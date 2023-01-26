// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8053();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_15B9;
    level.bot_funcs["crate_can_use"] = ::_id_2363;
}

_id_8053()
{
    level._id_161F = ::_id_15B1;
    level._id_1622 = ::_id_15B2;
    level._id_161C = ::_id_3CC0;
    level._id_161D = ::_id_3CC1;
    maps\mp\bots\_bots_util::_id_172D();

    while ( !isdefined( level.ball_goals ) )
        wait 0.05;

    level.ball_goals["allies"].script_label = "allies";
    level.ball_goals["axis"].script_label = "axis";
    _id_16F0();
    var_0 = _func_202( level.ball_goals["allies"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "allies" );

    var_0 = _func_202( level.ball_goals["axis"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "axis" );

    foreach ( var_2 in level.balls )
        var_2 thread _id_5D63();

    var_4 = 0;
    thread maps\mp\bots\_bots_gametype_common::_id_161E();
    level._id_1628 = 1;
}

_id_5D63()
{
    var_0 = self.visuals[0].origin;
    self.nearest_node = getclosestnodeinsight( var_0 );

    for (;;)
    {
        var_1 = self.visuals[0].origin;
        self._id_1282 = maps\mp\bots\_bots_util::_id_172A( var_0, var_1 );

        if ( !self._id_1282 )
        {
            var_2 = getclosestnodeinsight( var_1 );

            if ( !isdefined( var_2 ) )
            {
                var_3 = getnodesinradiussorted( var_1, 512, 0, 6000 );

                if ( var_3.size > 0 )
                    var_2 = var_3[0];
            }

            if ( isdefined( var_2 ) )
                self.nearest_node = var_2;
        }

        var_0 = var_1;
        wait 0.2;
    }
}

_id_16F0()
{
    wait 1.0;
    var_0 = 0;
    var_1 = 10;

    foreach ( var_3 in level.ball_goals )
    {
        var_3._id_12A9 = [];
        var_4 = 375;

        if ( isdefined( level.ballgoalradius ) )
            var_4 = level.ballgoalradius;

        var_5 = getnodesinradius( var_3.origin, var_4, 0 );

        foreach ( var_7 in var_5 )
        {
            if ( var_7.type == "End" )
                continue;

            if ( isdefined( level.ballpreventgoaljumpfromtraversals ) && level.ballpreventgoaljumpfromtraversals && var_7.type == "Begin" )
                continue;

            var_0++;

            if ( _id_15B8( var_7.origin, var_3, 1 ) )
                var_3._id_12A9[var_3._id_12A9.size] = var_7;

            if ( var_0 % var_1 == 0 )
                wait 0.05;
        }

        var_9 = 999999999;

        foreach ( var_7 in var_3._id_12A9 )
        {
            var_11 = _func_220( var_7.origin, var_3.origin );

            if ( var_11 < var_9 )
            {
                var_3.nearest_node = var_7;
                var_9 = var_11;
            }
        }

        wait 0.05;
    }
}

_id_15B8( var_0, var_1, var_2 )
{
    var_3 = _id_15BA( var_0, var_1.origin );

    if ( isdefined( var_2 ) && var_2 )
    {
        if ( !var_3 )
        {
            var_4 = var_1.origin - ( 0, 0, var_1.radius * 0.5 );
            var_3 = _id_15BA( var_0, var_4 );
        }

        if ( !var_3 )
        {
            var_4 = var_1.origin + ( 0, 0, var_1.radius * 0.5 );
            var_3 = _id_15BA( var_0, var_4 );
        }
    }

    return var_3;
}

_id_15BA( var_0, var_1 )
{
    if ( isdefined( self ) && ( isplayer( self ) || isagent( self ) ) )
        var_2 = playerphysicstrace( var_0, var_1, self );
    else
        var_2 = playerphysicstrace( var_0, var_1 );

    return distancesquared( var_2, var_1 ) < 1;
}

_id_2363( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0._id_175D ) )
        return 0;

    if ( _id_46DE() )
        return 0;

    return 1;
}

