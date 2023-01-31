// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

plant_tracker_start()
{
    level.start_point_scripted = "plant_tracker";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    thread move_lift();
    thread maps\irons_estate_track_irons::handle_gaz();
    thread maps\irons_estate_track_irons::handle_gaz2();
    soundscripts\_snd::snd_message( "start_plant_tracker" );
    thread stairwell_doors();
    thread landing_pad_lift_upper_static_setup();
    thread maps\irons_estate_track_irons::ambient_hangar_fan_blades_setup();
    level.player _meth_8310();
    level.player _meth_830E( "iw5_pbwsingleshot_sp_silencerpistol" );
    level.player _meth_830E( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
    level.player _meth_8315( "iw5_kf5fullauto_sp_opticsreddot_silencer01" );
}

plant_tracker_main()
{
    level.start_point_scripted = "plant_tracker";
    thread plant_tracker_begin();
    common_scripts\utility::flag_wait( "plant_tracker_end" );
    thread maps\_utility::autosave_by_name();
}

plant_tracker_begin()
{
    common_scripts\utility::flag_set( "plant_tracker_start" );
    level.player.grapple["dist_max"] = 1000;
    level.player maps\_utility::set_player_attacker_accuracy( 0.5 );
    thread plant_tracker_objective();
    thread exfil_setup();
    thread plant_tracker_vo();
    thread grapple_dist_max_watcher();
    thread landing_pad_lights_on();
    thread pop_cormack_into_exfil_anim_to_match_player();
    thread exfil_guys();
    level.allies[0] thread cormack_grapple_to_vtol();
    soundscripts\_snd::snd_message( "aud_exfil_vtol_start" );
}

grapple_dist_max_watcher()
{
    common_scripts\utility::flag_wait( "increase_grapple_dist_max" );
    level.player.grapple["dist_max"] = 1500;
}

plant_tracker_objective()
{
    objective_add( maps\_utility::obj( "plant_tracker" ), "current", &"IRONS_ESTATE_OBJ_PLANT_TRACKER" );
    objective_onentity( maps\_utility::obj( "plant_tracker" ), level.allies[0] );
    common_scripts\utility::flag_wait( "start_exfil_moment_final" );
    thread maps\_stealth_display::stealth_display_off();
    var_0 = common_scripts\utility::getstruct( "vtol_landing_pad_obj_marker", "targetname" );
    objective_position( maps\_utility::obj( "plant_tracker" ), var_0.origin );
    level.player waittill( "grappled_to_vtol" );
    objective_position( maps\_utility::obj( "plant_tracker" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "ATTACHED_TRACKER" );
    maps\_utility::objective_complete( maps\_utility::obj( "plant_tracker" ) );
}

move_lift()
{
    var_0 = getent( "landing_pad_lift", "targetname" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_0 _meth_804D( var_1, "tag_origin" );
    var_2 = common_scripts\utility::getstruct( "lift_end_pos", "targetname" );
    var_1 _meth_82AE( var_2.origin, 0.1 );
}

vtol_exhaust()
{
    common_scripts\utility::flag_wait( "start_exfil_moment_final_liftoff_started" );
    playfxontag( level._effect["vtol_exhaust_l"], self, "TAG_LT_WING_EXHAUSE_FX" );
    playfxontag( level._effect["vtol_exhaust_r"], self, "TAG_RT_WING_EXHAUSE_FX" );
}

vtolfx()
{
    common_scripts\utility::flag_wait( "start_exfil_moment_final_liftoff_started" );
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_LE_1" );
    wait 0.3;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_LE_2" );
    wait 0.1;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_LE_3" );
    wait 0.3;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_LE_4" );
    wait 0.1;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_RI_1" );
    wait 0.05;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_RI_2" );
    wait 0.05;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_RI_3" );
    wait 0.05;
    playfxontag( level._effect["vtol_engine"], self, "TAG_FX_ENGINE_RI_4" );
    common_scripts\_exploder::exploder( 1000 );
}

exfil_setup()
{
    level.anim_struct_exfil = common_scripts\utility::getstruct( "anim_struct_exfil", "targetname" );

    if ( isdefined( level.vtol ) )
        level.vtol delete();

    var_0 = [];
    level.vtol = maps\_utility::spawn_anim_model( "vtol", ( 0, 0, 0 ) );
    var_0[var_0.size] = level.vtol;
    level.exfil_arms = maps\_utility::spawn_anim_model( "player_rig", ( 0, 0, 0 ) );
    level.exfil_arms hide();
    var_0[var_0.size] = level.exfil_arms;
    level.tracking_device = maps\_utility::spawn_anim_model( "tracking_device" );
    level.tracking_device _meth_804D( level.exfil_arms, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.tracking_device hide();
    var_1 = maps\_utility::spawn_anim_model( "genericprop_x5" );
    var_1 hide();
    var_0[var_0.size] = var_1;
    var_1 thread exfil_spotlights_fx();
    level.anim_struct_exfil maps\_anim::anim_first_frame( var_0, "exfil" );
    level.vtol thread exfil_vtol();
    level.vtol thread vtol_lights();
    thread exfil_player();
    thread plant_tracker_waits();
    thread plant_tracker_rumbles();
    level.allies[0] thread exfil_cormack();
    thread exfil_allies();
    thread tracking_device_waits();
    thread breathers();
    common_scripts\utility::flag_wait_or_timeout( "start_exfil_moment_final_liftoff", 60 );
    common_scripts\utility::flag_set( "start_exfil_moment_final_liftoff_started" );
    wait 2.0;
    level.anim_struct_exfil thread maps\_anim::anim_single( var_0, "exfil" );
}

pop_cormack_into_exfil_anim_to_match_player()
{
    common_scripts\utility::flag_wait( "player_started_vtol_grapple" );
    level.allies[0].name = " ";
    level waittill( "stop_grapplesound" );
    level.allies[0] notify( "killgrapple" );
    level.allies[0] _meth_804F();
    level.anim_struct_exfil thread maps\_anim::anim_single_solo( level.allies[0], "exfil" );
    wait 0.05;
    maps\_anim::anim_set_time( [ level.vtol, level.allies[0], level.exfil_arms ], "exfil", 0.26867 );
}

vtol_lights()
{
    playfxontag( level._effect["ie_atlas_jet_exterior_lights"], self, "body_animate_jnt" );
    waitframe();
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_LT_WING_LIGHT_FX" );
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_RT_WING_LIGHT_FX" );
}

exfil_spotlights_fx()
{
    common_scripts\utility::flag_wait( "start_exfil_moment_final" );
    playfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_1" );
    wait 0.05;
    playfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_2" );
    wait 0.05;
    playfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_3" );
    wait 0.05;
    playfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_4" );
    common_scripts\utility::flag_wait( "player_grappled_to_vtol" );
    wait 3.0;
    stopfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_1" );
    wait 0.05;
    stopfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_2" );
    wait 0.05;
    stopfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_3" );
    wait 0.05;
    stopfxontag( level._effect["ie_lightbeam_vtol_landing"], self, "j_prop_4" );
}

exfil_vtol()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 hide();
    var_0 _meth_804D( self, "J_magnet_01", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self waittillmatch( "single anim", "grapple_on" );
    level thread player_started_vtol_grapple_monitor();
    thread cloud_fx();
    playfxontag( level._effect["ie_vtol_fill_grapple"], self, "J_magnet_01" );
    level.vtol thread vtol_obj_marker_monitor( var_0 );
    self waittillmatch( "single anim", "grapple_off" );

    if ( !common_scripts\utility::flag( "player_started_vtol_grapple" ) )
    {
        level notify( "player_started_vtol_grapple_monitor_off" );
        maps\_grapple::grapple_magnet_unregister( self, "J_magnet_01" );
        level.player maps\_grapple::grapple_take();
        objective_state( maps\_utility::obj( "plant_tracker" ), "failed" );
        wait 1.0;
        maps\_player_death::set_deadquote( &"IRONS_ESTATE_VTOL_GRAPPLE_FAIL" );
        maps\_utility::missionfailedwrapper();
    }

    self waittillmatch( "single anim", "tracker_on" );
    self waittillmatch( "single anim", "tracker_off" );
    common_scripts\utility::flag_set( "ATTACHED_TRACKER" );
    self waittillmatch( "single anim", "detach_on" );
    self waittillmatch( "single anim", "detach_off" );
    thread detach_motion_blur_enable();
    common_scripts\utility::flag_set( "DETACHED_FROM_VTOL" );
    thread dive_fx();
    self waittillmatch( "single anim", "end" );
    self delete();
}

#using_animtree("player");

vtol_obj_marker_monitor( var_0 )
{
    level endon( "player_started_vtol_grapple_monitor_off" );
    var_1 = spawnstruct();
    var_1.landanimbody = %ie_exfil_vtol_player;
    var_1.landanimhands = %ie_exfil_vtol_player_viewmodel;
    var_1.ignorecollision = 1;
    var_1.noenableweapon = 1;
    var_1.landhiderope = 1;
    var_1.noabort = 1;

    if ( common_scripts\utility::flag( "increase_grapple_dist_max" ) )
    {
        objective_onentity( maps\_utility::obj( "plant_tracker" ), var_0 );
        maps\_grapple::grapple_magnet_register( self, "J_magnet_01", ( 0, 0, 0 ), "grappled_to_vtol", undefined, var_1, undefined );
    }
    else
    {
        common_scripts\utility::flag_wait( "increase_grapple_dist_max" );
        objective_onentity( maps\_utility::obj( "plant_tracker" ), var_0 );
        maps\_grapple::grapple_magnet_register( self, "J_magnet_01", ( 0, 0, 0 ), "grappled_to_vtol", undefined, var_1, undefined );
    }
}

player_started_vtol_grapple_monitor()
{
    level endon( "missionfailed" );
    level.player endon( "death" );
    level endon( "player_started_vtol_grapple_monitor_off" );

    for (;;)
    {
        level.player waittill( "grapple_moving", var_0 );

        if ( isdefined( var_0 ) && var_0.notifyname == "grappled_to_vtol" )
        {
            objective_position( maps\_utility::obj( "plant_tracker" ), ( 0, 0, 0 ) );
            soundscripts\_snd::snd_message( "aud_exfil_vtol_grapple" );
            common_scripts\utility::flag_set( "player_started_vtol_grapple" );
            thread started_to_grapple_to_vtol_but_aborted_watcher();
        }
    }
}

started_to_grapple_to_vtol_but_aborted_watcher()
{
    level.player endon( "grappled_to_vtol" );
    level.player waittill( "grapple_abort" );
    level notify( "player_started_vtol_grapple_monitor_off" );
    maps\_grapple::grapple_magnet_unregister( level.vtol, "J_magnet_01" );
    level.player maps\_grapple::grapple_take();
    objective_state( maps\_utility::obj( "plant_tracker" ), "failed" );
    wait 1.0;
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_VTOL_GRAPPLE_FAIL" );
    maps\_utility::missionfailedwrapper();
}

exfil_player()
{
    level.player waittill( "grappled_to_vtol" );
    common_scripts\utility::flag_set( "player_grappled_to_vtol" );
    level.player _meth_80AD( "damage_light" );
    maps\_grapple::grapple_magnet_unregister( level.vtol, "J_magnet_01" );
    level.player maps\_grapple::grapple_take();
    level.player _meth_831D();
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    level.player _meth_831F();
    level.player _meth_8321();
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player maps\_tagging::tagging_set_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player _meth_807F( level.exfil_arms, "tag_player" );
    wait 0.05;
    level.player _meth_807D( level.exfil_arms, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    level.exfil_arms show();
}

exfil_cormack()
{
    level.allies[0] _meth_81CA( "stand" );
    level.allies[0].badplaceawareness = 0;
    level.anim_struct_exfil maps\_anim::anim_reach_solo( level.allies[0], "exfil_enter" );
    level.anim_struct_exfil thread maps\_anim::anim_single_solo( level.allies[0], "exfil_enter" );
    soundscripts\_snd::snd_message( "aud_exfil_door_1" );
    level.allies[0] waittillmatch( "single anim", "end" );
    thread running_up_the_stairs_fail();

    if ( common_scripts\utility::flag( "start_exfil_moment" ) )
    {
        var_0 = "exfil_enter_end_1";
        soundscripts\_snd::snd_message( "aud_exfil_door_2a" );
    }
    else
    {
        var_0 = "exfil_enter_end_2";
        level.anim_struct_exfil thread maps\_anim::anim_first_frame_solo( level.allies[0], var_0 );
        common_scripts\utility::flag_wait( "start_exfil_moment" );
        soundscripts\_snd::snd_message( "aud_exfil_door_2b" );
    }

    thread maps\_utility::autosave_stealth();
    level.anim_struct_exfil thread maps\_anim::anim_single_solo( level.allies[0], var_0 );
    level.allies[0] waittillmatch( "single anim", "door_open" );
    soundscripts\_snd::snd_message( "aud_exfil_vtol_ascend" );
    common_scripts\utility::flag_set( "start_exfil_moment_final" );
    maps\irons_estate_code::irons_estate_stealth_disable();
    level.allies[0] waittillmatch( "single anim", "end" );
    level.allies[0] thread cormack_landing_pad_combat();
}

cormack_landing_pad_combat()
{
    thread maps\_stealth_utility::disable_stealth_system();
    maps\_stealth_utility::disable_stealth_for_ai();
    self.baseaccuracy = 0.9;
    maps\_utility::enable_heat_behavior( 1 );
    self.disablereactionanims = 1;
    self.dontevershoot = undefined;
    maps\_utility::set_fixednode_false();
    maps\_utility::set_goalradius( 1024 );
    maps\_utility::disable_cqbwalk();
    maps\_utility::enable_careful();
    maps\_utility::set_force_color( "b" );
    maps\_utility::enable_ai_color();
    maps\_utility::disable_surprise();
    maps\_utility::disable_pain();
    maps\_utility::disable_bulletwhizbyreaction();
    self _meth_81CA( "stand", "crouch" );
    self.ignoreme = 0;
    self.ignoreall = 0;
    level notify( "wake_up_guys" );
}

exfil_guys()
{
    common_scripts\utility::flag_wait( "start_exfil_moment_final" );
    thread exfil_enemies();
}

exfil_enemies()
{
    maps\_utility::array_spawn_function_targetname( "landing_pad_enemies", ::exfil_enemies_setup );
    var_0 = maps\_utility::array_spawn_targetname( "landing_pad_enemies", 1 );
    level.jumper_clip_1 = getent( "jumper_clip_1", "targetname" );
    level.jumper_clip_2 = getent( "jumper_clip_2", "targetname" );
    var_1 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive( "landing_pad_drones" );
    common_scripts\utility::array_thread( var_1, ::landing_pad_drones );
}

exfil_enemies_setup()
{
    self endon( "death" );
    self.baseaccuracy = 0.5;
    level waittill( "wake_up_guys" );
    maps\_stealth_utility::disable_stealth_for_ai();
    self notify( "end_patrol" );

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "jumpers" )
    {
        if ( isdefined( level.jumper_clip_1 ) )
        {
            level.jumper_clip_1 _meth_82BF();
            level.jumper_clip_1 _meth_8058();
            level.jumper_clip_1 delete();
        }

        self.canjumppath = 100;
        maps\_utility::set_ignoreme( 1 );
        maps\_utility::set_ignoreall( 1 );
        var_0 = getent( "jumper_volume", "targetname" );
        self _meth_81A9( var_0 );
        common_scripts\utility::waittill_notify_or_timeout( "goal", 8 );

        if ( isdefined( level.jumper_clip_2 ) )
        {
            level.jumper_clip_2 _meth_82BF();
            level.jumper_clip_2 _meth_8058();
            level.jumper_clip_2 delete();
        }

        self _meth_81AB();
        self.dontattackme = undefined;
        self.ignoreme = 0;
        self.ignoreall = 0;
        maps\_utility::set_force_color( "o" );
        maps\_utility::enable_ai_color();
    }
    else
    {
        self.dontattackme = undefined;
        self.ignoreme = 0;
        self.ignoreall = 0;
        maps\_utility::set_force_color( "o" );
        maps\_utility::enable_ai_color();
    }

    common_scripts\utility::flag_wait( "player_started_vtol_grapple" );

    if ( isdefined( self ) && isalive( self ) )
        self _meth_8052();
}

landing_pad_drones()
{
    self endon( "death" );
    self.attack_accuracy = 0.5;
    level waittill( "wake_up_guys" );
    wait(randomfloatrange( 1.0, 2.0 ));
    thread vehicle_scripts\_pdrone_security::drone_set_mode( "attack" );
    common_scripts\utility::flag_wait( "player_started_vtol_grapple" );

    if ( isdefined( self ) && isalive( self ) )
        self _meth_8052();
}

#using_animtree("generic_human");

cormack_grapple_to_vtol()
{
    self endon( "killgrapple" );
    level endon( "missionfailed" );
    level.player endon( "death" );
    level endon( "player_started_vtol_grapple_monitor_off" );
    common_scripts\utility::flag_wait_either( "start_exfil_moment_final_liftoff_started", "landing_pad_enemies_dead" );
    common_scripts\utility::flag_set( "increase_grapple_dist_max" );
    var_0 = getnode( "cormack_landing_pad_grapple_spot", "targetname" );
    maps\_utility::ai_ignore_everything();
    maps\_utility::disable_ai_color();
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::set_fixednode_true();
    maps\_utility::set_goalradius( 64 );
    maps\_utility::enable_sprint();
    self _meth_81A5( var_0 );
    self waittill( "goal" );
    maps\_grapple_traverse::grapple_traverse( undefined, level.vtol, "J_magnet_02", %ie_exfil_impact_cormack );
    self waittill( "traverse_finish" );
    self _meth_804F();
    level.anim_struct_exfil thread maps\_anim::anim_single_solo( self, "exfil" );
    wait 0.05;
    var_1 = level.exfil_arms _meth_814F( level.exfil_arms maps\_utility::getanim( "exfil" ) );
    self _meth_8117( maps\_utility::getanim( "exfil" ), var_1 );
}

exfil_workers()
{
    maps\_utility::array_spawn_function_targetname( "landing_pad_workers_01", ::worker_spawn_func );
    var_0 = maps\_utility::array_spawn_targetname( "landing_pad_workers_01", 1 );
    maps\_utility::array_spawn_function_targetname( "landing_pad_workers_02", ::worker_spawn_func );
    var_1 = maps\_utility::array_spawn_targetname( "landing_pad_workers_02", 1 );
}

worker_spawn_func()
{
    self endon( "death" );
    maps\_utility::ai_ignore_everything();
    self.animname = "generic";
    maps\_utility::set_generic_idle_anim( "patrol_idle_cool" );
    common_scripts\utility::flag_wait( "_stealth_spotted" );
    maps\_utility::set_generic_run_anim( "patrol_walk_alert", 1 );
    var_0 = common_scripts\utility::getstruct( self.script_noteworthy + "_struct", "script_noteworthy" );
    maps\_utility::set_ignoreall( 1 );
    maps\_utility::set_ignoreme( 1 );
    maps\_utility::set_goal_radius( 32 );
    maps\_utility::set_fixednode_true();
    maps\_utility::set_forcegoal();
    self _meth_81A6( var_0.origin );
    self waittill( "goal" );
    maps\_anim::anim_loop_solo( self, "landing_pad_worker_cower_idle" );
}

stairwell_doors()
{
    if ( !isdefined( level.anim_struct_exfil ) )
        level.anim_struct_exfil = common_scripts\utility::getstruct( "anim_struct_exfil", "targetname" );

    level.lower_stairwell_door = maps\_utility::spawn_anim_model( "lower_stairwell_door" );
    level.anim_struct_exfil maps\_anim::anim_first_frame_solo( level.lower_stairwell_door, "lower_stairwell_door" );
    var_0 = maps\_utility::spawn_anim_model( "upper_stairwell_door_left" );
    var_1 = maps\_utility::spawn_anim_model( "upper_stairwell_door_right" );
    level.anim_struct_exfil maps\_anim::anim_first_frame( [ var_0, var_1 ], "upper_stairwell_doors" );
    wait 0.05;
    var_2 = getent( "lower_stairwell_door_clip", "targetname" );
    var_2 _meth_804D( level.lower_stairwell_door, "tag_origin" );
    var_3 = getent( "upper_stairwell_door_left_clip", "targetname" );
    var_3 _meth_804D( var_0, "tag_origin" );
    var_4 = getent( "upper_stairwell_door_right_clip", "targetname" );
    var_4 _meth_804D( var_1, "tag_origin" );
    level.allies[0] waittillmatch( "single anim", "door_open" );
    level.anim_struct_exfil maps\_anim::anim_single_solo( level.lower_stairwell_door, "lower_stairwell_door" );
    level.allies[0] waittillmatch( "single anim", "door_open" );
    level.vtol thread vtolfx();
    level.vtol thread vtol_exhaust();
    level.anim_struct_exfil maps\_anim::anim_single( [ var_0, var_1 ], "upper_stairwell_doors" );
}

exfil_allies()
{
    var_0 = maps\_utility::array_spawn_targetname( "exfil_diver", 1 );
    var_0[0].animname = "exfil_ally1";
    var_0[1].animname = "exfil_ally2";

    foreach ( var_2 in var_0 )
    {
        var_2.grapple_magnets = [];
        var_2 maps\_utility::gun_remove();
        var_2.name = " ";
    }

    level.anim_struct_exfil maps\_anim::anim_first_frame( var_0, "exfil" );
    level.vtol waittillmatch( "single anim", "ally_anim_start" );
    thread detach_motion_blur_disable();
    maps\_utility::stop_exploder( 10 );
    common_scripts\_exploder::exploder( 16 );
    level.anim_struct_exfil maps\_anim::anim_single( var_0, "exfil" );
}

plant_tracker_vo()
{
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_onme3" );
    wait 1.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_goingaftercargo" );
    wait 1.0;
    maps\_utility::smart_radio_dialogue( "ie_nox_jetloaded" );
    wait 1.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_pointdelta" );
    common_scripts\utility::flag_wait( "start_exfil_moment_final" );
    wait 0.5;
    level.allies[0] maps\_utility::smart_dialogue( "crsh_crmk_dropemquick" );
    level.allies[0] maps\_utility::smart_dialogue( "crsh_crmk_clearemout" );
    wait 1.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_run1" );
    wait 1.0;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_grappleready1" );
    level.allies[0] maps\_utility::smart_dialogue( "crsh_crmk_gogogo" );
}

plant_tracker_waits()
{
    level.exfil_arms waittillmatch( "single anim", "enable_movement" );
    level.player _meth_80A2( 0.5, 0.25, 0.25, 10, 10, 10, 10 );
    level.exfil_arms waittillmatch( "single anim", "disable_movement" );
    level.player _meth_80A2( 1.0, 0.25, 0.25, 0, 0, 0, 0 );
    level.exfil_arms waittillmatch( "single anim", "fade_start" );
    maps\_utility::nextmission();
}

plant_tracker_rumbles()
{
    level.player waittill( "grappled_to_vtol" );
    var_0 = level.player maps\_utility::get_rumble_ent( "ie_vtol_ride_rumble_low" );
    var_0 maps\_utility::set_rumble_intensity( 0.5 );
    level.vtol waittillmatch( "single anim", "rumble_heavy1" );
    var_0 delete();
    var_0 = level.player maps\_utility::get_rumble_ent( "ie_vtol_ride_rumble" );
    var_0 thread maps\_utility::rumble_ramp_to( 0.3, 2.0 );
    common_scripts\utility::flag_wait( "DETACHED_FROM_VTOL" );
    var_0 maps\_utility::rumble_ramp_off( 3.0 );
    level.exfil_arms waittillmatch( "single anim", "player_impact_water_rumble" );
    var_0 = level.player maps\_utility::get_rumble_ent( "ie_vtol_ride_rumble" );
    var_0 maps\_utility::set_rumble_intensity( 0.5 );
    wait 0.1;
    var_0 maps\_utility::rumble_ramp_off( 2.0 );
}

tracking_device_waits()
{
    level.vtol waittillmatch( "single anim", "tracker_anim_start" );
    level.tracking_device show();
    level.tracking_device maps\_anim::anim_single_solo( level.tracking_device, "tracking_device_plant" );
}

breathers()
{
    var_0 = maps\_utility::spawn_anim_model( "generic_prop_raven" );
    var_0 hide();
    level.anim_struct_exfil maps\_anim::anim_first_frame_solo( var_0, "exfil_breathers" );
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 _meth_80B1( "udt_respirator_small" );
    var_1 _meth_804D( var_0, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2 _meth_80B1( "udt_respirator_small" );
    var_2 _meth_804D( var_0, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.vtol waittillmatch( "single anim", "ally_anim_start" );
    thread sentinel_team_vo();
    level.anim_struct_exfil maps\_anim::anim_single_solo( var_0, "exfil_breathers" );
}

detach_motion_blur_enable()
{
    _func_0D3( "r_mbEnable", 2 );
    _func_0D3( "r_mbVelocityScalar", 4 );
}

detach_motion_blur_disable()
{
    _func_0D3( "r_mbEnable", 0 );
    _func_0D3( "r_mbVelocityScalar", 1 );
}

running_up_the_stairs_fail()
{
    level endon( "start_exfil_moment" );
    wait 5;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_moveit3" );
    wait 5;
    level.allies[0] maps\_utility::smart_dialogue( "ie_crmk_takeoff" );
    wait 5;
    maps\_player_death::set_deadquote( &"IRONS_ESTATE_VTOL_GRAPPLE_FAIL" );
    maps\_utility::missionfailedwrapper();
}

landing_pad_lights_off()
{
    var_0 = getent( "landing_pad_lights", "targetname" );
    var_0 hide();
}

landing_pad_lights_on()
{
    var_0 = getent( "landing_pad_lights", "targetname" );
    var_0 show();
}

sentinel_team_vo()
{
    wait 7.0;
    maps\_utility::smart_radio_dialogue( "ie_ss1_getem" );
    wait 1.0;
    maps\_utility::smart_radio_dialogue( "ie_kp_bringemhome" );
}

cloud_fx()
{
    common_scripts\utility::flag_wait( "player_started_vtol_grapple" );
    common_scripts\_exploder::exploder( 11 );
    common_scripts\_exploder::exploder( 12 );
}

dive_fx()
{
    common_scripts\utility::flag_wait( "DETACHED_FROM_VTOL" );
    maps\_utility::stop_exploder( 11 );
    maps\_utility::stop_exploder( 12 );
    wait 1.4;
    common_scripts\_exploder::exploder( 10 );
}

landing_pad_lift_upper_static_setup()
{
    var_0 = getent( "landing_pad_lift_upper_static", "targetname" );
    var_0 hide();
    var_0 _meth_82BF();
    common_scripts\utility::flag_wait( "start_exfil_moment_final" );
    level.anim_struct_exfil maps\_anim::anim_first_frame_solo( level.lower_stairwell_door, "lower_stairwell_door" );
    var_0 show();
    var_0 _meth_82BE();
    var_1 = getent( "landing_pad_lift", "targetname" );
    var_1 delete();
}
