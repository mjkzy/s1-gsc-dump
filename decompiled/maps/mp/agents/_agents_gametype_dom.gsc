// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
}

setup_callbacks()
{
    level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_dom_think;
    level.agent_funcs["player"]["think"] = ::agent_player_dom_think;
}

agent_player_dom_think()
{
    thread maps\mp\bots\_bots_gametype_dom::bot_dom_think();
}

agent_squadmember_dom_think()
{
    var_0 = undefined;

    foreach ( var_2 in self.owner.touchtriggers )
    {
        if ( var_2.useobj.id == "domFlag" )
            var_0 = var_2;
    }

    if ( isdefined( var_0 ) )
    {
        var_4 = var_0 maps\mp\gametypes\dom::getflagteam();

        if ( var_4 != self.team )
        {
            if ( !maps\mp\bots\_bots_gametype_dom::bot_is_capturing_flag( var_0 ) )
                maps\mp\bots\_bots_gametype_dom::capture_flag( var_0, "critical", 1 );

            return 1;
        }
    }

    return 0;
}
