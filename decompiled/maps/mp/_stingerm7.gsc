// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

stingerm7_think()
{
    thread stingerm7_targeting();
    thread stingerm7_monitor_fire();
}

stingerm7_targeting()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self.stingerm7_info = spawnstruct();
    self.stingerm7_info.locked_targets = [];
    self.stingerm7_info.locking_time = 0;
    var_0 = 0;

    for (;;)
    {
        var_1 = self _meth_8311();
        var_2 = 0;

        if ( issubstr( var_1, "stingerm7" ) )
            var_2 = 1;
        else if ( issubstr( var_1, "dlcgun11loot2" ) )
            var_2 = 1;

        if ( var_2 && self _meth_8340() > 0.99 )
        {
            var_0 = 1;

            if ( self.stingerm7_info.locked_targets.size > 0 )
                remove_invalid_locks();

            self.stingerm7_info.locked_targets = array_remove_dead( common_scripts\utility::array_removeundefined( self.stingerm7_info.locked_targets ) );

            if ( isdefined( self.stingerm7_info.locking_target ) )
            {
                if ( !locking_target_still_valid( self.stingerm7_info.locking_target ) )
                {
                    self.stingerm7_info.locking_target = undefined;
                    self notify( "stop_javelin_locking_feedback" );
                }
            }

            if ( isdefined( self.stingerm7_info.locking_target ) )
                self.stingerm7_info.locking_time += 0.05;
            else
            {
                self.stingerm7_info.locking_time = 0;

                if ( self.stingerm7_info.locked_targets.size < 4 )
                {
                    self.stingerm7_info.locking_target = get_best_locking_target();

                    if ( isdefined( self.stingerm7_info.locking_target ) )
                        thread locking_feedback();
                }
            }

            if ( self.stingerm7_info.locking_time >= 1 && isdefined( self.stingerm7_info.locking_target ) && self.stingerm7_info.locked_targets.size < 4 )
            {
                self notify( "stop_javelin_locking_feedback" );
                self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;
                thread locked_feedback();
                self.stingerm7_info.locking_target = undefined;
            }

            if ( self.stingerm7_info.locked_targets.size > 0 )
                self weaponlockfinalize( self.stingerm7_info.locked_targets[0] );
            else
            {
                self weaponlockfree();
                self notify( "stop_javelin_locked_feedback" );
            }
        }
        else if ( var_0 == 1 )
        {
            var_0 = 0;
            self weaponlockfree();
            self notify( "stop_javelin_locking_feedback" );
            self notify( "stop_javelin_locked_feedback" );
            self.stingerm7_info.locked_targets = [];

            if ( isdefined( self.stingerm7_info.locking_target ) )
                self.stingerm7_info.locking_target = undefined;

            self.stingerm7_info.locking_time = 0;
        }

        wait 0.05;
    }
}

stingerm7_monitor_fire()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( issubstr( var_1, "stingerm7" ) || issubstr( var_1, "dlcgun11loot2" ) )
            thread stinger_fire( self, var_0, var_1 );
    }
}

