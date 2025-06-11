// Home screen
// import relevant files, dependencies
import 'dart:convert';
import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:fitness_tracker_app/screens/BMIPage.dart';
import 'package:fitness_tracker_app/screens/ReportPage.dart';
import 'package:fitness_tracker_app/widgets/AddLogs.dart';
import 'package:fitness_tracker_app/widgets/WorkoutCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

// Stateful widget as dynamic list of logs
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  String allWorkoutKey =
      'allworkoutkey'; // Key for storing workouts in SharedPreferences

  // Sample default workouts (used before any saved data is loaded)
  List<Workout> logs = [
    Workout(
      title: "Jumping jacks",
      category: Category.Hiit,
      duration: 12,
      date: DateTime.now(),
    ),
    Workout(
      title: "Weight lifting",
      category: Category.Strength,
      duration: 12,
      date: DateTime.now(),
    ),
    Workout(
      title: "Meditate",
      category: Category.Yoga,
      duration: 12,
      date: DateTime.now(),
    ),
    Workout(
      title: "Push-ups",
      category: Category.Cardio,
      duration: 12,
      date: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadWorkout(); // Load workouts from SharedPreferences when app starts
  }

  // Load function
  void loadWorkout() async {
    final pref = await SharedPreferences.getInstance();

    List<String>? getData = pref.getStringList(allWorkoutKey);
    if (getData != null) {
      setState(() {
        logs = getData
            .map(
              (workoutJson) => Workout.fromJson(workoutJson),
            ) // Parse JSON strings to Workout objects
            .toList();
      });
    }
  }

  // Save current list of workouts to SharedPreferences
  void saveWorkout() async {
    final pref = await SharedPreferences.getInstance();
    List<String> workoutList = logs
        .map((workout) => json.encode(workout.toJson()))
        .toList();
    await pref.setStringList(allWorkoutKey, workoutList);
  }

  // Open bottom sheet to add a new workout
  add() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Addlogs(onAddWorkout: addWorkout),
    );
  }

  // Add new workout to the list and save it
  addWorkout(Workout workout) {
    setState(() {
      logs.add(workout);
    });
    saveWorkout();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Workout added!"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Remove a workout and allow undo via Snackbar
  removeWorkout(Workout workout) {
    setState(() {
      logs.remove(workout);
      saveWorkout();
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Workout removed!"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              logs.add(workout);
              saveWorkout();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        backgroundColor: Color(0xFF1E90FF),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom nav bar with Report and BMI buttons
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
                  MaterialPageRoute(
                    builder: (context) => Reportpage(allLogs: logs),
                  ),
                );
              },
              icon: Icon(Icons.assignment),
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

      // Main UI
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Card(
                  color: Color.fromARGB(255, 0, 0, 0),
                  elevation: 7,
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Hi there, \tWorkout Time',
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: add,
                              child: Text(
                                "Ready?",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  // fontFamily: 'Montserrat'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        "https://cdn.pixabay.com/photo/2025/02/20/21/33/ai-generated-9420601_1280.png",
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Workout list
            Container(
              height: MediaQuery.of(context).size.height - 256,

              child: Expanded(
                child: ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) => Container(
                    height: 80,
                    width: 340,
                    child: Workoutcard(
                      index: index,
                      allLogs: logs,
                      onRemoveWorkout: removeWorkout,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
