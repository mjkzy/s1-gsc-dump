// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_laser2_precache::main();
    maps\createart\mp_laser2_art::main();
    maps\mp\mp_laser2_fx::main();
    thread aud_init();
    maps\mp\_load::main();
    maps\mp\mp_laser2_lighting::main();
    maps\mp\mp_laser2_aud::main();
    maps\mp\_compass::setupminimap( "compass_map_mp_laser2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.aerial_pathnode_offset = 450;
    thread set_lighting_values();
    thread set_umbra_values();
    level.ospvisionset = "mp_laser2_osp";

    if ( level.nextgen == 1 )
        level thread rotateradar();

    level.ospvisionset = "mp_laser2_osp";
    level.osplightset = "mp_laser2_streak";
    level.mapcustomkillstreakfunc = ::laser2customkillstreakfunc;
    level.orbitalsupportoverridefunc = ::laser2customospfunc;
    level.orbitallaseroverridefunc = ::laser2customorbitallaserfunc;
    thread laser2customairstrike();
    thread scriptpatchclip();
    thread deathtriggerunderworld();
    thread scriptinvalidcarepackagearea();
    level.anim_laserbuoy = "laser_buoy_loop";
    level.waterline_offset = 2;
    maps\mp\_water::setshallowwaterweapon( "iw5_underwater_mp" );
    level thread maps\mp\_water::init();
    precacherumble( "damage_light" );
    level dynamicevent_init_sound();
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::handlemovingwater, undefined, ::handleendwater );
    level.alarmsystem = spawnstruct();
    level.alarmsystem.spinnerarray = getentarray( "horizonal_spinner", "targetname" );

    foreach ( var_1 in level.alarmsystem.spinnerarray )
        var_1 hide();

    level thread handleclouds();
    thread spawnsetup();
}

deathtriggerunderworld()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( 560, 400, -152 ), 0, 3500, 196 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( common_scripts\utility::array_contains( level.players, var_1 ) )
            var_1 _meth_8051( var_1.health + 999, var_0.origin );
    }
}

scriptpatchclip()
{
    thread vehiclecliproad();
    thread clipradarbunker();
    thread patchcliptower();
    thread patchcliplaserroof();
    thread patchclipbunkeroof();
    thread patchclipfencebunker();
    thread patchcliptowerbush();
    thread patchpillar();
    thread beachrockintoseam();
}

beachrockintoseam()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 655, -1351, 196 ), ( 19.6222, 30.4879, -7.54321 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 665, -1331, 181 ), ( 29.8983, 28.7324, -9.18216 ) );
}

patchpillar()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 67, -961, 348 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 81, -961, 348 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 81, -961, 380 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 82, -961, 412 ), ( 0, 44.998, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 65, -1013, 426 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 87, -1013, 426 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 65, -981, 426 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 87, -981, 426 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 69, -974, 425 ), ( 0, 44.998, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_32_32_32", ( 82, -961, 425 ), ( 0, 44.998, 0 ) );
}

patchcliptowerbush()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -750, 1842, 874 ), ( 0, 46, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -750, 1842, 1130 ), ( 0, 46, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -750, 1842, 1386 ), ( 0, 46, 0 ) );
}

patchclipfencebunker()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -272, 2618, 998 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -272, 2618, 742 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -176, 2549, 765 ), ( 0, 260.4, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -176, 2549, 1021 ), ( 0, 260.4, 0 ) );
}

patchclipbunkeroof()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -324, 2656, 832 ), ( 0, 170, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -674, 2718, 832 ), ( 0, 170, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -464, 2558, 832 ), ( 0, 260, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -576, 2578, 832 ), ( 0, 260, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -324, 2656, 1088 ), ( 0, 170, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -674, 2718, 1088 ), ( 0, 170, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -464, 2558, 1088 ), ( 0, 260, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -576, 2578, 1088 ), ( 0, 260, 0 ) );
}

vehiclecliproad()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 2862, 1182, 298 ), ( 274, 184, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 3086, 1212, 308 ), ( 272, 194, -180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 3314, 1286, 314 ), ( 272, 200, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 3512, 1390, 320 ), ( 271.779, 248.166, 141.856 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 3713, 1516, 325 ), ( 271.485, 262.445, 132.281 ) );
}

