part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}
class EditContact extends EditEvent {
  final ContactData contactData;

  EditContact({required this.contactData});
}
