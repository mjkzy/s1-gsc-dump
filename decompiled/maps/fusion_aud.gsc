// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_audio_flags();
    init_globals();
    launch_threads();
    launch_loops();
    create_level_envelop_arrays();
    register_trigger_callbacks();
    add_note_track_data();
    precache_presets();
    thread maps\fusion_vo::init_pcap_vo();
    register_snd_messages();
}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "start_intro_fly_in", ::start_intro_fly_in );
    soundscripts\_snd::snd_register_message( "start_intro_fly_in_part2", ::start_intro_fly_in_part2 );
    soundscripts\_snd::snd_register_message( "start_courtyard", ::start_courtyard );
    soundscripts\_snd::snd_register_message( "start_security_room", ::start_security_room );
    soundscripts\_snd::snd_register_message( "start_lab", ::start_lab );
    soundscripts\_snd::snd_register_message( "start_reactor", ::start_reactor );
    soundscripts\_snd::snd_register_message( "start_reactor_exit", ::start_reactor_exit );
    soundscripts\_snd::snd_register_message( "start_turbine_room", ::start_turbine_room );
    soundscripts\_snd::snd_register_message( "start_control_room_entrance", ::start_control_room_entrance );
    soundscripts\_snd::snd_register_message( "start_control_room", ::start_control_room );
    soundscripts\_snd::snd_register_message( "start_control_room_exit", ::start_control_room_exit );
    soundscripts\_snd::snd_register_message( "start_cooling_tower", ::start_cooling_tower );
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::snd_zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::snd_music_handler );
    soundscripts\_snd::snd_register_message( "player_warbird_spawn", ::player_warbird_spawn );
    soundscripts\_snd::snd_register_message( "start_hologram_audio", ::start_hologram_audio );
    soundscripts\_snd::snd_register_message( "start_burke_foley", ::start_burke_foley );
    soundscripts\_snd::snd_register_message( "start_intro_npc_foley", ::start_intro_npc_foley );
    soundscripts\_snd::snd_register_message( "decloak_intro_helicopter", ::decloak_intro_helicopter );
    soundscripts\_snd::snd_register_message( "intro_flight_missiles_fire", ::intro_flight_missiles_fire );
    soundscripts\_snd::snd_register_message( "missile_hit_warbird_b", ::missile_hit_warbird_b );
    soundscripts\_snd::snd_register_message( "warbird_b_crash_tower", ::warbird_b_crash_tower );
    soundscripts\_snd::snd_register_message( "rooftop_strafe_start", ::rooftop_strafe_start );
    soundscripts\_snd::snd_register_message( "fastzip_turret_switch_to", ::fastzip_turret_switch_to );
    soundscripts\_snd::snd_register_message( "fastzip_turret_switch_complete", ::fastzip_turret_switch_complete );
    soundscripts\_snd::snd_register_message( "fastzip_turret_fire", ::fastzip_turret_fire );
    soundscripts\_snd::snd_register_message( "fastzip_turret_putaway", ::fastzip_turret_putaway );
    soundscripts\_snd::snd_register_message( "fastzip_hit_the_ground", ::fastzip_hit_the_ground );
    soundscripts\_snd::snd_register_message( "fastzip_rappel", ::fastzip_rappel );
    soundscripts\_snd::snd_register_message( "snd_start_ambient_jet", ::start_ambient_jet );
    soundscripts\_snd::snd_register_message( "courtyard_ambient_bullet_impact", ::courtyard_ambient_bullet_impact );
    soundscripts\_snd::snd_register_message( "warbird_mobile_turret_dropoff", ::warbird_mobile_turret_dropoff );
    soundscripts\_snd::snd_register_message( "walker_mobile_turret_dropoff", ::walker_mobile_turret_dropoff );
    soundscripts\_snd::snd_register_message( "player_warbird_flyout", ::player_warbird_flyout );
    soundscripts\_snd::snd_register_message( "cvrdrn_paired_anim_start", ::cvrdrn_paired_anim_start );
    soundscripts\_snd::snd_register_message( "cvrdrn_paired_anim_explo", ::cvrdrn_paired_anim_explo );
    soundscripts\_snd::snd_register_message( "building_explode", ::building_explode );
    soundscripts\_snd::snd_register_message( "spawn_walker_mobile_turret_deploy", ::spawn_walker_mobile_turret_deploy );
    soundscripts\_snd::snd_register_message( "spawn_ally_walker_02", ::spawn_ally_walker_02 );
    soundscripts\_snd::snd_register_message( "street_wall_1_explode", ::street_wall_1_explode );
    soundscripts\_snd::snd_register_message( "player_enter_walker", ::player_enter_walker );
    soundscripts\_snd::snd_register_message( "player_exit_walker", ::player_exit_walker );
    soundscripts\_snd::snd_register_message( "player_enter_walker_anim", ::player_enter_walker_anim );
    soundscripts\_snd::snd_register_message( "player_exit_walker_anim", ::player_exit_walker_anim );
    soundscripts\_snd::snd_register_message( "player_mobile_turret_warning", ::player_mobile_turret_warning );
    soundscripts\_snd::snd_register_message( "player_mobile_turret_explo", ::player_mobile_turret_explo );
    soundscripts\_snd::snd_register_message( "x4_walker_hud_target_aquired", ::x4_walker_hud_target_aquired );
    soundscripts\_snd::snd_register_message( "x4_walker_hud_missile_launched", ::x4_walker_hud_missile_launched );
    soundscripts\_snd::snd_register_message( "x4_walker_fire_missile", ::x4_walker_fire_missile );
    soundscripts\_snd::snd_register_message( "mobile_turret_missile", ::mobile_turret_missile );
    soundscripts\_snd::snd_register_message( "courtyard_mi17_spawn_01", ::courtyard_mi17_spawn_01 );
    soundscripts\_snd::snd_register_message( "courtyard_mi17_spawn_02", ::courtyard_mi17_spawn_02 );
    soundscripts\_snd::snd_register_message( "titan_init", ::titan_init );
    soundscripts\_snd::snd_register_message( "titan_enter", ::titan_enter );
    soundscripts\_snd::snd_register_message( "titan_missile", ::titan_missile );
    soundscripts\_snd::snd_register_message( "trophy_system_explosion", ::trophy_system_explosion );
    soundscripts\_snd::snd_register_message( "titan_take_damage_from_smaw", ::titan_take_damage_from_smaw );
    soundscripts\_snd::snd_register_message( "titan_death", ::titan_death );
    soundscripts\_snd::snd_register_message( "itiot_fade_out", ::itiot_fade_out );
    soundscripts\_snd::snd_register_message( "itiot_fade_in", ::itiot_fade_in );
    soundscripts\_snd::snd_register_message( "start_elevator_zone_audio", ::start_elevator_zone_audio );
    soundscripts\_snd::snd_register_message( "start_dead_guy_foley", ::start_dead_guy_foley );
    soundscripts\_snd::snd_register_message( "Sec_Room_Move_To_Elevator", ::sec_room_move_to_elevator );
    soundscripts\_snd::snd_register_message( "Sec_Room_Attach_To_Elevator", ::sec_room_attach_to_elevator );
    soundscripts\_snd::snd_register_message( "Sec_Room_Elevator_Open", ::sec_room_elevator_open );
    soundscripts\_snd::snd_register_message( "start_burke_elevator_slide", ::start_burke_elevator_slide );
    soundscripts\_snd::snd_register_message( "start_player_elevator_jump", ::start_player_elevator_jump );
    soundscripts\_snd::snd_register_message( "start_player_elevator_slide", ::start_player_elevator_slide );
    soundscripts\_snd::snd_register_message( "start_airlock_anim_notetracks", ::start_airlock_anim_notetracks );
    soundscripts\_snd::snd_register_message( "start_reactor_airlock_open", ::start_reactor_airlock_open );
    soundscripts\_snd::snd_register_message( "start_reactor_burke_attack", ::start_reactor_burke_attack );
    soundscripts\_snd::snd_register_message( "crane_mach_mvmnt_start", ::crane_mach_mvmnt_start );
    soundscripts\_snd::snd_register_message( "crane_mach_mvmnt_stop", ::crane_mach_mvmnt_stop );
    soundscripts\_snd::snd_register_message( "crane_claw_mvmnt_start", ::crane_claw_mvmnt_start );
    soundscripts\_snd::snd_register_message( "crane_claw_mvmnt_stop", ::crane_claw_mvmnt_stop );
    soundscripts\_snd::snd_register_message( "crane_claw_drop_start", ::crane_claw_drop_start );
    soundscripts\_snd::snd_register_message( "crane_claw_drop_stop", ::crane_claw_drop_stop );
    soundscripts\_snd::snd_register_message( "crane_claw_rise_start", ::crane_claw_rise_start );
    soundscripts\_snd::snd_register_message( "crane_claw_rise_stop", ::crane_claw_rise_stop );
    soundscripts\_snd::snd_register_message( "crane_claw_crate_grab", ::crane_claw_crate_grab );
    soundscripts\_snd::snd_register_message( "crane_claw_crate_release", ::crane_claw_crate_release );
    soundscripts\_snd::snd_register_message( "reactor_bot_drive_shelf_start", ::reactor_bot_drive_shelf_start );
    soundscripts\_snd::snd_register_message( "reactor_bot_drive_shelf_stop", ::reactor_bot_drive_shelf_stop );
    soundscripts\_snd::snd_register_message( "reactor_bot_drive_self_start", ::reactor_bot_drive_shelf_stop );
    soundscripts\_snd::snd_register_message( "reactor_bot_drive_self_stop", ::reactor_bot_drive_shelf_stop );
    soundscripts\_snd::snd_register_message( "reactor_bot_turn_shelf", ::reactor_bot_turn_shelf );
    soundscripts\_snd::snd_register_message( "reactor_bot_turn_self", ::reactor_bot_turn_shelf );
    soundscripts\_snd::snd_register_message( "reactor_bot_shelf_pickup", ::reactor_bot_shelf_pickup );
    soundscripts\_snd::snd_register_message( "reactor_bot_shelf_drop", ::reactor_bot_shelf_drop );
    soundscripts\_snd::snd_register_message( "reactor_bot_elevator_start_lp", ::reactor_bot_elevator_start_lp );
    soundscripts\_snd::snd_register_message( "reactor_bot_elevator_stop_lp", ::reactor_bot_elevator_stop_lp );
    soundscripts\_snd::snd_register_message( "reactor_bot_initial_elevator_start", ::reactor_bot_initial_elevator_start );
    soundscripts\_snd::snd_register_message( "reactor_bot_initial_elevator_stop", ::reactor_bot_initial_elevator_stop );
    soundscripts\_snd::snd_register_message( "reactor_bot_final_elevator_start", ::reactor_bot_final_elevator_start );
    soundscripts\_snd::snd_register_message( "reactor_bot_final_elevator_stop", ::reactor_bot_final_elevator_stop );
    soundscripts\_snd::snd_register_message( "reactor_bot_elevator_open", ::reactor_bot_elevator_open );
    soundscripts\_snd::snd_register_message( "start_reactor_zone_audio", ::start_reactor_zone_audio );
    soundscripts\_snd::snd_register_message( "turbine_room_elevator_button", ::turbine_room_elevator_button );
    soundscripts\_snd::snd_register_message( "disable_turbine_elevator_trigger", ::disable_turbine_elevator_trigger );
    soundscripts\_snd::snd_register_message( "start_turbine_elevator", ::start_turbine_elevator );
    soundscripts\_snd::snd_register_message( "stop_turbine_elevator", ::stop_turbine_elevator );
    soundscripts\_snd::snd_register_message( "start_turbine_loop", ::start_turbine_loop );
    soundscripts\_snd::snd_register_message( "rec_player_drone_start", ::rec_player_drone_start );
    soundscripts\_snd::snd_register_message( "rec_player_drone_end", ::rec_player_drone_end );
    soundscripts\_snd::snd_register_message( "snd_player_drone_deploy", ::snd_player_drone_deploy );
    soundscripts\_snd::snd_register_message( "snd_player_drone_wrist_panel", ::snd_player_drone_wrist_panel );
    soundscripts\_snd::snd_register_message( "snd_player_drone_enter_drone_pov", ::snd_player_drone_enter_drone_pov );
    soundscripts\_snd::snd_register_message( "turbine_pre_explo", ::turbine_pre_explo );
    soundscripts\_snd::snd_register_message( "turbine_explo_audio", ::turbine_explo );
    soundscripts\_snd::snd_register_message( "start_pa_emergency_turbine", ::start_pa_emergency_turbine );
    soundscripts\_snd::snd_register_message( "start_turbine_door_breach", ::start_turbine_door_breach );
    soundscripts\_snd::snd_register_message( "start_turbine_door_impt", ::start_turbine_door_impt );
    soundscripts\_snd::snd_register_message( "start_control_room_explo", ::start_control_room_explo );
    soundscripts\_snd::snd_register_message( "start_pre_loading_bay", ::start_pre_loading_bay );
    soundscripts\_snd::snd_register_message( "snd_start_fire_steam", ::start_fire_steam_loops );
    soundscripts\_snd::snd_register_message( "hangar_explo_and_debris_01", ::hangar_explo_and_debris_01 );
    soundscripts\_snd::snd_register_message( "hangar_explo_and_debris_02", ::hangar_explo_and_debris_02 );
    soundscripts\_snd::snd_register_message( "hangar_transport_01_away", ::hangar_transport_01_away );
    soundscripts\_snd::snd_register_message( "hangar_transport_flying_01_away", ::hangar_transport_flying_01_away );
    soundscripts\_snd::snd_register_message( "hangar_transport_flying_02_away", ::hangar_transport_flying_02_away );
    soundscripts\_snd::snd_register_message( "pressure_explosion", ::pressure_explosion );
    soundscripts\_snd::snd_register_message( "fus_truck_flip_01", ::fus_truck_flip_01 );
    soundscripts\_snd::snd_register_message( "fus_truck_flip_02", ::fus_truck_flip_02 );
    soundscripts\_snd::snd_register_message( "extraction_chopper_spawn", ::extraction_chopper_spawn );
    soundscripts\_snd::snd_register_message( "extraction_chopper_move", ::extraction_chopper_move );
    soundscripts\_snd::snd_register_message( "start_gaz_02_retreat", ::start_gaz_02_retreat );
    soundscripts\_snd::snd_register_message( "start_gaz_03_retreat", ::start_gaz_03_retreat );
    soundscripts\_snd::snd_register_message( "tower_collapse_prep", ::tower_collapse_prep );
    soundscripts\_snd::snd_register_message( "tower_collapse_start", ::tower_collapse_start );
    soundscripts\_snd::snd_register_message( "tower_collapse_player_stumble", ::tower_collapse_player_stumble );
    soundscripts\_snd::snd_register_message( "tower_collapse_player_knockback", ::tower_collapse_player_knockback );
    soundscripts\_snd::snd_register_message( "silo_collapse_plr_stunned", ::silo_collapse_plr_stunned );
    soundscripts\_snd::snd_register_message( "fus_outro_burke_foley", ::fus_outro_burke_foley );
    soundscripts\_snd::snd_register_message( "fusion_silo_collapse_warbird", ::fusion_silo_collapse_warbird );
    soundscripts\_snd::snd_register_message( "ending_fade_out", ::ending_fade_out );
    soundscripts\_snd::snd_register_message( "fusion_endlogo", ::fusion_endlogo );
}

