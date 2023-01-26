// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "death" );
    self endon( "killanimscript" );
    self._id_24C6 endon( "disconnect" );
    var_0 = distancesquared( self._id_24C6.origin, self.origin );
    var_1 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

    if ( maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked() )
        return maps\mp\agents\humanoid\_humanoid_melee::_id_5B84();

    doattackstandard( self._id_24C6, var_1.origin );
}

_id_0140()
{
    self _meth_8395( 1, 1 );
}

_id_401F()
{
    return "attack_run_and_jump";
}

doattackstandard( var_0, var_1 )
{
    var_2 = _id_401F();
    var_3 = self.nonmoveratescale;
    var_4 = 0;
    var_5 = 0;
    self._id_55BA = undefined;
    self._id_55BB = undefined;
    var_6 = randomint( self _meth_83D6( var_2 ) );
    var_7 = self _meth_83D3( var_2, var_6 );
    var_8 = getanimlength( var_7 );
    var_9 = getnotetracktimes( var_7, "dog_melee" );
    var_10 = var_8 / var_3 * 0.33;

    if ( var_9.size > 0 )
        var_10 = var_8 / var_3 * var_9[0];

    self _meth_8398( "gravity" );

    if ( var_5 )
        self _meth_8396( "face enemy" );
    else
        self _meth_8396( "face angle abs", ( 0, vectortoyaw( var_0.origin - self.origin ), 0 ) );

    self _meth_8397( "anim deltas" );
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_2, var_6, var_3 );

    if ( var_4 )
    {
        self _meth_8395( 0, 1 );
        self _meth_839F( self.origin, var_1, var_10 );
        childthread _id_9B26( var_0, var_10, 1, self.lungelerprange );
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "DoAttackStandard" );
    }
    else
        self _meth_8395( 1, 1 );

    wait(var_10);
    self notify( "cancel_updatelerppos" );
    self _meth_8397( "anim deltas" );
    self _meth_8395( 1, 1 );

    if ( var_4 )
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoAttackStandard" );

    if ( maps\mp\agents\humanoid\_humanoid_melee::attackshouldhit( var_0 ) )
    {
        self notify( "attack_hit", var_0, var_1 );
        var_11 = 0;

        if ( isdefined( var_0 ) )
            var_11 = var_0.health;

        if ( isdefined( self._id_5B83 ) )
            var_11 = self._id_5B83;

        if ( isalive( var_0 ) )
            maps\mp\agents\humanoid\_humanoid_melee::_id_2CF2( var_0, var_11, "MOD_IMPACT" );
    }
    else
        self notify( "attack_miss", var_0, var_1 );

    self.lastmeleepos = self.origin;
    var_12 = var_8 / var_3 - var_10;

    if ( var_12 > 0 )
        maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "attack_anim", "end", var_12 );

    self.lastmeleefinishtime = gettime();
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
        var_2 = maps\mp\zombies\_util::_id_2F8E( var_0.origin );
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

            if ( maps\mp\zombies\_util::_id_1AD2( self.origin, var_5 ) )
                return var_5;
            else
                return undefined;
        }
    }
}
