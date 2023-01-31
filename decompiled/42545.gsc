// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.player_test_points = get_player_test_points();
    level.drone_test_points = common_scripts\utility::getstructarray( "drone_test_point", "targetname" );
    level.drone_air_spaces = getentarray( "drone_air_space", "script_noteworthy" );
    var_0 = spawnstruct();
    var_0.enabled = 1;
    var_0.tactical_location = ( 0, 0, 0 );
    var_0.target_air_space = undefined;
    var_0.drone_test_point = undefined;
    var_0.eval_min_range = 300;
    var_0.eval_max_range = 600;
    var_0.eval_too_close_range = 100;
    var_0.time_between_attacks = 1;
    var_0.num_move_wait_skips = 0;
    var_0.skip_moves = 0;
    level.drone_tactical_picker_data = var_0;
    common_scripts\utility::create_dvar( "AI_Drone_Tactical_Debug", 0 );
    build_nodes_for_airspace();
    thread update_tactical_picker();
    thread update_flock();
    thread update_drone_moves();
    thread update_drone_attacks();
    thread update_grenade_dodger();
}

get_player_test_points()
{
    var_0 = common_scripts\utility::getstructarray( "player_test_point", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.target ) || !isdefined( getent( var_3.target, "targetname" ) ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

build_nodes_for_airspace()
{
    foreach ( var_1 in level.drone_air_spaces )
    {
        if ( isdefined( var_1.tactical_location ) )
            continue;

        var_1.tactical_location = var_1 _meth_8216( 0, 0, 0 );
        var_2 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_1.origin, var_1.angles, var_1 _meth_8216( 1, 1, 1 ), ( 0, 0, 0 ) );
        var_1.box_extent = var_2["origin"];

        if ( !isdefined( var_1.target ) )
            continue;

        var_3 = common_scripts\utility::getstructarray( var_1.target, "targetname" );

        if ( !isdefined( var_3 ) || var_3.size == 0 )
            continue;

        var_4 = var_3[0];

        if ( !isdefined( var_4.script_noteworthy ) || var_4.script_noteworthy != "drone_forward_point" )
            continue;

        var_1.forward_direction = vectornormalize( ( var_4.origin - var_1.origin ) * ( 1, 1, 0 ) );
    }
}

validate_drone_test_points()
{
    if ( level.drone_test_points.size == 0 )
        return;

    foreach ( var_1 in level.drone_test_points )
    {
        var_2 = getent( var_1.target, "targetname" );

        if ( !isdefined( var_2 ) )
        {

        }

        if ( !_func_22A( var_1.origin, var_2 ) )
        {

        }
    }
}

find_tactical_override( var_0 )
{
    if ( !isdefined( level.player_test_points ) )
        return 0;

    var_1 = [];

    foreach ( var_3 in level.player_test_points )
    {
        var_4 = lengthsquared( var_3.origin - level.player.origin );

        if ( var_4 > squared( var_3.radius ) )
            continue;

        var_5 = getent( var_3.target, "targetname" );
        var_1[var_1.size] = var_5;
    }

    if ( var_1.size == 0 )
        return 0;

    var_7 = 0;
    var_8 = -1;
    var_9 = var_1.size + 1;

    if ( isdefined( var_1 ) )
        var_9 += var_1.size;

    foreach ( var_5 in var_1 )
    {
        if ( !isdefined( var_5.tactical_location ) )
            continue;

        wait 0.05;
        var_11 = calculate_tactical_score( var_5.tactical_location, var_5 );

        if ( var_11 >= 0 && var_11 > var_8 )
        {
            if ( var_1.size > 1 && var_5 != level.drone_tactical_picker_data.target_air_space && isdefined( var_5.last_picked_time ) && getlevelticks() * 0.05 - var_5.last_picked_time < 3 )
                continue;

            var_5.last_picked_time = getlevelticks() * 0.05;
            level.drone_tactical_picker_data.target_air_space = var_5;
            level.drone_tactical_picker_data.tactical_location = var_5.tactical_location;
            level.drone_tactical_picker_data.drone_test_point = undefined;
            var_8 = var_11;
            var_7 = 1;
        }
    }

    return var_7;
}

evaluate_tactical_range( var_0, var_1, var_2, var_3 )
{
    var_2 = max( 0.001, var_2 );
    var_3 = max( 0.001, var_3 );
    var_4 = length2d( var_0 - var_1 _meth_80A8() );

    if ( var_4 < var_2 )
        return squared( min( var_4 / var_2, 1.0 ) );

    if ( var_4 < var_3 )
        return 1;

    return 1.0 - squared( min( ( var_4 - var_2 ) / var_3, 1.0 ) );
}

evaluate_tactical_los( var_0, var_1 )
{
    if ( vehicle_scripts\_pdrone_threat_sensor::trace_to_enemy( var_0, var_1, undefined ) )
        return 1;

    return 0.5;
}

evaluate_tactical_too_close( var_0, var_1, var_2 )
{
    var_3 = length2d( var_0 - var_1 _meth_80A8() );

    if ( var_3 >= var_2 )
        return 1;

    return squared( ( var_2 - var_3 ) / var_2 );
}

evaluate_tactical_in_front_of_enemy( var_0, var_1 )
{
    var_2 = ( var_0 - var_1 _meth_80A8() ) * ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_3 = anglestoforward( var_1.angles * ( 1, 1, 0 ) );
    var_4 = ( vectordot( var_3, var_2 ) + 1 ) / 2;
    return var_4;
}

evaluate_tactical_above_player( var_0, var_1 )
{
    var_2 = var_0[2] - var_1.origin[2];
    var_3 = 0.5;

    if ( var_2 < 0 )
        return var_3;

    var_4 = 80;

    if ( var_2 > var_4 )
        return 1;

    return maps\_utility::linear_interpolate( clamp( var_2 / var_4, 0, 1 ), var_3, 1 );
}

evaluate_tactical_in_front_of_volume( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.forward_direction ) )
        return 1;

    var_2 = ( var_1.origin - var_0.origin ) * ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_3 = vectordot( var_2, var_0.forward_direction );

    if ( var_3 > 0 )
        return 1;

    return 0.1;
}

