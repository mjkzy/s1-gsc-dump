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

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "flag_stop_caravan_sfx" );
    common_scripts\utility::flag_init( "flag_stop_intro_music" );
    common_scripts\utility::flag_init( "flag_start_interrogation_music_pt2" );
}

init_globals()
{
    level.incin_amb = spawn( "script_origin", ( 0, 0, 0 ) );
    level.aud.incin_close = spawn( "script_origin", ( 0, 0, 3 ) );
    level.aud.cart_push = spawn( "script_origin", ( 0, 0, 2 ) );
    level.aud.cart_push2 = spawn( "script_origin", ( 0, 0, 2 ) );
    level.aud.cart = spawn( "script_origin", ( 0, 0, 1 ) );
    level.aud.cart_first_time = 1;
    level.aud.flame_loop = 0;
    level.aud.flame_loop2 = 0;
    level.aud.limp_footsteps = 0;
    level.aud.s2_walk_footsteps = 0;
    level.aud.mech_error_timeout = 0;
    level.aud.cell_prisoners_trig = 0;
    level.aud.incin_burst = spawn( "script_origin", ( 7986, -13424, -1675 ) );
    level.aud.incin_burst2 = spawn( "script_origin", ( 7851, -13394, -1685 ) );
    level.aud.living_gate = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread aud_captured_foley_override_handler();
    thread aud_captured_setup_anims();
    var_0 = getent( "trigger_darkness", "targetname" );
    var_0 thread trigger_darkness();
}

launch_loops()
{

}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

precache_presets()
{

}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_intro_drive", ::start_intro_drive );
    soundscripts\_snd::snd_register_message( "start_s1_elevator", ::start_s1_elevator );
    soundscripts\_snd::snd_register_message( "start_s2_walk", ::start_s2_walk );
    soundscripts\_snd::snd_register_message( "start_escape", ::start_escape );
    soundscripts\_snd::snd_register_message( "start_s2_elevator", ::start_s2_elevator );
    soundscripts\_snd::snd_register_message( "start_test_chamber", ::start_test_chamber );
    soundscripts\_snd::snd_register_message( "start_halls_to_autopsy", ::start_halls_to_autopsy );
    soundscripts\_snd::snd_register_message( "start_trolley", ::start_trolley );
    soundscripts\_snd::snd_register_message( "start_battle_to_heli", ::start_battle_to_heli );
    soundscripts\_snd::snd_register_message( "aud_intro_heli_flyover", ::aud_intro_heli_flyover );
    soundscripts\_snd::snd_register_message( "scn_truck_sounds", ::scn_truck_sounds );
    soundscripts\_snd::snd_register_message( "entrance_alarm", ::entrance_alarm );
    soundscripts\_snd::snd_register_message( "entrance_alarm_fast2", ::entrance_alarm_fast2 );
    soundscripts\_snd::snd_register_message( "entrance_alarm_fast", ::entrance_alarm_fast );
    soundscripts\_snd::snd_register_message( "entrance_vo_01", ::entrance_vo_01 );
    soundscripts\_snd::snd_register_message( "entrance_vo_03", ::entrance_vo_03 );
    soundscripts\_snd::snd_register_message( "aud_intro_caravan_passby", ::aud_intro_caravan_passby );
    soundscripts\_snd::snd_register_message( "aud_intro_caravan_mute", ::aud_intro_caravan_mute );
    soundscripts\_snd::snd_register_message( "aud_intro_caravan_unmute", ::aud_intro_caravan_unmute );
    soundscripts\_snd::snd_register_message( "aud_mech_idle_sfx", ::aud_mech_idle_sfx );
    soundscripts\_snd::snd_register_message( "aud_intro_to_elev_walla", ::aud_intro_to_elev_walla );
    soundscripts\_snd::snd_register_message( "aud_stop_cormack_foley", ::aud_stop_cormack_foley );
    soundscripts\_snd::snd_register_message( "s2_elevator_door_open_top", ::s2_elevator_door_open_top );
    soundscripts\_snd::snd_register_message( "s2_elevator_ride_down", ::s2_elevator_ride_down );
    soundscripts\_snd::snd_register_message( "s2_elevator_door_open", ::s2_elevator_door_open );
    soundscripts\_snd::snd_register_message( "s2_elevator_door_close", ::s2_elevator_door_close );
    soundscripts\_snd::snd_register_message( "aud_s2walk_trigger_start", ::aud_s2walk_trigger_start );
    soundscripts\_snd::snd_register_message( "s2_prison_amb", ::s2_prison_amb );
    soundscripts\_snd::snd_register_message( "aud_plr_hit", ::aud_plr_hit );
    soundscripts\_snd::snd_register_message( "aud_plr_hit_vo_move_forward", ::aud_plr_hit_vo_move_forward );
    soundscripts\_snd::snd_register_message( "aud_plr_hit_vo_move_back", ::aud_plr_hit_vo_move_back );
    soundscripts\_snd::snd_register_message( "aud_plr_hit_vo_look", ::aud_plr_hit_vo_look );
    soundscripts\_snd::snd_register_message( "aud_plr_hit_vo_line", ::aud_plr_hit_vo_line );
    soundscripts\_snd::snd_register_message( "aud_ambient_animations", ::aud_ambient_animations );
    soundscripts\_snd::snd_register_message( "s2_walk_vo_execution", ::s2_walk_vo_execution );
    soundscripts\_snd::snd_register_message( "s2_walk_execution_PA", ::s2_walk_execution_pa );
    soundscripts\_snd::snd_register_message( "aud_s2walk_emitters", ::aud_s2walk_emitters );
    soundscripts\_snd::snd_register_message( "aud_s2walk_alarm_tone_lp", ::aud_s2walk_alarm_tone_lp );
    soundscripts\_snd::snd_register_message( "aud_s2walk_flyby_1", ::aud_s2walk_flyby_1 );
    soundscripts\_snd::snd_register_message( "aud_s2walk_door_open", ::aud_s2walk_door_open );
    soundscripts\_snd::snd_register_message( "aud_s2walk_door_close", ::aud_s2walk_door_close );
    soundscripts\_snd::snd_register_message( "aud_s2walk_prisoner_2_beating", ::aud_s2walk_prisoner_2_beating );
    soundscripts\_snd::snd_register_message( "aud_s2walk_execution_kneeling_prisoners", ::aud_s2walk_execution_kneeling_prisoners );
    soundscripts\_snd::snd_register_message( "aud_s2walk_execution_fire", ::aud_s2walk_execution_fire );
    soundscripts\_snd::snd_register_message( "aud_s2walk_loudspeaker2_line1", ::aud_s2walk_loudspeaker2_line1 );
    soundscripts\_snd::snd_register_message( "aud_s2walk_loudspeaker2_line2", ::aud_s2walk_loudspeaker2_line2 );
    soundscripts\_snd::snd_register_message( "aud_s2walk_cell_prisoners", ::aud_s2walk_cell_prisoners );
    soundscripts\_snd::snd_register_message( "aud_s2walk_guard_radios", ::aud_s2walk_guard_radios );
    soundscripts\_snd::snd_register_message( "aud_s2walk_cells_foley_mix", ::aud_s2walk_cells_foley_mix );
    soundscripts\_snd::snd_register_message( "aud_s2walk_clear_foley_mix", ::aud_s2walk_clear_foley_mix );
    soundscripts\_snd::snd_register_message( "aud_s2walk_temp_guard_VO", ::aud_s2walk_temp_guard_vo );
    soundscripts\_snd::snd_register_message( "aud_s2walk_guard_hip_radio", ::aud_s2walk_guard_hip_radio );
    soundscripts\_snd::snd_register_message( "aud_s2walk_yard_prisoners_whimpering", ::aud_s2walk_yard_prisoners_whimpering );
    soundscripts\_snd::snd_register_message( "aud_incin_flame_loop_2", ::aud_incin_flame_loop_2 );
    soundscripts\_snd::snd_register_message( "aud_trolley_music", ::aud_trolley_music );
    soundscripts\_snd::snd_register_message( "aud_interrogation_music_pt1", ::aud_interrogation_music_pt1 );
    soundscripts\_snd::snd_register_message( "aud_interrogation_music_pt2", ::aud_interrogation_music_pt2 );
    soundscripts\_snd::snd_register_message( "aud_interrogation_scene", ::aud_interrogation_scene );
    soundscripts\_snd::snd_register_message( "aud_cap_interrogation_transition_vo", ::aud_cap_interrogation_transition_vo );
    soundscripts\_snd::snd_register_message( "aud_rescue_drone", ::aud_rescue_drone );
    soundscripts\_snd::snd_register_message( "aud_red_light", ::aud_red_light );
    soundscripts\_snd::snd_register_message( "aud_escape_doctor_bodybag", ::aud_escape_doctor_bodybag );
    soundscripts\_snd::snd_register_message( "aud_escape_guard_takedown_door", ::aud_escape_guard_takedown_door );
    soundscripts\_snd::snd_register_message( "aud_escape_keycard", ::aud_escape_keycard );
    soundscripts\_snd::snd_register_message( "aud_limp_on", ::aud_limp_on );
    soundscripts\_snd::snd_register_message( "aud_limp_exo", ::aud_limp_exo );
    soundscripts\_snd::snd_register_message( "aud_limp_off", ::aud_limp_off );
    soundscripts\_snd::snd_register_message( "aud_stop_headspace_ambience", ::aud_stop_headspace_ambience );
    soundscripts\_snd::snd_register_message( "aud_play_horror_ambience", ::aud_play_horror_ambience );
    soundscripts\_snd::snd_register_message( "aud_stop_horror_ambience", ::aud_stop_horror_ambience );
    soundscripts\_snd::snd_register_message( "aud_escape_give_gun_exo", ::aud_escape_give_gun_exo );
    soundscripts\_snd::snd_register_message( "aud_onearm_weapon_swap", ::aud_onearm_weapon_swap );
    soundscripts\_snd::snd_register_message( "aud_cap_45_onearm_toss", ::aud_cap_45_onearm_toss );
    soundscripts\_snd::snd_register_message( "aud_cap_sml_onearm_toss", ::aud_cap_sml_onearm_toss );
    soundscripts\_snd::snd_register_message( "aud_separation_logic", ::aud_separation_logic );
    soundscripts\_snd::snd_register_message( "aud_separation_elevator", ::aud_separation_elevator );
    soundscripts\_snd::snd_register_message( "aud_separation_door", ::aud_separation_door );
    soundscripts\_snd::snd_register_message( "start_indoor_alarms", ::start_courtyard_alarms );
    soundscripts\_snd::snd_register_message( "start_indoor_alarms_2", ::start_post_courtyard_interior_alarms );
    soundscripts\_snd::snd_register_message( "aud_gideon_test_chamber_stair_door", ::aud_gideon_test_chamber_stair_door );
    soundscripts\_snd::snd_register_message( "aud_gideon_test_chamber_climb_stairs_1", ::aud_gideon_test_chamber_climb_stairs_1 );
    soundscripts\_snd::snd_register_message( "aud_observation_guard_radio", ::aud_observation_guard_radio );
    soundscripts\_snd::snd_register_message( "aud_zap_scene", ::aud_zap_scene );
    soundscripts\_snd::snd_register_message( "aud_alarm_submix", ::aud_alarm_submix );
    soundscripts\_snd::snd_register_message( "aud_morgue_bodybag_line_emt", ::aud_morgue_bodybag_line_emt );
    soundscripts\_snd::snd_register_message( "aud_morgue_bodybag_doors", ::aud_morgue_bodybag_doors );
    soundscripts\_snd::snd_register_message( "aud_morgue_computer_door_entry_sfx", ::aud_morgue_computer_door_entry_sfx );
    soundscripts\_snd::snd_register_message( "aud_autopsy_knife_pry_door", ::aud_autopsy_knife_pry_door );
    soundscripts\_snd::snd_register_message( "aud_autopsy_entrance", ::aud_autopsy_entrance );
    soundscripts\_snd::snd_register_message( "aud_autopsy_entrance_vo", ::aud_autopsy_entrance_vo );
    soundscripts\_snd::snd_register_message( "aud_hatch_gideon", ::aud_hatch_gideon );
    soundscripts\_snd::snd_register_message( "incinerator_dialogue", ::incinerator_dialogue );
    soundscripts\_snd::snd_register_message( "incinerator_dialogue_2", ::incinerator_dialogue_2 );
    soundscripts\_snd::snd_register_message( "start_incinerator", ::start_incinerator );
    soundscripts\_snd::snd_register_message( "aud_incin_blackout", ::aud_incin_blackout );
    soundscripts\_snd::snd_register_message( "aud_incin_pipe_grab", ::aud_incin_pipe_grab );
    soundscripts\_snd::snd_register_message( "aud_incin_pipe_burst", ::aud_incin_pipe_burst );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light", ::aud_incin_pilot_light );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light1", ::aud_incin_pilot_light1 );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light2", ::aud_incin_pilot_light2 );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light3", ::aud_incin_pilot_light3 );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light4", ::aud_incin_pilot_light4 );
    soundscripts\_snd::snd_register_message( "aud_incin_pilot_light5", ::aud_incin_pilot_light5 );
    soundscripts\_snd::snd_register_message( "aud_incin_cart_start", ::aud_incin_cart_start );
    soundscripts\_snd::snd_register_message( "aud_incin_cart_push", ::aud_incin_cart_push );
    soundscripts\_snd::snd_register_message( "aud_incin_cart_push_stop", ::aud_incin_cart_push_stop );
    soundscripts\_snd::snd_register_message( "aud_incin_cart_done", ::aud_incin_cart_done );
    soundscripts\_snd::snd_register_message( "aud_incin_amb_kill", ::aud_incin_amb_kill );
    soundscripts\_snd::snd_register_message( "aud_incin_flame_loop", ::aud_incin_flame_loop );
    soundscripts\_snd::snd_register_message( "incineration_escape_logic", ::incineration_escape_logic );
    soundscripts\_snd::snd_register_message( "aud_incin_after", ::aud_incin_after );
    soundscripts\_snd::snd_register_message( "aud_incin_after_loop1", ::aud_incin_after_loop1 );
    soundscripts\_snd::snd_register_message( "start_outdoor_alarms", ::start_post_courtyard_ext_alarms );
    soundscripts\_snd::snd_register_message( "stop_post_courtyard_ext_alarms_2", ::stop_post_courtyard_ext_alarms_2 );
    soundscripts\_snd::snd_register_message( "aud_heli_battle_flyover", ::aud_heli_battle_flyover );
    soundscripts\_snd::snd_register_message( "aud_heli_manticore_flyover", ::aud_heli_manticore_flyover );
    soundscripts\_snd::snd_register_message( "aud_manticore_crane", ::aud_manticore_crane );
    soundscripts\_snd::snd_register_message( "aud_cap_escape_to_heli_truck_1", ::aud_cap_escape_to_heli_truck_1 );
    soundscripts\_snd::snd_register_message( "aud_cap_escape_to_heli_truck_2", ::aud_cap_escape_to_heli_truck_2 );
    soundscripts\_snd::snd_register_message( "aud_wakeup_mech_cooldown_pings", ::aud_wakeup_mech_cooldown_pings );
    soundscripts\_snd::snd_register_message( "aud_spark_1", ::aud_spark_1 );
    soundscripts\_snd::snd_register_message( "aud_spark_2", ::aud_spark_2 );
    soundscripts\_snd::snd_register_message( "aud_spark_3", ::aud_spark_3 );
    soundscripts\_snd::snd_register_message( "aud_spark_4", ::aud_spark_4 );
    soundscripts\_snd::snd_register_message( "aud_spark_5", ::aud_spark_5 );
    soundscripts\_snd::snd_register_message( "aud_wakeup_mix", ::aud_wakeup_mix );
    soundscripts\_snd::snd_register_message( "start_mech", ::start_mech );
    soundscripts\_snd::snd_register_message( "aud_mech_jump", ::aud_mech_jump );
    soundscripts\_snd::snd_register_message( "aud_mech_trucks_enter", ::aud_mech_trucks_enter );
    soundscripts\_snd::snd_register_message( "aud_mech1_bg_truck", ::aud_mech1_bg_truck );
    soundscripts\_snd::snd_register_message( "vrap_explode", ::vrap_explode );
    soundscripts\_snd::snd_register_message( "aud_mech_crush_guy", ::aud_mech_crush_guy );
    soundscripts\_snd::snd_register_message( "aud_mech_panic_walla_watcher", ::aud_mech_panic_walla_watcher );
    soundscripts\_snd::snd_register_message( "aud_stop_mech_panic_walla_watcher", ::aud_stop_mech_panic_walla_watcher );
    soundscripts\_snd::snd_register_message( "aud_plr_inside_mech", ::aud_plr_inside_mech );
    soundscripts\_snd::snd_register_message( "aud_mech_missile_fire", ::aud_mech_missile_fire );
    soundscripts\_snd::snd_register_message( "mech_wall_smash", ::mech_wall_smash );
    soundscripts\_snd::snd_register_message( "mech_wall_smash_3d", ::mech_wall_smash_3d );
    soundscripts\_snd::snd_register_message( "mech_warehouse_door_smash", ::mech_warehouse_door_smash );
    soundscripts\_snd::snd_register_message( "mech_scan", ::mech_scan );
    soundscripts\_snd::snd_register_message( "mech_weapon_offline", ::mech_weapon_offline );
    soundscripts\_snd::snd_register_message( "aud_warehouse_roof_machines_line", ::aud_warehouse_roof_machines_line );
    soundscripts\_snd::snd_register_message( "aud_warehouse_roof_machines", ::aud_warehouse_roof_machines );
    soundscripts\_snd::snd_register_message( "aud_warehouse_mech_lift", ::aud_warehouse_mech_lift );
    soundscripts\_snd::snd_register_message( "aud_warehouse_mech_lift_alarm", ::aud_warehouse_mech_lift_alarm );
    soundscripts\_snd::snd_register_message( "aud_warehouse_mech_lift_vo", ::aud_warehouse_mech_lift_vo );
    soundscripts\_snd::snd_register_message( "scn_cap_mech_door_closes", ::scn_cap_mech_door_closes );
    soundscripts\_snd::snd_register_message( "scn_cap_mech_door_grab", ::scn_cap_mech_door_grab );
    soundscripts\_snd::snd_register_message( "aud_mech_obj_move", ::aud_mech_obj_move );
    soundscripts\_snd::snd_register_message( "aud_mech_obj_move_wait", ::aud_mech_obj_move_wait );
    soundscripts\_snd::snd_register_message( "aud_mech_obj_move_end", ::aud_mech_obj_move_end );
    soundscripts\_snd::snd_register_message( "aud_door", ::aud_door );
    soundscripts\_snd::snd_register_message( "aud_heli_escape_idle_sfx", ::aud_heli_escape_idle_sfx );
    soundscripts\_snd::snd_register_message( "aud_crash_wakeup_sfx", ::aud_crash_wakeup_sfx );
}

zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {

    }
}

music_handler( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "mus_captured_intro":
            soundscripts\_audio_music::mus_play( "mus_captured_intro", 4 );
            common_scripts\utility::flag_wait( "flag_stop_intro_music" );
            wait 3.0;
            soundscripts\_audio_music::mus_stop( 4.0 );
            break;
        case "mus_captured_trolley":
            wait 0.7;
            soundscripts\_audio::aud_set_music_submix( 1.5, 0 );
            soundscripts\_audio_music::mus_play( "mus_captured_trolley", 0 );
            wait 13;
            soundscripts\_audio::aud_set_music_submix( 1, 4 );
            break;
        case "mus_captured_interrogation":
            wait 0.3;
            soundscripts\_audio_music::mus_play( "mus_captured_interrogation_pt1", 0 );
            common_scripts\utility::flag_wait( "flag_start_interrogation_music_pt2" );
            wait 0.5;
            soundscripts\_audio_music::mus_play( "mus_captured_interrogation_pt2", 0, 20 );
            wait 18;
            soundscripts\_audio::aud_set_music_submix( 10, 3 );
            wait 12;
            soundscripts\_audio::aud_set_music_submix( 1, 3 );
            break;
        case "mus_captured_escape":
            wait 9.5;
            soundscripts\_audio_music::mus_play( "mus_captured_escape", 0 );
            break;
        case "mus_captured_escape_end":
            maps\_utility::music_stop( 3 );
            break;
        case "mus_captured_test_chamber":
            soundscripts\_audio_music::mus_play( "mus_captured_test_chamber", 0 );
            break;
        case "mus_captured_halls":
            wait 1.5;
            soundscripts\_audio_music::mus_play( "mus_captured_halls", 0 );
            break;
        case "mus_captured_halls_end":
            common_scripts\utility::flag_wait( "flag_ah_combat_done" );
            maps\_utility::music_stop( 4 );
            soundscripts\_audio_zone_manager::azm_start_zone( "morgue_2", 1.0 );
            break;
        case "mus_captured_incinerator":
            soundscripts\_audio_music::mus_play( "mus_captured_incinerator", 0 );
            break;
        case "mus_captured_mech":
            wait 2;
            soundscripts\_audio_music::mus_play( "mus_captured_mech", 0 );
            break;
        case "mus_captured_mech_end":
            soundscripts\_audio_music::mus_play( "mus_captured_mech_end", 1 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

start_intro_drive()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "intro_drive", 1.0 );
}

start_s1_elevator()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "s2_walk", 1.0 );
}

start_s2_walk()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "s1_elevator", 1.0 );
}

start_s2_elevator()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "s2_elevator", 1.0 );
}

start_escape()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "pre_stair_hall", 1.0 );
}

start_test_chamber()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "pre_stair_hall", 1.0 );
}

start_halls_to_autopsy()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "test_chamber", 1.0 );
}

start_trolley()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "trolley", 1.0 );
}

start_incinerator()
{
    soundscripts\_snd::snd_message( "aud_incin_blackout" );
}

start_battle_to_heli()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "pre_run_to_heli", 1.0 );
}

scn_truck_sounds()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_intro_drive_lr" );
}

aud_intro_truck_gate( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_intro_truck_underpass_lr" );
}

aud_intro_truck_passby_01( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_intro_truck_passby_01" );
}

aud_intro_truck_passby_02( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_intro_truck_passby_02" );
    soundscripts\_snd::snd_message( "aud_intro_caravan_mute" );
}

aud_intro_truck_stop( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_intro_drive_stop_lr" );
}

aud_intro_heli_flyover()
{

}

aud_intro_caravan_passby()
{
    wait 7;

    if ( !common_scripts\utility::flag( "flag_entered_s1elevator" ) )
        soundscripts\_snd_playsound::snd_play_at( "scn_intro_truck_caravan_passby", ( 5073, -4905, 61 ) );
}

