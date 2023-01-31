// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_vtol_takedown()
{
    thread maps\crash_warbird_missile_defense::missile_defense_precache();
    common_scripts\utility::flag_init( "vtol_takedown_done" );
    common_scripts\utility::flag_init( "start_gideon_wave_anim" );
    common_scripts\utility::flag_init( "ready_for_vtol" );
    common_scripts\utility::flag_init( "gideon_intro_done" );
    common_scripts\utility::flag_init( "cormack_start_vtol" );
    common_scripts\utility::flag_init( "cormack_fires_stinger" );
    common_scripts\utility::flag_init( "cormack_fires_stinger_failsafe" );
    common_scripts\utility::flag_init( "vtol_can_lock_on" );
    common_scripts\utility::flag_init( "vtol_hit_early" );
    common_scripts\utility::flag_init( "vtol_hit_mid" );
    common_scripts\utility::flag_init( "vtol_hit_late" );
    common_scripts\utility::flag_init( "start_gideons_animation" );
    common_scripts\utility::flag_init( "cormack_missile_1_hit" );
    common_scripts\utility::flag_init( "missiles_hit_vtol" );
    common_scripts\utility::flag_init( "end_vtol_dying" );
    common_scripts\utility::flag_init( "player_stinger_fired" );
    common_scripts\utility::flag_init( "player_stinger_hit" );
    common_scripts\utility::flag_init( "vo_heat_line" );
    common_scripts\utility::flag_init( "vo_bringitdown_line" );
    common_scripts\utility::flag_init( "vtol_hit_mountain" );
    common_scripts\utility::flag_init( "player_bottom_of_hill" );
    common_scripts\utility::flag_init( "vtol_done_sliding" );
    common_scripts\utility::flag_init( "cargo_trigger" );
    common_scripts\utility::flag_init( "kill_sliding_anims" );
    common_scripts\utility::flag_init( "start_exfil" );
    common_scripts\utility::flag_init( "start_gideon_exfil" );
    common_scripts\utility::flag_init( "start_vtol_exfil" );
    common_scripts\utility::flag_init( "player_getting_in_end_chopper" );
    common_scripts\utility::flag_init( "vo_cormack_exfil1" );
    common_scripts\utility::flag_init( "vo_cormack_exfil2" );
    common_scripts\utility::flag_init( "vo_kingpin_exfil" );
    common_scripts\utility::flag_init( "failed_cargo_grab" );
    common_scripts\utility::flag_init( "gideon_boost_jump" );
    common_scripts\utility::flag_init( "player_exfil_success" );
    common_scripts\utility::flag_init( "exfil_fail" );
    precacherumble( "hijack_plane_medium" );
    precacheitem( "iw5_stingerm7fastprojectile_sp" );
    precacheitem( "turretheadmg_sp" );
    precachemodel( "genericprop_x5" );
    precachemodel( "atlas_stabilize_vial_static" );
    precachemodel( "atlas_stabilize_crate" );
    precachemodel( "vehicle_xh9_warbird_pulley" );
    precachemodel( "projectile_stinger_missile" );
    precacheshader( "m/mtl_xh9_warbird_main_destroy" );
    precacheshader( "m/mtl_xh9_warbird_main_02_destroy" );
    precacheshader( "m/mtl_xh9_warbird_windows_out_destroy" );
    precachestring( &"CRASH_HINT_STINGER" );
    precachestring( &"CRASH_HINT_STINGER_KEYBOARD" );
    precachestring( &"CRASH_CARGO_GRAB" );
    precachestring( &"CRASH_CARGO_GRAB_KEYBOARD" );
    precachestring( &"CRASH_HINT_EXFIL_JUMP" );
    maps\_utility::add_control_based_hint_strings( "end_jump", &"CRASH_HINT_BOOST_JUMP", ::should_break_end_jump_hint );
    var_0 = getentarray( "vtol_fail_triggers", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    level.end_crate = getent( "end_vtol_crate", "targetname" );
    level.end_crate hide();
    level.end_crate_clip = getent( "end_vtol_crate_clip", "targetname" );
    level.end_crate_clip hide();
    level.end_cables = getent( "end_vtol_cables", "targetname" );
    level.end_cables hide();
}

debug_start_vtol_takedown()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_vtol_takedown" );
    setsunflareposition( ( -10.39, -112.7, 0 ) );
    level.player _meth_83C0( "crash_avalanche", 0 );
    level.player _meth_8490( "clut_crash_crash_site", 2 );
    maps\_utility::vision_set_fog_changes( "crash_avalanche", 0 );
    _func_0D3( "r_dof_physical_enable", 1 );
    _func_0D3( "r_dof_physical_bokehenable", 1 );
    _func_0D3( "r_dof_physical_hipenable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 3.2 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.07 );
    thread dead_stinger_guy();
    thread vtol_takedown_gideon();
    thread vtol_takedown_cormack();
    thread vtol_takedown_cormack_stinger();
    thread vtol_takedown_ilona();
    thread maps\crash::objective_init();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    level.cormack maps\_utility::disable_ai_color();
    level.cormack.ignoreall = 1;
    level.cormack.ignoreme = 1;
    thread maps\crash_utility::cormack_helmet_open( level.cormack );
    level.ilana maps\_utility::disable_ai_color();
    level.ilana.ignoreall = 1;
    level.ilana.ignoreme = 1;
    level.gideon maps\_utility::disable_ai_color();
    level.gideon.ignoreall = 1;
    level.gideon.ignoreme = 1;
    common_scripts\_exploder::exploder( 1999 );
}

begin_vtol_takedown()
{
    thread vtol_takedown_gun_pickup();
    waitframe();
    thread vtol_takedown_dialogue();
    thread vtol_takedown_failure();
    thread vtol_takedown_chopper();
    level.player thread maps\crash_utility::exo_temp_outdoor();
    thread avalanche_falling_death();
    common_scripts\utility::flag_wait( "vtol_takedown_done" );
    level.player thread maps\_hud_util::fade_out( 3 );
    wait 5;
    maps\_utility::nextmission();
}

dead_stinger_guy()
{
    var_0 = common_scripts\utility::getstruct( "vtol_dead_guy", "targetname" );
    var_1 = maps\_utility::spawn_targetname( "vtol_dead_sentinel", 1 );
    var_1.animname = "generic";
    var_1 maps\_utility::set_ignoreall( 1 );
    var_1 maps\_utility::set_ignoreme( 1 );
    var_1 maps\_utility::set_battlechatter( 0 );
    var_1 maps\_utility::gun_remove();
    var_1.script_friendname = " ";
    var_1.name = " ";
    var_1 _meth_8171();
    var_0 thread maps\_anim::anim_loop_solo( var_1, "npc_deadbody_01", "stop_loop" );
}

vtol_takedown_gun_pickup()
{
    level.slide_dampening = 0.09;
    var_0 = getent( "heli_weapon_trigger", "targetname" );
    var_0 maps\_utility::addhinttrigger( &"CRASH_HINT_STINGER", &"CRASH_HINT_STINGER_KEYBOARD" );
    var_1 = getent( "player_heli_weapon", "targetname" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_0, var_1, cos( 40 ), 0, 1 );
    common_scripts\utility::flag_set( "obj_update_get_gun" );
    soundscripts\_snd::snd_message( "pickup_stinger" );
    var_1 delete();
    level.player_weapons = level.player maps\_utility::get_storable_weapons_list_all();
    level.player _meth_8310();
    level.player _meth_830E( "iw5_stingerm7fastprojectile_sp" );
    level.player _meth_82F7( "iw5_stingerm7fastprojectile_sp", 0 );
    level.player _meth_8315( "iw5_stingerm7fastprojectile_sp" );
    level.player _meth_8321();
    thread vtol_player_fired();
    common_scripts\utility::flag_wait( "gideon_intro_done" );
    thread vtol_takedown_vtol();
    thread vtol_takedown_cargo_and_cables();
    thread maps\_utility::autosave_now();
    var_2 = getentarray( "vtol_takedown_hide_spot", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 thread vtol_takedown_hide_check();

    maps\_utility::delaythread( 5, common_scripts\utility::flag_set, "obj_end_get_gun" );
    common_scripts\utility::flag_wait_or_timeout( "obj_end_get_gun", 5 );
    common_scripts\utility::flag_wait( "vtol_swap_player_weapon" );
    level.player _meth_831D();
    level.player _meth_8310();
    level.player _meth_830E( "s1_unarmed" );
    level.player _meth_8315( "s1_unarmed" );

    while ( level.player maps\_utility::issliding() )
        wait 0.05;

    level.player _meth_817D( "stand" );
    level.player _meth_831E();
    common_scripts\utility::flag_set( "player_bottom_of_hill" );
}

vtol_player_fired()
{
    level waittill( "stinger_fired", var_0, var_1 );
    common_scripts\utility::flag_set( "player_stinger_fired" );
    wait 0.1;
    _func_0D3( "objectiveHide", 1 );
    wait 0.2;
    common_scripts\utility::flag_set( "cormack_fires_stinger" );
    common_scripts\utility::flag_wait( "obj_end_exfil" );
    _func_0D3( "objectiveHide", 0 );
}

vtol_takedown_hide_check()
{
    level endon( "ready_for_vtol" );

    for (;;)
    {
        if ( level.player _meth_80A9( self ) )
        {
            common_scripts\utility::flag_set( "obj_end_get_gun" );
            common_scripts\utility::flag_set( "ready_for_vtol" );
        }

        wait 0.05;
    }
}

vtol_takedown_gideon()
{
    level.vtol_animnode = common_scripts\utility::getstruct( "avalanche_animnode", "targetname" );
    var_0 = level.player;
    level.gideon _meth_81A3( 1 );
    level.vtol_animnode maps\_anim::anim_single_solo( level.gideon, "vtol_ambush_intro" );
    common_scripts\utility::flag_set( "gideon_intro_done" );

    if ( !common_scripts\utility::flag( "obj_update_get_gun" ) )
        level.vtol_animnode thread maps\_anim::anim_loop_solo( level.gideon, "vtol_ambush_stinger_loop", "stop_gideon_loop" );

    common_scripts\utility::flag_wait( "obj_update_get_gun" );
    level.vtol_animnode notify( "stop_gideon_loop" );
    level.vtol_animnode maps\_anim::anim_single_solo( level.gideon, "vtol_ambush_vtol_talk" );
    level.vtol_animnode thread maps\_anim::anim_loop_solo( level.gideon, "vtol_ambush_stinger_loop", "stop_gideon_loop" );
    common_scripts\utility::flag_wait( "start_gideon_wave_anim" );
    level.vtol_animnode notify( "stop_gideon_loop" );
    level.vtol_animnode maps\_anim::anim_single_solo( level.gideon, "vtol_ambush_wave_gideon" );
    level.vtol_animnode thread maps\_anim::anim_loop_solo( level.gideon, "vtol_ambush_stinger_loop", "stop_gideon_loop" );
    common_scripts\utility::flag_wait( "start_gideons_animation" );
    level.vtol_animnode notify( "stop_gideon_loop" );
    level.vtol_animnode maps\_anim::anim_single_solo( level.gideon, "vtol_ambush_exit_cover" );
    level.gideon thread vtol_takedown_gideon_slide_fx();
    level.vtol_animnode thread maps\_anim::anim_single_solo( level.gideon, "vtol_sliding_off_cliff_gideon" );
    soundscripts\_snd::snd_music_message( "end_sequence" );
    wait 2;
    var_1 = getent( "block_vtol_slide", "targetname" );
    var_1 delete();

    while ( level.gideon _meth_814F( level.gideon maps\_utility::getanim( "vtol_sliding_off_cliff_gideon" ) ) < 1 && !common_scripts\utility::flag( "start_exfil" ) )
        wait 0.05;

    thread maps\crash_fx::gideon_boost_jump();

    if ( common_scripts\utility::flag( "start_exfil" ) )
    {
        common_scripts\utility::flag_wait( "start_gideon_exfil" );
        level.exfil_animnode maps\_anim::anim_single_solo( level.gideon, "avalanche_exit" );
    }
    else
    {
        thread cargo_recover_fail();
        common_scripts\utility::flag_set( "failed_cargo_grab" );
        var_2 = getent( "end_cargo_trigger", "targetname" );
        var_2 notify( "valid_trigger" );
        level.vtol_animnode maps\_anim::anim_single_solo( level.gideon, "vtol_falls_off_cliff_failure_gideon" );
    }
}

vtol_takedown_gideon_slide_fx()
{
    self waittillmatch( "single anim", "bodyfall large" );
    playfxontag( common_scripts\utility::getfx( "crash_ai_slide_snow_short" ), self, "j_ball_le" );
    self waittillmatch( "single anim", "bodyfall large" );
    playfxontag( common_scripts\utility::getfx( "crash_ai_slide_snow_short" ), self, "j_ball_le" );
}

vtol_takedown_cormack()
{
    var_0 = common_scripts\utility::getstruct( "avalanche_animnode", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.cormack, "vtol_ambush_intro" );
    var_0 thread maps\_anim::anim_loop_solo( level.cormack, "vtol_ambush_cover_loop", "stop_cormack_loop" );
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );
    var_0 notify( "stop_cormack_loop" );
    var_0 maps\_anim::anim_single_solo( level.cormack, "vtol_ambush_fire_stinger" );
    var_0 thread maps\_anim::anim_loop_solo( level.cormack, "vtol_ambush_call_evac_loop", "stop_cormack_loop" );
    common_scripts\utility::flag_wait( "start_exfil" );
    var_0 notify( "stop_cormack_loop" );
    level.cormack maps\_utility::gun_remove();
    level.exfil_animnode maps\_anim::anim_single_solo( level.cormack, "avalanche_exit" );
}

vtol_takedown_cormack_stinger()
{
    var_0 = common_scripts\utility::getstruct( "avalanche_animnode", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "vtol_launcher" );
    var_2 = maps\_utility::spawn_anim_model( "vtol_stinger" );
    var_0 maps\_anim::anim_first_frame_solo( var_2, "vtol_ambush_fire_stinger_missiles" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "vtol_ambush_intro" );
    var_3 = spawn( "script_model", var_1 gettagorigin( "j_prop_1" ) );
    var_3.angles = var_1 gettagangles( "j_prop_1" );
    var_3 _meth_80B1( "npc_stingerm7_nocamo" );
    var_3 _meth_804D( var_1, "j_prop_1" );
    var_4 = spawn( "script_model", var_2 gettagorigin( "j_prop_1" ) );
    var_4.angles = var_2 gettagangles( "j_prop_1" );
    var_4 _meth_80B1( "projectile_stinger_missile" );
    var_4 _meth_804D( var_2, "j_prop_1" );
    var_4 hide();
    var_5 = spawn( "script_model", var_2 gettagorigin( "j_prop_2" ) );
    var_5.angles = var_2 gettagangles( "j_prop_2" );
    var_5 _meth_80B1( "projectile_stinger_missile" );
    var_5 _meth_804D( var_2, "j_prop_2" );
    var_5 hide();
    var_6 = spawn( "script_model", var_2 gettagorigin( "j_prop_3" ) );
    var_6.angles = var_2 gettagangles( "j_prop_3" );
    var_6 _meth_80B1( "projectile_stinger_missile" );
    var_6 _meth_804D( var_2, "j_prop_3" );
    var_6 hide();
    var_7 = spawn( "script_model", var_2 gettagorigin( "j_prop_4" ) );
    var_7.angles = var_2 gettagangles( "j_prop_4" );
    var_7 _meth_80B1( "projectile_stinger_missile" );
    var_7 _meth_804D( var_2, "j_prop_4" );
    var_7 hide();
    common_scripts\utility::flag_wait( "cormack_start_vtol" );
    var_0 maps\_anim::anim_single_solo( var_1, "vtol_ambush_intro" );
    var_0 thread maps\_anim::anim_loop_solo( var_1, "vtol_ambush_cover_loop", "stop_launcher_loop" );
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );
    var_0 notify( "stop_launcher_loop" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "vtol_ambush_fire_stinger" );
    var_4 show();
    var_4 thread cormack_missile_fx( 0.2 );
    soundscripts\_snd::snd_message( "cormack_missile", var_4 );
    var_5 show();
    var_5 thread cormack_missile_fx( 0.23 );
    soundscripts\_snd::snd_message( "cormack_missile", var_5 );
    var_6 show();
    var_6 thread cormack_missile_fx( 0.2 );
    soundscripts\_snd::snd_message( "cormack_missile", var_6 );
    var_7 show();
    var_7 thread cormack_missile_fx( 0.25, 1 );
    soundscripts\_snd::snd_message( "cormack_missile", var_7 );
    var_0 thread maps\_anim::anim_single_solo( var_2, "vtol_ambush_fire_stinger_missiles" );
    var_2 waittillmatch( "single anim", "missile1_hit" );
    common_scripts\utility::flag_set( "cormack_missile_1_hit" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_4, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "crash_rocket_explosion_default" ), var_4, "tag_origin" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_5, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "crash_rocket_explosion_default" ), var_5, "tag_origin" );
    waitframe();
    var_4 delete();
    var_5 delete();
    var_2 waittillmatch( "single anim", "missile3_hit" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_6, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "ambient_explosion_midair_runner_single" ), var_6, "tag_origin" );
    var_2 waittillmatch( "single anim", "missile4_hit" );
    stopfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), var_7, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "ambient_explosion_midair_runner_single" ), var_7, "tag_origin" );
    var_2 waittillmatch( "single anim", "end" );
    var_6 delete();
    var_7 delete();
    var_2 delete();
    common_scripts\_exploder::exploder( 3122 );
    wait 0.2;
    common_scripts\_exploder::exploder( 3111 );
}

