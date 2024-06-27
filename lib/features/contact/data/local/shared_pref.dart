import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_data.dart';
import '../../../../core/constants/constant.dart';

class SharedPreferencesHelper {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> addContact(ContactData contact) async {
    final contacts = await loadContacts();
    contacts.add(contact);
    final updatedContactsJSON = jsonEncode(contacts.map((c) => c.toJson()).toList());
    await _prefs.setString(Constants.contacts, updatedContactsJSON);
  }

  Future<List<ContactData>> loadContacts() async {
    final contactsJSON = _prefs.getString(Constants.contacts) ?? "[]";
    try {
      final decodedContacts = jsonDecode(contactsJSON) as List<dynamic>;
      return decodedContacts.map((contact) => ContactData.fromJson(contact)).toList();
    } catch (e) {
      return []; // Return empty list on parsing error
    }
  }

  Future<void> deleteContactAtIndex(int index) async {
    final contacts = await loadContacts();
    if (index >= 0 && index < contacts.length) {
      contacts.removeAt(index);
      final updatedContactsJSON = jsonEncode(contacts.map((c) => c.toJson()).toList());
      await _prefs.setString(Constants.contacts, updatedContactsJSON);
    }
  }

  Future<void> updateContactAtIndex(int index, ContactData updatedContact) async {
    final contacts = await loadContacts();
    if (index >= 0 && index < contacts.length) {
      contacts[index] = updatedContact;
      final updatedContactsJSON = jsonEncode(contacts.map((c) => c.toJson()).toList());
      await _prefs.setString(Constants.contacts, updatedContactsJSON);
    }
  }
  Future<void> setString(String key, String value) async {
    _prefs.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    _prefs.setBool(key, value);
  }

// Get a string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> delete() {
    return _prefs.clear();
  }

// Other methods remain the same...
}
