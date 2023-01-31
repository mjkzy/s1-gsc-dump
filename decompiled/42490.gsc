// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

attack_drone_init()
{
    level.player_test_points = common_scripts\utility::getstructarray( "player_test_point", "targetname" );

    if ( !isdefined( level.player_test_points ) || level.player_test_points.size < 1 )
        level.player_test_points = getentarray( "player_test_point", "targetname" );

    level.drone_air_spaces = getentarray( "drone_air_space", "script_noteworthy" );

    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];
}

attack_drone_formation_init()
{
    precacheshader( "sentinel_drone_overlay" );
    precacheshader( "warbird_hud_overlay_cannon" );
    level.formation_volumes = getentarray( "drone_formation_volume", "targetname" );
}

spawn_attack_drone( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    else
        var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );

    return var_2;
}

queen_drone_gopath( var_0 )
{
    if ( isdefined( var_0 ) )
        thread maps\_vehicle::vehicle_paths( var_0 );

    maps\_vehicle::gopath();
}

setup_queen_drone()
{
    var_0 = self;
    var_0.ignoreall = 1;
    var_0.ignoreme = 1;
    var_0.maxhealth = 30000;
    var_0.health = 30000;
    var_0 _meth_8283( 5, 60, 60 );
}

skip_helicopter_death_logic()
{
    for (;;)
    {
        if ( isdefined( self ) )
            self notify( "in_air_explosion" );
        else
            break;

        wait 0.05;
    }
}

make_non_sentient()
{
    while ( !issentient( self ) )
        wait 0.05;

    self _meth_813A();
}

drone_lerp_to_position( var_0, var_1, var_2 )
{
    if ( !isdefined( self ) )
        return;

    self endon( "death" );
    self notify( "kill_lerp_process" );
    self endon( "kill_lerp_process" );
    var_3 = distance( var_0, self.origin );
    var_4 = 0;
    var_5 = self.origin;

    while ( var_4 < var_3 )
    {
        if ( !isdefined( self ) )
            return;

        var_6 = drone_getlerpfraction( self.origin, var_0, var_1, var_2 );
        self.origin = vectorlerp( self.origin, var_0, var_6 );
        var_4 = distance( self.origin, var_5 );
        wait 0.05;
    }

    self notify( "drone_lerped" );
}

drone_getlerpfraction( var_0, var_1, var_2, var_3 )
{
    var_4 = distance( var_0, var_1 );
    var_5 = var_2 / var_4 * 0.05;

    if ( var_5 > 0 )
        return var_5;
    else
        return 0;
}

make_queen_invulnerable( var_0 )
{
    level endon( "delete_drone_cloud" );
    level endon( "end_drone_cloud" );
    self endon( "death" );

    while ( isdronevehiclealive( self ) )
    {
        self.maxhealth = 500000;
        self.health = self.maxhealth;
        wait 0.05;
    }

    if ( !isdefined( var_0 ) && self == level.cloud_queen )
        level.cloud_queen = common_scripts\utility::random( level.drone_swarm_queens );
}

cloud_queen_fly()
{
    maps\_vehicle::gopath();

    for (;;)
    {
        common_scripts\utility::flag_wait( "cloud_in_formation" );
        maps\_utility::vehicle_detachfrompath();
        self notify( "drone_path_detach" );
        level waittill( "drone_cloud_formation_end" );
    }
}

is_real_vehicle()
{
    if ( isdefined( self ) && self.health > 0 && maps\_vehicle::isvehicle() )
        return 1;

    return 0;
}

add_to_flock( var_0 )
{
    self.boids = common_scripts\utility::array_removeundefined( self.boids );
    self.boids[self.boids.size] = var_0;
}

