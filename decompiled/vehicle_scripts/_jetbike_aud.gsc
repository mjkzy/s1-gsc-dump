// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

jetbike_constructor()
{
    var_0 = 0;
    var_1 = 60;
    var_2 = -2;
    var_3 = 2;
    var_4 = 0.0;
    var_5 = 1.0;
    var_6 = -1;
    var_7 = 0;
    var_8 = 1;
    var_9 = 0.0;
    var_10 = 1.0;
    var_11 = 0.7;
    var_12 = 0.75;
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "jetbike" );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_hover_spd2vol", [ [ 1.0, 0.15 ], [ 9.9762, 0.2618 ], [ 16.6746, 0.3613 ], [ 23.0879, 0.5 ], [ 29.3587, 0.3403 ], [ 34.9169, 0.1937 ], [ 42.4703, 0.0262 ], [ 60.0, 0.0052 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_hover_spd2pch", [ [ 0.0, 0.5 ], [ 0.9976, 0.6073 ], [ 30.3563, 0.9738 ], [ 60.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_air_spd2vol", [ [ 0.0, 0.0 ], [ 0.06, 0.0 ], [ 0.1, 0.0 ], [ 0.1, 0.0 ], [ 3.2779, 0.0 ], [ 8.4086, 0.0366 ], [ 13.8242, 0.1518 ], [ 18.2423, 0.288 ], [ 25.2257, 0.65 ], [ 30.4988, 0.65 ], [ 35.772, 0.4817 ], [ 39.7625, 0.3508 ], [ 44.038, 0.1885 ], [ 48.0285, 0.0052 ], [ 60.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_whine_spd2vol", [ [ 0.0, 0.0 ], [ 13.3302, 0.0 ], [ 28.399, 0.6387 ], [ 38.1069, 0.8534 ], [ 47.0903, 0.9372 ], [ 50.4228, 0.9634 ], [ 55.639, 1.0 ], [ 61.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_whine_spd2pch", [ [ 0.0, 0.5 ], [ 61.0, 2.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_engine_spd2vol", [ [ 0.0, 0.0 ], [ 30.5725, 0.0 ], [ 36.9477, 0.0 ], [ 43.0333, 0.0 ], [ 53.4656, 0.3508 ], [ 57.8124, 0.5707 ], [ 61.0, 0.8534 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_engine_spd2pch", [ [ 0.0, 0.0314 ], [ 61.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_antislip_antislip2vol", [ [ var_6 * 0.5, var_10 ], [ var_7, var_9 ], [ var_8 * 0.5, var_10 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_antislip_spd2vol", [ [ 0.0, 0.0 ], [ 1.0, 0.0 ], [ var_1 * 0.3, 0.2 ], [ var_1 * 0.7, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_antislip_antislip2pch", [ [ var_6, var_12 ], [ var_7, var_11 ], [ var_8, var_12 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "jtbk_doppler2pch", [ [ 0, 0.5 ], [ 90, 1.0 ], [ 180, 0.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "jtbk_hover" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.2, 0.06 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_hover_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "jtbk_hover_spd2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "jtbk_air" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.1, 0.9 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_air_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "jtbk_whine" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.15, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_whine_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "jtbk_whine_spd2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "jtbk_engine" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.2, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_engine_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "jtbk_engine_spd2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "jtbk_antislip" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "jetbike_anti_slip", 0.1, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_antislip_antislip2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "jtbk_antislip_antislip2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed_mph", 0.1, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "jtbk_antislip_spd2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "jtbk_accel_one_shot", undefined, undefined, 2 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_hover", ::jetbike_condition_callback_to_state_hover, [ "speed_mph", "distance2d", "acceleration_g" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_starting", ::jetbike_condition_callback_to_state_starting, [ "speed_mph", "distance2d", "acceleration_g" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "jtbk_accel_one_shot" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_flying", ::jetbike_condition_callback_to_state_flying, [ "speed_mph", "distance2d", "acceleration_g" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_distant", ::jetbike_condition_callback_to_state_distant, [ "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_flyby", ::jetbike_condition_callback_to_state_flyby, [ "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_destruct", ::jetbike_condition_callback_to_state_destruct );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off", ::jetbike_condition_callback_to_state_off, [ "speed_mph" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_starting", "to_state_starting" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_starting" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_flyby", 3.0 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();

    if ( !isdefined( level.aud.jetbike_snd_messages ) )
    {
        soundscripts\_snd::snd_register_message( "jetbike_hit_ramp", ::jetbike_hit_ramp );
        soundscripts\_snd::snd_register_message( "jetbike_hit_cliff", ::jetbike_hit_cliff );
        soundscripts\_snd::snd_register_message( "jetbike_hit_landing", ::jetbike_hit_landing );
        soundscripts\_snd::snd_register_message( "jetbike_soft_landing", ::jetbike_soft_landing );
        soundscripts\_snd::snd_register_message( "jetbike_landing_finished", ::jetbike_landing_finished );
    }
}

jetbike_hit_ramp()
{

}

jetbike_hit_cliff()
{

}

jetbike_hit_landing()
{
    soundscripts\_snd_playsound::snd_play_2d( "jtbk_thruster_plr" );
}

jetbike_soft_landing()
{
    soundscripts\_snd_playsound::snd_play_2d( "jtbk_thruster_plr" );
}

jetbike_landing_finished()
{

}

jetbike_condition_callback_to_state_off()
{
    return 0;
}

jetbike_condition_callback_to_state_hover( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed_mph"];
    var_4 = var_0["distance2d"];
    var_5 = var_0["acceleration_g"];
    var_6 = soundscripts\_audio_vehicle_manager::units2yards( var_4 );

    if ( !isdefined( var_1.prev_velo ) )
        var_1.prev_velo = 0;

    var_7 = var_3 - var_1.prev_velo;

    if ( var_7 < -1 || var_3 <= 5 && var_6 < 900 )
        var_2 = 1;

    var_1.prev_velo = var_3;
    return var_2;
}

jetbike_condition_callback_to_state_starting( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed_mph"];
    var_4 = var_0["distance2d"];
    var_5 = var_0["acceleration_g"];
    var_6 = soundscripts\_audio_vehicle_manager::units2yards( var_4 );

    if ( !isdefined( var_1.prev_velo ) )
        var_1.prev_velo = 0;

    var_7 = var_3 - var_1.prev_velo;

    if ( var_7 > 0 && var_3 > 5 && var_3 < 50 && var_6 < 900 )
    {
        if ( soundscripts\_audio_vehicle_manager::avmx_is_player_mode() )
            var_2 = 1;
        else
            var_2 = 1;
    }

    var_1.prev_velo = var_3;
    return var_2;
}

jetbike_condition_callback_to_state_flying( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed_mph"];
    var_4 = var_0["distance2d"];
    var_5 = var_0["acceleration_g"];
    var_6 = soundscripts\_audio_vehicle_manager::units2yards( var_4 );

    if ( !isdefined( var_1.prev_velo ) )
        var_1.prev_velo = 0;

    var_7 = var_3 - var_1.prev_velo;

    if ( var_3 >= 50 && var_6 < 900 )
    {
        if ( soundscripts\_audio_vehicle_manager::avmx_is_player_mode() )
            var_2 = 1;
        else
            var_2 = 1;
    }

    var_1.prev_velo = var_3;
    return var_2;
}

jetbike_condition_callback_to_state_distant( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = soundscripts\_audio_vehicle_manager::units2yards( var_3 );

    if ( var_4 >= 900 )
        var_2 = 1;

    return var_2;
}

jetbike_condition_callback_to_state_flyby( var_0, var_1 )
{
    if ( soundscripts\_audio_vehicle_manager::avmx_is_player_mode() )
        return 0;

    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = soundscripts\_audio_vehicle_manager::units2yards( var_3 );

    if ( !isdefined( var_1.flyby ) )
    {
        var_1.flyby = spawnstruct();
        var_1.flyby.prev_yards = var_4;
        var_1.flyby.prev_dx = 0;
    }
    else
    {
        var_5 = var_4 - var_1.flyby.prev_yards;

        if ( var_5 < 0 && var_4 < 216.0 )
        {
            if ( 0 )
                var_2 = [ "jetbike_flyby" ];
            else
                var_2 = 1;
        }

        var_1.flyby.prev_yards = var_4;
        var_1.flyby.prev_dx = var_5;
    }

    return var_2;
}

jetbike_condition_callback_to_state_flyover( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["relative_speed"];
    var_5 = soundscripts\_audio_vehicle_manager::units2yards( var_3 );

    if ( var_5 < 540 )
        var_2 = 1;

    return var_2;
}

jetbike_condition_callback_to_state_destruct( var_0, var_1 )
{
    return 0;
}
