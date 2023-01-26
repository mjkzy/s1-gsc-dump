// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    self endon( "killanimscript" );
    self._id_14B3 = 0;
    self _meth_8398( "gravity" );
    _id_8D26();
    _id_2165();
}

_id_0140()
{
    self._id_14B3 = 0;
    _id_1AB1( undefined );
    self _meth_8395( 1, 1 );
}

_id_831F()
{
    thread _id_A029();
    thread _id_A02C();
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
    self _meth_83D2( var_0 );
}

_id_A029()
{
    self endon( "dogmove_endwait_runwalk" );
    var_0 = self._id_02A6;

    for (;;)
    {
        if ( var_0 != self._id_02A6 )
        {
            _id_7FB0( self._id_02A6 );
            var_0 = self._id_02A6;
        }

        wait 0.1;
    }
}

_id_2D77( var_0 )
{
    var_1 = vectortoangles( var_0 );
    var_2 = angleclamp180( var_1[1] - self.angles[1] );
    var_3 = maps\mp\agents\_scriptedagents::_id_3EEF( var_2 );

    if ( var_3 == 4 )
    {
        _id_2165();
        return;
    }

    var_4 = "sharp_turn";
    var_5 = self _meth_83D3( var_4, var_3 );
    var_6 = getangledelta( var_5 );
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", ( 0, angleclamp180( var_1[1] - var_6 ), 0 ) );
    maps\mp\agents\_scriptedagents::_id_6A27( var_4, var_3, "sharp_turn" );
    _id_2165();
}

_id_A02C()
{
    self endon( "dogmove_endwait_sharpturn" );
    self waittill( "path_dir_change", var_0 );
    _id_1AB1( "sharpturn" );
    _id_2D77( var_0 );
}

_id_A032()
{
    self endon( "dogmove_endwait_stop" );
    self waittill( "stop_soon" );

    if ( isdefined( self._id_12EE ) && !self._id_12EE )
    {
        thread _id_A032();
        return;
    }

    var_0 = _id_40F2();
    var_1 = self _meth_83D3( var_0._id_8D50, var_0.index );
    var_2 = getmovedelta( var_1 );
    var_3 = getangledelta( var_1 );
    var_4 = self _meth_83E1();
    var_5 = var_4 - self.origin;

    if ( length( var_5 ) + 12 < length( var_2 ) )
    {
        thread _id_A032();
        return;
    }

    var_6 = _id_40F3();
    var_7 = _id_19C3( var_6._id_6E54, var_6.angles[1], var_2, var_3 );
    var_8 = maps\mp\agents\_scriptedagents::_id_2F8E( var_7 );

    if ( !isdefined( var_8 ) )
    {
        thread _id_A032();
        return;
    }

    if ( !maps\mp\agents\_scriptedagents::_id_1AD2( var_6._id_6E54, var_8 ) )
    {
        thread _id_A032();
        return;
    }

    _id_1AB1( "stop" );
    thread _id_A01F();
    thread _id_A02E();

    if ( distancesquared( var_7, self.origin ) > 4 )
    {
        self _meth_838F( var_7 );
        thread _id_A00B();
        self waittill( "waypoint_reached" );
        self notify( "dogmove_endwait_blockedwhilestopping" );
    }

    var_9 = var_4 - self.origin;
    var_10 = vectortoangles( var_9 );
    var_11 = ( 0, var_10[1] - var_3, 0 );
    var_12 = maps\mp\agents\_scriptedagents::_id_3EFB( var_4 - self.origin, var_2 );
    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", var_11, ( 0, var_10[1], 0 ) );
    self _meth_8395( var_12._id_A3A8, var_12.z );
    maps\mp\agents\_scriptedagents::_id_6A27( var_0._id_8D50, var_0.index, "move_stop" );
    self _meth_8390( self.origin );
}

_id_A01F()
{
    self endon( "killanimscript" );
    self endon( "dogmove_endwait_pathsetwhilestopping" );
    var_0 = self _meth_8391();
    self waittill( "path_set" );
    var_1 = self _meth_8391();

    if ( distancesquared( var_0, var_1 ) < 1 )
    {
        thread _id_A01F();
        return;
    }

    self notify( "dogmove_endwait_stop" );
    self notify( "dogmove_endwait_sharpturnwhilestopping" );
    _id_2165();
}

_id_A02E()
{
    self endon( "killanimscript" );
    self endon( "dogmove_endwait_sharpturnwhilestopping" );
    self waittill( "path_dir_change", var_0 );
    self notify( "dogmove_endwait_pathsetwhilestopping" );
    self notify( "dogmove_endwait_stop" );
    _id_2D77( var_0 );
}

_id_A00B()
{
    self endon( "killanimscript" );
    self endon( "dogmove_endwait_blockedwhilestopping" );
    self waittill( "path_blocked" );
    self notify( "dogmove_endwait_stop" );
    self _meth_838F( undefined );
}

