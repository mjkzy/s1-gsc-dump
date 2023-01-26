// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level._effect["green_light_mp"] = loadfx( "vfx/lights/aircraft_light_wingtip_green" );
    level._effect["juggernaut_sparks"] = loadfx( "vfx/explosion/bouncing_betty_explosion" );
    level._effect["jugg_droppod_open"] = loadfx( "vfx/explosion/goliath_pod_opening" );
    level._effect["jugg_droppod_marker"] = loadfx( "vfx/unique/vfx_marker_killstreak_guide_goliath" );
    level._effect["goliath_death_fire"] = loadfx( "vfx/fire/goliath_death_fire" );
    level._effect["goliath_self_destruct"] = loadfx( "vfx/explosion/goliath_self_destruct" );
    level._effect["lethal_rocket_wv"] = loadfx( "vfx/muzzleflash/playermech_lethal_flash_wv" );
    level._effect["swarm_rocket_wv"] = loadfx( "vfx/muzzleflash/playermech_tactical_wv_run" );
    level.goliathsuitweapons = [ "iw5_exominigunzm_mp", "playermech_rocket_zm_mp", "playermech_rocket_swarm_zm_mp", "iw5_juggernautrocketszm_mp", "iw5_combatknifegoliath_mp" ];
    level.killstreakwieldweapons["iw5_exominigunzm_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["playermech_rocket_zm_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["playermech_rocket_swarm_zm_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_juggernautrocketszm_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["iw5_combatknifegoliath_mp"] = "juggernaut_exosuit";
    level.killstreakwieldweapons["orbital_carepackage_droppod_zm_mp"] = "juggernaut_exosuit";
    level.killstreakfuncs["zm_goliath_suit"] = ::_id_98AB;
    level.customjuggernautdamagefunc = ::juggernautmodifydamage;
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
    level thread roundlogic();
}

roundlogic()
{
    var_0 = randomintrange( 8, 10 );

    for (;;)
    {
        level waittill( "zombie_wave_started" );

        if ( maps\mp\zombies\_util::_id_508F( level.disablecarepackagedrops ) )
            continue;

        while ( level.wavecounter >= var_0 )
        {
            var_1 = randomfloatrange( 35, 45 );
            var_2 = level common_scripts\utility::waittill_notify_or_timeout_return( "zombie_wave_ended", var_1 );

            if ( !isdefined( var_2 ) || var_2 != "timeout" )
                continue;

            if ( maps\mp\zombies\_util::_id_508F( level.disablecarepackagedrops ) )
                continue;

            var_2 = _id_98AB();

            if ( isdefined( var_2 ) )
                var_0 += randomintrange( 5, 7 );
        }

        level waittill( "zombie_wave_ended" );
    }
}

getowner()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) )
            return var_1;
    }
}

_id_98AB( var_0, var_1 )
{
    var_2 = self;

    if ( !isdefined( self ) || !isplayer( self ) )
    {
        var_2 = getowner();

        if ( !isdefined( var_2 ) )
            return 0;
    }

    var_3 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcratelandingspot( var_2, "goliath_suit" );

    if ( !isdefined( var_3 ) )
        return 0;

    level thread _id_37D3( var_3, [], var_2 );
    return 1;
}

_id_41EA( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self.attackerlist = [];
    var_2 = 1;
    self.juggmovespeedscaler = var_2;
    var_3 = isdefined( self.perks["specialty_hardline"] );
    self.isjuggernaut = 1;
    self.movespeedscaler = var_2;
    maps\mp\_utility::giveperk( "specialty_radarjuggernaut", 0 );

    if ( var_3 )
        maps\mp\_utility::giveperk( "specialty_hardline", 0 );

    thread _id_6D4B( var_1, var_0 );
    self.saved_lastweapon = self getweaponslistprimaries()[0];
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    self _meth_8438( "goliath_suit_up_mp" );
    level thread announcerglobalplaysuitvo( "gol_start", 5, self );
    level notify( "juggernaut_equipped", self );
    maps\mp\_matchdata::logkillstreakevent( "juggernaut", self.origin );
}

cggoliathroverlay()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "ejectedFromJuggernaut" );
    var_0 = 0.35;
    var_1 = newclienthudelem( self );
    thread cggoliathoverlaycleanup( var_1 );
    var_1.x = 0;
    var_1.y = 0;
    var_1 setshader( "black", 640, 480 );
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1.alpha = 0.0;
    var_1 fadeovertime( var_0 );
    var_1.alpha = 1.0;
    wait 2;
    var_1 fadeovertime( var_0 );
    var_1.alpha = 0.0;
}

cggoliathoverlaycleanup( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::waittill_any( "spawned", "disconnect", "ejectedFromJuggernaut", "death" );
    var_0 destroy();
}