precache_presets()
{

}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    level.player _meth_811F( "voices_critical" );
    soundscripts\_audio_whizby::whiz_set_radii( 50, 100, 5000 );
    soundscripts\_audio_whizby::whiz_set_offset( 15 );
    soundscripts\_audio_whizby::whiz_set_probabilities( 50, 50, 100 );
    soundscripts\_audio_whizby::whiz_set_spreads( 200, 300, 400 );
}

init_audio_flags()
{
    common_scripts\utility::flag_init( "aud_alarm_outside_started" );
    common_scripts\utility::flag_init( "aud_alarm_outside_enabled" );
    common_scripts\utility::flag_set( "aud_alarm_outside_enabled" );
    common_scripts\utility::flag_init( "flag_player_zip_started" );
}

init_globals()
{
    level.aud.reverb_alarm_volume = 1.0;
    level.aud.reverb_alarm_volume_update_rate = 0.1;
    level.aud.bomb_shakes = 0;
    level.aud.control_room_buzzer_started = 0;
    maps\_utility::disable_trigger_with_targetname( "audio_reactor_entrance" );
    maps\_utility::disable_trigger_with_targetname( "audio_elevator_entrance" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_level_global_mix" );
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread intro_fly_in_part2_vo();
    thread fastzip_explosion_seq();
    thread trigger_alarm_on_street_combat_started();
    thread sec_door_breach_anim();
    thread trigger_control_room_gas_leak();
    var_0 = getent( "audio_security_checkpoint_01", "targetname" );
    var_1 = getent( "audio_security_checkpoint_02", "targetname" );
    var_0 thread security_checkpoint_trigger_think();
    var_1 thread security_checkpoint_trigger_think();
}

launch_loops()
{
    thread start_looping_intro_alarm_sounds();
    thread start_looping_outro_alarm_sounds();
    thread launch_intro_loops();
    thread launch_middle_loops();
    thread launch_outro_loops();
}

launch_intro_loops()
{
    if ( level.currentgen && !_func_21E( "fusion_intro_tr" ) )
        return;

    common_scripts\utility::loop_fx_sound( "metal_detector_hum_lp", ( 657, 3291, 60 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "metal_detector_hum_lp", ( 657, 2721, 60 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 697, 3251, 30 ), 1, "aud_stop_intro" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 699, 2754, 30 ), 1, "aud_stop_intro" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        level notify( "aud_stop_intro" );
    }
}

launch_middle_loops()
{
    if ( level.currentgen && !_func_21E( "fusion_middle_tr" ) )
        level waittill( "tff_post_transition_intro_to_middle" );

    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 1105, 2566, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 987, 2566, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 865, 2566, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 1546, 2949, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_01", ( 1545, 2959, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_04", ( 865, 2566, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 42, 3362, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 42, 3483, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 42, 3600, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "static_offline_tv_panel_lp", ( 1020, 3212, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "static_offline_tv_panel_lp", ( 1020, 3450, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "static_offline_tv_panel_lp", ( 1190, 3543, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "static_offline_tv_panel_lp", ( 637, 3697, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_01", ( 596, 3168, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_02", ( 959, 3670, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_04", ( 822, 3527, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_03", ( 1111, 3420, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_01", ( 1028, 3899, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 1309, 3108, -479 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 577, 3091, -479 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1986, 4147, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1719, 4405, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 2129, 4268, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1861, 4547, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1872, 4809, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 2162, 5089, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1739, 4945, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 1989, 5186, -400 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 1941, 4645, -479 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 2263, 5011, -479 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_steam_lp", ( 3367, 4382, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_generator_lp", ( 3947, 4478, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 3777, 4568, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_01", ( 3307, 4059, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 3136, 3983, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 3302, 4076, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 3487, 4142, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 3707, 4203, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_03", ( 4289, 4106, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "liquid_coolant_pool_lp", ( 3558, 3794, -509 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "liquid_coolant_pool_lp", ( 4795, 3197, -509 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4259, 4029, -541 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4539, 3903, -541 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4343, 4484, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4677, 4394, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4186, 4244, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 4486, 3251, -543 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 5242, 3051, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_04", ( 5177, 2166, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_steam_lp", ( 5500, 2698, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 5186, 2446, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 5051, 2153, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 5377, 2160, -454 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 5288, 2017, -454 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 5040, 2497, -541 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4918, 2221, -541 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_steam_lp", ( 4076, 1214, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_steam_lp", ( 3485, 1939, -541 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 4078, 1538, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_hard_drive_lp", ( 3448, 1590, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "mach_industrial_steam_lp", ( 3409, 1339, -485 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4507, 4416, -357 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "computer_main_frame_lp", ( 4685, 4333, -357 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_02", ( 4724, 4363, -357 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "alarm_computer_warning_03", ( 4329, 4531, -357 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4021, 608, -479 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4013, 23, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 3548, 31, -484 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 3958, -139, -450 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 3585, -143, -450 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 3962, -324, -450 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "amb_elec_comp_smart_glass_lp", ( 3579, -329, -450 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4563, 7, -482 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4563, 449, -482 ), 1, "aud_stop_middle" );
    common_scripts\utility::loop_fx_sound( "electrical_transformer_hum_lp", ( 4563, 595, -482 ), 1, "aud_stop_middle" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_middle_to_outro" );
        level notify( "aud_stop_middle" );
    }
}

launch_outro_loops()
{
    if ( level.currentgen && !_func_21E( "fusion_outro_tr" ) )
        level waittill( "tff_post_transition_middle_to_outro" );

    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 5295, 1252, -36 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 5870, 719, -36 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 5830, 721, 93 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6554, 1065, 108 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 5735, 528, 228 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6146, 437, 228 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6251, 523, 238 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6257, 927, 268 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6460, 1103, 228 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6536, 1016, 268 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 7206, 1604, 230 ), 1 );
    common_scripts\utility::loop_fx_sound( "mach_industrial_boiler_lp", ( 6149, 534, 350 ), 1 );
    common_scripts\utility::loop_fx_sound( "mach_industrial_boiler_lp", ( 6891, 1266, 350 ), 1 );
    common_scripts\utility::loop_fx_sound( "mach_industrial_boiler_lp", ( 7274, 2228, 350 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6721, 1801, 164 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_lp", ( 6621, 2086, 147 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_sml_lp_01", ( 6550, 3171, 250 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_sml_lp_02", ( 6165, 3408, 250 ), 1 );
    common_scripts\utility::loop_fx_sound( "steam_broken_pipe_sml_lp_01", ( 6347, 3656, 250 ), 1 );
}

create_level_envelop_arrays()
{
    level.aud.envs["alarm_verb_level_over_distance"] = [ [ 0.0, 0.75 ], [ 700, 1.0 ], [ 1200, 0.5 ], [ 2500, 0.1 ], [ 3500, 0.0 ] ];
    level.aud.envs["alarm_verb_level_flyin_over_distance"] = [ [ 0.0, 0.0 ], [ 500, 0.2 ], [ 1000, 1.0 ], [ 4000, 0.6 ], [ 7000, 0.0 ] ];
    level.aud.envs["turret_drop_shake_over_distance"] = [ [ 0.0, 0.5 ], [ 1000, 0.1 ], [ 1200, 0.1 ] ];
    level.aud.envs["titan_tank_cannon"] = [ [ 0, 1 ], [ 1500, 0.75 ], [ 3000, 0.4 ], [ 4500, 0.1 ] ];
}

register_trigger_callbacks()
{

}

add_note_track_data()
{

}

start_intro_fly_in( var_0 )
{
    thread intro_flight_start();
    wait 5.2;
    thread intro_fly_in_vo();
    level notify( "heli_intro_burke_foley" );
}

start_intro_fly_in_part2( var_0 )
{
    level notify( "aud_start_fusion_fly_in_intro_vo_done" );
}

start_courtyard( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_courtyard_battle" );
}

start_security_room( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_courtyard_battle" );
}

start_lab( var_0 )
{
    if ( isdefined( level.aud.security_building_entrance ) )
    {
        level.aud.security_building_entrance aud_fade_out( 0.1 );
        level.aud.security_building_entrance = undefined;
    }

    thread start_lab_alarms();
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_airlock_lab_hallway" );
}

start_reactor( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_pre_reactor_hallway" );
    thread start_lab_alarms();
    thread start_pre_reactor_alarms();
}

start_reactor_exit( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_post_reactor_hallway" );
    thread start_alarm_post_reactor();
    thread start_pa_codered();
}

start_turbine_room( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_turbine_elevator" );
}

start_control_room_entrance( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_turbine_room" );
    level endon( "stop_pa_turbine" );

    if ( isdefined( level.aud.pa_emergency_turbine ) && level.aud.pa_emergency_turbine )
        return;
    else
    {
        level.aud.pa_emergency_turbine = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "fus_prg_pleaseproceedtothenearest", ( 7231, 2847, 267 ) );
            wait 9;
        }
    }
}

start_control_room( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_control_room" );
}

start_control_room_exit( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_pre_loading_bay" );
    thread start_loading_bay_alarms();
    thread start_control_room_alarms();
    thread trigger_bomb_shake();

    if ( !common_scripts\utility::flag( "aud_alarm_outside_started" ) )
        thread start_outside_alarm();
}

start_cooling_tower( var_0 )
{
    soundscripts\_snd::snd_music_message( "mus_fusion_pressure_readings_critical" );
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_battle_retreat" );

    if ( !common_scripts\utility::flag( "aud_alarm_outside_started" ) )
        thread start_outside_alarm();
}

snd_zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "enter_fusion_elevator_shaft":
            thread start_lab_alarms();
            break;
        case "enter_fusion_airlock_lab_hallway":
            if ( isdefined( level.aud.security_building_entrance ) )
            {
                level.aud.security_building_entrance aud_fade_out( 1 );
                level.aud.security_building_entrance = undefined;
            }

            break;
        case "enter_fusion_airlock_lab":
            thread start_pa_emergency_exit();
            thread start_pa_airlockclosing();
            thread start_pre_reactor_alarms();
            break;
        case "enter_fusion_post_reactor_hallway":
            thread start_pa_codered();
            thread start_alarm_post_reactor();
            break;
        case "enter_fusion_turbine_elevator_quiet":
            level notify( "stop_lab_alarms" );
            level notify( "stop_all_crane_audio" );
            soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_post_reactor_room" );
            break;
        case "enter_fusion_pre_loading_bay":
            level notify( "stop_pa_turbine" );
            break;
        case "enter_fusion_loading_bay":
            var_2 = var_1;
            break;
        case "exit_fusion_control_room":
            var_3 = var_1;

            if ( var_3 == "fusion_control_room" )
            {
                common_scripts\utility::flag_clear( "aud_alarm_outside_enabled" );
                thread trigger_bomb_shake();
            }
            else if ( var_3 == "fusion_loading_bay" )
            {
                common_scripts\utility::flag_set( "aud_alarm_outside_enabled" );
                level notify( "notify_out_of_control_room" );
                level.aud.bomb_shakes = 0;
            }

            break;
        case "exit_fusion_loading_bay":
            var_3 = var_1;

            if ( var_3 == "fusion_control_room" )
            {
                common_scripts\utility::flag_clear( "aud_alarm_outside_enabled" );
                thread trigger_bomb_shake();
            }
            else if ( var_3 == "fusion_loading_bay" )
            {
                common_scripts\utility::flag_set( "aud_alarm_outside_enabled" );
                level notify( "notify_out_of_control_room" );
                level.aud.bomb_shakes = 0;
            }

            break;
        case "enter_fusion_battle_retreat":
            var_2 = var_1;
            break;
        case "exit_fusion_battle_retreat":
            var_3 = var_1;

            if ( var_3 == "fusion_battle_retreat" )
            {
                level notify( "notify_out_of_loading_bay" );
                level.aud.control_room_buzzer_started = 0;
            }
            else if ( var_3 == "fusion_loading_bay" )
                thread start_control_room_alarms();

            break;
    }
}

intro_flight_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_intro_flight", 0.05 );
    wait 0.45;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_helo_interior", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_helo_controls", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_door_mech_a", 34.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_door_mech_b", 34.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_door_decompress", 34.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_door_wind", 34.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_b_flyin", 37.25 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_b_decloak", 40.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_b_chop", 40.75 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_b_engine", 40.75 );
    wait 35;
    soundscripts\_audio::aud_set_music_submix( 0.75, 5 );
}

start_hologram_audio()
{

}

start_burke_foley( var_0 )
{
    level waittill( "heli_intro_burke_foley" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_gideon_foley", 7.6 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_gideon_hologram", 9.8 );
    common_scripts\utility::flag_wait( "flag_burke_zip" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_intro_burke_jump_zipline", 7.7 );
}

start_intro_npc_foley( var_0 )
{

}

decloak_intro_helicopter()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_b_bank", 6.43 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbirds_engine", 8.25 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbirds_flyby", 8.25 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbirds_flyby_rear", 8.25 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_cliff_engine", 12.97 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_cliff_chop", 12.97 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_fighter_jets", 18.29 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_anti_air_explo", 19 );
    wait 14;
    soundscripts\_snd::snd_music_message( "mus_fusion_crest_hill" );
}

intro_flight_missiles_fire()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_rockets_miss", 1.67 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_rockets_hit", 5.47 );
    wait 3.16;
    soundscripts\_snd::snd_music_message( "mus_fusion_first_contact" );
}

missile_hit_warbird_b()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_hit", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_hit_debris", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_hit_chop", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_hit_broke", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_engine_hit", 1.52 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_crash", 2.7 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_crash_mtl", 2.7 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_intro_warbird_a_hover", 4 );
    wait 2.7;
    maps\_utility::radio_dialogue_stop();
    wait 2;
    thread intro_fly_in_post_crash_vo();
}

warbird_b_crash_tower()
{
    wait 8.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_intro_flight", 4 );
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_courtyard_battle_flyin", 5 );
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_courtyard_battle", 5 );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_metal_vehicle" );
}

rooftop_strafe_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_courtyard_warbirds", 2 );
    var_0 = self;
    var_0 thread soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "fus_warbird_roof_strafe_by", 1700 );
    wait 5;
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp", "stop_warbird_chop", undefined, undefined, 0, ( 0, 0, 0 ) );
    var_1 _meth_806F( 0.0 );
    var_1 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 1, 4 );
    common_scripts\utility::flag_wait( "flag_squad_heli_01_zip_complete" );
    var_0 thread soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "fus_warbird_roof_strafe_depart", 1000 );
    var_1 _meth_806F( 0, 5 );
    wait 5.05;
    level notify( "stop_warbird_chop" );
}

