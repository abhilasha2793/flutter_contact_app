import '../DatabaseHelper.dart';
import '../model/contact.dart';

// A class for managing contact data
class ContactRepository {
  final DatabaseHelper _databaseHelper;

  ContactRepository(this._databaseHelper);

  Future<List<Contact>> getContacts({bool favorite = false}) async {
    return await _databaseHelper.getContacts(favorite: favorite);
  }

  Future<int> insertContact(Contact contact) async {
    return await _databaseHelper.insertContact(contact);
  }

  Future<void> updateContact(Contact contact) async {
    await _databaseHelper.updateContact(contact);
  }

  Future<void> deleteContact(int contactId) async {
    await _databaseHelper.deleteContact(contactId);
  }
}