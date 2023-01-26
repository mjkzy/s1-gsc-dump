// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A764::main();
    _id_A6C8::main();
    _id_A763::main();
    maps\mp\_load::main();
    maps\mp\mp_detroit_lighting::main();
    maps\mp\mp_detroit_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_detroit" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    _id_A75F::_id_8000( "iw5_underwater_mp" );
    _id_A75F::init();
    level._id_65AB = "(mp_detroit_osp)";
    level._id_65A9 = "(mp_detroit_osp)";
    level._id_2F3B = "(mp_detroit_drone)";
    level._id_2F12 = "(mp_detroit_drone)";
    level._id_A197 = "(mp_detroit_warbird)";
    level._id_A18C = "(mp_detroit_warbird)";
    level._id_088B = 425;
    level thread maps\mp\mp_detroit_events::_id_96C4();
    level._id_5985 = ::_id_29C0;
    level._id_6573 = ::_id_29C1;
    level thread _id_29C2();
    level thread detroitpatchclip();
    thread _id_7E66();
}

_id_29C2()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 2500;
    setdvar( "bg_bombingRunNoMissileClip", 1 );
}

_id_29C1()
{
    level._id_6574._id_898B = 220;
    level._id_6574._id_898A = 260;

    if ( level.currentgen )
    {
        level._id_6574._id_0252 = 15;
        level._id_6574._id_0380 = 15;
        level._id_6574._id_04BD = -35;
        level._id_6574._id_0089 = 55;
    }
}

_id_29C0()
{
    level thread _id_A7D3::init();
}

detroitpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 697.5 ), ( 0.0, 353.054, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 569.5 ), ( 0.0, 353.054, 0.0 ) );
}

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}
