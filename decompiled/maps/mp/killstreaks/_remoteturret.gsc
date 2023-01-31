// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.turrettype ) )
        level.turrettype = [];

    level.turrettype["mg_turret"] = "remote_mg_turret";
    level.killstreakfuncs["remote_mg_turret"] = ::tryuseremotemgturret;
    level.killstreakfuncs["remote_mg_sentry_turret"] = ::tryuseremotemgsentryturret;
    level.killstreakwieldweapons["remote_energy_turret_mp"] = "remote_mg_sentry_turret";
    level.killstreakwieldweapons["sentry_minigun_mp"] = "remote_mg_sentry_turret";
    level.killstreakwieldweapons["killstreakmahem_mp"] = "remote_mg_sentry_turret";

    if ( !isdefined( level.turretsettings ) )
        level.turretsettings = [];

    level.turretsettings["mg_turret"] = spawnstruct();
    level.turretsettings["mg_turret"].sentrymodeon = "sentry";
    level.turretsettings["mg_turret"].sentrymodeoff = "sentry_offline";
    level.turretsettings["mg_turret"].timeout = 60.0;
    level.turretsettings["mg_turret"].maxhealth = 1000;
    level.turretsettings["mg_turret"].streakname = "remote_mg_turret";
    level.turretsettings["mg_turret"].teamsplash = "used_remote_mg_turret";
    level.turretsettings["mg_turret"].hintenter = &"MP_ENTER_REMOTE_TURRET";
    level.turretsettings["mg_turret"].hintpickup = &"MP_HOLD_TO_CARRY";
    level.turretsettings["mg_turret"].hintripoff = &"MP_TURRET_RIP_OFF";
    level.turretsettings["mg_turret"].hintdropturret = &"MP_TURRET_DROP";
    level.turretsettings["mg_turret"].placestring = &"MP_TURRET_PLACE";
    level.turretsettings["mg_turret"].cannotplacestring = &"MP_TURRET_CANNOT_PLACE";
    level.turretsettings["mg_turret"].laptopinfo = "killstreak_remote_turret_mp";
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

tryuseremotemgsentryturret( var_0, var_1 )
{
    var_2 = tryuseremoteturret( var_0, "mg_turret", 1, var_1 );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level.turretsettings["mg_turret"].streakname, self.origin );

    self.iscarrying = 0;
    return var_2;
}

tryuseremotemgturret( var_0, var_1 )
{
    var_2 = tryuseremoteturret( var_0, "mg_turret", 0, var_1 );

    if ( var_2 )
        maps\mp\_matchdata::logkillstreakevent( level.turretsettings["mg_turret"].streakname, self.origin );

    self.iscarrying = 0;
    return var_2;
}

takekillstreakweapons( var_0 )
{
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( level.turretsettings[var_0].laptopinfo );
}

tryuseremoteturret( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.turret ) )
    {
        self iclientprintlnbold( &"KILLSTREAKS_SENTRY_IN_USE" );
        return 0;
    }

    var_4 = createturretforplayer( var_1, self, var_2, var_3 );

    if ( isdefined( level.ishorde ) && level.ishorde && self.killstreakindexweapon == 1 )
        self.hordeclassturret = var_4;

    playeraddnotifycommands();
    removeperks();
    self.carriedturret = var_4;
    setcarryingturret( var_4, 1 );
    self.carriedturret = undefined;
    thread restoreperks();

    if ( isdefined( var_4 ) )
        return 1;
    else
        return 0;
}

setupheavyresistancemodel()
{
    if ( self.heavyresistance )
        self _meth_8048( "TAG_OPTIC_STANDARD" );
    else
        self _meth_8048( "TAG_OPTIC_RESISTANCE" );
}

setuprippablemodel()
{
    if ( !self.rippable )
        self _meth_8048( "TAG_HANDLES" );
}

setmodelturretbaseonly()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self.energyturret )
        self _meth_80B1( "npc_sentry_energy_turret_empty_base" );
    else if ( self.rocketturret )
        self _meth_80B1( "npc_sentry_rocket_turret_empty_base" );
    else if ( self.disruptorturret )
        self _meth_80B1( "npc_sentry_disruptor_turret_empty_base" );
    else
        self _meth_80B1( "npc_sentry_minigun_turret_empty_base" );

    setupheavyresistancemodel();
    setuprippablemodel();
}

setmodelremoteturret()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self.energyturret )
        self _meth_80B1( "npc_sentry_energy_turret_base" );
    else if ( self.rocketturret )
        self _meth_80B1( "npc_sentry_rocket_turret_base" );
    else if ( self.disruptorturret )
        self _meth_80B1( "npc_sentry_disruptor_turret_base" );
    else
        self _meth_80B1( "npc_sentry_minigun_turret_base" );

    setupheavyresistancemodel();
    setuprippablemodel();
}

setmodelturretplacementgood()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self.energyturret )
        self _meth_80B1( "npc_sentry_energy_turret_base_yellow_obj" );
    else if ( self.rocketturret )
        self _meth_80B1( "npc_sentry_rocket_turret_base_yellow_obj" );
    else if ( self.disruptorturret )
        self _meth_80B1( "npc_sentry_disruptor_turret_base_yellow_obj" );
    else
        self _meth_80B1( "npc_sentry_minigun_turret_base_yellow_obj" );

    setupheavyresistancemodel();
    setuprippablemodel();
}

setmodelturretplacementfailed()
{
    if ( isdefined( self.model ) && self.model != "" )
        self _meth_804C();

    if ( self.energyturret )
        self _meth_80B1( "npc_sentry_energy_turret_base_red_obj" );
    else if ( self.rocketturret )
        self _meth_80B1( "npc_sentry_rocket_turret_base_red_obj" );
    else if ( self.disruptorturret )
        self _meth_80B1( "npc_sentry_disruptor_turret_base_red_obj" );
    else
        self _meth_80B1( "npc_sentry_minigun_turret_base_red_obj" );

    setupheavyresistancemodel();
    setuprippablemodel();
}

