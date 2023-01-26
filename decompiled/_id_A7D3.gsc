// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakwieldweapons["detroit_tram_turret_mp"] = "mp_detroit";
    level.killstreakfuncs["mp_detroit"] = ::_id_98AC;
    level.mapkillstreak = "mp_detroit";
    level._id_598A = &"MP_DETROIT_MAP_KILLSTREAK_PICKUP";
    level.getaerialkillstreakarray = ::_id_96C2;
    level._id_8F1E = getentarray( "streak_tram", "targetname" );
    common_scripts\utility::array_thread( level._id_8F1E, maps\mp\mp_detroit_events::_id_96AA );
    common_scripts\utility::array_thread( level._id_8F1E, ::_id_96AD );
    level._id_29C3 = [];
    var_0 = [ "allies", "axis" ];

    foreach ( var_2 in var_0 )
    {
        level._id_29C3[var_2] = maps\mp\gametypes\_gameobjects::getnextobjid();
        objective_add( level._id_29C3[var_2], "invisible", ( 0.0, 0.0, 0.0 ) );
        objective_icon( level._id_29C3[var_2], common_scripts\utility::ter_op( var_2 == "allies", "compass_objpoint_tram_turret_friendly", "compass_objpoint_tram_turret_enemy" ) );
    }
}

_id_82FA()
{
    level thread maps\mp\bots\_bots_ks::_id_16CC( "mp_detroit", maps\mp\bots\_bots_ks::_id_167B );
}

_id_96AD()
{
    self._id_40F1 = ::_id_96BD;
}

_id_96BD()
{
    return self gettagorigin( "tag_turret" );
}

_id_96C2( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level._id_8F1E )
    {
        if ( var_3._id_0014 && isdefined( var_3.owner ) && ( !level.teambased || var_3.owner.team == var_0 ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_98AC( var_0, var_1 )
{
    if ( level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_TOO_MANY_VEHICLES" );
        return 0;
    }

    var_2 = 0;

    foreach ( var_4 in level._id_8F1E )
    {
        if ( var_4._id_0014 )
        {
            var_2 = 1;
            break;
        }
        else
            var_4 maps\mp\mp_detroit_events::_id_96B3();
    }

    var_6 = undefined;

    if ( !var_2 )
    {
        level._id_8F1E = sortbydistance( level._id_8F1E, self.origin );
        var_6 = level._id_8F1E[0];
    }

    if ( isdefined( var_6 ) )
    {
        var_7 = maps\mp\killstreaks\_killstreaks::initridekillstreak( "mp_detroit_tram" );

        if ( var_7 != "success" )
            return 0;

        maps\mp\_utility::incrementfauxvehiclecount();
        thread _id_76C0( var_6 );
        return 1;
    }
    else
    {
        self iclientprintlnbold( &"MP_DETROIT_MAP_KILLSTREAK_NOT_AVAILABLE" );
        return 0;
    }
}

_id_76C0( var_0 )
{
    var_1 = 35;
    var_0 maps\mp\mp_detroit_events::_id_96B3();
    var_0.owner = self;
    var_0.team = self.team;
    var_0.turret = var_0 _id_8968();
    var_0.isleaving = 0;
    var_0.stopdamagefunc = 0;
    var_0 _id_96B6();
    var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback( 1000, undefined, ::_id_96C3, undefined, 1 );
    self notifyonplayercommand( "CancelTramStart", "+usereload" );
    self notifyonplayercommand( "CancelTramEnd", "-usereload" );
    maps\mp\_utility::setusingremote( "mp_detroit_tram" );
    self _meth_80E8( var_0.turret, 30, var_0.angles[1] - 90 );
    var_0 thread _id_96C0();
    var_0 common_scripts\utility::make_entity_sentient_mp( var_0.team );
    self _meth_807E( var_0, "tag_player", 0, 180, 180, 0, 90, 0 );
    self _meth_80A0( 0 );
    self thermalvisionfofoverlayon();
    self setclientomnvar( "ui_detroit_tram_turret", 1 );
    var_0 thread _id_96B0();
    var_0 thread _id_96AB();
    var_0 thread _id_96AC();
    var_0 thread _id_96AF( var_1 );
    var_0 thread _id_96AE();
    var_0 thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

_id_96C0()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );
    self.turret endon( "death" );
    self._id_9199 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    self._id_9199 setmodel( "tag_origin" );
    self.turret _meth_8508( self._id_9199 );

    for (;;)
    {
        var_1 = self.turret gettagorigin( "tag_player" );
        var_2 = self.turret gettagorigin( "tag_player" ) + anglestoforward( self.turret gettagangles( "tag_player" ) ) * 20000;
        var_3 = bullettrace( var_1, var_2, 0, self.turret );
        var_4 = var_3["position"];
        self._id_9199.origin = var_4;
        waitframe();
    }
}

_id_96AE()
{
    self endon( "player_exit" );
    level waittill( "game_ended" );
    self notify( "player_exit" );
}

_id_96B6()
{
    foreach ( var_2, var_1 in level._id_29C3 )
    {
        objective_state( var_1, "active" );

        if ( var_2 == "allies" )
            objective_playerteam( var_1, self.owner getentitynumber() );
        else
            objective_playerenemyteam( var_1, self.owner getentitynumber() );

        objective_onentitywithrotation( var_1, self.turret._id_62B9 );
    }
}

_id_96A9()
{
    foreach ( var_2, var_1 in level._id_29C3 )
        objective_state( var_1, "invisible" );
}

_id_96C3( var_0, var_1, var_2, var_3 )
{
    self notify( "player_exit" );
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "map_killstreak_destroyed", undefined, "callout_destroyed_tram_turet", 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "vehicle_pdrone_explosion" ), self, "tag_turret" );

    if ( isdefined( self.turret ) )
        self.turret delete();

    if ( isdefined( self._id_9199 ) )
        self._id_9199 delete();
}