clipradarbunker()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1317.97, 1816.02, 788 ), ( 320, 342, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1319.81, 1964.37, 788 ), ( 320, 27, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1426, 2068, 788 ), ( 320, 72, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1574.37, 2066.19, 788 ), ( 320, 117, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1678.03, 1959.98, 788 ), ( 320, 162, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1676.19, 1811.63, 788 ), ( 320, 207, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1569.98, 1707.97, 788 ), ( 320, 252, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1421.63, 1709.81, 788 ), ( 320, 297, -90 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1500, 1886, 890 ), ( 90, 0, 0 ) );
}

patchcliptower()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -946, -1218, 954 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -946, -1218, 1210 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1414, -1218, 954 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1414, -1218, 1210 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1294, -1082, 954 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1294, -1082, 1210 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1066, -1082, 954 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1066, -1082, 1210 ), ( 0, 270, 0 ) );
}

patchcliplaserroof()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -434, 380, 802 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 418, 380, 802 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -36, 790, 846 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 38, 790, 846 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -42, -28, 846 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 32, -28, 846 ), ( 0, 270, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -314, 64, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -314, 320, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -314, 576, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -314, 704, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -194, 64, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -194, 320, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -194, 576, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -194, 704, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 62, 64, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 62, 320, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 62, 576, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 62, 704, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 318, 64, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 318, 320, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 318, 576, 814 ), ( 90, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 318, 704, 814 ), ( 90, 0, 0 ) );
}

scriptinvalidcarepackagearea()
{
    var_0 = spawn( "trigger_radius", ( -2, 393, 223 ), 0, 632, 215 );
    var_0.targetname = "orbital_node_covered";
    var_0.script_noteworthy = "dont_move_me";

    if ( !isdefined( level.goliath_bad_landing_volumes ) )
        level.goliath_bad_landing_volumes = [];

    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
    var_1 = getnodesinradiussorted( ( -2, 393, 223 ), 632, 0, 215 );

    if ( var_1.size > 0 )
    {
        foreach ( var_3 in var_1 )
            _func_2D6( var_3, "none" );
    }
}

dynamicevent_init_sound()
{
    level.tsunami_alarm = "mp_laser2_typhoon_alarm";
    level.tsunami_vo_int = "mp_laser2_vo_tsunami_warning_int";
    level.tsunami_vo_ext = "mp_laser2_vo_tsunami_warning_ext";
}

laser2customkillstreakfunc()
{
    level.killstreakweildweapons["mp_laser2_core"] = 1;
    level thread maps\mp\killstreaks\streak_mp_laser2::init();
}

laser2customospfunc()
{
    level.orbitalsupportoverrides.spawnanglemin = 30;
    level.orbitalsupportoverrides.spawnanglemax = 90;
    level.orbitalsupportoverrides.spawnheight = 9541;

    if ( level.currentgen )
    {
        level.orbitalsupportoverrides.leftarc = 20;
        level.orbitalsupportoverrides.rightarc = 20;
        level.orbitalsupportoverrides.toparc = -30;
        level.orbitalsupportoverrides.bottomarc = 60;
    }
}

laser2customorbitallaserfunc()
{
    level.orbitallaseroverrides.spawnheight = 3300;
}

laser2customairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 1750;
}

set_lighting_values()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 _meth_82FD( "r_tonemap", "2" );
        }
    }
}

set_umbra_values()
{
    setdvar( "r_umbraAccurateOcclusionThreshold", 256 );
}

handleclouds()
{
    var_0 = 122;

    for (;;)
    {
        level waittill( "connected", var_1 );

        if ( !isdefined( var_1.cloud_exploder_disabled ) )
        {
            common_scripts\_exploder::activate_clientside_exploder( var_0, var_1 );
            var_1.cloud_exploder_disabled = 0;
        }

        var_1 thread handlecloudsplayer();
    }
}

handlecloudsplayer()
{
    self endon( "disconnect" );
    var_0 = 122;

    for (;;)
    {
        self waittill( "player_start_aerial_view" );

        if ( self.cloud_exploder_disabled == 0 )
            level thread common_scripts\_exploder::deactivate_clientside_exploder( var_0, self, 1 );

        self.cloud_exploder_disabled++;
        self waittill( "player_stop_aerial_view" );
        self.cloud_exploder_disabled--;

        if ( self.cloud_exploder_disabled == 0 )
            common_scripts\_exploder::activate_clientside_exploder( var_0, self );
    }
}