stinger_fire( var_0, var_1, var_2 )
{
    var_3 = ( 0, 0, 0 );
    var_4 = ( 0, 0, 0 );

    if ( isdefined( var_1 ) )
    {
        var_3 = var_1.origin;
        var_4 = var_1.angles;
        var_1 delete();
    }
    else
        return;

    var_0.stingerm7_info.locked_targets = array_remove_dead( common_scripts\utility::array_removeundefined( self.stingerm7_info.locked_targets ) );
    var_5 = [];

    for ( var_6 = 0; var_6 < 4; var_6++ )
    {
        var_7 = var_4 + random_vector( 20, 20, 20 );
        var_8 = anglestoforward( var_7 );
        var_9 = magicbullet( var_2, var_3, var_3 + var_8, var_0 );
        var_9.owner = var_0;

        if ( var_0.stingerm7_info.locked_targets.size > 0 )
        {
            var_10 = undefined;

            if ( var_6 < var_0.stingerm7_info.locked_targets.size )
                var_10 = var_0.stingerm7_info.locked_targets[var_6];
            else
                var_10 = var_0.stingerm7_info.locked_targets[randomint( var_0.stingerm7_info.locked_targets.size )];

            var_9 _meth_81D9( var_10, stingerm7_get_target_offset( var_10 ) );
            var_9.lockedstingertarget = var_10;
        }

        var_5[var_5.size] = var_9;
    }

    level notify( "stinger_fired", var_0, var_5 );
    var_0 _meth_82F6( var_2, 0 );
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
    var_0 = maps\mp\_utility::getotherteam( self.team );
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( level.teambased && var_3.team == self.team )
            continue;

        if ( !maps\mp\_utility::isreallyalive( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    var_5 = vehicle_getarray();
    var_6 = [];

    foreach ( var_8 in var_5 )
    {
        if ( !isdefined( var_8.owner ) )
            continue;

        if ( var_8 maps\mp\killstreaks\_aerial_utility::vehicleiscloaked() )
            continue;

        if ( level.teambased && var_8.owner.team == self.team )
            continue;

        var_6[var_6.size] = var_8;
    }

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        foreach ( var_11 in level.agentarray )
        {
            if ( level.teambased && var_11.team == self.team )
                continue;

            if ( !maps\mp\_utility::isreallyalive( var_11 ) )
                continue;

            var_1[var_1.size] = var_11;
        }

        foreach ( var_8 in var_5 )
        {
            if ( var_8 maps\mp\killstreaks\_aerial_utility::vehicleiscloaked() )
                continue;

            if ( level.teambased && var_8.team == self.team )
                continue;

            var_6[var_6.size] = var_8;
        }
    }

    var_15 = maps\mp\killstreaks\_killstreaks::getaerialkillstreakarray( var_0 );
    var_16 = common_scripts\utility::array_combine( var_1, var_6 );
    var_16 = common_scripts\utility::array_combine( var_16, var_15 );

    if ( isdefined( level.stingerlockonentsfunc ) )
        var_16 = common_scripts\utility::array_combine( var_16, [[ level.stingerlockonentsfunc ]]( self ) );

    var_17 = self _meth_80A8();
    var_18 = anglestoforward( self getangles() );
    var_19 = undefined;
    var_20 = cos( 5 );

    foreach ( var_22 in var_16 )
    {
        if ( !common_scripts\utility::array_contains( self.stingerm7_info.locked_targets, var_22 ) )
        {
            var_23 = stingerm7_get_target_pos( var_22 );
            var_24 = vectordot( vectornormalize( var_23 - var_17 ), var_18 );

            if ( var_24 > var_20 )
            {
                var_25 = undefined;
                var_26 = !1;

                if ( !var_26 )
                {
                    var_27 = bullettracepassed( var_17, var_23, 0, var_22 );

                    if ( var_27 )
                        var_26 = 1;
                }

                if ( var_26 )
                {
                    var_19 = var_22;
                    var_20 = var_24;
                }
            }
        }
    }

    return var_19;
}

locking_target_still_valid( var_0 )
{
    var_1 = self _meth_80A8();
    var_2 = anglestoforward( self getangles() );
    var_3 = stingerm7_get_target_pos( var_0 );

    if ( ( isplayer( var_0 ) || isbot( var_0 ) || isdefined( level.ishorde ) && level.ishorde && isagent( var_0 ) ) && !maps\mp\_utility::isreallyalive( var_0 ) )
        return 0;

    if ( vectordot( vectornormalize( var_3 - var_1 ), var_2 ) > cos( 5 ) )
    {
        if ( !1 || bullettracepassed( var_1, var_3, 0, var_0 ) )
            return 1;
    }

    return 0;
}

remove_invalid_locks()
{
    for ( var_0 = 0; var_0 <= self.stingerm7_info.locked_targets.size; var_0++ )
    {
        if ( isdefined( self.stingerm7_info.locked_targets[var_0] ) && isdefined( self.stingerm7_info.locked_targets[var_0].origin ) )
        {
            if ( !isdefined( self.stingerm7_info.locked_targets[var_0].sight_lost_time ) )
                self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;

            var_1 = ( 0, 0, 0 );

            if ( isplayer( self.stingerm7_info.locked_targets[var_0] ) || isbot( self.stingerm7_info.locked_targets[var_0] ) )
                var_1 = ( 0, 0, 64 );

            if ( self _meth_8215( self.stingerm7_info.locked_targets[var_0].origin + var_1, 50, 400, 200 ) )
            {
                if ( bullettracepassed( self _meth_80A8(), self.stingerm7_info.locked_targets[var_0].origin + var_1, 0, self.stingerm7_info.locked_targets[var_0] ) )
                {
                    self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;
                    continue;
                }
            }

            if ( self.stingerm7_info.locked_targets[var_0].sight_lost_time == -1 )
            {
                self.stingerm7_info.locked_targets[var_0].sight_lost_time = gettime();
                continue;
            }

            if ( gettime() - self.stingerm7_info.locked_targets[var_0].sight_lost_time >= 500 )
            {
                self.stingerm7_info.locked_targets[var_0].sight_lost_time = -1;
                self.stingerm7_info.locked_targets[var_0] = undefined;
            }
        }
    }
}

stingerm7_get_target_pos( var_0 )
{
    if ( isdefined( var_0.getstingertargetposfunc ) )
        return var_0 [[ var_0.getstingertargetposfunc ]]();

    return var_0 _meth_8216( 0, 0, 0 );
}

stingerm7_get_target_offset( var_0 )
{
    return stingerm7_get_target_pos( var_0 ) - var_0.origin;
}

locking_feedback()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "stop_javelin_locking_feedback" );

    for (;;)
    {
        if ( isdefined( level.spawnedwarbirds ) )
        {
            foreach ( var_1 in level.spawnedwarbirds )
            {
                if ( isdefined( var_1.owner ) && isdefined( var_1.player ) && isdefined( self.stingerm7_info.locking_target ) && self.stingerm7_info.locking_target == var_1 )
                    var_1.owner playlocalsound( "wpn_stingerm7_enemy_locked" );
            }
        }

        if ( isdefined( level.orbitalsupport_player ) && isdefined( self.stingerm7_info.locking_target ) && self.stingerm7_info.locking_target == level.orbitalsupport_planemodel )
            level.orbitalsupport_player playlocalsound( "wpn_stingerm7_enemy_locked" );

        self playlocalsound( "wpn_stingerm7_locking" );
        self _meth_80AD( "heavygun_fire" );
        wait 0.6;
    }
}

