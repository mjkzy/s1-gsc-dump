// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\gametypes\_globallogic::init();
    maps\mp\gametypes\_callbacksetup::setupcallbacks();
    maps\mp\gametypes\_globallogic::setupcallbacks();

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread maps\mp\_utility::reinitializematchrulesonmigration();
    }
    else
    {
        maps\mp\_utility::registerroundswitchdvar( level.gametype, 0, 0, 9 );
        maps\mp\_utility::registertimelimitdvar( level.gametype, 0 );
        maps\mp\_utility::registerscorelimitdvar( level.gametype, 0 );
        maps\mp\_utility::registerroundlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registerwinlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registernumlivesdvar( level.gametype, 1 );
        maps\mp\_utility::registerhalftimedvar( level.gametype, 0 );
        setdvarifuninitialized( "scr_horde_startinground", 0 );
        setdvarifuninitialized( "scr_horde_difficulty", 0 );
        setdynamicdvar( "scr_horde_hardcore", 0 );
    }

    setdynamicdvar( "r_hudOutlineWidth", 2 );
    setdynamicdvar( "scr_horde_timeLimit", 0 );
    setdynamicdvar( "scr_horde_numLives", 1 );
    setdvarifuninitialized( "horde_set_character_models", 0 );
    maps\mp\_utility::registertimelimitdvar( level.gametype, 0 );
    setdvarifuninitialized( "scr_waveTableVersion", 2 );
    setspecialloadouts();
    initpickups();
    loadeffects();
    level.teambased = 1;
    level.ishorde = 1;
    level.disableforfeit = 1;
    level.nobuddyspawns = 1;
    level.alwaysdrawfriendlynames = 1;
    level.scorelimitoverride = 1;
    level.allowlatecomers = 1;
    level.skiplivesxpscalar = 1;
    level.highlightairdrop = 1;
    level.nocratetimeout = 1;
    level.noairdropkills = 1;
    level.allowlaststandai = 1;
    level.enableteamintel = 1;
    level.isteamintelcomplete = 1;
    level.removekillstreakicons = 1;
    level.assists_disabled = 1;
    level.skippointdisplayxp = 1;
    level.forceranking = 1;
    level.allowfauxdeath = 0;
    level.killstreakrewards = 0;
    level.supportintel = 0;
    level.donottrackgamesplayed = 1;
    level.playerteam = "allies";
    level.enemyteam = "axis";
    level.laststandusetime = 2000;
    level.currentteamintelname = "";
    level.timeromnvars = [];
    level.rankedmatch = 0;
    level.grenadegraceperiod = 0;
    level.disableweaponstats = 1;
    level.weaponweightfunc = ::hordeweaponweight;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onnormaldeath = ::onnormaldeath;
    level.onspawnplayer = ::onspawnplayer;
    level.modifyplayerdamage = ::modifyplayerdamagehorde;
    level.callbackplayerlaststand = maps\mp\gametypes\_horde_laststand::callback_playerlaststandhorde;
    level.ondeadevent = ::ondeadevent;
    level.customcratefunc = maps\mp\gametypes\_horde_crates::createhordecrates;
    level.onsuicidedeath = ::onnormaldeath;
    level.weapondropfunction = ::dropweaponfordeathhorde;
    level.hordevomissionfail = maps\mp\gametypes\_horde_dialog::hordevomissionfail;
    level.hordeupdatetimestats = maps\mp\gametypes\_horde_util::hordeupdatetimestats;
    level.cb_usedkillstreak = maps\mp\gametypes\_horde_util::horderemoveksicon;
    level.custom_giveloadout = ::hordecustomgiveloadout;
    level.hordehandlejuggdeath = maps\mp\gametypes\_horde_laststand::hordehandlejuggdeath;
    level.hordegivebackgoliath = maps\mp\gametypes\_horde_util::hordegivebackgoliath;
    level.laststandsaveloadoutinfo = maps\mp\gametypes\_horde_laststand::laststandsaveloadoutinfo;
    level.hordeonunderwater = maps\mp\gametypes\_horde_util::hordeonunderwater;
    level.hordedropandresetuplinkball = maps\mp\gametypes\_horde_util::hordedropandresetuplinkball;
    level.hordenumroundscompleted = 0;
    level.wavefirstspawn = 1;
    level.enemiesleft = 0;
    level.activehordedefendlocs = [];
    level.hordedefendlocs = [];
    level.horde_defend_killcount = 10;
    level.horde_collect_count = 20;
    level.horde_defuse_count = 3;
    level.hordecollected = 0;
    level.objdefend = 0;
    level.objcollect = 0;
    level.objintel = 0;
    level.objdefuse = 0;
    level.objuplink = 0;
    level.isobjectiveround = 0;
    level.killssinceinteldrop = 0;
    level.killssinceammodrop = 0;
    level.hordewaveadjust = 0;
    level.hordelevelflip = 1;
    level.hordeempduration = 60;
    level.hordepreviousfailureevent = "None";
    level.hordeweaponsjammed = 0;
    level.zombiesstarted = 0;
    level.onlydronesremaining = 0;
    level.fastesttime = undefined;
    level.numdroneswaitingtospawn = 0;
    level.droneweapon = "remote_turret_mp";
    level.hordeclassic = 1;
    level.players_ready = 0;
    level.noonespawnedyet = 1;
    level.weaponcamoorder = [ "0", "01", "03", "05", "06", "12", "09", "11", "14", "13", "15", "01", "03", "05", "06", "12", "09", "11", "14", "15", "16" ];
    level.horderoundstats = [];
    level.horderoundstats["support_drops_earned"] = 0;
    level.horderoundstats["round_time"] = 0;
    level.horderoundstats["objective_points"] = 0;
    level.classsettings = [];
    level.classsettings["light"]["classhealth"] = 125;
    level.classsettings["light"]["classDmgMod"] = 1;
    level.classsettings["light"]["allowDodge"] = 1;
    level.classsettings["light"]["allowSlide"] = 1;
    level.classsettings["light"]["speed"] = 1.15;
    level.classsettings["light"]["killstreak"] = "uav";
    level.classsettings["light"]["exoAbility"] = "exohoverhorde_equipment_mp";
    level.classsettings["light"]["classGrenade"] = "frag_grenade_horde_mp";
    level.classsettings["light"]["battery"] = 100;
    level.classsettings["heavy"]["classhealth"] = 250;
    level.classsettings["heavy"]["classDmgMod"] = 1.15;
    level.classsettings["heavy"]["allowDodge"] = 0;
    level.classsettings["heavy"]["allowSlide"] = 0;
    level.classsettings["heavy"]["speed"] = 0.9;
    level.classsettings["heavy"]["killstreak"] = "heavy_exosuit";
    level.classsettings["heavy"]["exoAbility"] = "exoshieldhorde_equipment_mp";
    level.classsettings["heavy"]["classGrenade"] = "frag_grenade_horde_mp";
    level.classsettings["heavy"]["battery"] = 100;
    level.classsettings["support"]["classhealth"] = 150;
    level.classsettings["support"]["classDmgMod"] = 1;
    level.classsettings["support"]["allowDodge"] = 0;
    level.classsettings["support"]["allowSlide"] = 0;
    level.classsettings["support"]["speed"] = 1;
    level.classsettings["support"]["killstreak"] = "remote_mg_sentry_turret";
    level.classsettings["support"]["exoAbility"] = "exocloakhorde_equipment_mp";
    level.classsettings["support"]["classGrenade"] = "frag_grenade_horde_mp";
    level.classsettings["support"]["battery"] = 100;
    level.classsettings["demolition"]["classhealth"] = 150;
    level.classsettings["demolition"]["classDmgMod"] = 1;
    level.classsettings["demolition"]["allowDodge"] = 0;
    level.classsettings["demolition"]["allowSlide"] = 1;
    level.classsettings["demolition"]["speed"] = 1;
    level.classsettings["demolition"]["killstreak"] = "missile_strike";
    level.classsettings["demolition"]["exoAbility"] = "exorepulsor_equipment_mp";
    level.classsettings["demolition"]["classGrenade"] = "contact_grenade_horde_mp";
    level.classsettings["demolition"]["battery"] = 100;
    level.modifiershieldaitypes = [];
    level.modifierexplosiveaitypes = [];
    level.modifiercompanionaitypes = [];
    level.modifiertoxicaitypes = [];
    level.hordemodedodgers = [ "assault", "assault_elite", "em1", "em1_heavy", "cloak", "rocket", "em1_heavy" ];
    level.hordemodegrunts = [ "shotgun", "smg", "assault", "em1" ];
    level.hordemodeelites = [ "em1_heavy", "assault_elite", "rocket", "cloak", "epm3", "handler" ];
    level.hordemodespecials = [ "Quad", "jugg", "jugg_handler", "em1_heavy" ];
    level.hordegetoutsideposition = ::hordegetoutsideposition;
    level.hordedome = getentarray( "horde_dome", "targetname" );
    level thread watchforhostmigrationselectclass();
    level thread hordeexploitclip();
    thread maps\mp\gametypes\_horde_warbird::horde_setup_warbird_pathnode_patch();
}

hordegetoutsideposition()
{
    sortdroplocations();
    var_0 = level.hordedroplocations[0];
    level.hordeuseddroplocations[level.hordeuseddroplocations.size] = var_0;
    level.hordedroplocations = common_scripts\utility::array_remove( level.hordedroplocations, var_0 );
    return var_0;
}

hordeautoassign()
{
    thread maps\mp\gametypes\_menus::setteam( level.playerteam );
}