_id_73E9()
{
    maps\mp\zombies\_zombies_laststand::savelaststandweapons( "", 0 );
    self._id_6F8A = common_scripts\utility::getlastweapon();
    var_0 = self getweaponslistall();

    foreach ( var_2 in var_0 )
    {
        var_3 = maps\mp\_utility::getweaponnametokens( var_2 );

        if ( var_3[0] == "alt" )
        {
            self._id_74B1[var_2] = self getweaponammoclip( var_2 );
            self._id_74B3[var_2] = self getweaponammostock( var_2 );
            continue;
        }

        self._id_74B1[var_2] = self getweaponammoclip( var_2 );
        self._id_74B3[var_2] = self getweaponammostock( var_2 );
    }

    self._id_A2E4 = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = maps\mp\_utility::getweaponnametokens( var_2 );

        if ( var_3[0] == "alt" )
            continue;

        if ( maps\mp\_utility::iskillstreakweapon( var_2 ) )
            continue;

        self._id_A2E4[self._id_A2E4.size] = var_2;
        self takeweapon( var_2 );
    }
}

_id_74B2()
{
    var_0 = self getweaponslistall();

    foreach ( var_2 in var_0 )
    {
        if ( maps\mp\_utility::iskillstreakweapon( var_2 ) && !iskillstreakgoliathweapon( var_2 ) )
            continue;

        self takeweapon( var_2 );
    }

    if ( !isdefined( self._id_74B1 ) || !isdefined( self._id_74B3 ) || !isdefined( self._id_A2E4 ) )
        return;

    self setlethalweapon( "none" );
    self settacticalweapon( "none" );
    var_4 = [];

    foreach ( var_2 in self._id_A2E4 )
    {
        var_6 = maps\mp\_utility::getweaponnametokens( var_2 );

        if ( var_6[0] == "alt" )
        {
            var_4[var_4.size] = var_2;
            continue;
        }

        if ( maps\mp\zombies\_util::iszombielethal( var_2 ) )
            self setlethalweapon( var_2 );
        else if ( maps\mp\zombies\_util::iszombietactical( var_2 ) )
            self settacticalweapon( var_2 );

        maps\mp\_utility::_giveweapon( var_2 );

        if ( isdefined( self._id_74B1[var_2] ) )
            self setweaponammoclip( var_2, self._id_74B1[var_2] );

        if ( isdefined( self._id_74B3[var_2] ) )
            self setweaponammostock( var_2, self._id_74B3[var_2] );
    }

    foreach ( var_9 in var_4 )
    {
        if ( isdefined( self._id_74B1[var_9] ) )
            self setweaponammoclip( var_9, self._id_74B1[var_9] );

        if ( isdefined( self._id_74B3[var_9] ) )
            self setweaponammostock( var_9, self._id_74B3[var_9] );
    }

    self._id_74B1 = undefined;
    self._id_74B3 = undefined;
}

iskillstreakgoliathweapon( var_0 )
{
    return common_scripts\utility::array_contains( level.goliathsuitweapons, var_0 );
}

_id_6D4B( var_0, var_1 )
{
    var_2 = spawnstruct();
    self._id_4798 = var_2;
    var_2._id_8F22 = self;
    var_2._id_4722 = 0;
    var_2.modules = var_0;
    var_2._id_52AB = var_1;
    var_2.hasradar = 0;
    var_2._id_4734 = 0;
    var_2._id_4733 = 1;
    var_2._id_4749 = 0;
    var_2._id_473F = 1;
    var_2._id_472A = 0;
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
    maps\mp\_utility::playerallowdodge( 0, "heavyexo" );
    maps\mp\_utility::playerallowboostjump( 0, "heavyexo" );
    maps\mp\_utility::playerallowhighjump( 0, "heavyexo" );
    maps\mp\_utility::playerallowhighjumpdrop( 0, "heavyexo" );
    self allowjump( 0 );
    self _meth_8119( 0 );
    self _meth_8302( 0 );
    self _meth_8303( 0 );
    self.inliveplayerkillstreak = 1;
    self._id_5B1D = 600;
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
    thread playermechtimeout();

    if ( var_2._id_4722 )
    {
        var_4 = _id_8301( var_2, self );

        if ( level.teambased )
            level thread _id_464F( var_2, self );
    }

    if ( !var_2._id_4734 )
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

    if ( var_2._id_473F )
    {
        level thread _id_8334( self, var_2 );
        _id_7E73( "ready" );
        thread _id_6CF5();
    }

    level thread setupeject( var_2, self );
    level thread _id_27EB( self );
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

    if ( isdefined( var_1 ) && isdefined( var_0 ) && var_1 == var_0 && isdefined( var_4 ) && ( var_4 == "iw5_juggernautrocketszm_mp" || var_4 == "playermech_rocket_zm_mp" ) )
        var_9 = 0;

    if ( isdefined( var_0._id_426D ) && var_0._id_426D )
        var_9 = 0;

    if ( isdefined( var_1 ) && !maps\mp\gametypes\_weapons::friendlyfirecheck( var_0, var_1 ) )
        var_9 = 0;

    if ( isdefined( var_1 ) && isdefined( var_1.agent_type ) && var_1.agent_type == "zombie_boss_oz_stage2" && var_3 == "MOD_IMPACT" )
        var_9 *= 2;

    if ( var_9 > 0 )
    {
        if ( maps\mp\_utility::attackerishittingteam( var_0, var_1 ) )
        {
            if ( isdefined( level.juggernautmod ) )
                var_9 *= level.juggernautmod;
            else
                var_9 *= 0.08;
        }

        var_10 = var_0._id_5B1D / 600;
        var_0._id_5B1D -= var_9;
        var_11 = var_0._id_5B1D / 600;
        var_0 setclientomnvar( "ui_exo_suit_health", var_11 );
        level thread dogoliathintegrityvo( var_10, var_11, self );

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
            if ( !isdefined( var_0.underwatermotiontype ) )
                var_0 thread playereject();
            else
                var_0 thread _id_6CD6( var_5, var_1, var_3, var_4, var_8 );
        }
    }

    return 0;
}

