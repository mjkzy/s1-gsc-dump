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
    soundscripts\_snd::snd_register_message( "start_seoul_intro", ::start_seoul_intro );
    soundscripts\_snd::snd_register_message( "start_seoul_first_land_assist", ::start_seoul_first_land_assist );
    soundscripts\_snd::snd_register_message( "start_seoul_enemy_encounter_01", ::start_seoul_enemy_encounter_01 );
    soundscripts\_snd::snd_register_message( "start_seoul_missle_evade_sequence", ::start_seoul_missle_evade_sequence );
    soundscripts\_snd::snd_register_message( "start_seoul_forward_operating_base", ::start_seoul_forward_operating_base );
    soundscripts\_snd::snd_register_message( "start_seoul_drone_swarm_intro", ::start_seoul_drone_swarm_intro );
    soundscripts\_snd::snd_register_message( "start_seoul_truck_push", ::start_seoul_truck_push );
    soundscripts\_snd::snd_register_message( "start_seoul_hotel_entrance", ::start_seoul_hotel_entrance );
    soundscripts\_snd::snd_register_message( "start_seoul_building_jump_sequence", ::start_seoul_building_jump_sequence );
    soundscripts\_snd::snd_register_message( "start_seoul_sinkhole_start", ::start_seoul_sinkhole_start );
    soundscripts\_snd::snd_register_message( "start_seoul_subway_start", ::start_seoul_subway_start );
    soundscripts\_snd::snd_register_message( "start_seoul_shopping_district_start", ::start_seoul_shopping_district_start );
    soundscripts\_snd::snd_register_message( "start_seoul_shopping_district_flee_swarm", ::start_seoul_shopping_district_flee_swarm );
    soundscripts\_snd::snd_register_message( "start_seoul_canal_intro", ::start_seoul_canal_intro );
    soundscripts\_snd::snd_register_message( "start_seoul_canal_combat_start", ::start_seoul_canal_combat_start );
    soundscripts\_snd::snd_register_message( "start_seoul_canal_combat_pt2", ::start_seoul_canal_combat_pt2 );
    soundscripts\_snd::snd_register_message( "start_seoul_finale_scene_start", ::start_seoul_finale_scene_start );
    soundscripts\_snd::snd_register_message( "start_seoul_e3_presentation", ::start_seoul_e3_presentation );
    soundscripts\_snd::snd_register_message( "start_seoul_cover_art", ::start_seoul_cover_art );
    soundscripts\_snd::snd_register_message( "dialogue_droppod_intro_prelaunch", ::dialogue_droppod_intro_prelaunch );
    soundscripts\_snd::snd_register_message( "pod_phase1a_start", ::pod_phase1a_start );
    soundscripts\_snd::snd_register_message( "droppod_intro_radio_duck", ::droppod_intro_radio_duck );
    soundscripts\_snd::snd_register_message( "droppod_intro_blimp_missile", ::droppod_intro_blimp_missile );
    soundscripts\_snd::snd_register_message( "droppod_intro_blimp_explode", ::droppod_intro_blimp_explode );
    soundscripts\_snd::snd_register_message( "droppod_main_pod_jets", ::droppod_main_pod_jets );
    soundscripts\_snd::snd_register_message( "droppod_phase_2b_begin", ::droppod_phase_2b_begin );
    soundscripts\_snd::snd_register_message( "droppod_first_building_impact", ::droppod_first_building_impact );
    soundscripts\_snd::snd_register_message( "droppod_final_impact", ::droppod_final_impact );
    soundscripts\_snd::snd_register_message( "droppod_harness_left_1", ::droppod_harness_left_1 );
    soundscripts\_snd::snd_register_message( "droppod_harness_left_2", ::droppod_harness_left_2 );
    soundscripts\_snd::snd_register_message( "droppod_harness_right_1", ::droppod_harness_right_1 );
    soundscripts\_snd::snd_register_message( "droppod_harness_right_2", ::droppod_harness_right_2 );
    soundscripts\_snd::snd_register_message( "seo_vista_amb_explos", ::seo_vista_amb_explos );
    soundscripts\_snd::snd_register_message( "midair_exp_audio", ::midair_exp_audio );
    soundscripts\_snd::snd_register_message( "midair_exp_glass", ::midair_exp_glass );
    soundscripts\_snd::snd_register_message( "vista_rockets", ::vista_rockets );
    soundscripts\_snd::snd_register_message( "vista_rockets_first_impact", ::vista_rockets_first_impact );
    soundscripts\_snd::snd_register_message( "vista_rockets_pod_door_view_01", ::vista_rockets_pod_door_view_01 );
    soundscripts\_snd::snd_register_message( "vista_rockets_pod_door_view_02", ::vista_rockets_pod_door_view_02 );
    soundscripts\_snd::snd_register_message( "seo_dirt_explosions", ::seo_dirt_explosions );
    soundscripts\_snd::snd_register_message( "seo_fireball_explosions", ::seo_fireball_explosions );
    soundscripts\_snd::snd_register_message( "seo_ambient_ground_explosions", ::seo_ambient_ground_explosions );
    soundscripts\_snd::snd_register_message( "aud_handle_vista_jets", ::aud_handle_vista_jets );
    soundscripts\_snd::snd_register_message( "seo_vista_bombing_run", ::seo_vista_bombing_run );
    soundscripts\_snd::snd_register_message( "hotel_razorback_fly_by", ::hotel_razorback_fly_by );
    soundscripts\_snd::snd_register_message( "seo_intro_patrol_drones", ::seo_intro_patrol_drones );
    soundscripts\_snd::snd_register_message( "missiles_strike_building", ::missiles_strike_building );
    soundscripts\_snd::snd_register_message( "missiles_strike_explo", ::missiles_strike_explo );
    soundscripts\_snd::snd_register_message( "shockwave_begin", ::shockwave_begin );
    soundscripts\_snd::snd_register_message( "hotel_windows_explode", ::hotel_windows_explode );
    soundscripts\_snd::snd_register_message( "seo_fob_tank_procedural", ::seo_fob_tank_procedural );
    soundscripts\_snd::snd_register_message( "seo_fob_tank_01", ::seo_fob_tank_01 );
    soundscripts\_snd::snd_register_message( "seo_fob_tank_02", ::seo_fob_tank_02 );
    soundscripts\_snd::snd_register_message( "seo_fob_tank_03", ::seo_fob_tank_03 );
    soundscripts\_snd::snd_register_message( "seo_fob_initial_razorback", ::seo_fob_initial_razorback );
    soundscripts\_snd::snd_register_message( "seo_fob_fake_jet_flyby", ::seo_fob_fake_jet_flyby );
    soundscripts\_snd::snd_register_message( "seo_fob_razorback_01", ::seo_fob_razorback_01 );
    soundscripts\_snd::snd_register_message( "seo_fob_razorback_02", ::seo_fob_razorback_02 );
    soundscripts\_snd::snd_register_message( "sidewinder_missile", ::sidewinder_missile );
    soundscripts\_snd::snd_register_message( "aud_handle_gangam_jets", ::aud_handle_gangam_jets );
    soundscripts\_snd::snd_register_message( "fob_meetup_vo", ::fob_meetup_vo );
    soundscripts\_snd::snd_register_message( "walker_step_over", ::walker_step_over );
    soundscripts\_snd::snd_register_message( "titan_walker_weapon_fire", ::titan_walker_weapon_fire );
    soundscripts\_snd::snd_register_message( "titan_walker_explo", ::titan_walker_explo );
    soundscripts\_snd::snd_register_message( "seo_big_car_explo", ::seo_big_car_explo );
    soundscripts\_snd::snd_register_message( "seo_truck_explo", ::seo_truck_explo );
    soundscripts\_snd::snd_register_message( "start_drone_barrage_submix", ::start_drone_barrage_submix );
    soundscripts\_snd::snd_register_message( "seo_single_drones_flyby", ::seo_single_drones_flyby );
    soundscripts\_snd::snd_register_message( "seo_drone_missile", ::seo_drone_missile );
    soundscripts\_snd::snd_register_message( "seo_drone_missile_impact", ::seo_drone_missile_impact );
    soundscripts\_snd::snd_register_message( "seo_will_car_door_explo", ::seo_will_car_door_explo );
    soundscripts\_snd::snd_register_message( "seo_start_drone_submix", ::seo_start_drone_submix );
    soundscripts\_snd::snd_register_message( "drone_kamikaze_hit_player", ::drone_kamikaze_hit_player );
    soundscripts\_snd::snd_register_message( "car_door_broken", ::car_door_broken );
    soundscripts\_snd::snd_register_message( "player_enter_walker_anim", ::player_enter_walker_anim );
    soundscripts\_snd::snd_register_message( "cherry_picker_target_add", ::cherry_picker_target_add );
    soundscripts\_snd::snd_register_message( "cherry_picker_target_remove", ::cherry_picker_target_remove );
    soundscripts\_snd::snd_register_message( "player_exit_walker_anim", ::player_exit_walker_anim );
    soundscripts\_snd::snd_register_message( "seo_swarm_emp_wave", ::seo_swarm_emp_wave );
    soundscripts\_snd::snd_register_message( "seo_swarm_die", ::seo_swarm_die );
    soundscripts\_snd::snd_register_message( "seo_video_log_start", ::seo_video_log_start );
    soundscripts\_snd::snd_register_message( "seo_hotel_ent_wp_takeoff", ::seo_hotel_ent_wp_takeoff );
    soundscripts\_snd::snd_register_message( "seo_zipline_harpoon_fire", ::seo_zipline_harpoon_fire );
    soundscripts\_snd::snd_register_message( "seo_zipline_harpoon_impact", ::seo_zipline_harpoon_impact );
    soundscripts\_snd::snd_register_message( "seo_zipline_rappel_begin", ::seo_zipline_rappel_begin );
    soundscripts\_snd::snd_register_message( "seo_zipline_rappel_land", ::seo_zipline_rappel_land );
    soundscripts\_snd::snd_register_message( "seo_zipline_retract_rope", ::seo_zipline_retract_rope );
    soundscripts\_snd::snd_register_message( "seo_per_arts_jump_explo_3", ::seo_per_arts_jump_explo_3 );
    soundscripts\_snd::snd_register_message( "sinkhole_drones_start", ::sinkhole_drones_start );
    soundscripts\_snd::snd_register_message( "seo_sinkhole_wp_flyby", ::seo_sinkhole_wp_flyby );
    soundscripts\_snd::snd_register_message( "sinkhole_truck_fall", ::sinkhole_truck_fall );
    soundscripts\_snd::snd_register_message( "sinkhole_truck_explode", ::sinkhole_truck_explode );
    soundscripts\_snd::snd_register_message( "subway_bomb_shake", ::subway_bomb_shake );
    soundscripts\_snd::snd_register_message( "subway_doors_opening", ::subway_doors_opening );
    soundscripts\_snd::snd_register_message( "subway_doors_closing", ::subway_doors_closing );
    soundscripts\_snd::snd_register_message( "subway_gate_triggered", ::subway_gate_triggered );
    soundscripts\_snd::snd_register_message( "seo_meet_atlas_slowmo_start", ::seo_meet_atlas_slowmo_start );
    soundscripts\_snd::snd_register_message( "seo_meet_atlas_slowmo_end", ::seo_meet_atlas_slowmo_end );
    soundscripts\_snd::snd_register_message( "subway_gate_atlas_meetup_close", ::subway_gate_atlas_meetup_close );
    soundscripts\_snd::snd_register_message( "sd_intersection_chopper", ::sd_intersection_chopper );
    soundscripts\_snd::snd_register_message( "shopping_district_turret_truck", ::shopping_district_turret_truck );
    soundscripts\_snd::snd_register_message( "vo_sd_demo_team_call", ::vo_sd_demo_team_call );
    soundscripts\_snd::snd_register_message( "seo_smoke_grenade_ambush", ::seo_smoke_grenade_ambush );
    soundscripts\_snd::snd_register_message( "shopping_district_glass_smashed", ::shopping_district_glass_smashed );
    soundscripts\_snd::snd_register_message( "shopping_district_glass_hit_after_smashed", ::shopping_district_glass_hit_after_smashed );
    soundscripts\_snd::snd_register_message( "shopping_district_panel_smashed", ::shopping_district_panel_smashed );
    soundscripts\_snd::snd_register_message( "shopping_district_panel_swing", ::shopping_district_panel_swing );
    soundscripts\_snd::snd_register_message( "seo_binocs_equip", ::seo_binocs_equip );
    soundscripts\_snd::snd_register_message( "canal_binocs_zoom_in", ::canal_binocs_zoom_in );
    soundscripts\_snd::snd_register_message( "canal_binocs_zoom_out", ::canal_binocs_zoom_out );
    soundscripts\_snd::snd_register_message( "canal_binocs_stop_zoom_in", ::canal_binocs_stop_zoom_in );
    soundscripts\_snd::snd_register_message( "canal_binocs_stop_zoom_out", ::canal_binocs_stop_zoom_out );
    soundscripts\_snd::snd_register_message( "binocs_put_away", ::binocs_put_away );
    soundscripts\_snd::snd_register_message( "canal_jet_flyover", ::canal_jet_flyover );
    soundscripts\_snd::snd_register_message( "seo_canal_razorback", ::seo_canal_razorback );
    soundscripts\_snd::snd_register_message( "razorback_fire_start", ::razorback_fire_start );
    soundscripts\_snd::snd_register_message( "razorback_fire_stop", ::razorback_fire_stop );
    soundscripts\_snd::snd_register_message( "havoc_missile_launch", ::havoc_missile_launch );
    soundscripts\_snd::snd_register_message( "seo_canal_heli_attacked", ::seo_canal_heli_attacked );
    soundscripts\_snd::snd_register_message( "timed_charges_vo", ::timed_charges_vo );
    soundscripts\_snd::snd_register_message( "seo_finale_start", ::seo_finale_start );
    soundscripts\_snd::snd_register_message( "seo_finale_wp_init_explo", ::seo_finale_wp_init_explo );
    soundscripts\_snd::snd_register_message( "seo_finale_wp_wing_explo", ::seo_finale_wp_wing_explo );
    soundscripts\_snd::snd_register_message( "seo_finale_wp_belly_explo", ::seo_finale_wp_belly_explo );
    soundscripts\_snd::snd_register_message( "seo_finale_wp_big_explo", ::seo_finale_wp_big_explo );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_out", ::e3_demo_fade_out );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_in", ::e3_demo_fade_in );
    soundscripts\_snd::snd_register_message( "e3_end_logo", ::e3_end_logo );
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seoul_global_mix" );
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "start_subway_pa_message" );
}

