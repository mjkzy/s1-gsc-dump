// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

intel_start()
{
    level.start_point_scripted = "intel";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();

    if ( !isdefined( level.meet_cormack_kill_org ) )
        level.meet_cormack_kill_org = common_scripts\utility::getstruct( "meet_cormack_kill_org", "targetname" );

    thread setup_intel_player( 1 );
    thread vo_test();
    thread temp_bink_stuff();
    soundscripts\_snd::snd_message( "start_intel" );
}

intel_main()
{
    level.start_point_scripted = "intel";
    common_scripts\utility::flag_set( "intel_begin" );
    thread intel_begin();
    common_scripts\utility::flag_wait( "intel_end" );
    maps\_utility::delaythread( 1, maps\_utility::autosave_by_name );
}

intel_begin()
{
    maps\irons_estate_code::irons_estate_stealth_disable();
    thread setup_intel_main();
}

setup_intel_main()
{
    if ( !isdefined( level.meet_cormack_kill_org ) )
        level.meet_cormack_kill_org = common_scripts\utility::getstruct( "meet_cormack_kill_org", "targetname" );

    thread setup_intel_cormack();
}

setup_intel_cormack()
{
    level endon( "player_used_intel_trigger" );

    if ( common_scripts\utility::flag( "player_used_intel_trigger" ) )
        return;

    level.meet_cormack_kill_org thread maps\_anim::anim_loop_solo( level.allies[0], "pent_desk_idle", "stop_pent_desk_idle" );
}

cormack_anim_rate_change( var_0, var_1 )
{
    wait 0.05;
    var_0 = level.allies[0] maps\_utility::getanim( var_0 );
    level.allies[0] _meth_83C7( var_0, var_1 );
}

setup_intel_player( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "intel_obj_xprompt", "targetname" );
    level.intel_player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.intel_player_rig hide();
    thread hack_device_setup();
    level.meet_cormack_kill_org maps\_anim::anim_first_frame_solo( level.intel_player_rig, "pent_desk" );

    if ( !isdefined( var_0 ) )
        level.allies[0] waittillmatch( "single anim", "desk_player" );

    objective_add( maps\_utility::obj( "intel" ), "current", &"IRONS_ESTATE_OBJ_INTEL" );
    objective_setpointertextoverride( maps\_utility::obj( "intel" ), &"IRONS_ESTATE_USE" );
    objective_position( maps\_utility::obj( "intel" ), var_1.origin );
    level.gather_intel_trigger = getent( "gather_intel_trigger", "targetname" );
    level.gather_intel_trigger thread maps\_utility::addhinttrigger( &"IRONS_ESTATE_INTEL", &"IRONS_ESTATE_INTEL_PC" );
    thread maps\irons_estate_code::handle_objective_marker( var_1, var_1, "player_used_intel_trigger", 60 );
    level.gather_intel_trigger waittill( "trigger" );
    soundscripts\_snd::snd_message( "aud_intel" );
    objective_position( maps\_utility::obj( "intel" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_set( "player_used_intel_trigger" );
    _func_0D3( "objectiveHide", 1 );
    level.gather_intel_trigger delete();
    thread right_tap_monitor();
    thread right_swipe_monitor();
    thread left_tap_monitor();
    thread left_swipe_monitor();
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player _meth_831D();
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    level.player _meth_84BF();
    level.player _meth_831F();
    level.player _meth_817D( "stand" );
    level.meet_cormack_kill_org notify( "stop_pent_desk_idle" );
    wait 0.05;
    level.player _meth_8080( level.intel_player_rig, "tag_player", 0.6 );
    level.meet_cormack_kill_org thread maps\_anim::anim_single( [ level.intel_player_rig, level.allies[0] ], "pent_desk" );
    wait 0.6;
    var_2 = level.player _meth_8311();
    var_3 = level.player _meth_830B();
    level.player _meth_8310();

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) && var_5 == "iw5_kf5singleshot_sp_opticsreddot_silencer01" )
            level.player _meth_830E( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );

        if ( isdefined( var_5 ) && var_5 == "iw5_sn6_sp_opticsreddot_silencer01" )
            level.player _meth_830E( "iw5_sn6_sp_opticsreddot_silencer01" );

        if ( isdefined( var_5 ) && var_5 == "iw5_pbwsingleshot_sp_silencerpistol" )
            level.player _meth_830E( "iw5_pbwsingleshot_sp_silencerpistol" );
    }

    if ( isdefined( var_2 ) && var_2 == "iw5_kf5singleshot_sp_opticsreddot_silencer01" )
        level.player _meth_8315( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
    else if ( isdefined( var_2 ) && var_2 == "iw5_sn6_sp_opticsreddot_silencer01" || var_2 == "iw5_pbwsingleshot_sp_silencerpistol" )
        level.player _meth_8315( "iw5_sn6_sp_opticsreddot_silencer01" );

    level.player _meth_807D( level.intel_player_rig, "tag_player", 1.0, 10, 10, 5, 5, 1 );
    level.hack_device show();
    level.intel_player_rig show();
    level.intel_player_rig waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "player_finished_desk_anim" );
    level.player _meth_804F();
    level.player _meth_831E();
    level.player freezecontrols( 0 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 1 );
    level.player maps\_tagging::tagging_set_enabled( 1 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_811A( 1 );
    level.intel_player_rig delete();
    thread maps\irons_estate_meet_cormack_pt2::elevator_top_enemies_setup();
}

