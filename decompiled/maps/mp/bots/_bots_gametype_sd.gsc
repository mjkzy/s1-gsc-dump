// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_16D7();
}

_id_806C()
{
    level.bot_funcs["crate_can_use"] = ::_id_2363;
    level.bot_funcs["gametype_think"] = ::_id_16D8;
    level.bot_funcs["should_start_cautious_approach"] = ::_id_8478;
    level.bot_funcs["know_enemies_on_start"] = undefined;
    level.bot_funcs["notify_enemy_bots_bomb_used"] = ::_id_6203;
}

_id_16D7()
{
    _id_805A();
}

_id_2363( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0._id_175D ) )
        return 0;

    if ( !maps\mp\_utility::isteamparticipant( self ) )
        return 1;

    if ( !isdefined( self._id_7597 ) )
        return 0;

    switch ( self._id_7597 )
    {
        case "atk_bomber":
        case "bomb_defuser":
        case "investigate_someone_using_bomb":
            return 0;
    }

    return 1;
}

_id_805A()
{
    level._id_1744 = 1;
    level._id_4DCD = 3000;
    maps\mp\bots\_bots_gametype_common::_id_16F1();
    maps\mp\bots\_bots_util::_id_172D( 1 );
    level._id_16D6 = [];
    level._id_16D6["axis"] = [];
    level._id_16D6["allies"] = [];
    level._id_15EB["atk_bomber"] = ::_id_0D86;
    level._id_15EB["clear_target_zone"] = ::_id_1ED9;
    level._id_15EB["defend_planted_bomb"] = ::_id_27A6;
    level._id_15EB["bomb_defuser"] = ::_id_152B;
    level._id_15EB["investigate_someone_using_bomb"] = ::_id_4F9E;
    level._id_15EB["camp_bomb"] = ::_id_1A36;
    level._id_15EB["defender"] = ::_id_27AC;
    level._id_15EB["backstabber"] = ::_id_125B;
    level._id_15EB["random_killer"] = ::_id_7112;
    var_0 = 0;

    foreach ( var_2 in level.bombzones )
    {
        var_3 = _func_202( var_2.curorigin );

        if ( isdefined( var_3 ) )
            botzonesetteam( var_3, game["defenders"] );
    }

    if ( !var_0 )
    {
        maps\mp\bots\_bots_gametype_common::_id_15BE();
        thread _id_16D5();
        level._id_1628 = 1;
    }
}

_id_16D8()
{
    self notify( "bot_sd_think" );
    self endon( "bot_sd_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self _meth_8351( "separation", 0 );
    self _meth_8351( "grenade_objectives", 1 );
    self _meth_8351( "use_obj_path_style", 1 );
    var_0 = game["attackers"];
    var_1 = 1;

    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && level.sdbomb.carrier == self && isdefined( self._id_7597 ) && self._id_7597 == "atk_bomber" )
        var_1 = 0;

    if ( var_1 )
        self._id_7597 = undefined;

    self._id_8FF9 = undefined;
    self._id_46FD = 0;
    self._id_0D85 = 0;
    self._id_7B34 = undefined;
    self._id_27AB = undefined;
    self._id_27BB = 0;

    if ( !isdefined( level._id_4DC4 ) && !level.multibomb )
    {
        level._id_4DC4 = level.sdbomb.curorigin;
        level._id_4DC5 = getclosestnodeinsight( level.sdbomb.curorigin );
    }

    if ( self.team == var_0 && !isdefined( level._id_1A4B ) )
    {
        var_2 = 0;

        if ( !level.multibomb )
        {
            var_3 = _id_3DC7( var_0 );

            foreach ( var_5 in var_3 )
            {
                if ( !isai( var_5 ) )
                    var_2 = 1;
            }
        }

        if ( var_2 )
        {
            var_7 = 6000;
            level._id_1A4B = gettime() + var_7;
            badplace_cylinder( "bomb", var_7 / 1000, level.sdbomb.curorigin, 75, 300, var_0 );
        }
    }

    for (;;)
    {
        wait(randomintrange( 1, 3 ) * 0.05);

        if ( self.health <= 0 )
            continue;

        self._id_46FD = 1;

        if ( !isdefined( self._id_7597 ) )
            _id_4DD8();

        if ( isdefined( self._id_8FF9 ) )
            continue;

        if ( self.team == var_0 )
        {
            if ( !level.multibomb && isdefined( level._id_1A4B ) && gettime() < level._id_1A4B && !isdefined( level.sdbomb.carrier ) )
            {
                if ( !maps\mp\bots\_bots_util::_id_165E( level.sdbomb.curorigin ) )
                {
                    var_8 = getclosestnodeinsight( level.sdbomb.curorigin );

                    if ( isdefined( var_8 ) )
                    {
                        var_9["nearest_node_to_center"] = var_8;
                        maps\mp\bots\_bots_strategy::_id_16C2( level.sdbomb.curorigin, 900, var_9 );
                    }
                    else
                        level._id_1A4B = gettime();
                }
            }
            else
                self [[ level._id_15EB[self._id_7597] ]]();

            continue;
        }

        if ( level.bombplanted )
        {
            if ( distancesquared( self.origin, level.sdbombmodel.origin ) > squared( level._id_703C * 2 ) )
            {
                if ( !isdefined( self._id_27AB ) )
                {
                    self._id_27AB = 1;
                    self _meth_8379( "scripted" );
                }
            }
            else if ( isdefined( self._id_27AB ) && !isdefined( self._id_7B34 ) )
            {
                self._id_27AB = undefined;
                self _meth_8379( undefined );
            }
        }

        if ( level.bombplanted && isdefined( level._id_152A ) && self._id_7597 != "bomb_defuser" )
        {
            if ( !maps\mp\bots\_bots_util::_id_165E( level.sdbombmodel.origin ) )
            {
                self _meth_8356();
                maps\mp\bots\_bots_strategy::_id_16C2( level.sdbombmodel.origin, level._id_703C );
            }

            continue;
        }

        self [[ level._id_15EB[self._id_7597] ]]();
    }
}

