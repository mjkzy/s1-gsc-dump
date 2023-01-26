// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8054();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_15DE;
}

_id_8054()
{
    level._id_170A = 200;
    level._id_1709 = 38;

    if ( maps\mp\_utility::isaugmentedgamemode() )
        level._id_1709 += 170;
}

_id_15DE()
{
    self notify( "bot_conf_think" );
    self endon( "bot_conf_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._id_60BF = gettime() + 500;
    self._id_9100 = [];
    childthread _id_1735();

    if ( self._id_67DC == "camper" )
    {
        self._id_20E7 = 0;

        if ( !isdefined( self._id_20E8 ) )
            self._id_20E8 = 0;
    }

    for (;;)
    {
        var_0 = isdefined( self._id_90B7 );
        var_1 = 0;

        if ( var_0 && self _meth_8365() )
        {
            var_2 = self _meth_835A();

            if ( maps\mp\bots\_bots_util::_id_172A( self._id_90B7._id_440E, var_2 ) )
            {
                if ( self _meth_8375() )
                    var_1 = 1;
            }
            else if ( maps\mp\bots\_bots_strategy::_id_1649( "kill_tag" ) && self._id_90B7 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) )
            {
                self._id_90B7 = undefined;
                var_0 = 0;
            }
        }

        self _meth_8351( "force_sprint", var_1 );
        self._id_9100 = _id_16CE( self._id_9100 );
        var_3 = _id_1610( self._id_9100, 1 );
        var_4 = isdefined( var_3 );

        if ( var_0 && !var_4 || !var_0 && var_4 || var_0 && var_4 && self._id_90B7 != var_3 )
        {
            self._id_90B7 = var_3;
            self _meth_8356();
            self notify( "stop_camping_tag" );
            maps\mp\bots\_bots_personality::_id_1EA3();
            maps\mp\bots\_bots_strategy::_id_15A1( "kill_tag" );
        }

        if ( isdefined( self._id_90B7 ) )
        {
            self._id_20E8 = 0;

            if ( self._id_67DC == "camper" && self._id_20E7 )
            {
                self._id_20E8 = 1;

                if ( maps\mp\bots\_bots_personality::_id_8470() )
                {
                    if ( maps\mp\bots\_bots_personality::_id_3751( self._id_90B7._id_440E, 1000 ) )
                        childthread _id_15C3( self._id_90B7, "camp" );
                    else
                        self._id_20E8 = 0;
                }
            }

            if ( !self._id_20E8 )
            {
                if ( !maps\mp\bots\_bots_strategy::_id_1649( "kill_tag" ) )
                {
                    var_5 = spawnstruct();
                    var_5._id_79FA = "objective";
                    var_5._id_62F0 = level._id_170A;
                    maps\mp\bots\_bots_strategy::_id_16A9( "kill_tag", self._id_90B7._id_440E, 25, var_5 );
                }
            }
        }

        var_6 = 0;

        if ( isdefined( self._id_07EB ) )
            var_6 = self [[ self._id_07EB ]]();

        if ( !isdefined( self._id_90B7 ) )
        {
            if ( !var_6 )
                self [[ self._id_67DE ]]();
        }

        if ( gettime() > self._id_60BF )
        {
            self._id_60BF = gettime() + 500;
            var_7 = _id_1617( 1 );
            self._id_9100 = _id_15DD( var_7, self._id_9100 );
        }

        wait 0.05;
    }
}

_id_15D4( var_0 )
{
    if ( isdefined( var_0.on_path_grid ) && var_0.on_path_grid )
    {
        var_1 = self.origin + ( 0.0, 0.0, 55.0 );

        if ( _func_220( var_0.curorigin, var_1 ) < 144 )
        {
            var_2 = var_0.curorigin[2] - var_1[2];

            if ( var_2 > 0 )
            {
                if ( var_2 < level._id_1709 )
                {
                    if ( !isdefined( self._id_5562 ) )
                        self._id_5562 = 0;

                    if ( gettime() - self._id_5562 > 3000 )
                    {
                        self._id_5562 = gettime();
                        thread _id_1668();
                    }
                }
                else
                {
                    var_0.on_path_grid = 0;
                    return 1;
                }
            }
        }
    }

    return 0;
}

_id_1668()
{
    self endon( "death" );
    self endon( "disconnect" );
    self _meth_8352( "stand" );
    wait 1.0;
    self _meth_837E( "jump" );
    wait 0.5;

    if ( maps\mp\_utility::isaugmentedgamemode() )
        self _meth_837E( "jump" );

    wait 0.5;
    self _meth_8352( "none" );
}

_id_1735()
{
    for (;;)
    {
        level waittill( "new_tag_spawned", var_0 );
        self._id_60BF = -1;

        if ( isdefined( var_0 ) )
        {
            if ( isdefined( var_0.victim ) && var_0.victim == self || isdefined( var_0.attacker ) && var_0.attacker == self )
            {
                if ( !isdefined( var_0.on_path_grid ) && !isdefined( var_0._id_19E7 ) )
                {
                    thread _id_19D5( var_0 );
                    _id_A0B3( var_0 );

                    if ( var_0.on_path_grid )
                    {
                        var_1 = spawnstruct();
                        var_1.origin = var_0.curorigin;
                        var_1._id_0429 = var_0;
                        var_2[0] = var_1;
                        self._id_9100 = _id_15DD( var_2, self._id_9100 );
                    }
                }
            }
        }
    }
}

