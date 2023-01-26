// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_19F7( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    while ( self._id_5193 || self._id_5194 )
        waitframe();

    if ( isdefined( self.iscarrying ) && self.iscarrying )
    {
        self notify( "force_cancel_placement" );
        waitframe();
    }

    _id_72EE( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( _id_3BFB( self ) )
    {
        self.uselaststandparams = 1;
        maps\mp\_utility::_suicide();
        _id_A798::_id_49D8( self, 0 );
        _id_498A();
        return;
    }

    if ( !_id_5A59( self ) )
    {
        self.uselaststandparams = 0;

        if ( level.players.size < 2 )
        {
            maps\mp\_utility::_suicide();
            _id_A798::_id_49D8( self, 0 );
            _id_498A();
            return;
        }
        else
        {
            if ( isdefined( level.hordedropandresetuplinkball ) )
                self [[ level.hordedropandresetuplinkball ]]();

            if ( isdefined( self.underwater ) )
            {
                var_9 = self getcurrentprimaryweapon();
                self takeweapon( var_9 );
            }

            thread _id_55E8();
            _id_8D38( 1, 1, 0 );
            return;
        }
    }

    self.inlaststand = 1;
    self.laststand = 1;
    self.ignoreme = 1;
    self.health = 1;
    self allowmelee( 0 );
    thread _id_5666();
    thread _id_55E5();
    self waittill( "last_stand_offhand_secondary_disabled" );
    var_10 = self getweaponslistprimaries();
    self._id_6F8D = [];

    foreach ( var_12 in var_10 )
    {
        if ( !issubstr( var_12, "combatknife" ) )
            self._id_6F8D[self._id_6F8D.size] = var_12;
    }

    self._id_559C = self getcurrentprimaryweapon();

    if ( self._id_559C == "iw5_carrydrone_mp" || self._id_559C == "search_dstry_bomb_defuse_mp" || issubstr( self._id_559C, "killstreak" ) || issubstr( self._id_559C, "turrethead" ) && !isdefined( self.pers["rippableSentry"] ) )
        self._id_559C = self._id_6F8D[0];

    foreach ( var_12 in self._id_6F8D )
    {
        self._id_6F8E[var_12]["ammoclip"] = self getweaponammoclip( var_12 );
        self._id_6F8E[var_12]["ammostock"] = self getweaponammostock( var_12 );

        if ( issubstr( var_12, "exoxmg" ) && !issubstr( var_12, "alt_" ) || issubstr( var_12, "sac3" ) )
            self._id_6F8E[var_12]["ammoclipleft"] = self getweaponammoclip( var_12, "left" );
    }

    foreach ( var_17 in self._id_6F8D )
    {
        if ( !issubstr( var_17, "titan" ) )
            self takeweapon( var_17 );
    }

    var_19 = hordelaststandweapon();
    maps\mp\gametypes\_weapons::saveweapon( "laststand", self._id_559C, var_19 );

    if ( !haslaststandweapon( var_19 ) )
        self giveweapon( var_19 );

    self._id_A1CA = isdefined( self.underwater );

    if ( !isdefined( self.underwater ) )
    {
        if ( !issubstr( self._id_559C, "titan" ) )
            self switchtoweaponimmediate( var_19 );
    }

    thread _id_A798::_id_4953( 0, "laststand" );
    self setclientomnvar( "ui_horde_show_armory", 0 );
    self setclientomnvar( "ui_horde_laststand", 1 );
    self _meth_83FA( 1, 0 );
    common_scripts\utility::_disableusability();
    self disableweaponswitch();
    self disableoffhandweapons();
    thread _id_55EC( var_0, var_1, var_4, var_7, var_3 );
}

_id_5666()
{
    if ( maps\mp\_utility::isinremotetransition() )
        maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();

    if ( isdefined( self.usingremote ) )
    {
        if ( self.usingremote == "warbird" )
        {
            foreach ( var_1 in level._id_89A1 )
            {
                if ( var_1.owner == self )
                {
                    var_1 notify( "death" );
                    var_1 thread maps\mp\killstreaks\_aerial_utility::_id_47CA();
                    wait 1;
                    break;
                }
            }
        }
        else if ( self.usingremote == "orbital_strike" )
        {
            foreach ( var_4 in level._id_654F )
            {
                if ( var_4.owner == self )
                {
                    var_4 notify( "death" );
                    wait 1;
                    break;
                }
            }
        }
        else if ( isdefined( self._id_7327 ) )
            self._id_7327[0] notify( "death" );
    }
}

