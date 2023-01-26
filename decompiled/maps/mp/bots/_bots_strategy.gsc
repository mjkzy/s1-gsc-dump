// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_15ED()
{
    var_0 = _id_15EC( self._id_24BD );

    if ( isdefined( var_0 ) && var_0.size > 0 )
        return common_scripts\utility::random( var_0 ).origin;

    return undefined;
}

_id_15EC( var_0, var_1 )
{
    if ( isdefined( self._id_27A2 ) )
        return maps\mp\bots\_bots_util::_id_162D( var_0, self._id_27A2, var_1 );

    return [];
}

_id_162B( var_0, var_1, var_2 )
{
    if ( self _meth_837B( "allowGrenades" ) == 0 )
        return;

    var_3 = [];
    var_4 = [];
    var_4[var_4.size] = var_0;

    if ( isdefined( var_1 ) )
        var_4[var_4.size] = var_1;

    if ( isdefined( var_1 ) )
        var_4[var_4.size] = var_2;

    if ( var_4.size == 0 )
        return;

    var_5 = self _meth_8403( "lethal" );
    var_6 = self _meth_8403( "tactical" );
    var_7 = isdefined( var_5 ) && ( self getweaponammoclip( var_5 ) > 0 || self getweaponammostock( var_5 ) > 0 );
    var_8 = isdefined( var_6 ) && ( self getweaponammoclip( var_6 ) > 0 || self getweaponammostock( var_6 ) > 0 );

    if ( !var_7 && !var_8 )
        return;

    foreach ( var_10 in var_4 )
    {
        if ( var_7 && maps\mp\bots\_bots_util::_id_1645( var_10, var_5 ) )
        {
            var_3["purpose"] = var_10;
            var_3["item_action"] = "lethal";
            return var_3;
        }

        if ( var_8 && maps\mp\bots\_bots_util::_id_1645( var_10, var_6 ) )
        {
            var_3["purpose"] = var_10;
            var_3["item_action"] = "tactical";
            return var_3;
        }
    }
}

_id_16E8( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "bot_set_ambush_trap" );
    self endon( "bot_set_ambush_trap" );

    if ( !isdefined( var_0 ) )
        return 0;

    var_5 = undefined;

    if ( !isdefined( var_4 ) && isdefined( var_1 ) && var_1.size > 0 )
    {
        if ( !isdefined( var_2 ) )
            return 0;

        var_6 = [];
        var_7 = undefined;

        if ( isdefined( var_3 ) )
            var_7 = anglestoforward( ( 0, var_3, 0 ) );

        foreach ( var_9 in var_1 )
        {
            if ( !isdefined( var_7 ) )
            {
                var_6[var_6.size] = var_9;
                continue;
            }

            if ( distancesquared( var_9.origin, var_2.origin ) > 90000 )
            {
                if ( vectordot( var_7, vectornormalize( var_9.origin - var_2.origin ) ) < 0.4 )
                    var_6[var_6.size] = var_9;
            }
        }

        if ( var_6.size > 0 )
        {
            var_5 = common_scripts\utility::random( var_6 );
            var_11 = getnodesinradius( var_5.origin, 300, 50 );
            var_12 = [];

            foreach ( var_14 in var_11 )
            {
                if ( !isdefined( var_14._id_15AC ) )
                    var_12[var_12.size] = var_14;
            }

            var_11 = var_12;
            var_4 = self _meth_8364( var_11, min( var_11.size, 3 ), "node_trap", var_2, var_5 );
        }
    }

    if ( isdefined( var_4 ) )
    {
        var_16 = undefined;

        if ( var_0["purpose"] == "trap_directional" && isdefined( var_5 ) )
        {
            var_17 = vectortoangles( var_5.origin - var_4.origin );
            var_16 = var_17[1];
        }

        if ( self _meth_8365() && self _meth_835D() != "critical" && self _meth_835D() != "tactical" )
            self _meth_8356();

        var_18 = self _meth_8355( var_4, "guard", var_16 );

        if ( var_18 )
        {
            var_19 = maps\mp\bots\_bots_util::_id_172E();

            if ( var_19 == "goal" )
            {
                thread maps\mp\bots\_bots_util::_id_161A( "stand", 5.0 );

                if ( !isdefined( self._id_0143 ) || 0 == self _meth_836F( self._id_0143 ) )
                {
                    if ( isdefined( var_16 ) )
                        self _meth_8367( var_5.origin, var_0["item_action"] );
                    else
                        self _meth_8367( self.origin + anglestoforward( self.angles ) * 50, var_0["item_action"] );

                    self._id_0B66 = undefined;
                    thread _id_16E9( "grenade_fire" );
                    thread _id_16E9( "missile_fire" );
                    var_20 = 3.0;

                    if ( var_0["purpose"] == "tacticalinsertion" )
                        var_20 = 6.0;

                    common_scripts\utility::waittill_any_timeout( var_20, "missile_fire", "grenade_fire" );
                    wait 0.05;
                    self notify( "ambush_trap_ent" );

                    if ( isdefined( self._id_0B66 ) && var_0["purpose"] == "c4" )
                        thread _id_1734( self._id_0B66, var_0["item_action"], 300 );

                    self._id_0B66 = undefined;
                    wait(randomfloat( 0.25 ));
                    self _meth_8352( "none" );
                }
            }

            return 1;
        }
    }

    return 0;
}

_id_16E9( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bot_set_ambush_trap" );
    self endon( "ambush_trap_ent" );
    level endon( "game_ended" );
    self waittill( var_0, var_1 );
    self._id_0B66 = var_1;
}

_id_1734( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_3 = var_2 * var_2;

    for (;;)
    {
        if ( distancesquared( self.origin, var_0.origin ) > var_3 )
        {
            var_4 = self _meth_8176( var_0.origin, 1.0 );

            if ( var_4 < var_3 )
            {
                self _meth_837E( var_1 );
                return;
            }
        }

        wait(randomfloatrange( 0.25, 1.0 ));
    }
}

_id_15D1( var_0, var_1, var_2 )
{
    thread _id_15F0( var_0, var_1, "capture", var_2 );
}

