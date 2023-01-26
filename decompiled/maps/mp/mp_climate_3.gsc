// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::climate_callbackstartgametype;
    maps\mp\mp_climate_3_precache::main();
    maps\createart\mp_climate_3_art::main();
    maps\mp\mp_climate_3_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_climate_3_lighting::main();
    maps\mp\mp_climate_3_aud::main();
    precacherumble( "tank_rumble" );
    precacherumble( "heavygun_fire" );
    precacherumble( "smg_fire" );
    precacheshellshock( "mp_climate_acid" );

    if ( level.nextgen )
    {
        map_restart( "cli_elevator_tower02_car01" );
        map_restart( "cli_elevator_tower02_car02" );
        map_restart( "cli_elevator_tower02_car03" );
        map_restart( "cli_elevator_tower02_car04" );
        map_restart( "cli_elevator_tower03_car01" );
        map_restart( "cli_elevator_tower03_car02" );
        map_restart( "cli_elevator_tower03_car03" );
        map_restart( "cli_elevator_tower03_car04" );
        map_restart( "cli_elevator_tower04_car01" );
        map_restart( "cli_elevator_tower04_car02" );
        map_restart( "cli_elevator_tower04_car03" );
        map_restart( "cli_elevator_tower04_car04" );
        map_restart( "cli_elevator_tower05_car01" );
        map_restart( "cli_elevator_tower05_car02" );
        map_restart( "cli_elevator_tower05_car03" );
        map_restart( "cli_elevator_tower05_car04" );
    }

    level.bots_ignore_water = 1;
    _id_A75F::_id_8000( "iw5_combatknife_mp" );
    _id_A75F::_id_7F3F( "iw5_combatknife_mp" );
    _id_A75F::init();
    setdvar( "scr_ball_water_drop_delay", 20 );
    maps\mp\_compass::_id_831E( "compass_map_mp_climate_3" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.watermovescale = 0.8;

    if ( level.nextgen )
        thread setupelevatoranims();

    level _id_2FE7();
    level thread maps\mp\_dynamic_events::_id_2FE6( ::startdynamicevent, undefined, ::enddynamicevent );
    level._id_6573 = ::climatepaladinoverrides;
    level._id_65AB = "mp_climate_3_osp";
    level._id_65A9 = "mp_climate_3_osp";
    level._id_A197 = "mp_climate_3_osp";
    level._id_A18C = "mp_climate_3_osp";
    level._id_9F74 = "mp_climate_3_osp";
    level._id_9F73 = "mp_climate_3_osp";
    _id_8A06();
    level thread onplayerconnect();

    if ( !( isdefined( level.wateristoxic ) && level.wateristoxic ) )
        thread preparetoxicwater();

    var_0 = getent( "waterfall_model_small", "targetname" );
    var_1 = getent( "waterfall_model_large", "targetname" );

    if ( isdefined( var_1 ) )
        var_1 notsolid();

    if ( isdefined( var_0 ) )
        var_0 notsolid();

    thread trigger_fixes();
    thread clip_fixes();
}

trigger_fixes()
{
    var_0 = 1024;
    var_1 = getentarray( "ball_out_of_bounds_triggers", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( distancesquared( var_3.origin, ( -216.0, -372.0, 20.0 ) ) <= var_0 )
            var_3.origin -= ( 0.0, 0.0, 5000.0 );
    }
}

clip_fixes()
{
    thread greenhouseroofclip01();
    thread greenhouseroofclip02();
    thread greenhouseroofclip03();
    thread canyonrockclip01();
    thread eagleheadclip01();
    thread archrockclip01();
    thread archrockclip02();
    thread lionheadrockclip01();
    thread waterfallrockclip01();
    thread climatronclip01();
    thread grapplenorthernbridge();
    thread swcanopygrappleoutbounds();
    thread sewerclip01();
    thread sewerclip02();
}

