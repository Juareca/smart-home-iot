import { Body, Controller, Get, Post, Req, UseGuards, UsePipes, ValidationPipe } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './guards/jwt-auth.guard';

@Controller()
export class AuthController {

    constructor(private authService: AuthService) {}

    @Get('register')
    obtenerUser() {
        return this.authService.getUser();
    }

    @Post('register')
    @UsePipes(new ValidationPipe())

    crearUser(@Body() user: CreateUserDto) {
        return this.authService.createUser(user);
    }


    @Post('login')
    login(@Body() dto: CreateUserDto) {
        return this.authService.login(dto);
    }

    @UseGuards(JwtAuthGuard)
    @Get('me')
    me(@Req() req) {
        return req.user;
    }

}
