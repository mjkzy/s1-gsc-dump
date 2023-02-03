// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

isswitchingteams()
{
    if ( isdefined( self.switching_teams ) )
        return 1;

    return 0;
}

isteamswitchbalanced()
{
    var_0 = maps\mp\gametypes\_teams::countplayers();
    var_0[self.leaving_team]--;
    var_0[self.joining_team]++;
    return var_0[self.joining_team] - var_0[self.leaving_team] < 2;
}

isfriendlyfire( var_0, var_1 )
{
    if ( !level.teambased )
        return 0;

    if ( !isdefined( var_1 ) )
        return 0;

    if ( !isplayer( var_1 ) && !isdefined( var_1.team ) )
        return 0;

    if ( var_0.team != var_1.team )
        return 0;

    if ( var_0 == var_1 )
        return 0;

    return 1;
}

killedself( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( var_0 != self )
        return 0;

    return 1;
}

handleteamchangedeath()
{
    if ( !level.teambased )
        return;

    if ( self.joining_team == "spectator" || !isteamswitchbalanced() )
    {
        self thread [[ level.onxpevent ]]( "suicide" );
        maps\mp\_utility::incpersstat( "suicides", 1 );
        self.suicides = maps\mp\_utility::getpersstat( "suicides" );
    }
}

handleworlddeath( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.team ) )
    {
        handlesuicidedeath( var_2, var_3 );
        return;
    }

    if ( level.teambased && var_0.team != self.team || !level.teambased )
    {
        if ( isdefined( level.onnormaldeath ) && ( isplayer( var_0 ) || isagent( var_0 ) ) && var_0.team != "spectator" )
            [[ level.onnormaldeath ]]( self, var_0, var_1 );
    }
}

givescoreloss( var_0 )
{
    var_1 = int( max( 0, maps\mp\gametypes\_gamescore::_getplayerscore( self ) - var_0 ) );
    maps\mp\gametypes\_gamescore::_setplayerscore( self, var_1 );
}

handlesuicidedeath( var_0, var_1 )
{
    self thread [[ level.onxpevent ]]( "suicide" );
    maps\mp\_utility::incpersstat( "suicides", 1 );
    self.suicides = maps\mp\_utility::getpersstat( "suicides" );

    if ( !maps\mp\_utility::privatematch() && self.suicides == 15 )
        thread delayedsuicidekick();

    var_2 = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "suicidepointloss" );
    givescoreloss( var_2 );

    if ( var_0 == "MOD_SUICIDE" && var_1 == "none" && isdefined( self.throwinggrenade ) )
        self.lastgrenadesuicidetime = gettime();

    if ( isdefined( level.onsuicidedeath ) )
        [[ level.onsuicidedeath ]]( self );

    if ( isdefined( self.friendlydamage ) )
        self iprintlnbold( &"MP_FRIENDLY_FIRE_WILL_NOT" );

    self.pers["suicideSpawnDelay"] = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "suicidespawndelay" );
}

delayedsuicidekick()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait(randomintrange( 1, 60 ));
    kick( self getentitynumber() );
}

handlefriendlyfiredeath( var_0 )
{
    var_0 thread [[ level.onxpevent ]]( "teamkill" );
    var_0.pers["teamkills"] += 1.0;
    var_0.pers["totalTeamKills"] += 1.0;
    var_0.teamkillsthisround++;

    if ( maps\mp\gametypes\_tweakables::gettweakablevalue( "team", "teamkillpointloss" ) )
    {
        var_1 = maps\mp\gametypes\_rank::getscoreinfovalue( "kill" );
        var_0 givescoreloss( var_1 );
    }

    var_2 = var_0 maps\mp\gametypes\_playerlogic::teamkilldelay();

    if ( var_2 > 0 )
    {
        var_0.pers["teamKillPunish"] = 1;
        var_0 maps\mp\_utility::_suicide();
    }

    var_3 = maps\mp\gametypes\_tweakables::gettweakablevalue( "team", "teamkillkicklimit" );

    if ( var_3 > 0 )
    {
        var_4 = var_0.pers["totalTeamKills"];

        if ( var_4 >= var_3 )
            thread friendlyfirekick( var_0 );
    }
}

