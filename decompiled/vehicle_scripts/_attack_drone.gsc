// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

drone_swarm_init()
{
    if ( level.nextgen )
    {
        level.attack_drones_num_drones_per_queen = 24;
        level.attack_drones_num_queens = 6;
        level.attack_drones_nofly_zone_radius = 125;
    }
    else
    {
        level.attack_drones_num_drones_per_queen = 5;
        level.attack_drones_num_queens = 3;
        level.attack_drones_nofly_zone_radius = 125;
    }

    level.swarm_spawned = 0;
    level.drone_turret_fake_death_awesome = 0;
    level.killable_kamikazes = 0;
    level.big_kamikaze_death = 0;
    common_scripts\utility::flag_init( "cloud_in_formation" );

    if ( !isdefined( level.flock_drones ) )
        level.flock_drones = [];

    if ( !isdefined( level.snakes ) )
        level.snakes = [];

    level.expected_drones = level.attack_drones_num_queens * level.attack_drones_num_drones_per_queen;
    level.drones_vs_car_shield = 0;
    level.no_fly_zone = undefined;
    level.smart_drone_think = 0;
    level.drone_test_tag = common_scripts\utility::spawn_tag_origin();
    precacheshellshock( "iw5_attackdronemagicbullet" );
    precacheshellshock( "remote_missile_drone_light" );
    precachemodel( "vehicle_mil_attack_drone_static" );
    precachemodel( "vehicle_mil_attack_drone_destroy" );
    precachemodel( "vehicle_mil_attack_drone_ai" );
    precachemodel( "vehicle_atlas_assault_drone_physics" );
    vehicle_scripts\_attack_drone_common::drone_fx();

    if ( !isdefined( level.boid_settings_presets ) )
        level.boid_settings_presets = [];

    level.boid_settings_presets["default_snake"] = spawnstruct();
    level.boid_settings_presets["default_snake"].queen_deadzone = 0;
    level.boid_settings_presets["default_snake"].queen_curl = 0.5;
    level.boid_settings_presets["default_snake"].neighborhood_radius = 110;
    level.boid_settings_presets["default_snake"].separation_factor = 12000;
    level.boid_settings_presets["default_snake"].alignment_factor = 0.002;
    level.boid_settings_presets["default_snake"].cohesion_factor = 0.00015;
    level.boid_settings_presets["default_snake"].magnet_factor = 10;
    level.boid_settings_presets["default_snake"].random_factor = 250;
    level.boid_settings_presets["default_snake"].max_accel = 3200;
    level.boid_settings_presets["default_snake"].drag_amount = 0.05;
    level.boid_settings_presets["default_snake"].random_drag_amount = 0.2;
    level.boid_settings_presets["default_snake"].queen_relative_speed = 1;
    level.boid_settings_presets["default_snake"].dodge_player_shots = 1;
    level.boid_settings_presets["default_snake"].emp_mode = 0;
    level.boid_settings_presets["frozen_snake"] = spawnstruct();
    level.boid_settings_presets["frozen_snake"].queen_deadzone = 0;
    level.boid_settings_presets["frozen_snake"].queen_curl = 0;
    level.boid_settings_presets["frozen_snake"].neighborhood_radius = 110;
    level.boid_settings_presets["frozen_snake"].separation_factor = 48000;
    level.boid_settings_presets["frozen_snake"].alignment_factor = -0.002;
    level.boid_settings_presets["frozen_snake"].cohesion_factor = 0;
    level.boid_settings_presets["frozen_snake"].magnet_factor = 2.5;
    level.boid_settings_presets["frozen_snake"].random_factor = 100;
    level.boid_settings_presets["frozen_snake"].max_accel = 3200;
    level.boid_settings_presets["frozen_snake"].drag_amount = 0.15;
    level.boid_settings_presets["frozen_snake"].random_drag_amount = 0;
    level.boid_settings_presets["frozen_snake"].queen_relative_speed = 0;
    level.boid_settings_presets["frozen_snake"].min_speed = 0;
    level.boid_settings_presets["frozen_snake"].max_speed = 352.0;
    level.boid_settings_presets["frozen_snake"].dodge_player_shots = 1;
    level.boid_settings_presets["frozen_snake"].emp_mode = 0;
    level.boid_settings_presets["emp_snake"] = spawnstruct();
    level.boid_settings_presets["emp_snake"].queen_deadzone = 0;
    level.boid_settings_presets["emp_snake"].queen_curl = 0;
    level.boid_settings_presets["emp_snake"].neighborhood_radius = 110;
    level.boid_settings_presets["emp_snake"].separation_factor = 48000;
    level.boid_settings_presets["emp_snake"].alignment_factor = 0;
    level.boid_settings_presets["emp_snake"].cohesion_factor = 0;
    level.boid_settings_presets["emp_snake"].magnet_factor = 0.000386;
    level.boid_settings_presets["emp_snake"].random_factor = 150;
    level.boid_settings_presets["emp_snake"].max_accel = 800;
    level.boid_settings_presets["emp_snake"].drag_amount = 0.01;
    level.boid_settings_presets["emp_snake"].random_drag_amount = 0;
    level.boid_settings_presets["emp_snake"].queen_relative_speed = 0;
    level.boid_settings_presets["emp_snake"].min_speed = 0;
    level.boid_settings_presets["emp_snake"].max_speed = 880.0;
    level.boid_settings_presets["emp_snake"].dodge_player_shots = 0;
    level.boid_settings_presets["emp_snake"].emp_mode = 1;
}

