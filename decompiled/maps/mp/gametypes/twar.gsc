// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

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
        maps\mp\_utility::registertimelimitdvar( level.gametype, 10 );
        maps\mp\_utility::registerscorelimitdvar( level.gametype, 75 );
        maps\mp\_utility::registerroundlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registerwinlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registernumlivesdvar( level.gametype, 0 );
        maps\mp\_utility::registerhalftimedvar( level.gametype, 0 );
        level.matchrules_damagemultiplier = 0;
        level.matchrules_vampirism = 0;
    }

    maps\mp\_utility::setovertimelimitdvar( 3 );
    level.teambased = 1;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.onnormaldeath = ::onnormaldeath;
    level.onspawnplayer = ::onspawnplayer;
    level.ontimelimit = ::ontimelimit;
    level.onplayerkilled = ::onplayerkilled;
    level.allowboostingabovetriggerradius = 1;
    level.ai_game_mode = 1;
    level.modifyplayerdamage = ::minion_damage;
    level.on_agent_player_killed = ::on_minion_killed;
    level.spawn_version = 3;
    level.flagfxid = loadfx( "vfx/unique/vfx_flag_project_neutral" );
    level.boarderfxid = loadfx( "vfx/unique/vfx_marker_dom_white" );

    if ( level.matchrules_damagemultiplier || level.matchrules_vampirism )
        level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "mom_intro";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "camera_thirdPerson" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
    else if ( getdvarint( "scr_diehard" ) )
        game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];

    game["dialog"]["defense_obj"] = "mtm_alert";
    game["dialog"]["offense_obj"] = "mtm_alert";
    game["dialog"]["mtm_taking"] = "mtm_taking";
    game["dialog"]["mtm_etaking"] = "mtm_etaking";
    game["dialog"]["mtm_lastflg"] = "mtm_lastflg";
    game["dialog"]["mtm_elastflg"] = "mtm_elastflg";
    game["dialog"]["mtm_secured"] = "mtm_secured";
    game["dialog"]["mtm_captured"] = "mtm_captured";
    game["dialog"]["mtm_max"] = "mtm_max";
    game["dialog"]["mtm_gain"] = "mtm_gain";
    game["dialog"]["mtm_reset"] = "mtm_reset";
    game["dialog"]["mtm_clrd"] = "mtm_clrd";
    game["dialog"]["mtm_lost"] = "mtm_lost";

    if ( maps\mp\_utility::isgrapplinghookgamemode() )
        game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];

    if ( !isdefined( game["shut_out"] ) )
    {
        game["shut_out"]["axis"] = 1;
        game["shut_out"]["allies"] = 1;
        game["max_meter"]["axis"] = 0;
        game["max_meter"]["allies"] = 0;
    }

    setdvar( "r_hudOutlineWidth", 1 );
}

initializematchrules()
{
    maps\mp\_utility::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_twar_roundswitch", 0 );
    maps\mp\_utility::registerroundswitchdvar( "twar", 0, 0, 9 );
    setdynamicdvar( "scr_twar_roundlimit", 1 );
    maps\mp\_utility::registerroundlimitdvar( "twar", 1 );
    setdynamicdvar( "scr_twar_winlimit", 1 );
    maps\mp\_utility::registerwinlimitdvar( "twar", 1 );
    setdynamicdvar( "scr_twar_halftime", 0 );
    maps\mp\_utility::registerhalftimedvar( "twar", 0 );
    setdynamicdvar( "scr_twar_halftime", 0 );
    setdynamicdvar( "scr_twar_minionsmax", getmatchrulesdata( "twarData", "numMinions" ) );
    setdynamicdvar( "scr_twar_capture_time", getmatchrulesdata( "twarData", "captureTime" ) );
    setdynamicdvar( "scr_twar_zone_count", getmatchrulesdata( "twarData", "numFlags" ) );
    setdynamicdvar( "scr_twar_ot_zone_count", getmatchrulesdata( "twarData", "numOTFlags" ) );
    setdynamicdvar( "scr_twar_min_capture_players", 1 );
    setdynamicdvar( "scr_twar_hud_momentum_bar", !getmatchrulesdata( "twarData", "hideMomentumBar" ) );
}

onstartgametype()
{
    getteamplayersalive( "auto_change" );

    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    maps\mp\_utility::setobjectivetext( "allies", &"OBJECTIVES_TWAR" );
    maps\mp\_utility::setobjectivetext( "axis", &"OBJECTIVES_TWAR" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_TWAR" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_TWAR" );
    }
    else
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_TWAR_SCORE" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_TWAR_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_TWAR_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_TWAR_HINT" );
    game["dialog"]["lockouts"]["mtm_taking"] = 5;
    game["dialog"]["lockouts"]["mtm_etaking"] = 5;
    initspawns();
    var_2[0] = level.gametype;
    maps\mp\gametypes\_gameobjects::main( var_2 );
    level.zone_radius = getdvarint( "scr_twar_zone_radius", 150 );

    if ( !isdefined( level.zone_height ) )
        level.zone_height = 60;

    level.momentum_multiplier_max = 3;
    find_zones();
    assign_spawns();
    create_active_zone();
    init_momentum( "allies" );
    init_momentum( "axis" );
    thread watch_for_joined_team();
    thread updateminions();
    thread update_lua_hud();
}

watch_for_joined_team()
{
    for (;;)
    {
        level waittill( "joined_team" );
        level notify( "update_flag_outline" );
        update_minion_hud_outlines();
    }
}

ontimelimit()
{
    level.finalkillcam_winner = "none";

    if ( game["status"] == "overtime" )
        var_0 = "tie";
    else if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
    {
        var_0 = "overtime";
        game["owned_flags"] = [];
        game["owned_flags"]["allies"] = 0;
        game["owned_flags"]["axis"] = 0;

        foreach ( var_2 in level.twar_zones )
        {
            if ( var_2.owner == "allies" )
            {
                game["owned_flags"]["allies"]++;
                continue;
            }

            if ( var_2.owner == "axis" )
                game["owned_flags"]["axis"]++;
        }
    }
    else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
    {
        level.finalkillcam_winner = "axis";
        var_0 = "axis";
    }
    else
    {
        level.finalkillcam_winner = "allies";
        var_0 = "allies";
    }

    if ( maps\mp\_utility::practiceroundgame() )
        var_0 = "none";

    thread maps\mp\gametypes\_gamelogic::endgame( var_0, game["end_reason"]["time_limit_reached"] );
}

spawn_flag_projector( var_0 )
{
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "flag_holo_base_ground" );
    return var_1;
}