init_globals()
{
    level.aud.heli = 0;
    level.aud.havoc = 0;
    level.aud.in_turret = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread setup_droppod_intro_anims();
    thread setup_pod_exit_anims();
    thread setup_land_assist_jump_anims();
    thread setup_fall_cloth_floey();
    thread setup_hotel_exo_punch_breach_anims();
    thread fob_pod_anims();
    thread setup_doorshield_anims();
    thread setup_mall_sizeup_anims();
    thread subway_pa_message();
    thread setup_finale_anims();
    thread seoul_foley_override_handler();
}

launch_loops()
{
    thread launch_intro_building_descend_fob_loops();
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 32238, 6710, 1338 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 31873, 6752, 1414 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 31873, 6752, 1414 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 32068, 7084, 1460 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 31807, 7054, 1383 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 31634, 7290, 1420 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 31420, 7689, 1520 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 31418, 7998, 1742 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 31418, 7998, 1742 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 31418, 7998, 1742 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 30905, 7540, 1353 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 30921, 8161, 1430 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 30808, 7442, 1338 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 30828, 7187, 1386 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 30612, 7216, 1340 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 29861, 7601, 1315 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 29132, 7638, 1331 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 28990, 7701, 1331 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 28998, 7240, 1329 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 28449, 6820, 1330 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 28398, 6540, 1331 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 28334, 6422, 1373 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 28726, 6594, 1366 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 28258, 6904, 1296 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 27979, 6930, 1328 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 28186, 7205, 1296 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 28784, 7511, 1324 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 28327, 7558, 1325 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 28210, 7758, 1329 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 28116, 7669, 1324 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 28020, 7693, 1325 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 27862, 7733, 1327 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 27913, 7439, 1317 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 28270, 8013, 1430 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 28270, 8013, 1430 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 30844, 7203, 1392 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 29183, 7679, 1343 ), "stop_fire_emitters" );
    thread launch_truck_puch_trans_loops();
    thread launch_mall_offices_loops();
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 27090, 9374, 1367 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 26840, 9404, 1452 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 25151, 13047, 1561 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 25119, 13093, 1554 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 25419, 13932, 1768 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 25173, 13935, 1894 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 25410, 14107, 1606 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 25177, 14136, 1586 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 24827, 15336, 1772 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 24603, 15340, 1103 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 24908, 14815, 1146 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 24462, 13943, 1091 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 24426, 13850, 1103 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 24136, 14095, 1093 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 23342, 13696, 1309 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 22859, 13905, 1332 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 23273, 13938, 832 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 22982, 15887, 928 ), "stop_fire_emitters" );
    thread launch_sinkhole_subway_loops();
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 32238, 6710, 1338 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 32068, 7084, 1460 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 31873, 6752, 1414 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 31873, 6752, 1414 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 28186, 7205, 1296 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 14625, 19881, 1319 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 13295, 20327, 1319 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 14447, 19465, 1327 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 14735, 19251, 1319 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 14500, 19031, 1319 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 13367, 17818, 1319 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 13312, 20757, 1315 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 13587, 20890, 1327 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 13514, 20914, 1349 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 13514, 20914, 1349 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 13731, 20562, 1227 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 14102, 21629, 1296 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 14102, 21629, 1296 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 13875, 21989, 1309 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 13875, 21989, 1309 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 14302, 21252, 1201 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 14879, 19029, 1360 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 14021, 21051, 1255 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 13841, 21951, 1255 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 14324, 20269, 1215 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 14345, 19858, 1215 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 13776, 19377, 1215 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 14318, 18955, 1215 ), "stop_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 13720, 18688, 1215 ), "stop_fire_emitters" );
    thread launch_riverwalk_loops();
}

