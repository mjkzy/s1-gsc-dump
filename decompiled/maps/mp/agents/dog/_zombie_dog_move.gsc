// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "killanimscript" );
    self _meth_8398( "gravity" );
    self._id_5154 = 1;
    _id_8D26();
    _id_2165();
}

_id_0140()
{
    self._id_5154 = undefined;
    _id_1AB1( undefined );
    self _meth_8395( 1, 1 );
}

_id_831F()
{
    thread maps\mp\agents\humanoid\_humanoid_move::_id_A029();
    thread waitforturn();
    thread _id_A032();
}

_id_2165()
{
    _id_831F();
    self _meth_8397( "code_move" );
    self _meth_8396( "face motion" );
    self _meth_8395( 1, 1 );
    _id_7FB0( self._id_02A6 );
}

_id_7FB0( var_0 )
{
    self notify( "zombiedogmove_endwait_setmoveanim" );
    self endon( "zombiedogmove_endwait_setmoveanim" );
    self endon( "killanimscript" );
    var_1 = randomint( self _meth_83D6( var_0 ) );
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_0, var_1, self.moveratescale );
}

_id_2D87( var_0 )
{
    self notify( "zombiedogmove_DoTurn" );
    self endon( "zombiedogmove_DoTurn" );
    self endon( "killanimscript" );
    var_1 = "turn_" + self._id_02A6;
    var_2 = vectortoangles( var_0 );
    var_3 = angleclamp180( var_2[1] - self.angles[1] );
    var_4 = self _meth_83D6( var_1 );

    if ( var_4 <= 0 )
    {
        thread waitforturn();
        return;
    }

    var_5 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable( var_3, var_4 );

    if ( var_5 == int( var_4 * 0.5 ) )
    {
        thread waitforturn();
        return;
    }

    var_6 = self _meth_83D3( var_1, var_5 );
    var_7 = getangledelta( var_6 );
    var_8 = ( 0, angleclamp180( var_2[1] - var_7 ), 0 );

    if ( !maps\mp\agents\humanoid\_humanoid_move::candoturnanim( var_6, var_8, var_5 == 3 || var_5 == 5, 1 ) )
    {
        thread waitforturn();
        return;
    }

    _id_1AB1( "turn" );
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", var_8 );
    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_1, var_5, self.moveratescale, "turn" );
    thread _id_2165();
}

waitforturn()
{
    self notify( "zombiedogmove_endwait_turn" );
    self endon( "zombiedogmove_endwait_turn" );
    self waittill( "path_dir_change", var_0 );
    childthread _id_2D87( var_0 );
}

_id_A032()
{
    self notify( "zombiedogmove_endwait_stop" );
    self endon( "zombiedogmove_endwait_stop" );
    self endon( "killanimscript" );
    self waittill( "stop_soon" );

    if ( !maps\mp\zombies\_util::_id_508F( self._id_12EE ) )
    {
        thread _id_A032();
        return;
    }

    var_0 = "stop_" + self._id_02A6;
    var_1 = self _meth_83D6( var_0 );

    if ( var_1 <= 0 )
    {
        thread _id_A032();
        return;
    }

    var_2 = 0;

    if ( isdefined( self._id_02BF ) )
        var_2 = self._id_02BF.angles[1] - self.angles[1];

    var_3 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable( var_2, var_1 );
    var_4 = self _meth_83D3( var_0, var_3 );
    var_5 = getmovedelta( var_4 );
    var_6 = getangledelta( var_4 );
    var_7 = self _meth_83E1();
    var_8 = var_7 - self.origin;

    if ( length( var_8 ) + 12 < length( var_5 ) )
    {
        thread _id_A032();
        return;
    }

    var_9 = _id_40F3();
    var_10 = _id_19C3( var_9._id_6E54, var_9.angles[1], var_5, var_6 );
    var_11 = maps\mp\zombies\_util::_id_2F8E( var_10 );

    if ( !isdefined( var_11 ) )
    {
        thread _id_A032();
        return;
    }

    if ( !maps\mp\zombies\_util::_id_1AD2( var_9._id_6E54, var_11 ) )
    {
        thread _id_A032();
        return;
    }

    _id_1AB1( "stop" );
    thread _id_A01F();
    thread waitforturnwhilestopping();

    if ( distancesquared( var_10, self.origin ) > 4 )
    {
        self _meth_838F( var_10 );
        thread _id_A00B();
        self waittill( "waypoint_reached" );
        self notify( "zombiedogmove_endwait_blockedwhilestopping" );
    }

    var_12 = var_7 - self.origin;
    var_13 = vectortoangles( var_12 );
    var_14 = ( 0, var_13[1] - var_6, 0 );
    var_15 = maps\mp\agents\_scripted_agent_anim_util::_id_3EFB( var_7 - self.origin, var_5 );
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", var_14, ( 0, var_13[1], 0 ) );
    self _meth_8395( var_15._id_A3A8, var_15.z );
    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_0, var_3, self.moveratescale, "move_stop" );
    self _meth_8390( self.origin );
}