aud_intro_caravan_mute()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "intro_caravan_mute" );
}

aud_intro_caravan_unmute()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "intro_caravan_mute", 2 );
    common_scripts\utility::flag_wait( "flag_entered_s1elevator" );
    soundscripts\_audio_mix_manager::mm_add_submix( "intro_caravan_mute" );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "intro_caravan_mute" );
}

aud_intro_to_elev_walla()
{
    wait 16;
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_intro_to_elev_walla_lp", ( 4719, -4602, 147 ), "kill_intro_to_elev_walla", 2, 2 );
}

aud_mech_idle_sfx()
{
    var_0 = getent( "aud_mech_idle_sfx", "targetname" );
    var_0 waittill( "trigger" );
    soundscripts\_snd_playsound::snd_play_at( "scn_intro_mech_idle", ( 5429, -5418, 36 ) );
}

entrance_alarm()
{

}

entrance_alarm_fast2()
{

}

entrance_alarm_fast()
{
    soundscripts\_snd_playsound::snd_play_at( "captured_entrance_alarm", ( 5409, -5208, 299 ) );
}

entrance_vo_01()
{
    wait 11;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_nowenteringgateb", ( 3893, -1872, 287 ) );
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_nowenteringgateb", ( 3561, -2057, 287 ) );
    wait 8.8;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_clearentrypermitted", ( 3893, -1872, 287 ) );
}

entrance_vo_03()
{
    wait 12.5;
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_compliancewithcamp", ( 6368, -3196, 604 ) );
    wait 6.2;
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_noncompliancewith2_alt01", ( 6368, -3196, 604 ) );
    wait 7.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_failuretoreportnon_alt01", ( 4188, -3173, 422 ) );
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_ls1_failuretoreportnon_alt01", ( 6368, -3196, 604 ) );
}

aud_stop_cormack_foley()
{
    wait 1.5;
    level notify( "stop_cormack_foley" );
    soundscripts\_audio_mix_manager::mm_add_submix( "s2_walk_pre_start" );
}

aud_ambient_animations( var_0 )
{
    switch ( var_0 )
    {
        case "cap_s2_walk_stake_inmate_01":
            soundscripts\_snd::snd_message( "aud_s2walk_yard_prisoners_whimpering" );
            break;
        case "cap_s2_walk_pitexecutions_01":
            break;
        case "cap_s2_walk_beating_prisoner2":
            soundscripts\_snd::snd_message( "aud_s2walk_prisoner_2_beating" );
            break;
    }
}

s2_elevator_door_open_top()
{
    soundscripts\_snd_playsound::snd_play_linked( "scn_cap_elevator_open" );
}

s2_elevator_ride_down()
{
    level notify( "kill_intro_to_elev_walla" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "scn_cap_intro_elevator_ride_lr", 2.669, undefined, "s2_elevator_stop_sfx" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "scn_cap_intro_elevator_ride_mtl_lr", 7.642, undefined, "s2_elevator_stop_sfx" );
}

s2_elevator_door_open()
{
    common_scripts\utility::flag_set( "flag_stop_intro_music" );
    thread s2_walk_footsteps();
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2_walk_pre_start" );
}

s2_walk_footsteps()
{
    level.aud.s2_walk_footsteps = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "s2_walk_footsteps" );
    common_scripts\utility::flag_wait( "flag_s2walk_end" );
    level.aud.s2_walk_footsteps = 0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2_walk_footsteps" );
}

s2_elevator_door_close()
{
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_cap_elevator_open", ( 5481, -5808, -548 ), 4.0 );
}

s2_prison_amb()
{
    var_0 = getent( "s2_cell_prisoner_trigger_on", "targetname" );
    var_0 waittill( "trigger" );
}

aud_plr_hit()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_plr_hit_s2walk" );
}

aud_plr_hit_vo_move_forward()
{

}

aud_plr_hit_vo_move_back()
{

}

aud_plr_hit_vo_look()
{

}

aud_plr_hit_vo_line()
{

}

s2_walk_vo_execution()
{
    wait 6;
    soundscripts\_snd::snd_message( "s2_walk_execution_PA" );
    wait 17;
    wait 4.75;
    soundscripts\_snd::snd_message( "aud_s2walk_execution_fire" );
}

s2_walk_execution_pa()
{
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_prisonerslineup", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_prisonerslineup", ( 7258, -7272, -375 ), 0.2 );
    wait 5.18;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_stepdownintothe", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_stepdownintothe", ( 7258, -7272, -375 ), 0.2 );
    wait 5;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_liefacedown", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_liefacedown", ( 7258, -7272, -375 ), 0.2 );
    wait 3.08;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_facesdown", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_facesdown", ( 7258, -7272, -375 ), 0.2 );
    wait 3.02;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_nobursts", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_nobursts", ( 7258, -7272, -375 ), 0.2 );
    wait 1.18;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_singleselect", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_singleselect", ( 7258, -7272, -375 ), 0.2 );
    wait 3.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_fire", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_fire", ( 7258, -7272, -375 ), 0.2 );
    wait 2.14;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_nextgrouplineup", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_nextgrouplineup", ( 7258, -7272, -375 ), 0.2 );
    wait 2.1;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_stepdownintothe2", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_stepdownintothe2", ( 7258, -7272, -375 ), 0.2 );
    wait 3.04;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_shouldertoshoulder2", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_shouldertoshoulder2", ( 7258, -7272, -375 ), 0.2 );
    wait 3.1;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_facedown2", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_facedown2", ( 7258, -7272, -375 ), 0.2 );
    wait 3.1;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_prisonerslineup2", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_prisonerslineup2", ( 7258, -7272, -375 ), 0.2 );
    wait 5.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_stepdownintothe3", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_stepdownintothe3", ( 7258, -7272, -375 ), 0.2 );
    common_scripts\utility::flag_wait( "flag_s2walk_near_end" );
    wait 4;
    soundscripts\_snd_playsound::snd_play_at( "cap_gr6_liefacedown2", ( 6681, -6169, -375 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_gr6_liefacedown2", ( 7258, -7272, -375 ), 0.2 );
}

aud_s2walk_trigger_start()
{
    var_0 = getent( "s2walk_celldoor_trigger", "targetname" );
    var_0 waittill( "trigger" );
    soundscripts\_snd::snd_message( "aud_s2walk_cells_foley_mix" );
    soundscripts\_audio_zone_manager::azm_start_zone( "s2_walk_cell", 0.1 );
    wait 1.5;
    soundscripts\_snd::snd_message( "aud_s2walk_door_close" );
}

aud_s2walk_emitters()
{
    var_0 = soundscripts\_snd_playsound::snd_play_loop_at( "scn_s2walk_fire_trench", ( 6691, -7051, -592 ), "snd_fire_trench_clear", 0, 3.5 );
    wait 2;
    soundscripts\_snd_playsound::snd_play_at( "emt_buzzer", ( 6180, -5970, -504 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_cap_s2walk_yard_walla_lp", ( 6732, -6787, -564 ), "prisoners_death" );
    level notify( "start_helicopter_fly" );
    soundscripts\_snd_playsound::snd_play_at( "scn_captured_s2_heli_flyover", ( 6133, -6375, -387 ) );
    wait 5.7;
    soundscripts\_snd::snd_message( "aud_s2walk_alarm_tone_lp" );
    wait 2.7;
    wait 5.8;
    wait 4.5;
    wait 1.3;
    soundscripts\_snd_playsound::snd_play_at( "emt_buzzer", ( 5960, -6926, -512 ) );
    thread snd_trench_fire_off( var_0 );
    wait 22.5;
    soundscripts\_snd::snd_message( "aud_s2walk_flyby_1" );
}

aud_s2walk_temp_guard_vo( var_0 )
{

}

snd_trench_fire_off( var_0 )
{
    wait 6;
    level notify( "snd_fire_trench_clear" );
}

aud_s2walk_flyby_1()
{
    level notify( "start_helicopter_fly" );
    level.player playsound( "scn_captured_s2_warbird_flyover" );
    wait 2;
    level.player playsound( "scn_captured_s2_heli_dust_lr" );
}

aud_s2walk_alarm_tone_lp()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "scn_captured_s2_alarm_tone", ( 6160, -7477, -358 ), "snd_alarm_tone_stop", 4.0, 0.2 );
    wait 17;
    level notify( "snd_alarm_tone_stop" );
}

aud_s2walk_prisoner_2_beating()
{
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_pr10_oof", ( 6096.3, -6252.4, -554.8 ), 14.8 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_pr10_argh", ( 6096.3, -6252.4, -554.8 ), 16 );
}

aud_s2walk_execution_kneeling_prisoners()
{
    wait 2;
}

aud_s2walk_execution_fire()
{
    level notify( "prisoners_death" );
    soundscripts\_snd_playsound::snd_play_at( "scn_captured_s2_execution", ( 6645, -6535, -550 ) );
}

aud_s2walk_door_open()
{
    soundscripts\_snd_playsound::snd_play_linked( "scn_captured_s2_door_open" );
}

aud_s2walk_door_close()
{
    level.player playsound( "scn_captured_s2_door_close" );
}

aud_s2walk_loudspeaker2_line1()
{
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_ls2_proceedinorderby", ( 5485, -6287.7, -391 ), 4 );
}

aud_s2walk_loudspeaker2_line2()
{
    soundscripts\_snd_playsound::snd_play_at( "cap_ls2_proceedinorderby2", ( 5191, -7727, -404 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_ls2_proceedinorderby2", ( 5547, -7717, -415 ), 0.2 );
}

aud_s2walk_guard_radios()
{
    wait 6;
    soundscripts\_snd_playsound::snd_play_at( "emt_cap_s2walk_guard_radiowalla_1", ( 6026, -5942, -556 ) );
    wait 7;
    soundscripts\_snd_playsound::snd_play_at( "emt_cap_s2walk_guard_radiowalla_2", ( 6118, -6172, -556 ) );
    wait 29;
    soundscripts\_snd_playsound::snd_play_at( "emt_cap_s2walk_guard_radiowalla_4", ( 5525, -6913, -393 ) );
}

aud_s2walk_cell_prisoners( var_0 )
{
    if ( level.aud.cell_prisoners_trig == 0 )
    {
        level.aud.cell_prisoners_trig = 1;
        soundscripts\_snd_playsound::snd_play_loop_at( "emt_cap_s2walk_cell_walla_lp", ( 5586.6, -6934.24, -548.2 ) );
        soundscripts\_snd_playsound::snd_play_at( "emt_s2_cell_01_l", ( 5861, -6998, -545 ) );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_s2_cell_01_R", ( 5855, -6854, -545 ), 4.114 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_cap_s2walk_cellprisoner_1", ( 5855, -6854, -545 ), 2.3 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_s2_cell_02_R", ( 5733, -6850, -545 ), 6.3 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_cap_s2walk_cellprisoner_2", ( 5733, -6850, -545 ), 6.3 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_s2_cell_02_l", ( 5613, -7028, -545 ), 5 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_s2_cell_03_R", ( 5603, -6856, -545 ), 7.9 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_cap_s2walk_cellprisoner_3", ( 5603, -6856, -545 ), 7.9 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_s2_cell_03_l", ( 5492, -7002, -545 ), 12.3 );
        soundscripts\_snd_playsound::snd_play_delayed_at( "emt_cap_s2walk_cellprisoner_4", ( 5492, -7002, -545 ), 12.3 );
        wait 12;
        soundscripts\_audio_mix_manager::mm_add_submix( "s2walk_cells_walla_down" );
    }
}

aud_s2walk_guard_hip_radio( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "cap_gr9_copythatprisoners" );
}