launch_intro_building_descend_fob_loops()
{
    if ( level.currentgen && ( !_func_21E( "seoul_intro_building_descend_tr" ) || !_func_21E( "seoul_fob_tr" ) ) )
        level common_scripts\utility::waittill_any( "transients_intro", "transients_intro_to_fob" );

    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium_intro", ( 36063, 10603, 4356 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 36003, 10603, 4368 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 36128, 10167, 4384 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35950, 10251, 4508 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 36033, 10271, 4508 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large_intro", ( 36003, 10510, 4512 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35350, 9559, 4388 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 35695, 10575, 4381 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35353, 9560, 4388 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35014, 9674, 4384 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 34950, 9604, 4406 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium_intro", ( 34950, 9604, 4406 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 34860, 9096, 3812 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 34858, 9323, 4184 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 34893, 9243, 4150 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 34794, 3993, 3976 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 34860, 9088, 3821 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 34738, 9053, 3810 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 34692, 8995, 3832 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 34738, 9053, 3810 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 35575, 8609, 3635 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 35575, 8609, 3635 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 35276, 8668, 3603 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 35278, 8473, 3626 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 35229, 8631, 3468 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 35664, 8568, 3468 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 35563, 8693, 3416 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small", ( 35539, 8427, 3434 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 35323, 8508, 3228 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium_intro", ( 35323, 8508, 3228 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger", ( 35349, 8632, 3083 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large_intro", ( 35785, 8692, 3068 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium", ( 35785, 8692, 3068 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 35353, 8617, 3068 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 35602, 9027, 1447 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_medium_intro", ( 35602, 9027, 1447 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large", ( 35376, 9090, 1361 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_larger_intro", ( 34794, 8918, 1425 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 34960, 8434, 1379 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 34575, 8477, 1375 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35689, 9150, 1409 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35507, 9218, 1399 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_small_intro", ( 35522, 8782, 1438 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_fire_large_intro", ( 35369, 9071, 1368 ), "stop_intro_fire_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_wind", ( 36312, 10538, 4400 ), "stop_wind_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_wind", ( 35377, 9209, 4553 ), "stop_wind_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_wind", ( 35377, 9209, 4553 ), "stop_wind_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_wind", ( 35378, 9133, 2313 ), "stop_wind_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_combat_high_01", ( 36182, 10530, 4330 ), "stop_combat_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_combat_high_02", ( 36182, 10530, 4330 ), "stop_combat_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_combat_high_03", ( 36182, 10530, 4330 ), "stop_combat_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_int_combat_jets_bombs", ( 36182, 10530, 4330 ), "stop_combat_emitters" );

    if ( level.currentgen )
    {
        level waittill( "pre_transients_drone_seq_one_to_trusk_push" );
        level notify( "stop_intro_fire_emitters" );
        level notify( "stop_wind_emitters" );
        level notify( "stop_combat_emitters" );
    }
}

launch_truck_puch_trans_loops()
{
    if ( level.currentgen && !_func_21E( "seoul_truck_push_trans_tr" ) )
        level waittill( "transients_drone_seq_one_to_truck_push" );

    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 25201, 11941, 1833 ), "stop_mall_electronic_emitters" );

    if ( level.currentgen )
    {
        level waittill( "pre_transients_mall_office_to_sinkhole_subway" );
        level notify( "stop_mall_electronic_emitters" );
    }
}

launch_mall_offices_loops()
{
    if ( level.currentgen && !_func_21E( "seoul_mall_offices_tr" ) )
        level waittill( "transients_truck_push_to_mall_office" );

    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_steam", ( 25231, 14575, 1764 ), "stop_steam_emitters" );

    if ( level.currentgen )
    {
        level waittill( "pre_transients_sinkhole_subway_to_subway" );
        level notify( "stop_steam_emitters" );
    }
}

launch_sinkhole_subway_loops()
{
    if ( level.currentgen && !_func_21E( "seoul_sinkhole_subway_tr" ) )
        level waittill( "transients_mall_office_to_sinkhole_subway" );

    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 22118, 15809, 920 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 22449, 16358, 1161 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 22446, 16602, 1161 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 22173, 17055, 1208 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 21729, 16646, 1125 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 20744, 16357, 1161 ), "stop_subway_electronic_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_smartglass_glitchy", ( 21029, 16972, 1120 ), "stop_subway_electronic_emitters" );

    if ( level.currentgen )
    {
        level waittill( "pre_transients_subway_to_shopping_dist" );
        level notify( "stop_subway_electronic_emitters" );
    }
}

launch_riverwalk_loops()
{
    if ( level.currentgen && !_func_21E( "seoul_riverwalk_tr" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_fountain", ( 14237, 17799, 1338 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_fountain", ( 13886, 17782, 1338 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_fountain", ( 14029, 17786, 1338 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_sml", ( 14257, 17889, 1312 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_sml", ( 13828, 17896, 1312 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_sml", ( 14042, 17895, 1312 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_lrg", ( 14257, 17889, 1298 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_lrg", ( 13828, 17896, 1298 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_lrg", ( 14037, 17981, 1298 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_ground", ( 14257, 17889, 1191 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_ground", ( 13828, 17896, 1191 ), "stop_water_emitters" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_seo_waterfall_ground", ( 14016, 17989, 1191 ), "stop_water_emitters" );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
    level.aud.envs["havoc_speed_of_sound"] = [ [ 500, 0.0 ], [ 750, 0.05 ], [ 1500, 0.1 ], [ 2000, 0.15 ], [ 2500, 0.2 ], [ 3000, 0.25 ], [ 3500, 0.3 ], [ 4000, 0.35 ], [ 4200, 0.4 ], [ 4500, 0.45 ], [ 5000, 0.5 ], [ 6000, 1.0 ] ];
    level.aud.envs["player_fall_foley"] = [ [ 499, 0.0 ], [ 500, 0.2 ], [ 600, 0.4 ], [ 800, 0.6 ], [ 1400, 1.0 ] ];
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
        case "enter_ext_crashshite":
            if ( var_2 == "int_crashsite" )
            {
                level.aud.wood_debris = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "seo_foley_override" );
            }

            break;
        case "exit_ext_crashsite":
            if ( var_3 == "int_crashsite" )
            {
                level.aud.wood_debris = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "seo_foley_override" );
            }

            break;
        case "exit_int_crashsite":
            if ( var_3 == "ext_crashsite" )
            {
                level.aud.wood_debris = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "seo_foley_override" );
            }

            break;
        case "enter_int_crashsite":
            if ( var_2 == "ext_crashsite" )
            {
                level.aud.wood_debris = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "seo_foley_override" );
            }

            break;
        case "enter_int_bedroom":
            if ( var_2 == "ext_crashsite" )
            {
                level.aud.wood_debris = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "seo_foley_override" );
            }

            break;
        case "exit_int_bedroom":
            if ( var_3 == "ext_crashsite" )
            {
                level.aud.wood_debris = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "seo_foley_override" );
            }

            break;
        case "enter_int_mall":
            if ( var_1 == "ext_post_drone_swarm_alley" )
                music( "enter_int_mall" );

            break;
        case "exit_ext_building_jump_01":
            if ( var_1 == "ext_building_jump_01" )
            {

            }

            break;
        case "exit_ext_shopping_district":
            if ( var_1 == "ext_shopping_district" )
            {
                if ( !isdefined( level.aud.mus_exit_subway ) )
                {
                    level.aud.mus_exit_subway = 1;
                    music( "exit_subway" );
                }
            }

            break;
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
    var_2 = 1.0;

    switch ( var_0 )
    {
        case "mus_podcrash_done":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            soundscripts\_audio_music::mus_play( "seo_mus_stealth_01", 4 );
            level waittill( "pod_deform" );
            wait 2.25;
            soundscripts\_audio::aud_set_music_submix( var_2 * 1.9, 0 );
            soundscripts\_audio_music::mus_play( "seo_mus_droppod_vista_stinger", 0, 1 );
            common_scripts\utility::flag_wait( "vo_hotel_top_floor_ended" );
            soundscripts\_audio::aud_set_music_submix( var_2, 8 );
            soundscripts\_audio_music::mus_play( "seo_mus_stealth_01", 8, 8 );
            common_scripts\utility::flag_wait( "player_landed_in_hotel" );
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            soundscripts\_audio_music::mus_stop( 2 );
            wait 1.0;
            var_3 = "npc_droppod_landing";
            var_4 = "stop_hotel_music_flag";
            common_scripts\utility::flag_init( var_4 );
            thread handle_stop_hotel_music_flag( var_3, var_4 );
            thread play_hotel_exit_adaptive_music( var_4 );
            break;
        case "mus_seo_swarm_emp_wave_done":
            wait 1;
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.75, 0 );
            soundscripts\_audio_music::mus_play( "seo_mus_firefight1_intro", 8 );
            break;
        case "enter_int_mall":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            soundscripts\_snd_common::snd_wait_for_enemies_see_player();
            soundscripts\_audio_music::mus_play( "seo_mus_firefight1_body", 1 );
            break;
        case "exit_int_mall":
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.5, 3 );
            soundscripts\_audio_music::mus_play( "seo_mus_firefight1_outro", 1 );
            break;
        case "dialogue_atlas_meetup_done":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            soundscripts\_audio_music::mus_play( "seo_mus_firefight2_intro", 1 );
            break;
        case "exit_subway":
            thread soundscripts\_snd_common::snd_wait_for_enemies_aware( "audio_enemies_aware" );
            level waittill( "audio_enemies_aware" );
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            soundscripts\_audio_music::mus_play( "seo_mus_firefight2_body", 1 );
            break;
        case "mus_sd_firefight_ending":
            soundscripts\_audio_music::mus_play( "seo_mus_firefight2_outtro", 1 );
            break;
        case "mus_canal_action_begin":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );

            if ( !isdefined( var_1 ) )
                var_1 = 0;

            wait(var_1);
            soundscripts\_audio_music::mus_play( "seo_mus_canal_intro" );
            break;
        case "mus_canal_swarm_chasing_off_razorback":
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.5 );
            soundscripts\_audio_music::mus_play( "seo_mus_canal_vamp", 20 );
            break;
        case "mus_canal_combat_done":
            soundscripts\_audio::aud_set_music_submix( var_2 * 0.5 );
            soundscripts\_audio_music::mus_play( "seo_mus_canal_end", 0, 1 );
            wait 8;
            soundscripts\_audio::aud_set_music_submix( var_2 );
            soundscripts\_audio_music::mus_play( "seo_mus_stealth_01", 3 );
            break;
        case "mus_will_death_plant_charge_part2":
            soundscripts\_audio::aud_set_music_submix( var_2 * 1.3, 0 );
            wait 4;
            soundscripts\_audio_mix_manager::mm_add_submix( "seo_other_side_mix", 4.0 );
            wait 4.0;
            soundscripts\_audio_music::mus_play( "seo_mus_other_side", 0 );
            break;
        case "mus_finale_wp_explo_01":
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "mus_mitchels_arm":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            wait 8.0;
            soundscripts\_audio_music::mus_play( "seo_mus_mitchels_arm", 0 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

handle_stop_hotel_music_flag( var_0, var_1 )
{
    level waittill( "aud_npc_droppod_landing" );
    waitframe();
    level waittill( "aud_npc_droppod_landing" );
    wait 1.0;
    common_scripts\utility::flag_set( var_1 );
}

play_hotel_exit_adaptive_music( var_0 )
{
    var_1 = 36;
    var_2 = 559;
    var_3 = 0.1;
    var_4 = 1.25;
    var_5 = 0.1;
    var_6 = ( 34513, 8315, 1396 );
    var_7 = 0.5;
    var_8 = 1.0;
    var_9 = [ [ var_1, var_4 ], [ var_2, var_3 ] ];
    var_10 = [ [ var_1, var_8 ], [ var_2, var_7 ] ];
    var_11 = distance2d( level.player.origin, var_6 );
    var_12 = soundscripts\_snd::snd_map( var_11, var_9 );
    soundscripts\_audio::aud_set_music_submix( var_7, 0 );
    var_13 = "stop_hotel_exit_adaptive_music";
    var_14 = soundscripts\_snd_playsound::snd_play_loop_2d( "seo_mus_hotel_exit", var_13, 0, 1, 1.0 );
    var_15 = soundscripts\_snd_playsound::snd_play_loop_2d( "seo_mus_hotel_exit_lyr_gtr", var_13, 0, 1, var_12 );

    while ( !common_scripts\utility::flag( var_0 ) )
    {
        var_11 = distance2d( level.player.origin, var_6 );
        var_12 = soundscripts\_snd::snd_map( var_11, var_9 );
        var_15 _meth_806F( var_12, var_5 );
        var_16 = soundscripts\_snd::snd_map( var_11, var_10 );
        soundscripts\_audio::aud_set_music_submix( var_16, var_5 );
        wait(var_5);
    }

    wait 0.5;
    level notify( var_13 );
}

start_seoul_intro()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_pod" );
}

start_seoul_first_land_assist()
{
    level notify( "aud_listen_fall_foley" );
    soundscripts\_audio_zone_manager::azm_start_zone( "int_atrium" );
}

