// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( level.rankedmatch && !( getdvarint( "scr_game_division", 0 ) > 0 ) )
        level thread onplayerconnect();
}

onplayerconnect()
{
    level endon( "game_ended" );
    level waittill( "prematch_over" );
    waitframe();

    foreach ( var_1 in level.players )
    {
        if ( isbot( var_1 ) )
            continue;

        var_1 _id_7454();
        var_1 thread _id_1D05();
    }

    for (;;)
    {
        level waittill( "connected", var_1 );

        if ( isbot( var_1 ) )
            continue;

        var_1 _id_7454();
        var_1 thread _id_1D05();
    }
}

_id_7454()
{
    self setclientomnvar( "ui_reinforcement_timer_type", 0 );
    self setclientomnvar( "ui_reinforcement_timer", 0 );
}

_id_8F16( var_0 )
{
    self.pers["reinforcements"] = spawnstruct();
    self.pers["reinforcements"].type = var_0;
    self.pers["reinforcements"]._id_8D3C = maps\mp\_utility::getgametimepassedms();
}

_id_1ABD()
{
    self.pers["reinforcements"].type = 0;
}

_id_67B8()
{
    return isdefined( self.pers["reinforcements"] );
}

_id_1D05()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !maps\mp\_utility::allowclasschoice() )
        return;

    if ( self.health <= 0 )
        self waittill( "spawned_player" );

    if ( _id_67B8() )
    {
        thread _id_2166();
        return;
    }

    var_0 = 0;

    if ( maps\mp\_utility::practiceroundgame() )
        var_0 = 4;
    else
        var_0 = self _meth_850F();

    _id_8F16( var_0 );

    if ( var_0 == 0 )
        return;

    var_2 = _id_4132( var_0 );
    var_3 = _id_4130();

    if ( var_3 < var_2 )
    {
        _id_1ABD();
        return;
    }

    thread _id_A026( var_0, var_2 );
}

_id_2166()
{
    var_0 = self.pers["reinforcements"].type;

    if ( var_0 == 0 )
        return;

    var_1 = _id_4132( var_0 );
    var_2 = maps\mp\_utility::getgametimepassedms();
    var_3 = self.pers["reinforcements"]._id_8D3C;
    var_1 -= var_2;
    var_1 += var_3;
    thread _id_A026( var_0, var_1 );
}

_id_4130()
{
    if ( maps\mp\_utility::isroundbased() )
    {
        var_0 = maps\mp\_utility::getscorelimit();
        var_1 = min( var_0 - maps\mp\_utility::getroundswon( "allies" ), var_0 - maps\mp\_utility::getroundswon( "axis" ) );
        var_2 = maps\mp\_utility::gettimelimit() * var_1;
        return var_2 * 60 * 1000 - maps\mp\_utility::gettimepassed();
    }
    else
        return maps\mp\gametypes\_gamelogic::gettimeremaining();
}

_id_4132( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            return 120000;
        case 2:
            return 240000;
        case 3:
            return 360000;
        case 4:
            return 60000;
        default:
            break;
    }

    return 0;
}

_id_3FCF( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 1;
        default:
            break;
    }

    return 0;
}

_id_3F24( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            return "airdrop_reinforcement_common";
        case 2:
            return "airdrop_reinforcement_uncommon";
        case 3:
            return "airdrop_reinforcement_rare";
        case 4:
            return "airdrop_reinforcement_practice";
        default:
            break;
    }

    return "";
}

_id_A026( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = _id_3FCF( var_0 );
    self setclientomnvar( "ui_reinforcement_timer_type", var_2 );
    self setclientomnvar( "ui_reinforcement_timer", gettime() + var_1 );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_1 / 1000.0 );
    self setclientomnvar( "ui_reinforcement_timer_type", 0 );
    self setclientomnvar( "ui_reinforcement_timer", 0 );
    _id_41FE( var_0 );
}

_id_41FE( var_0 )
{
    if ( !isplayer( self ) )
        return;

    var_1 = _id_3F24( var_0 );
    var_2 = 500;
    var_3 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex( var_1 );
    thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( var_1, var_2, undefined, undefined, var_3 );
    maps\mp\killstreaks\_killstreaks::givekillstreak( var_1 );
    _id_1ABD();
}