boid_flock_think()
{
    level endon( "delete_drone_cloud" );
    level endon( "end_drone_cloud" );

    while ( isalive( self.queen ) )
    {
        var_0 = [];

        foreach ( var_2 in self.boids )
        {
            if ( isdefined( var_2 ) && !isdefined( var_2.remove_from_flock ) )
                var_0[var_0.size] = var_2;
        }

        self.boids = var_0;

        if ( randomfloat( 1 ) < 0.05 )
            self.boid_settings.queen_curl *= -1;

        var_4 = self.boid_settings.min_speed;
        var_5 = self.boid_settings.max_speed;
        var_6 = [];

        if ( self.boid_settings.emp_mode )
            var_6[var_6.size] = [ self.queen.origin - ( 0, 0, 1000000.0 ), ( 0, 0, 0 ), 0, 1, 0 ];
        else
        {
            var_7 = self.queen _meth_8287();
            var_8 = length( var_7 );
            var_9 = max( 87.5, var_8 );
            var_10 = clamp( var_9 / 262.5, 0, 0.8 );
            var_11 = vectornormalize( var_7 ) * var_10;
            var_12 = self.boid_settings.queen_deadzone * ( 1.0 - var_10 );
            var_6[var_6.size] = [ self.queen.origin, var_11, self.boid_settings.queen_deadzone, 1, self.boid_settings.queen_curl ];

            if ( self.boid_settings.dodge_player_shots && level.player attackbuttonpressed() )
            {
                var_13 = level.player _meth_80A8();
                var_14 = 0.15 * distance( self.queen.origin, var_13 );
                var_6[var_6.size] = [ var_13, anglestoforward( level.player getangles() ), var_14, 0, 0 ];
            }

            if ( isdefined( level.player.magnet_radius ) )
                var_14 = level.player.magnet_radius;
            else
                var_14 = 192;

            var_6[var_6.size] = [ level.player.origin, ( 0, 0, 0 ), var_14, 0, 0 ];

            if ( isdefined( level.no_fly_zone ) )
                var_6[var_6.size] = [ level.no_fly_zone, ( 0, 0, 0 ), level.attack_drones_nofly_zone_radius, 0, 0 ];

            if ( isdefined( level.controllable_cloud_queen ) && isdefined( level.controllable_cloud_queen.camera_tag ) )
                var_6[var_6.size] = [ level.controllable_cloud_queen.camera_tag, ( 0, 0, 0 ), 150, 0, 0 ];

            if ( self.boid_settings.queen_relative_speed )
            {
                var_4 = max( var_9 * 0.25, 87.5 );
                var_5 = var_9 * 3;
            }
        }

        _func_2A1( self.boids, var_6, self.boid_settings.neighborhood_radius, self.boid_settings.separation_factor, self.boid_settings.alignment_factor, self.boid_settings.cohesion_factor, self.boid_settings.magnet_factor, self.boid_settings.random_factor, self.boid_settings.max_accel, var_4, var_5, self.boid_settings.drag_amount, self.boid_settings.random_drag_amount );
        waitframe();
    }
}

drone_find_ground()
{
    var_0 = bullettrace( self.origin - ( 0, 0, 5 ), self.origin - ( 0, 0, 1000 ), 0, self, 0, 0, 0 );
    return var_0["position"];
}

offset_position_from_drone( var_0, var_1, var_2 )
{
    var_3 = self gettagangles( var_1 );
    var_4 = self gettagorigin( var_1 );

    if ( var_0 == "up" )
        return var_4 + anglestoup( var_3 ) * var_2;

    if ( var_0 == "down" )
        return var_4 + anglestoup( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "right" )
        return var_4 + anglestoright( var_3 ) * var_2;

    if ( var_0 == "left" )
        return var_4 + anglestoright( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "forward" )
        return var_4 + anglestoforward( var_3 ) * var_2;

    if ( var_0 == "backward" )
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "backwardright" )
    {
        var_4 += anglestoright( var_3 ) * var_2;
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );
    }

    if ( var_0 == "backwardleft" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * -1 );
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );
    }

    if ( var_0 == "forwardright" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * 1 );
        return var_4 + anglestoforward( var_3 ) * var_2;
    }

    if ( var_0 == "forwardleft" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * -1 );
        return var_4 + anglestoforward( var_3 ) * var_2;
    }
}

