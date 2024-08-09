import '../../data/model/contact.dart';
// A class for managing contact events
abstract class ContactEvent {}

class InitEvent extends ContactEvent {}

class FetchAllContactEvent extends ContactEvent {}

class FetchFavoriteContactEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;

  AddContactEvent({required this.contact});
}

class UpdateContactEvent extends ContactEvent {
  final Contact contact;

  UpdateContactEvent({required this.contact});
}


class DeleteContactEvent extends ContactEvent {
  final int contactId;

  DeleteContactEvent({required this.contactId});
}
