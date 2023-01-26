// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

stingerm7_think()
{
    thread _id_8E4D();
    thread _id_8E4B();
}

_id_8E4D()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self._id_8E48 = spawnstruct();
    self._id_8E48._id_580A = [];
    self._id_8E48._id_5811 = 0;
    var_0 = 0;

    for (;;)
    {
        var_1 = self getcurrentweapon();
        var_2 = 0;

        if ( issubstr( var_1, "stingerm7" ) )
            var_2 = 1;
        else if ( issubstr( var_1, "dlcgun11loot2" ) )
            var_2 = 1;

        if ( var_2 && self playerads() > 0.99 )
        {
            var_0 = 1;

            if ( self._id_8E48._id_580A.size > 0 )
                _id_7363();

            self._id_8E48._id_580A = _id_0CF8( common_scripts\utility::array_removeundefined( self._id_8E48._id_580A ) );

            if ( isdefined( self._id_8E48._id_580F ) )
            {
                if ( !_id_5810( self._id_8E48._id_580F ) )
                {
                    self._id_8E48._id_580F = undefined;
                    self notify( "stop_javelin_locking_feedback" );
                }
            }

            if ( isdefined( self._id_8E48._id_580F ) )
                self._id_8E48._id_5811 += 0.05;
            else
            {
                self._id_8E48._id_5811 = 0;

                if ( self._id_8E48._id_580A.size < 4 )
                {
                    self._id_8E48._id_580F = _id_3CD7();

                    if ( isdefined( self._id_8E48._id_580F ) )
                        thread _id_580E();
                }
            }

            if ( self._id_8E48._id_5811 >= 1 && isdefined( self._id_8E48._id_580F ) && self._id_8E48._id_580A.size < 4 )
            {
                self notify( "stop_javelin_locking_feedback" );
                self._id_8E48._id_580A[self._id_8E48._id_580A.size] = self._id_8E48._id_580F;
                thread _id_5807();
                self._id_8E48._id_580F = undefined;
            }

            if ( self._id_8E48._id_580A.size > 0 )
                self weaponlockfinalize( self._id_8E48._id_580A[0] );
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
            self._id_8E48._id_580A = [];

            if ( isdefined( self._id_8E48._id_580F ) )
                self._id_8E48._id_580F = undefined;

            self._id_8E48._id_5811 = 0;
        }

        wait 0.05;
    }
}

_id_8E4B()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( issubstr( var_1, "stingerm7" ) || issubstr( var_1, "dlcgun11loot2" ) )
            thread _id_8E37( self, var_0, var_1 );
    }
}

_id_8E37( var_0, var_1, var_2 )
{
    var_3 = ( 0.0, 0.0, 0.0 );
    var_4 = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_1 ) )
    {
        var_3 = var_1.origin;
        var_4 = var_1.angles;
        var_1 delete();
    }
    else
        return;

    var_0._id_8E48._id_580A = _id_0CF8( common_scripts\utility::array_removeundefined( self._id_8E48._id_580A ) );
    var_5 = [];

    for ( var_6 = 0; var_6 < 4; var_6++ )
    {
        var_7 = var_4 + _id_7117( 20, 20, 20 );
        var_8 = anglestoforward( var_7 );
        var_9 = magicbullet( var_2, var_3, var_3 + var_8, var_0 );
        var_9.owner = var_0;

        if ( var_0._id_8E48._id_580A.size > 0 )
        {
            var_10 = undefined;

            if ( var_6 < var_0._id_8E48._id_580A.size )
                var_10 = var_0._id_8E48._id_580A[var_6];
            else
                var_10 = var_0._id_8E48._id_580A[randomint( var_0._id_8E48._id_580A.size )];

            var_9 missile_settargetent( var_10, _id_8E45( var_10 ) );
            var_9.lockedstingertarget = var_10;
        }

        var_5[var_5.size] = var_9;
    }

    level notify( "stinger_fired", var_0, var_5 );
    var_0 setweaponammoclip( var_2, 0 );
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