cormack_missile_fx( var_0, var_1 )
{
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );
    playfx( common_scripts\utility::getfx( "javelin_ignition" ), self.origin );
    wait(var_0);
    playfxontag( common_scripts\utility::getfx( "smoketrail_rpg_sp" ), self, "tag_origin" );
}

vtol_takedown_ilona()
{
    var_0 = common_scripts\utility::getstruct( "avalanche_animnode", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.ilana, "vtol_ambush_intro" );
    var_0 thread maps\_anim::anim_loop_solo( level.ilana, "vtol_ambush_cover_loop", "stop_ilana_loop" );
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );
    var_0 notify( "stop_ilana_loop" );
    var_0 maps\_anim::anim_single_solo( level.ilana, "vtol_ambush_exit_cover" );
    var_0 thread maps\_anim::anim_loop_solo( level.ilana, "vtol_ambush_call_evac_loop", "stop_ilana_loop" );
    common_scripts\utility::flag_wait( "start_exfil" );
    var_0 notify( "stop_cormack_loop" );
    level.ilana maps\_utility::gun_remove();
    level.exfil_animnode maps\_anim::anim_single_solo( level.ilana, "avalanche_exit" );
}

cargo_recover_fail()
{
    setdvar( "ui_deadquote", &"CRASH_FAIL_CARGO" );
    maps\_utility::missionfailedwrapper();
}

