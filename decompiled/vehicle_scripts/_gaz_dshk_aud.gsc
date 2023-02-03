// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

snd_init_gaz()
{
    soundscripts\_audio_vehicle_manager::avm_register_callback( "zvelocity", ::gaz_input_callback_zvelocity );
    soundscripts\_audio_vehicle_manager::avm_register_callback( "about_to_stop", ::gaz_input_callback_about_to_stop );
    soundscripts\_snd::snd_message( "snd_register_vehicle", "gaz_dshk", ::snd_gaz_dshk_constructor );
}

snd_start_gaz()
{
    if ( isdefined( self.snd_instance ) )
    {
        wait 1.0;
        snd_stop_gaz( 1.0 );
    }

    thread snd_monitor_new_path();
    var_0 = spawnstruct();
    var_0.preset_name = "gaz_dshk";
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}

snd_stop_gaz( var_0 )
{
    if ( isdefined( self.snd_instance ) )
    {
        soundscripts\_snd::snd_message( "snd_stop_vehicle", var_0 );
        self notify( "snd_stop_vehicle" );
    }
}

snd_monitor_new_path()
{
    self endon( "death" );
    self endon( "snd_stop_vehicle" );

    for (;;)
    {
        self.about_to_stop = undefined;
        thread snd_monitor_about_to_stop();
        self waittill( "newpath" );
    }
}

snd_monitor_about_to_stop()
{
    self endon( "newpath" );
    self endon( "death" );
    self endon( "snd_stop_vehicle" );
    self waittill( "about_to_stop", var_0 );

    if ( var_0 > 1.0 )
    {
        wait(var_0 - 1.0);

        if ( !isdefined( self ) )
            return;
    }

    self.about_to_stop = 1;
}

