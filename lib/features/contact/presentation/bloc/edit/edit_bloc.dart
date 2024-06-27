import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/local/sqflite/db_helper.dart';
import '../../../data/model/contact_data.dart';

part 'edit_event.dart';

part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final MyDatabaseHelper _database;

  EditBloc(this._database) : super(EditInitial()) {
    on<EditContact>((event, emit) {
      emit(EditLoading());
      _database.updateContactData(event.contactData);
      emit(EditSuccess());
    });
  }
}