_id_8D38( var_0, var_1, var_2 )
{
    if ( maps\mp\killstreaks\_emp::_id_51C3() && !level.gameended )
    {
        maps\mp\killstreaks\_emp::_id_739D();
        waitframe();
    }

    laststandsaveloadoutinfo( var_0, var_1, !var_2 );
    self._id_55C6 = self._id_4948;
    maps\mp\_utility::_clearperks();
    self._id_55B2 = [];
    var_3 = self getclientomnvar( "ui_horde_player_class" );
    var_4 = self._id_1E3A[var_3]["killstreak"];
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
            var_8 = self._id_55B2.size;
            self._id_55B2[var_8]["name"] = var_7.streakname;
            self._id_55B2[var_8]["modules"] = var_7.modules;
        }
    }

    self notify( "becameSpectator" );
    self.pers["class"] = undefined;
    self.class = undefined;
    self._id_51B2 = 1;
    self.ignoreme = 1;

    if ( var_2 )
        thread maps\mp\gametypes\_playerlogic::spawnspectator( self geteye() - ( 0.0, 0.0, 8.0 ), self getangles() );
    else
        thread maps\mp\gametypes\_playerlogic::spawnspectator();

    self notify( "revive" );
}

laststandsaveloadoutinfo( var_0, var_1, var_2 )
{
    if ( var_0 )
    {
        self._id_559C = self getcurrentprimaryweapon();
        self._id_6F8D = self getweaponslistprimaries();
        self._id_A1CA = isdefined( self.underwater );

        foreach ( var_4 in self._id_6F8D )
        {
            self._id_6F8E[var_4]["ammoclip"] = self getweaponammoclip( var_4 );
            self._id_6F8E[var_4]["ammostock"] = self getweaponammostock( var_4 );

            if ( issubstr( var_4, "exoxmg" ) && !issubstr( var_4, "alt_" ) || issubstr( var_4, "sac3" ) )
                self._id_6F8E[var_4]["ammoclipleft"] = self getweaponammoclip( var_4, "left" );
        }
    }

    if ( var_2 )
    {
        self._id_55B5 = self getlethalweapon();
        self._id_55B6 = self getweaponammoclip( self._id_55B5 );
    }

    if ( var_1 )
    {
        var_6 = self getclientomnvar( "ui_horde_player_class" );
        self._id_55FD = self gettacticalweapon();
        self._id_55FE = self batterygetcharge( self._id_55FD );
        self._id_1E3A[var_6]["battery"] = self._id_55FE;
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

    var_1 = self getweaponslistprimaries();

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

_id_3BFB( var_0 )
{
    if ( level.players.size < 2 )
    {
        if ( isdefined( self.hasselfrevive ) && self.hasselfrevive )
            return 0;
    }

    var_1 = 0;

    foreach ( var_3 in level.participants )
    {
        if ( var_0 == var_3 && !_id_A798::_id_4711( var_0 ) )
            continue;

        if ( !_id_A798::_id_5164( var_3 ) )
            continue;

        if ( _id_A798::_id_5175( var_3 ) && !_id_A798::_id_4711( var_3 ) )
            continue;

        if ( ( !isdefined( var_3.sessionstate ) || var_3.sessionstate != "playing" ) && !isdefined( var_3.goliathdeath ) )
            continue;

        var_1 = 1;
        break;
    }

    return !var_1;
}

_id_498A( var_0 )
{
    setomnvar( "horde_game_ended", 1 );

    foreach ( var_2 in level.players )
        var_2 setclientomnvar( "ui_horde_show_armory", 0 );

    foreach ( var_5 in level.carepackages )
        var_5 maps\mp\killstreaks\_airdrop::_id_2847();

    if ( !level._id_A3D0 )
        thread _id_A791::_id_4977();

    level notify( "defend_cancel" );
    wait 0.05;
    level.finalkillcam_winner = level._id_32C5;

    if ( !isdefined( var_0 ) )
        level thread maps\mp\gametypes\_gamelogic::endgame( level._id_32C5, game["end_reason"]["survivors_eliminated"] );
    else if ( var_0 == "extraction_failed" )
        level thread maps\mp\gametypes\_gamelogic::endgame( level._id_32C5, game["end_reason"]["zombie_extraction_failed"] );
    else if ( var_0 == "zombies_completed" )
        level thread maps\mp\gametypes\_gamelogic::endgame( level._id_6D6C, game["end_reason"]["zombies_completed"] );

    if ( level._id_2520 > 4 )
        _func_25F( 0 );
}

_id_5A59( var_0 )
{
    if ( var_0 maps\mp\_utility::touchingbadtrigger() )
        return 0;

    return 1;
}

_id_72EE( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
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

    if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1 getcurrentprimaryweapon() != "none" )
        var_7.sprimaryweapon = var_1 getcurrentprimaryweapon();
    else
        var_7.sprimaryweapon = undefined;

    self.laststandparams = var_7;
}

_id_55EC( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    level notify( "player_last_stand" );
    self notify( "player_start_last_stand" );
    self notify( "force_cancel_placement" );
    level thread _id_A798::_id_6DDB( "mp_last_stand" );
    level thread maps\mp\_utility::leaderdialog( "ally_down", level._id_6D6C, "status" );
    thread _id_55F4();
    thread _id_55E3();
    thread _id_55E7();
    thread _id_55E8();
    var_5 = spawn( "script_model", self.origin );
    var_5 setmodel( "tag_origin" );
    var_5 setcursorhint( "HINT_NOICON" );
    var_5 sethintstring( &"PLATFORM_REVIVE" );
    var_5 makeusable();
    var_5.inuse = 0;
    var_5.curprogress = 0;
    var_5.usetime = level._id_55F2;
    var_5.userate = 1;
    var_5.id = "last_stand";
    var_5.targetname = "revive_trigger";
    var_5.owner = self;
    var_5 linkto( self, "tag_origin", ( 0.0, 0.0, 20.0 ), ( 0.0, 0.0, 0.0 ) );
    var_5 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
    var_6 = newteamhudelem( self.team );
    var_6 setshader( "waypoint_revive", 8, 8 );
    var_6 setwaypoint( 1, 1 );
    var_6 settargetent( self );
    var_6.color = ( 0.33, 0.75, 0.24 );
    var_6 thread maps\mp\gametypes\_damage::destroyonreviveentdeath( var_5 );
    thread _id_55F1( var_5, var_6, 25 );
    var_5 thread reviveentmonitor();
    var_5 thread _id_74FE();
    var_5 thread _id_55F5();
    self.hasselfrevive = 0;

    if ( level.players.size < 2 )
    {
        thread _id_55ED();
        level thread _id_7C73( self );
    }
    else
        thread _id_55F0( 25, var_5 );

    var_5 endon( "death" );
    wait 25;

    while ( isdefined( var_5.inuse ) && var_5.inuse )
        waitframe();

    self _meth_83FB();
    self disableweapons();
    self.movespeedscaler = 0.05;

    if ( level.players.size > 1 )
        _id_8D38( 0, 0, 0 );
}

_id_55ED()
{
    self endon( "disconnect" );
    self setclientomnvar( "ui_use_bar_text", 3 );
    self setclientomnvar( "ui_use_bar_start_time", int( gettime() ) );
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
                self setclientomnvar( "ui_use_bar_end_time", int( var_3 ) );
            }

            var_0 = self.userate;
        }

        wait 0.05;
    }

    self setclientomnvar( "ui_use_bar_end_time", 0 );
}