_id_96AB()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "CancelTramStart" );
        var_1 = var_0 common_scripts\utility::waittill_any_timeout( 1, "CancelTramEnd" );

        if ( var_1 == "timeout" )
            self notify( "player_exit" );
    }
}

_id_96B0()
{
    var_0 = self.owner;
    self endon( "player_exit" );
    var_0 endon( "disconnect" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    self notify( "player_exit" );
}

_id_96AF( var_0 )
{
    maps\mp\mp_detroit_events::_id_96B9( var_0 );
    self notify( "player_exit" );
    self waittill( "trackEnd" );

    if ( isdefined( self.turret ) )
        self.turret delete();

    if ( isdefined( self._id_9199 ) )
        self._id_9199 delete();
}

_id_96AC()
{
    self endon( "disconnect" );
    self waittill( "player_exit" );
    _id_96A9();
    self.owner setclientomnvar( "ui_detroit_tram_turret", 0 );
    self.owner thermalvisionfofoverlayoff();
    self.owner unlink();
    self.owner _meth_80E9( self.turret );
    self freeentitysentient();
    self.owner maps\mp\_utility::clearusingremote();
    self.owner = undefined;
    thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
    self notify( "leaving" );
    self.isleaving = 1;
}

_id_8968()
{
    var_0 = "tag_turret";
    var_1 = spawnturret( "misc_turret", self.origin, "detroit_tram_turret_mp", 0 );
    var_1.angles = ( 0.0, 0.0, 0.0 );
    var_1 setmodel( "vehicle_xh9_warbird_turret_detroit_mp" );
    var_1 _meth_815A( 45.0 );
    var_1 linkto( self, var_0, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_1.owner = self.owner;
    var_1.health = 99999;
    var_1.maxhealth = 1000;
    var_1.damagetaken = 0;
    var_1.stunned = 0;
    var_1._id_8F70 = 0.0;
    var_1 setcandamage( 0 );
    var_1 setcanradiusdamage( 0 );
    var_1.team = self.team;
    var_1.pers["team"] = self.team;

    if ( level.teambased )
        var_1 _meth_8135( self.team );

    var_1 _meth_8065( "sentry_manual" );
    var_1 _meth_8103( self.owner );
    var_1 _meth_8105( 0 );
    var_1.chopper = self;
    var_2 = spawn( "script_model", self.origin );
    var_2 linkto( var_1, "tag_aim_pivot", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_2 setcontents( 0 );
    var_1 thread common_scripts\utility::delete_on_death( var_2 );
    var_1._id_62B9 = var_2;
    return var_1;
}