setcarryingturret( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !maps\mp\_utility::isreallyalive( self ) )
    {
        var_0 delete();
        return;
    }

    var_0 turret_setcarried( self );
    var_2 = maps\mp\_utility::getkillstreakweapon( "remote_mg_sentry_turret" );
    var_3 = self _meth_8312();

    if ( !maps\mp\gametypes\_weapons::isvalidlastweapon( var_3 ) || var_3 == "iw5_underwater_mp" )
        var_3 = common_scripts\utility::getlastweapon();

    if ( !var_1 )
    {
        maps\mp\_utility::_giveweapon( var_2, 0 );
        self _meth_8315( var_2 );
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

            var_0 turret_setcancelled();

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
            if ( !var_0.canbeplaced )
                continue;

            var_0 turret_setplaced();
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

    while ( self _meth_8312() != var_0 )
        waitframe();

    self.water_last_weapon = var_0;
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_1 );
}

setripoffturrethead( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 _meth_82C0( 0 );
    var_0 setcontents( 0 );
    var_0 _meth_813A();
    var_0.carriedby = self;
    self.iscarrying = 0;
    var_0 turret_setinactive();
    var_0 setmodelturretbaseonly();
    var_0 notify( "carried" );
    var_0 notify( "ripped" );
    var_0 _meth_8105( 0 );
    var_0 thread deleteaftertime( 20 );

    if ( isdefined( var_0.remoteent ) )
        var_0.remoteent maps\mp\_utility::makegloballyunusablebytype();

    if ( var_0.energyturret )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadenergy_mp" );
    else if ( var_0.rocketturret )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadrocket_mp" );
    else if ( var_0.disruptorturret )
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheaddisruptor_mp" );
    else
        thread maps\mp\killstreaks\_rippedturret::playergiveturrethead( "turretheadmg_mp" );

    var_0 playsound( "sentry_gun_detach" );
}

deleteaftertime( var_0 )
{
    self endon( "death" );
    level maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );

    if ( isdefined( self ) )
    {
        deathsoundsandfx();
        self delete();
    }
}

deathsoundsandfx()
{
    var_0 = self gettagorigin( "TAG_AIM_PIVOT" );
    playfx( common_scripts\utility::getfx( "sentry_gone" ), var_0 );
    playsoundatpos( var_0, "sentry_gun_self_destruct" );
}

removeperks()
{
    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );
    }
}

restoreperks()
{
    if ( isdefined( self.restoreperk ) )
    {
        maps\mp\_utility::giveperk( self.restoreperk, 0 );
        self.restoreperk = undefined;
    }
}

waitrestoreperks()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    restoreperks();
}

turret_quickdeath( var_0 )
{
    self.quick_death = 1;
    self notify( "death" );
}

turret_setplaced()
{
    setmodelremoteturret();
    thread sentry_attacktargets();
    thread sentry_disruptor();
    self _meth_8104( undefined );
    self _meth_82C0( 1 );
    self.carriedby _meth_80DE();
    self.carriedby = undefined;

    if ( isdefined( self.owner ) )
    {
        self.owner.iscarrying = 0;
        common_scripts\utility::make_entity_sentient_mp( self.owner.team );
    }

    var_0 = spawnstruct();
    var_0.linkparent = self.placementlinkentity;
    var_0.endonstring = "carried";
    var_0.deathoverridecallback = ::turret_quickdeath;
    thread maps\mp\_movers::handle_moving_platforms( var_0 );
    self playsound( "sentry_gun_deploy" );
    thread turret_setactive();
    self notify( "placed" );
}

turret_setcancelled()
{
    self.carriedby _meth_80DE();

    if ( isdefined( self.owner ) )
        self.owner.iscarrying = 0;

    self delete();
}

turret_setcarried( var_0 )
{
    setmodelturretplacementgood();
    self _meth_82C0( 0 );
    self _meth_8104( var_0 );
    self setcontents( 0 );
    self _meth_813A();
    self _meth_804F();
    self.carriedby = var_0;
    var_0.iscarrying = 1;
    var_0 thread updateturretplacement( self );
    thread turret_oncarrierdeath( var_0 );
    thread turret_oncarrierdisconnect( var_0 );
    thread turret_oncarrierchangedteam( var_0 );
    thread turret_ongameended();
    self _meth_815A( -89.0 );
    turret_setinactive();
    self notify( "carried" );
}

updateturretplacement( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "placed" );
    var_0 endon( "death" );
    var_0.canbeplaced = 1;
    var_0.placementlinkentity = undefined;
    var_1 = -1;

    for (;;)
    {
        var_2 = self _meth_82D2( 1 );
        var_0.origin = var_2["origin"];
        var_0.angles = var_2["angles"];
        var_0.canbeplaced = self _meth_8341() && var_2["result"] && ( abs( var_0.origin[2] - self.origin[2] ) < 10 && !var_0 istouchingwater() );

        if ( isdefined( var_2["entity"] ) )
            var_0.placementlinkentity = var_2["entity"];
        else
            var_0.placementlinkentity = undefined;

        if ( var_0.canbeplaced != var_1 )
        {
            if ( var_0.canbeplaced )
            {
                var_0 setmodelturretplacementgood();
                self _meth_80DD( level.turretsettings[var_0.turrettype].placestring );
            }
            else
            {
                var_0 setmodelturretplacementfailed();
                self _meth_80DD( level.turretsettings[var_0.turrettype].cannotplacestring );
            }
        }

        var_1 = var_0.canbeplaced;
        wait 0.05;
    }
}

istouchingwater()
{
    if ( !isdefined( level.water_triggers ) )
        return 0;
    else
    {
        foreach ( var_1 in level.water_triggers )
        {
            if ( self _meth_80A9( var_1 ) )
                return 1;
        }
    }

    return 0;
}