_id_153A( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self _meth_8351( "disable_movement", 1 );
    self _meth_8352( "stand" );
    wait(var_0);
    self _meth_8351( "disable_movement", 0 );
    self _meth_8352( "none" );
}

_id_0D86()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && isalive( level.sdbomb.carrier ) && level.sdbomb.carrier != self )
        wait 0.7;

    if ( !self.isbombcarrier && !level.multibomb )
    {
        if ( isdefined( level.sdbomb ) )
        {
            if ( !isdefined( self._id_550B ) )
                self._id_550B = level.sdbomb.curorigin;

            if ( distancesquared( self._id_550B, level.sdbomb.curorigin ) > 4 )
            {
                self _meth_8356();
                self._id_550B = level.sdbomb.curorigin;
            }
        }

        if ( self._id_0D85 >= 2 )
        {
            var_1 = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );
            var_2 = undefined;

            foreach ( var_4 in var_1 )
            {
                if ( !var_4 _meth_8386() )
                {
                    var_2 = var_4;
                    break;
                }
            }

            if ( isdefined( var_2 ) )
            {
                self botsetscriptgoal( var_2.origin, 20, "critical" );
                maps\mp\bots\_bots_util::_id_172E();

                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                    level.sdbomb maps\mp\gametypes\_gameobjects::setpickedup( self );
            }
            else
            {

            }

            return;
        }

        if ( !self _meth_8365() )
        {
            var_6 = 15;
            var_7 = 32;
            var_8 = maps\mp\bots\_bots_util::_id_16C3( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3AE3, level.sdbomb.curorigin, var_6 + var_7, self );

            if ( isdefined( var_8 ) )
            {
                var_9 = self botsetscriptgoal( level.sdbomb.curorigin, 0, "critical" );

                if ( var_9 )
                {
                    childthread _id_153B();
                    return;
                }
            }
            else
            {
                var_1 = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );

                if ( var_1.size > 0 )
                {
                    self botsetscriptgoal( var_1[0].origin, 0, "critical" );
                    maps\mp\bots\_bots_util::_id_172E();
                }

                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                {
                    var_8 = maps\mp\bots\_bots_util::_id_16C3( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3AE3, level.sdbomb.curorigin, var_6 + var_7, self );

                    if ( !isdefined( var_8 ) )
                        level.sdbomb maps\mp\gametypes\_gameobjects::setpickedup( self );
                }
            }
        }
    }
    else
    {
        if ( isdefined( self._id_2D21 ) && gettime() < self._id_2D21 )
            return;

        if ( !isdefined( level._id_1535 ) )
            level._id_1535 = level.bombzones[randomint( level.bombzones.size )];

        var_10 = level._id_1535;
        self._id_1554 = var_10;

        if ( !isdefined( level._id_4DC6 ) || gettime() - level._id_4DC6 < level._id_4DCD )
        {
            level._id_4DC6 = gettime() + level._id_4DCD;
            thread _id_153A( level._id_4DCD / 1000 );
            wait(level._id_4DCD / 1000);
        }

        self _meth_8356();

        if ( level._id_0E0F == "rush" )
        {
            self _meth_8379( "scripted" );
            var_11 = self _meth_8380( var_10._id_174F, "node_exposed" );
            var_12 = self _meth_837B( "strategyLevel" ) * 0.45;
            var_13 = ( self _meth_837B( "strategyLevel" ) + 1 ) * 0.15;

            foreach ( var_4 in var_10._id_174F )
            {
                if ( !common_scripts\utility::array_contains( var_11, var_4 ) )
                    var_11[var_11.size] = var_4;
            }

            if ( randomfloat( 1.0 ) < var_12 )
                var_16 = var_11[0];
            else if ( randomfloat( 1.0 ) < var_13 )
                var_16 = var_11[1];
            else
                var_16 = common_scripts\utility::random( var_11 );

            self botsetscriptgoal( var_16.origin, 0, "critical" );
        }

        var_17 = maps\mp\bots\_bots_util::_id_172E();

        if ( var_17 == "goal" )
        {
            var_18 = _id_3E54() - gettime();
            var_19 = var_18 - level.planttime * 2 * 1000;
            var_20 = gettime() + var_19;

            if ( var_19 > 0 )
                maps\mp\bots\_bots_util::_id_172F( var_19 );

            var_21 = gettime() >= var_20;
            var_22 = _id_7B5F( level.planttime + 2, "bomb_planted", var_21 );
            self _meth_8356();

            if ( var_22 )
            {
                maps\mp\bots\_bots_strategy::_id_1604();
                _id_16EE( "defend_planted_bomb" );
            }
            else if ( var_19 > 5000 )
                self._id_2D21 = gettime() + 5000;
        }
    }
}

