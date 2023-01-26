// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    level._id_164F = 0;

    if ( level.currentgen )
        level._id_164F = 1;

    _id_806C();
    _id_8056();
    level thread maps\mp\bots\_bots_util::_id_16A4( maps\mp\bots\_bots_util::_id_1725 );
}

_id_806C()
{
    level.bot_funcs["crate_can_use"] = ::_id_2363;
    level.bot_funcs["gametype_think"] = ::_id_15FF;
    level.bot_funcs["should_start_cautious_approach"] = ::_id_8476;
    level.bot_funcs["leader_dialog"] = ::_id_15FD;

    if ( !level._id_164F )
        level.bot_funcs["get_watch_node_chance"] = ::_id_15FC;
}

_id_2363( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0._id_175D ) )
        return 0;

    if ( !maps\mp\_utility::isteamparticipant( self ) )
        return 1;

    return maps\mp\bots\_bots_util::_id_1662();
}

_id_5E20()
{
    self notify( "monitor_zone_control" );
    self endon( "monitor_zone_control" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1;
        var_0 = maps\mp\gametypes\dom::getflagteam();

        if ( var_0 != "neutral" )
        {
            var_1 = _func_202( self.origin );

            if ( isdefined( var_1 ) )
                botzonesetteam( var_1, var_0 );
        }
    }
}