friendlyfirekick( var_0 )
{
    waittillframeend;
    kick( var_0 getentitynumber(), "EXE_PLAYERKICKED_TEAMKILL" );
    level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

handlenormaldeath( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 thread maps\mp\_events::killedplayer( var_0, self, var_3, var_4, var_2 );
    var_1 killnotification();

    if ( var_4 == "MOD_HEAD_SHOT" )
    {
        var_1 playlocalsound( "mp_headshot_killer" );
        self playsound( "mp_headshot_killed" );
    }

    var_1 thread maps\mp\_events::killedplayerevent( self, var_3, var_4 );
    var_5 = var_1.pers["cur_kill_streak"];

    if ( isalive( var_1 ) )
    {
        if ( maps\mp\_utility::ismeleemod( var_4 ) && !var_1 maps\mp\_utility::isjuggernaut() || var_1 maps\mp\_utility::killshouldaddtokillstreak( var_3 ) )
        {
            var_1.pers["cur_kill_streak"]++;
            var_1.killstreakcount = var_1.pers["cur_kill_streak"];
            var_1 notify( "kill_streak_increased" );

            if ( !maps\mp\_utility::iskillstreakweapon( var_3 ) )
                var_1.pers["cur_kill_streak_for_nuke"]++;

            var_6 = 30;

            if ( var_1 maps\mp\_utility::_hasperk( "specialty_hardline" ) )
                var_6--;

            if ( !maps\mp\_utility::iskillstreakweapon( var_3 ) && var_1.pers["cur_kill_streak_for_nuke"] == var_6 )
            {
                var_7 = var_1 maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex( "nuke", 0 );
                var_1 thread maps\mp\killstreaks\_killstreaks::givekillstreak( "nuke", 0, 1, var_1 );
                var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( "nuke", var_6, undefined, undefined, var_7 );
            }
        }

        var_1 maps\mp\_utility::setplayerstatifgreater( "longestkillstreak", var_1.pers["cur_kill_streak"] );

        if ( var_1.pers["cur_kill_streak"] > var_1 maps\mp\_utility::getpersstat( "longestStreak" ) )
            var_1 maps\mp\_utility::setpersstat( "longestStreak", var_1.pers["cur_kill_streak"] );
    }

    var_1.pers["cur_death_streak"] = 0;

    if ( var_1.pers["cur_kill_streak"] > var_1 maps\mp\gametypes\_persistence::statgetchild( "round", "killStreak" ) )
        var_1 maps\mp\gametypes\_persistence::statsetchild( "round", "killStreak", var_1.pers["cur_kill_streak"] );

    if ( var_1 maps\mp\_utility::rankingenabled() )
    {
        if ( var_1.pers["cur_kill_streak"] > var_1.kill_streak )
        {
            var_1 maps\mp\gametypes\_persistence::statset( "killStreak", var_1.pers["cur_kill_streak"] );
            var_1.kill_streak = var_1.pers["cur_kill_streak"];
        }
    }

    var_8 = maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "deathpointloss" );
    givescoreloss( var_8 );
    level notify( "player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1 );
    var_1 notify( "got_killstreak", var_1.pers["cur_kill_streak"] );
    var_1 notify( "killed_enemy" );

    if ( isdefined( level.onnormaldeath ) && var_1.pers["team"] != "spectator" )
        [[ level.onnormaldeath ]]( self, var_1, var_0 );

    if ( !level.teambased )
    {
        self.attackers = [];
        return;
    }

    level thread maps\mp\gametypes\_battlechatter_mp::saylocalsounddelayed( var_1, "kill", 0.75 );

    if ( isdefined( self.lastattackedshieldplayer ) && isdefined( self.lastattackedshieldtime ) && self.lastattackedshieldplayer != var_1 )
    {
        if ( gettime() - self.lastattackedshieldtime < 5000 )
            self.lastattackedshieldplayer thread maps\mp\_events::processassistevent( self, "assist_riot_shield" );
    }

    if ( !maps\mp\_utility::iskillstreakweapon( var_3 ) )
    {
        if ( isdefined( self.is_being_tracked ) && self.is_being_tracked && isdefined( self.trackedbyplayer ) )
        {
            if ( self.trackedbyplayer != var_1 )
                self.trackedbyplayer thread maps\mp\killstreaks\_marking_util::playerprocesstaggedassist( self );
        }

        var_9 = [];

        foreach ( var_11 in level.uavmodels[var_1.team] )
        {
            if ( !isdefined( var_11.owner ) || var_11.owner == var_1 )
                continue;

            if ( common_scripts\utility::array_contains( var_9, var_11.owner ) )
                continue;

            var_9[var_9.size] = var_11.owner;

            if ( var_11.assistpoints )
                var_11.owner thread maps\mp\_events::processassistevent( self, "assist_uav_plus" );
            else
                var_11.owner thread maps\mp\_events::processassistevent( self, "assist_uav" );

            var_11.owner thread maps\mp\gametypes\_missions::processchallenge( "ch_streak_uav" );
        }
    }

    if ( isdefined( self.tagmarkedby ) )
        self.tagmarkedby = undefined;

    if ( level.teambased && level.teamemped[self.team] || !level.teambased && isdefined( level.empplayer ) && level.empplayer != self )
    {
        if ( isdefined( level.empowner ) && level.empassistpoints && level.empowner != var_1 )
            level.empowner thread maps\mp\_events::processassistevent( self, "assist_emp" );
    }

    if ( isdefined( self.attackers ) )
    {
        foreach ( var_14 in self.attackers )
        {
            if ( !isdefined( maps\mp\_utility::_validateattacker( var_14 ) ) )
                continue;

            if ( var_14 == var_1 )
                continue;

            if ( self == var_14 )
                continue;

            var_14 thread maps\mp\_events::processassistevent( self );
        }

        self.attackers = [];
    }
}

isplayerweapon( var_0 )
{
    if ( weaponclass( var_0 ) == "non-player" )
        return 0;

    if ( weaponclass( var_0 ) == "turret" )
        return 0;

    if ( weaponinventorytype( var_0 ) == "primary" || weaponinventorytype( var_0 ) == "altmode" )
        return 1;

    return 0;
}

callback_playerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    playerkilled_internal( var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
}

callback_playergrenadesuicide( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_8 = 0;

        if ( level.players.size > 1 )
            var_8 = 1;
        else if ( self.hasselfrevive )
            var_8 = 1;

        if ( var_8 )
            var_0 laststanddie();

        [[ level.callbackplayerlaststand ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0 );
    }
}

callback_entityoutofworld()
{
    self delete();
}

launchshield( var_0, var_1 )
{
    self refreshshieldmodels();
    maps\mp\_riotshield::riotshield_clear();
}

playerkilled_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_2 endon( "spawned" );
    var_2 notify( "killed_player" );

    if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_1.exo_ping_on ) && var_1.exo_ping_on == 1 )
        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_exoability_ping" );

    if ( isdefined( var_2.prekilledfunc ) )
        var_2 [[ var_2.prekilledfunc ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

    var_2 maps\mp\gametypes\_playerlogic::resetuidvarsondeath();
    var_2.abilitychosen = 0;
    var_2.perkoutlined = 0;
    var_2.sensoroutlined = 0;
    var_1 = maps\mp\_utility::_validateattacker( var_1 );

    if ( isdefined( var_1 ) )
        var_1.assistedsuicide = undefined;

    if ( !isdefined( var_2.idflags ) )
    {
        if ( var_4 == "MOD_SUICIDE" )
            var_2.idflags = 0;
        else if ( var_4 == "MOD_GRENADE" )
        {
            if ( ( issubstr( var_5, "frag_grenade" ) || issubstr( var_5, "thermobaric_grenade" ) ) && var_3 == 100000 )
                var_2.idflags = 0;
            else if ( var_5 == "nuke_mp" )
                var_2.idflags = 0;
            else if ( level.friendlyfire >= 2 )
                var_2.idflags = 0;
            else
            {

            }
        }
    }

    if ( var_2 maps\mp\_riotshield::hasriotshieldequipped() )
        var_2 launchshield( var_3, var_4 );

    var_11 = maps\mp\_utility::ismeleemod( var_4 ) && ( issubstr( var_5, "knife" ) || issubstr( var_5, "tactical" ) );
    var_11 = var_11 || var_5 == maps\mp\_grappling_hook::get_grappling_hook_weapon();

    if ( var_11 )
    {
        if ( isdefined( common_scripts\utility::getfx( "exo_knife_blood" ) ) )
        {
            if ( isdefined( var_7 ) && isdefined( var_6 ) && isdefined( gethitloctag( var_7 ) ) )
                playimpactheadfatalfx( var_2 gettagorigin( gethitloctag( var_7 ) ), var_6 );
            else
                playimpactheadfatalfx( var_2 gettagorigin( "j_neck" ), anglestoforward( var_2 gettagangles( "j_neck" ) ) );
        }
    }

    maps\mp\gametypes\_weapons::recordtogglescopestates();

    if ( !var_10 )
    {
        if ( isdefined( var_2.endgame ) )
            maps\mp\_utility::revertvisionsetforplayer( 2 );
        else
        {
            maps\mp\_utility::revertvisionsetforplayer( 0 );
            var_2 thermalvisionoff();
        }
    }
    else
    {
        var_2.fauxdead = 1;
        self notify( "death", var_1, var_4, var_5 );
    }

    if ( game["state"] == "postgame" )
        return;

    var_12 = 0;

    if ( !isplayer( var_0 ) && isdefined( var_0.primaryweapon ) )
        var_13 = var_0.primaryweapon;
    else if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
        var_13 = var_1 getcurrentprimaryweapon();
    else if ( issubstr( var_5, "alt_" ) )
        var_13 = getsubstr( var_5, 4, var_5.size );
    else
        var_13 = undefined;

    if ( isdefined( var_2.uselaststandparams ) || isdefined( var_2.laststandparams ) && var_4 == "MOD_SUICIDE" )
    {
        var_2 ensurelaststandparamsvalidity();
        var_2.uselaststandparams = undefined;
        var_0 = var_2.laststandparams.einflictor;
        var_1 = maps\mp\_utility::_validateattacker( var_2.laststandparams.attacker );
        var_3 = var_2.laststandparams.idamage;
        var_4 = var_2.laststandparams.smeansofdeath;
        var_5 = var_2.laststandparams.sweapon;
        var_13 = var_2.laststandparams.sprimaryweapon;
        var_6 = var_2.laststandparams.vdir;
        var_7 = var_2.laststandparams.shitloc;
        var_12 = ( gettime() - var_2.laststandparams.laststandstarttime ) / 1000;
        var_2.laststandparams = undefined;
    }

    if ( ( !isdefined( var_1 ) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1.classname == "script_model" && ( isdefined( var_1.isenvironmentweapon ) && var_1.isenvironmentweapon == 1 ) || var_1 == var_2 ) && isdefined( self.attackers ) )
    {
        var_14 = undefined;

        foreach ( var_16 in self.attackers )
        {
            if ( !isdefined( maps\mp\_utility::_validateattacker( var_16 ) ) )
                continue;

            if ( !isdefined( var_2.attackerdata[var_16.guid].damage ) )
                continue;

            if ( var_16 == var_2 || level.teambased && var_16.team == var_2.team )
                continue;

            if ( var_2.attackerdata[var_16.guid].lasttimedamaged + 2500 < gettime() && ( var_1 != var_2 && ( isdefined( var_2.laststand ) && var_2.laststand ) ) )
                continue;

            if ( var_2.attackerdata[var_16.guid].damage > 1 && !isdefined( var_14 ) )
            {
                var_14 = var_16;
                continue;
            }

            if ( isdefined( var_14 ) && var_2.attackerdata[var_16.guid].damage > var_2.attackerdata[var_14.guid].damage )
                var_14 = var_16;
        }

        if ( isdefined( var_14 ) )
        {
            var_1 = var_14;
            var_1.assistedsuicide = 1;
            var_5 = var_2.attackerdata[var_14.guid].weapon;
            var_6 = var_2.attackerdata[var_14.guid].vdir;
            var_7 = var_2.attackerdata[var_14.guid].shitloc;
            var_8 = var_2.attackerdata[var_14.guid].psoffsettime;
            var_4 = var_2.attackerdata[var_14.guid].smeansofdeath;
            var_3 = var_2.attackerdata[var_14.guid].damage;
            var_13 = var_2.attackerdata[var_14.guid].sprimaryweapon;
            var_0 = var_1;
        }
    }
    else if ( isdefined( var_1 ) )
        var_1.assistedsuicide = undefined;

    if ( maps\mp\_utility::isheadshot( var_5, var_7, var_4, var_1 ) )
        var_4 = "MOD_HEAD_SHOT";
    else if ( !maps\mp\_utility::ismeleemod( var_4 ) && !isdefined( var_2.nuked ) )
        var_2 maps\mp\_utility::playdeathsound();

    var_18 = isfriendlyfire( var_2, var_1 );

    if ( isdefined( var_1 ) )
    {
        if ( var_1.code_classname == "script_vehicle" && isdefined( var_1.owner ) )
            var_1 = var_1.owner;

        if ( var_1.code_classname == "misc_turret" && isdefined( var_1.owner ) )
        {
            if ( isdefined( var_1.vehicle ) )
                var_1.vehicle notify( "killedPlayer", var_2 );

            var_1 = var_1.owner;
        }

        if ( isagent( var_1 ) && isdefined( var_1.owner ) )
        {
            var_1 = var_1.owner;
            var_5 = "agent_mp";
            var_4 = "MOD_RIFLE_BULLET";
        }

        if ( var_1.code_classname == "script_model" && isdefined( var_1.owner ) )
        {
            var_1 = var_1.owner;

            if ( !isfriendlyfire( var_2, var_1 ) && var_1 != var_2 )
                var_1 notify( "crushed_enemy" );
        }
    }

    if ( var_4 != "MOD_SUICIDE" && ( maps\mp\_utility::isaigameparticipant( var_2 ) || maps\mp\_utility::isaigameparticipant( var_1 ) ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["get_attacker_ent"] ) )
    {
        var_19 = [[ level.bot_funcs["get_attacker_ent"] ]]( var_1, var_0 );

        if ( isdefined( var_19 ) )
        {
            if ( maps\mp\_utility::isaigameparticipant( var_2 ) )
                var_2 botmemoryevent( "death", var_5, var_19.origin, var_2.origin, var_19 );

            if ( maps\mp\_utility::isaigameparticipant( var_1 ) )
            {
                var_20 = 1;

                if ( var_19.classname == "script_vehicle" && isdefined( var_19.helitype ) || var_19.classname == "rocket" || var_19.classname == "misc_turret" )
                    var_20 = 0;

                if ( var_20 )
                    var_1 botmemoryevent( "kill", var_5, var_19.origin, var_2.origin, var_2 );
            }
        }
    }

    var_21 = var_2 getcurrentweapon();
    var_2 thread maps\mp\gametypes\_weapons::dropscavengerfordeath( var_1 );

    if ( !isdefined( var_2.agentbody ) )
        var_2 thread [[ level.weapondropfunction ]]( var_1, var_4 );
    else
        var_2.agentbody thread [[ level.weapondropfunction ]]( var_1, var_4 );

    if ( !var_10 )
        var_2 maps\mp\_utility::updatesessionstate( "dead" );

    var_22 = isdefined( var_2.fauxdead ) && var_2.fauxdead && isdefined( var_2.switching_teams ) && var_2.switching_teams;

    if ( !var_22 )
        var_2 maps\mp\gametypes\_playerlogic::removefromalivecount();

    if ( !isdefined( var_2.switching_teams ) && !( isdefined( level.iszombiegame ) && level.iszombiegame ) )
    {
        var_23 = var_2;

        if ( isdefined( var_2.commanding_bot ) )
            var_23 = var_2.commanding_bot;

        var_23 maps\mp\_utility::incpersstat( "deaths", 1 );
        var_23.deaths = var_23 maps\mp\_utility::getpersstat( "deaths" );
        var_23 maps\mp\_utility::updatepersratio( "kdRatio", "kills", "deaths" );
        var_23 maps\mp\gametypes\_persistence::statsetchild( "round", "deaths", var_23.deaths );
        var_23 maps\mp\_utility::incplayerstat( "deaths", 1 );
    }

    if ( !maps\mp\_utility::practiceroundgame() )
        obituary( var_2, var_1, var_5, var_4 );

    var_24 = 0;
    var_2 logprintplayerdeath( self.lifeid, var_1, var_3, var_4, var_5, var_13, var_7 );
    var_2 maps\mp\_matchdata::logplayerlife( 1 );
    var_2 maps\mp\_matchdata::logplayerdeath( self.lifeid, var_1, var_3, var_4, var_5, var_13, var_7, var_21 );

    if ( maps\mp\_utility::ismeleemod( var_4 ) && isplayer( var_1 ) && !issubstr( var_5, "riotshield" ) )
        var_1 maps\mp\_utility::incplayerstat( "knifekills", 1 );

    if ( var_2 isswitchingteams() )
        handleteamchangedeath();
    else if ( !isplayer( var_1 ) || isplayer( var_1 ) && var_4 == "MOD_FALLING" )
    {
        handleworlddeath( var_1, self.lifeid, var_4, var_7 );

        if ( isagent( var_1 ) )
            var_24 = 1;

        if ( maps\mp\gametypes\_killcam::isworldkillcam( var_0, var_1 ) )
            var_24 = 1;
    }
    else if ( var_1 == var_2 && ( isdefined( var_0 ) && ( !isdefined( var_0.isorbitalcam ) || var_0.isorbitalcam == 0 ) ) )
        handlesuicidedeath( var_4, var_7 );
    else if ( var_18 )
    {
        if ( !isdefined( var_2.nuked ) && ( !isdefined( level.iszombiegame ) || !level.iszombiegame ) )
            handlefriendlyfiredeath( var_1 );
    }
    else
    {
        if ( var_4 == "MOD_GRENADE" && var_0 == var_1 || var_4 == "MOD_IMPACT" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_EXPLOSIVE" )
            addattacker( var_2, var_1, var_0, var_5, var_3, ( 0, 0, 0 ), var_6, var_7, var_8, var_4 );

        var_24 = 1;

        if ( isai( var_2 ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["should_do_killcam"] ) )
            var_24 = var_2 [[ level.bot_funcs["should_do_killcam"] ]]();

        if ( isdefined( var_0 ) && ( !isdefined( var_0.isorbitalcam ) || var_0.isorbitalcam == 0 ) )
        {
            handlenormaldeath( self.lifeid, var_1, var_0, var_5, var_4 );
            var_2 thread maps\mp\gametypes\_missions::playerkilled( var_0, var_1, var_3, var_4, var_5, var_13, var_7, var_1.modifiers );
        }

        var_2.pers["cur_death_streak"]++;

        if ( isplayer( var_1 ) && var_2 maps\mp\_utility::isjuggernaut() )
            var_1 thread maps\mp\_utility::teamplayercardsplash( "callout_killed_juggernaut", var_1 );
    }

    var_25 = 0;
    var_26 = undefined;

    if ( isdefined( self.previousprimary ) )
    {
        var_25 = 1;
        var_26 = self.previousprimary;
        self.previousprimary = undefined;
    }

    if ( isplayer( var_1 ) && var_1 != self && ( !level.teambased || level.teambased && self.team != var_1.team ) )
    {
        if ( var_25 && isdefined( var_26 ) )
            var_27 = var_26;
        else
            var_27 = self.lastdroppableweapon;

        thread maps\mp\gametypes\_gamelogic::trackleaderboarddeathstats( var_27, var_4 );
        var_1 thread maps\mp\gametypes\_gamelogic::trackattackerleaderboarddeathstats( var_5, var_4, var_0 );
    }

    var_2.wasswitchingteamsforonplayerkilled = undefined;

    if ( isdefined( var_2.switching_teams ) )
        var_2.wasswitchingteamsforonplayerkilled = 1;

    var_2 resetplayervariables();
    var_2.lastattacker = var_1;
    var_2.lastinflictor = var_0;

    if ( !isdefined( var_2.agentbody ) )
        var_2.lastdeathpos = var_2.origin;
    else
        var_2.lastdeathpos = var_2.agentbody.origin;

    var_2.deathtime = gettime();
    var_2.wantsafespawn = 0;
    var_2.revived = 0;
    var_2.sameshotdamage = 0;
    var_2 maps\mp\killstreaks\_killstreaks::resetadrenaline( 0 );
    var_28 = maps\mp\_awards::gettotalscore( var_2 ) - var_2.scoreatlifestart;
    var_2 maps\mp\_utility::setplayerstatifgreater( "mostScorePerLife", var_28 );
    var_29 = undefined;

    if ( maps\mp\_utility::isrocketcorpse() )
    {
        var_24 = 1;
        var_10 = 0;
        var_29 = self.killcament;
        self waittill( "final_rocket_corpse_death" );
    }
    else
    {
        if ( var_10 )
        {
            var_24 = 0;

            if ( !isdefined( var_2.agentbody ) )
                var_9 = var_2 playerforcedeathanim( var_0, var_4, var_5, var_7, var_6 );
        }

        if ( isdefined( var_2.hideondeath ) && var_2.hideondeath )
        {
            var_2 playerhide();
            thread maps\mp\gametypes\_deathicons::adddeathicon( var_2, var_2, var_2.team, 5.0, var_1 );
        }
        else if ( !isdefined( var_2.agentbody ) )
        {
            var_2.body = var_2 cloneplayer( var_9 );

            if ( var_10 )
                var_2 playerhide();

            if ( var_2 isonladder() || var_2 ismantling() || !var_2 isonground() || isdefined( var_2.nuked ) )
                var_2.body startragdoll();

            if ( !isdefined( var_2.switching_teams ) )
                thread maps\mp\gametypes\_deathicons::adddeathicon( var_2.body, var_2, var_2.team, 5.0, var_1 );

            thread delaystartragdoll( var_2.body, var_7, var_6, var_5, var_0, var_4 );
        }
        else if ( !isdefined( var_2.switching_teams ) )
            thread maps\mp\gametypes\_deathicons::adddeathicon( var_2.agentbody, var_2, var_2.team, 5.0, var_1 );
    }

    var_2 thread [[ level.onplayerkilled ]]( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self.lifeid );

    if ( isai( var_2 ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs["on_killed"] ) )
        var_2 thread [[ level.bot_funcs["on_killed"] ]]( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self.lifeid );

    if ( maps\mp\_utility::isgameparticipant( var_1 ) )
        var_30 = var_1 getentitynumber();
    else
        var_30 = -1;

    if ( isdefined( level.iszombiegame ) && level.iszombiegame )
        var_30 = -1;

    if ( !isdefined( var_29 ) && isdefined( var_1 ) )
        var_29 = var_2 getkillcamentity( var_1, var_0, var_5 );

    var_31 = -1;
    var_32 = 0;
    var_33 = 0;

    if ( isdefined( var_29 ) )
    {
        var_31 = var_29 getentitynumber();
        var_32 = var_29.birthtime;

        if ( isdefined( var_29.killcamstarttime ) )
        {
            var_32 = var_29.killcamstarttime;
            var_33 = 1;
        }

        if ( !isdefined( var_32 ) )
            var_32 = 0;
    }
    else if ( var_5 == "orbital_laser_fov_mp" && isdefined( var_0 ) && isdefined( var_0.killcamstarttime ) )
    {
        var_32 = var_0.killcamstarttime;
        var_33 = 1;
    }

    if ( isdefined( var_1 ) && isdefined( var_1.lastspawntime ) )
        var_34 = ( gettime() - var_1.lastspawntime ) / 1000.0;
    else
        var_34 = 0;

    if ( var_4 != "MOD_SUICIDE" && !( !isdefined( var_1 ) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2 ) )
        recordfinalkillcam( 5.0, var_2, var_1, var_30, var_31, var_32, var_5, var_12, var_8, var_4, "normal", var_33 );

    if ( maps\mp\gametypes\_killcam::killcamvalid( var_2, var_24 ) )
    {
        var_35 = maps\mp\gametypes\_playerlogic::timeuntilspawn( 1 );
        var_36 = maps\mp\gametypes\_gamelogic::timeuntilroundend();
        var_37 = maps\mp\gametypes\_killcam::killcamtime( var_32, var_5, 0, var_35, var_36, var_33, 0 );
        var_38 = maps\mp\gametypes\_killcam::killcamarchivetime( var_37, var_34, var_12, var_8 / 1000 );
        var_2 maps\mp\gametypes\_killcam::prekillcamnotify( var_0, var_1, var_38, var_21 );
    }
    else if ( maps\mp\_utility::isvalidclass( var_2.class ) )
        var_2 maps\mp\gametypes\_playerlogic::streamclassweapons();

    var_39 = gettime() + 5000;

    if ( !var_10 )
    {
        wait 0.25;
        var_2 thread maps\mp\gametypes\_killcam::cancelkillcamonuse();
        wait 0.25;
        self.respawntimerstarttime = gettime() + 1000;
        var_35 = maps\mp\gametypes\_playerlogic::timeuntilspawn( 1 );

        if ( var_35 < 1 )
            var_35 = 1;

        wait 1.0;

        if ( isdefined( self.streamweapons ) && self.streamweapons.size > 0 )
        {
            while ( maps\mp\gametypes\_killcam::killcamvalid( var_2, var_24 ) && isplayer( self ) && isplayer( var_1 ) && !self hasloadedcustomizationplayerview( var_1, self.streamweapons ) && gettime() < var_39 )
                waitframe();
        }

        var_2 notify( "death_delay_finished" );
    }

    var_40 = ( gettime() - var_2.deathtime ) / 1000;
    self.respawntimerstarttime = gettime();
    var_41 = gettime() >= var_39;

    if ( maps\mp\gametypes\_killcam::killcamvalid( var_2, var_24 ) && !var_41 )
    {
        var_42 = !( maps\mp\_utility::getgametypenumlives() && !var_2.pers["lives"] );
        var_35 = maps\mp\gametypes\_playerlogic::timeuntilspawn( 1 );
        var_43 = var_42 && var_35 <= 0;

        if ( !var_42 )
        {
            var_35 = -1;
            level notify( "player_eliminated", var_2 );
        }

        var_2 maps\mp\gametypes\_killcam::killcam( var_0, var_30, var_31, var_32, var_5, var_40 + var_12, var_8, var_35, maps\mp\gametypes\_gamelogic::timeuntilroundend(), var_1, var_2, var_4, "normal", var_34, var_33 );
    }

    if ( game["state"] != "playing" )
    {
        if ( !level.showingfinalkillcam )
        {
            var_2 maps\mp\_utility::updatesessionstate( "dead" );
            var_2 maps\mp\_utility::clearkillcamstate();
        }

        return;
    }

    var_44 = maps\mp\_utility::getgametypenumlives();
    var_45 = self.pers["lives"];

    if ( self == var_2 && isdefined( var_2.battlebuddy ) && maps\mp\_utility::isreallyalive( var_2.battlebuddy ) && ( !maps\mp\_utility::getgametypenumlives() || self.pers["lives"] ) && !var_2 maps\mp\_utility::isusingremote() )
        maps\mp\gametypes\_battlebuddy::waitforplayerrespawnchoice();

    if ( maps\mp\_utility::isvalidclass( var_2.class ) )
        var_2 thread maps\mp\gametypes\_playerlogic::spawnclient();
}

waittimerforspawn()
{
    self endon( "randomSpawnPressed" );
    self.kc_teamspawntext settext( &"PLATFORM_PRESS_TO_TEAMSPAWN" );
    self.kc_teamspawntext.alpha = 1;
    self.kc_randomspawntext settext( &"PLATFORM_PRESS_TO_RESPAWN" );
    self.kc_randomspawntext.alpha = 1;
    thread waitteamspawnbutton();
    thread waitspawnrandombutton();

    if ( isdefined( self.skippedkillcam ) && self.skippedkillcam )
        var_0 = 8;
    else
        var_0 = 9;

    if ( isdefined( self.timestartedtowait ) )
        var_1 = int( ceil( var_0 - ( gettime() - self.timestartedtowait ) / 1000 ) );
    else
        var_1 = var_0;

    self.partnerspawning = 0;
    wait 0.5;

    for ( var_2 = var_1; var_2 > 0; var_2-- )
    {
        maps\mp\_utility::setlowermessage( "kc_info", &"MP_TIME_TILL_SPAWN", var_1, 1, 1 );
        wait 1;
    }

    self.kc_randomspawntext.alpha = 0;
    self.kc_teamspawntext.alpha = 0;
    maps\mp\_utility::clearlowermessage( "kc_info" );
    self notify( "abort_fireteam_spawn" );
}

waitspawnrandombutton()
{
    self endon( "disconnect" );
    self endon( "abort_fireteam_spawn" );

    while ( self usebuttonpressed() )
        wait 0.05;

    while ( !self usebuttonpressed() )
    {
        wait 0.05;

        if ( !maps\mp\_utility::isreallyalive( self.partner ) )
            break;
    }

    self.partnerspawning = 0;
    self notify( "randomSpawnPressed" );
    self.kc_randomspawntext.alpha = 0;
    self.kc_teamspawntext.alpha = 0;
    maps\mp\_utility::clearlowermessage( "kc_info" );
    self notify( "abort_fireteam_spawn" );
}

waitteamspawnbutton()
{
    self endon( "disconnect" );
    self endon( "abort_fireteam_spawn" );

    while ( self attackbuttonpressed() )
        wait 0.05;

    while ( !self attackbuttonpressed() )
        wait 0.05;

    self.partnerspawning = 1;
    self playlocalsound( "copycat_steal_class" );
    self notify( "teamSpawnPressed" );
    self.kc_randomspawntext.alpha = 0;
    self.kc_teamspawntext.alpha = 0;
}

checkforcebleedout()
{
    if ( level.diehardmode != 1 )
        return 0;

    if ( !maps\mp\_utility::getgametypenumlives() )
        return 0;

    if ( level.livescount[self.team] > 0 )
        return 0;

    foreach ( var_1 in level.players )
    {
        if ( !isalive( var_1 ) )
            continue;

        if ( var_1.team != self.team )
            continue;

        if ( var_1 == self )
            continue;

        if ( !var_1.inlaststand )
            return 0;
    }

    foreach ( var_1 in level.players )
    {
        if ( !isalive( var_1 ) )
            continue;

        if ( var_1.team != self.team )
            continue;

        if ( var_1.inlaststand && var_1 != self )
            var_1 laststandbleedout( 0 );
    }

    return 1;
}

initfinalkillcam()
{
    level.finalkillcam_delay = [];
    level.finalkillcam_victim = [];
    level.finalkillcam_attacker = [];
    level.finalkillcam_attackernum = [];
    level.finalkillcam_killcamentityindex = [];
    level.finalkillcam_killcamentitystarttime = [];
    level.finalkillcam_sweapon = [];
    level.finalkillcam_deathtimeoffset = [];
    level.finalkillcam_psoffsettime = [];
    level.finalkillcam_timerecorded = [];
    level.finalkillcam_timegameended = [];
    level.finalkillcam_smeansofdeath = [];
    level.finalkillcam_type = [];
    level.finalkillcam_usestarttime = [];

    if ( level.multiteambased )
    {
        foreach ( var_1 in level.teamnamelist )
        {
            level.finalkillcam_delay[var_1] = undefined;
            level.finalkillcam_victim[var_1] = undefined;
            level.finalkillcam_attacker[var_1] = undefined;
            level.finalkillcam_attackernum[var_1] = undefined;
            level.finalkillcam_killcamentityindex[var_1] = undefined;
            level.finalkillcam_killcamentitystarttime[var_1] = undefined;
            level.finalkillcam_sweapon[var_1] = undefined;
            level.finalkillcam_deathtimeoffset[var_1] = undefined;
            level.finalkillcam_psoffsettime[var_1] = undefined;
            level.finalkillcam_timerecorded[var_1] = undefined;
            level.finalkillcam_timegameended[var_1] = undefined;
            level.finalkillcam_smeansofdeath[var_1] = undefined;
            level.finalkillcam_type[var_1] = undefined;
            level.finalkillcam_usestarttime[var_1] = undefined;
        }
    }
    else
    {
        level.finalkillcam_delay["axis"] = undefined;
        level.finalkillcam_victim["axis"] = undefined;
        level.finalkillcam_attacker["axis"] = undefined;
        level.finalkillcam_attackernum["axis"] = undefined;
        level.finalkillcam_killcamentityindex["axis"] = undefined;
        level.finalkillcam_killcamentitystarttime["axis"] = undefined;
        level.finalkillcam_sweapon["axis"] = undefined;
        level.finalkillcam_deathtimeoffset["axis"] = undefined;
        level.finalkillcam_psoffsettime["axis"] = undefined;
        level.finalkillcam_timerecorded["axis"] = undefined;
        level.finalkillcam_timegameended["axis"] = undefined;
        level.finalkillcam_smeansofdeath["axis"] = undefined;
        level.finalkillcam_type["axis"] = undefined;
        level.finalkillcam_usestarttime["axis"] = undefined;
        level.finalkillcam_delay["allies"] = undefined;
        level.finalkillcam_victim["allies"] = undefined;
        level.finalkillcam_attacker["allies"] = undefined;
        level.finalkillcam_attackernum["allies"] = undefined;
        level.finalkillcam_killcamentityindex["allies"] = undefined;
        level.finalkillcam_killcamentitystarttime["allies"] = undefined;
        level.finalkillcam_sweapon["allies"] = undefined;
        level.finalkillcam_deathtimeoffset["allies"] = undefined;
        level.finalkillcam_psoffsettime["allies"] = undefined;
        level.finalkillcam_timerecorded["allies"] = undefined;
        level.finalkillcam_timegameended["allies"] = undefined;
        level.finalkillcam_smeansofdeath["allies"] = undefined;
        level.finalkillcam_type["allies"] = undefined;
        level.finalkillcam_usestarttime["allies"] = undefined;
    }

    level.finalkillcam_delay["none"] = undefined;
    level.finalkillcam_victim["none"] = undefined;
    level.finalkillcam_attacker["none"] = undefined;
    level.finalkillcam_attackernum["none"] = undefined;
    level.finalkillcam_killcamentityindex["none"] = undefined;
    level.finalkillcam_killcamentitystarttime["none"] = undefined;
    level.finalkillcam_sweapon["none"] = undefined;
    level.finalkillcam_deathtimeoffset["none"] = undefined;
    level.finalkillcam_psoffsettime["none"] = undefined;
    level.finalkillcam_timerecorded["none"] = undefined;
    level.finalkillcam_timegameended["none"] = undefined;
    level.finalkillcam_smeansofdeath["none"] = undefined;
    level.finalkillcam_type["none"] = undefined;
    level.finalkillcam_usestarttime["none"] = undefined;
    level.finalkillcam_winner = undefined;
}

recordfinalkillcam( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( level.teambased && isdefined( var_2.team ) )
    {
        level.finalkillcam_delay[var_2.team] = var_0;
        level.finalkillcam_victim[var_2.team] = var_1;
        level.finalkillcam_attacker[var_2.team] = var_2;
        level.finalkillcam_attackernum[var_2.team] = var_3;
        level.finalkillcam_killcamentityindex[var_2.team] = var_4;
        level.finalkillcam_killcamentitystarttime[var_2.team] = var_5;
        level.finalkillcam_sweapon[var_2.team] = var_6;
        level.finalkillcam_deathtimeoffset[var_2.team] = var_7;
        level.finalkillcam_psoffsettime[var_2.team] = var_8;
        level.finalkillcam_timerecorded[var_2.team] = maps\mp\_utility::getsecondspassed();
        level.finalkillcam_timegameended[var_2.team] = maps\mp\_utility::getsecondspassed();
        level.finalkillcam_smeansofdeath[var_2.team] = var_9;
        level.finalkillcam_type[var_2.team] = var_10;
        level.finalkillcam_usestarttime[var_2.team] = isdefined( var_11 ) && var_11;
    }

    level.finalkillcam_delay["none"] = var_0;
    level.finalkillcam_victim["none"] = var_1;
    level.finalkillcam_attacker["none"] = var_2;
    level.finalkillcam_attackernum["none"] = var_3;
    level.finalkillcam_killcamentityindex["none"] = var_4;
    level.finalkillcam_killcamentitystarttime["none"] = var_5;
    level.finalkillcam_sweapon["none"] = var_6;
    level.finalkillcam_deathtimeoffset["none"] = var_7;
    level.finalkillcam_psoffsettime["none"] = var_8;
    level.finalkillcam_timerecorded["none"] = maps\mp\_utility::getsecondspassed();
    level.finalkillcam_timegameended["none"] = maps\mp\_utility::getsecondspassed();
    level.finalkillcam_timegameended["none"] = maps\mp\_utility::getsecondspassed();
    level.finalkillcam_smeansofdeath["none"] = var_9;
    level.finalkillcam_type["none"] = var_10;
    level.finalkillcam_usestarttime["none"] = isdefined( var_11 ) && var_11;
}

erasefinalkillcam()
{
    if ( level.multiteambased )
    {
        for ( var_0 = 0; var_0 < level.teamnamelist.size; var_0++ )
        {
            level.finalkillcam_delay[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_victim[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_attacker[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_attackernum[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_killcamentityindex[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_killcamentitystarttime[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_sweapon[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_deathtimeoffset[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_psoffsettime[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_timerecorded[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_timegameended[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_smeansofdeath[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_type[level.teamnamelist[var_0]] = undefined;
            level.finalkillcam_usestarttime[level.teamnamelist[var_0]] = undefined;
        }
    }
    else
    {
        level.finalkillcam_delay["axis"] = undefined;
        level.finalkillcam_victim["axis"] = undefined;
        level.finalkillcam_attacker["axis"] = undefined;
        level.finalkillcam_attackernum["axis"] = undefined;
        level.finalkillcam_killcamentityindex["axis"] = undefined;
        level.finalkillcam_killcamentitystarttime["axis"] = undefined;
        level.finalkillcam_sweapon["axis"] = undefined;
        level.finalkillcam_deathtimeoffset["axis"] = undefined;
        level.finalkillcam_psoffsettime["axis"] = undefined;
        level.finalkillcam_timerecorded["axis"] = undefined;
        level.finalkillcam_timegameended["axis"] = undefined;
        level.finalkillcam_smeansofdeath["axis"] = undefined;
        level.finalkillcam_type["axis"] = undefined;
        level.finalkillcam_usestarttime["axis"] = undefined;
        level.finalkillcam_delay["allies"] = undefined;
        level.finalkillcam_victim["allies"] = undefined;
        level.finalkillcam_attacker["allies"] = undefined;
        level.finalkillcam_attackernum["allies"] = undefined;
        level.finalkillcam_killcamentityindex["allies"] = undefined;
        level.finalkillcam_killcamentitystarttime["allies"] = undefined;
        level.finalkillcam_sweapon["allies"] = undefined;
        level.finalkillcam_deathtimeoffset["allies"] = undefined;
        level.finalkillcam_psoffsettime["allies"] = undefined;
        level.finalkillcam_timerecorded["allies"] = undefined;
        level.finalkillcam_timegameended["allies"] = undefined;
        level.finalkillcam_smeansofdeath["allies"] = undefined;
        level.finalkillcam_type["allies"] = undefined;
        level.finalkillcam_usestarttime["allies"] = undefined;
    }

    level.finalkillcam_delay["none"] = undefined;
    level.finalkillcam_victim["none"] = undefined;
    level.finalkillcam_attacker["none"] = undefined;
    level.finalkillcam_attackernum["none"] = undefined;
    level.finalkillcam_killcamentityindex["none"] = undefined;
    level.finalkillcam_killcamentitystarttime["none"] = undefined;
    level.finalkillcam_sweapon["none"] = undefined;
    level.finalkillcam_deathtimeoffset["none"] = undefined;
    level.finalkillcam_psoffsettime["none"] = undefined;
    level.finalkillcam_timerecorded["none"] = undefined;
    level.finalkillcam_timegameended["none"] = undefined;
    level.finalkillcam_smeansofdeath["none"] = undefined;
    level.finalkillcam_type["none"] = undefined;
    level.finalkillcam_usestarttime["none"] = undefined;
    level.finalkillcam_winner = undefined;
}

streamfinalkillcam()
{
    if ( isai( self ) )
        return;

    var_0 = "none";

    if ( isdefined( level.finalkillcam_winner ) )
        var_0 = level.finalkillcam_winner;

    var_1 = level.finalkillcam_victim[var_0];
    var_2 = level.finalkillcam_attacker[var_0];
    var_3 = level.finalkillcam_timegameended[var_0];
    var_4 = level.finalkillcam_timerecorded[var_0];

    if ( !finalkillcamvalid( var_1, var_2, var_3, var_4 ) )
        return;

    var_5 = level.finalkillcam_killcamentitystarttime[var_0];
    var_6 = level.finalkillcam_sweapon[var_0];
    var_7 = level.finalkillcam_usestarttime[var_0];
    var_8 = level.finalkillcam_psoffsettime[var_0];
    var_9 = level.finalkillcam_deathtimeoffset[var_0];
    var_10 = ( gettime() - var_1.deathtime ) / 1000;
    var_11 = var_10 + var_9;
    var_12 = maps\mp\gametypes\_killcam::killcamtime( var_5, var_6, var_11, 0, getkillcambuffertime(), var_7, 1 );
    var_13 = var_12 + var_11 + var_8 / 1000;
    self onlystreamactiveweapon( 1 );
    thread maps\mp\gametypes\_killcam::prekillcamnotify( level.finalkillcam_attacker[var_0], level.finalkillcam_attacker[var_0], var_13, "none" );
}

streamcheck( var_0 )
{
    level endon( "stream_end" );

    foreach ( var_2 in level.players )
    {
        if ( isai( var_2 ) )
            continue;

        if ( isdefined( var_2.streamweapons ) && var_2.streamweapons.size > 0 )
        {
            while ( isplayer( var_2 ) && isplayer( var_0 ) && !var_2 hasloadedcustomizationplayerview( var_0, var_2.streamweapons[0] ) )
                waitframe();
        }
    }

    level notify( "stream_end" );
}

resetonlystreamactive()
{
    foreach ( var_1 in level.players )
    {
        if ( !isai( var_1 ) )
            var_1 onlystreamactiveweapon( 0 );
    }
}

streamtimeout( var_0 )
{
    level endon( "stream_end" );
    wait(var_0);
    level notify( "stream_end" );
}

waitforstream( var_0 )
{
    thread streamtimeout( 5.0 );
    streamcheck( var_0 );
}

getkillcambuffertime()
{
    return 15;
}

finalkillcamvalid( var_0, var_1, var_2, var_3 )
{
    var_4 = isdefined( var_0 ) && isdefined( var_1 ) && !maps\mp\_utility::practiceroundgame();

    if ( var_4 )
    {
        var_5 = getkillcambuffertime();
        var_6 = var_2 - var_3;

        if ( var_6 <= var_5 )
            return 1;
    }

    return 0;
}

endfinalkillcam()
{
    resetonlystreamactive();
    level.showingfinalkillcam = 0;
    level notify( "final_killcam_done" );
}

dofinalkillcam()
{
    level waittill( "round_end_finished" );
    level.showingfinalkillcam = 1;
    var_0 = "none";

    if ( isdefined( level.finalkillcam_winner ) )
        var_0 = level.finalkillcam_winner;

    var_1 = level.finalkillcam_delay[var_0];
    var_2 = level.finalkillcam_victim[var_0];
    var_3 = level.finalkillcam_attacker[var_0];
    var_4 = level.finalkillcam_attackernum[var_0];
    var_5 = level.finalkillcam_killcamentityindex[var_0];
    var_6 = level.finalkillcam_killcamentitystarttime[var_0];
    var_7 = level.finalkillcam_usestarttime[var_0];
    var_8 = level.finalkillcam_sweapon[var_0];
    var_9 = level.finalkillcam_deathtimeoffset[var_0];
    var_10 = level.finalkillcam_psoffsettime[var_0];
    var_11 = level.finalkillcam_timerecorded[var_0];
    var_12 = level.finalkillcam_timegameended[var_0];
    var_13 = level.finalkillcam_smeansofdeath[var_0];
    var_14 = level.finalkillcam_type[var_0];

    if ( !finalkillcamvalid( var_2, var_3, var_12, var_11 ) )
    {
        endfinalkillcam();
        return;
    }

    if ( isdefined( var_3 ) )
    {
        var_3.finalkill = 1;

        if ( level.gametype == "conf" && isdefined( level.finalkillcam_attacker[var_3.team] ) && level.finalkillcam_attacker[var_3.team] == var_3 )
        {
            var_3 maps\mp\gametypes\_missions::processchallenge( "ch_theedge" );

            if ( isdefined( var_3.modifiers["revenge"] ) )
                var_3 maps\mp\gametypes\_missions::processchallenge( "ch_moneyshot" );

            if ( isdefined( var_3.infinalstand ) && var_3.infinalstand )
                var_3 maps\mp\gametypes\_missions::processchallenge( "ch_lastresort" );

            if ( isdefined( var_2 ) && isdefined( var_2.explosiveinfo ) && isdefined( var_2.explosiveinfo["stickKill"] ) && var_2.explosiveinfo["stickKill"] )
                var_3 maps\mp\gametypes\_missions::processchallenge( "ch_stickman" );

            if ( isdefined( var_2.attackerdata[var_3.guid] ) && isdefined( var_2.attackerdata[var_3.guid].smeansofdeath ) && isdefined( var_2.attackerdata[var_3.guid].weapon ) && issubstr( var_2.attackerdata[var_3.guid].smeansofdeath, "MOD_MELEE" ) && issubstr( var_2.attackerdata[var_3.guid].weapon, "riotshield_mp" ) )
                var_3 maps\mp\gametypes\_missions::processchallenge( "ch_owned" );

            switch ( level.finalkillcam_sweapon[var_3.team] )
            {
                case "artillery_mp":
                    var_3 maps\mp\gametypes\_missions::processchallenge( "ch_finishingtouch" );
                    break;
                case "stealth_bomb_mp":
                    var_3 maps\mp\gametypes\_missions::processchallenge( "ch_technokiller" );
                    break;
                case "sentry_minigun_mp":
                    var_3 maps\mp\gametypes\_missions::processchallenge( "ch_absentee" );
                    break;
                case "ac130_40mm_mp":
                case "ac130_105mm_mp":
                case "ac130_25mm_mp":
                    var_3 maps\mp\gametypes\_missions::processchallenge( "ch_deathfromabove" );
                    break;
                case "remotemissile_projectile_mp":
                    var_3 maps\mp\gametypes\_missions::processchallenge( "ch_dronekiller" );
                    break;
                default:
                    break;
            }
        }
    }

    waitforstream( var_3 );
    var_15 = ( gettime() - var_2.deathtime ) / 1000;

    foreach ( var_17 in level.players )
    {
        var_17 maps\mp\_utility::revertvisionsetforplayer( 0 );
        var_17 setblurforplayer( 0, 0 );
        var_17.killcamentitylookat = var_2 getentitynumber();

        if ( isdefined( var_3 ) && isdefined( var_3.lastspawntime ) )
            var_18 = ( gettime() - var_3.lastspawntime ) / 1000.0;
        else
            var_18 = 0;

        var_17 thread maps\mp\gametypes\_killcam::killcam( var_3, var_4, var_5, var_6, var_8, var_15 + var_9, var_10, 0, getkillcambuffertime(), var_3, var_2, var_13, var_14, var_18, var_7 );
    }

    wait 0.1;

    while ( anyplayersinkillcam() )
        wait 0.05;

    endfinalkillcam();
}

anyplayersinkillcam()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.killcam ) )
            return 1;
    }

    return 0;
}

resetplayervariables()
{
    self.killedplayerscurrent = [];
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    self.pers["cur_kill_streak"] = 0;
    self.pers["cur_kill_streak_for_nuke"] = 0;
    self.killstreakcount = 0;
    maps\mp\gametypes\_gameobjects::detachusemodels();
}

getkillcamentity( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.didturretexplosion ) && var_0.didturretexplosion && isdefined( var_0.turret ) )
    {
        var_0.didturretexplosion = undefined;
        return var_0.turret.killcament;
    }

    switch ( var_2 )
    {
        case "boost_slam_mp":
            return var_1;
        case "iw5_dlcgun12loot6_mp":
        case "remotemissile_projectile_cluster_child_mp":
        case "orbital_carepackage_pod_plane_mp":
        case "refraction_turret_mp":
        case "agent_mp":
        case "stealth_bomb_mp":
        case "artillery_mp":
        case "orbital_carepackage_droppod_mp":
        case "orbital_carepackage_pod_mp":
        case "explosive_drone_mp":
        case "bouncingbetty_mp":
        case "bomb_site_mp":
            return var_1.killcament;
        case "killstreak_laser2_mp":
            if ( isdefined( var_1.samturret ) && isdefined( var_1.samturret.killcament ) )
                return var_1.samturret.killcament;

            break;
        case "ball_drone_projectile_mp":
        case "ball_drone_gun_mp":
            if ( isplayer( var_0 ) && isdefined( var_0.balldrone ) && isdefined( var_0.balldrone.turret ) && isdefined( var_0.balldrone.turret.killcament ) )
                return var_0.balldrone.turret.killcament;

            break;
        case "drone_assault_remote_turret_mp":
        case "ugv_missile_mp":
            if ( isdefined( var_1.killcament ) )
                return var_1.killcament;
            else
                return undefined;
        case "assaultdrone_c4_mp":
            if ( isdefined( var_1.hasaioption ) && var_1.hasaioption )
                return var_1;
            else
                return undefined;
        case "warbird_missile_mp":
        case "dam_turret_mp":
        case "killstreak_solar_mp":
            if ( isdefined( var_1 ) && isdefined( var_1.killcament ) )
                return var_1.killcament;

            break;
        case "warbird_remote_turret_mp":
            if ( isdefined( var_1 ) && isdefined( var_1.killcament ) )
                return var_1.killcament;
            else
                return undefined;
        case "orbital_laser_fov_mp":
            return undefined;
        case "killstreakmahem_mp":
        case "remote_energy_turret_mp":
        case "sentry_minigun_mp":
            if ( isdefined( var_1 ) && isdefined( var_1.remotecontrolled ) )
                return undefined;

            break;
        case "none":
            if ( isdefined( var_1.targetname ) && var_1.targetname == "care_package" )
                return var_1.killcament;

            break;
        case "killstreak_terrace_mp":
        case "detroit_tram_turret_mp":
        case "remote_turret_mp":
        case "ugv_turret_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
        case "ac130_25mm_mp":
            return undefined;
        case "iw5_dlcgun12loot8_mp":
            if ( isdefined( var_1.killcament ) )
                return var_1.killcament;
            else
                return undefined;
    }

    if ( maps\mp\_utility::isdestructibleweapon( var_2 ) || maps\mp\_utility::isbombsiteweapon( var_2 ) )
    {
        if ( isdefined( var_1.killcament ) && !var_0 attackerinremotekillstreak() )
            return var_1.killcament;
        else
            return undefined;
    }

    if ( maps\mp\gametypes\_killcam::isworldkillcam( var_1, var_0 ) )
        return var_0.killcament;

    if ( !isdefined( var_1 ) || var_0 == var_1 && !isagent( var_0 ) )
        return undefined;

    return var_1;
}

attackerinremotekillstreak()
{
    if ( !isdefined( self ) )
        return 0;

    if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && self == level.chopper.gunner )
        return 1;

    if ( isdefined( self.using_remote_turret ) && self.using_remote_turret )
        return 1;

    if ( isdefined( self.using_remote_tank ) && self.using_remote_tank )
        return 1;

    return 0;
}

hitlocdebug( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_5[0] = 2;
    var_5[1] = 3;
    var_5[2] = 5;
    var_5[3] = 7;

    if ( !getdvarint( "scr_hitloc_debug" ) )
        return;

    if ( !isdefined( var_0.hitlocinited ) )
    {
        for ( var_6 = 0; var_6 < 6; var_6++ )
            var_0 setclientdvar( "ui_hitloc_" + var_6, "" );

        var_0.hitlocinited = 1;
    }

    if ( level.splitscreen || !isplayer( var_0 ) )
        return;

    var_7 = 6;

    if ( !isdefined( var_0.damageinfo ) )
    {
        var_0.damageinfo = [];

        for ( var_6 = 0; var_6 < var_7; var_6++ )
        {
            var_0.damageinfo[var_6] = spawnstruct();
            var_0.damageinfo[var_6].damage = 0;
            var_0.damageinfo[var_6].hitloc = "";
            var_0.damageinfo[var_6].bp = 0;
            var_0.damageinfo[var_6].jugg = 0;
            var_0.damageinfo[var_6].colorindex = 0;
        }

        var_0.damageinfocolorindex = 0;
        var_0.damageinfovictim = undefined;
    }

    for ( var_6 = var_7 - 1; var_6 > 0; var_6-- )
    {
        var_0.damageinfo[var_6].damage = var_0.damageinfo[var_6 - 1].damage;
        var_0.damageinfo[var_6].hitloc = var_0.damageinfo[var_6 - 1].hitloc;
        var_0.damageinfo[var_6].bp = var_0.damageinfo[var_6 - 1].bp;
        var_0.damageinfo[var_6].jugg = var_0.damageinfo[var_6 - 1].jugg;
        var_0.damageinfo[var_6].colorindex = var_0.damageinfo[var_6 - 1].colorindex;
    }

    var_0.damageinfo[0].damage = var_2;
    var_0.damageinfo[0].hitloc = var_3;
    var_0.damageinfo[0].bp = var_4 & level.idflags_penetration;
    var_0.damageinfo[0].jugg = var_1 maps\mp\_utility::isjuggernaut();

    if ( isdefined( var_0.damageinfovictim ) && var_0.damageinfovictim != var_1 )
    {
        var_0.damageinfocolorindex++;

        if ( var_0.damageinfocolorindex == var_5.size )
            var_0.damageinfocolorindex = 0;
    }

    var_0.damageinfovictim = var_1;
    var_0.damageinfo[0].colorindex = var_0.damageinfocolorindex;

    for ( var_6 = 0; var_6 < var_7; var_6++ )
    {
        var_8 = "^" + var_5[var_0.damageinfo[var_6].colorindex];

        if ( var_0.damageinfo[var_6].hitloc != "" )
        {
            var_9 = var_8 + var_0.damageinfo[var_6].hitloc;

            if ( var_0.damageinfo[var_6].bp )
                var_9 += " (BP)";

            if ( var_0.damageinfo[var_6].jugg )
                var_9 += " (Jugg)";

            var_0 setclientdvar( "ui_hitloc_" + var_6, var_9 );
        }

        var_0 setclientdvar( "ui_hitloc_damage_" + var_6, var_8 + var_0.damageinfo[var_6].damage );
    }
}

ishardwrireprotected( var_0 )
{
    if ( !maps\mp\_utility::_hasperk( "specialty_stun_resistance" ) )
        return 0;

    switch ( var_0 )
    {
        case "mp_lab_gas":
        case "killstreak_strike_missile_gas_mp":
            return 1;
    }

    return 0;
}

callback_playerdamage_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( getdvarint( "virtuallobbyactive", 0 ) )
        return "virtuallobbyactive";

    var_1 = maps\mp\_utility::_validateattacker( var_1 );
    var_11 = maps\mp\_utility::strip_suffix( var_6, "_lefthand" );

    if ( isdefined( var_5 ) && var_5 == "MOD_CRUSH" && isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "script_vehicle" )
        return "crushed";

    if ( !maps\mp\_utility::isreallyalive( var_2 ) && !isdefined( var_2.inliveplayerkillstreak ) )
        return "!isReallyAlive( victim )";

    if ( isdefined( var_1 ) && var_1.classname == "script_origin" && isdefined( var_1.type ) && var_1.type == "soft_landing" )
        return "soft_landing";

    if ( var_6 == "killstreak_emp_mp" )
        return "sWeapon == killstreak_emp_mp";

    if ( var_2 ishardwrireprotected( var_6 ) )
        return "specialty_stun_resistance";

    if ( ( var_11 == "emp_grenade_mp" || var_11 == "emp_grenade_var_mp" || var_11 == "emp_grenade_killstreak_mp" ) && var_5 != "MOD_IMPACT" )
        var_2 notify( "emp_grenaded", var_1 );

    if ( isdefined( level.hostmigrationtimer ) )
        return "level.hostMigrationTimer";

    if ( var_5 == "MOD_FALLING" )
        var_2 thread emitfalldamage( var_3 );

    if ( var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1 )
    {
        var_3 *= getdvarfloat( "scr_explBulletMod" );
        var_3 = int( var_3 );
    }

    if ( isdefined( var_1 ) && var_1.classname == "worldspawn" )
        var_1 = undefined;

    if ( isdefined( var_1 ) && isdefined( var_1.gunner ) )
        var_1 = var_1.gunner;

    if ( isdefined( var_1 ) && var_1 == var_2 && var_6 == "killstreak_strike_missile_gas_mp" )
        return "gasCloudOwner";

    if ( isdefined( var_1 ) && isplayer( var_1 ) && isexplosivedamagemod( var_5 ) && issubstr( var_6, "explosive_drone" ) && var_2 maps\mp\_utility::_hasperk( "_specialty_blastshield" ) && maps\mp\_utility::isreallyalive( var_2 ) )
        var_2.explosive_drone_owner = var_1;

    var_12 = maps\mp\_utility::attackerishittingteam( var_2, var_1 );
    var_13 = isdefined( var_1 ) && isdefined( var_0 ) && isdefined( var_2 ) && isplayer( var_1 ) && var_1 == var_0 && var_1 == var_2 && !isdefined( var_0.poison );

    if ( var_13 )
        return "attackerIsInflictorVictim";

    var_14 = 0.0;

    if ( var_4 & level.idflags_stun )
    {
        var_14 = 0.0;
        var_3 = 0.0;
    }
    else if ( var_9 == "shield" )
    {
        if ( var_12 && level.friendlyfire == 0 )
            return "attackerIsHittingTeammate";

        if ( var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET" && !var_12 )
        {
            if ( isplayer( var_1 ) )
            {
                var_1.lastattackedshieldplayer = var_2;
                var_1.lastattackedshieldtime = gettime();
            }

            if ( maps\mp\_utility::isenvironmentweapon( var_6 ) )
                var_16 = 25;
            else
                var_16 = maps\mp\perks\_perks::cac_modified_damage( var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9 );

            var_2.shielddamage += var_16;

            if ( !maps\mp\_utility::isenvironmentweapon( var_6 ) || common_scripts\utility::cointoss() )
            {
                var_2.shieldbullethits++;

                if ( isdefined( var_2.pers["bulletsBlockedByShield"] ) )
                    var_2.pers["bulletsBlockedByShield"]++;
            }

            if ( var_2.shieldbullethits >= level.riotshieldxpbullets )
            {
                var_2.shielddamage = 0;
                var_2.shieldbullethits = 0;
            }
        }

        if ( var_4 & level.idflags_shield_explosive_impact )
        {
            var_9 = "none";

            if ( !( var_4 & level.idflags_shield_explosive_impact_huge ) )
                var_3 *= 0.0;
        }
        else if ( var_4 & level.idflags_shield_explosive_splash )
        {
            if ( isdefined( var_0 ) && isdefined( var_0.stuckenemyentity ) && var_0.stuckenemyentity == var_2 )
                var_3 = 51;

            var_9 = "none";
        }
        else
            return "hit shield";
    }
    else if ( maps\mp\_utility::ismeleemod( var_5 ) && issubstr( var_6, "riotshield" ) )
    {
        if ( !( var_12 && level.friendlyfire == 0 ) )
        {
            var_14 = 0.0;
            var_2 stunplayer( 0.0 );
        }
    }

    if ( !var_12 )
        var_3 = maps\mp\perks\_perks::cac_modified_damage( var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0 );

    if ( isdefined( level.modifyplayerdamage ) )
        var_3 = [[ level.modifyplayerdamage ]]( var_2, var_0, var_1, var_3, var_5, var_6, var_7, var_8, var_9 );

    if ( var_2 maps\mp\_utility::isjuggernaut() && !isagent( var_2 ) )
    {
        if ( isdefined( level.customjuggernautdamagefunc ) )
            var_3 = [[ level.customjuggernautdamagefunc ]]( var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0 );
        else
            var_3 = maps\mp\killstreaks\_juggernaut::juggernautmodifydamage( var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0 );
    }

    var_17 = isdefined( var_1 ) && !isdefined( var_1.gunner ) && ( var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model" );
    var_12 = maps\mp\_utility::attackerishittingteam( var_2, var_1 );

    if ( !var_3 )
        return "!iDamage";

    var_2.idflags = var_4;
    var_2.idflagstime = gettime();

    if ( game["state"] == "postgame" )
        return "game[ state ] == postgame";

    if ( var_2.sessionteam == "spectator" )
        return "victim.sessionteam == spectator";

    if ( isdefined( var_2.candocombat ) && !var_2.candocombat )
        return "!victim.canDoCombat";

    if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_1.candocombat ) && !var_1.candocombat )
        return "!eAttacker.canDoCombat";

    if ( isdefined( var_1 ) && isalive( var_1 ) && !isdefined( var_1.perkoutlined ) )
        var_1.perkoutlined = 0;

    if ( var_17 && var_12 )
    {
        if ( var_5 == "MOD_CRUSH" )
        {
            var_2 maps\mp\_utility::_suicide();
            return "suicide crush";
        }

        if ( !level.friendlyfire )
            return "!level.friendlyfire";
    }

    if ( isai( self ) )
        self [[ level.bot_funcs["on_damaged"] ]]( var_1, var_3, var_5, var_6, var_0, var_9 );

    if ( !isdefined( var_8 ) )
        var_4 |= level.idflags_no_knockback;

    var_18 = 0;

    if ( var_2.health == var_2.maxhealth && ( !isdefined( var_2.laststand ) || !var_2.laststand ) || !isdefined( var_2.attackers ) && !isdefined( var_2.laststand ) )
    {
        var_2.attackers = [];
        var_2.attackerdata = [];
    }

    if ( maps\mp\_utility::isheadshot( var_6, var_9, var_5, var_1 ) )
        var_5 = "MOD_HEAD_SHOT";

    if ( maps\mp\gametypes\_tweakables::gettweakablevalue( "game", "onlyheadshots" ) )
    {
        if ( var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET" )
            return "getTweakableValue( game, onlyheadshots )";
        else if ( var_5 == "MOD_HEAD_SHOT" )
        {
            if ( var_2 maps\mp\_utility::isjuggernaut() )
                var_3 = 75;
            else
                var_3 = 150;
        }
    }

    if ( var_6 == "none" && isdefined( var_0 ) )
    {
        if ( isdefined( var_0.destructible_type ) && issubstr( var_0.destructible_type, "vehicle_" ) )
            var_6 = "destructible_car";
    }

    if ( gettime() < var_2.spawntime + level.killstreakspawnshield )
    {
        var_19 = int( max( var_2.health / 4, 1 ) );

        if ( var_3 >= var_19 && maps\mp\_utility::iskillstreakweapon( var_6 ) && !maps\mp\_utility::ismeleemod( var_5 ) )
            var_3 = var_19;
    }

    if ( !( var_4 & level.idflags_no_protection ) )
    {
        if ( !level.teambased && var_17 && isdefined( var_1.owner ) && var_1.owner == var_2 )
        {
            if ( var_5 == "MOD_CRUSH" )
                var_2 maps\mp\_utility::_suicide();

            return "ffa suicide";
        }

        if ( ( issubstr( var_5, "MOD_GRENADE" ) || issubstr( var_5, "MOD_EXPLOSIVE" ) || issubstr( var_5, "MOD_PROJECTILE" ) ) && isdefined( var_0 ) && isdefined( var_1 ) )
        {
            if ( var_2 != var_1 && var_0.classname == "grenade" && var_2.lastspawntime + 3500 > gettime() && isdefined( var_2.lastspawnpoint ) && distance( var_0.origin, var_2.lastspawnpoint.origin ) < 250 )
                return "spawnkill grenade protection";

            var_2.explosiveinfo = [];
            var_2.explosiveinfo["damageTime"] = gettime();
            var_2.explosiveinfo["damageId"] = var_0 getentitynumber();
            var_2.explosiveinfo["returnToSender"] = 0;
            var_2.explosiveinfo["counterKill"] = 0;
            var_2.explosiveinfo["chainKill"] = 0;
            var_2.explosiveinfo["cookedKill"] = 0;
            var_2.explosiveinfo["throwbackKill"] = 0;
            var_2.explosiveinfo["suicideGrenadeKill"] = 0;
            var_2.explosiveinfo["weapon"] = var_6;
            var_20 = issubstr( var_6, "frag_" );

            if ( var_1 != var_2 )
            {
                if ( ( issubstr( var_6, "c4_" ) || issubstr( var_6, "claymore_" ) ) && isdefined( var_1 ) && isdefined( var_0.owner ) )
                {
                    var_2.explosiveinfo["returnToSender"] = var_0.owner == var_2;
                    var_2.explosiveinfo["counterKill"] = isdefined( var_0.wasdamaged );
                    var_2.explosiveinfo["chainKill"] = isdefined( var_0.waschained );
                    var_2.explosiveinfo["bulletPenetrationKill"] = isdefined( var_0.wasdamagedfrombulletpenetration );
                    var_2.explosiveinfo["cookedKill"] = 0;
                }

                if ( isdefined( var_1.lastgrenadesuicidetime ) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_20 )
                    var_2.explosiveinfo["suicideGrenadeKill"] = 1;
            }

            if ( var_20 )
            {
                var_2.explosiveinfo["cookedKill"] = isdefined( var_0.iscooked );
                var_2.explosiveinfo["throwbackKill"] = isdefined( var_0.threwback );
            }

            var_2.explosiveinfo["stickKill"] = isdefined( var_0.isstuck ) && var_0.isstuck == "enemy";
            var_2.explosiveinfo["stickFriendlyKill"] = isdefined( var_0.isstuck ) && var_0.isstuck == "friendly";

            if ( isplayer( var_1 ) && var_1 != self )
                maps\mp\gametypes\_gamelogic::setinflictorstat( var_0, var_1, var_6 );
        }

        if ( issubstr( var_5, "MOD_IMPACT" ) && ( var_6 == "m320_mp" || issubstr( var_6, "gl" ) || issubstr( var_6, "gp25" ) ) )
        {
            if ( isplayer( var_1 ) && var_1 != self )
                maps\mp\gametypes\_gamelogic::setinflictorstat( var_0, var_1, var_6 );
        }

        if ( var_12 )
        {
            if ( level.friendlyfire == 0 || !isplayer( var_1 ) && level.friendlyfire != 1 )
            {
                if ( var_6 == "artillery_mp" || var_6 == "stealth_bomb_mp" )
                    var_2 damageshellshockandrumble( var_0, var_6, var_5, var_3, var_4, var_1 );

                return "friendly fire";
            }
            else if ( level.friendlyfire == 1 )
            {
                if ( var_3 < 1 )
                    var_3 = 1;

                if ( var_2 maps\mp\_utility::isjuggernaut() )
                    var_3 = maps\mp\perks\_perks::cac_modified_damage( var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9 );

                var_2.lastdamagewasfromenemy = 0;
                var_2 finishplayerdamagewrapper( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14 );
            }
            else if ( level.friendlyfire == 2 && maps\mp\_utility::isreallyalive( var_1 ) )
            {
                var_3 = int( var_3 * 0.5 );

                if ( var_3 < 1 )
                    var_3 = 1;

                var_1.lastdamagewasfromenemy = 0;
                var_1.friendlydamage = 1;
                var_1 finishplayerdamagewrapper( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14 );
                var_1.friendlydamage = undefined;
            }
            else if ( level.friendlyfire == 3 && maps\mp\_utility::isreallyalive( var_1 ) )
            {
                var_3 = int( var_3 * 0.5 );

                if ( var_3 < 1 )
                    var_3 = 1;

                var_2.lastdamagewasfromenemy = 0;
                var_1.lastdamagewasfromenemy = 0;
                var_2 finishplayerdamagewrapper( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14 );

                if ( maps\mp\_utility::isreallyalive( var_1 ) )
                {
                    var_1.friendlydamage = 1;
                    var_1 finishplayerdamagewrapper( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14 );
                    var_1.friendlydamage = undefined;
                }
            }

            var_18 = 1;
        }
        else
        {
            if ( var_3 < 1 )
                var_3 = 1;

            if ( isdefined( var_1 ) && isplayer( var_1 ) )
                addattacker( var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5 );

            if ( isdefined( var_1 ) && !isplayer( var_1 ) && isdefined( var_1.owner ) && ( !isdefined( var_1.scrambled ) || !var_1.scrambled ) )
                addattacker( var_2, var_1.owner, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5 );
            else if ( isdefined( var_1 ) && !isplayer( var_1 ) && isdefined( var_1.secondowner ) && isdefined( var_1.scrambled ) && var_1.scrambled )
                addattacker( var_2, var_1.secondowner, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5 );

            if ( var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH" && var_3 < var_2.health )
                var_2 notify( "survived_explosion", var_1 );

            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_6 ) )
                var_1 thread maps\mp\gametypes\_weapons::checkhit( var_6, var_2 );

            var_2.attackerposition = undefined;

            if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( var_6 ) && var_1 != var_2 )
                var_2.attackerposition = var_1.origin;

            if ( issubstr( var_5, "MOD_GRENADE" ) && isdefined( var_0 ) && isdefined( var_0.iscooked ) )
                var_2.wascooked = gettime();
            else
                var_2.wascooked = undefined;

            if ( issubstr( var_5, "MOD_IMPACT" ) && isdefined( var_0 ) && isdefined( var_0.recall ) && var_0.recall )
                var_2.wasrecall = 1;
            else
                var_2.wasrecall = 0;

            var_2.lastdamagewasfromenemy = isdefined( var_1 ) && var_1 != var_2;

            if ( var_2.lastdamagewasfromenemy )
            {
                var_21 = gettime();
                var_1.damagedplayers[var_2.guid] = var_21;
                var_2.lastdamagedtime = var_21;
            }

            var_2 finishplayerdamagewrapper( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14 );
            var_2 thread maps\mp\gametypes\_missions::playerdamaged( var_0, var_1, var_3, var_5, var_6, var_9 );
        }

        if ( var_3 > 0 && var_5 != "MOD_FALLING" )
            var_2 setclientomnvar( "ui_damage_flash", 1 );

        if ( var_17 && isdefined( var_1.gunner ) )
            var_22 = var_1.gunner;
        else
            var_22 = var_1;

        if ( isdefined( var_22 ) && ( var_22 != var_2 || maps\mp\_utility::iskillstreakweapon( var_6 ) ) && var_3 > 0 && ( !isdefined( var_9 ) || var_9 != "shield" ) )
        {
            if ( !maps\mp\_utility::isreallyalive( var_2 ) )
            {
                if ( var_9 == "head" )
                    var_23 = "killshot_headshot";
                else
                    var_23 = "killshot";
            }
            else if ( var_4 & level.idflags_stun )
                var_23 = "stun";
            else if ( var_9 == "head" )
                var_23 = "headshot";
            else if ( isdefined( var_2.exo_health_on ) && var_2.exo_health_on == 1 )
                var_23 = "hitmorehealth";
            else if ( isexplosivedamagemod( var_5 ) && var_2 maps\mp\_utility::_hasperk( "_specialty_blastshield" ) )
                var_23 = "hitblastshield";
            else if ( isdefined( var_2.lightarmorhp ) && var_5 != "MOD_HEAD_SHOT" && !maps\mp\_utility::isfmjdamage( var_6, var_5, var_1 ) )
                var_23 = "hitlightarmor";
            else if ( var_2 maps\mp\_utility::isjuggernaut() )
                var_23 = "hitjuggernaut";
            else if ( !shouldweaponfeedback( var_6 ) )
                var_23 = "none";
            else if ( var_6 == "killstreak_solar_mp" )
                var_23 = "mp_solar";
            else if ( var_6 == "killstreak_laser2_mp" )
                var_23 = "laser";
            else if ( isdefined( var_2.exo_health_on ) && var_2.exo_health_on )
                var_23 = "hitjuggernaut";
            else
                var_23 = "standard";

            var_22 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback( var_23 );
        }

        maps\mp\gametypes\_gamelogic::sethasdonecombat( var_2, 1 );
    }

    if ( isdefined( var_1 ) && var_1 != var_2 && !var_18 )
        level.usestartspawns = 0;

    if ( var_2.sessionstate != "dead" )
    {
        var_24 = var_2 getentitynumber();
        var_25 = var_2.name;
        var_26 = var_2.pers["team"];
        var_27 = var_2.guid;
        var_28 = "";

        if ( isplayer( var_1 ) )
        {
            var_29 = var_1 getentitynumber();
            var_30 = var_1.guid;
            var_31 = var_1.name;
            var_28 = var_1.pers["team"];
        }
        else
        {
            var_29 = -1;
            var_30 = "";
            var_31 = "";
            var_28 = "world";
        }

        if ( isplayer( var_1 ) )
        {
            var_32 = var_1.name;
            var_33 = var_1.origin;
            var_34 = var_1.lifeid;
        }
        else
        {
            var_32 = "world";
            var_33 = var_2.origin;
            var_34 = -1;
        }

        var_35 = gettime();

        if ( !isagent( var_2 ) && isdefined( var_2.spawninfo ) && isdefined( var_2.spawninfo.spawntime ) )
        {
            var_36 = ( var_35 - var_2.spawninfo.spawntime ) / 1000.0;

            if ( var_36 <= 3.0 && var_2.spawninfo.damagereceivedtoofast == 0 )
            {
                if ( !isdefined( level.matchdata ) )
                    level.matchdata = [];

                if ( !isdefined( level.matchdata["badSpawnDmgReceivedCount"] ) )
                    level.matchdata["badSpawnDmgReceivedCount"] = 1;
                else
                    level.matchdata["badSpawnDmgReceivedCount"]++;

                var_2.spawninfo.damagereceivedtoofast = 1;

                if ( var_2.spawninfo.badspawn == 0 )
                {
                    if ( !isdefined( level.matchdata["badSpawnByAnyMeansCount"] ) )
                        level.matchdata["badSpawnByAnyMeansCount"] = 1;
                    else
                        level.matchdata["badSpawnByAnyMeansCount"]++;

                    var_2.spawninfo.badspawn = 1;
                }
            }
        }
        else
            var_36 = -1;

        if ( isdefined( var_1 ) && isdefined( var_1.spawninfo ) && isdefined( var_1.spawninfo.spawntime ) && isplayer( var_1 ) )
        {
            var_37 = ( var_35 - var_1.spawninfo.spawntime ) / 1000.0;

            if ( var_37 <= 3.0 && var_1.spawninfo.damagedealttoofast == 0 )
            {
                if ( !isdefined( level.matchdata ) )
                    level.matchdata = [];

                if ( !isdefined( level.matchdata["badSpawnDmgDealtCount"] ) )
                    level.matchdata["badSpawnDmgDealtCount"] = 1;
                else
                    level.matchdata["badSpawnDmgDealtCount"]++;

                var_1.spawninfo.damagedealttoofast = 1;

                if ( var_1.spawninfo.badspawn == 0 )
                {
                    if ( !isdefined( level.matchdata["badSpawnByAnyMeansCount"] ) )
                        level.matchdata["badSpawnByAnyMeansCount"] = 1;
                    else
                        level.matchdata["badSpawnByAnyMeansCount"]++;

                    var_1.spawninfo.badspawn = 1;
                }
            }
        }
        else
            var_37 = -1;

        if ( !isagent( var_2 ) )
            reconspatialevent( var_2.origin, "script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f", var_2.name, var_2.angles, var_9, var_32, var_33, var_3, var_6, var_5, var_35, var_2.lifeid, var_34, var_36, var_37 );

        logprint( "D;" + var_27 + ";" + var_24 + ";" + var_26 + ";" + var_25 + ";" + var_30 + ";" + var_29 + ";" + var_28 + ";" + var_31 + ";" + var_6 + ";" + var_3 + ";" + var_5 + ";" + var_9 + "\\n" );
    }

    hitlocdebug( var_1, var_2, var_3, var_9, var_4 );

    if ( isagent( self ) )
        self [[ maps\mp\agents\_agent_utility::agentfunc( "on_damaged_finished" ) ]]( var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

    return "finished";
}

shouldweaponfeedback( var_0 )
{
    switch ( var_0 )
    {
        case "stealth_bomb_mp":
        case "artillery_mp":
            return 0;
    }

    return 1;
}

addattacker( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_0.attackerdata ) )
        var_0.attackerdata = [];

    if ( !isdefined( var_0.attackerdata[var_1.guid] ) )
    {
        var_0.attackers[var_1.guid] = var_1;
        var_0.attackerdata[var_1.guid] = spawnstruct();
        var_0.attackerdata[var_1.guid].damage = 0;
        var_0.attackerdata[var_1.guid].attackerent = var_1;
        var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    }

    if ( maps\mp\gametypes\_weapons::isprimaryweapon( var_3 ) && !maps\mp\gametypes\_weapons::issidearm( var_3 ) )
        var_0.attackerdata[var_1.guid].isprimary = 1;

    var_0.attackerdata[var_1.guid].damage += var_4;
    var_0.attackerdata[var_1.guid].weapon = var_3;
    var_0.attackerdata[var_1.guid].vpoint = var_5;
    var_0.attackerdata[var_1.guid].vdir = var_6;
    var_0.attackerdata[var_1.guid].shitloc = var_7;
    var_0.attackerdata[var_1.guid].psoffsettime = var_8;
    var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();

    if ( isdefined( var_2 ) && !isplayer( var_2 ) && isdefined( var_2.primaryweapon ) )
        var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
    else if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
        var_0.attackerdata[var_1.guid].sprimaryweapon = var_1 getcurrentprimaryweapon();
    else
        var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;

    if ( !isdefined( var_0.enemyhitcounts ) )
        var_0.enemyhitcounts = [];

    if ( isplayer( var_1 ) )
    {
        if ( !isdefined( var_0.enemyhitcounts[var_1.guid] ) )
            var_0.enemyhitcounts[var_1.guid] = 0;

        var_0.enemyhitcounts[var_1.guid]++;
        var_0.lastshotby = var_1.clientid;
    }
}

resetattackerlist()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    clearfirefightdata();
    wait 1.75;
    self.attackers = [];
    self.attackerdata = [];
}

clearfirefightdata()
{
    self.enemyhitcounts = [];
    self.currentfirefightshots = 0;
}

clearfirefightshotsoninterval()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 3;

        if ( isdefined( self.enemyhitcounts ) && self.enemyhitcounts.size > 0 )
            continue;
        else
            self.currentfirefightshots = 0;
    }
}

is_countered_by_hardwired( var_0 )
{
    switch ( var_0 )
    {
        case "paint_grenade_var_mp":
        case "emp_grenade_var_mp":
        case "stun_grenade_var_mp":
        case "emp_grenade_mp":
        case "paint_grenade_mp":
        case "stun_grenade_mp":
            return 1;
    }

    return 0;
}

callback_playerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = callback_playerdamage_internal( var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
}

finishplayerdamagewrapper( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = 0;

    if ( maps\mp\_utility::isusingremote() && var_2 >= self.health && !( var_3 & level.idflags_stun ) && !isdefined( self.inliveplayerkillstreak ) && !self isgod() )
        var_11 = 1;

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_11 = 0;

    if ( var_11 || maps\mp\_utility::isrocketcorpse() )
    {
        if ( !isdefined( var_7 ) )
            var_7 = ( 0, 0, 0 );

        if ( !isdefined( var_1 ) && !isdefined( var_0 ) )
        {
            var_1 = self;
            var_0 = var_1;
        }

        playerkilled_internal( var_0, var_1, self, var_2, var_4, var_5, var_7, var_8, var_9, 0, 1 );
    }
    else
    {
        if ( !callback_killingblow( var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ) )
            return;

        if ( !isalive( self ) )
            return;

        if ( isplayer( self ) )
        {
            var_12 = shouldplayblastimpact( var_3, var_4, var_5 );
            var_13 = self finishplayerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_12 );

            if ( isdefined( var_13 ) )
                thread finishplayerdamage_impactfxwrapper( var_13[0], var_13[1], var_13[2], var_13[3], var_13[4], var_13[5], var_13[6] );
        }
    }

    if ( var_4 == "MOD_EXPLOSIVE_BULLET" )
        self shellshock( "damage_mp", getdvarfloat( "scr_csmode" ) );

    damageshellshockandrumble( var_0, var_5, var_4, var_2, var_3, var_1 );
}

