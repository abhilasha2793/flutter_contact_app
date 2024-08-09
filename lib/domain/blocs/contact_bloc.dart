import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../data/DatabaseHelper.dart';
import '../../data/repository/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

// A class for managing contact data
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc({required this.contactRepository}) : super(InitialState()) {
    on<FetchAllContactEvent>(_onFetchAllContact);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
  }

  Future<void> _onFetchAllContact(FetchAllContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      final contacts = await contactRepository.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onAddContact(AddContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await contactRepository.insertContact(event.contact);
      final contacts = await contactRepository.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onUpdateContact(UpdateContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await contactRepository.updateContact(event.contact);
      final contacts = await contactRepository.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteContact(DeleteContactEvent event, Emitter<ContactState> emit) async {
    emit(LoadingState());
    try {
      await contactRepository.deleteContact(event.contactId);
      final contacts = await contactRepository.getContacts();
      emit(SuccessState(contacts));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

}