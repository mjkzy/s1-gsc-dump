// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_crash_site()
{
    common_scripts\utility::flag_init( "crash_site_done" );
    common_scripts\utility::flag_init( "white_vo_done" );
    common_scripts\utility::flag_init( "begin_crash_site_lighting" );
    common_scripts\utility::flag_init( "crash_dof_fly_in" );
    common_scripts\utility::flag_init( "zero_view" );
    common_scripts\utility::flag_init( "unhide_cargo" );
    common_scripts\utility::flag_init( "go_drop_pods" );
    common_scripts\utility::flag_init( "crash_lighting_cinema_end" );
    common_scripts\utility::flag_init( "crash_site_battle_start" );
    common_scripts\utility::flag_init( "above_hole" );
    common_scripts\utility::flag_init( "player_returning_to_map" );
    common_scripts\utility::flag_init( "choose_drop_pod" );
    common_scripts\utility::flag_init( "wave1_pods_done" );
    common_scripts\utility::flag_init( "wave2_pods_starting" );
    common_scripts\utility::flag_init( "wave2_pods_done" );
    common_scripts\utility::flag_init( "wave3_pods_starting" );
    common_scripts\utility::flag_init( "wave3_pods_done" );
    common_scripts\utility::flag_init( "cormack_help_me" );
    common_scripts\utility::flag_init( "cormack_reached" );
    common_scripts\utility::flag_init( "rz_pilot_vo" );
    common_scripts\utility::flag_init( "razorback_start" );
    common_scripts\utility::flag_init( "player_loading_cargo" );
    common_scripts\utility::flag_init( "lighting_loading_cargo" );
    common_scripts\utility::flag_init( "razorback_loaded" );
    common_scripts\utility::flag_init( "lighting_razorback_loaded" );
    common_scripts\utility::flag_init( "start_background_elements" );
    precachemodel( "vehicle_atlas_assault_drone_large" );
    precachemodel( "vehicle_drop_pod" );
    precachemodel( "vehicle_drop_pod_base" );
    precachemodel( "npc_hbra3_nocamo" );
    precachemodel( "csh_entry_shelf_ice_floor_01_anim" );
    precachemodel( "npc_exo_armor_rocket_large" );
    precachemodel( "csh_drone_parachute_01" );
    precacheitem( "iw5_microdronelauncher_sp" );
    precacherumble( "warbird_flyby" );
    precachestring( &"CRASH_INTROSCREEN_ANTARCTICA" );
    precachestring( &"CRASH_DONT_LEAVE" );
    precachestring( &"CRASH_FAIL_ALLIES_KILLED" );
    precachestring( &"CRASH_FAIL_FALL" );
    var_0 = getentarray( "drop_pod_clips", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_82BF();

    var_4 = getent( "crash_site_plane_snow", "targetname" );
    var_4 hide();
    var_5 = getentarray( "crash_site_scorching", "targetname" );

    foreach ( var_7 in var_5 )
        var_7 hide();

    var_9 = getent( "crash_site_plane_parachutes", "targetname" );
    var_9 delete();
    var_10 = getentarray( "crash_site_plane_snowpiles", "targetname" );

    foreach ( var_12 in var_10 )
        var_12 hide();

    var_14 = getentarray( "crash_site_debris_models", "targetname" );

    foreach ( var_12 in var_14 )
        var_12 hide();

    var_17 = getent( "player_jetpack", "targetname" );
    var_17 hide();
    level.drop_pods = getentarray( "drop_pod_node", "script_noteworthy" );

    foreach ( var_19 in level.drop_pods )
    {
        var_20 = getent( var_19.target, "targetname" );
        var_20 hide();
        var_19 hide();
    }

    var_22 = [];
    var_22[0] = getent( "fake_drop_pod_1", "targetname" );
    var_22[1] = getent( "fake_drop_pod_2", "targetname" );
    var_22[2] = getent( "fake_drop_pod_3", "targetname" );
    var_22[3] = getent( "fake_drop_pod_4", "targetname" );
    var_22[4] = getent( "fake_drop_pod_5", "targetname" );

    foreach ( var_19 in var_22 )
        var_19 hide();

    var_25 = getentarray( "drop_pod_background", "targetname" );

    foreach ( var_19 in var_25 )
    {
        var_20 = getent( var_19.target, "targetname" );
        var_20 hide();
        var_19 hide();
    }

    var_28 = getentarray( "craters", "script_noteworthy" );

    foreach ( var_30 in var_28 )
        var_30 hide();

    var_32 = getent( "drop_pod_mech_1", "targetname" );
    var_33 = getent( var_32.target, "targetname" );
    var_32 hide();
    var_33 hide();
    var_34 = getent( "drop_pod_mech_2", "targetname" );
    var_35 = getent( var_34.target, "targetname" );
    var_34 hide();
    var_35 hide();
    var_36 = getent( "drop_pod_mech_3", "targetname" );
    var_37 = getent( var_36.target, "targetname" );
    var_36 hide();
    var_37 hide();
    var_38 = getentarray( "crash_site_triggers", "targetname" );

    foreach ( var_40 in var_38 )
        var_40 common_scripts\utility::trigger_off();

    var_42 = getent( "cargo_trigger", "targetname" );
    var_42 common_scripts\utility::trigger_off();
    maps\_utility::add_control_based_hint_strings( "boost_jump", &"CRASH_HINT_BOOST_JUMP", ::should_break_boost_jump_hint );
    maps\_utility::add_control_based_hint_strings( "hint_dont_leave_mission", &"CRASH_DONT_LEAVE", ::should_break_dont_leave );
    level.crash_site_drones = [];
}

precache_cave_entry()
{
    common_scripts\utility::flag_init( "cave_entry_done" );
    common_scripts\utility::flag_init( "cave_entry_anim_start" );
    common_scripts\utility::flag_init( "player_starting_cave_entry" );
    common_scripts\utility::flag_init( "player_pre_loading_cargo" );
    common_scripts\utility::flag_init( "shoot_razorback" );
    common_scripts\utility::flag_init( "razorback_goliath_done" );
    common_scripts\utility::flag_init( "tank_firing_missiles" );
    common_scripts\utility::flag_init( "start_bunker_collapse" );
    common_scripts\utility::flag_init( "tank_incoming" );
    common_scripts\utility::flag_init( "flag_m_turret_dead" );
    common_scripts\utility::flag_init( "fall_debris_exploder" );
    common_scripts\utility::flag_init( "blur_player_vision" );
    precachemodel( "npc_resonance_device_base" );
    precacheshader( "overlay_rain_blur" );
    precacheshellshock( "crash_ice_cave_entry" );
    precachestring( &"CRASH_CARGO_PUSH" );
    precachestring( &"CRASH_CARGO_PUSH_KEYBOARD" );
}

debug_start_crash_site()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_crash_site" );
    thread maps\crash::objective_init();
    level.player maps\_utility::fog_set_changes( "crash_skyjack_heavy_fog", 0 );
    thread maps\_high_speed_clouds::cloudfastinit( "heavy", ( 0, 90, 0 ), 5, 1 );
    level.cormack maps\_utility::gun_remove();
    level.player _meth_831D();
    level.player _meth_8332( "iw5_hbra3_sp_opticstargetenhancer" );
    level.player _meth_8119( 0 );
    level.player _meth_8301( 0 );
    level.player _meth_8304( 0 );
    level.player _meth_811A( 0 );
    level.player _meth_8300( 0 );
    level.player _meth_8130( 0 );
}

debug_start_cave_entry()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_cave_entry" );
    level.crash_site_animnode = common_scripts\utility::getstruct( "crash_site_animnode", "targetname" );
    thread maps\crash::objective_init();

    if ( level.nextgen )
        level.allies_bunker = maps\_utility::array_spawn_targetname( "bunker_allies", 1 );
    else
    {
        var_0 = getentarray( "bunker_allies", "targetname" );
        level.allies_bunker = maps\_utility::array_spawn_cg( var_0, 1 );
    }

    var_1 = getent( "bunker_badplace", "targetname" );
    badplace_brush( "bunker_badplace", -1, var_1, "axis" );
    level.pod_enemies = [];
    waitframe();
    var_2 = getentarray( "runway_shells", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 delete();

    level.player thread maps\crash_utility::exo_temp_outdoor();

    if ( level.nextgen )
    {
        level.bunker_guy01 = maps\_utility::get_living_ai( "bunker_ally_01", "script_noteworthy" );
        level.bunker_guy01.animname = "bunker_guy01";
        var_6 = getnode( "bunker_ally_01_node", "targetname" );
        level.bunker_guy01 thread maps\_utility::magic_bullet_shield();
        level.bunker_guy01 _meth_81C6( var_6.origin, var_6.angles );
        level.bunker_guy01 _meth_81A5( var_6 );
        level.bunker_guy02 = maps\_utility::get_living_ai( "bunker_ally_02", "script_noteworthy" );
        level.bunker_guy02.animname = "bunker_guy02";
        var_7 = getnode( "bunker_ally_02_node", "targetname" );
        level.bunker_guy02 thread maps\_utility::magic_bullet_shield();
        level.bunker_guy02 _meth_81C6( var_7.origin, var_7.angles );
        level.bunker_guy02 _meth_81A5( var_7 );
    }

    level.bunker_guy03 = maps\_utility::get_living_ai( "bunker_ally_03", "script_noteworthy" );
    level.bunker_guy03.animname = "bunker_guy03";
    var_8 = getnode( "bunker_ally_03_node", "targetname" );
    level.bunker_guy03 _meth_81C6( var_8.origin, var_8.angles );
    level.bunker_guy03 _meth_81A5( var_8 );
    level.bunker_guy03 thread maps\_utility::magic_bullet_shield();
    thread razorback_trigger_handler();
    thread razorback_cargo_player();
    thread razorback_razorback();
    thread razorback_cargo();
    common_scripts\utility::flag_set( "razorback_start" );
    common_scripts\_exploder::exploder( 1474 );
    level.player _meth_83C0( "crash_crash_site" );
    maps\_utility::vision_set_fog_changes( "crash_crash_site", 0 );
    level.player _meth_8490( "clut_crash_crash_site", 0 );
    setsunflareposition( ( -10.08, -87.9, 0 ) );
    common_scripts\_exploder::exploder( 1999 );
    thread background_drop_pods();
    thread crash_site_random_bg_explosion();
}

begin_crash_site()
{
    if ( level.currentgen )
    {
        var_0 = [ "crash_mech" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "end_crash_perf_monitor", var_0, 18, 0 );
    }

    if ( level.currentgen )
    {
        if ( !_func_21E( "crash_site_tr" ) )
        {
            level.player _meth_84CB( 0 );
            level notify( "tff_pre_sky_to_site" );
            _func_219( "crash_sky_tr" );
            _func_218( "crash_site_tr" );

            while ( !_func_21E( "crash_site_tr" ) )
                wait 0.05;

            level notify( "tff_post_sky_to_site" );
            level.player _meth_84CC();
        }
    }

    thread maps\_utility::autosave_by_name( "crash_site" );
    level.crash_site_animnode = common_scripts\utility::getstruct( "crash_site_animnode", "targetname" );
    level.wind_dir = ( 0, 90, 0 );

    if ( level.start_point == "crash_site" )
        waitframe();

    common_scripts\utility::flag_set( "begin_crash_site_lighting" );
    common_scripts\_exploder::exploder( 1999 );
    var_1 = common_scripts\utility::getstruct( "crash_site_cormack", "targetname" );
    level.cormack _meth_81C6( var_1.origin, var_1.angles );
    level.ilana = maps\crash_utility::spawn_ally( "ilana", "crash_site_ilana" );
    waitframe();
    level.ilana maps\_utility::set_force_color( "g" );
    level.ilana.canjumppath = 1;
    maps\_utility::array_spawn_function_targetname( "plane_allies", ::crash_site_plane_allies );

    if ( level.nextgen )
        level.allies_plane = maps\_utility::array_spawn_targetname( "plane_allies", 1 );
    else
    {
        var_2 = getentarray( "plane_allies", "targetname" );
        level.allies_plane = maps\_utility::array_spawn_cg( var_2, 1 );
    }

    thread crash_site_cormack();
    thread crash_site_ilana();
    thread crash_site_player_gun();
    thread crash_site_bunker_sentinels();
    thread crash_site_intro_killer();
    thread crash_site_intro_killer2();
    thread crash_site_player();
    thread kill_trigger_array();
    thread check_potential_falling_death();
    thread falling_death();
    thread razorback_trigger_handler();
    thread razorback_cargo_player();
    thread crash_site_combat_manager();
    thread crash_site_drop_pod_manager();
    thread crash_site_kill_counter();
    thread crash_site_plane();
    thread crash_site_chutes();
    thread crash_site_runway();
    thread crash_site_drone();
    thread razorback_razorback();
    thread razorback_cargo();
    thread background_drop_pods();
    thread crash_site_random_bg_explosion();
    thread crash_site_random_playspace_explosion();
    common_scripts\utility::flag_set( "white_fade_done" );
    wait 1;
    maps\_utility::array_spawn_function_targetname( "bunker_allies", ::crash_site_bunker_allies );
    wait 2;
    level thread maps\_high_speed_clouds::cloudfastnone( 2 );
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_outdoor, 12.0 );
    level.player maps\_utility::delaythread( 13, maps\crash_utility::exo_temp_outdoor );

    if ( level.nextgen )
    {
        maps\_utility::array_spawn_function_targetname( "razorback_allies", ::crash_site_razorback_allies );
        maps\_utility::array_spawn_targetname( "razorback_allies", 1 );
    }

    wait 2;

    if ( level.nextgen )
        level.allies_bunker = maps\_utility::array_spawn_targetname( "bunker_allies", 1 );
    else
    {
        var_2 = getentarray( "bunker_allies", "targetname" );
        level.allies_bunker = maps\_utility::array_spawn_cg( var_2, 1 );
    }

    thread maps\_utility::center_screen_text( &"CRASH_INTROSCREEN_ANTARCTICA" );
    level notify( "stop_fast_clouds" );
    self notify( "fast_cloud_level_change" );
    self notify( "new_ramp" );
    level.player _meth_83D7( ( 0, 0, 0 ), 0 );
    wait 0.1;
    thread maps\_utility::autosave_by_name( "on_ground" );
    thread crash_site_dialogue();
    common_scripts\utility::flag_wait_either( "go_drop_pods", "drop_pod_failsafe" );
    _func_0D3( "cg_cinematicfullscreen", "0" );
    _func_0D3( "cg_cinematicCanPause", "0" );
    thread crash_site_dead_razorback_guys();
    wait 3;
    maps\_utility::battlechatter_on( "allies" );
    maps\_utility::battlechatter_on( "axis" );
    common_scripts\utility::flag_wait( "crash_site_done" );
}

