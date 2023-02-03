// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    launch_threads();
    launch_loops();
    create_level_envelop_arrays();
    precache_presets();
    register_snd_messages();
}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_refugee_camp", ::start_refugee_camp );
    soundscripts\_snd::snd_register_message( "start_drive_in", ::start_drive_in );
    soundscripts\_snd::snd_register_message( "start_school", ::start_school );
    soundscripts\_snd::snd_register_message( "start_school_interior", ::start_school_interior );
    soundscripts\_snd::snd_register_message( "start_school_before_fall", ::start_school_before_fall );
    soundscripts\_snd::snd_register_message( "start_school_basement", ::start_school_basement );
    soundscripts\_snd::snd_register_message( "start_school_wall_grab", ::start_school_wall_grab );
    soundscripts\_snd::snd_register_message( "start_alleyway", ::start_alleyway );
    soundscripts\_snd::snd_register_message( "start_office", ::start_office );
    soundscripts\_snd::snd_register_message( "start_exopush", ::start_exopush );
    soundscripts\_snd::snd_register_message( "start_hospital", ::start_hospital );
    soundscripts\_snd::snd_register_message( "start_hospital_capture_animation", ::start_hospital_capture_animation );
    soundscripts\_snd::snd_register_message( "start_sentinel_reveal", ::start_sentinel_reveal );
    soundscripts\_snd::snd_register_message( "start_exit_drive", ::start_exit_drive );
    soundscripts\_snd::snd_register_message( "weather_report", ::weather_report );
    soundscripts\_snd::snd_register_message( "lightning_strike", ::lightning_strike );
    soundscripts\_snd::snd_register_message( "play_maglev_train_path", ::play_maglev_train_path );
    soundscripts\_snd::snd_register_message( "opening_start", ::opening_start );
    soundscripts\_snd::snd_register_message( "level_intro_cinematic", ::level_intro_cinematic );
    soundscripts\_snd::snd_register_message( "begin_refugee_walk", ::begin_refugee_walk );
    soundscripts\_snd::snd_register_message( "begin_intro_conversation", ::begin_intro_conversation );
    soundscripts\_snd::snd_register_message( "start_stage_dialog", ::start_stage_dialog );
    soundscripts\_snd::snd_register_message( "jetbike_intro", ::jetbike_intro );
    soundscripts\_snd::snd_register_message( "refugee_butress_down", ::refugee_butress_down );
    soundscripts\_snd::snd_register_message( "gate_lightning", ::gate_lightning );
    soundscripts\_snd::snd_register_message( "drive_in_done", ::drive_in_done );
    soundscripts\_snd::snd_register_message( "begin_on_foot_segment", ::begin_on_foot_segment );
    soundscripts\_snd::snd_register_message( "walk_to_school", ::walk_to_school );
    soundscripts\_snd::snd_register_message( "horror_fluorescent_break", ::horror_fluorescent_break );
    soundscripts\_snd::snd_register_message( "horror_burke_gets_up_after_tile", ::horror_burke_gets_up_after_tile );
    soundscripts\_snd::snd_register_message( "horror_burk_opens_bodies_room_door", ::horror_burk_opens_bodies_room_door );
    soundscripts\_snd::snd_register_message( "body_room_exit", ::body_room_exit );
    soundscripts\_snd::snd_register_message( "finish_bodies_room_burke", ::finish_bodies_room_burke );
    soundscripts\_snd::snd_register_message( "horror_ghost_runs_by_door", ::horror_ghost_runs_by_door );
    soundscripts\_snd::snd_register_message( "school_upthestairs", ::school_upthestairs );
    soundscripts\_snd::snd_register_message( "burke_startle_stairs", ::burke_startle_stairs );
    soundscripts\_snd::snd_register_message( "player_shimmy_intro", ::player_shimmy_intro );
    soundscripts\_snd::snd_register_message( "school_fall", ::school_fall );
    soundscripts\_snd::snd_register_message( "school_fall_into_basement", ::school_fall_into_basement );
    soundscripts\_snd::snd_register_message( "basement_investigate", ::basement_investigate );
    soundscripts\_snd::snd_register_message( "kva_basement_idle_start", ::kva_basement_idle_start );
    soundscripts\_snd::snd_register_message( "steam_burst_valve_started", ::steam_burst_valve_started );
    soundscripts\_snd::snd_register_message( "wall_pull_animation_begin", ::wall_pull_animation_begin );
    soundscripts\_snd::snd_register_message( "wall_pull_slowmo", ::wall_pull_slowmo );
    soundscripts\_snd::snd_register_message( "detroit_kva_bauerdoyoureadme", ::detroit_kva_bauerdoyoureadme );
    soundscripts\_snd::snd_register_message( "train_scare", ::train_scare );
    soundscripts\_snd::snd_register_message( "school_lightning_strike", ::school_lightning_strike );
    soundscripts\_snd::snd_register_message( "kva_knife_takedown_scene_begin", ::kva_knife_takedown_scene_begin );
    soundscripts\_snd::snd_register_message( "mus_alley_combat", ::mus_alley_combat );
    soundscripts\_snd::snd_register_message( "temp_dog_bark", ::temp_dog_bark );
    soundscripts\_snd::snd_register_message( "office_reunion_dialogue", ::office_reunion_dialogue );
    soundscripts\_snd::snd_register_message( "hospital_breach_gun_away", ::hospital_breach_gun_away );
    soundscripts\_snd::snd_register_message( "hostpital_breach_start", ::hostpital_breach_start );
    soundscripts\_snd::snd_register_message( "push_dude_into_shelves", ::push_dude_into_shelves );
    soundscripts\_snd::snd_register_message( "breach_bad_guy2_gets_shot", ::breach_bad_guy2_gets_shot );
    soundscripts\_snd::snd_register_message( "shoot_dude_through_window", ::shoot_dude_through_window );
    soundscripts\_snd::snd_register_message( "breach_slo_mo_exit", ::breach_slo_mo_exit );
    soundscripts\_snd::snd_register_message( "capture_doctor_scene_start", ::capture_doctor_scene_start );
    soundscripts\_snd::snd_register_message( "office_skylights_breakable", ::office_skylights_breakable );
    soundscripts\_snd::snd_register_message( "begin_exo_push", ::begin_exo_push );
    soundscripts\_snd::snd_register_message( "ambulance_push_attach", ::ambulance_push_attach );
    soundscripts\_snd::snd_register_message( "ambulance_push_active", ::ambulance_push_active );
    soundscripts\_snd::snd_register_message( "ambulance_push_step_away", ::ambulance_push_step_away );
    soundscripts\_snd::snd_register_message( "ambulance_push_idle", ::ambulance_push_idle );
    soundscripts\_snd::snd_register_message( "ambulance_push_sequence_end", ::ambulance_push_sequence_end );
    soundscripts\_snd::snd_register_message( "hospital_flashbang1", ::hospital_flashbang1 );
    soundscripts\_snd::snd_register_message( "hospital_flashbang2", ::hospital_flashbang2 );
    soundscripts\_snd::snd_register_message( "hospital_flashbang3", ::hospital_flashbang3 );
    soundscripts\_snd::snd_register_message( "det_hospital_gate_close", ::det_hospital_gate_close );
    soundscripts\_snd::snd_register_message( "det_start_doctor_breathing", ::det_start_doctor_breathing );
    soundscripts\_snd::snd_register_message( "reveal_scene_start", ::reveal_scene_start );
    soundscripts\_snd::snd_register_message( "reveal_explosion", ::reveal_explosion );
    soundscripts\_snd::snd_register_message( "sent_guy_1_decloak", ::sent_guy_1_decloak );
    soundscripts\_snd::snd_register_message( "sent_guy_2_decloak", ::sent_guy_2_decloak );
    soundscripts\_snd::snd_register_message( "sent_guy_3_decloak", ::sent_guy_3_decloak );
    soundscripts\_snd::snd_register_message( "det_knx_thatsclassifiedmate", ::det_knx_thatsclassifiedmate );
    soundscripts\_snd::snd_register_message( "sentinel_reveal_final_vo", ::sentinel_reveal_final_vo );
    soundscripts\_snd::snd_register_message( "aud_impact_system_jetbike", ::aud_impact_system_jetbike );
    soundscripts\_snd::snd_register_message( "exit_ride_jetbike_mount_player", ::exit_ride_jetbike_mount_player );
    soundscripts\_snd::snd_register_message( "gaz_store_shootout_drive", ::gaz_store_shootout_drive );
    soundscripts\_snd::snd_register_message( "warehouse_chase_vehicle_02", ::warehouse_chase_vehicle_02 );
    soundscripts\_snd::snd_register_message( "warehouse_chase_vehicle_03", ::warehouse_chase_vehicle_03 );
    soundscripts\_snd::snd_register_message( "warehouse_chase_vehicle_04", ::warehouse_chase_vehicle_04 );
    soundscripts\_snd::snd_register_message( "warehouse_car_shots", ::warehouse_car_shots );
    soundscripts\_snd::snd_register_message( "gaz_water_crash_01", ::gaz_water_crash_01 );
    soundscripts\_snd::snd_register_message( "gaz_water_crash_02", ::gaz_water_crash_02 );
    soundscripts\_snd::snd_register_message( "exit_drive_rpgs", ::exit_drive_rpgs );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_initial", ::exitdrive_chopper_initial );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_initial_gopath", ::exitdrive_chopper_initial_gopath );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_tracks_1", ::exitdrive_chopper_tracks_1 );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_tracks_1_gopath", ::exitdrive_chopper_tracks_1_gopath );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_final", ::exitdrive_chopper_final );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_final_gopath", ::exitdrive_chopper_final_gopath );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_missile", ::collapsing_buttress_missile );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_01", ::collapsing_buttress_01 );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_02", ::collapsing_buttress_02 );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_03", ::collapsing_buttress_03 );
    soundscripts\_snd::snd_register_message( "exit_train_by", ::exit_train_by );
    soundscripts\_snd::snd_register_message( "exit_drive_ending_begin", ::exit_drive_ending_begin );
    soundscripts\_snd::snd_register_message( "gaz_water_crashed", ::gaz_water_crashed );
    soundscripts\_snd::snd_register_message( "exit_drive_rpgs", ::exit_drive_rpgs );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_initial", ::exitdrive_chopper_initial );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_initial_gopath", ::exitdrive_chopper_initial_gopath );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_tracks_1", ::exitdrive_chopper_tracks_1 );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_tracks_1_gopath", ::exitdrive_chopper_tracks_1_gopath );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_final", ::exitdrive_chopper_final );
    soundscripts\_snd::snd_register_message( "exitdrive_chopper_final_gopath", ::exitdrive_chopper_final_gopath );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_missile", ::collapsing_buttress_missile );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_01", ::collapsing_buttress_01 );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_02", ::collapsing_buttress_02 );
    soundscripts\_snd::snd_register_message( "collapsing_buttress_03", ::collapsing_buttress_03 );
    soundscripts\_snd::snd_register_message( "exit_train_by", ::exit_train_by );
    soundscripts\_snd::snd_register_message( "exit_drive_ending_begin", ::exit_drive_ending_begin );
    soundscripts\_snd::snd_register_message( "chopper_final_explo", ::chopper_final_explo );
    soundscripts\_snd::snd_register_message( "det_gl_end_logo", ::det_gl_end_logo );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_out", ::e3_demo_fade_out );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_in", ::e3_demo_fade_in );
    soundscripts\_snd::snd_register_message( "e3_demo_clear_basement_footsteps", ::e3_demo_clear_basement_footsteps );
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_snd_timescale::snd_set_timescale( "detroit_default" );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_global" );
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "aud_parking_garage_enter" );
    common_scripts\utility::flag_init( "aud_parking_garage_exit" );
    common_scripts\utility::flag_init( "aud_school_entrance" );
    common_scripts\utility::flag_init( "aud_school_bsmnt_stairs_start" );
    common_scripts\utility::flag_init( "aud_school_bsmnt_stairs_end" );
    common_scripts\utility::flag_init( "aud_school_exit" );
    common_scripts\utility::flag_init( "aud_courtyard_flood_start" );
    common_scripts\utility::flag_init( "aud_courtyard_flood_end" );
    common_scripts\utility::flag_init( "aud_horror_fluorescent_break" );
    common_scripts\utility::flag_init( "aud_wallpull_begin" );
    common_scripts\utility::flag_init( "aud_wallpull_success" );
    common_scripts\utility::flag_init( "aud_maglev_train_path_disabled" );
}