_id_3E54()
{
    if ( level.bombplanted )
        return level.defuseendtime;
    else
        return gettime() + maps\mp\gametypes\_gamelogic::gettimeremaining();
}

_id_153B()
{
    self notify( "bomber_monitor_no_path" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "goal" );
    self endon( "bomber_monitor_no_path" );
    level.sdbomb endon( "pickup_object" );

    for (;;)
    {
        self waittill( "no_path" );
        self._id_0D85++;
    }
}

_id_1ED9()
{
    self endon( "new_role" );

    if ( isdefined( level._id_0D84 ) )
    {
        if ( level._id_0E0F == "rush" )
        {
            if ( !isdefined( self._id_7E5B ) )
            {
                if ( !level.multibomb )
                {
                    var_0["nearest_node_to_center"] = level._id_4DC5;
                    maps\mp\bots\_bots_strategy::_id_16C2( level._id_4DC4, 900, var_0 );
                    wait(randomfloatrange( 0.0, 4.0 ));
                    maps\mp\bots\_bots_strategy::_id_15EF();
                }

                self._id_7E5B = 1;
            }

            if ( self _meth_837B( "strategyLevel" ) > 0 )
                _id_7E36();

            if ( isai( level._id_0D84 ) && isdefined( level._id_0D84._id_1554 ) )
                var_1 = level._id_0D84._id_1554;
            else if ( isdefined( level._id_1535 ) )
                var_1 = level._id_1535;
            else
                var_1 = _id_3757( level._id_0D84 );

            if ( !maps\mp\bots\_bots_util::_id_165E( var_1.curorigin ) )
            {
                var_0["min_goal_time"] = 2;
                var_0["max_goal_time"] = 4;
                var_0["override_origin_node"] = common_scripts\utility::random( var_1._id_174F );
                maps\mp\bots\_bots_strategy::_id_16C2( var_1.curorigin, level._id_703C, var_0 );
            }
        }
    }
}

_id_27A6()
{
    self endon( "new_role" );

    if ( level.bombplanted )
    {
        if ( level._id_0E0F == "rush" )
            _id_2AA4();

        if ( !maps\mp\bots\_bots_util::_id_165E( level.sdbombmodel.origin ) )
        {
            var_0["score_flags"] = "strongly_avoid_center";
            maps\mp\bots\_bots_strategy::_id_16C2( level.sdbombmodel.origin, level._id_703C, var_0 );
        }
    }
}

