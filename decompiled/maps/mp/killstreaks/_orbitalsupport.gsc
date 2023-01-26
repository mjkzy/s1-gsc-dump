// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_6574 = spawnstruct();
    level._id_6574._id_89F2 = undefined;
    level._id_6574._id_8989 = undefined;
    level._id_6574._id_898A = undefined;
    level._id_6574._id_898B = undefined;
    level._id_6574._id_8A00 = undefined;
    level._id_6574._id_89DC = undefined;
    level._id_6574._id_03E3 = undefined;
    level._id_6574._id_99B1 = undefined;
    level._id_6574._id_0252 = undefined;
    level._id_6574._id_0380 = undefined;
    level._id_6574._id_04BD = undefined;
    level._id_6574._id_0089 = undefined;

    if ( isdefined( level._id_6573 ) )
        [[ level._id_6573 ]]();

    level._id_6570 = 40;
    level._id_656E = 123;

    if ( isdefined( level._id_6574._id_03E3 ) )
        level._id_656E = level._id_6574._id_03E3;

    var_0 = getentarray( "minimap_corner", "targetname" );
    var_1 = ( 0.0, 0.0, 0.0 );

    if ( var_0.size )
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );

    if ( isdefined( level._id_6574._id_89F2 ) )
        var_1 = level._id_6574._id_89F2;

    level._id_65AA = spawn( "script_model", var_1 );
    level._id_65AA setmodel( "c130_zoomrig" );
    level._id_65AA.angles = ( 0.0, 115.0, 0.0 );
    level._id_65AA hide();
    thread _id_7600( level._id_656E );
    level._effect["orbitalsupport_cloud"] = loadfx( "vfx/cloud/orbitalsupport_cloud" );
    level._effect["orbitalsupport_rocket_explode_player"] = loadfx( "vfx/explosion/rocket_explosion_distant" );
    level._effect["orbitalsupport_entry"] = loadfx( "vfx/vehicle/vehicle_osp_enter_clouds_parent" );
    level._effect["orbitalsupport_entry_complete"] = loadfx( "vfx/vehicle/vehicle_osp_enter_shock" );
    level._effect["vehicle_osp_jet"] = loadfx( "vfx/vehicle/vehicle_osp_jet" );
    level._effect["vehicle_osp_jet_lg"] = loadfx( "vfx/vehicle/vehicle_osp_jet_lg" );
    level._effect["vehicle_osp_rocket_marker"] = loadfx( "vfx/unique/vfx_marker_killstreak_guide" );
    level._effect["vehicle_osp_jet_lg_trl"] = loadfx( "vfx/vehicle/vehicle_osp_jet_lg_trl" );
    level._effect["orbitalsupport_entry_flash"] = loadfx( "vfx/vehicle/vehicle_osp_enter_flash" );
    level._effect["orbitalsupport_explosion"] = loadfx( "vfx/explosion/vehicle_mil_blimp_explosion" );
    level._effect["orbitalsupport_explosion_jet"] = loadfx( "vfx/explosion/vehicle_mil_blimp_explosion_jet" );
    level._effect["orbitalsupport_light"] = loadfx( "vfx/lights/vehicle_osp_light" );
    level._id_6801["orbitalsupport_40mm_mp"] = 600;
    level._id_6801["orbitalsupport_40mmbuddy_mp"] = 600;
    level._id_6801["orbitalsupport_105mm_mp"] = 1000;
    level._id_6800["orbitalsupport_40mm_mp"] = 3.0;
    level._id_6800["orbitalsupport_40mmbuddy_mp"] = 3.0;
    level._id_6800["orbitalsupport_105mm_mp"] = 6.0;
    level.orbitalsupportinuse = 0;
    level thread _id_64BE();
    level.killstreakfuncs["orbitalsupport"] = ::_id_98B8;
    level.killstreakwieldweapons["orbitalsupport_105mm_mp"] = "orbitalsupport";
    level.killstreakwieldweapons["orbitalsupport_40mm_mp"] = "orbitalsupport";
    level.killstreakwieldweapons["orbitalsupport_40mmbuddy_mp"] = "orbitalsupport";
    level.killstreakwieldweapons["orbitalsupport_big_turret_mp"] = "orbitalsupport";
    level.killstreakwieldweapons["orbitalsupport_missile_mp"] = "orbitalsupport";
    level._id_6567 = 0;
    level._id_6565 = 0;
    game["dialog"]["assist_mp_paladin"] = "ks_paladin_joinreq";
    game["dialog"]["pilot_sup_mp_paladin"] = "pilot_sup_mp_paladin";
    game["dialog"]["pilot_aslt_mp_paladin"] = "pilot_aslt_mp_paladin";
    game["dialog"]["copilot_sup_mp_paladin"] = "copilot_sup_mp_paladin";
    game["dialog"]["copilot_aslt_mp_paladin"] = "copilot_aslt_mp_paladin";
    game["dialog"]["copilot_enemykill_mp_paladin"] = "copilot_enemykill_mp_paladin";
    game["dialog"]["copilot_marked_mp_paladin"] = "copilot_marked_mp_paladin";
}

_id_98B8( var_0, var_1 )
{
    if ( isdefined( level._id_656C ) || level.orbitalsupportinuse )
    {
        self iclientprintlnbold( &"MP_ORBITALSUPPORT_IN_USE" );
        return 0;
    }

    level.orbitalsupportinuse = 1;
    thread _id_6C72();
    var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "paladin", 0, undefined, 3.0 );

    if ( var_2 != "success" )
    {
        level.orbitalsupportinuse = 0;
        return 0;
    }

    maps\mp\_utility::setusingremote( "orbitalsupport" );
    thread _id_7FCC( self, var_1 );
    maps\mp\_matchdata::logkillstreakevent( "orbitalsupport", self.origin );
    level.orbitalsupport_planemodel._id_2359 = undefined;
    return 1;
}

_id_6C72()
{
    self endon( "rideKillstreakBlack" );
    self waittill( "joined_team" );
    level.orbitalsupportinuse = 0;
}