monitor_drone_cloud_health( var_0 )
{
    self notify( "kill_drone_cloud_health_process" );
    self endon( "kill_drone_cloud_health_process" );

    if ( isdefined( self ) )
        self.can_be_damaged = 0;

    if ( !isdefined( self ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !var_0 && randomint( 100 ) > 20 )
        return;

    if ( !var_0 )
        wait(randomfloat( 1.0 ));

    if ( _func_294( self ) )
        return;

    self _meth_82C0( 1 );
    self.can_be_damaged = 1;
    var_1 = 0;

    for (;;)
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6 );
        thread fake_drone_death();
        break;
    }
}

fake_drone_death( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( self ) )
        return;

    self.dying = 1;
    self.remove_from_flock = 1;
    var_4 = randomfloat( 0.15 );
    var_5 = 0.15;
    var_6 = 0.0085;
    var_7 = ( 0, 0, -800 );
    var_8 = 1930 * anglestoforward( self.angles );
    var_9 = self.origin;
    var_10 = undefined;
    var_11 = randomint( 16 );
    var_12 = randomint( 16 );
    var_13 = randomint( 16 );
    var_14 = 0;

    if ( common_scripts\utility::cointoss() )
        var_14 = 1;

    for ( var_15 = 0; var_15 < var_5; var_15 += 0.05 )
    {
        if ( !isdefined( self ) )
            return;

        var_9 += var_7 * 0.05;

        if ( var_15 < var_4 )
            var_9 += var_8 * 0.05;

        var_16 = min( var_6 * lengthsquared( var_9 ) * 0.05, length( var_9 ) );
        var_9 -= vectornormalize( var_9 ) * var_16;
        var_17 = self.origin + var_9 * 0.05;
        var_10 = bullettrace( self.origin + ( 0, 0, 3 ), var_17, 1, self, 0 );

        if ( var_10["fraction"] >= 1 )
        {
            self.origin = var_17;
            var_5 += 0.05;
        }
        else
            break;

        self _meth_82BA( var_11 );
        self _meth_82BB( var_13 );
        self _meth_82B9( var_12 );

        if ( var_14 && randomint( 100 ) > 95 )
        {
            drone_explode();
            return;
        }

        wait 0.05;
    }

    self.origin = var_10["position"];
    self.angles = var_10["normal"];
    drone_explode();
}

totally_fake_drone_death( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) && var_4 )
        playfx( common_scripts\utility::getfx( "drone_sparks" ), self.origin );
    else if ( isdefined( var_3 ) && var_3 )
        thread vehicle_scripts\_attack_drone::spawn_drone_physics();
    else if ( isdefined( var_2 ) && var_2 )
        playfx( common_scripts\utility::getfx( "drone_death_nexus" ), self.origin );
    else if ( var_0 )
        playfx( common_scripts\utility::getfx( "drone_death_nexus" ), self.origin );
    else if ( level.drone_turret_fake_death_awesome )
    {
        if ( randomint( 100 ) < 5 )
            playfx( common_scripts\utility::getfx( "drone_death_explode1" ), self.origin );
        else if ( randomint( 100 ) < 15 )
            thread vehicle_scripts\_attack_drone::spawn_drone_physics();
        else if ( randomint( 100 ) < 25 )
            playfx( common_scripts\utility::getfx( "drone_death_nexus" ), self.origin );
    }
    else
    {
        playfx( common_scripts\utility::getfx( "drone_death_nexus" ), self.origin );

        if ( randomint( 100 ) < 10 )
            thread vehicle_scripts\_attack_drone::spawn_drone_physics();
    }

    if ( isdefined( var_1 ) && var_1 && isdefined( self ) )
        self delete();

    level notify( "drone_swarm_hit" );
}