rotateradar()
{
    wait 0.05;
    var_0 = getent( "radar_dish01_rotate", "targetname" );
    maps\mp\_audio::scriptmodelplayanimwithnotify( var_0, "lsr_radar_dish_loop", "ps_emt_satellite_dish_rotate", "emt_satellite_dish_rotate", "laser2_custom_end_notify", "laser2_custom_ent_end_notify", "laser2_custom_ent2_end_notify" );
}

handlepropattachments( var_0 )
{
    if ( isdefined( self.target ) )
    {
        var_1 = getentarray( self.target, "targetname" );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_0 ) )
            {
                var_3 _meth_8446( var_0 );
                continue;
            }

            var_3 _meth_8446( self );
        }
    }
}

dynamicevent_init()
{
    level endon( "game_ended" );
    level.water_warning = undefined;
    level.ocean = undefined;
    var_0 = getentarray( "ocean_water", "targetname" );

    if ( isdefined( var_0 ) )
    {
        level.ocean = var_0[0];

        if ( var_0.size > 0 )
        {
            level.ocean_pieces = common_scripts\utility::array_remove( var_0, level.ocean );
            common_scripts\utility::array_thread( level.ocean_pieces, ::linktoent, level.ocean );
        }
    }

    level.ocean.warning_time = 30;
    level.ocean.origin -= ( 0, 0, 132 );
    var_1 = getent( "ocean_water_underside", "targetname" );
    var_2 = getentarray( "trigger_underwater", "targetname" );
    var_3 = getentarray( "ocean_moving_prop", "targetname" );
    var_4 = getentarray( "buoy", "targetname" );
    var_5 = [];
    level.moving_buoys = [];
    var_6 = getentarray( "water_clip", "targetname" );
    level.post_event_geo = getentarray( "post_event_geo", "targetname" );
    level.end_state_geo = getentarray( "end_state_geo", "targetname" );
    level.post_event_nodes = getnodearray( "post_event_node", "targetname" );
    level.pre_event_nodes = getnodearray( "pre_event_node", "targetname" );
    level.goliath_bad_landing_volumes = getentarray( "goliath_bad_landing_volume", "targetname" );
    level.drop_pod_bad_places = getentarray( "drop_pod_bad_place", "targetname" );
    level.post_event_pathing_blockers = getentarray( "post_event_pathing_blocker", "targetname" );
    level.pre_event_pathing_blockers = getentarray( "pre_event_pathing_blocker", "targetname" );
    level handle_event_geo_off();
    level thread handle_pathing_pre_event();

    foreach ( var_8 in var_3 )
    {
        if ( isdefined( var_8.script_noteworthy ) && var_8.script_noteworthy == "has_collision" )
            var_5[var_5.size] = var_8;
    }

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.script_noteworthy ) && var_11.script_noteworthy == "moving" )
            level.moving_buoys[level.moving_buoys.size] = var_11;
    }

    var_13 = common_scripts\utility::array_combine( var_3, level.moving_buoys );
    thread maps\mp\mp_laser2_fx::setupwaves( level.ocean );
    thread maps\mp\mp_laser2_fx::setupoceanfoam( level.ocean );

    if ( isdefined( level.waterline_ents ) )
        common_scripts\utility::array_thread( level.waterline_ents, ::linktoent, level.ocean );

    if ( level.nextgen )
        var_1 linktoent( level.ocean );

    if ( isdefined( var_6 ) && var_6.size > 0 )
        common_scripts\utility::array_thread( var_6, ::linktoent, level.ocean );

    if ( isdefined( var_13 ) && var_13.size > 0 )
        common_scripts\utility::array_thread( var_13, ::linktoent, level.ocean );

    if ( isdefined( var_2 ) && var_2.size > 0 && isdefined( level.ocean ) )
    {
        foreach ( var_15 in var_2 )
            var_15 thread handlewatertriggermovement( level.ocean );
    }

    if ( isdefined( level.goliath_bad_landing_volumes ) && level.goliath_bad_landing_volumes.size > 0 && isdefined( level.ocean ) )
    {
        foreach ( var_15 in level.goliath_bad_landing_volumes )
        {
            if ( isdefined( var_15.script_noteworthy ) && var_15.script_noteworthy == "dont_move_me" )
                continue;
            else
                var_15 thread handlewatertriggermovement( level.ocean );
        }
    }

    if ( isdefined( var_5 ) && var_5.size > 0 )
        common_scripts\utility::array_thread( var_5, ::handlepropattachments, level.ocean );

    if ( isdefined( var_4 ) && var_4.size > 0 )
        common_scripts\utility::array_thread( var_4, ::playbuoylights );

    if ( isdefined( level.moving_buoys ) && level.moving_buoys.size > 0 )
    {
        common_scripts\utility::array_thread( level.moving_buoys, ::playpropanim, level.anim_laserbuoy );
        common_scripts\utility::array_thread( level.moving_buoys, ::handlepropattachments, level.ocean );
    }

    var_19 = getent( "tidal_wave", "targetname" );
    var_19 hide();
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_04", "targetname" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_00", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_01", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_02", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_03", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_04", "targetname" );
    maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig( "trig_kill_drone_vista", "targetname" );
    thread maps\mp\mp_laser2_fx::playwaves( "end_initial_waves", 4, 6, "breaking_wave_01" );
    level setoceansinvalueslowtide();
}

