import 'package:equatable/equatable.dart';
import '../../../data/model/contact_data.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ContactData> contacts;

  const HomeLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