create_active_zone()
{
    var_0[0] = spawn_flag_projector( ( 0.0, 0.0, 0.0 ) );
    var_1 = spawn( "trigger_radius", ( 0.0, 0.0, 0.0 ), 0, level.zone_radius, level.zone_height );
    var_1.radius = level.zone_radius;
    var_2 = getdvarfloat( "scr_twar_capture_time", 20.0 );
    var_3 = maps\mp\gametypes\_gameobjects::createuseobject( "neutral", var_1, var_0 );
    var_3 maps\mp\gametypes\_gameobjects::allowuse( "any" );
    var_3 maps\mp\gametypes\_gameobjects::setusetime( var_2 );
    var_3 maps\mp\gametypes\_gameobjects::setvisibleteam( "any" );
    var_3.keepprogress = 1;
    var_3.nousebar = 1;
    var_3.id = "twarZone";
    var_3.onbeginuse = ::onbeginuse;
    var_3.onuse = ::onuse;
    var_3.onenduse = ::onenduse;
    var_3.onupdateuserate = ::onupdateuserate;
    level.twar_use_obj = var_3;
    reset_zone_owners();
}

zone_set_waiting()
{
    maps\mp\gametypes\_gameobjects::setownerteam( "neutral" );
    maps\mp\gametypes\_gameobjects::allowuse( "none" );
    var_0 = "waypoint_waitfor_flag_neutral";
    maps\mp\gametypes\_gameobjects::set2dicon( "friendly", var_0 );
    maps\mp\gametypes\_gameobjects::set3dicon( "friendly", var_0 );
    maps\mp\gametypes\_gameobjects::set2dicon( "enemy", var_0 );
    maps\mp\gametypes\_gameobjects::set3dicon( "enemy", var_0 );
    maps\mp\_utility::setmlgicons( self, var_0 );
    self.waiting = 1;
    setomnvar( "ui_twar_capture_team", 3 );
}

update_icons( var_0, var_1 )
{
    if ( isdefined( self.waiting ) )
        return;

    if ( var_0 > 0 && var_1 > 0 )
    {
        var_2 = "waypoint_contested";
        maps\mp\gametypes\_gameobjects::set2dicon( "friendly", var_2 );
        maps\mp\gametypes\_gameobjects::set3dicon( "friendly", var_2 );
        maps\mp\gametypes\_gameobjects::set2dicon( "enemy", var_2 );
        maps\mp\gametypes\_gameobjects::set3dicon( "enemy", var_2 );
        maps\mp\_utility::setmlgicons( self, var_2 );
    }
    else if ( var_0 == 0 && var_1 == 0 )
    {
        var_2 = "waypoint_captureneutral";
        maps\mp\gametypes\_gameobjects::set2dicon( "friendly", var_2 );
        maps\mp\gametypes\_gameobjects::set3dicon( "friendly", var_2 );
        maps\mp\gametypes\_gameobjects::set2dicon( "enemy", var_2 );
        maps\mp\gametypes\_gameobjects::set3dicon( "enemy", var_2 );
        maps\mp\_utility::setmlgicons( self, var_2 );
    }
    else
    {
        maps\mp\gametypes\_gameobjects::set2dicon( "enemy", "waypoint_losing" );
        maps\mp\gametypes\_gameobjects::set3dicon( "enemy", "waypoint_losing" );
        maps\mp\gametypes\_gameobjects::set2dicon( "friendly", "waypoint_taking" );
        maps\mp\gametypes\_gameobjects::set3dicon( "friendly", "waypoint_taking" );

        if ( self.claimteam == "allies" )
            maps\mp\_utility::setmlgicons( self, "waypoint_esports_taking_blue" );
        else
            maps\mp\_utility::setmlgicons( self, "waypoint_esports_taking_red" );
    }
}

zone_set_neutral()
{
    maps\mp\gametypes\_gameobjects::setownerteam( "neutral" );
    maps\mp\gametypes\_gameobjects::allowuse( "any" );
    self.waiting = undefined;
    setomnvar( "ui_twar_capture_team", 0 );
    update_icons( 0, 0 );
}

zone_flag_effect()
{
    zone_flag_effect_stop();
    var_0 = level.twar_use_obj.visuals[0];
    self.flagfx = _func_2C1( level.flagfxid, var_0, "tag_fx_flag" );
    setwinningteam( self.flagfx, 1 );
    triggerfx( self.flagfx );
}

zone_flag_effect_stop()
{
    if ( isdefined( self.flagfx ) )
        self.flagfx delete();
}

zone_boarder_effect()
{
    zone_boarder_effect_stop();
    var_0 = level.twar_use_obj.visuals[0];
    self.boarderfx = spawnfx( level.boarderfxid, var_0.origin, anglestoup( var_0.angles ) );
    setwinningteam( self.boarderfx, 1 );
    triggerfx( self.boarderfx );
}

zone_boarder_effect_stop()
{
    if ( isdefined( self.boarderfx ) )
        self.boarderfx delete();
}

zone_set_team( var_0 )
{
    maps\mp\gametypes\_gameobjects::setownerteam( var_0 );
    maps\mp\gametypes\_gameobjects::allowuse( "any" );
}

update_flag_outline()
{
    for (;;)
    {
        level waittill( "update_flag_outline" );
        var_0 = getdvarint( "scr_twar_flag_outline_color_friendly", -1 );
        var_1 = getdvarint( "scr_twar_flag_outline_color_enemy", -1 );
        var_2 = getdvarint( "scr_twar_flag_outline_color_neutral", -1 );
        var_3 = getdvarint( "scr_twar_flag_outline_depth", 0 );
        self hudoutlinedisableforclients( level.players );
        var_4 = level.twar_use_obj maps\mp\gametypes\_gameobjects::getclaimteam();
        var_5 = [];
        var_6 = [];
        var_7 = [];

        foreach ( var_9 in level.players )
        {
            if ( ( var_4 == "allies" || var_4 == "axis" ) && ( var_9.team == "allies" || var_9.team == "axis" ) )
            {
                if ( var_4 == var_9.team )
                    var_5[var_5.size] = var_9;
                else
                    var_6[var_6.size] = var_9;

                continue;
            }

            var_7[var_7.size] = var_9;
        }

        if ( var_5.size && var_0 >= 0 )
            self hudoutlineenableforclients( var_5, var_0, var_3 );

        if ( var_6.size && var_1 >= 0 )
            self hudoutlineenableforclients( var_6, var_1, var_3 );

        if ( var_7.size && var_2 >= 0 )
            self hudoutlineenableforclients( var_7, var_2, var_3 );
    }
}

reset_zone_owners()
{
    var_0 = int( level.twar_zones.size / 2 );

    foreach ( var_3, var_2 in level.twar_zones )
    {
        if ( var_3 < var_0 )
        {
            var_2.owner = "allies";
            continue;
        }

        if ( var_3 > var_0 )
        {
            var_2.owner = "axis";
            continue;
        }

        var_2.owner = "none";
    }

    set_contested_zone( level.twar_zones[var_0] );
}

