// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !level.teambased )
        return;

    level._id_8F27 = [];
    level._id_8F28 = [];
    level._id_8F26 = [];
    setdvar( "scr_coop_util_delay", "1" );
}

_id_7017( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !level.teambased )
        return;

    var_7 = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_5 ) )
        var_7 = var_5.origin;

    var_8 = spawn( "script_model", var_7 );
    var_8 hide();
    var_8.team = var_0;
    var_8._id_6082 = var_3;
    var_8._id_1834 = var_4;
    var_8._id_8F22 = var_5;
    var_8._id_5288 = var_6;
    var_8._id_528A = var_1;
    var_8._id_8A66 = var_2;
    var_8._id_0014 = 0;
    var_8._id_7018 = _id_4142();

    if ( isdefined( var_5 ) )
        var_8 disableplayeruse( var_5 );

    _id_0832( var_8 );
    return var_8._id_7018;
}

_id_8EF9( var_0 )
{
    if ( !level.teambased )
        return;

    foreach ( var_2 in level._id_8F27 )
    {
        if ( var_2._id_7018 == var_0 )
        {
            thread _id_73DD( var_2 );
            return;
        }
    }

    foreach ( var_2 in level._id_8F28 )
    {
        if ( var_2._id_7018 == var_0 )
        {
            thread _id_73DD( var_2 );
            return;
        }
    }
}

_id_A0C9( var_0 )
{
    for (;;)
    {
        level waittill( "buddyJoinedStreak", var_1, var_2 );

        if ( var_2 == var_0 )
            return var_1;
    }
}

_id_6D49( var_0 )
{
    _id_6D4A( var_0 );
}

_id_6D2F()
{
    _id_6D30();
}

playerstoppromptforstreaksupport()
{
    if ( !level.teambased )
        return;

    if ( !isdefined( level._id_8F26[self.guid] ) )
        level._id_8F26[self.guid] = 0;

    level._id_8F26[self.guid]++;

    if ( level._id_8F26[self.guid] > 1 )
        return;

    if ( self.team == "allies" )
    {
        foreach ( var_1 in level._id_8F27 )
            var_1 disableplayeruse( self );
    }
    else
    {
        foreach ( var_1 in level._id_8F28 )
            var_1 disableplayeruse( self );
    }
}

playerstartpromptforstreaksupport()
{
    if ( !level.teambased )
        return;

    level._id_8F26[self.guid]--;

    if ( level._id_8F26[self.guid] > 0 )
        return;

    if ( self.team == "allies" )
    {
        foreach ( var_1 in level._id_8F27 )
        {
            if ( self != var_1._id_8F22 )
                var_1 enableplayeruse( self );
        }
    }
    else
    {
        foreach ( var_1 in level._id_8F28 )
        {
            if ( self != var_1._id_8F22 )
                var_1 enableplayeruse( self );
        }
    }
}

_id_0832( var_0 )
{
    if ( var_0.team == "allies" )
    {
        level._id_8F27[level._id_8F27.size] = var_0;

        if ( level._id_8F27.size == 1 )
            level thread _id_8D39( var_0 );
    }
    else
    {
        level._id_8F28[level._id_8F28.size] = var_0;

        if ( level._id_8F28.size == 1 )
            level thread _id_8D39( var_0 );
    }
}

_id_73DD( var_0 )
{
    var_1 = var_0._id_0014;
    var_0._id_0014 = 0;
    var_0 notify( "streakPromptStopped" );

    if ( var_0.team == "allies" )
    {
        level._id_8F27 = common_scripts\utility::array_remove( level._id_8F27, var_0 );

        if ( var_1 && level._id_8F27.size > 0 )
            level thread _id_8D39( level._id_8F27[0] );
    }
    else
    {
        level._id_8F28 = common_scripts\utility::array_remove( level._id_8F28, var_0 );

        if ( var_1 && level._id_8F28.size > 0 )
            level thread _id_8D39( level._id_8F28[0] );
    }

    thread _id_27D3( var_0 );
}

_id_27D3( var_0 )
{
    wait 1;
    var_0 delete();
}

_id_4142( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level._id_8F27 )
    {
        if ( var_3._id_7018 >= var_1 )
            var_1 = var_3._id_7018 + 1;
    }

    foreach ( var_3 in level._id_8F28 )
    {
        if ( var_3._id_7018 >= var_1 )
            var_1 = var_3._id_7018 + 1;
    }

    return var_1;
}

