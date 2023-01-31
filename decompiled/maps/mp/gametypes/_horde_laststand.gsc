// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

callback_playerlaststandhorde( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    while ( self.isrunningarmorycommand || self.isrunningweapongive )
        waitframe();

    if ( isdefined( self.iscarrying ) && self.iscarrying )
    {
        self notify( "force_cancel_placement" );
        waitframe();
    }

    registerlaststandparameter( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( gameshouldend( self ) )
    {
        self.uselaststandparams = 1;
        maps\mp\_utility::_suicide();
        maps\mp\gametypes\_horde_util::hordeupdatescore( self, 0 );
        hordeendgame();
        return;
    }

    if ( !maydolaststandhorde( self ) )
    {
        self.uselaststandparams = 0;

        if ( level.players.size < 2 )
        {
            maps\mp\_utility::_suicide();
            maps\mp\gametypes\_horde_util::hordeupdatescore( self, 0 );
            hordeendgame();
            return;
        }
        else
        {
            if ( isdefined( level.hordedropandresetuplinkball ) )
                self [[ level.hordedropandresetuplinkball ]]();

            if ( isdefined( self.underwater ) )
            {
                var_9 = self _meth_8312();
                self _meth_830F( var_9 );
            }

            thread laststandmonitorabandonment();
            startspectatemode( 1, 1, 0 );
            return;
        }
    }

    self.inlaststand = 1;
    self.laststand = 1;
    self.ignoreme = 1;
    self.health = 1;
    self _meth_8130( 0 );
    thread leaveremotekillstreaks();
    thread laststandexoabilitymonitor();
    self waittill( "last_stand_offhand_secondary_disabled" );
    var_10 = self _meth_830C();
    self.primaryweapons = [];

    foreach ( var_12 in var_10 )
    {
        if ( !issubstr( var_12, "combatknife" ) )
            self.primaryweapons[self.primaryweapons.size] = var_12;
    }

    self.lastequippedweapon = self _meth_8312();

    if ( self.lastequippedweapon == "iw5_carrydrone_mp" || self.lastequippedweapon == "search_dstry_bomb_defuse_mp" || issubstr( self.lastequippedweapon, "killstreak" ) || issubstr( self.lastequippedweapon, "turrethead" ) && !isdefined( self.pers["rippableSentry"] ) )
        self.lastequippedweapon = self.primaryweapons[0];

    foreach ( var_12 in self.primaryweapons )
    {
        self.primaryweaponsammo[var_12]["ammoclip"] = self _meth_82F8( var_12 );
        self.primaryweaponsammo[var_12]["ammostock"] = self _meth_82F9( var_12 );

        if ( issubstr( var_12, "exoxmg" ) && !issubstr( var_12, "alt_" ) || issubstr( var_12, "sac3" ) )
            self.primaryweaponsammo[var_12]["ammoclipleft"] = self _meth_82F8( var_12, "left" );
    }

    foreach ( var_17 in self.primaryweapons )
    {
        if ( !issubstr( var_17, "titan" ) )
            self _meth_830F( var_17 );
    }

    var_19 = hordelaststandweapon();
    maps\mp\gametypes\_weapons::saveweapon( "laststand", self.lastequippedweapon, var_19 );

    if ( !haslaststandweapon( var_19 ) )
        self _meth_830E( var_19 );

    self.wasunderwater = isdefined( self.underwater );

    if ( !isdefined( self.underwater ) )
    {
        if ( !issubstr( self.lastequippedweapon, "titan" ) )
            self _meth_8316( var_19 );
    }

    thread maps\mp\gametypes\_horde_util::hordeallowallboost( 0, "laststand" );
    self _meth_82FB( "ui_horde_show_armory", 0 );
    self _meth_82FB( "ui_horde_laststand", 1 );
    self _meth_83FA( 1, 0 );
    common_scripts\utility::_disableusability();
    self _meth_8321();
    self _meth_831F();
    thread laststandrevivehorde( var_0, var_1, var_4, var_7, var_3 );
}

leaveremotekillstreaks()
{
    if ( maps\mp\_utility::isinremotetransition() )
        maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();

    if ( isdefined( self.usingremote ) )
    {
        if ( self.usingremote == "warbird" )
        {
            foreach ( var_1 in level.spawnedwarbirds )
            {
                if ( var_1.owner == self )
                {
                    var_1 notify( "death" );
                    var_1 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
                    wait 1;
                    break;
                }
            }
        }
        else if ( self.usingremote == "orbital_strike" )
        {
            foreach ( var_4 in level.orbital_lasers )
            {
                if ( var_4.owner == self )
                {
                    var_4 notify( "death" );
                    wait 1;
                    break;
                }
            }
        }
        else if ( isdefined( self.remoteturretlist ) )
            self.remoteturretlist[0] notify( "death" );
    }
}

startspectatemode( var_0, var_1, var_2 )
{
    if ( maps\mp\killstreaks\_emp::issystemhacked() && !level.gameended )
    {
        maps\mp\killstreaks\_emp::removeemp();
        waitframe();
    }

    laststandsaveloadoutinfo( var_0, var_1, !var_2 );
    self.lastperks = self.horde_perks;
    maps\mp\_utility::_clearperks();
    self.lastkillstreaks = [];
    var_3 = self _meth_8447( "ui_horde_player_class" );
    var_4 = self.classsettings[var_3]["killstreak"];
    var_5 = 0;

    foreach ( var_7 in self.pers["killstreaks"] )
    {
        if ( !var_5 && isdefined( var_7.streakname ) && var_7.streakname == var_4 )
        {
            var_5 = 1;
            continue;
        }

        if ( var_7.available )
        {
            var_8 = self.lastkillstreaks.size;
            self.lastkillstreaks[var_8]["name"] = var_7.streakname;
            self.lastkillstreaks[var_8]["modules"] = var_7.modules;
        }
    }

    self notify( "becameSpectator" );
    self.pers["class"] = undefined;
    self.class = undefined;
    self.isspectator = 1;
    self.ignoreme = 1;

    if ( var_2 )
        thread maps\mp\gametypes\_playerlogic::spawnspectator( self _meth_80A8() - ( 0, 0, 8 ), self getangles() );
    else
        thread maps\mp\gametypes\_playerlogic::spawnspectator();

    self notify( "revive" );
}

laststandsaveloadoutinfo( var_0, var_1, var_2 )
{
    if ( var_0 )
    {
        self.lastequippedweapon = self _meth_8312();
        self.primaryweapons = self _meth_830C();
        self.wasunderwater = isdefined( self.underwater );

        foreach ( var_4 in self.primaryweapons )
        {
            self.primaryweaponsammo[var_4]["ammoclip"] = self _meth_82F8( var_4 );
            self.primaryweaponsammo[var_4]["ammostock"] = self _meth_82F9( var_4 );

            if ( issubstr( var_4, "exoxmg" ) && !issubstr( var_4, "alt_" ) || issubstr( var_4, "sac3" ) )
                self.primaryweaponsammo[var_4]["ammoclipleft"] = self _meth_82F8( var_4, "left" );
        }
    }

    if ( var_2 )
    {
        self.lastlethalweapon = self _meth_8345();
        self.lastlethalweaponammoclip = self _meth_82F8( self.lastlethalweapon );
    }

    if ( var_1 )
    {
        var_6 = self _meth_8447( "ui_horde_player_class" );
        self.lasttacticalweapon = self _meth_831A();
        self.lasttacticalweaponammoclip = self _meth_84A2( self.lasttacticalweapon );
        self.classsettings[var_6]["battery"] = self.lasttacticalweaponammoclip;
    }
}

hordelaststandweapon()
{
    return "iw5_titan45_mp_xmags";
}

haslaststandweapon( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = hordelaststandweapon();

    var_1 = self _meth_830C();

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == var_0 )
        {
            self.hadlaststandweapon = 1;
            return 1;
        }
    }

    self.hadlaststandweapon = 0;
    return 0;
}

