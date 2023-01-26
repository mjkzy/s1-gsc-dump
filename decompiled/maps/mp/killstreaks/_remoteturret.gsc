// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level._id_99BD ) )
        level._id_99BD = [];

    level._id_99BD["mg_turret"] = "remote_mg_turret";
    level.killstreakfuncs["remote_mg_turret"] = ::_id_98C0;
    level.killstreakfuncs["remote_mg_sentry_turret"] = ::_id_98BF;
    level.killstreakwieldweapons["remote_energy_turret_mp"] = "remote_mg_sentry_turret";
    level.killstreakwieldweapons["sentry_minigun_mp"] = "remote_mg_sentry_turret";
    level.killstreakwieldweapons["killstreakmahem_mp"] = "remote_mg_sentry_turret";

    if ( !isdefined( level._id_99B4 ) )
        level._id_99B4 = [];

    level._id_99B4["mg_turret"] = spawnstruct();
    level._id_99B4["mg_turret"]._id_7CC4 = "sentry";
    level._id_99B4["mg_turret"]._id_7CC3 = "sentry_offline";
    level._id_99B4["mg_turret"]._id_9364 = 60.0;
    level._id_99B4["mg_turret"].maxhealth = 1000;
    level._id_99B4["mg_turret"].streakname = "remote_mg_turret";
    level._id_99B4["mg_turret"]._id_91FB = "used_remote_mg_turret";
    level._id_99B4["mg_turret"]._id_4901 = &"MP_ENTER_REMOTE_TURRET";
    level._id_99B4["mg_turret"]._id_4908 = &"MP_HOLD_TO_CARRY";
    level._id_99B4["mg_turret"]._id_490C = &"MP_TURRET_RIP_OFF";
    level._id_99B4["mg_turret"]._id_48FE = &"MP_TURRET_DROP";
    level._id_99B4["mg_turret"]._id_6865 = &"MP_TURRET_PLACE";
    level._id_99B4["mg_turret"]._id_1AD4 = &"MP_TURRET_CANNOT_PLACE";
    level._id_99B4["mg_turret"]._id_54BB = "killstreak_remote_turret_mp";
    level._effect["sentry_explode_mp"] = loadfx( "vfx/explosion/remote_sentry_death" );
    level._effect["sentry_smoke_mp"] = loadfx( "vfx/smoke/vehicle_sentrygun_damaged_smoke" );
    level._effect["sentry_overheat_mp"] = loadfx( "vfx/distortion/sentrygun_overheat" );
    level._effect["antenna_light_mp"] = loadfx( "vfx/lights/light_detonator_blink" );
    level._effect["sentry_stunned_mp"] = loadfx( "vfx/sparks/emp_drone_damage" );
    level._effect["sentry_laser_flash"] = loadfx( "vfx/fire/remote_sentry_laser_flash" );
    level._effect["sentry_gone"] = loadfx( "vfx/explosion/remote_sentry_death_smoke" );
    level._effect["sentry_rocket_muzzleflash_wv"] = loadfx( "vfx/muzzleflash/rpg_flash_wv" );
    level._effect["sentry_rocket_muzzleflash_view"] = loadfx( "vfx/muzzleflash/rpg_flash_view" );
    game["dialog"]["ks_sentrygun_destroyed"] = "ks_sentrygun_destroyed";
}

_id_98BF( var_0, var_1 )
{
    var_2 = _id_98C1( var_0, "mg_turret", 1, var_1 );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level._id_99B4["mg_turret"].streakname, self.origin );

    self.iscarrying = 0;
    return var_2;
}

_id_98C0( var_0, var_1 )
{
    var_2 = _id_98C1( var_0, "mg_turret", 0, var_1 );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level._id_99B4["mg_turret"].streakname, self.origin );

    self.iscarrying = 0;
    return var_2;
}

_id_9126( var_0 )
{
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( level._id_99B4[var_0]._id_54BB );
}

_id_98C1( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.turret ) )
    {
        self iclientprintlnbold( &"KILLSTREAKS_SENTRY_IN_USE" );
        return 0;
    }

    var_4 = _id_244A( var_1, self, var_2, var_3 );

    if ( isdefined( level.ishorde ) && level.ishorde && self.killstreakindexweapon == 1 )
        self._id_4963 = var_4;

    _id_6C5A();
    _id_73CC();
    self._id_1BAE = var_4;
    _id_7F32( var_4, 1 );
    self._id_1BAE = undefined;
    thread _id_74AA();

    if ( isdefined( var_4 ) )
        return 1;
    else
        return 0;
}

_id_8316()
{
    if ( self._id_4799 )
        self _meth_8048( "TAG_OPTIC_STANDARD" );
    else
        self _meth_8048( "TAG_OPTIC_RESISTANCE" );
}

_id_8331()
{
    if ( !self._id_7555 )
        self _meth_8048( "TAG_HANDLES" );
}

_id_7FAC()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self._id_32CD )
        self setmodel( "npc_sentry_energy_turret_empty_base" );
    else if ( self._id_7593 )
        self setmodel( "npc_sentry_rocket_turret_empty_base" );
    else if ( self.disruptorturret )
        self setmodel( "npc_sentry_disruptor_turret_empty_base" );
    else
        self setmodel( "npc_sentry_minigun_turret_empty_base" );

    _id_8316();
    _id_8331();
}

_id_7FAB()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self._id_32CD )
        self setmodel( "npc_sentry_energy_turret_base" );
    else if ( self._id_7593 )
        self setmodel( "npc_sentry_rocket_turret_base" );
    else if ( self.disruptorturret )
        self setmodel( "npc_sentry_disruptor_turret_base" );
    else
        self setmodel( "npc_sentry_minigun_turret_base" );

    _id_8316();
    _id_8331();
}

_id_7FAE()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self._id_32CD )
        self setmodel( "npc_sentry_energy_turret_base_yellow_obj" );
    else if ( self._id_7593 )
        self setmodel( "npc_sentry_rocket_turret_base_yellow_obj" );
    else if ( self.disruptorturret )
        self setmodel( "npc_sentry_disruptor_turret_base_yellow_obj" );
    else
        self setmodel( "npc_sentry_minigun_turret_base_yellow_obj" );

    _id_8316();
    _id_8331();
}

_id_7FAD()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self._id_32CD )
        self setmodel( "npc_sentry_energy_turret_base_red_obj" );
    else if ( self._id_7593 )
        self setmodel( "npc_sentry_rocket_turret_base_red_obj" );
    else if ( self.disruptorturret )
        self setmodel( "npc_sentry_disruptor_turret_base_red_obj" );
    else
        self setmodel( "npc_sentry_minigun_turret_base_red_obj" );

    _id_8316();
    _id_8331();
}

