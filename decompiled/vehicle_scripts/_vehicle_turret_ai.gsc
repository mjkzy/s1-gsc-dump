// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

vehicle_turret_default_ai()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );
    thread aim_at_my_attacker();
    thread vehicle_targeting();
    thread update_aiming();
    thread vehicle_firing();
}

vehicle_set_firing_disabled( var_0 )
{
    self.disable_firing = var_0;
}

vehicle_set_target_tracking_disabled( var_0 )
{
    self.disable_target_tracking = var_0;

    if ( var_0 )
    {
        self.ai_target = undefined;

        if ( 0 )
        {
            self.ai_target_force = undefined;
            self.ai_target_force_scripted = undefined;
            self.ai_target_force_damaged = undefined;
        }

        self _meth_8263();
    }
}

vehicle_set_threat_grenade_response( var_0 )
{
    self endon( "end_grenade_respose_function" );
    self.respond_to_threat_grenade = var_0;

    if ( !var_0 )
        self notify( "end_grenade_respose_function" );
    else
    {
        while ( var_0 )
        {
            level.player waittill( "threat_grenade_marking_started", var_1 );
            self.ai_target = undefined;
            self.ai_target_force_damaged = undefined;

            foreach ( var_3 in self.mgturret )
                self notify( "mgturret_acquire_new_target" );

            waitframe();
        }
    }
}

vehicle_turret_settings_shoot( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( self.vehicle_ai_settings ) )
        self.vehicle_ai_settings = spawnstruct();

    self.vehicle_ai_settings.min_fire_time = var_0;
    self.vehicle_ai_settings.max_fire_time = var_1;
    self.vehicle_ai_settings.shot_delay = var_2;
    self.vehicle_ai_settings.fire_delay = var_3;
    self.vehicle_ai_settings.avoid_players = isdefined( var_4 ) && var_4;
}

vehicle_turret_settings_target( var_0 )
{
    if ( !isdefined( self.vehicle_ai_settings ) )
        self.vehicle_ai_settings = spawnstruct();

    self.vehicle_ai_settings.update_target_time = var_0;
}

vehicle_set_forced_target( var_0 )
{
    if ( is_valid_target( var_0 ) && ( _func_2AE( var_0 ) || !_func_2AE( var_0 ) && !var_0 maps\_vehicle_code::is_corpse() ) )
    {
        self.ai_target_force_scripted = var_0;

        if ( !isdefined( self.disable_target_tracking ) || !self.disable_target_tracking )
        {
            if ( is_vector( var_0 ) )
                self _meth_8261( var_0 );
            else
                self _meth_8262( var_0 );
        }
    }
}

aim_at_my_attacker()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( isdefined( var_0 ) && var_0 > 0 && isdefined( var_1 ) && isai( var_1 ) && isalive( var_1 ) && !maps\_vehicle_code::attacker_isonmyteam( var_1 ) && !maps\_vehicle_code::attacker_troop_isonmyteam( var_1 ) )
        {
            self.ai_target_force_damaged = var_1;
            waittillframeend;
            self notify( "update_target" );
            self.ai_target_force_damaged maps\_utility::wait_for_notify_or_timeout( "death", 7 );
        }
    }
}

has_forced_target_changed( var_0, var_1 )
{
    if ( is_vector( var_0 ) && is_vector( var_1 ) )
        return var_0 != var_1;

    if ( is_vector( var_0 ) != is_vector( var_1 ) )
        return 1;

    return self.ai_target != self.ai_target_force;
}

