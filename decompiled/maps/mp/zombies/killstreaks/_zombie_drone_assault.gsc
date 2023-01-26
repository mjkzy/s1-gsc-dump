// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.dronesdeployed = 0;
    level._effect["assault_c4_explode"] = loadfx( "vfx/vehicle/vehicle_assault_drone_rocket" );
    level._effect["remote_tank_explode"] = loadfx( "vfx/explosion/vehicle_assault_drone_death" );
    level._effect["c4_forward_blur"] = loadfx( "vfx/unique/forward_view_radial_blur" );
    level._effect["assault_drone_exhaust"] = loadfx( "vfx/vehicle/vehicle_mp_assault_drone_exhaust" );
    level._effect["assault_drone_thruster"] = loadfx( "vfx/vehicle/vehicle_mp_assault_drone_thruster" );
    level._effect["assault_drone_marker"] = loadfx( "vfx/ui/vfx_marker_drone_assault" );
    level._effect["assault_drone_exhaust_bottom"] = loadfx( "vfx/vehicle/vehicle_mp_assault_drone_exhaust" );
    level.killstreakfuncs["zm_ugv"] = ::_id_98A3;
    level.killstreakwieldweapons["drone_assault_remote_turret_mp"] = "assault_ugv";
    level.killstreakwieldweapons["ugv_missile_mp"] = "assault_ugv";
    level.killstreakwieldweapons["assaultdrone_c4_mp"] = "assault_ugv";
    level.killstreakwieldweapons["killstreak_terrace_mp"] = "mp_terrace";
    thread maps\mp\zombies\killstreaks\_zombie_assaultdrone_ai::_id_0D47();
    game["dialog"]["ks_adrone_destroyed"] = "ks_adrone_destroyed";
}

_id_3F6D( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = spawnstruct();
    var_4._id_6862 = 1;

    if ( common_scripts\utility::array_contains( var_0, "mp_terrace" ) )
    {
        var_5 = getent( "killstreak_orbit_initial", "targetname" );
        var_6 = getent( "killstreak_orbit_lookat", "targetname" );

        if ( isdefined( var_5 ) && isdefined( var_6 ) )
        {
            var_4.origin = var_5.origin;
            var_4.angles = vectortoangles( var_6.origin - var_5.origin );
        }
        else
        {
            var_7 = common_scripts\utility::getstruct( "mp_terrace_killstreak_start", "targetname" );
            var_4.origin = var_7.origin;
            var_4.angles = var_7.angles;
        }
    }
    else
        var_4 = maps\mp\zombies\killstreaks\_zombie_drone_common::_id_2F0A();

    return var_4;
}

_id_98A3( var_0, var_1 )
{
    if ( maps\mp\zombies\_util::arekillstreaksdisabled() )
        return 0;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( isdefined( self._id_088E ) )
            self._id_088E notify( "death" );
    }

    if ( var_1.size == 0 )
        var_1 = [ "assault_ugv_ai", "assault_ugv_mg" ];

    var_2 = 1;

    if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    if ( level.dronesdeployed >= 2 )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    maps\mp\_utility::incrementfauxvehiclecount();
    var_3 = _id_3F6D( var_1 );

    if ( !var_3._id_6862 )
    {
        self iclientprintlnbold( &"MP_DRONE_PLACEMENT_INVALID" );
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    var_4 = common_scripts\utility::array_contains( var_1, "assault_ugv_ai" );

    if ( !var_4 )
    {
        var_5 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "assault_ugv" );

        if ( var_5 != "success" )
        {
            maps\mp\_utility::decrementfauxvehiclecount();
            return 0;
        }

        maps\mp\_utility::setusingremote( "assault_ugv" );
    }

    var_6 = _id_23E4( var_0, var_1, var_3.origin, var_3.angles );

    if ( isdefined( var_6 ) )
    {
        if ( common_scripts\utility::array_contains( var_1, "mp_terrace" ) )
        {
            maps\mp\_matchdata::logkillstreakevent( "mp_terrace", self.origin );
            thread maps\mp\_utility::teamplayercardsplash( "used_mp_terrace", self );
        }
        else
        {
            maps\mp\_matchdata::logkillstreakevent( "assault_ugv", self.origin );
            thread maps\mp\_utility::teamplayercardsplash( "used_assault_ugv", self );
        }

        if ( isdefined( level.ishorde ) && level.ishorde )
            self._id_088E = var_6;

        thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "ss_use_assault_drone" );
        level.dronesdeployed++;
        return 1;
    }
    else
        return 0;
}

