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
    soundscripts\_snd::snd_register_message( "start_funeral", ::start_funeral );
    soundscripts\_snd::snd_register_message( "start_training_01", ::start_training_01 );
    soundscripts\_snd::snd_register_message( "start_training_01_lodge", ::start_training_01_lodge );
    soundscripts\_snd::snd_register_message( "start_training_01_lodge_breach", ::start_training_01_lodge_breach );
    soundscripts\_snd::snd_register_message( "start_training_01_lodge_exit", ::start_training_01_lodge_exit );
    soundscripts\_snd::snd_register_message( "start_training_01_golf_course", ::start_training_01_golf_course );
    soundscripts\_snd::snd_register_message( "start_training_01_end", ::start_training_01_end );
    soundscripts\_snd::snd_register_message( "start_tour_ride", ::start_tour_ride );
    soundscripts\_snd::snd_register_message( "start_tour_exo", ::start_tour_exo );
    soundscripts\_snd::snd_register_message( "start_tour_exo_exit", ::start_tour_exo_exit );
    soundscripts\_snd::snd_register_message( "start_tour_firing_range", ::start_tour_firing_range );
    soundscripts\_snd::snd_register_message( "start_tour_augmented_reality", ::start_tour_augmented_reality );
    soundscripts\_snd::snd_register_message( "start_tour_end", ::start_tour_end );
    soundscripts\_snd::snd_register_message( "start_training_02", ::start_training_02 );
    soundscripts\_snd::snd_register_message( "start_training_02_lodge", ::start_training_02_lodge );
    soundscripts\_snd::snd_register_message( "start_training_02_lodge_breach", ::start_training_02_lodge_breach );
    soundscripts\_snd::snd_register_message( "start_training_02_lodge_exit", ::start_training_02_lodge_exit );
    soundscripts\_snd::snd_register_message( "start_training_02_golf_course", ::start_training_02_golf_course );
    soundscripts\_snd::snd_register_message( "start_training_02_end", ::start_training_02_end );
    soundscripts\_snd::snd_register_message( "camp_david_thunder_transition", ::camp_david_thunder_transition );
    soundscripts\_snd::snd_register_message( "camp_david_reload_malfunction", ::camp_david_reload_malfunction );
    soundscripts\_snd::snd_register_message( "rec_s2_door_guy_ambush", ::rec_s2_door_guy_ambush );
    soundscripts\_snd::snd_register_message( "camp_david_training_mute_device", ::camp_david_training_mute_device );
    soundscripts\_snd::snd_register_message( "rec_mute_breach_slo_mo1", ::rec_mute_breach_slo_mo1 );
    soundscripts\_snd::snd_register_message( "rec_chair_kva_gets_shot", ::rec_chair_kva_gets_shot );
    soundscripts\_snd::snd_register_message( "rec_kva_with_president_gets_shot", ::rec_kva_with_president_gets_shot );
    soundscripts\_snd::snd_register_message( "rec_s1_president_killed", ::rec_s1_president_killed );
    soundscripts\_snd::snd_register_message( "rec_bathroom_guy", ::rec_bathroom_guy );
    soundscripts\_snd::snd_register_message( "rec_plr_kills_president", ::rec_plr_kills_president );
    soundscripts\_snd::snd_register_message( "rec_s1_drones_fly_by", ::rec_s1_drones_fly_by );
    soundscripts\_snd::snd_register_message( "rec_s1_drones_attack", ::rec_s1_drones_attack );
    soundscripts\_snd::snd_register_message( "rec_drone_scanner", ::rec_drone_scanner );
    soundscripts\_snd::snd_register_message( "patio_flashbang", ::patio_flashbang );
    soundscripts\_snd::snd_register_message( "rec_train1_stealth_car_spawn", ::rec_train1_stealth_car_spawn );
    soundscripts\_snd::snd_register_message( "rec_train1_stealth_car_stop", ::rec_train1_stealth_car_stop );
    soundscripts\_snd::snd_register_message( "s1_popping_smoke", ::s1_popping_smoke );
    soundscripts\_snd::snd_register_message( "rec_train1_exfil_car_start", ::rec_train1_exfil_car_start );
    soundscripts\_snd::snd_register_message( "rec_train1_end", ::rec_train1_end );
    soundscripts\_snd::snd_register_message( "tour_jeep_startup", ::tour_jeep_startup );
    soundscripts\_snd::snd_register_message( "rec_tour_vtol_takeoff_spawn", ::rec_tour_vtol_takeoff_spawn );
    soundscripts\_snd::snd_register_message( "rec_littlebird_formation_spawn", ::rec_littlebird_formation_spawn );
    soundscripts\_snd::snd_register_message( "rec_tour_vehicle_1_start", ::rec_tour_vehicle_1_start );
    soundscripts\_snd::snd_register_message( "civ_domestic_truck_spawn", ::civ_domestic_truck_spawn );
    soundscripts\_snd::snd_register_message( "attack_drone_flybys_audio", ::attack_drone_flybys_audio );
    soundscripts\_snd::snd_register_message( "tour_drones_fly_by", ::tour_drones_fly_by );
    soundscripts\_snd::snd_register_message( "vrap_spawn", ::vrap_spawn );
    soundscripts\_snd::snd_register_message( "tour_littlebird_lander", ::tour_littlebird_lander );
    soundscripts\_snd::snd_register_message( "rec_tour_titan_gate_plr_open", ::rec_tour_titan_gate_plr_open );
    soundscripts\_snd::snd_register_message( "rec_tour_titan_1_start", ::rec_tour_titan_1_start );
    soundscripts\_snd::snd_register_message( "rec_tour_escort_jeep_start", ::rec_tour_escort_jeep_start );
    soundscripts\_snd::snd_register_message( "rec_tour_titan_2_walk_anim_start", ::rec_tour_titan_2_walk_anim_start );
    soundscripts\_snd::snd_register_message( "tour_hangar_drones", ::tour_hangar_drones );
    soundscripts\_snd::snd_register_message( "rec_tour_end_jeep_gate_plr_open", ::rec_tour_end_jeep_gate_plr_open );
    soundscripts\_snd::snd_register_message( "rec_tour_end_jeep_gate_plr_close", ::rec_tour_end_jeep_gate_plr_close );
    soundscripts\_snd::snd_register_message( "rec_tour_npc_jeep_exit_gate_open", ::rec_tour_npc_jeep_exit_gate_open );
    soundscripts\_snd::snd_register_message( "rec_tour_npc_jeep_exit_gate_close", ::rec_tour_npc_jeep_exit_gate_close );
    soundscripts\_snd::snd_register_message( "tour_littlebird_ambient", ::tour_littlebird_ambient );
    soundscripts\_snd::snd_register_message( "rec_exo_arm_repair_attempt_01_npc", ::rec_exo_arm_repair_attempt_01_npc );
    soundscripts\_snd::snd_register_message( "rec_exo_arm_repair_attempt_02_npc", ::rec_exo_arm_repair_attempt_02_npc );
    soundscripts\_snd::snd_register_message( "rec_exo_arm_repair_attempt_03_npc", ::rec_exo_arm_repair_attempt_03_npc );
    soundscripts\_snd::snd_register_message( "exo_repair_movement", ::exo_repair_movement );
    soundscripts\_snd::snd_register_message( "exo_repair_weight_updates", ::exo_repair_weight_updates );
    soundscripts\_snd::snd_register_message( "exo_repair_movement_stop", ::exo_repair_movement_stop );
    soundscripts\_snd::snd_register_message( "rec_exo_arm_repair_attempt_exit_npc", ::rec_exo_arm_repair_attempt_exit_npc );
    soundscripts\_snd::snd_register_message( "tour_base_ambient_vehicle_01", ::tour_base_ambient_vehicle_01 );
    soundscripts\_snd::snd_register_message( "exo_drone_flby", ::exo_drone_flby );
    soundscripts\_snd::snd_register_message( "shooting_range_transition1", ::shooting_range_transition1 );
    soundscripts\_snd::snd_register_message( "shooting_range_panels_up", ::shooting_range_panels_up );
    soundscripts\_snd::snd_register_message( "shooting_range_enemy_spawn", ::shooting_range_enemy_spawn );
    soundscripts\_snd::snd_register_message( "shooting_range_target_despawn", ::shooting_range_target_despawn );
    soundscripts\_snd::snd_register_message( "shooting_range_enemy_shot", ::shooting_range_enemy_shot );
    soundscripts\_snd::snd_register_message( "shooting_range_friendly_spawn", ::shooting_range_friendly_spawn );
    soundscripts\_snd::snd_register_message( "shooting_range_friendly_shot", ::shooting_range_friendly_shot );
    soundscripts\_snd::snd_register_message( "shooting_range_transition2", ::shooting_range_transition2 );
    soundscripts\_snd::snd_register_message( "shooting_range_transition3", ::shooting_range_transition3 );
    soundscripts\_snd::snd_register_message( "shooting_range_panels_down", ::shooting_range_panels_down );
    soundscripts\_snd::snd_register_message( "tour_base_ambient_vehicle_02", ::tour_base_ambient_vehicle_02 );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_flip", ::smart_grenade_target_flip );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_move", ::smart_grenade_target_move );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_move_back", ::smart_grenade_target_move_back );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_hit", ::smart_grenade_target_hit );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_shot", ::smart_grenade_target_shot );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_flip_down", ::smart_grenade_target_flip_down );
    soundscripts\_snd::snd_register_message( "smart_grenade_target_expire", ::smart_grenade_target_expire );
    soundscripts\_snd::snd_register_message( "rec_readyroom_elevator_left_hatch_back", ::rec_readyroom_elevator_left_hatch_back );
    soundscripts\_snd::snd_register_message( "rec_readyroom_elevator_left_hatch_front", ::rec_readyroom_elevator_left_hatch_front );
    soundscripts\_snd::snd_register_message( "rec_s2_breach_gun_holster", ::rec_s2_breach_gun_holster );
    soundscripts\_snd::snd_register_message( "rec_slomo_audio_handler", ::rec_slomo_audio_handler );
    soundscripts\_snd::snd_register_message( "rec_s2_breach_slo_mo", ::rec_s2_breach_slo_mo );
    soundscripts\_snd::snd_register_message( "rec_slomo_kill_bad_guy", ::rec_slomo_kill_bad_guy );
    soundscripts\_snd::snd_register_message( "aud_training_s2_potus_ziptie_release", ::aud_training_s2_potus_ziptie_release );
    soundscripts\_snd::snd_register_message( "rec_s2_drones_attack", ::rec_s2_drones_attack );
    soundscripts\_snd::snd_register_message( "rec_player_drone_start", ::rec_player_drone_start );
    soundscripts\_snd::snd_register_message( "rec_player_drone_end", ::rec_player_drone_end );
    soundscripts\_snd::snd_register_message( "snd_player_drone_deploy", ::snd_player_drone_deploy );
    soundscripts\_snd::snd_register_message( "snd_player_drone_wrist_panel", ::snd_player_drone_wrist_panel );
    soundscripts\_snd::snd_register_message( "snd_player_drone_enter_drone_pov", ::snd_player_drone_enter_drone_pov );
    soundscripts\_snd::snd_register_message( "rec_train2_exfil_car_start", ::rec_train2_exfil_car_start );
    soundscripts\_snd::snd_register_message( "rec_train2_exfil_car_end", ::rec_train2_exfil_car_end );
    soundscripts\_snd::snd_register_message( "rec_train2_ambush_car_1", ::rec_train2_ambush_car_1 );
    soundscripts\_snd::snd_register_message( "rec_train2_ambush_car_2", ::rec_train2_ambush_car_2 );
    soundscripts\_snd::snd_register_message( "rec_star_trek_door_open", ::rec_star_trek_door_open );
    soundscripts\_snd::snd_register_message( "rec_star_trek_door_close", ::rec_star_trek_door_close );
    soundscripts\_snd::snd_register_message( "temp_dog_bark", ::temp_dog_bark );
}