connect_paths()
{
    if ( isdefined( self ) )
        self _meth_8058();
}

disconnect_paths()
{
    if ( isdefined( self ) )
        self _meth_8057();
}

connect_nodes()
{
    if ( isdefined( self ) )
        self _meth_805A();
}

disconnect_nodes()
{
    if ( isdefined( self ) )
        self _meth_8059();
}

hidegeo()
{
    if ( isdefined( self ) && !isdefined( self.ishidden ) )
    {
        self.ishidden = 1;
        common_scripts\utility::trigger_off();
    }
}

showgeo()
{
    if ( isdefined( self ) && isdefined( self.ishidden ) )
    {
        self.ishidden = undefined;
        common_scripts\utility::trigger_on();
    }
}

oceansinmovement( var_0 )
{
    level endon( "game_ended" );
    level endon( "end_initial_waves" );
    self notify( "ocean_sin_movement" );
    self endon( "ocean_sin_movement" );

    for (;;)
    {
        self _meth_82AE( ( 0, level.oceansinamplitude, level.oceansinamplitude ) + var_0, level.oceansinperiod / 2, level.oceansinperiod * 0.25, level.oceansinperiod * 0.25 );
        wait(level.oceansinperiod / 2);
        self _meth_82AE( -1 * ( 0, level.oceansinamplitude, level.oceansinamplitude ) + var_0, level.oceansinperiod / 2, level.oceansinperiod * 0.25, level.oceansinperiod * 0.25 );
        wait(level.oceansinperiod / 2);
    }
}

setoceansinvalueslowtide()
{
    if ( level.nextgen )
    {
        level.oceansinamplitude = 12;
        level.oceansinperiod = 10;
    }
    else
    {
        level.oceansinamplitude = 16;
        level.oceansinperiod = 20;
    }
}

setoceansinvalueshightide()
{
    level.oceansinamplitude = 6;
    level.oceansinperiod = 10;
}

linktoent( var_0 )
{
    var_1 = self;
    var_1 _meth_8446( var_0 );
}

handlebuoydings( var_0, var_1 )
{
    level endon( "game_ended" );

    for (;;)
    {
        wait(randomfloatrange( 0.05, 0.5 ));

        while ( !isdefined( level.water_warning ) || level.water_warning != 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_1, "tag_origin" );
            wait(randomfloatrange( 3, 7 ));
        }

        while ( level.water_warning == 1 )
        {
            maps\mp\_utility::play_sound_on_tag( var_0, "tag_origin" );
            wait(randomfloatrange( 1.5, 4.5 ));
        }
    }
}

playbuoylights()
{
    self notify( "stop_buoy_lights" );
    self endon( "stop_buoy_lights" );
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait(randomfloat( 4 ));
    stopfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_buoy_red" ), self, "fx_joint_0" );
}

playpropanim( var_0 )
{
    wait(randomfloatrange( 0.1, 1 ));
    self _meth_8279( var_0 );
}

oceanmover_init( var_0 )
{
    level endon( "game_ended" );
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return undefined;

    var_1.warning_time = 30;
    return var_1;
}

oceanobjectmover_init( var_0 )
{
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1.targetname = "OceanObjectMover";
    var_1.dist_prop = ( 0, 352, 0 );
    return var_1;
}

moving_water_init()
{
    level endon( "game_ended" );
    thread maps\mp\mp_laser2_fx::playwaves( "end_initial_waves", 4, 6, "breaking_wave_01" );
}

