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
    init_notetracks();
}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "enter_water_override", ::enter_water_override );
    soundscripts\_snd::snd_register_message( "exit_water_override", ::exit_water_override );
    soundscripts\_snd::snd_register_message( "start_office", ::start_office );
    soundscripts\_snd::snd_register_message( "start_confrontation", ::start_confrontation );
    soundscripts\_snd::snd_register_message( "start_confrontation_qte", ::start_confrontation_qte );
    soundscripts\_snd::snd_register_message( "start_escape", ::start_escape );
    soundscripts\_snd::snd_register_message( "start_roof", ::start_roof );
    soundscripts\_snd::snd_register_message( "start_swim", ::start_swim );
    soundscripts\_snd::snd_register_message( "start_sewer", ::start_sewer );
    soundscripts\_snd::snd_register_message( "start_oldtown", ::start_oldtown );
    soundscripts\_snd::snd_register_message( "start_docks", ::start_docks );
    soundscripts\_snd::snd_register_message( "start_boat", ::start_boat );
    soundscripts\_snd::snd_register_message( "start_boatjump", ::start_boatjump );
    soundscripts\_snd::snd_register_message( "start_boatwarbird", ::start_boatwarbird );
    soundscripts\_snd::snd_register_message( "start_boatmall", ::start_boatmall );
    soundscripts\_snd::snd_register_message( "start_boatcrash", ::start_boatcrash );
    soundscripts\_snd::snd_register_message( "start_climb", ::start_climb );
    soundscripts\_snd::snd_register_message( "start_climbroof", ::start_climbroof );
    soundscripts\_snd::snd_register_message( "start_climbcrates", ::start_climbcrates );
    soundscripts\_snd::snd_register_message( "start_climbskybridge", ::start_climbskybridge );
    soundscripts\_snd::snd_register_message( "start_outro", ::start_outro );
    soundscripts\_snd::snd_register_message( "office_hallway_door_open", ::office_hallway_door_open );
    soundscripts\_snd::snd_register_message( "office_hallway_door_close", ::office_hallway_door_close );
    soundscripts\_snd::snd_register_message( "office_roof_door_open", ::office_roof_door_open );
    soundscripts\_snd::snd_register_message( "office_roof_door_close", ::office_roof_door_close );
    soundscripts\_snd::snd_register_message( "bet_gideon_arm_scanner", ::bet_gideon_arm_scanner );
    soundscripts\_snd::snd_register_message( "aud_scanner_door_open", ::aud_scanner_door_open );
    soundscripts\_snd::snd_register_message( "bet_hologram_start", ::bet_hologram_start );
    soundscripts\_snd::snd_register_message( "bet_holo_irons_shoot_pistol", ::bet_holo_irons_shoot_pistol );
    soundscripts\_snd::snd_register_message( "bet_conf_door_opens", ::bet_conf_door_opens );
    soundscripts\_snd::snd_register_message( "bet_conf_flash_bang_exp", ::bet_conf_flash_bang_exp );
    soundscripts\_snd::snd_register_message( "bet_conf_fire_suppression", ::bet_conf_fire_suppression );
    soundscripts\_snd::snd_register_message( "bet_conf_sprinkler", ::bet_conf_sprinkler );
    soundscripts\_snd::snd_register_message( "bet_conf_steam_lp", ::bet_conf_steam_lp );
    soundscripts\_snd::snd_register_message( "bet_conf_kill_guard", ::bet_conf_kill_guard );
    soundscripts\_snd::snd_register_message( "bet_conf_slo_mo_kick_start", ::bet_conf_slo_mo_kick_start );
    soundscripts\_snd::snd_register_message( "bet_conf_slo_mo_kick_stop", ::bet_conf_slo_mo_kick_stop );
    soundscripts\_snd::snd_register_message( "bet_conf_slo_mo_shoot_start", ::bet_conf_slo_mo_shoot_start );
    soundscripts\_snd::snd_register_message( "bet_conf_slo_mo_shoot_stop", ::bet_conf_slo_mo_shoot_stop );
    soundscripts\_snd::snd_register_message( "fire_door_1_open", ::fire_door_1_open );
    soundscripts\_snd::snd_register_message( "fire_door_1_close", ::fire_door_1_close );
    soundscripts\_snd::snd_register_message( "open_firedoor_for_guards", ::open_firedoor_for_guards );
    soundscripts\_snd::snd_register_message( "big_fire_door_open", ::big_fire_door_open );
    soundscripts\_snd::snd_register_message( "big_fire_door_close", ::big_fire_door_close );
    soundscripts\_snd::snd_register_message( "open_elevator_doors", ::open_elevator_doors );
    soundscripts\_snd::snd_register_message( "close_elevator_doors", ::close_elevator_doors );
    soundscripts\_snd::snd_register_message( "atlas_building_roof_walla", ::atlas_building_roof_walla );
    soundscripts\_snd::snd_register_message( "bet_escape_roof_slide", ::bet_escape_roof_slide );
    soundscripts\_snd::snd_register_message( "bet_escape_roof_slomo_start", ::bet_escape_roof_slomo_start );
    soundscripts\_snd::snd_register_message( "bet_escape_roof_slomo_end", ::bet_escape_roof_slomo_end );
    soundscripts\_snd::snd_register_message( "bet_roof_raise_blast_doors", ::bet_roof_raise_blast_doors );
    soundscripts\_snd::snd_register_message( "bet_roof_lower_blast_doors", ::bet_roof_lower_blast_doors );
    soundscripts\_snd::snd_register_message( "bet_roof_slide_start", ::bet_roof_slide_start );
    soundscripts\_snd::snd_register_message( "bet_roof_slo_mo_start", ::bet_roof_slo_mo_start );
    soundscripts\_snd::snd_register_message( "bet_roof_slo_mo_stop", ::bet_roof_slo_mo_stop );
    soundscripts\_snd::snd_register_message( "bet_roof_glass_hit", ::bet_roof_glass_hit );
    soundscripts\_snd::snd_register_message( "bet_roof_water_hit", ::bet_roof_water_hit );
    soundscripts\_snd::snd_register_message( "bet_ilona_swim_end", ::bet_ilona_swim_end );
    soundscripts\_snd::snd_register_message( "bet_swim_boat_explo", ::bet_swim_boat_explo );
    soundscripts\_snd::snd_register_message( "bet_swim_boat_hit_bottom", ::bet_swim_boat_hit_bottom );
    soundscripts\_snd::snd_register_message( "player_drowning_start", ::player_drowning_start );
    soundscripts\_snd::snd_register_message( "bet_swim_bullet_trails", ::bet_swim_bullet_trails );
    soundscripts\_snd::snd_register_message( "bet_swim_dock_explode", ::bet_swim_dock_explode );
    soundscripts\_snd::snd_register_message( "bet_swim_dock_debris_blocker", ::bet_swim_dock_debris_blocker );
    soundscripts\_snd::snd_register_message( "market_walla_init", ::market_walla_init );
    soundscripts\_snd::snd_register_message( "market_cleanup", ::market_walla_cleanup );
    soundscripts\_snd::snd_register_message( "add_doc_civ_walla", ::add_doc_civ_walla );
    soundscripts\_snd::snd_register_message( "ai_step_up_32", ::ai_step_up_32 );
    soundscripts\_snd::snd_register_message( "ai_mantle_over_low_cover_40", ::ai_mantle_over_low_cover_40 );
    soundscripts\_snd::snd_register_message( "ai_slide_across_car", ::ai_slide_across_car );
    soundscripts\_snd::snd_register_message( "ai_jump_over_40_down_88", ::ai_jump_over_40_down_88 );
    soundscripts\_snd::snd_register_message( "civ_boat_spawn", ::civ_boat_spawn );
    soundscripts\_snd::snd_register_message( "aud_impact_system_diveboat", ::aud_impact_system_diveboat );
    soundscripts\_snd::snd_register_message( "aud_ambient_helicopter", ::aud_ambient_helicopter );
    soundscripts\_snd::snd_register_message( "lock_on_target", ::lock_on_target );
    soundscripts\_snd::snd_register_message( "bet_boat_crash_audio_handler", ::bet_boat_crash_audio_handler );
    soundscripts\_snd::snd_register_message( "bet_boat_crash_bldg_impact", ::bet_boat_crash_bldg_impact );
    soundscripts\_snd::snd_register_message( "crate_path_start", ::crate_path_start );
    soundscripts\_snd::snd_register_message( "crate_move_start", ::crate_move_start );
    soundscripts\_snd::snd_register_message( "reverse_mag_glove_crane_move", ::reverse_mag_glove_crane_move );
    soundscripts\_snd::snd_register_message( "spawn_ending_pcap_warbird", ::spawn_ending_pcap_warbird );
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "betrayal_global_mix" );
}

