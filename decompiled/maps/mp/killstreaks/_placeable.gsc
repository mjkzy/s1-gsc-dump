// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level._id_685B ) )
        level._id_685B = [];
}

_id_41F6( var_0 )
{
    var_1 = _id_2431( var_0 );
    _id_73CC();
    self._id_1BAB = var_1;
    var_2 = _id_6450( var_0, var_1, 1 );
    self._id_1BAB = undefined;
    _id_74AA();
    return isdefined( var_1 );
}

_id_2431( var_0 )
{
    if ( isdefined( self.iscarrying ) && self.iscarrying )
        return;

    var_1 = level._id_685B[var_0];
    var_2 = spawn( "script_model", self.origin );
    var_2 setmodel( var_1._id_5D3A );
    var_2.angles = self.angles;
    var_2.owner = self;
    var_2.team = self.team;
    var_2._id_210F = var_1;
    var_2._id_381E = 1;

    if ( isdefined( var_1._id_6460 ) )
        var_2 [[ var_1._id_6460 ]]( var_0 );

    var_2 _id_2628( var_0 );
    var_2 thread _id_9364( var_0 );
    var_2 thread _id_468A( var_0 );
    var_2 thread _id_64B2( var_0 );
    var_2 thread ongameended( var_0 );
    var_2 thread createbombsquadmodel( var_0 );
    return var_2;
}

_id_468A( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_1 );

        if ( !maps\mp\_utility::isreallyalive( var_1 ) )
            continue;

        if ( isdefined( self getlinkedparent() ) )
            self unlink();

        var_1 _id_6450( var_0, self, 0 );
    }
}

_id_6450( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 thread _id_6457( var_0, self );
    common_scripts\utility::_disableweapon();

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "placePlaceable", "+attack" );
        self notifyonplayercommand( "placePlaceable", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancelPlaceable", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 5" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 6" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 7" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 8" );
        }
    }

    for (;;)
    {
        var_3 = common_scripts\utility::waittill_any_return( "placePlaceable", "cancelPlaceable", "force_cancel_placement" );

        if ( !isdefined( var_1 ) )
        {
            common_scripts\utility::_enableweapon();
            return 1;
        }
        else if ( var_3 == "cancelPlaceable" && var_2 || var_3 == "force_cancel_placement" )
        {
            var_1 _id_6454( var_0, var_3 == "force_cancel_placement" && !isdefined( var_1._id_381E ) );
            return 0;
        }
        else if ( var_1._id_1AAE )
        {
            var_1 thread _id_64C2( var_0 );
            common_scripts\utility::_enableweapon();
            return 1;
        }
    }
}

_id_6454( var_0, var_1 )
{
    if ( isdefined( self._id_1BAA ) )
    {
        var_2 = self._id_1BAA;
        var_2 _meth_80DE();
        var_2.iscarrying = undefined;
        var_2._id_1BAB = undefined;
        var_2 common_scripts\utility::_enableweapon();
    }

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel delete();

    if ( isdefined( self._id_1BAC ) )
        self._id_1BAC delete();

    var_3 = level._id_685B[var_0];

    if ( isdefined( var_3._id_6455 ) )
        self [[ var_3._id_6455 ]]( var_0 );

    if ( isdefined( var_1 ) && var_1 )
        maps\mp\gametypes\_weapons::equipmentdeletevfx();

    self delete();
}

