// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::blackbox_callbackstartgametype;
    maps\mp\mp_blackbox_precache::main();
    maps\createart\mp_blackbox_art::main();
    maps\mp\mp_blackbox_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_blackbox_lighting::main();
    maps\mp\mp_blackbox_aud::main();
    maps\mp\_compass::_id_831E( "compass_map_mp_blackbox" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level._id_65AB = "mp_blackbox_osp";
    level._id_65A9 = "mp_blackbox_osp";
    level._id_2F3B = "mp_blackbox_drone";
    level._id_2F12 = "mp_blackbox_drone";
    level._id_A197 = "mp_blackbox_warbird";
    level._id_A18C = "mp_blackbox_warbird";
    level._id_5985 = ::blackboxcustomkillstreakfunc;
    level._id_6573 = ::blackboxcustomospfunc;
    thread blackboxcustomairstrike();
    level._id_655B = ::blackboxcustomorbitallaserfunc;
    thread surface_light_relocation();
    level thread resetuplinkballoutofbounds();
    level thread patchclip();
}

patchclip()
{
    thread grappleshipclip01();
    thread grappleshipclip02();
    thread grappleshipclip03();
    thread grappleshipclip04();
    thread grappleshipclip05();
    thread spectateshipclip01();
    thread grappleexteriordebris01();
    thread grappleexteriorship01();
    thread grapplerock01();
    thread droneterrainclip();
    thread cockpitgrappleclip();
}

grappleshipclip05()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -581.0, -1713.0, 1788.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -581.0, -1713.0, 1660.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -581.0, -1713.0, 1532.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -581.0, -1713.0, 1404.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -537.0, -1593.0, 1788.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -537.0, -1593.0, 1660.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -537.0, -1593.0, 1532.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -537.0, -1593.0, 1404.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -476.0, -1752.0, 1788.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -476.0, -1752.0, 1660.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -476.0, -1752.0, 1532.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -476.0, -1752.0, 1404.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -433.0, -1632.0, 1788.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -433.0, -1632.0, 1660.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -433.0, -1632.0, 1532.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -433.0, -1632.0, 1404.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -389.0, -1512.0, 1788.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -389.0, -1512.0, 1660.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -389.0, -1512.0, 1532.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -389.0, -1512.0, 1404.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -355.0, -1673.0, 1818.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -355.0, -1673.0, 1690.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -355.0, -1673.0, 1562.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -311.0, -1553.0, 1818.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -311.0, -1553.0, 1690.0 ), ( 0.0, 250.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( -311.0, -1553.0, 1562.0 ), ( 0.0, 250.0, 0.0 ) );
}

spectateshipclip01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 752.0, -1012.0, 1432.0 ), ( 89.9999, 38.8699, -31.1302 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 692.0, -1178.0, 1432.0 ), ( 89.9999, 38.8699, -31.1302 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_128_128", ( 586.0, -1020.0, 1498.0 ), ( 0.0, 69.9994, 0.0 ) );
}

grappleshipclip04()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 646.0, -452.0, 1420.0 ), ( 0.0, 29.1973, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 646.0, -452.0, 1676.0 ), ( 0.0, 29.1973, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 646.0, -452.0, 1932.0 ), ( 0.0, 29.1973, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 672.0, -444.0, 1932.0 ), ( 0.0, 19.1973, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 672.0, -444.0, 1676.0 ), ( 0.0, 19.1973, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 672.0, -444.0, 1420.0 ), ( 0.0, 19.1973, 0.0 ) );
}

grapplerock01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1022.0, 1918.0, 1237.0 ), ( 0.0, 2.69981, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1034.0, 1663.0, 1237.0 ), ( 0.0, 2.69981, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1034.0, 1663.0, 1493.0 ), ( 0.0, 2.69981, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1022.0, 1918.0, 1493.0 ), ( 0.0, 2.69981, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 1034.0, 1663.0, 1237.0 ), ( 0.0, 2.69981, 0.0 ) );
}

