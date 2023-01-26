// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A778::main();
    _id_A6E6::main();
    _id_A777::main();
    maps\mp\mp_solar_aud::main();
    maps\mp\mp_solar_lighting::main();
    maps\mp\_load::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_solar" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_5985 = ::_id_8863;
    level thread _id_804D();
    level._id_6573 = ::_id_8865;
    level thread _id_4CEB();
    level._id_65AB = "mp_solar_osp";
    level._id_65A9 = "mp_solar_osp";
    level._id_A197 = "mp_solar_warbird";
    level._id_A18C = "mp_solar_warbird";
    level._id_2F3B = "mp_solar_drone";
    level._id_2F12 = "mp_solar_drone";

    if ( level.nextgen )
        setdvar( "sm_polygonOffsetPreset", 2 );

    _id_A75F::init();
}

_id_8863()
{
    level thread _id_A7D9::init();
}

_id_804D()
{
    ambientplay( "amb_mp_solar_ext" );
}

_id_8865()
{
    level._id_6574._id_89DC = 9079;
}

_id_4CEB()
{
    var_0 = getentarray( "solar_fan", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_76A7 );
}

_id_76A7()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 700, 750 );

    for (;;)
    {
        self rotatevelocity( ( var_1, 0, 0 ), var_0 );
        wait(var_0);
    }
}
