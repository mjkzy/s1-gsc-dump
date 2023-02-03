// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_comeback_precache::main();
    maps\createart\mp_comeback_art::main();
    maps\mp\mp_comeback_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_comeback_lighting::main();
    maps\mp\mp_comeback_aud::main();
    level.aerial_pathnode_offset = 600;
    level.aerial_pathnode_group_connect_dist = 275;
    maps\mp\_compass::setupminimap( "compass_map_mp_comeback" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.mapcustomkillstreakfunc = ::comebackcustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::comebackcustomospfunc;
    level thread init_ceiling_fans();
    level thread init_traffic();
    level.ospvisionset = "mp_comeback_osp";
    level.osplightset = "mp_comeback_osp";
    level.dronevisionset = "mp_comeback_drone";
    level.dronelightset = "mp_comeback_drone";
    level.warbirdvisionset = "mp_comeback_warbird";
    level.warbirdlightset = "mp_comeback_warbird";
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -2172, 364, 1836 ), ( -1472, 364, 1836 ) );
}

comebackcustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_comeback::init();
}

comebackcustomospfunc()
{
    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.spawnanglemin = 30;
        level.orbitalsupportoverrides.spawnanglemax = 90;
        level.orbitalsupportoverrides.spawnheight = 9541;
        level.orbitalsupportoverrides.leftarc = 15;
        level.orbitalsupportoverrides.rightarc = 15;
        level.orbitalsupportoverrides.toparc = -40;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

init_ceiling_fans()
{
    var_0 = getentarray( "ceiling_fan", "targetname" );
    common_scripts\utility::array_thread( var_0, ::ceiling_fan );
}

ceiling_fan()
{
    var_0 = 1800;
    var_1 = randomfloatrange( 700, 750 );

    for (;;)
    {
        self rotatevelocity( ( 0, var_1, 0 ), var_0 );
        wait(var_0);
    }
}

init_traffic()
{
    var_0 = [];

    for ( var_1 = 1; var_1 <= 7; var_1++ )
    {
        var_2 = "mp_comeback_vista_cars_0" + var_1;
        precachempanim( var_2 );
        var_0[var_0.size] = var_2;
    }

    var_3 = getentarray( "traffic", "targetname" );

    for ( var_1 = 0; var_1 < var_3.size && var_0.size; var_1++ )
        var_3[var_1] thread run_traffic( var_0[var_1] );
}

run_traffic( var_0 )
{
    self scriptmodelplayanimdeltamotionfrompos( var_0, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}
