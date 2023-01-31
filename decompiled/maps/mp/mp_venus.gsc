// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_venus_precache::main();
    maps\createart\mp_venus_art::main();
    maps\mp\mp_venus_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_venus_lighting::main();
    maps\mp\mp_venus_aud::main();
    level.aerial_pathnode_offset = 600;
    level.aerial_pathnode_group_connect_dist = 300;
    level.aerial_pathnodes_force_connect[0] = spawnstruct();
    level.aerial_pathnodes_force_connect[0].origin = ( -618, -1166, 1123 );
    level.aerial_pathnodes_force_connect[0].radius = 250;
    level.aerial_pathnodes_force_connect[1] = spawnstruct();
    level.aerial_pathnodes_force_connect[1].origin = ( -944, 845, 1245 );
    level.aerial_pathnodes_force_connect[1].radius = 300;
    maps\mp\_compass::setupminimap( "compass_map_mp_venus" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    maps\mp\_water::init();
    level.ospvisionset = "mp_venus_osp";
    level.warbirdvisionset = "mp_venus_osp";
    level.vulcanvisionset = "mp_venus_osp";
    var_0 = getnodearray( "pool_nodes", "targetname" );

    foreach ( var_2 in var_0 )
        _func_2C0( var_2, 1 );

    level.orbitalsupportoverridefunc = ::venuscustomospfunc;
    thread venuscustomairstrike();
    thread handle_glass_pathing();
    thread scriptpatchclip();
    thread scriptpatchkilltrigger();
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
}

scriptpatchkilltrigger()
{
    thread spawnkilltriggerthink( ( -965.5, -1035.5, 316 ), 286, 92 );
    thread spawnkilltriggerthink( ( -914.5, -1001.5, 572 ), 242, 48 );
    thread spawnkilltriggerthink( ( -912, -976, 572 ), 242, 48 );
    thread spawnkilltriggerthink( ( -955, -1008, 660 ), 282, 4 );
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

scriptpatchclip()
{
    thread barpatchclip();
    thread railingpatchclip();
    thread roofcurvedglasspatchclip();
    thread columnandturtlepatchclip();
    thread wallbreachrockroompatchclip();
    thread wallbreachwoodenstrippatchclip();
    thread exteriorcurvedwallpatchclip();
    thread exteriorwindowpatchclip();
    thread wallbreachwoodenstrippatchclip2();
    thread jumpthroughceilingpatchclip();
    thread marshmmllowbuildingpatchclip();
    thread marshmmllowbuildingpatchclip_2();
    thread receptionpillarinside();
    thread anotherradiusdeathtriggerinamashmellow();
}

anotherradiusdeathtriggerinamashmellow()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( -1015, -969, 836 ), 0, 130, 90 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        var_1 _meth_8051( var_1.health + 999, var_0.origin );
    }
}

receptionpillarinside()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( 956, -354, 574 ), 0, 32, 256 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        var_1 _meth_8051( var_1.health + 999, var_0.origin );
    }
}

marshmmllowbuildingpatchclip_2()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1060, -1101, 745 ), ( 0.499964, 45.3985, 1.39991 ) );
}

marshmmllowbuildingpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -693, -1127, 688 ), ( 90, 358.027, 15.7332 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -682, -1073, 688 ), ( 90, 357.495, 5.80108 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -677, -1015, 688 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -685, -960, 688 ), ( 90, 1.66172, -8.83289 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -701, -907, 688 ), ( 90, 5.52962, -17.265 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -823, -774, 688 ), ( 90, 22.7938, -41.6976 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -875, -756, 688 ), ( 90, 15.0314, -58.8594 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -932, -743, 688 ), ( 90, 10.9855, -71.2122 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -988, -743, 688 ), ( 90, 1.02405, -91.6673 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1042, -752, 688 ), ( 90, 29.8449, -75.1468 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1094, -773, 688 ), ( 90, 28.3374, -88.3533 ) );
}

jumpthroughceilingpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1356, 304, 1117 ), ( 0, 312.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1326, 164, 1191 ), ( 90, 312, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1136, 334, 1191 ), ( 90, 312, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -984, 384, 1191 ), ( 90, 88, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -832, 338, 1191 ), ( 90, 52, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -664, 174, 1191 ), ( 90, 226, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -566, 58, 1191 ), ( 90, 226, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -766, -224, 1191 ), ( 90, 222.8, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -934, -352, 1191 ), ( 90, 204.8, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1136, -428, 1191 ), ( 90, 8.8, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1236, -380, 1191 ), ( 90, 224.8, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1326, -292, 1191 ), ( 90, 224.8, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1382, -166, 1191 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1382, 42, 1191 ), ( 90, 358, 0 ) );
}

exteriorwindowpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1412, -348, 1072 ), ( 0, 45, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1308, -452, 1072 ), ( 0, 45, 0 ) );
}

exteriorcurvedwallpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258, 474, 1382 ), ( 0, 296, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1258, 474, 1126 ), ( 0, 296, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1482, 358, 1126 ), ( 0, 300, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1482, 358, 1382 ), ( 0, 300, 0 ) );
}

wallbreachwoodenstrippatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 966.5, -842, 731.5 ), ( 270, 0, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 966.5, -840, 724 ), ( 270, 0, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 947.5, -842, 731.5 ), ( 270, 0, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 947.5, -840, 724 ), ( 270, 0, -180 ) );
}

wallbreachwoodenstrippatchclip2()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 965.5, -1590, 731.5 ), ( 270, 180, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 946.5, -1590, 731.5 ), ( 270, 180, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 965.5, -1592, 724 ), ( 270, 180, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 946.5, -1592, 724 ), ( 270, 180, -180 ) );
}

wallbreachrockroompatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -348, 240, 1104 ), ( 0, 240, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -348, 240, 1360 ), ( 0, 240, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -551, 368, 1360 ), ( 0, 235.6, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -551, 368, 1104 ), ( 0, 235.6, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -124, 173, 1104 ), ( 0, 265.7, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -124, 173, 1360 ), ( 0, 265.7, 0 ) );
}

columnandturtlepatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1784, 244, 1032 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1784, 208, 1032 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -1712, 244, 1032 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1784, 148, 1192 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712, 148, 1192 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1784, 148, 1448 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712, 148, 1448 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1854, 748, 1236 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1614, 748, 1236 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1734, 868, 1236 ), ( 0, 90, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1734, 628, 1236 ), ( 0, 90, 0 ) );
}

barpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 136, 116, 828 ), ( 0, 0, 0 ) );
}

railingpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1595, -1009, 566 ), ( 0, 343.2, 0 ) );
}

roofcurvedglasspatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1382, -106, 972 ), ( 317.767, 318.557, -0.78 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1226, -278, 976 ), ( 317.767, 318.557, -0.78 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1066, -422, 980 ), ( 318, 296, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 898, -444, 1020 ), ( 318, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 714, -390, 1020 ), ( 318, 238, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 978, -516, 958 ), ( 0, 88, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 850, -502, 958 ), ( 0, 258, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 978, -516, 702 ), ( 0, 88, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 850, -502, 702 ), ( 0, 258, 0 ) );
}

venuscustomairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2100;
}

venuscustomospfunc()
{
    level.orbitalsupportoverrides.toparc = -39;
    level.orbitalsupportoverrides.spawnheight = 9563.06;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 20;
        level.orbitalsupportoverrides.rightarc = 20;
        level.orbitalsupportoverrides.toparc = -35;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

handle_glass_pathing()
{
    var_0 = getglassarray( "skylights" );
    var_1 = getentarray( "skylights", "targetname" );
    var_2 = getentarray( "glass_pathing", "targetname" );

    if ( !isdefined( var_1 ) )
        return 0;

    var_3 = 8;

    foreach ( var_5 in var_0 )
    {
        var_6 = getglassorigin( var_5 );

        foreach ( var_8 in var_1 )
        {
            if ( distance( var_6, var_8.origin ) <= var_3 )
            {
                var_8.glass_id = var_5;
                break;
            }
        }
    }

    common_scripts\utility::array_thread( var_1, ::handle_pathing_on_glass );
}

handle_pathing_on_glass()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_0 common_scripts\utility::trigger_off();
    var_0 _meth_8058();
    waittill_glass_break( self.glass_id );
    var_0 common_scripts\utility::trigger_on();
    var_0 _meth_8057();
    var_0 common_scripts\utility::trigger_off();
}

waittill_glass_break( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( isglassdestroyed( var_0 ) )
            return 1;

        wait 0.05;
    }
}
