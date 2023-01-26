// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.juggsettings = [];
    level.juggsettings["juggernaut_exosuit"] = spawnstruct();
    level.juggsettings["juggernaut_exosuit"]._id_8A67 = "used_juggernaut";
    level.juggsettings["juggernaut_exosuit"]._id_8A5F = "callout_destroyed_heavyexoattachment";
    level.juggsettings["juggernaut_exosuit"]._id_8A68 = "callout_weakened_heavyexoattachment";
    level._effect["green_light_mp"] = loadfx( "vfx/lights/aircraft_light_wingtip_green" );
    level._effect["juggernaut_sparks"] = loadfx( "vfx/explosion/bouncing_betty_explosion" );
    level._effect["jugg_droppod_open"] = loadfx( "vfx/explosion/goliath_pod_opening" );
    level._effect["jugg_droppod_marker"] = loadfx( "vfx/unique/vfx_marker_killstreak_guide_goliath" );
    level._effect["exo_ping_inactive"] = loadfx( "vfx/unique/exo_ping_inactive" );
    level._effect["exo_ping_active"] = loadfx( "vfx/unique/exo_ping_active" );
    level._effect["goliath_death_fire"] = loadfx( "vfx/fire/goliath_death_fire" );
    level._effect["goliath_self_destruct"] = loadfx( "vfx/explosion/goliath_self_destruct" );
    level._effect["lethal_rocket_wv"] = loadfx( "vfx/muzzleflash/playermech_lethal_flash_wv" );
    level._effect["swarm_rocket_wv"] = loadfx( "vfx/muzzleflash/playermech_tactical_wv_run" );
    level.killstreakwieldweapons["juggernaut_sentry_mg_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_juggernautrockets_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_exoxmgjugg_mp_akimbo"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_juggtitan45_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_exominigun_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_mechpunch_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["playermech_rocket_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["killstreak_goliathsd_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["orbital_carepackage_droppod_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["heavy_exo_trophy_mp"] = "juggernaut_exosuit";
    level.killstreakfuncs["heavy_exosuit"] = ::_id_98AB;
    game["dialog"]["assist_mp_goliath"] = "ks_goliath_joinreq";
    game["dialog"]["copilot_mp_goliath"] = "copilot_mp_goliath";
    game["dialog"]["sntryoff_mp_exoai"] = "sntryoff_mp_exoai";
    game["dialog"]["mancoff_mp_exoai"] = "mancoff_mp_exoai";
    game["dialog"]["longoff_mp_exoai"] = "longoff_mp_exoai";
    game["dialog"]["rcnoff_mp_exoai"] = "rcnoff_mp_exoai";
    game["dialog"]["rcktoff_mp_exoai"] = "rcktoff_mp_exoai";
    game["dialog"]["trphyoff_mp_exoai"] = "trphyoff_mp_exoai";
    game["dialog"]["weakdmg_mp_exoai"] = "weakdmg_mp_exoai";
    level thread onplayerconnect();
}

_id_98AB( var_0, var_1 )
{
    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( isdefined( self.hordegoliathpodinfield ) || isdefined( self.hordegoliathcontroller ) || isdefined( self.hordeclassgoliathcontroller ) )
        {
            self iclientprintlnbold( &"KILLSTREAKS_HEAVY_EXO_IN_USE" );
            return 0;
        }
    }

    var_2 = _id_6CD8( var_1 );
    return var_2;
}

_id_7466()
{
    var_0 = maps\mp\_utility::getkillstreakweapon( "heavy_exosuit" );
    self switchtoweapon( common_scripts\utility::getlastweapon() );
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_0 );
}

_id_1AE6()
{
    if ( self getstance() == "prone" || self getstance() == "crouch" )
        self setstance( "stand" );

    maps\mp\_utility::freezecontrolswrapper( 1 );
    var_0 = gettime() + 1500;

    while ( gettime() < var_0 && self getstance() != "stand" )
        waitframe();

    maps\mp\_utility::freezecontrolswrapper( 0 );
    return self getstance() == "stand";
}

_id_41EA( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    if ( maps\mp\perks\_perkfunctions::haslightarmor() )
        maps\mp\perks\_perkfunctions::unsetlightarmor();

    if ( maps\mp\_utility::_hasperk( "specialty_explosivebullets" ) )
        maps\mp\_utility::_unsetperk( "specialty_explosivebullets" );

    self.maxhealth = 125;

    if ( isdefined( level.ishorde ) && level.ishorde )
        self.maxhealth = 300 + 25 * self._id_4957;

    self.health = self.maxhealth;
    self.attackerlist = [];

    switch ( var_0 )
    {
        case "juggernaut_exosuit":
        default:
            var_2 = 1;
            var_3 = "juggernaut_exosuit";

            if ( !isdefined( var_1 ) || common_scripts\utility::array_contains( var_1, "heavy_exosuit_maniac" ) )
            {
                var_2 = 1.15;
                var_3 = "juggernaut_exosuit_maniac";
            }

            self.juggmovespeedscaler = var_2;
            _id_73E9();
            var_4 = isdefined( self.perks["specialty_hardline"] );
            maps\mp\gametypes\_class::giveandapplyloadout( self.pers["team"], var_3, 0, 0 );
            maps\mp\gametypes\_playerlogic::streamclassweapons( 0, 0, var_3 );
            self.isjuggernaut = 1;
            self.movespeedscaler = var_2;
            maps\mp\_utility::giveperk( "specialty_radarjuggernaut", 0 );

            if ( var_4 )
                maps\mp\_utility::giveperk( "specialty_hardline", 0 );

            thread _id_6D4B( var_1, var_0 );
            self.saved_lastweapon = self getweaponslistprimaries()[0];
            break;
    }

    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self disableweaponpickup();

    if ( !isdefined( var_1 ) || common_scripts\utility::array_contains( var_1, "heavy_exosuit_maniac" ) )
        self playsound( "goliath_suit_up_mp" );
    else
        self playsound( "goliath_suit_up_mp" );

    thread maps\mp\_utility::teamplayercardsplash( level.juggsettings[var_0]._id_8A67, self );
    thread juggremover();
    level notify( "juggernaut_equipped", self );
    maps\mp\_matchdata::logkillstreakevent( "juggernaut", self.origin );
}

juggernautsounds()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        wait 3.0;
        self playsound( "juggernaut_breathing_sound" );
    }
}

radarmover( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    self endon( "jugdar_removed" );

    for (;;)
    {
        var_0 moveto( self.origin, 0.05 );
        wait 0.05;
    }
}

juggremover()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    thread _id_52A8();
    common_scripts\utility::waittill_any( "death", "joined_team", "joined_spectators", "lost_juggernaut" );
    self enableweaponpickup();
    self.isjuggernaut = 0;
    common_scripts\utility::resetusability();
    self allowjump( 1 );
    self _meth_8119( 1 );
    self _meth_8302( 1 );
    self _meth_8303( 1 );
    self setdemigod( 0 );

    if ( isdefined( self.juggernautoverlay ) )
        self.juggernautoverlay destroy();

    self unsetperk( "specialty_radarjuggernaut", 1 );

    if ( isdefined( self.personalradar ) )
    {
        self notify( "jugdar_removed" );
        level maps\mp\gametypes\_portable_radar::deleteportableradar( self.personalradar );
        self.personalradar = undefined;
    }

    self notify( "jugg_removed" );
}

_id_52A8()
{
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level waittill( "game_ended" );

    if ( isdefined( self.juggernautoverlay ) )
        self.juggernautoverlay destroy();
}

_id_73E9()
{
    self._id_6F8A = common_scripts\utility::getlastweapon();

    foreach ( var_1 in self.weaponlist )
    {
        var_2 = maps\mp\_utility::getweaponnametokens( var_1 );

        if ( var_2[0] == "alt" )
        {
            self._id_74B1[var_1] = self getweaponammoclip( var_1 );
            self._id_74B3[var_1] = self getweaponammostock( var_1 );
            continue;
        }

        self._id_74B1[var_1] = self getweaponammoclip( var_1 );
        self._id_74B3[var_1] = self getweaponammostock( var_1 );
    }

    self._id_A2E4 = [];

    foreach ( var_1 in self.weaponlist )
    {
        var_2 = maps\mp\_utility::getweaponnametokens( var_1 );

        if ( var_2[0] == "alt" )
            continue;

        if ( maps\mp\_utility::iskillstreakweapon( var_1 ) )
            continue;

        self._id_A2E4[self._id_A2E4.size] = var_1;
        self takeweapon( var_1 );
    }
}