is_bullet_damage( var_0 )
{
    if ( var_0 == "MOD_CRUSH" )
        return 0;

    var_1 = [ "MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "mod_pistol_bullet", "mod_rifle_bullet", "mod_explosive_bullet", "mod_grenade", "mod_projecile", "mod_grenade_splash", "mod_projectile_splash", "mod_melee", "mod_melee_alt", "mod_explosive", "MOD_EXPLOSIVE_BULLET" ];

    foreach ( var_3 in var_1 )
    {
        if ( var_0 == var_3 )
            return 1;
    }

    return 0;
}

fly_to_target( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "im_dying" );
    thread explode_drone_on_impact( var_0 );

    if ( !isdefined( self ) )
        return;

    self.angles = vectortoangles( var_0.origin - self.origin );
    var_3 = var_0.origin + ( 0, 0, 40 );
    thread lerp_drone_to_position( var_3, 2700 );
    thread kamikaze_shooter( var_3 );
    self waittill( "lerp_complete" );
    self notify( "explode" );
}

find_unique_offset( var_0 )
{
    self endon( "im_dying" );
    var_1 = self.origin;
    var_2 = ( randomintrange( -300, 300 ), randomintrange( -300, 300 ), 100 );
    var_3 = bullettrace( self.origin, var_0.origin + var_2, 1, self );

    if ( isdefined( var_3["entity"] ) && var_3["entity"] == var_0 )
        return var_3["position"];

    wait 0.05;
}

explode_drone_on_impact( var_0 )
{
    self waittill( "explode" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = self.origin;

    if ( !isdefined( var_1 ) )
        var_1 = var_0.origin;

    playfx( common_scripts\utility::getfx( "drone_explode" ), var_1 );
    radiusdamage( var_1, 400, var_0.maxhealth / 3, var_0.maxhealth / 4 );

    if ( isdefined( self ) )
        self delete();
}

lerp_drone_to_position( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( self ) )
        return;

    var_4 = distance( var_0, self.origin );
    var_5 = 0;
    var_6 = self.origin;

    while ( var_5 < var_4 && isdefined( self ) )
    {
        var_7 = getdronelerpfraction( self.origin, var_0, var_1, var_2 );
        self.origin = vectorlerp( self.origin, var_0, var_7 );

        if ( isdefined( var_3 ) )
            self.angles += var_3;

        var_5 = distance( self.origin, var_6 );
        wait 0.05;
    }

    self notify( "lerp_complete" );
}

getdronelerpfraction( var_0, var_1, var_2, var_3 )
{
    var_4 = distance( var_0, var_1 );
    var_5 = var_2 / var_4 * 0.05;

    if ( var_5 > 0 )
        return var_5;
    else
        return 0;
}

kamikaze_shooter( var_0 )
{
    self endon( "death" );
    self endon( "im_dying" );
    self endon( "explode" );

    while ( isdefined( self ) )
    {
        magicbullet( "iw5_attackdronemagicbullet", self.origin, var_0 );
        wait 0.05;
    }
}

boid_vehicle_targets( var_0, var_1 )
{
    self endon( "im_dying" );

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    if ( !isdefined( self ) )
        return;

    if ( !isdefined( var_0 ) )
        return;

    self notify( "im_attacking" );
    self.remove_from_flock = 1;
    fly_to_target( var_0, 300 );
    wait 0.15;
}

make_no_fly_zone( var_0, var_1 )
{
    level.no_fly_zone = var_0;
    wait(var_1);
    level.no_fly_zone = undefined;
}

drone_explode()
{
    playfx( common_scripts\utility::getfx( common_scripts\utility::random( [ "drone_death_explode1", "drone_sparks" ] ) ), self.origin );

    if ( level.smart_drone_think )
        thread make_no_fly_zone( self.origin, 2 );

    self delete();
}