player_warbird_spawn()
{
    level waittill( "aud_roof_combat_complete" );
    var_0 = self;
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp", "stop_warbird_plr_blades", undefined, undefined, 0, ( -50, 200, 100 ) );
    var_1 _meth_806F( 0.0 );
    var_1 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 0.75, 2 );
    var_2 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_interior_lp", "stop_warbird_plr_interior", undefined, undefined, 0, ( -50, -200, 100 ) );
    var_2 _meth_806F( 0.0 );
    var_2 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 0.75, 2 );
    level waittill( "aud_fastzip_end" );
    var_1 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 0, 5 );
    var_2 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 0, 5 );
    wait 5.05;
    level notify( "stop_warbird_plr_blades" );
    level notify( "stop_warbird_plr_interior" );
}

fastzip_turret_switch_to()
{
    soundscripts\_snd_playsound::snd_play_2d( "tac_fastzip_start" );
}

fastzip_turret_switch_complete()
{

}

fastzip_turret_fire()
{
    soundscripts\_snd_playsound::snd_play_2d( "tac_fastzip_fire_plr" );
}

fastzip_turret_putaway()
{
    soundscripts\_snd_playsound::snd_play_2d( "tac_fastzip_turret_putaway" );
}

fastzip_rappel()
{
    wait 0.3;
    var_0 = soundscripts\_snd_playsound::snd_play_2d( "tac_fastzip_slide" );
    level waittill( "aud_fastzip_end" );
    soundscripts\_snd_playsound::snd_play_2d( "tac_fastzip_land" );

    if ( isdefined( var_0 ) )
        var_0 _meth_806F( 0, 0.01 );
}

fastzip_explosion_seq()
{
    common_scripts\utility::flag_wait( "flag_player_zip_started" );
    wait 1.2;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_fastzip_explo", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_fastzip_explode_hit_chunks", 0.05 );
}

fastzip_hit_the_ground()
{
    level notify( "aud_fastzip_end" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_courtyard_battle_flyin", 1 );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_metal_vehicle" );
}

player_warbird_flyout()
{
    thread soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "fus_warbird_plr_depart_flyby", 900 );
}

warbird_mobile_turret_dropoff()
{
    var_0 = self;
    wait 0.05;
    var_0 thread soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_turret_drop_chop" );
    wait 2.95;
    var_0 thread soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_turret_drop_engine" );
    wait 7.5;
    var_0 thread soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_turret_drop_depart" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_courtyard_warbirds", 8 );
}

walker_mobile_turret_dropoff()
{
    var_0 = 1000;
    var_1 = self;
    wait 8.35;
    var_1 thread soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_turret_drop_chain" );
    var_1 thread soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_turret_drop_mech" );
    wait 0.4;
    var_2 = distance( level.player.origin, var_1.origin );

    if ( var_2 < var_0 )
    {
        var_3 = soundscripts\_snd::snd_map( var_2, level.aud.envs["turret_drop_shake_over_distance"] );
        earthquake( var_3, 0.5, level.player.origin, var_0 );
    }
}

cvrdrn_paired_anim_start()
{
    waitframe();
    thread soundscripts\_snd_playsound::snd_play_linked( "fus_cvrdrn_paired_anim" );
}

cvrdrn_paired_anim_explo()
{
    thread soundscripts\_snd_playsound::snd_play_linked( "cvrdrn_explode_hit" );
    thread soundscripts\_snd_playsound::snd_play_linked( "cvrdrn_explode_hit_debris" );
}

start_ambient_jet()
{
    thread soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "veh_fa18_flyby_rand", 6000 );
}

courtyard_ambient_bullet_impact( var_0, var_1, var_2 )
{
    thread common_scripts\utility::play_sound_in_space( "bullet_large_default", var_2 );
}

street_wall_1_explode( var_0 )
{
    thread common_scripts\utility::play_sound_in_space( "wall_explode", var_0 );
    thread common_scripts\utility::play_sound_in_space( "wall_explode_mtl", var_0 );
}

spawn_walker_mobile_turret_deploy()
{
    if ( level.currentgen )
        level endon( "tff_pre_transition_intro_to_middle" );

    self waittill( "death" );
    var_0 = spawnstruct();
    var_0.pos = self.origin;
    var_0.speed_of_sound_ = 1;
    var_0.duck_alias_ = "exp_generic_explo_sub_kick";
    var_0.duck_dist_threshold_ = 1000;
    var_0.explo_delay_chance_ = 40;
    var_0.explo_tail_alias_ = "exp_generic_explo_tail";
    var_0.shake_dist_threshold_ = 1800;
    var_0.explo_debris_alias_ = "exp_debris_mixed";
    var_0.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
    var_0.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_0 );
}

spawn_ally_walker_02()
{
    if ( level.currentgen )
        level endon( "tff_pre_transition_intro_to_middle" );

    self waittill( "death" );
    thread common_scripts\utility::play_sound_in_space( "fus_walker_explode_hit", self.origin );
}

player_enter_walker( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_inside_xwalker", 0.1 );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "bullet_metal_vehicle" );
}

player_exit_walker( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_inside_xwalker", 1.0 );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "bullet_metal_vehicle" );
}

player_enter_walker_anim()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_enter_exit_walker", 0 );
    var_0 = soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_enter" );
    var_0 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_enter_exit_walker", 0.1 );
}

player_exit_walker_anim()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_enter_exit_walker", 0 );
    var_0 = soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_exit" );
    var_0 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_enter_exit_walker", 0.1 );
}

x4_walker_hud_missile_launched( var_0 )
{

}

x4_walker_hud_target_aquired( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "x4_walker_missile_lock" );
}