init_snd_flags()
{

}

init_globals()
{
    level.aud.water = spawnstruct();
    level.aud.water.enter_water_override = "enter_water_override";
    level.aud.water.exit_water_override = "exit_water_override";
    level.aud.underwater = 0;
    level.aud.bet_walla_intro_patio = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread bet_foley_override_handler();
}

launch_loops()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 2490, 59585, -27 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 2338, 59585, -27 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 2425, 59497, -20 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 2940, 59585, -20 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 3088, 59585, -20 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 1170, 62789, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 1170, 62789, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 1718, 62781, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 1718, 62781, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 1871, 62449, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 1871, 62449, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 1170, 62429, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 1026, 62286, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 1026, 62286, -481 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_lrg_lp", ( 654, 62296, -487 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 654, 62296, -487 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_fountain_txt_lp", ( 359, 62206, -487 ) );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

precache_presets()
{

}

init_notetracks()
{
    maps\_anim::addnotetrack_customfunction( "irons", "bet_holo_irons_stand_and_walk", ::bet_holo_irons_stand_and_walk, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_holo_glitches_1", ::bet_holo_glitches_1, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_holo_glitches_2", ::bet_holo_glitches_2, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_holo_glitches_3", ::bet_holo_glitches_3, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_holo_glitches_4", ::bet_holo_glitches_4, "confrontation_pt1" );
    maps\_anim::addnotetrack_customfunction( "gideon", "bet_conf_gideon_reacts", ::bet_conf_gideon_reacts, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "gideon", "bet_conf_gideon_turns_to_leave", ::bet_conf_gideon_turns_to_leave, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "gideon", "bet_conf_gideon_exits", ::bet_conf_gideon_exits, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_conf_irons_enters", ::bet_conf_irons_enters, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_conf_irons_walks_to_ilona", ::bet_conf_irons_walks_to_ilona, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_conf_irons_turns_to_leave", ::bet_conf_irons_turns_to_leave, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "irons", "bet_conf_irons_exits", ::bet_conf_irons_exits, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_guard_1_enter", ::bet_conf_guard_1_enter, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_guard_wpn_trained", ::bet_conf_guard_wpn_trained, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_guard_1_swing_wpn", ::bet_conf_guard_1_swing_wpn, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard2", "bet_conf_guard_2_push_down_ilona", ::bet_conf_guard_2_push_down_ilona, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_escape_guard_1_react", ::bet_conf_escape_guard_1_react, "escape_pt1" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_escape_guard_1_tripped", ::bet_conf_escape_guard_1_tripped, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard1", "bet_conf_escape_guard_1_punched", ::bet_conf_escape_guard_1_punched, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard2", "bet_conf_escape_guard_2_punch", ::bet_conf_escape_guard_2_punch, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "guard2", "bet_conf_escape_guard_2_shot", ::bet_conf_escape_guard_2_shot, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "ilona", "bet_conf_ilona_punched", ::bet_conf_ilona_punched, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_plr_knock_back", ::bet_conf_plr_knock_back, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_plr_punched", ::bet_conf_plr_punched, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_plr_pull_wpn", ::bet_conf_plr_pull_wpn, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_plr_sit_back", ::bet_conf_plr_sit_back, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_plr_lean", ::bet_conf_plr_lean, "confrontation_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_escape_plr_foot_sweep", ::bet_conf_escape_plr_foot_sweep, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_escape_plr_punch", ::bet_conf_escape_plr_punch, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_conf_escape_plr_wpn", ::bet_conf_escape_plr_wpn, "escape_pt2" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_gear_lt", maps\_exo_climb::aud_exo_climb_gear_lt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_gear_rt", maps\_exo_climb::aud_exo_climb_gear_rt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_windup_lt", maps\_exo_climb::aud_exo_climb_windup_lt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_windup_rt", maps\_exo_climb::aud_exo_climb_windup_rt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_hit_lt", maps\_exo_climb::aud_exo_climb_hit_lt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_exo_climb_hit_rt", maps\_exo_climb::aud_exo_climb_hit_rt, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_elevator_exoclimb_dismount", ::bet_elevator_exoclimb_dismount, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_elevator_exoclimb_dismount_foot", ::bet_elevator_exoclimb_dismount_foot, "elevator_climb_dismount" );
    maps\_anim::addnotetrack_customfunction( "ilana", "bet_ilona_swim_start", ::bet_ilona_swim_start, "roof_slide" );
    maps\_anim::addnotetrack_customfunction( "sewer_lid", "manhole_move_start_foley", ::manhole_move_start_foley, "sewer_grate_open" );
    maps\_anim::addnotetrack_customfunction( "sewer_lid", "manhole_move_start", ::manhole_move_start, "sewer_grate_open" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_start", ::bet_boat_enter_plr_start, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_jump_into_boat", ::bet_boat_enter_plr_jump_into_boat, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_sit", ::bet_boat_enter_plr_sit, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_exo_arm", ::bet_boat_enter_plr_exo_arm, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_power_on", ::bet_boat_enter_plr_power_on, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "bet_boat_enter_plr_grab_wheel", ::bet_boat_enter_plr_grab_wheel, "boat_getin" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "bet_boat_exit_start", ::bet_boat_exit_start, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "bet_boat_exit_jump_out", ::bet_boat_exit_jump_out, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "bet_boat_exit_stand_up", ::bet_boat_exit_stand_up, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "ilana", "bet_boat_exit_ilona", ::bet_boat_exit_ilona, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "ilana", "bet_boat_exit_ilona_pickup_wpn", ::bet_boat_exit_ilona_pickup_wpn, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "ilana", "bet_boat_exit_ilona_stand", ::bet_boat_exit_ilona_stand, "boat_getout" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_crane_mount_crouch_jump", ::aud_crane_mount_crouch_jump, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_crane_mount_lt_hand_hit", ::aud_crane_mount_lt_hand_hit, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_crane_mount_rt_hand_hit", ::aud_crane_mount_rt_hand_hit, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_crane_mount_lt_hand_rest", ::aud_crane_mount_lt_hand_rest, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_crane_mount_rt_hand_rest", ::aud_crane_mount_rt_hand_rest, "crane_mount" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_gear_lt", ::aud_bet_exo_climb_gear_lt, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_gear_rt", ::aud_bet_exo_climb_gear_rt, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_windup_lt", ::aud_bet_exo_climb_windup_lt, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_windup_rt", ::aud_bet_exo_climb_windup_rt, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_hit_lt", ::aud_bet_exo_climb_hit_lt, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_hit_rt", ::aud_bet_exo_climb_hit_rt, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_settle_lt", ::aud_bet_exo_climb_settle_lt, "left_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "aud_bet_exo_climb_settle_rt", ::aud_bet_exo_climb_settle_rt, "right_move" );
    maps\_anim::addnotetrack_customfunction( "player_rig_grapple", "betrayal_finale_player_jump", ::betrayal_finale_player_jump, "crane_to_final" );
    maps\_anim::addnotetrack_customfunction( "cormack", "finale_cormack_walk_1", ::finale_cormack_walk_1, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "cormack", "finale_cormack_decloak", ::finale_cormack_decloak, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "cormack", "finale_cormack_walk_2", ::finale_cormack_walk_2, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "cormack", "finale_cormack_walk_3", ::finale_cormack_walk_3, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "finale_crate_ext", "finale_crate_open_1", ::finale_crate_open_1, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "finale_crate_ext", "finale_crate_close", ::finale_crate_close, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "gideon", "finale_gideon_jump", ::finale_gideon_jump, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "gideon", "finale_gideon_radio", ::finale_gideon_radio, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "gideon", "finale_gideon_leave", ::finale_gideon_leave, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "ilana", "finale_ilana_land", ::finale_ilana_land, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "ilana", "finale_ilana_turn", ::finale_ilana_turn, "finale_scene" );
    maps\_anim::addnotetrack_customfunction( "joker", "finale_joker_jump", ::finale_joker_jump, "finale_scene" );
}