sewerclip01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 594.0, -200.0, 104.0 ), ( 270.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 604.0, -136.0, 104.0 ), ( 270.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 608.0, -72.0, 104.0 ), ( 270.0, 90.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 568.0, -72.0, 80.0 ), ( 0.0, 180.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 568.0, -72.0, 16.0 ), ( 0.0, 180.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 608.0, -32.0, 16.0 ), ( 0.0, 270.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 608.0, -32.0, 80.0 ), ( 0.0, 270.0, -180.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 608.0, -70.0, 91.0 ), ( 60.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 608.0, -45.0, 69.0 ), ( 30.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 604.5, -157.0, 104.0 ), ( 270.0, 0.0, 85.6 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 594.5, -217.0, 104.0 ), ( 270.0, 360.0, 76.2 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 573.5, -266.5, 104.0 ), ( 270.0, 0.0, 60.0 ) );
}

sewerclip02()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -56.0, 568.0, 104.0 ), ( 270.0, 270.0, -90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -120.0, 568.0, 104.0 ), ( 270.0, 270.0, -90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -184.0, 568.0, 104.0 ), ( 270.0, 270.0, -90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -248.0, 568.0, 104.0 ), ( 270.0, 270.0, -90.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -251.0, 560.0, 91.0 ), ( 60.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -276.0, 560.0, 69.0 ), ( 30.0, 0.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -289.0, 560.0, 16.0 ), ( 0.0, 0.0, 180.0 ) );
}

swcanopygrappleoutbounds()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -703.0, 1321.0, 785.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -877.0, 1496.0, 717.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1051.0, 1671.0, 647.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -691.0, 1332.0, 785.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -866.0, 1508.0, 717.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1040.0, 1683.0, 647.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -680.0, 1344.0, 785.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -854.0, 1519.0, 717.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1028.0, 1694.0, 647.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -668.0, 1355.0, 785.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -842.0, 1530.0, 717.0 ), ( 0.0, 44.8996, -15.4004 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1016.0, 1705.0, 647.0 ), ( 0.0, 44.8996, -15.4004 ) );
}

greenhouseroofclip01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 998.0, 461.0, 913.0 ), ( 0.0, 27.0962, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 998.0, 461.0, 1169.0 ), ( 0.0, 27.0962, 0.0 ) );
}

greenhouseroofclip02()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1018.5, 0.0, 879.8 ), ( 0.0, 27.8994, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1018.5, 0.0, 1135.8 ), ( 0.0, 27.8994, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1166.0, -203.0, 879.8 ), ( 0.0, 44.0983, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1166.0, -203.0, 1135.8 ), ( 0.0, 44.0983, 0.0 ) );
    var_0 = 814;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 1308, -243.5, var_0 ), ( 0.0, 42.1972, 0.0 ) );
        var_0 += 128;
    }
}

greenhouseroofclip03()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1013.5, 1638.0, 786.0 ), ( 0.0, 24.8, -32.6 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -925.0, 1444.5, 925.0 ), ( 0.0, 24.8, -32.6 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -793.0, 1233.0, 883.5 ), ( 0.0, 36.9, 30.7 ) );
}

canyonrockclip01()
{
    var_0 = -102;

    for ( var_1 = 0; var_1 < 12; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1455.5, -27, var_0 ), ( 0.0, 305.4, 0.0 ) );
        var_0 += 128;
    }
}

eagleheadclip01()
{
    var_0 = 432;

    for ( var_1 = 0; var_1 < 6; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1476, 364.5, var_0 ), ( 0.0, 64.1, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1483, 350, var_0 ), ( 0.0, 64.1, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1469, 379, var_0 ), ( 0.0, 64.1, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1490, 335.5, var_0 ), ( 0.0, 64.1, 0.0 ) );
        var_0 += 256;
    }
}

archrockclip01()
{
    var_0 = 455;

    for ( var_1 = 0; var_1 < 12; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -767, 341.5, var_0 ), ( 0.0, 24.8989, 0.0 ) );
        var_0 += 128;
    }

    var_0 = 300;

    for ( var_1 = 0; var_1 < 7; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -786, 290.5, var_0 ), ( 0.0, 355.4, 0.0 ) );
        var_0 += 256;
    }
}