x4_walker_fire_missile( var_0 )
{
    if ( isdefined( self ) )
    {
        var_1 = var_0;
        var_2 = self;
        thread soundscripts\_snd_playsound::snd_play_2d( "x4_walker_missile_fire" );
        var_2 _meth_8075( "x4_walker_missile_loop" );
        var_2 waittill( "explode", var_3 );
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
}

player_mobile_turret_warning()
{
    soundscripts\_snd_playsound::snd_play_loop_linked( "x4walker_warning_beep_loop", "snd_stop_mt_alert" );
    level waittill( "street_cleanup" );
    level notify( "snd_stop_mt_alert" );
}

player_mobile_turret_explo()
{
    level notify( "snd_stop_mt_alert" );
    thread soundscripts\_snd_playsound::snd_play_linked( "cvrdrn_explode_hit" );
    thread soundscripts\_snd_playsound::snd_play_linked( "cvrdrn_explode_hit_debris" );
}

mobile_turret_missile( var_0 )
{
    if ( isdefined( self ) )
    {
        var_1 = var_0;
        var_2 = self;
        thread soundscripts\_snd_playsound::snd_play_2d( "x4_walker_missile_fire_npc" );
        var_2 _meth_8075( "x4_walker_missile_loop" );
        var_2 waittill( "explode", var_3 );
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
}

courtyard_mi17_spawn_01( var_0 )
{
    var_0 endon( "death" );
    var_0.snd_disable_vehicle_system = 1;
    var_0 thread audio_monitor_chopper01_death();
    level.aud.chopper_01_dist_lp = aud_create_linked_entity( var_0 );
    level.aud.chopper_01_dist_lp aud_fade_in( "mi17_dist_towards_lp", 1, 1 );
    wait 7.5;
    level.aud.chopper_01_by_in = aud_create_linked_entity( var_0 );
    level.aud.chopper_01_by_in aud_play( "mi17_by_in_01" );
    level.aud.chopper_01_dist_lp aud_fade_out( 0.35 );
    level.aud.chopper_01_dist_lp = undefined;
    wait 4;
    level.aud.chopper_01_close_lp = aud_create_linked_entity( var_0 );
    level.aud.chopper_01_close_lp aud_fade_in( "mi17_close_towards_lp", 0.75, 1 );
    wait 15;
    level.aud.chopper_01_wind_up = aud_create_linked_entity( var_0 );
    level.aud.chopper_01_wind_up aud_play( "mi17_by_windup_01" );
    level.aud.chopper_01_close_lp aud_fade_out( 1 );
    level.aud.chopper_01_close_lp = undefined;
    wait 2;
    level.aud.chopper_01_away_by = aud_create_linked_entity( var_0 );
    level.aud.chopper_01_away_by aud_play( "mi17_by_out_01" );
}

courtyard_mi17_spawn_02( var_0 )
{
    var_0 endon( "death" );
    var_0.snd_disable_vehicle_system = 1;
    var_0 thread audio_monitor_chopper02_death();
    level.aud.chopper_02_dist_lp = aud_create_linked_entity( var_0 );
    level.aud.chopper_02_dist_lp aud_fade_in( "mi17_dist_towards_lp", 1, 1 );
    wait 7.5;
    level.aud.chopper_02_by_in = aud_create_linked_entity( var_0 );
    level.aud.chopper_02_by_in aud_play( "mi17_by_in_02" );
    level.aud.chopper_02_dist_lp aud_fade_out( 0.35 );
    level.aud.chopper_02_dist_lp = undefined;
    wait 4;
    level.aud.chopper_02_close_lp = aud_create_linked_entity( var_0 );
    level.aud.chopper_02_close_lp aud_fade_in( "mi17_close_towards_lp", 0.75, 1 );
    wait 15;
    level.aud.chopper_02_wind_up = aud_create_linked_entity( var_0 );
    level.aud.chopper_02_wind_up aud_play( "mi17_by_windup_02" );
    level.aud.chopper_02_close_lp aud_fade_out( 1 );
    level.aud.chopper_02_close_lp = undefined;
    wait 2;
    level.aud.chopper_02_away_by = aud_create_linked_entity( var_0 );
    level.aud.chopper_02_away_by aud_play( "mi17_by_out_02" );
}

titan_init( var_0 )
{
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_left_large", ::titan_footstep_front_left );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_right_large", ::titan_footstep_front_right );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_left_rear_large", ::titan_footstep_rear_left );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "footstep_right_rear_large", ::titan_footstep_rear_right );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "aud_titan_siege_mode_adj_left_side", ::aud_titan_siege_mode_adj_left_side );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "aud_titan_siege_mode_adj_right_side", ::aud_titan_siege_mode_adj_right_side );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "aud_titan_siege_mode_adj_left_side_back", ::aud_titan_siege_mode_adj_left_side_back );
    maps\_anim::addnotetrack_customfunction( "walker_tank", "aud_titan_siege_mode_adj_right_side_back", ::aud_titan_siege_mode_adj_right_side_back );
    thread titan_engine();
    thread titan_fire_wait();
}

titan_enter()
{
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_enter_transform", 5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_servo_move", 9.5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_servo_move", 8 );
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_servo_move", 7 );
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_footstep", 9 );
    thread soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_footstep", 11 );
    wait 9;
    thread maps\_utility::play_sound_on_tag( "titan_servo_move", "frontWheelTread01_FL" );
    wait 1;
    thread maps\_utility::play_sound_on_tag( "titan_footstep", "frontWheelTread01_FR" );
}

titan_missile( var_0 )
{
    if ( isdefined( self ) )
    {
        thread common_scripts\utility::play_sound_in_space( "wpn_rpg_npc", self.origin );
        var_1 = soundscripts\_snd_playsound::snd_play_loop_linked( "wpn_rpg_loop", "titan_rpg_loop_stop" );
        self waittill( "explode", var_2 );
        var_3 = spawnstruct();
        var_3.pos = var_2;
        var_3.duck_alias_ = "exp_generic_explo_sub_kick";
        var_3.duck_dist_threshold_ = 1000;
        var_3.explo_delay_chance_ = 100;
        var_3.shake_dist_threshold_ = 2000;
        var_3.explo_debris_alias_ = "exp_debris_dirt_chunks";
        var_3.shake_duration = 1.5;
        thread soundscripts\_snd_common::snd_ambient_explosion( var_3 );
    }
}

titan_engine()
{
    if ( isdefined( self ) )
    {
        soundscripts\_snd_playsound::snd_play_loop_linked( "titan_engine_lp", "stop_titan_engine_loop" );
        self waittill( "death" );
        level notify( "stop_titan_engine_loop" );
    }
}

titan_fire_wait()
{
    self endon( "death" );

    while ( isdefined( self ) )
    {
        self waittill( "weapon_fired" );
        var_0 = distance( self.origin, level.player.origin );
        var_1 = soundscripts\_snd::snd_map( var_0, level.aud.envs["titan_tank_cannon"] );
        var_2 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_main" );
        var_3 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_low" );
        var_4 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_crunch" );
        var_5 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_tail" );
        var_6 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_lfe" );
        var_7 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_hydraulics" );

        if ( var_0 > 2500 )
            var_8 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_shot_tail_dist" );
        else
            var_9 = soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_cannon_shot_tail_dist", 0.5 );

        var_10 = [ var_2, var_3, var_4, var_6, var_5 ];

        foreach ( var_12 in var_10 )
            var_12 _meth_806E( var_1, 0 );

        wait 0.05;
    }
}

trophy_system_explosion( var_0 )
{
    var_1 = distance( self.origin, level.player.origin );
    var_2 = soundscripts\_snd::snd_map( var_1, level.aud.envs["titan_tank_cannon"] );
    var_3 = level.player soundscripts\_snd_playsound::snd_play_linked( "titan_trophy_system_explode" );
    var_4 = level.player soundscripts\_snd_playsound::snd_play_linked( "titan_trophy_system_explode_impact" );
    var_3 _meth_806F( var_2, 0 );
    var_4 _meth_806F( var_2, 0 );
}

titan_take_damage_from_smaw( var_0 )
{
    var_1 = distance( self.origin, level.player.origin );
    var_2 = soundscripts\_snd::snd_map( var_1, level.aud.envs["titan_tank_cannon"] );
    var_3 = soundscripts\_snd_playsound::snd_play_linked( "titan_take_smaw_dmg" );
    var_3 _meth_806F( var_2 * 2, 0 );
    var_4 = self.origin + ( 500, 0, 0 );
    var_5 = spawnstruct();
    var_5.pos = var_4;
    var_5.duck_alias_ = "exp_generic_explo_sub_kick";
    var_5.duck_dist_threshold_ = 1000;
    var_5.explo_delay_chance_ = 100;
    var_5.shake_dist_threshold_ = 3000;
    var_5.explo_debris_alias_ = "exp_debris_dirt_chunks";
    soundscripts\_snd_common::snd_ambient_explosion( var_5 );
}

titan_death( var_0 )
{
    wait 1;
    var_1 = soundscripts\_snd_playsound::snd_play_linked( "titan_death_whine" );
    var_2 = soundscripts\_snd_playsound::snd_play_linked( "titan_take_smaw_dmg_sparks" );
    var_3 = soundscripts\_snd_playsound::snd_play_linked( "titan_servo_move" );
    var_4 = soundscripts\_snd_playsound::snd_play_linked( "titan_cannon_hydraulics" );
    var_5 = soundscripts\_snd_playsound::snd_play_delayed_linked( "titan_servo_move", 3 );
    wait 3.5;
    soundscripts\_snd_playsound::snd_play_delayed_2d( "titan_explode" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "titan_explode_mtl" );
    var_6 = soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_debris_dirt_chunks", 1.5 );
    var_7 = soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_debris_dirt_chunks", 2 );
}

titan_footstep_front_left( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_footstep", "frontWheelTread01_FL" );
}

titan_footstep_front_right( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_footstep", "frontWheelTread01_FR" );
}

titan_footstep_rear_left( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_footstep_rear", "frontWheelTread05_KL" );
}

titan_footstep_rear_right( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_footstep_rear", "frontWheelTread05_KR" );
}

aud_titan_siege_mode_adj_left_side( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_servo_move", "frontWheelTread01_FL" );
}

aud_titan_siege_mode_adj_right_side( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_servo_move", "frontWheelTread01_FR" );
}

aud_titan_siege_mode_adj_left_side_back( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_servo_move", "frontWheelTread01_FL" );
}

aud_titan_siege_mode_adj_right_side_back( var_0 )
{
    var_0 thread maps\_utility::play_sound_on_tag( "titan_servo_move", "frontWheelTread01_FR" );
}

itiot_fade_out()
{
    var_0 = 2;
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", var_0 );
}

itiot_fade_in()
{
    var_0 = 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", var_0 );
}

security_checkpoint_trigger_think()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );
        thread security_checkpoint_trigger_play_beep( var_0 );
        wait 0.05;
    }
}

security_checkpoint_trigger_play_beep( var_0 )
{
    if ( isdefined( self.instigators ) )
    {
        if ( common_scripts\utility::array_contains( self.instigators, var_0 ) )
            return;
    }
    else
        self.instigators = [];

    self.instigators[self.instigators.size] = var_0;
    var_1 = aud_create_linked_entity( self );
    var_1 aud_play( "beep_metal_detector_alert" );

    while ( var_0 _meth_80A9( self ) )
        wait 0.1;

    self.instigators = common_scripts\utility::array_remove( self.instigators, var_0 );
    self.instigators = common_scripts\utility::array_removeundefined( self.instigators );
}

sec_door_breach_anim()
{
    maps\_anim::addnotetrack_customfunction( "burke", "fus_gideon_bust_open_sec_door", ::fus_gideon_bust_open_sec_door, "fusion_security_doors_open" );
}

fus_gideon_bust_open_sec_door( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "fus_sec_door_breach", ( 304, 3011, 28 ) );
}

start_elevator_zone_audio()
{
    maps\_utility::enable_trigger_with_targetname( "audio_elevator_entrance" );
}

start_dead_guy_foley( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_security_dead_guy" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_dead_guy_drop", 0.6 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_dead_guy_brk_spin", 0.96 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_dead_guy_brk_leave", 5.15 );
    wait 10.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_security_dead_guy" );
}

sec_room_move_to_elevator()
{
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_joker_foley_01", 0 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_carter_foley_01", 0 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_joker_foley_02", 2.58 );
}

