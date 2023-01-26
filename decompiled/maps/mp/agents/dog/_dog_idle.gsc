// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self._id_0C8D = "none";
    _id_802C();
    self._id_9363 += 2000;
    self._id_1436 = 0;
    self _meth_8390( self.origin );
    self _meth_8396( "face angle abs", self.angles );
    self _meth_8397( "anim deltas" );
    self _meth_8398( "gravity" );
    _id_9B6E();
}

_id_0140()
{
    if ( isdefined( self._id_6F77 ) )
    {
        self _meth_839A( self._id_6F77 );
        self._id_6F77 = undefined;
    }
}

_id_9B6E()
{
    self endon( "killanimscript" );
    self endon( "cancelidleloop" );

    for (;;)
    {
        var_0 = self._id_0C8D;
        var_1 = _id_29AB();

        if ( var_1 != self._id_0C8D )
            _id_3309( var_1 );

        _id_9AEC();

        switch ( self._id_0C8D )
        {
            case "idle_combat":
                wait 0.2;
                continue;
            case "idle_noncombat":
                if ( var_0 == "none" )
                {

                }
                else if ( gettime() > self._id_9363 )
                    _id_802C();

                wait 0.5;
                continue;
            default:
                wait 1;
                continue;
        }
    }
}

_id_29AB()
{
    if ( _id_847D() )
        return "idle_combat";
    else
        return "idle_noncombat";
}

_id_3309( var_0 )
{
    _id_344B( self._id_0C8D );
    self._id_0C8D = var_0;
    _id_6DA8();
}

_id_344B( var_0 )
{
    if ( isdefined( self._id_6F77 ) )
    {
        self _meth_839A( self._id_6F77 );
        self._id_6F77 = undefined;
    }
}

_id_6DA8()
{
    if ( self._id_0C8D == "idle_combat" )
        self _meth_83D2( "attack_idle" );
    else
        self _meth_83D2( "casual_idle" );
}

_id_9AEC()
{
    var_0 = undefined;

    if ( isdefined( self._id_0143 ) && distancesquared( self._id_0143.origin, self.origin ) < 1048576 )
        var_0 = self._id_0143;
    else if ( isdefined( self.owner ) && distancesquared( self.owner.origin, self.origin ) > 576 )
        var_0 = self.owner;

    if ( isdefined( var_0 ) )
    {
        var_1 = var_0.origin - self.origin;
        var_2 = vectortoangles( var_1 );

        if ( abs( angleclamp180( var_2[1] - self.angles[1] ) ) > 1 )
            _id_9934( var_2[1] );
    }
}

_id_847D()
{
    return isdefined( self._id_0143 ) && maps\mp\_utility::isreallyalive( self._id_0143 ) && distancesquared( self.origin, self._id_0143.origin ) < 1000000;
}

_id_413B( var_0 )
{
    if ( _id_847D() )
    {
        if ( var_0 < -135 || var_0 > 135 )
            return "attack_turn_180";
        else if ( var_0 < 0 )
            return "attack_turn_right_90";
        else
            return "attack_turn_left_90";
    }
    else if ( var_0 < -135 || var_0 > 135 )
        return "casual_turn_180";
    else if ( var_0 < 0 )
        return "casual_turn_right_90";
    else
        return "casual_turn_left_90";
}

_id_9934( var_0 )
{
    var_1 = self.angles[1];
    var_2 = angleclamp180( var_0 - var_1 );

    if ( -0.5 < var_2 && var_2 < 0.5 )
        return;

    if ( -10 < var_2 && var_2 < 10 )
    {
        _id_7605( var_0, 2 );
        return;
    }

    var_3 = _id_413B( var_2 );
    var_4 = self _meth_83D3( var_3, 0 );
    var_5 = getanimlength( var_4 );
    var_6 = distance2dsquared( var_4 );
    self _meth_8397( "anim angle delta" );

    if ( animhasnotetrack( var_4, "turn_begin" ) && animhasnotetrack( var_4, "turn_end" ) )
    {
        maps\mp\agents\_scriptedagents::_id_6A27( var_3, 0, "turn_in_place" );
        var_7 = getnotetracktimes( var_4, "turn_begin" );
        var_8 = getnotetracktimes( var_4, "turn_end" );
        var_9 = ( var_8[0] - var_7[0] ) * var_5;
        var_10 = angleclamp180( var_2 - var_6[1] );
        var_11 = abs( var_10 ) / var_9 / 20;
        var_11 = var_11 * 3.14159 / 180;
        var_12 = ( 0, angleclamp180( self.angles[1] + var_10 ), 0 );
        self._id_6F77 = self _meth_839B();
        self _meth_839A( var_11 );
        self _meth_8396( "face angle abs", var_12 );
        maps\mp\agents\_scriptedagents::_id_A0F7( "turn_in_place", "turn_end" );
        self _meth_839A( self._id_6F77 );
        self._id_6F77 = undefined;
        maps\mp\agents\_scriptedagents::_id_A0F7( "turn_in_place", "end" );
    }
    else
    {
        self._id_6F77 = self _meth_839B();
        var_11 = abs( angleclamp180( var_2 - var_6[1] ) ) / var_5 / 20;
        var_11 = var_11 * 3.14159 / 180;
        self _meth_839A( var_11 );
        var_12 = ( 0, angleclamp180( var_0 - var_6[1] ), 0 );
        self _meth_8396( "face angle abs", var_12 );
        maps\mp\agents\_scriptedagents::_id_6A27( var_3, 0, "turn_in_place" );
        self _meth_839A( self._id_6F77 );
        self._id_6F77 = undefined;
    }

    self _meth_8397( "anim deltas" );
    _id_6DA8();
}

_id_7605( var_0, var_1 )
{
    if ( abs( angleclamp180( var_0 - self.angles[1] ) ) <= var_1 )
        return;

    var_2 = ( 0, var_0, 0 );
    self _meth_8396( "face angle abs", var_2 );

    while ( angleclamp180( var_0 - self.angles[1] ) > var_1 )
        wait 0.1;
}

_id_802C()
{
    self._id_9363 = gettime() + 8000 + randomint( 5000 );
}

_id_2CE2( var_0 )
{
    self._id_14B3 = 1;
    self._id_03FC = 1;
    self._id_1436 = 1;
    var_1 = angleclamp180( var_0 - self.angles[1] );

    if ( var_1 > 0 )
        var_2 = 1;
    else
        var_2 = 0;

    self notify( "cancelidleloop" );
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::_id_6A27( "stand_pain", var_2, "stand_pain" );
    self._id_14B3 = 0;
    self._id_03FC = 0;
    self._id_1436 = 0;
    self _meth_8396( "face angle abs", self.angles );
    self._id_0C8D = "none";
    thread _id_9B6E();
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( self._id_1436 )
        return;

    var_10 = vectortoangles( var_7 );
    var_11 = var_10[1] - 180;
    _id_2CE2( var_11 );
}

_id_64AA( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( self._id_1436 )
        return;

    _id_2CE2( self.angles[1] + 180 );
}
