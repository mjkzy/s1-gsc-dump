// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_solar_precache::main();
    maps\createart\mp_solar_art::main();
    maps\mp\mp_solar_fx::main();
    maps\mp\mp_solar_aud::main();
    maps\mp\mp_solar_lighting::main();
    maps\mp\_load::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_solar" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.mapcustomkillstreakfunc = ::solarcustomkillstreakfunc;
    level thread setup_audio();
    level.orbitalsupportoverridefunc = ::solarpaladinoverrides;
    level thread init_fans();
    level.ospvisionset = "mp_solar_osp";
    level.osplightset = "mp_solar_osp";
    level.warbirdvisionset = "mp_solar_warbird";
    level.warbirdlightset = "mp_solar_warbird";
    level.dronevisionset = "mp_solar_drone";
    level.dronelightset = "mp_solar_drone";

    if ( level.nextgen )
        setdvar( "sm_polygonOffsetPreset", 2 );

    maps\mp\_water::init();
    level thread solarpatchclip();
    level thread solargoliathscriptbadareas();
}

solarpatchclip()
{
    thread ravenclip();
    thread columnclip();
    thread waterbuildingroofclip();
    thread lightposthovertoroof();
}

lightposthovertoroof()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 450, 799, 667 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 450, 799, 923 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 450, 799, 1179 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 450, 799, 1435 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 194, 799, 667 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 194, 799, 923 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 194, 799, 1179 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 194, 799, 1435 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 130, 799, 667 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 130, 799, 923 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 130, 799, 1179 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 130, 799, 1435 ), ( 0, 270, 0 ) );
}

waterbuildingroofclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1174, 2482, 832 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1174, 2482, 576 ), ( 0, 270, 0 ) );
}

columnclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -1102.5, 1748, 391.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -1102.5, 1734, 391.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -1102.5, 1748, 327.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( -1102.5, 1734, 327.5 ), ( 0, 0, 0 ) );
}

ravenclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1412, 912, 148 ), ( 0, 100, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1308, 912, 148 ), ( 0, 80, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1212, 872, 148 ), ( 0, 55, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1144, 804, 148 ), ( 0, 30, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1100, 708, 148 ), ( 0, 10, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1100, 608, 148 ), ( 0, 350, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1136, 520, 148 ), ( 0, 327, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_128_128", ( -1216, 436, 148 ), ( 0, 302, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -748.5, 986, 54 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -804.5, 1058, 54 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -804.5, 1186, 54 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -748.5, 1042, 110 ), ( 270, 0, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -748.5, 1170, 110 ), ( 270, 0, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -590, 1808.5, 37 ), ( 0, 270, -33 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -529.5, 1808.5, 20 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( -487.5, 1843.5, 1 ), ( 0, 0, -123.2 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 724, -384, 188 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 724, -384, 60 ), ( 0, 0, 0 ) );
}

solargoliathscriptbadareas()
{
    if ( !isdefined( level.goliath_bad_landing_volumes ) )
        level.goliath_bad_landing_volumes = [];

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = spawn( "trigger_radius", ( -332, 600, -60 ), 0, 96, 64 );
}

solarcustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_solar::init();
}

setup_audio()
{
    ambientplay( "amb_mp_solar_ext" );
}

solarpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnheight = 9079;
}

init_fans()
{
    var_0 = getentarray( "solar_fan", "targetname" );
    common_scripts\utility::array_thread( var_0, ::run_fan );
}

run_fan()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 700, 750 );

    for (;;)
    {
        self _meth_82BD( ( var_1, 0, 0 ), var_0 );
        wait(var_0);
    }
}
