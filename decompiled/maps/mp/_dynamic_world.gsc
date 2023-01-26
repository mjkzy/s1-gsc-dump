// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate_slow", "targetname" ), ::_id_3668, "veryslow" );
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate", "targetname" ), ::_id_3668, "slow" );
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate_fast", "targetname" ), ::_id_3668, "fast" );
    var_0 = [];
    var_0["trigger_multiple_dyn_metal_detector"] = ::_id_5BB7;
    var_0["trigger_multiple_dyn_creaky_board"] = ::_id_2395;
    var_0["trigger_multiple_dyn_photo_copier"] = ::_id_67EC;
    var_0["trigger_multiple_dyn_copier_no_light"] = ::_id_67F0;
    var_0["trigger_radius_motion_light"] = ::_id_5EEE;
    var_0["trigger_radius_dyn_motion_dlight"] = ::_id_65B4;
    var_0["trigger_multiple_dog_bark"] = ::_id_2C90;
    var_0["trigger_radius_bird_startle"] = ::_id_147F;
    var_0["trigger_multiple_dyn_motion_light"] = ::_id_5EEE;
    var_0["trigger_multiple_dyn_door"] = ::_id_9768;
    _id_6B56();

    foreach ( var_4, var_2 in var_0 )
    {
        var_3 = getentarray( var_4, "classname" );
        common_scripts\utility::array_thread( var_3, ::triggertouchthink );
        common_scripts\utility::array_thread( var_3, var_2 );
    }

    common_scripts\utility::array_thread( getentarray( "vending_machine", "targetname" ), ::_id_9D7B );
    common_scripts\utility::array_thread( getentarray( "toggle", "targetname" ), ::_id_9BE2 );
    common_scripts\utility::array_thread( getentarray( "sliding_door", "targetname" ), ::_id_8622 );
    level thread onplayerconnect();
    var_5 = getent( "civilian_jet_origin", "targetname" );

    if ( isdefined( var_5 ) )
        var_5 thread _id_1DD1();

    thread _id_4EA1();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connecting", var_0 );
        var_0 thread _id_5F5C();
    }
}

_id_6B56()
{
    if ( common_scripts\utility::issp() )
    {
        foreach ( var_1 in level.players )
        {
            var_1.touchtriggers = [];
            var_1 thread _id_5F5C();
        }
    }
}

_id_08ED()
{
    self.touchtriggers = [];
    thread _id_5F5C();
}

_id_1DD1()
{
    level endon( "game_ended" );
    _id_5234();
    level waittill( "prematch_over" );

    for (;;)
    {
        thread _id_523F();
        self waittill( "start_flyby" );
        thread _id_5232();
        self waittill( "flyby_done" );
        _id_5239();
    }
}

_id_5234()
{
    self._id_5237 = getentarray( self.target, "targetname" );
    self._id_5233 = getent( "civilian_jet_flyto", "targetname" );
    self._id_32D1 = getentarray( "engine_fx", "targetname" );
    self._id_389D = getentarray( "flash_fx", "targetname" );
    self._id_522B = loadfx( "fx/fire/jet_afterburner" );
    self._id_522F = loadfx( "vfx/lights/aircraft_light_wingtip_red" );
    self._id_522E = loadfx( "vfx/lights/aircraft_light_wingtip_green" );
    self._id_522D = loadfx( "vfx/lights/aircraft_light_red_blink" );
    level._id_1E10 = undefined;
    var_0 = vectornormalize( self.origin - self._id_5233.origin ) * 20000;
    self._id_5233.origin -= var_0;
    self.origin += var_0;

    foreach ( var_2 in self._id_5237 )
    {
        var_2.origin += var_0;
        var_2._id_63AE = var_2.origin;
        var_2 hide();
    }

    foreach ( var_5 in self._id_32D1 )
        var_5.origin += var_0;

    foreach ( var_8 in self._id_389D )
        var_8.origin += var_0;

    var_10 = self.origin;
    var_11 = self._id_5233.origin;
    self._id_5231 = var_11 - var_10;
    var_12 = 2000;
    var_13 = abs( distance( var_10, var_11 ) );
    self._id_5230 = var_13 / var_12;
}

_id_5239()
{
    foreach ( var_1 in self._id_5237 )
    {
        var_1.origin = var_1._id_63AE;
        var_1 hide();
    }
}

_id_523F()
{
    level endon( "game_ended" );
    var_0 = _id_4128();
    var_1 = max( 10, var_0 );
    var_1 = min( var_1, 100 );

    if ( getdvar( "jet_flyby_timer" ) != "" )
        level._id_1E11 = 5 + getdvarint( "jet_flyby_timer" );
    else
        level._id_1E11 = ( 0.25 + randomfloatrange( 0.3, 0.7 ) ) * 60 * var_1;

    wait(level._id_1E11);

    while ( isdefined( level._id_099C ) || isdefined( level._id_06D1 ) || isdefined( level.chopper ) || isdefined( level.remotemissileinprogress ) )
        wait 0.05;

    self notify( "start_flyby" );
    level._id_1E10 = 1;
    self waittill( "flyby_done" );
    level._id_1E10 = undefined;
}

