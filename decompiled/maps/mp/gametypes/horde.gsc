// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

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
    _id_4DF7();
    _id_57D1();
    level.teambased = 1;
    level.ishorde = 1;
    level.disableforfeit = 1;
    level.nobuddyspawns = 1;
    level.alwaysdrawfriendlynames = 1;
    level.scorelimitoverride = 1;
    level.allowlatecomers = 1;
    level._id_85B6 = 1;
    level._id_4892 = 1;
    level._id_611D = 1;
    level._id_6116 = 1;
    level._id_0AAA = 1;
    level._id_311A = 1;
    level._id_51CA = 1;
    level._id_73B4 = 1;
    level.assists_disabled = 1;
    level._id_85BA = 1;
    level._id_39C1 = 1;
    level._id_0AA8 = 0;
    level.killstreakrewards = 0;
    level._id_8FDC = 0;
    level._id_2D15 = 1;
    level._id_6D6C = "allies";
    level._id_32C5 = "axis";
    level._id_55F2 = 2000;
    level._id_2527 = "";
    level._id_9372 = [];
    level.rankedmatch = 0;
    level.grenadegraceperiod = 0;
    level.disableweaponstats = 1;
    level.weaponweightfunc = ::hordeweaponweight;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onnormaldeath = ::onnormaldeath;
    level.onspawnplayer = ::onspawnplayer;
    level.modifyplayerdamage = ::_id_5D4F;
    level.callbackplayerlaststand = _id_A795::_id_19F7;
    level.ondeadevent = ::ondeadevent;
    level._id_2559 = _id_A792::_id_241E;
    level.onsuicidedeath = ::onnormaldeath;
    level.weapondropfunction = ::_id_2F99;
    level.hordevomissionfail = _id_A793::hordevomissionfail;
    level.hordeupdatetimestats = _id_A798::hordeupdatetimestats;
    level.cb_usedkillstreak = _id_A798::_id_49BA;
    level.custom_giveloadout = ::hordecustomgiveloadout;
    level.hordehandlejuggdeath = _id_A795::hordehandlejuggdeath;
    level.hordegivebackgoliath = _id_A798::hordegivebackgoliath;
    level.laststandsaveloadoutinfo = _id_A795::laststandsaveloadoutinfo;
    level.hordeonunderwater = _id_A798::hordeonunderwater;
    level.hordedropandresetuplinkball = _id_A798::hordedropandresetuplinkball;
    level._id_49B2 = 0;
    level._id_A2A3 = 1;
    level._id_31D4 = 0;
    level._id_0720 = [];
    level._id_496D = [];
    level._id_4944 = 10;
    level._id_4943 = 20;
    level._id_4945 = 3;
    level._id_4966 = 0;
    level._id_62DC = 0;
    level._id_62DB = 0;
    level._id_630B = 0;
    level._id_62DD = 0;
    level.objuplink = 0;
    level._id_515E = 0;
    level._id_537C = 0;
    level._id_537B = 0;
    level._id_49DE = 0;
    level._id_49A8 = 1;
    level._id_4988 = 60;
    level._id_49B8 = "None";
    level.hordeweaponsjammed = 0;
    level._id_A3D0 = 0;
    level._id_64B7 = 0;
    level._id_3679 = undefined;
    level._id_6298 = 0;
    level._id_2F3C = "remote_turret_mp";
    level._id_4960 = 1;
    level._id_6D38 = 0;
    level._id_6152 = 1;
    level._id_A2CB = [ "0", "01", "03", "05", "06", "12", "09", "11", "14", "13", "15", "01", "03", "05", "06", "12", "09", "11", "14", "15", "16" ];
    level._id_49BE = [];
    level._id_49BE["support_drops_earned"] = 0;
    level._id_49BE["round_time"] = 0;
    level._id_49BE["objective_points"] = 0;
    level._id_1E3A = [];
    level._id_1E3A["light"]["classhealth"] = 125;
    level._id_1E3A["light"]["classDmgMod"] = 1;
    level._id_1E3A["light"]["allowDodge"] = 1;
    level._id_1E3A["light"]["allowSlide"] = 1;
    level._id_1E3A["light"]["speed"] = 1.15;
    level._id_1E3A["light"]["killstreak"] = "uav";
    level._id_1E3A["light"]["exoAbility"] = "exohoverhorde_equipment_mp";
    level._id_1E3A["light"]["classGrenade"] = "frag_grenade_horde_mp";
    level._id_1E3A["light"]["battery"] = 100;
    level._id_1E3A["heavy"]["classhealth"] = 250;
    level._id_1E3A["heavy"]["classDmgMod"] = 1.15;
    level._id_1E3A["heavy"]["allowDodge"] = 0;
    level._id_1E3A["heavy"]["allowSlide"] = 0;
    level._id_1E3A["heavy"]["speed"] = 0.9;
    level._id_1E3A["heavy"]["killstreak"] = "heavy_exosuit";
    level._id_1E3A["heavy"]["exoAbility"] = "exoshieldhorde_equipment_mp";
    level._id_1E3A["heavy"]["classGrenade"] = "frag_grenade_horde_mp";
    level._id_1E3A["heavy"]["battery"] = 100;
    level._id_1E3A["support"]["classhealth"] = 150;
    level._id_1E3A["support"]["classDmgMod"] = 1;
    level._id_1E3A["support"]["allowDodge"] = 0;
    level._id_1E3A["support"]["allowSlide"] = 0;
    level._id_1E3A["support"]["speed"] = 1;
    level._id_1E3A["support"]["killstreak"] = "remote_mg_sentry_turret";
    level._id_1E3A["support"]["exoAbility"] = "exocloakhorde_equipment_mp";
    level._id_1E3A["support"]["classGrenade"] = "frag_grenade_horde_mp";
    level._id_1E3A["support"]["battery"] = 100;
    level._id_1E3A["demolition"]["classhealth"] = 150;
    level._id_1E3A["demolition"]["classDmgMod"] = 1;
    level._id_1E3A["demolition"]["allowDodge"] = 0;
    level._id_1E3A["demolition"]["allowSlide"] = 1;
    level._id_1E3A["demolition"]["speed"] = 1;
    level._id_1E3A["demolition"]["killstreak"] = "missile_strike";
    level._id_1E3A["demolition"]["exoAbility"] = "exorepulsor_equipment_mp";
    level._id_1E3A["demolition"]["classGrenade"] = "contact_grenade_horde_mp";
    level._id_1E3A["demolition"]["battery"] = 100;
    level._id_5D47 = [];
    level._id_5D46 = [];
    level._id_5D45 = [];
    level._id_5D48 = [];
    level._id_49AB = [ "assault", "assault_elite", "em1", "em1_heavy", "cloak", "rocket", "em1_heavy" ];
    level._id_49AD = [ "shotgun", "smg", "assault", "em1" ];
    level._id_49AC = [ "em1_heavy", "assault_elite", "rocket", "cloak", "epm3", "handler" ];
    level._id_49AE = [ "Quad", "jugg", "jugg_handler", "em1_heavy" ];
    level._id_4995 = ::_id_4995;
    level._id_497B = getentarray( "horde_dome", "targetname" );
    level thread watchforhostmigrationselectclass();
    level thread hordeexploitclip();
    thread maps\mp\gametypes\_horde_warbird::horde_setup_warbird_pathnode_patch();
}

_id_4995()
{
    _id_888E();
    var_0 = level._id_4986[0];
    level._id_49D9[level._id_49D9.size] = var_0;
    level._id_4986 = common_scripts\utility::array_remove( level._id_4986, var_0 );
    return var_0;
}

_id_495B()
{
    thread maps\mp\gametypes\_menus::setteam( level._id_6D6C );
}

_id_57D1()
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

_id_4DF7()
{
    level._id_5A48 = _id_401C();
    level._id_5A21 = 4;
    level._id_251E = 0;
    level._id_250A = 0;
    level._id_0B7D = "mil_grenade_box";
    level._id_202D = "prop_dogtags_future_enemy_animated";
    level._id_0B7C = ::_id_0B7A;
    level._id_202C = ::_id_202B;
}

_id_A05A( var_0 )
{
    level endon( "all_players_ready" );
    level endon( "collect_complete" );
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
    _id_802D( "ui_cranked_bomb_timer_final_seconds", 1 );
}

_id_7F86( var_0, var_1 )
{
    level thread _id_A05A( var_1 - 5 );
    _id_802D( "ui_cranked_bomb_timer_text", var_0 );
    _id_802D( "ui_cranked_bomb_timer_end_milliseconds", int( gettime() + var_1 * 1000 ) );
}

_id_1EEF()
{
    _id_802D( "ui_cranked_bomb_timer_end_milliseconds", 0 );
}

_id_802D( var_0, var_1 )
{
    level._id_9372[var_0] = var_1;

    foreach ( var_3 in level.players )
    {
        if ( !isagent( var_3 ) )
            var_3 setclientomnvar( var_0, var_1 );
    }
}

_id_9B83( var_0 )
{
    foreach ( var_3, var_2 in level._id_9372 )
    {
        if ( !isagent( var_0 ) )
            var_0 setclientomnvar( var_3, var_2 );
    }
}

_id_401C()
{
    var_0 = _id_A798::_id_4056() + 1;
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
    getteamplayersalive( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    maps\mp\_utility::setobjectivetext( "allies", &"OBJECTIVES_DOM" );
    maps\mp\_utility::setobjectivetext( "axis", &"OBJECTIVES_DOM" );
    maps\mp\_utility::setobjectivescoretext( "allies", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::setobjectivescoretext( "axis", &"HORDE_OBJECTIVE_SCORE" );
    maps\mp\_utility::setobjectivehinttext( "allies", &"HORDE_OBJECTIVE_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"HORDE_OBJECTIVE_HINT" );
    initspawns();
    _id_A793::_id_4975();
    var_0[0] = level.gametype;
    maps\mp\gametypes\_gameobjects::main( var_0 );
    _id_4DC2();
    level thread _id_5E87();
    level thread _id_64CC();
    level thread _id_76CD();

    if ( !level._id_49A5 )
        level thread _id_76C8();
}

_id_4DC2()
{
    setdvar( "g_keyboarduseholdtime", 250 );
    level._id_4986 = common_scripts\utility::getstructarray( "horde_drop", "targetname" );
    level._id_49D9 = [];
    level._id_4E9A = "iw6_minigunjugg_mp";
    level._id_4976 = int( clamp( getdvarint( "scr_horde_difficulty" ), 0, 2 ) );
    level._id_49CB = getdvarint( "scr_horde_startinground" );
    level._id_49A5 = getdvarint( "scr_horde_hardcore" );
    level._id_5A4E = 25;
    level._id_2520 = 0;
    level._id_251F = 0;
    level._id_32B6 = 0;
    level._id_2F6F = 0;
    _id_4987();
    level._id_1C66 = 0;
    level._id_5594 = 0;
    level._id_6E22 = [];
    level._id_6E22["damage_body"] = 10;
    level._id_6E22["damage_head"] = 30;
    level._id_6E22["kill_normal"] = 20;
    level._id_6E22["kill_melee"] = 50;
    level._id_6E22["kill_head"] = 50;
    level._id_6E22["kill_defend"] = 50;
    level._id_6E22["collect"] = 50;
    level._id_4AEA = 50;
    level._id_4ADD = 395;

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
        level._id_5A4E = 12;
}

_id_4987()
{
    foreach ( var_1 in level._id_4986 )
    {
        var_2 = var_1.origin + ( 0.0, 0.0, 32.0 );
        var_3 = var_1.origin - ( 0.0, 0.0, 256.0 );
        var_4 = bullettrace( var_2, var_3, 0 );
        var_1._id_9493 = var_1.origin;

        if ( var_4["fraction"] < 1 )
            var_1._id_9493 = var_4["position"];
    }
}

_id_64CC()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0._id_3BF2 = 1;
        level thread _id_2434( var_0 );
        level thread _id_5ECB( var_0 );
        level thread _id_5E48( var_0 );
        level thread _id_9B3D( var_0 );
        level thread _id_9B3B( var_0 );
        level thread _id_A797::_id_5EC1( var_0 );
        level thread _id_A798::hordeupdatenummatches( var_0 );
        level thread monitorplayercamping( var_0 );
        level thread monitordisconnect( var_0 );

        if ( isdefined( level._id_62DC ) && level._id_62DC )
            level thread _id_496C( var_0 );

        thread _id_39AD( var_0 );
        var_0 thread _id_A791::closehordearmoryonoffhandweapon();
    }
}

_id_39AD( var_0 )
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

_id_2434( var_0 )
{
    var_0._id_4948 = [];
    var_0._id_6E25 = [];
    var_0.beingrevived = 0;
    var_0._id_A1CA = 0;
    var_0.hasselfrevive = 0;
    var_0.saveweapons = [];
    var_0.firstsaveweapon = "none";
    var_0.classselection = 0;
    var_0._id_53B5 = 0;
    var_0._id_62AA = int( 0 );
    var_0.numcratesobtained = 0;
    var_0._id_7656 = 0;
    var_0.horde_score = int( 0 );
    var_0.deaths = 511;
    var_0 maps\mp\_utility::setpersstat( "deaths", var_0.deaths );
    var_0.objectivescompleted = 0;
    var_0.meleekills = 0;
    var_0.headshotkills = 0;
    var_0.numsincesamedroptype = 0;
    var_0.lastdroptype = "none";
    var_0._id_7654 = 0;
    var_0._id_7653 = 0;
    var_0._id_765C = 0;
    var_0._id_499D = 0;
    var_0._id_0CD5 = 0;
    var_0._id_2029 = 0;
    var_0._id_1E34 = 1;
    var_0._id_A2DB = 0;
    var_0._id_4957 = 0;
    var_0.hordeexobattery = 0;
    var_0._id_32CC = 1;
    var_0._id_A2CE = 1;
    var_0._id_1E32 = 0;
    var_0._id_1E31 = 1;
    var_0.classchosen = 0;
    var_0._id_4963 = undefined;
    var_0._id_5193 = 0;
    var_0._id_1E3C = 0;
    var_0._id_5194 = 0;
    var_0.missileweapon = undefined;
    var_0.rocket = undefined;
    var_0.markedformech = [];
    var_0.aerialassaultdrone = undefined;
    var_0._id_4964["light"]["primary"] = "iw5_kf5_mp";
    var_0._id_4964["light"]["secondary"] = "iw5_titan45_mp_xmags";
    var_0._id_4964["support"]["primary"] = "iw5_uts19_mp";
    var_0._id_4964["support"]["secondary"] = "iw5_vbr_mp_xmags";
    var_0._id_4964["heavy"]["primary"] = "iw5_em1_mp";
    var_0._id_4964["heavy"]["secondary"] = "iw5_pbw_mp_xmags";
    var_0._id_4964["demolition"]["primary"] = "iw5_microdronelaunchercoop_mp";
    var_0._id_4964["demolition"]["secondary"] = "iw5_titan45_mp_xmags";
    var_0._id_49A6 = [ "sentry_guardian", "assault_ugv_ai", "assault_ugv_mg" ];
    var_0._id_1E3A = level._id_1E3A;
    var_0.ignoreme = 1;

    if ( 1 )
    {
        if ( 0 )
            level._id_6D61 = "iw5_kf5_mp_none";
        else
            level._id_6D61 = "iw5_kf5_mp";

        var_1 = getweaponbasename( level._id_6D61 );
    }

    level thread _id_070D( var_0 );
    level thread _id_5EAA( var_0 );
    level thread _id_A791::_id_5ED8( var_0 );
    _id_A798::hordecleardata( var_0 );
    _id_A798::hordecompletetu1transition( var_0 );

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
        var_3 = var_0 _meth_82F3();

        if ( var_0 attackbuttonpressed() || var_0 adsbuttonpressed() || var_0 meleebuttonpressed() || var_0 fragbuttonpressed() || var_0 secondaryoffhandbuttonpressed() || var_0 _meth_83DE() || var_0 _meth_83BB() || var_3[0] != 0 || var_3[1] != 0 )
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
            var_0 iclientprintlnbold( &"GAME_INACTIVEDROPWARNING" );
            var_2 = 1;
        }

        if ( var_0.sessionstate != "spectator" )
            var_1 += 0.05;

        if ( level._id_A3D0 )
            break;

        wait 0.05;
    }
}

