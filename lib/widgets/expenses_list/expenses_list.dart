import 'package:flutter/material.dart';
import 'package:expense_track/models/expense.dart';
import 'package:expense_track/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length, 
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]), 
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of( context).cardTheme.margin?.horizontal ?? 16,
              vertical: Theme.of( context).cardTheme.margin?.vertical ?? 4,
            ),
          ),
          onDismissed: (direction){
            onRemoveExpense(expenses[index]);
          },
          child:  ExpensesItem(expenses[index])),
      );
  }
}