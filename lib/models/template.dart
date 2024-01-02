import 'package:flutter/widgets.dart';
import 'package:timegaurdian/UI/dashboard.dart';
import 'package:timegaurdian/UI/templates/habitTracker/screens/home_screen.dart';

class Template {
  final int id;
  final String name;
  final String description;
  final Widget screen;

  Template({
    required this.id,
    required this.name,
    required this.description,
    required this.screen,
  });
}

List<Template> getTemplates() {
  return [
    Template(
      id: 1,
      name: 'Sample Template',
      description: 'This is a sample template.',
      screen: DashboardScreen(), // Replace with the actual screen widget
    ),
    Template(id: 2, name: "Habit Tracker", description: "This is Habit Tracker template", screen: HabitTrackerScreen()),
        Template(id: 2, name: "Planner", description: "This is Planner template", screen: DashboardScreen()),

    // Add more templates here
  ];
}

class HabitsScreen2 {
}