aud_flag_handler()
{
    common_scripts\utility::flag_wait( "aud_parking_garage_enter" );
    common_scripts\utility::flag_wait( "aud_parking_garage_exit" );
    common_scripts\utility::flag_wait( "aud_school_entrance" );
    common_scripts\utility::flag_wait( "aud_school_bsmnt_stairs_start" );
    common_scripts\utility::flag_wait( "aud_school_bsmnt_stairs_end" );
    common_scripts\utility::flag_wait( "aud_school_exit" );
    common_scripts\utility::flag_wait( "aud_courtyard_flood_start" );
    common_scripts\utility::flag_wait( "aud_courtyard_flood_end" );
}

init_globals()
{
    level.aud.ams_enabled = 0;
    level.aud.amb_pushing = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread setup_gideon_intro_foley();
    thread setup_det_intro_catch_anims();
    thread setup_hoverbike_meet_up_notetracks();
    thread player_fall_zone_swap();
    thread aud_flag_handler();
    thread start_point_source_dambs();
    thread setup_decon_gate_anims();
    thread setup_entrance_gate_anims();
    thread setup_jetbike_motorpool_anims();
    thread setup_jetbike_checkpoint_anims();
    thread jetbikes_arrive_at_school();
    thread aud_det_foley_override_handler();
    thread setup_school_shimmy_anims();
    thread setup_wall_pull_anims();
    thread setup_fence_climb_anims();
    thread setup_hospital_post_breach_anims();
    thread setup_sentinel_reveal_anims();
    thread setup_exit_ride_anims();
    thread setup_ending_anims();
    thread setup_chopper_crash_anims();
    thread setup_end_gate();
}

player_fall_zone_swap()
{
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
    wait 0.5;
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_school_floor_1", 1.0 );
}

launch_loops()
{
    thread launch_intro_loops();
    thread launch_intro_ride_loops();
    thread launch_school_street_loops();
    thread launch_school_interior_loops();
    thread launch_office_loops();
}