shouldplayblastimpact( var_0, var_1, var_2 )
{
    if ( var_0 & level.idflags_radius && isexplosivedamagemod( var_1 ) )
    {
        if ( is_countered_by_hardwired( var_2 ) )
        {
            if ( !maps\mp\_utility::_hasperk( "specialty_class_hardwired" ) )
                return 1;
        }
        else if ( !maps\mp\_utility::_hasperk( "specialty_hard_shell" ) )
            return 1;
    }

    return 0;
}

finishplayerdamage_impactfxwrapper( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    waittillframeend;

    if ( !isdefined( self ) || !isdefined( var_0 ) )
        return;

    self finishplayerdamage_impactfx( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

callback_playerlaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = spawnstruct();
    var_9.einflictor = var_0;
    var_9.attacker = var_1;
    var_9.idamage = var_2;
    var_9.attackerposition = var_1.origin;

    if ( var_1 == self )
        var_9.smeansofdeath = "MOD_SUICIDE";
    else
        var_9.smeansofdeath = var_3;

    var_9.sweapon = var_4;

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
        var_9.sprimaryweapon = var_1 getcurrentprimaryweapon();
    else
        var_9.sprimaryweapon = undefined;

    var_9.vdir = var_5;
    var_9.shitloc = var_6;
    var_9.laststandstarttime = gettime();
    var_10 = maydolaststand( var_4, var_3, var_6 );

    if ( isdefined( self.endgame ) )
        var_10 = 0;

    if ( level.teambased && isdefined( var_1.team ) && var_1.team == self.team )
        var_10 = 0;

    if ( level.diehardmode )
    {
        if ( level.teamcount[self.team] <= 1 )
            var_10 = 0;
        else if ( maps\mp\_utility::isteaminlaststand() )
        {
            var_10 = 0;
            maps\mp\_utility::killteaminlaststand( self.team );
        }
    }

    if ( !var_10 )
    {
        self.laststandparams = var_9;
        self.uselaststandparams = 1;
        maps\mp\_utility::_suicide();
    }
    else
    {
        self.inlaststand = 1;
        var_11 = spawnstruct();

        if ( maps\mp\_utility::_hasperk( "specialty_finalstand" ) )
        {
            var_11.titletext = game["strings"]["final_stand"];
            var_11.iconname = level.specialty_finalstand_icon;
        }
        else
        {
            var_11.titletext = game["strings"]["last_stand"];
            var_11.iconname = level.specialty_finalstand_icon;
        }

        var_11.glowcolor = ( 1, 0, 0 );
        var_11.sound = "mp_last_stand";
        var_11.duration = 2.0;
        self.health = 1;
        thread maps\mp\gametypes\_hud_message::notifymessage( var_11 );
        var_12 = "frag_grenade_mp";

        if ( maps\mp\_utility::_hasperk( "specialty_finalstand" ) )
        {
            self.laststandparams = var_9;
            self.infinalstand = 1;
            var_13 = self getweaponslistexclusives();

            foreach ( var_15 in var_13 )
                self takeweapon( var_15 );

            common_scripts\utility::_disableusability();
            thread enablelaststandweapons();
            thread laststandtimer( 20, 1 );
        }
        else
        {
            if ( level.diehardmode )
            {
                var_1 thread maps\mp\_events::killedplayerevent( self, var_4, var_3 );
                self.laststandparams = var_9;
                common_scripts\utility::_disableweapon();
                thread laststandtimer( 20, 0 );
                common_scripts\utility::_disableusability();
                return;
            }

            self.laststandparams = var_9;
            var_17 = undefined;
            var_18 = self getweaponslistprimaries();

            foreach ( var_15 in var_18 )
            {
                if ( maps\mp\gametypes\_weapons::issidearm( var_15 ) )
                    var_17 = var_15;
            }

            if ( !isdefined( var_17 ) )
            {
                var_17 = "iw6_p226_mp";
                maps\mp\_utility::_giveweapon( var_17 );
            }

            self givemaxammo( var_17 );
            self disableweaponswitch();
            common_scripts\utility::_disableusability();

            if ( !maps\mp\_utility::_hasperk( "specialty_laststandoffhand" ) )
                self disableoffhandweapons();

            self switchtoweapon( var_17 );
            thread laststandtimer( 10, 0 );
        }
    }
}

dieaftertime( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    wait(var_0);
    self.uselaststandparams = 1;
    maps\mp\_utility::_suicide();
}

detonateonuse()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self waittill( "detonate" );
    self.uselaststandparams = 1;
    c4deathdetonate();
}