_id_8D39( var_0 )
{
    var_0._id_0014 = 1;
    level thread _id_466D( var_0 );
    level thread _id_645E( var_0 );

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_0._id_8F22 ) && var_2 == var_0._id_8F22 )
            continue;

        if ( maps\mp\_utility::isreallyalive( var_2 ) && var_2.team == var_0.team )
            var_2 thread _id_6D4D( var_0 );

        var_2 thread _id_6D1E( var_0 );
    }
}

_id_645E( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "streakPromptStopped" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_1 thread _id_6D1E( var_0 );
    }
}

_id_6D1E( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "streakPromptStopped" );

    for (;;)
    {
        self waittill( "spawned_player" );

        if ( self.team == var_0.team )
            thread _id_6D4D( var_0 );
    }
}

_id_6D4D( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "streakPromptStopped" );

    while ( maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition() )
        waitframe();

    _id_6C88( var_0 );
    thread _id_6C8B( var_0 );
    thread _id_6D6A( var_0 );
}

_id_6C88( var_0 )
{
    if ( !isdefined( level._id_8F26[self.guid] ) )
        return;

    if ( level._id_8F26[self.guid] > 0 )
    {
        var_0 disableplayeruse( self );

        while ( level._id_8F26[self.guid] > 0 )
            waitframe();
    }
}

_id_6C8B( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "streakPromptStopped" );

    if ( isdefined( var_0._id_8A66 ) )
        thread maps\mp\gametypes\_hud_message::coopkillstreaksplashnotify( var_0._id_8A66, var_0._id_6082 );
}

_id_A0DA( var_0, var_1 )
{
    if ( maps\mp\_utility::isinremotetransition() )
        var_0 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();

    waitframe();

    if ( maps\mp\_utility::isusingremote() )
        var_0 waittill( "stopped_using_remote" );
}

_id_A0E2( var_0 )
{
    var_0 endon( "streakPromptStopped" );
    var_0 waittill( "trigger" );
    return 1;
}

_id_6D6A( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        _id_A0DA( self );
        var_1 = _id_A0E2( var_0 );

        if ( !isdefined( var_1 ) )
            return;

        if ( !var_0._id_0014 )
            return;

        if ( isdefined( self _meth_84C5() ) && self _meth_84C5() == var_0 && self usebuttonpressed() && self isonground() )
        {
            var_2 = _id_6CAD();
            var_1 = _id_6CB8( var_0, var_2 );

            if ( var_1 || !var_0._id_0014 )
                return;
        }
    }
}

_id_6CAD()
{
    if ( getdvarint( "scr_coop_util_delay", 1 ) == 0 )
        return 1.25;
    else
    {
        var_0 = self.score;
        var_1 = self.score;

        for ( var_2 = 1; var_2 < level.players.size; var_2++ )
        {
            var_3 = level.players[var_2];

            if ( var_3.team != self.team )
                continue;

            if ( var_3.score > var_1 )
            {
                var_1 = var_3.score;
                continue;
            }

            if ( var_3.score < var_0 )
                var_0 = var_3.score;
        }

        var_4 = var_1 - var_0;

        if ( var_4 == 0 )
            return 1.25;

        var_5 = ( self.score - var_0 ) / var_4;
        var_6 = 1.25;
        var_7 = 1.25 + var_5 * var_6;
        return var_7;
    }
}

_id_466D( var_0 )
{
    var_0 maps\mp\_utility::makegloballyusablebytype( "coopStreakPrompt", var_0._id_528A, undefined, var_0.team );
    var_0 waittill( "streakPromptStopped" );
    var_0 maps\mp\_utility::makegloballyunusablebytype();
}

_id_6CB8( var_0, var_1 )
{
    var_2 = var_1 * 1000;

    if ( var_0 useholdthink( self, var_2, var_0 ) )
    {
        level notify( "buddyJoinedStreak", self, var_0._id_7018 );
        thread maps\mp\_events::killstreakjoinevent();

        if ( isdefined( var_0._id_8F22 ) && isalive( var_0._id_8F22 ) )
        {
            if ( isdefined( var_0._id_5288 ) )
                thread maps\mp\_utility::leaderdialogonplayer( var_0._id_5288 );

            if ( isdefined( var_0._id_1834 ) )
                var_0._id_8F22 thread maps\mp\_utility::leaderdialogonplayer( var_0._id_1834 );

            if ( isdefined( var_0._id_8F22._id_2517 ) )
                setmatchdata( "killstreaks", var_0._id_8F22._id_2517, "coopPlayerIndex", self.clientid );
        }

        var_0 notify( "streakPromptStopped" );
        return 1;
    }

    return 0;
}