_id_7C73( var_0 )
{
    while ( !level.gameended && maps\mp\_utility::isreallyalive( var_0 ) && var_0.curprogress < var_0.usetime )
    {
        var_0.curprogress += 50 * var_0.userate;

        if ( var_0.curprogress >= var_0.usetime )
            var_0 notify( "revive_trigger" );

        wait 0.05;
    }
}

_id_74FE()
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
        var_0._id_518D = 1;
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
                _id_A798::_id_6DDB( "mp_challenge_complete" );

                if ( isplayer( var_0 ) )
                    _id_A798::_id_120B( var_0 );
                else if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) && var_0.owner != self.owner )
                    _id_A798::_id_120B( var_0.owner );
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
    var_0._id_518D = 0;
}

_id_55F5()
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

    var_0 _id_55EB();
}

reviveentmonitor()
{
    self endon( "death" );
    self.owner common_scripts\utility::waittill_any( "revive_trigger", "disconnect", "becameSpectator" );
    self delete();
}

_id_55EB()
{
    self notify( "revive" );
    var_0 = self getclientomnvar( "ui_horde_player_class" );
    var_1 = level._id_1E3A[var_0]["speed"];
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
    self laststandrevive();

    if ( !isdefined( self.underwater ) )
        self setstance( "crouch" );

    if ( !self.hadlaststandweapon )
    {
        var_2 = hordelaststandweapon();
        self takeweapon( var_2 );
        self loadweapons( var_2 );
    }

    if ( !self._id_A1CA && isdefined( self.underwater ) )
        self._id_559C = level.shallow_water_weapon;

    if ( isdefined( self.underwater ) )
    {
        self giveweapon( level.shallow_water_weapon );
        self switchtoweaponimmediate( level.shallow_water_weapon );
    }

    thread _id_A798::_id_4953( 1, "laststand" );
    self allowmelee( 1 );
    self enableweapons();
    common_scripts\utility::_enableusability();
    self enableoffhandweapons();
    maps\mp\gametypes\_weapons::updatemovespeedscale();
    maps\mp\_utility::clearlowermessage( "last_stand" );
    maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );

    if ( isdefined( self.underwater ) || issubstr( self._id_559C, "turret" ) )
    {
        givebackstoredplayerweapons( var_0, 0, self._id_559C );

        if ( isdefined( self.underwater ) || issubstr( self._id_559C, "turret" ) )
        {
            self giveweapon( self._id_559C );

            while ( !self loadweapons( [ self._id_559C ] ) )
                waitframe();
        }
    }
    else
        givebackstoredplayerweapons( var_0, 1 );

    maps\mp\gametypes\_weapons::restoreweapon( "laststand" );

    if ( level.hordeweaponsjammed == 0 && !isdefined( self.underwater ) )
        self enableweaponswitch();

    if ( !precachestatusicon( self.origin ) )
        maps\mp\_movers::_id_9A54( self, 0 );
}