snd_gaz_dshk_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "gaz_dshk" );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "veh_gaz_idle_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "gaz_idle_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "veh_gaz_drive_slow_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "gaz_drive_slow_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "gaz_drive_slow_vel2pit" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "veh_gaz_drive_fast_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "gaz_drive_fast_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "gaz_drive_fast_vel2pit" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data( 0.5 );
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_shutoff_01", "gaz_shutoff_duck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_drive_offload_to_idle", "gaz_offload_duck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_stop_pavement", "gaz_noduck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_pull_away", "gaz_onload_from_idle_duck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_rev_single", "gaz_noduck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_drive_onload", "gaz_onload_duck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_drive_offload", "gaz_offload_duck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_bump_susp", "gaz_noduck" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "zvelocity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "gaz_bump_zvel2vol", "gaz_bump_zvel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_gaz_tire_chatter", "gaz_noduck" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off_initial", ::gaz_condition_callback_state_off );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off", ::gaz_condition_callback_to_off );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "veh_gaz_shutoff_01" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle_from_off", ::gaz_condition_callback_off_to_idle );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle_from_drive", ::gaz_condition_callback_drive_to_idle );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( [ "veh_gaz_drive_offload_to_idle", "veh_gaz_stop_pavement" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "about_to_stop", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_first_from_idle", ::gaz_condition_callback_idle_to_first );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( [ "veh_gaz_pull_away", "veh_gaz_rev_single" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.3, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "about_to_stop", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_second_from_first", ::gaz_condition_callback_first_to_second );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "veh_gaz_drive_onload" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.3, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_first_from_second", ::gaz_condition_callback_second_to_first );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "veh_gaz_drive_offload" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.3, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_wheels_bump", ::gaz_condition_callback_to_state_wheels_bump, [ "zvelocity" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_wheels_skid", ::gaz_condition_callback_to_state_wheels_skid, [ "yaw" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.3, 0.65 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "engine_oneshots", "state_off", "to_state_off_initial", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle_from_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drive_first_gear", "to_state_first_from_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_idle", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drive_first_gear", "to_state_first_from_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_drive_first_gear" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle_from_drive" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drive_second_gear", "to_state_second_from_first" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_drive_second_gear" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle_from_drive" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_drive_first_gear", "to_state_first_from_second" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "wheel_bumps", "wheels_bump_1", "to_state_wheels_bump", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "wheels_bump_1", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "wheels_bumps_2", "to_state_wheels_bump" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "wheels_bumps_2", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "wheels_bump_1", "to_state_wheels_bump" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "wheel_skids", "wheels_skid_1", "to_state_wheels_skid" );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "wheels_skid_1", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "wheels_skid_2", "to_state_wheels_skid" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "wheels_skid_2", 0.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "wheels_skid_1", "to_state_wheels_skid" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_linearvol", [ [ 0.0, 0.0 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_idle_vel2vol", [ [ 0.0, 0.5 ], [ 5.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_drive_slow_vel2vol", [ [ 1.0, 0.0 ], [ 10, 0.7 ], [ 17, 0.7 ], [ 27, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_drive_slow_vel2pit", [ [ 5, 0.85 ], [ 22, 1.15 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_drive_fast_vel2vol", [ [ 17, 0.0 ], [ 27, 0.7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_drive_fast_vel2pit", [ [ 22, 0.85 ], [ 45, 1.15 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_road_noise_vel2vol", [ [ 0.0, 0.0 ], [ 1.0, 0.7 ], [ 10.0, 0.7 ], [ 25.0, 0.25 ], [ 40.0, 0.7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_bump_zvel2vol", [ [ -60.0, 1.0 ], [ -40.0, 0.7 ], [ -20.0, 0.5 ], [ 0.0, 0.0 ], [ 20.0, 0.5 ], [ 40.0, 0.7 ], [ 60.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_shutoff_duck", [ [ 0.0, 0.0 ], [ 2.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_onload_from_idle_duck", [ [ 0.0, 0.5 ], [ 2.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_onload_duck", [ [ 0.0, 0.5 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_offload_duck", [ [ 0.0, 0.5 ], [ 1.5, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "gaz_noduck", [ [ 0.0, 1.0 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

gaz_input_callback_zvelocity()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_1 = var_0 maps\_shg_utility::get_differentiated_velocity();
    return var_1[2];
}

gaz_input_callback_about_to_stop()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    return isdefined( var_0.about_to_stop );
}

gaz_condition_callback_state_off( var_0, var_1 )
{
    return 0;
}

gaz_condition_callback_off_to_idle( var_0, var_1 )
{
    var_2 = var_0["speed"];

    if ( var_2 < 5 )
    {
        var_1.last_gear_change_time = 0;
        return 1;
    }

    return 0;
}

gaz_condition_callback_drive_to_idle( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];
    var_4 = 0;

    if ( var_3 > 0.5 || var_2 < 5 )
    {
        var_1.last_gear_change_time = gettime();
        var_4 = 1;
    }

    return var_4;
}

gaz_condition_callback_idle_to_first( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];
    var_4 = 0;

    if ( !isdefined( var_1.last_gear_change_time ) )
        var_1.last_gear_change_time = 0;

    var_5 = gettime();

    if ( var_3 < 0.5 && var_2 >= 5 && var_5 - var_1.last_gear_change_time > 2000 )
    {
        var_1.last_gear_change_time = var_5;
        var_4 = 1;
    }

    return var_4;
}

gaz_condition_callback_first_to_second( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = 0;

    if ( !isdefined( var_1.last_gear_change_time ) )
        var_1.last_gear_change_time = 0;

    var_4 = gettime();

    if ( var_2 >= 22 && var_4 - var_1.last_gear_change_time > 2000 )
    {
        var_1.last_gear_change_time = var_4;
        var_3 = 1;
    }

    return var_3;
}

gaz_condition_callback_second_to_first( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = 0;

    if ( !isdefined( var_1.last_gear_change_time ) )
        var_1.last_gear_change_time = 0;

    var_4 = gettime();

    if ( var_2 < 22 && var_4 - var_1.last_gear_change_time > 2000 )
    {
        var_1.last_gear_change_time = var_4;
        var_3 = 1;
    }

    return var_3;
}

gaz_condition_callback_to_off( var_0, var_1 )
{
    return 0;
}

gaz_condition_callback_to_state_wheels_bump( var_0, var_1 )
{
    var_2 = var_0["zvelocity"];
    var_3 = var_0["speed"];
    var_4 = 0;

    if ( !isdefined( var_1.last_bump_time ) )
        var_1.last_bump_time = 0;

    if ( isdefined( var_1.previous_bump_zvel ) )
    {
        var_5 = var_2 - var_1.previous_bump_zvel;
        var_6 = gettime();

        if ( abs( var_5 ) >= 20.0 && var_3 > 5 && var_6 - var_1.last_bump_time > 400 )
        {
            var_1.last_bump_time = var_6;
            var_4 = [ "veh_gaz_bump_susp" ];
        }
    }

    var_1.previous_bump_zvel = var_2;
    return var_4;
}

gaz_condition_callback_to_state_wheels_skid( var_0, var_1 )
{
    var_2 = var_0["yaw"];
    var_3 = var_0["speed"];
    var_4 = 0;

    if ( !isdefined( var_1.last_skid_time ) )
        var_1.last_skid_time = 0;

    if ( isdefined( var_1.previous_yaw ) )
    {
        var_5 = angleclamp180( var_2 - var_1.previous_yaw );
        var_6 = gettime();

        if ( abs( var_5 ) > 5.0 && var_3 > 5 && var_6 - var_1.last_skid_time > 1000 )
        {
            var_1.last_skid_time = var_6;
            var_4 = [ "veh_gaz_tire_chatter" ];
        }
    }

    var_1.previous_yaw = var_2;
    return var_4;
}