register_notetracks()
{
    waitframe();
    maps\_anim::addnotetrack_customfunction( "irons", "eulogy_irons_stand", ::eulogy_irons_stand, "rec_funeral_eulogy_ends_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "eulogy_irons_touch", ::eulogy_irons_touch, "rec_funeral_eulogy_ends_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "eulogy_irons_leave", ::eulogy_irons_leave, "rec_funeral_eulogy_ends_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_turn", ::atlascard_irons_turn, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_walk", ::atlascard_irons_walk, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_handshake", ::atlascard_irons_handshake, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_place_hand", ::atlascard_irons_place_hand, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_tap", ::atlascard_irons_tap, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_grab_card", ::atlascard_irons_grab_card, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "irons", "atlascard_irons_leave", ::atlascard_irons_leave, "rec_funeral_altascard_irons" );
    maps\_anim::addnotetrack_customfunction( "cormack", "eulogy_cormack_approach", ::eulogy_cormack_approach, "rec_funeral_eulogy_ends_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "eulogy_cormack_touch", ::eulogy_cormack_touch, "rec_funeral_eulogy_ends_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "eulogy_cormack_leave", ::eulogy_cormack_leave, "rec_funeral_eulogy_ends_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "atlascard_cormack_walk", ::atlascard_cormack_walk, "rec_funeral_altascard_cormack" );
    maps\_anim::addnotetrack_customfunction( "player_rig_funeral", "eulogy_player_touch", ::eulogy_player_touch, "rec_funeral_walktocar_vm" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "campdavid_player_arm_reveal", ::campdavid_player_arm_reveal, "rec_campdavid_intro" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_threat01_joker_start", ::rec_threat01_joker_start, "training_s1_threat_guy_open" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_threat01_joker_kick", ::rec_threat01_joker_kick, "training_s1_threat_guy_out" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_joker_start", ::rec_mute01_joker_start, "training_s1_exo_breach_joker_start" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_joker_breach", ::rec_mute01_joker_breach, "training_s1_exo_breach_joker_start" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_joker_run", ::rec_mute01_joker_run, "training_s1_exo_breach_joker_start" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_joker_kick", ::rec_mute01_joker_kick, "training_s1_exo_breach_joker_start" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_joker_turn", ::rec_mute01_joker_turn, "training_s1_exo_breach_joker_start" );
    maps\_anim::addnotetrack_customfunction( "generic", "rec_mute01_kva_with_gun_killed", ::rec_mute01_kva_with_gun_killed, "training_s1_exo_breach_kva1_success" );
    maps\_anim::addnotetrack_customfunction( "generic", "rec_mute01_kva_kicked", ::rec_mute01_kva_kicked, "training_s1_exo_breach_kva3_start" );
    maps\_anim::addnotetrack_customfunction( "generic", "rec_mute01_kva_hits_wall", ::rec_mute01_kva_hits_wall, "training_s1_exo_breach_kva3_start" );
    maps\_anim::addnotetrack_customfunction( "generic", "rec_mute01_chair_kva_killed", ::rec_mute01_chair_kva_killed, "training_s1_exo_breach_kva2_start" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_mute01_potus_free", ::rec_mute01_potus_free, "training_s1_exo_breach_joker_release" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_training01_lodge_stealth_exit_start", ::rec_training01_lodge_stealth_exit_start, "training_s1_patio_joker_door_slow_in" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_training01_lodge_stealth_open", ::rec_training01_lodge_stealth_open, "training_s1_patio_joker_door_slow_open" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_training01_lodge_stealth_exit_end", ::rec_training01_lodge_stealth_exit_end, "training_s1_patio_joker_door_slow_out" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_arm_malfunction", ::training_01_end_player_arm_malfunction, "training_s1_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_punched", ::training_01_end_player_punched, "training_s1_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_helped_up", ::training_01_end_player_helped_up, "training_s1_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_arm_up", ::training_01_end_player_arm_up, "training_s1_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_enters_jeep", ::training_01_end_player_enters_jeep, "training_s1_player_end_jeep_enter" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_moves_to_seat", ::training_01_end_player_moves_to_seat, "training_s1_player_end_jeep_enter" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "training_01_end_player_sits", ::training_01_end_player_sits, "training_s1_player_end_jeep_enter" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_walk", ::training_01_end_gideon_walk, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_punch", ::training_01_end_gideon_punch, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_pulls_gun", ::training_01_end_gideon_pulls_gun, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_shoots_potus", ::training_01_end_gideon_shoots_potus, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_to_player", ::training_01_end_gideon_to_player, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_mask", ::training_01_end_gideon_mask, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_gun_away", ::training_01_end_gideon_gun_away, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_helps_up_plr", ::training_01_end_gideon_helps_up_plr, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_grabs_arm", ::training_01_end_gideon_grabs_arm, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_idles", ::training_01_end_gideon_idles, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_walks_away", ::training_01_end_gideon_walks_away, "training_s1_gideon_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "training_01_end_gideon_enter_jeep", ::training_01_end_gideon_enter_jeep, "training_s1_gideon_end_enter" );
    maps\_anim::addnotetrack_customfunction( "irons", "training_01_end_irons_exit_jeep", ::training_01_end_irons_exit_jeep, "training_s1_irons_end" );
    maps\_anim::addnotetrack_customfunction( "irons", "training_01_end_irons_hand_on_shoulder", ::training_01_end_irons_hand_on_shoulder, "training_s1_irons_end" );
    maps\_anim::addnotetrack_customfunction( "irons", "training_01_end_irons_walk_away", ::training_01_end_irons_walk_away, "training_s1_irons_end" );
    maps\_anim::addnotetrack_customfunction( "irons", "training_01_end_irons_enter_jeep", ::training_01_end_irons_enter_jeep, "training_s1_irons_end" );
    maps\_anim::addnotetrack_customfunction( "president", "training_01_end_potus_threatened", ::training_01_end_potus_threatened, "training_s1_president_end" );
    maps\_anim::addnotetrack_customfunction( "president", "training_01_end_potus_shot", ::training_01_end_potus_shot, "training_s1_president_end" );
    maps\_anim::addnotetrack_customfunction( "president", "training_01_end_potus_gets_up", ::training_01_end_potus_gets_up, "training_s1_president_end" );
    maps\_anim::addnotetrack_customfunction( "driver", "training_01_end_driver_seat_movement", ::training_01_end_driver_seat_movement, "training_s1_driver_end_enter" );
    maps\_anim::addnotetrack_customfunction( "driver", "training_01_end_driver_gear_shift", ::training_01_end_driver_gear_shift, "training_s1_driver_end_enter" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_training1_jeep_enter", ::rec_training1_jeep_enter, "training_s1_vehicle_tour_end" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_training1_jeep_arrive", ::rec_training1_jeep_arrive, "training_s1_vehicle_tour_end" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_training1_jeep_irons_door_open", ::rec_training1_jeep_irons_door_open, "training_s1_vehicle_tour_end" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_training1_jeep_irons_door_close", ::rec_training1_jeep_irons_door_close, "training_s1_vehicle_tour_end" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_training1_jeep_player_door_close", ::rec_training1_jeep_player_door_close, "training_s1_vehicle_tour_end_enter" );
    maps\_anim::addnotetrack_customfunction( "irons", "rec_tour_ride_irons_turns_to_plr", ::rec_tour_ride_irons_turns_to_plr, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "rec_tour_ride_irons_gestures", ::rec_tour_ride_irons_gestures, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "rec_tour_ride_irons_waves", ::rec_tour_ride_irons_waves, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_tour_ride_plr_door", ::rec_tour_ride_plr_door, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_tour_ride_plr_exits_jeep", ::rec_tour_ride_plr_exits_jeep, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "gideon", "rec_tour_ride_gid_hand_on_door", ::rec_tour_ride_gid_hand_on_door, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "gideon", "rec_tour_ride_gid_exits_jeep", ::rec_tour_ride_gid_exits_jeep, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "driver", "rec_tour_ride_driver_gear_shift", ::rec_tour_ride_driver_gear_shift, "rec_tour_ride_c_pt1" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_tour_ride_veh_rightdoor_open", ::rec_tour_ride_veh_rightdoor_open, "rec_tour_ride_c_pt1_jeep" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_tour_ride_veh_leftdoor_open", ::rec_tour_ride_veh_leftdoor_open, "rec_tour_ride_c_pt1_jeep" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_tour_ride_veh_rightdoor_close", ::rec_tour_ride_veh_rightdoor_close, "rec_tour_ride_c_pt1_jeep" );
    maps\_anim::addnotetrack_customfunction( "jeep", "rec_tour_ride_veh_leftdoor_close", ::rec_tour_ride_veh_leftdoor_close, "rec_tour_ride_c_pt1_jeep" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_box_pickup", ::audio_push_1_box_pickup, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_box_drop", ::audio_push_1_box_drop, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_box_push", ::audio_push_1_box_push, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_crane_move_1", ::audio_push_1_crane_move_1, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_crane_move_2", ::audio_push_1_crane_move_2, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_1", "audio_push_1_crane_move_3", ::audio_push_1_crane_move_3, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_box_pickup", ::audio_push_2_box_pickup, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_box_drop", ::audio_push_2_box_drop, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_box_push", ::audio_push_2_box_push, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_crane_move_1", ::audio_push_2_crane_move_1, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_crane_move_2", ::audio_push_2_crane_move_2, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "pusher_2", "audio_push_2_crane_move_3", ::audio_push_2_crane_move_3, "rec_atlas_push_idle" );
    maps\_anim::addnotetrack_customfunction( "climber_1", "exo_climb_start", ::exo_climb_start, "rec_atlas_climb_guy02" );
    maps\_anim::addnotetrack_customfunction( "player_rig_repair", "exo_repair_vm_sit", ::exo_repair_vm_sit, "rec_exo_arm_repair_vm" );
    maps\_anim::addnotetrack_customfunction( "player_rig_repair", "exo_repair_vm_place_arm", ::exo_repair_vm_place_arm, "rec_exo_arm_repair_vm" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "exo_repair_desk_unfold", ::exo_repair_desk_unfold, "rec_exo_arm_repair_chair_unfold_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_harness_close", ::repair_desk_harness_close, "rec_exo_arm_repair_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_grab_needle", ::repair_desk_grab_needle, "rec_exo_arm_repair_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_align_needle", ::repair_desk_align_needle, "rec_exo_arm_repair_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_push_needle", ::repair_desk_push_needle, "rec_exo_arm_repair_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_remove_needle", ::repair_desk_remove_needle, "rec_exo_arm_repair_exit_desk" );
    maps\_anim::addnotetrack_customfunction( "animated_desk", "repair_desk_harness_release", ::repair_desk_harness_release, "rec_exo_arm_repair_exit_desk" );
    maps\_anim::addnotetrack_customfunction( "player_rig_repair", "exo_repair_vm_lift_arm", ::exo_repair_vm_lift_arm, "rec_exo_arm_repair_attempt_exit_vm" );
    maps\_anim::addnotetrack_customfunction( "player_rig_repair", "exo_repair_vm_test_hand", ::exo_repair_vm_test_hand, "rec_exo_arm_repair_attempt_exit_vm" );
    maps\_anim::addnotetrack_customfunction( "wrestler_1", "audio_start_wrestling_exo_guy", ::audio_start_wrestling_exo_guy, "rec_atlas_wrestling_idle" );
    maps\_anim::addnotetrack_customfunction( "wrestler_2", "audio_start_wrestling_guy2", ::audio_start_wrestling_guy2, "rec_atlas_wrestling_idle" );
    maps\_anim::addnotetrack_customfunction( "wrestler_3", "audio_start_wrestling_guy3", ::audio_start_wrestling_guy3, "rec_atlas_wrestling_idle" );
    maps\_anim::addnotetrack_customfunction( "wrestler_4", "audio_start_wrestling_guy4", ::audio_start_wrestling_guy4, "rec_atlas_wrestling_idle" );
    maps\_anim::addnotetrack_customfunction( "wrestler_5", "audio_start_wrestling_guy5", ::audio_start_wrestling_guy5, "rec_atlas_wrestling_idle" );
    maps\_anim::addnotetrack_customfunction( "gideon", "rec_readyroom_gideon_pushes_button", ::rec_readyroom_gideon_pushes_button, "rec_readyroom_seq" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_right", "rec_readyroom_elevator_right_open", ::rec_readyroom_elevator_right_open, "rec_readyroom_seq" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_right", "rec_readyroom_elevator_right_close", ::rec_readyroom_elevator_right_close, "rec_readyroom_up_elevator_right" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_right", "rec_readyroom_elevator_right_up", ::rec_readyroom_elevator_right_up, "rec_readyroom_up_elevator_right" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_right", "rec_readyroom_elevator_right_open2", ::rec_readyroom_elevator_right_open2, "rec_readyroom_up_elevator_right" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_left", "rec_readyroom_elevator_left_open", ::rec_readyroom_elevator_left_open, "rec_readyroom_elevator_left_open" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_left", "rec_readyroom_elevator_left_close", ::rec_readyroom_elevator_left_close, "rec_readyroom_seq" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_left", "rec_readyroom_elevator_left_up", ::rec_readyroom_elevator_left_up, "rec_readyroom_seq" );
    maps\_anim::addnotetrack_customfunction( "ready_room_elevator_left", "rec_readyroom_elevator_left_open2", ::rec_readyroom_elevator_left_open2, "rec_readyroom_seq" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_player_exo_breach_start", ::rec_player_exo_breach_start, "training_s2_breach" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_s2_exfil_car_plr_start", ::rec_s2_exfil_car_plr_start, "training_s2_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_s2_exfil_car_plr_help_potus", ::rec_s2_exfil_car_plr_help_potus, "training_s2_player_end" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "rec_s2_exfil_car_plr_hand", ::rec_s2_exfil_car_plr_hand, "training_s2_player_end" );
    maps\_anim::addnotetrack_customfunction( "president", "rec_s2_exfil_potus_start", ::rec_s2_exfil_potus_start, "training_s2_president_end" );
    maps\_anim::addnotetrack_customfunction( "president", "rec_s2_exfil_potus_enter_car", ::rec_s2_exfil_potus_enter_car, "training_s2_president_end" );
    maps\_anim::addnotetrack_customfunction( "irons", "training_2_irons_ending", ::training_2_irons_ending, "training_s2_irons_helicopter" );
    maps\_anim::addnotetrack_customfunction( "warbird", "rec_t2_warbird_start", ::rec_t2_warbird_start, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "rec_t2_warbird_decloak", ::rec_t2_warbird_decloak, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "rec_t2_warbird_land", ::rec_t2_warbird_land, "warbird_landing" );
    maps\_anim::addnotetrack_customfunction( "warbird", "rec_t2_warbird_door_open", ::rec_t2_warbird_door_open, "warbird_takeoff" );
    maps\_anim::addnotetrack_customfunction( "joker", "rec_guy_doubledoor_breach_start", ::rec_guy_doubledoor_breach_start, "training_s1_patio_joker_door_out" );
    maps\_anim::addnotetrack_customfunction( "gideon", "rec_guy_doubledoor_breach_start", ::rec_guy_doubledoor_breach_start, "training_s2_patio_gideon_door_out" );
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "recovery_global_mix" );
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "aud_auto_combat_music" );
    common_scripts\utility::flag_set( "aud_auto_combat_music" );
    level.player maps\_utility::ent_flag_init( "overdrive_on" );
}

init_globals()
{
    level.aud.last_repair_weights = [];
    level.aud.repair_weights = [];
}

launch_threads()
{
    thread rec_funeral_21_gun_salute();
    thread setup_funeral_ambi_fade();
    thread setup_lightning_transition();
    thread register_notetracks();
    thread setup_training_01_end_ambi_swap();
    thread setup_training_01_end_compound_ambi_emitter();
    thread play_vrap_sounds();
    thread rec_tour_hangar_background();
    thread setup_training_02_breach_smartglass();
}

launch_loops()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_rack_lp", ( -4464, 3413, 37 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_rack_lp", ( -4694, 4488, 37 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_floor_fan_lp", ( -4587, 2980, 69 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_floor_fan_lp", ( -4985, 2977, 69 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_floor_fan_lp", ( -4964, 3415, 69 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_floor_fan_lp", ( -4796, 3721, 33 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_floor_fan_lp", ( -4796, 3721, 33 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_rack_lp", ( -5830, 4007, 35 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_hdd_lp", ( -5810, 3763, 35 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_light_buzz_lp", ( -5824, 4028, 152 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_light_buzz_lp", ( -5833, 3751, 152 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_light_buzz_lp", ( -6020, 3815, 157 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_rack_lp", ( -3163, -301, -76 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_rack_lp", ( -2973, -595, -76 ) );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "emt_rec_cpu_rack_lp", 2, undefined, ( -3163, -301, -76 ) );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "emt_rec_cpu_rack_lp", 4, undefined, ( -3327, -411, -96 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cpu_hdd_lp", ( -3163, -301, -76 ) );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "emt_rec_cpu_hdd_lp", 4, undefined, ( -3327, -411, -96 ) );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "emt_rec_cpu_hdd_lp", 7, undefined, ( -3327, -501, -96 ) );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
    level.aud.envs["player_drone_pitch"] = [ [ 0, 0.75 ], [ 15, 0.9 ], [ 30, 1.1 ] ];
    level.aud.envs["player_drone_volume"] = [ [ 0, 0.5 ], [ 15, 0.9 ], [ 30, 1.0 ] ];
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

    if ( var_3 == "ext_atlas_base" || var_3 == "ext_lodge" )
    {
        _func_2CC( "weapons" );
        _func_2CC( "tactical" );
        _func_2CC( "vehicles" );
        _func_2CC( "foley" );
    }

    if ( var_3 == "int_training_facility_lobby" || var_3 == "int_training_facility" || var_3 == "int_training_facility_02" || var_3 == "int_operating_room" || var_3 == "int_firing_range_stairway" || var_3 == "int_firing_range" || var_3 == "int_weapons_room" || var_3 == "int_lodge" )
    {
        _func_2CC( "weapons", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
        _func_2CC( "tactical", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
        _func_2CC( "vehicles", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
        _func_2CC( "foley", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
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
    var_2 = 0.4;
    var_3 = 0.3;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    switch ( var_0 )
    {
        case "rec_funeral_eulogy_ends_irons":
            soundscripts\_audio::aud_set_music_submix( 1, 0 );
            wait 14;
            soundscripts\_audio_music::mus_play( "rec_mus_funeral", 4 );
            break;
        case "start_intro_stealth":
            soundscripts\_audio::aud_set_music_submix( var_2, 0 );
            wait 1;
            soundscripts\_audio_music::mus_play( "rec_mus_intro_stealth", 10 );

            for (;;)
            {
                var_6 = common_scripts\utility::flag( "aud_auto_combat_music" );

                if ( soundscripts\_snd_common::snd_get_num_enemies_aware() > 0 )
                {
                    if ( !var_5 && var_6 )
                    {
                        soundscripts\_audio::aud_set_music_submix( var_3, 10 );
                        soundscripts\_audio_music::mus_play( "rec_mus_intro_combat_lp", 3 );
                        var_4 = 0;
                        var_5 = 1;
                    }
                    else
                    {
                        soundscripts\_audio::aud_set_music_submix( 0, 4 );
                        var_4 = 0;
                        var_5 = 0;
                    }
                }
                else if ( !var_4 )
                {
                    soundscripts\_audio::aud_set_music_submix( var_2, 10 );
                    soundscripts\_audio_music::mus_play( "rec_mus_intro_stealth", 3 );
                    var_4 = 1;
                    var_5 = 0;
                }

                wait 1;
            }

            break;
        case "intro_approaching_north_access_road":
            soundscripts\_snd_common::snd_wait_for_enemies_see_player();
            wait 1;
            soundscripts\_audio::aud_set_music_submix( var_3, 8 );
            soundscripts\_audio_music::mus_play( "rec_mus_intro_combat_lp", 5 );
            break;
        case "rec_sim_reveal_gideon":
            soundscripts\_audio::aud_set_music_submix( 0.75, 4 );
            wait 4.5;
            soundscripts\_audio_music::mus_play( "rec_mus_intro_combat_end", 1, 2 );
            level waittill( "rec_gdn_noexcuseforequipmentfailure_done" );
            soundscripts\_audio_music::mus_play( "rec_mus_sim1_end" );
            break;
        case "rec_mus_tour_ride_end":
            var_7 = var_1;
            soundscripts\_audio_mix_manager::mm_add_submix( "rec_base_entrance_vo", var_7 );
            soundscripts\_audio::aud_set_music_submix( 0.45, var_1 );
            wait(var_1);
            soundscripts\_audio_music::mus_play( "rec_mus_tour_ride_end", 2.0 );
            level waittill( "sound_done_rec_irs_nowgogetthatarm" );
            soundscripts\_audio_mix_manager::mm_clear_submix( "rec_base_entrance_vo", 3.0 );
            break;
        case "firing_range_activating":
            soundscripts\_audio::aud_set_music_submix( 0.6, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_firing_range_lp", 2.0 );
            break;
        case "firing_range_deactivating":
            soundscripts\_audio::aud_set_music_submix( 0.6, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_firing_range_end", 2.0 );
            break;
        case "grenade_range_begin_phase1":
            soundscripts\_audio::aud_set_music_submix( 0.8, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_grnd_trnng_01_lp", 2.0 );
            break;
        case "grenade_range_begin_phase2":
            soundscripts\_audio::aud_set_music_submix( 0.75, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_grnd_trnng_02_lp", 2.0 );
            break;
        case "grenade_range_end_phase2":
            soundscripts\_audio::aud_set_music_submix( 0.75, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_grnd_trnng_02_end", 2.0 );
            break;
        case "sim2_complete":
            soundscripts\_audio::aud_set_music_submix( 0.75, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_grnd_trnng_02_lp", 6.0 );
            break;
        case "final_combat":
            soundscripts\_audio::aud_set_music_submix( 0.75, 1.0 );
            soundscripts\_audio_music::mus_play( "rec_grnd_trnng_02_end", 2.0 );
            break;
        case "rec_level_ending":
            soundscripts\_audio::aud_set_music_submix( 0.4, 0 );
            wait 0.05;
            soundscripts\_audio_music::mus_play( "rec_mus_level_ending", 2 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

start_funeral()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_funeral" );
    thread funeral_submix_handler();
    soundscripts\_snd_playsound::snd_play_loop_at( "walla_funeral", ( 6504, -43267, 132 ), "stop_walla_funeral", 6.0, 4.0 );
}

start_training_01()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_lodge" );
}

start_training_01_lodge()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
    music( "start_intro_stealth" );
}

start_training_01_lodge_breach()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
    music( "start_intro_stealth" );
}

start_training_01_lodge_exit()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
    music( "start_intro_stealth" );
}

start_training_01_golf_course()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_lodge" );
    music( "start_intro_stealth" );
}

start_training_01_end()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_exfil" );
}

start_tour_ride()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_exfil" );
}

start_tour_exo()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_atlas_base" );
}

start_tour_exo_exit()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_training_facility" );
}

start_tour_firing_range()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_atlas_base" );
}

start_tour_augmented_reality()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_atlas_base" );
}

start_tour_end()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_atlas_base" );
}

start_training_02()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_lodge" );
}

start_training_02_lodge()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
}

start_training_02_lodge_breach()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
}

start_training_02_lodge_exit()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lodge" );
}

start_training_02_golf_course()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_lodge" );
    music( "sim2_complete" );
}

start_training_02_end()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_exfil" );
    music( "sim2_complete" );
}

funeral_submix_handler()
{
    waitframe();
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_funeral" );
    level waittill( "funeral_done" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_funeral" );
}

eulogy_irons_stand( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_irons_stand" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_irons_stand", 0.0 );
}

eulogy_irons_touch( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_irons_touch" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_irons_touch", 0.0 );
}

eulogy_irons_leave( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_irons_leave" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_irons_leave", 0.0 );
}

eulogy_cormack_approach( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_cormack_approach" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_cormack_approach", 0.0 );
}

eulogy_cormack_touch( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_cormack_touch" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_cormack_touch", 0.0 );
}