onbeginuse( var_0 )
{
    var_1 = var_0.team;
    var_2 = maps\mp\_utility::getotherteam( var_1 );
    zone_set_team( var_1 );
    maps\mp\_utility::leaderdialog( "mtm_taking", var_1 );
    maps\mp\_utility::leaderdialog( "mtm_etaking", var_2 );
    level notify( "update_flag_outline" );
}

onuse( var_0 )
{
    var_1 = var_0.team;
    var_2 = maps\mp\_utility::getotherteam( var_1 );
    var_3 = self.zone;
    var_3.owner = var_1;
    var_4 = var_3.index;

    if ( var_1 == "allies" )
        var_4++;
    else if ( var_1 == "axis" )
        var_4--;

    game["shut_out"][var_2] = 0;

    if ( getdvarint( "scr_twar_momentum_clear_friendly_on_capture", 0 ) )
        clear_momentum( var_1 );
    else
        add_capture_friendly_momentum( var_1 );

    if ( getdvarint( "scr_twar_momentum_clear_enemy_on_capture", 0 ) )
        clear_momentum( var_2 );
    else
        add_capture_enemy_momentum( var_2 );

    var_0 thread maps\mp\_audio::snd_play_team_splash( "mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg" );
    thread givezonecapturexp( self.touchlist[var_1] );

    if ( var_4 < 0 || var_4 >= level.num_zones )
    {
        zone_flag_effect_stop();
        zone_boarder_effect_stop();
        level maps\mp\gametypes\_gamescore::giveteamscoreforobjective( var_1, 1 );
        maps\mp\_utility::leaderdialog( "mtm_secured", var_1 );

        if ( level.gameended )
            maps\mp\gametypes\_gameobjects::disableobject();
        else
            reset_zone_owners();
    }
    else
    {
        set_contested_zone( level.twar_zones[var_4] );

        if ( var_4 == 0 || var_4 == level.num_zones - 1 )
        {
            leaderdialogwait( "mtm_lastflg", var_2 );
            leaderdialogwait( "mtm_elastflg", var_1 );
        }
        else
            leaderdialogwait( "mtm_secured", var_1 );
    }

    self.nextusetime = gettime() + 50;
}

leaderdialogwait( var_0, var_1 )
{
    thread _leaderdialogwait( var_0, var_1 );
}

_leaderdialogwait( var_0, var_1 )
{
    waitframe();
    maps\mp\_utility::leaderdialog( var_0, var_1 );
}

givezonecapturexp( var_0 )
{
    level endon( "game_ended" );
    var_1 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();

    if ( isdefined( var_1.owner ) )
        var_1 = var_1.owner;

    if ( isplayer( var_1 ) )
        level thread maps\mp\_utility::teamplayercardsplash( "callout_securedposition", var_1 );

    var_2 = getarraykeys( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_1 = var_0[var_2[var_3]].player;

        if ( isdefined( var_1.owner ) )
            var_1 = var_1.owner;

        if ( !isplayer( var_1 ) )
            continue;

        var_1 thread maps\mp\_events::domcaptureevent( 0 );
        wait 0.05;
    }
}

onenduse( var_0, var_1, var_2 )
{
    zone_set_neutral();
    level notify( "update_flag_outline" );
}

onupdateuserate()
{
    var_0 = self.userate;
    var_1 = 0;
    var_2 = 0;
    var_3 = maps\mp\_utility::getotherteam( self.claimteam );

    foreach ( var_5 in self.touchlist[var_3] )
    {
        var_6 = var_5.player;

        if ( !isdefined( var_6 ) )
            continue;

        if ( var_6.pers["team"] != var_3 )
            continue;

        var_2++;
    }

    var_8 = getdvarint( "scr_twar_capture_players_max", 3 );

    foreach ( var_5 in self.touchlist[self.claimteam] )
    {
        var_6 = var_5.player;

        if ( !isdefined( var_6 ) )
            continue;

        if ( var_6.pers["team"] != self.claimteam )
            continue;

        var_1++;

        if ( var_1 >= var_8 )
            break;
    }

    self.userate = 0;
    self.stalemate = var_1 && var_2;
    var_11 = getdvarint( "scr_twar_min_capture_players", 1 );

    if ( var_1 && !var_2 && var_1 >= var_11 )
    {
        var_12 = level.twar_team_multiplier[self.claimteam];
        self.userate = var_1 * var_12;
    }

    var_13 = getdvarint( "scr_twar_capture_rate_max", 9.0 );
    self.userate = min( self.userate, var_13 );

    if ( self.keepprogress && self.lastclaimteam != self.claimteam )
        self.userate *= -1;

    update_icons( var_1, var_2 );
}

set_contested_zone( var_0 )
{
    var_0.owner = "none";
    level.twar_use_obj.zone = var_0;
    level.twar_use_obj maps\mp\gametypes\_gameobjects::move_use_object( var_0.origin, ( 0.0, 0.0, 100.0 ) );

    foreach ( var_2 in level.twar_zones )
    {
        if ( var_2 != var_0 )
        {
            var_2.projector show();
            continue;
        }

        var_2.projector hide();
    }

    if ( level.twar_use_obj.keepprogress )
        level.twar_use_obj.lastclaimteam = "none";

    level thread set_contested_zone_wait( 5 );
}

set_contested_zone_wait( var_0 )
{
    waittillframeend;
    level.twar_use_obj zone_flag_effect_stop();
    level.twar_use_obj zone_boarder_effect();
    level.twar_use_obj zone_set_waiting();
    wait(var_0);
    level.twar_use_obj zone_flag_effect();
    level.twar_use_obj zone_set_neutral();
}

update_lua_hud()
{
    for (;;)
    {
        waittillframeend;
        var_0 = 0;

        foreach ( var_2 in level.twar_zones )
        {
            if ( var_2.owner == "allies" )
                var_0++;
        }

        setomnvar( "ui_twar_ally_flag_count", var_0 );
        var_4 = 0;
        var_5 = "";

        if ( level.twar_use_obj.keepprogress )
            var_5 = level.twar_use_obj.lastclaimteam;
        else
            var_5 = level.twar_use_obj.claimteam;

        if ( var_5 == "axis" )
            var_4 = 1;
        else if ( var_5 == "allies" )
            var_4 = 2;

        var_6 = getdvarint( "scr_twar_hud_momentum_bar", 1 );
        setomnvar( "ui_twar_momentum_bar_visible", var_6 );

        if ( getomnvar( "ui_twar_capture_team" ) != 3 )
            setomnvar( "ui_twar_capture_team", var_4 );

        var_7 = 0.0;

        if ( var_5 != "none" )
            var_7 = level.twar_use_obj.curprogress / level.twar_use_obj.usetime;

        setomnvar( "ui_twar_capture_progress", var_7 );

        foreach ( var_4 in level.teamnamelist )
        {
            var_9 = 0;

            if ( level.twar_use_obj.interactteam == "any" )
                var_9 = level.twar_use_obj.numtouching[var_4];

            setomnvar( "ui_twar_touching_" + var_4, var_9 );
        }

        waitframe();
    }
}