aud_s2walk_cells_foley_mix()
{
    wait 2.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "s2walk_cells_foley" );
}

aud_s2walk_clear_foley_mix()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2walk_cells_foley" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "s2walk_cells_walla_down" );
}

aud_s2walk_yard_prisoners_whimpering()
{
    wait 2;
    soundscripts\_snd_playsound::snd_play_at( "cap_pr7_painfulgroan", ( 5200, -7433.2, -587.2 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_pr8_pleasewater", ( 5533.5, -7558.5, -587.2 ), 1 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_pr9_coughgroan", ( 5676, -7549.9, -601.5 ), 1 );
}

aud_cap_s2_trolley_sfx_01( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_01" );
}

aud_cap_s2_trolley_sfx_02( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_02" );
    soundscripts\_audio_mix_manager::mm_add_submix( "trolley_mix" );
}

aud_cap_s2_trolley_sfx_03( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_03" );
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "trolley_mix" );
    soundscripts\_audio_mix_manager::mm_add_submix( "trolley_mix_2" );
}

aud_cap_s2_trolley_sfx_03_crk( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_captured_trolley_03_crk" );
}

aud_cap_s2_trolley_sfx_04( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_04" );
}

aud_cap_s2_trolley_sfx_05( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_05" );
}

aud_cap_s2_trolley_sfx_06( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_06" );
}

aud_cap_s2_trolley_sfx_07( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_07" );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "trolley_mix_2" );
    soundscripts\_audio_mix_manager::mm_add_submix( "trolley_mix_3" );
}

aud_cap_s2_trolley_sfx_08( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_08" );
}

aud_cap_s2_trolley_sfx_09( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_09" );
}

aud_cap_s2_trolley_sfx_10( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_trolley_10" );
    wait 7;
    soundscripts\_audio_mix_manager::mm_clear_submix( "trolley_mix_3", 1 );
}

aud_limp_on()
{
    level.aud.limp_footsteps = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "limp_footsteps" );
}

aud_limp_exo()
{
    level.aud.limp_footsteps = 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "limp_footsteps" );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "limp_footsteps_exo" );
}

aud_limp_off()
{
    level.aud.limp_footsteps = 0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "limp_footsteps_exo" );
}

aud_rescue_sfx_a( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_a_lr" );
}

aud_rescue_sfx_b( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_b_lr" );
}

aud_rescue_sfx_c( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_c_lr" );
}

aud_rescue_sfx_d( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_d_lr" );
}

aud_rescue_sfx_e( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_e_lr" );
}

aud_rescue_sfx_f( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_f_lr" );
}

aud_rescue_sfx_g( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_g_lr" );
}

aud_rescue_drone( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "escape", 3 );
    soundscripts\_audio_mix_manager::mm_add_submix( "rescue_vign" );
    wait 3;
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_captured_rescue_low_lr" );
    wait 33;
    soundscripts\_audio_mix_manager::mm_clear_submix( "rescue_vign" );
}

aud_red_light()
{
    wait 1.3;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_esc_red_light", ( 5246, -10374, -1679 ) );
}

aud_stop_headspace_ambience()
{
    wait 7;
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "body_hall", "amb_captured_hallways_lr", 4.0 );
    soundscripts\_audio_zone_manager::azm_set_zone_reverb( "body_hall", "captured_hall", 1.0 );
}

aud_play_horror_ambience()
{
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "decontam", "amb_captured_horror_lr", 0.5 );
}

aud_stop_horror_ambience()
{
    soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience( "test_chamber", "amb_captured_hallways_lr", 5.0 );
}

aud_escape_doctor_bodybag()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_esc_door_open", ( 5273, -10314, -1708 ) );
    wait 1.45;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_esc_doctor_bodybag", ( 5273, -10314, -1708 ) );
    wait 6.1;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_esc_door_shut", ( 5273, -10314, -1708 ) );
}

aud_s3escape_doctor_radio( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "emt_cap_escape_doctor_radiowalla", "doctor_door_closed" );
    wait 7.35;
    level notify( "doctor_door_closed" );
}

aud_escape_give_gun_exo()
{
    maps\_utility::play_sound_on_entity( "scn_cap_esc_give_gun" );
}

aud_onearm_weapon_swap( var_0 )
{
    if ( var_0 == "iw5_titan45onearm_sp_xmags" )
        level.player playsound( "wpn_handgun_raise_plr_onearm" );
    else
        level.player playsound( "wpn_sml_raise_plr_onearm" );
}

aud_cap_45_onearm_toss()
{
    level.player playsound( "wpn_handgun_onearm_toss" );
}

aud_cap_sml_onearm_toss()
{
    level.player playsound( "wpn_sml_onearm_toss" );
}

aud_morgue_bodybag_line_emt()
{
    var_0 = "emt_morgue_bag_mvmt_lp";
    thread soundscripts\_audio::aud_play_line_emitter( "moving_bags_01", var_0, ( 5328, -13249, -1527 ), ( 4785, -13249, -1527 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "moving_bags_02", var_0, ( 5328, -13301, -1527 ), ( 5328, -14645, -1527 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "moving_bags_03", var_0, ( 4640, -12019, -1527 ), ( 4640, -12550, -1527 ) );
}

aud_morgue_bodybag_doors( var_0 )
{
    if ( var_0 == "open" )
        var_1 = "scn_morgue_bb_door_open";
    else
        var_1 = "scn_morgue_bb_door_close";

    var_2 = 0;

    foreach ( var_4 in self.doors )
    {
        var_2++;

        if ( var_2 % 2 == 0 )
            soundscripts\_snd_playsound::snd_play_at( var_1, var_4.open );
    }
}

aud_escape_guard_takedown_door()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_ally_guard_door", ( 5250, -10490, -1708 ) );
}

aud_escape_keycard( var_0 )
{
    switch ( var_0 )
    {
        case "control_room":
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_swipe", ( 5012, -10738, -1708 ) );
            wait 0.2;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_accept", ( 5012, -10738, -1708 ) );
            break;
        case "exit_door":
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_swipe", ( 4438, -10740, -1708 ) );
            wait 0.2;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_accept", ( 4438, -10740, -1708 ) );
            break;
        case "tc_stairs_door":
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_swipe", ( 3890, -10702, -1708 ) );
            wait 0.2;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_accept", ( 3890, -10702, -1708 ) );
            break;
    }
}

aud_morgue_computer_door_entry_sfx()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_morgue_comp_beep_01", ( 5469, -14436, -1584 ) );
    wait 0.4;
    soundscripts\_snd_playsound::snd_play_at( "scn_morgue_comp_beep_02", ( 5469, -14436, -1584 ) );
}

aud_separation_logic()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_separ_console_plr" );
}

aud_separation_elevator()
{
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_at( "scn_separ_elevator_open", ( 4731, -10977, -1697 ) );
}

aud_separation_door()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_separ_large_door_close", ( 4754, -10874, -1697 ) );
}

aud_observation_guard_radio()
{
    wait 14;
    soundscripts\_snd_playsound::snd_play_at( "emt_cap_test_chamber_radiowalla", ( 3998, -11305, -1516 ) );
}

aud_zap_scene()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_zap_door_close", ( 4368.5, -12011.9, -1611.9 ) );
    wait 1.85;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_zap_glow1", ( 4439, -11943, -1595 ) );
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_zap_glow2", ( 4295, -11937, -1595 ) );
    soundscripts\_snd_playsound::snd_play_2d( "scn_cap_zap" );
    thread aud_zap_logic_change();
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_cap_zap_door_open", ( 4363.1, -11895.5, -1611.9 ), 4.1 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sri_sequencing", ( 4370, -11919, -1553 ), 0.8 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sri_cleared", ( 4370, -11919, -1553 ), 3.5 );
    level notify( "stop_courtyard_alarms" );
    soundscripts\_snd::snd_message( "aud_alarm_submix" );
}

aud_zap_logic_change()
{
    wait 2;
    soundscripts\_audio_zone_manager::azm_start_zone( "decontam_headspace", 0 );
    wait 1;
    soundscripts\_audio_zone_manager::azm_start_zone( "test_chamber", 6 );
    wait 1;
    soundscripts\_snd::snd_music_message( "mus_captured_test_chamber" );
    soundscripts\_snd::snd_message( "aud_play_horror_ambience" );
}

aud_autopsy_knife_pry_door( var_0 )
{
    if ( var_0 == "handgun" )
    {
        level.player soundscripts\_snd_playsound::snd_play_linked( "scn_autopsy_door_knife_intro" );
        level.player soundscripts\_snd_playsound::snd_play_linked( "wpn_handgun_onearm_toss_autopsy" );
    }
    else
        level.player soundscripts\_snd_playsound::snd_play_linked( "wpn_sml_onearm_toss_autopsy" );
}

aud_autopsy_entrance()
{
    soundscripts\_snd::snd_message( "aud_autopsy_entrance_vo" );
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_autopsy_entrance_foley" );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_entrance_doors", ( 5672, -14546, -1572 ), 0.9 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_door_r", ( 5708, -14633, -1572 ), 2.6 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_door_l", ( 5719, -14452, -1572 ), 2.7 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_entrance_punch", ( 5812, -14607, -1572 ), 4.2 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_sci_fall", ( 5812, -14607, -1572 ), 4.5 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "scn_autopsy_dist_table", ( 6388, -14634, -1572 ), 5.8 );
}

aud_autopsy_entrance_vo()
{
    wait 2.2;
    soundscripts\_snd_playsound::snd_play_at( "cap_sc1_ahhheytakeiteasy", ( 5812, -14607, -1572 ) );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sc2_ahhohmygod", ( 5898, -14849, -1572 ), 3.5 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sc3_ahhscaredreaction", ( 6079, -14577, -1572 ), 3.2 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sc5_ahhscaredreaction", ( 6394, -14861, -1572 ), 3.5 );
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_sc4_ahhscaredreaction", ( 6383, -14634, -1572 ), 3.5 );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "cap_sc5_whimpering", 10, 0, ( 6394, -14861, -1572 ), "stop_mumbling" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_at( "cap_sc4_whimpering", 10, 0, ( 6383, -14634, -1572 ), "stop_mumbling" );
}

aud_gun_throw_logic( var_0 )
{
    level notify( "stop_mumbling" );
    var_1 = soundscripts\_snd_playsound::snd_play_at( "scn_autopsy_doc_gun", ( 6853, -14726, -1551 ) );
    var_1 moveto( ( 6564, -14805, -1567 ), 0.8 );
    var_2 = soundscripts\_snd_playsound::snd_play_at( "scn_autopsy_doc_gun_2", ( 6445, -14871, -1626 ) );
    wait 0.541;
    var_2 moveto( ( 6162, -14851, -1612 ), 1.5 );
    wait 4;
    thread start_autopsy_alarm();
}

aud_hatch_plr( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_autopsy_hatch_plr" );
}

aud_hatch_gideon()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_autopsy_doc_gid_05", ( 6983, -14793, -1571 ) );
}

trigger_darkness()
{
    self waittill( "trigger" );
    soundscripts\_audio_zone_manager::azm_start_zone( "incinerator_int_vol_down", 0 );
    wait 1.6;
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_black_lr" );
    soundscripts\_snd::snd_message( "incinerator_dialogue" );
    level notify( "stop_autopsy_alarm" );
    level notify( "stop_stop_post_courtyard_alarms" );
}

