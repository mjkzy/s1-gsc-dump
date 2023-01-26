// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    thread _id_A1DA();
}

_id_A1DA()
{
    level endon( "game_ended" );
}

_id_8C53()
{
    wait 1.5;
    playsoundatpos( ( 2382.0, 44.0, 140.0 ), "mp_laser2_wave_crashes_under_helipad_large" );
    wait 5;
    thread _id_6967( "mp_laser2_wave_crashes_under_helipad", ( 2265.0, -273.0, 184.0 ), 12, 15 );
    wait 6;
    thread _id_6967( "mp_laser2_wave_crashes_under_helipad", ( 2554.0, 188.0, 181.0 ), 11, 20 );
    wait 5;
    thread _id_6967( "mp_laser2_wave_crashes_under_helipad", ( 2562.0, 477.0, 184.0 ), 11, 16 );
}

_id_6967( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        playsoundatpos( var_1, var_0 );
        var_4 = level common_scripts\utility::waittill_any_timeout( randomintrange( var_2, var_3 ), "end_high_tide_waves" );

        if ( var_4 != "timeout" )
            return;
    }
}
