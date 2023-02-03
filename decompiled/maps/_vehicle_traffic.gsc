// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

traffic_init( var_0 )
{
    traffic_set_traffic_tuning( 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_debug", 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_dodge_debug", 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_lane_change_debug", 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_debug_spawn", 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_draw_scriptcar_path", 0 );
    common_scripts\utility::create_dvar( "vehicle_traffic_debug_single", 0 );

    if ( !isdefined( level.traffic_cars ) )
        level.traffic_cars = 0;

    if ( !isdefined( level.traffic_cars_scriptmodel_only_count ) )
        level.traffic_cars_scriptmodel_only_count = 0;

    if ( !isdefined( level.script_cars ) )
        level.script_cars = [];

    level.traffic_collision_fx_func = var_0;
    thread handle_wakeup_sphere_global();
}

traffic_set_traffic_tuning( var_0 )
{
    if ( isdefined( var_0 ) && var_0 )
    {
        level.traffic_tune_single_spawn_dist_between_cars = 315;
        level.traffic_tune_fill_spawn_dist_between_cars = 250;
        level.traffic_tune_min_follow_dist = 240;
        level.traffic_tune_min_speedup_dist = 300;
        level.traffic_tune_follow_speed_scale = 0.7;
        level.traffic_tune_min_stop_dist = 230;
        level.traffic_tune_extreme_near_car_dist = 100;
        level.traffic_tune_speedup_speed_scale = 1.3;
        level.traffic_tune_start_spawn_rand_chance = 100;
    }
    else
    {
        level.traffic_tune_single_spawn_dist_between_cars = 800;
        level.traffic_tune_fill_spawn_dist_between_cars = 2000;
        level.traffic_tune_min_follow_dist = 1400;
        level.traffic_tune_min_speedup_dist = 999999.0;
        level.traffic_tune_follow_speed_scale = 0.8;
        level.traffic_tune_min_stop_dist = 300;
        level.traffic_tune_extreme_near_car_dist = 100;
        level.traffic_tune_speedup_speed_scale = 1.0;
        level.traffic_tune_start_spawn_rand_chance = 70;
    }

    level.traffic_tune_single_spawn_dist_between_cars_sq = level.traffic_tune_single_spawn_dist_between_cars * level.traffic_tune_single_spawn_dist_between_cars;
    level.traffic_tune_fill_spawn_dist_between_cars_sq = level.traffic_tune_fill_spawn_dist_between_cars * level.traffic_tune_fill_spawn_dist_between_cars;
    level.traffic_tune_min_follow_dist_sq = level.traffic_tune_min_follow_dist * level.traffic_tune_min_follow_dist;
    level.traffic_tune_min_speedup_dist_sq = level.traffic_tune_min_speedup_dist * level.traffic_tune_min_speedup_dist;
    level.traffic_tune_min_stop_dist_sq = level.traffic_tune_min_stop_dist * level.traffic_tune_min_stop_dist;
    level.traffic_tune_extreme_near_car_dist_sq = level.traffic_tune_extreme_near_car_dist * level.traffic_tune_extreme_near_car_dist;
}

traffic_set_traffic_tuning_lagos_highway()
{
    traffic_set_traffic_tuning( 0 );
    level.traffic_tune_fill_spawn_dist_between_cars = level.traffic_tune_single_spawn_dist_between_cars;
    level.traffic_tune_fill_spawn_dist_between_cars_sq = level.traffic_tune_single_spawn_dist_between_cars_sq;
}

get_max_cars()
{
    if ( level.currentgen )
        return 15;
    else
        return 40;
}

traffic_path_head_car_traffic_jam( var_0 )
{
    traffic_path_all_cars_helper( var_0, 1, 1 );
}

traffic_path_head_car_traffic_jam_end_thread( var_0 )
{
    traffic_path_all_cars_helper( var_0, 0, 0 );
}

traffic_path_head_car_set_force_script_model( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 4 );
}

traffic_path_head_car_set_force_stop( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 3 );
}

traffic_path_all_cars_set_force_stop( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 0 );
}

traffic_path_all_cars_set_script_brush( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 2 );
}

traffic_path_remove_cars_at_node( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 5 );
}

traffic_path_set_cars_at_node_ai_path_blocker( var_0, var_1 )
{
    traffic_path_all_cars_helper( var_0, var_1, 9 );
}

traffic_path_all_cars_helper( var_0, var_1, var_2 )
{
    var_3 = 1;

    for (;;)
    {
        var_4 = var_0 + "_" + var_3;
        var_5 = getvehiclenodearray( var_4, "targetname" );

        if ( !isdefined( var_5 ) || var_5.size <= 0 )
            return;

        foreach ( var_7 in var_5 )
        {
            var_7 notify( "stop_car_random_stops" );

            if ( var_2 == 1 )
            {
                var_7 thread traffic_path_head_car_random_stops();
                continue;
            }

            if ( var_2 == 6 )
            {
                var_7.dont_spawn_over_obstacles = var_1;
                continue;
            }

            if ( var_2 == 7 )
            {
                var_7.no_crash_handling = var_1;
                continue;
            }

            if ( var_2 == 8 )
            {
                var_7.do_pathbased_avoidance = var_1;
                continue;
            }

            traffic_path_all_cars_set_command_single_lane( var_7, var_1, var_2 );
        }

        var_3++;
    }
}

traffic_path_head_car_random_stops()
{
    level endon( "stop_traffic" );
    self endon( "stop_traffic_lane" );
    self endon( "stop_car_random_stops" );
    var_0 = 1;

    for (;;)
    {
        var_1 = ( 20 + randomfloat( 80 ) ) * 0.02;
        wait(var_1);
        traffic_path_all_cars_set_command_single_lane( self, var_0, 3 );
        var_0 = !var_0;
    }
}

traffic_path_all_cars_set_command_single_lane( var_0, var_1, var_2 )
{
    for ( var_3 = var_0.traffic_head_veh; is_traffic_ent( var_3 ); var_3 = var_3.traffic_follower )
    {
        if ( var_2 == 0 || var_2 == 3 )
        {
            if ( var_1 )
            {
                var_3.traffic_speed_override = 0.0;
                var_3 scale_vehicle_speed( 0 );
            }
            else
                var_3.traffic_speed_override = undefined;

            if ( var_2 == 3 )
                break;
        }
        else
        {
            if ( var_2 == 2 )
            {
                if ( var_1 )
                {
                    var_3.vehicle vehicle_assignbrushmodelcollision();
                    var_3.vehicle setcandamage( 1 );
                    var_3.vehicle vehphys_enablecrashing();
                }
                else
                {
                    var_3.vehicle vehicle_removebrushmodelcollision();
                    var_3.vehicle setcandamage( 0 );
                    var_3.vehicle vehphys_disablecrashing();
                }

                continue;
            }

            if ( var_2 == 5 )
            {
                if ( var_3 vehicle_getcurrentnode_a().targetname == var_1 )
                    var_3 notify( "reached_end_node" );

                continue;
            }

            if ( var_2 == 9 )
            {
                if ( var_3 vehicle_getcurrentnode_a().targetname == var_1 )
                    var_3.vehicle disconnectpaths();
            }
        }
    }
}

setup_traffic_path( var_0, var_1, var_2, var_3 )
{
    setup_traffic_path_with_options( var_0, var_1, var_2, var_3, 0, 0, 0, 1, 9000000, 1 );
}

setup_traffic_path_with_options( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( level.traffic_cars ) )
        return;

    if ( !setup_traffic_spawner( var_1 ) )
        return;

    if ( !isdefined( level.traffic_lanes ) )
        level.traffic_lanes = [];

    if ( !isdefined( level.traffic_crashed_vehicles ) )
        level.traffic_crashed_vehicles = [];

    var_10 = 1;

    for (;;)
    {
        var_11 = var_0 + "_" + var_10;
        var_12 = getvehiclenodearray( var_11, "targetname" );

        if ( !isdefined( var_12 ) || var_12.size <= 0 )
            return;

        level thread setup_traffic_group( var_12, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        var_10++;
    }
}

delete_traffic_path( var_0 )
{
    var_1 = 1;

    for (;;)
    {
        var_2 = var_0 + "_" + var_1;
        var_3 = getvehiclenodearray( var_2, "targetname" );

        if ( !isdefined( var_3 ) || var_3.size <= 0 )
            return;

        level delete_traffic_group( var_3 );
        var_1++;
    }
}

setup_traffic_spawner( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    if ( !isdefined( var_1 ) || var_1.size <= 0 )
        return 0;

    if ( !isdefined( level.traffic_spawners ) )
        level.traffic_spawners = [];

    if ( !isdefined( level.traffic_spawners[var_0] ) )
    {
        level.traffic_spawners[var_0] = [];
        var_2 = 0;

        for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        {
            level.traffic_spawners[var_0][var_3]["spawner"] = var_1[var_3];
            level.traffic_spawners[var_0][var_3]["spawner"].traffic_locked = 0;
            level.traffic_spawners[var_0][var_3]["model"] = get_traffic_model( var_1[var_3].model );
            level.traffic_spawners[var_0][var_3]["weight"] = get_traffic_weight( var_1[var_3].vehicletype );
            var_2 += level.traffic_spawners[var_0][var_3]["weight"];
        }

        if ( var_2 > 0 )
        {
            for ( var_3 = 0; var_3 < level.traffic_spawners[var_0].size; var_3++ )
                level.traffic_spawners[var_0][var_3]["normalizedweight"] = level.traffic_spawners[var_0][var_3]["weight"] / var_2;
        }
    }

    return 1;
}

get_traffic_model( var_0 )
{
    if ( var_0 == "vehicle_suburban" )
        return "vehicle_suburban_bridge";

    if ( var_0 == "vehicle_80s_hatch1_silv_destructible_mp" )
        return "vehicle_80s_hatch2_silv";

    if ( var_0 == "vehicle_policecar_lapd_destructible" )
        return "vehicle_policecar_lapd";

    if ( var_0 == "vehicle_80s_wagon1_silv_destructible_mp" )
        return "vehicle_80s_wagon1_silv";

    if ( var_0 == "vehicle_80s_wagon1_red_destructible_mp" )
        return "vehicle_80s_wagon1_red";

    if ( var_0 == "vehicle_uk_utility_truck_destructible" )
        return "vehicle_uk_utility_truck_static";

    if ( var_0 == "vehicle_jeep_rubicon" )
        return "vehicle_jeep_destructible";

    return var_0;
}

get_traffic_weight( var_0 )
{
    if ( var_0 == "civ_domestic_truck_physics" )
        return 1;
    else if ( var_0 == "civ_domestic_sportscar_01_physics" )
        return 0.3;
    else if ( var_0 == "civ_pickup_truck_01_physics" )
        return 1;
    else if ( var_0 == "civ_workvan_physics" )
        return 0.3;
    else if ( var_0 == "civ_domestic_sedan_taxi_01_physics" )
        return 0.5;
    else if ( var_0 == "civ_domestic_sedan_taxi_02_physics" )
        return 0.5;
    else if ( var_0 == "civ_domestic_sedan_01_physics" )
        return 1;
    else
        return 1;
}

setup_traffic_group( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    setup_lane_information( var_0 );

    foreach ( var_12 in var_0 )
    {
        var_12.traffic_force_script_models_only = var_7;
        var_12.traffic_spawn_mode = var_5;

        if ( isdefined( var_4 ) )
            var_12.fill_pos_ent = var_4;

        if ( isdefined( var_9 ) )
            var_12.despawn_dist_sq = var_9;

        if ( isdefined( var_10 ) )
            var_12.despawn_if_not_in_view = var_10;

        if ( isdefined( var_8 ) )
            var_12.vehicle_collision_enabled = var_8;
        else
            var_12.vehicle_collision_enabled = 1;

        level.traffic_lanes[level.traffic_lanes.size] = var_12;
    }

    if ( isdefined( level.traffic_tune_no_spawn ) && level.traffic_tune_no_spawn == var_1 )
        return;

    foreach ( var_12 in var_0 )
    {
        if ( isdefined( var_12.nospawn ) && var_12.nospawn )
            continue;

        if ( isdefined( var_3 ) && var_3 )
            var_12 thread start_traffic_lane( var_2, var_4, var_6 );
    }
}

delete_traffic_group( var_0 )
{
    if ( !isdefined( level.traffic_lanes ) )
        return;

    var_1 = level.traffic_lanes;
    var_2 = level.traffic_lanes.size;
    level.traffic_lanes = [];
    level.additional_delete_cars = [];

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_1[var_3];

        if ( !isdefined( var_4 ) )
            continue;

        if ( !isdefined( var_4.traffic_tail ) )
            continue;

        foreach ( var_6 in var_0 )
        {
            if ( var_6 == var_4 )
            {
                var_7 = var_4.traffic_tail;
                delete_lane_cars( var_4.traffic_tail );
                var_4.traffic_tail.traffic_leader = undefined;
                var_4.traffic_tail = undefined;
                var_4.traffic_head_veh = undefined;
                var_4 notify( "stop_traffic_lane" );
                var_1[var_3] = undefined;
            }
        }
    }

    while ( level.additional_delete_cars.size > 0 )
    {
        var_9 = level.additional_delete_cars;
        level.additional_delete_cars = [];

        foreach ( var_11 in var_9 )
            delete_lane_cars( var_11 );
    }

    foreach ( var_4 in var_1 )
        level.traffic_lanes[level.traffic_lanes.size] = var_4;

    level.additional_delete_cars = undefined;
}

delete_lane_cars( var_0 )
{
    while ( isdefined( var_0 ) )
    {
        var_1 = var_0;

        if ( isdefined( var_0.traffic_leader_pending ) )
            level.additional_delete_cars[level.additional_delete_cars.size] = var_0.traffic_leader_pending;

        var_0 = var_0.traffic_leader;
        var_1 notify( "reached_end_node" );
    }
}