gameshouldend( var_0 )
{
    if ( level.players.size < 2 )
    {
        if ( isdefined( self.hasselfrevive ) && self.hasselfrevive )
            return 0;
    }

    var_1 = 0;

    foreach ( var_3 in level.participants )
    {
        if ( var_0 == var_3 && !maps\mp\gametypes\_horde_util::hasagentsquadmember( var_0 ) )
            continue;

        if ( !maps\mp\gametypes\_horde_util::isonhumanteam( var_3 ) )
            continue;

        if ( maps\mp\gametypes\_horde_util::isplayerinlaststand( var_3 ) && !maps\mp\gametypes\_horde_util::hasagentsquadmember( var_3 ) )
            continue;

        if ( ( !isdefined( var_3.sessionstate ) || var_3.sessionstate != "playing" ) && !isdefined( var_3.goliathdeath ) )
            continue;

        var_1 = 1;
        break;
    }

    return !var_1;
}

hordeendgame( var_0 )
{
    setomnvar( "horde_game_ended", 1 );

    foreach ( var_2 in level.players )
        var_2 _meth_82FB( "ui_horde_show_armory", 0 );

    foreach ( var_5 in level.carepackages )
        var_5 maps\mp\killstreaks\_airdrop::deletecrate();

    if ( !level.zombiesstarted )
        thread maps\mp\gametypes\_horde_armory::hordedisablearmories();

    level notify( "defend_cancel" );
    wait 0.05;
    level.finalkillcam_winner = level.enemyteam;

    if ( !isdefined( var_0 ) )
        level thread maps\mp\gametypes\_gamelogic::endgame( level.enemyteam, game["end_reason"]["survivors_eliminated"] );
    else if ( var_0 == "extraction_failed" )
        level thread maps\mp\gametypes\_gamelogic::endgame( level.enemyteam, game["end_reason"]["zombie_extraction_failed"] );
    else if ( var_0 == "zombies_completed" )
        level thread maps\mp\gametypes\_gamelogic::endgame( level.playerteam, game["end_reason"]["zombies_completed"] );

    if ( level.currentroundnumber > 4 )
        _func_25F( 0 );
}

