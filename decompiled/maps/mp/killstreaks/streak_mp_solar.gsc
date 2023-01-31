// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.solar_killstreak_duration = 30;
    level.solar_fire_fx = loadfx( "vfx/fire/fire_xsglow_runner_5s" );
    level.solar_reflector_sfx = "mp_solar_array_player";
    level.solar_reflector_target_sfx = "mp_solar_array_target";
    level.killstreakfuncs["mp_solar"] = ::tryusesolarreflector;
    level.mapkillstreak = "mp_solar";
    level.mapkillstreakpickupstring = &"MP_SOLAR_MAP_KILLSTREAK_PICKUP";
    level.mapkillstreakdamagefeedbacksound = ::handledamagefeedbacksound;
    level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
    level.killstreakwieldweapons["killstreak_solar_mp"] = "mp_solar";
}

setupbotsformapkillstreak()
{
    level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func( "mp_solar", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use );
}

tryusesolarreflector( var_0, var_1 )
{
    if ( isdefined( level.solar_reflector_player ) )
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
    var_2 = setsolarreflectorplayer( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_solar", self.origin );
    else if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    return isdefined( var_2 ) && var_2;
}

setsolarreflectorplayer( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    level.solar_reflector_player = var_0;
    thread maps\mp\_utility::teamplayercardsplash( "used_mp_solar", var_0 );
    thread onplayerconnect();
    thread setupplayerdeath();
    var_0 thread overlay();
    var_0 thread runbeam();
    var_0 thread removesolarreflectorplayeraftertime( level.solar_killstreak_duration );
    var_0 thread removesolarreflectorplayerwatch();
    var_0 thread removesolarreflectorlevelwatch();
    var_0 thread removesolarreflectorplayeroncommand();
    return 1;
}

beamminimap( var_0 )
{
    var_1 = "compassping_orbitallaser_friendly";
    var_2 = "compassping_orbitallaser_hostile";
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "invisible", ( 0, 0, 0 ) );
    objective_onentity( var_3, var_0 );
    objective_state( var_3, "active" );

    if ( level.teambased )
        objective_team( var_3, self.team );
    else
        objective_player( var_3, self _meth_81B1() );

    objective_icon( var_3, var_1 );
    var_4 = var_3;
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "invisible", ( 0, 0, 0 ) );
    objective_onentity( var_3, var_0 );
    objective_state( var_3, "active" );

    if ( level.teambased )
        objective_team( var_3, level.otherteam[self.team] );
    else
        objective_playerenemyteam( var_3, self _meth_81B1() );

    objective_icon( var_3, var_2 );
    var_5 = var_3;
    level waittill( "solar_reflector_player_removed" );
    maps\mp\_utility::_objective_delete( var_4 );
    maps\mp\_utility::_objective_delete( var_5 );
}

beamsounds( var_0, var_1 )
{
    waitframe();
    var_1 _meth_8075( level.solar_reflector_target_sfx );
    var_0 _meth_8075( level.solar_reflector_sfx );
    playsoundatpos( var_0.origin, "array_beam_start" );
    level waittill( "solar_reflector_player_removed" );
    playsoundatpos( var_0.origin, "array_beam_stop" );
    var_1 _meth_80AB();
    var_0 _meth_80AB();
}

runbeam()
{
    var_0 = common_scripts\utility::getstruct( "solar_cam_pos", "targetname" );
    var_1 = common_scripts\utility::getstruct( "solar_beam_pos", "targetname" );
    var_2 = common_scripts\utility::getstruct( "solar_ground_pos", "targetname" );
    var_3 = getgroundent( var_2 );
    var_4 = getcameraent( var_0, var_2 );
    thread playersetcamera( var_4 );
    var_5 = getbeament( var_1, var_2 );
    thread beamminimap( var_3 );
    thread beamsounds( var_4, var_3 );
    runbeamupdate( var_5, var_4, var_3 );
    var_5.killcament delete();
    var_5 delete();
    var_4 delete();
    var_3 delete();
}

