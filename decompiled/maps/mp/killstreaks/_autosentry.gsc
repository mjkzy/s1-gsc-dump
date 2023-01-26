// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.sentrytype ) )
        level.sentrytype = [];

    level.sentrytype["sentry_minigun"] = "sentry";
    level.sentrytype["sam_turret"] = "sam_turret";
    level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::_id_98A4;
    level.killstreakfuncs[level.sentrytype["sam_turret"]] = ::_id_98C5;

    if ( !isdefined( level._id_7CC5 ) )
        level._id_7CC5 = [];

    level._id_7CC5["sentry_minigun"] = spawnstruct();
    level._id_7CC5["sentry_minigun"].health = 999999;
    level._id_7CC5["sentry_minigun"].maxhealth = 1000;
    level._id_7CC5["sentry_minigun"]._id_1933 = 20;
    level._id_7CC5["sentry_minigun"]._id_1932 = 120;
    level._id_7CC5["sentry_minigun"]._id_6721 = 0.15;
    level._id_7CC5["sentry_minigun"]._id_6720 = 0.35;
    level._id_7CC5["sentry_minigun"]._id_7CC4 = "sentry";
    level._id_7CC5["sentry_minigun"]._id_7CC3 = "sentry_offline";
    level._id_7CC5["sentry_minigun"]._id_9364 = 90.0;
    level._id_7CC5["sentry_minigun"]._id_8A5D = 0.05;
    level._id_7CC5["sentry_minigun"]._id_65F2 = 8.0;
    level._id_7CC5["sentry_minigun"]._id_21B4 = 0.1;
    level._id_7CC5["sentry_minigun"]._id_3BBD = 0.3;
    level._id_7CC5["sentry_minigun"].streakname = "sentry";
    level._id_7CC5["sentry_minigun"]._id_051C = "sentry_minigun_mp";
    level._id_7CC5["sentry_minigun"]._id_5D3A = "sentry_minigun_weak";
    level._id_7CC5["sentry_minigun"]._id_5D40 = "sentry_minigun_weak_obj";
    level._id_7CC5["sentry_minigun"]._id_5D41 = "sentry_minigun_weak_obj_red";
    level._id_7CC5["sentry_minigun"]._id_5D3C = "sentry_minigun_weak_destroyed";
    level._id_7CC5["sentry_minigun"]._id_01F2 = &"SENTRY_PICKUP";
    level._id_7CC5["sentry_minigun"].headicon = 1;
    level._id_7CC5["sentry_minigun"]._id_91FB = "used_sentry";
    level._id_7CC5["sentry_minigun"]._id_84AA = 0;
    level._id_7CC5["sentry_minigun"]._id_9F28 = "sentry_destroyed";
    level._id_7CC5["sam_turret"] = spawnstruct();
    level._id_7CC5["sam_turret"].health = 999999;
    level._id_7CC5["sam_turret"].maxhealth = 1000;
    level._id_7CC5["sam_turret"]._id_1933 = 20;
    level._id_7CC5["sam_turret"]._id_1932 = 120;
    level._id_7CC5["sam_turret"]._id_6721 = 0.15;
    level._id_7CC5["sam_turret"]._id_6720 = 0.35;
    level._id_7CC5["sam_turret"]._id_7CC4 = "sentry_manual";
    level._id_7CC5["sam_turret"]._id_7CC3 = "sentry_offline";
    level._id_7CC5["sam_turret"]._id_9364 = 90.0;
    level._id_7CC5["sam_turret"]._id_8A5D = 0.05;
    level._id_7CC5["sam_turret"]._id_65F2 = 8.0;
    level._id_7CC5["sam_turret"]._id_21B4 = 0.1;
    level._id_7CC5["sam_turret"]._id_3BBD = 0.3;
    level._id_7CC5["sam_turret"].streakname = "sam_turret";
    level._id_7CC5["sam_turret"]._id_051C = "sam_mp";
    level._id_7CC5["sam_turret"]._id_5D3A = "mp_sam_turret";
    level._id_7CC5["sam_turret"]._id_5D40 = "mp_sam_turret_placement";
    level._id_7CC5["sam_turret"]._id_5D41 = "mp_sam_turret_placement_failed";
    level._id_7CC5["sam_turret"]._id_5D3C = "mp_sam_turret";
    level._id_7CC5["sam_turret"]._id_01F2 = &"SENTRY_PICKUP";
    level._id_7CC5["sam_turret"].headicon = 1;
    level._id_7CC5["sam_turret"]._id_91FB = "used_sam_turret";
    level._id_7CC5["sam_turret"]._id_84AA = 0;
    level._id_7CC5["sam_turret"]._id_9F28 = "sam_destroyed";
    level._effect["sentry_overheat_mp"] = loadfx( "vfx/distortion/sentrygun_overheat" );
    level._effect["sentry_explode_mp"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["sentry_smoke_mp"] = loadfx( "vfx/smoke/vehicle_sentrygun_damaged_smoke" );
    level._effect["sentry_stunned"] = loadfx( "vfx/sparks/direct_hack_stun" );
}