_id_23E4( var_0, var_1, var_2, var_3 )
{
    var_4 = common_scripts\utility::array_contains( var_1, "assault_ugv_mg" ) || common_scripts\utility::array_contains( var_1, "assault_ugv_rockets" ) || common_scripts\utility::array_contains( var_1, "mp_terrace" );
    var_5 = common_scripts\utility::array_contains( var_1, "mp_terrace" );
    var_6 = "assault_uav_mp";
    var_7 = 90;

    if ( var_4 )
        var_6 = "mg_assault_uav_mp";

    var_8 = "vehicle_atlas_aerial_drone_01_assult_mp_noturret_clr_50p";

    if ( !var_4 )
        var_8 = "vehicle_atlas_aerial_drone_01_patrol_mp_static_clr_01_50p";

    if ( var_5 )
    {
        var_6 = "assault_uav_mp_terrace";
        var_8 = "vehicle_sniper_drone_cloak_mp";
        var_7 = 30;
    }

    var_9 = spawnhelicopter( self, var_2, var_3, var_6, var_8 );

    if ( !isdefined( var_9 ) )
        return;

    thread _id_82FE( var_9, var_0, var_7, var_1 );
    var_9._id_40F1 = ::_id_0D37;
    return var_9;
}

_id_0D37()
{
    return self gettagorigin( "tag_origin" );
}

_id_8324( var_0 )
{
    if ( isbot( self ) )
        return;

    if ( isdefined( var_0 ) && var_0.hasaioption )
        return;

    self notifyonplayercommand( "FirePrimaryWeapon", "+attack" );
    self notifyonplayercommand( "FirePrimaryWeapon", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "FireSecondaryWeapon", "+speed_throw" );
    self notifyonplayercommand( "FireSecondaryWeapon", "+toggleads_throw" );
    self notifyonplayercommand( "FireSecondaryWeapon", "+ads_akimbo_accessible" );

    if ( isdefined( var_0 ) && var_0._id_4721 )
    {
        self notifyonplayercommand( "Cloak", "+usereload" );
        self notifyonplayercommand( "Cloak", "+activate" );
    }
}

_id_2B20( var_0 )
{
    if ( isbot( self ) )
        return;

    if ( isdefined( var_0 ) && var_0.hasaioption )
        return;

    self notifyonplayercommandremove( "FirePrimaryWeapon", "+attack" );
    self notifyonplayercommandremove( "FirePrimaryWeapon", "+attack_akimbo_accessible" );
    self notifyonplayercommandremove( "FireSecondaryWeapon", "+speed_throw" );
    self notifyonplayercommandremove( "FireSecondaryWeapon", "+toggleads_throw" );
    self notifyonplayercommandremove( "FireSecondaryWeapon", "+ads_akimbo_accessible" );

    if ( isdefined( var_0 ) && var_0._id_4721 )
    {
        self notifyonplayercommandremove( "Cloak", "+usereload" );
        self notifyonplayercommandremove( "Cloak", "+activate" );
    }
}

