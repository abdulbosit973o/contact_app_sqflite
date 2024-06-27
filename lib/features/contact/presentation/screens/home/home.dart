import 'package:contact_app_sqflite/features/contact/presentation/screens/home/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/theme/color/light_color.dart';
import '../../../data/local/shared_pref.dart';
import '../../../data/local/sqflite/db_helper.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../add/add_contact_screen.dart';
import '../edit/edit.dart';
import 'dialog/custom_delete_dialog.dart';
import 'dialog/custom_logot_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(SharedPreferencesHelper(), MyDatabaseHelper());
    _homeBloc.add(LoadContacts());
  }

  void _showDeleteDialog(int contactId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteDialog(
          onDelete: () {
            _homeBloc.add(DeleteContact(contactId));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomLogOutDialog(
          onLogout: () {
            _homeBloc.add(LogoutUser());
            Navigator.of(context).pop();
          },
          onUnregister: () {
            _homeBloc.add(UnregisterUser());
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Contacts',
              style: TextStyle(fontFamily: 'PaynetB')),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: LightColor.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Iconsax.logout, color: Colors.white),
                onPressed: () => _showLogoutDialog(),
              ),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return state.contacts.isEmpty
                  ? const Center(
                      child: Text('Empty',
                          style: TextStyle(fontFamily: 'PaynetB')))
                  : ListView.separated(
                      itemCount: state.contacts.length,
                      itemBuilder: (context, index) => ContactItem(
                        contact: state.contacts[index],
                        onCardClick: () {
                          _showDeleteDialog(state.contacts[index].id ?? 0);
                        },
                        onItemClick: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContactScreen(
                                contactData: state.contacts[index],
                              ),
                            ),
                          );
                          if (result == true) {
                            _homeBloc.add(LoadContacts());
                          }
                        },
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                        );
                      },
                    );
            } else if (state is HomeError) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(fontFamily: 'PaynetB')));
            } else {
              return const Center(
                  child: Text('Something went wrong',
                      style: TextStyle(fontFamily: 'PaynetB')));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: LightColor.mainColor,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContactScreen()),
            );
            if (result == true) {
              _homeBloc.add(LoadContacts());
            }
          },
          child: const Icon(Iconsax.add, color: Colors.white),
        ),
      ),
    );
  }
}