_id_152B()
{
    self endon( "new_role" );

    if ( level.bombdefused )
        return;

    var_0 = _id_376D();

    if ( !isdefined( var_0 ) )
        return;

    var_1 = common_scripts\utility::get_array_of_closest( level.sdbombmodel.origin, var_0._id_174F );
    var_2 = ( level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], var_1[0].origin[2] );

    if ( self._id_27BB <= 1 )
        var_3 = _id_1BD8( var_2, undefined );
    else
    {
        self _meth_8356();
        var_3 = self botsetscriptgoal( var_2, 20, "critical" );
    }

    if ( !var_3 )
        return;

    var_4 = maps\mp\bots\_bots_util::_id_172E();

    if ( var_4 == "bad_path" )
    {
        self._id_27BB++;

        if ( self._id_27BB >= 4 )
        {
            for (;;)
            {
                var_5 = getnodesinradiussorted( var_2, 50, 0 );
                var_6 = self._id_27BB - 4;

                if ( var_5.size <= var_6 )
                {
                    var_7 = _func_1FD( var_2, 50, self );

                    if ( isdefined( var_7 ) )
                        self botsetscriptgoal( var_7, 20, "critical" );
                    else
                        break;
                }
                else
                    self botsetscriptgoal( var_5[var_6].origin, 20, "critical" );

                var_4 = maps\mp\bots\_bots_util::_id_172E();

                if ( var_4 == "bad_path" )
                {
                    self._id_27BB++;
                    continue;
                }

                break;
            }
        }
    }

    if ( var_4 == "goal" )
    {
        var_8 = _id_3E54() - gettime();
        var_9 = var_8 - level.defusetime * 2 * 1000;
        var_10 = gettime() + var_9;

        if ( var_9 > 0 )
            maps\mp\bots\_bots_util::_id_172F( var_9 );

        var_11 = gettime() >= var_10;
        var_12 = level.sdbombmodel.origin[2] - self.origin[2];
        var_13 = _id_7B5F( level.defusetime + 2, "bomb_defused", var_11, var_12 > 40 );

        if ( !var_13 && self._id_27BB >= 4 )
            self._id_27BB++;

        self _meth_8356();
        maps\mp\bots\_bots_strategy::_id_1604();
    }
}

_id_4F9E()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    var_0 = _id_3757( self );
    self _meth_8355( common_scripts\utility::random( var_0._id_174F ), "guard" );
    var_1 = maps\mp\bots\_bots_util::_id_172E();

    if ( var_1 == "goal" )
    {
        wait 4;
        _id_16EE( self._id_6F41 );
    }
}

_id_1A36()
{
    self endon( "new_role" );

    if ( isdefined( level.sdbomb.carrier ) )
    {
        if ( self._id_6F41 == "defender" )
            self._id_27A8 = _id_3757( self );

        _id_16EE( self._id_6F41 );
    }
    else if ( !maps\mp\bots\_bots_util::_id_165E( level.sdbomb.curorigin ) )
    {
        var_0["nearest_node_to_center"] = level.sdbomb._id_606F;
        maps\mp\bots\_bots_strategy::_id_16C2( level.sdbomb.curorigin, level._id_703C, var_0 );
    }
}

_id_27AC()
{
    self endon( "new_role" );

    if ( !maps\mp\bots\_bots_util::_id_165E( self._id_27A8.curorigin ) )
    {
        var_0["score_flags"] = "strict_los";
        var_0["override_origin_node"] = common_scripts\utility::random( self._id_27A8._id_174F );
        maps\mp\bots\_bots_strategy::_id_16C2( self._id_27A8.curorigin, level._id_703C, var_0 );
    }
}

_id_125B()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    if ( !isdefined( self._id_125A ) )
        self._id_125A = "1_move_to_midpoint";

    if ( self._id_125A == "1_move_to_midpoint" )
    {
        var_0 = level.bombzones[0].curorigin;
        var_1 = level.bombzones[1].curorigin;
        var_2 = ( ( var_0[0] + var_1[0] ) * 0.5, ( var_0[1] + var_1[1] ) * 0.5, ( var_0[2] + var_1[2] ) * 0.5 );
        var_3 = getnodesinradiussorted( var_2, 512, 0 );

        if ( var_3.size == 0 )
        {
            _id_16EE( "random_killer" );
            return;
        }

        var_4 = undefined;
        var_5 = int( var_3.size * ( var_3.size + 1 ) * 0.5 );
        var_6 = randomint( var_5 );

        for ( var_7 = 0; var_7 < var_3.size; var_7++ )
        {
            var_8 = var_3.size - var_7;

            if ( var_6 < var_8 )
            {
                var_4 = var_3[var_7];
                break;
            }

            var_6 -= var_8;
        }

        self _meth_8379( "scripted" );
        var_9 = self _meth_8355( var_4, "guard" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::_id_172E();

            if ( var_10 == "goal" )
            {
                wait(randomfloatrange( 1.0, 4.0 ));
                self._id_125A = "2_move_to_enemy_spawn";
            }
        }
    }

    if ( self._id_125A == "2_move_to_enemy_spawn" )
    {
        var_11 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
        var_12 = common_scripts\utility::random( var_11 );
        self _meth_8379( "scripted" );
        var_9 = self botsetscriptgoal( var_12.origin, 250, "guard" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::_id_172E();

            if ( var_10 == "goal" )
                self._id_125A = "3_move_to_bombzone";
        }
    }

    if ( self._id_125A == "3_move_to_bombzone" )
    {
        if ( !isdefined( self._id_1553 ) )
            self._id_1553 = randomint( level.bombzones.size );

        self _meth_8379( undefined );
        var_9 = self botsetscriptgoal( common_scripts\utility::random( level.bombzones[self._id_1553]._id_174F ).origin, 160, "objective" );

        if ( var_9 )
        {
            var_10 = maps\mp\bots\_bots_util::_id_172E();

            if ( var_10 == "goal" )
            {
                self _meth_8356();
                self._id_125A = "2_move_to_enemy_spawn";
                self._id_1553 = 1 - self._id_1553;
            }
        }
    }
}