_id_82FE( var_0, var_1, var_2, var_3 )
{
    var_0 makeunusable();
    var_0 _meth_8202( 23, 23, 23 );
    var_0.lifeid = var_1;
    var_0.team = self.team;
    var_0.owner = self;
    var_0.maxhealth = 250;
    var_0.destroyed = 0;
    var_0.vehicletype = "drone_assault";
    var_0 common_scripts\utility::make_entity_sentient_mp( self.team );
    var_0.modules = var_3;
    var_0._id_5FCF = common_scripts\utility::array_contains( var_3, "mp_terrace" );
    var_0._id_46C8 = common_scripts\utility::array_contains( var_3, "assault_ugv_hardened" );
    var_0._id_4736 = common_scripts\utility::array_contains( var_3, "assault_ugv_mg" ) || var_0._id_5FCF;
    var_0._id_473F = common_scripts\utility::array_contains( var_3, "assault_ugv_rockets" );
    var_0._id_4721 = common_scripts\utility::array_contains( var_3, "assault_ugv_cloak" );
    var_0.hasaioption = common_scripts\utility::array_contains( var_3, "assault_ugv_ai" );
    var_0._id_4716 = common_scripts\utility::array_contains( var_3, "assault_ugv_ar_hud" ) || var_0._id_5FCF;
    var_0._id_474A = var_0._id_4736 || var_0._id_473F;
    var_0.endtime = gettime() + var_2 * 1000;

    if ( var_0._id_46C8 )
        var_0.maxhealth = int( var_0.maxhealth * 1.3 );

    if ( !var_0.hasaioption )
    {
        _id_8324( var_0 );
        thread _id_61F8( var_0 );
    }

    var_0 setcandamage( 1 );
    var_0.empgrenaded = 0;
    var_0._id_259B = 1.0;
    var_0.oldcontents = var_0 setcontents( 0 );
    var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_0.maxhealth, undefined, ::_id_644C, ::drone_modifydamage, 1 );
    var_0 ghost();
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_2F27( var_0, var_0._id_4721 );

    if ( var_0._id_4721 )
        thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_2EFF( var_0, var_0._id_4721 );

    self.using_remote_tank = !var_0.hasaioption;
    self._id_4713 = var_0.hasaioption;

    if ( !var_0.hasaioption )
    {
        _id_6D60( var_0 );
        thread _id_0D51( var_0 );
        thread _id_5ED7( var_0 );
    }
    else
        thread maps\mp\zombies\killstreaks\_zombie_assaultdrone_ai::_id_09A1( var_0 );

    thread _id_5E9A( var_0 );
    thread _id_0D4E( var_0 );
    thread _id_5EA8( var_0 );
    thread _id_5E9C( var_0 );
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::playerwatchfordroneemp( var_0 );

    if ( var_0._id_5FCF )
    {
        var_4 = getent( "killstreak_orbit_origin", "targetname" );
        var_5 = getent( "killstreak_orbit_initial", "targetname" );
        var_6 = getent( "killstreak_orbit_lookat", "targetname" );

        if ( isdefined( var_4 ) && isdefined( var_5 ) && isdefined( var_6 ) )
            var_0 _meth_850B( self, var_4, var_5, var_6 );
    }

    if ( !var_0._id_5FCF )
    {
        thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_6CB7( var_0, "assault_drone_exhaust", "TAG_EXHAUST_REAR", "assaultDroneHunterKiller" );
        thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_6CB7( var_0, "assault_drone_exhaust_bottom", "tag_exhaust_lt" );
        thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_6CB7( var_0, "assault_drone_exhaust_bottom", "tag_exhaust_rt" );
    }

    if ( !isdefined( level.ishorde ) || isdefined( level.ishorde ) && self getclientomnvar( "ui_horde_player_class" ) != "drone" )
        thread _id_0D4F( var_0, var_2 );

    _id_0D55( var_0 );
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_9B62( var_0, common_scripts\utility::getfx( "assault_drone_marker" ) );
    thread _id_26C3( var_0 );
    var_7 = spawnstruct();
    var_7._id_9C43 = 1;
    var_7.deathoverridecallback = ::_id_6617;
    var_0 thread maps\mp\_movers::handle_moving_platforms( var_7 );
    return var_0;
}

