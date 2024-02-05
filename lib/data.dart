// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_final_fields, unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/model.dart';

final formatter = DateFormat.yMd();

class Data extends StatefulWidget {
  const Data({super.key, required this.onAddExp});

  final void Function(Expense expense) onAddExp;
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  var _title = '';
  void _inputValue(String value) {
    value = _title;
  }

  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  DateTime? _selectDate;
  Category _cat = Category.travel;
  void _datepick() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );

    final date = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectDate = date;
    });
  }

  void submit() {
    final amt = double.tryParse(_amtController.text);
    final amtinvalid = amt == null || amt <= 0;
    if (_titleController.text.trim().isEmpty ||
        amtinvalid ||
        _selectDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid"),
          content: Text("Enter crt Details"),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExp(
      Expense(
          title: _titleController.text,
          amount: amt,
          date: _selectDate!,
          category: _cat),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amtController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("amount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectDate!),
                    ),
                    IconButton(
                      onPressed: _datepick,
                      icon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _cat,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _cat = value;
                    });
                  }),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: submit,
                child: Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
