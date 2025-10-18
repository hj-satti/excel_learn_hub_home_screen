import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseTitle;
  final String level;
  final int lessons;
  final int hours;

  const CourseDetailScreen({
    super.key,
    required this.courseTitle,
    required this.level,
    required this.lessons,
    required this.hours,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseTitle,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Level: $level'),
            Text('Lessons: $lessons'),
            Text('Hours: $hours'),
            const SizedBox(height: 24),
            const Text(
              'Course details go here...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
