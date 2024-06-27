part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}

class AddContact extends AddEvent {
  final ContactData contactData;

  AddContact({required this.contactData});
}
