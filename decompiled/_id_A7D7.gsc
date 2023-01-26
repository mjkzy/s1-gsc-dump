// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_5FC7 = spawnstruct();
    level._id_5FC7._id_5386 = 0;
    level._id_5FC7._id_5382 = 25;
    level._id_5FC7._id_8A4F = 1.25;
    level._id_5FC7._id_4780 = 1.75;
    level._id_5FC7._id_5A07 = 1500;
    level._id_5FC7._id_34EF = loadfx( "vfx/lights/air_light_exosuper_yellow" );
    level._id_5FC7._id_0B82 = loadfx( "vfx/lights/air_light_amplifymachine_yellow" );
    var_0 = getent( "damage_ring_01", "targetname" );
    var_1 = getent( "damage_ring_02", "targetname" );
    level._id_5FC7._id_25AC = [ var_0, var_1 ];

    foreach ( var_3 in level._id_5FC7._id_25AC )
    {
        var_3 _meth_83FA( 1, 1 );
        var_3 setcandamage( 1 );
        var_3 setcanradiusdamage( 1 );
        var_3._id_5A03 = level._id_5FC7._id_5A07;
        var_3.health = var_3._id_5A03;
        var_3.maxhealth = var_3._id_5A03;
        var_3._id_3650 = var_3._id_5A03;
        var_4 = common_scripts\utility::getstructarray( var_3.target, "targetname" );
        var_3._id_90B1 = [];

        foreach ( var_6 in var_4 )
        {
            var_7 = common_scripts\utility::spawn_tag_origin();
            var_7.origin = var_6.origin;
            var_7 show();
            var_3._id_90B1[var_3._id_90B1.size] = var_7;
        }
    }

    precachestring( &"KILLSTREAKS_MP_RECOVERY" );
    level.killstreakfuncs["mp_recovery"] = ::_id_98B1;
    level.mapkillstreak = "mp_recovery";
    level thread _id_64DB();
}

_id_98B1( var_0, var_1 )
{
    if ( level._id_5FC7._id_5386 )
    {
        self iclientprintlnbold( &"MP_RECOVERY_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_2 = _id_3512( self );

    if ( isdefined( var_2 ) && var_2 )
        maps\mp\_matchdata::logkillstreakevent( "mp_recovery", self.origin );

    return var_2;
}

_id_3512( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        level._id_5FC7._id_5386 = 1;
        level._id_5FC7.owner = var_0;
        level._id_5FC7._id_5390 = var_0.team;
    }
    else
        return 0;

    var_1 = var_0.team;
    thread _id_8D0C( var_0, var_1 );
    return 1;
}

_id_8D0C( var_0, var_1 )
{
    _id_82F5( var_0, var_1 );
    _id_8892( var_0, var_1 );
    thread _id_7FA1();
    level common_scripts\utility::waittill_any( "time_up", "amplifier_destroyed" );
    _id_854C();
    _id_854B();
    level notify( "recovery_streak_over" );
    wait 0.25;
    level._id_5FC7._id_5386 = 0;
}

_id_7FA1()
{
    level endon( "recovery_streak_over" );
    wait(level._id_5FC7._id_5382);
    level notify( "time_up" );
}

_id_82F5( var_0, var_1 )
{
    var_2 = "atlas";
    var_3 = "axis";

    if ( var_1 == "axis" )
    {
        var_2 = "atlas";
        var_3 = "allies";
    }
    else if ( var_1 == "allies" )
    {
        var_2 = "sentinel";
        var_3 = "axis";
    }

    var_4 = "faction_128_" + var_2;

    foreach ( var_6 in level._id_5FC7._id_25AC )
    {
        var_6 setcandamage( 1 );
        var_6 setcanradiusdamage( 1 );
        var_6.health = var_6._id_5A03;
        var_6.maxhealth = var_6._id_5A03;
        var_6._id_3650 = var_6._id_5A03;
        var_6 thread _id_8CF8();
        var_6 thread _id_5E28( var_0, var_1 );

        if ( level._id_2FEC == "before" && var_6.targetname == "damage_ring_02" )
            continue;
        else if ( level._id_2FEC == "after" && var_6.targetname == "damage_ring_01" )
            continue;

        if ( level.teambased == 0 )
        {
            foreach ( var_8 in level.players )
            {
                if ( var_8 != var_0 )
                    var_6 maps\mp\_entityheadicons::setheadicon( var_8, var_4, ( 0.0, 0.0, 0.0 ), 18, 18, undefined, undefined, undefined, 1, 0, 0 );
            }

            continue;
        }

        if ( level.teambased == 1 )
            var_6 maps\mp\_entityheadicons::setheadicon( var_3, var_4, ( 0.0, 0.0, 0.0 ), 18, 18, undefined, undefined, undefined, 1, 0, 0 );
    }
}

_id_5E28( var_0, var_1 )
{
    level endon( "recovery_streak_over" );

    while ( level._id_5FC7._id_5386 == 1 )
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( !_id_51F5( var_3, var_0, var_1 ) )
        {
            self._id_3650 += var_2 * -1;

            if ( self._id_3650 <= 0 )
            {
                level notify( "amplifier_destroyed" );
                return;
            }
        }
    }
}

