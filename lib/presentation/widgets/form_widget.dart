import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/contact.dart';
import '../../domain/blocs/contact_bloc.dart';
import '../../domain/blocs/contact_event.dart';
import '../../domain/blocs/contact_state.dart';
import '../../utils/validators.dart';
import 'profile_image_widget.dart';

class FormWidget extends StatefulWidget {
  final bool update;
  final Contact? contactToUpdate;
  final Function onAddUpdateDelete;

  FormWidget({
    super.key,
    required this.update,
    required this.contactToUpdate,
    required this.onAddUpdateDelete,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  String? imagePath;
  bool isFavorite = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController landLineController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.update && widget.contactToUpdate != null) {
      nameController.text = widget.contactToUpdate!.name;
      mobileController.text = widget.contactToUpdate!.mobile;
      landLineController.text = widget.contactToUpdate!.landLine ?? '';
      isFavorite = widget.contactToUpdate!.favorite;
      imagePath = widget.contactToUpdate!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        return _buildForm();
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          ProfileImageWidget(
            imageUrl: imagePath,
            onImageUpdate: (path) => {
              setState(() {
                imagePath = path;
              }),
            },
            imageUpdate: widget.update,
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter name',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: mobileController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )),
            validator: validatorPhoneNumber,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: landLineController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
                labelText: 'Landline',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )),
            validator: validateLandlineNumber,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Favorite', style: TextStyle(fontSize: 18.0)),
              ),
              BlocConsumer<ContactBloc, ContactState>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Not updated favorite')));
                    }
                  }, builder: (context, state) {
                return Switch(
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() {
                      isFavorite = value;
                    });
                    context.read<ContactBloc>().add(UpdateContactEvent(
                        contact: widget.contactToUpdate!
                            .copyWith(favorite: value)));
                  },
                );
              })
            ],
          ),
          const SizedBox(height: 30),
          widget.update
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _addUpdateContact();
                  }
                },
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteContact();
                },
                child: const Text('Delete'),
              ),
            ],
          )
              : ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _addUpdateContact();
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _addUpdateContact() {
    final newContact = Contact(
      id: widget.update ? widget.contactToUpdate!.id : null,
      name: nameController.text,
      mobile: mobileController.text,
      landLine: landLineController.text,
      favorite: isFavorite,
      imageUrl: imagePath,
    );
    widget.onAddUpdateDelete(newContact, widget.update ? 'update' : 'add');
  }

  void _deleteContact() {
    widget.onAddUpdateDelete(widget.contactToUpdate!, 'delete');
  }
}