setup_lane_information( var_0 )
{
    var_1 = [];
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( var_4.lane_processed ) )
        {
            var_4.lane_processed = 1;
            var_2[var_2.size] = var_4;
        }

        var_4.traffic_tail = spawnstruct();
        var_4.traffic_head_veh = undefined;
    }

    if ( var_2.size <= 0 )
        return;

    for (;;)
    {
        find_node_neighbors( var_2 );
        var_6 = undefined;
        var_7 = 0;

        for ( var_8 = 0; var_8 < var_2.size; var_8++ )
        {
            var_2[var_8].lane_start_node = var_0[var_8];
            var_9 = var_2[var_8];

            if ( var_7 > 50 )
                return;

            if ( isdefined( var_2[var_8].target ) && isdefined( var_2[var_8].targetname ) )
            {

            }

            if ( isdefined( var_2[var_8].script_noteworthy ) )
            {
                if ( var_2[var_8].script_noteworthy == "traffic_lane_merge" )
                {
                    var_10 = undefined;

                    if ( isdefined( var_2[var_8].target ) )
                        var_10 = getvehiclenodearray( var_2[var_8].target, "target" );

                    if ( isdefined( var_10 ) && var_10.size == 1 )
                    {

                    }
                    else
                    {
                        var_2 = maps\_utility::array_remove_index( var_2, var_8 );
                        var_0 = maps\_utility::array_remove_index( var_0, var_8 );

                        if ( var_2.size <= 0 )
                            return;
                        else
                        {
                            var_8--;
                            continue;
                        }
                    }
                }
                else if ( var_2[var_8].script_noteworthy == "traffic_lane_split" || var_2[var_8].script_noteworthy == "traffic_lane_exit" )
                {
                    if ( isdefined( var_2[var_8].script_linkto ) )
                    {
                        var_11 = getvehiclenodearray( var_2[var_8].script_linkto, "target" );

                        if ( isdefined( var_11 ) && var_11.size == 1 )
                            var_6 = var_2[var_8].script_linkto;
                        else if ( var_2[var_8].script_noteworthy == "traffic_lane_split" )
                        {
                            var_11 = getvehiclenodearray( var_2[var_8].script_linkto, "script_linkname" );

                            foreach ( var_13 in var_11 )
                            {
                                if ( !isdefined( var_13.lane_start_node ) )
                                    var_1[var_1.size] = var_13;
                            }
                        }
                    }
                    else
                    {

                    }
                }
            }

            if ( !isdefined( var_2[var_8].target ) )
            {
                var_7++;
                continue;
            }

            var_15 = getvehiclenode( var_2[var_8].target, "targetname" );

            if ( !isdefined( var_15 ) )
            {
                var_7++;
                continue;
            }

            var_2[var_8] = var_15;
            var_16 = var_2[var_8];
        }

        if ( isdefined( var_6 ) )
        {
            var_17 = getvehiclenode( var_6, "script_linkname" );

            if ( isdefined( var_17 ) )
            {
                var_17.lane_processed = 1;
                var_0[var_0.size] = var_17;
                var_2[var_2.size] = var_17;
            }

            var_6 = undefined;
        }

        if ( var_7 > 0 )
            break;
    }

    foreach ( var_13 in var_1 )
    {
        var_22 = [];
        var_22[0] = var_13;
        setup_lane_information( var_22 );
    }
}

find_node_neighbors( var_0 )
{
    if ( var_0.size <= 1 )
        return;

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !isdefined( var_0[var_1].target ) )
            continue;

        var_2 = getvehiclenode( var_0[var_1].target, "targetname" );

        if ( !isdefined( var_2 ) )
            continue;

        var_3 = vectornormalize( var_2.origin - var_0[var_1].origin );
        var_4 = get_closest_neighbors( var_0[var_1], var_0, var_3 );

        if ( isdefined( var_4["left"] ) )
            var_0[var_1].neighbor_left = var_4["left"];

        if ( isdefined( var_4["right"] ) )
            var_0[var_1].neighbor_right = var_4["right"];
    }
}

get_closest_neighbors( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = 999999999;
    var_5 = undefined;
    var_6 = 999999999;

    for ( var_7 = 0; var_7 < var_1.size; var_7++ )
    {
        if ( var_0 == var_1[var_7] )
            continue;

        var_8 = vectornormalize( var_1[var_7].origin - var_0.origin );
        var_9 = vectorcross( var_8, var_2 );

        if ( var_9[2] > 0 )
        {
            if ( !isdefined( var_5 ) )
            {
                var_5 = var_1[var_7];
                var_6 = distance2dsquared( var_0.origin, var_1[var_7].origin );
            }
            else
            {
                var_10 = distance2dsquared( var_0.origin, var_1[var_7].origin );

                if ( var_10 < var_6 )
                {
                    var_5 = var_1[var_7];
                    var_6 = var_10;
                }
            }

            continue;
        }

        if ( !isdefined( var_3 ) )
        {
            var_3 = var_1[var_7];
            var_4 = distance2dsquared( var_0.origin, var_1[var_7].origin );
            continue;
        }

        var_10 = distance2dsquared( var_0.origin, var_1[var_7].origin );

        if ( var_10 < var_4 )
        {
            var_3 = var_1[var_7];
            var_4 = var_10;
        }
    }

    var_11["left"] = var_3;
    var_11["right"] = var_5;
    return var_11;
}

spawn_single_vehicle_for_lane( var_0, var_1 )
{
    var_2 = getvehiclenode( var_0, "targetname" );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_3 = get_max_cars();

    if ( var_3 < 0 || level.traffic_cars < var_3 )
    {
        var_4 = spawn_new_traffic_entity_at_node( var_2, var_1 );

        if ( isdefined( var_4 ) )
        {
            var_4 insert_to_lane( var_2, undefined, "SPAWNING" );
            return var_4;
        }

        if ( level.currentgen )
            wait 0.1;
    }

    return undefined;
}

get_spawn_chance( var_0 )
{
    var_1 = level.traffic_tune_start_spawn_rand_chance;

    if ( isdefined( var_0.lane_start_node ) && isdefined( var_0.lane_start_node.spawn_chance_override ) )
        var_1 = var_0.lane_start_node.spawn_chance_override;

    return var_1;
}

start_traffic_lane( var_0, var_1, var_2 )
{
    level endon( "stop_traffic" );
    self endon( "stop_traffic_lane" );
    [var_4, var_5] = spawn_route_full_with_traffic_at( self, var_0, var_1, var_2 );

    if ( isdefined( var_4 ) )
    {
        self.traffic_tail.traffic_leader = var_4;
        self.traffic_head_veh = var_5;
        var_4.traffic_follower = self.traffic_tail;
    }

    var_6 = get_max_cars();
    var_7 = getvehiclenode( self.target, "targetname" );

    if ( self.traffic_spawn_mode == 10 || self.traffic_spawn_mode == 20 )
    {
        var_8 = 1;
        var_9 = 0;
        var_10 = 0;

        for (;;)
        {
            if ( isdefined( self.nospawn ) && self.nospawn )
            {
                waitframe();
                continue;
            }

            for ( var_11 = 0; var_11 < 2; var_11++ )
            {
                if ( randomint( 100 ) < get_spawn_chance( self ) * 0.5 )
                {
                    var_12 = undefined;
                    [var_8, var_14, var_15] = get_head_or_tail_variables( var_11, var_10, var_9 );

                    if ( isdefined( var_1 ) )
                        var_12 = get_node_at_radius_distance( var_7, var_1.origin, get_despawn_dist_sq( self ), !var_8 );
                    else
                        var_12 = getvehiclenode( self.target, "targetname" );

                    if ( isdefined( var_12 ) )
                    {
                        var_16 = var_12.targetname;
                        var_4 = undefined;
                        var_5 = undefined;
                        var_4 = self.traffic_tail.traffic_leader;

                        if ( isdefined( self.traffic_head_veh ) )
                            var_5 = self.traffic_head_veh;

                        var_17 = var_14 * level.traffic_tune_single_spawn_dist_between_cars;

                        if ( !isdefined( var_4 ) || !isdefined( var_5 ) || !var_8 && distance2d( var_4.vehicle.origin, var_12.origin ) > level.traffic_tune_single_spawn_dist_between_cars + var_17 && vehicle_in_front_of_node( var_4.vehicle, var_12 ) || var_8 && distance2d( var_5.vehicle.origin, var_12.origin ) > level.traffic_tune_single_spawn_dist_between_cars + var_17 && !vehicle_in_front_of_node( var_5.vehicle, var_12 ) )
                        {
                            var_18 = spawn_single_vehicle_for_lane( var_16, var_0 );

                            if ( isdefined( var_18 ) )
                                var_14 = 0;
                            else
                                var_14++;

                            if ( var_11 == 0 )
                                var_10 = var_14;

                            if ( var_11 == 1 )
                                var_9 = var_14;
                        }
                        else
                            wait 0.5;
                    }

                    if ( self.traffic_spawn_mode != 20 )
                        break;

                    continue;
                }
            }

            var_20 = randomint( 100 );
            wait(var_20 * 0.008);
            waitframe();
        }
    }
    else if ( self.traffic_spawn_mode == 0 )
    {
        for (;;)
        {
            if ( var_6 < 0 || level.traffic_cars < var_6 )
                fill_new_traffic_entity_near_player( self, var_0 );

            wait(randomfloatrange( 3, 6.5 ));
        }
    }
}

get_head_or_tail_variables( var_0, var_1, var_2 )
{
    if ( var_0 == 0 )
    {
        var_3 = 0;
        var_4 = var_1;
        var_5 = "tail";
        return [ var_3, var_4, var_5 ];
    }
    else
    {
        var_3 = 1;
        var_4 = var_2;
        var_5 = "head";
        return [ var_3, var_4, var_5 ];
    }
}

vehicle_in_front_of_node( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    var_2 = var_0.origin - var_1.origin;
    var_3 = getvehiclenode( var_1.target, "targetname" );

    if ( !isdefined( var_3 ) )
        return 1;

    var_4 = var_3.origin - var_1.origin;
    var_2 = vectornormalize( var_2 );
    var_4 = vectornormalize( var_4 );
    var_5 = vectordot( var_2, var_4 );
    return var_5 > 0;
}

get_pos_at_given_distance_on_lane( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0;
    var_5 = var_2;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = var_1;
    var_9 = 0;
    var_10 = 0;

    if ( !isdefined( var_1.target ) )
        var_8 = undefined;

    if ( var_3 )
    {
        var_11 = distance( var_4, var_8.origin );
        var_12 = randomfloatrange( 1, var_11 * 0.5 + 2.0 );
        var_5 += randomfloatrange( var_5, var_5 + var_12 );
    }

    while ( isdefined( var_8 ) && isdefined( var_8.target ) )
    {
        var_11 = distance( var_4, var_8.origin );
        var_13 = var_8.origin - var_4;
        var_14 = vectornormalize( var_13 );

        if ( var_11 > var_5 )
        {
            var_6 = var_4 + var_14 * var_5;
            var_7 = vectortoangles( var_14 );
            var_10 += var_5;
            break;
        }
        else
        {
            var_5 -= var_11;
            var_4 = var_8.origin;
            var_10 += var_11;
        }

        var_8 = getvehiclenode( var_8.target, "targetname" );
        var_9++;
    }

    return [ var_6, var_7, var_1, var_8, var_10 ];
}

spawn_route_full_with_traffic_at( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0.target ) )
        return [ undefined, undefined ];

    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = get_max_cars();
    var_8 = undefined;
    var_9 = undefined;
    var_10 = var_0.origin;
    var_11 = 0;
    var_12 = get_despawn_dist_sq( var_0.lane_start_node );
    var_13 = var_0;
    var_14 = -1;

    while ( isdefined( var_0 ) && isdefined( var_0.target ) )
    {
        var_14++;
        var_0 = var_13;

        if ( var_7 >= 0 && level.traffic_cars >= var_7 )
            break;

        if ( var_14 == 0 )
            var_11 = randomfloat( level.traffic_tune_fill_spawn_dist_between_cars * 0.5 );
        else
            var_11 = level.traffic_tune_fill_spawn_dist_between_cars;

        if ( var_3 )
            [var_8, var_9, var_0, var_13, var_16] = get_pos_at_given_distance_on_lane( var_10, var_0, var_11, 0 );
        else
            [var_8, var_9, var_0, var_13, var_16] = get_pos_at_given_distance_on_lane( var_10, var_0, var_11, 1 );

        if ( !isdefined( var_8 ) )
            break;

        var_10 = var_8;

        if ( isdefined( var_0.script_noteworthy ) && var_0.script_noteworthy == "traffic_lane_merge" )
        {
            if ( var_0.script_noteworthy == "traffic_lane_merge" )
                return [ var_4, var_5 ];
        }

        if ( isdefined( var_0.lane_start_node ) && isdefined( var_0.lane_start_node.nospawn ) && var_0.lane_start_node.nospawn || isdefined( var_2 ) && distance2dsquared( var_8, var_2.origin ) > var_12 || isdefined( var_0.script_noteworthy ) && ( var_0.script_noteworthy == "traffic_lane_split" || var_0.script_noteworthy == "traffic_lane_exit" ) )
            continue;

        if ( randomint( 100 ) < get_spawn_chance( var_0 ) )
        {
            var_6 = spawn_new_traffic_entity_at_node_override( var_8, var_9, var_0, var_1 );

            if ( isdefined( var_6 ) )
            {
                if ( !isdefined( var_4 ) )
                    var_4 = var_6;

                if ( isdefined( var_5 ) )
                {
                    var_5.traffic_leader = var_6;
                    var_6.traffic_follower = var_5;
                }

                var_5 = var_6;
            }
            else
            {

            }

            continue;
        }
    }

    return [ var_4, var_5 ];
}

fill_new_traffic_entity_near_player( var_0, var_1 )
{
    var_2 = level.player.origin;
    var_3 = anglestoforward( level.player getangles() );

    if ( !isdefined( var_0.target ) )
        return;

    var_4 = randomint( level.traffic_spawners[var_1].size );
    var_5 = var_0;
    var_6 = get_max_cars();

    for (;;)
    {
        if ( var_6 >= 0 && level.traffic_cars >= var_6 )
            return;

        if ( !isdefined( var_5.target ) )
            return;

        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "traffic_lane_merge" )
            return;

        var_7 = getvehiclenode( var_5.target, "targetname" );

        if ( !isdefined( var_7 ) )
            return;

        if ( randomint( 100 ) < get_spawn_chance( var_0 ) )
        {
            var_8 = vectornormalize( var_7.origin - var_5.origin );
            var_9 = vectordot( var_8, var_3 );
            var_10 = var_5.origin - var_2;
            var_11 = length2dsquared( var_10 );
            var_12 = vectornormalize( var_10 );
            var_13 = vectordot( var_12, var_3 );
            var_14 = var_9 > 0;
            var_15 = var_13 > 0;

            if ( !var_14 && !var_15 )
                return;

            if ( !var_14 && var_11 < 225000000 )
                return;

            if ( var_14 && var_11 > 400000000 )
                return;

            var_16 = 0;

            if ( var_15 && var_11 > 225000000 && var_11 < 400000000 )
                var_16 = 1;

            if ( var_16 )
            {
                var_17 = undefined;
                var_18 = find_closest_car( var_5, var_5.origin );

                if ( isdefined( var_18 ) )
                    var_17 = distance2dsquared( var_18.vehicle.origin, var_5.origin );

                if ( !isdefined( var_17 ) || var_17 > level.traffic_tune_single_spawn_dist_between_cars_sq )
                {
                    var_19 = spawn_new_traffic_entity_at_node( var_5, var_1 );

                    if ( isdefined( var_19 ) )
                        var_19 insert_to_lane( var_5, var_18, "FILL" );
                }
            }
        }

        var_5 = var_7;
    }
}

spawn_new_traffic_entity_at_node( var_0, var_1 )
{
    return spawn_new_traffic_entity_at_node_override( var_0.origin, var_0.angles, var_0, var_1 );
}