drone_fx()
{
    level._effect["drone_death_explode1"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["drone_death_extra"] = loadfx( "vfx/sparks/microwave_grenade_sparks_1" );
    level._effect["drone_death_cheap"] = loadfx( "vfx/sparks/drone_swarm_damage_spark" );
    level._effect["drone_explode"] = loadfx( "vfx/explosion/drone_swarm_projectile_explode" );
    level._effect["drone_sparks"] = loadfx( "vfx/sparks/sparks_pdrone_hit" );
    level._effect["drone_smoke"] = loadfx( "vfx/sparks/sparks_pdrone_smoldering" );
    level._effect["drone_death_nexus"] = loadfx( "vfx/explosion/drone_swarm_queen_explode" );
}

isdronevehiclealive( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !var_0 maps\_vehicle::isvehicle() )
        return 0;

    if ( isdefined( var_0.classname ) && issubstr( var_0.classname, "corpse" ) )
        return 0;

    if ( var_0.health < 1 )
        return 0;

    return 1;
}

spawn_snake_cloud( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_2 ) )
    {
        if ( level.nextgen )
            var_2 = 32;
        else
            var_2 = 10;
    }

    if ( !isdefined( var_3 ) )
    {
        if ( level.nextgen )
            var_3 = 18;
        else
            var_3 = 6;
    }

    var_6 = spawnstruct();
    var_6.snakes = [];

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = spawn_snake( var_0, var_3, var_4, var_5 );

        if ( isdefined( var_1 ) )
            var_8 snake_set_points( var_1 );

        var_8 thread snake_dyanamic_control();
        var_6.snakes[var_6.snakes.size] = var_8;
        wait 0.1;
    }

    return var_6;
}

spawn_snake_no_drones( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 32;

    var_5 = spawnstruct();
    var_5.snakes = [];
    var_6 = int( var_3.size / var_2 );

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = [];

        for ( var_9 = 0; var_9 < var_6; var_9++ )
        {
            if ( isdefined( var_3[var_9] ) )
                var_8[var_8.size] = var_3[var_9];
        }

        var_3 = common_scripts\utility::array_remove_array( var_3, var_8 );
        var_10 = spawn_snake_queen( var_0, var_8, var_4 );

        if ( isdefined( var_1 ) )
            var_10 snake_set_points( var_1 );

        var_10 thread snake_dyanamic_control();
        var_5.snakes[var_5.snakes.size] = var_10;
        wait 0.1;
    }

    return var_5;
}

cleanup_snake_cloud()
{
    level notify( "end_drone_snake_processes" );

    foreach ( var_1 in self.snakes )
        var_1 cleanup_snake();
}

snake_cloud_goto_points( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    self.snakes = common_scripts\utility::array_removeundefined( self.snakes );

    foreach ( var_7 in self.snakes )
    {
        if ( isdefined( var_7 ) )
        {
            if ( isdefined( var_5 ) )
                var_7.flock.boid_settings = var_5;

            var_7 snake_set_points( var_0, var_1, var_3, var_4 );
            wait(var_2 / self.snakes.size);
        }
    }
}

snake_cloud_stop_dynamic_control()
{
    foreach ( var_1 in self.snakes )
        var_1 notify( "stop_snake_control" );
}

snake_cloud_resume_dynamic_control()
{
    foreach ( var_1 in self.snakes )
        var_1 thread snake_dyanamic_control();
}

snake_cloud_set_boid_settings( var_0 )
{
    self.snakes = common_scripts\utility::array_removeundefined( self.snakes );

    foreach ( var_2 in self.snakes )
        var_2 snake_set_boid_settings( var_0 );
}

snake_set_boid_settings( var_0 )
{
    self.flock.boid_settings = var_0;
}

snake_cloud_teleport_to_point( var_0 )
{
    foreach ( var_2 in self.snakes )
    {
        var_2 notify( "stop_snake_control" );
        var_2 _meth_827C( var_0.origin, ( 0, 0, 0 ) );
        var_2.snake_points = [ var_0 ];
        var_2.snake_points_center = getaverageorigin( var_2.snake_points );
        var_2 thread snake_dyanamic_control();

        foreach ( var_4 in var_2.flock.boids )
            var_4.origin = var_2.origin;
    }
}

snake_swarm_attack_vehicle( var_0, var_1 )
{

}

