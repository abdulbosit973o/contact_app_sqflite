import 'package:bloc/bloc.dart';
import 'package:contact_app_sqflite/features/contact/data/model/contact_data.dart';
import 'package:meta/meta.dart';

import '../../../data/local/sqflite/db_helper.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final MyDatabaseHelper _database;
  AddBloc(this._database) : super(AddInitial()) {
    on<AddContact>((event, emit) {
      _addContact(event.contactData);
      emit(AddSuccess());
    });

  }

  void _addContact(ContactData contactData)async {
    await _database.addContactData(contactData);
  }
}
