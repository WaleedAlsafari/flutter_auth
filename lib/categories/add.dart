import 'package:flutter/material.dart';
import 'package:flutter_auth/components/CustomButton.dart';
import 'package:flutter_auth/components/CustomTextFormField.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _nameController = TextEditingController();

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  GlobalKey<FormState> formState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Form(
          key: formState,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                    hintText: 'Enter name',
                    controller: _nameController,
                    validator: _validateInput),
                SizedBox(
                  height: 30,
                ),
                CustomMaterialButton(
                  title: 'Add',
                  onPressed: () {},
                )
              ],
            ),
          )),
    );
  }
}
