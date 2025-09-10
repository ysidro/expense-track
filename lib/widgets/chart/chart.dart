import 'package:flutter/material.dart';

import 'package:expense_track/widgets/chart/chart_bart.dart';
import 'package:expense_track/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart ({super.key, required this.expenses});

final List<Expense> expenses;

List<ExpenseBucket> get buckets{
  return [
    ExpenseBucket.forCategory(expenses, Category.food),
    ExpenseBucket.forCategory(expenses, Category.leisure),
    ExpenseBucket.forCategory(expenses, Category.travel),
    ExpenseBucket.forCategory(expenses, Category.work),
  ];
}

double get maxTotalExpenses{
  double maxTotalExpenses = 0.0;
  for(final bucket in buckets){
    if(bucket.totalExpenses > maxTotalExpenses){
      maxTotalExpenses = bucket.totalExpenses;
    }
  }
  return maxTotalExpenses;
}

@override
  Widget build(BuildContext context) {
    
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical:16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(8),
        gradient: LinearGradient(
          colors:[
            Theme.of(context).colorScheme.primary.withValues(alpha:0.3),
            Theme.of(context).colorScheme.primary.withValues(alpha:0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(child: 
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for(final bucket in buckets)
                ChartBart(
                  fill: maxTotalExpenses == 0.0 ? 0.0 : bucket.totalExpenses / maxTotalExpenses,

                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map(
              (bucket) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color: isDarkMode ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary.withValues(alpha:0.7),
                  ),
                ),
              )
            ).toList(),
          ),
        ],
      )
    );

  }

}