// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_5FC5 = 25;
    precachelocationselector( "map_artillery_selector" );
    precachestring( &"KILLSTREAKS_MP_PRISON" );
    precacheitem( "prison_turret_mp" );
    _func_251( "prison_laser" );
    level._id_5FC3 = 0;
    level._id_6FC5 = 0;
    level._id_6FBF = "mp_prison_ks_alarm";
    level._id_6FC0 = "orbital_laser";
    level._id_6FC3 = loadfx( "vfx/lights/light_tracking_prison_blink_friendly" );
    level._id_6FC2 = loadfx( "vfx/lights/light_tracking_prison_blink_enemy" );
    level._id_6FC1 = loadfx( "vfx/lights/prison_tracking_laser_blue" );
    level.killstreakfuncs["mp_prison"] = ::_id_98B0;
    level.mapkillstreak = "mp_prison";

    if ( !isdefined( level._id_7CC5 ) )
        level._id_7CC5 = [];

    level._id_7CC5["prison_turret"] = spawnstruct();
    level._id_7CC5["prison_turret"].health = 999999;
    level._id_7CC5["prison_turret"].maxhealth = 1000;
    level._id_7CC5["prison_turret"]._id_1933 = 20;
    level._id_7CC5["prison_turret"]._id_1932 = 120;
    level._id_7CC5["prison_turret"]._id_6721 = 0.15;
    level._id_7CC5["prison_turret"]._id_6720 = 0.35;
    level._id_7CC5["prison_turret"]._id_7CC4 = "sentry";
    level._id_7CC5["prison_turret"]._id_7CC3 = "sentry_offline";
    level._id_7CC5["prison_turret"]._id_9364 = 90.0;
    level._id_7CC5["prison_turret"]._id_8A5D = 0.05;
    level._id_7CC5["prison_turret"]._id_65F2 = 8.0;
    level._id_7CC5["prison_turret"]._id_21B4 = 0.1;
    level._id_7CC5["prison_turret"]._id_3BBD = 0.3;
    level._id_7CC5["prison_turret"].streakname = "sentry";
    level._id_7CC5["prison_turret"]._id_051C = "prison_turret_mp";
    level._id_7CC5["prison_turret"]._id_5D3A = "prison_security_laser";
    level._id_7CC5["prison_turret"]._id_5D40 = "sentry_minigun_weak_obj";
    level._id_7CC5["prison_turret"]._id_5D41 = "sentry_minigun_weak_obj_red";
    level._id_7CC5["prison_turret"]._id_5D3C = "sentry_minigun_weak_destroyed";
    level._id_7CC5["prison_turret"]._id_01F2 = &"MP_PRISON_SENSOR_PICKUP";
    level._id_7CC5["prison_turret"].headicon = 1;
    level._id_7CC5["prison_turret"]._id_91FB = "used_sentry";
    level._id_7CC5["prison_turret"]._id_84AA = 0;
    level._id_7CC5["prison_turret"]._id_9F28 = "sentry_destroyed";
    level._id_598A = level._id_7CC5["prison_turret"]._id_01F2;
    level thread _id_64D8();
    level._id_6FC4 = _id_832C();
}

_id_98B0( var_0, var_1 )
{
    if ( level._id_5FC3 )
    {
        self iclientprintlnbold( &"MP_PRISON_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = _id_7FF0( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_prison", self.origin );

    return var_2;
}

_id_832C()
{
    var_0 = getentarray( "prison_turret", "targetname" );
    var_1 = "prison_turret";

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_0[var_2]._id_899E = spawnturret( "misc_turret", var_0[var_2].origin, level._id_7CC5[var_1]._id_051C, 0 );
        var_0[var_2]._id_899E _meth_8136();
        var_0[var_2]._id_899E _id_7CAD( var_1 );
        var_0[var_2]._id_899E.angles = var_0[var_2].angles;
        var_0[var_2]._id_899E._id_09B6 = 0;
        var_0[var_2]._id_899E._id_1926 = 0;
        var_0[var_2]._id_899E._id_7043 = 0;
        var_0[var_2]._id_899E._id_6FBE = 0;
    }

    return var_0;
}

_id_7CAD( var_0 )
{
    self.sentrytype = var_0;
    self._id_1AAE = 1;
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );
    self _meth_8138();
    self _meth_815A( 0.0 );
    self _meth_817A( 1 );
    maps\mp\killstreaks\_autosentry::_id_7CB9();
    thread maps\mp\killstreaks\_autosentry::_id_7CAB();
}

