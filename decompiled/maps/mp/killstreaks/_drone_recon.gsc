// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["emp_grenade"] = loadfx( "vfx/explosion/emp_grenade_explosion" );
    level._effect["antenna_light_mp"] = loadfx( "vfx/lights/light_reconugv_antenna" );
    level._effect["recon_drone_marker_threat"] = loadfx( "vfx/ui/vfx_marker_drone_recon" );
    level._effect["recon_drone_marker_emp"] = loadfx( "vfx/ui/vfx_marker_drone_recon2" );
    level._effect["recond_drone_exhaust"] = loadfx( "vfx/vehicle/vehicle_mp_recon_drone_smoke" );
    level._id_99E6 = [];
    thread onplayerconnect();
    level.killstreakfuncs["recon_ugv"] = ::_id_98B9;
    level.killstreakwieldweapons["recon_drone_turret_mp"] = "recon_ugv";
    level.killstreakwieldweapons["emp_grenade_killstreak_mp"] = "recon_ugv";
    level.killstreakwieldweapons["paint_grenade_killstreak_mp"] = "recon_ugv";
    game["dialog"]["ks_recdrone_destroyed"] = "ks_recdrone_destroyed";
}

_id_3F6D()
{
    var_0 = maps\mp\killstreaks\_drone_common::_id_2F0A();
    return var_0;
}

_id_98B9( var_0, var_1 )
{
    if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_2 = _id_3F6D();

    if ( !var_2._id_6862 )
    {
        self iclientprintlnbold( &"MP_DRONE_PLACEMENT_INVALID" );
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    common_scripts\utility::_disableweaponswitch();
    var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "recon_ugv" );

    if ( var_3 != "success" )
    {
        common_scripts\utility::_enableweaponswitch();
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    maps\mp\_utility::setusingremote( "recon_ugv" );
    var_4 = _id_2439( var_0, var_1, var_2.origin, var_2.angles );
    common_scripts\utility::_enableweaponswitch();
    self switchtoweapon( "killstreak_predator_missile_mp" );

    if ( isdefined( var_4 ) )
    {
        maps\mp\_matchdata::logkillstreakevent( "recon_ugv", self.origin );
        thread maps\mp\_utility::teamplayercardsplash( "used_recon_ugv", self );
        return 1;
    }
    else
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    var_0 = spawnstruct();
    var_0._id_59AB = [];
    var_0._id_59AD = [];
    var_0.owner = self;
    var_0._id_5E7F = 0;
    level._id_99E6 = common_scripts\utility::array_add( level._id_99E6, var_0 );
}

_id_2439( var_0, var_1, var_2, var_3 )
{
    var_4 = "recon_uav_mp";
    var_5 = "vehicle_atlas_aerial_drone_02_patrol_mp_static_75p";
    var_6 = spawnhelicopter( self, var_2, var_3, var_4, var_5 );

    if ( !isdefined( var_6 ) )
        return undefined;

    thread _id_6C7A( var_6, var_1, var_0 );
    var_6.maxhealth = 250;
    var_6.vehicletype = "drone_recon";
    var_6._id_9D76 = "recon_uav";
    var_6._id_59A3 = 1500;

    if ( var_6._id_472E )
        var_7 = 45.0;
    else
        var_7 = 30.0;

    var_6._id_56F5 = var_7;
    var_6.endtime = gettime() + var_7 * 1000;
    var_6 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_6.maxhealth, undefined, ::_id_64DA, maps\mp\killstreaks\_aerial_utility::_id_47D3, 1 );

    if ( var_6._id_4721 )
        thread maps\mp\killstreaks\_drone_common::_id_2EFF( var_6, var_6._id_4721 );

    _id_8D40( var_6 );
    thread _id_5ED7( var_6 );
    thread _id_5E9A( var_6 );
    thread _id_5EA8( var_6 );
    thread _id_5E9C( var_6 );
    thread _id_7275( var_6 );
    thread _id_7274( var_6 );
    thread _id_7273( var_6 );
    thread _id_7277( var_6 );
    thread maps\mp\killstreaks\_drone_common::playerwatchfordroneemp( var_6 );
    var_8 = spawnstruct();
    var_8._id_9C43 = 1;
    var_8.deathoverridecallback = ::_id_6617;
    var_6 thread maps\mp\_movers::handle_moving_platforms( var_8 );
    var_6._id_40F1 = ::_id_727D;
    return var_6;
}

_id_727D()
{
    return self gettagorigin( "tag_origin" );
}