maydolaststandhorde( var_0 )
{
    if ( var_0 maps\mp\_utility::touchingbadtrigger() )
        return 0;

    return 1;
}

registerlaststandparameter( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnstruct();
    var_7.einflictor = var_0;
    var_7.attacker = var_1;
    var_7.idamage = var_2;
    var_7.attackerposition = var_1.origin;
    var_7.smeansofdeath = var_3;
    var_7.sweapon = var_4;
    var_7.vdir = var_5;
    var_7.shitloc = var_6;
    var_7.laststandstarttime = gettime();

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 _meth_8312() != "none" )
        var_7.sprimaryweapon = var_1 _meth_8312();
    else
        var_7.sprimaryweapon = undefined;

    self.laststandparams = var_7;
}

laststandrevivehorde( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    level notify( "player_last_stand" );
    self notify( "player_start_last_stand" );
    self notify( "force_cancel_placement" );
    level thread maps\mp\gametypes\_horde_util::playsoundtoallplayers( "mp_last_stand" );
    level thread maps\mp\_utility::leaderdialog( "ally_down", level.playerteam, "status" );
    thread laststandwaittilldeathhorde();
    thread laststandammowacher();
    thread laststandkeepoverlayhorde();
    thread laststandmonitorabandonment();
    var_5 = spawn( "script_model", self.origin );
    var_5 _meth_80B1( "tag_origin" );
    var_5 _meth_80DA( "HINT_NOICON" );
    var_5 _meth_80DB( &"PLATFORM_REVIVE" );
    var_5 makeusable();
    var_5.inuse = 0;
    var_5.curprogress = 0;
    var_5.usetime = level.laststandusetime;
    var_5.userate = 1;
    var_5.id = "last_stand";
    var_5.targetname = "revive_trigger";
    var_5.owner = self;
    var_5 _meth_804D( self, "tag_origin", ( 0, 0, 20 ), ( 0, 0, 0 ) );
    var_5 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
    var_6 = newteamhudelem( self.team );
    var_6 _meth_80CC( "waypoint_revive", 8, 8 );
    var_6 _meth_80D8( 1, 1 );
    var_6 _meth_80CD( self );
    var_6.color = ( 0.33, 0.75, 0.24 );
    var_6 thread maps\mp\gametypes\_damage::destroyonreviveentdeath( var_5 );
    thread laststandupdatereviveiconcolorhorde( var_5, var_6, 25 );
    var_5 thread reviveentmonitor();
    var_5 thread revivetriggerthinkhorde();
    var_5 thread laststandwaittillliferecived();
    self.hasselfrevive = 0;

    if ( level.players.size < 2 )
    {
        thread laststandselfrevive();
        level thread selfrevivethinkloop( self );
    }
    else
        thread laststandtimerhorde( 25, var_5 );

    var_5 endon( "death" );
    wait 25;

    while ( isdefined( var_5.inuse ) && var_5.inuse )
        waitframe();

    self _meth_83FB();
    self _meth_831D();
    self.movespeedscaler = 0.05;

    if ( level.players.size > 1 )
        startspectatemode( 0, 0, 0 );
}

