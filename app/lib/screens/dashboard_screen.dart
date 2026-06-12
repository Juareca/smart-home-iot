import 'package:aplicacion1/screens/cuartos/cuarto_juan_alberto_screen.dart';
import 'package:aplicacion1/widgets/clock_card.dart';
import 'package:aplicacion1/widgets/room_card.dart';
import 'package:flutter/material.dart';
import '../services/mqtt_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      appBar: AppBar(
        title: const Text(
          "Familia AC",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
        backgroundColor: Color(0xFF0A0F1F),
        elevation: 0,
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Tarjeta MQTT original
                // Cuarto Juan Alberto
                RoomCard(
                  title: "Cuarto - Juan Alberto",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CuartoJuanAlbertoScreen(),
                      ),
                    );
                  },
                ),

                // TARJETA: Cuarto Luis Eduardo
                const RoomCard(title: "Cuarto - Luis Eduardo"),

                // TARJETA: Cuarto Elsis y Juan
                const RoomCard(title: "Cuarto - Elsis y Juan"),

                // Reloj futurista
                const ClockCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