_id_4128()
{
    if ( common_scripts\utility::issp() )
        return 10.0;

    if ( isdefined( game["status"] ) && game["status"] == "overtime" )
        return 1.0;
    else
        return getwatcheddvar( "timelimit" );
}

getwatcheddvar( var_0 )
{
    var_0 = "scr_" + level.gametype + "_" + var_0;

    if ( isdefined( level.overridewatchdvars ) && isdefined( level.overridewatchdvars[var_0] ) )
        return level.overridewatchdvars[var_0];

    return level.watchdvars[var_0].value;
}

_id_5232()
{
    foreach ( var_1 in self._id_5237 )
        var_1 show();

    var_3 = [];
    var_4 = [];

    foreach ( var_6 in self._id_32D1 )
    {
        var_7 = spawn( "script_model", var_6.origin );
        var_7 setmodel( "tag_origin" );
        var_7.angles = var_6.angles;
        var_3[var_3.size] = var_7;
    }

    foreach ( var_10 in self._id_389D )
    {
        var_11 = spawn( "script_model", var_10.origin );
        var_11 setmodel( "tag_origin" );
        var_11.color = var_10.script_noteworthy;
        var_11.angles = var_10.angles;
        var_4[var_4.size] = var_11;
    }

    thread _id_5238( self._id_5237[0], level.mapcenter );
    wait 0.05;

    foreach ( var_7 in var_3 )
        playfxontag( self._id_522B, var_7, "tag_origin" );

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.color ) && var_11.color == "blink" )
        {
            playfxontag( self._id_522D, var_11, "tag_origin" );
            continue;
        }

        if ( isdefined( var_11.color ) && var_11.color == "red" )
        {
            playfxontag( self._id_522F, var_11, "tag_origin" );
            continue;
        }

        playfxontag( self._id_522E, var_11, "tag_origin" );
    }

    foreach ( var_1 in self._id_5237 )
        var_1 moveto( var_1.origin + self._id_5231, self._id_5230 );

    foreach ( var_7 in var_3 )
        var_7 moveto( var_7.origin + self._id_5231, self._id_5230 );

    foreach ( var_11 in var_4 )
        var_11 moveto( var_11.origin + self._id_5231, self._id_5230 );

    wait(self._id_5230 + 1);

    foreach ( var_7 in var_3 )
        var_7 delete();

    foreach ( var_11 in var_4 )
        var_11 delete();

    self notify( "flyby_done" );
}

_id_5238( var_0, var_1 )
{
    var_0 thread _id_6DD6( "veh_mig29_dist_loop" );

    while ( !_id_91CA( var_0, var_1 ) )
        wait 0.05;

    var_0 thread _id_6DD6( "veh_mig29_close_loop" );

    while ( _id_91CB( var_0, var_1 ) )
        wait 0.05;

    wait 0.5;
    var_0 thread _id_6DD5( "veh_mig29_sonic_boom" );

    while ( _id_91CA( var_0, var_1 ) )
        wait 0.05;

    var_0 notify( "stop soundveh_mig29_close_loop" );
    self waittill( "flyby_done" );
    var_0 notify( "stop soundveh_mig29_dist_loop" );
}

_id_6DD5( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0.0, 0.0, 1.0 ) );
    var_3 hide();

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    var_3.origin = var_1;

    if ( isdefined( var_2 ) && var_2 )
        var_3 playsoundasmaster( var_0 );
    else
        var_3 playsound( var_0 );

    wait 10.0;
    var_3 delete();
}

_id_6DD6( var_0, var_1 )
{
    var_2 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_2 hide();
    var_2 endon( "death" );
    thread common_scripts\utility::delete_on_death( var_2 );

    if ( isdefined( var_1 ) )
    {
        var_2.origin = self.origin + var_1;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }
    else
    {
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_2 stoploopsound( var_0 );
    var_2 delete();
}

_id_91CB( var_0, var_1 )
{
    var_2 = anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) );
    var_3 = vectornormalize( common_scripts\utility::flat_origin( var_1 ) - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0 )
        return 1;
    else
        return 0;
}

_id_91CA( var_0, var_1 )
{
    var_2 = _id_91CB( var_0, var_1 );

    if ( var_2 )
        var_3 = 1;
    else
        var_3 = -1;

    var_4 = common_scripts\utility::flat_origin( var_0.origin );
    var_5 = var_4 + anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) ) * ( var_3 * 100000 );
    var_6 = pointonsegmentnearesttopoint( var_4, var_5, var_1 );
    var_7 = distance( var_4, var_6 );

    if ( var_7 < 3000 )
        return 1;
    else
        return 0;
}

