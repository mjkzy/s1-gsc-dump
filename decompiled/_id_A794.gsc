// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4969( var_0, var_1, var_2 )
{
    var_3 = _id_4992();
    var_4 = ( randomfloatrange( 0.1, 5 ), randomfloatrange( 0.1, 5 ), randomfloatrange( 0.1, 5 ) );
    var_5 = spawnhelicopter( var_0, var_3.origin + var_4, ( 0.0, 0.0, 0.0 ), var_1, var_2 );
    var_5._id_24D5 = getent( var_3.target, "targetname" );
    var_5.maxhealth = level._id_2F0B;
    var_5.damagetaken = 0;
    var_5._id_3B88 = "TAG_EYE";
    var_5._id_03E3 = 20;
    var_5._id_3978 = 20;
    var_5.owner = var_0;
    var_5.team = "axis";
    var_5._id_511B = 1;
    var_5._id_5A54 = 2000;
    var_5._id_5A3A = 300;
    var_5._id_94B6 = undefined;
    var_5 _meth_8253( 0, 0, 0 );
    var_5 _meth_8294( 90, 90 );
    var_5 _meth_8283( 40, 40, 40 );
    var_5 _meth_84B1( 90, 180, 90 );
    var_5 _meth_84B2( 1000 );
    var_5 _meth_825A( 5 );
    var_5 _meth_8292( 1000, 250, 100, 0.1 );
    var_5 thread _id_4946();
    var_5 thread _id_497D();
    var_5 thread _id_497E();
    var_5._id_2F34 = var_5 _id_49C9( level._id_2F3C, "vehicle_xh9_warbird_turret_coop", "TAG_EYE" );
    var_5 thread _id_4981();
    self._id_2526 = common_scripts\utility::random( level.players );
    var_5 thread _id_3926();
    return var_5;
}

_id_4992()
{
    var_0 = common_scripts\utility::array_randomize( level._id_4982 );

    foreach ( var_2 in var_0 )
    {
        var_3 = 1;

        foreach ( var_5 in level.players )
        {
            if ( spawnsighttrace( var_2, var_2.origin, var_5.origin, 0 ) )
            {
                var_3 = 0;
                break;
            }
        }

        if ( var_3 )
            return var_2;
    }

    return common_scripts\utility::random( level._id_4982 );
}

_id_4981()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self._id_91C1 ) )
        {
            if ( isdefined( self._id_91C1.isaerialassaultdrone ) && self._id_91C1.isaerialassaultdrone )
                self._id_2F34 _meth_8106( self._id_91C1, ( 0.0, 0.0, -20.0 ) );
            else
                self._id_2F34 _meth_8106( self._id_91C1 );

            if ( isdefined( self._id_2F34 _meth_8109( 0 ) ) )
            {
                var_0 = randomintrange( 5, 10 );

                for ( var_1 = 0; var_1 < var_0; var_1++ )
                {
                    self._id_2F34 _meth_80EA();
                    wait 0.08;
                }

                wait(randomintrange( 3, 5 ));
            }
            else
                wait(randomintrange( 1, 3 ));
        }

        wait 0.05;
    }
}

_id_4946()
{
    self endon( "death" );
    var_0 = 0.3;
    var_1 = common_scripts\utility::getfx( "drone_fan_distortion" );

    if ( level._id_4985 == "drone_large_energy" )
        var_1 = common_scripts\utility::getfx( "drone_fan_distortion_large" );

    foreach ( var_3 in level.players )
    {
        playfxontagforclients( var_1, self, "TAG_FX_FAN_L", var_3 );
        waitframe();
        playfxontagforclients( var_1, self, "TAG_FX_FAN_R", var_3 );
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_0", var_3 );
        wait(var_0);
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_1", var_3 );
        wait(var_0);
        playfxontagforclients( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_2", var_3 );
    }
}

_id_497D()
{
    self endon( "death" );
    level endon( "game_ended" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( ( !isdefined( var_1 ) || var_1.classname == "worldspawn" ) && isdefined( var_9 ) && ( var_9 == "killstreak_strike_missile_gas_mp" || var_9 == "warbird_missile_mp" ) )
            continue;

        if ( isdefined( var_1.team ) )
        {
            if ( self.team == var_1.team )
                continue;
        }
        else if ( isdefined( var_1.owner ) && isdefined( var_1.owner.team ) )
        {
            if ( self.team == var_1.owner.team )
                continue;
        }

        self._id_5604 = var_1;

        if ( !isdefined( self ) )
            return;

        if ( isdefined( var_8 ) && var_8 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        self.wasdamaged = 1;
        var_10 = var_0;

        if ( isplayer( var_1 ) )
        {
            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "tracking_drone" );

            if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
            {
                if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                    var_10 += var_0 * level.armorpiercingmod;
            }
        }

        if ( isdefined( var_1.owner ) && isplayer( var_1.owner ) )
            var_1.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "tracking_drone" );

        if ( isdefined( var_9 ) )
        {
            var_11 = maps\mp\_utility::strip_suffix( var_9, "_lefthand" );

            switch ( var_11 )
            {
                case "remotemissile_projectile_mp":
                case "stinger_mp":
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                    self.largeprojectiledamage = 1;
                    var_10 = self.maxhealth + 1;
                    break;
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                case "emp_grenade_killstreak_mp":
                    var_10 = self.maxhealth + 1;
                case "concussion_grenade_mp":
                case "flash_grenade_mp":
                case "stun_grenade_mp":
                case "stun_grenade_var_mp":
                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_9, self );
        }

        self.damagetaken += var_10;

        if ( self.damagetaken >= self.maxhealth )
        {
            if ( maps\mp\_utility::ismeleemod( var_4 ) || var_4 == "MOD_IMPACT" )
                _id_A798::awardhordemeleekills( var_1 );

            self notify( "death" );
            return;
        }
    }
}

