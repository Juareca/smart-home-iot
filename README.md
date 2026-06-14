🔌 SmartSwitch IoT — Control de iluminación con ESP32, Flutter y NestJS

Sistema IoT completo para control de iluminación en tiempo real, con integración entre hardware, backend y aplicación móvil.
Desarrollado por Juan Alberto Arévalo, Ingeniero de Software (2026).

🚀 Descripción general
SmartSwitch IoT es un sistema de automatización que permite controlar luces desde:

- una aplicación Flutter,
- un interruptor físico

El sistema funciona incluso cuando el usuario apaga la luz desde el interruptor físico, gracias a una arquitectura eléctrica profesional donde el ESP32 permanece energizado de forma independiente.
Este proyecto demuestra dominio en:

- Desarrollo móvil (Flutter)
- Backend profesional (NestJS)
- Comunicación en tiempo real (MQTT / WebSockets)
- Electrónica aplicada (ESP32 + relé + AC‑DC)
- Arquitectura IoT moderna

🧩 Arquitectura del sistema

Flutter App → NestJS API → MQTT Broker → ESP32 → Relé → Luz
                         ↑
                         └── WebSockets (estado en tiempo real)

🛠 Tecnologías utilizadas

Frontend: Flutter, Material Design, HTTP, WebSockets
Backend: NestJS, JWT, REST API, MQTT
Hardware: ESP32, Relé 5V, AC‑DC 110/220V→5V, interruptor físico

📱 Funcionalidades principales

✔ Login con JWT
Autenticación segura con token persistente usando SharedPreferences.

✔ Dashboard IoT
Visualización del estado de la luz en tiempo real.

✔ Control remoto
Encendido y apagado desde la app Flutter.

✔ Control físico
El usuario puede apagar la luz desde el interruptor tradicional.

✔ Control híbrido (modo Sonoff)
El ESP32 puede volver a encender la luz aunque el interruptor esté apagado.

✔ Estado en tiempo real
Sincronización instantánea entre app, backend y hardware.

🔌 Diagrama eléctrico (versión profesional)
Código
                ┌──────────────────────────┐
                │   MÓDULO AC‑DC 5V        │
                │                          │
Fase ───────────┤ L                    +5V ├──→ Vin ESP32
Neutro ─────────┤ N                    GND ├──→ GND ESP32
                └──────────────────────────┘

Fase ────────────────┐
                      │
                      ├──→ Interruptor → Retorno → Bombillo
                      │
                      └──→ COM del relé
                           NO del relé → Retorno → Bombillo