launch_intro_loops()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "intro" ) )
    {
        level waittill( "detroit_intro_tr" );
        wait 0.05;
    }

    common_scripts\utility::loop_fx_sound( "det_walla_start", ( -14077, 11309, -4 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "det_walla_fence_left", ( -13471, 10711, -4 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "det_walla_fence_right", ( -14137, 9868, -4 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "det_walla_food_truck", ( -13571, 9159, -4 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "det_walla_stage", ( -12791, 9098, -32 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -14268, 9863, 78 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -14068, 9219, 482 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_ext_wind_lrg", ( -13840, 11244, 23 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_ext_wind_lrg", ( -13796, 10474, 17 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "emt_ext_wind_lrg", ( -13714, 9965, 0 ), 1, "aud_stop_intro" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_intro_to_middle" );
        level notify( "aud_stop_intro" );
    }
}

launch_intro_ride_loops()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_gate" ) )
    {
        level waittill( "tff_post_gatetrans_entry" );
        wait 0.05;
    }

    common_scripts\utility::loop_fx_sound( "emt_ext_wind_lrg", ( -7742, 6106, 40 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_01", ( -7906, 8496, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_02", ( -7830, 8072, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_02", ( -5842, 9796, -81 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_high_01", ( -7602, 9383, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_high_02", ( -7587, 10017, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_low_02", ( -7332, 9844, -39 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_01", ( -7602, 9383, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_02", ( -7332, 9844, -39 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_01", ( -4416, 9518, -71 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_01", ( -7315, 9618, -100 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_high_02", ( -5164, 9688, -81 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_02", ( -4815, 9834, -81 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_med_02", ( -7248, 8942, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_high_01", ( -7121, 9380, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_low_03", ( -7124, 9052, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_03", ( -6992, 8929, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_water_high_02", ( -6437, 9417, -104 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_03", ( -5885, 9338, -59 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_01", ( -6992, 8929, -68 ), 1, "aud_stop_intro_ride" );
    common_scripts\utility::loop_fx_sound( "emt_rain_into_pool_drippy_lp_02", ( -7121, 9380, -68 ), 1, "aud_stop_intro_ride" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_remove_gatetrans" );
        level notify( "aud_stop_intro_ride" );
    }
}

launch_school_street_loops()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
    {
        level waittill( "tff_post_intro_to_middle" );
        wait 0.05;
    }

    common_scripts\utility::loop_fx_sound( "emt_ext_eerie_parking_garage_wind", ( -4737, 8822, -232 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_eerie_parking_garage_wind", ( -4225, 7158, -289 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_eerie_parking_garage_wind", ( -3570, 7163, -93 ), 1 );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -5239, 8796, -248 ), "snd_water_garage_clear", 2.0, 2.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -3153, 7729, -249 ), "snd_water_garage_clear", 2.0, 2.0 );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -4189, 7022, -199 ), "snd_water_garage_clear", 2.0, 2.0 );
    common_scripts\utility::loop_fx_sound( "emt_rain_on_tarp_01", ( -2596, 9175, -68 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_rain_on_tarp_01", ( -2670, 9249, -89 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_rain_on_tarp_01", ( -2569, 9314, -89 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_rain_on_mailbox_01", ( -2733, 9206, -89 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_rain_on_tarp_02", ( -2432, 9184, -37 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_med_01", ( -3193, 7032, -117 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_low_02", ( -3036, 7551, -117 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_high_03", ( -2541, 7071, -127 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_water_on_concrete_low_03", ( -2409, 7380, -114 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2638, 7461, -86 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2638, 7683, -86 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2638, 7787, -86 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2640, 7987, -86 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2632, 8233, -99 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2631, 8311, -99 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_ext_tarp_rustle", ( -2601, 8744, -88 ), 1 );
}

launch_school_interior_loops()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_school" ) )
    {
        level waittill( "tff_post_middle_add_school" );
        wait 0.05;
    }

    common_scripts\utility::loop_fx_sound( "emt_ext_eerie_whistling_wind1", ( -2287, 8995, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_eerie_howling_wind1", ( -2029, 9704, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_rain_thru_roof_to_puddle", ( -1399, 9399, -28 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_eerie_howling_wind2", ( -1520, 9370, 277 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_eerie_howling_wind1", ( -2029, 9704, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_tarp_sml", ( -1455, 9403, 4 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "corpse_room_flies", ( -1038, 9602, 9 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "corpse_room_flies", ( -844, 9741, 9 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -686, 9804, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -686, 9804, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_01", ( -1215, 9382, -187 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_01", ( -1026, 9359, -187 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_02", ( -802, 9435, -187 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_01", ( -958, 9141, -187 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_02", ( -1076, 9252, -187 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_01", ( -878, 9066, -158 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_bsmnt_drips_pool_lp_02", ( -1032, 9061, -158 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "corpse_room_flies", ( -1049, 9709, -10 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "corpse_room_flies", ( -799, 9432, -138 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "corpse_room_flies", ( -802, 9463, -145 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -764, 9984, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -764, 9984, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -970, 9965, 172 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -970, 9965, 172 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -1420, 9885, 157 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -2340, 9474, 166 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -2340, 9474, 166 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_low", ( -764, 9807, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -764, 9807, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_horror_wind_high", ( -970, 9965, 172 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -603, 9660, 146 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -2253, 9473, 165 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -2253, 9277, 165 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -2295, 9105, 189 ), 1, "aud_stop_school_interior" );
    common_scripts\utility::loop_fx_sound( "emt_int_exp_rain", ( -2295, 8864, 189 ), 1, "aud_stop_school_interior" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_remove_school" );
        level notify( "aud_stop_school_interior" );
    }
}

launch_office_loops()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_nightclub" ) )
    {
        level waittill( "tff_post_middle_add_nightclub" );
        wait 0.05;
    }

    common_scripts\utility::loop_fx_sound( "office_skylight_rain_lp", ( -1171, 4342, -79 ), 1, "aud_stop_office" );
    common_scripts\utility::loop_fx_sound( "emt_rain_thru_roof_to_puddle", ( -1171, 4342, -79 ), 1, "aud_stop_office" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_remove_nightclub" );
        level notify( "aud_stop_office" );
    }
}

start_point_source_dambs()
{
    thread launch_intro_point_source_dambs();
    thread launch_school_street_point_source_dambs();
    thread launch_school_interior_point_source_dambs();
}

launch_intro_point_source_dambs()
{

}

launch_school_street_point_source_dambs()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
    {
        level waittill( "tff_post_intro_to_middle" );
        wait 0.05;
    }

    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2607, 8227, -89 ), "outside_school1" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2601, 8346, -89 ), "outside_school2" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2601, 8443, -89 ), "outside_school3" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2601, 8745, -88 ), "outside_school4" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2564, 8853, -85 ), "outside_school5" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2655, 7487, -97 ), "outside_school1" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2655, 7646, -97 ), "outside_school2" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2656, 7830, -95 ), "outside_school3" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2655, 7967, -91 ), "outside_school4" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2538, 8092, -89 ), "outside_school5" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_chain_link_fence_tarps", ( -2378, 8092, -89 ), "outside_school6" );
}

launch_school_interior_point_source_dambs()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_school" ) )
    {
        level waittill( "tff_post_middle_add_school" );
        wait 0.05;
    }

    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "det_int_wisp_gusts", ( -686, 9804, -10 ), "bodies" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_wind_gusts", ( -603, 9660, 146 ), "window_01" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "det_int_wisp_gusts", ( -764, 9807, 146 ), "window_02" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_wind_gusts", ( -970, 9965, 172 ), "window_03" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "det_int_wisp_gusts", ( -2340, 9474, 166 ), "train_01" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "det_int_wisp_gusts", ( -2304, 9273, 166 ), "train_02" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "dtrt_school_wind_gusts", ( -2336, 8936, 189 ), "train_03_sml" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "det_int_wisp_gusts", ( -852, 9335, -10 ), "before_staircase" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_det_bsmnt", ( -1215, 9382, -187 ), "drips_01" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_det_bsmnt", ( -1026, 9359, -187 ), "drips_02" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_det_bsmnt", ( -802, 9435, -187 ), "drips_03" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_det_bsmnt", ( -958, 9141, -187 ), "drips_04" );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "damb_det_bsmnt", ( -1076, 9252, -187 ), "drips_05" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_middle_remove_school" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "det_int_wisp_gusts", "bodies" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "dtrt_school_wind_gusts", "window_01" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "det_int_wisp_gusts", "window_02" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "dtrt_school_wind_gusts", "window_03" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "det_int_wisp_gusts", "train_01" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "det_int_wisp_gusts", "train_02" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "dtrt_school_wind_gusts", "train_03_sml" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "det_int_wisp_gusts", "before_staircase" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "damb_det_bsmnt", "drips_01" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "damb_det_bsmnt", "drips_02" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "damb_det_bsmnt", "drips_03" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "damb_det_bsmnt", "drips_04" );
        soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point( "damb_det_bsmnt", "drips_05" );
    }
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
    level.aud.envs["gaz_strafe_whizybys"] = [ [ 0, 0.0 ], [ 1, 1.0 ] ];
}

precache_presets()
{

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
        case "exit_dtrt_ext_deserted_street_school":
            if ( var_3 == "dtrt_ext_deserted_street_school" )
                level notify( "snd_water_garage_clear" );

            break;
        case "enter_dtrt_ext_deserted_street_school":
            if ( var_2 == "dtrt_ext_deserted_street_school" )
            {
                soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -5239, 8796, -248 ), "snd_water_garage_clear", 2.0, 2.0 );
                soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -3153, 7729, -249 ), "snd_water_garage_clear", 2.0, 2.0 );
                soundscripts\_snd_playsound::snd_play_loop_at( "emt_water_garage", ( -4189, 7022, -199 ), "snd_water_garage_clear", 2.0, 2.0 );
            }

            break;
        case "enter_dtrt_int_school_floor_1":
            if ( var_2 == "dtrt_ext_deserted_street_school" )
            {
                music( "entering_school_from_deserted_street" );
                var_4 = ( -1793, 9421, 22 );
                thread start_fuorescent_light_hum( var_4 );
                thread monitor_fuorescent_light_dist( var_4 );
                soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
                level.aud.in_school = 1;
            }

            break;
        case "exit_dtrt_int_school_floor_1":
            if ( var_3 == "dtrt_int_school_floor_1" )
            {
                level notify( "kill_temp_outside_school_wind_loop" );
                soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
            }

            if ( var_3 == "dtrt_ext_deserted_street_school" )
            {
                level.aud.in_school = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "det_school_fs_override" );
            }

            break;
        case "exit_dtrt_int_school_floor_1_bodies_room":
            if ( var_3 == "dtrt_int_school_floor_1_bodies_room" )
                music( "school_floor_1_bodies_room" );

            break;
        case "exit_dtrt_int_school_exit_room":
            if ( var_3 == "dtrt_int_school_exit_room" )
                music( "school" );

            break;
        case "enter_dtrt_int_school_basement_stairs":
            if ( var_2 == "dtrt_int_school_basement" )
            {
                level.aud.in_school = 1;
                level.aud.in_basement = 0;
                music( "exit_basement" );
            }

            break;
        case "exit_dtrt_int_school_basement_stairs":
            if ( var_3 == "dtrt_int_school_basement" )
            {
                level.aud.in_school = 0;
                level.aud.in_basement = 1;
            }

            break;
        case "enter_dtrt_ext_streets_alleyway":
            if ( var_2 == "dtrt_int_school_exit_room" )
            {
                level.aud.in_school = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "det_school_fs_override" );
            }

            break;
        case "exit_dtrt_ext_streets_alleyway":
            if ( var_3 == "dtrt_int_school_exit_room" )
            {
                level.aud.in_school = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
            }

            break;
        case "enter_dtrt_int_abandoned_bank":
            if ( var_2 == "dtrt_ext_streets_alleyway" )
            {
                soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_down" );
                soundscripts\_audio_mix_manager::mm_add_submix( "alley_combat_trains_off" );
            }
            else if ( var_2 == "dtrt_int_abandoned_bank" )
            {
                soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_off" );
                soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_down" );
            }

            break;
        case "enter_dtrt_ext_train_tracks":
            if ( var_2 == "dtrt_int_hospital_exit_stairwell" )
            {
                soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_down" );
                soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_off" );
                return;
            }
    }
}

music( var_0, var_1 )
{
    thread music_handler( var_0, var_1 );
}

music_handler( var_0, var_1 )
{
    level notify( "stop_current_music_thread" );
    level endon( "stop_current_music_thread" );
    var_2 = 0.7;
    var_3 = 0.2;
    var_4 = 0.5;

    switch ( var_0 )
    {
        case "start_refugee_camp":
            music( "refugee_camp" );
            break;
        case "start_drive_in":
            music( "refugee_camp" );
            break;
        case "start_school":
            music( "off", var_1 );
            break;
        case "start_school_interior":
            music( "off", var_1 );
            break;
        case "start_school_before_fall":
            music( "off", var_1 );
            break;
        case "start_school_basement":
            music( "off", var_1 );
            break;
        case "start_school_wall_grab":
            music( "school_floor_1_bodies_room" );
            break;
        case "start_alleyway":
            music( "mus_pre_alley_combat" );
            break;
        case "start_office":
            music( "mus_alley_combat" );
            break;
        case "start_exopush":
            music( "off" );
            break;
        case "start_hospital":
            music( "off" );
            break;
        case "start_hospital_capture_animation":
            music( "off" );
            break;
        case "start_sentinel_reveal":
            music( "off" );
            break;
        case "start_exit_drive":
            music( "mus_pre_exit_drive" );
            break;
        case "off":
            soundscripts\_audio_music::mus_stop( var_1 );
            break;
        case "refugee_camp":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            wait 10;
            soundscripts\_audio_music::mus_play( "det_mus_refugee_camp", 0.5 );
            break;
        case "begin_intro_conversation":
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.45, 1 );
            break;
        case "end_intro_conversation":
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.8, 3 );
            break;
        case "end_refugee_camp_civ_convo_01":
            soundscripts\_audio_music::mus_stop( 45 );
            break;
        case "jetbike_intro":
            mus_auto_submixer( "off", 1, 3 );
            soundscripts\_audio_music::mus_stop( 3 );
            break;
        case "drive_in_done":
            mus_auto_submixer( "off", 1, 3 );
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "begin_on_foot_segment":
            mus_auto_submixer( "off", 1, 3 );
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "walk_to_school":
            wait 3;
            soundscripts\_audio::aud_set_music_submix( 1, 1.0 );
            soundscripts\_audio_music::mus_play( "det_mus_walk_to_the_school", 8 );
            break;
        case "entering_school_from_deserted_street":
            break;
        case "horror_burke_gets_up_after_tile":
            mus_auto_submixer( "off", 0.25, 9 );
            soundscripts\_audio_music::mus_play( "det_mus_horror_lp_01", 14 );
            break;
        case "horror_burk_door_open_end":
            soundscripts\_audio::aud_set_music_submix( 0.25, 0 );
            soundscripts\_audio_music::mus_play( "det_mus_horror_lp_02_end", 0, 3 );
            break;
        case "school_floor_1_bodies_room":
            mus_auto_submixer( "off", var_3 * 2.0, 3 );
            wait 0.5;
            soundscripts\_audio_music::mus_play( "det_mus_school" );
            wait 10;
            soundscripts\_audio::aud_set_music_submix( var_3, 15 );
            break;
        case "finish_bodies_room_burke":
            soundscripts\_audio::aud_set_music_submix( var_3 / 2, 5 );
            break;
        case "body_room_exit":
            soundscripts\_audio_music::mus_stop( 4 );
            soundscripts\_audio::aud_set_music_submix( var_3, 4 );
            break;
        case "school_upthestairs":
            soundscripts\_audio::aud_set_music_submix( var_3, 1 );
            soundscripts\_audio_music::mus_play( "det_mus_low_tension1", 5 );
            break;
        case "horror_ghost_runs_by_door":
            break;
        case "burke_beam_bend":
            soundscripts\_audio_music::mus_stop( 8 );
            break;
        case "school_fall_into_basement":
            soundscripts\_audio_music::mus_stop( 1 );
            break;
        case "exit_basement":
            mus_auto_submixer( "off", var_3, 0 );
            soundscripts\_audio_music::mus_play( "det_mus_low_tension3", 5 );
            break;
        case "wallpull":
            mus_auto_submixer( "off", 1.0, 0 );
            soundscripts\_audio_music::mus_play( "det_mus_wallpull", 0, 0 );
            wait 1;
            soundscripts\_audio::aud_set_music_submix( 0.5, 3 );
            break;
        case "mus_pre_alley_combat":
            mus_auto_submixer( "off", 0.5, 10 );
            soundscripts\_audio_music::mus_play( "det_mus_am_battlecry_perc1c", 10, 3 );
            break;
        case "mus_alley_combat":
            wait 1;
            mus_auto_submixer( "on", 1.0, 0, "npc_count" );
            soundscripts\_audio_music::mus_play( "det_mus_am_battlecry_lp", 0, 1 );
            break;
        case "office_reunion_dialogue":
            soundscripts\_audio_music::mus_play( "det_mus_am_battlecry_end", 0, 1 );
            wait 10;
            mus_auto_submixer( "off", 1, 10 );
            break;
        case "mus_pre_van_push":
            mus_auto_submixer( "off", 0.6, 0 );
            soundscripts\_audio_music::mus_play( "det_mus_am_battlecry_end", 0, 1 );
            break;
        case "mus_sounddone_det_gdn_mitchellonme":
            soundscripts\_audio::aud_set_music_submix( 0.25, 0 );
            wait 0.25;
            soundscripts\_audio_music::mus_play( "det_mus_high_tension1", 0 );
            break;
        case "det_sent_rev_explo":
            soundscripts\_audio_music::mus_stop( 0.1 );
            break;
        case "mus_pre_exit_drive":
            mus_auto_submixer( "off", 0.7, 0 );
            soundscripts\_audio_music::mus_play( "det_mus_high_tension1", 12 );
            break;
        case "mus_exit_drive":
            wait 1;
            mus_auto_submixer( "off", 1.3, 1 );
            soundscripts\_audio_music::mus_play( "det_mus_exit_drive", 1.0, 3 );
            break;
        case "mus_end_exit_drive":
            soundscripts\_audio_music::mus_stop( 3 );
            break;
        case "mus_det_ending_win":
            soundscripts\_audio::aud_set_music_submix( 0.6, 0.05 );
            wait 0.05;
            soundscripts\_audio_music::mus_play( "det_mus_ending_win" );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

mus_auto_submixer( var_0, var_1, var_2, var_3 )
{
    thread mus_auto_submixer_thread( var_0, var_1, var_2, var_3 );
}

mus_auto_submixer_thread( var_0, var_1, var_2, var_3 )
{
    level notify( "kill_mus_auto_submixer" );
    level endon( "kill_mus_auto_submixer" );
    var_0 = soundscripts\_audio::aud_get_optional_param( "on", var_0 );
    var_1 = soundscripts\_audio::aud_get_optional_param( 1.0, var_1 );
    var_2 = soundscripts\_audio::aud_get_optional_param( 1.0, var_2 );
    var_3 = soundscripts\_audio::aud_get_optional_param( "plr_speed", var_3 );

    if ( var_0 == "off" )
        soundscripts\_audio::aud_set_music_submix( var_1, var_2 );
    else
    {
        var_4 = 0.25;

        if ( var_3 == "plr_speed" )
        {
            var_5 = [ [ 0, 0.0 ], [ 10, 1.0 ] ];
            var_6 = 0.15;
            var_7 = 0.02;
            var_8 = 10;
            var_9 = 17.6;

            for (;;)
            {
                var_10 = length( level.player getvelocity() ) / var_9;

                if ( getdvarint( "print_player_speed" ) )
                    iprintln( var_10 );

                if ( var_10 > var_8 )
                    var_11 = var_6;
                else
                    var_11 = var_7;

                var_8 += var_11 * ( var_10 - var_8 );
                var_12 = piecewiselinearlookup( var_8, var_5 );
                var_12 *= var_1;
                soundscripts\_audio::aud_set_music_submix( var_12, var_4 );
                wait(var_4);
            }

            return;
        }

        if ( var_3 == "npc_count" )
        {
            var_13 = [ [ 0, 0.4 ], [ 10, 1.0 ] ];
            var_6 = 0.3;
            var_7 = 0.3;
            var_14 = 0;

            for (;;)
            {
                var_15 = 0;
                var_16 = getaiarray( "bad_guys" );

                foreach ( var_18 in var_16 )
                {
                    if ( isdefined( var_18.alertlevelint ) && var_18.alertlevelint >= 3 )
                        var_15++;
                }

                if ( getdvarint( "snd_det_print_npc_count" ) )
                    iprintln( var_15 );

                if ( var_15 > var_14 )
                    var_11 = var_6;
                else
                    var_11 = var_7;

                var_14 += var_11 * ( var_15 - var_14 );
                var_12 = piecewiselinearlookup( var_14, var_13 );
                var_12 *= var_1;
                soundscripts\_audio::aud_set_music_submix( var_12, var_4 );
                wait(var_4);
            }
        }
    }
}

auto_combat_music( var_0 )
{
    level endon( "stop_current_music_thread" );
    var_1 = 0.25;
    var_2 = 0;
    var_0 = soundscripts\_audio::aud_get_optional_param( 1, var_0 );
    mus_auto_submixer( "off", var_0, 1 );

    for (;;)
    {
        var_3 = mus_get_combat_count();

        if ( var_3 != var_2 )
        {
            var_2 = var_3;

            if ( var_3 > 0 )
            {
                soundscripts\_audio::aud_set_music_submix( var_0, 1 );
                soundscripts\_audio_music::mus_play( "det_mus_generic_combat", 1, 3 );
            }
            else
            {
                soundscripts\_audio::aud_set_music_submix( var_0 * 0.66, 10 );
                soundscripts\_audio_music::mus_play( "det_mus_high_tension1", 10, 10 );
            }
        }

        wait(var_1);
    }
}

mus_get_combat_count()
{
    var_0 = 0;
    var_1 = 0;
    var_2 = getaiarray( "bad_guys" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.alertlevelint ) && var_4.alertlevelint >= 3 )
            var_1++;
    }

    return var_1;
}

start_refugee_camp( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_refugee_camp", 0.5 );
    music( "start_refugee_camp" );
}

start_drive_in( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_refugee_camp", 0.5 );
    music( "start_drive_in" );
}

start_school( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_parking_garage", 0.5 );
    music( "start_school" );
}

start_school_interior( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_deserted_street_school", 0.5 );
    music( "start_school_interior" );
}

start_school_before_fall( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_school_floor_3", 0.5 );
    music( "start_school_before_fall" );
    level.aud.in_school = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
}

start_school_basement( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_school_basement", 0.5 );
    music( "start_school_basement" );
    level.aud.in_school = 0;
    level.aud.in_basement = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
}

start_school_wall_grab( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_school_floor_2", 0.5 );
    music( "start_school_wall_grab" );
    level.aud.in_school = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override" );
    maps\_utility::delaythread( 1, ::setup_wallpull );
}

start_alleyway( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_school_exit_room", 0.5 );
    music( "start_alleyway" );
    level.aud.in_school = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "dtrt_school_fs_override" );
}

