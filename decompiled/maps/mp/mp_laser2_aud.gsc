// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread watch_for_underwater();
}

watch_for_underwater()
{
    level endon( "game_ended" );
}

start_rough_tide()
{
    wait 1.5;
    playsoundatpos( ( 2382, 44, 140 ), "mp_laser2_wave_crashes_under_helipad_large" );
    wait 5;
    thread play_interval_sound( "mp_laser2_wave_crashes_under_helipad", ( 2265, -273, 184 ), 12, 15 );
    wait 6;
    thread play_interval_sound( "mp_laser2_wave_crashes_under_helipad", ( 2554, 188, 181 ), 11, 20 );
    wait 5;
    thread play_interval_sound( "mp_laser2_wave_crashes_under_helipad", ( 2562, 477, 184 ), 11, 16 );
}

play_interval_sound( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        playsoundatpos( var_1, var_0 );
        var_4 = level common_scripts\utility::waittill_any_timeout( randomintrange( var_2, var_3 ), "end_high_tide_waves" );

        if ( var_4 != "timeout" )
            return;
    }
}