_id_15D2( var_0, var_1, var_2, var_3 )
{
    var_3["capture_trigger"] = var_2;
    thread _id_15F0( var_0, var_1, "capture_zone", var_3 );
}

_id_16C2( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 12;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 18;

    thread _id_15F0( var_0, var_1, "protect", var_2 );
}

_id_16AD( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 0.0;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 0.01;

    thread _id_15F0( var_0, var_1, "patrol", var_2 );
}

_id_1646( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) || !isdefined( var_2["min_goal_time"] ) )
        var_2["min_goal_time"] = 15;

    if ( !isdefined( var_2 ) || !isdefined( var_2["max_goal_time"] ) )
        var_2["max_goal_time"] = 20;

    thread _id_15F0( var_0, var_1, "bodyguard", var_2 );
}

_id_15F0( var_0, var_1, var_2, var_3 )
{
    self notify( "started_bot_defend_think" );
    self endon( "started_bot_defend_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "defend_stop" );
    thread _id_27AF();

    if ( isdefined( self._id_15F1 ) || self _meth_835D() == "camp" )
        self _meth_8356();

    self._id_15F1 = 1;
    self._id_15F7 = var_2;

    if ( var_2 == "capture_zone" )
    {
        self._id_15F5 = undefined;
        self._id_15F3 = var_1;
        self._id_15F6 = var_3["capture_trigger"];
    }
    else
    {
        self._id_15F5 = var_1;
        self._id_15F3 = undefined;
        self._id_15F6 = undefined;
    }

    if ( maps\mp\_utility::isgameparticipant( var_0 ) )
    {
        self._id_15EE = var_0;
        childthread _id_5D7F();
    }
    else
    {
        self._id_15EE = undefined;
        self._id_15F2 = var_0;
    }

    self _meth_8352( "none" );
    var_4 = undefined;
    var_5 = 6;
    var_6 = 10;
    self._id_27B4 = [];

    if ( isdefined( var_3 ) )
    {
        self._id_27A2 = var_3["entrance_points_index"];
        self._id_15F4 = var_3["override_origin_node"];

        if ( isdefined( var_3["score_flags"] ) )
        {
            if ( isarray( var_3["score_flags"] ) )
                self._id_27B4 = var_3["score_flags"];
            else
                self._id_27B4[0] = var_3["score_flags"];
        }

        if ( isdefined( var_3["override_goal_type"] ) )
            var_4 = var_3["override_goal_type"];

        if ( isdefined( var_3["min_goal_time"] ) )
            var_5 = var_3["min_goal_time"];

        if ( isdefined( var_3["max_goal_time"] ) )
            var_6 = var_3["max_goal_time"];

        if ( isdefined( var_3["override_entrances"] ) && var_3["override_entrances"].size > 0 )
        {
            self._id_27B3 = var_3["override_entrances"];
            self._id_27A2 = self.name + " " + gettime();

            foreach ( var_8 in self._id_27B3 )
            {
                var_8._id_701D[self._id_27A2] = maps\mp\bots\_bots_util::_id_332A( var_8.origin, maps\mp\bots\_bots_util::_id_27A7(), "prone" );
                wait 0.05;
                var_8._id_2480[self._id_27A2] = maps\mp\bots\_bots_util::_id_332A( var_8.origin, maps\mp\bots\_bots_util::_id_27A7(), "crouch" );
                wait 0.05;
            }
        }

        self._id_27A5 = var_3["objective_radius"];
    }

    if ( !isdefined( self._id_15EE ) )
    {
        var_10 = undefined;

        if ( isdefined( var_3 ) && isdefined( var_3["nearest_node_to_center"] ) )
            var_10 = var_3["nearest_node_to_center"];

        if ( !isdefined( var_10 ) && isdefined( self._id_15F4 ) )
            var_10 = self._id_15F4;

        if ( !isdefined( var_10 ) && isdefined( self._id_15F6 ) && isdefined( self._id_15F6.nearest_node ) )
            var_10 = self._id_15F6.nearest_node;

        if ( !isdefined( var_10 ) )
            var_10 = getclosestnodeinsight( maps\mp\bots\_bots_util::_id_27A7() );

        if ( !isdefined( var_10 ) )
        {
            var_11 = maps\mp\bots\_bots_util::_id_27A7();
            var_12 = getnodesinradiussorted( var_11, 256, 0 );

            for ( var_13 = 0; var_13 < var_12.size; var_13++ )
            {
                var_14 = vectornormalize( var_12[var_13].origin - var_11 );
                var_15 = var_11 + var_14 * 15;

                if ( sighttracepassed( var_15, var_12[var_13].origin, 0, undefined ) )
                {
                    var_10 = var_12[var_13];
                    break;
                }

                wait 0.05;

                if ( sighttracepassed( var_15 + ( 0.0, 0.0, 55.0 ), var_12[var_13].origin + ( 0.0, 0.0, 55.0 ), 0, undefined ) )
                {
                    var_10 = var_12[var_13];
                    break;
                }

                wait 0.05;
            }
        }

        self._id_611F = var_10;
    }

    var_16 = level._id_1611[var_2];

    if ( !isdefined( var_4 ) )
    {
        var_4 = "guard";

        if ( var_2 == "capture" || var_2 == "capture_zone" )
            var_4 = "objective";
    }

    var_17 = maps\mp\bots\_bots_util::_id_165A();

    if ( var_2 == "protect" )
        childthread _id_703D();

    for (;;)
    {
        self._id_6F35 = self._id_24BB;
        self._id_24BB = undefined;
        self._id_24BA = undefined;
        self._id_24BC = undefined;
        var_18 = isdefined( var_3["entrance_points_index"] ) && isarray( var_3["entrance_points_index"] );
        self._id_24BD = _id_19C9( var_17, var_18 );
        var_19 = self _meth_835D();
        var_20 = maps\mp\bots\_bots_util::_id_1644( var_4, var_19 );

        if ( !var_20 )
        {
            wait 0.25;
            continue;
        }

        var_21 = var_5;
        var_22 = var_6;
        var_23 = 1;

        if ( isdefined( self._id_27B2 ) )
        {
            self._id_24BC = self._id_27B2;
            self._id_27B2 = undefined;
            var_23 = 0;
            var_21 = 1.0;
            var_22 = 2.0;
        }
        else if ( isdefined( self._id_27B0 ) )
        {
            self._id_24BB = self._id_27B0;
            self._id_27B0 = undefined;
        }
        else
        {
            if ( isdefined( level._id_0886 ) && level._id_0886[self.team] )
            {
                if ( !common_scripts\utility::array_contains( self._id_27B4, "avoid_aerial_enemies" ) )
                    self._id_27B4[self._id_27B4.size] = "avoid_aerial_enemies";
            }

            self [[ var_16 ]]();
        }

        self _meth_8356();
        var_24 = "";

        if ( isdefined( self._id_24BB ) || isdefined( self._id_24BC ) )
        {
            if ( var_23 && maps\mp\bots\_bots_util::_id_1662() && !isplayer( var_0 ) && isdefined( self._id_27A2 ) )
            {
                var_25 = _id_162B( "trap_directional", "trap", "c4" );

                if ( isdefined( var_25 ) )
                {
                    var_26 = maps\mp\bots\_bots_util::_id_162D( undefined, self._id_27A2 );
                    _id_16E8( var_25, var_26, self._id_611F );
                }
            }

            if ( isdefined( self._id_24BC ) )
            {
                var_27 = undefined;

                if ( isdefined( self._id_24BA ) )
                    var_27 = self._id_24BA[1];

                self botsetscriptgoal( self._id_24BC, 0, var_4, var_27, self._id_27A5 );
            }
            else if ( !isdefined( self._id_24BA ) )
                self _meth_8355( self._id_24BB, var_4, undefined, self._id_27A5 );
            else
                self _meth_8355( self._id_24BB, var_4, self._id_24BA[1], self._id_27A5 );

            if ( var_17 )
            {
                if ( !isdefined( self._id_6F35 ) || !isdefined( self._id_24BB ) || self._id_6F35 != self._id_24BB )
                    self _meth_8352( "none" );
            }

            var_28 = self _meth_835A();
            self notify( "new_defend_goal" );
            maps\mp\bots\_bots_util::_id_A1E3();

            if ( var_4 == "objective" )
            {
                _id_27AE();
                self _meth_8374( 1.0 );
                self _meth_8351( "cautious", 0 );
            }

            if ( self _meth_8365() )
            {
                var_29 = self _meth_835A();

                if ( maps\mp\bots\_bots_util::_id_172A( var_29, var_28 ) )
                    var_24 = maps\mp\bots\_bots_util::_id_172E( 20, "defend_force_node_recalculation" );
            }

            if ( var_24 == "goal" )
            {
                if ( var_17 )
                    self _meth_8352( self._id_24BD );

                childthread _id_27B5();

                if ( var_23 && maps\mp\bots\_bots_util::_id_1662() && !isplayer( var_0 ) && isdefined( self._id_27A2 ) )
                    maps\mp\bots\_bots_personality::_id_171B();
            }
        }

        if ( var_24 != "goal" )
        {
            wait 0.25;
            continue;
        }

        var_30 = randomfloatrange( var_21, var_22 );
        var_24 = common_scripts\utility::waittill_any_timeout( var_30, "node_relinquished", "goal_changed", "script_goal_changed", "defend_force_node_recalculation", "bad_path" );

        if ( ( var_24 == "node_relinquished" || var_24 == "bad_path" || var_24 == "goal_changed" || var_24 == "script_goal_changed" ) && ( self._id_24BD == "crouch" || self._id_24BD == "prone" ) )
            self _meth_8352( "none" );
    }
}

_id_19C9( var_0, var_1 )
{
    var_2 = "stand";

    if ( var_0 )
    {
        var_3 = 100;
        var_4 = 0;
        var_5 = 0;
        var_6 = self _meth_837B( "strategyLevel" );

        if ( var_6 == 1 )
        {
            var_3 = 20;
            var_4 = 25;
            var_5 = 55;
        }
        else if ( var_6 >= 2 )
        {
            var_3 = 10;
            var_4 = 20;
            var_5 = 70;
        }

        var_7 = randomint( 100 );

        if ( var_7 < var_4 )
            var_2 = "crouch";
        else if ( var_7 < var_4 + var_5 )
            var_2 = "prone";

        var_8 = !isdefined( var_1 ) || !var_1;

        if ( var_8 && var_2 == "prone" )
        {
            var_9 = _id_15EC( "prone" );
            var_10 = _id_27A4( "prone" );

            if ( var_10.size >= var_9.size )
                var_2 = "crouch";
        }

        if ( var_8 && var_2 == "crouch" )
        {
            var_11 = _id_15EC( "crouch" );
            var_12 = _id_27A4( "crouch" );

            if ( var_12.size >= var_11.size )
                var_2 = "stand";
        }
    }

    return var_2;
}

_id_8475( var_0 )
{
    var_1 = 1250;
    var_2 = var_1 * var_1;

    if ( var_0 )
    {
        if ( self _meth_837B( "strategyLevel" ) == 0 )
            return 0;

        if ( self._id_15F7 == "capture_zone" && self istouching( self._id_15F6 ) )
            return 0;

        return distancesquared( self.origin, self._id_15F2 ) > var_2 * 0.75 * 0.75;
    }
    else if ( self _meth_8375() && distancesquared( self.origin, self._id_15F2 ) < var_2 )
    {
        var_3 = self _meth_837C();
        return 0 <= var_3 && var_3 <= var_1;
    }
    else
        return 0;
}

_id_8152( var_0, var_1 )
{
    var_2 = spawnstruct();

    if ( isdefined( var_1 ) )
        var_2.origin = var_1;
    else
        var_2.origin = var_0.origin;

    var_2._id_02BF = var_0;
    var_2._id_3A0F = 0;
    return var_2;
}

_id_27AE()
{
    self notify( "defense_cautious_approach" );
    self endon( "defense_cautious_approach" );
    level endon( "game_ended" );
    self endon( "defend_force_node_recalculation" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "defend_stop" );
    self endon( "started_bot_defend_think" );

    if ( ![[ level.bot_funcs["should_start_cautious_approach"] ]]( 1 ) )
        return;

    var_0 = self _meth_835A();
    var_1 = self _meth_8376();
    var_2 = 1;
    var_3 = 0.2;

    while ( var_2 )
    {
        wait 0.25;

        if ( !self _meth_8365() )
            return;

        var_4 = self _meth_835A();

        if ( !maps\mp\bots\_bots_util::_id_172A( var_0, var_4 ) )
            return;

        var_3 += 0.25;

        if ( var_3 >= 0.5 )
        {
            var_3 = 0.0;

            if ( [[ level.bot_funcs["should_start_cautious_approach"] ]]( 0 ) )
                var_2 = 0;
        }
    }

    self _meth_8374( 1.8 );
    self _meth_8351( "cautious", 1 );
    var_5 = self _meth_8370();

    if ( !isdefined( var_5 ) || var_5.size <= 2 )
        return;

    self._id_57FA = [];
    var_6 = 1000;

    if ( isdefined( level._id_703C ) )
        var_6 = level._id_703C;

    var_7 = var_6 * var_6;
    var_8 = getnodesinradius( self._id_15F2, var_6, 0, 500 );

    if ( var_8.size <= 0 )
        return;

    var_9 = 5 + self _meth_837B( "strategyLevel" ) * 2;
    var_10 = int( min( var_9, var_8.size ) );
    var_11 = self _meth_8371( var_8, 15, var_10, "node_protect", maps\mp\bots\_bots_util::_id_27A7(), "ignore_occupancy" );

    for ( var_12 = 0; var_12 < var_11.size; var_12++ )
    {
        var_13 = _id_8152( var_11[var_12] );
        self._id_57FA = common_scripts\utility::array_add( self._id_57FA, var_13 );
    }

    var_14 = botgetmemoryevents( 0, gettime() - 60000, 1, "death", 0, self );

    foreach ( var_16 in var_14 )
    {
        if ( distancesquared( var_16, self._id_15F2 ) < var_7 )
        {
            var_17 = getclosestnodeinsight( var_16 );

            if ( isdefined( var_17 ) )
            {
                var_13 = _id_8152( var_17, var_16 );
                self._id_57FA = common_scripts\utility::array_add( self._id_57FA, var_13 );
            }
        }
    }

    if ( isdefined( self._id_27A2 ) )
    {
        var_19 = maps\mp\bots\_bots_util::_id_162D( "stand", self._id_27A2 );

        for ( var_12 = 0; var_12 < var_19.size; var_12++ )
        {
            var_13 = _id_8152( var_19[var_12] );
            self._id_57FA = common_scripts\utility::array_add( self._id_57FA, var_13 );
        }
    }

    if ( self._id_57FA.size == 0 )
        return;

    childthread _id_5D6D();
    var_20 = self _meth_835D();
    var_21 = self _meth_835B();
    var_22 = self _meth_835C();
    wait 0.05;

    for ( var_23 = 1; var_23 < var_5.size - 2; var_23++ )
    {
        maps\mp\bots\_bots_util::_id_172F();
        var_24 = getlinkednodes( var_5[var_23] );

        if ( var_24.size == 0 )
            continue;

        var_25 = [];

        for ( var_12 = 0; var_12 < var_24.size; var_12++ )
        {
            if ( !common_scripts\utility::within_fov( self.origin, self.angles, var_24[var_12].origin, 0 ) )
                continue;

            for ( var_26 = 0; var_26 < self._id_57FA.size; var_26++ )
            {
                var_16 = self._id_57FA[var_26];

                if ( getnodesintrigger( var_16._id_02BF, var_24[var_12], 1 ) )
                {
                    var_25 = common_scripts\utility::array_add( var_25, var_24[var_12] );
                    var_26 = self._id_57FA.size;
                }
            }
        }

        if ( var_25.size == 0 )
            continue;

        var_27 = self _meth_8364( var_25, 1 + var_25.size * 0.15, "node_hide" );

        if ( isdefined( var_27 ) )
        {
            var_28 = [];

            for ( var_12 = 0; var_12 < self._id_57FA.size; var_12++ )
            {
                if ( getnodesintrigger( self._id_57FA[var_12]._id_02BF, var_27, 1 ) )
                {
                    if ( _func_220( self._id_57FA[var_12].origin, var_27.origin ) > 3600 )
                        var_28 = common_scripts\utility::array_add( var_28, self._id_57FA[var_12] );
                }
            }

            self _meth_8356();
            self _meth_8355( var_27, "critical" );
            childthread _id_5D6E();
            var_29 = maps\mp\bots\_bots_util::_id_172E( undefined, "cautious_approach_early_out" );
            self notify( "stop_cautious_approach_early_out_monitor" );

            if ( var_29 == "cautious_approach_early_out" )
                break;

            if ( var_29 == "goal" )
            {
                for ( var_12 = 0; var_12 < var_28.size; var_12++ )
                {
                    if ( _func_220( self.origin, var_28[var_12].origin ) < 1600 )
                        continue;

                    for ( var_30 = 0; var_28[var_12]._id_3A0F < 18 && var_30 < 3.6; var_30 += 0.25 )
                    {
                        self _meth_836D( var_28[var_12].origin + ( 0, 0, self _meth_82F2() ), 0.25, "script_search" );
                        wait 0.25;
                    }
                }
            }
        }

        wait 0.05;
    }

    self notify( "stop_location_monitoring" );
    self _meth_8356();

    if ( isdefined( var_1 ) )
        self _meth_8355( var_1, var_20, var_22 );
    else
        self botsetscriptgoal( self._id_24BC, var_21, var_20, var_22 );
}

_id_5D6E()
{
    self endon( "cautious_approach_early_out" );
    self endon( "stop_cautious_approach_early_out_monitor" );
    var_0 = undefined;

    if ( isdefined( self._id_15F5 ) )
        var_0 = self._id_15F5 * self._id_15F5;
    else if ( isdefined( self._id_15F3 ) )
    {
        var_1 = _id_15D3();
        var_0 = var_1 * var_1;
    }

    wait 0.05;

    for (;;)
    {
        if ( distancesquared( self.origin, self._id_15F2 ) < var_0 )
            self notify( "cautious_approach_early_out" );

        wait 0.05;
    }
}

_id_5D6D()
{
    self endon( "stop_location_monitoring" );
    var_0 = 10000;

    for (;;)
    {
        var_1 = self _meth_8387();

        if ( isdefined( var_1 ) )
        {
            var_2 = self _meth_8373();

            for ( var_3 = 0; var_3 < self._id_57FA.size; var_3++ )
            {
                if ( getnodesintrigger( var_1, self._id_57FA[var_3]._id_02BF, 1 ) )
                {
                    var_4 = common_scripts\utility::within_fov( self.origin, self.angles, self._id_57FA[var_3].origin, var_2 );
                    var_5 = !var_4 || self._id_57FA[var_3]._id_3A0F < 17;

                    if ( var_5 && distancesquared( self.origin, self._id_57FA[var_3].origin ) < var_0 )
                    {
                        var_4 = 1;
                        self._id_57FA[var_3]._id_3A0F = 18;
                    }

                    if ( var_4 )
                    {
                        self._id_57FA[var_3]._id_3A0F++;

                        if ( self._id_57FA[var_3]._id_3A0F >= 18 )
                        {
                            self._id_57FA[var_3] = self._id_57FA[self._id_57FA.size - 1];
                            self._id_57FA[self._id_57FA.size - 1] = undefined;
                            var_3--;
                        }
                    }
                }
            }
        }

        wait 0.05;
    }
}

_id_703D()
{
    self notify( "protect_watch_allies" );
    self endon( "protect_watch_allies" );
    var_0 = [];
    var_1 = 1050;
    var_2 = var_1 * var_1;
    var_3 = 900;

    if ( isdefined( level._id_703C ) )
        var_3 = level._id_703C;

    for (;;)
    {
        var_4 = gettime();
        var_5 = _id_1640( self._id_15F2, var_3 );

        foreach ( var_7 in var_5 )
        {
            var_8 = var_7.entity_number;

            if ( !isdefined( var_8 ) )
                var_8 = var_7 getentitynumber();

            if ( !isdefined( var_0[var_8] ) )
                var_0[var_8] = var_4 - 1;

            if ( !isdefined( var_7._id_5534 ) )
                var_7._id_5534 = var_4 - 10001;

            if ( var_7.health == 0 && isdefined( var_7.deathtime ) && var_4 - var_7.deathtime < 5000 )
            {
                if ( var_4 - var_7._id_5534 > 10000 && var_4 > var_0[var_8] )
                {
                    if ( isdefined( var_7.lastattacker ) && isdefined( var_7.lastattacker.team ) && var_7.lastattacker.team == common_scripts\utility::get_enemy_team( self.team ) )
                    {
                        if ( distancesquared( var_7.origin, self.origin ) < var_2 )
                        {
                            self _meth_8377( var_7.lastattacker, var_7.origin );
                            var_9 = getclosestnodeinsight( var_7.origin );

                            if ( isdefined( var_9 ) )
                            {
                                self._id_27B2 = var_9.origin;
                                self notify( "defend_force_node_recalculation" );
                            }

                            var_7._id_5534 = var_4;
                        }

                        var_0[var_8] = var_4 + 10000;
                    }
                }
            }
        }

        wait(( randomint( 5 ) + 1 ) * 0.05);
    }
}

_id_27B1()
{
    if ( isdefined( self._id_27B3 ) )
        return self._id_27B3;
    else if ( maps\mp\bots\_bots_util::_id_165A() )
        return _id_15EC( self._id_24BD, 1 );
    else if ( maps\mp\bots\_bots_util::_id_1662() || maps\mp\bots\_bots_util::_id_1659() )
    {
        var_0 = nodeexposedtosky( self.origin );
        return var_0;
    }
}

_id_27B5()
{
    self notify( "defense_watch_entrances_at_goal" );
    self endon( "defense_watch_entrances_at_goal" );
    self endon( "new_defend_goal" );
    self endon( "script_goal_changed" );
    var_0 = self _meth_8387();
    var_1 = undefined;

    if ( maps\mp\bots\_bots_util::_id_165A() )
    {
        var_2 = _id_27B1();
        var_1 = [];

        if ( isdefined( var_0 ) )
        {
            foreach ( var_4 in var_2 )
            {
                if ( getnodesintrigger( var_0, var_4, 1 ) )
                    var_1 = common_scripts\utility::array_add( var_1, var_4 );
            }
        }

        if ( var_1.size == 0 )
            var_1 = nodeexposedtosky( self.origin );
    }
    else if ( maps\mp\bots\_bots_util::_id_1662() || maps\mp\bots\_bots_util::_id_1659() )
    {
        var_1 = _id_27B1();

        if ( isdefined( var_0 ) && !issubstr( self getcurrentweapon(), "riotshield" ) )
        {
            if ( getnodesintrigger( var_0, self._id_611F, 1 ) )
                var_1 = common_scripts\utility::array_add( var_1, self._id_611F );
        }
    }

    if ( isdefined( var_1 ) )
    {
        childthread maps\mp\bots\_bots_util::_id_1736( var_1 );

        if ( maps\mp\bots\_bots_util::_id_1659() )
            childthread _id_16A7();
        else
            childthread _id_16A6();
    }
}

_id_16A6()
{
    self notify( "bot_monitor_watch_entrances_at_goal" );
    self endon( "bot_monitor_watch_entrances_at_goal" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );

    while ( !isdefined( self._id_A1E1 ) )
        wait 0.05;

    var_0 = level.bot_funcs["get_watch_node_chance"];

    for (;;)
    {
        var_1 = 0.8;
        var_2 = 1.0;

        if ( common_scripts\utility::array_contains( self._id_27B4, "strict_los" ) )
        {
            var_1 = 1.0;
            var_2 = 0.5;
        }

        foreach ( var_4 in self._id_A1E1 )
        {
            if ( var_4 == self._id_611F )
            {
                var_4._id_A1E0[self.entity_number] = var_1;
                continue;
            }

            var_4._id_A1E0[self.entity_number] = var_2;
        }

        var_6 = isdefined( var_0 );

        if ( !var_6 )
            _id_6FBA( 0.5 );

        foreach ( var_4 in self._id_A1E1 )
        {
            if ( var_6 )
            {
                var_8 = self [[ var_0 ]]( var_4 );
                var_4._id_A1E0[self.entity_number] *= var_8;
            }

            if ( _id_332D( var_4 ) )
                var_4._id_A1E0[self.entity_number] *= 0.5;
        }

        wait(randomfloatrange( 0.5, 0.75 ));
    }
}

_id_16A7()
{
    self notify( "bot_monitor_watch_entrances_bodyguard" );
    self endon( "bot_monitor_watch_entrances_bodyguard" );
    self notify( "bot_monitor_watch_entrances" );
    self endon( "bot_monitor_watch_entrances" );

    while ( !isdefined( self._id_A1E1 ) )
        wait 0.05;

    for (;;)
    {
        var_0 = anglestoforward( self._id_15EE.angles ) * ( 1.0, 1.0, 0.0 );
        var_0 = vectornormalize( var_0 );

        foreach ( var_2 in self._id_A1E1 )
        {
            var_2._id_A1E0[self.entity_number] = 1.0;
            var_3 = var_2.origin - self._id_15EE.origin;
            var_3 = vectornormalize( var_3 );
            var_4 = vectordot( var_0, var_3 );

            if ( var_4 > 0.6 )
                var_2._id_A1E0[self.entity_number] *= 0.33;
            else if ( var_4 > 0 )
                var_2._id_A1E0[self.entity_number] *= 0.66;

            if ( !_id_3329( var_2 ) )
                var_2._id_A1E0[self.entity_number] *= 0.5;
        }

        wait(randomfloatrange( 0.4, 0.6 ));
    }
}

_id_3329( var_0 )
{
    var_1 = _func_206( var_0 );
    var_2 = vectornormalize( var_0.origin - self.origin );

    for ( var_3 = 0; var_3 < level._id_A3E6; var_3++ )
    {
        if ( botzonegetcount( var_3, self.team, "enemy_predict" ) > 0 )
        {
            if ( isdefined( var_1 ) && var_3 == var_1 )
                return 1;
            else
            {
                var_4 = vectornormalize( _func_205( var_3 ) - self.origin );
                var_5 = vectordot( var_2, var_4 );

                if ( var_5 > 0.2 )
                    return 1;
            }
        }
    }

    return 0;
}

_id_6FBA( var_0 )
{
    if ( self._id_A1E1.size <= 0 )
        return;

    var_1 = self._id_A1E1;

    for ( var_2 = 0; var_2 < level._id_A3E6; var_2++ )
    {
        if ( botzonegetcount( var_2, self.team, "enemy_predict" ) <= 0 )
            continue;

        if ( var_1.size == 0 )
            break;

        var_3 = vectornormalize( _func_205( var_2 ) - self.origin );

        for ( var_4 = 0; var_4 < var_1.size; var_4++ )
        {
            var_5 = _func_206( var_1[var_4] );
            var_6 = 0;

            if ( isdefined( var_5 ) && var_2 == var_5 )
                var_6 = 1;
            else
            {
                var_7 = vectornormalize( var_1[var_4].origin - self.origin );
                var_8 = vectordot( var_7, var_3 );

                if ( var_8 > 0.2 )
                    var_6 = 1;
            }

            if ( var_6 )
            {
                var_1[var_4]._id_A1E0[self.entity_number] *= var_0;
                var_1[var_4] = var_1[var_1.size - 1];
                var_1[var_1.size - 1] = undefined;
                var_4--;
            }
        }
    }
}

_id_332D( var_0 )
{
    var_1 = _id_163F( self._id_15F2 );

    foreach ( var_3 in var_1 )
    {
        if ( _id_332E( var_3, var_0 ) )
            return 1;
    }

    return 0;
}

_id_332E( var_0, var_1 )
{
    var_2 = anglestoforward( var_0.angles );
    var_3 = vectornormalize( var_1.origin - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0.6 )
        return 1;

    return 0;
}

_id_163F( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
    {
        if ( isdefined( level._id_703C ) )
            var_1 = level._id_703C;
        else
            var_1 = 900;
    }

    var_2 = [];
    var_3 = _id_1640( var_0, var_1 );

    foreach ( var_5 in var_3 )
    {
        if ( !isai( var_5 ) || var_5 maps\mp\bots\_bots_util::_id_165E( var_0 ) )
            var_2 = common_scripts\utility::array_add( var_2, var_5 );
    }

    return var_2;
}

_id_1640( var_0, var_1 )
{
    var_2 = var_1 * var_1;
    var_3 = [];

    for ( var_4 = 0; var_4 < level.participants.size; var_4++ )
    {
        var_5 = level.participants[var_4];

        if ( var_5 != self && isdefined( var_5.team ) && var_5.team == self.team && maps\mp\_utility::isteamparticipant( var_5 ) )
        {
            if ( distancesquared( var_0, var_5.origin ) < var_2 )
                var_3 = common_scripts\utility::array_add( var_3, var_5 );
        }
    }

    return var_3;
}

_id_27AF()
{
    level endon( "game_ended" );
    self endon( "started_bot_defend_think" );
    self endon( "defend_stop" );
    self endon( "disconnect" );
    self waittill( "death" );

    if ( isdefined( self ) )
        thread _id_15EF();
}

_id_15EF()
{
    self notify( "defend_stop" );
    self._id_15F1 = undefined;
    self._id_15F2 = undefined;
    self._id_15F5 = undefined;
    self._id_15F3 = undefined;
    self._id_15F7 = undefined;
    self._id_15F6 = undefined;
    self._id_15F4 = undefined;
    self._id_15EE = undefined;
    self._id_27B4 = undefined;
    self._id_611F = undefined;
    self._id_27B2 = undefined;
    self._id_27B0 = undefined;
    self._id_27A5 = undefined;
    self._id_6F35 = undefined;
    self._id_24BB = undefined;
    self._id_24BA = undefined;
    self._id_24BC = undefined;
    self._id_27A2 = undefined;
    self._id_27B3 = undefined;
    self _meth_8356();
    self _meth_8352( "none" );
}

_id_27A4( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.participants )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( var_3.team == self.team && var_3 != self && isai( var_3 ) && var_3 maps\mp\bots\_bots_util::_id_165D() && var_3._id_24BD == var_0 )
        {
            if ( var_3._id_15F7 == self._id_15F7 && maps\mp\bots\_bots_util::_id_165E( var_3._id_15F2 ) )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_id_5D7F()
{
    var_0 = 0;
    var_1 = 175;
    var_2 = self._id_15EE.origin;
    var_3 = 0;
    var_4 = 0;

    for (;;)
    {
        if ( !isdefined( self._id_15EE ) )
            thread _id_15EF();

        self._id_15F2 = self._id_15EE.origin;
        self._id_611F = self._id_15EE _meth_8387();

        if ( !isdefined( self._id_611F ) )
            self._id_611F = self _meth_8387();

        if ( self _meth_835D() != "none" )
        {
            var_5 = self _meth_835A();
            var_6 = self._id_15EE getvelocity();
            var_7 = lengthsquared( var_6 );

            if ( var_7 > 100 )
            {
                var_0 = 0;

                if ( distancesquared( var_2, self._id_15EE.origin ) > var_1 * var_1 )
                {
                    var_2 = self._id_15EE.origin;
                    var_4 = 1;
                    var_8 = vectornormalize( var_5 - self._id_15EE.origin );
                    var_9 = vectornormalize( var_6 );

                    if ( vectordot( var_8, var_9 ) < 0.1 )
                    {
                        self notify( "defend_force_node_recalculation" );
                        wait 0.25;
                    }
                }
            }
            else
            {
                var_0 += 0.05;

                if ( var_3 > 100 && var_4 )
                {
                    var_2 = self._id_15EE.origin;
                    var_4 = 0;
                }

                if ( var_0 > 0.5 )
                {
                    var_10 = distancesquared( var_5, self._id_15F2 );

                    if ( var_10 > self._id_15F5 * self._id_15F5 )
                    {
                        self notify( "defend_force_node_recalculation" );
                        wait 0.25;
                    }
                }
            }

            var_3 = var_7;

            if ( abs( self._id_15EE.origin[2] - var_5[2] ) >= 50 )
            {
                self notify( "defend_force_node_recalculation" );
                wait 0.25;
            }
        }

        wait 0.05;
    }
}

_id_375D()
{
    var_0 = _id_15ED();
    var_1 = maps\mp\bots\_bots_util::_id_1613( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F5, var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_2 = vectornormalize( var_0 - var_1.origin );
            self._id_24BA = vectortoangles( var_2 );
        }
        else
        {
            var_3 = vectornormalize( var_1.origin - maps\mp\bots\_bots_util::_id_27A7() );
            self._id_24BA = vectortoangles( var_3 );
        }

        self._id_24BB = var_1;
    }
    else if ( isdefined( var_0 ) )
        _id_1648( var_0, undefined );
    else
        _id_1648( undefined, maps\mp\bots\_bots_util::_id_27A7() );
}

_id_375E()
{
    var_0 = _id_15ED();
    var_1 = maps\mp\bots\_bots_util::_id_1614( self._id_15F3, var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_0 ) )
        {
            var_2 = vectornormalize( var_0 - var_1.origin );
            self._id_24BA = vectortoangles( var_2 );
        }
        else
        {
            var_3 = vectornormalize( var_1.origin - maps\mp\bots\_bots_util::_id_27A7() );
            self._id_24BA = vectortoangles( var_3 );
        }

        self._id_24BB = var_1;
    }
    else if ( isdefined( var_0 ) )
        _id_1648( var_0, undefined );
    else
        _id_1648( undefined, maps\mp\bots\_bots_util::_id_27A7() );
}