start_seoul_enemy_encounter_01()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_window_blowout_room" );
}

start_seoul_missle_evade_sequence()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_atrium" );
}

start_seoul_forward_operating_base()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_atrium" );
}

start_seoul_drone_swarm_intro()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_fob" );
}

start_seoul_truck_push()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_drone_swarm_street" );
    music( "mus_seo_swarm_emp_wave_done" );
}

start_seoul_hotel_entrance()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_post_drone_swarm_alley" );
    music( "mus_seo_swarm_emp_wave_done" );
}

start_seoul_building_jump_sequence()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_mall" );
}

start_seoul_sinkhole_start()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_building_jump_02" );
}

start_seoul_subway_start()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_subway_docking" );
}

start_seoul_shopping_district_start()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_subway" );
}

start_seoul_shopping_district_flee_swarm()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_shopping_district" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_vehicle_management" );
}

start_seoul_canal_intro()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_club" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_vehicle_management" );
}

start_seoul_canal_combat_start()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_club" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_combat", 0.05 );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_vehicle_management" );
}

start_seoul_canal_combat_pt2()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_club" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_combat", 0.05 );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_vehicle_management" );
}

start_seoul_finale_scene_start()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_canal" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_canal_combat", 0.05 );
}

start_seoul_e3_presentation()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_club" );
}

start_seoul_cover_art()
{

}

droppod_intro_radio_duck()
{
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "droppod_intro_radio_duck", 1.0 );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "droppod_intro_radio_duck", 1.0 );
}

setup_droppod_intro_anims()
{
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_start", ::seo_pod_enter_start, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_fs", ::seo_pod_enter_player_fs, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_lt_hand", ::seo_pod_enter_player_lt_hand, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_rt_hand", ::seo_pod_enter_player_rt_hand, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_lt_reach", ::seo_pod_enter_player_lt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_lt_pull", ::seo_pod_enter_player_lt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_rt_reach", ::seo_pod_enter_player_rt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_enter_player_rt_pull", ::seo_pod_enter_player_rt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_enter_will_fs", ::seo_pod_enter_will_fs, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_enter_will_lt_reach", ::seo_pod_enter_will_lt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_enter_will_lt_pull", ::seo_pod_enter_will_lt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_enter_will_rt_reach", ::seo_pod_enter_will_rt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_enter_will_rt_pull", ::seo_pod_enter_will_rt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_enter_cormack_fs", ::seo_pod_enter_cormack_fs, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_enter_cormack_rt_reach", ::seo_pod_enter_cormack_rt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_enter_cormack_rt_pull", ::seo_pod_enter_cormack_rt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_enter_cormack_lt_reach", ::seo_pod_enter_cormack_lt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_enter_cormack_lt_pull", ::seo_pod_enter_cormack_lt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_enter_jack_fs", ::seo_pod_enter_jack_fs, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_enter_jack_rt_reach", ::seo_pod_enter_jack_rt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_enter_jack_rt_pull", ::seo_pod_enter_jack_rt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_enter_jack_lt_reach", ::seo_pod_enter_jack_lt_reach, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_enter_jack_lt_pull", ::seo_pod_enter_jack_lt_pull, "pod_phase1a" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_launch_cam_shake", ::seo_pod_launch_cam_shake, "pod_phase1b" );
    maps\_anim::addnotetrack_customfunction( "droppod", "seo_pod_overhead_screen_start", ::seo_pod_overhead_screen_start, "pod_phase1b" );
    maps\_anim::addnotetrack_customfunction( "pod_missile_1", "aud_2b_missile1", ::aud_2b_missile1, "pod_phase2b" );
    maps\_anim::addnotetrack_customfunction( "pod_missile_2", "aud_2b_missile2", ::aud_2b_missile2, "pod_phase2b" );
    maps\_anim::addnotetrack_customfunction( "pod_missile_3", "aud_2b_missile3", ::aud_2b_missile3, "pod_phase2b" );
    maps\_anim::addnotetrack_customfunction( "pod_missile_final", "aud_2b_missile_final", ::aud_2b_missile_final, "pod_phase2b" );
    maps\_anim::addnotetrack_customfunction( "droppod", "seo_pod_phase3_door_pop", ::seo_pod_phase3_door_pop, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "droppod", "seo_pod_phase3_screen_boot", ::seo_pod_phase3_screen_boot, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_c", "seo_pod_phase3_seat_arm_up", ::seo_pod_phase3_seat_arm_up, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_c", "seo_pod_phase3_turn_lever", ::seo_pod_phase3_turn_lever, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_c", "seo_pod_phase3_seat_arm_down", ::seo_pod_phase3_seat_arm_down, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_c", "seo_pod_phase3_screen_down", ::seo_pod_phase3_screen_down, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_c", "seo_pod_phase3_screen_up", ::seo_pod_phase3_screen_up, "pod_phase3" );
    maps\_anim::addnotetrack_customfunction( "pod_seat_p", "seo_pod_phase3_vm_seat_arm_up", ::seo_pod_phase3_vm_seat_arm_up, "pod_phase3" );
}

dialogue_droppod_intro_prelaunch()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "intro_droppod_seq" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_getin_idle_fronts" );
}

pod_phase1a_start()
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_getin_footsteps" );
    soundscripts\_snd::snd_slate( "pod_phase1a_start" );
}

seo_pod_enter_start( var_0 )
{

}

seo_pod_enter_player_fs( var_0 )
{

}

seo_pod_enter_player_lt_hand( var_0 )
{

}

seo_pod_enter_player_rt_hand( var_0 )
{

}

seo_pod_enter_player_lt_reach( var_0 )
{

}

seo_pod_enter_player_lt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_player_lt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_plr_left" );
}

seo_pod_enter_player_rt_reach( var_0 )
{

}

seo_pod_enter_player_rt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_player_rt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_plr_right" );
}

seo_pod_enter_will_fs( var_0 )
{

}

seo_pod_enter_will_lt_reach( var_0 )
{

}

seo_pod_enter_will_lt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_will_lt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_will_left" );
}

seo_pod_enter_will_rt_reach( var_0 )
{

}

seo_pod_enter_will_rt_pull( var_0 )
{

}

seo_pod_enter_cormack_fs( var_0 )
{

}

seo_pod_enter_cormack_rt_reach( var_0 )
{

}

seo_pod_enter_cormack_rt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_cormack_rt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_cormack_right" );
}

seo_pod_enter_cormack_lt_reach( var_0 )
{

}

seo_pod_enter_cormack_lt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_cormack_lt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_cormack_left" );
}

seo_pod_enter_jack_fs( var_0 )
{

}

seo_pod_enter_jack_lt_reach( var_0 )
{

}

seo_pod_enter_jack_lt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_jack_lt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_jack_left" );
}

seo_pod_enter_jack_rt_reach( var_0 )
{

}

seo_pod_enter_jack_rt_pull( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_enter_jack_rt_pull" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_buckle_jack_right" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_start_apu", 1.386 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_start_engines_fronts", 6.891 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_start_engines_fire_a", 12.709 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_launch_subsonic", 14.546 );
}

seo_pod_launch_cam_shake( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_launch_cam_shake" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_launch_jet_burst" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_launch_detatch_hi", 0.456 );
}

seo_pod_overhead_screen_start( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_pod_overhead_screen_start" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_overhead_screen_start" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_launch_radio_a", 1.693 );
}

droppod_intro_blimp_missile()
{
    soundscripts\_snd::snd_slate( "droppod_intro_blimp_missile" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_blimp_missile" );
}

droppod_intro_blimp_explode()
{
    soundscripts\_snd::snd_slate( "droppod_intro_blimp_explode" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_blimp_explode" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_blimp_second_explo_a", 1.6 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_hull_debris_fronts", 1.8 );
}

droppod_main_pod_jets()
{
    soundscripts\_snd::snd_slate( "droppod_main_pod_jets" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_main_pod_jets" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_pod_flyby", 2.137 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "droppod_intro_launch_radio_b", 3.756 );
}

droppod_phase_2b_begin()
{
    soundscripts\_snd::snd_slate( "droppod_phase_2b_begin" );
    thread droppod_intro_missile_hit_pod();
    soundscripts\_snd_playsound::snd_play_2d( "droppod_intro_phase_2b_bump_fronts" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_engines_begining_fronts" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_rattles_begining_fronts" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_anti_aircraft_booms" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_rocket_flybys" );
}

aud_2b_missile1( var_0 )
{

}

aud_2b_missile2( var_0 )
{

}

aud_2b_missile3( var_0 )
{

}

aud_2b_missile_final( var_0 )
{

}

droppod_intro_missile_hit_pod()
{
    level waittill( "intro_missile_hit_pod" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_main" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_alarms" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_door_fire" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_engines_fronts" );
}

seo_pod_phase3_door_pop( var_0 )
{

}

seo_pod_phase3_screen_boot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_screen_reboot_end" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_reboot_crashing_engines_fronts" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_reboot_crashing_impacts_rock" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_reboot_crashing_alarm" );
}

seo_pod_phase3_seat_arm_up( var_0 )
{

}

seo_pod_phase3_turn_lever( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_turn_lever_foley" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_turn_lever_recompress" );
}

seo_pod_phase3_seat_arm_down( var_0 )
{

}

seo_pod_phase3_screen_down( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_screen_down_foley_ui" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_screen_down_rattles_rears" );
}

seo_pod_phase3_screen_up( var_0 )
{

}

seo_pod_phase3_vm_seat_arm_up( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_missile_hit_vm_harness" );
}

droppod_first_building_impact()
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_first_impact_main" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_first_impact_metal" );
}

