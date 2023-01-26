// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_4E24()
{
    level._id_6557 = 0;
    level._id_6556 = 5;
    level._id_6553 = 0;
    level._id_6552 = 5;
    level._id_6555 = 0;
    level thread _id_2854();
    level.orbital_util_covered_volumes = getentarray( "orbital_node_covered", "targetname" );
}

_id_2854()
{
    var_0 = getentarray( "carepackage_clip", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();
}

_id_6CAA( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "goliath";

    var_1 = _id_6CA8( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    self._id_55C1 = undefined;
    return var_1;
}

_id_6CA9( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "goliath";

    var_2 = maps\mp\killstreaks\_aerial_utility::_id_3F85( "remoteMissileSpawn", "targetname" );
    var_3 = _id_6131( var_0, var_2, var_1 );

    if ( isdefined( var_3 ) )
        return var_3;
    else
        return _id_6130( var_0 );
}

_id_40EA( var_0 )
{
    return var_0.origin + ( 0.0, 0.0, 24000.0 );
}

_id_07DF( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "goliath";

    var_0._id_6576 = var_1;
    level._id_655A[level._id_655A.size] = var_0;
    thread _id_0546( var_0 );
}

_id_6D22( var_0 )
{
    var_1 = self._id_55C1;
    var_2 = self._id_55C0;

    if ( !isdefined( var_1 ) )
    {
        var_3 = anglestoforward( self getangles() );
        var_4 = self geteye();
        var_5 = var_4 + var_3 * 500;
        var_1 = bullettrace( var_4, var_5, 0, self, 1, 0, 0, 0, 0 );
    }

    self._id_55C1 = undefined;
    self._id_55C0 = undefined;
    var_6 = var_1["position"];

    if ( isdefined( var_2 ) )
    {
        var_7 = var_1["normal"];
        var_8 = var_7[2] > 0.8;

        if ( !var_8 )
            var_6 = var_2.origin;
    }

    var_9 = spawn( "script_model", var_6 + ( 0.0, 0.0, 5.0 ) );
    var_9.angles = ( -90.0, 0.0, 0.0 );
    var_9 setmodel( "tag_origin" );
    var_9 hide();
    var_9 showtoplayer( self );
    playfxontag( var_0, var_9, "tag_origin" );
    wait 5;
    var_9 delete();
}

_id_6CA8( var_0 )
{
    var_1 = anglestoforward( self getangles() );
    var_2 = self geteye();
    var_3 = var_2 + var_1 * 500;
    var_4 = bullettrace( var_2, var_3, 0, self, 1, 0, 0, 0, 0 );
    self._id_55C1 = var_4;
    var_5 = var_4["fraction"] == 1;

    if ( var_5 )
        return _id_6CA7( undefined, var_0 );

    var_6 = var_4["position"];
    var_7 = getnodesinradius( var_6, 128, 0, 60 );
    var_8 = var_7.size == 0;

    if ( var_8 )
        return _id_6CA7( undefined, var_0 );

    var_9 = var_4["normal"];
    var_10 = var_9[2] > 0.8;

    if ( !var_10 )
        return _id_6CA7( var_6, var_0 );

    if ( orbitalbadlandingcheck( var_6 ) )
        return _id_6CA7( var_6, var_0 );

    if ( var_0 == "goliath" )
    {
        if ( _id_426C( var_6 ) )
            return _id_6CA7( var_6, var_0 );
    }

    var_11 = _id_1B9F( var_6, self, var_0 );

    if ( !var_11 )
        return _id_6CA7( var_6, var_0 );

    if ( groundpositionoffedge( var_6, var_0 ) )
        return _id_6CA7( var_6, var_0 );

    var_13 = spawnstruct();
    var_13.origin = var_6;
    var_14 = maps\mp\killstreaks\_aerial_utility::_id_3F85( "remoteMissileSpawn", "targetname" );
    var_15 = _id_6131( var_13, var_14, var_0 );

    if ( !isdefined( var_15 ) )
        return _id_6CA7( var_6, var_0 );

    return var_13;
}

groundpositionoffedge( var_0, var_1 )
{
    if ( var_1 == "goliath" )
        var_2 = 41;
    else
        var_2 = 26;

    var_3 = ( var_2, 0, 0 );
    var_4 = -1 * var_3;
    var_5 = ( 0, var_2, 0 );
    var_6 = -1 * var_5;
    var_7 = ( 0.0, 0.0, -10.0 );
    var_8 = [ var_3, var_4, var_5, var_6 ];

    foreach ( var_10 in var_8 )
    {
        var_11 = var_0 + var_10;
        var_12 = var_0 + var_10 + var_7;
        var_13 = bullettracepassed( var_11, var_12, 0, undefined );

        if ( var_13 )
            return 1;
    }

    return 0;
}

_nodefindnewremotemissileorg( var_0, var_1, var_2 )
{
    var_3 = _id_612F( var_0, var_1, var_2 );

    if ( isdefined( var_3 ) )
        return _id_6132( var_0, var_1 );

    var_4 = _id_613A( var_0, var_2 );

    if ( isdefined( var_4 ) )
        return _id_6130( var_0 );
    else
    {

    }
}

_id_6131( var_0, var_1, var_2 )
{
    if ( _id_6133( var_0 ) )
    {
        if ( !_id_6135( var_0 ) )
            return _id_6132( var_0, var_1 );
        else
            return _id_6130( var_0 );
    }
    else
        return _nodefindnewremotemissileorg( var_0, var_1, var_2 );
}

_id_6134( var_0 )
{
    return isdefined( var_0.type );
}

_id_6135( var_0 )
{
    return _id_6134( var_0 ) && getchallengeid( var_0 ) && _func_2C9( var_0 ) == "up" || isdefined( var_0._id_13B1 );
}

_id_6133( var_0 )
{
    return _id_6134( var_0 ) && getchallengeid( var_0 ) || isdefined( var_0._id_13B1 ) || isdefined( var_0._id_13B0 );
}

_id_6130( var_0 )
{
    return _id_40EA( var_0 );
}

_id_613A( var_0, var_1 )
{
    var_2 = _id_40EA( var_0 );
    var_3 = _id_7324( var_2, var_0.origin, var_1 );

    if ( var_3 )
    {
        var_0._id_13B1 = var_2;
        return var_2;
    }
}

_id_6132( var_0, var_1 )
{
    var_2 = undefined;

    if ( _id_6134( var_0 ) && getchallengeid( var_0 ) )
    {
        var_3 = _func_2C9( var_0 );

        foreach ( var_5 in var_1 )
        {
            if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == var_3 )
                var_2 = var_5;
        }
    }
    else if ( isdefined( var_0._id_13B0 ) )
        var_2 = var_0._id_13B0;

    var_7 = vectornormalize( var_2.origin - var_0.origin );
    return var_0.origin + var_7 * 24000;
}

_id_612F( var_0, var_1, var_2 )
{
    var_1 = sortbydistance( var_1, var_0.origin );

    foreach ( var_4 in var_1 )
    {
        var_5 = _id_7324( var_4.origin, var_0.origin, var_2 );

        if ( var_5 )
        {
            var_0._id_13B0 = var_4;
            return var_4;
        }

        waitframe();
    }
}

_id_7324( var_0, var_1, var_2 )
{
    if ( level._id_6557 != gettime() )
    {
        level._id_6557 = gettime();
        level._id_6556 = 5;
    }

    if ( level._id_6556 <= 0 )
    {
        if ( level._id_6555 != gettime() )
        {
            waitframe();
            level._id_6555 = gettime();
        }

        level._id_6556 = 5;
    }

    level._id_6556--;
    var_3 = 26;

    if ( var_2 == "goliath" )
        var_3 = 41;

    return _func_2CA( var_0, var_1, var_3, 1 );
}

_id_612D( var_0, var_1 )
{
    if ( orbitalbadlandingcheck( var_0.origin ) )
        return 0;

    if ( isdefined( var_1 ) && var_1 == "goliath" )
    {
        if ( _id_426C( var_0.origin ) )
            return 0;
    }

    if ( getchallengeid( var_0 ) )
        return _func_2C9( var_0 ) != "none";
    else
        return _func_20C( var_0, 1 );
}

_id_1B9F( var_0, var_1, var_2 )
{
    var_3 = 100;

    if ( var_2 == "goliath" )
        var_4 = 41;
    else
        var_4 = 26;

    foreach ( var_6 in level._id_655A )
    {
        var_7 = var_4;

        if ( var_6._id_6576 == "goliath" )
            var_7 += 41;
        else
            var_7 += 26;

        var_8 = var_7 * var_7;
        var_9 = _func_220( var_6.origin, var_0 );

        if ( var_9 < var_8 )
            return 0;
    }

    if ( level._id_6553 != gettime() )
    {
        level._id_6553 = gettime();
        level._id_6552 = 5;
    }

    if ( level._id_6552 <= 0 )
    {
        if ( level._id_6555 != gettime() )
        {
            waitframe();
            level._id_6555 = gettime();
        }

        level._id_6552 = 5;
    }

    level._id_6552--;
    return _func_2AB( var_0 + ( 0.0, 0.0, 6.0 ), var_4, var_4 * 2, var_1, 0 );
}

_id_6CA7( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_2 = 300;
        var_3 = self geteye();
        var_4 = anglestoforward( self.angles );
        var_5 = var_3 + var_4 * var_2;
        var_6 = bullettrace( var_3, var_5, 0, self );
        var_0 = var_5;

        if ( var_6["fraction"] < 1 )
            var_0 = var_3 + var_4 * var_2 * var_6["fraction"];
    }

    var_7 = getclosestnodeinsight( var_0, 1 );
    var_8 = isdefined( var_7 );

    if ( var_8 )
        var_8 = _id_612D( var_7, var_1 ) && _id_1B9F( var_7.origin, self, var_1 );

    if ( var_8 )
        return var_7;

    var_9 = spawnstruct();
    var_9._id_5A53 = 5;
    var_9._id_5A41 = 20;
    var_9._id_62AD = 5;
    _id_6C9F( var_0, var_1, var_9 );
    var_10 = var_9._id_6072;

    if ( isdefined( var_10 ) )
        return var_10;

    if ( !isdefined( var_7 ) )
    {
        var_7 = _id_6CA4( 500, 100, self.origin, 0, 1, var_1 );

        if ( !isdefined( var_7 ) )
            var_7 = _id_6CA4( 500, 0, self.origin, 0, 0, var_1 );

        if ( !isdefined( var_7 ) )
            var_7 = self _meth_8387();
    }

    self._id_55C0 = var_7;

    if ( isdefined( var_7 ) )
        return _id_6C9E( var_7, var_1 );
}