crash_site_player()
{
    if ( level.start_point != "crash_site" )
    {
        level.player _meth_8310();

        foreach ( var_1 in level.player_weapons )
            level.player _meth_830E( var_1 );

        level.player _meth_8322();
        level.player _meth_8315( "iw5_hbra3_sp_opticstargetenhancer" );
        level.player _meth_8332( "iw5_hbra3_sp_opticstargetenhancer" );
    }

    level.player _meth_817D( "stand" );
    var_3 = maps\_utility::spawn_anim_model( "rig" );
    var_3 _meth_808E();
    thread maps\_shg_utility::disable_features_entering_cinema();
    level.player _meth_807D( var_3, "tag_player", 1, 0, 0, 0, 0 );
    soundscripts\_snd::snd_message( "ambush_events" );
    level.crash_site_animnode thread maps\_anim::anim_single_solo( var_3, "crash_atlas_plane_crash_player" );
    wait 3;
    level.player _meth_80A2( 0.25, 0.15, 0, 10, 10, 10, 7 );
    var_3 waittillmatch( "single anim", "player_land" );
    level.player _meth_80AD( "light_2s" );
    common_scripts\utility::flag_wait( "zero_view" );
    level.player _meth_80A2( 0.4, 0.15, 0, 0, 0, 0, 0 );
    common_scripts\utility::flag_wait( "unhide_cargo" );
    level.player _meth_80A2( 0.25, 0.15, 0, 10, 10, 10, 7 );
    var_4 = getent( "player_jetpack", "targetname" );
    var_4 show();
    var_3 waittillmatch( "single anim", "end" );
    var_5 = getentarray( "crash_site_triggers", "targetname" );

    foreach ( var_7 in var_5 )
        var_7 common_scripts\utility::trigger_on();

    level.player _meth_804F();
    thread maps\_shg_utility::enable_features_exiting_cinema();
    common_scripts\utility::flag_set( "crash_lighting_cinema_end" );
    level.player _meth_8119( 1 );
    level.player _meth_8301( 1 );
    level.player _meth_8304( 1 );
    level.player _meth_811A( 1 );
    level.player _meth_8300( 1 );
    level.player _meth_8130( 1 );
    level.player _meth_831E();
    thread maps\crash_utility::player_exo_enable();
    var_3 delete();
}

crash_site_player_gun()
{
    var_0 = maps\_utility::spawn_anim_model( "cs_gun" );
    level.crash_site_animnode maps\_anim::anim_first_frame_solo( var_0, "plane_crash_player_gun" );
    var_1 = spawn( "script_model", var_0 gettagorigin( "j_prop_1" ) );
    var_1 _meth_80B1( "npc_hbra3_nocamo" );
    var_1.angles = var_0 gettagangles( "j_prop_1" );
    var_1 _meth_804D( var_0, "j_prop_1" );
    common_scripts\utility::flag_wait( "white_fade_done" );
    level.crash_site_animnode maps\_anim::anim_single_solo( var_0, "plane_crash_player_gun" );
    var_1 delete();
    var_0 delete();
}

crash_site_cormack()
{
    level.cormack endon( "death" );
    level.cormack.ignoreme = 1;
    level.cormack.lastgroundtype = "snow";
    level.crash_site_animnode thread maps\_anim::anim_single_solo( level.cormack, "atlas_plane_crash" );
    playfxontag( common_scripts\utility::getfx( "jetpack_skyjack_trail" ), level.cormack, "tag_fx_engine_l_exhause" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "jetpack_skyjack_trail" ), level.cormack, "tag_fx_engine_r_exhause" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "jetpack_exhaust_exhaust_npc" ), level.cormack, "tag_fx_engine_l_exhause" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "jetpack_exhaust_exhaust_npc" ), level.cormack, "tag_fx_engine_r_exhause" );
    level.cormack waittillmatch( "single anim", "jets_off" );
    stopfxontag( common_scripts\utility::getfx( "jetpack_skyjack_trail" ), level.cormack, "tag_fx_engine_l_exhause" );
    stopfxontag( common_scripts\utility::getfx( "jetpack_skyjack_trail" ), level.cormack, "tag_fx_engine_r_exhause" );
    waitframe();
    stopfxontag( common_scripts\utility::getfx( "jetpack_exhaust_exhaust_npc" ), level.cormack, "tag_fx_engine_l_exhause" );
    stopfxontag( common_scripts\utility::getfx( "jetpack_exhaust_exhaust_npc" ), level.cormack, "tag_fx_engine_r_exhause" );
    level.cormack waittillmatch( "single anim", "cormack_land" );
    playfxontag( common_scripts\utility::getfx( "boost_dust_impact_ground" ), level.cormack, "j_ball_le" );
    level.cormack waittillmatch( "single anim", "pods_enter" );
    common_scripts\utility::flag_set( "go_drop_pods" );
    wait 1;
    maps\_utility::activate_trigger_with_targetname( "plane_allies_move" );
    level.cormack waittillmatch( "single anim", "end" );
    level.cormack maps\_utility::gun_recall();
    level.cormack maps\_utility::enable_ai_color_dontmove();
    stopfxontag( common_scripts\utility::getfx( "boost_dust_impact_ground" ), level.cormack, "j_ball_le" );
    wait 0.5;
    level.cormack maps\crash_utility::clear_additive_helmet_anim( 0 );
    maps\_utility::activate_trigger_with_targetname( "ambush_start_color" );
    common_scripts\utility::flag_set( "crash_site_battle_start" );
    level.cormack.ignoreme = 0;
    common_scripts\utility::flag_wait_either( "razorback_start", "player_loading_cargo" );
    thread crash_site_bg_warbirds();
    common_scripts\utility::flag_set( "crash_site_done" );
}

cormack_jetpack_switch( var_0 )
{
    var_1 = spawn( "script_model", level.cormack gettagorigin( "tag_jetpack" ) + ( 0, 0, -16 ) );
    var_1.angles = level.cormack gettagangles( "tag_jetpack" );
    var_1 _meth_80B1( "jetpack_sentinel_halo" );
    waitframe();
    level.cormack _meth_80B1( "body_hero_cormack_sentinel_halo" );
}

crash_site_ilana()
{
    level.ilana endon( "death" );
    level.ilana.ignoreme = 1;
    level.crash_site_animnode maps\_anim::anim_first_frame_solo( level.ilana, "atlas_plane_crash" );
    common_scripts\utility::flag_wait( "white_fade_done" );
    level.crash_site_animnode thread maps\_anim::anim_single_solo( level.ilana, "atlas_plane_crash" );
    level.ilana waittillmatch( "single anim", "end" );
    level.ilana.ignoreme = 0;
}

crash_site_plane()
{
    var_0 = getent( "crash_site_plane", "targetname" );
    var_0.animname = "cargo_plane";
    var_0 maps\_anim::setanimtree();
    level.crashing_plane = var_0;
    var_0 _meth_8048( "J_LT_WING" );
    var_0 _meth_8048( "J_RT_WING" );
    var_0 _meth_8048( "J_FLAP_L1" );
    var_0 _meth_8048( "J_FLAP_L2" );
    var_0 _meth_8048( "J_FLAP_R1" );
    var_0 _meth_8048( "J_FLAP_R2" );
    var_0 _meth_8048( "J_SPOILER_L1" );
    var_0 _meth_8048( "J_SPOILER_L2" );
    var_0 _meth_8048( "J_SPOILER_L3" );
    var_0 _meth_8048( "J_SPOILER_L4" );
    var_0 _meth_8048( "J_SPOILER_R1" );
    var_0 _meth_8048( "J_SPOILER_R2" );
    var_0 _meth_8048( "J_SPOILER_R3" );
    var_0 _meth_8048( "J_SPOILER_R4" );
    level.crash_site_animnode maps\_anim::anim_first_frame_solo( var_0, "atlas_plane_crash_plane" );
    waitframe();
    common_scripts\utility::flag_wait( "white_fade_done" );
    level.crash_site_animnode thread maps\_anim::anim_single_solo( var_0, "atlas_plane_crash_plane" );
    wait 0.15;
    playfxontag( level._effect["fire_burning_vtol_left"], var_0, "tag_smoke_lt_body" );
    wait 0.1;
    playfxontag( level._effect["fire_burning_vtol"], var_0, "tag_smoke_rt_body" );
    common_scripts\_exploder::exploder( 8124 );
    wait 0.3;

    if ( level.start_point != "crash_site" )
        playfxontag( level._effect["fx_crash_hud_flare"], var_0, "body_animate_jnt" );

    wait 0.7;
    common_scripts\_exploder::exploder( 1100 );
    wait 4.95;
    common_scripts\utility::flag_set( "crash_dof_fly_in" );
    wait 1.55;
    playfxontag( level._effect["crash_vtol_landing_exp"], var_0, "tag_smoke_rt_body" );
    wait 6;
    common_scripts\_exploder::exploder( 1300 );
    var_0 waittillmatch( "single anim", "end" );
    common_scripts\_exploder::kill_exploder( 8124 );

    if ( level.nextgen )
        common_scripts\utility::flag_wait( "cave_entry_done" );
    else
        level waittill( "tff_pre_site_to_caves" );

    stopfxontag( level._effect["fire_burning_vtol"], var_0, "tag_smoke_rt_body" );
    stopfxontag( level._effect["fire_burning_vtol_left"], var_0, "tag_smoke_lt_body" );
    waitframe();
    var_0 delete();
}

crash_site_chutes()
{
    var_0 = [];
    var_0[0] = maps\_utility::spawn_anim_model( "drone_chute1" );
    var_0[1] = maps\_utility::spawn_anim_model( "drone_chute2" );
    var_0[2] = maps\_utility::spawn_anim_model( "drone_chute3" );
    var_0[3] = maps\_utility::spawn_anim_model( "drone_cable" );
    level.crash_site_animnode thread maps\_anim::anim_single( var_0, "atlas_plane_crash" );
    var_0[0] waittillmatch( "single anim", "switch" );
    common_scripts\utility::array_call( var_0, ::hide );
    maps\_utility::array_delete( var_0 );
    var_1 = maps\_utility::spawn_anim_model( "ground_chute" );
    level.crash_site_animnode thread maps\_anim::anim_loop_solo( var_1, "crash_chute_idle", "stop_chute" );
    common_scripts\utility::flag_wait( "crash_site_done" );
    level.crash_site_animnode notify( "stop_chute" );
    wait 0.05;
    var_1 delete();
}