droppod_final_impact()
{
    soundscripts\_snd_playsound::snd_play_2d( "droppod_final_impact_main" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_final_impact_metal" );
    soundscripts\_snd_playsound::snd_play_2d( "droppod_final_impact_debris_fronts" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "intro_droppod_seq" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_pod_intro_post_crash" );
    thread mute_intro_ambis();
    soundscripts\_snd_playsound::snd_play_loop_2d( "seo_pod_int_amb", "kill_pod_amb_loop" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_start" );
}

droppod_harness_left_1()
{
    soundscripts\_snd::snd_slate( "droppod_harness_left_1" );
}

droppod_harness_left_2()
{
    soundscripts\_snd::snd_slate( "droppod_harness_left_2" );
}

droppod_harness_right_1()
{
    soundscripts\_snd::snd_slate( "droppod_harness_right_1" );
}

droppod_harness_right_2()
{
    soundscripts\_snd::snd_slate( "droppod_harness_right_2" );
}

midair_exp_audio( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", var_0 );
}

seo_vista_amb_explos( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", var_0 );
}

seo_dirt_explosions( var_0, var_1 )
{
    var_2 = soundscripts\_snd_playsound::snd_play_at( "exp_generic_incoming", var_0 );
    var_2 waittill( "sounddone" );
    level notify( var_1 );
    var_3 = var_0;
    var_4 = spawnstruct();
    var_4.pos = var_3;
    var_4.speed_of_sound_ = 1;
    var_4.duck_alias_ = "exp_generic_explo_sub_kick";
    var_4.duck_dist_threshold_ = 1000;
    var_4.explo_delay_chance_ = 40;
    var_4.explo_tail_alias_ = "exp_generic_explo_tail";
    var_4.shake_dist_threshold_ = 1800;
    var_4.explo_debris_alias_ = "exp_debris_mixed";
    var_4.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
    var_4.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_4 );
}

seo_fireball_explosions( var_0 )
{
    var_1 = var_0;
    var_2 = spawnstruct();
    var_2.pos = var_1;
    var_2.speed_of_sound_ = 1;
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1000;
    var_2.explo_tail_alias_ = "exp_generic_explo_tail";
    var_2.shake_dist_threshold_ = 1000;
    var_2.explo_debris_alias_ = "exp_fireball";
    var_2.ground_zero_alias_ = "exp_ground_zero";
    var_2.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
}

seo_ambient_ground_explosions( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_structure", var_0 );
}

midair_exp_glass( var_0 )
{
    var_1 = var_0;
    var_2 = spawnstruct();
    var_2.pos = var_1;
    var_2.speed_of_sound_ = 1;
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1000;
    var_2.explo_tail_alias_ = "exp_generic_explo_tail";
    var_2.shake_dist_threshold_ = 500;
    var_2.explo_debris_alias_ = "exp_debris_glass";
    var_2.ground_zero_alias_ = "exp_debris_structure_collapse";
    var_2.ground_zero_dist_threshold_ = 1000;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
}

mute_intro_ambis()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_intro_gunfire" );
}

fade_in_intro_ambis()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_intro_gunfire" );
    soundscripts\_audio_mix_manager::mm_add_submix( "intro_gunfire" );
}

setup_pod_exit_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_reach_hatch", ::seo_pod_int_player_reach_hatch, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_kick_attempt", ::seo_pod_int_player_kick_attempt, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_kick_open_hatch", ::seo_pod_int_player_kick_open_hatch, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_lean_in_door", ::seo_pod_int_player_lean_in_door, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_exit", ::seo_pod_int_player_exit, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_ext_player_land", ::seo_pod_ext_player_land, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_ext_player_turn", ::seo_pod_ext_player_turn, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_cormack_reach_hatch", ::seo_pod_cormack_reach_hatch, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_cormack_exit", ::seo_pod_cormack_exit, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_cormack_land", ::seo_pod_cormack_land, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_cormack_pivot", ::seo_pod_cormack_pivot, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_pod_cormack_walk_2", ::seo_pod_cormack_walk_2, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_will_land", ::seo_pod_will_land, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_will_walk_1", ::seo_pod_will_walk_1, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_pod_will_walk_2", ::seo_pod_will_walk_2, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_new_guy_exit", ::seo_pod_new_guy_exit, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_new_guy_land", ::seo_pod_new_guy_land, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "jackson", "seo_pod_new_guy_gets_up", ::seo_pod_new_guy_gets_up, "pod_exit" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_unbuckle_left", ::seo_pod_int_player_unbuckle_left, "pod_wakeup_left_1" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_unbuckle_left", ::seo_pod_int_player_unbuckle_left, "pod_wakeup_left_2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_unbuckle_right", ::seo_pod_int_player_unbuckle_right, "pod_wakeup_right_1" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_unbuckle_right", ::seo_pod_int_player_unbuckle_right, "pod_wakeup_right_2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_move_to_hatch_left", ::seo_pod_int_player_move_to_hatch_left, "pod_wakeup_left_2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_pod_int_player_move_to_hatch_right", ::seo_pod_int_player_move_to_hatch_right, "pod_wakeup_right_2" );
}

seo_pod_int_player_unbuckle( var_0 )
{

}

seo_pod_int_player_move_to_hatch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_to_hatch" );
}

seo_pod_int_player_reach_hatch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_reach_hatch" );
}

seo_pod_int_player_kick_attempt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_plyr_kick_hatch" );
}

seo_pod_int_player_kick_open_hatch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_plyr_kick_hatch_open" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_ext_unstable_01" );
    maps\_utility::delaythread( 0.5, ::fade_in_intro_ambis );
}

seo_pod_int_player_lean_in_door( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_exit_prep" );
}

seo_pod_int_player_exit( var_0 )
{
    level.aud.wood_debris = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_foley_override" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_exit" );
    wait 1;
    level notify( "kill_pod_amb_loop" );
}

seo_pod_ext_player_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_land" );
}

seo_pod_ext_player_turn( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_pod_ext_unstable_02", ( 36013, 10429, 4518 ) );
}

seo_pod_cormack_reach_hatch( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_cormack_foley_to_hatch" );
}

seo_pod_cormack_exit( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_cormack_foley_exit" );
}

seo_pod_cormack_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_cormack_land" );
}

seo_pod_cormack_pivot( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_cormack_walk_1" );
}

seo_pod_cormack_walk_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_cormack_walk_2" );
}

seo_pod_will_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_will_land" );
}

seo_pod_will_walk_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_will_walk_1" );
}

seo_pod_will_walk_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_will_walk_2" );
}

seo_pod_new_guy_exit( var_0 )
{
    thread seo_pod_break_loose_and_fall();
    maps\_utility::delaythread( 3, ::hotel_razorback_approach );
}

seo_pod_new_guy_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_pod_jackson_land" );
}

seo_pod_new_guy_gets_up( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_pod_intro_post_crash" );
}

seo_pod_int_player_unbuckle_left( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_unbuckle_left" );
}

seo_pod_int_player_unbuckle_right( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_unbuckle_right" );
}

seo_pod_int_player_move_to_hatch_left( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_to_hatch_l" );
}

seo_pod_int_player_move_to_hatch_right( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_foley_plyr_to_hatch_r" );
}

vista_rockets( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_sky_missile", var_0 );
}

vista_rockets_first_impact( var_0 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_2d( "seo_init_sky_missile" );
}

vista_rockets_pod_door_view_01( var_0 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_2d( "seo_second_sky_missile" );
}

vista_rockets_pod_door_view_02( var_0 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_2d( "seo_third_sky_missile" );
}

seo_pod_break_loose_and_fall()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_vista_pod_fall" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_pod_fall_creak" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_pod_fall_impact", 1.4 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_pod_fall_debris", 1.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "shrike_flyby_jet", 3.0 );
    wait 3.2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_vista_pod_fall", 1 );
    level notify( "aud_listen_fall_foley" );
}

hotel_razorback_approach()
{
    var_0 = ( 37198, 7604, 4747 );
    var_1 = ( 36801, 9652, 4661 );
    var_2 = soundscripts\_snd_playsound::snd_play_at( "seo_vista_razor_approach", var_0 );
    var_2 _meth_82AE( var_1, 3.5 );
}

hotel_razorback_fly_by()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_vista_razor_flyby" );
}

aud_handle_vista_jets()
{
    var_0 = self;
    var_0 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "seo_vista_jet_flyby", 3000 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "intro_gunfire", 5 );
}

seo_vista_bombing_run( var_0 )
{
    var_1 = soundscripts\_audio_zone_manager::azm_get_current_zone();

    if ( var_1 == "ext_crashsite" )
        soundscripts\_snd_playsound::snd_play_at( "seo_vista_bombing_run", var_0 );
}

seo_intro_patrol_drones()
{
    var_0 = self[0];
    var_1 = self[1];
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_drone_first_contact_sml", "aud_stop_first_contact_drones", 0.15, 0.2 );
    var_1 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_drone_first_contact_sml", "aud_stop_first_contact_drones", 0.15, 0.2 );
    thread seo_stop_intro_patrol_drones();
    level notify( "aud_listen_fall_foley" );
}

seo_stop_intro_patrol_drones()
{
    if ( level.currentgen )
    {
        level waittill( "pre_transients_fob_to_drone_seq_one" );
        level notify( "aud_stop_first_contact_drones" );
    }
}

setup_land_assist_jump_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "cormack", "landassist_jump_cormack_walkback", ::landassist_jump_cormack_walkback, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "cormack", "landassist_jump_cormack_powerup", ::landassist_jump_cormack_powerup, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "cormack", "landassist_jump_cormack_run", ::landassist_jump_cormack_run, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "cormack", "landassist_jump_cormack_jump", ::landassist_jump_cormack_jump, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "landassist_jump_will_walkback", ::landassist_jump_will_walkback, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "landassist_jump_will_powerup", ::landassist_jump_will_powerup, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "landassist_jump_will_run", ::landassist_jump_will_run, "first_landassist_jump_e3" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "landassist_jump_will_jump", ::landassist_jump_will_jump, "first_landassist_jump_e3" );
}

setup_fall_cloth_floey()
{
    level endon( "aud_stop_foley_fall_watch" );
    level waittill( "aud_listen_fall_foley" );
    wait 1;
    var_0 = level.player soundscripts\_snd_playsound::snd_play_loop_linked( "seo_hotel_falling_foley_lp", "aud_stop_foley_fall_watch", 0.2, 0.3 );
    thread stop_fall_foley_audio( var_0 );
    wait 0.05;
    var_0 _meth_806F( 0, 0.05 );
    wait 0.05;

    for (;;)
    {
        var_1 = length( level.player getvelocity() );
        var_2 = soundscripts\_snd::snd_map( var_1, level.aud.envs["player_fall_foley"] );

        if ( isdefined( var_0 ) )
            var_0 _meth_806F( var_2, 0.1 );

        wait 0.05;
    }
}

stop_fall_foley_audio( var_0 )
{
    level waittill( "aud_stop_foley_fall_watch" );
    var_0 _meth_80AC();
}

landassist_jump_cormack_walkback( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_crmk_walk" );
}

landassist_jump_cormack_powerup( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_crmk_powerup" );
}

landassist_jump_cormack_run( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_crmk_run" );
}

landassist_jump_cormack_jump( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_crmk_jump" );
}

landassist_jump_will_walkback( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_will_walk" );
}

landassist_jump_will_powerup( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_will_powerup" );
}

landassist_jump_will_run( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_will_run" );
}