drone_modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\gametypes\_damage::modifydamage( var_0, var_1, var_2, var_3 );

    if ( isdefined( var_1 ) && ( var_1 == "drone_assault_remote_turret_mp" || var_1 == "ugv_missile_mp" ) )
        var_4 = -1;

    if ( isplayer( var_0 ) )
        var_4 = -1;

    return var_4;
}

_id_6617( var_0 )
{
    self notify( "death" );
}

_id_26C3( var_0 )
{

}

_id_61F8( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        var_1 = common_scripts\utility::waittill_any_return( "FirePrimaryWeapon", "FireSecondaryWeapon", "Cloak" );

        if ( isdefined( var_1 ) )
            var_0 notify( var_1 );
    }
}

_id_6D60( var_0 )
{
    var_1 = self;

    if ( getdvarint( "camera_thirdPerson" ) )
        var_1 maps\mp\_utility::setthirdpersondof( 0 );

    var_1 maps\mp\_utility::playersaveangles();

    if ( !var_0._id_5FCF )
        var_1 cameralinkto( var_0, "tag_origin" );

    var_1 _meth_8206( var_0 );
    var_1 thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_7F56( 1.5, var_0 );
    var_1.using_remote_tank = 1;
    return 1;
}

_id_0D55( var_0 )
{
    if ( var_0._id_474A )
        thread _id_89EE( var_0 );
    else
        thread _id_A00D( var_0 );

    if ( var_0._id_473F )
        thread _id_8333( var_0 );

    thread _id_0D53( var_0 );
}

_id_3F06()
{
    return 200;
}

_id_A00D( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( !var_0.hasaioption )
        thread _id_6CC5( var_0 );

    wait 2;
    var_0 waittill( "FirePrimaryWeapon" );
    self notify( "ForceUncloak" );
    _id_6C8D( var_0 );
    var_0 entityradiusdamage( var_0.origin + ( 0.0, 0.0, 50.0 ), _id_3F06(), 200, 200, self, "MOD_EXPLOSIVE", "AssaultDrone_C4_mp" );
    playfx( common_scripts\utility::getfx( "assault_c4_explode" ), var_0.origin );
    var_0 notify( "death" );
}

_id_6CC5( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( self.team != var_2.team && !var_2 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
            var_2 hudoutlineenableforclient( self, 0, 1 );
    }

    var_0 waittill( "death" );

    if ( !isdefined( self ) )
        return;

    foreach ( var_2 in level.players )
    {
        if ( self.team != var_2.team )
            var_2 hudoutlinedisableforclient( self );
    }
}

_id_64CD( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_1 );

        if ( !isdefined( self ) )
            return;

        if ( self.team != var_1.team )
            var_1 thread _id_64D6();
    }
}

_id_64D6( var_0 )
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );

    if ( isdefined( var_0 ) )
        self hudoutlineenableforclient( var_0, 0, 1 );
}