loadeffects()
{
    level._effect["spawn_effect"] = loadfx( "fx/maps/mp_siege_dam/mp_siege_spawn" );
    level._effect["drone_fan_distortion"] = loadfx( "vfx/distortion/drone_fan_distortion" );
    level._effect["drone_fan_distortion_large"] = loadfx( "vfx/distortion/drone_fan_distortion_large" );
    level._effect["drone_thruster_distortion"] = loadfx( "vfx/distortion/drone_thruster_distortion" );
    level._effect["pdrone_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["pdrone_emp_death"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["drone_beacon_red"] = loadfx( "vfx/lights/light_drone_beacon_red" );
    level._effect["drone_beacon_red_fast"] = loadfx( "vfx/lights/light_drone_beacon_red_fast" );
    level._effect["drone_beacon_red_slow_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_slow_nolight" );
    level._effect["drone_beacon_red_sm_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_sm_nolight" );
    level._effect["emp_drone_damage"] = loadfx( "vfx/sparks/emp_drone_damage" );
    level._effect["tracking_grenade_spray_large"] = loadfx( "vfx/trail/tracking_grenade_hovering" );
    level._effect["tracking_grenade_spray_small"] = loadfx( "vfx/trail/tracking_grenade_spay_small" );
    level._effect["tracking_grenade_trail"] = loadfx( "vfx/trail/tracking_grenade_trail" );
    level._effect["toxic_gas"] = loadfx( "vfx/props/flare_ambient_green" );
}

initpickups()
{
    level.maxpickupsperround = getmaxpickupsperround();
    level.maxammopickupsperround = 4;
    level.currentpickupcount = 0;
    level.currentammopickupcount = 0;
    level.ammopickupmodel = "mil_grenade_box";
    level.collectpickupmodel = "prop_dogtags_future_enemy_animated";
    level.ammopickupfunc = ::ammopickup;
    level.collectpickupfunc = ::collectpickup;
}

waitthenflashhudtimer( var_0 )
{
    level endon( "all_players_ready" );
    level endon( "collect_complete" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    settimeromnvar( "ui_cranked_bomb_timer_final_seconds", 1 );
}

sethudtimer( var_0, var_1 )
{
    level thread waitthenflashhudtimer( var_1 - 5 );
    settimeromnvar( "ui_cranked_bomb_timer_text", var_0 );
    settimeromnvar( "ui_cranked_bomb_timer_end_milliseconds", int( gettime() + var_1 * 1000 ) );
}

clearhudtimer()
{
    settimeromnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

settimeromnvar( var_0, var_1 )
{
    level.timeromnvars[var_0] = var_1;

    foreach ( var_3 in level.players )
    {
        if ( !isagent( var_3 ) )
            var_3 setclientomnvar( var_0, var_1 );
    }
}

updatetimeromnvars( var_0 )
{
    foreach ( var_3, var_2 in level.timeromnvars )
    {
        if ( !isagent( var_0 ) )
            var_0 setclientomnvar( var_3, var_2 );
    }
}

getmaxpickupsperround()
{
    var_0 = maps\mp\gametypes\_horde_util::getnumplayers() + 1;
    return clamp( var_0, 3, 5 );
}

initializematchrules()
{
    maps\mp\_utility::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_horde_roundswitch", 0 );
    maps\mp\_utility::registerroundswitchdvar( "horde", 0, 0, 9 );
    setdynamicdvar( "scr_horde_roundlimit", 1 );
    maps\mp\_utility::registerroundlimitdvar( "horde", 1 );
    setdynamicdvar( "scr_horde_winlimit", 1 );
    maps\mp\_utility::registerwinlimitdvar( "horde", 1 );
    setdynamicdvar( "scr_horde_halftime", 0 );
    maps\mp\_utility::registerhalftimedvar( "horde", 0 );
    setdynamicdvar( "scr_horde_timeLimit", 0 );
    maps\mp\_utility::registertimelimitdvar( level.gametype, 0 );
    setdynamicdvar( "scr_horde_numLives", 1 );
    maps\mp\_utility::registernumlivesdvar( level.gametype, 1 );
    setdynamicdvar( "scr_horde_difficulty", getmatchrulesdata( "hordeData", "difficulty" ) );
    setdynamicdvar( "scr_horde_startinground", getmatchrulesdata( "hordeData", "startingWave" ) );
    setdynamicdvar( "scr_horde_hardcore", getmatchrulesdata( "hordeData", "supportDropsOff" ) );
    setdynamicdvar( "r_hudOutlineWidth", 2 );
}

onstartgametype()
{
    setclientnamemode( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    maps\mp\_utility::setobjectivetext( "allies", &"OBJECTIVES_DOM" );
    maps\mp\_utility::setobjectivetext( "axis", &"OBJECTIVES_DOM" );
    maps\mp\_utility::setobjectivescoretext( "allies", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::setobjectivescoretext( "axis", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::setobjectivehinttext( "allies", &"HORDE_OBJECTIVE_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"HORDE_OBJECTIVE_HINT" );
    initspawns();
    maps\mp\gametypes\_horde_dialog::hordedialoginit();
    var_0[0] = level.gametype;
    maps\mp\gametypes\_gameobjects::main( var_0 );
    inithordesettings();
    level thread monitoronlydrones();
    level thread onplayerconnecthorde();
    level thread runhordemode();

    if ( !level.hordeishardcore )
        level thread rundroplocations();
}

inithordesettings()
{
    setdvar( "g_keyboarduseholdtime", 250 );
    level.hordedroplocations = common_scripts\utility::getstructarray( "horde_drop", "targetname" );
    level.hordeuseddroplocations = [];
    level.intelminigun = "iw6_minigunjugg_mp";
    level.hordedifficultylevel = int( clamp( getdvarint( "scr_horde_difficulty" ), 0, 2 ) );
    level.hordestartinground = getdvarint( "scr_horde_startinground" );
    level.hordeishardcore = getdvarint( "scr_horde_hardcore" );
    level.maxrounds = 25;
    level.currentroundnumber = 0;
    level.currentpointtotal = 0;
    level.enemyoutlinecolor = 0;
    level.droplocationindex = 0;
    hordedroplocationtrace();
    level.chancetospawndog = 0;
    level.lastdoground = 0;
    level.pointevents = [];
    level.pointevents["damage_body"] = 10;
    level.pointevents["damage_head"] = 30;
    level.pointevents["kill_normal"] = 20;
    level.pointevents["kill_melee"] = 50;
    level.pointevents["kill_head"] = 50;
    level.pointevents["kill_defend"] = 50;
    level.pointevents["collect"] = 50;
    level.hudleftspace = 50;
    level.huddownspace = 395;

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
        level.maxrounds = 12;
}

hordedroplocationtrace()
{
    foreach ( var_1 in level.hordedroplocations )
    {
        var_2 = var_1.origin + ( 0, 0, 32 );
        var_3 = var_1.origin - ( 0, 0, 256 );
        var_4 = bullettrace( var_2, var_3, 0 );
        var_1.tracelocation = var_1.origin;

        if ( var_4["fraction"] < 1 )
            var_1.tracelocation = var_4["position"];
    }
}

onplayerconnecthorde()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.gamemodefirstspawn = 1;
        level thread createplayervariables( var_0 );
        level thread monitorstuck( var_0 );
        level thread monitordome( var_0 );
        level thread updateoutlines( var_0 );
        level thread updateobjectiveui( var_0 );
        level thread maps\mp\gametypes\_horde_smart_grenade::monitorsmartgrenade( var_0 );
        level thread maps\mp\gametypes\_horde_util::hordeupdatenummatches( var_0 );
        level thread monitorplayercamping( var_0 );
        level thread monitordisconnect( var_0 );

        if ( isdefined( level.objdefend ) && level.objdefend )
            level thread hordedefendenemyoutline( var_0 );

        thread forceclassselection( var_0 );
        var_0 thread maps\mp\gametypes\_horde_armory::closehordearmoryonoffhandweapon();
    }
}

forceclassselection( var_0 )
{
    var_0 endon( "horde_class_change" );
    var_0 endon( "disconnect" );
    var_0.usingarmory = 1;
    var_0.classselection = 1;
    thread monitorclassselection( var_0 );
    var_1 = var_0 common_scripts\utility::waittill_any_timeout( 60, "death", "becameSpectator" );
    var_0 setclientomnvar( "ui_horde_show_armory", 0 );
    var_0.usingarmory = 0;
    var_0.classselection = 0;

    if ( var_1 == "timeout" )
        var_0 notify( "luinotifyserver", "horde_exo_class", 100 );
}

monitorclassselection( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "horde_class_change" );
    var_0 endon( "death" );
    var_0 endon( "becameSpectator" );

    for (;;)
    {
        var_0 waittill( "luinotifyserver", var_1, var_2 );

        if ( var_1 == "horde_armory_closed" )
        {
            wait 0.5;
            var_0 setclientomnvar( "ui_horde_armory_type", "class" );
            var_0 setclientomnvar( "ui_horde_show_armory", 1 );
        }
    }
}

monitordisconnect( var_0 )
{
    level endon( "game_ended" );
    var_0 waittill( "disconnect" );
    level notify( "player_disconnected" );
}

createplayervariables( var_0 )
{
    var_0.horde_perks = [];
    var_0.pointnotifylua = [];
    var_0.beingrevived = 0;
    var_0.wasunderwater = 0;
    var_0.hasselfrevive = 0;
    var_0.saveweapons = [];
    var_0.firstsaveweapon = "none";
    var_0.classselection = 0;
    var_0.killz = 0;
    var_0.numrevives = int( 0 );
    var_0.numcratesobtained = 0;
    var_0.roundsplayed = 0;
    var_0.horde_score = int( 0 );
    var_0.deaths = 511;
    var_0 maps\mp\_utility::setpersstat( "deaths", var_0.deaths );
    var_0.objectivescompleted = 0;
    var_0.meleekills = 0;
    var_0.headshotkills = 0;
    var_0.numsincesamedroptype = 0;
    var_0.lastdroptype = "none";
    var_0.roundkills = 0;
    var_0.roundheadshots = 0;
    var_0.roundupgradepoints = 0;
    var_0.hordeheadshots = 0;
    var_0.armorypoints = 0;
    var_0.collectcount = 0;
    var_0.classdmgmod = 1;
    var_0.weaponproficiency = 0;
    var_0.hordearmor = 0;
    var_0.hordeexobattery = 0;
    var_0.energydmgmod = 1;
    var_0.weapondmgmod = 1;
    var_0.classabilitytime = 0;
    var_0.classabilityready = 1;
    var_0.classchosen = 0;
    var_0.hordeclassturret = undefined;
    var_0.isrunningarmorycommand = 0;
    var_0.classswitchwaiting = 0;
    var_0.isrunningweapongive = 0;
    var_0.missileweapon = undefined;
    var_0.rocket = undefined;
    var_0.markedformech = [];
    var_0.aerialassaultdrone = undefined;
    var_0.hordeclassweapons["light"]["primary"] = "iw5_kf5_mp";
    var_0.hordeclassweapons["light"]["secondary"] = "iw5_titan45_mp_xmags";
    var_0.hordeclassweapons["support"]["primary"] = "iw5_uts19_mp";
    var_0.hordeclassweapons["support"]["secondary"] = "iw5_vbr_mp_xmags";
    var_0.hordeclassweapons["heavy"]["primary"] = "iw5_em1_mp";
    var_0.hordeclassweapons["heavy"]["secondary"] = "iw5_pbw_mp_xmags";
    var_0.hordeclassweapons["demolition"]["primary"] = "iw5_microdronelaunchercoop_mp";
    var_0.hordeclassweapons["demolition"]["secondary"] = "iw5_titan45_mp_xmags";
    var_0.hordekillstreakmodules = [ "sentry_guardian", "assault_ugv_ai", "assault_ugv_mg" ];
    var_0.classsettings = level.classsettings;
    var_0.ignoreme = 1;

    if ( 1 )
    {
        if ( 0 )
            level.playerstartweaponname = "iw5_kf5_mp_none";
        else
            level.playerstartweaponname = "iw5_kf5_mp";

        var_1 = getweaponbasename( level.playerstartweaponname );
    }

    level thread activateplayerhud( var_0 );
    level thread monitorpointnotifylua( var_0 );
    level thread maps\mp\gametypes\_horde_armory::monitorupgrades( var_0 );
    maps\mp\gametypes\_horde_util::hordecleardata( var_0 );
    maps\mp\gametypes\_horde_util::hordecompletetu1transition( var_0 );

    if ( maps\mp\_utility::matchmakinggame() )
        monitorinactivity( var_0 );
}

monitorinactivity( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        var_3 = var_0 getnormalizedmovement();

        if ( var_0 attackbuttonpressed() || var_0 adsbuttonpressed() || var_0 meleebuttonpressed() || var_0 fragbuttonpressed() || var_0 secondaryoffhandbuttonpressed() || var_0 jumpbuttonpressed() || var_0 sprintbuttonpressed() || var_3[0] != 0 || var_3[1] != 0 )
        {
            var_1 = 0;
            var_2 = 0;
        }

        if ( var_1 >= 180 )
        {
            kick( var_0 getentitynumber(), "EXE_PLAYERKICKED_INACTIVE" );
            break;
        }
        else if ( var_1 >= 170 && !var_2 )
        {
            var_0 iprintlnbold( &"GAME_INACTIVEDROPWARNING" );
            var_2 = 1;
        }

        if ( var_0.sessionstate != "spectator" )
            var_1 += 0.05;

        if ( level.zombiesstarted )
            break;

        wait 0.05;
    }
}

hasweaponstate( var_0, var_1 )
{
    return isdefined( var_1 ) && isdefined( var_0.weaponstate[var_1] );
}

playaispawneffect()
{
    playfx( level._effect["spawn_effect"], self.origin );
}

onspawnplayer()
{
    var_0 = undefined;

    if ( self.gamemodefirstspawn )
    {
        self.pers["class"] = "gamemode";
        self.pers["lastClass"] = "";
        self.pers["gamemodeLoadout"] = level.hordeloadouts[level.playerteam];
        self.class = self.pers["class"];
        self.lastclass = self.pers["lastClass"];
        maps\mp\gametypes\_class::giveloadout( self.team, self.class );
        self.maxhealth = 200;
        self.health = self.maxhealth;
    }

    if ( isagent( self ) )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
        {
            setenemydifficultysettings( self );
            var_0 = self.hordeloadout;
            self.pers["gamemodeLoadout"] = var_0;
            self.horde_type = var_0["type"];
            self.awardpoints = var_0["points"];

            if ( var_0["type"] == "zombie" )
                self.agentname = undefined;
            else
                self.agentname = var_0["name_localized"];

            thread playaispawneffect();
            self botsetdifficultysetting( "allowGrenades", 1 );
        }
        else
        {
            self.pers["gamemodeLoadout"] = level.hordeloadouts["squadmate"];
            maps\mp\bots\_bots_util::bot_set_personality( "camper" );
            maps\mp\bots\_bots_util::bot_set_difficulty( "regular" );
            self botsetdifficultysetting( "allowGrenades", 1 );
        }

        self.avoidkillstreakonspawntimer = 0;
    }

    thread onspawnfinished( var_0 );
}

setenemydifficultysettings( var_0 )
{
    var_0 maps\mp\bots\_bots_util::bot_set_personality( "run_and_gun" );
    var_0 maps\mp\bots\_bots_util::bot_set_difficulty( "recruit" );
    var_0 hordeaddgeneraltuningvalues();
}

onspawnfinished( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !self.gamemodefirstspawn )
        return;

    self waittill( "applyLoadout" );
    maps\mp\killstreaks\_killstreaks::clearkillstreaks();

    if ( maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
    {
        self givemaxammo( level.playerstartweaponname );

        if ( self.gamemodefirstspawn )
            self setclientomnvar( "ui_horde_show_armory", 1 );

        if ( isplayer( self ) )
        {
            self setweaponammoclip( "frag_grenade_mp", 1 );
            self setweaponammoclip( "none", 0 );
            self setclientomnvar( "exo_ability_nrg_total0", 0 );
            self setclientomnvar( "ui_exo_battery_level0", 0 );
            self takeweapon( "frag_grenade_mp" );
            self setlethalweapon( "frag_grenade_horde_mp" );
            self giveweapon( "frag_grenade_horde_mp" );
            self setweaponammoclip( "frag_grenade_horde_mp", 4 );
            maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
            maps\mp\_utility::giveperk( "specialty_horde_dualprimary", 1, 1 );
            self loadweapons( [ "iw5_em1_mp", "iw5_kf5_mp", "iw5_uts19_mp", "iw5_titan45_mp", "iw5_vbr_mp", "iw5_pbw_mp" ] );
            self loadweapons( [ "iw5_microdronelauncher_mp", "iw5_microdronelaunchercoop_mp" ] );
            self loadweapons( maps\mp\gametypes\_horde_laststand::hordelaststandweapon() );
            childthread updaterespawnsplash( self.gamemodefirstspawn );
            removeperkhud( self );
            updatetimeromnvars( self );
        }

        if ( isagent( self ) )
        {
            self.agentname = &"HORDE_GRUNT";
            self.horde_type = "Buddy";
            childthread ammorefillprimary();
            thread maps\mp\bots\_bots::bot_think_revive();
        }
    }
    else
    {
        childthread ammorefillprimary();
        childthread ammorefillsecondary();
        self.maxhealth = hordegetenemyhealth( var_0 );
        self.health = self.maxhealth;
        hordeaddnavigationabilities();

        if ( self.horde_type != "zombie" )
            hordeapplyaimodifiers();

        switch ( self.horde_type )
        {
            case "shotgun":
                self.agentname = &"HORDE_GRUNT";
                self botsetdifficultysetting( "maxNonAutoFireDelay", 1500 );
                self botsetdifficultysetting( "minNonAutoFireDelay", 800 );
                self setagentcostumeindex( randomintrange( 1, 5 ) );
                break;
            case "smg":
                self.agentname = &"HORDE_GUNNER";
                hordesetcharactermodel( "kva_body_smg_mp", "kva_head_smg" );
                self botsetdifficultysetting( "minBurstFireTime", 100 );
                self botsetdifficultysetting( "maxBurstFireTime", 600 );
                self botsetdifficultysetting( "minTimeBetweenBursts", 600 );
                self botsetdifficultysetting( "maxTimeBetweenBursts", 1500 );
                self botsetdifficultysetting( "dodgeChance", 0.3 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.8 );
                self setagentcostumeindex( randomintrange( 5, 9 ) );
                break;
            case "cloak":
                self.agentname = &"HORDE_ASSASSIN";
                self.movespeedscaler = var_0["movespeedscale"];
                self botsetdifficultysetting( "minBurstFireTime", 200 );
                self botsetdifficultysetting( "maxBurstFireTime", 1000 );
                self botsetdifficultysetting( "minTimeBetweenBursts", 500 );
                self botsetdifficultysetting( "maxTimeBetweenBursts", 1200 );
                self botsetdifficultysetting( "dodgeChance", 0.8 );
                self botsetdifficultysetting( "dodgeIntelligence", 1.0 );
                self setagentcostumeindex( 10 );
                self cloakingenable();
                break;
            case "assault":
                self.agentname = &"HORDE_ASSAULT";
                self botsetdifficultysetting( "minBurstFireTime", 400 );
                self botsetdifficultysetting( "maxBurstFireTime", 1200 );
                self botsetdifficultysetting( "minTimeBetweenBursts", 400 );
                self botsetdifficultysetting( "maxTimeBetweenBursts", 1200 );
                self botsetdifficultysetting( "dodgeChance", 0.6 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.8 );

                if ( level.hordelevelflip < 2 )
                {
                    self botsetdifficultysetting( "strafeChance", 0.4 );
                    self botsetdifficultysetting( "reactionTime", 425 );
                }

                self setagentcostumeindex( 10 );
                break;
            case "assault_elite":
                self.agentname = &"HORDE_ELITE";
                self botsetdifficultysetting( "minBurstFireTime", 600 );
                self botsetdifficultysetting( "maxBurstFireTime", 2400 );
                self botsetdifficultysetting( "minTimeBetweenBursts", 100 );
                self botsetdifficultysetting( "maxTimeBetweenBursts", 600 );
                self botsetdifficultysetting( "dodgeChance", 0.6 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.8 );
                self botsetdifficultysetting( "reactionTime", 100 );
                self botsetdifficultysetting( "diveChance", 0.2 );

                if ( level.hordelevelflip < 3 )
                    self botsetdifficultysetting( "strafeChance", 0.7 );

                self setagentcostumeindex( randomintrange( 19, 23 ) );

                if ( level.hordelevelflip > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                {
                    self takeallweapons();
                    self giveweapon( "turretheadmg_mp" );
                    self switchtoweaponimmediate( "turretheadmg_mp" );
                }

                break;
            case "epm3":
                self.agentname = &"HORDE_EPM3";
                self botsetdifficultysetting( "dodgeChance", 0.4 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.8 );
                self botsetdifficultysetting( "minInaccuracy", 0.1 );
                self botsetdifficultysetting( "maxInaccuracy", 0.15 );
                self botsetdifficultysetting( "minNonAutoFireDelay", 200 );
                self botsetdifficultysetting( "maxNonAutoFireDelay", 400 );

                if ( level.hordelevelflip < 3 )
                    self botsetdifficultysetting( "reactionTime", 200 );

                if ( level.hordelevelflip < 2 )
                    self botsetdifficultysetting( "strafeChance", 0.5 );

                self setagentcostumeindex( 15 );
                break;
            case "em1":
                self.agentname = &"HORDE_BEAMER";
                hordesetcharactermodel( "kva_hazmat_body_a_mp", "kva_hazmat_head_a" );
                self botsetdifficultysetting( "dodgeChance", 0.3 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.5 );
                self botsetdifficultysetting( "maxNonAutoFireDelay", 2800 );
                self botsetdifficultysetting( "minNonAutoFireDelay", 1500 );
                self setagentcostumeindex( 9 );
                break;
            case "em1_heavy":
                self.agentname = &"HORDE_BEAMER_HEAVY";
                hordesetcharactermodel( "nk_army_assault_body_mp", "nk_army_a_head" );
                self botsetdifficultysetting( "dodgeChance", 0.5 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.5 );
                self botsetdifficultysetting( "maxNonAutoFireDelay", 1400 );
                self botsetdifficultysetting( "minNonAutoFireDelay", 750 );
                self setagentcostumeindex( 18 );
                break;
            case "rocket":
                self.agentname = &"HORDE_LAUNCHER";
                hordesetcharactermodel( "atlas_arctic_guard_body_mp", "atlas_arctic_head_a" );
                self botsetdifficultysetting( "maxNonAutoFireDelay", 2000 );
                self botsetdifficultysetting( "minNonAutoFireDelay", 1000 );
                self setagentcostumeindex( 17 );

                if ( level.hordelevelflip > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                {
                    self takeallweapons();
                    self giveweapon( "turretheadrocket_mp" );
                    self switchtoweaponimmediate( "turretheadrocket_mp" );
                }

                break;
            case "jugg":
                self.agentname = &"HORDE_AST";
                maps\mp\killstreaks\_juggernaut::playersetjuggexomodel();
                self setplayermech( 1 );
                self botsetstance( "stand" );
                self allowjump( 0 );
                self allowladder( 0 );
                self allowmantle( 0 );
                self allowcrouch( 0 );
                self allowprone( 0 );
                maps\mp\_utility::playerallowhighjump( 0, "class" );
                maps\mp\_utility::playerallowdodge( 0, "class" );
                hordeattachminigunbarrel();
                thread hordeaddcompaniondrone( 1, 1, 1 );
                thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
                thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();

                if ( maps\mp\_utility::getmapname() == "mp_detroit" )
                    thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();

                break;
            case "jugg_handler":
                self.agentname = &"HORDE_AST";
                maps\mp\killstreaks\_juggernaut::playersetjuggexomodel();
                self setplayermech( 1 );
                thread hordeaddcompaniondrone( 1, 1, 1 );
                self botsetstance( "stand" );
                self allowjump( 0 );
                self allowladder( 0 );
                self allowmantle( 0 );
                self allowcrouch( 0 );
                self allowprone( 0 );
                maps\mp\_utility::playerallowhighjump( 0, "class" );
                maps\mp\_utility::playerallowdodge( 0, "class" );
                hordeattachminigunbarrel();
                thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
                thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();

                if ( maps\mp\_utility::getmapname() == "mp_detroit" )
                    thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();

                if ( level.currentroundnumber > 13 || level.hordelevelflip > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                    thread maps\mp\agents\_agents_gametype_horde::hordejuggrocketswarmthink();

                break;
            case "handler":
                self.agentname = &"HORDE_HANDLER";
                self botsetdifficultysetting( "minBurstFireTime", 1500 );
                self botsetdifficultysetting( "maxBurstFireTime", 3000 );
                self botsetdifficultysetting( "dodgeChance", 0.2 );
                self botsetdifficultysetting( "dodgeIntelligence", 0.4 );
                thread hordeaddcompaniondrone();
                self setagentcostumeindex( randomintrange( 11, 15 ) );
                break;
            case "zombie":
                maps\mp\gametypes\_horde_zombies::hordesetzombiemodel();
                maps\mp\gametypes\_horde_zombies::hordezombiesounds();
                self botsetstance( "stand" );
                self allowcrouch( 0 );
                break;
            default:
        }

        self setclothtype( "cloth" );
    }

    self.gamemodefirstspawn = 0;
}

hordeattachminigunbarrel()
{
    self.barrellinker = spawn( "script_model", self gettagorigin( "tag_barrel" ) );
    self.barrellinker setmodel( "generic_prop_raven" );
    self.barrellinker vehicle_jetbikesethoverforcescale( self, "tag_barrel", ( 12.7, 0, -2.9 ), ( 90, 0, 0 ) );
    self.barrel = spawn( "script_model", self.barrellinker gettagorigin( "j_prop_1" ) );
    self.barrel setmodel( "npc_exo_armor_minigun_barrel" );
    self.barrel vehicle_jetbikesethoverforcescale( self.barrellinker, "j_prop_1", ( 0, 0, 0 ), ( -90, 0, 0 ) );
}

hordeaddgeneraltuningvalues()
{
    var_0 = self;
    var_0 botsetdifficultysetting( "visionBlinded", 0.05 );
    var_0 botsetdifficultysetting( "hearingDeaf", 0.05 );
    var_0 botsetdifficultysetting( "targetVehicleChance", 1 );
    var_0 botsetdifficultysetting( "meleeReactAllowed", 1 );
    var_0 botsetdifficultysetting( "meleeReactionTime", 600 );
    var_0 botsetdifficultysetting( "meleeDist", 85 );
    var_0 botsetdifficultysetting( "meleeChargeDist", 100 );
    var_0 botsetdifficultysetting( "minBurstFireTime", 400 );
    var_0 botsetdifficultysetting( "maxBurstFireTime", 2400 );
    var_0 botsetdifficultysetting( "minTimeBetweenBursts", 400 );
    var_0 botsetdifficultysetting( "maxTimeBetweenBursts", 1200 );
    var_0 botsetdifficultysetting( "dodgeChance", 0.0 );
    var_0 botsetdifficultysetting( "dodgeIntelligence", 0.0 );
    var_0 botsetdifficultysetting( "strafeChance", 0.35 );
    var_0 botsetdifficultysetting( "avoidSkyPercent", 0 );

    if ( level.currentroundnumber > 8 && level.hordelevelflip == 1 )
    {
        var_0 botsetdifficultysetting( "minInaccuracy", 0.75 );
        var_0 botsetdifficultysetting( "maxInaccuracy", 1.5 );
    }
    else if ( level.hordelevelflip == 1 )
    {
        var_0 botsetdifficultysetting( "minInaccuracy", 2.25 );
        var_0 botsetdifficultysetting( "maxInaccuracy", 4.5 );
    }

    if ( level.currentroundnumber > 20 || level.hordelevelflip > 1 )
    {
        var_0 botsetdifficultysetting( "adsAllowed", 1 );
        var_0 botsetdifficultysetting( "diveChance", 0.15 );
        var_0 botsetdifficultysetting( "strafeChance", 0.5 );
        var_0 botsetdifficultysetting( "strategyLevel", 1 );
    }

    if ( level.hordelevelflip == 2 )
    {
        var_0 botsetdifficultysetting( "reactionTime", 200 );
        var_0 botsetdifficultysetting( "strategyLevel", 3 );
        var_0 botsetdifficultysetting( "cornerFireChance", 0.5 );
        var_0 botsetdifficultysetting( "cornerJumpChance", 0.3 );
        var_0 botsetdifficultysetting( "strafeChance", 0.7 );
        var_0 botsetdifficultysetting( "diveChance", 0.2 );
        var_0 botsetdifficultysetting( "launcherRespawnChance", 0.25 );
        var_0 botsetdifficultysetting( "minInaccuracy", 0.5 );
        var_0 botsetdifficultysetting( "maxInaccuracy", 1.0 );
        var_0 botsetdifficultysetting( "grenadeCookPrecision", 500 );
    }
    else if ( level.hordelevelflip > 2 )
    {
        var_0 botsetdifficultysetting( "reactionTime", 100 );
        var_0 botsetdifficultysetting( "strategyLevel", 3 );
        var_0 botsetdifficultysetting( "cornerFireChance", 1.0 );
        var_0 botsetdifficultysetting( "cornerJumpChance", 0.75 );
        var_0 botsetdifficultysetting( "diveChance", 0.2 );
        var_0 botsetdifficultysetting( "strafeChance", 0.9 );
        var_0 botsetdifficultysetting( "launcherRespawnChance", 0.4 );
        var_0 botsetdifficultysetting( "minInaccuracy", 0.25 );
        var_0 botsetdifficultysetting( "maxInaccuracy", 0.75 );
        var_0 botsetdifficultysetting( "grenadeCookPrecision", 100 );
    }
}

hordeaddnavigationabilities()
{
    var_0 = self;

    if ( isdefined( var_0.horde_type ) && var_0.horde_type == "jugg" || var_0.horde_type == "jugg_handler" )
        return;

    if ( level.hordelevelflip > 1 || level.currentroundnumber >= 8 )
    {
        if ( isdefined( var_0.horde_type ) && !common_scripts\utility::array_contains( level.hordemodedodgers, var_0.horde_type ) )
            return;

        if ( common_scripts\utility::cointoss() )
            return;

        var_0 maps\mp\_utility::playerallowdodge( 1, "class" );
        var_0 botsetdifficultysetting( "dodgeChance", 0.3 );
        var_0 botsetdifficultysetting( "dodgeIntelligence", 0.8 );
    }
    else if ( level.currentroundnumber < 3 )
        var_0 maps\mp\_utility::playerallowdodge( 0, "class" );
}

hordeapplyaimodifiers()
{
    if ( level.hordelevelflip == 1 && level.currentroundnumber < 12 )
        return;

    var_0 = clamp( level.hordelevelflip, 1, 4 );

    switch ( int( var_0 ) )
    {
        case 4:
            if ( maps\mp\_utility::currentactivevehiclecount( 2 ) < maps\mp\_utility::maxvehiclesallowed() )
            {
                if ( hordeapplyaimodifiersdiceroll( level.modifiercompanionaitypes, clamp( 5 * level.hordelevelflip, 5, 25 ) ) )
                    thread hordeaddcompaniondrone();
            }
        case 3:
            if ( hordeapplyaimodifiersdiceroll( level.modifierexplosiveaitypes, clamp( 10 * level.hordelevelflip, 10, 45 ) ) )
                thread hordeaddexplosivedeath();
        case 2:
            if ( hordeapplyaimodifiersdiceroll( level.modifiershieldaitypes, clamp( 20 * level.hordelevelflip, 20, 75 ) ) )
            {
                hordeaddexoshield();
                return;
            }
    }
}

hordeapplyaimodifiersdiceroll( var_0, var_1 )
{
    if ( common_scripts\utility::array_contains( var_0, self.horde_type ) && maps\mp\gametypes\_horde_util::cointossweighted( var_1 ) )
        return 1;

    return 0;
}

hordeaddtoxicgas()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "tag_origin" );
    waitframe();
    var_0 linkto( self, "tag_origin", ( 0, 0, 16 ), ( 0, 0, 0 ) );
    wait 1;

    foreach ( var_2 in level.players )
        playfxontagforclients( common_scripts\utility::getfx( "toxic_gas" ), var_0, "tag_origin", var_2 );

    thread hordeaddtoxicgasthink();
    thread hordeaddtoxicgascleanup( var_0 );
}

hordeaddtoxicgascleanup( var_0 )
{
    self waittill( "death" );

    foreach ( var_2 in level.players )
        stopfxontagforclient( common_scripts\utility::getfx( "toxic_gas" ), var_0, "tag_origin", var_2 );

    var_0 delete();
}

hordeaddtoxicgasthink()
{
    self endon( "death" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( distance( self.origin, var_1.origin ) < 100 )
                var_1 shellshock( "mp_lab_gas", 1 );
        }

        wait 1;
    }
}

hordeaddexplosivedeath()
{
    self waittill( "death" );
    var_0 = self.origin;
    magicgrenademanual( "frag_grenade_mp", var_0, ( 0, 0, 0 ), 2 );
}

hordeaddexoshield()
{
    self botsetdifficultysetting( "allowGrenades", 1 );
    self botsetdifficultysetting( "exoTacticalAllowed", 1 );
    self.pers["numberOfTimesShieldUsed"] = 0;
    self settacticalweapon( "exoshieldhorde_equipment_mp" );
    self giveweapon( "exoshieldhorde_equipment_mp" );
    thread maps\mp\_exo_shield::exo_shield_think();
    maps\mp\_utility::giveperk( "specialty_extratactical", 0 );
    var_0 = self getweaponammoclip( "exoshieldhorde_equipment_mp" );
    self setweaponammoclip( "exoshieldhorde_equipment_mp", var_0 + 1 );
}

hordeaddcompaniondrone( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    for ( var_3 = 0; var_3 < var_0; var_3++ )
    {
        while ( maps\mp\_utility::currentactivevehiclecount( 2 ) >= maps\mp\_utility::maxvehiclesallowed() )
            wait 1;

        var_4 = maps\mp\_tracking_drone::createtrackingdrone();
        thread maps\mp\_tracking_drone::starttrackingdrone( var_4 );
        var_4 thread handlerdronethink( self, var_1, var_2 );
    }
}

handlerdronethink( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( var_1 )
        thread respawnhandlerdrone( var_0 );

    if ( var_2 )
    {
        var_0 common_scripts\utility::waittill_any_timeout( 30, "damage", "weapon_fired" );

        if ( isdefined( var_0 ) && isalive( var_0 ) )
            var_0 common_scripts\utility::waittill_any_timeout( randomintrange( 10, 20 ), "death" );
    }
    else
        var_0 waittill( "death" );

    self.maxhealth = 1;
    self playloopsound( level.trackingdronesettings.sound_lock );
    self notify( "leaving" );
    var_3 = maps\mp\gametypes\_horde_util::hordegetclosesthealthyplayer( self.origin );

    if ( !isdefined( var_3 ) )
    {
        thread maps\mp\_tracking_drone::trackingdroneexplode();
        return;
    }

    self setdronegoalpos( var_3, ( 0, 0, 72 ) );
    thread handlerdronedetonate( var_3 );
    common_scripts\utility::waittill_any_timeout( 10, "detonate" );
    self stoploopsound();
    self playsound( "drone_warning_beap" );
    wait 1.4;
    self radiusdamage( self.origin, 256, 200, 25, self, "MOD_EXPLOSIVE" );
    thread maps\mp\_tracking_drone::trackingdroneexplode();
}

respawnhandlerdrone( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self waittill( "death" );
    wait(randomintrange( 10, 15 ));

    if ( isdefined( var_0 ) )
        var_0 thread hordeaddcompaniondrone( 1, 1, 1 );
}

handlerdronedetonate( var_0 )
{
    self endon( "explode" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );

    while ( distance( self.origin, var_0.origin ) > 150 )
        wait 0.1;

    self notify( "detonate" );
}

updaterespawnsplash( var_0 )
{
    self waittill( "spawned_player" );

    if ( !var_0 )
        thread maps\mp\gametypes\_hud_message::splashnotify( "horde_respawn" );
}

monitorstuck( var_0 )
{
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "unresolved_collision" );
        maps\mp\_movers::unresolved_collision_nearest_node( var_0, 0 );
        wait 0.5;
    }
}

