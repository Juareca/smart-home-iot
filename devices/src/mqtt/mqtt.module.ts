import { Module } from '@nestjs/common';
import { MqttService } from './mqtt.service';
import { DeviceStateModule } from '../device-state/device-state.module';

@Module({
  imports: [DeviceStateModule],
  providers: [MqttService],
  exports: [MqttService]
})
export class MqttModule {}