vehicle_targeting()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );

    for (;;)
    {
        if ( isdefined( self.ai_target_force_scripted ) )
            self.ai_target_force = self.ai_target_force_scripted;
        else if ( isdefined( self.ai_target_force_damaged ) )
            self.ai_target_force = self.ai_target_force_damaged;

        if ( isdefined( self.disable_target_tracking ) && self.disable_target_tracking )
        {
            waitframe();
            continue;
        }

        if ( isdefined( self.ai_target_force ) )
        {
            if ( !is_valid_target( self.ai_target_force ) )
                self.ai_target_force = undefined;
            else if ( !isdefined( self.ai_target ) || has_forced_target_changed( self.ai_target_force, self.ai_target ) )
            {
                if ( isdefined( self.ai_target_force_scripted ) && self.ai_target_force == self.ai_target_force_scripted || isdefined( self.ai_target_force_damaged ) && self.ai_target_force == self.ai_target_force_damaged && !isdefined( self.ai_target ) )
                {
                    if ( isdefined( self.ai_target ) && !is_vector( self.ai_target ) )
                        self.ai_target.target_score = 0;

                    self.ai_target = self.ai_target_force;

                    if ( !is_vector( self.ai_target ) )
                        self.ai_target.target_score = -50;

                    self notify( "main_barrel_acquire_new_target" );
                }
            }
        }
        else
            self.ai_target = undefined;

        if ( isdefined( self.ai_target ) && ( isdefined( self.reset_forced_target_if_no_line_of_sight ) && self.reset_forced_target_if_no_line_of_sight ) && !turret_can_see_target( self.ai_target ) )
        {
            if ( isdefined( self.ai_target_force_scripted ) && self.ai_target == self.ai_target_force_scripted )
                self.ai_target_force_scripted = undefined;

            if ( isdefined( self.ai_target_force_damaged ) && self.ai_target == self.ai_target_force_damaged )
                self.ai_target_force_damaged = undefined;

            self.ai_target = undefined;
        }

        if ( !is_valid_target( self.ai_target ) )
        {
            self.ai_target = acquire_target();

            if ( isdefined( self.ai_target ) )
            {
                self.ai_target.target_score = -50;
                self notify( "main_barrel_acquire_new_target" );
            }
        }

        var_0 = 1.5;

        if ( isdefined( self.vehicle_ai_settings ) && isdefined( self.vehicle_ai_settings.update_target_time ) )
            var_0 = self.vehicle_ai_settings.update_target_time;

        maps\_utility::wait_for_notify_or_timeout( "update_target", var_0 );
    }
}

is_vector( var_0 )
{
    return _func_2AE( var_0 );
}

is_valid_target( var_0 )
{
    if ( is_vector( var_0 ) )
        return 1;

    return isdefined( var_0 ) && !_func_294( var_0 ) && ( !isdefined( var_0.health ) || isdefined( var_0.health ) && var_0.health >= 0 );
}

is_on_target( var_0 )
{
    var_1 = undefined;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( is_vector( var_0 ) )
        var_1 = var_0;
    else
        var_1 = var_0.origin + ( 0, 0, 50 );

    var_2 = var_1 - self gettagorigin( "tag_flash" );
    var_2 = vectornormalize( var_2 );
    var_3 = self gettagangles( "tag_flash" );
    var_4 = anglestoforward( var_3 );
    var_5 = vectordot( var_2, var_4 );

    if ( var_5 > 0.95 )
        return 1;

    return 0;
}

acquire_target()
{
    var_0 = undefined;

    if ( self.script_team == "allies" )
        var_0 = "axis";
    else if ( self.script_team == "axis" )
        var_0 = "allies";

    if ( isdefined( var_0 ) )
    {
        var_1 = _func_0D6( var_0 );

        if ( isdefined( var_1 ) && var_1.size > 0 )
        {
            var_2 = randomint( var_1.size );
            var_3 = undefined;
            var_4 = undefined;

            for ( var_5 = 0; var_5 < var_1.size; var_5++ )
            {
                var_6 = ( var_5 + var_2 ) % var_1.size;
                var_7 = var_1[var_6];

                if ( isdefined( var_7 ) && isalive( var_7 ) )
                {
                    var_8 = get_target_score( var_7 );

                    if ( !isdefined( var_3 ) || var_8 > var_3 )
                    {
                        var_3 = var_8;
                        var_4 = var_7;
                    }
                }
            }

            if ( isdefined( var_3 ) && var_3 > 0 )
                return var_4;
        }
    }

    return undefined;
}

get_target_score( var_0 )
{
    var_1 = 0;
    var_2 = 16384;
    var_3 = 2250000;
    var_4 = self gettagorigin( "tag_flash" );
    var_5 = distancesquared( var_4, var_0.origin );

    if ( var_5 < var_2 )
        return 0;

    if ( var_5 > var_3 )
        return 0;

    var_1 = 100 * ( 1 - ( var_5 - var_2 ) / ( var_3 - var_2 ) );

    if ( !turret_can_see_target( var_0 ) )
        return 0;

    if ( is_on_target( var_0 ) )
        var_1 += 50;

    if ( isdefined( var_0.target_score ) )
        var_1 += var_0.target_score;

    if ( isdefined( self.respond_to_threat_grenade ) && self.respond_to_threat_grenade && isdefined( var_0.detected ) && isdefined( var_0.detected["grenade"] ) )
        var_1 += 500;

    return var_1;
}