archrockclip02()
{
    var_0 = 354;

    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( -904, -12, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 128;
    }
}

lionheadrockclip01()
{
    var_0 = 640;

    for ( var_1 = 0; var_1 < 7; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 504, 704, var_0 ), ( 0.0, 315.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 552, 648, var_0 ), ( 0.0, 315.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 483, 635, var_0 ), ( 0.0, 270.0, 0.0 ) );
        var_0 += 128;
    }
}

waterfallrockclip01()
{
    var_0 = 64;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -1408, -1304, var_0 ), ( 0.0, 0.0, 0.0 ) );
        var_0 += 128;
    }

    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( -1480.0, -1284.5, 512.0 ), ( 270.0, 0.0, 0.0 ) );
}

climatronclip01()
{
    var_0 = 1176;

    for ( var_1 = 0; var_1 < 8; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -476.7, -800.5, var_0 ), ( 0.0, 1.7, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -728.2, -1131.6, var_0 ), ( 0.0, 293.5, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -847.75, -1159.5, var_0 ), ( 0.0, 271.1, 0.0 ) );
        var_0 += 128;
    }

    var_0 = 1240;

    for ( var_1 = 0; var_1 < 4; var_1++ )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -534.14, -945.92, var_0 ), ( 0.0, 329.3, 0.0 ) );
        var_0 += 256;
    }
}

grapplenorthernbridge()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1328.0, 518.0, 751.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1328.0, 518.0, 1007.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1328.0, 518.0, 1263.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1138.0, 518.0, 751.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1138.0, 518.0, 1007.0 ), ( 0.0, 270.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1138.0, 518.0, 1263.0 ), ( 0.0, 270.0, 0.0 ) );
}

climate_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

preparetoxicwater()
{
    var_0 = getentarray( "water_bad", "targetname" );
    var_1 = getent( "waterfall_01_bad", "targetname" );
    linkallbadwater( var_0, var_1 );
    moveallbadwater( ( -0.0, -0.0, -12000.0 ) );
}

linkallbadwater( var_0, var_1 )
{
    level.water_bad_link = var_0[0];

    for ( var_2 = 1; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2].origin - level.water_bad_link.origin;
        var_4 = var_0[var_2].angles - level.water_bad_link.angles;
        var_0[var_2] linkto( level.water_bad_link, "", var_3, var_4 );
    }

    var_3 = var_1.origin - level.water_bad_link.origin;
    var_4 = var_1.angles - level.water_bad_link.angles;
    var_1 linkto( level.water_bad_link, "", var_3, var_4 );
}

moveallbadwater( var_0 )
{
    level.water_bad_link.origin += var_0;
}

