import 'package:contact_app/presentation/screens/contact_list.dart';
import 'package:flutter/material.dart';
import '../../routes/AppRoutes.dart';
import '../widgets/nav_drawer_header.dart';
import '../screens/add_update_contact.dart';

//A class for adding a navigation drawer to the app
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
              Navigator.pushReplacementNamed(context, AppRoutes.contactList);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add new contact',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.addUpdateContact,
                  arguments: {'update': false, 'contactToUpdate': null});
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Favorite contacts',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.favoriteContactsList);
            },
          ),
        ],
      ),
    );
  }
}
