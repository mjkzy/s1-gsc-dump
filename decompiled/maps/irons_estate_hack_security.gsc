// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hack_security_start()
{
    level.start_point_scripted = "hack_security";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    var_0 = getentarray( "security_center_light", "targetname" );
    thread maps\irons_estate_code::security_center_lights( 1, var_0 );
    var_1 = getentarray( "security_center_light_hatch", "targetname" );
    thread maps\irons_estate_code::security_center_lights( 1, var_1 );
    var_2 = getentarray( "ac_unit_emissive", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );

    var_6 = getent( "security_center_ladder_light", "targetname" );
    var_6 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );
    var_7 = getentarray( "server_lights", "targetname" );

    foreach ( var_9 in var_7 )
        var_9 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );

    var_11 = getent( "security_center_hatch_window_cards", "targetname" );
    var_11 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );
    thread maps\irons_estate_security_center::security_center_fan_blades();
    common_scripts\utility::flag_set( "player_in_estate" );
    common_scripts\utility::flag_set( "security_center_guard_right" );
    common_scripts\utility::flag_set( "security_center_guard_left" );
    maps\irons_estate_code::security_center_player_rig_and_hatch_door_setup();
    thread maps\irons_estate_infil::poolhouse_enemies();
    thread maps\irons_estate_code::tennis_court_floor( 1 );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_top_kill_trigger" );
    soundscripts\_snd::snd_message( "start_hack_security" );
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    objective_add( maps\_utility::obj( "security_center" ), "current", &"IRONS_ESTATE_OBJ_SECURITY_CENTER" );
}

hack_security_main()
{
    level.start_point_scripted = "hack_security";
    common_scripts\utility::flag_set( "hack_security_begin" );
    thread hack_security_begin();
    common_scripts\utility::flag_wait( "hack_security_end" );
    maps\_utility::autosave_stealth();
}

handprint_fx_test()
{
    wait 1;
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );

    if ( level.player _meth_817C() != "stand" )
        level.player _meth_817D( "stand" );

    level.player _meth_8119( 0 );
    level.player _meth_831D();
    level.security_center_anim_struct maps\_anim::anim_first_frame_solo( level.player_rig, "handprint" );
    level.player _meth_8080( level.player_rig, "tag_player", 0.6 );
    level.security_center_anim_struct thread maps\_anim::anim_single_solo( level.player_rig, "handprint" );
    wait 0.6;
    level.player_rig show();
    level.player_rig waittillmatch( "single anim", "print_on" );
    thread handprint_on_fx();
    wait 0.4;
    maps\_anim::anim_set_rate_single( level.player_rig, "handprint", 0 );
}

handprint_on_fx()
{
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_thumb_print", "j_thumb_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_index_print", "j_index_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_middle_print", "j_mid_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_ring_print", "j_ring_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_pinky_print", "j_pinky_le_2" );
    playfxontag( level._effect["ie_hand_palm"], level.player_rig, "TAG_FX_PALM" );
    wait 0.1;
    playfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_1" );
    playfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_1" );
    playfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_1" );
    playfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_1" );
    playfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_1" );
    playfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_2" );
}

hack_security_begin()
{
    common_scripts\utility::flag_init( "handprint_ready" );
    common_scripts\utility::flag_init( "computer_vo" );
    common_scripts\utility::flag_init( "security_center_exit" );
    common_scripts\utility::flag_init( "security_center_exit_complete" );
    level.player.grapple["dist_max"] = 800;
    thread handle_hack_security();
    thread hack_security_vo();
    common_scripts\utility::flag_wait( "player_is_out_of_security_center" );
    thread maps\irons_estate_civilians::ie_west_civilian_vignettes();
    thread maps\irons_estate_penthouse::ie_west_enemies();
    thread maps\irons_estate_penthouse::guesthouse_enemies();
}

#using_animtree("player");