_id_7FCC( var_0, var_1 )
{
    self endon( "orbitalsupport_player_removed" );
    self endon( "disconnect" );
    level._id_656C = var_0;
    var_0 maps\mp\_utility::playersaveangles();
    var_0 _id_656D();
    level.orbitalsupport_planemodel._id_4C28 = 0;
    level.orbitalsupport_planemodel.vehicletype = "paladin";
    level.orbitalsupport_planemodel thread maps\mp\gametypes\_damage::setentitydamagecallback( 3000, undefined, ::_id_235F, maps\mp\killstreaks\_aerial_utility::_id_47D3, 1 );
    level.orbitalsupport_planemodel.modules = var_1;
    level.orbitalsupport_planemodel._id_473F = common_scripts\utility::array_contains( var_1, "orbitalsupport_rockets" );
    level.orbitalsupport_planemodel._id_474A = common_scripts\utility::array_contains( var_1, "orbitalsupport_turret" );
    level.orbitalsupport_planemodel._id_21C9 = common_scripts\utility::array_contains( var_1, "orbitalsupport_coop_offensive" );
    level.orbitalsupport_planemodel._id_35AA = common_scripts\utility::array_contains( var_1, "orbitalsupport_flares" );
    level.orbitalsupport_planemodel._id_0B79 = common_scripts\utility::array_contains( var_1, "orbitalsupport_ammo" );
    level.orbitalsupport_planemodel.player = var_0;

    if ( level.orbitalsupport_planemodel._id_35AA )
        var_2 = 1;
    else
        var_2 = 0;

    level.orbitalsupport_planemodel.helitype = "osp";
    level.orbitalsupport_planemodel thread maps\mp\killstreaks\_aerial_utility::_id_47BC( var_2 );
    thread maps\mp\_utility::teamplayercardsplash( "used_orbitalsupport", var_0 );
    var_0 _meth_834A();
    var_0 maps\mp\killstreaks\_aerial_utility::_id_6C89();
    var_0 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
    var_0 thread _id_A051( 1.0 );
    var_0 thread _id_A006( 1.0 );
    var_0 thread _id_7FCF( 1.25 );
    var_0 thread _id_1FEE();

    if ( getdvarint( "camera_thirdPerson" ) )
        var_0 maps\mp\_utility::setthirdpersondof( 0 );

    var_0 _id_6D69( level._id_6563 );
    var_0._id_218B = "medium";
    var_0._id_7315 = 0;
    var_0._id_7317 = 0;
    var_0._id_7318 = 0;
    var_0._id_7316 = 0;
    var_0._id_5B2A = 8;
    var_0 thread _id_73C6();
    var_0 thread _id_73C3();
    var_0 thread _id_73C8();
    var_0 thread _id_73C5();
    var_0 thread _id_73C7();
    wait 1;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_0 _id_6D44();
    var_0 setclientomnvar( "ui_osp_weapon", 1 );
    var_0 setclientomnvar( "ui_osp_toggle", 1 );
    var_0 thread _id_A04F( 0.1 );
    var_0 thread _id_704F();
    var_3 = level._id_6570;

    if ( common_scripts\utility::array_contains( var_1, "orbitalsupport_time" ) )
        var_3 += 15;

    var_0._id_6568 = gettime() + var_3 * 1000;
    var_0 setclientomnvar( "ui_warbird_countdown", var_0._id_6568 );
    self notifyonplayercommand( "orbitalsupport_fire", "+attack" );
    self notifyonplayercommand( "orbitalsupport_fire", "+attack_akimbo_accessible" );
    var_0 thread _id_1C85();
    var_0 thread _id_37CC();
    var_0 thread _id_37DD();
    var_0 thread _id_37E3();
    var_0 thread _id_84F5();
    var_0 thread _id_73C2( var_3 );
    var_0 thread _id_73C4();

    if ( level.teambased )
        level thread _id_464F( var_0 );

    level thread _id_8328();
}

_id_A04F( var_0 )
{
    self endon( "orbitalsupport_player_removed" );
    self endon( "disconnect" );
    wait(var_0);
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
}

_id_A051( var_0 )
{
    self endon( "disconnect" );
    level endon( "orbitalsupport_player_removed" );
    self endon( "orbitalsupport_player_removed" );
    wait(var_0);
    self thermalvisionfofoverlayon();
    var_1 = 9275;

    if ( isdefined( level._id_6574._id_89DC ) )
        var_1 = level._id_6574._id_89DC - level.mapcenter[2];

    var_2 = 0.3;
    var_3 = var_1;
    var_4 = 0.3;
    var_5 = var_1 * 0.75;
    var_6 = 20;
    var_7 = 30;
    thread maps\mp\killstreaks\_aerial_utility::_id_92FD( "orbitalsupport_player_removed", var_2, var_3, var_4, var_5, var_6, var_7 );
}

_id_A006( var_0 )
{
    self endon( "disconnect" );
    level endon( "orbitalsupport_player_removed" );
    self endon( "orbitalsupport_player_removed" );
    wait(var_0);
    self _meth_851A( 0 );
}

_id_7FCF( var_0 )
{
    self endon( "disconnect" );
    level endon( "orbitalsupport_player_removed" );
    wait(var_0);

    if ( isdefined( level._id_65AB ) )
        self setclienttriggervisionset( level._id_65AB, 0 );

    if ( isdefined( level._id_65A9 ) )
        self lightsetforplayer( level._id_65A9 );

    maps\mp\killstreaks\_aerial_utility::_id_45F0();
}

_id_73C9( var_0 )
{
    self setclienttriggervisionset( "", var_0 );
    self lightsetforplayer( "" );
    maps\mp\killstreaks\_aerial_utility::_id_45E2();
}

_id_73C4()
{
    self endon( "orbitalsupport_player_removed" );
    var_0 = 0;

    for (;;)
    {
        if ( self usebuttonpressed() )
        {
            var_0 += 0.05;

            if ( var_0 > 1.0 )
            {
                if ( isdefined( level._id_6564 ) && level._id_6564._id_5287 == 1 || !isdefined( level._id_6564 ) )
                {
                    level thread _id_73C1( self, 0 );
                    return;
                }
            }
        }
        else
            var_0 = 0;

        wait 0.05;
    }
}

_id_73C7()
{
    self endon( "orbitalsupport_player_removed" );
    level waittill( "game_ended" );
    level thread _id_73C1( self, 0 );
}

_id_73C5()
{
    self endon( "orbitalsupport_player_removed" );
    level.orbitalsupport_planemodel waittill( "crashing" );
    level thread _id_73C1( self, 0 );
}

_id_73C6()
{
    self endon( "orbitalsupport_player_removed" );
    self waittill( "disconnect" );
    level thread _id_73C1( self, 1 );
}

_id_73C3()
{
    self endon( "orbitalsupport_player_removed" );
    self waittill( "joined_team" );
    level thread _id_73C1( self, 0 );
}

_id_73C8()
{
    self endon( "orbitalsupport_player_removed" );
    common_scripts\utility::waittill_any( "joined_spectators", "spawned" );
    level thread _id_73C1( self, 0 );
}

_id_73C2( var_0 )
{
    self endon( "orbitalsupport_player_removed" );

    if ( maps\mp\_utility::_hasperk( "specialty_blackbox" ) && isdefined( self._id_8A32 ) )
        var_0 *= self._id_8A32;

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );

    if ( isdefined( level._id_6564 ) )
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 7 );

    level thread _id_73C1( self, 0 );
}