start_office( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_abandoned_bank", 0.5 );
    music( "start_office" );
}

start_exopush( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_streets_clean", 0.5 );
    music( "start_exopush" );
}

start_hospital( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_streets_clean", 0.5 );
    music( "start_hospital" );
}

start_hospital_capture_animation( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_hospital_office_hallway", 0.5 );
    music( "start_hospital_capture_animation" );
}

start_sentinel_reveal( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_ext_train_tracks", 0.5 );
    music( "start_sentinel_reveal" );
}

start_exit_drive( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "dtrt_int_sent_stairs", 0.5 );
    music( "start_exit_drive" );
}

opening_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_opening_warbird", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_door_mech_a", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_door_mech_b", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_door_decompress", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_door_wind", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_warbird_blades", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_warbird_engine", 3.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_warbird_chop", 6.15 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_intro_warbird_flyaway", 9.0 );
    wait 4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_opening_warbird" );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_opening_pcap_scene" );
    wait 14;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_opening_pcap_scene", 5 );
}

level_intro_cinematic( var_0 )
{

}

begin_refugee_walk( var_0 )
{

}

begin_intro_conversation()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "intro_conversation" );
    music( "begin_intro_conversation" );
    level waittill( "end_intro_conversation" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "intro_conversation" );
    music( "end_intro_conversation" );
}

start_stage_dialog()
{
    var_0 = [ "detroit_atr_youllbewontbeable", "detroit_atr_onceyourdnaisin", "detroit_atr_ifyouhaveaquestion", "detroit_atr_remembernothinghappensunlessyou", "detroit_atr_weappreciateyourpatience", "detroit_atr_sectorsathroughfwill", "detroit_atr_werereopeningthesectorc", "detroit_atr_iknowyouallhave", "detroit_atr_werelookingatarolling" ];
    var_1 = [ 14.07, 12.19, 3.18, 10.25, 4.21, 7.27, 3.29, 6.09, 2.2 ];
    var_2 = ( -12584, 9182, 48 );
    common_scripts\utility::flag_set( "flag_stage_dialogue_start_audio" );

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = var_0[var_3] + "_near";
        var_5 = soundscripts\_snd_playsound::snd_play_at( var_4, var_2 );
        var_4 = var_0[var_3] + "_far";
        var_6 = soundscripts\_snd_playsound::snd_play_delayed_2d( var_4, 0.2, undefined, undefined, undefined, undefined, 0.45 );
        var_6 thread monitor_pa_dist( var_2 );
        wait(var_1[var_3]);
        wait 1;
    }

    common_scripts\utility::flag_set( "flag_stage_dialogue_end_audio" );
}

monitor_pa_dist( var_0 )
{
    self endon( "death" );
    self endon( "sounddone" );
    var_1 = [ [ 360, 0.0 ], [ 3600, 1.0 ] ];

    for (;;)
    {
        var_2 = distance2d( var_0, level.player.origin );
        var_3 = soundscripts\_snd::snd_map( var_2, var_1 );
        self scalevolume( var_3 );
        wait 0.2;
    }
}

setup_decon_gate_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "intro" ) )
        level waittill( "detroit_intro_tr" );

    maps\_anim::addnotetrack_customfunction( "decon_gate", "front_door_close", ::scanner_front_door_close, "decon_scanner_front" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "rear_door_close", ::scanner_rear_door_close, "decon_scanner_back" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "scanner_forward", ::scanner_forward, "decon_scanner_back" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "scanner_back", ::scanner_return, "decon_scanner_back" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "front_door_open", ::scanner_front_door_open, "decon_scanner_back" );
    maps\_anim::addnotetrack_customfunction( "bones", "bones_high_five", ::bones_high_five, "gate_decon_b" );
}

scanner_front_door_close( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_decon_scanner" );
    soundscripts\_audio_zone_manager::azm_set_reverb_enable( 0 );
    soundscripts\_audio_reverb::rvb_start_preset( "det_decon_scanner_open", 0.5 );
    soundscripts\_snd_playsound::snd_play_at( "decon_scanner_front_door_cl", ( -12341, 7197, -34 ) );
}

scanner_rear_door_close( var_0 )
{
    soundscripts\_audio_reverb::rvb_start_preset( "det_decon_scanner_closed", 0.5 );
    soundscripts\_snd_playsound::snd_play_at( "decon_scanner_back_door_cl", ( -12354, 7460, -34 ) );
}

scanner_forward( var_0 )
{
    thread scanner_beam();
    var_1 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_front_left", ( -12301, 7215, -34 ) );
    var_2 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_front_right", ( -12403, 7214, -34 ) );
    var_3 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_rear_left", ( -12302, 7445, -34 ) );
    var_4 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_rear_right", ( -12405, 7452, -34 ) );
    var_1 moveto( ( -12301, 7308, -34 ), 3, 0.5, 0.5 );
    var_2 moveto( ( -12403, 7302, -34 ), 3, 0.5, 0.5 );
    var_3 moveto( ( -12302, 7353, -34 ), 3, 0.5, 0.5 );
    var_4 moveto( ( -12403, 7356, -34 ), 3, 0.5, 0.5 );
}

scanner_return( var_0 )
{
    var_1 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_front_left_return", ( -12301, 7308, -34 ) );
    var_2 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_front_right_return", ( -12403, 7302, -34 ) );
    var_3 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_rear_left_return", ( -12302, 7353, -34 ) );
    var_4 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_device_rear_right_return", ( -12403, 7356, -34 ) );
    var_1 moveto( ( -12301, 7215, -34 ), 3, 0.5, 0.5 );
    var_2 moveto( ( -12403, 7214, -34 ), 3, 0.5, 0.5 );
    var_3 moveto( ( -12302, 7445, -34 ), 3, 0.5, 0.5 );
    var_4 moveto( ( -12405, 7452, -34 ), 3, 0.5, 0.5 );
}

scanner_beam()
{
    var_0 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_beam", ( -12354, 7213, -34 ) );
    var_1 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_beam", ( -12352, 7444, -34 ) );
    var_0 moveto( ( -12354, 7310, -34 ), 3.2, 0.5, 0.5 );
    var_1 moveto( ( -12352, 7358, -34 ), 3.2, 0.5, 0.5 );
    wait 3.21;

    if ( isdefined( var_0 ) )
        var_0 moveto( ( -12354, 7213, -34 ), 3.2, 0.5, 0.5 );

    if ( isdefined( var_1 ) )
        var_1 moveto( ( -12352, 7444, -34 ), 3.2, 0.5, 0.5 );
}

scanner_front_door_open( var_0 )
{
    var_1 = soundscripts\_snd_playsound::snd_play_at( "decon_scanner_front_door_open", ( -12341, 7197, -34 ) );
    maps\_utility::delaythread( 3, soundscripts\_audio_reverb::rvb_start_preset, "det_refugee_camp", 4 );
    maps\_utility::delaythread( 3.1, soundscripts\_audio_zone_manager::azm_set_reverb_enable, 1 );
    var_1 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_decon_scanner" );
}

setup_entrance_gate_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_intro" ) )
        level waittill( "wait_forever_I_dont_care_its_already_happened" );

    maps\_anim::addnotetrack_customfunction( "decon_gate", "front_door_close", ::entrance_scanner_front_door_close, "det_gate_decon_station" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "front_door_open", ::entrance_scanner_front_door_open, "det_gate_decon_station" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "back_door_close", ::entrance_scanner_back_door_close, "det_gate_decon_station" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "back_door_open", ::entrance_scanner_back_door_open, "det_gate_decon_station" );
    maps\_anim::addnotetrack_customfunction( "decon_gate", "scanner_running", ::entrance_scanner_running, "det_gate_decon_station" );
}

entrance_scanner_front_door_close( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "entrance_gate_door_cl", ( -12205, 7204, -34 ) );
}

entrance_scanner_front_door_open( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "entrance_gate_door_op", ( -12205, 7204, -34 ) );
}

entrance_scanner_back_door_close( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "entrance_gate_door_cl", ( -12200, 7451, -34 ) );
}

entrance_scanner_back_door_open( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "entrance_gate_door_op", ( -12200, 7451, -34 ) );
}

entrance_scanner_running( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "entrance_gate_scanner", ( -12174, 7329, -34 ) );
}

bones_high_five( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_bones_high_five" );
}

setup_jetbike_motorpool_anims()
{
    maps\_anim::addnotetrack_customfunction( "player_bike", "player_bike_wing_flaps", ::player_bike_wing_flaps, "hoverbike_mount" );
    maps\_anim::addnotetrack_customfunction( "player_bike", "player_bike_wing_flaps_left", ::player_bike_wing_flaps_left, "hoverbike_mount_left" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_mounts_bike", ::burke_mounts_bike, "hoverbike_mount" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_powers_up_bike", ::burke_powers_up_bike, "hoverbike_mount" );
}

player_bike_wing_flaps( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "camp_jtbk_start_servos" );
}

player_bike_wing_flaps_left( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "camp_jtbk_start_servos" );
}

burke_mounts_bike( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "camp_jtbk_burke_mount" );
}

burke_powers_up_bike( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "camp_jtbk_burke_start_engine" );
}

jetbike_intro( var_0 )
{
    music( "jetbike_intro" );
    maps\_utility::delaythread( 1.5, ::jetbike_intro_hover_npc_bikes );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_motorpool_meet_up" );

    if ( var_0 == "left_anim" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "det_jtbk_ridein_part1_accent_plr" );
        level.joker soundscripts\_snd_playsound::snd_play_linked( "det_jtbk_ridein_part1_accent_jok" );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_mount_foley", 0.2 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_ignition_foley", 4.5 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_ignition", 4.5 );
        maps\_utility::delaythread( 4.5, ::jetbike_intro_hover_player_bike );
    }
    else if ( var_0 == "right_anim" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "det_jtbk_ridein_part1_accent_plr" );
        level.joker soundscripts\_snd_playsound::snd_play_linked( "det_jtbk_ridein_part1_accent_jok" );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_mount_foley", 0.0 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_ignition_foley", 4.6 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "camp_jtbk_ignition", 4.6 );
        maps\_utility::delaythread( 4.6, ::jetbike_intro_hover_player_bike );
    }
}

jetbike_intro_hover_npc_bikes()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_jetbike_ridein" );
    level.burke_bike maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    level.joker_bike maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    level.bones_bike maps\_utility::ent_flag_set( "jetbike_is_hovering" );
}

jetbike_intro_hover_player_bike()
{
    level.player_bike maps\_utility::ent_flag_set( "jetbike_is_hovering" );
}

setup_jetbike_checkpoint_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_gate" ) )
        level waittill( "tff_post_gatetrans_entry" );

    maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_land", ::burke_gate_jtbk_land, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_lift", ::burke_gate_jtbk_lift, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "joker", "joker_hoverbike_land", ::joker_gate_jtbk_land, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "joker", "joker_hoverbike_lift", ::joker_gate_jtbk_lift, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "bones", "bones_hoverbike_land", ::bones_gate_jtbk_land, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "bones", "bones_hoverbike_lift", ::bones_gate_jtbk_lift, "hoverbike_meet_up" );
}

burke_gate_jtbk_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_burke_land" );
}

burke_gate_jtbk_lift( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_burke_lift" );
}

joker_gate_jtbk_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_joker_land" );
}

joker_gate_jtbk_lift( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_joker_lift" );
}

bones_gate_jtbk_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_bones_land" );
}

bones_gate_jtbk_lift( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_chkpnt_jtbk_bones_lift" );
}