_id_A01F()
{
    self notify( "zombiedogmove_endwait_pathsetwhilestopping" );
    self endon( "zombiedogmove_endwait_pathsetwhilestopping" );
    self endon( "killanimscript" );
    var_0 = self _meth_8391();
    self waittill( "path_set" );
    var_1 = self _meth_8391();

    if ( distancesquared( var_0, var_1 ) < 1 )
    {
        thread _id_A01F();
        return;
    }

    self notify( "zombiedogmove_endwait_stop" );
    self notify( "zombiedogmove_endwait_turnwhilestopping" );
    thread _id_2165();
}

waitforturnwhilestopping()
{
    self notify( "zombiedogmove_endwait_turnwhilestopping" );
    self endon( "zombiedogmove_endwait_turnwhilestopping" );
    self endon( "killanimscript" );
    self waittill( "path_dir_change", var_0 );
    self notify( "zombiedogmove_endwait_pathsetwhilestopping" );
    self notify( "zombiedogmove_endwait_stop" );
    thread _id_2D87( var_0 );
}

_id_A00B()
{
    self notify( "zombiedogmove_endwait_blockedwhilestopping" );
    self endon( "zombiedogmove_endwait_blockedwhilestopping" );
    self endon( "killanimscript" );
    self waittill( "path_blocked" );
    self notify( "zombiedogmove_endwait_stop" );
    self _meth_838F( undefined );
}

_id_1AB1( var_0 )
{
    var_1 = [ "turn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "turnwhilestopping", "setmoveanim", "modechange" ];
    var_2 = isdefined( var_0 );

    foreach ( var_4 in var_1 )
    {
        if ( var_2 && var_4 == var_0 )
            continue;

        self notify( "zombiedogmove_endwait_" + var_4 );
    }
}

_id_8D26()
{
    var_0 = self _meth_819D();

    if ( isdefined( var_0 ) )
        var_1 = var_0.origin;
    else
        var_1 = self _meth_83E1();

    if ( distancesquared( var_1, self.origin ) < 10000 )
        return;

    var_2 = self _meth_83E0();
    var_3 = vectortoangles( var_2 );
    var_4 = self getvelocity();

    if ( length2dsquared( var_4 ) > 16 )
    {
        var_4 = vectornormalize( var_4 );

        if ( vectordot( var_4, var_2 ) > 0.707 )
            return;
    }

    var_5 = "move_start";
    var_6 = angleclamp180( var_3[1] - self.angles[1] );
    var_7 = self _meth_83D6( var_5 );

    if ( var_7 == 0 )
        return;

    var_8 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable( var_6, var_7 );
    var_9 = self _meth_83D3( var_5, var_8 );
    var_10 = getmovedelta( var_9 );
    var_11 = rotatevector( var_10, self.angles ) + self.origin;

    if ( !maps\mp\zombies\_util::_id_1AD2( self.origin, var_11, 0 ) )
        return;

    var_12 = distance2dsquared( var_9 );
    self _meth_8397( "anim deltas" );

    if ( abs( var_8 - int( var_7 * 0.5 ) ) <= 1 )
        self _meth_8396( "face angle abs", ( 0, angleclamp180( var_3[1] - var_12[1] ), 0 ) );
    else
        self _meth_8396( "face angle abs", self.angles );

    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_5, var_8, self.moveratescale, "move_start", "code_move" );
}

_id_40F3()
{
    var_0 = spawnstruct();

    if ( isdefined( self._id_02BF ) )
    {
        var_0._id_6E54 = self._id_02BF.origin;
        var_0.angles = self._id_02BF.angles;
    }
    else
    {
        var_1 = self _meth_83E1();
        var_0._id_6E54 = var_1;
        var_0.angles = vectortoangles( self _meth_83E0() );
    }

    return var_0;
}

_id_19C3( var_0, var_1, var_2, var_3 )
{
    var_4 = var_1 - var_3;
    var_5 = ( 0, var_4, 0 );
    var_6 = anglestoforward( var_5 );
    var_7 = anglestoright( var_5 );
    var_8 = var_6 * var_2[0];
    var_9 = var_7 * var_2[1];
    return var_0 - var_8 + var_9;
}

_id_2CE2( var_0, var_1 )
{
    _id_1AB1( undefined );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "DoHitReaction" );
    var_2 = angleclamp180( var_0 - self.angles[1] );
    var_3 = "";
    var_4 = 0;

    if ( isdefined( var_1 ) && var_1 == "boost_slam_mp" && var_2 < 45 && randomfloat( 1 ) < 0.4 )
    {
        var_3 = "pain_knockback_front";
        var_4 = 0;
    }
    else
    {
        var_3 = "run_pain";

        if ( var_2 > 0 )
            var_4 = 1;
        else
            var_4 = 0;
    }

    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", self.angles );
    maps\mp\agents\_scripted_agent_anim_util::_id_6A25( var_3, var_4, self.nonmoveratescale, "pain_anim" );
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "DoHitReaction" );
    _id_2165();
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return;

    if ( isdefined( var_7 ) )
    {
        var_10 = vectortoangles( var_7 );
        var_11 = var_10[1] - 180;
        thread _id_2CE2( var_11, var_5 );
    }
}

_id_64AA( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
        return;

    _id_2CE2( self.angles[1] + 180 );
}