is_maxed_momentum( var_0 )
{
    return level.twar_team_multiplier[var_0] == level.momentum_multiplier_max;
}

set_maxed_momentum( var_0, var_1 )
{
    thread clear_max_momentum_delayed( var_0, var_1 );
    set_momentum( var_0, 0.0 );
    setomnvar( "ui_twar_momentum_maxed_time", var_1 );
    setomnvar( "ui_twar_momentum_end_time_" + var_0, gettime() + int( 1000 * var_1 ) );
}

clear_max_momentum_delayed( var_0, var_1 )
{
    level endon( "clear_max_momentum_" + var_0 );
    wait(var_1);
    thread clear_maxed_momentum( var_0 );
}

clear_maxed_momentum( var_0 )
{
    level notify( "clear_max_momentum_" + var_0 );

    if ( !is_maxed_momentum( var_0 ) )
        return;

    set_momentum( var_0, 0.0 );
    set_momentum_multiplier( var_0, level.momentum_multiplier_max - 1 );
    setomnvar( "ui_twar_momentum_end_time_" + var_0, 0 );
}

clear_momentum( var_0 )
{
    if ( level.twar_team_multiplier[var_0] == 1 )
        maps\mp\_utility::leaderdialog( "mtm_clrd", var_0, "momentum_down" );
    else
        maps\mp\_utility::leaderdialog( "mtm_reset", var_0, "momentum_down" );

    clear_maxed_momentum( var_0 );
    var_1 = level.twar_team_momentum[var_0] + level.twar_team_multiplier[var_0] - 1;
    add_momentum( var_0, -1 * var_1 );
}

add_momentum( var_0, var_1, var_2 )
{
    if ( var_1 == 0 )
        return;

    if ( level.momentum_multiplier_max <= 1 )
        return;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !var_2 && is_maxed_momentum( var_0 ) )
        return;

    var_3 = level.twar_team_momentum[var_0];
    var_4 = level.twar_team_multiplier[var_0];
    var_5 = 0;

    for ( var_3 += var_1; var_3 <= 0.0 && var_4 > 1; var_5 = 1 )
    {
        var_3 += 1.0;
        var_4--;
    }

    if ( !var_5 )
    {
        while ( var_3 >= 1.0 && var_4 < level.momentum_multiplier_max )
        {
            var_3 -= 1.0;
            var_4++;
            var_5 = 1;
        }
    }

    set_momentum( var_0, var_3 );

    if ( var_5 )
        set_momentum_multiplier( var_0, var_4 );

    if ( is_maxed_momentum( var_0 ) )
    {
        var_6 = getdvarfloat( "scr_twar_maxed_time", 20.0 );
        set_maxed_momentum( var_0, var_6 );
    }
    else
        setomnvar( "ui_twar_momentum_" + var_0, level.twar_team_momentum[var_0] );
}

set_momentum( var_0, var_1 )
{
    var_1 = clamp( var_1, 0.0, 1.0 );
    level.twar_team_momentum[var_0] = var_1;
    setomnvar( "ui_twar_momentum_" + var_0, level.twar_team_momentum[var_0] );
}

set_momentum_multiplier( var_0, var_1 )
{
    var_2 = level.twar_team_multiplier[var_0];
    level.twar_team_multiplier[var_0] = var_1;

    if ( var_2 != var_1 )
    {
        setomnvar( "ui_twar_momentum_scale_" + var_0, var_1 );
        level.twar_use_obj maps\mp\gametypes\_gameobjects::updateuserate();

        if ( var_2 > var_1 )
        {
            if ( var_2 != level.momentum_multiplier_max )
                maps\mp\_utility::leaderdialog( "mtm_lost", var_0, "momentum_down" );
        }
        else if ( is_maxed_momentum( var_0 ) )
        {
            maps\mp\_utility::leaderdialog( "mtm_max", var_0 );

            if ( !game["max_meter"][var_0] )
            {
                game["max_meter"][var_0] = 1;

                foreach ( var_4 in level.players )
                {
                    if ( var_4.team != var_0 )
                        continue;

                    var_4 maps\mp\gametypes\_missions::processchallenge( "ch_twar_blitzkrieg" );
                }
            }
        }
        else
            maps\mp\_utility::leaderdialog( "mtm_gain", var_0 );
    }
}

add_kill_enemy_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_kill_enemy", 0.1 );
    add_momentum( var_0, var_1 );
}

add_kill_friendly_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_kill_friendly", -0.1 );
    add_momentum( var_0, var_1 );
}

add_capture_friendly_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_capture_friendly", 0.2 );
    add_momentum( var_0, var_1 );
}

add_capture_enemy_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_capture_enemy", -0.2 );
    add_momentum( var_0, var_1 );
}

init_momentum( var_0 )
{
    level.twar_team_multiplier[var_0] = 1;
    level.twar_team_momentum[var_0] = 0;
    setomnvar( "ui_twar_momentum_end_time_" + var_0, 0 );
    setomnvar( "ui_twar_momentum_" + var_0, level.twar_team_momentum[var_0] );
    setomnvar( "ui_twar_momentum_scale_" + var_0, level.twar_team_multiplier[var_0] );

    if ( level.momentum_multiplier_max <= 1 )
        return;

    level thread init_overtime_momentum( var_0 );
}

init_overtime_momentum( var_0 )
{
    maps\mp\_utility::gameflagwait( "prematch_done" );

    if ( game["status"] == "overtime" )
    {
        var_1 = 0;
        var_2 = game["owned_flags"][var_0];

        if ( var_2 == 4 )
            var_1 = 2.0;
        else if ( var_2 == 3 )
            var_1 = 1.0;

        add_momentum( var_0, var_1 );
    }
}

initspawns()
{
    level.spawnmins = ( 0.0, 0.0, 0.0 );
    level.spawnmaxs = ( 0.0, 0.0, 0.0 );
    level.start_spawn_prefix = "mp_twar_spawn_";
    level.start_spawn_allies = "mp_twar_spawn_allies_start";
    level.start_spawn_axis = "mp_twar_spawn_axis_start";

    if ( !getspawnarray( level.start_spawn_allies ).size )
    {
        level.start_spawn_prefix = "mp_tdm_spawn_";
        level.start_spawn_allies = "mp_tdm_spawn_allies_start";
        level.start_spawn_axis = "mp_tdm_spawn_axis_start";
    }

    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( level.start_spawn_allies );
    maps\mp\gametypes\_spawnlogic::addstartspawnpoints( level.start_spawn_axis );
    level.spawn_name = "mp_twar_spawn";

    if ( !getspawnarray( level.spawn_name ).size )
        level.spawn_name = "mp_tdm_spawn";

    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", level.spawn_name );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", level.spawn_name );
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