_id_6617( var_0 )
{
    self notify( "death" );
}

_id_8324( var_0 )
{
    if ( isbot( self ) )
        return;

    self notifyonplayercommand( "recon_fire_main", "+attack" );
    self notifyonplayercommand( "recon_fire_main", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "recon_fire_secondary", "+speed_throw" );
    self notifyonplayercommand( "recon_fire_secondary", "+toggleads_throw" );
    self notifyonplayercommand( "recon_fire_secondary", "+ads_akimbo_accessible" );

    if ( common_scripts\utility::array_contains( var_0, "recon_ugv_cloak" ) )
    {
        self notifyonplayercommand( "Cloak", "+activate" );
        self notifyonplayercommand( "Cloak", "+usereload" );
    }
}

_id_2B20( var_0 )
{
    if ( isbot( self ) )
        return;

    self notifyonplayercommandremove( "recon_fire_main", "+attack" );
    self notifyonplayercommandremove( "recon_fire_main", "+attack_akimbo_accessible" );
    self notifyonplayercommandremove( "recon_fire_secondary", "+speed_throw" );
    self notifyonplayercommandremove( "recon_fire_secondary", "+toggleads_throw" );
    self notifyonplayercommandremove( "recon_fire_secondary", "+ads_akimbo_accessible" );

    if ( isdefined( var_0 ) && var_0._id_4721 )
    {
        self notifyonplayercommandremove( "Cloak", "+activate" );
        self notifyonplayercommandremove( "Cloak", "+usereload" );
    }
}

_id_6C7A( var_0, var_1, var_2 )
{
    self endon( "reconStreakComplete" );
    var_0 endon( "death" );
    self.using_remote_tank = 0;
    var_0.lifeid = var_2;
    var_0.team = self.team;
    var_0.owner = self;
    var_0.damagetaken = 0;
    var_0.destroyed = 0;
    var_0.empgrenaded = 0;
    var_0._id_259B = 1.0;
    var_0._id_59AC = [];
    var_0.modules = var_1;
    var_0._id_4716 = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_ar_hud" );
    var_0._id_473A = 1;
    var_0._id_4717 = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_assist_points" );
    var_0._id_4744 = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_stun" );
    var_0._id_472E = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_increased_time" );
    var_0._id_4721 = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_cloak" );
    var_0._id_4728 = common_scripts\utility::array_contains( var_0.modules, "recon_ugv_emp" );
    var_0 hide();
    var_0 makeunusable();
    var_0 _meth_8202( 23, -9, 23 );
    var_0 setcandamage( 1 );
    var_0 common_scripts\utility::make_entity_sentient_mp( var_0.team );
    _id_727C( var_0 );
    thread maps\mp\killstreaks\_drone_common::_id_2F27( var_0, var_0._id_4721 );
    wait 1.6;
    _id_8324( var_1 );
    thread _id_621A( var_0 );
    var_3 = "recon_drone_marker_threat";

    if ( var_0._id_4728 )
        var_3 = "recon_drone_marker_emp";

    thread maps\mp\killstreaks\_drone_common::_id_9B62( var_0, common_scripts\utility::getfx( var_3 ), 1 );
    thread maps\mp\killstreaks\_drone_common::_id_6CB7( var_0, "recond_drone_exhaust", "tag_exhaust" );
    var_0._id_5BD2 _meth_8106( var_0._id_91C2 );
    thread _id_727A( var_0 );
}

