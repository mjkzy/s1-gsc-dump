// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    precacheshellshock( "frag_grenade_mp" );
    _id_70AF();
    _id_70B3();
    _id_9E0A();
    _id_6B56();
}

_id_70AF()
{
    _id_60B3( "main", "player_view1_start", "player_view1_end" );
    var_0 = _id_60B2( "main", "Primary Weapon", "radial_weapons_primary", ::_id_06EE );
    var_1 = _id_60B2( "main", "Secondary Weapon", "radial_weapons_secondary", ::_id_06EF );
    var_2 = _id_60B2( "main", "Gears", "radial_gears", ::_id_06E8 );
    var_3 = _id_60B2( "main", "Kill Streaks", "radial_killstreaks", ::_id_06E9 );
    var_4 = _id_60B2( "main", "Leaderboards", "radial_leaderboards", ::_id_06EA );
    _id_60B3( "gears", "player_view2_start", "player_view2_end" );
    _id_60B3( "weapons_primary", "player_view3_start", "player_view3_end" );
    _id_60B3( "weapons_secondary", "player_view3_start", "player_view3_end" );
    _id_60B3( "killstreak", "player_view4_start", "player_view4_end" );
    _id_60B3( "leaderboards", "player_view5_start", "player_view5_end" );
}

_id_70B3()
{
    foreach ( var_1 in level._id_70B0 )
    {
        _id_8887( var_1 );

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            if ( isdefined( var_1[var_2 + 1] ) )
            {
                var_3 = _id_4020( var_1[var_2]._id_6E55, var_1[var_2 + 1]._id_6E55 );
                var_1[var_2]._id_311D = var_3;
                var_1[var_2 + 1]._id_8B2B = var_3;
                continue;
            }

            var_3 = _id_4020( var_1[var_2]._id_6E55, var_1[0]._id_6E55 ) + 180;

            if ( var_3 > 360 )
                var_3 -= 360;

            var_1[var_2]._id_311D = var_3;
            var_1[0]._id_8B2B = var_3;
        }
    }

    thread _id_9B5E();
    thread _id_A24D();
    thread _id_A1F8();
    thread _id_2713();
}

_id_2713()
{
    level endon( "game_ended" );
    level._id_246F = 1;

    for (;;)
    {
        if ( !isdefined( level._id_6329 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._id_6329 buttonpressed( "BUTTON_Y" ) )
            wait 0.05;

        level._id_6329 playsound( "mouse_click" );

        if ( var_0 )
        {
            level._id_246F *= -1;
            var_0 = 0;
        }

        while ( level._id_6329 buttonpressed( "BUTTON_Y" ) )
            wait 0.05;
    }
}

_id_6B56()
{
    level thread onplayerconnect();
    level thread _id_74D1();
}

_id_74D1()
{
    level waittill( "game_ended" );
    setdvar( "cg_draw2d", 1 );
}

onplayerconnect()
{
    level waittill( "connected", var_0 );
    var_0 thread _id_71DD();
    var_0 waittill( "spawned_player" );
    wait 1;
    var_0 takeallweapons();
    setdvar( "cg_draw2d", 0 );

    if ( !isdefined( var_0 ) )
        return;
    else
        level._id_6329 = var_0;

    var_0 thread _id_3E52();
    _id_A3F1( "main" );
}

_id_71DD()
{
    self endon( "disconnect" );
    var_0 = "autoassign";

    while ( !isdefined( self.pers["team"] ) )
        wait 0.05;

    self notify( "menuresponse", game["menu_team"], var_0 );
    wait 0.5;
    var_1 = getarraykeys( level.classmap );
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( !issubstr( var_1[var_3], "custom" ) )
            var_2[var_2.size] = var_1[var_3];
    }

    for (;;)
    {
        var_4 = var_2[0];
        self notify( "menuresponse", "changeclass", var_4 );
        self waittill( "spawned_player" );
        wait 0.1;
    }
}

_id_3E52()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for (;;)
    {
        var_0 = self _meth_82F3();
        var_1 = vectortoangles( var_0 );
        level._id_766C = int( var_1[1] );
        wait 0.05;
    }
}