_id_73C1( var_0, var_1 )
{
    var_0 notify( "orbitalsupport_player_removed" );
    level notify( "orbitalsupport_player_removed" );
    waittillframeend;
    level.orbitalsupport_planemodel.player = undefined;

    if ( isdefined( level._id_6564 ) )
        level._id_6564 thread _id_73BC( 0 );

    if ( !var_1 )
    {
        var_0 _id_6D33();
        var_0 notifyonplayercommandremove( "orbitalsupport_fire", "+attack" );
        var_0 notifyonplayercommandremove( "orbitalsupport_fire", "+attack_akimbo_accessible" );

        if ( !isbot( var_0 ) && ( level.orbitalsupport_planemodel._id_473F || level.orbitalsupport_planemodel._id_474A ) )
            var_0 notifyonplayercommandremove( "switch_orbitalsupport_turret", "weapnext" );

        var_0 _meth_80E9( level._id_6563 );
        level._id_6563 hide();
        var_0 unlink();
        var_2 = maps\mp\_utility::getkillstreakweapon( "orbitalsupport" );
        var_0 takeweapon( var_2 );

        if ( var_0 maps\mp\_utility::isusingremote() )
            var_0 maps\mp\_utility::clearusingremote();

        maps\mp\killstreaks\_aerial_utility::_id_2B1E( var_0 );
        var_0 _meth_851A( 1 );
        var_0 thermalvisionfofoverlayoff();
        var_0 setblurforplayer( 0, 0 );
        var_0 _id_73C9( 1.5 );
        var_0 _meth_834B();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_0._id_25F3 ) )
            var_0._id_25F3 destroy();

        var_0._id_7315 = undefined;
        var_0._id_7317 = undefined;
        var_0._id_7318 = undefined;
        var_0._id_7316 = undefined;
        var_0 maps\mp\_utility::playerrestoreangles();
    }

    if ( isdefined( level.orbitalsupport_planemodel._id_2359 ) )
    {
        level._id_656C = undefined;
        return;
    }

    level._id_656C = undefined;
    level.orbitalsupport_planemodel stoploopsound();
    level.orbitalsupport_planemodel playsound( "paladin_orbit_return" );
    level.orbitalsupport_planemodel _id_6571();
}

_id_1E8E()
{
    level.orbitalsupport_planemodel stoploopsound();

    if ( isdefined( level._id_656F ) )
    {
        stopfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level._id_656F, "tag_origin" );
        level._id_656F delete();
    }

    level._id_6566 turretdeletesoundent();
    level._id_6566 delete();

    if ( isdefined( level.orbitalsupport_planemodel._id_366B ) )
    {
        level.orbitalsupport_planemodel._id_366B stoploopsound();
        level.orbitalsupport_planemodel._id_366B delete();
    }

    if ( isdefined( level.orbitalsupport_planemodel._id_1FDC ) )
    {
        level.orbitalsupport_planemodel._id_1FDC stoploopsound();
        level.orbitalsupport_planemodel._id_1FDC delete();
    }

    if ( isdefined( level.orbitalsupport_planemodel._id_5C73 ) )
        level.orbitalsupport_planemodel._id_5C73 delete();
}

_id_656D()
{
    var_0 = getentarray( "minimap_corner", "targetname" );
    var_1 = ( 0.0, 0.0, 0.0 );

    if ( var_0.size )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter( var_0[0].origin, var_0[1].origin );
        var_1 = ( var_1[0], var_1[1], 0 );
    }

    if ( isdefined( level._id_6574._id_89F2 ) )
    {
        var_1 = level._id_6574._id_89F2;
        var_1 = ( var_1[0], var_1[1], 0 );
    }

    level.orbitalsupport_planemodel = spawn( "script_model", var_1 );
    level.orbitalsupport_planemodel.angles = ( 0.0, 0.0, 0.0 );
    level.orbitalsupport_planemodel setmodel( "vehicle_mil_blimp_orbital_platform_ai" );
    level.orbitalsupport_planemodel.owner = self;
    level.orbitalsupport_planemodel common_scripts\utility::make_entity_sentient_mp( self.team );
    level.orbitalsupport_planemodel._id_5C73 = spawnplane( self, "script_model", var_1, "compass_objpoint_ac130_friendly", "compass_objpoint_ac130_enemy" );
    level.orbitalsupport_planemodel._id_5C73 setmodel( "tag_origin" );
    level.orbitalsupport_planemodel._id_5C73 linktosynchronizedparent( level.orbitalsupport_planemodel, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    level.orbitalsupport_planemodel setcandamage( 1 );
    level.orbitalsupport_planemodel setcanradiusdamage( 1 );
    level.orbitalsupport_planemodel.maxhealth = 2000;
    level.orbitalsupport_planemodel.health = level.orbitalsupport_planemodel.maxhealth;
    level.orbitalsupport_planemodel._id_852D = 0;
    level.orbitalsupport_planemodel _id_7FF3();
    level._id_6563 = _id_89F1( "orbitalsupport_big_turret_mp", "orbitalsupport_big_turret", "tag_orbitalsupport_biggun", 0 );
    level._id_6566 = _id_89F1( "orbitalsupport_buddy_turret_mp", "orbitalsupport_small_turret", "tag_orbitalsupport_mediumgun2", 1 );
    level.orbitalsupport_planemodel thread _id_5F5E();
}

_id_89F1( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnturret( "misc_turret", level.orbitalsupport_planemodel gettagorigin( var_2 ), var_0, 0 );
    var_4.angles = level.orbitalsupport_planemodel gettagangles( var_2 );
    var_4 setmodel( var_1 );
    var_4 _meth_815A( 45 );
    var_4 linkto( level.orbitalsupport_planemodel, var_2, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4.owner = undefined;
    var_4.health = 99999;
    var_4.maxhealth = 1000;
    var_4.damagetaken = 0;
    var_4.stunned = 0;
    var_4._id_8F70 = 0.0;
    var_4 setcandamage( 0 );
    var_4 setcanradiusdamage( 0 );
    var_4 _meth_815C();

    if ( var_3 )
        var_4 thread turretspawnsoundent( var_2 );

    return var_4;
}

turretspawnsoundent( var_0 )
{
    waitframe();
    self.soundent = spawn( "script_model", self.origin );
    self.soundent setmodel( "tag_origin" );
    self.soundent linkto( level.orbitalsupport_planemodel, var_0, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
}

_id_704F()
{
    level endon( "orbitalsupport_player_removed" );
    self endon( "orbitalsupport_player_removed" );
    self endon( "switch_orbitalsupport_turret" );
    self setclientomnvar( "ui_osp_reload_bitfield", 0 );
    var_0 = 1;
    var_1 = 2;
    var_2 = 4;

    for (;;)
    {
        var_3 = 0;

        if ( self._id_7315 )
            var_3 += var_0;

        if ( self._id_7317 || self._id_7316 )
            var_3 += var_1;

        if ( self._id_7318 )
            var_3 += var_2;

        self setclientomnvar( "ui_osp_reload_bitfield", var_3 );
        wait 0.05;
    }
}

_id_1C85()
{
    self endon( "orbitalsupport_player_removed" );

    if ( isbot( self ) )
        return;

    var_0 = level.orbitalsupport_planemodel._id_473F;
    var_1 = level.orbitalsupport_planemodel._id_474A;

    if ( !var_0 && !var_1 )
        return;

    self notifyonplayercommand( "switch_orbitalsupport_turret", "weapnext" );
    wait 0.05;
    self setclientomnvar( "ui_osp_weapon", 1 );

    for (;;)
    {
        self waittill( "switch_orbitalsupport_turret" );

        if ( self._id_218B == "medium" )
        {
            if ( var_0 )
                _id_6D68();
            else
                _id_6D66();
        }
        else if ( self._id_218B == "rocket" )
        {
            if ( var_1 )
                _id_6D66();
            else
                _id_6D67();
        }
        else if ( self._id_218B == "big" )
            _id_6D67();

        self playlocalsound( "paladin_weapon_cycle_plr" );
    }
}

_id_6D44()
{
    var_0 = level.orbitalsupport_planemodel._id_473F;
    var_1 = level.orbitalsupport_planemodel._id_474A;
    var_2 = 1;

    if ( var_1 )
        var_2 += 2;

    if ( var_0 )
        var_2 += 4;

    self setclientomnvar( "ui_osp_avail_weapons", var_2 );
}

_id_6D69( var_0 )
{
    self unlink();
    level thread _id_4689( var_0 );
    var_1 = 25;
    var_2 = 25;
    var_3 = -25;
    var_4 = 60;

    if ( isdefined( level._id_6574._id_0380 ) )
        var_1 = level._id_6574._id_0380;

    if ( isdefined( level._id_6574._id_0252 ) )
        var_2 = level._id_6574._id_0252;

    if ( isdefined( level._id_6574._id_04BD ) )
        var_3 = level._id_6574._id_04BD;

    if ( isdefined( level._id_6574._id_0089 ) )
        var_4 = level._id_6574._id_0089;

    self _meth_807E( var_0, "tag_player", 0, var_1, var_2, var_3, var_4, 1 );
    self _meth_80A1( 1 );
    var_5 = 45;

    if ( isdefined( level._id_6574._id_99B1 ) )
        var_5 = level._id_6574._id_99B1;

    self _meth_80E8( var_0, var_5 );
}

_id_4689( var_0 )
{
    var_0 endon( "death" );
    var_0 notify( "startHandleSoundEnt" );
    var_0 endon( "startHandleSoundEnt" );

    if ( isdefined( var_0.soundent ) )
        var_0.soundent hide();

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_0.owner ) && var_0.owner != var_2 )
        {
            if ( isdefined( var_0.soundent ) )
                var_0.soundent showtoplayer( var_2 );
        }
    }

    for (;;)
    {
        level waittill( "connected", var_2 );

        if ( isdefined( var_0.soundent ) )
            var_0.soundent showtoplayer( var_2 );
    }
}

