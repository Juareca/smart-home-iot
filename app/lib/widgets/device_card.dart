import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isOn;
  final Widget switchWidget;
  final VoidCallback? onTap;

  const DeviceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isOn,
    required this.switchWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: isOn
                  ? Colors.cyanAccent.withValues(alpha: 0.4)
                  : Colors.blueGrey.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 60,
              color: isOn ? Colors.cyanAccent : Colors.white24,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Switch futurista (inyectado desde afuera)
            switchWidget,

            Text(
              isOn ? "ON" : "OFF",
              style: TextStyle(
                fontSize: 18,
                color: isOn ? Colors.cyanAccent : Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