_id_474B( var_0, var_1 )
{
    return isdefined( var_1 ) && isdefined( var_0._id_A2E3[var_1] );
}

_id_6A20()
{
    playfx( level._effect["spawn_effect"], self.origin );
}

onspawnplayer()
{
    var_0 = undefined;

    if ( self._id_3BF2 )
    {
        self.pers["class"] = "gamemode";
        self.pers["lastClass"] = "";
        self.pers["gamemodeLoadout"] = level._id_49A9[level._id_6D6C];
        self.class = self.pers["class"];
        self.lastclass = self.pers["lastClass"];
        maps\mp\gametypes\_class::giveloadout( self.team, self.class );
        self.maxhealth = 200;
        self.health = self.maxhealth;
    }

    if ( isagent( self ) )
    {
        if ( !_id_A798::_id_5164( self ) )
        {
            _id_7F5E( self );
            var_0 = self.hordeloadout;
            self.pers["gamemodeLoadout"] = var_0;
            self._id_4949 = var_0["type"];
            self._id_120E = var_0["points"];

            if ( var_0["type"] == "zombie" )
                self.agentname = undefined;
            else
                self.agentname = var_0["name_localized"];

            thread _id_6A20();
            self _meth_837A( "allowGrenades", 1 );
        }
        else
        {
            self.pers["gamemodeLoadout"] = level._id_49A9["squadmate"];
            maps\mp\bots\_bots_util::_id_16ED( "camper" );
            maps\mp\bots\_bots_util::_id_16EB( "regular" );
            self _meth_837A( "allowGrenades", 1 );
        }

        self.avoidkillstreakonspawntimer = 0;
    }

    thread onspawnfinished( var_0 );
}

_id_7F5E( var_0 )
{
    var_0 maps\mp\bots\_bots_util::_id_16ED( "run_and_gun" );
    var_0 maps\mp\bots\_bots_util::_id_16EB( "recruit" );
    var_0 _id_494E();
}

onspawnfinished( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !self._id_3BF2 )
        return;

    self waittill( "applyLoadout" );
    maps\mp\killstreaks\_killstreaks::clearkillstreaks();

    if ( _id_A798::_id_5164( self ) )
    {
        self givemaxammo( level._id_6D61 );

        if ( self._id_3BF2 )
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
            self loadweapons( _id_A795::hordelaststandweapon() );
            childthread _id_9B50( self._id_3BF2 );
            _id_73CB( self );
            _id_9B83( self );
        }

        if ( isagent( self ) )
        {
            self.agentname = &"HORDE_GRUNT";
            self._id_4949 = "Buddy";
            childthread _id_0B7E();
            thread maps\mp\bots\_bots::_id_1715();
        }
    }
    else
    {
        childthread _id_0B7E();
        childthread _id_0B7F();
        self.maxhealth = hordegetenemyhealth( var_0 );
        self.health = self.maxhealth;
        _id_494F();

        if ( self._id_4949 != "zombie" )
            _id_4955();

        switch ( self._id_4949 )
        {
            case "shotgun":
                self.agentname = &"HORDE_GRUNT";
                self _meth_837A( "maxNonAutoFireDelay", 1500 );
                self _meth_837A( "minNonAutoFireDelay", 800 );
                self _meth_852D( randomintrange( 1, 5 ) );
                break;
            case "smg":
                self.agentname = &"HORDE_GUNNER";
                _id_49C4( "kva_body_smg_mp", "kva_head_smg" );
                self _meth_837A( "minBurstFireTime", 100 );
                self _meth_837A( "maxBurstFireTime", 600 );
                self _meth_837A( "minTimeBetweenBursts", 600 );
                self _meth_837A( "maxTimeBetweenBursts", 1500 );
                self _meth_837A( "dodgeChance", 0.3 );
                self _meth_837A( "dodgeIntelligence", 0.8 );
                self _meth_852D( randomintrange( 5, 9 ) );
                break;
            case "cloak":
                self.agentname = &"HORDE_ASSASSIN";
                self.movespeedscaler = var_0["movespeedscale"];
                self _meth_837A( "minBurstFireTime", 200 );
                self _meth_837A( "maxBurstFireTime", 1000 );
                self _meth_837A( "minTimeBetweenBursts", 500 );
                self _meth_837A( "maxTimeBetweenBursts", 1200 );
                self _meth_837A( "dodgeChance", 0.8 );
                self _meth_837A( "dodgeIntelligence", 1.0 );
                self _meth_852D( 10 );
                self cloakingenable();
                break;
            case "assault":
                self.agentname = &"HORDE_ASSAULT";
                self _meth_837A( "minBurstFireTime", 400 );
                self _meth_837A( "maxBurstFireTime", 1200 );
                self _meth_837A( "minTimeBetweenBursts", 400 );
                self _meth_837A( "maxTimeBetweenBursts", 1200 );
                self _meth_837A( "dodgeChance", 0.6 );
                self _meth_837A( "dodgeIntelligence", 0.8 );

                if ( level._id_49A8 < 2 )
                {
                    self _meth_837A( "strafeChance", 0.4 );
                    self _meth_837A( "reactionTime", 425 );
                }

                self _meth_852D( 10 );
                break;
            case "assault_elite":
                self.agentname = &"HORDE_ELITE";
                self _meth_837A( "minBurstFireTime", 600 );
                self _meth_837A( "maxBurstFireTime", 2400 );
                self _meth_837A( "minTimeBetweenBursts", 100 );
                self _meth_837A( "maxTimeBetweenBursts", 600 );
                self _meth_837A( "dodgeChance", 0.6 );
                self _meth_837A( "dodgeIntelligence", 0.8 );
                self _meth_837A( "reactionTime", 100 );
                self _meth_837A( "diveChance", 0.2 );

                if ( level._id_49A8 < 3 )
                    self _meth_837A( "strafeChance", 0.7 );

                self _meth_852D( randomintrange( 19, 23 ) );

                if ( level._id_49A8 > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                {
                    self takeallweapons();
                    self giveweapon( "turretheadmg_mp" );
                    self switchtoweaponimmediate( "turretheadmg_mp" );
                }

                break;
            case "epm3":
                self.agentname = &"HORDE_EPM3";
                self _meth_837A( "dodgeChance", 0.4 );
                self _meth_837A( "dodgeIntelligence", 0.8 );
                self _meth_837A( "minInaccuracy", 0.1 );
                self _meth_837A( "maxInaccuracy", 0.15 );
                self _meth_837A( "minNonAutoFireDelay", 200 );
                self _meth_837A( "maxNonAutoFireDelay", 400 );

                if ( level._id_49A8 < 3 )
                    self _meth_837A( "reactionTime", 200 );

                if ( level._id_49A8 < 2 )
                    self _meth_837A( "strafeChance", 0.5 );

                self _meth_852D( 15 );
                break;
            case "em1":
                self.agentname = &"HORDE_BEAMER";
                _id_49C4( "kva_hazmat_body_a_mp", "kva_hazmat_head_a" );
                self _meth_837A( "dodgeChance", 0.3 );
                self _meth_837A( "dodgeIntelligence", 0.5 );
                self _meth_837A( "maxNonAutoFireDelay", 2800 );
                self _meth_837A( "minNonAutoFireDelay", 1500 );
                self _meth_852D( 9 );
                break;
            case "em1_heavy":
                self.agentname = &"HORDE_BEAMER_HEAVY";
                _id_49C4( "nk_army_assault_body_mp", "nk_army_a_head" );
                self _meth_837A( "dodgeChance", 0.5 );
                self _meth_837A( "dodgeIntelligence", 0.5 );
                self _meth_837A( "maxNonAutoFireDelay", 1400 );
                self _meth_837A( "minNonAutoFireDelay", 750 );
                self _meth_852D( 18 );
                break;
            case "rocket":
                self.agentname = &"HORDE_LAUNCHER";
                _id_49C4( "atlas_arctic_guard_body_mp", "atlas_arctic_head_a" );
                self _meth_837A( "maxNonAutoFireDelay", 2000 );
                self _meth_837A( "minNonAutoFireDelay", 1000 );
                self _meth_852D( 17 );

                if ( level._id_49A8 > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                {
                    self takeallweapons();
                    self giveweapon( "turretheadrocket_mp" );
                    self switchtoweaponimmediate( "turretheadrocket_mp" );
                }

                break;
            case "jugg":
                self.agentname = &"HORDE_AST";
                maps\mp\killstreaks\_juggernaut::_id_6D48();
                self _meth_8494( 1 );
                self _meth_8352( "stand" );
                self allowjump( 0 );
                self _meth_8302( 0 );
                self _meth_8303( 0 );
                self _meth_8119( 0 );
                self _meth_811A( 0 );
                maps\mp\_utility::playerallowhighjump( 0, "class" );
                maps\mp\_utility::playerallowdodge( 0, "class" );
                _id_495A();
                thread _id_494B( 1, 1, 1 );
                thread maps\mp\killstreaks\_juggernaut::_id_6C6E();
                thread maps\mp\killstreaks\_juggernaut::_id_6955();

                if ( maps\mp\_utility::getmapname() == "mp_detroit" )
                    thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();

                break;
            case "jugg_handler":
                self.agentname = &"HORDE_AST";
                maps\mp\killstreaks\_juggernaut::_id_6D48();
                self _meth_8494( 1 );
                thread _id_494B( 1, 1, 1 );
                self _meth_8352( "stand" );
                self allowjump( 0 );
                self _meth_8302( 0 );
                self _meth_8303( 0 );
                self _meth_8119( 0 );
                self _meth_811A( 0 );
                maps\mp\_utility::playerallowhighjump( 0, "class" );
                maps\mp\_utility::playerallowdodge( 0, "class" );
                _id_495A();
                thread maps\mp\killstreaks\_juggernaut::_id_6C6E();
                thread maps\mp\killstreaks\_juggernaut::_id_6955();

                if ( maps\mp\_utility::getmapname() == "mp_detroit" )
                    thread maps\mp\agents\_agents_gametype_horde::handledetroitgoliathtrailerexploit();

                if ( level._id_2520 > 13 || level._id_49A8 > 1 || getdvarint( "scr_horde_preview" ) > 0 )
                    thread maps\mp\agents\_agents_gametype_horde::hordejuggrocketswarmthink();

                break;
            case "handler":
                self.agentname = &"HORDE_HANDLER";
                self _meth_837A( "minBurstFireTime", 1500 );
                self _meth_837A( "maxBurstFireTime", 3000 );
                self _meth_837A( "dodgeChance", 0.2 );
                self _meth_837A( "dodgeIntelligence", 0.4 );
                thread _id_494B();
                self _meth_852D( randomintrange( 11, 15 ) );
                break;
            case "zombie":
                _id_A799::_id_49C7();
                _id_A799::_id_49E6();
                self _meth_8352( "stand" );
                self _meth_8119( 0 );
                break;
            default:
        }

        self setclothtype( "cloth" );
    }

    self._id_3BF2 = 0;
}

_id_495A()
{
    self._id_12E9 = spawn( "script_model", self gettagorigin( "tag_barrel" ) );
    self._id_12E9 setmodel( "generic_prop_raven" );
    self._id_12E9 linktosynchronizedparent( self, "tag_barrel", ( 12.7, 0.0, -2.9 ), ( 90.0, 0.0, 0.0 ) );
    self._id_12E4 = spawn( "script_model", self._id_12E9 gettagorigin( "j_prop_1" ) );
    self._id_12E4 setmodel( "npc_exo_armor_minigun_barrel" );
    self._id_12E4 linktosynchronizedparent( self._id_12E9, "j_prop_1", ( 0.0, 0.0, 0.0 ), ( -90.0, 0.0, 0.0 ) );
}

_id_494E()
{
    var_0 = self;
    var_0 _meth_837A( "visionBlinded", 0.05 );
    var_0 _meth_837A( "hearingDeaf", 0.05 );
    var_0 _meth_837A( "targetVehicleChance", 1 );
    var_0 _meth_837A( "meleeReactAllowed", 1 );
    var_0 _meth_837A( "meleeReactionTime", 600 );
    var_0 _meth_837A( "meleeDist", 85 );
    var_0 _meth_837A( "meleeChargeDist", 100 );
    var_0 _meth_837A( "minBurstFireTime", 400 );
    var_0 _meth_837A( "maxBurstFireTime", 2400 );
    var_0 _meth_837A( "minTimeBetweenBursts", 400 );
    var_0 _meth_837A( "maxTimeBetweenBursts", 1200 );
    var_0 _meth_837A( "dodgeChance", 0.0 );
    var_0 _meth_837A( "dodgeIntelligence", 0.0 );
    var_0 _meth_837A( "strafeChance", 0.35 );
    var_0 _meth_837A( "avoidSkyPercent", 0 );

    if ( level._id_2520 > 8 && level._id_49A8 == 1 )
    {
        var_0 _meth_837A( "minInaccuracy", 0.75 );
        var_0 _meth_837A( "maxInaccuracy", 1.5 );
    }
    else if ( level._id_49A8 == 1 )
    {
        var_0 _meth_837A( "minInaccuracy", 2.25 );
        var_0 _meth_837A( "maxInaccuracy", 4.5 );
    }

    if ( level._id_2520 > 20 || level._id_49A8 > 1 )
    {
        var_0 _meth_837A( "adsAllowed", 1 );
        var_0 _meth_837A( "diveChance", 0.15 );
        var_0 _meth_837A( "strafeChance", 0.5 );
        var_0 _meth_837A( "strategyLevel", 1 );
    }

    if ( level._id_49A8 == 2 )
    {
        var_0 _meth_837A( "reactionTime", 200 );
        var_0 _meth_837A( "strategyLevel", 3 );
        var_0 _meth_837A( "cornerFireChance", 0.5 );
        var_0 _meth_837A( "cornerJumpChance", 0.3 );
        var_0 _meth_837A( "strafeChance", 0.7 );
        var_0 _meth_837A( "diveChance", 0.2 );
        var_0 _meth_837A( "launcherRespawnChance", 0.25 );
        var_0 _meth_837A( "minInaccuracy", 0.5 );
        var_0 _meth_837A( "maxInaccuracy", 1.0 );
        var_0 _meth_837A( "grenadeCookPrecision", 500 );
    }
    else if ( level._id_49A8 > 2 )
    {
        var_0 _meth_837A( "reactionTime", 100 );
        var_0 _meth_837A( "strategyLevel", 3 );
        var_0 _meth_837A( "cornerFireChance", 1.0 );
        var_0 _meth_837A( "cornerJumpChance", 0.75 );
        var_0 _meth_837A( "diveChance", 0.2 );
        var_0 _meth_837A( "strafeChance", 0.9 );
        var_0 _meth_837A( "launcherRespawnChance", 0.4 );
        var_0 _meth_837A( "minInaccuracy", 0.25 );
        var_0 _meth_837A( "maxInaccuracy", 0.75 );
        var_0 _meth_837A( "grenadeCookPrecision", 100 );
    }
}

_id_494F()
{
    var_0 = self;

    if ( isdefined( var_0._id_4949 ) && var_0._id_4949 == "jugg" || var_0._id_4949 == "jugg_handler" )
        return;

    if ( level._id_49A8 > 1 || level._id_2520 >= 8 )
    {
        if ( isdefined( var_0._id_4949 ) && !common_scripts\utility::array_contains( level._id_49AB, var_0._id_4949 ) )
            return;

        if ( common_scripts\utility::cointoss() )
            return;

        var_0 maps\mp\_utility::playerallowdodge( 1, "class" );
        var_0 _meth_837A( "dodgeChance", 0.3 );
        var_0 _meth_837A( "dodgeIntelligence", 0.8 );
    }
    else if ( level._id_2520 < 3 )
        var_0 maps\mp\_utility::playerallowdodge( 0, "class" );
}

_id_4955()
{
    if ( level._id_49A8 == 1 && level._id_2520 < 12 )
        return;

    var_0 = clamp( level._id_49A8, 1, 4 );

    switch ( int( var_0 ) )
    {
        case 4:
            if ( maps\mp\_utility::currentactivevehiclecount( 2 ) < maps\mp\_utility::maxvehiclesallowed() )
            {
                if ( _id_4956( level._id_5D45, clamp( 5 * level._id_49A8, 5, 25 ) ) )
                    thread _id_494B();
            }
        case 3:
            if ( _id_4956( level._id_5D46, clamp( 10 * level._id_49A8, 10, 45 ) ) )
                thread _id_494D();
        case 2:
            if ( _id_4956( level._id_5D47, clamp( 20 * level._id_49A8, 20, 75 ) ) )
            {
                _id_494C();
                return;
            }
    }
}

_id_4956( var_0, var_1 )
{
    if ( common_scripts\utility::array_contains( var_0, self._id_4949 ) && _id_A798::_id_2007( var_1 ) )
        return 1;

    return 0;
}

_id_4950()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 setmodel( "tag_origin" );
    waitframe();
    var_0 linkto( self, "tag_origin", ( 0.0, 0.0, 16.0 ), ( 0.0, 0.0, 0.0 ) );
    wait 1;

    foreach ( var_2 in level.players )
        playfxontagforclients( common_scripts\utility::getfx( "toxic_gas" ), var_0, "tag_origin", var_2 );

    thread _id_4952();
    thread _id_4951( var_0 );
}