spawn_new_traffic_entity_at_node_override( var_0, var_1, var_2, var_3 )
{
    if ( check_if_intersecting_any_script_car( var_0, var_2.lane_start_node ) )
        return undefined;

    if ( isdefined( var_2.nospawn ) )
        return undefined;

    var_4 = 0;
    var_5 = randomfloatrange( 0, 1 );

    for ( var_6 = 0; var_6 < level.traffic_spawners[var_3].size; var_6++ )
    {
        if ( var_5 < level.traffic_spawners[var_3][var_6]["normalizedweight"] )
        {
            var_4 = var_6;
            break;
        }

        var_5 -= level.traffic_spawners[var_3][var_6]["normalizedweight"];
    }

    var_7 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_7.is_traffic_ent = 1;
    var_7.targetname = "traffic_vehicle";
    var_7.traffic_spawner = level.traffic_spawners[var_3][var_4];
    var_7.traffic_speed_status = 0;
    var_7.traffic_leader = undefined;
    var_7.traffic_follower = undefined;
    var_7.spawn_time = gettime();

    if ( isdefined( var_2.speed ) )
        var_7.traffic_speed = var_2.speed;

    var_7.currentnode = var_2;
    var_7.birthnode = var_2.lane_start_node;

    if ( !var_2.lane_start_node.traffic_force_script_models_only && should_be_vehicle( var_2.origin ) )
        var_8 = var_7 spawn_new_traffic_vehicle( var_0, var_1, var_2, level.traffic_spawners[var_3][var_4] );
    else
        var_8 = var_7 spawn_new_traffic_model( var_0 - ( 0, 0, 16 ), var_1, var_2, level.traffic_spawners[var_3][var_4] );

    if ( isdefined( var_8 ) )
    {
        var_7.vehicle = var_8;

        if ( isdefined( var_2.lane_start_node.vehicle_easy_crash_die ) )
        {
            if ( var_8.code_classname == "script_vehicle" )
                var_8.health = 5;
            else
                var_8.currenthealth = 5;
        }

        if ( !var_2.lane_start_node.traffic_force_script_models_only )
            var_7 thread traffic_type_swap();

        var_7 thread monitor_vehicle_speed();
        var_7 thread car_behavior();
        var_7 thread clean_up_car( var_2.lane_start_node.traffic_force_script_models_only );
        return var_7;
    }
    else
    {
        var_7 delete();
        return undefined;
    }
}

spawn_new_traffic_vehicle( var_0, var_1, var_2, var_3 )
{
    while ( var_3["spawner"].traffic_locked == 1 )
        wait 0.05;

    foreach ( var_5 in vehicle_getarray() )
    {
        if ( abs( var_5.origin[2] - var_0[2] ) < 50.0 && distance2dsquared( var_5.origin, var_0 ) < level.traffic_tune_extreme_near_car_dist_sq )
            return undefined;
    }

    var_3["spawner"].traffic_locked = 1;
    var_5 = var_3["spawner"] maps\_utility::spawn_vehicle();
    thread unlock_traffic_spawner( var_3 );

    if ( isdefined( var_5 ) )
    {
        var_5.parent_ent = self;
        var_7 = undefined;

        if ( !isdefined( self.currentnode.lane_start_node.vehicle_nodrivers ) || !self.currentnode.lane_start_node.vehicle_nodrivers )
        {
            var_8 = getent( "civ_vehicle_driver_spawner", "targetname" );

            if ( isdefined( var_8 ) )
            {
                var_7 = var_8 maps\_utility::spawn_ai( 1 );
                var_5 maps\_utility::guy_enter_vehicle( var_7 );
                var_7 setcandamage( 0 );
            }
        }

        var_5 thread clean_up_on_parent_death( self );
        var_5 vehicle_setspeedimmediate( model_speed_to_mph( self.traffic_speed ), 15, 15 );

        if ( isdefined( self.currentnode.lane_start_node.vehicle_notsolid ) && self.currentnode.lane_start_node.vehicle_notsolid )
        {
            if ( isdefined( var_7 ) )
                var_7 notsolid();

            var_5 vehicle_removebrushmodelcollision();
            var_5 vehphys_disablecrashing();
        }

        if ( isdefined( self.currentnode.lane_start_node.no_crash_handling ) && !self.currentnode.lane_start_node.no_crash_handling )
            var_5 thread handle_traffic_collisions();

        if ( islagostraversesetting( var_5 ) )
        {
            if ( isdefined( var_7 ) )
                var_7 notsolid();
        }

        var_5 thread setup_vehicle_for_damage();
        thread sync_entity_damage( var_5 );
        var_5 vehicle_teleport( var_0, var_1, 1 );
        var_5 thread traffic_drive_vehicle( var_2 );
        var_5 thread handle_brake_lights();
        var_5 thread detect_being_pushed( ::force_vehicle_delete );
        var_5 thread detect_dropping();
        var_5 soundscripts\_snd::snd_message( "spawn_new_traffic_vehicle" );
    }

    return var_5;
}

unlock_traffic_spawner( var_0 )
{
    wait 0.05;
    var_0["spawner"].traffic_locked = 0;
}

spawn_new_traffic_model( var_0, var_1, var_2, var_3 )
{
    if ( level.currentgen && level.traffic_cars_scriptmodel_only_count > 20 )
        return undefined;

    var_4 = spawn( "script_model", var_0 );
    var_4.angles = var_1;
    var_4 setmodel( var_3["model"] );

    if ( var_2.lane_start_node.traffic_force_script_models_only && isdefined( level.vehicle_deathmodel ) && isdefined( level.vehicle_deathmodel[var_4.model] ) && var_2.lane_start_node.vehicle_collision_enabled )
    {
        var_4 vehicle_assignbrushmodelcollision();
        var_4 setcandamage( 1 );
        var_4 thread monitor_script_model_damage();
    }
    else
    {
        var_4 vehicle_removebrushmodelcollision();
        var_4 notsolid();
        var_4 removefrommovingplatformsystem( 1 );
    }

    var_4 thread clean_up_on_parent_death( self );
    sync_entity_damage( var_4 );
    var_4.parent_ent = self;
    var_4 thread traffic_drive_vehicle( var_2 );
    var_4 thread vehicle_treads_script_model( var_3["spawner"].classname );
    return var_4;
}

vehicle_treads_script_model( var_0 )
{
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    self endon( "death" );
    var_1 = maps\_vehicle_code::get_vehicle_effect( var_0, "default_script_model" );

    if ( isdefined( var_1 ) )
        playfxontag( var_1, self, "tag_origin" );
}

clear_cars_around_pos( var_0, var_1, var_2 )
{
    var_3 = var_1 * var_1;
    var_4 = getentarray( "traffic_vehicle", "targetname" );

    foreach ( var_6 in var_4 )
    {
        if ( !isdefined( var_6 ) )
            continue;

        if ( isdefined( var_2 ) )
        {
            if ( var_2 && !isdefined( var_6.vehicle ) )
                continue;
        }

        var_7 = distance2dsquared( var_6.vehicle.origin, var_0 );

        if ( var_7 < var_3 )
            var_6 notify( "reached_end_node" );
    }
}

add_script_car( var_0, var_1 )
{
    var_2 = undefined;

    for ( var_3 = 0; var_3 < level.script_cars.size; var_3++ )
    {
        if ( !isdefined( level.script_cars[var_3] ) )
        {
            var_2 = var_3;
            break;
        }
    }

    if ( !isdefined( var_2 ) )
        var_2 = level.script_cars.size;

    level.script_cars[var_2] = var_0;

    if ( !isdefined( var_1 ) || isdefined( var_1 ) && var_1 )
        var_0 thread handle_traffic_collisions();

    var_0 thread mark_adjacent_script_cars();
    level notify( "new_script_car", var_0 );
}

mark_adjacent_script_cars()
{
    self endon( "death" );
    var_0 = 160000;
    var_1 = 130;
    var_2 = 0.5;

    for (;;)
    {
        if ( vehicle_getspeed_a() > 50 )
        {
            var_3 = 0;
            self.script_car_on_left = undefined;
            self.script_car_on_right = undefined;

            foreach ( var_5 in level.script_cars )
            {
                if ( !isdefined( var_5 ) || self == var_5 )
                    continue;

                var_6 = [];

                if ( isdefined( var_5 gettagorigin( "tag_wheel_back_left" ) ) && isdefined( var_5 gettagorigin( "tag_wheel_front_right" ) ) )
                {
                    var_6[0] = var_5 get_adjusted_script_car_origin( 0 );
                    var_6[1] = var_5 get_adjusted_script_car_origin( 1 );
                }
                else
                    var_6[0] = var_5.origin;

                foreach ( var_8 in var_6 )
                {
                    if ( distance2dsquared( self.origin, var_8 ) < var_0 )
                    {
                        var_3 = 1;
                        var_9 = self.origin + ( 0, 0, 25 );
                        var_10 = var_5 get_adjusted_script_car_origin( 0 ) - var_9;
                        var_11 = anglestoright( self.angles );
                        var_12 = vectordot( var_11, var_10 );

                        if ( var_12 > 0 && var_12 > var_1 && var_12 < var_1 * 2 )
                            self.script_car_on_right = var_5;

                        if ( var_12 < 0 && var_12 < -1 * var_1 && var_12 > var_1 * -2 )
                            self.script_car_on_left = var_5;
                    }
                }
            }
        }

        wait(var_2);
    }
}

remove_script_car( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.script_cars )
    {
        if ( !isdefined( var_3 ) || var_3 == var_0 )
            continue;

        var_1[var_1.size] = var_3;
    }

    level.script_cars = var_1;
}

check_if_intersecting_any_script_car( var_0, var_1 )
{
    if ( isdefined( var_1.dont_spawn_over_obstacles ) && !var_1.dont_spawn_over_obstacles )
        return 0;

    var_2 = 136900;

    foreach ( var_4 in level.script_cars )
    {
        if ( !isdefined( var_4 ) )
            continue;

        var_5[0] = var_4.origin;

        if ( isdefined( var_4 gettagorigin( "tag_wheel_back_left" ) ) && isdefined( var_4 gettagorigin( "tag_wheel_front_right" ) ) )
        {
            var_5[0] = var_4 get_adjusted_script_car_origin( 0 );
            var_5[1] = var_4 get_adjusted_script_car_origin( 1 );
        }

        foreach ( var_7 in var_5 )
        {
            if ( distance2dsquared( var_7, var_0 ) < var_2 )
                return 1;
        }
    }

    return 0;
}

is_traffic_ent( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_0.is_traffic_ent ) || !var_0.is_traffic_ent )
        return 0;

    return 1;
}

traffic_drive_vehicle( var_0 )
{
    var_1 = 0;
    level endon( "stop_traffic" );
    self endon( "death" );
    self notify( "traffic_drive_vehicle_once" );
    self endon( "traffic_drive_vehicle_once" );
    thread traffic_handle_messages();

    if ( self.classname == "script_model" )
    {
        var_2 = var_0;
        var_3 = anglestoforward( self.angles );
        var_4 = var_2.origin - self.origin;
        var_4 = vectornormalize( var_4 );
        var_5 = vectordot( var_3, var_4 );
        var_6 = distance2dsquared( var_0.origin, self.origin );

        if ( var_6 < level.traffic_tune_extreme_near_car_dist_sq || var_5 < 0 )
        {
            if ( isdefined( var_0.target ) )
                var_2 = getvehiclenode( var_0.target, "targetname" );
            else
                var_1 = 1;
        }

        for (;;)
        {
            if ( isdefined( var_2 ) )
            {
                script_vehicle_move_to_node( var_2 );

                if ( isdefined( var_2.script_noteworthy ) )
                    self notify( "noteworthy", var_2.script_noteworthy );

                var_0 = var_2;

                if ( !isdefined( var_0.target ) )
                {
                    var_1 = 1;
                    break;
                }

                var_2 = getvehiclenode( var_2.target, "targetname" );

                if ( isdefined( var_0.speed ) )
                    adjust_model_speed_to_node( var_0 );

                continue;
            }

            var_1 = 1;
            break;
        }
    }
    else
    {
        var_7 = getvehiclenodepreviousforstartpath( var_0 );

        if ( isdefined( var_7 ) )
            var_0 = var_7;

        thread maps\_vehicle_code::_vehicle_paths( var_0 );
        self startpath( var_0 );
        self waittill( "reached_end_node" );
        self.parent_ent notify( "reached_end_node" );
    }

    if ( var_1 )
    {
        if ( gettime() == self.parent_ent.spawn_time )
            waitframe();

        self.parent_ent notify( "reached_end_node" );
        return;
    }
}

getvehiclenodepreviousforstartpath( var_0 )
{
    var_1 = getvehiclenodearray( var_0.targetname, "target" );

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( var_1.size == 1 )
        return var_1[0];

    var_2 = undefined;
    var_3 = 0;

    foreach ( var_5 in var_1 )
    {
        var_6 = var_0.origin - var_5.origin;
        var_6 = ( var_6[0], var_6[1], 0 );
        var_6 = vectornormalize( var_6 );
        var_7 = anglestoforward( self.angles );
        var_7 = ( var_7[0], var_7[1], 0 );
        var_7 = vectornormalize( var_7 );
        var_8 = vectordot( var_7, var_6 );

        if ( var_8 > var_3 )
        {
            var_3 = var_8;
            var_2 = var_5;
        }
    }

    return var_2;
}

script_vehicle_move_to_node( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        var_1 = distance2dsquared( var_0.origin, self.origin );

        if ( var_1 < level.traffic_tune_extreme_near_car_dist_sq )
        {
            if ( ( !isdefined( self.parent_ent.traffic_speed_override ) || self.parent_ent.traffic_speed_override > 0 ) && self.parent_ent.traffic_speed > 0 )
                return;
        }

        path_to_node_at_current_speed( var_1, var_0 );
    }
}

set_zero_speed( var_0 )
{
    var_1 = var_0.origin - ( 0, 0, 16 ) - self.origin;
    var_2 = undefined;

    if ( length2dsquared( var_1 ) < 400 )
        var_2 = var_0.origin;
    else
    {
        var_1 = vectornormalize( var_1 );
        var_2 = self.origin + var_1 * 20;
    }

    var_2 = self.origin;
    self moveto( var_2, 0.15, 0, 0.15 );
    self rotateto( self.angles, 0.1, 0, 0.1 );
}

path_to_node_at_current_speed( var_0, var_1 )
{
    self endon( "death" );
    self endon( "traffic_speed_changed" );

    if ( self.parent_ent.traffic_speed <= 0.0 )
    {
        set_zero_speed( var_1 );
        self waittill( "forever" );
    }

    var_5 = sqrt( var_0 ) / self.parent_ent.traffic_speed;
    var_6 = var_5 * 2;
    var_7 = maps\_utility::round_float( var_6, 1, 0 );
    var_8 = var_7 * 0.5;
    self.parent_ent.currentnode = var_1;
    self moveto( var_1.origin - ( 0, 0, 27 ), var_8 + 0.05, 0, 0 );
    self rotateto( var_1.angles, var_5, 0, 0 );
    wait(var_8);
}