_id_64C2( var_0 )
{
    var_1 = level._id_685B[var_0];
    self.origin = self._id_6863;
    self.angles = self._id_1BAC.angles;
    self playsound( var_1._id_685C );
    _id_851E( var_0 );

    if ( isdefined( var_1._id_64C3 ) )
        self [[ var_1._id_64C3 ]]( var_0 );

    self setcursorhint( "HINT_NOICON" );
    self sethintstring( var_1._id_01F2 );
    var_2 = self.owner;
    var_2 _meth_80DE();
    var_2.iscarrying = undefined;
    self._id_1BAA = undefined;
    self._id_5170 = 1;
    self._id_381E = undefined;

    if ( isdefined( var_1._id_4775 ) )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0, 0, var_1._id_4775 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( var_2, ( 0, 0, var_1._id_4775 ) );
    }

    thread _id_4651( var_0 );
    thread _id_4653( var_0 );
    self makeusable();
    common_scripts\utility::make_entity_sentient_mp( self.owner.team );

    if ( issentient( self ) )
        self setthreatbiasgroup( "DogsDontAttack" );

    foreach ( var_4 in level.players )
    {
        if ( var_4 == var_2 )
        {
            self enableplayeruse( var_4 );
            continue;
        }

        self disableplayeruse( var_4 );
    }

    if ( isdefined( self._id_84AA ) )
    {
        level thread maps\mp\_utility::teamplayercardsplash( var_1._id_8A61, var_2 );
        self._id_84AA = 0;
    }

    var_6 = spawnstruct();
    var_6._id_5791 = self._id_5F9F;
    var_6._id_6A3B = 1;
    var_6.endonstring = "carried";

    if ( isdefined( var_1._id_64BA ) )
        var_6.deathoverridecallback = var_1._id_64BA;

    thread maps\mp\_movers::handle_moving_platforms( var_6 );
    thread _id_A241();
    self notify( "placed" );
    self._id_1BAC delete();
    self._id_1BAC = undefined;
}

_id_6457( var_0, var_1 )
{
    var_2 = level._id_685B[var_0];
    self._id_1BAC = var_1 _id_23E8( var_0 );
    self._id_5170 = undefined;
    self._id_1BAA = var_1;
    var_1.iscarrying = 1;
    _id_2628( var_0 );
    _id_487B( var_0 );

    if ( isdefined( var_2._id_6458 ) )
        self [[ var_2._id_6458 ]]( var_0 );

    thread updateplacement( var_0, var_1 );
    thread _id_6459( var_0, var_1 );
    self notify( "carried" );
}

updateplacement( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "placed" );
    self endon( "death" );
    self._id_1AAE = 1;
    var_2 = -1;
    var_3 = level._id_685B[var_0];
    var_4 = ( 0.0, 0.0, 0.0 );

    if ( isdefined( var_3._id_6861 ) )
        var_4 = ( 0, 0, var_3._id_6861 );

    var_5 = self._id_1BAC;

    for (;;)
    {
        var_6 = var_1 _meth_82D2( 1, var_3._id_6864 );
        self._id_6863 = var_6["origin"];
        var_5.origin = self._id_6863 + var_4;
        var_5.angles = var_6["angles"];
        self._id_1AAE = var_1 isonground() && var_6["result"] && abs( self._id_6863[2] - var_1.origin[2] ) < var_3._id_685F;

        if ( isdefined( var_6["entity"] ) )
            self._id_5F9F = var_6["entity"];
        else
            self._id_5F9F = undefined;

        if ( self._id_1AAE != var_2 )
        {
            if ( self._id_1AAE )
            {
                var_5 setmodel( var_3._id_5D40 );
                var_1 _meth_80DD( var_3._id_6865 );
            }
            else
            {
                var_5 setmodel( var_3._id_5D41 );
                var_1 _meth_80DD( var_3._id_1AD4 );
            }
        }

        var_2 = self._id_1AAE;
        wait 0.05;
    }
}

_id_2628( var_0 )
{
    self makeunusable();
    _id_4874();
    self freeentitysentient();
    var_1 = level._id_685B[var_0];

    if ( isdefined( var_1._id_6462 ) )
        self [[ var_1._id_6462 ]]( var_0 );
}

_id_4874()
{
    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( "none", ( 0.0, 0.0, 0.0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::setplayerheadicon( undefined, ( 0.0, 0.0, 0.0 ) );
}

_id_4651( var_0 )
{
    self endon( "carried" );
    var_1 = level._id_685B[var_0];
    maps\mp\gametypes\_damage::setentitydamagecallback( var_1.maxhealth, var_1.damagefeedback, ::_id_4654, ::modifydamage, 1 );
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_5 = self._id_210F;

    if ( isdefined( var_5._id_0AAC ) && var_5._id_0AAC )
        var_4 = maps\mp\gametypes\_damage::handlemeleedamage( var_1, var_2, var_4 );

    if ( isdefined( var_5._id_0AA6 ) && var_5._id_0AA6 )
        var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4, var_0 );

    var_4 = maps\mp\gametypes\_damage::handlemissiledamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );

    if ( isdefined( var_5.modifydamage ) )
        var_4 = self [[ var_5.modifydamage ]]( var_1, var_2, var_4 );

    return var_4;
}

