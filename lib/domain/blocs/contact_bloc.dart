import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../data/DatabaseHelper.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final DatabaseHelper dbHelper;

  ContactBloc({required this.dbHelper}) : super(InitialState()) {
    on<FetchAllContactEvent>(_onFetchAllContact);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<UpdateProfileImageEvent>(_onUpdateProfileImage);
    on<TemporaryProfileImageEvent>(_onTemporaryProfileImage);
    on<ToggleFavoriteContactEvent>(_onToggleFavoriteContact);
  }

  Future<void> _onFetchAllContact(FetchAllContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      final contacts = await dbHelper.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onAddContact(AddContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await dbHelper.insertContact(event.contact);
      final contacts = await dbHelper.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onUpdateContact(UpdateContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await dbHelper.updateContact(event.contact);
      final contacts = await dbHelper.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteContact(DeleteContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await dbHelper.deleteContact(event.contactId);
      final contacts = await dbHelper.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  FutureOr<void> _onUpdateProfileImage(UpdateProfileImageEvent event, Emitter<ContactState> emit) async {
    try {
      final updatedContact = event.contact.copyWith(imageUrl: event.imagePath);
      await dbHelper.updateContact(updatedContact);
      add(FetchAllContactEvent());
    } catch (error) {
      emit(ErrorState('Failed to update profile image'));
    }
  }

  Future<void> _onTemporaryProfileImage(TemporaryProfileImageEvent event, Emitter<ContactState> emit) async {
    emit(ProfileImageUpdatedState(event.imagePath));
  }

  Future<void> _onToggleFavoriteContact(ToggleFavoriteContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      final updatedContact = event.contact.copyWith(favorite: !event.contact.favorite);
      await dbHelper.updateContact(updatedContact);
      add(FetchAllContactEvent());
    } catch (error) {
      emit(ErrorState('Failed to update favorite status'));
    }
  }
}