eulogy_cormack_leave( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_cormack_leave" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_eulogy_cormack_leave", 0.0 );
}

eulogy_player_touch( var_0 )
{
    soundscripts\_snd::snd_slate( "eulogy_player_touch" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_eulogy_player_touch", 0.4 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_eulogy_player_release", 0.07 );
}

atlascard_cormack_walk( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_cormack_walk" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_cormack_walk", 0.0 );
}

atlascard_irons_turn( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_turn" );
}

atlascard_irons_walk( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_walk" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_walk", 0.0 );
}

atlascard_irons_handshake( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_handshake" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_handshake", 0.0 );
}

atlascard_irons_place_hand( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_place_hand" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_place_hand", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_place_hand_fs", 0.3 );
}

atlascard_irons_tap( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_tap" );
    level notify( "aud_start_21_gun_salute" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_tap", 0.0 );
}

atlascard_irons_grab_card( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_grab_card" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_grabs_card", 0.0 );
}

atlascard_irons_leave( var_0 )
{
    soundscripts\_snd::snd_slate( "atlascard_irons_leave" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_atlascard_irons_leave", 0.0 );
}

rec_funeral_21_gun_salute()
{
    level waittill( "aud_start_21_gun_salute" );
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_funeral_salute" );
    maps\_utility::delaythread( 10.0, maps\recovery_utility::play_rumble_funeral_gun_salute );
    soundscripts\_snd::snd_slate( "21_gun_salute" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_vo_01", 7.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_foley_02", 9.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_vo_02", 10.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_shot_02", 10.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_vo_03", 14.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_foley_03", 16.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_shot_03", 14.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_funeral_salute_thunder", 18.0 );
    level notify( "stop_walla_funeral" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_funeral_salute" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_funeral_ambi_fade", 10 );
}

campdavid_player_arm_reveal( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: campdavid_player_arm_reveal" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_reveal_exo", 0.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_reveal_gun", 2.35 );
}

rec_threat01_joker_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_joker_steps", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_joker_gear", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_joker_door", 0.0 );
}