_id_6D4B( var_0, var_1 )
{
    var_2 = spawnstruct();
    self._id_4798 = var_2;
    var_2._id_8F22 = self;
    var_2._id_4722 = 1;
    var_2.modules = var_0;
    var_2._id_52AB = var_1;

    if ( isdefined( var_0 ) )
    {
        var_2.hasradar = common_scripts\utility::array_contains( var_0, "heavy_exosuit_radar" );
        var_2._id_4734 = common_scripts\utility::array_contains( var_0, "heavy_exosuit_maniac" );
        var_2._id_4733 = common_scripts\utility::array_contains( var_0, "heavy_exosuit_punch" );
        var_2._id_4749 = common_scripts\utility::array_contains( var_0, "heavy_exosuit_trophy" );
        var_2._id_473F = common_scripts\utility::array_contains( var_0, "heavy_exosuit_rockets" );
        var_2._id_472A = common_scripts\utility::array_contains( var_0, "heavy_exosuit_ammo" );
    }
    else
    {
        var_2.hasradar = 1;
        var_2._id_4734 = 1;
        var_2._id_4733 = 0;
        var_2._id_4749 = 1;
        var_2._id_473F = 1;
        var_2._id_472A = 1;
    }

    var_3 = 0;

    if ( var_2._id_473F )
        var_3 += 1;

    if ( var_2._id_4733 )
        var_3 += 2;

    if ( var_2.hasradar )
        var_3 += 4;

    if ( var_2._id_4749 )
        var_3 += 8;

    if ( var_2._id_4734 )
        var_3 += 16;

    if ( var_2._id_4722 )
        var_3 += 32;

    self setclientomnvar( "ui_exo_suit_modules_on", var_3 );
    maps\mp\_utility::playerallowpowerslide( 0, "heavyexo" );

    if ( !var_2._id_4734 )
    {
        maps\mp\_utility::playerallowdodge( 0, "heavyexo" );
        maps\mp\_utility::playerallowboostjump( 0, "heavyexo" );
        maps\mp\_utility::playerallowhighjump( 0, "heavyexo" );
        maps\mp\_utility::playerallowhighjumpdrop( 0, "heavyexo" );
    }

    common_scripts\utility::_disableusability();
    self allowjump( 0 );
    self _meth_8119( 0 );
    self _meth_8302( 0 );
    self _meth_8303( 0 );
    self.inliveplayerkillstreak = 1;
    self._id_5B1D = 125;

    if ( isdefined( level.ishorde ) && level.ishorde )
        self._id_5B1D = self.maxhealth;

    self setdemigod( 1 );
    self setclientomnvar( "ui_exo_suit_health", 1 );
    _id_6D48( var_2 );
    thread _id_6D52( var_2 );
    thread _id_6C6F( var_2 );
    thread _id_6C70();
    thread _id_6D36();
    thread _id_6CF0();
    thread _id_6CB3();
    thread _id_6955();
    thread _id_6D11();

    if ( isdefined( level.ishorde ) && level.ishorde )
        thread playermechtimeout();

    if ( var_2._id_4722 )
    {

    }

    if ( var_2.hasradar )
        level thread _id_832E( self, var_2 );

    if ( var_2._id_4734 )
    {
        level thread _id_831C( self );
        _id_7E6E( "offline" );
    }
    else
    {
        thread _id_6CB2();
        _id_7E6E( "ready" );
    }

    if ( var_2._id_4733 )
    {
        level thread _id_831B( self, var_2 );
        _id_7E70( "ready" );
        thread _id_6CF4();
    }
    else
    {
        _id_7E70( "offline" );

        if ( !var_2._id_4734 )
            self disableoffhandweapons();
    }

    if ( var_2._id_4749 )
        level thread _id_8339( self, var_2 );

    if ( var_2._id_473F )
    {
        level thread _id_8334( self, var_2 );
        _id_7E73( "ready" );
        thread _id_6CF5();
    }
    else
    {
        self _meth_84BF();
        _id_7E73( "offline" );
    }

    level thread _id_27EB( self );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "horde_cancel_goliath" );

    wait 5;

    if ( isdefined( self ) )
        thread _id_7C6C();
}

_id_6CB3()
{
    self._id_426D = 1;
    wait 4.16;
    self._id_426D = undefined;
}

juggernautmodifydamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !var_0 maps\mp\_utility::isjuggernaut() )
        return var_2;

    var_9 = var_2;

    if ( isdefined( var_3 ) && var_3 == "MOD_FALLING" )
        var_9 = 0;

    if ( isdefined( var_4 ) && var_4 == "boost_slam_mp" )
        var_9 = 20;

    if ( isdefined( var_1 ) && isdefined( var_0 ) && var_1 == var_0 && isdefined( var_4 ) && ( var_4 == "iw5_juggernautrockets_mp" || var_4 == "playermech_rocket_mp" ) )
        var_9 = 0;

    if ( isdefined( var_0._id_426D ) && var_0._id_426D )
    {
        if ( isdefined( level.ishorde ) && level.ishorde && var_3 == "MOD_TRIGGER_HURT" && var_0 maps\mp\_utility::touchingbadtrigger() )
            var_9 = 10000;
        else
            var_9 = 0;
    }

    if ( isdefined( var_1 ) && !maps\mp\gametypes\_weapons::friendlyfirecheck( var_0, var_1 ) )
        var_9 = 0;

    if ( var_9 > 0 )
    {
        if ( maps\mp\_utility::attackerishittingteam( var_0, var_1 ) )
        {
            if ( isdefined( level.juggernautmod ) )
                var_9 *= level.juggernautmod;
            else
                var_9 *= 0.08;
        }

        if ( isdefined( var_7 ) && var_7 == "head" )
            var_9 *= 4.0;

        if ( isdefined( var_4 ) && var_4 == "killstreak_goliathsd_mp" && isdefined( var_1 ) && isdefined( var_0 ) && var_1 == var_0 )
            var_9 = var_0._id_5B1D + 1;

        if ( isdefined( var_4 ) && var_4 == "nuke_mp" && isdefined( var_1 ) && isdefined( var_0 ) && var_1 != var_0 )
            var_9 = var_0._id_5B1D + 1;

        var_0._id_5B1D -= var_9;

        if ( isdefined( level.ishorde ) && level.ishorde )
            var_0 setclientomnvar( "ui_exo_suit_health", var_0._id_5B1D / var_0.maxhealth );
        else
            var_0 setclientomnvar( "ui_exo_suit_health", var_0._id_5B1D / 125 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
        {
            if ( isdefined( var_7 ) && var_7 == "head" )
                var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "headshot" );
            else
                var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "hitjuggernaut" );

            if ( var_0 maps\mp\gametypes\_damage::isnewattacker( var_1 ) )
                var_0.attackerlist[var_0.attackerlist.size] = var_1;
        }

        if ( var_0._id_5B1D < 0 )
        {
            if ( isdefined( level.ishorde ) && level.ishorde )
            {
                maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
                playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );
                self thread [[ level.hordehandlejuggdeath ]]();
            }
            else
                var_0 thread _id_6CD6( var_5, var_1, var_3, var_4, var_8 );
        }
    }

    return int( var_9 );
}

_id_6CD6( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "killHeavyExo" );
    self allowjump( 1 );
    self _meth_8119( 1 );
    self _meth_8302( 1 );
    self _meth_8303( 1 );
    self setdemigod( 0 );
    self.isjuggernaut = 0;
    var_5 = 1001;

    if ( !isdefined( var_0 ) )
        var_0 = self.origin;

    var_6 = 0;

    if ( isdefined( var_3 ) && isdefined( var_1 ) && isdefined( var_2 ) && isdefined( var_4 ) )
        var_6 = self dodamage( var_5, var_0, var_1, var_4, var_2, var_3 );
    else if ( isdefined( var_3 ) && isdefined( var_1 ) && isdefined( var_2 ) )
        var_6 = self dodamage( var_5, var_0, var_1, undefined, var_2, var_3 );
    else if ( isdefined( var_1 ) && isdefined( var_2 ) )
        var_6 = self dodamage( var_5, var_0, var_1, undefined, var_2 );
    else if ( isdefined( var_1 ) )
        var_6 = self dodamage( var_5, var_0, var_1, undefined );
    else
        var_6 = self dodamage( var_5, var_0 );
}

_id_27EB( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    var_1 = maps\mp\_utility::getkillstreakweapon( "heavy_exosuit" );
    var_0 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe( var_1 );
    var_0 giveweapon( "iw5_exominigun_mp" );
    var_0 switchtoweapon( "iw5_exominigun_mp" );
    var_0 notify( "waitTakeKillstreakWeapon" );
    waitframe();
    var_0 _meth_8494( 1 );
    var_0 disableweaponswitch();
}

_id_6C6F( var_0 )
{
    self endon( "disconnect" );
    self waittill( "death", var_1, var_2, var_3 );

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 != self && var_1.team != self.team )
    {
        var_1 maps\mp\_utility::incplayerstat( "goliath_destroyed", 1 );
        level thread maps\mp\gametypes\_rank::awardgameevent( "goliath_destroyed", var_1, var_3, self, var_2 );
    }

    if ( !isdefined( level.ishorde ) )
        maps\mp\_events::checkvandalismmedal( var_1 );

    self.inliveplayerkillstreak = undefined;
    self._id_5B1D = undefined;
    _id_6D2E( var_0 );
}

_id_6C70()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    level common_scripts\utility::waittill_any( "game_ended" );
    _id_6D32();
}

_id_6D2E( var_0 )
{
    self notify( "lost_juggernaut" );
    self notify( "exit_mech" );
    _id_6D32();
    maps\mp\_utility::playerallowdodge( 1, "heavyexo" );
    maps\mp\_utility::playerallowpowerslide( 1, "heavyexo" );
    maps\mp\_utility::playerallowboostjump( 1, "heavyexo" );
    maps\mp\_utility::playerallowhighjump( 1, "heavyexo" );
    self _meth_84C0();
    self enableoffhandweapons();
    self enableweaponswitch();
    self _meth_8494( 0 );
    self._id_74B1 = undefined;
    self._id_74B3 = undefined;
    self.juggernautweak = undefined;
    self._id_4798 = undefined;

    if ( isdefined( self._id_529F ) )
        self._id_529F = undefined;

    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0.hud )
        {
            if ( isdefined( var_2 ) )
            {
                var_2._id_92B9 = undefined;
                var_2.type = undefined;
                var_2 destroy();
            }
        }
    }
}

_id_6D32()
{
    self setclientomnvar( "ui_exo_suit_enabled", 0 );
    self setclientomnvar( "ui_exo_suit_modules_on", 0 );
    self setclientomnvar( "ui_exo_suit_health", 0 );
    self setclientomnvar( "ui_exo_suit_recon_cd", 0 );
    self setclientomnvar( "ui_exo_suit_punch_cd", 0 );
    self setclientomnvar( "ui_exo_suit_rockets_cd", 0 );
    self setclientomnvar( "ui_playermech_swarmrecharge", 0 );
    self setclientomnvar( "ui_playermech_rocketrecharge", 0 );
}

_id_6D48( var_0 )
{
    self detachall();
    self setmodel( "npc_exo_armor_mp_base" );
    self attach( "head_hero_cormack_sentinel_halo" );
    self setviewmodel( "vm_view_arms_mech_mp" );

    if ( isdefined( var_0 ) && !var_0._id_4734 || isdefined( level.ishorde ) )
        self attach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );

    if ( isai( self ) )
        self.hideondeath = 1;

    self notify( "goliath_equipped" );
}

