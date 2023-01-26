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
    thread _id_A029();
    thread waitforturn();
    thread _id_A032();
    thread waitfordodge();
    thread waitforleap();
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
    self notify( "humanoidmove_endwait_setmoveanim" );
    self endon( "humanoidmove_endwait_setmoveanim" );
    self endon( "killanimscript" );
    self.inpainmoving = 0;
    self.inturnanim = 0;
    var_1 = randomint( self _meth_83D6( var_0 ) );
    maps\mp\agents\_scripted_agent_anim_util::set_anim_state( var_0, var_1, self.moveratescale );
}

setmoveanimpain( var_0, var_1, var_2 )
{
    self notify( "humanoidmove_endwait_setmoveanim" );
    self endon( "humanoidmove_endwait_setmoveanim" );
    self endon( "killanimscript" );

    if ( maps\mp\agents\humanoid\_humanoid_util::_id_50EA() )
        return;

    var_3 = "pain_" + self._id_02A6;

    if ( var_2 )
        var_3 += "_lower";

    var_4 = angleclamp180( var_0 - self.angles[1] );
    var_5 = self _meth_83D6( var_3 );
    var_6 = maps\mp\agents\humanoid\_humanoid_util::getpainangleindexvariable( var_4, var_5 );
    self.inpainmoving = 1;
    self _meth_8397( "code_move" );
    self _meth_8396( "face motion" );
    self _meth_8395( 1, 1 );
    var_7 = self.moveratescale;

    if ( self._id_02A6 == "walk" )
        var_7 -= 0.2;
    else if ( self._id_02A6 == "run" )
        var_7 -= 0.1;

    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_3, var_6, var_7, "pain_anim" );
    thread _id_2165();
}

_id_A029()
{
    self notify( "humanoidmove_endwait_modechange" );
    self endon( "humanoidmove_endwait_modechange" );
    self endon( "killanimscript" );
    var_0 = self._id_02A6;
    var_1 = self.moveratescale;

    for (;;)
    {
        var_2 = 0;

        if ( isdefined( self._id_02A6 ) && ( !isdefined( var_0 ) || var_0 != self._id_02A6 ) )
            var_2 = 1;

        if ( isdefined( self.moveratescale ) && ( !isdefined( var_1 ) || var_1 != self.moveratescale ) )
            var_2 = 1;

        if ( var_2 )
        {
            thread _id_7FB0( self._id_02A6 );
            var_0 = self._id_02A6;
            var_1 = self.moveratescale;
        }

        wait 0.05;
    }
}

_id_2D87( var_0 )
{
    self notify( "humanoidmove_DoTurn" );
    self endon( "humanoidmove_DoTurn" );
    self endon( "killanimscript" );
    var_1 = "turn_" + self._id_02A6;

    if ( self._id_02A6 == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2 )
        var_1 += "_v2";

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

    if ( !candoturnanim( var_6, var_8, var_5 == 3 || var_5 == 5, 1 ) )
    {
        var_1 += "_quick";
        var_9 = 0;

        if ( self _meth_8567( var_1 ) && maps\mp\zombies\_util::getzombieslevelnum() >= 2 )
        {
            var_6 = self _meth_83D3( var_1, var_5 );
            var_7 = getangledelta( var_6 );
            var_8 = ( 0, angleclamp180( var_2[1] - var_7 ), 0 );

            if ( candoturnanim( var_6, var_8, var_5 == 3 || var_5 == 5, 2 ) )
                var_9 = 1;
        }

        if ( !var_9 )
        {
            thread waitforturn();
            return;
        }
    }

    _id_1AB1( "turn" );
    self.inturnanim = 1;
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", var_8 );
    var_10 = self.moveratescale;

    if ( !maps\mp\agents\humanoid\_humanoid_util::_id_50EA() && self._id_02A6 == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() < 2 )
    {
        var_10 = level.moveratescalemod["run"][1];
        var_10 += self.moveratescale - level.moveratescalemod["sprint"][0];
    }

    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_1, var_5, var_10, "turn" );
    thread _id_2165();
}