detonateondeath()
{
    self endon( "detonate" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self waittill( "death" );
    c4deathdetonate();
}

c4deathdetonate()
{
    self playsound( "detpack_explo_default" );
    self.c4deatheffect = playfx( level.c4death, self.origin );
    radiusdamage( self.origin, 312, 100, 100, self );

    if ( isalive( self ) )
        maps\mp\_utility::_suicide();
}

enablelaststandweapons()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    maps\mp\_utility::freezecontrolswrapper( 1 );
    wait 0.3;
    maps\mp\_utility::freezecontrolswrapper( 0 );
}

laststandtimer( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    level notify( "player_last_stand" );
    thread laststandwaittilldeath();
    self.laststand = 1;

    if ( !var_1 && ( !isdefined( self.inc4death ) || !self.inc4death ) )
    {
        thread laststandallowsuicide();
        maps\mp\_utility::setlowermessage( "last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        thread laststandkeepoverlay();
    }

    if ( level.diehardmode == 1 && level.diehardmode != 2 )
    {
        var_2 = spawn( "script_model", self.origin );
        var_2 setmodel( "tag_origin" );
        var_2 setcursorhint( "HINT_NOICON" );
        var_2 sethintstring( &"PLATFORM_REVIVE" );
        var_2 revivesetup( self );
        var_2 endon( "death" );
        var_3 = newteamhudelem( self.team );
        var_3 setshader( "waypoint_revive", 8, 8 );
        var_3 setwaypoint( 1, 1 );
        var_3 settargetent( self );
        var_3 thread destroyonreviveentdeath( var_2 );
        var_3.color = ( 0.33, 0.75, 0.24 );
        maps\mp\_utility::playdeathsound();

        if ( var_1 )
        {
            wait(var_0);

            if ( self.infinalstand )
                thread laststandbleedout( var_1, var_2 );
        }

        return;
    }
    else if ( level.diehardmode == 2 )
    {
        thread laststandkeepoverlay();
        var_2 = spawn( "script_model", self.origin );
        var_2 setmodel( "tag_origin" );
        var_2 setcursorhint( "HINT_NOICON" );
        var_2 sethintstring( &"PLATFORM_REVIVE" );
        var_2 revivesetup( self );
        var_2 endon( "death" );
        var_3 = newteamhudelem( self.team );
        var_3 setshader( "waypoint_revive", 8, 8 );
        var_3 setwaypoint( 1, 1 );
        var_3 settargetent( self );
        var_3 thread destroyonreviveentdeath( var_2 );
        var_3.color = ( 0.33, 0.75, 0.24 );
        maps\mp\_utility::playdeathsound();

        if ( var_1 )
        {
            wait(var_0);

            if ( self.infinalstand )
                thread laststandbleedout( var_1, var_2 );
        }

        wait(var_0 / 3);
        var_3.color = ( 1, 0.64, 0 );

        while ( var_2.inuse )
            wait 0.05;

        maps\mp\_utility::playdeathsound();
        wait(var_0 / 3);
        var_3.color = ( 1, 0, 0 );

        while ( var_2.inuse )
            wait 0.05;

        maps\mp\_utility::playdeathsound();
        wait(var_0 / 3);

        while ( var_2.inuse )
            wait 0.05;

        wait 0.05;
        thread laststandbleedout( var_1 );
        return;
    }

    thread laststandkeepoverlay();
    wait(var_0);
    thread laststandbleedout( var_1 );
}

maxhealthoverlay( var_0, var_1 )
{
    self endon( "stop_maxHealthOverlay" );
    self endon( "revive" );
    self endon( "death" );

    for (;;)
    {
        self.health -= 1;
        self.maxhealth = var_0;
        wait 0.05;
        self.maxhealth = 50;
        self.health += 1;
        wait 0.5;
    }
}

laststandbleedout( var_0, var_1 )
{
    if ( var_0 )
    {
        self.laststand = undefined;
        self.infinalstand = 0;
        self notify( "revive" );
        maps\mp\_utility::clearlowermessage( "last_stand" );
        maps\mp\gametypes\_playerlogic::laststandrespawnplayer();

        if ( isdefined( var_1 ) )
            var_1 delete();
    }
    else
    {
        self.uselaststandparams = 1;
        self.beingrevived = 0;
        maps\mp\_utility::_suicide();
    }
}

laststandallowsuicide()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "revive" );

    for (;;)
    {
        if ( self usebuttonpressed() )
        {
            var_0 = gettime();

            while ( self usebuttonpressed() )
            {
                wait 0.05;

                if ( gettime() - var_0 > 700 )
                    break;
            }

            if ( gettime() - var_0 > 700 )
                break;
        }

        wait 0.05;
    }

    thread laststandbleedout( 0 );
}

