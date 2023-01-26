// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\bots\_bots_gametype_sd::_id_806C();
    _id_806C();
    maps\mp\bots\_bots_gametype_conf::_id_8054();
    maps\mp\bots\_bots_gametype_sd::_id_16D7();
}

_id_806C()
{
    level.bot_funcs["gametype_think"] = ::_id_1704;
}

_id_1704()
{
    self notify( "bot_sr_think" );
    self endon( "bot_sr_think" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_1628 ) )
        wait 0.05;

    self._id_8FF9 = undefined;
    childthread _id_90D5();
    maps\mp\bots\_bots_gametype_sd::_id_16D8();
}

_id_90D5()
{
    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        if ( !isdefined( self._id_7597 ) )
            continue;

        var_0 = maps\mp\bots\_bots_gametype_conf::_id_1617( 0 );

        if ( var_0.size > 0 )
        {
            var_1 = common_scripts\utility::random( var_0 );

            if ( distancesquared( self.origin, var_1._id_0429.curorigin ) < 10000 )
                _id_8AD7( var_1._id_0429 );
            else if ( self.team == game["attackers"] )
            {
                if ( self._id_7597 != "atk_bomber" )
                    _id_8AD7( var_1._id_0429 );
            }
            else if ( self._id_7597 != "bomb_defuser" )
                _id_8AD7( var_1._id_0429 );
        }
    }
}

_id_8AD7( var_0 )
{
    if ( isdefined( var_0._id_16B8 ) && isdefined( var_0._id_16B8[self.team] ) && isalive( var_0._id_16B8[self.team] ) && var_0._id_16B8[self.team] != self )
        return;

    if ( _id_8AD5( var_0 ) )
        return;

    if ( !isdefined( self._id_7597 ) )
        return;

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    var_0._id_16B8[self.team] = self;
    var_0 thread _id_1EA0();
    var_0 thread _id_1E9F( self );
    self._id_8FF9 = 1;
    childthread _id_6220( var_0, "tag_picked_up" );
    var_1 = var_0.curorigin;
    self botsetscriptgoal( var_1, 0, "tactical" );
    childthread _id_A1EC( var_0 );
    var_2 = maps\mp\bots\_bots_util::_id_172E( undefined, "tag_picked_up", "new_role" );
    self notify( "stop_watch_tag_destination" );

    if ( var_2 == "no_path" )
    {
        var_1 += ( 16 * _id_7109(), 16 * _id_7109(), 0 );
        self botsetscriptgoal( var_1, 0, "tactical" );
        var_2 = maps\mp\bots\_bots_util::_id_172E( undefined, "tag_picked_up", "new_role" );

        if ( var_2 == "no_path" )
        {
            var_1 = maps\mp\bots\_bots_util::_id_16C3( "BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3AE3, var_0.curorigin, 32, self );

            if ( isdefined( var_1 ) )
            {
                self botsetscriptgoal( var_1, 0, "tactical" );
                var_2 = maps\mp\bots\_bots_util::_id_172E( undefined, "tag_picked_up", "new_role" );
            }
        }
    }
    else if ( var_2 == "bad_path" )
    {
        var_3 = getnodesinradiussorted( var_0.curorigin, 256, 0, level._id_1709 + 55 );

        if ( var_3.size > 0 )
        {
            var_4 = ( var_0.curorigin[0], var_0.curorigin[1], ( var_3[0].origin[2] + var_0.curorigin[2] ) * 0.5 );
            self botsetscriptgoal( var_4, 0, "tactical" );
            var_2 = maps\mp\bots\_bots_util::_id_172E( undefined, "tag_picked_up", "new_role" );
        }
    }

    if ( var_2 == "goal" && var_0 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) )
        wait 3.0;

    if ( self _meth_8365() && isdefined( var_1 ) )
    {
        var_5 = self _meth_835A();

        if ( maps\mp\bots\_bots_util::_id_172A( var_5, var_1 ) )
            self _meth_8356();
    }

    self notify( "stop_tag_watcher" );
    var_0._id_16B8[self.team] = undefined;
    self._id_8FF9 = undefined;
}

_id_A1EC( var_0 )
{
    self endon( "stop_watch_tag_destination" );

    for (;;)
    {
        if ( !var_0 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) )
            wait 0.05;

        var_1 = self _meth_835A();
        wait 0.05;
    }
}

_id_8AD5( var_0 )
{
    var_1 = distance( self.origin, var_0.curorigin );
    var_2 = maps\mp\bots\_bots_gametype_sd::_id_3DC7( self.team, 1 );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 != self && isdefined( var_4._id_7597 ) && var_4._id_7597 != "atk_bomber" && var_4._id_7597 != "bomb_defuser" )
        {
            var_5 = distance( var_4.origin, var_0.curorigin );

            if ( var_5 < var_1 * 0.5 )
                return 1;
        }
    }

    return 0;
}

_id_7109()
{
    return randomintrange( 0, 2 ) * 2 - 1;
}

_id_1EA0()
{
    self waittill( "reset" );
    self._id_16B8 = [];
}

_id_1E9F( var_0 )
{
    self endon( "reset" );
    var_1 = var_0.team;
    var_0 common_scripts\utility::waittill_any( "death", "disconnect" );
    self._id_16B8[var_1] = undefined;
}

_id_6220( var_0, var_1 )
{
    self endon( "stop_tag_watcher" );

    while ( var_0 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) && !maps\mp\bots\_bots_gametype_conf::_id_15D4( var_0 ) )
        wait 0.05;

    self notify( var_1 );
}

_id_8AD6( var_0 )
{
    if ( isdefined( var_0._id_15C4 ) && isdefined( var_0._id_15C4[self.team] ) && isalive( var_0._id_15C4[self.team] ) && var_0._id_15C4[self.team] != self )
        return;

    if ( !isdefined( self._id_7597 ) )
        return;

    if ( maps\mp\bots\_bots_util::_id_165D() )
        maps\mp\bots\_bots_strategy::_id_15EF();

    var_0._id_15C4[self.team] = self;
    var_0 thread _id_1E9E();
    var_0 thread _id_1E9D( self );
    self._id_8FF9 = 1;
    maps\mp\bots\_bots_personality::_id_1EA3();
    var_1 = self._id_7597;

    while ( var_0 maps\mp\gametypes\_gameobjects::caninteractwith( self.team ) && self._id_7597 == var_1 )
    {
        if ( maps\mp\bots\_bots_personality::_id_8470() )
        {
            if ( maps\mp\bots\_bots_personality::_id_3751( var_0.curorigin, 1000 ) )
                childthread maps\mp\bots\_bots_gametype_conf::_id_15C3( var_0, "tactical", "new_role" );
        }

        wait 0.05;
    }

    self notify( "stop_camping_tag" );
    self _meth_8356();
    var_0._id_15C4[self.team] = undefined;
    self._id_8FF9 = undefined;
}

_id_1E9E()
{
    self waittill( "reset" );
    self._id_15C4 = [];
}

_id_1E9D( var_0 )
{
    self endon( "reset" );
    var_1 = var_0.team;
    var_0 common_scripts\utility::waittill_any( "death", "disconnect" );
    self._id_15C4[var_1] = undefined;
}