_id_98A4( var_0, var_1 )
{
    var_2 = _id_4201( "sentry_minigun" );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level._id_7CC5["sentry_minigun"].streakname, self.origin );

    return var_2;
}

_id_98C5( var_0, var_1 )
{
    var_2 = _id_4201( "sam_turret" );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level._id_7CC5["sam_turret"].streakname, self.origin );

    return var_2;
}

_id_4201( var_0 )
{
    if ( !maps\mp\_utility::validateusestreak() )
        return 0;

    self._id_5553 = var_0;
    var_1 = _id_243B( var_0, self );
    _id_73CC();
    var_2 = _id_7F31( var_1, 1 );
    thread _id_A04D();
    self.iscarrying = 0;

    if ( isdefined( var_1 ) )
        return 1;
    else
        return 0;
}

_id_7F31( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 _id_7CB8( self );
    common_scripts\utility::_disableweapon();

    if ( !isai( self ) )
    {
        self notifyonplayercommand( "place_sentry", "+attack" );
        self notifyonplayercommand( "place_sentry", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancel_sentry", "+actionslot 5" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 6" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 7" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 8" );
        }
    }

    for (;;)
    {
        var_2 = common_scripts\utility::waittill_any_return( "place_sentry", "cancel_sentry", "force_cancel_placement" );

        if ( var_2 == "cancel_sentry" || var_2 == "force_cancel_placement" )
        {
            if ( !var_1 && var_2 == "cancel_sentry" )
                continue;

            if ( level.console )
            {
                var_3 = maps\mp\_utility::getkillstreakweapon( level._id_7CC5[var_0.sentrytype].streakname );

                if ( isdefined( self.killstreakindexweapon ) && var_3 == maps\mp\_utility::getkillstreakweapon( self.pers["killstreaks"][self.killstreakindexweapon].streakname ) && !self getweaponslistitems().size )
                {
                    maps\mp\_utility::_giveweapon( var_3, 0 );
                    maps\mp\_utility::_setactionslot( 4, "weapon", var_3 );
                }
            }

            var_0 _id_7CB7();
            common_scripts\utility::_enableweapon();
            return 0;
        }

        if ( !var_0._id_1AAE )
            continue;

        var_0 _id_7CBB();
        common_scripts\utility::_enableweapon();
        return 1;
    }
}

_id_73E9()
{
    if ( self hasweapon( "riotshield_mp" ) )
    {
        self.restoreweapon = "riotshield_mp";
        self takeweapon( "riotshield_mp" );
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

_id_A04D()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    _id_74AA();
}

_id_243B( var_0, var_1 )
{
    var_2 = spawnturret( "misc_turret", var_1.origin, level._id_7CC5[var_0]._id_051C );
    var_2.angles = var_1.angles;
    var_2 _id_7CAD( var_0, var_1 );
    return var_2;
}

_id_7CAD( var_0, var_1 )
{
    self.sentrytype = var_0;
    self._id_1AAE = 1;
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );
    self._id_84AA = 1;
    self setcandamage( 1 );

    switch ( var_0 )
    {
        case "sam_turret":
            self _meth_8138();
            self _meth_8156( 180 );
            self _meth_8155( 180 );
            self _meth_8157( 80 );
            self _meth_815A( -89.0 );
            self._id_54D7 = 0;
            var_2 = spawn( "script_model", self gettagorigin( "tag_laser" ) );
            var_2 linkto( self );
            self.killcament = var_2;
            self.killcament setscriptmoverkillcam( "explosive" );
            break;
        default:
            self _meth_8138();
            self _meth_815A( -89.0 );
            break;
    }

    self _meth_817A( 1 );
    _id_7CB9();
    _id_7CBA( var_1 );
    thread _id_7CA9();
    thread _id_7CC0();

    switch ( var_0 )
    {
        case "sam_turret":
            thread _id_7CAB();
            thread _id_7CA3();
            break;
        default:
            thread _id_7CAB();
            thread _id_7CA2();
            thread _id_7CA3();
            break;
    }
}