_id_15B9()
{
    self notify( "bot_ball_think" );
    self endon( "bot_ball_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "owner_disconnect" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    var_0 = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    var_1 = 0;
    self._id_5541 = 0;
    self._id_1283 = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    self._id_1284 = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    self._id_1286 = randomint( 100 ) < self _meth_837B( "strategyLevel" ) * 25;
    var_2 = level.ball_goals[self.team];
    var_3 = level.ball_goals[common_scripts\utility::get_enemy_team( self.team )];
    childthread _id_A1CD();

    for (;;)
    {
        if ( self.health <= 0 )
            continue;

        var_4 = !isdefined( self._id_7597 );

        if ( var_4 )
            maps\mp\bots\_bots_gametype_common::_id_1627();

        self _meth_8351( "force_sprint", 0 );
        var_5 = _id_15B3( self.team );
        var_6 = _id_15B3( common_scripts\utility::get_enemy_team( self.team ) );

        foreach ( var_8 in var_6 )
        {
            var_9 = var_8 _id_15B6() - ( 0.0, 0.0, 75.0 );
            self _meth_8377( var_8.carrier, var_9 );
        }

        if ( _id_46DE() )
        {
            self _meth_8351( "force_sprint", 1 );
            var_11 = distancesquared( self.origin, var_3.nearest_node.origin );

            if ( var_11 > 360000 )
            {
                var_12 = var_3.nearest_node;
                var_13 = 600;
            }
            else
            {
                var_12 = common_scripts\utility::get_array_of_closest( self.origin, var_3._id_12A9 )[0];
                var_13 = 16;
            }

            _id_1EAD();
            self botsetscriptgoal( var_12.origin, var_13, "critical" );
            var_14 = maps\mp\bots\_bots_util::_id_172E( undefined, "bot_no_longer_has_ball" );

            if ( var_14 == "goal" && distancesquared( self.origin, var_12.origin ) <= 256 )
            {
                self _meth_8356();
                var_15 = vectornormalize( var_3.origin - self geteye() );

                if ( vectordot( var_15, ( 0.0, 0.0, 1.0 ) ) < 0.93 )
                    self _meth_836D( var_3.origin, 5.0, "script_forced" );

                var_16 = 0;
                var_17 = 0;
                var_18 = self.origin[2];

                while ( var_16 < 4.0 && _id_46DE() )
                {
                    self _meth_8353( vectortoyaw( var_3.origin - self.origin ), 0.05 );

                    if ( var_16 == 0.3 || var_16 == 0.75 )
                        self _meth_837E( "jump" );

                    var_19 = var_16 > 1.25 && self.origin[2] < var_18;
                    var_18 = self.origin[2];

                    if ( !var_17 )
                    {
                        var_20 = abs( self.origin[2] - var_3.origin[2] );
                        var_21 = distance2d( self.origin, var_3.origin );

                        if ( var_20 < 10 || var_19 && var_21 > 200 )
                        {
                            self _meth_837E( "sprint" );
                            var_17 = 1;
                        }
                    }

                    wait 0.05;
                    var_16 += 0.05;

                    if ( !_id_46DE() || var_16 > 0.75 && self isonground() )
                        var_16 = 5.0;
                }

                self _meth_836D( undefined );
            }

            self _meth_8356();
        }
        else if ( self._id_7597 == "attacker" )
        {
            var_22 = _id_15B5();

            if ( var_22.size <= 0 )
            {
                if ( var_6.size > 0 )
                {
                    var_23 = _id_15B4( var_6 );
                    var_24 = var_23 _id_15B6() - ( 0.0, 0.0, 75.0 );

                    if ( var_0 )
                    {
                        if ( gettime() > var_1 )
                        {
                            var_1 = gettime() + 5000;
                            var_25 = undefined;
                            var_26 = _func_200( var_24, var_2.nearest_node.origin );

                            if ( isdefined( var_26 ) && var_26.size > 0 )
                                var_25 = var_26[int( var_26.size * randomfloatrange( 0.25, 0.75 ) )].origin;

                            _id_1EAD();

                            if ( isdefined( var_25 ) && maps\mp\bots\_bots_personality::_id_3751( var_25, 512 ) )
                                self _meth_8355( self._id_611E, "guard", self._id_0B68 );
                            else
                                self botsetscriptgoal( var_24, 16, "guard" );
                        }
                    }
                    else
                    {
                        _id_1EAD();
                        self botsetscriptgoal( var_24, 16, "guard" );
                    }
                }
                else if ( var_5.size > 0 )
                {
                    if ( !maps\mp\bots\_bots_util::_id_1659() )
                    {
                        var_27 = _id_15B4( var_5 );
                        _id_1EAD();
                        maps\mp\bots\_bots_strategy::_id_1646( var_27.carrier, 500 );
                    }
                }
                else if ( maps\mp\_utility::isjuggernaut() )
                    maps\mp\bots\_bots_personality::_id_9ACA();
                else
                {
                    var_28 = common_scripts\utility::get_array_of_closest( self.origin, level.ball_starts );
                    _id_1EAD();
                    self botsetscriptgoal( var_28[0].origin, 16, "guard" );
                }
            }
            else if ( maps\mp\_utility::isjuggernaut() )
                maps\mp\bots\_bots_personality::_id_9ACA();
            else
            {
                var_29 = _id_15B4( var_22 );
                _id_1EAD( "objective" );

                if ( var_29._id_1282 )
                {
                    var_30 = var_29 _id_15B6();

                    if ( !self _meth_8365() || !maps\mp\bots\_bots_util::_id_172A( var_30, self _meth_835A() ) )
                        self botsetscriptgoal( var_30, 16, "objective", undefined, 180 );
                }
                else
                    self botsetscriptgoal( var_29.nearest_node.origin, 16, "objective", undefined, 180 );
            }
        }
        else
        {
            var_31 = undefined;
            var_22 = _id_15B5();

            foreach ( var_8 in var_22 )
            {
                var_33 = _func_220( var_8 _id_15B6(), var_2.origin );

                if ( var_33 < squared( _id_3CD1() ) )
                {
                    var_31 = var_8;
                    break;
                }
            }

            if ( isdefined( var_31 ) && !maps\mp\_utility::isjuggernaut() )
            {
                _id_1EAD();

                if ( var_31._id_1282 )
                    self botsetscriptgoal( var_31 _id_15B6(), 16, "guard" );
                else
                    self botsetscriptgoal( var_31.nearest_node.origin, 16, "guard" );

                maps\mp\bots\_bots_util::_id_172E( 1.0 );
            }
            else if ( !maps\mp\bots\_bots_util::_id_1662() )
            {
                self _meth_8356();
                var_35["score_flags"] = "strict_los";
                var_35["override_origin_node"] = var_2.nearest_node;
                maps\mp\bots\_bots_strategy::_id_16C2( var_2.nearest_node.origin, _id_3CD1(), var_35 );
            }
        }

        wait 0.05;
    }
}

_id_A1CD()
{
    var_0 = 0;

    for (;;)
    {
        if ( _id_46DE() && !var_0 )
        {
            childthread _id_5DD4();
            var_0 = 1;
            self _meth_8351( "melee_critical_path", 1 );
        }
        else if ( !_id_46DE() && var_0 )
        {
            self notify( "bot_no_longer_has_ball" );
            var_0 = 0;
            self _meth_8351( "melee_critical_path", 0 );
        }

        wait 0.05;
    }
}

_id_5DD4()
{
    self endon( "bot_no_longer_has_ball" );
    var_0 = level.ball_goals[self.team];
    var_1 = level.ball_goals[common_scripts\utility::get_enemy_team( self.team )];

    for (;;)
    {
        if ( self._id_1283 )
        {
            if ( isdefined( self.pass_target ) )
            {
                var_2 = 1;

                if ( var_2 )
                {
                    var_3 = distancesquared( self.origin, var_1.origin );
                    var_4 = distancesquared( self.pass_target.origin, var_1.origin );

                    if ( var_4 <= var_3 )
                    {
                        var_5 = anglestoforward( self getangles() );
                        var_6 = vectornormalize( self.pass_target.origin - self.origin );
                        var_7 = vectordot( var_5, var_6 );

                        if ( var_7 > 0.7 )
                        {
                            self _meth_836D( self.pass_target.origin + ( 0.0, 0.0, 40.0 ), 1.25, "script_forced" );
                            wait 0.25;
                            self _meth_837E( "throw" );
                            wait 1.0;
                        }
                    }
                }
            }
        }

        if ( self._id_1284 )
        {
            if ( isdefined( self._id_0143 ) && isalive( self._id_0143 ) && self _meth_836F( self._id_0143 ) )
            {
                var_8 = 1;

                if ( var_8 )
                {
                    var_9 = distancesquared( self.origin, var_0.origin );
                    var_10 = var_9 < squared( _id_3CD1() );

                    if ( !var_10 && distancesquared( self.origin, self._id_0143.origin ) < squared( 350 ) )
                    {
                        var_11 = anglestoforward( self._id_0143 getangles() );
                        var_12 = vectornormalize( self.origin - self._id_0143.origin );
                        var_7 = vectordot( var_11, var_12 );

                        if ( var_7 > 0.5 )
                        {
                            var_5 = anglestoforward( self getangles() );
                            var_13 = -1 * var_12;
                            var_7 = vectordot( var_5, var_13 );

                            if ( var_7 > 0.77 )
                            {
                                self _meth_836D( self._id_0143.origin + ( 0.0, 0.0, 40.0 ), 1.25, "script_forced" );
                                wait 0.25;
                                self _meth_837E( "attack" );
                                wait 1.0;
                            }
                        }
                    }
                }
            }
        }

        if ( self._id_1286 )
        {
            if ( self.health < 100 && _id_15B8( self.origin, var_1 ) )
            {
                self _meth_836D( var_1.origin, 1.25, "script_forced" );
                wait 0.25;
                self _meth_837E( "attack" );
                wait 1.0;
            }
            else if ( self._id_7597 == "defender" )
            {
                var_9 = distancesquared( self.origin, var_0.origin );

                if ( var_9 < squared( _id_3CD1() ) )
                {
                    var_14 = anglestoforward( self getangles() * ( 0.0, 1.0, 1.0 ) + ( -30.0, 0.0, 0.0 ) );
                    self _meth_836D( self geteye() + var_14 * 200, 1.25, "script_forced" );
                    wait 0.25;
                    self _meth_837E( "attack" );
                    wait 1.0;
                }
            }
        }

        wait 0.05;
    }
}

_id_1289( var_0 )
{
    var_1 = self _meth_8387();
    var_2 = var_0 _meth_8387();

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        if ( getnodesintrigger( var_1, var_2, 1 ) )
            return var_2;

        var_3 = getlinkednodes( var_2 );

        foreach ( var_5 in var_3 )
        {
            if ( getnodesintrigger( var_1, var_5, 1 ) )
                return var_5;
        }
    }

    return undefined;
}