calculate_tactical_score( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return -1;

    var_2 = level.player;

    if ( !isdefined( var_2 ) )
        return -1;

    var_3 = evaluate_tactical_range( var_0, var_2, level.drone_tactical_picker_data.eval_min_range, level.drone_tactical_picker_data.eval_max_range );
    var_3 += evaluate_tactical_too_close( var_0, var_2, level.drone_tactical_picker_data.eval_too_close_range );
    var_3 += evaluate_tactical_in_front_of_enemy( var_0, var_2 );
    var_3 += evaluate_tactical_above_player( var_0, var_2 );
    var_3 *= evaluate_tactical_los( var_0, var_2 );
    var_3 *= evaluate_tactical_in_front_of_volume( var_1, var_2 );
    return var_3 / 4;
}

set_time_between_attacks( var_0 )
{
    level.drone_tactical_picker_data.time_between_attacks = var_0;
}

toggle_tactical_picker( var_0 )
{
    level.drone_tactical_picker_data.enabled = var_0;
}

update_tactical_picker()
{
    level notify( "pdrone_update_tactical_picker" );
    level endon( "pdrone_update_tactical_picker" );
    level.drone_tactical_picker_data.target_air_space = level.drone_air_spaces[randomint( level.drone_air_spaces.size )];
    level.drone_tactical_picker_data.tactical_location = level.drone_tactical_picker_data.target_air_space.tactical_location;

    for (;;)
    {
        wait 0.05;

        if ( !level.drone_tactical_picker_data.enabled )
            continue;

        if ( !isdefined( level.flying_attack_drones ) )
            continue;

        level.flying_attack_drones = common_scripts\utility::array_removeundefined( level.flying_attack_drones );

        if ( level.flying_attack_drones.size == 0 )
            continue;

        if ( find_tactical_override() )
            continue;

        update_tactical();
    }
}