handle_hack_security()
{
    var_0 = common_scripts\utility::getstruct( "hack_security_obj", "targetname" );
    var_1 = common_scripts\utility::getstruct( "security_center_desk_xprompt", "targetname" );
    _func_0D3( "objectiveHide", 0 );
    objective_position( maps\_utility::obj( "security_center" ), var_1.origin );
    objective_setpointertextoverride( maps\_utility::obj( "security_center" ), &"IRONS_ESTATE_USE" );
    thread maps\irons_estate_code::handle_objective_marker( var_1, var_0, "handprint_start", 50 );
    common_scripts\utility::flag_wait( "handprint_ready" );
    var_2 = getent( "hack_security_trigger", "targetname" );
    var_2 thread maps\_utility::addhinttrigger( &"IRONS_ESTATE_ACCESS_SECURITY", &"IRONS_ESTATE_ACCESS_SECURITY_PC" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_2, var_1, cos( 20 ), 0, 1 );
    common_scripts\utility::flag_set( "handprint_start" );
    objective_setpointertextoverride( maps\_utility::obj( "security_center" ), "" );
    _func_0D3( "objectiveHide", 1 );
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );

    if ( level.player _meth_817C() != "stand" )
        level.player _meth_817D( "stand" );

    level.player _meth_8119( 0 );
    level.player _meth_831D();
    level.security_center_anim_struct maps\_anim::anim_first_frame_solo( level.player_rig, "handprint" );
    level.player _meth_8080( level.player_rig, "tag_player", 0.6 );
    level.security_center_anim_struct thread maps\_anim::anim_single_solo( level.player_rig, "handprint" );
    wait 0.6;
    level.player _meth_807D( level.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    level.player_rig show();
    level.player_rig waittillmatch( "single anim", "print_on" );
    level notify( "handprint_on" );
    thread handprint_on();
    wait 1.5;
    level.player _meth_80A2( 0.2, 0, 0, 10, 10, 10, 10 );
    common_scripts\utility::flag_set( "computer_vo" );
    wait 1;
    level.player _meth_80AD( "light_1s" );
    wait 6;
    level notify( "start_camera_vo" );
    wait 2;
    level notify( "security_center_table_bink_done" );
    level.player_rig waittillmatch( "single anim", "end" );
    level.player_rig hide();
    level.player _meth_804F();
    level.player freezecontrols( 0 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_831E();
    common_scripts\utility::flag_set( "security_center_hack_complete" );
    thread server_lights_setup();
    thread maps\irons_estate_fx::drone_holo_on();
    common_scripts\utility::flag_wait( "security_center_exit" );
    var_3 = common_scripts\utility::getstruct( "security_center_exit_grapple_magnet_struct", "targetname" );
    var_4 = var_3 common_scripts\utility::spawn_tag_origin();
    maps\_grapple::grapple_magnet_register( var_4, "tag_origin", ( 0, 0, 0 ), undefined, undefined, undefined, %ie_sec_center_exit_player );
    thread security_center_exit();
    common_scripts\utility::flag_wait( "security_center_exit" );
    common_scripts\utility::flag_set( "ie_west_driveway_trees" );
    maps\_utility::autosave_stealth();
    var_5 = common_scripts\utility::getstruct( "security_center_exit_grapple_magnet_struct", "targetname" );
    objective_position( maps\_utility::obj( "security_center" ), var_5.origin );
    _func_0D3( "objectiveHide", 0 );
    var_6 = 15;
    thread maps\irons_estate_code::timer( var_6, undefined, "player_is_out_of_security_center", &"IRONS_ESTATE_SECURITY_TIMER" );
    thread timer_fail( var_6, var_4 );
    soundscripts\_snd::snd_message( "aud_security_countdown" );
    thread security_center_drones_turn_on_setup();
    common_scripts\utility::flag_wait( "player_is_exiting_security_center" );
    maps\_utility::objective_complete( maps\_utility::obj( "security_center" ) );
    common_scripts\utility::flag_wait( "player_is_out_of_security_center" );
}

handprint_on()
{
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_thumb_print", "j_thumb_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_index_print", "j_index_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_middle_print", "j_mid_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_ring_print", "j_ring_le_2" );
    level.player_rig attach( "viewhands_sentinel_udt_mitchell_pinky_print", "j_pinky_le_2" );
    playfxontag( level._effect["ie_hand_palm"], level.player_rig, "TAG_FX_PALM" );
    wait 0.1;
    playfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_1" );
    playfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_1" );
    playfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_1" );
    playfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_1" );
    playfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_2" );
    waitframe();
    playfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_1" );
    playfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_2" );
    wait 0.4;
    level.player_rig thread finger_material_swap( "mtl_vm_sentinel_udt_thumb" );
    level.player_rig thread finger_material_swap( "mtl_vm_sentinel_udt_index" );
    level.player_rig thread finger_material_swap( "mtl_vm_sentinel_udt_middle" );
    level.player_rig thread finger_material_swap( "mtl_vm_sentinel_udt_ring" );
    level.player_rig thread finger_material_swap( "mtl_vm_sentinel_udt_pinky" );
    wait 1;
    stopfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_1" );
    stopfxontag( level._effect["ie_hand_thumb"], level.player_rig, "TAG_FX_THUMB_2" );
    waitframe();
    stopfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_1" );
    stopfxontag( level._effect["ie_hand_fore"], level.player_rig, "TAG_FX_INDEX_2" );
    waitframe();
    stopfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_1" );
    stopfxontag( level._effect["ie_hand_middle"], level.player_rig, "TAG_FX_MID_2" );
    waitframe();
    stopfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_1" );
    stopfxontag( level._effect["ie_hand_ring"], level.player_rig, "TAG_FX_RING_2" );
    waitframe();
    stopfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_1" );
    stopfxontag( level._effect["ie_hand_pinky"], level.player_rig, "TAG_FX_PINKY_2" );
    waitframe();
    stopfxontag( level._effect["ie_hand_palm"], level.player_rig, "TAG_FX_PALM" );
    wait 1;
    level.player_rig detach( "viewhands_sentinel_udt_mitchell_thumb_print", "j_thumb_le_2" );
    level.player_rig detach( "viewhands_sentinel_udt_mitchell_index_print", "j_index_le_2" );
    level.player_rig detach( "viewhands_sentinel_udt_mitchell_middle_print", "j_mid_le_2" );
    level.player_rig detach( "viewhands_sentinel_udt_mitchell_ring_print", "j_ring_le_2" );
    level.player_rig detach( "viewhands_sentinel_udt_mitchell_pinky_print", "j_pinky_le_2" );
}

finger_material_swap( var_0 )
{
    wait(randomfloatrange( 0.1, 0.5 ));

    if ( level.nextgen )
    {
        self _meth_846C( var_0, "m/mtl_base_fingerprint_01" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_02" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_03" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_04" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_05" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_06" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_07" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_08" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_09" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_10" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_11" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "m/mtl_base_fingerprint_12" );
    }
    else
    {
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_01" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_02" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_03" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_04" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_05" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_06" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_07" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_08" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_09" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_10" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_11" );
        wait(randomfloatrange( 0.05, 0.1 ));
        self _meth_846C( var_0, "mq/mtl_base_fingerprint_12" );
    }
}

server_lights_setup()
{
    thread server_lights();
    waitframe();
    var_0 = common_scripts\utility::getstructarray( "server_lookat_struct", "targetname" );
    common_scripts\utility::array_thread( var_0, ::player_looking_at_object, "player_sees_server" );
}

server_lights()
{
    var_0 = common_scripts\utility::getstructarray( "server_lookat_struct", "targetname" );
    level common_scripts\utility::waittill_notify_or_timeout( "player_sees_server", 20 );
    wait(randomfloatrange( 0.3, 0.75 ));
    var_1 = getentarray( "server_lights_group_1", "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 security_center_server_lights();

    wait(randomfloatrange( 0.3, 0.75 ));
    var_5 = getentarray( "server_lights_group_2", "script_noteworthy" );

    foreach ( var_3 in var_5 )
        var_3 security_center_server_lights();

    wait(randomfloatrange( 0.3, 0.75 ));
    var_8 = getentarray( "server_lights_group_3", "script_noteworthy" );

    foreach ( var_3 in var_8 )
        var_3 security_center_server_lights();

    wait(randomfloatrange( 0.3, 0.75 ));
    var_11 = getentarray( "server_lights_group_4", "script_noteworthy" );

    foreach ( var_3 in var_11 )
        var_3 security_center_server_lights();
}

security_center_server_lights()
{
    thread maps\irons_estate_code::security_center_script_brushmodels();
}

timer_fail( var_0, var_1 )
{
    wait(var_0);

    if ( !common_scripts\utility::flag( "player_is_exiting_security_center" ) )
    {
        maps\_grapple::grapple_magnet_unregister( var_1, "tag_origin" );
        _func_0D3( "objectiveHide", 1 );
        level.hatch_door_middle thread maps\_anim::anim_single_solo( level.hatch_door_middle, "hatch_close" );
        waitframe();
        maps\_anim::anim_set_rate_single( level.hatch_door_middle, "hatch_close", 0.25 );
        maps\_utility::smart_radio_dialogue( "ie_nox_gotmitchell" );
        maps\_player_death::set_deadquote( &"IRONS_ESTATE_SECURITY_CENTER_ESCAPE_FAIL" );
        thread maps\_utility::missionfailedwrapper();
    }
}

security_center_exit()
{
    level.player waittill( "grapple_land_anim" );
    common_scripts\utility::flag_set( "player_is_exiting_security_center" );
    soundscripts\_snd::snd_message( "aud_security_hatch_exit" );
    level.player _meth_831D();
    var_0 = getentarray( "security_center_light", "targetname" );
    thread maps\irons_estate_code::security_center_lights( undefined, var_0, 50 );
    var_1 = getentarray( "security_center_light_hatch", "targetname" );
    thread maps\irons_estate_code::security_center_lights( undefined, var_1, 8000 );
    var_2 = getentarray( "ac_unit_emissive", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 thread maps\irons_estate_code::security_center_script_brushmodels();

    var_6 = getent( "security_center_ladder_light", "targetname" );
    var_6 thread maps\irons_estate_code::security_center_script_brushmodels();

    while ( level.player.grapple["ready_weapon"] == 1 )
        wait 0.05;

    common_scripts\utility::flag_set( "player_is_out_of_security_center" );
    var_7 = getent( "security_center_hatch_window_cards", "targetname" );
    var_7 thread maps\irons_estate_code::security_center_script_brushmodels();
    level.hatch_door_middle thread maps\_anim::anim_single_solo( level.hatch_door_middle, "hatch_close" );
    common_scripts\_exploder::exploder( 6611 );
    level.player _meth_831E();
    level.player maps\_tagging::tagging_set_enabled( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 1 );
    level.player_rig delete();
    common_scripts\utility::flag_set( "security_center_exit_complete" );
}

security_center_drones_turn_on_setup()
{
    thread security_center_drones_turn_on();
    waitframe();
    var_0 = getentarray( "security_center_drone", "targetname" );
    common_scripts\utility::array_thread( var_0, ::player_looking_at_object, "player_sees_drones" );
}

security_center_drones_turn_on()
{
    var_0 = getentarray( "security_center_drone", "targetname" );
    level common_scripts\utility::waittill_notify_or_timeout( "player_sees_drones", 10 );
    soundscripts\_snd::snd_message( "aud_security_center_drones_on" );

    foreach ( var_2 in var_0 )
        var_2 thread security_center_drones_turn_on_internal();

    common_scripts\utility::flag_wait( "player_enters_front_yard_save_1" );

    foreach ( var_2 in var_0 )
    {
        stopfxontag( level._effect["ie_drone_eye_emissive_bootup"], var_2, "tag_main_camera" );

        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

security_center_drones_turn_on_internal()
{
    wait(randomfloatrange( 1, 4 ));
    playfxontag( level._effect["ie_drone_eye_emissive_bootup"], self, "tag_main_camera" );
    soundscripts\_snd_playsound::snd_play_linked( "irons_security_drone_eye_wakeup" );
}

player_looking_at_object( var_0 )
{
    level endon( var_0 );
    level endon( "security_center_exit_complete" );

    for (;;)
    {
        if ( maps\_utility::within_fov_2d( level.player.origin, level.player.angles, self.origin, cos( 45 ) ) )
            level notify( var_0 );

        wait 0.05;
    }
}

hack_security_vo()
{
    common_scripts\utility::flag_wait( "handprint_vo" );
    maps\_utility::smart_radio_dialogue( "ie_nox_worthprice" );
    common_scripts\utility::flag_set( "handprint_ready" );
    common_scripts\utility::flag_wait( "handprint_start" );
    soundscripts\_snd::snd_message( "aud_security_prints" );
    maps\_utility::smart_radio_dialogue( "ie_nox_uploadingprints" );
    common_scripts\utility::flag_wait( "computer_vo" );
    soundscripts\_snd::snd_message( "aud_security_welcome" );
    level waittill( "start_camera_vo" );
    maps\_utility::smart_radio_dialogue( "ie_nox_imin3" );
    maps\_utility::smart_radio_dialogue( "ie_nox_cameras" );
    soundscripts\_snd::snd_message( "aud_security_reboot" );
    wait 1.5;
    maps\_utility::smart_radio_dialogue( "ie_nox_backonline" );
    common_scripts\utility::flag_set( "security_center_exit" );
    wait 1;

    if ( !common_scripts\utility::flag( "player_is_exiting_security_center" ) )
    {
        wait 2;
        thread maps\_utility::smart_radio_dialogue( "ie_nox_backtoroof" );
    }

    common_scripts\utility::flag_wait( "security_center_exit_complete" );
    maps\_utility::smart_radio_dialogue( "ie_nox_patchedin" );
    maps\_utility::smart_radio_dialogue( "ie_crmk_sniffirons" );
    common_scripts\utility::flag_set( "hack_security_end" );
}