dogoliathintegrityvo( var_0, var_1, var_2 )
{
    if ( var_0 > 0.75 && var_1 <= 0.75 )
        level thread announcerglobalplaysuitvo( "gol_armor1", undefined, var_2 );
    else if ( var_0 > 0.5 && var_1 <= 0.5 )
        level thread announcerglobalplaysuitvo( "gol_armor2", undefined, var_2 );
    else if ( var_0 > 0.25 && var_1 <= 0.25 )
        level thread announcerglobalplaysuitvo( "gol_armor3", undefined, var_2 );
    else if ( var_0 > 0.08 && var_1 <= 0.08 )
        level thread announcerglobalplaysuitvo( "gol_armor4", undefined, var_2 );
}

_id_6CD6( var_0, var_1, var_2, var_3, var_4 )
{
    if ( maps\mp\_utility::isjuggernaut() )
        _id_6D2E();

    var_5 = "ui_zm_character_" + self.characterindex + "_alive";
    setomnvar( var_5, 0 );
    maps\mp\_utility::_suicide();

    if ( level.players.size < 2 )
        maps\mp\zombies\_zombies_laststand::zombieendgame( undefined, "MOD_SUICIDE" );

    level notify( "player_left_goliath_suit" );
}

_id_27EB( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 giveweapon( "iw5_exominigunzm_mp" );
    var_0 switchtoweapon( "iw5_exominigunzm_mp" );
    waitframe();
    var_0 _meth_8494( 1 );
    var_0 common_scripts\utility::_disableweaponswitch();

    if ( var_0 hasweapon( "iw5_combatknifegoliath_mp" ) )
        var_0 takeweapon( "iw5_combatknifegoliath_mp" );
}

_id_6C6F( var_0 )
{
    self endon( "disconnect" );
    self endon( "ejectedFromJuggernaut" );
    self waittill( "death", var_1, var_2, var_3 );

    if ( maps\mp\_utility::isjuggernaut() )
        thread _id_6D2E();
}

_id_6C70()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "ejectedFromJuggernaut" );
    level common_scripts\utility::waittill_any( "game_ended" );
    _id_6D32();
}

_id_6D2E()
{
    self notify( "lost_juggernaut" );
    self notify( "exit_mech" );
    self._id_4798 = undefined;
    self.isjuggernaut = 0;
    self unsetperk( "specialty_radarjuggernaut", 1 );
    self.movespeedscaler = 1;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\_utility::playerallowpowerslide( 1, "heavyexo" );
    maps\mp\_utility::playerallowdodge( 1, "heavyexo" );
    maps\mp\_utility::playerallowboostjump( 1, "heavyexo" );
    maps\mp\_utility::playerallowhighjump( 1, "heavyexo" );
    maps\mp\_utility::playerallowhighjumpdrop( 1, "heavyexo" );
    self allowjump( 1 );
    self _meth_8119( 1 );
    self _meth_8302( 1 );
    self _meth_8303( 1 );
    self.inliveplayerkillstreak = undefined;
    self._id_5B1D = undefined;
    self setdemigod( 0 );
    _id_6D32();
    self _meth_8494( 0 );
    common_scripts\utility::_enableweaponswitch();
    self enableoffhandweapons();
    self _meth_84C0();
    self._id_74B1 = undefined;
    self._id_74B3 = undefined;

    if ( isdefined( self._id_529F ) )
        self._id_529F = undefined;
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
    self attach( self.characterhead );
    self setviewmodel( "vm_view_arms_mech_mp" );
    self attach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );
}