zone_handler( var_0, var_1 )
{
    var_2 = "";
    var_3 = "";

    if ( getsubstr( var_0, 0, 6 ) == "enter_" )
        var_2 = var_1;
    else if ( getsubstr( var_0, 0, 5 ) == "exit_" )
        var_3 = var_1;

    var_4 = ( 2720, 59247, -28 );

    switch ( var_0 )
    {
        case "exit_ext_rooftop":
            if ( var_3 == "ext_rooftop" && !level.aud.bet_walla_intro_patio )
            {
                level.aud.exited_lobby = 1;
                soundscripts\_snd_playsound::snd_play_loop_at( "bet_walla_intro_patio", var_4, "stop_bet_walla_intro_patio", 3, 3 );
                level.aud.bet_walla_intro_patio = 1;
            }

            break;
        case "exit_int_stairwell":
            if ( var_3 == "int_stairwell" )
            {
                level notify( "stop_bet_walla_intro_patio" );
                level.aud.bet_walla_intro_patio = 0;
            }
            else if ( var_3 == "ext_rooftop" && !level.aud.bet_walla_intro_patio )
            {
                soundscripts\_snd_playsound::snd_play_loop_at( "bet_walla_intro_patio", var_4, "stop_bet_walla_intro_patio", 3, 3 );
                level.aud.bet_walla_intro_patio = 1;
            }

            break;
        case "enter_int_betrayal_room":
            if ( !isdefined( level.aud.bet_intro_done ) )
            {
                level.aud.bet_intro_done = 1;
                music( "bet_intro_done" );
            }

            break;
        case "int_hallway":
            if ( var_2 == "int_betrayal_room" )
            {
                soundsettraceflags( "weapons", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
                soundsettraceflags( "foley", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
            }

            break;
        case "int_elevator_shaft":
            if ( var_3 == "ext_rooftop" )
            {
                soundsettraceflags( "weapons" );
                soundsettraceflags( "foley" );
            }

            break;
        case "enter_ext_skybridge":
            if ( var_2 == "ext_tower" )
            {
                level.aud.skybridge = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_skybridge_fs_override" );
            }

            break;
        case "exit_int_tower":
            if ( var_3 == "ext_crane" )
            {
                level.aud.skybridge = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_skybridge_fs_override" );
            }

            break;
        case "exit_ext_crane":
            if ( var_3 == "int_tower" )
            {
                level.aud.skybridge = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_skybridge_fs_override" );
            }

            break;
        case "enter_ext_crane":
            if ( var_2 == "int_tower" )
            {
                level.aud.skybridge = 0;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_skybridge_fs_override" );
            }

            break;
        case "exit_ext_tower":
            if ( var_3 == "ext_skybridge" )
            {
                level.aud.skybridge = 1;
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_skybridge_fs_override" );
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

    switch ( var_0 )
    {
        case "bet_intro":
            soundscripts\_audio::aud_set_music_submix( 0.4, 0 );
            soundscripts\_audio_music::mus_play( "bet_intro", 5.0 );
            wait 96.6;
            soundscripts\_audio_music::mus_play( "bet_intro_vamp", 5 );
            break;
        case "bet_intro_done":
            soundscripts\_audio_music::mus_stop( 3 );
            break;
        case "hologram_begin":
            soundscripts\_audio::aud_set_music_submix( 0.6, 0.25 );
            wait 0.25;
            soundscripts\_audio_music::mus_play( "bet_hologram_prt1", 2 );
            wait 37;
            soundscripts\_audio_music::mus_play( "bet_hologram_prt2", 0.0, 3.0 );
            break;
        case "betrayal_scene_begin":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            wait 1;
            soundscripts\_audio_music::mus_play( "bet_betrayal_prt1", 0.0 );
            wait 61.0;
            wait 0.6;
            soundscripts\_audio_music::mus_play( "bet_betrayal_prt2", 1.0 );
            break;
        case "post_betrayal_action":
            soundscripts\_audio::aud_set_music_submix( 0.75, 10 );
            soundscripts\_audio_music::mus_play( "bet_post_betrayal_action_lp", 0.5, 0.5 );
            wait 10;
            level waittill( "player_out_of_atlas" );
            soundscripts\_audio_music::mus_stop( 0.5 );
            break;
        case "roof_slide":
            wait 7.5;
            soundscripts\_audio_music::mus_stop( 0.5 );
            break;
        case "sewer_out_of_water":
            soundscripts\_audio::aud_set_music_submix( 0.3, 0 );
            soundscripts\_audio_music::mus_play( "bet_baghdad_sewer", 4.0 );
            common_scripts\utility::flag_wait( "flag_dialogue_sewer_checkpoint" );
            soundscripts\_snd_common::snd_wait_for_enemies_aware();
            soundscripts\_audio::aud_set_music_submix( 0.8, 0 );
            soundscripts\_audio_music::mus_play( "bet_baghdad_streets_begin", 3.0 );
            common_scripts\utility::flag_wait( "boat_scene_start" );
            wait 1;
            soundscripts\_audio_music::mus_play( "bet_baghdad_streets_end", 0, 1 );
            wait 2;
            soundscripts\_audio_music::mus_play( "bet_baghdad_sewer", 3.0, 5 );
            break;
        case "start_point_docks":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "bet_baghdad_streets_begin", 3.0 );
            common_scripts\utility::flag_wait( "boat_scene_start" );
            wait 1;
            soundscripts\_audio_music::mus_play( "bet_baghdad_streets_end", 2, 2 );
            wait 2;
            soundscripts\_audio_music::mus_play( "bet_baghdad_sewer", 3.0, 5 );
            break;
        case "boat_chase_begin":
            wait 3;
            soundscripts\_audio::aud_set_music_submix( 1.0, 1 );
            soundscripts\_audio_music::mus_play( "bet_boat_chase_begin", 7.0 );
            level common_scripts\utility::flag_wait( "flag_objective_boat_chase_complete" );
            soundscripts\_audio_music::mus_play( "bet_boat_chase_end", 0.0 );
            level waittill( "boat_crash_end" );
            music( "post_boat_chase" );
            break;
        case "post_boat_chase":
            thread handle_climb_scene_music();
            break;
        case "climb_scene_finale":
            soundscripts\_audio::aud_set_music_submix( 0.3, 0.05 );
            wait 0.05;
            soundscripts\_audio_music::mus_play( "bet_climb_stealth_end", 0, 1 );
            level waittill( "sounddone_bet_gdn_standdown" );
            soundscripts\_audio::aud_set_music_submix( 0, 0.05 );
            wait 0.05;
            soundscripts\_audio::aud_set_music_submix( 0.5, 16.0 );
            soundscripts\_audio_music::mus_play( "bet_end" );
            wait 16;
            soundscripts\_audio::aud_set_music_submix( 1.0, 5.0 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

handle_climb_scene_music()
{
    level endon( "stop_current_music_thread" );
    var_0 = 0;
    var_1 = 0;
    wait 4;

    for (;;)
    {
        if ( soundscripts\_snd_common::snd_get_num_enemies_aware() > 0 )
        {
            if ( !var_1 )
            {
                soundscripts\_audio::aud_set_music_submix( 0.5, 4 );
                soundscripts\_audio_music::mus_play( "bet_climb_combat", 4 );
                var_0 = 0;
                var_1 = 1;
            }
        }
        else if ( !var_0 )
        {
            soundscripts\_audio::aud_set_music_submix( 0.5, 5 );
            soundscripts\_audio_music::mus_play( "bet_climb_stealth", 5 );
            var_0 = 1;
            var_1 = 0;
        }

        wait 0.5;
    }
}

enter_water_override()
{
    level.aud.underwater = 1;
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 1 );
    soundscripts\_snd_filters::snd_fade_in_filter( "underwater", 0.05 );
    soundscripts\_audio_mix_manager::mm_add_submix( "underwater" );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "underwater" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_swim_plr_submerge" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "underwater_main_lp", "kill_underwater_loop" );
}

exit_water_override()
{
    level.aud.underwater = 0;
    level notify( "kill_underwater_loop" );
    soundscripts\_snd_filters::snd_fade_out_filter( 0.05 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "underwater" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "underwater" );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 0 );
}

start_office( var_0 )
{
    common_scripts\utility::flag_wait( "flag_office_start_intro_pcap" );
    soundscripts\_audio_zone_manager::azm_start_zone( "int_lobby", 10 );
    music( "bet_intro" );
}

start_confrontation( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_betrayal_room" );
}

start_confrontation_qte( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_betrayal_room" );
}

start_escape( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_betrayal_room" );
    music( "post_betrayal_action" );
}

start_roof( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_rooftop" );
    music( "post_betrayal_action" );
}

start_swim( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_underwater" );
}

start_sewer( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_sewer" );
    music( "sewer_out_of_water" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_swarm_down" );
}

start_oldtown( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_old_town" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_swarm_down" );
}

start_docks( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_docks" );
    music( "start_point_docks" );
}

start_boat( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_docks" );
}

start_boatjump( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_boat" );
    music( "boat_chase_begin" );
}

start_boatwarbird( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_boat" );
}

start_boatmall( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_boat" );
}

start_boatcrash( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_boat" );
}

start_climb( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_tower" );
    music( "post_boat_chase" );
}

start_climbroof( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_tower" );
    music( "post_boat_chase" );
}

start_climbcrates( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_tower" );
    music( "post_boat_chase" );
}

start_climbskybridge( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_skybridge" );
    music( "post_boat_chase" );
}

start_outro( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_exfill" );
    music( "climb_scene_finale" );
}

office_hallway_door_open( var_0, var_1 )
{
    soundscripts\_snd::snd_slate( "door_hall_op" );

    if ( var_0.size < 1 || var_1.size < 1 )
        return;

    var_2 = var_0[0];
    var_3 = var_1[0];
    var_2 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_patio_open_l" );
    var_3 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_patio_open_r" );
}

office_hallway_door_close( var_0, var_1 )
{
    soundscripts\_snd::snd_slate( "door_hall_cl" );
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "int_lobby", "none" );

    if ( var_0.size < 1 || var_1.size < 1 )
        return;

    var_2 = var_0[0];
    var_3 = var_1[0];
    var_2 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_patio_close_l" );
    var_3 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_patio_close_r" );
}

office_roof_door_open( var_0, var_1 )
{
    soundscripts\_snd::snd_slate( "door1_op" );

    if ( var_0.size < 1 || var_1.size < 1 )
        return;

    var_2 = var_0[0];
    var_3 = var_1[0];
    var_2 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_bldg2_open_l" );
    var_3 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_bldg2_open_r" );
}

office_roof_door_close( var_0, var_1 )
{
    soundscripts\_snd::snd_slate( "door1_cl" );

    if ( var_0.size < 1 || var_1.size < 1 )
        return;

    var_2 = var_0[0];
    var_3 = var_1[0];
    var_2 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_bldg2_close_l" );
    var_3 soundscripts\_snd_playsound::snd_play_linked( "bet_door_to_bldg2_close_r" );
}

bet_gideon_arm_scanner()
{
    level.gideon soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_gideon_arm_scanner", 6.7 );
}

aud_scanner_door_open()
{
    soundscripts\_snd::snd_printlnbold( "SLATE: Scanner Star Trek Door" );
    level.gideon soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_st_door_pre_conf", 0.0 );
}

bet_hologram_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_hologram" );
    soundscripts\_snd::snd_slate( "hologram_start" );
    soundscripts\_snd_playsound::snd_play_at( "bet_holo_hologram", ( 3452, 59301, -391 ) );
    music( "hologram_begin" );
}

bet_holo_glitches_1( var_0 )
{
    soundscripts\_snd::snd_slate( "glitch_1" );
    soundscripts\_snd_playsound::snd_play_at( "bet_holo_glitch_1", ( 3452, 59301, -391 ) );
}

bet_holo_glitches_2( var_0 )
{
    soundscripts\_snd::snd_slate( "glitch_2" );
    soundscripts\_snd_playsound::snd_play_at( "bet_holo_glitch_2", ( 3452, 59301, -391 ) );
}

bet_holo_glitches_3( var_0 )
{
    soundscripts\_snd::snd_slate( "glitch_3" );
    soundscripts\_snd_playsound::snd_play_at( "bet_holo_glitch_3", ( 3452, 59301, -391 ) );
}

bet_holo_glitches_4( var_0 )
{
    soundscripts\_snd::snd_slate( "glitch_4" );
    soundscripts\_snd_playsound::snd_play_at( "bet_holo_glitch_4", ( 3452, 59301, -391 ) );
}

bet_holo_irons_shoot_pistol( var_0 )
{
    var_1 = var_0;
    soundscripts\_snd::snd_slate( "bang" );
    var_1 soundscripts\_snd_playsound::snd_play_linked( "bet_holo_irons_shoot" );
}

bet_conf_door_opens( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_door_flashbang_roll" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_hologram" );
}

bet_conf_flash_bang_exp()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_confrontation" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_flash_bang" );
}