monitordome( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( level.hordedome[0] ) )
        return;

    for (;;)
    {
        while ( !var_0 maps\mp\_utility::isusingremote() )
            wait 0.1;

        foreach ( var_2 in level.hordedome )
            var_2 hide();

        foreach ( var_0 in level.players )
        {
            if ( !var_0 maps\mp\_utility::isusingremote() )
            {
                foreach ( var_2 in level.hordedome )
                    var_2 showtoplayer( var_0 );
            }
        }

        while ( var_0 maps\mp\_utility::isusingremote() )
            wait 0.1;

        foreach ( var_2 in level.hordedome )
            var_2 showtoplayer( var_0 );
    }
}

monitoronlydrones()
{
    level endon( "zombies_start" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 1;

        if ( isdefined( level.flying_attack_drones ) && level.flying_attack_drones.size > 0 && isdefined( level.currentaliveenemycount ) && isdefined( level.numdroneswaitingtospawn ) && level.flying_attack_drones.size + level.numdroneswaitingtospawn >= level.currentaliveenemycount )
        {
            foreach ( var_2 in level.players )
            {
                if ( maps\mp\_utility::isreallyalive( var_2 ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( var_2 ) )
                {
                    if ( var_2.armorypoints > 0 )
                    {
                        var_0 = 0;
                        break;
                    }

                    var_3 = 0;
                    var_4 = var_2 getweaponslistprimaries();

                    foreach ( var_6 in var_4 )
                    {
                        if ( var_2 getammocount( var_6 ) > 0 )
                        {
                            var_3 = 1;
                            break;
                        }
                    }

                    if ( var_3 )
                    {
                        var_0 = 0;
                        break;
                    }
                }
            }
        }
        else
            var_0 = 0;

        if ( var_0 )
        {
            foreach ( var_2 in level.players )
            {
                if ( maps\mp\_utility::isreallyalive( var_2 ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( var_2 ) )
                {
                    var_2 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_team_restock" );
                    maps\mp\gametypes\_horde_util::refillammohorde( var_2 );
                }
            }
        }

        wait 1;
    }
}

updateoutlines( var_0 )
{
    var_0 endon( "disconnect" );

    if ( level.currentroundnumber == 0 )
        return;

    if ( !isdefined( level.carepackages ) )
        return;

    foreach ( var_2 in level.carepackages )
    {
        if ( isdefined( var_2.outlinecolor ) )
            var_2.friendlymodel hudoutlineenable( var_2.outlinecolor, 0 );
    }

    wait 0.05;

    if ( !isdefined( level.characters ) )
        return;

    foreach ( var_5 in level.characters )
    {
        if ( isdefined( var_5.outlinecolor ) )
            var_5 hudoutlineenable( var_5.outlinecolor, 0 );
    }

    foreach ( var_8 in level.flying_attack_drones )
    {
        if ( isdefined( var_8.lasttwoenemies ) )
        {
            var_8 hudoutlineenable( level.enemyoutlinecolor, 0 );
            var_8.droneturret hudoutlineenable( level.enemyoutlinecolor, 0 );
            continue;
        }

        var_8 hudoutlineenable( level.enemyoutlinecolor, 1 );
        var_8.droneturret hudoutlineenable( level.enemyoutlinecolor, 1 );
    }

    foreach ( var_11 in level.spawnedwarbirds )
    {
        if ( isdefined( var_11.lasttwoenemies ) )
        {
            var_11 hudoutlineenable( level.enemyoutlinecolor, 0 );
            var_11.warbirdturret hudoutlineenable( level.enemyoutlinecolor, 0 );
            continue;
        }

        var_11 hudoutlineenable( level.enemyoutlinecolor, 1 );
        var_11.warbirdturret hudoutlineenable( level.enemyoutlinecolor, 1 );
    }

    if ( isdefined( level.hordearmories ) )
    {
        foreach ( var_14 in level.hordearmories )
        {
            var_15 = "specops_ui_exostore";

            if ( var_14.script_parameters == "specops_ui_equipmentstore" )
                var_15 = "specops_ui_weaponstore";

            var_14.headicon = var_14 maps\mp\_entityheadicons::setheadicon( var_0, var_15, ( 0, 0, 48 ), 4, 4, undefined, undefined, 0, 1, undefined, 0 );
        }
    }
}

updateobjectiveui( var_0 )
{
    if ( level.isobjectiveround )
    {
        setomnvar( "ui_horde_show_objstatus", 1 );

        if ( level.objdefend )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_defend" );
            setomnvar( "ui_horde_objcount_1", level.currentdefendloc.killcount );
            setomnvar( "ui_horde_objmax_1", level.horde_defend_killcount );
        }
        else if ( level.objcollect || level.objintel )
        {
            var_1 = "horde_collect";

            if ( level.objintel )
                var_1 = "horde_intel";

            var_0 setclientomnvar( "ui_horde_count_type", var_1 );
            setomnvar( "ui_horde_objcount_1", level.hordecollected );
            setomnvar( "ui_horde_objmax_1", level.horde_collect_count );
        }
        else if ( level.objdefuse )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_defuse" );
            setomnvar( "ui_horde_objcount_1", level.hordedefused );
            setomnvar( "ui_horde_objmax_1", level.horde_defuse_count );
        }
        else if ( level.objuplink )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_uplink" );
            setomnvar( "ui_horde_objcount_1", level.horde_ball_score );
            setomnvar( "ui_horde_objmax_1", level.horde_ball_score_count );
        }
    }
}

hordesetcharactermodel( var_0, var_1 )
{
    if ( getdvarint( "horde_set_character_models" ) == 1 || maps\mp\_utility::getmapname() == "mp_prison_z" && issubstr( var_0, "zombie" ) )
    {
        self detachall();
        self setmodel( var_0 );

        if ( isdefined( var_1 ) )
        {
            self.headmodel = var_1;
            self attach( self.headmodel, "", 1 );
        }
    }
}

ammorefillprimary()
{
    if ( self.primaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.primaryweapon );
        wait 12;
    }
}

ammorefillsecondary()
{
    if ( self.secondaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.secondaryweapon );
        wait 8;
    }
}

runhordemode()
{
    level endon( "game_ended" );
    waituntilmatchstart();
    maps\mp\gametypes\_horde_armory::initarmories();
    thread hordeinitdefuseobjects();

    if ( maps\mp\_utility::getmapname() != "mp_prison_z" )
        thread hordeinituplinkobjects();

    horderandomizeaimodifiertypes();
    level.turretsettings["mg_turret"].timeout = 120.0;

    foreach ( var_1 in level.players )
    {
        if ( var_1.class == "gamemode" )
        {

        }

        if ( level.players.size < 2 )
            var_1.hasselfrevive = 1;
    }

    maps\mp\gametypes\_horde_drones::flying_attack_drone_system_init();
    maps\mp\gametypes\_horde_sentry::hordesentryinit();

    while ( level.noonespawnedyet )
        wait 0.05;

    for (;;)
    {
        updatehordesettings();
        shownextroundmessage();

        if ( level.currentroundnumber == 3 && level.hordelevelflip == 1 && maps\mp\_utility::getmapname() == "mp_urban" )
            level.dynamiceventstartnow = 1;

        runhordeobjective();
        level notify( "start_round" );
        level.horderoundstats["round_time"] = gettime();
        level childthread monitorroundend();
        level waittill( "round_ended" );

        while ( level.objcollect || level.objdefuse || level.objuplink )
            wait 0.05;

        if ( level.currentroundnumber < 25 )
            hordeupdateroundstats();

        hordeloadwaveweapons();

        foreach ( var_1 in level.players )
        {
            maps\mp\gametypes\_horde_util::awardhorderoundnumber( var_1 );
            maps\mp\gametypes\_horde_util::hordeupdatetimestats( var_1 );
            maps\mp\gametypes\_horde_util::givegearforwavescompleted( var_1 );
            maps\mp\gametypes\_horde_util::givegearformapsplayed( var_1 );
        }
    }
}

runhordeobjective()
{
    level.hordeobjectivesuccess = 1;

    if ( !isobjectiveround() )
        return;

    if ( !isdefined( level.hordeobjectiveorder ) || level.hordeobjectiveindex >= level.hordeobjectiveorder.size )
    {
        level.hordeobjectiveorder = [ 1, 2, 3, 4 ];

        if ( maps\mp\_utility::getmapname() != "mp_prison_z" )
            level.hordeobjectiveorder = common_scripts\utility::array_add( level.hordeobjectiveorder, 5 );

        level.hordeobjectiveorder = common_scripts\utility::array_randomize( level.hordeobjectiveorder );
        level.hordeobjectiveindex = 0;
    }

    var_0 = level.hordeobjectiveorder[level.hordeobjectiveindex];

    switch ( var_0 )
    {
        case 1:
            thread runhordedefend();
            break;
        case 2:
            thread runhordecollect();
            break;
        case 3:
            thread runhordeintel();
            break;
        case 4:
            thread runhordedefuse();
            break;
        case 5:
            thread runhordeuplink();
            break;
    }

    level.hordeobjectiveindex++;
}

isobjectiveround()
{
    var_0 = [ 3, 6, 9, 13, 16, 19, 22, 24 ];

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
        var_0 = [ 3, 6 ];

    foreach ( var_2 in var_0 )
    {
        if ( level.currentroundnumber == var_2 )
            return 1;
    }

    return 0;
}

hordeobjectivesuccess()
{
    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_complete" );
        thread maps\mp\gametypes\_horde_armory::addarmorypoints( var_1, "objective_complete" );
        maps\mp\gametypes\_horde_util::awardhordeobjectivescompleted( var_1 );
    }

    maps\mp\gametypes\_horde_util::playsoundtoallplayers( "mp_ctf_obj_cap_ally" );
    level.hordeobjectivesuccess = 1;
    level.isobjectiveround = 0;
}

hordeinituplinkobjects()
{
    maps\mp\gametypes\horde_ball::setup();
}

runhordeuplink()
{
    level endon( "game_ended" );
    level endon( "uplink_completed" );
    setomnvar( "ui_horde_show_objstatus", 1 );
    level.hordeobjectivesuccess = 0;
    level.isobjectiveround = 1;
    level.objuplink = 1;

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_uplink" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_satellite_start", "horde", 1 );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_uplink" );
    }

    level.horde_ball_score_count = int( min( 10, 3 + 1 * ( maps\mp\gametypes\_horde_util::getnumplayers() - 1 ) ) );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_ball_score_count );
    level thread maps\mp\gametypes\horde_ball::run_horde_ball();
    thread hordesuccessmonitor();
    thread hordeuplinkcancel();
    var_3 = ( level.hordelevelflip - 1 ) * 25 + level.currentroundnumber;
    var_4 = 120 + floor( var_3 / 12 ) * 5;

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        sethudtimer( "uplink_time", var_4 );

    if ( getdvarint( "scr_hordenoobjtimers" ) > 0 )
        level waittill( "round_ended" );
    else
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_4 );

    level notify( "uplink_completed" );
}

