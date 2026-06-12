import 'package:flutter/material.dart';

class NeonSwitch extends StatelessWidget {
  final bool isOn;

  const NeonSwitch({
    super.key,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 80,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: isOn
              ? [Colors.cyanAccent, Colors.blueAccent]
              : [Colors.grey.shade700, Colors.grey.shade800],
        ),
        boxShadow: [
          BoxShadow(
            color: isOn
                ? Colors.cyanAccent.withValues(alpha: 0.4)
                : Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withValues(alpha: 0.4),
                blurRadius: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
