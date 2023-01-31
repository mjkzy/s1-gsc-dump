// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "fusion" );
    maps\_utility::set_console_status();
    setup_precache();
    maps\_utility::intro_screen_create( "", "", "" );
    maps\_utility::intro_screen_custom_func( maps\fusion_code::fusion_intro_screen );
    level.intro_hades_video_length = 30.7;
    setup_start_points();
    init_level_flags();
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "axis_street" );
    maps\_player_fastzip::main();
    maps\createart\fusion_art::main();
    maps\fusion_fx::main();
    maps\_weapon_pdrone::initialize();

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\fusion_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "assault", 1 );
    maps\fusion_anim::main();
    maps\fusion_aud::main();
    thread maps\fusion_lighting::main();
    maps\_drone_ai::init();
    maps\_chargeable_weapon::setup_charged_shot();
    maps\_microwave_grenade::main();
    maps\_microdronelauncher::init();
    maps\sanfran_b_sonar_vision::main();
    maps\fusion_utility::spawn_metrics_init_for_noteworthy( "enemy_street_zip_rooftop" );
    maps\fusion_utility::spawn_metrics_init_for_noteworthy( "enemy_street_zip_rooftop_strafe" );

    if ( level.currentgen )
    {
        maps\fusion_utility::spawn_metrics_init_for_noteworthy( "enemy_street_zip_rooftop_left" );
        maps\fusion_utility::spawn_metrics_init_for_noteworthy( "enemy_street_zip_rooftop_right" );
    }

    maps\_utility::add_control_based_hint_strings( "hint_use_boost", &"FUSION_BOOST_HINT", maps\fusion_code::boost_use_hint );
    maps\_utility::add_control_based_hint_strings( "hint_mt_fire_gun", &"FUSION_HINT_FIRE_GUN", ::should_break_use_mt_fire );
    maps\_utility::add_control_based_hint_strings( "hint_mt_fire_missiles", &"FUSION_HINT_FIRE_MISSILES", ::should_break_use_mt_missiles );
    maps\_utility::add_control_based_hint_strings( "hint_mt_fire_missiles_release", &"FUSION_HINT_FIRE_MISSILES_RELEASE", ::should_break_release_mt_missiles );
    maps\_utility::add_control_based_hint_strings( "hint_use_sonar", &"FUSION_SONAR_HINT", maps\fusion_utility::should_end_sonar_hint );
    maps\_utility::add_control_based_hint_strings( "drone_deploy_prompt", &"FUSION_PROMPT_DEPLOY_DRONE", maps\fusion_utility::should_end_pdrone_hint );
    maps\_utility::add_control_based_hint_strings( "drone_deploy_fail_prompt", &"FUSION_PROMPT_DEPLOY_DRONE_FAIL", maps\fusion_utility::should_end_pdrone_fail_hint );
    maps\_utility::add_control_based_hint_strings( "hint_sonics", &"FUSION_SONICS_HINT", ::sonics_use_hint );
    maps\_utility::add_control_based_hint_strings( "hint_boost_slam", &"FUSION_BOOST_SLAM_HINT", ::boost_slam_use_hint, &"FUSION_BOOST_SLAM_HINT_PC" );
    thread maps\fusion_code::gameplay_setup();
    maps\fusion_vo::main();
    thread handle_objectives();
    thread boost_slam_hint();
    thread sonics_hint();
    level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player_rig hide();
    maps\_car_door_shield::init_door_shield();
    setdvarifuninitialized( "demo_itiot", 0 );
    var_0 = getent( "armapshade", "targetname" );
    var_0 _meth_83A7( 0.0, 0.0 );
    setup_portal_scripting();
    common_scripts\_pipes::main();

    if ( level.currentgen )
        _func_0D3( "ai_corpseCount", 8 );

    if ( level.currentgen )
    {
        _func_0D3( "r_gunSightColorEntityScale", "7" );
        _func_0D3( "r_gunSightColorNoneScale", "0.8" );
    }
}

