import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String level;
  final int lessons;
  final int hours;
  final double progress;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;

  const CourseCard({
    super.key,
    required this.title,
    required this.level,
    required this.lessons,
    required this.hours,
    this.progress = 0,
    this.isBookmarked = false,
    required this.onTap,
    required this.onBookmarkToggle,
  });

  Color getLevelColor() {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and bookmark icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.orange : Colors.grey,
                    ),
                    onPressed: onBookmarkToggle,
                  )
                ],
              ),
              const SizedBox(height: 6),

              // Level chip
              Container(
                decoration: BoxDecoration(
                  color: getLevelColor().withAlpha((0.2 * 255).toInt()),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  level,
                  style: TextStyle(
                    color: getLevelColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Lessons and hours info
              Row(
                children: [
                  Text('$lessons Lessons'),
                  const SizedBox(width: 12),
                  Text('$hours Hours'),
                ],
              ),

              const SizedBox(height: 8),

              // Progress bar + percentage
              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                color: Colors.orange,
                minHeight: 6,
              ),
              const SizedBox(height: 4),
              Text('${(progress * 100).toStringAsFixed(0)}% Completed'),
            ],
          ),
        ),
      ),
    );
  }
}
