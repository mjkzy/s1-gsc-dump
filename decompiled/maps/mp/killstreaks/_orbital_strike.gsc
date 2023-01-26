// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["orbital_laser_clouds"] = loadfx( "vfx/unique/vfx_odin_parallax_clouds" );
    level._effect["orbital_laser_warmup"] = loadfx( "vfx/beam/orbital_laser_warmup" );
    level._effect["orbital_laser_warmup_water"] = loadfx( "vfx/beam/orbital_laser_water_boiling" );
    level._effect["orbital_laser_warmup_wide"] = loadfx( "vfx/beam/orbital_laser_warmup_large" );
    level._effect["orbital_laser_warmup_wide_water"] = loadfx( "vfx/beam/orbital_laser_water_boiling" );
    level._effect["orbital_laser_warmup_lightshow"] = loadfx( "vfx/beam/orbital_laser_warmup_lightshow" );
    level._effect["orbital_laser_warmup_lightshow_water"] = loadfx( "vfx/beam/orbital_laser_water_boiling" );
    level._effect["orbital_laser_warmup_lightshow_wide"] = loadfx( "vfx/beam/orbital_laser_warmup_lightshow_large" );
    level._effect["orbital_laser_warmup_lightshow_wide_water"] = loadfx( "vfx/beam/orbital_laser_water_boiling" );
    level._effect["orbital_laser_fire"] = loadfx( "vfx/beam/orbital_laser_fire_small" );
    level._effect["orbital_laser_fire_water"] = loadfx( "vfx/beam/orbital_laser_water_sm" );
    level._effect["orbital_laser_fire_wide"] = loadfx( "vfx/beam/orbital_laser_fire_large" );
    level._effect["orbital_laser_fire_wide_water"] = loadfx( "vfx/beam/orbital_laser_water_sm" );
    level._effect["orbital_laser_fire_lightshow"] = loadfx( "vfx/beam/orbital_laser_fire_lightshow" );
    level._effect["orbital_laser_fire_lightshow_water"] = loadfx( "vfx/beam/orbital_laser_water_sm" );
    level._effect["orbital_laser_fire_lightshow_wide"] = loadfx( "vfx/beam/orbital_laser_fire_lightshow_large" );
    level._effect["orbital_laser_fire_lightshow_wide_water"] = loadfx( "vfx/beam/orbital_laser_water_sm" );
    level._effect["orbital_laser_ending"] = loadfx( "vfx/beam/orbital_laser_ending" );
    level._effect["orbital_laser_ending_water"] = loadfx( "vfx/beam/orbital_laser_water_aftermath" );
    level._effect["orbital_laser_beam"] = loadfx( "vfx/beam/orbital_laser_lightbeam" );
    level._effect["orbital_laser_beam_wide"] = loadfx( "vfx/beam/orbital_laser_lightbeam_lg" );
    level._effect["orbital_laser_beam_lightshow"] = loadfx( "vfx/beam/orbital_laser_lightbeam_lightshow" );
    level._effect["orbital_laser_beam_lightshow_wide"] = loadfx( "vfx/beam/orbital_laser_lightbeam_lightshow_lg" );
    level._effect["orbital_laser_smoldering"] = loadfx( "vfx/beam/orbital_laser_smoldering" );
    level._effect["orbital_laser_death"] = loadfx( "vfx/beam/orbital_laser_lightbeam_burnmark" );
    level._id_0607 = [];
    level._id_0607 = spawnstruct();
    level._id_0607.vehicle = "orbital_laser_strike_mp";
    level._id_0607.helitype = "OrbitalStrike";
    level._id_0607.maxhealth = 9999999;
    level.killstreakfuncs["orbital_strike_laser"] = ::_id_98B7;
    level.killstreakwieldweapons["orbital_laser_fov_mp"] = "orbital_strike_laser";

    if ( !isdefined( level._id_654F ) )
        level._id_654F = [];

    if ( level.teambased )
    {
        level._id_654E = 0;
        level._id_654D = 0;
    }

    level._id_655C = spawnstruct();
    level._id_655C._id_89DC = undefined;
    level._id_655C.spawnpoint = undefined;

    if ( isdefined( level._id_655B ) )
        [[ level._id_655B ]]();
}

