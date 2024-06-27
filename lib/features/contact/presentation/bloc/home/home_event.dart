import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends HomeEvent {}

class DeleteContact extends HomeEvent {
  final int contactId;

  const DeleteContact(this.contactId);

  @override
  List<Object?> get props => [contactId];
}

class LogoutUser extends HomeEvent {}

class UnregisterUser extends HomeEvent {}