aud_incin_blackout()
{
    wait 8.35;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light" );
    wait 7.5;
    soundscripts\_audio_zone_manager::azm_start_zone( "incinerator_int_vol_up", 1.0 );
}

incinerator_dialogue()
{
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_2d( "cap_plr_argh" );
    wait 1.7;
    soundscripts\_snd_playsound::snd_play_2d( "cap_gdn_wherearewe" );
    wait 3.7;
    soundscripts\_snd_playsound::snd_play_at( "cap_gdn_holdonillgetalight", ( 7582, -13441, -1678 ) );
}

incinerator_dialogue_2()
{
    wait 3.8;
}

aud_incin_pilot_light()
{
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light", ( 7651, -13427, -1675 ) );
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_main_lr" );
    thread aud_play_dust();
    wait 2.45;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light1" );
}

aud_play_dust()
{
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_main_dust_lr" );
}

aud_incin_pilot_light1()
{
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light_2", ( 7851, -13394, -1685 ) );
    wait 1;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light2" );
}

aud_incin_pilot_light2()
{
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light_3", ( 8106, -13393, -1685 ) );
    wait 0.75;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light3" );
}

aud_incin_pilot_light3()
{
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light_4", ( 8296, -13396, -1685 ) );
    wait 0.65;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light4" );
}

aud_incin_pilot_light4()
{
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light_5", ( 8424, -13397, -1685 ) );
    wait 0.5;
    soundscripts\_snd::snd_message( "aud_incin_pilot_light5" );
}

aud_incin_pilot_light5()
{
    soundscripts\_snd_playsound::snd_play_at( "incineration_pilot_light_6", ( 8617, -13397, -1685 ) );
    level.aud.incin_burst soundscripts\_snd_playsound::snd_play_linked( "incineration_burst_2d" );
    thread aud_close_sounds();
    soundscripts\_snd::snd_message( "aud_incin_flame_loop" );
}

aud_close_sounds()
{
    wait 1.66;
    level.aud.incin_close = soundscripts\_snd_playsound::snd_play_loop_2d( "amb_incin_above_lr" );
}

aud_incin_flame_loop()
{
    while ( level.aud.flame_loop == 0 )
    {
        wait 8.508;

        if ( level.aud.flame_loop == 0 )
            level.aud.incin_burst soundscripts\_snd_playsound::snd_play_linked( "incineration_burst" );
    }
}

aud_incin_cart_start()
{
    wait 0.5;
}

aud_incin_cart_push()
{
    if ( isdefined( level.aud.cart_first_time ) && level.aud.cart_first_time == 1 )
    {
        level.aud.cart_push2 scalevolume( 1, 0 );
        level.aud.cart_push soundscripts\_snd_playsound::snd_play_linked( "scn_incin_cart_start" );
        level.aud.cart_push2 soundscripts\_snd_playsound::snd_play_loop( "scn_incin_cart_start_middle" );
        level.aud.cart_first_time = 0;
    }
    else
        level.aud.cart_push2 scalevolume( 1, 0 );
}

aud_incin_cart_push_stop()
{
    if ( isdefined( level.aud.cart_push2 ) )
        level.aud.cart_push2 scalevolume( 0, 0 );
}

aud_incin_cart_done()
{
    wait 1;
    thread aud_stop_sound_logic();
    wait 1.4;
    soundscripts\_snd::snd_message( "incineration_escape_logic" );
}

aud_stop_sound_logic()
{
    wait 0.4;
    level.aud.cart_push2 scalevolume( 0, 1 );
    level.aud.cart soundscripts\_snd_playsound::snd_play_2d( "scn_incin_cart_end" );
    wait 1.4;
    level.aud.cart_push2 stoploopsound();
    wait 0.1;
    level.aud.cart_push2 delete();
}

incineration_escape_logic()
{
    wait 5.8;
    thread snd_scalevo_flame_logic();
    level.aud.flame_loop = 1;
    soundscripts\_snd_playsound::snd_play_2d( "incineration_burst_escape" );
    soundscripts\_snd::snd_message( "aud_incin_flame_loop_2" );
    wait 1.85;
    soundscripts\_snd_playsound::snd_play_2d( "incineration_burst_escape_body" );
}

snd_scalevo_flame_logic()
{
    level.aud.incin_burst scalevolume( 0, 5 );
    wait 1;
    level.aud.incin_burst stopsounds();
    soundscripts\_audio_zone_manager::azm_start_zone( "incinerator_underground", 0.5 );
    level.aud.incin_close scalevolume( 0, 1 );
    wait 1;
    level.aud.incin_close stoploopsound();
    wait 0.1;
    level.aud.incin_close delete();
}

aud_incin_flame_loop_2()
{
    level.aud.incin_burst2 soundscripts\_snd_playsound::snd_play_linked( "incineration_burst_escape_end" );
    level.aud.incin_burst2 scalevolume( 0, 0 );
    thread aud_incin_flame_logic_first_burst();

    while ( level.aud.flame_loop2 == 0 )
    {
        wait 8.508;

        if ( level.aud.flame_loop2 == 0 )
            level.aud.incin_burst2 soundscripts\_snd_playsound::snd_play_linked( "incineration_burst" );
    }
}

aud_incin_flame_logic_first_burst()
{
    wait 0.8;
    level.aud.incin_burst2 scalevolume( 1, 2 );
}

aud_incin_pipe_grab()
{
    wait 0.1;
    soundscripts\_audio_music::mus_stop( 2 );
    thread scale_flame_sound_logic2();
    level.aud.flame_loop2 = 1;
    wait 1.0;
    soundscripts\_audio_zone_manager::azm_start_zone( "incinerator_ext", 1.0 );
    wait 1.5;
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_pipe_fireball_lr" );
}

scale_flame_sound_logic2()
{
    wait 1;
    level.aud.incin_burst2 scalevolume( 0, 2 );
    wait 2;
    level.aud.incin_burst2 stopsounds();
}

aud_incin_pipe_burst()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_pipe_expl" );
    soundscripts\_snd_playsound::snd_play_2d( "scn_incinerator_pipe_expl_trans" );
    soundscripts\_snd::snd_message( "aud_incin_after" );
}

aud_incin_amb_kill()
{
    level.incin_amb stoploopsound();
    wait 0.1;
    level.incin_amb delete();
}

aud_incin_after()
{
    wait 5;
    soundscripts\_snd::snd_message( "aud_incin_after_loop1" );
}

aud_incin_after_loop1()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_01", ( 7986, -13440, -1759 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_02", ( 8570, -13576, -1670 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_03", ( 8273, -13504, -1712 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_04", ( 8575, -13579, -1670 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_05", ( 8146, -13426, -1759 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_09", ( 7954, -13601, -1692 ) );
    thread aud_engine_wait();
}

aud_engine_wait()
{
    wait 1;
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_06", ( 7959, -13650, -1769 ) );
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_08", ( 8301, -13490, -1692 ) );
    wait 1.4;
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_afterincin_engine_10", ( 8301, -13490, -1692 ) );
}

aud_heli_battle_flyover()
{
    var_0 = self;
    var_0 vehicle_turnengineoff();
    wait 1.6;
    var_0 thread soundscripts\_snd_playsound::snd_play_linked( "scn_cap_bh_heli_flyover" );
    wait 11.0;
    var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "scn_cap_bh_heli_hover", undefined, 2.0, 1.0 );
}

aud_heli_manticore_flyover()
{
    var_0 = self;
    var_0 vehicle_turnengineoff();
    var_0 thread soundscripts\_snd_playsound::snd_play_linked( "scn_cap_manticore_heli_flyover" );
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_manticore_flyover_rattle_r", ( 11884, -13713, -1808 ) );
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_manticore_flyover_rattle_l", ( 11846, -13514, -1808 ) );
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_manticore_flyover_rattle_b", ( 11595, -13524, -1808 ) );
    thread stop_post_courtyard_ext_alarms_2();
}

aud_manticore_crane()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_manticore_crane", ( 12140, -13782, -1819 ) );
}

aud_cap_escape_to_heli_truck_1()
{
    if ( isarray( self ) )
    {
        foreach ( var_1 in self )
        {
            if ( !isdefined( var_1 ) )
                return;

            if ( isremovedentity( var_1 ) )
                return;

            if ( var_1 maps\_vehicle::isvehicle() )
                var_1 thread soundscripts\_snd_playsound::snd_play_linked( "scn_cap_escape_to_heli_truck_1" );

            wait 5.7;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck1_door_open", ( 12498.9, -12865.8, -1974 ) );
            wait 3.3;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck1_guard_land", ( 12439.8, -12877.7, -2003.3 ) );
            wait 0.3;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck1_door_close", ( 12498.9, -12865.8, -1974 ) );
            return;
        }
    }
}

aud_cap_escape_to_heli_truck_2()
{
    if ( isarray( self ) )
    {
        foreach ( var_1 in self )
        {
            if ( !isdefined( var_1 ) )
                return;

            if ( isremovedentity( var_1 ) )
                return;

            if ( var_1 maps\_vehicle::isvehicle() )
                wait 4;

            var_1 thread soundscripts\_snd_playsound::snd_play_linked( "scn_cap_escape_to_heli_truck_2" );
            wait 11.2;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck2_door_open", ( 11885.3, -12632.6, -1959.3 ) );
            wait 2.2;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck2_guard_land", ( 11870.9, -12718.2, -2021.1 ) );
            wait 0.6;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_runtoheli_truck2_door_close", ( 11885.3, -12632.6, -1959.3 ) );
            return;
        }
    }
}

stop_post_courtyard_ext_alarms_2()
{
    level notify( "stop_post_courtyard_ext_alarms_2" );
}

aud_heli_escape_idle_sfx()
{
    wait 8;
    soundscripts\_snd_playsound::snd_play_loop_linked( "scn_cap_heli_idle_engine", "stop_heli_loop", 2.0, 3 );
    soundscripts\_snd_playsound::snd_play_loop_linked( "scn_cap_heli_idle_chop", "stop_heli_loop", 2.0, 3 );
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    level notify( "stop_heli_loop" );
}

aud_cap_heli_sfx_01( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "heli_ride", 2.0 );
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_01_lr" );
}

aud_cap_heli_sfx_02( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_02_lr" );
}

aud_cap_heli_sfx_03( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_03_lr" );
}

aud_cap_heli_sfx_04( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_04_lr" );
}

aud_cap_heli_sfx_05( var_0 )
{
    soundscripts\_snd_timescale::snd_set_timescale( "captured_timescale_override" );
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_05_lr" );
}

aud_cap_heli_sfx_06( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_06_lr" );
    wait 5;
    soundscripts\_snd::snd_message( "aud_crash_wakeup_sfx" );
    wait 1;
    soundscripts\_snd_timescale::snd_set_timescale( "captured_default" );
}

aud_crash_wakeup_sfx()
{
    wait 0.5;
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_cap_heli_wakeup_lr" );
}

aud_wakeup_mix()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "wake_up_before", 0 );
}

aud_wakeup_amb( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "wake_up", 4.0 );
}

aud_wakeup_mech_cooldown_pings()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "emt_cap_metal_cool_pings", ( 10663, -5838, 492 ), "flag_getting_into_mech", 1.0, 1.0 );
}

aud_spark_1()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_wakeup_mech_sparks" );
}

aud_spark_2()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_wakeup_mech_sparks2" );
}

aud_spark_3()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_wakeup_mech_sparks3" );
}

