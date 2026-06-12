import { Module } from '@nestjs/common';
import { DeviceModule } from './device/device.module';
import { DeviceStateModule } from './device-state/device-state.module';
import { MqttModule } from './mqtt/mqtt.module';

@Module({
  imports: [
    DeviceModule,
    DeviceStateModule,
    MqttModule,
  ],
})
export class AppModule {}
