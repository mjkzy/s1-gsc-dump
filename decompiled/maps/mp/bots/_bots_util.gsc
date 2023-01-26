// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_1637( var_0, var_1, var_2, var_3 )
{
    var_4 = getnodesinradius( self.origin, var_1, var_0 );
    var_5 = [];
    var_6 = self _meth_8387();
    var_7 = anglestoforward( self getangles() );
    var_8 = vectornormalize( var_7 * ( 1.0, 1.0, 0.0 ) );

    foreach ( var_10 in var_4 )
    {
        var_11 = vectornormalize( ( var_10.origin - self.origin ) * ( 1.0, 1.0, 0.0 ) );
        var_12 = vectordot( var_11, var_8 );

        if ( var_12 > var_2 )
        {
            if ( !var_3 || isdefined( var_6 ) && getnodesintrigger( var_10, var_6, 1 ) )
                var_5[var_5.size] = var_10;
        }
    }

    return var_5;
}

_id_1644( var_0, var_1 )
{
    if ( var_0 == "none" )
        return var_1 == "none";
    else if ( var_0 == "hunt" )
        return var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "guard" )
        return var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "objective" )
        return var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "critical" )
        return var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
    else if ( var_0 == "tactical" )
        return 1;
}

_id_16ED( var_0 )
{
    self _meth_8369( var_0 );
    maps\mp\bots\_bots_personality::_id_15AD();
    self _meth_8356();
}

_id_16EB( var_0, var_1 )
{
    if ( var_0 == "default" )
        var_0 = _id_15D6();

    var_3 = self _meth_836B();
    self _meth_836A( var_0 );

    if ( isplayer( self ) && var_3 != var_0 )
    {
        maps\mp\_utility::set_rank_xp_and_prestige_for_bot();
        var_4 = maps\mp\gametypes\_rank::getrankforxp( maps\mp\gametypes\_rank::gettotalxp() );
        self.pers["rank"] = var_4;
        var_5 = self.pers["prestige"];
        self setrank( var_4, var_5 );
    }
}

_id_15D6()
{
    if ( !isdefined( level._id_15F8 ) )
    {
        level._id_15F8 = [];
        level._id_15F8[level._id_15F8.size] = "recruit";
        level._id_15F8[level._id_15F8.size] = "regular";
        level._id_15F8[level._id_15F8.size] = "hardened";
    }

    var_0 = self.pers["bot_chosen_difficulty"];

    if ( !isdefined( var_0 ) )
    {
        var_1 = [];
        var_2 = self.team;

        if ( !isdefined( var_2 ) )
            var_2 = self.bot_team;

        if ( !isdefined( var_2 ) )
            var_2 = self.pers["team"];

        if ( !isdefined( var_2 ) )
            var_2 = "allies";

        foreach ( var_4 in level.players )
        {
            if ( var_4 == self )
                continue;

            if ( !isai( var_4 ) )
                continue;

            var_5 = var_4 _meth_836B();

            if ( var_5 == "default" )
                continue;

            var_6 = var_4.team;

            if ( !isdefined( var_6 ) )
                var_6 = var_4.bot_team;

            if ( !isdefined( var_6 ) )
                var_6 = var_4.pers["team"];

            if ( !isdefined( var_6 ) )
                continue;

            if ( !isdefined( var_1[var_6] ) )
                var_1[var_6] = [];

            if ( !isdefined( var_1[var_6][var_5] ) )
            {
                var_1[var_6][var_5] = 1;
                continue;
            }

            var_1[var_6][var_5]++;
        }

        var_8 = -1;

        foreach ( var_10 in level._id_15F8 )
        {
            if ( !isdefined( var_1[var_2] ) || !isdefined( var_1[var_2][var_10] ) )
            {
                var_0 = var_10;
                break;
            }
            else if ( var_8 == -1 || var_1[var_2][var_10] < var_8 )
            {
                var_8 = var_1[var_2][var_10];
                var_0 = var_10;
            }
        }
    }

    if ( isdefined( var_0 ) )
        self.pers["bot_chosen_difficulty"] = var_0;

    return var_0;
}

_id_165A()
{
    if ( _id_165D() )
    {
        if ( self._id_15F7 == "capture" || self._id_15F7 == "capture_zone" )
            return 1;
    }

    return 0;
}

_id_1661()
{
    if ( _id_165D() )
    {
        if ( self._id_15F7 == "patrol" )
            return 1;
    }

    return 0;
}

_id_1662()
{
    if ( _id_165D() )
    {
        if ( self._id_15F7 == "protect" )
            return 1;
    }

    return 0;
}

_id_1659()
{
    if ( _id_165D() )
    {
        if ( self._id_15F7 == "bodyguard" )
            return 1;
    }

    return 0;
}