_id_4951( var_0 )
{
    self waittill( "death" );

    foreach ( var_2 in level.players )
        _func_2AC( common_scripts\utility::getfx( "toxic_gas" ), var_0, "tag_origin", var_2 );

    var_0 delete();
}

_id_4952()
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

_id_494D()
{
    self waittill( "death" );
    var_0 = self.origin;
    _func_071( "frag_grenade_mp", var_0, ( 0.0, 0.0, 0.0 ), 2 );
}

_id_494C()
{
    self _meth_837A( "allowGrenades", 1 );
    self _meth_837A( "exoTacticalAllowed", 1 );
    self.pers["numberOfTimesShieldUsed"] = 0;
    self settacticalweapon( "exoshieldhorde_equipment_mp" );
    self giveweapon( "exoshieldhorde_equipment_mp" );
    thread maps\mp\_exo_shield::exo_shield_think();
    maps\mp\_utility::giveperk( "specialty_extratactical", 0 );
    var_0 = self getweaponammoclip( "exoshieldhorde_equipment_mp" );
    self setweaponammoclip( "exoshieldhorde_equipment_mp", var_0 + 1 );
}

_id_494B( var_0, var_1, var_2 )
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

        var_4 = maps\mp\_tracking_drone::_id_2448();
        thread maps\mp\_tracking_drone::_id_8D3E( var_4 );
        var_4 thread _id_4675( self, var_1, var_2 );
    }
}

_id_4675( var_0, var_1, var_2 )
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
    self playloopsound( level._id_94EB._id_889A );
    self notify( "leaving" );
    var_3 = _id_A798::_id_4991( self.origin );

    if ( !isdefined( var_3 ) )
    {
        thread maps\mp\_tracking_drone::_id_94E7();
        return;
    }

    self _meth_83F9( var_3, ( 0.0, 0.0, 72.0 ) );
    thread _id_4674( var_3 );
    common_scripts\utility::waittill_any_timeout( 10, "detonate" );
    self stoploopsound();
    self playsound( "drone_warning_beap" );
    wait 1.4;
    self entityradiusdamage( self.origin, 256, 200, 25, self, "MOD_EXPLOSIVE" );
    thread maps\mp\_tracking_drone::_id_94E7();
}

respawnhandlerdrone( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    self waittill( "death" );
    wait(randomintrange( 10, 15 ));

    if ( isdefined( var_0 ) )
        var_0 thread _id_494B( 1, 1, 1 );
}

_id_4674( var_0 )
{
    self endon( "explode" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );

    while ( distance( self.origin, var_0.origin ) > 150 )
        wait 0.1;

    self notify( "detonate" );
}

_id_9B50( var_0 )
{
    self waittill( "spawned_player" );

    if ( !var_0 )
        thread maps\mp\gametypes\_hud_message::splashnotify( "horde_respawn" );
}

_id_5ECB( var_0 )
{
    var_0 endon( "disconnect" );

    for (;;)
    {
        var_0 waittill( "unresolved_collision" );
        maps\mp\_movers::_id_9A54( var_0, 0 );
        wait 0.5;
    }
}

_id_5E48( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( level._id_497B[0] ) )
        return;

    for (;;)
    {
        while ( !var_0 maps\mp\_utility::isusingremote() )
            wait 0.1;

        foreach ( var_2 in level._id_497B )
            var_2 hide();

        foreach ( var_0 in level.players )
        {
            if ( !var_0 maps\mp\_utility::isusingremote() )
            {
                foreach ( var_2 in level._id_497B )
                    var_2 showtoplayer( var_0 );
            }
        }

        while ( var_0 maps\mp\_utility::isusingremote() )
            wait 0.1;

        foreach ( var_2 in level._id_497B )
            var_2 showtoplayer( var_0 );
    }
}

_id_5E87()
{
    level endon( "zombies_start" );
    level endon( "game_ended" );

    for (;;)
    {
        var_0 = 1;

        if ( isdefined( level.flying_attack_drones ) && level.flying_attack_drones.size > 0 && isdefined( level._id_2509 ) && isdefined( level._id_6298 ) && level.flying_attack_drones.size + level._id_6298 >= level._id_2509 )
        {
            foreach ( var_2 in level.players )
            {
                if ( maps\mp\_utility::isreallyalive( var_2 ) && !_id_A798::_id_5175( var_2 ) )
                {
                    if ( var_2._id_0CD5 > 0 )
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
                if ( maps\mp\_utility::isreallyalive( var_2 ) && !_id_A798::_id_5175( var_2 ) )
                {
                    var_2 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_team_restock" );
                    _id_A798::_id_72AC( var_2 );
                }
            }
        }

        wait 1;
    }
}

_id_9B3D( var_0 )
{
    var_0 endon( "disconnect" );

    if ( level._id_2520 == 0 )
        return;

    if ( !isdefined( level.carepackages ) )
        return;

    foreach ( var_2 in level.carepackages )
    {
        if ( isdefined( var_2._id_65C2 ) )
            var_2._id_3AB6 _meth_83FA( var_2._id_65C2, 0 );
    }

    wait 0.05;

    if ( !isdefined( level.characters ) )
        return;

    foreach ( var_5 in level.characters )
    {
        if ( isdefined( var_5._id_65C2 ) )
            var_5 _meth_83FA( var_5._id_65C2, 0 );
    }

    foreach ( var_8 in level.flying_attack_drones )
    {
        if ( isdefined( var_8._id_5605 ) )
        {
            var_8 _meth_83FA( level._id_32B6, 0 );
            var_8._id_2F34 _meth_83FA( level._id_32B6, 0 );
            continue;
        }

        var_8 _meth_83FA( level._id_32B6, 1 );
        var_8._id_2F34 _meth_83FA( level._id_32B6, 1 );
    }

    foreach ( var_11 in level._id_89A1 )
    {
        if ( isdefined( var_11._id_5605 ) )
        {
            var_11 _meth_83FA( level._id_32B6, 0 );
            var_11._id_A196 _meth_83FA( level._id_32B6, 0 );
            continue;
        }

        var_11 _meth_83FA( level._id_32B6, 1 );
        var_11._id_A196 _meth_83FA( level._id_32B6, 1 );
    }

    if ( isdefined( level._id_4958 ) )
    {
        foreach ( var_14 in level._id_4958 )
        {
            var_15 = "specops_ui_exostore";

            if ( var_14.script_parameters == "specops_ui_equipmentstore" )
                var_15 = "specops_ui_weaponstore";

            var_14.headicon = var_14 maps\mp\_entityheadicons::setheadicon( var_0, var_15, ( 0.0, 0.0, 48.0 ), 4, 4, undefined, undefined, 0, 1, undefined, 0 );
        }
    }
}

_id_9B3B( var_0 )
{
    if ( level._id_515E )
    {
        setomnvar( "ui_horde_show_objstatus", 1 );

        if ( level._id_62DC )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_defend" );
            setomnvar( "ui_horde_objcount_1", level._id_250F._id_5354 );
            setomnvar( "ui_horde_objmax_1", level._id_4944 );
        }
        else if ( level._id_62DB || level._id_630B )
        {
            var_1 = "horde_collect";

            if ( level._id_630B )
                var_1 = "horde_intel";

            var_0 setclientomnvar( "ui_horde_count_type", var_1 );
            setomnvar( "ui_horde_objcount_1", level._id_4966 );
            setomnvar( "ui_horde_objmax_1", level._id_4943 );
        }
        else if ( level._id_62DD )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_defuse" );
            setomnvar( "ui_horde_objcount_1", level._id_496F );
            setomnvar( "ui_horde_objmax_1", level._id_4945 );
        }
        else if ( level.objuplink )
        {
            var_0 setclientomnvar( "ui_horde_count_type", "horde_uplink" );
            setomnvar( "ui_horde_objcount_1", level.horde_ball_score );
            setomnvar( "ui_horde_objmax_1", level.horde_ball_score_count );
        }
    }
}

_id_49C4( var_0, var_1 )
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

_id_0B7E()
{
    if ( self.primaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.primaryweapon );
        wait 12;
    }
}

_id_0B7F()
{
    if ( self.secondaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.secondaryweapon );
        wait 8;
    }
}

_id_76CD()
{
    level endon( "game_ended" );
    _id_A0F5();
    _id_A791::_id_4D87();
    thread _id_49A0();

    if ( maps\mp\_utility::getmapname() != "mp_prison_z" )
        thread hordeinituplinkobjects();

    _id_49B9();
    level._id_99B4["mg_turret"]._id_9364 = 120.0;

    foreach ( var_1 in level.players )
    {
        if ( var_1.class == "gamemode" )
        {

        }

        if ( level.players.size < 2 )
            var_1.hasselfrevive = 1;
    }

    _id_A794::_id_392A();
    _id_A796::_id_49C2();

    while ( level._id_6152 )
        wait 0.05;

    for (;;)
    {
        _id_9B1E();
        _id_8519();

        if ( level._id_2520 == 3 && level._id_49A8 == 1 && maps\mp\_utility::getmapname() == "mp_urban" )
            level.dynamiceventstartnow = 1;

        _id_76CE();
        level notify( "start_round" );
        level._id_49BE["round_time"] = gettime();
        level childthread _id_5EB6();
        level waittill( "round_ended" );

        while ( level._id_62DB || level._id_62DD || level.objuplink )
            wait 0.05;

        if ( level._id_2520 < 25 )
            _id_49D7();

        _id_49AA();

        foreach ( var_1 in level.players )
        {
            _id_A798::_id_120C( var_1 );
            _id_A798::hordeupdatetimestats( var_1 );
            _id_A798::_id_41E8( var_1 );
            _id_A798::_id_41E5( var_1 );
        }
    }
}

_id_76CE()
{
    level._id_49B5 = 1;

    if ( !_id_515E() )
        return;

    if ( !isdefined( level._id_49B4 ) || level._id_49B3 >= level._id_49B4.size )
    {
        level._id_49B4 = [ 1, 2, 3, 4 ];

        if ( maps\mp\_utility::getmapname() != "mp_prison_z" )
            level._id_49B4 = common_scripts\utility::array_add( level._id_49B4, 5 );

        level._id_49B4 = common_scripts\utility::array_randomize( level._id_49B4 );
        level._id_49B3 = 0;
    }

    var_0 = level._id_49B4[level._id_49B3];

    switch ( var_0 )
    {
        case 1:
            thread _id_76CA();
            break;
        case 2:
            thread _id_76C9();
            break;
        case 3:
            thread _id_76CC();
            break;
        case 4:
            thread _id_76CB();
            break;
        case 5:
            thread runhordeuplink();
            break;
    }

    level._id_49B3++;
}

_id_515E()
{
    var_0 = [ 3, 6, 9, 13, 16, 19, 22, 24 ];

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
        var_0 = [ 3, 6 ];

    foreach ( var_2 in var_0 )
    {
        if ( level._id_2520 == var_2 )
            return 1;
    }

    return 0;
}

