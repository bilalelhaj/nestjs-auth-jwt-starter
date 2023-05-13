import { IsEmail, IsIP, IsNotEmpty, IsString } from 'class-validator';

export class SignUpAuthDto {
  @IsIP()
  @IsNotEmpty()
  userIp: string;

  @IsNotEmpty()
  @IsString()
  firstName: string;

  @IsNotEmpty()
  @IsString()
  lastName: string;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