handleendwater()
{
    level.ocean.origin += ( 0, 0, 72 );
    level notify( "end_initial_waves" );
    thread maps\mp\mp_laser2_fx::playwaves( undefined, 6, 8, "breaking_wave_01" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 201 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 202 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 203 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 204 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 205 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 206 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 207 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 208 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 209 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 121 );

    if ( isdefined( level.end_state_geo ) )
        common_scripts\utility::array_thread( level.end_state_geo, ::showgeo );

    level handle_event_geo_on();
    level maps\mp\_utility::delaythread( 0.05, ::handle_pathing_post_event );
}

handlemovingwater()
{
    level endon( "game_ended" );
    var_0 = 122;

    foreach ( var_2 in level.players )
    {
        if ( var_2.cloud_exploder_disabled == 0 )
            level thread common_scripts\_exploder::deactivate_clientside_exploder( var_0, var_2, 0 );

        var_2.cloud_exploder_disabled++;
    }

    level.skipoceanspawns = 1;
    var_4 = level.ocean;
    var_5 = getent( "tidal_wave", "targetname" );
    var_5 show();
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.targetname = "ocean_tag_origin";
    var_6 show();
    var_7 = getent( "lsr_tidal_wave_car", "targetname" );
    var_8 = getent( "lsr_tidal_wave_shipping_container_closed", "targetname" );
    var_9 = getent( "lsr_tidal_wave_shipping_container_open", "targetname" );
    create_bot_badplaces();

    foreach ( var_11 in level.water_triggers )
        var_11 thread killobjectsunderwater();

    level thread addposteventgeotocratebadplacearray();
    level thread killplayersusingremotestreaks();
    wait 0.05;
    level.water_warning = 1;
    level notify( "end_initial_waves" );
    thread maps\mp\mp_laser2_aud::start_rough_tide();
    var_13 = 2;
    earthquake( 0.3, var_13, ( 0, 0, 0 ), 5000 );
    thread aud_dynamic_event_startup( var_13 );
    thread play_earthquake_rumble_for_all_players( 0.75 );
    level maps\mp\_utility::delaythread( 3, ::handletsunamiwarningsounds );
    var_14 = 26.667;
    var_15 = 36.7;
    var_16 = var_15;

    if ( var_14 > var_15 )
        var_16 = var_14;

    if ( var_4.warning_time > var_16 )
        wait(var_4.warning_time - var_16);
    else
        wait 2;

    var_5 thread tidal_wave_notetracks();
    var_5 _meth_827B( "lsr_tidal_wave_mesh_anim", "tidal_wave_notetrack" );
    var_4 _meth_804D( var_6 );
    var_6 _meth_827B( "lsr_tidal_wave_ocean_anim" );

    if ( isdefined( var_7 ) )
        var_7 _meth_827B( "lsr_tidal_wave_car" );

    var_8 _meth_827B( "lsr_tidal_wave_shipping_container_closed" );
    var_9 _meth_827B( "lsr_tidal_wave_shipping_container_open" );

    foreach ( var_18 in level.moving_buoys )
    {
        if ( isdefined( var_18.animation ) )
        {
            var_18 _meth_827A();
            var_18 _meth_804F();
            var_18 _meth_827B( var_18.animation );
            var_18 thread playbuoylights();
            var_18 maps\mp\_utility::delaythread( var_15, ::buoys_return_to_bobbing );
        }
    }

    level maps\mp\_utility::delaythread( var_14 - 3, ::stop_water_warning );
    level maps\mp\_utility::delaythread( var_14 - 2.9, ::play_earthquake_rumble_for_all_players, 0.75 );
    var_5 common_scripts\utility::delaycall( var_14, ::hide );
    var_6 common_scripts\utility::delaycall( var_15, ::hide );
    var_4 common_scripts\utility::delaycall( var_15, ::_meth_804F );
    wait(var_16);
    var_20 = getnodearray( "water_nodes", "targetname" );

    foreach ( var_22 in var_20 )
        _func_2C0( var_22, 1 );

    delete_bot_badplaces();
    level.skipoceanspawns = 0;
    wait 2;
    thread maps\mp\mp_laser2_fx::playwaves( undefined, 6, 8, "breaking_wave_01" );
    level notify( "dynamic_event_complete" );
}

