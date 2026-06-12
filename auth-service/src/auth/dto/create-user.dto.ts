import { IsEmail, IsNotEmpty, IsString, Max } from "class-validator";

export class CreateUserDto {
    @IsEmail()
    @IsString()
    @IsNotEmpty()
    email!: string;

    @IsNotEmpty()
    @IsString()
    password!: string;

}