setupelevatoranims()
{
    var_0 = common_scripts\utility::getstructarray( "tower_2_anim_node_01", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "tower_2_anim_node_02", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "tower_2_anim_node_03", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "tower_2_anim_node_04", "targetname" );
    var_4 = common_scripts\utility::getstructarray( "tower_3_anim_node_01", "targetname" );
    var_5 = common_scripts\utility::getstructarray( "tower_3_anim_node_02", "targetname" );
    var_6 = common_scripts\utility::getstructarray( "tower_3_anim_node_03", "targetname" );
    var_7 = common_scripts\utility::getstructarray( "tower_3_anim_node_04", "targetname" );
    var_8 = common_scripts\utility::getstructarray( "tower_4_anim_node_01", "targetname" );
    var_9 = common_scripts\utility::getstructarray( "tower_4_anim_node_02", "targetname" );
    var_10 = common_scripts\utility::getstructarray( "tower_4_anim_node_03", "targetname" );
    var_11 = common_scripts\utility::getstructarray( "tower_4_anim_node_04", "targetname" );
    var_12 = common_scripts\utility::getstructarray( "tower_5_anim_node_01", "targetname" );
    var_13 = common_scripts\utility::getstructarray( "tower_5_anim_node_02", "targetname" );
    var_14 = common_scripts\utility::getstructarray( "tower_5_anim_node_03", "targetname" );
    var_15 = common_scripts\utility::getstructarray( "tower_5_anim_node_04", "targetname" );

    foreach ( var_17 in var_0 )
    {
        var_18 = spawn( "script_model", var_17.origin );
        var_18 setmodel( "cli_vista_tower_elevator_02" );
        var_18.angles = var_17.angles;
        thread startelevatoranims( var_18, "tower02", "car01", 5.56 );
        waitframe();
    }

    foreach ( var_17 in var_1 )
    {
        var_21 = spawn( "script_model", var_17.origin );
        var_21 setmodel( "cli_vista_tower_elevator_02" );
        var_21.angles = var_17.angles;
        thread startelevatoranims( var_21, "tower02", "car02", 16.73 );
        waitframe();
    }

    foreach ( var_17 in var_2 )
    {
        var_24 = spawn( "script_model", var_17.origin );
        var_24 setmodel( "cli_vista_tower_elevator_02" );
        var_24.angles = var_17.angles;
        thread startelevatoranims( var_24, "tower02", "car03", 12.23 );
        waitframe();
    }

    foreach ( var_17 in var_3 )
    {
        var_27 = spawn( "script_model", var_17.origin );
        var_27 setmodel( "cli_vista_tower_elevator_02" );
        var_27.angles = var_17.angles;
        thread startelevatoranims( var_27, "tower02", "car04", 0.0 );
        waitframe();
    }

    foreach ( var_17 in var_4 )
    {
        var_18 = spawn( "script_model", var_17.origin );
        var_18 setmodel( "cli_vista_tower_elevator_02" );
        var_18.angles = var_17.angles;
        thread startelevatoranims( var_18, "tower03", "car01", 5.56 );
        waitframe();
    }

    foreach ( var_17 in var_5 )
    {
        var_21 = spawn( "script_model", var_17.origin );
        var_21 setmodel( "cli_vista_tower_elevator_02" );
        var_21.angles = var_17.angles;
        thread startelevatoranims( var_21, "tower03", "car02", 16.73 );
        waitframe();
    }

    foreach ( var_17 in var_6 )
    {
        var_24 = spawn( "script_model", var_17.origin );
        var_24 setmodel( "cli_vista_tower_elevator_02" );
        var_24.angles = var_17.angles;
        thread startelevatoranims( var_24, "tower03", "car03", 12.23 );
        waitframe();
    }

    foreach ( var_17 in var_7 )
    {
        var_27 = spawn( "script_model", var_17.origin );
        var_27 setmodel( "cli_vista_tower_elevator_02" );
        var_27.angles = var_17.angles;
        thread startelevatoranims( var_27, "tower03", "car04", 0.0 );
        waitframe();
    }

    foreach ( var_17 in var_8 )
    {
        var_18 = spawn( "script_model", var_17.origin );
        var_18 setmodel( "cli_vista_tower_elevator_02" );
        var_18.angles = var_17.angles;
        thread startelevatoranims( var_18, "tower04", "car01", 5.56 );
        waitframe();
    }

    foreach ( var_17 in var_9 )
    {
        var_21 = spawn( "script_model", var_17.origin );
        var_21 setmodel( "cli_vista_tower_elevator_02" );
        var_21.angles = var_17.angles;
        thread startelevatoranims( var_21, "tower04", "car02", 16.73 );
        waitframe();
    }

    foreach ( var_17 in var_10 )
    {
        var_24 = spawn( "script_model", var_17.origin );
        var_24 setmodel( "cli_vista_tower_elevator_02" );
        var_24.angles = var_17.angles;
        thread startelevatoranims( var_24, "tower04", "car03", 12.23 );
        waitframe();
    }

    foreach ( var_17 in var_11 )
    {
        var_27 = spawn( "script_model", var_17.origin );
        var_27 setmodel( "cli_vista_tower_elevator_02" );
        var_27.angles = var_17.angles;
        thread startelevatoranims( var_27, "tower04", "car04", 0.0 );
        waitframe();
    }

    foreach ( var_17 in var_12 )
    {
        var_18 = spawn( "script_model", var_17.origin );
        var_18 setmodel( "cli_vista_tower_elevator_02" );
        var_18.angles = var_17.angles;
        thread startelevatoranims( var_18, "tower05", "car01", 5.56 );
        waitframe();
    }

    foreach ( var_17 in var_13 )
    {
        var_21 = spawn( "script_model", var_17.origin );
        var_21 setmodel( "cli_vista_tower_elevator_02" );
        var_21.angles = var_17.angles;
        thread startelevatoranims( var_21, "tower05", "car02", 16.73 );
        waitframe();
    }

    foreach ( var_17 in var_14 )
    {
        var_24 = spawn( "script_model", var_17.origin );
        var_24 setmodel( "cli_vista_tower_elevator_02" );
        var_24.angles = var_17.angles;
        thread startelevatoranims( var_24, "tower05", "car03", 12.23 );
        waitframe();
    }

    foreach ( var_17 in var_15 )
    {
        var_27 = spawn( "script_model", var_17.origin );
        var_27 setmodel( "cli_vista_tower_elevator_02" );
        var_27.angles = var_17.angles;
        thread startelevatoranims( var_27, "tower05", "car04", 0.0 );
        waitframe();
    }
}