candoturnanim( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.5;
    var_5 = getnotetracktimes( var_0, "turn_extent" );

    if ( var_5.size == 1 )
        var_4 = var_5[0];

    var_6 = 1.0;
    var_7 = getnotetracktimes( var_0, "finish" );

    if ( var_7.size == 0 )
        var_7 = getnotetracktimes( var_0, "end" );

    if ( var_7.size == 1 )
        var_6 = var_7[0];

    var_8 = getmovedelta( var_0, 0.0, var_4 );
    var_9 = getmovedelta( var_0, 0.0, var_6 );
    var_10 = self.origin;
    var_11 = rotatevector( var_8, var_1 ) + var_10;
    var_12 = rotatevector( var_9, var_1 ) + var_10;

    if ( !maps\mp\zombies\_util::_id_1AD2( var_11, var_12, 0 ) )
        return 0;

    var_13 = self.radius;

    if ( !var_2 )
        var_13 = self.radius / 2;

    if ( !maps\mp\zombies\_util::_id_1AD2( var_10, var_11, 0, var_13 ) )
        return 0;

    return 1;
}

waitforturn()
{
    self notify( "humanoidmove_endwait_turn" );
    self endon( "humanoidmove_endwait_turn" );
    self endon( "killanimscript" );
    self waittill( "path_dir_change", var_0 );

    if ( maps\mp\zombies\_util::_id_508F( self.inairforleap ) )
        thread waitforturn();

    if ( maps\mp\zombies\_util::_id_508F( self.inpainmoving ) )
        thread waitforturn();

    childthread _id_2D87( var_0 );
}

