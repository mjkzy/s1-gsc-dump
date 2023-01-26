// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{

}

_id_A21C( var_0 )
{
    _id_0D07();
    self endon( "solar_reflector_player_removed" );
    var_1 = 0.05;
    var_2 = 0;
    var_3 = self getangles();
    var_4 = spawn( "script_origin", level._id_885F.origin );
    var_4 linkto( level._id_885F );
    thread _id_9F9F( var_4 );

    for (;;)
    {
        var_5 = self getangles();
        var_6 = distance2d( var_5, var_3 );

        if ( var_6 > var_1 )
        {
            if ( !var_2 )
            {
                var_4 playloopsound( "mp_solar_array_player_move" );
                var_4 scalevolume( 0.7, 0.1 );
                var_2 = 1;
            }
        }
        else if ( var_2 )
        {
            var_4 scalevolume( 0, 0.3 );
            var_4 stoploopsound();
            var_2 = 0;
        }

        var_3 = var_5;
        wait 0.05;
    }
}

_id_0D07()
{
    playsoundatpos( ( 1423.67, 1543.22, 64.4061 ), "mp_solar_array_generator" );
}

_id_9F9F( var_0 )
{
    self waittill( "solar_reflector_player_removed" );
    var_0 stoploopsound();
    wait 0.25;
    var_0 delete();
}