orbitalbadlandingcheck( var_0 )
{
    if ( isdefined( level.orbital_util_covered_volumes ) && level.orbital_util_covered_volumes.size > 0 )
    {
        var_1 = 0;

        foreach ( var_3 in level.orbital_util_covered_volumes )
        {
            var_1 = _func_22A( var_0, var_3 );

            if ( var_1 )
                return 1;
        }
    }

    return 0;
}

_id_426C( var_0 )
{
    if ( isdefined( level.goliath_bad_landing_volumes ) )
    {
        foreach ( var_2 in level.goliath_bad_landing_volumes )
        {
            if ( _func_22A( var_0, var_2 ) )
                return 1;
        }
    }

    return 0;
}

_id_6C9F( var_0, var_1, var_2 )
{
    var_3 = 500;
    var_4 = 100;
    var_5 = _id_6CA0( var_0, var_4, var_3, var_1, var_2 );

    if ( !isdefined( var_5 ) && var_2._id_5A41 > 0 )
    {
        var_4 = 0;
        var_5 = _id_6CA0( var_0, var_4, var_3, var_1, var_2 );
    }

    var_2._id_6072 = var_5;
}

_id_6CA0( var_0, var_1, var_2, var_3, var_4 )
{
    while ( var_1 < var_2 && var_4._id_5A41 > 0 )
    {
        var_5 = _id_6CA4( var_2, var_1, var_0, 1, 1, var_3 );

        if ( var_4._id_62AD <= 0 && !_id_9490() )
        {
            waitframe();
            var_4._id_62AD = var_4._id_5A53;
        }

        if ( isdefined( var_5 ) )
        {
            var_4._id_62AD--;
            var_4._id_5A41--;
            var_6 = self geteye();
            var_7 = var_5.origin + ( 0.0, 0.0, 6.0 );
            var_8 = bullettrace( var_6, var_7, 0, self );
            var_9 = var_8["fraction"] == 1 && _id_1B9F( var_5.origin, self, var_3 );

            if ( var_9 )
                return var_5;

            var_1 = distance( var_0, var_5.origin ) + 1;
            continue;
        }

        var_1 = var_2 + 1;
    }
}

