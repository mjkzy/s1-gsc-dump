// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_885E = 30;
    level._id_885D = loadfx( "vfx/fire/fire_xsglow_runner_5s" );
    level._id_8861 = "mp_solar_array_player";
    level._id_8862 = "mp_solar_array_target";
    level.killstreakfuncs["mp_solar"] = ::_id_98C6;
    level.mapkillstreak = "mp_solar";
    level._id_598A = &"MP_SOLAR_MAP_KILLSTREAK_PICKUP";
    level.mapkillstreakdamagefeedbacksound = ::_id_4652;
    level._id_5984 = ::_id_82FA;
    level.killstreakwieldweapons["killstreak_solar_mp"] = "mp_solar";
}

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_solar", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
}

_id_98C6( var_0, var_1 )
{
    if ( isdefined( level._id_8860 ) )
    {
        self iclientprintlnbold( &"MP_SOLAR_REFLECTOR_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak();

    if ( var_2 != "success" )
        return 0;

    maps\mp\_utility::setusingremote( "mp_solar" );
    var_2 = _id_800C( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_solar", self.origin );
    else if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    return isdefined( var_2 ) && var_2;
}

_id_800C( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    level._id_8860 = var_0;
    thread maps\mp\_utility::teamplayercardsplash( "used_mp_solar", var_0 );
    thread onplayerconnect();
    thread _id_8325();
    var_0 thread overlay();
    var_0 thread _id_76C4();
    var_0 thread _id_73D8( level._id_885E );
    var_0 thread _id_73DA();
    var_0 thread _id_73D6();
    var_0 thread _id_73D9();
    return 1;
}

_id_1362( var_0 )
{
    var_1 = "compassping_orbitallaser_friendly";
    var_2 = "compassping_orbitallaser_hostile";
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "invisible", ( 0.0, 0.0, 0.0 ) );
    objective_onentity( var_3, var_0 );
    objective_state( var_3, "active" );

    if ( level.teambased )
        objective_team( var_3, self.team );
    else
        objective_player( var_3, self getentitynumber() );

    objective_icon( var_3, var_1 );
    var_4 = var_3;
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "invisible", ( 0.0, 0.0, 0.0 ) );
    objective_onentity( var_3, var_0 );
    objective_state( var_3, "active" );

    if ( level.teambased )
        objective_team( var_3, level.otherteam[self.team] );
    else
        objective_playerenemyteam( var_3, self getentitynumber() );

    objective_icon( var_3, var_2 );
    var_5 = var_3;
    level waittill( "solar_reflector_player_removed" );
    maps\mp\_utility::_objective_delete( var_4 );
    maps\mp\_utility::_objective_delete( var_5 );
}

_id_1364( var_0, var_1 )
{
    waitframe();
    var_1 playloopsound( level._id_8862 );
    var_0 playloopsound( level._id_8861 );
    playsoundatpos( var_0.origin, "array_beam_start" );
    level waittill( "solar_reflector_player_removed" );
    playsoundatpos( var_0.origin, "array_beam_stop" );
    var_1 stoploopsound();
    var_0 stoploopsound();
}

_id_76C4()
{
    var_0 = common_scripts\utility::getstruct( "solar_cam_pos", "targetname" );
    var_1 = common_scripts\utility::getstruct( "solar_beam_pos", "targetname" );
    var_2 = common_scripts\utility::getstruct( "solar_ground_pos", "targetname" );
    var_3 = _id_3FB1( var_2 );
    var_4 = _id_3F1F( var_0, var_2 );
    thread _id_6D45( var_4 );
    var_5 = _id_3F11( var_1, var_2 );
    thread _id_1362( var_3 );
    thread _id_1364( var_4, var_3 );
    _id_76C5( var_5, var_4, var_3 );
    var_5.killcament delete();
    var_5 delete();
    var_4 delete();
    var_3 delete();
}

_id_3F1F( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2.angles = vectortoangles( var_1.origin - var_0.origin );
    var_2 setmodel( "tag_player" );
    return var_2;
}

_id_3FB1( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1.angles = ( 0.0, 0.0, 0.0 );
    var_1 setmodel( "tag_origin" );
    return var_1;
}

_id_6D45( var_0 )
{
    var_0 endon( "death" );
    self _meth_807E( var_0, "tag_player", 1.0, 40, 40, 12, 10 );
    self setangles( var_0 gettagangles( "tag_player" ) );
    self setclientomnvar( "fov_scale", 0.2 );
    self thermalvisionfofoverlayon();

    for (;;)
    {
        self _meth_80FE( 0.05, 0.05 );
        level waittill( "host_migration_begin" );
        waitframe();
        self setclientomnvar( "fov_scale", 0.2 );
        self thermalvisionfofoverlayon();
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }
}

_id_3F11( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2.angles = vectortoangles( var_1.origin - var_0.origin );
    var_2 setmodel( "tag_laser" );
    var_2 laseron( "solar_laser" );
    var_3 = anglestoforward( var_2.angles ) * 5000 - ( 0.0, 0.0, 100.0 );
    var_4 = spawn( "script_model", var_0.origin + var_3 );
    var_4.angles = var_2.angles;
    var_4 linkto( var_2 );
    var_2.killcament = var_4;
    return var_2;
}

_id_1361( var_0 )
{
    var_0 endon( "death" );
    var_1 = undefined;

    for (;;)
    {
        waitframe();

        if ( !isdefined( var_0._id_0423 ) )
            continue;

        var_2 = _id_1360( var_0._id_0423 );

        if ( !isdefined( var_1 ) || var_1 != var_2 )
        {
            if ( isdefined( var_1 ) )
                stopfxontag( var_1, var_0, "tag_origin" );

            playfxontag( var_2, var_0, "tag_origin" );
            var_1 = var_2;
        }
    }
}

_id_1360( var_0 )
{
    switch ( var_0 )
    {
        case "water":
        case "water_waist":
            return common_scripts\utility::getfx( "steam_column_rising" );
        default:
            return common_scripts\utility::getfx( "fx_flare_solar" );
    }
}

_id_76C5( var_0, var_1, var_2 )
{
    self endon( "solar_reflector_player_removed" );
    var_3 = 300;
    var_4 = 20000;
    var_5 = spawnstruct();
    var_5.origin = var_2.origin;
    var_6 = 0;

    for (;;)
    {
        var_7 = self getangles();
        var_7 = ( var_7[0], var_7[1], 0 );
        var_9 = anglestoforward( var_7 );
        var_10 = abs( ( var_1.origin[2] - var_5.origin[2] ) / var_9[2] );
        var_11 = var_1.origin + var_9 * var_10;
        var_12 = distance2d( var_11, var_5.origin );

        if ( var_12 <= var_3 * 0.05 )
            var_5.origin = var_11;
        else
        {
            var_13 = var_11 - var_5.origin;
            var_13 = vectornormalize( var_13 );
            var_5.origin += var_13 * var_3 * 0.05;
        }

        var_14 = vectornormalize( var_5.origin - var_0.origin );
        var_0 _meth_82B5( vectortoangles( var_14 ), 0.1 );
        var_15 = var_0.origin;
        var_16 = var_15 + var_14 * var_4;
        var_17 = bullettrace( var_15, var_16, 0 );
        var_2 moveto( var_17["position"], 0.1 );
        var_2._id_0423 = var_17["surfacetype"];
        var_2.killcament = var_0.killcament;
        var_2 entityradiusdamage( var_2.origin, 128, 8, 2, self, "MOD_EXPLOSIVE", "killstreak_solar_mp" );
        waitframe();
    }
}

_id_4652()
{
    self.shouldloopdamagefeedback = 1;
    self.damagefeedbacktimer = 10;
    self playlocalsound( "MP_solar_hit_alert" );
    self _meth_80AE( "damage_light" );

    while ( self.damagefeedbacktimer > 0 )
    {
        self.damagefeedbacktimer--;
        wait 0.05;
    }

    self stoprumble( "damage_light" );
    self stoplocalsound( "MP_solar_hit_alert" );
    self.shouldloopdamagefeedback = undefined;
}

_id_73D9()
{
    self endon( "solar_reflector_player_removed" );

    for (;;)
    {
        var_0 = 0;

        while ( self usebuttonpressed() )
        {
            var_0 += 0.05;

            if ( var_0 > 0.75 )
            {
                level thread _id_73D7( self );
                return;
            }

            waitframe();
        }

        waitframe();
    }
}

_id_73DA()
{
    self endon( "solar_reflector_player_removed" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "spawned", "killstreak_exit" );
    level thread _id_73D7( self );
}

_id_73D6()
{
    self endon( "solar_reflector_player_removed" );
    level waittill( "game_cleanup" );
    level thread _id_73D7( self );
}

_id_73D8( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    wait 1;

    if ( maps\mp\_utility::_hasperk( "specialty_blackbox" ) && isdefined( self._id_8A32 ) )
        var_0 *= self._id_8A32;

    thread _id_8866( var_0 );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    level thread _id_73D7( self );
}

_id_8866( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    var_1 = gettime() + var_0 * 1000;

    for (;;)
    {
        self setclientomnvar( "ui_solar_beam_timer", var_1 );
        level waittill( "host_migration_begin" );
        var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_1 += var_2;
    }
}

_id_73D7( var_0 )
{
    var_0 notify( "solar_reflector_player_removed" );
    level notify( "solar_reflector_player_removed" );
    waittillframeend;

    if ( isdefined( var_0 ) )
    {
        var_0 maps\mp\_utility::clearusingremote();
        var_0 show();
        var_0 unlink();
        var_0 thermalvisionfofoverlayoff();
        var_0 setblurforplayer( 0, 0 );
        var_0 setclientomnvar( "ui_solar_beam", 0 );
        var_0 _meth_80FF();
        var_0 setclientomnvar( "fov_scale", 1 );
    }

    level._id_8860 = undefined;
}

overlay()
{
    self endon( "disconnect" );
    level endon( "solar_reflector_player_removed" );
    wait 1;
    self setblurforplayer( 1.2, 0 );
    self setclientomnvar( "ui_solar_beam", 1 );
}

onplayerconnect()
{
    level notify( "solarOnPlayerConnect" );
    level endon( "solarOnPlayerConnect" );
    level endon( "solar_reflector_player_removed" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.prekilledfunc = ::_id_6D26;
        var_0 thread onplayerspawned();
        var_0 thread _id_6CC8();
    }
}

onplayerspawned()
{
    level notify( "solarOnPlayerSpawned" );
    level endon( "solarOnPlayerSpawned" );
    level endon( "solar_reflector_player_removed" );

    for (;;)
    {
        self waittill( "player_spawned" );
        self.hideondeath = undefined;
    }
}

_id_8325()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) || var_1 == level._id_8860 )
            continue;

        var_1.prekilledfunc = ::_id_6D26;
        var_1 thread onplayerspawned();
    }
}

