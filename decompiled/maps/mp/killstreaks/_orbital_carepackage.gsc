// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_0606 = [];
    level._id_655A = [];
    level._effect["ocp_death"] = loadfx( "vfx/explosion/exo_droppod_explosion" );
    level._effect["ocp_midair"] = loadfx( "vfx/explosion/exo_droppod_split" );
    level._effect["ocp_ground_marker"] = loadfx( "vfx/unique/vfx_marker_killstreak_guide_carepackage" );
    level._effect["ocp_ground_marker_bad"] = loadfx( "vfx/unique/vfx_marker_killstreak_guide_carepackage_fizzle" );
    level._effect["ocp_exhaust"] = loadfx( "vfx/vehicle/vehicle_ocp_exhaust" );
    level._effect["ocp_thruster_small"] = loadfx( "vfx/vehicle/vehicle_ocp_thrusters_small" );
    level._effect["vfx_ocp_steam"] = loadfx( "vfx/steam/vfx_ocp_steam" );
    level._effect["vfx_ocp_steam2"] = loadfx( "vfx/steam/vfx_ocp_steam2" );
    level._effect["ocp_glow"] = loadfx( "vfx/unique/orbital_carepackage_glow" );
    level.killstreakfuncs["orbital_carepackage"] = ::_id_98A5;
    level.killstreakwieldweapons["orbital_carepackage_pod_mp"] = "orbital_carepackage";
    level.killstreakfuncs["orbital_carepackage_juggernaut_exosuit"] = ::_id_98B6;
    map_restart( "orbital_care_package_open" );
    map_restart( "orbital_care_package_fan_spin" );
    level.ocp_weap_name = "orbital_carepackage_pod_mp";

    if ( !isdefined( level.missileitemclipdelay ) )
        level.missileitemclipdelay = 3.0;
}

_id_98A5( var_0, var_1 )
{
    return _id_98B5( var_0, "orbital_carepackage", var_1 );
}

_id_98B6( var_0, var_1 )
{
    return _id_98B5( var_0, "orbital_carepackage_juggernaut_exosuit", var_1 );
}

_id_98B5( var_0, var_1, var_2 )
{
    if ( common_scripts\utility::array_contains( var_2, "orbital_carepackage_drone" ) && maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    var_3 = _id_6CD7( var_1, var_2 );

    if ( !isdefined( var_3 ) || !var_3 )
        return 0;

    if ( var_1 == "orbital_carepackage" )
        maps\mp\gametypes\_missions::processchallenge( "ch_streak_orbitalcare", 1 );

    return 1;
}

_id_6CD7( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_orbital_util::_id_6CAA( "carepackage" );
    var_3 = undefined;

    if ( isdefined( var_2 ) )
        var_3 = var_2.origin;
    else if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_2 = [[ level._id_4995 ]]();
        var_3 = var_2.origin;
    }
    else
    {
        thread maps\mp\killstreaks\_orbital_util::_id_6D22( common_scripts\utility::getfx( "ocp_ground_marker_bad" ) );
        self setclientomnvar( "ui_invalid_orbital_care_package", 1 );
        return 0;
    }

    var_4 = undefined;

    if ( common_scripts\utility::array_contains( var_1, "orbital_carepackage_drone" ) )
    {
        var_4 = spawnhelicopter( self, var_3 + ( 0.0, 0.0, 200.0 ), ( 0.0, 0.0, 0.0 ), "orbital_carepackage_drone_mp", "orbital_carepackage_pod_01_vehicle" );

        if ( !isdefined( var_4 ) )
            return 0;

        var_4 hide();
    }

    var_5 = _id_37E1( level.ocp_weap_name, self, var_2, var_0, var_1, var_4, undefined, undefined, 1 );
    return isdefined( var_5 );
}

_id_37E1( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_6 ) )
        var_6 = var_1 maps\mp\killstreaks\_orbital_util::_id_6CA9( var_2, "carepackage" );

    var_9 = var_2.origin;

    if ( !isdefined( var_7 ) )
        var_7 = [];

    var_10 = magicbullet( var_0, var_6, var_9, var_1, 0, 1 );

    if ( !isdefined( var_10 ) )
        return;

    var_10 thread _id_7FA6( level.missileitemclipdelay );

    if ( !isdefined( level.iszombiegame ) || !level.iszombiegame )
        var_10 thread _id_96A7( var_1 );

    var_11 = var_1 createplayerdroppod( var_10 );
    var_11.streakname = var_3;
    var_11.modules = var_4;
    var_11._id_2F8D = var_2.origin;
    var_11._id_2E19 = var_5;
    var_11._id_41DF = var_8;
    var_10.team = var_1.team;
    var_10.owner = var_1;
    var_10.type = "remote";
    return _id_5E4C( var_1, var_10, var_11, var_3, var_7, var_0 );
}

