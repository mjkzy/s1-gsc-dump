// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_detroit_precache::main();
    maps\createart\mp_detroit_art::main();
    maps\mp\mp_detroit_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_detroit_lighting::main();
    maps\mp\mp_detroit_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_detroit" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    maps\mp\_water::setshallowwaterweapon( "iw5_underwater_mp" );
    maps\mp\_water::init();
    level.ospvisionset = "(mp_detroit_osp)";
    level.osplightset = "(mp_detroit_osp)";
    level.dronevisionset = "(mp_detroit_drone)";
    level.dronelightset = "(mp_detroit_drone)";
    level.warbirdvisionset = "(mp_detroit_warbird)";
    level.warbirdlightset = "(mp_detroit_warbird)";
    level.aerial_pathnode_offset = 425;
    level thread maps\mp\mp_detroit_events::trams();
    level.mapcustomkillstreakfunc = ::detroitcustomkillstreakfunc;
    level.orbitalsupportoverridefunc = ::detroitpaladinoverrides;
    level thread detroitstrikeheightoverrides();
    level thread detroitpatchclip();
    level thread scriptpatchkilltrigger();
    thread set_lighting_values();
}

detroitstrikeheightoverrides()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2500;
    setdvar( "bg_bombingRunNoMissileClip", 1 );
}

detroitpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnanglemin = 220;
    level.orbitalsupportoverrides.spawnanglemax = 260;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 15;
        level.orbitalsupportoverrides.rightarc = 15;
        level.orbitalsupportoverrides.toparc = -35;
        level.orbitalsupportoverrides.bottomarc = 55;
    }
}

detroitcustomkillstreakfunc()
{
    level thread maps\mp\killstreaks\streak_mp_detroit::init();
}

detroitpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 697.5 ), ( 0, 353.054, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1440.64, -10.0738, 569.5 ), ( 0, 353.054, 0 ) );
    thread tirevehiclecollision();
    thread umbrawallcollision();
    thread cornerbuildingoutofworld();
    thread jumpovermaingate();
    thread jumpoversidegate();
    thread uplinkballbarrier();
    thread buildingexeriorclip();
    thread jumpontramsupport();
    thread cornerjump();
    thread centerbuildingwalljump();
    thread wigglewallcurve();
}

scriptpatchkilltrigger()
{
    thread spawnkilltriggerthink( ( -8, 368, 1200 ), 4096, 256 );
}

spawnkilltriggerthink( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = spawn( "trigger_radius", var_0, 0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return;

    for (;;)
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( var_4 ) && isplayer( var_4 ) && isdefined( var_4.health ) )
            var_4 _meth_8051( var_4.health + 999, var_3.origin );
    }
}

wigglewallcurve()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1620, 840, 720 ), ( 0, 344, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1580, 900, 720 ), ( 0, 318, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1522, 942, 720 ), ( 0, 298, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1488, 956, 720 ), ( 0, 278, 0 ) );
}

centerbuildingwalljump()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -446, 198, 1054 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -446, 198, 1310 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -468, 180, 1310 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -468, 180, 1054 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -724, 180, 1310 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -724, 180, 1054 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -980, 180, 1054 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -980, 180, 1310 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1100, 300, 1500 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1100, 300, 1244 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -998, 362, 1500 ), ( 0, 126, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -998, 362, 1244 ), ( 0, 126, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1004, 462, 1310 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1004, 462, 1054 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1004, 880, 1310 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1004, 880, 1054 ), ( 0, 180, 0 ) );
}

cornerjump()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -181, 299, 1012 ), ( 0, 312.7, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -181, 299, 1268 ), ( 0, 312.7, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 916 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 980 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1044 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1108 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1172 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1236 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1300 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -90, 412, 1364 ), ( 0, 0, 0 ) );
}

jumpontramsupport()
{
    stackclip( ( 0, 0, 0 ), ( 857, 1738, 940 ), 64, "patchclip_player_64_64_64", 5 );
    stackclip( ( 0, 0, 0 ), ( 857, 1717, 940 ), 64, "patchclip_player_64_64_64", 5 );
    stackclip( ( 0, 0, 0 ), ( 887, 1717, 940 ), 64, "patchclip_player_64_64_64", 5 );
    stackclip( ( 0, 0, 0 ), ( 887, 1738, 940 ), 64, "patchclip_player_64_64_64", 5 );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 1103, 1613, 1118 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_128_128_128", ( 1103, 1613, 1246 ), ( 0, 0, 0 ) );
}

stackclip( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_4; var_6++ )
    {
        maps\mp\_utility::spawnpatchclip( var_3, var_1 + ( 0, 0, var_5 ), var_0 );
        var_5 += var_2;
    }
}

buildingexeriorclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 962, -4, 1374 ), ( 0, 266, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 962, -4, 1118 ), ( 0, 266, 0 ) );
}

uplinkballbarrier()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( 465, 1402, 663 ), ( 0, 280.5, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( 588, 1413, 663 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( 481, 1389, 652 ), ( 0, 280.5, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_128_128", ( 587, 1398, 655 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( 629, 1372, 719 ), ( 90, 333.435, -26.5651 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( 629, 1346, 719 ), ( 90, 333.435, -26.5651 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_item_16_64_64", ( 631, 1346, 679 ), ( 0, 0, 0 ) );
}

jumpovermaingate()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1544, -1638, 1156 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1776, -1654, 1156 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2032, -1654, 1156 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2250, -1638, 1156 ), ( 0, 270, 0 ) );
}

jumpoversidegate()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2358, 36, 1156 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2358, -220, 1156 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2358, -476, 1156 ), ( 0, 0, 0 ) );
}

tirevehiclecollision()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_128_128_128", ( 1738, 2530, 588 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_64_64_64", ( 1692, 2540, 664 ), ( 0, 346, 0 ) );
}

umbrawallcollision()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -2246.5, -1658, 562 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -2186.5, -1658, 562 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1589.5, -1658, 562 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1529.5, -1658, 562 ), ( 0, 0, 0 ) );
}

cornerbuildingoutofworld()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -190, 2594, 1236 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -310, 2474, 1236 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -566, 2474, 1236 ), ( 0, 270, 0 ) );
}

set_lighting_values()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 _meth_82FD( "r_tonemap", "1", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0" );
        }
    }
}
