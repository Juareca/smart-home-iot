import 'package:aplicacion1/services/mqtt_service.dart';
import 'package:aplicacion1/widgets/clock_card.dart';
import 'package:aplicacion1/widgets/device_card.dart';
import 'package:aplicacion1/widgets/neon_switch.dart';
import 'package:flutter/material.dart';

class CuartoJuanAlbertoScreen extends StatefulWidget {
  const CuartoJuanAlbertoScreen({super.key});

  @override
  State<CuartoJuanAlbertoScreen> createState() => _CuartoJuanAlbertoScreenState();
}

class _CuartoJuanAlbertoScreenState extends State<CuartoJuanAlbertoScreen> {
  bool luzCuarto = false;

  final mqtt = MqttService();

  @override
  void initState() {
    super.initState();

    mqtt.onMessage = (msg) {
      setState(() {
        luzCuarto = msg == "ON";
      });
    };

    mqtt.connect();
  }

  void toggleLight() {
    final newState = luzCuarto ? "OFF" : "ON";
    mqtt.publish("casa/cuarto1/luz/set", newState);
    setState(() => luzCuarto = !luzCuarto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A0F1F),
              Color(0xFF111827),
              Color(0xFF1F2937),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,

                children: [
                  // Tarjeta de luz
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: DeviceCard(
                      title: "Luz Cuarto 1",
                      icon: Icons.lightbulb,
                      isOn: luzCuarto,
                      switchWidget: NeonSwitch(isOn: luzCuarto),
                      onTap: toggleLight,
                    ),
                  ),

                  // Reloj futurista
                  const SizedBox(
                    width: 180,
                    child: ClockCard(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
