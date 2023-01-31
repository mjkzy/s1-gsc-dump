// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.bot_ignore_precalc_paths = 0;

    if ( level.currentgen )
        level.bot_ignore_precalc_paths = 1;

    setup_callbacks();
    setup_bot_twar();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_twar_think;
    level.bot_funcs["should_start_cautious_approach"] = ::bot_twar_should_start_cautious_approach;

    if ( !level.bot_ignore_precalc_paths )
        level.bot_funcs["get_watch_node_chance"] = ::bot_twar_get_node_chance;
}

setup_bot_twar()
{
    maps\mp\bots\_bots_util::bot_waittill_bots_enabled( 1 );

    for ( var_0 = 0; var_0 < level.twar_zones.size; var_0++ )
        level.twar_zones[var_0].script_label = "_" + var_0;

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array( level.twar_zones, "zone", level.bot_ignore_precalc_paths );
    var_1 = 55;
    var_2 = 0;

    foreach ( var_4 in level.twar_zones )
    {
        if ( !isdefined( var_4.nearest_node ) )
            return;

        var_4 thread monitor_zone_control();
        var_5 = ( var_4.origin - ( 0, 0, var_1 ) + ( var_4.origin + ( 0, 0, level.zone_height ) ) ) / 2.0;
        var_6 = ( level.zone_height + var_1 ) / 2.0;
        var_4.nodes = getnodesinradius( var_5, level.zone_radius, 0, var_6 );

        if ( var_4.nodes.size < 6 )
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

    level.bot_gametype_precaching_done = 1;
}

monitor_zone_control()
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

bot_twar_think()
{
    self notify( "bot_twar_think" );
    self endon( "bot_twar_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    while ( !isdefined( level.bot_gametype_precaching_done ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    self _meth_8379( "beeline" );
    self _meth_8351( "force_sprint", 1 );

    for (;;)
    {
        if ( !bot_twar_is_capturing_zone( level.twar_use_obj.zone ) )
            bot_twar_capture_zone( level.twar_use_obj.zone );

        wait 0.05;
    }
}

bot_twar_capture_zone( var_0 )
{
    self.current_zone = var_0;
    var_1["entrance_points_index"] = bot_twar_get_zone_label( var_0 );
    var_1["nearest_node_to_center"] = var_0.nearest_node;
    var_1["objective_radius"] = 500;
    maps\mp\bots\_bots_strategy::bot_capture_point( var_0.origin, level.zone_radius, var_1 );
}

bot_twar_is_capturing_zone( var_0 )
{
    if ( maps\mp\bots\_bots_util::bot_is_capturing() )
    {
        if ( self.current_zone == var_0 )
            return 1;
    }

    return 0;
}

bot_twar_get_node_chance( var_0 )
{
    var_1 = 0;
    var_2 = bot_twar_get_zone_label( level.twar_use_obj.zone );
    var_3 = bot_twar_get_zones_for_team( self.team );
    var_1 = 0;

    foreach ( var_5 in var_3 )
    {
        if ( var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels( var_2, bot_twar_get_zone_label( var_5 ) ) )
        {
            var_1 = 1;
            break;
        }
    }

    if ( var_1 )
    {
        var_7 = bot_twar_get_zones_for_team( common_scripts\utility::get_enemy_team( self.team ) );

        foreach ( var_9 in var_7 )
        {
            if ( var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels( var_2, bot_twar_get_zone_label( var_9 ) ) )
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

bot_twar_get_zones_for_team( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.twar_zones )
    {
        if ( var_3.owner == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

bot_twar_get_zone_label( var_0 )
{
    return "zone" + var_0.script_label;
}

bot_twar_should_start_cautious_approach( var_0 )
{
    return 0;
}