update_tactical()
{
    level notify( "pdrone_update_tactical" );
    level endon( "pdrone_update_tactical" );
    var_0 = calculate_tactical_score( level.drone_tactical_picker_data.tactical_location, level.drone_tactical_picker_data.target_air_space );
    var_1 = level.drone_air_spaces.size + 1;

    if ( isdefined( level.drone_test_points ) )
        var_1 += level.drone_test_points.size;

    foreach ( var_3 in level.drone_air_spaces )
    {
        if ( !isdefined( var_3.tactical_location ) )
            continue;

        if ( isdefined( var_3.script_ignoreme ) && var_3.script_ignoreme )
            continue;

        var_4 = 0.01;

        if ( length2dsquared( var_3.origin - level.player.origin ) < squared( 2000 ) )
        {
            wait 0.05;
            var_4 = calculate_tactical_score( var_3.tactical_location, var_3 );
        }

        if ( var_4 >= 0 && var_4 > var_0 )
        {
            if ( var_3 != level.drone_tactical_picker_data.target_air_space && isdefined( var_3.last_picked_time ) && getlevelticks() * 0.05 - var_3.last_picked_time < 3 )
                continue;

            var_3.last_picked_time = getlevelticks() * 0.05;
            level.drone_tactical_picker_data.target_air_space = var_3;
            level.drone_tactical_picker_data.tactical_location = var_3.tactical_location;
            level.drone_tactical_picker_data.drone_test_point = undefined;
            var_0 = var_4;
        }
    }

    if ( !isdefined( level.drone_test_points ) )
        return;

    foreach ( var_7 in level.drone_test_points )
    {
        if ( isdefined( var_7.script_ignoreme ) && var_7.script_ignoreme )
            continue;

        var_4 = 0;

        if ( length2dsquared( var_7.origin - level.player.origin ) < squared( 2000 ) )
        {
            wait 0.05;
            var_4 = calculate_tactical_score( var_7.origin );
        }

        if ( var_4 >= 0 && var_4 > var_0 )
        {
            level.drone_tactical_picker_data.target_air_space = getent( var_7.target, "targetname" );
            level.drone_tactical_picker_data.tactical_location = var_7.origin;
            level.drone_tactical_picker_data.drone_test_point = var_7;
            var_0 = var_4;
        }
    }
}

update_flock()
{
    level notify( "pdrone_update_flock" );
    level endon( "pdrone_update_flock" );

    for (;;)
    {
        wait 0.05;

        if ( !level.drone_tactical_picker_data.enabled )
            continue;

        update_flock_goal_positions();
    }
}

randomize_flock_positions()
{
    foreach ( var_1 in level.flying_attack_drones )
    {
        if ( !isdefined( var_1 ) || !isalive( var_1 ) )
            continue;

        if ( !isdefined( var_1.flock_goal_position ) || !_func_22A( var_1.flock_goal_position, level.drone_tactical_picker_data.target_air_space ) )
        {
            var_1.flock_goal_position = var_1 get_random_point_nearby_in_volume( level.drone_tactical_picker_data.target_air_space, 1 );
            var_1.current_goal_position = var_1.flock_goal_position;
            var_1.current_goal_offset = ( 0, 0, 0 );
        }
    }
}

update_flock_goal_positions()
{
    level notify( "pdrone_update_flock_position" );
    level endon( "pdrone_update_flock_position" );

    if ( !isdefined( level.flying_attack_drones ) || level.flying_attack_drones.size == 0 )
        return;

    if ( !isdefined( level.drone_tactical_picker_data.target_air_space ) )
        return;

    randomize_flock_positions();
    calculate_flock_goal_positions();
}

calculate_flock_goal_positions()
{
    level notify( "pdrone_calculate_flock_position" );
    level endon( "pdrone_calculate_flock_position" );

    foreach ( var_1 in level.flying_attack_drones )
    {
        if ( !isdefined( var_1 ) || !isalive( var_1 ) )
            continue;

        var_2 = 0;
        var_3 = 0;
        var_4 = ( 0, 0, 0 );
        var_5 = 0;
        var_6 = ( 0, 0, 0 );
        var_7 = ( 0, 0, 0 );

        foreach ( var_9 in level.flying_attack_drones )
        {
            if ( !isdefined( var_9 ) || !isalive( var_9 ) )
                continue;

            if ( var_1 == var_9 )
                continue;

            var_2++;
            var_10 = var_9.flock_goal_position - var_1.flock_goal_position;
            var_11 = length( var_10 );

            if ( var_11 <= 0 )
                var_11 = 1;

            if ( var_11 < 90 )
            {
                var_3++;
                var_4 -= 0.5 * ( 90 - var_11 ) * var_10 / var_11;
                continue;
            }

            if ( var_11 > 150 )
            {
                var_5++;
                var_6 += 0.5 * ( var_11 - 150 ) * var_10 / var_11;
            }
        }

        if ( var_2 > 0 )
        {
            if ( var_3 > 0 )
                var_7 += var_4 / var_3;

            if ( var_5 > 0 )
                var_7 += var_6 / var_5;

            var_1.flock_goal_offset = var_7;
        }
    }
}

set_random_flock_goal_position()
{
    self.flock_goal_position = get_random_point_radius_in_volume( level.drone_tactical_picker_data.target_air_space, randomintrange( 30, 150 ) );
    self.flock_goal_offset = ( 0, 0, 0 );
}

