// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_8254()
{
    level._id_16B0 = [];
    level._id_16B1 = [];
    level._id_16B0["active"][0] = "default";
    level._id_16B0["active"][1] = "run_and_gun";
    level._id_16B0["active"][2] = "cqb";
    level._id_16B0["stationary"][0] = "camper";
    level._id_16B2 = [];

    foreach ( var_5, var_1 in level._id_16B0 )
    {
        foreach ( var_3 in var_1 )
        {
            level._id_16B2[var_3] = var_5;
            level._id_16B1[level._id_16B1.size] = var_3;
        }
    }

    level._id_16B3 = [];
    level._id_16B3["active"] = 4;
    level._id_16B3["stationary"] = 1;
    level._id_16AE = [];
    level._id_16AE["default"] = ::_id_4D2D;
    level._id_16AE["camper"] = ::_id_4D2C;
    level._id_16AF["default"] = ::_id_9ACA;
    level._id_16AF["camper"] = ::_id_9AC9;
}

_id_15AD()
{
    self._id_67DC = self _meth_8366();
    self.pers["personality"] = self._id_67DC;
    self._id_67DD = level._id_16AE[self._id_67DC];

    if ( !isdefined( self._id_67DD ) )
        self._id_67DD = level._id_16AE["default"];

    self [[ self._id_67DD ]]();
    self._id_67DE = level._id_16AF[self._id_67DC];

    if ( !isdefined( self._id_67DE ) )
        self._id_67DE = level._id_16AF["default"];
}

_id_15B0()
{
    if ( isdefined( self._id_67DF ) && self._id_67DF )
        return;

    if ( isdefined( self.pers["personality"] ) )
    {
        self _meth_8369( self.pers["personality"] );
        return;
    }

    var_0 = self.team;

    if ( !isdefined( var_0 ) && !isdefined( self.bot_team ) )
        var_0 = self.pers["team"];

    var_1 = [];
    var_2 = [];

    foreach ( var_8, var_4 in level._id_16B0 )
    {
        var_2[var_8] = 0;

        foreach ( var_6 in var_4 )
            var_1[var_6] = 0;
    }

    foreach ( var_10 in level.participants )
    {
        if ( maps\mp\_utility::isteamparticipant( var_10 ) && isdefined( var_10.team ) && var_10.team == var_0 && var_10 != self && isdefined( var_10._id_46DD ) )
        {
            var_6 = var_10 _meth_8366();
            var_8 = level._id_16B2[var_6];
            var_1[var_6] += 1;
            var_2[var_8] += 1;
        }
    }

    var_12 = undefined;

    while ( !isdefined( var_12 ) )
    {
        for ( var_13 = level._id_16B3; var_13.size > 0; var_13[var_14] = undefined )
        {
            var_14 = maps\mp\bots\_bots_util::_id_163C( var_13, randomint( var_13.size ) );
            var_2[var_14] -= level._id_16B3[var_14];

            if ( var_2[var_14] < 0 )
            {
                var_12 = var_14;
                break;
            }
        }
    }

    var_15 = undefined;
    var_16 = undefined;
    var_17 = 9999;
    var_18 = undefined;
    var_19 = -9999;
    var_20 = common_scripts\utility::array_randomize( level._id_16B0[var_12] );

    foreach ( var_6 in var_20 )
    {
        if ( var_1[var_6] < var_17 )
        {
            var_16 = var_6;
            var_17 = var_1[var_6];
        }

        if ( var_1[var_6] > var_19 )
        {
            var_18 = var_6;
            var_19 = var_1[var_6];
        }
    }

    if ( var_19 - var_17 >= 2 )
        var_15 = var_16;
    else
        var_15 = common_scripts\utility::random( level._id_16B0[var_12] );

    if ( self _meth_8366() != var_15 )
        self _meth_8369( var_15 );

    self._id_46DD = 1;
}

_id_4D2C()
{
    _id_1EA3();
}

_id_4D2D()
{
    _id_1EA3();
}