startelevatoranims( var_0, var_1, var_2, var_3 )
{
    wait(var_3);
    var_0 scriptmodelplayanim( "cli_elevator_" + var_1 + "_" + var_2 );
}

_id_2FE7()
{
    level endon( "game_ended" );
    maps\mp\_dynamic_events::_id_7F59( 0.5 );
    setdvar( "scr_dynamic_event_start_perc", level._id_2FE6["start_percent"] );
    var_0 = getent( "toxic_water_trigger", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 = getentarray( "out_of_bounds", "targetname" );
    var_2 = "nil";

    foreach ( var_4 in var_1 )
    {
        if ( var_4.script_noteworthy == "toxic_water_objective_trigger" )
            var_2 = var_4;
    }

    if ( isdefined( var_2 ) )
        var_2 common_scripts\utility::trigger_off();

    level.cancelbadwaterspawns = 0;
    level.wateristoxic = 0;
    level.ventishot = 0;
    level.toxiceventstarted = 0;
    level.toxiceventcomplete = 0;
    level.toxicquake = common_scripts\utility::getstruct( "toxic_quake", "targetname" );
}

startdynamicevent()
{
    level endon( "game_ended" );
    level.toxiceventstarted = 1;
    var_0 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_0 playsound( "climate_event_warn" );
    level.cancelbadwaterspawns = 1;
    wait 4.9;
    thread starttoxicquake( 0.3, 1.0 );
    wait 0.1;
    level.toxicstage1finished = 1;
    thread disconnectnodesslowly();
    aud_event_explosion_warning();
    aud_event_explosion( 1 );
    thread maps\mp\mp_climate_3_fx::top_vent_damage_fx();
    wait 0.1;
    level.toxicstage2finished = 1;

    if ( level.nextgen )
    {
        thread maps\mp\mp_climate_3_fx::clear_water_transition_fx();
        thread maps\mp\mp_climate_3_fx::clear_water_transition_looping_fx();
    }

    thread maps\mp\mp_climate_3_fx::electrical_arcs_fx();
    thread maps\mp\mp_climate_3_fx::electrical_arc_coils_fx();
    wait 0.1;
    level.toxicstage3finished = 1;
    thread maps\mp\mp_climate_3_fx::toxic_vent_steam_fx();
    thread maps\mp\mp_climate_3_fx::small_toxic_vent_steam_fx();
    thread maps\mp\mp_climate_3_fx::machine_toxic_window_fx();
    wait 0.7;
    thread starttoxicquake( 0.3, 1.0 );
    wait 0.1;
    level.toxicstage4finished = 1;
    thread maps\mp\mp_climate_3_fx::vent_metal_shards_fx();
    thread maps\mp\mp_climate_3_fx::vent_firecrawl_fx();

    foreach ( var_2 in level.players )
        var_2 thread dyneventflash();

    thread aud_event_explosion( 2 );
    wait 0.1;
    thread setuptoxicwater( 1 );
    wait 0.85;
    level.toxicstage5finished = 1;
    thread maps\mp\mp_climate_3_fx::machine_toxic_pipes_fx();
    wait 1.25;
    thread starttoxicquake( 0.6, 2.0 );
    wait 0.1;
    thread aud_toxic_water_boil_activate();
    var_4 = getent( "machine_vent_pristine", "targetname" );
    var_4 setmodel( "cli_climate_control_machine_vent_dstry2" );
    aud_event_explosion( 3 );
    level.ventishot = 1;

    if ( isdefined( level.players ) )
    {
        foreach ( var_2 in level.players )
            var_2 thread check_vent_damage();
    }

    if ( level.nextgen )
        thread maps\mp\mp_climate_3_fx::water_transition_fx();

    wait 0.1;
    level.toxicstage6finished = 1;
    thread maps\mp\mp_climate_3_fx::dead_fish_fx();

    if ( level.nextgen )
        thread maps\mp\mp_climate_3_fx::toxic_waterfall_start();

    wait 1.9;
    level.toxicstage7finished = 1;
    thread maps\mp\mp_climate_3_fx::vent_smoke_damage_fx();
    wait 1;
    wait 1;
    wait 1;
    wait 1;
    var_0 playsound( "climate_event_finished" );
    wait 1;
    wait 1;
    wait 0.3;
    thread maps\mp\mp_climate_3_fx::less_freq_electrical_sparks_fx();
    thread maps\mp\mp_climate_3_fx::water_surface_steam_fx();
    level.toxiceventcomplete = 1;
}

check_vent_damage()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = getent( "hot_vent", "targetname" );

    for (;;)
    {
        if ( self istouching( var_0 ) )
        {
            while ( isalive( self ) && self istouching( var_0 ) )
            {
                self dodamage( 5, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "none", "none" );
                wait 0.1;
                maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
            }
        }

        waitframe();
    }
}

