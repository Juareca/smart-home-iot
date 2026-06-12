import { Injectable } from '@nestjs/common';
import { MqttService } from '../mqtt/mqtt.service';

@Injectable()
export class DeviceService {
    constructor(private readonly mqtt: MqttService) {}

  turnOn(deviceId: string) {
    this.mqtt.publish(`devices/${deviceId}/set`, 'ON');
    return { status: 'ok', action: 'on' };
  }

  turnOff(deviceId: string) {
    this.mqtt.publish(`devices/${deviceId}/set`, 'OFF');
    return { status: 'ok', action: 'off' };
  }
}
