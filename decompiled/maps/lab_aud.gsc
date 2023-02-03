// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    launch_threads();
    thread launch_loops();
    thread launch_line_emitters();
    create_level_envelop_arrays();
    init_level_arrays();
    precache_presets();
    thread maps\lab_vo::init_pcap_vo();
    common_scripts\utility::array_thread( getentarray( "vrap_placed", "script_noteworthy" ), ::aud_jeep_death_listener );
    register_snd_messages();
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_global_mix" );

    if ( getdvarint( "snd_enable_damagefeedback" ) )
        maps\_utility::enable_damagefeedback_snd();
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "truck_takedown_burke_done" );
    common_scripts\utility::flag_init( "aud_player_entering_river" );
    common_scripts\utility::flag_init( "aud_river_shallow_water" );
    common_scripts\utility::flag_init( "aud_lab_phone_start" );
    common_scripts\utility::flag_init( "aud_start_jammer" );
    common_scripts\utility::flag_init( "aud_balcony_aircraft" );
    common_scripts\utility::flag_init( "aud_hangar_light_hum_start" );
}

init_globals()
{
    level.aud.rope_started = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread aud_handle_river_sfx();
    thread damb_animal_sfx_offset();
    thread aud_forest_ambient_loops();
    thread aud_lab_foley_override_handler();
    thread setup_burke_river_cross_notetracks();
    thread setup_deer_notetracks();
    thread setup_gideon_climb_notetracks();
    thread setup_player_takedown_notetracks();
    thread setup_npc_cloak_button_anims();
    thread aud_handle_clearing_dambs();
    thread aud_handle_river_progress_flags();
    thread aud_handle_river_shallow_flag();
    thread setup_cormack_meetup_scene_notetracks();
    thread setup_server_room_scene_notetracks();
    thread setup_hangar_notetracks();
    thread set_up_tank_exit_anims();
    thread lab_exfil_detonate_anims();
}

