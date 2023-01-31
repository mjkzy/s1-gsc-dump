// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_ball();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_ball_think;
    level.bot_funcs["crate_can_use"] = ::crate_can_use;
}

setup_bot_ball()
{
    level.bot_gametype_attacker_limit_for_team = ::bot_ball_attacker_limit_for_team;
    level.bot_gametype_defender_limit_for_team = ::bot_ball_defender_limit_for_team;
    level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
    level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;
    maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

    while ( !isdefined( level.ball_goals ) )
        wait 0.05;

    level.ball_goals["allies"].script_label = "allies";
    level.ball_goals["axis"].script_label = "axis";
    bot_setup_ball_jump_nodes();
    var_0 = _func_202( level.ball_goals["allies"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "allies" );

    var_0 = _func_202( level.ball_goals["axis"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "axis" );

    foreach ( var_2 in level.balls )
        var_2 thread monitor_ball();

    var_4 = 0;
    thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
    level.bot_gametype_precaching_done = 1;
}

monitor_ball()
{
    var_0 = self.visuals[0].origin;
    self.nearest_node = getclosestnodeinsight( var_0 );

    for (;;)
    {
        var_1 = self.visuals[0].origin;
        self.ball_at_rest = maps\mp\bots\_bots_util::bot_vectors_are_equal( var_0, var_1 );

        if ( !self.ball_at_rest )
        {
            var_2 = getclosestnodeinsight( var_1 );

            if ( !isdefined( var_2 ) )
            {
                var_3 = getnodesinradiussorted( var_1, 512, 0, 6000 );

                if ( var_3.size > 0 )
                    var_2 = var_3[0];
            }

            if ( isdefined( var_2 ) )
                self.nearest_node = var_2;
        }

        var_0 = var_1;
        wait 0.2;
    }
}

bot_setup_ball_jump_nodes()
{
    wait 1.0;
    var_0 = 0;
    var_1 = 10;

    foreach ( var_3 in level.ball_goals )
    {
        var_3.ball_jump_nodes = [];
        var_4 = 375;

        if ( isdefined( level.ballgoalradius ) )
            var_4 = level.ballgoalradius;

        var_5 = getnodesinradius( var_3.origin, var_4, 0 );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.type == "End" )
                continue;

            if ( isdefined( level.ballpreventgoaljumpfromtraversals ) && level.ballpreventgoaljumpfromtraversals && var_7.type == "Begin" )
                continue;

            var_0++;

            if ( bot_ball_origin_can_see_goal( var_7.origin, var_3, 1 ) )
                var_3.ball_jump_nodes[var_3.ball_jump_nodes.size] = var_7;

            if ( var_0 % var_1 == 0 )
                wait 0.05;
        }

        var_9 = 999999999;

        foreach ( var_7 in var_3.ball_jump_nodes )
        {
            var_11 = _func_220( var_7.origin, var_3.origin );

            if ( var_11 < var_9 )
            {
                var_3.nearest_node = var_7;
                var_9 = var_11;
            }
        }

        wait 0.05;
    }
}

bot_ball_origin_can_see_goal( var_0, var_1, var_2 )
{
    var_3 = bot_ball_trace_to_origin( var_0, var_1.origin );

    if ( isdefined( var_2 ) && var_2 )
    {
        if ( !var_3 )
        {
            var_4 = var_1.origin - ( 0, 0, var_1.radius * 0.5 );
            var_3 = bot_ball_trace_to_origin( var_0, var_4 );
        }

        if ( !var_3 )
        {
            var_4 = var_1.origin + ( 0, 0, var_1.radius * 0.5 );
            var_3 = bot_ball_trace_to_origin( var_0, var_4 );
        }
    }

    return var_3;
}

bot_ball_trace_to_origin( var_0, var_1 )
{
    if ( isdefined( self ) && ( isplayer( self ) || isagent( self ) ) )
        var_2 = playerphysicstrace( var_0, var_1, self );
    else
        var_2 = playerphysicstrace( var_0, var_1 );

    return distancesquared( var_2, var_1 ) < 1;
}

crate_can_use( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0.boxtype ) )
        return 0;

    if ( has_ball() )
        return 0;

    return 1;
}