setup_precache()
{
    precachemodel( "fus_cooling_tower_b_vista_dmg" );
    precachemodel( "fus_cooling_tower_collapse_chunks" );
    precachemodel( "fus_cooling_tower_collapse_concrete_shattered" );
    precachemodel( "fus_cooling_tower_collapse_concrete_shattered2" );
    precachemodel( "fus_cooling_tower_collapse_street_collapse" );
    precachemodel( "vehicle_xh9_warbird_cloaked" );
    precachemodel( "vehicle_mobile_cover" );
    precachemodel( "npc_zipline101ft" );
    precachemodel( "vehicle_ind_utility_tractor_01_dstrypv" );
    precachemodel( "fus_sever_debris" );
    precachemodel( "fus_sever_debris_02" );
    precachemodel( "fus_pipes_elec_set_01_piece_01" );
    precachemodel( "fus_end_scene_rubble" );
    precachemodel( "vb_pmc" );
    precachemodel( "vb_pmc_dismember" );
    precachemodel( "rubble_combo_01" );
    precachemodel( "rubble_rock_chunk_01" );
    precachemodel( "viewhands_s1_pmc" );
    precachemodel( "worldhands_s1_pmc" );
    precachemodel( "vehicle_mobile_cover_dstrypv" );
    precachemodel( "vehicle_xh9_warbird" );
    precachemodel( "fus_control_monitor_02_cinematic" );
    precacheshader( "cinematic" );
    precacheshellshock( "fusion_pre_collapse" );
    precacheshellshock( "fusion_collapse" );
    precacheshellshock( "slowview" );
    precacheshellshock( "fusion_slowview" );
    precacheshellshock( "zipline" );
    _func_07F();
    precachestring( &"FUSION_HINT_FIRE_GUN" );
    precachestring( &"FUSION_HINT_FIRE_MISSILES" );
    precachemodel( "ind_streetlight_single_off_rig" );
    precachemodel( "npc_m160" );
    precachemodel( "genericProp" );
    precachemodel( "fus_shelving_robot_01" );
    precachemodel( "fus_shelving_unit_cage_01" );
    precachemodel( "fus_shelving_unit_item_01" );
    precachemodel( "vehicle_v22_osprey_damaged_static_bladepiece_left" );
    precachemodel( "deployable_cover" );
    precachemodel( "fus_elevator_button_02" );
    precacheshader( "mtl_fus_elevator_button_02" );
    precachemodel( "door_double_01_rigged" );
    precachemodel( "furniture_metal_door02_handleright" );
    precachemodel( "furniture_metal_door02_handleright_destroyed" );
    precachemodel( "breach_door_metal_right" );
    precachemodel( "door_controlroom_01_rig" );
    precachemodel( "door_controlroom_01_damage_rig" );
    precacherumble( "steady_rumble" );
    precacherumble( "subtle_tank_rumble" );
    precacheshader( "dpad_icon_drone" );
    precacheshader( "dpad_icon_drone_off" );
    _func_081();

    if ( level.currentgen )
        precachemodel( "fus_tower_lower_panel_01_dark" );

    precacheitem( "iw5_ak12_sp" );
    precacheitem( "iw5_stingerm7_sp" );
    precacheitem( "iw5_bal27_sp_variablereddot" );
    precacheitem( "iw5_hmr9_sp" );
    animscripts\traverse\boost::precache_boost_fx_npc();
}

setup_start_points()
{
    maps\_utility::add_start( "fly_in_animated", ::start_intro_fly_in, "", ::intro_fly_in_animated );
    maps\_utility::add_start( "courtyard", ::start_courtyard, "", ::courtyard );
    maps\_utility::add_start( "security_room", ::start_security_room, "", undefined );
    maps\_utility::add_start( "lab", ::start_lab, "", undefined );
    maps\_utility::add_start( "reactor_room", ::start_reactor, "", undefined );
    maps\_utility::add_start( "reactor_room_exit", ::start_reactor_exit, "", undefined );
    maps\_utility::add_start( "turbine_room", ::start_turbine_room, "", undefined );
    maps\_utility::add_start( "control_room_entrance", ::start_control_room_entrance, "", undefined );
    maps\_utility::add_start( "control_room", ::start_control_room, "", undefined );
    maps\_utility::add_start( "control_room_exit", ::start_control_room_exit, "", ::control_room_exit );
    maps\_utility::add_start( "cooling_tower", ::start_cooling_tower, "", ::cooling_tower );

    if ( level.currentgen )
    {
        var_0 = [ "fusion_intro_tr" ];
        maps\_utility::set_start_transients( "fly_in_animated", var_0 );
        maps\_utility::set_start_transients( "courtyard", var_0 );
        maps\_utility::set_start_transients( "security_room", var_0 );
        var_0 = [ "fusion_middle_tr" ];
        maps\_utility::set_start_transients( "lab", var_0 );
        maps\_utility::set_start_transients( "reactor_room", var_0 );
        maps\_utility::set_start_transients( "reactor_room_exit", var_0 );
        var_0 = [ "fusion_outro_tr" ];
        maps\_utility::set_start_transients( "turbine_room", var_0 );
        maps\_utility::set_start_transients( "control_room_entrance", var_0 );
        maps\_utility::set_start_transients( "control_room", var_0 );
        maps\_utility::set_start_transients( "control_room_exit", var_0 );
        maps\_utility::set_start_transients( "cooling_tower", var_0 );
    }
}

