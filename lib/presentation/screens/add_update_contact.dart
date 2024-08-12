import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/data/model/contact.dart';
import 'package:contact_app/domain/blocs/contact_bloc.dart';
import 'package:contact_app/domain/blocs/contact_event.dart';
import 'package:contact_app/domain/blocs/contact_state.dart';
import 'package:contact_app/presentation/widgets/form_widget.dart';

// A class for creating UI for AddUpdateContactScreen
class AddUpdateContactScreen extends StatelessWidget {
  final bool update;
  final Contact? contactToUpdate;

  const AddUpdateContactScreen({
    super.key,
    required this.update,
    this.contactToUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(update ? 'Update Contact' : 'Add Contact')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (BuildContext context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: FormWidget(
              update: update,
              contactToUpdate: contactToUpdate,
              onAddUpdateDelete: (contactToUpdate, operation) {
                _performOperationsOnContact(context, contactToUpdate, operation);
              },
            ),
          );
        },
      ),
    );
  }

  void _performOperationsOnContact(BuildContext context, contactToUpdate, operation) {
    if (operation == 'update') {
      context.read<ContactBloc>().add(UpdateContactEvent(contact: contactToUpdate));
    } else if (operation == 'delete') {
      context.read<ContactBloc>().add(DeleteContactEvent(contactId: contactToUpdate!.id!));
    } else {
      context.read<ContactBloc>().add(AddContactEvent(contact: contactToUpdate));
    }
    Navigator.pop(context);
  }
}