laststandkeepoverlay()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );

    while ( !level.gameended )
    {
        self.health = 2;
        wait 0.05;
        self.health = 1;
        wait 0.5;
    }

    self.health = self.maxhealth;
}

laststandwaittilldeath()
{
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    self waittill( "death" );
    maps\mp\_utility::clearlowermessage( "last_stand" );
    self.laststand = undefined;
}

maydolaststand( var_0, var_1, var_2 )
{
    if ( var_1 == "MOD_TRIGGER_HURT" )
        return 0;

    if ( var_1 != "MOD_PISTOL_BULLET" && var_1 != "MOD_RIFLE_BULLET" && var_1 != "MOD_FALLING" && var_1 != "MOD_EXPLOSIVE_BULLET" )
        return 0;

    if ( var_1 == "MOD_IMPACT" && ( var_0 == "throwingknife_mp" || var_0 == "throwingknifejugg_mp" ) )
        return 0;

    if ( var_1 == "MOD_IMPACT" && ( var_0 == "m79_mp" || issubstr( var_0, "gl_" ) ) )
        return 0;

    if ( maps\mp\_utility::isheadshot( var_0, var_2, var_1 ) )
        return 0;

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    return 1;
}

ensurelaststandparamsvalidity()
{
    if ( !isdefined( self.laststandparams.attacker ) )
        self.laststandparams.attacker = self;
}