getspawnpoint()
{
    var_0 = self.pers["team"];

    if ( game["switchedsides"] )
        var_0 = maps\mp\_utility::getotherteam( var_0 );

    if ( level.usestartspawns && level.ingraceperiod )
    {
        var_1 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( level.start_spawn_prefix + var_0 + "_start" );
        var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn( var_1 );
    }
    else
    {
        var_1 = [];
        var_3 = [];

        if ( level.twar_zones.size == 1 && level.spawn_version != 3 )
            var_1 = level.single_zone_spawns[var_0];
        else if ( level.spawn_version == 1 )
        {
            var_4 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( var_0 );

            foreach ( var_2 in var_4 )
            {
                if ( var_2.nearestzone.owner == var_0 )
                {
                    var_1[var_1.size] = var_2;
                    continue;
                }

                if ( var_2.nearestzone.owner == "none" )
                    var_3[var_3.size] = var_2;
            }
        }
        else if ( level.spawn_version == 2 )
        {
            for ( var_7 = 0; var_7 < level.twar_zones.size; var_7++ )
            {
                var_8 = var_7;

                if ( var_0 == "allies" )
                    var_8 = level.twar_zones.size - 1 - var_7;

                var_9 = level.twar_zones[var_8];

                if ( var_9.owner == var_0 )
                {
                    var_1 = var_9.nearspawns;
                    break;
                }
                else if ( var_9.owner == "none" )
                    var_3 = var_9.nearspawns;
            }
        }
        else if ( level.spawn_version == 3 )
        {
            var_10 = level.twar_use_obj.zone;
            var_1 = var_10.nearspawns[var_0];
        }

        if ( var_1.size == 0 )
            var_1 = var_3;

        var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_twar( var_1, level.twar_use_obj.zone );
    }

    maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint( var_2 );
    return var_2;
}

onnormaldeath( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) )
        add_kill_enemy_momentum( var_1.team );

    if ( isdefined( var_0.team ) )
        add_kill_friendly_momentum( var_0.team );
}

get_start_spawn_centers( var_0 )
{
    var_1 = [];
    var_2 = [ "allies", "axis" ];
    var_3 = [];

    foreach ( var_5 in var_2 )
        var_3[var_5] = maps\mp\gametypes\_spawnlogic::getspawnpointarray( level.start_spawn_prefix + var_5 + "_start" );

    foreach ( var_5 in var_2 )
    {
        var_8 = ( 0.0, 0.0, 0.0 );

        foreach ( var_10 in var_3[var_5] )
            var_8 += var_10.origin;

        var_8 /= var_3[var_5].size;
        var_1[var_5] = var_8;
    }

    if ( var_0 )
    {
        var_13 = getallnodes();

        foreach ( var_5, var_8 in var_1 )
        {
            var_15 = 0;

            for ( var_16 = 0; var_16 < 10 && var_16 < var_13.size; var_16++ )
            {
                var_17 = getpathdist( var_8, var_13[var_16].origin, 99999, 1 );

                if ( var_17 > 0 )
                {
                    var_15 = 1;
                    break;
                }
            }

            if ( !var_15 )
                var_1[var_5] = var_3[var_5][0].origin;
        }
    }

    return var_1;
}

find_zones()
{
    if ( !isdefined( game["zone_origins"] ) || game["status"] == "overtime" )
        game["zone_origins"] = get_zone_origins();

    var_0 = 5;
    level.num_zones = getdvarint( "scr_twar_zone_count", var_0 );

    if ( level.num_zones <= 0 )
        level.num_zones = var_0;

    if ( game["status"] == "overtime" )
        level.num_zones = getdvarint( "scr_twar_ot_zone_count", 3 );

    if ( game["zone_origins"].size > level.num_zones )
    {
        var_1 = int( ( game["zone_origins"].size - level.num_zones ) / 2 );
        var_2 = [];

        for ( var_3 = var_1; var_3 <= game["zone_origins"].size - 1 - var_1; var_3++ )
            var_2[var_2.size] = game["zone_origins"][var_3];

        game["zone_origins"] = var_2;
    }

    setomnvar( "ui_twar_flag_count", level.num_zones );
    level.twar_zones = [];

    foreach ( var_3, var_5 in game["zone_origins"] )
    {
        var_6 = twar_zone( var_3, var_5.origin, var_5.angles, color_from_index( var_3 ) );
        level.twar_zones[var_3] = var_6;
    }
}

get_zone_origins()
{
    var_0 = [];
    var_1 = common_scripts\utility::getstructarray( "twar_zone", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.script_index ) )
            return var_0;
    }

    if ( maps\mp\_utility::isaugmentedgamemode() )
    {
        var_5 = common_scripts\utility::getstructarray( "twar_zone_augmented", "targetname" );

        foreach ( var_7 in var_5 )
        {
            if ( !isdefined( var_7.script_index ) )
                continue;

            foreach ( var_9, var_3 in var_1 )
            {
                if ( var_3.script_index == var_7.script_index )
                    var_1[var_9] = var_7;
            }
        }
    }

    if ( var_1.size < 3 || var_1.size > 7 )
        return var_0;

    var_1 = maps\mp\_utility::quicksort( var_1, ::quicksort_flag_compare );

    foreach ( var_3 in var_1 )
    {
        var_12 = twarzoneangleoverride( var_3 );
        var_13 = spawnstruct();
        var_13.origin = var_3.origin;

        if ( isdefined( var_12 ) )
            var_13.angles = var_12;
        else
            var_13.angles = var_3.script_angles;

        var_0[var_0.size] = var_13;
    }

    level.num_zones = var_0.size;
    return var_0;
}

twarzoneangleoverride( var_0 )
{
    var_1 = maps\mp\_utility::getmapname();
    var_2 = undefined;
    var_3 = var_0.script_index;

    switch ( var_1 )
    {
        case "mp_detroit":
            if ( var_3 == 5 )
                var_2 = ( 0.0, 215.0, 0.0 );

            if ( var_3 == 1 )
                var_2 = ( 0.0, 245.0, 0.0 );

            break;
        case "mp_instinct":
            if ( var_3 == 1 )
                var_2 = ( 0.0, 190.0, 0.0 );

            if ( var_3 == 2 )
                var_2 = ( 0.0, 285.0, 0.0 );

            if ( var_3 == 4 )
                var_2 = ( 0.0, 340.0, 0.0 );

            if ( var_3 == 5 )
                var_2 = ( 0.0, 350.0, 0.0 );

            break;
        default:
            break;
    }

    return var_2;
}

quicksort_flag_compare( var_0, var_1 )
{
    return var_0.script_index <= var_1.script_index;
}