spawn_snake( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
    {
        if ( level.nextgen )
            var_1 = 18;
        else
            var_1 = 6;
    }

    var_4 = getent( var_0, "targetname" );
    var_4.count++;
    var_5 = var_4 maps\_utility::spawn_vehicle();
    var_5 setcontents( 0 );

    if ( isdefined( var_2 ) )
        var_5 _meth_827C( var_2, ( 0, 0, 0 ) );

    var_5.godmode = 1;
    var_5.ignoreme = 1;
    var_6 = var_5 vehicle_scripts\_attack_drone::make_boidcloud( level.boid_settings_presets["default_snake"], var_1, var_3 );
    level.flock_drones = common_scripts\utility::array_combine( common_scripts\utility::array_removeundefined( level.flock_drones ), var_6.boids );

    if ( !isdefined( level.snakes ) )
        level.snakes = [];

    level.snakes = common_scripts\utility::array_removeundefined( level.snakes );
    level.snakes[level.snakes.size] = var_5;
    return var_5;
}

spawn_snake_queen( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );
    var_3.count++;
    var_4 = var_3 maps\_utility::spawn_vehicle();
    var_4 setcontents( 0 );

    if ( isdefined( var_2 ) )
        var_4 _meth_827C( var_2, ( 0, 0, 0 ) );

    var_4.godmode = 1;
    var_4.ignoreme = 1;
    var_5 = var_4 vehicle_scripts\_attack_drone::make_boidcloud_from_spawned_models( level.boid_settings_presets["default_snake"], var_1 );
    level.flock_drones = common_scripts\utility::array_combine( common_scripts\utility::array_removeundefined( level.flock_drones ), var_5.boids );

    if ( !isdefined( level.snakes ) )
        level.snakes = [];

    level.snakes = common_scripts\utility::array_removeundefined( level.snakes );
    level.snakes[level.snakes.size] = var_4;
    return var_4;
}

cleanup_snake()
{
    if ( !isdefined( self ) )
        return;

    foreach ( var_1 in self.flock.boids )
    {
        if ( isdefined( var_1 ) )
            var_1 delete();
    }

    self delete();
}

snake_set_points( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( self ) )
        return;

    self.snake_points = common_scripts\utility::getstructarray( var_0, "script_noteworthy" );

    if ( self.snake_points.size == 0 )
        return;

    self.snake_goal_origin = var_1;

    if ( isdefined( var_2 ) )
        var_2 *= 17.6;

    self.snake_speed_override = var_2;

    if ( isdefined( var_3 ) && var_3 )
        self.first_point = common_scripts\utility::getstruct( var_0, "targetname" );

    self.snake_points_center = getaverageorigin( self.snake_points );
}

getaverageorigin( var_0 )
{
    var_1 = ( 0, 0, 0 );

    foreach ( var_3 in var_0 )
        var_1 += var_3.origin;

    if ( var_0.size > 0 )
        var_1 *= 1.0 / var_0.size;

    return var_1;
}

debug_snake_points( var_0 )
{
    level notify( "debug_snake_points" );
    level endon( "debug_snake_points" );

    for (;;)
    {
        foreach ( var_2 in common_scripts\utility::getstructarray( var_0, "script_noteworthy" ) )
        {
            if ( isdefined( var_2.last_score ) )
                continue;
        }

        wait 0.05;
    }
}