_id_3760()
{
    var_0 = maps\mp\bots\_bots_util::_id_1612( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F5 );

    if ( isdefined( var_0 ) )
    {
        var_1 = vectornormalize( maps\mp\bots\_bots_util::_id_27A7() - var_0.origin );
        self._id_24BA = vectortoangles( var_1 );
        self._id_24BB = var_0;
    }
    else
        _id_1648( maps\mp\bots\_bots_util::_id_27A7(), undefined );
}

_id_375C()
{
    var_0 = maps\mp\bots\_bots_util::_id_1615( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F5 );

    if ( isdefined( var_0 ) )
        self._id_24BB = var_0;
    else
    {
        var_1 = self _meth_8387();

        if ( isdefined( var_1 ) )
            self._id_24BB = var_1;
        else
            self._id_24BC = self.origin;
    }
}

_id_375F()
{
    var_0 = undefined;
    var_1 = getnodesinradius( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F5, 0 );

    if ( isdefined( var_1 ) && var_1.size > 0 )
        var_0 = self _meth_8364( var_1, 1 + var_1.size * 0.5, "node_traffic" );

    if ( isdefined( var_0 ) )
        self._id_24BB = var_0;
    else
        _id_1648( undefined, maps\mp\bots\_bots_util::_id_27A7() );
}