gethitlocheight( var_0 )
{
    switch ( var_0 )
    {
        case "neck":
        case "helmet":
        case "head":
            return 60;
        case "left_hand":
        case "right_hand":
        case "left_arm_lower":
        case "right_arm_lower":
        case "left_arm_upper":
        case "right_arm_upper":
        case "torso_upper":
        case "gun":
            return 48;
        case "torso_lower":
            return 40;
        case "left_leg_upper":
        case "right_leg_upper":
            return 32;
        case "left_leg_lower":
        case "right_leg_lower":
            return 10;
        case "left_foot":
        case "right_foot":
            return 5;
    }

    return 48;
}

gethitloctag( var_0 )
{
    switch ( var_0 )
    {
        case "helmet":
            return "j_neck";
        case "head":
            return "j_neck";
        case "neck":
            return "j_neck";
        case "torso_upper":
            return "j_neck";
        case "right_arm_upper":
            return "J_Shoulder_RI";
        case "left_arm_upper":
            return "J_Shoulder_LE";
        case "right_arm_lower":
            return "J_Elbow_RI";
        case "left_arm_lower":
            return "J_Elbow_LE";
        case "right_hand":
            return "J_Wrist_RI";
        case "left_hand":
            return "J_Wrist_LE";
        case "gun":
            return "J_Wrist_RI";
        case "torso_lower":
            return "J_SpineLower";
        case "right_leg_upper":
            return "J_Hip_RI";
        case "left_leg_upper":
            return "J_Hip_LE";
        case "right_leg_lower":
            return "J_Knee_RI";
        case "left_leg_lower":
            return "J_Knee_LE";
        case "right_foot":
            return "J_Ankle_RI";
        case "left_foot":
            return "J_Ankle_LE";
    }

    return undefined;
}