vtol_takedown_vtol()
{
    level.stingerm7_lock_range = 10000;
    level.end_vtol = maps\_vehicle::spawn_vehicle_from_targetname( "end_vtol" );
    soundscripts\_snd::snd_message( "vtol_flyin" );
    level.end_vtol.animname = "crashed_vtol";
    level.end_vtol maps\_anim::setanimtree();
    level.end_vtol maps\_vehicle::godon();
    level.end_vtol _meth_8259( "axis" );
    level.end_vtol hide();
    level.end_vtol.stinger_override_tags = [ "tag_driver", "tag_grapple_fl", "tag_grapple_br", "TAG_STATIC_TAIL_ROTOR" ];
    level.end_vtol thread maps\crash_warbird_missile_defense::heli_flares_monitor();
    level.end_vtol thread vtol_damage_monitor();
    var_0 = getent( "end_vtol_clip", "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 _meth_804D( level.end_vtol );
        var_0 _meth_82BF();
    }

    common_scripts\utility::flag_wait( "obj_end_get_gun" );
    level.end_vtol show();
    level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_ambush_fly_intro" );

    while ( !common_scripts\utility::flag( "cormack_fires_stinger_failsafe" ) && !common_scripts\utility::flag( "player_stinger_hit" ) )
        wait 0.05;

    level notify( "vtol_takedown_vtol_hit" );
    level.end_vtol thread stinger_add_hit();
    level.end_vtol thread vtol_delayed_stinger_ignore( 5 );
    thread maps\_utility::autosave_now();

    if ( common_scripts\utility::flag( "vtol_can_lock_on" ) && !common_scripts\utility::flag( "vtol_hit_early" ) )
    {
        common_scripts\utility::flag_wait( "vtol_hit_early" );
        level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_ambush_stinger_hit_early" );
    }
    else if ( common_scripts\utility::flag( "vtol_hit_early" ) && !common_scripts\utility::flag( "vtol_hit_mid" ) )
    {
        common_scripts\utility::flag_wait( "vtol_hit_mid" );
        level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_ambush_stinger_hit_mid" );
    }
    else if ( common_scripts\utility::flag( "vtol_hit_mid" ) )
    {
        common_scripts\utility::flag_wait( "missiles_hit_vtol" );
        level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_ambush_stinger_hit_late" );
    }
    else
    {

    }

    level.end_vtol notify( "warbird_stop_firing" );
    level.end_vtol notify( "end_vtol_start_dying" );
    level notify( "vtol_downed" );
    playfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.end_vtol, "jnt_wingsocket_l" );
    playfxontag( common_scripts\utility::getfx( "smoke_trail_black_heli_emitter" ), level.end_vtol, "jnt_wingsocket_l" );
    level.end_vtol waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "end_vtol_dying" );
    common_scripts\utility::flag_set( "obj_end_exfil" );
    common_scripts\_exploder::exploder( 3131 );
    stopfxontag( common_scripts\utility::getfx( "helicopter_explosion_secondary_small" ), level.end_vtol, "jnt_wingsocket_l" );
    stopfxontag( common_scripts\utility::getfx( "smoke_trail_black_heli_emitter" ), level.end_vtol, "jnt_wingsocket_l" );
    maps\_utility::delaythread( 4.0, common_scripts\utility::flag_set, "obj_final_recover_cargo" );

    if ( isdefined( var_0 ) )
        var_0 _meth_82BE();

    thread vtol_takedown_terrain();
    thread vtol_takedown_vtol_slide_fx();

    if ( level.nextgen )
    {
        level.end_vtol _meth_846C( "mtl_xh9_warbird_main", "m/mtl_xh9_warbird_main_destroy" );
        level.end_vtol _meth_846C( "mtl_xh9_warbird_main_02", "m/mtl_xh9_warbird_main_02_destroy" );
        level.end_vtol _meth_846C( "mtl_xh9_warbird_windows_out", "m/mtl_xh9_warbird_windows_out_destroy" );
    }
    else
    {
        level.end_vtol _meth_846C( "mtl_xh9_warbird_main", "mq/mtl_xh9_warbird_main_destroy" );
        level.end_vtol _meth_846C( "mtl_xh9_warbird_main_02", "mq/mtl_xh9_warbird_main_02_destroy" );
        level.end_vtol _meth_846C( "mtl_xh9_warbird_windows_out", "mq/mtl_xh9_warbird_windows_out_destroy" );
    }

    level.end_vtol _meth_804B( "TAG_STATIC_MAIN_ROTOR_L" );
    level.end_vtol _meth_804B( "TAG_STATIC_MAIN_ROTOR_R" );
    level.end_vtol _meth_804B( "TAG_STATIC_TAIL_ROTOR" );
    level.end_vtol _meth_8048( "TAG_SPIN_MAIN_ROTOR_L" );
    level.end_vtol _meth_8048( "TAG_SPIN_MAIN_ROTOR_R" );
    level.end_vtol _meth_8048( "TAG_SPIN_TAIL_ROTOR" );
    level.vtol_animnode maps\_anim::anim_single_solo( level.end_vtol, "vtol_ambush_crash" );
    thread avalanche_environment();
    thread vtol_takedown_player_grabs_cargo();
    common_scripts\utility::flag_set( "vtol_done_sliding" );
    level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_sliding_off_cliff" );

    while ( level.end_vtol _meth_814F( level.end_vtol maps\_utility::getanim( "vtol_sliding_off_cliff" ) ) < 1 && !common_scripts\utility::flag( "kill_sliding_anims" ) )
        wait 0.05;

    if ( common_scripts\utility::flag( "kill_sliding_anims" ) )
    {
        level.end_vtol _meth_83C7( level.end_vtol maps\_utility::getanim( "vtol_sliding_off_cliff" ), 0 );
        common_scripts\utility::flag_wait( "start_vtol_exfil" );
        level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "avalanche_exit_fail" );
    }
    else
        level.vtol_animnode thread maps\_anim::anim_single_solo( level.end_vtol, "vtol_falls_off_cliff" );

    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_maindoor_LR" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_launcherDoor02_R" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_BL" );
    playfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_FL" );
}