turret_oncarrierdeath( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 waittill( "death" );

    if ( self.canbeplaced )
        turret_setplaced();
    else
    {
        if ( isdefined( self.owner ) )
            self.owner.iscarrying = 0;

        self delete();
    }
}

turret_oncarrierdisconnect( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 waittill( "disconnect" );
    self delete();
}

turret_oncarrierchangedteam( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    var_0 common_scripts\utility::waittill_any( "joined_team", "joined_spectators" );
    self delete();
}

turret_ongameended( var_0 )
{
    self endon( "placed" );
    self endon( "death" );
    self endon( "ripped" );
    level waittill( "game_ended" );
    self delete();
}

createturretforplayer( var_0, var_1, var_2, var_3 )
{
    var_4 = "sentry_minigun_mp";

    if ( common_scripts\utility::array_contains( var_3, "sentry_energy_turret" ) )
        var_4 = "remote_energy_turret_mp";

    var_5 = spawnturret( "misc_turret", var_1.origin, var_4 );
    var_5.angles = var_1.angles;
    var_5.owner = var_1;
    var_5.health = level.turretsettings[var_0].maxhealth;
    var_5.maxhealth = level.turretsettings[var_0].maxhealth;
    var_5.turrettype = var_0;
    var_5.stunned = 0;
    var_5.directhacked = 0;
    var_5.modules = var_3;
    var_5.heavyresistance = common_scripts\utility::array_contains( var_5.modules, "sentry_heavy_resistance" );
    var_5.antiintrusion = common_scripts\utility::array_contains( var_5.modules, "sentry_anti_intrusion" );
    var_5.rocketturret = common_scripts\utility::array_contains( var_5.modules, "sentry_rocket_turret" );
    var_5.energyturret = common_scripts\utility::array_contains( var_5.modules, "sentry_energy_turret" );
    var_5.disruptorturret = common_scripts\utility::array_contains( var_5.modules, "sentry_disruptor" );
    var_5.rippable = common_scripts\utility::array_contains( var_5.modules, "sentry_rippable" );
    var_5.issentry = common_scripts\utility::array_contains( var_5.modules, "sentry_guardian" );
    var_5.is360 = common_scripts\utility::array_contains( var_5.modules, "sentry_360" );
    var_5.weaponinfo = var_4;
    var_5 setmodelremoteturret();

    if ( var_5.rocketturret )
    {
        var_5 _meth_815C();
        var_5.weaponinfo = "killstreakmahem_mp";
    }

    if ( var_5.rocketturret || var_5.energyturret || var_5.disruptorturret )
        var_5 _meth_8424( 0 );

    var_5 _meth_817A( 1 );
    var_5 turret_setinactive();
    var_5 _meth_8103( var_1 );
    var_5 _meth_8105( 1, var_0 );

    if ( var_5.disruptorturret )
    {
        var_5 _meth_8156( 0 );
        var_5 _meth_8155( 0 );
    }
    else if ( var_5.is360 )
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
    var_5 thread turret_handleownerdisconnect();
    var_1.turret = var_5;
    var_5.damagefade = 1.0;
    var_5 thread turret_incrementdamagefade();
    var_5 thread sentry_attacktargets();
    return var_5;
}

turret_setactive()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    self makeunusable();
    self _meth_8136();

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    level.turrets[self _meth_81B1()] = self;

    if ( isdefined( var_0.remoteturretlist ) )
    {
        foreach ( var_2 in var_0.remoteturretlist )
            var_2 notify( "death" );
    }

    var_0.remoteturretlist = [];
    var_0.remoteturretlist[0] = self;

    if ( !self.disruptorturret )
    {
        if ( !isdefined( self.remoteent ) )
        {
            self.remoteent = spawn( "script_model", self.origin + ( 0, 0, 1 ) );
            self.remoteent _meth_80B1( "tag_origin" );
            self.remoteent.owner = var_0;
            self.remoteent maps\mp\_utility::makegloballyusablebytype( "killstreakRemote", level.turretsettings[self.turrettype].hintenter, var_0 );
        }
        else
            self.remoteent maps\mp\_utility::enablegloballyusablebytype();
    }

    var_0.using_remote_turret = 0;
    var_0.pickup_message_deleted = undefined;
    var_0.enter_message_deleted = undefined;
    var_0 thread watchownermessageondeath( self );

    if ( level.teambased )
    {
        self.team = var_0.team;
        self _meth_8135( var_0.team );
        maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0, 0, 65 ), "tag_origin" );
    }
    else
        maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0, 0, 65 ), "tag_origin" );

    self.ownertrigger = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 32, 64 );
    self.pickupent = spawn( "script_model", self.origin + ( 0, 0, 1 ) );
    self.pickupent _meth_80B1( "tag_origin" );
    self.pickupent.owner = var_0;
    var_0 thread player_handleturretpickup( self );
    var_0 thread player_handleturrethints( self );

    if ( self.rippable )
        var_0 thread player_handleturretrippable( self );

    if ( !self.disruptorturret )
        thread watchenterandexit();

    thread turret_handledeath();
    thread maps\mp\gametypes\_damage::setentitydamagecallback( self.maxhealth, undefined, ::onturretdeath, ::turret_modifydamage, 1 );
    thread turret_timeout();
    thread turret_gameend();
    thread turret_watchemp();

    if ( !self.heavyresistance )
        thread turret_watchdisabled();

    if ( self.antiintrusion )
        thread turret_createantiintrusionkillcament();

    thread turret_handlepitch();
    thread turret_handlelaser();

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

turret_modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = handlemeleedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleempdamage( var_1, var_2, var_4, var_0 );
    var_4 = maps\mp\gametypes\_damage::handlemissiledamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = maps\mp\gametypes\_damage::handleapdamage( var_1, var_2, var_4, var_0 );

    if ( isdefined( self.owner ) && var_4 > 0 )
    {
        self.owner _meth_80AD( "damage_heavy" );
        self.owner thread maps\mp\killstreaks\_aerial_utility::playershowstreakstaticfordamage();
    }

    return var_4;
}