_id_165D()
{
    return isdefined( self._id_15F1 );
}

_id_165E( var_0 )
{
    if ( _id_165D() )
    {
        if ( _id_172A( self._id_15F2, var_0 ) )
            return 1;
    }

    return 0;
}

_id_165F( var_0 )
{
    if ( _id_1659() && self._id_15EE == var_0 )
        return 1;

    return 0;
}

_id_332A( var_0, var_1, var_2 )
{
    var_3 = ( 0.0, 0.0, 11.0 );
    var_4 = ( 0.0, 0.0, 40.0 );
    var_5 = undefined;

    if ( var_2 == "stand" )
        return 1;
    else if ( var_2 == "crouch" )
        var_5 = var_4;
    else if ( var_2 == "prone" )
        var_5 = var_3;

    return sighttracepassed( var_1 + var_5, var_0 + var_5, 0, undefined );
}

_id_3D62( var_0, var_1 )
{
    var_2 = _id_3AE7( var_0, var_1 );

    if ( isdefined( var_2 ) )
    {
        var_2 = _id_7344( var_2 );
        var_2 = _id_3CBA( var_2 );
    }

    return var_2;
}

_id_3AE8( var_0, var_1 )
{
    return getpathdist( var_0, var_1 );
}

_id_3AE7( var_0, var_1 )
{
    return _func_200( var_0, var_1 );
}

_id_3AE3( var_0, var_1, var_2 )
{
    return _func_1FD( var_0, var_1, var_2 );
}

_id_6123( var_0, var_1 )
{
    if ( !isdefined( self._id_6441 ) )
        return 0;

    if ( isdefined( self._id_6441[var_0] ) && isdefined( self._id_6441[var_0][var_1] ) && self._id_6441[var_0][var_1] )
        return 1;

    if ( isdefined( self._id_6441[var_1] ) && isdefined( self._id_6441[var_1][var_0] ) && self._id_6441[var_1][var_0] )
        return 1;

    return 0;
}

_id_3CBA( var_0 )
{
    var_1 = var_0;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = getlinkednodes( var_0[var_2] );

        for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        {
            if ( !common_scripts\utility::array_contains( var_1, var_3[var_4] ) )
                var_1 = common_scripts\utility::array_add( var_1, var_3[var_4] );
        }
    }

    return var_1;
}

_id_3EBC( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( getnodesintrigger( var_4, var_1, 1 ) )
            var_2 = common_scripts\utility::array_add( var_2, var_4 );
    }

    return var_2;
}

_id_7344( var_0 )
{
    var_0[var_0.size - 1] = undefined;
    var_0[0] = undefined;
    return common_scripts\utility::array_removeundefined( var_0 );
}

_id_172D( var_0 )
{
    var_1 = 1;

    while ( !_id_15BC( var_0 ) )
        wait 0.5;
}

_id_15BC( var_0 )
{
    if ( botautoconnectenabled() )
        return 1;

    if ( isdefined( level.ai_game_mode ) && level.ai_game_mode )
        return 1;

    if ( _id_1745( var_0 ) )
        return 1;

    return 0;
}

_id_172F( var_0 )
{
    var_1 = gettime();

    for (;;)
    {
        if ( isdefined( var_0 ) )
        {
            if ( gettime() > var_1 + var_0 )
                return;
        }

        if ( !isdefined( self._id_0143 ) )
            return;
        else if ( !_id_1650() )
            return;

        wait 0.05;
    }
}

_id_1650( var_0 )
{
    var_1 = gettime() - self._id_5520;
    var_2 = level._id_16AC;

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    return var_1 < var_2;
}

_id_172E( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) && isdefined( var_2 ) )
    {

    }

    var_3 = [ "goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed" ];

    if ( isdefined( var_1 ) )
        var_3[var_3.size] = var_1;

    if ( isdefined( var_2 ) )
        var_3[var_3.size] = var_2;

    if ( isdefined( var_0 ) )
        var_4 = common_scripts\utility::waittill_any_in_array_or_timeout( var_3, var_0 );
    else
        var_4 = common_scripts\utility::waittill_any_in_array_return( var_3 );

    return var_4;
}