crash_site_runway()
{
    var_0 = getent( "runway_shell_geo_01", "targetname" );
    var_1 = getent( "runway_shell_geo_02", "targetname" );
    var_2 = getent( "runway_shell_geo_03", "targetname" );
    var_3 = getent( "runway_shell_geo_04", "targetname" );
    var_4 = getent( "runway_shell_geo_05", "targetname" );
    var_5 = getent( "runway_shell_geo_06", "targetname" );
    var_6 = getent( "runway_shell_geo_07", "targetname" );
    var_7 = getent( "runway_shell_geo_08", "targetname" );
    var_8 = getent( "runway_shell_geo_09", "targetname" );
    var_9 = getent( "runway_shell_geo_10", "targetname" );
    var_10 = getent( "runway_shell_geo_11", "targetname" );
    wait 5.05;
    var_0 _meth_8058();
    var_1 _meth_8058();
    var_0 delete();
    var_1 delete();
    wait 0.25;
    var_2 _meth_8058();
    var_2 delete();
    wait 0.45;
    var_3 _meth_8058();
    var_3 delete();
    wait 0.95;
    var_4 _meth_8058();
    var_4 delete();
    wait 0.23;
    var_5 _meth_8058();
    var_5 delete();
    wait 0.33;
    var_6 _meth_8058();
    var_6 delete();
    wait 0.49;
    var_7 _meth_8058();
    var_7 delete();
    wait 0.69;
    var_8 _meth_8058();
    var_8 delete();
    wait 0.61;
    var_9 _meth_8058();
    var_9 delete();
    wait 1.22;
    var_10 _meth_8058();
    var_10 delete();
    var_11 = getent( "crash_site_plane_snow", "targetname" );
    var_11 show();
    var_12 = getentarray( "crash_site_plane_snowpiles", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 show();

    wait 3.28;
    var_16 = getentarray( "crash_site_scorching", "targetname" );

    foreach ( var_18 in var_16 )
        var_18 show();

    var_20 = getentarray( "crash_site_debris_models", "targetname" );

    foreach ( var_14 in var_20 )
        var_14 show();
}

crash_site_drone()
{
    var_0 = maps\_utility::spawn_anim_model( "drone_pod" );
    level.crash_site_animnode maps\_anim::anim_first_frame_solo( var_0, "atlas_plane_crash_drone" );
    common_scripts\utility::flag_wait( "white_fade_done" );
    level.crash_site_animnode maps\_anim::anim_single_solo( var_0, "atlas_plane_crash_drone" );
}

crash_site_plane_allies()
{
    self endon( "death" );
    self.health = 500;
    self.canjumppath = 2.5;
    self.baseaccuracy *= 0.25;
    self.animname = self.script_noteworthy;
    maps\_utility::enable_ai_color_dontmove();
    var_0 = common_scripts\utility::spawn_tag_origin();
    self _meth_81A6( var_0.origin );
    self.ignoreall = 1;
    common_scripts\utility::flag_wait( "go_drop_pods" );
    self.ignoreall = 0;
    var_0 delete();
    self.health = int( self.health * 0.2 );
}

crash_site_razorback_allies()
{
    self.ignoreall = 1;
    self.canjumppath = 10;
    common_scripts\utility::flag_wait( "go_drop_pods" );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

crash_site_intro_killer()
{
    var_0 = maps\_utility::get_living_ai( "sent1", "script_noteworthy" );
    var_0.animname = "sent1";
    var_0 maps\_utility::disable_ai_color();
    level.crash_site_animnode maps\_anim::anim_single_solo( var_0, "atlas_plane_crash_craig" );
    var_1 = getnode( "killer_node", "targetname" );
    var_0 _meth_81A5( var_1 );
    var_0 waittill( "goal" );
    var_0 maps\_utility::enable_ai_color_dontmove();
}

crash_site_intro_killer2()
{
    var_0 = maps\_utility::get_living_ai( "sent2", "script_noteworthy" );
    var_0.animname = "sent2";
    var_0 maps\_utility::disable_ai_color();
    level.crash_site_animnode maps\_anim::anim_single_solo( var_0, "atlas_plane_crash_tony" );
    var_1 = getnode( "killer_node2", "targetname" );
    var_0 _meth_81A5( var_1 );
    var_0 waittill( "goal" );
    var_0 maps\_utility::enable_ai_color_dontmove();
}

crash_site_bunker_allies()
{
    self.baseaccuracy *= 0.25;
    thread maps\_utility::magic_bullet_shield();
    self.canjumppath = 2.5;
    self.ignoreall = 1;
    self.suppressionthreshold = 0.15;
    self waittill( "goal" );
    maps\_utility::enable_ai_color_dontmove();
    common_scripts\utility::flag_wait( "go_drop_pods" );
    self.ignoreall = 0;
}

crash_site_bunker_sentinels()
{
    common_scripts\utility::flag_wait( "razorback_start" );

    if ( level.nextgen )
    {
        level.bunker_guy01 = maps\_utility::get_living_ai( "bunker_ally_01", "script_noteworthy" );
        level.bunker_guy01.animname = "bunker_guy01";
        level.bunker_guy01 maps\_utility::disable_ai_color();
        var_0 = getnode( "bunker_ally_01_node", "targetname" );
        level.bunker_guy01 _meth_81A5( var_0 );
        level.bunker_guy01 thread bunker_settings();
        level.bunker_guy02 = maps\_utility::get_living_ai( "bunker_ally_02", "script_noteworthy" );
        level.bunker_guy02.animname = "bunker_guy02";
        level.bunker_guy02 maps\_utility::disable_ai_color();
        var_1 = getnode( "bunker_ally_02_node", "targetname" );
        level.bunker_guy02 _meth_81A5( var_1 );
        level.bunker_guy02 thread bunker_settings();
    }

    level.bunker_guy03 = maps\_utility::get_living_ai( "bunker_ally_03", "script_noteworthy" );
    level.bunker_guy03.animname = "bunker_guy03";
    level.bunker_guy03 maps\_utility::disable_ai_color();
    var_2 = getnode( "bunker_ally_03_node", "targetname" );
    level.bunker_guy03 _meth_81A5( var_2 );
    level.bunker_guy03 thread bunker_settings();
}

crash_site_dead_razorback_guys()
{
    if ( level.nextgen )
    {
        maps\_utility::array_spawn_function_targetname( "dead_razor_ally", ::dead_razorback_spawn );
        level.crash_site_ally_drones = maps\_utility::array_spawn_targetname( "dead_razor_ally", 1 );
    }
    else
    {

    }
}

dead_razorback_spawn()
{
    var_0 = common_scripts\utility::getstruct( self.script_noteworthy, "targetname" );
    self.animname = "generic";
    thread maps\crash_utility::disable_awareness();
    maps\_utility::set_battlechatter( 0 );
    maps\_utility::gun_remove();
    self.script_friendname = " ";
    self.name = " ";
    thread maps\_utility::magic_bullet_shield();
    self _meth_8171();
    var_0 thread maps\_anim::anim_loop_solo( self, self.script_animation, "stop_loop" );
}

crash_site_combat_manager()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    var_0 = getent( "bunker_badplace", "targetname" );
    badplace_brush( "bunker_badplace", -1, var_0, "axis" );
    common_scripts\utility::flag_wait( "wave1_pods_done" );
    thread fake_drop_pods();
    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_1 = 16 - level.pod_enemies.size;
    var_2 = 6 - var_1;
    var_2 = clamp( var_2, 0, 6 );
    var_2 = int( var_2 );
    thread maps\crash_utility::ai_array_killcount_flag_set( level.pod_enemies, var_2, "drop_pod_failsafe" );
    common_scripts\utility::flag_wait( "drop_pod_failsafe" );
    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_4 = getent( "cs_advance_1", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        maps\_utility::activate_trigger( "cs_advance_1", "script_noteworthy", level.player );

    waitframe();

    if ( isdefined( var_4 ) )
        var_4 delete();

    common_scripts\utility::flag_set( "wave2_pods_starting" );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_0_n", "vol_ambush_combat_1_n", 0.05, 0.25 );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_0_s", "vol_ambush_combat_1_s", 0.05, 0.25 );
    common_scripts\utility::flag_wait( "wave2_pods_done" );

    if ( !common_scripts\utility::flag( "cs_pre_fail_state" ) && !common_scripts\utility::flag( "above_hole" ) )
        thread maps\_utility::autosave_by_name( "cs_combat_1" );

    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_1 = 12 - level.pod_enemies.size;

    if ( var_1 < 0 )
        var_1 = 0;

    var_2 = 5 - var_1;
    var_2 = clamp( var_2, 0, 5 );
    var_2 = int( var_2 );
    thread maps\crash_utility::ai_array_killcount_flag_set( level.pod_enemies, var_2, "fallback_vol_2" );
    common_scripts\utility::flag_wait( "fallback_vol_2" );
    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_4 = getent( "cs_advance_2", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        maps\_utility::activate_trigger( "cs_advance_2", "script_noteworthy", level.player );

    waitframe();

    if ( isdefined( var_4 ) )
        var_4 delete();

    common_scripts\utility::flag_set( "wave3_pods_starting" );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_1_n", "vol_ambush_combat_2_n", 0.05, 0.25 );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_1_s", "vol_ambush_combat_2_s", 0.05, 0.25 );
    wait 12.2;
    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_1 = 16 - level.pod_enemies.size;

    if ( var_1 < 0 )
        var_1 = 0;

    var_2 = 8 - var_1;
    var_2 = clamp( var_2, 0, 8 );
    var_2 = int( var_2 );
    var_4 = getent( "cs_advance_3", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        maps\_utility::activate_trigger( "cs_advance_3", "script_noteworthy", level.player );

    waitframe();

    if ( isdefined( var_4 ) )
        var_4 delete();

    thread retreat_from_vol_to_vol( "vol_ambush_combat_2_n", "vol_ambush_combat_3_n", 0.05, 0.25 );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_2_s", "vol_ambush_combat_3_s", 0.05, 0.25 );
    common_scripts\utility::flag_wait( "wave3_pods_done" );

    if ( !common_scripts\utility::flag( "cs_pre_fail_state" ) && !common_scripts\utility::flag( "above_hole" ) )
        thread maps\_utility::autosave_by_name( "cs_combat_2" );

    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_1 = 16 - level.pod_enemies.size;

    if ( var_1 < 0 )
        var_1 = 0;

    var_2 = 8 - var_1;
    var_2 = clamp( var_2, 0, 8 );
    var_2 = int( var_2 );
    thread maps\crash_utility::ai_array_killcount_flag_set( level.pod_enemies, var_2, "fallback_vol_3" );
    common_scripts\utility::flag_wait( "fallback_vol_3" );
    var_4 = getent( "cs_advance_4", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        maps\_utility::activate_trigger( "cs_advance_4", "script_noteworthy", level.player );

    waitframe();

    if ( isdefined( var_4 ) )
        var_4 delete();

    thread retreat_from_vol_to_vol( "vol_ambush_combat_3_n", "vol_ambush_combat_4_n", 0.05, 0.15 );
    thread retreat_from_vol_to_vol( "vol_ambush_combat_3_s", "bg_ai_volume", 0.05, 0.15 );
    level.pod_enemies = common_scripts\utility::array_removeundefined( level.pod_enemies );
    var_3 = level.pod_enemies.size;
    var_2 = level.pod_enemies.size - 8;
    var_2 = clamp( var_2, 0, 10 );
    var_2 = int( var_2 );
    thread maps\crash_utility::ai_array_killcount_flag_set( level.pod_enemies, var_2, "razorback_start" );
    common_scripts\utility::flag_wait( "razorback_start" );
    common_scripts\utility::flag_set( "start_background_elements" );
    var_4 = getent( "cs_advance_5", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        var_4 delete();
}

crash_site_kill_counter()
{
    var_0 = 0;

    while ( !isdefined( level.pod_enemies ) )
        wait 0.05;

    while ( level.pod_enemies.size < 1 )
        wait 0.05;

    while ( var_0 < 10 )
    {
        maps\_utility::waittill_dead_or_dying( level.pod_enemies, 1 );
        var_0 += 1;
    }

    common_scripts\utility::flag_set( "keep_pushing" );

    while ( var_0 < 25 )
    {
        maps\_utility::waittill_dead_or_dying( level.pod_enemies, 1 );
        var_0 += 1;
    }

    common_scripts\utility::flag_set( "rz_pilot_vo" );
    common_scripts\utility::flag_set( "obj_move_dot_razorback" );
}

retreat_from_vol_to_vol( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_0, "targetname" );
    var_5 = var_4 maps\_utility::get_ai_touching_volume( "axis" );
    var_6 = getent( var_1, "targetname" );
    var_7 = getnode( var_6.target, "targetname" );

    foreach ( var_9 in var_5 )
    {
        if ( isdefined( var_9 ) && isalive( var_9 ) )
        {
            if ( issubstr( var_9.model, "shotgun" ) )
                return;

            var_9.ignoresuppression = 1;
            var_9.forcegoal = 0;
            var_9.fixednode = 0;
            var_9.pathrandompercent = randomintrange( 75, 100 );
            var_9 _meth_81A9( var_6 );
            wait 5;

            if ( isdefined( var_9 ) && isalive( var_9 ) )
                var_9.ignoresuppression = 0;
        }
    }
}

fake_drop_pods()
{
    level endon( "crash_site_done" );
    var_0 = [];
    var_0[0] = getent( "fake_drop_pod_1", "targetname" );
    var_0[1] = getent( "fake_drop_pod_2", "targetname" );
    var_0[2] = getent( "fake_drop_pod_3", "targetname" );
    var_0[3] = getent( "fake_drop_pod_4", "targetname" );
    var_0[4] = getent( "fake_drop_pod_5", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = getent( var_0[var_1].target, "targetname" );
        wait(randomintrange( 5, 10 ));

        while ( !level.player _meth_8214( var_2.origin, 65, 400 ) )
            wait 0.05;

        var_0[var_1] thread drop_pod_fall();
    }
}

crash_site_drop_pod_manager()
{
    level endon( "crash_site_done" );
    level endon( "stop_drop_pods" );
    level.pod_enemies = [];
    common_scripts\utility::flag_wait( "go_drop_pods" );
    var_0 = getentarray( "drop_pod_0_clip", "targetname" );
    var_1 = getent( "drop_pod_0", "targetname" );
    var_2 = getentarray( "drop_pod_0_crater", "targetname" );
    var_1 thread drop_pod_fall( "enemy", var_2 );
    var_3 = getent( "drop_pod_1", "targetname" );
    var_4 = getentarray( "drop_pod_1_crater", "targetname" );
    var_5 = getent( "drop_pod_2", "targetname" );
    var_6 = getentarray( "drop_pod_2_crater", "targetname" );
    var_7 = getent( "drop_pod_3", "targetname" );
    var_8 = getentarray( "drop_pod_3_crater", "targetname" );
    wait 0.75;
    var_3 thread drop_pod_fall( "enemy", var_4 );
    wait(randomfloatrange( 1.25, 2.25 ));
    maps\_utility::array_spawn_function_targetname( "cs_first_response", ::first_response );

    if ( level.nextgen )
        maps\_utility::array_spawn_targetname( "cs_first_response", 1 );
    else
    {
        var_9 = getentarray( "cs_first_response", "targetname" );
        maps\_utility::array_spawn_cg( var_9, 1 );
    }

    var_5 thread drop_pod_fall( "enemy", var_6 );
    wait(randomfloatrange( 4.0, 5.5 ));
    var_7 thread drop_pod_fall( "enemy", var_8 );
    wait 3.6;
    common_scripts\utility::flag_set( "wave1_pods_done" );
    common_scripts\utility::flag_wait( "wave2_pods_starting" );
    var_10 = getent( "drop_pod_4", "targetname" );
    var_11 = getent( "drop_pod_5", "targetname" );
    var_12 = getent( "drop_pod_6", "targetname" );
    var_13 = getent( var_10.target, "targetname" );
    var_14 = getent( var_11.target, "targetname" );
    var_15 = getent( var_12.target, "targetname" );
    var_16 = getentarray( "drop_pod_4_crater", "targetname" );
    var_17 = getentarray( "drop_pod_5_crater", "targetname" );
    var_18 = getentarray( "drop_pod_6_crater", "targetname" );
    wait(randomfloatrange( 0.75, 1.75 ));
    thread drop_pod_chooser( var_10, var_13, var_16, var_11, var_14, var_17, var_12, var_15, var_18 );
    wait(randomfloatrange( 2.75, 5.0 ));
    common_scripts\utility::flag_set( "choose_drop_pod" );
    wait(randomfloatrange( 4.0, 5.5 ));
    common_scripts\utility::flag_set( "choose_drop_pod" );
    wait 3.6;
    level notify( "done_choosing_drop_pods" );
    common_scripts\utility::flag_set( "wave2_pods_done" );
    common_scripts\utility::flag_wait( "wave3_pods_starting" );
    var_19 = getent( "drop_pod_7", "targetname" );
    var_20 = getent( "drop_pod_8", "targetname" );
    var_21 = getent( "drop_pod_9", "targetname" );
    var_22 = getent( var_19.target, "targetname" );
    var_23 = getent( var_20.target, "targetname" );
    var_24 = getent( var_21.target, "targetname" );
    var_25 = getentarray( "drop_pod_7_crater", "targetname" );
    var_26 = getentarray( "drop_pod_8_crater", "targetname" );
    var_27 = getentarray( "drop_pod_9_crater", "targetname" );
    var_28 = getent( "drop_pod_10", "targetname" );
    var_29 = getentarray( "drop_pod_10_crater", "targetname" );
    thread drop_pod_chooser( var_19, var_22, var_25, var_20, var_23, var_26, var_21, var_24, var_27 );
    wait 3.6;
    common_scripts\utility::flag_set( "choose_drop_pod" );
    wait(randomfloatrange( 2.75, 5.0 ));
    common_scripts\utility::flag_set( "choose_drop_pod" );
    wait 3.6;
    level notify( "done_choosing_drop_pods" );
    common_scripts\utility::flag_set( "wave3_pods_done" );
}

drop_pod_chooser( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level endon( "done_choosing_drop_pods" );
    var_0.valid = 1;
    var_3.valid = 1;
    var_6.valid = 1;

    for (;;)
    {
        if ( isdefined( var_0 ) && level.player _meth_8214( var_1.origin, 65, 200 ) && var_0.valid == 1 )
        {
            var_0 thread drop_pod_fall( "enemy", var_2 );
            var_0.valid = 0;
        }
        else if ( isdefined( var_3 ) && level.player _meth_8214( var_4.origin, 65, 200 ) && var_3.valid == 1 )
        {
            var_3 thread drop_pod_fall( "enemy", var_5 );
            var_3.valid = 0;
        }
        else if ( isdefined( var_6 ) && level.player _meth_8214( var_7.origin, 65, 200 ) && var_6.valid == 1 )
        {
            var_6 thread drop_pod_fall( "enemy", var_8 );
            var_6.valid = 0;
        }
        else if ( isdefined( var_0 ) && var_0.valid == 1 )
        {
            var_0 thread drop_pod_fall( "enemy", var_2 );
            var_0.valid = 0;
        }
        else if ( isdefined( var_3 ) && var_3.valid == 1 )
        {
            var_3 thread drop_pod_fall( "enemy", var_5 );
            var_3.valid = 0;
        }
        else if ( isdefined( var_6 ) && var_6.valid == 1 )
        {
            var_6 thread drop_pod_fall( "enemy", var_8 );
            var_6.valid = 0;
        }
        else
        {

        }

        common_scripts\utility::flag_clear( "choose_drop_pod" );
        common_scripts\utility::flag_wait( "choose_drop_pod" );
    }
}

first_response()
{
    self.canjumppath = 1;
    maps\_utility::magic_bullet_shield();
    wait 3;
    maps\_utility::stop_magic_bullet_shield();
}

crash_site_dialogue()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "crash_site_battle_start" );
    common_scripts\utility::flag_set( "obj_start_goto_razorback" );
    wait 1;
    thread player_boost_hint();
    thread crash_site_battle_chatter_manager();
    common_scripts\utility::flag_wait( "keep_pushing" );

    if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
    {
        maps\_utility::smart_radio_dialogue( "crsh_ss1_heavylosses" );
        wait 0.25;
        maps\_utility::smart_radio_dialogue( "crsh_iln_makeit" );
        maps\_utility::smart_radio_dialogue( "crsh_crmk_pushthrough3" );
        wait 0.75;

        if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
            maps\_utility::smart_radio_dialogue( "crsh_ss1_mandown" );

        wait 1.5;

        if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
            maps\_utility::smart_radio_dialogue( "crsh_crmk_gettocargo" );
    }

    common_scripts\utility::flag_wait( "rz_pilot_vo" );

    if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
    {
        maps\_utility::smart_radio_dialogue( "crsh_grdn5_liftingoff" );
        maps\_utility::smart_radio_dialogue( "crsh_crmk_yourass" );
    }

    var_0 = maps\_utility::make_array( "crsh_crmk_cargoahead", "crsh_crmk_pushtocargo" );
    thread maps\crash_utility::nag_until_flag( var_0, "razorback_start", 15, 20, 5 );
}

crash_site_battle_chatter_manager()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    thread crash_site_battle_chatter_chooser( "crsh_iln_hostileswest", "razorback_start", 0.75 );
    thread crash_site_battle_chatter_chooser( "crsh_ss1_southridge", "pod4_5_spawned", 0.35 );
    thread crash_site_battle_chatter_chooser( "crsh_ss1_mnorthridge", "pod7_spawned", 0.35 );
    thread crash_site_battle_chatter_north();
    thread crash_site_battle_chatter_south();
    thread crash_site_bg_battle_chatter_north();
    thread crash_site_bg_battle_chatter_south();
}