spawn_queen_drone_and_drive( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        var_3 = var_1 maps\_utility::spawn_vehicle();
    else
        var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );

    var_3 vehicle_scripts\_attack_drone_common::setup_queen_drone();
    return var_3;
}

monitor_drone_death()
{
    self endon( "death" );

    foreach ( var_1 in self.drones )
    {
        while ( isdefined( var_1 ) )
            wait 0.05;
    }

    self notify( "drones_gone" );
}

flying_attack_drone_move_think()
{
    self endon( "death" );
    self.current_air_space = common_scripts\utility::getclosest( self.origin, level.drone_air_spaces );
    update_flying_attack_drone_goal_pos();
    self waittill( "near_goal" );
    wait 2;

    for (;;)
    {
        var_0 = maps\_utility::get_closest_player_healthy( self.origin );
        self setlookatent( var_0 );
        var_1 = var_0.origin;
        var_2 = common_scripts\utility::getclosest( var_1, level.player_test_points );
        var_3 = getent( var_2.target, "targetname" );

        if ( var_3 != self.current_air_space )
        {
            var_4 = get_next_air_space( self.current_air_space, var_3, level.drone_air_spaces );

            if ( isdefined( var_4 ) )
                self.current_air_space = var_4;
        }

        update_flying_attack_drone_goal_pos();
        self waittill( "near_goal" );

        if ( var_3 == self.current_air_space )
            wait(randomfloatrange( 0.5, 1.5 ));
    }
}

update_flying_attack_drone_goal_pos()
{
    var_0 = self.origin;
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_1.origin = var_0;

    if ( !var_1 istouching( self.current_air_space ) )
        var_0 = get_random_point_in_air_space( self.current_air_space );
    else
    {
        var_2 = 0;
        var_3 = 0;
        var_4 = ( 0, 0, 0 );
        var_5 = 0;
        var_6 = ( 0, 0, 0 );

        foreach ( var_8 in level.flying_attack_drones )
        {
            if ( self != var_8 && isdefined( self.current_air_space ) && isdefined( var_8.current_air_space ) )
            {
                if ( self.current_air_space == var_8.current_air_space )
                {
                    var_2++;
                    var_9 = var_8.origin - self.origin;
                    var_10 = length( var_9 );

                    if ( var_10 < 90 )
                    {
                        var_3++;
                        var_4 -= 0.5 * ( 90 - var_10 ) * var_9 / var_10;
                    }
                    else if ( var_10 > 150 )
                    {
                        var_5++;
                        var_6 += 0.5 * ( var_10 - 150 ) * var_9 / var_10;
                    }
                }
            }
        }

        if ( var_2 > 0 )
        {
            if ( var_3 > 0 )
                var_0 += var_4 / var_3;

            if ( var_5 > 0 )
                var_0 += var_6 / var_5;
        }
        else
            var_0 = get_random_point_in_air_space( self.current_air_space );
    }

    self setvehgoalpos( var_0, 1 );
    var_1 delete();
}

get_random_point_in_air_space( var_0 )
{
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );

    for ( var_1.origin = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ); !var_1 istouching( var_0 ); var_1.origin = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) )
    {

    }

    var_2 = var_1.origin;
    var_1 delete();
    return var_2;
}

flying_attack_drone_damage_monitor()
{
    self endon( "death" );
    self.damagetaken = 0;
    self.istakingdamage = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread flying_attack_drone_damage_update();
    }
}

flying_attack_drone_damage_update()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self.istakingdamage = 1;
    wait 1;
    self.istakingdamage = 0;
}