traffic_handle_messages()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );
    self endon( "vehicle_crash" );
    self notify( "traffic_handle_msg_once" );
    self endon( "traffic_handle_msg_once" );

    for (;;)
    {
        self waittill( "noteworthy", var_0 );

        if ( var_0 == "traffic_lane_merge" )
        {
            self.parent_ent merge_lane();
            continue;
        }

        if ( var_0 == "traffic_lane_split" || var_0 == "traffic_lane_exit" )
            self.parent_ent split_lane();
    }
}

traffic_type_swap()
{
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    self endon( "death" );
    self endon( "vehicle_crash" );
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0.2;

    if ( !isdefined( self ) )
        return;

    wait 0.1;

    for (;;)
    {
        if ( self.vehicle.classname == "script_model" )
        {
            if ( should_be_vehicle( self.vehicle.origin, self.vehicle.classname ) )
            {
                if ( self.traffic_spawner["spawner"].traffic_locked == 0 )
                {
                    var_1 = spawn_new_traffic_vehicle( self.vehicle.origin, self.vehicle.angles, self.currentnode, self.traffic_spawner );

                    if ( isdefined( var_1 ) )
                    {
                        self.vehicle delete();
                        self.vehicle = var_1;
                        self.vehicle.parent_ent = self;
                        var_1 vehicle_setspeedimmediate( model_speed_to_mph( self.traffic_speed ), 15, 15 );
                        self notify( "swap_to_real_vehicle" );
                    }
                    else
                        self notify( "reached_end_node" );
                }
            }
        }
        else if ( !should_be_vehicle( self.vehicle.origin, self.vehicle.classname ) )
        {
            var_1 = spawn_new_traffic_model( self.vehicle.origin, self.vehicle.angles, self.vehicle.currentnode, self.traffic_spawner );

            if ( isdefined( var_1 ) )
            {
                self.vehicle notify( "newpath" );
                self.vehicle notify( "stop_dodge" );

                if ( isdefined( self.vehicle.deathfx_ent ) )
                    self.vehicle.deathfx_ent delete();

                self.vehicle delete();
                self.vehicle = var_1;
                self.vehicle.parent_ent = self;
            }
        }

        wait(var_0);
    }
}

restore_vehicle_speed()
{
    if ( isdefined( self.traffic_old_speed ) )
    {
        self.traffic_speed = self.traffic_old_speed;
        self.vehicle notify( "traffic_speed_changed" );
    }

    self.traffic_old_speed = undefined;
}

scale_vehicle_speed( var_0 )
{
    if ( isdefined( self.traffic_old_speed ) )
    {
        if ( self.traffic_speed == self.traffic_old_speed * var_0 )
            return;
    }

    restore_vehicle_speed();
    self.traffic_old_speed = self.traffic_speed;
    self.traffic_speed *= var_0;

    if ( self.vehicle.classname != "script_model" )
        self.vehicle vehicle_setspeed( model_speed_to_mph( self.traffic_speed ), 15, 15 );
    else
        self.vehicle notify( "traffic_speed_changed" );
}

set_vehicle_speed( var_0 )
{
    if ( !isdefined( self.traffic_old_speed ) )
        self.traffic_old_speed = self.traffic_speed;

    if ( self.traffic_speed != var_0 )
    {
        self.traffic_speed = var_0;

        if ( self.vehicle.classname != "script_model" )
            self.vehicle vehicle_setspeed( model_speed_to_mph( self.traffic_speed ), 15, 15 );
        else
            self.vehicle notify( "traffic_speed_changed" );
    }
}

monitor_vehicle_speed()
{
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    self endon( "death" );
    self endon( "vehicle_crash" );
    wait 0.05;

    for (;;)
    {
        self.traffic_speed_status_prev = self.traffic_speed_status;

        if ( isdefined( self.currentnode.is_blockage ) && self.currentnode.is_blockage )
        {
            self.traffic_speed_status = -10;
            scale_vehicle_speed( 0 );
        }
        else if ( isdefined( self.traffic_speed_override ) )
        {
            self.traffic_speed_status = -20;
            set_vehicle_speed( mph_to_model_speed( self.traffic_speed_override ) );
        }
        else if ( !isdefined( self.dodging ) )
        {
            var_0 = 2222220000.0;
            var_1 = 0;

            if ( isdefined( self.traffic_leader ) && self.traffic_leader != self )
            {
                var_1 = 1;
                var_0 = distance2dsquared( self.vehicle.origin, self.traffic_leader.vehicle.origin );
            }

            if ( var_0 < level.traffic_tune_extreme_near_car_dist_sq )
                self notify( "reached_end_node" );
            else if ( self.traffic_speed_status != 10 && var_0 < level.traffic_tune_min_stop_dist_sq )
            {
                self.traffic_speed_status = 10;
                scale_vehicle_speed( 0 );

                if ( self.vehicle.code_classname == "script_vehicle" )
                    self.traffic_stop_waittime = gettime() + randomfloat( 100 );
                else
                    self.traffic_stop_waittime = gettime() + randomfloat( 1000 );
            }
            else if ( self.traffic_speed_status == 10 )
            {
                if ( var_0 > level.traffic_tune_min_stop_dist_sq * 1.1 )
                {
                    if ( !var_1 || gettime() > self.traffic_stop_waittime )
                    {
                        self.traffic_speed_status = 20;
                        scale_vehicle_speed( level.traffic_tune_follow_speed_scale );
                    }
                }
            }
            else if ( islagostraversesetting( self.vehicle ) && isdefined( self.traffic_change_lane ) && self.traffic_change_lane )
            {
                if ( isdefined( self.traffic_change_lane_speed ) )
                    set_vehicle_speed( self.traffic_change_lane_speed );
                else
                    scale_vehicle_speed( 1.5 );
            }
            else if ( self.traffic_speed_status != 20 && var_0 < level.traffic_tune_min_follow_dist_sq )
            {
                self.traffic_speed_status = 20;
                scale_vehicle_speed( level.traffic_tune_follow_speed_scale );
            }
            else if ( self.traffic_speed_status == 20 )
            {
                if ( var_0 > level.traffic_tune_min_follow_dist_sq * 1.1 )
                    self.traffic_speed_status = 0;
            }
            else if ( !islagostraversesetting( self.vehicle ) && isdefined( self.traffic_change_lane ) && self.traffic_change_lane )
                scale_vehicle_speed( 1.5 );
            else if ( self.traffic_speed_status != 30 && var_0 > level.traffic_tune_min_speedup_dist_sq && var_1 )
            {
                self.traffic_speed_status = 30;
                scale_vehicle_speed( level.traffic_tune_speedup_speed_scale );
            }
            else if ( self.traffic_speed_status == 30 )
            {
                if ( var_0 < level.traffic_tune_min_speedup_dist_sq * 0.9 || !var_1 )
                    self.traffic_speed_status = 0;
            }
            else if ( isdefined( self.traffic_old_speed ) )
            {
                restore_vehicle_speed();

                if ( self.vehicle.classname != "script_model" )
                    self.vehicle resumespeed( 15 );

                self.traffic_speed_status = 0;
            }
        }

        process_traffic_leader_pending_due_to_lane_split();
        wait 0.05;
    }
}

process_traffic_leader_pending_due_to_lane_split()
{
    if ( level.template_script != "lagos" )
        return;

    var_0 = 0;

    if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
    {
        if ( isdefined( self.traffic_leader ) )
        {
            var_1 = anglestoforward( self.vehicle.angles );
            var_2 = vectornormalize( var_1 );
            var_3 = self.traffic_leader.vehicle.origin - self.vehicle.origin;
            var_4 = vectordot( var_3, var_2 ) * var_2;
            var_5 = distance2dsquared( var_3, var_4 );

            if ( var_5 > 8100 )
            {
                self.traffic_leader = self.traffic_leader_pending;
                var_0 = 1;
            }
        }
        else
        {
            self.traffic_leader = self.traffic_leader_pending;
            var_0 = 1;
        }

        if ( var_0 )
        {
            self.traffic_leader_pending_check = undefined;
            self.traffic_leader_pending = undefined;
        }
    }
}

handle_brake_lights()
{
    self endon( "death" );

    if ( !isdefined( level.vehicle_lights_group[self.classname] ) || !isdefined( level.vehicle_lights_group[self.classname]["brakelights"] ) )
        return;

    var_0 = 0.1;

    if ( level.currentgen )
        var_0 = 0.25;

    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        var_3 = self vehicle_getspeed();

        if ( var_3 < var_2 && !var_1 )
        {
            thread maps\_vehicle::vehicle_lights_on( "brakelights" );
            var_1 = 1;
        }
        else if ( var_1 && ( var_3 == 0 || var_3 > var_2 ) )
        {
            thread maps\_vehicle::vehicle_lights_off( "brakelights" );
            var_1 = 0;
        }

        var_2 = var_3;
        wait(var_0);
    }
}

car_behavior()
{
    thread lane_change_behavior();
    thread dodge_behavior();
    thread telefrag_behavior();
}

lane_change_behavior()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );
    self endon( "vehicle_crash" );
    self.traffic_change_lane = 0;
    waitframe();

    for (;;)
    {
        thread decide_to_change_lane();
        self waittill( "change_lane", var_0, var_1 );

        if ( isdefined( var_0 ) )
            thread turn_signal_on( var_0 );

        change_lane( var_0, var_1 );
        self notify( "changing_lane" );
        wait 0.7;
        var_2 = 0;
    }
}

turn_signal_on( var_0 )
{
    self notify( "one_turn_signal_on" );
    self endon( "one_turn_signal_on" );
    self endon( "death" );
    self endon( "reached_end_node" );

    if ( self.vehicle.classname == "script_model" )
        return;

    if ( !isdefined( var_0 ) )
        return;

    var_1 = [];
    var_2 = [];

    if ( var_0 == "left" )
    {
        var_1 = [ "taillight_scroll_left" ];
        var_2 = [ "taillight_left", "mirrorlight_left", "frontsignal_left" ];
    }
    else if ( var_0 == "right" )
    {
        var_1 = [ "taillight_scroll_right" ];
        var_2 = [ "taillight_right", "mirrorlight_right", "frontsignal_right" ];
    }

    var_3 = common_scripts\utility::array_combine( var_1, var_2 );
    self endon( var_0 + "_light_off" );
    thread turn_signal_off( var_0, var_3 );
    thread traffic_vehicle_lights_on( var_1 );

    for (;;)
    {
        traffic_vehicle_lights_on( var_2 );
        wait 0.35;
        traffic_vehicle_lights_off( var_2 );
        wait 0.5;
    }
}

turn_signal_off( var_0, var_1 )
{
    wait_for_turn_signal_off();

    if ( !isdefined( self ) )
        return;

    self notify( var_0 + "_light_off" );
    traffic_vehicle_lights_off( var_1 );
}

wait_for_turn_signal_off()
{
    self endon( "one_turn_signal_on" );
    self endon( "death" );
    self waittill( "changing_lane" );
    wait 5;
}

decide_to_change_lane()
{
    self endon( "death" );
    self endon( "reached_end_node" );
    self endon( "vehicle_crash" );
    wait 0.05;
    thread change_lane_too_close();
}

get_path_segment_array( var_0, var_1, var_2 )
{
    var_3 = var_0;
    var_4 = distance2d( self.vehicle.origin, var_3.origin );
    var_5 = [];

    if ( isdefined( var_2 ) && var_2 )
    {
        var_6 = getvehiclenode( var_0.targetname, "target" );

        if ( isdefined( var_6 ) )
            var_5[var_5.size] = var_6;
    }

    var_5[var_5.size] = var_0;

    for (;;)
    {
        if ( !isdefined( var_3 ) )
            break;

        if ( !isdefined( var_3.target ) )
            break;

        var_7 = var_3;
        var_3 = getvehiclenode( var_3.target, "targetname" );
        var_4 += distance2d( var_7.origin, var_3.origin );

        if ( var_4 > var_1 )
        {
            var_5[var_5.size] = var_3;
            break;
        }

        if ( var_5.size > 5 )
            break;

        var_5[var_5.size] = var_3;
    }

    return var_5;
}

get_c_right_dist_2d( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 = ( var_0[0], var_0[1], 0 );
    var_1 = ( var_1[0], var_1[1], 0 );
    var_2 = ( var_2[0], var_2[1], 0 );
    var_4 = ( var_4[0], var_4[1], 0 );
    var_3 = ( var_3[0], var_3[1], 0 );
    var_5 = ( var_5[0], var_5[1], 0 );

    if ( vectors_are_equal_2d( var_0, var_1 ) )
    {
        var_6 = var_3 - var_0;
        var_7 = var_5 - var_0;
        var_8 = vectornormalize( var_6 );
        var_9 = var_8 * vectordot( var_7, var_8 );
        var_10 = var_5 - var_0 + var_9;
        var_11 = vectornormalize( var_10 );
        return vectordot( var_7, var_11 );
    }
    else
    {
        var_6 = var_0 - var_2;
        var_7 = var_1 - var_2;
        var_8 = vectornormalize( var_6 );
        var_9 = var_8 * vectordot( var_7, var_8 );
        var_10 = var_1 - var_2 + var_9;
        var_11 = vectornormalize( var_10 );
        return vectordot( var_7, var_11 );
    }
}

vehicle_getcurrentnode_a()
{
    var_0 = undefined;

    if ( self.code_classname == "script_vehicle" )
    {
        var_0 = self vehicle_getcurrentnode();

        if ( isdefined( var_0 ) && isdefined( var_0.target ) )
            var_0 = getvehiclenode( var_0.target, "targetname" );
        else if ( isdefined( self.parent_ent ) )
            var_0 = self.parent_ent.currentnode;
    }
    else if ( isdefined( self.parent_ent ) )
        var_0 = self.parent_ent.currentnode;
    else if ( is_traffic_ent( self ) )
        return self.vehicle vehicle_getcurrentnode_a();

    if ( isdefined( self._animactive ) && self._animactive > 0 )
    {
        var_0 = undefined;

        if ( isdefined( var_0 ) )
            var_0 = get_closest_node_in_front_of_given_car( var_0, self );

        if ( !isdefined( var_0 ) && isdefined( self.vehicle_spawner.target ) )
            var_0 = getvehiclenode( self.vehicle_spawner.target, "targetname" );
    }

    return var_0;
}