_id_9D7B()
{
    level endon( "game_ended" );
    self endon( "death" );
    self setcursorhint( "HINT_ACTIVATE" );
    self._id_9EBE = getent( self.target, "targetname" );
    var_0 = getent( self._id_9EBE.target, "targetname" );
    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    self._id_9EBB = var_2.origin;
    var_3 = getent( var_2.target, "targetname" );
    self._id_9EBC = var_3.origin;

    if ( isdefined( var_3.target ) )
        self._id_9EB5 = getent( var_3.target, "targetname" ).origin;

    self._id_9EBE setcandamage( 1 );
    self._id_9EBF = self._id_9EBE.model;
    self._id_9EB2 = self._id_9EBE.script_noteworthy;
    self._id_9EC5 = var_0.model;
    self._id_9EC7 = var_0.origin;
    self._id_9EC6 = var_0.angles;
    self._id_9EC9 = var_1.origin;
    self._id_9EC8 = var_1.angles;
    precachemodel( self._id_9EB2 );
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
    self._id_8853 = [];
    self._id_8856 = 12;
    self._id_8857 = undefined;
    self._id_4AA1 = 400;
    thread _id_9D7C( self._id_9EBE );
    self playloopsound( "vending_machine_hum" );

    for (;;)
    {
        self waittill( "trigger", var_4 );
        self playsound( "vending_machine_button_press" );

        if ( !self._id_8856 )
            continue;

        if ( isdefined( self._id_8857 ) )
            _id_8855();

        _id_8854( _id_894E() );
        wait 0.05;
    }
}

_id_9D7C( var_0 )
{
    level endon( "game_ended" );
    var_1 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
    var_2 = loadfx( "fx/explosions/tv_explosion" );

    for (;;)
    {
        var_3 = undefined;
        var_4 = undefined;
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
        var_0 waittill( "damage", var_3, var_4, var_5, var_6, var_7 );

        if ( isdefined( var_7 ) )
        {
            if ( issubstr( var_1, tolower( var_7 ) ) )
                var_3 *= 3;

            self._id_4AA1 -= var_3;

            if ( self._id_4AA1 > 0 )
                continue;

            self notify( "death" );
            self.origin += ( 0.0, 0.0, 10000.0 );

            if ( !isdefined( self._id_9EB5 ) )
                var_8 = self._id_9EBE.origin + ( 37.0, -31.0, 52.0 );
            else
                var_8 = self._id_9EB5;

            playfx( var_2, var_8 );
            self._id_9EBE setmodel( self._id_9EB2 );

            while ( self._id_8856 > 0 )
            {
                if ( isdefined( self._id_8857 ) )
                    _id_8855();

                _id_8854( _id_894E() );
                wait 0.05;
            }

            self stoploopsound( "vending_machine_hum" );
            return;
        }
    }
}

_id_894E()
{
    var_0 = spawn( "script_model", self._id_9EC7 );
    var_0 setmodel( self._id_9EC5 );
    var_0.origin = self._id_9EC7;
    var_0.angles = self._id_9EC6;
    return var_0;
}

_id_8854( var_0 )
{
    var_0 moveto( self._id_9EC9, 0.2 );
    var_0 playsound( "vending_machine_soda_drop" );
    wait 0.2;
    self._id_8857 = var_0;
    self._id_8856--;
}

_id_8855()
{
    self endon( "death" );

    if ( isdefined( self._id_8857._id_3021 ) && self._id_8857._id_3021 == 1 )
        return;

    var_0 = 1;
    var_1 = var_0 * -999;
    var_2 = int( 40000 );
    var_3 = ( int( var_2 / 2 ), int( var_2 / 2 ), 0 ) - ( randomint( var_2 ), randomint( var_2 ), 0 );
    var_4 = vectornormalize( self._id_9EBC - self._id_9EBB + var_3 );
    var_5 = var_4 * randomfloatrange( var_1, var_0 );
    self._id_8857 _meth_82C2( self._id_9EBB, var_5 );
    self._id_8857._id_3021 = 1;
}

_id_3A25()
{
    level endon( "game_ended" );
    var_0 = "briefcase_bomb_mp";
    precacheitem( var_0 );

    for (;;)
    {
        self waittill( "trigger_enter", var_1 );

        if ( !var_1 hasweapon( var_0 ) )
        {
            var_1 playsound( "freefall_death" );
            var_1 giveweapon( var_0 );
            var_1 setweaponammostock( var_0, 0 );
            var_1 setweaponammoclip( var_0, 0 );
            var_1 switchtoweapon( var_0 );
        }
    }
}