flying_attack_drone_death_monitor()
{
    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    self waittill( "death" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

get_linked_air_spaces( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    if ( isdefined( var_0.script_linkto ) )
        var_3 = strtok( var_0.script_linkto, " " );

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = 0;

        if ( isdefined( var_1[var_4].script_linkname ) )
        {
            for ( var_6 = 0; var_6 < var_3.size; var_6++ )
            {
                if ( var_1[var_4].script_linkname == var_3[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    var_5 = 1;
                    break;
                }
            }
        }

        if ( !var_5 && isdefined( var_1[var_4].script_linkto ) && isdefined( var_0.script_linkname ) )
        {
            var_7 = strtok( var_1[var_4].script_linkto, " " );

            for ( var_6 = 0; var_6 < var_7.size; var_6++ )
            {
                if ( var_0.script_linkname == var_7[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    break;
                }
            }
        }
    }

    return var_2;
}

get_next_air_space( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    var_4 = [];

    foreach ( var_6 in var_2 )
        var_6.g_score = 0;

    var_0.f_score = var_0.g_score + distance( var_0.origin, var_1.origin );

    while ( var_3.size > 0 )
    {
        var_8 = undefined;
        var_9 = 500000;

        foreach ( var_11 in var_3 )
        {
            if ( var_11.f_score < var_9 )
            {
                var_8 = var_11;
                var_9 = var_11.f_score;
            }
        }

        if ( var_8 == var_1 )
        {
            for ( var_13 = var_1; var_13.came_from != var_0; var_13 = var_13.came_from )
            {

            }

            return var_13;
        }

        var_3 = common_scripts\utility::array_remove( var_3, var_8 );
        var_4[var_4.size] = var_8;
        var_14 = get_linked_air_spaces( var_8, var_2 );

        foreach ( var_11 in var_14 )
        {
            var_16 = var_8.g_score + distance( var_8.origin, var_11.origin );

            if ( common_scripts\utility::array_contains( var_4, var_11 ) && var_16 >= var_11.g_score )
                continue;

            var_17 = common_scripts\utility::array_contains( var_3, var_11 );

            if ( !var_17 || var_16 < var_11.g_score )
            {
                var_11.came_from = var_8;
                var_11.g_score = var_16;
                var_11.f_score = var_11.g_score + distance( var_11.origin, var_1.origin );

                if ( !var_17 )
                    var_3[var_3.size] = var_11;
            }
        }
    }

    return undefined;
}

sortbydistanceauto( var_0, var_1 )
{
    return sortbydistance( var_0, var_1, 0, 1 );
}

kamikaze_new_style( var_0, var_1 )
{
    level endon( "end_kamikaze_newstyle" );
    level endon( "delete_drone_cloud" );

    for (;;)
    {
        var_2 = sortbydistanceauto( level.flock_drones, level.player.origin );
        var_3 = randomint( 5 );

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( !isdefined( var_2[var_4] ) || isdefined( var_2[var_4].attacking_player ) )
                continue;

            var_2[var_4] thread drone_kamikaze_player( var_1, var_0 );
            var_2[var_4].attacking_player = 1;
            wait(randomfloatrange( 0.1, 0.25 ));
        }

        wait 0.5;
    }
}

handle_drones_vs_car_shield( var_0 )
{
    if ( !level.drones_vs_car_shield )
        return;

    level notify( "kill_drone_vs_carshiel_process" );
    level endon( "kill_drone_vs_carshiel_process" );
    level endon( "end_drone_kamikaze_player" );
    level endon( "delete_drone_cloud" );

    for (;;)
    {
        while ( level.flock_drones.size <= 0 )
            wait 0.05;

        var_1 = anglestoforward( level.player getangles() );
        var_2 = level.player geteye() + var_1 * 200;
        var_3 = sortbydistanceauto( level.flock_drones, var_2 );

        if ( var_3.size > 0 )
        {
            var_4 = distance( var_3[0].origin, level.player.origin );

            if ( var_4 <= 1000 )
            {
                var_3[0] thread drone_kamikaze_player( var_0 );
                var_3[0] setmodel( "vehicle_mil_attack_drone_static" );
                wait(randomfloatrange( 1.5, 2.5 ));
            }
            else
                wait 0.25;

            continue;
        }

        wait 0.25;
    }
}

force_kamikaze( var_0, var_1 )
{
    level endon( "delete_drone_cloud" );
    var_2 = get_legal_drone_for_kamikaze();

    if ( !isdefined( var_2 ) )
        return;

    while ( isdefined( var_0.vehicle_spawned_thisframe ) )
        wait 0.1;

    var_2 thread drone_kamikaze_player( var_0, undefined, var_1 );
}

get_legal_drone_for_kamikaze()
{
    level endon( "delete_drone_cloud" );
    var_0 = undefined;

    for (;;)
    {
        var_1 = anglestoforward( level.player getangles() );
        var_2 = level.player geteye() + var_1 * 200;
        var_3 = sortbydistanceauto( level.flock_drones, var_2 );

        foreach ( var_6, var_0 in var_3 )
        {
            var_5 = distance( var_0.origin, var_2 );

            if ( var_5 > 100 )
                continue;
            else
                return var_0;
        }

        waitframe();
    }
}

drone_kamikaze_player( var_0, var_1, var_2 )
{
    level endon( "delete_drone_cloud" );
    level endon( "stop_kamikaze_player" );

    if ( isdefined( var_0.vehicle_spawned_thisframe ) )
        return;

    if ( !isdefined( level.spawned_kamikaze_drones ) )
        level.spawned_kamikaze_drones = [];

    var_3 = var_0 maps\_utility::spawn_vehicle();
    level.spawned_kamikaze_drones[level.spawned_kamikaze_drones.size] = var_3;

    if ( !isdefined( var_3 ) || !var_3 maps\_vehicle::isvehicle() )
        return;

    var_3 notify( "nodeath_thread" );
    var_3.health = 1;

    if ( isdefined( self ) )
    {
        var_3 vehicle_teleport( self.origin, self.angles );
        var_4 = vectortoangles( level.player.origin - var_3.origin );
        var_3 vehicle_teleport( self.origin, var_4 );
    }
    else
        return;

    if ( level.killable_kamikazes )
    {
        level.flock_drones = common_scripts\utility::array_add( level.flock_drones, var_3 );
        var_3.kamikaze = 1;
    }

    var_5 = var_3.origin;

    for (;;)
    {
        if ( !isdefined( var_3 ) || !var_3 maps\_vehicle::isvehicle() )
            return;

        var_6 = anglestoforward( level.player getangles() );
        var_7 = level.player geteye() + var_6 * 30;
        var_3 vehicle_setspeed( 20, 20, 20 );
        var_3 setvehgoalposauto( var_7 );
        var_8 = level.player.origin - var_3.origin;
        var_8 = vectortoyaw( var_8 );
        var_3 setgoalyaw( var_8 );

        if ( !isdefined( var_1 ) )
        {
            if ( distance( var_3.origin, level.player geteye() ) < 60 )
            {
                var_9 = 30;
                level.player notify( "car_door_shield_damaged", var_9, var_3.origin, var_3.angles, "drones" );

                if ( !is_current_weapon_shield( level.player getcurrentweapon() ) )
                    soundscripts\_snd::snd_message( "drone_kamikaze_hit_player" );

                var_3 thread drone_die_random();
                level.player notify( "kamikaze_hit_player" );
                earthquake( randomfloatrange( 0.25, 1 ), 0.5, level.player.origin, 32 );
            }
        }
        else if ( isdefined( var_1 ) && var_3 isorigintouchingvol( var_1 ) || distance( var_3.origin, level.player geteye() ) < 60 )
        {
            if ( distance( var_3.origin, level.player geteye() ) < 60 )
                soundscripts\_snd::snd_message( "drone_kamikaze_hit_player" );

            var_3 thread drone_die_random();
            earthquake( randomfloatrange( 0.25, 1 ), 0.5, level.player.origin, 32 );
        }
        else if ( !bullettracepassed( var_5, var_3.origin, 0, var_3 ) )
            var_3 thread drone_die_random();

        if ( isdefined( var_3 ) )
            var_5 = var_3.origin;

        wait 0.05;
    }
}

is_current_weapon_shield( var_0 )
{
    return var_0 == "weapon_suv_door_shield_fr" || var_0 == "weapon_suv_door_shield_fl" || var_0 == "weapon_suv_door_shield_kl" || var_0 == "weapon_suv_door_shield_kr";
}

drone_kamikaze_player_evil_style( var_0, var_1 )
{
    var_2 = var_0.model;
    var_3 = spawn( "script_model", self.origin );
    var_3.angles = self.angles;
    var_3 setmodel( var_2 );
    var_4 = 352.0;
    var_5 = 1920;
    var_6 = 0.15;
    var_7 = 0.3;
    var_8 = ( 0, 0, 0 );
    var_9 = 0;
    var_10 = 60;
    var_11 = self evaluatetrajectorydelta();
    var_12 = undefined;
    var_13 = vectornormalize( var_11 );
    var_14 = var_13;

    for (;;)
    {
        var_12 = kamikaze_drone_get_target_origin();
        var_15 = var_12 - var_3.origin;
        var_13 = vectornormalize( var_15 );
        var_16 = ( var_13 - var_14 ) * 20 + var_8 + common_scripts\utility::randomvector( var_9 );
        var_14 = var_13;
        var_17 = length( var_11 );
        var_18 = vectornormalize( var_11 );

        if ( var_17 < var_4 )
            var_19 = min( var_17 + var_5 * 0.05, var_4 );
        else
            var_19 = max( var_17 - var_5 * 0.05, var_4 );

        if ( vectordot( var_11, var_12 - var_3.origin ) < 0 )
            var_16 *= -1;

        var_20 = vectorclamp( var_16 * var_7, var_6 );
        var_21 = vectornormalize( var_18 + var_20 );
        var_11 = var_21 * var_19;
        var_22 = var_3.origin + var_11 * 0.05;

        if ( !bullettracepassed( self.origin, var_22, 0, var_3 ) )
            break;

        var_3.origin = var_22;
        var_3.angles = vectortoangles( var_11 );

        if ( distance( var_22, var_12 ) < var_10 )
            break;

        if ( isdefined( var_1 ) && var_3 istouching( var_1 ) )
            break;

        waitframe();
    }

    var_23 = 30;
    level.player notify( "car_door_shield_damaged", var_23, var_3.origin, var_3.angles, "drones" );
    var_3 drone_die_random( var_11 );
    earthquake( randomfloatrange( 0.25, 1 ), 0.5, level.player.origin, 32 );
}

kamikaze_drone_get_target_origin()
{
    var_0 = anglestoforward( level.player getangles() );
    var_1 = level.player geteye() + var_0 * 30;
    return var_1;
}

isorigintouchingvol( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();

    if ( var_1 istouching( var_0 ) )
    {
        var_1 delete();
        return 1;
    }
    else
        var_1 delete();

    return 0;
}

setvehgoalposauto( var_0 )
{
    if ( !isdefined( self ) )
        return;

    if ( !maps\_vehicle::isvehicle() )
        return;

    self setvehgoalpos( var_0 );
}

drone_die_random( var_0, var_1 )
{
    var_2 = self.origin;
    var_3 = self.angles;

    if ( !isdefined( level.every_other_one ) )
        level.every_other_one = 0;

    if ( level.every_other_one > 1 )
        level.every_other_one = 0;

    if ( randomint( 100 ) < 5 )
        playfx( common_scripts\utility::getfx( "drone_sparks" ), var_2 );

    if ( isdefined( var_0 ) )
    {
        if ( level.gameskill > 1 && level.every_other_one < 1 )
        {
            magicbullet( "iw5_attackdronemagicbullet", var_2, var_2 + var_0 );
            level.every_other_one++;
        }
        else
            magicbullet( "iw5_attackdronemagicbullet", var_2, var_2 + var_0 );
    }
    else if ( level.gameskill > 1 && level.every_other_one < 1 )
    {
        magicbullet( "iw5_attackdronemagicbullet", var_2, level.player geteye() );
        level.every_other_one++;
    }
    else
        magicbullet( "iw5_attackdronemagicbullet", var_2, level.player geteye() );

    level notify( "heavy_rumble" );
    var_4 = spawn( "script_model", var_2 );
    var_4 setmodel( "vehicle_mil_attack_drone_destroy" );
    var_4.angles = var_3;
    level notify( "drone_kamikaze_crash", self.origin );

    if ( !isdefined( var_1 ) || !var_1 )
        self delete();

    var_5 = var_4.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) - level.player geteye();
    var_6 = randomintrange( 50, 80 );
    var_4 physicslaunchserver( var_4.origin + ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), randomintrange( -15, 15 ) ), var_5 * var_6 );

    if ( randomint( 100 ) < 15 )
        playfxontag( common_scripts\utility::getfx( "drone_smoke" ), var_4, "tag_origin" );

    playfxontag( common_scripts\utility::getfx( "drone_sparks" ), var_4, "tag_origin" );

    if ( level.big_kamikaze_death )
        playfxontag( common_scripts\utility::getfx( "drone_death_explode1" ), var_4, "tag_origin" );

    wait 15;
    var_4 delete();
}

