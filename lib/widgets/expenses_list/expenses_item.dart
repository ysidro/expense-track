import 'package:expense_track/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget{
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        
        child: 
        Padding(
            padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:  Text(expense.title, style: Theme.of(context).textTheme.titleLarge ),
              ),
              const SizedBox(height:4),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}', style:Theme.of(context).textTheme.titleMedium ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 5) ,
                      Text(expense.formattedDate, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  )
                ],
              )
            ],
          )
        ),
      );
  }
}