stinger_add_hit()
{
    level endon( "missiles_hit_vtol" );
    common_scripts\utility::flag_wait( "player_stinger_hit" );
    level.end_vtol _meth_814B( level.end_vtol maps\_utility::getanim( "ambush_hit_add" ), 0.5 );
    level.end_cables _meth_814B( level.end_cables maps\_utility::getanim( "ambush_hit_add" ), 0.5 );
    level.end_crate _meth_814B( level.end_crate maps\_utility::getanim( "ambush_hit_add" ), 0.5 );
}

vtol_takedown_vtol_slide_fx()
{
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_maindoor_LL" );
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_maindoor_LR" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_launcherDoor02_L" );
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_launcherDoor02_R" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_BL" );
    playfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_FL" );
    playfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "Tag_light_l_wing" );
    common_scripts\utility::flag_wait( "vtol_done_sliding" );
    stopfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_maindoor_LL" );
    stopfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_maindoor_LR" );
    wait 0.05;
    stopfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_launcherDoor02_L" );
    stopfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "jnt_launcherDoor02_R" );
    wait 0.05;
    stopfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_BL" );
    stopfxontag( common_scripts\utility::getfx( "crate_crash_slide_snow" ), level.end_crate, "TAG_FX_SLIDE_FL" );
    stopfxontag( common_scripts\utility::getfx( "vtol_crash_slide_snow" ), level.end_vtol, "Tag_light_l_wing" );
}