launch_loops()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_audio_tr" ) )
        return;

    common_scripts\utility::loop_fx_sound( "heli_fire_lrg_lp", ( -11258, -1660, 3 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "grass_fire_lp_03", ( -10123, -1664, 27 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "grass_fire_lp_01", ( -10501, -1636, -3 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "grass_fire_lp_03", ( -10752, -1645, -12 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "grass_fire_lp_02", ( -10609, -1506, -17 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_waterfall_sml_lp_lyr_01", ( -9813, 3497, -389 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_foliage_lp", ( -9481, 4846, 44 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_foliage_lp", ( -8584, 4722, -42 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_foliage_lp", ( -8855, 5311, -5 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_clearing_foliage_lp", ( -15543, 9251, 536 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_clearing_foliage_lp", ( -14812, 8798, 337 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_clearing_foliage_lp", ( -15012, 8733, 576 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_clearing_foliage_lp", ( -15122, 9460, 105 ), 1, "aud_stop_intro" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        level notify( "aud_stop_intro" );
    }
}

launch_line_emitters()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_audio_tr" ) )
        return;

    wait 0.1;
    thread soundscripts\_audio::aud_play_line_emitter( "stream_lab_01", "lab_stream_flow_line_lp", ( -12585, 15542, -1447 ), ( -12820, 15320, -1447 ), undefined, 0 );
    thread soundscripts\_audio::aud_play_line_emitter( "stream_lab_02", "lab_stream_flow_line_lp", ( -12190, 15632, -1447 ), ( -12665, 15609, -1447 ), undefined, 0 );
    thread soundscripts\_audio::aud_play_line_emitter( "stream_lab_03", "lab_stream_drain", ( -11757, 15774, -1440 ), ( -12070, 15703, -1447 ), undefined, 0 );
    thread soundscripts\_audio::aud_play_line_emitter( "stream_lab_04", "lab_stream_flow_lp", ( -12820, 15327, -1440 ), ( -13022, 15115, -1440 ), undefined, 0 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        soundscripts\_audio::aud_stop_line_emitter( "stream_lab_01" );
        soundscripts\_audio::aud_stop_line_emitter( "stream_lab_02" );
        soundscripts\_audio::aud_stop_line_emitter( "stream_lab_03" );
        soundscripts\_audio::aud_stop_line_emitter( "stream_lab_04" );
    }
}

aud_handle_river_sfx()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_audio_tr" ) )
        return;

    var_0 = ( -9716, 3329, -502 );
    var_1 = ( -7836, 3283, -502 );
    thread soundscripts\_audio::aud_play_line_emitter( "river_emitter", "emt_river_lrg_lp_lyr_01", var_0, var_1 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        soundscripts\_audio::aud_stop_line_emitter( "river_emitter" );
    }
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
    level.aud.envs["snipe_report_volume"] = [ [ 700, 0.6 ], [ 900, 0.7 ], [ 1150, 0.8 ], [ 1350, 0.9 ], [ 1600, 1.0 ] ];
    level.aud.envs["snipe_report_delay"] = [ [ 750, 0.0 ], [ 900, 0.0 ], [ 1200, 0.1 ], [ 1600, 0.2 ], [ 1800, 0.3 ] ];
    level.aud.envs["player_speed_to_music_vol"] = [ [ 0, 0.0 ], [ 10, 1.0 ] ];
    level.aud.envs["dog_bark_percentage"] = [ [ 0, 0 ], [ 0.5, 0 ], [ 17, 100 ] ];
}

init_level_arrays()
{
    level.aud.sniper = [];
    level.aud.sniper["surfaces"] = [ "dirt", "wood", "water", "grass" ];
}

precache_presets()
{

}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_crash", ::start_crash );
    soundscripts\_snd::snd_register_message( "start_forest", ::start_forest );
    soundscripts\_snd::snd_register_message( "start_forest_takedown", ::start_forest_takedown );
    soundscripts\_snd::snd_register_message( "start_logging_road", ::start_logging_road );
    soundscripts\_snd::snd_register_message( "start_mech_march", ::start_mech_march );
    soundscripts\_snd::snd_register_message( "start_cliff_rappel", ::start_cliff_rappel );
    soundscripts\_snd::snd_register_message( "start_facility_breach", ::start_facility_breach );
    soundscripts\_snd::snd_register_message( "start_server_room", ::start_server_room );
    soundscripts\_snd::snd_register_message( "start_research_facility_bridge", ::start_research_facility_bridge );
    soundscripts\_snd::snd_register_message( "start_foam_room", ::start_foam_room );
    soundscripts\_snd::snd_register_message( "start_courtyard", ::start_courtyard );
    soundscripts\_snd::snd_register_message( "start_courtyard_jammer", ::start_courtyard_jammer );
    soundscripts\_snd::snd_register_message( "start_tank_hangar", ::start_tank_hangar );
    soundscripts\_snd::snd_register_message( "start_tank_board", ::start_tank_board );
    soundscripts\_snd::snd_register_message( "start_tank_road", ::start_tank_road );
    soundscripts\_snd::snd_register_message( "start_tank_field", ::start_tank_field );
    soundscripts\_snd::snd_register_message( "start_exfil", ::start_exfil );
    soundscripts\_snd::snd_register_message( "aud_lab_intro_screen", ::aud_lab_intro_screen );
    soundscripts\_snd::snd_register_message( "aud_helo_spotlight_spawn", ::aud_helo_spotlight_spawn );
    soundscripts\_snd::snd_register_message( "aud_burke_intro_anim", ::aud_burke_intro_anim );
    soundscripts\_snd::snd_register_message( "hud_malfunction", ::hud_malfunction );
    soundscripts\_snd::snd_register_message( "player_reaches_shack", ::player_reaches_shack );
    soundscripts\_snd::snd_register_message( "chopper_sniper_shot", ::chopper_sniper_shot );
    soundscripts\_snd::snd_register_message( "aud_shack_explode_whizby", ::aud_shack_explode_whizby );
    soundscripts\_snd::snd_register_message( "aud_shack_explode", ::aud_shack_explode );
    soundscripts\_snd::snd_register_message( "aud_burke_stumble_run", ::aud_burke_stumble_run );
    soundscripts\_snd::snd_register_message( "aud_burke_step_over_log", ::aud_burke_step_over_log );
    soundscripts\_snd::snd_register_message( "aud_burke_tree_cover_01", ::aud_burke_tree_cover_01 );
    soundscripts\_snd::snd_register_message( "aud_burke_stumble_knee", ::aud_burke_stumble_knee );
    soundscripts\_snd::snd_register_message( "burke_hill_slide", ::burke_hill_slide );
    soundscripts\_snd::snd_register_message( "aud_player_hill_slide", ::aud_player_hill_slide );
    soundscripts\_snd::snd_register_message( "aud_burke_hill_slide_stump", ::aud_burke_hill_slide_stump );
    soundscripts\_snd::snd_register_message( "aud_burke_river_over_log", ::aud_burke_river_over_log );
    soundscripts\_snd::snd_register_message( "forest_climb_wall_start", ::forest_climb_wall_start );
    soundscripts\_snd::snd_register_message( "aud_burke_wall_climb", ::aud_burke_wall_climb );
    soundscripts\_snd::snd_register_message( "aud_player_wall_climb_01", ::aud_player_wall_climb_01 );
    soundscripts\_snd::snd_register_message( "aud_player_wall_climb_02", ::aud_player_wall_climb_02 );
    soundscripts\_snd::snd_register_message( "aud_player_wall_climb_03", ::aud_player_wall_climb_03 );
    soundscripts\_snd::snd_register_message( "aud_player_wall_climb_04", ::aud_player_wall_climb_04 );
    soundscripts\_snd::snd_register_message( "aud_player_wall_climb_05", ::aud_player_wall_climb_05 );
    soundscripts\_snd::snd_register_message( "player_cloak_on", ::player_cloak_on );
    soundscripts\_snd::snd_register_message( "wall_climb_cloak_activate", ::wall_climb_cloak_activate );
    soundscripts\_snd::snd_register_message( "wall_climb_last_jump", ::wall_climb_last_jump );
    soundscripts\_snd::snd_register_message( "burke_run_slide", ::burke_run_slide );
    soundscripts\_snd::snd_register_message( "deer_foliage_rustle", ::deer_sequence );
    soundscripts\_snd::snd_register_message( "random_dog_barks", ::random_dog_barks );
    soundscripts\_snd::snd_register_message( "burke_slide_02", ::burke_slide_02 );
    soundscripts\_snd::snd_register_message( "player_forest_takedown", ::player_forest_takedown );
    soundscripts\_snd::snd_register_message( "burke_forest_takedown", ::burke_forest_takedown );
    soundscripts\_snd::snd_register_message( "takedown_01_complete", ::takedown_01_complete );
    soundscripts\_snd::snd_register_message( "combat_forest_patrols_start", ::combat_forest_patrols_start );
    soundscripts\_snd::snd_register_message( "flank_right_dialogue", ::flank_right_dialogue );
    soundscripts\_snd::snd_register_message( "gaz_01_dist_by", ::gaz_01_dist_by );
    soundscripts\_snd::snd_register_message( "gaz_02_dist_by", ::gaz_02_dist_by );
    soundscripts\_snd::snd_register_message( "gaz_03_close_by", ::gaz_03_close_by );
    soundscripts\_snd::snd_register_message( "burke_solo_takedown", ::burke_solo_takedown );
    soundscripts\_snd::snd_register_message( "aud_vrap_mute_start", ::aud_vrap_mute_start );
    soundscripts\_snd::snd_register_message( "lab_brk_illtakedriver", ::lab_brk_illtakedriver );
    soundscripts\_snd::snd_register_message( "truck_takedown_radio", ::truck_takedown_radio );
    soundscripts\_snd::snd_register_message( "truck_takedown", ::truck_takedown );
    soundscripts\_snd::snd_register_message( "takedown_truck_lights_off", ::takedown_truck_lights_off );
    soundscripts\_snd::snd_register_message( "vehicle_takedown_01_complete", ::vehicle_takedown_01_complete );
    soundscripts\_snd::snd_register_message( "aud_patrol_helo_debris_sfx", ::aud_patrol_helo_debris_sfx );
    soundscripts\_snd::snd_register_message( "gaz_04_slow_by", ::gaz_04_slow_by );
    soundscripts\_snd::snd_register_message( "gaz_05_slow_by", ::gaz_05_slow_by );
    soundscripts\_snd::snd_register_message( "forest_mech_spawn", ::forest_mech_spawn );
    soundscripts\_snd::snd_register_message( "skr_distant_pull_up_and_scan", ::skr_distant_pull_up_and_scan );
    soundscripts\_snd::snd_register_message( "start_seeker_audio", ::start_seeker_audio );
    soundscripts\_snd::snd_register_message( "start_fixed_scanner_audio", ::start_fixed_scanner_audio );
    soundscripts\_snd::snd_register_message( "seeker_clear", ::seeker_clear );
    soundscripts\_snd::snd_register_message( "aud_burke_nearing_cliff", ::aud_burke_nearing_cliff );
    soundscripts\_snd::snd_register_message( "aud_rappel_player_hookup", ::aud_rappel_player_hookup );
    soundscripts\_snd::snd_register_message( "aud_rappel_player_movement_start", ::aud_rappel_player_movement_start );
    soundscripts\_snd::snd_register_message( "aud_rappel_player_movement_stop", ::aud_rappel_player_movement_stop );
    soundscripts\_snd::snd_register_message( "player_rappel_complete", ::aud_player_rappel_complete );
    soundscripts\_snd::snd_register_message( "lab_mute_gun_holster", ::lab_mute_gun_holster );
    soundscripts\_snd::snd_register_message( "aud_facility_breach_start", ::aud_facility_breach_start );
    soundscripts\_snd::snd_register_message( "aud_lab_ambient_emitters", ::aud_lab_ambient_emitters );
    soundscripts\_snd::snd_register_message( "begin_pcap_vo_lab_serverroom_cormack", ::begin_pcap_vo_lab_serverroom_cormack );
    soundscripts\_snd::snd_register_message( "open_server_room_door", ::open_server_room_door );
    soundscripts\_snd::snd_register_message( "aud_server_room_door_crack", ::aud_server_room_door_crack );
    soundscripts\_snd::snd_register_message( "aud_server_room_door_kick", ::aud_server_room_door_kick );
    soundscripts\_snd::snd_register_message( "aud_server_room_door_enter", ::aud_server_room_door_enter );
    soundscripts\_snd::snd_register_message( "aud_player_computer_gl_timing_fix", ::aud_player_computer_gl_timing_fix );
    soundscripts\_snd::snd_register_message( "research_building_combat_complete", ::research_building_combat_complete );
    soundscripts\_snd::snd_register_message( "aud_foam_room_emitters", ::aud_foam_room_emitters );
    soundscripts\_snd::snd_register_message( "foam_room_crmk_plant_these_frvs", ::foam_room_crmk_plant_these_frvs );
    soundscripts\_snd::snd_register_message( "neutralize_bio_weapons_complete", ::neutralize_bio_weapons_complete );
    soundscripts\_snd::snd_register_message( "player_plant_frb", ::player_plant_frb );
    soundscripts\_snd::snd_register_message( "foam_room_door_close", ::foam_room_door_close );
    soundscripts\_snd::snd_register_message( "door2courtyard_open", ::door2courtyard_open );
    soundscripts\_snd::snd_register_message( "foam_room_complete_dialogue", ::foam_room_complete_dialogue );
    soundscripts\_snd::snd_register_message( "aud_ctyard_vrap01", ::aud_ctyard_vrap01 );
    soundscripts\_snd::snd_register_message( "aud_ctyard_vrap02", ::aud_ctyard_vrap02 );
    soundscripts\_snd::snd_register_message( "aud_ctyard_vrap04", ::aud_ctyard_vrap04 );
    soundscripts\_snd::snd_register_message( "aud_ctyard_vrap05", ::aud_ctyard_vrap05 );
    soundscripts\_snd::snd_register_message( "courtyard_hangar_mech_01_spawned", ::courtyard_hangar_mech_01_spawned );
    soundscripts\_snd::snd_register_message( "courtyard_door_hack_start_dialogue", ::courtyard_door_hack_start_dialogue );
    soundscripts\_snd::snd_register_message( "courtyard_start_dish", ::courtyard_start_dish );
    soundscripts\_snd::snd_register_message( "courtyard_defend_start", ::courtyard_defend_start );
    soundscripts\_snd::snd_register_message( "courtyard_end_jammer", ::courtyard_end_jammer );
    soundscripts\_snd::snd_register_message( "aud_courtyard_hangar_door_close", ::aud_courtyard_hangar_door_close );
    soundscripts\_snd::snd_register_message( "aud_courtyard_hangar_door_hack", ::aud_courtyard_hangar_door_hack );
    soundscripts\_snd::snd_register_message( "aud_courtyard_hangar_door_hack_idle", ::aud_courtyard_hangar_door_hack_idle );
    soundscripts\_snd::snd_register_message( "aud_courtyard_hangar_door_open", ::aud_courtyard_hangar_door_open );
    soundscripts\_snd::snd_register_message( "courtyard_hangar_door_close_rpg", ::courtyard_hangar_door_close_rpg );
    soundscripts\_snd::snd_register_message( "aud_post_courtyard_emitters", ::aud_post_courtyard_emitters );
    soundscripts\_snd::snd_register_message( "current_gen_hangar_door_open", ::current_gen_hangar_door_open );
    soundscripts\_snd::snd_register_message( "hangar_lights_on", ::hangar_lights_on );
    soundscripts\_snd::snd_register_message( "hover_tank_startup_sequence", ::hover_tank_startup_sequence );
    soundscripts\_snd::snd_register_message( "hovertank_enter", ::hovertank_enter );
    soundscripts\_snd::snd_register_message( "aud_player_gets_in_tank", ::aud_player_gets_in_tank );
    soundscripts\_snd::snd_register_message( "aud_impact_system_hovertank", ::aud_impact_system_hovertank );
    soundscripts\_snd::snd_register_message( "aud_tank_section_vehicles_spawned", ::aud_tank_section_vehicles_spawned );
    soundscripts\_snd::snd_register_message( "boxtruck_explode", ::boxtruck_explode );
    soundscripts\_snd::snd_register_message( "warbird_emp_death", ::warbird_emp_death );
    soundscripts\_snd::snd_register_message( "log_pile_collapse", ::log_pile_collapse );
    soundscripts\_snd::snd_register_message( "tank_shack_destruct", ::tank_shack_destruct );
    soundscripts\_snd::snd_register_message( "tank_disabled", ::tank_disabled );
    soundscripts\_snd::snd_register_message( "tank_exit", ::tank_exit );
    soundscripts\_snd::snd_register_message( "lab_exfil_missile_strike", ::lab_exfil_missile_strike );
    soundscripts\_snd::snd_register_message( "razorback_land", ::razorback_land );
    soundscripts\_snd::snd_register_message( "tank_exfil_charges", ::tank_exfil_charges_going_off );
    soundscripts\_snd::snd_register_message( "tank_exfil_detonate", ::tank_exfil_detonate );
    soundscripts\_snd::snd_register_message( "lab_e3_end_logo", ::lab_e3_end_logo );
    soundscripts\_snd::snd_register_message( "aud_start_exfil_foley", ::aud_start_exfil_foley );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_out", ::e3_demo_fade_out );
    soundscripts\_snd::snd_register_message( "e3_demo_clear_alarm", ::e3_demo_clear_alarm );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_in", ::e3_demo_fade_in );
}

zone_handler( var_0, var_1 )
{
    var_2 = "";
    var_3 = "";

    if ( getsubstr( var_0, 0, 6 ) == "enter_" )
        var_2 = var_1;
    else if ( getsubstr( var_0, 0, 5 ) == "exit_" )
        var_3 = var_1;

    switch ( var_0 )
    {
        case "enter_lab_ext_forest_ent":
            if ( var_2 == "lab_ext_field" )
            {
                level.aud.in_river = 1;
                level.aud.opening_run = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "lab_opening_chase" );
            }
            else if ( var_2 == "lab_ext_forest_ent" )
                level.aud.in_river = 1;

            break;
        case "exit_lab_ext_forest_ent":
            if ( var_3 == "lab_ext_field" )
                level.aud.in_river = 0;
            else if ( var_3 == "lab_ext_forest_ent" )
                level.aud.in_river = 0;

            break;
        case "exit_lab_ext_smoking_balcony":
            level notify( "stop_courtyard_alarms" );
            soundscripts\_snd_filters::snd_fade_out_filter( 0.5 );
            break;
    }
}

music( var_0, var_1 )
{
    thread music_handler( var_0, var_1 );
}

music_handler( var_0, var_1 )
{
    level notify( "exit_music_thread" );
    level endon( "exit_music_thread" );
    var_2 = 0.75;
    var_3 = 0.4;
    var_4 = 0.95;
    var_5 = 0.5;
    var_6 = 0.4;
    var_7 = 0.3;
    var_8 = 0.7;
    var_9 = 0.45;

    switch ( var_0 )
    {
        case "mus_lab_intro_black_done":
            soundscripts\_audio::aud_set_music_submix( var_2 );
            wait 5.5;
            soundscripts\_audio_music::mus_play( "mus_lab_intro_lp", 0.6 );
            break;
        case "player_cloak_on":
            soundscripts\_audio_music::mus_play( "mus_lab_intro_end", 0.1, 1 );
            break;
        case "mus_forest_stealth":
            break;
        case "flank_right_dialogue":
            break;
        case "lab_brk_illtakedriver":
            soundscripts\_audio_music::mus_stop( 8 );
            break;
        case "vehicle_takedown_01_complete":
            break;
        case "mus_forest_mech_march":
            soundscripts\_audio_mix_manager::mm_add_submix( "lab_mech_march", 1.5 );
            mus_submixer( "off" );
            soundscripts\_audio::aud_set_music_submix( var_4, 2.5 );
            soundscripts\_audio_music::mus_play( "mus_forest_mech_march", 0, 2 );
            wait 1;
            wait 17;
            soundscripts\_audio::aud_set_music_submix( 0, 14 );
            soundscripts\_audio_mix_manager::mm_clear_submix( "lab_mech_march", 4 );
            break;
        case "seeker_clear":
            soundscripts\_audio_music::mus_stop( 15 );
            break;
        case "begin_pcap_vo_lab_serverroom_cormack":
            mus_submixer( "off" );
            soundscripts\_audio::aud_set_music_submix( 0.1 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_intro", 0.2 );
            wait 0.1;
            soundscripts\_audio::aud_set_music_submix( var_5, 45 );
            break;
        case "open_server_room_door":
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_body", 0, 4 );
            soundscripts\_audio::aud_set_music_submix( var_5, 2 );
            wait 128;
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_vamp1", 0, 4 );
            break;
        case "research_building_combat_complete":
            soundscripts\_audio::aud_set_music_submix( var_5, 2 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_vamp2", 0, 1 );
            break;
        case "foam_room_crmk_plant_these_frvs":
            soundscripts\_audio::aud_set_music_submix( var_5, 2 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_vamp3", 1, 1 );
            wait 0.1;
            soundscripts\_audio::aud_set_music_submix( 0.2, 2 );
            break;
        case "neutralize_bio_weapons_complete":
            soundscripts\_audio::aud_set_music_submix( var_5, 2 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat1_end", 0, 0.5 );
            break;
        case "begin_courtyard_combat":
            soundscripts\_audio_mix_manager::mm_add_submix( "lab_courtyard_quads_low", 10 );
            soundscripts\_audio::aud_set_music_submix( var_6, 1 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat2_lp", 10 );
            break;
        case "pre_mech_vrap":
            soundscripts\_audio_mix_manager::mm_clear_submix( "lab_courtyard_quads_low", 3 );
            soundscripts\_audio::aud_set_music_submix( 0.1, 5 );
            wait 2;
            soundscripts\_audio_music::mus_play( "mus_lab_combat2_end", 1, 1 );
            break;
        case "courtyard_hangar_mech_01_spawned":
            soundscripts\_audio_mix_manager::mm_add_submix( "lab_courtyard_quads_low", 3 );
            soundscripts\_audio_mix_manager::mm_add_submix( "lab_courtyard_alarms_low", 3 );
            soundscripts\_audio::aud_set_music_submix( var_8, 0 );
            soundscripts\_audio_music::mus_play( "mus_lab_courtyard_ast1", 0 );
            break;
        case "courtyard_door_hack_start_dialogue":
            soundscripts\_audio_mix_manager::mm_clear_submix( "lab_courtyard_quads_low", 5 );
            soundscripts\_audio_mix_manager::mm_clear_submix( "lab_courtyard_alarms_low", 5 );
            soundscripts\_audio_music::mus_stop( 5 );
            wait 1;
            soundscripts\_audio::aud_set_music_submix( var_6, 10 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat3_lp", 10 );
            break;
        case "courtyard_defend_start":
            break;
        case "courtyard_hangar_door_close":
            soundscripts\_audio::aud_set_music_submix( var_7, 1 );
            soundscripts\_audio_music::mus_play( "mus_lab_combat3_end", 0, 1 );
            break;
        case "tank_reveal":
            soundscripts\_audio::aud_set_music_submix( 0.6, 0.5 );
            soundscripts\_audio_music::mus_play( "mus_lab_tank_reveal", 0 );
            wait 8;
            soundscripts\_audio::aud_set_music_submix( 0.4, 3 );
            break;
        case "hover_tank_startup":
            break;
        case "begin_tank_combat":
            soundscripts\_audio::aud_set_music_submix( var_9, 0 );
            soundscripts\_audio_music::mus_play( "mus_lab_tank_combat", 0 );
            break;
        case "end_tank_combat":
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "lab_finale":
            soundscripts\_audio::aud_set_music_submix( 0.6, 0.1 );
            wait 0.1;
            soundscripts\_audio_music::mus_play( "mus_lab_finale", 5 );
            break;
        default:
            if ( getdvarint( "snd_validate_music_messages" ) )
            {

            }

            break;
    }
}

mus_submixer( var_0, var_1 )
{
    var_0 = soundscripts\_audio::aud_get_optional_param( "on", var_0 );
    var_1 = soundscripts\_audio::aud_get_optional_param( 1, var_1 );

    if ( var_0 == "off" )
        level notify( "kill_mus_submixer" );
    else
        thread mus_submixer_thread( var_1 );
}

mus_submixer_thread( var_0 )
{
    level notify( "kill_mus_submixer" );
    level endon( "kill_mus_submixer" );
    var_1 = 0.25;
    var_2 = 0.1;
    var_3 = 0.02;
    var_4 = 0;
    var_5 = 17.6;

    for (;;)
    {
        var_6 = length( level.player getvelocity() ) / var_5;

        if ( getdvarint( "print_player_speed" ) )
            iprintln( var_6 );

        if ( var_6 > var_4 )
            var_7 = var_2;
        else
            var_7 = var_3;

        var_4 += var_7 * ( var_6 - var_4 );
        var_8 = piecewiselinearlookup( var_4, level.aud.envs["player_speed_to_music_vol"] );
        soundscripts\_audio::aud_set_music_submix( var_8 * var_0, var_1 );
        wait(var_1);
    }
}

start_crash()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_field", 1.0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_intro_black" );
    wait 0.05;
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_heli_sniper" );
    level.aud.opening_run = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_opening_chase" );
}

start_forest()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_forest_ent", 1.0 );
    music( "mus_lab_intro_black_done" );
}

start_forest_takedown()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_forest", 1.0 );
    common_scripts\utility::flag_set( "snd_cloak_is_enabled" );
}

start_logging_road()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_forest", 1.0 );
    common_scripts\utility::flag_set( "snd_cloak_is_enabled" );
}

start_mech_march()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_forest", 1.0 );
    common_scripts\utility::flag_set( "snd_cloak_is_enabled" );
}

start_cliff_rappel()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_forest", 1.0 );
}

start_facility_breach()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_infil", 1.0 );
}

start_server_room()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1.0 );
    thread aud_lab_ambient_emitters();
}

