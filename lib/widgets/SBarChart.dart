import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

 // Calculate total number of workouts per category
class Sbarchart extends StatelessWidget {
  final List<Workout> allLogs;
  Sbarchart({required this.allLogs});

  Map<Category, int> getTotals() {
    Map<Category, int> totals = {
      Category.Cardio: 0,
      Category.Hiit: 0,
      Category.Strength: 0,
      Category.Yoga: 0,
    };
    for (var workout in allLogs) {
      totals[workout.category] = totals[workout.category]! + 1;
    }

    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = getTotals();
    final List<BarChartGroupData> barGroups = [];
    int i = 0;

    categoryTotals.forEach((category, total) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: total.toDouble(),// height based on total
              color: Workout.getColor(category),// color based on category
              width: 20,
            ),
          ],
        ),

      );
      i++;
    });
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const labels = ['Cardio', 'Hiit', 'Strength', 'Yoga'];
                  return Text(labels[value.toInt()]);
                },
              ),
            ),
          ),
          barGroups: barGroups
        ),
      ),
    );
  }
}
