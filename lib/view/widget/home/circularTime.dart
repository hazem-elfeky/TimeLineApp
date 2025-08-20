import 'package:flutter/material.dart';

class CircleTimer extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  const CircleTimer({
    required this.label,
    required this.value,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (value / max).clamp(0.0, 1.0);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                value: percentage,
                color: Colors.purple,
                backgroundColor: Colors.grey[300],
                strokeWidth: 5,
              ),
            ),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
