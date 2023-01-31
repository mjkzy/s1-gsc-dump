// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_greenband_precache::main();
    maps\createart\mp_greenband_art::main();
    maps\mp\mp_greenband_fx::main();
    maps\mp\_load::main();
    thread setup_audio();
    maps\mp\_compass::setupminimap( "compass_map_mp_greenband" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    setdvar( "r_diffuseColorScale", 1.5 );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );
    level.ospvisionset = "(mp_greenband_osp)";
    level.osplightset = "(mp_greenband_osp)";
    level.dronevisionset = "(mp_greenband_drone)";
    level.dronelightset = "(mp_greenband_drone)";
    level.warbirdvisionset = "(mp_greenband_warbird)";
    level.warbirdlightset = "(mp_greenband_warbird)";
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level.nextgen )
        level.aerial_pathnode_group_connect_dist = 600;

    level thread maps\mp\_water::init();
    level thread greenband_drones();

    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 2500;
    level.orbitalsupportoverridefunc = ::greenbandcustomospfunc;
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    level thread greenbandpatchclip();
    level thread greenbanddisconnectnodes();
    level thread fixupremotemissileentsonnodes();
    level thread killdronesunderbuilding();
}

killdronesunderbuilding()
{
    if ( !isdefined( level.vehicle_kill_triggers ) )
        level.vehicle_kill_triggers = [];

    level.vehicle_kill_triggers[level.vehicle_kill_triggers.size] = spawn( "trigger_radius", ( 1854, 660, -604 ), 16, 2048, 290 );
}

greenbandpatchclip()
{
    thread ravenpatchclip();
    thread stuckrockpatchclip();
    thread cherrytreetowallledge();
}

cherrytreetowallledge()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1440.38, 1103.35, 389.4 ), ( 0, 317.8, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1440.38, 1103.35, 509.9 ), ( 0, 317.8, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1440.38, 1103.35, 765.9 ), ( 0, 317.8, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1625.8, 1276.9, 389.4 ), ( 0, 308.4, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1625.8, 1276.9, 509.9 ), ( 0, 308.4, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1625.8, 1276.9, 765.9 ), ( 0, 308.4, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1702.8, 1180.9, 269.4 ), ( 89.9976, 340.598, 32.2021 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 1531.8, 1020.9, 269.4 ), ( 89.9975, 343.898, 26.0043 ) );
}

stuckrockpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1356, 1458, 168 ), ( 0, 310, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1382, 1398, 116 ), ( 270, 340, 4.61 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 1356, 1406, 116 ), ( 270, 340, 4.61 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1398, 1502, 104 ), ( 270, 336, 3.39997 ) );
}

ravenpatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722, -3380, 128 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722, -3380, 384 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1722, -3380, 640 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1748, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1996, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2252, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2508, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2764, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -3020, 2340, -184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( -2546, 1200.5, 152 ), ( 0, 347.9, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1559.9, 878.4, 184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 1559.9, -43.6, 184 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_64_64", ( 292, 1160, 168 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_nosight_16_64_64", ( -236, -784, -10 ), ( 270, 288.902, 86.0983 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1677.9, -43.6, 64 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1615.9, -43.6, 118 ), ( 0, 270, -34 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1677.9, 878.4, 64 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 1615.9, 878.4, 118 ), ( 0, 270, -34 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, 960, -384 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, 704, -384 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, 448, -384 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, 192, -384 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, -64, -384 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 664, -320, -384 ), ( 0, 0, 0 ) );
}

fishtankbuildinglowerclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1298, -994, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1042, -994, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 786, -994, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, -858, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, -678, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, -422, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, -166, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 90, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 346, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 602, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 858, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 1114, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 1370, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 1626, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 666, 1882, -434 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 802, 2002, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1058, 2002, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1314, 2002, -434 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1450, 2126, -434 ), ( 0, 170, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1510, 2302, -434 ), ( 0, 150, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 1670, 2492, -434 ), ( 0, 130, 0 ) );
}

greenbanddisconnectnodes()
{
    var_0 = getnodesinradiussorted( ( -78.8542, 710.082, 240 ), 256, 0 )[0];
    var_1 = getnodesinradiussorted( ( 306.854, 865.918, 240 ), 256, 0 )[0];
    disconnectnodepair( var_0, var_1 );
    var_0 = getnodesinradiussorted( ( -602.3, -535.337, 220 ), 256, 0 )[0];
    var_1 = getnodesinradiussorted( ( -869.7, -216.663, 220 ), 256, 0 )[0];
    disconnectnodepair( var_0, var_1 );
}

fixupremotemissileentsonnodes()
{
    for (;;)
    {
        maps\mp\killstreaks\_orbital_util::nodesetremotemissilenamewrapper( ( -1876, -556, 72.625 ), "none" );
        level waittill( "host_migration_begin" );
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    }
}

greenbandcustomospfunc()
{
    level.orbitalsupportoverrides.spawnheight = 9279;
    level.orbitalsupportoverrides.spawnradius = 7000;
    level.orbitalsupportoverrides.turretpitch = 50;
    level.orbitalsupportoverrides.spawnanglemin = undefined;
    level.orbitalsupportoverrides.spawnanglemax = undefined;

    if ( level.currentgen )
        level.orbitalsupportoverrides.toparc = -40;
}

setup_audio()
{
    ambientplay( "amb_gnb_ext" );
}

greenband_drones()
{
    level.drones = [];
    level thread ambient_police_drones();
    level thread vista_police_drones();
    level thread vista_police_group_drones();
}