_id_9AC9()
{
    if ( _id_8470() && !maps\mp\bots\_bots_util::_id_165D() && !maps\mp\bots\_bots_util::_id_1664() )
    {
        var_0 = self _meth_835D();
        var_1 = 0;

        if ( !isdefined( self._id_1A41 ) )
            self._id_1A41 = 0;

        var_2 = var_0 == "hunt";
        var_3 = gettime() > self._id_1A41 + 10000;

        if ( ( !var_2 || var_3 ) && !maps\mp\bots\_bots_util::_id_16AB() )
        {
            if ( !self _meth_8365() )
                _id_16C7();

            var_1 = _id_3755();

            if ( !var_1 )
                self._id_1A41 = gettime();
        }

        if ( isdefined( var_1 ) && var_1 )
        {
            self._id_0B62 = maps\mp\bots\_bots_util::_id_16C3( "bot_find_ambush_entrances", ::_id_160F, self._id_611E, 1 );
            var_4 = maps\mp\bots\_bots_strategy::_id_162B( "trap_directional", "trap", "c4" );

            if ( isdefined( var_4 ) )
            {
                var_5 = gettime();
                maps\mp\bots\_bots_strategy::_id_16E8( var_4, self._id_0B62, self._id_611E, self._id_0B68 );
                var_5 = gettime() - var_5;

                if ( var_5 > 0 && isdefined( self._id_0B61 ) && isdefined( self._id_611E ) )
                {
                    self._id_0B61 += var_5;
                    self._id_611E._id_15AC = self._id_0B61 + 10000;
                }
            }

            if ( !maps\mp\bots\_bots_strategy::_id_1649() && !maps\mp\bots\_bots_util::_id_165D() && isdefined( self._id_611E ) )
            {
                self _meth_8355( self._id_611E, "camp", self._id_0B68 );
                thread _id_1ED2( "bad_path", "node_relinquished", "out_of_ammo" );
                thread _id_A1E4();
                thread _id_15A2( "clear_camper_data", "goal" );
                thread _id_1732( "clear_camper_data", "bot_add_ambush_time_delayed", self._id_0B62, self._id_0B68 );
                childthread _id_171B( "clear_camper_data", "goal" );
                return;
            }
        }
        else
        {
            if ( var_0 == "camp" )
                self _meth_8356();

            _id_9ACA();
        }
    }
}

_id_9ACA()
{
    var_0 = undefined;
    var_1 = self _meth_8365();

    if ( var_1 )
        var_0 = self _meth_835A();

    if ( gettime() - self.lastspawntime > 5000 )
        _id_171B();

    if ( !maps\mp\bots\_bots_strategy::_id_1649() && !maps\mp\bots\_bots_util::_id_1664() )
    {
        var_2 = undefined;
        var_3 = undefined;

        if ( var_1 )
        {
            var_2 = distancesquared( self.origin, var_0 );
            var_3 = self _meth_835B();
            var_4 = var_3 * 2;

            if ( isdefined( self._id_16A1 ) && var_2 < var_4 * var_4 )
            {
                var_5 = botmemoryflags( "investigated" );
                botflagmemoryevents( 0, gettime() - self._id_16A2, 1, self._id_16A1, var_4, "kill", var_5, self );
                botflagmemoryevents( 0, gettime() - self._id_16A2, 1, self._id_16A1, var_4, "death", var_5, self );
                self._id_16A1 = undefined;
                self._id_16A2 = undefined;
            }
        }

        if ( !var_1 || var_2 < var_3 * var_3 )
        {
            var_6 = _id_16C7();

            if ( var_6 && randomfloat( 100 ) < 25 )
            {
                var_7 = maps\mp\bots\_bots_strategy::_id_162B( "trap_directional", "trap" );

                if ( isdefined( var_7 ) )
                {
                    var_8 = self _meth_835A();

                    if ( isdefined( var_8 ) )
                    {
                        var_9 = getclosestnodeinsight( var_8 );

                        if ( isdefined( var_9 ) )
                        {
                            var_10 = _id_160F( var_9, 0 );
                            var_11 = maps\mp\bots\_bots_strategy::_id_16E8( var_7, var_10, var_9 );

                            if ( !isdefined( var_11 ) || var_11 )
                            {
                                self _meth_8356();
                                var_6 = _id_16C7();
                            }
                        }
                    }
                }
            }

            if ( var_6 )
                thread _id_1ED2( "enemy", "bad_path", "goal", "node_relinquished", "search_end" );
        }
    }
}