laststandselfrevive()
{
    self endon( "disconnect" );
    self _meth_82FB( "ui_use_bar_text", 3 );
    self _meth_82FB( "ui_use_bar_start_time", int( gettime() ) );
    self.curprogress = 0;
    self.userate = 1;
    self.usetime = 8000;
    var_0 = -1;

    while ( maps\mp\_utility::isreallyalive( self ) && isdefined( self.laststand ) && !level.gameended )
    {
        if ( var_0 != self.userate )
        {
            if ( self.curprogress > self.usetime )
                self.curprogress = self.usetime;

            if ( self.userate > 0 )
            {
                var_1 = gettime();
                var_2 = self.curprogress / self.usetime;
                var_3 = var_1 + ( 1 - var_2 ) * self.usetime / self.userate;
                self _meth_82FB( "ui_use_bar_end_time", int( var_3 ) );
            }

            var_0 = self.userate;
        }

        wait 0.05;
    }

    self _meth_82FB( "ui_use_bar_end_time", 0 );
}

selfrevivethinkloop( var_0 )
{
    while ( !level.gameended && maps\mp\_utility::isreallyalive( var_0 ) && var_0.curprogress < var_0.usetime )
    {
        var_0.curprogress += 50 * var_0.userate;

        if ( var_0.curprogress >= var_0.usetime )
            var_0 notify( "revive_trigger" );

        wait 0.05;
    }
}

revivetriggerthinkhorde()
{
    self endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        self makeusable();
        self waittill( "trigger", var_0 );
        self makeunusable();
        self.curprogress = 0;
        self.inuse = 1;
        self.owner.beingrevived = 1;
        var_0 freezecontrols( 1 );
        var_0 common_scripts\utility::_disableweaponswitch();
        var_0 _meth_8131( 0 );
        var_0.isreviving = 1;
        thread revivetriggerthinkhorde_cleanup( var_0 );
        var_1 = maps\mp\gametypes\_damage::reviveholdthink( var_0, undefined, 0 );
        self.inuse = 0;

        if ( isdefined( self.owner ) )
            self.owner.beingrevived = 0;

        if ( isdefined( var_0 ) && maps\mp\_utility::isreallyalive( var_0 ) )
        {
            self notify( "reviveTriggerThinkHorde_cleanup" );

            if ( isdefined( var_1 ) && var_1 )
            {
                var_0 thread maps\mp\gametypes\_hud_message::splashnotifydelayed( "horde_reviver" );
                maps\mp\gametypes\_horde_util::playsoundtoallplayers( "mp_challenge_complete" );

                if ( isplayer( var_0 ) )
                    maps\mp\gametypes\_horde_util::awardhorderevive( var_0 );
                else if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) && var_0.owner != self.owner )
                    maps\mp\gametypes\_horde_util::awardhorderevive( var_0.owner );
            }

            if ( !isdefined( var_1 ) )
                var_0 maps\mp\gametypes\_gameobjects::updateuiprogress( self, 0 );
        }

        if ( isdefined( var_1 ) && var_1 )
        {
            self.owner notify( "revive_trigger", var_0 );
            break;
        }
    }
}