_id_96A7( var_0 )
{
    self endon( "death" );
    var_1 = self.origin;

    while ( isdefined( self ) )
    {
        if ( !level.teambased )
            _id_1B45( 10000, self.origin, var_1, 30, undefined, var_0 );
        else
            _id_1B45( 10000, self.origin, var_1, 30, level.otherteam[var_0.team], var_0 );

        var_1 = self.origin;
        wait 0.05;
    }
}

_id_1B45( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_2 - var_1;
    var_7 = vectornormalize( var_6 );
    var_8 = length( var_6 );
    var_9 = var_3 * var_3;

    foreach ( var_11 in level.characters )
    {
        if ( !isalive( var_11 ) )
            continue;

        if ( var_11 != var_5 && isdefined( var_4 ) && isdefined( var_11.team ) && var_11.team != var_4 )
            continue;

        var_12 = var_11.origin - var_1;
        var_13 = vectordot( var_12, var_7 );

        if ( var_13 > var_3 * -1 && var_13 < var_8 + var_3 )
        {
            var_14 = var_1 + var_7 * var_13;
            var_15 = distancesquared( var_14, var_11.origin );

            if ( var_15 <= var_9 )
                var_11 dodamage( var_0, var_14, var_5, self, "MOD_EXPLOSIVE", level.ocp_weap_name );
        }
    }
}

_id_7FA6( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self _meth_851C( 1 );
}

createplayerdroppod( var_0 )
{
    var_1 = 0;

    if ( !isdefined( level._id_0606 ) )
        level._id_0606 = [];
    else
    {
        level._id_0606 = maps\mp\_utility::cleanarray( level._id_0606 );
        var_1 = level._id_0606.size;
    }

    level._id_0606[var_1] = spawnstruct();
    level._id_0606[var_1]._id_4730 = 0;
    level._id_0606[var_1]._id_6E13 = var_0;
    level._id_0606[var_1]._id_6E13.maxhealth = 100;
    level._id_0606[var_1]._id_6E13.health = 100;
    level._id_0606[var_1]._id_6E13.damagetaken = 0;
    level._id_0606[var_1]._id_6E13._id_517B = 1;
    level._id_0606[var_1].owner = self;
    level._id_0606[var_1]._id_09DC = 1;
    return level._id_0606[var_1];
}

rocket_cleanupondeath()
{
    var_0 = self getentitynumber();
    level.rockets[var_0] = self;
    self waittill( "death" );

    if ( isdefined( level.orbitaldropupgrade ) && level.orbitaldropupgrade == 1 )
        _func_071( "dna_aoe_grenade_throw_zombie_mp", self.origin + ( 0.0, 0.0, 64.0 ), ( 0.0, 0.0, 0.0 ), 3.0, level.player, 1 );

    level.rockets[var_0] = undefined;

    if ( isdefined( self.killcament ) )
    {
        self.killcament unlink();
        self.killcament.origin += ( 0.0, 0.0, 300.0 );
    }
}

_id_3F6E( var_0 )
{
    switch ( var_0 )
    {
        case "orbital_carepackage_juggernaut_exosuit":
            return "orbital_carepackage_juggernaut_exosuit";
        case "airdrop_reinforcement_common":
            return "airdrop_reinforcement_common";
        case "airdrop_reinforcement_uncommon":
            return "airdrop_reinforcement_uncommon";
        case "airdrop_reinforcement_rare":
            return "airdrop_reinforcement_rare";
        case "airdrop_reinforcement_practice":
            return "airdrop_reinforcement_practice";
        case "horde_support_drop":
            return "horde_support_drop";
        default:
            return "airdrop_assault";
    }
}

_id_0AA3( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( level.teambased && level.teamemped[var_0.team] )
        return 0;

    if ( !level.teambased && isdefined( level.empplayer ) && level.empplayer != var_0 )
        return 0;

    return 1;
}

