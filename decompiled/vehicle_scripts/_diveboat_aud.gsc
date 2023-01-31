// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

diveboat_constructor()
{
    var_0 = 0;
    var_1 = 60;
    var_2 = -2;
    var_3 = 2;
    var_4 = 0.0;
    var_5 = 1.0;
    var_6 = 0.0;
    var_7 = 1.0;
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "diveboat" );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_water_idle_spd2vol", [ [ 0.0, 0.65 ], [ 100.796, 0.2 ], [ 450.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_idle_spd2pch", [ [ 0.0, 0.625 ], [ 100.796, 0.625 ], [ 450.0, 0.625 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_idle_spd2vol", [ [ 0.0, 0.8 ], [ 50.2613, 0.5 ], [ 100.0, 0.25 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_high_throt2vol", [ [ 0.0, 0.1 ], [ 40.2755, 0.2 ], [ 170.102, 0.4346 ], [ 290.501, 0.5864 ], [ 450.0, 0.6283 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_high_throt2pch", [ [ 0.0, 0.5 ], [ 25.6033, 0.6126 ], [ 45.4204, 0.7932 ], [ 100.62, 0.8252 ], [ 170.637, 0.9764 ], [ 310.211, 1.2937 ], [ 450.0, 1.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_throt2vol", [ [ 0.0, 0.5 ], [ 25.5, 0.75 ], [ 50.0689, 0.85 ], [ 100.672, 0.95 ], [ 125.451, 1.0 ], [ 150.651, 1.0 ], [ 250.012, 1.0 ], [ 330.884, 0.9891 ], [ 450.0, 0.9562 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_throt2pch", [ [ 0.0, 0.625 ], [ 10.6033, 0.7126 ], [ 30.4204, 0.852 ], [ 90.62, 0.9252 ], [ 170.637, 1.0 ], [ 250.637, 1.25 ], [ 310.211, 1.3 ], [ 450.0, 1.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_high_jump_throt2vol", [ [ 0.0, 0.0 ], [ 30.5725, 0.0 ], [ 36.9477, 0.0 ], [ 43.0333, 0.0 ], [ 53.4656, 0.3508 ], [ 57.8124, 0.5707 ], [ 61.0, 0.8534 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_high_jump_throt2pch", [ [ 0.0, 0.0314 ], [ 61.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_jump_throt2vol", [ [ 0.0, 0.5 ], [ 25.5, 0.85 ], [ 50.0689, 0.95 ], [ 100.672, 0.97 ], [ 125.451, 0.987 ], [ 450.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_jump_throt2pch", [ [ 0.0, 0.525 ], [ 10.6033, 0.6126 ], [ 30.4204, 0.652 ], [ 50.62, 1.375 ], [ 170.637, 1.4 ], [ 250.637, 1.5 ], [ 310.211, 1.6 ], [ 450.0, 2.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_ending_throt2vol", [ [ 0.0, 0.0 ], [ 50.0689, 0.0 ], [ 100.672, 0.25 ], [ 125.451, 0.3 ], [ 150.651, 0.5 ], [ 250.012, 0.6 ], [ 330.884, 0.9891 ], [ 450.0, 0.9562 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_engine_low_ending_throt2pch", [ [ 0.0, 0.625 ], [ 10.6033, 0.625 ], [ 30.4204, 0.625 ], [ 90.62, 0.625 ], [ 170.637, 1.0 ], [ 250.637, 1.25 ], [ 310.211, 1.3 ], [ 450.0, 1.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_drag_fast_drag2vol", [ [ 0.0, 0.0 ], [ 16.5677, 0.002 ], [ 18.5677, 0.25 ], [ 24.3705, 1.0 ], [ 45.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_drag_med_drag2vol", [ [ 0.0, 0.0 ], [ 10.0, 0.6 ], [ 50.5344, 0.7 ], [ 100.772, 0.8569 ], [ 150.071, 1.0 ], [ 240.798, 0.8 ], [ 320.28, 0.75 ], [ 450.0, 0.5141 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dvbt_drag_med_drag2pch", [ [ 0.0, 0.7 ], [ 50.0, 0.8 ], [ 130.254, 0.9 ], [ 450.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_idle" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.08, 0.06 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_idle_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_idle_spd2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_water_idle" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.3, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_water_idle_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_drive_high" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_throttle", 0.2, 0.06 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_high_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_engine_high_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_drive_low" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_throttle", 0.08, 0.2 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_low_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_engine_low_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_drive_high_jump" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_throttle", 0.1, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_high_jump_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_engine_high_jump_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_drive_low_jump", 0.1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_throttle", 0.9, 0.95 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_low_jump_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_engine_low_jump_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_drive_water_fast" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_drag_with_mph", 0.5, 0.2 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_drag_fast_drag2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_drive_water_med" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_drag_with_mph", 0.3, 0.4 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_drag_med_drag2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_drag_med_drag2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "dive_boat_engine_drive_low_ending" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "diveboat_throttle", 0.9, 0.05 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dvbt_engine_low_ending_throt2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "dvbt_engine_low_ending_throt2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "dive_boat_accel_one_shot", undefined, undefined, 2 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "dive_boat_drag_one_shot", undefined, undefined, 2 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle", ::diveboat_condition_callback_to_state_idle, [ "diveboat_throttle", "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "dive_boat_engine_idle", "dive_boat_water_idle", "dive_boat_engine_drive_low" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_throttling", ::diveboat_condition_callback_to_state_throttling, [ "diveboat_throttle", "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "dive_boat_engine_idle", "dive_boat_engine_drive_high", "dive_boat_engine_drive_low", "dive_boat_drive_water_fast", "dive_boat_drive_water_med" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "dive_boat_accel_one_shot" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_dragging", ::diveboat_condition_callback_to_state_dragging, [ "diveboat_throttle", "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "dive_boat_engine_idle", "dive_boat_engine_drive_high", "dive_boat_engine_drive_low" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "dive_boat_drag_one_shot" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_jumping", ::diveboat_condition_callback_to_state_jumping, [ "diveboat_throttle", "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "dive_boat_engine_idle", "dive_boat_engine_drive_low_jump" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_ending", ::diveboat_condition_callback_to_state_ending, [ "diveboat_throttle", "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "dive_boat_engine_idle", "dive_boat_engine_drive_low_ending" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "test_state_group", "state_idle", "to_state_idle", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_throttling", "to_state_throttling" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_ending", "to_state_ending" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_throttling" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_jumping", "to_state_jumping" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drag", "to_state_dragging" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_ending", "to_state_ending" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_drag" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_jumping", "to_state_jumping" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_throttling", "to_state_throttling" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_ending", "to_state_ending" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_jumping" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_throttling", "to_state_throttling" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drag", "to_state_dragging" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_ending", "to_state_ending" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_ending" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

diveboat_init( var_0 )
{

}

diveboat_condition_callback_to_state_idle( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["diveboat_throttle"];
    var_4 = var_0["speed_mph"];
    var_5 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_6 = var_5.origin[2];

    if ( !isdefined( var_1.prev_throttle ) || !isdefined( var_1.prev_speed ) || !isdefined( var_1.prev_height ) )
    {
        var_2 = 1;
        var_1.prev_throttle = var_3;
        var_1.prev_speed = var_4;
        var_1.prev_height = var_6;
    }
    else if ( var_3 <= 0.1 && var_4 <= 1.0 && var_1.prev_speed > 1.0 )
    {
        var_2 = 1;
        var_1.prev_throttle = var_3;
        var_1.prev_speed = var_4;
        var_1.prev_height = var_6;
    }

    return var_2;
}

diveboat_condition_callback_to_state_throttling( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["diveboat_throttle"];
    var_4 = var_0["speed_mph"];
    var_5 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_6 = var_5.origin[2];

    if ( isdefined( var_1.prev_throttle ) && var_1.prev_throttle <= 0.1 && var_3 > 0.1 )
        var_2 = 1;
    else if ( isdefined( var_1.prev_height ) && var_1.prev_height > -560 && var_6 <= -560 && var_3 > 0.1 )
        var_2 = 1;

    if ( var_6 <= -560 )
    {
        var_1.prev_throttle = var_3;
        var_1.prev_speed = var_4;
        var_1.prev_height = var_6;
    }

    return var_2;
}

diveboat_condition_callback_to_state_dragging( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["diveboat_throttle"];
    var_4 = var_0["speed_mph"];
    var_5 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_6 = var_5.origin[2];

    if ( isdefined( var_1.prev_throttle ) && var_1.prev_throttle > 0.1 && var_3 <= 0.1 && var_4 > 1.0 )
        var_2 = 1;
    else if ( isdefined( var_1.prev_height ) && var_1.prev_height > -560 && var_6 <= -560 && var_3 <= 0.1 )
        var_2 = 1;

    var_1.prev_throttle = var_3;
    var_1.prev_speed = var_4;
    var_1.prev_height = var_6;
    return var_2;
}

diveboat_condition_callback_to_state_jumping( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["diveboat_throttle"];
    var_4 = var_0["speed_mph"];
    var_5 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_6 = var_5.origin[2];

    if ( isdefined( var_1.prev_height ) && var_6 > -560 && var_1.prev_height <= -560 )
    {
        var_2 = 1;
        var_1.prev_throttle = var_3;
        var_1.prev_speed = var_4;
        var_1.prev_height = var_6;
    }

    return var_2;
}

diveboat_condition_callback_to_state_ending( var_0, var_1 )
{
    var_2 = 0;

    if ( isdefined( level.aud.diveboat_ending ) && level.aud.diveboat_ending == 1 )
        var_2 = 1;

    return var_2;
}
