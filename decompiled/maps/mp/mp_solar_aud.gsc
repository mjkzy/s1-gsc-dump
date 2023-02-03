// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{

}

watchforlasermovement( var_0 )
{
    array_sound_start();
    self endon( "solar_reflector_player_removed" );
    var_1 = 0.05;
    var_2 = 0;
    var_3 = self getangles();
    var_4 = spawn( "script_origin", level.solar_reflector_cam_tag.origin );
    var_4 linkto( level.solar_reflector_cam_tag );
    thread wait_for_laser_end( var_4 );

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

array_sound_start()
{
    playsoundatpos( ( 1423.67, 1543.22, 64.4061 ), "mp_solar_array_generator" );
}

wait_for_laser_end( var_0 )
{
    self waittill( "solar_reflector_player_removed" );
    var_0 stoploopsound();
    wait 0.25;
    var_0 delete();
}