revivetriggerthinkhorde_cleanup( var_0 )
{
    common_scripts\utility::waittill_any_ents( self, "death", self, "reviveTriggerThinkHorde_cleanup" );
    var_0 freezecontrols( 0 );
    var_0 _meth_8131( 1 );
    var_0 common_scripts\utility::_enableweaponswitch();
    var_0.isreviving = 0;
}

laststandwaittillliferecived()
{
    level endon( "game_ended" );
    var_0 = self.owner;
    var_0 endon( "becameSpectator" );
    var_0 endon( "death" );
    var_0 endon( "disconnect" );
    var_0 waittill( "revive_trigger", var_1 );

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 != var_0 )
        var_0 thread maps\mp\gametypes\_hud_message::playercardsplashnotify( "revived", var_1 );

    if ( var_0 _meth_8336() )
    {
        while ( var_0 _meth_8336() )
            waitframe();

        waitframe();
    }

    var_0 laststandrespawnplayerhorde();
}

reviveentmonitor()
{
    self endon( "death" );
    self.owner common_scripts\utility::waittill_any( "revive_trigger", "disconnect", "becameSpectator" );
    self delete();
}

laststandrespawnplayerhorde()
{
    self notify( "revive" );
    var_0 = self _meth_8447( "ui_horde_player_class" );
    var_1 = level.classsettings[var_0]["speed"];
    self.laststand = undefined;
    self.inlaststand = 0;
    self.headicon = "";
    self.health = self.maxhealth;
    self.movespeedscaler = var_1;
    self.ignoreme = 0;
    self.beingrevived = 0;

    if ( maps\mp\_utility::_hasperk( "specialty_lightweight" ) )
        self.movespeedscaler = maps\mp\_utility::lightweightscalar();

    self _meth_83FB();
    self _meth_82C7();

    if ( !isdefined( self.underwater ) )
        self _meth_817D( "crouch" );

    if ( !self.hadlaststandweapon )
    {
        var_2 = hordelaststandweapon();
        self _meth_830F( var_2 );
        self _meth_8511( var_2 );
    }

    if ( !self.wasunderwater && isdefined( self.underwater ) )
        self.lastequippedweapon = level.shallow_water_weapon;

    if ( isdefined( self.underwater ) )
    {
        self _meth_830E( level.shallow_water_weapon );
        self _meth_8316( level.shallow_water_weapon );
    }

    thread maps\mp\gametypes\_horde_util::hordeallowallboost( 1, "laststand" );
    self _meth_8130( 1 );
    self _meth_831E();
    common_scripts\utility::_enableusability();
    self _meth_8320();
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\_utility::clearlowermessage( "last_stand" );
    maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );

    if ( isdefined( self.underwater ) || issubstr( self.lastequippedweapon, "turret" ) )
    {
        givebackstoredplayerweapons( var_0, 0, self.lastequippedweapon );

        if ( isdefined( self.underwater ) || issubstr( self.lastequippedweapon, "turret" ) )
        {
            self _meth_830E( self.lastequippedweapon );

            while ( !self _meth_8511( [ self.lastequippedweapon ] ) )
                waitframe();
        }
    }
    else
        givebackstoredplayerweapons( var_0, 1 );

    maps\mp\gametypes\_weapons::restoreweapon( "laststand" );

    if ( level.hordeweaponsjammed == 0 && !isdefined( self.underwater ) )
        self _meth_8322();

    if ( !precachestatusicon( self.origin ) )
        maps\mp\_movers::unresolved_collision_nearest_node( self, 0 );
}

givestoredweapon( var_0, var_1, var_2 )
{
    maps\mp\gametypes\_horde_util::trygivehordeweapon( self, var_0, 1, var_2, undefined, var_1 );
    self _meth_82F6( var_0, self.primaryweaponsammo[var_0]["ammoclip"] );
    self _meth_82F7( var_0, self.primaryweaponsammo[var_0]["ammostock"] );
}