onturretdeath( var_0, var_1, var_2, var_3 )
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
    self _meth_80B3();
}

playershowturretoverlay( var_0 )
{
    self endon( "disconnect" );
    self endon( "playerHideTurretOverlay" );
    wait 0.5;
    var_1 = 0;

    if ( var_0.weaponinfo == "sentry_minigun_mp" )
        var_1 = 1;
    else if ( var_0.weaponinfo == "remote_energy_turret_mp" )
        var_1 = 2;
    else if ( var_0.weaponinfo == "killstreakmahem_mp" )
        var_1 = 3;

    self _meth_82FB( "ui_sentry_ammo_type", var_1 );
    self _meth_82FB( "ui_sentry_toggle", 1 );
    maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

playerhideturretoverlay()
{
    self notify( "playerHideTurretOverlay" );
    self _meth_82FB( "ui_sentry_toggle", 0 );
    maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

playerwaittillweaponswitchover( var_0 )
{
    self endon( "weapon_change" );
    self waittill( "weapon_switch_started", var_1 );

    if ( var_0 != var_1 )
        return;

    while ( self _meth_8337() )
        waitframe();
}

startusingremoteturret( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_5 = self.owner;

    if ( !var_4 )
    {
        var_5 _meth_807C( self.remoteent );
        var_5 _meth_8081();
        var_5 maps\mp\_utility::_giveweapon( level.turretsettings[self.turrettype].laptopinfo );
        var_5 _meth_8315( level.turretsettings[self.turrettype].laptopinfo );
        var_5 _meth_831F();
        var_5 _meth_84BF();
        var_5 playerwaittillweaponswitchover( level.turretsettings[self.turrettype].laptopinfo );
        var_6 = var_5 _meth_8311();

        if ( var_6 != level.turretsettings[self.turrettype].laptopinfo )
        {
            var_5 takekillstreakweapons( self.turrettype );
            var_5 _meth_8320();
            var_5 _meth_84C0();
            var_5 _meth_804F();
            return 0;
        }
    }

    self.remotecontrolled = 1;
    sentry_stopattackingtargets();
    var_5 thread playerdoridekillstreak( self, var_4 );
    var_5 waittill( "initRideKillstreak_complete", var_7 );

    if ( !var_7 )
        return 0;

    var_5 maps\mp\_utility::playersaveangles();
    var_5 maps\mp\_utility::setusingremote( self.turrettype );
    self notify( "remoteControlledUpdate" );
    self.killcamstarttime = gettime();
    var_5 thread waitsetthermal( 1.0, self );

    if ( getdvarint( "camera_thirdPerson" ) )
        var_5 maps\mp\_utility::setthirdpersondof( 0 );

    var_5 _meth_807E( self, "tag_player", 0, var_0, var_1, var_2, var_3, 0 );
    var_5 _meth_80A0( 0 );
    var_5 _meth_80A1( 1 );
    var_5 _meth_80E8( self );

    if ( isdefined( self.remoteent ) )
        self.remoteent maps\mp\_utility::disablegloballyusablebytype();

    turret_clearpickuphints();
    var_5 thread playershowturretoverlay( self );

    if ( self.rocketturret )
        var_5 thread playermonitorrocketturretfire( self );

    if ( var_5 maps\mp\_utility::isjuggernaut() )
        var_5.juggernautoverlay.alpha = 0;

    thread maps\mp\_utility::playloopsoundtoplayers( "sentry_gun_remote_view_bg", ( 0, 0, 60 ), [ var_5 ] );
    return 1;
}

waitsetthermal( var_0, var_1 )
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

stopusingremoteturret( var_0 )
{
    if ( !isdefined( self.remotecontrolled ) || !self.remotecontrolled )
        return;

    self.remotecontrolled = undefined;
    self notify( "remoteControlledUpdate" );
    var_1 = self.owner;
    var_1 takekillstreakweapons( self.turrettype );
    var_1 _meth_8320();
    var_1 _meth_84C0();
    thread sentry_attacktargets();
    var_2 = maps\mp\_utility::getkillstreakweapon( level.turretsettings[self.turrettype].streakname );
    var_1 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_2 );
    var_3 = var_1 common_scripts\utility::getlastweapon();

    if ( isdefined( var_1.underwater ) && var_1.underwater )
        var_3 = var_1 maps\mp\_utility::get_water_weapon();

    var_1 _meth_8315( var_3 );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_1 _meth_804F();

    if ( var_1 maps\mp\_utility::isusingremote() )
    {
        var_1 setthermaloff();
        var_1 _meth_80E9( self );

        if ( var_1 maps\mp\_utility::isusingremote() )
            var_1 maps\mp\_utility::clearusingremote();

        if ( getdvarint( "camera_thirdPerson" ) )
            var_1 maps\mp\_utility::setthirdpersondof( 1 );
    }

    if ( turret_isstunned() )
        var_1 stopshellshock();

    if ( !turret_isstunned() && var_0 && ( !isdefined( var_1.using_remote_turret_when_died ) || !var_1.using_remote_turret_when_died ) )
        self.remoteent maps\mp\_utility::enablegloballyusablebytype();

    if ( var_1 maps\mp\_utility::isjuggernaut() )
        var_1.juggernautoverlay.alpha = 1;

    var_1 playerhideturretoverlay();
    self notify( "stop soundsentry_gun_remote_view_bg" );

    if ( isdefined( var_1.killcament ) )
        var_1.killcament delete();

    maps\mp\_utility::playerrestoreangles();
    self notify( "exit" );
}

playerdoridekillstreak( var_0, var_1 )
{
    var_2 = "remote_turret";

    if ( var_1 )
        var_2 = "coop";

    var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak( var_2 );

    if ( !isdefined( self ) )
        return;

    if ( var_3 != "success" || var_0 turret_isstunned() || isdefined( var_0.dead ) )
    {
        if ( var_3 != "disconnect" || var_0 turret_isstunned() || isdefined( var_0.dead ) )
        {
            thread maps\mp\_utility::playerremotekillstreakshowhud();
            var_0 stopusingremoteturret( !var_1 );
        }

        self notify( "initRideKillstreak_complete", 0 );
        return;
    }

    self notify( "initRideKillstreak_complete", 1 );
}

watchownermessageondeath( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "ripped" );
    self.using_remote_turret_when_died = 0;

    for (;;)
    {
        if ( isalive( self ) )
            self waittill( "death" );

        if ( isdefined( var_0.remoteent ) )
            var_0.remoteent maps\mp\_utility::disablegloballyusablebytype();

        var_0 turret_clearpickuphints();

        if ( self.using_remote_turret )
            self.using_remote_turret_when_died = 1;
        else
            self.using_remote_turret_when_died = 0;

        self waittill( "spawned_player" );
        self.using_remote_turret_when_died = 0;

        if ( isdefined( var_0.remoteent ) )
            var_0.remoteent maps\mp\_utility::enablegloballyusablebytype();
    }
}

