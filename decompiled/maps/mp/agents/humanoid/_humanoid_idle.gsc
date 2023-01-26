// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self._id_0C8D = "none";
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
    self endon( "UpdateState" );

    for (;;)
    {
        var_0 = _id_29AB();

        if ( var_0 != self._id_0C8D )
        {
            _id_344B( self._id_0C8D );
            _id_3309( var_0 );
        }

        _id_9AEC();

        switch ( self._id_0C8D )
        {
            case "idle_combat":
                wait 0.2;
                continue;
            case "idle_noncombat":
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
    if ( isdefined( self.idlestateoverridefunc ) )
        return [[ self.idlestateoverridefunc ]]();
    else if ( _id_847D() )
        return "idle_combat";
    else
        return "idle_noncombat";
}

_id_3309( var_0 )
{
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
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( self._id_0C8D );
}

_id_9AEC()
{
    var_0 = undefined;

    if ( isdefined( self.targetofinterest ) && distancesquared( self.targetofinterest.origin, self.origin ) < 262144 )
        var_0 = self.targetofinterest;
    else if ( isdefined( self.distractiondrone ) && distancesquared( self.distractiondrone._id_4414, self.origin ) < 16384 )
        var_0 = self.distractiondrone;
    else if ( isdefined( self._id_0143 ) && distancesquared( self._id_0143.origin, self.origin ) < 1048576 )
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
    if ( !isdefined( self._id_0143 ) )
        return 0;

    if ( !maps\mp\_utility::isreallyalive( self._id_0143 ) )
        return 0;

    if ( distancesquared( self.origin, self._id_0143.origin ) >= 1000000 )
        return 0;

    return 1;
}

_id_413B( var_0 )
{
    var_1 = "idle_noncombat_turn";

    if ( _id_847D() )
        var_1 = "idle_combat_turn";

    var_2 = self _meth_83D6( var_1 );
    var_3 = 0;

    if ( var_2 == 3 )
    {
        if ( var_0 < -135 || var_0 > 135 )
            var_3 = 0;
        else if ( var_0 < 0 )
            var_3 = 1;
        else
            var_3 = 2;
    }

    return [ var_1, var_3 ];
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
    var_4 = var_3[0];
    var_5 = var_3[1];
    var_6 = self _meth_83D3( var_4, var_5 );
    var_7 = getanimlength( var_6 );
    var_8 = distance2dsquared( var_6 );
    self _meth_8397( "anim angle delta" );

    if ( animhasnotetrack( var_6, "turn_begin" ) && animhasnotetrack( var_6, "turn_end" ) )
    {
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_4, var_5, self.generalspeedratescale, "turn_in_place" );
        var_9 = getnotetracktimes( var_6, "turn_begin" );
        var_10 = getnotetracktimes( var_6, "turn_end" );
        var_11 = ( var_10[0] - var_9[0] ) * var_7;
        var_12 = angleclamp180( var_2 - var_8[1] );
        var_13 = abs( var_12 ) / var_11 / 20;
        var_13 = var_13 * 3.14159 / 180;
        var_14 = ( 0, angleclamp180( self.angles[1] + var_12 ), 0 );
        self._id_6F77 = self _meth_839B();
        self _meth_839A( var_13 );
        self _meth_8396( "face angle abs", var_14 );
        var_7 = getanimlength( self _meth_83D3( var_4, var_5 ) );
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "turn_in_place", "turn_end", var_7 );
        self _meth_839A( self._id_6F77 );
        self._id_6F77 = undefined;
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "turn_in_place", "end", var_7 );
    }
    else
    {
        self._id_6F77 = self _meth_839B();
        var_13 = abs( angleclamp180( var_2 - var_8[1] ) ) / var_7 / 20;
        var_13 = var_13 * 3.14159 / 180;
        self _meth_839A( var_13 );
        var_14 = ( 0, angleclamp180( var_0 - var_8[1] ), 0 );
        self _meth_8396( "face angle abs", var_14 );
        maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_4, var_5, self.generalspeedratescale, "turn_in_place" );
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