_id_5BB7()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );
    var_0 _meth_81B3();
    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    var_3 = getent( var_2.target, "targetname" );
    var_4 = getent( var_3.target, "targetname" );
    var_5 = [];
    var_6 = min( var_1.origin[0], var_2.origin[0] );
    var_5[0] = var_6;
    var_7 = max( var_1.origin[0], var_2.origin[0] );
    var_5[1] = var_7;
    var_8 = min( var_1.origin[1], var_2.origin[1] );
    var_5[2] = var_8;
    var_9 = max( var_1.origin[1], var_2.origin[1] );
    var_5[3] = var_9;
    var_10 = min( var_1.origin[2], var_2.origin[2] );
    var_5[4] = var_10;
    var_11 = max( var_1.origin[2], var_2.origin[2] );
    var_5[5] = var_11;
    var_1 delete();
    var_2 delete();

    if ( !common_scripts\utility::issp() )
        self._id_09B3 = 7;
    else
        self._id_09B3 = 2;

    self._id_09B7 = 0;
    self._id_09AF = 0;
    self._id_93D9 = 0;
    thread _id_5BB8( var_0 );
    thread _id_5BB9();
    thread _id_5BBA( var_5, "weapon_claymore", "weapon_c4" );
    var_12 = ( var_3.origin[0], var_3.origin[1], var_11 );
    var_13 = ( var_4.origin[0], var_4.origin[1], var_11 );
    var_14 = loadfx( "fx/props/metal_detector_light" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "dmg_triggered", "touch_triggered", "weapon_triggered" );
        thread _id_6DD4( "alarm_metal_detector", var_14, var_12, var_13 );
    }
}

_id_6DD4( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( !self._id_09B7 )
    {
        self._id_09B7 = 1;
        thread _id_0C92();

        if ( !self._id_09AF )
            self playsound( var_0 );

        playfx( var_1, var_2 );
        playfx( var_1, var_3 );
        wait(self._id_09B3);
        self._id_09B7 = 0;
    }
}

_id_0C92()
{
    level endon( "game_ended" );

    if ( !self._id_93D9 )
        return;

    var_0 = self._id_09B3 + 0.15;

    if ( self._id_93D9 )
        self._id_93D9--;
    else
        self._id_09AF = 1;

    var_1 = gettime();
    var_2 = 7;

    if ( common_scripts\utility::issp() )
        var_2 = 2;

    _id_A066( "dmg_triggered", "touch_triggered", "weapon_triggered", var_2 + 2 );
    var_3 = gettime() - var_1;

    if ( var_3 > var_2 * 1000 + 1150 )
    {
        self._id_09AF = 0;
        self._id_93D9 = 0;
    }
}

_id_A066( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self endon( var_0 );
    self endon( var_1 );
    self endon( var_2 );
    wait(var_3);
}

_id_5BBA( var_0, var_1, var_2 )
{
    level endon( "game_ended" );

    for (;;)
    {
        _id_A0C1();
        var_3 = getentarray( "grenade", "classname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.model ) && ( var_5.model == var_1 || var_5.model == var_2 ) )
            {
                if ( _id_511E( var_5, var_0 ) )
                    thread _id_A2BF( var_5, var_0 );
            }
        }
    }
}

_id_A0C1()
{
    level endon( "game_ended" );
    self endon( "dmg_triggered" );
    self waittill( "touch_triggered" );
}

_id_A2BF( var_0, var_1 )
{
    var_0 endon( "death" );

    while ( _id_511E( var_0, var_1 ) )
    {
        self notify( "weapon_triggered" );
        wait(self._id_09B3);
    }
}

_id_511E( var_0, var_1 )
{
    var_2 = var_1[0];
    var_3 = var_1[1];
    var_4 = var_1[2];
    var_5 = var_1[3];
    var_6 = var_1[4];
    var_7 = var_1[5];
    var_8 = var_0.origin[0];
    var_9 = var_0.origin[1];
    var_10 = var_0.origin[2];

    if ( _id_511F( var_8, var_2, var_3 ) )
    {
        if ( _id_511F( var_9, var_4, var_5 ) )
        {
            if ( _id_511F( var_10, var_6, var_7 ) )
                return 1;
        }
    }

    return 0;
}

_id_511F( var_0, var_1, var_2 )
{
    if ( var_0 > var_1 && var_0 < var_2 )
        return 1;

    return 0;
}

_id_5BB8( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( isdefined( var_5 ) && _id_09BD( var_5 ) )
            self notify( "dmg_triggered" );
    }
}

_id_5BB9()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( _id_0C9B( self ) )
        {
            self notify( "touch_triggered" );
            wait(self._id_09B3);
        }
    }
}

_id_09BD( var_0 )
{
    var_1 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
    var_2 = strtok( var_1, " " );

    foreach ( var_4 in var_2 )
    {
        if ( tolower( var_4 ) == tolower( var_0 ) )
            return 1;
    }

    return 0;
}

_id_2395()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter", var_0 );
        var_0 thread _id_2BB9( self );
    }
}

_id_2BB9( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self playsound( "step_walk_plr_woodcreak_on" );

    for (;;)
    {
        self waittill( "trigger_leave", var_1 );

        if ( var_0 != var_1 )
            continue;

        self playsound( "step_walk_plr_woodcreak_off" );
        return;
    }
}