_id_6CB2()
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    thread _id_6C6E();
    self notifyonplayercommand( "goliathAttack", "+attack" );
    self notifyonplayercommand( "goliathAttackDone", "-attack" );
    self._id_12E9 = spawn( "script_model", self gettagorigin( "tag_barrel" ) );
    self._id_12E9 setmodel( "generic_prop_raven" );
    self._id_12E9 linktosynchronizedparent( self, "tag_barrel", ( 12.7, 0.0, -2.9 ), ( 90.0, 0.0, 0.0 ) );
    self._id_12E4 = spawn( "script_model", self._id_12E9 gettagorigin( "j_prop_1" ) );
    self._id_12E4 setmodel( "npc_exo_armor_minigun_barrel" );
    self._id_12E4 linktosynchronizedparent( self._id_12E9, "j_prop_1", ( 0.0, 0.0, 0.0 ), ( -90.0, 0.0, 0.0 ) );

    if ( isdefined( level.ishorde ) && level.ishorde && isplayer( self ) )
        self._id_12E4 _meth_83FA( 5, 1 );

    self._id_12E9 scriptmodelplayanimdeltamotion( "mp_generic_prop_spin_02" );
    self._id_12E9 _meth_84BD( 1 );

    for (;;)
    {
        self waittill( "goliathAttack" );
        self._id_12E9 _meth_84BD( 0 );
        self waittill( "goliathAttackDone" );
        self._id_12E9 _meth_84BD( 1 );
    }
}

_id_6C6E()
{
    if ( isdefined( level.ishorde ) && level.ishorde )
        common_scripts\utility::waittill_any( "death", "disconnect", "becameSpectator" );
    else
        common_scripts\utility::waittill_any( "death", "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self._id_12E4 _meth_83FB();

    self._id_12E4 delete();
    self._id_12E9 delete();
}

_id_6D36()
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        self waittill( "grenade_pullback", var_0 );

        if ( var_0 == "playermech_rocket_mp" )
        {
            self notify( "mech_rocket_pullback" );
            self waittill( "grenade_fire", var_1 );
            self notify( "mech_rocket_fire", var_1 );
        }
        else if ( var_0 == "playermech_rocket_swarm_mp" || var_0 == "playermech_rocket_swarm_maniac_mp" )
        {
            self notify( "mech_swarm_pullback" );
            self waittill( "grenade_fire", var_1 );
            self notify( "mech_swarm_fire", var_1.origin );
            var_1 delete();
        }

        waitframe();
    }
}

