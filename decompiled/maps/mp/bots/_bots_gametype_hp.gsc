// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_hp();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_hp_think;
    level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_hp;
}

setup_bot_hp()
{
    maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

    for ( var_0 = 0; var_0 < level.all_hp_zones.size; var_0++ )
    {
        var_1 = level.all_hp_zones[var_0];
        var_1.script_label = "zone_" + var_0;
        var_1 thread monitor_zone_control();
        var_2 = 0;

        if ( isdefined( var_1.trig.trigger_off ) && var_1.trig.trigger_off )
        {
            var_1.trig common_scripts\utility::trigger_on();
            var_2 = 1;
        }

        var_1.nodes = getnodesintrigger( var_1.trig );
        maps\mp\bots\_bots_gametype_common::bot_add_missing_nodes( var_1, var_1.trig );

        if ( var_2 )
            var_1.trig common_scripts\utility::trigger_off();
    }

    bot_cache_entrances_to_hardpoints( 1 );
    level.bot_hp_allow_predictive_capping = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_hardpoints( 0 );
}

bot_cache_entrances_to_hardpoints( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = 0;

    foreach ( var_5 in level.all_hp_zones )
    {
        if ( var_0 && var_5 != level.zone || !var_0 && var_5 == level.zone )
            continue;

        var_6 = 0;
        var_5.entrance_indices = [];
        var_5.zone_bounds = calculate_zone_node_extents( var_5 );
        var_5.center_node = zone_get_node_nearest_2d_bounds( var_5, 0, 0 );
        var_7 = [ ( 0, 0, 0 ), ( 1, 1, 0 ), ( 1, -1, 0 ), ( -1, 1, 0 ), ( -1, -1, 0 ) ];

        foreach ( var_9 in var_7 )
        {
            var_10 = zone_get_node_nearest_2d_bounds( var_5, var_9[0], var_9[1] );
            var_1[var_3] = var_10.origin;
            var_11 = var_5.script_label + "_" + var_6;
            var_2[var_3] = var_11;
            var_5.entrance_indices[var_5.entrance_indices.size] = var_11;
            var_3++;
            var_6++;
        }
    }

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances( var_1, var_2, 1 );
}

calculate_zone_node_extents( var_0 )
{
    var_1 = spawnstruct();
    var_1.min_pt = ( 999999, 999999, 999999 );
    var_1.max_pt = ( -999999, -999999, -999999 );

    foreach ( var_3 in var_0.nodes )
    {
        var_1.min_pt = ( min( var_3.origin[0], var_1.min_pt[0] ), min( var_3.origin[1], var_1.min_pt[1] ), min( var_3.origin[2], var_1.min_pt[2] ) );
        var_1.max_pt = ( max( var_3.origin[0], var_1.max_pt[0] ), max( var_3.origin[1], var_1.max_pt[1] ), max( var_3.origin[2], var_1.max_pt[2] ) );
    }

    var_1.center = ( ( var_1.min_pt[0] + var_1.max_pt[0] ) / 2, ( var_1.min_pt[1] + var_1.max_pt[1] ) / 2, ( var_1.min_pt[2] + var_1.max_pt[2] ) / 2 );
    var_1.half_size = ( var_1.max_pt[0] - var_1.center[0], var_1.max_pt[1] - var_1.center[1], var_1.max_pt[2] - var_1.center[2] );
    var_1.radius = max( var_1.half_size[0], var_1.half_size[1] );
    return var_1;
}

zone_get_node_nearest_2d_bounds( var_0, var_1, var_2 )
{
    var_3 = ( var_0.zone_bounds.center[0] + var_1 * var_0.zone_bounds.half_size[0], var_0.zone_bounds.center[1] + var_2 * var_0.zone_bounds.half_size[1], 0 );
    var_4 = undefined;
    var_5 = 9999999;

    foreach ( var_7 in var_0.nodes )
    {
        var_8 = distance2dsquared( var_7.origin, var_3 );

        if ( var_8 < var_5 )
        {
            var_5 = var_8;
            var_4 = var_7;
        }
    }

    return var_4;
}

monitor_zone_control()
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
            var_1 = getzonenearest( self.origin );

            if ( isdefined( var_1 ) )
                botzonesetteam( var_1, var_0 );
        }

        wait 1.0;
    }
}

bot_hp_think()
{
    self notify( "bot_hp_think" );
    self endon( "bot_hp_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level.bot_gametype_precaching_done ) )
        wait 0.05;

    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
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

        if ( !isdefined( var_0 ) && level.randomzonespawn == 0 && level.bot_hp_allow_predictive_capping )
        {
            var_2 = level.zonemovetime - gettime();

            if ( var_2 > 0 && var_2 < 10000 )
            {
                var_3 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam() == self.team;

                if ( !var_3 )
                {
                    var_4 = level.zone.zone_bounds.radius * 6;

                    if ( var_2 < 5000 )
                        var_4 = level.zone.zone_bounds.radius * 3;

                    var_5 = distance( level.zone.zone_bounds.center, self.origin );

                    if ( var_5 > var_4 )
                        var_0 = bot_should_cap_next_zone();
                }
                else
                {
                    var_6 = maps\mp\bots\_bots_util::bot_get_max_players_on_team( self.team );
                    var_7 = ceil( var_6 / 2 );

                    if ( var_2 < 5000 )
                        var_7 = ceil( var_6 / 3 );

                    var_8 = bot_get_num_teammates_capturing_zone( level.zone );

                    if ( var_8 + 1 > var_7 )
                        var_0 = bot_should_cap_next_zone();
                }
            }
        }

        var_9 = level.zone;

        if ( isdefined( var_0 ) && var_0 )
            var_9 = level.zones[( level.prevzoneindex + 1 ) % level.zones.size];

        if ( !bot_is_capturing_zone( var_9 ) )
            bot_capture_hp_zone( var_9 );
    }
}

bot_should_cap_next_zone()
{
    if ( level.randomzonespawn )
        return 0;
    else
    {
        var_0 = self botgetdifficultysetting( "strategyLevel" );
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

bot_get_num_teammates_capturing_zone( var_0 )
{
    return bot_get_teammates_capturing_zone( var_0 ).size;
}

bot_get_teammates_capturing_zone( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.participants )
    {
        if ( var_3 != self && maps\mp\_utility::isteamparticipant( var_3 ) && isalliedsentient( self, var_3 ) )
        {
            if ( var_3 istouching( level.zone.trig ) )
            {
                if ( !isai( var_3 ) || var_3 bot_is_capturing_zone( var_0 ) )
                    var_1[var_1.size] = var_3;
            }
        }
    }

    return var_1;
}

bot_is_capturing_zone( var_0 )
{
    if ( !maps\mp\bots\_bots_util::bot_is_capturing() )
        return 0;

    return self.current_zone == var_0;
}

bot_capture_hp_zone( var_0 )
{
    self.current_zone = var_0;
    var_1["entrance_points_index"] = var_0.entrance_indices;
    var_1["override_origin_node"] = var_0.center_node;
    maps\mp\bots\_bots_strategy::bot_capture_zone( var_0.origin, var_0.nodes, var_0.trig, var_1 );
}

should_start_cautious_approach_hp( var_0 )
{
    if ( var_0 )
    {
        var_1 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

        if ( var_1 == "neutral" || var_1 == self.team )
            return 0;
    }

    return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default( var_0 );
}