landassist_jump_will_jump( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_landassist_foley_will_jump" );
}

setup_hotel_exo_punch_breach_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_foley", ::exo_punch_breach_foley, "exo_punch_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_impact", ::exo_punch_breach_impact, "exo_punch_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_sweetener", ::exo_punch_breach_sweetener, "exo_punch_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_deep", ::exo_punch_breach_deep, "exo_punch_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_debris", ::exo_punch_breach_debris, "exo_punch_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "exo_punch_breach_debris_texture", ::exo_punch_breach_debris_texture, "exo_punch_breach" );
}

exo_punch_breach_foley( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "hotel_exo_punch_breach" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_foley", 0.0 );
}

exo_punch_breach_impact( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_impact", 0.0 );
}

exo_punch_breach_sweetener( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_sweetener", 0.15 );
}

exo_punch_breach_deep( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_deep", 0.0 );
}

exo_punch_breach_debris( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_debris", 0.06 );
}

exo_punch_breach_debris_texture( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_punch_breach_debris_texture", 0.0 );
    wait 4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "hotel_exo_punch_breach" );
}

missiles_strike_building()
{

}

missiles_strike_explo()
{

}

shockwave_begin()
{

}

hotel_windows_explode()
{
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "int_window_blowout_room", "amb_ext_city_combat_dist" );
}

fob_pod_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "npc_droppod", "seo_fob_pod_descend", ::seo_fob_pod_descend, "pod_landing" );
    maps\_anim::addnotetrack_customfunction( "npc_droppod", "seo_fob_pod_land", ::seo_fob_pod_land, "pod_landing" );
    maps\_anim::addnotetrack_customfunction( "npc_droppod", "seo_fob_pod_door_open", ::seo_fob_pod_door_open, "pod_landing" );
    maps\_anim::addnotetrack_customfunction( "npc_droppod", "seo_fob_pod_door_land", ::seo_fob_pod_door_land, "pod_landing" );
    maps\_anim::addnotetrack_customfunction( "npc_droppod", "seo_fob_pod_flaps", ::seo_fob_pod_flaps, "pod_landing" );
}

seo_fob_pod_descend( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_pod_descend" );
}

seo_fob_pod_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_pod_land" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_pod_debris" );
}

seo_fob_pod_door_open( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_pod_door_open" );
}

seo_fob_pod_door_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_fob_pod_door_crash", ( 33525, 7687, 1400 ) );
}

seo_fob_pod_flaps( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_pod_flaps" );
}

seo_fob_tank_procedural()
{
    if ( level.nextgen )
        soundscripts\_snd_playsound::snd_play_linked( "seo_fob_tank_procedural", "stop_vehicle_sfx" );
    else
        soundscripts\_snd_playsound::snd_play_loop_linked( "seo_fob_tank_procedural", "stop_vehicle_sfx" );
}

seo_fob_tank_01()
{
    soundscripts\_snd_playsound::snd_play_linked( "seo_fob_tank_01", "stop_vehicle_sfx" );
}

seo_fob_tank_02()
{
    if ( level.nextgen )
        soundscripts\_snd_playsound::snd_play_linked( "seo_fob_tank_02", "stop_vehicle_sfx" );
    else
        soundscripts\_snd_playsound::snd_play_loop_linked( "seo_fob_tank_procedural", "stop_vehicle_sfx" );
}

seo_fob_tank_03()
{
    if ( level.nextgen )
        soundscripts\_snd_playsound::snd_play_linked( "seo_fob_tank_03", "stop_vehicle_sfx" );
    else
        soundscripts\_snd_playsound::snd_play_loop_linked( "seo_fob_tank_procedural", "stop_vehicle_sfx" );
}

seo_fob_initial_razorback()
{

}

seo_fob_fake_jet_flyby()
{

}

seo_fob_razorback_01()
{

}

seo_fob_razorback_02()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seoul_fob" );
    var_0 = self;

    if ( level.aud.heli == 0 )
    {
        var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_fob_razorback_flyby" );
        wait 0.3;
        level.aud.heli = 1;
        return;
    }
    else if ( level.aud.heli == 1 )
        return;
}

sidewinder_missile()
{
    var_0 = self;
    var_1 = ( 33538, 8525, 1378 );
    var_2 = distance( var_1, level.player.origin );

    if ( var_2 < 1350 )
        var_3 = 0;
    else
        var_3 = 1;

    var_4 = randomfloatrange( 0.2, 0.5 );

    if ( isdefined( var_0 ) )
    {
        var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_sidewinder_missile_shot" );
        wait(var_3);
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_sidewinder_missile_by", var_4 );
    }
}

aud_handle_gangam_jets()
{
    var_0 = self;
    var_0 soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "seo_fob_jet_flyby", 5500 );
}

fob_meetup_vo( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seoul_fob_meetup_vo", 1 );
    level waittill( var_0 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seoul_fob_meetup_vo", 2 );
    level notify( "aud_stop_foley_fall_watch" );
}

walker_track_pos()
{
    self endon( "death" );

    for (;;)
    {
        level.aud.drone_walker_pos = self.origin;
        waitframe();
    }
}

walker_explode()
{
    thread walker_track_pos();
    self waittill( "death" );
    soundscripts\_snd_playsound::snd_play_at( "seo_truck_explo", level.aud.drone_walker_pos );
}

walker_step_over()
{
    thread walker_explode();
    soundscripts\_audio_mix_manager::mm_clear_submix( "seoul_fob" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seoul_bus_battle" );
    _func_2B5( 1000, 500, 500, 500, 3, 5 );
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "seoul_walker_step_over" );
    wait 15;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seoul_walker_step_over", 8 );
}

titan_walker_explo( var_0 )
{
    var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.v["origin"];
        soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", var_2 );
    }
}

titan_walker_weapon_fire()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "walker_cannon_shot" );
}

seo_drone_missile( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_drone_missile_incoming" );
}

start_drone_barrage_submix()
{
    wait 0.1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seoul_bus_battle" );
    soundscripts\_audio_mix_manager::mm_add_submix( "drone_missile_barrage", 0.05 );
    soundscripts\_snd_playsound::snd_play_at( "seo_drone_attack_init_exp", ( 27906, 7557, 1405 ) );
    wait 2.6;
    soundscripts\_audio_mix_manager::mm_clear_submix( "drone_missile_barrage", 1 );
    soundscripts\_audio_mix_manager::mm_add_submix( "drone_attack_complete" );
}

seo_single_drones_flyby()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_teaser_drones", "aud_stop_single_drones_flyby" );
    thread seo_stop_single_drones_flyby();
}

seo_stop_single_drones_flyby()
{
    if ( level.currentgen )
    {
        level waittill( "pre_transients_truck_push_to_mall_office" );
        level notify( "aud_stop_first_contact_drones" );
    }
}

seo_big_car_explo()
{
    var_0 = self;
    soundscripts\_snd_playsound::snd_play_at( "seo_swarm_car_explo", var_0.origin );
}

seo_truck_explo()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "drone_missile_barrage", 0.05 );
    var_0 = self;
    soundscripts\_snd_playsound::snd_play_at( "seo_truck_explo", var_0.origin );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "drone_missile_barrage", 0.5 );
}

seo_start_drone_submix()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_drone_kamikaze_attack" );
}

drone_kamikaze_hit_player()
{
    if ( level.aud.in_turret == 1 )
        soundscripts\_snd_playsound::snd_play_2d( "attack_drone_vehicle_impact" );
    else if ( level.aud.in_turret == 0 )
        soundscripts\_snd_playsound::snd_play_2d( "attack_drone_player_impact" );
}

car_door_broken()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_drone_suicide_door_brk" );
}

seo_drone_missile_impact( var_0 )
{
    var_1 = var_0;
    var_2 = spawnstruct();
    var_2.pos = var_1;
    var_2.speed_of_sound_ = 1;
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1000;
    var_2.explo_tail_alias_ = "exp_generic_explo_tail";
    var_2.shake_dist_threshold_ = 500;
    var_2.explo_debris_alias_ = "exp_debris_mixed";
    var_2.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
    var_2.ground_zero_dist_threshold_ = 400;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
}

seo_will_car_door_explo( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_will_door_explo", var_0 );
}

setup_doorshield_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "will_irons", "will_doorshield_foley", ::will_doorshield_foley, "will_door_shield_grab" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "will_doorshield_grabs", ::will_doorshield_grabs, "will_door_shield_grab" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "will_doorshield_tension", ::will_doorshield_tension, "will_door_shield_grab" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "will_doorshield_rip", ::will_doorshield_rip, "will_door_shield_grab" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "will_doorshield_debris", ::will_doorshield_debris, "will_door_shield_grab" );
}

will_doorshield_foley( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "doorshield_foley_will", 0.0 );
}

will_doorshield_grabs( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "doorshield_grabs_will", 0.0 );
}

will_doorshield_tension( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "doorshield_tension_will", 0.0 );
}

will_doorshield_rip( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "doorshield_rip_will", 0.0 );
}

will_doorshield_debris( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "doorshield_debris_will", 0.0 );
}

player_enter_walker_anim()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_turret_drone_sequence" );
    soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_enter" );
    wait 2;
    level.aud.in_turret = 1;
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_metal_vehicle" );
    _func_2B5( 0, 0, 0, 0, -2, 2 );
}

cherry_picker_target_add()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_turret_drone_target_acquired" );
}

cherry_picker_target_remove()
{

}

seo_swarm_die( var_0 )
{
    var_1 = var_0 - ( 0, 0, var_0[2] - 1375 );
    var_2 = randomfloatrange( 0.5, 1.8 );
    wait(var_2);
    soundscripts\_snd_playsound::snd_play_at( "seo_drone_death_fall", var_1 );
}

player_exit_walker_anim()
{
    soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_exit" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_turret_drone_sequence" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_metal_vehicle" );
    _func_2B5( 0, 0, 0, 0, 1, 1 );
}

seo_swarm_emp_wave()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_turret_emp" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_turret_emp_activate" );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_emp_drone_mute" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_turret_emp" );
    music( "mus_seo_swarm_emp_wave_done" );
    wait 8;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_emp_drone_mute" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "drone_attack_complete" );
    level.aud.in_turret = 0;
}

seo_video_log_start()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_drone_kamikaze_attack" );
}

seo_hotel_ent_wp_takeoff()
{

}

seo_zipline_harpoon_fire( var_0, var_1, var_2 )
{
    var_3 = soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_shot", var_0 );
    var_3 _meth_82AE( var_1, var_2 );
}