_id_1724( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    childthread _id_9BCD();
    var_3 = common_scripts\utility::waittill_any_timeout( var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use" );
    self notify( "stop_usebutton_watcher" );
    return var_3;
}

_id_9BCD( var_0, var_1 )
{
    self endon( "stop_usebutton_watcher" );
    wait 0.05;

    while ( self usebuttonpressed() )
        wait 0.05;

    self notify( "use_button_no_longer_pressed" );
}

_id_1745( var_0 )
{
    foreach ( var_2 in level.participants )
    {
        if ( isai( var_2 ) )
        {
            if ( isdefined( var_0 ) && var_0 )
            {
                if ( !maps\mp\_utility::isteamparticipant( var_2 ) )
                    continue;
            }

            return 1;
        }
    }

    return 0;
}

_id_162D( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_3322 ) && !isdefined( self._id_27B3 ) )
        return undefined;

    if ( isarray( var_1 ) )
    {
        if ( isdefined( var_2 ) && var_2 )
        {
            var_3 = undefined;
            var_4 = 999999999;

            foreach ( var_6 in var_1 )
            {
                var_7 = common_scripts\utility::array_find( level._id_331F, var_6 );
                var_8 = level._id_3320[var_7];
                var_9 = distancesquared( self.origin, var_8 );

                if ( var_9 < var_4 )
                {
                    var_3 = var_6;
                    var_4 = var_9;
                }
            }

            var_1 = var_3;
        }
        else
            var_1 = common_scripts\utility::random( var_1 );
    }

    var_11 = [];

    if ( isdefined( self._id_27B3 ) )
        var_11 = self._id_27B3;
    else
        var_11 = level._id_3321[var_1];

    if ( !isdefined( var_0 ) || var_0 == "stand" )
        return var_11;
    else if ( var_0 == "crouch" )
    {
        var_12 = [];

        foreach ( var_14 in var_11 )
        {
            if ( var_14._id_2480[var_1] )
                var_12 = common_scripts\utility::array_add( var_12, var_14 );
        }

        return var_12;
    }
    else if ( var_0 == "prone" )
    {
        var_12 = [];

        foreach ( var_14 in var_11 )
        {
            if ( var_14._id_701D[var_1] )
                var_12 = common_scripts\utility::array_add( var_12, var_14 );
        }

        return var_12;
    }

    return undefined;
}

_id_1615( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = self._id_15EE getvelocity();

    if ( lengthsquared( var_4 ) > 100 )
    {
        var_5 = getnodesinradius( var_0, var_1 * 1.75, var_1 * 0.5, 500 );
        var_6 = [];
        var_7 = vectornormalize( var_4 );

        for ( var_8 = 0; var_8 < var_5.size; var_8++ )
        {
            var_9 = vectornormalize( var_5[var_8].origin - self._id_15EE.origin );

            if ( vectordot( var_9, var_7 ) > 0.1 )
                var_6[var_6.size] = var_5[var_8];
        }
    }
    else
        var_6 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( isdefined( var_2 ) && var_2 )
    {
        var_10 = vectornormalize( self._id_15EE.origin - self.origin );
        var_11 = var_6;
        var_6 = [];

        foreach ( var_13 in var_11 )
        {
            var_9 = vectornormalize( var_13.origin - self._id_15EE.origin );

            if ( vectordot( var_10, var_9 ) > 0.2 )
                var_6[var_6.size] = var_13;
        }
    }

    var_15 = [];
    var_16 = [];
    var_17 = [];

    for ( var_8 = 0; var_8 < var_6.size; var_8++ )
    {
        var_18 = distancesquared( var_6[var_8].origin, var_0 ) > 10000;
        var_19 = abs( var_6[var_8].origin[2] - self._id_15EE.origin[2] ) < 50;

        if ( var_18 )
            var_15[var_15.size] = var_6[var_8];

        if ( var_19 )
            var_16[var_16.size] = var_6[var_8];

        if ( var_18 && var_19 )
            var_17[var_17.size] = var_6[var_8];

        if ( var_8 % 100 == 99 )
            wait 0.05;
    }

    if ( var_17.size > 0 )
        var_3 = self _meth_8364( var_17, var_17.size * 0.15, "node_capture", var_0, undefined, self._id_27B4 );

    if ( !isdefined( var_3 ) )
    {
        wait 0.05;

        if ( var_16.size > 0 )
            var_3 = self _meth_8364( var_16, var_16.size * 0.15, "node_capture", var_0, undefined, self._id_27B4 );

        if ( !isdefined( var_3 ) && var_15.size > 0 )
        {
            wait 0.05;
            var_3 = self _meth_8364( var_15, var_15.size * 0.15, "node_capture", var_0, undefined, self._id_27B4 );
        }
    }

    return var_3;
}

_id_1613( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( var_4.size > 0 )
        var_3 = self _meth_8364( var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self._id_27B4 );

    return var_3;
}

_id_1614( var_0, var_1 )
{
    var_2 = undefined;

    if ( var_0.size > 0 )
        var_2 = self _meth_8364( var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self._id_27B4 );

    return var_2;
}

_id_1612( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( var_3.size > 0 )
        var_2 = self _meth_8364( var_3, var_3.size * 0.15, "node_protect", var_0, self._id_27B4 );

    return var_2;
}