_id_7CC1()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        playfxontag( common_scripts\utility::getfx( "sentry_stunned" ), self, "tag_aim" );
        self _meth_815A( 40 );
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
        wait(var_1);
        stopfxontag( common_scripts\utility::getfx( "sentry_stunned" ), self, "tag_aim" );
        self _meth_815A( -89.0 );
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
    }
}

_id_7CA6()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._id_2A69 = 0.25;

    if ( isdefined( self._id_2A6B ) && gettime() < self._id_2A6B )
    {
        self._id_2A6B = gettime() + self._id_2A69 * 1000;
        return;
    }

    playfxontag( common_scripts\utility::getfx( "sentry_stunned" ), self, "tag_aim" );
    self._id_2A6B = gettime() + self._id_2A69 * 1000;
    self _meth_815A( 40 );
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );

    for (;;)
    {
        if ( gettime() > self._id_2A6B )
            break;

        wait 0.05;
    }

    self _meth_815A( -89.0 );
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
    stopfxontag( common_scripts\utility::getfx( "sentry_stunned" ), self, "tag_aim" );
}

_id_7CA9()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3C );
    _id_7CB9();
    self _meth_815A( 40 );
    self _meth_8103( undefined );
    self _meth_8105( 0 );

    if ( isdefined( self._id_6638 ) )
        self._id_6638 delete();

    self playsound( "sentry_explode" );

    if ( isdefined( self._id_4F93 ) )
    {
        playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_origin" );
        playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        self._id_4F93._id_9976 maps\mp\gametypes\_hud_util::destroyelem();
        self._id_4F93 _id_74AA();
        self._id_4F93 _id_74B2();
        self notify( "deleting" );
        wait 1.0;
        stopfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_origin" );
        stopfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
    }
    else
    {
        playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "tag_aim" );
        wait 1.5;
        self playsound( "sentry_explode_smoke" );

        for ( var_0 = 8; var_0 > 0; var_0 -= 0.4 )
        {
            playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
            wait 0.4;
        }

        self notify( "deleting" );
    }

    if ( isdefined( self.killcament ) )
        self.killcament delete();

    self delete();
}

_id_7CAB()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( !maps\mp\_utility::isreallyalive( var_0 ) )
            continue;

        if ( self.sentrytype == "sam_turret" )
            self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );

        var_0 _id_7F31( self, 0 );
    }
}

_id_995B( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( !isdefined( var_0._id_6638 ) )
        return;

    var_1 = 0;

    for (;;)
    {
        if ( isalive( self ) && self istouching( var_0._id_6638 ) && !isdefined( var_0._id_4F93 ) && !isdefined( var_0._id_1BAA ) && self isonground() )
        {
            if ( self usebuttonpressed() )
            {
                if ( isdefined( self.using_remote_turret ) && self.using_remote_turret )
                    continue;

                var_1 = 0;

                while ( self usebuttonpressed() )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                var_1 = 0;

                while ( !self usebuttonpressed() && var_1 < 0.5 )
                {
                    var_1 += 0.05;
                    wait 0.05;
                }

                if ( var_1 >= 0.5 )
                    continue;

                if ( !maps\mp\_utility::isreallyalive( self ) )
                    continue;

                if ( isdefined( self.using_remote_turret ) && self.using_remote_turret )
                    continue;

                var_0 _meth_8065( level._id_7CC5[var_0.sentrytype]._id_7CC3 );
                thread _id_7F31( var_0, 0 );
                var_0._id_6638 delete();
                return;
            }
        }

        wait 0.05;
    }
}