seo_zipline_harpoon_impact( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_impact", var_0 );
}

seo_zipline_rappel_begin()
{

}

seo_zipline_rappel_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_npc_zipline_unhook" );
}

seo_zipline_retract_rope( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_retract", var_0 );
}

setup_mall_sizeup_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_mall_sizeup_crmk_walk", ::seo_mall_sizeup_crmk_walk, "seo_mall_sizeup_jump_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_mall_sizeup_crmk_powerup", ::seo_mall_sizeup_crmk_powerup, "seo_mall_sizeup_jump_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_mall_sizeup_crmk_turn", ::seo_mall_sizeup_crmk_turn, "seo_mall_sizeup_jump_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_mall_sizeup_crmk_runjump", ::seo_mall_sizeup_crmk_runjump, "seo_mall_sizeup_jump_cormack" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_mall_sizeup_will_walk", ::seo_mall_sizeup_will_walk, "seo_mall_sizeup_jump_will" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_mall_sizeup_will_wpn_sling", ::seo_mall_sizeup_will_wpn_sling, "seo_mall_sizeup_jump_will" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_mall_sizeup_will_powerup", ::seo_mall_sizeup_will_powerup, "seo_mall_sizeup_jump_will" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_mall_sizeup_will_runjump", ::seo_mall_sizeup_will_runjump, "seo_mall_sizeup_jump_will" );
    maps\_anim::addnotetrack_customfunction( "gideon", "seo_gideon_meet_atlast_start", ::seo_gideon_meet_atlast_start, "seo_meet_atlas" );
    maps\_anim::addnotetrack_customfunction( "roof_chunks", "aud_meet_atlast_roof_explode", ::aud_meet_atlast_roof_explode, "seo_meet_atlas" );
}

seo_mall_sizeup_crmk_walk( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_mall_boost_jump" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_crmk_walk" );
}

seo_mall_sizeup_crmk_powerup( var_0 )
{

}

seo_mall_sizeup_crmk_turn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_crmk_turn" );
}

seo_mall_sizeup_crmk_runjump( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_crmk_jump" );
}

seo_mall_sizeup_will_walk( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_will_walk" );
}

seo_mall_sizeup_will_wpn_sling( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_will_sling" );
}

seo_mall_sizeup_will_powerup( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_will_powerup" );
}

seo_mall_sizeup_will_runjump( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_mall_sizeup_will_jump" );
}

seo_per_arts_jump_explo_3( var_0 )
{
    var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.v["origin"];
        soundscripts\_snd_playsound::snd_play_at( "seo_per_arts_jump_explo_3", var_2 );
    }
}

sinkhole_drones_start( var_0 )
{
    wait 0.2;

    foreach ( var_2 in var_0 )
    {
        var_2 soundscripts\_snd::snd_message( "snd_stop_vehicle" );
        var_2 soundscripts\_snd_playsound::snd_play_linked( "seo_sink_drone_alert" );
        var_2 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_teaser_drones", undefined, 1.5 );
        var_3 = "seo_sink_drone_flyby";
        var_4 = [];
        var_4[0] = 800;
        var_5 = [];
        var_5[0] = 20;
        var_5[1] = 5;
        var_2 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_3, undefined, var_4, var_5, 1, undefined, undefined, 3, 2 );
    }
}

seo_sinkhole_wp_flyby()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_sinkhole_wp_takeoff" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_mall_boost_jump" );
}

sinkhole_truck_fall()
{

}

sinkhole_truck_explode()
{

}

subway_bomb_shake()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_sbwy_shake_bomb" );
    var_0 = randomfloatrange( 0, 0.3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_sbwy_shake_bomb_cracks", var_0 );
}

subway_doors_opening()
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_sbwy_doors_open", 0.0 );
    common_scripts\utility::flag_set( "start_subway_pa_message" );
}

subway_doors_closing()
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_sbwy_doors_close", 0.0 );
}

subway_pa_message()
{
    common_scripts\utility::flag_wait( "start_subway_pa_message" );
    soundscripts\_snd_playsound::snd_play_delayed_at( "seo_sbwy_kr_pa", ( 21000, 16432, 1174 ), 3, undefined, "stop_subway_pa", undefined, 3 );
}

aud_meet_atlast_roof_explode( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "atlas_meetup_breach_explode" );
}

subway_gate_triggered()
{
    soundscripts\_snd_playsound::snd_play_2d( "atlas_meetup_gun_away" );
}

seo_gideon_meet_atlast_start( var_0 )
{
    soundscripts\_snd::snd_slate( "seo_gideon_meet_atlast_start" );
    soundscripts\_snd_timescale::snd_set_timescale_all( 0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "atlas_meetup_subway", 4 );
    soundscripts\_snd_playsound::snd_play_2d( "atlas_meetup_grabgate_foley" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_grabgate_hit", 0.4, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_breach_cut_sizzle", 0.85, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_breach_cut_hum", 1.25, 1 );
}

seo_meet_atlas_slowmo_start()
{
    soundscripts\_snd::snd_slate( "Subway Slowmo Start" );
    soundscripts\_snd_playsound::snd_play_2d( "atlas_meetup_slo_mo_enter" );
}

seo_meet_atlas_slowmo_end()
{
    soundscripts\_snd::snd_slate( "Subway Slowmo end" );
    soundscripts\_snd_playsound::snd_play_2d( "atlas_meetup_foley_lands_gun" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_foley_fs_fronts", 3.5, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_gate_open_hi", 5.5, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_dust_debris", 9.0, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "atlas_meetup_foley_fs_rears", 16.5, 1 );
    wait 15;
    soundscripts\_audio_mix_manager::mm_clear_submix( "atlas_meetup_subway", 5 );
}

subway_gate_atlas_meetup_close()
{
    var_0 = self;
    soundscripts\_snd::snd_slate( "Gate Move" );
    wait 0.05;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "atlas_meetup_gate_close" );
}

sd_intersection_chopper()
{
    common_scripts\utility::flag_wait( "sd_intersection_chopper_wait" );
    soundscripts\_snd::snd_slate( "sd_intersection_chopper" );
    soundscripts\_audio_mix_manager::mm_add_submix( "shopping_district_littlebird" );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_shop_district_littlebird_eng", 0.05 );
    wait 15;
    soundscripts\_audio_mix_manager::mm_clear_submix( "shopping_district_littlebird" );
}

shopping_district_turret_truck()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_shopping_district_truck" );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_shopping_turret_truck", 0.0 );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_shopping_district_truck" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_vehicle_management" );
}

vo_sd_demo_team_call()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_sd_demo_team_call_mix", 10 );
    level waittill( "kill_seo_sd_demo_team_call_mix" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_sd_demo_team_call_mix", 10 );
}

seo_smoke_grenade_ambush( var_0, var_1 )
{
    wait(var_1);
    soundscripts\_snd_playsound::snd_play_at( "wpn_smoke_grenade_exp", var_0 );
}

shopping_district_glass_smashed( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "bullet_large_glass", var_0 );
    soundscripts\_snd_playsound::snd_play_at( "seo_nightclub_window_crack", var_0 );
}

shopping_district_glass_hit_after_smashed( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_nightclub_drone_window", var_0 );
}

shopping_district_panel_smashed( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_nightclub_panel_hit", var_0 );
}

shopping_district_panel_swing( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_nightclub_panel_swing", var_0 );
}

seo_binocs_equip()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_havoc_mix_management" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_binocs_equip" );
}

canal_binocs_zoom_in()
{
    level notify( "canal_bonocs_zoom_in" );
    level notify( "canal_bonocs_zoom_out" );
    level endon( "canal_bonocs_zoom_in" );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "seo_binocs_zoom_in", "canal_bonocs_zoom_out" );
}

canal_binocs_zoom_out()
{
    level notify( "canal_bonocs_zoom_in" );
    level notify( "canal_bonocs_zoom_out" );
    level endon( "canal_bonocs_zoom_out" );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "seo_binocs_zoom_out", "canal_bonocs_zoom_in" );
}

canal_binocs_stop_zoom_in()
{
    level notify( "canal_bonocs_zoom_out" );
}

canal_binocs_stop_zoom_out()
{
    level notify( "canal_bonocs_zoom_in" );
}

binocs_put_away()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_binocs_put_away" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_canal_combat", 0.05 );
    _func_2B5( 1000, 500, 500, 500, 5, 7 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_havoc_mix_management" );
}

havoc_missile_launch()
{
    var_0 = self;
    var_1 = ( 13754, 16832, 1756 );
    var_2 = distance( level.player.origin, var_1 );
    var_3 = soundscripts\_snd::snd_map( var_2, level.aud.envs["havoc_speed_of_sound"] );
    soundscripts\_snd_playsound::snd_play_at( "seo_havoc_launch", var_1 );
    wait(var_3);
    soundscripts\_snd_playsound::snd_play_at( "seo_havoc_launch_dist", var_1 );
    var_4 = var_0.origin;

    while ( isdefined( var_0 ) )
    {
        var_4 = var_0.origin;
        wait 0.05;
    }

    soundscripts\_snd_playsound::snd_play_at( "seo_havoc_impact", var_4 );
}

seo_canal_dynamic_bombs()
{
    level endon( "aud_stop_canal_bombs" );
    var_0 = 4;
    var_1 = 9;

    for (;;)
    {
        var_2 = randomintrange( var_0, var_1 );
        wait(var_2);
        var_3 = randomintrange( 700, 1500 );
        var_4 = randomintrange( 700, 1500 );
        var_5 = randomintrange( 200, 800 );
        var_6 = level.player.origin + ( var_3, var_4, var_5 );
        var_7 = var_6;
        var_8 = spawnstruct();
        var_8.pos = var_7;
        var_8.speed_of_sound_ = 1;
        var_8.duck_alias_ = "exp_generic_explo_sub_kick";
        var_8.duck_dist_threshold_ = 1000;
        var_8.explo_tail_alias_ = "exp_generic_explo_tail";
        var_8.shake_dist_threshold_ = 500;
        var_8.explo_debris_alias_ = "exp_debris_mixed";
        var_8.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
        var_8.ground_zero_dist_threshold_ = 400;
        soundscripts\_snd_common::snd_ambient_explosion( var_8 );
    }
}

canal_jet_flyover()
{
    var_0 = self;
    soundscripts\_snd_playsound::snd_play_2d( "seo_canal_shrike_flyover" );
    thread seo_canal_dynamic_bombs();
}