hordesuccessmonitor()
{
    level endon( "uplink_completed" );
    var_0 = level.horde_ball_score;

    for (;;)
    {
        if ( level.horde_ball_score != var_0 )
        {
            setomnvar( "ui_horde_objcount_1", level.horde_ball_score );
            var_0 = level.horde_ball_score;
        }

        if ( level.horde_ball_score >= level.horde_ball_score_count )
        {
            thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_objective_complete", "horde", 1, 1 );
            hordeobjectivesuccess();
            level notify( "uplink_completed" );
            break;
        }

        wait 0.05;
    }
}

hordeuplinkcancel()
{
    level endon( "game_ended" );
    level waittill( "uplink_completed" );
    hordecheckobjectivefailure();
    clearhudtimer();
    level thread maps\mp\gametypes\horde_ball::horde_ball_cleanup();
    level.isobjectiveround = 0;
    level.objuplink = 0;
    wait 3.0;
    setomnvar( "ui_horde_show_objstatus", 0 );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", 0 );
}

runhordedefend()
{
    level endon( "game_ended" );
    setomnvar( "ui_horde_show_objstatus", 1 );
    level.hordeobjectivesuccess = 0;
    level.isobjectiveround = 1;
    level.objdefend = 1;

    if ( level.currentroundnumber < 10 )
        level.horde_defend_killcount = 10;
    else if ( level.currentroundnumber < 20 )
        level.horde_defend_killcount = 12;
    else
        level.horde_defend_killcount = 15;

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_defend" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_hardpoint", "horde", 1 );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_defend" );
    }

    if ( !isdefined( level.hordedefendlocs ) || level.hordedefendlocs.size < 1 )
    {
        level.hordedefendlocs = common_scripts\utility::getstructarray( "horde_defend", "targetname" );
        level.hordedefendlocs = common_scripts\utility::array_randomize( level.hordedefendlocs );
    }

    level.currentdefendloc = common_scripts\utility::random( level.hordedefendlocs );
    common_scripts\utility::array_remove( level.hordedefendlocs, level.currentdefendloc );
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "active", level.currentdefendloc.origin, "waypoint_defend" );
    level.currentdefendloc.index = var_3;
    level.currentdefendloc.killcount = 0;

    foreach ( var_1 in level.players )
    {
        if ( var_1.sessionstate == "spectator" )
            continue;

        level.currentdefendloc.headicon = level.currentdefendloc maps\mp\_entityheadicons::setheadicon( var_1, "waypoint_defend", ( 0, 0, 0 ), 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
        level thread hordedefendenemyoutline( var_1 );
    }

    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_defend_killcount );
    thread hordedefendcancel();
    level common_scripts\utility::waittill_any( "defend_complete", "defend_cancel" );
    level.isobjectiveround = 0;
    level.objdefend = 0;
    setomnvar( "ui_horde_show_objstatus", 0 );

    foreach ( var_1 in level.players )
        level.currentdefendloc maps\mp\_entityheadicons::setheadicon( "none", "", ( 0, 0, 0 ) );

    if ( isdefined( level.currentdefendloc.headicon ) )
        level.currentdefendloc.headicon destroy();

    maps\mp\_utility::_objective_delete( level.currentdefendloc.index );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", 0 );
}

hordedefendcancel()
{
    level endon( "game_ended" );
    level endon( "defend_complete" );
    level waittill( "round_ended" );
    level notify( "defend_cancel" );
    hordecheckobjectivefailure();
}

hordedefendenemyoutline( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( var_1 ) )
        var_1 = level.currentdefendloc;

    while ( level.objdefend )
    {
        foreach ( var_3 in level.agentarray )
        {
            if ( common_scripts\utility::array_contains( var_0.markedformech, var_3 ) )
                continue;

            if ( distance( var_0.origin, var_1.origin ) < 800 )
            {
                if ( level.currentaliveenemycount < 3 )
                    var_3 hudoutlineenableforclient( var_0, 4, 0 );
                else
                    var_3 hudoutlineenableforclient( var_0, 4, 1 );

                continue;
            }

            if ( level.currentaliveenemycount < 3 )
                var_3 hudoutlineenableforclient( var_0, level.enemyoutlinecolor, 0 );
            else
                var_3 hudoutlinedisableforclient( var_0 );

            var_3.outlinecolor = level.enemyoutlinecolor;
        }

        wait 0.05;
    }

    foreach ( var_3 in level.agentarray )
    {
        if ( level.currentaliveenemycount < 3 )
        {
            var_3 hudoutlineenableforclient( var_0, level.enemyoutlinecolor, 0 );
            continue;
        }

        var_3 hudoutlinedisableforclient( var_0 );
    }
}

hordeinitdefuseobjects()
{
    level.hordebombs = getentarray( "horde_defuse_bomb", "targetname" );
    level.hordedefuseobjects = [];

    for ( var_0 = 0; var_0 < level.hordebombs.size; var_0++ )
    {
        level.hordebombs[var_0] show();
        level.hordebombs[var_0] initdefuseobject();
        level.hordebombs[var_0] makeusable();
        var_1 = &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES";
        level.hordebombs[var_0] sethintstring( var_1 );
    }
}

initdefuseobject()
{
    var_0[0] = self;
    var_1 = getent( self.target, "targetname" );
    var_1 makeunusable();
    var_2 = maps\mp\gametypes\_gameobjects::createuseobject( "allies", var_1, var_0, ( 0, 0, 32 ), 1 );
    var_2 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_2 maps\mp\gametypes\_gameobjects::setusetime( 5 );
    var_2 maps\mp\gametypes\_gameobjects::setusetext( &"MP_DEFUSING_EXPLOSIVE" );
    var_2 maps\mp\gametypes\_gameobjects::setusehinttext( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
    var_2.onbeginuse = ::hordedefuseonbeginuse;
    var_2.onenduse = ::hordedefuseonenduse;
    var_2.onuse = ::hordeonusedefuseobject;
    var_2.useweapon = "search_dstry_bomb_defuse_mp";
    var_2.visuals[0] hide();
    level.hordedefuseobjects[level.hordedefuseobjects.size] = var_2;
    self.trigger = var_1;
}

defusethink()
{
    level endon( "game_ended" );
    level endon( "defuse_completed" );

    for (;;)
    {
        self waittill( "trigger", var_0 );
        self.trigger notify( "trigger", var_0 );
    }
}

runhordedefuse()
{
    level endon( "game_ended" );
    level endon( "defuse_completed" );
    level.hordedefused = 0;
    level.isobjectiveround = 1;
    level.hordeobjectivesuccess = 0;
    level.objdefuse = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_defuse_count );

    foreach ( var_1 in level.players )
    {
        var_1 setclientomnvar( "ui_horde_count_type", "horde_defuse" );
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_defuse" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_empbombsshowingonsensors", "horde", 1 );
    }

    level.hordedefuselocs = getentarray( "horde_defuse", "targetname" );
    level.hordedefuselocs = common_scripts\utility::array_randomize( level.hordedefuselocs );

    if ( level.hordedefuselocs.size < 3 )
        level.hordedefuselocs = level.hordecollectlocs;

    level.hordedefuselocs = common_scripts\utility::array_randomize( level.hordedefuselocs );
    hordemovebaddefuselocations();

    for ( var_3 = 0; var_3 < level.hordedefuseobjects.size; var_3++ )
    {
        var_4 = maps\mp\gametypes\_gameobjects::getnextobjid();
        level.hordedefuseobjects[var_3].objectiveindex = var_4;
        objective_add( var_4, "active", level.hordedefuselocs[var_3].origin, "objective_sm" );
        level.hordedefuseobjects[var_3].curorigin = level.hordedefuselocs[var_3].origin;
        level.hordedefuseobjects[var_3].visuals[0].curorigin = level.hordedefuselocs[var_3].origin;
        level.hordedefuseobjects[var_3].trigger.origin = level.hordedefuselocs[var_3].origin;
        level.hordedefuseobjects[var_3].origin = level.hordedefuselocs[var_3].origin;
        level.hordedefuseobjects[var_3].visuals[0].origin = level.hordedefuselocs[var_3].origin;
        level.hordedefuseobjects[var_3].visuals[0].angles = level.hordedefuselocs[var_3].angles;
        level.hordedefuseobjects[var_3].visuals[0] hudoutlineenable( 4, 0 );
        level.hordedefuseobjects[var_3].visuals[0] show();
        level.hordedefuseobjects[var_3].visuals[0] makeusable();
        level.hordedefuseobjects[var_3].visuals[0] thread defusethink();
    }

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        sethudtimer( "defuse_time", 120 );

    thread hordedefusecancel();

    if ( getdvarint( "scr_hordenoobjtimers" ) > 0 )
        level waittill( "round_ended" );
    else
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 120 );

    level notify( "defuse_completed" );
}

hordemovebaddefuselocations()
{
    if ( maps\mp\_utility::getmapname() == "mp_torqued" )
    {
        foreach ( var_1 in level.hordedefuselocs )
        {
            if ( var_1.origin == ( 1024.7, -285.7, 883 ) )
            {
                var_1.origin = ( 1209.58, -161.35, 862 );
                var_1.angles = ( 0, 0, 0 );
            }
        }
    }
}

hordedefuseonbeginuse( var_0 )
{
    var_0 maps\mp\_utility::notify_enemy_bots_bomb_used( "defuse" );
    var_0 playsound( "mp_bomb_defuse" );
    var_0.isdefusing = 1;
    self.visuals[0] makeunusable();
    self.visuals[0] hide();
}

hordedefuseonenduse( var_0, var_1, var_2 )
{
    self.visuals[0] show();
    self.visuals[0] makeusable();

    if ( !isdefined( var_1 ) )
        return;

    if ( isalive( var_1 ) )
    {
        var_1.isdefusing = 0;
        var_1.isplanting = 0;
    }
}

hordeplayerdefusing()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.isdefusing ) && var_1.isdefusing )
            return 1;
    }

    return 0;
}

hordeonusedefuseobject( var_0 )
{
    var_0 thread maps\mp\gametypes\_rank::xppointspopup( "horde_defuse", 700 );
    level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0, 700 );
    level.currentpointtotal += 700;
    level notify( "pointsEarned" );
    maps\mp\_utility::_objective_delete( self.objectiveindex );
    self.objectiveindex = undefined;
    self.visuals[0] hide();
    self.visuals[0] makeunusable();
    level.hordedefused++;
    setomnvar( "ui_horde_objcount_1", level.hordedefused );

    if ( level.hordedefused > 2 )
    {
        hordeobjectivesuccess();
        level notify( "defuse_completed" );
    }
    else
        level thread maps\mp\gametypes\_horde_util::showteamsplashhorde( "horde_defused" );
}

hordedefusecancel()
{
    level endon( "game_ended" );
    level waittill( "defuse_completed" );
    clearhudtimer();

    while ( hordeplayerdefusing() )
        wait 0.05;

    hordecheckobjectivefailure();

    foreach ( var_1 in level.hordedefuseobjects )
    {
        if ( isdefined( var_1.objectiveindex ) )
            maps\mp\_utility::_objective_delete( var_1.objectiveindex );

        var_1.visuals[0] hide();
        var_1.visuals[0] makeunusable();
        var_1.objectiveindex = undefined;
    }

    level.objdefuse = 0;
    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

runhordecollect()
{
    level endon( "game_ended" );
    level endon( "collect_completed" );
    level.horde_collect_count = int( min( 20, 10 + 5 * ( maps\mp\gametypes\_horde_util::getnumplayers() - 1 ) ) );
    level.hordecollected = 0;
    level.collectobjects = [];
    level.hordeobjectivesuccess = 0;
    level.isobjectiveround = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );

    foreach ( var_1 in level.players )
    {
        var_1 setclientomnvar( "ui_horde_count_type", "horde_collect" );
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_collect" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_dogtagsareinthefield", "horde", 1 );
    }

    level.hordecollectlocs = common_scripts\utility::getstructarray( "horde_collect", "targetname" );
    level.hordecollectlocs = common_scripts\utility::array_randomize( level.hordecollectlocs );

    for ( var_3 = 0; var_3 < level.horde_collect_count; var_3++ )
    {
        var_4 = spawnpickup( level.hordecollectlocs[var_3].origin, level.collectpickupmodel, level.collectpickupfunc, 112, 0 );
        var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
        var_4.objectiveindex = var_5;
        objective_add( var_5, "active", level.hordecollectlocs[var_3].origin, "objective_sm" );
        level.collectobjects[level.collectobjects.size] = var_4;
    }

    level.objcollect = 1;
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_collect_count );

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        sethudtimer( "collect_time", 120 );

    thread hordecollectcancel();

    if ( getdvarint( "scr_hordenoobjtimers" ) > 0 )
        level waittill( "round_ended" );
    else
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 120 );

    level notify( "collect_completed" );
}

hordecollectcancel()
{
    level endon( "game_ended" );
    level waittill( "collect_completed" );
    hordecheckobjectivefailure();
    clearhudtimer();

    foreach ( var_1 in level.collectobjects )
    {
        if ( isdefined( var_1 ) )
            maps\mp\_utility::_objective_delete( var_1.objectiveindex );
    }

    level.objcollect = 0;
    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

runhordeintel()
{
    level endon( "game_ended" );
    level.objintel = 1;
    level.killssinceinteldrop = 0;
    level.hordecollected = 0;
    level.collectobjects = [];

    if ( level.currentroundnumber < 10 )
        level.horde_collect_count = 3;
    else if ( level.currentroundnumber < 20 )
        level.horde_collect_count = 4;
    else
        level.horde_collect_count = 5;

    level.hordeobjectivesuccess = 0;
    level.isobjectiveround = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_intel" );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_intel" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_hostilesincomingsearchdowned", "horde", 1 );
    }

    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_collect_count );
    thread hordeintelcancel();
    level common_scripts\utility::waittill_any( "collect_completed", "intel_cancel" );
    hordecheckobjectivefailure();
    level.objintel = 0;

    foreach ( var_4 in level.collectobjects )
    {
        if ( isdefined( var_4 ) )
        {
            maps\mp\_utility::_objective_delete( var_4.objectiveindex );
            var_4 delete();
        }
    }

    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

hordeintelcancel()
{
    level endon( "game_ended" );
    level endon( "collect_completed" );
    level waittill( "round_ended" );
    level notify( "intel_cancel" );
}

checkdefendkill( var_0, var_1 )
{
    if ( isdefined( var_1 ) && ( isplayer( var_1 ) || isplayer( var_1.owner ) ) && level.currentdefendloc.killcount < level.horde_defend_killcount )
    {
        if ( var_1 maps\mp\_utility::isusingremote() && var_1.usingremote == "mg_turret" && isdefined( var_1.turret ) )
            var_1 = var_1.turret;

        if ( isdefined( var_1.tank ) && isdefined( var_1.tank.isaerialassaultdrone ) && var_1.tank.isaerialassaultdrone && isdefined( var_1.owner ) )
            var_1 = var_1.owner;

        if ( distancesquared( var_1.origin, level.currentdefendloc.origin ) <= 640000 )
        {
            level.currentdefendloc.killcount++;
            level.currentpointtotal += 150;
            level notify( "pointsEarned" );
            setomnvar( "ui_horde_objcount_1", level.currentdefendloc.killcount );

            if ( isdefined( var_1.owner ) )
            {
                var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "horde_defend", 150 );
                level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1.owner, 150 );
                var_1.owner setclientomnvar( "ui_horde_count", 1 );
            }
            else if ( isdefined( var_1 ) )
            {
                var_1 setclientomnvar( "ui_horde_count", 1 );
                var_1 thread maps\mp\gametypes\_rank::xppointspopup( "horde_defend", 150 );
                level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_1, 150 );
            }

            if ( level.currentdefendloc.killcount >= level.horde_defend_killcount )
            {
                thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_locationdefended", "horde", 1 );
                thread hordeobjectivesuccess();
                level notify( "defend_complete" );
                level.currentdefendloc notify( "defended" );
            }
        }
    }
}

hordecheckobjectivefailure()
{
    level.objectivefailureevents = [];
    level.objectivefailureevents[0] = "Emp";
    level.objectivefailureevents[1] = "Smoke";
    level.objectivefailureevents[2] = "Sentry";
    level.objectivefailureevents[3] = "Pistols";
    level.objectivefailureevents[4] = "NanoSwarm";

    if ( !level.hordeobjectivesuccess )
    {
        maps\mp\gametypes\_horde_util::playsoundtoallplayers( "mp_ctf_obj_cap_enemy" );

        for (;;)
        {
            var_0 = common_scripts\utility::random( level.objectivefailureevents );

            if ( var_0 != level.hordepreviousfailureevent )
            {
                level.hordepreviousfailureevent = var_0;
                break;
            }
        }

        level thread maps\mp\gametypes\_horde_util::showteamsplashhorde( "horde_obj_failed_" + var_0 );
        level.isobjectiveround = 0;

        switch ( var_0 )
        {
            case "Emp":
                thread failureeventemp();
                break;
            case "Smoke":
                thread failureeventsmoke();
                break;
            case "NanoSwarm":
                thread failureeventmissileburst( 1 );
                break;
            case "Sentry":
                thread failureeventsentry();
                break;
            case "Pistols":
                thread failureeventpistolsonly();
                break;
        }
    }
}

failureeventemp()
{
    foreach ( var_1 in level.players )
    {
        var_2 = var_1 getclientomnvar( "ui_horde_armory_type" );

        if ( var_2 != "killstreak_armory" && var_2 != "perk_armory" )
            maps\mp\gametypes\_horde_armory::hordecleanuparmory( var_1 );
    }

    thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_systemhack", "horde", 1, 1 );
    thread maps\mp\gametypes\_horde_armory::hordedisablearmories();
    level.players[0] maps\mp\killstreaks\_emp::emp_jamteam( level.playerteam, [ "emp_exo_kill", "emp_streak_kill", "emp_equipment_kill" ] );
}

failureeventsmoke()
{
    level endon( "game_ended" );
    thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_tangosarepoppingsmoke", "horde", 1, 1 );
    var_0 = gettime() + int( 60000 );

    while ( gettime() < var_0 )
    {
        var_1 = common_scripts\utility::random( level.players );
        var_1 thread failureeventsmokethink();
        wait(randomfloatrange( 10, 12 ));
    }
}

failureeventsmokethink()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = 0;

    while ( var_0 != 3 )
    {
        wait(randomfloatrange( 0.25, 0.85 ));
        var_1 = _getrandomorginfrontofplayer();
        var_2 = getnodesinradiussorted( var_1, 512, 32, 256, "path" );
        var_3 = common_scripts\utility::random( var_2 );

        if ( !isdefined( var_3 ) )
            continue;

        magicgrenademanual( "smoke_grenade_mp", var_3.origin, ( 0, 0, 0 ), 1 );
        var_0++;
    }
}

