import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Ip,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpBodyDto, SignUpAuthDto } from './dto';
import { Tokens } from './types';
import { SignInBodyDto } from './dto';
import { SignInAuthDto } from './dto';
import { RtGuard } from '../common/guards';
import { GetCurrentUser, GetCurrentUserId, Public } from '../common/decorators';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Public()
  @Post('local/signup')
  @HttpCode(HttpStatus.CREATED)
  signupLocal(
    @Ip() userIp: string,
    @Body() bodyDto: SignUpBodyDto,
  ): Promise<Tokens> {
    const dto: SignUpAuthDto = { ...bodyDto, userIp };
    return this.authService.signupLocal(dto);
  }

  @Public()
  @Post('local/signin')
  @HttpCode(HttpStatus.OK)
  signinLocal(
    @Ip() userIp: string,
    @Body() bodyDto: SignInBodyDto,
  ): Promise<Tokens> {
    const dto: SignInAuthDto = { ...bodyDto, userIp };
    return this.authService.signinLocal(dto);
  }

  @Post('logout')
  @HttpCode(HttpStatus.OK)
  logout(@GetCurrentUserId() userId: number): Promise<boolean> {
    return this.authService.logout(userId);
  }

  @Public()
  @UseGuards(RtGuard)
  @Post('refresh')
  @HttpCode(HttpStatus.OK)
  refreshTokens(
    @Ip() userIp: string,
    @GetCurrentUser('refreshToken') refreshToken: string,
    @GetCurrentUserId() userId: number,
  ): Promise<Tokens> {
    return this.authService.refreshTokens(userId, refreshToken, userIp);
  }
}