seo_canal_razorback()
{
    if ( level.currentgen && !_func_21E( "seoul_riverwalk_tr" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    var_0 = level.canal_razorback;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_canal_razor_intro", "switch_to_loop", undefined, 1 );
    wait 16;
    level notify( "switch_to_loop" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_canal_razor_lp", "switch_to_fly_away", 2, 2 );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "seo_canal_razor_turbine_lp", "switch_to_fly_away", 2, 2 );
}

razorback_fire_start( var_0 )
{
    soundscripts\_snd_playsound::snd_play_loop_linked( "wpn_razorback_turretv2_lp", "aud_stop_razorback_fire_lp" );
}

razorback_fire_stop( var_0 )
{
    level notify( "aud_stop_razorback_fire_lp" );
}

seo_canal_heli_attacked()
{
    level notify( "switch_to_fly_away" );
    var_0 = level.canal_razorback;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_canal_razor_fly_away", undefined, undefined, 2 );
}

timed_charges_vo()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_timed_charges_vo", 2 );
    level waittill( "timed_charges_vo_done" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_timed_charges_vo", 2 );
}

seo_finale_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_finale", 5 );
    _func_2B5( 0, 0, 0, 0, 1, 1 );
}

setup_finale_anims()
{
    wait 0.05;
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_start", ::seo_finale_will_start, "finale_pt01" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_jump_onto_platform", ::seo_finale_will_jump_onto_platform, "finale_pt01" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_grab_hatch", ::seo_finale_will_grab_hatch, "finale_pt01" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_open_hatch", ::seo_finale_will_open_hatch, "finale_pt01" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_bomb_turn", ::seo_finale_will_bomb_turn, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_bomb_accept", ::seo_finale_will_bomb_accept, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_bomb_arm", ::seo_finale_will_bomb_arm, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_place_bomb", ::seo_finale_will_place_bomb, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_bomb_hatch_trap", ::seo_finale_will_bomb_hatch_trap, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_struggle", ::seo_finale_will_struggle, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_first_attempt_to_free", ::seo_finale_will_first_attempt_to_free, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_second_attempt", ::seo_finale_will_second_attempt, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_grabs_player", ::seo_finale_will_grabs_player, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "will_irons", "seo_finale_will_pushes_player", ::seo_finale_will_pushes_player, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_jump_onto_platform", ::seo_finale_player_jump_onto_platform, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_retrieve_bomb", ::seo_finale_player_retrieve_bomb, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_hatch_react", ::seo_finale_player_hatch_react, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_grab_hatch", ::seo_finale_player_grab_hatch, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_two_handed_hatch_pull", ::seo_finale_player_two_handed_hatch_pull, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_falls", ::seo_finale_player_falls, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_lands", ::seo_finale_player_lands, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_bounces", ::seo_finale_player_bounces, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_arm_slice", ::seo_finale_player_arm_slice, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_leg_up", ::seo_finale_player_leg_up, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_leg_down", ::seo_finale_player_leg_down, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "seo_finale_player_dragged_away", ::seo_finale_player_dragged_away, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_enter_scene", ::seo_finale_cormack_enter_scene, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_walk_to_player", ::seo_finale_cormack_walk_to_player, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_crouch", ::seo_finale_cormack_crouch, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_grab_metal", ::seo_finale_cormack_grab_metal, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_assist_player", ::seo_finale_cormack_assist_player, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "cormack", "seo_finale_cormack_pull_player", ::seo_finale_cormack_pull_player, "finale_pt03" );
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_hatch_close", ::seo_finale_wp_hatch_close, "finale_plantbomb" );
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_prepare_to_lift_off", ::seo_finale_wp_prepare_to_lift_off, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_lift_off", ::seo_finale_wp_lift_off, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_landing_gears_up", ::seo_finale_wp_landing_gears_up, "finale_pt02" );
    maps\_anim::addnotetrack_customfunction( "weapon_platform", "seo_finale_wp_take_off", ::seo_finale_wp_take_off, "finale_pt02" );
}

seo_finale_will_start( var_0 )
{
    level notify( "aud_stop_canal_bombs" );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_finale_will_foley_start", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_finale_will_intro_steps", 1.17 );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_finale_wp_ambi_soft", 7 );
}

seo_finale_will_jump_onto_platform( var_0 )
{

}

seo_finale_will_grab_hatch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_linked( "seo_finale_will_opens_door", 0.65 );
}

seo_finale_will_open_hatch( var_0 )
{

}

seo_finale_will_bomb_turn( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_will_bomb_pt_01", 0.77 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_bomb_timer", 1.73 );
}

seo_finale_will_bomb_accept( var_0 )
{

}

seo_finale_will_bomb_arm( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_bomb_plant", 1.82 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_door_closing", 2.359 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_door_slam_lyr_02", 2.51 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_door_slam", 2.587 );
}

seo_finale_will_place_bomb( var_0 )
{

}

seo_finale_will_bomb_hatch_trap( var_0 )
{

}

seo_finale_will_struggle( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_will_bomb_pt_02", 2.95 );
}

seo_finale_will_first_attempt_to_free( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_door_strain", 1.1 );
}

seo_finale_will_second_attempt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_will_bomb_pt_03", 4.09 );
}

seo_finale_will_grabs_player( var_0 )
{
    wait 1.75;
    level notify( "kill_hatch_jam" );
}

seo_finale_will_pushes_player( var_0 )
{

}

seo_finale_player_jump_onto_platform( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_plr_foley_start", 0.2 );
}

seo_finale_player_retrieve_bomb( var_0 )
{

}

seo_finale_player_hatch_react( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_plr_react", 0.25 );
}

seo_finale_player_grab_hatch( var_0 )
{

}

seo_finale_player_two_handed_hatch_pull( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_plr_2h_grab", 0.32 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_plr_tossed", 4.85 );
}

seo_finale_player_falls( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_other_side_mix" );
}

seo_finale_player_lands( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_plyr_land" );
}

seo_finale_player_bounces( var_0 )
{
    if ( level.currentgen && !_func_21E( "seoul_riverwalk_tr" ) )
        level waittill( "transients_canal_overlook_to_riverwalk" );

    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_plyr_roll" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "seo_finale_plyr_filter_lp", undefined, 2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_hearing_damage" );
}

seo_finale_player_arm_slice( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_mtl_chunk_flip" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "seo_finale_mtl_impact", 1.034 );
}

seo_finale_player_leg_up( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_plyr_grab_metal" );
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "ext_canal", "amb_ext_cmbt_hdmg" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_finale_wp_ambi_soft" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_finale_wp_ambi_fade", 2 );
}

seo_finale_player_leg_down( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_plyr_leg_down" );
}

seo_finale_player_dragged_away( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_plyr_dragged" );
}

seo_finale_cormack_enter_scene( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_enter_scene" );
}

seo_finale_cormack_walk_to_player( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_walk_to_plyr" );
}

seo_finale_cormack_crouch( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_crouch" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_filtered_warbird" );
}

seo_finale_cormack_grab_metal( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_grab_metal" );
}

seo_finale_cormack_assist_player( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_assist" );
}

seo_finale_cormack_pull_player( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_crmk_pull" );
}

seo_finale_wp_hatch_close( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_finale_wp_soft_engine" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_hatch_jammed", "kill_hatch_jam", undefined, 2.5 );
}

seo_finale_wp_prepare_to_lift_off( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_wp_powerup" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_wp_engine", "kill_engine_sounds" );
}

seo_finale_wp_lift_off( var_0 )
{

}

seo_finale_wp_landing_gears_up( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "seo_finale_wp_soft_engine" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_landing_gear" );
    soundscripts\_audio_mix_manager::mm_add_submix( "seo_finale_wp_ambi_fade", 5 );
}

seo_finale_wp_take_off( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_wp_take_off" );
    level waittill( "wp_engine_failure" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_finale_wp_engine_failure_01", "kill_engine_sounds" );
}

seo_finale_wp_init_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_explo_01" );
    level notify( "wp_engine_failure" );
    music( "mus_finale_wp_explo_01" );
}

seo_finale_wp_belly_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_explo_02" );
    level notify( "kill_engine_sounds" );
}

seo_finale_wp_wing_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_explo_03" );
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_explo_04" );
}

seo_finale_wp_big_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_finale_wp_crash" );
}

e3_demo_fade_out()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

e3_demo_fade_in()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "solo_radio", 0 );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "solo_radio", 3.0 );
}

e3_end_logo()
{
    soundscripts\_snd_playsound::snd_play_2d( "seo_e3_end_logo" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_add_submix( "e3_end_logo", 3 );
}

seoul_foley_override_handler()
{
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "foley", var_0, var_1, var_2 );

        if ( isdefined( level.aud.wood_debris ) && level.aud.wood_debris == 1 )
        {
            switch ( var_0 )
            {
                case "stationarycrouchscuff":
                    soundscripts\_snd_playsound::snd_play_2d( "step_scrape_plr_wood_debris" );
                    break;
                case "stationaryscuff":
                    soundscripts\_snd_playsound::snd_play_2d( "step_scrape_plr_wood_debris" );
                    break;
                case "crouchscuff":
                    soundscripts\_snd_playsound::snd_play_2d( "step_scrape_plr_wood_debris" );
                    break;
                case "runscuff":
                    soundscripts\_snd_playsound::snd_play_2d( "step_scrape_plr_wood_debris" );
                    break;
                case "sprintscuff":
                    soundscripts\_snd_playsound::snd_play_2d( "step_scrape_plr_wood_debris" );
                    break;
                case "prone":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_prone_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_prone_plr_wood_debris_r" );

                    break;
                case "crouchwalk":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_wood_debris_r" );

                    break;
                case "crouchrun":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_run_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_run_plr_wood_debris_r" );

                    break;
                case "walk":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_walk_plr_wood_debris_r" );

                    break;
                case "run":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_run_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_run_plr_wood_debris_r" );

                    break;
                case "sprint":
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "step_sprint_plr_wood_debris_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "step_sprint_plr_wood_debris_r" );

                    break;
                case "jump":
                    break;
                case "lightland":
                    soundscripts\_snd_playsound::snd_play_2d( "step_land_plr_lt_wood_debris" );
                    break;
                case "mediumland":
                    soundscripts\_snd_playsound::snd_play_2d( "step_land_plr_med_wood_debris" );
                    break;
                case "heavyland":
                    soundscripts\_snd_playsound::snd_play_2d( "step_land_plr_hv_wood_debris" );
                    break;
                case "damageland":
                    soundscripts\_snd_playsound::snd_play_2d( "step_land_plr_dmg_wood_debris" );
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

            continue;
        }
    }
}