_id_7FF0( var_0 )
{
    if ( level._id_5FC3 )
        return 0;

    level._id_5FC3 = 1;

    for ( var_1 = 0; var_1 < level._id_6FC4.size; var_1++ )
    {
        level._id_6FC5++;
        level._id_6FC4[var_1]._id_899E _id_7CBA( var_0 );
        level._id_6FC4[var_1]._id_899E._id_84AA = 0;
        level._id_6FC4[var_1]._id_899E._id_1BAA = var_0;
        level._id_6FC4[var_1]._id_899E _id_7CBB();
        level._id_6FC4[var_1]._id_899E setcandamage( 1 );
        level._id_6FC4[var_1]._id_899E setcanradiusdamage( 1 );
        level._id_6FC4[var_1]._id_899E thread _id_7CA8();
        level._id_6FC4[var_1]._id_899E thread _id_7CA9();
        level._id_6FC4[var_1]._id_899E._id_09B6 = 0;
        level._id_6FC4[var_1]._id_899E._id_1926 = 0;
        level._id_6FC4[var_1]._id_899E._id_7043 = 0;
        level._id_6FC4[var_1]._id_899E._id_83CB = 0;
        level._id_6FC4[var_1]._id_899E._id_6FBE = 1;
        level._id_6FC4[var_1]._id_899E._id_62A5 = 0;
        level._id_6FC4[var_1]._id_899E thread _id_6FCA();
        level._id_6FC4[var_1]._id_899E thread _id_73FD();
        level._id_6FC4[var_1]._id_899E thread _id_0FED();
    }

    level thread _id_6FCB();
    level thread _id_5EB0();
    level thread _id_0CB0();
    return 1;
}

_id_6FCB()
{
    level endon( "game_ended" );
    var_0 = level._id_5FC5;

    while ( var_0 > 0 )
    {
        wait 1;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_0--;

        if ( level._id_5FC3 == 0 )
            return;
    }

    for ( var_1 = 0; var_1 < level._id_6FC4.size; var_1++ )
        level._id_6FC4[var_1]._id_899E notify( "fake_prison_death" );
}

_id_7CBA( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );

    if ( level.teambased && isdefined( var_0 ) )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread _id_7CAA();
}

_id_7CBB()
{
    self _meth_8104( undefined );
    self._id_1BAA _meth_80DE();
    self._id_1BAA = undefined;

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    _id_7CB6();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

_id_7CA8()
{
    self endon( "fake_prison_death" );
    level endon( "game_ended" );
    self.health = level._id_7CC5[self.sentrytype].health;
    self.maxhealth = level._id_7CC5[self.sentrytype].maxhealth;
    self.damagetaken = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
            continue;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        var_10 = 0;

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                    self.largeprojectiledamage = 0;
                    var_10 = self.maxhealth + 1;

                    if ( isplayer( var_1 ) )
                        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

                    break;
                default:
                    if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
                        var_10 = var_0 * 3.5;
                    else
                        var_10 = 0;

                    if ( isplayer( var_1 ) )
                        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "sentry" );

                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_1, var_0, var_4, var_9 );

            if ( isplayer( var_1 ) && ( !isdefined( self.owner ) || var_1 != self.owner ) )
            {
                var_1 maps\mp\_utility::incplayerstat( "map_killstreak_destroyed", 1 );
                level thread maps\mp\gametypes\_rank::awardgameevent( "map_killstreak_destroyed", var_1, var_9, undefined, var_4 );
            }

            if ( isdefined( self.owner ) )
                self.owner thread maps\mp\_utility::leaderdialogonplayer( level._id_7CC5[self.sentrytype]._id_9F28, undefined, undefined, self.origin );

            self notify( "fake_prison_death" );
            return;
        }
    }
}

