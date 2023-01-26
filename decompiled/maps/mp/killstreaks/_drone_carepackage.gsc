// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._id_1B8F = spawnstruct();
    level._id_1B8F.health = 999999;
    level._id_1B8F.maxhealth = 200;
    level._id_1B8F._id_3BA9 = loadfx( "vfx/explosion/tracking_drone_explosion" );
    level._id_1B8F._id_8898 = "veh_tracking_drone_explode";
    level._id_1B8F._id_730D = &"KILLSTREAKS_DRONE_CAREPACKAGE_RELEASE";
    level._id_1B99 = [];
}

_id_82FC( var_0, var_1 )
{
    var_0 common_scripts\utility::make_entity_sentient_mp( self.team );
    var_0 _meth_83F3( 1 );
    var_0 _id_0847();
    var_0 thread _id_73A3();
    var_0.health = level._id_1B8F.health;
    var_0.maxhealth = level._id_1B8F.maxhealth;
    var_0.damagetaken = 0;
    var_0._id_03E3 = 15;
    var_0._id_3978 = 15;
    var_0.owner = self;
    var_0.team = self.team;
    var_0 _meth_8283( var_0._id_03E3, 10, 10 );
    var_0 _meth_8292( 120, 90 );
    var_0 _meth_825A( 64 );
    var_0 _meth_8253( 4, 5, 5 );
    var_0._id_3B88 = "tag_body";

    if ( var_1 )
    {
        var_0._id_9BC7 = spawn( "script_model", var_0.origin + ( 0.0, 0.0, 1.0 ) );
        var_0._id_9BC7 setmodel( "tag_origin" );
        var_0._id_9BC7.owner = self;
        var_0._id_9BC7 maps\mp\_utility::makegloballyusablebytype( "killstreakRemote", level._id_1B8F._id_730D, self );
    }

    var_2 = 45;
    var_3 = 45;
    var_0 _meth_8294( var_2, var_3 );
    var_4 = 10000;
    var_5 = 150;
    var_0._id_0E54 = missile_createattractorent( var_0, var_4, var_5 );
    var_0.stunned = 0;
    var_0 thread _id_1B95();
    var_0 thread _id_1B96();
    var_0 thread _id_1B97();
}

_id_1B91()
{
    self endon( "death" );
    var_0 = self.owner;
    self._id_9BC7 waittill( "trigger" );
    _id_1B90();
}

_id_1B95()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    _id_1B93();
}

_id_1B96()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_gone" );
    thread _id_1B93();
}

_id_1B97()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread _id_1B93();
}

_id_1B93()
{
    self endon( "death" );
    self notify( "leaving" );
    _id_1B92();
}

_id_1B92()
{
    if ( isdefined( level._id_1B8F._id_3BA9 ) )
        playfx( level._id_1B8F._id_3BA9, self.origin );

    if ( isdefined( level._id_1B8F._id_8898 ) )
        self playsound( level._id_1B8F._id_8898 );

    if ( isdefined( self._id_9BC7 ) )
    {
        self._id_9BC7 maps\mp\_utility::makegloballyunusablebytype();
        self._id_9BC7 delete();
    }

    self notify( "explode" );
    _id_1B94();
}

_id_1B90()
{
    if ( isdefined( self._id_9BC7 ) )
    {
        self._id_9BC7 maps\mp\_utility::makegloballyunusablebytype();
        self._id_9BC7 delete();
    }

    self notify( "explode" );
    _id_1B94();
}

_id_1B94()
{
    maps\mp\_utility::decrementfauxvehiclecount();
    self delete();
}

_id_0847()
{
    level._id_1B99[level._id_1B99.size] = self;
}

_id_73A3()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level._id_1B99 = common_scripts\utility::array_remove( level._id_1B99, self );
}
