// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/model.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item(
    this.expense, {
    super.key,
  });
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("\$${expense.amount.toStringAsFixed(2)}"),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    SizedBox(
                      width: 5,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
