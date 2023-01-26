// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_167A()
{
    var_0 = gettime();

    if ( !isdefined( level._id_5380 ) )
    {
        thread _id_16F5();
        _id_16CC( "uav", ::_id_167B );
        _id_16CC( "orbital_carepackage", ::_id_167B );
        _id_16CC( "heavy_exosuit", ::_id_167B );
        _id_16CC( "nuke", ::_id_167B );
        _id_16CC( "emp", ::_id_167B, ::_id_15CA );
        _id_16CC( "remote_mg_sentry_turret", maps\mp\bots\_bots_sentry::_id_1679, maps\mp\bots\_bots_sentry::_id_15CC, "turret" );
        _id_16CC( "assault_ugv", ::_id_167B, ::_id_15C8 );
        _id_16CC( "warbird", ::_id_167B, ::_id_15CF );
        _id_16CC( "strafing_run_airstrike", ::_id_166A, ::_id_15CD );
        _id_16CC( "orbitalsupport", ::_id_1677, ::_id_166B );
        _id_16CC( "recon_ugv", ::_id_1677, ::_id_166B );
        _id_16CC( "orbital_strike_laser", ::_id_1677, ::_id_166B );
        _id_16CC( "missile_strike", ::_id_1677, ::_id_166B );
    }

    thread maps\mp\bots\_bots_ks_remote_vehicle::_id_731F();
}

_id_16F5()
{
    wait 0.5;

    if ( isdefined( level._id_5984 ) )
        [[ level._id_5984 ]]();
    else if ( isdefined( level.mapkillstreak ) )
        _id_16CC( level.mapkillstreak, ::_id_1677, ::_id_166B );
}

_id_16CC( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level._id_5380 ) )
        level._id_5380 = [];

    level._id_5380[var_0] = var_1;

    if ( !isdefined( level._id_537F ) )
        level._id_537F = [];

    level._id_537F[var_0] = var_2;

    if ( !isdefined( level._id_5381 ) )
        level._id_5381 = [];

    level._id_5381[var_0] = var_3;

    if ( !isdefined( level._id_1707 ) )
        level._id_1707 = [];

    level._id_1707[level._id_1707.size] = var_0;
}

_id_1666( var_0, var_1 )
{
    if ( _id_1675( var_0, "bots", undefined ) )
        return 1;
    else if ( var_1 )
    {

    }

    return 0;
}

_id_1675( var_0, var_1, var_2 )
{
    if ( !_id_1676( var_0, var_1 ) )
        return 0;

    return 1;
}

_id_1676( var_0, var_1 )
{
    if ( var_1 == "humans" )
        return isdefined( level.killstreakfuncs[var_0] ) && maps\mp\_utility::getkillstreakindex( var_0 ) != -1;
    else if ( var_1 == "bots" )
        return isdefined( level._id_5380[var_0] );
}

_id_1713()
{
    self notify( "bot_think_killstreak" );
    self endon( "bot_think_killstreak" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_5380 ) )
        wait 0.05;

    for (;;)
    {
        if ( maps\mp\bots\_bots_util::_id_15AB() )
        {
            var_0 = self.pers["killstreaks"];

            if ( isdefined( var_0 ) )
            {
                var_1 = 0;

                for ( var_2 = 0; var_2 < var_0.size && !var_1; var_2++ )
                {
                    var_3 = var_0[var_2];

                    if ( isdefined( var_3.streakname ) && isdefined( self._id_167C ) && isdefined( self._id_167C[var_3.streakname] ) && gettime() < self._id_167C[var_3.streakname] )
                        continue;

                    if ( var_3.available )
                    {
                        var_4 = var_3.streakname;
                        var_3.weapon = maps\mp\_utility::getkillstreakweapon( var_3.streakname, var_3.modules );
                        var_5 = level._id_537F[var_4];

                        if ( isdefined( var_5 ) && !self [[ var_5 ]]( var_3 ) )
                            continue;

                        if ( !maps\mp\_utility::validateusestreak( var_3.streakname, 1 ) )
                            continue;

                        var_6 = level._id_5380[var_4];

                        if ( isdefined( var_6 ) )
                        {
                            var_7 = self [[ var_6 ]]( var_3, var_0, var_5, level._id_5381[var_3.streakname] );

                            if ( !isdefined( var_7 ) || var_7 == 0 )
                            {
                                if ( !isdefined( self._id_167C ) )
                                    self._id_167C = [];

                                self._id_167C[var_3.streakname] = gettime() + 5000;
                            }
                        }
                        else
                        {
                            var_3.available = 0;
                            maps\mp\killstreaks\_killstreaks::updatekillstreaks( 0 );
                        }

                        var_1 = 1;
                    }
                }
            }
        }

        wait(randomfloatrange( 2.0, 4.0 ));
    }
}