_id_49B5()
{
    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_complete" );
        thread _id_A791::_id_07CA( var_1, "objective_complete" );
        _id_A798::awardhordeobjectivescompleted( var_1 );
    }

    _id_A798::_id_6DDB( "mp_ctf_obj_cap_ally" );
    level._id_49B5 = 1;
    level._id_515E = 0;
}

hordeinituplinkobjects()
{
    maps\mp\gametypes\horde_ball::_id_8039();
}

runhordeuplink()
{
    level endon( "game_ended" );
    level endon( "uplink_completed" );
    setomnvar( "ui_horde_show_objstatus", 1 );
    level._id_49B5 = 0;
    level._id_515E = 1;
    level.objuplink = 1;

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_uplink" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_satellite_start", "horde", 1 );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_uplink" );
    }

    level.horde_ball_score_count = int( min( 10, 3 + 1 * ( _id_A798::_id_4056() - 1 ) ) );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level.horde_ball_score_count );
    level thread maps\mp\gametypes\horde_ball::run_horde_ball();
    thread hordesuccessmonitor();
    thread hordeuplinkcancel();
    var_3 = ( level._id_49A8 - 1 ) * 25 + level._id_2520;
    var_4 = 120 + floor( var_3 / 12 ) * 5;

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        _id_7F86( "uplink_time", var_4 );

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
            thread _id_A793::_id_49A7( "coop_gdn_objective_complete", "horde", 1, 1 );
            _id_49B5();
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
    _id_495E();
    _id_1EEF();
    level thread maps\mp\gametypes\horde_ball::horde_ball_cleanup();
    level._id_515E = 0;
    level.objuplink = 0;
    wait 3.0;
    setomnvar( "ui_horde_show_objstatus", 0 );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", 0 );
}

_id_76CA()
{
    level endon( "game_ended" );
    setomnvar( "ui_horde_show_objstatus", 1 );
    level._id_49B5 = 0;
    level._id_515E = 1;
    level._id_62DC = 1;

    if ( level._id_2520 < 10 )
        level._id_4944 = 10;
    else if ( level._id_2520 < 20 )
        level._id_4944 = 12;
    else
        level._id_4944 = 15;

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_defend" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_hardpoint", "horde", 1 );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_defend" );
    }

    if ( !isdefined( level._id_496D ) || level._id_496D.size < 1 )
    {
        level._id_496D = common_scripts\utility::getstructarray( "horde_defend", "targetname" );
        level._id_496D = common_scripts\utility::array_randomize( level._id_496D );
    }

    level._id_250F = common_scripts\utility::random( level._id_496D );
    common_scripts\utility::array_remove( level._id_496D, level._id_250F );
    var_3 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_3, "active", level._id_250F.origin, "waypoint_defend" );
    level._id_250F.index = var_3;
    level._id_250F._id_5354 = 0;

    foreach ( var_1 in level.players )
    {
        if ( var_1.sessionstate == "spectator" )
            continue;

        level._id_250F.headicon = level._id_250F maps\mp\_entityheadicons::setheadicon( var_1, "waypoint_defend", ( 0.0, 0.0, 0.0 ), 4, 4, undefined, undefined, undefined, 1, undefined, 0 );
        level thread _id_496C( var_1 );
    }

    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level._id_4944 );
    thread _id_496B();
    level common_scripts\utility::waittill_any( "defend_complete", "defend_cancel" );
    level._id_515E = 0;
    level._id_62DC = 0;
    setomnvar( "ui_horde_show_objstatus", 0 );

    foreach ( var_1 in level.players )
        level._id_250F maps\mp\_entityheadicons::setheadicon( "none", "", ( 0.0, 0.0, 0.0 ) );

    if ( isdefined( level._id_250F.headicon ) )
        level._id_250F.headicon destroy();

    maps\mp\_utility::_objective_delete( level._id_250F.index );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", 0 );
}

_id_496B()
{
    level endon( "game_ended" );
    level endon( "defend_complete" );
    level waittill( "round_ended" );
    level notify( "defend_cancel" );
    _id_495E();
}

_id_496C( var_0, var_1 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( var_1 ) )
        var_1 = level._id_250F;

    while ( level._id_62DC )
    {
        foreach ( var_3 in level.agentarray )
        {
            if ( common_scripts\utility::array_contains( var_0.markedformech, var_3 ) )
                continue;

            if ( distance( var_0.origin, var_1.origin ) < 800 )
            {
                if ( level._id_2509 < 3 )
                    var_3 hudoutlineenableforclient( var_0, 4, 0 );
                else
                    var_3 hudoutlineenableforclient( var_0, 4, 1 );

                continue;
            }

            if ( level._id_2509 < 3 )
                var_3 hudoutlineenableforclient( var_0, level._id_32B6, 0 );
            else
                var_3 hudoutlinedisableforclient( var_0 );

            var_3._id_65C2 = level._id_32B6;
        }

        wait 0.05;
    }

    foreach ( var_3 in level.agentarray )
    {
        if ( level._id_2509 < 3 )
        {
            var_3 hudoutlineenableforclient( var_0, level._id_32B6, 0 );
            continue;
        }

        var_3 hudoutlinedisableforclient( var_0 );
    }
}

_id_49A0()
{
    level._id_495D = getentarray( "horde_defuse_bomb", "targetname" );
    level._id_4971 = [];

    for ( var_0 = 0; var_0 < level._id_495D.size; var_0++ )
    {
        level._id_495D[var_0] show();
        level._id_495D[var_0] _id_4DA5();
        level._id_495D[var_0] makeusable();
        var_1 = &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES";
        level._id_495D[var_0] sethintstring( var_1 );
    }
}

_id_4DA5()
{
    var_0[0] = self;
    var_1 = getent( self.target, "targetname" );
    var_1 makeunusable();
    var_2 = maps\mp\gametypes\_gameobjects::createuseobject( "allies", var_1, var_0, ( 0.0, 0.0, 32.0 ), 1 );
    var_2 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_2 maps\mp\gametypes\_gameobjects::setusetime( 5 );
    var_2 maps\mp\gametypes\_gameobjects::setusetext( &"MP_DEFUSING_EXPLOSIVE" );
    var_2 maps\mp\gametypes\_gameobjects::setusehinttext( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
    var_2.onbeginuse = ::_id_4972;
    var_2.onenduse = ::_id_4973;
    var_2.onuse = ::_id_49B6;
    var_2.useweapon = "search_dstry_bomb_defuse_mp";
    var_2.visuals[0] hide();
    level._id_4971[level._id_4971.size] = var_2;
    self.trigger = var_1;
}

_id_27BD()
{
    level endon( "game_ended" );
    level endon( "defuse_completed" );

    for (;;)
    {
        self waittill( "trigger", var_0 );
        self.trigger notify( "trigger", var_0 );
    }
}

_id_76CB()
{
    level endon( "game_ended" );
    level endon( "defuse_completed" );
    level._id_496F = 0;
    level._id_515E = 1;
    level._id_49B5 = 0;
    level._id_62DD = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level._id_4945 );

    foreach ( var_1 in level.players )
    {
        var_1 setclientomnvar( "ui_horde_count_type", "horde_defuse" );
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_defuse" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_empbombsshowingonsensors", "horde", 1 );
    }

    level._id_4970 = getentarray( "horde_defuse", "targetname" );
    level._id_4970 = common_scripts\utility::array_randomize( level._id_4970 );

    if ( level._id_4970.size < 3 )
        level._id_4970 = level._id_4967;

    level._id_4970 = common_scripts\utility::array_randomize( level._id_4970 );
    hordemovebaddefuselocations();

    for ( var_3 = 0; var_3 < level._id_4971.size; var_3++ )
    {
        var_4 = maps\mp\gametypes\_gameobjects::getnextobjid();
        level._id_4971[var_3]._id_62FB = var_4;
        objective_add( var_4, "active", level._id_4970[var_3].origin, "objective_sm" );
        level._id_4971[var_3].curorigin = level._id_4970[var_3].origin;
        level._id_4971[var_3].visuals[0].curorigin = level._id_4970[var_3].origin;
        level._id_4971[var_3].trigger.origin = level._id_4970[var_3].origin;
        level._id_4971[var_3].origin = level._id_4970[var_3].origin;
        level._id_4971[var_3].visuals[0].origin = level._id_4970[var_3].origin;
        level._id_4971[var_3].visuals[0].angles = level._id_4970[var_3].angles;
        level._id_4971[var_3].visuals[0] _meth_83FA( 4, 0 );
        level._id_4971[var_3].visuals[0] show();
        level._id_4971[var_3].visuals[0] makeusable();
        level._id_4971[var_3].visuals[0] thread _id_27BD();
    }

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        _id_7F86( "defuse_time", 120 );

    thread _id_496E();

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
        foreach ( var_1 in level._id_4970 )
        {
            if ( var_1.origin == ( 1024.7, -285.7, 883.0 ) )
            {
                var_1.origin = ( 1209.58, -161.35, 862.0 );
                var_1.angles = ( 0.0, 0.0, 0.0 );
            }
        }
    }
}

_id_4972( var_0 )
{
    var_0 maps\mp\_utility::notify_enemy_bots_bomb_used( "defuse" );
    var_0 playsound( "mp_bomb_defuse" );
    var_0.isdefusing = 1;
    self.visuals[0] makeunusable();
    self.visuals[0] hide();
}

_id_4973( var_0, var_1, var_2 )
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

_id_49B7()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.isdefusing ) && var_1.isdefusing )
            return 1;
    }

    return 0;
}

_id_49B6( var_0 )
{
    var_0 thread maps\mp\gametypes\_rank::xppointspopup( "horde_defuse", 700 );
    level thread _id_A798::_id_49D8( var_0, 700 );
    level._id_251F += 700;
    level notify( "pointsEarned" );
    maps\mp\_utility::_objective_delete( self._id_62FB );
    self._id_62FB = undefined;
    self.visuals[0] hide();
    self.visuals[0] makeunusable();
    level._id_496F++;
    setomnvar( "ui_horde_objcount_1", level._id_496F );

    if ( level._id_496F > 2 )
    {
        _id_49B5();
        level notify( "defuse_completed" );
    }
    else
        level thread _id_A798::_id_852A( "horde_defused" );
}

_id_496E()
{
    level endon( "game_ended" );
    level waittill( "defuse_completed" );
    _id_1EEF();

    while ( _id_49B7() )
        wait 0.05;

    _id_495E();

    foreach ( var_1 in level._id_4971 )
    {
        if ( isdefined( var_1._id_62FB ) )
            maps\mp\_utility::_objective_delete( var_1._id_62FB );

        var_1.visuals[0] hide();
        var_1.visuals[0] makeunusable();
        var_1._id_62FB = undefined;
    }

    level._id_62DD = 0;
    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

_id_76C9()
{
    level endon( "game_ended" );
    level endon( "collect_completed" );
    level._id_4943 = int( min( 20, 10 + 5 * ( _id_A798::_id_4056() - 1 ) ) );
    level._id_4966 = 0;
    level._id_202A = [];
    level._id_49B5 = 0;
    level._id_515E = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );

    foreach ( var_1 in level.players )
    {
        var_1 setclientomnvar( "ui_horde_count_type", "horde_collect" );
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_collect" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_dogtagsareinthefield", "horde", 1 );
    }

    level._id_4967 = common_scripts\utility::getstructarray( "horde_collect", "targetname" );
    level._id_4967 = common_scripts\utility::array_randomize( level._id_4967 );

    for ( var_3 = 0; var_3 < level._id_4943; var_3++ )
    {
        var_4 = _id_89F4( level._id_4967[var_3].origin, level._id_202D, level._id_202C, 112, 0 );
        var_5 = maps\mp\gametypes\_gameobjects::getnextobjid();
        var_4._id_62FB = var_5;
        objective_add( var_5, "active", level._id_4967[var_3].origin, "objective_sm" );
        level._id_202A[level._id_202A.size] = var_4;
    }

    level._id_62DB = 1;
    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level._id_4943 );

    if ( getdvarint( "scr_hordenoobjtimers" ) == 0 )
        _id_7F86( "collect_time", 120 );

    thread _id_4965();

    if ( getdvarint( "scr_hordenoobjtimers" ) > 0 )
        level waittill( "round_ended" );
    else
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 120 );

    level notify( "collect_completed" );
}

