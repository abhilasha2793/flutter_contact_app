import 'package:flutter/material.dart';
import 'package:contact_app/presentation/screens/contact_list.dart';
import 'package:contact_app/presentation/screens/add_update_contact.dart';

/// A class for defining routes in the app
class AppRoutes {
  static const String contactList = '/contactList';
  static const String addUpdateContact = '/addUpdateContact';
  static const String favoriteContactsList = '/favoriteContactsList';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case contactList:
        return MaterialPageRoute(builder: (_) => const ContactListScreen(title: 'Contact List', favorite: false));
      case addUpdateContact:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AddUpdateContactScreen(
            update: args['update'],
            contactToUpdate: args['contactToUpdate'],
          ),
        );
        case favoriteContactsList:
          return MaterialPageRoute(builder: (_) => const ContactListScreen(title: 'Favorite contacts', favorite: true));
      default:
        return MaterialPageRoute(builder: (_) => const ContactListScreen(title: 'Contact List', favorite: false));
    }
  }
}