vtol_delayed_stinger_ignore( var_0 )
{
    wait(var_0);

    if ( isdefined( self ) )
        maps\_stingerm7::stinger_ignore();
}

vtol_damage_monitor()
{
    level endon( "vtol_takedown_vtol_hit" );
    level.end_vtol _meth_82C0( 1 );
    level.end_vtol _meth_82C1( 1 );

    for (;;)
    {
        level waittill( "stinger_fired", var_0, var_1 );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3 ) )
                var_3 thread projectile_alive();
        }
    }

    level notify( "vtol_downed" );
    var_5 = getentarray( "vtol_fail_triggers", "targetname" );
    maps\_utility::array_delete( var_5 );
}

projectile_alive()
{
    level endon( "player_stinger_hit" );

    while ( isdefined( self ) )
        wait 0.05;

    common_scripts\utility::flag_set( "player_stinger_hit" );
}

vtol_takedown_shoot_monitor()
{
    self endon( "end_vtol_start_dying" );
    level.player.ignoreme = 0;
    wait 0.25;
    thread maps\crash_utility::warbird_shooting_think( 0, 0.5, 2.5, 1 );
    wait 0.05;
    self notify( "warbird_fire" );
}

vtol_takedown_cargo_and_cables()
{
    level.end_cables _meth_82BF();
    level.end_crate.origin = level.end_cables gettagorigin( "tag_attach" );
    level.end_crate.angles = level.end_cables gettagangles( "tag_attach" );
    level.end_crate _meth_82BF();
    level.end_crate_clip.origin = level.end_crate.origin;
    level.end_crate_clip.angles = level.end_crate.angles;
    level.end_crate_clip _meth_804D( level.end_crate );
    level.end_crate_clip _meth_82BF();
    var_0 = getent( "end_cargo_trigger", "targetname" );
    var_0 _meth_8069();
    var_0 _meth_804D( level.end_crate, "tag_origin", ( 64, 0, 48 ), ( 0, 0, 0 ) );
    var_0 common_scripts\utility::trigger_off();
    level.final_loc = level.end_crate common_scripts\utility::spawn_tag_origin();
    level.final_loc.origin = level.end_crate gettagorigin( "j_casing_lid" );
    level.final_loc _meth_804D( level.end_crate, "j_casing_lid" );
    level.final_use_struct = level.end_crate common_scripts\utility::spawn_tag_origin();
    level.final_use_struct.origin = level.end_crate gettagorigin( "j_casing_lid" );
    level.final_use_struct _meth_804D( level.end_crate, "j_casing_lid" );
    var_1 = [];
    var_1[0] = level.end_crate;
    var_1[1] = level.end_cables;
    level.end_crate.animname = "vtol_cargo";
    level.end_crate maps\_anim::setanimtree();
    level.end_cables.animname = "vtol_cables";
    level.end_cables maps\_anim::setanimtree();
    common_scripts\utility::flag_wait( "obj_end_get_gun" );
    level.end_cables show();
    level.end_crate show();
    level.end_crate_clip show();
    level.vtol_animnode thread maps\_anim::anim_single( var_1, "vtol_ambush_fly_intro" );

    while ( !common_scripts\utility::flag( "cormack_fires_stinger_failsafe" ) && !common_scripts\utility::flag( "player_stinger_hit" ) )
        wait 0.05;

    if ( common_scripts\utility::flag( "vtol_can_lock_on" ) && !common_scripts\utility::flag( "vtol_hit_early" ) )
    {
        common_scripts\utility::flag_wait( "vtol_hit_early" );
        level.vtol_animnode maps\_anim::anim_single( var_1, "vtol_ambush_stinger_hit_early" );
    }
    else if ( common_scripts\utility::flag( "vtol_hit_early" ) && !common_scripts\utility::flag( "vtol_hit_mid" ) )
    {
        common_scripts\utility::flag_wait( "vtol_hit_mid" );
        level.vtol_animnode maps\_anim::anim_single( var_1, "vtol_ambush_stinger_hit_mid" );
    }
    else if ( common_scripts\utility::flag( "vtol_hit_mid" ) )
    {
        common_scripts\utility::flag_wait( "missiles_hit_vtol" );
        level.vtol_animnode maps\_anim::anim_single( var_1, "vtol_ambush_stinger_hit_late" );
    }
    else
    {

    }

    level.end_cables _meth_82BE();
    level.end_crate _meth_82BE();
    level.end_crate_clip _meth_82BE();
    level.vtol_animnode maps\_anim::anim_single( var_1, "vtol_ambush_crash" );
    var_0 common_scripts\utility::trigger_on();
    level.vtol_animnode thread maps\_anim::anim_single( var_1, "vtol_sliding_off_cliff" );

    while ( level.end_vtol _meth_814F( level.end_vtol maps\_utility::getanim( "vtol_sliding_off_cliff" ) ) < 1 && !common_scripts\utility::flag( "kill_sliding_anims" ) )
        wait 0.05;

    if ( common_scripts\utility::flag( "kill_sliding_anims" ) )
    {
        level.end_cables _meth_83C7( level.end_cables maps\_utility::getanim( "vtol_sliding_off_cliff" ), 0 );
        level.end_crate _meth_83C7( level.end_crate maps\_utility::getanim( "vtol_sliding_off_cliff" ), 0 );
        level.exfil_animnode = level.end_crate common_scripts\utility::spawn_tag_origin();
        common_scripts\utility::flag_set( "start_exfil" );
        level.exfil_animnode maps\_anim::anim_single_solo( level.end_crate, "avalanche_exit" );
        common_scripts\utility::flag_wait( "start_vtol_exfil" );
        level.vtol_animnode maps\_anim::anim_single( var_1, "avalanche_exit_fail" );
    }
    else
    {
        var_0 delete();
        level.vtol_animnode maps\_anim::anim_single( var_1, "vtol_falls_off_cliff" );
    }
}

