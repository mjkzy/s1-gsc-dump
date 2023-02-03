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
        maps\mp\_utility::registertimelimitdvar( level.gametype, 10 );
        maps\mp\_utility::setoverridewatchdvar( "scorelimit", 0 );
        maps\mp\_utility::registerroundlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registerwinlimitdvar( level.gametype, 1 );
        maps\mp\_utility::registernumlivesdvar( level.gametype, 0 );
        maps\mp\_utility::registerhalftimedvar( level.gametype, 0 );
        level.matchrules_numinitialinfected = 1;
        level.matchrules_damagemultiplier = 0;
    }

    setdynamicdvar( "scr_game_high_jump", 1 );
    setdynamicdvar( "jump_slowdownEnable", 0 );
    setspecialloadouts();
    level.teambased = 1;
    level.doprematch = 1;
    level.disableforfeit = 1;
    level.nobuddyspawns = 1;
    level.onstartgametype = ::onstartgametype;
    level.onspawnplayer = ::onspawnplayer;
    level.getspawnpoint = ::getspawnpoint;
    level.onplayerkilled = ::onplayerkilled;
    level.ondeadevent = ::ondeadevent;
    level.ontimelimit = ::ontimelimit;
    level.autoassign = ::infectautoassign;
    level.bypassclasschoicefunc = ::infectedclass;

    if ( level.matchrules_damagemultiplier )
        level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

    game["dialog"]["gametype"] = "inf_intro";

    if ( getdvarint( "g_hardcore" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "inf_survive";
    game["dialog"]["defense_obj"] = "inf_survive";
    game["dialog"]["first_infected"] = "inf_patientzero";
    game["dialog"]["time_extended"] = "inf_extratime";
    game["dialog"]["lone_survivor"] = "inf_lonesurvivor";
    game["dialog"]["been_infected"] = "inf_been_infected";

    if ( maps\mp\_utility::isgrapplinghookgamemode() )
        game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
}

initializematchrules()
{
    maps\mp\_utility::setcommonrulesfrommatchrulesdata();
    level.matchrules_numinitialinfected = getmatchrulesdata( "infectData", "numInitialInfected" );
    setdynamicdvar( "scr_" + level.gametype + "_numLives", 0 );
    maps\mp\_utility::registernumlivesdvar( level.gametype, 0 );
    maps\mp\_utility::setoverridewatchdvar( "scorelimit", 0 );
    setdynamicdvar( "scr_infect_roundswitch", 0 );
    maps\mp\_utility::registerroundswitchdvar( "infect", 0, 0, 9 );
    setdynamicdvar( "scr_infect_roundlimit", 1 );
    maps\mp\_utility::registerroundlimitdvar( "infect", 1 );
    setdynamicdvar( "scr_infect_winlimit", 1 );
    maps\mp\_utility::registerwinlimitdvar( "infect", 1 );
    setdynamicdvar( "scr_infect_halftime", 0 );
    maps\mp\_utility::registerhalftimedvar( "infect", 0 );
    setdynamicdvar( "scr_infect_playerrespawndelay", 0 );
    setdynamicdvar( "scr_infect_waverespawndelay", 0 );
    setdynamicdvar( "scr_player_forcerespawn", 1 );
    setdynamicdvar( "scr_team_fftype", 0 );
    setdynamicdvar( "scr_game_hardpoints", 0 );
}

onstartgametype()
{
    setclientnamemode( "auto_change" );
    maps\mp\_utility::setobjectivetext( "allies", &"OBJECTIVES_INFECT" );
    maps\mp\_utility::setobjectivetext( "axis", &"OBJECTIVES_INFECT" );

    if ( level.splitscreen )
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_INFECT" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_INFECT" );
    }
    else
    {
        maps\mp\_utility::setobjectivescoretext( "allies", &"OBJECTIVES_INFECT_SCORE" );
        maps\mp\_utility::setobjectivescoretext( "axis", &"OBJECTIVES_INFECT_SCORE" );
    }

    maps\mp\_utility::setobjectivehinttext( "allies", &"OBJECTIVES_INFECT_HINT" );
    maps\mp\_utility::setobjectivehinttext( "axis", &"OBJECTIVES_INFECT_HINT" );
    initspawns();
    var_0[0] = level.gametype;
    maps\mp\gametypes\_gameobjects::main( var_0 );
    level.quickmessagetoall = 1;
    level.blockweapondrops = 1;
    level.infect_allowsuicide = 0;
    level.infect_chosefirstinfected = 0;
    level.infect_choosingfirstinfected = 0;
    level.infect_countdowninprogress = 0;
    level.infect_teamscores["axis"] = 0;
    level.infect_teamscores["allies"] = 0;
    level.infect_players = [];
    level thread onplayerconnect();
    level thread gametimer();
}