_id_7112()
{
    self endon( "new_role" );

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    self [[ self._id_67DE ]]();
}

_id_7E36()
{
    if ( !isdefined( self._id_0B08 ) )
    {
        self _meth_8351( "force_sprint", 1 );
        self._id_0B08 = 1;
    }
}

_id_2AA4()
{
    if ( isdefined( self._id_0B08 ) )
    {
        self _meth_8351( "force_sprint", 0 );
        self._id_0B08 = undefined;
    }
}

_id_7EB0()
{
    if ( !isdefined( self._id_7B34 ) )
    {
        self _meth_8379( "scripted" );
        self._id_7B34 = 1;
    }
}

_id_1BD8( var_0, var_1 )
{
    var_2 = level._id_1B4A;
    var_3["entrance_points_index"] = var_1;
    maps\mp\bots\_bots_strategy::_id_15D1( var_0, var_2, var_3 );
    wait 0.05;

    while ( distancesquared( self.origin, var_0 ) > var_2 * var_2 && maps\mp\bots\_bots_util::_id_165D() )
    {
        if ( _id_3E54() - gettime() < 20000 )
        {
            _id_7EB0();
            _id_7E36();
            break;
        }

        wait 0.05;
    }

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    return self botsetscriptgoal( var_0, 20, "critical" );
}

_id_7B5F( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;

    if ( self _meth_837B( "strategyLevel" ) == 1 )
        var_4 = 40;
    else if ( self _meth_837B( "strategyLevel" ) >= 2 )
        var_4 = 80;

    if ( randomint( 100 ) < var_4 && !( isdefined( var_3 ) && var_3 ) )
    {
        self _meth_8352( "prone" );
        wait 0.2;
    }

    if ( self _meth_837B( "strategyLevel" ) > 0 && !var_2 )
    {
        childthread _id_6218();
        childthread _id_6211();
    }

    self _meth_837E( "use", var_0 );
    var_5 = maps\mp\bots\_bots_util::_id_1724( var_0, var_1, "use_interrupted" );
    self _meth_8352( "none" );
    self _meth_837F( "use" );
    var_6 = var_5 == var_1;
    return var_6;
}

_id_6203( var_0 )
{
    var_1 = _id_3DC7( common_scripts\utility::get_enemy_team( self.team ), 1 );

    foreach ( var_3 in var_1 )
    {
        var_4 = 0;

        if ( var_0 == "plant" )
            var_4 = 300 + var_3 _meth_837B( "strategyLevel" ) * 100;
        else if ( var_0 == "defuse" )
            var_4 = 500 + var_3 _meth_837B( "strategyLevel" ) * 500;

        if ( distancesquared( var_3.origin, self.origin ) < squared( var_4 ) )
            var_3 _id_16EE( "investigate_someone_using_bomb" );
    }
}

_id_6218()
{
    var_0 = _id_3757( self );
    self waittill( "bulletwhizby", var_1 );

    if ( !isdefined( var_1.team ) || var_1.team != self.team )
    {
        var_2 = var_0.usetime - var_0.curprogress;

        if ( var_2 > 1000 )
            self notify( "use_interrupted" );
    }
}

_id_6211()
{
    self waittill( "damage", var_0, var_1 );

    if ( !isdefined( var_1.team ) || var_1.team != self.team )
        self notify( "use_interrupted" );
}