_id_8301( var_0, var_1 )
{
    var_2 = var_1 gettagorigin( "tag_turret" );
    var_3 = _id_898C( "juggernaut_sentry_mg_mp", "npc_heavy_exo_armor_turret_base", var_2, 200, var_1, &"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST" );
    var_3 _meth_8065( "sentry_offline" );
    var_3 _meth_8103( var_1 );
    var_3 _meth_8156( 180 );
    var_3 _meth_8155( 180 );
    var_3 _meth_8157( 55 );
    var_3 _meth_8158( 30 );
    var_3 _meth_815A( 0.0 );
    var_3 _meth_817A( 1 );
    var_3 makeunusable();
    var_3 _meth_8136();
    var_3._id_7593 = 0;
    var_3._id_32CD = 0;
    var_3._id_99BD = "mg_turret";
    var_3.issentry = 0;
    var_3.stunned = 0;
    var_3._id_60DB = 5;
    var_3._id_4795 = 0;
    var_3._id_1316 = var_1;

    if ( level.teambased )
        var_3 _meth_8135( var_1.team );

    var_3 common_scripts\utility::make_entity_sentient_mp( var_1.team );
    var_3 maps\mp\killstreaks\_autosentry::_id_0855( var_3 getentitynumber() );
    var_3 thread maps\mp\killstreaks\_remoteturret::_id_9999();
    var_3 linkto( var_1, "tag_turret", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3.effect = _id_898D( var_2, var_1 );
    var_3.effect linkto( var_3, "tag_player", ( 29.0, -7.0, -6.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3.effect hide();
    var_0._id_21CA = var_3;
    thread _id_8F01( var_0, var_3, var_1 );
    thread _id_4650( var_0, var_3, var_1 );
    thread _id_4688( var_0, var_3, var_1 );
    return var_3;
}

_id_8F01( var_0, var_1, var_2 )
{
    var_1 waittill( "death" );

    if ( isdefined( var_1 ) )
    {
        var_1.issentry = 0;
        var_2 notify( "turretDead" );
        _id_7397( var_0 );
        _id_8EE2( var_1, common_scripts\utility::getfx( "green_light_mp" ), 1 );
        var_1 playsound( "sentry_explode" );
        var_1 thread maps\mp\killstreaks\_remoteturret::_id_7CBE();
        var_1 maps\mp\killstreaks\_autosentry::_id_73AF( var_1 getentitynumber() );
        var_1 _meth_8065( "sentry_offline" );
        var_1.damagecallback = undefined;
        var_1 setcandamage( 0 );
        var_1 setdamagecallbackon( 0 );
        var_1 freeentitysentient();
        var_1 _meth_815A( 35 );
        var_1 _meth_8103( undefined );
        level thread _id_2D89( var_1 );
    }
}

_id_4650( var_0, var_1, var_2 )
{
    var_1 endon( "death" );
    var_3 = weaponfiretime( "juggernaut_sentry_mg_mp" );

    for (;;)
    {
        if ( !isdefined( var_1.remotecontrolled ) || !var_1.remotecontrolled )
        {
            waitframe();
            continue;
        }

        if ( var_1.owner attackbuttonpressed() && !var_1 _meth_844F() )
        {
            var_1 _id_99B6( var_1._id_1316 );
            wait(var_3);
            continue;
        }

        waitframe();
    }
}

_id_99B5()
{
    self _meth_80EA();
    _id_99B6( self._id_1316 );
}

_id_99B6( var_0 )
{
    var_1 = self gettagorigin( "tag_flash" );
    var_2 = anglestoforward( self gettagangles( "tag_flash" ) );
    var_3 = var_1 + var_2 * 1000;
    var_4 = 0;
    self._id_60DB--;

    if ( self._id_60DB <= 0 )
    {
        var_4 = 1;
        self._id_60DB = 5;
    }

    randomcostume( var_1, var_3, "juggernaut_sentry_mg_mp", var_4, var_0 );
}

_id_2D89( var_0 )
{
    var_0 playsound( "sentry_explode" );
    playfxontag( common_scripts\utility::getfx( "sentry_explode_mp" ), var_0, "tag_aim" );
    wait 1.5;

    if ( !isdefined( var_0 ) )
        return;

    var_0 playsound( "sentry_explode_smoke" );

    for ( var_1 = 0; var_1 < 10; var_1++ )
    {
        playfxontag( common_scripts\utility::getfx( "sentry_smoke_mp" ), var_0, "tag_aim" );
        wait 0.4;

        if ( !isdefined( var_0 ) )
            return;
    }
}

_id_4688( var_0, var_1, var_2 )
{
    thread _id_0DFE( var_0, var_1, var_2 );
    _id_A0C6( var_2 );
    _id_8EE2( var_1, common_scripts\utility::getfx( "green_light_mp" ) );
    var_1 maps\mp\killstreaks\_autosentry::_id_73AF( var_1 getentitynumber() );
    var_1.issentry = 0;
    var_2 notify( "turretDead" );
    _id_7397( var_0 );
    var_1 delete();
}

_id_832E( var_0, var_1 )
{
    var_2 = var_0 gettagorigin( "tag_recon_back" );
    var_3 = _id_898C( "radar", "npc_heavy_exo_armor_recon_back_base", var_2, undefined, var_0 );
    var_3 linkto( var_0, "tag_recon_back", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_0 thread _id_6CBA( var_1, var_3 );
    _id_A0C6( var_0 );
    waitframe();
    var_3 delete();
}

_id_6CBA( var_0, var_1 )
{
    var_1 endon( "death" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "faux_spawn" );
    self endon( "joined_team" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    if ( !isbot( self ) )
        self notifyonplayercommand( "juggernautPing", "weapnext" );

    playfxontag( common_scripts\utility::getfx( "exo_ping_inactive" ), self, "J_SpineUpper" );

    for (;;)
    {
        self waittill( "juggernautPing" );
        _id_06F8();
        self setclientomnvar( "ui_exo_suit_recon_cd", 1 );
        wait 10;
        _id_262B();
        _id_A001( 5, "ui_exo_suit_recon_cd" );
    }
}

_id_06F8()
{
    thread stop_exo_ping();
    self setperk( "specialty_exo_ping", 1, 0 );
    self playlocalsound( "mp_exo_cloak_activate" );
    self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on( self, -1 );
    killfxontag( common_scripts\utility::getfx( "exo_ping_inactive" ), self, "J_SpineUpper" );
    playfxontag( common_scripts\utility::getfx( "exo_ping_active" ), self, "J_SpineUpper" );
}

_id_262B()
{
    self unsetperk( "specialty_exo_ping", 1 );
    self playlocalsound( "mp_exo_cloak_deactivate" );

    if ( isdefined( self.highlight_effect ) )
        maps\mp\_threatdetection::detection_highlight_hud_effect_off( self.highlight_effect );

    killfxontag( common_scripts\utility::getfx( "exo_ping_active" ), self, "J_SpineUpper" );
    playfxontag( common_scripts\utility::getfx( "exo_ping_inactive" ), self, "J_SpineUpper" );
}

stop_exo_ping()
{
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        common_scripts\utility::waittill_any( "death", "faux_spawn", "joined_team", "becameSpectator" );
    else
        common_scripts\utility::waittill_any( "death", "faux_spawn", "joined_team" );

    self unsetperk( "specialty_exo_ping", 1 );

    if ( isdefined( self.highlight_effect ) )
        maps\mp\_threatdetection::detection_highlight_hud_effect_off( self.highlight_effect );

    killfxontag( common_scripts\utility::getfx( "exo_ping_active" ), self, "J_SpineUpper" );
}

_id_831C( var_0 )
{
    var_1 = var_0 gettagorigin( "tag_maniac_l" );
    var_2 = _id_898C( "speedAttachment", "npc_heavy_exo_armor_maniac_l_base", var_1, undefined, var_0 );
    var_2 linkto( var_0, "tag_maniac_l", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_1 = var_0 gettagorigin( "tag_maniac_r" );
    var_3 = _id_898C( "speedAttachment", "npc_heavy_exo_armor_maniac_r_base", var_1, undefined, var_0 );
    var_3 linkto( var_0, "tag_maniac_r", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4 = var_0 gettagorigin( "tag_jetpack" );
    var_5 = _id_898C( "speedAttachment", "npc_heavy_exo_armor_jetpack_base", var_4, undefined, var_0 );
    var_5 linkto( var_0, "tag_jetpack", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    _id_A0C6( var_0 );
    _id_0DFF( var_2, var_0, "maniac", var_3 );
    _id_0DFF( var_5, var_0, "maniac" );
    waitframe();
    var_2 delete();
    var_3 delete();
    var_5 delete();
}

_id_831B( var_0, var_1 )
{
    var_0 setlethalweapon( "playermech_rocket_mp" );
    var_0 giveweapon( "playermech_rocket_mp" );
    var_2 = "tag_origin";
    var_0 thread _id_6D8D( var_1 );
    _id_A0C6( var_0 );
}

_id_6D8D( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        self waittill( "mech_rocket_fire", var_1 );
        playfxontag( common_scripts\utility::getfx( "lethal_rocket_wv" ), self, "TAG_WEAPON_RIGHT" );
        thread _id_7319( self, var_0 );
    }
}

_id_7319( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    _id_A001( 10, "ui_exo_suit_punch_cd" );
}

_id_6DD1( var_0 )
{
    self playlocalsound( "orbitalsupport_reload_40mm" );
}

_id_A001( var_0, var_1 )
{
    var_2 = 0;

    for (;;)
    {
        wait 0.05;
        var_2 += 0.05;
        var_3 = 1 - var_2 / var_0;
        var_3 = clamp( var_3, 0, 1 );
        self setclientomnvar( var_1, var_3 );

        if ( var_3 <= 0 )
            break;
    }
}

_id_8339( var_0, var_1 )
{
    var_2 = var_0 gettagorigin( "j_spine4" );
    var_3 = _id_898C( "trophy", "npc_heavy_exo_armor_trophy_l_base", var_2, undefined, var_0 );
    var_3.stunned = 0;
    var_3.ammo = 1;
    var_3 linkto( var_0, "tag_trophy_l", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_3.weaponname = "heavy_exo_trophy_mp";
    var_3 thread maps\mp\gametypes\_equipment::trophyactive( var_0, undefined, 1, var_3.weaponname );
    var_3 thread maps\mp\gametypes\_equipment::trophyaddlaser( 12, ( 90.0, 90.0, 270.0 ) );
    var_3 thread maps\mp\gametypes\_equipment::trophysetmindot( -0.087, ( 90.0, 90.0, 270.0 ) );
    level.trophies[level.trophies.size] = var_3;
    var_4 = _id_898C( "trophy", "npc_heavy_exo_armor_trophy_r_base", var_2, undefined, var_0 );
    var_4.stunned = 0;
    var_4.ammo = 1;
    var_4 linkto( var_0, "tag_trophy_r", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_4.weaponname = "heavy_exo_trophy_mp";
    var_4 thread maps\mp\gametypes\_equipment::trophyactive( var_0, undefined, 1, var_4.weaponname );
    var_4 thread maps\mp\gametypes\_equipment::trophyaddlaser( 6, ( 260.0, 90.0, 270.0 ) );
    var_4 thread maps\mp\gametypes\_equipment::trophysetmindot( -0.087, ( 260.0, 90.0, 270.0 ) );
    level.trophies[level.trophies.size] = var_4;
    var_3._id_65B1 = var_4;
    var_4._id_65B1 = var_3;
    _id_A0C6( var_0 );
    var_3 notify( "trophyDisabled" );
    var_4 notify( "trophyDisabled" );
    waitframe();

    if ( isdefined( var_3.laserent ) )
        var_3.laserent delete();

    if ( isdefined( var_4.laserent ) )
        var_4.laserent delete();

    var_3 delete();
    var_4 delete();
}

trophystunbegin()
{
    if ( self.stunned )
        return;

    self.stunned = 1;
    self._id_65B1.stunned = 1;
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "mine_stunned" ), var_0, "tag_origin" );
    thread _id_983B( var_0 );
    common_scripts\utility::waittill_notify_or_timeout( "death", 3 );
    self notify( "stunEnd" );
    stopfxontag( common_scripts\utility::getfx( "mine_stunned" ), var_0, "tag_origin" );
    waitframe();
    var_0 delete();

    if ( isdefined( self ) )
    {
        self.stunned = 0;
        self._id_65B1.stunned = 0;
    }
}

_id_983B( var_0 )
{
    self endon( "death" );
    self endon( "stunEnd" );

    for (;;)
    {
        var_0.origin = self.origin;
        waitframe();
    }
}

_id_8334( var_0, var_1 )
{
    var_2 = "playermech_rocket_swarm_mp";

    if ( var_1._id_4734 )
        var_2 = "playermech_rocket_swarm_maniac_mp";

    var_0 settacticalweapon( var_2 );
    var_0 giveweapon( var_2 );
    var_3 = "tag_origin";
    var_4 = var_0 gettagorigin( var_3 );
    var_5 = _id_898C( "rocketAttachment", "npc_heavy_exo_armor_missile_pack_base", var_4, undefined, var_0 );
    var_5._id_580D = 0;
    var_5._id_7314 = 0;
    var_5.rockets = [];
    var_5._id_4B4D = [];
    var_5 linkto( var_0, var_3, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_5 hide();
    var_0._id_758A = var_5;
    thread _id_783C( var_5, var_0 );
    var_0 thread _id_6D8E( var_5, var_1 );
    _id_A0C6( var_0, var_5 );
    waitframe();
    var_5 delete();
    var_0._id_758A = undefined;
}

_id_783C( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_1 endon( "becameSpectator" );

    for (;;)
    {
        waitframe();

        if ( var_0._id_7314 || var_0.rockets.size > 0 || var_0._id_580D )
            continue;

        var_2 = _id_3F14( var_1, 4 );

        if ( isdefined( var_2 ) )
        {
            if ( !isdefined( var_0._id_32C4 ) || var_0._id_32C4 != var_2 )
                thread _id_59CC( var_0, var_1, var_2 );

            continue;
        }

        if ( isdefined( var_0._id_32C4 ) )
        {
            var_0 notify( "unmark" );
            var_0._id_32C4 = undefined;
        }
    }
}

_id_6CD2()
{
    return isdefined( self._id_758A ) && isdefined( self._id_758A._id_7314 ) && self._id_758A._id_7314;
}

_id_6CD3()
{
    return isdefined( self._id_758A ) && isdefined( self._id_758A._id_32C4 );
}

_id_3F14( var_0, var_1 )
{
    var_2 = 0.843391;
    var_3 = anglestoforward( var_0 getangles() );
    var_4 = var_0 geteye();
    var_5 = undefined;
    var_6 = [];

    foreach ( var_8 in level.participants )
    {
        if ( var_8.team == var_0.team )
            continue;

        if ( !maps\mp\_utility::isreallyalive( var_8 ) )
            continue;

        var_9 = var_8 geteye();
        var_10 = vectornormalize( var_9 - var_4 );
        var_11 = vectordot( var_3, var_10 );

        if ( var_11 > var_2 )
        {
            var_6[var_6.size] = var_8;
            var_8.dot = var_11;
            var_8._id_1CFB = 0;
        }
    }

    if ( var_6.size == 0 )
        return;

    for ( var_13 = 0; var_13 < var_1 && var_13 < var_6.size; var_13++ )
    {
        var_14 = _id_3FC4( var_6 );
        var_14._id_1CFB = 1;
        var_15 = var_4;
        var_16 = var_14 geteye();
        var_17 = sighttracepassed( var_15, var_16, 1, var_0, var_14 );

        if ( var_17 )
        {
            var_5 = var_14;
            break;
        }
    }

    foreach ( var_8 in level.participants )
    {
        var_8.dot = undefined;
        var_8._id_1CFB = undefined;
    }

    return var_5;
}

_id_3FC4( var_0 )
{
    if ( var_0.size == 0 )
        return;

    var_1 = undefined;
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        if ( !var_4._id_1CFB && var_4.dot > var_2 )
        {
            var_1 = var_4;
            var_2 = var_4.dot;
        }
    }

    return var_1;
}

_id_6D8E( var_0, var_1 )
{
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( "mech_swarm_fire", var_2 );

        if ( var_0._id_7314 || var_0._id_580D )
        {
            waitframe();
            continue;
        }

        thread _id_4662( var_0, var_1 );
        thread _id_731A( var_0, self, var_1 );
        thread _id_37E4( var_0, self, var_2 );
    }
}

_id_4662( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0._id_580D = 1;
    var_0 notify( "lockedTarget" );
    _id_A0EA( var_0 );

    if ( isdefined( var_0 ) )
    {
        var_0._id_580D = 0;
        var_0._id_32C4 = undefined;
    }
}

_id_37E4( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_1 getangles() );
    var_4 = anglestoright( var_1 getangles() );
    var_5 = [ ( 0.0, 0.0, 50.0 ), ( 0.0, 0.0, 20.0 ), ( 10.0, 0.0, 0.0 ), ( 0.0, 10.0, 0.0 ) ];
    playfxontag( common_scripts\utility::getfx( "swarm_rocket_wv" ), var_1, "TAG_ROCKET4" );

    for ( var_6 = 0; var_6 < 4; var_6++ )
    {
        var_7 = var_2 + var_3 * 20 + var_4 * -30;
        var_8 = var_3 + _id_7117( 0.2 );
        var_9 = magicbullet( "iw5_juggernautrockets_mp", var_7, var_7 + var_8, var_1 );
        var_0.rockets = common_scripts\utility::array_add( var_0.rockets, var_9 );
        var_9 thread _id_7592( var_0, var_0._id_32C4, var_5[var_6] );
        var_9 thread _id_758C( 7 );
    }
}

_id_7592( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( isdefined( var_1 ) )
        self missile_settargetent( var_1, var_2 );

    self waittill( "death" );
    var_0.rockets = common_scripts\utility::array_remove( var_0.rockets, self );
}

_id_758C( var_0 )
{
    self endon( "death" );
    wait(var_0);
    self delete();
}

_id_731A( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_0._id_7314 = 1;
    _id_A001( 10, "ui_exo_suit_rockets_cd" );
    var_0._id_7314 = 0;
}

_id_6DD2( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_3 = 3;
    self playlocalsound( "warbird_missile_reload_bed" );
    wait 0.5;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        self playlocalsound( "warbird_missile_reload" );
        wait(var_2 / var_3);
    }
}

_id_59CC( var_0, var_1, var_2 )
{
    var_2 endon( "disconnect" );
    var_0 notify( "mark" );
    var_0 endon( "mark" );
    var_0 endon( "unmark" );
    var_3 = ( 0.0, 0.0, 60.0 );
    var_4 = var_2 getentitynumber();
    var_0._id_32C4 = var_2;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_2 hudoutlineenableforclient( var_1, 1, 0 );
        var_1.markedformech[var_1.markedformech.size] = var_2;
    }
    else
        var_2 hudoutlineenableforclient( var_1, 4, 0 );

    thread _id_1E8F( var_0, var_2, var_1 );
    var_0 waittill( "lockedTarget" );
    var_2 hudoutlineenableforclient( var_1, 0, 0 );
    _id_A0EA( var_0 );

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( level._id_2509 < 3 )
        {
            if ( level._id_62DC && distancesquared( var_1.origin, level._id_250F.origin ) > 640000 )
                var_2 hudoutlineenableforclient( var_1, level._id_32B6, 0 );

            var_1.markedformech = common_scripts\utility::array_remove( var_1.markedformech, var_2 );
        }
        else
        {
            var_2 hudoutlinedisableforclient( var_1 );
            var_1.markedformech = common_scripts\utility::array_remove( var_1.markedformech, var_2 );
        }
    }
    else
        var_2 hudoutlinedisableforclient( var_1 );
}

_id_1E8F( var_0, var_1, var_2 )
{
    var_1 endon( "disconnect" );
    _id_A0F0( var_0 );

    if ( isdefined( level.ishorde ) && level.ishorde && isdefined( var_2 ) )
    {
        if ( level._id_2509 < 3 )
        {
            if ( level._id_62DC && distancesquared( var_2.origin, level._id_250F.origin ) > 640000 )
                var_1 hudoutlineenableforclient( var_2, level._id_32B6, 0 );

            var_2.markedformech = common_scripts\utility::array_remove( var_2.markedformech, var_1 );
        }
        else
        {
            var_1 hudoutlinedisableforclient( var_2 );
            var_2.markedformech = common_scripts\utility::array_remove( var_2.markedformech, var_1 );
        }
    }
    else if ( isdefined( var_2 ) )
        var_1 hudoutlinedisableforclient( var_2 );
}

_id_A0F0( var_0 )
{
    var_0._id_32C4 endon( "death" );
    var_0 common_scripts\utility::waittill_any( "death", "mark", "unmark" );
}

_id_A0EA( var_0 )
{
    wait 0.1;

    while ( isdefined( var_0 ) && var_0.rockets.size > 0 )
        waitframe();
}

_id_A0C6( var_0, var_1, var_2 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    if ( isdefined( var_1 ) )
        var_1 endon( "death" );

    if ( isdefined( var_2 ) )
        var_2 endon( "death" );

    var_0 waittill( "forever" );
}

_id_27E9( var_0, var_1 )
{
    var_0 endon( "death" );
    waitframe();
    waitframe();
    playfxontag( var_1, var_0, "tag_origin" );
}

_id_8EE2( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.effect ) )
    {
        stopfxontag( var_1, var_0.effect, "tag_origin" );

        if ( isdefined( var_2 ) && var_2 )
            playfx( common_scripts\utility::getfx( "juggernaut_sparks" ), var_0.effect.origin );

        var_0.effect delete();
    }
}