sec_room_attach_to_elevator()
{
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_carter_foley_02", 2.87 );
}

sec_room_elevator_open()
{
    var_0 = getent( "security_room_elevator_doors", "targetname" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_elev_pry_open", 2.4 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_carter_foley_03", 2.67 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_sec_room_joker_foley_03", 2.8 );
}

start_burke_elevator_slide()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_security_elevator_burke" );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_look", 2.4 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_run", 3.6 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_jump", 5.1 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_grab", 5.4 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_slide", 5.9 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_elev_slide_burke_land", 7.9 );
    wait 10.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_security_elevator_burke" );
}

start_player_elevator_jump()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_elev_slide_plr_jump", 0 );
}

start_player_elevator_slide()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_security_elevator_player" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_elev_slide_plr_slide", 1.05 );
    wait 6.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_security_elevator_player" );
}

start_lab_alarms()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.lab_alarms ) && level.aud.lab_alarms )
        return;
    else
    {
        level.aud.lab_alarms = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_verb", ( 1730, 3044, -445 ) );
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_verb", ( 1145, 2883, -445 ) );
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_verb", ( 794, 4173, -445 ) );
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_verb", ( 1051, 4847, -445 ) );
            wait 2.5;
        }
    }
}

start_pa_emergency_exit()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.pa_emergency ) && level.aud.pa_emergency )
        return;
    else
    {
        level.aud.pa_emergency = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "fus_prg_pleaseproceedtothenearest", ( 789, 3596, -445 ) );
            wait 11;
        }
    }
}

start_pa_airlockclosing()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.pa_airlock ) && level.aud.pa_airlock )
        return;
    else
    {
        level.aud.pa_airlock = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "fus_prg_warningcontainmentairlockclosing", ( 1438, 4445, -445 ) );
            wait 8;
        }
    }
}

start_pre_reactor_alarms()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.pre_reactor_alarms ) && level.aud.pre_reactor_alarms )
        return;
    else
    {
        level.aud.pre_reactor_alarms = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_siren_verb", ( 2080, 4817, -445 ) );
            wait 2.5;
        }
    }
}

start_reactor_zone_audio()
{
    wait 6;
    maps\_utility::enable_trigger_with_targetname( "audio_reactor_entrance" );
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.reactor_alarm ) && level.aud.reactor_alarm )
        return;
    else
    {
        level.aud.reactor_alarm = 1;

        for (;;)
        {
            soundscripts\_snd_playsound::snd_play_at( "alarm_interior_hall_dist_verb", ( 3358, 3350, -300 ) );
            soundscripts\_snd_playsound::snd_play_at( "alarm_interior_hall_dist_verb", ( 4474, 3302, -300 ) );
            soundscripts\_snd_playsound::snd_play_at( "alarm_interior_hall_dist_verb", ( 3707, 2198, -300 ) );
            wait 3.5;
        }
    }
}

start_airlock_anim_notetracks()
{
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_approach", "fus_airlock_carter_comp_strt", "fus_airlock_carter_comp_strt" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_approach", "fus_airlock_comp_beep_01", "fus_airlock_comp_beep_01" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_02", "fus_airlock_comp_beep_02" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_03", "fus_airlock_comp_beep_03" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_04", "fus_airlock_comp_beep_04" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_05", "fus_airlock_comp_beep_05" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_06", "fus_airlock_comp_beep_06" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_07", "fus_airlock_comp_beep_07" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_08", "fus_airlock_comp_beep_02" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening_idle", "fus_airlock_comp_beep_09", "fus_airlock_comp_beep_03" );
    maps\_anim::addnotetrack_animsound( "carter", "fusion_airlock_opening", "fus_airlock_comp_beep_10", "fus_airlock_comp_beep_04" );
}

start_reactor_airlock_open( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_reactor_airlock_open" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fus_reactor_airlock_open" );
    wait 4.0;
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_reactor_airlock_servo_lp", "stop_airlock_door_loop" );
    var_1 _meth_806F( 0.0 );
    var_1 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 1, 4 );
    wait 21.0;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fus_reactor_airlock_stop" );
    wait 0.5;
    level notify( "stop_airlock_door_loop" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_reactor_airlock_open" );
}

start_reactor_burke_attack()
{
    wait 8.4;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "fus_airlock_burke_grab" );
    wait 0.7;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "fus_airlock_burke_gun_butt" );
    wait 0.4;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "fus_airlock_burke_exo_throw" );
    wait 1.9;
    level.burke soundscripts\_snd_playsound::snd_play_linked( "fus_airlock_burke_gun_up" );
}

crane_mach_mvmnt_start( var_0, var_1 )
{
    var_0.snd_ent = aud_create_linked_entity( var_0 );
    var_0.snd_ent aud_play( "crane_rctr_mach_start_01" );
    var_0.snd_ent thread crane_check_for_stop_command();
    var_0.snd_ent thread crane_force_stop_command();
    var_1.snd_ent = aud_create_linked_entity( var_1 );
    var_1.snd_ent aud_play( "crane_rctr_mach_start_02" );
    var_1.snd_ent thread crane_check_for_stop_command();
    var_1.snd_ent thread crane_force_stop_command();
}

crane_mach_mvmnt_stop( var_0, var_1 )
{
    if ( isdefined( var_0.snd_ent ) )
    {
        var_0.snd_ent aud_fade_out( 0.5 );
        var_0.snd_ent = undefined;
    }

    if ( isdefined( var_1.snd_ent ) )
    {
        var_1.snd_ent aud_fade_out( 0.5 );
        var_1.snd_ent = undefined;
    }

    var_0.snd_ent = aud_create_linked_entity( var_0 );
    var_0.snd_ent aud_play( "crane_rctr_mach_stop_01" );
    var_0.snd_ent thread crane_check_for_stop_command();
    var_0.snd_ent thread crane_force_stop_command();
    var_1.snd_ent = aud_create_linked_entity( var_1 );
    var_1.snd_ent aud_play( "crane_rctr_mach_stop_02" );
    var_1.snd_ent thread crane_check_for_stop_command();
    var_1.snd_ent thread crane_force_stop_command();
}

crane_claw_mvmnt_start( var_0 )
{
    var_0.snd_ent = aud_create_linked_entity( var_0 );
    var_0.snd_ent aud_play( "crane_rctr_claw_mvmnt_start" );
    var_0.snd_ent thread crane_check_for_stop_command();
    var_0.snd_ent thread crane_force_stop_command();
}

crane_claw_mvmnt_stop( var_0 )
{
    if ( isdefined( var_0.snd_ent ) )
    {
        var_0.snd_ent aud_fade_out( 0.5 );
        var_0.snd_ent = undefined;
    }

    var_0.snd_ent = aud_create_linked_entity( var_0 );
    var_0.snd_ent aud_play( "crane_rctr_claw_mvmnt_stop" );
    var_0.snd_ent thread crane_check_for_stop_command();
    var_0.snd_ent thread crane_force_stop_command();
}

crane_claw_drop_start( var_0 )
{
    var_0 endon( "stop_claw_beep" );
    var_0 playsound( "crane_rctr_claw_drop_start" );
    var_0 _meth_8075( "crane_rctr_claw_drop_lp" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();

    for (;;)
    {
        var_0 playsound( "crane_rctr_claw_drop_beep" );
        wait 1;
    }
}

crane_claw_drop_stop( var_0 )
{
    var_0 notify( "stop_claw_beep" );
    var_0 _meth_80AB( "crane_rctr_claw_drop_lp" );
    var_0 playsound( "crane_rctr_claw_drop_stop" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();
}

crane_claw_rise_start( var_0 )
{
    var_0 playsound( "crane_rctr_claw_rise_start" );
    var_0 _meth_8075( "crane_rctr_claw_rise_lp" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();
}

crane_claw_rise_stop( var_0 )
{
    var_0 _meth_80AB( "crane_rctr_claw_rise_lp" );
    var_0 playsound( "crane_rctr_claw_rise_stop" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();
}

crane_claw_crate_grab( var_0 )
{
    var_0 playsound( "crane_rctr_claw_grab" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();
}

crane_claw_crate_release( var_0 )
{
    var_0 playsound( "crane_rctr_claw_release" );
    var_0 thread crane_check_for_stop_command();
    var_0 thread crane_force_stop_command();
}

crane_check_for_stop_command()
{
    self endon( "death" );

    if ( isdefined( self.hasaudiocheck ) )
        return;

    self.hasaudiocheck = 1;
    level waittill( "stop_all_crane_audio" );

    if ( !isdefined( self ) )
        return;

    self _meth_80AC();
}

crane_force_stop_command()
{
    self endon( "death" );

    if ( level.currentgen )
    {
        if ( isdefined( self.hasaudiocheck ) )
            return;

        self.hasaudiocheck = 1;
        level waittill( "tff_pre_transition_middle_to_outro" );
        self notify( "stop_claw_beep" );

        if ( !isdefined( self ) )
            return;

        self _meth_80AC();
    }
}

reactor_bot_drive_shelf_start( var_0 )
{
    var_0 _meth_8075( "fus_reactor_robot_drive_with_shelf" );
}

reactor_bot_drive_shelf_stop( var_0 )
{
    var_0 _meth_80AB( "fus_reactor_robot_drive_with_shelf" );
    var_0 playsound( "fus_reactor_robot_stop_with_shelf" );
}

reactor_bot_drive_self_start( var_0 )
{
    var_0 _meth_8075( "fus_reactor_robot_drive_no_shelf" );
}

reactor_bot_drive_self_stop( var_0 )
{
    var_0 _meth_80AB( "fus_reactor_robot_drive_no_shelf" );
    var_0 playsound( "fus_reactor_robot_stop_with_shelf" );
}

reactor_bot_turn_shelf( var_0 )
{
    var_0 playsound( "fus_reactor_robot_turn_with_shelf" );
    wait 0.85;
    var_0 playsound( "fus_reactor_robot_lock_in" );
}

reactor_bot_turn_self( var_0 )
{
    var_0 playsound( "fus_reactor_robot_turn_no_shelf" );
    wait 0.85;
    var_0 playsound( "fus_reactor_robot_lock_in" );
}

reactor_bot_shelf_pickup( var_0 )
{
    var_0 playsound( "fus_reactor_robot_shelf_pickup" );
}

reactor_bot_shelf_drop( var_0 )
{
    var_0 playsound( "fus_reactor_robot_shelf_drop" );
}

reactor_bot_elevator_start_lp( var_0 )
{
    var_0 _meth_806F( 0.0, 0.0 );
    var_0 _meth_8075( "fus_reactor_robot_elevator_lp" );
    var_0 _meth_806F( 1.0, 1.0 );
}

reactor_bot_elevator_stop_lp( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    var_0 _meth_80AB( "fus_reactor_robot_elevator_lp" );
}

reactor_bot_initial_elevator_start( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    var_0 playsound( "fus_reactor_robot_elevator_start" );
}

reactor_bot_initial_elevator_stop( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    var_0 playsound( "fus_reactor_robot_elevator_stop" );
}

reactor_bot_final_elevator_start( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    var_0 playsound( "fus_reactor_robot_elevator_door_close" );
}

reactor_bot_final_elevator_stop( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);
}

reactor_bot_elevator_open( var_0 )
{
    var_0 playsound( "fus_reactor_robot_elevator_door_open" );
}

start_pa_codered()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.pa_codered ) && level.aud.pa_codered )
        return;
    else
    {
        level.aud.pa_codered = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "fus_prg_coderedcoderedwarning", ( 3798, 331, -430 ) );
            wait 12;
        }
    }
}

start_alarm_post_reactor()
{
    level endon( "stop_lab_alarms" );

    if ( isdefined( level.aud.post_reactor_alarm ) && level.aud.post_reactor_alarm )
        return;
    else
    {
        level.aud.post_reactor_alarm = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "alarm_interior_hallway_siren_verb", ( 4670, 106, -445 ) );
            wait 2.5;
        }
    }
}