_id_16B7( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;
    var_6 = getnodesinradius( var_0, var_1, 0, 500 );

    if ( isdefined( var_6 ) && var_6.size >= 2 )
        var_5 = _id_1616( var_6, var_2 );

    if ( !isdefined( var_5 ) )
    {
        if ( !isdefined( var_3 ) )
            var_3 = 0;

        if ( !isdefined( var_4 ) )
            var_4 = 1;

        var_7 = randomfloatrange( self._id_15F5 * var_3, self._id_15F5 * var_4 );
        var_8 = anglestoforward( ( 0, randomint( 360 ), 0 ) );
        var_5 = var_0 + var_8 * var_7;
    }

    return var_5;
}

_id_16B6( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( var_1.size >= 2 )
        var_3 = _id_1616( var_1, var_2 );

    if ( !isdefined( var_3 ) )
    {
        var_4 = common_scripts\utility::random( var_1 );
        var_5 = var_4.origin - var_0;
        var_3 = var_0 + vectornormalize( var_5 ) * length( var_5 ) * randomfloat( 1.0 );
    }

    return var_3;
}

_id_1616( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = common_scripts\utility::array_randomize( var_0 );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        for ( var_5 = var_4 + 1; var_5 < var_3.size; var_5++ )
        {
            var_6 = var_3[var_4];
            var_7 = var_3[var_5];

            if ( getnodesintrigger( var_6, var_7, 1 ) )
            {
                var_2 = ( ( var_6.origin[0] + var_7.origin[0] ) * 0.5, ( var_6.origin[1] + var_7.origin[1] ) * 0.5, ( var_6.origin[2] + var_7.origin[2] ) * 0.5 );

                if ( isdefined( var_1 ) && self [[ var_1 ]]( var_2 ) == 1 )
                    return var_2;
            }
        }
    }

    return var_2;
}

_id_27A7()
{
    if ( isdefined( self._id_15F4 ) )
        return self._id_15F4.origin;
    else if ( isdefined( self._id_15F2 ) )
        return self._id_15F2;

    return undefined;
}

_id_15AB()
{
    if ( maps\mp\_utility::iskillstreakdenied() )
        return 0;

    if ( _id_1664() )
        return 0;

    if ( self isusingturret() )
        return 0;

    if ( isdefined( level.nukeincoming ) )
        return 0;

    if ( isdefined( self.underwater ) && self.underwater )
        return 0;

    if ( isdefined( self.controlsfrozen ) && self.controlsfrozen )
        return 0;

    if ( self _meth_8465() )
        return 0;

    if ( maps\mp\_utility::getgametypenumlives() > 0 )
    {
        var_0 = 1;

        foreach ( var_2 in level.participants )
        {
            if ( isalive( var_2 ) && !_func_285( self, var_2 ) )
                var_0 = 0;
        }

        if ( var_0 )
            return 0;
    }

    if ( !_id_1650( 500 ) )
        return 1;

    if ( !isalive( self._id_0143 ) )
        return 1;

    return 0;
}

_id_16CB()
{
    var_0 = undefined;
    var_1 = botmemoryflags( "investigated", "killer_died" );
    var_2 = botmemoryflags( "investigated" );
    var_3 = common_scripts\utility::random( botgetmemoryevents( 0, gettime() - 10000, 1, "death", var_1, self ) );

    if ( isdefined( var_3 ) )
    {
        var_0 = var_3;
        self._id_16A2 = 10000;
    }
    else
    {
        var_4 = undefined;

        if ( self _meth_835D() != "none" )
            var_4 = self _meth_835A();

        var_5 = botgetmemoryevents( 0, gettime() - 45000, 1, "kill", var_2, self );
        var_6 = botgetmemoryevents( 0, gettime() - 45000, 1, "death", var_1, self );
        var_3 = common_scripts\utility::random( common_scripts\utility::array_combine( var_5, var_6 ) );

        if ( isdefined( var_3 ) > 0 && ( !isdefined( var_4 ) || distancesquared( var_4, var_3 ) > 1000000 ) )
        {
            var_0 = var_3;
            self._id_16A2 = 45000;
        }
    }

    if ( isdefined( var_0 ) )
    {
        var_7 = _func_202( var_0 );
        var_8 = _func_202( self.origin );

        if ( isdefined( var_7 ) && isdefined( var_8 ) && var_8 != var_7 )
        {
            var_9 = botzonegetcount( var_7, self.team, "ally" ) + botzonegetcount( var_7, self.team, "path_ally" );

            if ( var_9 > 1 )
                var_0 = undefined;
        }
    }

    if ( isdefined( var_0 ) )
        self._id_16A1 = var_0;

    return var_0;
}

