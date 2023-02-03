// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    common_scripts\utility::flag_init( "force_stealth_spotted_drones" );
    common_scripts\utility::flag_init( "drones_investigating" );
    level.dronespawnertemplate = getent( "droneSpawnerTemplate", "targetname" );
    level.dronespawners = common_scripts\utility::getstructarray( "droneSpawner", "targetname" );
    level.dronespawnerexits = [];

    foreach ( var_1 in level.dronespawners )
    {
        if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "droneDespawner" )
            level.dronespawnerexits[level.dronespawnerexits.size] = var_1;
    }

    if ( !isdefined( level.stealth_spotted_drones ) )
        level.stealth_spotted_drones = [];

    thread drones_can_see_enemy_test();
    thread drones_stealth_detect();
}

drones_stealth_detect()
{
    for (;;)
    {
        wait 0.05;

        if ( !isdefined( level.active_drones ) )
            continue;

        foreach ( var_1 in level.active_drones )
        {
            if ( isdefined( var_1.threatsightdelay ) && var_1.threatsightdelay > 0 )
                level.player maps\_stealth_display::stealth_display_seed( var_1, var_1.threatsightdelay, var_1.canseeplayer );
        }
    }
}

stealth_alerted_drone_monitor()
{
    level notify( "stealth_alerted_drone_monitor" );
    level endon( "stealth_alerted_drone_monitor" );
    level.player endon( "death" );
    level endon( "meet_cormack_end" );
}

drone_investigate_monitor()
{
    level notify( "drone_investigate_monitor" );
    level endon( "drone_investigate_monitor" );

    if ( !isdefined( level.drone_investigates ) )
        level.drone_investigates = [];

    for (;;)
    {
        level waittill( "drone_investigate", var_0, var_1, var_2, var_3 );
        level thread drone_investigate_initiate( var_0, var_1, var_2, var_3 );
    }
}

drone_investigate_initiate( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level.stealth_spotted_drones ) && level.stealth_spotted_drones.size > 0 )
        return;

    if ( isdefined( var_1 ) )
    {
        var_4 = var_1 common_scripts\utility::waittill_any_timeout_no_endon_death( 5, "death" );

        if ( var_4 != "timeout" )
            return;
    }

    if ( !vehicle_scripts\_pdrone_security::drone_investigate_try_location( var_0, var_2, var_3 ) && isdefined( var_1 ) )
        vehicle_scripts\_pdrone_security::drone_investigate_try_location( var_1.origin, var_2, var_3 );
}

stealth_spotted_drone_monitor()
{
    level.player endon( "death" );
    level endon( "stop_stealth_spotted_drone_monitor" );
    level endon( "meet_cormack_end" );

    for (;;)
    {
        common_scripts\utility::flag_waitopen( "_stealth_spotted" );
        var_0 = common_scripts\utility::flag_wait_any_return( "_stealth_spotted", "force_stealth_spotted_drones" );
        level.abort_drones = 0;
        level thread level_drone_abort_monitor();

        if ( var_0 == "_stealth_spotted" || var_0 == "force_stealth_spotted_drones" )
        {
            if ( var_0 == "_stealth_spotted" )
            {
                wait 4.0;

                if ( !common_scripts\utility::flag( "_stealth_spotted" ) )
                    continue;
            }

            foreach ( var_2 in level.stealth_spotted_drones )
            {
                var_2.pacifist = 0;
                var_2 maps\_utility::ent_flag_clear( "fire_disabled" );
            }

            var_4 = sortbydistance( level.dronespawners, level.player.origin );
            var_5 = sortbydistance( level.active_drones, level.player.origin, 4000 );
            var_6 = 0;
            var_7 = cos( 60 );
            var_8 = 0;

            while ( !level.abort_drones && common_scripts\utility::flag( "_stealth_spotted" ) && var_8 < 4 )
            {
                var_5 = maps\_utility::remove_dead_from_array( var_5 );

                if ( var_6 >= var_4.size )
                    var_6 = 0;

                if ( var_5.size > 0 )
                {
                    var_5[0] vehicle_scripts\_pdrone_security::drone_set_mode( "attack", 0 );
                    var_5[0] thread drone_abort_monitor();
                    var_5 = common_scripts\utility::array_remove( var_5, var_5[0] );
                    var_8 += 1;
                }
                else
                {
                    for ( var_9 = anglestoforward( level.player getangles() ); var_6 < var_4.size; var_6++ )
                    {
                        var_10 = vectornormalize( var_4[var_6].origin - level.player.origin );

                        if ( vectordot( var_10, var_9 ) < var_7 )
                            break;
                    }

                    if ( var_6 < var_4.size )
                    {
                        var_2 = vehicle_scripts\_pdrone_security::drone_spawn( var_4[var_6], "attack" );
                        var_2 thread drone_stealth_display_seed_always();
                        var_2 thread stealth_spotted_drone_death_monitor();

                        if ( isdefined( level.stealth_spotted_drones ) )
                            level.stealth_spotted_drones = common_scripts\utility::array_add( level.stealth_spotted_drones, var_2 );

                        var_8 += 1;
                        var_2 thread drone_damage_monitor();
                        var_2 thread drone_abort_monitor();
                        var_6++;
                    }
                    else
                        var_6 = 0;
                }

                wait 0.5;
            }
        }

        wait 1.0;
    }
}

