// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_refraction_precache::main();
    maps\createart\mp_refraction_art::main();
    maps\mp\mp_refraction_lighting::main();
    maps\mp\mp_refraction_fx::main();
    level.aerial_pathnode_offset = 600;
    level.aerial_pathnode_group_connect_dist = 300;
    level.ospvisionset = "mp_refraction_osp";
    level.osplightset = "mp_refraction_osp";
    level.warbirdvisionset = "mp_refraction_osp";
    level.warbirdlightset = "mp_refraction_osp";
    level.vulcanvisionset = "mp_refraction_osp";
    level.vulcanlightset = "mp_refraction_osp";
    maps\mp\_load::main();
    level.alarmfx = loadfx( "vfx/lights/light_red_pulse_fast" );
    level.rain = loadfx( "vfx/rain/rain_volume_windy" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 10 );
    maps\mp\_water::init();
    maps\mp\_compass::setupminimap( "compass_map_mp_refraction" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    thread set_lighting_values();
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.mapcustomkillstreakfunc = ::refractioncustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::refractioncustomospfunc;
    level.remote_missile_height_override = 16000;
    level.orbitallaseroverridefunc = ::refractionvulcancustomfunc;
    thread scriptpatchclip();
    thread scriptmissilespawnmove();
    thread fixdroppedbomb();
    thread scriptpatchdisconnectnodes();
    thread fixupremotemissileentsonnodes();
    common_scripts\utility::array_thread( getentarray( "com_radar_dish", "targetname" ), ::radar_dish_rotate );
}

scriptmissilespawnmove()
{
    var_0 = getentarray( "remoteMissileSpawn", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_noteworthy ) )
        {
            if ( var_2.script_noteworthy == "0" )
            {
                var_2.origin = ( 1953.2, -2062.4, 5654 );
                var_3 = getent( var_2.target, "targetname" );
                var_3.origin = ( 1508.7, -1493.2, 2270 );
                continue;
            }

            if ( var_2.script_noteworthy == "3" )
            {
                var_2.origin = ( 1905, 70.4, 5654 );
                var_3 = getent( var_2.target, "targetname" );
                var_3.origin = ( 1413, -202, 2270 );
                continue;
            }

            if ( var_2.script_noteworthy == "2" )
            {
                var_2.origin = ( -1798, -132, 5654 );
                var_3 = getent( var_2.target, "targetname" );
                var_3.origin = ( -1149.3, -418.1, 2270 );
                continue;
            }

            if ( var_2.script_noteworthy == "1" )
            {
                var_2.origin = ( -1338, -1820, 5654 );
                var_3 = getent( var_2.target, "targetname" );
                var_3.origin = ( -709, -1462.9, 2270 );
            }
        }
    }
}

fixdroppedbomb()
{
    if ( level.gametype == "sd" )
    {
        while ( !isdefined( level.sdbomb ) )
            wait 0.05;

        level.sdbomb thread watchcarryobjects();
    }
    else if ( level.gametype == "sr" )
    {
        while ( !isdefined( level.sdbomb ) )
            wait 0.05;

        level.sdbomb thread watchcarryobjects();
    }
    else if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread watchcarryobjects();
    }
    else if ( level.gametype == "ctf" )
    {
        while ( !isdefined( level.teamflags ) || !isdefined( level.teamflags[game["defenders"]] ) || !isdefined( level.teamflags[game["attackers"]] ) )
            wait 0.05;

        level.teamflags[game["defenders"]] thread watchcarryobjects();
        level.teamflags[game["attackers"]] thread watchcarryobjects();
    }
}

watchcarryobjects()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( 176, -308, -116 ), 0, 5000, 2000 );
    var_0.targetname = "object_out_of_bounds";

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;

        if ( isoutofbounds() )
            maps\mp\gametypes\_gameobjects::returnhome();
    }
}

isoutofbounds()
{
    var_0 = getentarray( "radiation", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_0[var_1] ) )
            continue;

        return 1;
    }

    var_2 = getentarray( "minefield", "targetname" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_2[var_1] ) )
            continue;

        return 1;
    }

    var_3 = getentarray( "trigger_hurt", "classname" );

    for ( var_1 = 0; var_1 < var_3.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_3[var_1] ) )
            continue;

        return 1;
    }

    var_4 = getentarray( "remote_heli_range", "targetname" );

    for ( var_1 = 0; var_1 < var_4.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_4[var_1] ) )
            continue;

        return 1;
    }

    var_5 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_5.size; var_1++ )
    {
        if ( !self.visuals[0] _meth_80A9( var_5[var_1] ) )
            continue;

        return 1;
    }

    if ( self.visuals[0].origin[2] <= 1863 )
        return 1;

    return 0;
}

scriptpatchclip()
{
    thread lockingpiececlip();
    thread stuckspotbanisterclip();
    thread columnclip();
    thread elevatorclip();
    thread securityclip();
    thread elevatorclip2();
    thread helipadoutmap();
    thread jumpintocranegeo();
    thread dropandhoverintoscaffolding();
    thread standoutsideunderwalkway();
}

standoutsideunderwalkway()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -213, -730, 1868 ), ( 0, 0, 0 ) );
}

jumpintocranegeo()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -1872, -180, 1931 ), ( 338.3, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -1990, -180, 1884 ), ( 338.3, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -2108, -180, 1837 ), ( 338.3, 0, 0 ) );
}