_id_6D66()
{
    self._id_218B = "big";
    self setclientomnvar( "ui_osp_weapon", 0 );
    thread _id_704F();

    if ( isdefined( level._id_656F ) )
        stopfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level._id_656F, "tag_origin" );
}

_id_6D68()
{
    self._id_218B = "rocket";
    self setclientomnvar( "ui_osp_weapon", 3 );
    thread _id_704F();

    if ( isdefined( level._id_656F ) )
        playfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level._id_656F, "tag_origin" );
}

_id_6D67()
{
    self._id_218B = "medium";
    self setclientomnvar( "ui_osp_weapon", 1 );
    thread _id_704F();

    if ( isdefined( level._id_656F ) )
        stopfxontag( common_scripts\utility::getfx( "vehicle_osp_rocket_marker" ), level._id_656F, "tag_origin" );
}

_id_6CAC( var_0 )
{
    if ( !isdefined( var_0 ) || !var_0 )
        return level._id_6563 gettagorigin( "tag_player" ) + anglestoforward( level._id_6563 gettagangles( "tag_player" ) ) * 20000;
    else
        return level._id_6566 gettagorigin( "tag_player" ) + anglestoforward( level._id_6566 gettagangles( "tag_player" ) ) * 20000;
}

_id_37CC()
{
    self endon( "orbitalsupport_player_removed" );

    if ( !level.orbitalsupport_planemodel._id_0B79 )
        var_0 = 6;
    else
        var_0 = 4;

    while ( !isdefined( level.orbitalsupport_planemodel.paladinflying ) )
        waitframe();

    for (;;)
    {
        self._id_7315 = 0;
        self waittill( "orbitalsupport_fire" );

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( self._id_218B == "big" )
        {
            var_1 = _id_6CAC();
            var_2 = level._id_6563 gettagorigin( "tag_missile1" );
            var_3 = magicbullet( "orbitalsupport_105mm_mp", var_2, var_1, self, 1 );
            var_3._id_9CBC = level.orbitalsupport_planemodel;
            level.orbitalsupport_planemodel playsound( "paladin_cannon_snap" );
            var_3 playsound( "orbitalsupport_105mm_proj_travel" );
            self playrumbleonentity( "ac130_105mm_fire" );
            self playlocalsound( "paladin_cannon_reload" );
            earthquake( 0.3, 1, level.orbitalsupport_planemodel.origin, 1000, self );
            self._id_7315 = 1;
            wait(var_0);
        }
    }
}

_id_37DD()
{
    self endon( "orbitalsupport_player_removed" );

    while ( !isdefined( level.orbitalsupport_planemodel.paladinflying ) )
        waitframe();

    for (;;)
    {
        self._id_7317 = 0;

        if ( !level.orbitalsupport_planemodel._id_0B79 )
            var_0 = 3;
        else
            var_0 = 2;

        if ( self._id_218B == "medium" && self attackbuttonpressed() && !isdefined( level.hostmigrationtimer ) )
        {
            var_1 = level._id_6563 gettagorigin( "tag_missile1" );
            var_2 = _id_6CAC();
            level.orbitalsupport_planemodel playsound( "paladin_mgun_burst_plr" );
            var_3 = magicbullet( "orbitalsupport_40mm_mp", var_1, var_2, self, 1 );
            var_3._id_9CBC = level.orbitalsupport_planemodel;
            var_4 = bullettrace( var_1, var_2, 0 );
            wait 0.05;
            earthquake( 0.1, 0.5, level.orbitalsupport_planemodel.origin, 1000, self );
            _id_37DE( var_4["position"], "orbitalsupport_40mm_mp" );
            _id_37DE( var_4["position"], "orbitalsupport_40mm_mp" );
            _id_37DE( var_4["position"], "orbitalsupport_40mm_mp" );
            self._id_5B2A--;

            if ( self._id_5B2A <= 0 )
            {
                self._id_7317 = 1;
                wait(var_0);
                self._id_5B2A = 8;
            }
        }

        wait 0.05;
    }
}

_id_37CE()
{
    self endon( "orbitalsupport_player_removed" );

    for (;;)
    {
        self waittill( "orbitalsupport_fire" );
        maps\mp\killstreaks\_aerial_utility::_id_6C9D( level._id_6566.soundent );
        wait 2;
    }
}