_id_7CA9()
{
    self waittill( "fake_prison_death" );

    if ( !isdefined( self ) )
        return;

    maps\mp\killstreaks\_autosentry::_id_7CB9();
    self _meth_8103( undefined );
    self _meth_8105( 0 );

    if ( level._id_7CC5[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( "none", ( 0.0, 0.0, 0.0 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( "none", ( 0.0, 0.0, 0.0 ) );
    }

    level._id_6FC5--;
    self setcandamage( 0 );
    self setcanradiusdamage( 0 );

    if ( self._id_09B6 == 1 )
        self._id_09B6 = 0;

    if ( self._id_1926 == 1 )
        self._id_1926 = 0;

    if ( isdefined( self._id_6F58 ) )
    {
        self notify( "lost_or_changed_target" );
        self._id_6F58 = undefined;
    }

    self._id_83CB = 0;
    self._id_04D0 = undefined;

    if ( self._id_7043 == 1 )
        self._id_7043 = 0;

    self._id_6FBE = 0;
}

_id_7CB6()
{
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );

    if ( level._id_7CC5[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 25.0 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 25.0 ) );
    }
}

_id_7CAA()
{
    level endon( "game_ended" );
    self endon( "fake_prison_death" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "fake_prison_death" );
}

_id_5EB0()
{
    level endon( "game_ended" );

    while ( level._id_6FC5 > 0 )
        wait 0.05;

    level._id_5FC3 = 0;

    for ( var_0 = 0; var_0 < level._id_6FC4.size; var_0++ )
    {
        if ( level._id_6FC4[var_0]._id_899E._id_7043 == 1 )
            level._id_6FC4[var_0]._id_899E._id_7043 = 0;

        for ( var_1 = 0; var_1 < level.players.size; var_1++ )
        {
            level.players[var_1]._id_54DE[var_0] laseroff();
            stopfxontag( level._id_6FC1, level.players[var_1]._id_54DE[var_0], "tag_laser" );
            level.players[var_1]._id_54DE[var_0] _meth_846B();
            level.players[var_1]._id_54DE[var_0]._id_54F4 = 0;
        }
    }

    for ( var_2 = 0; var_2 < level.players.size; var_2++ )
    {
        level.players[var_2]._id_62A6 = 0;

        if ( level.players[var_2] hasperk( "specialty_radararrow", 1 ) )
            level.players[var_2] unsetperk( "specialty_radararrow", 1 );

        level.players[var_2] notify( "player_not_tracked" );
        level.players[var_2].is_being_tracked = 0;
    }
}

_id_466C()
{
    playfxontag( level._id_6FC3, self, "tag_fx" );
    self waittill( "fake_prison_death" );
    stopfxontag( level._id_6FC3, self, "tag_fx" );
}

_id_6FCA()
{
    level endon( "game_ended" );
    self._id_6E4A = spawn( "script_model", self.origin );
    self._id_6E4A.team = self.team;
    self._id_6E4A makeportableradar( self.owner );
    self waittill( "fake_prison_death" );
    level maps\mp\gametypes\_portable_radar::deleteportableradar( self._id_6E4A );
    self._id_6E4A = undefined;
}

_id_0CB0()
{
    level endon( "game_ended" );

    while ( level._id_5FC3 )
    {
        if ( isdefined( level._id_6FC4 ) && isdefined( level.players ) )
        {
            for ( var_0 = 0; var_0 < level._id_6FC4.size; var_0++ )
            {
                if ( level._id_6FC4[var_0]._id_899E._id_6FBE != 1 )
                {
                    for ( var_1 = 0; var_1 < level.players.size; var_1++ )
                    {
                        if ( level.players[var_1]._id_54DE[var_0]._id_54F4 == 1 )
                        {
                            level.players[var_1]._id_54DE[var_0] laseroff();
                            level.players[var_1]._id_54DE[var_0] _meth_846B();
                            level.players[var_1]._id_54DE[var_0]._id_54F4 = 0;
                        }
                    }

                    continue;
                }

                level._id_6FC4[var_0]._id_899E._id_62A5 = 0;

                for ( var_1 = 0; var_1 < level.players.size; var_1++ )
                {
                    var_2 = 0;
                    var_3 = 10;
                    var_4 = ( randomfloat( var_3 ), randomfloat( var_3 ), randomfloat( var_3 ) ) - ( 5.0, 5.0, 5.0 );

                    if ( level.players[var_1] getstance() == "stand" )
                        var_5 = ( 0.0, 0.0, 50.0 ) + var_4;
                    else if ( level.players[var_1] getstance() == "crouch" )
                        var_5 = ( 0.0, 0.0, 35.0 ) + var_4;
                    else
                        var_5 = ( 0.0, 0.0, 10.0 ) + var_4;

                    if ( isdefined( level.players[var_1] ) && isalive( level.players[var_1] ) && ( level.teambased && level.players[var_1].team != level._id_6FC4[var_0]._id_899E.team || !level.teambased && level.players[var_1] != level._id_6FC4[var_0]._id_899E.owner ) )
                    {
                        var_6 = distancesquared( level.players[var_1].origin, level._id_6FC4[var_0]._id_899E.origin );

                        if ( var_6 < 3610000 )
                        {
                            if ( sighttracepassed( level._id_6FC4[var_0]._id_899E.origin, level.players[var_1].origin + var_5, 0, undefined ) )
                                var_2 = 1;
                        }
                    }

                    if ( var_2 )
                    {
                        if ( level.players[var_1]._id_54DE[var_0]._id_54F4 == 0 )
                        {
                            level.players[var_1]._id_54DE[var_0]._id_54F4 = 1;
                            level.players[var_1]._id_54DE[var_0] laseron( "prison_laser" );
                            playfxontag( level._id_6FC1, level.players[var_1]._id_54DE[var_0], "tag_laser" );
                            level.players[var_1]._id_54DE[var_0] _meth_846A( level.players[var_1], "bone", "tag_eye", "randomoffset" );
                        }

                        level.players[var_1]._id_62A6++;
                        level._id_6FC4[var_0]._id_899E._id_62A5++;
                        continue;
                    }

                    if ( level.players[var_1]._id_54DE[var_0]._id_54F4 == 1 )
                    {
                        level.players[var_1]._id_54DE[var_0]._id_54F4 = 0;
                        level.players[var_1]._id_54DE[var_0] laseroff();
                        stopfxontag( level._id_6FC1, level.players[var_1]._id_54DE[var_0], "tag_laser" );
                        level.players[var_1]._id_54DE[var_0] _meth_846B();
                    }
                }

                if ( level._id_6FC4[var_0]._id_899E._id_62A5 > 0 )
                {
                    if ( level._id_6FC4[var_0]._id_899E._id_7043 == 0 )
                        level._id_6FC4[var_0]._id_899E._id_7043 = 1;

                    continue;
                }

                if ( level._id_6FC4[var_0]._id_899E._id_7043 == 1 )
                    level._id_6FC4[var_0]._id_899E._id_7043 = 0;
            }

            for ( var_7 = 0; var_7 < level.players.size; var_7++ )
            {
                if ( level.players[var_7]._id_62A6 > 0 )
                {
                    level.players[var_7] setperk( "specialty_radararrow", 1, 0 );

                    if ( level.players[var_7].is_being_tracked == 0 )
                        level.players[var_7].is_being_tracked = 1;
                }
                else
                {
                    if ( level.players[var_7] hasperk( "specialty_radararrow", 1 ) )
                        level.players[var_7] unsetperk( "specialty_radararrow", 1 );

                    level.players[var_7] notify( "player_not_tracked" );
                    level.players[var_7].is_being_tracked = 0;
                }

                level.players[var_7]._id_62A6 = 0;
            }
        }

        wait 0.1;
    }
}

_id_2425()
{
    if ( !isdefined( self._id_54DE ) )
    {
        self._id_54DE = [];

        for ( var_0 = 0; var_0 < level._id_6FC4.size; var_0++ )
        {
            var_1 = level._id_6FC4[var_0]._id_899E.origin;
            self._id_54DE[var_0] = spawn( "script_model", var_1 );
            self._id_54DE[var_0] setmodel( "tag_laser" );
            self._id_54DE[var_0]._id_54F4 = 0;
        }
    }
}

_id_2853()
{
    if ( isdefined( self._id_54DE ) )
    {
        for ( var_0 = 0; var_0 < level._id_6FC4.size; var_0++ )
        {
            self._id_54DE[var_0] _meth_846B();
            self._id_54DE[var_0] delete();
        }
    }
}

_id_64D8()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;
        var_0 _id_2425();
        var_0._id_62A6 = 0;
        var_0 thread _id_64D9();
    }
}