get_zone_origins_auto()
{
    level.num_zones = getdvarint( "scr_twar_zone_count", 5 );
    var_0 = get_start_spawn_centers( 1 );
    var_1 = [ "allies", "axis" ];
    var_2 = getallnodes();
    var_3 = level.num_zones;
    var_4 = getdvarfloat( "scr_twar_auto_zone_spacing", 0.15 );
    var_5 = getdvarfloat( "scr_twar_auto_zone_zig_zag", 0.1 );
    var_6 = getdvarint( "scr_twar_auto_zone_allow_traversals", 0 );
    var_7 = getdvarint( "scr_twar_auto_zone_sky_only", 1 );
    var_8 = [];

    for ( var_9 = 0; var_9 < level.num_zones; var_9++ )
    {
        var_10 = ( var_9 + 1 ) / ( level.num_zones + 1 - var_9 + 1 );
        var_11 = ( 2 * ( var_9 + 1 ) - 1 ) / ( 2 * ( level.num_zones + 1 - var_9 + 1 ) + 1 );
        var_12 = ( 2 * ( var_9 + 1 ) + 1 ) / ( 2 * ( level.num_zones + 1 - var_9 + 1 ) - 1 );
        var_8[var_9]["min"] = var_10 - var_4 * ( var_10 - var_11 );
        var_8[var_9]["max"] = var_10 + var_4 * ( var_12 - var_10 );
    }

    var_13 = [];

    for ( var_9 = 0; var_9 < var_8.size; var_9++ )
        var_13[var_9] = [];

    foreach ( var_15 in var_2 )
    {
        if ( var_7 && !_func_20C( var_15, 1 ) )
            continue;

        var_16 = [];

        foreach ( var_18 in var_1 )
            var_16[var_18] = getpathdist( var_0[var_18], var_15.origin, 99999, var_6 );

        if ( var_16["allies"] <= 0 || var_16["axis"] <= 0 )
            continue;

        var_20 = var_16["allies"] / var_16["axis"];

        for ( var_9 = 0; var_9 < var_8.size; var_9++ )
        {
            if ( var_20 > var_8[var_9]["min"] && var_20 < var_8[var_9]["max"] )
                var_13[var_9][var_13[var_9].size] = var_15;
        }
    }

    var_22 = [];
    var_23 = var_0["allies"];

    foreach ( var_9, var_25 in var_13 )
    {
        var_25 = sortbydistance( var_25, var_23 );
        var_26 = int( clamp( 2 * var_25.size * var_5 - var_25.size, 0, var_25.size ) );
        var_27 = int( clamp( 2 * var_25.size * var_5, 0, var_25.size ) );

        if ( var_26 < var_27 )
            var_28 = randomintrange( var_26, var_27 );
        else
            var_28 = int( clamp( var_26, 0, var_25.size - 1 ) );

        var_29 = spawnstruct();
        var_29.origin = var_25[var_28].origin;
        var_22[var_9] = var_29;
        var_23 = var_25[var_28].origin;
    }

    return var_22;
}

color_from_index( var_0 )
{
    return ( var_0 & 4, var_0 & 2, var_0 & 1 );
}

twar_zone( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_5 = var_1 + ( 0.0, 0.0, 32.0 );
    var_6 = var_1 + ( 0.0, 0.0, -64.0 );
    var_7 = bullettrace( var_5, var_6, 0, undefined );
    var_4.origin = var_7["position"];
    var_4.owner = "none";
    var_4.index = var_0;
    var_4.angles = var_2;
    var_4._id_2683 = var_3;
    var_4.projector = spawn_flag_projector( var_4.origin );
    return var_4;
}

draw_spawn_until_notify( var_0, var_1, var_2 )
{
    level endon( var_2 );
    var_3 = anglestoforward( var_0.angles );
    level thread draw_line_until_notify( var_0.origin, var_0.origin + var_3 * 50, var_1, var_2 );
    var_0.debug_draw = 1;

    for (;;)
        wait 0.05;
}

draw_line_until_notify( var_0, var_1, var_2, var_3 )
{
    level endon( var_3 );

    for (;;)
        wait 0.05;
}

draw_circle_until_notify( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
        var_5 = var_4;
    else
        var_5 = 16;

    var_6 = 360 / var_5;
    var_7 = [];

    for ( var_8 = 0; var_8 < var_5; var_8++ )
    {
        var_9 = var_6 * var_8;
        var_10 = cos( var_9 ) * var_1;
        var_11 = sin( var_9 ) * var_1;
        var_12 = var_0[0] + var_10;
        var_13 = var_0[1] + var_11;
        var_14 = var_0[2];
        var_7[var_7.size] = ( var_12, var_13, var_14 );
    }

    for ( var_8 = 0; var_8 < var_7.size; var_8++ )
    {
        var_15 = var_7[var_8];

        if ( var_8 + 1 >= var_7.size )
            var_16 = var_7[0];
        else
            var_16 = var_7[var_8 + 1];

        thread draw_line_until_notify( var_15, var_16, var_2, var_3 );
    }
}

assign_spawns()
{
    if ( level.spawn_version == 2 )
        assign_spawns_version_2();
    else if ( level.spawn_version == 3 )
        assign_spawns_version_3();
}

assign_spawns_version_2()
{
    if ( level.twar_zones.size == 1 )
    {
        level.single_zone_spawns = [];
        level.single_zone_spawns["allies"] = [];
        level.single_zone_spawns["axis"] = [];
        var_0 = getnearestspawns( level.twar_zones[0], 12 );

        foreach ( var_2 in var_0 )
        {
            var_3 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( level.start_spawn_prefix + "allies_start" )[0];
            var_4 = twar_dist( var_2.origin, var_3.origin );
            var_3 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( level.start_spawn_prefix + "axis_start" )[0];
            var_5 = twar_dist( var_2.origin, var_3.origin );
            var_6 = common_scripts\utility::ter_op( var_4 < var_5, "allies", "axis" );
            var_7 = level.single_zone_spawns[var_6].size;
            level.single_zone_spawns[var_6][var_7] = var_2;
        }
    }
    else
    {
        foreach ( var_10 in level.twar_zones )
            var_10.nearspawns = getnearestspawns( var_10, 6 );

        var_12 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( "axis" );

        foreach ( var_14 in var_12 )
        {
            var_14.nearestzone = getnearestzonepoint( var_14 );

            if ( !common_scripts\utility::array_contains( var_14.nearestzone.nearspawns, var_14 ) )
            {
                var_7 = var_14.nearestzone.nearspawns.size;
                var_14.nearestzone.nearspawns[var_7] = var_14;
            }
        }
    }
}

get_zone_dir( var_0 )
{
    if ( isdefined( level.twar_zones[var_0].angles ) )
        return anglestoforward( level.twar_zones[var_0].angles );
    else
    {
        var_3 = get_start_spawn_centers( 0 );
        var_4 = var_3["axis"] - var_3["allies"];
        var_4 = ( var_4[0], var_4[1], 0 );
        return vectornormalize( var_4 );
    }
}