turbine_room_elevator_button()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_reactor_elevator_button", 0.5 );
}

disable_turbine_elevator_trigger()
{
    maps\_utility::disable_trigger_with_targetname( "audio_turbine_elevator_top" );
}

start_turbine_elevator()
{
    thread start_turbine_elevator_alarm();
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_turbine_elevator" );
    wait 0.2;
    thread common_scripts\utility::play_sound_in_space( "fus_elev_door_close", ( 4676, 787, -445 ) );
    wait 5.1;
    level.aud.elev_ride = aud_create_entity( ( 0, 0, 0 ) );
    level.aud.elev_ride aud_fade_in( "fus_elev_ride_lp", 0.35, 1 );
}

stop_turbine_elevator()
{
    thread common_scripts\utility::play_sound_in_space( "fus_elev_door_open", ( 4862, 960, -95 ) );

    if ( isdefined( level.aud.elev_ride ) )
    {
        level.aud.elev_ride aud_fade_out( 0.5 );
        level.aud.elev_ride = undefined;
    }

    wait 2.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_turbine_elevator", 1.0 );
}

start_turbine_elevator_alarm()
{
    wait 1.1;
    soundscripts\_snd_playsound::snd_play_2d( "fus_elev_door_alarm" );
    wait 0.83;
    soundscripts\_snd_playsound::snd_play_2d( "fus_elev_door_alarm" );
    wait 0.83;
    soundscripts\_snd_playsound::snd_play_2d( "fus_elev_door_alarm" );
}

start_turbine_loop()
{
    wait 0.5;
    var_0 = common_scripts\utility::getstruct( "turbine_1_sound_source_upper", "targetname" );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_upper_01", var_0.origin );
    var_1 = common_scripts\utility::getstruct( "turbine_1_sound_source_lower", "targetname" );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_01", var_1.origin );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_mech_parts_close", ( 5393, 960, 3 ) );
    var_2 = common_scripts\utility::getstruct( "turbine_2_sound_source_upper", "targetname" );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_upper_02", var_2.origin );
    var_3 = common_scripts\utility::getstruct( "turbine_2_sound_source_lower", "targetname" );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_02", var_3.origin );
    thread common_scripts\utility::play_loopsound_in_space( "fus_turbine_mech_parts_close", ( 6020, 1398, 3 ) );
    var_4 = common_scripts\utility::getstruct( "turbine_3_sound_source_upper", "targetname" );
    level.aud.damaged_turbine_1 = common_scripts\utility::play_loopsound_in_space( "fus_turbine_damaged", var_4.origin );
    var_5 = common_scripts\utility::getstruct( "turbine_3_sound_source_lower", "targetname" );
    level.aud.damaged_turbine_2 = common_scripts\utility::play_loopsound_in_space( "fus_turbine_damaged", var_5.origin );
    common_scripts\utility::play_loopsound_in_space( "fus_turbine_upper_02", ( 6967, 1920, 140 ) );
    soundscripts\_audio_zone_manager::azm_start_zone( "fusion_turbine_elevator_loud", 0.5 );
    maps\_utility::enable_trigger_with_targetname( "audio_turbine_elevator_top" );
}

rec_player_drone_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_playable_drone", 0.25 );
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
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_playable_drone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_playable_drone_deploy" );
}

snd_player_drone_deploy( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_playable_drone_deploy" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "assault_drone_deploy", 0.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "assault_drone_wrist_panel", 3.63 );
    wait 4.25;
    soundscripts\_snd_playsound::snd_play_at( "assault_drone_start", var_0.origin, "kill_player_op_drone_ext_loop", undefined, 1.5 );
    soundscripts\_snd_playsound::snd_play_2d( "assault_drone_start_pov" );
}

snd_player_drone_wrist_panel()
{

}

snd_player_drone_enter_drone_pov()
{

}

turbine_pre_explo()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_turbine_room_expl" );
    thread soundscripts\_snd_playsound::snd_play_2d( "turbine_pre_expl_2d_lr" );
    thread common_scripts\utility::play_sound_in_space( "turbine_pre_expl_3d_01", ( 6701.75, 1845.58, 115.563 ) );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_turbine_room_expl", 0.35 );
    wait 0.4;
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_turbine_room_expl" );
    thread common_scripts\utility::play_sound_in_space( "turbine_pre_expl_3d_02", ( 7000.59, 1638, 91.9606 ) );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_turbine_room_expl", 0.35 );
}

turbine_explo()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_turbine_room_expl" );
    thread soundscripts\_snd_playsound::snd_play_2d( "turbine_expl_2d_lr" );
    wait 0.2;
    thread soundscripts\_snd_playsound::snd_play_2d( "turbine_expl_2d_lfe" );
    thread common_scripts\utility::play_sound_in_space( "turbine_expl_3d_01", ( 6701.75, 1845.58, 115.563 ) );
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space( "turbine_expl_3d_02", ( 7000.59, 1638, 91.9606 ) );
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_turbine_room_expl", 1.0 );
    wait 0.75;
    var_0 = common_scripts\utility::getstruct( "turbine_3_sound_source_upper", "targetname" );
    var_1 = common_scripts\utility::getstruct( "turbine_3_sound_source_lower", "targetname" );
    thread common_scripts\utility::play_sound_in_space( "turbine_expl_windup", var_1.origin );
    level.aud.damaged_turbine_1 _meth_80AB();
    level.aud.damaged_turbine_2 _meth_80AB();
    level.aud.damaged_turbine_1 delete();
    level.aud.damaged_turbine_2 delete();
    wait 4;
    common_scripts\utility::play_loopsound_in_space( "turbine_expl_post_lp", var_1.origin );
    common_scripts\utility::play_loopsound_in_space( "turbine_expl_post_lp_top", var_0.origin );
}

start_pa_emergency_turbine()
{
    level endon( "stop_pa_turbine" );

    if ( isdefined( level.aud.pa_emergency_turbine ) && level.aud.pa_emergency_turbine )
        return;
    else
    {
        level.aud.pa_emergency_turbine = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "fus_prg_pleaseproceedtothenearest", ( 7231, 2847, 267 ) );
            wait 9;
        }
    }
}

start_turbine_door_breach()
{
    thread control_room_foley_notetracks();
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_turbine_door_breach" );
    wait 1.45;
    level.carter soundscripts\_snd_playsound::snd_play_linked( "door_trbn_rm_exo_pnch" );
    common_scripts\utility::play_sound_in_space( "door_trbn_rm_breach", ( 7234, 2736, 228 ) );
}

start_turbine_door_impt( var_0, var_1 )
{
    wait 2.2;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "door_trbn_rm_impt_left" );
    wait 0.25;
    var_1 soundscripts\_snd_playsound::snd_play_linked( "door_trbn_rm_impt_right" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_turbine_door_breach", 1.0 );
}

control_room_foley_notetracks()
{
    maps\_anim::addnotetrack_customfunction( "burke", "aud_start_burke_ctrl_rm_start", ::burke_cr_foley_start, "fusion_door_explosion" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_start_burke_ctrl_rm_enter", ::burke_cr_foley_enter, "fusion_door_explosion" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_start_burke_ctrl_rm_idle", ::burke_cr_foley_idle, "control_room_idle" );
    maps\_anim::addnotetrack_customfunction( "burke", "aud_start_burke_ctrl_rm_console", ::burke_cr_foley_console, "control_room_scene" );
    maps\_anim::addnotetrack_customfunction( "carter", "aud_start_carter_ctrl_rm_start", ::carter_cr_foley_start, "fusion_door_explosion" );
    maps\_anim::addnotetrack_customfunction( "carter", "aud_start_carter_ctrl_rm_idle", ::carter_cr_foley_idle, "control_room_idle" );
    maps\_anim::addnotetrack_customfunction( "burke", "fus_burke_ctrl_rm_shoulder_ram", ::fus_burke_ctrl_rm_shoulder_ram, "control_room_scene" );
}

burke_cr_foley_start( var_0 )
{
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_burke_explo_foley", 3.07 );
}

burke_cr_foley_enter( var_0 )
{
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_burke_to_console_foley", 0.75 );
}

burke_cr_foley_idle( var_0 )
{
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_burke_idle_foley_lp", 0.0 );
}

burke_cr_foley_console( var_0 )
{
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_burke_console_foley", 0.075 );
    level.burke soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_burke_away_foley", 35.163 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_end_walk_foley", 26.191 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_leave_foley", 42.172 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_joker_console_foley", 2.581 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_joker_grab_foley", 25.581 );
    level.joker soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_joker_leave_foley", 21.662 );
}

carter_cr_foley_start( var_0 )
{
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_explo_run_foley", 3.485 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_bodyfall_foley", 9.776 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_get_up_foley", 14.061 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_to_console_foley", 16.465 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_pre_idle_foley", 29.162 );
}

carter_cr_foley_idle( var_0 )
{
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_idle_foley_01", 1.103 );
    level.carter soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_cr_carter_idle_foley_02", 4.974 );
}

start_control_room_explo()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_control_rm_explo" );
    var_0 = aud_create_entity( ( 7000, 3540, 168 ) );
    var_0.angles = vectortoangles( var_0.origin - level.player.origin );
    var_0 aud_play( "fus_cntrl_rm_door_explo" );
    soundscripts\_snd_playsound::snd_play_2d( "fus_cntrl_rm_door_explo" );
    soundscripts\_snd_playsound::snd_play_2d( "cntrl_rm_door_explode_hit_chunks" );
    var_0 waittill( "sounddone" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_control_rm_explo" );
}

fus_burke_ctrl_rm_shoulder_ram( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fus_control_room_exit" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_burke_ctrl_rm_shoulder_ram", 0.05 );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fus_control_room_exit" );
}

start_pre_loading_bay( var_0 )
{
    thread start_loading_bay_alarms();
    thread start_control_room_alarms();
    thread trigger_bomb_shake();

    if ( !common_scripts\utility::flag( "aud_alarm_outside_started" ) )
        thread start_outside_alarm();
}

hangar_explo_and_debris_01()
{
    var_0 = ( 6564, 5343, 61 );
    var_1 = spawnstruct();
    var_1.pos = var_0;
    var_1.speed_of_sound_ = 1;
    var_1.duck_alias_ = "exp_generic_explo_sub_kick";
    var_1.duck_dist_threshold_ = 1000;
    var_1.explo_delay_chance_ = 50;
    var_1.shake_dist_threshold_ = 2000;
    soundscripts\_snd_common::snd_ambient_explosion( var_1 );
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_rain", var_0 );
    wait 0.4;
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_01", var_0 );
}

hangar_explo_and_debris_02( var_0 )
{
    var_1 = var_0;
    var_2 = soundscripts\_audio::aud_find_exploder( var_1 );

    if ( isdefined( var_2 ) )
        var_3 = var_2.v["origin"];

    var_4 = ( 6480, 5522, 94 );
    var_5 = ( 6302, 5684, -49 );
    var_6 = ( 6442, 5347, 4 );
    var_7 = ( 6564, 5343, 61 );
    var_8 = ( 6682, 5600, -59 );
    var_9 = spawnstruct();
    var_9.pos = var_4;
    var_9.speed_of_sound_ = 1;
    var_9.duck_alias_ = "exp_generic_explo_sub_kick";
    var_9.duck_dist_threshold_ = 1000;
    var_9.explo_delay_chance_ = 50;
    var_9.shake_dist_threshold_ = 2000;
    soundscripts\_snd_common::snd_ambient_explosion( var_9 );
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_rain", var_4 );
    wait 0.4;
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_01", var_5 );
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_02", var_6 );
    wait 1.2;
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_03", var_7 );
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_01", var_8 );
    thread common_scripts\utility::play_sound_in_space( "hangar_glass_shatter_02", var_7 );
}

hangar_transport_01_away( var_0 )
{
    var_0.snd_disable_vehicle_system = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_hangar_exit_helos", 0 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "mi17_hangar_transport_01_away" );
    soundscripts\_snd_playsound::snd_play_2d( "mi17_hangar_transport_01_away_2d" );
    wait 6.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_hangar_exit_helos", 0.1 );
    wait 1.5;
    var_0.snd_disable_vehicle_system = 0;
}