_id_995D()
{
    self notify( "turret_handluse" );
    self endon( "turret_handleuse" );
    self endon( "deleting" );
    level endon( "game_ended" );
    self._id_39B8 = 0;
    var_0 = ( 1.0, 0.9, 0.7 );
    var_1 = ( 1.0, 0.65, 0.0 );
    var_2 = ( 1.0, 0.25, 0.0 );

    for (;;)
    {
        self waittill( "trigger", var_3 );

        if ( isdefined( self._id_1BAA ) )
            continue;

        if ( isdefined( self._id_4F93 ) )
            continue;

        if ( !maps\mp\_utility::isreallyalive( var_3 ) )
            continue;

        var_3 _id_73CC();
        var_3 _id_73E9();
        self._id_4F93 = var_3;
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
        _id_7CBA( var_3 );
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
        var_3 thread _id_9989( self );
        var_3._id_9976 = var_3 maps\mp\gametypes\_hud_util::createbar( var_0, 100, 6 );
        var_3._id_9976 maps\mp\gametypes\_hud_util::setpoint( "CENTER", "BOTTOM", 0, -70 );
        var_3._id_9976.alpha = 0.65;
        var_3._id_9976.bar.alpha = 0.65;
        var_4 = 0;

        for (;;)
        {
            if ( !maps\mp\_utility::isreallyalive( var_3 ) )
            {
                self._id_4F93 = undefined;
                var_3._id_9976 maps\mp\gametypes\_hud_util::destroyelem();
                break;
            }

            if ( !var_3 isusingturret() )
            {
                self notify( "player_dismount" );
                self._id_4F93 = undefined;
                var_3._id_9976 maps\mp\gametypes\_hud_util::destroyelem();
                var_3 _id_74AA();
                var_3 _id_74B2();
                self sethintstring( level._id_7CC5[self.sentrytype]._id_01F2 );
                self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
                _id_7CBA( self.originalowner );
                self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
                break;
            }

            if ( self._id_4795 >= level._id_7CC5[self.sentrytype]._id_65F2 )
                var_5 = 1;
            else
                var_5 = self._id_4795 / level._id_7CC5[self.sentrytype]._id_65F2;

            var_3._id_9976 maps\mp\gametypes\_hud_util::updatebar( var_5 );

            if ( self._id_39B8 || self._id_65F1 )
            {
                self _meth_815C();
                var_3._id_9976.bar.color = var_2;
                var_4 = 0;
            }
            else
            {
                var_3._id_9976.bar.color = var_0;
                self _meth_8179();
                var_4 = 0;
                self notify( "not_overheated" );
            }

            wait 0.05;
        }

        self _meth_815A( 0.0 );
    }
}

_id_7CAA()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_handleOwner" );
    self endon( "sentry_handleOwner" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "death" );
}

_id_7CBA( var_0 )
{
    self.owner = var_0;
    self _meth_8103( self.owner );
    self _meth_8105( 1, self.sentrytype );

    if ( level.teambased )
    {
        self.team = self.owner.team;
        self _meth_8135( self.team );
    }

    thread _id_7CAA();
}

_id_7CBB()
{
    self setmodel( level._id_7CC5[self.sentrytype]._id_5D3A );

    if ( self _meth_8066() == "manual" )
        self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );

    self _meth_8104( undefined );
    self setcandamage( 1 );
    _id_7CB0();
    self._id_1BAA _meth_80DE();
    self._id_1BAA = undefined;

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    _id_7CB6();
    self playsound( "sentry_gun_plant" );
    self notify( "placed" );
}

_id_7CB7()
{
    self._id_1BAA _meth_80DE();

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    self delete();
}

_id_7CB8( var_0 )
{
    if ( isdefined( self.originalowner ) )
    {

    }
    else
    {

    }

    self setmodel( level._id_7CC5[self.sentrytype]._id_5D40 );
    self _meth_8104( var_0 );
    self setcandamage( 0 );
    _id_7CAF();
    self._id_1BAA = var_0;
    var_0.iscarrying = 1;
    var_0 thread _id_9B5F( self );
    thread _id_7CB2( var_0 );
    thread _id_7CB3( var_0 );
    thread _id_7CB1( var_0 );
    thread _id_7CB4();
    self _meth_815A( -89.0 );
    _id_7CB9();
    self notify( "carried" );
}