assign_spawns_version_3()
{
    var_0 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( "axis" );
    var_1 = var_0.size;

    foreach ( var_14, var_3 in level.twar_zones )
    {
        var_4 = 9;
        var_3.nearspawns["all"] = getnearestspawns( var_3, 24, level.zone_radius * 3, 0.0 );
        var_3.dir = get_zone_dir( var_14 );

        foreach ( var_6 in var_3.nearspawns["all"] )
        {
            var_7 = vectornormalize( var_3.origin - var_6.origin );
            var_6.dot = vectordot( var_7, var_3.dir );
        }

        var_3.nearspawns["all"] = maps\mp\_utility::quicksort( var_3.nearspawns["all"], ::twar_spawn_dot );
        var_3.nearspawns["allies"] = [];
        var_3.nearspawns["axis"] = [];

        for ( var_9 = 0; var_9 < var_3.nearspawns["all"].size; var_9++ )
        {
            var_10 = int( var_9 / 2 );
            var_11 = "axis";

            if ( var_9 % 2 == 1 )
            {
                var_10 = var_3.nearspawns["all"].size - int( ( var_9 + 1 ) / 2 );
                var_11 = "allies";
            }

            var_12 = undefined;
            var_6 = var_3.nearspawns["all"][var_10];

            if ( var_3.nearspawns[var_11].size < var_4 )
                var_12 = var_11;
            else if ( var_6.dot > 0 )
                var_12 = "allies";
            else
                var_12 = "axis";

            if ( isdefined( var_12 ) )
            {
                var_13 = var_3.nearspawns[var_12].size;
                var_3.nearspawns[var_12][var_13] = var_6;
            }
        }
    }
}

twar_dist( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
    var_3 = -1;

    if ( var_2 )
        var_3 = getpathdist( var_0, var_1, 999999 );

    if ( var_3 == -1 )
        var_3 = distance( var_0, var_1 );

    return var_3;
}

getnearestspawns( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_4 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
    var_5 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( "axis" );

    foreach ( var_7 in var_5 )
    {
        var_7.dist = -1;

        if ( var_4 )
            var_7.dist = getpathdist( var_7.origin, var_0.origin, 999999 );

        if ( var_7.dist == -1 )
            var_7.dist = distance( var_0.origin, var_7.origin );
    }

    var_5 = maps\mp\_utility::quicksort( var_5, ::twar_spawn_dist );
    var_9 = maps\mp\_utility::getmapname();
    var_10 = game["status"] == "overtime";
    var_11 = var_0.index;

    if ( var_10 )
        var_11 += 1;

    var_12 = [];

    for ( var_13 = 0; var_13 < var_5.size && var_12.size < var_1; var_13++ )
    {
        var_7 = var_5[var_13];

        if ( var_7.dist < var_2 )
            continue;

        switch ( var_9 )
        {
            case "mp_instinct":
                if ( var_11 == 0 )
                {
                    if ( var_7.index == 1 )
                        continue;
                }
                else if ( var_11 == 1 )
                {
                    if ( var_7.index == 14 )
                        continue;
                }
                else if ( var_11 == 3 )
                {
                    if ( var_7.index == 16 )
                        continue;
                }
                else if ( var_11 == 4 )
                {
                    if ( var_7.index == 16 )
                        continue;
                }

                break;
        }

        var_12[var_12.size] = var_7;
    }

    return var_12;
}

twar_spawn_dot( var_0, var_1 )
{
    return var_0.dot <= var_1.dot;
}

twar_spawn_dist( var_0, var_1 )
{
    return var_0.dist <= var_1.dist;
}

getnearestzonepoint( var_0 )
{
    var_1 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_5 in level.twar_zones )
    {
        var_6 = undefined;

        if ( var_1 )
            var_6 = getpathdist( var_0.origin, var_5.origin, 999999 );

        if ( !isdefined( var_6 ) || var_6 == -1 )
            var_6 = distance( var_5.origin, var_0.origin );

        if ( !isdefined( var_2 ) || var_6 < var_3 )
        {
            var_2 = var_5;
            var_3 = var_6;
        }
    }

    return var_2;
}

onspawnplayer()
{
    self.minionstreak = 0;
}

updateminions()
{
    level endon( "game_ended" );

    while ( !isdefined( level.agentarray ) )
        waitframe();

    maps\mp\_utility::gameflagwait( "prematch_done" );
    var_0 = getdvarint( "scr_twar_minionsmax", 18 );

    if ( var_0 <= 0 )
        return;

    update_minion_hud_outlines();
    var_1 = [ "allies", "axis" ];
    var_2 = getdvarfloat( "scr_twar_minionspawndelay", 10.0 );
    var_3 = [];
    var_4 = undefined;
    var_5 = undefined;
    var_6 = getdvarint( "scr_twar_minionspawnhud", 0 );

    if ( var_6 > 0 )
    {
        var_4 = minion_spawn_timer_hud();
        var_4 hud_set_visible();

        if ( var_6 > 1 )
        {
            var_5 = minion_max_hud();

            foreach ( var_8 in var_1 )
            {
                foreach ( var_10 in var_1 )
                    var_3[var_8][var_10] = minion_count_hud( var_8, var_10 );
            }
        }
    }

    while ( !level.gameended )
    {
        if ( isdefined( var_4 ) )
            var_4 settimer( var_2 );

        wait(var_2);
        maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        var_13 = getminioncount();
        var_14 = level.num_zones - 1;

        if ( var_13 + var_14 < var_0 )
        {
            var_15 = [];

            foreach ( var_17 in var_1 )
                var_15[var_17] = 0;

            foreach ( var_20 in level.twar_zones )
            {
                var_17 = var_20.owner;

                if ( var_17 != "allies" && var_17 != "axis" )
                    continue;

                var_21 = undefined;
                var_22 = undefined;
                var_23 = maps\mp\agents\_agents::add_humanoid_agent( "player", var_17, "minion", var_21, var_22, undefined, 0, 0, "recruit" );

                if ( isdefined( var_23 ) )
                {
                    var_23 takeallweapons();
                    var_24 = getdvarint( "scr_twar_minionweapon", 0 );
                    var_25 = "";

                    switch ( var_24 )
                    {
                        case 2:
                            var_25 = "iw5_kf5_mp";
                            break;
                        case 1:
                            var_25 = "iw5_hbra3_mp";
                            break;
                        case 0:
                        default:
                            var_25 = "iw5_titan45_mp";
                            break;
                    }

                    var_23 giveweapon( var_25 );
                    var_23 switchtoweaponimmediate( var_25 );
                    var_23 maps\mp\_utility::giveperk( "specialty_minion", 0 );
                    var_23.movespeedscaler = getdvarfloat( "scr_twar_minionmovespeedscale", 0.85 );
                    var_23.damage_scale = getdvarfloat( "scr_twar_miniondamagescale", 0.5 );
                    var_23.agentname = &"MP_MINION";
                    var_23.nonkillstreakagent = 1;
                    var_23 thread minion_ai();
                    update_minion_hud_outlines();
                    var_23 detachall();
                    var_23 setmodel( "kva_hazmat_body_infected_mp" );
                    var_23 attach( "kva_hazmat_head_infected" );
                    var_23 setclothtype( "cloth" );
                    var_26 = getdvarfloat( "scr_twar_minionhealthscale", 0.75 );
                    var_23 maps\mp\agents\_agent_common::set_agent_health( int( var_23.health * var_26 ) );
                    var_15[var_17]++;
                }
            }

            foreach ( var_8, var_29 in var_3 )
            {
                foreach ( var_10, var_31 in var_29 )
                {
                    var_31 hud_set_visible();
                    var_31 setvalue( var_15[var_10] );
                    var_31 maps\mp\_utility::delaythread( 3.0, ::hud_set_invisible );
                }
            }

            continue;
        }

        if ( isdefined( var_5 ) )
        {
            var_5 hud_set_visible();
            var_5 maps\mp\_utility::delaythread( 3.0, ::hud_set_invisible );
        }
    }
}