_id_A032()
{
    self notify( "humanoidmove_endwait_stop" );
    self endon( "humanoidmove_endwait_stop" );
    self endon( "killanimscript" );
    self waittill( "stop_soon" );

    if ( maps\mp\zombies\_util::_id_508F( self.inairforleap ) )
        thread _id_A032();

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

    if ( var_0 == "stop_sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2 )
        var_0 += "_v2";

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
        self notify( "humanoidmove_endwait_blockedwhilestopping" );
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

waitfordodge()
{
    self notify( "humanoidmove_endwait_dodge" );
    self endon( "humanoidmove_endwait_dodge" );
    self endon( "killanimscript" );
    maps\mp\zombies\_util::waittill_enter_game();

    while ( isalive( self ) )
    {
        self waittill( "damage", var_0, var_1 );
        wait 0.05;

        if ( !isalive( self ) )
            return;

        if ( !maps\mp\zombies\_util::_id_508F( self.dodgeenabled ) )
            return;

        if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
            continue;

        if ( !isdefined( var_1 ) || !isalive( var_1 ) || !isplayer( var_1 ) )
            continue;

        var_2 = var_1.origin - self.origin;
        var_3 = anglestoforward( self.angles );

        if ( vectordot( vectornormalize( var_2 ), var_3 ) < 0.7 )
            continue;

        var_4 = lengthsquared( var_2 );

        if ( var_4 > 1000000 || var_4 < 40000 )
            continue;

        if ( isdefined( self.dodgelast ) && gettime() - self.dodgelast < self.dodgedebouncems )
            continue;

        self.dodgelast = gettime();

        if ( randomfloat( 1.0 ) < self.dodgechance )
        {
            wait(randomfloatrange( 0.1, 0.3 ));

            if ( !isalive( self ) )
                return;

            if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
                continue;

            _id_1AB1( "dodge" );
            self.lungelast = gettime();
            var_5 = vectornormalize( ( var_2[0], var_2[1], 0 ) );
            var_6 = vectortoangles( var_5 );
            var_7 = self.dodgeanimstate;
            var_8 = randomint( self _meth_83D6( var_7 ) );
            maps\mp\agents\humanoid\_humanoid_util::play_boost_fx( self.dodge_fx[var_8] );
            self _meth_8397( "anim deltas" );
            self _meth_8396( "face angle abs", var_6, var_6 );
            self _meth_8395( 1, 1 );
            maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_7, var_8, self.nonmoveratescale, "dodge" );
            self._id_1434 = 1;
            thread _id_2165();
        }
    }
}

waitforleap()
{
    self notify( "humanoidmove_endwait_leap" );
    self endon( "humanoidmove_endwait_leap" );
    self endon( "killanimscript" );
    maps\mp\zombies\_util::waittill_enter_game();

    for (;;)
    {
        wait 0.05;

        if ( !isalive( self ) )
            return;

        if ( !maps\mp\zombies\_util::_id_508F( self.leapenabled ) )
            return;

        if ( maps\mp\agents\_scripted_agent_anim_util::isstatelocked() )
            continue;

        if ( !isdefined( self._id_24C6 ) )
            continue;

        if ( issentient( self._id_24C6 ) && !self _meth_838E( self._id_24C6 ) || !maps\mp\_utility::findisfacing( self, self._id_24C6, 25 ) )
            continue;

        if ( isdefined( self.getleaptargetpointfunc ) )
            var_0 = [[ self.getleaptargetpointfunc ]]();
        else
            var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint( self._id_24C6 );

        if ( !var_0._id_9C3B )
            continue;

        var_1 = distancesquared( self._id_24C6.origin, self.origin );

        if ( var_1 > self.leapmaxrangesq || var_1 < self.leapminrangesq )
            continue;

        var_2 = gettime();
        var_3 = var_2 - self.leaplastperform;

        if ( var_3 < self.leapdebouncems )
            continue;

        var_4 = var_2 - self.leaplastcheck;

        if ( var_4 < self.leapchecktimems )
            continue;

        self.leaplastcheck = var_2;
        var_5 = self.leapchance;

        if ( randomfloat( 1.0 ) >= var_5 )
            continue;

        var_7 = randomint( self _meth_83D6( self.leapanimstate ) );
        var_8 = self _meth_83D3( self.leapanimstate, var_7 );
        var_9 = getnotetracktimes( var_8, "h_point" )[0];
        var_10 = getmovedelta( var_8, 0, var_9 );
        var_11 = self _meth_81B0( var_10 );
        var_12 = playerphysicstrace( self.origin, var_11, self );

        if ( distancesquared( var_12, var_11 ) > 1 )
        {
            self.leaplastcheck += 1000;
            continue;
        }

        var_12 = playerphysicstrace( var_11, var_0.origin, self );

        if ( distancesquared( var_12, var_0.origin ) > 1 )
        {
            self.leaplastcheck += 1000;
            continue;
        }

        _id_1AB1( "leap" );
        self.leaplastperform = gettime();
        maps\mp\agents\humanoid\_humanoid_util::play_boost_fx( self.leapfx );
        var_13 = getanimlength( var_8 );
        var_14 = getnotetracktimes( var_8, "land" );
        var_14[0] -= 0.1;
        var_15 = var_13 / self.nonmoveratescale * var_14[0];
        self _meth_8398( "noclip" );
        self _meth_8396( "face angle abs", ( 0, vectortoyaw( var_0.origin - self.origin ), 0 ) );
        self _meth_8397( "anim deltas" );
        self _meth_8395( 0, 1 );
        self _meth_839F( self.origin, var_0.origin, var_15 );
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 1, "WaitForLeap" );
        self.inairforleap = 1;
        maps\mp\agents\_scripted_agent_anim_util::set_anim_state( self.leapanimstate, var_7, self.nonmoveratescale );
        wait(var_15);
        self notify( "cancel_updatelerppos" );
        self _meth_8397( "anim deltas" );
        self _meth_8395( 1, 1 );
        self _meth_8398( "gravity" );
        maps\mp\agents\_scripted_agent_anim_util::setstatelocked( 0, "WaitForLeap" );
        self.inairforleap = 0;

        if ( var_13 - var_15 > 0 )
            maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe( "leap", "end", var_13 - var_15 );

        thread _id_2165();
    }
}