getcameraent( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2.angles = vectortoangles( var_1.origin - var_0.origin );
    var_2 _meth_80B1( "tag_player" );
    return var_2;
}

getgroundent( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1.angles = ( 0, 0, 0 );
    var_1 _meth_80B1( "tag_origin" );
    return var_1;
}

playersetcamera( var_0 )
{
    var_0 endon( "death" );
    self _meth_807E( var_0, "tag_player", 1.0, 40, 40, 12, 10 );
    self setangles( var_0 gettagangles( "tag_player" ) );
    self _meth_82FB( "fov_scale", 0.2 );
    self thermalvisionfofoverlayon();

    for (;;)
    {
        self _meth_80FE( 0.05, 0.05 );
        level waittill( "host_migration_begin" );
        waitframe();
        self _meth_82FB( "fov_scale", 0.2 );
        self thermalvisionfofoverlayon();
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }
}

getbeament( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2.angles = vectortoangles( var_1.origin - var_0.origin );
    var_2 _meth_80B1( "tag_laser" );
    var_2 _meth_80B2( "solar_laser" );
    var_3 = anglestoforward( var_2.angles ) * 5000 - ( 0, 0, 100 );
    var_4 = spawn( "script_model", var_0.origin + var_3 );
    var_4.angles = var_2.angles;
    var_4 _meth_804D( var_2 );
    var_2.killcament = var_4;
    return var_2;
}

beamgroundfx( var_0 )
{
    var_0 endon( "death" );
    var_1 = undefined;

    for (;;)
    {
        waitframe();

        if ( !isdefined( var_0.surfacetype ) )
            continue;

        var_2 = beamgetgroundfx( var_0.surfacetype );

        if ( !isdefined( var_1 ) || var_1 != var_2 )
        {
            if ( isdefined( var_1 ) )
                stopfxontag( var_1, var_0, "tag_origin" );

            playfxontag( var_2, var_0, "tag_origin" );
            var_1 = var_2;
        }
    }
}

beamgetgroundfx( var_0 )
{
    switch ( var_0 )
    {
        case "water_waist":
        case "water":
            return common_scripts\utility::getfx( "steam_column_rising" );
        default:
            return common_scripts\utility::getfx( "fx_flare_solar" );
    }
}

runbeamupdate( var_0, var_1, var_2 )
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
        var_2 _meth_82AE( var_17["position"], 0.1 );
        var_2.surfacetype = var_17["surfacetype"];
        var_2.killcament = var_0.killcament;
        var_2 entityradiusdamage( var_2.origin, 128, 8, 2, self, "MOD_EXPLOSIVE", "killstreak_solar_mp" );
        waitframe();
    }
}

handledamagefeedbacksound()
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

    self _meth_80AF( "damage_light" );
    self stoplocalsound( "MP_solar_hit_alert" );
    self.shouldloopdamagefeedback = undefined;
}

removesolarreflectorplayeroncommand()
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
                level thread removesolarreflectorplayer( self );
                return;
            }

            waitframe();
        }

        waitframe();
    }
}

removesolarreflectorplayerwatch()
{
    self endon( "solar_reflector_player_removed" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "spawned", "killstreak_exit" );
    level thread removesolarreflectorplayer( self );
}

removesolarreflectorlevelwatch()
{
    self endon( "solar_reflector_player_removed" );
    level waittill( "game_cleanup" );
    level thread removesolarreflectorplayer( self );
}

removesolarreflectorplayeraftertime( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    wait 1;

    if ( maps\mp\_utility::_hasperk( "specialty_blackbox" ) && isdefined( self.specialty_blackbox_bonus ) )
        var_0 *= self.specialty_blackbox_bonus;

    thread solarrelectortimer( var_0 );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    level thread removesolarreflectorplayer( self );
}