_id_1648( var_0, var_1 )
{
    if ( self._id_15F7 == "capture_zone" )
        self._id_24BC = maps\mp\bots\_bots_util::_id_16B6( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F3, ::_id_15CB );
    else
        self._id_24BC = maps\mp\bots\_bots_util::_id_16B7( maps\mp\bots\_bots_util::_id_27A7(), self._id_15F5, ::_id_15CB, 0.15, 0.9 );

    if ( isdefined( var_0 ) )
    {
        var_2 = vectornormalize( var_0 - self._id_24BC );
        self._id_24BA = vectortoangles( var_2 );
    }
    else if ( isdefined( var_1 ) )
    {
        var_2 = vectornormalize( self._id_24BC - var_1 );
        self._id_24BA = vectortoangles( var_2 );
    }
}

_id_15CB( var_0 )
{
    if ( _id_15D5( var_0, 1, 1, 1 ) )
        return 0;

    return 1;
}

_id_15D5( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 < level.participants.size; var_4++ )
    {
        var_5 = level.participants[var_4];

        if ( var_5.team == self.team && var_5 != self )
        {
            if ( isai( var_5 ) )
            {
                if ( var_2 )
                {
                    if ( distancesquared( var_0, var_5.origin ) < 441 )
                        return 1;
                }

                if ( var_3 && var_5 _meth_8365() )
                {
                    var_6 = var_5 _meth_835A();

                    if ( distancesquared( var_0, var_6 ) < 441 )
                        return 1;
                }

                continue;
            }

            if ( var_1 )
            {
                if ( distancesquared( var_0, var_5.origin ) < 441 )
                    return 1;
            }
        }
    }

    return 0;
}