is_minion()
{
    return self hasperk( "specialty_minion", 1 );
}

hud_set_visible()
{
    self.alpha = 1.0;
}

hud_set_invisible()
{
    self.alpha = 0.0;
}

minion_max_hud()
{
    var_0 = maps\mp\gametypes\_hud_util::createserverfontstring( "hudbig", 1.0 );
    var_0 maps\mp\gametypes\_hud_util::setpoint( "BOTTOM", undefined, 0, -20 );
    var_0.label = &"MP_DOMAI_MINIONS_SPAWNED_MAX";
    var_0.color = ( 1.0, 0.0, 0.0 );
    var_0.archived = 1;
    var_0.showinkillcam = 1;
    var_0.alpha = 0.0;
    return var_0;
}

minion_count_hud( var_0, var_1 )
{
    var_2 = maps\mp\gametypes\_hud_util::createserverfontstring( "hudbig", 1.0, var_0 );
    var_2 maps\mp\gametypes\_hud_util::setpoint( "BOTTOM", undefined, 0, common_scripts\utility::ter_op( var_0 == var_1, -40, -20 ) );
    var_2.label = common_scripts\utility::ter_op( var_0 == var_1, &"MP_DOMAI_MINIONS_SPAWNED_FRIENDLY", &"MP_DOMAI_MINIONS_SPAWNED_ENEMY" );
    var_2.color = common_scripts\utility::ter_op( var_0 == var_1, ( 0.157, 0.392, 0.784 ), ( 0.784, 0.49, 0.157 ) );
    var_2.archived = 1;
    var_2.showinkillcam = 1;
    var_2.alpha = 0.0;
    return var_2;
}

minion_spawn_timer_hud()
{
    var_0 = maps\mp\gametypes\_hud_util::createservertimer( "hudbig", 1.0 );
    var_0 maps\mp\gametypes\_hud_util::setpoint( "BOTTOM", undefined, 0, -60 );
    var_0.label = &"MP_DOMAI_MINIONS_SPAWN_TIMER";
    var_0.color = ( 1.0, 1.0, 1.0 );
    var_0.archived = 1;
    var_0.showinkillcam = 1;
    return var_0;
}

update_minion_hud_outlines()
{
    var_0 = [];
    var_1 = [];
    var_2 = getdvarint( "scr_twar_minionoutline", 0 );

    foreach ( var_4 in level.players )
    {
        if ( var_4.team == "allies" )
        {
            var_0[var_0.size] = var_4;
            continue;
        }

        var_1[var_1.size] = var_4;
    }

    foreach ( var_7 in level.agentarray )
    {
        if ( var_7 is_minion() )
        {
            if ( level.players.size > 0 )
                var_7 hudoutlinedisableforclients( level.players );

            if ( var_2 )
            {
                if ( var_0.size > 0 )
                    var_7 hudoutlineenableforclients( var_0, common_scripts\utility::ter_op( var_7.team == "allies", 2, 3 ), 1 );

                if ( var_1.size > 0 )
                    var_7 hudoutlineenableforclients( var_1, common_scripts\utility::ter_op( var_7.team == "axis", 2, 3 ), 1 );
            }
        }
    }
}

minion_ai()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( level.twar_use_obj ) )
        {
            var_0 = level.twar_use_obj.trigger.origin;
            self botsetscriptgoal( var_0, level.zone_radius * 0.9, "objective" );
        }

        wait 0.1;
    }
}

getminioncount()
{
    var_0 = 0;

    foreach ( var_2 in level.agentarray )
    {
        if ( isdefined( var_2.isactive ) && var_2.isactive && var_2.agent_type == "player" && var_2 is_minion() )
            var_0++;
    }

    return var_0;
}

minion_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( var_2 ) && isdefined( var_2.damage_scale ) )
        var_3 = int( var_3 * var_2.damage_scale );

    return var_3;
}

on_minion_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isplayer( var_1 ) && is_minion() && var_1.team != self.team )
    {
        var_9 = getdvarfloat( "scr_twar_score_kill_minion_multipler", 0 );

        if ( var_9 > 0 )
        {
            var_10 = getdvarfloat( "scr_twar_score_kill_minion_base", 10 );
            var_11 = int( var_1.minionstreak * var_9 + var_10 );
            var_11 = min( var_11, getdvarint( "scr_twar_score_kill_minion_max", 150 ) );
            setdvar( "scr_twar_score_kill_minion", var_11 );
        }

        var_1.minionstreak++;
        level thread maps\mp\gametypes\_rank::awardgameevent( "kill_minion", var_1, var_4, self, var_3 );

        if ( isdefined( var_1 ) )
            add_kill_enemy_minion_momentum( var_1.team );

        if ( isdefined( self.team ) )
            add_kill_friendly_minion_momentum( self.team );
    }
}

add_kill_enemy_minion_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_kill_enemy_minion", 0.1 );
    add_momentum( var_0, var_1 );
}

add_kill_friendly_minion_momentum( var_0 )
{
    var_1 = getdvarfloat( "scr_twar_momentum_kill_friendly_minion", -0.1 );
    add_momentum( var_0, var_1 );
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isplayer( var_1 ) )
        return;

    if ( maps\mp\gametypes\_damage::isfriendlyfire( self, var_1 ) )
        return;

    if ( var_1 == self )
        return;

    if ( isdefined( var_4 ) && maps\mp\_utility::iskillstreakweapon( var_4 ) )
        return;

    var_10 = 0;
    var_11 = self;

    foreach ( var_13 in var_1.touchtriggers )
    {
        if ( var_13 != level.twar_use_obj.trigger )
            continue;

        var_1 thread maps\mp\_events::killwhilecapture( var_11, var_9 );
        var_10 = 1;
        break;
    }

    if ( !var_10 )
    {
        foreach ( var_13 in var_11.touchtriggers )
        {
            if ( var_13 != level.twar_use_obj.trigger )
                continue;

            var_1 thread maps\mp\_events::assaultobjectiveevent( self, var_9 );
        }
    }
}