change_lane_too_close()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );
    self endon( "vehicle_crash" );
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0.2;

    for (;;)
    {
        foreach ( var_2 in level.script_cars )
        {
            if ( !isdefined( var_2 ) )
                continue;

            var_3 = var_2 vehicle_getspeed();

            if ( var_3 < 1 )
                continue;

            var_4 = anglestoforward( var_2.angles );
            var_5 = anglestoforward( self.vehicle.angles );
            var_6 = self.vehicle.origin - var_2.origin;
            var_7 = vectornormalize( var_6 );

            if ( vectordot( var_4, var_5 ) > 0.87 && vectordot( var_4, var_7 ) > 0.87 )
            {
                var_8 = self.traffic_speed;

                if ( isdefined( self.traffic_old_speed ) )
                    var_8 = self.traffic_old_speed;

                var_3 = mph_to_model_speed( var_3 );
                var_9 = var_2 vehicle_getcurrentnode_a();

                if ( isdefined( var_9 ) )
                {
                    var_10 = var_9.speed;
                    var_3 = max( var_3, var_10 );
                }

                var_11 = var_3 - var_8;
                var_12 = squared( var_11 * 4 );
                var_13 = distance2dsquared( self.vehicle.origin, var_2 get_adjusted_script_car_origin( 1 ) );

                if ( ( var_11 > 0 || var_11 > -80 && var_13 < level.traffic_tune_min_stop_dist_sq ) && var_13 < var_12 )
                {
                    var_14 = anglestoright( var_2.angles );
                    var_15 = vectordot( var_14, var_6 );
                    var_16 = self.vehicle vehicle_getcurrentnode_a();

                    if ( isdefined( var_16 ) && isdefined( var_16.lane_start_node.do_pathbased_avoidance ) && var_16.lane_start_node.do_pathbased_avoidance && isdefined( var_9 ) )
                    {
                        var_17 = 0;
                        var_18 = sqrt( var_13 );
                        var_19 = sqrt( var_12 );
                        var_20 = 1;
                        var_21 = get_path_segment_array( var_16, var_19 - var_18, var_20 );
                        var_22 = get_path_segment_array( var_9, var_19 );
                        var_23 = 0;
                        var_24 = undefined;
                        var_25 = undefined;
                        var_26 = undefined;
                        var_27 = undefined;
                        var_28 = undefined;
                        var_29 = undefined;
                        var_30 = undefined;
                        var_31 = undefined;
                        var_32 = 0;
                        var_33 = var_22.size == 1;

                        foreach ( var_35 in var_21 )
                        {
                            var_36 = 0;

                            if ( var_20 && var_21[0] == var_35 )
                                var_36 = 1;

                            foreach ( var_38 in var_22 )
                            {
                                var_32++;
                                [var_40, var_41, var_42, var_43, var_44, var_45, var_46, var_47] = get_closest_point_from_segment_to_segment_n( var_35, var_38, var_33, var_36 );

                                if ( var_43 )
                                {
                                    var_48 = distance2dsquared( self.vehicle.origin, var_41 );

                                    if ( var_48 > var_23 )
                                    {
                                        var_24 = var_40;
                                        var_25 = var_41;
                                        var_26 = var_42;
                                        var_27 = var_43;
                                        var_28 = var_44;
                                        var_30 = var_46;
                                        var_29 = var_45;
                                        var_31 = var_47;
                                        var_23 = var_48;
                                        var_17 = var_32;
                                    }
                                }
                            }
                        }

                        if ( var_17 != 0 )
                        {
                            var_51 = [];
                            var_52 = get_c_right_dist_2d( var_25, var_26, var_28, var_29, var_30, var_31 );
                            var_53 = 0;
                            var_54 = 0;

                            if ( var_52 > -35 && isdefined( get_neighbor_node( "right" ) ) && is_neighboring_lane_clear( "right", 1 ) )
                                var_53 = 1;

                            if ( var_52 < 35 && isdefined( get_neighbor_node( "left" ) ) && is_neighboring_lane_clear( "left", 1 ) )
                                var_54 = 1;

                            if ( var_53 && var_54 )
                            {
                                if ( !isdefined( var_2.script_car_on_right ) )
                                    var_51[var_51.size] = "right";

                                if ( !isdefined( var_2.script_car_on_left ) )
                                    var_51[var_51.size] = "left";

                                if ( isdefined( var_2.script_car_on_right ) && isdefined( var_2.script_car_on_left ) )
                                {
                                    var_55 = get_farthest_car( [ var_2, var_2.script_car_on_right, var_2.script_car_on_left ] );

                                    if ( var_55 == var_2.script_car_on_right )
                                        var_51[var_51.size] = "right";
                                    else if ( var_55 == var_2.script_car_on_left )
                                        var_51[var_51.size] = "left";
                                }
                            }
                            else if ( var_53 )
                            {
                                if ( !isdefined( var_2.script_car_on_right ) )
                                    var_51[var_51.size] = "right";
                            }
                            else if ( var_54 )
                            {
                                if ( !isdefined( var_2.script_car_on_left ) )
                                    var_51[var_51.size] = "left";
                            }
                            else
                                var_56 = 0;

                            if ( var_51.size > 0 )
                            {
                                var_57 = randomint( var_51.size );
                                self notify( "change_lane", var_51[var_57], var_2 );
                                return;
                            }
                            else
                            {
                                self.traffic_change_lane++;

                                if ( var_13 < level.traffic_tune_min_stop_dist_sq )
                                    thread set_traffic_change_speedup( 1, var_3 * 1.05 );
                                else
                                    thread set_traffic_change_speedup( 1 );
                            }
                        }
                    }
                    else
                    {
                        var_58 = undefined;

                        if ( var_15 > -25 && var_15 < 25 )
                        {
                            if ( isdefined( get_neighbor_node( "left" ) ) )
                                var_58 = "right";
                            else if ( isdefined( get_neighbor_node( "left" ) ) )
                                var_58 = "left";
                        }
                        else if ( isdefined( get_neighbor_node( "left" ) ) && var_15 < -25 )
                            var_58 = "left";
                        else if ( isdefined( get_neighbor_node( "left" ) ) && var_15 > 25 )
                            var_58 = "right";

                        if ( isdefined( var_58 ) )
                        {
                            self notify( "change_lane", var_58, var_2 );
                            return;
                        }
                    }
                }
            }
        }

        wait(var_0);
    }
}

get_farthest_car( var_0 )
{
    var_1 = -999;
    var_2 = undefined;

    foreach ( var_4 in var_0 )
    {
        var_5 = distance2dsquared( var_4.origin, self.vehicle.origin );

        if ( var_5 > var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2;
}

get_closest_point_from_segment_to_segment_n( var_0, var_1, var_2, var_3 )
{
    var_4 = 110;
    var_5 = ( 1, 1, 1 );
    var_6 = 500;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    var_11 = undefined;
    var_12 = undefined;

    if ( isdefined( var_0.target ) )
        var_7 = getvehiclenode( var_0.target, "targetname" );
    else
        return [ 0, ( 0, 0, 0 ), ( 0, 0, 0 ), 0 ];

    if ( isdefined( var_3 ) && var_3 )
    {
        var_13 = var_7.origin - var_0.origin;
        var_13 = vectornormalize( var_13 );
        var_14 = vectordot( self.vehicle.origin - var_0.origin, var_13 );
        var_8 = var_0.origin + var_14 * var_13;
        var_9 = var_0.targetname + "car_projected";
    }
    else
    {
        var_8 = var_0.origin;
        var_9 = var_0.targetname;
    }

    if ( isdefined( var_1.target ) )
    {
        var_10 = getvehiclenode( var_1.target, "targetname" );
        var_11 = var_10.origin;
        var_12 = var_10.targetname;
    }
    else
    {
        var_15 = getvehiclenode( var_1.targetname, "target" );

        if ( isdefined( var_15 ) && isdefined( var_2 ) && var_2 )
        {
            var_13 = var_1.origin - var_15.origin;
            var_13 = vectornormalize( var_13 );
            var_11 = var_1.origin + var_13 * var_6;
            var_12 = var_1.targetname + "Extend";
        }
        else
            return [ 0, ( 0, 0, 0 ), ( 0, 0, 0 ), 0 ];
    }

    [var_17, var_18, var_19] = get_closest_point_from_segment_to_segment( var_8, var_7.origin, var_1.origin, var_11 );
    var_20 = var_8;
    var_21 = var_7.origin;
    var_22 = var_1.origin;
    var_23 = var_11;
    var_24 = var_17 < var_4 * var_4;
    return [ var_17, var_18, var_19, var_24, var_20, var_21, var_22, var_22 ];
}

get_neighbor_node_of_target( var_0 )
{
    return get_neighbor_node( var_0, 1 );
}

get_neighbor_node( var_0, var_1 )
{
    if ( self.vehicle.classname == "script_model" )
        var_2 = self.currentnode;
    else
    {
        var_3 = vehicle_getcurrentnode_a();

        if ( isdefined( var_1 ) && var_1 )
        {
            if ( !isdefined( var_3.target ) )
                return undefined;

            var_2 = getvehiclenode( var_3.target, "targetname" );
        }
        else
            var_2 = var_3;
    }

    if ( !isdefined( var_0 ) )
        return undefined;

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( var_0 == "right" || var_0 == "r" )
        return var_2.neighbor_right;
    else if ( var_0 == "left" || var_0 == "l" )
        return var_2.neighbor_left;

    return undefined;
}

is_neighboring_lane_clear( var_0, var_1 )
{
    var_2 = 1;
    var_3 = 0;
    var_4 = get_neighbor_node( var_0 );
    var_5 = find_closest_car( var_4, self.vehicle.origin );

    if ( isdefined( var_5 ) && var_5 != self )
    {
        var_6 = distance2dsquared( var_5.vehicle.origin, self.vehicle.origin );

        if ( var_6 < 65536 )
            var_2 = 0;
        else
            var_2 = 1;
    }

    if ( isdefined( var_1 ) && var_1 )
    {
        var_7 = undefined;
        var_0 = tolower( getsubstr( var_0, 0, 1 ) );

        if ( var_0 == "r" )
            var_7 = anglestoright( self.vehicle.angles );
        else
            var_7 = -1 * anglestoright( self.vehicle.angles );

        var_8 = self.vehicle.origin + ( 0, 0, 25 ) + var_7 * 40;

        for ( var_9 = 0; var_9 < 3; var_9++ )
        {
            var_10 = undefined;

            if ( var_9 == 0 )
                var_10 = var_7 * 150;

            if ( var_9 == 1 )
                var_10 = ( var_7 + -1 * anglestoforward( self.vehicle.angles ) ) * 150;

            if ( var_9 == 2 )
                var_10 = ( var_7 + anglestoforward( self.vehicle.angles ) * 2 ) * 0.5 * 180;

            var_3 = bullettracepassed( var_8, var_8 + var_10, 0, self.vehicle );

            if ( !var_3 )
                break;
        }
    }
    else
        var_3 = 1;

    return var_3 && var_2;
}

change_lane( var_0, var_1 )
{
    self endon( "death" );
    var_2 = get_neighbor_node( var_0 );

    if ( !isdefined( var_2 ) )
        return;

    var_3 = 0;
    var_4 = 5;
    var_5 = 0;
    var_6 = 0.0871558;

    while ( var_4 > 0 )
    {
        var_3 = 1;
        var_7 = anglestoright( self.vehicle.angles );

        if ( var_0 == "left" )
            var_7 *= -1;

        var_2 = is_neighboring_lane_clear( var_0 );

        if ( isdefined( var_2 ) )
            var_3 = 0;
        else
            var_8 = 0;

        if ( var_3 )
        {
            foreach ( var_10 in level.script_cars )
            {
                if ( !isdefined( var_10 ) )
                    continue;

                var_11 = var_10.origin - self.vehicle.origin;
                var_12 = length2dsquared( var_11 );

                if ( var_12 < 65536 )
                {
                    var_13 = vectornormalize( var_11 );
                    var_14 = vectordot( var_13, var_7 );

                    if ( var_14 > var_6 )
                    {
                        var_3 = 0;
                        break;
                    }
                }
            }
        }

        if ( var_3 )
            break;

        if ( !var_5 )
        {
            var_5 = 1;
            self.traffic_change_lane++;
        }

        var_4 -= 0.05;
        wait 0.05;
    }

    if ( var_5 )
        self.traffic_change_lane--;

    if ( var_3 )
    {
        var_2 = get_neighbor_node( var_0 );

        if ( isdefined( var_2 ) )
        {
            var_16 = 1500;

            if ( islagostraversesetting( self.vehicle ) && self.vehicle.code_classname == "script_vehicle" )
            {
                if ( !isdefined( level.traffic_tune_lane_change_angle ) )
                    level.traffic_tune_lane_change_cosangle = cos( 30 );

                var_17 = anglestoright( self.vehicle.angles );
                var_18 = vectornormalize( var_2.origin - self.vehicle.origin );

                if ( abs( vectordot( var_17, var_18 ) ) > level.traffic_tune_lane_change_cosangle )
                    var_2 = getvehiclenode( var_2.target, "targetname" );

                if ( distance2dsquared( self.vehicle.origin, var_2.origin ) > var_16 * var_16 )
                {
                    var_19 = getvehiclenode( var_2.targetname, "target" );

                    if ( isdefined( var_19 ) )
                    {
                        var_20 = get_goal_pos_on_segment( var_2.origin, var_19.origin, self.vehicle.origin, var_16 );
                        self.vehicle vehicledriveto( var_20, self.vehicle vehicle_getspeed() );
                    }
                }
            }

            var_21 = undefined;

            if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
                var_21 = self.traffic_leader_pending;
            else
                var_21 = self.traffic_leader;

            var_22 = self.traffic_follower;
            insert_to_lane( var_2, undefined, "CHANGELANE" );
            self.vehicle thread traffic_drive_vehicle( var_2 );
            var_22.traffic_leader = var_21;

            if ( islagostraversesetting( self.vehicle ) && isdefined( var_1 ) )
            {
                var_23 = mph_to_model_speed( var_1 vehicle_getspeed_a() );
                var_24 = var_1 vehicle_getcurrentnode_a();

                if ( isdefined( var_24 ) )
                {
                    var_25 = var_24.speed;
                    var_23 = max( var_23, var_25 );
                }

                var_26 = mph_to_model_speed( self.vehicle vehicle_getspeed_a() );
                var_27 = var_1.origin;
                var_28 = distance2d( var_27, self.vehicle.origin );
                var_29 = var_23 - var_26;
                var_30 = var_28 / var_29;

                if ( var_23 > var_26 * 1.5 || var_30 < 1.0 )
                {
                    self.traffic_change_lane++;

                    if ( var_28 < level.traffic_tune_min_stop_dist )
                    {
                        thread set_traffic_change_speedup( 1, var_23 * 1.05 );
                        return;
                    }

                    thread set_traffic_change_speedup( 1 );
                    return;
                    return;
                }

                return;
            }
        }
        else
            var_8 = 0;
    }
}

islagostraversesetting( var_0 )
{
    var_1 = var_0 vehicle_getcurrentnode_a();

    if ( isdefined( var_1 ) && isdefined( var_1.lane_start_node ) && isdefined( var_1.lane_start_node.lagoshack ) )
        return 1;
    else
        return 0;
}

vehicle_getspeed_a()
{
    if ( self.code_classname == "script_vehicle" )
        return self vehicle_getspeed();
    else if ( isdefined( self.vehicle ) )
        return self.vehicle.parent_ent.traffic_speed;
    else
        return 0;
}

set_traffic_change_speedup( var_0, var_1 )
{
    self.traffic_change_lane_speed = var_1;
    self endon( "death" );
    wait(var_0);
    self.traffic_change_lane--;

    if ( self.traffic_change_lane == 0 )
        self.traffic_change_lane_speed = undefined;
}

merge_lane()
{
    var_0 = undefined;
    var_0 = vehicle_getcurrentnode_a();

    if ( !isdefined( var_0 ) )
        return;

    var_1 = self.traffic_follower;
    insert_to_lane( var_0, undefined, "MERGE" );
    self.traffic_pre_merge_follower = var_1;

    if ( is_traffic_ent( var_1 ) && var_1 != self )
        var_1.traffic_leader = self;
}

split_lane()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );

    if ( randomint( 100 ) > 40 )
        return;

    var_0 = undefined;

    if ( self.vehicle.classname == "script_model" )
    {
        var_1 = getvehiclenodearray( self.currentnode.targetname, "target" );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            if ( isdefined( var_1[var_2].script_noteworthy ) && ( var_1[var_2].script_noteworthy == "traffic_lane_split" || var_1[var_2].script_noteworthy == "traffic_lane_exit" ) )
            {
                var_0 = var_1[var_2];
                break;
            }
        }
    }
    else
        var_0 = self.vehicle;

    if ( !isdefined( var_0.script_linkto ) )
        return;

    var_3 = getvehiclenode( var_0.script_linkto, "script_linkname" );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = undefined;

    if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
        var_4 = self.traffic_leader_pending;
    else
        var_4 = self.traffic_leader;

    var_5 = self.traffic_follower;
    insert_to_lane( var_3, undefined, "SPLIT" );
    split_lane_extra_handling( var_4, var_5 );
    self.vehicle thread traffic_drive_vehicle( var_3 );
}