_id_1601( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{

}

_id_1602( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{

}

bot_draw_circle( var_0, var_1, var_2, var_3, var_4 )
{

}

_id_1641()
{
    var_0 = 0;
    var_1 = undefined;

    if ( isdefined( self.weaponlist ) && self.weaponlist.size > 0 )
        var_1 = self.weaponlist;
    else
        var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_0 += self getweaponammoclip( var_3 );
        var_0 += self getweaponammostock( var_3 );
    }

    return var_0;
}

_id_16AB()
{
    var_0 = undefined;

    if ( isdefined( self.weaponlist ) && self.weaponlist.size > 0 )
        var_0 = self.weaponlist;
    else
        var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( self getweaponammoclip( var_2 ) > 0 )
            return 0;

        if ( self getweaponammostock( var_2 ) > 0 )
            return 0;
    }

    return 1;
}

_id_162E()
{
    var_0 = 0;
    var_1 = self getweaponslistoffhands();

    foreach ( var_3 in var_1 )
        var_0 += self getweaponammostock( var_3 );

    return var_0;
}

_id_1645( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "trap_directional":
            switch ( var_1 )
            {
                case "claymore_mp":
                    return 1;
            }

            break;
        case "trap":
            switch ( var_1 )
            {
                case "trophy_mp":
                case "explosive_drone_mp":
                case "proximity_explosive_mp":
                case "motion_sensor_mp":
                    return 1;
            }

            break;
        case "trap_follower":
            switch ( var_1 )
            {
                case "tracking_drone_mp":
                    return 1;
            }

            break;
        case "c4":
            switch ( var_1 )
            {
                case "c4_mp":
                    return 1;
            }

            break;
        case "tacticalinsertion":
            switch ( var_1 )
            {
                case "s1_tactical_insertion_device_mp":
                    return 1;
            }

            break;
    }

    return 0;
}

_id_1736( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self notify( "bot_watch_nodes" );
    self endon( "bot_watch_nodes" );
    self endon( "bot_watch_nodes_stop" );
    self endon( "using_remote" );
    self endon( "disconnect" );
    self endon( "death" );

    if ( isdefined( var_4 ) )
        self endon( var_4 );

    if ( isdefined( var_5 ) )
        self endon( var_5 );

    if ( isdefined( var_6 ) )
        self endon( var_6 );

    if ( isdefined( var_7 ) )
        self endon( var_7 );

    wait 1.0;
    var_8 = 1;
    var_9 = squared( self _meth_835B() );

    while ( var_8 )
    {
        if ( self _meth_8365() && self _meth_8375() )
        {
            if ( distancesquared( self _meth_835A(), self.origin ) < var_9 )
            {
                if ( length( self getvelocity() ) <= 1 )
                    var_8 = 0;
            }
        }

        if ( var_8 )
            wait 0.05;
    }

    var_10 = self.origin;
    var_11 = ( 0, 0, self _meth_82F2() );

    if ( isdefined( var_0 ) )
    {
        self._id_A1E1 = [];

        foreach ( var_13 in var_0 )
        {
            var_14 = 0;

            if ( _func_220( self.origin, var_13.origin ) <= 40 )
                var_14 = 1;

            var_15 = self geteye();
            var_16 = vectordot( ( 0.0, 0.0, 1.0 ), vectornormalize( var_13.origin + var_11 - var_15 ) );

            if ( abs( var_16 ) > 0.92 )
                var_14 = 1;

            if ( !var_14 )
                self._id_A1E1[self._id_A1E1.size] = var_13;
        }
    }

    if ( !isdefined( self._id_A1E1 ) )
        return;

    thread _id_A1E2();
    self._id_A1E1 = common_scripts\utility::array_randomize( self._id_A1E1 );

    foreach ( var_13 in self._id_A1E1 )
        var_13._id_A1E0[self.entity_number] = 1.0;

    var_20 = gettime();
    var_21 = var_20;
    var_22 = [];
    var_23 = undefined;

    if ( isdefined( var_1 ) )
        var_23 = ( 0, var_1, 0 );

    var_24 = isdefined( var_23 ) && isdefined( var_2 );
    var_25 = undefined;

    for (;;)
    {
        var_26 = gettime();
        self notify( "still_watching_nodes" );
        var_27 = self _meth_8373();

        if ( isdefined( var_3 ) && var_26 >= var_3 )
            return;

        if ( maps\mp\bots\_bots_strategy::_id_1649() )
        {
            self _meth_836D( undefined );
            wait 0.2;
            continue;
        }

        if ( !self _meth_8365() || !self _meth_8375() )
        {
            wait 0.2;
            continue;
        }

        if ( isdefined( var_25 ) && var_25._id_A1E0[self.entity_number] == 0.0 )
            var_21 = var_26;

        if ( self._id_A1E1.size > 0 )
        {
            var_28 = 0;

            if ( isdefined( self._id_0143 ) )
            {
                var_29 = self _meth_81C1( self._id_0143 );
                var_30 = self _meth_81C0( self._id_0143 );

                if ( var_30 && var_26 - var_30 < 5000 )
                {
                    var_31 = vectornormalize( var_29 - self.origin );
                    var_32 = 0;

                    for ( var_33 = 0; var_33 < self._id_A1E1.size; var_33++ )
                    {
                        var_34 = vectornormalize( self._id_A1E1[var_33].origin - self.origin );
                        var_35 = vectordot( var_31, var_34 );

                        if ( var_35 > var_32 )
                        {
                            var_32 = var_35;
                            var_25 = self._id_A1E1[var_33];
                            var_28 = 1;
                        }
                    }
                }
            }

            if ( !var_28 && var_26 >= var_21 )
            {
                var_36 = [];

                for ( var_33 = 0; var_33 < self._id_A1E1.size; var_33++ )
                {
                    var_13 = self._id_A1E1[var_33];
                    var_37 = var_13 _meth_8381();

                    if ( var_24 && !common_scripts\utility::within_fov( self.origin, var_23, var_13.origin, var_2 ) )
                        continue;

                    if ( _func_220( self.origin, var_13.origin ) <= 10 )
                        continue;

                    if ( !isdefined( var_22[var_37] ) )
                        var_22[var_37] = 0;

                    if ( common_scripts\utility::within_fov( self.origin, self.angles, var_13.origin, var_27 ) )
                        var_22[var_37] = var_26;

                    for ( var_38 = 0; var_38 < var_36.size; var_38++ )
                    {
                        if ( var_22[var_36[var_38] _meth_8381()] > var_22[var_37] )
                            break;
                    }

                    var_36 = common_scripts\utility::array_insert( var_36, var_13, var_38 );
                }

                var_25 = undefined;

                for ( var_33 = 0; var_33 < var_36.size; var_33++ )
                {
                    if ( randomfloat( 1 ) > var_36[var_33]._id_A1E0[self.entity_number] )
                        continue;

                    var_25 = var_36[var_33];
                    var_21 = var_26 + randomintrange( 3000, 5000 );
                    break;
                }
            }

            if ( isdefined( var_25 ) )
            {
                var_39 = var_25.origin + var_11;

                if ( _func_220( self.origin, var_39 ) <= 10 )
                {
                    self _meth_836D( undefined );
                    var_25 = undefined;
                    var_21 = 0;
                }
                else
                    self _meth_836D( var_39, 0.4, "script_search" );
            }
        }

        wait 0.2;
    }
}