_id_8CF8()
{
    foreach ( var_1 in level._id_5FC7._id_25AC )
    {
        foreach ( var_3 in var_1._id_90B1 )
            playfxontag( level._id_5FC7._id_0B82, var_3, "tag_origin" );
    }
}

_id_854C()
{
    _id_8550();

    foreach ( var_1 in level._id_5FC7._id_25AC )
    {
        var_1 destroyplayericons();

        foreach ( var_3 in var_1._id_90B1 )
            stopfxontag( level._id_5FC7._id_0B82, var_3, "tag_origin" );
    }
}

destroyplayericons()
{
    if ( isdefined( self.entityheadicons ) )
    {
        if ( isdefined( self.entityheadicons["allies"] ) )
        {
            self.entityheadicons["allies"] destroy();
            self.entityheadicons["allies"] = undefined;
        }

        if ( isdefined( self.entityheadicons["axis"] ) )
        {
            self.entityheadicons["axis"] destroy();
            self.entityheadicons["axis"] = undefined;
        }

        foreach ( var_1 in level.players )
        {
            if ( isdefined( self.entityheadicons[var_1.guid] ) )
            {
                self.entityheadicons[var_1.guid] destroy();
                self.entityheadicons[var_1.guid] = undefined;
            }
        }
    }
}

_id_8550()
{
    foreach ( var_1 in level.players )
    {
        foreach ( var_3 in level._id_5FC7._id_25AC )
            var_3 hudoutlinedisableforclient( var_1 );
    }
}

_id_992F( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( !_id_51F5( var_3, var_0, var_1 ) )
        {
            foreach ( var_5 in level._id_5FC7._id_25AC )
                var_5 hudoutlineenableforclient( var_3, 1, 1 );
        }
    }
}

_id_8892( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( _id_51F5( var_3, var_0, var_1 ) == 1 )
        {
            if ( maps\mp\_utility::isreallyalive( var_3 ) )
            {
                var_3 _id_8338();
                var_3 thread _id_4202();
            }
        }

        var_3 thread _id_5EC4( var_0, var_1 );
    }

    thread _id_5E36( var_0, var_1 );
}

_id_854B()
{
    foreach ( var_1 in level.players )
        var_1 _id_854D();
}

_id_854D()
{
    if ( isdefined( self._id_8FD7 ) && isdefined( self._id_8FD7.isactive ) )
        self._id_8FD7.isactive = 0;

    _id_8552();
    _id_854E();
    _id_854F();
    _id_8551();
}

_id_8551()
{
    if ( isdefined( self._id_198C ) && self._id_198C == 1 )
    {

    }
    else if ( maps\mp\_utility::_hasperk( "specialty_exo_slamboots" ) )
        maps\mp\_utility::_unsetperk( "specialty_exo_slamboots" );

    self._id_198C = undefined;
}