_id_60B3( var_0, var_1, var_2 )
{
    if ( isdefined( level._id_70B0 ) && level._id_70B0.size )
    {

    }

    var_3 = getent( var_2, "targetname" );
    var_4 = vectornormalize( anglestoforward( var_3.angles ) ) * 40;
    level._id_70B0[var_0] = [];
    level._id_70B1[var_0]["view_start"] = var_1;
    level._id_70B1[var_0]["view_pos"] = var_3.origin + var_4;
    level._id_70B1[var_0]["player_view_pos"] = var_3.origin;
    level._id_70B1[var_0]["view_angles"] = var_3.angles;
}

_id_60B2( var_0, var_1, var_2, var_3 )
{
    var_4 = getent( var_2, "targetname" );
    var_5 = _id_40A0( var_0, var_4 );
    var_6 = spawnstruct();
    var_6._id_6E54 = var_4.origin;
    var_6.label = var_1;
    var_6._id_397A = 1;
    var_6._id_3979 = ( 0.5, 0.5, 1.0 );
    var_6._id_6E55 = var_5;
    var_6._id_06E7 = var_3;
    var_6._id_70D2 = 8;
    level._id_70B0[var_0][level._id_70B0[var_0].size] = var_6;
    return var_6;
}

_id_9B5E()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._id_70AE ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = level._id_0712;

        foreach ( var_2 in level._id_70B0[level._id_70AE] )
        {
            if ( _id_5127( var_2._id_8B2B, var_2._id_311D ) )
            {
                level._id_0712 = var_2;
                continue;
            }

            var_2._id_3979 = ( 0.5, 0.5, 1.0 );
        }

        if ( isdefined( level._id_0712 ) )
        {
            level._id_0712._id_3979 = ( 1.0, 1.0, 0.5 );

            if ( isdefined( var_0 ) && var_0 != level._id_0712 )
                level._id_6329 playsound( "mouse_over" );
        }

        wait 0.05;
    }
}

_id_A24D()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._id_6329 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._id_6329 buttonpressed( "BUTTON_A" ) )
            wait 0.05;

        level._id_6329 playsound( "mouse_click" );

        if ( isdefined( level._id_0712 ) && var_0 )
        {
            level._id_0712 notify( "select_button_pressed" );
            [[ level._id_0712._id_06E7 ]]();
            var_0 = 0;
        }

        while ( level._id_6329 buttonpressed( "BUTTON_A" ) )
            wait 0.05;
    }
}

_id_A1F8()
{
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._id_6329 ) )
        {
            wait 0.05;
            continue;
        }

        var_0 = 1;

        while ( !level._id_6329 buttonpressed( "BUTTON_X" ) )
            wait 0.05;

        level._id_6329 playsound( "mouse_click" );

        if ( var_0 )
        {
            _id_06E6();
            var_0 = 0;
        }

        while ( level._id_6329 buttonpressed( "BUTTON_X" ) )
            wait 0.05;
    }
}

_id_8887( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size - 1; var_1++ )
    {
        for ( var_2 = 0; var_2 < var_0.size - 1 - var_1; var_2++ )
        {
            if ( var_0[var_2 + 1]._id_6E55 < var_0[var_2]._id_6E55 )
                _id_1957( var_0[var_2], var_0[var_2 + 1] );
        }
    }
}

_id_1957( var_0, var_1 )
{
    var_2 = var_0._id_6E54;
    var_3 = var_0.label;
    var_4 = var_0._id_6E55;
    var_5 = var_0._id_06E7;
    var_6 = var_0._id_70D2;
    var_0._id_6E54 = var_1._id_6E54;
    var_0.label = var_1.label;
    var_0._id_6E55 = var_1._id_6E55;
    var_0._id_06E7 = var_1._id_06E7;
    var_0._id_70D2 = var_1._id_70D2;
    var_1._id_6E54 = var_2;
    var_1.label = var_3;
    var_1._id_6E55 = var_4;
    var_1._id_06E7 = var_5;
    var_1._id_70D2 = var_6;
}