gametimer()
{
    level endon( "game_ended" );
    setdynamicdvar( "scr_infect_timelimit", 0 );
    var_0 = 0;

    for (;;)
    {
        level waittill( "update_game_time", var_1 );

        if ( !isdefined( var_1 ) )
            var_1 = ( maps\mp\_utility::gettimepassed() + 1500 ) / 60000 + 2;

        setdynamicdvar( "scr_infect_timelimit", var_1 );
        level thread watchhostmigration( var_1 );

        if ( var_0 )
            level thread maps\mp\_utility::leaderdialogbothteams( "time_extended", "axis", "time_extended", "allies", "status" );

        var_0 = 1;
    }
}

watchhostmigration( var_0 )
{
    level notify( "watchHostMigration" );
    level endon( "watchHostMigration" );
    level endon( "game_ended" );
    level waittill( "host_migration_begin" );
    setdynamicdvar( "scr_infect_timelimit", 0 );
    waittillframeend;
    setdynamicdvar( "scr_infect_timelimit", 0 );
    level waittill( "host_migration_end" );
    level notify( "update_game_time", var_0 );
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.infectedrejoined = 0;
        var_0.killsasinfected = 0;

        if ( maps\mp\_utility::gameflag( "prematch_done" ) )
        {
            if ( isdefined( level.infect_chosefirstinfected ) && level.infect_chosefirstinfected )
                var_0.survivalstarttime = gettime();
        }

        if ( isdefined( level.infect_players[var_0.name] ) )
            var_0.infectedrejoined = 1;

        var_0 thread monitorsurvivaltime();
    }
}

initspawns()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.spawn_name = "mp_tdm_spawn";
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", level.spawn_name );
    maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", level.spawn_name );
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

infectautoassign()
{
    var_0 = "allies";

    if ( self.infectedrejoined )
        var_0 = "axis";

    thread maps\mp\gametypes\_menus::setteam( var_0 );
}

getspawnpoint()
{
    if ( level.ingraceperiod )
    {
        var_0 = maps\mp\gametypes\_spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
        var_1 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random( var_0 );
    }
    else
    {
        var_0 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( self.pers["team"] );
        var_1 = maps\mp\gametypes\_spawnscoring::getspawnpoint_nearteam( var_0 );
    }

    maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint( var_1 );
    return var_1;
}

infectedclass()
{
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";
    self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
    self.class = self.pers["class"];
    self.lastclass = self.pers["lastClass"];
    preloadweapons();
}

preloadweapons()
{
    var_0 = [];

    foreach ( var_2 in level.infect_loadouts )
    {
        if ( isdefined( var_2["loadoutPrimary"] ) && var_2["loadoutPrimary"] != "iw5_combatknife" && var_2["loadoutPrimary"] != "none" )
            var_0[var_0.size] = var_2["loadoutPrimary"];

        if ( isdefined( var_2["loadoutSecondary"] ) && var_2["loadoutSecondary"] != "iw5_combatknife" && var_2["loadoutSecondary"] != "none" )
            var_0[var_0.size] = var_2["loadoutSecondary"];
    }

    if ( var_0.size > 0 )
        self loadweapons( var_0 );
}