start_research_facility_bridge()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1.0 );
    music( "open_server_room_door" );
    start_interior_alarms();
}

start_foam_room()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1.0 );
    music( "research_building_combat_complete" );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_neutralize_bio_weapons_complete", 1 );
    start_interior_alarms();
    thread aud_foam_room_emitters();
}

start_courtyard()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1.0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_neutralize_bio_weapons_complete", 1 );
    thread aud_foam_room_emitters();
    start_interior_alarms();
    courtyard_start_dish();
}

start_courtyard_jammer( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1 );
    music( "courtyard_door_hack_start_dialogue" );
    start_courtyard_alarms();
}

start_tank_hangar()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_main", 1.0 );
    thread aud_post_courtyard_emitters();
    start_post_courtyard_interior_alarms();
}

start_tank_board()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_tank_hangar", 1.0 );
    thread tank_checkpoint_engine();
}

tank_checkpoint_engine()
{
    var_0 = spawn( "script_origin", ( -12771, 9352, -1203 ) );
    var_0 soundscripts\_snd_playsound::snd_play_loop( "ht_startup_engine_loop" );
    level waittill( "kill_tank_startup_loop" );
    wait 4.8;
    soundscripts\_audio::aud_fade_loop_out_and_delete( var_0, 4 );
}

start_tank_road()
{
    tank_screens_boot_up();
    soundscripts\_audio_mix_manager::mm_add_submix( "tank_battle", 0.25 );
    soundscripts\_snd::snd_music_message( "begin_tank_combat" );
}

start_tank_field()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_tank", 1.0 );
    tank_screens_boot_up();
    soundscripts\_audio_mix_manager::mm_add_submix( "tank_battle", 0.25 );
    soundscripts\_snd::snd_music_message( "begin_tank_combat" );
}

start_exfil()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_ext_field", 1.0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "tank_battle", 0.25 );
}

aud_lab_intro_screen()
{
    wait 0.5;
    thread aud_introblack_bullet( "right" );
    soundscripts\_snd_playsound::snd_play_2d( "lab_introblack_breathing" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "lab_introblack_gearfoley", 3.0 );
    wait 1.5;
    thread aud_introblack_bullet( "left" );
    wait 3.0;
    thread aud_introblack_bullet( "right" );
    wait 3.0;
    thread aud_introblack_bullet( "left" );
    wait 5.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_intro_black", 5 );
}

aud_introblack_bullet( var_0 )
{
    var_1 = "left";

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    soundscripts\_snd_playsound::snd_play_2d( "lab_introblack_whizby" );

    if ( var_1 == "left" )
        soundscripts\_snd_playsound::snd_play_delayed_2d( "lab_introblack_bullet_l", 0.2 );
    else
        soundscripts\_snd_playsound::snd_play_delayed_2d( "lab_introblack_bullet_r", 0.2 );
}

aud_burke_intro_anim()
{
    soundscripts\_snd_playsound::snd_play_2d( "lab_introblack_helo_flyby_rears" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "lab_introblack_burke_trip", 0.8 );
}

hud_malfunction()
{
    soundscripts\_snd::snd_music_message( "mus_lab_intro_black_done" );
}

player_reaches_shack()
{
    level notify( "hud_malfunction_loop_stop" );
}

aud_helo_spotlight_spawn()
{
    var_0 = self;
}

chopper_sniper_shot( var_0, var_1 )
{
    var_2 = var_0;
    var_3 = var_1;
    thread aud_chopper_sniper_whizby( var_2, var_3 );
    thread aud_chopper_sniper_bullet( var_2, var_3 );
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_at( "helo_sniper_shot", var_2 );
    var_4 = distance( level.player.origin, var_2 );
    var_5 = soundscripts\_snd::snd_map( var_4, level.aud.envs["snipe_report_delay"] );
    wait(var_5);
    var_6 = soundscripts\_snd_playsound::snd_play_2d( "helo_sniper_tail" );
    var_7 = soundscripts\_snd::snd_map( var_4, level.aud.envs["snipe_report_volume"] );
    var_6 scalevolume( var_7, 0.05 );
}

aud_chopper_sniper_whizby( var_0, var_1 )
{
    var_2 = soundscripts\_snd_playsound::snd_play_at( "whizby_sniper", var_0 );
    var_2 moveto( var_1, 0.2 );
}

aud_chopper_sniper_bullet( var_0, var_1 )
{
    var_2 = ( var_1 - var_0 ) * 1.05 + var_0;
    var_3 = bullettrace( var_0, var_2, 0, level.helo_spotlight, 0, 0, 0, 1 );
    var_4 = var_3["surfacetype"];

    if ( var_4 == "none" )
        var_4 = "dirt";

    if ( !soundscripts\_snd_common::snd_is_valid_surface( var_4, level.aud.sniper["surfaces"] ) )
        var_4 = "dirt";

    if ( var_4 == "water" )
        return;

    var_5 = "bullet_sniper_" + var_4;
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_at( var_5, var_1 );
}

aud_shack_explode_whizby()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_shack_explode" );
    level.burke soundscripts\_snd_playsound::snd_play_linked( "lab_shack_explode_whizby" );
}

aud_shack_explode( var_0 )
{
    var_1 = level.burke soundscripts\_snd_playsound::snd_play_linked( "lab_shack_explode_impact" );
    var_1 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_shack_explode" );
}

aud_burke_stumble_run()
{

}

aud_burke_step_over_log()
{

}

aud_burke_tree_cover_01()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_hill_slide", 0.05 );
}

aud_burke_stumble_knee()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_hill_slide", 0.05 );
}

burke_hill_slide( var_0 )
{
    if ( var_0 == "anim_01" )
    {
        level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "hill_slide_burke_fence", 0 );
        level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "hill_slide_burke", 1.8 );
    }
    else if ( var_0 == "anim_02" )
        level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "hill_slide_burke", 0.25 );
}

aud_player_hill_slide()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "hill_slide_log_grab", 0.45 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "hill_slide_main", 1.6 );
    wait 7;
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_hill_slide" );
}

aud_burke_hill_slide_stump()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_river", 0.05 );
}

aud_burke_river_over_log()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_river_foley", 0.05 );
}

setup_burke_river_cross_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_jump", ::aud_burke_water_jump, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_enter", ::aud_burke_water_enter, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_deep_step", ::aud_burke_water_deep_step, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_slip", ::aud_burke_water_slip, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_fall_forward", ::aud_burke_water_fall_forward, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_shallow_step", ::aud_burke_water_shallow_step, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_exit", ::aud_burke_water_exit, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_footstep_left", ::aud_burke_water_footstep_left, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_water_footstep_right", ::aud_burke_water_footstep_right, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_riverbank_footstep_left", ::aud_burke_riverbank_footstep_left, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_riverbank_footstep_right", ::aud_burke_riverbank_footstep_right, "burke_river_cross" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_burke_riverbank_slide", ::aud_burke_riverbank_slide, "burke_river_to_tree" );
}

aud_handle_river_progress_flags()
{
    common_scripts\utility::flag_wait( "aud_player_entering_river" );
    var_0 = length( level.player getvelocity() );

    if ( var_0 > 275 )
        soundscripts\_snd_playsound::snd_play_2d( "river_player_splash_hvy" );
}

aud_burke_water_jump( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "river_burke_splash", 0.4 );
}

aud_burke_water_enter( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "river_burke_movement" );
}

aud_burke_water_deep_step( var_0 )
{

}

aud_burke_water_slip( var_0 )
{

}

aud_burke_water_fall_forward( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "river_burke_fall_forward" );
}

aud_burke_water_shallow_step( var_0 )
{

}

aud_burke_water_exit( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "river_burke_water_exit" );
}

aud_burke_water_footstep_left( var_0 )
{

}

aud_burke_water_footstep_right( var_0 )
{

}

aud_burke_riverbank_footstep_left( var_0 )
{

}

aud_burke_riverbank_footstep_right( var_0 )
{

}

aud_burke_riverbank_slide( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lab_burke_slide_01" );
}

aud_handle_river_shallow_flag()
{
    level endon( "aud_river_complete" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "aud_river_shallow_water" );
        soundscripts\_audio_mix_manager::mm_add_submix( "lab_river_shallow", 1.5 );

        for (;;)
        {
            if ( common_scripts\utility::flag( "aud_river_shallow_water" ) == 0 )
            {
                soundscripts\_audio_mix_manager::mm_clear_submix( "lab_river_shallow", 2 );
                break;
            }

            wait 0.1;
        }

        wait 0.1;
    }
}

forest_climb_wall_start()
{

}

aud_forest_ambient_loops()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_audio_tr" ) )
        return;

    var_0 = [];
    var_1 = [ ( -8761, 5374, -125 ), ( -8171, 4923, -229 ), ( -7729, 5360, -93 ), ( -7793, 4878, -125 ), ( -8368, 5757, -39 ), ( -8334, 6698, 42 ), ( -8796, 7843, 136 ), ( -9307, 9345, 203 ), ( -9401, 7219, 110 ), ( -9920, 6863, 137 ), ( -9604, 6146, 163 ), ( -9039, 6273, 82 ), ( -9948, 6252, 64 ), ( -10676, 5843, 39 ), ( -11209, 6488, 166 ), ( -12571, 6420, 188 ), ( -13202, 5550, 110 ), ( -13626, 5622, 113 ), ( -13478, 6332, 123 ), ( -14324, 6694, 132 ), ( -14855, 7641, 65 ), ( -15099, 8229, 41 ) ];

    foreach ( var_3 in var_1 )
        var_0[var_0.size] = common_scripts\utility::play_loopsound_in_space( "emt_crickets_lp", var_3 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );

        foreach ( var_6 in var_0 )
        {
            var_6 stoploopsound();
            var_6 delete();
        }
    }
}

aud_burke_wall_climb()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_wall_climb_foley_mute" );
    level.burke soundscripts\_snd_playsound::snd_play_linked( "wall_climb_burke" );
}

setup_gideon_climb_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "burke", "gideon_wall_cloak_on", ::gideon_wall_cloak_on, "burke_says_exo_is_on" );
}

gideon_wall_cloak_on( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "wall_climb_burke_cloak_on" );
}

aud_player_wall_climb_01()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "player_wall_climb", 0.05 );
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_01" );
    wait 0.05;
    level notify( "aud_river_complete" );
}

aud_player_wall_climb_02()
{
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_02" );
}

aud_player_wall_climb_03()
{
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_03" );
}

aud_player_wall_climb_04()
{
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_04" );
}

aud_player_wall_climb_05()
{
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_05" );
}

damb_animal_sfx_offset()
{
    level waittill( "aud_wall_climb_done" );
    soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience( "lab_ext_forest_ent", "damb_ext_forest_animal", 10 );
}

player_cloak_on()
{
    soundscripts\_snd::snd_music_message( "player_cloak_on" );
}

wall_climb_cloak_activate()
{
    soundscripts\_snd::snd_music_message( "aud_player_wall_climb_end" );
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_cloak_panel" );
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_last_branch" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "wall_climb_cloak_on", 1, undefined, undefined, undefined, undefined, undefined, ( 0, 50, 50 ) );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "wall_climb_cloak_on_wide", 1.2 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_heli_sniper" );
}

wall_climb_last_jump()
{
    soundscripts\_snd_playsound::snd_play_2d( "wall_climb_player_jump_to_top" );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_river_foley", 0.05 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "player_wall_climb", 0.05 );
}

burke_run_slide()
{
    common_scripts\utility::flag_wait( "flag_search_drone_burke_anim_start" );
    wait 2.5;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "burke_dodges_drone", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
}

drone_turn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "atlasdrn_turn" );
}

drone_detect( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "atlasdrn_turn_02", 0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "atlasdrn_turn_03", 1.33 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "atlasdrn_detect", 2.23 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "atlasdrn_turn_04", 7.63 );
}

setup_deer_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "search_drone", "dronefirstturn", ::drone_turn, "search_drone" );
    maps\_anim::addnotetrack_customfunction( "search_drone", "droneturn", ::drone_detect, "search_drone" );
}

deer_sequence()
{
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "deer_moment", 0.05 );
    wait 16.5;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "deer_foliage_rustle_01" );
    wait 1.5;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "deer_jumps_out" );
    wait 0.25;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "deer_runs_away" );
    wait 4.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "deer_moment", 0.05 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_wall_climb_foley_mute" );
}

random_dog_barks()
{
    level endon( "dog_barks_stop" );
    var_0 = ( -8962, 6119, 25 );
    var_1 = ( -8204, 7556, 118 );
    var_2 = ( -7695, 6451, 67 );
    var_3 = ( -7820, 5647, -26 );
    var_4 = ( -8618, 5723, -26 );
    var_5 = [ var_0, var_1, var_2, var_3, var_4 ];
    var_6 = 17.6;

    for (;;)
    {
        var_7 = length( level.player getvelocity() ) / var_6;
        var_8 = soundscripts\_snd::snd_map( var_7, level.aud.envs["dog_bark_percentage"] );

        if ( soundscripts\_audio::aud_percent_chance( var_8 ) )
            soundscripts\_snd_playsound::snd_play_at( "guard_dog_distant", var_5[randomintrange( 0, var_5.size )] );

        wait 1;
    }
}

burke_slide_02()
{
    level.burke soundscripts\_snd_playsound::snd_play_linked( "lab_burke_slide_02", undefined, undefined, undefined, undefined, ( 0, 0, -25 ) );
}

setup_player_takedown_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "player_rig", "plyr_forest_takedown_gun_wrestle", ::plyr_forest_takedown_gun_wrestle, "forest_disarm" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "plyr_forest_takedown_punch", ::plyr_forest_takedown_punch, "forest_disarm" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "plyr_forest_takedown_tree_slam", ::plyr_forest_takedown_tree_slam, "forest_disarm" );
}

plyr_forest_takedown_gun_wrestle( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "forest_takedown_player_grab" );
}

plyr_forest_takedown_punch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "forest_takedown_player_punch" );
}

plyr_forest_takedown_tree_slam( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "forest_takedown_player_tree" );
}