_id_2DC2( var_0 )
{
    foreach ( var_2 in level._id_70B0[var_0] )
        var_2 thread _id_2DC1( var_0 );
}

_id_2DC1( var_0 )
{
    level endon( "game_ended" );
    self endon( "remove_button" );
    var_1 = level._id_70B1[var_0]["view_pos"];
    var_2 = var_1 + _id_70AD( self._id_6E55, 4 );

    for (;;)
    {
        var_3 = ( 1.0, 0.0, 0.0 );

        if ( _id_5127( self._id_8B2B, self._id_311D ) )
            var_3 = ( 1.0, 1.0, 0.0 );

        if ( isdefined( level._id_246F ) && level._id_246F > 0 )
            var_4 = var_1 + _id_70AD( level._id_766C, 2 );

        wait 0.05;
    }
}

_id_A3F1( var_0, var_1 )
{
    level._id_0712 = undefined;

    if ( isdefined( level._id_70AE ) && level._id_70AE != "" )
        level._id_70B2 = level._id_70AE;
    else
    {
        level._id_70B2 = "main";
        level._id_70AE = "main";
    }

    foreach ( var_3 in level._id_70B0[level._id_70B2] )
        var_3 notify( "remove_button" );

    if ( isdefined( var_1 ) && var_1 )
        level._id_6329 _id_423B( level._id_70B1[level._id_70B2]["view_start"], var_0 );
    else
        level._id_6329 _id_423A( level._id_70B1[var_0]["view_start"] );

    level thread _id_2DC2( var_0 );
    level._id_70AE = var_0;
}

_id_40A0( var_0, var_1 )
{
    var_2 = level._id_70B1[var_0]["view_angles"];
    var_3 = level._id_70B1[var_0]["view_pos"];
    var_3 += vectornormalize( anglestoforward( var_2 ) ) * 40;
    var_4 = anglestoforward( var_2 );
    var_5 = vectornormalize( anglestoup( var_2 ) );
    var_6 = var_1.angles;
    var_7 = var_1.origin;
    var_8 = vectornormalize( vectorfromlinetopoint( var_3, var_3 + var_4, var_7 ) );
    var_9 = acos( vectordot( var_8, var_5 ) );

    if ( vectordot( anglestoright( var_2 ), var_8 ) < 0 )
        var_9 = 360 - var_9;

    return var_9;
}

_id_70AD( var_0, var_1 )
{
    var_2 = ( 270 - var_0, 0, 0 );
    var_3 = anglestoforward( var_2 );
    var_4 = vectornormalize( var_3 );
    var_5 = var_4 * var_1;
    return var_5;
}

_id_4020( var_0, var_1 )
{
    var_2 = ( var_0 + var_1 + 720 ) / 2 - 360;
    return var_2;
}

_id_5127( var_0, var_1 )
{
    var_2 = level._id_766C > var_0 && level._id_766C < 360;
    var_3 = level._id_766C > 0 && level._id_766C < var_1;

    if ( var_0 > var_1 )
        var_4 = var_2 || var_3;
    else
        var_4 = level._id_766C > var_0 && level._id_766C < var_1;

    return var_4;
}

_id_06E6()
{
    if ( isdefined( level._id_70AE ) && level._id_70AE != "main" )
        _id_A3F1( "main", 1 );
    else
        return;
}

_id_06EE()
{
    iprintlnbold( "action_weapons_primary" );
    _id_A3F1( "weapons_primary" );
}

_id_06EF()
{
    iprintlnbold( "action_weapons_secondary" );
    _id_A3F1( "weapons_secondary" );
}

_id_06E8()
{
    iprintlnbold( "action_gears" );
    _id_A3F1( "gears" );
}

_id_06E9()
{
    iprintlnbold( "action_killstreak" );
    _id_A3F1( "killstreak" );
}

_id_06EA()
{
    iprintlnbold( "action_leaderboards" );
    _id_A3F1( "leaderboards" );
}

_id_9E0A()
{
    level._id_9E0B = [];
    _id_185F( "player_view1_start" );
    _id_185F( "player_view2_start" );
    _id_185F( "player_view3_start" );
    _id_185F( "player_view4_start" );
    _id_185F( "player_view5_start" );
}

