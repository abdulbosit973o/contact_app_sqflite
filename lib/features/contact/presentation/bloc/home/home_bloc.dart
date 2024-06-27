import 'package:bloc/bloc.dart';

import '../../../../../core/constants/constant.dart';
import '../../../data/local/shared_pref.dart';
import '../../../data/local/sqflite/db_helper.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferencesHelper _pref;
  final MyDatabaseHelper _database;

  HomeBloc(this._pref, this._database) : super(HomeInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<DeleteContact>(_onDeleteContact);
    on<LogoutUser>(_onLogoutUser);
    on<UnregisterUser>(_onUnregisterUser);
  }

  void _onLoadContacts(LoadContacts event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final contacts = await _database.getAllContactData();
      emit(HomeLoaded(contacts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<HomeState> emit) async {
    try {
      _database.deleteContactData(event.contactId);
      add(LoadContacts());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) async {
    await _pref.setBool(Constants.isVerified, false);
    // Navigate to login screen
  }

  void _onUnregisterUser(UnregisterUser event, Emitter<HomeState> emit) async {
    await _pref.delete();
    // Navigate to login screen
  }
}