_id_8552()
{
    self.movespeedscaler = level.baseplayermovescale;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();

    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

_id_854F()
{
    self.maxhealth = int( self.maxhealth / level._id_5FC7._id_4780 );

    if ( self.health > self.maxhealth )
        self.health = self.maxhealth;

    self.healthregenlevel = undefined;
}

_id_854E()
{
    if ( isdefined( self._id_8FD7 ) && isdefined( self._id_8FD7.overlay ) )
        self._id_8FD7.overlay destroy();

    if ( isdefined( level._id_5FC7._id_34EF ) )
    {
        if ( maps\mp\_utility::isreallyalive( self ) )
        {
            stopfxontag( level._id_5FC7._id_34EF, self, "tag_shield_back" );
            stopfxontag( level._id_5FC7._id_34EF, self, "j_knee_le" );
            stopfxontag( level._id_5FC7._id_34EF, self, "j_knee_ri" );
        }
    }
}

_id_4202()
{
    _id_8338();
    self._id_8FD7.isactive = 1;
    _id_4206();
    _id_4203();
    _id_4207();
    _id_4204();
    _id_4205();
    _id_9930();
    thread _id_A217();
}

_id_A217()
{
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );
    self endon( "disconnect" );
    self waittill( "death" );

    if ( level._id_5FC7._id_5386 == 1 )
        _id_854D();
}

_id_4206()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self.movespeedscaler = level._id_5FC7._id_8A4F;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
}

_id_4203()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self.maxhealth = int( self.maxhealth * level._id_5FC7._id_4780 );
    self.ignoreregendelay = 1;
    self.healthregenlevel = 0.99;
    self notify( "damage" );
}

_id_4207()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    self._id_198C = undefined;

    if ( maps\mp\_utility::_hasperk( "specialty_exo_slamboots" ) )
        self._id_198C = 1;
    else
    {
        maps\mp\_utility::giveperk( "specialty_exo_slamboots", 0 );
        self._id_198C = 0;
    }
}

_id_4204()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
}

_id_4205()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );
    thread maps\mp\_exo_repulsor::do_exo_repulsor();
}

_id_9930()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );

    if ( !isdefined( self._id_8FD7.overlay ) )
    {
        self._id_8FD7.overlay = newclienthudelem( self );
        self._id_8FD7.overlay.x = 0;
        self._id_8FD7.overlay.y = 0;
        self._id_8FD7.overlay.horzalign = "fullscreen";
        self._id_8FD7.overlay.vertalign = "fullscreen";
        self._id_8FD7.overlay setshader( "exo_hud_cloak_overlay", 640, 480 );
        self._id_8FD7.overlay._id_0CCB = 1;
        self._id_8FD7.overlay.alpha = 1.0;
    }

    if ( isdefined( level._id_5FC7._id_34EF ) )
    {
        playfxontag( level._id_5FC7._id_34EF, self, "tag_shield_back" );
        playfxontag( level._id_5FC7._id_34EF, self, "j_knee_le" );
        playfxontag( level._id_5FC7._id_34EF, self, "j_knee_ri" );
    }
}

_id_8338()
{
    if ( !isdefined( self._id_8FD7 ) )
        self._id_8FD7 = spawnstruct();

    if ( !isdefined( level._id_5FC7._id_34EF ) )
        level._id_5FC7._id_34EF = loadfx( "vfx/lights/air_light_exosuper_yellow" );

    self._id_8FD7.isactive = 0;
}

_id_51F5( var_0, var_1, var_2 )
{
    if ( level.teambased == 0 && isdefined( var_1 ) && var_0 == var_1 )
        return 1;
    else if ( level.teambased == 1 && var_0.team == var_2 )
        return 1;
    else
        return 0;
}

_id_5EC4( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );

    while ( level._id_5FC7._id_5386 == 1 )
    {
        self waittill( "spawned_player" );

        if ( _id_51F5( self, var_0, var_1 ) == 1 )
        {
            wait 0.25;

            if ( level._id_5FC7._id_5386 == 1 )
            {
                _id_8338();
                thread _id_4202();
            }
        }
    }
}

_id_5E36( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "recovery_streak_over" );

    while ( level._id_5FC7._id_5386 == 1 )
    {
        level waittill( "connected", var_2 );
        var_2 _id_5EC4( var_0, var_1 );
    }
}

_id_64DB()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );

        foreach ( var_2 in level._id_5FC7._id_25AC )
            var_2 hudoutlinedisableforclient( var_0 );

        var_0 thread _id_64DC();
    }
}

_id_64DC()
{
    level endon( "game_ended" );
    self waittill( "disconnect" );
}