_id_A01F()
{
    self notify( "humanoidmove_endwait_pathsetwhilestopping" );
    self endon( "humanoidmove_endwait_pathsetwhilestopping" );
    self endon( "killanimscript" );
    var_0 = self _meth_8391();
    self waittill( "path_set" );
    var_1 = self _meth_8391();

    if ( distancesquared( var_0, var_1 ) < 1 )
    {
        thread _id_A01F();
        return;
    }

    self notify( "humanoidmove_endwait_stop" );
    self notify( "humanoidmove_endwait_turnwhilestopping" );
    thread _id_2165();
}

waitforturnwhilestopping()
{
    self notify( "humanoidmove_endwait_turnwhilestopping" );
    self endon( "humanoidmove_endwait_turnwhilestopping" );
    self endon( "killanimscript" );
    self waittill( "path_dir_change", var_0 );
    self notify( "humanoidmove_endwait_pathsetwhilestopping" );
    self notify( "humanoidmove_endwait_stop" );
    thread _id_2D87( var_0 );
}

_id_A00B()
{
    self notify( "humanoidmove_endwait_blockedwhilestopping" );
    self endon( "humanoidmove_endwait_blockedwhilestopping" );
    self endon( "killanimscript" );
    self waittill( "path_blocked" );
    self notify( "humanoidmove_endwait_stop" );
    self _meth_838F( undefined );
}

_id_1AB1( var_0 )
{
    var_1 = [ "turn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "turnwhilestopping", "dodge", "setmoveanim", "modechange" ];
    var_2 = isdefined( var_0 );

    foreach ( var_4 in var_1 )
    {
        if ( var_2 && var_4 == var_0 )
            continue;

        self notify( "humanoidmove_endwait_" + var_4 );
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

    var_5 = "start_" + self._id_02A6;

    if ( self._id_02A6 == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() >= 2 )
        var_5 += "_v2";

    var_6 = angleclamp180( var_3[1] - self.angles[1] );
    var_7 = self _meth_83D6( var_5 );

    if ( var_7 == 0 )
        return;

    var_8 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable( var_6, var_7 );
    var_9 = self _meth_83D3( var_5, var_8 );
    var_10 = getmovedelta( var_9 );
    var_11 = rotatevector( var_10, self.angles ) + self.origin;

    if ( !maps\mp\zombies\_util::_id_1AD2( self.origin, var_11 ) )
        return;

    var_12 = distance2dsquared( var_9 );
    self _meth_8397( "anim deltas" );

    if ( abs( var_8 - int( var_7 * 0.5 ) ) <= 1 )
        self _meth_8396( "face angle abs", ( 0, angleclamp180( var_3[1] - var_12[1] ), 0 ) );
    else
        self _meth_8396( "face angle abs", self.angles );

    var_13 = self.moveratescale;

    if ( !maps\mp\agents\humanoid\_humanoid_util::_id_50EA() && self._id_02A6 == "sprint" && maps\mp\zombies\_util::getzombieslevelnum() < 2 )
    {
        var_13 = level.moveratescalemod["run"][1];
        var_13 += self.moveratescale - level.moveratescalemod["sprint"][0];
    }

    maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe( var_5, var_8, var_13, "move_start", "code_move" );
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

islowerbody( var_0 )
{
    switch ( var_0 )
    {
        case "right_leg_upper":
        case "left_leg_upper":
        case "right_leg_lower":
        case "left_leg_lower":
        case "right_foot":
        case "left_foot":
            return 1;
        default:
            return 0;
    }
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !maps\mp\zombies\_zombies::shouldplayhitreactionpainsensor() )
        return;

    if ( !maps\mp\agents\_scripted_agent_anim_util::isstatelocked() && !maps\mp\zombies\_util::_id_508F( self.inpainmoving ) )
        thread setmoveanimpain( maps\mp\agents\humanoid\_humanoid_util::damagehitangle( var_6, var_7 ), self._id_02A6, islowerbody( var_8 ) );
}