hangar_transport_flying_01_away( var_0 )
{
    var_0.snd_disable_vehicle_system = 1;
    wait 0.3;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "mi17_hangar_transport_flying_01_away" );
    wait 4.5;
    var_0.snd_disable_vehicle_system = 0;
}

hangar_transport_flying_02_away( var_0 )
{
    var_0.snd_disable_vehicle_system = 1;
    wait 0.75;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "mi17_hangar_transport_flying_02_away" );
    wait 3.7;
    var_0.snd_disable_vehicle_system = 0;
}

extraction_chopper_spawn()
{
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_extraction_warbird", 2 );
    var_0 thread soundscripts\_snd_common::snd_air_vehicle_smart_flyby( "fus_warbird_extract_flyby", 4000 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_extract_engine" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_warbird_extract_turn", 5.2 );
    wait 12;
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_extract_chop_lp", "stop_warbird_chop", undefined, undefined, 0, ( 0, 0, 0 ) );
    var_1 _meth_806F( 0.0 );
    var_1 thread common_scripts\utility::delaycall( 0.05, ::_meth_806F, 1.0, 4 );
    level waittill( "aud_extract_warbird_move" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fus_warbird_extract_move" );
    var_1 _meth_806F( 0, 5 );
    wait 5.05;
    level notify( "stop_warbird_chop" );
}

extraction_chopper_move()
{
    level notify( "aud_extract_warbird_move" );
    soundscripts\_snd::snd_music_message( "mus_pre_tower_collapse_build" );
}

building_explode( var_0 )
{
    thread common_scripts\utility::play_sound_in_space( "building_explode", var_0 );
    var_1 = spawnstruct();
    var_1.pos = var_0;
    var_1.speed_of_sound_ = 1;
    var_1.duck_alias_ = "exp_generic_explo_sub_kick";
    var_1.duck_dist_threshold_ = 1000;
    var_1.explo_delay_chance_ = 40;
    var_1.explo_tail_alias_ = "exp_generic_explo_tail";
    var_1.shake_dist_threshold_ = 1800;
    var_1.explo_debris_alias_ = "exp_debris_mixed";
    var_1.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
    var_1.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_1 );
}

pressure_explosion( var_0 )
{
    var_1 = var_0;
    var_2 = soundscripts\_audio::aud_find_exploder( var_1 );

    if ( isdefined( var_2 ) )
    {
        var_3 = var_2.v["origin"];
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
}

fus_truck_flip_01( var_0 )
{
    var_1 = var_0;
    var_2 = soundscripts\_audio::aud_find_exploder( var_1 );

    if ( isdefined( var_2 ) )
    {
        var_3 = var_2.v["origin"];
        var_4 = soundscripts\_snd_playsound::snd_play_2d( "fus_truck_flip_exp" );
        var_5 = soundscripts\_snd_playsound::snd_play_2d( "fus_truck_flip_exp_lfe_big" );
        thread common_scripts\utility::play_sound_in_space( "fus_truck_flip_exp_debris", var_3 );
        var_6 = ( 9681, 9270, -12 );
        soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", var_6, "air_pressure_truck_flip_01" );
        wait 0.65;
        var_7 = ( 10201, 8959, 75 );
        thread common_scripts\utility::play_sound_in_space( "fus_truck_flip_impact", var_7 );
    }
}

fus_truck_flip_02( var_0 )
{
    var_1 = var_0;
    var_2 = soundscripts\_audio::aud_find_exploder( var_1 );

    if ( isdefined( var_2 ) )
    {
        var_3 = var_2.v["origin"];
        thread common_scripts\utility::play_sound_in_space( "fus_truck_flip_02_exp", var_3 );
        var_4 = soundscripts\_snd_playsound::snd_play_2d( "fus_truck_flip_exp_lfe_big" );
        thread common_scripts\utility::play_sound_in_space( "fus_truck_flip_exp_debris", var_3 );
        var_5 = ( 11578, 9038, -52 );
        soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", var_3, "air_pressure_truck_flip_02" );
        wait 0.8;
        var_6 = ( 11544, 8868, 18 );
        thread common_scripts\utility::play_sound_in_space( "fus_truck_flip_02_impact", var_6 );
    }
}

start_gaz_02_retreat( var_0 )
{
    var_0.snd_disable_vehicle_system = 1;
    level.aud.gaz_02 = aud_create_linked_entity( var_0 );
    level.aud.gaz_02 aud_play( "veh_gaz_tigr_pull_away_fusion_01" );
    wait 4.5;
    var_0.snd_disable_vehicle_system = 0;
}

start_gaz_03_retreat( var_0 )
{
    var_0.snd_disable_vehicle_system = 1;
    level.aud.gaz_03 = aud_create_linked_entity( var_0 );
    level.aud.gaz_03 aud_play( "veh_gaz_tigr_pull_away_fusion_02" );
    wait 5.0;
    var_0.snd_disable_vehicle_system = 0;
}

tower_collapse_prep()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_tower_collapse", 0.05 );
    soundscripts\_snd::snd_music_message( "mus_tower_collapse_start" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_explo_shot_12", 0.104 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_explo_shot_08", 0.382 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_explo_shot_06", 0.687 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_explo_shot_07", 0.837 );
}

tower_collapse_start()
{
    soundscripts\_snd_playsound::snd_play_2d( "fus_tower_explo_sweet_lfe" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_big_boom", 0.13 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_bass_dive", 0.394 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_1st_wave_rubble", 1.445 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_rip_whoosh_front", 1.888 );
}

tower_collapse_player_stumble()
{
    thread tower_collapse_dialog();
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_1st_wave_debris_front", 0.538 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_chunk_impacts", 6.138 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_chunk_impact_left", 8.458 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_chunk_impact_right", 11.612 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_2nd_wave_rvrs_rubble", 14.946 );
    wait 3.616;
    var_0 = spawn( "script_origin", level.player.origin );
    var_0 playsound( "fus_tower_rock_rips_front" );
    wait 4;
    wait 3.565;
    var_1 = spawn( "script_origin", level.player.origin );
    var_1 playsound( "fus_tower_2nd_wave_debris_front" );
}

tower_collapse_dialog()
{
    soundscripts\_snd_filters::snd_fade_in_filter( "fus_tower_collapse_800", 3.0 );
    wait 1.733;
    maps\fusion_vo::radio_dialogue_queue_global( "fus_ch1_bravodoyoucopy" );
    soundscripts\_snd_filters::snd_fade_out_filter( 2.35 );
    level.burke maps\fusion_vo::dialogue_queue_global( "fus_gdn_keepmovingkeepmoving" );
    soundscripts\_snd_filters::snd_fade_in_filter( "fus_tower_collapse_800", 0.05 );
    wait 0.5;
    wait 3.9;
    soundscripts\_snd_filters::snd_fade_out_filter( 0.05 );
    wait 0.6;
    maps\fusion_vo::radio_dialogue_queue_global( "fus_jkr_itscomingdown" );
    soundscripts\_snd_filters::snd_fade_in_filter( "fus_tower_collapse_800", 0.05 );
    wait 1.1;
    maps\fusion_vo::radio_dialogue_queue_global( "fus_jkr_wherescarterwherescarter" );
    soundscripts\_snd_filters::snd_fade_out_filter( 0.05 );
    wait 0.15;
    soundscripts\_snd_filters::snd_fade_in_filter( "fus_tower_collapse_1000", 0.05 );
    maps\fusion_vo::radio_dialogue_queue_global( "fus_ch1_bravotakecover" );
    soundscripts\_snd::snd_music_message( "mus_pre_ending" );
    soundscripts\_snd_filters::snd_fade_out_filter( 0.05 );
}

tower_collapse_player_knockback()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_teleport_impact", 4.102 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_end_burk_debris", 14.965 );
    wait 1.178;
    thread soundscripts\_snd::snd_music_message( "mus_tower_collapse_ending_guitar" );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fusion_tower_collapse", 4 );
    wait 3.822;
    wait 2.818;
    var_0 = spawn( "script_origin", level.player.origin );
    var_0 playsound( "fus_tower_filtered_warbird_front" );
}

silo_collapse_plr_stunned()
{
    var_0 = 6.0;
    soundscripts\_snd_filters::snd_fade_in_filter( "fus_silo_collapse_plr_stunned", var_0 );
    wait 3.0;
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_end_heartbeat", undefined, 4.0, undefined, 1.0 );
    wait 3.0;
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_silo_collapse_plr_stunned", 6.0 );
}

fusion_silo_collapse_warbird()
{
    wait 13.75;
    soundscripts\_snd_playsound::snd_play_2d( "fus_tower_warbird_flyover" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_tower_warbird_landing", 1.05 );
}

fus_outro_burke_foley()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_01", 10.8 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_02", 16.2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_03", 20.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_04", 22.15 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_05", 22.8 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_06", 26.87 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_07", 31.93 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fus_out_burke_foley_08", 38.52 );
}

ending_fade_out( var_0 )
{

}