_id_727C( var_0 )
{
    var_1 = "recon_drone_turret_mp";
    var_2 = "tag_turret";
    var_3 = "vehicle_atlas_aerial_drone_02_patrol_mp_turret_75p";
    var_4 = spawnturret( "misc_turret", var_0 gettagorigin( var_2 ), var_1, 0 );
    var_4.angles = var_0 gettagangles( var_2 );
    var_4 setmodel( var_3 );
    var_4 _meth_815A( 45.0 );
    var_4 linkto( var_0, var_2, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4.owner = var_0.owner;
    var_4.health = 99999;
    var_4.maxhealth = 1000;
    var_4.damagetaken = 0;
    var_4.stunned = 0;
    var_4._id_8F70 = 0.0;
    var_4 setcandamage( 0 );
    var_4 setcanradiusdamage( 0 );
    var_4 makeunusable();
    var_4.team = var_0.team;
    var_4.pers["team"] = var_0.team;

    if ( level.teambased )
        var_4 _meth_8135( var_0.team );

    var_4 _meth_8065( "sentry_manual" );
    var_4 _meth_8103( var_0.owner );
    var_4 _meth_8105( 0 );
    var_4.chopper = var_0;
    var_4 setcontents( 0 );
    var_4._id_37E6 = spawn( "script_model", var_0 gettagorigin( var_2 ) );
    var_4._id_37E6 setmodel( "tag_origin" );
    var_4._id_37E6 linktosynchronizedparent( var_0, var_2, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4._id_37E6 setcontents( 0 );
    var_4 hide();
    var_0._id_5BD2 = var_4;

    if ( var_0._id_473A )
        thread _id_37EA( var_0 );

    if ( var_0._id_4728 )
        thread _id_37D5( var_0 );
}

_id_37EA( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    var_1 = gettime();
    var_2 = 0;

    for (;;)
    {
        self waittill( "recon_fire_main" );
        self notify( "ForceUncloak" );
        var_3 = var_0._id_5BD2 gettagorigin( "tag_aim" );
        var_4 = var_0._id_91C2.origin;

        if ( var_0._id_4744 && gettime() >= var_1 )
        {
            var_1 = gettime() + 6000;
            var_2 = 1;
        }

        maps\mp\killstreaks\_aerial_utility::_id_6C9C( var_0._id_5BD2._id_37E6, var_3, var_4, var_2, var_0 );
        self setclientomnvar( "ui_recondrone_paint", 2 );
        wait 2;
        self setclientomnvar( "ui_recondrone_paint", 1 );
        var_2 = 0;
    }
}

_id_37D5( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "recon_fire_secondary" );
        self notify( "ForceUncloak" );
        var_1 = var_0._id_5BD2 gettagorigin( "tag_aim" );
        var_2 = var_0._id_91C2.origin;
        maps\mp\killstreaks\_aerial_utility::_id_6C9B( var_0._id_5BD2._id_37E6, var_1, var_2 );
        self setclientomnvar( "ui_recondrone_emp", 2 );
        wait 5;
        self setclientomnvar( "ui_recondrone_emp", 1 );
    }
}

_id_621A( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        var_1 = common_scripts\utility::waittill_any_return( "recon_fire_main", "recon_fire_secondary", "Cloak" );

        if ( isdefined( var_1 ) )
            var_0 notify( var_1 );
    }
}

_id_8D40( var_0 )
{
    var_1 = self;

    if ( getdvarint( "camera_thirdPerson" ) )
        var_1 maps\mp\_utility::setthirdpersondof( 0 );

    var_1 maps\mp\_utility::playersaveangles();
    var_1 cameralinkto( var_0, "tag_origin" );
    var_1 _meth_8206( var_0 );
    var_1 thread maps\mp\killstreaks\_drone_common::_id_7F56( 1.5, var_0 );
    var_1.using_remote_tank = 1;

    if ( var_1 maps\mp\_utility::isjuggernaut() )
        var_1.juggernautoverlay.alpha = 0;
}

_id_7277( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    _id_7276( var_0 );
    wait 0.5;
    self setclientomnvar( "ui_recondrone_toggle", 1 );
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
    self setclientomnvar( "ui_recondrone_countdown", var_0.endtime );

    if ( var_0._id_4721 )
        self setclientomnvar( "ui_drone_cloak", 2 );

    if ( var_0._id_473A )
        self setclientomnvar( "ui_recondrone_paint", 1 );

    if ( var_0._id_4728 )
        self setclientomnvar( "ui_recondrone_emp", 1 );

    if ( var_0._id_4716 )
        self thermalvisionfofoverlayon();
}

_id_7276( var_0 )
{
    self setclientomnvar( "ui_recondrone_toggle", 0 );
    self setclientomnvar( "ui_recondrone_countdown", 0 );
    self setclientomnvar( "ui_drone_cloak", 0 );
    self setclientomnvar( "ui_drone_cloak_time", 0 );
    self setclientomnvar( "ui_drone_cloak_cooldown", 0 );
    self setclientomnvar( "ui_recondrone_paint", 0 );
    self setclientomnvar( "ui_recondrone_emp", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C89();
}

_id_5ED7( var_0 )
{
    self endon( "reconStreakComplete" );
    thread maps\mp\killstreaks\_aerial_utility::_id_6CB4( var_0, "reconStreakComplete" );
    thread maps\mp\killstreaks\_aerial_utility::_id_6CB9( var_0, "reconStreakComplete" );
    var_0 waittill( "outOfBounds" );
    wait 2;
    var_0 notify( "death" );
}

_id_5E9A( var_0 )
{
    self endon( "StopWaitForDisconnect" );
    var_0 endon( "death" );
    self waittill( "disconnect" );
    var_0 notify( "death" );
}

_id_5EA8( var_0 )
{
    self endon( "reconStreakComplete" );
    common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    var_0 notify( "death" );
}

_id_5E9C( var_0 )
{
    self endon( "reconStreakComplete" );
    level waittill( "game_ended" );
    var_0 notify( "death" );
}

_id_64DA( var_0, var_1, var_2, var_3 )
{
    self notify( "death", var_0, var_2, var_1 );
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "recon_drone_destroyed", undefined, "callout_destroyed_drone_recon", 1 );
}