bet_conf_slo_mo_kick_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "slomo" );
    level.player enablecustomweaponcontext();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "slomo" );
    soundscripts\_snd_timescale::snd_set_timescale( "slomo_timescale" );
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_enter", "kill_slo_mo" );
}

bet_conf_slo_mo_kick_stop()
{
    level notify( "kill_slo_mo" );
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_exit" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "slomo" );
    level.player disablecustomweaponcontext();
    soundscripts\_audio_mix_manager::mm_clear_submix( "slomo" );
}

bet_conf_slo_mo_shoot_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "slomo" );
    level.player enablecustomweaponcontext();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "slomo" );
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_enter", "kill_slo_mo" );
}

bet_conf_slo_mo_shoot_stop()
{
    level notify( "kill_slo_mo" );
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_exit" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "slomo" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
    level.player disablecustomweaponcontext();
    soundscripts\_audio_mix_manager::mm_clear_submix( "slomo" );
}

bet_conf_kill_guard()
{
    soundscripts\_snd_playsound::snd_play_at( "bet_conf_guy2_gets_shot", ( 3509, 59134, -385 ) );
    wait 2;
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_confrontation" );
}

bet_conf_fire_suppression()
{
    soundscripts\_snd::snd_slate( "fire suppresion" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_fire_supp_syst" );
    bet_escape_alarms();
    bet_escape_additional_sprinklers();
    bet_escape_additional_steam();
}

bet_conf_sprinkler( var_0 )
{
    var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.v["origin"];
        soundscripts\_snd_playsound::snd_play_at( "bet_conf_sprinklers_start", var_2 );
        soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_sprinklers_lp", var_2, "cleanup_fire_suppression_stuff" );
        soundscripts\_snd::snd_slate( "sprinklers" );
    }
}