givestoredweapon( var_0, var_1, var_2 )
{
    _id_A798::_id_9894( self, var_0, 1, var_2, undefined, var_1 );
    self setweaponammoclip( var_0, self._id_6F8E[var_0]["ammoclip"] );
    self setweaponammostock( var_0, self._id_6F8E[var_0]["ammostock"] );
}

givebackstoredplayerweapons( var_0, var_1, var_2 )
{
    if ( level._id_A3D0 )
    {
        foreach ( var_4 in self._id_6F8D )
        {
            self giveweapon( var_4 );
            self setweaponammostock( var_4, self._id_6F8E[var_4]["ammostock"] );
            self setweaponammoclip( var_4, self._id_6F8E[var_4]["ammoclip"] );
        }

        self switchtoweaponimmediate( self._id_559C );
        return;
    }

    var_6 = self._id_559C == self._id_4964[var_0]["secondary"];
    var_7 = var_1 && !var_6 && !level.hordeweaponsjammed;
    var_8 = var_1 && var_6 && !level.hordeweaponsjammed;
    givestoredweapon( self._id_4964[var_0]["primary"], "primary", var_7 );
    givestoredweapon( self._id_4964[var_0]["secondary"], "secondary", var_8 );

    foreach ( var_4 in self._id_6F8D )
    {
        if ( issubstr( var_4, "exoxmg" ) && !issubstr( var_4, "alt_" ) || issubstr( var_4, "sac3" ) )
            self setweaponammoclip( var_4, self._id_6F8E[var_4]["ammoclipleft"], "left" );
    }

    var_11 = self getweaponslistprimaries();

    foreach ( var_4 in var_11 )
    {
        if ( isdefined( var_2 ) && var_4 == var_2 )
            continue;

        if ( var_4 != self._id_4964[var_0]["primary"] && var_4 != self._id_4964[var_0]["secondary"] )
        {
            if ( !issubstr( var_4, "alt_iw5_" ) )
                self takeweapon( var_4 );
        }
    }

    if ( level.hordeweaponsjammed )
    {
        if ( isdefined( var_2 ) )
            var_14 = var_2;
        else if ( var_6 )
            var_14 = self._id_4964[var_0]["secondary"];
        else
            var_14 = self._id_4964[var_0]["primary"];

        maps\mp\gametypes\horde::handlejammedpistols( var_14 );
    }
}

