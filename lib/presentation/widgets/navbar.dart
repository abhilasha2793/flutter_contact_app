import 'package:contact_app/presentation/screens/contact_list.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_drawer_header.dart';
import '../screens/add_update_contact.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const NavDrawerHeader(title: 'Contact App'),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Contact List Screen',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactListScreen(
                            title: 'Contact List',
                            favorite: false,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add new contact',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddUpdateContactScreen(
                            update: false,
                            contactToUpdate: null,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Favorite contacts',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactListScreen(
                            title: 'Favorite contacts',
                            favorite: true,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
