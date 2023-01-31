// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_ctf();
}

setup_callbacks()
{
    level.bot_funcs["crate_can_use"] = ::crate_can_use;
    level.bot_funcs["gametype_think"] = ::bot_ctf_think;
    level.bot_funcs["get_watch_node_chance"] = ::bot_ctf_get_node_chance;
}

setup_bot_ctf()
{
    level.bot_gametype_attacker_limit_for_team = ::ctf_bot_attacker_limit_for_team;
    level.bot_gametype_defender_limit_for_team = ::ctf_bot_defender_limit_for_team;
    level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
    level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;
    maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

    while ( !isdefined( level.teamflags ) )
        wait 0.05;

    level.teamflags["allies"].script_label = "allies";
    level.teamflags["axis"].script_label = "axis";
    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array( level.teamflags, "flag_" );
    var_0 = _func_202( level.teamflags["allies"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "allies" );

    var_0 = _func_202( level.teamflags["axis"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "axis" );

    level.capzones["allies"].nearest_node = level.teamflags["allies"].nearest_node;
    level.capzones["axis"].nearest_node = level.teamflags["axis"].nearest_node;
    thread bot_ctf_ai_director_update();
    level.bot_gametype_precaching_done = 1;
}

crate_can_use( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0.boxtype ) )
        return 0;

    if ( isdefined( self.carryflag ) )
        return 0;

    return level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome();
}

bot_ctf_think()
{
    self notify( "bot_ctf_think" );
    self endon( "bot_ctf_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level.bot_gametype_precaching_done ) )
        wait 0.05;

    self.next_time_hunt_carrier = 0;
    self.next_flag_hide_time = 0;
    self _meth_8351( "separation", 0 );
    self _meth_8351( "use_obj_path_style", 1 );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        if ( !isdefined( self.role ) )
            maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();

        var_2 = 0;

        if ( self.role == "attacker" )
        {
            if ( isdefined( self.carryflag ) )
                var_2 = 1;
            else if ( !isdefined( level.flag_carriers[self.team] ) )
                var_2 = distancesquared( self.origin, level.teamflags[level.otherteam[self.team]].curorigin ) < squared( get_flag_protect_radius() );
        }
        else if ( !level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome() )
            var_2 = !isdefined( level.flag_carriers[level.otherteam[self.team]] );

        self _meth_8351( "force_sprint", var_2 );
        var_1 = 0;

        if ( isdefined( self.carryflag ) )
        {
            clear_defend();

            if ( !isdefined( level.flag_carriers[level.otherteam[self.team]] ) )
            {
                var_1 = 1;

                if ( !var_0 )
                {
                    var_0 = 1;
                    self _meth_8379( "scripted" );
                }

                self _meth_8354( level.capzones[self.team].curorigin, 16, "critical" );
            }
            else if ( gettime() > self.next_flag_hide_time )
            {
                var_3 = getnodesinradius( level.capzones[self.team].curorigin, 900, 0, 300 );
                var_4 = self _meth_8364( var_3, var_3.size * 0.15, "node_hide_anywhere" );

                if ( !isdefined( var_4 ) )
                    var_4 = level.capzones[self.team].nearest_node;

                var_5 = self _meth_8355( var_4, "critical" );

                if ( var_5 )
                    self.next_flag_hide_time = gettime() + 15000;
            }
        }
        else if ( self.role == "attacker" )
        {
            if ( isdefined( level.flag_carriers[self.team] ) )
            {
                if ( !maps\mp\bots\_bots_util::bot_is_bodyguarding() )
                {
                    clear_defend();
                    self _meth_8356();
                    maps\mp\bots\_bots_strategy::bot_guard_player( level.flag_carriers[self.team], 500 );
                }
            }
            else
            {
                clear_defend();

                if ( self _meth_835D() == "critical" )
                    self _meth_8356();

                self _meth_8354( level.teamflags[level.otherteam[self.team]].curorigin, 16, "objective", undefined, 300 );
            }
        }
        else if ( !level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome() )
        {
            if ( !isdefined( level.flag_carriers[level.otherteam[self.team]] ) )
            {
                clear_defend();
                self _meth_8354( level.teamflags[self.team].curorigin, 16, "critical" );
            }
            else
            {
                var_6 = level.flag_carriers[level.otherteam[self.team]];

                if ( gettime() > self.next_time_hunt_carrier || self _meth_836F( var_6 ) )
                {
                    clear_defend();
                    self _meth_8354( var_6.origin, 16, "critical" );
                    self.next_time_hunt_carrier = gettime() + randomintrange( 4500, 5500 );
                }
            }
        }
        else if ( !is_protecting_flag() )
        {
            self _meth_8356();
            var_7["score_flags"] = "strict_los";
            var_7["entrance_points_index"] = "flag_" + level.teamflags[self.team].script_label;
            var_7["nearest_node_to_center"] = level.teamflags[self.team].nearest_node;
            maps\mp\bots\_bots_strategy::bot_protect_point( level.teamflags[self.team].curorigin, get_flag_protect_radius(), var_7 );
        }

        if ( var_0 && !var_1 )
        {
            var_0 = 0;
            self _meth_8379( undefined );
        }
    }
}

clear_defend()
{
    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();
}

is_protecting_flag()
{
    return maps\mp\bots\_bots_util::bot_is_protecting();
}

get_flag_protect_radius()
{
    if ( isalive( self ) && !isdefined( level.protect_radius ) )
    {
        var_0 = self _meth_835F();
        var_1 = ( var_0[0] + var_0[1] ) / 2;
        level.protect_radius = min( 800, var_1 / 5.5 );
    }

    if ( !isdefined( level.protect_radius ) )
        return 900;

    return level.protect_radius;
}

ctf_bot_attacker_limit_for_team( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team( var_0 );
    var_2 = var_1 * 0.67;
    var_3 = floor( var_2 );
    var_4 = ceil( var_2 );
    var_5 = var_2 - var_3;
    var_6 = var_4 - var_2;

    if ( var_5 < var_6 )
        var_7 = int( var_3 );
    else
        var_7 = int( var_4 );

    var_8 = game["teamScores"][var_0];
    var_9 = game["teamScores"][common_scripts\utility::get_enemy_team( var_0 )];

    if ( var_8 + 1 < var_9 )
        var_7 = int( min( var_7 + 1, var_1 ) );

    return var_7;
}

ctf_bot_defender_limit_for_team( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team( var_0 );
    return var_1 - ctf_bot_attacker_limit_for_team( var_0 );
}

get_allied_attackers_for_team( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team( var_0, level.capzones[var_0].curorigin, get_flag_protect_radius() );
}

get_allied_defenders_for_team( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team( var_0, level.capzones[var_0].curorigin, get_flag_protect_radius() );
}

bot_ctf_ai_director_update()
{
    level notify( "bot_ctf_ai_director_update" );
    level endon( "bot_ctf_ai_director_update" );
    level endon( "game_ended" );
    level.flag_carriers = [];
    thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();

    for (;;)
    {
        level.flag_carriers["allies"] = undefined;
        level.flag_carriers["axis"] = undefined;

        foreach ( var_1 in level.participants )
        {
            if ( isalive( var_1 ) && isdefined( var_1.carryflag ) )
                level.flag_carriers[var_1.team] = var_1;
        }

        wait 0.05;
    }
}

bot_ctf_get_node_chance( var_0 )
{
    if ( var_0 == self.node_closest_to_defend_center )
        return 1.0;

    if ( !is_protecting_flag() )
        return 1.0;

    var_1 = var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels( "flag_allies", "flag_axis" );

    if ( var_1 )
        return 1.0;

    return 0.2;
}