dropandhoverintoscaffolding()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -2250, 87, 2085 ), ( 270, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -2196, 87, 2085 ), ( 270, 0, 0 ) );
}

helipadoutmap()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -2450, -1008, 2364 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -2450, -1136, 2364 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -2450, -1222, 2364 ), ( 0, 0, 0 ) );
}

elevatorclip2()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -772, 184, 2500 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -772, 184, 2756 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -768, 184, 3012 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -768, 184, 3268 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -766, 194, 3268 ), ( 0, 314, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -766, 194, 3012 ), ( 0, 314, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -766, 194, 2756 ), ( 0, 314, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -766, 194, 2500 ), ( 0, 314, 0 ) );
}

securityclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 553, 2264 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 585, 2264 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 553, 2392 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 585, 2392 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 553, 2520 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1490, 585, 2520 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 553, 2264 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 585, 2264 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 553, 2392 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 585, 2392 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 553, 2520 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1686, 585, 2520 ), ( 0, 0, 0 ) );
}

elevatorclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 780, 396, 2753 ), ( 0, 315.5, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -758, 370, 2648 ), ( 0, 225.3, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 460, 164, 2388 ), ( 0, 296, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 460, 164, 2644 ), ( 0, 296, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -450, 160, 2388 ), ( 0, 246, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -450, 160, 2644 ), ( 0, 246, 0 ) );
}

columnclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1268, -885, 2658 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1268, -885, 2914 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1388, -765, 2658 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1388, -765, 2914 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1388, -897, 2658 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1388, -897, 2914 ), ( 0, 270, 0 ) );
}

stuckspotbanisterclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 814, -25, 2152 ), ( 0, 0, 0 ) );
}

scriptpatchdisconnectnodes()
{
    thread whitneybuildingnodes();
    thread overgapcenternodes01();
}

whitneybuildingnodes()
{
    findpairnodeanddisconnect( ( 2554.5, -700, 2286 ) );
    findpairnodeanddisconnect( ( 2778, -886, 2204 ) );
}

overgapcenternodes01()
{
    findpairnodeanddisconnect( ( -289.1, -1157.1, 2000 ) );
}

findpairnodeanddisconnect( var_0 )
{
    var_1 = getnodesinradius( var_0, 64, 0, 72, "Begin" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.target ) )
        {
            var_4 = getnode( var_3.target, "targetname" );

            if ( isdefined( var_4 ) && isdefined( var_3 ) )
                disconnectnodepair( var_3, var_4 );
        }
    }
}

lockingpiececlip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 110, -180, 2565.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 110, -180, 2693.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 110, -180, 2821.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 110, -180, 2874 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 38, -180, 2930 ), ( 90, 0, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -38, -180, 2930 ), ( 90, 0, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -110, -180, 2874 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -110, -180, 2821.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -110, -180, 2693.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -110, -180, 2565.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 110, -180, 2565.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 110, -180, 2693.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 110, -180, 2821.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 110, -180, 2874 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 38, -180, 2930 ), ( 90, 0, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( -38, -180, 2930 ), ( 90, 0, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( -110, -180, 2874 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( -110, -180, 2821.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( -110, -180, 2693.5 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( -110, -180, 2565.5 ), ( 0, 0, 0 ) );
}

fixupremotemissileentsonnodes()
{
    for (;;)
    {
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1249.3, 828.9, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1319.8, 823.9, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1251.1, 789.2, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1348.6, 834.2, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1332, 786, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1244.7, 687.7, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1254.9, 635.6, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1304, 632, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1324, 674, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1332, 678, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1376, 624, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1456, 720, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1504, 768, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1472, 624, 2064.63 ), "up" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1552, 768, 2064.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1600, 832, 2064.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1648, 784, 2064.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1536, 688, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1544.85, 634.729, 2064.63 ), "up" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1616, 704, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1696, 720, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1584, 624, 2064.63 ), "up" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1648, 640, 2064.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1584, 560, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1615.4, 546.8, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1664, 512, 2064.63 ), "none" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1324, 566, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1308.1, 495.1, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1262.9, 515.6, 2202.63 ), "1" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1513.4, 501.3, 2202.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1516.89, 530.409, 2202.63 ), "4" );
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1760, 512, 2065.71 ), "4" );
        level waittill( "host_migration_begin" );
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }
}

refractioncustomkillstreakfunc()
{
    level.killstreakweildweapons["refraction_turret_mp"] = 1;
    level thread maps\mp\killstreaks\streak_mp_refraction::init();
}

refractioncustomospfunc()
{
    level.orbitalsupportoverrides.spawnanglemin = 260;
    level.orbitalsupportoverrides.spawnanglemax = 350;
    level.orbitalsupportoverrides.turretpitch = 50;
    level.orbitalsupportoverrides.toparc = -38;
    level.orbitalsupportoverrides.spawnheight = 10426;
}

refractionvulcancustomfunc()
{
    level.orbitallaseroverrides.spawnpoint = ( 20, -500, 0 );
}

radar_dish_rotate()
{
    var_0 = 0;
    var_1 = 40000;
    var_2 = 1.0;

    if ( isdefined( self.speed ) )
        var_2 = self.speed;

    var_0 = 70;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
        wait 0;
    else
        wait(randomfloatrange( 0, 1 ));

    for (;;)
    {
        self _meth_82BD( ( 0, var_0, 0 ), var_1 );
        wait(var_1);
    }
}

set_lighting_values()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 _meth_82FD( "r_tonemap", "1" );
        }
    }
}