_id_3CD7()
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

        if ( var_8 maps\mp\killstreaks\_aerial_utility::_id_9D6F() )
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
            if ( var_8 maps\mp\killstreaks\_aerial_utility::_id_9D6F() )
                continue;

            if ( level.teambased && var_8.team == self.team )
                continue;

            var_6[var_6.size] = var_8;
        }
    }

    var_15 = maps\mp\killstreaks\_killstreaks::getaerialkillstreakarray( var_0 );
    var_16 = common_scripts\utility::array_combine( var_1, var_6 );
    var_16 = common_scripts\utility::array_combine( var_16, var_15 );

    if ( isdefined( level._id_8E41 ) )
        var_16 = common_scripts\utility::array_combine( var_16, [[ level._id_8E41 ]]( self ) );

    var_17 = self geteye();
    var_18 = anglestoforward( self getangles() );
    var_19 = undefined;
    var_20 = cos( 5 );

    foreach ( var_22 in var_16 )
    {
        if ( !common_scripts\utility::array_contains( self._id_8E48._id_580A, var_22 ) )
        {
            var_23 = _id_8E46( var_22 );
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

_id_5810( var_0 )
{
    var_1 = self geteye();
    var_2 = anglestoforward( self getangles() );
    var_3 = _id_8E46( var_0 );

    if ( ( isplayer( var_0 ) || isbot( var_0 ) || isdefined( level.ishorde ) && level.ishorde && isagent( var_0 ) ) && !maps\mp\_utility::isreallyalive( var_0 ) )
        return 0;

    if ( vectordot( vectornormalize( var_3 - var_1 ), var_2 ) > cos( 5 ) )
    {
        if ( !1 || bullettracepassed( var_1, var_3, 0, var_0 ) )
            return 1;
    }

    return 0;
}

_id_7363()
{
    for ( var_0 = 0; var_0 <= self._id_8E48._id_580A.size; var_0++ )
    {
        if ( isdefined( self._id_8E48._id_580A[var_0] ) && isdefined( self._id_8E48._id_580A[var_0].origin ) )
        {
            if ( !isdefined( self._id_8E48._id_580A[var_0]._id_855F ) )
                self._id_8E48._id_580A[var_0]._id_855F = -1;

            var_1 = ( 0.0, 0.0, 0.0 );

            if ( isplayer( self._id_8E48._id_580A[var_0] ) || isbot( self._id_8E48._id_580A[var_0] ) )
                var_1 = ( 0.0, 0.0, 64.0 );

            if ( self _meth_8215( self._id_8E48._id_580A[var_0].origin + var_1, 50, 400, 200 ) )
            {
                if ( bullettracepassed( self geteye(), self._id_8E48._id_580A[var_0].origin + var_1, 0, self._id_8E48._id_580A[var_0] ) )
                {
                    self._id_8E48._id_580A[var_0]._id_855F = -1;
                    continue;
                }
            }

            if ( self._id_8E48._id_580A[var_0]._id_855F == -1 )
            {
                self._id_8E48._id_580A[var_0]._id_855F = gettime();
                continue;
            }

            if ( gettime() - self._id_8E48._id_580A[var_0]._id_855F >= 500 )
            {
                self._id_8E48._id_580A[var_0]._id_855F = -1;
                self._id_8E48._id_580A[var_0] = undefined;
            }
        }
    }
}

_id_8E46( var_0 )
{
    if ( isdefined( var_0._id_40F1 ) )
        return var_0 [[ var_0._id_40F1 ]]();

    return var_0 getpointinbounds( 0, 0, 0 );
}

_id_8E45( var_0 )
{
    return _id_8E46( var_0 ) - var_0.origin;
}

_id_580E()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "stop_javelin_locking_feedback" );

    for (;;)
    {
        if ( isdefined( level._id_89A1 ) )
        {
            foreach ( var_1 in level._id_89A1 )
            {
                if ( isdefined( var_1.owner ) && isdefined( var_1.player ) && isdefined( self._id_8E48._id_580F ) && self._id_8E48._id_580F == var_1 )
                    var_1.owner playlocalsound( "wpn_stingerm7_enemy_locked" );
            }
        }

        if ( isdefined( level._id_656C ) && isdefined( self._id_8E48._id_580F ) && self._id_8E48._id_580F == level.orbitalsupport_planemodel )
            level._id_656C playlocalsound( "wpn_stingerm7_enemy_locked" );

        self playlocalsound( "wpn_stingerm7_locking" );
        self playrumbleonentity( "heavygun_fire" );
        wait 0.6;
    }
}

_id_5807()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );
    self endon( "stop_javelin_locked_feedback" );

    for (;;)
    {
        if ( isdefined( level._id_89A1 ) )
        {
            foreach ( var_1 in level._id_89A1 )
            {
                if ( isdefined( var_1.owner ) && isdefined( var_1.player ) && isdefined( self._id_8E48._id_580A ) && _id_511D( self._id_8E48._id_580A, var_1 ) )
                    var_1.owner playlocalsound( "wpn_stingerm7_enemy_locked" );
            }
        }

        if ( isdefined( level._id_656C ) && isdefined( self._id_8E48._id_580A ) && _id_511D( self._id_8E48._id_580A, level.orbitalsupport_planemodel ) )
            level._id_656C playlocalsound( "wpn_stingerm7_enemy_locked" );

        self playlocalsound( "wpn_stingerm7_locked" );
        self playrumbleonentity( "heavygun_fire" );
        wait 0.25;
    }
}

_id_0CF8( var_0 )
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

_id_7117( var_0, var_1, var_2 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_1 ) - var_1 * 0.5, randomfloat( var_2 ) - var_2 * 0.5 );
}

_id_511D( var_0, var_1 )
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