_id_7275( var_0 )
{
    var_0 endon( "death" );
    var_1 = 10.0;
    var_2 = 1.0;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0._id_56F5 - var_1 );

    while ( var_1 > 0 )
    {
        var_0 playsound( "mp_warbird_outofbounds_warning" );
        var_1 -= var_2;
        wait(var_2);
    }

    var_0 notify( "death" );
}

_id_7274( var_0 )
{
    var_0 endon( "death" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0._id_56F5 );
    var_0 notify( "death" );
}

_id_7273( var_0 )
{
    var_1 = var_0 getentitynumber();
    var_0 maps\mp\killstreaks\_drone_common::_id_2EF4( var_1 );
    var_0 waittill( "death", var_2 );

    if ( isdefined( var_0 ) )
        var_0 ghost();

    if ( isdefined( var_0._id_5BD2 ) )
        var_0._id_5BD2 ghost();

    if ( isdefined( self ) )
        maps\mp\_utility::freezecontrolswrapper( 1 );

    self notify( "reconStreakComplete" );
    self notify( "StopWaitForDisconnect" );
    var_0 playsound( "assault_drn_death" );
    var_0 maps\mp\killstreaks\_drone_common::_id_2F17( var_1 );
    waitframe();
    playfxontag( level._effect["remote_tank_explode"], var_0, "tag_origin" );
    wait 1;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if ( isdefined( self ) && !level.gameended )
        maps\mp\_utility::freezecontrolswrapper( 0 );

    if ( isdefined( self ) && isdefined( var_2 ) && self != var_2 )
        thread maps\mp\_utility::leaderdialogonplayer( "ks_recdrone_destroyed", undefined, undefined, self.origin );

    if ( isdefined( self ) && ( self.using_remote_tank || maps\mp\_utility::isusingremote() ) )
    {
        _id_727B( var_0 );
        self.using_remote_tank = 0;

        if ( maps\mp\_utility::isjuggernaut() )
            self.juggernautoverlay.alpha = 1;
    }

    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( var_0._id_5BD2 ) )
    {
        if ( isdefined( var_0._id_5BD2._id_37E6 ) )
            var_0._id_5BD2._id_37E6 delete();

        var_0._id_5BD2 delete();
    }

    if ( isdefined( var_0._id_9304 ) )
        var_0._id_9304 delete();

    var_0 delete();
}

_id_727B( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = self;

    if ( isdefined( var_1.using_remote_tank ) && var_1.using_remote_tank )
    {
        var_1 notify( "end_remote" );
        var_1 _meth_8207( var_0 );
        var_1 thermalvisionfofoverlayoff();
        thread maps\mp\killstreaks\_drone_common::_id_739C( 1.5 );
        var_1 _id_7276( var_0 );
        var_1 _id_2B20( var_0 );

        if ( var_1 maps\mp\_utility::isusingremote() && !level.gameended )
            var_1 maps\mp\_utility::clearusingremote();

        var_2 = maps\mp\_utility::getkillstreakweapon( "recon_ugv" );
        var_1 takeweapon( var_2 );
        var_1 enableweaponswitch();
        var_1 switchtoweapon( common_scripts\utility::getlastweapon() );
        var_1 maps\mp\_utility::playerrestoreangles();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_1 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_1.disabledusability ) && var_1.disabledusability )
            var_1 common_scripts\utility::_enableusability();

        var_1.using_remote_tank = 0;
    }
}

_id_727A( var_0 )
{
    if ( !isdefined( self ) )
        return;

    var_1 = self;
    level endon( "game_ended" );
    var_1 endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        var_2 = 0;

        while ( var_1 usebuttonpressed() )
        {
            var_2 += 0.05;

            if ( var_2 > 0.75 )
            {
                var_0 notify( "death" );
                return;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}