_id_98B7( var_0, var_1 )
{
    if ( _id_1D14() )
    {
        self iclientprintlnbold( &"KILLSTREAKS_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_2 = undefined;

    if ( level.teambased )
    {
        var_2 = self.team;
        _id_7FCA( var_2, 1 );
    }

    var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "orbital_strike" );

    if ( var_3 != "success" )
    {
        maps\mp\_utility::decrementfauxvehiclecount();

        if ( level.teambased )
            _id_7FCA( var_2, 0 );

        return 0;
    }

    if ( isdefined( level.ishorde ) && level.ishorde && self.killstreakindexweapon == 1 )
        self notify( "used_horde_orbital" );

    maps\mp\_utility::setusingremote( "orbital_strike" );
    var_3 = _id_8322( var_0, var_1 );
    maps\mp\_matchdata::logkillstreakevent( "orbital_strike", self.origin );
    return var_3;
}

_id_1D14()
{
    if ( level.teambased )
    {
        if ( self.team == "allies" )
            return level._id_654D;
        else
            return level._id_654E;
    }
    else
        return level._id_654F.size >= 2;
}

_id_7FCA( var_0, var_1 )
{
    if ( var_0 == "allies" )
        level._id_654D = var_1;
    else
        level._id_654E = var_1;
}

orbitalstrikesetupdelay( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    waitframe();
    var_0 thermaldrawdisable();
}

_id_8322( var_0, var_1 )
{
    _id_6C5A();
    var_2 = _id_3776();
    var_3 = spawnhelicopter( self, var_2.origin, ( 0.0, 0.0, 0.0 ), level._id_0607.vehicle, "tag_origin" );

    if ( !isdefined( var_3 ) )
        return 0;

    thread orbitalstrikesetupdelay( var_3 );
    level._id_654F = common_scripts\utility::array_add( level._id_654F, var_3 );
    var_3.modules = var_1;
    var_3.vehicletype = "orbital_strike";
    var_3.lifeid = var_0;
    var_3.team = self.pers["team"];
    var_3.pers["team"] = self.pers["team"];
    var_3.owner = self;
    var_3.maxhealth = level._id_0607.maxhealth;
    var_3._id_A3C2 = ( 0.0, 0.0, 0.0 );
    var_3._id_91C5 = level._id_47F7;
    var_3._id_6F89 = undefined;
    var_3._id_7BF6 = undefined;
    var_3.attacker = undefined;
    var_3._id_1FC7 = 0;
    var_3._id_6293 = 1;

    if ( common_scripts\utility::array_contains( var_3.modules, "orbital_strike_laser_burst1" ) )
        var_3._id_6293++;

    if ( common_scripts\utility::array_contains( var_3.modules, "orbital_strike_laser_burst2" ) )
        var_3._id_6293++;

    var_3._id_A310 = common_scripts\utility::array_contains( var_3.modules, "orbital_strike_laser_width" );
    var_3._id_1363 = common_scripts\utility::array_contains( var_3.modules, "orbital_strike_laser_beam" );
    var_3._id_37D4 = 6;

    if ( common_scripts\utility::array_contains( var_3.modules, "orbital_strike_laser_duration" ) )
        var_3._id_37D4 *= 1.5;

    self._id_2199 = 1;
    thread _id_5E8A( var_3 );
    thread _id_5E88( var_3 );
    thread _id_5E9A( var_3 );
    thread _id_5EA9( var_3 );
    thread _id_5E60( var_3 );
    thread _id_6C7C( var_3 );
    thread _id_A1F5( var_3, self );
    thread onplayerconnect( var_3, self );
    return 1;
}

onplayerconnect( var_0, var_1 )
{
    var_1 endon( "OrbitalStrikeStreakComplete" );
    var_1 endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "PossessHoldTimeComplete" );
    var_0 endon( "leaving" );

    for (;;)
    {
        level waittill( "connected", var_2 );
        var_2 thread _id_A01C( var_0, var_1 );
    }
}

_id_A3F5( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin + ( 0.0, 0.0, 3000.0 ) );
    var_1.angles = vectortoangles( ( 0.0, 0.0, 1.0 ) );
    var_1 setmodel( "tag_origin" );
    var_1 thread _id_9FFC( 5 );
    var_2 = common_scripts\utility::array_add( maps\mp\_utility::get_players_watching(), self );

    foreach ( var_4 in var_2 )
    {
        var_4 setclientomnvar( "cam_scene_name", "odin_zoom_down" );
        var_4 setclientomnvar( "cam_scene_lead", var_0 getentitynumber() );
        var_4 setclientomnvar( "cam_scene_support", var_1 getentitynumber() );
        var_4 playlocalsound( "vulcan_hud_transition" );
        var_4 thread _id_1FEE( var_0 );
    }
}

_id_1FEE( var_0 )
{
    level endon( "game_ended" );
    var_1 = spawn( "script_model", var_0.origin + ( 0.0, 0.0, -1000.0 ) );
    var_1.angles = vectortoangles( ( 0.0, 0.0, 1.0 ) );
    var_1 setmodel( "tag_origin" );
    var_1 thread _id_9FFC( 5 );
    playfxontagforclients( level._effect["orbital_laser_clouds"], var_1, "tag_origin", self );
}

_id_9FFC( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait(var_0);
    self delete();
}

_id_992C()
{
    self setclientomnvar( "ui_orbital_laser", 1 );
    self setclientomnvar( "ui_orbital_laser_mode", 0 );
    self setclientomnvar( "ui_orbital_laser_charge", 0 );
    self setclientomnvar( "ui_orbital_laser_bursts", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
}

_id_851C( var_0 )
{
    thread _id_070F();
    self setclientomnvar( "ui_orbital_laser_mode", 1 );
    self setclientomnvar( "ui_orbital_laser_bursts", var_0._id_6293 );
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
}

_id_655F( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "OrbitalStrikeStreakComplete" );
    var_2 = gettime() + var_1 * 1000;
    self setclientomnvar( "ui_orbital_laser_charge", var_2 );
    self setclientomnvar( "ui_orbital_laser_mode", 1 );
    self playrumbleonentity( "orbital_laser_charge" );
    _id_6DEA( var_0, 0 );
    wait 0.1;
    _id_6DE9( var_0 );
}

_id_655E( var_0, var_1 )
{
    var_2 = gettime() + var_1 * 1000;
    self setclientomnvar( "ui_orbital_laser_charge", var_2 );
    self stoprumble( "orbital_laser_charge" );
    self playrumbleonentity( "orbital_laser_charge_quick" );
    _id_6DEA( var_0, 1 );
}