_id_171B( var_0, var_1 )
{
    self notify( "bot_try_trap_follower" );
    self endon( "bot_try_trap_follower" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        self endon( var_0 );

    self endon( "node_relinquished" );
    self endon( "bad_path" );

    if ( isdefined( var_1 ) )
        self waittill( var_1 );

    var_2 = maps\mp\bots\_bots_strategy::_id_162B( "trap_follower" );

    if ( isdefined( var_2 ) && self isonground() )
    {
        var_3 = maps\mp\bots\_bots_util::_id_1637( 300, 600, 0.7, 1 );

        if ( var_3.size > 0 )
        {
            self _meth_837E( var_2["item_action"] );
            common_scripts\utility::waittill_any_timeout( 5, "grenade_fire", "missile_fire" );
        }
    }
}

_id_1ED2( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "clear_script_goal_on" );
    self endon( "clear_script_goal_on" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "start_tactical_goal" );
    var_5 = self _meth_835A();
    var_6 = 1;

    while ( var_6 )
    {
        var_7 = common_scripts\utility::waittill_any_return( var_0, var_1, var_2, var_3, var_4, "script_goal_changed" );
        var_6 = 0;
        var_8 = 1;

        if ( var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed" )
        {
            if ( !self _meth_8365() )
                var_8 = 0;
            else
            {
                var_9 = self _meth_835A();
                var_8 = maps\mp\bots\_bots_util::_id_172A( var_5, var_9 );
            }
        }

        if ( var_7 == "enemy" && isdefined( self._id_0143 ) )
        {
            var_8 = 0;
            var_6 = 1;
        }

        if ( var_8 )
            self _meth_8356();
    }
}

_id_A1E4()
{
    self notify( "watch_out_of_ammo" );
    self endon( "watch_out_of_ammo" );
    self endon( "death" );
    self endon( "disconnect" );

    while ( !maps\mp\bots\_bots_util::_id_16AB() )
        wait 0.5;

    self notify( "out_of_ammo" );
}

_id_15A2( var_0, var_1 )
{
    self notify( "bot_add_ambush_time_delayed" );
    self endon( "bot_add_ambush_time_delayed" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( var_0 ) )
        self endon( var_0 );

    self endon( "node_relinquished" );
    self endon( "bad_path" );
    var_2 = gettime();

    if ( isdefined( var_1 ) )
        self waittill( var_1 );

    if ( isdefined( self._id_0B61 ) && isdefined( self._id_611E ) )
    {
        self._id_0B61 += gettime() - var_2;
        self._id_611E._id_15AC = self._id_0B61 + 10000;
    }

    self notify( "bot_add_ambush_time_delayed" );
}

_id_1732( var_0, var_1, var_2, var_3 )
{
    self notify( "bot_watch_entrances_delayed" );

    if ( var_2.size > 0 )
    {
        self endon( "bot_watch_entrances_delayed" );
        self endon( "death" );
        self endon( "disconnect" );
        self endon( var_0 );
        self endon( "node_relinquished" );
        self endon( "bad_path" );

        if ( isdefined( var_1 ) )
            self waittill( var_1 );

        self endon( "path_enemy" );
        childthread maps\mp\bots\_bots_util::_id_1736( var_2, var_3, 0, self._id_0B61 );
        childthread _id_16A8();
    }
}

_id_16A8()
{
    self notify( "bot_monitor_watch_entrances_camp" );
    self endon( "bot_monitor_watch_entrances_camp" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );
    self endon( "disconnect" );
    self endon( "death" );

    while ( !isdefined( self._id_A1E1 ) )
        wait 0.05;

    while ( isdefined( self._id_A1E1 ) )
    {
        foreach ( var_1 in self._id_A1E1 )
            var_1._id_A1E0[self.entity_number] = 1.0;

        maps\mp\bots\_bots_strategy::_id_6FBA( 0.5 );
        wait(randomfloatrange( 0.5, 0.75 ));
    }
}

_id_160F( var_0, var_1 )
{
    self endon( "disconnect" );
    var_2 = [];
    var_3 = nodeexposedtosky( var_0.origin );

    if ( isdefined( var_3 ) && var_3.size > 0 )
    {
        wait 0.05;
        var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";

        if ( var_4 && var_1 )
            var_3 = self _meth_8380( var_3, "node_exposure_vis", var_0.origin, "crouch" );

        foreach ( var_6 in var_3 )
        {
            if ( distancesquared( self.origin, var_6.origin ) < 90000 )
                continue;

            if ( var_4 && var_1 )
            {
                wait 0.05;

                if ( !maps\mp\bots\_bots_util::_id_332A( var_6.origin, var_0.origin, "crouch" ) )
                    continue;
            }

            var_2[var_2.size] = var_6;
        }
    }

    return var_2;
}

_id_160B( var_0 )
{
    var_1 = [];
    var_2 = gettime();
    var_3 = var_0.size;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( !isdefined( var_5._id_15AC ) || var_2 > var_5._id_15AC )
            var_1[var_1.size] = var_5;
    }

    return var_1;
}

