// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:expense_tracker/data.dart';
import 'package:expense_tracker/list.dart';
import 'package:expense_tracker/model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter",
      amount: 12,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Bus",
      amount: 12,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Data(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 190, 243, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 190, 243, 250),
        title: Text("Expense_Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpenseList(
              expenses: _registeredExpenses,
            ),
          )
        ],
      ),
    );
  }
}