_id_A1E3()
{
    self notify( "bot_watch_nodes_stop" );

    if ( isdefined( self._id_A1E1 ) )
    {
        foreach ( var_1 in self._id_A1E1 )
            var_1._id_A1E0[self.entity_number] = undefined;
    }

    self._id_A1E1 = undefined;
}

_id_A1E2()
{
    self notify( "watch_nodes_aborted" );
    self endon( "watch_nodes_aborted" );
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_timeout( 0.5, "still_watching_nodes" );

        if ( !isdefined( var_0 ) || var_0 != "still_watching_nodes" )
        {
            _id_A1E3();
            return;
        }
    }
}

_id_1681( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 != ( 0.0, 0.0, 0.0 ) )
    {
        if ( !common_scripts\utility::within_fov( self.origin, self.angles, var_1, self _meth_8373() ) )
        {
            var_2 = self _meth_836E( var_1 );

            if ( isdefined( var_2 ) )
                self _meth_836D( var_2 + ( 0.0, 0.0, 40.0 ), 1.0, "script_seek" );
        }

        self botmemoryevent( "known_enemy", undefined, var_1 );
    }
}

_id_1634( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.classname ) )
    {
        if ( var_1.classname == "grenade" )
        {
            if ( isdefined( var_0 ) && var_0.classname == "worldspawn" )
                return undefined;

            if ( !_id_1608( var_1 ) )
                return var_0;
        }
        else if ( var_1.classname == "rocket" )
        {
            if ( isdefined( var_1._id_9CBC ) )
                return var_1._id_9CBC;

            if ( isdefined( var_1.type ) && ( var_1.type == "remote" || var_1.type == "odin" ) )
                return var_1;

            if ( isdefined( var_1.owner ) )
                return var_1.owner;
        }
        else if ( var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt" )
            return undefined;

        return var_1;
    }

    return var_0;
}

_id_1608( var_0 )
{
    if ( !isdefined( var_0._id_A2BD ) )
        return 0;

    if ( var_0._id_A2BD == "c4_mp" )
        return 1;

    if ( var_0._id_A2BD == "proximity_explosive_mp" )
        return 1;

    return 0;
}