_id_6C8D( var_0 )
{
    var_1 = 7000;
    var_2 = 22500;
    var_3 = 3600;
    self notify( "assaultDroneHunterKiller" );
    var_0._id_4B07 = 1;

    if ( var_0.hasaioption )
        var_4 = var_0.origin;
    else
        var_4 = self _meth_845C( 1 );

    var_5 = var_0._id_91C2.origin;
    var_6 = vectornormalize( var_5 - var_4 );
    var_5 = var_4 + var_6 * 20000;
    var_7 = bullettrace( var_4, var_5, 0, var_0, 0, 0, 1, 0, 0 );
    var_8 = var_7["position"];
    var_9 = distancesquared( var_0.origin, var_8 );

    if ( var_9 > var_3 )
    {
        var_10 = undefined;

        if ( var_0.hasaioption )
        {
            var_11 = var_0.origin;
            var_12 = var_0.angles;
        }
        else
        {
            var_11 = self _meth_845C( 1 );
            var_12 = self getangles();
            var_0._id_1A2F = spawn( "script_model", var_11 );
            var_0._id_1A2F setmodel( "tag_player" );
            var_0._id_1A2F.angles = var_12;
            var_0._id_1A2F linkto( var_0, "tag_origin" );
            waitframe();
            self _meth_807E( var_0._id_1A2F, "tag_player", 1, 0, 0, 0, 0, 1 );
            self _meth_80A0( 0 );
            self _meth_8207();
            earthquake( 0.2, 1, var_11, 100 );
            var_10 = _func_272( common_scripts\utility::getfx( "c4_forward_blur" ), var_11, self );
            triggerfx( var_10 );
        }

        stopfxontag( common_scripts\utility::getfx( "assault_drone_exhaust" ), var_0, "TAG_EXHAUST_REAR" );
        var_0 notify( "stopShootLocationUpdate" );
        var_0 setotherent( undefined );
        var_0 _meth_827C( var_0.origin, var_0.angles, 0, 0 );
        waitframe();
        thread _id_6D23( var_0, var_8 );
        thread _id_6D24( var_0 );
        var_13 = gettime() + var_1;
        var_14 = 120;
        var_15 = var_14 * 4 / 5;
        var_0 _meth_8283( var_14, var_15 );
        var_0 _meth_825B( var_8, 0 );
        var_0._id_8D6E = 0.3;
        var_0._id_0B0E = 1;
        var_0 setcontents( 0 );
        waitframe();
        playfxontag( common_scripts\utility::getfx( "assault_drone_thruster" ), var_0, "TAG_EXHAUST_REAR" );
        var_9 = distancesquared( var_0.origin, var_8 );

        while ( gettime() < var_13 && var_9 > var_2 )
        {
            waitframe();
            var_9 = distancesquared( var_0.origin, var_8 );
            glassradiusdamage( var_0.origin, 70, 200, 200 );
        }

        if ( !var_0.hasaioption )
            var_0._id_1A2F unlink();

        while ( gettime() < var_13 && var_9 > var_3 )
        {
            waitframe();
            var_9 = distancesquared( var_0.origin, var_8 );
            glassradiusdamage( var_0.origin, 70, 200, 200 );
        }

        var_0 _meth_8284( 0 );

        if ( !var_0.hasaioption )
            var_10 delete();
    }
}

_id_6D24( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 linkto( var_0, "tag_origin" );
    var_1 hide();

    foreach ( var_3 in level.players )
    {
        if ( self == var_3 )
            continue;

        var_1 showtoplayer( var_3 );
    }

    var_1 _meth_8438( "assault_drn_kamikaze_boost_npc" );
    self playlocalsound( "assault_drn_kamikaze_boost_plr" );
    wait 2;
    var_1 delete();
}

_id_6D23( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_1 );
    var_2 setmodel( "tag_origin" );
    var_2.angles = ( -90.0, 0.0, 0.0 );
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "assault_drone_marker" ), var_2, "tag_origin" );
    var_0 waittill( "death" );
    maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( "assault_drone_marker" ), var_2, "tag_origin" );
    waitframe();
    var_2 delete();
}