_id_4654( var_0, var_1, var_2, var_3 )
{
    var_4 = self._id_210F;
    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, var_4._id_A39E, var_4._id_28E6 );
}

_id_4653( var_0 )
{
    self endon( "carried" );
    self waittill( "death" );
    var_1 = level._id_685B[var_0];

    if ( isdefined( self ) )
    {
        _id_2628( var_0 );

        if ( isdefined( var_1._id_5D3C ) )
            self setmodel( var_1._id_5D3C );

        if ( isdefined( var_1._id_6465 ) )
            self [[ var_1._id_6465 ]]( var_0 );

        self delete();
    }
}

_id_6459( var_0, var_1 )
{
    self endon( "placed" );
    self endon( "death" );
    var_1 endon( "disconnect" );
    var_1 waittill( "death" );

    if ( self._id_1AAE )
        thread _id_64C2( var_0 );
    else
        _id_6454( var_0 );
}

_id_64B2( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self.owner waittill( "killstreak_disowned" );
    _id_1E5F( var_0 );
}

ongameended( var_0 )
{
    self endon( "death" );
    level waittill( "game_ended" );
    _id_1E5F( var_0 );
}

_id_1E5F( var_0 )
{
    if ( isdefined( self._id_5170 ) )
        self notify( "death" );
    else
        _id_6454( var_0 );
}

_id_A241()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        thread _id_64C8( var_0 );
    }
}

_id_64C8( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    self disableplayeruse( var_0 );
}

_id_9364( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_1 = level._id_685B[var_0];
    var_2 = var_1._id_56F5;

    while ( var_2 > 0.0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( !isdefined( self._id_1BAA ) )
            var_2 -= 1.0;
    }

    if ( isdefined( self.owner ) && isdefined( var_1._id_4273 ) )
        self.owner thread maps\mp\_utility::leaderdialogonplayer( var_1._id_4273 );

    self notify( "death" );
}

_id_73E9()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self.restoreweapon = "iw6_riotshield_mp";
        self takeweapon( "iw6_riotshield_mp" );
    }
}

_id_73CC()
{
    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        self._id_74A9 = "specialty_explosivebullets";
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
    }
}

_id_74B2()
{
    if ( isdefined( self.restoreweapon ) )
    {
        maps\mp\_utility::_giveweapon( self.restoreweapon );
        self.restoreweapon = undefined;
    }
}

_id_74AA()
{
    if ( isdefined( self._id_74A9 ) )
    {
        maps\mp\_utility::giveperk( self._id_74A9, 0 );
        self._id_74A9 = undefined;
    }
}

createbombsquadmodel( var_0 )
{
    var_1 = level._id_685B[var_0];

    if ( isdefined( var_1._id_5D3B ) )
    {
        var_2 = spawn( "script_model", self.origin );
        var_2.angles = self.angles;
        var_2 hide();
        var_2 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater( self.owner );
        var_2 setmodel( var_1._id_5D3B );
        var_2 linkto( self );
        var_2 setcontents( 0 );
        self.bombsquadmodel = var_2;
        self waittill( "death" );

        if ( isdefined( var_2 ) )
        {
            var_2 delete();
            self.bombsquadmodel = undefined;
        }
    }
}

_id_851E( var_0 )
{
    self show();

    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( "update_bombsquad" );
    }
}

_id_487B( var_0 )
{
    self hide();

    if ( isdefined( self.bombsquadmodel ) )
        self.bombsquadmodel hide();
}

_id_23E8( var_0 )
{
    if ( isdefined( self.iscarrying ) && self.iscarrying )
        return;

    var_1 = spawnturret( "misc_turret", self.origin + ( 0.0, 0.0, 25.0 ), "sentry_minigun_mp" );
    var_1.angles = self.angles;
    var_1.owner = self;
    var_2 = level._id_685B[var_0];
    var_1 setmodel( var_2._id_5D3A );
    var_1 _meth_8138();
    var_1 _meth_817A( 1 );
    var_1 _meth_8065( "sentry_offline" );
    var_1 makeunusable();
    var_1 _meth_8103( self );
    var_1 _meth_8104( self );
    var_1 setcandamage( 0 );
    var_1 setcontents( 0 );
    return var_1;
}
