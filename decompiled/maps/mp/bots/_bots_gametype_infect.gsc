// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_infect();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_infect_think;
    level.bot_funcs["should_pickup_weapons"] = ::bot_should_pickup_weapons_infect;
}

setup_bot_infect()
{
    level.bots_gametype_handles_class_choice = 1;
    level.bots_ignore_team_balance = 1;
    level.bots_gametype_handles_team_choice = 1;
    level.infected_knife_name = "exoknife_mp";
    thread bot_infect_ai_director_update();
}

bot_should_pickup_weapons_infect()
{
    if ( level.infect_chosefirstinfected && self.team == "axis" )
        return 0;

    return maps\mp\bots\_bots::bot_should_pickup_weapons();
}

bot_infect_think()
{
    self notify( "bot_infect_think" );
    self endon( "bot_infect_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    childthread bot_infect_retrieve_knife();

    for (;;)
    {
        if ( level.infect_chosefirstinfected )
        {
            if ( self.team == "axis" && self botgetpersonality() != "run_and_gun" )
                maps\mp\bots\_bots_util::bot_set_personality( "run_and_gun" );
        }

        if ( self.bot_team != self.team )
            self.bot_team = self.team;

        if ( self.team == "axis" )
        {
            var_0 = maps\mp\bots\_bots_strategy::bot_melee_tactical_insertion_check();

            if ( !isdefined( var_0 ) || var_0 )
                self botclearscriptgoal();
        }

        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

bot_infect_ai_director_update()
{
    level notify( "bot_infect_ai_director_update" );
    level endon( "bot_infect_ai_director_update" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = [];
        var_1 = [];

        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3.initial_spawn_time ) && var_3.health > 0 && isdefined( var_3.team ) && ( var_3.team == "allies" || var_3.team == "axis" ) )
                var_3.initial_spawn_time = gettime();

            if ( isdefined( var_3.initial_spawn_time ) && gettime() - var_3.initial_spawn_time > 5000 )
            {
                if ( !isdefined( var_3.team ) )
                    continue;

                if ( var_3.team == "axis" )
                {
                    var_0[var_0.size] = var_3;
                    continue;
                }

                if ( var_3.team == "allies" )
                    var_1[var_1.size] = var_3;
            }
        }

        if ( var_0.size > 0 && var_1.size > 0 )
        {
            var_5 = 1;

            foreach ( var_7 in var_1 )
            {
                if ( isbot( var_7 ) )
                    var_5 = 0;
            }

            if ( var_5 )
            {
                foreach ( var_3 in var_1 )
                {
                    if ( !isdefined( var_3.last_infected_hiding_time ) )
                    {
                        var_3.last_infected_hiding_time = gettime();
                        var_3.last_infected_hiding_loc = var_3.origin;
                        var_3.time_spent_hiding = 0;
                    }

                    if ( gettime() >= var_3.last_infected_hiding_time + 5000 )
                    {
                        var_3.last_infected_hiding_time = gettime();
                        var_10 = distancesquared( var_3.origin, var_3.last_infected_hiding_loc );
                        var_3.last_infected_hiding_loc = var_3.origin;

                        if ( var_10 < 90000 )
                        {
                            var_3.time_spent_hiding += 5000;

                            if ( var_3.time_spent_hiding >= 20000 )
                            {
                                var_11 = common_scripts\utility::get_array_of_closest( var_3.origin, var_0 );

                                foreach ( var_13 in var_11 )
                                {
                                    if ( isbot( var_13 ) )
                                    {
                                        var_14 = var_13 botgetscriptgoaltype();

                                        if ( var_14 != "tactical" && var_14 != "critical" )
                                        {
                                            var_13 thread hunt_human( var_3 );
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            var_3.time_spent_hiding = 0;
                            var_3.last_infected_hiding_loc = var_3.origin;
                        }
                    }
                }
            }
        }

        wait 1.0;
    }
}

hunt_human( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self botsetscriptgoal( var_0.origin, 0, "critical" );
    maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
    self botclearscriptgoal();
}

bot_infect_retrieve_knife()
{
    if ( self.team == "axis" )
    {
        self.can_melee_enemy_time = 0;
        self.melee_enemy = undefined;
        self.melee_enemy_node = undefined;
        self.melee_enemy_new_node_time = 0;
        self.melee_self_node = undefined;
        self.melee_self_new_node_time = 0;
        var_0 = self botgetdifficultysetting( "throwKnifeChance" );

        if ( var_0 < 0.25 )
            self botsetdifficultysetting( "throwKnifeChance", 0.25 );

        self botsetdifficultysetting( "allowGrenades", 1 );

        for (;;)
        {
            if ( self hasweapon( level.infected_knife_name ) )
            {
                if ( maps\mp\_utility::isgameparticipant( self.enemy ) )
                {
                    var_1 = gettime();

                    if ( !isdefined( self.melee_enemy ) || self.melee_enemy != self.enemy )
                    {
                        self.melee_enemy = self.enemy;
                        self.melee_enemy_node = self.enemy getnearestnode();
                        self.melee_enemy_new_node_time = var_1;
                    }
                    else
                    {
                        var_2 = squared( self botgetdifficultysetting( "meleeDist" ) );

                        if ( distancesquared( self.enemy.origin, self.origin ) <= var_2 )
                            self.can_melee_enemy_time = var_1;

                        var_3 = self.enemy getnearestnode();
                        var_4 = self getnearestnode();

                        if ( !isdefined( self.melee_enemy_node ) || self.melee_enemy_node != var_3 )
                        {
                            self.melee_enemy_new_node_time = var_1;
                            self.melee_enemy_node = var_3;
                        }

                        if ( !isdefined( self.melee_self_node ) || self.melee_self_node != var_4 )
                        {
                            self.melee_self_new_node_time = var_1;
                            self.melee_self_node = var_4;
                        }
                        else if ( distancesquared( self.origin, self.melee_self_node.origin ) > 9216 )
                            self.melee_self_at_same_node_time = var_1;

                        if ( self.can_melee_enemy_time + 3000 < var_1 )
                        {
                            if ( self.melee_self_new_node_time + 3000 < var_1 )
                            {
                                if ( self.melee_enemy_new_node_time + 3000 < var_1 )
                                {
                                    if ( bot_infect_angle_too_steep_for_knife_throw( self.origin, self.enemy.origin ) )
                                        maps\mp\bots\_bots_util::bot_queued_process( "find_node_can_see_ent", ::bot_infect_find_node_can_see_ent, self.enemy, self.melee_self_node );

                                    if ( !self getammocount( level.infected_knife_name ) )
                                        self setweaponammoclip( level.infected_knife_name, 1 );

                                    maps\mp\_utility::waitfortimeornotify( 30, "enemy" );
                                    self botclearscriptgoal();
                                }
                            }
                        }
                    }
                }
            }

            wait 0.25;
        }
    }
}

bot_infect_angle_too_steep_for_knife_throw( var_0, var_1 )
{
    if ( abs( var_0[2] - var_1[2] ) > 56.0 && distance2dsquared( var_0, var_1 ) < 2304 )
        return 1;

    return 0;
}

bot_infect_find_node_can_see_ent( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    var_2 = 0;

    if ( issubstr( var_1.type, "Begin" ) )
        var_2 = 1;

    var_3 = getlinkednodes( var_1 );

    if ( isdefined( var_3 ) && var_3.size )
    {
        var_4 = common_scripts\utility::array_randomize( var_3 );

        foreach ( var_6 in var_4 )
        {
            if ( var_2 && issubstr( var_6.type, "End" ) )
                continue;

            if ( bot_infect_angle_too_steep_for_knife_throw( var_6.origin, var_0.origin ) )
                continue;

            var_7 = self geteye() - self.origin;
            var_8 = var_6.origin + var_7;
            var_9 = var_0.origin;

            if ( isplayer( var_0 ) )
                var_9 = var_0 maps\mp\_utility::getstancecenter();

            if ( sighttracepassed( var_8, var_9, 0, self, var_0 ) )
            {
                var_10 = vectortoyaw( var_9 - var_8 );
                self botsetscriptgoalnode( var_6, "critical", var_10 );
                maps\mp\bots\_bots_util::bot_waittill_goal_or_fail( 3.0 );
                return;
            }

            wait 0.05;
        }
    }
}