split_lane_extra_handling( var_0, var_1 )
{
    if ( level.template_script != "lagos" )
        return;

    if ( is_traffic_ent( var_1 ) )
    {
        var_1.traffic_leader = self;

        if ( isdefined( self.traffic_leader_pending ) )
            var_1.traffic_leader_pending = self.traffic_leader_pending;
        else
            var_1.traffic_leader_pending = var_0;

        var_1.traffic_leader_pending_check = 1;
    }

    if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
    {
        self.traffic_leader_pending_check = undefined;
        self.traffic_leader_pending = undefined;
    }
}

dodge_behavior()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );

    if ( isdefined( self.crashed ) )
        return;

    self endon( "vehicle_crash" );
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0.05;

    for (;;)
    {
        if ( islagostraversesetting( self.vehicle ) && self.traffic_change_lane > 0 )
        {
            wait(var_0);
            continue;
        }

        if ( self.vehicle.classname == "script_model" )
        {
            self waittill( "swap_to_real_vehicle" );
            continue;
        }

        [var_2, var_3] = decide_to_dodge();

        if ( isdefined( var_2 ) )
        {
            self.dodging = 1;
            var_4 = update_dodge( var_2, var_3, 2.5 );
            self.dodging = undefined;

            if ( distance2dsquared( self.vehicle.origin, level.player.origin ) > 342225 || self.vehicle vehicle_getspeed() > 0 )
                resume_driving_from_dodge( var_4 );
            else
                thread do_crash();
        }

        wait(var_0);
    }
}

do_crash()
{
    var_0 = vehicle_getcurrentnode_a();

    if ( isdefined( var_0.no_crash_handling ) && var_0.no_crash_handling )
        return;

    self notify( "vehicle_crash" );

    if ( isdefined( self.vehicle ) )
        self.vehicle notify( "vehicle_crash" );
}

startpath_with_currentnode_update( var_0 )
{
    var_1 = get_closest_node_in_front_of_given_car( var_0, self );
    thread maps\_vehicle::vehicle_paths( var_1 );
    self startpath( var_1 );
}

get_closest_node_in_front_of_given_car( var_0, var_1 )
{
    var_2 = var_0;
    var_3 = 1409865409;
    var_4 = var_0;

    for (;;)
    {
        if ( !isdefined( var_2 ) )
            break;

        if ( !isdefined( var_2.target ) )
            break;

        var_5 = distance2dsquared( var_2.origin, var_1.origin );

        if ( var_5 < var_3 && !vehicle_in_front_of_node( var_1, var_2 ) )
        {
            var_3 = var_5;
            var_4 = var_2;
        }

        var_2 = getvehiclenode( var_2.target, "targetname" );

        if ( !isdefined( var_2 ) )
            break;
    }

    return var_4;
}

get_node_at_radius_distance( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0;
    var_5 = undefined;

    for (;;)
    {
        if ( !isdefined( var_4 ) )
            break;

        if ( !isdefined( var_4.target ) )
            break;

        var_6 = distancesquared( var_1, var_4.origin );

        if ( var_6 < var_2 )
        {
            if ( !isdefined( var_4.nospawn ) )
            {
                var_5 = var_4;
                break;
            }
        }

        var_4 = getvehiclenode( var_4.target, "targetname" );

        if ( !isdefined( var_4 ) )
            break;
    }

    if ( !var_3 )
    {
        var_5 = undefined;
        var_7 = var_4;

        for (;;)
        {
            if ( !isdefined( var_4 ) )
                break;

            if ( !isdefined( var_4.target ) )
                break;

            var_6 = distancesquared( var_1, var_4.origin );

            if ( var_6 > var_2 && !isdefined( var_4.nospawn ) )
            {
                var_5 = var_7;
                break;
            }

            var_7 = var_4;
            var_4 = getvehiclenode( var_4.target, "targetname" );

            if ( !isdefined( var_4 ) )
                break;
        }
    }

    return var_5;
}

resume_driving_from_dodge( var_0 )
{
    var_1 = get_neighbor_node( var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( self.vehicle ) && self.vehicle.classname == "script_vehicle" )
            self.vehicle vehicledriveto( var_1.origin, var_1.speed * 0.5 );

        var_2 = undefined;

        if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
            var_2 = self.traffic_leader_pending;
        else
            var_2 = self.traffic_leader;

        var_3 = self.traffic_follower;
        var_4 = insert_to_lane( var_1, undefined, "RESUMEDODGE" );
        self.vehicle thread traffic_drive_vehicle( var_1 );

        if ( var_4 )
        {
            var_3.traffic_leader = var_2;
            return;
        }
    }
    else
    {
        if ( !isdefined( var_1 ) )
            var_1 = vehicle_getcurrentnode_a();

        self.vehicle thread traffic_drive_vehicle( var_1 );
    }
}

update_dodge( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "vehicle_crash" );
    self.vehicle endon( "stop_dodge" );
    var_3 = 0;
    var_4 = undefined;
    var_5 = 0.05;

    if ( level.currentgen )
        var_5 = 0.05;

    if ( self.vehicle.classname == "script_model" )
        return undefined;

    for (;;)
    {
        [var_7, var_8, var_9] = most_threatening_car( 234 );

        if ( isdefined( var_7 ) )
        {
            var_10 = maps\_shg_utility::linear_map_clamp( var_1, 0, 1.8, 5, 3 );

            if ( islagostraversesetting( self.vehicle ) )
                var_10 *= 2;

            var_11 = self.vehicle vehicle_getvelocity();
            var_12 = length( var_11 );
            var_13 = vectornormalize( var_11 );
            var_14 = var_7 get_adjusted_script_car_origin();
            var_15 = [];
            var_16 = "";
            var_17 = undefined;
            var_18 = [];

            foreach ( var_20 in [ -1, 1 ] )
            {
                var_21 = transformmove( ( 0, 0, 0 ), ( 0, var_20 * var_10, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), var_13, ( 0, 0, 0 ) )["origin"];

                if ( var_20 == -1 )
                    var_16 = "R";
                else
                    var_16 = "L";

                if ( !is_neighboring_lane_clear( var_16, 1 ) )
                    continue;

                if ( bullettracepassed( self.vehicle.origin, self.vehicle.origin + var_21 * ( var_12 * 1 ), 0, self.vehicle ) )
                {
                    if ( islagostraversesetting( self.vehicle ) )
                        var_22 = var_12;
                    else
                        var_22 = var_12 + mph_to_model_speed( 5 );

                    if ( var_22 < mph_to_model_speed( 90 ) )
                    {
                        var_15[var_18.size] = var_16 + "a";
                        var_18[var_18.size] = var_21 * var_22;
                    }
                }
                else
                {

                }

                if ( !islagostraversesetting( self.vehicle ) )
                {
                    var_22 = var_12 - mph_to_model_speed( 5 );

                    if ( var_22 > mph_to_model_speed( 10 ) )
                    {
                        var_15[var_18.size] = var_16 + "d";
                        var_18[var_18.size] = var_21 * var_22;
                    }
                }
            }

            var_24 = var_11;
            var_25 = undefined;
            var_26 = -1;
            var_27 = -1;
            var_28 = [];
            var_29 = [];
            var_30 = [];

            foreach ( var_32 in var_18 )
            {
                var_27++;
                [var_34, var_35] = time_and_distance_of_closest_approach( self.vehicle.origin, var_32, var_14, var_7 vehicle_getvelocity(), 0.1, 136.5, 1 );

                if ( var_34 > 1.8 )
                {
                    var_28[var_27] = -1;
                    var_29[var_27] = var_34;
                    var_30[var_27] = var_35;
                    continue;
                }

                var_36 = compute_threat( var_34, var_35 );
                var_28[var_27] = var_36;
                var_29[var_27] = var_34;
                var_30[var_27] = var_35;

                if ( !isdefined( var_25 ) || var_36 < var_25 )
                {
                    var_26 = var_27;
                    var_25 = var_36;
                    var_24 = var_32;
                }
            }

            if ( distance2dsquared( self.vehicle.origin, level.player.origin ) < 38025 && vectordot( var_24, anglestoforward( level.player.angles ) ) < 0 )
                var_24 = ( 0, 0, 0 );

            if ( var_26 > -1 )
            {
                if ( var_15[var_26] == "La" || var_15[var_26] == "Ld" )
                    var_4 = "left";
                else
                    var_4 = "right";
            }

            var_38 = self.vehicle.origin + var_24 * 10;
            self.vehicle vehicledriveto( var_38, model_speed_to_mph( length( var_24 ) ) );
        }
        else if ( var_3 > 0.3 )
            return var_4;

        var_3 += 0.05;
        wait(var_5);
    }

    return var_4;
}

best_dodge_car()
{
    if ( self.vehicle.classname == "script_model" )
        return [ undefined, undefined ];

    [var_1, var_2, var_3] = most_threatening_car( 136.5 );

    if ( isdefined( var_1 ) && var_3 < 136.5 )
        return [ var_1, var_2 ];
    else
        return [ undefined, undefined ];
}

get_adjusted_script_car_origin( var_0 )
{
    if ( self.vehicletype == "civ_domestic_bus_physics" )
    {
        var_1 = self gettagorigin( "tag_wheel_back_left" );
        var_2 = self gettagorigin( "tag_wheel_back_right" );

        if ( isdefined( var_0 ) && var_0 )
        {
            var_1 = self gettagorigin( "tag_wheel_front_left" );
            var_2 = self gettagorigin( "tag_wheel_front_right" );
        }

        var_3 = ( var_1 - var_2 ) * 0.5 + var_2;
        return var_3;
    }
    else
        return self.origin;
}

most_threatening_car( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = self.vehicle.origin;
    var_6 = self.vehicle vehicle_getvelocity();

    foreach ( var_8 in level.script_cars )
    {
        if ( !isdefined( var_8 ) )
            continue;

        var_9 = var_8 get_adjusted_script_car_origin();

        if ( distance2dsquared( var_5, var_9 ) > 60840000 )
            continue;

        [var_11, var_12] = time_and_distance_of_closest_approach( var_5, var_6, var_9, var_8 vehicle_getvelocity(), 0.1, 136.5 );

        if ( var_11 > 1.8 )
            continue;

        if ( isdefined( level.player_pitbull ) && var_8 == level.player_pitbull )
            var_12 *= 0.5;

        if ( var_12 > var_0 )
            continue;

        var_13 = 0;

        if ( islagostraversesetting( self.vehicle ) )
        {
            var_14 = anglestoforward( self.vehicle.angles );
            var_14 = ( var_14[0], var_14[1], 0 );
            var_14 = vectornormalize( var_14 );
            var_15 = var_9 - self.vehicle.origin;
            var_15 = ( var_15[0], var_15[1], 0 );
            var_15 = vectornormalize( var_15 );
            var_16 = vectordot( var_15, var_14 );
            var_13 = 0;

            if ( var_16 < 1 && var_16 > -1 )
                var_13 = acos( var_16 );
        }

        if ( var_13 < 30 )
        {
            var_17 = compute_threat( var_11, var_12 );

            if ( !isdefined( var_1 ) || var_17 > var_4 )
            {
                var_1 = var_8;
                var_2 = var_12;
                var_3 = var_11;
                var_4 = var_17;
            }
        }
    }

    return [ var_1, var_3, var_2 ];
}

compute_threat( var_0, var_1 )
{
    if ( var_1 < 136.6 )
    {
        if ( var_0 <= 0.1 )
            var_2 = 3 - var_1 / 136.5;
        else
            var_2 = 2 - var_0 / 1.8;
    }
    else
        var_2 = 1 / ( var_1 + 1 );

    return var_2;
}

time_and_distance_of_closest_approach( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0.05;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_7 = var_0 - var_2;
    var_8 = var_1 - var_3;
    var_9 = lengthsquared( var_8 );
    var_10 = 2 * vectordot( var_7, var_8 );
    var_11 = lengthsquared( var_7 ) - squared( var_5 );
    var_12 = squared( var_10 ) - 4 * var_9 * var_11;
    var_13 = 0;

    if ( var_12 > 0 && var_9 > 0 )
    {
        var_14 = -0.5 * ( var_10 + common_scripts\utility::sign( var_10 ) * sqrt( var_12 ) );
        var_15 = min( var_14 / var_9, var_11 / var_14 );
    }
    else if ( var_9 > 0 )
        var_15 = var_10 / -2 * var_9;
    else
        var_15 = var_4;

    if ( var_15 < var_4 )
        var_15 = var_4;

    var_16 = distance( var_0 + var_1 * var_15, var_2 + var_3 * var_15 );
    return [ var_15, var_16 ];
}

decide_to_dodge()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 0.05;

    for (;;)
    {
        [var_2, var_3] = best_dodge_car();

        if ( isdefined( var_3 ) )
        {
            if ( level.nextgen )
            {
                if ( var_3 < 2.5 && var_3 > 0.5 )
                    thread high_beam_oncoming();
            }

            return [ var_2, var_3 ];
        }

        wait(var_0);
    }
}

high_beam_oncoming()
{
    self endon( "death" );

    if ( isdefined( self.high_beaming ) && self.high_beaming )
        return;

    var_0 = [ "headlight_left", "headlight_right", "headlight_set" ];
    self.high_beaming = 1;
    traffic_vehicle_lights_on( var_0 );
    wait 0.2;
    traffic_vehicle_lights_off( var_0 );
    wait 0.3;
    traffic_vehicle_lights_on( var_0 );
    wait 0.2;
    traffic_vehicle_lights_off( var_0 );
    wait 0.3;
    self.high_beaming = undefined;
}