_id_160C( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = [];
    var_5 = var_2 * var_2;

    if ( level.teambased )
    {
        foreach ( var_7 in level.participants )
        {
            if ( !maps\mp\_utility::isreallyalive( var_7 ) )
                continue;

            if ( !isdefined( var_7.team ) )
                continue;

            if ( var_7.team == var_1.team && var_7 != var_1 && isdefined( var_7._id_611E ) )
                var_4[var_4.size] = var_7._id_611E.origin;
        }
    }

    var_9 = var_4.size;
    var_10 = var_0.size;

    for ( var_11 = 0; var_11 < var_10; var_11++ )
    {
        var_12 = 0;
        var_13 = var_0[var_11];

        for ( var_14 = 0; !var_12 && var_14 < var_9; var_14++ )
        {
            var_15 = distancesquared( var_4[var_14], var_13.origin );
            var_12 = var_15 < var_5;
        }

        if ( !var_12 )
            var_3[var_3.size] = var_13;
    }

    return var_3;
}

_id_1EA3()
{
    self notify( "clear_camper_data" );

    if ( isdefined( self._id_611E ) && isdefined( self._id_611E._id_15AC ) )
        self._id_611E._id_15AC = undefined;

    self._id_611E = undefined;
    self._id_6E1E = undefined;
    self._id_0B68 = undefined;
    self._id_0B62 = undefined;
    self._id_0B60 = randomintrange( 20000, 30000 );
    self._id_0B61 = -1;
}

_id_8470()
{
    if ( maps\mp\bots\_bots_strategy::_id_1649() )
        return 0;

    if ( gettime() > self._id_0B61 )
        return 1;

    if ( !self _meth_8365() )
        return 1;

    return 0;
}

_id_3755()
{
    self notify( "find_camp_node" );
    self endon( "find_camp_node" );
    return maps\mp\bots\_bots_util::_id_16C3( "find_camp_node_worker", ::_id_3756 );
}

_id_3756()
{
    self notify( "find_camp_node_worker" );
    self endon( "find_camp_node_worker" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    _id_1EA3();

    if ( level._id_A3E6 <= 0 )
        return 0;

    var_0 = _func_202( self.origin );
    var_1 = undefined;
    var_2 = undefined;
    var_3 = self.angles;

    if ( isdefined( var_0 ) )
    {
        var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1 );

        if ( !isdefined( var_4 ) )
            var_4 = botzonenearestcount( var_0, self.team, -1, "enemy_predict", ">", 0 );

        if ( isdefined( var_4 ) )
        {
            var_5 = _func_208( var_4 );
            var_6 = getlinkednodes( var_5 );

            if ( var_6.size == 0 )
                var_4 = undefined;
        }

        if ( !isdefined( var_4 ) )
        {
            var_7 = -1;
            var_8 = -1;

            for ( var_9 = 0; var_9 < level._id_A3E6; var_9++ )
            {
                var_5 = _func_208( var_9 );
                var_6 = getlinkednodes( var_5 );

                if ( var_6.size > 0 )
                {
                    var_10 = common_scripts\utility::random( _func_203( var_9 ) );
                    var_11 = isdefined( var_10.targetname ) && var_10.targetname == "no_bot_random_path";

                    if ( !var_11 )
                    {
                        var_12 = _func_220( _func_205( var_9 ), self.origin );

                        if ( var_12 > var_7 )
                        {
                            var_7 = var_12;
                            var_8 = var_9;
                        }
                    }
                }
            }

            var_4 = var_8;
        }

        var_13 = _func_204( var_0, var_4 );

        if ( !isdefined( var_13 ) || var_13.size == 0 )
            return 0;

        for ( var_14 = 0; var_14 <= int( var_13.size / 2 ); var_14++ )
        {
            var_1 = var_13[var_14];
            var_2 = var_13[int( min( var_14 + 1, var_13.size - 1 ) )];

            if ( botzonegetcount( var_2, self.team, "enemy_predict" ) != 0 )
                break;
        }

        if ( isdefined( var_1 ) && isdefined( var_2 ) && var_1 != var_2 )
        {
            var_3 = _func_205( var_2 ) - _func_205( var_1 );
            var_3 = vectortoangles( var_3 );
        }
    }

    var_15 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_16 = 1;
        var_17 = 1;
        var_18 = 0;

        while ( var_16 )
        {
            var_19 = _func_207( var_1, 800 * var_17, 1 );

            if ( var_19.size > 1024 )
                var_19 = _func_203( var_1, 0 );

            wait 0.05;
            var_20 = randomint( 100 );

            if ( var_20 < 66 && var_20 >= 33 )
                var_3 = ( var_3[0], var_3[1] + 45, 0 );
            else if ( var_20 < 33 )
                var_3 = ( var_3[0], var_3[1] - 45, 0 );

            if ( var_19.size > 0 )
            {
                while ( var_19.size > 1024 )
                    var_19[var_19.size - 1] = undefined;

                var_21 = int( clamp( var_19.size * 0.15, 1, 10 ) );

                if ( var_18 )
                    var_19 = self _meth_8371( var_19, var_21, var_21, "node_camp", anglestoforward( var_3 ), "lenient" );
                else
                    var_19 = self _meth_8371( var_19, var_21, var_21, "node_camp", anglestoforward( var_3 ) );

                var_19 = _id_160B( var_19 );

                if ( !isdefined( self._id_1A47 ) || !self._id_1A47 )
                {
                    var_22 = 800;
                    var_19 = _id_160C( var_19, self, var_22 );
                }

                if ( var_19.size > 0 )
                    var_15 = common_scripts\utility::random_weight_sorted( var_19 );
            }

            if ( isdefined( var_15 ) )
                var_16 = 0;
            else if ( isdefined( self._id_1A43 ) )
            {
                if ( var_17 == 1 && !var_18 )
                    var_17 = 3;
                else if ( var_17 == 3 && !var_18 )
                    var_18 = 1;
                else if ( var_17 == 3 && var_18 )
                    var_16 = 0;
            }
            else
                var_16 = 0;

            if ( var_16 )
                wait 0.05;
        }
    }

    if ( !isdefined( var_15 ) || !self _meth_8360( var_15 ) )
        return 0;

    self._id_611E = var_15;
    self._id_0B61 = gettime() + self._id_0B60;
    self._id_611E._id_15AC = self._id_0B61;
    self._id_0B68 = var_3[1];
    return 1;
}