_id_6560( var_0 )
{
    self setclientomnvar( "ui_orbital_laser_charge", 0 );
    self stoprumble( "orbital_laser_charge" );
    self stoprumble( "orbital_laser_charge_quick" );
    self _meth_80AE( "orbital_laser_fire" );
}

_id_242F( var_0, var_1 )
{
    var_2 = gettime() + var_1 * 1000;
    thread _id_655F( var_0, var_1 );
    maps\mp\_utility::waitfortimeornotify( var_1, "StartFire" );
    var_3 = var_2 - gettime();

    if ( var_3 > 2500 )
    {
        _id_655E( var_0, 1.1 );
        wait 1.1;
    }
    else
        _id_8F06( var_0 );

    _id_6560( var_0 );
}

_id_486F( var_0 )
{
    self setclientomnvar( "ui_orbital_laser_mode", 2 );
}

_id_7F85( var_0 )
{
    self setclientomnvar( "ui_orbital_laser_bursts", var_0._id_6293 );
}

_id_4061()
{
    if ( isdefined( level._id_655C._id_89DC ) )
        return level._id_655C._id_89DC;

    var_0 = maps\mp\killstreaks\_aerial_utility::_id_3FC1();
    var_1 = var_0.origin[2] + 1024;

    if ( isdefined( level._id_099D ) && isdefined( level._id_099D._id_89DC ) )
        var_1 += level._id_099D._id_89DC;

    return var_1;
}

_id_3776()
{
    if ( !isdefined( self._id_8F4B ) )
        self._id_8F4B = spawnstruct();

    var_0 = maps\mp\killstreaks\_aerial_utility::_id_3FC1();
    var_1 = _id_4061();
    var_2 = level.mapcenter;

    if ( isdefined( level._id_655C.spawnpoint ) )
        var_2 = level._id_655C.spawnpoint;

    self._id_8F4B.origin = var_2 + ( 0, 0, var_1 );
    self._id_8F4B.angles = ( 0, self.angles[1], 0 );
    return self._id_8F4B;
}

_id_5E89( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    thread maps\mp\killstreaks\_aerial_utility::_id_6CB4( var_0, "OrbitalStrikeStreakComplete" );
    var_0 waittill( "outOfBounds" );
    wait 2;
    var_0 notify( "leaving" );
}

_id_6C7C( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    thread maps\mp\_utility::freezecontrolswrapper( 1 );
    thread _id_5E89( var_0 );
    maps\mp\_utility::playersaveangles();
    wait 0.45;
    thread _id_834D( 0.5 );
    _id_A3F5( var_0 );
    _id_992C();
    wait 1.5;
    maps\mp\killstreaks\_aerial_utility::_id_6D51();
    thread maps\mp\_utility::freezecontrolswrapper( 0 );
    maps\mp\_utility::_giveweapon( "orbital_laser_fov_mp" );
    self switchtoweapon( "orbital_laser_fov_mp" );
    common_scripts\utility::_disableweaponswitch();
    self unlink();
    var_0 _meth_8253( 0, 0, 0 );
    var_0 _meth_8252( ( 0.0, 0.0, 0.0 ), 0, 0 );
    thread _id_5665( var_0 );
    thread _id_6DB6( var_0 );
    self setangles( ( 0.0, 0.0, 0.0 ) );
    self _meth_8206( var_0 );
    wait 0.05;
    self cameralinkto( var_0, "tag_origin" );
    wait 0.55;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_0.killcamstarttime = gettime();
    _id_851C( var_0 );
    thread _id_A2DF( var_0 );
}

_id_7FE3()
{
    if ( self getstance() == "prone" )
        self setstance( "crouch" );
}

_id_5665( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_1 = 5;

    for (;;)
    {
        self waittill( "ToggleControlState" );
        thread _id_1ABE();
        self._id_493C = 1;

        for ( var_2 = 0; var_2 <= var_1; var_2++ )
        {
            wait 0.1;

            if ( self._id_493C == 1 && var_2 == var_1 )
            {
                var_0 notify( "PossessHoldTimeComplete" );
                continue;
            }

            if ( self._id_493C == 0 )
                break;
        }
    }
}

_id_1ABE()
{
    self endon( "OrbitalStrikeStreakComplete" );
    self endon( "PossessHoldTimeComplete" );
    self waittill( "ToggleControlCancel" );
    self._id_493C = 0;
}

_id_070F()
{
    self _meth_851A( 0 );
    self thermalvisionfofoverlayon();
    self setblurforplayer( 1.1, 0 );
    var_0 = 0.125;
    var_1 = 8500;
    var_2 = 0.125;
    var_3 = 5500;
    var_4 = 20;
    var_5 = 30;
    thread maps\mp\killstreaks\_aerial_utility::_id_92FD( "OrbitalStrikeStreakComplete", var_0, var_1, var_2, var_3, var_4, var_5 );
}

_id_6DB6( var_0 )
{
    var_1 = common_scripts\utility::array_add( maps\mp\_utility::get_players_watching(), self );

    if ( isdefined( var_0 ) )
        var_0 thread maps\mp\_utility::playloopsoundtoplayers( "vulcan_interior_loop_plr", undefined, var_1 );

    common_scripts\utility::waittill_any( "OrbitalStrikeStreakComplete" );

    if ( isdefined( var_0 ) )
        var_0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_interior_loop_plr" );
}