_id_5E4C( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = _id_3F6E( var_3 );

    if ( var_6 == "airdrop_assault" && common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_odds" ) )
        var_6 = "airdrop_assault_odds";

    if ( isdefined( level.getcratefordroptype ) )
        var_7 = [[ level.getcratefordroptype ]]( var_6 );
    else
        var_7 = maps\mp\killstreaks\_airdrop::_id_3F3E( var_6 );

    thread _id_5E4D( var_0, var_1, var_2, var_6, var_7, var_5 );
    return var_7;
}

_id_5E4D( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level endon( "game_ended" );
    var_1 thread rocket_cleanupondeath();
    var_6 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_trap" );
    var_7 = var_0 maps\mp\killstreaks\_airdrop::_id_23E2( var_0, var_3, var_4, var_1.origin, undefined, var_6, 0 );
    var_7._id_5D58 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_trap" );
    var_7._id_5D54 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_hide" );
    var_7._id_5D56 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_roll" );
    var_7._id_5D55 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_fast_pickup" );
    var_7.angles = ( 0.0, 0.0, 0.0 );
    var_7.en_route_in_air = 1;
    var_1.killcament = var_7.killcament;

    if ( var_5 == "orbital_carepackage_pod_plane_mp" )
        var_1.killcament.killcamstarttime = gettime();

    var_8 = common_scripts\utility::array_contains( var_2.modules, "orbital_carepackage_drone" );
    var_9 = spawn( "script_model", var_2._id_2F8D + ( 0.0, 0.0, 5.0 ) );
    var_9.angles = ( -90.0, 0.0, 0.0 );
    var_9 setmodel( "tag_origin" );
    var_9 hide();
    var_9 showtoplayer( var_0 );
    playfxontag( common_scripts\utility::getfx( "ocp_ground_marker" ), var_9, "tag_origin" );
    var_9 thread _id_1B9D( var_2.modules, var_0 );
    maps\mp\killstreaks\_orbital_util::_id_07DF( var_9 );

    if ( var_8 )
        var_0 thread _id_6D15( var_1, var_2, var_9, var_7 );

    var_7 linkto( var_1, "tag_origin", ( 0.0, 0.0, 0.0 ), ( -90.0, 0.0, 0.0 ) );
    var_1 waittill( "death", var_10, var_11, var_12 );

    if ( isdefined( var_1 ) && !var_8 && var_1.origin[2] > var_2._id_2F8D[2] && distancesquared( var_1.origin, var_2._id_2F8D ) > 22500 )
    {
        if ( var_2._id_41DF )
        {
            if ( isdefined( level.ishorde ) && level.ishorde )
            {
                var_13 = [[ level._id_4995 ]]();
                _id_37E1( level.ocp_weap_name, self, var_13, "horde_support_drop", var_2.modules, 0, undefined, undefined, 1 );
            }
            else if ( isdefined( var_0 ) )
                var_0 _id_6CAE( var_2 );
        }

        level thread _id_1E8A( var_2, var_7, var_9 );
        return;
    }

    if ( var_8 && _id_0AA3( var_0 ) && isdefined( var_2._id_2E19 ) )
        var_2._id_2E19 show();
    else
    {
        earthquake( 0.4, 1, var_2._id_2F8D, 800 );
        playrumbleonposition( "artillery_rumble", var_2._id_2F8D );
    }

    killfxontag( common_scripts\utility::getfx( "ocp_ground_marker" ), var_9, "tag_origin" );
    var_2._id_09DC = 0;

    if ( var_8 && _id_0AA3( var_0 ) && isdefined( var_2._id_2E19 ) )
    {
        var_2._id_2E19 waittill( "delivered" );
        var_7 setcontents( var_7.oldcontents );
        var_7.oldcontents = undefined;
    }

    var_9 thread _id_1B8E( var_7 );
    var_7 clonebrushmodeltoscriptmodel( level._id_0996 );
    var_7._id_2F75 = 1;
    var_7 unlink();
    var_7 physicslaunchserver( ( 0.0, 0.0, 0.0 ) );
    var_7 thread _id_2374();
    var_7 thread _id_655D( var_3, var_4, var_0 );
    level thread _id_73D1( var_7, var_2 );
    var_7.en_route_in_air = 0;
}

_id_2376( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = getnodesinradiussorted( self.origin, 300, 0, 300 );

    foreach ( var_3 in level.characters )
    {
        if ( !isalive( var_3 ) )
            continue;

        if ( _func_285( var_3, var_0 ) )
        {
            if ( var_3 istouching( self ) )
            {
                foreach ( var_5 in var_1 )
                {
                    if ( distancesquared( var_5.origin, self.origin ) > 10000 )
                    {
                        var_3 setorigin( var_5.origin, 1 );
                        var_1 = common_scripts\utility::array_remove( var_1, var_5 );
                        break;
                    }
                }
            }
        }
    }
}

_id_2374()
{
    self endon( "physics_finished" );
    self endon( "death" );
    var_0 = 4;
    var_1 = var_0 / 0.05;
    var_2 = 25;
    var_3 = 0;
    var_4 = self.origin;

    for (;;)
    {
        waitframe();
        var_5 = distancesquared( var_4, self.origin );

        if ( var_5 < var_2 )
            var_3++;
        else
            var_3 = 0;

        var_4 = self.origin;

        if ( var_3 >= var_1 )
        {
            self physicsstop();
            return;
        }
    }
}

_id_6CAE( var_0 )
{
    var_1 = maps\mp\killstreaks\_killstreaks::getstreakcost( "orbital_carepackage" );
    var_2 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex( "orbital_carepackage", 0 );
    thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( "orbital_carepackage", var_1, undefined, var_0.modules, var_2 );
    thread maps\mp\killstreaks\_killstreaks::givekillstreak( "orbital_carepackage", 0, 0, self, var_0.modules );
}

_id_1E8A( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
    {
        thread _id_73D1( var_1, var_0 );
        var_1 delete();
    }

    if ( isdefined( var_0._id_2E19 ) )
        var_0._id_2E19 maps\mp\killstreaks\_drone_carepackage::_id_1B94();

    if ( isdefined( var_2 ) )
    {
        if ( isdefined( var_2._id_6305 ) )
            maps\mp\_utility::_objective_delete( var_2._id_6305 );

        if ( isdefined( var_2._id_6304 ) )
            maps\mp\_utility::_objective_delete( var_2._id_6304 );

        killfxontag( common_scripts\utility::getfx( "ocp_ground_marker" ), var_2, "tag_origin" );
        waitframe();
        var_2 delete();
    }
}

_id_655D( var_0, var_1, var_2 )
{
    self endon( "death" );
    maps\mp\killstreaks\_airdrop::_id_6802( var_0, var_1 );
    self playsound( "orbital_pkg_panel" );

    if ( isdefined( self._id_32B4 ) )
    {
        self._id_32B4 thread _id_6559();
        self._id_32B4 solid();
    }

    if ( isdefined( self._id_3AB6 ) )
    {
        self._id_3AB6 thread _id_6559();
        self._id_3AB6 solid();
    }

    thread _id_2376( var_2 );
}

_id_6559( var_0 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) || !var_0 )
        wait 0.75;

    if ( isdefined( var_0 ) && var_0 )
        self scriptmodelplayanim( "orbital_care_package_open_loop" );
    else
        self scriptmodelplayanim( "orbital_care_package_open" );

    playfxontag( common_scripts\utility::getfx( "ocp_glow" ), self, "TAG_ORIGIN" );

    if ( !isdefined( var_0 ) || !var_0 )
    {
        waitframe();
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam2" ), self, "TAG_FX_PANEL_F" );
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam2" ), self, "TAG_FX_PANEL_K" );
        waitframe();
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam" ), self, "TAG_FX_PANEL_FR" );
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam" ), self, "TAG_FX_PANEL_KL" );
        waitframe();
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam" ), self, "TAG_FX_PANEL_FL" );
        playfxontag( common_scripts\utility::getfx( "vfx_ocp_steam" ), self, "TAG_FX_PANEL_KR" );
    }
}