_id_172A( var_0, var_1 )
{
    return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

_id_15A6( var_0 )
{
    var_0.high_priority_for = [];

    if ( var_0.bot_interaction_type == "use" )
        _id_15A7( var_0 );
    else if ( var_0.bot_interaction_type == "damage" )
        _id_15A5( var_0 );
    else
    {

    }
}

_id_16CD( var_0 )
{
    var_0._id_0AFF = 1;
    level._id_56CE = common_scripts\utility::array_remove( level._id_56CE, var_0 );
}

_id_15A7( var_0 )
{
    if ( !issubstr( var_0.code_classname, "trigger_use" ) )
        return;

    if ( !isdefined( var_0.target ) )
        return;

    if ( isdefined( var_0._id_170B ) )
        return;

    if ( !isdefined( var_0.use_time ) )
        return;

    var_1 = getnodearray( var_0.target, "targetname" );

    if ( var_1.size != 1 )
        return;

    var_0._id_170B = var_1[0];

    if ( !isdefined( level._id_56CE ) )
        level._id_56CE = [];

    level._id_56CE = common_scripts\utility::array_add( level._id_56CE, var_0 );
}

_id_15A5( var_0 )
{
    if ( !issubstr( var_0.code_classname, "trigger_damage" ) )
        return;

    var_1 = getnodearray( var_0.target, "targetname" );

    if ( var_1.size != 2 )
        return;

    var_0._id_170D = var_1;

    if ( !isdefined( level._id_56CE ) )
        level._id_56CE = [];

    level._id_56CE = common_scripts\utility::array_add( level._id_56CE, var_0 );
}

_id_163C( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_5, var_4 in var_0 )
    {
        if ( var_2 == var_1 )
            return var_5;

        var_2++;
    }

    return undefined;
}

_id_1642( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < level._id_A3E6; var_2++ )
    {
        var_3 = _func_208( var_2 );
        var_3._id_9E75 = 0;
    }

    var_4 = _func_208( var_0 );
    return _id_1643( var_4, var_1 );
}

_id_1643( var_0, var_1 )
{
    var_2 = [];
    var_2[0] = _func_206( var_0 );
    var_0._id_9E75 = 1;
    var_3 = getlinkednodes( var_0 );

    foreach ( var_5 in var_3 )
    {
        if ( !var_5._id_9E75 )
        {
            var_6 = distance( var_0.origin, var_5.origin );

            if ( var_6 < var_1 )
            {
                var_7 = _id_1643( var_5, var_1 - var_6 );
                var_2 = common_scripts\utility::array_combine( var_7, var_2 );
            }
        }
    }

    return var_2;
}

_id_15E2( var_0 )
{
    return isdefined( var_0 ) && isdefined( var_0._id_20B9 ) && var_0._id_20B9;
}

_id_1636( var_0 )
{
    return level._id_169F[var_0];
}

_id_163D()
{
    return int( _id_162C() / 2 );
}

_id_162C()
{
    var_0 = getdvarint( "party_maxplayers", 0 );
    var_0 = max( var_0, getdvarint( "party_maxPrivatePartyPlayers", 0 ) );

    if ( var_0 > level.maxclients )
        return level.maxclients;

    return var_0;
}

_id_16C4()
{
    self notify( "bot_queued_process_level_thread" );
    self endon( "bot_queued_process_level_thread" );
    wait 0.05;

    for (;;)
    {
        if ( isdefined( level._id_16C6 ) && level._id_16C6.size > 0 )
        {
            var_0 = level._id_16C6[0];

            if ( isdefined( var_0 ) && isdefined( var_0.owner ) )
            {
                var_1 = undefined;

                if ( isdefined( var_0._id_6691 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._id_668E, var_0._id_668F, var_0._id_6690, var_0._id_6691 );
                else if ( isdefined( var_0._id_6690 ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._id_668E, var_0._id_668F, var_0._id_6690 );
                else if ( isdefined( var_0._id_668F ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._id_668E, var_0._id_668F );
                else if ( isdefined( var_0._id_668E ) )
                    var_1 = var_0.owner [[ var_0.func ]]( var_0._id_668E );
                else
                    var_1 = var_0.owner [[ var_0.func ]]();

                var_0.owner notify( var_0._id_603B, var_1 );
            }

            var_2 = [];

            for ( var_3 = 1; var_3 < level._id_16C6.size; var_3++ )
                var_2[var_3 - 1] = level._id_16C6[var_3];

            level._id_16C6 = var_2;
        }

        wait 0.05;
    }
}

_id_16C3( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level._id_16C6 ) )
        level._id_16C6 = [];

    foreach ( var_8, var_7 in level._id_16C6 )
    {
        if ( var_7.owner == self && var_7.name == var_0 )
        {
            self notify( var_7.name );
            level._id_16C6[var_8] = undefined;
        }
    }

    var_7 = spawnstruct();
    var_7.owner = self;
    var_7.name = var_0;
    var_7._id_603B = var_7.name + "_done";
    var_7.func = var_1;
    var_7._id_668E = var_2;
    var_7._id_668F = var_3;
    var_7._id_6690 = var_4;
    var_7._id_6691 = var_5;
    level._id_16C6[level._id_16C6.size] = var_7;

    if ( !isdefined( level._id_16C5 ) )
    {
        level._id_16C5 = 1;
        level thread _id_16C4();
    }

    self waittill( var_7._id_603B, var_9 );
    return var_9;
}

_id_1664()
{
    return maps\mp\_utility::isusingremote() || self islinked();
}

_id_1635( var_0 )
{
    var_1 = undefined;

    if ( isdefined( self.weaponlist ) && self.weaponlist.size > 0 )
        var_1 = self.weaponlist;
    else
        var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        var_4 = weaponclipsize( var_3 );
        var_5 = self getweaponammostock( var_3 );

        if ( var_5 <= var_4 )
            return 1;

        if ( self _meth_8334( var_3 ) <= var_0 )
            return 1;
    }

    return 0;
}