bet_conf_steam_lp( var_0 )
{
    var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.v["origin"];
        soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_steam_lp", var_2, "cleanup_fire_suppression_stuff" );
        soundscripts\_snd::snd_slate( "steam" );
    }
}

bet_escape_alarms()
{
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.05, undefined, ( 3249, 59273, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.1, undefined, ( 3744, 59400, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.15, undefined, ( 3576, 59189, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.2, undefined, ( 3517, 58886, -293 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.25, undefined, ( 3512, 58504, -293 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.3, undefined, ( 3324, 58332, -293 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.35, undefined, ( 3324, 58332, -293 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.4, undefined, ( 3324, 57605, -293 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "bet_escape_alarms", 0.55, undefined, ( 3717, 57705, -211 ), "cleanup_fire_suppression_stuff" );
}

bet_escape_additional_sprinklers()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_sprinklers_lp", ( 3312, 57856, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_sprinklers_lp", ( 3308, 58032, -315 ), "cleanup_fire_suppression_stuff" );
}

bet_escape_additional_steam()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_steam_lp", ( 3461, 58751, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_steam_lp", ( 3428, 58461, -315 ), "cleanup_fire_suppression_stuff" );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_conf_steam_lp", ( 3581, 58879, -377 ), "cleanup_fire_suppression_stuff" );
}

fire_door_1_open( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_fire_doors_open" );
    soundsettraceflags( "weapons", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
    soundsettraceflags( "foley", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
}

fire_door_1_close( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_fire_doors_close" );
}

open_firedoor_for_guards()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_fire_doors_open_long" );
    soundsettraceflags( "weapons" );
    soundsettraceflags( "foley" );
}

big_fire_door_open( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_big_fire_doors_open" );
}

big_fire_door_close( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_big_fire_doors_close" );
    soundsettraceflags( "weapons", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
    soundsettraceflags( "foley", "locational", "solid", "glass", "translucent", "clipshot", "playerclip", "structural" );
}

open_elevator_doors( var_0 )
{
    var_0[1] soundscripts\_snd_playsound::snd_play_linked( "bet_elevator_blast_doors_open" );
}

close_elevator_doors( var_0 )
{
    var_0[1] soundscripts\_snd_playsound::snd_play_linked( "bet_elevator_blast_doors_close" );
    wait 4;
    level notify( "cleanup_fire_suppression_stuff" );
}

atlas_building_roof_walla( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    soundscripts\_snd_playsound::snd_play_at( "bet_walla_atlas_building_roof", ( 2674, 59238, -28 ) );
    soundsettraceflags( "weapons" );
    soundsettraceflags( "foley" );
}

bet_roof_raise_blast_doors( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_raise_blast_doors" );
}

bet_roof_lower_blast_doors( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_lower_blast_doors" );
}

bet_roof_slide_start( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_slide_start" );
}

bet_roof_slo_mo_start( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_slo_mo_start" );
}

bet_roof_slo_mo_stop( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_slo_mo_stop" );
}

bet_roof_glass_hit( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_glass_hit" );
}

bet_roof_water_hit( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_roof_water_hit" );
}

bet_swim_bullet_trails( var_0 )
{
    if ( level.aud.underwater == 1 )
    {
        var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

        if ( isdefined( var_1 ) )
        {
            var_2 = var_1.v["origin"];
            soundscripts\_snd_playsound::snd_play_at( "bet_swim_bullet_trail", var_2 );
        }
    }
}

bet_swim_boat_explo( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_swim_boat_explo" );
    maps\_utility::delaythread( 3, ::bet_swim_boat_sink, var_0 );
}

bet_swim_boat_sink( var_0 )
{
    if ( level.aud.underwater == 1 )
        var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_swim_boat_sink", "kill_sink_audio" );
}

bet_swim_boat_hit_bottom( var_0 )
{
    if ( level.aud.underwater == 1 )
    {
        var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_swim_boat_hit_bottom" );
        level notify( "kill_sink_audio" );
    }
}

bet_swim_dock_explode( var_0 )
{
    var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_2 = var_1.v["origin"];
        soundscripts\_snd_playsound::snd_play_at( "bet_swim_boat_explo", var_2 );
    }
}

bet_swim_dock_debris_blocker()
{
    var_0 = ( 3488, 62164, -784 );
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_at( "bet_swim_boat_hit_bottom", var_0 );
}

player_drowning_start()
{
    soundscripts\_snd::snd_slate( "snd: drowning" );
    soundscripts\_snd_playsound::snd_play_2d( "underwater_drowning", "kill_drowning_audio" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "underwater_bubble_lp_player", "kill_drowning_audio" );
    self waittill( "stop_drowning" );
    level notify( "kill_drowning_audio" );
    soundscripts\_snd::snd_slate( "snd: not drowning" );
}

market_walla_init()
{
    level endon( "market_walla_cleanup" );
    var_0 = ( 5146, 63703, -388 );
    var_1 = ( 5357, 64647, -388 );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_walla_mrkt_calm", var_0, "stop_bet_walla_mrkt_calm", 3, 3 );
    soundscripts\_snd_playsound::snd_play_loop_at( "bet_walla_mrkt_tense", var_1, "stop_bet_walla_mrkt_tense", 3, 3 );
    level waittill( "market_walla_guards_wakeup" );
    level notify( "stop_bet_walla_mrkt_calm" );
    level notify( "stop_bet_walla_mrkt_tense" );
    soundscripts\_snd_playsound::snd_play_at( "bet_walla_mrkt_panic1", var_1, "stop_bet_walla_mrkt_panic1", 0, 3 );
}

market_walla_cleanup( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    level notify( "market_walla_cleanup" );
    level notify( "stop_bet_walla_mrkt_calm" );
    level notify( "stop_bet_walla_mrkt_tense" );
    level notify( "stop_bet_walla_mrkt_panic1" );
}

add_doc_civ_walla( var_0 )
{
    if ( !isdefined( level.aud.oldtown_civs ) )
    {
        var_1 = soundscripts\_snd_playsound::snd_play_loop_2d( "bet_walla_doc_panic", "stop_bet_walla_doc_panic", 1, 3 );
        level.aud.oldtown_civs = [];
        thread monitor_oldtown_doc_civs( var_1 );
    }

    level.aud.oldtown_civs[level.aud.oldtown_civs.size] = var_0;
}

monitor_oldtown_doc_civs( var_0 )
{
    var_1 = 0.2;

    while ( !common_scripts\utility::flag( "boat_scene_start" ) )
    {
        level.aud.oldtown_civs = common_scripts\utility::array_removeundefined( level.aud.oldtown_civs );
        var_2 = level.aud.oldtown_civs.size;
        var_3 = 0;

        foreach ( var_5 in level.aud.oldtown_civs )
            var_3 += distance2d( level.player.origin, var_5.origin );

        var_7 = get_oldtown_doc_civ_vol( var_2, var_3 );
        var_0 scalevolume( var_7, var_1 );
        wait(var_1);
    }

    level notify( "stop_bet_walla_doc_panic" );
}

get_oldtown_doc_civ_vol( var_0, var_1 )
{
    if ( var_0 <= 0 )
        return 0;

    var_2 = var_1 / var_0;
    var_3 = [ [ 360, 1.0 ], [ 900, 0.5 ], [ 1080, 0.0 ] ];
    var_4 = [ [ 0, 0.0 ], [ 5, 0.2 ], [ 8, 1.0 ] ];
    var_5 = soundscripts\_snd::snd_map( var_2, var_3 );
    var_6 = soundscripts\_snd::snd_map( var_0, var_4 );

    if ( common_scripts\utility::flag( "boat_scene_start" ) )
        var_6 *= 0.5;

    return var_5 * var_6;
}

ai_step_up_32( var_0 )
{
    if ( var_0 == level.ilana )
        soundscripts\_snd::snd_printlnbold( "Ilana Step Up 32 Units" );
}

ai_mantle_over_low_cover_40( var_0 )
{
    if ( var_0 == level.ilana )
        soundscripts\_snd::snd_printlnbold( "Ilana Mantle Over Lowe Cover" );
}

ai_slide_across_car( var_0 )
{
    if ( var_0 == level.ilana )
        soundscripts\_snd::snd_printlnbold( "Ilana Roof Slide" );
}

ai_jump_over_40_down_88( var_0 )
{
    if ( var_0 == level.ilana )
        soundscripts\_snd::snd_printlnbold( "Ilana Roof Mantle" );
}

civ_boat_spawn( var_0 )
{
    var_1 = "bet_npc_boats_flyby";
    var_2 = [];
    var_2[0] = 800;
    var_3 = [];
    var_3[0] = 20;
    var_3[1] = 5;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, undefined, var_2, var_3, 1, undefined, undefined, 3, 2 );
}

aud_impact_system_diveboat( var_0 )
{
    var_1 = [];
    var_1["Debug"] = 0;
    var_1["VehicleID"] = "dive_boat_impact";
    var_1["PV_MinVelocityThreshold"] = 1;
    var_1["PV_MaxVelocity"] = 500;
    var_1["PV_NumVelocityRanges"] = 3;
    var_1["PV_MaxSmlVelocity"] = 200;
    var_1["PV_MaxMedVelocity"] = 350;
    var_1["PV_MaxLrgVelocity"] = 500;
    var_1["NPC_MinVelocityThreshold"] = 1;
    var_1["NPC_MaxVelocity"] = 500;
    var_1["NPC_NumVelocityRanges"] = 3;
    var_1["NPC_MaxSmlVelocity"] = 200;
    var_1["NPC_MaxMedVelocity"] = 350;
    var_1["NPC_MaxLrgVelocity"] = 500;
    var_1["MinLFEVolumeThreshold"] = 0.0;
    var_1["FallVelMultiplier"] = 0.1;
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
    var_2 = [];
    var_2 = [ "vehicle" ];
    soundscripts\_snd_common::snd_play_vehicle_collision( var_0, var_1, var_2 );
}

aud_ambient_helicopter( var_0 )
{
    self vehicle_turnengineoff();

    if ( var_0 == "spawner_boat_chase_warbird" )
    {
        if ( issubstr( self.spawner.script_linkname, "230" ) )
        {
            var_1 = 230;
            var_0 = "boat_chase_warbird_" + var_1;
        }
        else if ( issubstr( self.spawner.script_linkname, "231" ) )
        {
            var_1 = 231;
            var_0 = "boat_chase_warbird_" + var_1;
        }
        else
            var_0 = "boat_chase_warbird";
    }

    var_2 = self.vehicletype;

    if ( isdefined( var_0 ) && var_2 == "littlebird" )
    {
        switch ( var_0 )
        {
            case "office_scene_warbird02":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_littlebird_flyby_patio" );
                soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_littlebird_rooftop_flyby", 7.7 );
                wait 15;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_littlebird_flyby_patio" );
                break;
            default:
                break;
        }
    }

    if ( isdefined( var_0 ) && var_2 == "xh9_warbird" )
    {
        switch ( var_0 )
        {
            case "office_scene_warbird01":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_warbird_flyby_interior" );
                soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_warbird_flyby_interior", 1.5 );
                wait 10;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_warbird_flyby_interior" );
                break;
            case "swim_ambush_helo":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                break;
            case "sewer_exit_warbird_outro":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_warbird_sewer_flyover" );
                soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_warbird_sewer_flyover", 5.7 );
                wait 12;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_warbird_sewer_flyover" );
                break;
            case "boat_chase_warbird_230":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                break;
            case "boat_chase_warbird_231":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                break;
            case "spawner_climb_onfoot_heli":
                soundscripts\_snd::snd_slate( "Spawn: " + var_0 );
                soundscripts\_audio_mix_manager::mm_add_submix( "bet_warbird_rooftop_arrive_depart" );
                soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_warbird_rooftop_arrive", 1.0, undefined, "kill_roof_warbird_idle_sfx", 0.5, 5 );
                thread aud_rooftop_warbird_departing();
                wait 30;
                soundscripts\_audio_mix_manager::mm_clear_submix( "bet_warbird_rooftop_arrive_depart" );
                break;
            default:
                break;
        }
    }
}

aud_rooftop_warbird_departing()
{
    self waittill( "unloaded" );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_warbird_rooftop_depart", 0.0 );
    level notify( "kill_roof_warbird_idle_sfx" );
}

lock_on_target()
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_lock_on_target" );
}

bet_boat_crash_audio_handler()
{
    level.aud.diveboat_ending = 1;
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "diveboat" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_boat_chase" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_boat_crash" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_crash_jump" );
}

bet_boat_crash_bldg_impact()
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_crash_impact" );
}

crate_path_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_climb_const_crate_close", 15.5 );
}

