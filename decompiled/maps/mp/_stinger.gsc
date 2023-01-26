// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4E27()
{
    self._id_8E53 = undefined;
    self.stingertarget = undefined;
    self._id_8E42 = undefined;
    self._id_8E43 = undefined;
    thread _id_745D();
}

_id_745C()
{
    if ( !isdefined( self._id_8E56 ) )
        return;

    self._id_8E56 = undefined;
    self notify( "stop_javelin_locking_feedback" );
    self notify( "stop_javelin_locked_feedback" );
    self weaponlockfree();
    _id_4E27();
}

_id_745D()
{
    self endon( "disconnect" );
    self notify( "ResetStingerLockingOnDeath" );
    self endon( "ResetStingerLockingOnDeath" );

    for (;;)
    {
        self waittill( "death" );
        _id_745C();
    }
}

_id_8E32( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !self _meth_8214( var_0.origin, 65, 85 ) )
        return 0;

    if ( isdefined( level._id_06CE ) && self.stingertarget == level._id_06CE._id_6879 && !isdefined( level._id_06D1 ) )
        return 0;

    if ( isdefined( level.orbitalsupport_planemodel ) && self.stingertarget == level.orbitalsupport_planemodel && !isdefined( level._id_656C ) )
        return 0;

    return 1;
}

_id_5891()
{
    self endon( "faux_spawn" );
    self endon( "stop_javelin_locking_feedback" );

    for (;;)
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && isdefined( self.stingertarget ) && self.stingertarget == level.chopper.gunner )
            level.chopper.gunner playlocalsound( "missile_locking" );

        if ( isdefined( level._id_06D1 ) && isdefined( self.stingertarget ) && self.stingertarget == level._id_06CE._id_6879 )
            level._id_06D1 playlocalsound( "missile_locking" );

        self playlocalsound( "stinger_locking" );
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.6;
    }
}

_id_5890()
{
    self endon( "faux_spawn" );
    self endon( "stop_javelin_locked_feedback" );

    for (;;)
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && isdefined( self.stingertarget ) && self.stingertarget == level.chopper.gunner )
            level.chopper.gunner playlocalsound( "missile_locking" );

        if ( isdefined( level._id_06D1 ) && isdefined( self.stingertarget ) && self.stingertarget == level._id_06CE._id_6879 )
            level._id_06D1 playlocalsound( "missile_locking" );

        self playlocalsound( "stinger_locked" );
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.25;
    }
}

_id_5815( var_0 )
{
    var_1 = self geteye();

    if ( !isdefined( var_0 ) )
        return 0;

    var_2 = sighttracepassed( var_1, var_0.origin, 0, var_0 );

    if ( var_2 )
        return 1;

    var_3 = var_0 getpointinbounds( 1, 0, 0 );
    var_2 = sighttracepassed( var_1, var_3, 0, var_0 );

    if ( var_2 )
        return 1;

    var_4 = var_0 getpointinbounds( -1, 0, 0 );
    var_2 = sighttracepassed( var_1, var_4, 0, var_0 );

    if ( var_2 )
        return 1;

    return 0;
}

_id_8E3F( var_0 )
{

}

_id_885C()
{
    var_0 = 500;

    if ( _id_5815( self.stingertarget ) )
    {
        self._id_8E43 = 0;
        return 1;
    }

    if ( self._id_8E43 == 0 )
        self._id_8E43 = gettime();

    var_1 = gettime() - self._id_8E43;

    if ( var_1 >= var_0 )
    {
        _id_745C();
        return 0;
    }

    return 1;
}