_id_9B5F( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0._id_1AAE = 1;
    var_1 = -1;

    for (;;)
    {
        var_2 = self _meth_82D2( 1, 22 );
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0._id_1AAE = self isonground() && var_2["result"] && abs( var_0.origin[2] - self.origin[2] ) < 30;

        if ( var_0._id_1AAE != var_1 )
        {
            if ( var_0._id_1AAE )
            {
                var_0 setmodel( level._id_7CC5[var_0.sentrytype]._id_5D40 );
                self _meth_80DD( &"SENTRY_PLACE" );
            }
            else
            {
                var_0 setmodel( level._id_7CC5[var_0.sentrytype]._id_5D41 );
                self _meth_80DD( &"SENTRY_CANNOT_PLACE" );
            }
        }

        var_1 = var_0._id_1AAE;
        wait 0.05;
    }
}

_id_7CB2( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "death" );

    if ( self._id_1AAE )
        _id_7CBB();
    else
        self delete();
}

_id_7CB3( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self delete();
}

_id_7CB1( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    self delete();
}

_id_7CB4( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    self delete();
}

_id_7CB6()
{
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC4 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( level._id_7CC5[self.sentrytype]._id_01F2 );

    if ( level._id_7CC5[self.sentrytype].headicon )
    {
        if ( level.teambased )
            maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 65.0 ) );
        else
            maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 65.0 ) );
    }

    self makeusable();

    foreach ( var_1 in level.players )
    {
        var_2 = self getentitynumber();
        _id_0855( var_2 );

        if ( var_1 == self.owner )
        {
            self enableplayeruse( var_1 );
            continue;
        }

        self disableplayeruse( var_1 );
    }

    if ( self._id_84AA )
    {
        level thread maps\mp\_utility::teamplayercardsplash( level._id_7CC5[self.sentrytype]._id_91FB, self.owner, self.owner.team );
        self._id_84AA = 0;
    }

    if ( self.sentrytype == "sam_turret" )
        thread _id_77D4();

    thread _id_7CC1();
}