useholdthink( var_0, var_1, var_2 )
{
    var_0 playerlinkto( var_2 );
    var_0 playerlinkedoffsetenable();
    var_0.manuallyjoiningkillstreak = 1;
    thread _id_9BFB( var_0 );
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;
    self.usetime = var_1;

    if ( isdefined( var_0._id_4FAA ) )
    {
        var_0 _meth_8119( 0 );
        var_0 _meth_811A( 0 );
    }

    var_0 maps\mp\_utility::_giveweapon( "killstreak_remote_turret_mp" );
    var_0 switchtoweapon( "killstreak_remote_turret_mp" );
    var_0 disableweaponswitch();
    var_0 thread personalusebar( self, var_2 );
    var_3 = useholdthinkloop( var_0, var_2 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( isalive( var_0 ) && !var_3 )
        var_0 _id_6D30();

    self.inuse = 0;
    self.curprogress = 0;

    if ( isdefined( var_0 ) )
    {
        var_0.manuallyjoiningkillstreak = 0;
        var_0 setclientomnvar( "ui_use_bar_text", 0 );
        var_0 setclientomnvar( "ui_use_bar_end_time", 0 );
        var_0 setclientomnvar( "ui_use_bar_start_time", 0 );
    }

    self notify( "coopUtilUseHoldThinkComplete" );
    return var_3;
}

_id_9BFB( var_0 )
{
    self endon( "coopUtilUseHoldThinkComplete" );
    var_0 common_scripts\utility::waittill_any( "death", "disconnect" );

    if ( isdefined( var_0 ) )
    {
        var_0 _id_6D30();
        var_0.manuallyjoiningkillstreak = 0;
        var_0 setclientomnvar( "ui_use_bar_text", 0 );
        var_0 setclientomnvar( "ui_use_bar_end_time", 0 );
        var_0 setclientomnvar( "ui_use_bar_start_time", 0 );
    }
}

_id_6D30()
{
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( "killstreak_predator_missile_mp" );
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( "killstreak_remote_turret_mp" );
    self _meth_8119( 1 );
    self _meth_811A( 1 );
    self enableweaponswitch();
    self switchtoweapon( common_scripts\utility::getlastweapon() );
    thread _id_6C81();
    self unlink();
}

_id_6D4A( var_0 )
{
    if ( isdefined( var_0 ) )
        wait(var_0);

    self enableweaponswitch();
    maps\mp\_utility::_giveweapon( "killstreak_predator_missile_mp" );
    self switchtoweaponimmediate( "killstreak_predator_missile_mp" );
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( "killstreak_remote_turret_mp" );
    self disableweaponswitch();
}

_id_6C81()
{
    self endon( "disconnect" );
    maps\mp\_utility::freezecontrolswrapper( 1 );
    wait 0.5;
    maps\mp\_utility::freezecontrolswrapper( 0 );
}

personalusebar( var_0, var_1 )
{
    self endon( "disconnect" );
    var_1 endon( "streakPromptStopped" );
    self setclientomnvar( "ui_use_bar_text", 2 );
    self setclientomnvar( "ui_use_bar_start_time", int( gettime() ) );
    var_2 = -1;

    while ( maps\mp\_utility::isreallyalive( self ) && isdefined( var_0 ) && var_0.inuse && !level.gameended )
    {
        if ( var_2 != var_0.userate )
        {
            if ( var_0.curprogress > var_0.usetime )
                var_0.curprogress = var_0.usetime;

            if ( var_0.userate > 0 )
            {
                var_3 = gettime();
                var_4 = var_0.curprogress / var_0.usetime;
                var_5 = var_3 + ( 1 - var_4 ) * var_0.usetime / var_0.userate;
                self setclientomnvar( "ui_use_bar_end_time", int( var_5 ) );
            }

            var_2 = var_0.userate;
        }

        wait 0.05;
    }

    self setclientomnvar( "ui_use_bar_end_time", 0 );
}

useholdthinkloop( var_0, var_1 )
{
    var_1 endon( "streakPromptStopped" );

    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::isreallyalive( var_0 ) && var_0 usebuttonpressed() && self.curprogress < self.usetime )
    {
        self.curprogress += 50 * self.userate;

        if ( isdefined( self.objectivescaler ) )
            self.userate = 1 * self.objectivescaler;
        else
            self.userate = 1;

        if ( self.curprogress >= self.usetime )
            return maps\mp\_utility::isreallyalive( var_0 );

        wait 0.05;
    }

    return 0;
}