crash_site_battle_chatter_north()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    level endon( "right_flank_called" );
    level endon( "player_pre_loading_cargo" );
    var_0 = getent( "vol_ambush_combat_north", "targetname" );

    for (;;)
    {
        var_1 = 0;
        var_2 = maps\_utility::get_living_ai_array( "pod_enemies", "script_noteworthy" );

        foreach ( var_4 in var_2 )
        {
            if ( var_4 _meth_80A9( var_0 ) )
                var_1 += 1;
        }

        if ( var_1 > 12 )
        {
            thread crash_site_battle_chatter_chooser( "crsh_ss2_supressright" );
            level notify( "right_flank_called" );
        }

        wait 0.05;
    }
}

crash_site_battle_chatter_south()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    level endon( "left_flank_called" );
    level endon( "player_pre_loading_cargo" );
    level.player endon( "death" );
    var_0 = getent( "vol_ambush_combat_south", "targetname" );

    for (;;)
    {
        var_1 = 0;
        var_2 = maps\_utility::get_living_ai_array( "pod_enemies", "script_noteworthy" );

        foreach ( var_4 in var_2 )
        {
            if ( var_4 _meth_80A9( var_0 ) )
                var_1 += 1;
        }

        if ( var_1 > 12 )
        {
            thread crash_site_battle_chatter_chooser( "crsh_crmk_moremen" );
            level notify( "left_flank_called" );
        }

        wait 0.05;
    }
}

crash_site_bg_battle_chatter_north()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    level endon( "bg_right_flank_called" );
    level endon( "player_pre_loading_cargo" );
    var_0 = getent( "vol_bg_combat_north", "targetname" );

    for (;;)
    {
        var_1 = 0;
        var_2 = maps\_utility::get_living_ai_array( "pod_enemies", "script_noteworthy" );
        var_3 = maps\_utility::get_living_ai_array( "background_atlas", "script_noteworthy" );
        var_2 = common_scripts\utility::array_combine( var_2, var_3 );

        foreach ( var_5 in var_2 )
        {
            if ( var_5 _meth_80A9( var_0 ) )
                var_1 += 1;
        }

        if ( var_1 > 6 )
        {
            thread crash_site_battle_chatter_chooser( "crsh_ss3_hostilesnorth" );
            level notify( "bg_right_flank_called" );
        }

        wait 0.05;
    }
}

crash_site_bg_battle_chatter_south()
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    level endon( "bg_left_flank_called" );
    level endon( "player_pre_loading_cargo" );
    var_0 = getent( "vol_bg_combat_south", "targetname" );

    for (;;)
    {
        var_1 = 0;
        var_2 = maps\_utility::get_living_ai_array( "pod_enemies", "script_noteworthy" );
        var_3 = maps\_utility::get_living_ai_array( "background_atlas", "script_noteworthy" );
        var_2 = common_scripts\utility::array_combine( var_2, var_3 );

        foreach ( var_5 in var_2 )
        {
            if ( var_5 _meth_80A9( var_0 ) )
                var_1 += 1;
        }

        if ( var_1 > 6 )
        {
            thread crash_site_battle_chatter_chooser( "crsh_ss3_hostilesouth" );
            level notify( "bg_left_flank_called" );
        }

        wait 0.05;
    }
}

crash_site_battle_chatter_chooser( var_0, var_1, var_2 )
{
    level endon( "crash_site_failed" );
    level.player endon( "death" );
    level endon( "stop_drone_respawn" );

    if ( isdefined( var_1 ) )
        common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( var_2 ) )
        wait(var_2);

    switch ( var_0 )
    {
        case "crsh_iln_tangoseast":
            maps\_utility::smart_radio_dialogue( "crsh_iln_hostileseast" );
            break;
        case "crsh_iln_tangoswest":
            maps\_utility::smart_radio_dialogue( "crsh_iln_hostileswest" );
            break;
        case "crsh_crmk_leftflank":
            maps\_utility::smart_radio_dialogue( "crsh_crmk_moremen" );
            break;
        case "crsh_ss1_podssouth":
            maps\_utility::smart_radio_dialogue( "crsh_ss1_southridge" );
            break;
        case "crsh_ss1_podsnorth":
            maps\_utility::smart_radio_dialogue( "crsh_ss1_mnorthridge" );
            break;
        case "crsh_ss2_rightflank1":
            maps\_utility::smart_radio_dialogue( "crsh_ss2_supressright" );
            break;
        case "crsh_ss3_hostilesouth1":
            maps\_utility::smart_radio_dialogue( "crsh_ss3_hostilesouth" );
            break;
        case "crsh_ss3_hostilesnorth1":
            maps\_utility::smart_radio_dialogue( "crsh_ss3_hostilesnorth" );
            break;
    }
}

player_boost_hint()
{
    level.player maps\_utility::hintdisplayhandler( "boost_jump", 4 );
}

should_break_boost_jump_hint()
{
    return level.player _meth_83B4();
}

