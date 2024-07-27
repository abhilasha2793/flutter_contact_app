import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/model/contact.dart';
import '../screens/add_update_contact.dart';

/// A stateless widget to render ContactListItem.
class ContactListItem extends StatelessWidget {
  final Contact contactItem;
  final Function onUpdate;

  const ContactListItem(
      {super.key, required this.contactItem, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: InkWell(
          onTap: () => _navigateToAddUpdateScreen(context),
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                title: Text(contactItem.name),
                subtitle: Text(contactItem.mobile),
                leading: CircleAvatar(
                  backgroundImage: _getImageProvider(),
                  child: _getImageProvider() == null
                      ? Text(
                          _getInitials(contactItem.name),
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                ),
                trailing: contactItem.favorite ?Icon(Icons.star,
                    color: contactItem.favorite ? Colors.red : Colors.grey):null,
              ))),
    );
  }

  ImageProvider<Object>? _getImageProvider() {
    print('Contact is : ${contactItem.imageUrl}');
    if (contactItem.imageUrl == null) {
      return null;
    } else if (Uri.parse(contactItem.imageUrl!).isAbsolute) {
      return NetworkImage(contactItem.imageUrl!);
    } else if (File(contactItem.imageUrl!).existsSync()) {
      return FileImage(File(contactItem.imageUrl!));
    } else {
      return null;
    }
  }

  String _getInitials(String name) {
    final nameSplit = name.split(' ');
    return nameSplit.length > 1
        ? '${nameSplit[0][0]}${nameSplit[1][0]}'
        : nameSplit[0][0];
  }

  Future<void> _navigateToAddUpdateScreen(BuildContext context) async {
    var result = Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddUpdateContactScreen(
                update: true,
                contactToUpdate: contactItem,
              )),
    );
    if (result != null) {
      onUpdate();
    }
  }
}
