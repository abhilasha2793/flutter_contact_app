import '../../data/model/contact.dart';

sealed class ContactState {}

class InitialState extends ContactState {}

class LoadingState extends ContactState {}

class ErrorState extends ContactState {
  final String message;

  ErrorState(this.message);
}

class SuccessState extends ContactState {
  final List<Contact> contacts;
  SuccessState(this.contacts);
}

class ProfileImageUpdatedState extends ContactState {
  final String imagePath;
  ProfileImageUpdatedState(this.imagePath);
}