watchenterandexit()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    var_0 = self.owner;
    thread watchenterandexitinput();

    for (;;)
    {
        if ( var_0 player_shoulddisableremoteenter( self ) )
        {
            if ( !isdefined( var_0.enter_message_deleted ) || !var_0.enter_message_deleted )
            {
                var_0.enter_message_deleted = 1;
                self.remoteent maps\mp\_utility::disablegloballyusablebytype();
            }
        }
        else if ( isdefined( var_0.enter_message_deleted ) && var_0.enter_message_deleted )
        {
            self.remoteent maps\mp\_utility::enablegloballyusablebytype();
            var_0.enter_message_deleted = 0;
        }

        waitframe();
    }
}

player_shoulddisableremoteenter( var_0 )
{
    var_1 = self _meth_8311();
    return var_0 turret_isstunned() || player_isusingkillstreak( var_0 ) || isdefined( self.underwater ) && self.underwater || self.using_remote_turret || var_1 == "none" || self _meth_80A9( var_0.ownertrigger ) || self _meth_8068() && !self.using_remote_turret || isdefined( self.empgrenaded ) && self.empgrenaded;
}

watchenterandexitinput()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    var_0 = self.owner;
    var_1 = 50;
    var_2 = 30;
    var_3 = 80;
    var_4 = 80;

    if ( self.is360 )
    {
        var_3 = 180;
        var_4 = 180;
    }

    for (;;)
    {
        waittillremoteturretusedreturn();
        var_0.using_remote_turret = 1;
        var_5 = startusingremoteturret( var_3, var_4, var_1, var_2 );

        if ( var_5 )
        {
            wait 2.0;
            waittillremoteturretleavereturn();
            var_0.using_remote_turret = 0;
            stopusingremoteturret();
            wait 2.0;
            continue;
        }

        var_0.using_remote_turret = 0;
    }
}

waittillremoteturretusedreturn()
{
    var_0 = self.owner;

    for (;;)
    {
        self.remoteent waittill( "trigger" );

        if ( var_0 playercanuseturret( self ) )
            return;
    }
}

waittillremoteturretleavereturn()
{
    var_0 = self.owner;

    for (;;)
    {
        var_1 = 0;

        while ( var_0 usebuttonpressed() )
        {
            var_1 += 0.05;

            if ( var_1 > 0.2 && var_0 playercanuseturret( self ) )
                return;

            waitframe();
        }

        waitframe();
    }
}

playercanuseturret( var_0 )
{
    if ( self _meth_82EE() || isdefined( self.throwinggrenade ) || self _meth_82EF() )
        return 0;

    if ( self _meth_8342() || !self _meth_8341() )
        return 0;

    if ( isdefined( var_0.ownertrigger ) && self _meth_80A9( var_0.ownertrigger ) )
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

    if ( self _meth_8068() && !self.using_remote_turret )
        return 0;

    return 1;
}

player_isusingkillstreak( var_0 )
{
    var_1 = self _meth_8311();
    return maps\mp\_utility::isjuggernaut() || maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition() || maps\mp\_utility::iskillstreakweapon( var_1 ) && var_1 != "killstreak_remote_turret_mp" && var_1 != "sentry_minigun_mp" && var_1 != "remote_energy_turret_mp" && var_1 != level.turretsettings[var_0.turrettype].laptopinfo && var_1 != "none" && var_1 != "turretheadmg_mp" && var_1 != "turretheadenergy_mp" && var_1 != "turretheadrocket_mp";
}

player_handleturrethints( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0.ownertrigger ) || !isdefined( var_0.pickupent ) )
        return;

    var_0.pickupent endon( "death" );

    for (;;)
    {
        if ( player_shouldclearturretpickuphints( var_0 ) )
        {
            if ( !isdefined( self.pickup_message_deleted ) || !self.pickup_message_deleted )
            {
                self.pickup_message_deleted = 1;
                var_0 turret_clearpickuphints();
            }
        }
        else if ( isdefined( self.pickup_message_deleted ) && self.pickup_message_deleted )
        {
            var_0 thread turret_setpickuphints();
            self.pickup_message_deleted = 0;
        }

        waitframe();
    }
}

player_shouldclearturretpickuphints( var_0 )
{
    var_1 = self _meth_8311();
    return var_0 turret_isstunned() || player_isusingkillstreak( var_0 ) || isdefined( self.underwater ) && self.underwater || self.using_remote_turret || var_1 == "none" || !self _meth_80A9( var_0.ownertrigger ) || !maps\mp\_utility::isreallyalive( self ) || !self _meth_8341() || isdefined( var_0.carriedby );
}