_id_37CD()
{
    self endon( "orbitalsupport_player_removed" );
    var_0 = 6;
    self._id_7316 = 0;
    self._id_218B = "buddy";
    thread _id_704F();

    for (;;)
    {
        self._id_7316 = 0;

        if ( !level.orbitalsupport_planemodel._id_0B79 )
            var_1 = 5;
        else
            var_1 = 3;

        if ( self attackbuttonpressed() )
        {
            var_2 = level._id_6566 gettagorigin( "tag_missile1" );
            var_3 = _id_6CAC( 1 );
            level.orbitalsupport_planemodel playsound( "paladin_mgun_burst_plr" );
            var_4 = magicbullet( "orbitalsupport_40mmbuddy_mp", var_2, var_3, self );
            var_4._id_9CBC = level.orbitalsupport_planemodel;
            var_5 = bullettrace( var_2, var_3, 0 );
            waitframe();
            earthquake( 0.1, 0.5, level.orbitalsupport_planemodel.origin, 1000, self );
            _id_37DE( var_5["position"], "orbitalsupport_40mmbuddy_mp" );
            _id_37DE( var_5["position"], "orbitalsupport_40mmbuddy_mp" );
            _id_37DE( var_5["position"], "orbitalsupport_40mmbuddy_mp" );
            var_0--;

            if ( var_0 <= 0 )
            {
                self._id_7316 = 1;
                wait(var_1);
                var_0 = 6;
            }
        }

        wait 0.05;
    }
}

_id_37DE( var_0, var_1 )
{
    var_2 = level.orbitalsupport_planemodel gettagorigin( "tag_orbitalsupport_mediumgun1" );
    var_3 = randomfloat( 400 ) - 200;
    var_4 = randomfloat( 400 ) - 200;
    var_5 = magicbullet( var_1, var_2, ( var_0[0] + var_3, var_0[1] + var_4, var_0[2] ), self, 1 );
    var_5._id_9CBC = level.orbitalsupport_planemodel;
    self playrumbleonentity( "ac130_25mm_fire" );
    wait 0.05;
    var_2 = level.orbitalsupport_planemodel gettagorigin( "tag_orbitalsupport_mediumgun0" );
    var_3 = randomfloat( 400 ) - 200;
    var_4 = randomfloat( 400 ) - 200;
    var_5 = magicbullet( var_1, var_2, ( var_0[0] + var_3, var_0[1] + var_4, var_0[2] ), self, 1 );
    var_5._id_9CBC = level.orbitalsupport_planemodel;
    self playrumbleonentity( "ac130_25mm_fire" );
    wait 0.05;
    var_2 = level.orbitalsupport_planemodel gettagorigin( "tag_orbitalsupport_mediumgun3" );
    var_3 = randomfloat( 400 ) - 200;
    var_4 = randomfloat( 400 ) - 200;
    var_5 = magicbullet( var_1, var_2, ( var_0[0] + var_3, var_0[1] + var_4, var_0[2] ), self, 1 );
    var_5._id_9CBC = level.orbitalsupport_planemodel;
    self playrumbleonentity( "ac130_25mm_fire" );
    wait 0.05;
}

_id_7117( var_0 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5 );
}

_id_37E3()
{
    self endon( "orbitalsupport_player_removed" );
    var_0 = 3;
    var_1 = var_0;
    self setclientomnvar( "ui_osp_rockets", var_1 );

    if ( !level.orbitalsupport_planemodel._id_0B79 )
        var_2 = 6;
    else
        var_2 = 4;

    thread _id_9B62();

    while ( !isdefined( level.orbitalsupport_planemodel.paladinflying ) )
        waitframe();

    for (;;)
    {
        self._id_7318 = 0;

        if ( self._id_218B == "rocket" && self attackbuttonpressed() && !isdefined( level.hostmigrationtimer ) )
        {
            earthquake( 0.3, 1, level.orbitalsupport_planemodel.origin, 1000, self );
            var_3 = level._id_6563 gettagorigin( "tag_missile1" );
            var_4 = vectornormalize( anglestoforward( self getangles() ) );
            var_5 = vectornormalize( anglestoforward( level.orbitalsupport_planemodel gettagangles( "tag_origin" ) ) );

            for ( var_6 = 0; var_6 < 3; var_6++ )
            {
                var_7 = var_4 + ( 0.0, 0.0, 0.4 ) + _id_7117( 1 );
                var_8 = magicbullet( "orbitalsupport_missile_mp", var_3, var_3 + var_7, self );
                var_8._id_9CBC = level.orbitalsupport_planemodel;
                self playlocalsound( "paladin_missile_shot_2d" );
                self playrumbleonentity( "ac130_40mm_fire" );
                var_8 missile_settargetent( level._id_656F );
                var_8 missile_setflightmodedirect();
                wait 0.1;
            }

            var_1--;
            self setclientomnvar( "ui_osp_rockets", var_1 );

            if ( var_1 == 0 )
            {
                self._id_7318 = 1;
                thread _id_7590( var_2 );
                wait(var_2);
                var_1 = var_0;
                self setclientomnvar( "ui_osp_rockets", var_1 );
                self notify( "rocketReloadComplete" );
                continue;
            }
            else
                wait 1.3;
        }

        waitframe();
    }
}

_id_9B62()
{
    self endon( "orbitalsupport_player_removed" );
    level._id_656F = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    level._id_656F setmodel( "tag_origin" );
    level._id_6563 _meth_8508( level._id_656F );

    for (;;)
    {
        var_0 = level._id_6563 gettagorigin( "tag_player" );
        var_1 = level._id_6563 gettagorigin( "tag_player" ) + anglestoforward( level._id_6563 gettagangles( "tag_player" ) ) * 20000;
        var_2 = bullettrace( var_0, var_1, 0, level._id_6563 );
        var_3 = var_2["position"];
        level._id_656F.origin = var_3;
        waitframe();
    }
}

_id_7590( var_0 )
{
    self endon( "rocketReloadComplete" );
    self endon( "orbitalsupport_player_removed" );
    var_1 = 3;
    self playlocalsound( "warbird_missile_reload_bed" );
    wait 0.5;

    for (;;)
    {
        self playlocalsound( "warbird_missile_reload" );
        wait(var_0 / var_1);
    }
}

_id_84F5()
{
    level.orbitalsupport_planemodel endon( "death" );

    while ( !isdefined( level.orbitalsupport_planemodel.paladinflying ) )
        waitframe();

    level.orbitalsupport_planemodel._id_852D = 1;
    level.orbitalsupport_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
    level.orbitalsupport_planemodel common_scripts\utility::waittill_either( "crashing", "leaving" );
    level.orbitalsupport_planemodel._id_852D = 0;
    level.orbitalsupport_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

_id_1FEE()
{
    self endon( "orbitalsupport_player_removed" );
    wait 6;
    _id_1FEF();

    for (;;)
    {
        wait(randomfloatrange( 40, 80 ));
        _id_1FEF();
    }
}

_id_1FEF()
{
    if ( isdefined( level._id_6D90 ) && issubstr( tolower( level._id_6D90 ), "25" ) )
        return;

    playfxontagforclients( level._effect["orbitalsupport_cloud"], level.orbitalsupport_planemodel, "tag_player", level._id_656C );
}

_id_235F( var_0, var_1, var_2, var_3 )
{
    level.orbitalsupport_planemodel notify( "crashing" );
    level.orbitalsupport_planemodel._id_2359 = 1;
    level.orbitalsupport_planemodel maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "paladin_destroyed", undefined, "callout_destroyed_orbitalsupport", 1 );
    thread _id_235C();
    level.orbitalsupport_planemodel stopsounds();
    playsoundatpos( level.orbitalsupport_planemodel.origin, "paladin_ground_death" );
    waitframe();
    _id_1E8E();
    level.orbitalsupport_planemodel delete();
    level.orbitalsupportinuse = 0;
}