crate_move_start( var_0 )
{
    if ( !isdefined( level._snd.crate_count ) )
        level._snd.crate_count = 0;

    var_1 = self;

    if ( var_0 == "climbimg_moving_crate_on_foot_start_node" )
        return;

    if ( var_0 == "climbimg_moving_crate_construction_ambience_start_node" )
    {
        level._snd.crate_count += 1;

        if ( level._snd.crate_count == 2 )
            soundscripts\_snd::snd_slate( "crate_move_start - 1" );

        var_1 soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_climb_const_crate_far_01", 0.0 );
    }
    else if ( var_0 == "climbimg_moving_crate_climb_ambience_start_node" )
    {
        level._snd.crate_count += 1;

        if ( level._snd.crate_count == 3 )
            soundscripts\_snd::snd_slate( "crate_move_start - 2" );

        var_1 soundscripts\_snd_playsound::snd_play_delayed_linked( "bet_climb_const_crate_far_02", 0.0 );
    }
    else
    {

    }
}

reverse_mag_glove_crane_move()
{
    soundscripts\_snd::snd_slate( "reverse_mag_glove_crane_move" );
}

spawn_ending_pcap_warbird()
{
    soundscripts\_snd::snd_slate( "spawn_ending_pcap_warbird" );
}

bet_holo_irons_stand_and_walk( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_holo_irons_walk" );
}