init_level_flags()
{
    common_scripts\utility::flag_init( "intro_text_cinematic_over" );
    common_scripts\utility::flag_init( "intro_screen_done" );
    common_scripts\utility::flag_init( "flag_intro_objective_given" );
    common_scripts\utility::flag_init( "flag_show_boost_slam_hint" );
    common_scripts\utility::flag_init( "flag_show_sonic_hint" );
    common_scripts\utility::flag_init( "flag_player_used_boost_slam" );
    common_scripts\utility::flag_init( "flag_player_used_sonics" );
    common_scripts\utility::flag_init( "intro_squad_helis_start" );
    common_scripts\utility::flag_init( "start_heli_fly" );
    common_scripts\utility::flag_init( "ready_zip" );
    common_scripts\utility::flag_init( "flag_player_zip_started" );
    common_scripts\utility::flag_init( "flag_combat_zip_rooftop_start" );
    common_scripts\utility::flag_init( "flag_burke_zip" );
    common_scripts\utility::flag_init( "player_participated_in_rooftop_fight" );
    common_scripts\utility::flag_init( "flag_combat_zip_rooftop_complete" );
    common_scripts\utility::flag_init( "player_can_zip" );
    common_scripts\utility::flag_init( "street_combat_start" );
    common_scripts\utility::flag_init( "flag_rooftop_strafe" );
    common_scripts\utility::flag_init( "flag_player_cleared_rooftop" );
    common_scripts\utility::flag_init( "sun_shad_off_zip" );
    common_scripts\utility::flag_init( "player_fly_in_done" );
    common_scripts\utility::flag_init( "flag_mcd_vo_done" );
    common_scripts\utility::flag_init( "burke_fastzip_done" );
    common_scripts\utility::flag_init( "courtyard_start_lighting" );
    common_scripts\utility::flag_init( "flag_squad_heli_2_unload" );
    common_scripts\utility::flag_init( "flag_squad_heli_01_zip_complete" );
    common_scripts\utility::flag_init( "flag_rpg_at_heli" );
    common_scripts\utility::flag_init( "flag_player_enters_mobile_turret" );
    common_scripts\utility::flag_init( "flag_player_starts_entering_mobile_turret" );
    common_scripts\utility::flag_init( "flag_m_turret_dead" );
    common_scripts\utility::flag_init( "flag_walker_tank_on_mount" );
    common_scripts\utility::flag_init( "flag_player_picked_up_smaw" );
    common_scripts\utility::flag_init( "flag_launcher_out_of_ammo" );
    common_scripts\utility::flag_init( "flag_launcher_ammo_gathered" );
    common_scripts\utility::flag_init( "flag_walker_death_anim_start" );
    common_scripts\utility::flag_init( "flag_walker_destroyed" );
    common_scripts\utility::flag_init( "walker_trophy_1" );
    common_scripts\utility::flag_init( "walker_trophy_2" );
    common_scripts\utility::flag_init( "walker_damaged" );
    common_scripts\utility::flag_init( "security_room_player_start" );
    common_scripts\utility::flag_init( "lab_player_start" );
    common_scripts\utility::flag_init( "reactor_player_start" );
    common_scripts\utility::flag_init( "reactor_exit_player_start" );
    common_scripts\utility::flag_init( "joker_placing_turbine_elevator_cover" );
    common_scripts\utility::flag_init( "turbine_room_player_start" );
    common_scripts\utility::flag_init( "control_room_entrance_player_start" );
    common_scripts\utility::flag_init( "start_itiot" );
    common_scripts\utility::flag_init( "evacuation_started" );
    common_scripts\utility::flag_init( "flag_shut_down_reactor_failed" );
    common_scripts\utility::flag_init( "tower_debris" );
    common_scripts\utility::flag_init( "hangar_retreat_done" );
    common_scripts\utility::flag_init( "evacuation_first_drones_down" );
    common_scripts\utility::flag_init( "player_start_control_room" );
    common_scripts\utility::flag_init( "start_control_room_exit_lighting" );
    common_scripts\utility::flag_init( "cooling_tower_cart_explosion_lighting" );
    common_scripts\utility::flag_init( "player_start_cooling_tower" );
    common_scripts\utility::flag_init( "sun_shad_fly_in" );
    common_scripts\utility::flag_init( "tower_knockback" );
    common_scripts\utility::flag_init( "extraction_chopper_move_from_explosion" );
    common_scripts\utility::flag_init( "objective_on_extraction_chopper" );
    common_scripts\utility::flag_init( "off_fire_light" );
    common_scripts\utility::flag_init( "hangar_exit_explosion" );
    common_scripts\utility::flag_init( "mobile_turret_health_1" );
    common_scripts\utility::flag_init( "mobile_turret_health_2" );
    common_scripts\utility::flag_init( "mobile_turret_health_3" );
    common_scripts\utility::flag_init( "mobile_turret_health_4" );
    common_scripts\utility::flag_init( "play_ending" );
    common_scripts\utility::flag_init( "flag_hint_mt_control_fire_missiles_press" );
    common_scripts\utility::flag_init( "flag_reactor_room_combat_seek_player" );
    common_scripts\utility::flag_init( "flag_turbine_room_combat_seek_player" );
    common_scripts\utility::flag_init( "flag_autofocus_on" );
    common_scripts\utility::flag_init( "flag_anim_elevator_button_pressed" );
    common_scripts\utility::flag_init( "flag_end_sonar_vision" );
    common_scripts\utility::flag_init( "update_obj_pos_walker" );
    common_scripts\utility::flag_init( "update_obj_pos_security_entrance_1" );
    common_scripts\utility::flag_init( "update_obj_pos_security_entrance_2" );
    common_scripts\utility::flag_init( "update_obj_pos_security_elevator" );
    common_scripts\utility::flag_init( "update_obj_pos_elevator_descent" );
    common_scripts\utility::flag_init( "update_obj_pos_lab_follow_joker" );
    common_scripts\utility::flag_init( "update_obj_pos_lab_follow_burke" );
    common_scripts\utility::flag_init( "update_obj_pos_lab_follow_carter" );
    common_scripts\utility::flag_init( "update_obj_pos_reactor_1" );
    common_scripts\utility::flag_init( "update_obj_pos_turbine_elevator_button" );
    common_scripts\utility::flag_init( "update_obj_pos_turbine_elevator_ascent" );
    common_scripts\utility::flag_init( "update_obj_pos_turbine_room_1" );
    common_scripts\utility::flag_init( "update_obj_pos_control_room_door" );
    common_scripts\utility::flag_init( "update_obj_pos_control_room_explosion" );
    common_scripts\utility::flag_init( "update_obj_pos_control_room_console" );
    common_scripts\utility::flag_init( "update_obj_pos_control_room_using_console" );
    common_scripts\utility::flag_init( "update_obj_pos_control_room_exit_1" );
    common_scripts\utility::flag_init( "flag_road_combat_mid_save_1" );
    common_scripts\utility::flag_init( "flag_road_combat_mid_save_2" );
    common_scripts\utility::flag_init( "flag_turbine_combat_mid_save_1" );
    common_scripts\utility::flag_init( "reactor_room_combat_mid_save_1" );
    common_scripts\utility::flag_init( "player_drone_start" );
    common_scripts\utility::flag_init( "flag_player_using_drone" );
    common_scripts\utility::flag_init( "player_drone_attack_done" );
    common_scripts\utility::flag_init( "drone_deploy_prompt_displayed" );
    common_scripts\utility::flag_init( "turbine_room_all_enemies" );
    common_scripts\utility::flag_init( "flag_turbine_pdrone_combat_complete" );
    common_scripts\utility::flag_init( "player_is_in_turbine_room" );
    interior_init_level_flags();
}

