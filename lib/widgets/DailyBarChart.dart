import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// A stateless widget to show today's workouts per category in a bar chart
class Dailybarchart extends StatelessWidget {
  final List<Workout> allLogs;

  Dailybarchart({required this.allLogs});

  // Returns the count of workouts per category done today
  Map<Category, int> getTodayTotals() {
    Map<Category, int> totals = {
      Category.Cardio: 0,
      Category.Hiit: 0,
      Category.Strength: 0,
      Category.Yoga: 0,
    };

    String today = formatter.format(DateTime.now());

    for (var workout in allLogs) {
      if (formatter.format(workout.date) == today) {
        totals[workout.category] = totals[workout.category]! + 1;
      }
    }

    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = getTodayTotals(); // Map<Category, int>
    final List<BarChartGroupData> barGroups = [];
    int i = 0;
    categoryTotals.forEach((category, total) {
      // Create a bar group for each category
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: total.toDouble(),
              color: Workout.getLightColor(category), // bar color
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
          barGroups: barGroups, // actual bar data
        ),
      ),
    );
  }
}
