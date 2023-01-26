// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["airstrike_ground"] = loadfx( "vfx/explosion/clusterbomb_explode" );
    level._effect["airstrike_bombs"] = loadfx( "vfx/explosion/vfx_clusterbomb" );
    level._effect["airstrike_death"] = loadfx( "vfx/explosion/vehicle_warbird_explosion_midair" );
    level._effect["airstrike_engine"] = loadfx( "vfx/fire/jet_afterburner" );
    level._effect["airstrike_wingtip"] = loadfx( "vfx/trail/jet_contrail" );
    level._id_46DC = [];
    level.planes = [];
    level.artillerydangercenters = [];
    level._id_25ED["strafing_run_airstrike"] = 900;
    level._id_25EE["strafing_run_airstrike"] = 750;
    level._id_25EC["strafing_run_airstrike"] = 1;
    level._id_25EF["strafing_run_airstrike"] = 6.0;
    level.killstreakfuncs["strafing_run_airstrike"] = ::_id_98C8;
    level.killstreakwieldweapons["stealth_bomb_mp"] = "strafing_run_airstrike";
    level.killstreakwieldweapons["airstrike_missile_mp"] = "strafing_run_airstrike";
    level.killstreakwieldweapons["orbital_carepackage_pod_plane_mp"] = "strafing_run_airstrike";
}

_id_98C8( var_0, var_1 )
{
    return _id_98A2( var_0, "strafing_run_airstrike", var_1 );
}

_id_98A2( var_0, var_1, var_2 )
{
    if ( isdefined( level._id_8F19 ) )
    {
        self iclientprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    var_3 = _id_7C5B( var_0, var_1, var_2 );

    if ( !isdefined( var_3 ) || !var_3 )
        return 0;

    return 1;
}

_id_2BE2( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( level._id_099C ) )
    {
        while ( isdefined( level._id_099C ) )
            level waittill( "begin_airstrike" );

        level._id_099C = 1;
        wait 2.0;
    }

    if ( !isdefined( var_3 ) )
        return;

    level._id_099C = 1;
    var_7 = _id_2F92( var_1, var_3 );
    var_8 = spawnstruct();
    var_8.origin = var_7;
    var_8.forward = anglestoforward( ( 0, var_2, 0 ) );
    var_8.streakname = var_5;
    var_8.team = var_4;
    level.artillerydangercenters[level.artillerydangercenters.size] = var_8;
    var_9 = _id_1A0B( var_0, var_3, var_7, var_2, var_5, var_6 );
    wait 1.0;
    level._id_099C = undefined;
    var_3 notify( "begin_airstrike" );
    level notify( "begin_airstrike" );
    wait 7.5;
    var_10 = 0;
    var_11 = [];

    for ( var_12 = 0; var_12 < level.artillerydangercenters.size; var_12++ )
    {
        if ( !var_10 && level.artillerydangercenters[var_12].origin == var_7 )
        {
            var_10 = 1;
            continue;
        }

        var_11[var_11.size] = level.artillerydangercenters[var_12];
    }

    level.artillerydangercenters = var_11;
}

_id_1EFD( var_0 )
{
    wait 2.0;
    level._id_099C = undefined;
}

getairstrikedanger( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level.artillerydangercenters.size; var_2++ )
    {
        var_3 = level.artillerydangercenters[var_2].origin;
        var_4 = level.artillerydangercenters[var_2].forward;
        var_5 = level.artillerydangercenters[var_2].streakname;
        var_1 += _id_40C8( var_0, var_3, var_4, var_5 );
    }

    return var_1;
}

_id_40C8( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 + level._id_25EC[var_3] * level._id_25ED[var_3] * var_2;
    var_5 = var_0 - var_4;
    var_5 = ( var_5[0], var_5[1], 0 );
    var_6 = vectordot( var_5, var_2 ) * var_2;
    var_7 = var_5 - var_6;
    var_8 = var_7 + var_6 / level._id_25EF[var_3];
    var_9 = lengthsquared( var_8 );

    if ( var_9 > level._id_25ED[var_3] * level._id_25ED[var_3] )
        return 0;

    if ( var_9 < level._id_25EE[var_3] * level._id_25EE[var_3] )
        return 1;

    var_10 = sqrt( var_9 );
    var_11 = ( var_10 - level._id_25EE[var_3] ) / ( level._id_25ED[var_3] - level._id_25EE[var_3] );
    return 1 - var_11;
}

