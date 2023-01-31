// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_zombies();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_zombies_think;
}

setup_bot_zombies()
{
    level.bots_gametype_handles_team_choice = 1;
    level.bots_ignore_team_balance = 1;
}

bot_zombies_think()
{
    self notify( "bot_zombies_think" );
    self endon( "bot_zombies_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( self _meth_8366() != "run_and_gun" )
            maps\mp\bots\_bots_util::bot_set_personality( "run_and_gun" );

        if ( !isdefined( self.bot_defend_player_guarding ) )
        {
            var_0 = 9999;
            var_1 = undefined;

            foreach ( var_3 in level.players )
            {
                if ( isbot( var_3 ) )
                    continue;

                if ( !isdefined( var_3.guardcount ) )
                    var_3.guardcount = 0;

                if ( var_3.guardcount < var_0 )
                {
                    var_0 = var_3.guardcount;
                    var_1 = var_3;
                }
            }

            if ( isdefined( var_1 ) )
            {
                thread maps\mp\bots\_bots_strategy::bot_guard_player( var_1, 800 );
                var_1.guardcount++;
            }
        }

        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}