telefrag_behavior()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "new_script_car", var_0 );

        if ( distance2dsquared( var_0.origin, self.vehicle.origin ) < 24336 )
            self notify( "reached_end_node" );
    }
}

is_lane_start_node( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    foreach ( var_2 in level.traffic_lanes )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

find_closest_car( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    var_2 = var_0.lane_start_node;
    var_3 = undefined;
    var_4 = 0;

    if ( !isdefined( level.player.assertdisplayed ) )
        level.player.assertdisplayed = 0;

    if ( isdefined( var_2.traffic_tail ) && isdefined( var_2.traffic_tail.traffic_leader ) )
    {
        var_5 = var_2.traffic_tail.traffic_leader;
        var_6 = var_5;
        var_3 = var_5;
        var_7 = distance2dsquared( var_5.vehicle.origin, var_1 );
        var_8 = [];
        var_9 = var_5;

        while ( isdefined( var_5.traffic_leader ) && var_5.traffic_leader != var_6 )
        {
            var_4++;

            if ( isdefined( var_5.traffic_leader_pending_check ) && var_5.traffic_leader_pending_check )
            {
                if ( !isdefined( self.traffic_follower ) || is_traffic_ent( self.traffic_follower ) && self.traffic_follower vehicle_getcurrentnode_a().lane_start_node == var_5.traffic_leader vehicle_getcurrentnode_a() )
                    var_5 = var_5.traffic_leader_pending;
                else
                    var_5 = var_5.traffic_leader;
            }
            else
                var_5 = var_5.traffic_leader;

            if ( !isdefined( var_5 ) )
                break;

            var_10 = distance2dsquared( var_5.vehicle.origin, var_1 );

            if ( var_10 < var_7 )
            {
                var_3 = var_5;
                var_7 = var_10;
            }

            if ( var_5 == self )
                return self;

            if ( var_9 == var_5 )
                break;

            if ( var_4 > 300 )
            {
                if ( !level.player.assertdisplayed )
                    level.player.assertdisplayed = 1;

                break;
            }
        }
    }

    return var_3;
}

insert_to_lane( var_0, var_1, var_2 )
{
    if ( !isdefined( level.player.assertdisplayed_b ) )
        level.player.assertdisplayed_b = 0;

    var_3 = var_0.lane_start_node;

    if ( !isdefined( var_1 ) )
        var_1 = find_closest_car( var_0, self.vehicle.origin );

    if ( !isdefined( var_1 ) )
    {
        remove_and_insert_at_traffic_tail( var_0 );
        return 0;
    }

    if ( var_1 == self )
        return 0;

    var_4 = vectornormalize( anglestoforward( self.vehicle.angles ) );
    var_5 = var_1;
    var_6 = undefined;
    var_7 = 0;

    for (;;)
    {
        var_7++;
        var_8 = vectornormalize( var_5.vehicle.origin - self.vehicle.origin );

        if ( vectordot( var_8, var_4 ) > 0 )
        {
            var_6 = var_5;
            break;
        }

        if ( !isdefined( var_5.traffic_leader ) )
            break;

        var_5 = var_5.traffic_leader;

        if ( var_7 > 300 )
        {
            if ( !level.player.assertdisplayed_b )
                level.player.assertdisplayed_b = 1;

            break;
        }
    }

    if ( isdefined( var_6 ) )
        remove_and_insert_behind_leader( var_6 );
    else
        remove_and_insert_before_leader( var_5 );

    return 1;
}

remove_from_traffic_lane()
{
    var_0 = undefined;

    if ( isdefined( self.traffic_leader ) )
        var_0 = self.traffic_leader;

    var_1 = undefined;

    if ( isdefined( self.traffic_follower ) )
        var_1 = self.traffic_follower;

    var_2 = undefined;

    if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
        var_2 = self.traffic_leader_pending;

    if ( isdefined( var_0 ) )
    {
        if ( var_0.traffic_follower == self )
        {
            var_0.traffic_follower = var_1;

            if ( isdefined( var_1 ) )
                var_1.traffic_leader = var_0;
        }
        else if ( isdefined( var_1 ) )
            var_1.traffic_leader = var_0;
    }

    if ( isdefined( var_2 ) )
    {
        if ( var_2.traffic_follower == self )
            var_2.traffic_follower = var_1;
    }

    foreach ( var_4 in level.traffic_lanes )
    {
        if ( isdefined( var_4.traffic_head_veh ) && var_4.traffic_head_veh == self )
        {
            if ( isdefined( var_1 ) && is_traffic_ent( var_1 ) )
                var_4.traffic_head_veh = var_1;
            else
                var_4.traffic_head_veh = undefined;
        }

        if ( isdefined( var_4.traffic_tail ) && isdefined( var_4.traffic_tail.traffic_leader ) && var_4.traffic_tail.traffic_leader == self )
        {
            if ( isdefined( var_0 ) && is_traffic_ent( var_0 ) )
            {
                var_4.traffic_tail.traffic_leader = var_0;
                continue;
            }

            var_4.traffic_tail.traffic_leader = undefined;
        }
    }

    self.traffic_leader = undefined;
    self.traffic_follower = undefined;
}

remove_and_insert_at_traffic_tail( var_0 )
{
    var_1 = var_0.lane_start_node;
    remove_from_traffic_lane();
    self.traffic_follower = var_1.traffic_tail;
    var_1.traffic_tail.traffic_leader = self;

    if ( !isdefined( var_1.lane_start_node.traffic_head_veh ) )
        var_1.lane_start_node.traffic_head_veh = self;
}

remove_and_insert_behind_leader( var_0 )
{
    if ( var_0 == self )
        return;

    var_1 = 0;

    if ( isdefined( self.traffic_leader_pending_check ) && self.traffic_leader_pending_check )
    {
        if ( isdefined( self.traffic_leader_pending ) && var_0 == self.traffic_leader_pending )
            return;
    }
    else if ( isdefined( self.traffic_leader ) && var_0 == self.traffic_leader )
    {
        if ( isdefined( var_0.traffic_follower ) && var_0.traffic_follower == self )
            return;
        else
            var_1 = 1;
    }

    var_2 = var_0.traffic_follower;

    if ( !var_1 )
        remove_from_traffic_lane();

    var_3 = var_0.traffic_follower;
    self.traffic_leader = var_0;
    var_0.traffic_follower = self;
    self.traffic_follower = var_3;
    var_3.traffic_leader = self;

    if ( is_traffic_ent( var_2 ) && var_2 != var_3 )
        var_2.traffic_leader = self;
}

remove_and_insert_before_leader( var_0 )
{
    if ( var_0 == self )
        return;

    var_1 = var_0 vehicle_getcurrentnode_a().lane_start_node;
    remove_from_traffic_lane();

    if ( !isdefined( var_1.traffic_head_veh ) || !is_traffic_ent( var_0.traffic_leader ) )
        var_1.traffic_head_veh = self;

    var_2 = var_0.traffic_leader;
    self.traffic_follower = var_0;
    var_0.traffic_leader = self;
    self.traffic_leader = var_2;

    if ( isdefined( var_2 ) )
        var_2.traffic_follower = self;
}

wait_to_clean_car( var_0 )
{
    level endon( "stop_traffic" );
    self waittill( "reached_end_node" );
}

clean_up_car( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.birthnode.fill_pos_ent ) )
        thread remove_when_out_of_range( self.birthnode.fill_pos_ent );

    if ( var_0 )
        level.traffic_cars_scriptmodel_only_count++;
    else
        level.traffic_cars++;

    wait_to_clean_car();

    if ( var_0 )
        level.traffic_cars_scriptmodel_only_count--;
    else
        level.traffic_cars--;

    if ( is_traffic_ent( self.traffic_pre_merge_follower ) && isdefined( self.traffic_pre_merge_follower.traffic_leader ) && self.traffic_pre_merge_follower.traffic_leader == self )
        self.traffic_pre_merge_follower.traffic_leader = self.traffic_leader;

    var_1 = self.traffic_leader;
    var_2 = self.traffic_follower;
    remove_from_traffic_lane();

    if ( is_traffic_ent( var_2 ) && !isdefined( var_1 ) )
        var_2.traffic_leader = undefined;

    if ( isdefined( self.vehicle.deathfx_ent ) )
        self.vehicle.deathfx_ent delete();

    self.vehicle delete();
    self delete();
}

remove_when_out_of_range( var_0 )
{
    self endon( "death" );
    var_1 = -1;

    if ( var_0 != level.player )
        var_0 = level.player;

    waitframe();

    for (;;)
    {
        var_2 = self.vehicle.origin - var_0.origin;

        if ( get_despawn_despawn_if_not_in_view( vehicle_getcurrentnode_a().lane_start_node ) )
        {
            var_3 = anglestoforward( var_0 getangles() );
            var_1 = vectordot( var_2, var_3 );
        }

        if ( var_1 < 0 )
        {
            if ( length2dsquared( var_2 ) > get_despawn_dist_sq( vehicle_getcurrentnode_a().lane_start_node ) )
                break;
        }

        wait 0.2;
    }

    self notify( "reached_end_node" );
}

get_despawn_despawn_if_not_in_view( var_0 )
{
    var_1 = 0;

    if ( isdefined( var_0.despawn_if_not_in_view ) )
        var_1 = var_0.despawn_if_not_in_view;

    return var_1;
}

get_despawn_dist_sq( var_0 )
{
    var_1 = 100000000;

    if ( isdefined( var_0.despawn_dist_sq ) )
        var_1 = var_0.despawn_dist_sq;

    return var_1;
}

clean_up_on_parent_death( var_0 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        var_0 waittill( "death" );

    if ( isdefined( self.deathfx_ent ) )
        self.deathfx_ent delete();

    self delete();
}

handle_traffic_collisions()
{
    self endon( "death" );
    self endon( "reached_end_node" );
    level endon( "stop_traffic" );

    for (;;)
    {
        self waittill( "veh_contact", var_0, var_1, var_2, var_3, var_4 );

        if ( isdefined( self.last_traffic_hit_time ) && self.last_traffic_hit_time == gettime() )
        {
            if ( self.last_traffic_hit_pos == var_1 )
                continue;
        }

        var_5 = 0;

        if ( isdefined( var_0 ) )
        {
            var_5 = 1;

            if ( isdefined( var_0.last_traffic_hit_time ) && var_0.last_traffic_hit_time == gettime() )
            {
                if ( var_0.last_traffic_hit_pos == var_1 )
                    var_5 = 0;
            }
        }

        self.last_traffic_hit_time = gettime();
        self.last_traffic_hit_pos = var_1;

        if ( isdefined( var_0 ) )
        {
            var_0.last_traffic_hit_time = gettime();
            var_0.last_traffic_hit_pos = var_1;
        }

        self notify( "vehicle_damage_destruct_parts_if_available", var_1, var_2 );

        if ( var_5 )
            var_0 notify( "vehicle_damage_destruct_parts_if_available", var_1, var_2 );

        if ( crash_is_fatal( var_3 ) )
        {
            self notify( "vehicle_crash" );

            if ( isdefined( self.parent_ent ) )
                self.parent_ent notify( "vehicle_crash" );
        }

        if ( var_5 )
        {
            if ( var_0 crash_is_fatal( var_3 * -1 ) )
            {
                var_0 notify( "vehicle_crash" );

                if ( isdefined( var_0.parent_ent ) )
                    var_0.parent_ent notify( "vehicle_crash" );
            }
        }

        if ( isdefined( level.traffic_collision_fx_func ) )
            level thread [[ level.traffic_collision_fx_func ]]( self, var_0, var_1, var_2, var_3, var_4 );

        var_6 = [];
        var_6["vehicle"] = self;
        var_6["hit_entity"] = var_0;
        var_6["pos"] = var_1;
        var_6["impulse"] = var_2;
        var_6["relativeVel"] = var_3;
        var_6["surface"] = var_4;

        if ( isdefined( var_0 ) && !isdefined( var_0.audio ) )
            var_0 soundscripts\_snd_common::sndx_vehicle_collision_args_setup( var_6 );

        soundscripts\_snd::snd_message( "play_vehicle_collision", var_6 );
    }
}

crash_is_fatal( var_0 )
{
    var_1 = ( var_0[0], var_0[1], 0 );
    var_2 = length2dsquared( var_1 );

    if ( vectordot( var_0, anglestoforward( self.angles ) ) > 0 )
        return var_2 > 250000;
    else
    {
        var_3 = undefined;
        var_3 = self vehicle_getcurrentnode().lane_start_node;

        if ( isdefined( var_3 ) && isdefined( var_3.vehicle_easy_crash_die ) && var_3.vehicle_easy_crash_die )
            return var_2 > 100;
        else
            return var_2 > 2250000;
    }
}

sync_entity_damage( var_0 )
{
    var_0 hide_damaged_parts();

    if ( isdefined( self.damaged_parts ) )
    {
        foreach ( var_3, var_2 in self.damaged_parts )
        {
            if ( var_2 )
            {
                var_0 hidepart( var_3 );
                var_0 showpart( var_3 + "_D" );
            }
        }
    }
}

setup_vehicle_for_damage()
{
    thread handle_destruct_parts();
    thread handle_crashing();
    thread monitor_life();
}

monitor_script_model_damage()
{
    var_0 = undefined;
    var_1 = undefined;
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    maps\_vehicle_code::vehicle_life();

    for ( self.currenthealth = self.health; self.currenthealth > 0; self.currenthealth -= var_2 )
        self waittill( "damage", var_2, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0 );

    set_zero_speed( self.parent_ent.currentnode );
    thread maps\_vehicle_code::vehicle_kill_common( var_1, undefined );
}

monitor_life()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    var_0 = get_destruct_parts();

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in var_2 )
        {
            self hidepart( var_4 );
            self showpart( var_4 + "_D" );

            if ( isdefined( self.parent_ent ) )
            {
                if ( !isdefined( self.parent_ent.damaged_parts ) )
                    self.parent_ent.damaged_parts = [];

                self.parent_ent.damaged_parts[var_4] = 1;
            }
        }
    }
}

get_destruct_parts()
{
    var_0 = undefined;

    if ( isdefined( self ) && isdefined( self.model ) )
    {
        if ( self.model == "vehicle_paris_escape_sedan" || self.model == "vehicle_sedan_destruct_test" )
        {
            var_0 = [];
            var_0["front"] = [ "hitB", "TAG_GLASS_FRONT" ];
            var_0["left"] = [ "TAG_GLASS_LEFT_FRONT", "TAG_GLASS_LEFT_BACK", "wheel_A_KL", "wheel_A_FL", "doorC_FL", "doorC_KL" ];
            var_0["right"] = [ "TAG_GLASS_RIGHT_FRONT", "TAG_GLASS_RIGHT_BACK", "wheel_A_KR", "wheel_A_FR", "doorC_FR", "doorC_KR" ];
            var_0["back"] = [ "hitA", "trunk", "TAG_GLASS_BACK" ];
            var_0["top"] = [ "hitD", "TAG_GLASS_ROOF" ];
            var_0["bottom"] = [ "hitC" ];
        }
    }

    return var_0;
}

