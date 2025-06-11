import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:fitness_tracker_app/screens/BMIPage.dart';
import 'package:fitness_tracker_app/screens/HomePage.dart';
import 'package:fitness_tracker_app/widgets/DailyBarChart.dart';
import 'package:fitness_tracker_app/widgets/SBarChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reportpage extends StatelessWidget {
  final List<Workout> allLogs;
  Reportpage({required this.allLogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Report',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              icon: Icon(Icons.home),
            ),
            SizedBox(width: 200),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bmipage()),
                );
              },
              icon: Icon(Icons.health_and_safety),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Total Workouts per Category",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Sbarchart(allLogs: allLogs),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Daily Report",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Dailybarchart(allLogs: allLogs),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