_id_185F( var_0 )
{
    level._id_9E0B[var_0] = [];
    var_1 = getent( var_0, "targetname" );

    for ( level._id_9E0B[var_0][level._id_9E0B[var_0].size] = var_1; isdefined( var_1 ) && isdefined( var_1.target ); var_1 = var_2 )
    {
        var_2 = getent( var_1.target, "targetname" );
        level._id_9E0B[var_0][level._id_9E0B[var_0].size] = var_2;
    }
}

_id_423A( var_0 )
{
    if ( !isdefined( level._id_2FC0 ) )
    {
        var_1 = level._id_9E0B[var_0][0];
        level._id_2FC0 = spawn( "script_model", var_1.origin );
        level._id_2FC0.angles = var_1.angles;
        self setorigin( level._id_2FC0.origin - ( 0.0, 0.0, 65.0 ) );
        self linkto( level._id_2FC0 );
        wait 0.05;
        self setangles( level._id_2FC0.angles );
        thread _id_399F();
    }

    var_2 = 1;
    var_3 = abs( distance( level._id_2FC0.origin, level._id_9E0B[var_0][level._id_9E0B[var_0].size - 1].origin ) );
    var_2 *= var_3 / 1200;
    var_2 = max( var_2, 0.1 );
    var_4 = var_2;

    if ( !1 )
        var_4 *= ( var_2 * ( level._id_9E0B[var_0].size + 1 ) );

    thread _id_14C6( 3, var_4 );

    foreach ( var_7, var_6 in level._id_9E0B[var_0] )
    {
        if ( 1 )
        {
            if ( var_7 != level._id_9E0B[var_0].size - 1 )
                continue;
        }

        level._id_2FC0 moveto( var_6.origin, var_2, var_2 * 0.5, 0 );
        level._id_2FC0 _meth_82B5( var_6.angles, var_2, var_2 * 0.5, 0 );
        wait(var_2);
    }
}

_id_423B( var_0, var_1 )
{
    var_2 = 1;
    var_3 = abs( distance( level._id_2FC0.origin, level._id_70B1[var_1]["player_view_pos"] ) );
    var_2 *= var_3 / 1200;
    var_2 = max( var_2, 0.1 );
    var_4 = var_2;

    if ( !1 )
        var_4 *= ( var_2 * ( level._id_9E0B[var_0].size + 1 ) );

    thread _id_14C6( 3, var_4 );

    if ( !1 )
    {
        for ( var_5 = level._id_9E0B[var_0].size - 1; var_5 >= 0; var_5-- )
        {
            var_6 = level._id_9E0B[var_0][var_5];
            level._id_2FC0 moveto( var_6.origin, var_2 );
            level._id_2FC0 _meth_82B5( var_6.angles, var_2 );
            wait(var_2);
        }
    }

    thread _id_14C6( 3, var_2 );
    var_7 = level._id_70B1[var_1]["player_view_pos"];
    var_8 = level._id_70B1[var_1]["view_angles"];
    level._id_2FC0 moveto( var_7, var_2, var_2 * 0.5, 0 );
    level._id_2FC0 _meth_82B5( var_8, var_2, var_2 * 0.5, 0 );
    wait(var_2);
}

_id_9722( var_0 )
{
    self setblurforplayer( 20, ( var_0 + 0.2 ) / 2 );
    self setblurforplayer( 0, ( var_0 + 0.2 ) / 2 );
    self shellshock( "frag_grenade_mp", var_0 + 0.2 );
}

_id_14C6( var_0, var_1 )
{
    var_2 = int( var_1 / 0.05 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_3 / var_2;
        var_5 = sin( 180 * var_4 );
        var_6 = var_0 * var_5;
        setdvar( "r_blur", var_6 );
        wait 0.05;
    }

    setdvar( "r_blur", 0 );
}

_id_399F()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level._id_2FC0 endon( "remove_dummy" );

    for (;;)
    {
        self setangles( level._id_2FC0.angles );
        wait 0.05;
    }
}
