import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:google_fonts/google_fonts.dart';

// Addlogs is a form screen that lets users add a new Workout entry
class Addlogs extends StatefulWidget {
  final void Function(Workout)
  onAddWorkout; // Callback to pass workout to parent

  Addlogs({required this.onAddWorkout});
  @override
  State<Addlogs> createState() {
    return AddlogsState();
  }
}

class AddlogsState extends State<Addlogs> {
  // Controllers to capture input
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  Category defaultSelect = Category.Yoga; // Default category
  DateTime selectedDate = DateTime.now(); // Default date

  // Show validation error popup
  showDialog(BuildContext context, String message) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text("Invalid Input"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  // Save the workout
  save() {
    String duration = durationController.text.trim();

    // Basic validation
    if (titleController.text.isEmpty || duration.isEmpty) {
      showDialog(context, "Empty fields");
      return;
    }
    if (int.tryParse(duration) == null) {
      showDialog(context, "Invalid duration");
      return;
    }

    // Create workout object
    Workout workout = Workout(
      title: titleController.text,
      category: defaultSelect,
      date: selectedDate,
      duration: int.parse(duration),
    );

    // Trigger callback and close modal
    widget.onAddWorkout(workout);
    Navigator.pop(context);
  }

  // Cancel button logic
  cancel() {
    Navigator.pop(context);
  }

  // Open date picker and update selected date
  datepicker() async {
    DateTime firstDate = DateTime(2025, 1, 1);
    DateTime lastDate = DateTime(2025, 12, 31);

    final dateSelected = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    // If user selects a date, update the state
    setState(() {
      selectedDate = dateSelected!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          // Duration input and date picker
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: durationController,
                  decoration: InputDecoration(
                    labelText: 'Duration',
                    suffixText: 'mins',
                  ),
                ),
              ),
              SizedBox(width: 30),
              // Display selected date and icon to open picker
              Row(
                children: [
                  Text(
                    formatter.format(selectedDate), // Format date
                    style: GoogleFonts.poppins(),
                  ),
                  IconButton(
                    onPressed: datepicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          // Category dropdown and Save/Cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                value: defaultSelect,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name, style: GoogleFonts.poppins()),
                  );
                }).toList(),

                onChanged: (Category? newValue) {
                  setState(() {
                    defaultSelect = newValue!;
                  });
                },
              ),
              SizedBox(width: 20),

              // Save button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 255, 204),
                ),
                onPressed: save,
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),

              // Cancel button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 191, 186),
                ),
                onPressed: cancel,
                child: Text(
                  "Cancel",
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
