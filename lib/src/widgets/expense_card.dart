import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  Color convertToColor(String name) {
    final numbers = name.codeUnits;
    final sum = numbers.reduce((a, b) => a + b);

    final remainder = sum % Colors.accents.length;

    final color = Colors.accents[remainder];

    return color;
  }

  @override
  Widget build(BuildContext context) {
    assert(expense.title != null);
    assert(expense.amount != null);
    assert(expense.people != null);

    final title = expense.title as String;
    final amount = '\$${(expense.amount as double).toStringAsFixed(2)}';
    final people = expense.people as List<String>;
    people.sort();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(title),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(amount),
              ),
            ),
            Expanded(
              child: Wrap(
                children: <Widget>[
                  for (final person in people)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: convertToColor(person),
                        ),
                        label: Text(person),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