_id_4965()
{
    level endon( "game_ended" );
    level waittill( "collect_completed" );
    _id_495E();
    _id_1EEF();

    foreach ( var_1 in level._id_202A )
    {
        if ( isdefined( var_1 ) )
            maps\mp\_utility::_objective_delete( var_1._id_62FB );
    }

    level._id_62DB = 0;
    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

_id_76CC()
{
    level endon( "game_ended" );
    level._id_630B = 1;
    level._id_537C = 0;
    level._id_4966 = 0;
    level._id_202A = [];

    if ( level._id_2520 < 10 )
        level._id_4943 = 3;
    else if ( level._id_2520 < 20 )
        level._id_4943 = 4;
    else
        level._id_4943 = 5;

    level._id_49B5 = 0;
    level._id_515E = 1;
    setomnvar( "ui_horde_show_objstatus", 1 );

    foreach ( var_1 in level.players )
    {
        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_obj_intel" );
        var_1 setclientomnvar( "ui_horde_count_type", "horde_intel" );
        var_1 maps\mp\_utility::leaderdialogonplayer( "coop_gdn_hostilesincomingsearchdowned", "horde", 1 );
    }

    setomnvar( "ui_horde_objcount_1", 0 );
    setomnvar( "ui_horde_objmax_1", level._id_4943 );
    thread _id_49A1();
    level common_scripts\utility::waittill_any( "collect_completed", "intel_cancel" );
    _id_495E();
    level._id_630B = 0;

    foreach ( var_4 in level._id_202A )
    {
        if ( isdefined( var_4 ) )
        {
            maps\mp\_utility::_objective_delete( var_4._id_62FB );
            var_4 delete();
        }
    }

    wait 3;
    setomnvar( "ui_horde_show_objstatus", 0 );
}

_id_49A1()
{
    level endon( "game_ended" );
    level endon( "collect_completed" );
    level waittill( "round_ended" );
    level notify( "intel_cancel" );
}

checkdefendkill( var_0, var_1 )
{
    if ( isdefined( var_1 ) && ( isplayer( var_1 ) || isplayer( var_1.owner ) ) && level._id_250F._id_5354 < level._id_4944 )
    {
        if ( var_1 maps\mp\_utility::isusingremote() && var_1.usingremote == "mg_turret" && isdefined( var_1.turret ) )
            var_1 = var_1.turret;

        if ( isdefined( var_1._id_9130 ) && isdefined( var_1._id_9130.isaerialassaultdrone ) && var_1._id_9130.isaerialassaultdrone && isdefined( var_1.owner ) )
            var_1 = var_1.owner;

        if ( distancesquared( var_1.origin, level._id_250F.origin ) <= 640000 )
        {
            level._id_250F._id_5354++;
            level._id_251F += 150;
            level notify( "pointsEarned" );
            setomnvar( "ui_horde_objcount_1", level._id_250F._id_5354 );

            if ( isdefined( var_1.owner ) )
            {
                var_1.owner thread maps\mp\gametypes\_rank::xppointspopup( "horde_defend", 150 );
                level thread _id_A798::_id_49D8( var_1.owner, 150 );
                var_1.owner setclientomnvar( "ui_horde_count", 1 );
            }
            else if ( isdefined( var_1 ) )
            {
                var_1 setclientomnvar( "ui_horde_count", 1 );
                var_1 thread maps\mp\gametypes\_rank::xppointspopup( "horde_defend", 150 );
                level thread _id_A798::_id_49D8( var_1, 150 );
            }

            if ( level._id_250F._id_5354 >= level._id_4944 )
            {
                thread _id_A793::_id_49A7( "coop_gdn_locationdefended", "horde", 1 );
                thread _id_49B5();
                level notify( "defend_complete" );
                level._id_250F notify( "defended" );
            }
        }
    }
}

_id_495E()
{
    level._id_62F7 = [];
    level._id_62F7[0] = "Emp";
    level._id_62F7[1] = "Smoke";
    level._id_62F7[2] = "Sentry";
    level._id_62F7[3] = "Pistols";
    level._id_62F7[4] = "NanoSwarm";

    if ( !level._id_49B5 )
    {
        _id_A798::_id_6DDB( "mp_ctf_obj_cap_enemy" );

        for (;;)
        {
            var_0 = common_scripts\utility::random( level._id_62F7 );

            if ( var_0 != level._id_49B8 )
            {
                level._id_49B8 = var_0;
                break;
            }
        }

        level thread _id_A798::_id_852A( "horde_obj_failed_" + var_0 );
        level._id_515E = 0;

        switch ( var_0 )
        {
            case "Emp":
                thread _id_361E();
                break;
            case "Smoke":
                thread _id_3628();
                break;
            case "NanoSwarm":
                thread _id_361F( 1 );
                break;
            case "Sentry":
                thread _id_3627();
                break;
            case "Pistols":
                thread _id_3623();
                break;
        }
    }
}

_id_361E()
{
    foreach ( var_1 in level.players )
    {
        var_2 = var_1 getclientomnvar( "ui_horde_armory_type" );

        if ( var_2 != "killstreak_armory" && var_2 != "perk_armory" )
            _id_A791::hordecleanuparmory( var_1 );
    }

    thread _id_A793::_id_49A7( "coop_gdn_systemhack", "horde", 1, 1 );
    thread _id_A791::_id_4977();
    level.players[0] maps\mp\killstreaks\_emp::_id_3070( level._id_6D6C, [ "emp_exo_kill", "emp_streak_kill", "emp_equipment_kill" ] );
}

_id_3628()
{
    level endon( "game_ended" );
    thread _id_A793::_id_49A7( "coop_gdn_tangosarepoppingsmoke", "horde", 1, 1 );
    var_0 = gettime() + int( 60000 );

    while ( gettime() < var_0 )
    {
        var_1 = common_scripts\utility::random( level.players );
        var_1 thread _id_3629();
        wait(randomfloatrange( 10, 12 ));
    }
}

_id_3629()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = 0;

    while ( var_0 != 3 )
    {
        wait(randomfloatrange( 0.25, 0.85 ));
        var_1 = _id_05BA();
        var_2 = getnodesinradiussorted( var_1, 512, 32, 256, "path" );
        var_3 = common_scripts\utility::random( var_2 );

        if ( !isdefined( var_3 ) )
            continue;

        _func_071( "smoke_grenade_mp", var_3.origin, ( 0.0, 0.0, 0.0 ), 1 );
        var_0++;
    }
}

_id_05BA()
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

_id_361F( var_0 )
{
    level endon( "game_ended" );
    var_1 = getentarray( "remoteMissileSpawn", "targetname" );
    thread _id_A793::_id_49A7( "coop_gdn_nanostrike", "horde", 1, 1 );

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

            var_10 _id_3622( var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
        }
    }
}

_id_3622( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_8 = "warbird_missile_mp";

    for ( var_9 = 0; var_9 < var_2; var_9++ )
    {
        for ( var_10 = 0; var_10 < var_3; var_10++ )
        {
            var_11 = maps\mp\killstreaks\_missile_strike::_id_3F15( var_0 );
            var_12 = _id_05BA();
            var_13 = magicbullet( var_8, var_11.origin, var_12 );

            if ( var_1 )
                var_13 thread hordespawnnanoswarm();

            var_13 _meth_81DA( var_12 );
            var_13 missile_setflightmodedirect();
            var_13 _meth_8464( 1 );
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
    var_2 = level._id_05F1["Particle_FX"]._id_3C11;
    waitframe();

    foreach ( var_4 in level.players )
        playfxontagforclients( var_2, var_0, "tag_origin", var_4 );

    badplace_cylinder( "gas_zone" + var_0 getentitynumber(), 20, var_0.origin, 200, 128, level._id_32C5 );
    var_0 thread _id_3621();
    wait 20;
    var_0.killcament delete();
    var_0 delete();
}

_id_3621()
{
    self endon( "death" );
    var_0 = 200;
    var_1 = 12;

    for (;;)
    {
        self.killcament entityradiusdamage( self.origin, var_0, var_1, var_1, undefined, "MOD_TRIGGER_HURT", "killstreak_strike_missile_gas_mp", 0 );
        wait 1;
    }
}

_id_3627()
{
    level endon( "game_ended" );
    thread _id_A793::_id_49A7( "coop_gdn_sentryguns", "horde", 1, 1 );
    var_0 = [ "remote_energy_turret_mp", "sentry_minigun_mp" ];
    var_1 = common_scripts\utility::random( var_0 );
    var_2 = clamp( level._id_49C3.size / 2, 1, 5 );
    level._id_49C3 = common_scripts\utility::array_randomize( level._id_49C3 );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = _id_A796::_id_49CA( var_1, level._id_49C3[var_3] );
        wait 2.5;
    }
}

_id_3623()
{
    level endon( "game_ended" );
    var_0 = [];
    var_1 = 45;
    level.hordeweaponsjammed = 1;
    setomnvar( "ui_horde_allow_classchange", 0 );
    level thread _id_3626( var_1 );
    thread _id_A793::_id_49A7( "coop_gdn_weaponsoffline", "horde", 1, 1 );

    foreach ( var_3 in level.players )
    {
        while ( isdefined( var_3.ball_carried ) )
            wait 0.05;

        var_3 thread _id_3625( var_1 );
        var_3 thread _id_3624( var_1, var_0 );

        if ( var_3 maps\mp\_utility::isusingremote() )
            var_3 thread _id_362B();
    }
}

_id_3624( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "death" );
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbar( 0, 190 );
    var_3 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext( 0, 185 );
    var_3 settext( &"HORDE_WEAPONS_JAMMED" );
    var_2 thread _id_362A( var_0, var_1 );
    thread failureeventpistolonlyjammedbarhide( var_2, var_3 );
    var_2 waittill( "Clear_JammedBar_UI" );
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

_id_362A( var_0, var_1 )
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

_id_3625( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = self getclientomnvar( "ui_horde_player_class" );
    var_2 = self getcurrentprimaryweapon();

    if ( maps\mp\_utility::isusingremote() )
        var_2 = self._id_4964[var_1]["primary"];

    if ( var_2 == "iw5_carrydrone_mp" )
    {
        var_3 = self getweaponslistprimaries();
        var_2 = var_3[0];
    }

    maps\mp\gametypes\_weapons::saveweapon( "jam", var_2, _id_A795::hordelaststandweapon() );
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

    var_1 = _id_A795::hordelaststandweapon();

    if ( !_id_A795::haslaststandweapon( var_1 ) )
        self giveweapon( var_1 );

    if ( !isdefined( self.underwater ) && !_id_A798::_id_5175( self ) )
        self switchtoweaponimmediate( var_1 );

    self disableweaponswitch();
    var_2 = self getweaponammostock( var_0 );
    var_3 = weaponclipsize( var_0 );

    if ( var_2 < var_3 )
        self setweaponammostock( var_0, var_3 );

    var_4 = ( self.weaponjamcompletiontime - gettime() ) * 0.001;
    wait(var_4);

    if ( !isdefined( self.underwater ) && !_id_A798::_id_5175( self ) )
        self enableweaponswitch();

    if ( !self.hadlaststandweapon )
        self takeweapon( var_1 );
}

_id_3626( var_0 )
{
    level endon( "game_ended" );
    wait(var_0);
    setomnvar( "ui_horde_allow_classchange", 1 );
    level thread _id_A798::_id_852A( "horde_weapons_enabled" );
    _id_A798::_id_6DDB( "mp_ctf_obj_cap_ally" );
    wait 0.5;
    level.hordeweaponsjammed = 0;
}

_id_362B()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "stopped_using_remote" );

    if ( isdefined( level.hordeweaponsjammed ) && level.hordeweaponsjammed )
        self switchtoweaponimmediate( "iw5_titan45_mp_xmags" );
}

_id_1FD6()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;

    if ( !isagent( self ) )
        thread maps\mp\gametypes\_playerlogic::setuioptionsmenu( -1 );
}

_id_5EB6()
{
    level._id_31D4 = level._id_5A32;

    for (;;)
    {
        level waittill( "enemy_death" );

        if ( level._id_2514 == level._id_5A32 && level._id_2509 == 0 )
        {
            _id_6231();

            foreach ( var_1 in level.players )
                _id_A791::_id_07CA( var_1, "round" );

            level._id_31D4 = 0;
            setomnvar( "ui_horde_enemies_left", level._id_31D4 );
            return;
        }
    }
}

_id_6231()
{
    level endon( "game_ended" );

    if ( getdvarint( "scr_hordenoobjtimers" ) < 1 )
    {
        while ( level._id_62DB || level._id_62DD || level.objuplink )
            wait 0.05;
    }

    level thread _id_7475();
    var_0 = "horde_wave_complete";

    if ( level._id_2520 == level._id_5A4E )
        var_0 = "horde_map_flip";

    waittillframeend;

    if ( level._id_49B5 )
    {
        if ( level._id_2520 == 10 && maps\mp\_utility::getmapname() == "mp_prison_z" )
        {
            level notify( "zombies_start" );
            setnojipscore( 1 );
            thread _id_A799::_id_76CF();
        }
        else
        {
            level thread _id_A798::_id_852A( var_0 );
            thread _id_A793::_id_49A7( "coop_gdn_roundover", "horde", 1, 1 );
        }
    }

    setdvar( "bg_compassShowEnemies", 0 );
    level._id_49B2++;

    if ( level._id_2520 == level._id_5A4E )
        wait 10;

    level notify( "round_ended" );
}

_id_7475()
{
    level endon( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( !_id_A798::_id_5165( var_1 ) )
            continue;

        if ( !isdefined( self.goliathdeath ) )
            level thread _id_7476( var_1 );
    }
}

hordecustomgiveloadout( var_0 )
{
    if ( isdefined( self._id_51B2 ) )
        self.loadout = undefined;
    else
        maps\mp\gametypes\_class::applyloadout();
}

setupplayerafterrevivefromspectator()
{
    self notify( "revive" );
    var_0 = self getclientomnvar( "ui_horde_player_class" );
    var_1 = level._id_1E3A[var_0]["speed"];
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

    self _meth_83FB();
    self laststandrevive();
    self setstance( "stand" );
    thread _id_A798::_id_4953( 1, "laststand" );
    self allowmelee( 1 );
    self enableweapons();
    common_scripts\utility::_enableusability();
    self enableoffhandweapons();
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\_utility::clearlowermessage( "last_stand" );
    maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
    maps\mp\_utility::giveperk( "specialty_horde_dualprimary", 1, 1 );

    if ( maps\mp\killstreaks\_emp::_id_51C3() && !maps\mp\_utility::_hasperk( "specialty_empimmune" ) )
        maps\mp\killstreaks\_emp::_id_0CAB();

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
    self._id_A1CA = 0;
    wait 0.1;
}

_id_7476( var_0 )
{
    level endon( "game_ended" );

    if ( isdefined( var_0._id_51B2 ) )
    {
        var_0.pers["lives"] = 1;
        var_0.pers["class"] = "gamemode";
        var_0.class = var_0.pers["class"];
        var_0.addtoteam = level._id_6D6C;
        var_0.alreadyaddedtoalivecount = 1;
        var_0 maps\mp\killstreaks\_killstreaks::clearkillstreaks( 1 );
        var_0 notify( "horde_end_spectate" );
        var_1 = var_0 getclientomnvar( "ui_horde_player_class" );

        if ( var_1 == "none" )
        {
            var_1 = "light";
            var_0 setclientomnvar( "ui_horde_player_class", var_1 );
            var_0._id_1E37 = var_0._id_1E3A[var_1]["classhealth"];
            var_2 = var_0._id_4964[var_1]["secondary"];
            var_0._id_6F8E[var_2]["ammoclip"] = 15;
            var_0._id_6F8E[var_2]["ammostock"] = 90;
            var_0 setweaponammoclip( var_2, 15 );
            var_0._id_1E3A[var_1]["battery"] = level._id_1E3A[var_1]["battery"];
            var_0._id_55FD = var_0._id_1E3A[var_1]["exoAbility"];
            wait 0.1;

            if ( var_0 getclientomnvar( "horde_first_spawn" ) == 1 )
                thread _id_A791::_id_4961( var_0 );
        }

        var_0 maps\mp\gametypes\_playerlogic::spawnplayer( 0, 0 );
        var_0._id_51B2 = undefined;
        wait 0.1;

        if ( var_0._id_A1CA )
            resetwateronrevivefromspectator();

        var_0 setupplayerafterrevivefromspectator();
        var_0 setlethalweapon( var_0._id_55B5 );
        var_0 giveweapon( var_0._id_55B5 );
        var_0 settacticalweapon( var_0._id_55FD );
        var_0 giveweapon( var_0._id_55FD );
        var_0 setweaponammoclip( var_0._id_55B5, var_0._id_55B6 );
        var_0 _id_A791::_id_0CD4( var_0._id_55FD, 1 );
        var_0 maps\mp\_utility::playerallowdodge( var_0._id_1E3A[var_1]["allowDodge"], "class" );
        var_0 maps\mp\_utility::playerallowpowerslide( var_0._id_1E3A[var_1]["allowSlide"], "class" );
        var_0 thread _id_07F9();
        var_3 = var_0 getclientomnvar( "ui_horde_player_class" );
        _id_A791::_id_4998( var_0, var_3 );
        var_0 setclientomnvar( "ks_count1", 0 );
        var_0 setclientomnvar( "ks_count_updated", 1 );
        var_0.maxhealth = var_0._id_1E37 + var_0._id_4957 * 40;
        var_0.health = var_0.maxhealth;

        if ( !var_0._id_1E31 && !level._id_A3D0 )
        {
            if ( isdefined( var_0.hordeclassgoliathcontroller ) || isdefined( var_0.hordeclassgoliathpodinfield ) )
                level thread _id_A791::hordewaitforgoliathdeath( var_0, _id_A791::getabilitywaittime( var_0 ) );
            else
                level thread _id_A791::_id_494A( var_0, _id_A791::getabilitywaittime( var_0 ) );
        }

        var_0.goliathdeath = undefined;
        var_0 _id_A795::givebackstoredplayerweapons( var_1, 1 );

        foreach ( var_5 in var_0._id_55B2 )
        {
            var_6 = _id_A798::_id_40C9( var_0 );

            if ( !isdefined( var_6 ) )
                continue;

            var_0 thread maps\mp\killstreaks\_killstreaks::givekillstreak( var_5["name"], 0, 0, var_0, var_5["modules"], var_6 );
            var_0._id_2518[var_6] = var_5["name"];
        }
    }
    else if ( _id_A798::_id_5175( var_0 ) )
        var_0 notify( "revive_trigger", var_0 );
}

