// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_1679( var_0, var_1, var_2, var_3 )
{
    self endon( "bot_sentry_exited" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait(randomintrange( 3, 5 ));

    while ( isdefined( self._id_7CB5 ) && gettime() < self._id_7CB5 )
        wait 1;

    if ( isdefined( self._id_0143 ) && self._id_0143.health > 0 && self _meth_836F( self._id_0143 ) )
        return 1;

    var_4 = self.origin;

    if ( var_3 != "hide_nonlethal" )
    {
        var_4 = _id_16E2( var_3 );

        if ( !isdefined( var_4 ) )
            return 1;
    }

    _id_16DD( var_0, var_4, var_3, var_1 );

    while ( maps\mp\bots\_bots_strategy::_id_1649( "sentry_placement" ) )
        wait 0.5;

    return 1;
}

_id_15CC( var_0 )
{
    foreach ( var_2 in var_0.modules )
    {
        if ( var_2 == "sentry_guardian" )
            return 1;
    }

    return 0;
}

_id_16DD( var_0, var_1, var_2, var_3 )
{
    var_4 = _id_16E1( var_0, var_1, var_2, var_3 );

    if ( isdefined( var_4 ) )
    {
        maps\mp\bots\_bots_strategy::_id_15A1( "sentry_placement" );
        var_5 = spawnstruct();
        var_5._id_62DE = var_4;
        var_5._id_79FB = var_4._id_A3AB;
        var_5._id_79F9 = 10;
        var_5._id_8CBD = ::_id_16E5;
        var_5._id_3150 = ::_id_16DE;
        var_5._id_8447 = ::_id_16E7;
        var_5._id_06ED = ::_id_16DC;
        self._id_6867 = var_0.streakname;
        maps\mp\bots\_bots_strategy::_id_16A9( "sentry_placement", var_4._id_02BF.origin, 0, var_5 );
    }
}

_id_16E7( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( isdefined( self._id_0143 ) && self._id_0143.health > 0 && self _meth_836F( self._id_0143 ) )
        return 1;

    self._id_7CB5 = gettime() + 1000;
    return 0;
}

_id_16DF()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "bot_sentry_canceled" );
    self endon( "bot_sentry_ensure_exit" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( isdefined( self._id_0143 ) && self._id_0143.health > 0 && self _meth_836F( self._id_0143 ) )
            thread _id_16DE();

        wait 0.05;
    }
}

_id_16E5( var_0 )
{
    thread _id_16E6( var_0 );
}