create_bot_badplaces()
{
    badplace_cylinder( "badplace_1", -1, ( -1096, -688, 229.5 ), 300, 200 );
    badplace_cylinder( "badplace_2", -1, ( -544, -1104, 158 ), 500, 200 );
    badplace_cylinder( "badplace_3", -1, ( 0, -1024, 154.286 ), 500, 200 );
    badplace_cylinder( "badplace_4", -1, ( 608, -1152, 153.195 ), 500, 200 );
    badplace_cylinder( "badplace_5", -1, ( 1360, -832, 203.4 ), 500, 200 );
    badplace_cylinder( "badplace_6", -1, ( 2128, -416, 159.325 ), 500, 200 );
    badplace_cylinder( "badplace_7", -1, ( 2464, 176, 128 ), 500, 200 );
}

delete_bot_badplaces()
{
    badplace_delete( "badplace_1" );
    badplace_delete( "badplace_2" );
    badplace_delete( "badplace_3" );
    badplace_delete( "badplace_4" );
    badplace_delete( "badplace_5" );
    badplace_delete( "badplace_6" );
    badplace_delete( "badplace_7" );
}

killobjectsunderwater()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );

    for (;;)
    {
        if ( isdefined( level.turrets ) )
        {
            foreach ( var_1 in level.turrets )
            {
                if ( var_1 _meth_80A9( self ) )
                    var_1 notify( "death" );
            }
        }

        if ( isdefined( level.carepackages ) )
        {
            foreach ( var_4 in level.carepackages )
            {
                if ( isdefined( var_4 ) && !_func_294( var_4 ) && var_4 iscarepackageinposteventgeo() )
                {
                    if ( isdefined( var_4.cratetype ) && var_4.cratetype != "juggernaut" )
                    {
                        var_4 maps\mp\killstreaks\_airdrop::deletecrate( 1, 1 );
                        continue;
                    }

                    if ( isdefined( var_4.cratetype ) && var_4.cratetype == "juggernaut" )
                        var_4 maps\mp\killstreaks\_juggernaut::deletegoliathpod( 1, 1 );
                }
            }
        }

        wait 0.05;
    }
}

iscarepackageinposteventgeo()
{
    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_1 in level.drop_pod_bad_places )
        {
            if ( _func_22A( self.origin, var_1 ) )
                return 1;
        }
    }

    return 0;
}

addposteventgeotocratebadplacearray()
{
    level waittill( "post_event_geo_on" );

    foreach ( var_1 in level.drop_pod_bad_places )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_1;
}

killplayersusingremotestreaks()
{
    level endon( "game_ended" );
    level endon( "dynamic_event_complete" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1 ) && isdefined( var_1.inwater ) && var_1 maps\mp\_utility::isusingremote() )
                var_1 maps\mp\_utility::_suicide();
        }

        wait 0.05;
    }
}

buoys_return_to_bobbing()
{
    linktoent( level.ocean );
    self _meth_827A();
    wait(randomfloatrange( 0.1, 1 ));
    self _meth_8279( level.anim_laserbuoy );
    thread playbuoylights();
}

play_earthquake_rumble_for_all_players( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 thread play_earthquake_rumble( var_0 );
}

play_earthquake_rumble( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for ( var_1 = var_0 * 20; var_1 >= 0; var_1 -= 2 )
    {
        self _meth_80AD( "damage_light" );
        wait 0.1;
    }
}

stop_water_warning()
{
    level.water_warning = 0;
    common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstop );
}

tidal_wave_notetracks()
{
    thread event_fx();
    thread event_killtriggers();
    thread event_geo();
}

event_fx()
{
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_mist_start" );
    thread maps\mp\mp_laser2_fx::start_wave_mist_fx();
    self waittillmatch( "tidal_wave_notetrack", "vfx_receding_foam_start" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 120 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 100 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_rocks1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 101 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 201 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 0 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_tower_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 102 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 202 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 1 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_concrete_chunk1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 103 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 203 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 2 );
    thread maps\mp\mp_laser2_fx::stop_wave_mist_fx();
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse1_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 104 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 204 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 3 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse2_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 105 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 205 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 4 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_wave_collapse3_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 106 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 206 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 5 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_midbeach_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 107 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 207 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 6 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 108 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 208 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 7 );
    self waittillmatch( "tidal_wave_notetrack", "vfx_helipad_splash2" );
    level thread common_scripts\_exploder::activate_clientside_exploder( 109 );
    level thread common_scripts\_exploder::activate_clientside_exploder( 209 );
    thread maps\mp\mp_laser2_fx::playoceanfoam( "tidal_wave_lingering_foam1", 8 );
    wait 1.0;
    level thread common_scripts\_exploder::activate_clientside_exploder( 121 );
    var_0 = 122;

    foreach ( var_2 in level.players )
    {
        if ( var_2.cloud_exploder_disabled > 0 )
        {
            var_2.cloud_exploder_disabled--;

            if ( var_2.cloud_exploder_disabled == 0 )
                common_scripts\_exploder::activate_clientside_exploder( var_0, var_2 );
        }
    }
}