player_forest_takedown( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "forest_takedown", 0.05 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_river", 0.05 );
    thread player_forest_takedown_bad_guy_left_vox( var_0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "forest_takedown_bod_fall", 4.85 );
}

player_forest_takedown_bad_guy_left_vox( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr1_takedown1react1", 0.5 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr11_takedown1react2", 0.95 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr1_takedown1react3", 2.15 );
}

burke_forest_takedown( var_0 )
{
    thread player_forest_takedown_bad_guy_right_vox( var_0 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "forest_takedown_burke_neck", 5.8 );
    wait 9.25;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "forest_takedown_burke_fall" );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "forest_takedown_pickup_wpn", 3.4, undefined, undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "forest_takedown" );
}

player_forest_takedown_bad_guy_right_vox( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr2_takedown2react1", 6.0 );
}

takedown_01_complete()
{

}

combat_forest_patrols_start( var_0 )
{
    level endon( "patrol_radios_stop" );

    for (;;)
    {
        var_1 = randomintrange( 5, 9 );
        var_2 = randomintrange( 0, var_0.size );
        var_3 = var_0[var_2];

        if ( isdefined( var_3 ) )
            var_3 soundscripts\_snd_playsound::snd_play_linked( "random_patrol_radio" );

        wait(var_1);
    }
}

aud_patrol_helo_debris_sfx()
{
    var_0 = self;
    var_1 = ( 0, 0, -875 );
}

gaz_01_dist_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "gaz_01_dist_by" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "gaz_01_dist_bumps", 7.0 );
}

gaz_02_dist_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "gaz_02_dist_by", 7.0 );
}

gaz_03_close_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "gaz_03_close_by" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_dirt_crush_lp", "aud_stop_dirt_crush_lp" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_bumps_lp", "aud_stop_bumps_lp" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        level notify( "aud_stop_dirt_crush_lp" );
    }
}

flank_right_dialogue()
{
    soundscripts\_snd::snd_music_message( "flank_right_dialogue" );
}

burke_solo_takedown( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_stab_takedown_foley_mute" );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "burke_solo_takedown_gunsling", 0.5, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 50 ) );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "burke_solo_takedown", 1.41, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 50 ) );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "burke_solo_takedown_fall", 3.01, undefined, undefined, undefined, undefined, undefined, ( 0, 0, -25 ) );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr3_takedown3react1", 2.45 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr3_takedown3react2", 3.01 );
    maps\_utility::delaythread( 4, ::gideon_knife_takedown_unmute_foley );
}

gideon_knife_takedown_unmute_foley()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_stab_takedown_foley_mute" );
}

setup_npc_cloak_button_anims()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "burke", "crch_lft_npc_cloak_buttons", ::crch_lft_npc_cloak_buttons, "cornercrouch_left_cloak_toggle" );
    maps\_anim::addnotetrack_customfunction( "burke", "crch_rt_npc_cloak_buttons", ::crch_rt_npc_cloak_buttons, "cornercrouch_right_cloak_toggle" );
    maps\_anim::addnotetrack_customfunction( "burke", "crch_exp_npc_cloak_buttons", ::crch_exp_npc_cloak_buttons, "crouch_exposed_cloak_toggle" );
}

crch_lft_npc_cloak_buttons( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "burke_cloak_buttons_crouched" );
}

crch_rt_npc_cloak_buttons( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "burke_cloak_buttons_crouched" );
}

crch_exp_npc_cloak_buttons( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "burke_cloak_buttons_crouched" );
}

lab_brk_illtakedriver()
{
    soundscripts\_snd::snd_music_message( "lab_brk_illtakedriver" );
    soundscripts\_audio_mix_manager::mm_add_submix( "vehicle_takedown_vo_duck" );
}

aud_vrap_mute_start( var_0, var_1 )
{
    var_2 = self;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_activate", 0.5 );
    wait 1.25;
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_vrap_mute_device", 0.05 );
    var_2 thread soundscripts\_snd_common::snd_mute_device( "mute_device", var_0, var_0 + 250, var_1, "mute_device" );
    var_2 thread aud_stop_vrap_mute_device();
}

aud_stop_vrap_mute_device()
{
    level waittill( "aud_vehicle_takedown_complete" );
    self notify( "turn_off" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_vrap_mute_device", 2 );
}

truck_takedown_radio( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "truck_takedown", 0.05 );
    wait 3;
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_linked( "truck_takedown_radio", undefined, undefined, undefined, undefined, ( 0, 0, 60 ) );
    level waittill( "kill_radio" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr4_takedown4react1", 0.8 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr4_takedown4react2", 2.1 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "lab_gr5_takedown5react1", 3.4 );
    wait 0.5;

    if ( isdefined( var_1 ) )
        var_1 scalevolume( 0, 0.05 );
}

truck_takedown()
{
    thread truck_takedown_burke();
    level notify( "kill_radio" );
    soundscripts\_snd_playsound::snd_play_2d( "truck_takedown_player" );
    var_0 = spawn( "script_origin", ( -9001, 7208, 60 ) );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "truck_player_door_close", 7.0 );
    common_scripts\utility::flag_wait( "truck_takedown_burke_done" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "truck_takedown", 0.05 );
}

truck_takedown_burke()
{
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "truck_takedown_door_open", 2, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 50 ) );
    wait 3.25;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "truck_takedown_burke", undefined, undefined, undefined, undefined, ( 0, 0, 50 ) );
    wait 2.0;
    level notify( "aud_vehicle_takedown_complete" );
    wait 1.85;
    var_0 = level.burke soundscripts\_snd_playsound::snd_play_linked( "truck_takedown_door_close" );

    while ( isdefined( var_0 ) )
        wait 0.5;

    common_scripts\utility::flag_set( "truck_takedown_burke_done" );
}

takedown_truck_lights_off()
{
    soundscripts\_snd_playsound::snd_play_at( "truck_takedown_lights_off", ( -8997, 7138, 70 ) );
}

vehicle_takedown_01_complete()
{
    soundscripts\_snd::snd_music_message( "vehicle_takedown_01_complete" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "vehicle_takedown_vo_duck" );
}

gaz_04_slow_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "gaz_04_slow_by" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_dirt_crush_close_lp", "aud_stop_dirt_crush_lp" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_bumps_close_lp", "aud_stop_bumps_lp" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        level notify( "aud_stop_dirt_crush_lp" );
    }
}

gaz_05_slow_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "gaz_05_slow_by", 10.0 );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_dirt_crush_close_lp", "aud_stop_dirt_crush_lp" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "gaz_bumps_close_lp", "aud_stop_bumps_lp" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        level notify( "aud_stop_dirt_crush_lp" );
    }
}

forest_mech_spawn()
{
    wait 2.5;
    soundscripts\_snd::snd_music_message( "mus_forest_mech_march" );
}

skr_distant_pull_up_and_scan()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seeker_pullup_stop" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "seeker_bumps_lp", "aud_stop_bumps_lp" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "seeker_tire_skid", 5.4 );
    wait 5.0;
    level notify( "aud_stop_bumps_lp" );
}

start_seeker_audio()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_audio_tr" ) )
        return;

    var_0 = self;
    var_1 = soundscripts\_snd_playsound::snd_play_loop_at( "seeker_scan_lp", var_0.origin, "", 0.4 );
    var_0 thread monitor_seeker_pos( var_1 );
    var_0 thread stop_seeker_audio( var_1 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_audio_to_middle" );
        var_1 soundscripts\_snd_playsound::snd_stop_sound();
    }
}

stop_seeker_audio( var_0 )
{
    self waittill( "stop_seeker_audio" );
    var_0 soundscripts\_snd_playsound::snd_stop_sound();
}

monitor_seeker_pos( var_0 )
{
    var_1 = self;
    var_1 endon( "stop_seeker_audio" );

    for (;;)
    {
        var_1 waittill( "update_seeker_audio", var_2 );
        var_0.origin = var_2;
    }
}

start_fixed_scanner_audio()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_0 = self;
    var_1 = soundscripts\_snd::snd_new_guid();
    var_2 = "stop_scan_notify" + var_1;
    var_3 = "stop_alert_notify" + var_1;
    var_0 thread monitor_fixed_scanner_explode( var_2, var_3 );
    var_0 monitor_fixed_scanner( var_2, var_3 );
    level notify( var_2 );
    level notify( var_3 );
}

monitor_fixed_scanner( var_0, var_1 )
{
    var_2 = self;
    var_2 endon( "stop_fixed_scanner_audio" );
    var_2 endon( "death" );
    level endon( "kill_all_scanner_audio" );
    var_2 soundscripts\_snd_playsound::snd_play_loop_linked( "fixed_camera_scan", var_0 );

    for (;;)
    {
        var_2 waittill( "update_fixed_scanner_audio", var_3 );

        if ( var_3 )
        {
            level notify( var_0 );
            var_2 soundscripts\_snd_playsound::snd_play_loop_linked( "fixed_camera_alert", var_1 );
            continue;
        }

        level notify( var_1 );
        var_2 soundscripts\_snd_playsound::snd_play_loop_linked( "fixed_camera_scan", var_0 );
    }
}

monitor_fixed_scanner_explode( var_0, var_1 )
{
    var_2 = self;
    level endon( "kill_all_scanner_audio" );
    var_3 = var_2.origin;
    var_2 common_scripts\utility::waittill_any( "death", "stop_fixed_scanner_audio" );
    level notify( var_0 );
    level notify( var_1 );
    soundscripts\_snd_playsound::snd_play_at( "fixed_camera_explode", var_3 );
}

seeker_clear()
{
    soundscripts\_snd::snd_music_message( "seeker_clear" );
}

aud_handle_clearing_dambs()
{
    level waittill( "aud_start_clearing_damb" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_ext_clearing_birds", ( -15522, 8176, 391 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_ext_clearing_birds", ( -14805, 8244, 300 ) );
    level waittill( "aud_stop_clearing_damb" );
    soundscripts\_audio_dynamic_ambi::damb_stop_preset( "damb_ext_clearing_birds", 3 );
    level waittill( "cliff_rappel_landing" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_ext_forest_animal", level.player.origin );
    level waittill( "aud_stop_forest_ext_damb" );
    soundscripts\_audio_dynamic_ambi::damb_stop_preset( "damb_ext_forest_animal", 3 );
}

aud_burke_nearing_cliff()
{
    level.burke soundscripts\_snd_playsound::snd_play_linked( "meetup_burke_nearing_cliff" );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_ext_cliff_scene" );
}

setup_cormack_meetup_scene_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_intro_tr" ) )
        return;

    maps\_anim::addnotetrack_customfunction( "cormack", "aud_cormack_approach", ::aud_cormack_approach, "cliff_meetup" );
    maps\_anim::addnotetrack_customfunction( "knox", "aud_knox_keypad", ::aud_knox_keypad, "cliff_meetup" );
    maps\_anim::addnotetrack_customfunction( "cormack", "aud_cormack_rappel_cable", ::aud_cormack_rappel_cable, "cliff_meetup" );
}

aud_cormack_approach( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_cormack_01", 0.05 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_burke_01", 0.25 );
    level.knox soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_knox_01", 2.55 );
    level.knox soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_knox_02", 21 );
}

aud_knox_keypad( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_cormack_02", 0.75 );
}

aud_cormack_rappel_cable( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_cormack_03", 0.1 );
    level.knox soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_knox_03", 0.25 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "meetup_foley_burke_02", 3.8 );
    level.knox soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_knox_hookup", 4.55 );
}

aud_rappel_player_hookup()
{
    wait 0.65;
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_player_hookup", 0 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_burke_jump", 8.9 );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_player_jump", 10.65 );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_gust", 12.85 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "rappel_burke_descend", 15.05 );
}

aud_rappel_player_movement_start( var_0 )
{
    if ( !level.aud.rope_started )
    {
        level.aud.rope_started = 1;

        if ( !isdefined( level.aud.ropesound ) )
        {
            level.aud.ropesound = spawn( "script_origin", level.player.origin );
            level.aud.ropesound soundscripts\_snd_playsound::snd_play_loop( "rappel_player_descend_lp" );
            var_0 thread aud_watch_for_anim_end();
        }

        level.player soundscripts\_snd_playsound::snd_play( "rappel_player_descend_start" );
        level.aud.ropesound scalevolume( 1, 0.5 );
        level.aud.ropesound scalepitch( 1, 2 );
        var_1 = var_0 common_scripts\utility::waittill_any_return( "start_cliff_jump", "aud_faded_loop" );

        if ( var_1 == "start_cliff_jump" )
        {
            if ( isdefined( level.aud.ropesound ) )
            {
                level.aud.ropesound scalevolume( 0.0, 0.15 );
                level.aud.ropesound scalepitch( 0.5, 0.15 );
            }

            level.player soundscripts\_snd_playsound::snd_play( "rappel_player_land" );
        }
    }
}

aud_watch_for_anim_end()
{
    for (;;)
    {
        var_0 = self getanimtime( level.scr_anim["player_rig"]["cliff_jump"] );

        if ( var_0 > 0.94 )
        {
            self notify( "start_cliff_jump" );
            return;
        }

        waitframe();
    }
}

aud_rappel_player_movement_stop( var_0 )
{
    if ( level.aud.rope_started )
    {
        level.aud.rope_started = 0;
        level.player soundscripts\_snd_playsound::snd_play( "rappel_player_descend_stop" );

        if ( isdefined( level.aud.ropesound ) )
        {
            level.aud.ropesound scalevolume( 0.0, 0.05 );
            level.aud.ropesound scalepitch( 0.5, 0.05 );
            wait 0.05;
            var_0 notify( "aud_faded_loop" );
        }
    }
}

aud_player_rappel_complete()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_ext_cliff_scene" );

    if ( isdefined( level.aud.ropesound ) )
    {
        level.aud.ropesound scalevolume( 0.0, 0.05 );
        level.aud.ropesound scalepitch( 0.5, 0.05 );
        wait 0.05;

        if ( isdefined( level.aud.ropesound ) )
        {
            level.aud.ropesound stoploopsound();
            wait 0.05;

            if ( isdefined( level.aud.ropesound ) )
                level.aud.ropesound delete();
        }
    }
}

