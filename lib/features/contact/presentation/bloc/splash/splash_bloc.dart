import 'package:bloc/bloc.dart';
import 'package:contact_app_sqflite/features/contact/presentation/bloc/splash/splash_event.dart';
import 'package:contact_app_sqflite/features/contact/presentation/bloc/splash/splash_state.dart';
import '../../../data/local/shared_pref.dart';
import '../../../../../core/constants/constant.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SharedPreferencesHelper _pref;

  SplashScreenBloc(this._pref) : super(SplashInitial()) {
    on<CheckVerificationStatus>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 1));
      var bool = _pref.getBool(Constants.isVerified);
      if (bool == null || !bool) {
        emit(SplashUnauthenticated());
      } else {
        emit(SplashAuthenticated());
      }
    });
  }
}
