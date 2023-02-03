// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

missile_handle_threat_grenade()
{
    self endon( "death" );
    self endon( "stop_missle_handle_thread_grenade" );
    self.targetlist = [];

    for (;;)
    {
        level.player waittill( "threat_grenade_marking_started", var_0 );
        var_1 = var_0.enemies;
        wait 3;
        fire_missles_at_target_array( var_1 );
    }
}

fire_missles_at_target_array_repeated( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( isdefined( var_5 ) )
    {
        if ( !isdefined( level.vehicle_missile_launcher_count ) )
            level.vehicle_missile_launcher_count = [];

        if ( !isdefined( level.vehicle_missile_launcher_count[var_5] ) )
            level.vehicle_missile_launcher_count[var_5] = 0;
    }

    if ( !isdefined( var_6 ) )
        var_6 = 2;

    var_8 = 4;
    var_9 = 0;

    foreach ( var_11 in var_0 )
    {
        if ( var_11 == level.player )
        {
            var_9 = 1;
            break;
        }
    }

    var_13 = 0;
    var_14 = level.vehicle_missile_launcher[self.classname][0];

    for (;;)
    {
        if ( isdefined( var_1 ) )
            self [[ var_1 ]]();

        for (;;)
        {
            var_15 = 1;

            if ( var_15 && var_3 )
            {
                var_16 = getdvarint( "cg_fov" );

                if ( !level.player worldpointinreticle_circle( self.origin, var_16, 250 ) )
                    var_15 = 0;
            }

            if ( var_15 && var_4 && var_9 )
            {
                var_17 = self gettagorigin( self.missiletags[0] );
                var_18 = level.player geteye() - var_17;
                var_18 *= 0.75;
                var_19 = bullettrace( var_17, var_17 + var_18, 1, self, 0, 0, 0 );

                if ( var_19["fraction"] < 1 )
                    var_15 = 0;
            }

            if ( var_15 && var_2 )
            {
                var_17 = self gettagorigin( self.missiletags[0] );
                var_18 = anglestoforward( self gettagangles( self.missiletags[0] ) );
                var_18 *= 100;
                var_19 = bullettrace( var_17, var_17 + var_18, 1, self, 0, 0, 0 );

                if ( var_19["fraction"] < 1 )
                    var_15 = 0;
            }

            if ( var_15 )
            {
                if ( isdefined( var_7 ) && !var_13 )
                {
                    wait(var_7);
                    var_13 = 1;
                    var_15 = 0;
                }
            }

            if ( var_15 && isdefined( var_5 ) && level.vehicle_missile_launcher_count[var_5] >= var_6 )
                var_15 = 0;

            if ( var_15 )
                break;

            wait(var_8 * 0.05);
            maps\_utility::array_removedead( var_0 );
        }

        if ( isdefined( var_5 ) )
        {
            self.needs_to_decrement_launcher_count = 1;
            level.vehicle_missile_launcher_count[var_5]++;
            thread decrement_firing_count_if_died_while_firing( var_5, var_14 );
        }

        fire_missles_at_target_array( var_0, self.missiletags.size / var_0.size, undefined, 1 );

        if ( isdefined( var_14 ) && isdefined( var_14.salvo_cooldown_min ) )
            wait(randomfloatrange( var_14.salvo_cooldown_min, var_14.salvo_cooldown_max ));
        else
            wait(randomfloatrange( 0.5, 1.5 ));

        if ( isdefined( var_5 ) )
        {
            level.vehicle_missile_launcher_count[var_5]--;
            self.needs_to_decrement_launcher_count = 0;
            self notify( "kill_decrement_firing_count_if_died_while_firing" );
        }

        waitframe();
    }
}

decrement_firing_count_if_died_while_firing( var_0, var_1 )
{
    self notify( "kill_decrement_firing_count_if_died_while_firing" );
    self endon( "kill_decrement_firing_count_if_died_while_firing" );
    self waittill( "death" );

    if ( isdefined( var_1 ) && isdefined( var_1.salvo_cooldown_min ) )
        wait(randomfloatrange( var_1.salvo_cooldown_min, var_1.salvo_cooldown_max ));
    else
        wait(randomfloatrange( 0.5, 1.5 ));

    level.vehicle_missile_launcher_count[var_0]--;
}

fire_missles_at_target_array( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = level.vehicle_missile_launcher[self.classname][var_2];
    var_5 = var_4.pre_fire_function;
    var_6 = var_4.post_fire_function;

    if ( !var_3 && isdefined( var_5 ) )
        self [[ var_5 ]]();

    if ( isdefined( self.missile_target_onscreen_guys_first ) && self.missile_target_onscreen_guys_first )
    {
        var_7 = getdvarint( "cg_fov" );
        var_8 = [];
        var_9 = [];

        foreach ( var_11 in var_0 )
        {
            if ( !isdefined( var_11 ) )
                continue;

            if ( !level.player worldpointinreticle_circle( var_11.origin, var_7, 500 ) )
            {
                var_8[var_8.size] = var_11;
                continue;
            }

            var_9[var_9.size] = var_11;
        }

        foreach ( var_11 in var_9 )
            walker_tank_handle_target( var_11, var_1 );

        foreach ( var_11 in var_8 )
            walker_tank_handle_target( var_11, var_1 );
    }
    else
    {
        foreach ( var_11 in var_0 )
            walker_tank_handle_target( var_11, var_1 );
    }

    if ( isdefined( var_6 ) )
        self [[ var_6 ]]();

    if ( isdefined( self.missile_auto_reload ) && self.missile_auto_reload )
        reload_launchers();
}