rec_threat01_joker_kick( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_kick_joker_steps", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_kick_joker_gear", 0.0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_threat_breach_foley" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_kick_joker_windup", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_kick_joker_door", 0.1 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_threat_kick_joker_door_otherside", 0.1 );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_threat_breach_foley" );
}

rec_mute01_joker_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_mute_01_joker_start" );
}

rec_mute01_joker_breach( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_mute_01_joker_breach" );
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_charge_loop_management", 0.5 );
}

camp_david_training_mute_device( var_0, var_1 )
{
    var_2 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_s1_mute_breach" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_off" );
    level.player _meth_8518();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "mute" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mute_device_activate", 0.5 );
    wait 1.25;
    var_2 thread soundscripts\_snd_common::snd_mute_device( "mute_device", var_0, var_0 + 250, var_1, "mute_device" );
    var_2 thread aud_stop_training_mute_device();
}

aud_stop_training_mute_device()
{
    level waittill( "training_s1_breach_enemy_dead" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "mute" );
    level.player _meth_8519();
    self notify( "turn_off" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_s1_mute_breach" );
}

rec_mute01_joker_run( var_0 )
{

}

rec_mute01_joker_kick( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_mute_01_joker_kick" );
}

rec_mute_breach_slo_mo1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_mute_slo_mo", "kill_slo_mo", undefined, 0.5 );
    wait(var_0);
    level notify( "kill_wall_hit_sound" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
}

rec_chair_kva_gets_shot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "bullet_flesh_slo_mo", var_0 );
}