_id_7CB9()
{
    self _meth_8065( level._id_7CC5[self.sentrytype]._id_7CC3 );
    self makeunusable();
    self freeentitysentient();
    var_0 = self getentitynumber();
    _id_73AF( var_0 );

    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( "none", ( 0.0, 0.0, 0.0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::setplayerheadicon( undefined, ( 0.0, 0.0, 0.0 ) );
}

_id_7CB0()
{
    self _meth_8136();
}

_id_7CAF()
{
    self setcontents( 0 );
}

_id_510D( var_0 )
{
    if ( level.teambased && self.team == var_0.team )
        return 1;

    return 0;
}

_id_0855( var_0 )
{
    level.turrets[var_0] = self;
}

_id_73AF( var_0 )
{
    level.turrets[var_0] = undefined;
}

_id_7CA2()
{
    self endon( "death" );
    level endon( "game_ended" );
    self._id_5D59 = 0;
    self._id_4795 = 0;
    self._id_65F1 = 0;
    thread _id_7CAC();

    for (;;)
    {
        common_scripts\utility::waittill_either( "turretstatechange", "cooled" );

        if ( self _meth_80E4() )
        {
            thread _id_7CA4();
            continue;
        }

        _id_7CBC();
        thread _id_7CA5();
    }
}

_id_7CC0()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = level._id_7CC5[self.sentrytype]._id_9364;

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( !isdefined( self._id_1BAA ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    if ( isdefined( self.owner ) )
    {
        if ( self.sentrytype == "sam_turret" )
            self.owner thread maps\mp\_utility::leaderdialogonplayer( "sam_gone" );
        else
            self.owner thread maps\mp\_utility::leaderdialogonplayer( "sentry_gone" );
    }

    self notify( "death" );
}

_id_7CBF()
{
    self endon( "death" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

_id_7CBD()
{
    thread _id_7CBF();

    while ( self._id_5D59 < level._id_7CC5[self.sentrytype]._id_8A5D )
    {
        self._id_5D59 += 0.1;
        wait 0.1;
    }
}

_id_7CBC()
{
    self._id_5D59 = 0;
}

_id_7CA4()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    _id_7CBD();
    var_0 = weaponfiretime( level._id_7CC5[self.sentrytype]._id_051C );
    var_1 = level._id_7CC5[self.sentrytype]._id_1933;
    var_2 = level._id_7CC5[self.sentrytype]._id_1932;
    var_3 = level._id_7CC5[self.sentrytype]._id_6721;
    var_4 = level._id_7CC5[self.sentrytype]._id_6720;

    for (;;)
    {
        var_5 = randomintrange( var_1, var_2 + 1 );

        for ( var_6 = 0; var_6 < var_5 && !self._id_65F1; var_6++ )
        {
            self _meth_80EA();
            self._id_4795 += var_0;
            wait(var_0);
        }

        wait(randomfloatrange( var_3, var_4 ));
    }
}

_id_7CA5()
{
    self notify( "stop_shooting" );
}

_id_9989( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "player_dismount" );
    var_1 = weaponfiretime( level._id_7CC5[var_0.sentrytype]._id_051C );

    for (;;)
    {
        var_0 waittill( "turret_fire" );
        var_0._id_4795 += var_1;
        var_0._id_21B5 = var_1;
    }
}

_id_7CAC()
{
    self endon( "death" );
    var_0 = weaponfiretime( level._id_7CC5[self.sentrytype]._id_051C );
    var_1 = 0;
    var_2 = 0;
    var_3 = level._id_7CC5[self.sentrytype]._id_65F2;
    var_4 = level._id_7CC5[self.sentrytype]._id_21B4;

    for (;;)
    {
        if ( self._id_4795 != var_1 )
            wait(var_0);
        else
            self._id_4795 = max( 0, self._id_4795 - 0.05 );

        if ( self._id_4795 > var_3 )
        {
            self._id_65F1 = 1;
            thread _id_6DA6();

            while ( self._id_4795 )
            {
                self._id_4795 = max( 0, self._id_4795 - var_4 );
                wait 0.1;
            }

            self._id_65F1 = 0;
            self notify( "not_overheated" );
        }

        var_1 = self._id_4795;
        wait 0.05;
    }
}

_id_995E()
{
    self endon( "death" );
    var_0 = level._id_7CC5[self.sentrytype]._id_65F2;

    for (;;)
    {
        if ( self._id_4795 > var_0 )
        {
            self._id_65F1 = 1;
            thread _id_6DA6();

            while ( self._id_4795 )
                wait 0.1;

            self._id_65F1 = 0;
            self notify( "not_overheated" );
        }

        wait 0.05;
    }
}

_id_9945()
{
    self endon( "death" );

    for (;;)
    {
        if ( self._id_4795 > 0 )
        {
            if ( self._id_21B5 <= 0 )
                self._id_4795 = max( 0, self._id_4795 - 0.05 );
            else
                self._id_21B5 = max( 0, self._id_21B5 - 0.05 );
        }

        wait 0.05;
    }
}

_id_6DA6()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait(level._id_7CC5[self.sentrytype]._id_3BBD);
    }
}

_id_6DD3()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }
}

_id_7CA3()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 3.0;

        if ( !isdefined( self._id_1BAA ) )
            self playsound( "sentry_gun_beep" );
    }
}

_id_77D4()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self._id_77E4 = undefined;
    self._id_77E3 = [];

    for (;;)
    {
        self._id_77E4 = _id_77D3();
        _id_77D5();
        wait 0.05;
    }
}