_id_8478( var_0 )
{
    var_1 = 2000;
    var_2 = var_1 * var_1;

    if ( var_0 )
    {
        if ( _id_3E54() - gettime() < 15000 )
            return 0;

        var_3 = 0;
        var_4 = common_scripts\utility::get_enemy_team( self.team );

        foreach ( var_6 in level.players )
        {
            if ( !isdefined( var_6.team ) )
                continue;

            if ( isalive( var_6 ) && var_6.team == var_4 )
                var_3 = 1;
        }

        return var_3;
    }
    else
        return distancesquared( self.origin, self._id_15F2 ) <= var_2 && self _meth_8375();
}

_id_3757( var_0 )
{
    var_1 = undefined;
    var_2 = 999999999;

    foreach ( var_4 in level.bombzones )
    {
        var_5 = distancesquared( var_4.curorigin, var_0.origin );

        if ( var_5 < var_2 )
        {
            var_1 = var_4;
            var_2 = var_5;
        }
    }

    return var_1;
}

_id_3E30( var_0 )
{
    var_1 = [];
    var_2 = _id_3DC7( game["defenders"] );

    foreach ( var_4 in var_2 )
    {
        if ( isai( var_4 ) && isdefined( var_4._id_7597 ) && var_4._id_7597 == "defender" )
        {
            if ( isdefined( var_4._id_27A8 ) && var_4._id_27A8 == var_0 )
                var_1 = common_scripts\utility::array_add( var_1, var_4 );

            continue;
        }

        if ( distancesquared( var_4.origin, var_0.curorigin ) < level._id_703C * level._id_703C )
            var_1 = common_scripts\utility::array_add( var_1, var_4 );
    }

    return var_1;
}

_id_376D()
{
    if ( isdefined( level.tickingobject ) )
    {
        foreach ( var_1 in level.bombzones )
        {
            if ( distancesquared( level.tickingobject.origin, var_1.curorigin ) < 90000 )
                return var_1;
        }
    }

    return undefined;
}

_id_3E69( var_0 )
{
    var_0 = "_" + tolower( var_0 );

    for ( var_1 = 0; var_1 < level.bombzones.size; var_1++ )
    {
        if ( level.bombzones[var_1].label == var_0 )
            return level.bombzones[var_1];
    }
}

_id_153D()
{
    self endon( "stopped_being_bomb_carrier" );
    self endon( "new_role" );
    common_scripts\utility::waittill_any( "death", "disconnect" );
    level._id_0D84 = undefined;
    level._id_5507 = gettime();

    if ( isdefined( self ) )
        self._id_7597 = undefined;

    var_0 = _id_3DC7( game["attackers"], 1 );
    _id_3987( var_0, undefined );
}

_id_153C()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stopped_being_bomb_carrier" );
    level.sdbomb endon( "pickup_object" );
    level.sdbomb waittill( "reset" );

    if ( maps\mp\_utility::isaiteamparticipant( self ) )
        self _meth_8356();

    _id_16EE( "atk_bomber" );
}

_id_7E7D()
{
    level._id_0D84 = self;
    _id_16EE( "atk_bomber" );
    thread _id_153D();

    if ( !level.multibomb )
        thread _id_153C();

    if ( isai( self ) )
    {
        maps\mp\bots\_bots_strategy::_id_15F9();

        if ( level._id_0E0F == "rush" && self _meth_837B( "strategyLevel" ) > 0 )
            _id_7E36();
    }
}