_id_235C()
{
    var_0 = _id_4063( "TAG_FX_ENGINE_B" );
    var_1 = _id_4063( "tag_origin" );
    var_2 = _id_4063( "tag_light_belly" );
    var_3 = _id_4063( "TAG_FX_ENGINE_L_1" );
    var_4 = _id_4063( "TAG_FX_ENGINE_L_2" );
    var_5 = _id_4063( "TAG_FX_ENGINE_R_1" );
    var_6 = _id_4063( "TAG_FX_ENGINE_R_2" );
    playfx( common_scripts\utility::getfx( "orbitalsupport_explosion" ), var_1.origin, var_2.dir );
    playfx( common_scripts\utility::getfx( "orbitalsupport_explosion_jet" ), var_3.origin, var_3.dir );
    playfx( common_scripts\utility::getfx( "orbitalsupport_explosion_jet" ), var_4.origin, var_4.dir );
    wait 0.05;
    playfx( common_scripts\utility::getfx( "orbitalsupport_explosion_jet" ), var_5.origin, var_5.dir );
    playfx( common_scripts\utility::getfx( "orbitalsupport_explosion_jet" ), var_6.origin, var_6.dir );
}

_id_4063( var_0 )
{
    var_1 = spawnstruct();
    var_1.origin = level.orbitalsupport_planemodel gettagorigin( var_0 );
    var_1.dir = anglestoforward( level.orbitalsupport_planemodel gettagangles( var_0 ) );
    return var_1;
}

_id_464F( var_0 )
{
    var_1 = "orbitalsupport_coop_defensive";
    var_2 = &"MP_JOIN_ORBITALSUPPORT_DEF";
    var_3 = "pilot_sup_mp_paladin";
    var_4 = "copilot_sup_mp_paladin";

    if ( level.orbitalsupport_planemodel._id_21C9 )
    {
        var_1 = "orbitalsupport_coop_offensive";
        var_2 = &"MP_JOIN_ORBITALSUPPORT_OFF";
        var_3 = "pilot_aslt_mp_paladin";
        var_4 = "copilot_aslt_mp_paladin";
    }

    for (;;)
    {
        var_5 = maps\mp\killstreaks\_coop_util::_id_7017( var_0.team, var_2, var_1, "assist_mp_paladin", var_3, var_0, var_4 );
        level thread _id_A21B( var_5, var_0 );
        var_6 = _id_A0E3( "orbitalsupport_buddy_added" );
        maps\mp\killstreaks\_coop_util::_id_8EF9( var_5 );

        if ( !isdefined( var_6 ) )
            return;

        var_6 = _id_A0E3( "orbitalsupport_buddy_removed" );

        if ( !isdefined( var_6 ) )
            return;

        waittillframeend;
    }
}

_id_A0E3( var_0 )
{
    level endon( "orbitalsupport_player_removed" );
    level waittill( var_0 );
    return 1;
}

_id_A21B( var_0, var_1 )
{
    level endon( "orbitalsupport_player_removed" );
    var_2 = maps\mp\killstreaks\_coop_util::_id_A0C9( var_0 );
    var_2 thread _id_7FCB( var_1 );
}

_id_64BE()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0._id_6569 = 0;
    }
}

_id_7FCB( var_0 )
{
    self endon( "orbitalsupport_player_removed" );
    level._id_6564 = self;
    level._id_6564._id_5287 = 0;
    level._id_6565 = 0;
    level notify( "orbitalsupport_buddy_added" );
    var_0 maps\mp\_utility::playersaveangles();
    _id_8310();
    level thread maps\mp\_utility::teamplayercardsplash( "joined_orbitalsupport", self );

    if ( getdvarint( "camera_thirdPerson" ) )
        maps\mp\_utility::setthirdpersondof( 0 );

    thread _id_6C91();
    self waittill( "initRideKillstreak_complete", var_1 );

    if ( !var_1 )
        return;

    maps\mp\_utility::setusingremote( "orbitalsupport" );
    self _meth_834A();
    maps\mp\killstreaks\_aerial_utility::_id_6C89();
    _id_6D69( level._id_6566 );
    thread _id_A04F( 0.1 );
    thread _id_A051( 1.0 );
    thread _id_A006( 1.0 );
    thread _id_7FCF( 1.25 );
    thread _id_1FEE();
    self._id_7315 = 0;
    self._id_7317 = 0;
    self._id_7318 = 0;
    self._id_7316 = 0;

    if ( isdefined( level.orbitalsupport_planemodel ) && level.orbitalsupport_planemodel._id_21C9 )
    {
        self setclientomnvar( "ui_osp_avail_weapons", 1 );
        self setclientomnvar( "ui_osp_weapon", 1 );
        thread _id_37CD();
    }
    else
    {
        self notifyonplayercommand( "orbitalsupport_fire", "+attack" );
        self notifyonplayercommand( "orbitalsupport_fire", "+attack_akimbo_accessible" );
        self setclientomnvar( "ui_osp_weapon", 4 );
        thread _id_37CE();
    }

    thread _id_73BF();
    thread _id_73BD();
    thread _id_73C0();

    if ( !isbot( self ) )
        thread _id_73BE();

    wait 0.5;
    level._id_6564._id_5287 = 1;
    self setclientomnvar( "ui_osp_toggle", 2 );
    self setclientomnvar( "ui_warbird_countdown", var_0._id_6568 );
    var_2 = var_0 getentitynumber();
    self setclientomnvar( "ui_coop_primary_num", var_2 );
}

_id_6C91()
{
    var_0 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "coop" );

    if ( var_0 != "success" )
    {
        _id_73BC( var_0 == "disconnect" );
        self notify( "initRideKillstreak_complete", 0 );
        return;
    }

    self notify( "initRideKillstreak_complete", 1 );
}

