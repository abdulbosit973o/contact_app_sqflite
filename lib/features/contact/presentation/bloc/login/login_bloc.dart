import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../data/local/shared_pref.dart';
import '../../../../../core/constants/constant.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SharedPreferencesHelper _pref;

  LoginBloc(this._pref) : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
  }

  void _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final username = _pref.getString(Constants.username);
      final password = _pref.getString(Constants.password);

      if (username == event.username && password == event.password) {
        _pref.setBool(Constants.isVerified, true);
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure("User data not same"));
      }
    } catch (error) {
      emit(const LoginFailure("An error occurred"));
    }
  }
}