_id_A2D5( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_1 = gettime() + var_0._id_37D4 * 1000;
    self setclientomnvar( "ui_orbital_laser_fire", var_1 );
    wait(var_0._id_37D4);
    self setclientomnvar( "ui_orbital_laser_fire", 0 );
    var_0 notify( "stop_charge" );
}

_id_3FF9( var_0 )
{
    if ( var_0._id_A310 )
        return 256;
    else
        return 128;
}

_id_A2DF( var_0 )
{
    var_1 = anglestoforward( var_0.angles );
    var_2 = anglestoright( var_0.angles );
    var_3 = var_0 gettagorigin( "tag_origin" ) + var_1 * 30;
    var_4 = ( 0.0, 0.0, -1.0 );
    var_5 = var_3 + var_4 * 5000;
    var_6 = bullettrace( var_3, var_5, 0, var_0 );
    var_7 = var_6["position"];
    var_8 = _id_3FF9( var_0 );
    var_0._id_A2D3 = spawn( "script_model", var_3 );
    var_0._id_A2D3 setmodel( "generic_prop_raven" );
    var_0._id_A2D3 linktosynchronizedparent( var_0, "tag_origin" );
    var_9 = var_7;
    var_10 = vectortoangles( var_9 - var_3 );
    var_11 = spawn( "script_model", var_3 );
    var_11 setmodel( "tag_origin" );
    var_11.angles = var_10;
    var_11 linktosynchronizedparent( var_0._id_A2D3, "tag_origin" );
    var_0._id_A2E5 = var_11;
    var_12 = spawn( "script_model", var_9 );
    var_12.angles = ( -90.0, 0.0, 0.0 );
    var_12 setmodel( "tag_origin" );
    var_12 setotherent( var_11 );
    var_12 show();
    var_0._id_A2E5._id_91C0 = var_12;

    if ( var_0._id_1363 )
    {
        var_9 = var_7 + var_1 * var_8;
        var_10 = vectortoangles( var_9 - var_3 );
        var_13 = spawn( "script_model", var_3 );
        var_13 setmodel( "tag_origin" );
        var_13.angles = var_10;
        var_13 linktosynchronizedparent( var_0._id_A2D3, "j_prop_1" );
        var_0._id_A2E6 = var_13;
        var_14 = spawn( "script_model", var_9 );
        var_14.angles = ( -90.0, 0.0, 0.0 );
        var_14 setmodel( "tag_origin" );
        var_14 setotherent( var_13 );
        var_14 show();
        var_0._id_A2E6._id_91C0 = var_14;
        var_15 = sin( 60 ) * var_8;
        var_16 = cos( 60 ) * var_8;
        var_9 = var_7 - var_1 * var_16 + var_2 * var_15;
        var_10 = vectortoangles( var_9 - var_3 );
        var_17 = spawn( "script_model", var_3 );
        var_17 setmodel( "tag_origin" );
        var_17.angles = var_10;
        var_17 linktosynchronizedparent( var_0._id_A2D3, "j_prop_1" );
        var_0._id_A2E7 = var_17;
        var_18 = spawn( "script_model", var_9 );
        var_18.angles = ( -90.0, 0.0, 0.0 );
        var_18 setmodel( "tag_origin" );
        var_18 setotherent( var_17 );
        var_18 show();
        var_0._id_A2E7._id_91C0 = var_18;
        var_9 = var_7 - var_1 * var_16 - var_2 * var_15;
        var_10 = vectortoangles( var_9 - var_3 );
        var_19 = spawn( "script_model", var_3 );
        var_19 setmodel( "tag_origin" );
        var_19.angles = var_10;
        var_19 linktosynchronizedparent( var_0._id_A2D3, "j_prop_1" );
        var_0._id_A2E8 = var_19;
        var_20 = spawn( "script_model", var_9 );
        var_20.angles = ( -90.0, 0.0, 0.0 );
        var_20 setmodel( "tag_origin" );
        var_20 setotherent( var_19 );
        var_20 show();
        var_0._id_A2E8._id_91C0 = var_20;
    }

    thread _id_8A5C( var_0 );
    thread _id_5E8B( var_0 );
}

_id_2875( var_0 )
{
    if ( isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 delete();
        var_0._id_A2E5 delete();

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 delete();
            var_0._id_A2E6 delete();
            var_0._id_A2E7._id_91C0 delete();
            var_0._id_A2E7 delete();
            var_0._id_A2E8._id_91C0 delete();
            var_0._id_A2E8 delete();
        }
    }

    if ( isdefined( var_0._id_A2D3 ) )
        var_0._id_A2D3 delete();
}

_id_8A5C( var_0 )
{
    var_0._id_A2D3 scriptmodelplayanim( "mp_generic_prop_spin", "hello" );
}

_id_5E8B( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 _meth_8263();
    wait 1;
    var_1 = 6;

    while ( var_0._id_6293 > 0 )
    {
        _id_242F( var_0, var_1 );
        var_0._id_6293--;
        _id_7F85( var_0 );
        thread _id_A2D5( var_0 );
        _id_486F( var_0 );
        _id_54FF( var_0 );
        wait 0.1;
    }

    var_0 notify( "done" );
}

_id_64A0( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 5.0;

    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "tag_origin" );
    var_2 linktosynchronizedparent( self );
    var_2 playsound( var_0 );
    var_2 thread _id_9FFC( var_1 );
}