onspawnplayer()
{
    if ( isdefined( self.teamchangedthisframe ) )
    {
        self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
        maps\mp\gametypes\_class::giveloadout( self.team, self.class );
        thread monitordisconnect();
    }

    self.teamchangedthisframe = undefined;
    preloadweapons();
    updateteamscores();

    if ( !level.infect_choosingfirstinfected )
    {
        level.infect_choosingfirstinfected = 1;
        level thread choosefirstinfected();
    }

    if ( self.infectedrejoined )
    {
        if ( !level.infect_allowsuicide )
        {
            level notify( "infect_stopCountdown" );
            level.infect_chosefirstinfected = 1;
            level.infect_allowsuicide = 1;

            foreach ( var_1 in level.players )
            {
                if ( isdefined( var_1.infect_isbeingchosen ) )
                    var_1.infect_isbeingchosen = undefined;
            }
        }

        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.isinitialinfected ) )
                var_1 thread setinitialtonormalinfected();
        }

        if ( level.infect_teamscores["axis"] == 1 )
            self.isinitialinfected = 1;

        clearsurvivaltime();
    }

    if ( isdefined( self.isinitialinfected ) )
    {
        self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
        maps\mp\gametypes\_class::giveloadout( self.team, self.class );
    }

    thread onspawnfinished();
    level notify( "spawned_player" );
}

onspawnfinished()
{
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "applyLoadout" );
    updateloadouts();
}

updateloadouts()
{
    if ( self.pers["team"] == "allies" )
        maps\mp\_utility::giveperk( "specialty_extended_battery", 0 );

    if ( self.pers["team"] == "axis" )
    {
        thread setinfectedmsg();
        thread setinfectedmodels();
        self setmovespeedscale( 1.2 );
    }
}

setinfectedmodels()
{
    self detachall();
    self setmodel( "kva_hazmat_body_infected_mp" );
    self attach( "kva_hazmat_head_infected" );
    self setviewmodel( "vm_kva_hazmat_infected" );
    self setclothtype( "cloth" );
}

setinfectedmsg()
{
    if ( !isdefined( self.showninfected ) || !self.showninfected )
    {
        thread maps\mp\_events::gotinfectedevent();
        self playsoundtoplayer( "mp_inf_got_infected", self );
        maps\mp\_utility::leaderdialogonplayer( "been_infected", "status" );
        self.showninfected = 1;
    }
}

choosefirstinfected()
{
    level endon( "game_ended" );
    level endon( "infect_stopCountdown" );
    level.infect_allowsuicide = 0;
    maps\mp\_utility::gameflagwait( "prematch_done" );
    level.infect_countdowninprogress = 1;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 1.0 );
    var_0 = 15;
    setomnvar( "ui_match_countdown_title", 7 );
    setomnvar( "ui_match_countdown_toggle", 1 );

    while ( var_0 > 0 && !level.gameended )
    {
        var_0--;
        setomnvar( "ui_match_countdown", var_0 + 1 );
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 1.0 );
    }

    setomnvar( "ui_match_countdown", 1 );
    setomnvar( "ui_match_countdown_title", 0 );
    setomnvar( "ui_match_countdown_toggle", 0 );
    level.infect_countdowninprogress = 0;
    var_1 = [];
    var_2 = undefined;

    foreach ( var_4 in level.players )
    {
        if ( maps\mp\_utility::matchmakinggame() && level.players.size > 1 && var_4 ishost() )
        {
            var_2 = var_4;
            continue;
        }

        if ( var_4.team == "spectator" )
            continue;

        if ( !var_4.hasspawned )
            continue;

        var_1[var_1.size] = var_4;
    }

    if ( !var_1.size && isdefined( var_2 ) )
        var_1[var_1.size] = var_2;

    var_6 = var_1[randomint( var_1.size )];
    var_6 setfirstinfected( 1 );

    foreach ( var_4 in level.players )
    {
        if ( var_4 == var_6 )
            continue;

        var_4.survivalstarttime = gettime();
    }
}

prepareforclasschange()
{
    while ( !maps\mp\_utility::isreallyalive( self ) || maps\mp\_utility::isusingremote() )
        wait 0.05;

    if ( isdefined( self.iscarrying ) && self.iscarrying == 1 )
    {
        self notify( "force_cancel_placement" );
        wait 0.05;
    }

    while ( self ismeleeing() )
        wait 0.05;

    while ( self ismantling() )
        wait 0.05;

    while ( !self isonground() && !self isonladder() )
        wait 0.05;

    if ( maps\mp\_utility::isjuggernaut() )
    {
        self notify( "lost_juggernaut" );
        wait 0.05;
    }

    maps\mp\_exo_ping::stop_exo_ping();
    maps\mp\_extrahealth::stopextrahealth();
    maps\mp\_adrenaline::stopadrenaline();
    maps\mp\_exo_cloak::active_cloaking_disable();
    maps\mp\_exo_mute::stop_exo_mute();
    maps\mp\_exo_repulsor::stop_repulsor();
    wait 0.05;

    while ( !maps\mp\_utility::isreallyalive( self ) )
        wait 0.05;
}