_id_A033()
{
    self endon( "killanimscript" );
    self endon( "dogmove_endwait_stopearly" );
    var_0 = self _meth_83D3( "move_stop_4", 0 );
    var_1 = getmovedelta( var_0 );
    var_2 = length( var_1 );
    var_3 = self._id_6EF1 + var_2;
    var_4 = var_3 * var_3;

    if ( distancesquared( self.origin, self.owner.origin ) <= var_4 )
        return;

    for (;;)
    {
        if ( !isdefined( self.owner ) )
            break;

        if ( distancesquared( self.origin, self.owner.origin ) < var_4 )
        {
            var_5 = self _meth_81B0( var_1 );
            self _meth_8390( var_5 );
            break;
        }

        wait 0.1;
    }
}

_id_1AB1( var_0 )
{
    var_1 = [ "runwalk", "sharpturn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "sharpturnwhilestopping", "stopearly" ];
    var_2 = isdefined( var_0 );

    foreach ( var_4 in var_1 )
    {
        if ( var_2 && var_4 == var_0 )
            continue;

        self notify( "dogmove_endwait_" + var_4 );
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

    var_5 = angleclamp180( var_3[1] - self.angles[1] );
    var_6 = maps\mp\agents\_scriptedagents::_id_3EEF( var_5 );
    var_7 = self _meth_83D3( "move_start", var_6 );
    var_8 = getmovedelta( var_7 );
    var_9 = rotatevector( var_8, self.angles ) + self.origin;

    if ( !maps\mp\agents\_scriptedagents::_id_1AD2( self.origin, var_9 ) )
        return;

    var_10 = distance2dsquared( var_7 );
    self _meth_8397( "anim deltas" );

    if ( 3 <= var_6 && var_6 <= 5 )
        self _meth_8396( "face angle abs", ( 0, angleclamp180( var_3[1] - var_10[1] ), 0 ) );
    else
        self _meth_8396( "face angle abs", self.angles );

    self._id_14B3 = 1;
    maps\mp\agents\_scriptedagents::_id_6A27( "move_start", var_6, "move_start" );
    self._id_14B3 = 0;
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

_id_40F2( var_0 )
{
    if ( isdefined( self._id_02BF ) )
    {
        var_1 = self._id_02BF.angles[1] - self.angles[1];
        var_2 = maps\mp\agents\_scriptedagents::_id_3EEF( var_1 );
    }
    else
        var_2 = 4;

    var_3 = spawnstruct();
    var_3._id_8D50 = "move_stop";
    var_3.index = var_2;
    return var_3;
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

_id_2C81()
{
    var_0 = clamp( self._id_024E / 25.0, -1, 1 );

    if ( var_0 > 0 )
        return;

    return;
}

_id_465D( var_0, var_1, var_2, var_3 )
{
    if ( 1 )
        return 0;

    switch ( var_0 )
    {
        case "footstep_front_left_small":
        case "footstep_front_right_small":
        case "footstep_back_left_small":
        case "footstep_back_right_small":
        case "footstep_front_left_large":
        case "footstep_front_right_large":
        case "footstep_back_left_large":
        case "footstep_back_right_large":
            var_4 = undefined;

            if ( isdefined( self._id_0423 ) )
            {
                var_4 = self._id_0423;
                self._id_55FC = var_4;
            }
            else if ( isdefined( self._id_55FC ) )
                var_4 = self._id_55FC;
            else
                var_4 = "dirt";

            if ( var_4 != "dirt" && var_4 != "concrete" && var_4 != "wood" && var_4 != "metal" )
                var_4 = "dirt";

            if ( var_4 == "concrete" )
                var_4 = "cement";

            if ( self._id_09A3 == "traverse" )
                var_5 = "land";
            else if ( self._id_02A6 == "sprint" )
                var_5 = "sprint";
            else if ( self._id_02A6 == "fastwalk" )
                var_5 = "walk";
            else
                var_5 = "run";

            self _meth_8438( "dogstep_" + var_5 + "_" + var_4 );

            if ( issubstr( var_0, "front_left" ) )
            {
                var_6 = "anml_dog_mvmt_accent";
                var_7 = "anml_dog_mvmt_vest";

                if ( var_5 == "walk" )
                    var_8 = "_npc";
                else
                    var_8 = "_run_npc";

                self _meth_8438( var_6 + var_8 );
                self _meth_8438( var_7 + var_8 );
            }

            return 1;
    }

    return 0;
}

_id_2CE2( var_0 )
{
    _id_1AB1( undefined );
    self._id_14B3 = 1;
    self._id_03FC = 1;
    var_1 = angleclamp180( var_0 - self.angles[1] );

    if ( var_1 > 0 )
        var_2 = 1;
    else
        var_2 = 0;

    self _meth_8397( "anim deltas" );
    self _meth_8396( "face angle abs", self.angles );
    maps\mp\agents\_scriptedagents::_id_6A27( "run_pain", var_2, "run_pain" );
    self._id_14B3 = 0;
    self._id_03FC = 0;
    _id_2165();
}

_id_6461( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( self._id_03FC )
        return;

    var_10 = vectortoangles( var_7 );
    var_11 = var_10[1] - 180;
    _id_2CE2( var_11 );
}

_id_64AA( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( self._id_03FC )
        return;

    _id_2CE2( self.angles[1] + 180 );
}