_getrandomorginfrontofplayer()
{
    var_0 = anglestoforward( self.angles );
    var_1 = anglestoright( self.angles );
    var_2 = self.origin + var_0 * randomfloatrange( 128, 256 );
    var_3 = var_2 + var_1 * randomfloatrange( 64, 128 );

    if ( common_scripts\utility::cointoss() )
        var_3 = var_2 + var_1 * 128;
    else
        var_3 = var_2 - var_1 * 128;

    return var_3;
}

failureeventmissileburst( var_0 )
{
    level endon( "game_ended" );
    var_1 = getentarray( "remoteMissileSpawn", "targetname" );
    thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_nanostrike", "horde", 1, 1 );

    if ( var_0 )
    {
        var_2 = 3;
        var_3 = 1;
        var_4 = 2;
        var_5 = 5;
        var_6 = 10;
        var_7 = 15;
    }
    else
    {
        var_2 = 3;
        var_3 = 5;
        var_4 = 0.25;
        var_5 = 1.25;
        var_6 = 2;
        var_7 = 5;
    }

    var_8 = gettime() + int( 60000 );

    while ( gettime() < var_8 )
    {
        wait(randomfloatrange( 3, 6 ));

        foreach ( var_10 in level.players )
        {
            if ( isdefined( var_10.laststand ) && var_10.laststand == 1 )
                continue;

            var_10 failureeventmissileburstthink( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
        }
    }
}

failureeventmissileburstthink( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_8 = "warbird_missile_mp";

    for ( var_9 = 0; var_9 < var_2; var_9++ )
    {
        for ( var_10 = 0; var_10 < var_3; var_10++ )
        {
            var_11 = maps\mp\killstreaks\_missile_strike::getbestspawnpoint( var_0 );
            var_12 = _getrandomorginfrontofplayer();
            var_13 = magicbullet( var_8, var_11.origin, var_12 );

            if ( var_1 )
                var_13 thread hordespawnnanoswarm();

            var_13 missile_settargetpos( var_12 );
            var_13 missile_setflightmodedirect();
            var_13 setmissileminimapvisible( 1 );
            wait(randomfloatrange( var_4, var_5 ));
        }

        wait(randomfloatrange( var_6, var_7 ));
    }
}

hordespawnnanoswarm()
{
    self endon( "cancel_swarm" );
    common_scripts\utility::waittill_any( "death", "startSwarm" );
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "tag_origin" );
    var_1 = spawn( "script_model", var_0.origin );
    var_0.killcament = var_1;
    var_2 = level._missile_strike_setting["Particle_FX"].gas;
    waitframe();

    foreach ( var_4 in level.players )
        playfxontagforclients( var_2, var_0, "tag_origin", var_4 );

    badplace_cylinder( "gas_zone" + var_0 getentitynumber(), 20, var_0.origin, 200, 128, level.enemyteam );
    var_0 thread failureeventmissileburstgasdamage();
    wait 20;
    var_0.killcament delete();
    var_0 delete();
}

failureeventmissileburstgasdamage()
{
    self endon( "death" );
    var_0 = 200;
    var_1 = 12;

    for (;;)
    {
        self.killcament radiusdamage( self.origin, var_0, var_1, var_1, undefined, "MOD_TRIGGER_HURT", "killstreak_strike_missile_gas_mp", 0 );
        wait 1;
    }
}

failureeventsentry()
{
    level endon( "game_ended" );
    thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_sentryguns", "horde", 1, 1 );
    var_0 = [ "remote_energy_turret_mp", "sentry_minigun_mp" ];
    var_1 = common_scripts\utility::random( var_0 );
    var_2 = clamp( level.hordesentryspawns.size / 2, 1, 5 );
    level.hordesentryspawns = common_scripts\utility::array_randomize( level.hordesentryspawns );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = maps\mp\gametypes\_horde_sentry::hordespawnenemyturret( var_1, level.hordesentryspawns[var_3] );
        wait 2.5;
    }
}

failureeventpistolsonly()
{
    level endon( "game_ended" );
    var_0 = [];
    var_1 = 45;
    level.hordeweaponsjammed = 1;
    setomnvar( "ui_horde_allow_classchange", 0 );
    level thread failureeventpistolsreenabled( var_1 );
    thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_weaponsoffline", "horde", 1, 1 );

    foreach ( var_3 in level.players )
    {
        while ( isdefined( var_3.ball_carried ) )
            wait 0.05;

        var_3 thread failureeventpistolsonlythink( var_1 );
        var_3 thread failureeventpistolsonlyjammedbar( var_1, var_0 );

        if ( var_3 maps\mp\_utility::isusingremote() )
            var_3 thread failurepistolshandleremotereturn();
    }
}

failureeventpistolsonlyjammedbar( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "death" );
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbar( 0, 190 );
    var_3 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext( 0, 185 );
    var_3 settext( &"HORDE_WEAPONS_JAMMED" );
    var_2 thread failureeventupdateweaponjammedbar( var_0, var_1 );
    thread failureeventpistolonlyjammedbarhide( var_2, var_3 );
    var_2 waittill( "Clear_JammedBar_UI" );
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

failureeventupdateweaponjammedbar( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_2 = 0;

    while ( var_2 != var_0 )
    {
        var_2++;
        maps\mp\gametypes\_hud_util::updatebar( var_2 / var_0 );
        wait 1;
    }

    self notify( "Clear_JammedBar_UI" );
}

failureeventpistolonlyjammedbarhide( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 endon( "Clear_JammedBar_UI" );
    var_2 = [ var_0, var_1 ];

    for (;;)
    {
        if ( !isdefined( self.inlaststand ) )
        {
            wait 0.05;
            continue;
        }

        if ( isdefined( self.inlaststand ) && self.inlaststand == 0 )
        {
            foreach ( var_4 in var_2 )
                var_4 maps\mp\gametypes\_hud_util::showelem();
        }

        if ( isdefined( self.inlaststand ) && self.inlaststand == 1 )
        {
            foreach ( var_4 in var_2 )
                var_4 maps\mp\gametypes\_hud_util::hideelem();
        }

        wait 0.05;
    }
}

failureeventpistolsonlythink( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = self getclientomnvar( "ui_horde_player_class" );
    var_2 = self getcurrentprimaryweapon();

    if ( maps\mp\_utility::isusingremote() )
        var_2 = self.hordeclassweapons[var_1]["primary"];

    if ( var_2 == "iw5_carrydrone_mp" )
    {
        var_3 = self getweaponslistprimaries();
        var_2 = var_3[0];
    }

    maps\mp\gametypes\_weapons::saveweapon( "jam", var_2, maps\mp\gametypes\_horde_laststand::hordelaststandweapon() );
    self.weaponjamcompletiontime = gettime() + var_0 * 1000;
    handlejammedpistols( var_2 );
    maps\mp\gametypes\_weapons::restoreweapon( "jam" );
}

handlejammedpistols( var_0 )
{
    self notify( "horde_handle_jammed_pistols" );
    self endon( "horde_handle_jammed_pistols" );

    if ( isdefined( self.isjuggernaut ) && self.isjuggernaut )
        return;

    var_1 = maps\mp\gametypes\_horde_laststand::hordelaststandweapon();

    if ( !maps\mp\gametypes\_horde_laststand::haslaststandweapon( var_1 ) )
        self giveweapon( var_1 );

    if ( !isdefined( self.underwater ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( self ) )
        self switchtoweaponimmediate( var_1 );

    self disableweaponswitch();
    var_2 = self setweaponammostock( var_0 );
    var_3 = weaponclipsize( var_0 );

    if ( var_2 < var_3 )
        self setweaponammostock( var_0, var_3 );

    var_4 = ( self.weaponjamcompletiontime - gettime() ) * 0.001;
    wait(var_4);

    if ( !isdefined( self.underwater ) && !maps\mp\gametypes\_horde_util::isplayerinlaststand( self ) )
        self enableweaponswitch();

    if ( !self.hadlaststandweapon )
        self takeweapon( var_1 );
}

failureeventpistolsreenabled( var_0 )
{
    level endon( "game_ended" );
    wait(var_0);
    setomnvar( "ui_horde_allow_classchange", 1 );
    level thread maps\mp\gametypes\_horde_util::showteamsplashhorde( "horde_weapons_enabled" );
    maps\mp\gametypes\_horde_util::playsoundtoallplayers( "mp_ctf_obj_cap_ally" );
    wait 0.5;
    level.hordeweaponsjammed = 0;
}

failurepistolshandleremotereturn()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "stopped_using_remote" );

    if ( isdefined( level.hordeweaponsjammed ) && level.hordeweaponsjammed )
        self switchtoweaponimmediate( "iw5_titan45_mp_xmags" );
}

closeclassmenu()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;

    if ( !isagent( self ) )
        thread maps\mp\gametypes\_playerlogic::setuioptionsmenu( -1 );
}

monitorroundend()
{
    level.enemiesleft = level.maxenemycount;

    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level.currentenemycount == level.maxenemycount && level.currentaliveenemycount == 0 )
        {
            notifyroundover();

            foreach ( var_1 in level.players )
                maps\mp\gametypes\_horde_armory::addarmorypoints( var_1, "round" );

            level.enemiesleft = 0;
            setomnvar( "ui_horde_enemies_left", level.enemiesleft );
            return;
        }
    }
}

notifyroundover()
{
    level endon( "game_ended" );

    if ( getdvarint( "scr_hordenoobjtimers" ) < 1 )
    {
        while ( level.objcollect || level.objdefuse || level.objuplink )
            wait 0.05;
    }

    level thread respawneliminatedplayers();
    var_0 = "horde_wave_complete";

    if ( level.currentroundnumber == level.maxrounds )
        var_0 = "horde_map_flip";

    waittillframeend;

    if ( level.hordeobjectivesuccess )
    {
        if ( level.currentroundnumber == 10 && maps\mp\_utility::getmapname() == "mp_prison_z" )
        {
            level notify( "zombies_start" );
            setnojiptime( 1 );
            thread maps\mp\gametypes\_horde_zombies::runhordezombies();
        }
        else
        {
            level thread maps\mp\gametypes\_horde_util::showteamsplashhorde( var_0 );
            thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_roundover", "horde", 1, 1 );
        }
    }

    setdvar( "bg_compassShowEnemies", 0 );
    level.hordenumroundscompleted++;

    if ( level.currentroundnumber == level.maxrounds )
        wait 10;

    level notify( "round_ended" );
}

respawneliminatedplayers()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteamorspectator( var_1 ) )
            continue;

        if ( !isdefined( self.goliathdeath ) )
            level thread respawnplayer( var_1 );
    }
}

hordecustomgiveloadout( var_0 )
{
    if ( isdefined( self.isspectator ) )
        self.loadout = undefined;
    else
        maps\mp\gametypes\_class::applyloadout();
}

setupplayerafterrevivefromspectator()
{
    self notify( "revive" );
    var_0 = self getclientomnvar( "ui_horde_player_class" );
    var_1 = level.classsettings[var_0]["speed"];
    self.laststand = undefined;
    self.inlaststand = 0;
    self.headicon = "";
    self.movespeedscaler = var_1;
    self.ignoreme = 0;
    self.beingrevived = 0;
    self.saveweapons = [];
    self.firstsaveweapon = "none";

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();

    self hudoutlinedisable();
    self laststandrevive();
    self setstance( "stand" );
    thread maps\mp\gametypes\_horde_util::hordeallowallboost( 1, "laststand" );
    self allowmelee( 1 );
    self enableweapons();
    common_scripts\utility::_enableusability();
    self enableoffhandweapons();
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\_utility::clearlowermessage( "last_stand" );
    maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
    maps\mp\_utility::giveperk( "specialty_horde_dualprimary", 1, 1 );

    if ( maps\mp\killstreaks\_emp::issystemhacked() && !maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
        maps\mp\killstreaks\_emp::applyemp();

    maps\mp\_utility::_setactionslot( 1, "" );
    maps\mp\_utility::_setactionslot( 3, "altMode" );
    maps\mp\_utility::_setactionslot( 4, "" );

    if ( !level.console )
    {
        maps\mp\_utility::_setactionslot( 5, "" );
        maps\mp\_utility::_setactionslot( 6, "" );
        maps\mp\_utility::_setactionslot( 7, "" );
        maps\mp\_utility::_setactionslot( 8, "" );
    }
}

resetwateronrevivefromspectator()
{
    self notify( "above_water" );
    self.wasunderwater = 0;
    wait 0.1;
}

respawnplayer( var_0 )
{
    level endon( "game_ended" );

    if ( isdefined( var_0.isspectator ) )
    {
        var_0.pers["lives"] = 1;
        var_0.pers["class"] = "gamemode";
        var_0.class = var_0.pers["class"];
        var_0.addtoteam = level.playerteam;
        var_0.alreadyaddedtoalivecount = 1;
        var_0 maps\mp\killstreaks\_killstreaks::clearkillstreaks( 1 );
        var_0 notify( "horde_end_spectate" );
        var_1 = var_0 getclientomnvar( "ui_horde_player_class" );

        if ( var_1 == "none" )
        {
            var_1 = "light";
            var_0 setclientomnvar( "ui_horde_player_class", var_1 );
            var_0.classmaxhealth = var_0.classsettings[var_1]["classhealth"];
            var_2 = var_0.hordeclassweapons[var_1]["secondary"];
            var_0.primaryweaponsammo[var_2]["ammoclip"] = 15;
            var_0.primaryweaponsammo[var_2]["ammostock"] = 90;
            var_0 setweaponammoclip( var_2, 15 );
            var_0.classsettings[var_1]["battery"] = level.classsettings[var_1]["battery"];
            var_0.lasttacticalweapon = var_0.classsettings[var_1]["exoAbility"];
            wait 0.1;

            if ( var_0 getclientomnvar( "horde_first_spawn" ) == 1 )
                thread maps\mp\gametypes\_horde_armory::hordeclassrunfirstspawn( var_0 );
        }

        var_0 maps\mp\gametypes\_playerlogic::spawnplayer( 0, 0 );
        var_0.isspectator = undefined;
        wait 0.1;

        if ( var_0.wasunderwater )
            resetwateronrevivefromspectator();

        var_0 setupplayerafterrevivefromspectator();
        var_0 setlethalweapon( var_0.lastlethalweapon );
        var_0 giveweapon( var_0.lastlethalweapon );
        var_0 settacticalweapon( var_0.lasttacticalweapon );
        var_0 giveweapon( var_0.lasttacticalweapon );
        var_0 setweaponammoclip( var_0.lastlethalweapon, var_0.lastlethalweaponammoclip );
        var_0 maps\mp\gametypes\_horde_armory::armorygiveexoability( var_0.lasttacticalweapon, 1 );
        var_0 maps\mp\_utility::playerallowdodge( var_0.classsettings[var_1]["allowDodge"], "class" );
        var_0 maps\mp\_utility::playerallowpowerslide( var_0.classsettings[var_1]["allowSlide"], "class" );
        var_0 thread addlastperks();
        var_3 = var_0 getclientomnvar( "ui_horde_player_class" );
        maps\mp\gametypes\_horde_armory::hordegiveability( var_0, var_3 );
        var_0 setclientomnvar( "ks_count1", 0 );
        var_0 setclientomnvar( "ks_count_updated", 1 );
        var_0.maxhealth = var_0.classmaxhealth + var_0.hordearmor * 40;
        var_0.health = var_0.maxhealth;

        if ( !var_0.classabilityready && !level.zombiesstarted )
        {
            if ( isdefined( var_0.hordeclassgoliathcontroller ) || isdefined( var_0.hordeclassgoliathpodinfield ) )
                level thread maps\mp\gametypes\_horde_armory::hordewaitforgoliathdeath( var_0, maps\mp\gametypes\_horde_armory::getabilitywaittime( var_0 ) );
            else
                level thread maps\mp\gametypes\_horde_armory::hordeabilityregenbar( var_0, maps\mp\gametypes\_horde_armory::getabilitywaittime( var_0 ) );
        }

        var_0.goliathdeath = undefined;
        var_0 maps\mp\gametypes\_horde_laststand::givebackstoredplayerweapons( var_1, 1 );

        foreach ( var_5 in var_0.lastkillstreaks )
        {
            var_6 = maps\mp\gametypes\_horde_util::getslotnumber( var_0 );

            if ( !isdefined( var_6 ) )
                continue;

            var_0 thread maps\mp\killstreaks\_killstreaks::givekillstreak( var_5["name"], 0, 0, var_0, var_5["modules"], var_6 );
            var_0.currentkillstreaks[var_6] = var_5["name"];
        }
    }
    else if ( maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) )
        var_0 notify( "revive_trigger", var_0 );
}

addlastperks()
{
    self endon( "death" );
    level endon( "game_ended" );

    foreach ( var_1 in self.lastperks )
    {
        wait 0.1;

        if ( !maps\mp\_utility::_hasperk( var_1["name"] ) )
            maps\mp\gametypes\_horde_armory::hordegiveperk( var_1["name"] );
    }
}

updateachievements()
{
    if ( level.hordelevelflip > 1 )
    {
        foreach ( var_1 in level.players )
            var_1 giveachievement( "COOP_EXO_SURVIVOR" );
    }

    if ( level.hordelevelflip > 2 )
    {
        foreach ( var_1 in level.players )
            var_1 giveachievement( "COOP_FLIP_FLOP" );
    }
}