_id_77D3()
{
    var_0 = self gettagorigin( "tag_laser" );

    if ( !isdefined( self._id_77E4 ) )
    {
        if ( level.teambased )
        {
            var_1 = [];

            if ( level.multiteambased )
            {
                foreach ( var_3 in level.teamnamelist )
                {
                    if ( var_3 != self.team )
                    {
                        foreach ( var_5 in level.uavmodels[var_3] )
                            var_1[var_1.size] = var_5;
                    }
                }
            }
            else if ( isdefined( self.team ) )
                var_1 = level.uavmodels[level.otherteam[self.team]];

            foreach ( var_9 in var_1 )
            {
                if ( isdefined( var_9.isleaving ) && var_9.isleaving )
                    continue;

                if ( isdefined( var_9.orbit ) && var_9.orbit )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self ) )
                    return var_9;
            }

            foreach ( var_12 in level.littlebirds )
            {
                if ( isdefined( var_12.team ) && var_12.team == self.team )
                    continue;

                if ( sighttracepassed( var_0, var_12.origin, 0, self ) )
                    return var_12;
            }

            foreach ( var_15 in level.helis )
            {
                if ( isdefined( var_15.team ) && var_15.team == self.team )
                    continue;

                if ( isdefined( var_15._id_1FC7 ) && var_15._id_1FC7 < 1 )
                    continue;

                if ( sighttracepassed( var_0, var_15.origin, 0, self, var_15 ) )
                    return var_15;
            }

            if ( level.orbitalsupportinuse && isdefined( level.orbitalsupport_planemodel.owner ) && level.orbitalsupport_planemodel.owner.team != self.team )
            {
                if ( sighttracepassed( var_0, level.orbitalsupport_planemodel.origin, 0, self ) )
                    return level.orbitalsupport_planemodel;
            }

            if ( isdefined( level._id_0606 ) )
            {
                foreach ( var_18 in level._id_0606 )
                {
                    if ( isdefined( var_18._id_6E13 ) && var_18.owner.team != self.team )
                    {
                        if ( sighttracepassed( var_0, var_18._id_6E13.origin, 0, self ) )
                            return var_18._id_6E13;
                    }
                }
            }

            foreach ( var_21 in level.planes )
            {
                if ( isdefined( var_21.team ) && var_21.team == self.team )
                    continue;

                if ( sighttracepassed( var_0, var_21.origin, 0, self ) )
                    return var_21;
            }
        }
        else
        {
            foreach ( var_9 in level.uavmodels )
            {
                if ( isdefined( var_9.isleaving ) && var_9.isleaving )
                    continue;

                if ( isdefined( var_9.owner ) && isdefined( self.owner ) && var_9.owner == self.owner )
                    continue;

                if ( isdefined( var_9.orbit ) && var_9.orbit )
                    continue;

                if ( sighttracepassed( var_0, var_9.origin, 0, self ) )
                    return var_9;
            }

            foreach ( var_12 in level.littlebirds )
            {
                if ( isdefined( var_12.owner ) && isdefined( self.owner ) && var_12.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_12.origin, 0, self ) )
                    return var_12;
            }

            foreach ( var_15 in level.helis )
            {
                if ( isdefined( var_15.owner ) && isdefined( self.owner ) && var_15.owner == self.owner )
                    continue;

                if ( isdefined( var_15._id_1FC7 ) && var_15._id_1FC7 < 1 )
                    continue;

                if ( sighttracepassed( var_0, var_15.origin, 0, self, var_15 ) )
                    return var_15;
            }

            if ( level.orbitalsupportinuse && isdefined( level.orbitalsupport_planemodel.owner ) && isdefined( self.owner ) && level.orbitalsupport_planemodel.owner != self.owner )
            {
                if ( sighttracepassed( var_0, level.orbitalsupport_planemodel.owner.origin, 0, self ) )
                    return level.orbitalsupport_planemodel.owner;
            }

            if ( isdefined( level._id_0606 ) )
            {
                foreach ( var_18 in level._id_0606 )
                {
                    if ( isdefined( var_18._id_6E13 ) && var_18.owner != self )
                    {
                        if ( sighttracepassed( var_0, var_18._id_6E13.origin, 0, self ) )
                            return var_18._id_6E13;
                    }
                }
            }

            foreach ( var_21 in level.planes )
            {
                if ( isdefined( var_21.team ) && var_21.owner == self.owner )
                    continue;

                if ( sighttracepassed( var_0, var_21.origin, 0, self ) )
                    return var_21;
            }
        }

        self _meth_8108();
        return undefined;
    }
    else
    {
        if ( !sighttracepassed( var_0, self._id_77E4.origin, 0, self, self._id_77E4 ) )
        {
            self _meth_8108();
            return undefined;
        }

        return self._id_77E4;
    }
}