setfirstinfected( var_0 )
{
    self endon( "disconnect" );
    prepareforclasschange();

    if ( var_0 )
    {
        self.infect_isbeingchosen = 1;
        maps\mp\gametypes\_menus::addtoteam( "axis", undefined, 1 );
        thread monitordisconnect();
        level.infect_chosefirstinfected = 1;
        self.infect_isbeingchosen = undefined;
        level notify( "update_game_time" );
        updateteamscores();
        level.infect_allowsuicide = 1;
        level.infect_players[self.name] = 1;
    }

    self.isinitialinfected = 1;
    self.showninfected = 1;
    self notify( "faux_spawn" );
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    maps\mp\gametypes\_class::giveandapplyloadout( self.team, "gamemode" );
    updateloadouts();
    thread maps\mp\_events::firstinfectedevent();
    self playsoundtoplayer( "mp_inf_got_infected", self );
    maps\mp\_utility::leaderdialogonplayer( "first_infected", "status" );
    clearsurvivaltime();
    refillbattery();
}

setinitialtonormalinfected()
{
    level endon( "game_ended" );
    self.isinitialinfected = undefined;
    prepareforclasschange();
    self notify( "faux_spawn" );
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
    thread onspawnfinished();
    maps\mp\gametypes\_class::giveandapplyloadout( self.team, "gamemode" );
    refillbattery();
}

refillbattery()
{
    var_0 = self getweaponslistoffhands();

    foreach ( var_2 in var_0 )
        self batteryfullrecharge( var_2 );
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( self.team == "axis" && isplayer( var_1 ) && var_1.team == "allies" && maps\mp\_utility::ismeleemod( var_3 ) )
        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_infect_tooclose" );

    if ( self.team == "axis" )
        return;

    var_10 = var_1 == self || !isplayer( var_1 );

    if ( var_10 && !level.infect_allowsuicide )
        return;

    level notify( "update_game_time" );
    self notify( "delete_explosive_drones" );
    self.teamchangedthisframe = 1;
    maps\mp\gametypes\_menus::addtoteam( "axis" );
    setsurvivaltime( 1 );
    updateteamscores();
    maps\mp\_utility::playsoundonplayers( "mp_enemy_obj_captured", "allies" );
    maps\mp\_utility::playsoundonplayers( "mp_war_objective_taken", "axis" );
    level.infect_players[self.name] = 1;
    level thread maps\mp\_utility::teamplayercardsplash( "callout_got_infected", self, "allies" );

    if ( !var_10 )
    {
        var_1 thread maps\mp\_events::infectedsurvivorevent();
        var_1 playsoundtoplayer( "mp_inf_infection_kill", var_1 );
        var_1.killsasinfected++;

        if ( var_1.killsasinfected == 3 )
        {
            var_1 thread maps\mp\_events::plagueevent();
            var_1.killsasinfected = 0;
        }
    }

    if ( level.infect_teamscores["axis"] == 2 )
    {
        foreach ( var_12 in level.players )
        {
            if ( isdefined( var_12.isinitialinfected ) )
                var_12 thread setinitialtonormalinfected();
        }
    }

    if ( level.infect_teamscores["allies"] == 0 )
    {
        onsurvivorseliminated();
        return;
    }

    if ( level.infect_teamscores["allies"] == 1 )
    {
        onfinalsurvivor();
        return;
    }
}

onfinalsurvivor()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1 ) )
            continue;

        if ( var_1.team != "allies" )
            continue;

        if ( isdefined( var_1.awardedfinalsurvivor ) )
            continue;

        var_1.awardedfinalsurvivor = 1;
        var_1 thread maps\mp\_events::finalsurvivorevent();
        var_1 thread maps\mp\_utility::leaderdialogonplayer( "lone_survivor", "status" );
        level thread finalsurvivoruav( var_1 );
        break;
    }
}