bot_ball_think()
{
    self notify( "bot_ball_think" );
    self endon( "bot_ball_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    while ( !isdefined( level.bot_gametype_precaching_done ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    var_0 = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    var_1 = 0;
    self.last_pass_throw_check = 0;
    self.ball_can_pass_ally = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    self.ball_can_pass_enemy = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    self.ball_can_throw = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    var_2 = level.ball_goals[self.team];
    var_3 = level.ball_goals[common_scripts\utility::get_enemy_team( self.team )];
    childthread watch_ball_pickup_and_loss();

    for (;;)
    {
        if ( self.health <= 0 )
            continue;

        var_4 = !isdefined( self.role );

        if ( var_4 )
            maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();

        self _meth_8351( "force_sprint", 0 );
        var_5 = bot_ball_get_balls_carried_by_team( self.team );
        var_6 = bot_ball_get_balls_carried_by_team( common_scripts\utility::get_enemy_team( self.team ) );

        foreach ( var_8 in var_6 )
        {
            var_9 = var_8 bot_ball_get_origin() - ( 0, 0, 75 );
            self _meth_8377( var_8.carrier, var_9 );
        }

        if ( has_ball() )
        {
            self _meth_8351( "force_sprint", 1 );
            var_11 = distancesquared( self.origin, var_3.nearest_node.origin );

            if ( var_11 > 360000 )
            {
                var_12 = var_3.nearest_node;
                var_13 = 600;
            }
            else
            {
                var_12 = common_scripts\utility::get_array_of_closest( self.origin, var_3.ball_jump_nodes )[0];
                var_13 = 16;
            }

            clear_defend_or_goal_if_necessary();
            self _meth_8354( var_12.origin, var_13, "critical" );
            var_14 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( undefined, "bot_no_longer_has_ball" );

            if ( var_14 == "goal" && distancesquared( self.origin, var_12.origin ) <= 256 )
            {
                self _meth_8356();
                var_15 = vectornormalize( var_3.origin - self _meth_80A8() );

                if ( vectordot( var_15, ( 0, 0, 1 ) ) < 0.93 )
                    self _meth_836D( var_3.origin, 5.0, "script_forced" );

                var_16 = 0;
                var_17 = 0;
                var_18 = self.origin[2];

                while ( var_16 < 4.0 && has_ball() )
                {
                    self _meth_8353( vectortoyaw( var_3.origin - self.origin ), 0.05 );

                    if ( var_16 == 0.3 || var_16 == 0.75 )
                        self _meth_837E( "jump" );

                    var_19 = var_16 > 1.25 && self.origin[2] < var_18;
                    var_18 = self.origin[2];

                    if ( !var_17 )
                    {
                        var_20 = abs( self.origin[2] - var_3.origin[2] );
                        var_21 = distance2d( self.origin, var_3.origin );

                        if ( var_20 < 10 || var_19 && var_21 > 200 )
                        {
                            self _meth_837E( "sprint" );
                            var_17 = 1;
                        }
                    }

                    wait 0.05;
                    var_16 += 0.05;

                    if ( !has_ball() || var_16 > 0.75 && self _meth_8341() )
                        var_16 = 5.0;
                }

                self _meth_836D( undefined );
            }

            self _meth_8356();
        }
        else if ( self.role == "attacker" )
        {
            var_22 = bot_ball_get_free_balls();

            if ( var_22.size <= 0 )
            {
                if ( var_6.size > 0 )
                {
                    var_23 = bot_ball_get_closest_ball( var_6 );
                    var_24 = var_23 bot_ball_get_origin() - ( 0, 0, 75 );

                    if ( var_0 )
                    {
                        if ( gettime() > var_1 )
                        {
                            var_1 = gettime() + 5000;
                            var_25 = undefined;
                            var_26 = _func_200( var_24, var_2.nearest_node.origin );

                            if ( isdefined( var_26 ) && var_26.size > 0 )
                                var_25 = var_26[int( var_26.size * randomfloatrange( 0.25, 0.75 ) )].origin;

                            clear_defend_or_goal_if_necessary();

                            if ( isdefined( var_25 ) && maps\mp\bots\_bots_personality::find_ambush_node( var_25, 512 ) )
                                self _meth_8355( self.node_ambushing_from, "guard", self.ambush_yaw );
                            else
                                self _meth_8354( var_24, 16, "guard" );
                        }
                    }
                    else
                    {
                        clear_defend_or_goal_if_necessary();
                        self _meth_8354( var_24, 16, "guard" );
                    }
                }
                else if ( var_5.size > 0 )
                {
                    if ( !maps\mp\bots\_bots_util::bot_is_bodyguarding() )
                    {
                        var_27 = bot_ball_get_closest_ball( var_5 );
                        clear_defend_or_goal_if_necessary();
                        maps\mp\bots\_bots_strategy::bot_guard_player( var_27.carrier, 500 );
                    }
                }
                else if ( maps\mp\_utility::isjuggernaut() )
                    maps\mp\bots\_bots_personality::update_personality_default();
                else
                {
                    var_28 = common_scripts\utility::get_array_of_closest( self.origin, level.ball_starts );
                    clear_defend_or_goal_if_necessary();
                    self _meth_8354( var_28[0].origin, 16, "guard" );
                }
            }
            else if ( maps\mp\_utility::isjuggernaut() )
                maps\mp\bots\_bots_personality::update_personality_default();
            else
            {
                var_29 = bot_ball_get_closest_ball( var_22 );
                clear_defend_or_goal_if_necessary( "objective" );

                if ( var_29.ball_at_rest )
                {
                    var_30 = var_29 bot_ball_get_origin();

                    if ( !self _meth_8365() || !maps\mp\bots\_bots_util::bot_vectors_are_equal( var_30, self _meth_835A() ) )
                        self _meth_8354( var_30, 16, "objective", undefined, 180 );
                }
                else
                    self _meth_8354( var_29.nearest_node.origin, 16, "objective", undefined, 180 );
            }
        }
        else
        {
            var_31 = undefined;
            var_22 = bot_ball_get_free_balls();

            foreach ( var_8 in var_22 )
            {
                var_33 = _func_220( var_8 bot_ball_get_origin(), var_2.origin );

                if ( var_33 < squared( get_ball_goal_protect_radius() ) )
                {
                    var_31 = var_8;
                    break;
                }
            }

            if ( isdefined( var_31 ) && !maps\mp\_utility::isjuggernaut() )
            {
                clear_defend_or_goal_if_necessary();

                if ( var_31.ball_at_rest )
                    self _meth_8354( var_31 bot_ball_get_origin(), 16, "guard" );
                else
                    self _meth_8354( var_31.nearest_node.origin, 16, "guard" );

                maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( 1.0 );
            }
            else if ( !maps\mp\bots\_bots_util::bot_is_protecting() )
            {
                self _meth_8356();
                var_35["score_flags"] = "strict_los";
                var_35["override_origin_node"] = var_2.nearest_node;
                maps\mp\bots\_bots_strategy::bot_protect_point( var_2.nearest_node.origin, get_ball_goal_protect_radius(), var_35 );
            }
        }

        wait 0.05;
    }
}

watch_ball_pickup_and_loss()
{
    var_0 = 0;

    for (;;)
    {
        if ( has_ball() && !var_0 )
        {
            childthread monitor_pass_throw();
            var_0 = 1;
            self _meth_8351( "melee_critical_path", 1 );
        }
        else if ( !has_ball() && var_0 )
        {
            self notify( "bot_no_longer_has_ball" );
            var_0 = 0;
            self _meth_8351( "melee_critical_path", 0 );
        }

        wait 0.05;
    }
}

monitor_pass_throw()
{
    self endon( "bot_no_longer_has_ball" );
    var_0 = level.ball_goals[self.team];
    var_1 = level.ball_goals[common_scripts\utility::get_enemy_team( self.team )];

    for (;;)
    {
        if ( self.ball_can_pass_ally )
        {
            if ( isdefined( self.pass_target ) )
            {
                var_2 = 1;

                if ( var_2 )
                {
                    var_3 = distancesquared( self.origin, var_1.origin );
                    var_4 = distancesquared( self.pass_target.origin, var_1.origin );

                    if ( var_4 <= var_3 )
                    {
                        var_5 = anglestoforward( self getangles() );
                        var_6 = vectornormalize( self.pass_target.origin - self.origin );
                        var_7 = vectordot( var_5, var_6 );

                        if ( var_7 > 0.7 )
                        {
                            self _meth_836D( self.pass_target.origin + ( 0, 0, 40 ), 1.25, "script_forced" );
                            wait 0.25;
                            self _meth_837E( "throw" );
                            wait 1.0;
                        }
                    }
                }
            }
        }

        if ( self.ball_can_pass_enemy )
        {
            if ( isdefined( self.enemy ) && isalive( self.enemy ) && self _meth_836F( self.enemy ) )
            {
                var_8 = 1;

                if ( var_8 )
                {
                    var_9 = distancesquared( self.origin, var_0.origin );
                    var_10 = var_9 < squared( get_ball_goal_protect_radius() );

                    if ( !var_10 && distancesquared( self.origin, self.enemy.origin ) < squared( 350 ) )
                    {
                        var_11 = anglestoforward( self.enemy getangles() );
                        var_12 = vectornormalize( self.origin - self.enemy.origin );
                        var_7 = vectordot( var_11, var_12 );

                        if ( var_7 > 0.5 )
                        {
                            var_5 = anglestoforward( self getangles() );
                            var_13 = -1 * var_12;
                            var_7 = vectordot( var_5, var_13 );

                            if ( var_7 > 0.77 )
                            {
                                self _meth_836D( self.enemy.origin + ( 0, 0, 40 ), 1.25, "script_forced" );
                                wait 0.25;
                                self _meth_837E( "attack" );
                                wait 1.0;
                            }
                        }
                    }
                }
            }
        }

        if ( self.ball_can_throw )
        {
            if ( self.health < 100 && bot_ball_origin_can_see_goal( self.origin, var_1 ) )
            {
                self _meth_836D( var_1.origin, 1.25, "script_forced" );
                wait 0.25;
                self _meth_837E( "attack" );
                wait 1.0;
            }
            else if ( self.role == "defender" )
            {
                var_9 = distancesquared( self.origin, var_0.origin );

                if ( var_9 < squared( get_ball_goal_protect_radius() ) )
                {
                    var_14 = anglestoforward( self getangles() * ( 0, 1, 1 ) + ( -30, 0, 0 ) );
                    self _meth_836D( self _meth_80A8() + var_14 * 200, 1.25, "script_forced" );
                    wait 0.25;
                    self _meth_837E( "attack" );
                    wait 1.0;
                }
            }
        }

        wait 0.05;
    }
}

ball_carrier_is_almost_visible( var_0 )
{
    var_1 = self _meth_8387();
    var_2 = var_0 _meth_8387();

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        if ( _func_1FF( var_1, var_2, 1 ) )
            return var_2;

        var_3 = getlinkednodes( var_2 );

        foreach ( var_5 in var_3 )
        {
            if ( _func_1FF( var_1, var_5, 1 ) )
                return var_5;
        }
    }

    return undefined;
}