start_mech()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "mech_into", 2.0 );
    wait 22;
    soundscripts\_snd::snd_message( "aud_plr_inside_mech" );
}

aud_spark_4()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_entr_spark_01" );
}

aud_spark_5()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_entr_spark_02" );
}

aud_into_mech_missle( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_rocket" );
}

aud_plr_inside_mech()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "captured_int_mech", 1.0 );
}

aud_mech_missile_fire()
{
    soundscripts\_snd_playsound::snd_play_2d( "wpn_mech_missiles" );
}

aud_mech_jump()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_jump_dirt_lr" );
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_jump_mech_lr" );
    soundscripts\_snd::snd_message( "aud_mech1_bg_truck" );
}

aud_mech1_bg_truck()
{
    wait 7;
    soundscripts\_snd_playsound::snd_play_at( "scn_mech1_suv_arrival_2", ( 9658, -4469, 349.1 ) );
}

aud_mech_trucks_enter( var_0 )
{
    var_1 = self;

    if ( issubstr( self.script_noteworthy, "mb1" ) )
    {
        switch ( var_0 )
        {
            case 1:
                var_1 thread soundscripts\_snd_playsound::snd_play_linked( "scn_mech1_suv_arrival_1" );
                break;
            case 2:
                wait 0.1;
                break;
        }
    }

    if ( issubstr( self.script_noteworthy, "mb2" ) )
    {
        switch ( var_0 )
        {
            case 1:
                wait 1.3;
                var_1 thread soundscripts\_snd_playsound::snd_play_linked( "scn_mech2_suv_arrival_3" );
                break;
            case 2:
                wait 1;
                var_1 thread soundscripts\_snd_playsound::snd_play_linked( "scn_mech2_suv_arrival_4" );
                break;
        }
    }
}

vrap_explode()
{
    self waittill( "explode" );
    self playsound( "atlas_van_explo" );
    var_0 = spawnstruct();

    if ( level.currentgen )
        var_0.explo_shot_array_ = [ [ "exp_generic_explo_shot_04", 0 ], [ "exp_generic_explo_shot_07", 0 ], [ "exp_generic_explo_shot_10", 0 ], [ "exp_generic_explo_shot_12", 0 ], [ "exp_generic_explo_shot_13", 0 ], [ "exp_generic_explo_shot_20", 0 ], [ "exp_generic_explo_shot_22", 0 ] ];
    else
        var_0.explo_shot_array_ = [ [ "exp_generic_explo_shot_01", 0 ], [ "exp_generic_explo_shot_02", 0 ], [ "exp_generic_explo_shot_03", 0 ], [ "exp_generic_explo_shot_04", 0 ], [ "exp_generic_explo_shot_05", 0 ], [ "exp_generic_explo_shot_06", 0 ], [ "exp_generic_explo_shot_07", 0 ] ];

    var_0.pos = self.origin;
    var_0.explo_tail_alias_ = "exp_generic_random_accent";
    var_0.explo_debris_alias_ = "exp_fireball";
    var_0.explo_delay_chance_ = 100;
    var_0.shake_dist_threshold_ = 1500;
    var_0.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_0 );
}

aud_mech_crush_guy( var_0 )
{
    var_1 = "generic_death_enemy_" + randomintrange( 1, 8 );
    soundscripts\_snd_playsound::snd_play_at( "generic_npc_kick_body", var_0.origin );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_at( var_1, var_0.origin );
}

aud_mech_panic_walla_watcher()
{
    level endon( "stop_panic_watcher" );
    var_0 = 1;

    for (;;)
    {
        if ( !isdefined( level._mb.civilians["civ_mb1_foot"] ) || level._mb.civilians["civ_mb1_foot"].size == 0 )
        {
            wait 0.05;
            continue;
        }

        var_1 = 0;

        foreach ( var_3 in level._mb.civilians["civ_mb1_foot"] )
        {
            if ( isalive( var_3 ) && issubstr( var_3.classname, "hardhat" ) )
            {
                if ( distance( var_3.origin, level.player.origin ) < 550 && var_1 == 0 )
                {
                    var_4 = randomfloatrange( 0, 10 );

                    if ( var_4 > 8 || var_0 == 1 )
                    {
                        var_3 soundscripts\_snd_playsound::snd_play_linked( "emt_mech_civ_walla_ss" );
                        var_1 = 1;

                        if ( var_0 == 1 )
                            var_0 = 0;
                    }
                }
            }
        }

        wait 5;
    }
}

aud_stop_mech_panic_walla_watcher()
{
    level notify( "stop_panic_watcher" );
}

mech_wall_smash()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "mech_wall_smash" );
}

mech_wall_smash_3d( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "mech_wall_smash_3d", var_0 );
}

mech_warehouse_door_smash()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "mech_warehouse_smash" );
}

mech_scan()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "mech_scan" );
}

mech_weapon_offline()
{
    if ( level.aud.mech_error_timeout == 0 )
    {
        level.player soundscripts\_snd_playsound::snd_play_2d( "wpn_mech_offline" );
        level.aud.mech_error_timeout = 1;
        wait 1.5;
        level.aud.mech_error_timeout = 0;
    }
}

aud_warehouse_roof_machines_line()
{
    thread soundscripts\_audio::aud_play_line_emitter( "emt_warehouse_crane_01_motor_lp", "emt_warehouse_crane_01_motor_lp", ( 9774, -325, 387 ), ( 8279, -323, 387 ) );
}

aud_warehouse_roof_machines( var_0 )
{
    thread common_scripts\utility::play_loop_sound_on_entity( "emt_warehouse_crane_01_lp", ( 0, 0, -20 ) );
    wait(var_0);
    common_scripts\utility::stop_loop_sound_on_entity( "emt_warehouse_crane_01_lp" );
}

aud_warehouse_mech_lift()
{
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "scn_cap_mech_rise", 0, 0, undefined, undefined, undefined, undefined, ( 0, 0, 130 ) );
    level notify( "stop_panic_watcher" );
}

aud_warehouse_mech_lift_alarm()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.0 ] ];
    var_1 = [ [ 0.0, 0.1 ], [ 284.751, 0.3 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 845.82, 0.1099 ], [ 900.0, 0.04 ] ];
    thread alarm_enable( ( 8991, 603, 470 ), 0.2, "alarm_av_09_int_near", var_0, "alarm_av_09_int_far", var_1, "stop_mech_alarms" );
    wait 12;
    level notify( "stop_mech_alarms" );
}

aud_warehouse_mech_lift_vo()
{
    soundscripts\_snd_playsound::snd_play_delayed_at( "cap_ls3_warningloadingplatform", ( 9185, 965, 448 ), 1.0 );
}

scn_cap_mech_door_closes()
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_mech_door_closes", ( 8266, 2937, 202 ) );
}

scn_cap_mech_door_grab()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_cap_mech_door_grab" );
    soundscripts\_audio::aud_set_music_submix( 0.5, 2 );
    wait 2.7;
    soundscripts\_snd_playsound::snd_play_2d( "scn_cap_mech_door_grab02" );
}

aud_mech_obj_move( var_0 )
{
    if ( var_0 == "anim_exit_gatelift_1" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "scn_cap_mech_door_lift_start" );
        level.aud.living_gate = 1;
        soundscripts\_snd_playsound::snd_play_loop_2d( "scn_cap_mech_door_lift_lp", "kill_mech_lift_loop" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "scn_cap_mech_door_spark_lp", "kill_mech_lift_loop" );
    }
}

aud_mech_obj_move_wait()
{
    if ( level.aud.living_gate == 1 )
    {
        soundscripts\_snd_playsound::snd_play_2d( "scn_cap_mech_door_closed" );
        level notify( "kill_mech_lift_loop" );
        level.aud.living_gate = 0;
    }
}

aud_mech_obj_move_end()
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_cap_mech_door_opened" );
    level notify( "kill_mech_lift_loop" );
    soundscripts\_audio::aud_set_music_submix( 1, 5 );
}

snd_end_01( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_01_lr" );
    soundscripts\_audio_zone_manager::azm_start_zone( "mech_end_scene_1", 1 );
    wait 2.261;
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_02_lr" );
    wait 0.469;
    wait 4.675;
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_03_lr" );
    wait 10.182;
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_04_lr" );
    soundscripts\_audio_zone_manager::azm_start_zone( "mech_end_scene_2", 2 );
    wait 4.701;
    soundscripts\_snd::snd_music_message( "mus_captured_mech_end" );
    wait 1.627;
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_05a_lr" );
    wait 10.283;
    soundscripts\_snd_playsound::snd_play_2d( "scn_mech_end_05_lr" );
}

aud_captured_foley_override_handler()
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
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( var_2 )
                    {
                        if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                        {
                            soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                            soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_brkglass_l" );
                        }
                        else if ( soundexists( "limp_prone_plr_" + var_1 + "_l" ) )
                        {
                            soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                            soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_" + var_1 + "_l" );
                        }
                        else
                        {
                            soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                            soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_default_l" );
                        }
                    }
                    else if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_brkglass_r" );
                    }
                    else if ( soundexists( "limp_prone_plr_" + var_1 + "_r" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_" + var_1 + "_r" );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_prone_plr_default_r" );
                    }
                }

                break;
            case "crouchwalk":
                if ( level.aud.limp_footsteps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                    wait 0.1;

                    if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_brkglass_l" );
                    else if ( soundexists( "limp_walk_plr_" + var_1 + "_l" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_" + var_1 + "_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_default_l" );

                    wait 0.1;
                    soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                    wait 0.1;

                    if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_brkglass_r" );
                    else if ( soundexists( "limp_walk_plr_" + var_1 + "_l" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_" + var_1 + "_r" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_default_r" );
                }

                break;
            case "crouchrun":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_run_plr_" + var_1 + "_l" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_r" );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_r" );
                    }
                }

                break;
            case "walk":
                if ( level.aud.limp_footsteps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                    wait 0.1;

                    if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_brkglass_l" );
                    else if ( soundexists( "limp_" + var_0 + "_plr_" + var_1 + "_l" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_" + var_0 + "_plr_" + var_1 + "_l" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_default_l" );

                    wait 0.1;
                    soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_r" );
                    wait 0.1;

                    if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_brkglass_r" );
                    else if ( soundexists( "limp_" + var_0 + "_plr_" + var_1 + "_l" ) )
                        soundscripts\_snd_playsound::snd_play_2d( "limp_" + var_0 + "_plr_" + var_1 + "_r" );
                    else
                        soundscripts\_snd_playsound::snd_play_2d( "limp_walk_plr_default_r" );
                }
                else if ( level.aud.s2_walk_footsteps == 1 )
                {
                    if ( var_2 )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_s2_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "s2_walk_plr_default_l" );
                        wait 0.1;
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_s2_r" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "s2_walk_plr_default_r" );
                        wait 0.1;
                    }
                }

                break;
            case "run":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_run_plr_" + var_1 + "_l" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_r" );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_r" );
                    }
                }

                break;
            case "sprint":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_run_plr_" + var_1 + "_l" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_" + var_1 + "_r" );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_l" );
                        wait 0.1;
                        soundscripts\_snd_playsound::snd_play_2d( "gear_limp_plr_run_r" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_run_plr_default_r" );
                    }
                }

                break;
            case "jump":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( common_scripts\utility::flag( "aud_glass_footsteps" ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_jump_plr_glass" );
                    }
                    else if ( soundexists( "limp_jump_plr_" + var_1 ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_jump_plr_" + var_1 );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_jump_plr_default" );
                    }
                }

                break;
            case "lightland":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_land_plr_med_" + var_1 ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_" + var_1 );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_default" );
                    }
                }

                break;
            case "mediumland":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_land_plr_med_" + var_1 ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_" + var_1 );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_default" );
                    }
                }

                break;
            case "heavyland":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_land_plr_med_" + var_1 ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_" + var_1 );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_default" );
                    }
                }

                break;
            case "damageland":
                if ( level.aud.limp_footsteps == 1 )
                {
                    if ( soundexists( "limp_land_plr_med_" + var_1 ) )
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_" + var_1 );
                    }
                    else
                    {
                        soundscripts\_snd_playsound::snd_play_2d( "gear_rattle_plr_limp_l" );
                        soundscripts\_snd_playsound::snd_play_2d( "limp_land_plr_med_default" );
                    }
                }

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