delaystartragdoll( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_0 ) )
    {
        var_6 = var_0 getcorpseanim();

        if ( animhasnotetrack( var_6, "ignore_ragdoll" ) )
            return;
    }

    if ( isdefined( level.noragdollents ) && level.noragdollents.size )
    {
        foreach ( var_8 in level.noragdollents )
        {
            if ( distancesquared( var_0.origin, var_8.origin ) < 65536 )
                return;
        }
    }

    wait 0.2;

    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 isragdoll() )
        return;

    var_6 = var_0 getcorpseanim();
    var_10 = 0.35;

    if ( animhasnotetrack( var_6, "start_ragdoll" ) )
    {
        var_11 = getnotetracktimes( var_6, "start_ragdoll" );

        if ( isdefined( var_11 ) )
            var_10 = var_11[0];
    }

    var_12 = var_10 * getanimlength( var_6 );
    wait(var_12);

    if ( isdefined( var_0 ) )
        var_0 startragdoll();
}

getmostkilledby()
{
    var_0 = "";
    var_1 = 0;
    var_2 = getarraykeys( self.killedby );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( self.killedby[var_4] <= var_1 )
            continue;

        var_1 = self.killedby[var_4];
        var_5 = var_4;
    }

    return var_0;
}

getmostkilled()
{
    var_0 = "";
    var_1 = 0;
    var_2 = getarraykeys( self.killedplayers );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( self.killedplayers[var_4] <= var_1 )
            continue;

        var_1 = self.killedplayers[var_4];
        var_0 = var_4;
    }

    return var_0;
}

damageshellshockandrumble( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    thread maps\mp\gametypes\_weapons::onweapondamage( var_0, var_1, var_2, var_3, var_5 );
    self playrumbleonentity( "sniper_fire" );
}

revivesetup( var_0 )
{
    var_1 = var_0.team;
    self linkto( var_0, "tag_origin" );
    self.owner = var_0;
    self.inuse = 0;
    self makeusable();
    updateusablebyteam( var_1 );
    thread trackteamchanges( var_1 );
    thread revivetriggerthink( var_1 );
    thread deleteonreviveordeathordisconnect();
}

deleteonreviveordeathordisconnect()
{
    self endon( "death" );
    self.owner common_scripts\utility::waittill_any( "death", "disconnect" );
    self delete();
}

updateusablebyteam( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_0 == var_2.team && var_2 != self.owner )
        {
            self enableplayeruse( var_2 );
            continue;
        }

        self disableplayeruse( var_2 );
    }
}

trackteamchanges( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "joined_team" );
        updateusablebyteam( var_0 );
    }
}

tracklaststandchanges( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "player_last_stand" );
        updateusablebyteam( var_0 );
    }
}

revivetriggerthink( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger", var_1 );
        self.owner.beingrevived = 1;

        if ( isdefined( var_1.beingrevived ) && var_1.beingrevived )
        {
            self.owner.beingrevived = 0;
            continue;
        }

        self makeunusable();
        self.owner maps\mp\_utility::freezecontrolswrapper( 1 );
        var_2 = reviveholdthink( var_1 );
        self.owner.beingrevived = 0;

        if ( !isalive( self.owner ) )
        {
            self delete();
            return;
        }

        self.owner maps\mp\_utility::freezecontrolswrapper( 0 );

        if ( var_2 )
        {
            level thread maps\mp\gametypes\_rank::awardgameevent( "reviver", var_1 );
            self.owner.laststand = undefined;
            self.owner maps\mp\_utility::clearlowermessage( "last_stand" );
            self.owner.movespeedscaler = level.baseplayermovescale;

            if ( self.owner maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
                self.owner.movespeedscaler = maps\mp\_utility::lightweightscalar();

            self.owner common_scripts\utility::_enableweapon();
            self.owner.maxhealth = 100;
            self.owner maps\mp\gametypes\_weapons::updatemovespeedscale();
            self.owner maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
            self.owner maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
            self.owner.beingrevived = 0;
            self delete();
            return;
        }

        self makeusable();
        updateusablebyteam( var_0 );
    }
}

reviveholdthink( var_0, var_1, var_2 )
{
    var_3 = 3000;
    var_4 = spawn( "script_origin", self.origin );
    var_4 hide();

    if ( isplayer( var_0 ) )
        var_0 playerlinkto( var_4 );
    else
        var_0 linkto( var_4 );

    var_0 playerlinkedoffsetenable();

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( var_2 )
        var_0 common_scripts\utility::_disableweapon();

    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;

    if ( isdefined( var_1 ) )
        self.usetime = var_1;
    else
        self.usetime = var_3;

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_0 thread personalusebaroldstyle( self );
    else
        var_0 thread personalusebar( self );

    thread reviveholdthink_cleanup( var_0, var_2, var_4 );
    var_5 = reviveholdthinkloop( var_0 );
    self.inuse = 0;
    var_4 delete();

    if ( isdefined( var_5 ) && var_5 )
    {
        self.owner thread maps\mp\gametypes\_hud_message::playercardsplashnotify( "revived", var_0 );
        self.owner.inlaststand = 0;
        return 1;
    }

    return 0;
}

reviveholdthink_cleanup( var_0, var_1, var_2 )
{
    common_scripts\utility::waittill_any_ents( self, "death", var_2, "death" );

    if ( !isremovedentity( var_2 ) )
        var_2 delete();

    if ( isdefined( var_0 ) && maps\mp\_utility::isreallyalive( var_0 ) )
    {
        var_0 unlink();

        if ( var_1 )
            var_0 common_scripts\utility::_enableweapon();
    }
}

personalusebar( var_0 )
{
    self setclientomnvar( "ui_use_bar_text", 3 );
    self setclientomnvar( "ui_use_bar_start_time", int( gettime() ) );
    var_1 = undefined;

    if ( isdefined( var_0 ) && isdefined( var_0.owner ) )
    {
        var_1 = var_0.owner;
        var_1 setclientomnvar( "ui_use_bar_text", 4 );
        var_1 setclientomnvar( "ui_use_bar_start_time", int( gettime() ) );
    }

    var_2 = -1;

    while ( maps\mp\_utility::isreallyalive( self ) && isdefined( var_0 ) && var_0.inuse && !level.gameended && isdefined( self ) )
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

                if ( isdefined( var_1 ) )
                    var_1 setclientomnvar( "ui_use_bar_end_time", int( var_5 ) );
            }

            var_2 = var_0.userate;
        }

        wait 0.05;
    }

    if ( isdefined( self ) )
        self setclientomnvar( "ui_use_bar_end_time", 0 );

    if ( isdefined( var_1 ) )
        var_1 setclientomnvar( "ui_use_bar_end_time", 0 );
}

