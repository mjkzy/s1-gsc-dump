// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A762::main();
    _id_A6C5::main();
    _id_A761::main();
    maps\mp\_load::main();
    maps\mp\mp_comeback_lighting::main();
    maps\mp\mp_comeback_aud::main();
    level._id_088B = 600;
    level._id_088A = 275;
    maps\mp\_compass::_id_831E( "compass_map_mp_comeback" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::_id_20B6;
    level._id_6573 = ::_id_20B7;
    level thread _id_4CC0();
    level thread _id_4D69();
    level._id_65AB = "mp_comeback_osp";
    level._id_65A9 = "mp_comeback_osp";
    level._id_2F3B = "mp_comeback_drone";
    level._id_2F12 = "mp_comeback_drone";
    level._id_A197 = "mp_comeback_warbird";
    level._id_A18C = "mp_comeback_warbird";
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -2172.0, 364.0, 1836.0 ), ( -1472.0, 364.0, 1836.0 ) );
}

_id_20B6()
{
    level thread _id_A7D2::init();
}

_id_20B7()
{
    if ( level.currentgen )
    {
        level._id_6574._id_898B = 30;
        level._id_6574._id_898A = 90;
        level._id_6574._id_89DC = 9541;
        level._id_6574._id_0252 = 15;
        level._id_6574._id_0380 = 15;
        level._id_6574._id_04BD = -40;
        level._id_6574._id_0089 = 60;
    }
}

_id_4CC0()
{
    var_0 = getentarray( "ceiling_fan", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_1C0D );
}

_id_1C0D()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 700, 750 );

    for (;;)
    {
        self rotatevelocity( ( 0, var_1, 0 ), var_0 );
        wait(var_0);
    }
}

_id_4D69()
{
    var_0 = [];

    for ( var_1 = 1; var_1 <= 7; var_1++ )
    {
        var_2 = "mp_comeback_vista_cars_0" + var_1;
        map_restart( var_2 );
        var_0[var_0.size] = var_2;
    }

    var_3 = getentarray( "traffic", "targetname" );

    for ( var_1 = 0; var_1 < var_3.size && var_0.size; var_1++ )
        var_3[var_1] thread _id_76BC( var_0[var_1] );
}

_id_76BC( var_0 )
{
    self _meth_848B( var_0, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
}
