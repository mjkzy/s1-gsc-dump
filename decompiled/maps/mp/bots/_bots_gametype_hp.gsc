// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8058();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_164E;
    level.bot_funcs["should_start_cautious_approach"] = ::_id_8477;
}

_id_8058()
{
    maps\mp\bots\_bots_util::_id_172D();

    for ( var_0 = 0; var_0 < level.all_hp_zones.size; var_0++ )
    {
        var_1 = level.all_hp_zones[var_0];
        var_1.script_label = "zone_" + var_0;
        var_1 thread _id_5E20();
        var_2 = 0;

        if ( isdefined( var_1.trig.trigger_off ) && var_1.trig.trigger_off )
        {
            var_1.trig common_scripts\utility::trigger_on();
            var_2 = 1;
        }

        var_1._id_6136 = _func_1FE( var_1.trig );
        maps\mp\bots\_bots_gametype_common::_id_15A3( var_1, var_1.trig );

        if ( var_2 )
            var_1.trig common_scripts\utility::trigger_off();
    }

    _id_15C0( 1 );
    level._id_164D = 1;
    level._id_1628 = 1;
    thread _id_15C0( 0 );
}

_id_15C0( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = 0;

    foreach ( var_5 in level.all_hp_zones )
    {
        if ( var_0 && var_5 != level.zone || !var_0 && var_5 == level.zone )
            continue;

        var_6 = 0;
        var_5._id_331F = [];
        var_5._id_A3D7 = _id_19D8( var_5 );
        var_5._id_1C10 = _id_A3DC( var_5, 0, 0 );
        var_7 = [ ( 0.0, 0.0, 0.0 ), ( 1.0, 1.0, 0.0 ), ( 1.0, -1.0, 0.0 ), ( -1.0, 1.0, 0.0 ), ( -1.0, -1.0, 0.0 ) ];

        foreach ( var_9 in var_7 )
        {
            var_10 = _id_A3DC( var_5, var_9[0], var_9[1] );
            var_1[var_3] = var_10.origin;
            var_11 = var_5.script_label + "_" + var_6;
            var_2[var_3] = var_11;
            var_5._id_331F[var_5._id_331F.size] = var_11;
            var_3++;
            var_6++;
        }
    }

    maps\mp\bots\_bots_gametype_common::_id_15BD( var_1, var_2, 1 );
}

_id_19D8( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_5C2E = ( 999999.0, 999999.0, 999999.0 );
    var_1._id_5A0D = ( -999999.0, -999999.0, -999999.0 );

    foreach ( var_3 in var_0._id_6136 )
    {
        var_1._id_5C2E = ( min( var_3.origin[0], var_1._id_5C2E[0] ), min( var_3.origin[1], var_1._id_5C2E[1] ), min( var_3.origin[2], var_1._id_5C2E[2] ) );
        var_1._id_5A0D = ( max( var_3.origin[0], var_1._id_5A0D[0] ), max( var_3.origin[1], var_1._id_5A0D[1] ), max( var_3.origin[2], var_1._id_5A0D[2] ) );
    }

    var_1.center = ( ( var_1._id_5C2E[0] + var_1._id_5A0D[0] ) / 2, ( var_1._id_5C2E[1] + var_1._id_5A0D[1] ) / 2, ( var_1._id_5C2E[2] + var_1._id_5A0D[2] ) / 2 );
    var_1._id_44F8 = ( var_1._id_5A0D[0] - var_1.center[0], var_1._id_5A0D[1] - var_1.center[1], var_1._id_5A0D[2] - var_1.center[2] );
    var_1.radius = max( var_1._id_44F8[0], var_1._id_44F8[1] );
    return var_1;
}

_id_A3DC( var_0, var_1, var_2 )
{
    var_3 = ( var_0._id_A3D7.center[0] + var_1 * var_0._id_A3D7._id_44F8[0], var_0._id_A3D7.center[1] + var_2 * var_0._id_A3D7._id_44F8[1], 0 );
    var_4 = undefined;
    var_5 = 9999999;

    foreach ( var_7 in var_0._id_6136 )
    {
        var_8 = _func_220( var_7.origin, var_3 );

        if ( var_8 < var_5 )
        {
            var_5 = var_8;
            var_4 = var_7;
        }
    }

    return var_4;
}

