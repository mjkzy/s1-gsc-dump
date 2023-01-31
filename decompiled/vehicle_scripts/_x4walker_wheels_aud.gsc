// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

snd_init_x4_walker_wheels()
{
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_zvelocity_front_left", ::x4ww_input_callback_wheel_zvelocity_front_left );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_zvelocity_front_right", ::x4ww_input_callback_wheel_zvelocity_front_right );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_zvelocity_rear_left", ::x4ww_input_callback_wheel_zvelocity_rear_left );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_zvelocity_rear_right", ::x4ww_input_callback_wheel_zvelocity_rear_right );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_gun_pitch_rate", ::x4ww_input_callback_gun_pitch_rate );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_gun_yaw_rate", ::x4ww_input_callback_gun_yaw_rate );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_player_driver", ::x4ww_input_callback_player_driver );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_gun_pitch_rate2", ::x4ww_input_callback_gun_pitch_rate );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "x4ww_gun_yaw_rate2", ::x4ww_input_callback_gun_yaw_rate );
    soundscripts\_snd::snd_message( "snd_register_vehicle", "x4walker_wheels", ::snd_x4walker_wheels_constructor );
}

snd_start_x4_walker_wheels( var_0 )
{
    if ( isdefined( self.snd_instance ) )
    {
        wait 1;
        var_1 = 1;
        soundscripts\_snd::snd_message( "snd_stop_vehicle", var_1 );
        soundscripts\_snd::snd_message( "player_exit_walker" );
    }

    var_2 = spawnstruct();
    var_2.preset_name = "x4walker_wheels";
    var_2.player_mode = var_0 == "plr";
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_2 );
}