_id_6E24( var_0, var_1, var_2, var_3 )
{
    return distance2d( var_0, var_1 ) <= level._id_25ED[var_3] * 1.25;
}

_id_70D3( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = level.players;

    foreach ( var_7 in level.players )
    {
        if ( !isalive( var_7 ) )
            continue;

        if ( var_7.team == var_4 || var_7.team == "spectator" )
            continue;

        var_8 = var_7.origin + ( 0.0, 0.0, 32.0 );
        var_9 = distance( var_0, var_8 );

        if ( var_9 > var_1 )
            continue;

        var_10 = int( var_2 + ( var_3 - var_2 ) * var_9 / var_1 );
        var_7 thread _id_0D34( "default", var_10 );
    }
}

_id_0D34( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( isdefined( self._id_13A9 ) && self._id_13A9 )
        return;

    self._id_13A9 = 1;
    self shellshock( var_0, var_1 );
    wait(var_1 + 1);
    self._id_13A9 = 0;
}

_id_153F( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "crashing" );
    var_2 = spawnstruct();
    var_2._id_9BF3 = [];
    var_2._id_2385 = [];
    _id_A038( var_0 );
    wait 0.1;
    var_3 = gettime();
    var_2._id_2385[0] = _id_83E8( var_0, var_1, var_2 );
    var_4 = gettime();
    var_5 = 0.1 - ( var_4 - var_3 ) / 1000;

    if ( var_5 > 0 )
        wait(var_5);

    var_3 = gettime();
    var_2._id_2385[1] = _id_83E8( var_0, var_1, var_2 );
    var_4 = gettime();
    var_5 = 0.1 - ( var_4 - var_3 ) / 1000;

    if ( var_5 > 0 )
        wait(var_5);

    var_2._id_2385[2] = _id_83E8( var_0, var_1, var_2 );
}

_id_83E8( var_0, var_1, var_2 )
{
    var_3 = _id_2F92( var_0.origin, var_0 );
    var_4 = _id_377A( var_3, var_0, var_2, var_0._id_2F91, var_1 );

    if ( !isdefined( var_4 ) )
    {
        var_4 = spawnstruct();
        var_4.origin = var_3;
    }

    var_5 = var_0.origin + ( 0.0, 0.0, -5.0 );
    return maps\mp\killstreaks\_orbital_carepackage::_id_37E1( "orbital_carepackage_pod_plane_mp", var_1, var_4, "airdrop_assault", [], undefined, var_5, var_2._id_2385, 0 );
}

_id_2F92( var_0, var_1 )
{
    var_2 = var_0;
    var_3 = var_2 + ( 0.0, 0.0, -1000000.0 );
    var_4 = bullettrace( var_2, var_3, 0, var_1 );

    for ( var_5 = var_4["entity"]; isdefined( var_5 ) && isdefined( var_5.vehicletype ); var_5 = var_4["entity"] )
    {
        waitframe();
        var_2 = var_4["position"];
        var_4 = bullettrace( var_2, var_3, 0, var_5 );
    }

    return var_4["position"];
}

withinothercarepackagenodes( var_0, var_1 )
{
    var_2 = 26;
    var_3 = var_2 * 2;
    var_4 = var_3 * var_3;

    foreach ( var_6 in var_1._id_9BF3 )
    {
        var_7 = _func_220( var_6.origin, var_0 );

        if ( var_7 < var_4 )
            return 1;
    }

    return 0;
}

_id_377A( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 4;
    var_6 = 5;
    var_7 = var_1.origin;
    var_8 = getnodesinradiussorted( var_3, 300, 0, 1000 );
    var_9 = undefined;

    foreach ( var_11 in var_8 )
    {
        if ( var_5 <= 0 )
            break;

        if ( !_func_20C( var_11, 1 ) )
            continue;

        if ( common_scripts\utility::array_contains( var_2._id_9BF3, var_11 ) )
            continue;

        if ( withinothercarepackagenodes( var_11.origin, var_2 ) )
            continue;

        var_12 = var_11.origin + ( 0.0, 0.0, 5.0 );
        var_13 = var_4;

        if ( !isdefined( var_13 ) )
            var_13 = var_1;

        var_2._id_9BF3[var_2._id_9BF3.size] = var_11;

        if ( bullettracepassed( var_7, var_12, 0, var_1 ) && maps\mp\killstreaks\_orbital_util::_id_1B9F( var_11.origin, var_13, "carepackage" ) )
        {
            var_9 = var_11;
            break;
        }

        var_6--;

        if ( var_6 <= 0 )
        {
            var_5--;
            var_6 = 5;
            waitframe();
        }
    }

    return var_9;
}