_id_5E20()
{
    self notify( "monitor_zone_control" );
    self endon( "monitor_zone_control" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = self.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

        if ( var_0 != "neutral" && var_0 != "none" )
        {
            var_1 = _func_202( self.origin );

            if ( isdefined( var_1 ) )
                botzonesetteam( var_1, var_0 );
        }

        wait 1.0;
    }
}

_id_164E()
{
    self notify( "bot_hp_think" );
    self endon( "bot_hp_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    self _meth_8351( "grenade_objectives", 1 );
    var_0 = undefined;
    var_1 = level.zone;

    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        if ( var_1 != level.zone )
        {
            var_0 = undefined;
            var_1 = level.zone;
        }

        if ( !isdefined( var_0 ) && level.randomzonespawn == 0 && level._id_164D )
        {
            var_2 = level.zonemovetime - gettime();

            if ( var_2 > 0 && var_2 < 10000 )
            {
                var_3 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam() == self.team;

                if ( !var_3 )
                {
                    var_4 = level.zone._id_A3D7.radius * 6;

                    if ( var_2 < 5000 )
                        var_4 = level.zone._id_A3D7.radius * 3;

                    var_5 = distance( level.zone._id_A3D7.center, self.origin );

                    if ( var_5 > var_4 )
                        var_0 = _id_16F6();
                }
                else
                {
                    var_6 = maps\mp\bots\_bots_util::_id_1636( self.team );
                    var_7 = ceil( var_6 / 2 );

                    if ( var_2 < 5000 )
                        var_7 = ceil( var_6 / 3 );

                    var_8 = _id_1638( level.zone );

                    if ( var_8 + 1 > var_7 )
                        var_0 = _id_16F6();
                }
            }
        }

        var_9 = level.zone;

        if ( isdefined( var_0 ) && var_0 )
            var_9 = level.zones[( level.prevzoneindex + 1 ) % level.zones.size];

        if ( !_id_165C( var_9 ) )
            _id_15D0( var_9 );
    }
}

_id_16F6()
{
    if ( level.randomzonespawn )
        return 0;
    else
    {
        var_0 = self _meth_837B( "strategyLevel" );
        var_1 = 0;

        if ( var_0 == 1 )
            var_1 = 0.1;
        else if ( var_0 == 2 )
            var_1 = 0.5;
        else if ( var_0 == 3 )
            var_1 = 0.8;

        return randomfloat( 1.0 ) < var_1;
    }
}

_id_1638( var_0 )
{
    return _id_163E( var_0 ).size;
}

_id_163E( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.participants )
    {
        if ( var_3 != self && maps\mp\_utility::isteamparticipant( var_3 ) && _func_285( self, var_3 ) )
        {
            if ( var_3 istouching( level.zone.trig ) )
            {
                if ( !isai( var_3 ) || var_3 _id_165C( var_0 ) )
                    var_1[var_1.size] = var_3;
            }
        }
    }

    return var_1;
}

_id_165C( var_0 )
{
    if ( !maps\mp\bots\_bots_util::_id_165A() )
        return 0;

    return self._id_2507 == var_0;
}

_id_15D0( var_0 )
{
    self._id_2507 = var_0;
    var_1["entrance_points_index"] = var_0._id_331F;
    var_1["override_origin_node"] = var_0._id_1C10;
    maps\mp\bots\_bots_strategy::_id_15D2( var_0.origin, var_0._id_6136, var_0.trig, var_1 );
}

_id_8477( var_0 )
{
    if ( var_0 )
    {
        var_1 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

        if ( var_1 == "neutral" || var_1 == self.team )
            return 0;
    }

    return maps\mp\bots\_bots_strategy::_id_8475( var_0 );
}