_id_89EE( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    var_1 = "drone_assault_remote_turret_mp";
    var_2 = "vehicle_atlas_aerial_drone_01_mp_turret_50p";
    var_3 = 0.0;
    var_4 = "tag_origin";
    var_5 = ( 0.0, 0.0, 0.0 );
    var_6 = ( 0.0, 0.0, 0.0 );

    if ( var_0._id_5FCF )
    {
        var_1 = "killstreak_terrace_mp";
        var_2 = "vehicle_sniper_drone_turret_mp_cloak";
    }

    var_7 = var_0 gettagorigin( var_4 );
    var_8 = spawnturret( "misc_turret", var_7, var_1, 0 );
    var_8.angles = var_0.angles;
    var_8 setmodel( var_2 );
    var_8 _meth_815A( var_3 );
    var_8 linkto( var_0, var_4, var_5, var_6 );
    var_8.owner = self;
    var_8.health = 99999;
    var_8 setcandamage( 0 );
    var_8 setcanradiusdamage( 0 );
    var_8._id_9130 = var_0;
    var_8 makeunusable();

    if ( var_0.hasaioption )
        var_8.killcament = var_0;

    var_0._id_5BD2 = var_8;
    var_0._id_5BD2 _meth_8065( "sentry_manual" );
    var_0._id_5BD2 _meth_8103( self );
    var_0._id_5BD2 _meth_8105( 0 );
    var_0._id_5BD2 cloakingenable();

    if ( !var_0._id_4736 )
        var_0._id_5BD2 _meth_815C();

    if ( var_0._id_5FCF )
    {
        self _meth_80FE( 0.2, 0.3, 0.8, 0.8 );
        thread _id_9290( var_0 );
    }

    if ( !var_0.hasaioption )
    {
        if ( var_0._id_5FCF )
            thread _id_217E( var_0, 0.0 );
        else
            thread _id_217E( var_0, 1.6 );
    }

    thread _id_283C( var_0 );

    if ( var_0._id_4721 && var_0._id_4736 )
        thread _id_A233( var_0 );
}

_id_217E( var_0, var_1 )
{
    var_2 = 0.0;

    if ( var_1 > 0 )
        wait(var_1);

    if ( isdefined( self ) && isdefined( var_0 ) && isdefined( var_0._id_5BD2 ) )
        self _meth_80E8( var_0._id_5BD2, var_2 );
}

_id_A233( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "FirePrimaryWeapon" );
        self notify( "ForceUncloak" );
    }
}

_id_9290( var_0 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );
    waitframe();
    playfxontagforclients( level._effect["sniper_drone_thruster_view"], var_0._id_5BD2, "tag_fx2", self );
    waitframe();
    playfxontagforclients( level._effect["sniper_drone_wind_marker"], var_0._id_5BD2, "tag_fx1", self );
}

_id_283C( var_0 )
{
    var_0 waittill( "death" );

    if ( isdefined( self ) )
    {
        self _meth_80E9( var_0._id_5BD2 );
        self thermalvisionfofoverlayoff();
    }

    if ( var_0._id_5FCF )
    {
        stopfxontag( level._effect["sniper_drone_thruster_view"], var_0._id_5BD2, "tag_fx2" );
        stopfxontag( level._effect["sniper_drone_wind_marker"], var_0._id_5BD2, "tag_fx1" );
    }

    var_0._id_5BD2 delete();
}

_id_8333( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    var_0._id_7589 = 3;

    if ( self getclientomnvar( "ui_assaultdrone_toggle" ) )
        self setclientomnvar( "ui_assaultdrone_rockets", var_0._id_7589 );

    for (;;)
    {
        if ( var_0._id_4736 )
            var_0 waittill( "FireSecondaryWeapon" );
        else
            var_0 waittill( "FirePrimaryWeapon" );

        self notify( "ForceUncloak" );
        earthquake( 0.3, 1, var_0.origin, 500 );
        self playrumbleonentity( "damage_heavy" );
        var_1 = var_0._id_5BD2 gettagorigin( "tag_flash" );
        var_2 = var_0._id_91C2.origin;

        if ( var_0.hasaioption )
            var_3 = var_0 _meth_8287();
        else
            var_3 = var_0 getentityvelocity();

        var_4 = magicbullet( "ugv_missile_mp", var_1 + var_3 / 10, var_2, self, 1 );
        var_0._id_5BD2 _meth_8438( "wpn_mahem_npc" );
        playfxontag( common_scripts\utility::getfx( "sentry_rocket_muzzleflash_wv" ), var_0._id_5BD2, "tag_flash" );
        var_4 missile_settargetent( var_0._id_91C2 );
        var_4 missile_setflightmodedirect();

        if ( var_0.hasaioption )
            var_4.killcament = var_0;

        var_0._id_7589--;

        if ( var_0._id_7589 > 0 )
        {
            self setclientomnvar( "ui_assaultdrone_rockets", var_0._id_7589 );
            wait 1;
            continue;
        }

        self setclientomnvar( "ui_assaultdrone_rockets", 4 );
        wait 5;
        var_0._id_7589 = 3;
        self setclientomnvar( "ui_assaultdrone_rockets", var_0._id_7589 );
    }
}

