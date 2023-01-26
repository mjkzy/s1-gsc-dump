// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.killstreakfuncs["ripped_turret"] = ::_id_98C3;
    level.killstreakwieldweapons["turretheadmg_mp"] = "ripped_turret";
    level.killstreakwieldweapons["turretheadenergy_mp"] = "ripped_turret";
    level.killstreakwieldweapons["turretheadrocket_mp"] = "ripped_turret";
    level thread onplayerconnect();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        level thread onplayerspawned( var_0 );
    }
}

onplayerspawned( var_0 )
{
    for (;;)
    {
        var_0 waittill( "killstreakUseWaiter" );
        level thread _id_9AEB( var_0 );
    }
}

_id_9AEB( var_0 )
{
    var_0 setclientomnvar( "ui_energy_ammo", 1 );

    if ( !isdefined( var_0.pers["rippableSentry"] ) )
        return;

    var_1 = undefined;

    if ( var_0 hasweapon( "turretheadmg_mp" ) )
        var_1 = "turretheadmg_mp";
    else if ( var_0 hasweapon( "turretheadenergy_mp" ) )
        var_1 = "turretheadenergy_mp";
    else if ( var_0 hasweapon( "turretheadrocket_mp" ) )
        var_1 = "turretheadrocket_mp";

    if ( !isdefined( var_1 ) )
        return;

    var_2 = var_0 _id_6CAB();

    if ( _id_51D9( var_1 ) )
    {
        var_3 = _id_3EEE( var_1 );
        var_4 = var_2 / var_3;
        var_0 setclientomnvar( "ui_energy_ammo", var_4 );
    }
    else
        var_0 setweaponammoclip( var_1, var_2 );
}

_id_98C3( var_0, var_1 )
{
    var_2 = _id_98C4( var_1 );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( "ripped_turret", self.origin );

    return var_2;
}

_id_98C4( var_0 )
{
    if ( maps\mp\_utility::isusingremote() )
        return 0;

    var_1 = _id_6D4C( var_0 );
    return var_1;
}

playergiveturrethead( var_0 )
{
    maps\mp\killstreaks\_killstreaks::givekillstreak( "ripped_turret", 0, 0, self, [ var_0 ] );

    if ( !isdefined( self.pers["rippableSentry"] ) )
        self.pers["rippableSentry"] = spawnstruct();

    var_1 = _id_3EEE( var_0 );
    _id_6D29( var_1 );

    if ( !common_scripts\utility::is_player_gamepad_enabled() )
    {
        self notify( "streakUsed1" );
        waittillframeend;
    }

    self switchtoweapon( var_0 );
}

_id_6D13( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( var_2 == "turretheadenergy_mp" || var_2 == "turretheadrocket_mp" || var_2 == "turretheadmg_mp" )
            return 1;
    }

    return 0;
}

_id_6D4C( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = _id_6CAB();
    var_2 = var_0[0];

    if ( !_id_51D9( var_2 ) )
        self setweaponammoclip( var_2, var_1 );

    self setweaponammostock( var_2, 0 );
    thread _id_6D19( var_2 );

    if ( _id_51D9( var_2 ) )
        thread _id_6D4E( var_2, var_1 );
    else
        thread _id_6D6F( var_2 );

    common_scripts\utility::waittill_any_return( "death", "rippable_complete", "rippable_switch" );

    if ( !isdefined( self ) )
        return 0;

    if ( _id_51D9( var_2 ) )
    {
        self notifyonplayercommandremove( "fire_turret_weapon", "+attack" );
        self notifyonplayercommandremove( "fire_turret_weapon", "+attack_akimbo_accessible" );
    }

    var_3 = !_id_6CBC();
    return var_3;
}

_id_6D19( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "rippable_complete" );
    var_1 = self getcurrentweapon();

    while ( var_1 == var_0 || maps\mp\_utility::isbombsiteweapon( var_1 ) )
        self waittill( "weapon_change", var_1 );

    if ( maps\mp\_utility::iskillstreakweapon( var_1 ) )
        self.justswitchedtokillstreakweapon = var_1;

    self notify( "rippable_switch" );
}

_id_6D6F( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "rippable_switch" );

    for (;;)
    {
        var_1 = self getweaponammoclip( var_0 );
        _id_6D29( var_1 );

        if ( var_1 == 0 )
        {
            _id_6C73();
            self notify( "rippable_complete" );
            return;
        }

        waitframe();
    }
}

_id_6CBE()
{
    if ( _id_6CBC() )
        return 1;

    var_0 = self getweaponslistprimaries();

    foreach ( var_2 in var_0 )
    {
        if ( var_2 == "turretheadenergy_mp" || var_2 == "turretheadrocket_mp" || var_2 == "turretheadmg_mp" )
            return 1;
    }

    return 0;
}

_id_3EEE( var_0 )
{
    if ( var_0 == "turretheadmg_mp" )
        return 100;
    else if ( var_0 == "turretheadrocket_mp" )
        return 6;
    else
        return getfullenergy();
}

_id_51D9( var_0 )
{
    return var_0 == "turretheadenergy_mp";
}

_id_6D4E( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "rippable_switch" );
    var_2 = getfullenergy();
    self notifyonplayercommand( "fire_turret_weapon", "+attack" );
    self notifyonplayercommand( "fire_turret_weapon", "+attack_akimbo_accessible" );
    var_1 = _id_6CAB();
    var_3 = var_1 / var_2;
    self setclientomnvar( "ui_energy_ammo", var_3 );

    for (;;)
    {
        if ( !self attackbuttonpressed() )
            self waittill( "fire_turret_weapon" );

        if ( self isswitchingweapon() || self getcurrentweapon() != "turretheadenergy_mp" || !self _meth_812D() || self _meth_84E0() )
        {
            waitframe();
            continue;
        }

        var_1 = _id_6CAB();
        var_1 = clamp( var_1 - 1, 0, getfullenergy() );
        var_3 = var_1 / var_2;
        self setclientomnvar( "ui_energy_ammo", var_3 );

        if ( var_1 <= 0 )
        {
            var_4 = self getweaponslistprimaries();

            if ( var_4.size > 0 )
                self switchtoweapon( var_4[0] );
            else
                self takeweapon( var_0 );

            _id_6C73();
            self notify( "rippable_complete" );
            return;
        }

        waitframe();
        _id_6D29( var_1 );
    }
}

getfullenergy()
{
    return 200.0;
}

_id_6CAB()
{
    return self.pers["rippableSentry"].ammo;
}

_id_6D29( var_0 )
{
    self.pers["rippableSentry"].ammo = var_0;
}

_id_6CBC()
{
    return isdefined( self.pers["rippableSentry"] ) && _id_6CAB() > 0;
}

_id_6C73()
{
    self.pers["rippableSentry"] = undefined;
}