_id_15D3()
{
    var_0 = 0;

    if ( isdefined( self._id_15F3 ) )
    {
        foreach ( var_2 in self._id_15F3 )
        {
            var_3 = distance( self._id_15F2, var_2.origin );
            var_0 = max( var_3, var_0 );
        }
    }

    return var_0;
}

_id_1717()
{
    self notify( "bot_think_tactical_goals" );
    self endon( "bot_think_tactical_goals" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._id_90A8 = [];

    for (;;)
    {
        if ( self._id_90A8.size > 0 && !maps\mp\bots\_bots_util::_id_1664() )
        {
            var_0 = self._id_90A8[0];

            if ( !isdefined( var_0._id_06BA ) )
            {
                self notify( "start_tactical_goal" );

                if ( isdefined( var_0._id_8CBD ) )
                    self [[ var_0._id_8CBD ]]( var_0 );

                childthread _id_A1DB( var_0 );
                var_1 = "tactical";

                if ( isdefined( var_0._id_424E ) )
                    var_1 = var_0._id_424E;

                self botsetscriptgoal( var_0._id_424C, var_0._id_424D, var_1, var_0._id_01C4, var_0._id_62F0 );
                var_2 = maps\mp\bots\_bots_util::_id_172E( undefined, "stop_tactical_goal" );
                self notify( "stop_goal_aborted_watch" );

                if ( var_2 == "goal" )
                {
                    if ( isdefined( var_0._id_06ED ) )
                        self [[ var_0._id_06ED ]]( var_0 );
                }

                if ( var_2 != "script_goal_changed" )
                    self _meth_8356();

                if ( isdefined( var_0._id_3150 ) )
                    self [[ var_0._id_3150 ]]( var_0 );
            }

            self._id_90A8 = common_scripts\utility::array_remove( self._id_90A8, var_0 );
        }

        wait 0.05;
    }
}

_id_A1DB( var_0 )
{
    self endon( "stop_tactical_goal" );
    self endon( "stop_goal_aborted_watch" );
    wait 0.05;

    for (;;)
    {
        if ( isdefined( var_0._id_06BA ) || isdefined( var_0._id_8447 ) && self [[ var_0._id_8447 ]]( var_0 ) )
            self notify( "stop_tactical_goal" );

        wait 0.05;
    }
}

_id_16A9( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.type = var_0;
    var_4._id_424C = var_1;

    if ( isdefined( self._id_64B6 ) )
    {
        if ( !common_scripts\utility::array_contains( self._id_64B6, var_0 ) )
            return;
    }

    var_4.priority = var_2;
    var_4._id_62DE = var_3._id_62DE;
    var_4._id_424E = var_3._id_79FA;
    var_4._id_01C4 = var_3._id_79FB;
    var_4._id_424D = 0;

    if ( isdefined( var_3._id_79F9 ) )
        var_4._id_424D = var_3._id_79F9;

    var_4._id_8CBD = var_3._id_8CBD;
    var_4._id_3150 = var_3._id_3150;
    var_4._id_8447 = var_3._id_8447;
    var_4._id_06ED = var_3._id_06ED;
    var_4._id_62F0 = var_3._id_62F0;

    for ( var_5 = 0; var_5 < self._id_90A8.size; var_5++ )
    {
        if ( var_4.priority > self._id_90A8[var_5].priority )
            break;
    }

    for ( var_6 = self._id_90A8.size - 1; var_6 >= var_5; var_6-- )
        self._id_90A8[var_6 + 1] = self._id_90A8[var_6];

    self._id_90A8[var_5] = var_4;
}

_id_1649( var_0, var_1 )
{
    if ( !isdefined( self._id_90A8 ) )
        return 0;

    if ( isdefined( var_0 ) )
    {
        foreach ( var_3 in self._id_90A8 )
        {
            if ( var_3.type == var_0 )
            {
                if ( isdefined( var_1 ) && isdefined( var_3._id_62DE ) )
                    return var_3._id_62DE == var_1;
                else
                    return 1;
            }
        }

        return 0;
    }
    else
        return self._id_90A8.size > 0;
}

_id_15A1( var_0, var_1 )
{
    if ( !isdefined( self._id_90A8 ) )
        return;

    foreach ( var_3 in self._id_90A8 )
    {
        if ( var_3.type == var_0 )
        {
            if ( isdefined( var_1 ) )
            {
                if ( isdefined( var_3._id_62DE ) && var_3._id_62DE == var_1 )
                    var_3._id_06BA = 1;

                continue;
            }

            var_3._id_06BA = 1;
        }
    }
}

_id_15F9()
{
    self._id_64B6[0] = "map_interactive_object";

    foreach ( var_1 in self._id_90A8 )
    {
        if ( var_1.type != "map_interactive_object" )
            var_1._id_06BA = 1;
    }
}

_id_1604()
{
    self._id_64B6 = undefined;
}

_id_16A0()
{
    var_0 = gettime();

    if ( !isdefined( self._id_553B ) || var_0 - self._id_553B > 1000 )
    {
        self._id_553B = var_0;
        var_1 = _id_162B( "tacticalinsertion" );

        if ( !isdefined( var_1 ) )
            return 0;

        if ( isdefined( self._id_0143 ) && self _meth_836F( self._id_0143 ) )
            return 0;

        var_2 = _func_202( self.origin );

        if ( !isdefined( var_2 ) )
            return 0;

        var_3 = botzonenearestcount( var_2, self.team, 1, "enemy_predict", ">", 0 );

        if ( !isdefined( var_3 ) )
            return 0;

        var_4 = getnodesinradius( self.origin, 500, 0 );

        if ( var_4.size <= 0 )
            return 0;

        var_5 = self _meth_8364( var_4, var_4.size * 0.15, "node_hide" );

        if ( !isdefined( var_5 ) )
            return 0;

        return _id_16E8( var_1, undefined, undefined, undefined, var_5 );
    }

    return 0;
}