_id_0D51( var_0 )
{
    var_0 endon( "death" );
    self endon( "disconnect" );
    _id_0D50( var_0 );
    wait 0.5;
    self setclientomnvar( "ui_assaultdrone_toggle", 1 );

    if ( var_0._id_5FCF )
        self _meth_8532();

    maps\mp\killstreaks\_aerial_utility::_id_6C96();
    self setclientomnvar( "ui_assaultdrone_countdown", var_0.endtime );

    if ( !var_0._id_474A )
        self setclientomnvar( "ui_assaultdrone_weapon", 2 );
    else if ( var_0._id_5FCF )
        self setclientomnvar( "ui_assaultdrone_weapon", 3 );
    else if ( var_0._id_4736 )
        self setclientomnvar( "ui_assaultdrone_weapon", 1 );

    if ( var_0._id_473F && isdefined( var_0._id_7589 ) )
        self setclientomnvar( "ui_assaultdrone_rockets", var_0._id_7589 );

    if ( var_0._id_4721 )
        self setclientomnvar( "ui_drone_cloak", 2 );

    if ( isdefined( level.ishorde ) && level.ishorde && self getclientomnvar( "ui_horde_player_class" ) == "drone" )
        self setclientomnvar( "ui_horde_drone_heal", 1 );

    if ( var_0._id_4716 )
        self thermalvisionfofoverlayon();
}

_id_0D50( var_0 )
{
    self setclientomnvar( "ui_assaultdrone_toggle", 0 );
    self setclientomnvar( "ui_assaultdrone_countdown", 0 );
    self setclientomnvar( "ui_drone_cloak", 0 );
    self setclientomnvar( "ui_drone_cloak_time", 0 );
    self setclientomnvar( "ui_drone_cloak_cooldown", 0 );
    self setclientomnvar( "ui_assaultdrone_weapon", 0 );
    self setclientomnvar( "ui_assaultdrone_rockets", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C89();

    if ( var_0._id_5FCF )
        self disableforcefirstpersonwhenfollowed();
}

_id_5ED7( var_0 )
{
    self endon( "assaultStreakComplete" );

    if ( var_0._id_5FCF )
        return;

    thread maps\mp\killstreaks\_aerial_utility::_id_6CB4( var_0, "assaultStreakComplete" );
    thread maps\mp\killstreaks\_aerial_utility::_id_6CB9( var_0, "assaultStreakComplete" );
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
    self endon( "assaultStreakComplete" );
    common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    var_0 notify( "death" );
}

_id_5E9C( var_0 )
{
    self endon( "assaultStreakComplete" );
    level waittill( "game_ended" );
    var_0 notify( "death" );
}

_id_644C( var_0, var_1, var_2, var_3 )
{
    self notify( "death", var_0, var_2, var_1 );

    if ( isdefined( level.ishorde ) && level.ishorde && isdefined( var_0._id_511C ) && var_0._id_511C )
        return;

    if ( self._id_5FCF )
        maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "map_killstreak_destroyed", undefined, "callout_destroyed_terrace_sniper_drone", 1 );
    else
        maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "assault_drone_destroyed", undefined, "callout_destroyed_drone_assault", 1 );
}

_id_0D4F( var_0, var_1 )
{
    var_0 endon( "death" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_1 - 10 );
    var_2 = 10;

    while ( var_2 != 0 )
    {
        if ( !var_0.hasaioption )
            var_0 playsound( "mp_warbird_outofbounds_warning" );

        var_2 -= 1;
        wait 1;
    }

    if ( isdefined( var_0._id_4B07 ) )
        return;

    var_0 notify( "death" );
}