vtol_takedown_terrain()
{
    var_0 = getent( "vtol_slide_cover_01", "targetname" );
    var_1 = getent( "vtol_slide_cover_01a", "targetname" );
    var_2 = getent( "vtol_slide_cover_02", "targetname" );
    var_3 = getent( "vtol_slide_cover_03", "targetname" );
    var_4 = getent( "vtol_slide_cover_04", "targetname" );
    var_5 = getent( "vtol_slide_cover_05", "targetname" );
    var_6 = getent( "vtol_slide_cover_06", "targetname" );
    var_7 = getent( "vtol_slide_cover_07", "targetname" );
    var_8 = getent( "vtol_slide_cover_08", "targetname" );
    var_9 = getent( "vtol_slide_cover_09", "targetname" );
    var_10 = getent( "vtol_slide_cover_10", "targetname" );
    var_11 = getent( "vtol_slide_cover_11", "targetname" );
    var_12 = getent( "vtol_slide_cover_12", "targetname" );
    common_scripts\_exploder::exploder( 8700 );
    var_0 delete();
    wait 0.34;
    var_1 delete();
    wait 3.58;
    var_2 delete();
    wait 1.33;
    var_3 delete();
    wait 1.05;
    var_4 delete();
    wait 1.13;
    var_5 delete();
    wait 0.98;
    var_6 delete();
    wait 0.78;
    var_7 delete();
    wait 0.81;
    var_8 delete();
    wait 0.86;
    var_9 delete();
    wait 1.13;
    var_10 delete();
    wait 0.81;
    var_11 delete();
    wait 0.85;
    var_12 delete();
}