_id_7F32( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !maps\mp\_utility::isreallyalive( self ) )
    {
        var_0 delete();
        return;
    }

    var_0 _id_9980( self );
    var_2 = maps\mp\_utility::getkillstreakweapon( "remote_mg_sentry_turret" );
    var_3 = self getcurrentprimaryweapon();

    if ( !maps\mp\gametypes\_weapons::isvalidlastweapon( var_3 ) || var_3 == "iw5_underwater_mp" )
        var_3 = common_scripts\utility::getlastweapon();

    if ( !var_1 )
    {
        maps\mp\_utility::_giveweapon( var_2, 0 );
        self switchtoweapon( var_2 );
        self.water_last_weapon = var_2;
        common_scripts\utility::_disableweaponswitch();
    }

    for (;;)
    {
        var_4 = common_scripts\utility::waittill_any_return( "place_turret", "cancel_turret", "force_cancel_placement" );

        if ( var_4 == "cancel_turret" || var_4 == "force_cancel_placement" )
        {
            if ( var_4 == "cancel_turret" && !var_1 )
                continue;

            var_0 _id_997F();

            if ( !var_1 )
            {
                if ( !isdefined( self.underwater ) )
                    playerswitchawayfromholdingturret( var_3, var_2 );
                else
                    self.water_last_weapon = var_3;

                common_scripts\utility::_enableweaponswitch();
            }

            return 0;
        }

        if ( isdefined( var_0 ) )
        {
            if ( !var_0._id_1AAE )
                continue;

            var_0 _id_9983();
        }

        if ( !var_1 )
        {
            if ( !isdefined( self.underwater ) )
                playerswitchawayfromholdingturret( var_3, var_2 );
            else
                self.water_last_weapon = var_3;

            common_scripts\utility::_enableweaponswitch();
        }

        return 1;
    }
}

playerswitchawayfromholdingturret( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    maps\mp\_utility::switch_to_last_weapon( var_0 );

    while ( self getcurrentprimaryweapon() != var_0 )
        waitframe();

    self.water_last_weapon = var_0;
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_1 );
}

_id_7FF9( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 setcandamage( 0 );
    var_0 setcontents( 0 );
    var_0 freeentitysentient();
    var_0._id_1BAA = self;
    self.iscarrying = 0;
    var_0 _id_9981();
    var_0 _id_7FAC();
    var_0 notify( "carried" );
    var_0 notify( "ripped" );
    var_0 _meth_8105( 0 );
    var_0 thread _id_2844( 20 );

    if ( isdefined( var_0._id_7321 ) )
        var_0._id_7321 maps\mp\_utility::makegloballyunusablebytype();

    if ( var_0._id_32CD )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadenergy_mp" );
    else if ( var_0._id_7593 )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadrocket_mp" );
    else if ( var_0.disruptorturret )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheaddisruptor_mp" );
    else
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadmg_mp" );

    var_0 playsound( "sentry_gun_detach" );
}

_id_2844( var_0 )
{
    self endon( "death" );
    level maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );

    if ( isdefined( self ) )
    {
        _id_2669();
        self delete();
    }
}

_id_2669()
{
    var_0 = self gettagorigin( "TAG_AIM_PIVOT" );
    playfx( common_scripts\utility::getfx( "sentry_gone" ), var_0 );
    playsoundatpos( var_0, "sentry_gun_self_destruct" );
}