rec_kva_with_president_gets_shot( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "bullet_flesh_slo_mo", var_0 );
}

rec_mute01_joker_turn( var_0 )
{

}

rec_mute01_kva_with_gun_killed( var_0 )
{

}

rec_mute01_kva_kicked( var_0 )
{
    wait 1.25;
    level notify( "kill_slo_mo" );
}

rec_mute01_kva_hits_wall( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_mute_01_kva_hits_wall", "kill_wall_hit_sound" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cabin_sglass_brkn_lp", ( -2908, -5304, 376 ), "stop_electronic_emitters_sim_01", 1, 1 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_charge_loop_management" );
}

rec_mute01_chair_kva_killed( var_0 )
{

}

rec_mute01_potus_free( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_joker_potus_rescue" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_joker_training_01_potus_rescue", 1.25 );
    wait 8;
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_joker_potus_rescue" );
}

rec_s1_president_killed()
{
    if ( isdefined( level.president ) )
        level.president soundscripts\_snd_playsound::snd_play_linked( "bullet_flesh_slo_mo" );
}

rec_bathroom_guy( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_mute_01_bathroom_guy" );
}

rec_plr_kills_president( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "bullet_flesh_slo_mo", var_0 );
}

rec_training01_lodge_stealth_exit_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_stealth_exit_joker_steps", 8.6 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_stealth_exit_joker_gear", 8.3 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_stealth_exit_joker_texture", 8.3 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_stealth_exit_joker_door", 8.6 );
}

rec_training01_lodge_stealth_open( var_0 )
{

}

rec_training01_lodge_stealth_exit_end( var_0 )
{

}

rec_s1_drones_fly_by( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "Drone Flyby 1 Start" );
    var_1 = var_0[0];
    soundscripts\_audio_mix_manager::mm_add_submix( "training_1_drone_patrol" );
    var_2 = "kill_fly_by_on_attack" + soundscripts\_snd::snd_new_guid();
    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_patrol_flyby", var_2 );
    thread rec_s1_drones_wait_for_attack( var_2 );
    wait 25;
    soundscripts\_audio_mix_manager::mm_clear_submix( "training_1_drone_patrol" );
    level notify( "s1_drones_complete" );
}

rec_s1_drones_wait_for_attack( var_0 )
{
    level endon( "s1_drones_complete" );
    level waittill( "s1_drones_attacking" );
    level notify( var_0 );
}

rec_s1_drones_attack( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "Drone Flyby 1 Turn" );
    var_1 = var_0[0];

    if ( !isalive( var_1 ) )
    {
        if ( isalive( var_0[1] ) )
            var_1 = var_0[1];
        else if ( isalive( var_0[2] ) )
            var_1 = var_0[2];
        else
            return;
    }

    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_alert" );
    wait 3.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "training_1_drone_patrol" );
    soundscripts\_audio_mix_manager::mm_add_submix( "training_1_drone_patrol_attack" );
    level notify( "s1_drones_attacking" );

    if ( !isalive( var_1 ) )
    {
        if ( isalive( var_0[1] ) )
            var_1 = var_0[1];
        else if ( isalive( var_0[2] ) )
            var_1 = var_0[2];
        else
            return;
    }

    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_attack" );

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && !_func_294( var_3 ) )
            var_3 waittill( "death" );
    }

    soundscripts\_audio_mix_manager::mm_clear_submix( "training_1_drone_patrol_attack" );
}

rec_drone_scanner()
{
    soundscripts\_snd::snd_printlnbold( "Drone Flyby 1 Scan" );
    wait 1.6;
    soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_patrol_scan" );
}

patio_flashbang( var_0, var_1 )
{
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_at( "rec_s1_flash_bang", var_1 );
}

rec_train1_stealth_car_spawn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_stealth_car_engine", "stealth_car_alerted" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_stealth_car_sfx", "stealth_car_alerted" );
}

rec_train1_stealth_car_stop( var_0 )
{
    level notify( "stealth_car_alerted" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_stealth_car_stop_engine" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_stealth_car_stop_sfx" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_stealth_car_stop_lfe" );
}

s1_popping_smoke( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "wpn_smoke_grenade_exp", var_0 );
}

rec_train1_exfil_car_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "1st_time_exfil_truck" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_exfil_car_enter_engine" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_loop_linked( "rec_train_1_exfil_car_idle_loop", 5.372, 0, "exfil_loop_stop" );
}

training_01_end_player_arm_malfunction( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: car door arm malfunctions" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "1st_time_exfil_truck" );
    soundscripts\_audio_mix_manager::mm_add_submix( "training_1_end_scene", 2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_plr_try_handle", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_door_malfunction_exo", 1.45 );
    level notify( "stop_electronic_emitters_sim_01" );
}

training_01_end_gideon_walk( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_gideon_emerge" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_branch_snap" );
}

training_01_end_player_punched( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_plr_fall" );
    level notify( "stop_rain_quads" );
}

training_01_end_gideon_punch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_punch" );
}

training_01_end_potus_threatened( var_0 )
{

}

training_01_end_gideon_pulls_gun( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_gun_draw" );
}

training_01_end_potus_shot( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_potus_shot" );
}

training_01_end_gideon_shoots_potus( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_gun_shot" );
}

training_01_end_gideon_to_player( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_to_plr" );
}

training_01_end_gideon_mask( var_0 )
{

}

training_01_end_gideon_gun_away( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_gun_away" );
}

rec_train1_end()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_reveal_reset", 2.782 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_reveal_door", 5.464 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_reveal_amb1", 4.952 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_reveal_amb2", 35.29 );

    if ( isdefined( level.escape_vehicle ) )
        level.escape_vehicle soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_1_exfil_car_shutoff", 5 );

    wait 5;
    level notify( "exfil_loop_stop" );
}

tour_jeep_startup()
{
    soundscripts\_snd::snd_slate( "tour_jeep_startup" );
    level.cart soundscripts\_snd_playsound::snd_play_linked( "rec_tour_jeep_start" );
    wait 3.43;
    level.cart soundscripts\_snd_playsound::snd_play_loop_linked( "rec_tour_jeep_idle_lp", "rec_tour_jeep_idle_stop", undefined, 1.0 );
}

training_01_end_potus_gets_up( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_1_end_potus_getup", 0.5 );
    level notify( "start_compound_ambi_emitter" );
}

training_01_end_player_helped_up( var_0 )
{

}

training_01_end_gideon_helps_up_plr( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_gideon_helps_up_plr" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_help_up" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_train_1_end_plr_getup", 0.75 );
}

training_01_end_irons_exit_jeep( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_irons_exit_jeep" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_irons_arrives" );
}

training_01_end_player_arm_up( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_player_arm_up" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_plr_arm_up" );
}

training_01_end_gideon_grabs_arm( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_gideon_grabs_arm" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_gideon_arm_grab" );
}

training_01_end_gideon_idles( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_gideon_idles" );
}

training_01_end_irons_hand_on_shoulder( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_irons_hand_on_shoulder" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_irons_shoulder" );
}

training_01_end_gideon_walks_away( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_gideon_walks_away" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_gideon_to_jeep" );
}

training_01_end_irons_walk_away( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_irons_walks_away" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_irons_returns" );
}

training_01_end_irons_enter_jeep( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_Irons_enter_jeep" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_irons_in_jeep" );
}

training_01_end_player_enters_jeep( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_player_enters_jeep" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_train_1_end_plr_jeep_enter" );
    soundscripts\_audio_mix_manager::mm_add_submix( "irons_jeep_tour" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_training_01_ambis", 15 );
}

training_01_end_driver_seat_movement( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_driver_seat_movement" );
}

training_01_end_player_moves_to_seat( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_player_moves_to_seat" );
}

training_01_end_player_sits( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_player_sits" );
}

training_01_end_gideon_enter_jeep( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_gideon_enter_jeep" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_gideon_jeep_enter" );
}

training_01_end_driver_gear_shift( var_0 )
{
    soundscripts\_snd::snd_slate( "training_01_end_driver_gear_shift" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_1_end_driver_gear" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "training_1_end_scene" );
}

rec_training1_jeep_enter( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_training1_jeep_enter" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_tour_jeep_enter_sfx" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_tour_jeep_enter_eng" );
}

rec_training1_jeep_arrive( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_training1_jeep_arrive" );
}

rec_training1_jeep_irons_door_open( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_training1_jeep_irons_door_open" );
}

rec_training1_jeep_irons_door_close( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_training1_jeep_irons_door_close" );
}

rec_training1_jeep_player_door_close( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_training1_jeep_player_door_close" );
}

rec_tour_ride_driver_gear_shift( var_0 )
{
    soundscripts\_snd::snd_slate( "SLATE: rec_tour_ride_driver_gear_shift" );
}

rec_tour_ride_veh_rightdoor_open( var_0 )
{
    soundscripts\_snd::snd_slate( "SLATE: rec_tour_ride_veh_rightdoor_open" );
}

rec_tour_ride_veh_leftdoor_open( var_0 )
{
    soundscripts\_snd::snd_slate( "SLATE: rec_tour_ride_veh_leftdoor_open" );
}

rec_tour_ride_veh_rightdoor_close( var_0 )
{
    soundscripts\_snd::snd_slate( "SLATE: rec_tour_ride_veh_rightdoor_close" );
}

rec_tour_vtol_takeoff_spawn( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_tour_vtol_takeoff_spawn" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_warbird_takeoff", 3.05 );
}

