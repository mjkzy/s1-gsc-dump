// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_A238()
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "faux_spawn" );

    if ( !isdefined( level._id_0869 ) )
        _id_601F();

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

            thread _id_98B3( var_0 );
        }
    }
}

_id_601F()
{
    self._id_0869 = spawnstruct();
}

_id_98B3( var_0 )
{
    if ( !isdefined( self._id_0869 ) )
        _id_601F();

    thread _id_8D2A( var_0 );
    thread monitorplayerdeath( var_0 );
    var_0 thread _id_5E85();
    return 1;
}

_id_8D2A( var_0 )
{
    self endon( "ClearMuteBomb" );
    self endon( "death" );
    var_0 endon( "death" );
    var_0 playsound( "mute_device_activate" );
    wait 0.75;
    var_0 _meth_84D5( 350, 600, 0.25 );
    var_0 playloopsound( "mute_device_active_lp" );
    var_0 thread _id_5E86();
    wait 20;
    var_0 scalevolume( 0.0, 0.25 );
    var_0 _meth_84D6( 0.25 );
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
        var_0 _meth_84D6( 0.25 );
        var_0 notify( "ShutdownMuteBomb" );
    }
}

_id_5E85()
{
    self endon( "ShutdownMuteBomb" );
    self waittill( "death" );

    if ( isdefined( self ) )
    {
        self _meth_84D6( 0.25 );
        self notify( "ShutdownMuteBomb" );
    }
}

_id_5E86()
{
    self endon( "ShutdownMuteBomb" );
    var_0 = 475.0;
    self._id_9404 = [];

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            var_3 = distance( self.origin, var_2.origin );
            var_4 = common_scripts\utility::array_contains( self._id_9404, var_2 );

            if ( var_3 <= var_0 )
            {
                if ( !var_4 )
                {
                    self._id_9404 = common_scripts\utility::array_add( self._id_9404, var_2 );
                    var_2 playlocalsound( "mute_device_active_enter" );
                }

                continue;
            }

            if ( var_4 )
            {
                self._id_9404 = common_scripts\utility::array_remove( self._id_9404, var_2 );
                var_2 playlocalsound( "mute_device_active_exit" );
            }
        }

        wait 0.05;
    }
}