bot_ball_is_resetting()
{
    return self.compassicons["friendly"] == "waypoint_ball_download" || self.compassicons["friendly"] == "waypoint_ball_upload";
}

bot_ball_get_closest_ball( var_0 )
{
    if ( var_0.size == 1 )
        return var_0[0];

    var_1 = 99999999;
    var_2 = undefined;

    foreach ( var_4 in var_0 )
    {
        var_5 = distancesquared( self.origin, var_4 bot_ball_get_origin() );

        if ( var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2;
}

bot_ball_get_origin()
{
    if ( isdefined( self.carrier ) )
        return self.curorigin;
    else
        return self.visuals[0].origin;
}

clear_defend_or_goal_if_necessary( var_0 )
{
    if ( maps\mp\bots\_bots_util::bot_is_defending() )
        maps\mp\bots\_bots_strategy::bot_defend_stop();

    if ( self _meth_835D() == "objective" )
    {
        var_1 = isdefined( var_0 ) && var_0 == "objective";

        if ( !var_1 )
            self _meth_8356();
    }
}

has_ball()
{
    return isdefined( self.ball_carried );
}

bot_ball_get_free_balls()
{
    var_0 = [];

    foreach ( var_2 in level.balls )
    {
        if ( var_2 bot_ball_is_resetting() )
            continue;

        if ( !isdefined( var_2.carrier ) )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

bot_ball_get_balls_carried_by_team( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.balls )
    {
        if ( var_3 bot_ball_is_resetting() )
            continue;

        if ( isdefined( var_3.carrier ) && var_3.carrier.team == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

bot_ball_attacker_limit_for_team( var_0 )
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

    return var_7;
}

bot_ball_defender_limit_for_team( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team( var_0 );
    return var_1 - bot_ball_attacker_limit_for_team( var_0 );
}

get_ball_goal_protect_radius()
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

get_allied_attackers_for_team( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team( var_0, level.ball_goals[var_0].origin, get_ball_goal_protect_radius() );
}

get_allied_defenders_for_team( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team( var_0, level.ball_goals[var_0].origin, get_ball_goal_protect_radius() );
}