drone_stealth_display_seed_always()
{
    self notify( "drone_stealth_display_seed_always" );
    self endon( "drone_stealth_display_seed_always" );
    self endon( "death" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "_stealth_spotted" ) )
            level.player maps\_stealth_display::stealth_display_seed( self, 1.0, 1 );

        wait 0.05;
    }
}

drones_can_see_enemy_test()
{
    level.player endon( "death" );

    for (;;)
    {
        level.drones_lost_player_time = 0;

        while ( !common_scripts\utility::flag( "_stealth_spotted" ) )
        {
            while ( level.stealth_spotted_drones.size > 0 && level.drones_lost_player_time <= 6.0 )
            {
                var_0 = 0;

                foreach ( var_2 in level.stealth_spotted_drones )
                {
                    var_3 = var_2.origin;

                    if ( var_2 gettagindex( "tag_flash" ) != -1 )
                        var_3 = var_2 gettagorigin( "tag_flash" );

                    if ( sighttracepassed( var_3, level.player geteye(), 0, var_2, level.player ) )
                    {
                        var_0 = 1;
                        break;
                    }
                }

                if ( var_0 )
                    level.drones_lost_player_time = 0;
                else
                    level.drones_lost_player_time += 0.05;

                if ( level.drones_lost_player_time >= 6.0 )
                {
                    foreach ( var_2 in level.stealth_spotted_drones )
                        var_2 thread drone_fly_away();

                    common_scripts\utility::flag_clear( "force_stealth_spotted_drones" );
                }

                wait 0.05;
            }

            wait 0.05;
        }

        wait 0.05;
    }
}

stealth_spotted_drone_death_monitor()
{
    self notify( "stealth_spotted_drone_death_monitor" );
    self endon( "stealth_spotted_drone_death_monitor" );
    self waittill( "death" );

    if ( isdefined( self ) && isdefined( level.stealth_spotted_drones ) )
        level.stealth_spotted_drones = common_scripts\utility::array_remove( level.stealth_spotted_drones, self );
}

drone_fly_away()
{
    self endon( "death" );
    self.pacifist = 1;
    maps\_utility::ent_flag_set( "fire_disabled" );
    var_0 = self.origin + ( 0, 0, 1000 );
    self vehicle_setspeed( 20, 20, 20 );
    self setvehgoalpos( var_0, 1 );
    common_scripts\utility::waittill_any( "near_goal", "goal" );
    level.stealth_spotted_drones = common_scripts\utility::array_remove( level.stealth_spotted_drones, self );
    self delete();
}

drone_damage_monitor()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_return_parms( "damage" );

        if ( var_0[0] == "damage" && isdefined( var_0[2] ) && var_0[2] == level.player )
        {
            if ( !common_scripts\utility::flag( "force_stealth_spotted_drones" ) && !common_scripts\utility::flag( "_stealth_spotted" ) )
                common_scripts\utility::flag_set( "force_stealth_spotted_drones" );
        }

        wait 0.05;
    }
}

drone_abort_monitor()
{
    self notify( "drone_abort_monitor" );
    self endon( "drone_abort_monitor" );
    self endon( "death" );
    level waittill( "drones_abort" );
    vehicle_scripts\_pdrone_security::drone_set_mode( "patrol", isdefined( self.prev_attachedpath ) );
    wait 0.5;
    thread vehicle_scripts\_pdrone_security::drone_return_home( undefined, self.prev_attachedpath );
}

level_drone_abort_monitor()
{
    self notify( "level_drone_abort_monitor" );
    self endon( "level_drone_abort_monitor" );
    level waittill( "drones_abort" );
    level.abort_drones = 1;
}
