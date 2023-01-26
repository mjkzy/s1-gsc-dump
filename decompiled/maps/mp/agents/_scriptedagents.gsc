// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_02DF( var_0, var_1 )
{
    if ( isdefined( self._id_648D ) )
        self [[ self._id_648D ]]( var_0, var_1 );
}

_id_02DE()
{
    self notify( "killanimscript" );
}

_id_6A28( var_0, var_1, var_2, var_3 )
{
    _id_6A27( var_0, 0, var_1, var_2, var_3 );
}

_id_6A27( var_0, var_1, var_2, var_3, var_4 )
{
    self _meth_83D2( var_0, var_1 );

    if ( !isdefined( var_3 ) )
        var_3 = "end";

    _id_A0F7( var_2, var_3, var_0, var_1, var_4 );
}

_id_6A25( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self _meth_83D2( var_0, var_1, var_2 );

    if ( !isdefined( var_4 ) )
        var_4 = "end";

    _id_A0F7( var_3, var_4, var_0, var_1, var_5 );
}

_id_A0F7( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = gettime();
    var_6 = undefined;
    var_7 = undefined;

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_7 = getanimlength( self _meth_83D3( var_2, var_3 ) );

    for (;;)
    {
        self waittill( var_0, var_8 );

        if ( isdefined( var_7 ) )
            var_6 = ( gettime() - var_5 ) * 0.001 / var_7;

        if ( !isdefined( var_7 ) || var_6 > 0 )
        {
            if ( var_8 == var_1 || var_8 == "end" || var_8 == "anim_will_finish" || var_8 == "finish" )
                break;
        }

        if ( isdefined( var_4 ) )
            [[ var_4 ]]( var_8, var_2, var_3, var_6 );
    }
}

_id_6A23( var_0, var_1 )
{
    _id_6A26( var_0, 0, var_1 );
}

_id_6A26( var_0, var_1, var_2 )
{
    self _meth_83D2( var_0, var_1 );
    wait(var_2);
}

_id_6A24( var_0, var_1, var_2, var_3 )
{
    self _meth_83D2( var_0, var_1, var_2 );
    wait(var_3);
}

_id_3EFB( var_0, var_1, var_2 )
{
    var_3 = length2d( var_0 );
    var_4 = var_0[2];
    var_5 = length2d( var_1 );
    var_6 = var_1[2];
    var_7 = 1;
    var_8 = 1;

    if ( isdefined( var_2 ) && var_2 )
    {
        var_9 = ( var_1[0], var_1[1], 0 );
        var_10 = vectornormalize( var_9 );

        if ( vectordot( var_10, var_0 ) < 0 )
            var_7 = 0;
        else if ( var_5 > 0 )
            var_7 = var_3 / var_5;
    }
    else if ( var_5 > 0 )
        var_7 = var_3 / var_5;

    if ( abs( var_6 ) > 0.001 && var_6 * var_4 >= 0 )
        var_8 = var_4 / var_6;

    var_11 = spawnstruct();
    var_11._id_A3A8 = var_7;
    var_11.z = var_8;
    return var_11;
}

_id_3EEF( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 10;

    if ( var_0 < 0 )
        return int( ceil( ( 180 + var_0 - var_1 ) / 45 ) );
    else
        return int( floor( ( 180 + var_0 + var_1 ) / 45 ) );
}

_id_2F8E( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 18;

    var_2 = var_0 + ( 0, 0, var_1 );
    var_3 = var_0 + ( 0, 0, var_1 * -1 );
    var_4 = self _meth_83E5( var_2, var_3, self.radius, self.height, 1 );

    if ( abs( var_4[2] - var_2[2] ) < 0.1 )
        return undefined;

    if ( abs( var_4[2] - var_3[2] ) < 0.1 )
        return undefined;

    return var_4;
}

_id_1AD2( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 6;

    if ( !isdefined( var_3 ) )
        var_3 = self.radius;

    var_4 = ( 0.0, 0.0, 1.0 ) * var_2;
    var_5 = var_0 + var_4;
    var_6 = var_1 + var_4;
    return self _meth_83E6( var_5, var_6, var_3, self.height - var_2, 1 );
}

_id_4149( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 6;

    var_3 = ( 0.0, 0.0, 1.0 ) * var_2;
    var_4 = var_0 + var_3;
    var_5 = var_1 + var_3;
    return self _meth_83E5( var_4, var_5, self.radius + 4, self.height - var_2, 1 );
}

_id_40BE( var_0 )
{
    var_1 = getmovedelta( var_0 );
    var_2 = self _meth_81B0( var_1 );
    var_3 = _id_4149( self.origin, var_2 );
    var_4 = distance( self.origin, var_3 );
    var_5 = distance( self.origin, var_2 );
    return min( 1.0, var_4 / var_5 );
}

_id_77C7( var_0, var_1, var_2, var_3 )
{
    var_4 = _id_40A1( var_0 );
    _id_77C6( var_0, var_4, var_1, var_2, var_3 );
}

_id_77C4( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = _id_40A1( var_0 );
    _id_77C5( var_0, var_5, var_1, var_2, var_3, var_4 );
}

_id_77C5( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self _meth_83D2( var_0, var_1, var_2 );
    _id_77C6( var_0, var_1, var_3, var_4, var_5 );
}

_id_77C6( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self _meth_83D3( var_0, var_1 );
    var_6 = _id_40BE( var_5 );
    self _meth_8395( var_6, 1.0 );
    _id_6A27( var_0, var_1, var_2, var_3, var_4 );
    self _meth_8395( 1.0, 1.0 );
}

_id_40A1( var_0 )
{
    var_1 = self _meth_83D6( var_0 );
    return randomint( var_1 );
}

_id_3EF0( var_0 )
{
    var_1 = vectortoangles( var_0 );
    var_2 = angleclamp180( var_1[1] - self.angles[1] );
    return _id_3EEF( var_2 );
}