_id_2BE4( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !common_scripts\utility::array_contains( var_6, "strafing_run_airstrike_two" ) )
        thread _id_8986( var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1 );
    else
    {
        var_7 = spawnstruct();
        _id_3ED9( var_3, var_4, var_7 );
        thread _id_8986( var_0, var_1, var_2, var_7._id_8D30, var_4, var_5, var_6, 1 );
        wait 1;
        thread _id_8986( var_0, var_1, var_2, var_7._id_8D31, var_4, var_5, var_6, 0 );
    }
}

_id_3ED9( var_0, var_1, var_2 )
{
    var_3 = anglestoright( var_1 );
    var_2._id_8D30 = var_0 + var_3 * 500;
    var_2._id_8D31 = var_0 + var_3 * -1 * 500;
}

_id_8986( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = "compass_objpoint_airstrike_busy";

    if ( common_scripts\utility::array_contains( var_6, "strafing_run_airstrike_stealth" ) )
        var_8 = "compass_objpoint_b2_airstrike_enemy";

    var_9 = spawn( "script_model", var_3 );
    var_9.angles = var_4;
    var_9 setmodel( "vehicle_airplane_shrike" );
    var_9._id_5C73 = spawnplane( var_1, "script_model", var_3, "compass_objpoint_airstrike_friendly", var_8 );
    var_9._id_5C73 setmodel( "tag_origin" );
    var_9._id_5C73 linktosynchronizedparent( var_9, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_9.modules = var_6;
    var_9.vehicletype = "strafing_run";
    _id_081C( var_9 );
    var_9 setcandamage( 1 );
    var_9 setcanradiusdamage( 1 );
    var_9 thread maps\mp\gametypes\_damage::setentitydamagecallback( 1000, undefined, ::_id_644B, maps\mp\killstreaks\_aerial_utility::_id_47D3, 1 );

    if ( common_scripts\utility::array_contains( var_9.modules, "strafing_run_airstrike_flares" ) )
        var_9 thread _id_099A();

    var_9 thread _id_4653();
    var_9 playloopsound( "bombrun_jet_dist_loop" );
    var_9.lifeid = var_0;
    var_9.owner = var_1;
    var_9.team = var_1.team;
    var_9._id_2F91 = var_2;
    var_9._id_3306 = 1;
    var_9 thread _id_6878( var_2 );
    var_9 thread _id_687A();
    thread _id_8E12( var_9, var_5 );

    if ( common_scripts\utility::array_contains( var_9.modules, "strafing_run_airstrike_package" ) )
        thread _id_153F( var_9, var_1 );
    else
        thread _id_153E( var_9, var_1 );

    if ( level.teambased && var_7 )
        level thread _id_464F( var_9, var_1 );

    var_9 endon( "death" );
    var_9 endon( "crashing" );
    _id_A038( var_9 );
    var_9._id_3306 = 0;
    var_9 waittill( "pathComplete" );
    level._id_8F19 = undefined;
    var_9 notify( "airstrike_complete" );
    _id_73CE( var_9 );
    var_9 waittillmatch( "airstrike", "end" );
    var_9 notify( "delete" );

    if ( isdefined( var_9._id_5C73 ) )
        var_9._id_5C73 delete();

    var_9 delete();
}

planehandlehostmigration()
{
    self endon( "airstrike_complete" );
    self endon( "pathComplete" );

    for (;;)
    {
        level waittill( "host_migration_begin" );
        self _meth_84BD( 1 );
        level waittill( "host_migration_end" );
        self _meth_84BD( 0 );
    }
}

_id_6878( var_0 )
{
    self endon( "airstrike_complete" );
    self scriptmodelplayanimdeltamotion( "strafing_run_ks_flyby", "airstrike" );
    thread planehandlehostmigration();
    self.status = "flying_in";
    self._id_392F = 3333.33;
    wait 3;
    self.status = "strike";
    self._id_392F = 1000.0;
    wait 10;
    self.status = "flying_out";
    self._id_392F = 3333.33;
    wait 2.9;
    self notify( "pathComplete" );
}

_id_099A()
{
    self._id_629D = 4;
    thread maps\mp\killstreaks\_aerial_utility::handleincomingstinger();
}

_id_644B( var_0, var_1, var_2, var_3 )
{
    thread _id_235F();
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "strafing_run_destroyed", undefined, "callout_destroyed_airstrike", 1 );
}

