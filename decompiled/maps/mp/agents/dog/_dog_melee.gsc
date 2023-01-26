// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "death" );
    self endon( "killanimscript" );
    self._id_24C6 endon( "disconnect" );
    var_0 = self._id_24C6.origin - self.origin;
    var_1 = length( var_0 );
    var_2 = 1;

    if ( var_1 < self._id_0E47 )
    {
        var_3 = self.origin;
        var_2 = 0;
    }
    else
    {
        var_0 /= var_1;
        var_3 = self._id_24C6.origin - var_0 * self._id_0E47;
    }

    var_4 = 0;
    var_5 = self.origin + ( 0.0, 0.0, 30.0 );
    var_6 = self._id_24C6.origin + ( 0.0, 0.0, 30.0 );
    var_7 = physicstrace( var_5, var_6 );

    if ( distancesquared( var_7, var_6 ) > 1 )
        _id_5B84();
    else
    {
        if ( var_2 )
            var_8 = maps\mp\agents\_scriptedagents::_id_1AD2( self.origin, var_3 );
        else
            var_8 = 1;

        var_9 = undefined;

        if ( !var_8 )
            var_10 = 0;
        else
        {
            var_9 = _id_8489( self._id_24C6 );
            var_10 = isdefined( var_9 );
        }

        self._id_14B3 = 1;

        if ( var_10 )
        {
            _id_2C3B( var_9 );
            return;
        }

        _id_2D7E( var_3, var_8 );
    }
}

_id_0140()
{
    self _meth_8395( 1, 1 );
    self._id_14B3 = 0;
}

_id_401F()
{
    return "attack_run_and_jump";
}

_id_8489( var_0 )
{
    if ( !self._id_310E )
        return undefined;

    var_1 = 4;

    if ( !maps\mp\_utility::isgameparticipant( var_0 ) )
        return undefined;

    if ( _id_5183( var_0 ) )
        return undefined;

    if ( var_0 maps\mp\_utility::isjuggernaut() )
        return undefined;

    var_2 = self.origin - var_0.origin;

    if ( abs( var_2[2] ) > var_1 )
        return undefined;

    var_3 = vectornormalize( ( var_2[0], var_2[1], 0 ) );
    var_4 = anglestoforward( var_0.angles );
    var_5 = vectordot( var_4, var_3 );

    if ( var_5 > 0.707 )
    {
        var_6 = 0;
        var_7 = rotatevector( ( 1.0, 0.0, 0.0 ), var_0.angles );
    }
    else if ( var_5 < -0.707 )
    {
        var_6 = 1;
        var_7 = rotatevector( ( -1.0, 0.0, 0.0 ), var_0.angles );
    }
    else
    {
        var_8 = maps\mp\agents\dog\_dog_think::_id_2478( var_2, var_4 );

        if ( var_8 > 0 )
        {
            var_6 = 3;
            var_7 = rotatevector( ( 0.0, -1.0, 0.0 ), var_0.angles );
        }
        else
        {
            var_6 = 2;
            var_7 = rotatevector( ( 0.0, 1.0, 0.0 ), var_0.angles );
        }
    }

    if ( var_6 == 1 )
        var_9 = 128;
    else
        var_9 = 96;

    var_10 = var_0.origin - var_9 * var_7;
    var_11 = maps\mp\agents\_scriptedagents::_id_2F8E( var_10 );

    if ( !isdefined( var_11 ) )
        return undefined;

    if ( abs( var_11[2] - var_10[2] ) > var_1 )
        return undefined;

    if ( !self _meth_83E6( var_0.origin + ( 0.0, 0.0, 4.0 ), var_11 + ( 0.0, 0.0, 4.0 ), self.radius, self.height ) )
        return undefined;

    return var_6;
}

_id_2C3B( var_0 )
{
    var_1 = "attack_extended";
    _id_2CF2( self._id_24C6, self._id_24C6.health, "MOD_MELEE_DOG" );
    var_2 = self _meth_83D3( var_1, var_0 );
    thread _id_3597( var_2, self._id_24C6.origin, self._id_24C6.angles );
    maps\mp\agents\_scriptedagents::_id_6A27( var_1, var_0, "attack", "end" );
    self notify( "kill_stick" );
    self._id_24C6 = undefined;
    self _meth_8397( "anim deltas" );
    self unlink();
}