spawn_drone_physics( var_0, var_1 )
{
    var_2 = self.origin;
    var_3 = self.angles;
    var_4 = spawn( "script_model", var_2 );
    var_4 setmodel( "vehicle_mil_attack_drone_destroy" );
    var_4.angles = var_3;
    var_5 = var_4.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) - level.player geteye();
    var_4 physicslaunchserver( var_4.origin + ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), randomintrange( -15, 15 ) ), var_5 );

    if ( randomint( 100 ) < 5 )
        playfxontag( common_scripts\utility::getfx( "drone_smoke" ), var_4, "tag_origin" );

    wait(randomfloat( 5 ));
    playfx( common_scripts\utility::getfx( "drone_sparks" ), var_4.origin );
    var_4 delete();
}

clear_drone_cloud()
{
    level waittill( "delete_drone_cloud" );
    common_scripts\utility::array_thread( level.flock_drones, ::delete_drone );
}

delete_drone()
{
    if ( !isdefined( self ) )
        return;

    self delete();
}

handle_drone_cloud_vehicle_attack( var_0, var_1 )
{
    self notify( "kill_cloud_vehicle_attack_process" );
    self endon( "kill_cloud_vehicle_attack_process" );

    if ( !common_scripts\utility::flag( "cloud_in_formation" ) )
        common_scripts\utility::flag_set( "cloud_in_formation" );

    if ( isdefined( var_0 ) )
        thread drone_cloud_formation_circle( var_0, var_1 );

    while ( vehicle_scripts\_attack_drone_common::isdronevehiclealive( var_0 ) )
        wait 0.05;

    common_scripts\utility::flag_clear( "cloud_in_formation" );
    level notify( "drone_cloud_formation_end" );
}