snake_dyanamic_control()
{
    self endon( "death" );
    self endon( "stop_snake_control" );
    var_0 = 334.4;

    while ( !isdefined( self.snake_points ) )
        wait 0.05;

    var_1 = self.origin;
    var_2 = common_scripts\utility::getclosest( self.origin, self.snake_points );

    for (;;)
    {
        if ( isdefined( self.first_point ) )
        {
            var_2 = self.first_point;
            self.first_point = undefined;
        }
        else
        {
            for (;;)
            {
                var_2 = snake_choose_next_point( self.snake_points, var_2 );

                if ( isdefined( var_2 ) )
                    break;

                waitframe();
            }
        }

        if ( isdefined( var_2 ) && isdefined( var_2.script_flag_set ) )
        {
            if ( !common_scripts\utility::flag( var_2.script_flag_set ) )
            {
                level notify( var_2.script_flag_set, self );
                waitframe();
                common_scripts\utility::flag_set( var_2.script_flag_set );
                self.lead_snake = 1;

                foreach ( var_4 in level.snake_cloud.snakes )
                {
                    if ( var_4 == self )
                        continue;
                    else
                        var_4.lead_snake = undefined;
                }
            }
        }

        if ( isdefined( self.snake_speed_override ) )
            var_6 = self.snake_speed_override;
        else if ( isdefined( var_2 ) && isdefined( var_2.speed ) )
            var_6 = var_2.speed * 17.6;
        else
            var_6 = var_0;

        for (;;)
        {
            var_7 = var_6;

            if ( isdefined( level.snake_swarm_speed_scale ) )
                var_7 *= level.snake_swarm_speed_scale;

            var_8 = var_2.origin - var_1;
            var_9 = var_7 * 0.05;

            if ( length( var_8 ) < var_9 )
                break;

            var_1 += vectornormalize( var_8 ) * var_9;
            self _meth_8260( var_1, var_7, var_7, var_7, 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
            wait 0.05;
        }

        wait 0.05;

        while ( self.snake_points.size == 1 )
            wait 0.05;
    }
}

snake_kamikaze_control()
{
    self endon( "death" );
    self endon( "stop_snake_control" );
    var_0 = 175.0;
    self _meth_8260( self.origin + ( 0, 0, 156 ), var_0, var_0, var_0, 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
    wait 3;
    self _meth_8260( level.player.origin, var_0, var_0, var_0, 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
    var_1 = self.health;

    while ( distance( self.origin, level.player.origin > 195 ) )
    {
        if ( self.health != self.init_health )
        {
            foreach ( var_3 in self.flock )
                var_3 delete();

            self delete();
        }
    }

    level.player _meth_8051( 25, self.origin );
    thread snake_dyanamic_control();
}

draw_line_from_self_to_origin( var_0 )
{
    self notify( "draw_line_from_self_to_origin" );
    self endon( "draw_line_from_self_to_origin" );
    self endon( "death" );

    for (;;)
        wait 0.05;
}

snake_choose_next_point( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.target ) )
    {
        var_2 = common_scripts\utility::getstructarray( var_1.target, "targetname" );
        var_3 = common_scripts\utility::random( var_2 );

        if ( common_scripts\utility::array_contains( var_0, var_1 ) )
        {
            self.current_point_was_authored = 1;
            return var_3;
        }
    }

    if ( !common_scripts\utility::array_contains( var_0, var_1 ) )
    {
        self.current_point_was_authored = 0;
        return common_scripts\utility::getclosest( self.origin, var_0 );
    }

    var_4 = 0.25;
    var_5 = 2;
    var_6 = 0.001;
    var_7 = 2;
    var_8 = 0;
    var_9 = 1;
    var_10 = 0.003;
    var_11 = 10;
    var_12 = 1500.0;
    var_13 = anglestoforward( level.player _meth_8036() );
    var_14 = undefined;
    var_15 = undefined;

    foreach ( var_17 in var_0 )
    {
        if ( isdefined( var_17.target ) )
            continue;

        if ( var_17.origin == var_1.origin )
            continue;

        var_18 = randomfloat( var_4 );
        var_19 = vectornormalize( maps\_shg_utility::get_differentiated_velocity() );
        var_20 = var_17.origin - self.origin;
        var_21 = vectornormalize( var_20 );
        var_18 += ( vectordot( var_19, var_21 ) + 1 ) / 2 * var_5;
        var_22 = var_17.origin - level.player.origin;
        var_23 = vectornormalize( var_22 );
        var_18 += ( vectordot( var_23, var_13 ) + 1 ) / 2 * var_7;
        var_18 -= distance( var_1.origin, var_17.origin ) * var_6;
        var_18 -= distance( level.player.origin, var_17.origin ) * var_8;
        var_18 += vectorcross( vectornormalize( self.snake_points_center - self.origin ), var_21 )[2] * var_9;

        if ( isdefined( self.snake_goal_origin ) )
            var_18 -= distance( self.snake_goal_origin, var_17.origin ) * var_10;

        if ( isdefined( var_1 ) && isdefined( var_1.went_thither ) && var_1.went_thither == var_17 && gettime() - var_1.went_thither_time < var_12 )
            var_18 += randomfloat( var_11 );

        if ( ( !isdefined( var_15 ) || var_18 > var_15 ) && sighttracepassed( self.origin, var_17.origin, 0, self ) )
        {
            var_15 = var_18;
            var_14 = var_17;
        }

        var_17.last_score = var_18;
    }

    if ( !isdefined( var_14 ) )
        var_14 = common_scripts\utility::random( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_1.went_thither = var_14;
        var_1.went_thither_time = gettime();
    }

    self.current_point_was_authored = 0;
    return var_14;
}

snake_cloud_pester_helicopter( var_0 )
{
    self.snakes = common_scripts\utility::array_removeundefined( self.snakes );

    foreach ( var_2 in self.snakes )
        var_2 thread snake_pester_helicopter( var_0 );

    while ( isdefined( var_0 ) )
        var_0 waittill( "death" );

    if ( isdefined( self ) )
        cleanup_snake_cloud();
}

snake_pester_helicopter( var_0 )
{
    self notify( "stop_snake_control" );
    self endon( "death" );
    self endon( "stop_snake_control" );
    var_1 = 50;
    var_2 = 47;
    var_3 = 195;
    var_4 = 85;
    var_5 = 117;
    var_6 = 270;
    var_7 = 300;
    var_8 = squared( var_3 + var_5 );
    var_9 = 3.14159;
    var_10 = sqrt( squared( var_2 * ( var_3 + var_5 ) * var_9 / 180 ) + squared( var_4 * var_5 * var_9 / 180 ) );
    var_10 *= 3;
    var_11 = var_10 / 17.6;
    var_12 = var_0.origin;

    while ( distancesquared( self.origin, var_12 ) > var_8 )
    {
        if ( isdefined( var_0 ) )
            var_12 = var_0.origin;

        self _meth_8260( var_12, var_1, var_1, var_1, 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
        wait 0.05;
    }

    var_13 = randomfloat( 60 );

    if ( common_scripts\utility::cointoss() )
        var_14 = 180;
    else
        var_14 = 0;

    for (;;)
    {
        if ( isdefined( var_0 ) )
            var_12 = var_0.origin;

        var_15 = gettime() * 0.001 - var_13;
        var_16 = var_2 * var_15;
        var_17 = angleclamp( var_4 * var_15 + var_14 );

        if ( var_17 > var_6 && var_17 < var_7 )
        {
            if ( isdefined( var_0 ) )
            {
                var_0.godmode = 0;
                var_0 _meth_8051( 100, self.origin );
            }

            snake_cheap_death();

            if ( self.flock.boids.size == 0 )
            {
                self delete();
                return;
            }
        }

        var_18 = ( cos( var_16 ), sin( var_16 ), 0 );
        var_19 = var_12 + var_18 * ( var_3 + cos( var_17 ) * var_5 ) + ( 0, 0, sin( var_17 ) * var_5 );
        self _meth_8260( var_19, var_11, var_11, var_11, 0, ( 0, 0, 0 ), 0, 0, 0, 1, 0, 0, 0 );
        wait 0.05;
    }
}

snake_cheap_death()
{
    self.flock.boids = common_scripts\utility::array_removeundefined( self.flock.boids );

    if ( self.flock.boids.size != 0 )
        self.flock.boids[self.flock.boids.size - 1] boid_cheap_death();
}

boid_cheap_death()
{
    if ( randomfloat( 1 ) < 0.1 )
        playfx( common_scripts\utility::getfx( "drone_death_explode1" ), self.origin );

    self delete();
}
