import '../../data/model/contact.dart';

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

class ToggleFavoriteContactEvent extends ContactEvent {
  final Contact contact;

  ToggleFavoriteContactEvent(this.contact);
}

class UpdateProfileImageEvent extends ContactEvent {
  final Contact contact;
  final String imagePath;

  UpdateProfileImageEvent(this.contact, this.imagePath);
}

class TemporaryProfileImageEvent extends ContactEvent {
  final String imagePath;
  TemporaryProfileImageEvent(this.imagePath);
}

class DeleteContactEvent extends ContactEvent {
  final int contactId;

  DeleteContactEvent({required this.contactId});
}
