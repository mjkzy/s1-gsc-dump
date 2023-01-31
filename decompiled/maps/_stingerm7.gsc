// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init( var_0 )
{
    level.stingerm7_lock_los = 1;
    level.stingerm7_lock_range = -1.0;

    if ( isdefined( var_0 ) )
        level.stinger_weapon = var_0;
    else
        level.stinger_weapon = "iw5_stingerm7_sp";

    precacheitem( level.stinger_weapon );
    precacheshader( "bls_ui_turret_targetacquired" );
    precacheshader( "bls_ui_turret_targetacquired_range" );
    precacheshader( "bls_ui_turret_targetlock_white" );

    foreach ( var_2 in level.players )
    {
        var_2 thread stingerm7_targeting();
        var_2 thread stingerm7_monitor_fire();
    }
}

stingerm7_targeting_remove_dead( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && isdefined( var_3.ent ) && isalive( var_3.ent ) && !stingerm7_get_target_ignore( var_3 ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

stingerm7_targeting_contains( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( var_4.ent == var_1 )
        {
            if ( isdefined( var_4.tag ) && isdefined( var_2 ) && var_4.tag == var_2 )
                return 1;

            if ( !isdefined( var_4.tag ) && !isdefined( var_2 ) )
                return 1;
        }
    }

    return 0;
}

stingerm7_targeting()
{
    self endon( "death" );
    self.stingerm7_info = spawnstruct();
    self.stingerm7_info.locked_targets = [];
    self.stingerm7_info.possible_targets = [];
    self.stingerm7_info.locking_time = 0;

    for (;;)
    {
        var_0 = self.stingerm7_info.locking_target;
        var_1 = level.stingerm7_lock_range;

        if ( self _meth_8311() == level.stinger_weapon && self _meth_8340() > 0.99 )
        {
            self.stingerm7_info.locked_targets = stingerm7_targeting_remove_dead( self.stingerm7_info.locked_targets );

            if ( isdefined( var_0 ) )
            {
                if ( !target_still_valid( var_0 ) )
                {
                    _func_09B( var_0.trackent );
                    var_0.trackent delete();
                    var_0.trackent = undefined;
                    self.stingerm7_info.locking_target = undefined;
                }
            }

            if ( !isdefined( var_0 ) )
            {
                self.stingerm7_info.locking_time = 0;

                if ( self.stingerm7_info.locked_targets.size < 4 )
                {
                    self.stingerm7_info.locking_target = get_best_locking_target();
                    var_0 = self.stingerm7_info.locking_target;

                    if ( isdefined( var_0 ) )
                    {
                        if ( !isdefined( var_0.trackent ) )
                        {
                            var_2 = stingerm7_get_target_tag( var_0 );
                            var_0.trackent = common_scripts\utility::spawn_tag_origin();

                            if ( isdefined( var_2 ) )
                                var_0.trackent _meth_804D( var_0.ent, var_2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                            else
                            {
                                var_0.trackent.origin = stingerm7_get_target_pos( var_0 );
                                var_0.trackent _meth_804D( var_0.ent );
                            }

                            var_0.trackent thread stinger_track_ent_cleanup( var_0.ent );
                        }

                        _func_09A( var_0.trackent );
                    }
                }
            }

            var_3 = 0;

            if ( isdefined( var_0 ) )
            {
                var_3 = var_1 < 0 || distancesquared( stingerm7_get_target_pos( var_0 ), level.player _meth_80A8() ) < var_1 * var_1;

                if ( !var_3 )
                {
                    if ( isdefined( var_0.trackent ) )
                        _func_09C( var_0.trackent, "bls_ui_turret_targetacquired_range" );

                    self.stingerm7_info.locking_time = 0;
                }
                else
                {
                    if ( isdefined( var_0.trackent ) )
                    {
                        if ( !isdefined( var_0.trackent.sound_played ) )
                        {
                            soundscripts\_snd_playsound::snd_play_2d( "wpn_stingerm7_locking" );
                            var_0.trackent.sound_played = 1;
                        }

                        _func_09C( var_0.trackent, "bls_ui_turret_targetacquired" );
                    }

                    self.stingerm7_info.locking_time += 0.05;
                }
            }

            if ( self.stingerm7_info.locking_time >= 0.5 && isdefined( var_0 ) && isdefined( var_0.trackent ) && self.stingerm7_info.locked_targets.size < 4 )
            {
                self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = var_0;
                soundscripts\_snd_playsound::snd_play_2d( "wpn_stingerm7_locked" );
                _func_09C( var_0.trackent, "bls_ui_turret_targetlock_white" );
                self.stingerm7_info.locking_target = undefined;
            }

            if ( self.stingerm7_info.locked_targets.size > 0 )
                self weaponlockfinalize( self.stingerm7_info.locked_targets[0].ent );
            else
                self weaponlockfree();
        }
        else
        {
            foreach ( var_5 in self.stingerm7_info.locked_targets )
            {
                if ( isdefined( var_5.trackent ) )
                {
                    _func_09B( var_5.trackent );
                    var_5.trackent delete();
                    var_5.trackent = undefined;
                }
            }

            foreach ( var_5 in self.stingerm7_info.possible_targets )
            {
                if ( isdefined( var_5.trackent ) )
                {
                    _func_09B( var_5.trackent );
                    var_5.trackent delete();
                    var_5.trackent = undefined;
                }
            }

            self.stingerm7_info.locked_targets = [];
            self.stingerm7_info.possible_targets = [];
            self.stingerm7_info.locking_target = undefined;
            self.stingerm7_info.locking_time = 0;
        }

        waitframe();
    }
}

stinger_ignore()
{
    self.stinger_ignore = 1;
    self notify( "stinger_ignore" );
}

stinger_track_ent_cleanup( var_0 )
{
    self notify( "stinger_track_ent_cleanup" );
    self endon( "stinger_track_ent_cleanup" );
    self endon( "death" );
    var_0 common_scripts\utility::waittill_any( "death", "stinger_ignore" );

    if ( isdefined( self ) )
        self delete();
}

stingerm7_monitor_fire()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( var_1 == level.stinger_weapon )
            stinger_fire( self, var_0 );
    }
}