_id_5DA0()
{
    self notify( "monitor_flag_ownership" );
    self endon( "monitor_flag_ownership" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = maps\mp\gametypes\dom::getflagteam();

    for (;;)
    {
        var_1 = maps\mp\gametypes\dom::getflagteam();

        if ( var_1 != var_0 )
            level notify( "flag_changed_ownership" );

        var_0 = var_1;
        wait 0.05;
    }
}

_id_8056()
{
    maps\mp\bots\_bots_util::_id_172D( 1 );
    var_0 = _id_162A();

    if ( var_0.size > 3 )
    {
        while ( !isdefined( level._id_9210 ) )
            wait 0.05;

        var_1 = [];

        foreach ( var_3 in var_0 )
        {
            if ( !isdefined( var_1[var_3._id_9251] ) )
                var_1[var_3._id_9251] = [];

            var_1[var_3._id_9251] = common_scripts\utility::array_add( var_1[var_3._id_9251], var_3 );
        }

        foreach ( var_7, var_6 in var_1 )
        {
            level._id_3322 = 0;
            _id_15C1( var_6 );
            maps\mp\bots\_bots_gametype_common::_id_15BF( var_6, var_7 + "_flag", level._id_164F );
        }
    }
    else
    {
        maps\mp\bots\_bots_gametype_common::_id_15BF( var_0, "flag", level._id_164F );
        _id_15C1( var_0 );
        thread _id_172C( var_0 );
    }

    foreach ( var_3 in var_0 )
    {
        var_3 thread _id_5E20();
        var_3 thread _id_5DA0();

        if ( var_3.script_label != "_a" && var_3.script_label != "_b" && var_3.script_label != "_c" )
        {

        }

        var_3._id_6136 = _func_1FE( var_3 );
        maps\mp\bots\_bots_gametype_common::_id_15A3( var_3, var_3 );
        var_3._id_5563["allies"] = 0;
        var_3._id_5563["axis"] = 0;
    }

    level._id_15FE = [];
    level._id_15FE["axis"] = [];
    level._id_15FE["allies"] = [];
    level._id_1628 = 1;
}

_id_172C( var_0 )
{
    level endon( "game_ended" );
    level waittill( "dom_flags_moved" );
    maps\mp\bots\_bots_gametype_common::_id_15BF( var_0, "flag", level._id_164F, 1 );
    _id_15C1( var_0 );

    foreach ( var_2 in var_0 )
    {
        var_2._id_6136 = _func_1FE( var_2 );
        maps\mp\bots\_bots_gametype_common::_id_15A3( var_2, var_2 );
    }

    foreach ( var_5 in level.participants )
    {
        if ( maps\mp\_utility::isaiteamparticipant( var_5 ) )
            var_5._id_399A = 1;
    }
}

_id_162A()
{
    if ( isdefined( level._id_09E0 ) )
        return level._id_09E0;
    else
        return level.flags;
}

_id_15C1( var_0 )
{
    if ( !isdefined( level._id_3836 ) )
        level._id_3836 = [];

    for ( var_1 = 0; var_1 < var_0.size - 1; var_1++ )
    {
        for ( var_2 = var_1 + 1; var_2 < var_0.size; var_2++ )
        {
            var_3 = distance( var_0[var_1].origin, var_0[var_2].origin );
            var_4 = _id_3D6C( var_0[var_1] );
            var_5 = _id_3D6C( var_0[var_2] );
            level._id_3836[var_4][var_5] = var_3;
            level._id_3836[var_5][var_4] = var_3;
        }
    }
}

_id_8476( var_0 )
{
    if ( var_0 )
    {
        if ( self._id_24E5 maps\mp\gametypes\dom::getflagteam() == "neutral" && _id_383A( self._id_24E5 ) )
        {
            var_1 = _id_3CF5( self.lastspawnpoint.origin );

            if ( var_1 == self._id_24E5 )
                return 0;
            else
            {
                var_2 = _id_3E04( var_1, self._id_24E5 );
                var_3 = distancesquared( var_1.origin, self._id_24E5.origin );
                var_4 = distancesquared( var_2.origin, self._id_24E5.origin );

                if ( var_3 < var_4 )
                    return 0;
            }
        }
    }

    return maps\mp\bots\_bots_strategy::_id_8475( var_0 );
}

_id_15FA()
{
    return 0;
}

_id_15FB()
{
    return 0;
}

_id_15FF()
{
    self notify( "bot_dom_think" );
    self endon( "bot_dom_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self._id_399A = 0;
    self._id_609A = 0;
    self._id_60BE = 0;
    self _meth_8351( "separation", 0 );
    self _meth_8351( "grenade_objectives", 1 );
    self _meth_8351( "use_obj_path_style", 1 );

    for (;;)
    {
        maps\mp\bots\_bots_util::_id_1723();
        var_0 = gettime();

        if ( var_0 > self._id_60BE )
        {
            self._id_60BE = gettime() + 10000;
            self._id_8F1D = self _meth_837B( "strategyLevel" );
        }

        if ( var_0 > self._id_609A || self._id_399A )
        {
            if ( _id_845B() )
                self._id_609A = var_0 + 5000;
            else
            {
                self._id_399A = 0;
                _id_15D7();
                self._id_609A = var_0 + randomintrange( 30000, 45000 );
            }
        }

        common_scripts\utility::waittill_notify_or_timeout( "needs_new_flag_goal", 1.0 );
    }
}

_id_845B()
{
    if ( self._id_399A )
        return 0;

    if ( !maps\mp\bots\_bots_util::_id_165A() )
        return 0;

    if ( self._id_24E5 maps\mp\gametypes\dom::getflagteam() == self.team )
        return 0;

    var_0 = _id_3D6B();

    if ( distancesquared( self.origin, self._id_24E5.origin ) < var_0 * 2 * ( var_0 * 2 ) )
    {
        var_1 = _id_3CC2( self.team );

        if ( var_1.size == 2 && !common_scripts\utility::array_contains( var_1, self._id_24E5 ) && !_id_15A9() )
            return 0;

        return 1;
    }

    return 0;
}

_id_3E12()
{
    return level._id_15FE[self.team];
}

_id_46F4()
{
    var_0 = _id_3E12();
    return var_0.size > 0;
}

_id_3839( var_0 )
{
    return !_id_383A( var_0 );
}

_id_383A( var_0 )
{
    return var_0.useobj.firstcapture;
}

_id_15D7()
{
    var_0 = undefined;
    var_1 = [];
    var_2 = [];
    var_3 = 1;
    var_4 = _id_3E12();

    if ( var_4.size > 0 )
        var_5 = var_4;
    else
        var_5 = level.flags;

    for ( var_6 = 0; var_6 < var_5.size; var_6++ )
    {
        var_7 = var_5[var_6] maps\mp\gametypes\dom::getflagteam();

        if ( var_3 )
        {
            if ( _id_3839( var_5[var_6] ) )
                var_3 = 0;
            else
            {

            }
        }

        if ( var_7 != self.team )
        {
            var_1[var_1.size] = var_5[var_6];
            continue;
        }

        var_2[var_2.size] = var_5[var_6];
    }

    var_8 = undefined;

    if ( var_1.size == 3 )
        var_8 = 1;
    else if ( var_1.size == 2 )
    {
        if ( var_2.size == 1 )
        {
            if ( !_id_16F8( var_2[0], 1 ) )
                var_8 = 1;
            else
                var_8 = !_id_16F7( 0.34 );

            if ( maps\mp\bots\_bots_util::_id_1636( self.team ) == 1 )
                var_8 = 1;
        }
        else if ( var_2.size == 0 )
            var_8 = 1;
    }
    else if ( var_1.size == 1 )
    {
        if ( var_2.size == 2 )
        {
            if ( _id_15A9() )
            {
                if ( !_id_16F8( var_2[0], 2 ) && !_id_16F8( var_2[1], 2 ) )
                    var_8 = 1;
                else if ( self._id_8F1D == 0 )
                    var_8 = !_id_16F7( 0.34 );
                else
                    var_8 = !_id_16F7( 0.5 );
            }
            else
                var_8 = 0;
        }
        else if ( var_2.size == 1 )
        {
            if ( !_id_16F8( var_2[0], 1 ) )
                var_8 = 1;
            else
                var_8 = !_id_16F7( 0.34 );
        }
        else if ( var_2.size == 0 )
            var_8 = 1;
    }
    else if ( var_1.size == 0 )
        var_8 = 0;

    if ( var_8 )
    {
        if ( var_1.size > 1 )
            var_9 = common_scripts\utility::get_array_of_closest( self.origin, var_1 );
        else
            var_9 = var_1;

        if ( var_3 && !_id_46F4() )
        {
            var_10 = _id_3DF4( var_9[0], 1 );

            if ( var_10 < _id_5C2A() )
                var_11 = 0;
            else
            {
                var_12 = 20;
                var_13 = 65;
                var_14 = 15;

                if ( self._id_8F1D == 0 )
                {
                    var_12 = 50;
                    var_13 = 25;
                    var_14 = 25;
                }
                else if ( self._id_8F1D == 1 )
                {
                    var_12 = 40;
                    var_13 = 40;
                    var_14 = 20;
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_12 )
                    var_11 = 0;
                else if ( var_15 < var_12 + var_13 )
                    var_11 = 1;
                else
                    var_11 = 2;
            }

            var_16 = undefined;

            if ( var_11 == 0 )
                var_16 = "critical";

            _id_1B47( var_9[var_11], var_16 );
            return;
        }

        if ( var_9.size == 1 )
            var_0 = var_9[0];
        else if ( distancesquared( var_9[0].origin, self.origin ) < 102400 )
            var_0 = var_9[0];
        else
        {
            var_17 = [];
            var_18 = [];

            for ( var_6 = 0; var_6 < var_9.size; var_6++ )
            {
                var_19 = distance( var_9[var_6].origin, self.origin );
                var_18[var_6] = var_19;
                var_17[var_6] = var_19;
            }

            if ( var_2.size == 1 )
            {
                var_20 = 1.5;

                for ( var_6 = 0; var_6 < var_17.size; var_6++ )
                    var_17[var_6] += level._id_3836[_id_3D6C( var_9[var_6] )][_id_3D6C( var_2[0] )] * var_20;
            }

            if ( self._id_8F1D == 0 )
            {
                var_15 = randomint( 100 );

                if ( var_15 < 50 )
                    var_0 = var_9[0];
                else if ( var_15 < 50 + 50 / ( var_9.size - 1 ) )
                    var_0 = var_9[1];
                else
                    var_0 = var_9[2];
            }
            else if ( var_17.size == 2 )
            {
                var_21[0] = 50;
                var_21[1] = 50;

                for ( var_6 = 0; var_6 < var_9.size; var_6++ )
                {
                    if ( var_17[var_6] < var_17[1 - var_6] )
                    {
                        var_21[var_6] += 20;
                        var_21[1 - var_6] = var_21[1 - var_6] - 20;
                    }

                    if ( var_18[var_6] < 640 )
                    {
                        var_21[var_6] += 15;
                        var_21[1 - var_6] = var_21[1 - var_6] - 15;
                    }

                    if ( var_9[var_6] maps\mp\gametypes\dom::getflagteam() == "neutral" )
                    {
                        var_21[var_6] += 15;
                        var_21[1 - var_6] = var_21[1 - var_6] - 15;
                    }
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_21[0] )
                    var_0 = var_9[0];
                else
                    var_0 = var_9[1];
            }
            else if ( var_17.size == 3 )
            {
                var_21[0] = 34;
                var_21[1] = 33;
                var_21[2] = 33;

                for ( var_6 = 0; var_6 < var_9.size; var_6++ )
                {
                    var_22 = ( var_6 + 1 ) % 3;
                    var_23 = ( var_6 + 2 ) % 3;

                    if ( var_17[var_6] < var_17[var_22] && var_17[var_6] < var_17[var_23] )
                    {
                        var_21[var_6] += 36;
                        var_21[var_22] -= 18;
                        var_21[var_23] -= 18;
                    }

                    if ( var_18[var_6] < 640 )
                    {
                        var_21[var_6] += 15;
                        var_21[var_22] -= 7;
                        var_21[var_23] -= 8;
                    }

                    if ( var_9[var_6] maps\mp\gametypes\dom::getflagteam() == "neutral" )
                    {
                        var_21[var_6] += 15;
                        var_21[var_22] -= 7;
                        var_21[var_23] -= 8;
                    }
                }

                var_15 = randomint( 100 );

                if ( var_15 < var_21[0] )
                    var_0 = var_9[0];
                else if ( var_15 < var_21[0] + var_21[1] )
                    var_0 = var_9[1];
                else
                    var_0 = var_9[2];
            }
        }
    }
    else
    {
        if ( var_2.size > 1 )
            var_24 = common_scripts\utility::get_array_of_closest( self.origin, var_2 );
        else
            var_24 = var_2;

        foreach ( var_26 in var_24 )
        {
            if ( _id_16F8( var_26, var_2.size ) )
            {
                var_0 = var_26;
                break;
            }
        }

        if ( !isdefined( var_0 ) )
        {
            if ( self._id_8F1D == 0 )
                var_0 = var_2[0];
            else if ( var_24.size == 2 )
            {
                var_28 = _id_3E04( var_24[0], var_24[1] );
                var_29 = common_scripts\utility::get_array_of_closest( var_28.origin, var_24 );
                var_15 = randomint( 100 );

                if ( var_15 < 70 )
                    var_0 = var_29[0];
                else
                    var_0 = var_29[1];
            }
            else
                var_0 = var_24[0];
        }
    }

    if ( var_8 )
        _id_1B47( var_0 );
    else
        _id_27A3( var_0 );
}

_id_5C2A()
{
    var_0 = maps\mp\bots\_bots_util::_id_1636( self.team );
    return ceil( var_0 / 3 );
}

_id_15A9()
{
    if ( self._id_8F1D == 0 )
        return 1;

    var_0 = _id_3E12();

    if ( var_0.size == 3 )
        return 1;

    var_1 = maps\mp\gametypes\_gamescore::_getteamscore( common_scripts\utility::get_enemy_team( self.team ) );
    var_2 = maps\mp\gametypes\_gamescore::_getteamscore( self.team );
    var_3 = 200 - var_1;
    var_4 = 200 - var_2;
    var_5 = var_4 * 0.5 > var_3;
    return var_5;
}

_id_16F7( var_0 )
{
    if ( randomfloat( 1 ) < var_0 )
        return 1;

    var_1 = level._id_16B2[self._id_67DC];

    if ( var_1 == "stationary" )
        return 1;
    else if ( var_1 == "active" )
        return 0;
}

_id_1B47( var_0, var_1, var_2 )
{
    self._id_24E5 = var_0;

    if ( _id_15FB() )
    {
        var_3["override_goal_type"] = var_1;
        var_3["entrance_points_index"] = _id_3D6C( var_0 );
        maps\mp\bots\_bots_strategy::_id_16C2( var_0.origin, _id_3D6D(), var_3 );
    }
    else
    {
        var_3["override_goal_type"] = var_1;
        var_3["entrance_points_index"] = _id_3D6C( var_0 );
        maps\mp\bots\_bots_strategy::_id_15D2( var_0.origin, var_0._id_6136, var_0, var_3 );
    }

    if ( !isdefined( var_2 ) || !var_2 )
        thread _id_5DA1( var_0 );
}

_id_27A3( var_0 )
{
    self._id_24E5 = var_0;

    if ( _id_15FA() )
    {
        var_1["entrance_points_index"] = _id_3D6C( var_0 );
        maps\mp\bots\_bots_strategy::_id_15D2( var_0.origin, var_0._id_6136, var_0, var_1 );
    }
    else
    {
        var_1["entrance_points_index"] = _id_3D6C( var_0 );
        var_1["nearest_node_to_center"] = var_0.nearest_node;
        maps\mp\bots\_bots_strategy::_id_16C2( var_0.origin, _id_3D6D(), var_1 );
    }

    thread _id_5DA1( var_0 );
}

_id_3D6B()
{
    if ( !isdefined( level._id_1B4A ) )
        level._id_1B4A = 158;

    return level._id_1B4A;
}

_id_3D6D()
{
    if ( !isdefined( level._id_703C ) )
    {
        var_0 = self _meth_835F();
        var_1 = ( var_0[0] + var_0[1] ) / 2;
        level._id_703C = min( 1000, var_1 / 3.5 );
    }

    return level._id_703C;
}

_id_15FD( var_0, var_1 )
{
    if ( issubstr( var_0, "losing" ) && var_0 != "losing_score" && var_0 != "losing_time" )
    {
        var_2 = getsubstr( var_0, var_0.size - 2 );
        var_3 = _id_3E67( var_2 );

        if ( _id_15A8( var_3 ) )
        {
            self botmemoryevent( "known_enemy", undefined, var_3.origin );

            if ( !isdefined( self._id_553A ) || gettime() - self._id_553A > 10000 )
            {
                if ( maps\mp\bots\_bots_util::_id_1662() )
                {
                    var_4 = distancesquared( self.origin, var_3.origin ) < 490000;
                    var_5 = _id_1663( var_3 );

                    if ( var_4 || var_5 )
                    {
                        _id_1B47( var_3 );
                        self._id_553A = gettime();
                    }
                }
            }
        }
    }
    else if ( issubstr( var_0, "secured" ) )
    {
        var_2 = getsubstr( var_0, var_0.size - 2 );
        var_6 = _id_3E67( var_2 );
        var_6._id_5563[self.team] = gettime();
    }

    maps\mp\bots\_bots_util::_id_1681( var_0, var_1 );
}

_id_15A8( var_0 )
{
    var_1 = _id_3E12();

    if ( var_1.size == 0 )
        return 1;

    if ( common_scripts\utility::array_contains( var_1, var_0 ) )
        return 1;

    return 0;
}

_id_5DA1( var_0 )
{
    self notify( "monitor_flag_status" );
    self endon( "monitor_flag_status" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = _id_3DF6( self.team );
    var_2 = _id_3D6B() * _id_3D6B();
    var_3 = _id_3D6B() * 3 * ( _id_3D6B() * 3 );
    var_4 = 1;

    while ( var_4 )
    {
        var_5 = 0;
        var_6 = var_0 maps\mp\gametypes\dom::getflagteam();
        var_7 = _id_3DF6( self.team );
        var_8 = _id_3D4C( self.team );

        if ( maps\mp\bots\_bots_util::_id_165A() )
        {
            if ( var_6 == self.team && var_0.useobj.claimteam == "none" )
            {
                if ( !_id_15FA() )
                    var_5 = 1;
            }

            if ( var_7 == 2 && var_6 != self.team && !_id_15A9() )
            {
                if ( distancesquared( self.origin, var_0.origin ) > var_2 )
                    var_5 = 1;
            }

            foreach ( var_10 in var_8 )
            {
                if ( var_10 != var_0 && _id_15A8( var_10 ) )
                {
                    if ( distancesquared( self.origin, var_10.origin ) < var_3 )
                        var_5 = 1;
                }
            }

            if ( self istouching( var_0 ) && var_0.useobj.userate <= 0 )
            {
                if ( self _meth_8365() )
                {
                    var_12 = self _meth_835A();
                    var_13 = self _meth_835B();

                    if ( distancesquared( self.origin, var_12 ) < squared( var_13 ) )
                    {
                        var_14 = self _meth_8387();

                        if ( isdefined( var_14 ) )
                        {
                            var_15 = undefined;

                            foreach ( var_17 in var_0._id_6136 )
                            {
                                if ( !getnodesintrigger( var_17, var_14, 1 ) )
                                {
                                    var_15 = var_17.origin;
                                    break;
                                }
                            }

                            if ( isdefined( var_15 ) )
                            {
                                self._id_27B2 = var_15;
                                self notify( "defend_force_node_recalculation" );
                            }
                        }
                    }
                }
            }
        }

        if ( maps\mp\bots\_bots_util::_id_1662() )
        {
            if ( var_6 != self.team )
            {
                if ( !_id_15FB() )
                    var_5 = 1;
            }
            else if ( var_7 == 1 && var_1 > 1 )
                var_5 = 1;
        }

        var_1 = var_7;

        if ( var_5 )
        {
            self._id_399A = 1;
            var_4 = 0;
            self notify( "needs_new_flag_goal" );
            continue;
        }

        var_19 = level common_scripts\utility::waittill_notify_or_timeout_return( "flag_changed_ownership", 1 + randomfloatrange( 0, 2 ) );

        if ( !( isdefined( var_19 ) && var_19 == "timeout" ) )
        {
            var_20 = max( ( 3 - self._id_8F1D ) * 1.0 + randomfloatrange( -0.5, 0.5 ), 0 );
            wait(var_20);
        }
    }
}

_id_15FC( var_0 )
{
    if ( var_0 == self._id_611F )
        return 1.0;

    if ( !isdefined( self._id_24E5 ) )
        return 1.0;

    var_1 = 0;
    var_2 = _id_3D6C( self._id_24E5 );
    var_3 = _id_3CC2( self.team );

    foreach ( var_5 in var_3 )
    {
        if ( var_5 != self._id_24E5 )
        {
            var_1 = var_0 maps\mp\bots\_bots_util::_id_6123( var_2, _id_3D6C( var_5 ) );

            if ( var_1 )
            {
                var_6 = _id_3E04( self._id_24E5, var_5 );
                var_7 = var_6 maps\mp\gametypes\dom::getflagteam();

                if ( var_7 != self.team )
                {
                    if ( var_0 maps\mp\bots\_bots_util::_id_6123( var_2, _id_3D6C( var_6 ) ) )
                        var_1 = 0;
                }
            }
        }
    }

    if ( var_1 )
        return 0.2;

    return 1.0;
}

_id_3D6C( var_0 )
{
    var_1 = "";

    if ( isdefined( var_0._id_9251 ) )
        var_1 += ( var_0._id_9251 + "_" );

    var_1 += ( "flag" + var_0.script_label );
    return var_1;
}

_id_3E04( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level.flags.size; var_2++ )
    {
        if ( level.flags[var_2] != var_0 && level.flags[var_2] != var_1 )
            return level.flags[var_2];
    }
}

_id_3E68( var_0 )
{
    var_1 = "_" + tolower( var_0 );
    _id_3E67( var_1 );
}

_id_3E67( var_0 )
{
    for ( var_1 = 0; var_1 < level.flags.size; var_1++ )
    {
        if ( level.flags[var_1].script_label == var_0 )
            return level.flags[var_1];
    }
}

_id_3CF5( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    foreach ( var_4 in level.flags )
    {
        var_5 = distancesquared( var_4.origin, var_0 );

        if ( !isdefined( var_2 ) || var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_id_3DF4( var_0, var_1 )
{
    var_2 = 0;
    var_3 = _id_3D6B();

    foreach ( var_5 in level.participants )
    {
        if ( !isdefined( var_5.team ) )
            continue;

        if ( var_5.team == self.team && var_5 != self && maps\mp\_utility::isteamparticipant( var_5 ) )
        {
            if ( isai( var_5 ) )
            {
                if ( var_5 _id_165B( var_0 ) )
                    var_2++;

                continue;
            }

            if ( !isdefined( var_1 ) || !var_1 )
            {
                if ( var_5 istouching( var_0 ) )
                    var_2++;
            }
        }
    }

    return var_2;
}

_id_165B( var_0 )
{
    if ( !maps\mp\bots\_bots_util::_id_165A() )
        return 0;

    return _id_170C( var_0 );
}

_id_1663( var_0 )
{
    if ( !maps\mp\bots\_bots_util::_id_1662() )
        return 0;

    return _id_170C( var_0 );
}

_id_170C( var_0 )
{
    return self._id_24E5 == var_0;
}

_id_3DF6( var_0 )
{
    var_1 = 0;

    for ( var_2 = 0; var_2 < level.flags.size; var_2++ )
    {
        var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

        if ( var_3 == var_0 )
            var_1++;
    }

    return var_1;
}

_id_3D4C( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level.flags.size; var_2++ )
    {
        var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

        if ( var_3 == common_scripts\utility::get_enemy_team( var_0 ) )
            var_1 = common_scripts\utility::array_add( var_1, level.flags[var_2] );
    }

    return var_1;
}

_id_3CC2( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level.flags.size; var_2++ )
    {
        var_3 = level.flags[var_2] maps\mp\gametypes\dom::getflagteam();

        if ( var_3 == var_0 )
            var_1 = common_scripts\utility::array_add( var_1, level.flags[var_2] );
    }

    return var_1;
}

_id_16F8( var_0, var_1 )
{
    var_2 = _id_3DD4( var_1 );
    var_3 = _id_3E2F( var_0 );
    return var_3.size < var_2;
}

_id_3DD4( var_0 )
{
    var_1 = maps\mp\bots\_bots_util::_id_1636( self.team );

    if ( var_0 == 1 )
        return ceil( var_1 / 6 );
    else
        return ceil( var_1 / 3 );
}

_id_3E2F( var_0 )
{
    var_1 = _id_3D6D();
    var_2 = [];

    foreach ( var_4 in level.participants )
    {
        if ( !isdefined( var_4.team ) )
            continue;

        if ( var_4.team == self.team && var_4 != self && maps\mp\_utility::isteamparticipant( var_4 ) )
        {
            if ( isai( var_4 ) )
            {
                if ( var_4 _id_1663( var_0 ) )
                    var_2 = common_scripts\utility::array_add( var_2, var_4 );

                continue;
            }

            var_5 = gettime() - var_0._id_5563[self.team];

            if ( var_5 < 10000 )
                continue;

            if ( distancesquared( var_0.origin, var_4.origin ) < var_1 * var_1 )
                var_2 = common_scripts\utility::array_add( var_2, var_4 );
        }
    }

    return var_2;
}