get_guy_or_backup_target_if_guy_died_or_dummy_target( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( isdefined( var_0 ) && var_2 )
    {
        var_3 = common_scripts\utility::spawn_tag_origin();
        return var_3;
    }
    else if ( isdefined( var_0 ) )
        return var_0;
    else
    {
        var_3 = common_scripts\utility::spawn_tag_origin();
        var_3.origin = var_1;
        return var_3;
    }
}

update_dummy_target_position( var_0, var_1, var_2 )
{
    var_1 endon( "death" );
    var_2 endon( "death" );
    var_0 endon( "death" );

    if ( !isdefined( var_2 ) || !isvalidmissile( var_0 ) || !isdefined( var_1 ) )
        return;

    var_3 = 0;
    var_4 = 0;
    var_5 = undefined;

    if ( isplayer( var_2 ) )
        var_3 = level.player geteye()[2] - var_2.origin[2];

    if ( randomfloat( 100 ) > 50 )
        var_5 = randomfloatrange( 30, 40 );
    else
        var_5 = -1 * randomfloatrange( 30, 40 );

    var_4 = randomfloatrange( -35, 5 );

    while ( isvalidmissile( var_0 ) )
    {
        var_6 = var_0 localtoworldcoords( ( 0, var_5, 0 ) );
        var_7 = var_6 - var_0.origin;
        var_8 = var_2.origin + ( var_7[0], var_7[1], var_3 + var_4 );

        if ( isplayer( var_2 ) )
            var_1.origin = var_8;
        else
        {
            var_1 unlink();
            var_1.origin = var_8;
            var_1 linkto( var_2 );
        }

        waitframe();
    }
}

walker_tank_handle_target( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = level.vehicle_missile_launcher[self.classname][var_2];
    var_4 = var_0.origin;
    var_5 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = randomintrange( 2, 4 );

    for ( var_6 = 0; var_6 < var_1; var_6++ )
    {
        if ( self.missiles_loaded_count == 0 )
            continue;

        var_7 = self.missiletags[self.missiles_loaded_count - 1];

        if ( var_0 == level.player && var_6 != 0 )
            var_5 = 1;

        thread walker_tank_missile_fire( var_7, var_4, var_2, var_0, var_5 );

        if ( isdefined( var_3.inter_salvo_delay ) )
        {
            wait(var_3.inter_salvo_delay);
            continue;
        }

        wait 0.1;
    }
}

walker_tank_missile_fire( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( self.classname == "script_vehicle_corpse" )
        self notify( "death" );

    if ( !isdefined( level.walker_tank_reload_ok ) )
        level.walker_tank_reload_ok = 1;

    var_5 = 0;
    var_6 = 0;
    var_7 = _offset_position_from_tag( "forward", var_0, 20 + var_6 );
    var_8 = _offset_position_from_tag( "forward", var_0, 200 + var_6 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_9 = level.vehicle_missile_launcher[self.classname][var_2];
    var_10 = magicbullet( var_9.missile_object, var_7, var_8 );

    if ( isdefined( var_10 ) && level.walker_tank_reload_ok )
    {
        self detach( var_9.missile_model, var_0 );
        self.missiletagsready[self.missiles_loaded_count - 1] = 0;
        self.missiles_loaded_count--;
    }

    if ( isdefined( var_9.homing_delay_min ) && isdefined( var_9.homing_delay_max ) )
        wait(randomfloatrange( var_9.homing_delay_min, var_9.homing_delay_max ));
    else
        wait(randomfloatrange( 0.5, 0.85 ));

    var_11 = get_guy_or_backup_target_if_guy_died_or_dummy_target( var_3, var_1, var_4 );

    if ( !isdefined( var_3 ) || var_11 != var_3 )
        var_5 = 1;

    var_12 = undefined;

    if ( isvalidmissile( var_10 ) && !is_abort_missile( var_9, self ) )
    {
        var_12 = missile_createattractorent( var_11, 50000, 2000, var_10, 1 );

        if ( var_4 )
            thread update_dummy_target_position( var_10, var_11, var_3 );

        if ( isdefined( var_10 ) && isvalidmissile( var_10 ) )
            var_10 missile_settargetent( var_11 );
    }

    while ( isdefined( var_10 ) )
    {
        waitframe();

        if ( isvalidmissile( var_10 ) && is_abort_missile( var_9, self ) )
            var_10 missile_cleartarget();
    }

    if ( var_5 )
        var_11 delete();

    if ( isdefined( var_12 ) )
        missile_deleteattractor( var_12 );
}

is_abort_missile( var_0, var_1 )
{
    if ( isdefined( var_0.missile_abort_if_owner_destroyed ) && var_0.missile_abort_if_owner_destroyed && !isdefined( var_1 ) )
        return 1;
    else
        return 0;
}

_offset_position_from_tag( var_0, var_1, var_2 )
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

reload_launchers( var_0 )
{
    if ( isdefined( var_0 ) )
    {

    }

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( self.missiletagsready ) )
        self.missiletagsready = [];

    for ( var_1 = 0; var_1 < self.missiletags.size; var_1++ )
    {
        if ( !isdefined( self.missiletagsready[var_1] ) || self.missiletagsready[var_1] == 0 )
        {
            self attach( level.vehicle_missile_launcher[self.classname][var_0].missile_model, self.missiletags[var_1], 1 );
            self.missiletagsready[var_1] = 1;
        }
    }

    self.missiles_loaded_count = self.missiletags.size;
}