_id_07F9()
{
    self endon( "death" );
    level endon( "game_ended" );

    foreach ( var_1 in self._id_55C6 )
    {
        wait 0.1;

        if ( !maps\mp\_utility::_hasperk( var_1["name"] ) )
            _id_A791::_id_499B( var_1["name"] );
    }
}

_id_9AE7()
{
    if ( level._id_49A8 > 1 )
    {
        foreach ( var_1 in level.players )
            var_1 _meth_80F9( "COOP_EXO_SURVIVOR" );
    }

    if ( level._id_49A8 > 2 )
    {
        foreach ( var_1 in level.players )
            var_1 _meth_80F9( "COOP_FLIP_FLOP" );
    }
}

_id_9B1E()
{
    if ( level._id_2520 == level._id_5A4E )
    {
        level._id_49A8++;
        setomnvar( "ui_horde_flip", level._id_49A8 );
        _id_49B9();
    }

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level._id_2520 == 10 )
        level._id_49DE = 15;

    level._id_2520 = _id_4042();
    level._id_5A31 = 0;
    level.maxwarbirdcount = 0;
    level._id_5A1D = 0;
    level._id_5A30 = 0;
    level._id_5A1C = 0;
    level._id_2CD9 = 0;
    level._id_A2A3 = 1;
    level._id_49BE["support_drops_earned"] = 0;
    var_0 = getwavetable();
    level._id_8A20 = [];
    level._id_8A21 = strtok( tablelookup( var_0, 1, level._id_2520 + level._id_49DE, 5 ), " " );
    level._id_8A1F = strtok( tablelookup( var_0, 1, level._id_2520 + level._id_49DE, 6 ), " " );

    for ( var_1 = 0; var_1 < level._id_8A21.size; var_1++ )
    {
        level._id_8A20[level._id_8A21[var_1]]["count"] = 0;
        level._id_8A20[level._id_8A21[var_1]]["maxCount"] = int( level._id_8A1F[var_1] ) + _id_3EDD( level._id_8A21[var_1] );
    }

    level._id_614F = strtok( tablelookup( var_0, 1, level._id_2520 + level._id_49DE, 7 ), " " );

    for ( var_1 = 0; var_1 < level._id_614F.size; var_1++ )
    {
        if ( issubstr( level._id_614F[var_1], "drone" ) && !( level._id_49A8 > 1 && level._id_2520 == 9 ) )
        {
            level._id_5A31 = _id_401A( level._id_2520 );
            level._id_5A1D = level._id_5A31;
            level._id_2F3C = tablelookup( getwavetable(), 1, level._id_4985, 4 );
            level._id_2F0B = int( tablelookup( getwavetable(), 1, level._id_4985, 7 ) );
            level._id_4980 = "vehicle_atlas_assault_drone";

            if ( level._id_4985 == "drone_large_energy" )
                level._id_4980 = "vehicle_atlas_assault_drone_large";
        }

        if ( issubstr( level._id_614F[var_1], "warbird" ) || level._id_49A8 > 1 && level._id_2520 == 9 || level._id_49A8 == 1 && level._id_2520 == 11 )
        {
            level.maxwarbirdcount = getmaxwarbirdcount( level._id_2520 );

            if ( level._id_49A8 > 1 && level._id_2520 == 9 || level._id_49A8 == 1 && level._id_2520 == 11 )
            {
                level.maxwarbirdcount = 1;
                level.hordewarbirdtype = "warbird";
            }

            level.warbirdweapon = tablelookup( getwavetable(), 1, level.hordewarbirdtype, 4 );
            level.warbirdhealth = int( tablelookup( getwavetable(), 1, level.hordewarbirdtype, 7 ) );
            level.hordewarbirdmodel = "vehicle_atlas_assault_warbird";
        }

        if ( issubstr( level._id_614F[var_1], "dog" ) && !( level._id_49A8 == 1 && level._id_2520 == 11 ) )
        {
            level._id_5A30 = _id_4019( level._id_2520 );
            level._id_5A1C = level._id_5A30;
        }
    }

    level._id_5A32 = _id_401B( level._id_2520 );
    level._id_2514 = 0;
    level._id_5A1E = _id_4017( level._id_2520 );
    level._id_2509 = 0;
    level._id_31D4 = 0;
    level._id_5A48 = _id_401C();
    level._id_251E = 0;
    level._id_250A = 0;
    level._id_1C66 = 0;

    if ( level._id_2520 == 10 && _id_A798::_id_4056() < 2 )
    {
        level._id_5A32 = 1;
        level._id_5A1E = 1;
    }

    if ( level._id_2520 > 4 )
        _func_25F( 1 );

    foreach ( var_3 in level.players )
    {
        var_3._id_7654 = 0;
        var_3._id_7653 = 0;
        var_3._id_765C = 0;
    }

    _id_9AE7();
}

_id_49B9()
{
    var_0 = clamp( level._id_49A8, 1, 4 );

    switch ( int( var_0 ) )
    {
        case 4:
            level._id_5D45 = _id_49BC( level._id_49AC, undefined, 3 );
        case 3:
            level._id_5D46 = _id_49BC( level._id_49AC, undefined, 2 );
        case 2:
            level._id_5D48 = _id_49BC( level._id_49AE, level._id_49AC, 3 );
        case 1:
            level._id_5D47 = _id_49BC( level._id_49AD, undefined, level._id_49AD.size / 2 );
    }
}

_id_49BC( var_0, var_1, var_2 )
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

_id_49D7()
{
    level._id_49BE["round_time"] = gettime() - level._id_49BE["round_time"];

    if ( !isdefined( level._id_3679 ) || level._id_49BE["round_time"] < level._id_3679 )
        level._id_3679 = level._id_49BE["round_time"];

    var_0 = int( level._id_49BE["round_time"] / 1000 );

    if ( var_0 > 999 )
        var_0 = 999;

    setomnvar( "ui_horde_round_time", var_0 );
    setomnvar( "ui_horde_round_drops", level._id_49BE["support_drops_earned"] );

    foreach ( var_2 in level.players )
    {
        var_2 setclientomnvar( "ui_horde_round_kills", var_2._id_7654 );
        var_2 setclientomnvar( "ui_horde_round_headshots", var_2._id_7653 );
        var_2 setclientomnvar( "ui_horde_round_points", var_2._id_765C );
    }

    if ( getomnvar( "ui_horde_show_objstatus" ) > 0 )
        setomnvar( "ui_horde_show_objstatus", 0 );

    if ( !level._id_A3D0 )
        setomnvar( "ui_horde_show_roundstats", 1 );

    var_4 = ( 300 - var_0 ) * 5;

    if ( var_4 < 0 )
        var_4 = 0;

    foreach ( var_2 in level.players )
    {
        var_6 = var_2._id_7654 * 50;
        var_7 = level._id_49BE["support_drops_earned"] * 500;
        var_8 = var_2._id_765C * 500;
        var_9 = var_2._id_7653 * 50;
        var_10 = var_4 + var_6 + var_7 + var_8 + var_9;
        level thread _id_A798::_id_49D8( var_2, var_10 );
        level thread _id_A798::_id_1209( var_2, var_2._id_7653 );
    }

    thread _id_499E();
}

_id_499E()
{
    level endon( "game_ended" );
    common_scripts\utility::waittill_any_timeout( 15, "all_players_ready", "round_begin" );
    setomnvar( "ui_horde_show_roundstats", 0 );

    if ( level._id_515E )
        setomnvar( "ui_horde_show_objstatus", 1 );
}

_id_4042()
{
    if ( level._id_2520 == level._id_5A4E )
        var_0 = 1;
    else if ( level._id_2520 == 0 )
        var_0 = _id_4996( getdvarint( "scr_horde_startinground" ) );
    else
        var_0 = level._id_2520 + 1;

    return var_0;
}

_id_4996( var_0 )
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

_id_40BA( var_0 )
{
    var_0 = int( clamp( var_0, 1, 20 ) );
    var_0 -= 1;
    return var_0 * 4 + _id_A798::_id_4056();
}

_id_401D( var_0 )
{
    var_1 = 100;

    switch ( var_0 )
    {
        case 0:
        case 1:
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

_id_401B( var_0 )
{
    var_1 = int( tablelookup( getwavetable(), 1, level._id_2520 + level._id_49DE, 2 ) ) + _id_3EDD();
    return var_1;
}

_id_401A( var_0 )
{
    var_1 = getwavetable();
    level._id_4985 = tablelookup( var_1, 1, level._id_2520 + level._id_49DE, 7 );
    var_2 = int( tablelookup( var_1, 1, level._id_2520 + level._id_49DE, 8 ) );
    return var_2;
}

_id_4019( var_0 )
{
    level._id_497A = tablelookup( getwavetable(), 1, level._id_2520 + level._id_49DE, 7 );
    var_1 = int( tablelookup( getwavetable(), 1, level._id_2520 + level._id_49DE, 8 ) );
    return var_1;
}

getmaxwarbirdcount( var_0 )
{
    var_1 = getwavetable();
    level.hordewarbirdtype = tablelookup( var_1, 1, level._id_2520 + level._id_49DE, 7 );
    var_2 = int( tablelookup( var_1, 1, level._id_2520 + level._id_49DE, 8 ) );
    return var_2;
}

_id_4017( var_0 )
{
    var_1 = int( tablelookup( getwavetable(), 1, level._id_2520 + level._id_49DE, 3 ) ) + _id_3EDD();
    return var_1;
}

_id_3EDD( var_0 )
{
    if ( level._id_2520 == 5 || level._id_2520 == 10 )
        return 0;

    var_1 = _id_A798::_id_4056() - 1;

    if ( isdefined( var_0 ) && issubstr( var_0, "jugg" ) )
    {
        if ( level._id_2520 < 14 )
            var_1 = 0;
        else if ( level._id_2520 < 24 )
            var_1 = min( 1, _id_A798::_id_4056() - 1 );
        else if ( level._id_2520 == 25 )
            var_1 = min( 2, _id_A798::_id_4056() - 1 );
    }

    return var_1;
}

_id_A0F5()
{
    maps\mp\_utility::gameflagwait( "prematch_done" );

    while ( !isdefined( level._id_1695 ) || level._id_1695 == 0 )
        wait 0.05;

    while ( !level.players.size )
        wait 0.05;
}

_id_8519()
{
    level._id_6D38 = 0;

    if ( level._id_2520 > 1 )
    {
        foreach ( var_1 in level.players )
            level thread _id_49B0( var_1, "readyup" );

        level thread _id_49B1();
    }

    setomnvar( "ui_horde_round_number_unlock", level._id_2520 );
    _id_49BD();

    foreach ( var_1 in level.players )
        var_1 setclientomnvar( "ui_horde_show_readyup", 0 );

    setomnvar( "ui_horde_round_number", level._id_2520 );
    level thread _id_7475();
    var_5 = "horde_wave_start";
    level childthread _id_A798::_id_6DDB( var_5 );

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level._id_2520 > 10 )
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 5 );
}

_id_8511()
{
    if ( level._id_2520 == 1 )
        return 0;

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" && level._id_2520 > 10 )
        return 0;

    if ( isdefined( level._id_49B5 ) && !level._id_49B5 )
        return 0;

    return 1;
}

_id_49B1()
{
    level endon( "game_ended" );
    level endon( "start_round" );

    while ( level._id_6D38 < level.players.size )
        wait 0.05;

    level notify( "all_players_ready" );
    setomnvar( "ui_horde_show_roundstats", 0 );
    _id_1EEF();
}

_id_49BD()
{
    level endon( "game_ended" );
    level endon( "all_players_ready" );

    if ( _id_8511() )
    {
        _id_7F86( "start_time", _id_40B8() );

        foreach ( var_1 in level.players )
            var_1 setclientomnvar( "ui_horde_show_readyup", 1 );
    }

    if ( level._id_2520 == 1 )
        thread _id_A793::_id_49A7( "coop_gdn_intro", "horde", 1, 2 );

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( _id_40B8() - 6 );

    if ( !level._id_A3D0 )
    {
        level notify( "wave_final_countdown" );

        foreach ( var_1 in level.players )
            var_1 setclientomnvar( "ui_horde_show_readyup", 0 );

        _id_49A3();
        thread _id_49A2();
    }

    level notify( "round_begin" );
}

_id_49A3( var_0 )
{
    _id_1EEF();

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

_id_49A2()
{
    setomnvar( "ui_match_countdown_title", 5 );
    setomnvar( "ui_match_countdown", 0 );
    setomnvar( "ui_match_countdown_toggle", 0 );
    wait 2;
    setomnvar( "ui_match_countdown_title", 0 );
}

_id_40B8()
{
    if ( !_id_8511() )
        return 10;

    return 45;
}

_id_49B0( var_0, var_1 )
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
                        level._id_6D38++;

                        if ( level._id_6D38 < level.players.size )
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

_id_76C8()
{
    level endon( "game_ended" );
    level endon( "zombies_start" );
    _id_A0F5();

    if ( !isdefined( level._id_4986 ) || !level._id_4986.size )
        return;

    level childthread _id_5ECD();

    for (;;)
    {
        level waittill( "airSupport" );
        thread _id_A793::_id_49A7( "coop_gdn_supportdropincoming", "horde", 1, 1 );
        level childthread _id_2B61();

        for ( var_0 = 0; var_0 < level._id_49D9.size; var_0++ )
        {
            level._id_4986[level._id_4986.size] = level._id_49D9[0];
            level._id_49D9 = common_scripts\utility::array_remove( level._id_49D9, level._id_49D9[0] );
        }

        foreach ( var_2 in level.players )
        {
            if ( !maps\mp\_utility::isreallyalive( var_2 ) )
                continue;

            var_3 = var_2 thread maps\mp\killstreaks\_orbital_carepackage::_id_6CD7( "horde_support_drop", var_2.killstreakmodules );
        }

        level._id_49BE["support_drops_earned"]++;
    }
}

_id_888E()
{
    var_0 = ( 0.0, 0.0, 0.0 );
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( !_id_A798::_id_5164( var_3 ) || !isalive( var_3 ) )
            continue;

        var_1++;
        var_0 += ( var_3.origin[0], var_3.origin[1], var_3.origin[2] );
    }

    var_5 = var_0 / var_1;
    level._id_4986 = sortbydistance( level._id_4986, var_5 );
}

