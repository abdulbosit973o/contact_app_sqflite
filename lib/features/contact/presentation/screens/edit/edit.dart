import 'package:contact_app_sqflite/config/theme/color/light_color.dart';
import 'package:contact_app_sqflite/config/theme/images/app_imiage.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_button.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_text_field.dart';
import 'package:contact_app_sqflite/features/contact/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/sqflite/db_helper.dart';
import '../../../data/model/contact_data.dart';
import '../../bloc/edit/edit_bloc.dart';

class EditContactScreen extends StatefulWidget {
  final ContactData contactData;

  const EditContactScreen(
      {super.key, required this.contactData});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  _EditContactScreenState();

  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    textController1.text = widget.contactData.name;
    textController2.text = widget.contactData.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBloc(MyDatabaseHelper()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Contact',
              style: TextStyle(fontFamily: 'PaynetB')),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: LightColor.white,
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
                        image: AssetImage('assets/images/edit_image.png'),
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
                  BlocConsumer<EditBloc, EditState>(
                    listener: (context, state) {
                      if (state is EditSuccess) {
                        CustomToast.show('Edited successfully',
                            backgroundColor: LightColor.green);
                        Navigator.pop(context, true);
                      }
                      if (state is EditFailure) {
                        CustomToast.show(state.message,
                            backgroundColor: LightColor.red);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is EditLoading)
                            const CircularProgressIndicator(),
                          CustomButton(
                              onPressed: () {
                                final contact = ContactData(
                                  id: widget.contactData.id,
                                  name: textController1.text,
                                  phone: textController2.text,
                                  image: AppImage.avatar,
                                );
                                context
                                    .read<EditBloc>()
                                    .add(EditContact(contactData: contact));
                              },
                              text: 'Edit Contact')
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