aud_captured_setup_anims()
{
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_drive_gideon_truck_gate", ::aud_intro_truck_gate );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_drive_gideon_truck_passby_01", ::aud_intro_truck_passby_01 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_drive_gideon_truck_passby_02", ::aud_intro_truck_passby_02 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_drive_gideon_truck_stop", ::aud_intro_truck_stop );
    maps\_anim::addnotetrack_customfunction( "guard_3", "aud_s1_elevator_guard_foley", ::aud_s1_elevator_guard_foley );
    maps\_anim::addnotetrack_customfunction( "general_1", "aud_s1_elevator_boss_foley", ::aud_s1_elevator_boss_foley );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_s1_elevator_cormack_foley", ::aud_s1_elevator_cormack_foley );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_s1_elevator_kick_1", ::aud_s1_elevator_kick_1 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_s1_elevator_kick_2", ::aud_s1_elevator_kick_2 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_s2walk_start_gideon_foley", ::aud_s2walk_start_gideon_foley );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_s2walk_start_cormack_foley", ::aud_s2walk_start_cormack_foley );
    maps\_anim::addnotetrack_customfunction( "ally_1", "aud_s2walk_start_ilona_foley", ::aud_s2walk_start_ilona_foley );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_s2walk_start_gideon_bodyfall", ::aud_s2walk_start_gideon_bodyfall );
    maps\_anim::addnotetrack_customfunction( "guard_1", "aud_s2walk_start_guard_1_foley", ::aud_s2walk_start_guard_1_foley );
    maps\_anim::addnotetrack_customfunction( "guard_1", "aud_s2walk_start_guard_1_grabpush", ::aud_s2walk_start_guard_1_grabpush );
    maps\_anim::addnotetrack_customfunction( "guard_2", "aud_s2walk_start_guard_2_foley", ::aud_s2walk_start_guard_2_foley );
    maps\_anim::addnotetrack_customfunction( "guard_2", "aud_s2walk_start_guard_2_grabpush", ::aud_s2walk_start_guard_2_grabpush );
    maps\_anim::addnotetrack_customfunction( "guard_2", "aud_s2walk_start_guard_2_grab", ::aud_s2walk_start_guard_2_grab );
    maps\_anim::addnotetrack_customfunction( "guard_2", "aud_s2walk_start_guard_2_push", ::aud_s2walk_start_guard_2_push );
    maps\_anim::addnotetrack_customfunction( "guard_3", "aud_s2walk_start_guard_3_foley", ::aud_s2walk_start_guard_3_foley );
    maps\_anim::addnotetrack_customfunction( "guard_3", "aud_s2walk_start_guard_3_walkup_foley", ::aud_s2walk_start_guard_3_walkup_foley );
    maps\_anim::addnotetrack_customfunction( "player_rig_noexo", "aud_s2walk_start_player_foley", ::aud_s2walk_start_player_foley );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_s2walk_cormack_punched", ::aud_s2walk_cormack_punched );
    maps\_anim::addnotetrack_customfunction( "ally_1", "aud_s2walk_ilona_push", ::aud_s2walk_ilona_push );
    maps\_anim::addnotetrack_customfunction( "exterior_ambient_prisoner", "ambient_cell_prisoner_audio", ::aud_s2walk_cell_prisoners );
    maps\_anim::addnotetrack_customfunction( "guard_end", "aud_guard_3_foley_01", ::aud_s2walk_guard_3_foley_01 );
    maps\_anim::addnotetrack_customfunction( "guard_end", "aud_guard_3_foley_02", ::aud_s2walk_guard_3_foley_02 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_01", ::aud_cap_s2_trolley_sfx_01 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_02", ::aud_cap_s2_trolley_sfx_02 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_03", ::aud_cap_s2_trolley_sfx_03 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_03_crk", ::aud_cap_s2_trolley_sfx_03_crk );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_04", ::aud_cap_s2_trolley_sfx_04 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_05", ::aud_cap_s2_trolley_sfx_05 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_06", ::aud_cap_s2_trolley_sfx_06 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_07", ::aud_cap_s2_trolley_sfx_07 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_08", ::aud_cap_s2_trolley_sfx_08 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_09", ::aud_cap_s2_trolley_sfx_09 );
    maps\_anim::addnotetrack_customfunction( "ally_2", "aud_cap_s2_trolley_sfx_10", ::aud_cap_s2_trolley_sfx_10 );
    maps\_anim::addnotetrack_customfunction( "irons", "interrogation_music_start", ::aud_interrogation_music_pt1 );
    maps\_anim::addnotetrack_customfunction( "irons", "interrogation_music_pt2", ::aud_interrogation_music_pt2 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_a", ::aud_rescue_sfx_a );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_b", ::aud_rescue_sfx_b );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_c", ::aud_rescue_sfx_c );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_d", ::aud_rescue_sfx_d );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_e", ::aud_rescue_sfx_e );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_f", ::aud_rescue_sfx_f );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_s1_rescue_sfx_g", ::aud_rescue_sfx_g );
    maps\_anim::addnotetrack_customfunction( "ally_0", "trolley_music_start", ::aud_trolley_music );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_rescue_01", ::aud_ilana_carmack_rescue_01 );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_escape_hallway", ::aud_ilana_carmack_escape_hallway );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_escape_hallway_end", ::aud_ilana_carmack_escape_hallway_end );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_escape_takedown", ::aud_ilana_carmack_escape_takedown );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_escape_controlroom", ::aud_ilana_carmack_escape_controlroom );
    maps\_anim::addnotetrack_customfunction( "ally_1", "ilana_carmack_escape_controlroom_attack", ::aud_ilana_carmack_escape_controlroom_attack );
    maps\_anim::addnotetrack_customfunction( "doctor", "aud_gun_throw_logic", ::aud_gun_throw_logic );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_ascend_start", ::aud_gideon_test_chamber_ascend_start );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_stair_door", ::aud_gideon_test_chamber_stair_door );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_climb_stairs_1", ::aud_gideon_test_chamber_climb_stairs_1 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_climb_stairs_2", ::aud_gideon_test_chamber_climb_stairs_2 );
    maps\_anim::addnotetrack_customfunction( "scientist_4", "lab_tech_desk_bump", ::aud_lab_tech_desk_bump );
    maps\_anim::addnotetrack_customfunction( "scientist_1", "lab_tech_chair_startle_1", ::aud_lab_tech_chair_startle_1 );
    maps\_anim::addnotetrack_customfunction( "scientist_2", "lab_tech_chair_startle_2", ::aud_lab_tech_chair_startle_2 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_descend_stairs", ::aud_gideon_test_chamber_descend_stairs );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_descend_stairs_2", ::aud_gideon_test_chamber_descend_stairs_2 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_security", ::aud_gideon_test_chamber_security );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_autopsy_halls_start", ::aud_gideon_autopsy_halls_start );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_cap_incinerator_crawl_loop_gideon_230", maps\captured_vo::cap_incinerator_crawl_loop_01 );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_gideon_test_chamber_bodybag_1", ::aud_gideon_test_chamber_bodybag_1, "tc_enter_test" );
    maps\_anim::addnotetrack_customfunction( "ally_0", "aud_gideon_test_chamber_bodybag_2", ::aud_gideon_test_chamber_bodybag_2, "tc_enter_test" );
    maps\_anim::addnotetrack_customfunction( "op_alarm", "hazmat_guy_foley", ::aud_hazmat_guy_foley );
    maps\_anim::addnotetrack_customfunction( "op_alarm", "hazmat_guy_pushes_alarm", ::aud_hazmat_guy_pushes_alarm );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_test_chamber_door_kick", ::aud_gideon_test_chamber_door_kick );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_heli_runout_start", ::aud_gideon_heli_runout_start );
    maps\_anim::addnotetrack_customfunction( "ally_0", "gideon_heli_runout_door_kick", ::aud_gideon_heli_runout_kick );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_hatch_plr", ::aud_hatch_plr );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_01", ::aud_cap_heli_sfx_01 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_02", ::aud_cap_heli_sfx_02 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_03", ::aud_cap_heli_sfx_03 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_04", ::aud_cap_heli_sfx_04 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_05", ::aud_cap_heli_sfx_05 );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_cap_heli_sfx_06", ::aud_cap_heli_sfx_06 );
}

aud_s1_elevator_guard_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s1_elev_guard_foley" );
}

aud_s1_elevator_boss_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s1_elev_boss_foley" );
}

aud_s1_elevator_cormack_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s1_elev_cormack_foley", "stop_cormack_foley" );
}

aud_s1_elevator_kick_1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_s1_elev_kick_01", ( 5423.8, -5280.5, 36.2 ) );
}

aud_s1_elevator_kick_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_s1_elev_kick_02", ( 5423.8, -5280.5, 36.2 ) );
}

aud_s2walk_start_gideon_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_gideon_foley" );
}

aud_s2walk_start_cormack_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_cormack_foley" );
}

aud_s2walk_start_ilona_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_ilona_foley" );
}

aud_s2walk_start_gideon_bodyfall( var_0 )
{
    level notify( "s2_elevator_stop_sfx" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s1_elev_gid_out" );
}

aud_s2walk_start_guard_1_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_1_foley" );
}

aud_s2walk_start_guard_1_grabpush( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_1_grab_push" );
}

aud_s2walk_start_guard_2_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_2_foley" );
}

aud_s2walk_start_guard_2_grabpush( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_2_grab_push" );
}

aud_s2walk_start_guard_2_grab( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_2_grab" );
}

aud_s2walk_start_guard_2_push( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_2_push" );
}

aud_s2walk_start_guard_3_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_3_foley" );
}

aud_s2walk_start_guard_3_walkup_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2walk_start_guard_3_walkup_foley" );
}

aud_s2walk_start_player_foley( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "scn_s1_elev_plr_out" );
}

aud_s2walk_guard_3_foley_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_guard_cloth_01" );
}

aud_s2walk_guard_3_foley_02( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_guard_cloth_02" );
}

aud_s2walk_cormack_punched( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_cormack_punched" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_cormack_punch_exertion" );
    wait 1.05;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_cormack_punch_exertion_2" );
}

aud_s2walk_ilona_push( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_ilona_push" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_ilona_stumble" );
    wait 2.16;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_cormack_push" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_s2_walk_cormack_punched" );
}

aud_trolley_music( var_0 )
{
    soundscripts\_snd::snd_music_message( "mus_captured_trolley" );
}

aud_interrogation_music_pt1( var_0 )
{
    soundscripts\_snd::snd_music_message( "mus_captured_interrogation" );
}

aud_interrogation_music_pt2( var_0 )
{
    common_scripts\utility::flag_set( "flag_start_interrogation_music_pt2" );
}