_id_3751( var_0, var_1 )
{
    _id_1EA3();

    if ( isdefined( var_0 ) )
        self._id_6E1E = var_0;
    else
    {
        var_2 = undefined;
        var_3 = getnodesinradius( self.origin, 5000, 0, 2000 );

        if ( var_3.size > 0 )
            var_2 = self _meth_8364( var_3, var_3.size * 0.25, "node_traffic" );

        if ( isdefined( var_2 ) )
            self._id_6E1E = var_2.origin;
        else
            return 0;
    }

    var_4 = 2000;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    var_5 = getnodesinradius( self._id_6E1E, var_4, 0, 1000 );
    var_6 = undefined;

    if ( var_5.size > 0 )
    {
        var_7 = int( max( 1, int( var_5.size * 0.15 ) ) );
        var_5 = self _meth_8371( var_5, var_7, var_7, "node_ambush", self._id_6E1E );
    }

    var_5 = _id_160B( var_5 );

    if ( var_5.size > 0 )
        var_6 = common_scripts\utility::random_weight_sorted( var_5 );

    if ( !isdefined( var_6 ) || !self _meth_8360( var_6 ) )
        return 0;

    self._id_611E = var_6;
    self._id_0B61 = gettime() + self._id_0B60;
    self._id_611E._id_15AC = self._id_0B61;
    var_8 = vectornormalize( self._id_6E1E - self._id_611E.origin );
    var_9 = vectortoangles( var_8 );
    self._id_0B68 = var_9[1];
    return 1;
}

_id_16C7()
{
    if ( maps\mp\bots\_bots_util::_id_1664() )
        return 0;

    var_0 = level._id_16C9[self.team];
    return self [[ var_0 ]]();
}

_id_16C8()
{
    var_0 = 0;
    var_1 = 50;

    if ( self._id_67DC == "camper" )
        var_1 = 0;

    var_2 = undefined;

    if ( randomint( 100 ) < var_1 )
        var_2 = maps\mp\bots\_bots_util::_id_16CB();

    if ( !isdefined( var_2 ) )
    {
        var_3 = self _meth_8361();

        if ( isdefined( var_3 ) )
            var_2 = var_3.origin;
    }

    if ( isdefined( var_2 ) )
        var_0 = self botsetscriptgoal( var_2, 128, "hunt" );

    return var_0;
}

_id_16F3()
{
    if ( maps\mp\_utility::practiceroundgame() )
        return "practice" + randomintrange( 1, 6 );

    if ( maps\mp\bots\_bots_loadout::_id_16F4() )
        return "callback";
    else
        return "class0";
}
