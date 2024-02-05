import 'package:expense_tracker/item.dart';
import 'package:expense_tracker/model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.removeExp,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) removeExp;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          removeExp(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: Item(expenses[index]),
      ),
    );
  }
}