givebackstoredplayerweapons( var_0, var_1, var_2 )
{
    if ( level.zombiesstarted )
    {
        foreach ( var_4 in self.primaryweapons )
        {
            self _meth_830E( var_4 );
            self _meth_82F7( var_4, self.primaryweaponsammo[var_4]["ammostock"] );
            self _meth_82F6( var_4, self.primaryweaponsammo[var_4]["ammoclip"] );
        }

        self _meth_8316( self.lastequippedweapon );
        return;
    }

    var_6 = self.lastequippedweapon == self.hordeclassweapons[var_0]["secondary"];
    var_7 = var_1 && !var_6 && !level.hordeweaponsjammed;
    var_8 = var_1 && var_6 && !level.hordeweaponsjammed;
    givestoredweapon( self.hordeclassweapons[var_0]["primary"], "primary", var_7 );
    givestoredweapon( self.hordeclassweapons[var_0]["secondary"], "secondary", var_8 );

    foreach ( var_4 in self.primaryweapons )
    {
        if ( issubstr( var_4, "exoxmg" ) && !issubstr( var_4, "alt_" ) || issubstr( var_4, "sac3" ) )
            self _meth_82F6( var_4, self.primaryweaponsammo[var_4]["ammoclipleft"], "left" );
    }

    var_11 = self _meth_830C();

    foreach ( var_4 in var_11 )
    {
        if ( isdefined( var_2 ) && var_4 == var_2 )
            continue;

        if ( var_4 != self.hordeclassweapons[var_0]["primary"] && var_4 != self.hordeclassweapons[var_0]["secondary"] )
        {
            if ( !issubstr( var_4, "alt_iw5_" ) )
                self _meth_830F( var_4 );
        }
    }

    if ( level.hordeweaponsjammed )
    {
        if ( isdefined( var_2 ) )
            var_14 = var_2;
        else if ( var_6 )
            var_14 = self.hordeclassweapons[var_0]["secondary"];
        else
            var_14 = self.hordeclassweapons[var_0]["primary"];

        maps\mp\gametypes\horde::handlejammedpistols( var_14 );
    }
}

laststandwaittilldeathhorde()
{
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    self waittill( "death" );
    self.laststand = undefined;
    self.inlaststand = 0;
    self.ignoreme = 0;
}

laststandkeepoverlayhorde()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        self.health = 2;
        waitframe();
        self.health = 1;
        waitframe();
    }
}

laststandmonitorabandonment()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "revive_trigger" );
    self endon( "horde_end_spectate" );

    for (;;)
    {
        level waittill( "player_disconnected" );

        if ( gameshouldend( self ) )
        {
            self.uselaststandparams = 1;
            maps\mp\_utility::_suicide();
            maps\mp\gametypes\_horde_util::hordeupdatescore( self, 0 );

            if ( getomnvar( "horde_game_ended" ) == 0 )
                hordeendgame();

            return;
        }

        waitframe();
    }
}

laststandupdatereviveiconcolorhorde( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    maps\mp\_utility::playdeathsound();
    wait(var_2 / 3);
    var_1.color = ( 1, 0.64, 0 );

    while ( var_0.inuse )
        wait 0.05;

    maps\mp\_utility::playdeathsound();
    wait(var_2 / 3);
    var_1.color = ( 1, 0, 0 );

    while ( var_0.inuse )
        wait 0.05;

    maps\mp\_utility::playdeathsound();
}

laststandtimerhorde( var_0, var_1 )
{
    self endon( "disconnect" );
    var_2 = 90;

    if ( !issplitscreen() )
        var_2 = 120;

    var_3 = maps\mp\gametypes\_hud_util::createtimer( "hudsmall", 1.0 );
    var_3 maps\mp\gametypes\_hud_util::setpoint( "CENTER", undefined, 0, var_2 );
    var_3.label = &"MP_HORDE_BLEED_OUT";
    var_3.color = ( 0.804, 0.804, 0.035 );
    var_3.archived = 0;
    var_3.showinkillcam = 0;
    var_3 _meth_80CF( var_0 - 1 );
    var_1 common_scripts\utility::waittill_any_timeout( var_0, "death" );

    if ( !isdefined( var_3 ) )
        return;

    var_3 notify( "destroying" );
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

laststandammowacher()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1.5;
        var_0 = self _meth_8312();

        if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_0 ) )
            continue;

        var_1 = self _meth_82F9( var_0 );
        var_2 = weaponclipsize( var_0 );

        if ( var_1 < var_2 )
            self _meth_82F7( var_0, var_2 );
    }
}

