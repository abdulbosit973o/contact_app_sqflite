import 'package:contact_app_sqflite/config/theme/images/app_imiage.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_button.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_text_field.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/sqflite/db_helper.dart';
import '../../../data/model/contact_data.dart';
import '../../bloc/add/add_bloc.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBloc(MyDatabaseHelper()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact',
              style: TextStyle(fontFamily: 'PaynetB')),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImage.addImage),
                      ),
                    ),
                    width: 188,
                    height: 174,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                          controller: textController1,
                          hintText: 'Name',
                          isPassword: false),
                      const SizedBox(height: 16),
                      CustomTextField(
                          controller: textController2,
                          hintText: 'Phone',
                          isPassword: false),
                    ],
                  ),
                  BlocConsumer<AddBloc, AddState>(
                    listener: (context, state) {
                      if (state is AddSuccess) {
                        CustomToast.show("Added successfully");
                        Navigator.pop(context, true);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomButton(
                              onPressed: () {
                                final contact = ContactData(
                                  name: textController1.text,
                                  phone: textController2.text,
                                  image: AppImage.avatar,
                                );
                                context
                                    .read<AddBloc>()
                                    .add(AddContact(contactData: contact));
                              },
                              text: 'Add contact')
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