bet_conf_gideon_reacts( var_0 )
{

}

bet_conf_gideon_turns_to_leave( var_0 )
{

}

bet_conf_gideon_exits( var_0 )
{

}

bet_conf_irons_enters( var_0 )
{

}

bet_conf_irons_walks_to_ilona( var_0 )
{

}

bet_conf_irons_turns_to_leave( var_0 )
{

}

bet_conf_irons_exits( var_0 )
{
    soundscripts\_snd_timescale::snd_set_timescale( "slomo_timescale" );
}

bet_conf_guard_1_enter( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_guy1_enters" );
}

bet_conf_guard_wpn_trained( var_0 )
{

}

bet_conf_guard_1_swing_wpn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_guy1_swings_wpn" );
}

bet_conf_escape_guard_1_react( var_0 )
{

}

bet_conf_escape_guard_1_tripped( var_0 )
{

}

bet_conf_escape_guard_1_punched( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_guy1_punched" );
}

bet_conf_guard_2_push_down_ilona( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_guy2_pushes_ilona" );
}

bet_conf_escape_guard_2_punch( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_conf_guy2_roughs_up_ilona" );
}

bet_conf_escape_guard_2_shot( var_0 )
{

}

bet_conf_ilona_punched( var_0 )
{

}

bet_conf_plr_knock_back( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_plr_knock_back" );
}

bet_conf_plr_punched( var_0 )
{

}

bet_conf_plr_pull_wpn( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_plr_pull_wpn" );
}

bet_conf_plr_sit_back( var_0 )
{

}

bet_conf_plr_lean( var_0 )
{

}

bet_conf_escape_plr_foot_sweep( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_plr_foot_sweep" );
}

bet_conf_escape_plr_punch( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_plr_punch" );
}

bet_conf_escape_plr_wpn( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_conf_plr_pickup_wpn" );
}

bet_elevator_exoclimb_dismount( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_exo_climb_pullup_gear" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_exo_climb_pullup_mag" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_exo_climb_pullup_fs", 0.25 );
}

bet_elevator_exoclimb_dismount_foot( var_0 )
{

}

bet_escape_roof_slide()
{
    soundscripts\_snd_timescale::snd_set_timescale( "slomo_timescale" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_roof_slide" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_roof_slide" );
}

bet_escape_roof_slomo_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_roof_slide_slo_mo" );
}

bet_escape_roof_slomo_end()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_roof_slide_slo_mo" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_water_player_pre_splash", 3.15, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_water_player_splash_fronts", 3.2, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_water_player_hit_underwater", 3.3, 1 );
    wait 3;
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_player_splashdown" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_roof_slide" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_player_splashdown" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_swarm_down" );
}

bet_ilona_swim_start( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_ilona_swim_start" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_swim_surface" );
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "underwater_bubble_lp_sm_01", "kill_ilona_swim_loop" );
}

bet_ilona_swim_end( var_0 )
{
    soundscripts\_snd::snd_slate( "bet_ilona_swim_end" );
    level notify( "kill_ilona_swim_loop" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_swim_surface" );
}

manhole_move_start_foley( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_manhole_cover_foley" );
}

manhole_move_start( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_manhole_cover_move" );
}

bet_boat_enter_plr_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_boat_chase" );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "diveboat" );
    soundscripts\_snd_playsound::snd_play_2d( "dive_boat_enter" );
    soundscripts\_snd_playsound::snd_play_at( "dive_boat_dive_canopy_open", ( 855, 61685, -550 ) );
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_boat" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_swarm_down" );
}