_id_73CC()
{
    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        self._id_74A9 = "specialty_explosivebullets";
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
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

_id_9979( var_0 )
{
    self._id_709A = 1;
    self notify( "death" );
}

_id_9983()
{
    _id_7FAB();
    thread _id_7CA2();
    thread sentry_disruptor();
    self _meth_8104( undefined );
    self setcandamage( 1 );
    self._id_1BAA _meth_80DE();
    self._id_1BAA = undefined;

    if ( isdefined( self.owner ) )
    {
        self.owner.iscarrying = 0;
        common_scripts\utility::make_entity_sentient_mp( self.owner.team );
    }

    var_0 = spawnstruct();
    var_0._id_5791 = self._id_6860;
    var_0.endonstring = "carried";
    var_0.deathoverridecallback = ::_id_9979;
    thread maps\mp\_movers::handle_moving_platforms( var_0 );
    self playsound( "sentry_gun_deploy" );
    thread _id_997E();
    self notify( "placed" );
}

_id_997F()
{
    self._id_1BAA _meth_80DE();

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    self delete();
}

_id_9980( var_0 )
{
    _id_7FAE();
    self setcandamage( 0 );
    self _meth_8104( var_0 );
    self setcontents( 0 );
    self freeentitysentient();
    self unlink();
    self._id_1BAA = var_0;
    var_0.iscarrying = 1;
    var_0 thread _id_9B89( self );
    thread _id_9973( var_0 );
    thread _id_9974( var_0 );
    thread _id_9972( var_0 );
    thread _id_9975();
    self _meth_815A( -89.0 );
    _id_9981();
    self notify( "carried" );
}

_id_9B89( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0._id_1AAE = 1;
    var_0._id_6860 = undefined;
    var_1 = -1;

    for (;;)
    {
        var_2 = self _meth_82D2( 1 );
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0._id_1AAE = self isonground() && var_2["result"] && ( abs( var_0.origin[2] - self.origin[2] ) < 10 && !var_0 _id_51D5() );

        if ( isdefined( var_2["entity"] ) )
            var_0._id_6860 = var_2["entity"];
        else
            var_0._id_6860 = undefined;

        if ( var_0._id_1AAE != var_1 )
        {
            if ( var_0._id_1AAE )
            {
                var_0 _id_7FAE();
                self _meth_80DD( level._id_99B4[var_0._id_99BD]._id_6865 );
            }
            else
            {
                var_0 _id_7FAD();
                self _meth_80DD( level._id_99B4[var_0._id_99BD]._id_1AD4 );
            }
        }

        var_1 = var_0._id_1AAE;
        wait 0.05;
    }
}

_id_51D5()
{
    if ( !isdefined( level._id_A284 ) )
        return 0;
    else
    {
        foreach ( var_1 in level._id_A284 )
        {
            if ( self istouching( var_1 ) )
                return 1;
        }
    }

    return 0;
}

_id_9973( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 waittill( "death" );

    if ( self._id_1AAE )
        _id_9983();
    else
    {
        if ( isdefined( self.owner ) )
            self.owner.iscarrying = 0;

        self delete();
    }
}

_id_9974( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 waittill( "disconnect" );
    self delete();
}

_id_9972( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    self delete();
}

_id_9975( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    level waittill( "game_ended" );
    self delete();
}

_id_244A( var_0, var_1, var_2, var_3 )
{
    var_4 = "sentry_minigun_mp";

    if ( common_scripts\utility::array_contains( var_3, "sentry_energy_turret" ) )
        var_4 = "remote_energy_turret_mp";

    var_5 = spawnturret( "misc_turret", var_1.origin, var_4 );
    var_5.angles = var_1.angles;
    var_5.owner = var_1;
    var_5.health = level._id_99B4[var_0].maxhealth;
    var_5.maxhealth = level._id_99B4[var_0].maxhealth;
    var_5._id_99BD = var_0;
    var_5.stunned = 0;
    var_5._id_2A6A = 0;
    var_5.modules = var_3;
    var_5._id_4799 = common_scripts\utility::array_contains( var_5.modules, "sentry_heavy_resistance" );
    var_5._id_0C93 = common_scripts\utility::array_contains( var_5.modules, "sentry_anti_intrusion" );
    var_5._id_7593 = common_scripts\utility::array_contains( var_5.modules, "sentry_rocket_turret" );
    var_5._id_32CD = common_scripts\utility::array_contains( var_5.modules, "sentry_energy_turret" );
    var_5.disruptorturret = common_scripts\utility::array_contains( var_5.modules, "sentry_disruptor" );
    var_5._id_7555 = common_scripts\utility::array_contains( var_5.modules, "sentry_rippable" );
    var_5.issentry = common_scripts\utility::array_contains( var_5.modules, "sentry_guardian" );
    var_5._id_50A1 = common_scripts\utility::array_contains( var_5.modules, "sentry_360" );
    var_5._id_051C = var_4;
    var_5 _id_7FAB();

    if ( var_5._id_7593 )
    {
        var_5 _meth_815C();
        var_5._id_051C = "killstreakmahem_mp";
    }

    if ( var_5._id_7593 || var_5._id_32CD || var_5.disruptorturret )
        var_5 _meth_8424( 0 );

    var_5 _meth_817A( 1 );
    var_5 _id_9981();
    var_5 _meth_8103( var_1 );
    var_5 _meth_8105( 1, var_0 );

    if ( var_5.disruptorturret )
    {
        var_5 _meth_8156( 0 );
        var_5 _meth_8155( 0 );
    }
    else if ( var_5._id_50A1 )
    {
        var_5 _meth_8156( 180 );
        var_5 _meth_8155( 180 );
    }
    else
    {
        var_5 _meth_8156( 80 );
        var_5 _meth_8155( 80 );
    }

    var_5 _meth_8157( 50 );
    var_5 _meth_8158( 30 );
    var_5 _meth_815A( -89.0 );
    var_5 thread _id_995A();
    var_1.turret = var_5;
    var_5._id_259B = 1.0;
    var_5 thread _id_9965();
    var_5 thread _id_7CA2();
    return var_5;
}

_id_997E()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self makeunusable();
    self _meth_8136();

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    level.turrets[self getentitynumber()] = self;

    if ( isdefined( var_0._id_7327 ) )
    {
        foreach ( var_2 in var_0._id_7327 )
            var_2 notify( "death" );
    }

    var_0._id_7327 = [];
    var_0._id_7327[0] = self;

    if ( !self.disruptorturret )
    {
        if ( !isdefined( self._id_7321 ) )
        {
            self._id_7321 = spawn( "script_model", self.origin + ( 0.0, 0.0, 1.0 ) );
            self._id_7321 setmodel( "tag_origin" );
            self._id_7321.owner = var_0;
            self._id_7321 maps\mp\_utility::makegloballyusablebytype( "killstreakRemote", level._id_99B4[self._id_99BD]._id_4901, var_0 );
        }
        else
            self._id_7321 maps\mp\_utility::enablegloballyusablebytype();
    }

    var_0.using_remote_turret = 0;
    var_0._id_680E = undefined;
    var_0._id_32F5 = undefined;
    var_0 thread _id_A23C( self );

    if ( level.teambased )
    {
        self.team = var_0.team;
        self _meth_8135( var_0.team );
        maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 65.0 ), "tag_origin" );
    }
    else
        maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 65.0 ), "tag_origin" );

    self._id_6638 = spawn( "trigger_radius", self.origin + ( 0.0, 0.0, 1.0 ), 0, 32, 64 );
    self._id_6811 = spawn( "script_model", self.origin + ( 0.0, 0.0, 1.0 ) );
    self._id_6811 setmodel( "tag_origin" );
    self._id_6811.owner = var_0;
    var_0 thread _id_6B3B( self );
    var_0 thread _id_6B3A( self );

    if ( self._id_7555 )
        var_0 thread _id_6B3C( self );

    if ( !self.disruptorturret )
        thread _id_A20D();

    thread _id_9958();
    thread maps\mp\gametypes\_damage::setentitydamagecallback( self.maxhealth, undefined, ::_id_64F0, ::_id_996B, 1 );
    thread _id_9992();
    thread _id_9955();
    thread _id_999A();

    if ( !self._id_4799 )
        thread _id_9999();

    if ( self._id_0C93 )
        thread _id_9946();

    thread _id_995C();
    thread _id_9959();

    if ( isdefined( level.ishorde ) && level.ishorde )
        thread turret_hordeshootdronesandturrets();
}

handlemeleedamage( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::ismeleemod( var_1 ) )
    {
        var_3 = self.maxhealth + 1;

        if ( var_3 > var_2 )
            return var_3;
    }

    return var_2;
}

_id_996B( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = handlemeleedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4, var_0 );
    var_4 = maps\mp\gametypes\_damage::handlemissiledamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );

    if ( isdefined( self.owner ) && var_4 > 0 )
    {
        self.owner playrumbleonentity( "damage_heavy" );
        self.owner thread maps\mp\killstreaks\_aerial_utility::_id_6D53();
    }

    return var_4;
}

_id_64F0( var_0, var_1, var_2, var_3 )
{
    self notify( "death", var_0, var_2, var_1 );

    if ( isdefined( self.tagmarkedby ) && self.tagmarkedby != var_0 )
        self.tagmarkedby thread maps\mp\killstreaks\_marking_util::playerprocesstaggedassist( self );

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( !isplayer( var_0 ) )
            var_0 = var_0.owner;
    }

    maps\mp\gametypes\_damage::onkillstreakkilled( var_0, var_1, var_2, var_3, "sentry_gun_destroyed", undefined, undefined, 0 );
    self laseroff();
}

_id_6D55( var_0 )
{
    self endon( "disconnect" );
    self endon( "playerHideTurretOverlay" );
    wait 0.5;
    var_1 = 0;

    if ( var_0._id_051C == "sentry_minigun_mp" )
        var_1 = 1;
    else if ( var_0._id_051C == "remote_energy_turret_mp" )
        var_1 = 2;
    else if ( var_0._id_051C == "killstreakmahem_mp" )
        var_1 = 3;

    self setclientomnvar( "ui_sentry_ammo_type", var_1 );
    self setclientomnvar( "ui_sentry_toggle", 1 );
    maps\mp\killstreaks\_aerial_utility::_id_6C96();
}

_id_6CC3()
{
    self notify( "playerHideTurretOverlay" );
    self setclientomnvar( "ui_sentry_toggle", 0 );
    maps\mp\killstreaks\_aerial_utility::_id_6C89();
}

_id_6D86( var_0 )
{
    self endon( "weapon_change" );
    self waittill( "weapon_switch_started", var_1 );

    if ( var_0 != var_1 )
        return;

    while ( self isswitchingweapon() )
        waitframe();
}

