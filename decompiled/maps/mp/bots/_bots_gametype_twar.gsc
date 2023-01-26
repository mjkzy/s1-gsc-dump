// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level._id_164F = 0;

    if ( level.currentgen )
        level._id_164F = 1;

    _id_806C();
    _id_805B();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_1722;
    level.bot_funcs["should_start_cautious_approach"] = ::_id_1721;

    if ( !level._id_164F )
        level.bot_funcs["get_watch_node_chance"] = ::_id_171D;
}

_id_805B()
{
    maps\mp\bots\_bots_util::_id_172D( 1 );

    for ( var_0 = 0; var_0 < level.twar_zones.size; var_0++ )
        level.twar_zones[var_0].script_label = "_" + var_0;

    maps\mp\bots\_bots_gametype_common::_id_15BF( level.twar_zones, "zone", level._id_164F );
    var_1 = 55;
    var_2 = 0;

    foreach ( var_4 in level.twar_zones )
    {
        if ( !isdefined( var_4.nearest_node ) )
            return;

        var_4 thread _id_5E20();
        var_5 = ( var_4.origin - ( 0, 0, var_1 ) + ( var_4.origin + ( 0, 0, level.zone_height ) ) ) / 2.0;
        var_6 = ( level.zone_height + var_1 ) / 2.0;
        var_4._id_6136 = getnodesinradius( var_5, level.zone_radius, 0, var_6 );

        if ( var_4._id_6136.size < 6 )
        {
            var_2++;

            if ( var_2 == 1 )
            {
                wait 5;
                continue;
            }

            wait 1;
        }
    }

    level._id_1628 = 1;
}

_id_5E20()
{
    self notify( "monitor_zone_control" );
    self endon( "monitor_zone_control" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1.0;
        var_0 = self.owner;

        if ( var_0 == "none" && level.twar_use_obj.userate > 0 )
            var_0 = level.twar_use_obj.claimteam;

        if ( var_0 != "none" )
        {
            var_1 = _func_202( self.origin );

            if ( isdefined( var_1 ) )
                botzonesetteam( var_1, var_0 );
        }
    }
}

_id_1722()
{
    self notify( "bot_twar_think" );
    self endon( "bot_twar_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    self _meth_8379( "beeline" );
    self _meth_8351( "force_sprint", 1 );

    for (;;)
    {
        if ( !_id_1720( level.twar_use_obj.zone ) )
            _id_171C( level.twar_use_obj.zone );

        wait 0.05;
    }
}

_id_171C( var_0 )
{
    self._id_2507 = var_0;
    var_1["entrance_points_index"] = _id_171E( var_0 );
    var_1["nearest_node_to_center"] = var_0.nearest_node;
    var_1["objective_radius"] = 500;
    maps\mp\bots\_bots_strategy::_id_15D1( var_0.origin, level.zone_radius, var_1 );
}

_id_1720( var_0 )
{
    if ( maps\mp\bots\_bots_util::_id_165A() )
    {
        if ( self._id_2507 == var_0 )
            return 1;
    }

    return 0;
}

_id_171D( var_0 )
{
    var_1 = 0;
    var_2 = _id_171E( level.twar_use_obj.zone );
    var_3 = _id_171F( self.team );
    var_1 = 0;

    foreach ( var_5 in var_3 )
    {
        if ( var_0 maps\mp\bots\_bots_util::_id_6123( var_2, _id_171E( var_5 ) ) )
        {
            var_1 = 1;
            break;
        }
    }

    if ( var_1 )
    {
        var_7 = _id_171F( common_scripts\utility::get_enemy_team( self.team ) );

        foreach ( var_9 in var_7 )
        {
            if ( var_0 maps\mp\bots\_bots_util::_id_6123( var_2, _id_171E( var_9 ) ) )
            {
                var_1 = 0;
                break;
            }
        }
    }

    if ( var_1 )
        return 0.2;

    return 1.0;
}

_id_171F( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.twar_zones )
    {
        if ( var_3.owner == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_171E( var_0 )
{
    return "zone" + var_0.script_label;
}

_id_1721( var_0 )
{
    return 0;
}
