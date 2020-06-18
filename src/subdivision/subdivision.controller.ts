import { Body, Controller, Post, Put, Request, UseGuards, ValidationPipe } from '@nestjs/common';

import { SubdivisionService } from './subdivision.service';
import { SubdivisionDto } from './dto/subdivision.dto';
import { ISubdivision } from './interfaces/subdivision.interface';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';
import { Reflector } from '@nestjs/core';
import { ITokenPayload } from '../auth/interfaces/token-payload.interface';

@ApiTags('subdivision')
@Controller('api/v1/subdivision')
@UseGuards(JwtAuthGuard, RolesGuard)
export class SubdivisionController {

  constructor(private readonly subdivisionService: SubdivisionService) { }

  @ApiBearerAuth('access-token')
  @Roles('admin')
  @UseGuards(new RolesGuard(new Reflector()))
  @Post('/')
  async create(@Request() req, @Body(new ValidationPipe()) subdivisionDto: SubdivisionDto): Promise<ISubdivision> {
    const user: ITokenPayload = req.user;
    return this.subdivisionService.create(user, subdivisionDto);
  }

  @ApiBearerAuth('access-token')
  @Roles('admin')
  @UseGuards(new RolesGuard(new Reflector()))
  @Put('/')
  async update(@Request() req, @Body(new ValidationPipe()) subdivisionDto: SubdivisionDto): Promise<Boolean> {
    const user: ITokenPayload = req.user;
    return await this.subdivisionService.update(user, subdivisionDto);
  }

}