_id_8D41( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_5 = self.owner;

    if ( !var_4 )
    {
        var_5 playerlinkto( self._id_7321 );
        var_5 playerlinkedoffsetenable();
        var_5 maps\mp\_utility::_giveweapon( level._id_99B4[self._id_99BD]._id_54BB );
        var_5 switchtoweapon( level._id_99B4[self._id_99BD]._id_54BB );
        var_5 disableoffhandweapons();
        var_5 _meth_84BF();
        var_5 _id_6D86( level._id_99B4[self._id_99BD]._id_54BB );
        var_6 = var_5 getcurrentweapon();

        if ( var_6 != level._id_99B4[self._id_99BD]._id_54BB )
        {
            var_5 _id_9126( self._id_99BD );
            var_5 enableoffhandweapons();
            var_5 _meth_84C0();
            var_5 unlink();
            return 0;
        }
    }

    self.remotecontrolled = 1;
    _id_7CBE();
    var_5 thread _id_6C91( self, var_4 );
    var_5 waittill( "initRideKillstreak_complete", var_7 );

    if ( !var_7 )
        return 0;

    var_5 maps\mp\_utility::playersaveangles();
    var_5 maps\mp\_utility::setusingremote( self._id_99BD );
    self notify( "remoteControlledUpdate" );
    self.killcamstarttime = gettime();
    var_5 thread _id_A051( 1.0, self );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_5 maps\mp\_utility::setthirdpersondof( 0 );

    var_5 _meth_807E( self, "tag_player", 0, var_0, var_1, var_2, var_3, 0 );
    var_5 _meth_80A0( 0 );
    var_5 _meth_80A1( 1 );
    var_5 _meth_80E8( self );

    if ( isdefined( self._id_7321 ) )
        self._id_7321 maps\mp\_utility::disablegloballyusablebytype();

    _id_9944();
    var_5 thread _id_6D55( self );

    if ( self._id_7593 )
        var_5 thread _id_6D17( self );

    if ( var_5 maps\mp\_utility::isjuggernaut() )
        var_5.juggernautoverlay.alpha = 0;

    thread maps\mp\_utility::playloopsoundtoplayers( "sentry_gun_remote_view_bg", ( 0.0, 0.0, 60.0 ), [ var_5 ] );
    return 1;
}

_id_A051( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "thermalVisionFOFOverlayOff" );
    var_1 endon( "death" );
    wait(var_0);
    self thermalvisionfofoverlayon();
}

setthermaloff()
{
    self notify( "thermalVisionFOFOverlayOff" );
    self thermalvisionfofoverlayoff();
}

_id_8F02( var_0 )
{
    if ( !isdefined( self.remotecontrolled ) || !self.remotecontrolled )
        return;

    self.remotecontrolled = undefined;
    self notify( "remoteControlledUpdate" );
    var_1 = self.owner;
    var_1 _id_9126( self._id_99BD );
    var_1 enableoffhandweapons();
    var_1 _meth_84C0();
    thread _id_7CA2();
    var_2 = maps\mp\_utility::getkillstreakweapon( level._id_99B4[self._id_99BD].streakname );
    var_1 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_2 );
    var_3 = var_1 common_scripts\utility::getlastweapon();

    if ( isdefined( var_1.underwater ) && var_1.underwater )
        var_3 = var_1 maps\mp\_utility::get_water_weapon();

    var_1 switchtoweapon( var_3 );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 unlink();

    if ( var_1 maps\mp\_utility::isusingremote() )
    {
        var_1 setthermaloff();
        var_1 _meth_80E9( self );

        if ( var_1 maps\mp\_utility::isusingremote() )
            var_1 maps\mp\_utility::clearusingremote();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_1 maps\mp\_utility::setthirdpersondof( 1 );
    }

    if ( _id_9967() )
        var_1 stopshellshock();

    if ( !_id_9967() && var_0 && ( !isdefined( var_1._id_9C1F ) || !var_1._id_9C1F ) )
        self._id_7321 maps\mp\_utility::enablegloballyusablebytype();

    if ( var_1 maps\mp\_utility::isjuggernaut() )
        var_1.juggernautoverlay.alpha = 1;

    var_1 _id_6CC3();
    self notify( "stop soundsentry_gun_remote_view_bg" );

    if ( isdefined( var_1.killcament ) )
        var_1.killcament delete();

    maps\mp\_utility::playerrestoreangles();
    self notify( "exit" );
}

_id_6C91( var_0, var_1 )
{
    var_2 = "remote_turret";

    if ( var_1 )
        var_2 = "coop";

    var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak( var_2 );

    if ( !isdefined( self ) )
        return;

    if ( var_3 != "success" || var_0 _id_9967() || isdefined( var_0._id_0108 ) )
    {
        if ( var_3 != "disconnect" || var_0 _id_9967() || isdefined( var_0._id_0108 ) )
        {
            thread maps\mp\_utility::playerremotekillstreakshowhud();
            var_0 _id_8F02( !var_1 );
        }

        self notify( "initRideKillstreak_complete", 0 );
        return;
    }

    self notify( "initRideKillstreak_complete", 1 );
}

_id_A23C( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "ripped" );
    self._id_9C1F = 0;

    for (;;)
    {
        if ( isalive( self ) )
            self waittill( "death" );

        if ( isdefined( var_0._id_7321 ) )
            var_0._id_7321 maps\mp\_utility::disablegloballyusablebytype();

        var_0 _id_9944();

        if ( self.using_remote_turret )
            self._id_9C1F = 1;
        else
            self._id_9C1F = 0;

        self waittill( "spawned_player" );
        self._id_9C1F = 0;

        if ( isdefined( var_0._id_7321 ) )
            var_0._id_7321 maps\mp\_utility::enablegloballyusablebytype();
    }
}

_id_A20D()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    var_0 = self.owner;
    thread _id_A20E();

    for (;;)
    {
        if ( var_0 _id_6C10( self ) )
        {
            if ( !isdefined( var_0._id_32F5 ) || !var_0._id_32F5 )
            {
                var_0._id_32F5 = 1;
                self._id_7321 maps\mp\_utility::disablegloballyusablebytype();
            }
        }
        else if ( isdefined( var_0._id_32F5 ) && var_0._id_32F5 )
        {
            self._id_7321 maps\mp\_utility::enablegloballyusablebytype();
            var_0._id_32F5 = 0;
        }

        waitframe();
    }
}

_id_6C10( var_0 )
{
    var_1 = self getcurrentweapon();
    return var_0 _id_9967() || _id_6B72( var_0 ) || isdefined( self.underwater ) && self.underwater || self.using_remote_turret || var_1 == "none" || self istouching( var_0._id_6638 ) || self islinked() && !self.using_remote_turret || isdefined( self.empgrenaded ) && self.empgrenaded;
}

_id_A20E()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_1 = 50;
    var_2 = 30;
    var_3 = 80;
    var_4 = 80;

    if ( self._id_50A1 )
    {
        var_3 = 180;
        var_4 = 180;
    }

    for (;;)
    {
        _id_A0E7();
        var_0.using_remote_turret = 1;
        var_5 = _id_8D41( var_3, var_4, var_1, var_2 );

        if ( var_5 )
        {
            wait 2.0;
            _id_A0E6();
            var_0.using_remote_turret = 0;
            _id_8F02();
            wait 2.0;
            continue;
        }

        var_0.using_remote_turret = 0;
    }
}

