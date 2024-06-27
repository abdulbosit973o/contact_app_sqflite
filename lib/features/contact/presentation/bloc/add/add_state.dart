part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddSuccess extends AddState {}

class AddFailure extends AddState {
  final String message;

  AddFailure({required this.message});
}
