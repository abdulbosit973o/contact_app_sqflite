part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}
class EditLoading extends EditState {}

class EditSuccess extends EditState {}

class EditFailure extends EditState {
  final String message;

  EditFailure({required this.message});
}