crash_site_bg_warbirds()
{
    thread crash_site_bg_warbird_2();
    wait 5;
    thread crash_site_bg_warbird_1();
    wait 5;
    thread crash_site_bg_warbird_3();
}

crash_site_bg_warbird_1()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "bg_warbird_1" );
    var_0 maps\_vehicle::godon();
    var_1 = getent( "bg_warbird_1_cables", "targetname" );
    var_2 = getent( "bg_warbird_1_walker", "targetname" );
    var_1 _meth_804D( var_0 );
    var_2 _meth_804D( var_0 );
    waitframe();
    var_0 maps\_utility::vehicle_detachfrompath();
    var_0 _meth_8283( 25, 15, 5 );
    var_3 = common_scripts\utility::getstruct( "bg_warbird_1_path", "targetname" );
    var_0 thread maps\_utility::vehicle_dynamicpath( var_3, 0 );
    common_scripts\utility::flag_wait_any( "bg_warbird1_done", "player_loading_cargo" );
    var_1 delete();
    var_2 delete();
    var_0 delete();
}

crash_site_bg_warbird_2()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "bg_warbird_2" );
    var_0 maps\_vehicle::godon();
    var_1 = getent( "bg_warbird_2_cables", "targetname" );
    var_2 = getent( "bg_warbird_2_walker", "targetname" );
    var_1 _meth_804D( var_0 );
    var_2 _meth_804D( var_0 );
    waitframe();
    var_0 maps\_utility::vehicle_detachfrompath();
    var_0 _meth_8283( 25, 15, 5 );
    var_3 = common_scripts\utility::getstruct( "bg_warbird_2_path", "targetname" );
    var_0 thread maps\_utility::vehicle_dynamicpath( var_3, 0 );
    common_scripts\utility::flag_wait_any( "bg_warbird2_done", "player_loading_cargo" );
    var_1 delete();
    var_2 delete();
    var_0 delete();
}

crash_site_bg_warbird_3()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "bg_warbird_3" );
    var_0 maps\_vehicle::godon();
    var_1 = getent( "bg_warbird_3_cables", "targetname" );
    var_2 = getent( "bg_warbird_3_walker", "targetname" );
    var_1 _meth_804D( var_0 );
    var_2 _meth_804D( var_0 );
    waitframe();
    var_0 maps\_utility::vehicle_detachfrompath();
    var_0 _meth_8283( 25, 15, 5 );
    var_3 = common_scripts\utility::getstruct( "bg_warbird_3_path", "targetname" );
    var_0 thread maps\_utility::vehicle_dynamicpath( var_3, 0 );
    common_scripts\utility::flag_wait_any( "bg_warbird3_done", "player_loading_cargo" );
    var_1 delete();
    var_2 delete();
    var_0 delete();
}

drop_pod_fall( var_0, var_1 )
{
    self show();
    var_2 = getent( self.target, "targetname" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 _meth_804D( self );
    playfxontag( common_scripts\utility::getfx( "orbital_pod_trail_crsh" ), var_3, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "smoketrail_groundtoair" ), var_3, "tag_origin" );
    soundscripts\_snd::snd_message( "drop_pod", self );
    self _meth_82AE( var_2.origin, 2.5 );
    wait 2.5;
    stopfxontag( common_scripts\utility::getfx( "orbital_pod_trail_crsh" ), var_3, "tag_origin" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_groundtoair" ), var_3, "tag_origin" );
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin += ( 0, 0, 24 );
    playfxontag( common_scripts\utility::getfx( "drop_pod_landing_impact_snow" ), var_4, "tag_origin" );
    level.player _meth_80AD( "heavy_1s" );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_6 in var_1 )
            var_6 show();
    }

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "drop_pod_node" )
        thread drop_pod_clip();

    wait 0.75;
    level endon( "stop_drone_respawn" );

    if ( !isdefined( var_0 ) )
        var_2 delete();
    else
        var_2 show();

    self delete();
    wait 0.25;

    if ( isdefined( var_0 ) && var_0 == "enemy" )
    {
        var_8 = undefined;

        if ( isdefined( var_2.script_parameters ) && var_2.script_parameters == "no_microwave" )
            var_8 = 0;
        else
            var_8 = 1;

        var_2 thread crash_site_drop_pod_enemies( var_8 );
    }
    else if ( isdefined( var_0 ) && var_0 == "drone" )
    {
        var_9 = getentarray( var_2.target, "targetname" );

        foreach ( var_11 in var_9 )
        {
            if ( isdefined( var_11.script_parameters ) && var_11.script_parameters == "first" )
                level thread bunker_respawn_handler( var_11 );
        }
    }
    else if ( isdefined( var_0 ) && var_0 == "mech" )
        var_2 thread cave_entry_goliath_spawn();

    wait 0.4;
    stopfxontag( common_scripts\utility::getfx( "drop_pod_landing_impact_snow" ), var_4, "tag_origin" );
    var_3 delete();
    var_4 delete();
}

drop_pod_clip()
{
    var_0 = getent( self.targetname + "_clip", "targetname" );
    var_0 maps\_utility::ent_flag_init( "touching_clip" );

    while ( !var_0 maps\_utility::ent_flag( "touching_clip" ) )
    {
        if ( !level.player _meth_80A9( var_0 ) )
        {
            var_0 _meth_82BE();
            var_0 maps\_utility::ent_flag_set( "touching_clip" );
        }

        waitframe();
    }
}

crash_site_drop_pod_enemies( var_0 )
{
    level endon( "crash_site_done" );
    var_1 = getentarray( "pod_spawners", "targetname" );
    var_2 = common_scripts\utility::getstructarray( self.target, "targetname" );
    var_3 = [];

    if ( isdefined( var_1[0] ) && isdefined( var_2[0] ) )
    {
        for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        {
            var_1[var_4].origin = var_2[var_4].origin;

            if ( isdefined( var_2[var_4].angles ) )
                var_1[var_4].angles = var_2[var_4].angles;

            var_3[var_4] = var_1[var_4] maps\_utility::spawn_ai( 1 );
            common_scripts\utility::add_to_array( var_3, var_3[var_4] );

            if ( isdefined( var_0 ) && var_0 == 1 )
            {
                if ( randomint( 100 ) < 25 )
                    var_3[var_4] maps\crash_utility::equip_microwave_grenade();
            }
            else
                var_3[var_4].grenadeammo = 1;

            var_3[var_4] thread crash_site_jump_node_usage_scale( 10.0, 1.0, 5.0 );

            if ( var_2[var_4].script_noteworthy == "node" )
            {
                var_5 = getnode( var_2[var_4].target, "targetname" );
                var_3[var_4].goalradius = 32;
                var_3[var_4] _meth_81A5( var_5 );
                continue;
            }

            if ( var_2[var_4].script_noteworthy == "volume" )
            {
                var_6 = getent( var_2[var_4].target, "targetname" );
                var_3[var_4] _meth_81A9( var_6 );
                continue;
            }
        }
    }

    level.pod_enemies = maps\_utility::array_merge( level.pod_enemies, var_3 );
}

crash_site_jump_node_usage_scale( var_0, var_1, var_2 )
{
    self endon( "death" );
    self.canjumppath = var_0;
    wait(var_2);
    self.canjumppath = var_1;
}

background_drop_pods()
{
    level endon( "stop_drone_respawn" );
    level.bg_guys = getentarray( "background_atlas", "script_noteworthy" );
    var_0 = getentarray( "drop_pod_background", "targetname" );

    foreach ( var_2 in var_0 )
    {
        common_scripts\utility::flag_wait( "start_background_elements" );

        if ( level.start_point == "cave_entry" )
            wait(randomfloatrange( 0, 0.5 ));
        else
            wait(randomfloatrange( 0, 7 ));

        var_2 thread drop_pod_fall( "drone" );
    }
}

bunker_respawn_handler( var_0 )
{
    level endon( "cave_entry_done" );
    wait(randomfloatrange( 0.5, 3.0 ));
    var_1 = var_0 maps\_utility::try_forever_spawn();
    var_1.baseaccuracy *= 0.9;
    var_1.grenadeammo = 0;
    var_2 = getent( var_0.script_linkto, "script_linkname" );

    for (;;)
    {
        level.crash_site_drones = common_scripts\utility::add_to_array( level.crash_site_drones, var_1 );
        var_3[0] = var_1;
        maps\_utility::waittill_dead_or_dying( var_3 );
        level endon( "stop_drone_respawn" );
        wait(randomfloatrange( 0.5, 3.0 ));

        if ( common_scripts\utility::cointoss() )
        {
            var_1 = var_0 maps\_utility::try_forever_spawn();
            var_1.baseaccuracy *= 0.9;
            var_1.grenadeammo = 0;
            continue;
        }

        var_1 = var_2 maps\_utility::try_forever_spawn();
        var_1.baseaccuracy *= 0.9;
        var_1.grenadeammo = 0;
    }
}

crash_site_random_bg_explosion()
{
    level endon( "cave_entry_done" );
    var_0 = common_scripts\utility::getstructarray( "ambient_snow_explosion", "targetname" );
    common_scripts\utility::flag_wait( "fallback_vol_3" );

    for (;;)
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );
        var_1 = var_0[0] common_scripts\utility::spawn_tag_origin();
        var_1.angles = ( -90, 0, 0 );
        level.background_org = var_1;
        playfxontag( common_scripts\utility::getfx( "ambient_explosion_snow_01" ), var_1, "tag_origin" );
        soundscripts\_snd::snd_message( "background_explosion", var_1.origin );
        wait 2;
        stopfxontag( common_scripts\utility::getfx( "ambient_explosion_snow_01" ), var_1, "tag_origin" );
        wait(randomintrange( 1, 6 ));
        var_1 delete();
    }
}

crash_site_random_playspace_explosion()
{
    level endon( "cave_entry_done" );
    var_0 = common_scripts\utility::getstructarray( "ambient_snow_explosion_playspace", "targetname" );
    common_scripts\utility::flag_wait( "crash_site_battle_start" );
    wait 10;

    for (;;)
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );
        var_1 = var_0[0] common_scripts\utility::spawn_tag_origin();
        var_1.angles = ( -90, 0, 0 );
        level.playspace_org = var_1;
        var_2 = distance2d( level.player.origin, var_1.origin );

        if ( var_2 > 448 )
        {
            playfxontag( common_scripts\utility::getfx( "ambient_exp_snow_playspace" ), var_1, "tag_origin" );
            soundscripts\_snd::snd_message( "playspace_explosion", var_1.origin, var_2 );
        }

        wait(randomfloatrange( 2.0, 5.5 ));
        var_1 delete();
    }
}

kill_trigger_array()
{
    level endon( "cave_entry_done" );
    var_0 = getentarray( "crash_site_fail", "targetname" );
    var_1 = 0;
    common_scripts\utility::flag_wait( "crash_site_battle_start" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "cs_pre_fail_state" );
        common_scripts\utility::flag_clear( "player_returning_to_map" );
        thread maps\_utility::smart_radio_dialogue( "crsh_crmk_staywithus" );
        maps\_utility::hintdisplayhandler( "hint_dont_leave_mission" );
        wait 2.5;

        foreach ( var_3 in var_0 )
        {
            if ( level.player _meth_80A9( var_3 ) )
                var_1 = 1;
        }

        if ( var_1 )
        {
            thread maps\_utility::smart_radio_dialogue( "crsh_crmk_getback" );
            wait 2.75;

            foreach ( var_3 in var_0 )
            {
                if ( level.player _meth_80A9( var_3 ) )
                    var_1 = 1;
            }

            if ( var_1 )
            {
                level.cormack maps\_utility::stop_magic_bullet_shield();
                level.ilana maps\_utility::stop_magic_bullet_shield();
                level.cormack _meth_8052();
                level.ilana _meth_8052();
                level notify( "crash_site_failed" );
                wait 0.15;
                setdvar( "ui_deadquote", &"CRASH_FAIL_ALLIES_KILLED" );
                maps\_utility::missionfailedwrapper();
            }
        }

        common_scripts\utility::flag_clear( "cs_pre_fail_state" );
        common_scripts\utility::flag_set( "player_returning_to_map" );
        var_1 = 0;
        wait 0.05;
    }
}

should_break_dont_leave()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "player_returning_to_map" ) )
        return 1;
    else
        return 0;
}

check_potential_falling_death()
{
    level endon( "cave_entry_done" );
    var_0 = getent( "crash_site_above_hole", "targetname" );

    for (;;)
    {
        if ( level.player _meth_80A9( var_0 ) )
            common_scripts\utility::flag_set( "above_hole" );

        if ( !level.player _meth_80A9( var_0 ) )
            common_scripts\utility::flag_clear( "above_hole" );

        wait 0.05;
    }
}

falling_death()
{
    level endon( "cave_entry_done" );
    var_0 = getent( "crash_site_fall_death", "targetname" );

    for (;;)
    {
        if ( level.player _meth_80A9( var_0 ) )
        {
            wait 0.5;
            setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
            maps\_utility::missionfailedwrapper();
            level.player thread maps\_player_exo::player_exo_deactivate();
        }

        wait 0.05;
    }
}

