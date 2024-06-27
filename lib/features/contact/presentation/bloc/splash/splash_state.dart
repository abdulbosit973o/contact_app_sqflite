import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashScreenState {}

class SplashLoading extends SplashScreenState {}

class SplashAuthenticated extends SplashScreenState {}

class SplashUnauthenticated extends SplashScreenState {}
