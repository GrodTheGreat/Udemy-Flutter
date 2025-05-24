import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // One option for user input...
  // var _enteredTitle = "";
  //
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  // The preferred method...
  final _titleController =
      TextEditingController(); // Controllers must be deleted when done!!!

  @override
  void dispose() {
    // Don't forget to destroy controllers when done!
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // One option for user input...
            // onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                },
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