grappleshipclip01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 955.0, 34.5, 1574.0 ), ( 0.0, 244.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 955.0, 34.5, 1830.0 ), ( 0.0, 244.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 955.0, 34.5, 2086.0 ), ( 0.0, 244.0, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 955.0, 34.5, 2342.0 ), ( 0.0, 244.0, 0.0 ) );
}

grappleshipclip02()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 1468.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 1596.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 1724.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 1852.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 1980.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1083.99, -2538.42, 2108.0 ), ( 0.0, 157.1, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 1468.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 1596.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 1724.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 1852.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 1980.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1098.6, -2448.2, 2108.0 ), ( 0.0, 207.7, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1215.06, -2369.69, 1532.0 ), ( 0.0, 253.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1215.06, -2369.69, 1788.0 ), ( 0.0, 253.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1215.06, -2369.69, 2044.0 ), ( 0.0, 253.3, 0.0 ) );
}

grappleshipclip03()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -170.0, 76.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -282.0, 306.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -334.0, 412.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 398.0, 314.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 286.0, 544.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 228.0, 664.0, 1212.0 ), ( 90.0, 297.479, 1.4795 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -158.0, 24.0, 1186.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -28.0, 26.0, 1186.0 ), ( 0.0, 251.998, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 42.0, -20.0, 1268.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 330.0, 200.0, 1186.0 ), ( 0.0, 339.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 408.0, 292.0, 1186.0 ), ( 0.0, 295.999, 0.0 ) );
}

grappleexteriordebris01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1436.0, -2710.0, 1612.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1436.0, -2710.0, 1868.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1436.0, -2710.0, 2124.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_grapple_16_256_256", ( 1430.0, -2710.0, 1612.0 ), ( 0.0, 295.999, 0.0 ) );
}

grappleexteriorship01()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -514.0, 486.0, 1760.0 ), ( 0.0, 295.999, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -514.0, 486.0, 1504.0 ), ( 0.0, 295.999, 0.0 ) );
}

droneterrainclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1320.71, -3140.18, 1344.0 ), ( 270.0, 184.081, 67.9193 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1399.82, -2896.71, 1344.0 ), ( 270.0, 184.081, 67.9193 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1643.29, -2975.82, 1344.0 ), ( 270.0, 184.081, 67.9193 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1564.18, -3219.29, 1344.0 ), ( 270.0, 184.081, 67.9193 ) );
}

cockpitgrappleclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -252.0, 2332.0, 854.0 ), ( 296.672, 48.4086, -64.9689 ) );
}

resetuplinkballoutofbounds()
{
    level endon( "game_ended" );

    if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread _id_A200();
    }
}

_id_A200()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;
        thread monitorballstate();
        var_0 = common_scripts\utility::waittill_any_return( "pickup_object", "reset" );
    }
}

monitorballstate()
{
    self endon( "pickup_object" );
    self endon( "reset" );

    for (;;)
    {
        if ( _id_5168() )
        {
            thread maps\mp\gametypes\_gameobjects::returnhome();
            return;
        }

        wait 0.05;
    }
}

_id_5168()
{
    var_0 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_0[var_1] ) )
            continue;

        return 1;
    }

    return 0;
}

blackbox_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

blackboxcustomkillstreakfunc()
{
    level._id_53AB["iw5_dlcgun12loot4_mp"] = 1;
    level thread maps\mp\killstreaks\streak_mp_blackbox::streak_init();
}

surface_light_relocation()
{
    var_0 = getentarray( "alien_green_surface_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 hide();
}

blackboxcustomospfunc()
{
    level._id_6574._id_898B = 10;
    level._id_6574._id_898A = 70;
    level._id_6574._id_89DC = 9000;

    if ( level.currentgen )
    {
        level._id_6574._id_0252 = 20;
        level._id_6574._id_0380 = 20;
        level._id_6574._id_04BD = -30;
        level._id_6574._id_0089 = 60;
    }
}

blackboxcustomairstrike()
{
    if ( !isdefined( level._id_099D ) )
        level._id_099D = spawnstruct();

    level._id_099D._id_89DC = 6000;
}

blackboxcustomorbitallaserfunc()
{
    level._id_655C._id_89DC = 3500;
}
