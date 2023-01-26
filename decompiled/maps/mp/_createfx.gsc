// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_2402()
{
    level._id_3AEC = common_scripts\utility::void;
    level._id_3AED = ::_id_3AED;
    level._id_3AE9 = _id_A4EE::_id_5880;
    level._id_3AEA = _id_A4EE::_id_649D;
    level._id_3AE4 = _id_A4EE::_id_23CA;
    level._id_3AEF = common_scripts\_createfx::_id_7487;
    level._id_3AEE = common_scripts\_createfx::_id_6FE9;
    level._id_3AEB = ::_id_3AEB;
    level._id_5FA9 = 1;
    level.callbackstartgametype = common_scripts\utility::void;
    level.callbackplayerconnect = common_scripts\utility::void;
    level.callbackplayerdisconnect = common_scripts\utility::void;
    level.callbackplayerdamage = common_scripts\utility::void;
    level.callbackplayerkilled = common_scripts\utility::void;
    level.callbackentityoutofworld = common_scripts\utility::void;
    level.callbackcodeendgame = common_scripts\utility::void;
    level.callbackplayerlaststand = common_scripts\utility::void;
    level.callbackplayerconnect = ::callback_playerconnect;
    level.callbackplayermigrated = common_scripts\utility::void;
    maps\mp\gametypes\_gameobjects::main( [] );
    thread common_scripts\_createfx::_id_3AE6();
    common_scripts\_createfx::_id_2407();
    level waittill( "eternity" );
}

_id_3AED( var_0 )
{
    return level.player.origin;
}

callback_playerconnect()
{
    self waittill( "begin" );

    if ( !isdefined( level.player ) )
    {
        var_0 = getentarray( "mp_global_intermission", "classname" );
        var_1 = ( var_0[0].angles[0], var_0[0].angles[1], 0.0 );
        self spawn( var_0[0].origin, var_1 );
        maps\mp\_utility::updatesessionstate( "playing" );
        self.maxhealth = 10000000;
        self.health = 10000000;
        level.player = self;
        thread common_scripts\_createfx::_id_241B();
    }
    else
        kick( self getentitynumber() );
}

_id_3AEB()
{
    var_0 = level._id_0575._id_6C16 / 190;
    level.player setmovespeedscale( var_0 );
}
