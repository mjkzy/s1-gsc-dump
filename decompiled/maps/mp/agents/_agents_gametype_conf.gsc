// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
}

setup_callbacks()
{
    level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_conf_think;
    level.agent_funcs["player"]["think"] = ::agent_player_conf_think;
}

agent_player_conf_think()
{
    thread maps\mp\bots\_bots_gametype_conf::bot_conf_think();
}

agent_squadmember_conf_think()
{
    if ( !isdefined( self.tags_seen_by_owner ) )
        self.tags_seen_by_owner = [];

    if ( !isdefined( self.next_time_check_tags ) )
        self.next_time_check_tags = gettime() + 500;

    if ( gettime() > self.next_time_check_tags )
    {
        self.next_time_check_tags = gettime() + 500;
        var_0 = 0.78;
        var_1 = self.owner getnearestnode();

        if ( isdefined( var_1 ) )
        {
            var_2 = self.owner maps\mp\bots\_bots_gametype_conf::bot_find_visible_tags( 1, var_1, var_0 );
            self.tags_seen_by_owner = maps\mp\bots\_bots_gametype_conf::bot_combine_tag_seen_arrays( var_2, self.tags_seen_by_owner );
        }
    }

    self.tags_seen_by_owner = maps\mp\bots\_bots_gametype_conf::bot_remove_invalid_tags( self.tags_seen_by_owner );
    var_3 = maps\mp\bots\_bots_gametype_conf::bot_find_best_tag_from_array( self.tags_seen_by_owner, 0 );

    if ( isdefined( var_3 ) )
    {
        if ( !isdefined( self.tag_getting ) || distancesquared( var_3.curorigin, self.tag_getting.curorigin ) > 1 )
        {
            self.tag_getting = var_3;
            maps\mp\bots\_bots_strategy::bot_defend_stop();
            self botsetscriptgoal( self.tag_getting.curorigin, 0, "objective", undefined, level.bot_tag_obj_radius );
        }

        return 1;
    }
    else if ( isdefined( self.tag_getting ) )
    {
        self botclearscriptgoal();
        self.tag_getting = undefined;
    }

    return 0;
}
