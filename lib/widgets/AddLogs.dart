import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/model/Workout.dart';
import 'package:google_fonts/google_fonts.dart';

class Addlogs extends StatefulWidget {
  final void Function(Workout) onAddWorkout;

  Addlogs({required this.onAddWorkout});
  @override
  State<Addlogs> createState() {
    return AddlogsState();
  }
}

class AddlogsState extends State<Addlogs> {
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  Category defaultSelect = Category.Yoga;
  DateTime selectedDate = DateTime.now();

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

  save() {
    String duration = durationController.text.trim();
    if (titleController.text.isEmpty || duration.isEmpty) {
      showDialog(context, "Empty fields");
      return;
    }
    if (int.tryParse(duration) == null) {
      showDialog(context, "Invalid duration");
      return;
    }

    Workout workout = Workout(
      title: titleController.text,
      category: defaultSelect,
      date: selectedDate,
      duration: int.parse(duration),
    );

    widget.onAddWorkout(workout);
    Navigator.pop(context);
  }

  cancel() {
    Navigator.pop(context);
  }

  datepicker() async {
    DateTime firstDate = DateTime(2025, 1, 1);
    DateTime lastDate = DateTime(2025, 12, 31);

    final dateSelected = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

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

              Row(
                children: [
                  Text(
                    formatter.format(selectedDate),
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