enddynamicevent()
{
    var_0 = getent( "machine_vent_pristine", "targetname" );
    var_0 setmodel( "cli_climate_control_machine_vent_dstry2" );
    level.toxiceventcomplete = 1;
    level.cancelbadwaterspawns = 1;
    thread disconnectnodesslowly();
    thread setuptoxicwater( 0 );
}

setuptoxicwater( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    level.wateristoxic = 1;
    var_1 = getent( "toxic_water_trigger", "targetname" );
    var_1 common_scripts\utility::trigger_on();
    var_2 = getentarray( "out_of_bounds", "targetname" );
    var_3 = "nil";

    foreach ( var_5 in var_2 )
    {
        if ( var_5.script_noteworthy == "toxic_water_objective_trigger" )
            var_3 = var_5;
    }

    if ( isdefined( var_3 ) )
    {
        var_3 common_scripts\utility::trigger_on();
        var_3 childthread handle_ball_water_return();
    }

    var_7 = getentarray( "water_good", "targetname" );

    foreach ( var_9 in var_7 )
        var_9 delete();

    if ( var_0 )
        moveallbadwater( ( 0.0, 0.0, 12000.0 ) );

    if ( isdefined( level.players ) )
    {
        foreach ( var_12 in level.players )
            var_12 thread handle_toxic_water_damage();
    }

    thread setupsupportdropvolumes( var_1 );
}

disconnectnodesslowly()
{
    var_0 = getnodearray( "water_node", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    var_2 = getnodearray( "water_node", "script_noteworthy" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        var_2[var_1] _meth_8059();

        if ( var_1 % 50 == 0 )
            waitframe();
    }

    waitframe();
    disconnectnodepairs( var_0 );
}

disconnectnodepairs( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_3 = [];
        var_3 = getlinkednodes( var_2, 1 );

        if ( var_3.size > 0 )
        {
            foreach ( var_5 in var_3 )
                disconnectnodepair( var_2, var_5 );
        }
    }
}