_id_64A1( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 5.0;

    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( "tag_origin" );
    var_2 playsound( var_0 );
    var_2 thread _id_9FFC( var_1 );
}

_id_8D23( var_0 )
{
    var_0._id_6DB4 = 1;
    var_1 = common_scripts\utility::array_add( maps\mp\_utility::get_players_watching(), self );
    var_0._id_A2E5._id_91C0 thread common_scripts\utility::play_loop_sound_on_entity( "vulcan_beam_loop_npc" );
    var_0._id_A2E5._id_91C0 thread common_scripts\utility::play_loop_sound_on_entity( "vulcan_impact_loop_npc" );
    var_0._id_A2E5._id_91C0 _id_64A0( "vulcan_shot_snap_npc" );
    var_0._id_A2E5._id_91C0 _id_64A0( "vulcan_shot_tail_npc" );
    var_2 = "vulcan_std_beam_loop_plr";

    if ( var_0._id_1363 )
        var_2 = "vulcan_lshow_beam_loop_plr";
    else if ( var_0._id_A310 )
        var_2 = "vulcan_wide_beam_loop_plr";

    var_0 thread maps\mp\_utility::playloopsoundtoplayers( "vulcan_beam_loop_plr", undefined, var_1 );
    var_0 thread maps\mp\_utility::playloopsoundtoplayers( var_2, undefined, var_1 );
    var_3 = "vulcan_shot_snap_plr";

    if ( var_0._id_1363 )
        var_3 = "vulcan_shot_snap_lshow_plr";
    else if ( var_0._id_A310 )
        var_3 = "vulcan_shot_snap_wide_plr";

    self playlocalsound( var_3 );
    self playlocalsound( "vulcan_shot_tail_plr" );
}

_id_8EEF( var_0 )
{
    if ( isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_beam_loop_npc" );
        var_0._id_A2E5._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_impact_loop_npc" );

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_beam_loop_npc" );
            var_0._id_A2E6._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_impact_loop_npc" );
            var_0._id_A2E7._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_beam_loop_npc" );
            var_0._id_A2E7._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_impact_loop_npc" );
            var_0._id_A2E8._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_beam_loop_npc" );
            var_0._id_A2E8._id_91C0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_impact_loop_npc" );
        }
    }

    var_1 = "vulcan_std_beam_loop_plr";

    if ( var_0._id_A310 )
        var_1 = "vulcan_wide_beam_loop_plr";

    var_0 common_scripts\utility::stop_loop_sound_on_entity( "vulcan_beam_loop_plr" );
    var_0 common_scripts\utility::stop_loop_sound_on_entity( var_1 );

    if ( isdefined( var_0._id_6DB4 ) && var_0._id_6DB4 )
    {
        var_0._id_6DB4 = 0;

        if ( isdefined( var_0._id_A2E5 ) )
        {
            var_0._id_A2E5._id_91C0 _id_64A1( "vulcan_beam_stop_npc" );

            if ( var_0._id_1363 )
            {
                var_0._id_A2E6._id_91C0 _id_64A1( "vulcan_beam_stop_npc" );
                var_0._id_A2E7._id_91C0 _id_64A1( "vulcan_beam_stop_npc" );
                var_0._id_A2E8._id_91C0 _id_64A1( "vulcan_beam_stop_npc" );
            }
        }

        if ( self._id_2199 )
        {
            var_2 = 1;

            if ( isdefined( self ) && var_2 )
                self playlocalsound( "vulcan_beam_stop_plr" );
        }
    }
}

_id_54FF( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    _id_8F05( var_0 );
    waitframe();
    waitframe();
    thread _id_37D8( var_0 );
    thread _id_54FB( var_0 );
    thread _id_54FD( var_0 );
    thread _id_54F0( var_0 );
    thread _id_54EF( var_0 );
    self _meth_84E2( 0.3 );
    var_0 waittill( "stop_charge" );
    self _meth_84E2( 1.0 );
}