_id_3597( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "killanimscript" );
    self endon( "kill_stick" );
    wait 0.05;

    if ( isalive( self._id_24C6 ) )
        return;

    var_3 = self._id_24C6 _meth_842C();
    self linkto( var_3 );
    self _meth_8428( var_0, var_1, var_2 );
}

_id_2D7E( var_0, var_1 )
{
    var_2 = _id_401F();
    var_3 = 0;

    if ( !var_1 )
    {
        if ( self _meth_838E( self._id_24C6 ) )
        {
            var_4 = maps\mp\agents\_scriptedagents::_id_2F8E( self._id_24C6.origin );

            if ( isdefined( var_4 ) )
            {
                var_3 = 1;
                var_0 = var_4;
            }
            else
            {
                _id_5B84();
                return;
            }
        }
        else
        {
            _id_5B84();
            return;
        }
    }

    self._id_55BA = undefined;
    self._id_55BB = undefined;
    var_5 = self _meth_83D3( var_2, 0 );
    var_6 = getanimlength( var_5 );
    var_7 = getnotetracktimes( var_5, "dog_melee" );

    if ( var_7.size > 0 )
        var_8 = var_7[0] * var_6;
    else
        var_8 = var_6;

    self _meth_839F( self.origin, var_0, var_8 );
    thread _id_9B26( self._id_24C6, var_8, var_1 );
    maps\mp\agents\_scriptedagents::_id_6A27( var_2, 0, "attack", "dog_melee" );
    self notify( "cancel_updatelerppos" );
    var_9 = 0;

    if ( isdefined( self._id_24C6 ) )
        var_9 = self._id_24C6.health;

    if ( isdefined( self._id_5B83 ) )
        var_9 = self._id_5B83;

    if ( isdefined( self._id_24C6 ) )
        _id_2CF2( self._id_24C6, var_9, "MOD_IMPACT" );

    self._id_24C6 = undefined;

    if ( var_3 )
        self _meth_8395( 0, 1 );
    else
        self _meth_8395( 1, 1 );

    self _meth_8398( "gravity" );
    self _meth_8397( "anim deltas" );
    maps\mp\agents\_scriptedagents::_id_A0F7( "attack", "end" );
}

_id_9B26( var_0, var_1, var_2 )
{
    self endon( "killanimscript" );
    self endon( "death" );
    self endon( "cancel_updatelerppos" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    var_3 = var_1;
    var_4 = 0.05;

    for (;;)
    {
        wait(var_4);
        var_3 -= var_4;

        if ( var_3 <= 0 )
            break;

        var_5 = _id_4145( var_0, var_2 );

        if ( !isdefined( var_5 ) )
            break;

        self _meth_839F( self.origin, var_5, var_3 );
    }
}

_id_4145( var_0, var_1 )
{
    if ( !var_1 )
    {
        var_2 = maps\mp\agents\_scriptedagents::_id_2F8E( var_0.origin );
        return var_2;
    }
    else
    {
        var_3 = var_0.origin - self.origin;
        var_4 = length( var_3 );

        if ( var_4 < self._id_0E47 )
            return self.origin;
        else
        {
            var_3 /= var_4;
            var_5 = var_0.origin - var_3 * self._id_0E47;

            if ( maps\mp\agents\_scriptedagents::_id_1AD2( self.origin, var_5 ) )
                return var_5;
            else
                return undefined;
        }
    }
}

_id_5183( var_0 )
{
    if ( var_0 maps\mp\_riotshield::_id_473D() )
    {
        var_1 = self.origin - var_0.origin;
        var_2 = vectornormalize( ( var_1[0], var_1[1], 0 ) );
        var_3 = anglestoforward( var_0.angles );
        var_4 = vectordot( var_3, var_1 );

        if ( var_0 maps\mp\_riotshield::hasriotshieldequipped() )
        {
            if ( var_4 > 0.766 )
                return 1;
        }
        else if ( var_4 < -0.766 )
            return 1;
    }

    return 0;
}

_id_2CF2( var_0, var_1, var_2 )
{
    if ( _id_5183( var_0 ) )
        return;

    var_0 dodamage( var_1, self.origin, self, self, var_2 );
}

_id_5B84()
{
    self._id_55BA = self.origin;
    self._id_55BB = self._id_24C6.origin;
}
