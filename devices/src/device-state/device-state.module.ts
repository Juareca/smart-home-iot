import { Module } from '@nestjs/common';
import { DeviceStateService } from './device-state.service';
import { PrismaService } from '../prisma/prisma.service';

@Module({
  providers: [DeviceStateService, PrismaService],
  exports: [DeviceStateService],
})
export class DeviceStateModule {}