event_killtriggers()
{
    common_scripts\utility::trigger_on( "trig_kill_drone_vista", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_00" );
    common_scripts\utility::trigger_off( "trig_kill_drone_vista", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_00", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_01" );
    common_scripts\utility::trigger_off( "trig_kill_00", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_01", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_02" );
    common_scripts\utility::trigger_off( "trig_kill_01", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_02", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_03" );
    common_scripts\utility::trigger_off( "trig_kill_02", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_03", "targetname" );
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    common_scripts\utility::trigger_off( "trig_kill_03", "targetname" );
    common_scripts\utility::trigger_on( "trig_kill_04", "targetname" );
    maps\mp\_utility::delaythread( 1, common_scripts\utility::trigger_off, "trig_kill_04", "targetname" );
}

event_geo()
{
    self waittillmatch( "tidal_wave_notetrack", "kill_trig_04" );
    level handle_event_geo_on();
    level handle_pathing_post_event();
}

handle_event_geo_on()
{
    if ( isdefined( level.post_event_geo ) )
    {
        foreach ( var_1 in level.post_event_geo )
            var_1 showgeo();

        level notify( "post_event_geo_on" );
    }

    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_4 in level.drop_pod_bad_places )
            var_4 showgeo();
    }
}

handle_event_geo_off()
{
    if ( isdefined( level.post_event_geo ) )
    {
        foreach ( var_1 in level.post_event_geo )
            var_1 hidegeo();

        level notify( "post_event_geo_off" );
    }

    if ( isdefined( level.drop_pod_bad_places ) )
    {
        foreach ( var_4 in level.drop_pod_bad_places )
            var_4 hidegeo();
    }

    if ( isdefined( level.end_state_geo ) )
        common_scripts\utility::array_thread( level.end_state_geo, ::hidegeo );
}

handle_pathing_pre_event()
{
    if ( getdvar( "scr_dynamic_event_state", "on" ) != "endstate" && ( !isdefined( level.dynamiceventstype ) || level.dynamiceventstype != 2 ) )
        wait 0.05;

    foreach ( var_1 in level.pre_event_pathing_blockers )
    {
        var_1 disconnect_paths();
        var_1 hidegeo();
    }

    foreach ( var_1 in level.post_event_pathing_blockers )
    {
        var_1 hidegeo();
        var_1 connect_paths();
    }
}

handle_pathing_post_event()
{
    if ( isdefined( level.post_event_pathing_blockers ) )
    {
        foreach ( var_1 in level.post_event_pathing_blockers )
        {
            var_1 showgeo();
            var_1 disconnect_paths();
            var_1 hidegeo();
        }
    }

    if ( isdefined( level.pre_event_pathing_blockers ) )
        common_scripts\utility::array_thread( level.pre_event_pathing_blockers, ::connect_paths );
}

oceanobjectmover_set_goal( var_0 )
{
    if ( var_0.direction == "up" && 0 )
        self.goal = self.loc_start;
    else if ( var_0.direction == "down" && 1 )
        self.goal = self.loc_start;
    else
        self.goal = self.loc_end;
}

activate_splashes( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );

    if ( isdefined( var_1 ) )
    {
        level notify( var_1 );
        level endon( var_1 );
    }

    if ( !isdefined( var_2 ) )
        var_2 = 3;

    if ( !isdefined( var_3 ) )
        var_3 = 5;

    for (;;)
    {
        level thread common_scripts\_exploder::activate_clientside_exploder( var_0 );
        wait(randomfloatrange( var_2, var_3 ));
    }
}