stinger_fire( var_0, var_1 )
{
    var_1 delete();
    var_2 = [];
    var_0.stingerm7_info.locked_targets = stingerm7_targeting_remove_dead( self.stingerm7_info.locked_targets );
    var_3 = ( 5, -8, 5 );

    if ( var_0.stingerm7_info.locked_targets.size > 0 )
    {
        var_4 = var_0.stingerm7_info.locked_targets;

        for ( var_5 = 0; var_5 < 4; var_5++ )
        {
            if ( var_5 < var_4.size )
                var_6 = var_4[var_5];
            else
                var_6 = common_scripts\utility::random( var_4 );

            var_7 = var_0 getangles();
            var_8 = var_0 _meth_80A8();
            var_9 = anglestoforward( var_7 );
            var_9 = rotatevector( var_9, ( randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ), 0 ) );
            var_10 = var_8 + rotatevector( var_3, var_7 ) + var_9 * 10;
            var_11 = magicbullet( level.stinger_weapon, var_10, var_10 + var_9 * 1000, var_0 );
            soundscripts\_snd_playsound::snd_play_2d( "wpn_stingerm7_plr" );
            var_0 _meth_80AD( "heavy_1s" );

            if ( isdefined( var_11 ) )
            {
                var_11 thread stinger_delayed_lock( randomfloatrange( 0.25, 1.0 ), var_6 );
                var_11.lockedstingertarget = var_6.ent;
                var_2[var_2.size] = var_11;
            }

            wait 0.15;
        }

        level notify( "stinger_fired", var_0, var_2 );
        var_0 _meth_82F6( level.stinger_weapon, 0 );
    }
    else
        var_0 _meth_82F6( level.stinger_weapon, 4 );
}

stinger_delayed_lock( var_0, var_1 )
{
    self endon( "death" );
    var_1.ent endon( "death" );
    self.delayedlocktargetent = var_1.ent;
    self.delayedlocktargettag = var_1.tag;
    wait(var_0);

    if ( isdefined( self.delayedlocktargetent ) )
        self _meth_81D9( self.delayedlocktargetent, stingerm7_get_target_offset( undefined, self.delayedlocktargetent, self.delayedlocktargettag ) );

    self.delayedlocktargetent = undefined;
    self.delayedlocktargettag = undefined;
}

anystingermissilelockedon( var_0, var_1 )
{
    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3.lockedstingertarget ) && var_3.lockedstingertarget == var_1 )
            return 1;
    }

    return 0;
}

