import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String username;
  final String password;
  final String confirmPassword;

  const RegisterUser(this.username, this.password, this.confirmPassword);

  @override
  List<Object> get props => [username, password, confirmPassword];
}