vtol_takedown_player_grabs_cargo()
{
    level endon( "failed_cargo_grab" );

    if ( common_scripts\utility::flag( "failed_cargo_grab" ) )
        return;

    var_0 = getent( "end_cargo_trigger", "targetname" );
    var_0 maps\_utility::addhinttrigger( &"CRASH_CARGO_GRAB", &"CRASH_CARGO_GRAB_KEYBOARD" );
    maps\player_scripted_anim_util::waittill_trigger_activate_looking_at( var_0, level.final_loc, cos( 40 ), 0, 1 );
    common_scripts\utility::flag_set( "cargo_trigger" );
    common_scripts\utility::flag_set( "kill_sliding_anims" );
    common_scripts\utility::flag_wait( "start_exfil" );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_1 = maps\_utility::spawn_anim_model( "rig" );
    var_1 hide();
    var_2 = spawn( "script_model", var_1.origin );
    var_2 _meth_80B1( "atlas_stabilize_vial_static" );
    var_2 hide();
    var_2.origin = var_1 gettagorigin( "tag_weapon_right" );
    var_2.angles = var_1 gettagangles( "tag_weapon_right" );
    var_2 _meth_804D( var_1, "tag_weapon_right" );
    soundscripts\_snd::snd_message( "recover_cargo" );
    level.exfil_animnode thread maps\_anim::anim_single_solo( var_1, "avalanche_exit" );
    thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player _meth_8080( var_1, "tag_player", 0.6 );
    wait 0.3;
    var_1 show();
    wait 0.3;
    common_scripts\utility::flag_set( "obj_end_recover_cargo" );
    level.player _meth_807D( var_1, "tag_player", 1, 25, 25, 20, 20, 1 );
    common_scripts\_exploder::exploder( 5186 );
    wait 0.5;
    level notify( "moved_indoors" );
    var_1 waittillmatch( "single anim", "unhide_vial" );
    var_2 show();
    var_1 waittillmatch( "single anim", "jump_window_end" );

    if ( !common_scripts\utility::flag( "player_exfil_success" ) )
    {
        var_3 = var_1 common_scripts\utility::spawn_tag_origin();
        var_3 thread maps\_anim::anim_single_solo( var_1, "avalanche_death" );
        soundscripts\_snd::snd_message( "exfil_fail" );
        wait 1;
        var_4 = var_1 common_scripts\utility::spawn_tag_origin();
        var_4 _meth_804D( var_1, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "screen_avalanche_death" ), var_4, "tag_origin" );
        wait 0.75;
        setdvar( "ui_deadquote", &"CRASH_FAIL_CARGO" );
        maps\_utility::missionfailedwrapper();
    }

    var_1 waittillmatch( "single anim", "end" );
}