get_best_locking_target()
{
    if ( isdefined( level.stinger_no_ai ) && level.stinger_no_ai )
        var_0 = vehicle_getarray();
    else
        var_0 = common_scripts\utility::array_combine( _func_0D6( "axis" ), vehicle_getarray() );

    if ( isdefined( level.scripttargets ) )
        level.stinger_targets = common_scripts\utility::array_combine( var_0, level.scripttargets );
    else
        level.stinger_targets = var_0;

    var_1 = self _meth_80A8();
    var_2 = anglestoforward( self _meth_8036() );
    var_3 = undefined;
    var_4 = cos( 3 );

    foreach ( var_6 in level.stinger_targets )
    {
        if ( !is_enemy_target( var_6, self ) )
            continue;

        if ( isdefined( var_6.stinger_override_tags ) )
        {
            foreach ( var_8 in var_6.stinger_override_tags )
            {
                if ( !stingerm7_targeting_contains( self.stingerm7_info.possible_targets, var_6, var_8 ) )
                {
                    var_9 = spawnstruct();
                    var_9.ent = var_6;
                    var_9.tag = var_8;
                    self.stingerm7_info.possible_targets[self.stingerm7_info.possible_targets.size] = var_9;
                }
            }

            continue;
        }

        if ( !stingerm7_targeting_contains( self.stingerm7_info.possible_targets, var_6 ) )
        {
            var_9 = spawnstruct();
            var_9.ent = var_6;
            self.stingerm7_info.possible_targets[self.stingerm7_info.possible_targets.size] = var_9;
        }
    }

    self.stingerm7_info.possible_targets = stingerm7_targeting_remove_dead( self.stingerm7_info.possible_targets );

    foreach ( var_13 in self.stingerm7_info.possible_targets )
    {
        if ( !stingerm7_targeting_contains( self.stingerm7_info.locked_targets, var_13.ent, var_13.tag ) )
        {
            var_14 = stingerm7_get_target_pos( var_13 );
            var_15 = vectordot( vectornormalize( var_14 - var_1 ), var_2 );

            if ( var_15 > var_4 )
            {
                if ( !level.stingerm7_lock_los || bullettracepassed( var_1, var_14, 0, var_13 ) )
                {
                    var_3 = var_13;
                    var_4 = var_15;
                }
                else
                {
                    foreach ( var_17 in level.stinger_targets )
                    {
                        if ( !level.stingerm7_lock_los || bullettracepassed( var_1, var_14, 0, var_17 ) )
                        {
                            var_3 = var_13;
                            var_4 = var_15;
                        }
                    }
                }
            }
        }
    }

    return var_3;
}

target_still_valid( var_0 )
{
    if ( stingerm7_get_target_ignore( var_0 ) )
        return 0;

    var_1 = self _meth_80A8();
    var_2 = anglestoforward( self _meth_8036() );
    var_3 = stingerm7_get_target_pos( var_0 );

    if ( vectordot( vectornormalize( var_3 - var_1 ), var_2 ) > cos( 3 ) )
    {
        if ( !level.stingerm7_lock_los || bullettracepassed( var_1, var_3, 0, var_0 ) )
            return 1;
        else
        {
            foreach ( var_5 in level.stinger_targets )
            {
                if ( !level.stingerm7_lock_los || bullettracepassed( var_1, var_3, 0, var_5 ) )
                    return 1;
            }
        }
    }

    return 0;
}

is_enemy_target( var_0, var_1 )
{
    var_2 = undefined;

    if ( isdefined( var_0.stinger_ignore ) && var_0.stinger_ignore )
        return 0;

    if ( !isdefined( var_0.team ) && !isdefined( var_0.script_team ) )
        return 0;

    if ( isai( var_0 ) )
        var_2 = var_0.team;
    else if ( isdefined( var_0.script_team ) )
        var_2 = var_0.script_team;

    return isenemyteam( var_2, var_1.team );
}

stingerm7_get_target_tag( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    if ( isdefined( var_0.tag ) )
        return var_0.tag;

    if ( isai( var_0.ent ) )
        return "tag_eye";

    return undefined;
}

stingerm7_get_target_pos( var_0, var_1, var_2 )
{
    var_3 = var_1;
    var_4 = var_2;

    if ( !isdefined( var_3 ) )
        var_3 = var_0.ent;

    if ( !isdefined( var_4 ) )
        var_4 = stingerm7_get_target_tag( var_0 );

    if ( isdefined( var_4 ) )
        return var_3 gettagorigin( var_4 );

    return var_3 _meth_8216( 0, 0, 0 );
}

stingerm7_get_target_offset( var_0, var_1, var_2 )
{
    var_3 = var_1;

    if ( !isdefined( var_3 ) )
        var_3 = var_0.ent;

    return stingerm7_get_target_pos( var_0, var_1, var_2 ) - var_3.origin;
}

stingerm7_get_target_ignore( var_0, var_1 )
{
    var_2 = var_1;

    if ( !isdefined( var_2 ) )
        var_2 = var_0.ent;

    return isdefined( var_2 ) && isdefined( var_2.stinger_ignore ) && var_2.stinger_ignore;
}