lab_mute_gun_holster()
{
    soundscripts\_snd_playsound::snd_play_2d( "wpn_med_holster_plr" );
}

aud_facility_breach_start()
{
    level notify( "aud_stop_forest_ext_damb" );
    var_0 = self;
    level.player enablecustomweaponcontext();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "mute" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_activate", 0.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_step_back", 1.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_breach_plant", 4.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_breach_exp", 9.65 );
    wait 1.25;
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_facility_breach", 0.05 );
    var_0 thread soundscripts\_snd_common::snd_mute_device( "mute_device", 350, 600, 40, "mute_device" );
    var_0 thread aud_stop_mute_device_for_vo();
    wait 8.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_facility_breach", 3 );
}

aud_stop_mute_device_for_vo()
{
    level waittill( "flag_post_breach_patrol" );
    self notify( "turn_off" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "mute" );
    level.player disablecustomweaponcontext();
}

aud_lab_ambient_emitters()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_0 = spawn( "script_origin", ( -14293, 12048, -1336 ) );
    var_1 = spawn( "script_origin", ( -14278, 11609, -1322 ) );
    var_2 = spawn( "script_origin", ( -14346, 11610, -1322 ) );
    var_3 = spawn( "script_origin", ( -14454, 11538, -1322 ) );
    var_4 = spawn( "script_origin", ( -13909, 11329, -1322 ) );
    var_5 = spawn( "script_origin", ( -13962, 11329, -1322 ) );
    var_6 = spawn( "script_origin", ( -13925, 11570, -1263 ) );
    var_7 = spawn( "script_origin", ( -13801, 11293, -1263 ) );
    var_8 = spawn( "script_origin", ( -14280, 11297, -1263 ) );
    var_9 = spawn( "script_origin", ( -14044, 12307, -1318 ) );
    var_10 = spawn( "script_origin", ( -13990, 11552, -1314 ) );
    var_11 = spawn( "script_origin", ( -13600, 11500, -1268 ) );
    var_12 = spawn( "script_origin", ( -14343, 12604, -1322 ) );
    var_13 = spawn( "script_origin", ( -14335, 11846, -1264 ) );
    var_14 = spawn( "script_origin", ( -13878, 11846, -1264 ) );
    var_15 = spawn( "script_origin", ( -13902, 12387, -1323 ) );
    var_16 = spawn( "script_origin", ( -13538, 11354, -1275 ) );
    var_17 = spawn( "script_origin", ( -13506, 11915, -1136 ) );
    var_0 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_computer_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_1 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_2 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_02", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_3 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_03", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_4 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_04", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_5 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_05", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_6 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_7 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_02", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_8 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_03", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_9 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_transformer_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_10 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_transformer_02", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_11 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_transformer_03", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_12 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_04", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_13 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_05", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_14 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_06", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_15 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_ventilation_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_16 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_occluded_machine_hum_01", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    var_17 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_occluded_machine_hum_02", "aud_stop_lab_amb_emits", 0.3, undefined, 1 );
    thread aud_lab_phone_wait();

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_to_outro" );
        level notify( "aud_stop_lab_amb_emits" );
    }
}

aud_lab_phone_wait()
{
    common_scripts\utility::flag_wait( "aud_lab_phone_start" );

    for ( var_0 = 0; var_0 <= 3; var_0++ )
    {
        soundscripts\_snd_playsound::snd_play_at( "lab_phone_next_door", ( -13739, 11640, -1320 ) );
        wait 2.5;
    }
}

aud_server_room_door_crack()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    wait 1;
    soundscripts\_snd_playsound::snd_play_at( "server_door_crack", ( -13695, 11854, -1062 ) );
    var_0 = "server_room_pt_src_snds_1";
    var_1 = "server_room_pt_src_snds_2";
    var_2 = 0.3;
    var_3 = 2.0;
    var_4 = ( -13695, 11854, -1083 );
    var_5 = ( -14421, 12070, -1083 );
    var_6 = ( -13881, 11949, -1062 );
    var_7 = ( -14274, 11638, -1062 );
    var_8 = ( -13975, 11639, -1062 );
    var_9 = ( -14198, 11945, -1143 );
    var_10 = ( -14442, 11630, -1143 );
    var_11 = ( -14198, 11945, -1143 );
    var_12 = ( -14442, 11630, -1143 );
    var_13 = ( -14305, 12011, -1143 );
    var_14 = ( -13926, 11638, -1143 );
    var_15 = ( -14198, 11646, -1143 );
    var_16 = ( -14326, 11644, -1143 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_light_hum_01", var_4, var_0, var_2, 0.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_light_hum_02", var_5, var_0, var_2, 0.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_vent_01", var_6, var_0, var_2, 0.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_vent_02", var_7, var_0, var_2, 0.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_vent_03", var_8, var_0, var_2, 0.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_machine_purr_01", var_9, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_machine_purr_02", var_10, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_01", var_11, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_02", var_12, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_03", var_13, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_computer_screen_01", var_14, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_computer_screen_02", var_15, var_1, var_2, var_3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_computer_screen_01", var_16, var_1, var_2, var_3 );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );
    wait 23.5;
    thread aud_server_room_thermite();
    wait 3;
    level notify( var_1 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_to_outro" );
        level notify( var_0 );
    }
}

aud_server_room_door_kick()
{

}

aud_server_room_door_enter()
{
    wait 1;
}

setup_server_room_scene_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_player_computer", ::aud_player_computer, "server_room_exit" );
    maps\_anim::addnotetrack_customfunction( "knox", "aud_knox_thermite", ::aud_knox_thermite, "server_room_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "aud_cormack_monitor_smash", ::aud_cormack_final_monitor_smash, "server_room_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_smash_monitor_01", ::cormack_smash_monitor_01, "server_room_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_smash_monitor_02", ::cormack_smash_monitor_02, "server_room_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_player_computer", ::aud_player_computer_promo, "server_room_exit_promo" );
    maps\_anim::addnotetrack_customfunction( "knox", "aud_knox_thermite", ::aud_knox_thermite_promo, "server_room_exit_promo" );
    maps\_anim::addnotetrack_customfunction( "cormack", "aud_cormack_monitor_smash_promo", ::aud_cormack_monitor_smash_promo, "server_room_exit_promo" );
    maps\_anim::addnotetrack_customfunction( "cormack", "aud_cormack_final_smash_promo", ::aud_cormack_final_smash_promo, "server_room_exit_promo" );
}

aud_player_computer( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "server_player_monitor_move" );
}

aud_player_computer_gl_timing_fix()
{
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "server_player_interact", 0.45 );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "server_footsteps_in", 1.05 );
}

aud_knox_thermite( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "server_monitor_smashing", 0.25 );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "server_player_step_back", 7.25 );
}

cormack_smash_monitor_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "server_crmk_smash_01" );
}

cormack_smash_monitor_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "server_crmk_smash_02" );
}

aud_cormack_final_monitor_smash( var_0 )
{

}

aud_player_computer_promo( var_0 )
{

}

aud_knox_thermite_promo( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "server_player_step_back", 7.25 );
}

aud_cormack_monitor_smash_promo( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_server_promo_smash" );
    level.player soundscripts\_snd_playsound::snd_play_2d( "server_promo_monitor_smashing" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_server_promo", 5 );
}

aud_cormack_final_smash_promo( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "server_promo_final_smash" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_server_promo", 8 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_server_promo_smash", 8 );
}

aud_server_room_thermite()
{
    thread aud_server_thermite_out();
    thread aud_server_thermite_burn_start();
    thread aud_server_thermite_burn_loop();
}

aud_server_thermite_out()
{
    soundscripts\_snd_playsound::snd_play_at( "server_thermite_throw_01", ( -14237, 11851, -1148 ) );
    wait 4;
    soundscripts\_snd_playsound::snd_play_at( "server_thermite_throw_02", ( -14274, 11867, -1148 ) );
}

aud_server_thermite_burn_start()
{
    wait 9;
    level.player soundscripts\_snd_playsound::snd_play_linked( "server_thermite_flames_start" );
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_at( "server_data_center_burn_electrical_02", ( -14339, 11949, -1183 ) );
    soundscripts\_snd_filters::snd_fade_in_filter( "lab_alarm_occlusion", 0.5 );
    start_interior_alarms();
    wait 3;
    soundscripts\_snd_playsound::snd_play_at( "server_data_center_burn_electrical_01", ( -14403, 11671, -1183 ) );
}

aud_server_thermite_burn_loop()
{
    var_0 = "aud_server_thermite_burn_loop";
    var_1 = 1.0;
    var_2 = 1.5;
    var_3 = ( -14211, 11909, -1183 );
    var_4 = ( -14339, 11949, -1183 );
    var_5 = ( -14403, 11671, -1183 );
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_burn_lp_01", var_3, var_0, var_1, var_2 );
    wait 22.5;
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_burn_lp_02", var_4, var_0, var_1, var_2 );
    wait 2;
    soundscripts\_snd_playsound::snd_play_loop_at( "server_data_center_burn_lp_03", var_5, var_0, var_1, var_2 );
    common_scripts\utility::flag_wait( "vfx_server_room_exit" );
    wait 14;
    level notify( var_0 );
}

aud_foam_room_emitters()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_0 = ( -11120, 15628, -1266 );
    var_1 = ( -11120, 15072, -1266 );
    var_2 = ( -11120, 15337, -1266 );
    var_3 = ( -11492, 15947, -1266 );
    var_4 = ( -11492, 15224, -1266 );
    var_5 = ( -11266, 15826, -1332 );
    var_6 = ( -11845, 15892, -1283 );
    var_7 = "aud_server_thermite_burn_loop";
    var_8 = 0.3;
    soundscripts\_snd_playsound::snd_play_loop_at( "locker_rm_ventilation_01", var_0, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "locker_rm_ventilation_02", var_1, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "locker_rm_ventilation_03", var_2, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "foam_rm_large_ventilation_01", var_3, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "foam_rm_large_ventilation_02", var_4, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "foam_rm_large_ventilation_03", var_5, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_loop_at( "foam_rm_computer_01", var_6, var_7, var_8 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_to_outro" );
        level notify( var_7 );
    }
}

aud_post_courtyard_emitters()
{
    var_0 = spawn( "script_origin", ( -12753, 10939, -1245 ) );
    var_1 = spawn( "script_origin", ( -12963, 10956, -1256 ) );
    var_2 = spawn( "script_origin", ( -11863, 11300, -1256 ) );
    var_3 = spawn( "script_origin", ( -11412, 11044, -1149 ) );
    var_4 = spawn( "script_origin", ( -11667, 10866, -1034 ) );
    thread aud_balcony_aircraft_wait();
    var_5 = spawn( "script_origin", ( -11017, 10329, -1006 ) );
    var_6 = spawn( "script_origin", ( -11526, 10305, -862 ) );
    var_7 = spawn( "script_origin", ( -11404, 9942, -1007 ) );
    var_8 = spawn( "script_origin", ( -11049, 9586, -1075 ) );
    var_9 = spawn( "script_origin", ( -12409, 9438, -1244 ) );
    var_10 = spawn( "script_origin", ( -12193, 9033, -1263 ) );
    var_11 = spawn( "script_origin", ( -12200, 9594, -1254 ) );
    var_12 = spawn( "script_origin", ( -12788, 8695, -1055 ) );
    var_13 = spawn( "script_origin", ( -13226, 9027, -1075 ) );
    var_14 = spawn( "script_origin", ( -12164, 9970, -1075 ) );
    var_15 = spawn( "script_origin", ( -12062, 9618, -1231 ) );
    var_16 = spawn( "script_origin", ( -13244, 9199, -1223 ) );
    var_17 = spawn( "script_origin", ( -13244, 9389, -1223 ) );
    var_18 = spawn( "script_origin", ( -12429, 9680, -1123 ) );
    var_19 = spawn( "script_origin", ( -12429, 9101, -1123 ) );
    var_20 = spawn( "script_origin", ( -12815, 8943, -1153 ) );
    var_21 = spawn( "script_origin", ( -13074, 9282, -1257 ) );
    var_22 = spawn( "script_origin", ( -12932, 8798, -1245 ) );
    var_23 = spawn( "script_origin", ( -12612, 8798, -1245 ) );
    var_24 = spawn( "script_origin", ( -12294, 8588, -1200 ) );
    var_25 = spawn( "script_origin", ( -13189, 9585, -1250 ) );
    var_26 = spawn( "script_origin", ( -12295, 9360, -1174 ) );
    var_27 = spawn( "script_origin", ( -12405, 9439, -1174 ) );
    var_28 = spawn( "script_origin", ( -12307, 9516, -1174 ) );
    var_0 thread soundscripts\_snd_playsound::snd_play_loop_linked( "lab_electromech_06", undefined, 0.3, undefined, 1 );
    var_1 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_turbine_01", undefined, 0.3, undefined, 1 );
    var_2 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_turbine_02", undefined, 0.3, undefined, 1 );
    var_3 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_ventilation_01", undefined, 0.3, undefined, 1 );
    var_4 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_turbine_03", undefined, 0.3, undefined, 1 );
    var_5 thread soundscripts\_snd_playsound::snd_play_loop_linked( "balcony_left", undefined, 0.3, undefined, 1 );
    var_6 thread soundscripts\_snd_playsound::snd_play_loop_linked( "balcony_right", undefined, 0.3, undefined, 1 );
    var_7 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_ventilation_02", undefined, 0.3, undefined, 1 );
    var_8 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_turbine_05", undefined, 0.3, undefined, 1 );
    var_12 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_turbine_04", undefined, 0.3, undefined, 1 );
    var_13 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_ventilation_03", undefined, 0.3, undefined, 1 );
    var_14 thread soundscripts\_snd_playsound::snd_play_loop_linked( "post_courtyard_ventilation_01", undefined, 0.3, undefined, 1 );

    if ( level.currentgen && !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_post_middle_to_outro" );

    var_9 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_close_02", undefined, 0.3, undefined, 1 );
    var_10 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_close_01", undefined, 0.3, undefined, 1 );
    var_11 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_close_01", undefined, 0.3, undefined, 1 );
    var_15 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_computer_01", undefined, 0.3, undefined, 1 );
    var_16 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_computer_02", undefined, 0.3, undefined, 1 );
    var_17 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_computer_03", undefined, 0.3, undefined, 1 );
    common_scripts\utility::flag_wait( "aud_hangar_light_hum_start" );
    var_18 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_light_hum_01", undefined, 6.0, undefined, 1 );
    var_19 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_light_hum_02", undefined, 6.0, undefined, 1 );
    var_20 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_small_electromech_01", undefined, 0.1, undefined, 1 );
    var_21 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_small_electromech_02", undefined, 0.1, undefined, 1 );
    var_22 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_ventilation_01", undefined, 1.0, undefined, 1 );
    var_23 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_ventilation_02", undefined, 1.0, undefined, 1 );
    var_24 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_transformer_01", undefined, 0.1, undefined, 1 );
    var_25 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_transformer_02", undefined, 0.1, undefined, 1 );
    var_26 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_low_drone", undefined, 1.0, undefined, 1 );
    var_27 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_high_drone", undefined, 1.0, undefined, 1 );
    var_26 setpitch( 0.5 );
    var_27 setpitch( 0.4 );
    waitframe();
    var_26 scalepitch( 1, 4 );
    var_27 scalepitch( 1, 2.5 );
    wait 1;
    var_28 thread soundscripts\_snd_playsound::snd_play_loop_linked( "hangar_comp_bg", undefined, 5.0, undefined, 1 );
    common_scripts\utility::flag_wait( "flag_hovertank_reveal_scene_started" );
    wait 4;
    var_12 scalevolume( 0.1, 4 );
    var_13 scalevolume( 0.1, 4 );
    var_14 scalevolume( 0.1, 4 );
    var_18 scalevolume( 0.1, 4 );
    var_19 scalevolume( 0.1, 4 );
    var_20 scalevolume( 0.1, 4 );
    var_21 scalevolume( 0.1, 4 );
    var_22 scalevolume( 0.1, 4 );
    var_23 scalevolume( 0.1, 4 );
    var_26 scalevolume( 0.3, 4 );
    var_27 scalevolume( 0.3, 4 );
    var_28 scalevolume( 0.3, 4 );

    for ( var_29 = 0; var_29 <= 3; var_29++ )
    {
        soundscripts\_snd_playsound::snd_play_at( "hangar_warning", ( -12776, 10038, -1084 ) );
        wait 3;
    }

    level waittill( "kill_tank_startup_loop" );
    wait 4.8;
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_0, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_1, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_2, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_3, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_4, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_5, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_6, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_7, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_8, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_9, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_10, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_11, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_12, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_13, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_14, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_15, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_16, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_17, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_18, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_19, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_20, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_21, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_22, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_23, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_26, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_27, 4 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_28, 4 );
}

