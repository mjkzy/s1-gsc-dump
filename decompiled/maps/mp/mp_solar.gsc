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
        self rotatevelocity( ( var_1, 0, 0 ), var_0 );
        wait(var_0);
    }
}