drone_cloud_formation_circle( var_0, var_1 )
{
    self notify( "kill_drone_cloud_formation_circle_process" );
    self endon( "kill_drone_cloud_formation_circle_process" );
    var_2 = ( 0, 0, 0 );
    var_0 endon( "death" );
    var_0.follow_dist = 200;
    level.cloud_queen.radii = 600;
    level.cloud_queen.accel = 35;
    level.cloud_queen.decel = 45;

    if ( !isdefined( var_1 ) )
        var_1 = 100;

    while ( vehicle_scripts\_attack_drone_common::isdronevehiclealive( var_0 ) )
    {
        level.cloud_queen.desired_speed = level.cloud_queen vehicle_getspeed() + 8;
        level.drone_test_tag.origin = var_0.origin;
        level.drone_test_tag.angles = var_0.angles;
        var_3 = level.drone_test_tag vehicle_scripts\_attack_drone_common::offset_position_from_drone( "backward", "tag_origin", var_0.follow_dist );
        var_3 += ( 0, 0, var_1 );

        if ( var_3 == var_2 && distance( var_3, level.cloud_queen.origin ) < 20 )
            level.cloud_queen vehicle_setspeed( 0, 30, 40 );
        else
        {
            var_4 = var_0 vehicle_getspeed() * 1.25;

            if ( var_4 <= 0 )
                var_4 = 18;

            level.cloud_queen vehicle_setspeed( var_4, var_4, var_4 * 1.25 );
            level.cloud_queen setvehgoalpos( var_3 );
        }

        var_2 = var_3;
        wait 0.05;
    }

    level.cloud_queen vehicle_setspeed( 10, 5, 5 );
}