setupsupportdropvolumes( var_0 )
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_0;

    while ( !isdefined( level.goliath_bad_landing_volumes ) )
        waitframe();

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
}

handle_ball_water_return()
{
    var_0 = self;

    if ( isdefined( level.balls ) && level.balls.size != 0 )
    {
        for (;;)
        {
            foreach ( var_2 in level.balls )
            {
                if ( isdefined( var_2.visuals[0] ) && var_2.visuals[0] istouching( var_0 ) )
                    var_2 thread maps\mp\gametypes\_gameobjects::returnhome();
            }

            wait 2;
        }
    }
}

starttoxicquake( var_0, var_1 )
{
    earthquake( var_0, var_1, level.toxicquake.origin, 3500 );
    toxic_quake_rumble( var_1 );
}

toxic_quake_rumble( var_0 )
{
    level notify( "Toxic_Quake_End" );
    waittillframeend;

    foreach ( var_2 in level.players )
    {
        if ( isalive( var_2 ) )
            var_2 thread toxic_quake_rumble_player( var_0 );
    }
}

toxic_quake_rumble_player( var_0 )
{
    level endon( "Toxic_Quake_End" );
    var_1 = "tank_rumble";
    var_2 = "heavygun_fire";
    var_3 = "smg_fire";
    self _meth_80AE( var_1 );
    thread watch_toxic_rumble_end( var_1, var_0 );
    var_4 = 0;

    if ( distancesquared( level.toxicquake.origin, self.origin ) < 1210000 )
    {
        self playrumbleonentity( var_2 );
        var_4 = 1;
    }

    if ( !var_4 && distancesquared( level.toxicquake.origin, self.origin ) < 6250000 )
        self playrumbleonentity( var_3 );
}

watch_toxic_rumble_end( var_0, var_1 )
{
    level endon( "Toxic_Quake_End" );
    self endon( "disconnect" );
    thread watch_toxic_rumble_end_early( var_0 );

    while ( var_1 > 0.0 )
    {
        var_1 -= 0.05;
        wait 0.05;
    }

    self stoprumble( var_0 );
    self notify( "Toxic_Quake_Rumble_End" );
}

watch_toxic_rumble_end_early( var_0 )
{
    self endon( "Toxic_Quake_Rumble_End" );
    self endon( "disconnect" );
    level waittill( "Toxic_Quake_End" );
    self stoprumble( var_0 );
}

handle_toxic_water_damage()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 = getent( "toxic_water_trigger", "targetname" );

    for (;;)
    {
        if ( self istouching( var_0 ) )
        {
            var_1 = 0;

            while ( isalive( self ) && self istouching( var_0 ) )
            {
                if ( var_1 == 0 )
                {
                    self shellshock( "mp_climate_acid", 5, 0, 0, 0 );
                    var_1 = 1;
                }

                self dodamage( 5, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "none", "none" );
                wait 0.1;
                maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
            }

            self _meth_8185();
        }

        waitframe();
    }
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();

        if ( level.wateristoxic )
            var_0 thread handle_toxic_water_damage();

        if ( level.ventishot )
            var_0 thread check_vent_damage();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        thread aud_toxic_water_boil_setup();
    }
}

_id_8A06()
{
    level.dynamicspawns = ::_id_4005;
}