_id_4DD8()
{
    if ( self.team == game["attackers"] )
    {
        if ( level.bombplanted )
            _id_16EE( "defend_planted_bomb" );
        else if ( !isdefined( level._id_0D84 ) )
            _id_7E7D();
        else if ( level._id_0E0F == "rush" )
            _id_16EE( "clear_target_zone" );
    }
    else
    {
        var_0 = _id_3E2E( "backstabber" );
        var_1 = _id_3E2E( "defender" );
        var_2 = level._id_16B2[self._id_67DC];
        var_3 = self _meth_837B( "strategyLevel" );

        if ( var_2 == "active" )
        {
            if ( !isdefined( self._id_7597 ) && level._id_0A8E && var_3 > 0 )
            {
                if ( var_0.size == 0 )
                    _id_16EE( "backstabber" );
                else
                {
                    var_4 = 1;

                    foreach ( var_6 in var_0 )
                    {
                        var_7 = level._id_16B2[var_6._id_67DC];

                        if ( var_7 == "active" )
                        {
                            var_4 = 0;
                            break;
                        }
                    }

                    if ( var_4 )
                    {
                        _id_16EE( "backstabber" );
                        var_0[0] _id_16EE( undefined );
                    }
                }
            }

            if ( !isdefined( self._id_7597 ) )
            {
                if ( var_1.size < 4 )
                    _id_16EE( "defender" );
            }

            if ( !isdefined( self._id_7597 ) )
            {
                var_9 = randomint( 4 );

                if ( var_9 == 3 && level._id_0A9C && var_3 > 0 )
                    _id_16EE( "random_killer" );
                else if ( var_9 == 2 && level._id_0A8E && var_3 > 0 )
                    _id_16EE( "backstabber" );
                else
                    _id_16EE( "defender" );
            }
        }
        else if ( var_2 == "stationary" )
        {
            if ( !isdefined( self._id_7597 ) )
            {
                if ( var_1.size < 4 )
                    _id_16EE( "defender" );
                else
                {
                    foreach ( var_11 in var_1 )
                    {
                        var_12 = level._id_16B2[var_11._id_67DC];

                        if ( var_12 == "active" )
                        {
                            _id_16EE( "defender" );
                            var_11 _id_16EE( undefined );
                            break;
                        }
                    }
                }
            }

            if ( !isdefined( self._id_7597 ) && level._id_0A8E && var_3 > 0 )
            {
                if ( var_0.size == 0 )
                    _id_16EE( "backstabber" );
            }

            if ( !isdefined( self._id_7597 ) )
                _id_16EE( "defender" );
        }

        if ( self._id_7597 == "defender" )
        {
            var_14 = level.bombzones;

            if ( _id_46F5( self.team ) )
                var_14 = _id_3E13( self.team );

            if ( var_14.size == 1 )
                self._id_27A8 = var_14[0];
            else
            {
                var_15 = _id_3E30( var_14[0] );
                var_16 = _id_3E30( var_14[1] );

                if ( var_15.size < var_16.size )
                    self._id_27A8 = var_14[0];
                else if ( var_16.size < var_15.size )
                    self._id_27A8 = var_14[1];
                else
                    self._id_27A8 = common_scripts\utility::random( var_14 );
            }
        }
    }
}

_id_16EE( var_0 )
{
    if ( isai( self ) )
    {
        maps\mp\bots\_bots_strategy::_id_15EF();
        self _meth_8379( undefined );
    }

    self._id_6F41 = self._id_7597;
    self._id_7597 = var_0;
    self notify( "new_role" );
}

_id_16EF( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "new_role" );
    wait(var_1);
    _id_16EE( var_0 );
}

_id_3987( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_4 thread _id_16EF( var_1, randomfloatrange( 0.0, var_2 ) );
            continue;
        }

        var_4 thread _id_16EE( var_1 );
    }
}

_id_3E13( var_0 )
{
    return level._id_16D6[var_0];
}

_id_46F5( var_0 )
{
    var_1 = _id_3E13( var_0 );
    return var_1.size > 0;
}