rec_littlebird_formation_spawn( var_0 )
{
    if ( var_0.vehicle_spawner.targetname == "littlebird_formation" )
        soundscripts\_snd::snd_printlnbold( "SLATE: rec_littlebird_formation_spawn" );
    else if ( var_0.vehicle_spawner.targetname == "pf4_auto2369" )
    {
        soundscripts\_snd::snd_printlnbold( "SLATE: rec_littlebird_flyover" );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_lb_flyby", 2.8 );
    }
}

rec_tour_vehicle_1_start( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "rec_tour_vehicle_1_start" );
    level notify( "rec_tour_jeep_idle_stop" );
    level.cart soundscripts\_snd_playsound::snd_play_2d( "rec_tour_jeep_sfx_front" );
    level.cart soundscripts\_snd_playsound::snd_play_2d( "rec_tour_jeep_sfx_rear" );
    level.cart soundscripts\_snd_playsound::snd_play_2d( "rec_tour_jeep_eng" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_civi_sedan", 16.149 );
}

civ_domestic_truck_spawn( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "civ_domestic_truck_spawn" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_tour_civi_truck_front", 7.273 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_tour_civi_truck_rear", 7.273 );
}

tour_drones_fly_by()
{
    soundscripts\_snd::snd_slate( "tour_drones_fly_by" );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_three_drones_fly_by" );
}

attack_drone_flybys_audio()
{
    var_0 = "rec_tour_drone_flyby";
    var_1 = [];
    var_1[0] = 800;
    var_2 = [];
    var_2[0] = 20;
    var_2[1] = 5;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_0, undefined, var_1, var_2, 1, undefined, undefined, 3, 2 );
}

rec_tour_ride_irons_turns_to_plr( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_tour_ride_irons_turns_to_plr" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_end_irons_turn" );
}

tour_littlebird_lander( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "tour_littlebird_lander" );
    wait 1.3;
    soundscripts\_snd_playsound::snd_play_2d( "rec_tour_lb_lander_fronts" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_lb_lander_ent" );
}

vrap_spawn( var_0 )
{
    level notify( "aud_new_vrap", var_0 );
}

rec_tour_titan_gate_plr_open( var_0 )
{
    soundscripts\_snd::snd_slate( "Gate that the player drives through as the Titan passes by opens." );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_locks", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_move", 0.1 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_buzzer", 0.0 );
}

rec_tour_titan_1_start( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "rec_tour_titan_1_start" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_base_titan_drive_by", 0.0 );
}

rec_tour_escort_jeep_start( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "rec_tour_escort_jeep_start" );
}

rec_tour_ride_irons_gestures( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_end_irons_gesture" );
}

rec_tour_titan_2_walk_anim_start( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "rec_tour_titan_2_walk_anim_start" );
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "walker_walking_mech", 0.2 );
    wait 12.5;
    var_1 _meth_804F();
}

rec_tour_hangar_background()
{
    var_0 = ( -64, 8793, 232 );
    common_scripts\utility::flag_wait( "flag_titan_crossing" );
    soundscripts\_snd_playsound::snd_play_delayed_at( "rec_tour_hangar_background", var_0, 14.25, undefined, "kill_hangar_emitters" );
    level waittill( "sounddone" );
    level notify( "kill_hangar_emitters" );
}

tour_hangar_drones( var_0 )
{
    var_1 = var_0[0];
    var_2 = var_0[3];
    var_3 = var_0[8];
    var_4 = var_0[11];
    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_hangar_drone_land_01" );
    var_2 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_hangar_drone_land_02" );
    var_3 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_hangar_drone_land_03" );
    var_4 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_hangar_drone_land_04" );
    wait 13;
    soundscripts\_audio_mix_manager::mm_add_submix( "irons_jeep_tour_exit_hanger", 3 );
}

rec_tour_end_jeep_gate_plr_open( var_0 )
{
    soundscripts\_snd::snd_slate( "Gate that the player drives through at the end of the tour opens." );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_locks", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_move", 0.1 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_tour_gate_buzzer", 0.0 );
}

rec_tour_end_jeep_gate_plr_close( var_0 )
{
    soundscripts\_snd::snd_slate( "Gate that the player drives through at the end of the tour closes." );
}

rec_tour_ride_irons_waves( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_end_irons_wave" );
}

rec_tour_npc_jeep_exit_gate_open( var_0 )
{
    soundscripts\_snd::snd_slate( "Gate that the NPCs drive through opens." );
}

rec_tour_npc_jeep_exit_gate_close( var_0 )
{
    soundscripts\_snd::snd_slate( "Gate that the NPCs drive through closes." );
}

tour_littlebird_ambient( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "tour_littlebird_ambient" );
}

rec_tour_ride_gid_hand_on_door( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_end_gid_open_door" );
}

rec_tour_ride_gid_exits_jeep( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_end_gid_exit_jeep" );
}

rec_tour_ride_plr_door( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_tour_end_plr_open_door" );
}

rec_tour_ride_plr_exits_jeep( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_tour_end_plr_exit_jeep" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "irons_jeep_tour_exit_hanger", 5 );
}

rec_tour_ride_veh_leftdoor_close( var_0 )
{
    soundscripts\_snd::snd_slate( "SLATE: rec_tour_ride_veh_leftdoor_close" );
    level.cart soundscripts\_snd_playsound::snd_play_linked( "rec_tour_jeep_exit_sfx" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "irons_jeep_tour" );
}

audio_push_1_box_pickup( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_pickup" );
}

audio_push_1_box_drop( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_drop" );
}

audio_push_1_box_push( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_push" );
}

audio_push_1_crane_move_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_01_crane_move_01" );
}

audio_push_1_crane_move_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_01_crane_move_02" );
}

audio_push_1_crane_move_3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_01_crane_move_03" );
}

audio_push_2_box_pickup( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_pickup" );
}

audio_push_2_box_drop( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_drop" );
}

audio_push_2_box_push( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_box_push" );
}

audio_push_2_crane_move_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_02_crane_move_01" );
}

audio_push_2_crane_move_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_02_crane_move_02" );
}

audio_push_2_crane_move_3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_pusher_02_crane_move_03" );
}

exo_climb_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_climb" );
}

exo_repair_vm_sit( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: exo_repair_vm_sit" );
}

exo_repair_vm_place_arm( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: exo_repair_vm_place_arm" );
}

exo_repair_desk_unfold( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: exo_repair_desk_unfold" );
    soundscripts\_snd_playsound::snd_play_at( "arm_bench_door_open", ( -6483.47, 3861.26, 29.793 ) );
    common_scripts\utility::flag_wait( "tour_exo_arm" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_sit_foley", 0.1 );
}

repair_desk_harness_close( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_harness_close" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_harness_close", 0.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_grab_insert_needle", 3.7 );
}

repair_desk_grab_needle( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_grab_needle" );
}

repair_desk_align_needle( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_align_needle" );
}

repair_desk_push_needle( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_push_needle" );
}

rec_exo_arm_repair_attempt_01_npc()
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_exo_arm_repair_attempt_01_npc" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_lab_tech_computer_01", 0.05 );
}

rec_exo_arm_repair_attempt_02_npc()
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_exo_arm_repair_attempt_02_npc" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_lab_tech_computer_02", 0.05 );
}

rec_exo_arm_repair_attempt_03_npc()
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_exo_arm_repair_attempt_03_npc" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_lab_tech_computer_03", 0.75 );
}

exo_repair_movement( var_0 )
{
    level endon( "audio_repair_done" );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        level waittill( "audio_repair_weights_updated" );

        if ( level.aud.repair_weights["anim_up"] - 0.1 > level.aud.last_repair_weights["anim_up"] || level.aud.repair_weights["anim_down"] + 0.1 < level.aud.last_repair_weights["anim_down"] )
        {
            if ( var_2 == 1 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Up" );
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Down" );
                play_exo_repair_movement_sound( var_0 );
                var_2 = -1;
            }
            else if ( var_2 == 0 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Down" );
                play_exo_repair_movement_sound( var_0 );
                var_2 = -1;
            }
        }
        else if ( level.aud.repair_weights["anim_down"] - 0.1 > level.aud.last_repair_weights["anim_down"] || level.aud.repair_weights["anim_up"] + 0.1 < level.aud.last_repair_weights["anim_up"] )
        {
            if ( var_2 == -1 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Down" );
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Up" );
                play_exo_repair_movement_sound( var_0 );
                var_2 = 1;
            }
            else if ( var_2 == 0 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Up" );
                play_exo_repair_movement_sound( var_0 );
                var_2 = 1;
            }
        }
        else
        {
            if ( var_2 == 1 )
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Up" );
            else if ( var_2 == -1 )
                soundscripts\_snd::snd_printlnbold( "Exp Repair - Stop Down" );

            var_2 = 0;
        }

        if ( level.aud.repair_weights["anim_left"] - 0.1 > level.aud.last_repair_weights["anim_left"] || level.aud.repair_weights["anim_right"] + 0.1 < level.aud.last_repair_weights["anim_right"] )
        {
            if ( var_1 == 1 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Right" );
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Left" );
                play_exo_repair_movement_sound( var_0 );
                var_1 = -1;
            }
            else if ( var_1 == 0 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Left" );
                play_exo_repair_movement_sound( var_0 );
                var_1 = -1;
            }

            continue;
        }

        if ( level.aud.repair_weights["anim_right"] - 0.1 > level.aud.last_repair_weights["anim_right"] || level.aud.repair_weights["anim_left"] + 0.1 < level.aud.last_repair_weights["anim_left"] )
        {
            if ( var_1 == -1 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Left" );
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Right" );
                play_exo_repair_movement_sound( var_0 );
                var_1 = 1;
            }
            else if ( var_1 == 0 )
            {
                soundscripts\_snd::snd_printlnbold( "Exo Repair - Start Right" );
                play_exo_repair_movement_sound( var_0 );
                var_1 = 1;
            }

            continue;
        }

        if ( var_1 == 1 )
            soundscripts\_snd::snd_printlnbold( "Exo Repair - Stop Right" );
        else if ( var_1 == -1 )
            soundscripts\_snd::snd_printlnbold( "Exp Repair - Stop Left" );

        var_1 = 0;
    }
}