_id_4005( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 _id_51F4() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

_id_51F4()
{
    if ( ( level.cancelbadwaterspawns == 1 || level.wateristoxic == 1 ) && self.targetname == "water_spawn" )
        return 0;

    return 1;
}

climatepaladinoverrides()
{
    level._id_6574._id_89DC = 9279;
    level._id_6574._id_8A00 = 8000;
    level._id_6574._id_8989 = 312;
}

aud_event_explosion_warning()
{
    var_0 = 30;
    maps\mp\_audio::_id_873B( "climate3_event_alarm_lp", ( -1150.0, -1030.0, 1065.0 ), "aud_stop_alarm_loops", var_0 );
}

aud_event_explosion( var_0 )
{
    var_1 = 20;
    var_2 = 5;

    if ( var_0 == 1 )
    {
        maps\mp\_audio::_id_8730( "climate3_event_explo_01", ( -1150.0, -1030.0, 1065.0 ) );
        maps\mp\_audio::_id_8730( "climate3_event_explo_deep", ( -1150.0, -1030.0, 1065.0 ) );
        maps\mp\_audio::_id_8730( "climate3_event_explo_metal", ( -1150.0, -1030.0, 1065.0 ) );
        maps\mp\_audio::_id_8730( "climate3_event_explo_machine", ( -1150.0, -1030.0, 1065.0 ) );
        level.aud_event_started = 1;
        wait 2;
        maps\mp\_audio::_id_8730( "climate3_event_explo_metal_2", ( -1150.0, -1030.0, 1065.0 ) );
    }

    if ( var_0 == 2 )
    {
        thread aud_event_start_loops();
        maps\mp\_audio::_id_8730( "climate3_event_explo_02", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        maps\mp\_audio::_id_8730( "climate3_event_explo_02_debris", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        wait 0.2;
        maps\mp\_audio::_id_8730( "climate3_event_explo_01", ( -1150.0, -1030.0, 1065.0 ), var_1, var_2 );
        wait 0.3;
        maps\mp\_audio::_id_8730( "climate3_event_explo_01", ( -1150.0, -1030.0, 1065.0 ), var_1, var_2 );
        maps\mp\_audio::_id_8730( "climate3_event_explo_02", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        maps\mp\_audio::_id_8730( "climate3_event_explo_03", ( -684.0, -617.0, 1267.0 ), var_1, var_2 );
        wait 0.5;
        maps\mp\_audio::_id_8730( "climate3_event_explo_01", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        wait 0.3;
        maps\mp\_audio::_id_8730( "climate3_event_explo_02", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        maps\mp\_audio::_id_8730( "climate3_event_explo_03", ( -684.0, -617.0, 1267.0 ), var_1, var_2 );
    }

    if ( var_0 == 3 )
    {
        maps\mp\_audio::_id_8730( "climate3_event_explo_final", ( -630.0, -580.0, 897.0 ), var_1, var_2 );
        level notify( "aud_stop_alarm_loops" );
    }
}

aud_event_start_loops()
{
    if ( level.aud_event_started == 1 )
    {
        var_0 = [ ( -723.0, -496.0, 969.0 ), ( -573.0, -643.0, 840.0 ), ( -639.0, -592.0, 777.0 ), ( -595.0, -668.0, 538.0 ), ( -730.0, -497.0, 775.0 ), ( -652.0, -590.0, 546.0 ), ( -699.0, -496.0, 939.0 ), ( -692.0, -510.0, 778.0 ), ( -568.0, -662.0, 646.0 ), ( -702.0, -521.0, 577.0 ), ( -1184.0, -1047.0, 959.0 ) ];
        wait 0.1;

        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            maps\mp\_audio::_id_873B( "climate3_event_fire_lp", var_0[var_1], "aud_stop_fire_loops" );

            if ( var_1 % 3 == 2 )
                wait 0.1;
        }
    }
}

aud_toxic_water_boil_setup()
{
    if ( !level.wateristoxic )
        self _meth_84D7( "mp_pre_event_mix", 1 );
    else
        self _meth_84D7( "mp_post_event_mix", 1 );
}

aud_toxic_water_boil_activate()
{
    foreach ( var_1 in level.players )
    {
        var_1 _meth_84D8( "mp_pre_event_mix", 1 );
        var_1 _meth_84D7( "mp_post_event_mix", 1 );
        wait 0.05;
    }
}

dyneventflash()
{
    self visionsetnakedforplayer( "mp_climate_3_dynEventFlash", 0.6 );
    thread endvisionondeath();
    wait 0.25;
    level notify( "end_flash" );
    thread maps\mp\_utility::revertvisionsetforplayer( 1.25 );
}

endvisionondeath()
{
    level endon( "end_flash" );
    self waittill( "death" );
    thread maps\mp\_utility::revertvisionsetforplayer( 0 );
}
