//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

// Workout types
enum Category { Yoga, Cardio, Strength, Hiit }

final uuid = Uuid(); // Generates unique ID for each workout
final formatter = DateFormat().add_yMd(); // Date formatter

class Workout {
  final String id;
  final String title;
  final int duration;
  final DateTime date;
  final Category category;

  // Constructor with auto-generated ID
  Workout({
    required this.title,
    required this.category,
    required this.date,
    required this.duration,
  }) : id = uuid.v4();

  // Format date as MM/DD/YYYY
  String getFormattedDate() {
    return formatter.format(date);
  }

  // Get icon based on workout category
  getCategoryIcon() {
    if (category == Category.Cardio) {
      return Icons.directions_run;
    } else if (category == Category.Yoga) {
      return Icons.self_improvement;
    } else if (category == Category.Hiit) {
      return Icons.flash_on;
    } else {
      return Icons.fitness_center;
    }
  }

  // Get primary color based on category
  static getColor(Category category) {
    if (category == Category.Cardio) {
      return Color(0xFFCF0F47);
    } else if (category == Category.Yoga) {
      return Color(0xFF2E8B57);
    } else if (category == Category.Hiit) {
      return Color(0xFFFFA500);
    } else {
      return Color(0xFF1E90FF);
    }
  }

  // Get lighter color version for UI
  static getLightColor(Category category) {
    if (category == Category.Cardio) {
      return Color.fromARGB(255, 213, 125, 150);
    } else if (category == Category.Yoga) {
      return Color.fromARGB(255, 137, 195, 162);
    } else if (category == Category.Hiit) {
      return Color.fromARGB(255, 249, 203, 117);
    } else {
      return Color.fromARGB(255, 151, 199, 248);
    }
  }

  // Convert workout object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  // Create workout object from JSON string
  static Workout fromJson(String source) {
    final data = json.decode(source);

    return Workout(
      title: data['title'],
      category: Category.values.firstWhere(
        (e) =>
            e.name.toLowerCase() ==
            data['category'].split('.').last.toLowerCase(),
      ),
      date: DateTime.parse(data['date']),
      duration: data['duration'],
    );
  }
}