laststandexoabilitymonitor()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "becameSpectator" );
    level endon( "game_ended" );
    var_0 = self _meth_8447( "ui_horde_player_class" );
    self.lasttacticalweapon = self _meth_831A();
    self.lasttacticalweaponammoclip = self _meth_84A2( self.lasttacticalweapon );
    self.classsettings[var_0]["battery"] = self.lasttacticalweaponammoclip;

    switch ( self.lasttacticalweapon )
    {
        case "exocloakhorde_equipment_mp":
            maps\mp\_exo_cloak::take_exo_cloak();
            break;
        case "exohoverhorde_equipment_mp":
            maps\mp\_exo_hover::take_exo_hover();
            break;
        case "exoshieldhorde_equipment_mp":
            if ( isdefined( self.exo_shield_on ) && self.exo_shield_on )
            {
                self _meth_84A3( "exoshieldhorde_equipment_mp", 0 );
                self waittillmatch( "battery_discharge_end" );
            }

            maps\mp\_exo_shield::take_exo_shield();
            break;
        case "exoping_equipment_mp":
            maps\mp\_exo_ping::take_exo_ping();
            break;
        case "exorepulsor_equipment_mp":
            maps\mp\_exo_repulsor::take_exo_repulsor();
            break;
        case "extra_health_mp":
            maps\mp\_extrahealth::take_exo_health();
            break;
    }

    waitframe();
    self notify( "last_stand_offhand_secondary_disabled" );
    self _meth_84BF();
    self waittill( "revive" );

    switch ( self.lasttacticalweapon )
    {
        case "exocloakhorde_equipment_mp":
            maps\mp\_exo_cloak::give_exo_cloak();
            break;
        case "exohoverhorde_equipment_mp":
            maps\mp\_exo_hover::give_exo_hover();
            break;
        case "exoshieldhorde_equipment_mp":
            maps\mp\_exo_shield::give_exo_shield();
            break;
        case "exoping_equipment_mp":
            maps\mp\_exo_ping::give_exo_ping();
            break;
        case "exorepulsor_equipment_mp":
            maps\mp\_exo_repulsor::give_exo_repulsor();
            break;
        case "extra_health_mp":
            maps\mp\_extrahealth::give_exo_health();
            break;
    }

    self _meth_84A3( self.lasttacticalweapon, self.lasttacticalweaponammoclip );
    self _meth_82FB( "ui_exo_battery_level0", self.lasttacticalweaponammoclip );
    self _meth_84C0();
    level thread maps\mp\gametypes\_horde_armory::hordebatterylevel( self );
}

hordehandlejuggdeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.goliathdeath = 1;
    self.inliveplayerkillstreak = undefined;
    self.mechhealth = undefined;
    self.markedformech = [];

    if ( isdefined( self.barrel ) )
        self.barrel hide();

    self _meth_830F( "iw5_exominigun_mp" );
    maps\mp\killstreaks\_juggernaut::playerreset( self.heavyexodata );
    self _meth_83FB();
    self playerhide();
    self notify( "horde_cancel_goliath" );
    waittillframeend;
    startspectatemode( 0, 0, 1 );
    self _meth_8506( 1 );
    self freezecontrols( 1 );
    self _meth_82FB( "ui_hide_hud", 1 );
    wait 2.5;
    self _meth_8506( 0 );
    self freezecontrols( 0 );
    self _meth_82FB( "ui_hide_hud", 0 );
    self detachall();
    self _meth_84BA( self.costume );
    self playershow();
    level thread maps\mp\gametypes\horde::respawnplayer( self );

    if ( !level.zombiesstarted )
    {
        if ( isdefined( self.hordeclassgoliathowner ) )
        {
            self.hordeclassgoliathowner.hordeclassgoliathcontroller = undefined;
            self.hordeclassgoliathowner notify( "startJuggCooldown" );
        }
        else
            self notify( "startJuggCooldown" );
    }

    if ( isdefined( self.hordegoliathowner ) )
        self.hordegoliathowner.hordegoliathcontroller = undefined;

    self.hordeclassgoliathowner = undefined;
    self.hordegoliathowner = undefined;
}