get_normalized_point_in_volume( var_0, var_1 )
{
    var_2 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_1.origin, var_1.angles, var_0, ( 0, 0, 0 ) );
    var_3 = ( clamp( var_2["origin"][0] / var_1.box_extent[0], -1, 1 ), clamp( var_2["origin"][1] / var_1.box_extent[1], -1, 1 ), clamp( var_2["origin"][2] / var_1.box_extent[2], -1, 1 ) );
    return var_3;
}

get_random_point_in_bounds( var_0, var_1 )
{
    var_2 = clamp( var_0[0] + randomfloatrange( -1 * var_1, var_1 ), -1, 1 );
    var_3 = clamp( var_0[1] + randomfloatrange( -1 * var_1, var_1 ), -1, 1 );
    var_4 = clamp( var_0[2] + randomfloatrange( -1 * var_1, var_1 ), -1, 1 );
    var_5 = level.drone_tactical_picker_data.target_air_space _meth_8216( var_2, var_3, var_4 );
    return var_5;
}

get_random_point_nearby_in_volume( var_0, var_1 )
{
    if ( !isdefined( level.drone_tactical_picker_data.drone_test_point ) )
        return get_random_point_in_volume( var_0 );

    var_2 = get_normalized_point_in_volume( level.drone_tactical_picker_data.tactical_location, var_0 );
    var_3 = get_random_point_in_bounds( var_2, 0.3 );
    return var_3;
}

get_random_point_radius_in_volume( var_0, var_1 )
{
    var_2 = common_scripts\utility::randomvector( 1 );
    var_2 = vectornormalize( var_2 );
    var_3 = self.origin + var_2 * var_1;

    if ( !_func_22A( var_3, var_0 ) )
    {
        var_2 *= -1;
        var_3 = self.origin + var_2 * var_1;

        if ( !_func_22A( var_3, var_0 ) )
            var_3 = get_random_point_in_volume( var_0 );
    }

    return var_3;
}

get_random_point_in_volume( var_0 )
{
    return var_0 _meth_8216( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) );
}

update_drone_moves()
{
    level notify( "pdrone_update_move" );
    level endon( "pdrone_update_move" );

    for (;;)
    {
        wait 0.05;

        if ( !level.drone_tactical_picker_data.enabled )
            continue;

        sort_drone_moves();
    }
}

sort_drone_moves()
{
    level notify( "pdrone_sort_drone_moves" );
    level endon( "pdrone_sort_drone_moves" );

    if ( !isdefined( level.flying_attack_drones ) || level.flying_attack_drones.size == 0 )
        return;

    var_0 = maps\_sarray::sarray_spawn();

    foreach ( var_2 in level.flying_attack_drones )
    {
        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2.time_before_move ) )
            var_2.time_before_move = 0;

        var_2.time_before_move -= 0.05;

        if ( isdefined( var_2.current_air_space ) && var_2.current_air_space != level.drone_tactical_picker_data.target_air_space )
            continue;

        var_0 maps\_sarray::sarray_push( var_2 );
    }

    if ( var_0.array.size == 0 )
        return;

    maps\_sarray::sarray_sort_by_handler( var_0, maps\_sarray::sarray_create_func_obj( ::compare_time_before_move ) );
    var_4 = var_0.array[0];

    if ( var_4.time_before_move > 0 )
        return;

    var_4.time_before_move = 1;
    var_5 = 0;

    if ( level.flying_attack_drones.size == 1 )
        var_5 = randomfloatrange( 3, 5 );
    else
    {
        if ( level.drone_tactical_picker_data.num_move_wait_skips <= 0 )
        {
            level.drone_tactical_picker_data.num_move_wait_skips = randomint( level.flying_attack_drones.size );
            level.drone_tactical_picker_data.skip_moves = !level.drone_tactical_picker_data.skip_moves;
        }

        if ( level.drone_tactical_picker_data.skip_moves )
            var_5 = randomfloatrange( 0, 3 );

        level.drone_tactical_picker_data.num_move_wait_skips--;
    }

    var_4.current_goal_position = var_4.flock_goal_position;
    var_4.current_goal_offset = var_4.flock_goal_offset;
    var_4.flock_goal_position = var_4 get_random_point_nearby_in_volume( level.drone_tactical_picker_data.target_air_space );

    foreach ( var_2 in level.flying_attack_drones )
    {
        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
            continue;

        var_2.time_before_move += var_5;
    }
}