_id_235F()
{
    self notify( "crashing" );
    self._id_2359 = 1;
}

_id_153E( var_0, var_1 )
{
    var_0 endon( "airstrike_complete" );

    while ( !_id_91CA( var_0, var_0._id_2F91, 5000 ) )
        wait 0.05;

    var_2 = 1;
    var_3 = 0;
    var_0 notify( "start_bombing" );
    var_0 thread _id_6A2F();

    for ( var_4 = _id_91C4( var_0, var_0._id_2F91 ); var_4 < 5000; var_4 = _id_91C4( var_0, var_0._id_2F91 ) )
    {
        if ( var_4 < 1500 && !var_3 )
            var_3 = 1;

        var_2 = !var_2;

        if ( var_4 < 4500 )
            var_0 thread _id_1A0C( var_0.origin, var_1, ( 0.0, 0.0, 0.0 ), var_2 );

        wait 0.1;
    }

    var_0 notify( "stop_bombing" );
    level._id_8F19 = undefined;
}

_id_6A2F()
{
    self endon( "stop_bombing" );
    self endon( "airstrike_complete" );
    self._id_1532 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    self._id_1532 setmodel( "tag_origin" );
    self._id_1532 linkto( self, "bombaydoor_left_jnt", ( 0.0, 0.0, 0.0 ), ( 0.0, -90.0, 0.0 ) );
    self._id_1533 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    self._id_1533 setmodel( "tag_origin" );
    self._id_1533 linkto( self, "bombaydoor_right_jnt", ( 0.0, 0.0, 0.0 ), ( 0.0, -90.0, 0.0 ) );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "airstrike_bombs" ), self._id_1532, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "airstrike_bombs" ), self._id_1533, "tag_origin" );
        wait 0.5;
    }
}

_id_8E12( var_0, var_1 )
{
    var_0 endon( "airstrike_complete" );
    var_0 waittill( "start_bombing" );
    var_2 = anglestoforward( var_0.angles );
    var_3 = spawn( "script_model", var_0.origin + ( 0.0, 0.0, 100.0 ) - var_2 * 200 );
    var_0.killcament = var_3;
    var_0.killcament setscriptmoverkillcam( "airstrike" );
    var_0._id_099E = var_1;
    var_3.starttime = gettime();
    var_3 thread _id_2844( 16.0 );
    var_3 linkto( var_0, "tag_origin", ( -256.0, 768.0, 768.0 ), ( 0.0, 0.0, 0.0 ) );
}

_id_1A0C( var_0, var_1, var_2, var_3 )
{
    self endon( "airstrike_complete" );

    if ( !isdefined( var_1 ) || var_1 maps\mp\_utility::isemped() || var_1 maps\mp\_utility::isairdenied() )
    {
        self notify( "stop_bombing" );
        return;
    }

    var_4 = 512;
    var_5 = ( 0, randomint( 360 ), 0 );
    var_6 = var_0 + anglestoforward( var_5 ) * randomfloat( var_4 );
    var_7 = bullettrace( var_6, var_6 + ( 0.0, 0.0, -10000.0 ), 0, self );
    var_6 = var_7["position"];
    var_8 = distance( var_0, var_6 );

    if ( var_8 > 10000 )
        return;

    wait(0.85 * var_8 / 2000);

    if ( !isdefined( var_1 ) || var_1 maps\mp\_utility::isemped() || var_1 maps\mp\_utility::isairdenied() )
    {
        self notify( "stop_bombing" );
        return;
    }

    if ( var_3 )
    {
        playfx( common_scripts\utility::getfx( "airstrike_ground" ), var_6 );
        level thread maps\mp\gametypes\_shellshock::stealthairstrike_earthquake( var_6 );
    }

    thread maps\mp\_utility::playsoundinspace( "bombrun_snap", var_6 );
    _id_70D3( var_6, 512, 8, 4, var_1.team );
    self entityradiusdamage( var_6 + ( 0.0, 0.0, 16.0 ), 896, 300, 50, var_1, "MOD_EXPLOSIVE", "stealth_bomb_mp" );

    if ( isdefined( level.ishorde ) && level.ishorde && isdefined( level.flying_attack_drones ) )
    {
        foreach ( var_10 in level.flying_attack_drones )
        {
            if ( var_10.origin[2] > var_6[2] - 24 && var_10.origin[2] < var_6[2] + 1000 && _func_220( var_10.origin, var_6 ) < 90000 )
                var_10 dodamage( randomintrange( 50, 300 ), var_6 + ( 0.0, 0.0, 16.0 ), var_1, var_1, "MOD_EXPLOSIVE", "stealth_bomb_mp" );
        }
    }
}