begin_cave_entry()
{
    level.player endon( "death" );
    level.cave_entry_animnode = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "mech" );
    createthreatbiasgroup( "heroes" );
    level.player _meth_8177( "player" );
    level.cormack _meth_8177( "heroes" );
    level.ilana _meth_8177( "heroes" );
    thread razorback_cormack();
    thread razorback_ilana();
    thread razorback_dialogue();
    common_scripts\utility::flag_wait( "razorback_loaded" );
    wait 4;
    thread cave_entry_goliaths();
    wait 0.25;
    thread cave_entry_sentinel();
    wait 1;
    wait 10;
    wait 1.5;
    common_scripts\utility::flag_set( "tank_incoming" );
    thread cave_entry_dialogue();
    thread cave_entry_walker_tank();
    common_scripts\utility::flag_wait( "tank_firing_missiles" );
    level.cormack thread tank_missile_react();
    level.ilana thread tank_missile_react();
    common_scripts\utility::flag_wait( "start_bunker_collapse" );
    soundscripts\_snd::snd_message( "cave_entry" );
    common_scripts\utility::flag_set( "obj_update_goto_razorback" );
    common_scripts\utility::flag_set( "obj_end_goto_razorback" );

    if ( level.currentgen )
        level notify( "end_crash_perf_monitor" );

    thread cave_entry_scene();
    thread cave_entry_slide_exploders();
    common_scripts\utility::flag_wait( "cave_entry_done" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    level.cormack _meth_8166();
    level.ilana _meth_8166();
    level.cormack maps\_utility::set_ignoresuppression( 0 );
    level.cormack maps\_utility::set_ignoreall( 0 );
    level.ilana maps\_utility::set_ignoresuppression( 0 );
    level.ilana maps\_utility::set_ignoreall( 0 );
    level.player _meth_8177();
    level.cormack _meth_8177();
    level.ilana _meth_8177();
}

tank_missile_react()
{
    level endon( "start_bunker_collapse" );
    maps\_utility::anim_stopanimscripted();
    self _meth_81CA( "stand", "crouch" );
    var_0 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    maps\_utility::set_ignoresuppression( 1 );
    maps\_utility::set_ignoreall( 1 );
    var_0 maps\_anim::anim_reach_solo( self, "bunker_spot_missiles" );
    var_0 thread maps\_anim::anim_single_solo( self, "bunker_spot_missiles" );
}

cave_entry_dialogue()
{
    wait 5;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_onhorizon" );
    common_scripts\utility::flag_wait( "tank_firing_missiles" );
    wait 0.2;
    maps\_utility::smart_radio_dialogue( "crsh_ss1_incoming" );
}

razorback_razorback()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "crash_site_razorback" );
    var_0.animname = "razorback";
    var_0 maps\_anim::setanimtree();
    var_0 maps\_vehicle::godon();
    var_0 _meth_8455();
    level.razorback = var_0;
    waitframe();
    var_0 thread vehicle_scripts\_razorback_fx::vfx_red_lights_on();
    var_1 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "prebunker_intro_razorback" );
    common_scripts\utility::flag_wait( "razorback_start" );
    var_1 maps\_anim::anim_single_solo( var_0, "prebunker_intro_razorback" );

    if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
        var_1 thread maps\_anim::anim_loop_solo( var_0, "prebunker_loop_razorback", "stop_loop" );

    common_scripts\utility::flag_wait( "player_loading_cargo" );
    var_1 notify( "stop_loop" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "prebunker_end_razorback" );
    var_2 = getent( "cs_razorback_clip", "targetname" );
    var_2 delete();
    wait 6.65;
    wait 7.1;
    var_0 thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_light_on( var_0 );
    var_0 thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on( var_0 );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_strong" ), var_0, "thrusterCenter_BL_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_strong" ), var_0, "thrusterCenter_BR_FX" );
    maps\_utility::delaythread( 0.1, vehicle_scripts\_razorback_fx::play_regular_tread_back_rz, var_0 );
    maps\_utility::delaythread( 0.3, vehicle_scripts\_razorback_fx::stop_idle_back_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.05, vehicle_scripts\_razorback_fx::vfx_razorback_jets_on, var_0 );
    var_0 waittillmatch( "single anim", "cargo_hit" );
    common_scripts\utility::flag_set( "shoot_razorback" );
    wait 2;
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), var_0, "landinggearcover_kl" );
    wait 0.75;
    playfxontag( common_scripts\utility::getfx( "smoke_trail_black_heli_emitter" ), var_0, "thrustercenter_tl_fx" );
    maps\_utility::smart_radio_dialogue_overlap( "crsh_grdn5_werehit2" );
    wait 1.5;
    maps\_utility::smart_radio_dialogue_overlap( "crsh_grdn5_lostread" );
    var_0 waittillmatch( "single anim", "end" );
    stopfxontag( common_scripts\utility::getfx( "smoke_trail_black_heli_emitter" ), var_0, "thrustercenter_tl_fx" );
    var_0 notify( "death" );
    var_0 delete();
}

razorback_cargo()
{
    var_0 = maps\_utility::spawn_anim_model( "razor_cargo" );

    if ( level.start_point != "cave_entry" )
        var_0 hide();

    var_1 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "prebunker_intro_crate" );
    var_2 = getent( "cargo_objective", "targetname" );
    level.razorback_org = var_2;
    common_scripts\utility::flag_wait( "unhide_cargo" );
    var_0 show();
    common_scripts\utility::flag_wait( "player_loading_cargo" );
    var_3 = getent( "razorback_crate_clip", "targetname" );
    var_3 delete();
    var_1 maps\_anim::anim_single_solo( var_0, "prebunker_end_crate" );
    wait 1.5;
}

razorback_cargo_player()
{
    var_0 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "rig" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "prebunker_end_player" );
    var_1 hide();
    common_scripts\utility::flag_wait( "player_pre_loading_cargo" );
    level.player maps\_utility::set_ignoreme( 1 );
    level.player _meth_8080( var_1, "tag_player", 0.6 );
    level.player _meth_80EF();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    var_0 thread maps\_anim::anim_single_solo( var_1, "prebunker_end_player" );
    common_scripts\utility::flag_set( "player_loading_cargo" );
    common_scripts\utility::flag_set( "lighting_loading_cargo" );
    var_2 = getent( "blocking_cargo", "targetname" );
    var_2 delete();
    level.walkers = [];
    thread mobile_turret_dropoff( "warbird_deploy_2_animnode", "bunker_warbird_2", "bunker_walker_2", "deploy_warbird_2_done", "warbird2_path_after_turret_deploy" );
    wait 0.6;
    var_1 show();
    level.player _meth_807D( var_1, "tag_player", 1, 17, 20, 20, 20 );
    var_3 = maps\_utility::get_living_ai_array( "pod_enemies", "script_noteworthy" );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) && isalive( var_5 ) && !level.player _meth_812B( var_5 ) )
        {
            var_5 _meth_8052();
            continue;
        }

        if ( isdefined( var_5 ) && isalive( var_5 ) )
            var_5.grenadeammo = 0;
    }

    var_7 = getent( "bunker_badplace_extra", "targetname" );
    badplace_brush( "bunker_badplace2", -1, var_7, "axis" );
    wait 2.5;
    thread cave_entry_bunker_battle();
    wait 4.2;
    thread mobile_turret_dropoff( "warbird_deploy_1_animnode", "bunker_warbird_1", "bunker_walker_1", "deploy_warbird_1_done", "warbird_path_after_turret_deploy" );
    var_1 waittillmatch( "single anim", "end" );
    thread maps\_utility::autosave_by_name( "razorback2" );
    level.player _meth_80F0();
    level.player _meth_804F();
    var_1 delete();
    level.player _meth_8304( 1 );
    level.player _meth_811A( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_8118( 1 );
    thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    thread check_player_bunker_position();
}

razorback_rumble( var_0 )
{
    var_1 = level.player maps\_utility::get_rumble_ent();
    var_1 maps\_utility::rumble_ramp_to( 1, 0.75 );
    var_0 waittillmatch( "single anim", "releasing_crate" );
    var_1 maps\_utility::set_rumble_intensity( 0 );
    waitframe();
    var_1 delete();
}

razorback_trigger_handler()
{
    var_0 = getent( "cargo_trigger", "targetname" );
    common_scripts\utility::flag_wait_either( "cormack_reached", "obj_move_dot_razorback" );
    var_0 common_scripts\utility::trigger_on();
    var_0 maps\_utility::addhinttrigger( &"CRASH_CARGO_PUSH", &"CRASH_CARGO_PUSH_KEYBOARD" );
    var_1 = getent( "cargo_objective", "targetname" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_0, var_1, cos( 40 ), 0, 1 );
    common_scripts\utility::flag_set( "player_pre_loading_cargo" );
}

check_player_bunker_position()
{
    level endon( "cave_entry_done" );
    wait 5;
    level.player maps\_utility::set_ignoreme( 0 );
    setignoremegroup( "player", "mech" );
    var_0 = getent( "bunker_badplace", "targetname" );

    while ( !common_scripts\utility::flag( "obj_update_goto_razorback" ) )
    {
        if ( !level.player _meth_80A9( var_0 ) )
        {
            common_scripts\utility::flag_set( "obj_update_goto_razorback" );
            maps\_utility::smart_radio_dialogue( "crsh_crmk_getoverhere2" );
        }

        wait 0.05;
    }

    for (;;)
    {
        while ( !level.player _meth_80A9( var_0 ) )
        {
            wait 0.05;

            foreach ( var_2 in level.walkers )
                self.ai_target_force = level.player;
        }

        wait 0.05;

        while ( level.player _meth_80A9( var_0 ) )
        {
            wait 0.05;

            foreach ( var_2 in level.walkers )
                self.ai_target_force = undefined;
        }
    }
}

razorback_gun_enable( var_0 )
{
    _func_0D3( "ammoCounterHide", 0 );
    level.player _meth_8320();
    level.player _meth_831E();
    level.player _meth_8130( 1 );
}

cormack_reached()
{
    level.cormack endon( "death" );
    waitframe();
    var_0 = getnode( "cormack_razor_node", "targetname" );
    level.cormack.goalradius = 64;
    level.cormack _meth_81A5( var_0 );
    level.cormack waittill( "goal" );

    if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
    {
        var_1 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
        var_1 maps\_anim::anim_reach_solo( level.cormack, "prebunker_intro_cormack", undefined, 1 );
    }

    common_scripts\utility::flag_set( "cormack_reached" );
}

razorback_cormack()
{
    level.cormack endon( "death" );
    var_0 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    level.cormack.animname = "cormack";
    level.cormack maps\_utility::disable_ai_color();
    level.cormack maps\_utility::set_ignoresuppression( 1 );
    level.cormack maps\_utility::set_ignoreme( 1 );
    level.cormack maps\_utility::set_ignoreall( 1 );
    level.cormack maps\_utility::disable_pain();
    level.cormack thread cormack_reached();
    var_1 = getent( "razorback_crate_clip", "targetname" );
    common_scripts\utility::flag_wait_either( "cormack_reached", "player_loading_cargo" );

    if ( common_scripts\utility::flag( "player_loading_cargo" ) )
        var_0 maps\_anim::anim_single_solo( level.cormack, "prebunker_start_push_fast_cormack" );
    else
    {
        level.cormack bunker_intro_anim( var_0 );

        if ( !common_scripts\utility::flag( "player_loading_cargo" ) )
        {
            var_0 thread maps\_anim::anim_loop_solo( level.cormack, "prebunker_loop_cormack", "stop_loop" );
            thread maps\_utility::smart_radio_dialogue( "crsh_crmk_givehand" );
            var_2 = maps\_utility::make_array( "crsh_crmk_helpme", "crsh_crmk_overhere2" );
            thread maps\crash_utility::nag_until_flag( var_2, "player_pre_loading_cargo", 15, 20, 5 );
        }

        common_scripts\utility::flag_wait( "player_loading_cargo" );
        var_0 notify( "stop_loop" );
        var_0 maps\_anim::anim_single_solo( level.cormack, "prebunker_start_push_slow_cormack" );
    }

    var_3 = getnode( "cormack_jump_start", "targetname" );
    level.cormack.goalradius = 64;
    level.cormack _meth_81A5( var_3 );
    var_0 maps\_anim::anim_single_solo( level.cormack, "prebunker_end_cormack" );
    common_scripts\utility::flag_set( "razorback_loaded" );
    common_scripts\utility::flag_set( "lighting_razorback_loaded" );
    wait 1;
    level.cormack waittill( "goal" );
    level.cormack maps\_utility::set_ignoresuppression( 0 );
    level.cormack maps\_utility::set_ignoreme( 0 );
    level.cormack maps\_utility::set_ignoreall( 0 );
    level.cormack maps\_utility::enable_pain();
    common_scripts\utility::flag_wait( "tank_firing_missiles" );
    level.cormack maps\_utility::disable_pain();
}