_id_27D0( var_0 )
{
    wait 5;
    var_0 delete();
}

_id_73D1( var_0, var_1 )
{
    var_0 waittill( "death" );
    wait 15;

    for ( var_2 = 0; var_2 < level._id_0606.size; var_2++ )
    {
        if ( isdefined( level._id_0606[var_2] ) && level._id_0606[var_2] == var_1 )
        {
            if ( level._id_0606[var_2]._id_09DC == 0 )
                level._id_0606[var_2] = undefined;
        }
    }

    if ( isdefined( var_1 ) )
        var_1 = undefined;
}

_id_1B9D( var_0, var_1 )
{
    self endon( "death" );

    if ( common_scripts\utility::array_contains( var_0, "orbital_carepackage_hide" ) )
        return;

    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "invisible", ( 0.0, 0.0, 0.0 ) );
    objective_position( var_2, self.origin );
    objective_state( var_2, "active" );
    var_3 = "compass_objpoint_ammo_friendly";
    objective_icon( var_2, var_3 );

    if ( !level.teambased )
        objective_playerteam( var_2, var_1 getentitynumber() );
    else
        objective_team( var_2, var_1.team );

    self._id_6305 = var_2;

    if ( !( isdefined( level.ishorde ) && level.ishorde ) )
    {
        var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( var_2, "invisible", ( 0.0, 0.0, 0.0 ) );
        objective_position( var_2, self.origin );
        objective_state( var_2, "active" );
        objective_icon( var_2, "compass_objpoint_ammo_enemy" );

        if ( !level.teambased )
            objective_playerenemyteam( var_2, var_1 getentitynumber() );
        else
            objective_team( var_2, level.otherteam[var_1.team] );

        self._id_6304 = var_2;
    }

    if ( common_scripts\utility::array_contains( var_0, "orbital_carepackage_drone" ) )
    {
        self waittill( "linkedToDrone" );
        objective_onentity( self._id_6305, self );

        if ( isdefined( self._id_6304 ) )
        {
            objective_onentity( self._id_6304, self );
            self show();
        }
    }
}