_id_16BB( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 256;

    if ( !isdefined( var_2 ) )
        var_2 = 50;

    var_3 = getnodesinradiussorted( var_0, var_1, 0, var_2, "Path" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_0 + ( 0.0, 0.0, 30.0 );
        var_7 = var_5.origin + ( 0.0, 0.0, 30.0 );
        var_8 = physicstrace( var_6, var_7 );

        if ( _id_172A( var_8, var_7 ) )
            return 1;

        wait 0.05;
    }

    return 0;
}

_id_16A4( var_0 )
{
    level endon( "game_ended" );
    self notify( "bot_monitor_enemy_camp_spots" );
    self endon( "bot_monitor_enemy_camp_spots" );
    level._id_3204 = [];
    level._id_3203 = [];
    level._id_3202 = [];

    for (;;)
    {
        wait 1.0;
        var_1 = [];

        if ( !isdefined( var_0 ) )
            continue;

        foreach ( var_3 in level.participants )
        {
            if ( !isdefined( var_3.team ) )
                continue;

            if ( var_3 [[ var_0 ]]() && !isdefined( var_1[var_3.team] ) )
            {
                level._id_3202[var_3.team] = undefined;
                level._id_3204[var_3.team] = var_3 _meth_8437( 1 );

                if ( isdefined( level._id_3204[var_3.team] ) )
                {
                    if ( !isdefined( level._id_3203[var_3.team] ) || !common_scripts\utility::array_contains( level._id_3204[var_3.team], level._id_3203[var_3.team] ) )
                        level._id_3203[var_3.team] = common_scripts\utility::random( level._id_3204[var_3.team] );

                    if ( isdefined( level._id_3203[var_3.team] ) )
                    {
                        var_4 = [];

                        foreach ( var_6 in level.participants )
                        {
                            if ( !isdefined( var_6.team ) )
                                continue;

                            if ( var_6 [[ var_0 ]]() && var_6.team == var_3.team )
                                var_4[var_4.size] = var_6;
                        }

                        var_4 = sortbydistance( var_4, level._id_3203[var_3.team] );

                        if ( var_4.size > 0 )
                            level._id_3202[var_3.team] = var_4[0];
                    }
                }

                var_1[var_3.team] = 1;
            }
        }
    }
}

_id_1725()
{
    if ( !isdefined( self ) )
        return 0;

    if ( !isai( self ) )
        return 0;

    if ( !isdefined( self.team ) )
        return 0;

    if ( self.team == "spectator" )
        return 0;

    if ( !isalive( self ) )
        return 0;

    if ( !maps\mp\_utility::isaiteamparticipant( self ) )
        return 0;

    if ( self._id_67DC == "camper" )
        return 0;

    return 1;
}

_id_1723()
{
    if ( !isdefined( level._id_3202 ) )
        return;

    if ( !isdefined( level._id_3202[self.team] ) )
        return;

    if ( level._id_3202[self.team] == self )
    {
        maps\mp\bots\_bots_strategy::_id_15EF();
        self botsetscriptgoal( level._id_3203[self.team], 128, "objective", undefined, 256 );
        _id_172E();
    }
}

_id_161A( var_0, var_1 )
{
    self notify( "bot_force_stance_for_time" );
    self endon( "bot_force_stance_for_time" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self _meth_8352( var_0 );
    wait(var_1);
    self _meth_8352( "none" );
}