_id_0DFE( var_0, var_1, var_2, var_3 )
{
    var_2 endon( "death" );
    var_2 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_2 endon( "becameSpectator" );

    if ( isdefined( var_3 ) )
        var_3 endon( "death" );

    var_1 waittill( "death", var_4, var_5, var_6 );

    if ( isdefined( var_4 ) && isplayer( var_4 ) )
    {
        var_7 = level.juggsettings[var_0._id_52AB]._id_8A5F;

        if ( issubstr( var_1._id_0E06, "weakSpot" ) )
            var_7 = level.juggsettings[var_0._id_52AB]._id_8A68;

        maps\mp\_utility::teamplayercardsplash( var_7, var_4 );
    }
}

_id_0DFF( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1 ) )
    {
        if ( isalive( var_1 ) )
            var_1 thread _id_6D21( var_0._id_0E06 );

        if ( isdefined( var_0 ) )
            playfx( common_scripts\utility::getfx( "juggernaut_sparks" ), var_0.origin );

        if ( isdefined( var_3 ) )
            playfx( common_scripts\utility::getfx( "juggernaut_sparks" ), var_3.origin );

        var_1 playsound( "sentry_explode" );
    }
}

_id_4871( var_0 )
{
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( var_2 != var_0 )
            self showtoplayer( var_2 );
    }
}

_id_4872( var_0 )
{
    self hide();

    foreach ( var_2 in level.players )
    {
        if ( !common_scripts\utility::array_contains( var_0, var_2 ) )
            self showtoplayer( var_2 );
    }
}

_id_898C( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = undefined;

    if ( issubstr( var_0, "sentry" ) )
        var_6 = spawnturret( "misc_turret", var_2, var_0 );
    else
        var_6 = spawn( "script_model", var_2 );

    var_6 setmodel( var_1 );
    var_6._id_0E06 = var_0;

    if ( isdefined( var_3 ) )
    {
        var_6.health = var_3;
        var_6.maxhealth = var_6.health;
        var_6.damagecallback = ::_id_4647;

        if ( isdefined( var_5 ) )
            var_6 thread _id_4648( var_0, var_4, var_5 );

        var_6 setdamagecallbackon( 1 );
    }

    var_6 _id_4871( var_4 );
    var_6.owner = var_4;

    if ( level.teambased )
        var_6.team = var_4.team;

    return var_6;
}

_id_898D( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = spawn( "script_model", var_0 );
    var_3 setmodel( "tag_origin" );
    var_3 _id_4871( var_1 );
    thread _id_27E9( var_3, common_scripts\utility::getfx( "green_light_mp" ) );
    return var_3;
}

_id_4648( var_0, var_1, var_2 )
{
    if ( var_0 == "weakSpotHead" )
        return;

    level endon( "game_ended" );
    self waittill( "death", var_3, var_4, var_5 );

    if ( !isdefined( var_3 ) || !isplayer( var_3 ) || isdefined( var_1 ) && var_3 == var_1 )
        return;

    level thread maps\mp\gametypes\_rank::awardgameevent( "heavy_exo_attachment", var_3, undefined, undefined, undefined, var_2 );
}

_id_4647( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( self.lasttimedamaged ) )
        self.lasttimedamaged = 0;

    var_12 = var_2;

    if ( isdefined( var_1 ) && !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) || var_1 == self.owner || self.lasttimedamaged == gettime() )
        var_12 = 0;
    else
    {
        if ( isdefined( var_5 ) && var_5 == "boost_slam_mp" && var_2 > 10 )
            var_12 = 10;

        if ( maps\mp\_utility::ismeleemod( var_4 ) )
            var_12 += self.maxhealth;

        if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
            self.wasdamagedfrombulletpenetration = 1;

        self.wasdamaged = 1;
        self._id_259B = 0.0;

        if ( isplayer( var_1 ) )
        {
            if ( var_1 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) )
                var_12 *= level.armorpiercingmod;

            var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "juggernautAttachment" );
            var_1 notify( "hitHeavyExoAttachment" );
            self.lastattacker = var_1;
        }

        if ( isdefined( var_5 ) )
        {
            var_13 = maps\mp\_utility::strip_suffix( var_5, "_lefthand" );

            switch ( var_13 )
            {
                case "remotemissile_projectile_mp":
                case "stinger_mp":
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                    self.largeprojectiledamage = 1;
                    var_12 = self.maxhealth + 1;
                    break;
                case "artillery_mp":
                case "stealth_bomb_mp":
                    self.largeprojectiledamage = 0;
                    var_12 += var_2 * 4;
                    break;
                case "bomb_site_mp":
                case "emp_grenade_mp":
                case "emp_grenade_var_mp":
                case "emp_grenade_killstreak_mp":
                    self.largeprojectiledamage = 0;
                    var_12 = self.maxhealth + 1;
                    break;
            }

            maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_5, self );
        }
    }

    self.lasttimedamaged = gettime();
    self finishentitydamage( var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
}

_id_7117( var_0 )
{
    return ( randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5, randomfloat( var_0 ) - var_0 * 0.5 );
}

_id_464F( var_0, var_1 )
{
    for (;;)
    {
        var_2 = maps\mp\killstreaks\_coop_util::_id_7017( var_1.team, &"MP_JOIN_HEAVY_EXO", "heavy_exosuit_coop_offensive", "assist_mp_goliath", "copilot_mp_goliath", var_1 );
        level thread _id_A21B( var_2, var_1, var_0 );
        var_3 = _id_A0E3( var_1, "buddyJoinedStreak" );
        maps\mp\killstreaks\_coop_util::_id_8EF9( var_2 );

        if ( !isdefined( var_3 ) )
            return;

        var_3 = _id_A0E3( var_1, "buddyLeftCoopTurret" );

        if ( !isdefined( var_3 ) )
            return;
    }
}

