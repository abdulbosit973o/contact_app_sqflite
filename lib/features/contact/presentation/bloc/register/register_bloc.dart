import 'package:bloc/bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../../../data/local/shared_pref.dart';
import '../../../../../core/constants/constant.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SharedPreferencesHelper _pref;

  RegisterBloc(this._pref) : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      if (event.password != event.confirmPassword) {
        emit(const RegisterFailure("Passwords are not the same"));
        return;
      }
      emit(RegisterLoading());
      await Future.delayed(const Duration(seconds: 1));

      _pref.delete();
      _pref.setString(Constants.username, event.username);
      _pref.setString(Constants.password, event.password);
      _pref.setBool(Constants.isVerified, true);

      emit(RegisterSuccess());
    });
  }
}