_id_77D5()
{
    if ( isdefined( self._id_77E4 ) )
    {
        if ( self._id_77E4 == level._id_06CE._id_6879 && !isdefined( level._id_06D1 ) || isdefined( level.orbitalsupport_planemodel ) && self._id_77E4 == level.orbitalsupport_planemodel && !isdefined( level._id_656C ) )
        {
            self._id_77E4 = undefined;
            self _meth_8108();
            return;
        }

        self _meth_8106( self._id_77E4 );
        self waittill( "turret_on_target" );

        if ( !isdefined( self._id_77E4 ) )
            return;

        if ( !self._id_54D7 )
        {
            thread _id_77D7();
            thread _id_77D6();
            thread _id_77D8();
            thread _id_77D9();
        }

        wait 2.0;

        if ( !isdefined( self._id_77E4 ) )
            return;

        if ( self._id_77E4 == level._id_06CE._id_6879 && !isdefined( level._id_06D1 ) )
        {
            self._id_77E4 = undefined;
            self _meth_8108();
            return;
        }

        var_0 = [];
        var_0[0] = self gettagorigin( "tag_le_missile1" );
        var_0[1] = self gettagorigin( "tag_le_missile2" );
        var_0[2] = self gettagorigin( "tag_ri_missile1" );
        var_0[3] = self gettagorigin( "tag_ri_missile2" );
        var_1 = self._id_77E3.size;

        for ( var_2 = 0; var_2 < 4; var_2++ )
        {
            if ( !isdefined( self._id_77E4 ) )
                return;

            if ( isdefined( self._id_1BAA ) )
                return;

            self _meth_80EA();
            var_3 = magicbullet( "sam_projectile_mp", var_0[var_2], self._id_77E4.origin, self.owner );
            var_3 missile_settargetent( self._id_77E4 );
            var_3 missile_setflightmodedirect();
            var_3.samturret = self;
            var_3._id_77E2 = var_1;
            self._id_77E3[var_1][var_2] = var_3;
            level notify( "sam_missile_fired", self.owner, var_3, self._id_77E4 );

            if ( var_2 == 3 )
                break;

            wait 0.25;
        }

        level notify( "sam_fired", self.owner, self._id_77E3[var_1], self._id_77E4 );
        wait 3.0;
    }
}

_id_77D9()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "fakedeath" );

    while ( isdefined( self._id_77E4 ) && isdefined( self _meth_8109( 1 ) ) && self _meth_8109( 1 ) == self._id_77E4 )
    {
        var_0 = self gettagorigin( "tag_laser" );

        if ( !sighttracepassed( var_0, self._id_77E4.origin, 0, self, self._id_77E4 ) )
        {
            self _meth_8108();
            self._id_77E4 = undefined;
            break;
        }

        wait 0.05;
    }
}

_id_77D7()
{
    self endon( "death" );
    self laseron();
    self._id_54D7 = 1;
    self notify( "laser_on" );

    while ( isdefined( self._id_77E4 ) && isdefined( self _meth_8109( 1 ) ) && self _meth_8109( 1 ) == self._id_77E4 )
        wait 0.05;

    self laseroff();
    self._id_54D7 = 0;
    self notify( "laser_off" );
}

_id_77D6()
{
    self endon( "death" );
    self endon( "fakedeath" );
    self._id_77E4 endon( "death" );

    if ( !isdefined( self._id_77E4.helitype ) )
        return;

    self._id_77E4 waittill( "crashing" );
    self _meth_8108();
    self._id_77E4 = undefined;
}

_id_77D8()
{
    self endon( "death" );
    self endon( "fakedeath" );
    self._id_77E4 endon( "death" );

    if ( !isdefined( self._id_77E4.model ) )
        return;

    if ( self._id_77E4.model == "vehicle_uav_static_mp" )
    {
        self._id_77E4 waittill( "leaving" );
        self _meth_8108();
        self._id_77E4 = undefined;
    }
}