fusion_endlogo()
{
    soundscripts\_snd_playsound::snd_play_2d( "fus_end_logo" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fusion_end_logo", 12.0 );
}

snd_music_handler( var_0 )
{
    switch ( var_0 )
    {
        case "mus_fusion_intro":
            wait 3;
            soundscripts\_audio::aud_set_music_submix( 0.9, 0 );
            soundscripts\_audio_music::mus_play( "mus_fus_fly_in_intro", 0 );
            wait 2;
            soundscripts\_audio::aud_set_music_submix( 0.65, 6 );
            break;
        case "mus_fusion_crest_hill":
            soundscripts\_audio::aud_set_music_submix( 0.0, 4 );
            break;
        case "mus_fusion_first_contact":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_fus_fly_in_first_contact", 0, 3 );
            wait 15;
            soundscripts\_audio::aud_set_music_submix( 0.75, 10 );
            wait 15;
            soundscripts\_audio::aud_set_music_submix( 0.5, 10 );
            break;
        case "mus_combat_zip_rooftop_complete":
            soundscripts\_audio_music::mus_stop( 15 );
            level notify( "aud_roof_combat_complete" );
            wait 15;
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            break;
        case "mus_fusion_welcome_to_the_party":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            break;
        case "mus_fusion_pressure_readings_critical":
            soundscripts\_audio::aud_set_music_submix( 0.3, 0.05 );
            wait 0.1;
            soundscripts\_audio_music::mus_play( "mus_fus_pressure_readings_critical", 0, 3 );
            soundscripts\_audio::aud_set_music_submix( 1, 30 );
            break;
        case "mus_tower_collapse_start":
            soundscripts\_audio_music::mus_stop( 0.5 );
            break;
        case "mus_pre_ending":
            wait 2;
            soundscripts\_audio::aud_set_music_submix( 1.2, 0.05 );
            soundscripts\_audio_music::mus_play( "mus_fus_pre_outro", 3.0 );
            break;
        case "mus_ending":
            wait 14;
            soundscripts\_audio::aud_set_music_submix( 1.0, 0.05 );
            soundscripts\_audio_music::mus_play( "mus_fus_outro", 0.5 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

intro_fly_in_vo()
{
    wait 2.5;
    maps\_utility::radio_dialogue_queue( "fus_ch2_copytwothreewehavea" );
}

intro_fly_in_part2_vo()
{
    level waittill( "aud_start_fusion_fly_in_intro_vo_done" );
    wait 6.8;
    maps\_utility::radio_dialogue_queue( "fus_ch3_disengagingstealth" );
    wait 2.25;
    maps\_utility::radio_dialogue_queue( "fus_ch3_twothreeunderstandwearestill" );
    maps\_utility::radio_dialogue_queue( "fus_ch1_negativeonthatrestrictedroe" );
    level waittill( "aud_start_fusion_fly_in_pt2_vo_done" );
    wait 7.12;
    maps\_utility::radio_dialogue_queue( "fus_ch1_twofourwevegotasam" );
    wait 0.37;
    thread maps\_utility::radio_dialogue( "fus_ch1_contactcontactdeployingswarmcountermeasures" );
    wait 2.34;
    level.burke thread maps\_utility::dialogue_queue( "fus_gdn_holdon" );
    wait 1.0;
    maps\_utility::radio_dialogue_queue( "fus_ch3_wraithtwothreewerehitwere" );
}

intro_fly_in_post_crash_vo()
{
    maps\_utility::radio_dialogue_queue( "fus_ch1_twofourisdowntwofouris" );
    maps\_utility::radio_dialogue_queue( "fus_ch1_twofivebreakpositionandprovide" );
    wait 0.15;
    maps\_utility::radio_dialogue_queue( "fus_ch4_copythattwothree" );
    wait 0.58;
    common_scripts\utility::flag_set( "flag_rooftop_combat_dialogue" );
}

monitor_2d_reverb_volume()
{
    self endon( "sounddone" );

    for (;;)
    {
        self _meth_806F( level.aud.reverb_alarm_volume, level.aud.reverb_alarm_volume_update_rate );
        wait(level.aud.reverb_alarm_volume_update_rate);
    }
}

play_2d_reverb_alarm_sound()
{
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_0 playsound( "alarm_horn_1shot_verb_ver_04", "sounddone" );
    var_0 thread monitor_2d_reverb_volume();
    var_0 waittill( "sounddone" );
    var_0 _meth_80AC();
    wait 0.05;
    var_0 delete();
}

trigger_alarm_on_street_combat_started()
{
    wait 1;
    common_scripts\utility::flag_wait( "street_combat_start" );
    start_outside_alarm();
}

start_outside_alarm()
{
    common_scripts\utility::flag_set( "aud_alarm_outside_started" );
    var_0 = 3.0;
    var_1 = [ ( -505, -3395, 0 ), ( -1408, 608, 1 ), ( 7984, 8323, 48 ) ];
    thread alarm_reverb_distance_mix( var_1 );

    for (;;)
    {
        if ( common_scripts\utility::flag( "aud_alarm_outside_enabled" ) )
        {
            for ( var_2 = 0; var_2 < var_1.size; var_2++ )
                thread common_scripts\utility::play_sound_in_space( "alarm_horn_1shot_ver_04", var_1[var_2] );

            thread play_2d_reverb_alarm_sound();
        }

        wait(var_0);
    }
}

alarm_reverb_distance_mix( var_0 )
{
    wait 0.05;
    var_1 = var_0[0];

    for (;;)
    {
        if ( common_scripts\utility::flag( "aud_alarm_outside_enabled" ) )
        {
            var_2 = distance( level.player.origin, var_1 );

            for ( var_3 = 0; var_3 < var_0.size; var_3++ )
            {
                var_4 = distance( level.player.origin, var_0[var_3] );

                if ( var_4 < var_2 )
                {
                    var_1 = var_0[var_3];
                    var_2 = var_4;
                }
            }

            var_5 = distance( level.player.origin, var_1 );
            level.aud.reverb_alarm_volume = soundscripts\_snd::snd_map( var_5, level.aud.envs["alarm_verb_level_over_distance"] );
        }

        wait(level.aud.reverb_alarm_volume_update_rate);
    }
}

trigger_courtyard_point_sounds()
{

}

start_control_room_alarms()
{
    level endon( "notify_out_of_loading_bay" );

    if ( !level.aud.control_room_buzzer_started )
    {
        level.aud.control_room_buzzer_started = 1;

        for (;;)
        {
            thread common_scripts\utility::play_sound_in_space( "alarm_buzzer_control_room_3", ( 5444, 4390, 220 ) );
            thread common_scripts\utility::play_sound_in_space( "alarm_buzzer_control_room_3", ( 5144, 4641, 220 ) );
            wait 1.2;
        }
    }
}

trigger_control_room_gas_leak()
{
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", ( 5002, 4713, 400 ), "air_pressure_control_room", 600, 1.0 );
}

start_fire_steam_loops()
{
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_gas_large", ( 6604, 6221, 80 ), "gas_fire_loading_bay_left", 600, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", ( 6212, 5834, 50 ), "air_pressure_leak_left1", 600, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", ( 6844, 6428, 50 ), "air_pressure_leak_left2", 600, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", ( 6922, 5828, 0 ), "air_pressure_leak_middle", 600, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "air_pressure_leak_large", ( 7124, 5602, 260 ), "air_pressure_leak_right_high", 600, 1.0 );
}

start_loading_bay_alarms()
{
    for (;;)
    {
        thread common_scripts\utility::play_sound_in_space( "alarm_buzzer_inside_1shot_ver_02", ( 6372, 5827, 100 ) );
        thread common_scripts\utility::play_sound_in_space( "alarm_buzzer_inside_1shot_ver_02", ( 7576, 6047, 100 ) );
        wait 2;
    }
}

start_looping_intro_alarm_sounds()
{
    if ( level.currentgen && !_func_21E( "fusion_intro_tr" ) )
        return;

    common_scripts\utility::loop_fx_sound( "alarm_small_outside_loop_ver_05", ( -2733, -219, 60 ), 1, "aud_stop_intro_alarms" );
    common_scripts\utility::loop_fx_sound( "alarm_small_outside_loop_ver_03", ( -2827, -3112, 61 ), 1, "aud_stop_intro_alarms" );
    common_scripts\utility::loop_fx_sound( "alarm_small_outside_loop_ver_01", ( -3192, 1426, 61 ), 1, "aud_stop_intro_alarms" );
    level.aud.security_building_entrance = aud_create_entity( ( -200, 3012, 154 ) );
    level.aud.security_building_entrance aud_fade_in( "alarm_small_outside_loop_ver_05", 1, 1 );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_middle" );
        level notify( "aud_stop_intro_alarms" );
    }
}

start_looping_outro_alarm_sounds()
{
    if ( level.currentgen && !_func_21E( "fusion_outro_tr" ) )
        level waittill( "tff_post_transition_middle_to_outro" );

    common_scripts\utility::loop_fx_sound( "alarm_inside_ver_02", ( 5574, 4255, 406 ), 1 );
    common_scripts\utility::loop_fx_sound( "alarm_inside_ver_02", ( 5156, 4634, 406 ), 1 );
    common_scripts\utility::loop_fx_sound( "alarm_inside_ver_02", ( 5879, 4882, 406 ), 1 );
}

do_inside_bombshake()
{
    var_0 = spawn( "script_origin", level.player.origin );
    var_0 playsound( "bomb_explo_shakes", "sounddone" );
    level thread maps\fusion_fx::dust_falling_control_room();
    earthquake( 0.3, 3, level.player.origin, 850 );
    var_0 waittill( "sounddone" );
    var_0 _meth_80AC();
    wait 0.05;
    var_0 delete();
}

trigger_bomb_shake()
{
    level endon( "notify_out_of_control_room" );

    if ( level.aud.bomb_shakes )
        return;
    else
    {
        level.aud.bomb_shakes = 1;
        var_0 = randomintrange( 10, 11 );

        for (;;)
        {
            wait(var_0);
            var_0 = randomintrange( 10, 20 );
            thread do_inside_bombshake();
        }
    }
}

audio_monitor_chopper01_death()
{
    self waittill( "death" );

    if ( isdefined( level.aud.chopper_01_dist_lp ) )
    {
        level.aud.chopper_01_dist_lp aud_fade_out( 0.1 );
        level.aud.chopper_01_dist_lp = undefined;
    }

    if ( isdefined( level.aud.chopper_01_by_in ) )
    {
        level.aud.chopper_01_by_in aud_fade_out( 0.1 );
        level.aud.chopper_01_by_in = undefined;
    }

    if ( isdefined( level.aud.chopper_01_close_lp ) )
    {
        level.aud.chopper_01_close_lp aud_fade_out( 0.1 );
        level.aud.chopper_01_close_lp = undefined;
    }

    if ( isdefined( level.aud.chopper_01_wind_up ) )
    {
        level.aud.chopper_01_wind_up aud_fade_out( 0.1 );
        level.aud.chopper_01_wind_up = undefined;
    }

    if ( isdefined( level.aud.chopper_01_away_by ) )
    {
        level.aud.chopper_01_away_by aud_fade_out( 0.1 );
        level.aud.chopper_01_away_by = undefined;
    }
}

audio_monitor_chopper02_death( var_0 )
{
    self waittill( "death" );

    if ( isdefined( level.aud.chopper_02_dist_lp ) )
    {
        level.aud.chopper_02_dist_lp aud_fade_out( 0.1 );
        level.aud.chopper_02_dist_lp = undefined;
    }

    if ( isdefined( level.aud.chopper_02_by_in ) )
    {
        level.aud.chopper_02_by_in aud_fade_out( 0.1 );
        level.aud.chopper_02_by_in = undefined;
    }

    if ( isdefined( level.aud.chopper_02_close_lp ) )
    {
        level.aud.chopper_02_close_lp aud_fade_out( 0.1 );
        level.aud.chopper_02_close_lp = undefined;
    }

    if ( isdefined( level.aud.chopper_02_wind_up ) )
    {
        level.aud.chopper_02_wind_up aud_fade_out( 0.1 );
        level.aud.chopper_02_wind_up = undefined;
    }

    if ( isdefined( level.aud.chopper_02_away_by ) )
    {
        level.aud.chopper_02_away_by aud_fade_out( 0.1 );
        level.aud.chopper_02_away_by = undefined;
    }
}

aud_play( var_0, var_1 )
{
    var_2 = 0;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    if ( var_2 )
        self _meth_8075( var_0 );
    else
    {
        self playsound( var_0, "sounddone" );
        aud_delete_on_sounddone();
    }
}

aud_fade_in( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( isdefined( var_2 ) )
        var_3 = var_2;

    if ( var_3 )
        self _meth_8075( var_0 );
    else
    {
        self playsound( var_0, "sounddone" );
        aud_delete_on_sounddone();
    }

    if ( var_1 > 0.0 )
        thread audx_fade_in_internal( var_1 );
}

audx_fade_in_internal( var_0 )
{
    self _meth_806F( 0.0 );
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    self _meth_806F( 1.0, var_0 );
}

aud_fade_out( var_0 )
{
    thread audx_fade_out_internal( var_0 );
}

audx_fade_out_internal( var_0 )
{
    self _meth_806F( 0.0, var_0 );
    wait(var_0 + 0.05);

    if ( !isdefined( self ) )
        return;

    self _meth_80AC();
    self _meth_80AB();
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    self delete();
}

aud_delete_on_sounddone()
{
    thread audx_delete_on_sounddone_internal();
}

audx_delete_on_sounddone_internal()
{
    self endon( "death" );
    self waittill( "sounddone" );

    if ( !isdefined( self ) )
        return;

    self delete();
}

aud_play_distance_attenuated_2d( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 1.0;

    if ( isdefined( var_3 ) )
        var_5 = var_3;

    aud_play( var_0, var_4 );
    thread audx_play_distance_attenuated_2d_internal( var_1, var_2, var_5 );
}

audx_play_distance_attenuated_2d_internal( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "aud_stop_distance_attenuation" );

    while ( isdefined( self ) )
    {
        var_3 = distance( self.origin, level.player.origin );
        var_4 = audx_attenuate( var_3, var_0, var_1, var_2 );
        self _meth_806F( var_4 );
        wait 0.05;
    }
}

audx_attenuate( var_0, var_1, var_2, var_3 )
{
    var_0 = max( var_0, var_1 );

    if ( var_0 > var_2 )
        return 0.0;

    var_4 = var_1 / ( var_1 + var_3 * ( var_0 - var_1 ) );
    return var_4;
}

aud_create_entity( var_0 )
{
    return spawn( "script_origin", var_0 );
}

aud_create_linked_entity( var_0, var_1 )
{
    var_2 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_1 ) )
        var_2 _meth_804D( var_0, "", var_1, ( 0, 0, 0 ) );
    else
        var_2 _meth_804D( var_0 );

    return var_2;
}