exo_repair_weight_updates( var_0 )
{
    if ( level.aud.last_repair_weights.size == 0 )
        level.aud.last_repair_weights = var_0;
    else
        level.aud.last_repair_weights = level.aud.repair_weights;

    level.aud.repair_weights = var_0;
    level notify( "audio_repair_weights_updated" );
}

exo_repair_movement_stop()
{
    level notify( "audio_repair_done" );
}

play_exo_repair_movement_sound( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            soundscripts\_snd_playsound::snd_play_2d( "arm_bench_knuckle_move" );
            break;
        case 2:
            if ( randomint( 100 ) > 25 )
                soundscripts\_snd_playsound::snd_play_2d( "arm_bench_finger_move" );

            break;
        case 3:
            if ( randomint( 100 ) > 25 )
                soundscripts\_snd_playsound::snd_play_2d( "arm_bench_hand_move" );

            break;
        default:
            break;
    }
}

rec_exo_arm_repair_attempt_exit_npc()
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_remove_needle" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_remove_needle", 1.4 );
}

repair_desk_remove_needle( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_remove_needle" );
}

repair_desk_harness_release( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: repair_desk_harness_release" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_bench_remove_arm_exo", 0.65 );
}

exo_repair_vm_lift_arm( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: exo_repair_vm_lift_arm" );
}

exo_repair_vm_test_hand( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: exo_repair_vm_test_hand" );
}

audio_start_wrestling_exo_guy( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_sparring_guy_exo" );
}

audio_start_wrestling_guy2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_sparring_guy1" );
}

audio_start_wrestling_guy3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_sparring_guy2" );
}

audio_start_wrestling_guy4( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_sparring_guy3" );
}

audio_start_wrestling_guy5( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_tour_exo_sparring_guy4" );
}

exo_drone_flby( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "tour_drones_2" );
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_exo_fac_exit_drones_fly_by" );
    wait 12;
    soundscripts\_audio_mix_manager::mm_clear_submix( "tour_drones_2" );
}

tour_base_ambient_vehicle_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_walking_tour_vehicle1" );
}

shooting_range_transition1( var_0 )
{
    thread shooting_range_overdrive_watcher();
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_shooting_range" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_appear", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_panels_bell", 3.0 );
}

shooting_range_panels_up( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_shooting_range_panels_up", 0.0 );
}

shooting_range_enemy_spawn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_red_appear", 0.0 );
}

shooting_range_target_despawn()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_disappear", 0.0 );
}

shooting_range_enemy_shot( var_0, var_1 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_red_hit", 0.0 );
}

shooting_range_friendly_spawn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_green_appear", 0.0 );
}

shooting_range_friendly_shot( var_0, var_1 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_green_hit", 0.0 );
}

shooting_range_transition2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_appear", 0.0 );
}

shooting_range_transition3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_shooting_range_appear", 0.0 );
}

shooting_range_panels_down( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_shooting_range_panels_down", 0.0 );
    level waittill( "sounddone" );
}

tour_base_ambient_vehicle_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_walking_tour_vehicle2" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_shooting_range" );
    level notify( "aud_shooting_range_complete" );
}

smart_grenade_target_flip()
{
    soundscripts\_snd::snd_slate( "smart_grenade_target_flip" );
    soundscripts\_snd_playsound::snd_play_linked( "rec_ar_target_up" );
}

smart_grenade_target_move( var_0 )
{
    var_1 = "stop_target_move" + soundscripts\_snd::snd_new_guid();
    var_2 = 0.31;
    soundscripts\_snd::snd_slate( "smart_grenade_target_move" );
    soundscripts\_snd_playsound::snd_play_loop_linked( "rec_ar_target_move_lp", var_1 );
    wait(var_0 - var_2);
    level notify( var_1 );
    soundscripts\_snd_playsound::snd_play_linked( "rec_ar_target_cod" );
}

smart_grenade_target_move_back( var_0 )
{
    var_1 = "stop_target_move" + soundscripts\_snd::snd_new_guid();
    var_2 = 0.31;
    soundscripts\_snd::snd_slate( "smart_grenade_target_move_back" );
    soundscripts\_snd_playsound::snd_play_loop_linked( "rec_ar_target_move_back_lp", var_1 );
    wait(var_0 - var_2);
    level notify( var_1 );
    soundscripts\_snd_playsound::snd_play_linked( "rec_ar_target_cod" );
}

smart_grenade_target_hit()
{
    soundscripts\_snd::snd_slate( "smart_grenade_target_hit" );
}

smart_grenade_target_shot()
{
    soundscripts\_snd::snd_slate( "smart_grenade_target_shot" );
}

smart_grenade_target_flip_down()
{
    soundscripts\_snd::snd_slate( "smart_grenade_target_flip_down" );
    soundscripts\_snd_playsound::snd_play_linked( "rec_ar_target_down" );
}

smart_grenade_target_expire()
{
    if ( self.hit_type == "none" )
    {
        soundscripts\_snd::snd_slate( "smart_grenade_target_expire" );
        soundscripts\_snd_playsound::snd_play_linked( "rec_ar_target_down" );
    }
}

rec_readyroom_gideon_pushes_button( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_gideon_pushes_button" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_gideon_button", 0.01 );
}

rec_readyroom_elevator_right_open( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_readyroom_elevator" );
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_right_open" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_gates_close", 0.4 );
}

rec_readyroom_elevator_right_close( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_right_close" );
}

rec_readyroom_elevator_right_up( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_right_up" );
}

rec_readyroom_elevator_right_open2( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_right_open2" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_ext_gates_open", 0.15 );
}

rec_readyroom_elevator_left_open( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_left_open" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_gates_open", 0.4 );
}

rec_readyroom_elevator_left_close( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_left_close" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_gates_close", 0.0 );
}

rec_readyroom_elevator_left_up( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_left_up" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_rr_int_elevator_start", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_rr_int_elevator_move", 1.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_rr_ext_elevator_alarm", 5.6 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_rr_int_elevator_stop", 12.7 );
}

rec_readyroom_elevator_left_hatch_back( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_elevator_hatch_open", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_elevator_hatch_impact", 2.88 );
}

rec_readyroom_elevator_left_hatch_front( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_int_elevator_hatch_impact", 2.88 );
}

rec_readyroom_elevator_left_open2( var_0 )
{
    soundscripts\_snd::snd_slate( "rec_readyroom_elevator_left_open2" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_rr_ext_gates_open", 0.0 );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "rec_readyroom_elevator" );
}

rec_s2_door_guy_ambush()
{
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "door_guy_ambush" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_s2_door_guy_ambush" );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "door_guy_ambush" );
}

rec_s2_breach_gun_holster()
{
    soundscripts\_snd_playsound::snd_play_2d( "wpn_med_holster_plr" );
}

rec_player_exo_breach_start( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_player_exo_breach_start" );
    soundscripts\_audio_mix_manager::mm_add_submix( "training_2_breach" );
    soundscripts\_snd_timescale::snd_set_timescale( "slomo_timescale" );
    soundscripts\_snd_playsound::snd_play_2d( "rec_s2_breach_slomo_swing" );
}

rec_slomo_audio_handler()
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_s2_breach" );
}

rec_s2_breach_slo_mo( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "slomo" );
    level.player _meth_8518();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "slomo" );
    wait 0.05;
    soundscripts\_snd_playsound::snd_play_loop_2d( "overdrive_loop", "kill_slo_mo2", 0.25, 0.5 );
    wait(var_0);
    soundscripts\_snd_playsound::snd_play_2d( "rec_exit_slo_mo" );
    wait 0.5;
    level notify( "kill_slo_mo2" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "slomo" );
    level.player _meth_8519();
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "slomo" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "training_2_breach" );
}

rec_slomo_kill_bad_guy( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "bullet_flesh_slo_mo", var_0 );
}

aud_training_s2_potus_ziptie_release()
{
    soundscripts\_snd::snd_slate( "potus_ziptie_cut" );
    level.gideon soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_s2_breach_ziptie_cut", 5 );
}

rec_s2_drones_attack( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "Drone Flyby 2 Turn" );
    var_1 = var_0[0];

    if ( !isalive( var_1 ) )
    {
        if ( isalive( var_0[1] ) )
            var_1 = var_0[1];
        else if ( isalive( var_0[2] ) )
            var_1 = var_0[2];
        else
            return;
    }

    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_alert" );
    level notify( "s1_drones_attacking" );
    var_1 soundscripts\_snd_playsound::snd_play_linked( "rec_s1_drone_attack" );
}

rec_player_drone_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "s2_playable_drone" );
    level endon( "pdrone_end" );
    var_1 = var_0.origin;
    var_2 = level.player _meth_8340();
    var_3 = 0;

    for (;;)
    {
        var_4 = var_0.origin;
        var_5 = level.player _meth_8340();
        var_6 = abs( length( var_4 - var_1 ) );
        var_7 = var_5 - var_2;

        if ( var_7 > 0 )
        {
            if ( var_3 != -1 )
            {
                soundscripts\_snd_playsound::snd_play_2d( "wpn_wasp_scope_zoom_out" );
                var_3 = -1;
            }
        }
        else if ( var_7 < 0 )
        {
            if ( var_3 != 1 )
            {
                level.aud.zoominsound = soundscripts\_snd_playsound::snd_play_2d( "wpn_wasp_scope_zoom_in", "stop_zoominsound", 0, 0.25 );
                var_3 = 1;
            }
        }
        else if ( var_3 != 0 )
        {
            level notify( "stop_zoominsound" );
            var_3 = 0;
        }

        var_1 = var_4;
        var_2 = var_5;
        waitframe();
    }
}

rec_player_drone_end()
{
    level notify( "pdrone_end" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2_playable_drone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "drone_deploy" );
}