updatehordesettings()
{
    if ( level.currentroundnumber == level.maxrounds )
    {
        level.hordelevelflip++;
        setomnvar( "ui_horde_flip", level.hordelevelflip );
        horderandomizeaimodifiertypes();
    }

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber == 10 )
        level.hordewaveadjust = 15;

    level.currentroundnumber = getnextroundnumber();
    level.maxdronecount = 0;
    level.maxwarbirdcount = 0;
    level.maxalivedronecount = 0;
    level.maxdogcount = 0;
    level.maxalivedogcount = 0;
    level.dogsalive = 0;
    level.wavefirstspawn = 1;
    level.horderoundstats["support_drops_earned"] = 0;
    var_0 = getwavetable();
    level.specialaistats = [];
    level.specialaitypes = strtok( tablelookup( var_0, 1, level.currentroundnumber + level.hordewaveadjust, 5 ), " " );
    level.specialaicount = strtok( tablelookup( var_0, 1, level.currentroundnumber + level.hordewaveadjust, 6 ), " " );

    for ( var_1 = 0; var_1 < level.specialaitypes.size; var_1++ )
    {
        level.specialaistats[level.specialaitypes[var_1]]["count"] = 0;
        level.specialaistats[level.specialaitypes[var_1]]["maxCount"] = int( level.specialaicount[var_1] ) + getaicountincrease( level.specialaitypes[var_1] );
    }

    level.nonhumantypes = strtok( tablelookup( var_0, 1, level.currentroundnumber + level.hordewaveadjust, 7 ), " " );

    for ( var_1 = 0; var_1 < level.nonhumantypes.size; var_1++ )
    {
        if ( issubstr( level.nonhumantypes[var_1], "drone" ) && !( level.hordelevelflip > 1 && level.currentroundnumber == 9 ) )
        {
            level.maxdronecount = getmaxdronecount( level.currentroundnumber );
            level.maxalivedronecount = level.maxdronecount;
            level.droneweapon = tablelookup( getwavetable(), 1, level.hordedronetype, 4 );
            level.dronehealth = int( tablelookup( getwavetable(), 1, level.hordedronetype, 7 ) );
            level.hordedronemodel = "vehicle_atlas_assault_drone";

            if ( level.hordedronetype == "drone_large_energy" )
                level.hordedronemodel = "vehicle_atlas_assault_drone_large";
        }

        if ( issubstr( level.nonhumantypes[var_1], "warbird" ) || level.hordelevelflip > 1 && level.currentroundnumber == 9 || level.hordelevelflip == 1 && level.currentroundnumber == 11 )
        {
            level.maxwarbirdcount = getmaxwarbirdcount( level.currentroundnumber );

            if ( level.hordelevelflip > 1 && level.currentroundnumber == 9 || level.hordelevelflip == 1 && level.currentroundnumber == 11 )
            {
                level.maxwarbirdcount = 1;
                level.hordewarbirdtype = "warbird";
            }

            level.warbirdweapon = tablelookup( getwavetable(), 1, level.hordewarbirdtype, 4 );
            level.warbirdhealth = int( tablelookup( getwavetable(), 1, level.hordewarbirdtype, 7 ) );
            level.hordewarbirdmodel = "vehicle_atlas_assault_warbird";
        }

        if ( issubstr( level.nonhumantypes[var_1], "dog" ) && !( level.hordelevelflip == 1 && level.currentroundnumber == 11 ) )
        {
            level.maxdogcount = getmaxdogcount( level.currentroundnumber );
            level.maxalivedogcount = level.maxdogcount;
        }
    }

    level.maxenemycount = getmaxenemycount( level.currentroundnumber );
    level.currentenemycount = 0;
    level.maxaliveenemycount = getmaxaliveenemycount( level.currentroundnumber );
    level.currentaliveenemycount = 0;
    level.enemiesleft = 0;
    level.maxpickupsperround = getmaxpickupsperround();
    level.currentpickupcount = 0;
    level.currentammopickupcount = 0;
    level.chancetospawndog = 0;

    if ( level.currentroundnumber == 10 && maps\mp\gametypes\_horde_util::getnumplayers() < 2 )
    {
        level.maxenemycount = 1;
        level.maxaliveenemycount = 1;
    }

    if ( level.currentroundnumber > 4 )
        setnojipscore( 1 );

    foreach ( var_3 in level.players )
    {
        var_3.roundkills = 0;
        var_3.roundheadshots = 0;
        var_3.roundupgradepoints = 0;
    }

    updateachievements();
}

horderandomizeaimodifiertypes()
{
    var_0 = clamp( level.hordelevelflip, 1, 4 );

    switch ( int( var_0 ) )
    {
        case 4:
            level.modifiercompanionaitypes = hordereturnrandomaitypes( level.hordemodeelites, undefined, 3 );
        case 3:
            level.modifierexplosiveaitypes = hordereturnrandomaitypes( level.hordemodeelites, undefined, 2 );
        case 2:
            level.modifiertoxicaitypes = hordereturnrandomaitypes( level.hordemodespecials, level.hordemodeelites, 3 );
        case 1:
            level.modifiershieldaitypes = hordereturnrandomaitypes( level.hordemodegrunts, undefined, level.hordemodegrunts.size / 2 );
    }
}

hordereturnrandomaitypes( var_0, var_1, var_2 )
{
    var_3 = [];

    if ( isdefined( var_1 ) )
        var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        var_5 = common_scripts\utility::random( var_0 );
        var_3 = common_scripts\utility::add_to_array( var_3, var_5 );
        var_0 = common_scripts\utility::array_remove( var_0, var_5 );
    }

    return var_3;
}

hordeupdateroundstats()
{
    level.horderoundstats["round_time"] = gettime() - level.horderoundstats["round_time"];

    if ( !isdefined( level.fastesttime ) || level.horderoundstats["round_time"] < level.fastesttime )
        level.fastesttime = level.horderoundstats["round_time"];

    var_0 = int( level.horderoundstats["round_time"] / 1000 );

    if ( var_0 > 999 )
        var_0 = 999;

    setomnvar( "ui_horde_round_time", var_0 );
    setomnvar( "ui_horde_round_drops", level.horderoundstats["support_drops_earned"] );

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_horde_round_kills", var_2.roundkills );
        var_2 setclientomnvar( "ui_horde_round_headshots", var_2.roundheadshots );
        var_2 setclientomnvar( "ui_horde_round_points", var_2.roundupgradepoints );
    }

    if ( getomnvar( "ui_horde_show_objstatus" ) > 0 )
        setomnvar( "ui_horde_show_objstatus", 0 );

    if ( !level.zombiesstarted )
        setomnvar( "ui_horde_show_roundstats", 1 );

    var_4 = ( 300 - var_0 ) * 5;

    if ( var_4 < 0 )
        var_4 = 0;

    foreach ( var_2 in level.players )
    {
        var_6 = var_2.roundkills * 50;
        var_7 = level.horderoundstats["support_drops_earned"] * 500;
        var_8 = var_2.roundupgradepoints * 500;
        var_9 = var_2.roundheadshots * 50;
        var_10 = var_4 + var_6 + var_7 + var_8 + var_9;
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_2, var_10 );
        level thread maps\mp\gametypes\_horde_util::awardhordeheadshots( var_2, var_2.roundheadshots );
    }

    thread hordehideroundstats();
}

hordehideroundstats()
{
    level endon( "game_ended" );
    common_scripts\utility::waittill_any_timeout( 15, "all_players_ready", "round_begin" );
    setomnvar( "ui_horde_show_roundstats", 0 );

    if ( level.isobjectiveround )
        setomnvar( "ui_horde_show_objstatus", 1 );
}

getnextroundnumber()
{
    if ( level.currentroundnumber == level.maxrounds )
        var_0 = 1;
    else if ( level.currentroundnumber == 0 )
        var_0 = hordegetstartingroundnum( getdvarint( "scr_horde_startinground" ) );
    else
        var_0 = level.currentroundnumber + 1;

    return var_0;
}

hordegetstartingroundnum( var_0 )
{
    var_1 = 1;

    switch ( var_0 )
    {
        case 0:
            var_1 = 1;
            break;
        case 1:
            var_1 = 5;
            break;
        case 2:
            var_1 = 10;
            break;
        case 3:
            var_1 = 15;
            break;
        case 4:
            var_1 = 20;
            break;
        case 5:
            var_1 = 25;
            break;
    }

    return var_1;
}

getrownumber( var_0 )
{
    var_0 = int( clamp( var_0, 1, 20 ) );
    var_0 -= 1;
    return var_0 * 4 + maps\mp\gametypes\_horde_util::getnumplayers();
}

getmaxrounds( var_0 )
{
    var_1 = 100;

    switch ( var_0 )
    {
        case 1:
        case 0:
            var_1 = 20;
            break;
        case 2:
            var_1 = 40;
            break;
        case 3:
            var_1 = 100;
            break;
        default:
            var_1 = 100;
            break;
    }

    return var_1;
}

getmaxenemycount( var_0 )
{
    var_1 = int( tablelookup( getwavetable(), 1, level.currentroundnumber + level.hordewaveadjust, 2 ) ) + getaicountincrease();
    return var_1;
}

getmaxdronecount( var_0 )
{
    var_1 = getwavetable();
    level.hordedronetype = tablelookup( var_1, 1, level.currentroundnumber + level.hordewaveadjust, 7 );
    var_2 = int( tablelookup( var_1, 1, level.currentroundnumber + level.hordewaveadjust, 8 ) );
    return var_2;
}

getmaxdogcount( var_0 )
{
    level.hordedogtype = tablelookup( getwavetable(), 1, level.currentroundnumber + level.hordewaveadjust, 7 );
    var_1 = int( tablelookup( getwavetable(), 1, level.currentroundnumber + level.hordewaveadjust, 8 ) );
    return var_1;
}

getmaxwarbirdcount( var_0 )
{
    var_1 = getwavetable();
    level.hordewarbirdtype = tablelookup( var_1, 1, level.currentroundnumber + level.hordewaveadjust, 7 );
    var_2 = int( tablelookup( var_1, 1, level.currentroundnumber + level.hordewaveadjust, 8 ) );
    return var_2;
}

getmaxaliveenemycount( var_0 )
{
    var_1 = int( tablelookup( getwavetable(), 1, level.currentroundnumber + level.hordewaveadjust, 3 ) ) + getaicountincrease();
    return var_1;
}

getaicountincrease( var_0 )
{
    if ( level.currentroundnumber == 5 || level.currentroundnumber == 10 )
        return 0;

    var_1 = maps\mp\gametypes\_horde_util::getnumplayers() - 1;

    if ( isdefined( var_0 ) && issubstr( var_0, "jugg" ) )
    {
        if ( level.currentroundnumber < 14 )
            var_1 = 0;
        else if ( level.currentroundnumber < 24 )
            var_1 = min( 1, maps\mp\gametypes\_horde_util::getnumplayers() - 1 );
        else if ( level.currentroundnumber == 25 )
            var_1 = min( 2, maps\mp\gametypes\_horde_util::getnumplayers() - 1 );
    }

    return var_1;
}

waituntilmatchstart()
{
    maps\mp\_utility::gameflagwait( "prematch_done" );

    while ( !isdefined( level.bot_loadouts_initialized ) || level.bot_loadouts_initialized == 0 )
        wait 0.05;

    while ( !level.players.size )
        wait 0.05;
}

shownextroundmessage()
{
    level.players_ready = 0;

    if ( level.currentroundnumber > 1 )
    {
        foreach ( var_1 in level.players )
            level thread hordemonitordoubletap( var_1, "readyup" );

        level thread hordemonitorplayersready();
    }

    setomnvar( "ui_horde_round_number_unlock", level.currentroundnumber );
    horderoundintermission();

    foreach ( var_1 in level.players )
        var_1 setclientomnvar( "ui_horde_show_readyup", 0 );

    setomnvar( "ui_horde_round_number", level.currentroundnumber );
    level thread respawneliminatedplayers();
    var_5 = "horde_wave_start";
    level childthread maps\mp\gametypes\_horde_util::playsoundtoallplayers( var_5 );

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10 )
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 5 );
}

showintermissiontimer()
{
    if ( level.currentroundnumber == 1 )
        return 0;

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10 )
        return 0;

    if ( isdefined( level.hordeobjectivesuccess ) && !level.hordeobjectivesuccess )
        return 0;

    return 1;
}

hordemonitorplayersready()
{
    level endon( "game_ended" );
    level endon( "start_round" );

    while ( level.players_ready < level.players.size )
        wait 0.05;

    level notify( "all_players_ready" );
    setomnvar( "ui_horde_show_roundstats", 0 );
    clearhudtimer();
}

horderoundintermission()
{
    level endon( "game_ended" );
    level endon( "all_players_ready" );

    if ( showintermissiontimer() )
    {
        sethudtimer( "start_time", getroundintermissiontimer() );

        foreach ( var_1 in level.players )
            var_1 setclientomnvar( "ui_horde_show_readyup", 1 );
    }

    if ( level.currentroundnumber == 1 )
        thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_intro", "horde", 1, 2 );

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( getroundintermissiontimer() - 6 );

    if ( !level.zombiesstarted )
    {
        level notify( "wave_final_countdown" );

        foreach ( var_1 in level.players )
            var_1 setclientomnvar( "ui_horde_show_readyup", 0 );

        hordeintermissionfinalcountdown();
        thread hordeintermissionclearcountdown();
    }

    level notify( "round_begin" );
}

hordeintermissionfinalcountdown( var_0 )
{
    clearhudtimer();

    if ( !isdefined( var_0 ) )
        var_0 = 5;

    setomnvar( "ui_match_countdown_toggle", 1 );
    setomnvar( "ui_match_countdown_title", 4 );

    while ( var_0 > 0 && !level.gameended )
    {
        if ( getomnvar( "ui_match_countdown_title" ) == 4 )
            setomnvar( "ui_match_countdown", var_0 );

        wait 1;
        var_0--;
    }
}

hordeintermissionclearcountdown()
{
    setomnvar( "ui_match_countdown_title", 5 );
    setomnvar( "ui_match_countdown", 0 );
    setomnvar( "ui_match_countdown_toggle", 0 );
    wait 2;
    setomnvar( "ui_match_countdown_title", 0 );
}

getroundintermissiontimer()
{
    if ( !showintermissiontimer() )
        return 10;

    return 45;
}

hordemonitordoubletap( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "death" );
    level endon( "game_ended" );

    if ( var_1 == "dismiss_info" )
        var_0 endon( "info_dismissed" );
    else if ( var_1 == "readyup" )
    {
        var_0 endon( "ready" );
        level endon( "start_round" );
        level endon( "wave_final_countdown" );
    }

    var_2 = 0;

    for (;;)
    {
        if ( var_0 usebuttonpressed() )
        {
            var_2 = 0;

            while ( var_0 usebuttonpressed() )
            {
                var_2 += 0.05;
                wait 0.05;
            }

            if ( var_2 >= 0.5 )
                continue;

            var_2 = 0;

            while ( !var_0 usebuttonpressed() && var_2 < 0.5 )
            {
                var_2 += 0.05;
                wait 0.05;
            }

            if ( var_2 >= 0.5 )
                continue;

            switch ( var_1 )
            {
                case "readyup":
                    if ( !var_0 maps\mp\_utility::isusingremote() )
                    {
                        level.players_ready++;

                        if ( level.players_ready < level.players.size )
                            var_0 setclientomnvar( "ui_horde_show_readyup", 2 );

                        var_0 notify( "ready" );
                    }

                    break;
                case "dismiss_info":
                    var_0 notify( "info_dismissed" );
                    break;
            }
        }

        wait 0.05;
    }
}

rundroplocations()
{
    level endon( "game_ended" );
    level endon( "zombies_start" );
    waituntilmatchstart();

    if ( !isdefined( level.hordedroplocations ) || !level.hordedroplocations.size )
        return;

    level childthread monitorsupportdropprogress();

    for (;;)
    {
        level waittill( "airSupport" );
        thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_supportdropincoming", "horde", 1, 1 );
        level childthread displayincomingairdropmessage();

        for ( var_0 = 0; var_0 < level.hordeuseddroplocations.size; var_0++ )
        {
            level.hordedroplocations[level.hordedroplocations.size] = level.hordeuseddroplocations[0];
            level.hordeuseddroplocations = common_scripts\utility::array_remove( level.hordeuseddroplocations, level.hordeuseddroplocations[0] );
        }

        foreach ( var_2 in level.players )
        {
            if ( !maps\mp\_utility::isreallyalive( var_2 ) )
                continue;

            var_3 = var_2 thread maps\mp\killstreaks\_orbital_carepackage::playerlaunchcarepackage( "horde_support_drop", var_2.killstreakmodules );
        }

        level.horderoundstats["support_drops_earned"]++;
    }
}

sortdroplocations()
{
    var_0 = ( 0, 0, 0 );
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) || !isalive( var_3 ) )
            continue;

        var_1++;
        var_0 += ( var_3.origin[0], var_3.origin[1], var_3.origin[2] );
    }

    var_5 = var_0 / var_1;
    level.hordedroplocations = sortbydistance( level.hordedroplocations, var_5 );
}

monitorsupportdropprogress()
{
    level.supportbarsize = getsupportbarsize();

    for (;;)
    {
        level common_scripts\utility::waittill_any( "pointsEarned", "host_migration_end" );

        if ( level.currentpointtotal >= level.supportbarsize )
        {
            level notify( "airSupport" );

            foreach ( var_1 in level.players )
                maps\mp\gametypes\_horde_armory::addarmorypoints( var_1, "support_bar_filled" );

            level.currentpointtotal -= level.supportbarsize;
            level.supportbarsize = getsupportbarsize();
            setomnvar( "ui_horde_support_drop_progress", 100 );
            wait 2.72;
        }

        setomnvar( "ui_horde_support_drop_progress", int( level.currentpointtotal / level.supportbarsize * 100 ) );
    }
}

getsupportbarsize()
{
    var_0 = getmaxenemycount( level.currentroundnumber );
    var_1 = int( level.currentroundnumber / 4 );
    var_2 = 45 + var_1 * 15;
    var_3 = 1500;

    if ( maps\mp\gametypes\_horde_util::getnumplayers() == 2 )
        var_3 = 2100;
    else if ( maps\mp\gametypes\_horde_util::getnumplayers() == 3 )
        var_3 = 3300;
    else if ( maps\mp\gametypes\_horde_util::getnumplayers() == 4 )
        var_3 = 4100;

    var_3 += 800 * level.hordedifficultylevel;
    return var_3 + var_0 * var_2;
}

activateplayerhud( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    wait 0.05;

    if ( level.currentroundnumber == 0 )
        var_1 = hordegetstartingroundnum( getdvarint( "scr_horde_startinground" ) );
    else
        var_1 = level.currentroundnumber;

    setomnvar( "ui_horde_round_number", var_1 );
    thread watchforhostmigrationsetround();
}

watchforhostmigrationsetround()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        var_0 = int( max( level.currentroundnumber, 1 ) );
        setomnvar( "ui_horde_round_number", var_0 );

        foreach ( var_2 in level.players )
        {
            if ( isai( var_2 ) )
                continue;

            if ( !isdefined( var_2 ) )
                continue;

            if ( !isdefined( var_2.horde_perks ) )
                continue;

            if ( !var_2.horde_perks.size )
                continue;

            var_3 = var_2.horde_perks.size;

            for ( var_4 = 0; var_4 < var_3; var_4++ )
            {
                if ( !isdefined( var_2 ) )
                    continue;

                if ( !isagent( var_2 ) )
                    var_2 setclientomnvar( "ui_horde_update_perk", var_2.horde_perks[var_4]["index"] );

                wait 0.05;
            }
        }
    }
}

watchforhostmigrationselectclass()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_begin" );

        foreach ( var_1 in level.players )
        {
            var_2 = var_1 getclientomnvar( "ui_horde_show_armory" );
            var_3 = var_1 getclientomnvar( "ui_horde_armory_type" );

            if ( var_2 && var_3 != "killstreak_armory" && var_3 != "perk_armory" )
            {
                var_1 setclientomnvar( "ui_horde_show_armory", 0 );
                var_1 enableusability();
            }
        }

        level waittill( "host_migration_end" );

        foreach ( var_1 in level.players )
        {
            if ( !var_1.classchosen )
            {
                var_1 setclientomnvar( "ui_horde_armory_type", "class" );
                var_1 setclientomnvar( "ui_horde_show_armory", 1 );
            }
        }
    }
}

getweaponfxheight( var_0 )
{
    var_1 = var_0 getstance();

    if ( var_1 == "stand" )
        return 48;

    if ( var_1 == "crouch" )
        return 32;

    return 12;
}