aud_balcony_aircraft_wait()
{
    common_scripts\utility::flag_wait( "aud_balcony_aircraft" );
    soundscripts\_snd_playsound::snd_play_at( "balcony_aircraft", ( -11050, 10541, -733 ) );
}

player_plant_frb()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bio_room_detonate", 0.05 );
    soundscripts\_snd_playsound::snd_play_2d( "bio_lab_frb_plant" );
}

foam_room_door_close( var_0, var_1 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bio_lab_frb_clacker_equip" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bio_lab_door_close_left" );
    var_1 soundscripts\_snd_playsound::snd_play_linked( "bio_lab_door_close_right" );
    level notify( "kill_all_scanner_audio" );
    level waittill( "vfx_foam_room_explode_start" );
    gas_release();
}

gas_release()
{
    var_0 = spawn( "script_origin", ( -11430, 15458, -1352 ) );
    var_1 = "stop_bio_lab_gas_loop";
    var_2 = 1.5;
    var_3 = 1.0;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bio_lab_gas_exp" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "bio_lab_gas_loop", var_1, var_2, var_3 );
    level waittill( "kill_gas_loop" );
    level notify( var_1 );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "bio_room_detonate", 1 );
}

door2courtyard_open()
{
    var_0 = ( -11247, 15082, -1373 );
    var_1 = ( -11247, 15137, -1373 );
    common_scripts\utility::flag_wait( "flag_foam_room_complete_dialogue" );
    soundscripts\_snd_playsound::snd_play_at( "door_to_courtyard_left", var_0 );
    soundscripts\_snd_playsound::snd_play_at( "door_to_courtyard_right", var_1 );
}

current_gen_hangar_door_open()
{
    soundscripts\_snd_playsound::snd_play_at( "lab_hangar_door_open", ( -11420, 10077, -1068 ) );
}

hangar_lights_on()
{
    soundscripts\_snd::snd_music_message( "tank_reveal" );
    var_0 = ( -12621, 9561, -1059 );
    var_1 = ( -12926, 9561, -1059 );
    var_2 = ( -12926, 9496, -1059 );
    var_3 = ( -12621, 9496, -1059 );
    var_4 = ( -12621, 9433, -1059 );
    var_5 = ( -12926, 9433, -1059 );
    var_6 = ( -12926, 9367, -1059 );
    var_7 = ( -12621, 9367, -1059 );
    var_8 = ( -12621, 9305, -1059 );
    var_9 = ( -12926, 9305, -1059 );
    var_10 = ( -12926, 9240, -1059 );
    var_11 = ( -12621, 9240, -1059 );
    var_12 = ( -12621, 9175, -1059 );
    var_13 = ( -12926, 9175, -1059 );
    var_14 = 1;
    common_scripts\utility::flag_set( "aud_hangar_light_hum_start" );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_1 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_12 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_2 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_11 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_5 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_8 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_6 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_7 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_9 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_4 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_10 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_3 );
    wait(var_14);
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_13 );
    soundscripts\_snd_playsound::snd_play_at( "tank_hangar_light_on", var_0 );
}

setup_hangar_notetracks()
{
    if ( level.currentgen && !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_post_middle_to_outro" );

    maps\_anim::addnotetrack_customfunction( "knox", "aud_knox_control_panel", ::hovertank_control_panel, "hovertank_reveal_approach" );
}

hovertank_control_panel( var_0 )
{

}

hover_tank_startup_sequence()
{
    var_0 = ( -12771, 9352, -1203 );
    var_1 = ( -12769, 9327, -1155 );
    var_2 = ( -12593, 9526, -1256 );
    var_2 = ( -12934, 9526, -1256 );
    var_3 = ( -12593, 9242, -1256 );
    var_3 = ( -12934, 9242, -1256 );
    var_4 = ( -12660, 9173, -1227 );
    var_5 = ( -12801, 9173, -1227 );
    soundscripts\_audio_mix_manager::mm_add_submix( "hover_tank_startup", 0.1 );
    soundscripts\_snd::snd_music_message( "hover_tank_startup" );
    soundscripts\_snd_playsound::snd_play_delayed_at( "ht_startup_main", var_0, 3.5 );
    wait 16.6;
    soundscripts\_snd_playsound::snd_play_at( "ht_startup_hover_engage", var_0 );
    soundscripts\_snd_playsound::snd_play_at( "ht_support_release_fl", var_2 );
    soundscripts\_snd_playsound::snd_play_at( "ht_support_release_fr", var_2 );
    soundscripts\_snd_playsound::snd_play_at( "ht_support_release_rl", var_3 );
    soundscripts\_snd_playsound::snd_play_at( "ht_support_release_rr", var_3 );
    wait 2.2;
    var_6 = "stop_ht_startup_engine_loop";
    var_7 = 3.75;
    var_8 = 4.0;
    soundscripts\_snd_playsound::snd_play_loop_at( "ht_startup_engine_loop", var_0, var_6, var_7, var_8 );
    soundscripts\_snd_playsound::snd_play_at( "ht_startup_armor_panels", var_0 );
    wait 3;
    soundscripts\_snd_playsound::snd_play_at( "ht_rear_panels_l", var_4 );
    soundscripts\_snd_playsound::snd_play_at( "ht_rear_panels_r", var_5 );
    wait 10.2;
    soundscripts\_snd_playsound::snd_play_at( "ht_hatch_open_ext", var_1 );
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "ht_cormack_feet_ext_hangar", 3, undefined, undefined, undefined, undefined, undefined, ( 0, 0, -25 ) );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "ht_burke_feet_ext_hangar", 3, undefined, undefined, undefined, undefined, undefined, ( 0, 0, -25 ) );
    level waittill( "kill_tank_startup_loop" );
    wait 4.8;
    level notify( var_6 );
}

hovertank_enter()
{
    level notify( "kill_tank_startup_loop" );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_tank_foley_mute" );
    thread soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_metal_vehicle" );
    soundscripts\_snd_playsound::snd_play_2d( "ht_player_tank_enter" );
    var_0 = ( -12768, 9350, -1248 );
    var_1 = "stop_ht_int_idle_low";
    var_2 = 6.0;
    var_3 = 1.0;
    var_4 = 0.3;
    soundscripts\_snd_playsound::snd_play_loop_at( "ht_int_idle_low", var_0, var_1, var_2, var_3, var_4 );
    wait 5.8;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "ht_burke_tank_enter" );
    level waittill( "tank_switch" );
    tank_screens_boot_up();
    level notify( var_1 );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "hover_tank_startup", 1.0 );
}

aud_player_gets_in_tank()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "lab_int_tank", 1.0 );
    aud_hangar_door_open();
    soundscripts\_audio_mix_manager::mm_add_submix( "tank_battle", 0.25 );
}

tank_screens_boot_up()
{
    level notify( "stop_post_courtyard_alarms" );
    soundscripts\_snd_playsound::snd_play_2d( "ht_monitors_boot_up" );
}

aud_impact_system_hovertank( var_0 )
{
    var_1 = [];
    var_1["Debug"] = 0;
    var_1["VehicleID"] = "tank_impact";
    var_1["PV_MinVelocityThreshold"] = 10;
    var_1["PV_MaxVelocity"] = 250;
    var_1["PV_NumVelocityRanges"] = 3;
    var_1["PV_MaxSmlVelocity"] = 45;
    var_1["PV_MaxMedVelocity"] = 125;
    var_1["PV_MaxLrgVelocity"] = 250;
    var_1["NPC_MinVelocityThreshold"] = 25;
    var_1["NPC_MaxVelocity"] = 800;
    var_1["NPC_NumVelocityRanges"] = 3;
    var_1["NPC_MaxSmlVelocity"] = 100;
    var_1["NPC_MaxMedVelocity"] = 400;
    var_1["NPC_MaxLrgVelocity"] = 800;
    var_1["MinLFEVolumeThreshold"] = 0.0;
    var_1["FallVelMultiplier"] = 2;
    var_1["MinTimeThreshold"] = 250;
    var_1["ScrapeEnabled"] = 0;
    var_1["ScrapeSeperationTime"] = 0.5;
    var_1["ScrapeFadeOutTime"] = 0.5;
    var_1["ScrapeUpdateRate"] = 0.05;
    var_1["TireSkidProbability"] = 0;
    var_1["MaxDistanceThreshold"] = 6000;
    var_1["MedVolMin"] = 0.1;
    var_1["LrgVolMin"] = 0.5;
    var_1["NonPlayerImpVolReduction"] = 0.0;
    soundscripts\_snd_common::snd_play_vehicle_collision( var_0, var_1 );
}

aud_hangar_door_open()
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_at( "hangar_door_open", ( -12765, 10082, -1108 ) );
}

begin_pcap_vo_lab_serverroom_cormack()
{
    soundscripts\_snd::snd_music_message( "begin_pcap_vo_lab_serverroom_cormack" );
}

open_server_room_door()
{
    soundscripts\_snd::snd_music_message( "open_server_room_door" );
    soundscripts\_snd_filters::snd_fade_out_filter( 0.5 );
}

research_building_combat_complete()
{
    soundscripts\_snd::snd_music_message( "research_building_combat_complete" );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_neutralize_bio_weapons_complete", 1 );
}

foam_room_crmk_plant_these_frvs()
{
    soundscripts\_snd::snd_music_message( "foam_room_crmk_plant_these_frvs" );
}

neutralize_bio_weapons_complete()
{
    soundscripts\_snd::snd_music_message( "neutralize_bio_weapons_complete" );
}

foam_room_complete_dialogue()
{
    soundscripts\_snd::snd_music_message( "begin_courtyard_combat" );
    start_courtyard_alarms();
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_neutralize_bio_weapons_complete", 6 );
}

begin_courtyard_combat()
{

}

aud_ctyard_vrap01()
{
    level.courtyard_vrap01 soundscripts\_snd_playsound::snd_play_linked( "scn_lab_ctyard_vrap01" );
    level notify( "stop_interior_alarms" );
    soundscripts\_snd::snd_music_message( "pre_mech_vrap" );
}

aud_ctyard_vrap02()
{
    level.courtyard_vrap02 soundscripts\_snd_playsound::snd_play_delayed_linked( "scn_lab_ctyard_vrap02", 0.01 );
}

aud_ctyard_vrap04()
{
    level.courtyard_vrap04 soundscripts\_snd_playsound::snd_play_linked( "scn_lab_ctyard_vrap04" );
    level notify( "kill_gas_loop" );
}

aud_ctyard_vrap05()
{
    level.courtyard_vrap05 soundscripts\_snd_playsound::snd_play_delayed_linked( "scn_lab_ctyard_vrap05", 0.95 );
}

courtyard_hangar_mech_01_spawned( var_0 )
{
    soundscripts\_snd::snd_music_message( "courtyard_hangar_mech_01_spawned" );
}

courtyard_door_hack_start_dialogue()
{
    soundscripts\_snd::snd_music_message( "courtyard_door_hack_start_dialogue" );
}

