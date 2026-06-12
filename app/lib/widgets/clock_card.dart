import 'package:flutter/material.dart';

class ClockCard extends StatelessWidget {
  const ClockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            final now = DateTime.now();
            final time = "${now.hour.toString().padLeft(2, '0')}:"
                "${now.minute.toString().padLeft(2, '0')}:"
                "${now.second.toString().padLeft(2, '0')}";

            return Text(
              time,
              style: const TextStyle(
                fontSize: 34,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}
