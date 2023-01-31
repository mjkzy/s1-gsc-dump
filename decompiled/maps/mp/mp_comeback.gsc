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
    level thread scriptpatchclip();
    level thread movehelispawnnodes();

    if ( isdefined( level.gametype ) )
    {
        if ( level.gametype == "sd" || level.gametype == "sr" )
            level thread movebombsitea();
    }
}

movehelispawnnodes()
{
    var_0 = getentarray( "heli_loop_start", "targetname" );

    for (;;)
    {
        var_1 = getent( var_0[var_0.size - 1].target, "targetname" );

        if ( !isdefined( var_1 ) )
            break;
        else if ( common_scripts\utility::array_contains( var_0, var_1 ) )
            break;
        else
            var_0[var_0.size] = var_1;
    }

    foreach ( var_3 in var_0 )
    {
        if ( distance( ( 2000, -1416, 1920 ), var_3.origin ) < 10 )
        {
            var_3.origin = ( 1680, -1416, 1920 );
            continue;
        }

        if ( distance( ( -2172, 364, 1836 ), var_3.origin ) < 10 )
        {
            var_3.origin = ( -1628, 364, 1836 );
            continue;
        }

        if ( distance( ( 224, 2092, 1884 ), var_3.origin ) < 10 )
        {
            var_3.origin = ( 224, 1884, 1884 );
            continue;
        }

        if ( distance( ( 1880, 716, 1964 ), var_3.origin ) < 10 )
        {
            var_3.origin = ( 1524, 630.5, 1964 );
            continue;
        }

        if ( distance( ( 32, -2020, 1884 ), var_3.origin ) < 10 )
            var_3.origin = ( 32, -1825.5, 1884 );
    }
}

scriptpatchclip()
{
    thread clipsign();
    thread clipbuildingside();
}

clipbuildingside()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 340, -344, 936 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 340, -344, 1192 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 340, -344, 1448 ), ( 0, 0, 0 ) );
}

clipsign()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1332, -1166, 676 ), ( 0, 250, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1338, -1152, 676 ), ( 0, 250, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1270, -988, 676 ), ( 0, 160, 0 ) );
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

movebombsitea()
{
    var_0 = -12;
    var_1 = getentarray( "bombzone", "targetname" );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4.script_label ) && var_4.script_label == "_a" )
        {
            var_2[var_2.size] = var_4;
            var_5 = getent( var_4.target, "targetname" );
            var_2[var_2.size] = var_5;
            var_2[var_2.size] = getent( var_5.target, "targetname" );
            var_4.origin += ( -24, 0, 0 );
            break;
        }
    }

    var_7 = getentarray( "exploder", "targetname" );

    foreach ( var_9 in var_7 )
    {
        if ( isdefined( var_9.script_gameobjectname ) && var_9.script_gameobjectname == "bombzone" )
        {
            if ( isdefined( var_9.script_exploder ) && issubstr( var_9.script_exploder, "_1" ) )
            {
                var_2[var_2.size] = var_9;
                break;
            }
        }
    }

    var_11 = getentarray( "script_brushmodel", "classname" );

    foreach ( var_13 in var_11 )
    {
        if ( isdefined( var_13.script_gameobjectname ) && var_13.script_gameobjectname == "bombzone" )
        {
            if ( isdefined( var_13.script_label ) && var_13.script_label == "bombzone_a" )
            {
                var_2[var_2.size] = var_13;
                break;
            }
        }
    }

    foreach ( var_16 in var_2 )
        var_16.origin += ( var_0, 0, 0 );
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
        self _meth_82BD( ( 0, var_1, 0 ), var_0 );
        wait(var_0);
    }
}

init_traffic()
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
        var_3[var_1] thread run_traffic( var_0[var_1] );
}

run_traffic( var_0 )
{
    self _meth_848B( var_0, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}
