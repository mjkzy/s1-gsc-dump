// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    setup_bot_zombies();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::bot_zombies_think;
}

setup_bot_zombies()
{
    level._id_1747 = 1;
    level._id_1748 = 1;
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
            maps\mp\bots\_bots_util::_id_16ED( "run_and_gun" );

        if ( !isdefined( self._id_15EE ) )
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
                thread maps\mp\bots\_bots_strategy::_id_1646( var_1, 800 );
                var_1.guardcount++;
            }
        }

        self [[ self._id_67DE ]]();
        wait 0.05;
    }
}