_id_64D9()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );
    _id_2853();
}

_id_2437()
{
    if ( !isdefined( self._id_6FCC ) )
    {
        self._id_6FCC = newclienthudelem( self );
        self._id_6FCC.x = -80;
        self._id_6FCC.y = -60;
        self._id_6FCC setshader( "tracking_drone_targeted_overlay", 800, 600 );
        self._id_6FCC.alignx = "left";
        self._id_6FCC.aligny = "top";
        self._id_6FCC.horzalign = "fullscreen";
        self._id_6FCC.vertalign = "fullscreen";
        self._id_6FCC.alpha = 0;
    }
}

_id_35F1()
{
    level endon( "game_ended" );
    self endon( "player_not_tracked" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );

    for (;;)
    {
        if ( isdefined( self._id_99BC ) )
        {
            var_0 = randomfloatrange( 0.25, 1.0 );
            self._id_6FCC fadeovertime( 0.1 );
            self._id_6FCC.color = ( var_0, var_0, var_0 );
            self._id_6FCC.alpha = 1;
            wait 0.1;
        }

        wait 0.05;
    }
}

_id_31BC()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self._id_6FCC fadeovertime( 0.2 );
    self._id_6FCC.alpha = 0.0;
}

_id_73FD()
{
    self endon( "fake_prison_death" );

    while ( level._id_5FC3 )
    {
        if ( self._id_7043 == 1 )
            playsoundatpos( self.origin, level._id_6FBF );

        wait 4;
    }
}

_id_0FED()
{
    wait 2.5;
    playsoundatpos( ( 0.0, 0.0, 0.0 ), "mp_prison_anouncer_ext" );
}