_id_497E()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death", var_0 );
    var_0 = self._id_5604;
    thread _id_497F( var_0 );
}

_id_497F( var_0 )
{
    if ( !isdefined( self ) )
        return;

    level._id_2509--;
    level._id_31D4--;
    setomnvar( "ui_horde_enemies_left", level._id_31D4 );

    if ( level._id_62DC )
        maps\mp\gametypes\horde::checkdefendkill( self, var_0 );

    level notify( "enemy_death", var_0, self );
    waitframe();

    if ( isplayer( var_0 ) )
    {
        _id_A798::_id_120A( var_0 );
        var_0 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 100 );
        level thread _id_A798::_id_49D8( var_0, 100 );

        if ( var_0 maps\mp\_utility::_hasperk( "specialty_triggerhappy" ) )
        {

        }
    }

    if ( isdefined( var_0 ) && isdefined( var_0.owner ) && isplayer( var_0.owner ) && isdefined( var_0.owner._id_53B5 ) )
    {
        _id_A798::_id_120A( var_0.owner );
        var_0.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 100 );
        level thread _id_A798::_id_49D8( var_0.owner, 100 );
    }

    maps\mp\_tracking_drone::_id_94D7();

    if ( isdefined( level._id_94EB._id_3BA9 ) )
        playfx( level._id_94EB._id_3BA9, self.origin );

    if ( isdefined( level._id_94EB._id_8898 ) )
        self playsound( "horde_uav_assault_drone_exp" );

    level._id_251F += 100;
    level notify( "pointsEarned" );
    self._id_2F34 delete();
    self delete();
}

_id_49C9( var_0, var_1, var_2 )
{
    var_3 = spawnturret( "misc_turret", self gettagorigin( var_2 ), var_0, 0 );
    var_3.angles = self gettagangles( var_2 );
    var_3 setmodel( var_1 );
    var_3 _meth_815A( -45.0 );
    var_3 linkto( self, var_2, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3.owner = self.owner;
    var_3.health = 10000;
    var_3.maxhealth = 10000;
    var_3.damagetaken = 0;
    var_3.stunned = 0;
    var_3._id_8F70 = 0.0;
    var_3 setcandamage( 1 );
    var_3 setcanradiusdamage( 1 );
    var_3 _meth_8158( 180 );
    var_3.team = self.team;
    var_3.pers["team"] = self.team;

    if ( level.teambased )
        var_3 _meth_8135( self.team );

    var_3 _meth_8065( "auto_nonai" );
    var_3 _meth_8103( undefined );
    var_3 _meth_8105( 0 );
    var_3.chopper = self;
    var_3 _meth_8156( 180 );
    var_3 _meth_8155( 180 );
    var_3 _meth_8138();
    var_3 _meth_8136();
    var_3 makeunusable();
    var_3 thread _id_4984();
    return var_3;
}

_id_4984()
{
    self.damagecallback = ::_id_4983;
    self setcandamage( 1 );
    self setdamagecallbackon( 1 );
}

_id_4983( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    self.chopper notify( "damage", var_2, var_1, var_7, var_6, var_4, undefined, undefined, var_11, var_3, var_5 );
}

_id_392A()
{
    level._id_2E1D = [];
    level.flying_attack_drones = [];
    level._id_4982 = common_scripts\utility::getstructarray( "horde_drone_spawn", "targetname" );
    level._id_6C2C = common_scripts\utility::getstructarray( "player_test_point", "targetname" );
    var_0 = getentarray( "trigger_once", "classname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy == "drone_air_space" )
            level._id_2E1D[level._id_2E1D.size] = var_2;
    }

    _id_4D07();
    _id_4D64();

    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];
}