_id_0D4E( var_0 )
{
    var_1 = var_0 getentitynumber();
    var_0 maps\mp\zombies\killstreaks\_zombie_drone_common::_id_2EF4( var_1 );
    var_0 waittill( "death", var_2 );

    if ( isdefined( var_0._id_1A2F ) )
        var_0._id_1A2F unlink();

    if ( isdefined( var_0 ) )
        var_0 ghost();

    if ( isdefined( var_0._id_5BD2 ) )
        var_0._id_5BD2 ghost();

    if ( isdefined( self ) && !var_0.hasaioption )
        maps\mp\_utility::freezecontrolswrapper( 1 );

    self notify( "assaultStreakComplete" );
    self notify( "StopWaitForDisconnect" );
    var_0 playsound( "assault_drn_death" );
    playfx( level._effect["remote_tank_explode"], var_0.origin );
    var_0 maps\mp\zombies\killstreaks\_zombie_drone_common::_id_2F17( var_1 );

    if ( isdefined( self ) && !var_0._id_474A && !var_0.hasaioption && !level.gameended )
    {
        wait 1;
        maps\mp\killstreaks\_aerial_utility::_id_6D51();
        wait 0.8;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }

    if ( isdefined( self ) && isdefined( var_2 ) && self != var_2 )
        thread maps\mp\_utility::leaderdialogonplayer( "ks_adrone_destroyed", undefined, undefined, self.origin );

    if ( !var_0.hasaioption )
    {
        if ( isdefined( self ) && !level.gameended )
            maps\mp\_utility::freezecontrolswrapper( 0 );

        if ( isdefined( self ) && ( self.using_remote_tank || maps\mp\_utility::isusingremote() ) )
        {
            _id_0D54( var_0 );
            self.using_remote_tank = 0;
        }
    }
    else if ( isdefined( self ) )
        self._id_4713 = 0;

    maps\mp\_utility::decrementfauxvehiclecount();
    level.dronesdeployed--;

    if ( isdefined( var_0._id_1A2F ) )
        var_0._id_1A2F delete();

    var_0 delete();
}

_id_0D54( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = self;

    if ( isdefined( var_1.using_remote_tank ) && var_1.using_remote_tank )
    {
        var_1 notify( "end_remote" );
        var_1 _meth_80FF();
        var_1 _meth_8207( var_0 );
        var_1 thermalvisionfofoverlayoff();
        thread maps\mp\zombies\killstreaks\_zombie_drone_common::_id_739C( 1.5 );
        var_1 unlink();

        if ( var_1 maps\mp\_utility::isusingremote() && !level.gameended )
            var_1 maps\mp\_utility::clearusingremote();

        var_1 _id_9070();
        var_1 maps\mp\_utility::playerrestoreangles();
        var_1 _id_2B20( var_0 );
        thread _id_0D50( var_0 );

        if ( getdvarint( "camera_thirdPerson" ) )
            var_1 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_1.disabledusability ) && var_1.disabledusability )
            var_1 common_scripts\utility::_enableusability();

        var_1.using_remote_tank = 0;
    }
}

_id_9070()
{
    var_0 = maps\mp\_utility::getkillstreakweapon( "orbitalsupport" );
    self takeweapon( var_0 );
    self enableweaponswitch();
    self switchtoweapon( common_scripts\utility::getlastweapon() );
}

_id_0D53( var_0 )
{
    if ( !isdefined( self ) )
        return;

    var_1 = self;
    level endon( "game_ended" );
    var_1 endon( "disconnect" );
    var_1 endon( "assaultDroneHunterKiller" );
    var_0 endon( "death" );

    for (;;)
    {
        var_2 = 0;

        while ( !var_0.hasaioption && var_1 usebuttonpressed() )
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
