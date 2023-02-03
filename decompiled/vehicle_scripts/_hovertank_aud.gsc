// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hovertank_constructor()
{
    var_0 = "ht_engine_idle";
    var_1 = "ht_engine_noise";
    var_2 = "ht_engine_drive";
    var_3 = "ht_engine_synth";
    var_4 = "ht_turret_rotate";
    var_5 = "ht_turret_grind";
    var_6 = "ht_turret_tilt";
    var_7 = "ht_thruster";
    var_8 = "ht_repulsor_front_left";
    var_9 = "ht_repulsor_front_right";
    var_10 = "ht_repulsor_back_left";
    var_11 = "ht_repulsor_back_right";
    var_12 = "ht_uprighting";
    var_13 = "ht_engine_autoyaw";
    var_14 = "ht_turret_start";
    var_15 = "ht_turret_stop";
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "hovertank", ::hovertank_init );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_drive_throt2vol", [ [ 0.0, 0.05 ], [ 0.5, 0.2 ], [ 0.75, 0.5 ], [ 0.85, 0.6 ], [ 1.0, 0.35 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_drive_throt2pch", [ [ 0.0, 0.75 ], [ 0.55, 1.0 ], [ 1.0, 1.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_rumble_throt2vol", [ [ 0.0, 0.3 ], [ 0.3, 0.6 ], [ 1.0, 0.35 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_rumble_throt2pch", [ [ 0.0, 1.0 ], [ 1.0, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_noise_throt2vol", [ [ 0.0, 0.0 ], [ 0.5, 0.1 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_synth_throt2vol", [ [ 0.0, 0.0 ], [ 0.3, 0.02 ], [ 0.4, 0.1 ], [ 0.7, 0.4 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_synth_throt2pch", [ [ 0.0, 0.75 ], [ 0.75, 1.0 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_repulsor2vol", [ [ 0.0, 0.0 ], [ 0.23, 1.0 ], [ 0.25, 0.1 ], [ 1.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_repulsor2pch", [ [ 0.0, 1.0 ], [ 1.0, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_uprighting2vol", [ [ 0.0, 0.0 ], [ 0.01, 0.01 ], [ 0.02, 0.04 ], [ 0.025, 0.09 ], [ 0.04, 0.18 ], [ 0.06, 0.5 ], [ 0.1, 0.9 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_uprighting2pch", [ [ 0.0, 0.6 ], [ 0.025, 1.0 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_autoyaw2vol", [ [ 0.0, 0.0 ], [ 0.15, 0.1 ], [ 0.25, 0.75 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_autoyaw2pch", [ [ 0.0, 0.75 ], [ 0.4, 1.0 ], [ 1.0, 1.25 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_rotate_yaw2vol", [ [ 0.0, 0.0 ], [ 0.0523, 0.6545 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_rotate_yaw2pch", [ [ 0.0, 0.85 ], [ 0.1, 0.95 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_grind_yaw2vol", [ [ 0.0, 0.0 ], [ 0.1, 0.35 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_grind_yaw2pch", [ [ 0.0, 0.95 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_pitch_pch2vol", [ [ 0.0, 0.0 ], [ 0.1, 0.3 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "ht_turret_pitch_pch2pch", [ [ 0.0, 0.95 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_0 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_throttle_magnitude", 0.2, 0.06 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_rumble_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_rumble_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_2 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_throttle_magnitude", 0.15, 0.03 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_drive_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_drive_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_throttle_magnitude", 0.02, 0.2 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_noise_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_3 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_throttle_magnitude", 0.05, 0.15 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_synth_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_synth_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_8 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_repulsor_front_left", 0.75, 0.75 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_repulsor2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_repulsor2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_9 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_repulsor_front_right", 0.75, 0.75 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_repulsor2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_repulsor2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_10 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_repulsor_back_left", 0.75, 0.75 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_repulsor2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_repulsor2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_11 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_repulsor_back_right", 0.75, 0.75 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_repulsor2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_repulsor2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_12 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_uprighting", 0.6, 0.09 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_uprighting2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_uprighting2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_13 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_auto_yaw_magnitude", 0.3, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_autoyaw2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_autoyaw2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_4 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_turret_yaw", 0.6, 0.7 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_turret_rotate_yaw2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_turret_rotate_yaw2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( var_5 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "hovertank_turret_yaw", 0.4, 0.4 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "ht_turret_grind_yaw2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "ht_turret_grind_yaw2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( var_7 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( var_14 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "ht_turret_stop", "ht_turret_stop_duck_envelope", 0.25 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off", ::ht_condition_callback_to_state_off, [ "hovertank_throttle_magnitude" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle", ::ht_condition_callback_to_state_idle, [ "hovertank_throttle_magnitude" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_moving", ::ht_condition_callback_to_state_moving, [ "hovertank_throttle_magnitude" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( var_7 );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_destruct", ::ht_condition_callback_to_state_destruct );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_turret_state_off", ::ht_turret_condition_callback_to_state_off, [ "hovertank_turret_yaw" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_stationary", ::ht_turret_condition_callback_to_state_stationary, [ "hovertank_turret_yaw" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_rotating", ::ht_turret_condition_callback_to_state_rotating, [ "hovertank_turret_yaw" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_turret_state_destruct", ::ht_turret_condition_callback_to_state_destruct );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.05, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "test_state_group", "state_off", "to_state_off", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_moving", "to_state_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "ht_turret", "turret_state_off", "to_turret_state_off", 50, 0.25 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "turret_state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_stationary", "to_state_stationary" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "turret_state_destruct", "to_turret_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_stationary" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rotating", "to_state_rotating" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "turret_state_destruct", "to_turret_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_rotating" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_stationary", "to_state_stationary" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "turret_state_destruct", "to_turret_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "turret_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "turret_state_off", "to_turret_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

hovertank_init( var_0 )
{
    soundscripts\_snd::snd_register_message( "hovertank_missile_small_start", ::hovertank_missile_small_start );
    soundscripts\_snd::snd_register_message( "hovertank_missile_small_stop", ::hovertank_missile_small_stop );
    soundscripts\_snd::snd_register_message( "hovertank_missile_small_slow", ::hovertank_missile_small_slow );
    soundscripts\_snd::snd_register_message( "hovertank_cannon_fire", ::hovertank_cannon_fire );
    soundscripts\_snd::snd_register_message( "hovertank_antiair_fire", ::hovertank_antiair_fire );
    soundscripts\_snd::snd_register_message( "hovertank_switch_to_emp", ::hovertank_switch_to_emp );
    soundscripts\_snd::snd_register_message( "hovertank_switch_to_cannon", ::hovertank_switch_to_cannon );
    soundscripts\_snd::snd_register_message( "hovertank_switch_to_missile", ::hovertank_switch_to_missile );
    soundscripts\_snd::snd_register_message( "hovertank_antiair_recoil", ::hovertank_antiair_recoil );
    soundscripts\_snd::snd_register_message( "hovertank_barrel_turn", ::hovertank_barrel_turn );
    soundscripts\_snd::snd_register_message( "ht_cannon_reload", ::ht_cannon_reload );
    soundscripts\_snd::snd_register_message( "hovertank_trophy_system", ::hovertank_trophy_system );
    soundscripts\_snd::snd_register_message( "defenseless_tank_impact", ::defenseless_tank_impact );
    var_1 = self;
    var_2 = var_1 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_2 thread monitor_tank_health();
}

hovertank_missile_small_start()
{
    level endon( "hovertank_end" );
    wait 0.1;
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_missile_one_shot" );
    soundscripts\_audio::deprecated_aud_play_linked_sound( "ht_missile_start", level.player, "loop", "notify_hovertank_missile_small_stop_loop", undefined, undefined, undefined, 0.1 );
    var_0 = "ht_missile_tail";
    var_1 = "level_notify_kill_missile_tail_fast";

    while ( level.gun_state == "full_loop" )
    {
        thread play_missile_whoosh_thread( var_0, var_1 );
        wait(randomfloatrange( 0.08, 0.4 ));
    }

    level notify( var_1 );
}

hovertank_missile_small_slow()
{
    level endon( "hovertank_end" );
    wait 0.1;
    level notify( "notify_hovertank_missile_small_stop_loop" );
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_missile_reload" );
    soundscripts\_audio::deprecated_aud_play_linked_sound( "ht_missile_slow", level.player, "loop", "notify_hovertank_missile_small_stop_loop", undefined, undefined, undefined, 0.1 );
    var_0 = "ht_missile_tail";
    var_1 = "level_notify_kill_missile_tail_slow";

    while ( level.gun_state == "slow_loop" )
    {
        thread play_missile_whoosh_thread( var_0, var_1 );
        wait(randomfloatrange( 0.1, 0.7 ));
    }

    level notify( var_1 );
}

hovertank_missile_small_stop()
{
    level notify( "notify_hovertank_missile_small_stop_loop" );
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_missile_recoil" );
}

play_missile_whoosh_thread( var_0, var_1 )
{
    level endon( "hovertank_end" );
    var_2 = spawn( "script_origin", level.player.origin );
    var_2 soundscripts\_snd_playsound::snd_play( var_0, "sounddone" );
    var_2 thread monitor_missile_snd_ent( "sounddone" );
    var_2 thread monitor_missile_fire_done( var_1 );
    var_2 waittill( "notify_kill_missile_tail_snd_ent" );

    if ( isdefined( var_2 ) )
    {
        var_3 = 0.5;
        var_2 scalevolume( 0, var_3 );
        wait(var_3);

        if ( isdefined( var_2 ) )
        {
            var_2 soundscripts\_snd_playsound::snd_stop_sound();
            var_2 delete();
        }
    }
}

monitor_missile_snd_ent( var_0 )
{
    var_1 = self;
    var_1 endon( "notify_kill_missile_tail_snd_ent" );
    var_1 waittill( var_0 );
    var_1 notify( "notify_kill_missile_tail_snd_ent" );
}

monitor_missile_fire_done( var_0 )
{
    var_1 = self;
    var_1 endon( "notify_kill_missile_tail_snd_ent" );
    level waittill( var_0 );
    var_1 notify( "notify_kill_missile_tail_snd_ent" );
}

hovertank_cannon_fire()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_cannon_fire" );
}

hovertank_antiair_fire()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_antiair_fire" );
}

hovertank_barrel_turn()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_barrel_turn" );
}

hovertank_antiair_recoil()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_antiair_recoil" );
}

hovertank_switch_to_emp()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_barrel_swch2emp" );
}

hovertank_switch_to_cannon()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_barrel_swch2cannon" );
}

hovertank_switch_to_missile()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_missile_equip" );
}

ht_cannon_reload()
{
    var_0 = soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_cannon_reload" );
    level waittill( "kill_reload_sound" );
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_cannon_reload_stop" );

    if ( isdefined( var_0 ) )
        var_0 scalevolume( 0, 0.1 );
}

monitor_tank_health()
{
    var_0 = self;
    var_1 = var_0.health;
    var_2 = undefined;

    while ( isdefined( var_0 ) )
    {
        var_3 = var_0.health;

        if ( !isdefined( var_2 ) && var_3 <= 23000 )
        {
            var_2 = spawn( "script_origin", level.player.origin );
            soundscripts\_snd_playsound::snd_play_loop( "ht_damage_alarm" );
            level waittill( "hovertank_end" );
            soundscripts\_audio::aud_fade_out_and_delete( var_2, 0.25 );
            break;
        }

        var_1 = var_3;
        wait 0.5;
    }
}

hovertank_trophy_system( var_0 )
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_trophy_shot" );
    soundscripts\_audio::deprecated_aud_play_sound_at( "ht_trophy_intercept", var_0.origin );
}

defenseless_tank_impact()
{
    soundscripts\_audio::deprecated_aud_play_2d_sound( "ht_trophy_empty_hit" );
}

ht_condition_callback_to_state_off( var_0, var_1 )
{
    return 0;
}

ht_condition_callback_to_state_idle( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["hovertank_throttle_magnitude"];

    if ( !isdefined( var_1.prev_throttle ) )
    {
        var_1.prev_throttle = var_3;
        var_2 = 1;
    }
    else if ( var_1.prev_throttle > 0.001 && var_3 <= 0.001 )
    {
        var_1.prev_throttle = var_3;
        var_2 = 1;
    }

    return var_2;
}

ht_condition_callback_to_state_moving( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["hovertank_throttle_magnitude"];

    if ( isdefined( var_1.prev_throttle ) && var_1.prev_throttle <= 0.001 && var_3 > 0.001 )
        var_2 = 1;

    var_1.prev_throttle = var_3;
    return var_2;
}

ht_condition_callback_to_state_destruct( var_0, var_1 )
{
    return 0;
}

ht_turret_condition_callback_to_state_off( var_0, var_1 )
{
    return 0;
}

ht_turret_condition_callback_to_state_stationary( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["hovertank_turret_yaw"];

    if ( !isdefined( var_1.prev_turret_state ) )
    {
        var_1.prev_turret_state = var_3;
        var_2 = 1;
    }
    else if ( var_1.prev_turret_state > 0.001 && var_3 <= 0.001 )
    {
        var_1.prev_turret_state = var_3;
        var_2 = 1;
    }

    return var_2;
}

ht_turret_condition_callback_to_state_rotating( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["hovertank_turret_yaw"];

    if ( !isdefined( var_1.prev_turret_state ) )
        var_1.prev_turret_state = var_3;
    else if ( var_1.prev_turret_state <= 0.001 && var_3 > 0.001 )
    {
        var_1.prev_turret_state = var_3;
        var_2 = 1;
    }

    return var_2;
}

ht_turret_condition_callback_to_state_destruct( var_0, var_1 )
{
    return 0;
}