displayincomingairdropmessage()
{
    wait 0.05;

    foreach ( var_1 in level.players )
    {
        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_1 ) )
            continue;

        if ( var_1.sessionstate == "spectator" )
            continue;

        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_support_drop" );
    }
}

initspawns()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    level.spawn_name = "mp_tdm_spawn";
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", level.spawn_name );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", level.spawn_name );
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

getspawnpoint()
{
    var_0 = self.team;

    if ( !maps\mp\gametypes\_horde_util::isonhumanteam( self ) && self.agent_type == "player" )
        self.hordeloadout = hordegetenemyloadout();

    if ( maps\mp\gametypes\_horde_util::isonhumanteam( self ) )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );

        if ( level.ingraceperiod )
            var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random( var_1 );
        else
            var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_nearteam( var_1 );

        return var_2;
    }

    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );

    if ( isdefined( self.hordeloadout ) && issubstr( self.hordeloadout["type"], "jugg" ) )
        var_1 = cullbadjuggspawns( var_1 );
    else if ( isdefined( self.agent_type ) && self.agent_type == "dog" )
        var_1 = cullbaddogspawns( var_1 );

    var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_safeguard( var_1 );
    return var_2;
}

cullbadjuggspawns( var_0 )
{
    if ( isarray( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( maps\mp\_utility::getmapname() == "mp_recovery" && ( distance2dsquared( var_2.origin, ( -631, -313.2, 38 ) ) < 4096 || distance2dsquared( var_2.origin, ( -1276, -129, 148 ) ) < 4096 ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );

            if ( maps\mp\_utility::getmapname() == "mp_refraction" && distance2dsquared( var_2.origin, ( -2356, -1208, 2304 ) ) < 4096 )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );

            if ( maps\mp\_utility::getmapname() == "mp_comeback" && ( distance2dsquared( var_2.origin, ( 814, -945, 239 ) ) < 4096 || distance2dsquared( var_2.origin, ( 474, 788, 184 ) ) < 4096 ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }
    }

    return var_0;
}

cullbaddogspawns( var_0 )
{
    if ( isarray( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            if ( maps\mp\_utility::getmapname() == "mp_lab2" && distance2dsquared( var_2.origin, ( -529, 1378, 499 ) ) < 4096 )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }
    }

    return var_0;
}

getagentdamagescalar()
{
    var_0 = 0.25;
    var_1 = maps\mp\gametypes\_horde_util::getnumplayers();

    switch ( var_1 )
    {
        case 0:
            var_0 = 0.015;
            break;
        case 1:
            var_0 = 0.015;
            break;
        case 2:
            var_0 = 0.025;
            break;
        case 3:
            var_0 = 0.05;
            break;
        case 4:
        default:
            var_0 = 0.05;
            break;
    }

    return var_0;
}

getplayerdamagescale()
{
    var_0 = maps\mp\gametypes\_horde_util::getnumplayers();
    var_1 = 0.05;

    switch ( var_0 )
    {
        case 1:
            var_1 = 0.05;
            break;
        case 2:
            var_1 = 0.14;
            break;
        case 3:
            var_1 = 0.32;
            break;
        case 4:
            var_1 = 0.46;
            break;
    }

    var_1 += 0.15 * level.hordedifficultylevel;
    var_1 += 0.3 * ( level.hordelevelflip - 1 );
    return var_1;
}

modifyplayerdamagehorde( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( ( !isdefined( var_2 ) || var_2.classname == "worldspawn" ) && var_0.team == level.enemyteam && isdefined( var_5 ) && ( var_5 == "killstreak_strike_missile_gas_mp" || var_5 == "warbird_missile_mp" ) )
        return 0;

    if ( isdefined( var_2 ) && isdefined( var_2.team ) && var_2.team == var_0.team )
    {
        if ( var_5 == "destructible_toy" || var_5 == "mp_lab_gas_explosion" )
        {
            var_3 = 60;
            var_3 = int( min( var_3 + var_3 * getplayerdamagescale(), 0.7 * var_0.maxhealth ) );

            if ( isdefined( var_0.horde_perks ) )
            {
                foreach ( var_10 in var_0.horde_perks )
                {
                    if ( var_10["name"] == "specialty_class_flakjacket" )
                    {
                        var_3 *= 0.5;
                        break;
                    }
                }
            }

            return int( var_3 );
        }
        else if ( var_5 == "stun_grenade_horde_mp" )
            return var_3;
        else
            return 0;
    }

    if ( isdefined( var_2 ) && isplayer( var_2 ) )
    {
        if ( var_0 == var_2 && maps\mp\_utility::iskillstreakweapon( var_5 ) )
            var_3 = 0;

        var_12 = getweaponbasename( var_5 );

        if ( var_0.team == level.enemyteam && var_2.team == level.playerteam )
        {
            if ( maps\mp\_utility::ismeleemod( var_4 ) )
                var_3 = var_0.maxhealth + 1;

            var_13 = weaponclass( var_5 );

            if ( isdefined( var_0.horde_type ) && ( var_0.horde_type == "jugg" || var_0.horde_type == "jugg_handler" ) )
            {
                if ( maps\mp\_utility::ismeleemod( var_4 ) )
                    var_3 = int( var_3 * 0.25 );
                else if ( var_5 == "boost_slam_mp" )
                    var_3 = int( var_3 * 0.25 );
                else if ( issubstr( var_5, "microdronelauncher" ) )
                    var_3 = int( var_3 * 3 );
                else if ( issubstr( var_5, "crossbow" ) )
                    var_3 = int( var_3 * 2 );
                else if ( var_13 == "rocketlauncher" )
                {
                    if ( issubstr( var_5, "stinger" ) )
                        var_3 = int( var_3 * 0.05 );
                    else if ( var_4 == "MOD_PROJECTILE_SPLASH" )
                        var_3 *= 0.9;
                    else
                        var_3 = int( var_3 * 0.1 );
                }
                else if ( var_5 == "orbital_laser_fov_mp" )
                    var_3 = int( var_3 * 0.13 );
                else if ( var_5 == "warbird_remote_turret_mp" )
                    var_3 = int( var_3 * 4 );
                else if ( var_5 == "remotemissile_projectile_mp" )
                    var_3 = int( var_3 * 7 );
                else if ( var_5 == "stealth_bomb_mp" )
                    var_3 = int( var_3 * 4 );
                else if ( issubstr( var_5, "em1" ) )
                {
                    if ( randomintrange( 0, 101 ) < 50 )
                        var_3 = 1;
                    else
                        return 0;
                }
                else if ( var_13 == "mg" && var_5 != "iw5_exominigun_mp" )
                    var_3 = int( var_3 * 0.2 );
                else if ( issubstr( var_5, "epm3" ) )
                    var_3 = int( var_3 * 2 );
                else if ( var_5 == "iw5_exominigun_mp" )
                    var_3 = int( var_3 * 3 );
                else if ( var_5 == "playermech_rocket_mp" || var_5 == "iw5_juggernautrockets_mp" || var_5 == "playermech_rocket_swarm_mp" )
                    var_3 = int( var_3 * 0.035 );
            }
            else
                var_3 = int( var_3 * var_2.weapondmgmod );

            if ( weaponclass( var_5 ) == "sniper" )
                var_3 *= 2;

            if ( weaponclass( var_5 ) == "rocketlauncher" )
            {
                var_14 = 1000;

                if ( getweaponbasename( var_5 ) == "iw5_maaws_mp" )
                {
                    if ( var_4 == "MOD_PROJECTILE_SPLASH" )
                        var_3 *= 2;

                    if ( var_3 > var_14 )
                        var_3 = var_14;
                }

                if ( getweaponbasename( var_5 ) == "iw5_mahem_mp" )
                {
                    if ( var_4 == "MOD_PROJECTILE_SPLASH" )
                        var_3 *= 3;

                    if ( var_3 > var_14 )
                        var_3 = var_14;
                }
            }

            if ( maps\mp\_utility::iskillstreakweapon( var_5 ) )
                var_3 = int( var_3 + 0 * level.currentroundnumber );

            if ( maps\mp\gametypes\_class::isvalidequipment( var_5, 0 ) )
            {
                if ( isexplosivedamagemod( var_4 ) )
                    var_3 = int( var_0.maxhealth ) + 1;

                if ( var_5 == "throwingknife_mp" )
                    var_3 = var_0.maxhealth + 1;
            }

            var_3 = int( var_3 * var_2.classdmgmod );

            if ( var_8 == "head" && var_3 >= var_0.health )
                var_2.roundheadshots++;

            var_2 givepointsfordamage( var_0, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
        }
    }

    if ( isdefined( var_2 ) && isdefined( var_2.owner ) && isplayer( var_2.owner ) )
    {
        var_15 = 0;

        if ( maps\mp\_utility::iskillstreakweapon( var_5 ) )
            var_3 = int( var_3 + 0 * level.currentroundnumber );

        if ( isagent( var_2 ) )
        {
            var_3 = int( var_3 + var_3 * 0.1 * ( level.currentroundnumber - 2 ) );
            var_15 = 1;
        }

        if ( !isdefined( var_2.chopper ) && !isdefined( var_2.ishordeenemysentry ) )
            var_2.owner givepointsfordamage( var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_15 );
    }

    if ( isplayer( var_0 ) || maps\mp\gametypes\_horde_util::isonhumanteam( var_0 ) )
    {
        if ( maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) && !var_0 maps\mp\_utility::touchingbadtrigger() )
            return 0;

        if ( var_5 == "semtexproj_mp" )
            var_3 *= 3;

        if ( isplayer( var_0 ) )
        {
            if ( issubstr( var_5, "_em1" ) )
                var_3 = int( var_3 * 0.33 + 1 );

            if ( issubstr( var_5, "microdronelauncher" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.4 ) );
            else if ( issubstr( var_5, "exominigun" ) )
                var_3 = int( var_3 * 0.4 );
            else if ( issubstr( var_5, "mp11" ) || issubstr( var_5, "bal27" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.08 ) );
            else if ( issubstr( var_5, "maul" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() - 0.02 ) );
            else if ( issubstr( var_5, "himar" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.16 ) );
            else if ( issubstr( var_5, "iw5_em1_mp" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.05 ) );
            else if ( issubstr( var_5, "iw5_em1loot8_mp" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.12 ) );
            else if ( issubstr( var_5, "iw5_em1loot4_mp" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.08 ) );
            else if ( issubstr( var_5, "iw5_em1loot1_mp" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.16 ) );
            else if ( issubstr( var_5, "epm3" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.35 ) );
            else if ( issubstr( var_5, "remote_turret" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.06 ) );
            else if ( issubstr( var_5, "warbird_missile_mp" ) )
            {
                var_3 *= 2;

                if ( var_3 > 400 )
                    var_3 = 400;

                var_3 = int( var_3 * getplayerdamagescale() );

                if ( isdefined( var_0.horde_perks ) )
                {
                    foreach ( var_10 in var_0.horde_perks )
                    {
                        if ( var_10["name"] == "specialty_class_flakjacket" )
                        {
                            var_3 = int( var_3 * 0.5 );
                            break;
                        }
                    }
                }
            }
            else if ( issubstr( var_5, "remote_energy_turret" ) )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.1 ) );
            else if ( var_5 == "frag_grenade_mp" )
                var_3 = int( var_3 * ( getplayerdamagescale() + 0.3 ) );
            else if ( var_5 == "iw5_juggernautrockets_mp" )
                var_3 = 20 + 30 * ( level.hordelevelflip - 1 );
            else if ( isdefined( var_2 ) && isdefined( var_2.type ) && issubstr( var_2.type, "tracking_drone" ) )
                var_3 = int( min( var_3 * ( getplayerdamagescale() + 0.35 ), var_0.maxhealth * 0.8 ) );
            else if ( var_5 == "killstreak_strike_missile_gas_mp" )
                return int( var_0.maxhealth * 0.1 );
            else if ( var_4 == "MOD_TRIGGER_HURT" && var_0 maps\mp\_utility::touchingbadtrigger() )
            {
                var_0.classselection = 0;

                if ( isdefined( var_0.enteringgoliath ) && var_0.enteringgoliath )
                {
                    maps\mp\_snd_common_mp::snd_message( "goliath_self_destruct" );
                    playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );
                    self thread [[ level.hordehandlejuggdeath ]]();
                }

                if ( maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) )
                {
                    if ( isdefined( var_0.isspectator ) && var_0.isspectator )
                        return 0;

                    self hudoutlinedisable();
                    self disableweapons();
                    self.movespeedscaler = 0.05;

                    if ( level.players.size > 1 )
                        thread maps\mp\gametypes\_horde_laststand::startspectatemode( 0, 0, 0 );
                    else
                        return 10000;

                    return 0;
                }

                return 10000;
            }
            else
                var_3 = int( var_3 * getplayerdamagescale() );

            if ( var_0.classselection )
                return 0;
        }
        else
            var_3 = int( var_3 * getagentdamagescalar() );

        if ( isdefined( var_2 ) && isagent( var_2 ) )
        {
            if ( maps\mp\_utility::ismeleemod( var_4 ) )
            {
                if ( issubstr( var_5, "zombiemelee" ) )
                    var_3 = int( var_0.maxhealth / 8 ) + 1;
                else
                    var_3 = int( var_0.maxhealth / 3 ) + 1;
            }

            if ( var_2.agent_type == "dog" )
            {
                var_3 = int( var_3 * 0.5 );

                if ( isdefined( var_0.isjuggernaut ) && var_0.isjuggernaut )
                    var_3 = int( var_3 / 4 );
            }
        }

        if ( issubstr( var_5, "em1" ) )
            var_3 *= var_0.energydmgmod;

        if ( isdefined( var_0.isreviving ) && var_0.isreviving )
        {
            if ( isagent( var_0 ) )
                var_3 = 0;

            if ( isplayer( var_0 ) )
                var_3 = int( var_3 * 0.7 );
        }

        if ( var_0 maps\mp\_utility::isusingremote() )
            var_3 = int( var_3 * 0.4 );
    }

    if ( var_3 < 1 )
        var_3 = 1;

    return var_3;
}

givepointsfordamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = maps\mp\_utility::isheadshot( var_3, var_6, var_2, self );
    var_9 = maps\mp\_utility::ismeleemod( var_2 ) || var_2 == "MOD_IMPACT";
    var_10 = var_1 >= var_0.health;

    if ( var_9 && var_6 == "shield" )
        return;

    var_11 = undefined;

    if ( var_10 )
    {
        if ( var_9 )
        {
            var_11 = "kill_melee";
            maps\mp\gametypes\_horde_util::awardhordemeleekills( self );
        }
        else if ( var_8 )
        {
            var_11 = "kill_head";
            maps\mp\gametypes\_horde_util::awardhordeheadshotkills( self );
        }
        else
            var_11 = "kill_normal";
    }
    else if ( var_8 && ( isdefined( var_3 ) && !maps\mp\_utility::iskillstreakweapon( var_3 ) ) )
        var_11 = "damage_head";
    else
        var_11 = "damage_body";

    givepointsforevent( var_11, var_3, var_7 );
}

givepointsforevent( var_0, var_1, var_2 )
{
    if ( isdefined( level.empowner ) )
        return;

    if ( level.hordeishardcore )
        return;

    var_3 = level.pointevents[var_0];

    if ( issubstr( var_1, "em1" ) || issubstr( var_1, "turret" ) )
        var_3 = 4;

    self.pointnotifylua[self.pointnotifylua.size] = var_3;
    level thread maps\mp\gametypes\_rank::awardgameevent( var_0, self );
    level.currentpointtotal += var_3;
    level notify( "pointsEarned" );

    if ( var_2 )
        return;
}

monitorpointnotifylua( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( var_0.pointnotifylua.size > 0 )
        {
            if ( !isagent( var_0 ) )
                var_0 setclientomnvar( "ui_horde_award_points", var_0.pointnotifylua[var_0.pointnotifylua.size - 1] );

            var_0.pointnotifylua = removelastelement( var_0.pointnotifylua );
        }

        wait 0.05;
    }
}

monitorbackbutton( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( var_0 buttonpressed( "BUTTON_BACK" ) )
        {
            if ( var_0 maps\mp\_utility::isusingremote() && var_0.usingremote == "horde_player_drone" || !var_0 maps\mp\_utility::isusingremote() )
                var_0 setclientomnvar( "ui_horde_show_armory", 1 );
        }

        wait 0.05;
    }
}

removelastelement( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
        var_1[var_2] = var_0[var_2];

    return var_1;
}

onnormaldeath( var_0, var_1, var_2 )
{
    removeperkhud( var_0 );

    if ( isplayer( var_0 ) && maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) )
    {
        maps\mp\gametypes\_horde_util::hordeupdatescore( self, 0 );

        if ( maps\mp\gametypes\_horde_laststand::gameshouldend( var_0 ) )
            maps\mp\gametypes\_horde_laststand::hordeendgame();
        else
            var_0 maps\mp\gametypes\_horde_laststand::startspectatemode( 0, 0, 0 );
    }

    if ( !isdefined( var_1 ) )
        return;

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]] )
        var_1.finalkill = 1;
}

removeperkhud( var_0 )
{
    if ( isplayer( var_0 ) && !isagent( var_0 ) )
    {
        var_0 setclientomnvar( "ui_horde_update_perk", 0 );
        var_0.horde_perks = [];
    }
}

chancetospawnpickup( var_0 )
{
    level endon( "game_ended" );

    if ( var_0.agent_type == "dog" || var_0.horde_type == "zombie" )
        return;

    if ( level.objintel && level.killssinceinteldrop > 2 )
    {
        thread spawnintelpickup( var_0.origin + ( 0, 0, 22 ) );
        level.killssinceinteldrop = 0;
        return;
    }

    if ( level.hordelevelflip == 1 )
    {
        var_1 = 8;
        var_2 = 11;
    }
    else
    {
        var_1 = 11;
        var_2 = 15;
    }

    if ( level.currentpickupcount >= level.maxpickupsperround )
        return;

    if ( level.killssinceammodrop < randomintrange( var_1, var_2 ) )
        return;

    if ( level.currentammopickupcount < level.maxammopickupsperround )
    {
        var_3 = level.ammopickupmodel;
        var_4 = level.ammopickupfunc;
        level.currentammopickupcount++;
        level.killssinceammodrop = 0;
        spawnpickup( var_0.origin + ( 0, 0, 22 ), var_3, var_4, undefined, 1 );
    }
}

