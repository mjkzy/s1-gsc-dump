// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

watchmutebombusage()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level.adrenalinesettings ) )
        mutebombinit();

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );

        if ( var_1 == "mute_bomb_mp" )
        {
            if ( !isalive( self ) )
            {
                var_0 delete();
                return;
            }

            thread tryusemutebomb( var_0 );
        }
    }
}

mutebombinit()
{
    self.adrenalinesettings = spawnstruct();
}

tryusemutebomb( var_0 )
{
    if ( !isdefined( self.adrenalinesettings ) )
        mutebombinit();

    thread startmutebomb( var_0 );
    thread monitorplayerdeath( var_0 );
    var_0 thread monitormutebombdeath();
    return 1;
}

startmutebomb( var_0 )
{
    self endon( "ClearMuteBomb" );
    self endon( "death" );
    var_0 endon( "death" );
    var_0 playsound( "mute_device_activate" );
    wait 0.75;
    var_0 addsoundmutedevice( 350, 600, 0.25 );
    var_0 playloopsound( "mute_device_active_lp" );
    var_0 thread monitormutebombplayers();
    wait 20;
    var_0 scalevolume( 0.0, 0.25 );
    var_0 removesoundmutedevice( 0.25 );
    var_0 notify( "ShutdownMuteBomb" );
    wait 0.25;
    var_0 stoploopsound();
}

monitorplayerdeath( var_0 )
{
    var_0 endon( "ShutdownMuteBomb" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        var_0 removesoundmutedevice( 0.25 );
        var_0 notify( "ShutdownMuteBomb" );
    }
}

monitormutebombdeath()
{
    self endon( "ShutdownMuteBomb" );
    self waittill( "death" );

    if ( isdefined( self ) )
    {
        self removesoundmutedevice( 0.25 );
        self notify( "ShutdownMuteBomb" );
    }
}

monitormutebombplayers()
{
    self endon( "ShutdownMuteBomb" );
    var_0 = 475.0;
    self.touchingplayers = [];

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            var_3 = distance( self.origin, var_2.origin );
            var_4 = common_scripts\utility::array_contains( self.touchingplayers, var_2 );

            if ( var_3 <= var_0 )
            {
                if ( !var_4 )
                {
                    self.touchingplayers = common_scripts\utility::array_add( self.touchingplayers, var_2 );
                    var_2 playlocalsound( "mute_device_active_enter" );
                }

                continue;
            }

            if ( var_4 )
            {
                self.touchingplayers = common_scripts\utility::array_remove( self.touchingplayers, var_2 );
                var_2 playlocalsound( "mute_device_active_exit" );
            }
        }

        wait 0.05;
    }
}