_id_4CDF()
{
    var_0 = undefined;

    if ( !isdefined( self._id_792D ) )
        var_0 = 40;
    else
        var_0 = self._id_792D;

    self _meth_825A( 30 );
    self _meth_8283( var_0, var_0 / 4, var_0 / 4 );
}

_id_3926( var_0 )
{
    self notify( "pdrone_flying_attack_drone_logic" );
    self endon( "pdrone_flying_attack_drone_logic" );
    self endon( "death" );
    var_0 = self;
    var_0 thread _id_3922();
    var_0 thread _id_3924();
    var_0._id_0E11 = 1.0;
    var_0._id_0E0D = 1.0;
    var_0 _id_4CDF();

    if ( isdefined( var_0.target ) )
        var_0 waittill( "reached_dynamic_path_end" );

    var_0 thread _id_3927();
}

_id_3E86( var_0 )
{
    var_1 = 500000000;
    var_2 = undefined;

    foreach ( var_4 in level._id_6C2C )
    {
        var_5 = distancesquared( var_4.origin, var_0.origin );

        if ( var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2._id_5778;
}

_id_3E40()
{
    var_0 = common_scripts\utility::random( level._id_6C2C );
    return var_0._id_5778;
}

_id_3927()
{
    self endon( "death" );

    if ( !isdefined( level._id_2E1D ) )
        return;

    _id_9AB6();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = _id_A798::_id_4990( self );

        if ( isdefined( var_0 ) )
        {
            self _meth_8265( var_0 );
            self._id_91C1 = var_0;
            var_1 = _id_3E86( var_0 );
        }
        else
            var_1 = _id_3E40();

        if ( var_1 != self._id_24D5 )
        {
            var_2 = _id_3DE8( self._id_24D5, var_1, level._id_2E1D );

            if ( isdefined( var_2 ) )
                self._id_24D5 = var_2;
        }

        _id_9AB6();
        self waittill( "near_goal" );

        if ( var_1 == self._id_24D5 )
            _id_9FD0();
    }
}

_id_9FD0()
{
    level endon( "pdrone_wait_in_current_air_space" );
    wait(randomfloatrange( 0.5, 1.5 ));
}

_id_19C0()
{
    var_0 = self.origin;

    if ( !_func_22A( var_0, self._id_24D5 ) )
        var_0 = _id_3E43( self._id_24D5 );
    else
    {
        var_1 = 0;
        var_2 = 0;
        var_3 = ( 0.0, 0.0, 0.0 );
        var_4 = 0;
        var_5 = ( 0.0, 0.0, 0.0 );

        foreach ( var_7 in level.flying_attack_drones )
        {
            if ( self != var_7 && isdefined( self._id_24D5 ) && isdefined( var_7._id_24D5 ) )
            {
                if ( self._id_24D5 == var_7._id_24D5 )
                {
                    var_1++;
                    var_8 = var_7.origin - self.origin;
                    var_9 = length( var_8 );

                    if ( var_9 < 90 )
                    {
                        var_2++;
                        var_3 -= 0.5 * ( 90 - var_9 ) * var_8 / var_9;
                    }
                    else if ( var_9 > 150 )
                    {
                        var_4++;
                        var_5 += 0.5 * ( var_9 - 150 ) * var_8 / var_9;
                    }
                }
            }
        }

        if ( var_1 > 0 )
        {
            if ( randomint( 5 ) == 0 )
                var_0 = _id_3E43( self._id_24D5 );
            else
            {
                if ( var_2 > 0 )
                    var_0 += var_3 / var_2;

                if ( var_4 > 0 )
                    var_0 += var_5 / var_4;
            }
        }
        else
            var_0 = _id_3E43( self._id_24D5 );
    }

    return var_0;
}

_id_3E82()
{
    if ( self._id_24D5 != level._id_2ED5._id_9191 || !isdefined( self._id_38E7 ) || !isdefined( self._id_38E6 ) )
        return _id_3E43( self._id_24D5 );

    if ( isdefined( self._id_2C28 ) )
        return self._id_2C28;

    return self._id_38E7 + self._id_38E6;
}

_id_90AA()
{
    var_0 = _id_3E82();
    var_1 = undefined;
    var_2 = self.angles[1];

    if ( !isdefined( self._id_2EDD ) || !isdefined( self._id_2EDD._id_9310 ) )
    {
        var_1 = 1;
        var_3 = var_0 - self.origin;

        if ( var_3 != ( 0.0, 0.0, 0.0 ) )
        {
            var_4 = vectortoangles( var_3 );
            var_2 = var_4[1];
        }
    }

    self _meth_8260( var_0, 60, 50, 50, undefined, var_1, var_2, 0, 0, 0, 0, 0, 1 );
}

_id_9AB6()
{
    self _meth_825B( _id_19C0(), 1 );
}

_id_3E43( var_0 )
{
    for ( var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ); !_func_22A( var_1, var_0 ); var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) )
    {

    }

    return var_1;
}