exfil_player_jump( var_0 )
{
    level.player endon( "exfil_fail" );
    thread maps\_utility::hintdisplayhandler( "end_jump" );
    level.player _meth_82DD( "exfil_jump", "+gostand" );
    level.player waittill( "exfil_jump" );
    waitframe();
    level.player _meth_82DD( "exfil_jump2", "+gostand" );
    level.player waittill( "exfil_jump2" );
    common_scripts\utility::flag_set( "player_exfil_success" );
}

exfil_player_jump_fail( var_0 )
{
    level.player notify( "exfil_fail" );
    common_scripts\utility::flag_set( "exfil_fail" );
}

should_break_end_jump_hint()
{
    return common_scripts\utility::flag( "player_exfil_success" ) || common_scripts\utility::flag( "exfil_fail" );
}

vtol_takedown_chopper()
{
    common_scripts\utility::flag_wait_any( "player_bottom_of_hill", "player_at_vtol", "cargo_trigger" );
    var_0 = common_scripts\utility::getstruct( "avalanche_exfil_animnode", "targetname" );
    level.end_chopper = maps\_vehicle::spawn_vehicle_from_targetname( "end_littlebird" );
    level.end_chopper.animname = "exfil_heli";
    level.end_chopper maps\_anim::setanimtree();
    level.end_chopper hide();
    level.end_chopper _meth_828B();
    var_0 maps\_anim::anim_first_frame_solo( level.end_chopper, "avalanche_exit" );
    common_scripts\utility::flag_wait( "start_exfil" );
    level.end_chopper show();
    level.exfil_animnode maps\_anim::anim_single_solo( level.end_chopper, "avalanche_exit" );
}

vtol_takedown_dialogue()
{
    level.gideon maps\_utility::smart_dialogue( "crsh_gid_stingers" );
    common_scripts\utility::flag_set( "obj_start_get_gun" );
    common_scripts\utility::flag_wait( "gideon_intro_done" );
    wait 0.4;
    level.gideon maps\_utility::smart_dialogue( "crsh_gid_dealthwith" );
    wait 0.75;
    maps\_utility::smart_radio_dialogue( "crsh_acp_yourelucky" );
    wait 0.5;
    level.gideon maps\_utility::smart_dialogue( "crsh_gid_cargosecure2" );
    wait 0.75;
    maps\_utility::smart_radio_dialogue( "crsh_acp_intact" );
    common_scripts\utility::flag_wait( "vo_heat_line" );

    if ( !common_scripts\utility::flag( "player_stinger_fired" ) )
    {
        maps\_utility::smart_radio_dialogue( "crsh_acp_heatsignatures" );
        common_scripts\utility::flag_wait( "vo_bringitdown_line" );

        if ( !common_scripts\utility::flag( "player_stinger_fired" ) )
            maps\_utility::smart_radio_dialogue( "crsh_gid_bringitdown2" );
    }

    level waittill( "vtol_downed" );
    wait 1;
    level.gideon maps\_utility::smart_dialogue( "crsh_gid_callevac3" );
    common_scripts\utility::flag_wait( "gideon_jump_talk" );
    level.gideon maps\_utility::smart_dialogue( "crsh_gid_comingapart3" );
    wait 1;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_evacshere" );
    wait 1.5;

    if ( !common_scripts\utility::flag( "player_at_vtol" ) )
        maps\_utility::smart_radio_dialogue( "crsh_gid_loseit2" );

    common_scripts\utility::flag_wait( "player_at_vtol" );

    if ( !common_scripts\utility::flag( "cargo_trigger" ) )
        maps\_utility::smart_radio_dialogue( "crsh_gid_grabcargo2" );

    common_scripts\utility::flag_wait( "vo_cormack_exfil1" );

    if ( common_scripts\utility::flag( "player_exfil_success" ) )
        level.cormack maps\_utility::smart_dialogue( "crsh_crmk_boxissecure" );

    common_scripts\utility::flag_wait( "vo_kingpin_exfil" );

    if ( common_scripts\utility::flag( "player_exfil_success" ) )
        maps\_utility::smart_radio_dialogue( "crsh_so_solidcopy1" );

    common_scripts\utility::flag_wait( "vo_cormack_exfil2" );

    if ( common_scripts\utility::flag( "player_exfil_success" ) )
        level.cormack maps\_utility::smart_dialogue( "crsh_crmk_donttrustyou" );
}

vtol_takedown_failure()
{
    level endon( "vtol_downed" );
    var_0 = getentarray( "vtol_fail_triggers", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();

    common_scripts\utility::flag_clear( "vtol_fail" );
    common_scripts\utility::flag_wait( "vtol_fail" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_CARGO" );
    maps\_utility::missionfailedwrapper();
}

avalanche_environment()
{
    while ( !common_scripts\utility::flag( "obj_end_recover_cargo" ) )
    {
        var_0 = randomfloatrange( 1.5, 5.5 );
        level.player _meth_80AD( "hijack_plane_medium" );
        _func_234( level.player.origin, 0.5, 0.5, 0.25, var_0, 0, 0.5, 500, 8, 5, 2 );
        wait(var_0 + randomfloatrange( 0.5, 1.5 ));
    }
}

avalanche_falling_death()
{
    common_scripts\utility::flag_wait( "av_fall_death" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
}