player_handleturretpickup( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0.ownertrigger ) || !isdefined( var_0.pickupent ) )
        return;

    var_0.pickupent endon( "death" );
    var_1 = 0;

    for (;;)
    {
        if ( player_isusingkillstreak( var_0 ) )
        {
            waitframe();
            continue;
        }

        if ( !self _meth_80A9( var_0.ownertrigger ) )
        {
            waitframe();
            continue;
        }

        if ( maps\mp\_utility::isreallyalive( self ) && self _meth_80A9( var_0.ownertrigger ) && !isdefined( var_0.carriedby ) && self _meth_8341() )
        {
            var_2 = 0;

            while ( self usebuttonpressed() )
            {
                if ( !maps\mp\_utility::isreallyalive( self ) )
                    break;

                if ( !self _meth_80A9( var_0.ownertrigger ) )
                    break;

                if ( self _meth_82EE() || self _meth_82EF() || isdefined( self.throwinggrenade ) )
                    break;

                if ( self _meth_8068() || !self _meth_8341() || self _meth_8342() || maps\mp\_utility::isusingremote() )
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
                    var_0 _meth_8065( level.turretsettings[var_0.turrettype].sentrymodeoff );
                    var_0 sentry_stopattackingtargets();
                    thread setcarryingturret( var_0, 0 );
                    var_0 turret_clearpickuphints();
                    self.remoteturretlist = undefined;
                    var_0.pickupent delete();
                    var_0.ownertrigger delete();
                    return;
                }

                waitframe();
            }
        }

        waitframe();
    }
}

player_handleturretrippable( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );

    if ( isbot( self ) )
        return;

    if ( !isdefined( var_0.ownertrigger ) || !isdefined( var_0.pickupent ) )
        return;

    var_0.pickupent endon( "death" );
    var_1 = 0;

    for (;;)
    {
        if ( player_isusingkillstreak( var_0 ) )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\killstreaks\_rippedturret::playerhasturretheadweapon() )
        {
            waitframe();
            continue;
        }

        if ( !self _meth_80A9( var_0.ownertrigger ) )
        {
            wait 0.05;
            continue;
        }

        if ( maps\mp\_utility::isreallyalive( self ) && self _meth_80A9( var_0.ownertrigger ) && !isdefined( var_0.carriedby ) && self _meth_8341() )
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

                var_0 _meth_8065( level.turretsettings[var_0.turrettype].sentrymodeoff );
                var_0 sentry_stopattackingtargets();
                thread setripoffturrethead( var_0 );
                var_0 turret_clearpickuphints();
                self.remoteturretlist = undefined;
                var_0.pickupent delete();
                var_0.ownertrigger delete();
                return;
            }
        }

        wait 0.05;
    }
}

turret_blinky_light()
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

turret_setinactive()
{
    self _meth_8065( level.turretsettings[self.turrettype].sentrymodeoff );
    sentry_stopattackingtargets();

    if ( level.teambased )
        maps\mp\_entityheadicons::setteamheadicon( "none", ( 0, 0, 0 ) );
    else if ( isdefined( self.owner ) )
        maps\mp\_entityheadicons::setplayerheadicon( undefined, ( 0, 0, 0 ) );

    if ( !isdefined( self.owner ) )
        return;

    var_0 = self.owner;
    level.turrets[self _meth_81B1()] = undefined;

    if ( isdefined( self.remoteent ) )
        self.remoteent maps\mp\_utility::disablegloballyusablebytype();

    if ( isdefined( var_0.using_remote_turret ) && var_0.using_remote_turret )
    {
        var_0 thermalvisionoff();
        var_0 setthermaloff();
        var_0 _meth_80E9( self );
        var_0 _meth_804F();
        var_1 = var_0 common_scripts\utility::getlastweapon();

        if ( isdefined( var_0.underwater ) && var_0.underwater )
            var_1 = var_0 maps\mp\_utility::get_water_weapon();

        var_0 _meth_8315( var_1 );

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

        var_0 takekillstreakweapons( self.turrettype );

        if ( var_0 maps\mp\_utility::isjuggernaut() )
            var_0.juggernautoverlay.alpha = 1;
    }
}

turret_handleownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "turret_handleOwner" );
    self endon( "turret_handleOwner" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "death" );
}

turret_gameend()
{
    self endon( "death" );
    level waittill( "game_ended" );

    if ( isdefined( self.owner ) )
        self.owner playerhideturretoverlay();
}

turret_timeout()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( self.timeoutstarted ) )
        return;

    self.timeoutstarted = 1;
    var_0 = level.turretsettings[self.turrettype].timeout;

    if ( self.disruptorturret )
        var_0 += 30;

    self.owner _meth_82FB( "ui_sentry_lifespan", var_0 );

    while ( var_0 )
    {
        wait 1.0;
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( !isdefined( self.carriedby ) )
            var_0 = max( 0, var_0 - 1.0 );
    }

    if ( isdefined( self.owner ) )
        self.owner playerhideturretoverlay();

    self notify( "death" );
}