courtyard_start_dish()
{
    if ( level.currentgen && !istransientloaded( "lab_middle_tr" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_0 = spawn( "script_origin", ( -12332, 13331, -1093 ) );
    var_0 thread soundscripts\_snd_playsound::snd_play_loop_linked( "courtyard_jammer_mech", undefined, 0.3, undefined, 1 );
    common_scripts\utility::flag_wait( "aud_start_jammer" );
    var_1 = spawn( "script_origin", ( -12289, 13353, -1120 ) );
    var_2 = spawn( "script_origin", ( -12324, 13352, -1088 ) );
    var_1 thread soundscripts\_snd_playsound::snd_play_loop_linked( "courtyard_jammer_emi_close", undefined, 1.0, undefined, 1 );
    var_2 thread soundscripts\_snd_playsound::snd_play_loop_linked( "courtyard_jammer_emi_wide", undefined, 1.0, undefined, 1 );
    common_scripts\utility::flag_wait( "flag_obj_jammer_interact" );
    wait 2;
    var_0 scalepitch( 0.5, 3 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_1, 1 );
    var_2 scalepitch( 0.1, 2 );
    wait 1;
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_0, 2 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( var_2, 1 );
}

courtyard_end_jammer()
{
    wait 1.35;
    level.player soundscripts\_snd_playsound::snd_play_linked( "courtyard_jammer_plant" );
}

courtyard_defend_start()
{
    soundscripts\_snd::snd_music_message( "courtyard_defend_start" );
}

aud_courtyard_hangar_door_close()
{
    soundscripts\_snd_playsound::snd_play_at( "lab_hangar_door_close", ( -12699, 11527, -1256 ) );
}

aud_courtyard_hangar_door_hack( var_0, var_1 )
{
    wait_for_anim_start( var_0, var_1 );
    wait 2;
    level.knox soundscripts\_snd_playsound::snd_play_linked( "lab_hangar_door_hack_foley_start" );
}

aud_courtyard_hangar_door_hack_idle( var_0, var_1 )
{
    level endon( "hack_success" );
    var_2 = 1;
    wait_for_anim_start( var_0, var_1 );

    for (;;)
    {
        var_3 = var_1 getanimtime( var_0 );

        if ( var_3 < var_2 )
            maps\_utility::delaythread( 3.45, ::play_sound_stop_on_notify, "lab_hangar_door_hack_foley", level.knox, "hack_success" );

        var_2 = var_3;
        waitframe();
    }
}

aud_courtyard_hangar_door_open()
{
    soundscripts\_snd_playsound::snd_play_at( "lab_hangar_door_open", ( -12699, 11527, -1256 ) );
    start_post_courtyard_interior_alarms();
}

courtyard_hangar_door_close_rpg( var_0, var_1 )
{
    var_2 = self;
    soundscripts\_snd::snd_music_message( "courtyard_hangar_door_close" );
    var_2 thread play_courtyard_hangar_door_rpg( var_0, var_1 );
    soundscripts\_snd_filters::snd_fade_in_filter( "lab_courtyard_hangar_door_rpg", var_1 );
}

play_courtyard_hangar_door_rpg( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        var_2 = self;
        var_3 = var_2.origin;
        soundscripts\_snd_playsound::snd_play_at( "lab_hangar_door_close_int", ( -12699, 11491, -1256 ) );
        soundscripts\_snd_playsound::snd_play_at( "courtyard_hangar_door_rpg_fire", var_3 );
        var_2 soundscripts\_snd_playsound::snd_play_loop_linked( "courtyard_hangar_door_rpg_travel", "stop_courtyard_hangar_door_rpg_travel" );
        wait(var_1);
        level notify( "stop_courtyard_hangar_door_rpg_travel" );
        var_4 = spawnstruct();
        var_4.pos = var_0;
        var_4.speed_of_sound_ = 1;
        var_4.incoming_alias_ = "exp_generic_incoming";
        var_4.duck_alias_ = "exp_generic_explo_sub_kick";
        var_4.duck_dist_threshold_ = 1000;
        var_4.explo_delay_chance_ = 100;
        var_4.shake_dist_threshold_ = 2000;
        var_4.explo_debris_alias_ = "exp_debris_dirt_chunks";
        var_4.ground_zero_alias_ = "exp_grnd_zero_stone";
        var_4.ground_zero_dist_threshold_ = 500;
        soundscripts\_snd_common::snd_ambient_explosion( var_4 );
    }
}

boxtruck_explode()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lab_boxtruck_explode" );
}

warbird_emp_death()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play( "warbird_emp_impact" );
}

log_pile_collapse( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "log_pile_collapse", var_0.origin + ( 0, 0, 100 ) );
}

tank_shack_destruct( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "shack_destroyed", var_0 );
}

aud_tank_road_littlebird_1( var_0 )
{
    var_1 = "LB-" + var_0;
    var_2 = "littlebird_road_flyby";
    var_3 = [];
    var_3["littlebird_med_incoming"] = 9.5;
    var_4 = [];
    var_4[0] = 1400;
    var_4[1] = 2000;
    var_4[2] = 2500;
    var_5 = [];
    var_5[0] = 40;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, var_4, var_5, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_tank_road_littlebird_2( var_0 )
{
    var_1 = "LB-" + var_0;
    var_2 = "littlebird_road_flyby";
    var_3 = [];
    var_3[0] = 1600;
    var_4 = [];
    var_4[0] = 33;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, undefined, var_3, var_4, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_tank_field_warbird()
{
    var_0 = "WB-1:  ";
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2["warbird_field_spawn_1st"] = 0.266;
    var_2["warbird_field_spawn_2nd"] = 16.096;
    var_3 = [];
    var_3[0] = 2000;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, undefined, 1, undefined, "warbird_death_explo" );
}

aud_tank_field_littlebird( var_0 )
{
    var_1 = "LB-" + var_0 + ":  ";
    var_2 = "littlebird_flyby";
    var_3 = [];
    var_3["littlebird_field_spawn_far"] = 4.857;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, undefined, undefined, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_combat_clearing_1_warbird()
{
    var_0 = "WB-2:  ";
    var_1 = "warbird_clearing_flyby";
    var_2 = [];
    var_2["warbird_clearing_spawn_1st"] = 0.369;
    var_2["warbird_clearing_spawn_2nd"] = 15.957;
    var_2["warbird_clearing_spawn_3rd"] = 18.859;
    var_3 = [];
    var_3[0] = 2000;
    var_3[1] = 3000;
    var_3[2] = 5000;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, undefined, 1, undefined, "warbird_death_explo" );
}

aud_combat_clearing_2_littlebird_1( var_0 )
{
    var_1 = "LB-" + var_0 + ":  ";
    var_2 = "littlebird_clearing2_flyby";
    var_3 = [];
    var_3["littlebird_clearing2_spawn"] = 4.74;
    var_4 = [];
    var_4[0] = 2000;
    var_4[1] = 3000;
    var_5 = [];
    var_5[0] = 40;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, var_4, var_5, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_combat_clearing_2_littlebird_2( var_0 )
{
    var_1 = "LB-" + var_0 + ":  ";
    var_2 = "littlebird_flyby";
    var_3 = [];
    var_3["littlebird_med_incoming"] = 0.1;
    var_3["littlebird_far_incoming"] = 15.415;
    var_4 = [];
    var_4[0] = 1900;
    var_5 = [];
    var_5[0] = 15;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, var_4, var_5, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_combat_clearing_3_littlebird_1( var_0 )
{
    var_1 = "LB-" + var_0 + ":  ";
    var_2 = "littlebird_flyby";
    var_3 = [];
    var_3["littlebird1_clearing3_spawn"] = 3.145;
    var_4 = [];
    var_4[0] = 500;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, var_4, undefined, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_combat_clearing_3_littlebird_2( var_0 )
{
    var_1 = "LB-" + var_0 + ":  ";
    var_2 = "littlebird_flyby";
    var_3 = [];
    var_3["littlebird2_clearing3_spawn"] = 4.658;
    var_4 = [];
    var_4[0] = 500;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_2, var_3, var_4, undefined, 1, "littlebird_death_spin", "littlebird_death_explo" );
}

aud_ascent_final_warbird()
{
    var_0 = "WB-3:  ";
    var_1 = "warbird_flyby";
    var_2 = [];
    var_2["warbird_ascent_spawn"] = 1.0;
    var_3 = [];
    var_3[0] = 500;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, undefined, 1, undefined, "warbird_death_explo" );
}

tank_disabled()
{
    soundscripts\_snd_playsound::snd_play_2d( "ht_monitors_power_down" );
    var_0 = ( 6859, 14947, -484 );
    soundscripts\_snd_playsound::snd_play_at( "ht_hatch_open_int", ( 6792, 14954, -448 ) );
    soundscripts\_snd_playsound::snd_play_at( "ht_exfil_engine_power_down", var_0 );
    soundscripts\_snd_playsound::snd_play_at( "ht_exfil_tank_rattle", var_0 );
    wait 2.7;
    soundscripts\_snd::snd_music_message( "end_tank_combat" );
}

tank_exit()
{
    thread razorback_fly_in();
    thread soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_metal_vehicle" );
    wait 8.3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "tank_battle" );
    soundscripts\_audio_mix_manager::mm_add_submix( "tank_exfil" );
}

set_up_tank_exit_anims()
{
    if ( level.currentgen && !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_post_middle_to_outro" );

    maps\_anim::addnotetrack_customfunction( "burke", "lab_tank_exit_gid_stand", ::lab_tank_exit_gid_stand, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "burke", "lab_tank_exit_gid_walk", ::lab_tank_exit_gid_walk, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "burke", "lab_tank_exit_gid_stairs", ::lab_tank_exit_gid_stairs, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "burke", "lab_tank_exit_gid_at_hatch", ::lab_tank_exit_gid_at_hatch, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "lab_tank_exit_crmk_stand", ::lab_tank_exit_crmk_stand, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "lab_tank_exit_crmk_walk", ::lab_tank_exit_crmk_walk, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "lab_tank_exit_crmk_land", ::lab_tank_exit_crmk_land, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "knox", "lab_tank_exit_knx_stand", ::lab_tank_exit_knx_stand, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "knox", "lab_tank_exit_knx_stairs", ::lab_tank_exit_knx_stairs, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "knox", "lab_tank_exit_knx_at_hatch", ::lab_tank_exit_knx_at_hatch, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "knox", "lab_tank_exit_knx_land", ::lab_tank_exit_knx_land, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "lab_tank_exit_plr_stand", ::lab_tank_exit_plr_stand, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "lab_tank_exit_plr_stairs", ::lab_tank_exit_plr_stairs, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "lab_tank_exit_plr_at_hatch", ::lab_tank_exit_plr_at_hatch, "hovertank_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "lab_tank_exit_plr_land", ::lab_tank_exit_plr_land, "hovertank_exit" );
}

lab_tank_exit_gid_stand( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_burke_stand" );
}

lab_tank_exit_gid_walk( var_0 )
{

}

lab_tank_exit_gid_stairs( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_burke_stairs" );
}

lab_tank_exit_gid_at_hatch( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_burke_hatch" );
}

lab_tank_exit_crmk_stand( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_cormack_stand" );
}

lab_tank_exit_crmk_walk( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_cormack_stairs" );
}

lab_tank_exit_crmk_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_cormack_land" );
}

lab_tank_exit_knx_stand( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_knox_stand" );
}

lab_tank_exit_knx_stairs( var_0 )
{

}

lab_tank_exit_knx_at_hatch( var_0 )
{

}

lab_tank_exit_knx_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "ht_exit_tank_knox_land" );
}

lab_tank_exit_plr_stand( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "ht_exit_tank_player" );
}

lab_tank_exit_plr_stairs( var_0 )
{

}

lab_tank_exit_plr_at_hatch( var_0 )
{

}

lab_tank_exit_plr_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "ht_exit_tank_player_land" );
}

lab_exfil_missile_strike()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lab_missile_strike_incoming" );
    var_1 = var_0.origin;

    while ( isdefined( var_0 ) )
    {
        var_1 = var_0.origin;
        wait 0.05;
    }

    soundscripts\_snd_playsound::snd_play_at( "lab_missile_strike_explo", var_1 );
}

razorback_fly_in()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "lab_tank_foley_mute" );
    soundscripts\_audio_mix_manager::mm_add_submix( "razorback_fly_in" );
    level waittill( "hovertank_hide_interior" );
    soundscripts\_snd_playsound::snd_play_2d( "razorback_fly_by" );
}

razorback_land()
{
    var_0 = ( 7836, 14849, -505 );
    var_1 = ( 7899, 14651, -526 );
    level.razorback soundscripts\_snd_playsound::snd_play_linked( "razorback_overhead" );
    wait 3.5;
    var_2 = soundscripts\_snd_playsound::snd_play_loop_at( "razorback_ext_idle", var_1, "kill_engine_loop" );
    var_3 = soundscripts\_snd_playsound::snd_play_loop_at( "razorback_ext_idle_jet", var_0, "kill_jet_loop" );
    level waittill( "player_enters_razorback" );
    soundscripts\_snd_playsound::snd_play_2d( "razorback_int_takeoff" );
    var_3 scalevolume( 0, 2 );
    wait 2;
    level notify( "kill_jet_loop" );
    var_2 scalevolume( 0.5, 4 );
    wait 5;
    var_2 scalevolume( 0, 3 );
    wait 3;
    level notify( "kill_engine_loop" );
}

aud_start_exfil_foley()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_razor_exfil_foley_mute" );
    wait 0.65;
    soundscripts\_snd_playsound::snd_play_2d( "lab_exfil_player_foley" );
    wait 3.76;
    soundscripts\_snd_playsound::snd_play_at( "lab_exfil_portside_guy_foley", ( 7958, 14634, -529 ) );
    wait 1.1;
    soundscripts\_snd_playsound::snd_play_at( "lab_exfil_cormack_foley", ( 7894, 14727, -538 ) );
}