_id_5EEE()
{
    level endon( "game_ended" );
    self._id_5F92 = 1;
    self._id_575B = 0;
    var_0 = getentarray( self.target, "targetname" );
    common_scripts\utility::noself_array_call( [ "com_two_light_fixture_off", "com_two_light_fixture_on" ], ::precachemodel );

    foreach ( var_2 in var_0 )
    {
        var_2._id_5740 = [];
        var_3 = getent( var_2.target, "targetname" );

        if ( !isdefined( var_3.target ) )
            continue;

        var_2._id_5740 = getentarray( var_3.target, "targetname" );
    }

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( _id_0C9B( self ) )
        {
            var_5 = 0;

            foreach ( var_7 in self.touchlist )
            {
                if ( isdefined( var_7._id_2B7E ) && var_7._id_2B7E > 5.0 )
                    var_5 = 1;
            }

            if ( var_5 )
            {
                if ( !self._id_575B )
                {
                    self._id_575B = 1;
                    var_0[0] playsound( "switch_auto_lights_on" );

                    foreach ( var_2 in var_0 )
                    {
                        var_2 _meth_81DF( 1.0 );

                        if ( isdefined( var_2._id_5740 ) )
                        {
                            foreach ( var_11 in var_2._id_5740 )
                                var_11 setmodel( "com_two_light_fixture_on" );
                        }
                    }
                }

                thread _id_5EEF( var_0, 10.0 );
            }

            wait 0.05;
        }
    }
}

_id_5EEF( var_0, var_1 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait(var_1);

    foreach ( var_3 in var_0 )
    {
        var_3 _meth_81DF( 0 );

        if ( isdefined( var_3._id_5740 ) )
        {
            foreach ( var_5 in var_3._id_5740 )
                var_5 setmodel( "com_two_light_fixture_off" );
        }
    }

    var_0[0] playsound( "switch_auto_lights_off" );
    self._id_575B = 0;
}

_id_65B4()
{
    if ( !isdefined( level._id_65B6 ) )
        level._id_65B6 = loadfx( "vfx/lights/outdoor_motion_light" );

    level endon( "game_ended" );
    self._id_5F92 = 1;
    self._id_575B = 0;
    var_0 = getent( self.target, "targetname" );
    var_1 = getentarray( var_0.target, "targetname" );
    common_scripts\utility::noself_array_call( [ "com_two_light_fixture_off", "com_two_light_fixture_on" ], ::precachemodel );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( _id_0C9B( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self.touchlist )
            {
                if ( isdefined( var_4._id_2B7E ) && var_4._id_2B7E > 5.0 )
                    var_2 = 1;
            }

            if ( var_2 )
            {
                if ( !self._id_575B )
                {
                    self._id_575B = 1;
                    var_0 playsound( "switch_auto_lights_on" );
                    var_0 setmodel( "com_two_light_fixture_on" );

                    foreach ( var_7 in var_1 )
                    {
                        var_7._id_5713 = spawn( "script_model", var_7.origin );
                        var_7._id_5713 setmodel( "tag_origin" );
                        playfxontag( level._id_65B6, var_7._id_5713, "tag_origin" );
                    }
                }

                thread _id_65B5( var_0, var_1, 10.0 );
            }

            wait 0.05;
        }
    }
}

_id_65B5( var_0, var_1, var_2 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait(var_2);

    foreach ( var_4 in var_1 )
        var_4._id_5713 delete();

    var_0 playsound( "switch_auto_lights_off" );
    var_0 setmodel( "com_two_light_fixture_off" );
    self._id_575B = 0;
}

_id_2C90()
{
    level endon( "game_ended" );
    self._id_5F92 = 1;
    var_0 = getent( self.target, "targetname" );

    for (;;)
    {
        self waittill( "trigger_enter", var_1 );

        while ( _id_0C9B( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self.touchlist )
            {
                if ( isdefined( var_4._id_2B7E ) && var_4._id_2B7E > var_2 )
                    var_2 = var_4._id_2B7E;
            }

            if ( var_2 > 6.0 )
            {
                var_0 playsound( "dyn_anml_dog_bark" );
                wait(randomfloatrange( 16 / var_2, 16 / var_2 + randomfloat( 1.0 ) ));
                continue;
            }

            wait 0.05;
        }
    }
}

_id_9768()
{
    var_0 = getent( self.target, "targetname" );
    self._id_2D5D = var_0;
    self._id_2D5B = _id_414F( vectornormalize( self getorigin() - var_0 getorigin() ) );
    var_0._id_131A = var_0.angles[1];
    var_1 = 1.0;

    for (;;)
    {
        self waittill( "trigger_enter", var_2 );
        var_0 thread _id_2D67( var_1, _id_3F6A( var_2 ) );

        if ( _id_0C9B( self ) )
            self waittill( "trigger_empty" );

        wait 3.0;

        if ( _id_0C9B( self ) )
            self waittill( "trigger_empty" );

        var_0 thread _id_2D5C( var_1 );
    }
}

_id_2D67( var_0, var_1 )
{
    if ( var_1 )
        self _meth_82B5( ( 0, self._id_131A + 90, 1 ), var_0, 0.1, 0.75 );
    else
        self _meth_82B5( ( 0, self._id_131A - 90, 1 ), var_0, 0.1, 0.75 );

    self playsound( "door_generic_house_open" );
    wait(var_0 + 0.05);
}