bunker_intro_anim( var_0 )
{
    level endon( "player_loading_cargo" );
    var_0 thread maps\_anim::anim_single_solo( level.cormack, "prebunker_intro_cormack" );
    level.cormack waittillmatch( "single anim", "end" );
}

razorback_ilana()
{
    level.ilana endon( "death" );
    level.ilana maps\_utility::disable_ai_color();
    var_0 = getnode( "ilana_jump_start", "targetname" );
    level.ilana.goalradius = 16;
    level.ilana _meth_81A5( var_0 );
    level.ilana maps\_utility::set_fixednode_true();
    common_scripts\utility::flag_wait( "tank_firing_missiles" );
    level.ilana maps\_utility::disable_pain();
}

razorback_dialogue()
{
    level.cormack maps\_utility::set_battlechatter( 0 );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_holdtight" );
    common_scripts\utility::flag_wait( "razorback_loaded" );
    maps\_utility::smart_radio_dialogue( "crsh_crmk_cargosecured3" );
    maps\_utility::smart_radio_dialogue( "crsh_grdn5_liftoff2" );
    wait 0.75;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_drawfire" );
    wait 4;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_astsincoming" );
    level.cormack maps\_utility::set_battlechatter( 1 );
}

razorback_mech( var_0 )
{
    var_1 = getent( "razorback_goliath", "targetname" );
    var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
    var_1 maps\_utility::add_spawn_function( ::razorback_mech_behavior, var_2 );
    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    var_3 maps\_utility::magic_bullet_shield( 1 );
    var_3.ignoreme = 1;
    var_3.ignoreall = 1;
    thread razorback_mech_missiles( var_3 );
    var_3.animname = "goliath";
    level.crash_mechs = common_scripts\utility::add_to_array( level.crash_mechs, var_3 );
    var_4 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    var_4 maps\_anim::anim_single_solo( var_3, "prebunker_end_mech" );
    common_scripts\utility::flag_set( "razorback_goliath_done" );
}

razorback_mech_missiles( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "cave_entry_animnode", "targetname" );
    var_2 = maps\_utility::spawn_anim_model( "razor_missiles" );
    var_1 maps\_anim::anim_first_frame_solo( var_2, "prebunker_end_missiles" );
    var_3 = spawn( "script_model", var_2 gettagorigin( "j_prop_1" ) );
    var_3.angles = var_2 gettagangles( "j_prop_1" );
    var_3 _meth_80B1( "npc_exo_armor_rocket_large" );
    var_3 _meth_804D( var_2, "j_prop_1" );
    var_3 hide();
    var_4 = spawn( "script_model", var_2 gettagorigin( "j_prop_2" ) );
    var_4.angles = var_2 gettagangles( "j_prop_2" );
    var_4 _meth_80B1( "npc_exo_armor_rocket_large" );
    var_4 _meth_804D( var_2, "j_prop_2" );
    var_4 hide();
    var_5 = spawn( "script_model", var_2 gettagorigin( "j_prop_3" ) );
    var_5.angles = var_2 gettagangles( "j_prop_3" );
    var_5 _meth_80B1( "npc_exo_armor_rocket_large" );
    var_5 _meth_804D( var_2, "j_prop_3" );
    var_5 hide();
    var_6 = spawn( "script_model", var_2 gettagorigin( "j_prop_4" ) );
    var_6.angles = var_2 gettagangles( "j_prop_4" );
    var_6 _meth_80B1( "npc_exo_armor_rocket_large" );
    var_6 _meth_804D( var_2, "j_prop_4" );
    var_6 hide();
    var_7 = spawn( "script_model", var_2 gettagorigin( "j_prop_5" ) );
    var_7.angles = var_2 gettagangles( "j_prop_5" );
    var_7 _meth_80B1( "npc_exo_armor_rocket_large" );
    var_7 _meth_804D( var_2, "j_prop_5" );
    var_7 hide();
    var_1 thread maps\_anim::anim_single_solo( var_2, "prebunker_end_missiles" );
    var_2 waittillmatch( "single anim", "missile_1_launched" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), var_3.origin );
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_3, "tag_origin" );
    var_3 show();
    soundscripts\_snd::snd_message( "mech_fire_missile_first", var_3, var_0 );
    var_2 waittillmatch( "single anim", "missile_2_launched" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), var_4.origin );
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_4, "tag_origin" );
    var_4 show();
    soundscripts\_snd::snd_message( "mech_fire_missile", var_4, var_0 );
    var_2 waittillmatch( "single anim", "missile_3_launched" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), var_5.origin );
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_5, "tag_origin" );
    var_5 show();
    soundscripts\_snd::snd_message( "mech_fire_missile", var_5, var_0 );
    var_2 waittillmatch( "single anim", "missile_4_launched" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), var_6.origin );
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_6, "tag_origin" );
    var_6 show();
    soundscripts\_snd::snd_message( "mech_fire_missile", var_6, var_0 );
    var_2 waittillmatch( "single anim", "missile_5_launched" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), var_7.origin );
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_7, "tag_origin" );
    var_7 show();
    soundscripts\_snd::snd_message( "mech_fire_missile", var_7, var_0 );
    var_2 waittillmatch( "single anim", "missile_1_impact" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_3, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "crash_rocket_explosion_default" ), level.razorback, "TAG_MISSILE_1" );
    var_3 delete();
    var_2 waittillmatch( "single anim", "missile_2_impact" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_4, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.razorback, "TAG_MISSILE_2" );
    var_4 delete();
    var_2 waittillmatch( "single anim", "missile_3_impact" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_5, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.razorback, "TAG_MISSILE_3" );
    var_5 delete();
    var_2 waittillmatch( "single anim", "missile_4_impact" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_6, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.razorback, "TAG_MISSILE_4" );
    var_6 delete();
    var_2 waittillmatch( "single anim", "missile_5_impact" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_7, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.razorback, "TAG_MISSILE_5" );
    var_7 delete();
}

razorback_mech_behavior( var_0 )
{
    common_scripts\utility::flag_wait( "razorback_goliath_done" );
    self _meth_8177( "mech" );
    thread maps\_utility::stop_magic_bullet_shield();
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.usechokepoints = 0;
    self.goalradius = 24;
    self _meth_81A6( var_0.origin );
    self waittill( "goal" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    self _meth_81A6( var_1.origin );
    self waittill( "goal" );
    var_2 = common_scripts\utility::getstruct( var_1.target, "targetname" );
    self _meth_81A6( var_2.origin );
    self waittill( "goal" );
}

razorback_mech_shoot()
{
    common_scripts\utility::flag_wait( "shoot_razorback" );
    maps\crash_utility::mech_fire_rockets_special( level.razorback );
}

cave_entry_bunker_battle()
{
    maps\_utility::array_spawn_function_targetname( "bunker_enemies", ::no_grenades );
    maps\_utility::array_spawn_function_targetname( "extra_bunker_allies", ::no_grenades );
    maps\_utility::array_spawn_function_targetname( "extra_bunker_allies", ::bunker_settings );

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "bunker_enemies", 1 );
    else
    {
        var_1 = getentarray( "bunker_enemies", "targetname" );
        var_0 = maps\_utility::array_spawn_cg( var_1, 1 );
    }

    wait 0.5;

    if ( level.nextgen )
        var_2 = maps\_utility::array_spawn_targetname( "extra_bunker_allies", 1 );
    else
    {
        var_1 = getentarray( "extra_bunker_allies", "targetname" );
        var_2 = maps\_utility::array_spawn_cg( var_1, 1 );
    }
}

no_grenades()
{
    self.grenadeammo = 0;
}

bunker_settings()
{
    self.goalradius = 16;
    self.script_forcegoal = 1;
    self.script_fixednode = 1;
}

cave_entry_scene()
{
    level.player endon( "death" );
    level.cormack endon( "death" );
    level.ilana endon( "death" );
    var_0 = getent( "bunker_badplace", "targetname" );
    var_1 = getent( "left_mech_rocket", "targetname" );
    var_2 = getent( "right_mech_rocket", "targetname" );
    var_3 = getent( "cheat_mech_rocket", "targetname" );
    var_4 = undefined;
    level.player _meth_80AD( "heavy_2s" );
    level.player thread play_fullscreen_mist( 4, 0, 2.5, 0.75, 0, 0 );
    level.player thread play_fullscreen_mist( 4, 0, 2.5, 0.75, 50, 70 );
    common_scripts\utility::flag_set( "cave_entry_anim_start" );
    level notify( "stop_drone_respawn" );
    thread cave_entry_player();
    var_5 = [];
    var_5[0] = level.cormack;
    var_5[1] = level.ilana;
    var_5[3] = maps\_utility::spawn_targetname( "shock_goliath", 1 );
    var_5[3].animname = "goliath";
    var_5[3].ignoreall = 1;
    var_5[3].ignoreme = 1;
    var_5[3] hide();
    var_5[5] = maps\_utility::spawn_anim_model( "ice_floor" );
    var_6 = getent( "cave_entry_floor", "targetname" );
    var_6 delete();
    level.cormack maps\_utility::anim_stopanimscripted();
    level.ilana maps\_utility::anim_stopanimscripted();
    level.cave_entry_animnode thread maps\_anim::anim_single( var_5, "icecave_enter" );
    level.cormack maps\_utility::set_battlechatter( 0 );
    level.ilana maps\_utility::set_battlechatter( 0 );
    level.cormack waittillmatch( "single anim", "end" );

    if ( level.currentgen )
        maps\_utility::tff_sync();

    level.ilana maps\_utility::set_fixednode_false();
    level.ilana maps\_utility::enable_pain();
    level.cormack maps\_utility::set_fixednode_false();
    level.cormack maps\_utility::enable_pain();
    common_scripts\utility::flag_set( "cave_entry_done" );
    level notify( "moved_indoors" );
    thread cave_entry_surface_cleanup();
}