drone_cloud_formation_circle_player( var_0, var_1, var_2 )
{
    self notify( "kill_drone_cloud_formation_circle_process" );
    self endon( "kill_cdrone_cloud_formation_circle_process" );
    level endon( "end_cherry_picker" );
    level endon( "end_drone_cloud" );
    self endon( "death" );

    foreach ( var_5, var_4 in level.drone_swarm_queens )
    {
        if ( var_4 != self )
            var_4 thread queen_drone_form_hemisphere( self, var_5 );
    }

    self hide();
    var_6 = ( 0, 0, 0 );
    var_0 endon( "death" );
    level.player endon( "death" );
    var_0.follow_dist = 200;
    self.radii = 600;
    self.accel = 35;
    self.decel = 45;
    self.retreat_path = 0;
    var_7 = var_0.origin + ( 0, 0, 90 );
    var_8 = var_7[2] + 50;
    var_9 = var_7[2] + 250;

    if ( !isdefined( var_1 ) )
        var_1 = 50;

    while ( isdefined( self ) )
    {
        while ( common_scripts\utility::flag( "cloud_queen_retreat_path" ) )
        {
            self.retreat_path = 1;
            wait 0.05;
        }

        self.retreat_path = 0;
        wait(randomfloatrange( 0.5, 0.9 ));
        var_10 = fixed_point_on_squished_sphere( 250, 70 );
        var_11 = var_0 gettagorigin( "tag_flash" );
        var_12 = var_0 gettagangles( "tag_flash" );
        var_11 += anglestoforward( var_12 ) * var_1;
        var_11 += var_10;

        if ( var_11[2] > var_9 )
            var_11 = ( var_11[0], var_11[1], var_8 );
        else if ( var_11[2] < var_8 )
            var_11 = ( var_11[0], var_11[1], var_9 );

        var_13 = vectortoangles( var_7 - self.origin );
        self vehicle_teleport( var_11, var_13 );
        self vehicle_setspeed( 0, 5, 5 );
        wait 0.25;
    }
}