_id_2D5C( var_0 )
{
    self _meth_82B5( ( 0, self._id_131A, 1 ), var_0 );
    self playsound( "door_generic_house_close" );
    wait(var_0 + 0.05);
}

_id_3F6A( var_0 )
{
    return vectordot( self._id_2D5B, vectornormalize( var_0.origin - self._id_2D5D getorigin() ) ) > 0;
}

_id_414F( var_0 )
{
    return ( var_0[1], 0 - var_0[0], var_0[2] );
}

_id_9BE2()
{
    if ( self.classname != "trigger_use_touch" )
        return;

    var_0 = getentarray( self.target, "targetname" );
    self._id_575B = 1;

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 1.5 * self._id_575B );

    for (;;)
    {
        self waittill( "trigger" );
        self._id_575B = !self._id_575B;

        if ( self._id_575B )
        {
            foreach ( var_2 in var_0 )
                var_2 _meth_81DF( 1.5 );

            self playsound( "switch_auto_lights_on" );
            continue;
        }

        foreach ( var_2 in var_0 )
            var_2 _meth_81DF( 0 );

        self playsound( "switch_auto_lights_off" );
    }
}

_id_147F()
{

}

_id_67EE( var_0 )
{
    self._id_21CE = _id_3E1B( var_0 );

    if ( isdefined( self._id_21CE ) )
    {
        var_1 = getent( self._id_21CE.target, "targetname" );

        if ( isdefined( var_1 ) )
        {
            var_2 = getent( var_1.target, "targetname" );

            if ( isdefined( var_2 ) )
            {
                var_2._id_4E9B = var_2 _meth_81DE();
                var_2 _meth_81DF( 0 );
                var_0._id_21D4 = var_1;
                var_0._id_8C3B = var_1.origin;
                var_0._id_0255 = var_2;
                var_3 = self._id_21CE.angles + ( 0.0, 90.0, 0.0 );
                var_4 = anglestoforward( var_3 );
                var_0._id_313D = var_0._id_8C3B + var_4 * 30;
            }
        }
    }
}

_id_3E1B( var_0 )
{
    if ( !isdefined( var_0.target ) )
    {
        var_1 = getentarray( "destructible_toy", "targetname" );
        var_2 = var_1[0];

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4.destructible_type ) && var_4.destructible_type == "toy_copier" )
            {
                if ( distance( var_0.origin, var_2.origin ) > distance( var_0.origin, var_4.origin ) )
                    var_2 = var_4;
            }
        }
    }
    else
    {
        var_2 = getent( var_0.target, "targetname" );

        if ( isdefined( var_2 ) )
            var_2 setcandamage( 1 );
    }

    return var_2;
}

_id_A071()
{
    if ( !isdefined( self._id_21CE ) )
        return;

    self._id_21CE endon( "FX_State_Change0" );
    self._id_21CE endon( "death" );
    self waittill( "trigger_enter" );
}

_id_67EC()
{
    level endon( "game_ended" );
    _id_67EE( self );

    if ( !isdefined( self._id_21CE ) )
        return;

    self._id_21CE endon( "FX_State_Change0" );
    thread _id_67F1();

    for (;;)
    {
        _id_A071();
        self playsound( "mach_copier_run" );

        if ( isdefined( self._id_21D4 ) )
        {
            _id_7424( self );
            thread _id_67ED();
            thread _id_67EF();
        }

        wait 3;
    }
}

_id_67F0()
{
    level endon( "game_ended" );
    self endon( "death" );

    if ( common_scripts\utility::get_template_level() == "hamburg" )
        return;

    self._id_21CE = _id_3E1B( self );

    if ( !isdefined( self._id_21CE ) )
        return;

    self._id_21CE endon( "FX_State_Change0" );

    for (;;)
    {
        _id_A071();
        self playsound( "mach_copier_run" );
        wait 3;
    }
}

_id_7424( var_0 )
{
    var_0._id_21D4 moveto( var_0._id_8C3B, 0.2 );
    var_0._id_0255 _meth_81DF( 0 );
}

_id_67ED()
{
    self._id_21CE notify( "bar_goes" );
    self._id_21CE endon( "bar_goes" );
    self._id_21CE endon( "FX_State_Change0" );
    self._id_21CE endon( "death" );
    var_0 = self._id_21D4;
    wait 2.0;
    var_0 moveto( self._id_313D, 1.6 );
    wait 1.8;
    var_0 moveto( self._id_8C3B, 1.6 );
    wait 1.6;
    var_1 = self._id_0255;
    var_2 = 0.2;
    var_3 = var_2 / 0.05;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_4 * 0.05;
        var_5 /= var_2;
        var_5 = 1 - var_5 * var_1._id_4E9B;

        if ( var_5 > 0 )
            var_1 _meth_81DF( var_5 );

        wait 0.05;
    }
}