_id_1677()
{

}

_id_166B( var_0 )
{
    return 0;
}

_id_1669( var_0 )
{
    return var_0.weapon == "killstreak_uav_mp";
}

_id_15CF( var_0 )
{
    if ( !_id_1669( var_0 ) )
        return 0;

    if ( !_id_15CE( var_0 ) )
        return 0;

    return 1;
}

_id_15CE( var_0 )
{
    if ( !maps\mp\killstreaks\_warbird::_id_1AFD() )
        return 0;

    if ( _id_9D67() )
        return 0;

    return 1;
}

_id_15C8( var_0 )
{
    if ( !_id_1669( var_0 ) )
        return 0;

    if ( !_id_15C7( var_0 ) )
        return 0;

    return 1;
}

_id_15C7( var_0 )
{
    if ( _id_9D67() )
        return 0;

    return 1;
}

_id_9D67()
{
    return maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

_id_15CA( var_0 )
{
    if ( isdefined( level.empplayer ) )
        return 0;

    var_1 = level.otherteam[self.team];

    if ( isdefined( level.teamemped ) && isdefined( level.teamemped[var_1] ) && level.teamemped[var_1] )
        return 0;

    return 1;
}

_id_15CD( var_0 )
{
    if ( isdefined( level._id_8F19 ) )
        return 0;

    return 1;
}

_id_167B( var_0, var_1, var_2, var_3 )
{
    wait(randomintrange( 3, 5 ));

    if ( !maps\mp\bots\_bots_util::_id_15AB() )
        return 1;

    if ( isdefined( var_2 ) && !self [[ var_2 ]]( var_0 ) )
        return 0;

    _id_1708( var_0, var_1, var_0.weapon );
    return 1;
}

_id_166D( var_0, var_1, var_2, var_3 )
{
    _id_166C( var_0, var_1, var_2, var_3, "anywhere" );
}

_id_166F( var_0, var_1, var_2, var_3 )
{
    _id_166C( var_0, var_1, var_2, var_3, "outside" );
}

_id_166E( var_0, var_1, var_2, var_3 )
{
    _id_166C( var_0, var_1, var_2, var_3, "hidden" );
}

_id_166C( var_0, var_1, var_2, var_3, var_4 )
{
    wait(randomintrange( 2, 4 ));

    if ( !isdefined( var_4 ) )
        var_4 = "anywhere";

    if ( !maps\mp\bots\_bots_util::_id_15AB() )
        return 1;

    if ( isdefined( var_2 ) && !self [[ var_2 ]]( var_0 ) )
        return 0;

    var_5 = self getweaponammoclip( var_0.weapon ) + self getweaponammostock( var_0.weapon );

    if ( var_5 == 0 )
    {
        foreach ( var_7 in var_1 )
        {
            if ( isdefined( var_7.streakname ) && var_7.streakname == var_0.streakname )
                var_7.available = 0;
        }

        maps\mp\killstreaks\_killstreaks::updatekillstreaks( 0 );
        return 1;
    }

    var_9 = undefined;

    if ( var_4 == "outside" )
    {
        var_10 = [];
        var_11 = maps\mp\bots\_bots_util::_id_1637( 0, 750, 0.6, 1 );

        foreach ( var_13 in var_11 )
        {
            if ( _func_20C( var_13 ) )
                var_10 = common_scripts\utility::array_add( var_10, var_13 );
        }

        if ( var_11.size > 5 && var_10.size > var_11.size * 0.6 )
        {
            var_15 = common_scripts\utility::get_array_of_closest( self.origin, var_10, undefined, undefined, undefined, 150 );

            if ( var_15.size > 0 )
                var_9 = common_scripts\utility::random( var_15 );
            else
                var_9 = common_scripts\utility::random( var_10 );
        }
    }
    else if ( var_4 == "hidden" )
    {
        var_16 = getnodesinradius( self.origin, 256, 0, 40 );
        var_17 = self _meth_8387();

        if ( isdefined( var_17 ) )
        {
            var_18 = [];

            foreach ( var_13 in var_16 )
            {
                if ( getnodesintrigger( var_17, var_13, 1 ) )
                    var_18 = common_scripts\utility::array_add( var_18, var_13 );
            }

            var_9 = self _meth_8364( var_18, 1, "node_hide" );
        }
    }

    if ( isdefined( var_9 ) || var_4 == "anywhere" )
    {
        self _meth_8351( "disable_movement", 1 );

        if ( isdefined( var_9 ) )
            self _meth_836D( var_9.origin, 2.45, "script_forced" );

        _id_1708( var_0, var_1, var_0.weapon );
        wait 2.0;
        self _meth_837E( "attack" );
        wait 1.5;
        self switchtoweapon( "none" );
        self _meth_8351( "disable_movement", 0 );
    }

    return 1;
}

_id_1708( var_0, var_1, var_2 )
{
    _id_16AA( var_0, var_1 );
    wait 0.05;
    self switchtoweapon( var_2 );
}

_id_16AA( var_0, var_1 )
{
    if ( isdefined( var_0.isgimme ) && var_0.isgimme )
        self notify( "streakUsed1" );
    else
    {
        for ( var_2 = 0; var_2 < 3; var_2++ )
        {
            if ( isdefined( var_1[var_2].streakname ) )
            {
                if ( var_1[var_2].streakname == var_0.streakname )
                    break;
            }
        }

        self notify( "streakUsed" + ( var_2 + 1 ) );
    }
}

_id_166A( var_0, var_1, var_2, var_3 )
{
    wait(randomintrange( 3, 5 ));

    if ( !maps\mp\bots\_bots_util::_id_15AB() )
        return;

    var_4 = _func_202( self.origin );

    if ( !isdefined( var_4 ) )
        return;

    self _meth_8351( "disable_movement", 1 );
    _id_1708( var_0, var_1, var_0.weapon );
    wait 2;

    if ( !isdefined( self.selectinglocation ) )
        return;

    var_5 = level._id_A3E6;
    var_6 = -1;
    var_7 = 0;
    var_8 = [];
    var_9 = randomfloat( 100 ) > 50;

    for ( var_10 = 0; var_10 < var_5; var_10++ )
    {
        if ( var_9 )
            var_11 = var_5 - 1 - var_10;
        else
            var_11 = var_10;

        if ( var_11 != var_4 && botzonegetindoorpercent( var_11 ) < 0.25 )
        {
            var_12 = botzonegetcount( var_11, self.team, "enemy_predict" );

            if ( var_12 > var_7 )
            {
                var_6 = var_11;
                var_7 = var_12;
            }

            var_8 = common_scripts\utility::array_add( var_8, var_11 );
        }
    }

    if ( var_6 >= 0 )
        var_13 = _func_205( var_6 );
    else if ( var_8.size > 0 )
        var_13 = _func_205( common_scripts\utility::random( var_8 ) );
    else
        var_13 = _func_205( randomint( level._id_A3E6 ) );

    var_14 = ( randomfloatrange( -500, 500 ), randomfloatrange( -500, 500 ), 0 );
    var_15 = 1;

    while ( var_15 )
    {
        self notify( "confirm_location", var_13 + var_14, randomintrange( 0, 360 ) );
        var_16 = common_scripts\utility::waittill_any_return( "location_selection_complete", "airstrikeShowBlockedHUD" );

        if ( var_16 == "location_selection_complete" )
        {
            var_15 = 0;
            continue;
        }

        wait 0.5;
    }

    wait 1.0;
    self _meth_8351( "disable_movement", 0 );
}

_id_1718()
{
    self notify( "bot_think_watch_aerial_killstreak" );
    self endon( "bot_think_watch_aerial_killstreak" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( level._id_552A ) )
        level._id_552A = -10000;

    if ( !isdefined( level._id_5384 ) )
    {
        level._id_5384["allies"] = [];
        level._id_5384["axis"] = [];
    }

    if ( !isdefined( level._id_0886 ) )
    {
        level._id_0886["allies"] = 0;
        level._id_0886["axis"] = 0;
    }

    var_0 = 0;
    var_1 = randomfloatrange( 0.05, 4.0 );

    for (;;)
    {
        wait(var_1);
        var_1 = randomfloatrange( 0.05, 4.0 );

        if ( maps\mp\bots\_bots_util::_id_1664() )
            continue;

        if ( self _meth_837B( "strategyLevel" ) == 0 )
            continue;

        var_2 = 0;
        var_3 = _id_3D4E( self.team );

        if ( isdefined( var_3 ) )
        {
            var_2 = 1;

            if ( !_id_1660( var_3 ) )
                childthread _id_5D5D( var_3 );
        }

        if ( _id_3260( self.team ) )
        {
            var_2 = 1;

            if ( !_id_1660( level.orbitalsupport_planemodel ) )
                childthread _id_5D5D( level.orbitalsupport_planemodel );
        }

        if ( _id_325F( self.team ) )
        {
            _id_9884( "orbital_laser", ::_id_325F );
            var_2 = 1;
        }

        if ( _id_3259( self.team ) )
        {
            _id_9884( "missile_strike", ::_id_3259 );
            var_2 = 1;
        }

        if ( _id_327E( self.team ) )
        {
            _id_9884( "missile_strike", ::_id_327E );
            var_2 = 1;
        }

        if ( !var_0 && var_2 )
        {
            var_0 = 1;
            self _meth_8351( "hide_indoors", 1 );
        }

        if ( var_0 && !var_2 )
        {
            var_0 = 0;
            self _meth_8351( "hide_indoors", 0 );
        }

        level._id_0886[self.team] = var_2;
    }
}

_id_1660( var_0 )
{
    if ( !isdefined( self._id_0887 ) )
        return 0;

    return common_scripts\utility::array_contains( self._id_0887, var_0 );
}

_id_5D5D( var_0 )
{
    if ( !isdefined( self._id_0887 ) )
        self._id_0887 = [];

    self._id_0887[self._id_0887.size] = var_0;
    var_1 = vectornormalize( ( var_0.origin - self.origin ) * ( 1.0, 1.0, 0.0 ) );

    while ( isalive( var_0 ) )
    {
        var_2 = vectornormalize( ( var_0.origin - self.origin ) * ( 1.0, 1.0, 0.0 ) );
        var_3 = vectordot( var_1, var_2 );

        if ( var_3 <= 0 )
        {
            var_1 = var_2;
            self notify( "defend_force_node_recalculation" );
        }

        wait 0.05;
    }

    self._id_0887 = common_scripts\utility::array_remove( self._id_0887, var_0 );
}

_id_9884( var_0, var_1 )
{
    if ( !isdefined( level._id_5384[self.team][var_0] ) )
        level._id_5384[self.team][var_0] = 0;

    if ( !level._id_5384[self.team][var_0] )
    {
        level._id_5384[self.team][var_0] = 1;
        level thread _id_5D92( self.team, var_0, var_1 );
    }
}

_id_5D92( var_0, var_1, var_2 )
{
    var_3 = 0.5;

    while ( [[ var_2 ]]( var_0 ) )
    {
        if ( gettime() > level._id_552A + 4000 )
        {
            badplace_global( "", 5.0, var_0, "only_sky" );
            level._id_552A = gettime();
        }

        wait(var_3);
    }

    level._id_5384[var_0][var_1] = 0;
}

_id_3D4E( var_0 )
{
    if ( isdefined( level._id_89A1 ) )
    {
        foreach ( var_2 in level._id_89A1 )
        {
            if ( !level.teambased || var_2.team != var_0 )
                return var_2;
        }
    }

    return undefined;
}

_id_325F( var_0 )
{
    if ( isdefined( level._id_654F ) )
    {
        foreach ( var_2 in level._id_654F )
        {
            if ( !level.teambased || var_2.team != var_0 )
                return 1;
        }
    }

    return 0;
}

_id_3260( var_0 )
{
    if ( level.orbitalsupportinuse )
    {
        if ( isdefined( level.orbitalsupport_planemodel ) && isdefined( level.orbitalsupport_planemodel.owner ) )
        {
            if ( !level.teambased || level.orbitalsupport_planemodel.owner.team != var_0 )
                return 1;
        }
    }

    return 0;
}

_id_3259( var_0 )
{
    if ( isdefined( level.remotemissileinprogress ) )
    {
        foreach ( var_2 in level.rockets )
        {
            if ( var_2.type == "remote" && var_2.team != var_0 )
                return 1;
        }
    }

    return 0;
}

_id_327E( var_0 )
{
    if ( isdefined( level.artillerydangercenters ) )
    {
        foreach ( var_2 in level.artillerydangercenters )
        {
            if ( maps\mp\_utility::isstrstart( var_2.streakname, "strafing_run_airstrike" ) && var_2.team != var_0 )
                return 1;
        }
    }

    return 0;
}
