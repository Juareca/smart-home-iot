import { Body, Controller, Param, Post } from '@nestjs/common';
import { DeviceService } from './device.service';

@Controller()
export class DeviceController {

    constructor(private readonly deviceService: DeviceService) {}

    @Post(':id/on')
    turnOn(@Param('id') id: string) {
        return this.deviceService.turnOn(id);
    }

    @Post(':id/off')
    turnOff(@Param('id') id: string) {
        return this.deviceService.turnOff(id);
    }

}
