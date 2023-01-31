// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

snd_pitbull_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_register_callback( "throttle", soundscripts\_audio_vehicle_manager::input_callback_throttle );
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "pitbull", ::pbull_init );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pbull_rpm_idle_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pbull_rpm_idle_vol_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pbull_rpm_hi_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pbull_rpm_hi_vol_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pbull_int_sus_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pbull_int_sus_lo_vol_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pbull_reverse_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pbull_reverse_loop_vol_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_rev_low_to_hi", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_rev_med_to_hi", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_rev_hi_to_max", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_brakes_med", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_int_brake_pedal", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "blank_oneshot", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_reverse", undefined, 0.75, 0 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pbull_decel_to_idle", undefined, 0.75, 1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "dummy_map" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_any_to_gas_off", ::pbull_callback_gas_off, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_decel_to_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_any_to_crash", ::pbull_callback_crash, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_decel_to_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_stopped_to_reverse", ::pbull_callback_from_stopped_to_reverse, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "pbull_int_sus_lp", "pbull_reverse_lp" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_reverse" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_reverse_to_reverse_gas_off", ::pbull_callback_from_reverse_to_reverse_gas_off, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_decel_to_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_gas_off_to_rev_low", ::pbull_callback_from_gas_off_to_rev_low, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_rev_low_to_hi" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_gas_off_to_rev_med", ::pbull_callback_from_gas_off_to_rev_med, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_rev_med_to_hi" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_gas_off_to_rev_hi", ::pbull_callback_from_gas_off_to_rev_hi, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_rev_hi_to_max" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "from_any_to_brakes_med", ::pbull_callback_to_brakes_med, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pbull_int_brake_pedal" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_oneshots", "state_gas_off", "from_any_to_gas_off", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_gas_off", 0.75, 2 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_low", "from_gas_off_to_rev_low" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_med", "from_gas_off_to_rev_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_hi", "from_gas_off_to_rev_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse", "from_stopped_to_reverse" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_reverse", 0.75, 2 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse_gas_off", "from_reverse_to_reverse_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_reverse_gas_off", 0.75, 2 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_low", "from_gas_off_to_rev_low" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_med", "from_gas_off_to_rev_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_hi", "from_gas_off_to_rev_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse", "from_stopped_to_reverse" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_rev_low", 0.75, 3 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_rev_med", 0.75, 3 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_rev_hi", 0.75, 3 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_brakes_skid", "from_any_to_brakes_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_brakes_skid", 3.5, 1 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_low", "from_gas_off_to_rev_low" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_med", "from_gas_off_to_rev_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_hi", "from_gas_off_to_rev_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_crash", "from_any_to_crash" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse", "from_stopped_to_reverse" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_crash", 3.5, 1 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_low", "from_gas_off_to_rev_low" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_med", "from_gas_off_to_rev_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_hi", "from_gas_off_to_rev_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse", "from_stopped_to_reverse" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off", 3.5, 1 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_low", "from_gas_off_to_rev_low" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_med", "from_gas_off_to_rev_med" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_rev_hi", "from_gas_off_to_rev_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_gas_off", "from_any_to_gas_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_reverse", "from_stopped_to_reverse" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_rpm_idle_vol_map", [ [ 1, 0.7 ], [ 30, 0.45 ], [ 63, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_rpm_med_vol_map", [ [ 1, 0.0 ], [ 40, 0.8 ], [ 63, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_rpm_med_pitch_map", [ [ 1, 0.8 ], [ 70, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_rpm_hi_vol_map", [ [ 1, 0.0 ], [ 40, 0.1 ], [ 63, 0.3 ], [ 70, 0.8 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_int_sus_lo_vol_map", [ [ 1, 0.1 ], [ 40, 0.75 ], [ 70, 0.78 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_reverse_loop_vol_map", [ [ 1, 1.0 ], [ 70, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "dummy_map", [ [ 1, 1.0 ], [ 70, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pbull_rev_ducks_lp_env", [ [ 0.0, 1.0 ], [ 0.33, 0.33 ], [ 0.66, 0.33 ], [ 1.33, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

foo_env_function()
{
    return 1.0;
}

pbull_init( var_0 )
{
    var_1 = self;
    var_2 = var_1 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_0.pbull_is_revving = 0;
    var_0.pbull_is_reversed = 0;
    var_0.pbull_is_upshifting = 0;
    var_0.pbull_is_downshifting = 0;
    var_0.crash = spawnstruct();
    var_0.crash.crash_event = 0;
    var_0.crash.crash_time = undefined;
    var_0.crash.crash_speed = 0;
    var_2 thread pbull_crash_watch( var_0 );
    var_2 thread pbull_shift_watch( var_0 );
}

pbull_callback_gas_off( var_0, var_1 )
{
    var_2 = 0;

    if ( var_1.pbull_is_upshifting == 1 )
    {
        var_2 = 1;
        var_1.pbull_is_upshifting = 0;
        var_1.pbull_is_revving = 0;
    }
    else
    {
        var_3 = var_0["speed"];

        if ( !level.player attackbuttonpressed() && var_1.pbull_is_revving == 1 )
        {
            var_1.pbull_is_revving = 0;
            var_1.pbull_is_reversed = 0;
            var_2 = 1;
        }
    }

    return var_2;
}

pbull_callback_to_brakes_med( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( level.player _meth_824C( "BUTTON_B" ) && var_3 > 20 && !level.player attackbuttonpressed() && !var_1.pbull_is_reversed )
    {
        var_1.pbull_is_revving = 0;
        var_1.pbull_is_reversed = 0;
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_from_gas_off_to_rev_low( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( level.player attackbuttonpressed() && var_3 < 40 && var_1.pbull_is_revving == 0 && var_3 > 3 )
    {
        var_1.pbull_is_revving = 1;
        var_1.pbull_is_reversed = 0;
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_from_gas_off_to_rev_med( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( level.player attackbuttonpressed() && var_3 > 40 && var_3 < 63 && var_1.pbull_is_revving == 0 )
    {
        var_1.pbull_is_revving = 1;
        var_1.pbull_is_reversed = 0;
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_from_gas_off_to_rev_hi( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( level.player attackbuttonpressed() && var_3 > 63 && var_3 < 67 && var_1.pbull_is_revving == 0 )
    {
        var_1.pbull_is_revving = 1;
        var_1.pbull_is_reversed = 0;
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_from_stopped_to_reverse( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( level.player _meth_824C( "BUTTON_B" ) && var_3 > 0 && !var_1.pbull_is_reversed )
    {
        var_1.pbull_is_reversed = 1;
        thread pbull_play_reverse_beeps( var_1 );
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_from_reverse_to_reverse_gas_off( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( !level.player _meth_824C( "BUTTON_B" ) )
    {
        var_1.pbull_is_revving = 0;
        var_1.pbull_is_reversed = 0;
        var_2 = 1;
    }

    return var_2;
}

pbull_callback_crash( var_0, var_1 )
{
    var_2 = 0;

    if ( var_1.crash.crash_event == 1 )
    {
        if ( !isdefined( var_1.crash.crash_time ) )
        {
            var_1.crash.crash_time = gettime();
            var_1.crash.crash_speed = var_0["speed"];
        }
        else
        {
            var_3 = gettime() - var_1.crash.crash_time;

            if ( var_3 > 300 )
            {
                var_4 = var_1.crash.crash_speed - var_0["speed"];

                if ( var_4 > 3 )
                {
                    var_1.pbull_is_revving = 0;
                    var_1.pbull_is_reversed = 0;
                    var_2 = 1;
                }

                var_1.crash.crash_event = 0;
                var_1.crash.crash_time = undefined;
            }
        }
    }

    return var_2;
}

player_pbull_honk()
{
    var_0 = "honk";
    level.player _meth_82DD( var_0, "+usereload" );

    for (;;)
    {
        level.player waittill( var_0 );
        level.player soundscripts\_snd_playsound::snd_play( "pbull_honk" );
        wait 0.3;
    }
}

pbull_play_reverse_beeps( var_0 )
{
    wait 0.5;

    while ( var_0.pbull_is_reversed )
    {
        level.player soundscripts\_snd_playsound::snd_play( "pbull_reverse_beep" );
        wait 1;
    }
}

pbull_crash_watch( var_0, var_1 )
{
    for (;;)
    {
        level.player_pitbull waittill( "veh_contact", var_2, var_3, var_4, var_5, var_6 );
        var_0.crash.crash_event = 1;
    }
}

pbull_shift_watch( var_0 )
{
    for (;;)
    {
        self waittill( "audio_shift", var_1 );
        soundscripts\_snd_playsound::snd_play( "pbull_int_shift" );
        var_2 = self _meth_8286();

        if ( var_1 == "gear_up" )
        {
            if ( var_2 > 35 )
            {
                var_0.pbull_is_upshifting = 1;
                var_0.pbull_is_downshifting = 0;
            }

            continue;
        }

        if ( var_1 == "gear_down" )
        {
            if ( var_2 < 35 )
            {
                var_0.pbull_is_upshifting = 0;
                var_0.pbull_is_downshifting = 1;
                soundscripts\_snd_playsound::snd_play( "pbull_downshift_to_idle" );
            }
        }
    }
}