handlewatertriggermovement( var_0 )
{
    level endon( "game_ended" );
    var_1 = undefined;

    if ( isdefined( self.target ) )
        var_1 = common_scripts\utility::getstruct( self.target, "targetname" );

    var_2 = self.origin - var_0.origin;
    childthread movetrig( var_0, var_2 );

    if ( isdefined( var_1 ) )
    {
        var_3 = var_1.origin[2] - self.origin[2];
        var_4 = var_2 + ( 0, 0, var_3 );
        var_1 childthread movetrig( var_0, var_4 );
    }
}

movetrig( var_0, var_1 )
{
    for (;;)
    {
        self.origin = var_0.origin + var_1;
        wait 0.05;
    }
}

spawnsetup()
{
    level.skipoceanspawns = 0;
    level.dynamicspawns = ::getlistofgoodspawnpoints;
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 isvalidspawn() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

isvalidspawn()
{
    if ( level.skipoceanspawns == 1 && self.targetname == "ocean_spawn" )
        return 0;

    return 1;
}

spinalarmsstart()
{
    self show();
    self _meth_82BD( ( 0, 600, 0 ), 12 );
    var_0 = _func_231( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part", "siren_on" );
}

spinalarmsstop()
{
    self hide();
    var_0 = _func_231( "tsunami_alarm", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_83F6( "static_part", "siren_off" );
}

aud_init()
{

}

aud_dynamic_event_startup( var_0 )
{
    thread aud_handle_earthquake( var_0 );
    thread aud_handle_warning_vo();
    thread aud_handle_wave_incoming();
    thread aud_handle_buoy_sfx();
}

aud_handle_warning_vo()
{
    wait 2;
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_vo_tsunami_warn_tide", ( 0, 0, 0 ) );
    wait 5;
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_vo_tsunami_warn_high_ground", ( 0, 0, 0 ) );
}

aud_handle_earthquake( var_0 )
{
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_ty_initial_hit", ( 0, 0, 0 ) );
}

aud_handle_buoy_sfx()
{
    level endon( "aud_kill_dings" );

    for (;;)
    {
        thread maps\mp\_audio::snd_play_in_space( "mp_laser_buoy_ding_event", ( 150, -2295, 403 ) );
        wait 0.5;
        thread maps\mp\_audio::snd_play_in_space( "mp_laser_buoy_ding_event", ( 1026, -2381, 403 ) );
        wait 6;
    }
}

aud_handle_wave_incoming()
{
    var_0 = thread maps\mp\_audio::snd_play_loop_in_space( "mp_laser2_ty_quake_lp", ( 79, -1591, 455 ), "aud_dynamic_event_end" );
    thread aud_handle_waves_crash();
    var_0 _meth_806F( 0, 0.05 );
    wait 16.5;
    thread aud_handle_incoming();
    var_0 _meth_806F( 0.8, 8 );
}

aud_handle_incoming()
{
    thread maps\mp\_audio::snd_play_in_space( "mp_laser2_ty_incoming", ( 79, -1591, 455 ) );
    wait 4;
    level notify( "aud_kill_dings" );
    earthquake( 0.1, 4, ( 79, -1591, 455 ), 2500 );
    wait 1.2;
    earthquake( 0.2, 4, ( 79, -1591, 455 ), 2500 );
    wait 2;
    earthquake( 0.3, 5.5, ( 79, -1591, 455 ), 2500 );
}

aud_handle_waves_crash()
{
    wait 27;
    level notify( "aud_dynamic_event_end" );
    level._snd.dynamic_event_happened = 1;

    foreach ( var_1 in level.players )
    {
        var_1 _meth_84D8( "mp_pre_event_mix" );
        wait 0.05;
    }

    wait 0.05;

    foreach ( var_1 in level.players )
    {
        var_1 _meth_84D7( "mp_post_event_mix", 1 );
        wait 0.05;
    }
}

handletsunamiwarningsounds()
{
    level endon( "game_ended" );
    var_0 = getentarray( "tsunami_speaker", "targetname" );

    while ( level.water_warning == 1 )
    {
        if ( isdefined( var_0 ) )
        {
            foreach ( var_2 in var_0 )
                playsoundatpos( var_2.origin, level.tsunami_alarm );

            playsoundatpos( ( 0, 0, 0 ), level.tsunami_alarm );
        }

        common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstart );
        wait 2;

        if ( !isdefined( level.water_warning ) || level.water_warning != 1 )
            return;

        foreach ( var_2 in var_0 )
        {

        }

        wait 3;
    }
}