compare_time_before_move( var_0, var_1 )
{
    return var_0.time_before_move < var_1.time_before_move;
}

update_drone_attacks()
{
    level notify( "pdrone_update_attacks" );
    level endon( "pdrone_update_attacks" );

    for (;;)
    {
        wait 0.05;

        if ( !level.drone_tactical_picker_data.enabled )
            continue;

        sort_drone_attacks();
    }
}

sort_drone_attacks()
{
    level notify( "pdrone_sort_drone_attacks" );
    level endon( "pdrone_sort_drone_attacks" );

    if ( !isdefined( level.flying_attack_drones ) || level.flying_attack_drones.size == 0 )
        return;

    var_0 = maps\_sarray::sarray_spawn();

    foreach ( var_2 in level.flying_attack_drones )
    {
        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2.time_before_attack ) )
            var_2.time_before_attack = 0;

        var_2.time_before_attack -= 0.05;
        var_0 maps\_sarray::sarray_push( var_2 );
    }

    if ( var_0.array.size == 0 )
        return;

    maps\_sarray::sarray_sort_by_handler( var_0, maps\_sarray::sarray_create_func_obj( ::compare_time_before_attack ) );
    var_2 = var_0.array[0];

    if ( var_2.time_before_attack > 0 )
        return;

    var_4 = level.drone_tactical_picker_data.time_between_attacks;

    if ( isdefined( var_2.attack_delay ) )
        var_4 = var_2.attack_delay;

    var_2.time_before_attack = var_4;
    var_2.attack_available = 1;

    if ( isdefined( var_2.drone_threat_data.threat ) && var_2.drone_threat_data.threat != level.player )
        return;

    var_5 = randomfloatrange( 0, var_4 );

    foreach ( var_2 in level.flying_attack_drones )
    {
        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
            continue;

        var_2.time_before_attack += var_5;
    }
}

compare_time_before_attack( var_0, var_1 )
{
    return var_0.time_before_attack < var_1.time_before_attack;
}

update_grenade_dodger()
{
    level notify( "pdrone_update_grenade_dodger" );
    level endon( "pdrone_update_grenade_dodger" );

    for (;;)
    {
        level.player waittill( "grenade_fire", var_0 );

        if ( !isdefined( level.flying_attack_drones ) || level.flying_attack_drones.size == 0 )
            return;

        var_1 = anglestoforward( level.player _meth_8036() );
        calculate_dodge_positions( var_0, var_1 );
        wait 0.5;
        clear_dodge_positions();
    }
}

calculate_dodge_positions( var_0, var_1 )
{
    var_2 = ( 0, 0, 0 );

    foreach ( var_4 in level.flying_attack_drones )
        var_2 += var_4.origin;

    var_2 /= level.flying_attack_drones.size;

    for (;;)
    {
        wait 0.05;

        if ( !isdefined( var_0 ) )
            return;

        var_6 = length( var_0.origin - var_2 );

        if ( var_6 < 200 )
            break;
    }

    foreach ( var_4 in level.flying_attack_drones )
    {
        wait 0.05;

        if ( !isdefined( var_4 ) || !isalive( var_4 ) )
            continue;

        calculate_dodge_position( var_4, var_0, var_1 );
    }

    level notify( "pdrone_wait_in_current_air_space" );
}

calculate_dodge_position( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        return;

    var_3 = var_0.origin - var_1.origin;
    var_2 *= ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );
    var_4 = vectordot( var_3, var_2 );
    var_5 = var_1.origin + var_2 * var_4;
    var_6 = var_0.origin - var_5;
    var_6 *= ( 1, 1, 0 );
    var_6 = vectornormalize( var_6 );
    var_7 = var_0.origin + var_6 * randomfloatrange( 200, 300 );
    var_8 = physicstrace( var_0.origin, var_7 );

    if ( var_8 != var_7 )
    {
        var_9 = length( var_7 - var_0.origin );

        if ( var_9 < 60 )
            return;

        var_7 = var_8 - var_6 * 60;
    }

    var_0.dodge_position = var_7;
    var_0.time_before_attack = randomfloatrange( 2, 3 );
    var_0.time_before_move = randomfloatrange( 1, 3 );
}

clear_dodge_positions()
{
    foreach ( var_1 in level.flying_attack_drones )
    {
        if ( !isdefined( var_1 ) || !isalive( var_1 ) )
            continue;

        var_1.dodge_position = undefined;
    }
}