turret_can_see_target( var_0 )
{
    if ( is_vector( var_0 ) )
        return 1;

    var_1 = self gettagorigin( "tag_flash" );

    if ( sighttracepassed( var_1, var_0.origin + ( 0, 0, 40 ), 0, self, var_0 ) )
        return 1;
    else
        return 0;
}

update_aiming()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );

    for (;;)
    {
        var_0 = ( randomintrange( -128, 128 ), randomintrange( -128, 128 ), randomintrange( -12, 36 ) );

        if ( !is_vector( self.ai_target ) )
            var_0 += ( 0, 0, 50 );

        thread update_aim_offset( var_0 );
        maps\_utility::wait_for_notify_or_timeout( "main_barrel_acquire_new_target", 1.5 );
    }
}

update_aim_offset( var_0 )
{
    self notify( "kill_update_aim_offset" );
    self endon( "kill_update_aim_offset" );
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );
    self endon( "main_barrel_acquire_new_target" );
    var_1 = undefined;

    while ( isdefined( self.ai_target ) && is_valid_target( self.ai_target ) )
    {
        var_2 = var_0;

        if ( is_vector( self.ai_target ) )
        {
            self _meth_8261( self.ai_target + var_2 );
            var_1 = ( 0, 0, 0 );
        }
        else
        {
            if ( isdefined( self.ai_target.a ) && isdefined( self.ai_target.a.pose ) && self.ai_target.a.pose == "crouch" )
                var_2 = var_0 - ( 0, 0, 15 );

            self _meth_8262( self.ai_target, var_2 );
            var_1 = ( 0, 0, 50 );
        }

        var_0 -= var_1;
        var_0 *= 0.2;
        var_0 += var_1;
        wait 0.5;
    }
}

vehicle_firing()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "stop_vehicle_turret_ai" );
    var_0 = 1.5;

    if ( isdefined( self.vehicle_ai_settings ) && isdefined( self.vehicle_ai_settings.fire_delay ) )
        var_0 = self.vehicle_ai_settings.fire_delay;

    for (;;)
    {
        if ( isdefined( self.disable_firing ) && self.disable_firing )
        {
            waitframe();
            continue;
        }

        if ( isdefined( self.last_fire_time ) )
        {
            var_1 = ( gettime() - self.last_fire_time + var_0 * 1000 ) / 1000;

            if ( var_1 > 0 )
                wait(var_1);

            self.last_fire_time = undefined;
        }

        if ( is_valid_target( self.ai_target ) && turret_can_see_target( self.ai_target ) )
            fire_at_target();

        maps\_utility::wait_for_notify_or_timeout( "main_barrel_acquire_new_target", var_0 );
    }
}

fire_at_target()
{
    var_0 = 0;

    if ( isdefined( self.vehicle_ai_settings ) && isdefined( self.vehicle_ai_settings.min_fire_time ) )
    {
        var_1 = self.vehicle_ai_settings.min_fire_time;
        var_2 = self.vehicle_ai_settings.max_fire_time;
        var_3 = self.vehicle_ai_settings.shot_delay;
    }
    else
    {
        var_1 = 1;
        var_2 = 3;
        var_3 = 1.5;
    }

    var_4 = randomintrange( var_1, var_2 );

    while ( is_valid_target( self.ai_target ) && !is_on_target( self.ai_target ) )
        wait 0.5;

    while ( var_0 < var_4 && is_valid_target( self.ai_target ) )
    {
        if ( isdefined( self.vehicle_ai_settings ) && isdefined( self.vehicle_ai_settings.avoid_players ) && self.vehicle_ai_settings.avoid_players )
        {
            var_5 = self gettagorigin( "tag_flash" );
            var_6 = var_5 + anglestoforward( self gettagangles( "tag_flash" ) ) * 10000;

            if ( maps\_utility::shot_endangers_any_player( var_5, var_6 ) )
                break;
        }

        self _meth_8268();
        soundscripts\_snd::snd_message( "titan_walker_weapon_fire" );
        self.last_fire_time = gettime();
        var_0 += var_3;
        wait(var_3);
    }
}