spawn_police_drone_with_anim( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::getstruct( "event_anim_node", "targetname" );
    var_4 = spawn_police_drone( var_0 );

    if ( isdefined( var_2 ) )
    {
        for (;;)
        {
            var_4.health = 20;
            var_4 _meth_82C0( 1 );
            var_4 thread police_drone_play_anim( var_1, var_2, var_0, var_3 );
            var_4 waittill( "death" );
            var_4 hide();
            playfx( level._effect["vehicle_pdrone_explosion"], var_4.origin );
            playsoundatpos( var_4.origin, "mp_greenband_drone_exp" );
            var_4 waittillmatch( "event_police_drone", "enter_start" );
            var_4 show();
            var_4 thread police_drone_play_all_fx();
        }
    }
    else
        var_4 thread police_drone_play_anim( var_1, undefined, var_0, var_3 );
}

police_drone_play_anim( var_0, var_1, var_2, var_3 )
{
    self notify( "police_drone_play_anim" );
    self endon( "police_drone_play_anim" );
    self _meth_827A();

    if ( isdefined( var_1 ) )
    {
        self _meth_848B( var_1, var_3.origin, var_3.angles, "event_police_drone" );
        self waittillmatch( "event_police_drone", "end" );
    }

    self _meth_848B( var_0, var_3.origin, var_3.angles, "event_police_drone" );
}

spawn_police_drone( var_0 )
{
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1.angles = ( 0, 0, 0 );
    var_1.destroyed = 0;
    var_1.dronetype = var_0;

    if ( !isdefined( level.drones[var_0] ) )
        level.drones[var_0] = [];

    level.drones[var_0][level.drones[var_0].size] = var_1;

    switch ( var_0 )
    {
        case "ambient":
        case "test":
            var_1.light_fx_name = "mp_gb_drone_blink_nt";
            var_1.exhaust_fx_name = "mp_gb_drone_trail";
            var_1 _meth_80B1( "vehicle_police_drone_01_anim" );
            var_1 _meth_8075( "mp_gnb_police_drone_hover_lp" );
            break;
        case "vista":
            var_1.light_fx_name = "mp_gb_drone_blink_vista";
            var_1.exhaust_fx_name = "mp_gb_drone_trail_vista";
            var_1 _meth_80B1( "vehicle_police_drone_01_simple_anim" );
            break;
        case "vista_group":
            var_1.light_fx_name = "mp_gb_drone_hd_grp";
            var_1.exhaust_fx_name = "mp_gb_drone_trail_grp";
            var_1 _meth_80B1( "vehicle_police_drone_01_group_anim" );
            var_1 _meth_8075( "mp_gnb_drone_group_flyby" );
            break;
        default:
            break;
    }

    var_1 thread police_drone_play_all_fx();
    return var_1;
}

police_drone_play_all_fx()
{
    self endon( "death" );
    thread police_drone_play_fx( self.light_fx_name, "tag_lights" );
    thread police_drone_play_fx( self.exhaust_fx_name, "tag_exhaust" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        thread police_drone_play_fx( self.light_fx_name, "tag_lights", var_0 );
        thread police_drone_play_fx( self.exhaust_fx_name, "tag_exhaust", var_0 );
    }
}

police_drone_play_fx( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_2 ) )
        var_2 endon( "death" );

    waitframe();
    var_3 = [ var_1 ];

    if ( self.dronetype == "vista_group" )
    {
        for ( var_4 = 1; var_4 < 5; var_4++ )
            var_3[var_3.size] = var_1 + "" + var_4;
    }

    foreach ( var_6 in var_3 )
    {
        if ( isdefined( var_2 ) )
            playfxontagforclients( level._effect[var_0], self, var_6, var_2 );
        else
            playfxontag( level._effect[var_0], self, var_6 );

        waitframe();
    }
}

vista_police_group_drones()
{
    level thread spawn_police_drone_with_anim( "vista_group", "mp_gb_drone_vista_group_01" );
    level thread spawn_police_drone_with_anim( "vista_group", "mp_gb_drone_vista_group_02" );
}

vista_police_drones()
{
    level thread spawn_police_drone_with_anim( "vista", "mp_gb_drone_vista_01" );
    level thread spawn_police_drone_with_anim( "vista", "mp_gb_drone_vista_02" );
    level thread spawn_police_drone_with_anim( "vista", "mp_gb_drone_vista_03" );
    level thread spawn_police_drone_with_anim( "vista", "mp_gb_drone_vista_04" );
}

ambient_police_drones()
{
    level thread spawn_police_drone_with_anim( "ambient", "mp_gb_drone_circle_01", "mp_gb_drone_circle_01_enter" );
    level thread spawn_police_drone_with_anim( "ambient", "mp_gb_drone_circle_02", "mp_gb_drone_circle_02_enter" );
    level thread spawn_police_drone_with_anim( "ambient", "mp_gb_drone_circle_03", "mp_gb_drone_circle_03_enter" );
    level thread spawn_police_drone_with_anim( "ambient", "mp_gb_drone_circle_04", "mp_gb_drone_circle_04_enter" );
    level thread ambient_police_drone_vo();
}

ambient_police_drone_vo()
{
    for (;;)
    {
        foreach ( var_1 in level.drones["ambient"] )
        {
            if ( !var_1.destroyed )
            {
                wait(randomfloatrange( 7, 15 ));
                var_1 playsound( "mp_gnb_police_drone_chatter" );
            }
        }

        wait 1;
    }
}
