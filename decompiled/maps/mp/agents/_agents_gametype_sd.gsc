// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
}

setup_callbacks()
{
    level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

agent_player_sd_think()
{
    common_scripts\utility::_enableusability();

    foreach ( var_1 in level.bombzones )
        var_1.trigger enableplayeruse( self );

    thread maps\mp\bots\_bots_gametype_sd::bot_sd_think();
}