turret_handledeath()
{
    self endon( "carried" );
    var_0 = self _meth_81B1();
    maps\mp\killstreaks\_autosentry::addtoturretlist( var_0 );
    self waittill( "death", var_1, var_2, var_3 );
    self _meth_8108();
    turret_deathsounds( var_1, var_3 );
    self.damagecallback = undefined;
    self _meth_82C0( 0 );
    self _meth_8495( 0 );
    self _meth_813A();
    self _meth_80B3();
    self.dead = 1;
    maps\mp\killstreaks\_autosentry::removefromturretlist( var_0 );

    if ( !isdefined( self ) )
        return;

    turret_clearpickuphints();
    turret_setinactive();
    self _meth_815A( 35 );
    self _meth_8103( undefined );
    self _meth_8105( 0 );

    if ( isdefined( self.remoteent ) )
        self.remoteent maps\mp\_utility::makegloballyunusablebytype();

    var_4 = self.owner;

    if ( isdefined( var_4 ) )
    {
        stopusingremoteturret();
        var_4.using_remote_turret = 0;
        var_4.turret = undefined;
        var_4 restoreperks();
        var_4 playerremovenotifycommands();

        if ( var_4 _meth_8311() == "none" )
        {
            var_5 = var_4 common_scripts\utility::getlastweapon();

            if ( isdefined( var_4.underwater ) && var_4.underwater )
                var_5 = var_4 maps\mp\_utility::get_water_weapon();

            var_4 _meth_8315( var_5 );
        }
    }

    self playsound( "sentry_gun_death_exp" );

    if ( !isdefined( self.quick_death ) || !self.quick_death )
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

    if ( isdefined( self.target_ent ) )
        self.target_ent delete();

    if ( isdefined( self.ownertrigger ) )
        self.ownertrigger delete();

    if ( isdefined( self.pickupent ) )
        self.pickupent delete();

    if ( isdefined( self.remoteent ) )
        self.remoteent delete();

    if ( isdefined( self.rocketmuzzleflashent ) )
        self.rocketmuzzleflashent delete();

    deathsoundsandfx();
    self delete();
}

turret_deathsounds( var_0, var_1 )
{
    if ( isdefined( self.owner ) && isdefined( var_0 ) && self.owner != var_0 )
        self.owner thread maps\mp\_utility::leaderdialogonplayer( "ks_sentrygun_destroyed", undefined, undefined, self.origin );
}

turret_incrementdamagefade()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( self.damagefade < 1.0 )
        {
            self.damagefade += 0.1;
            var_0 = 1;
        }
        else if ( var_0 )
        {
            self.damagefade = 1.0;
            var_0 = 0;
        }

        wait 0.1;
    }
}

turret_setpickuphints()
{
    self notify( "turretClearPickupHints" );
    self endon( "turretClearPickupHints" );
    self.pickupent makeusable();
    self.pickupent _meth_80DB( level.turretsettings[self.turrettype].hintpickup );
    self.pickupent _meth_80DA( "HINT_NOICON" );
    self.pickupent _meth_849B( 1 );

    if ( self.rippable )
    {
        for (;;)
        {
            var_0 = 0;

            if ( !var_0 && isdefined( self.owner ) && !self.owner maps\mp\killstreaks\_rippedturret::playerhasturretheadweapon() )
            {
                self.pickupent _meth_80DC( level.turretsettings[self.turrettype].hintripoff );
                var_0 = 1;
            }
            else if ( var_0 )
            {
                self.pickupent _meth_80DC( "" );
                var_0 = 0;
            }

            waitframe();
        }
    }
}

turret_clearpickuphints()
{
    self notify( "turretClearPickupHints" );

    if ( !isdefined( self.pickupent ) )
        return;

    self.pickupent makeunusable();
    self.pickupent _meth_80DB( "" );
    self.pickupent _meth_80DC( "" );
    self.pickupent _meth_849B( 0 );
}

sentry_stopattackingtargets()
{
    self notify( "sentry_stop" );
}

sentry_attacktargets( var_0 )
{
    if ( !self.issentry )
        return;

    self endon( "sentry_stop" );
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_start" );
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;

    if ( !self.rocketturret )
        thread sentry_heatmonitor( "sentry_minigun_mp", 4.0, 0.1 );

    self _meth_8065( level.turretsettings["mg_turret"].sentrymodeon );
    self.firereadytime = gettime();

    for (;;)
    {
        common_scripts\utility::waittill_either( "turretstatechange", "cooled" );

        if ( self _meth_80E4() )
        {
            thread turret_startshooting( var_0 );
            continue;
        }

        thread turret_stopshooting();
    }
}

turret_startshooting( var_0 )
{
    if ( self.rocketturret )
        thread turret_firerockets();
    else
        thread sentry_burstfirestart( var_0 );
}

turret_stopshooting()
{
    if ( self.rocketturret )
        thread turret_stoprockets();
    else
    {
        sentry_spindown();
        thread sentry_burstfirestop();
    }
}

playermonitorrocketturretfire( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "sentry_start" );
    var_0 endon( "exit" );
    var_0.firereadytime = gettime();

    for (;;)
    {
        self waittill( "turret_fire" );
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

        if ( isdefined( level.hostmigrationtimer ) )
            continue;

        if ( gettime() >= var_0.firereadytime )
            var_0 thread turret_firerocket( 0 );
    }
}

sentry_targetlocksound()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

sentry_spinup()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    thread sentry_targetlocksound();

    while ( self.momentum < 0.05 )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

sentry_spindown()
{
    self.momentum = 0;
}

sentry_burstfirestart( var_0 )
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    sentry_spinup();
    var_1 = weaponfiretime( "sentry_minigun_mp" );
    var_2 = 20;
    var_3 = 120;
    var_4 = 0.15;
    var_5 = 0.35;

    for (;;)
    {
        var_6 = randomintrange( var_2, var_3 + 1 );

        for ( var_7 = 0; var_7 < var_6 && !self.overheated; var_7++ )
        {
            if ( isdefined( var_0 ) )
                self [[ var_0 ]]();
            else
                self _meth_80EA();

            self.heatlevel += var_1;
            wait(var_1);
        }

        wait(randomfloatrange( var_4, var_5 ));
    }
}

turret_stoprockets()
{
    self notify( "stop_shooting" );
}