_id_A0E7()
{
    var_0 = self.owner;

    for (;;)
    {
        self._id_7321 waittill( "trigger" );

        if ( var_0 _id_6C69( self ) )
            return;
    }
}

_id_A0E6()
{
    var_0 = self.owner;

    for (;;)
    {
        var_1 = 0;

        while ( var_0 usebuttonpressed() )
        {
            var_1 += 0.05;

            if ( var_1 > 0.2 && var_0 _id_6C69( self ) )
                return;

            waitframe();
        }

        waitframe();
    }
}

_id_6C69( var_0 )
{
    if ( self fragbuttonpressed() || isdefined( self.throwinggrenade ) || self secondaryoffhandbuttonpressed() )
        return 0;

    if ( self isusingturret() || !self isonground() )
        return 0;

    if ( isdefined( var_0._id_6638 ) && self istouching( var_0._id_6638 ) )
        return 0;

    if ( isdefined( self.empgrenaded ) && self.empgrenaded )
        return 0;

    if ( isdefined( self.iscarrying ) && self.iscarrying )
        return 0;

    if ( isdefined( self.iscapturingcrate ) && self.iscapturingcrate )
        return 0;

    if ( !isalive( self ) )
        return 0;

    if ( !self.using_remote_turret && maps\mp\_utility::isusingremote() )
        return 0;

    if ( self islinked() && !self.using_remote_turret )
        return 0;

    return 1;
}

_id_6B72( var_0 )
{
    var_1 = self getcurrentweapon();
    return maps\mp\_utility::isjuggernaut() || maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition() || maps\mp\_utility::iskillstreakweapon( var_1 ) && var_1 != "killstreak_remote_turret_mp" && var_1 != "sentry_minigun_mp" && var_1 != "remote_energy_turret_mp" && var_1 != level._id_99B4[var_0._id_99BD]._id_54BB && var_1 != "none" && var_1 != "turretheadmg_mp" && var_1 != "turretheadenergy_mp" && var_1 != "turretheadrocket_mp";
}

_id_6B3A( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0._id_6638 ) || !isdefined( var_0._id_6811 ) )
        return;

    var_0._id_6811 endon( "death" );

    for (;;)
    {
        if ( _id_6C0F( var_0 ) )
        {
            if ( !isdefined( self._id_680E ) || !self._id_680E )
            {
                self._id_680E = 1;
                var_0 _id_9944();
            }
        }
        else if ( isdefined( self._id_680E ) && self._id_680E )
        {
            var_0 thread _id_9982();
            self._id_680E = 0;
        }

        waitframe();
    }
}

_id_6C0F( var_0 )
{
    var_1 = self getcurrentweapon();
    return var_0 _id_9967() || _id_6B72( var_0 ) || isdefined( self.underwater ) && self.underwater || self.using_remote_turret || var_1 == "none" || !self istouching( var_0._id_6638 ) || !maps\mp\_utility::isreallyalive( self ) || !self isonground() || isdefined( var_0._id_1BAA );
}

_id_6B3B( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0._id_6638 ) || !isdefined( var_0._id_6811 ) )
        return;

    var_0._id_6811 endon( "death" );
    var_1 = 0;

    for (;;)
    {
        if ( _id_6B72( var_0 ) )
        {
            waitframe();
            continue;
        }

        if ( !self istouching( var_0._id_6638 ) )
        {
            waitframe();
            continue;
        }

        if ( maps\mp\_utility::isreallyalive( self ) && self istouching( var_0._id_6638 ) && !isdefined( var_0._id_1BAA ) && self isonground() )
        {
            var_2 = 0;

            while ( self usebuttonpressed() )
            {
                if ( !maps\mp\_utility::isreallyalive( self ) )
                    break;

                if ( !self istouching( var_0._id_6638 ) )
                    break;

                if ( self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || isdefined( self.throwinggrenade ) )
                    break;

                if ( self islinked() || !self isonground() || self isusingturret() || maps\mp\_utility::isusingremote() )
                    break;

                if ( isdefined( self.iscarrying ) && self.iscarrying )
                    break;

                if ( isdefined( self.iscapturingcrate ) && self.iscapturingcrate )
                    break;

                if ( isdefined( self.empgrenaded ) && self.empgrenaded )
                    break;

                if ( isdefined( self.using_remote_turret ) && self.using_remote_turret )
                    break;

                if ( isdefined( self.ball_carried ) )
                    break;

                var_2 += 0.05;

                if ( var_2 > 0.75 )
                {
                    var_0 playsound( "sentry_gun_pick_up" );
                    var_0 _meth_8065( level._id_99B4[var_0._id_99BD]._id_7CC3 );
                    var_0 _id_7CBE();
                    thread _id_7F32( var_0, 0 );
                    var_0 _id_9944();
                    self._id_7327 = undefined;
                    var_0._id_6811 delete();
                    var_0._id_6638 delete();
                    return;
                }

                waitframe();
            }
        }

        waitframe();
    }
}

_id_6B3C( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0._id_6638 ) || !isdefined( var_0._id_6811 ) )
        return;

    var_0._id_6811 endon( "death" );
    var_1 = 0;

    for (;;)
    {
        if ( _id_6B72( var_0 ) )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\killstreaks\_rippedturret::_id_6CBE() )
        {
            waitframe();
            continue;
        }

        if ( !self istouching( var_0._id_6638 ) )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\_utility::isreallyalive( self ) && self istouching( var_0._id_6638 ) && !isdefined( var_0._id_1BAA ) && self isonground() )
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

                if ( isdefined( self.ball_carried ) )
                    continue;

                var_0 _meth_8065( level._id_99B4[var_0._id_99BD]._id_7CC3 );
                var_0 _id_7CBE();
                thread _id_7FF9( var_0 );
                var_0 _id_9944();
                self._id_7327 = undefined;
                var_0._id_6811 delete();
                var_0._id_6638 delete();
                return;
            }
        }

        wait 0.05;
    }
}

_id_993F()
{
    self endon( "death" );
    self endon( "carried" );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "antenna_light_mp" ), self, "tag_fx" );
        wait 1.0;
        stopfxontag( common_scripts\utility::getfx( "antenna_light_mp" ), self, "tag_fx" );
    }
}