solarrelectortimer( var_0 )
{
    self endon( "solar_reflector_player_removed" );
    var_1 = gettime() + var_0 * 1000;

    for (;;)
    {
        self _meth_82FB( "ui_solar_beam_timer", var_1 );
        level waittill( "host_migration_begin" );
        var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_1 += var_2;
    }
}

removesolarreflectorplayer( var_0 )
{
    var_0 notify( "solar_reflector_player_removed" );
    level notify( "solar_reflector_player_removed" );
    waittillframeend;

    if ( isdefined( var_0 ) )
    {
        var_0 maps\mp\_utility::clearusingremote();
        var_0 show();
        var_0 _meth_804F();
        var_0 thermalvisionfofoverlayoff();
        var_0 setblurforplayer( 0, 0 );
        var_0 _meth_82FB( "ui_solar_beam", 0 );
        var_0 _meth_80FF();
        var_0 _meth_82FB( "fov_scale", 1 );
    }

    level.solar_reflector_player = undefined;
}

overlay()
{
    self endon( "disconnect" );
    level endon( "solar_reflector_player_removed" );
    wait 1;
    self setblurforplayer( 1.2, 0 );
    self _meth_82FB( "ui_solar_beam", 1 );
}

onplayerconnect()
{
    level notify( "solarOnPlayerConnect" );
    level endon( "solarOnPlayerConnect" );
    level endon( "solar_reflector_player_removed" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.prekilledfunc = ::playerprekilled;
        var_0 thread onplayerspawned();
        var_0 thread playerimmunetofire();
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

setupplayerdeath()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) || var_1 == level.solar_reflector_player )
            continue;

        var_1.prekilledfunc = ::playerprekilled;
        var_1 thread onplayerspawned();
    }
}

playerplayvaporizefx()
{
    self.hideondeath = 1;
    var_0 = ( 0, 0, 30 );
    var_1 = self _meth_817C();

    if ( var_1 == "crouch" )
        var_0 = ( 0, 0, 20 );
    else if ( var_1 == "prone" )
        var_0 = ( 0, 0, 10 );

    playfx( common_scripts\utility::getfx( "solar_killstreak_death" ), self.origin + var_0 );
}

playerprekilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( var_5 == "killstreak_solar_mp" )
        playerplayvaporizefx();
}

playerimmunetofire()
{
    self endon( "disconnect" );
    self.solarimmunefire = 1;
    wait 5;
    self.solarimmunefire = undefined;
}

beamstartfires( var_0 )
{
    level endon( "solar_reflector_player_removed" );
    var_1 = spawnfx( level.solar_fire_fx, ( 0, 0, 0 ) );
    var_2 = ( 0, 0, 0 );
    var_3 = gettime();

    for (;;)
    {
        waitframe();
        var_4 = _func_220( var_0.origin, var_2 );
        var_5 = ( var_3 - gettime() ) / 1000;

        if ( var_4 > 2500 || var_5 > 5 )
        {
            var_2 = var_0.origin;

            if ( !isdefined( var_0.surfacetype ) || !maps\mp\_utility::isstrstart( var_0.surfacetype, "water_" ) )
                level thread fireatposition( var_2, self );

            var_3 = gettime();
        }
    }
}

fireatposition( var_0, var_1 )
{
    playfx( level.solar_fire_fx, var_0 );
    var_2 = gettime() + 5000;

    while ( gettime() < var_2 )
    {
        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4.solarimmunefire ) )
                continue;

            if ( var_4.origin[2] < var_0[2] - 5 )
                continue;

            if ( var_4.origin[2] > var_0[2] + 80 )
                continue;

            var_5 = _func_220( var_4.origin, var_0 );

            if ( var_5 < 4900 )
                var_4 _meth_8051( 4, var_0, var_1, var_1, "MOD_EXPLOSIVE", "killstreak_solar_mp" );
        }

        wait 0.1;
    }
}