_id_4653( var_0 )
{
    level endon( "game_ended" );
    self endon( "delete" );
    common_scripts\utility::waittill_either( "death", "crashing" );
    var_1 = anglestoforward( self.angles );
    playfx( common_scripts\utility::getfx( "airstrike_death" ), self.origin, var_1 );
    maps\mp\_utility::playsoundinspace( "bombrun_air_death", self.origin );
    self notify( "airstrike_complete" );
    _id_73CE( self );
    level._id_8F19 = undefined;

    if ( isdefined( self._id_5C73 ) )
        self._id_5C73 delete();

    self delete();
}

_id_081C( var_0 )
{
    level.planes[level.planes.size] = var_0;
}

_id_73CE( var_0 )
{
    level.planes = common_scripts\utility::array_remove( level.planes, var_0 );
}

_id_2844( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self delete();
}

_id_687A()
{
    self endon( "airstrike_complete" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "airstrike_engine" ), self, "tag_engine_right" );
    playfxontag( common_scripts\utility::getfx( "airstrike_engine" ), self, "tag_engine_left" );
    playfxontag( common_scripts\utility::getfx( "airstrike_wingtip" ), self, "tag_right_wingtip" );
    playfxontag( common_scripts\utility::getfx( "airstrike_wingtip" ), self, "tag_left_wingtip" );
}

_id_1A0B( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    thread maps\mp\_utility::teamplayercardsplash( "used_strafing_run_airstrike", var_1, var_1.team );
    var_6 = _id_4084();
    var_1 endon( "disconnect" );
    var_7 = ( 0, var_3, 0 );
    var_8 = _id_3F9A( var_2, var_7, var_6 );
    level thread _id_2BE4( var_0, var_1, var_2, var_8, var_7, var_4, var_5 );
}

_id_4084()
{
    var_0 = 0;

    if ( isdefined( level._id_099D ) && isdefined( level._id_099D._id_89DC ) )
        var_0 = level._id_099D._id_89DC;

    var_1 = maps\mp\killstreaks\_aerial_utility::_id_3FC1();
    return var_1.origin[2] + 750 + var_0;
}

_id_3F9A( var_0, var_1, var_2 )
{
    var_3 = _id_3F99() / 2;
    var_4 = var_0 + anglestoforward( var_1 ) * ( -1 * var_3 );
    var_4 *= ( 1.0, 1.0, 0.0 );
    var_4 += ( 0, 0, var_2 );
    return var_4;
}

_id_3F99()
{
    return 30000;
}

_id_91C4( var_0, var_1 )
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
    return var_7;
}

_id_91CA( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 3000;

    var_3 = _id_91CB( var_0, var_1 );

    if ( var_3 )
        var_4 = 1;
    else
        var_4 = -1;

    var_5 = common_scripts\utility::flat_origin( var_0.origin );
    var_6 = var_5 + anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) ) * ( var_4 * 100000 );
    var_7 = pointonsegmentnearesttopoint( var_5, var_6, var_1 );
    var_8 = distance( var_5, var_7 );

    if ( var_8 < var_2 )
        return 1;
    else
        return 0;
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

_id_A007()
{
    self endon( "location_selection_complete" );
    self endon( "disconnect" );
    self waittill( "stop_location_selection" );
    self setblurforplayer( 0, 0.3 );
    self setclientomnvar( "ui_map_location_blocked", 0 );

    if ( maps\mp\gametypes\_hostmigration::waittillhostmigrationdone() > 0 )
        self switchtoweapon( common_scripts\utility::getlastweapon() );

    level._id_8F19 = undefined;
}