_id_9981()
{
    self _meth_8065( level._id_99B4[self._id_99BD]._id_7CC3 );
    _id_7CBE();

    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( "none", ( 0.0, 0.0, 0.0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::setplayerheadicon( undefined, ( 0.0, 0.0, 0.0 ) );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    level.turrets[self getentitynumber()] = undefined;

    if ( isdefined( self._id_7321 ) )
        self._id_7321 maps\mp\_utility::disablegloballyusablebytype();

    if ( isdefined( var_0.using_remote_turret ) && var_0.using_remote_turret )
    {
        var_0 thermalvisionoff();
        var_0 setthermaloff();
        var_0 _meth_80E9( self );
        var_0 unlink();
        var_1 = var_0 common_scripts\utility::getlastweapon();

        if ( isdefined( var_0.underwater ) && var_0.underwater )
            var_1 = var_0 maps\mp\_utility::get_water_weapon();

        var_0 switchtoweapon( var_1 );

        if ( var_0 maps\mp\_utility::isusingremote() )
            var_0 maps\mp\_utility::clearusingremote();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_0 maps\mp\_utility::setthirdpersondof( 1 );

        if ( isdefined( var_0.disabledusability ) && var_0.disabledusability )
        {
            if ( isdefined( level.ishorde ) && level.ishorde && isdefined( var_0.laststand ) && var_0.laststand )
            {
                if ( var_0.disabledusability > 1 )
                    var_0.disabledusability--;
            }
            else
                var_0 common_scripts\utility::_enableusability();
        }

        var_0 _id_9126( self._id_99BD );

        if ( var_0 maps\mp\_utility::isjuggernaut() )
            var_0.juggernautoverlay.alpha = 1;
    }
}

_id_995A()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "turret_handleOwner" );
    self endon( "turret_handleOwner" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "death" );
}

_id_9955()
{
    self endon( "death" );
    level waittill( "game_ended" );

    if ( isdefined( self.owner ) )
        self.owner _id_6CC3();
}

_id_9992()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self._id_9368 ) )
        return;

    self._id_9368 = 1;
    var_0 = level._id_99B4[self._id_99BD]._id_9364;

    if ( self.disruptorturret )
        var_0 += 30;

    self.owner setclientomnvar( "ui_sentry_lifespan", var_0 );

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( !isdefined( self._id_1BAA ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    if ( isdefined( self.owner ) )
        self.owner _id_6CC3();

    self notify( "death" );
}

_id_9958()
{
    self endon( "carried" );
    var_0 = self getentitynumber();
    maps\mp\killstreaks\_autosentry::_id_0855( var_0 );
    self waittill( "death", var_1, var_2, var_3 );
    self _meth_8108();
    _id_994B( var_1, var_3 );
    self.damagecallback = undefined;
    self setcandamage( 0 );
    self setdamagecallbackon( 0 );
    self freeentitysentient();
    self laseroff();
    self._id_0108 = 1;
    maps\mp\killstreaks\_autosentry::_id_73AF( var_0 );

    if ( !isdefined( self ) )
        return;

    _id_9944();
    _id_9981();
    self _meth_815A( 35 );
    self _meth_8103( undefined );
    self _meth_8105( 0 );

    if ( isdefined( self._id_7321 ) )
        self._id_7321 maps\mp\_utility::makegloballyunusablebytype();

    var_4 = self.owner;

    if ( isdefined( var_4 ) )
    {
        _id_8F02();
        var_4.using_remote_turret = 0;
        var_4.turret = undefined;
        var_4 _id_74AA();
        var_4 _id_6D2D();

        if ( var_4 getcurrentweapon() == "none" )
        {
            var_5 = var_4 common_scripts\utility::getlastweapon();

            if ( isdefined( var_4.underwater ) && var_4.underwater )
                var_5 = var_4 maps\mp\_utility::get_water_weapon();

            var_4 switchtoweapon( var_5 );
        }
    }

    self playsound( "sentry_gun_death_exp" );

    if ( !isdefined( self._id_709A ) || !self._id_709A )
    {
        playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), self, "TAG_AIM_PIVOT" );
        wait 1.5;

        for ( var_6 = 8; var_6 > 0; var_6 -= 0.4 )
        {
            playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
            wait 0.4;
        }
    }

    self notify( "deleting" );

    if ( isdefined( self._id_9199 ) )
        self._id_9199 delete();

    if ( isdefined( self._id_6638 ) )
        self._id_6638 delete();

    if ( isdefined( self._id_6811 ) )
        self._id_6811 delete();

    if ( isdefined( self._id_7321 ) )
        self._id_7321 delete();

    if ( isdefined( self.rocketmuzzleflashent ) )
        self.rocketmuzzleflashent delete();

    _id_2669();
    self delete();
}

_id_994B( var_0, var_1 )
{
    if ( isdefined( self.owner ) && isdefined( var_0 ) && self.owner != var_0 )
        self.owner thread maps\mp\_utility::leaderdialogonplayer( "ks_sentrygun_destroyed", undefined, undefined, self.origin );
}

_id_9965()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( self._id_259B < 1.0 )
        {
            self._id_259B += 0.1;
            var_0 = 1;
        }
        else if ( var_0 )
        {
            self._id_259B = 1.0;
            var_0 = 0;
        }

        wait 0.1;
    }
}

_id_9982()
{
    self notify( "turretClearPickupHints" );
    self endon( "turretClearPickupHints" );
    self._id_6811 makeusable();
    self._id_6811 sethintstring( level._id_99B4[self._id_99BD]._id_4908 );
    self._id_6811 setcursorhint( "HINT_NOICON" );
    self._id_6811 _meth_849B( 1 );

    if ( self._id_7555 )
    {
        for (;;)
        {
            var_0 = 0;

            if ( !var_0 && isdefined( self.owner ) && !self.owner maps\mp\killstreaks\_rippedturret::_id_6CBE() )
            {
                self._id_6811 _meth_80DC( level._id_99B4[self._id_99BD]._id_490C );
                var_0 = 1;
            }
            else if ( var_0 )
            {
                self._id_6811 _meth_80DC( "" );
                var_0 = 0;
            }

            waitframe();
        }
    }
}

_id_9944()
{
    self notify( "turretClearPickupHints" );

    if ( !isdefined( self._id_6811 ) )
        return;

    self._id_6811 makeunusable();
    self._id_6811 sethintstring( "" );
    self._id_6811 _meth_80DC( "" );
    self._id_6811 _meth_849B( 0 );
}

_id_7CBE()
{
    self notify( "sentry_stop" );
}

_id_7CA2( var_0 )
{
    if ( !self.issentry )
        return;

    self endon( "sentry_stop" );
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_start" );
    self._id_5D59 = 0;
    self._id_4795 = 0;
    self._id_65F1 = 0;

    if ( !self._id_7593 )
        thread _id_7CAC( "sentry_minigun_mp", 4.0, 0.1 );

    self _meth_8065( level._id_99B4["mg_turret"]._id_7CC4 );
    self._id_37E2 = gettime();

    for (;;)
    {
        common_scripts\utility::waittill_either( "turretstatechange", "cooled" );

        if ( self _meth_80E4() )
        {
            thread _id_998A( var_0 );
            continue;
        }

        thread _id_998C();
    }
}

_id_998A( var_0 )
{
    if ( self._id_7593 )
        thread _id_9953();
    else
        thread _id_7CA4( var_0 );
}

_id_998C()
{
    if ( self._id_7593 )
        thread _id_998B();
    else
    {
        _id_7CBC();
        thread _id_7CA5();
    }
}

