import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/contact_data.dart';

class MyDatabaseHelper {
  static int version = 1;
  static String dbName = 'Example.db';

  Future<Database> _getDb() async {
    return await openDatabase(join(await getDatabasesPath(), dbName),
        version: version,
        singleInstance: true,
        onCreate: (db, version) async => db.execute(
            'CREATE TABLE ContactData (id INTEGER NOT NULL, name TEXT NOT NULL, phone TEXT NOT NULL, image TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))'));
  }

  Future<void> addContactData(ContactData contact) async {
    final db = await _getDb();
    db.insert('ContactData', contact.toJson());
  }

  Future<ContactData?> getContactData(int id) async {
    final db = await _getDb();
    final List<Map<String, dynamic>> map =
        await db.query('ContactData', where: 'id = ?', whereArgs: [id]);
    if (map.isNotEmpty) {
      return ContactData.fromJson(map.first);
    }
    return null;
  }

  void updateContactData(ContactData contact) async {
    final db = await _getDb();
    db.update('ContactData', contact.toJson(),
        where: 'id =?', whereArgs: [contact.id]);
  }

  void deleteContactData(int id) async {
    final db = await _getDb();
    db.delete('ContactData', where: 'id =?', whereArgs: [id]);
  }

  Future<List<ContactData>> getAllContactData() async {
    final db = await _getDb();
    final map = await db.query('ContactData');

    return List.generate(map.length, (index) => ContactData.fromJson(map[index]));
  }
}