cave_entry_player()
{
    level.player endon( "death" );
    var_0 = common_scripts\utility::getstruct( "cave_entry_teleport_animnode", "targetname" );
    level.player _meth_8301( 0 );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_1 = maps\_utility::spawn_anim_model( "rig" );
    var_2 = maps\_utility::spawn_anim_model( "rig" );
    var_1 hide();
    level.cave_entry_animnode thread maps\_anim::anim_single_solo( var_1, "icecave_enter" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "icecave_enter" );
    thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    var_3 = level.player _meth_84EB();
    var_4 = spawn( "script_model", var_2 gettagorigin( "tag_sync" ) );
    var_4.angles = var_2 gettagangles( "tag_sync" );
    var_4 _meth_804D( var_2, "tag_sync" );
    var_4 _meth_80B1( var_3 );
    level.player _meth_80EF();
    level.player _meth_8080( var_1, "tag_player", 0.5 );
    level.player _meth_817D( "stand" );
    wait 0.5;
    var_1 show();
    var_1 waittillmatch( "single anim", "ice_break" );
    common_scripts\_exploder::exploder( 5347 );
    common_scripts\_exploder::exploder( 2238 );
    var_1 waittillmatch( "single anim", "no_control" );
    level.player _meth_80F0();
    level.player _meth_80EC( 1 );
    var_1 waittillmatch( "single anim", "player_land" );
    var_5 = newclienthudelem( level.player );
    var_5 _meth_80CC( "black", 1280, 720 );
    var_5.horzalign = "fullscreen";
    var_5.vertalign = "fullscreen";
    var_5.alpha = 1;
    var_5.foreground = 0;
    level.player _meth_807F( var_2, "tag_player" );
    common_scripts\utility::flag_set( "blur_player_vision" );
    level.player _meth_8051( 150, level.player.origin );
    waitframe();
    level.player _meth_807D( var_2, "tag_player", 1, 20, 20, 20, 15, 1 );
    wait 0.1;
    var_5.alpha = 0;
    var_5 destroy();
    var_1 waittillmatch( "single anim", "gun_up" );
    var_4 delete();
    level.player_weapons = level.player _meth_830B();

    foreach ( var_7 in level.player_weapons )
        level.player _meth_8332( var_7 );

    _func_0D3( "r_gunSightColorEntityScale", 0 );
    _func_0D3( "r_gunSightColorNoneScale", 0 );
    _func_0D3( "ammoCounterHide", 0 );
    level.player _meth_8320();
    level.player _meth_831E();
    level.player _meth_8130( 1 );
    var_1 waittillmatch( "single anim", "end" );
    level.player _meth_804F();
    var_1 delete();
    var_2 delete();
    level.player _meth_80EC( 0 );
    level.player _meth_8301( 1 );
    level.player _meth_8304( 1 );
    level.player _meth_811A( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_8118( 1 );
    thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
}

cave_entry_goliath_show( var_0 )
{
    var_0 show();
}

play_fullscreen_mist( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level.player endon( "death" );
    var_6 = newclienthudelem( self );
    var_6.x = var_4;
    var_6.y = var_5;
    var_6 _meth_80CC( "overlay_rain_blur", 640, 480 );
    var_6.splatter = 1;
    var_6.alignx = "left";
    var_6.aligny = "top";
    var_6.sort = 1;
    var_6.foreground = 0;
    var_6.horzalign = "fullscreen";
    var_6.vertalign = "fullscreen";
    var_6.alpha = 0;
    var_7 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_8 = 0.05;

    if ( var_1 > 0 )
    {
        var_9 = 0;
        var_10 = var_3 / ( var_1 / var_8 );

        while ( var_9 < var_3 )
        {
            var_6.alpha = var_9;
            var_9 += var_10;
            wait(var_8);
        }
    }

    var_6.alpha = var_3;
    wait(var_0 - var_1 + var_2);

    if ( var_2 > 0 )
    {
        var_9 = var_3;
        var_11 = var_3 / ( var_2 / var_8 );

        while ( var_9 > 0 )
        {
            var_6.alpha = var_9;
            var_9 -= var_11;
            wait(var_8);
        }
    }

    var_6.alpha = 0;
    var_6 destroy();
}

cave_entry_sentinel()
{
    level.bunker_guy03.animname = "bunker_guy03";

    if ( level.nextgen )
    {
        level.bunker_guy01.ignoreme = 0;
        level.bunker_guy01.grenadeammo = 0;
        level.bunker_guy02.ignoreme = 0;
        level.bunker_guy02.grenadeammo = 0;
    }

    level.bunker_guy03.ignoreme = 0;
    level.bunker_guy03.grenadeammo = 0;
    createthreatbiasgroup( "bunker_guys" );

    if ( level.nextgen )
    {
        level.bunker_guy01 _meth_8177( "bunker_guys" );
        level.bunker_guy02 _meth_8177( "bunker_guys" );
    }

    level.bunker_guy03 _meth_8177( "bunker_guys" );

    if ( level.nextgen )
    {
        if ( isdefined( level.bunker_guy01.magic_bullet_shield ) )
            level.bunker_guy01 maps\_utility::stop_magic_bullet_shield();

        if ( isdefined( level.bunker_guy02.magic_bullet_shield ) )
            level.bunker_guy02 maps\_utility::stop_magic_bullet_shield();
    }

    if ( isdefined( level.bunker_guy03.magic_bullet_shield ) )
        level.bunker_guy03 maps\_utility::stop_magic_bullet_shield();
}

cave_entry_goliaths()
{
    level.player endon( "death" );
    level.crash_mechs = [];
    level.player _meth_8177( "player" );
    var_0 = getent( "drop_pod_mech_1", "targetname" );
    var_0 thread drop_pod_fall( "mech" );
    wait 3.25;
    var_1 = getent( "drop_pod_mech_2", "targetname" );
    var_1 thread drop_pod_fall( "mech" );
    wait(randomfloatrange( 4.5, 6.5 ));
    var_2 = getent( "drop_pod_mech_3", "targetname" );
    var_2 thread drop_pod_fall( "mech" );
}

cave_entry_goliath_spawn()
{
    var_0 = getent( self.target, "targetname" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_0 maps\_utility::add_spawn_function( ::cave_entry_goliath_behavior, var_1 );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    level.crash_mechs = common_scripts\utility::add_to_array( level.crash_mechs, var_2 );
}

cave_entry_goliath_behavior( var_0 )
{
    self _meth_8177( "mech" );
    self.baseaccuracy *= 0.5;
    thread cave_entry_goliath_movement( var_0 );
}

cave_entry_goliath_movement( var_0 )
{
    self endon( "death" );
    wait 2;
    setthreatbias( "bunker_guys", "mech", 900000 );
    setthreatbias( "player", "mech", 0 );
    self.usechokepoints = 0;
    self.goalradius = 72;
    self _meth_81A6( var_0.origin );
    self waittill( "goal" );
    thread cave_entry_goliath_attack();
    common_scripts\utility::flag_wait( "tank_incoming" );
    self notify( "stop_hunting" );
    var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    self _meth_81A6( var_1.origin );
    self waittill( "goal" );
    setthreatbias( "bunker_guys", "mech", 0 );
    setthreatbias( "player", "mech", 0 );
    setthreatbias( "heroes", "mech", 90000 );
}

cave_entry_goliath_attack()
{
    self endon( "death" );
    self endon( "stop_hunting" );
    var_0 = maps\_utility::get_living_ai_array( "bunker_allies", "targetname" );
    var_1 = maps\_utility::get_living_ai_array( "extra_bunker_allies", "script_noteworthy" );

    for ( var_2 = common_scripts\utility::array_combine( var_0, var_1 ); var_2.size > 0; var_2 = common_scripts\utility::array_removeundefined( var_2 ) )
    {
        if ( !isdefined( self.enemy ) )
        {
            var_2 = maps\_utility::array_removedead_or_dying( var_2 );
            var_2 = common_scripts\utility::array_removeundefined( var_2 );
            var_2 = sortbydistance( var_2, self.origin );
            self.favoriteenemy = var_2[0];
        }

        if ( isdefined( self.enemy ) )
        {
            self _meth_81A6( self.enemy.origin );
            self.goalradius = 1250;
            self.goalheight = 81;
        }

        wait 2;
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
    }
}

cave_entry_surface_cleanup()
{
    foreach ( var_1 in level.crash_mechs )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
            var_1 delete();
    }

    var_3 = maps\_utility::get_living_ai_array( "extra_bunker_allies", "script_noteworthy" );

    foreach ( var_1 in var_3 )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
            var_1 delete();
    }

    common_scripts\utility::flag_wait( "cave_entry_done" );
    wait 0.25;

    foreach ( var_1 in level.crash_site_drones )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }

    waitframe();

    foreach ( var_1 in level.bg_guys )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }

    var_10 = _func_0D6( "axis" );

    foreach ( var_1 in var_10 )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
            var_1 delete();
    }

    if ( level.nextgen )
    {
        if ( isdefined( level.bunker_guy01 ) && isalive( level.bunker_guy01 ) )
        {
            if ( isdefined( level.bunker_guy01.magic_bullet_shield ) )
                level.bunker_guy01 thread maps\_utility::stop_magic_bullet_shield();

            waitframe();
            level.bunker_guy01 delete();
        }

        if ( isdefined( level.bunker_guy02 ) && isalive( level.bunker_guy02 ) )
        {
            if ( isdefined( level.bunker_guy02.magic_bullet_shield ) )
                level.bunker_guy02 thread maps\_utility::stop_magic_bullet_shield();

            waitframe();
            level.bunker_guy02 delete();
        }
    }

    if ( isdefined( level.bunker_guy03 ) && isalive( level.bunker_guy03 ) )
    {
        if ( isdefined( level.bunker_guy03.magic_bullet_shield ) )
            level.bunker_guy03 thread maps\_utility::stop_magic_bullet_shield();

        waitframe();
        level.bunker_guy03 delete();
    }

    var_13 = getentarray( "drop_pod_bases", "script_noteworthy" );
    maps\_utility::array_delete( var_13 );
    var_14 = getentarray( "crash_site_volumes", "script_noteworthy" );
    maps\_utility::array_delete( var_14 );
    maps\_utility::stop_exploder( 1474 );
    maps\_utility::stop_exploder( 1066 );
    var_15 = getent( "player_jetpack", "targetname" );
    var_15 delete();
    clearallcorpses();
}

cave_entry_slide_exploders()
{
    common_scripts\utility::flag_wait( "fall_debris_exploder" );
    common_scripts\_exploder::exploder( 1190 );
}

cave_entry_walker_tank()
{
    level.player endon( "death" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "cave_walker_tank" );
    var_0.animname = "walker_tank";
    var_1 = common_scripts\utility::getstruct( "walker_tank_animnode_new", "targetname" );
    var_2 = var_1 common_scripts\utility::spawn_tag_origin();
    var_0 thread walker_tank_fx();
    var_2 maps\_anim::anim_single_solo( var_0, "fusion_walker_tank_enter" );
    var_2 thread maps\_anim::anim_loop_solo( var_0, "fusion_walker_tank_fwd_idle", "walker_stop_idle" );
    var_0 vehicle_scripts\_walker_tank::enable_firing( 0 );
    var_0 vehicle_scripts\_walker_tank::disable_firing( -1 );
    var_0 vehicle_scripts\_walker_tank::enable_firing( 1 );
    var_0 vehicle_scripts\_walker_tank::enable_firing( 2 );
    var_3 = getentarray( "walker_cave_target", "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_5 _meth_82C0( 1 );
        var_5 _meth_82C1( 1 );
    }

    var_7 = 0;
    var_8 = getent( "bunker_badplace", "targetname" );

    while ( !level.player _meth_80A9( var_8 ) )
        wait 0.05;

    while ( !level.player _meth_8214( var_0.origin, 65, 250 ) && var_7 < 5 )
    {
        wait 0.05;
        var_7 += 0.05;
    }

    var_0 vehicle_scripts\_walker_tank::disable_firing( 0 );
    var_0 vehicle_scripts\_walker_tank::disable_firing( -1 );
    var_0 vehicle_scripts\_walker_tank::disable_firing( 1 );
    var_0 vehicle_scripts\_walker_tank::disable_firing( 2 );
    var_0.missile_auto_reload = 1;
    level.vehicle_missile_launcher[var_0.classname][0].post_fire_function = undefined;
    common_scripts\utility::flag_set( "tank_firing_missiles" );
    soundscripts\_snd::snd_message( "cave_entry_tank_missile", var_3 );
    var_0 vehicle_scripts\_walker_tank::fire_missles_at_target_array( var_3, 1 );
    wait 1;
    common_scripts\utility::flag_set( "start_bunker_collapse" );
    var_9 = getentarray( "walker_cave_target2", "targetname" );
    wait 0.15;
    var_0 vehicle_scripts\_walker_tank::fire_missles_at_target_array( var_9, 1 );
    common_scripts\utility::flag_wait( "cave_entry_done" );
    var_0 notify( "stop_vehicle_turret_ai" );
    wait 5;
    var_0 delete();
}

walker_tank_fx()
{
    wait 6.47;
    playfxontag( common_scripts\utility::getfx( "walker_footstep_snow" ), self, "tag_wheel_front_left" );
    wait 0.46;
    playfxontag( common_scripts\utility::getfx( "walker_footstep_snow" ), self, "tag_wheel_front_right" );
}

mobile_turret_dropoff( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "death" );
    var_5 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( var_1 );
    var_6.animname = "warbird_deploy";
    var_6 maps\_vehicle::godon();
    var_6 maps\_vehicle::vehicle_lights_on( "running" );
    var_6 _meth_828B();
    soundscripts\_snd::snd_message( "warbird_crash_site", var_1, var_6 );
    var_7 = maps\_utility::spawn_anim_model( "walker_deploy" );
    var_7.animname = "walker_deploy";
    var_8 = maps\_utility::spawn_anim_model( "pulley_deploy" );
    var_8.animname = "pulley_deploy";
    var_5 maps\_anim::anim_first_frame( [ var_6, var_8, var_7 ], "mobile_turret_deploy" );
    var_5 thread play_warbird_mobile_turret_dropoff( var_6, var_8, var_3, var_4 );
    var_5 maps\_anim::anim_single_solo( var_7, "mobile_turret_deploy" );
    var_9 = getent( var_2, "targetname" );
    var_9.origin = var_7.origin;
    var_9.angles = var_7.angles;
    var_10 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_2 );
    var_10 _meth_8259( "axis" );
    var_10.makemobileturretunusable = 1;
    var_10 maps\_vehicle::godon();
    level.walkers = common_scripts\utility::array_add( level.walkers, var_10 );
    var_7 delete();
    var_10 thread monitor_turret_2_death();
    var_10 thread kill_path_on_death();
    common_scripts\utility::flag_wait( "start_bunker_collapse" );
    var_10 notify( "stop_vehicle_turret_ai" );
    common_scripts\utility::flag_wait( "cave_entry_done" );
    var_10 maps\_vehicle::godoff();
    wait 1.75;
    var_10 _meth_8051( var_10.health + 500, var_10.origin, var_10 );
}

play_warbird_mobile_turret_dropoff( var_0, var_1, var_2, var_3 )
{
    maps\_anim::anim_single( [ var_0, var_1 ], "mobile_turret_deploy" );
    var_1 _meth_804D( var_0 );
    var_0 maps\_utility::vehicle_detachfrompath();
    var_0 _meth_8283( 60, 15, 5 );
    var_4 = common_scripts\utility::getstruct( var_3, "targetname" );
    var_0 thread maps\_utility::vehicle_dynamicpath( var_4, 0 );
    common_scripts\utility::flag_wait( var_2 );
    var_1 delete();
    var_0 delete();
}

monitor_turret_2_death()
{
    self waittill( "death" );
    common_scripts\utility::flag_set( "flag_m_turret_dead" );
}

kill_path_on_death()
{
    wait_to_kill_path();
    self notify( "newpath" );
}

wait_to_kill_path()
{
    self endon( "death" );
    self endon( "driver dead" );
    level waittill( "eternity" );
}