_id_6D17( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "sentry_start" );
    var_0 endon( "exit" );
    var_0._id_37E2 = gettime();

    for (;;)
    {
        self waittill( "turret_fire" );
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( gettime() >= var_0._id_37E2 )
            var_0 thread _id_9952( 0 );
    }
}

_id_7CBF()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

_id_7CBD()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    thread _id_7CBF();

    while ( self._id_5D59 < 0.05 )
    {
        self._id_5D59 += 0.1;
        wait 0.1;
    }
}

_id_7CBC()
{
    self._id_5D59 = 0;
}

_id_7CA4( var_0 )
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    _id_7CBD();
    var_1 = weaponfiretime( "sentry_minigun_mp" );
    var_2 = 20;
    var_3 = 120;
    var_4 = 0.15;
    var_5 = 0.35;

    for (;;)
    {
        var_6 = randomintrange( var_2, var_3 + 1 );

        for ( var_7 = 0; var_7 < var_6 && !self._id_65F1; var_7++ )
        {
            if ( isdefined( var_0 ) )
                self [[ var_0 ]]();
            else
                self _meth_80EA();

            self._id_4795 += var_1;
            wait(var_1);
        }

        wait(randomfloatrange( var_4, var_5 ));
    }
}

_id_998B()
{
    self notify( "stop_shooting" );
}

_id_9953()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    self._id_37E2 = gettime();

    for (;;)
    {
        if ( gettime() >= self._id_37E2 )
            thread _id_9952( 1 );

        waitframe();
    }
}

_id_9952( var_0 )
{
    level endon( "game_ended" );
    var_1 = self gettagorigin( "tag_flash" );
    var_2 = anglestoforward( self gettagangles( "tag_flash" ) );
    var_3 = var_1 + var_2 * 10000;
    var_1 += var_2 * 10;
    var_4 = bullettrace( var_1, var_3, 1 );
    var_5 = var_4["entity"];
    var_6 = 0;

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_6 = isdefined( var_5 ) && isdefined( var_5.team ) && self.team != var_5.team;
    else
        var_6 = isdefined( var_5 ) && isplayer( var_5 ) && !_func_285( self.owner, var_5 );

    if ( !var_6 && var_0 )
        return;

    self playrumbleonentity( "damage_heavy" );
    var_7 = magicbullet( "killstreakmahem_mp", var_1, var_3, self.owner );

    if ( var_0 )
        var_8 = 2500;
    else
        var_8 = 1250;

    self._id_37E2 = gettime() + var_8;

    if ( !var_0 )
    {
        playfxontagforclients( common_scripts\utility::getfx( "sentry_rocket_muzzleflash_view" ), self, "tag_flash", self.owner );

        if ( !isdefined( self.rocketmuzzleflashent ) )
            self.rocketmuzzleflashent = spawnmuzzleflashent( self, "tag_flash", self.owner );

        playfxontag( common_scripts\utility::getfx( "sentry_rocket_muzzleflash_wv" ), self.rocketmuzzleflashent, "tag_origin" );
    }
    else
        playfxontag( common_scripts\utility::getfx( "sentry_rocket_muzzleflash_wv" ), self, "tag_flash" );
}

spawnmuzzleflashent( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_3 setmodel( "tag_origin" );
    var_3 linkto( var_0, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3 hide();

    foreach ( var_5 in level.players )
    {
        if ( var_5 != var_2 )
            var_3 showtoplayer( var_5 );
    }

    thread onplayerconnectmuzzleflashent( var_3 );
    return var_3;
}

onplayerconnectmuzzleflashent( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        thread onplayerspawnedmuzzleflashent( var_0, var_1 );
    }
}

onplayerspawnedmuzzleflashent( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 waittill( "spawned_player" );
    var_0 showtoplayer( var_1 );
}

_id_7CA5()
{
    self notify( "stop_shooting" );
}

_id_7CAC( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "sentry_stop" );
    var_3 = weaponfiretime( var_0 );
    var_4 = 0;
    var_5 = 0;

    for (;;)
    {
        if ( self._id_4795 != var_4 )
            wait(var_3);
        else
            self._id_4795 = max( 0, self._id_4795 - 0.05 );

        if ( self._id_4795 > var_1 )
        {
            self._id_65F1 = 1;
            self _meth_8424( 0 );
            thread _id_6DA6();

            switch ( self._id_99BD )
            {
                case "mg_turret":
                    playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self._id_4795 )
            {
                self._id_4795 = max( 0, self._id_4795 - var_2 );
                wait 0.1;
            }

            self _meth_8424( 1 );
            self._id_65F1 = 0;
            self notify( "not_overheated" );
        }

        var_4 = self._id_4795;
        wait 0.05;
    }
}

_id_6DA6()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );

    for (;;)
    {
        playfxontag( common_scripts\utility::getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait 0.3;
    }
}

_id_999A()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "emp_damage" );
    self notify( "death" );
}

_id_9999()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "concussed" );
        var_0 = 4;
        playfxontag( common_scripts\utility::getfx( "sentry_stunned_mp" ), self, "tag_aim" );
        self notify( "stunned" );
        self.stunned = 1;

        if ( self.issentry )
        {
            self _meth_815A( 35 );
            self _meth_8065( level._id_99B4[self._id_99BD]._id_7CC3 );
        }

        if ( isdefined( self.remotecontrolled ) && self.remotecontrolled )
            _id_8F02();

        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
        stopfxontag( common_scripts\utility::getfx( "sentry_stunned_mp" ), self, "tag_aim" );

        if ( self.issentry )
        {
            self _meth_815A( 0 );
            self _meth_8065( level._id_99B4[self._id_99BD]._id_7CC4 );
        }

        self.stunned = 0;
        self notify( "stunnedDone" );
    }
}

_id_9967()
{
    return isdefined( self.stunned ) && self.stunned;
}

_id_9946()
{
    var_0 = spawn( "script_model", self.origin + ( 0.0, 0.0, 60.0 ) );
    self.killcament = var_0;
    common_scripts\utility::waittill_any( "death", "carried" );
    wait 3;
    var_0 delete();
}

_id_9959()
{
    self endon( "death" );

    if ( !self.issentry )
        return;

    self laseron( "mp_sentry_turret" );
    self waittill( "carried" );
    self laseroff();
}

_id_995C()
{
    self endon( "carried" );
    self endon( "death" );

    if ( self.issentry || self.disruptorturret )
    {
        self _meth_815A( 0 );
        return;
    }
    else
        self _meth_815A( 35 );

    for (;;)
    {
        self waittill( "remoteControlledUpdate" );

        if ( isdefined( self.remotecontrolled ) && self.remotecontrolled )
        {
            self _meth_815A( 0 );
            continue;
        }

        self _meth_815A( 35 );
    }
}