_id_73BC( var_0 )
{
    self notify( "orbitalsupport_player_removed" );
    level notify( "orbitalsupport_buddy_removed" );

    if ( !var_0 )
    {
        _id_6D33();
        thread _id_73C9( 0.5 );
        maps\mp\_utility::revertvisionsetforplayer( 0 );
        self notifyonplayercommandremove( "ExitButtonDown", "+activate" );
        self notifyonplayercommandremove( "ExitButtonUp", "-activate" );
        self notifyonplayercommandremove( "ExitButtonDown", "+usereload" );
        self notifyonplayercommandremove( "ExitButtonUp", "-usereload" );

        if ( !isdefined( level.orbitalsupport_planemodel ) || !level.orbitalsupport_planemodel._id_21C9 )
        {
            self notifyonplayercommandremove( "orbitalsupport_fire", "+attack" );
            self notifyonplayercommandremove( "orbitalsupport_fire", "+attack_akimbo_accessible" );
        }

        self _meth_80E9( level._id_6566 );
        self unlink();
        level._id_6566 hide();
        maps\mp\killstreaks\_aerial_utility::_id_2B1E( self );
        self _meth_851A( 1 );
        self thermalvisionfofoverlayoff();
        self setblurforplayer( 0, 0 );
        maps\mp\killstreaks\_aerial_utility::_id_45E2();
        self _meth_834B();

        if ( getdvarint( "camera_thirdPerson" ) )
            maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( self._id_25F3 ) )
            self._id_25F3 destroy();

        if ( maps\mp\_utility::isusingremote() )
            maps\mp\_utility::clearusingremote();

        self._id_7315 = undefined;
        self._id_7317 = undefined;
        self._id_7318 = undefined;
        self._id_7316 = undefined;
        maps\mp\_utility::playerrestoreangles();
        maps\mp\killstreaks\_coop_util::_id_6D2F();
        maps\mp\_utility::playerremotekillstreakshowhud();
    }

    level._id_6564 = undefined;
    _id_8310();
}

_id_73BF()
{
    self endon( "orbitalsupport_player_removed" );
    self waittill( "disconnect" );
    thread _id_73BC( 1 );
}

_id_73BD()
{
    self endon( "orbitalsupport_player_removed" );
    self waittill( "joined_team" );
    thread _id_73BC( 0 );
}

_id_73C0()
{
    self endon( "orbitalsupport_player_removed" );
    common_scripts\utility::waittill_any( "joined_spectators", "spawned" );
    thread _id_73BC( 0 );
}

_id_73BE()
{
    self endon( "orbitalsupport_player_removed" );
    self notifyonplayercommand( "ExitButtonDown", "+activate" );
    self notifyonplayercommand( "ExitButtonUp", "-activate" );
    self notifyonplayercommand( "ExitButtonDown", "+usereload" );
    self notifyonplayercommand( "ExitButtonUp", "-usereload" );

    for (;;)
    {
        self waittill( "ExitButtonDown" );
        thread _id_8D2E();
        thread _id_1ABC();
    }
}

_id_8D2E()
{
    self endon( "orbitalsupport_player_removed" );
    self endon( "ExitButtonUp" );
    self._id_65A8 = 1;
    wait 0.5;

    if ( self._id_65A8 == 1 )
        thread _id_73BC( 0 );
}

_id_1ABC()
{
    self endon( "orbitalsupport_player_removed" );
    self waittill( "ExitButtonUp" );
    self._id_65A8 = 0;
}

_id_7FF3()
{
    var_0 = level.mapcenter[2] + 9275;
    var_1 = 8000;
    var_2 = ( 0, randomint( 360 ), 0 );

    if ( isdefined( level._id_6574._id_8989 ) )
        var_2 = ( 0, level._id_6574._id_8989, 0 );
    else if ( isdefined( level._id_6574._id_898B ) && isdefined( level._id_6574._id_898A ) )
        var_2 = ( 0, randomintrange( level._id_6574._id_898B, level._id_6574._id_898A ), 0 );

    if ( isdefined( level._id_6574._id_8A00 ) )
        var_1 = level._id_6574._id_8A00;

    if ( isdefined( level._id_6574._id_89DC ) )
        var_0 = level._id_6574._id_89DC;

    level.orbitalsupport_planemodel.angles = var_2;
    level.orbitalsupport_planemodel.origin -= vectornormalize( -1 * anglestoright( level.orbitalsupport_planemodel gettagangles( "tag_origin" ) ) ) * var_1;
    level.orbitalsupport_planemodel.origin += ( 0, 0, var_0 );
    level.orbitalsupport_planemodel._id_28BC = spawnstruct();
    level.orbitalsupport_planemodel._id_28BC.origin = level.orbitalsupport_planemodel.origin;
    level.orbitalsupport_planemodel._id_28BC.angles = level.orbitalsupport_planemodel.angles;
    level.orbitalsupport_planemodel.origin += ( 0.0, 0.0, 65000.0 );
}

_id_5F5E( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    level endon( "orbitalsupport_player_removed" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    thread _id_7600( 1, "off" );
    level.orbitalsupport_planemodel thread _id_6DB7();
    thread _id_6A41();
    level.orbitalsupport_planemodel scriptmodelplayanimdeltamotion( "paladin_ks_callin", "paladin_notetrack" );

    if ( isdefined( level.orbitalsupport_planemodel.owner ) )
        level.orbitalsupport_planemodel.owner thread _id_6C82( 1.5 );

    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "engines_full" );
    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "downward_stop" );

    if ( isdefined( level.orbitalsupport_planemodel.owner ) )
    {
        level.orbitalsupport_planemodel.owner stoprumble( "orbital_laser_charge" );
        level.orbitalsupport_planemodel.owner playrumbleonentity( "ac130_105mm_fire" );
        earthquake( 0.2, 2, level.orbitalsupport_planemodel._id_28BC.origin, 1000 );
    }

    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "engines_idle" );

    if ( var_0 )
    {
        level.orbitalsupport_planemodel linktosynchronizedparent( level._id_65AA, "tag_player" );
        thread _id_7600( level._id_656E );
    }

    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "end" );
    level.orbitalsupport_planemodel _meth_827A();
    level.orbitalsupport_planemodel scriptmodelplayanim( "paladin_ks_loop", "paladin_notetrack" );

    if ( isdefined( level.orbitalsupport_planemodel.owner ) )
    {
        level.orbitalsupport_planemodel._id_1FDC = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
        level.orbitalsupport_planemodel._id_1FDC linktosynchronizedparent( level.orbitalsupport_planemodel, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        level.orbitalsupport_planemodel._id_1FDC playloopsound( "paladin_flight_loop_near" );
    }

    level.orbitalsupport_planemodel._id_366B = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    level.orbitalsupport_planemodel._id_366B linktosynchronizedparent( level.orbitalsupport_planemodel, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    level.orbitalsupport_planemodel._id_366B playloopsound( "paladin_flight_loop_dist" );
    _id_8310();
    level.orbitalsupport_planemodel.paladinflying = 1;
}

_id_8310()
{
    if ( isdefined( level.orbitalsupport_planemodel._id_1FDC ) )
    {
        level.orbitalsupport_planemodel._id_1FDC hide();

        if ( isdefined( level.orbitalsupport_planemodel.owner ) )
            level.orbitalsupport_planemodel._id_1FDC showtoplayer( level.orbitalsupport_planemodel.owner );

        if ( isdefined( level._id_6564 ) && !level.splitscreen && !_id_173B( level.orbitalsupport_planemodel.owner, level._id_6564 ) )
            level.orbitalsupport_planemodel._id_1FDC showtoplayer( level._id_6564 );
    }

    if ( isdefined( level.orbitalsupport_planemodel._id_366B ) )
    {
        level.orbitalsupport_planemodel._id_366B hide();

        foreach ( var_1 in level.players )
        {
            if ( level.splitscreen || isdefined( level.orbitalsupport_planemodel.owner ) && _id_173B( level.orbitalsupport_planemodel.owner, var_1 ) )
                continue;

            if ( isdefined( level.orbitalsupport_planemodel.owner ) && var_1 != level.orbitalsupport_planemodel.owner )
                level.orbitalsupport_planemodel._id_366B showtoplayer( var_1 );
        }
    }
}

_id_173B( var_0, var_1 )
{
    return var_0 issplitscreenplayer() && var_1 issplitscreenplayer();
}

_id_6C82( var_0 )
{
    self endon( "disconnect" );
    self endon( "orbitalsupport_player_removed" );
    wait(var_0);
    self playrumbleonentity( "orbital_laser_charge" );
}

_id_6DB7()
{
    level.orbitalsupport_planemodel endon( "death" );
    level.orbitalsupport_planemodel endon( "crashing" );
    level endon( "game_ended" );
    level endon( "orbitalsupport_player_removed" );
    level.orbitalsupport_planemodel endon( "stopEffects" );
    playfxontag( common_scripts\utility::getfx( "orbitalsupport_entry" ), level.orbitalsupport_planemodel, "tag_origin" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    waitframe();
    playfx( common_scripts\utility::getfx( "orbitalsupport_entry_flash" ), level.orbitalsupport_planemodel._id_28BC.origin );
    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "engines_full" );
    playfxontag( common_scripts\utility::getfx( "orbitalsupport_light" ), level.orbitalsupport_planemodel, "tag_light_tail" );
    playfxontag( common_scripts\utility::getfx( "orbitalsupport_entry_complete" ), level.orbitalsupport_planemodel, "tag_light_belly" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    level.orbitalsupport_planemodel waittillmatch( "paladin_notetrack", "engines_idle" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "orbitalsupport_entry" ), level.orbitalsupport_planemodel, "tag_origin" );
}

_id_6A41()
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    level endon( "orbitalsupport_player_removed" );
    wait 1;
    playsoundatpos( level.orbitalsupport_planemodel._id_28BC.origin, "paladin_orbit_drop" );
}