_id_6C9E( var_0, var_1 )
{
    var_2 = _id_1D13( var_0, self, var_1 );

    if ( isdefined( var_2 ) )
    {
        if ( orbitalbadlandingcheck( var_2.origin ) )
            return undefined;

        if ( var_1 == "goliath" )
        {
            if ( _id_426C( var_2.origin ) )
                return undefined;
        }

        return var_2;
    }
}

_id_9490()
{
    return level._id_6555 == gettime();
}

_id_1D13( var_0, var_1, var_2 )
{
    var_3 = 250000;
    var_4 = 20;
    var_0._id_5782 = 0;
    var_0._id_612E = 1;
    var_5 = spawnstruct();
    var_5._id_6139 = [];
    var_5._id_6138 = [];
    var_5._id_6138["" + var_0 _meth_8381()] = var_0;
    var_5._id_60D5 = getlinkednodes( var_0, 1 );
    _id_0804( var_5, 1, var_0, var_3, var_1, var_2 );
    var_6 = 0;

    for (;;)
    {
        var_7 = _id_403E( var_5 );

        if ( isdefined( var_7 ) )
        {
            var_6++;

            if ( !_id_1B9F( var_7.origin, var_1, var_2 ) )
            {
                var_7._id_612E = 1;
                var_5._id_6139["" + var_7 _meth_8381()] = undefined;
                var_5._id_6138["" + var_7 _meth_8381()] = var_7;
                var_8 = var_7._id_5782 + 1;

                if ( var_8 <= 6 )
                {
                    var_5._id_60D5 = getlinkednodes( var_7, 1 );
                    _id_0804( var_5, var_8, var_7, var_3, var_1, var_2 );
                }
            }
            else
            {
                _id_1E8C( var_5 );
                return var_7;
            }
        }
        else
        {
            _id_1E8C( var_5 );
            return;
        }

        if ( var_6 >= var_4 )
        {
            if ( !_id_9490() )
                waitframe();

            var_6 = 0;
        }
    }
}