interior_init_level_flags()
{
    common_scripts\utility::flag_init( "interior_allies" );
    common_scripts\utility::flag_init( "burke_facing_elevator" );
    common_scripts\utility::flag_init( "lab_cqb" );
    common_scripts\utility::flag_init( "start_lab_traversals" );
    common_scripts\utility::flag_init( "reactor_room_reveal_burke_ready" );
    common_scripts\utility::flag_init( "reactor_room_reveal_allies_advance" );
    common_scripts\utility::flag_init( "joker_place_elevator_cover" );
    common_scripts\utility::flag_init( "turbine_room_initial_combat_retreat" );
    common_scripts\utility::flag_init( "control_room_run_prep" );
    common_scripts\utility::flag_init( "control_room_explosion" );
    common_scripts\utility::flag_init( "control_room_player_start" );
    common_scripts\utility::flag_init( "control_room_console_enable" );
    common_scripts\utility::flag_init( "control_room_scene_ready" );
    common_scripts\utility::flag_init( "control_room_scene" );
    common_scripts\utility::flag_init( "shutdown_reactor_failed" );
    common_scripts\utility::flag_init( "vo_security_room_elevator_access" );
    common_scripts\utility::flag_init( "vo_security_room_elevator_open" );
    common_scripts\utility::flag_init( "vo_lab_elevator_slide_complete" );
    common_scripts\utility::flag_init( "vo_reactor_gogogo" );
    common_scripts\utility::flag_init( "vo_reactor_open_airlock" );
    common_scripts\utility::flag_init( "vo_reactor_entrance" );
    common_scripts\utility::flag_init( "vo_turbine_elevator_near" );
    common_scripts\utility::flag_init( "vo_turbine_elevator_ready" );
    common_scripts\utility::flag_init( "vo_turbine_elevator" );
    common_scripts\utility::flag_init( "vo_turbine_room_entrance" );
    common_scripts\utility::flag_init( "vo_turbine_explosion" );
    common_scripts\utility::flag_init( "vo_control_hall_door_stack" );
    common_scripts\utility::flag_init( "vo_control_hall_door_kicked" );
    common_scripts\utility::flag_init( "vo_control_room_explosion" );
    common_scripts\utility::flag_init( "vo_control_room_scene" );
}

should_break_use_mt_fire()
{
    if ( !isdefined( level.player.drivingvehicleandturret ) || level.player attackbuttonpressed() )
        return 1;

    return 0;
}