_id_54EF( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_0 endon( "PossessHoldTimeComplete" );
    var_0 endon( "leaving" );
    var_0 endon( "stop_charge" );
    var_1 = _id_3FF9( var_0 );

    for (;;)
    {
        var_0 entityradiusdamage( var_0._id_A2E5._id_91C0.origin + ( 0.0, 0.0, 8.0 ), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp" );

        if ( isdefined( level.ishorde ) && level.ishorde && isdefined( level.flying_attack_drones ) )
        {
            foreach ( var_3 in level.flying_attack_drones )
            {
                if ( var_3.origin[2] > var_0._id_A2E5._id_91C0.origin[2] && _func_220( var_3.origin, var_0._id_A2E5._id_91C0.origin ) < int( var_1 * var_1 / 9 ) )
                    var_3 dodamage( 90, var_0._id_A2E5._id_91C0.origin, self, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp" );
            }
        }

        if ( var_0._id_1363 )
        {
            var_0 entityradiusdamage( var_0._id_A2E6._id_91C0.origin + ( 0.0, 0.0, 8.0 ), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp" );
            var_0 entityradiusdamage( var_0._id_A2E7._id_91C0.origin + ( 0.0, 0.0, 8.0 ), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp" );
            var_0 entityradiusdamage( var_0._id_A2E8._id_91C0.origin + ( 0.0, 0.0, 8.0 ), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp" );
        }

        glassradiusdamage( var_0._id_A2E5._id_91C0.origin + ( 0.0, 0.0, 32.0 ), var_1 * 2, 200, 200 );

        if ( var_0._id_1363 )
        {
            glassradiusdamage( var_0._id_A2E6._id_91C0.origin + ( 0.0, 0.0, 32.0 ), var_1 * 2, 200, 200 );
            glassradiusdamage( var_0._id_A2E7._id_91C0.origin + ( 0.0, 0.0, 32.0 ), var_1 * 2, 200, 200 );
            glassradiusdamage( var_0._id_A2E8._id_91C0.origin + ( 0.0, 0.0, 32.0 ), var_1 * 2, 200, 200 );
        }

        wait 0.15;
    }
}

_id_A1F5( var_0, var_1 )
{
    foreach ( var_3 in level.players )
        var_3 thread _id_A01C( var_0, var_1 );
}

_id_A01C( var_0, var_1 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_0 endon( "PossessHoldTimeComplete" );
    var_0 endon( "leaving" );

    for (;;)
    {
        self waittill( "death", var_2, var_3, var_4 );

        if ( isdefined( var_4 ) && isdefined( var_2 ) && var_2 == var_1 && var_4 == "orbital_laser_fov_mp" )
        {
            var_5 = 10;

            for ( var_6 = 0; var_6 < var_5; var_6++ )
            {
                wait 0.05;

                if ( isdefined( self ) && isdefined( self.body ) )
                {
                    playfxontag( level._effect["orbital_laser_death"], self.body, "tag_origin" );
                    break;
                }
            }
        }

        wait 0.05;
    }
}

_id_54F0( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_0 endon( "PossessHoldTimeComplete" );
    var_0 endon( "leaving" );
    var_0 endon( "stop_charge" );
    var_1 = _id_3FF9( var_0 );
    var_2 = 2;

    for (;;)
    {
        var_3 = randomfloatrange( 0.65, 0.8 );
        var_4 = randomintrange( -180, 180 );
        var_5 = ( var_0._id_A2E5._id_91C0.angles[0] * var_3, var_4, var_4 );
        var_6 = anglestoforward( var_5 );
        physicsexplosionsphere( var_0._id_A2E5._id_91C0.origin + ( 0.0, 0.0, 1.0 ), var_1, 96, var_2 );
        wait 0.4;
    }
}

_id_37D8( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    _id_6D9A( var_0 );
    _id_6A2C( var_0 );
    _id_8D23( var_0 );
    var_0 waittill( "stop_charge" );

    if ( isdefined( var_0 ) )
    {
        _id_8EDF( var_0 );
        _id_8ED8( var_0 );
        _id_8EEF( var_0 );
    }
}

_id_54FB( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_0 endon( "stop_weapon" );
    var_0 endon( "stop_charge" );
    var_1 = 0.25;
    earthquake( 0.07, var_1, var_0.origin, 256 );
    wait(var_1);
}

_id_54FD( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 endon( "death" );
    var_0 endon( "stop_weapon" );
    var_0 endon( "stop_charge" );
    var_1 = 0.25;
    earthquake( 0.5, var_1, var_0._id_A2E5._id_91C0.origin + ( 0.0, 0.0, 16.0 ), 384 );
    wait(var_1);
}

_id_6A3F( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_3 = self _meth_850D();

    if ( var_3 )
        playfxontag( var_1, self, "tag_origin" );
    else
        playfxontag( var_0, self, "tag_origin" );

    for (;;)
    {
        var_4 = var_3;
        var_3 = self _meth_850D();

        if ( var_3 != var_4 )
        {
            if ( var_3 )
            {
                stopfxontag( var_0, self, "tag_origin" );
                playfxontag( var_1, self, "tag_origin" );
            }
            else
            {
                stopfxontag( var_1, self, "tag_origin" );
                playfxontag( var_0, self, "tag_origin" );
            }
        }

        var_5 = common_scripts\utility::waittill_notify_or_timeout_return( var_2, 0.05 );

        if ( !isdefined( var_5 ) || var_5 != "timeout" )
            break;
    }

    if ( var_3 )
        stopfxontag( var_1, self, "tag_origin" );
    else
        stopfxontag( var_0, self, "tag_origin" );
}

_id_6DE9( var_0 )
{
    var_1 = "stop_warmup_fx";
    var_2 = _id_4159( var_0 );
    var_3 = _id_4159( var_0, 1 );
    var_0._id_A2E5._id_91C0 thread _id_6A3F( var_2, var_3, var_1 );

    if ( var_0._id_1363 )
    {
        var_4 = _id_415A( var_0 );
        var_5 = _id_415A( var_0, 1 );
        var_0._id_A2E6._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
        var_0._id_A2E7._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
        var_0._id_A2E8._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
    }
}

_id_8F05( var_0 )
{
    var_1 = "stop_warmup_fx";

    if ( isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 notify( var_1 );

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 notify( var_1 );
            var_0._id_A2E7._id_91C0 notify( var_1 );
            var_0._id_A2E8._id_91C0 notify( var_1 );
        }
    }
}

_id_4159( var_0, var_1 )
{
    var_2 = "orbital_laser_warmup";

    if ( var_0._id_A310 )
        var_2 += "_wide";

    if ( isdefined( var_1 ) && var_1 )
        var_2 += "_water";

    return common_scripts\utility::getfx( var_2 );
}

_id_415A( var_0, var_1 )
{
    var_2 = "orbital_laser_warmup_lightshow";

    if ( var_0._id_A310 )
        var_2 += "_wide";

    if ( isdefined( var_1 ) && var_1 )
        var_2 += "_water";

    return common_scripts\utility::getfx( var_2 );
}

_id_6DEA( var_0, var_1 )
{
    _id_8F06( var_0 );
    var_2 = "vulcan_charge_start_npc";
    var_3 = "vulcan_charge_start_plr";

    if ( var_1 )
    {
        var_2 = "vulcan_charge_up_npc";
        var_3 = "vulcan_charge_up_plr";
    }

    var_0._id_A2E5._id_91C0 _meth_8438( var_2 );

    if ( var_0._id_1363 )
    {
        var_0._id_A2E6._id_91C0 _meth_8438( var_2 );
        var_0._id_A2E7._id_91C0 _meth_8438( var_2 );
        var_0._id_A2E8._id_91C0 _meth_8438( var_2 );
    }

    self playlocalsound( var_3 );
}

_id_8F06( var_0 )
{
    if ( isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 stopsounds();

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 stopsounds();
            var_0._id_A2E7._id_91C0 stopsounds();
            var_0._id_A2E8._id_91C0 stopsounds();
        }
    }

    if ( isdefined( self ) )
    {
        self stoplocalsound( "vulcan_charge_start_plr" );
        self stoplocalsound( "vulcan_charge_up_plr" );
    }
}

_id_6D9A( var_0 )
{
    var_1 = "stop_fire_fx";
    var_2 = _id_3F92( var_0 );
    var_3 = _id_3F92( var_0, 1 );
    var_4 = _id_3F93( var_0 );
    var_5 = _id_3F93( var_0, 1 );

    if ( var_0._id_1363 )
    {
        var_0._id_A2E5._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
        var_0._id_A2E6._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
        var_0._id_A2E7._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
        var_0._id_A2E8._id_91C0 thread _id_6A3F( var_4, var_5, var_1 );
    }
    else
        var_0._id_A2E5._id_91C0 thread _id_6A3F( var_2, var_3, var_1 );
}

_id_8EDF( var_0 )
{
    var_1 = "stop_fire_fx";

    if ( isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 notify( var_1 );

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 notify( var_1 );
            var_0._id_A2E7._id_91C0 notify( var_1 );
            var_0._id_A2E8._id_91C0 notify( var_1 );
        }

        _id_6DBB( var_0 );
    }
}

_id_6DBB( var_0 )
{
    var_1 = var_0._id_A2E5._id_91C0;

    if ( var_1 _meth_850D() )
        playfx( level._effect["orbital_laser_ending_water"], var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
    else
        playfx( level._effect["orbital_laser_ending"], var_1.origin, anglestoforward( var_1.angles ), anglestoup( var_1.angles ) );
}

_id_3F92( var_0, var_1 )
{
    var_2 = "orbital_laser_fire";

    if ( var_0._id_A310 )
        var_2 += "_wide";

    if ( isdefined( var_1 ) && var_1 )
        var_2 += "_water";

    return common_scripts\utility::getfx( var_2 );
}

_id_3F93( var_0, var_1 )
{
    var_2 = "orbital_laser_fire_lightshow";

    if ( var_0._id_A310 )
        var_2 += "_wide";

    if ( isdefined( var_1 ) && var_1 )
        var_2 += "_water";

    return common_scripts\utility::getfx( var_2 );
}

_id_6A2C( var_0 )
{
    var_1 = _id_3F10( var_0 );
    playfxontag( var_1, var_0._id_A2E5._id_91C0, "tag_origin" );

    if ( var_0._id_1363 )
    {
        var_2 = _id_4002( var_0 );
        playfxontag( var_2, var_0._id_A2E6._id_91C0, "tag_origin" );
        playfxontag( var_2, var_0._id_A2E7._id_91C0, "tag_origin" );
        playfxontag( var_2, var_0._id_A2E8._id_91C0, "tag_origin" );
    }
}

_id_8ED8( var_0 )
{
    var_1 = _id_3F10( var_0 );
    waitframe();

    if ( isdefined( var_0._id_A2E5 ) )
    {
        stopfxontag( var_1, var_0._id_A2E5._id_91C0, "tag_origin" );

        if ( var_0._id_1363 )
        {
            var_2 = _id_4002( var_0 );
            stopfxontag( var_2, var_0._id_A2E6._id_91C0, "tag_origin" );
            stopfxontag( var_2, var_0._id_A2E7._id_91C0, "tag_origin" );
            stopfxontag( var_2, var_0._id_A2E8._id_91C0, "tag_origin" );
        }
    }
}

_id_6DBC( var_0 )
{
    playfxontag( "orbital_laser_smoldering", var_0._id_A2E5._id_91C0, "tag_origin" );
}

_id_3F10( var_0 )
{
    var_1 = "orbital_laser_beam";

    if ( var_0._id_A310 )
        var_1 += "_wide";

    return common_scripts\utility::getfx( var_1 );
}

_id_4002( var_0 )
{
    var_1 = "orbital_laser_beam_lightshow";

    if ( var_0._id_A310 )
        var_1 += "_wide";

    return common_scripts\utility::getfx( var_1 );
}

_id_6562( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "OrbitalStrikeStreakComplete" );
    wait(var_0);
    var_1 notify( "leaving" );
}

_id_5E88( var_0 )
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 waittill( "death", var_1, var_2, var_3 );
    var_0 maps\mp\gametypes\_damage::onkillstreakkilled( var_1, var_3, var_2, var_0.health + 1, "vulcan_destroyed", undefined, undefined, 1 );
    var_0 notify( "finish_death" );
}

_id_5E8A( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    var_0 common_scripts\utility::waittill_any( "leaving", "crashing", "PossessHoldTimeComplete", "done", "finish_death" );
    thread _id_6561( var_0 );
}

_id_41E1( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0._id_A2E5 ) )
    {
        var_0._id_A2E5._id_91C0 setotherent( undefined );

        if ( var_0._id_1363 )
        {
            var_0._id_A2E6._id_91C0 setotherent( undefined );
            var_0._id_A2E7._id_91C0 setotherent( undefined );
            var_0._id_A2E8._id_91C0 setotherent( undefined );
        }
    }

    self setclientomnvar( "ui_orbital_laser_charge", 0 );
    self setclientomnvar( "ui_orbital_laser_mode", 0 );
    self setclientomnvar( "ui_orbital_laser_bursts", 0 );
    self setclientomnvar( "ui_orbital_laser_fire", 0 );
    self setclientomnvar( "ui_orbital_laser", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C89();
    self takeweapon( "orbital_laser_fov_mp" );

    if ( self.disabledweaponswitch > 0 )
        common_scripts\utility::_enableweaponswitch();

    self setblurforplayer( 0, 0 );
    self _meth_851A( 1 );
    maps\mp\killstreaks\_aerial_utility::_id_2B1E( self );
    self thermalvisionfofoverlayoff();
    self _meth_8207();
    self controlsunlink();
    self cameraunlink();

    if ( maps\mp\_utility::isusingremote() )
        maps\mp\_utility::clearusingremote();

    thread _id_27D1();
    thread _id_73E5( 0.5 );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::setthirdpersondof( 1 );

    maps\mp\_utility::playerrestoreangles();
    self notify( "player_control_strike_over" );
}