_id_55F4()
{
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    self waittill( "death" );
    self.laststand = undefined;
    self.inlaststand = 0;
    self.ignoreme = 0;
}

_id_55E7()
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

_id_55E8()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "revive_trigger" );
    self endon( "horde_end_spectate" );

    for (;;)
    {
        level waittill( "player_disconnected" );

        if ( _id_3BFB( self ) )
        {
            self.uselaststandparams = 1;
            maps\mp\_utility::_suicide();
            _id_A798::_id_49D8( self, 0 );

            if ( getomnvar( "horde_game_ended" ) == 0 )
                _id_498A();

            return;
        }

        waitframe();
    }
}

_id_55F1( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    maps\mp\_utility::playdeathsound();
    wait(var_2 / 3);
    var_1.color = ( 1.0, 0.64, 0.0 );

    while ( var_0.inuse )
        wait 0.05;

    maps\mp\_utility::playdeathsound();
    wait(var_2 / 3);
    var_1.color = ( 1.0, 0.0, 0.0 );

    while ( var_0.inuse )
        wait 0.05;

    maps\mp\_utility::playdeathsound();
}

_id_55F0( var_0, var_1 )
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
    var_3 settimer( var_0 - 1 );
    var_1 common_scripts\utility::waittill_any_timeout( var_0, "death" );

    if ( !isdefined( var_3 ) )
        return;

    var_3 notify( "destroying" );
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
}

_id_55E3()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "revive" );
    level endon( "game_ended" );

    for (;;)
    {
        wait 1.5;
        var_0 = self getcurrentprimaryweapon();

        if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_0 ) )
            continue;

        var_1 = self getweaponammostock( var_0 );
        var_2 = weaponclipsize( var_0 );

        if ( var_1 < var_2 )
            self setweaponammostock( var_0, var_2 );
    }
}

_id_55E5()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "becameSpectator" );
    level endon( "game_ended" );
    var_0 = self getclientomnvar( "ui_horde_player_class" );
    self._id_55FD = self gettacticalweapon();
    self._id_55FE = self batterygetcharge( self._id_55FD );
    self._id_1E3A[var_0]["battery"] = self._id_55FE;

    switch ( self._id_55FD )
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

    switch ( self._id_55FD )
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

    self _meth_84A3( self._id_55FD, self._id_55FE );
    self setclientomnvar( "ui_exo_battery_level0", self._id_55FE );
    self _meth_84C0();
    level thread _id_A791::_id_495C( self );
}

hordehandlejuggdeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.goliathdeath = 1;
    self.inliveplayerkillstreak = undefined;
    self._id_5B1D = undefined;
    self.markedformech = [];

    if ( isdefined( self._id_12E4 ) )
        self._id_12E4 hide();

    self takeweapon( "iw5_exominigun_mp" );
    maps\mp\killstreaks\_juggernaut::_id_6D2E( self._id_4798 );
    self _meth_83FB();
    self playerhide();
    self notify( "horde_cancel_goliath" );
    waittillframeend;
    _id_8D38( 0, 0, 1 );
    self setmlgspectator( 1 );
    self freezecontrols( 1 );
    self setclientomnvar( "ui_hide_hud", 1 );
    wait 2.5;
    self setmlgspectator( 0 );
    self freezecontrols( 0 );
    self setclientomnvar( "ui_hide_hud", 0 );
    self detachall();
    self setcostumemodels( self.costume );
    self playershow();
    level thread maps\mp\gametypes\horde::_id_7476( self );

    if ( !level._id_A3D0 )
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