queen_drone_form_hemisphere( var_0, var_1 )
{
    level endon( "delete_drone_cloud" );
    level endon( "end_drone_cloud" );
    self endon( "death" );
    self notify( "kill_queen_drone_fly_process" );
    self endon( "kill_queen_drone_fly_process" );
    self.retreat_path = 0;
    self.radii = 250;
    self.accel = 5;
    self.decel = 15;
    var_2 = ( 0, 0, 0 );
    self.desired_speed = 15;
    self.new_position = var_0.origin;
    var_3 = level.player.cherry_turret;
    self.maintain_position = undefined;
    thread maintain_position_around_queen( 200, -100, 150, level.cloud_queen );

    while ( vehicle_scripts\_attack_drone_common::is_real_vehicle() )
    {
        while ( !isdefined( self.maintain_position ) || self.retreat_path )
            wait 0.05;

        if ( level.cloud_queen vehicle_getspeed() < 18 )
            var_4 = 18;
        else
            var_4 = level.cloud_queen vehicle_getspeed();

        self vehicle_setspeed( var_4, var_4, var_4 );
        self setvehgoalpos( self.maintain_position );
        wait 0.5;
    }
}

maintain_position_around_queen( var_0, var_1, var_2, var_3 )
{
    level endon( "end_drone_cloud" );
    var_4 = level.player.cherry_turret;
    var_5 = var_3.origin;
    var_6 = var_5;

    while ( isdefined( self ) )
    {
        var_7 = distance( var_5, var_3.origin );
        var_8 = fixed_point_on_squished_sphere( var_0 );
        var_9 = var_3.origin + var_8;
        var_6 = var_3.origin;

        if ( !isdefined( level.no_fly_zone ) || isdefined( level.no_fly_zone ) && distance( level.no_fly_zone, var_9 ) > level.attack_drones_nofly_zone_radius )
            self.maintain_position = var_9;
        else
        {
            wait 0.05;
            continue;
        }

        wait 0.1;
    }
}

queen_drone_fly( var_0, var_1 )
{
    level endon( "delete_drone_cloud" );
    self endon( "death" );
    self notify( "kill_queen_drone_fly_process" );
    self endon( "kill_queen_drone_fly_process" );
    self.radii = var_1;
    self.accel = 5;
    self.decel = 15;
    var_2 = ( 0, 0, 0 );
    self.desired_speed = 15;
    self notify( "queen_set_fly_logic" );

    while ( vehicle_scripts\_attack_drone_common::is_real_vehicle() )
    {
        var_3 = ( perlinnoise2d( gettime() * 0.001 * 0.05, 10, 4, 5, 2 ), perlinnoise2d( gettime() * 0.001 * 0.05, 20, 4, 5, 2 ), perlinnoise2d( gettime() * 0.001 * 0.05, 30, 4, 5, 2 ) );
        var_4 = position_in_circle( var_0.origin, self.radii );
        var_2 = var_4;
        var_5 = var_0 vehicle_getspeed();

        if ( var_5 <= 5 )
        {
            var_6 = 1;
            var_5 = 18;
            self vehicle_setspeed( var_5 * 1.25, var_5 * 2, var_5 * 2.25 );
        }
        else
        {
            var_6 = 0;
            self vehicle_setspeed( var_5 * 1.25, var_5, var_5 * 1.25 );
        }

        self setvehgoalpos( var_3 + var_4 );

        if ( var_6 )
        {
            if ( self.location + 1 <= self.num_in_formation )
                self.location++;
            else
                self.location = 0;

            wait 0.05;
            continue;
        }

        wait 0.25;
    }
}

position_in_circle( var_0, var_1 )
{
    var_2 = var_1;
    var_3 = 1;
    var_4 = self.num_in_formation;
    var_5 = 360 / var_4;
    var_6 = [];
    var_7 = [];

    for ( var_8 = 0; var_8 < var_4; var_8++ )
    {
        var_3 = var_5 * var_8;
        var_9 = 0;
        var_6[var_6.size] = var_0 + anglestoforward( ( var_9, var_3, 0 ) ) * var_2;
    }

    if ( isdefined( var_6[self.location] ) )
        return var_6[self.location];
    else
        return var_6[0];
}

position_in_spear( var_0, var_1, var_2 )
{
    return var_2.origin;
}

