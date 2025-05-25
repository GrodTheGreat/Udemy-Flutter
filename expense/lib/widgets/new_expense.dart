import 'dart:io';

import 'package:expense/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense(this.onAddExpense, {super.key});

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
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showTitleDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder:
            (ctx) => CupertinoAlertDialog(
              title: const Text("Invalid input"),
              content: const Text("Please make sure title is not empty"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Invalid input"),
              content: const Text("Please make sure title is not empty"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
      );
    }
  }

  void _submitExpenseData() {
    if (_titleController.text.trim().isEmpty) {
      _showTitleDialog();
      return;
    }
    // tryParse("Hello") => null
    var enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0.0;
    if (!amountIsValid) {
      //error
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Invalid input"),
              content: const Text(
                "Please make sure amount is a positive number",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
      );
      return;
    }
    if (_selectedDate == null) {
      // error
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Invalid input"),
              content: const Text("Please make sure to select a date."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Don't forget to destroy controllers when done!
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        print(constraints.minWidth);
        print(constraints.maxWidth);
        print(constraints.minHeight);
        print(constraints.maxHeight);

        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                16.0,
                16.0,
                keyboardSpace + 16.0,
              ),
              child: Column(
                children: [
                  if (width >= 600.0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            // One option for user input...
                            // onChanged: _saveTitleInput,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "\$ ",
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      // One option for user input...
                      // onChanged: _saveTitleInput,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text("Title")),
                    ),
                  if (width >= 600.0)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No date selected"
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "\$ ",
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "No date selected"
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16.0),
                  if (width >= 600.0)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