_id_27D1()
{
    self freezecontrols( 1 );
    wait 0.5;
    self freezecontrols( 0 );
}

_id_5E9A( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    self waittill( "disconnect" );
    thread _id_6561( var_0, 1 );
}

_id_5EA9( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    common_scripts\utility::waittill_either( "joined_team", "joined_spectators" );
    thread _id_6561( var_0 );
}

_id_5E60( var_0 )
{
    self endon( "OrbitalStrikeStreakComplete" );
    level waittill( "game_ended" );
    thread _id_6561( var_0 );
}

_id_6561( var_0, var_1 )
{
    self notify( "OrbitalStrikeStreakComplete" );
    waittillframeend;

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !var_1 )
    {
        self._id_2199 = 0;
        _id_41E1( var_0 );
        _id_6D2D();
    }

    level._id_654F = common_scripts\utility::array_remove( level._id_654F, var_0 );

    if ( level.teambased )
        _id_7FCA( var_0.team, 0 );

    _id_8F06( var_0 );
    _id_8EEF( var_0 );
    _id_8F05( var_0 );
    _id_8EDF( var_0 );
    _id_8ED8( var_0 );
    _id_2875( var_0 );
    var_0 delete();
    maps\mp\_utility::decrementfauxvehiclecount();
    waitframe();

    if ( isdefined( self ) )
    {
        self stoprumble( "orbital_laser_charge" );
        self stoprumble( "orbital_laser_charge_quick" );
    }

    waitframe();

    if ( isdefined( self ) )
        self stoprumble( "orbital_laser_fire" );
}

