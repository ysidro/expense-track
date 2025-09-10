import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();
enum Category { food, travel, leisure, work }

const categoryIcons = {

  Category.food : Icons.food_bank_outlined,
  Category.travel : Icons.flight_takeoff_outlined,
  Category.leisure : Icons.movie_outlined,
  Category.work : Icons.work_outline

};

class Expense {

  Expense(
    
    {
      required this.title, 
      required this.amount, 
      required this.date,
      required this.category
    }

  ) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate{
    return formatter.format(date);
  }

}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0.0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}