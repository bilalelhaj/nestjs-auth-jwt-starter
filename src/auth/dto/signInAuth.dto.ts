import { IsEmail, IsIP, IsNotEmpty, IsString } from 'class-validator';

export class SignInAuthDto {
  @IsIP()
  @IsNotEmpty()
  userIp: string;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
