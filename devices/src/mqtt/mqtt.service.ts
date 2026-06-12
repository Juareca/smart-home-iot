import { Injectable } from '@nestjs/common';
import mqtt from 'mqtt';
import { DeviceStateService } from '../device-state/device-state.service';

@Injectable()
export class MqttService {
  private client: mqtt.MqttClient;

  constructor(private readonly deviceStateService: DeviceStateService) {
    this.client = mqtt.connect('mqtt://172.31.64.1:1883');

    this.client.on('connect', () => {
      console.log('[MQTT] Conectado a mqtt-broker:1883');

      // Suscribirse a tus topics reales: casa/<room>/<device>/state
      this.client.subscribe('casa/+/+/state', (err) => {
        if (err) console.error('[MQTT] Error al suscribirse:', err.message);
        else console.log('[MQTT] Suscrito a casa/+/+/state');
      });
    });

    this.client.on('message', async (topic, message) => {
      const payload = message.toString(); // "ON" o "OFF"

      // topic: casa/cuarto1/luz/state
      const parts = topic.split('/'); 
      // parts = ["casa", "cuarto1", "luz", "state"]

      const room = parts[1];     // cuarto1
      const device = parts[2];   // luz
      const deviceId = `${room}-${device}`; // cuarto1-luz

      console.log(`[MQTT] Estado recibido → ${deviceId}: ${payload}`);

      try {
        await this.deviceStateService.saveState(deviceId, payload);
        console.log(`[DB] Guardado estado de ${deviceId}: ${payload}`);
      } catch (error) {
        console.error('[DB] Error guardando estado:', error instanceof Error ? error.message : String(error));
      }
    });

    this.client.on('error', (err) => {
      console.error('[MQTT] Error:', err.message);
    });
  }

  publish(topic: string, message: string) {
    this.client.publish(topic, message, {}, (err) => {
      if (err) {
        console.error('[MQTT] Error al publicar:', err.message);
      } else {
        console.log(`[MQTT] Publicado en ${topic}: ${message}`);
      }
    });
  }

  onModuleDestroy() {
    this.client.end();
  }
}