_id_15B7()
{
    return self.compassicons["friendly"] == "waypoint_ball_download" || self.compassicons["friendly"] == "waypoint_ball_upload";
}

_id_15B4( var_0 )
{
    if ( var_0.size == 1 )
        return var_0[0];

    var_1 = 99999999;
    var_2 = undefined;

    foreach ( var_4 in var_0 )
    {
        var_5 = distancesquared( self.origin, var_4 _id_15B6() );

        if ( var_5 < var_1 )
        {
            var_1 = var_5;
            var_2 = var_4;
        }
    }

    return var_2;
}

_id_15B6()
{
    if ( isdefined( self.carrier ) )
        return self.curorigin;
    else
        return self.visuals[0].origin;
}

_id_1EAD( var_0 )
{
    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    if ( self _meth_835D() == "objective" )
    {
        var_1 = isdefined( var_0 ) && var_0 == "objective";

        if ( !var_1 )
            self _meth_8356();
    }
}

_id_46DE()
{
    return isdefined( self.ball_carried );
}

_id_15B5()
{
    var_0 = [];

    foreach ( var_2 in level.balls )
    {
        if ( var_2 _id_15B7() )
            continue;

        if ( !isdefined( var_2.carrier ) )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

_id_15B3( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.balls )
    {
        if ( var_3 _id_15B7() )
            continue;

        if ( isdefined( var_3.carrier ) && var_3.carrier.team == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_15B1( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::_id_1625( var_0 );
    var_2 = var_1 * 0.67;
    var_3 = floor( var_2 );
    var_4 = ceil( var_2 );
    var_5 = var_2 - var_3;
    var_6 = var_4 - var_2;

    if ( var_5 < var_6 )
        var_7 = int( var_3 );
    else
        var_7 = int( var_4 );

    return var_7;
}

_id_15B2( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::_id_1625( var_0 );
    return var_1 - _id_15B1( var_0 );
}

_id_3CD1()
{
    if ( isalive( self ) && !isdefined( level._id_703C ) )
    {
        var_0 = self _meth_835F();
        var_1 = ( var_0[0] + var_0[1] ) / 2;
        level._id_703C = min( 800, var_1 / 5.5 );
    }

    if ( !isdefined( level._id_703C ) )
        return 900;

    return level._id_703C;
}

_id_3CC0( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::_id_1623( var_0, level.ball_goals[var_0].origin, _id_3CD1() );
}

_id_3CC1( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::_id_1624( var_0, level.ball_goals[var_0].origin, _id_3CD1() );
}