_id_6CB2()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "ejectedFromJuggernaut" );
    thread _id_6C6E();
    self notifyonplayercommand( "goliathAttack", "+attack" );
    self notifyonplayercommand( "goliathAttackDone", "-attack" );
    self._id_12E9 = spawn( "script_model", self gettagorigin( "tag_barrel" ) );
    self._id_12E9 setmodel( "generic_prop_raven" );
    self._id_12E9 linktosynchronizedparent( self, "tag_barrel", ( 12.7, 0.0, -2.9 ), ( 90.0, 0.0, 0.0 ) );
    self._id_12E4 = spawn( "script_model", self._id_12E9 gettagorigin( "j_prop_1" ) );
    self._id_12E4 setmodel( "npc_exo_armor_minigun_barrel" );
    self._id_12E4 linktosynchronizedparent( self._id_12E9, "j_prop_1", ( 0.0, 0.0, 0.0 ), ( -90.0, 0.0, 0.0 ) );
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
    common_scripts\utility::waittill_any( "death", "disconnect", "ejectedFromJuggernaut" );

    if ( isdefined( self ) )
    {
        if ( isdefined( self._id_12E4 ) )
            self._id_12E4 delete();

        if ( isdefined( self._id_12E9 ) )
            self._id_12E9 delete();
    }
}

_id_6D36()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "ejectedFromJuggernaut" );

    for (;;)
    {
        self waittill( "grenade_pullback", var_0 );

        if ( var_0 == "playermech_rocket_zm_mp" )
        {
            self notify( "mech_rocket_pullback" );
            self waittill( "grenade_fire", var_1 );
            self notify( "mech_rocket_fire", var_1 );
        }
        else if ( var_0 == "playermech_rocket_swarm_zm_mp" )
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
    var_3 = _id_898C( "juggernaut_sentry_mg_zm_mp", "npc_heavy_exo_armor_turret_base", var_2, 200, var_1, &"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST" );
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
    var_3 = weaponfiretime( "juggernaut_sentry_mg_zm_mp" );

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

    randomcostume( var_1, var_3, "juggernaut_sentry_mg_zm_mp", var_4, var_0 );
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

_id_831B( var_0, var_1 )
{
    var_0 setlethalweapon( "playermech_rocket_zm_mp" );
    var_0 giveweapon( "playermech_rocket_zm_mp" );
    var_2 = "tag_origin";
    var_0 thread _id_6D8D( var_1 );
    _id_A0C6( var_0 );
}

_id_6D8D( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "ejectedFromJuggernaut" );

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
    self endon( "ejectedFromJuggernaut" );
    _id_A001( var_0 playergetrocketreloadtime(), "ui_exo_suit_punch_cd" );
}

playergetrocketreloadtime()
{
    if ( maps\mp\_utility::gameflag( "unlimited_ammo" ) )
        return 0.1;
    else if ( maps\mp\_utility::_hasperk( "specialty_fastreload" ) )
        return 5;
    else
        return 10;
}