_id_4105()
{
    var_0 = [];

    if ( maps\mp\_utility::invirtuallobby() )
        return var_0;

    if ( level.teambased )
    {
        if ( isdefined( level.chopper ) && ( level.chopper.team != self.team || isdefined( level.chopper.owner ) && level.chopper.owner == self ) )
            var_0[var_0.size] = level.chopper;

        if ( isdefined( level._id_06D1 ) && level._id_06D1.team != self.team )
            var_0[var_0.size] = level._id_06CE._id_6879;

        if ( isdefined( level._id_656C ) && level._id_656C.team != self.team )
            var_0[var_0.size] = level.orbitalsupport_planemodel;

        if ( isdefined( level._id_89A1 ) )
        {
            foreach ( var_2 in level._id_89A1 )
            {
                if ( isdefined( var_2 ) && var_2.team != self.team )
                    var_0[var_0.size] = var_2;
            }
        }

        if ( isdefined( level._id_46DC ) )
        {
            foreach ( var_5 in level._id_46DC )
            {
                if ( isdefined( var_5 ) && ( var_5.team != self.team || isdefined( var_5.owner ) && var_5.owner == self ) )
                    var_0[var_0.size] = var_5;
            }
        }

        if ( level.multiteambased )
        {
            for ( var_7 = 0; var_7 < level.teamnamelist.size; var_7++ )
            {
                if ( self.team != level.teamnamelist[var_7] )
                {
                    if ( level.uavmodels[level.teamnamelist[var_7]].size )
                    {
                        foreach ( var_9 in level.uavmodels[level.teamnamelist[var_7]] )
                            var_0[var_0.size] = var_9;
                    }
                }
            }
        }
        else if ( level.uavmodels[level.otherteam[self.team]].size )
        {
            foreach ( var_9 in level.uavmodels[level.otherteam[self.team]] )
                var_0[var_0.size] = var_9;
        }

        if ( isdefined( level.littlebirds ) )
        {
            foreach ( var_14 in level.littlebirds )
            {
                if ( isdefined( var_14 ) && ( var_14.team != self.team || isdefined( var_14.owner ) && var_14.owner == self ) )
                    var_0[var_0.size] = var_14;
            }
        }

        if ( isdefined( level.ugvs ) )
        {
            foreach ( var_17 in level.ugvs )
            {
                if ( isdefined( var_17 ) && ( var_17.team != self.team || isdefined( var_17.owner ) && var_17.owner == self ) )
                    var_0[var_0.size] = var_17;
            }
        }
    }
    else
    {
        if ( isdefined( level.chopper ) )
            var_0[var_0.size] = level.chopper;

        if ( isdefined( level._id_06D1 ) )
            var_0[var_0.size] = level._id_06CE._id_6879;

        if ( isdefined( level._id_46DC ) )
        {
            foreach ( var_5 in level._id_46DC )
            {
                if ( isdefined( var_5 ) )
                    var_0[var_0.size] = var_5;
            }
        }

        if ( level.uavmodels.size )
        {
            foreach ( var_22, var_9 in level.uavmodels )
            {
                if ( isdefined( var_9.owner ) && var_9.owner == self )
                    continue;

                var_0[var_0.size] = var_9;
            }
        }

        if ( isdefined( level.littlebirds ) )
        {
            foreach ( var_14 in level.littlebirds )
            {
                if ( !isdefined( var_14 ) )
                    continue;

                var_0[var_0.size] = var_14;
            }
        }

        if ( isdefined( level.ugvs ) )
        {
            foreach ( var_17 in level.ugvs )
            {
                if ( !isdefined( var_17 ) )
                    continue;

                var_0[var_0.size] = var_17;
            }
        }
    }

    return var_0;
}

stingerusageloop()
{
    if ( !isplayer( self ) )
        return;

    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    var_0 = 1000;
    _id_4E27();

    for (;;)
    {
        wait 0.05;

        if ( self playerads() < 0.95 )
        {
            _id_745C();
            continue;
        }

        var_1 = self getcurrentweapon();

        if ( issubstr( var_1, "stingerm7" ) )
            continue;

        if ( var_1 != "stinger_mp" && var_1 != "iw5_maaws_mp" )
        {
            _id_745C();
            continue;
        }

        self._id_8E56 = 1;

        if ( !isdefined( self._id_8E53 ) )
            self._id_8E53 = 0;

        _id_8E3F( self.stingertarget );

        if ( self._id_8E53 == 0 )
        {
            var_2 = _id_4105();

            if ( var_2.size == 0 )
                continue;

            var_3 = [];

            foreach ( var_5 in var_2 )
            {
                if ( !isdefined( var_5 ) )
                    continue;

                var_6 = self _meth_8214( var_5.origin, 65, 75 );

                if ( var_6 )
                    var_3[var_3.size] = var_5;
            }

            if ( var_3.size == 0 )
                continue;

            var_8 = sortbydistance( var_3, self.origin );

            if ( !_id_5815( var_8[0] ) )
                continue;

            thread _id_5891();
            self.stingertarget = var_8[0];
            self._id_8E42 = gettime();
            self._id_8E53 = 1;
            self._id_8E43 = 0;
        }

        if ( self._id_8E53 == 1 )
        {
            if ( !_id_8E32( self.stingertarget ) )
            {
                _id_745C();
                continue;
            }

            var_9 = _id_885C();

            if ( !var_9 )
                continue;

            var_10 = gettime() - self._id_8E42;

            if ( maps\mp\_utility::_hasperk( "specialty_fasterlockon" ) )
            {
                if ( var_10 < var_0 * 0.5 )
                    continue;
            }
            else if ( var_10 < var_0 )
                continue;

            self notify( "stop_javelin_locking_feedback" );
            thread _id_5890();
            self weaponlockfinalize( self.stingertarget );
            self._id_8E53 = 2;
        }

        if ( self._id_8E53 == 2 )
        {
            var_9 = _id_885C();

            if ( !var_9 )
                continue;

            if ( !_id_8E32( self.stingertarget ) )
            {
                _id_745C();
                continue;
            }
        }
    }
}