_id_15DD( var_0, var_1 )
{
    var_2 = var_1;

    foreach ( var_4 in var_0 )
    {
        var_5 = 0;

        foreach ( var_7 in var_1 )
        {
            if ( var_4._id_0429 == var_7._id_0429 && maps\mp\bots\_bots_util::_id_172A( var_4.origin, var_7.origin ) )
            {
                var_5 = 1;
                break;
            }
        }

        if ( !var_5 )
            var_2 = common_scripts\utility::array_add( var_2, var_4 );
    }

    return var_2;
}

_id_1665( var_0, var_1, var_2 )
{
    if ( !var_0.calculated_nearest_node )
    {
        var_0.nearest_node = getclosestnodeinsight( var_0.curorigin );
        var_0.calculated_nearest_node = 1;
    }

    if ( isdefined( var_0._id_19E7 ) )
        return 0;

    var_3 = var_0.nearest_node;
    var_4 = !isdefined( var_0.on_path_grid );

    if ( isdefined( var_3 ) && ( var_4 || var_0.on_path_grid ) )
    {
        var_5 = var_3 == var_1 || getnodesintrigger( var_3, var_1, 1 );

        if ( var_5 )
        {
            var_6 = common_scripts\utility::within_fov( self.origin, self.angles, var_0.curorigin, var_2 );

            if ( var_6 )
            {
                if ( var_4 )
                {
                    thread _id_19D5( var_0 );
                    _id_A0B3( var_0 );

                    if ( !var_0.on_path_grid )
                        return 0;
                }

                return 1;
            }
        }
    }

    return 0;
}

_id_1617( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_1 ) )
        var_3 = var_1;
    else
        var_3 = self _meth_8387();

    var_4 = undefined;

    if ( isdefined( var_2 ) )
        var_4 = var_2;
    else
        var_4 = self _meth_8373();

    var_5 = [];

    if ( isdefined( var_3 ) )
    {
        foreach ( var_7 in level.dogtags )
        {
            if ( var_7 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) )
            {
                var_8 = 0;

                if ( !var_0 || var_7.attacker == self )
                {
                    if ( !isdefined( var_7._id_19E7 ) )
                    {
                        if ( !isdefined( var_7.on_path_grid ) )
                        {
                            level thread _id_19D5( var_7 );
                            _id_A0B3( var_7 );
                        }

                        var_8 = distancesquared( self.origin, var_7._id_440E ) < 1000000 && var_7.on_path_grid;
                    }
                }
                else if ( _id_1665( var_7, var_3, var_4 ) )
                    var_8 = 1;

                if ( var_8 )
                {
                    var_9 = spawnstruct();
                    var_9.origin = var_7.curorigin;
                    var_9._id_0429 = var_7;
                    var_5 = common_scripts\utility::array_add( var_5, var_9 );
                }
            }
        }
    }

    return var_5;
}

_id_19D5( var_0 )
{
    var_0 endon( "reset" );
    var_0._id_19E7 = 1;
    var_0.on_path_grid = maps\mp\bots\_bots_util::_id_16BB( var_0.curorigin, undefined, level._id_1709 + 55 );

    if ( var_0.on_path_grid )
    {
        var_0._id_440E = getgroundposition( var_0.curorigin, 32 );

        if ( !isdefined( var_0._id_440E ) )
            var_0.on_path_grid = 0;
    }

    var_0._id_19E7 = undefined;
}

_id_A0B3( var_0 )
{
    while ( !isdefined( var_0.on_path_grid ) )
        wait 0.05;
}

_id_1610( var_0, var_1 )
{
    var_2 = undefined;

    if ( var_0.size > 0 )
    {
        var_3 = 1409865409;

        foreach ( var_5 in var_0 )
        {
            var_6 = _id_3DF5( var_5._id_0429 );

            if ( !var_1 || var_6 < 2 )
            {
                var_7 = distancesquared( var_5._id_0429._id_440E, self.origin );

                if ( var_7 < var_3 )
                {
                    var_2 = var_5._id_0429;
                    var_3 = var_7;
                }
            }
        }
    }

    return var_2;
}

_id_16CE( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3._id_0429 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) && maps\mp\bots\_bots_util::_id_172A( var_3._id_0429.curorigin, var_3.origin ) )
        {
            if ( !_id_15D4( var_3._id_0429 ) && var_3._id_0429.on_path_grid )
                var_1 = common_scripts\utility::array_add( var_1, var_3 );
        }
    }

    return var_1;
}

_id_3DF5( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level.participants )
    {
        if ( !isdefined( var_3.team ) )
            continue;

        if ( var_3.team == self.team && var_3 != self )
        {
            if ( isai( var_3 ) )
            {
                if ( isdefined( var_3._id_90B7 ) && var_3._id_90B7 == var_0 )
                    var_1++;

                continue;
            }

            if ( distancesquared( var_3.origin, var_0.curorigin ) < 160000 )
                var_1++;
        }
    }

    return var_1;
}

_id_15C3( var_0, var_1, var_2 )
{
    self notify( "bot_camp_tag" );
    self endon( "bot_camp_tag" );
    self endon( "stop_camping_tag" );

    if ( isdefined( var_2 ) )
        self endon( var_2 );

    self _meth_8355( self._id_611E, var_1, self._id_0B68 );
    var_3 = maps\mp\bots\_bots_util::_id_172E();

    if ( var_3 == "goal" )
    {
        var_4 = var_0.nearest_node;

        if ( isdefined( var_4 ) )
        {
            var_5 = nodeexposedtosky( self.origin );
            var_5 = common_scripts\utility::array_add( var_5, var_4 );
            childthread maps\mp\bots\_bots_util::_id_1736( var_5 );
        }
    }
}