_id_5ECD()
{
    level._id_8FDA = _id_40FD();

    for (;;)
    {
        level common_scripts\utility::waittill_any( "pointsEarned", "host_migration_end" );

        if ( level._id_251F >= level._id_8FDA )
        {
            level notify( "airSupport" );

            foreach ( var_1 in level.players )
                _id_A791::_id_07CA( var_1, "support_bar_filled" );

            level._id_251F -= level._id_8FDA;
            level._id_8FDA = _id_40FD();
            setomnvar( "ui_horde_support_drop_progress", 100 );
            wait 2.72;
        }

        setomnvar( "ui_horde_support_drop_progress", int( level._id_251F / level._id_8FDA * 100 ) );
    }
}

_id_40FD()
{
    var_0 = _id_401B( level._id_2520 );
    var_1 = int( level._id_2520 / 4 );
    var_2 = 45 + var_1 * 15;
    var_3 = 1500;

    if ( _id_A798::_id_4056() == 2 )
        var_3 = 2100;
    else if ( _id_A798::_id_4056() == 3 )
        var_3 = 3300;
    else if ( _id_A798::_id_4056() == 4 )
        var_3 = 4100;

    var_3 += 800 * level._id_4976;
    return var_3 + var_0 * var_2;
}

_id_070D( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 waittill( "spawned_player" );
    wait 0.05;

    if ( level._id_2520 == 0 )
        var_1 = _id_4996( getdvarint( "scr_horde_startinground" ) );
    else
        var_1 = level._id_2520;

    setomnvar( "ui_horde_round_number", var_1 );
    thread _id_A219();
}

_id_A219()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "host_migration_end" );
        var_0 = int( max( level._id_2520, 1 ) );
        setomnvar( "ui_horde_round_number", var_0 );

        foreach ( var_2 in level.players )
        {
            if ( isai( var_2 ) )
                continue;

            if ( !isdefined( var_2 ) )
                continue;

            if ( !isdefined( var_2._id_4948 ) )
                continue;

            if ( !var_2._id_4948.size )
                continue;

            var_3 = var_2._id_4948.size;

            for ( var_4 = 0; var_4 < var_3; var_4++ )
            {
                if ( !isdefined( var_2 ) )
                    continue;

                if ( !isagent( var_2 ) )
                    var_2 setclientomnvar( "ui_horde_update_perk", var_2._id_4948[var_4]["index"] );

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

_id_4167( var_0 )
{
    var_1 = var_0 getstance();

    if ( var_1 == "stand" )
        return 48;

    if ( var_1 == "crouch" )
        return 32;

    return 12;
}

_id_2B61()
{
    wait 0.05;

    foreach ( var_1 in level.players )
    {
        if ( !_id_A798::_id_5164( var_1 ) )
            continue;

        if ( var_1.sessionstate == "spectator" )
            continue;

        var_1 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_support_drop" );
    }
}

initspawns()
{
    level.spawnmins = ( 0.0, 0.0, 0.0 );
    level.spawnmaxs = ( 0.0, 0.0, 0.0 );
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

    if ( !_id_A798::_id_5164( self ) && self.agent_type == "player" )
        self.hordeloadout = _id_4993();

    if ( _id_A798::_id_5164( self ) )
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
            if ( maps\mp\_utility::getmapname() == "mp_recovery" && ( _func_220( var_2.origin, ( -631.0, -313.2, 38.0 ) ) < 4096 || _func_220( var_2.origin, ( -1276.0, -129.0, 148.0 ) ) < 4096 ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );

            if ( maps\mp\_utility::getmapname() == "mp_refraction" && _func_220( var_2.origin, ( -2356.0, -1208.0, 2304.0 ) ) < 4096 )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );

            if ( maps\mp\_utility::getmapname() == "mp_comeback" && ( _func_220( var_2.origin, ( 814.0, -945.0, 239.0 ) ) < 4096 || _func_220( var_2.origin, ( 474.0, 788.0, 184.0 ) ) < 4096 ) )
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
            if ( maps\mp\_utility::getmapname() == "mp_lab2" && _func_220( var_2.origin, ( -529.0, 1378.0, 499.0 ) ) < 4096 )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }
    }

    return var_0;
}

_id_3EDB()
{
    var_0 = 0.25;
    var_1 = _id_A798::_id_4056();

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

_id_4087()
{
    var_0 = _id_A798::_id_4056();
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

    var_1 += 0.15 * level._id_4976;
    var_1 += 0.3 * ( level._id_49A8 - 1 );
    return var_1;
}

_id_5D4F( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( ( !isdefined( var_2 ) || var_2.classname == "worldspawn" ) && var_0.team == level._id_32C5 && isdefined( var_5 ) && ( var_5 == "killstreak_strike_missile_gas_mp" || var_5 == "warbird_missile_mp" ) )
        return 0;

    if ( isdefined( var_2 ) && isdefined( var_2.team ) && var_2.team == var_0.team )
    {
        if ( var_5 == "destructible_toy" || var_5 == "mp_lab_gas_explosion" )
        {
            var_3 = 60;
            var_3 = int( min( var_3 + var_3 * _id_4087(), 0.7 * var_0.maxhealth ) );

            if ( isdefined( var_0._id_4948 ) )
            {
                foreach ( var_10 in var_0._id_4948 )
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

        if ( var_0.team == level._id_32C5 && var_2.team == level._id_6D6C )
        {
            if ( maps\mp\_utility::ismeleemod( var_4 ) )
                var_3 = var_0.maxhealth + 1;

            var_13 = weaponclass( var_5 );

            if ( isdefined( var_0._id_4949 ) && ( var_0._id_4949 == "jugg" || var_0._id_4949 == "jugg_handler" ) )
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
                var_3 = int( var_3 * var_2._id_A2CE );

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
                var_3 = int( var_3 + 0 * level._id_2520 );

            if ( maps\mp\gametypes\_class::isvalidequipment( var_5, 0 ) )
            {
                if ( isexplosivedamagemod( var_4 ) )
                    var_3 = int( var_0.maxhealth ) + 1;

                if ( var_5 == "throwingknife_mp" )
                    var_3 = var_0.maxhealth + 1;
            }

            var_3 = int( var_3 * var_2._id_1E34 );

            if ( var_8 == "head" && var_3 >= var_0.health )
                var_2._id_7653++;

            var_2 _id_41FA( var_0, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
        }
    }

    if ( isdefined( var_2 ) && isdefined( var_2.owner ) && isplayer( var_2.owner ) )
    {
        var_15 = 0;

        if ( maps\mp\_utility::iskillstreakweapon( var_5 ) )
            var_3 = int( var_3 + 0 * level._id_2520 );

        if ( isagent( var_2 ) )
        {
            var_3 = int( var_3 + var_3 * 0.1 * ( level._id_2520 - 2 ) );
            var_15 = 1;
        }

        if ( !isdefined( var_2.chopper ) && !isdefined( var_2._id_511C ) )
            var_2.owner _id_41FA( var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_15 );
    }

    if ( isplayer( var_0 ) || _id_A798::_id_5164( var_0 ) )
    {
        if ( _id_A798::_id_5175( var_0 ) && !var_0 maps\mp\_utility::touchingbadtrigger() )
            return 0;

        if ( var_5 == "semtexproj_mp" )
            var_3 *= 3;

        if ( isplayer( var_0 ) )
        {
            if ( issubstr( var_5, "_em1" ) )
                var_3 = int( var_3 * 0.33 + 1 );

            if ( issubstr( var_5, "microdronelauncher" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.4 ) );
            else if ( issubstr( var_5, "exominigun" ) )
                var_3 = int( var_3 * 0.4 );
            else if ( issubstr( var_5, "mp11" ) || issubstr( var_5, "bal27" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.08 ) );
            else if ( issubstr( var_5, "maul" ) )
                var_3 = int( var_3 * ( _id_4087() - 0.02 ) );
            else if ( issubstr( var_5, "himar" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.16 ) );
            else if ( issubstr( var_5, "iw5_em1_mp" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.05 ) );
            else if ( issubstr( var_5, "iw5_em1loot8_mp" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.12 ) );
            else if ( issubstr( var_5, "iw5_em1loot4_mp" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.08 ) );
            else if ( issubstr( var_5, "iw5_em1loot1_mp" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.16 ) );
            else if ( issubstr( var_5, "epm3" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.35 ) );
            else if ( issubstr( var_5, "remote_turret" ) )
                var_3 = int( var_3 * ( _id_4087() + 0.06 ) );
            else if ( issubstr( var_5, "warbird_missile_mp" ) )
            {
                var_3 *= 2;

                if ( var_3 > 400 )
                    var_3 = 400;

                var_3 = int( var_3 * _id_4087() );

                if ( isdefined( var_0._id_4948 ) )
                {
                    foreach ( var_10 in var_0._id_4948 )
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
                var_3 = int( var_3 * ( _id_4087() + 0.1 ) );
            else if ( var_5 == "frag_grenade_mp" )
                var_3 = int( var_3 * ( _id_4087() + 0.3 ) );
            else if ( var_5 == "iw5_juggernautrockets_mp" )
                var_3 = 20 + 30 * ( level._id_49A8 - 1 );
            else if ( isdefined( var_2 ) && isdefined( var_2.type ) && issubstr( var_2.type, "tracking_drone" ) )
                var_3 = int( min( var_3 * ( _id_4087() + 0.35 ), var_0.maxhealth * 0.8 ) );
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

                if ( _id_A798::_id_5175( var_0 ) )
                {
                    if ( isdefined( var_0._id_51B2 ) && var_0._id_51B2 )
                        return 0;

                    self _meth_83FB();
                    self disableweapons();
                    self.movespeedscaler = 0.05;

                    if ( level.players.size > 1 )
                        thread _id_A795::_id_8D38( 0, 0, 0 );
                    else
                        return 10000;

                    return 0;
                }

                return 10000;
            }
            else
                var_3 = int( var_3 * _id_4087() );

            if ( var_0.classselection )
                return 0;
        }
        else
            var_3 = int( var_3 * _id_3EDB() );

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
            var_3 *= var_0._id_32CC;

        if ( isdefined( var_0._id_518D ) && var_0._id_518D )
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

_id_41FA( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
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
            _id_A798::awardhordemeleekills( self );
        }
        else if ( var_8 )
        {
            var_11 = "kill_head";
            _id_A798::awardhordeheadshotkills( self );
        }
        else
            var_11 = "kill_normal";
    }
    else if ( var_8 && ( isdefined( var_3 ) && !maps\mp\_utility::iskillstreakweapon( var_3 ) ) )
        var_11 = "damage_head";
    else
        var_11 = "damage_body";

    _id_41FB( var_11, var_3, var_7 );
}

_id_41FB( var_0, var_1, var_2 )
{
    if ( isdefined( level.empowner ) )
        return;

    if ( level._id_49A5 )
        return;

    var_3 = level._id_6E22[var_0];

    if ( issubstr( var_1, "em1" ) || issubstr( var_1, "turret" ) )
        var_3 = 4;

    self._id_6E25[self._id_6E25.size] = var_3;
    level thread maps\mp\gametypes\_rank::awardgameevent( var_0, self );
    level._id_251F += var_3;
    level notify( "pointsEarned" );

    if ( var_2 )
        return;
}

_id_5EAA( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( var_0._id_6E25.size > 0 )
        {
            if ( !isagent( var_0 ) )
                var_0 setclientomnvar( "ui_horde_award_points", var_0._id_6E25[var_0._id_6E25.size - 1] );

            var_0._id_6E25 = _id_73B5( var_0._id_6E25 );
        }

        wait 0.05;
    }
}

_id_5E2B( var_0 )
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

_id_73B5( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size - 1; var_2++ )
        var_1[var_2] = var_0[var_2];

    return var_1;
}

onnormaldeath( var_0, var_1, var_2 )
{
    _id_73CB( var_0 );

    if ( isplayer( var_0 ) && _id_A798::_id_5175( var_0 ) )
    {
        _id_A798::_id_49D8( self, 0 );

        if ( _id_A795::_id_3BFB( var_0 ) )
            _id_A795::_id_498A();
        else
            var_0 _id_A795::_id_8D38( 0, 0, 0 );
    }

    if ( !isdefined( var_1 ) )
        return;

    if ( game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]] )
        var_1.finalkill = 1;
}

_id_73CB( var_0 )
{
    if ( isplayer( var_0 ) && !isagent( var_0 ) )
    {
        var_0 setclientomnvar( "ui_horde_update_perk", 0 );
        var_0._id_4948 = [];
    }
}

_id_1C67( var_0 )
{
    level endon( "game_ended" );

    if ( var_0.agent_type == "dog" || var_0._id_4949 == "zombie" )
        return;

    if ( level._id_630B && level._id_537C > 2 )
    {
        thread _id_89E2( var_0.origin + ( 0.0, 0.0, 22.0 ) );
        level._id_537C = 0;
        return;
    }

    if ( level._id_49A8 == 1 )
    {
        var_1 = 8;
        var_2 = 11;
    }
    else
    {
        var_1 = 11;
        var_2 = 15;
    }

    if ( level._id_251E >= level._id_5A48 )
        return;

    if ( level._id_537B < randomintrange( var_1, var_2 ) )
        return;

    if ( level._id_250A < level._id_5A21 )
    {
        var_3 = level._id_0B7D;
        var_4 = level._id_0B7C;
        level._id_250A++;
        level._id_537B = 0;
        _id_89F4( var_0.origin + ( 0.0, 0.0, 22.0 ), var_3, var_4, undefined, 1 );
    }
}

_id_89E2( var_0 )
{
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "greece_drone_control_pad" );
    var_1.angles = ( 0.0, 0.0, 0.0 ) + ( randomint( 360 ), randomint( 360 ), randomint( 360 ) );
    var_1 physicslaunchserver( var_1.origin, ( 0.0, 0.0, -1.0 ) );
    var_1 makeusable();
    var_1 sethintstring( &"HORDE_PICKUP_INTEL" );
    var_1 _meth_83FA( 4, 0 );
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add( var_2, "active", var_1.origin, "objective_sm" );
    var_1._id_62FB = var_2;
    level._id_202A[level._id_202A.size] = var_1;
    var_1 waittill( "trigger", var_3 );
    var_3 playlocalsound( "mp_killconfirm_tags_pickup" );
    level._id_4966++;
    setomnvar( "ui_horde_objcount_1", level._id_4966 );
    var_3 setclientomnvar( "ui_horde_count", 1 );
    var_3 thread maps\mp\gametypes\_rank::xppointspopup( "horde_collect", 500 );
    level thread _id_A798::_id_49D8( var_3, 500 );
    level._id_251F += 500;
    level notify( "pointsEarned" );

    if ( level._id_4966 == level._id_4943 )
    {
        thread _id_A793::_id_49A7( "coop_gdn_allintelaquired", "horde", 1, 1 );
        _id_49B5();
        level notify( "collect_completed" );
        level._id_4966 = 0;
    }

    maps\mp\_utility::_objective_delete( var_2 );
    var_1 delete();
}