personalusebaroldstyle( var_0 )
{
    var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
    var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_2 settext( &"MPUI_REVIVING" );
    var_3 = var_0.owner maps\mp\gametypes\_hud_util::createprimaryprogressbar();
    var_4 = var_0.owner maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
    var_4 settext( &"MPUI_BEING_REVIVED" );
    var_5 = -1;

    while ( maps\mp\_utility::isreallyalive( self ) && isdefined( var_0 ) && var_0.inuse && !level.gameended && isdefined( self ) )
    {
        if ( var_5 != var_0.userate )
        {
            if ( var_0.curprogress > var_0.usetime )
                var_0.curprogress = var_0.usetime;

            var_1 maps\mp\gametypes\_hud_util::updatebar( var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate );
            var_3 maps\mp\gametypes\_hud_util::updatebar( var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate );

            if ( !var_0.userate )
            {
                var_1 maps\mp\gametypes\_hud_util::hideelem();
                var_2 maps\mp\gametypes\_hud_util::hideelem();
                var_3 maps\mp\gametypes\_hud_util::hideelem();
                var_4 maps\mp\gametypes\_hud_util::hideelem();
            }
            else
            {
                var_1 maps\mp\gametypes\_hud_util::showelem();
                var_2 maps\mp\gametypes\_hud_util::showelem();
                var_3 maps\mp\gametypes\_hud_util::showelem();
                var_4 maps\mp\gametypes\_hud_util::showelem();
            }
        }

        var_5 = var_0.userate;
        wait 0.05;
    }

    if ( isdefined( var_1 ) )
        var_1 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( var_2 ) )
        var_2 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( var_3 ) )
        var_3 maps\mp\gametypes\_hud_util::destroyelem();

    if ( isdefined( var_4 ) )
        var_4 maps\mp\gametypes\_hud_util::destroyelem();
}

reviveholdthinkloop( var_0 )
{
    level endon( "game_ended" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );

    while ( maps\mp\_utility::isreallyalive( var_0 ) && var_0 usebuttonpressed() && self.curprogress < self.usetime && !( isdefined( var_0.inlaststand ) && var_0.inlaststand ) )
    {
        self.curprogress += 50 * self.userate;
        self.userate = 1;

        if ( self.curprogress >= self.usetime )
        {
            self.inuse = 0;
            return maps\mp\_utility::isreallyalive( var_0 );
        }

        wait 0.05;
    }

    return 0;
}

callback_killingblow( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( isdefined( self.lastdamagewasfromenemy ) && self.lastdamagewasfromenemy && var_2 >= self.health && isdefined( self.combathigh ) && self.combathigh == "specialty_endgame" )
    {
        maps\mp\_utility::giveperk( "specialty_endgame", 0 );
        return 0;
    }

    return 1;
}

emitfalldamage( var_0 )
{
    physicsexplosionsphere( self.origin, 64, 64, 1 );
    var_1 = [];

    for ( var_2 = 0; var_2 < 360; var_2 += 30 )
    {
        var_3 = cos( var_2 ) * 16;
        var_4 = sin( var_2 ) * 16;
        var_5 = bullettrace( self.origin + ( var_3, var_4, 4 ), self.origin + ( var_3, var_4, -6 ), 1, self );

        if ( isdefined( var_5["entity"] ) && isdefined( var_5["entity"].targetname ) && ( var_5["entity"].targetname == "destructible_vehicle" || var_5["entity"].targetname == "destructible_toy" ) )
            var_1[var_1.size] = var_5["entity"];
    }

    if ( var_1.size )
    {
        var_6 = spawn( "script_origin", self.origin );
        var_6 hide();
        var_6.type = "soft_landing";
        var_6.destructibles = var_1;
        radiusdamage( self.origin, 64, 100, 100, var_6 );
        wait 0.1;
        var_6 delete();
    }
}

_obituary( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0.team;

    foreach ( var_6 in level.players )
    {
        var_7 = var_6.team;

        if ( var_7 == "spectator" )
        {
            var_6 iprintln( &"MP_OBITUARY_NEUTRAL", var_1.name, var_0.name );
            continue;
        }

        if ( var_7 == var_4 )
        {
            var_6 iprintln( &"MP_OBITUARY_ENEMY", var_1.name, var_0.name );
            continue;
        }

        var_6 iprintln( &"MP_OBITUARY_FRIENDLY", var_1.name, var_0.name );
    }
}

logprintplayerdeath( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = self getentitynumber();
    var_8 = self.name;
    var_9 = self.team;
    var_10 = self.guid;

    if ( isplayer( var_1 ) )
    {
        var_11 = var_1.guid;
        var_12 = var_1.name;
        var_13 = var_1.team;
        var_14 = var_1 getentitynumber();
        var_15 = var_1.xuid + "(" + var_12 + ")";
    }
    else
    {
        var_11 = "";
        var_12 = "";
        var_13 = "world";
        var_14 = -1;
        var_15 = "none";
    }

    logprint( "K;" + var_10 + ";" + var_7 + ";" + var_9 + ";" + var_8 + ";" + var_11 + ";" + var_14 + ";" + var_13 + ";" + var_12 + ";" + var_4 + ";" + var_2 + ";" + var_3 + ";" + var_6 + "\\n" );
}

destroyonreviveentdeath( var_0 )
{
    var_0 waittill( "death" );
    self destroy();
}

gamemodemodifyplayerdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( var_2 ) && isplayer( var_2 ) && isalive( var_2 ) )
    {
        if ( level.matchrules_damagemultiplier )
            var_3 *= level.matchrules_damagemultiplier;

        if ( level.matchrules_vampirism )
            var_2.health = int( min( float( var_2.maxhealth ), float( var_2.health + 20 ) ) );
    }

    return var_3;
}

setentitydamagecallback( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = "normal";

    if ( !isdefined( var_3 ) )
        var_3 = ::modifydamage;

    self setcandamage( 1 );

    if ( isdefined( self.classname ) && self.classname != "script_vehicle" )
        self setdamagecallbackon( 1 );

    self.health = 999999;
    self.maxhealth = var_0;
    self.damagetaken = 0;
    self.biskillstreak = var_4;
    self.damagefeedback = var_1;
    self.damagecallback = ::processdamagetaken;
    self.modifydamagefunc = var_3;
    self.ondeathfunc = var_2;
    self.attackerlist = [];
}

processdamagetaken( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    if ( !isdefined( self ) )
        return;

    if ( !( isdefined( level.ishorde ) && level.ishorde ) && !( isdefined( level.iszombiegame ) && level.iszombiegame ) && isdefined( var_1 ) && !maps\mp\_utility::isgameparticipant( var_1 ) )
        return;

    if ( isdefined( var_1 ) && !maps\mp\gametypes\_weapons::friendlyfirecheck( self.owner, var_1 ) )
        return;

    var_1 playrumbleonentity( "damage_light" );

    if ( isdefined( self.iscrashing ) && self.iscrashing )
        return;

    if ( isdefined( self.isleaving ) && self.isleaving )
        return;

    if ( isdefined( self.stopdamagefunc ) && self.stopdamagefunc )
        return;

    var_12 = var_2;

    if ( isdefined( var_5 ) )
    {
        var_13 = maps\mp\_utility::strip_suffix( var_5, "_lefthand" );

        switch ( var_13 )
        {
            case "smoke_grenade_var_mp":
            case "paint_grenade_var_mp":
            case "smoke_grenade_mp":
            case "paint_grenade_mp":
                return;
        }

        if ( isdefined( level.ishorde ) && level.ishorde )
            self.damageloc = var_11;

        var_12 = [[ self.modifydamagefunc ]]( var_1, var_5, var_4, var_2 );

        if ( isdefined( level.ishorde ) && level.ishorde )
            self.damageloc = undefined;
    }

    if ( var_12 < 0 )
        return 1;

    if ( isdefined( var_3 ) && var_3 & level.idflags_penetration )
        self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;
    self.damagetaken += var_12;
    maps\mp\killstreaks\_killstreaks::killstreakhit( var_1, var_5, self );

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( self.damagefeedback );

        if ( isnewattacker( var_1 ) )
            self.attackerlist[self.attackerlist.size] = var_1;
    }

    if ( self.damagetaken >= self.maxhealth )
    {
        if ( self.biskillstreak && isplayer( var_1 ) )
            var_1 notify( "destroyed_killstreak", var_5 );

        if ( self.classname == "script_vehicle" || self.classname == "script_model" )
        {
            var_14 = maps\mp\_utility::getbaseweaponname( var_5, 1 );

            if ( maps\mp\_utility::islootweapon( var_14 ) )
                var_14 = maps\mp\gametypes\_class::getbasefromlootversion( var_14 );

            var_15 = maps\mp\gametypes\_missions::get_challenge_weapon_class( var_5, var_14 );

            if ( isdefined( self.model ) && var_15 == "weapon_launcher" )
            {
                if ( issubstr( self.model, "uav" ) )
                {
                    if ( isdefined( level.challengeinfo["ch_uav_" + var_14] ) )
                        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_uav_" + var_14 );
                }

                if ( issubstr( self.model, "warbird" ) )
                {
                    if ( isdefined( level.challengeinfo["ch_warbird_" + var_14] ) )
                        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_warbird_" + var_14 );
                }

                if ( issubstr( self.model, "orbital_platform" ) )
                {
                    if ( isdefined( level.challengeinfo["ch_paladin_" + var_14] ) )
                        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_paladin_" + var_14 );
                }

                if ( issubstr( self.model, "drone" ) && !issubstr( self.model, "uav" ) )
                {
                    if ( isdefined( level.challengeinfo["ch_drone_" + var_14] ) )
                        var_1 maps\mp\gametypes\_missions::processchallenge( "ch_drone_" + var_14 );
                }
            }
        }

        self.stopdamagefunc = 1;
        self thread [[ self.ondeathfunc ]]( var_1, var_5, var_4, var_2 );
    }
}

isnewattacker( var_0 )
{
    foreach ( var_2 in self.attackerlist )
    {
        if ( var_0 == var_2 )
            return 0;
    }

    return 1;
}

modifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3;
    var_4 = handlemeleedamage( var_1, var_2, var_4 );
    var_4 = handleempdamage( var_1, var_2, var_4, var_0 );
    var_4 = handlemissiledamage( var_1, var_2, var_4 );
    var_4 = handlegrenadedamage( var_1, var_2, var_4 );
    var_4 = handleapdamage( var_1, var_2, var_4, var_0 );
    return var_4;
}

handlemissiledamage( var_0, var_1, var_2 )
{
    var_3 = var_2;

    switch ( var_0 )
    {
        case "orbitalsupport_missile_mp":
        case "orbitalsupport_105mm_mp":
        case "airstrike_missile_mp":
        case "remotemissile_projectile_secondary_mp":
        case "remotemissile_projectile_cluster_child_hellfire_mp":
        case "warbird_missile_mp":
        case "dam_turret_mp":
        case "remotemissile_projectile_cluster_child_mp":
        case "orbital_carepackage_pod_plane_mp":
        case "stealth_bomb_mp":
        case "stinger_mp":
        case "orbital_carepackage_droppod_mp":
        case "orbital_carepackage_pod_mp":
        case "remotemissile_projectile_gas_mp":
        case "remotemissile_projectile_cluster_parent_mp":
        case "remotemissile_projectile_mp":
        case "bomb_site_mp":
            self.largeprojectiledamage = 1;
            var_3 = self.maxhealth + 1;
            break;
        case "killstreak_laser2_mp":
            self.largeprojectiledamage = 1;
            var_4 = level.sentrygun.ownerlist;
            var_5 = 0.34;

            if ( isdefined( var_4 ) && var_4.size > 0 )
            {
                var_6 = var_4.size;

                if ( var_4.size >= 3 )
                    var_6 = 3;

                var_5 *= var_6;
            }

            var_3 = self.maxhealth * var_5;
            break;
        case "killstreak_orbital_laser_mp":
        case "killstreakmahem_mp":
        case "assaultdrone_c4_mp":
        case "ugv_missile_mp":
        case "turretheadrocket_mp":
            self.largeprojectiledamage = 0;
            var_3 = self.maxhealth + 1;
            break;
        case "orbitalsupport_40mmbuddy_mp":
        case "orbitalsupport_40mm_mp":
            self.largeprojectiledamage = 0;
            var_3 *= 2;
            break;
    }

    return var_3;
}

handlegrenadedamage( var_0, var_1, var_2 )
{
    var_3 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( var_3 == "stun_grenade_mp" || var_3 == "stun_grenade_var_mp" || var_3 == "stun_grenade_horde_mp" )
    {
        self notify( "concussed" );
        return 0;
    }
    else if ( isexplosivedamagemod( var_1 ) )
    {
        switch ( var_3 )
        {
            case "explosive_drone_mp":
            case "semtex_mp":
            case "frag_grenade_mp":
                var_2 *= 4;
                break;
            default:
                if ( maps\mp\_utility::isstrstart( var_0, "alt_" ) )
                    var_2 *= 3;

                break;
        }
    }

    return var_2;
}

handlemeleedamage( var_0, var_1, var_2 )
{
    if ( maps\mp\_utility::ismeleemod( var_1 ) )
    {
        var_3 = int( self.maxhealth / 3 ) + 1;

        if ( var_3 > var_2 )
            return var_3;
    }

    return var_2;
}

handleempdamage( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\mp\_utility::strip_suffix( var_0, "_lefthand" );

    if ( ( var_4 == "emp_grenade_mp" || var_4 == "emp_grenade_var_mp" || var_4 == "emp_grenade_killstreak_mp" ) && ( var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_GRENADE" ) )
    {
        self notify( "emp_damage", var_3, 8.0 );
        return 0;
    }

    return var_2;
}

handleapdamage( var_0, var_1, var_2, var_3 )
{
    if ( var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_PISTOL_BULLET" )
    {
        if ( var_3 maps\mp\_utility::_hasperk( "specialty_armorpiercing" ) || maps\mp\_utility::isfmjdamage( var_0, var_1, var_3 ) )
            return var_2 * level.armorpiercingmod;
    }

    return var_2;
}

onkillstreakkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = undefined;

    if ( isdefined( var_0 ) && isdefined( self.owner ) )
    {
        if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) )
            var_0 = var_0.owner;

        if ( var_0 == self.owner )
            return;

        if ( !isalliedsentient( self.owner, var_0 ) )
            var_8 = var_0;
    }

    if ( isdefined( var_8 ) )
    {
        var_8 notify( "destroyed_killstreak", var_1 );
        var_8 maps\mp\_utility::incplayerstat( var_4, 1 );
        level thread maps\mp\gametypes\_rank::awardgameevent( var_4, var_8, var_1, undefined, var_2 );

        if ( isdefined( var_1 ) && var_1 == "killstreak_laser2_mp" && isdefined( level.sentrygun ) && isdefined( level.sentrygun.ownerlist ) )
        {
            foreach ( var_10 in level.sentrygun.ownerlist )
            {
                if ( var_10 != var_8 )
                {
                    var_10 notify( "destroyed_killstreak", var_1 );
                    var_10 maps\mp\_utility::incplayerstat( var_4, 1 );
                    level thread maps\mp\gametypes\_rank::awardgameevent( var_4, var_10, var_1, undefined, var_2 );
                }
            }
        }

        if ( isdefined( var_6 ) )
            level thread maps\mp\_utility::teamplayercardsplash( var_6, var_8 );

        if ( isdefined( var_7 ) && var_7 )
            level thread maps\mp\gametypes\_missions::vehiclekilled( self.owner, self, undefined, var_8, var_3, var_2, var_1 );
    }

    thread maps\mp\_events::checkvandalismmedal( var_8 );

    if ( isdefined( self.owner ) && isdefined( var_5 ) )
        self.owner thread maps\mp\_utility::leaderdialogonplayer( var_5, undefined, undefined, self.origin );
}