_id_3922()
{
    self endon( "death" );
    self.damagetaken = 0;
    self._id_51C5 = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread _id_3923();
    }
}

_id_3923()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self._id_51C5 = 1;
    wait 1;
    self._id_51C5 = 0;
}

_id_3924()
{
    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];

    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    self waittill( "death" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

_id_4D07()
{
    var_0 = level._id_2E1D;
    var_1 = [];
    var_2 = 0;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !isdefined( var_0[var_3].script_linkname ) )
        {
            var_1[var_1.size] = var_3;
            continue;
        }

        if ( int( var_0[var_3].script_linkname ) > var_2 )
            var_2 = int( var_0[var_3].script_linkname );
    }

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        var_2++;
        var_0[var_1[var_3]].script_linkname = var_2;
    }

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !isdefined( var_0[var_3]._id_5797 ) )
            var_0[var_3]._id_5797 = [];

        var_4 = [];

        if ( isdefined( var_0[var_3].script_linkto ) )
        {
            var_4 = strtok( var_0[var_3].script_linkto, " " );

            for ( var_5 = 0; var_5 < var_4.size; var_5++ )
            {
                for ( var_6 = 0; var_6 < var_0.size; var_6++ )
                {
                    if ( var_0[var_6].script_linkname == var_4[var_5] )
                    {
                        var_7 = 0;

                        for ( var_8 = 0; var_8 < var_0[var_3]._id_5797.size; var_8++ )
                        {
                            if ( var_0[var_3]._id_5797[var_8] == var_0[var_6] )
                            {
                                var_7 = 1;
                                break;
                            }
                        }

                        if ( !var_7 )
                            var_0[var_3]._id_5797[var_0[var_3]._id_5797.size] = var_0[var_6];

                        if ( !isdefined( var_0[var_6]._id_5797 ) )
                            var_0[var_6]._id_5797 = [];

                        var_7 = 0;

                        for ( var_8 = 0; var_8 < var_0[var_6]._id_5797.size; var_8++ )
                        {
                            if ( var_0[var_6]._id_5797[var_8] == var_0[var_3] )
                            {
                                var_7 = 1;
                                break;
                            }
                        }

                        if ( !var_7 )
                            var_0[var_6]._id_5797[var_0[var_6]._id_5797.size] = var_0[var_3];

                        break;
                    }
                }
            }
        }
    }
}

_id_4D64()
{
    for ( var_0 = 0; var_0 < level._id_6C2C.size; var_0++ )
        level._id_6C2C[var_0]._id_5778 = getent( level._id_6C2C[var_0].target, "targetname" );
}

_id_3DE8( var_0, var_1, var_2 )
{
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
    var_4 = [];
    var_4[0] = var_0;
    var_5 = [];
    var_0._id_35B2 = distancesquared( var_0.origin, var_1.origin );
    var_0._id_3BC1 = 0;

    while ( var_4.size > 0 )
    {
        var_6 = undefined;
        var_7 = 500000000;

        foreach ( var_9 in var_4 )
        {
            if ( var_9._id_35B2 < var_7 )
            {
                var_6 = var_9;
                var_7 = var_9._id_35B2;
            }
        }

        if ( var_6 == var_1 )
            return var_6._id_1A12;

        var_4 = common_scripts\utility::array_remove( var_4, var_6 );
        var_5[var_5.size] = var_6;
        var_11 = var_6._id_5797;

        foreach ( var_9 in var_11 )
        {
            if ( common_scripts\utility::array_contains( var_5, var_9 ) )
                continue;

            var_13 = var_6._id_3BC1 + distancesquared( var_6.origin, var_9.origin );
            var_14 = common_scripts\utility::array_contains( var_4, var_9 );

            if ( !var_14 )
            {
                var_9._id_1A12 = var_6;
                var_9._id_3BC1 = var_13;
                var_9._id_35B2 = var_9._id_3BC1 + distancesquared( var_9.origin, var_1.origin );
                var_4[var_4.size] = var_9;
                continue;
            }

            if ( var_13 < var_9._id_3BC1 )
            {
                var_9._id_1A12 = var_6;
                var_9._id_3BC1 = var_13;
                var_9._id_35B2 = var_9._id_3BC1 + distancesquared( var_9.origin, var_1.origin );
            }
        }
    }

    return undefined;
}