_id_89F4( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 15;

    var_5[0] = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_5[0] setmodel( var_1 );

    if ( isdefined( var_4 ) && var_4 )
        var_5[0] _meth_83FA( 1, 0 );

    var_6 = spawn( "trigger_radius", ( 0.0, 0.0, 0.0 ), 0, 32, 32 );
    var_7 = maps\mp\gametypes\_gameobjects::createuseobject( level._id_6D6C, var_6, var_5, ( 0.0, 0.0, 16.0 ), 1 );
    var_8 = var_0;
    var_7.curorigin = var_8;
    var_7.trigger.origin = var_8;
    var_7.visuals[0].origin = var_8;
    var_7 maps\mp\gametypes\_gameobjects::setusetime( 0 );
    var_7 maps\mp\gametypes\_gameobjects::allowuse( "friendly" );
    var_7.onuse = var_2;
    level._id_251E++;
    var_7 thread _id_6810();
    var_7 thread _id_6815( var_3 );
    return var_7;
}

_id_6810()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "death" );
    var_0 = self;
    var_1 = self.curorigin;
    var_2 = self.curorigin + ( 0.0, 0.0, 12.0 );
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

_id_6815( var_0 )
{
    self endon( "deleted" );
    wait(var_0);
    thread _id_6813();
    wait 8;
    level thread _id_73CD( self );
}

_id_6813()
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

_id_73CD( var_0 )
{
    var_0 notify( "deleted" );
    wait 0.05;
    var_0.trigger delete();
    var_0.visuals[0] delete();
}

_id_0B7A( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( _id_A798::_id_5164( var_2 ) && maps\mp\_utility::isreallyalive( var_2 ) )
        {
            var_2 thread maps\mp\gametypes\_hud_message::splashnotify( "horde_team_restock" );
            _id_A798::_id_72AC( var_2 );
            var_2.health = var_2.maxhealth;
        }
    }

    var_0 playlocalsound( "scavenger_pack_pickup" );
    level thread _id_73CD( self );
}

_id_202B( var_0 )
{
    var_0._id_2029++;
    var_0 playlocalsound( "mp_killconfirm_tags_pickup" );
    level._id_4966++;
    setomnvar( "ui_horde_objcount_1", level._id_4966 );
    var_0 setclientomnvar( "ui_horde_count", 1 );
    var_0 thread maps\mp\gametypes\_rank::xppointspopup( "horde_collect", 200 );
    level thread _id_A798::_id_49D8( var_0, 200 );
    level._id_251F += 200;
    level notify( "pointsEarned" );
    maps\mp\_utility::_objective_delete( self._id_62FB );
    level._id_202A = common_scripts\utility::array_remove( level._id_202A, self );

    if ( level._id_4966 == level._id_4943 )
    {
        thread _id_A793::_id_49A7( "coop_gdn_allgodtagssecured", "horde", 1, 1 );
        _id_49B5();
        level notify( "collect_completed" );
        level._id_4966 = 0;
    }

    level thread _id_73CD( self );
}

_id_2F99( var_0, var_1 )
{
    waittillframeend;
}

ondeadevent( var_0 )
{
    if ( var_0 != level._id_32C5 )
    {
        iprintln( &"MP_GHOSTS_ELIMINATED" );
        logstring( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
        level.finalkillcam_winner = "axis";
        level thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["allies_eliminated"] );
    }
}

setspecialloadouts()
{
    level._id_49A9["allies"]["loadoutPrimary"] = "iw5_kf5";
    level._id_49A9["allies"]["loadoutPrimaryAttachment"] = "none";
    level._id_49A9["allies"]["loadoutPrimaryAttachment2"] = "none";
    level._id_49A9["allies"]["loadoutPrimaryAttachment3"] = "none";
    level._id_49A9["allies"]["loadoutPrimaryBuff"] = "specialty_null";
    level._id_49A9["allies"]["loadoutPrimaryCamo"] = "none";
    level._id_49A9["allies"]["loadoutPrimaryReticle"] = "none";
    level._id_49A9["allies"]["loadoutSecondary"] = "none";
    level._id_49A9["allies"]["loadoutSecondaryAttachment"] = "none";
    level._id_49A9["allies"]["loadoutSecondaryAttachment2"] = "none";
    level._id_49A9["allies"]["loadoutSecondaryAttachment3"] = "none";
    level._id_49A9["allies"]["loadoutSecondaryBuff"] = "specialty_null";
    level._id_49A9["allies"]["loadoutSecondaryCamo"] = "none";
    level._id_49A9["allies"]["loadoutSecondaryReticle"] = "none";
    level._id_49A9["allies"]["loadoutEquipment"] = "frag_grenade_mp";
    level._id_49A9["allies"]["loadoutOffhand"] = "none";
    level._id_49A9["allies"]["loadoutKillstreaks"][0] = "none";
    level._id_49A9["allies"]["loadoutKillstreaks"][1] = "none";
    level._id_49A9["allies"]["loadoutKillstreaks"][2] = "none";
    level._id_49A9["allies"]["loadoutKillstreaks"][3] = "none";
    level._id_49A9["allies"]["loadoutJuggernaut"] = 0;
    level._id_49A9["allies"]["loadoutPerks"] = [ "specialty_falldamage", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    level._id_49A9["allies"]["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];
    level._id_49A9["squadmate"]["loadoutPrimary"] = "iw5_ak12";
    level._id_49A9["squadmate"]["loadoutPrimaryAttachment"] = "none";
    level._id_49A9["squadmate"]["loadoutPrimaryAttachment2"] = "none";
    level._id_49A9["squadmate"]["loadoutPrimaryAttachment3"] = "none";
    level._id_49A9["squadmate"]["loadoutPrimaryBuff"] = "specialty_null";
    level._id_49A9["squadmate"]["loadoutPrimaryCamo"] = "none";
    level._id_49A9["squadmate"]["loadoutPrimaryReticle"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondary"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondaryAttachment"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondaryAttachment2"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondaryAttachment3"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondaryBuff"] = "specialty_null";
    level._id_49A9["squadmate"]["loadoutSecondaryCamo"] = "none";
    level._id_49A9["squadmate"]["loadoutSecondaryReticle"] = "none";
    level._id_49A9["squadmate"]["loadoutEquipment"] = "frag_grenade_mp";
    level._id_49A9["squadmate"]["loadoutOffhand"] = "none";
    level._id_49A9["squadmate"]["loadoutKillstreaks"][0] = "none";
    level._id_49A9["squadmate"]["loadoutKillstreaks"][1] = "none";
    level._id_49A9["squadmate"]["loadoutKillstreaks"][2] = "none";
    level._id_49A9["squadmate"]["loadoutKillstreaks"][3] = "none";
    level._id_49A9["squadmate"]["loadoutJuggernaut"] = 0;
    level._id_49A9["squadmate"]["loadoutPerks"] = [ "specialty_falldamage", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    level._id_49A9["squadmate"]["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];
}

_id_4993()
{
    var_0 = getwavetable();
    var_1 = tablelookup( var_0, 1, level._id_2520 + level._id_49DE, 4 );

    if ( level._id_8A21.size > 0 )
    {
        for ( var_2 = 0; var_2 < level._id_8A20.size; var_2++ )
        {
            if ( level._id_A2A3 && level._id_8A20[level._id_8A21[var_2]]["count"] < level._id_8A20[level._id_8A21[var_2]]["maxCount"] )
            {
                level._id_8A20[level._id_8A21[var_2]]["count"]++;
                var_1 = level._id_8A21[var_2];
                break;
            }
            else if ( !level._id_A2A3 && !( level._id_8A21[var_2] == "jugg" || level._id_8A21[var_2] == "jugg_handler" ) )
            {
                if ( _id_A798::_id_2007( hordegetchancetorespawn( level._id_8A21[var_2] ) ) )
                    var_1 = level._id_8A21[var_2];
            }
        }
    }

    if ( level._id_49A8 > 1 )
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
    var_1 = int( var_0["startinghealth"] + var_0["startinghealth"] * ( level._id_49A8 - 1 ) * 0.5 );

    if ( _id_A798::_id_4056() == 3 )
        var_1 = int( var_1 * 1.2 );
    else if ( _id_A798::_id_4056() == 4 )
        var_1 = int( var_1 * 1.4 );

    return var_1;
}

_id_49AA()
{
    level._id_49DF = [];
    var_0 = tablelookup( getwavetable(), 1, level._id_2520 + 1 + level._id_49DE, 4 );
    level._id_49DF[level._id_49DF.size] = tablelookup( getwavetable(), 1, var_0, 4 ) + "_mp";
    level._id_49DF[level._id_49DF.size] = tablelookup( getwavetable(), 1, var_0, 10 ) + "_mp";
    var_1 = strtok( tablelookup( getwavetable(), 1, level._id_2520 + 1 + level._id_49DE, 5 ), " " );

    foreach ( var_0 in var_1 )
        level._id_49DF[level._id_49DF.size] = tablelookup( getwavetable(), 1, var_0, 4 ) + "_mp";

    foreach ( var_5 in level.players )
    {
        var_5 loadweapons( level._id_49DF );
        var_5 loadweapons( [ "iw5_microdronelauncher_mp" ] );
    }
}

monitorplayercamping( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "start_extraction" );
    level endon( "game_ended" );

    while ( !isdefined( level._id_2520 ) || level._id_2520 < 5 )
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

            if ( !isdefined( level._id_2509 ) || level._id_2509 < 1 || _id_A798::_id_5175( var_0 ) || isdefined( var_0._id_51B2 ) && var_0._id_51B2 || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0._id_518D ) && var_0._id_518D )
            {
                while ( !isdefined( level._id_2509 ) || level._id_2509 < 1 || _id_A798::_id_5175( var_0 ) || isdefined( var_0._id_51B2 ) && var_0._id_51B2 || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0._id_518D ) && var_0._id_518D )
                    wait 0.5;

                var_1 = var_0.origin;
                var_2 = gettime();
            }
        }

        var_5 = spawncamperdrone();

        if ( !isdefined( var_5 ) )
            continue;

        var_5 _meth_848F( 0 );
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

    var_1 = var_0 maps\mp\_tracking_drone::_id_2448();
    var_0 thread maps\mp\_tracking_drone::_id_8D3E( var_1 );
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
    self _meth_83F9( var_0, ( 0.0, 0.0, 72.0 ) );
    thread _id_4674( var_0 );
    thread hordespawnnanoswarm();
    thread camperdronecancel( var_0, var_0.origin );
    common_scripts\utility::waittill_any_timeout( 20, "detonate" );
    self stoploopsound();
    self playsound( "drone_warning_beap" );
    wait 1.4;
    self notify( "startSwarm" );
    waitframe();
    self entityradiusdamage( self.origin, 256, 100, 25, self, "MOD_EXPLOSIVE" );
    thread maps\mp\_tracking_drone::_id_94E7();
}

camperdronecancel( var_0, var_1 )
{
    self endon( "startSwarm" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( !isdefined( level._id_2509 ) || level._id_2509 < 1 || _id_A798::_id_5175( var_0 ) || isdefined( var_0._id_51B2 ) && var_0._id_51B2 || isdefined( var_0.usingarmory ) || var_0 maps\mp\_utility::isusingremote() || isdefined( var_0._id_518D ) && var_0._id_518D )
        {
            self notify( "cancel_swarm" );
            waitframe();
            thread maps\mp\_tracking_drone::_id_94E7();
        }

        wait 0.25;
    }
}

hordeexploitclip()
{
    if ( maps\mp\_utility::getmapname() == "mp_instinct" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 236.851, -1405.0, 1016.0 ), ( 0.0, 22.7, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 79.0, -1339.9, 1016.0 ), ( 0.0, 292.7, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 730.1, 792.5, 1080.0 ), ( 0.0, 241.8, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 681.5, 955.9, 1080.0 ), ( 0.0, 151.8, 0.0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_laser2" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 526.0, 2476.0, 467.0 ), ( 90.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( 526.0, 2361.0, 436.0 ), ( 60.0, 90.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 159.5, 2473.1, 513.5 ), ( 70.0, 90.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -102.5, 2473.1, 513.5 ), ( 70.0, 90.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2336.58, 1331.1, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2162.7, 1279.51, 936.0 ), ( 0.0, 204.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2232.93, 1233.68, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2059.05, 1182.1, 936.0 ), ( 0.0, 204.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2135.11, 1182.07, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2047.53, 993.406, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2071.25, 885.376, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -2063.75, 743.332, 936.0 ), ( 0.0, 114.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1990.92, 909.438, 936.0 ), ( 0.0, 204.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1998.42, 1051.48, 936.0 ), ( 0.0, 204.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1962.26, 1094.72, 872.0 ), ( 0.0, 24.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -2002.68, 1181.8, 872.0 ), ( 0.0, 24.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -2002.68, 1181.8, 1000.0 ), ( 0.0, 24.9, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( -1962.26, 1094.72, 1000.0 ), ( 0.0, 24.9, 0.0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_detroit" )
        maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 147.0, 2272.0, 673.0 ), ( 0.0, 20.0, 0.0 ) );

    if ( maps\mp\_utility::getmapname() == "mp_recovery" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1200.0, -1984.0, 32.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1456.0, -1984.0, 32.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712.0, -1984.0, 32.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1200.0, -1984.0, 288.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1456.0, -1984.0, 288.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1712.0, -1984.0, 288.0 ), ( 0.0, 270.0, 0.0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_venus" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2248.0, 384.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2504.0, 384.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2760.0, 384.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2248.0, 640.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2504.0, 640.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2760.0, 640.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2248.0, 896.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2504.0, 896.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 496.0, -2760.0, 896.0 ), ( 0.0, 0.0, 0.0 ) );
    }

    if ( maps\mp\_utility::getmapname() == "mp_prison_z" )
    {
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1516.0, 2164.0, 1016.0 ), ( 0.0, 270.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1636.0, 2028.0, 1016.0 ), ( 0.0, 0.0, 0.0 ) );
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -1636.0, 1772.0, 1016.0 ), ( 0.0, 0.0, 0.0 ) );
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