make_boidcloud( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.attack_drones_num_drones_per_queen;

    if ( !isdefined( var_2 ) )
        var_2 = 50;

    var_3 = spawnstruct();
    var_3.queen = self;
    var_3.queen.flock = var_3;
    var_3.boids = [];

    if ( isdefined( var_0 ) )
        var_3.boid_settings = var_0;
    else
        var_3.boid_settings = spawnstruct();

    setsaveddvar( "r_lightCacheLessFrequentPeriod", 20 );
    setsaveddvar( "r_lightCacheLessFrequentMaxDistance", 9999 );

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = spawn( "script_model", self.origin );

        if ( level.nextgen )
            var_5 setmodel( self.model );
        else if ( randomint( 100 ) < var_2 )
        {
            var_5 setmodel( "vehicle_mil_attack_drone_static_multi_cg" );
            var_5 thread multi_drone_handle_anim();
        }
        else
            var_5 setmodel( self.model );

        var_5.old_contents = var_5 setcontents( 0 );
        var_5 startusinglessfrequentlighting();
        var_3.boids[var_3.boids.size] = var_5;
        var_5 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health();
    }

    self.boid_cloud_spawned = 1;
    var_3 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
    return var_3;
}

make_boidcloud_from_spawned_models( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.queen = self;
    var_2.queen.flock = var_2;
    var_2.boids = var_1;

    if ( isdefined( var_0 ) )
        var_2.boid_settings = var_0;
    else
        var_2.boid_settings = spawnstruct();

    setsaveddvar( "r_lightCacheLessFrequentPeriod", 20 );
    setsaveddvar( "r_lightCacheLessFrequentMaxDistance", 9999 );

    foreach ( var_4 in var_1 )
    {
        var_4.old_contents = var_4 setcontents( 0 );
        var_4 startusinglessfrequentlighting();
        var_4 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health();
    }

    self.boid_cloud_spawned = 1;
    var_2 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
    return var_2;
}

monitor_drone_swearm_boundaries()
{
    if ( common_scripts\utility::cointoss() )
        return;

    var_0 = getentarray( "vol_drone_swarm_boundary", "targetname" );

    while ( isdefined( self ) )
    {
        if ( !is_boid_in_vols( var_0 ) )
            wait 0.1;

        wait 0.05;
    }
}

is_boid_in_vols( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( self istouching( var_2 ) )
            return 1;
    }

    return 0;
}

fixed_point_squished_sphere( var_0 )
{
    var_1 = var_0 * var_0;

    for ( var_2 = common_scripts\utility::randomvector( var_0 ); lengthsquared( var_2 ) > var_1; var_2 = common_scripts\utility::randomvector( var_0 ) )
    {

    }

    return ( var_2[0], var_2[1], var_2[2] * 0.65 );
}

fixed_point_on_squished_sphere( var_0, var_1 )
{
    var_2 = fixed_point_squished_sphere( 1 );
    var_3 = vectornormalize( var_2 ) * var_0;

    while ( isdefined( var_1 ) )
    {
        if ( var_3[2] < var_1 )
        {
            var_2 = fixed_point_squished_sphere( 1 );
            var_3 = vectornormalize( var_2 ) * var_0;
            continue;
        }

        break;
    }

    return var_3;
}

boid_add_vehicle_to_targets( var_0, var_1 )
{
    var_0 notify( "stop_friendlyfire_shield" );
    level endon( "end_drone_cloud" );
    var_0 endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    while ( vehicle_scripts\_attack_drone_common::isdronevehiclealive( var_0 ) )
    {
        var_2 = sortbydistanceauto( level.flock_drones, var_0.origin );

        for ( var_3 = 0; var_3 < 5; var_3++ )
        {
            if ( isdefined( var_2[var_3] ) )
            {
                var_2[var_3] thread vehicle_scripts\_attack_drone_common::boid_vehicle_targets( var_0, var_1 );
                wait 0.1;
            }
        }

        wait 2;
    }
}

#using_animtree("vehicles");

multi_drone_handle_anim()
{
    self endon( "death" );
    level endon( "end_drone_cloud" );
    level endon( "delete_drone_cloud" );
    self useanimtree( #animtree );

    if ( randomfloat( 1.0 ) >= 0.5 )
        var_0 = %mil_attack_drone_multi_cg_spin_cw;
    else
        var_0 = %mil_attack_drone_multi_cg_spin_ccw;

    var_1 = getanimlength( var_0 );
    wait(randomfloat( 1.0 ));

    for (;;)
    {
        self setanimknobrestart( var_0 );
        wait(var_1);
    }
}