finalsurvivoruav( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "eliminated" );
    level endon( "infect_lateJoiner" );
    level thread enduavonlatejoiner( var_0 );
    var_1 = 0;
    level.radarmode["axis"] = "normal_radar";

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == "axis" )
            var_3.radarmode = "normal_radar";
    }

    setteamradarstrength( "axis", 1 );

    for (;;)
    {
        var_5 = var_0.origin;
        wait 4;

        if ( var_1 )
        {
            setteamradar( "axis", 0 );
            var_1 = 0;
        }

        wait 6;

        if ( distance( var_5, var_0.origin ) < 200 )
        {
            setteamradar( "axis", 1 );
            var_1 = 1;

            foreach ( var_3 in level.players )
                var_3 playlocalsound( "recondrone_tag" );
        }
    }
}

enduavonlatejoiner( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "disconnect" );
    var_0 endon( "eliminated" );

    for (;;)
    {
        if ( level.infect_teamscores["allies"] > 1 )
        {
            level notify( "infect_lateJoiner" );
            wait 0.05;
            setteamradar( "axis", 0 );
            break;
        }

        wait 0.05;
    }
}

monitordisconnect()
{
    level endon( "game_ended" );
    self endon( "eliminated" );
    self notify( "infect_monitor_disconnect" );
    self endon( "infect_monitor_disconnect" );
    var_0 = self.team;

    if ( !isdefined( var_0 ) && isdefined( self.bot_team ) )
        var_0 = self.bot_team;

    self waittill( "disconnect" );
    updateteamscores();

    if ( isdefined( self.infect_isbeingchosen ) || level.infect_chosefirstinfected )
    {
        if ( level.infect_teamscores["axis"] && level.infect_teamscores["allies"] )
        {
            if ( var_0 == "allies" && level.infect_teamscores["allies"] == 1 )
                onfinalsurvivor();
            else if ( var_0 == "axis" && level.infect_teamscores["axis"] == 1 )
            {
                foreach ( var_2 in level.players )
                {
                    if ( var_2 != self && var_2.team == "axis" )
                        var_2 setfirstinfected( 0 );
                }
            }
        }
        else if ( level.infect_teamscores["allies"] == 0 )
            onsurvivorseliminated();
        else if ( level.infect_teamscores["axis"] == 0 )
        {
            if ( level.infect_teamscores["allies"] == 1 )
            {
                level.finalkillcam_winner = "allies";
                level thread maps\mp\gametypes\_gamelogic::endgame( "allies", game["end_reason"]["infected_eliminated"] );
            }
            else if ( level.infect_teamscores["allies"] > 1 )
            {
                level.infect_chosefirstinfected = 0;
                level thread choosefirstinfected();
            }
        }
    }
    else if ( level.infect_countdowninprogress && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0 )
    {
        level notify( "infect_stopCountdown" );
        level.infect_choosingfirstinfected = 0;
        setomnvar( "ui_match_start_countdown", 0 );
    }

    self.isinitialinfected = undefined;
}

ondeadevent( var_0 )
{
    return;
}

ontimelimit()
{
    level.finalkillcam_winner = "allies";
    level thread maps\mp\gametypes\_gamelogic::endgame( "allies", game["end_reason"]["time_limit_reached"] );
}

onsurvivorseliminated()
{
    level.finalkillcam_winner = "axis";
    level thread maps\mp\gametypes\_gamelogic::endgame( "axis", game["end_reason"]["survivors_eliminated"] );
}

getteamsize( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( var_3.sessionstate == "spectator" && !var_3.spectatekillcam )
            continue;

        if ( var_3.team == var_0 )
            var_1++;
    }

    return var_1;
}

updateteamscores()
{
    level.infect_teamscores["allies"] = getteamsize( "allies" );
    game["teamScores"]["allies"] = level.infect_teamscores["allies"];
    setteamscore( "allies", level.infect_teamscores["allies"] );
    level.infect_teamscores["axis"] = getteamsize( "axis" );
    game["teamScores"]["axis"] = level.infect_teamscores["axis"];
    setteamscore( "axis", level.infect_teamscores["axis"] );
}

