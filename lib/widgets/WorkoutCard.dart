import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Workoutcard extends StatelessWidget {
  final List<Workout> allLogs;
  final index;
  final void Function(Workout) onRemoveWorkout;
  Workoutcard({required this.index, required this.allLogs, required this.onRemoveWorkout});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(allLogs[index]),
      background: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(144, 255, 0, 25),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onDismissed: (direction)=>onRemoveWorkout(allLogs[index]),
      child: Card(
        // elevation: 10,
        color:Color.fromARGB(255, 216, 216, 216),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.all(10),

              decoration: BoxDecoration(
                color:Workout.getColor(allLogs[index].category),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Icon(allLogs[index].getCategoryIcon(), color: Colors.white),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      allLogs[index].title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 20,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:Color.fromARGB(255, 0, 0, 0),

                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        allLogs[index].duration.toString() + " mins",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 20,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:Color.fromARGB(255, 0, 0, 0),

                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        allLogs[index].category.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),

                    Container(
                      height: 20,
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:Color.fromARGB(255, 0, 0, 0),

                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        allLogs[index].getFormattedDate().toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