_id_A0E3( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 endon( "turretDead" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    return var_0 common_scripts\utility::waittill_any_return_no_endon_death( var_1, var_2, var_3 );
}

_id_A0EF( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 endon( "turretDead" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_1 endon( "becameSpectator" );

    for (;;)
    {
        waitframe();

        if ( var_0._id_21CA.stunned || var_0._id_21CA._id_2A6A )
            continue;

        return 1;
    }
}

_id_A21B( var_0, var_1, var_2 )
{
    var_1 endon( "disconnect" );
    var_1 endon( "death" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_1 endon( "becameSpectator" );

    var_3 = maps\mp\killstreaks\_coop_util::_id_A0C9( var_0 );
    var_1 notify( "buddyJoinedStreak" );
    var_3 thread _id_6D2A( var_2 );
}

_id_6D2A( var_0 )
{
    self endon( "disconnect" );
    var_0._id_21CA endon( "death" );
    var_0._id_8F22 endon( "death" );
    var_0._id_8F22 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        self endon( "becameSpectator" );
        var_0._id_8F22 endon( "becameSpectator" );
    }

    var_0._id_21CA _meth_8103( undefined );
    var_0._id_21CA _meth_8103( self );
    var_0._id_21CA.owner = self;
    var_0._id_21CA.effect _id_4872( [ self, var_0._id_8F22 ] );
    self.using_remote_turret = 1;
    var_0._id_21CA maps\mp\killstreaks\_remoteturret::_id_8D41( 180, 180, 55, 30, 1 );
    thread _id_7398( var_0 );
    var_0._id_21CA maps\mp\killstreaks\_remoteturret::_id_A0E6();
    _id_7397( var_0 );
}

_id_7398( var_0 )
{
    var_0._id_21CA endon( "removeCoopTurretBuddy" );
    self waittill( "disconnect" );
    thread _id_7397( var_0 );
}

_id_7397( var_0 )
{
    if ( !isdefined( var_0._id_21CA.remotecontrolled ) )
        return;

    var_0._id_21CA notify( "removeCoopTurretBuddy" );
    var_0._id_21CA.remotecontrolled = undefined;
    var_1 = var_0._id_21CA.owner;

    if ( isdefined( var_1 ) )
    {
        var_1.using_remote_turret = undefined;
        var_0._id_21CA maps\mp\killstreaks\_remoteturret::_id_8F02( 0 );
    }
    else if ( isalive( var_0._id_21CA ) )
    {

    }

    var_1 enableweaponswitch();

    if ( isdefined( var_0._id_8F22 ) && maps\mp\_utility::isreallyalive( var_0._id_8F22 ) )
    {
        if ( isdefined( var_0._id_21CA.effect ) )
            var_0._id_21CA.effect hide();

        var_0._id_21CA _meth_8103( undefined );
        var_0._id_21CA _meth_8103( var_0._id_8F22 );
        var_0._id_21CA.owner = var_0._id_8F22;
        var_0._id_8F22 notify( "buddyLeftCoopTurret" );
    }
}

_id_6D52( var_0 )
{
    var_0.hud = [];
    thread _id_6D8A( var_0 );
    _id_2423( var_0 );
}

_id_2423( var_0 )
{
    self setclientomnvar( "ui_exo_suit_enabled", 1 );
    thread _id_6D03();
}

_id_6D8A( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "emp_grenaded", "applyEMPkillstreak", "directHackStarted" );

        foreach ( var_2 in var_0.hud )
            var_2.alpha = 0;

        for (;;)
        {
            common_scripts\utility::waittill_any( "empGrenadeTimedOut", "removeEMPkillstreak", "directHackTimedOut" );
            waitframe();

            if ( _id_6D50() )
                break;
        }

        foreach ( var_2 in var_0.hud )
        {
            if ( var_2.type != "rocketReload" )
            {
                var_2 fadeovertime( 0.5 );
                var_2.alpha = 1;
            }
        }
    }
}

_id_6D50()
{
    return !isdefined( self.empgrenaded ) || !self.empgrenaded || !isdefined( self._id_3089 ) || !self._id_3089;
}

_id_6D21( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "juggernaut_sentry_mp_mp":
            var_1 = "sntryoff_mp_exoai";
            break;
        case "speedAttachment":
            var_1 = "mancoff_mp_exoai";
            break;
        case "punchAttachment":
            var_1 = "longoff_mp_exoai";
            break;
        case "radar":
            var_1 = "rcnoff_mp_exoai";
            break;
        case "rocketAttachment":
            var_1 = "rcktoff_mp_exoai";
            break;
        case "trophy":
            var_1 = "trphyoff_mp_exoai";
            break;
        default:
            var_1 = "weakdmg_mp_exoai";
            break;
    }

    maps\mp\_utility::leaderdialogonplayer( var_1 );
}

_id_6CD8( var_0 )
{
    var_1 = maps\mp\killstreaks\_orbital_util::_id_6CAA();

    if ( !isdefined( var_1 ) )
    {
        thread maps\mp\killstreaks\_orbital_util::_id_6D22( common_scripts\utility::getfx( "ocp_ground_marker_bad" ) );
        self setclientomnvar( "ui_invalid_goliath", 1 );
        return 0;
    }

    thread _id_37D3( var_1, var_0 );
    return 1;
}

droppodmovenearbyallies( var_0 )
{
    if ( !isdefined( self ) || !isdefined( var_0 ) )
        return;

    self._id_9A55 = getnodesinradius( self.origin, 300, 80, 200 );

    foreach ( var_2 in level.characters )
    {
        if ( !isalive( var_2 ) )
            continue;

        if ( _func_285( var_2, var_0 ) )
        {
            if ( distancesquared( self.origin, var_2.origin ) < 6000 )
                maps\mp\_movers::_id_9A54( var_2, 1 );
        }
    }
}

givebackgoliathstreak( var_0 )
{
    var_1 = maps\mp\killstreaks\_killstreaks::getstreakcost( "heavy_exosuit" );
    var_2 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex( "heavy_exosuit", 0 );
    thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( "heavy_exosuit", var_1, undefined, var_0, var_2 );
    thread maps\mp\killstreaks\_killstreaks::givekillstreak( "heavy_exosuit", 0, 0, self, var_0 );
}

_id_37D3( var_0, var_1 )
{
    var_2 = maps\mp\killstreaks\_orbital_util::_id_6CA9( var_0 );
    var_3 = var_0.origin;
    var_4 = magicbullet( "orbital_carepackage_droppod_mp", var_2, var_3, self, 0, 1 );
    var_4.team = self.team;
    var_4.killcament = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_4.killcament linktosynchronizedparent( var_4, "tag_origin", ( 0.0, 0.0, 200.0 ), ( 0.0, 10.0, 10.0 ) );
    var_4.killcament.targetname = "killCamEnt_goliath_droppod";
    var_4.killcament setscriptmoverkillcam( "missile" );
    var_4 thread maps\mp\_load::_id_284B();
    var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_5, "invisible", ( 0.0, 0.0, 0.0 ) );
    objective_position( var_5, var_3 );
    objective_state( var_5, "active" );
    var_6 = "compass_waypoint_farp";
    objective_icon( var_5, var_6 );
    var_7 = spawn( "script_model", var_3 + ( 0.0, 0.0, 5.0 ) );
    var_7.angles = ( -90.0, 0.0, 0.0 );
    var_7 setmodel( "tag_origin" );
    var_7 hide();
    var_7 showtoplayer( self );
    playfxontag( common_scripts\utility::getfx( "jugg_droppod_marker" ), var_7, "tag_origin" );
    maps\mp\killstreaks\_orbital_util::_id_07DF( var_7 );
    var_8 = 0;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( self.killstreakindexweapon == 1 )
        {
            self notify( "used_horde_goliath" );
            var_8 = 1;
            self.hordeclassgoliathpodinfield = 1;
        }

        self.hordegoliathpodinfield = 1;
    }

    var_4 waittill( "death" );

    if ( distancesquared( var_4.origin, var_3 ) > 22500 )
    {
        var_7 delete();
        maps\mp\_utility::_objective_delete( var_5 );

        if ( !isdefined( level.ishorde ) || !level.ishorde )
            givebackgoliathstreak( var_1 );
        else
        {
            self [[ level.hordegivebackgoliath ]]( var_8 );
            self.hordeclassgoliathpodinfield = undefined;
            self.hordegoliathpodinfield = undefined;
        }

        return;
    }

    var_3 = getgroundposition( var_4.origin + ( 0.0, 0.0, 8.0 ), 20 );
    thread destroy_nearby_turrets( var_3 );
    var_7 hide();
    earthquake( 0.4, 1, var_3, 800 );
    playrumbleonposition( "artillery_rumble", var_3 );
    stopfxontag( common_scripts\utility::getfx( "jugg_droppod_marker" ), var_7, "tag_origin" );
    var_9 = spawn( "script_model", var_3 );
    var_9.angles = ( 0.0, 0.0, 0.0 );
    var_9 _id_23F2( var_3 );
    var_9.targetname = "care_package";
    var_9._id_2F75 = 0;
    var_9._id_24C7 = var_5;
    var_10 = spawn( "script_model", var_3 );
    var_10.angles = ( 90.0, 0.0, 0.0 );
    var_10.targetname = "goliath_pod_model";
    var_10 setmodel( "vehicle_drop_pod" );
    var_10 thread _id_458D( var_9 );

    if ( isdefined( self ) )
        var_9.owner = self;

    var_9._id_2383 = "juggernaut";
    var_9._id_2F97 = "juggernaut";
    var_9 thread _id_2168();
    var_9 sethintstring( &"KILLSTREAKS_HEAVY_EXO_PICKUP" );
    var_9 thread maps\mp\killstreaks\_airdrop::_id_237B();
    var_9 thread maps\mp\killstreaks\_airdrop::_id_237C();
    var_9 thread _id_9BF8();
    var_11 = spawnstruct();
    var_11._id_9BF6 = var_9;
    var_11._id_6A3B = 1;
    var_11.deathoverridecallback = ::_id_5FA4;
    var_11._id_9403 = ::_id_5FA5;
    var_9 thread maps\mp\_movers::handle_moving_platforms( var_11 );
    var_9 thread _id_458E( var_8 );
    var_9 droppodmovenearbyallies( self );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_9 disconnectpaths();

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        if ( level._id_A3D0 || level.teamemped["allies"] )
            var_9 _id_2851();
        else
            var_9 thread delete_goliath_drop_pod_for_event( self );
    }

    var_12 = var_9 _id_6D83();

    if ( isdefined( level.ishorde ) && level.ishorde && isdefined( self ) )
    {
        if ( isdefined( var_12 ) && var_12 != self )
        {
            if ( var_8 )
            {
                var_12.hordeclassgoliathowner = self;
                self.hordeclassgoliathcontroller = var_12;
            }
            else
            {
                var_12.hordegoliathowner = self;
                self.hordegoliathcontroller = var_12;
            }

            var_12 [[ level.laststandsaveloadoutinfo ]]( 1, 1, 1 );
        }
        else
            self [[ level.laststandsaveloadoutinfo ]]( 1, 1, 1 );

        self.hordeclassgoliathpodinfield = undefined;
        self.hordegoliathpodinfield = undefined;
    }

    if ( isdefined( var_12 ) && isalive( var_12 ) )
    {
        maps\mp\gametypes\_gamelogic::sethasdonecombat( var_12, 1 );
        self notify( "entering_juggernaut" );
        var_12.enteringgoliath = 1;
        var_12 takeallweapons();
        var_12 giveweapon( "iw5_combatknifegoliath_mp", 0, 0, 0, 1 );
        var_12 switchtoweapon( "iw5_combatknifegoliath_mp" );
        var_12 unlink();
        var_12 maps\mp\_utility::freezecontrolswrapper( 1 );
        var_13 = var_3 - var_12.origin;
        var_14 = vectortoangles( var_13 );
        var_15 = ( 0, var_14[1], 0 );
        var_16 = rotatevector( var_13, ( 45.0, 0.0, 0.0 ) );
        var_17 = spawn( "script_model", var_3 );
        var_17.angles = var_15;
        var_17 setmodel( "npc_exo_armor_ingress" );
        var_17 scriptmodelplayanimdeltamotion( "mp_goliath_spawn" );
        var_12 maps\mp\_snd_common_mp::snd_message( "goliath_pod_burst" );

        if ( isdefined( var_9 ) )
            var_9 _id_2851( 0 );

        playfx( level._effect["jugg_droppod_open"], var_3, var_16 );
        wait 0.1;
        var_12 _id_501D( var_17, var_3 );

        if ( isdefined( var_12 ) && isalive( var_12 ) && !( isdefined( level.ishorde ) && level.ishorde && isdefined( var_12._id_51B2 ) && var_12._id_51B2 ) )
        {
            var_12 setorigin( var_3, 1 );
            var_12 setangles( var_17.angles );
            var_12 enableweapons();
            var_12 _id_41EA( "juggernaut_exosuit", var_1 );
            var_17 delete();
            var_12 _meth_8517();

            if ( isdefined( level.ishorde ) && level.ishorde )
                var_12.enteringgoliath = undefined;

            wait 1;
            var_12.enteringgoliath = undefined;
            var_12 maps\mp\_utility::freezecontrolswrapper( 0 );

            if ( isdefined( level.ishorde ) && level.ishorde )
                var_12 _meth_83FA( 5, 1 );
        }
        else
            var_17 delete();
    }

    var_7 delete();
}

