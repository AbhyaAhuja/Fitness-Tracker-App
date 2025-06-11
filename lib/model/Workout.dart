import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

enum Category { Yoga, Cardio, Strength, Hiit }

final uuid = Uuid();
final formatter = DateFormat().add_yMd();

class Workout {
  final String id;
  final String title;
  final int duration;
  final DateTime date;
  final Category category;

  Workout({
    required this.title,
    required this.category,
    required this.date,
    required this.duration,
  }) : id = uuid.v4();

  String getFormattedDate() {
    return formatter.format(date);
  }

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'date': date,
      'category': category.name,
    };
  }

  static Workout fromJson(String source) {
  try {
    final data = json.decode(source);
    return Workout(
      title: data['title'],
      category: Category.values.firstWhere((e) => e.name == data['category']),
      date: DateTime.parse(data['date']),
      duration: data['duration'],
    );
  } catch (e) {
    throw Exception("Failed to parse workout: $e");
  }
}

}