_id_7C5B( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_598D ) )
        level._id_598D = 1024;

    var_3 = level._id_598D / 6.46875;

    if ( level.splitscreen )
        var_3 *= 1.5;

    level._id_8F19 = 1;
    var_4 = 1;
    var_5 = 1;

    if ( common_scripts\utility::array_contains( var_2, "strafing_run_airstrike_two" ) )
        var_5 = 2;

    self setclientomnvar( "ui_map_location_use_carepackages", common_scripts\utility::array_contains( var_2, "strafing_run_airstrike_package" ) );
    self setclientomnvar( "ui_map_location_num_planes", var_5 );
    self setclientomnvar( "ui_map_location_height", _id_4084() );
    maps\mp\_utility::_beginlocationselection( var_1, "map_artillery_selector", var_4, var_3 );
    thread _id_A007();
    self endon( "stop_location_selection" );
    self endon( "disconnect" );
    var_6 = undefined;
    var_7 = undefined;
    var_8 = 0;

    while ( !var_8 )
    {
        self waittill( "confirm_location", var_9, var_10 );

        if ( !var_4 )
            var_10 = 0;

        if ( _id_9C44( var_9, var_10, var_2, self ) )
        {
            var_6 = var_9;
            var_7 = var_10;
            self setclientomnvar( "ui_map_location_use_carepackages", 0 );
            self setclientomnvar( "ui_map_location_num_planes", 0 );
            self setclientomnvar( "ui_map_location_height", 0 );
            break;
        }
        else
            thread _id_84FA();
    }

    self setblurforplayer( 0, 0.3 );
    self notify( "location_selection_complete" );
    self setclientomnvar( "ui_map_location_blocked", 0 );
    maps\mp\_matchdata::logkillstreakevent( var_1, var_6 );
    thread _id_3791( var_0, [ var_6 ], [ var_7 ], var_1, var_2 );
    return 1;
}

_id_84FA()
{
    self endon( "location_selection_complete" );
    self endon( "disconnect" );
    self endon( "stop_location_selection" );
    self notify( "airstrikeShowBlockedHUD" );
    self endon( "airstrikeShowBlockedHUD" );

    if ( self getclientomnvar( "ui_map_location_blocked" ) == 0 )
        self playlocalsound( "recon_drn_cloak_notready" );

    self setclientomnvar( "ui_map_location_blocked", 1 );
    wait 1.5;
    self setclientomnvar( "ui_map_location_blocked", 0 );
}

_id_9C44( var_0, var_1, var_2, var_3 )
{
    var_4 = _id_4084();
    var_5 = 1;

    if ( common_scripts\utility::array_contains( var_2, "strafing_run_airstrike_two" ) )
        var_5 = 2;

    return _func_2CB( var_0, var_4, var_1, var_5 );
}

_id_3791( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "used" );

    for ( var_5 = 0; var_5 < var_1.size; var_5++ )
    {
        var_6 = var_1[var_5];
        var_7 = var_2[var_5];
        var_8 = bullettrace( level.mapcenter + ( 0.0, 0.0, 1000000.0 ), level.mapcenter, 0, undefined );
        var_6 = ( var_6[0], var_6[1], var_8["position"][2] - 514 );
        thread _id_2BE2( var_0, var_6, var_7, self, self.pers["team"], var_3, var_4 );
    }
}

_id_A038( var_0 )
{
    var_0 endon( "airstrike_complete" );

    while ( !_id_91CA( var_0, var_0._id_2F91, 200 ) )
        waitframe();
}

_id_6C81()
{
    self endon( "disconnect" );
    maps\mp\_utility::freezecontrolswrapper( 1 );
    wait 0.5;
    maps\mp\_utility::freezecontrolswrapper( 0 );
}

_id_6C91( var_0 )
{
    var_1 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "coop", 0, 0.5 );

    if ( var_1 != "success" || !isdefined( var_0 ) )
    {
        if ( var_1 != "disconnect" )
        {
            if ( !isdefined( var_0 ) )
                thread maps\mp\_utility::playerremotekillstreakshowhud();

            _id_6D2E( 0 );
            maps\mp\killstreaks\_coop_util::_id_6D2F();
        }

        self notify( "initRideKillstreak_complete", 0 );
        return;
    }

    self notify( "initRideKillstreak_complete", 1 );
}

_id_464F( var_0, var_1 )
{
    var_2 = var_1.team;

    if ( var_1.team == "allies" )
    {
        var_3 = "SE_1mc_orbitalsupport_buddyrequest";
        var_4 = "SE_1mc_orbitalsupport_buddy";
    }
    else
    {
        var_3 = "AT_1mc_orbitalsupport_buddyrequest";
        var_4 = "AT_1mc_orbitalsupport_buddy";
    }

    _id_A0D9( var_0 );

    if ( !isdefined( var_0 ) )
        return;

    var_5 = maps\mp\killstreaks\_coop_util::_id_7017( var_2, &"MP_JOIN_STRAFING_RUN", "strafing_run_airstrike_coop_offensive", var_3, var_4, var_1 );
    level thread _id_A21B( var_5, var_0, var_1 );
    var_6 = _id_A0E3( var_0, "buddyJoinedStreak" );
    maps\mp\killstreaks\_coop_util::_id_8EF9( var_5 );

    if ( !isdefined( var_6 ) )
        return;

    var_6 = _id_A0E3( var_0, "airstrike_buddy_removed" );

    if ( !isdefined( var_6 ) )
        return;
}