hack_device_setup()
{
    level.hack_device = spawn( "script_model", ( 0, 0, 0 ) );
    level.hack_device _meth_80B1( "base_hack_device_01" );
    level.hack_device _meth_804D( level.intel_player_rig, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.hack_device hide();
    level.intel_player_rig waittillmatch( "single anim", "drop_device" );
    level.hack_device _meth_804F();
    level.intel_player_rig waittillmatch( "single anim", "pick_up_device" );
    level.hack_device _meth_804D( level.intel_player_rig, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.intel_player_rig waittillmatch( "single anim", "end" );

    if ( isdefined( level.hack_device ) )
        level.hack_device delete();
}

vo_test()
{
    common_scripts\utility::flag_wait( "player_used_intel_trigger" );
    level.allies[0] waittillmatch( "single anim", "sd_ie_crmk_damnit3" );
    soundscripts\_snd::snd_message( "aud_lockdown_alarm" );
    level.allies[0] waittillmatch( "single anim", "end" );
    objective_state_nomessage( maps\_utility::obj( "intel" ), "done" );
    _func_0D3( "objectiveHide", 0 );
    common_scripts\utility::flag_set( "intel_end" );
}

temp_bink_stuff()
{
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_0D3( "cg_cinematicCanPause", "1" );
    _func_057( "ie_penthouse_desk", 1 );
    level.intel_player_rig waittillmatch( "single anim", "bink_start" );
    pausecinematicingame( 0 );

    while ( _func_05B() )
        wait 0.05;

    _func_0D3( "cg_cinematicCanPause", "0" );
    _func_0D3( "cg_cinematicFullScreen", "1" );
}

right_tap_monitor()
{
    level endon( "player_finished_desk_anim" );

    for (;;)
    {
        level.intel_player_rig waittillmatch( "single anim", "right_tap" );
        playrumbleonposition( "ie_desk_right_tap", level.intel_player_rig gettagorigin( "tag_weapon_left" ) );
    }
}

right_swipe_monitor()
{
    level endon( "player_finished_desk_anim" );

    for (;;)
    {
        level.intel_player_rig waittillmatch( "single anim", "right_swipe" );
        playrumbleonposition( "ie_desk_right_swipe", level.intel_player_rig gettagorigin( "tag_weapon_left" ) );
    }
}

left_tap_monitor()
{
    level endon( "player_finished_desk_anim" );

    for (;;)
    {
        level.intel_player_rig waittillmatch( "single anim", "left_tap" );
        playrumbleonposition( "ie_desk_left_tap", level.intel_player_rig gettagorigin( "tag_weapon_right" ) );
    }
}

left_swipe_monitor()
{
    level endon( "player_finished_desk_anim" );

    for (;;)
    {
        level.intel_player_rig waittillmatch( "single anim", "left_swipe" );
        playrumbleonposition( "ie_desk_left_swipe", level.intel_player_rig gettagorigin( "tag_weapon_right" ) );
    }
}