lab_exfil_detonate_anims()
{
    if ( level.currentgen && !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_post_middle_to_outro" );

    maps\_anim::addnotetrack_customfunction( "burke", "lab_exfil_wrist_panel", ::lab_exfil_wrist_panel, "exfil_enter" );
}

lab_exfil_wrist_panel( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lab_exfil_gideon_exo_panel" );
}

tank_exfil_charges_going_off()
{
    soundscripts\_snd_playsound::snd_play_2d( "ht_exfil_charges_ignite" );
}

tank_exfil_detonate()
{
    soundscripts\_snd_playsound::snd_play_2d( "ht_exfil_detonate" );
    wait 3;
    soundscripts\_snd_playsound::snd_play_2d( "ht_exfil_exp_secondaries" );
}

lab_e3_end_logo()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "lab_end_logo_e3", 0.5 );
    soundscripts\_audio_mix_manager::mm_add_submix( "lab_end_logo" );
}

e3_demo_fade_out()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

e3_demo_clear_alarm()
{
    level notify( "stop_interior_alarms" );
}

e3_demo_fade_in()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 0.05;
    start_post_courtyard_interior_alarms();
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 2.0 );
}

aud_lab_foley_override_handler()
{
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "foley", var_0, var_1, var_2 );

        switch ( var_0 )
        {
            case "stationarycrouchscuff":
                break;
            case "stationaryscuff":
                break;
            case "crouchscuff":
                break;
            case "runscuff":
                break;
            case "sprintscuff":
                break;
            case "prone":
                break;
            case "crouchwalk":
                break;
            case "crouchrun":
                break;
            case "walk":
                if ( isdefined( level.aud.in_river ) && level.aud.in_river == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_walk_r" );
                }
                else if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_walk" );

                break;
            case "run":
                if ( isdefined( level.aud.in_river ) && level.aud.in_river == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_r" );
                }
                else if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_run" );

                break;
            case "sprint":
                if ( isdefined( level.aud.in_river ) && level.aud.in_river == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_r" );
                }
                else if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_sprint" );

                break;
            case "jump":
                break;
            case "lightland":
                if ( isdefined( level.aud.in_river ) && level.aud.in_river == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_l" );
                    soundscripts\_snd_playsound::snd_play_2d( "fs_river_player_sprint_r" );
                }
                else if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_land_lt" );

                break;
            case "mediumland":
                if ( isdefined( level.aud.in_river ) && level.aud.in_river == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "river_player_splash_med" );
                else if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_land_med" );

                break;
            case "heavyland":
                if ( isdefined( level.aud.opening_run ) && level.aud.opening_run == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "lab_opening_chase_land_hv" );

                break;
            case "damageland":
                break;
            case "mantleuphigh":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_up_high" );
                break;
            case "mantleupmedium":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_up_medium" );
                break;
            case "mantleuplow":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_up_low" );
                break;
            case "mantleoverhigh":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_over_high" );
                break;
            case "mantleovermedium":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_over_medium" );
                break;
            case "mantleoverlow":
                soundscripts\_snd_playsound::snd_play_2d( "log_mantle_over_low" );
                break;
        }
    }
}

start_interior_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.01 ] ];
    var_1 = [ [ 0.0, 0.25 ], [ 284.751, 0.5 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 915.82, 0.1099 ], [ 1080.0, 0.01 ] ];
    thread alarm_enable( ( -14489, 12517, -1115 ), 0.4, "alarm_av_04_int_near", var_0, "alarm_av_04_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -14431, 12807, -1148 ), 0.1, "alarm_av_07_int_near", var_0, "alarm_av_07_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -13884, 14223, -1154 ), 0.2, "alarm_av_01_int_near", var_0, "alarm_av_01_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -13884, 14223, -1154 ), 0.2, "alarm_av_09_int_near", var_0, "alarm_av_09_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -12548, 14973, -1148 ), 0.3, "alarm_av_04_int_near", var_0, "alarm_av_04_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -13072, 15642, -1148 ), 0.3, "alarm_av_04_int_near", var_0, "alarm_av_04_int_far", var_1, "stop_interior_alarms" );
    thread alarm_enable( ( -11896, 15552, -1148 ), 0.2, "alarm_01_int_near", var_0, "alarm_01_int_far", var_1, "stop_interior_alarms" );
}

start_courtyard_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.01 ] ];
    var_1 = [ [ 0.0, 0.25 ], [ 284.751, 0.5 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 915.82, 0.1099 ], [ 1080.0, 0.01 ] ];
    var_0 = soundscripts\_audio::aud_scale_envelope( var_0, 1.7 );
    var_1 = soundscripts\_audio::aud_scale_envelope( var_1, 1.7 );
    thread alarm_enable( ( -12683, 11674, -1260 ), 0.6, "alarm_al_01a_int_near", var_0, "alarm_06_int_far", var_1, "stop_courtyard_alarms" );
}

start_post_courtyard_interior_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.01 ] ];
    var_1 = [ [ 0.0, 0.25 ], [ 284.751, 0.5 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 915.82, 0.1099 ], [ 1080.0, 0.01 ] ];
    var_2 = ( -12837, 11152, -1239 );
    var_3 = ( -12163, 11008, -1210 );
    var_4 = ( -11496, 10433, -1068 );
    var_5 = ( -10758, 10549, -1078 );
    var_6 = ( -11601, 9528, -1068 );
    thread alarm_enable( var_2, 0.25, "alarm_av_04_int_near_hangar", var_0, "alarm_av_04_int_far_hangar", var_1, "stop_post_courtyard_alarms" );
    thread alarm_enable( var_3, 0.25, "alarm_av_04_int_near_hangar", var_0, "alarm_av_04_int_far_hangar", var_1, "stop_post_courtyard_alarms" );
    thread alarm_enable( var_5, 0.15, "alarm_06_int_far_hangar", var_0, "alarm_06_int_far_hangar", var_1, "stop_post_courtyard_alarms" );
    thread alarm_enable( var_6, 0.25, "alarm_av_04_int_near_hangar", var_0, "alarm_av_04_int_far_hangar", var_1, "stop_post_courtyard_alarms" );
}

alarm_enable( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( level.aud.alarm_guid ) )
        level.aud.alarm_guid = 0;

    var_8 = "stop_" + var_2 + "_" + level.aud.alarm_guid;
    level.aud.alarm_guid++;
    thread alarm_start( var_0, var_1, var_2, var_3, var_4, var_5, var_8, var_7 );
    level waittill( var_6 );
    level notify( var_8 );
}

alarm_start( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    level endon( var_6 );
    var_8 = 0;
    var_9 = 1;
    var_7 = soundscripts\_audio::aud_get_optional_param( 0, var_7 );
    var_10 = spawnstruct();
    var_10.emitter_origin = var_0;
    var_10.volume = var_1;
    var_10.update_rate = 0.1;
    var_10.alarm_is_playing = 0;
    var_10.loop_fade_time = 1.0;
    var_10.stop_notify_string = var_6;
    var_10.loops = [ alarm_create_loops( var_2, var_3, var_10.loop_fade_time ), alarm_create_loops( var_4, var_5, var_10.loop_fade_time ) ];
    var_10 thread alarm_monitor_cleanup();
    var_11 = var_10.loops[0].env.size;
    var_12 = var_10.loops[0].env[var_11 - 1];
    var_13 = var_12[0];

    for (;;)
    {
        var_10.curr_dist = distance( level.player.origin, var_0 );

        if ( !var_10.alarm_is_playing && ( var_7 == var_8 || var_7 == var_9 && var_10.curr_dist <= var_13 ) )
            var_10 thread alarm_start_loops();
        else if ( var_10.alarm_is_playing && var_7 == var_9 && var_10.curr_dist > var_13 )
            var_10 thread alarm_stop_loops();
        else if ( var_10.curr_dist <= var_13 )
            var_10 alarm_update_loops();

        wait(var_10.update_rate);
    }
}

alarm_create_loops( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.alias = var_0;
    var_3.env = var_1;
    var_3.fade_time = var_2;
    return var_3;
}

alarm_start_loops()
{
    var_0 = self;
    var_1 = var_0.loops[0].env.size;
    var_2 = var_0.loops[0].env[var_1 - 1];
    var_3 = var_2[1];

    foreach ( var_5 in var_0.loops )
    {
        var_5.ent = spawn( "script_origin", var_0.emitter_origin );
        var_5.ent scalevolume( var_3, 0 );
        var_5.ent soundscripts\_snd_playsound::snd_play_loop( var_5.alias );
    }

    var_0.alarm_is_playing = 1;
}

alarm_stop_loops()
{
    var_0 = self;
    var_0.alarm_is_playing = 0;
    var_1 = [];

    foreach ( var_3 in var_0.loops )
    {
        var_4 = var_3.ent;
        var_3.ent = undefined;

        if ( isdefined( var_4 ) )
        {
            var_4 scalevolume( 0, var_0.loop_fade_time );
            var_1[var_1.size] = var_4;
        }
    }

    wait(var_0.loop_fade_time);

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4 ) )
        {
            var_4 soundscripts\_snd_playsound::snd_stop_sound();
            var_4 delete();
        }
    }
}

alarm_update_loops()
{
    var_0 = self;

    if ( var_0.alarm_is_playing )
    {
        foreach ( var_2 in var_0.loops )
        {
            if ( isdefined( var_2.ent ) )
            {
                var_3 = piecewiselinearlookup( var_0.curr_dist, var_2.env );
                var_2.ent scalevolume( var_3 * var_0.volume, var_0.update_rate );
            }
        }
    }
}

alarm_monitor_cleanup()
{
    var_0 = self;
    level waittill( var_0.stop_notify_string );
    var_0 alarm_stop_loops();
}

aud_tank_section_vehicles_spawned( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        var_4 = var_3.vehicletype;
        var_3 aud_tank_section_vehicles_handler( var_4, var_1 );
    }
}

aud_tank_section_vehicles_handler( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        switch ( var_0 )
        {
            case "ft101_tank_physics":
                thread aud_tank_death_listener();
                break;
            case "vrap_physics":
                thread aud_jeep_death_listener();
                break;
            default:
                break;
        }
    }

    if ( isdefined( var_1 ) )
    {
        switch ( var_1 )
        {
            case "flag_tank_road_littlebirds":
                if ( var_0 == "littlebird" )
                {
                    if ( !isdefined( level.aud.tank_road_littlebird ) )
                    {
                        var_2 = 1;
                        thread aud_tank_road_littlebird_1( var_2 );
                    }
                    else
                    {
                        var_2 = level.aud.tank_road_littlebird + 1;
                        thread aud_tank_road_littlebird_2( var_2 );
                    }

                    level.aud.tank_road_littlebird = var_2;
                }

                break;
            case "flag_tank_field_warbird_and_littlebird":
                if ( var_0 == "xh9_warbird" )
                    thread aud_tank_field_warbird();
                else if ( var_0 == "littlebird" )
                {
                    var_2 = 1;
                    thread aud_tank_field_littlebird( var_2 );
                }

                break;
            case "flag_hovertank_combat_clearing_choppers_1":
                if ( var_0 == "xh9_warbird" )
                    thread aud_combat_clearing_1_warbird();

                break;
            case "flag_hovertank_combat_clearing_choppers_2":
                if ( var_0 == "littlebird" )
                {
                    if ( !isdefined( level.aud.tank_clearing2_littlebird ) )
                    {
                        var_2 = 1;
                        thread aud_combat_clearing_2_littlebird_1( var_2 );
                    }
                    else
                    {
                        var_2 = level.aud.tank_clearing2_littlebird + 1;
                        thread aud_combat_clearing_2_littlebird_2( var_2 );
                    }

                    level.aud.tank_clearing2_littlebird = var_2;
                }

                break;
            case "flag_hovertank_combat_clearing_choppers_3":
                if ( var_0 == "littlebird" )
                {
                    if ( !isdefined( level.aud.tank_clearing3_littlebird ) )
                    {
                        var_2 = 1;
                        thread aud_combat_clearing_3_littlebird_1( var_2 );
                    }
                    else
                    {
                        var_2 = level.aud.tank_clearing3_littlebird + 1;
                        thread aud_combat_clearing_3_littlebird_2( var_2 );
                    }

                    level.aud.tank_clearing3_littlebird = var_2;
                }

                break;
            case "flag_hovertank_ascent_final_enemies":
                if ( var_0 == "xh9_warbird" )
                    thread aud_ascent_final_warbird();

                break;
            default:
                break;
        }
    }
}

aud_tank_death_listener()
{
    self waittill( "death" );
    var_0 = 0;

    if ( isdefined( self ) )
    {
        var_1 = distance2d( self.origin, level.player.origin );

        if ( var_1 < 720 )
        {
            soundscripts\_audio_mix_manager::mm_add_submix( "tank_vehicle_destruct" );
            var_0 = 1;
        }
    }

    wait 0.05;
    level.player soundscripts\_snd_playsound::snd_play( "enemy_tank_destroyed_impact" );

    if ( var_0 )
    {
        wait 0.35;
        soundscripts\_audio_mix_manager::mm_clear_submix( "tank_vehicle_destruct", 0.5 );
    }
}

aud_jeep_death_listener()
{
    self waittill( "death" );
    var_0 = 0;

    if ( isdefined( self ) )
    {
        if ( distance2d( self.origin, level.player.origin ) < 720 )
        {
            soundscripts\_audio_mix_manager::mm_add_submix( "jeep_vehicle_destruct" );
            var_0 = 1;
        }
    }

    wait 0.05;
    level.player soundscripts\_snd_playsound::snd_play( "enemy_jeep_destroyed_impact" );

    if ( var_0 )
    {
        wait 0.35;
        soundscripts\_audio_mix_manager::mm_clear_submix( "jeep_vehicle_destruct", 0.5 );
    }
}

wait_for_anim_start( var_0, var_1 )
{
    while ( var_1 getanimtime( var_0 ) == 0 )
        waitframe();
}

play_sound_stop_on_notify( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", var_1.origin );
    var_3 linkto( var_1 );
    var_3 soundscripts\_snd_playsound::snd_play( var_0, "sounddone" );
    common_scripts\utility::waittill_any_ents( var_3, "sounddone", level, var_2 );
    soundscripts\_audio::aud_fade_out_and_delete( var_3, 0.1 );
}