refugee_butress_down()
{
    if ( isdefined( level.aud.refugee_butress_down_time ) && gettime() - level.aud.refugee_butress_down_time < 1 )
        return;

    level.aud.refugee_butress_down_time = gettime();
    soundscripts\_snd_playsound::snd_play_delayed_linked( "barricade_lower_hydro", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "barricade_lower_cmprsr", 0.113 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "barricade_lower_impact", 0.7 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "barricade_lower_lfe", 0.7 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "barricade_lower_far", 0.9 );
}

gate_lightning()
{
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_gate_lightning", 0.5 );
    soundscripts\_snd_playsound::snd_play_2d( "det_gate_lightning" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_gate_lightning", 4.0 );
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( soundscripts\_audio_zone_manager::azm_get_current_zone(), "quad_ext_rain_mech_gate", 6.5 );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_mech_gate_ambi" );
}

setup_gideon_intro_foley()
{
    if ( level.currentgen && level.transient_zone == "intro" )
    {
        for (;;)
        {
            if ( istransientloaded( "detroit_introa_tr" ) )
                break;

            wait 0.25;
        }
    }

    if ( level.currentgen && level.transient_zone != "intro" )
        level waittill( "some_bs_that_will_never_happen_used_to_deal_with_start_points" );

    maps\_anim::addnotetrack_customfunction( "burke", "det_intro_gideon_foley_pt1", ::det_intro_gideon_foley_pt1, "level_intro_cinematic" );
    maps\_anim::addnotetrack_customfunction( "burke", "det_intro_gideon_foley_pt2", ::det_intro_gideon_foley_pt2, "level_intro_cinematic" );
    maps\_anim::addnotetrack_customfunction( "burke", "det_intro_gideon_foley_pt3", ::det_intro_gideon_foley_pt3, "level_intro_cinematic" );
}

det_intro_gideon_foley_pt1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_intro_gideon_foley_pt1" );
}

det_intro_gideon_foley_pt2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_intro_gideon_foley_pt2" );
}

det_intro_gideon_foley_pt3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_gideon_foley_pt3" );
}

setup_det_intro_catch_anims()
{
    maps\_anim::addnotetrack_customfunction( "drone_civs", "start_det_catch_guy_01", ::start_det_catch_guy_01, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_01_pt_02", ::det_catch_guy_01_pt_02, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_01_pt_03", ::det_catch_guy_01_pt_03, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_01_ball_drop", ::det_catch_guy_01_ball_drop, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_01_pt_04", ::det_catch_guy_01_pt_04, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_01_pt_05", ::det_catch_guy_01_pt_05, "baseball1" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "start_det_catch_guy_02", ::start_det_catch_guy_02, "baseball2" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_02_pt_02", ::det_catch_guy_02_pt_02, "baseball2" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_02_pt_03", ::det_catch_guy_02_pt_03, "baseball2" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_02_pt_04", ::det_catch_guy_02_pt_04, "baseball2" );
    maps\_anim::addnotetrack_customfunction( "drone_civs", "det_catch_guy_02_pt_05", ::det_catch_guy_02_pt_05, "baseball2" );
}

start_det_catch_guy_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01" );
}

det_catch_guy_01_pt_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01_pt_02" );
}

det_catch_guy_01_pt_03( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01_pt_03" );
}

det_catch_guy_01_ball_drop( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01_ball_drop" );
}

det_catch_guy_01_pt_04( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01_pt_04" );
}

det_catch_guy_01_pt_05( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_01_pt_05" );
}

start_det_catch_guy_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_02" );
}

det_catch_guy_02_pt_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_02_pt_02" );
}

det_catch_guy_02_pt_03( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_02_pt_03" );
}

det_catch_guy_02_pt_04( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_02_pt_04" );
}

det_catch_guy_02_pt_05( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_intro_catch_guy_02_pt_05" );
}

setup_hoverbike_meet_up_notetracks()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_gate" ) )
        level waittill( "tff_post_gatetrans_entry" );

    maps\_anim::addnotetrack_customfunction( "mech1", "aud_mech_scanner", ::aud_mech_scanner, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "entrance_gate", "aud_big_gate_pre_open", ::aud_big_gate_pre_open, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "entrance_gate", "aud_big_gate_open_stage_1", ::aud_big_gate_open_stage_1, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "entrance_gate", "aud_big_gate_stop_stage_1", ::aud_big_gate_stop_stage_1, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "entrance_gate", "aud_big_gate_open_stage_2", ::aud_big_gate_open_stage_2, "hoverbike_meet_up" );
    maps\_anim::addnotetrack_customfunction( "entrance_gate", "aud_big_gate_stop_stage_2", ::aud_big_gate_stop_stage_2, "hoverbike_meet_up" );
}

aud_mech_scanner( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_mech_scanner" );
}

aud_big_gate_pre_open( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_jtbk_ridein_part2_accent_plr" );
    level.joker soundscripts\_snd_playsound::snd_play_linked( "det_jtbk_ridein_part2_accent_jok" );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_buzzer", 1.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_movement_stage_1", 1.25 );
}

aud_big_gate_open_stage_1( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_alarm_2x", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_horn", 1.25 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_lock_stage_1", 3.35 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_lfe_impact_1", 4.35 );
}

aud_big_gate_stop_stage_1( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_movement_stage_2", 0.05 );
}

aud_big_gate_open_stage_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_movement_stage_2_rear", 2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_lock_stage_2", 5.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "big_gate_lfe_impact_2", 5.15 );
}

aud_big_gate_stop_stage_2( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_motorpool_meet_up", 5 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_mech_gate_ambi" );
}

drive_in_done()
{
    music( "drive_in_done" );
}

jetbikes_arrive_at_school()
{
    common_scripts\utility::flag_wait( "aud_parking_garage_exit" );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "det_school_jtbk_burke_land", 1 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "det_school_jtbk_joker_land", 1.4 );
    level.bones soundscripts\_snd_playsound::snd_play_delayed_linked( "det_school_jtbk_bones_land", 2.3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_jtbk_school_land", 2.25 );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_jetbike_ridein" );
}

setup_fence_climb_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
        level waittill( "tff_post_intro_to_middle" );

    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_01", ::climb_fence_joker_01, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_02", ::climb_fence_joker_02, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_03", ::climb_fence_joker_03, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_04", ::climb_fence_joker_04, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_05", ::climb_fence_joker_05, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_06", ::climb_fence_joker_06, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_07", ::climb_fence_joker_07, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_08", ::climb_fence_joker_08, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_09", ::climb_fence_joker_09, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "joker", "climb_fence_joker_10", ::climb_fence_joker_10, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_01", ::climb_fence_torres_01, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_02", ::climb_fence_torres_02, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_03", ::climb_fence_torres_03, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_04", ::climb_fence_torres_04, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_05", ::climb_fence_torres_05, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_06", ::climb_fence_torres_06, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_07", ::climb_fence_torres_07, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_08", ::climb_fence_torres_08, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_09", ::climb_fence_torres_09, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "bones", "climb_fence_torres_10", ::climb_fence_torres_10, "bike_dismount" );
}

climb_fence_joker_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_01" );
}

climb_fence_joker_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_02" );
}

climb_fence_joker_03( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_03" );
}

climb_fence_joker_04( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_04" );
}

climb_fence_joker_05( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_05" );
}

climb_fence_joker_06( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_06" );
}

climb_fence_joker_07( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_07" );
}

climb_fence_joker_08( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_08" );
}

climb_fence_joker_09( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_09" );
}

climb_fence_joker_10( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_joker_10" );
}

climb_fence_torres_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_01" );
}

climb_fence_torres_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_02" );
}

climb_fence_torres_03( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_03" );
}

climb_fence_torres_04( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_04" );
}

climb_fence_torres_05( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_05" );
}

climb_fence_torres_06( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_06" );
}

climb_fence_torres_07( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_07" );
}

climb_fence_torres_08( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_08" );
}

climb_fence_torres_09( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_09" );
}

climb_fence_torres_10( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "climb_fence_torres_10" );
}

begin_on_foot_segment()
{
    music( "begin_on_foot_segment" );
}

weather_report( var_0 )
{
    switch ( var_0 )
    {
        case "drizzle":
            break;
        case "med_rain":
            break;
        case "heavy_rain":
            break;
        case "heavy_speedy_rain":
            break;
    }
}

lightning_strike()
{
    var_0 = self;
    wait 0.5;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "generic_lightning_strike" );
    thread setup_wallpull();
}

play_maglev_train_path()
{
    if ( common_scripts\utility::flag( "aud_maglev_train_path_disabled" ) )
        return;

    var_0 = self;
    var_1 = 1.5;
    var_2 = 4;
    var_3 = soundscripts\_snd_playsound::snd_play_loop_linked( "maglev_train_lp", undefined, var_1, var_2 );
    var_0 thread dopplerize_train( var_3 );

    if ( !isdefined( level.aud.maglev_by_school_sweetener_num ) )
        level.aud.maglev_by_school_sweetener_num = 1;

    var_4 = "maglev_by_school_swt" + level.aud.maglev_by_school_sweetener_num;
    level.aud.maglev_by_school_sweetener_num += 1;

    if ( level.aud.maglev_by_school_sweetener_num > 3 )
        level.aud.maglev_by_school_sweetener_num = 1;

    if ( var_0 soundscripts\_snd_common::snd_waittill_within_radius( 2800, 0 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "maglev_by_school_main", 0.0, undefined, undefined, 0, 4.0 );
            var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( var_4, 0.4, undefined, undefined, 0, 4.0 );
        }
    }
}

dopplerize_train( var_0 )
{
    var_1 = self;
    var_2 = 0.05;
    var_3 = 1;
    var_4 = 1;

    while ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_5 = dopplerpitch( var_1.origin, var_1 maps\_shg_utility::get_differentiated_velocity(), level.player.origin, level.player maps\_shg_utility::get_differentiated_velocity(), var_3, var_4 );
        var_0 scalepitch( var_5, var_2 );
        wait(var_2);
        waittillframeend;
    }
}

walk_to_school()
{
    music( "walk_to_school" );
}

start_fuorescent_light_hum( var_0 )
{
    var_1 = spawn( "script_origin", var_0 );
    var_1 soundscripts\_snd_playsound::snd_play_loop( "school_fluorescent_hum" );
    common_scripts\utility::flag_wait( "aud_horror_fluorescent_break" );
    var_1 scalevolume( 0, 0.25 );
    wait 0.25;
    var_1 stopsounds();
    var_1 delete();
}

monitor_fuorescent_light_dist( var_0 )
{
    var_1 = 0.1;
    var_2 = distance2d( level.burke.origin, var_0 );
    var_3 = [ [ 36, 0.4 ], [ var_2, 1.0 ] ];
    var_4 = soundscripts\_audio::aud_get_ambi_submix();
    var_5 = soundscripts\_audio::aud_get_music_submix();
    var_6 = distance2d( level.player.origin, var_0 );
    var_7 = 0;

    while ( !common_scripts\utility::flag( "aud_horror_fluorescent_break" ) )
    {
        var_6 = distance2d( level.burke.origin, var_0 );
        var_8 = soundscripts\_snd::snd_map( var_6, var_3 );
        soundscripts\_audio::aud_set_ambi_submix( var_4 * var_8, var_1 );

        if ( var_8 < var_7 )
            soundscripts\_audio::aud_set_music_submix( var_5 * var_8, var_1 );

        var_7 = var_8;
        wait 0.05;
    }

    soundscripts\_audio_music::mus_stop( 1 );
    wait 3;
    soundscripts\_audio::aud_set_ambi_submix( var_4, 30 );
}

horror_fluorescent_break()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_bulb_break_gag" );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "school_fluorescent_break" );
    common_scripts\utility::flag_set( "aud_horror_fluorescent_break" );
    var_0 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_bulb_break_gag" );
}

horror_burke_gets_up_after_tile()
{
    music( "horror_burke_gets_up_after_tile" );
}

horror_burk_opens_bodies_room_door()
{
    thread horror_burk_opens_bodies_room_door_sfx();
    thread horror_burk_opens_bodies_room_door_mus();
}

horror_burk_opens_bodies_room_door_sfx()
{
    var_0 = ( -1529, 9494, -10 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "enter_bodies_room_latch", var_0, 2.8 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "enter_bodies_room_door0", var_0, 2.8 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "enter_bodies_room_door1", var_0, 5.4 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "enter_bodies_room_door2", var_0, 8.8 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "enter_bodies_room_door_kick", var_0, 8.8 );
}

