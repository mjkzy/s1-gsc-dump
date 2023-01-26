// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_7E62();
    thread _id_572C( "sewers_pit_flicker_aa", 1, 55000, 0.01, 0.1 );
    thread _id_572C( "gasStation_fire_flicker_aa", 1, 155000, 0.01, 0.1 );
}

_id_7E62()
{
    if ( _func_235() )
        return;
}

_id_572C( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getent( var_0, "targetname" );

    if ( !isdefined( var_5 ) )
        return;

    for (;;)
    {
        var_6 = randomfloatrange( var_1, var_2 );
        var_5 _meth_81DF( var_6 );
        wait(randomfloatrange( var_3, var_4 ));
    }
}