_id_6D25()
{
    self.hideondeath = 1;
    var_0 = ( 0.0, 0.0, 30.0 );
    var_1 = self getstance();

    if ( var_1 == "crouch" )
        var_0 = ( 0.0, 0.0, 20.0 );
    else if ( var_1 == "prone" )
        var_0 = ( 0.0, 0.0, 10.0 );

    playfx( common_scripts\utility::getfx( "solar_killstreak_death" ), self.origin + var_0 );
}

_id_6D26( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( var_5 == "killstreak_solar_mp" )
        _id_6D25();
}

_id_6CC8()
{
    self endon( "disconnect" );
    self._id_8864 = 1;
    wait 5;
    self._id_8864 = undefined;
}

_id_1365( var_0 )
{
    level endon( "solar_reflector_player_removed" );
    var_1 = spawnfx( level._id_885D, ( 0.0, 0.0, 0.0 ) );
    var_2 = ( 0.0, 0.0, 0.0 );
    var_3 = gettime();

    for (;;)
    {
        waitframe();
        var_4 = _func_220( var_0.origin, var_2 );
        var_5 = ( var_3 - gettime() ) / 1000;

        if ( var_4 > 2500 || var_5 > 5 )
        {
            var_2 = var_0.origin;

            if ( !isdefined( var_0._id_0423 ) || !maps\mp\_utility::isstrstart( var_0._id_0423, "water_" ) )
                level thread _id_37CA( var_2, self );

            var_3 = gettime();
        }
    }
}

_id_37CA( var_0, var_1 )
{
    playfx( level._id_885D, var_0 );
    var_2 = gettime() + 5000;

    while ( gettime() < var_2 )
    {
        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4._id_8864 ) )
                continue;

            if ( var_4.origin[2] < var_0[2] - 5 )
                continue;

            if ( var_4.origin[2] > var_0[2] + 80 )
                continue;

            var_5 = _func_220( var_4.origin, var_0 );

            if ( var_5 < 4900 )
                var_4 dodamage( 4, var_0, var_1, var_1, "MOD_EXPLOSIVE", "killstreak_solar_mp" );
        }

        wait 0.1;
    }
}