aud_interrogation_scene()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "interrogation", 0 );
    wait 0.02;
    level.player soundscripts\_snd_playsound::snd_play_linked( "scn_cap_interrogation_bg_lr" );
}

aud_cap_interrogation_transition_vo()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "cap_ls3_cleanupcrewtomedical" );
}

aud_ilana_carmack_rescue_01( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_rescue_01" );
}

aud_ilana_carmack_escape_hallway( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_escape_hallway" );
}

aud_ilana_carmack_escape_hallway_end( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_escape_hallway_end" );
}

aud_ilana_carmack_escape_takedown( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_escape_takedown" );
}

aud_ilana_carmack_escape_controlroom( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_escape_controlroom" );
}

aud_ilana_carmack_escape_controlroom_attack( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_ila_escape_controlroom_attack" );
}

aud_gideon_test_chamber_ascend_start( var_0 )
{
    soundscripts\_snd::snd_message( "aud_gideon_test_chamber_stair_door", var_0 );
    soundscripts\_snd::snd_message( "aud_gideon_test_chamber_climb_stairs_1", var_0 );
}

aud_gideon_test_chamber_stair_door( var_0 )
{
    wait 2.87;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_gdn_test_stair_door", ( 3895, -10650, -1708 ) );
    wait 1.48;
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_gdn_test_stair_door_hit", ( 3824, -10677, -1700 ) );
}

aud_gideon_test_chamber_climb_stairs_1( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_gdn_test_stair_climb_1" );
}

aud_gideon_test_chamber_climb_stairs_2( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_gdn_test_stair_climb_2" );
}

aud_lab_tech_desk_bump( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_lab_tech_desk_bump", ( 3886.5, -10844.5, -1515.9 ) );
}

aud_lab_tech_chair_startle_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_lab_tech_chair_startle_01" );
}

aud_lab_tech_chair_startle_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_lab_tech_chair_startle_02" );
}

aud_gideon_test_chamber_descend_stairs( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_gdn_test_stair_descend_gear_1" );
}

aud_gideon_test_chamber_descend_stairs_2( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_gdn_test_stair_descend_gear_2" );
}

aud_gideon_test_chamber_security( var_0 )
{
    thread aud_ally_card_swipe( ( 4410, -11886.8, -1611.9 ) );
    wait 0.2;
    thread aud_ally_card_error( ( 4410, -11886.8, -1611.9 ) );
}

aud_ally_card_accept( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_accept", var_0 );
}

aud_ally_card_error( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_zap_door_fail_beep", var_0 );
}

aud_ally_card_swipe( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_keycard_swipe", var_0 );
}

aud_gideon_autopsy_halls_start( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_test_chamber_gideon_gear" );
}

aud_gideon_test_chamber_bodybag_1( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_test_chamber_gideon_bodybag1", ( 4494, -11736, -1612 ) );
}

aud_gideon_test_chamber_bodybag_2( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_test_chamber_gideon_bodybag2", ( 4487, -11672, -1612 ) );
}

aud_gideon_test_chamber_door_kick( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_test_chamber_door_kick", ( 4745, -11541, -1612 ) );
    soundscripts\_audio_mix_manager::mm_clear_submix( "captured_alarm_down", 1 );
}

aud_alarm_submix()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "captured_alarm_down" );
}

aud_hazmat_guy_foley( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_guy_hitting_alarm_foley" );
}

aud_hazmat_guy_pushes_alarm( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "scn_cap_guy_hitting_alarm" );
}

aud_gideon_heli_runout_start( var_0 )
{
    level.ally soundscripts\_snd_playsound::snd_play_linked( "scn_cap_manticore_gideon_gear" );
}

aud_gideon_heli_runout_kick( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "scn_cap_manticore_doorkick", ( 11778, -13499, -1820 ) );
}

start_courtyard_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.0 ] ];
    var_1 = [ [ 0.0, 0.1 ], [ 284.751, 0.3 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 845.82, 0.1099 ], [ 900.0, 0.04 ] ];
    thread alarm_enable( ( 3898, -10628, -1635 ), 0.6, "alarm_av_04_int_near", var_0, "alarm_av_04_int_far", var_1, "stop_courtyard_alarms" );
    thread alarm_enable( ( 4029, -10662, -1450 ), 0.6, "alarm_av_01_int_near", var_0, "alarm_av_01_int_far", var_1, "stop_courtyard_alarms" );
    thread aud_pa_announc_01();
}

start_post_courtyard_interior_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 377.102, 0.5916 ], [ 446.366, 0.4293 ], [ 513.064, 0.2408 ], [ 579.763, 0.1047 ], [ 700.333, 0.01 ], [ 1080.0, 0.0 ] ];
    var_1 = [ [ 0.0, 0.25 ], [ 284.751, 0.5 ], [ 495.107, 0.4974 ], [ 625.938, 0.4293 ], [ 728.551, 0.2984 ], [ 823.468, 0.1937 ], [ 915.82, 0.1099 ], [ 1080.0, 0.1 ] ];
    thread alarm_enable( ( 5212, -12366, -1513 ), 0.6, "alarm_av_04_int_near", var_0, "alarm_av_04_int_far", var_1, "stop_stop_post_courtyard_alarms" );
    thread alarm_enable( ( 4779, -13145, -1516 ), 0.6, "alarm_av_01_int_near", var_0, "alarm_av_01_int_far", var_1, "stop_stop_post_courtyard_alarms" );
    thread aud_pa_announc_02();
}

start_post_courtyard_ext_alarms()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.9796 ], [ 305.273, 0.933 ], [ 377.102, 0.8916 ], [ 446.366, 0.7293 ], [ 600.064, 0.6408 ], [ 800.763, 0.6 ], [ 1000.33, 0.5 ], [ 1500.0, 0.0 ] ];
    var_1 = [ [ 0.0, 0.25 ], [ 284.751, 0.5 ], [ 495.107, 0.3974 ], [ 625.938, 0.3293 ], [ 728.551, 0.2 ], [ 823.468, 0.15 ], [ 1050.82, 0.1 ], [ 1200.0, 0.0 ] ];
    wait 2;
    thread alarm_enable( ( 9951, -14004, -1792 ), 0.6, "alarm_06_int_near", var_0, "alarm_06_int_far", var_1, "stop_post_courtyard_ext_alarms_2" );
    thread start_post_courtyard_ext_alarms_2();
}

start_post_courtyard_ext_alarms_2()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 325, 0.5916 ], [ 350, 0.4293 ], [ 400, 0.2408 ], [ 600, 0.1047 ], [ 700, 0.05 ], [ 800, 0.0 ] ];
    var_1 = [ [ 0.0, 0.2 ], [ 284.751, 0.1 ], [ 495.107, 0.0 ], [ 625.938, 0.0 ], [ 680, 0.0 ], [ 725, 0.0 ], [ 750, 0.0 ], [ 800, 0.0 ] ];
}

start_autopsy_alarm()
{
    var_0 = [ [ 0.0, 1.0 ], [ 79.5249, 1.0 ], [ 194.964, 0.8796 ], [ 305.273, 0.733 ], [ 325, 0.5916 ], [ 350, 0.4293 ], [ 400, 0.2408 ], [ 600, 0.1047 ], [ 700, 0.05 ], [ 800, 0.0 ] ];
    var_1 = [ [ 0.0, 0.3 ], [ 284.751, 0.3 ], [ 495.107, 0.3 ], [ 625.938, 0.3 ], [ 680, 0.2 ], [ 725, 0.2 ], [ 750, 0.1 ], [ 800, 0.0 ] ];
    wait 2.5;
    thread aud_pa_announc_03();
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

aud_pa_announc_01()
{
    level endon( "stop_courtyard_alarms" );
    var_0 = ( 4708, -10827, -1615 );
    var_1 = ( 4138, -10796, -1634 );
    wait 4;

    for (;;)
    {
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_1 );
        wait(randomfloatrange( 10, 14 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_1 );
        wait(randomfloatrange( 10, 14 ));
    }
}

aud_pa_announc_02()
{
    level endon( "stop_stop_post_courtyard_alarms" );
    var_0 = ( 4963, -11974, -1505 );
    var_1 = ( 4851, -13274, -1508 );

    for (;;)
    {
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersareheading", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersareheading", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_1 );
        wait(randomfloatrange( 8, 12 ));
    }
}

aud_pa_announc_03()
{
    level endon( "stop_autopsy_alarm" );
    var_0 = ( 5884, -14710, -1463 );
    wait 1.5;

    for (;;)
    {
        wait 1.5;
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_0 );
        wait(randomfloatrange( 3, 4 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersareheading", var_0 );
        wait(randomfloatrange( 3, 4 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_0 );
        wait(randomfloatrange( 3, 4 ));
    }
}

aud_pa_announc_04()
{
    level endon( "stop_post_courtyard_ext_alarms_2" );
    var_0 = ( 10740, -14474, -1484 );
    var_1 = ( 11294, -12971, -1629 );

    for (;;)
    {
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_alertthisisnota", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonersarearmed", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_prisonershaveescaped", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_irepeatprisoners2", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shootonsightthey", var_1 );
        wait(randomfloatrange( 8, 12 ));
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_0 );
        soundscripts\_snd_playsound::snd_play_at( "cap_ls3_shoottokillprisoners", var_1 );
        wait(randomfloatrange( 8, 12 ));
    }
}

aud_door( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        iprintlnbold( "Door" );
        return;
    }

    switch ( var_0 )
    {
        case "rescue":
            wait 0.1;
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_rescue_door", ( 5225, -9935, -1700 ) );
            break;
        case "control_rm":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_control", ( 5013, -10703, -1700 ) );
            else if ( var_1 == "close" )
            {

            }

            break;
        case "control_rm_exit":
            if ( var_1 == "open" )
            {
                wait 0.2;
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_control_fast", ( 4444, -10696, -1700 ) );
            }
            else if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_01_close", ( 4444, -10696, -1700 ) );

            break;
        case "test_chamber":
            soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 3984, -11175, -1520 ) );
            break;
        case "test_chamber_side":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 3884, -11067, -1520 ) );
            else if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_close", ( 3884, -11067, -1520 ) );

            break;
        case "test_chamber_exit":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_01_open", ( 4149, -11837, -1520 ) );
            else if ( var_1 == "close" )
            {

            }

            break;
        case "test_chamber_stairwell":
            if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_autopsy_door_l", ( 3863, -10632, -1708 ) );

            break;
        case "morgue_doors":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 4964, -13134, -1572 ) );
            else if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 4964, -13134, -1572 ) );

            break;
        case "autopsy_pre_doors":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 5509, -14536, -1572 ) );
            else if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_close", ( 5509, -14536, -1572 ) );

            break;
        case "yard_doors":
            if ( var_1 == "open" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_open", ( 11432, -13607, -1820 ) );
            else if ( var_1 == "close" )
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_02_close", ( 11432, -13607, -1820 ) );

            break;
        case "post_incin":
            if ( var_1 == "open" )
            {
                wait 0.13;
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_post_incin_open", ( 9239, -14294, -1820 ) );
            }
            else if ( var_1 == "close" )
            {
                wait 0.2;
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_post_incin_close", ( 9239, -14294, -1820 ) );
            }

            break;
        case "battle_to_heli":
            if ( var_1 == "open" )
            {
                wait 0.13;
                soundscripts\_snd_playsound::snd_play_at( "scn_cap_door_battle_to_heli", ( 10056, -14043, -1959 ) );
            }

            break;
        default:
            break;
    }
}