snd_x4walker_wheels_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "x4walker_wheels" );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3.0, 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "x4ww_idle" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_idle_vel2vol", "x4_idle_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "x4ww_move" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_move_vel2vol", "x4_move_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "x4_move_vel2pch", "x4_move_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "pitch" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "x4_move_pit2pch", "x4_move_pit2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "x4ww_move2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_move2_lp_vel2vol", "x4_move2_lp_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "x4_move2_lp_vel2pch", "x4_move2_lp_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "pitch" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "x4_move_pit2pch", "x4_move_pit2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_startup", "x4_startup_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_shutoff", "xwalk_shutoff_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_accel_hard", "xwalk_accel_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "acceleration_g", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_accel_1shot_accel2vol", "x4_accel_1shot_accel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_decel_1", "xwalk_stop_duck_envelope", 0.5, 1, [ "x4ww_decel" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_break_squeal_vel2vol", "x4_break_squeal_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_decel_2", "xwalk_stop_duck_envelope", 0.5, 1, [ "x4ww_decel", "x4ww_stop_squeal" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_break_squeal_vel2vol", "x4_break_squeal_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_stop_chuff", "xwalk_stop_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_chuff_vel2vol", "x4_chuff_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_suspen_bump_hard", "xwalk_stop_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "x4_chuff_vel2vol", "x4_chuff_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "x4ww_rotate_stop", "xwalk_stop_duck_envelope" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off", ::x4ww_condition_callback_to_state_off );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_startup", ::x4ww_condition_callback_to_state_startup );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "x4ww_startup" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_shutoff", ::x4ww_condition_callback_to_state_shutoff, [ "x4ww_player_driver" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "x4ww_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_enter_vehicle", ::x4ww_condition_callback_to_state_enter_vehicle, [ "x4ww_player_driver" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle", ::x4ww_condition_callback_to_state_idle, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_start_move", ::x4ww_condition_callback_to_state_start_move );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "x4ww_accel_hard" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_moving", ::x4ww_condition_callback_to_state_moving, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_breaking", ::x4ww_condition_callback_to_state_breaking );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "pitch", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_stop", ::x4ww_condition_callback_to_state_stopped, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "x4ww_stop_chuff" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_destruct", ::x4ww_condition_callback_to_state_destruct );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_wheels_neutral", ::x4ww_condition_callback_to_state_wheels_neutral );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_wheels_bump_impact", ::x4ww_condition_callback_to_state_wheels_bump_impact, [ "x4ww_zvelocity_front_left", "x4ww_zvelocity_front_right", "x4ww_zvelocity_rear_left", "x4ww_zvelocity_rear_right", "speed" ], 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "x4ww_suspen_bump_hard" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_turret_rotate", ::x4ww_condition_callback_to_state_turret_rotate );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_turret_rotate_accel", ::x4ww_condition_callback_to_state_turret_rotate_accel );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "x4ww_gun_yaw_rate", 1, 1 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.6, 0.6 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_turret_rotate_decel", ::x4ww_condition_callback_to_state_turret_rotate_decel );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_turret_stopped", ::x4ww_condition_callback_to_state_turret_stopped );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_turret_elevate", ::x4ww_condition_callback_to_state_turret_elevate );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_oneshots", "state_enter_vehicle", "to_state_enter_vehicle", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_enter_vehicle", "to_state_enter_vehicle" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_enter_vehicle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_startup", "to_state_startup" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_startup" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_start_move", "to_state_start_move" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_start_move", "to_state_start_move" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_shutoff", "to_state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_start_move" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_moving", "to_state_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_shutoff", "to_state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_stop", "to_state_stop" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_breaking", "to_state_breaking" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_breaking" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_stop", "to_state_stop" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_moving", "to_state_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_shutoff", "to_state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_start_move", "to_state_start_move" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_stop" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_shutoff", "to_state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_exit_vehicle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_breaking", "to_state_breaking" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_stop", "to_state_stop" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_shutoff", "to_state_shutoff" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_start_move", "to_state_start_move" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "wheel_legs", "state_wheels_neutral", "to_state_wheels_neutral", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_wheels_neutral" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_wheels_bump_impact", "to_state_wheels_bump_impact" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_wheels_neutral", "to_state_wheels_neutral" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_wheels_bump_impact" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_wheels_bump_impact", "to_state_wheels_bump_impact" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_wheels_neutral", "to_state_wheels_neutral" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "turret_rotate", "state_turret_rotate", "to_state_turret_rotate", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_turret_stopped" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate", "to_state_turret_rotate" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_turret_rotate" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate", "to_state_turret_rotate" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate_accel", "to_state_turret_rotate_accel" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate_decel", "to_state_turret_rotate_decel" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_turret_rotate_accel" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate_accel", "to_state_turret_rotate_accel" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_turret_rotate_decel" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate", "to_state_turret_rotate" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_rotate_accel", "to_state_turret_rotate_accel" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "turret_elevate", "state_turret_elevate", "to_state_turret_elevate", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_turret_elevate" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_turret_elevate", "to_state_turret_elevate" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_idle_vel2vol", [ [ 0, 0.8 ], [ 1.75, 0.3 ], [ 3.5, 0.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_move_vel2vol", [ [ 0, 0.0 ], [ 1.75, 0.9 ], [ 7, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_move2_lp_vel2vol", [ [ 0, 0.0 ], [ 1.75, 0.7 ], [ 7, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_chuff_vel2vol", [ [ 0, 0.75 ], [ 1, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_break_squeal_vel2vol", [ [ 0, 0.0 ], [ 7, 0.7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_rot_fast_vel2vol", [ [ -100, 0.6 ], [ -30, 0.2 ], [ 0, 0 ], [ 30, 0.2 ], [ 100, 0.6 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_rot_slow_vel2vol", [ [ -100, 0.6 ], [ -10, 0.5 ], [ 0, 0 ], [ 10, 0.5 ], [ 100, 0.6 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_rot_slow_vel2pit", [ [ -30, 0.7 ], [ 0, 0.5 ], [ 30, 0.7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_rot_fast_vel2pit", [ [ -150, 3 ], [ -30, 0.3 ], [ 0, 0 ], [ 30, 0.3 ], [ 150, 3 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_pitch_rate_vel2vol", [ [ -10, 0.6 ], [ -1, 0.4 ], [ 0, 0.0 ], [ 1, 0.4 ], [ 10, 0.6 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_pitch_rate_gate", [ [ -0.3, 1 ], [ -0.2, 0 ], [ 0, 0 ], [ 0.2, 0 ], [ 0.3, 1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_turret_pitch_rate_vel2pit", [ [ -100, 0.5 ], [ 0, 0.5 ], [ 100, 0.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_move_vel2pch", [ [ 0, 0.9 ], [ 7, 1.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_move2_lp_vel2pch", [ [ 0, 0.9 ], [ 2, 0.9 ], [ 7, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_sub_lp_vel2vol", [ [ 0, 0.2 ], [ 7, 0.4 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_veh_speed_to_turret_rot_vel2vol", [ [ 0, 1 ], [ 1.4, 0.0 ], [ 7, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_veh_speed_to_turret_rot_gate", [ [ -1, 1 ], [ 0, 0 ], [ 1, 1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_suspen_vel2vol", [ [ 0, 0 ], [ 7, 0.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_accel_1shot_accel2vol", [ [ 0, 1 ], [ 0.02, 1 ], [ 0.1, 1 ], [ 0.2, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "xwalk_accel_duck_envelope", [ [ 0.0, 1.0 ], [ 0.55, 0.4 ], [ 1.0, 0.6 ], [ 2.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "xwalk_accel2vol", [ [ 0, 0.7 ], [ 0.3, 0.7 ], [ 1.0, 0.7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "xwalk_vel2vol", [ [ 0, 1.0 ], [ 7, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_move_pit2pch", [ [ -2, 0.9 ], [ 0, 1.0 ], [ 2, 1.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "xwalk_stop_duck_envelope", [ [ 0.0, 1.0 ], [ 0.55, 0.8 ], [ 0.85, 0.8 ], [ 2.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "x4_startup_duck_envelope", [ [ 0.0, 0.0 ], [ 0.55, 0.1 ], [ 0.85, 0.2 ], [ 1.5, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "xwalk_shutoff_duck_envelope", [ [ 0.0, 1.0 ], [ 0.55, 0.4 ], [ 0.85, 0.3 ], [ 1.5, 0.0 ], [ 5.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

x4ww_condition_callback_to_state_off( var_0, var_1 )
{
    return 1;
}

x4ww_condition_callback_to_state_enter_vehicle( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["x4ww_player_driver"];

    if ( var_3 )
        var_2 = 1;

    return var_2;
}

x4ww_condition_callback_to_state_exit_vehicle( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["x4ww_player_driver"];

    if ( !var_3 )
        var_2 = 1;

    return var_2;
}

x4ww_condition_callback_to_state_startup( var_0, var_1 )
{
    var_1.g_xwalk_pitched_hard = 0;
    var_1.g_xwalk_was_stopped = 1;
    var_1.g_xwalk_vel_que = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
    var_1.g_turret_vel_array = [ 0, 0, 0, 0 ];
    var_1.g_xwalk_started_to_move = 0;
    return 1;
}

x4ww_condition_callback_to_state_shutoff( var_0, var_1 )
{
    var_2 = 0;
    return var_2;
}

x4ww_condition_callback_to_state_idle( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["speed"];

    if ( var_4 <= 0.0001 )
        var_2 = 1;

    return var_2;
}

x4ww_condition_callback_to_state_start_move( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = 0;

    if ( !isdefined( var_1.start_move ) )
    {
        var_1.start_move = spawnstruct();
        var_1.start_move.prev_velo = var_3;
        var_1.start_move.time_accel = 0;
        var_1.start_move.acceltime = 0;
        var_1.start_move.accelerating = 0;
        var_1.start_move.strain_accel_last_trigger = 0;
        var_1.start_move.strain_accel_time_since_trigger = 1000;
        var_1.start_move.rand_second_accel_thresh = randomintrange( 1500, 3500 );
    }
    else
    {
        var_5 = var_3 - var_1.start_move.prev_velo;

        if ( var_1.start_move.accelerating == 0 && var_5 > 0 )
        {
            var_1.start_move.accelerating = 1;
            var_1.start_move.acceltime = gettime();
        }
        else if ( var_1.start_move.accelerating == 1 && var_5 > 0 )
            var_1.start_move.time_accel = var_1.start_move.time_accel + gettime() - var_1.start_move.acceltime;
        else if ( var_5 <= 0 || var_3 >= 7 )
        {
            var_1.start_move.accelerating = 0;
            var_1.start_move.acceltime = 0;
            var_1.start_move.time_accel = 0;
        }

        var_4 = gettime() - var_1.g_xwalk_started_to_move;

        if ( var_1.g_xwalk_pitched_hard == 1 && var_5 > 0 )
        {
            var_6 = gettime() - var_1.start_move.strain_accel_last_trigger;

            if ( var_6 > 4000 )
            {
                var_2 = 1;
                var_1.g_xwalk_started_to_move = gettime();
                var_1.start_move.acceltime = 0;
                var_1.start_move.accelerating = 0;
                var_1.start_move.time_accel = 0;
                var_1.g_xwalk_pitched_hard = 0;
                var_1.start_move.strain_accel_last_trigger = gettime();
                var_1.g_xwalk_was_stopped = 0;
            }
        }
        else if ( var_1.start_move.time_accel > 400 && var_5 > 0.1 && var_1.g_xwalk_was_stopped )
        {
            var_2 = 1;
            var_1.g_xwalk_started_to_move = gettime();
            var_1.start_move.acceltime = 0;
            var_1.start_move.accelerating = 0;
            var_1.start_move.time_accel = 0;
            var_1.g_xwalk_was_stopped = 0;
        }
        else if ( var_3 > 2 && var_4 > var_1.start_move.rand_second_accel_thresh && var_4 < var_1.start_move.rand_second_accel_thresh + 500 )
        {
            var_2 = 1;
            var_1.start_move.acceltime = 0;
            var_1.start_move.accelerating = 0;
            var_1.start_move.time_accel = 0;
            var_1.g_xwalk_was_stopped = 0;
            var_1.start_move.rand_second_accel_thresh = randomintrange( 1500, 3500 );
        }
        else if ( var_3 >= 7 && var_1.g_xwalk_was_stopped )
        {
            var_2 = 1;
            var_1.g_xwalk_started_to_move = gettime();
            var_1.start_move.acceltime = 0;
            var_1.start_move.accelerating = 0;
            var_1.start_move.time_accel = 0;
            var_1.g_xwalk_was_stopped = 0;
        }

        var_1.start_move.prev_velo = var_3;
    }

    return var_2;
}

x4ww_condition_callback_to_state_moving( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( var_3 > 0.1 )
        var_2 = 1;

    return var_2;
}

x4ww_condition_callback_to_state_breaking( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["pitch"];
    var_5 = gettime() - var_1.g_xwalk_started_to_move;

    if ( !isdefined( var_1.breaking ) )
    {
        var_1.breaking = spawnstruct();
        var_1.breaking.prev_velo = var_3;
        var_1.breaking.time_breaking = 0;
        var_1.breaking.breaktime = 0;
        var_1.breaking.is_breaking = 0;
        var_1.breaking.prev_pitch = 0;
        var_1.breaking.prev_dp = 0;
        var_1.breaking.time_pitching_hard = 0;
        var_1.breaking.pitching_hard = 0;
        var_1.breaking.pitching_hard_start_time = 0;
    }
    else
    {
        var_6 = var_4 - var_1.breaking.prev_pitch;

        if ( abs( var_6 ) > 0.5 && var_1.g_xwalk_pitched_hard == 0 )
        {
            var_2 = [ "x4ww_decel_1" ];
            var_1.g_xwalk_pitched_hard = 1;
        }

        var_7 = var_3 - var_1.breaking.prev_velo;

        if ( var_1.breaking.is_breaking == 0 && var_7 < 0 )
        {
            var_1.breaking.is_breaking = 1;
            var_1.breaktime = gettime();
        }
        else if ( var_1.breaking.is_breaking == 1 && var_7 < 0 )
            var_1.breaking.time_breaking = var_1.breaking.time_breaking + gettime() - var_1.breaking.breaktime;
        else if ( var_7 >= 0 )
        {
            var_1.breaking.breaking = 0;
            var_1.breaking.breaktime = 0;
            var_1.breaking.time_breaking = 0;
        }

        if ( var_1.breaking.time_breaking > 400 && var_7 < -0.6 && var_5 > 2000 )
        {
            var_1.breaking.breaktime = 0;
            var_1.breaking.breaking = 0;
            var_1.breaking.time_breaking = 0;
            var_2 = [ "x4ww_decel_2" ];
        }
        else if ( var_1.breaking.time_breaking > 400 && var_7 < -0.6 && var_5 <= 2000 )
        {
            var_1.breaking.breaktime = 0;
            var_1.breaking.breaking = 0;
            var_1.breaking.time_breaking = 0;
            var_2 = [ "x4ww_decel_1" ];
        }
        else if ( var_3 < 0.1 )
        {
            var_2 = 1;
            var_1.breaking.breaktime = 0;
            var_1.breaking.breaking = 0;
            var_1.breaking.time_breaking = 0;
            var_2 = [ "x4ww_decel_1" ];
        }

        var_1.breaking.prev_velo = var_3;
        var_1.breaking.prev_pitch = var_4;
    }

    return var_2;
}

x4ww_condition_callback_to_state_stopped( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( !isdefined( var_1.stopped ) )
    {
        var_1.stopped = spawnstruct();
        var_1.stopped.prev_velo = var_3;
        var_1.stopped.prev_dv = 0;
    }
    else
    {
        var_4 = var_3 - var_1.stopped.prev_velo;

        if ( var_3 < 0.1 )
        {
            var_2 = 1;
            var_1.g_xwalk_was_stopped = 1;
        }

        var_1.stopped.prev_velo = var_3;
        var_1.stopped.prev_dv = var_4;
    }

    return var_2;
}

x4ww_condition_callback_to_state_destruct( var_0, var_1 )
{
    return 0;
}

x4ww_condition_callback_to_state_wheels_neutral( var_0, var_1 )
{
    return 0;
}

x4ww_condition_callback_to_state_wheels_bump_impact( var_0, var_1 )
{
    var_2 = [ "zv_front_left", "zv_front_right", "zv_rear_left", "zv_rear_right" ];
    var_3 = [];
    var_3["zv_front_left"] = var_0["x4ww_zvelocity_front_left"];
    var_3["zv_front_right"] = var_0["x4ww_zvelocity_front_right"];
    var_3["zv_rear_left"] = var_0["x4ww_zvelocity_rear_left"];
    var_3["zv_rear_right"] = var_0["x4ww_zvelocity_rear_right"];
    var_4 = var_0["speed"];
    var_5 = 0;

    if ( !isdefined( var_1.wheels_bump_impact ) )
    {
        var_1.wheels_bump_impact = spawnstruct();
        var_1.wheels_bump_impact.prev_zv = [];

        foreach ( var_7 in var_2 )
            var_1.wheels_bump_impact.prev_zv[var_7] = var_3[var_7];

        var_9 = 0;
    }
    else
    {
        foreach ( var_11 in var_2 )
        {
            var_9 = var_3[var_11] - var_1.wheels_bump_impact.prev_zv[var_11];

            if ( abs( var_9 ) > 2 && var_4 > 0 )
                var_5 = 1;

            var_1.wheels_bump_impact.prev_zv[var_11] = var_3[var_11];
        }
    }

    return var_5;
}

x4ww_condition_callback_to_state_turret_rotate( var_0, var_1 )
{
    var_2 = 0;
    return var_2;
}

x4ww_condition_callback_to_state_turret_stopped( var_0, var_1 )
{
    var_2 = 0;
    return var_2;
}

x4ww_condition_callback_to_state_turret_rotate_accel( var_0, var_1 )
{
    var_2 = 0;
    var_3 = abs( var_0["x4ww_gun_yaw_rate"] );
    var_4 = var_0["speed"];

    if ( !isdefined( var_1.turret_rotate_accel ) )
    {
        var_1.turret_rotate_accel = spawnstruct();
        var_1.turret_rotate_accel.prev_velo = var_3;
        var_1.turret_rotate_accel.prev_dv = 0;
        var_1.turret_rotate_accel.is_turret_accelerating = 0;
        var_1.turret_rotate_accel.time_turret_accelerating = 0;
        var_1.turret_rotate_accel.time_turret_accel_started = 0;
        var_1.turret_rotate_accel.time_last_turret_accel = 1000;
        var_1.turret_rotate_accel.can_turret_start_play = 1;
        var_1.turret_rotate_accel.time_turret_rotating = 0;
        var_1.turret_rotate_accel.is_turret_rotating = 0;
        var_1.turret_rotate_accel.time_turret_started_rotating = 0;
    }
    else
    {
        var_5 = var_3 - var_1.turret_rotate_accel.prev_velo;

        if ( var_1.turret_rotate_accel.is_turret_accelerating == 0 && var_5 > 0 )
        {
            var_1.turret_rotate_accel.is_turret_accelerating = 1;
            var_1.turret_rotate_accel.time_turret_accel_started = gettime();
        }
        else if ( var_1.turret_rotate_accel.is_turret_accelerating == 1 && var_5 > 0 )
            var_1.turret_rotate_accel.time_turret_accelerating = var_1.turret_rotate_accel.time_turret_accelerating + gettime() - var_1.turret_rotate_accel.time_turret_accel_started;
        else if ( var_5 <= 0 )
        {
            var_1.turret_rotate_accel.is_turret_accelerating = 0;
            var_1.turret_rotate_accel.time_turret_accelerating = 0;
            var_1.turret_rotate_accel.time_turret_accel_started = 0;
        }

        var_6 = gettime() - var_1.turret_rotate_accel.time_last_turret_accel;

        if ( var_3 > 0.1 && var_1.turret_rotate_accel.is_turret_rotating == 0 )
        {
            if ( var_3 > 2 && var_5 > 0.05 && var_1.turret_rotate_accel.can_turret_start_play == 1 && var_4 < 0.1 )
            {
                var_2 = [ "x4ww_rotate_stop" ];
                var_1.turret_rotate_accel.time_last_turret_accel = gettime();
                var_1.turret_rotate_accel.can_turret_start_play = 0;
                var_1.turret_rotate_accel.time_turret_started_rotating = gettime();
                var_1.turret_rotate_accel.is_turret_rotating = 1;
            }
            else if ( var_3 > 0.5 && var_1.turret_rotate_accel.can_turret_start_play == 1 )
            {
                var_1.turret_rotate_accel.can_turret_start_play = 0;
                var_1.turret_rotate_accel.time_turret_started_rotating = gettime();
                var_1.turret_rotate_accel.is_turret_rotating = 1;
            }
        }
        else if ( var_3 <= 0.1 && var_1.turret_rotate_accel.is_turret_rotating == 1 && var_4 < 0.1 )
        {
            var_7 = gettime() - var_1.turret_rotate_accel.time_turret_started_rotating;

            if ( var_7 > 1500 && var_1.turret_rotate_accel.can_turret_start_play == 0 )
            {
                var_2 = [ "x4ww_rotate_stop" ];
                var_1.turret_rotate_accel.can_turret_start_play = 1;
                var_1.turret_rotate_accel.is_turret_rotating = 0;
                var_7 = 0;
            }
            else if ( var_7 <= 1500 )
            {
                var_1.turret_rotate_accel.is_turret_rotating = 0;
                var_1.turret_rotate_accel.can_turret_start_play = 1;
                var_7 = 0;
            }
        }
        else if ( var_3 <= 0.1 && var_1.turret_rotate_accel.is_turret_rotating == 1 && var_4 >= 0.1 )
        {
            var_1.turret_rotate_accel.is_turret_rotating = 0;
            var_1.turret_rotate_accel.can_turret_start_play = 1;
            var_7 = 0;
        }

        var_1.turret_rotate_accel.prev_velo = var_3;
        var_1.turret_rotate_accel.prev_dv = var_5;
    }

    return var_2;
}

x4ww_condition_callback_to_state_turret_rotate_decel( var_0, var_1 )
{
    var_2 = 0;
    return var_2;
}

x4ww_condition_callback_to_state_turret_elevate( var_0, var_1 )
{
    var_2 = 0;
    return var_2;
}

x4ww_input_callback_wheel_zvelocity_front_left()
{
    return x4ww_input_callback_wheel_zvelocity( "tag_wheel_front_left" );
}

x4ww_input_callback_wheel_zvelocity_front_right()
{
    return x4ww_input_callback_wheel_zvelocity( "tag_wheel_front_right" );
}

x4ww_input_callback_wheel_zvelocity_rear_left()
{
    return x4ww_input_callback_wheel_zvelocity( "tag_wheel_back_left" );
}

x4ww_input_callback_wheel_zvelocity_rear_right()
{
    return x4ww_input_callback_wheel_zvelocity( "tag_wheel_back_right" );
}

x4ww_input_callback_wheel_zvelocity( var_0 )
{
    var_1 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_2 = var_1 vehicle_scripts\_x4walker_wheels::get_wheel_velocity( var_0 );
    var_3 = var_2[2];
    return var_3;
}

x4ww_input_callback_gun_pitch_rate()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_1 = 0;
    return var_1;
}

x4ww_input_callback_gun_yaw_rate()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_1 = 0;
    return var_1;
}

x4ww_input_callback_player_driver()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    return isdefined( var_0.player_driver );
}

push_item_on_que( var_0, var_1 )
{
    for ( var_2 = var_0.size - 1; var_2 > 0; var_2-- )
        var_0[var_2] = var_0[var_2 - 1];

    var_0[0] = var_1;
    return var_0;
}

get_average_in_que( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_1 += var_0[var_2];

    var_3 = var_1 / var_0.size;
    return var_3;
}