locked_feedback()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "stop_javelin_locked_feedback" );

    for (;;)
    {
        if ( isdefined( level.spawnedwarbirds ) )
        {
            foreach ( var_1 in level.spawnedwarbirds )
            {
                if ( isdefined( var_1.owner ) && isdefined( var_1.player ) && isdefined( self.stingerm7_info.locked_targets ) && isinarray( self.stingerm7_info.locked_targets, var_1 ) )
                    var_1.owner playlocalsound( "wpn_stingerm7_enemy_locked" );
            }
        }

        if ( isdefined( level.orbitalsupport_player ) && isdefined( self.stingerm7_info.locked_targets ) && isinarray( self.stingerm7_info.locked_targets, level.orbitalsupport_planemodel ) )
            level.orbitalsupport_player playlocalsound( "wpn_stingerm7_enemy_locked" );

        self playlocalsound( "wpn_stingerm7_locked" );
        self _meth_80AD( "heavygun_fire" );
        wait 0.25;
    }
}

array_remove_dead( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isalive( var_3 ) )
            continue;

        var_1[var_1.size] = var_3;
    }

    return var_1;
}

random_vector( var_0, var_1, var_2 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_1 ) - var_1 * 0.5, randomfloat( var_2 ) - var_2 * 0.5 );
}

isinarray( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
    {
        foreach ( var_3 in var_0 )
        {
            if ( var_3 == var_1 )
                return 1;
        }
    }

    return 0;
}
