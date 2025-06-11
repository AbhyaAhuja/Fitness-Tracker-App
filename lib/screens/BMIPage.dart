import 'package:fitness_tracker_app/screens/HomePage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bmipage extends StatefulWidget {
  @override
  State<Bmipage> createState() => _BmipageState();
}

class _BmipageState extends State<Bmipage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double weight = 0;
  double height = 0;
  double bmi = 0;
  bool isCal = false;
  updatebmi() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Invalid Input"),
            content: Text("Fill all fields"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    if (double.tryParse(heightController.text) == null ||
        double.tryParse(weightController.text) == null) {
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Invalid Input"),
            content: Text("Enter numeric values only"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      double heightM = double.parse(heightController.text) / 100;
      double weight = double.parse(weightController.text);
      bmi = weight / (heightM * heightM);
      isCal = true;
    });
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi >= 18.5 && bmi <= 24.9) return "Normal";
    if (bmi >= 25 && bmi <= 29.9) return "Overweight";
    return "Obese";
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        value: bmi < 18.5 ? 1 : 0,
        title: "Underweight",
        color: Colors.blue,
      ),
      PieChartSectionData(
        value: (bmi >= 18.5 && bmi <= 24.9) ? 1 : 0,
        title: "Normal",
        color: Colors.green,
      ),
      PieChartSectionData(
        value: (bmi >= 25 && bmi <= 29.9) ? 1 : 0,
        title: "Overweight",
        color: Colors.yellow,
      ),
      PieChartSectionData(
        value: bmi >= 30 ? 1 : 0,
        title: "Obese",
        color: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: Text(
          'BMI Calculator',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
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
                Navigator.pop(context);
              },
              icon: Icon(Icons.assignment),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 8,
            color: const Color.fromARGB(255, 41, 41, 41),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    style: GoogleFonts.poppins(color: Colors.white),

                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Enter your Weight',
                      suffixText: 'kg',
                    ),
                  ),

                  TextField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: 'Enter your height',
                      suffixText: 'cm',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updatebmi,
                    child: Text(
                      'Calculate',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40),

          if (isCal)
            Card(
              elevation: 8,
              color: const Color.fromARGB(255, 255, 230, 249),
              child: Column(
                children: [
                  Text(
                    "BMI: ${bmi.toStringAsFixed(1)} (${getBMICategory(bmi)})",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: getSections(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