snd_player_drone_deploy( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "drone_deploy" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "assault_drone_deploy", 0.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "assault_drone_wrist_panel", 3.63 );
    wait 2.75;
    soundscripts\_snd_playsound::snd_play_at( "assault_drone_start", var_0.origin, "kill_player_op_drone_ext_loop", undefined, 1.5 );
}

snd_player_drone_wrist_panel()
{

}

snd_player_drone_enter_drone_pov()
{
    soundscripts\_snd_playsound::snd_play_2d( "assault_drone_start_pov" );
}

rec_s2_exfil_car_plr_start( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_s2_exfil_plr_start" );
}

rec_s2_exfil_car_plr_help_potus( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_s2_exfil_plr_help" );
}

rec_s2_exfil_car_plr_hand( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "rec_s2_exfil_plr_hand" );
}

rec_s2_exfil_potus_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_s2_exfil_potus_start" );
}

rec_s2_exfil_potus_enter_car( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_s2_exfil_potus_car" );
}

rec_train2_exfil_car_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_2_exfil_car_enter_engine", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_2_exfil_car_sfx_enter", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_2_exfil_car_puddle_enter", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_loop_linked( "rec_train_2_exfil_car_idle_loop", 5.205, 0, "exfil_car_exit" );
}

rec_train2_exfil_car_end( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "rec_train2_exfil_car_end" );
    soundscripts\_audio_mix_manager::mm_add_submix( "s2_exfil_drones" );
    level notify( "exfil_car_exit" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_2_exfil_car_exit_engine", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_train_2_exfil_car_sfx_exit", 8.182 );
}

rec_train2_ambush_car_2( var_0 )
{
    waitframe();
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_2_ambush_1_eng" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_2_ambush_1_sfx" );
}

rec_train2_ambush_car_1( var_0 )
{
    wait 2.402;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_2_ambush_2_eng" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_train_2_ambush_2_sfx" );
}

rec_t2_warbird_start( var_0 )
{
    level endon( "aud_irons_warbird_shutdown" );
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_t2_warbird_start" );
    soundscripts\_audio_mix_manager::mm_add_submix( "ending_warbird_pcap" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_ending_irons_warbird_flyover" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_ending_irons_warbird_landing", 3.05 );
    wait 15;
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "rec_ending_irons_warbird_idle_lp", "aud_irons_warbird_shutdown", 5, 20 );
}

rec_t2_warbird_decloak( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_t2_warbird_decloak" );
}

rec_t2_warbird_land( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_t2_warbird_land" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2_exfil_drones" );
}

rec_t2_warbird_door_open( var_0 )
{
    level notify( "aud_irons_warbird_shutdown" );
    soundscripts\_snd::snd_printlnbold( "SLATE: rec_t2_warbird_door_open" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_door_mech_a" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "warbird_door_mech_b" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "rec_ending_irons_warbird_shutdown" );
}

training_2_irons_ending( var_0 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: training_2_irons_ending" );
}

camp_david_thunder_transition()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_thunder_gun_turn_gear", 0.75 );
}

camp_david_reload_malfunction( var_0, var_1 )
{
    soundscripts\_snd::snd_printlnbold( "SLATE: Malfunction: " + var_0 + " : " + var_1 );

    switch ( var_0 )
    {
        case 1:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.2 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magout", 3.2 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_maggrab", 3.5 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magin", 4.26 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magsmack", 4.5 );
            break;
        case 2:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.267 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magout", 2.8 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_maggrab", 2.7 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magin", 3.59 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_bal27_magsmack", 3.9 );
            break;
        case 3:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.26 );
            break;
        case 4:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.202 );
            break;
        case 5:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.0 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_ak12_magout", 3.6 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_ak12_magin", 4.5 );
            break;
        case 6:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.198 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_ak12_magout", 3.6 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_ak12_magin", 4.3 );
            break;
        case 7:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.191 );
            break;
        case 8:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.02 );
            break;
        case 9:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.0 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_rhino_magout", 3.2 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_rhino_magin", 4.5 );
            break;
        case 10:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.2 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_rhino_magout", 2.7 );
            soundscripts\_snd_playsound::snd_play_delayed_2d( "rec_wpn_rhino_magin", 4.0 );
            break;
        case 11:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type1", 0.0 );
            break;
        case 12:
            soundscripts\_snd_playsound::snd_play_delayed_2d( "arm_malfunction_type2", 0.081 );
            break;
        default:
            break;
    }
}

rec_guy_doubledoor_breach_start( var_0 )
{
    if ( level.joker == var_0 )
    {
        soundscripts\_snd::snd_printlnbold( "SLATE: rec_guy_doubledoor_breach_start - Joker" );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_joker_steps", 2.45 );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_joker_gear", 2.45 );
        soundscripts\_audio_mix_manager::mm_add_submix( "rec_assault_exit_joker" );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_joker_texture", 2.45 );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_joker_door", 2.45 );
        wait 10;
        soundscripts\_audio_mix_manager::mm_clear_submix( "rec_assault_exit_joker" );
    }
    else if ( level.gideon == var_0 )
    {
        soundscripts\_snd::snd_printlnbold( "SLATE: rec_guy_doubledoor_breach_start - Gideon" );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_gideon_steps", 2.45 );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_gideon_gear", 2.45 );
        soundscripts\_audio_mix_manager::mm_add_submix( "rec_assault_exit_gideon" );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_gideon_texture", 2.45 );
        var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "rec_assault_exit_gideon_door", 2.45 );
        wait 10;
        soundscripts\_audio_mix_manager::mm_clear_submix( "rec_assault_exit_gideon" );
    }
}

rec_star_trek_door_open( var_0, var_1 )
{
    level endon( "aud_door_closing_" + var_0.targetname );
    level notify( "aud_door_opening_" + var_0.targetname );
    soundscripts\_snd_playsound::snd_play_at( "rec_star_trek_door_open_movement", ( var_0.origin + var_1.origin ) / 2, "aud_door_closing_" + var_0.targetname );
    wait 0.45;
    soundscripts\_snd_playsound::snd_play_at( "rec_star_trek_door_open_impact", ( var_0.origin + var_1.origin ) / 2 );
}

rec_star_trek_door_close( var_0, var_1 )
{
    level endon( "aud_door_opening_" + var_0.targetname );
    level notify( "aud_door_closing_" + var_0.targetname );
    soundscripts\_snd_playsound::snd_play_at( "rec_star_trek_door_close_movement", ( var_0.origin + var_1.origin ) / 2, "aud_door_opening_" + var_0.targetname );
    wait 0.45;
    soundscripts\_snd_playsound::snd_play_at( "rec_star_trek_door_close_impact", ( var_0.origin + var_1.origin ) / 2 );
}

setup_funeral_ambi_fade()
{
    common_scripts\utility::flag_wait( "eulogy_complete" );
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_funeral_ambi_fade", 10 );
}

setup_lightning_transition()
{
    common_scripts\utility::flag_wait( "player_proximity_irons" );
    var_0 = soundscripts\_audio_zone_manager::azm_get_current_zone();

    if ( var_0 == "ext_funeral" )
    {
        common_scripts\utility::flag_wait( "training_start_area_lighting" );
        soundscripts\_audio_zone_manager::azm_stop_zone( var_0, 0.5 );
        soundscripts\_audio_zone_manager::azm_start_zone( "ext_lodge", 0.5 );
    }

    return;
}

setup_training_01_end_ambi_swap()
{
    level waittill( "stop_rain_quads" );
    soundscripts\_snd_playsound::snd_play_loop_at( "rec_training_rain_ending", ( 1182, -2019, 63 ), "stop_rain_emitters", 2, 5 );
    soundscripts\_audio_mix_manager::mm_add_submix( "rec_training_01_ambis", 8 );
    wait 7;
    var_0 = soundscripts\_audio_zone_manager::azm_get_current_zone();

    if ( var_0 == "ext_exfil" )
    {
        wait 10;
        soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "ext_exfil", "amb_ext_compound", 10 );
    }

    common_scripts\utility::flag_wait( "flag_obj_base_start" );
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "ext_exfil", "amb_ext_forest_rain" );
    level notify( "stop_rain_emitters" );
}

setup_training_01_end_compound_ambi_emitter()
{
    level waittill( "start_compound_ambi_emitter" );
    soundscripts\_snd_playsound::snd_play_loop_at( "rec_training_ext_compound", ( 537, 9, 224 ), "stop_rain_emitters", 9, 5 );
}

play_vrap_sounds()
{
    if ( !isdefined( level.aud.vrapcount ) )
        level.aud.vrapcount = 0;

    for (;;)
    {
        level waittill( "aud_new_vrap", var_0 );
        level.aud.vrapcount += 1;

        switch ( level.aud.vrapcount )
        {
            case 1:
                soundscripts\_snd::snd_printlnbold( "vrap_1_spawn" );
                break;
            case 2:
                soundscripts\_snd::snd_printlnbold( "vrap_2_spawn" );
                break;
            default:
                soundscripts\_snd::snd_printlnbold( "Move vraps than we know what to do with" );
                break;
        }

        waitframe();
    }
}

shooting_range_overdrive_watcher()
{
    level endon( "aud_shooting_range_complete" );

    for (;;)
    {
        level.player maps\_utility::ent_flag_wait( "overdrive_on" );
        wait 0.25;
        soundscripts\_audio_mix_manager::mm_add_submix( "rec_shooting_range_overdrive" );
        level.player maps\_utility::ent_flag_waitopen( "overdrive_on" );
        soundscripts\_audio_mix_manager::mm_clear_submix( "rec_shooting_range_overdrive" );
        waitframe();
    }
}

setup_training_02_breach_smartglass()
{
    common_scripts\utility::flag_wait( "training_s2_start_charge" );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_rec_cabin_sglass_brkn_lp", ( -2908, -5304, 376 ), "stop_electronic_emitters_sim_02", 1, 1 );
}

temp_dog_bark( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "lag_dog_bark" );
}