_id_3E2E( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.participants )
    {
        if ( isalive( var_3 ) && maps\mp\_utility::isteamparticipant( var_3 ) && isdefined( var_3._id_7597 ) && var_3._id_7597 == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_id_3DC7( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in level.participants )
    {
        if ( !isdefined( var_4.team ) )
            continue;

        if ( maps\mp\_utility::isreallyalive( var_4 ) && maps\mp\_utility::isteamparticipant( var_4 ) && var_4.team == var_0 )
        {
            if ( !isdefined( var_1 ) || var_1 && isai( var_4 ) && isdefined( var_4._id_7597 ) )
                var_2[var_2.size] = var_4;
        }
    }

    return var_2;
}

_id_16D5()
{
    level notify( "bot_sd_ai_director_update" );
    level endon( "bot_sd_ai_director_update" );
    level endon( "game_ended" );
    level._id_0A8E = randomint( 3 ) <= 1;
    level._id_0A9C = randomint( 3 ) <= 1;
    level._id_0E0F = "rush";
    level._id_703C = 725;
    level._id_1B4A = 140;

    for (;;)
    {
        if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && !isai( level.sdbomb.carrier ) )
            level._id_1535 = _id_3757( level.sdbomb.carrier );

        var_0 = 0;

        if ( !level.bombplanted )
        {
            var_1 = _id_3DC7( game["attackers"] );

            foreach ( var_3 in var_1 )
            {
                if ( var_3.isbombcarrier )
                {
                    level._id_1A4B = gettime();

                    if ( !isdefined( level._id_0D84 ) || var_3 != level._id_0D84 )
                    {
                        if ( isdefined( level._id_0D84 ) && isalive( level._id_0D84 ) )
                        {
                            level._id_0D84 _id_16EE( undefined );
                            level._id_0D84 notify( "stopped_being_bomb_carrier" );
                        }

                        var_0 = 1;
                        var_3 _id_7E7D();
                    }
                }
            }

            if ( !level.multibomb && !isdefined( level.sdbomb.carrier ) )
            {
                var_5 = getclosestnodeinsight( level.sdbomb.curorigin );

                if ( isdefined( var_5 ) )
                {
                    level.sdbomb._id_606F = var_5;
                    var_6 = 0;
                    var_7 = _id_3DC7( game["defenders"], 1 );

                    foreach ( var_9 in var_7 )
                    {
                        var_10 = var_9 _meth_8387();
                        var_11 = var_9 _meth_837B( "strategyLevel" );

                        if ( var_11 > 0 && var_9._id_7597 != "camp_bomb" && isdefined( var_10 ) && getnodesintrigger( var_5, var_10, 1 ) )
                        {
                            var_12 = var_9 _meth_8373();

                            if ( common_scripts\utility::within_fov( var_9.origin, var_9.angles, level.sdbomb.curorigin, var_12 ) )
                            {
                                if ( var_11 >= 2 || distancesquared( var_9.origin, level.sdbomb.curorigin ) < squared( 700 ) )
                                {
                                    var_6 = 1;
                                    break;
                                }
                            }
                        }
                    }

                    if ( var_6 )
                    {
                        foreach ( var_9 in var_7 )
                        {
                            if ( var_9._id_7597 != "camp_bomb" && var_9 _meth_837B( "strategyLevel" ) > 0 )
                                var_9 _id_16EE( "camp_bomb" );
                        }
                    }
                }
            }

            var_16 = level.bombzones;

            if ( _id_46F5( game["defenders"] ) )
                var_16 = _id_3E13( game["defenders"] );

            for ( var_17 = 0; var_17 < var_16.size; var_17++ )
            {
                for ( var_18 = 0; var_18 < var_16.size; var_18++ )
                {
                    var_19 = _id_3E30( var_16[var_17] );
                    var_20 = _id_3E30( var_16[var_18] );

                    if ( var_19.size > var_20.size + 1 )
                    {
                        var_21 = [];

                        foreach ( var_3 in var_19 )
                        {
                            if ( isai( var_3 ) )
                                var_21 = common_scripts\utility::array_add( var_21, var_3 );
                        }

                        if ( var_21.size > 0 )
                        {
                            var_24 = common_scripts\utility::random( var_21 );
                            var_24 maps\mp\bots\_bots_strategy::_id_15EF();
                            var_24._id_27A8 = var_16[var_18];
                        }
                    }
                }
            }
        }
        else
        {
            if ( isdefined( level._id_0D84 ) )
                level._id_0D84 = undefined;

            if ( !isdefined( level._id_152A ) || !isalive( level._id_152A ) )
            {
                var_25 = [];
                var_26 = _id_3E2E( "defender" );
                var_27 = _id_3E2E( "backstabber" );
                var_28 = _id_3E2E( "random_killer" );

                if ( var_26.size > 0 )
                    var_25 = var_26;
                else if ( var_27.size > 0 )
                    var_25 = var_27;
                else if ( var_28.size > 0 )
                    var_25 = var_28;

                if ( var_25.size > 0 )
                {
                    var_29 = common_scripts\utility::get_array_of_closest( level.sdbombmodel.origin, var_25 );
                    level._id_152A = var_29[0];
                    level._id_152A _id_16EE( "bomb_defuser" );
                    level._id_152A maps\mp\bots\_bots_strategy::_id_15F9();
                    level._id_152A thread _id_27BC();
                }
            }

            if ( !isdefined( level._id_7B4B ) )
            {
                level._id_7B4B = 1;
                var_30 = _id_3DC7( game["attackers"] );

                foreach ( var_3 in var_30 )
                {
                    if ( isdefined( var_3._id_7597 ) )
                    {
                        if ( var_3._id_7597 == "atk_bomber" )
                        {
                            var_3 thread _id_16EE( undefined );
                            continue;
                        }

                        if ( var_3._id_7597 != "defend_planted_bomb" )
                            var_3 thread _id_16EF( "defend_planted_bomb", randomfloatrange( 0.0, 3.0 ) );
                    }
                }
            }
        }

        wait 0.5;
    }
}

_id_27BC()
{
    common_scripts\utility::waittill_any( "death", "disconnect" );
    level._id_152A = undefined;
}