should_break_use_mt_missiles()
{
    if ( !isdefined( level.player.drivingvehicleandturret ) || level.player _meth_82EE() )
    {
        common_scripts\utility::flag_set( "flag_hint_mt_control_fire_missiles_press" );
        return 1;
    }

    return 0;
}

should_break_release_mt_missiles()
{
    if ( !isdefined( level.player.drivingvehicleandturret ) || !level.player _meth_82EE() )
    {
        if ( isdefined( level.player.drivingvehicleandturret ) )
            wait 1.0;

        return 1;
    }

    return 0;
}

start_intro_fly_in()
{
    setup_allies();
    wait(level.intro_hades_video_length);
    soundscripts\_snd::snd_message( "start_intro_fly_in" );
    soundscripts\_snd::snd_music_message( "mus_fusion_intro" );
}

intro_fly_in_animated()
{
    thread maps\fusion_code::show_hide_plant_vista_intro();
    thread maps\fusion_code::setup_ally_squad();
    thread maps\fusion_code::road_battle_setup();
    maps\fusion_code::fly_in_sequence();
}

start_intro_fly_in_part2()
{
    soundscripts\_snd::snd_message( "start_intro_fly_in_part2" );
    thread maps\fusion_code::setup_ally_squad();
    thread maps\fusion_code::road_battle_setup();
    common_scripts\utility::flag_set( "sun_shad_fly_in" );
    common_scripts\utility::flag_set( "intro_squad_helis_start" );
    level notify( "hatch_door_open" );
    thread maps\fusion_lighting::hatch_door_lightgrid_off();
    thread maps\fusion_lighting::fusion_intro_dof();
    thread maps\fusion_lighting::hatch_door_vision();
    thread maps\fusion_lighting::hatch_door_veil();
    thread maps\fusion_lighting::hatch_door_push_fog_out();
    thread maps\_utility::flag_set_delayed( "street_combat_start", 20 );
    thread maps\fusion_code::squad_heli_zip();
    thread maps\fusion_code::fly_in_ambient_heli_squad();
    level.warbird_a = maps\_vehicle::spawn_vehicle_from_targetname( "blackhawk" );
    level.warbird_a.animname = "warbird_a";
    level.warbird_a.no_anim_rotors = 1;
    maps\fusion_code::spawn_intro_heroes();
    maps\fusion_code::spawn_intro_pilots();
    var_0 = maps\fusion_code::spawn_player_anim_rig();
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player _meth_807D( var_0, "tag_player", 0.75, 50, 30, 15, 45, 1 );
    var_1 = common_scripts\utility::getstruct( "org_flyin", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( level.warbird_a, "fly_in_part2" );
    var_2 = [ var_0, level.burke, level.joker, level.carter, level.copilot_intro, level.pilot_intro ];
    level.warbird_a maps\_anim::anim_first_frame( var_2, "fly_in_part2", "tag_guy0" );

    foreach ( var_4 in var_2 )
        var_4 _meth_804D( level.warbird_a, "tag_guy0" );

    wait 2.5;
    thread maps\fusion_code::finish_fly_in_sequence( var_1, level.warbird_a, var_0 );
    wait 54;
    common_scripts\utility::flag_set( "flag_combat_zip_rooftop_start" );
    common_scripts\utility::flag_wait( "flag_combat_zip_rooftop_complete" );
    common_scripts\utility::flag_set( "ready_zip" );
    maps\_utility::activate_trigger_with_targetname( "trig_move_squad_from_heli" );
}

intro_fly_in_animated_part2()
{
    common_scripts\utility::flag_wait( "player_fly_in_done" );
    maps\_utility::delaythread( 3, maps\_utility::autosave_by_name );
}

start_courtyard()
{
    soundscripts\_snd::snd_message( "start_courtyard" );
    setup_allies( "checkpoint_courtyard" );
    maps\fusion_utility::teleport_to_scriptstruct( "checkpoint_courtyard" );
    level.carter maps\_utility::disable_ai_color();
    level.carter maps\fusion_utility::goto_node( "node_carter_zip_rally", 0 );
    thread maps\fusion_code::rooftop_slide();
    thread maps\fusion_code::allies_rally_init();
    thread maps\fusion_code::burke_rally_init();
    thread maps\fusion_code::setup_ally_squad();
    thread maps\fusion_code::road_battle_setup();
    thread maps\fusion_code::street_hanging_pipes_anim();
    thread maps\fusion_code::show_hide_plant_vista();
    thread maps\fusion_code::fly_in_ambient_street_jets();
    waittillframeend;
    common_scripts\utility::flag_set( "ready_zip" );
    common_scripts\utility::flag_set( "burke_fastzip_done" );
    common_scripts\utility::flag_set( "player_fly_in_done" );
    common_scripts\utility::flag_set( "flag_ambient_explosions_start" );
    common_scripts\utility::flag_set( "flag_player_zip_started" );
    common_scripts\utility::flag_set( "flag_rooftop_strafe" );
    common_scripts\utility::flag_set( "flag_player_cleared_rooftop" );
    common_scripts\utility::flag_set( "sun_shad_off_zip" );
    common_scripts\utility::flag_set( "street_combat_start" );
    common_scripts\utility::flag_set( "courtyard_start_lighting" );
}

courtyard()
{
    thread maps\fusion_code::courtyard_ambient_explosions();

    if ( level.nextgen )
        thread maps\fusion_code::evacuation_kiosk_movie();

    maps\fusion_code::enemy_walker();
    thread maps\fusion_code::demo_skip_forward();
    wait 0.05;
    maps\_utility::autosave_by_name();
}

start_security_room()
{
    soundscripts\_snd::snd_message( "start_security_room" );
    maps\_shg_utility::move_player_to_start( "security_room_player_start" );
    setup_allies( "security_room_player_start" );
    common_scripts\utility::flag_set( "security_room_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
}

start_lab()
{
    soundscripts\_snd::snd_message( "start_lab" );
    maps\_shg_utility::move_player_to_start( "lab_player_start" );
    common_scripts\utility::flag_set( "vo_lab_elevator_slide_complete" );
    setup_allies( "lab_player_start" );
    common_scripts\utility::flag_set( "lab_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
    common_scripts\utility::flag_set( "lab_cqb" );
    common_scripts\utility::flag_set( "start_lab_traversals" );
}

start_reactor()
{
    soundscripts\_snd::snd_message( "start_reactor" );
    maps\_shg_utility::move_player_to_start( "reactor_player_start" );
    setup_allies( "reactor_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
    common_scripts\utility::flag_set( "lab_cqb" );
    common_scripts\utility::flag_set( "reactor_player_start" );
    maps\_utility::activate_trigger_with_targetname( "airlock_color_trigger" );
}

start_reactor_exit()
{
    soundscripts\_snd::snd_message( "start_reactor_exit" );
    maps\_shg_utility::move_player_to_start( "reactor_exit_player_start" );
    setup_allies( "reactor_exit_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
    common_scripts\utility::flag_set( "reactor_exit_player_start" );
}

start_turbine_room()
{
    soundscripts\_snd::snd_message( "start_turbine_room" );
    maps\_shg_utility::move_player_to_start( "turbine_room_player_start" );
    setup_allies( "turbine_room_player_start" );
    level.turbine_room_elevator_ascent_time = 0;
    common_scripts\utility::flag_set( "interior_allies" );
    common_scripts\utility::flag_set( "elevator_ascend" );
    common_scripts\utility::flag_set( "turbine_room_player_start" );
    common_scripts\utility::flag_set( "turbine_elevator_enter" );
    common_scripts\utility::flag_set( "portal_on_turbine_room_flag" );
    wait 0.05;
    common_scripts\utility::flag_clear( "portal_on_turbine_room_flag" );
}

start_control_room_entrance()
{
    soundscripts\_snd::snd_message( "start_control_room_entrance" );
    maps\_shg_utility::move_player_to_start( "control_room_entrance_player_start" );
    common_scripts\utility::flag_set( "control_room_entrance_player_start" );
    setup_allies( "control_room_entrance_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
    common_scripts\utility::flag_set( "control_room_run_prep" );
    common_scripts\utility::flag_set( "control_room_run_approach" );
    maps\_utility::vision_set_fog_changes( "fusion_control_room_dark", 0.5 );
}

start_control_room()
{
    soundscripts\_snd::snd_message( "start_control_room" );
    maps\_shg_utility::move_player_to_start( "control_room_player_start" );
    common_scripts\utility::flag_set( "control_room_player_start" );
    setup_allies( "control_room_player_start" );
    common_scripts\utility::flag_set( "interior_allies" );
    maps\_utility::vision_set_fog_changes( "fusion_control_room_dark", 0.5 );
    _func_0D3( "r_disablelightsets", 0 );
    level.player _meth_83C0( "fusion_screen_control_room_lightset" );
    thread maps\fusion_code::control_room_scene_player( common_scripts\utility::getstruct( "control_room_burke_position", "targetname" ) );
    thread maps\fusion_code::control_room_scene();
    thread maps\fusion_code::control_room_screens();
    common_scripts\utility::flag_set( "control_room_explosion" );
    common_scripts\utility::flag_set( "control_room_console_enable" );
    common_scripts\utility::array_call( getentarray( "control_room_doors", "targetname" ), ::delete );
    var_0 = getent( "control_room_door_clip", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

start_control_room_exit()
{
    soundscripts\_snd::snd_message( "start_control_room_exit" );
    maps\_shg_utility::move_player_to_start( "itiot_player_start" );
    setup_allies( "itiot_player_start" );
    level.player setangles( level.player.angles + ( 7, 0, 0 ) );

    if ( level.nextgen )
        thread maps\fusion_code::evacuation_kiosk_movie();

    common_scripts\utility::flag_set( "flag_obj_01_pos_update_02" );
    common_scripts\utility::flag_set( "player_start_control_room" );
    common_scripts\utility::flag_set( "evacuation_started" );
    common_scripts\utility::flag_set( "start_control_room_exit_lighting" );
    common_scripts\utility::flag_set( "portal_on_control_room_flag" );
    wait 0.05;
    common_scripts\utility::flag_clear( "portal_on_control_room_flag" );
}

control_room_exit()
{
    common_scripts\utility::flag_wait( "flag_shut_down_reactor_failed" );
    soundscripts\_snd::snd_message( "start_pre_loading_bay" );
    common_scripts\utility::flag_set( "player_start_control_room" );
    thread maps\fusion_code::dialog_meltdown();
    thread maps\fusion_code::reaction_explosions();
    thread maps\fusion_code::reaction_ai();
    wait 0.5;
    thread maps\fusion_code::combat_hangar();
    maps\_utility::autosave_by_name();
}

start_cooling_tower()
{
    soundscripts\_snd::snd_message( "start_cooling_tower" );
    maps\_shg_utility::move_player_to_start();
    setup_allies( "cooling_tower_playerstart" );
    common_scripts\utility::flag_set( "player_start_cooling_tower" );
    common_scripts\utility::flag_set( "evacuation_started" );
    common_scripts\utility::flag_set( "show_collapse_tower" );
    common_scripts\utility::flag_set( "stop_ambient_explosions" );
    common_scripts\utility::flag_set( "ct_final_retreat" );
    getent( "retreat_gaz_01", "targetname" ) delete();
    thread maps\_utility::vision_set_fog_changes( "fusion_cooling_towers", 0 );
    thread maps\fusion_code::dialog_collapse();
    maps\_utility::activate_trigger_with_targetname( "allies_move_to_tower" );
}

cooling_tower()
{

}

setup_allies( var_0 )
{
    level.burke = getent( "hero_burke", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.burke.animname = "burke";
    level.joker = getent( "hero_joker", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.joker.animname = "joker";
    level.carter = getent( "hero_carter", "targetname" ) maps\_utility::spawn_ai( 1, 1 );
    level.carter.animname = "carter";

    if ( isdefined( var_0 ) )
    {
        var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

        if ( !isdefined( var_1 ) )
            var_1 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );

        level.burke maps\_utility::teleport_ent( var_1 );
        level.joker maps\_utility::teleport_ent( var_1 );
        level.carter maps\_utility::teleport_ent( var_1 );

        if ( var_0 == "lab_player_start" )
        {
            level.burke thread maps\fusion_code::laboratory_start_idle();
            level.joker thread maps\fusion_code::laboratory_start_idle();
            level.carter thread maps\fusion_code::laboratory_start_idle();
        }

        if ( var_0 == "reactor_player_start" )
        {
            level.burke maps\_utility::enable_cqbwalk();
            level.joker maps\_utility::enable_cqbwalk();
            level.carter maps\_utility::enable_cqbwalk();
            level.burke.moveplaybackrate = 1.1;
            level.joker.moveplaybackrate = 1.1;
            level.carter.moveplaybackrate = 1.1;
        }

        if ( var_0 != "turbine_room_player_start" && var_0 != "control_room_entrance_player_start" && var_0 != "control_room_player_start" && var_0 != "control_room_exit_player_start" && var_0 != "cooling_tower_player_start" )
            thread deployable_cover_think();

        if ( var_0 == "itiot_player_start" || var_0 == "cooling_tower_playerstart" )
        {
            level.burke maps\_utility::set_force_color( "r" );
            level.joker maps\_utility::set_force_color( "o" );
            level.carter maps\_utility::set_force_color( "o" );
            return;
        }
    }
    else
        thread deployable_cover_think();
}

deployable_cover_think()
{
    level.deployable_cover = spawn( "script_model", level.joker gettagorigin( "j_SpineUpper" ) + ( 0, 0, 0 ) );
    level.deployable_cover.angles = level.joker gettagangles( "j_SpineUpper" ) + ( 0, 0, 0 );
    level.deployable_cover.animname = "deployable_cover";
    level.deployable_cover _meth_80B1( "deployable_cover" );
    level.deployable_cover maps\_anim::setanimtree();
    level.deployable_cover maps\_anim::anim_first_frame_solo( level.deployable_cover, "deployable_cover_closed_idle" );
    level.deployable_cover _meth_804D( level.joker, "j_SpineUpper" );
    common_scripts\utility::flag_wait( "joker_placing_turbine_elevator_cover" );
    level.deployable_cover delete();
}

handle_objectives()
{
    waittillframeend;
    set_completed_objective_flags();
    maps\fusion_code::objectives();
}

boost_slam_hint()
{
    level endon( "flag_player_used_boost_slam" );
    thread boost_slam_use_monitor();
    common_scripts\utility::flag_wait( "flag_show_boost_slam_hint" );
    maps\_utility::hintdisplaymintimehandler( "hint_boost_slam", 5 );
}

boost_slam_use_monitor()
{
    level.player waittill( "ground_slam" );
    common_scripts\utility::flag_set( "flag_player_used_boost_slam" );
}

sonics_hint()
{
    level endon( "flag_player_used_sonics" );
    thread sonics_use_monitor();
    common_scripts\utility::flag_wait( "flag_show_sonic_hint" );
    level.burke maps\_utility::dialogue_queue( "fin_gdn_usesonics" );
    maps\_utility::hintdisplaymintimehandler( "hint_sonics", 5 );
}

sonics_use_monitor()
{
    level waittill( "SonicAoEStarted" );
    common_scripts\utility::flag_set( "flag_player_used_sonics" );
}

boost_slam_use_hint()
{
    if ( common_scripts\utility::flag( "flag_player_used_boost_slam" ) )
        return 1;
    else
        return 0;
}

sonics_use_hint()
{
    if ( common_scripts\utility::flag( "flag_player_used_sonics" ) )
        return 1;
    else
        return 0;
}

set_completed_objective_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "fly_in_animated" )
        return;

    common_scripts\utility::flag_set( "flag_intro_objective_given" );

    if ( var_0 == "fly_in_animated_part2" )
        return;

    if ( var_0 == "courtyard" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_walker" );
    common_scripts\utility::flag_set( "update_obj_pos_security_entrance_1" );
    common_scripts\utility::flag_set( "update_obj_pos_security_entrance_2" );

    if ( var_0 == "security_room" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_security_room" );
    common_scripts\utility::flag_set( "update_obj_pos_security_elevator_burke" );
    common_scripts\utility::flag_set( "update_obj_pos_security_elevator" );
    common_scripts\utility::flag_set( "update_obj_pos_elevator_descent" );
    common_scripts\utility::flag_set( "update_obj_pos_lab_follow_joker" );

    if ( var_0 == "lab" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_lab_follow_burke" );
    common_scripts\utility::flag_set( "update_obj_pos_lab_follow_carter" );

    if ( var_0 == "reactor_room" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_reactor_1" );
    common_scripts\utility::flag_set( "update_obj_pos_reactor_2" );
    common_scripts\utility::flag_set( "update_obj_pos_reactor_exit" );
    common_scripts\utility::flag_set( "update_obj_pos_reactor_storage_1" );
    common_scripts\utility::flag_set( "update_obj_pos_reactor_storage_2" );
    common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator" );

    if ( var_0 == "reactor_room_exit" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator_button" );
    common_scripts\utility::flag_set( "update_obj_pos_turbine_elevator_ascent" );

    if ( var_0 == "turbine_room" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_turbine_room_1" );
    common_scripts\utility::flag_set( "update_obj_pos_turbine_room_exit" );

    if ( var_0 == "control_room_entrance" )
        return;

    common_scripts\utility::flag_set( "update_obj_pos_control_room_door" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_explosion" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_console" );

    if ( var_0 == "control_room" )
        return;

    common_scripts\utility::flag_set( "flag_shut_down_reactor_failed" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_using_console" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_exit_1" );
    common_scripts\utility::flag_set( "update_obj_pos_control_room_exit_2" );
    common_scripts\utility::flag_set( "update_obj_pos_hangar_entrance" );

    if ( var_0 == "control_room_exit" )
        return;

    common_scripts\utility::flag_set( "flag_obj_02_pos_update_02" );
    common_scripts\utility::flag_set( "flag_obj_02_pos_update_03" );
    common_scripts\utility::flag_set( "objective_on_extraction_chopper" );

    if ( var_0 == "cooling_tower" )
        return;
}

setup_portal_scripting()
{
    thread handle_fusion_portal_groups_toggle( "portal_grp_reactor_room", "portal_on_reactor_room_flag", "portal_off_reactor_room_flag" );
    common_scripts\utility::flag_init( "portal_on_turbine_room_flag" );
    thread handle_fusion_portal_groups_on( "portal_grp_turbine_room", "portal_on_turbine_room_flag", "endPortalTurbineRoom", "turbine_room" );
    common_scripts\utility::flag_init( "portal_on_control_room_flag" );
    thread handle_fusion_portal_groups_toggle( "portal_grp_control_room", "portal_on_control_room_flag", "portal_off_control_room_flag" );
}

handle_fusion_portal_groups_on( var_0, var_1, var_2, var_3 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    if ( isdefined( var_2 ) && isstring( var_2 ) )
        level endon( var_2 );

    var_4 = getent( var_0, "targetname" );
    var_4 _meth_8070( 0 );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        var_4 _meth_8070( 1 );
        wait 0.05;

        if ( isdefined( var_2 ) )
            level notify( var_2 );
    }
}

handle_fusion_portal_groups_toggle( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    var_3 = getent( var_0, "targetname" );
    var_3 _meth_8070( 0 );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        var_3 _meth_8070( 1 );
        wait 0.05;
        common_scripts\utility::flag_wait( var_2 );
        var_3 _meth_8070( 0 );
        wait 0.05;
    }
}