_id_1E8C( var_0 )
{
    foreach ( var_2 in var_0._id_6139 )
    {
        var_2._id_5782 = undefined;
        var_2._id_612E = undefined;
    }

    foreach ( var_2 in var_0._id_6138 )
    {
        var_2._id_5782 = undefined;
        var_2._id_612E = undefined;
    }
}

_id_403E( var_0 )
{
    if ( var_0._id_6139.size == 0 )
        return;

    var_1 = undefined;
    var_2 = undefined;
    var_3 = getarraykeys( var_0._id_6139 );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_5 = var_0._id_6139[var_3[var_4]];

        if ( !isdefined( var_1 ) || var_5._id_5782 < var_2 )
        {
            var_1 = var_5;
            var_2 = var_5._id_5782;
        }
    }

    return var_1;
}

_id_0804( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    for ( var_6 = 0; var_6 < var_0._id_60D5.size; var_6++ )
    {
        var_7 = var_0._id_60D5[var_6];

        if ( !isdefined( var_7._id_612E ) )
        {
            var_8 = _id_612D( var_7, var_5 );

            if ( var_8 )
            {
                var_9 = distancesquared( var_7.origin, var_4.origin );
                var_8 = var_9 < var_3;
            }

            if ( !var_8 )
            {
                var_7._id_612E = 1;
                var_0._id_6138["" + var_7 _meth_8381()] = var_7;
            }
            else if ( !isdefined( var_7._id_5782 ) )
            {
                var_7._id_5782 = var_1;
                var_0._id_6139["" + var_7 _meth_8381()] = var_7;
            }
            else if ( var_7._id_5782 > var_1 )
                var_7._id_5782 = var_1;
        }
    }
}

_id_6CA4( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1500;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = self.origin;

    var_6 = 100;
    var_7 = var_1;
    var_8 = var_1 + var_6;

    if ( var_8 > var_0 )
        var_8 = var_0;

    while ( var_8 <= var_0 && var_7 < var_0 )
    {
        var_9 = _id_6CA5( var_8, var_7, var_2, var_3, var_4, var_5 );

        if ( isdefined( var_9 ) )
            return var_9;

        var_7 += var_6;
        var_8 += var_6;

        if ( var_8 > var_0 )
            var_8 = var_0;
    }
}

_id_6CA5( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 1;
    var_7 = getnodesinradiussorted( var_2, var_0, var_1, 120, "path" );

    for ( var_8 = 0; var_8 < var_7.size; var_8++ )
    {
        if ( var_3 )
            var_6 &= _id_612D( var_7[var_8], var_5 );

        if ( var_4 )
            var_6 &= _id_6D92( var_7[var_8].origin );

        if ( var_6 )
            return var_7[var_8];
    }
}

_id_6D92( var_0 )
{
    var_1 = cos( 60 );
    var_2 = vectornormalize( ( var_0[0], var_0[1], 0 ) - ( self.origin[0], self.origin[1], 0 ) );
    var_3 = anglestoforward( ( 0, self.angles[1], 0 ) );
    return vectordot( var_3, var_2 ) >= var_1;
}

_id_0546( var_0 )
{
    var_0 waittill( "death" );
    level._id_655A = common_scripts\utility::array_remove( level._id_655A, var_0 );
}

nodesetremotemissilenamewrapper( var_0, var_1 )
{
    var_2 = getnodesinradiussorted( var_0, 24, 0 );

    if ( var_2.size > 0 )
    {
        var_3 = var_2[0];
        _func_2D6( var_3, var_1 );
    }
    else
    {

    }
}
