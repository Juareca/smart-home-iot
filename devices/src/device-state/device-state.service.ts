import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class DeviceStateService {
  constructor(private readonly prisma: PrismaService) {}

  async saveState(deviceId: string, state: string) {
    return this.prisma.deviceState.create({
      data: { deviceId, state },
    });
  }

  async getLatest(deviceId: string) {
    return this.prisma.deviceState.findFirst({
      where: { deviceId },
      orderBy: { createdAt: 'desc' },
    });
  }
}