horror_burk_opens_bodies_room_door_mus()
{
    var_0 = 8.75;
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1 scalevolume( 0, 0 );
    var_1 soundscripts\_snd_playsound::snd_play_loop( "det_mus_horror_lp_02" );
    var_1 scalevolume( 0.75, var_0 );
    wait(var_0);
    music( "horror_burk_door_open_end" );
    level notify( "horror_burk_door_open_end" );
    var_1 scalevolume( 0, 5 );
    wait 5;
    var_1 stopsounds();
    var_1 delete();
}

body_room_exit()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exit_bodies_room_door", 2.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exit_bodies_room_door_debris", 2.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exit_bodies_room_bump", 4.5 );
    music( "body_room_exit" );
}

finish_bodies_room_burke()
{
    music( "finish_bodies_room_burke" );
}

horror_ghost_runs_by_door()
{
    wait 3;
    wait 8;
    music( "post_horror_ghost_runs_by_door" );
}

school_upthestairs()
{
    music( "school_upthestairs" );
}

burke_startle_stairs()
{
    soundscripts\_snd_playsound::snd_play_at( "burke_startle_stairs", ( -1049, 9336, 278 ) );
}

train_scare()
{
    var_0 = "stop_school_train_scare";
    var_1 = soundscripts\_snd_playsound::snd_play_2d( "school_train_scare", var_0, 5, 6 );
    var_1 soundscripts\_snd_playsound::snd_play_set_cleanup_msg( "Train Scare" );
    wait 7;
    level notify( var_0 );
}

school_lightning_strike()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "generic_lightning_strike" );
}

setup_wallpull()
{
    var_0 = soundscripts\_audio_zone_manager::azm_get_current_zone();

    if ( var_0 == "dtrt_int_school_floor_2" && !isdefined( level.aud.setup_wallpull ) )
        level.aud.setup_wallpull = 1;
    else
        return;

    var_1 = 4;
    var_2 = 0.1;
    var_3 = ( -1778, 8629, 129 );
    var_4 = [ [ 36, 0.01 ], [ 750, 1.0 ] ];
    var_5 = soundscripts\_audio::aud_get_music_submix();
    var_6 = soundscripts\_audio::aud_get_ambi_submix();
    var_7 = distance2d( level.player.origin, var_3 );
    var_8 = soundscripts\_snd::snd_map( var_7, var_4 );
    soundscripts\_audio::aud_set_music_submix( var_5 * var_8, var_1 );
    soundscripts\_audio::aud_set_ambi_submix( var_6 * var_8, var_1 );
    wait(var_1);

    while ( !common_scripts\utility::flag( "aud_wallpull_begin" ) )
    {
        var_7 = distance2d( level.player.origin, var_3 );
        var_8 = soundscripts\_snd::snd_map( var_7, var_4 );
        soundscripts\_audio::aud_set_music_submix( var_5 * var_8, var_2 );
        soundscripts\_audio::aud_set_ambi_submix( var_6 * var_8, var_2 );
        wait 0.05;
    }

    soundscripts\_audio::aud_set_ambi_submix( var_6, 0 );
}

kva_knife_takedown_scene_begin()
{
    music( "mus_pre_alley_combat" );
}

mus_alley_combat( var_0 )
{
    music( "mus_alley_combat" );
    soundscripts\_audio_mix_manager::mm_add_submix( "alley_combat_trains_down" );
}

temp_dog_bark( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lag_dog_bark" );
}

office_reunion_dialogue()
{
    music( "office_reunion_dialogue" );
}

player_shimmy_intro( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_shimmy" );

    if ( var_0 == "short_version" )
        soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_into_short" );
    else if ( var_0 == "long_version" )
        soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_into_long" );
}

setup_school_shimmy_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_school" ) )
        level waittill( "tff_post_middle_add_school" );

    maps\_anim::addnotetrack_customfunction( "school_blockage", "burke_beam_bend", ::burke_beam_bend, "burke_wall_walk" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_shimmy_1", ::burke_shimmy_1, "burke_wall_walk" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_shimmy_2", ::burke_shimmy_2, "burke_shimmey_wait_idle_out" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_shimmy_2b", ::burke_shimmy_2b, "burke_shimmey_wait_idle_out" );
    maps\_anim::addnotetrack_customfunction( "world_body", "shimmy_2", ::player_shimmy_2, "school_fall_shuffle_pt2" );
    maps\_anim::addnotetrack_customfunction( "world_body", "shimmy_4", ::player_shimmy_4, "school_fall_shuffle_pt4" );
    maps\_anim::addnotetrack_customfunction( "world_body", "shimmy_1", ::player_shimmy_1, "school_fall_shuffle_pt1" );
    maps\_anim::addnotetrack_customfunction( "world_body", "shimmy_3", ::player_shimmy_3, "school_fall_shuffle_pt3" );
}

burke_beam_bend( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_school_beam_bend" );
    music( "burke_beam_bend" );
}

burke_shimmy_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_school_shimmy_burke_1", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
}

burke_shimmy_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_school_shimmy_burke_2", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
    soundscripts\_snd_playsound::snd_play_at( "det_school_shimmy_burke_beam", ( -1374, 9388, 83 ) );
}

burke_shimmy_2b( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_school_shimmy_burke_2b", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
}

player_shimmy_1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_1" );
}

player_shimmy_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_2" );
}

player_shimmy_3( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_3" );
}

player_shimmy_4( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_school_shimmy_4" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_school_shimmy" );
}

school_fall()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fall", 2 );
    soundscripts\_snd_playsound::snd_play_2d( "det_school_fall" );
}

school_fall_into_basement()
{
    music( "school_fall_into_basement" );
    soundscripts\_snd_playsound::snd_play_2d( "det_school_fall_into_basement" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_school_fall", 3 );
    wait 3;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_school_fs_override", 0.5 );
    level.aud.in_basement = 1;
    level.aud.in_school = 0;
}

basement_investigate()
{
    var_0 = self;
    var_1 = ( -970, 9111, -143 );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_steam_guy" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "basement_steam_guy_fs2", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "basement_steam_guy_steam", var_1, 0.0 );
    wait 8.409;

    if ( common_scripts\utility::flag( "kill_the_valve_anim" ) )
    {
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_steam_guy" );
        return;
    }

    soundscripts\_snd_playsound::snd_play_at( "basement_steam_guy_valve1", var_1 );
    wait 2.5;

    if ( common_scripts\utility::flag( "kill_the_valve_anim" ) )
    {
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_steam_guy" );
        return;
    }

    soundscripts\_snd_playsound::snd_play_at( "basement_steam_guy_valve2", var_1 );
    wait 2;

    if ( common_scripts\utility::flag( "kill_the_valve_anim" ) )
    {
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_steam_guy" );
        return;
    }

    if ( isalive( var_0 ) )
        var_0 soundscripts\_snd_playsound::snd_play_linked( "basement_steam_guy_fs3" );

    wait 20;

    if ( !common_scripts\utility::flag( "kill_the_valve_anim" ) )
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_steam_guy" );
}

kva_basement_idle_start()
{
    soundscripts\_snd::snd_println( "kva_basement_idle_start" );
}

steam_burst_valve_started()
{
    soundscripts\_snd::snd_println( "steam_burst_valve_started" );
}

setup_wall_pull_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_school" ) )
        level waittill( "tff_post_middle_add_school" );

    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_foley1_grabs_vox1", ::grab_n_stab_foley1_grabs_vox1, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_kick_impact_vox2", ::grab_n_stab_kick_impact_vox2, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_brick_snap", ::grab_n_stab_brick_snap, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_brick_impact_with_lfe_glass", ::grab_n_stab_brick_impact_with_lfe_glass, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_vox3", ::grab_n_stab_vox3, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_body_fall_with_lfe", ::grab_n_stab_body_fall_with_lfe, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_knife1", ::grab_n_stab_knife1, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_foley2", ::grab_n_stab_foley2, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_knife2", ::grab_n_stab_knife2, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_knife3", ::grab_n_stab_knife3, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_knife4", ::grab_n_stab_knife4, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "grab_n_stab_knife5", ::grab_n_stab_knife5, "wall_pull" );
}

grab_n_stab_foley1_grabs_vox1( var_0 )
{
    common_scripts\utility::flag_set( "aud_wallpull_begin" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_foley1" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_grabs" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_vox1" );
}

grab_n_stab_kick_impact_vox2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_kick_impact" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_vox2" );
}

grab_n_stab_brick_snap( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_brick_snap" );
}

grab_n_stab_brick_impact_with_lfe_glass( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_brick_impact" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_brick_impact_lfe" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_glass" );
}

grab_n_stab_vox3( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_vox3" );
}

grab_n_stab_body_fall_with_lfe( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_body_fall" );
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_body_fall_lfe" );
}

grab_n_stab_knife1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_knife1" );
}

grab_n_stab_foley2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_foley2" );
}

grab_n_stab_knife2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_knife2" );
}

grab_n_stab_knife3( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_knife3" );
}

grab_n_stab_knife4( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_knife4" );
}

grab_n_stab_knife5( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_n_stab_knife5" );
}

setup_hospital_post_breach_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_hospital" ) )
        level waittill( "tff_post_middle_add_hospital" );

    maps\_anim::addnotetrack_customfunction( "doctor", "hospital_post_breach_01", ::hospital_post_breach_01, "doctor_capture" );
    maps\_anim::addnotetrack_customfunction( "doctor", "hospital_post_breach_02", ::hospital_post_breach_02, "doctor_capture" );
    maps\_anim::addnotetrack_customfunction( "doctor", "hospital_post_breach_03", ::hospital_post_breach_03, "doctor_capture" );
    maps\_anim::addnotetrack_customfunction( "doctor", "hospital_post_breach_04", ::hospital_post_breach_04, "doctor_capture" );
    maps\_anim::addnotetrack_customfunction( "doctor", "hospital_post_breach_05", ::hospital_post_breach_05, "doctor_capture" );
    maps\_anim::addnotetrack_customfunction( "doctor", "det_doc_roll_over", ::det_doc_roll_over, "carry_doc_lift" );
    maps\_anim::addnotetrack_customfunction( "doctor", "det_doc_picked_up", ::det_doc_picked_up, "carry_doc_lift" );
}

hospital_post_breach_01( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_post_hospital_breach" );
    det_stop_doctor_breathing();
    soundscripts\_snd_playsound::snd_play_2d( "wpn_med_holster_plr" );
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_01" );
}

hospital_post_breach_02( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_02" );
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_02_punch" );
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_02_punch_lfe" );
}

hospital_post_breach_03( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_03" );
}

hospital_post_breach_04( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_04" );
}

hospital_post_breach_05( var_0 )
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "det_post_breach_05" );
}

det_doc_roll_over( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_post_breach_doctor_roll" );
}

det_doc_picked_up( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_post_breach_doctor_pickup" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_post_hospital_breach", 1 );
}

wall_pull_animation_begin()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_wallpull", 0.5 );
    soundscripts\_snd_timescale::snd_set_timescale( "wall_pull" );
    music( "wallpull" );
    wait 20;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_wallpull", 3.0 );
    soundscripts\_snd_timescale::snd_set_timescale( "detroit_default" );
}

