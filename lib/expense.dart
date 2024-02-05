// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types

import 'package:expense_tracker/chart.dart';
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
      title: "Food",
      amount: 10,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      shape: BeveledRectangleBorder(),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Data(
        onAddExp: _addExp,
      ),
    );
  }

  void _addExp(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExp(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(
          seconds: 3,
        ),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget main = Center(
      child: Text("Add some Expenses"),
    );
    if (_registeredExpenses.isNotEmpty) {
      main = ExpenseList(
        removeExp: _removeExp,
        expenses: _registeredExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
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
          Chart(expenses: _registeredExpenses),
          Expanded(child: main),
        ],
      ),
    );
  }
}