turret_firerockets()
{
    self endon( "death" );
    self endon( "sentry_stop" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    self.firereadytime = gettime();

    for (;;)
    {
        if ( gettime() >= self.firereadytime )
            thread turret_firerocket( 1 );

        waitframe();
    }
}

turret_firerocket( var_0 )
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

    self _meth_80AD( "damage_heavy" );
    var_7 = magicbullet( "killstreakmahem_mp", var_1, var_3, self.owner );

    if ( var_0 )
        var_8 = 2500;
    else
        var_8 = 1250;

    self.firereadytime = gettime() + var_8;

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
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3 _meth_80B1( "tag_origin" );
    var_3 _meth_804D( var_0, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
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

sentry_burstfirestop()
{
    self notify( "stop_shooting" );
}

sentry_heatmonitor( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "sentry_stop" );
    var_3 = weaponfiretime( var_0 );
    var_4 = 0;
    var_5 = 0;

    for (;;)
    {
        if ( self.heatlevel != var_4 )
            wait(var_3);
        else
            self.heatlevel = max( 0, self.heatlevel - 0.05 );

        if ( self.heatlevel > var_1 )
        {
            self.overheated = 1;
            self _meth_8424( 0 );
            thread playheatfx();

            switch ( self.turrettype )
            {
                case "mg_turret":
                    playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }

            while ( self.heatlevel )
            {
                self.heatlevel = max( 0, self.heatlevel - var_2 );
                wait 0.1;
            }

            self _meth_8424( 1 );
            self.overheated = 0;
            self notify( "not_overheated" );
        }

        var_4 = self.heatlevel;
        wait 0.05;
    }
}

playheatfx()
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

turret_watchemp()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self waittill( "emp_damage" );
    self notify( "death" );
}

turret_watchdisabled()
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
            self _meth_8065( level.turretsettings[self.turrettype].sentrymodeoff );
        }

        if ( isdefined( self.remotecontrolled ) && self.remotecontrolled )
            stopusingremoteturret();

        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
        stopfxontag( common_scripts\utility::getfx( "sentry_stunned_mp" ), self, "tag_aim" );

        if ( self.issentry )
        {
            self _meth_815A( 0 );
            self _meth_8065( level.turretsettings[self.turrettype].sentrymodeon );
        }

        self.stunned = 0;
        self notify( "stunnedDone" );
    }
}

turret_isstunned()
{
    return isdefined( self.stunned ) && self.stunned;
}

turret_createantiintrusionkillcament()
{
    var_0 = spawn( "script_model", self.origin + ( 0, 0, 60 ) );
    self.killcament = var_0;
    common_scripts\utility::waittill_any( "death", "carried" );
    wait 3;
    var_0 delete();
}

turret_handlelaser()
{
    self endon( "death" );

    if ( !self.issentry )
        return;

    self _meth_80B2( "mp_sentry_turret" );
    self waittill( "carried" );
    self _meth_80B3();
}

turret_handlepitch()
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
    var_0 = ( 0, 0, 40 );

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

        foreach ( var_9 in level.hordesentryarray )
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

playeraddnotifycommands()
{
    self _meth_82DD( "turret_fire", "+attack" );
    self _meth_82DD( "turret_fire", "+attack_akimbo_accessible" );
    self _meth_82DD( "place_turret", "+attack" );
    self _meth_82DD( "place_turret", "+attack_akimbo_accessible" );

    if ( !isbot( self ) )
    {
        self _meth_82DD( "cancel_turret", "weapnext" );
        self _meth_82DD( "cancel_turret", "+actionslot 4" );

        if ( !level.console )
        {
            self _meth_82DD( "cancel_turret", "+actionslot 5" );
            self _meth_82DD( "cancel_turret", "+actionslot 6" );
            self _meth_82DD( "cancel_turret", "+actionslot 7" );
            self _meth_82DD( "cancel_turret", "+actionslot 8" );
        }
    }
}

playerremovenotifycommands()
{
    self _meth_849C( "turret_fire", "+attack" );
    self _meth_849C( "turret_fire", "+attack_akimbo_accessible" );
    self _meth_849C( "place_turret", "+attack" );
    self _meth_849C( "place_turret", "+attack_akimbo_accessible" );

    if ( !isbot( self ) )
    {
        self _meth_849C( "cancel_turret", "+actionslot 4" );

        if ( !level.console )
        {
            self _meth_849C( "cancel_turret", "weapnext" );
            self _meth_849C( "cancel_turret", "+actionslot 5" );
            self _meth_849C( "cancel_turret", "+actionslot 6" );
            self _meth_849C( "cancel_turret", "+actionslot 7" );
            self _meth_849C( "cancel_turret", "+actionslot 8" );
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

    var_3 = var_0.origin + ( 0, 0, 30 );
    var_4 = distancesquared( var_3, var_1 );

    if ( var_4 > level.turretdisruptorradiussq )
        return 0;

    var_5 = vectornormalize( var_0.origin - self.origin );
    var_6 = vectordot( var_2, var_5 );

    if ( var_6 < level.turretdisruptordetectdot )
        return 0;

    var_7 = var_0 _meth_81D7( var_1, self );
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
            var_0 _meth_8051( var_2, var_7, self.owner, self, "MOD_TRIGGER_HURT", "iw5_dlcgun12loot3_mp", "torso_upper" );
            var_3 = gettime() + var_1 * 1000;

            if ( isalive( var_0 ) && !var_0 maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
                var_0 thread maps\mp\_empgrenade::applyemp();
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
    var_0 = self gettagangles( "tag_flash" ) + ( 90, 0, 0 );
    var_1 = spawn( "script_model", self gettagorigin( "tag_flash" ) );
    var_1.angles = ( var_0[0], var_0[1], 0 );
    var_1 _meth_80B1( "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "turret_distortion" ), var_1, "tag_origin" );
    var_1 _meth_8438( "wpn_disruptor_snap_npc" );
    var_1 _meth_8075( "wpn_disruptor_beam_hi_npc" );
    common_scripts\utility::waittill_any( "death", "carried" );
    killfxontag( common_scripts\utility::getfx( "turret_distortion" ), var_1, "tag_origin" );
    var_1 _meth_8438( "wpn_disruptor_off_blast_npc" );
    var_1 _meth_80AB( "wpn_disruptor_beam_hi_npc" );
    wait 0.1;
    var_1 delete();
}