hide_damaged_parts()
{
    var_0 = get_destruct_parts();

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            foreach ( var_4 in var_2 )
                self hidepart( var_4 + "_D" );
        }
    }
}

handle_destruct_parts()
{
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    self endon( "death" );
    var_0 = get_destruct_parts();

    if ( !isdefined( var_0 ) )
        return;

    var_1 = cos( 35 );
    var_2 = cos( 60 );

    for (;;)
    {
        self waittill( "vehicle_damage_destruct_parts_if_available", var_3, var_4 );
        var_5 = var_3 - self.origin;
        var_5 = vectornormalize( var_5 );
        var_6 = anglestoforward( self.angles );
        var_7 = anglestoright( self.angles );
        var_8 = anglestoup( self.angles );
        var_9 = vectordot( var_8, var_5 );

        if ( var_9 > 0.707 )
            damage_part_area( "top", var_0 );
        else if ( var_9 < -0.707 )
            damage_part_area( "bottom", var_0 );

        var_10 = vectordot( var_6, var_5 );

        if ( var_10 > var_1 )
            damage_part_area( "front", var_0 );
        else if ( var_10 < var_1 * -1 )
            damage_part_area( "back", var_0 );

        var_11 = vectordot( var_7, var_5 );

        if ( var_11 > var_2 )
        {
            damage_part_area( "right", var_0 );
            continue;
        }

        if ( var_11 < var_2 * -1 )
            damage_part_area( "left", var_0 );
    }
}

damage_part_area( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || !isdefined( var_1[var_0] ) )
        return;

    var_2 = var_1[var_0];

    foreach ( var_4 in var_2 )
    {
        self hidepart( var_4 );
        self showpart( var_4 + "_D" );

        if ( isdefined( self.parent_ent ) )
        {
            if ( !isdefined( self.parent_ent.damaged_parts ) )
                self.parent_ent.damaged_parts = [];

            if ( !isdefined( self.parent_ent.damaged_parts[var_4] ) || !self.parent_ent.damaged_parts[var_4] )
            {
                self.parent_ent.damaged_parts[var_4] = 1;
                level notify( "vehicle_part_damage", self, var_4 );
            }
        }
    }
}

handle_crashing()
{
    level endon( "stop_traffic" );
    self endon( "reached_end_node" );
    self endon( "death" );

    if ( isdefined( self.parent_ent.crashed ) )
        return;

    for (;;)
    {
        self waittill( "vehicle_crash" );

        if ( !isdefined( self.parent_ent.crashed ) )
        {
            self.parent_ent.crashed = 1;
            var_0 = get_crashed_vehicle_index();
            level.traffic_crashed_vehicles[var_0] = self;
            self vehicledriveto( self.origin + anglestoright( self.angles ) * 10000 + anglestoforward( self.angles ) * 10000, 0 );
            self vehicle_setspeed( 0, 25, 25 );
            self.parent_ent thread safe_vehicle_delete();
            wait 0.2;
            self vehphys_crash( 0 );
            return;
        }
    }
}

get_crashed_vehicle_index()
{
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;

    if ( level.traffic_crashed_vehicles.size < 10 )
        return level.traffic_crashed_vehicles.size;
    else
    {
        for ( var_3 = 0; var_3 < level.traffic_crashed_vehicles.size; var_3++ )
        {
            if ( !isdefined( level.traffic_crashed_vehicles[var_3] ) )
                return var_3;

            var_4 = distance2dsquared( level.traffic_crashed_vehicles[var_3].origin, level.player.origin );

            if ( !isdefined( var_0 ) || var_0 < var_4 )
            {
                var_0 = var_4;
                var_1 = level.traffic_crashed_vehicles[var_3];
                var_2 = var_3;
            }
        }
    }

    var_1.parent_ent notify( "reached_end_node" );
    return var_2;
}

safe_vehicle_delete()
{
    level endon( "stop_traffic" );
    self endon( "death" );
    self endon( "reached_end_node" );

    for (;;)
    {
        wait 0.05;

        if ( !isdefined( self ) || !isdefined( self.vehicle ) )
            return;

        if ( !player_can_see_vehicle() )
            break;
    }

    self notify( "reached_end_node" );
}

force_vehicle_delete()
{
    var_0 = self.parent_ent;

    if ( var_0 player_can_see_vehicle() )
    {
        self dodamage( 1000000000, self.origin );
        wait 0.3;
    }

    var_0 notify( "reached_end_node" );
}

player_can_see_vehicle()
{
    return maps\_utility::players_within_distance( 512, self.vehicle.origin ) || maps\_utility::either_player_looking_at( self.vehicle.origin + ( 0, 0, 48 ), 0.5, 1 );
}

should_be_vehicle( var_0, var_1 )
{
    var_2 = vectornormalize( var_0 - level.player.origin );
    var_3 = vectornormalize( anglestoforward( level.player getangles() ) );
    var_4 = 0;

    if ( vectordot( var_2, var_3 ) < 0 )
    {
        var_5 = 1048576;
        var_4 = 16384;
    }
    else
    {
        var_5 = 16777216;
        var_4 = 262144;
    }

    if ( isdefined( var_1 ) && var_1 != "script_model" )
        var_5 += var_4;

    if ( distance2dsquared( var_0, level.player.origin ) < var_5 )
        return 1;

    var_5 = 1048576;

    if ( isdefined( var_1 ) && var_1 != "script_model" )
        var_5 += var_4;

    foreach ( var_7 in level.script_cars )
    {
        if ( isdefined( var_7 ) && distance2dsquared( var_0, var_7.origin ) < var_5 )
            return 1;
    }

    return 0;
}

model_speed_to_mph( var_0 )
{
    return var_0 / 63360.0 * 60.0 * 60.0;
}

mph_to_model_speed( var_0 )
{
    return var_0 * 63360.0 / 60.0 / 60.0;
}

too_close_to_leader( var_0 )
{
    var_1 = level.traffic_tune_min_follow_dist_sq;

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    if ( isdefined( self.traffic_leader ) )
    {
        if ( distance2dsquared( self.vehicle.origin, self.traffic_leader.vehicle.origin ) < var_1 )
            return 1;
    }

    return 0;
}

far_enough_from_leader( var_0 )
{
    var_1 = level.traffic_tune_min_follow_dist_sq * 1.1;

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    if ( isdefined( self.traffic_leader ) )
    {
        if ( distance2dsquared( self.vehicle.origin, self.traffic_leader.vehicle.origin ) > var_1 )
            return 1;
    }
    else
        return 0;

    return 0;
}

adjust_model_speed_to_node( var_0 )
{
    if ( isdefined( self.parent_ent.traffic_old_speed ) )
        self.parent_ent.traffic_old_speed = var_0.speed;
    else
        self.parent_ent.traffic_speed = var_0.speed;
}

traffic_vehicle_lights_on( var_0 )
{
    if ( self.vehicle.classname == "script_model" )
        return;

    foreach ( var_2 in var_0 )
        self.vehicle maps\_vehicle::vehicle_single_light_on( var_2 );
}

traffic_vehicle_lights_off( var_0 )
{
    if ( self.vehicle.classname == "script_model" )
        return;

    foreach ( var_2 in var_0 )
        self.vehicle maps\_vehicle::vehicle_single_light_off( var_2 );
}

handle_wakeup_sphere_global()
{
    level.player endon( "death" );
    var_0 = squared( 3900 );
    var_1 = cos( 60 );
    var_2 = 195;
    var_3 = 10;

    for (;;)
    {
        var_4 = 0;

        foreach ( var_6 in sortbydistance( vehicle_getarray(), level.player.origin ) )
        {
            if ( isdefined( self.no_wakeup_physics_sphere ) )
                continue;

            var_7 = var_6.origin - level.player.origin;

            if ( length2dsquared( var_7 ) > var_0 )
                break;

            if ( vectordot( anglestoforward( level.player getgunangles() ), vectornormalize( var_7 ) ) > var_1 )
            {
                var_4++;
                wakeupphysicssphere( var_6.origin, var_2 );
            }

            if ( var_4 >= var_3 )
                break;
        }

        waitframe();
    }
}

detect_dropping()
{
    self endon( "death" );
    self endon( "reached_end_node" );

    for (;;)
    {
        var_0 = self.origin[2];
        wait 1;

        if ( var_0 - self.origin[2] > 2000 )
        {
            self notify( "reached_end_node" );
            return;
        }
    }
}

detect_being_pushed( var_0 )
{
    var_1 = 2;
    var_2 = self vehicle_getcurrentnode().lane_start_node;

    if ( isdefined( var_2 ) && isdefined( var_2.vehicle_easy_crash_die ) && var_2.vehicle_easy_crash_die )
        var_1 = 0.6;

    var_3 = 0;
    waitframe();
    var_4 = 0.05;

    if ( level.currentgen )
        var_4 = 0.2;

    while ( isdefined( self ) )
    {
        var_5 = self vehicle_getspeed() > 5 && ( !any_wheel_on_ground() || some_wheels_slipping() );

        if ( var_5 )
            var_3 += 0.05;
        else
            var_3 -= 0.1;

        if ( self vehicle_getvelocity()[2] > 700 )
            var_3 += 3.0;

        var_3 = max( var_3, 0 );

        if ( var_3 > var_1 )
        {
            self [[ var_0 ]]();
            return;
        }

        wait(var_4);
    }
}

some_wheels_slipping()
{
    var_0 = 0;

    foreach ( var_2 in [ "front_left", "front_right", "back_left", "back_right" ] )
    {
        if ( self iswheelslipping( var_2 ) )
            var_0++;
    }

    return var_0 >= 3;
}

any_wheel_on_ground()
{
    foreach ( var_1 in [ "front_left", "front_right", "back_left", "back_right" ] )
    {
        if ( self getwheelsurface( var_1 ) != "none" )
            return 1;
    }

    return 0;
}

is_inside_radius_of_closest_point_of_segment( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_0.target ) )
        var_3 = getvehiclenode( var_0.target, "targetname" );
    else
        var_3 = var_0;

    if ( distance2dsquared( var_0.origin, var_1 ) < var_2 )
        return 1;

    if ( distance2dsquared( var_3.origin, var_1 ) < var_2 )
        return 1;

    [var_5, var_6, var_7] = get_closest_point_from_segment_to_segment( var_0.origin, var_3.origin, var_1, var_1 );
    var_8 = var_5 < var_2;
    return var_8;
}

get_goal_pos_on_segment( var_0, var_1, var_2, var_3 )
{
    var_4 = var_2;
    var_5 = var_4 - var_0;
    var_6 = var_1 - var_0;
    var_7 = vectornormalize( var_6 );
    var_8 = vectordot( var_5, var_7 );
    var_9 = var_7 * var_8;
    var_10 = var_9 + var_7 * var_3;
    return var_10;
}

get_closest_point_from_segment_to_segment( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.001;
    var_5 = var_1 - var_0;
    var_6 = var_3 - var_2;
    var_7 = var_0 - var_2;
    var_8 = vectordot( var_5, var_5 );
    var_9 = vectordot( var_6, var_6 );
    var_10 = vectordot( var_6, var_7 );
    var_11 = 0;

    if ( var_8 <= var_4 && var_9 <= var_4 )
    {
        var_12 = 0;
        var_13 = 0;
        var_14 = var_0;
        var_15 = var_2;
        return [ vectordot( var_14 - var_15, var_14 - var_15 ), var_14, var_15 ];
    }

    if ( var_8 <= var_4 )
    {
        var_12 = 0;
        var_13 = var_10 / var_9;
        var_13 = clamp( var_13, 0, 1 );
    }
    else
    {
        var_16 = vectordot( var_5, var_7 );

        if ( var_9 <= var_4 )
        {
            var_13 = 0;
            var_12 = clamp( -1 * var_16 / var_8, 0, 1 );
        }
        else
        {
            var_17 = vectordot( var_5, var_6 );
            var_18 = var_8 * var_9 - var_17 * var_17;

            if ( var_18 != 0 )
                var_12 = clamp( ( var_17 * var_10 - var_16 * var_9 ) / var_18, 0, 1 );
            else
                var_12 = 0;

            var_13 = ( var_17 * var_12 + var_10 ) / var_9;

            if ( var_13 < 0 )
            {
                var_13 = 0;
                var_12 = clamp( -1 * var_16 / var_8, 0, 1 );
            }
            else if ( var_13 > 1 )
            {
                var_13 = 1;
                var_12 = clamp( ( var_17 - var_16 ) / var_8, 0, 1 );
            }
        }
    }

    var_14 = var_0 + var_5 * var_12;
    var_15 = var_2 + var_6 * var_13;
    return [ vectordot( var_14 - var_15, var_14 - var_15 ), var_14, var_15 ];
}

vectors_are_equal_2d( var_0, var_1 )
{
    var_2 = 0.001;
    var_3 = var_1 - var_0;

    if ( abs( var_3[0] ) < var_2 && abs( var_3[1] ) < var_2 )
        return 1;
    else
        return 0;
}

mark_nodes_near_spawnnodes_and_startnodes( var_0 )
{
    var_1 = 3600;
    var_2 = 25000000;
    var_3 = getvehiclenodearray( var_0, "targetname" );
    var_4 = getentarray( "script_vehicle", "code_classname" );
    var_5 = [];

    foreach ( var_7 in var_4 )
    {
        if ( isdefined( var_7.spawnflags ) && var_7.spawnflags == 2 )
            var_5[var_5.size] = var_7;
    }

    var_9 = getallvehiclenodes();
    var_10 = [];

    foreach ( var_7 in var_9 )
    {
        if ( isdefined( var_7.spawnflags ) && var_7.spawnflags == 1 && var_7.targetname != var_0 )
            var_10[var_10.size] = var_7;
    }

    foreach ( var_14 in var_3 )
    {
        var_15 = var_14;

        for (;;)
        {
            if ( !isdefined( var_14 ) )
                break;

            if ( !isdefined( var_14.target ) )
                break;

            foreach ( var_17 in var_5 )
            {
                if ( distance2dsquared( var_14.origin, var_17.origin ) < var_2 && is_inside_radius_of_closest_point_of_segment( var_14, var_17.origin, var_1 ) )
                {
                    var_14.nospawn = var_17;
                    var_14 = getvehiclenode( var_14.target, "targetname" );
                    var_14.nospawn = var_17;
                    var_15.nospawn = var_17;
                }
            }

            foreach ( var_20 in var_10 )
            {
                if ( distance2dsquared( var_14.origin, var_20.origin ) < var_2 && is_inside_radius_of_closest_point_of_segment( var_14, var_20.origin, var_1 ) )
                {
                    var_14.nospawn = var_20;
                    var_14 = getvehiclenode( var_14.target, "targetname" );
                    var_14.nospawn = var_20;
                    var_15.nospawn = var_20;
                }
            }

            var_15 = var_14;
            var_14 = getvehiclenode( var_14.target, "targetname" );
        }
    }
}

drawnode( var_0 )
{
    self endon( "death" );
}