destroy_nearby_turrets( var_0 )
{
    var_1 = 4096;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3.turret ) && distancesquared( var_3.turret.origin, var_0 ) <= var_1 )
            var_3.turret notify( "death" );
    }
}

is_goliath_drop_pod( var_0 )
{
    return isdefined( var_0._id_2383 ) && var_0._id_2383 == "juggernaut" && isdefined( var_0._id_2F97 ) && var_0._id_2F97 == "juggernaut";
}

_id_5FA4( var_0 )
{
    if ( isdefined( self ) && isdefined( self._id_24C7 ) )
        maps\mp\_utility::_objective_delete( self._id_24C7 );

    if ( isdefined( var_0._id_3095 ) )
        var_0._id_3095 delete();

    if ( isdefined( var_0._id_9BF6 ) )
        var_0._id_9BF6 delete();
}

_id_5FA5( var_0 )
{
    return _id_4268( var_0 ) && _id_4269( var_0 ) && _id_426A( var_0 );
}

_id_4268( var_0 )
{
    return !isdefined( self._id_2383 ) || !isdefined( var_0.targetname ) || self._id_2383 != "juggernaut" || var_0.targetname != "care_package";
}

_id_4269( var_0 )
{
    return !isdefined( self._id_2383 ) || !isdefined( var_0._id_2383 ) || self._id_2383 != "juggernaut" || var_0._id_2383 != "juggernaut";
}

_id_426A( var_0 )
{
    return !isdefined( self._id_2383 ) || !isdefined( var_0._id_1B9E ) || self._id_2383 != "juggernaut" || !var_0._id_1B9E;
}

_id_2168()
{
    self endon( "captured" );
    self endon( "death" );
    level endon( "game_ended" );
    self makeusable();

    foreach ( var_1 in level.players )
        self disableplayeruse( var_1 );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            var_4 = 0;

            if ( var_1 isonground() && !var_1 isonladder() && !var_1 isjumping() && !var_1 ismantling() && maps\mp\_utility::isreallyalive( var_1 ) && var_1 getstance() == "stand" )
            {
                if ( distancesquared( self.origin, var_1.origin ) < 6000 )
                {
                    if ( var_1 _meth_8215( self.origin + ( 0.0, 0.0, 50.0 ), 65, 400, 600 ) )
                        var_4 = 1;
                }
            }

            if ( var_4 == 1 )
            {
                self enableplayeruse( var_1 );
                continue;
            }

            self disableplayeruse( var_1 );
        }

        wait 0.2;
    }
}

_id_501D( var_0, var_1 )
{
    var_2 = anglestoforward( var_0.angles );
    var_1 -= var_2 * 37;
    self setorigin( var_1, 0 );
    self setangles( var_0.angles );
    wait 0.05;
    var_0 scriptmodelplayanimdeltamotion( "mp_goliath_enter" );
    self _meth_8516();
    wait 2.3;
}

_id_23F2( var_0 )
{
    var_1 = getent( "goliath_collision", "targetname" );

    if ( isdefined( var_1 ) )
        self clonebrushmodeltoscriptmodel( var_1 );
}

_id_6D83()
{
    self endon( "death" );
    self waittill( "captured", var_0 );
    var_0 setstance( "stand" );
    var_0 setdemigod( 1 );

    if ( isdefined( self.owner ) && var_0 != self.owner )
    {
        if ( !level.teambased || var_0.team != self.owner.team )
            var_0 thread maps\mp\_events::hijackerevent( self.owner );
        else if ( !isdefined( level.ishorde ) )
            self.owner thread maps\mp\_events::sharedevent();
    }

    return var_0;
}

_id_9BF8()
{
    self endon( "death" );
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( var_1 maps\mp\_utility::isjuggernaut() )
        {
            self disableplayeruse( var_1 );
            thread _id_9C05( var_1 );
        }
    }

    for (;;)
    {
        level waittill( "juggernaut_equipped", var_1 );
        self disableplayeruse( var_1 );
        thread _id_9C05( var_1 );
    }
}

_id_9C05( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    var_0 endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    var_0 waittill( "death" );
    self enableplayeruse( var_0 );
}

_id_0861( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_4 ) )
        var_4 = ( 0.0, 0.0, 0.0 );

    thread _id_2DE3( var_2, var_0 );
    setdvar( "scr_adjust_angles", "" + var_4 );
    setdvar( "scr_adjust_origin", "" + var_3 );
    var_5 = ( 0.0, 0.0, 0.0 );
    var_6 = ( 0.0, 0.0, 0.0 );

    for (;;)
    {
        waitframe();
        var_7 = getdvarvector( "scr_adjust_angles" );
        var_8 = getdvarvector( "scr_adjust_origin" );

        if ( var_7 == var_5 && var_8 == var_6 )
            continue;

        var_5 = var_7;
        var_6 = var_8;
        var_0 unlink();
        var_0 linkto( var_2, var_1, var_6, var_5 );
    }
}

_id_2DE3( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    var_1 endon( "death" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 endon( "becameSpectator" );

    for (;;)
    {
        var_2 = var_1.origin;
        var_3 = var_1.angles;
        _id_267B( var_2, var_3 );
        waitframe();
    }
}

_id_267B( var_0, var_1 )
{
    var_2 = 20;
    var_3 = anglestoforward( var_1 ) * var_2;
    var_4 = anglestoright( var_1 ) * var_2;
    var_5 = anglestoup( var_1 ) * var_2;
}

_id_6D0B()
{
    if ( !isdefined( self._id_5B27 ) )
    {
        self._id_5B27 = spawnstruct();
        self._id_5B27._id_1C58 = spawnstruct();
        self._id_5B27._id_900E = spawnstruct();
        self._id_5B27.rocket = spawnstruct();
        self._id_5B27._id_9319 = spawnstruct();
        self._id_5B27._id_8D50 = "none";
        self._id_5B27._id_1C58._id_8D50 = "none";
        self._id_5B27._id_1C58._id_555B = "none";
        self._id_5B27._id_900E._id_8D50 = "none";
        self._id_5B27._id_900E._id_555B = "none";
        self._id_5B27.rocket._id_8D50 = "none";
        self._id_5B27.rocket._id_555B = "none";
    }

    _id_7E71();
    self._id_5B27._id_9319._id_932A = [];
    self._id_5B27._id_9319._id_20CD = [];
    self._id_5B27._id_1C58._id_4795 = 0;
    self._id_5B27._id_1C58._id_65F1 = 0;
    self._id_5B27._id_900E._id_931C = 0;
    self._id_5B27._id_900E._id_7261 = 100;
    self._id_5B27.rocket._id_379B = 0;
    self._id_5B27.rocket._id_7261 = 100;
}

_id_6D03()
{
    self endon( "disconnect" );
    self endon( "exit_mech" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    _id_6D0B();
    _id_7E71();
    _id_7E6E();
    _id_7E70();
    _id_7E73();
    waitframe();

    for (;;)
    {
        _id_8D51();
        _id_8D5B();
        _id_8D5C();
        _id_6D0E( self._id_5B27 );
        wait 0.05;
    }
}

_id_7E71( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self._id_5B27 ) )
        return;

    if ( self._id_5B27._id_8D50 == var_0 )
        return;

    self._id_5B27._id_8D50 = var_0;
}

_id_3DD7()
{
    if ( !isdefined( self._id_5B27 ) )
        return;

    return self._id_5B27._id_8D50;
}

get_is_in_mech()
{
    var_0 = self getattachmodelname( 0 );

    if ( isdefined( var_0 ) && var_0 == "head_hero_cormack_sentinel_halo" )
        return 1;

    return 0;
}

_id_3D81( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( vectordot( var_4.origin - self.origin, var_1 ) < 0 )
            continue;

        var_2[var_2.size] = var_4;
    }

    var_2 = sortbydistance( var_2, self.origin );
    return var_2;
}

_id_6D10( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "exit_mech" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    self setclientomnvar( var_1, 0 );

    for (;;)
    {
        while ( !self call [[ var_0 ]]() )
            wait 0.05;

        self setclientomnvar( var_1, 1 );

        while ( self call [[ var_0 ]]() )
            wait 0.05;

        self setclientomnvar( var_1, 0 );
        wait 0.05;
    }
}

_id_6D0E( var_0 )
{
    var_1 = _id_6CD3();
    var_2 = 0;

    if ( var_1 )
        var_2 = 1;

    if ( self._id_4798._id_473F )
        self setclientomnvar( "ui_playermech_swarmrecharge", var_0._id_900E._id_7261 );

    if ( self._id_4798._id_4733 )
        self setclientomnvar( "ui_playermech_rocketrecharge", var_0.rocket._id_7261 );
}