wall_pull_slowmo( var_0 )
{
    if ( var_0 == "begin" )
    {
        soundscripts\_audio_mix_manager::mm_add_submix( "det_wallpull_slowmo", 1.0 );
        soundscripts\_snd_playsound::snd_play_2d( "wallpull_slowmo_in" );
        soundscripts\_snd_playsound::snd_play_2d( "wallpull_slowmo_body", "wallpull_slomo_stop_notify", 0, 0.5, 0.6 );
    }
    else if ( var_0 == "end" )
    {
        level notify( "wallpull_slomo_stop_notify" );
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_wallpull_slowmo", 1.0 );
        soundscripts\_snd_playsound::snd_play_2d( "wallpull_slowmo_out" );
        common_scripts\utility::flag_set( "aud_wallpull_success" );
    }
    else if ( var_0 == "fail" )
        soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

detroit_kva_bauerdoyoureadme()
{
    soundscripts\_snd_playsound::snd_play_at( "detroit_kva_bauerdoyoureadme", ( -1784, 8758, 83 ) );
}

hospital_breach_gun_away()
{
    soundscripts\_snd_playsound::snd_play_2d( "det_breach_gun_away" );
}

hostpital_breach_start()
{
    soundscripts\_snd_timescale::snd_set_timescale( "detroit_breach" );
    level.player enablecustomweaponcontext();
    enablesoundcontextoverride( "slomo" );
    soundscripts\_snd_playsound::snd_play_2d( "det_breach_door" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "det_hospital_breach", 1 );
    soundscripts\_snd_playsound::snd_play_loop_2d( "overdrive_loop", "kill_breach_loop" );
}

breach_slo_mo_exit()
{
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_exit" );
    soundscripts\_snd_timescale::snd_set_timescale( "detroit_default" );
    disablesoundcontextoverride( "slomo" );
    level.player disablecustomweaponcontext();
    level notify( "kill_breach_loop" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_hospital_breach", 2 );
}

push_dude_into_shelves()
{
    soundscripts\_snd_playsound::snd_play_2d( "det_breach_punch_dude" );
}

breach_bad_guy2_gets_shot()
{
    soundscripts\_snd_playsound::snd_play_linked( "det_breach_shoot_dude" );
}

shoot_dude_through_window()
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "det_breach_window_dude", 0.1 );
}

capture_doctor_scene_start()
{

}

office_skylights_breakable( var_0 )
{
    var_1 = var_0.origin;
    thread soundscripts\_snd_playsound::snd_play_at( "office_skylight_break", var_1 );
    var_2 = bullettrace( var_1, var_1 + ( 0, 0, -10000 ), 0 );
    var_3 = var_2["position"];
    wait 0.2;
    thread soundscripts\_snd_playsound::snd_play_at( "office_skylight_debris", var_3 );
    wait 0.2;
    thread soundscripts\_snd_playsound::snd_play_at( "office_skylight_debris_shatters", var_3 );
}

begin_exo_push()
{
    changewhizbyautosimparams( 0, 0, 0, 0, -4, 2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_ambulance_push" );
    thread end_exo_push();
}

ambulance_push_attach( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_attach" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "pc_exo_strength_hi", 0.5 );
}

amb_push_oneshots()
{
    level endon( "aud_amb_push_stopped" );
    level waittill( "aud_amb_push_active" );

    for (;;)
    {
        var_0 = randomintrange( 1, 3 );
        wait(var_0);
        thread soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_random_oneshot" );
    }
}

ambulance_push_active()
{
    var_0 = self;

    if ( level.aud.amb_pushing == 0 )
    {
        level.player soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_start" );
        thread amb_push_oneshots();
        soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_metal_vehicle" );
    }

    level.aud.amb_pushing = 1;
    level notify( "aud_amb_push_active" );
    var_0 scalevolume( 1, 0.1 );
    var_0 playloopsound( "det_amb_push_body_lp" );
}

ambulance_push_step_away()
{
    var_0 = self;
    var_0 scalevolume( 0, 0.4 );
    thread soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_detach" );
    level.aud.amb_pushing = 0;
    level notify( "aud_amb_push_stopped" );
    wait 0.5;
    var_0 stopsounds();
    var_0 stoploopsound();
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_metal_vehicle" );
}

ambulance_push_idle()
{
    var_0 = self;

    if ( level.aud.amb_pushing == 1 )
        level.player soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_stop" );

    var_0 scalevolume( 0, 0.4 );
    level.aud.amb_pushing = 0;
    level notify( "aud_amb_push_stopped" );
}

ambulance_push_sequence_end()
{
    var_0 = self;
    thread soundscripts\_snd_playsound::snd_play_2d( "det_amb_push_end" );
    var_0 scalevolume( 0, 0.2 );
    level.aud.amb_pushing = 0;
    level notify( "aud_amb_push_stopped" );
    wait 0.2;
    var_0 stoploopsound();
}

end_exo_push()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    changewhizbyautosimparams( 0, 0, 0, 0, 1, 1 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_ambulance_push" );
}

hospital_flashbang1( var_0, var_1 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_at( "det_hopital_flash_bang", var_1 );
    soundscripts\_snd::snd_slate( "hospital_flashbang1" );
}

hospital_flashbang2( var_0, var_1 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_at( "det_hopital_flash_bang", var_1 );
    soundscripts\_snd::snd_slate( "hospital_flashbang2" );
}

hospital_flashbang3( var_0, var_1 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_at( "det_hopital_flash_bang", var_1 );
    soundscripts\_snd::snd_slate( "hospital_flashbang3" );
}

det_hospital_gate_close()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_hospital_gate" );
}

det_start_doctor_breathing( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "detroit_dcr_breathing", "det_doctor_stop_breathing" );
}

det_stop_doctor_breathing()
{
    level notify( "det_doctor_stop_breathing" );
}

reveal_scene_start()
{
    var_0 = getent( "animated_bouncing_betty", "targetname" );
    soundscripts\_snd_timescale::snd_set_timescale( "sent_reveal" );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_sentinel_reveal", 0.05 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_betty_arm" );
}

reveal_explosion()
{
    music( "det_sent_rev_explo" );
    soundscripts\_snd_playsound::snd_play_2d( "det_sent_rev_explo" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_sent_rev_gunfire", 6.8, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_sent_rev_bullet_hits", 6.8, 1 );
}

setup_sentinel_reveal_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_hospital" ) )
        level waittill( "tff_post_middle_add_hospital" );

    maps\_anim::addnotetrack_customfunction( "kva1", "kva_guy1_footsteps", ::kva_guy1_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "kva1", "kva_guy1_gets_shot", ::kva_guy1_gets_shot, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "kva2", "kva_guy2_footsteps", ::kva_guy2_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "kva2", "kva_guy2_gets_shot", ::kva_guy2_gets_shot, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "kva3", "kva_guy3_footsteps", ::kva_guy3_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "kva3", "kva_guy3_gets_shot", ::kva_guy3_gets_shot, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy_1_footsteps", ::sent_guy_1_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy1_out_of_slo_mo_foley", ::sent_guy_1_footsteps_part2, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy1_footsteps2", ::sent_guy_1_footsteps_part3, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy2", "sent_guy2_footsteps", ::sent_guy_2_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy3", "sent_guy3_footsteps", ::sent_guy_3_footsteps, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy1_mask_up", ::sent_guy1_mask_up, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy1_mask_down", ::sent_guy1_mask_down, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy1", "sent_guy1_cloak", ::sent_guy1_cloak, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_knocked_to_ground", ::burke_knocked_to_ground, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_gets_up", ::burke_gets_up, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_feet01", ::burke_feet01, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_alert", ::burke_alert, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "burke", "burke_exit", ::burke_exit, "sentinel_kva_reveal" );
}

kva_guy1_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_badguy01_feet" );
}

kva_guy1_gets_shot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_sent_rev_badguy01_shot" );
}

kva_guy2_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_badguy02_feet" );
}

kva_guy2_gets_shot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_sent_rev_badguy02_shot" );
}

kva_guy3_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_badguy03_feet" );
}

kva_guy3_gets_shot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_sent_rev_badguy03_shot" );
}

sent_guy_1_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_feet1" );
}

sent_guy_1_footsteps_part2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_feet2" );
}

sent_guy_1_footsteps_part3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_feet3" );
}

sent_guy_2_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy02_feet" );
}

sent_guy_3_footsteps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy03_feet" );
}

sent_guy_2_decloak()
{
    soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy02_uncloak" );

    if ( level.currentgen )
        soundscripts\_audio_mix_manager::mm_clear_submix( "det_sentinel_reveal", 5 );
}

sent_guy_3_decloak()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_sentinel_reveal", 5 );
    soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy03_uncloak" );
}

det_knx_thatsclassifiedmate()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_post_sentinel_reveal", 0.1 );
}

sentinel_reveal_final_vo()
{
    music( "mus_pre_exit_drive" );
}

sent_guy_1_decloak()
{
    soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_uncloak" );
    soundscripts\_snd_timescale::snd_set_timescale( "detroit_default" );
}

sent_guy1_mask_up( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_mask_open" );
}

sent_guy1_mask_down( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_mask_close" );
    surprise_attack();
}

sent_guy1_cloak( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_goodguy01_cloak" );
}

burke_knocked_to_ground( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_burke_fall" );
}

burke_gets_up( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_burke_get_up" );
}

burke_feet01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_burke_limp" );
}

burke_alert( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_burke_alert" );
}

burke_exit( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_sent_rev_burke_exit" );
}

surprise_attack()
{
    soundscripts\_snd_playsound::snd_play_2d( "det_sent_rev_surprise_attack" );
}

aud_impact_system_jetbike( var_0 )
{
    var_1 = [];
    var_1["Debug"] = 0;
    var_1["VehicleID"] = "jbike_impact";
    var_1["PV_MinVelocityThreshold"] = 125;
    var_1["PV_MaxVelocity"] = 800;
    var_1["PV_NumVelocityRanges"] = 3;
    var_1["PV_MaxSmlVelocity"] = 200;
    var_1["PV_MaxMedVelocity"] = 375;
    var_1["PV_MaxLrgVelocity"] = 800;
    var_1["NPC_MinVelocityThreshold"] = 25;
    var_1["NPC_MaxVelocity"] = 800;
    var_1["NPC_NumVelocityRanges"] = 3;
    var_1["NPC_MaxSmlVelocity"] = 100;
    var_1["NPC_MaxMedVelocity"] = 400;
    var_1["NPC_MaxLrgVelocity"] = 800;
    var_1["MinLFEVolumeThreshold"] = 0.0;
    var_1["FallVelMultiplier"] = 2;
    var_1["MinTimeThreshold"] = 350;
    var_1["ScrapeEnabled"] = 0;
    var_1["ScrapeSeperationTime"] = 0.5;
    var_1["ScrapeFadeOutTime"] = 0.5;
    var_1["ScrapeUpdateRate"] = 0.05;
    var_1["TireSkidProbability"] = 0;
    var_1["MaxDistanceThreshold"] = 6000;
    var_1["MedVolMin"] = 0.7;
    var_1["LrgVolMin"] = 1.0;
    var_1["NonPlayerImpVolReduction"] = 0.0;
    soundscripts\_snd_common::snd_play_vehicle_collision( var_0, var_1 );
}

setup_exit_ride_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
        level waittill( "tff_post_intro_to_middle" );

    maps\_anim::addnotetrack_customfunction( "burke", "aud_exitride_burke_start", ::exit_ride_burke_start, "det_exit_drive_starting_anim_1" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_exitride_burke_door_open", ::exit_ride_burke_door_open, "det_exit_drive_starting_anim_1" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_exitride_burke_mount", ::exit_ride_burke_mount, "det_exit_drive_starting_anim_1" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_exitride_burke_away", ::exit_ride_burke_away, "det_exit_drive_starting_anim_2" );
    maps\_anim::addnotetrack_customfunction( "joker", "aud_exitride_joker_start", ::exit_ride_joker_start, "det_exit_drive_starting_anim_2" );
}

exit_ride_burke_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "exit_ride_burke_feet", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_post_sentinel_reveal", 3 );
}

exit_ride_burke_door_open( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "exit_ride_burke_door" );
}

exit_ride_burke_mount( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "exit_ride_burke_mount" );
}

exit_ride_burke_away( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "exit_ride_burke_away" );
}

exit_ride_joker_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "exit_ride_joker_feet", undefined, undefined, undefined, undefined, ( 0, 0, -10 ) );
}

exit_ride_jetbike_mount_player()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_intro" );
    soundscripts\_snd_playsound::snd_play_2d( "exit_ride_player_foley" );
    wait 6;
    soundscripts\_snd_playsound::snd_play_2d( "exit_ride_player_ignition" );
    wait 4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_exit_ride_intro", 2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_jetbikes", 1 );
}

gaz_store_shootout_drive( var_0 )
{
    var_1 = self;
    var_1 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_driveby_01" );
}

warehouse_chase_vehicle_02()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_driveby_01" );
}

warehouse_chase_vehicle_03()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_driveby_02" );
}

warehouse_chase_vehicle_04()
{
    var_0 = self;
}