_id_6C5A()
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "SwitchVisionMode", "+actionslot 1" );
        self notifyonplayercommand( "ToggleControlState", "+activate" );
        self notifyonplayercommand( "ToggleControlCancel", "-activate" );
        self notifyonplayercommand( "ToggleControlState", "+usereload" );
        self notifyonplayercommand( "ToggleControlCancel", "-usereload" );
        self notifyonplayercommand( "StartFire", "+attack" );
        self notifyonplayercommand( "StartFire", "+attack_akimbo_accessible" );
    }
}

_id_6D2D()
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "SwitchVisionMode", "+actionslot 1" );
        self notifyonplayercommandremove( "ToggleControlState", "+activate" );
        self notifyonplayercommandremove( "ToggleControlCancel", "-activate" );
        self notifyonplayercommandremove( "ToggleControlState", "+usereload" );
        self notifyonplayercommandremove( "ToggleControlCancel", "-usereload" );
        self notifyonplayercommandremove( "StartFire", "+attack" );
        self notifyonplayercommandremove( "StartFire", "+attack_akimbo_accessible" );
    }
}

_id_834D( var_0 )
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "OrbitalStrikeStreakComplete" );
    wait(var_0);

    if ( isdefined( level._id_9F74 ) )
        self setclienttriggervisionset( level._id_9F74, 0 );

    if ( isdefined( level._id_9F73 ) )
        self lightsetforplayer( level._id_9F73 );

    maps\mp\killstreaks\_aerial_utility::_id_45F0();
}

_id_73E5( var_0 )
{
    self setclienttriggervisionset( "", var_0 );
    self lightsetforplayer( "" );
    maps\mp\killstreaks\_aerial_utility::_id_45E2();
}
