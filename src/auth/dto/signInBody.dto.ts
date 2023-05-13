import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class SignInBodyDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