_id_6CEC()
{
    if ( self._id_5B27._id_1C58._id_65F1 )
        return 1;

    return 0;
}

_id_6CED()
{
    if ( self._id_5B27.rocket._id_7261 < 100 )
        return 1;

    return 0;
}

_id_6CEE()
{
    if ( self._id_5B27._id_900E._id_7261 < 100 )
        return 1;

    return 0;
}

_id_6CEF( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "exit_mech" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    var_2 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self call [[ var_0 ]]() )
        {
            if ( !var_2 )
            {
                if ( [[ var_1 ]]() )
                {
                    var_2 = 1;
                    self playlocalsound( "wpn_mech_offline" );
                    wait 1.5;
                }
            }

            continue;
        }

        var_2 = 0;
    }
}

_id_6CF0()
{
    thread _id_6CEF( ::attackbuttonpressed, ::_id_6CEC );
    thread _id_6CEF( ::fragbuttonpressed, ::_id_6CED );
    thread _id_6CEF( ::secondaryoffhandbuttonpressed, ::_id_6CEE );
}

_id_8D58()
{
    switch ( _id_3DD7() )
    {
        case "base_noweap_bootup":
        case "base_swarmonly_nolegs":
        case "base_swarmonly_exit":
        case "base_noweap":
        case "base_swarmonly":
        case "base_transition":
        case "base":
        case "dmg1_transition":
        case "dmg1":
        case "dmg2_transition":
        case "dmg2":
            break;
        case "none":
            _id_6D0B();
            break;
        default:
    }
}

_id_8D51()
{
    var_0 = _id_3DD5();
    var_1 = self getcurrentweapon();
    self._id_5B27._id_1C58._id_4795 = self getweaponheatlevel( var_1 );
    self._id_5B27._id_1C58._id_65F1 = self _meth_83BA( var_1 );

    if ( var_0 == "ready" )
    {
        if ( self._id_5B27._id_1C58._id_65F1 )
            _id_7E6E( "overheat" );
        else if ( self attackbuttonpressed() )
            _id_7E6E( "firing" );
    }
    else if ( var_0 == "firing" )
    {
        if ( self._id_5B27._id_1C58._id_65F1 )
            _id_7E6E( "overheat" );
        else if ( !self attackbuttonpressed() )
            _id_7E6E( "ready" );
    }
    else if ( var_0 == "overheat" && !self._id_5B27._id_1C58._id_65F1 )
        _id_7E6E( "ready" );
}

_id_8D5B()
{
    var_0 = _id_3DD6();

    if ( var_0 != "offline" && _id_6CED() )
        _id_7E70( "reload" );
    else if ( var_0 == "reload" && !_id_6CED() )
        _id_7E70( "ready" );
}

_id_8D5C()
{
    var_0 = _id_3DD8();

    if ( !_id_6CD3() && !_id_6CD2() )
        _id_7E73( "target" );
    else if ( var_0 == "target" && _id_6CEE() )
        _id_7E73( "reload" );
    else if ( var_0 == "reload" && !_id_6CEE() )
        _id_7E73( "ready" );
}

_id_7E6E( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self._id_5B27._id_1C58._id_8D50 ) )
        self._id_5B27._id_1C58._id_8D50 = "none";

    if ( self._id_5B27._id_1C58._id_8D50 == var_0 )
        return;

    self._id_5B27._id_1C58._id_8D50 = var_0;
    self notify( "chaingun_state_" + var_0 );
}

_id_3DD5()
{
    if ( !isdefined( self._id_5B27 ) )
        return;

    return self._id_5B27._id_1C58._id_8D50;
}

_id_77DE()
{
    if ( isdefined( self._id_5B27._id_1C58._id_555B ) && self._id_5B27._id_1C58._id_8D50 == self._id_5B27._id_1C58._id_555B )
        return 1;

    self._id_5B27._id_1C58._id_555B = self._id_5B27._id_1C58._id_8D50;
    return 0;
}

_id_7E70( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self._id_5B27.rocket._id_8D50 ) )
        self._id_5B27.rocket._id_8D50 = "none";

    if ( self._id_5B27.rocket._id_8D50 == var_0 )
        return;

    self._id_5B27.rocket._id_8D50 = var_0;
}

_id_3DD6()
{
    if ( !isdefined( self._id_5B27 ) )
        return;

    return self._id_5B27.rocket._id_8D50;
}

_id_77DF()
{
    if ( isdefined( self._id_5B27.rocket._id_555B ) && self._id_5B27.rocket._id_8D50 == self._id_5B27.rocket._id_555B )
        return 1;

    self._id_5B27.rocket._id_555B = self._id_5B27.rocket._id_8D50;
    return 0;
}

_id_7E73( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self._id_5B27._id_900E._id_8D50 ) )
        self._id_5B27._id_900E._id_8D50 = "none";

    if ( self._id_5B27._id_900E._id_8D50 == var_0 )
        return;

    self._id_5B27._id_900E._id_8D50 = var_0;
}

_id_3DD8()
{
    if ( !isdefined( self._id_5B27 ) )
        return;

    return self._id_5B27._id_900E._id_8D50;
}

_id_77E0()
{
    if ( isdefined( self._id_5B27._id_900E._id_555B ) && self._id_5B27._id_900E._id_8D50 == self._id_5B27._id_900E._id_555B )
        return 1;

    self._id_5B27._id_900E._id_555B = self._id_5B27._id_900E._id_8D50;
    return 0;
}

_id_6CF6( var_0, var_1 )
{
    var_0._id_7261 = 0;
    var_2 = 100.0 / ( var_1 / 0.05 );

    while ( var_0._id_7261 < 100 )
    {
        var_0._id_7261 += var_2;
        wait 0.05;
    }

    var_0._id_7261 = 100;

    while ( isdefined( self.underwatermotiontype ) )
        wait 0.05;
}

_id_6CF4()
{
    self endon( "disconnect" );
    self endon( "exit_mech" );
    self notify( "stop_rocket_recharge" );
    self endon( "stop_rocket_recharge" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        self waittill( "mech_rocket_fire" );
        self disableoffhandweapons();
        _id_6CF6( self._id_5B27.rocket, 10 );
        self enableoffhandweapons();
        wait 0.05;
    }
}

_id_6CF5()
{
    self endon( "disconnect" );
    self endon( "exit_mech" );
    self notify( "stop_swarm_recharge" );
    self endon( "stop_swarm_recharge" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        self waittill( "mech_swarm_fire" );
        self _meth_84BF();
        _id_6CF6( self._id_5B27._id_900E, 10 );
        self _meth_84C0();
        wait 0.05;
    }
}

_id_6955()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    common_scripts\utility::waittill_any( "death", "joined_team", "faux_spawn" );

    if ( isai( self ) )
    {
        maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
        playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );

        if ( isagent( self ) && isdefined( self.hideondeath ) && self.hideondeath == 1 )
        {
            var_0 = self _meth_842C();

            if ( isdefined( var_0 ) )
                var_0 hide();
        }
    }
    else if ( !isdefined( self._id_52A5 ) && !isdefined( level.ishorde ) )
    {
        playfxontag( common_scripts\utility::getfx( "goliath_death_fire" ), self.body, "J_NECK" );
        maps\mp\_snd_common_mp::snd_message( "goliath_death_explosion" );
    }

    self._id_52A5 = undefined;
}

_id_7C6C()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "faux_spawn" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "horde_cancel_goliath" );

    var_0 = 0;

    while ( maps\mp\_utility::isjuggernaut() )
    {
        if ( self usebuttonpressed() )
        {
            var_0 += 0.05;

            if ( var_0 > 1.0 )
            {
                maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
                playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );
                wait 0.05;
                self.hideondeath = 1;
                self._id_52A5 = 1;
                radiusdamage( self.origin + ( 0.0, 0.0, 50.0 ), 400, 200, 20, self, "MOD_EXPLOSIVE", "killstreak_goliathsd_mp" );

                if ( isdefined( level.ishorde ) && level.ishorde )
                    self thread [[ level.hordehandlejuggdeath ]]();
            }
        }
        else
            var_0 = 0;

        wait 0.05;
    }
}

playermechtimeout()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "lost_juggernaut" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "horde_cancel_goliath" );

    for (;;)
    {
        wait 1;
        self._id_5B1D -= int( self.maxhealth / 100 );

        if ( self._id_5B1D < 0 )
        {
            maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
            playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );
            self thread [[ level.hordehandlejuggdeath ]]();
        }

        self setclientomnvar( "ui_exo_suit_health", self._id_5B1D / self.maxhealth );
    }
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "spawned_player" );
        self.hideondeath = 0;
    }
}

_id_2851( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( isdefined( self._id_24C7 ) )
        maps\mp\_utility::_objective_delete( self._id_24C7 );

    if ( isdefined( self._id_2F97 ) )
    {
        if ( var_0 )
            playfx( common_scripts\utility::getfx( "ocp_death" ), self.origin );

        if ( var_1 )
            playsoundatpos( self.origin, "orbital_pkg_self_destruct" );
    }

    self delete();
}

_id_458E( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    wait 120;

    if ( isdefined( level.ishorde ) && level.ishorde && var_0 )
    {
        self.owner.hordeclassgoliathpodinfield = undefined;
        self.owner.hordegoliathpodinfield = undefined;
        self.owner notify( "startJuggCooldown" );
    }

    _id_2851();
}

delete_goliath_drop_pod_for_event( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( level, "zombies_start", level, "EMP_JamTeamallies", var_0, "disconnect" );
    _id_2851();
}

_id_458D( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 waittill( "death" );
    self delete();
}

_id_6D11()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    for (;;)
    {
        self waittill( "emp_grenaded", var_0 );

        if ( isdefined( var_0 ) && isplayer( var_0 ) )
            var_0 thread _id_1C4B();
    }
}

_id_1C4B()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );

    if ( isdefined( level.ishorde ) && level.ishorde )
        self endon( "becameSpectator" );

    var_0 = 5.0;
    wait(var_0);

    if ( maps\mp\_utility::isreallyalive( self ) )
        maps\mp\gametypes\_missions::processchallenge( "ch_precision_closecall" );
}