warehouse_car_shots( var_0 )
{
    var_1 = self;
    var_1 endon( "death" );
    var_2 = 0.05;
    var_1 soundscripts\_snd_playsound::snd_play_loop_linked( "wpn_wraith_turret_npc_lp", var_0 );
    var_3 = spawn( "script_origin", level.jetbike maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 500 ) );
    var_4 = var_3 soundscripts\_snd_playsound::snd_play_loop_linked( "det_gaz_strafe_bullets_lp", var_0 );
    var_5 = var_3 soundscripts\_snd_playsound::snd_play_loop_linked( "det_gaz_strafe_bullets_metal_lp", var_0 );
    thread warehouse_one_shots_glass( var_0 );
    thread warehouse_one_shots_rock( var_0 );

    while ( isdefined( var_1 ) )
    {
        var_6 = distance( var_1.origin, level.player.origin );
        var_7 = soundscripts\_snd::snd_map( var_6, level.aud.envs["gaz_strafe_whizybys"] );
        var_8 = level.jetbike maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 500 );
        var_3 moveto( var_8, var_2 );

        if ( isdefined( var_4 ) )
            var_4 scalevolume( var_7, var_2 );

        if ( isdefined( var_5 ) )
            var_5 scalevolume( var_7, var_2 );

        wait(var_2);
    }

    var_3 delete();
}

warehouse_one_shots_glass( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        var_1 = randomintrange( 1, 2 );
        wait(var_1);
        level.player thread soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_random_shots_glass" );
        wait 0.05;
    }
}

warehouse_one_shots_rock( var_0 )
{
    level endon( var_0 );

    for (;;)
    {
        var_1 = randomintrange( 2, 5 );
        level.player thread soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_random_shots_rock" );
        wait(var_1);
    }
}

exit_drive_rpgs()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "det_rpg_attack_lp" );
    var_0 thread exit_drive_rpgs_flyby();
    var_0 waittill( "explode" );

    if ( isdefined( var_0 ) )
    {
        thread soundscripts\_snd_playsound::snd_play_at( "det_rpg_attack_exp", self.origin );
        thread soundscripts\_snd_playsound::snd_play_at( "det_rpg_attack_debris", self.origin );
    }
}

exit_drive_rpgs_flyby()
{
    var_0 = self;
    var_1 = 900;

    while ( isdefined( var_0 ) )
    {
        var_2 = distance( var_0.origin, level.player.origin );

        if ( var_2 < var_1 )
        {
            var_0 soundscripts\_snd_playsound::snd_play_linked( "det_rpg_attack_flyby" );
            break;
        }

        wait 0.05;
    }
}

exitdrive_chopper_initial()
{

}

exitdrive_chopper_initial_gopath()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_littlebirds", 1 );
    var_0 = self;
    var_0 vehicle_turnengineoff();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_littlebird_exitride_first" );
}

exitdrive_chopper_tracks_1()
{
    var_0 = "LB-track:  ";
    var_1 = "littlebird_flyby";
    var_2 = [];
    var_2[0] = 3100;
    var_3 = [];
    var_3[0] = 75;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, undefined, var_2, var_3, 1 );
}

exitdrive_chopper_tracks_1_gopath()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "littlebird_med_incoming", undefined, undefined, 0.6 );
}

gaz_water_crash_01()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_driveby_02", "aud_gaz_water_crashed" );
}

gaz_water_crash_02()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_strafe_driveby_01", "aud_gaz_water_crashed" );
}

gaz_water_crashed( var_0 )
{
    var_1 = self;
    var_1 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_watercrash" );
    wait 0.1;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_gaz_watercrash" );
    level notify( "aud_gaz_water_crashed" );
}

exitdrive_chopper_final()
{

}

exitdrive_chopper_final_gopath()
{
    var_0 = self;
    var_0 vehicle_turnengineoff();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "det_littlebird_exitride_last" );
    wait 25;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_exit_ride_littlebirds", 3 );
}

collapsing_buttress_missile()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "det_rpg_attack_lp" );
    var_0 thread collapsing_buttress_missile_flyby();
    var_0 waittill( "explode" );

    if ( isdefined( var_0 ) )
    {
        thread soundscripts\_snd_playsound::snd_play_at( "det_rpg_attack_exp", self.origin );
        thread soundscripts\_snd_playsound::snd_play_at( "det_rpg_attack_debris", self.origin );
    }
}

collapsing_buttress_missile_flyby()
{
    var_0 = self;
    var_1 = 900;

    while ( isdefined( var_0 ) )
    {
        var_2 = distance( var_0.origin, level.player.origin );

        if ( var_2 < var_1 )
        {
            var_0 soundscripts\_snd_playsound::snd_play_linked( "det_rpg_attack_flyby" );
            break;
        }

        wait 0.05;
    }
}

collapsing_buttress_01()
{
    var_0 = ( -7808, 15430, -2 );
    thread soundscripts\_snd_playsound::snd_play_at( "det_buttress_collapse_impact", var_0 );
}

collapsing_buttress_02()
{
    var_0 = ( -7822, 14051, -11 );
    thread soundscripts\_snd_playsound::snd_play_at( "det_buttress_collapse_impact_02", var_0 );
}

collapsing_buttress_03()
{
    var_0 = ( -7841, 12406, -11 );
    thread soundscripts\_snd_playsound::snd_play_at( "det_buttress_collapse_impact", var_0 );
}

exit_train_by( var_0 )
{
    var_1 = self;
    common_scripts\utility::flag_set( "aud_maglev_train_path_disabled" );

    switch ( var_0 )
    {
        case 1:
            soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_maglev_trains" );
            soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_homestretch_bike_down1" );
            soundscripts\_snd_playsound::snd_play_delayed_linked( "det_exit_train1", 1.66 );
            soundscripts\_snd_playsound::snd_play_delayed_linked( "det_exit_train1_horn", 1.66 );
            soundscripts\_snd_playsound::snd_play_delayed_linked( "det_exit_train1_lfe", 2.06 );
            break;
        case 2:
            soundscripts\_snd_playsound::snd_play_delayed_linked( "det_exit_train2", 1.13 );
            soundscripts\_snd_playsound::snd_play_delayed_linked( "det_exit_train2_lfe", 2.13 );
            break;
        case 3:
            var_2 = ( -5636, 6974, 475 );
            thread exit_train_by_train3_loop( var_2 );
            thread exit_train_by_train3_whoosh( var_2 );
            soundscripts\_audio_mix_manager::mm_clear_submix( "det_exit_ride_homestretch_bike_down1", 15 );
            soundscripts\_audio_mix_manager::mm_add_submix( "det_exit_ride_homestretch_bike_down2", 15 );
            break;
    }
}

exit_train_by_train3_loop( var_0 )
{
    var_1 = "exit_train3_loop";
    var_2 = [ [ 540, 1.0 ], [ 1080, 0.1 ] ];
    var_3 = soundscripts\_snd::snd_map( distance2d( level.player.origin, var_0 ), var_2 );
    wait 2.13;
    var_4 = soundscripts\_snd_playsound::snd_play_loop_at( "det_exit_train3_bart", var_0, var_1, 0.5, 1, var_3 );
    var_5 = soundscripts\_snd_playsound::snd_play_loop_at( "det_exit_train3_hum", var_0, var_1, 0.5, 1, var_3 );
    var_6 = soundscripts\_snd_playsound::snd_play_loop_at( "det_exit_train3_lfe", var_0, var_1, 0.5, 1, var_3 );
    var_7 = 100000;
    var_8 = distance2d( level.player.origin, var_0 );

    for ( var_9 = var_7 - var_8 > 0; var_9; var_9 = var_7 - var_8 > 0 )
    {
        var_3 = soundscripts\_snd::snd_map( var_8, var_2 );
        var_4 scalevolume( var_3 );
        var_5 scalevolume( var_3 );
        var_6 scalevolume( var_3 );
        wait 0.1;
        var_7 = var_8;
        var_8 = distance2d( level.player.origin, var_0 );
    }

    level notify( var_1 );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "det_exit_ride_maglev_trains" );
}

exit_train_by_train3_whoosh( var_0 )
{
    var_1 = 100000;
    var_2 = distance2d( level.player.origin, var_0 );
    var_3 = var_1 - var_2 > 0;

    while ( var_3 )
    {
        wait 0.1;
        var_1 = var_2;
        var_2 = distance2d( level.player.origin, var_0 );
        var_3 = var_1 - var_2 > 0;

        if ( var_2 < 200 )
            break;
    }

    soundscripts\_snd_playsound::snd_play_at( "det_exit_train3_whoosh", level.player.origin );
}

exit_drive_ending_begin()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "det_final_cinematic" );
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_bike_approach" );
}

setup_ending_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_outro" ) )
        level waittill( "tff_post_remove_hospital_add_exit" );

    maps\_anim::addnotetrack_customfunction( "player_bike", "ending_player_bike_braking", ::ending_player_bike_braking, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "joker_bike", "ending_joker_bike_flyby", ::ending_joker_bike_flyby, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "bones_bike", "ending_bones_bike_flyby", ::ending_bones_bike_flyby, "det_exit_drive_ending" );
}

ending_player_bike_braking( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_plr_bike_braking" );
    music( "mus_end_exit_drive" );
}

ending_joker_bike_flyby( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_squad_bikes_fly_by" );
}

ending_bones_bike_flyby( var_0 )
{

}

setup_chopper_crash_anims()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_outro" ) )
        level waittill( "tff_post_remove_hospital_add_exit" );

    maps\_anim::addnotetrack_customfunction( "littlebird", "det_end_chopper_approach", ::det_end_chopper_approach, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "littlebird", "det_end_chopper_crash_start", ::det_end_chopper_crash_start, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "littlebird", "det_end_chopper_tumble", ::det_end_chopper_tumble, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "littlebird", "det_end_chopper_tumble_2", ::det_end_chopper_tumble_2, "det_exit_drive_ending" );
}

det_end_chopper_approach( var_0 )
{

}

det_end_chopper_crash_start( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_heli_initial_explo" );
}

det_end_chopper_tumble( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_heli_tumble1" );
}

det_end_chopper_tumble_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_heli_tumble2" );
    music( "mus_det_ending_win" );
}

chopper_final_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "det_ending_heli_big_explo" );
}

setup_end_gate()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "_outro" ) )
        level waittill( "tff_post_remove_hospital_add_exit" );

    maps\_anim::addnotetrack_customfunction( "gate", "det_end_gate_close", ::det_end_gate_close, "det_exit_drive_ending" );
}

det_end_gate_close( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "det_ending_big_gate_close", 0.0 );
}

det_gl_end_logo()
{
    soundscripts\_snd_playsound::snd_play_2d( "det_gl_end_logo" );
    soundscripts\_audio_mix_manager::mm_add_submix( "det_gl_end_logo" );
}

e3_demo_fade_out()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

e3_demo_fade_in()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 0.05;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 2.0 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "alley_combat_trains_off" );
}

e3_demo_clear_basement_footsteps()
{
    level.aud.in_basement = 0;
}

aud_det_foley_override_handler()
{
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "foley", var_0, var_1, var_2 );

        switch ( var_0 )
        {
            case "stationarycrouchscuff":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_scuff" );

                break;
            case "stationaryscuff":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_scuff" );

                break;
            case "crouchscuff":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_scuff" );

                break;
            case "runscuff":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_scuff" );

                break;
            case "sprintscuff":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_scuff" );

                break;
            case "prone":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_prone_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_prone_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_r" );
                }

                break;
            case "crouchwalk":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_walk_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_r" );
                }

                break;
            case "crouchrun":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_run_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_run_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_r" );
                }

                break;
            case "walk":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_walk_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_walk_r" );
                }

                break;
            case "run":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_run_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_run_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_run_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_run_r" );
                }

                break;
            case "sprint":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_sprint_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_sprint_r" );
                }
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_sprint_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_sprint_r" );
                }

                break;
            case "jump":
                break;
            case "lightland":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_land_lt" );
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_land_lt" );

                break;
            case "mediumland":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_land_med" );
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_land_med" );

                break;
            case "heavyland":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_land_hv" );
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_land_hv" );

                break;
            case "damageland":
                if ( isdefined( level.aud.in_school ) && level.aud.in_school == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_school_plr_land_hv_dam" );
                else if ( isdefined( level.aud.in_basement ) && level.aud.in_basement == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "fs_det_bsmt_wtr_plr_land_hv_dam" );

                break;
            case "mantleuphigh":
                break;
            case "mantleupmedium":
                break;
            case "mantleuplow":
                break;
            case "mantleoverhigh":
                break;
            case "mantleovermedium":
                break;
            case "mantleoverlow":
                break;
        }
    }
}