_id_6224( var_0 )
{
    var_0 endon( "airstrike_complete" );

    if ( var_0._id_3306 )
        _id_A038( var_0 );

    _id_A0D7( var_0, 1.65 );
    var_0 notify( "coopJoinOver" );
}

_id_A0D9( var_0 )
{
    var_1 = 1.65;
    var_2 = anglestoforward( var_0.angles );

    for (;;)
    {
        waitframe();

        if ( !isdefined( var_0 ) )
            return;

        var_3 = var_0._id_392F * var_1;
        var_4 = var_0.origin + var_2 * var_3;
        var_5 = var_4 + ( 0.0, 0.0, -10000.0 );
        var_6 = bullettrace( var_4, var_5, 0, var_0 );

        if ( var_6["fraction"] == 1 )
            continue;

        var_7 = var_6["position"];
        var_8 = getnodesinradius( var_7, 300, 0 );

        if ( var_8.size > 0 )
            break;
    }
}

_id_A0D7( var_0, var_1 )
{
    var_0 endon( "airstrike_complete" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    for (;;)
    {
        waitframe();
        var_2 = var_0._id_392F * var_1;
        var_3 = anglestoforward( var_0.angles );
        var_4 = var_0.origin + var_3 * var_2;
        var_5 = var_4 + ( 0.0, 0.0, -10000.0 );
        var_6 = bullettrace( var_4, var_5, 0, var_0 );

        if ( var_6["fraction"] == 1 )
            break;

        var_7 = var_6["position"];
        var_8 = getnodesinradius( var_7, 300, 0 );

        if ( var_8.size == 0 )
            break;
    }
}

_id_A0D2( var_0, var_1 )
{
    var_1 endon( "airstrike_fire" );
    var_0 endon( "airstrike_complete" );

    if ( var_0._id_3306 )
        _id_A038( var_0 );

    _id_A0D7( var_0 );
}

_id_A0E3( var_0, var_1 )
{
    var_0 endon( "airstrike_complete" );
    var_0 endon( "coopJoinOver" );
    var_0 waittill( var_1 );
    return 1;
}

_id_A21B( var_0, var_1, var_2 )
{
    var_3 = _id_A0C8( var_0, var_1 );

    if ( !isdefined( var_3 ) )
        return;

    var_1 notify( "buddyJoinedStreak" );
    level notify( "buddyGO" );
    var_3 thread _id_6C91( var_1 );
    var_3 waittill( "initRideKillstreak_complete", var_4 );

    if ( !var_4 )
        return;

    var_3 maps\mp\_utility::playersaveangles();
    var_3 maps\mp\_utility::setusingremote( "strafing_run" );
    var_3 notifyonplayercommand( "airstrike_fire", "+attack" );
    var_3 notifyonplayercommand( "airstrike_fire", "+attack_akimbo_accessible" );
    var_5 = spawnturret( "misc_turret", var_1 gettagorigin( "tag_origin" ), "sentry_minigun_mp" );
    var_5 _meth_815C();
    var_5 setmodel( "tag_turret" );
    var_5 linktosynchronizedparent( var_1, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 70.0, 180.0, 0.0 ) );
    var_3 _meth_807E( var_5, "tag_player", 0, 180, 180, 5, 15, 0 );
    var_3 _meth_80A0( 0 );
    var_3 _meth_80A1( 1 );
    var_3 _meth_80E8( var_5, 60, 45 );
    var_6 = var_3 maps\mp\killstreaks\_missile_strike::_id_188F( [] );
    _id_5CB8( var_3, var_6, var_2 );
    _id_A0D2( var_1, var_3 );

    if ( isdefined( var_3 ) )
    {
        earthquake( 0.4, 1, var_3 _meth_845C(), 300 );
        _id_37DF( var_3, var_5, var_6 );

        if ( isdefined( var_3 ) )
        {
            var_3 maps\mp\killstreaks\_coop_util::_id_6D2F();
            var_3 notifyonplayercommandremove( "airstrike_fire", "+attack" );
            var_3 notifyonplayercommandremove( "airstrike_fire", "+attack_akimbo_accessible" );
        }
    }

    var_5 delete();
}