_id_67EF()
{
    self._id_21CE notify( "light_on" );
    self._id_21CE endon( "light_on" );
    self._id_21CE endon( "FX_State_Change0" );
    self._id_21CE endon( "death" );
    var_0 = self._id_0255;
    var_1 = 0.2;
    var_2 = var_1 / 0.05;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_3 * 0.05;
        var_4 /= var_1;
        var_0 _meth_81DF( var_4 * var_0._id_4E9B );
        wait 0.05;
    }

    _id_67F2( var_0 );
}

_id_67F1()
{
    self._id_21CE waittill( "FX_State_Change0" );
    self._id_21CE endon( "death" );
    _id_7424( self );
}

_id_67F2( var_0 )
{
    var_0 _meth_81DF( 1 );
    wait 0.05;
    var_0 _meth_81DF( 0 );
    wait 0.1;
    var_0 _meth_81DF( 1 );
    wait 0.05;
    var_0 _meth_81DF( 0 );
    wait 0.1;
    var_0 _meth_81DF( 1 );
}

_id_3668( var_0 )
{
    var_1 = 0;
    var_2 = 20000;
    var_3 = 1.0;

    if ( isdefined( self._id_03E3 ) )
        var_3 = self._id_03E3;

    if ( var_0 == "slow" )
    {
        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
            var_1 = 180;
        else
            var_1 = randomfloatrange( 100 * var_3, 360 * var_3 );
    }
    else if ( var_0 == "fast" )
        var_1 = randomfloatrange( 720 * var_3, 1000 * var_3 );
    else if ( var_0 == "veryslow" )
        var_1 = randomfloatrange( 1 * var_3, 2 * var_3 );
    else
    {

    }

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
        wait 0;
    else
        wait(randomfloatrange( 0, 1 ));

    if ( !isdefined( self ) )
        return;

    var_4 = self.angles;
    var_5 = anglestoright( self.angles ) * 100;
    var_5 = vectornormalize( var_5 );

    for (;;)
    {
        var_6 = abs( vectordot( var_5, ( 1.0, 0.0, 0.0 ) ) );
        var_7 = abs( vectordot( var_5, ( 0.0, 1.0, 0.0 ) ) );
        var_8 = abs( vectordot( var_5, ( 0.0, 0.0, 1.0 ) ) );

        if ( var_6 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_7 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_8 > 0.9 )
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );
        else
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );

        wait(var_2);
    }
}

triggertouchthink( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self.entnum = self getentitynumber();

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) && !isdefined( var_2._id_3795 ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2.touchtriggers[self.entnum] ) )
            var_2 thread _id_6D6E( self, var_0, var_1 );
    }
}

_id_6D6E( var_0, var_1, var_2 )
{
    var_0 endon( "deleted" );

    if ( !isplayer( self ) )
        self endon( "death" );

    if ( !common_scripts\utility::issp() )
        var_3 = self.guid;
    else
        var_3 = "player" + gettime();

    var_0.touchlist[var_3] = self;

    if ( isdefined( var_0._id_5F92 ) )
        self._id_5F93++;

    var_0 notify( "trigger_enter", self );
    self notify( "trigger_enter", var_0 );

    if ( isdefined( var_1 ) )
        self thread [[ var_1 ]]( var_0 );

    self.touchtriggers[var_0.entnum] = var_0;

    while ( isalive( self ) && self istouching( var_0 ) && ( common_scripts\utility::issp() || !level.gameended ) )
        wait 0.05;

    if ( isdefined( self ) )
    {
        self.touchtriggers[var_0.entnum] = undefined;

        if ( isdefined( var_0._id_5F92 ) )
            self._id_5F93--;

        self notify( "trigger_leave", var_0 );

        if ( isdefined( var_2 ) )
            self thread [[ var_2 ]]( var_0 );
    }

    if ( !common_scripts\utility::issp() && level.gameended )
        return;

    var_0.touchlist[var_3] = undefined;
    var_0 notify( "trigger_leave", self );

    if ( !_id_0C9B( var_0 ) )
        var_0 notify( "trigger_empty" );
}

_id_5F5C()
{
    if ( isdefined( level._id_2B1C ) )
        return;

    self endon( "disconnect" );

    if ( !isplayer( self ) )
        self endon( "death" );

    self._id_5F93 = 0;
    self._id_2B7E = 0;

    for (;;)
    {
        self waittill( "trigger_enter" );
        var_0 = self.origin;

        while ( self._id_5F93 )
        {
            self._id_2B7E = distance( var_0, self.origin );
            var_0 = self.origin;
            wait 0.05;
        }

        self._id_2B7E = 0;
    }
}

_id_0C9B( var_0 )
{
    return var_0.touchlist.size;
}

_id_6D6D( var_0, var_1 )
{
    return isdefined( var_0.touchtriggers[var_1.entnum] );
}

_id_4EA1()
{
    var_0 = getentarray( "interactive_tv", "targetname" );

    if ( var_0.size )
    {
        common_scripts\utility::noself_array_call( [ "com_tv2_d", "com_tv1_d", "com_tv1", "com_tv2", "com_tv1_testpattern", "com_tv2_testpattern" ], ::precachemodel );
        level._id_17DD["tv_explode"] = loadfx( "fx/explosions/tv_explosion" );
    }

    level._id_99CA = getentarray( "interactive_tv_light", "targetname" );
    common_scripts\utility::array_thread( getentarray( "interactive_tv", "targetname" ), ::_id_99CB );
}