bet_boat_enter_plr_jump_into_boat( var_0 )
{

}

bet_boat_enter_plr_sit( var_0 )
{

}

bet_boat_enter_plr_exo_arm( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "dive_boat_equip" );
}

bet_boat_enter_plr_grab_wheel( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "dive_boat_ready" );
}

bet_boat_enter_plr_power_on( var_0 )
{
    wait 0.75;
    soundscripts\_snd_playsound::snd_play_2d( "dive_boat_dive_power_on" ) soundscripts\_snd_playsound::snd_play_2d( "dive_boat_dive_canopy_close" );
    level.player_boat thread vehicle_scripts\_diveboat::diveboat_audio();
    thread bet_boat_dive_watcher( level.player_boat );
}

bet_boat_dive_watcher( var_0 )
{
    thread bet_boat_end_watcher();
    var_1 = 0;

    for (;;)
    {
        if ( var_0 vehicle_diveboatissubmerged() )
        {
            if ( var_1 == 0 )
            {
                soundscripts\_audio_mix_manager::mm_add_submix( "underwater", 0.05 );
                soundscripts\_snd_common::snd_enable_soundcontextoverride( "underwater" );
                soundscripts\_snd_playsound::snd_play_2d( "dive_boat_dive_one_shot_plr" );
                soundscripts\_snd_playsound::snd_play_loop_2d( "underwater_main_lp", "kill_submerged_loop", undefined, undefined, 0.75 );
                var_1 = 1;
            }
        }
        else if ( var_1 == 1 )
        {
            soundscripts\_audio_mix_manager::mm_clear_submix( "underwater", 0.05 );
            level notify( "kill_submerged_loop" );
            soundscripts\_snd_playsound::snd_play_2d( "dive_boat_surface_one_shot_plr" );
            soundscripts\_snd_common::snd_disable_soundcontextoverride( "underwater" );
            var_1 = 0;
        }

        if ( isdefined( level.aud.boat_end ) && level.aud.boat_end == 1 )
            break;

        waitframe();
    }
}

bet_boat_end_watcher()
{
    common_scripts\utility::flag_wait( "flag_objective_boat_chase_complete" );
    level.aud.boat_end = 1;
}

bet_boat_exit_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_boat_crash" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_boat_post_crash" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_exit_plr" );
    soundscripts\_audio_zone_manager::azm_start_zone( "ext_tower" );
}

bet_boat_exit_jump_out( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_exit_plr_jump" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_exit_debris" );
}

bet_boat_exit_stand_up( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_boat_exit_plr_stand" );
}

bet_boat_exit_ilona( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_boat_exit_ilona" );
}

bet_boat_exit_ilona_pickup_wpn( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_boat_exit_ilona_wpn" );
}

bet_boat_exit_ilona_stand( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "bet_boat_exit_ilona_stand" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "bet_boat_post_crash" );
}

aud_crane_mount_crouch_jump( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "betrayal_ending" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_crane_climb_mount_gear" );
}

aud_crane_mount_lt_hand_hit( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_crane_climb_mount_mag" );
}

aud_crane_mount_rt_hand_hit( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "exo_climb_hit_magnet", 0.1 );
}

aud_crane_mount_lt_hand_rest( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_rest_magnet" );
}

aud_crane_mount_rt_hand_rest( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_rest_magnet" );
}

aud_bet_exo_climb_gear_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_gear_lt" );
}

aud_bet_exo_climb_gear_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_gear_rt" );
}

aud_bet_exo_climb_windup_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_lt" );
}

aud_bet_exo_climb_windup_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_rt" );
}

aud_bet_exo_climb_hit_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_hit_magnet" );
}

aud_bet_exo_climb_hit_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_hit_magnet" );
}

aud_bet_exo_climb_settle_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_crane_climb_swing_leather" );
}

aud_bet_exo_climb_settle_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_crane_climb_swing_leather" );
}

betrayal_finale_player_jump( var_0 )
{
    soundscripts\_snd::snd_slate( "betrayal_finale_player_jump" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_crane_dismount_gear_jangle" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_crane_dismount_slide_mtl", 0.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_crane_dismount_land_hit", 6.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_crane_dismount_land_gear", 8.5 );
}

finale_cormack_walk_1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_1_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_1_gear" );
}

finale_cormack_decloak( var_0 )
{
    soundscripts\_snd::snd_slate( "finale_cormack_decloak" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_decloak" );
    soundscripts\_audio_mix_manager::mm_add_submix( "bet_warbird_ending_dropoff" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_warbird_ending_dropoff", 4.1 );
}

finale_cormack_walk_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_2_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_2_gear" );
}

finale_cormack_walk_3( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_3_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_cormack_walk_3_gear" );
}

finale_crate_open_1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_crate_open" );
}

finale_crate_close( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_crate_close" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_crate_close_drawnout" );
}

finale_gideon_jump( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_gideon_jump_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_gideon_jump_gear" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_additional_movement_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_additional_movement_gear" );
}

finale_gideon_radio( var_0 )
{
    soundscripts\_snd::snd_slate( "finale_gideon_radio" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_gideon_radio_gear" );
}

finale_gideon_leave( var_0 )
{
    soundscripts\_snd::snd_slate( "finale_gideon_leave" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_gideon_leave_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_gideon_leave_gear" );
}

finale_ilana_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_ilona_land_fts" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bet_finale_ilona_land_gear", 1.5 );
}

finale_ilana_turn( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_ilona_turn_gear" );
}

finale_joker_jump( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_joker_jump_fts" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_finale_joker_jump_gear" );
}

bet_foley_override_handler()
{
    level.player endon( "death" );

    for (;;)
    {
        level.player waittill( "foley", var_0, var_1, var_2 );

        switch ( var_0 )
        {
            case "stationarycrouchscuff":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_scrape" );

                break;
            case "stationaryscuff":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_scrape" );

                break;
            case "crouchscuff":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_scrape" );

                break;
            case "runscuff":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_scrape" );

                break;
            case "sprintscuff":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_scrape" );

                break;
            case "prone":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_prone" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_prone" );
                }

                break;
            case "crouchwalk":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_walk" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_walk" );
                }

                break;
            case "crouchrun":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_run" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_run" );
                }

                break;
            case "walk":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_walk" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_walk" );
                }

                break;
            case "run":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_run" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_run" );
                }

                break;
            case "sprint":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                {
                    if ( var_2 )
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_sprint" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_sprint" );
                }

                break;
            case "jump":
                break;
            case "lightland":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_land_lt" );

                break;
            case "mediumland":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_land_med" );

                break;
            case "heavyland":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_land_hv" );

                break;
            case "damageland":
                if ( isdefined( level.aud.skybridge ) && level.aud.skybridge == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "bet_fs_glass_debris_land_dmg" );

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