_id_16E6( var_0 )
{
    self endon( "stop_tactical_goal" );
    self endon( "stop_goal_aborted_watch" );
    self endon( "bot_sentry_canceled" );
    self endon( "bot_sentry_exited" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( isdefined( var_0._id_62DE ) && isdefined( var_0._id_62DE.weapon ) )
    {
        if ( distance2d( self.origin, var_0._id_62DE._id_02BF.origin ) < 400 )
        {
            thread maps\mp\bots\_bots_util::_id_161A( "stand", 5.0 );
            thread _id_16DF();
            maps\mp\bots\_bots_ks::_id_1708( var_0._id_62DE._id_5385, var_0._id_62DE._id_53A1, var_0._id_62DE.weapon );
            return;
        }

        wait 0.05;
    }
}

_id_16E2( var_0 )
{
    var_1 = maps\mp\bots\_bots_util::_id_27A7();

    if ( isdefined( var_1 ) )
        return var_1;

    if ( isdefined( self._id_611E ) )
        return self._id_611E.origin;

    var_2 = getnodesinradius( self.origin, 1000, 0, 512 );
    var_3 = 5;

    if ( var_0 != "turret" )
    {
        if ( self _meth_837B( "strategyLevel" ) == 1 )
            var_3 = 10;
        else if ( self _meth_837B( "strategyLevel" ) == 0 )
            var_3 = 15;
    }

    if ( var_0 == "turret_air" )
        var_4 = self _meth_8364( var_2, var_3, "node_traffic", "ignore_no_sky" );
    else
        var_4 = self _meth_8364( var_2, var_3, "node_traffic" );

    if ( isdefined( var_4 ) )
        return var_4.origin;
}

_id_16E1( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;
    var_5 = getnodesinradius( var_1, 1000, 0, 512 );
    var_6 = 5;

    if ( var_2 != "turret" )
    {
        if ( self _meth_837B( "strategyLevel" ) == 1 )
            var_6 = 10;
        else if ( self _meth_837B( "strategyLevel" ) == 0 )
            var_6 = 15;
    }

    if ( var_2 == "turret_air" )
        var_7 = self _meth_8364( var_5, var_6, "node_sentry", var_1, "ignore_no_sky" );
    else if ( var_2 == "trap" )
        var_7 = self _meth_8364( var_5, var_6, "node_traffic" );
    else if ( var_2 == "hide_nonlethal" )
        var_7 = self _meth_8364( var_5, var_6, "node_hide" );
    else
        var_7 = self _meth_8364( var_5, var_6, "node_sentry", var_1 );

    if ( isdefined( var_7 ) )
    {
        var_4 = spawnstruct();
        var_4._id_02BF = var_7;

        if ( var_1 != var_7.origin && var_2 != "hide_nonlethal" )
            var_4._id_A3AB = vectortoyaw( var_1 - var_7.origin );
        else
            var_4._id_A3AB = undefined;

        var_4.weapon = var_0.weapon;
        var_4._id_5385 = var_0;
        var_4._id_53A1 = var_3;
    }

    return var_4;
}

_id_16E0()
{
    if ( isdefined( self._id_1BAD ) )
        return self._id_1BAD;

    if ( isdefined( self._id_1BAE ) )
        return self._id_1BAE;

    if ( isdefined( self._id_1BAB ) )
        return self._id_1BAB;
}

_id_16DC( var_0 )
{
    var_1 = 0;
    var_2 = _id_16E0();

    if ( isdefined( var_2 ) )
    {
        var_3 = 0;

        if ( !var_2._id_1AAE )
        {
            var_4 = 0.75;
            var_5 = gettime();
            var_6 = self.angles[1];

            if ( isdefined( var_0._id_62DE._id_A3AB ) )
                var_6 = var_0._id_62DE._id_A3AB;

            var_7 = [];
            var_7[0] = var_6 + 180;
            var_7[1] = var_6 + 135;
            var_7[2] = var_6 - 135;
            var_8 = 1000;

            foreach ( var_10 in var_7 )
            {
                var_11 = playerphysicstrace( var_0._id_62DE._id_02BF.origin, var_0._id_62DE._id_02BF.origin + anglestoforward( ( 0, var_10 + 180, 0 ) ) * 100 );
                var_12 = distance2d( var_11, var_0._id_62DE._id_02BF.origin );

                if ( var_12 < var_8 )
                {
                    var_8 = var_12;
                    self _meth_8353( var_10, var_4 );
                    self _meth_836D( var_0._id_62DE._id_02BF.origin, var_4, "script_forced" );
                }
            }

            while ( !var_3 && isdefined( var_2 ) && !var_2._id_1AAE )
            {
                var_14 = float( gettime() - var_5 ) / 1000.0;

                if ( !var_2._id_1AAE && var_14 > var_4 )
                {
                    var_3 = 1;
                    self._id_7CB5 = gettime() + 30000;
                }

                wait 0.05;
            }
        }

        if ( isdefined( var_2 ) && var_2._id_1AAE )
        {
            _id_16DB();
            var_1 = 1;
        }
    }

    wait 0.25;
    _id_16E3();
    return var_1;
}

_id_16DB()
{
    self notify( "place_sentry" );
    self notify( "place_turret" );
    self notify( "placePlaceable" );
}

_id_16DA()
{
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
    self notify( "cancel_sentry" );
    self notify( "cancel_turret" );
    self notify( "cancelPlaceable" );
}

_id_16DE( var_0 )
{
    self notify( "bot_sentry_canceled" );
    _id_16DA();
    _id_16E3();
}

_id_16E3()
{
    self notify( "bot_sentry_abort_goal_think" );
    self notify( "bot_sentry_ensure_exit" );
    self endon( "bot_sentry_ensure_exit" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self switchtoweapon( "none" );
    self _meth_8356();
    self _meth_8352( "none" );
    self enableweapons();
    self enableweaponswitch();
    wait 0.25;
    var_0 = 0;

    while ( isdefined( _id_16E0() ) )
    {
        var_0++;
        _id_16DA();
        wait 0.25;

        if ( var_0 > 2 )
            _id_16E4();
    }

    self notify( "bot_sentry_exited" );
}

_id_16E4()
{
    if ( isdefined( self._id_1BAD ) )
        self._id_1BAD maps\mp\killstreaks\_autosentry::_id_7CB7();

    if ( isdefined( self._id_1BAE ) )
        self._id_1BAE maps\mp\killstreaks\_remoteturret::_id_997F();

    if ( isdefined( self._id_1BAB ) )
        self._id_1BAB maps\mp\killstreaks\_placeable::_id_6454( self._id_6867, 0 );

    self._id_1BAD = undefined;
    self._id_1BAE = undefined;
    self._id_1BAB = undefined;
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
}
