import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {required this.controller, required this.onSave, required this.onCancel});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.blueGrey),
          decoration: InputDecoration(
              labelText: 'Add a new task',
              labelStyle: TextStyle(color: Colors.blueGrey),
              border: _border,
              focusedBorder: _border,
              enabledBorder: _border),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your task';
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    onSave();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ],
    );
  }
}

var _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.blueGrey, width: 2) // Rounded corners
    );