_id_6571()
{
    level.orbitalsupport_planemodel endon( "crashing" );
    level.orbitalsupport_planemodel notify( "leaving" );
    level.orbitalsupport_planemodel unlink();
    level.orbitalsupport_planemodel scriptmodelplayanimdeltamotion( "paladin_ks_exit", "paladin_notetrack" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    stopfxontag( common_scripts\utility::getfx( "vehicle_osp_jet" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg_trl" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg_trl" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg_trl" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1" );
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg_trl" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_osp_jet_lg_trl" ), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_B" );
    wait 4.8;
    _id_1E8E();
    level.orbitalsupport_planemodel delete();
    level.orbitalsupportinuse = 0;
}

_id_8328()
{
    level._id_6567 = 0;

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.team ) && level.orbitalsupport_planemodel.owner.team == var_1.team )
            continue;
        else if ( !isdefined( var_1.team ) )
        {
            var_1 _id_64D4();
            continue;
        }

        var_1 thread _id_6D14();
        var_1 thread _id_6D16();
    }

    level thread _id_64C7();
}

_id_64C7()
{
    level endon( "game_ended" );
    level.orbitalsupport_planemodel.owner endon( "orbitalsupport_player_removed" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread _id_64D4();
    }
}

_id_64D4()
{
    self waittill( "spawned_player" );
    thread _id_6D14();
    thread _id_6D16();
    _id_8310();
}

_id_6D16()
{
    self endon( "disconnect" );
    level.orbitalsupport_planemodel.owner endon( "orbitalsupport_player_removed" );
    var_0 = level.orbitalsupport_planemodel.owner.team;

    for (;;)
    {
        self waittill( "paint_marked_target", var_1 );

        if ( self.team == var_0 || !isdefined( var_1 ) )
            continue;

        if ( isdefined( level._id_6564 ) && var_1 == level._id_6564 && gettime() > level._id_6565 )
        {
            level._id_6565 = gettime() + 10000;

            if ( !level.orbitalsupport_planemodel._id_21C9 )
                var_1 maps\mp\_utility::leaderdialogonplayer( "copilot_marked_mp_paladin" );
        }
    }
}

_id_6D14()
{
    self endon( "disconnect" );
    level.orbitalsupport_planemodel.owner endon( "orbitalsupport_player_removed" );
    var_0 = level.orbitalsupport_planemodel.owner.team;

    for (;;)
    {
        self waittill( "death", var_1, var_2, var_3 );

        if ( self.team == var_0 || !isdefined( var_1 ) )
            continue;

        if ( var_1 == level.orbitalsupport_planemodel.owner && gettime() > level._id_6567 )
        {
            level._id_6567 = gettime() + 10000;
            var_1 maps\mp\_utility::leaderdialogonplayer( "copilot_enemykill_mp_paladin" );
        }

        if ( isdefined( level._id_6564 ) && var_1 == level._id_6564 && gettime() > level._id_6565 )
        {
            level._id_6565 = gettime() + 10000;

            if ( level.orbitalsupport_planemodel._id_21C9 )
                var_1 maps\mp\_utility::leaderdialogonplayer( "copilot_enemykill_mp_paladin" );
        }
    }
}

turretdeletesoundent()
{
    if ( isdefined( self.soundent ) )
        self.soundent delete();
}

_id_6D33()
{
    self setclientomnvar( "ui_killstreak_optic", 0 );
    self setclientomnvar( "ui_osp_rockets", 0 );
    self setclientomnvar( "ui_osp_avail_weapons", 0 );
    self setclientomnvar( "ui_osp_weapon", 0 );
    self setclientomnvar( "ui_osp_reload_bitfield", 0 );
    self setclientomnvar( "ui_osp_toggle", 0 );
    self setclientomnvar( "ui_coop_primary_num", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C89();
}

_id_7600( var_0, var_1 )
{
    level notify( "stop_rotatePlane_thread" );
    level endon( "stop_rotatePlane_thread" );

    if ( !isdefined( var_1 ) )
        var_1 = "on";

    if ( var_1 == "on" )
    {
        level._id_65AA rotateyaw( 360, var_0, 0.5 );
        wait(var_0);

        for (;;)
        {
            level._id_65AA rotateyaw( 360, var_0 );
            wait(var_0);
        }
    }
    else if ( var_1 == "off" )
    {
        var_2 = 10;
        var_3 = var_0 / 360 * var_2;
        level._id_65AA rotateyaw( level._id_65AA.angles[2] + var_2, var_3, 0, var_3 );
    }
}

spawnmuzzleflashent( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_3 setmodel( "tag_origin" );
    var_3 linkto( var_0, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3 hide();

    foreach ( var_5 in level.players )
    {
        if ( var_5 != var_2 )
            var_3 showtoplayer( var_5 );
    }

    thread onplayerconnectmuzzleflashent( var_3 );
    return var_3;
}

onplayerconnectmuzzleflashent( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        thread onplayerspawnedmuzzleflashent( var_0, var_1 );
    }
}

onplayerspawnedmuzzleflashent( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 waittill( "spawned_player" );
    var_0 showtoplayer( var_1 );
}