turret_hordeshootdronesandturrets()
{
    self endon( "death" );
    var_0 = ( 0.0, 0.0, 40.0 );

    for (;;)
    {
        var_1 = 5000000;
        var_2 = undefined;

        foreach ( var_4 in level.flying_attack_drones )
        {
            var_5 = distancesquared( self.origin, var_4.origin );

            if ( var_5 < var_1 )
            {
                if ( sighttracepassed( self.origin + var_0, var_4.origin, 0, undefined ) )
                {
                    var_1 = var_5;
                    var_2 = var_4;
                }
            }
        }

        var_7 = undefined;

        foreach ( var_9 in level._id_49C1 )
        {
            var_5 = distancesquared( self.origin, var_9.origin );

            if ( var_5 < var_1 )
            {
                if ( sighttracepassed( self.origin + var_0, var_9.origin + var_0, 0, undefined ) )
                {
                    var_1 = var_5;
                    var_7 = var_9;
                }
            }
        }

        if ( isdefined( var_7 ) )
            self _meth_8106( var_7, var_0 );
        else if ( isdefined( var_2 ) )
            self _meth_8106( var_2 );

        waitframe();
    }
}

_id_6C5A()
{
    self notifyonplayercommand( "turret_fire", "+attack" );
    self notifyonplayercommand( "turret_fire", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "place_turret", "+attack" );
    self notifyonplayercommand( "place_turret", "+attack_akimbo_accessible" );

    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "cancel_turret", "weapnext" );
        self notifyonplayercommand( "cancel_turret", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommand( "cancel_turret", "+actionslot 5" );
            self notifyonplayercommand( "cancel_turret", "+actionslot 6" );
            self notifyonplayercommand( "cancel_turret", "+actionslot 7" );
            self notifyonplayercommand( "cancel_turret", "+actionslot 8" );
        }
    }
}

_id_6D2D()
{
    self notifyonplayercommandremove( "turret_fire", "+attack" );
    self notifyonplayercommandremove( "turret_fire", "+attack_akimbo_accessible" );
    self notifyonplayercommandremove( "place_turret", "+attack" );
    self notifyonplayercommandremove( "place_turret", "+attack_akimbo_accessible" );

    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "cancel_turret", "+actionslot 4" );

        if ( !level.console )
        {
            self notifyonplayercommandremove( "cancel_turret", "weapnext" );
            self notifyonplayercommandremove( "cancel_turret", "+actionslot 5" );
            self notifyonplayercommandremove( "cancel_turret", "+actionslot 6" );
            self notifyonplayercommandremove( "cancel_turret", "+actionslot 7" );
            self notifyonplayercommandremove( "cancel_turret", "+actionslot 8" );
        }
    }
}

sentry_disruptor()
{
    level endon( "game_ended" );
    self endon( "carried" );
    self endon( "death" );

    if ( !isdefined( self.owner ) || !self.disruptorturret )
        return;

    if ( isdefined( level.turretdisruptorcustomthink ) )
    {
        self thread [[ level.turretdisruptorcustomthink ]]();
        return;
    }

    if ( !isdefined( level.turretdisruptorradiussq ) )
    {
        level.turretdisruptorradiussq = 90000;
        level.turretdisruptordetectdot = 0.5;
    }

    wait 0.5;
    thread turretdisruptorvisualsaudio();
    self.radiationlist = [];

    for (;;)
    {
        var_0 = self gettagorigin( "tag_flash" );
        var_1 = anglestoforward( self gettagangles( "tag_flash" ) );

        foreach ( var_3 in level.players )
        {
            if ( self.stunned )
                continue;

            if ( var_3 == self.owner || level.teambased && var_3.team == self.team )
                continue;

            if ( !turretdisruptorcanhurtplayer( var_3, var_0, var_1 ) )
                continue;

            if ( common_scripts\utility::array_contains( self.radiationlist, var_3 ) )
                continue;

            self.radiationlist = common_scripts\utility::array_add( self.radiationlist, var_3 );
            thread turretdisruptorhurtplayer( var_3 );
        }

        waitframe();
    }
}

turretdisruptorcanhurtplayer( var_0, var_1, var_2 )
{
    if ( !isalive( var_0 ) )
        return 0;

    var_3 = var_0.origin + ( 0.0, 0.0, 30.0 );
    var_4 = distancesquared( var_3, var_1 );

    if ( var_4 > level.turretdisruptorradiussq )
        return 0;

    var_5 = vectornormalize( var_0.origin - self.origin );
    var_6 = vectordot( var_2, var_5 );

    if ( var_6 < level.turretdisruptordetectdot )
        return 0;

    var_7 = var_0 damageconetrace( var_1, self );
    return var_7 > 0;
}

turretdisruptorhurtplayer( var_0 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    var_1 = 0.8;
    var_2 = 16;
    var_3 = gettime();
    var_4 = gettime();
    var_5 = 2;
    var_6 = 1;

    while ( var_6 )
    {
        var_7 = self gettagorigin( "tag_flash" );
        var_8 = anglestoforward( self gettagangles( "tag_flash" ) );

        if ( self.stunned )
        {
            while ( self.stunned )
                waitframe();

            var_6 = turretdisruptorcanhurtplayer( var_0, var_7, var_8 );
            continue;
        }

        if ( gettime() >= var_4 )
        {
            var_0 shellshock( "mp_radiation_med", var_5 );
            var_4 = gettime() + var_5 * 1000;
        }

        if ( gettime() >= var_3 )
        {
            var_0 dodamage( var_2, var_7, self.owner, self, "MOD_TRIGGER_HURT", "iw5_dlcgun12loot3_mp", "torso_upper" );
            var_3 = gettime() + var_1 * 1000;

            if ( isalive( var_0 ) && !var_0 maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
                var_0 thread maps\mp\_empgrenade::_id_0CAB();
        }

        var_9 = var_0 common_scripts\utility::waittill_notify_or_timeout_return( "death", 0.05 );

        if ( !isdefined( var_9 ) || var_9 != "timeout" )
        {
            var_0 stopshellshock();
            break;
        }

        var_6 = turretdisruptorcanhurtplayer( var_0, var_7, var_8 );
    }

    if ( isdefined( var_0 ) && !isalive( var_0 ) )
        var_0 stopshellshock();

    self.radiationlist = common_scripts\utility::array_remove( self.radiationlist, var_0 );
}

turretdisruptorvisualsaudio()
{
    var_0 = self gettagangles( "tag_flash" ) + ( 90.0, 0.0, 0.0 );
    var_1 = spawn( "script_model", self gettagorigin( "tag_flash" ) );
    var_1.angles = ( var_0[0], var_0[1], 0 );
    var_1 setmodel( "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "turret_distortion" ), var_1, "tag_origin" );
    var_1 _meth_8438( "wpn_disruptor_snap_npc" );
    var_1 playloopsound( "wpn_disruptor_beam_hi_npc" );
    common_scripts\utility::waittill_any( "death", "carried" );
    killfxontag( common_scripts\utility::getfx( "turret_distortion" ), var_1, "tag_origin" );
    var_1 _meth_8438( "wpn_disruptor_off_blast_npc" );
    var_1 stoploopsound( "wpn_disruptor_beam_hi_npc" );
    wait 0.1;
    var_1 delete();
}