_id_A0C8( var_0, var_1 )
{
    var_1 endon( "airstrike_complete" );
    var_1 endon( "coopJoinOver" );
    thread _id_6224( var_1 );
    var_2 = maps\mp\killstreaks\_coop_util::_id_A0C9( var_0 );
    return var_2;
}

_id_37DF( var_0, var_1, var_2 )
{
    var_3 = var_1 gettagorigin( "tag_player" );
    var_4 = anglestoforward( var_1 gettagangles( "tag_player" ) );
    var_5 = var_3 + var_4 * 10000;
    var_6 = magicbullet( "airstrike_missile_mp", var_3, var_5, var_0 );
    var_6.owner = var_0;
    waitframe();

    if ( !isdefined( var_0 ) )
        return;

    var_0 unlink();
    var_0 _meth_80E9( var_1 );
    var_0 setclientomnvar( "fov_scale", 4.33333 );
    _id_5CB7( var_0, var_6, var_2 );

    if ( !isdefined( var_0 ) )
        return;

    var_0 setclientomnvar( "fov_scale", 1.0 );
}

_id_5CB8( var_0, var_1, var_2 )
{
    var_0 thread _id_4AE8( var_1, var_2 );
    var_0 thermalvisionfofoverlayon();

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::setthirdpersondof( 0 );
}

_id_5CB7( var_0, var_1, var_2 )
{
    var_0 endon( "joined_team" );
    var_0 endon( "joined_spectators" );
    var_0 endon( "player_control_strike_over" );
    var_0 endon( "disconnect" );
    var_2 endon( "ms_early_exit" );
    var_1 thread maps\mp\killstreaks\_missile_strike::rocket_cleanupondeath();
    var_0 thread maps\mp\killstreaks\_missile_strike::player_cleanupongameended( var_1, var_2 );
    var_0 thread maps\mp\killstreaks\_missile_strike::player_cleanuponteamchange( var_1, var_2 );
    var_0 thread _id_4AE7( var_1, var_2 );
    var_0 thread _id_6D82( var_2 );
    var_0 cameralinkto( var_1, "tag_origin" );
    var_0 controlslinkto( var_1 );
    var_0 thread maps\mp\killstreaks\_missile_strike::_id_6D8C( var_2 );
    var_1 common_scripts\utility::waittill_notify_or_timeout( "death", 10 );
    var_2 notify( "missile_strike_complete" );
}

_id_6D82( var_0 )
{
    var_0 common_scripts\utility::waittill_either( "missile_strike_complete", "ms_early_exit" );
    _id_6D2E();
}

_id_6D2E( var_0 )
{
    self endon( "disconnect" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    self controlsunlink();
    maps\mp\_utility::freezecontrolswrapper( 1 );
    self setclientomnvar( "fov_scale", 1.0 );
    _id_8EF2();
    maps\mp\killstreaks\_missile_strike::_id_8EF2();

    if ( !level.gameended || isdefined( self.finalkill ) )
        maps\mp\killstreaks\_aerial_utility::_id_6D51();

    if ( var_0 )
    {
        wait 0.5;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }

    maps\mp\killstreaks\_missile_strike::_id_735E();
    self thermalvisionfofoverlayoff();
    self cameraunlink();
    maps\mp\_utility::freezecontrolswrapper( 0 );

    if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    maps\mp\_utility::playerrestoreangles();
}

_id_8EF2()
{
    self stoplocalsound( "bombrun_support_mstrike_boost_shot" );
    self stoplocalsound( "bombrun_support_mstrike_boost_boom" );
    self stoplocalsound( "bombrun_support_mstrike_boost_jet" );
}

_id_4AE8( var_0, var_1 )
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_predator_missile", 2 );
    self setclientomnvar( "ui_coop_primary_num", var_1 getentitynumber() );
    waitframe();
    maps\mp\killstreaks\_missile_strike::_id_4AD6( undefined, var_0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
}

_id_4AE7( var_0, var_1 )
{
    thread maps\mp\killstreaks\_missile_strike::_id_91C7();
    thread maps\mp\killstreaks\_missile_strike::_id_91C8( var_0, var_1 );
}