_id_99CB()
{
    self setcandamage( 1 );
    self._id_25A6 = undefined;
    self._id_6375 = undefined;
    self._id_25A6 = "com_tv2_d";
    self._id_6375 = "com_tv2";
    self._id_64B9 = "com_tv2_testpattern";

    if ( issubstr( self.model, "1" ) )
    {
        self._id_6375 = "com_tv1";
        self._id_64B9 = "com_tv1_testpattern";
    }

    if ( isdefined( self.target ) )
    {
        if ( isdefined( level._id_2AAE ) )
        {
            var_0 = getent( self.target, "targetname" );

            if ( isdefined( var_0 ) )
                var_0 delete();
        }
        else
        {
            self._id_9C12 = getent( self.target, "targetname" );
            self._id_9C12 _meth_817B();
            self._id_9C12 setcursorhint( "HINT_NOICON" );
        }
    }

    var_1 = common_scripts\utility::get_array_of_closest( self.origin, level._id_99CA, undefined, undefined, 64 );

    if ( var_1.size )
    {
        self._id_57A4 = var_1[0];
        level._id_99CA = common_scripts\utility::array_remove( level._id_99CA, self._id_57A4 );
        self._id_57A6 = self._id_57A4 _meth_81DE();
    }

    thread _id_99C7();

    if ( isdefined( self._id_9C12 ) )
        thread _id_99CE();
}

_id_99CE()
{
    self._id_9C12 endon( "death" );

    for (;;)
    {
        wait 0.2;
        self._id_9C12 waittill( "trigger" );
        self notify( "off" );

        if ( self.model == self._id_6375 )
        {
            self setmodel( self._id_64B9 );

            if ( isdefined( self._id_57A4 ) )
                self._id_57A4 _meth_81DF( self._id_57A6 );

            continue;
        }

        self setmodel( self._id_6375 );

        if ( isdefined( self._id_57A4 ) )
            self._id_57A4 _meth_81DF( 0 );
    }
}

_id_99C7()
{
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );
    self notify( "off" );

    if ( isdefined( self._id_9C12 ) )
        self._id_9C12 notify( "death" );

    self setmodel( self._id_25A6 );

    if ( isdefined( self._id_57A4 ) )
        self._id_57A4 _meth_81DF( 0 );

    playfxontag( level._id_17DD["tv_explode"], self, "tag_fx" );
    self playsound( "tv_shot_burst" );

    if ( isdefined( self._id_9C12 ) )
        self._id_9C12 delete();
}

_id_8622()
{
    if ( !isdefined( self._id_6519 ) )
        self._id_6519 = 1;

    var_0 = getentarray( self.target, "script_linkname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_origin" )
        {
            var_1[var_1.size] = var_3;
            continue;
        }

        var_3 _id_2D45( self._id_6519 );
    }

    var_0 = common_scripts\utility::array_remove_array( var_0, var_1 );

    for (;;)
    {
        if ( !isdefined( level.characters ) )
        {
            wait 1;
            continue;
        }

        var_5 = vehicle_getarray();
        var_6 = common_scripts\utility::array_combine( level.characters, var_5 );
        var_7 = 0;

        foreach ( var_9 in var_6 )
        {
            if ( isdefined( var_9.team ) && var_9.team == "spectator" || isdefined( var_9.sessionstate ) && var_9.sessionstate == "spectator" )
                continue;

            if ( var_9 istouching( self ) )
            {
                var_7++;
                break;
            }
        }

        if ( var_7 > 0 )
            _id_6501( var_0 );
        else
        {
            var_11 = 1;
            thread _id_1FCD( var_0, var_11 );
        }

        wait 0.05;
    }
}

_id_2D45( var_0 )
{
    self._id_8C3C = self.origin;
    self._id_8623 = "closed";
    var_1 = getent( self.target, "targetname" );
    self._id_6514 = var_1.origin;
    self._id_651B = distance( self._id_6514, self.origin ) / var_0;
}

_id_6501( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( var_2._id_8623 == "open" || var_2._id_8623 == "opening" )
            continue;

        var_2 thread _id_6506();
    }
}

_id_6506()
{
    self._id_8623 = "opening";
    var_0 = distance( self.origin, self._id_6514 ) / self._id_651B;

    if ( var_0 < 0.05 )
        var_0 = 0.05;

    self moveto( self._id_6514, var_0 );
    self playsound( "glass_door_open" );
    wait(var_0);
    self._id_8623 = "open";
}

_id_1FCD( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( var_3._id_8623 == "closed" || var_3._id_8623 == "opening" )
            continue;

        var_3 moveto( var_3._id_8C3C, var_1 );
        self playsound( "glass_door_close" );
        var_3._id_8623 = "closed";
    }
}
