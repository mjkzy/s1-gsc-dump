// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8059();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_1655;
    level.bot_funcs["should_pickup_weapons"] = ::_id_16FC;
}

_id_8059()
{
    level._id_1746 = 1;
    level._id_1748 = 1;
    level._id_1747 = 1;
    level._id_4C4D = "exoknife_mp";
    thread _id_1651();
}

_id_16FC()
{
    if ( level.infect_chosefirstinfected && self.team == "axis" )
        return 0;

    return maps\mp\bots\_bots::_id_16FB();
}

_id_1655()
{
    self notify( "bot_infect_think" );
    self endon( "bot_infect_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    childthread _id_1654();

    for (;;)
    {
        if ( level.infect_chosefirstinfected )
        {
            if ( self.team == "axis" && self _meth_8366() != "run_and_gun" )
                maps\mp\bots\_bots_util::_id_16ED( "run_and_gun" );
        }

        if ( self.bot_team != self.team )
            self.bot_team = self.team;

        if ( self.team == "axis" )
        {
            var_0 = maps\mp\bots\_bots_strategy::_id_16A0();

            if ( !isdefined( var_0 ) || var_0 )
                self _meth_8356();
        }

        self [[ self._id_67DE ]]();
        wait 0.05;
    }
}

_id_1651()
{
    level notify( "bot_infect_ai_director_update" );
    level endon( "bot_infect_ai_director_update" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = [];
        var_1 = [];

        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3._id_4DCE ) && var_3.health > 0 && isdefined( var_3.team ) && ( var_3.team == "allies" || var_3.team == "axis" ) )
                var_3._id_4DCE = gettime();

            if ( isdefined( var_3._id_4DCE ) && gettime() - var_3._id_4DCE > 5000 )
            {
                if ( !isdefined( var_3.team ) )
                    continue;

                if ( var_3.team == "axis" )
                {
                    var_0[var_0.size] = var_3;
                    continue;
                }

                if ( var_3.team == "allies" )
                    var_1[var_1.size] = var_3;
            }
        }

        if ( var_0.size > 0 && var_1.size > 0 )
        {
            var_5 = 1;

            foreach ( var_7 in var_1 )
            {
                if ( isbot( var_7 ) )
                    var_5 = 0;
            }

            if ( var_5 )
            {
                foreach ( var_3 in var_1 )
                {
                    if ( !isdefined( var_3._id_5533 ) )
                    {
                        var_3._id_5533 = gettime();
                        var_3._id_5532 = var_3.origin;
                        var_3._id_9351 = 0;
                    }

                    if ( gettime() >= var_3._id_5533 + 5000 )
                    {
                        var_3._id_5533 = gettime();
                        var_10 = distancesquared( var_3.origin, var_3._id_5532 );
                        var_3._id_5532 = var_3.origin;

                        if ( var_10 < 90000 )
                        {
                            var_3._id_9351 += 5000;

                            if ( var_3._id_9351 >= 20000 )
                            {
                                var_11 = common_scripts\utility::get_array_of_closest( var_3.origin, var_0 );

                                foreach ( var_13 in var_11 )
                                {
                                    if ( isbot( var_13 ) )
                                    {
                                        var_14 = var_13 _meth_835D();

                                        if ( var_14 != "tactical" && var_14 != "critical" )
                                        {
                                            var_13 thread _id_4B05( var_3 );
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            var_3._id_9351 = 0;
                            var_3._id_5532 = var_3.origin;
                        }
                    }
                }
            }
        }

        wait 1.0;
    }
}

_id_4B05( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self botsetscriptgoal( var_0.origin, 0, "critical" );
    maps\mp\bots\_bots_util::_id_172E();
    self _meth_8356();
}

_id_1654()
{
    if ( self.team == "axis" )
    {
        self._id_1A4A = 0;
        self._id_5B56 = undefined;
        self._id_5B58 = undefined;
        self._id_5B57 = 0;
        self._id_5B6B = undefined;
        self._id_5B6A = 0;
        var_0 = self _meth_837B( "throwKnifeChance" );

        if ( var_0 < 0.25 )
            self _meth_837A( "throwKnifeChance", 0.25 );

        self _meth_837A( "allowGrenades", 1 );

        for (;;)
        {
            if ( self hasweapon( level._id_4C4D ) )
            {
                if ( maps\mp\_utility::isgameparticipant( self._id_0143 ) )
                {
                    var_1 = gettime();

                    if ( !isdefined( self._id_5B56 ) || self._id_5B56 != self._id_0143 )
                    {
                        self._id_5B56 = self._id_0143;
                        self._id_5B58 = self._id_0143 _meth_8387();
                        self._id_5B57 = var_1;
                    }
                    else
                    {
                        var_2 = squared( self _meth_837B( "meleeDist" ) );

                        if ( distancesquared( self._id_0143.origin, self.origin ) <= var_2 )
                            self._id_1A4A = var_1;

                        var_3 = self._id_0143 _meth_8387();
                        var_4 = self _meth_8387();

                        if ( !isdefined( self._id_5B58 ) || self._id_5B58 != var_3 )
                        {
                            self._id_5B57 = var_1;
                            self._id_5B58 = var_3;
                        }

                        if ( !isdefined( self._id_5B6B ) || self._id_5B6B != var_4 )
                        {
                            self._id_5B6A = var_1;
                            self._id_5B6B = var_4;
                        }
                        else if ( distancesquared( self.origin, self._id_5B6B.origin ) > 9216 )
                            self._id_5B69 = var_1;

                        if ( self._id_1A4A + 3000 < var_1 )
                        {
                            if ( self._id_5B6A + 3000 < var_1 )
                            {
                                if ( self._id_5B57 + 3000 < var_1 )
                                {
                                    if ( _id_1652( self.origin, self._id_0143.origin ) )
                                        maps\mp\bots\_bots_util::_id_16C3( "find_node_can_see_ent", ::_id_1653, self._id_0143, self._id_5B6B );

                                    if ( !self getammocount( level._id_4C4D ) )
                                        self setweaponammoclip( level._id_4C4D, 1 );

                                    maps\mp\_utility::waitfortimeornotify( 30, "enemy" );
                                    self _meth_8356();
                                }
                            }
                        }
                    }
                }
            }

            wait 0.25;
        }
    }
}

_id_1652( var_0, var_1 )
{
    if ( abs( var_0[2] - var_1[2] ) > 56.0 && _func_220( var_0, var_1 ) < 2304 )
        return 1;

    return 0;
}

_id_1653( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    var_2 = 0;

    if ( issubstr( var_1.type, "Begin" ) )
        var_2 = 1;

    var_3 = getlinkednodes( var_1 );

    if ( isdefined( var_3 ) && var_3.size )
    {
        var_4 = common_scripts\utility::array_randomize( var_3 );

        foreach ( var_6 in var_4 )
        {
            if ( var_2 && issubstr( var_6.type, "End" ) )
                continue;

            if ( _id_1652( var_6.origin, var_0.origin ) )
                continue;

            var_7 = self geteye() - self.origin;
            var_8 = var_6.origin + var_7;
            var_9 = var_0.origin;

            if ( isplayer( var_0 ) )
                var_9 = var_0 maps\mp\_utility::getstancecenter();

            if ( sighttracepassed( var_8, var_9, 0, self, var_0 ) )
            {
                var_10 = vectortoyaw( var_9 - var_8 );
                self _meth_8355( var_6, "critical", var_10 );
                maps\mp\bots\_bots_util::_id_172E( 3.0 );
                return;
            }

            wait 0.05;
        }
    }
}