_id_A001( var_0, var_1 )
{
    self endon( "disconnect" );
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

_id_8334( var_0, var_1 )
{
    var_2 = "playermech_rocket_swarm_zm_mp";
    var_0 settacticalweapon( var_2 );
    var_0 giveweapon( var_2 );
    var_3 = "tag_origin";
    var_4 = var_0 gettagorigin( var_3 );
    var_5 = _id_898C( "rocketAttachment", "npc_heavy_exo_armor_missile_pack_base", var_4, undefined, var_0 );
    var_5._id_580D = 0;
    var_5._id_7314 = 0;
    var_5.enemytargets = [];
    var_5.rockets = [];
    var_5._id_4B4D = [];
    var_5 linkto( var_0, var_3, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
    var_5 hide();
    var_0._id_758A = var_5;
    thread _id_783C( var_5, var_0 );
    var_0 thread _id_6D8E( var_5, var_1 );
    _id_A0C6( var_0, var_5 );
    waitframe();

    if ( isdefined( var_5 ) )
        var_5 delete();

    var_0._id_758A = undefined;
}

_id_783C( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 endon( "ejectedFromJuggernaut" );

    for (;;)
    {
        waitframe();

        if ( var_0._id_7314 || var_0.rockets.size > 0 || var_0._id_580D )
            continue;

        var_0.enemytargets = getbestenemies( var_1, 5 );
    }
}

_id_6CD2()
{
    return isdefined( self._id_758A ) && isdefined( self._id_758A._id_7314 ) && self._id_758A._id_7314;
}

_id_6CD3()
{
    return isdefined( self._id_758A ) && isdefined( self._id_758A.enemytargets ) && self._id_758A.enemytargets.size > 0;
}

getbestenemies( var_0, var_1 )
{
    var_2 = 0.843391;
    var_3 = anglestoforward( var_0 getangles() );
    var_4 = var_0 geteye();
    var_5 = undefined;
    var_6 = [];
    var_7 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

    if ( isdefined( level.bossozstage1 ) && isdefined( level.bossozstage1.damagecallback ) )
        var_7[var_7.size] = level.bossozstage1;

    foreach ( var_9 in var_7 )
    {
        if ( issentient( var_9 ) && _func_285( var_9, var_0 ) )
            continue;

        if ( !maps\mp\_utility::isreallyalive( var_9 ) )
            continue;

        if ( issentient( var_9 ) )
            var_10 = var_9 geteye();
        else
            var_10 = var_9.origin + ( 0.0, 0.0, 55.0 );

        var_11 = vectornormalize( var_10 - var_4 );
        var_12 = vectordot( var_3, var_11 );

        if ( var_12 > var_2 )
        {
            var_6[var_6.size] = var_9;
            var_9.dot = var_12;
            var_9._id_1CFB = 0;
        }
    }

    if ( var_6.size == 0 )
        return [];

    var_14 = [];

    for ( var_15 = 0; var_15 < var_1 && var_15 < var_6.size; var_15++ )
    {
        var_16 = _id_3FC4( var_6 );

        if ( !isdefined( var_16 ) )
            return;

        var_16._id_1CFB = 1;
        var_17 = var_4;

        if ( issentient( var_16 ) )
            var_18 = var_16 geteye();
        else
            var_18 = var_16.origin + ( 0.0, 0.0, 55.0 );

        var_19 = sighttracepassed( var_17, var_18, 1, var_0, var_16 );

        if ( var_19 )
            var_14[var_14.size] = var_16;
    }

    foreach ( var_9 in var_7 )
    {
        var_9.dot = undefined;
        var_9._id_1CFB = undefined;
    }

    return var_14;
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
        var_0.enemytargets = [];
    }
}

_id_37E4( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_1 getangles() );
    var_4 = anglestoright( var_1 getangles() );
    var_5 = [ ( 0.0, 0.0, 50.0 ), ( 0.0, 0.0, 20.0 ), ( 10.0, 0.0, 0.0 ), ( 0.0, 10.0, 0.0 ) ];
    playfxontag( common_scripts\utility::getfx( "swarm_rocket_wv" ), var_1, "TAG_ROCKET4" );
    var_6 = 0;
    var_7 = undefined;

    for ( var_8 = 0; var_8 < 4; var_8++ )
    {
        var_9 = var_2 + var_3 * 20 + var_4 * -30;
        var_10 = var_3 + _id_7117( 0.2 );
        var_11 = magicbullet( "iw5_juggernautrocketszm_mp", var_9, var_9 + var_10, var_1 );
        var_0.rockets = common_scripts\utility::array_add( var_0.rockets, var_11 );

        if ( var_6 < var_0.enemytargets.size )
        {
            var_7 = var_0.enemytargets[var_6];
            var_6++;
        }

        var_11 thread _id_7592( var_0, var_7, var_5[var_8] );
        var_11 thread _id_758C( 7 );
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
    _id_A001( var_1 playergetswarmreloadtime(), "ui_exo_suit_rockets_cd" );
    var_0._id_7314 = 0;
}

playergetswarmreloadtime()
{
    if ( maps\mp\_utility::gameflag( "unlimited_ammo" ) )
        return 0.1;
    else if ( maps\mp\_utility::_hasperk( "specialty_fastreload" ) )
        return 5;
    else
        return 10;
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
    var_0 endon( "ejectedFromJuggernaut" );

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
    var_2 endon( "ejectedFromJuggernaut" );

    if ( isdefined( var_3 ) )
        var_3 endon( "death" );

    var_1 waittill( "death", var_4, var_5, var_6 );
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
    var_0 endon( "ejectedFromJuggernaut" );
    var_0 endon( "turretDead" );
    return var_0 common_scripts\utility::waittill_any_return_no_endon_death( var_1, var_2, var_3 );
}

_id_A0EF( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 endon( "disconnect" );
    var_1 endon( "turretDead" );
    var_1 endon( "ejectedFromJuggernaut" );

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
    var_1 endon( "ejectedFromJuggernaut" );
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
    self setclientomnvar( "ui_exo_suit_enabled", 1 );
    thread _id_6D03();
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

droppodmovenearbyallies( var_0 )
{
    if ( !isdefined( self ) )
        return;

    self._id_9A55 = getnodesinradius( self.origin, 300, 80, 200 );

    foreach ( var_2 in level.characters )
    {
        if ( !isalive( var_2 ) )
            continue;

        if ( var_2.team == var_0 )
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

_id_37D3( var_0, var_1, var_2 )
{
    var_3 = var_2 maps\mp\killstreaks\_orbital_util::_id_6CA9( var_0 );
    var_4 = var_0.origin;

    if ( !isdefined( var_2 ) )
        var_2 = getowner();

    var_5 = var_2.team;
    var_6 = magicbullet( "orbital_carepackage_droppod_zm_mp", var_3, var_4, var_2, 0, 1 );
    var_6.team = var_5;
    var_7 = spawn( "script_model", var_4 + ( 0.0, 0.0, 5.0 ) );
    var_7.angles = ( -90.0, 0.0, 0.0 );
    var_7 setmodel( "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "jugg_droppod_marker" ), var_7, "tag_origin" );
    maps\mp\killstreaks\_orbital_util::_id_07DF( var_7, "goliath_suit" );

    if ( !maps\mp\zombies\_util::_id_508F( level.zmkillstreakgoliathprevo ) )
    {
        var_8 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint( var_7.origin );
        var_8 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "gol_drop_pre" );
        level.zmkillstreakgoliathprevo = 1;
    }

    var_6 waittill( "death" );

    if ( distancesquared( var_6.origin, var_4 ) > 22500 )
    {
        var_7 delete();
        return;
    }

    var_4 = getgroundposition( var_6.origin + ( 0.0, 0.0, 8.0 ), 20 );

    if ( !maps\mp\zombies\_util::_id_508F( level.zmkillstreakgoliathreactvo ) )
    {
        var_8 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint( var_4 );
        var_8 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "gol_react" );
        level.zmkillstreakgoliathreactvo = 1;
    }

    thread destroy_nearby_turrets( var_4 );
    var_7 hide();
    earthquake( 0.4, 1, var_4, 800 );
    playrumbleonposition( "artillery_rumble", var_4 );
    stopfxontag( common_scripts\utility::getfx( "jugg_droppod_marker" ), var_7, "tag_origin" );
    var_9 = spawn( "script_model", var_4 );
    var_9.angles = ( 0.0, 0.0, 0.0 );
    var_9 _id_23F2( var_4 );
    var_9.targetname = "care_package";
    var_9._id_2F75 = 0;
    var_10 = spawn( "script_model", var_4 );
    var_10.angles = ( 90.0, 0.0, 0.0 );
    var_10.targetname = "goliath_pod_model";
    var_10 setmodel( "vehicle_drop_pod" );
    var_10 thread _id_458D( var_9 );
    var_10 maps\mp\_entityheadicons::setheadicon( var_5, maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( "zm_goliath_suit", [] ), ( 0.0, 0.0, 140.0 ), 14, 14, undefined, undefined, undefined, undefined, undefined, 0 );
    var_9.owner = undefined;
    var_9._id_2383 = "juggernaut";
    var_9._id_2F97 = "juggernaut";
    var_9 thread _id_2168();
    var_9 sethintstring( &"KILLSTREAKS_HEAVY_EXO_PICKUP" );
    var_9 thread cratecapturethink();
    var_9 thread _id_9BF8();
    var_11 = spawnstruct();
    var_11._id_9BF6 = var_9;
    var_11._id_6A3B = 1;
    var_11.deathoverridecallback = ::_id_5FA4;
    var_11._id_9403 = ::_id_5FA5;
    var_9 thread maps\mp\_movers::handle_moving_platforms( var_11 );
    var_9 droppodmovenearbyallies( var_5 );
    var_9 disconnectpaths();
    var_12 = var_9 _id_6D83();

    if ( isdefined( var_12 ) && isalive( var_12 ) )
    {
        maps\mp\gametypes\_gamelogic::sethasdonecombat( var_12, 1 );
        var_12.enteringgoliath = 1;
        var_12 playerswitchtosuitupweapon();
        var_12 unlink();
        var_12 maps\mp\_utility::freezecontrolswrapper( 1 );
        var_13 = var_4 - var_12.origin;
        var_14 = vectortoangles( var_13 );
        var_15 = ( 0, var_14[1], 0 );
        var_16 = rotatevector( var_13, ( 45.0, 0.0, 0.0 ) );
        var_17 = spawn( "script_model", var_4 );
        var_17.angles = var_15;

        if ( level.nextgen )
        {
            var_17 setmodel( "npc_exo_armor_ingress" );
            var_17 scriptmodelplayanimdeltamotion( "mp_goliath_spawn" );
        }
        else
            var_17 setmodel( "npc_exo_armor_mp_base" );

        var_12 maps\mp\_snd_common_mp::snd_message( "goliath_pod_burst" );

        if ( isdefined( var_9 ) )
            var_9 _id_2851( 0 );

        playfx( level._effect["jugg_droppod_open"], var_4, var_16 );
        wait 0.1;
        var_12 _id_501D( var_17, var_4 );

        if ( isdefined( var_12 ) && isalive( var_12 ) )
        {
            var_12 setorigin( var_4, 1 );
            var_12 setangles( var_17.angles );
            var_12 enableweapons();
            var_12 _id_41EA( "juggernaut_exosuit", var_1 );
            var_17 delete();
            var_12 _meth_8517();
            wait 1;

            if ( isdefined( var_12 ) )
            {
                var_12.enteringgoliath = undefined;
                var_12 maps\mp\_utility::freezecontrolswrapper( 0 );
            }
        }
        else
            var_17 delete();
    }

    var_7 delete();
}

playerswitchtosuitupweapon()
{
    _id_73E9();
    self giveweapon( "iw5_combatknifegoliath_mp", 0, 0, 0, 1 );
    self switchtoweapon( "iw5_combatknifegoliath_mp" );
}

cratecapturethink( var_0 )
{
    self endon( "captured" );
    var_1 = self;

    if ( isdefined( self._id_65AF ) )
        var_1 = self._id_65AF;

    while ( isdefined( self ) )
    {
        var_1 waittill( "trigger", var_2 );

        if ( maps\mp\zombies\_util::arekillstreaksdisabled() )
            continue;

        if ( var_2 maps\mp\_utility::isjuggernaut() )
            continue;

        if ( isdefined( self.owner ) && var_2 == self.owner )
            continue;

        if ( var_2 isjumping() || isdefined( var_2.exo_hover_on ) && var_2.exo_hover_on )
            continue;

        if ( !var_2 isonground() && !maps\mp\killstreaks\_airdrop::_id_A04A( var_2 ) )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::_id_9C45( var_2 ) )
            continue;

        var_2.iscapturingcrate = 1;
        var_3 = maps\mp\killstreaks\_airdrop::_id_244B();
        var_4 = var_3 useholdthink( var_2, undefined, var_0 );

        if ( isdefined( var_3 ) )
            var_3 delete();

        if ( !var_4 )
        {
            if ( isdefined( var_2 ) )
                var_2.iscapturingcrate = 0;

            continue;
        }

        var_2.iscapturingcrate = 0;
        self notify( "captured", var_2 );
    }
}

useholdthink( var_0, var_1, var_2 )
{
    if ( isplayer( var_0 ) )
        var_0 playerlinkto( self );
    else
        var_0 linkto( self );

    var_0 playerlinkedoffsetenable();

    if ( !var_0 maps\mp\_utility::isjuggernaut() )
        var_0 common_scripts\utility::_disableweapon();

    thread _id_9BFD( var_0 );
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;

    if ( isdefined( var_1 ) )
    {
        if ( var_0 maps\mp\_utility::_hasperk( "specialty_unwrapper" ) && isdefined( var_0._id_8A39 ) )
            var_1 *= var_0._id_8A39;

        if ( isdefined( level.podcapturetimemodifier ) )
            var_1 *= level.podcapturetimemodifier;

        self.usetime = var_1;
    }
    else if ( var_0 maps\mp\_utility::_hasperk( "specialty_unwrapper" ) && isdefined( var_0._id_8A39 ) )
        self.usetime = 3000 * var_0._id_8A39;
    else
        self.usetime = 3000;

    if ( isplayer( var_0 ) )
        var_0 thread personalusebar( self, var_2 );

    var_3 = useholdthinkloop( var_0 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( self ) )
        return 0;

    self notify( "useHoldThinkLoopDone" );
    self.inuse = 0;
    self.curprogress = 0;
    return var_3;
}

_id_9BFD( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::waittill_any( "death", "captured", "useHoldThinkLoopDone" );

    if ( isalive( var_0 ) )
    {
        if ( !var_0 maps\mp\_utility::isjuggernaut() )
            var_0 common_scripts\utility::_enableweapon();

        if ( var_0 islinked() )
            var_0 unlink();
    }
}

personalusebar( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( isdefined( var_1 ) )
        iprintlnbold( "Fixme @agersant " + var_1 );

    self setclientomnvar( "ui_use_bar_text", 1 );
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

ishordelaststand( var_0 )
{
    return isdefined( level.ishorde ) && level.ishorde && isdefined( var_0.laststand ) && var_0.laststand;
}

useholdthinkloop( var_0 )
{
    var_0 endon( "stop_useHoldThinkLoop" );

    while ( !level.gameended && isdefined( self ) && maps\mp\_utility::isreallyalive( var_0 ) && !maps\mp\zombies\_util::_id_5175( var_0 ) && var_0 usebuttonpressed() && self.curprogress < self.usetime )
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

    if ( level.currentgen )
        thread cggoliathroverlay();

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
    var_0 endon( "ejectedFromJuggernaut" );
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
    self endon( "ejectedFromJuggernaut" );
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

_id_6D10( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "exit_mech" );
    self endon( "ejectedFromJuggernaut" );
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
    self endon( "ejectedFromJuggernaut" );
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
    self endon( "ejectedFromJuggernaut" );

    for (;;)
    {
        self waittill( "mech_rocket_fire" );
        self disableoffhandweapons();
        _id_6CF6( self._id_5B27.rocket, playergetrocketreloadtime() );
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
    self endon( "ejectedFromJuggernaut" );

    for (;;)
    {
        self waittill( "mech_swarm_fire" );
        self _meth_84BF();
        _id_6CF6( self._id_5B27._id_900E, playergetswarmreloadtime() );
        self _meth_84C0();
        wait 0.05;
    }
}

_id_6955()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
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
}

playermechtimeout()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "lost_juggernaut" );
    self endon( "ejectedFromJuggernaut" );
    var_0 = int( 2.0 );

    while ( maps\mp\zombies\_util::_id_508F( self._id_426D ) )
        waitframe();

    for (;;)
    {
        wait 1;
        var_1 = self._id_5B1D / 600;
        self._id_5B1D -= var_0;
        var_2 = self._id_5B1D / 600;
        self setclientomnvar( "ui_exo_suit_health", var_2 );
        level thread dogoliathintegrityvo( var_1, var_2, self );

        if ( self._id_5B1D < 0 )
        {
            if ( !isdefined( self.underwatermotiontype ) )
                thread playereject();
            else
                thread _id_6CD6( self.origin );

            return;
        }
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

_id_458D( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 waittill( "death" );
    self delete();
}

setupeject( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    var_1 endon( "death" );
    var_1 endon( "ejectedFromJuggernaut" );

    if ( !isbot( var_1 ) )
        var_1 notifyonplayercommand( "juggernautEject", "+goStand" );

    for (;;)
    {
        var_1 waittill( "juggernautEject" );
        waitframe();
        var_2 = 0;

        while ( var_1 _meth_83DE() )
        {
            var_2 += 0.05;

            if ( var_2 > 0.7 )
            {
                if ( !isdefined( var_1.underwatermotiontype ) )
                    var_1 thread playereject();
                else
                    var_1 thread _id_6CD6( var_1.origin );

                return;
            }

            waitframe();
        }
    }
}

playereject( var_0 )
{
    self notify( "ejectedFromJuggernaut" );
    level thread juggernautsuitexplode( self );
    self detachall();
    self setmodel( self.charactermodel );
    self setviewmodel( self.characterviewmodel );
    self attach( self.characterhead );
    _id_74B2();
    thread playersetpreviousweapon();

    if ( maps\mp\_utility::isjuggernaut() )
        _id_6D2E();

    level notify( "player_left_goliath_suit" );
}

playerhandlejump()
{
    self endon( "disconnect" );
    self endon( "death" );
    self allowjump( 0 );
    wait 1;

    while ( !self isonground() )
        waitframe();

    self allowjump( 1 );
}

playersetpreviousweapon()
{
    self endon( "disconnect" );
    self endon( "death" );
    var_0 = self._id_6F8A;
    self._id_6F8A = undefined;

    while ( self getcurrentweapon() != var_0 )
    {
        self switchtoweapon( var_0 );
        wait 0.1;
    }
}

juggernautsuitexplode( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = var_0;

    var_2 = var_1.origin;
    var_3 = var_1.angles;
    waittillframeend;

    if ( isdefined( var_0 ) )
    {
        var_0 entityradiusdamage( var_2, 400, 200, 50, var_0, "MOD_EXPLOSIVE", "iw5_juggernautrocketszm_mp" );
        var_0 maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
    }

    playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), var_2, anglestoup( var_3 ) );
}

announcerglobalplaysuitvo( var_0, var_1, var_2 )
{
    var_2 endon( "death" );
    var_2 endon( "disconnect" );
    var_2 endon( "ejectedFromJuggernaut" );

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
    maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog( "global", var_0, undefined, undefined, undefined, undefined, [ var_2 ] );
}
