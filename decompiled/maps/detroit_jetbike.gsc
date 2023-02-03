// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

spawn_exit_jetbike()
{
    level.jetbike = getent( "player_jetbike_exit", "targetname" );
}

handle_glass_collisions()
{
    self endon( "death" );
    level endon( "missionfailed" );

    for (;;)
    {
        var_0 = self.origin + anglestoforward( self.angles ) * 125;
        glassradiusdamage( var_0, 100, 1000, 600 );
        waitframe();
    }
}

handle_contact_collisions()
{
    self endon( "death" );
    level endon( "missionfailed" );
    vehicle_scripts\_jetbike::non_player_contact_watcher();
}

vehicle_rubberband( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = var_1 * 0.5;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    if ( !isdefined( self.rubberband_settings ) )
    {
        self.rubberband_settings = spawnstruct();
        var_7 = 1;
    }
    else
        var_7 = 0;

    self.rubberband_settings.target = var_0;
    self.rubberband_settings.desired_range = var_1;
    self.rubberband_settings.min_speed_ips = var_3 * 17.6;
    self.rubberband_settings.range_slop = var_2;
    self.rubberband_settings.time_constant = var_4;
    self.rubberband_settings.fail_range = var_5;
    self.rubberband_settings.fail_time = var_6;

    if ( var_7 )
        thread vehicle_rubberband_think();
}

vehicle_rubberband_stop()
{
    self.rubberband_settings = undefined;
    self notify( "vehicle_rubberband_stop" );
}

vehicle_rubberband_set_min_speed( var_0 )
{
    self.rubberband_settings.min_speed_ips = var_0 * 17.6;
}

vehicle_rubberband_set_desired_range( var_0 )
{
    self.rubberband_settings.desired_range = var_0;
}

vehicle_rubberband_set_fail_range( var_0, var_1 )
{
    self.rubberband_settings.fail_range = var_0;
    self.rubberband_settings.fail_time = var_1;
}

vehicle_rubberband_think()
{
    self endon( "death" );
    self endon( "vehicle_rubberband_stop" );
    var_0 = self.rubberband_settings.desired_range;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = self.rubberband_settings.target maps\_shg_utility::get_differentiated_speed();

    while ( isdefined( self.rubberband_settings.target ) )
    {
        var_6 = self.origin - self.rubberband_settings.target.origin;
        var_7 = vectornormalize( anglestoforward( self.angles ) + anglestoforward( self.rubberband_settings.target.angles ) + vectornormalize( var_6 ) );
        var_8 = vectordot( var_6, var_7 );

        if ( abs( var_8 - self.rubberband_settings.desired_range ) < self.rubberband_settings.range_slop )
            var_0 = var_8;
        else
            var_0 = self.rubberband_settings.desired_range;

        var_9 = var_8 - var_0;
        var_10 = self.rubberband_settings.time_constant;
        var_11 = self.rubberband_settings.target maps\_shg_utility::get_differentiated_speed();
        var_5 = maps\_utility::linear_interpolate( 0.9, var_11, var_5 );
        var_12 = var_5;
        var_12 -= var_9 / var_10;
        var_12 = max( var_12, self.rubberband_settings.min_speed_ips );
        var_13 = var_12 / 17.6;
        self vehicle_setspeed( var_13, 60, 60 );

        if ( isdefined( self.rubberband_settings.fail_range ) )
        {
            maps\_utility::add_extra_autosave_check( "jetbike_check_trailing", ::autosave_jetbike_check_trailing, "trailing too far behind the friendly jetbike." );
            maps\_utility::add_extra_autosave_check( "jetbike_check_too_slow", ::autosave_jetbike_check_too_slow, "player's jetbike is moving too slowly" );
            level.jetbike_too_slow = var_11 < self.rubberband_settings.min_speed_ips;

            if ( var_8 > self.rubberband_settings.fail_range )
            {
                level.jetbike_is_trailing = 1;
                var_1 += 0.05;

                if ( !var_2 )
                {
                    if ( !var_2 && !var_3 )
                    {
                        thread show_fail_range_hint_1();
                        var_3 = 1;
                        var_2 = 1;
                    }

                    if ( !var_2 && !var_4 )
                    {
                        thread show_fail_range_hint_2();
                        var_4 = 1;
                        var_2 = 1;
                    }
                }
            }
            else
            {
                level.jetbike_is_trailing = 0;
                var_1 = 0;
                var_2 = 0;
            }

            if ( var_1 > self.rubberband_settings.fail_time )
                fail_out_of_range();
        }
        else
            maps\_utility::remove_extra_autosave_check( "jetbike_check_trailing" );

        waitframe();
    }

    vehicle_rubberband_stop();
}

autosave_jetbike_check_trailing()
{
    return !level.jetbike_is_trailing;
}

autosave_jetbike_check_too_slow()
{
    return !level.jetbike_too_slow;
}

show_fail_range_hint_1()
{
    level.burke maps\_utility::dialogue_queue( "det_brk_mitchellkeepup" );
}

show_fail_range_hint_2()
{
    level.burke maps\_utility::dialogue_queue( "det_brk_keepgoing" );
}

fail_out_of_range()
{
    level notify( "exit_drive_failed" );
    setdvar( "ui_deadquote", &"DETROIT_OBJECTIVE_FAIL_JETBIKE" );
    maps\_utility::missionfailedwrapper();
}

intro_drive_jetbike_lights_friendlies()
{
    thread intro_drive_jetbike_lights( "jetbike_lights", "jetbike_lights_dim" );
}

intro_drive_jetbike_lights_player()
{
    common_scripts\utility::flag_set( "jetbike_dynfx_on" );
    intro_drive_jetbike_lights( "det_dyn_spotlight_jetbike", "det_dyn_spotlight_jetbike_dim" );
}

intro_drive_jetbike_lights( var_0, var_1 )
{
    if ( common_scripts\utility::flag( "exit_drive_started" ) == 1 )
        var_2 = maps\_shg_utility::play_fx_with_handle( var_0, self, "tag_headlight" );

    common_scripts\utility::flag_wait( "open_massive_door" );
    var_2 = maps\_shg_utility::play_fx_with_handle( var_0, self, "tag_headlight" );
    maps\_shg_design_tools::waittill_trigger_with_name( "jetbike_lights_off1" );
    maps\_shg_utility::kill_fx_with_handle( var_2 );
    common_scripts\utility::flag_clear( "jetbike_dynfx_on" );
    thread maps\detroit_lighting::turn_off_light_bright();
}

intro_drive_jetbike_lights_red( var_0 )
{
    var_1 = maps\_shg_utility::play_fx_with_handle( var_0, self, "TAG_LIGHT_BACK_MID" );
    maps\_shg_design_tools::waittill_trigger_with_name( "move_burke_ahead" );
    maps\_shg_utility::kill_fx_with_handle( var_1 );
}