_id_1B8E( var_0 )
{
    var_0 common_scripts\utility::waittill_any( "physics_finished", "death" );

    if ( isdefined( self._id_6305 ) )
        maps\mp\_utility::_objective_delete( self._id_6305 );

    if ( isdefined( self._id_6304 ) )
        maps\mp\_utility::_objective_delete( self._id_6304 );

    killfxontag( common_scripts\utility::getfx( "ocp_glow" ), self, "TAG_ORIGIN" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 notify( "drop_pod_cleared" );

    waitframe();
    self delete();
}

_id_8304( var_0 )
{
    var_0.health = 500;
    var_0.maxhealth = var_0.health;
    var_0._id_71E1 = 0;
    _id_8305( var_0._id_3AB6 );
    _id_8305( var_0._id_32B4 );
}

_id_8305( var_0 )
{
    var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback( 9999, undefined, undefined, ::_id_2375, 1 );
}

_id_2AFF( var_0 )
{
    _id_2B00( var_0._id_3AB6 );
    _id_2B00( var_0._id_32B4 );
}

_id_2B00( var_0 )
{
    var_0.damagecallback = undefined;
    var_0 setcandamage( 0 );
    var_0 setdamagecallbackon( 0 );
}

_id_2375( var_0, var_1, var_2, var_3 )
{
    var_4 = self;

    if ( isdefined( self._id_6684 ) )
        var_4 = self._id_6684;

    var_5 = maps\mp\gametypes\_damage::modifydamage( var_0, var_1, var_2, var_3 );
    var_4.health -= var_5;

    if ( var_4.health <= 0 )
    {
        _id_2AFF( var_4 );
        var_4 notify( "disabled" );
    }

    return 0;
}

_id_6D15( var_0, var_1, var_2, var_3 )
{
    self endon( "disconenct" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    var_4 = 576;
    var_5 = 250000;
    var_6 = var_1._id_2F8D;
    var_7 = var_0.origin;
    var_8 = distancesquared( var_7, var_6 );
    _id_8304( var_3 );
    var_9 = var_1._id_2E19;
    var_9 thread _id_1B9A( var_3 );
    var_3.oldcontents = var_3 setcontents( 0 );
    var_3._id_3AB6 solid();
    var_3._id_32B4 solid();

    for (;;)
    {
        if ( !isdefined( var_0 ) )
            break;

        var_7 = var_0.origin;
        var_8 = distancesquared( var_7, var_6 );

        if ( var_8 <= var_5 )
            break;

        waitframe();
    }

    if ( var_8 > var_5 )
    {
        if ( var_1._id_41DF && _id_0AA3( self ) )
            _id_6CAE( var_1 );

        level thread _id_1E8A( var_1, var_3, var_2 );
        return;
    }

    if ( !isdefined( self ) )
    {
        level thread _id_1E8A( var_1, var_3, var_2 );
        return;
    }

    if ( !_id_0AA3( self ) )
    {
        level thread _id_1E8A( var_3, undefined, undefined );
        return;
    }

    var_9 thread _id_1B9B();
    var_9 endon( "death" );
    var_9 _meth_827C( var_3.origin, var_3.angles, 0, 0 );
    var_3 linkto( var_9, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3._id_3AB6 scriptmodelplayanim( "orbital_care_package_fan_spin", "nothing" );
    var_3._id_32B4 scriptmodelplayanim( "orbital_care_package_fan_spin", "nothing" );
    maps\mp\killstreaks\_drone_carepackage::_id_82FC( var_9, 1 );
    var_9._id_2361 = var_3;

    if ( isdefined( var_0 ) )
    {
        var_7 = var_0.origin;
        var_0 notify( "death" );
        var_0 delete();
    }

    playsoundatpos( var_7, "orbital_pkg_pod_midair_exp" );
    playfx( common_scripts\utility::getfx( "ocp_midair" ), var_7, getdvarvector( "scr_ocp_forward", ( 0.0, 0.0, -1.0 ) ) );
    var_9 thread _id_2EDE();
    var_10 = var_1._id_2F8D + ( 0.0, 0.0, 35.0 );
    var_9 _meth_825B( var_10, 1 );
    var_9 _meth_8284( getdvarfloat( "scr_ocp_dropspeed", 30 ), getdvarfloat( "scr_ocp_dropa", 20 ), getdvarfloat( "scr_ocp_dropd", 1 ) );
    var_9 _meth_8253( 30, 5, 5 );
    var_9 _meth_8294( 15, 15 );

    while ( distancesquared( var_9.origin, var_10 ) > var_4 && var_3.health > 0 )
        waitframe();

    if ( var_3.health > 0 )
        wait 1;

    if ( var_3.health > 0 )
    {
        var_2 linkto( var_9, "tag_origin" );
        var_2 notify( "linkedToDrone" );
        var_9 thread maps\mp\killstreaks\_drone_carepackage::_id_1B91();
        var_9 _id_1B98();
    }

    _id_2AFF( var_3 );
    var_3 _meth_8438( "orbital_pkg_drone_jets_off" );

    if ( isdefined( var_9 ) )
        var_9 _id_2EC7();

    var_3._id_3AB6 _meth_827A( "orbital_care_package_fan_spin", "nothing" );
    var_3._id_32B4 _meth_827A( "orbital_care_package_fan_spin", "nothing" );
    waitframe();

    if ( isdefined( var_9 ) )
        var_9 maps\mp\killstreaks\_drone_carepackage::_id_1B90();
}

_id_1B9B()
{
    self endon( "delivered" );
    self waittill( "death" );
    self notify( "delivered" );
}

_id_1B9A( var_0 )
{
    self endon( "delivered" );
    var_0 waittill( "disabled" );
    self notify( "delivered" );
}

_id_1B98()
{
    var_0 = self.owner;
    var_0 endon( "disconnect" );
    self endon( "death" );
    self endon( "delivered" );
    var_1 = 22500;
    var_2 = 1;
    var_3 = gettime();

    for (;;)
    {
        var_4 = maps\mp\_utility::isreallyalive( var_0 );

        if ( !var_4 )
        {
            var_2 = 1;
            waitframe();
        }

        if ( var_3 < gettime() || var_2 )
        {
            var_2 = 0;
            self _meth_83F9( var_0, ( 0.0, -100.0, 15.0 ) );
            var_3 = gettime() + 1000;
        }

        var_5 = distancesquared( self.origin, var_0.origin + ( 0.0, 0.0, 15.0 ) );

        if ( var_5 < var_1 )
        {
            wait(getdvarfloat( "scr_ocp_waitDeliver", 1 ));
            self notify( "delivered" );
            return;
        }

        waitframe();
    }
}

_id_2EDE()
{
    self endon( "death" );
    playfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fl" );
    playfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fr" );
    playfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kl" );
    playfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kr" );
    waitframe();
    waitframe();

    if ( isdefined( self ) )
        playfxontag( common_scripts\utility::getfx( "ocp_exhaust" ), self, "tag_fx" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        thread _id_2EE3( var_0 );
    }
}

_id_2EE3( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );

    if ( isdefined( var_0 ) && isdefined( self ) )
        _id_2EE2( var_0 );
}

_id_2EE2( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "death" );
    playfxontagforclients( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fl", var_0 );
    playfxontagforclients( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fr", var_0 );
    playfxontagforclients( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kl", var_0 );
    playfxontagforclients( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kr", var_0 );
    waitframe();
    waitframe();

    if ( isdefined( self ) )
        playfxontagforclients( common_scripts\utility::getfx( "ocp_exhaust" ), self, "tag_fx", var_0 );
}

_id_2EC7()
{
    killfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fl" );
    killfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_fr" );
    killfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kl" );
    killfxontag( common_scripts\utility::getfx( "ocp_thruster_small" ), self, "j_thruster_kr" );
    waitframe();
    waitframe();

    if ( isdefined( self ) )
        killfxontag( common_scripts\utility::getfx( "ocp_exhaust" ), self, "tag_fx" );
}
