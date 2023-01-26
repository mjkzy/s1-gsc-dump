// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_806C();
    _id_8055();
}

_id_806C()
{
    level.bot_funcs["crate_can_use"] = ::_id_2363;
    level.bot_funcs["gametype_think"] = ::_id_15E6;
    level.bot_funcs["get_watch_node_chance"] = ::_id_15E5;
}

_id_8055()
{
    level._id_161F = ::_id_24AC;
    level._id_1622 = ::_id_24AD;
    level._id_161C = ::_id_3CC0;
    level._id_161D = ::_id_3CC1;
    maps\mp\bots\_bots_util::_id_172D();

    while ( !isdefined( level.teamflags ) )
        wait 0.05;

    level.teamflags["allies"].script_label = "allies";
    level.teamflags["axis"].script_label = "axis";
    maps\mp\bots\_bots_gametype_common::_id_15BF( level.teamflags, "flag_" );
    var_0 = _func_202( level.teamflags["allies"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "allies" );

    var_0 = _func_202( level.teamflags["axis"].origin );

    if ( isdefined( var_0 ) )
        botzonesetteam( var_0, "axis" );

    level.capzones["allies"].nearest_node = level.teamflags["allies"].nearest_node;
    level.capzones["axis"].nearest_node = level.teamflags["axis"].nearest_node;
    thread _id_15E4();
    level._id_1628 = 1;
}

_id_2363( var_0 )
{
    if ( isagent( self ) && !isdefined( var_0._id_175D ) )
        return 0;

    if ( isdefined( self.carryflag ) )
        return 0;

    return level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome();
}

_id_15E6()
{
    self notify( "bot_ctf_think" );
    self endon( "bot_ctf_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self._id_60C0 = 0;
    self._id_60B7 = 0;
    self _meth_8351( "separation", 0 );
    self _meth_8351( "use_obj_path_style", 1 );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        if ( !isdefined( self._id_7597 ) )
            maps\mp\bots\_bots_gametype_common::_id_1627();

        var_2 = 0;

        if ( self._id_7597 == "attacker" )
        {
            if ( isdefined( self.carryflag ) )
                var_2 = 1;
            else if ( !isdefined( level._id_382E[self.team] ) )
                var_2 = distancesquared( self.origin, level.teamflags[level.otherteam[self.team]].curorigin ) < squared( _id_3D6D() );
        }
        else if ( !level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome() )
            var_2 = !isdefined( level._id_382E[level.otherteam[self.team]] );

        self _meth_8351( "force_sprint", var_2 );
        var_1 = 0;

        if ( isdefined( self.carryflag ) )
        {
            _id_1EAC();

            if ( !isdefined( level._id_382E[level.otherteam[self.team]] ) )
            {
                var_1 = 1;

                if ( !var_0 )
                {
                    var_0 = 1;
                    self _meth_8379( "scripted" );
                }

                self botsetscriptgoal( level.capzones[self.team].curorigin, 16, "critical" );
            }
            else if ( gettime() > self._id_60B7 )
            {
                var_3 = getnodesinradius( level.capzones[self.team].curorigin, 900, 0, 300 );
                var_4 = self _meth_8364( var_3, var_3.size * 0.15, "node_hide_anywhere" );

                if ( !isdefined( var_4 ) )
                    var_4 = level.capzones[self.team].nearest_node;

                var_5 = self _meth_8355( var_4, "critical" );

                if ( var_5 )
                    self._id_60B7 = gettime() + 15000;
            }
        }
        else if ( self._id_7597 == "attacker" )
        {
            if ( isdefined( level._id_382E[self.team] ) )
            {
                if ( !maps\mp\bots\_bots_util::_id_1659() )
                {
                    _id_1EAC();
                    self _meth_8356();
                    maps\mp\bots\_bots_strategy::_id_1646( level._id_382E[self.team], 500 );
                }
            }
            else
            {
                _id_1EAC();

                if ( self _meth_835D() == "critical" )
                    self _meth_8356();

                self botsetscriptgoal( level.teamflags[level.otherteam[self.team]].curorigin, 16, "objective", undefined, 300 );
            }
        }
        else if ( !level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome() )
        {
            if ( !isdefined( level._id_382E[level.otherteam[self.team]] ) )
            {
                _id_1EAC();
                self botsetscriptgoal( level.teamflags[self.team].curorigin, 16, "critical" );
            }
            else
            {
                var_6 = level._id_382E[level.otherteam[self.team]];

                if ( gettime() > self._id_60C0 || self _meth_836F( var_6 ) )
                {
                    _id_1EAC();
                    self botsetscriptgoal( var_6.origin, 16, "critical" );
                    self._id_60C0 = gettime() + randomintrange( 4500, 5500 );
                }
            }
        }
        else if ( !_id_506E() )
        {
            self _meth_8356();
            var_7["score_flags"] = "strict_los";
            var_7["entrance_points_index"] = "flag_" + level.teamflags[self.team].script_label;
            var_7["nearest_node_to_center"] = level.teamflags[self.team].nearest_node;
            maps\mp\bots\_bots_strategy::_id_16C2( level.teamflags[self.team].curorigin, _id_3D6D(), var_7 );
        }

        if ( var_0 && !var_1 )
        {
            var_0 = 0;
            self _meth_8379( undefined );
        }
    }
}

_id_1EAC()
{
    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();
}

_id_506E()
{
    return maps\mp\bots\_bots_util::_id_1662();
}

_id_3D6D()
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

_id_24AC( var_0 )
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

    var_8 = game["teamScores"][var_0];
    var_9 = game["teamScores"][common_scripts\utility::get_enemy_team( var_0 )];

    if ( var_8 + 1 < var_9 )
        var_7 = int( min( var_7 + 1, var_1 ) );

    return var_7;
}

_id_24AD( var_0 )
{
    var_1 = maps\mp\bots\_bots_gametype_common::_id_1625( var_0 );
    return var_1 - _id_24AC( var_0 );
}

_id_3CC0( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::_id_1623( var_0, level.capzones[var_0].curorigin, _id_3D6D() );
}

_id_3CC1( var_0 )
{
    return maps\mp\bots\_bots_gametype_common::_id_1624( var_0, level.capzones[var_0].curorigin, _id_3D6D() );
}

_id_15E4()
{
    level notify( "bot_ctf_ai_director_update" );
    level endon( "bot_ctf_ai_director_update" );
    level endon( "game_ended" );
    level._id_382E = [];
    thread maps\mp\bots\_bots_gametype_common::_id_161E();

    for (;;)
    {
        level._id_382E["allies"] = undefined;
        level._id_382E["axis"] = undefined;

        foreach ( var_1 in level.participants )
        {
            if ( isalive( var_1 ) && isdefined( var_1.carryflag ) )
                level._id_382E[var_1.team] = var_1;
        }

        wait 0.05;
    }
}

_id_15E5( var_0 )
{
    if ( var_0 == self._id_611F )
        return 1.0;

    if ( !_id_506E() )
        return 1.0;

    var_1 = var_0 maps\mp\bots\_bots_util::_id_6123( "flag_allies", "flag_axis" );

    if ( var_1 )
        return 1.0;

    return 0.2;
}