spawnintelpickup( var_0 )
{
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "greece_drone_control_pad" );
    var_1.angles = ( 0, 0, 0 ) + ( randomint( 360 ), randomint( 360 ), randomint( 360 ) );
    var_1 physicslaunchserver( var_1.origin, ( 0, 0, -1 ) );
    var_1 makeusable();
    var_1 sethintstring( &"HORDE_PICKUP_INTEL" );
    var_1 hudoutlineenable( 4, 0 );
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "active", var_1.origin, "objective_sm" );
    var_1.objectiveindex = var_2;
    level.collectobjects[level.collectobjects.size] = var_1;
    var_1 waittill( "trigger", var_3 );
    var_3 playlocalsound( "mp_killconfirm_tags_pickup" );
    level.hordecollected++;
    setomnvar( "ui_horde_objcount_1", level.hordecollected );
    var_3 setclientomnvar( "ui_horde_count", 1 );
    var_3 thread maps\mp\gametypes\_rank::xppointspopup( "horde_collect", 500 );
    level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_3, 500 );
    level.currentpointtotal += 500;
    level notify( "pointsEarned" );

    if ( level.hordecollected == level.horde_collect_count )
    {
        thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_allintelaquired", "horde", 1, 1 );
        hordeobjectivesuccess();
        level notify( "collect_completed" );
        level.hordecollected = 0;
    }

    maps\mp\_utility::_objective_delete( var_2 );
    var_1 delete();
}

spawnpickup( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 15;

    var_5[0] = spawn( "script_model", ( 0, 0, 0 ) );
    var_5[0] setmodel( var_1 );

    if ( isdefined( var_4 ) && var_4 )
        var_5[0] hudoutlineenable( 1, 0 );

    var_6 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    var_7 = maps\mp\gametypes\_gameobjects::createuseobject( level.playerteam, var_6, var_5, ( 0, 0, 16 ), 1 );
    var_8 = var_0;
    var_7.curorigin = var_8;
    var_7.trigger.origin = var_8;
    var_7.visuals[0].origin = var_8;
    var_7 maps\mp\gametypes\_gameobjects::setusetime( 0 );
    var_7 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_7.onuse = var_2;
    level.currentpickupcount++;
    var_7 thread pickupbounce();
    var_7 thread pickuptimer( var_3 );
    return var_7;
}

pickupbounce()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "death" );
    var_0 = self;
    var_1 = self.curorigin;
    var_2 = self.curorigin + ( 0, 0, 12 );
    var_3 = 1.25;

    if ( isdefined( self.visuals ) && isdefined( self.visuals[0] ) )
        var_0 = self.visuals[0];

    for (;;)
    {
        var_0 moveto( var_2, var_3, 0.15, 0.15 );
        var_0 rotateyaw( 180, var_3 );
        wait(var_3);
        var_0 moveto( var_1, var_3, 0.15, 0.15 );
        var_0 rotateyaw( 180, var_3 );
        wait(var_3);
    }
}

pickuptimer( var_0 )
{
    self endon( "deleted" );
    wait(var_0);
    thread pickupstartflashing();
    wait 8;
    level thread removepickup( self );
}

pickupstartflashing()
{
    self endon( "deleted" );

    for (;;)
    {
        self.visuals[0] hide();
        wait 0.25;
        self.visuals[0] show();
        wait 0.25;
    }
}

removepickup( var_0 )
{
    var_0 notify( "deleted" );
    wait 0.05;
    var_0.trigger delete();
    var_0.visuals[0] delete();
}

ammopickup( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( maps\mp\gametypes\_horde_util::isonhumanteam( var_2 ) && maps\mp\_utility::isreallyalive( var_2 ) )
        {
            var_2 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_team_restock" );
            maps\mp\gametypes\_horde_util::refillammohorde( var_2 );
            var_2.health = var_2.maxhealth;
        }
    }

    var_0 playlocalsound( "scavenger_pack_pickup" );
    level thread removepickup( self );
}

collectpickup( var_0 )
{
    var_0.collectcount++;
    var_0 playlocalsound( "mp_killconfirm_tags_pickup" );
    level.hordecollected++;
    setomnvar( "ui_horde_objcount_1", level.hordecollected );
    var_0 setclientomnvar( "ui_horde_count", 1 );
    var_0 thread maps\mp\gametypes\_rank::xppointspopup( "horde_collect", 200 );
    level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0, 200 );
    level.currentpointtotal += 200;
    level notify( "pointsEarned" );
    maps\mp\_utility::_objective_delete( self.objectiveindex );
    level.collectobjects = common_scripts\utility::array_remove( level.collectobjects, self );

    if ( level.hordecollected == level.horde_collect_count )
    {
        thread maps\mp\gametypes\_horde_dialog::hordeleaderdialogallplayers( "coop_gdn_allgodtagssecured", "horde", 1, 1 );
        hordeobjectivesuccess();
        level notify( "collect_completed" );
        level.hordecollected = 0;
    }

    level thread removepickup( self );
}

dropweaponfordeathhorde( var_0, var_1 )
{
    waittillframeend;
}

ondeadevent( var_0 )
{
    if ( var_0 != level.enemyteam )
    {
        iprintln( &"MP_GHOSTS_ELIMINATED" );
        logstring( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "axis";
        level thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["allies_eliminated"] );
    }
}

setspecialloadouts()
{
    level.hordeloadouts["allies"]["loadoutPrimary"] = "iw5_kf5";
    level.hordeloadouts["allies"]["loadoutPrimaryAttachment"] = "none";
    level.hordeloadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
    level.hordeloadouts["allies"]["loadoutPrimaryAttachment3"] = "none";
    level.hordeloadouts["allies"]["loadoutPrimaryBuff"] = "specialty_null";
    level.hordeloadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.hordeloadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondary"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondaryAttachment"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondaryAttachment3"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
    level.hordeloadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.hordeloadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.hordeloadouts["allies"]["loadoutEquipment"] = "frag_grenade_mp";
    level.hordeloadouts["allies"]["loadoutOffhand"] = "none";
    level.hordeloadouts["allies"]["loadoutKillstreaks"][0] = "none";
    level.hordeloadouts["allies"]["loadoutKillstreaks"][1] = "none";
    level.hordeloadouts["allies"]["loadoutKillstreaks"][2] = "none";
    level.hordeloadouts["allies"]["loadoutKillstreaks"][3] = "none";
    level.hordeloadouts["allies"]["loadoutJuggernaut"] = 0;
    level.hordeloadouts["allies"]["loadoutPerks"] = [ "specialty_falldamage", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    level.hordeloadouts["allies"]["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];
    level.hordeloadouts["squadmate"]["loadoutPrimary"] = "iw5_ak12";
    level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment"] = "none";
    level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment2"] = "none";
    level.hordeloadouts["squadmate"]["loadoutPrimaryAttachment3"] = "none";
    level.hordeloadouts["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
    level.hordeloadouts["squadmate"]["loadoutPrimaryCamo"] = "none";
    level.hordeloadouts["squadmate"]["loadoutPrimaryReticle"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondary"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment2"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondaryAttachment3"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
    level.hordeloadouts["squadmate"]["loadoutSecondaryCamo"] = "none";
    level.hordeloadouts["squadmate"]["loadoutSecondaryReticle"] = "none";
    level.hordeloadouts["squadmate"]["loadoutEquipment"] = "frag_grenade_mp";
    level.hordeloadouts["squadmate"]["loadoutOffhand"] = "none";
    level.hordeloadouts["squadmate"]["loadoutKillstreaks"][0] = "none";
    level.hordeloadouts["squadmate"]["loadoutKillstreaks"][1] = "none";
    level.hordeloadouts["squadmate"]["loadoutKillstreaks"][2] = "none";
    level.hordeloadouts["squadmate"]["loadoutKillstreaks"][3] = "none";
    level.hordeloadouts["squadmate"]["loadoutJuggernaut"] = 0;
    level.hordeloadouts["squadmate"]["loadoutPerks"] = [ "specialty_falldamage", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    level.hordeloadouts["squadmate"]["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];
}

hordegetenemyloadout()
{
    var_0 = getwavetable();
    var_1 = tablelookup( var_0, 1, level.currentroundnumber + level.hordewaveadjust, 4 );

    if ( level.specialaitypes.size > 0 )
    {
        for ( var_2 = 0; var_2 < level.specialaistats.size; var_2++ )
        {
            if ( level.wavefirstspawn && level.specialaistats[level.specialaitypes[var_2]]["count"] < level.specialaistats[level.specialaitypes[var_2]]["maxCount"] )
            {
                level.specialaistats[level.specialaitypes[var_2]]["count"]++;
                var_1 = level.specialaitypes[var_2];
                break;
            }
            else if ( !level.wavefirstspawn && !( level.specialaitypes[var_2] == "jugg" || level.specialaitypes[var_2] == "jugg_handler" ) )
            {
                if ( maps\mp\gametypes\_horde_util::cointossweighted( hordegetchancetorespawn( level.specialaitypes[var_2] ) ) )
                    var_1 = level.specialaitypes[var_2];
            }
        }
    }

    if ( level.hordelevelflip > 1 )
    {
        var_3["loadoutPrimary"] = tablelookup( getwavetable(), 1, var_1, 10 );
        var_3["loadoutPrimaryAttachment"] = tablelookup( getwavetable(), 1, var_1, 11 );
        var_3["loadoutEquipment"] = tablelookup( getwavetable(), 1, var_1, 12 );
        var_3["startinghealth"] = int( tablelookup( getwavetable(), 1, var_1, 13 ) );
    }
    else
    {
        var_3["loadoutPrimary"] = tablelookup( getwavetable(), 1, var_1, 4 );
        var_3["loadoutPrimaryAttachment"] = "none";
        var_3["loadoutEquipment"] = tablelookup( getwavetable(), 1, var_1, 5 );
        var_3["startinghealth"] = int( tablelookup( getwavetable(), 1, var_1, 7 ) );
    }

    var_3["loadoutPrimaryAttachment2"] = "none";
    var_3["loadoutPrimaryAttachment3"] = "none";
    var_3["loadoutPrimaryBuff"] = "specialty_null";
    var_3["loadoutPrimaryCamo"] = "none";
    var_3["loadoutPrimaryReticle"] = "none";
    var_3["loadoutSecondary"] = "none";
    var_3["loadoutSecondaryAttachment"] = "none";
    var_3["loadoutSecondaryAttachment2"] = "none";
    var_3["loadoutSecondaryAttachment3"] = "none";
    var_3["loadoutSecondaryBuff"] = "specialty_null";
    var_3["loadoutSecondaryCamo"] = "none";
    var_3["loadoutSecondaryReticle"] = "none";
    var_3["loadoutKillstreaks"][0] = "none";
    var_3["loadoutKillstreaks"][1] = "none";
    var_3["loadoutKillstreaks"][2] = "none";
    var_3["loadoutKillstreaks"][3] = "none";
    var_3["name_localized"] = &"HORDE_HAMMER";
    var_3["type"] = tablelookup( getwavetable(), 1, var_1, 1 );
    var_3["loadoutPerks"] = [ "specialty_falldamage", "specialty_lightweight", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    var_3["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];

    if ( issubstr( var_3["type"], "jugg" ) )
        var_3["loadoutJuggernaut"] = 1;
    else
        var_3["loadoutJuggernaut"] = 0;

    if ( issubstr( var_3["type"], "elite" ) )
        var_3["loadoutOffhand"] = "exoshield_equipment_mp";
    else
        var_3["loadoutOffhand"] = "specialty_null";

    var_3["movespeedscale"] = int( tablelookup( getwavetable(), 1, var_1, 8 ) );
    var_3["points"] = int( tablelookup( getwavetable(), 1, var_1, 9 ) );
    return var_3;
}

hordegetchancetorespawn( var_0 )
{
    var_1 = 70;

    if ( var_0 == "handler" )
        var_1 = 30;

    return var_1;
}

hordegetenemyhealth( var_0 )
{
    var_1 = int( var_0["startinghealth"] + var_0["startinghealth"] * ( level.hordelevelflip - 1 ) * 0.5 );

    if ( maps\mp\gametypes\_horde_util::getnumplayers() == 3 )
        var_1 = int( var_1 * 1.2 );
    else if ( maps\mp\gametypes\_horde_util::getnumplayers() == 4 )
        var_1 = int( var_1 * 1.4 );

    return var_1;
}

hordeloadwaveweapons()
{
    level.hordewaveweapons = [];
    var_0 = tablelookup( getwavetable(), 1, level.currentroundnumber + 1 + level.hordewaveadjust, 4 );
    level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup( getwavetable(), 1, var_0, 4 ) + "_mp";
    level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup( getwavetable(), 1, var_0, 10 ) + "_mp";
    var_1 = strtok( tablelookup( getwavetable(), 1, level.currentroundnumber + 1 + level.hordewaveadjust, 5 ), " " );

    foreach ( var_0 in var_1 )
        level.hordewaveweapons[level.hordewaveweapons.size] = tablelookup( getwavetable(), 1, var_0, 4 ) + "_mp";

    foreach ( var_5 in level.players )
    {
        var_5 loadweapons( level.hordewaveweapons );
        var_5 loadweapons( [ "iw5_microdronelauncher_mp" ] );
    }
}

monitorplayercamping( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "start_extraction" );
    level endon( "game_ended" );

    while ( !isdefined( level.currentroundnumber ) || level.currentroundnumber < 5 )
        wait 3;

    for (;;)
    {
        wait 10;
        var_1 = var_0.origin;
        var_2 = gettime();

        for (;;)
        {
            wait 1.0;
            var_3 = distancesquared( var_0.origin, var_1 );
            var_4 = ( gettime() - var_2 ) / 1000;

            if ( var_3 > 16384 )
            {
                var_1 = var_0.origin;
                var_2 = gettime();
            }
            else if ( var_4 > 30 )
                break;

            if ( !isdefined( level.currentaliveenemycount ) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) || isdefined( var_0.isspectator ) && var_0.isspectator || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0.isreviving ) && var_0.isreviving )
            {
                while ( !isdefined( level.currentaliveenemycount ) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) || isdefined( var_0.isspectator ) && var_0.isspectator || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0.isreviving ) && var_0.isreviving )
                    wait 0.5;

                var_1 = var_0.origin;
                var_2 = gettime();
            }
        }

        var_5 = spawncamperdrone();

        if ( !isdefined( var_5 ) )
            continue;

        var_5 vehicle_setminimapvisible( 0 );
        var_5.health = 50;
        var_5 camperdroneseektarget( var_0 );
    }
}

spawncamperdrone()
{
    level endon( "game_ended" );
    level endon( "start_extraction" );

    while ( maps\mp\_utility::currentactivevehiclecount( 2 ) >= maps\mp\_utility::maxvehiclesallowed() )
        wait 1;

    var_0 = hordegetcamperdronespawn();

    if ( !isdefined( var_0 ) )
        return undefined;

    var_1 = var_0 maps\mp\_tracking_drone::createtrackingdrone();
    var_0 thread maps\mp\_tracking_drone::starttrackingdrone( var_1 );
    return var_1;
}

hordegetcamperdronespawn()
{
    var_0 = common_scripts\utility::array_randomize( level.participants );

    foreach ( var_2 in var_0 )
    {
        if ( !isagent( var_2 ) )
        {
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
            continue;
        }

        var_3 = 1;

        foreach ( var_5 in level.players )
        {
            if ( spawnsighttrace( var_2, var_2.origin, var_5.origin, 0 ) )
            {
                var_3 = 0;
                break;
            }
        }

        if ( var_3 )
            return var_2;
    }

    if ( var_0.size > 0 )
        return common_scripts\utility::random( var_0 );
    else
        return undefined;
}

camperdroneseektarget( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "leaving" );
    self setdronegoalpos( var_0, ( 0, 0, 72 ) );
    thread handlerdronedetonate( var_0 );
    thread hordespawnnanoswarm();
    thread camperdronecancel( var_0, var_0.origin );
    common_scripts\utility::waittill_any_timeout( 20, "detonate" );
    self stoploopsound();
    self playsound( "drone_warning_beap" );
    wait 1.4;
    self notify( "startSwarm" );
    waitframe();
    self radiusdamage( self.origin, 256, 100, 25, self, "MOD_EXPLOSIVE" );
    thread maps\mp\_tracking_drone::trackingdroneexplode();
}

camperdronecancel( var_0, var_1 )
{
    self endon( "startSwarm" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level.currentaliveenemycount ) || level.currentaliveenemycount < 1 || maps\mp\gametypes\_horde_util::isplayerinlaststand( var_0 ) || isdefined( var_0.isspectator ) && var_0.isspectator || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0.isreviving ) && var_0.isreviving )
        {
            self notify( "cancel_swarm" );
            waitframe();
            thread maps\mp\_tracking_drone::trackingdroneexplode();
        }

        wait 0.25;
    }
}

hordeexploitclip()
{
    if ( maps\mp\_utility::getmapname() == "mp_instinct" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 236.851, -1405, 1016 ), ( 0, 22.7, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 79, -1339.9, 1016 ), ( 0, 292.7, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 730.1, 792.5, 1080 ), ( 0, 241.8, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 681.5, 955.9, 1080 ), ( 0, 151.8, 0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_laser2" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 526, 2476, 467 ), ( 90, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 526, 2361, 436 ), ( 60, 90, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 159.5, 2473.1, 513.5 ), ( 70, 90, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -102.5, 2473.1, 513.5 ), ( 70, 90, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2336.58, 1331.1, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2162.7, 1279.51, 936 ), ( 0, 204.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2232.93, 1233.68, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2059.05, 1182.1, 936 ), ( 0, 204.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2135.11, 1182.07, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2047.53, 993.406, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2071.25, 885.376, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2063.75, 743.332, 936 ), ( 0, 114.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1990.92, 909.438, 936 ), ( 0, 204.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1998.42, 1051.48, 936 ), ( 0, 204.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1962.26, 1094.72, 872 ), ( 0, 24.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -2002.68, 1181.8, 872 ), ( 0, 24.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -2002.68, 1181.8, 1000 ), ( 0, 24.9, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1962.26, 1094.72, 1000 ), ( 0, 24.9, 0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_detroit" )
        maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 147, 2272, 673 ), ( 0, 20, 0 ) );

    if ( maps\mp\_utility::getmapname() == "mp_recovery" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1200, -1984, 32 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1456, -1984, 32 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712, -1984, 32 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1200, -1984, 288 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1456, -1984, 288 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712, -1984, 288 ), ( 0, 270, 0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_venus" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2248, 384 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2504, 384 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2760, 384 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2248, 640 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2504, 640 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2760, 640 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2248, 896 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2504, 896 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496, -2760, 896 ), ( 0, 0, 0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1516, 2164, 1016 ), ( 0, 270, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1636, 2028, 1016 ), ( 0, 0, 0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1636, 1772, 1016 ), ( 0, 0, 0 ) );
    }
}

getwavetable()
{
    var_0 = getdvarint( "scr_waveTableVersion" );
    var_1 = "mp/hordeWaves.csv";

    switch ( var_0 )
    {
        case 2:
            var_1 = "mp/hordeWavesV2.csv";
            break;
        case 1:
        default:
            var_1 = "mp/hordeWaves.csv";
            break;
    }

    return var_1;
}

hordeweaponweight( var_0 )
{
    var_1 = tablelookup( "mp/statstable.csv", 4, var_0, 8 );

    if ( !isdefined( var_1 ) || var_1 == "" )
        var_1 = tablelookup( "mp/hordeStatsTable.csv", 0, var_0, 1 );

    if ( !isdefined( var_1 ) || var_1 == "" )
        var_1 = 4;

    return int( var_1 );
}