setspecialloadouts()
{
    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", "allies", 0, "class", "inUse" ) )
        level.infect_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass( "allies", 0 );
    else if ( level.rankedmatch )
    {
        level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
        var_0 = [];
        var_0[0] = "iw5_maul";
        var_0[1] = "iw5_uts19";
        var_0[2] = "iw5_m182spr";
        var_0[3] = "iw5_arx160";
        var_0[4] = "iw5_hmr9";
        var_0[5] = "iw5_sn6";
        var_0[6] = "iw5_em1";
        var_0[7] = "iw5_epm3";
        level.infect_loadouts["allies"]["loadoutPrimary"] = var_0[randomint( var_0.size )];
        level.infect_loadouts["allies"]["loadoutPerks"][4] = "specialty_class_scavenger";
        level.infect_loadouts["allies"]["loadoutEquipment"] = "explosive_drone_mp";
        level.infect_loadouts["allies"]["loadoutEquipmentExtra"] = 1;
        level.infect_loadouts["allies"]["loadoutOffhand"] = "exoshield_equipment_mp";
    }
    else
    {
        level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
        level.infect_loadouts["allies"]["loadoutPrimary"] = "iw5_maul";
        level.infect_loadouts["allies"]["loadoutPerks"][4] = "specialty_class_scavenger";
        level.infect_loadouts["allies"]["loadoutEquipment"] = "explosive_drone_mp";
        level.infect_loadouts["allies"]["loadoutEquipmentExtra"] = 1;
        level.infect_loadouts["allies"]["loadoutOffhand"] = "exoshield_equipment_mp";
    }

    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", "axis", 1, "class", "inUse" ) )
        level.infect_loadouts["axis_initial"] = maps\mp\_utility::getmatchrulesspecialclass( "axis", 1 );
    else
    {
        level.infect_loadouts["axis_initial"] = maps\mp\gametypes\_class::getemptyloadout();
        level.infect_loadouts["axis_initial"]["loadoutPrimary"] = "iw5_rw1";
        level.infect_loadouts["axis_initial"]["loadoutEquipment"] = "exoknife_mp";
        level.infect_loadouts["axis_initial"]["loadoutOffhand"] = "s1_tactical_insertion_device_mp";
        level.infect_loadouts["axis_initial"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
    }

    if ( isusingmatchrulesdata() && getmatchrulesdata( "defaultClasses", "axis", 0, "class", "inUse" ) )
        level.infect_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass( "axis", 0 );
    else
    {
        level.infect_loadouts["axis"] = maps\mp\gametypes\_class::getemptyloadout();
        level.infect_loadouts["axis"]["loadoutPrimary"] = "iw5_combatknife";
        level.infect_loadouts["axis"]["loadoutEquipment"] = "exoknife_mp";
        level.infect_loadouts["axis"]["loadoutOffhand"] = "s1_tactical_insertion_device_mp";
        level.infect_loadouts["axis"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
    }
}

monitorsurvivaltime()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "infected" );
    level endon( "game_ended" );
    var_0 = 0;

    for (;;)
    {
        if ( !level.infect_chosefirstinfected || !isdefined( self.survivalstarttime ) || !isalive( self ) )
        {
            wait 0.05;
            continue;
        }

        setsurvivaltime( 0 );
        var_0++;
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 1.0 );

        if ( var_0 == 30 )
        {
            thread maps\mp\_events::survivorevent();
            var_0 = 0;
        }
    }
}

clearsurvivaltime()
{
    maps\mp\_utility::setextrascore0( 0 );
    self notify( "infected" );
    maps\mp\_utility::setextrascore1( 1 );
}

setsurvivaltime( var_0 )
{
    if ( !isdefined( self.survivalstarttime ) )
        self.survivalstarttime = self.spawntime;

    var_1 = int( ( gettime() - self.survivalstarttime ) / 1000 );

    if ( var_1 > 999 )
        var_1 = 999;

    maps\mp\_utility::setextrascore0( var_1 );

    if ( isdefined( var_0 ) && var_0 )
    {
        self notify( "infected" );
        maps\mp\_utility::setextrascore1( 1 );
    }
}
