// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    if ( isdefined( level._id_5985 ) )
        [[ level._id_5985 ]]();

    level thread maps\mp\killstreaks\_airdrop::init();
    level thread maps\mp\killstreaks\_rippedturret::init();
    level thread maps\mp\killstreaks\_orbital_carepackage::init();
    level thread maps\mp\killstreaks\_orbital_util::_id_4E24();
    level thread maps\mp\zombies\killstreaks\_zombie_drone_assault::init();
    level thread maps\mp\zombies\killstreaks\_zombie_sentry::init();
    level thread maps\mp\zombies\killstreaks\_zombie_camouflage::init();
    level thread extrainit();
    level.killstreakfuncs["zm_ripped_turret"] = maps\mp\killstreaks\_rippedturret::_id_98C3;
    level.killstreakwieldweapons["orbital_carepackage_pod_zm_mp"] = "orbital_carepackage";
    level.ocp_weap_name = "orbital_carepackage_pod_zm_mp";
    level thread roundlogic();
}

extrainit()
{
    level.teamemped["allies"] = 0;
    level.teamemped["axis"] = 0;
    level.orbitalsupportinuse = 0;
    level.missile_strike_gas_clouds = [];
}

_id_167A()
{
    var_0 = gettime();

    if ( !isdefined( level._id_5380 ) )
    {
        thread maps\mp\bots\_bots_ks::_id_16F5();
        maps\mp\bots\_bots_ks::_id_16CC( "zm_squadmate", maps\mp\bots\_bots_ks::_id_167B );
        maps\mp\bots\_bots_ks::_id_16CC( "remote_mg_sentry_turret", maps\mp\bots\_bots_sentry::_id_1679, maps\mp\bots\_bots_sentry::_id_15CC, "turret" );
        maps\mp\bots\_bots_ks::_id_16CC( "assault_ugv", maps\mp\bots\_bots_ks::_id_167B, maps\mp\bots\_bots_ks::_id_15C8 );
        maps\mp\bots\_bots_ks::_id_16CC( "zm_sentry", maps\mp\bots\_bots_sentry::_id_1679, maps\mp\bots\_bots_sentry::_id_15CC, "turret" );
        maps\mp\bots\_bots_ks::_id_16CC( "zm_ugv", maps\mp\bots\_bots_ks::_id_167B, maps\mp\bots\_bots_ks::_id_15C8 );
        maps\mp\bots\_bots_ks::_id_16CC( "uav", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "orbital_carepackage", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "heavy_exosuit", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "nuke", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "warbird", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "emp", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "orbitalsupport", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "recon_ugv", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "orbital_strike_laser", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "missile_strike", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
        maps\mp\bots\_bots_ks::_id_16CC( "strafing_run_airstrike", maps\mp\bots\_bots_ks::_id_1677, maps\mp\bots\_bots_ks::_id_166B );
    }
}

airdropcustomfunc()
{
    level._id_2377 = [];
    level._id_2385 = [];
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "sentry_1", 8, ::_id_5396, &"ZOMBIES_SENTRY_TURRET", "zm_sentry", "sentry_guardian", "sentry_rippable" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "sentry_2", 8, ::_id_5396, &"ZOMBIES_ROCKET_TURRET", "zm_sentry", "sentry_guardian", "sentry_rocket_turret", "sentry_rippable" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "sentry_3", 9, ::_id_5396, &"ZOMBIES_LASER_TURRET", "zm_sentry", "sentry_guardian", "sentry_energy_turret", "sentry_rippable" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "drone_1", 12, ::_id_5396, &"ZOMBIES_ROCKET_DRONE", "zm_ugv", "assault_ugv_ai", "assault_ugv_rockets" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "drone_2", 13, ::_id_5396, &"ZOMBIES_ASSAULT_DRONE", "zm_ugv", "assault_ugv_ai", "assault_ugv_mg" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "money", 25, ::moneycratethink, &"ZOMBIES_CRATE_MONEY", "money" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "camo", 25, ::_id_5396, &"ZOMBIES_CRATE_SHIELD", "zm_camouflage" );

    if ( isdefined( level.airdropcustomfunclevelspecific ) )
        [[ level.airdropcustomfunclevelspecific ]]();
}

schedulescorestreaks()
{
    var_0 = undefined;

    if ( isdefined( level.zmscorestreaks ) && level.zmscorestreaks.size > 0 )
        var_0 = level.zmscorestreaks[level.zmscorestreaks.size - 1];

    level.zmscorestreaks = [];
    level.zmscorestreakindex = 0;
    var_1 = [];

    if ( isdefined( level.zmgetscorestreaksforschedule ) )
        var_1 = [[ level.zmgetscorestreaksforschedule ]]();
    else
    {
        var_1[var_1.size] = "sentry_" + randomintrange( 1, 4 );
        var_1[var_1.size] = "drone_" + randomintrange( 1, 3 );
        var_1[var_1.size] = "money";
        var_1[var_1.size] = "camo";
        var_1[var_1.size] = "sentry_" + randomintrange( 1, 4 );
        var_1[var_1.size] = "drone_" + randomintrange( 1, 3 );
        var_1[var_1.size] = "money";
        var_1[var_1.size] = "camo";
    }

    var_1 = common_scripts\utility::array_randomize( var_1 );
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = getnextscorestreakindex( var_1, var_2, var_0 );

        if ( var_4 != -1 )
        {
            level.zmscorestreaks[level.zmscorestreaks.size] = var_1[var_4];
            var_0 = var_1[var_4];
            var_1[var_4] = undefined;
            continue;
        }

        level.zmscorestreaks[level.zmscorestreaks.size] = level.zmscorestreaks[0];
        var_4 = getarraykeys( var_1 )[0];
        level.zmscorestreaks[0] = var_1[var_4];
    }
}

getnextscorestreakindex( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
    {
        var_3 = strtok( var_2, "_" );
        var_2 = var_3[0];
    }

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( isdefined( var_5 ) )
        {
            if ( !isdefined( var_2 ) )
                return var_4;
            else
            {
                var_3 = strtok( var_5, "_" );
                var_5 = var_3[0];

                if ( var_5 != var_2 )
                    return var_4;
            }
        }
    }

    return -1;
}

setupdroppositions()
{
    level.zmcarepackagelandingspots = common_scripts\utility::getstructarray( "carepackageDropPosition", "targetname" );

    foreach ( var_1 in level.zmcarepackagelandingspots )
    {
        var_1.indoors = isdefined( var_1.script_parameters ) && var_1.script_parameters == "indoors";
        var_1.groundorg = var_1.origin;

        if ( var_1.indoors )
        {
            var_2 = var_1.origin;
            var_3 = var_1.origin + ( 0.0, 0.0, -10000.0 );
            var_4 = bullettrace( var_2, var_3, 0 );
            var_1.groundorg = var_4["position"];
        }

        waitframe();
    }
}

schedulemoneydrops()
{
    var_0 = [];
    var_0[var_0.size] = 100;
    var_0[var_0.size] = 100;
    var_0[var_0.size] = 300;
    var_0[var_0.size] = 400;
    var_0[var_0.size] = 600;
    var_0[var_0.size] = 700;
    var_0[var_0.size] = 800;
    var_0[var_0.size] = 1000;
    level.zmmoneyschedule = common_scripts\utility::array_randomize( var_0 );
    level.zmmoneyscheduleindex = 0;
}

getnextmoneyamount()
{
    if ( level.zmmoneyschedule.size == level.zmmoneyscheduleindex )
        schedulemoneydrops();

    var_0 = level.zmmoneyschedule[level.zmmoneyscheduleindex];
    level.zmmoneyscheduleindex++;
    return var_0;
}

roundlogic()
{
    level.zmcarepackagelandingspots = common_scripts\utility::getstructarray( "carepackageDropPosition", "targetname" );

    if ( level.zmcarepackagelandingspots.size == 0 )
        return;

    level.zmusedcarepackagelandingspots = [];
    level.getcratefordroptype = ::getcrate;
    level.zmkillstreakcrateprevo = 0;
    level.zmkillstreakcratereactvo = 0;
    level.zmkillstreakcratefirstvo = 0;
    thread setupdroppositions();
    thread schedulescorestreaks();
    thread schedulemoneydrops();
    var_0 = randomintrange( 3, 5 );

    for (;;)
    {
        level waittill( "zombie_wave_started" );

        if ( maps\mp\zombies\_util::_id_508F( level.disablecarepackagedrops ) )
            continue;

        while ( level.wavecounter >= var_0 )
        {
            var_1 = randomfloatrange( 20, 30 );
            var_2 = level common_scripts\utility::waittill_notify_or_timeout_return( "zombie_wave_ended", var_1 );

            if ( !isdefined( var_2 ) || var_2 != "timeout" )
                continue;

            if ( level.currentgen && isdefined( level.numzombierewarddrops ) && level.numzombierewarddrops >= 4 )
                continue;

            if ( isdefined( level.nodroppodpenalty ) && level.nodroppodpenalty == 1 )
                continue;

            if ( maps\mp\zombies\_util::_id_508F( level.disablecarepackagedrops ) )
                continue;

            var_2 = dropcarepackage();

            if ( isdefined( var_2 ) )
            {
                if ( isdefined( level.roundsupplydrops ) )
                    level.roundsupplydrops[level.roundsupplydrops.size] = var_2;

                if ( level.players.size == 4 )
                {
                    var_2 = dropcarepackage();

                    if ( isdefined( var_2 ) && isdefined( level.roundsupplydrops ) )
                        level.roundsupplydrops[level.roundsupplydrops.size] = var_2;
                }

                var_0 += randomintrange( 2, 4 );
            }
        }

        level waittill( "zombie_wave_ended" );
    }
}

getcloseplayertodroppoint( var_0 )
{
    var_1 = sortbydistance( level.players, var_0 );
    return var_1[0];
}

getcrate( var_0 )
{
    if ( level.zmscorestreaks.size == level.zmscorestreakindex )
        schedulescorestreaks();

    var_4 = level.zmscorestreaks[level.zmscorestreakindex];
    level.zmscorestreakindex++;
    return var_4;
}

dropcarepackage( var_0 )
{
    var_1 = getowner();

    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = getcratelandingspot( var_1 );

    if ( !isdefined( var_0 ) )
        return;

    if ( !var_0.indoors )
    {
        var_2 = maps\mp\killstreaks\_orbital_carepackage::_id_37E1( level.ocp_weap_name, var_1, var_0, "zombies", [], undefined, undefined, undefined, 0 );

        if ( isdefined( var_2 ) && !level.zmkillstreakcrateprevo )
        {
            var_1 = getcloseplayertodroppoint( var_0.origin );
            var_1 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "orbital_drop_pre" );
            level.zmkillstreakcrateprevo = 1;
        }
        else if ( isdefined( var_2 ) && isdefined( level.zmbcustomsupplydropvo ) )
            [[ level.zmbcustomsupplydropvo ]]();

        return var_2;
    }
    else
        return dropcratephysics( var_1, var_0 );
}

dropcratephysics( var_0, var_1 )
{
    var_2 = "airdrop_assault";
    var_3 = getcrate( var_2 );
    var_4 = var_0 maps\mp\killstreaks\_airdrop::_id_23E2( var_0, var_2, var_3, var_1.origin, undefined, 0, 1 );
    var_4 physicslaunchserver( ( 0.0, 0.0, 0.0 ) );
    var_4 thread maps\mp\killstreaks\_orbital_carepackage::_id_2374();
    var_4 maps\mp\killstreaks\_airdrop::_id_6802( var_2, var_3 );
    return var_3;
}

getowner()
{
    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) )
            return var_1;
    }
}

getcratelandingspot( var_0, var_1 )
{
    var_2 = 2;
    var_3 = getvalidnodes();

    if ( !isdefined( var_1 ) )
        var_1 = "carepackage";

    if ( var_3.size == 0 )
    {
        level.zmusedcarepackagelandingspots = [];
        var_3 = getvalidnodes();
    }

    var_3 = common_scripts\utility::array_randomize( var_3 );
    var_4 = undefined;
    var_5 = 0;

    foreach ( var_7 in var_3 )
    {
        if ( closetomarker( var_7.origin, var_1 ) )
            continue;

        if ( var_5 >= var_2 )
        {
            waitframe();
            var_5 = 0;
        }

        var_8 = _id_1B9F( var_7.groundorg, var_0, var_1 );
        var_5++;

        if ( var_8 )
        {
            var_4 = var_7;
            break;
        }
    }

    if ( isdefined( var_4 ) )
    {
        level.zmusedcarepackagelandingspots[level.zmusedcarepackagelandingspots.size] = var_4;
        return var_4;
    }
}

getvalidnodes()
{
    var_0 = [];

    foreach ( var_2 in level.zmcarepackagelandingspots )
    {
        if ( common_scripts\utility::array_contains( level.zmusedcarepackagelandingspots, var_2 ) )
            continue;

        if ( isdefined( var_2.script_noteworthy ) && !common_scripts\utility::flag( var_2.script_noteworthy ) )
            continue;

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

_id_40C9( var_0 )
{
    var_1 = undefined;
    var_2 = 2;
    var_3 = 5;

    for ( var_4 = var_2; var_4 < var_3; var_4++ )
    {
        var_5 = var_0.pers["killstreaks"][var_4];

        if ( !isdefined( var_5 ) || !isdefined( var_5.streakname ) || var_5.available == 0 )
        {
            var_1 = var_4;
            break;
        }
    }

    return var_1;
}

handlekillstreaklimit( var_0 )
{
    if ( !isdefined( _id_40C9( var_0 ) ) )
    {
        showstreaklimitreached( var_0 );
        return 1;
    }

    return 0;
}

showstreaklimitreached( var_0 )
{
    var_0 iclientprintlnbold( &"ZOMBIES_STREAK_LIMIT" );
}

closetomarker( var_0, var_1 )
{
    var_2 = 26;
    var_3 = 41;

    if ( var_1 == "goliath_suit" )
        var_4 = var_3;
    else
        var_4 = var_2;

    foreach ( var_6 in level._id_655A )
    {
        var_7 = var_4;

        if ( var_6._id_6576 == "goliath_suit" )
            var_7 += var_3;
        else
            var_7 += var_2;

        var_8 = var_7 * var_7;
        var_9 = _func_220( var_6.origin, var_0 );

        if ( var_9 < var_8 )
            return 1;
    }

    return 0;
}

_id_1B9F( var_0, var_1, var_2 )
{
    var_3 = 26;
    var_4 = 41;

    if ( var_2 == "goliath_suit" )
        var_5 = var_4;
    else
        var_5 = var_3;

    return _func_2AB( var_0 + ( 0.0, 0.0, 6.0 ), var_5, var_5 * 2, var_1, 0 );
}

_id_5396( var_0 )
{
    self endon( "death" );

    if ( !level.zmkillstreakcratereactvo )
    {
        var_1 = getcloseplayertodroppoint( self.origin );
        var_1 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "orbital_drop_react" );
        level.zmkillstreakcratereactvo = 1;
    }

    self.owner = undefined;
    var_2 = maps\mp\killstreaks\_airdrop::_id_40F5( var_0, self._id_2383 );
    var_3 = maps\mp\killstreaks\_airdrop::_id_4028( var_0, self._id_2383 );
    var_4 = isdefined( self.owner ) && ( self.owner maps\mp\_utility::_hasperk( "specialty_highroller" ) || isdefined( self._id_5D56 ) && self._id_5D56 );
    var_5 = undefined;

    if ( var_4 )
        var_5 = &"MP_PACKAGE_REROLL";

    var_6 = undefined;

    if ( isdefined( game["strings"][var_0 + self._id_2383 + "_hint"] ) )
        var_6 = game["strings"][var_0 + self._id_2383 + "_hint"];
    else
        var_6 = &"PLATFORM_GET_KILLSTREAK";

    maps\mp\killstreaks\_airdrop::_id_2380( var_6, var_5 );
    maps\mp\killstreaks\_airdrop::_id_237F( "all", maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon( var_2, var_3 ) );
    thread _id_237B();

    if ( var_4 )
        thread maps\mp\killstreaks\_airdrop::_id_237D();

    if ( self._id_51D6 )
        maps\mp\killstreaks\_airdrop::_id_2382();

    for (;;)
    {
        self waittill( "captured", var_1 );
        var_7 = _id_40C9( var_1 );
        var_2 = maps\mp\killstreaks\_airdrop::_id_40F5( var_0, self._id_2383 );
        var_3 = maps\mp\killstreaks\_airdrop::_id_4028( var_0, self._id_2383 );

        if ( isdefined( self.owner ) && var_1 != self.owner )
        {
            if ( !level.teambased || var_1.team != self.team )
            {
                if ( self._id_51D6 )
                {
                    var_1 thread maps\mp\killstreaks\_airdrop::_id_29B3( self, self.owner );
                    return;
                }
                else
                    var_1 thread maps\mp\_events::hijackerevent( self.owner );
            }
            else
                self.owner thread maps\mp\_events::sharedevent();
        }

        var_1 playlocalsound( "orbital_pkg_use" );

        if ( !level.zmkillstreakcratefirstvo )
        {
            var_1 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "orbital_drop_1st_get" );
            level.zmkillstreakcratefirstvo = 1;
        }
        else
            var_1 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "ss_crate_capture" );

        var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify( var_2, undefined, undefined, var_3, var_7 );
        var_1 thread maps\mp\killstreaks\_killstreaks::givekillstreak( var_2, 0, 0, var_1, var_3, var_7 );

        if ( isdefined( level.mapkillstreak ) && level.mapkillstreak == self._id_2383 )
            var_1 thread maps\mp\_events::mapkillstreakevent();

        var_8 = 1;
        var_9 = var_1 maps\mp\_utility::_hasperk( "specialty_highroller" ) && ( !level.teambased || var_1.team != self.team );
        var_10 = isdefined( self._id_5D58 ) && self._id_5D58;
        var_11 = var_10 && ( self.owner == var_1 || level.teambased && var_1.team == self.team );

        if ( var_9 || var_11 )
        {
            var_12 = var_1 maps\mp\killstreaks\_airdrop::_id_23E2( var_1, "booby_trap", "booby_trap", self.origin, self.angles );

            if ( isdefined( var_12._id_32B4 ) )
                var_12._id_32B4 thread maps\mp\killstreaks\_orbital_carepackage::_id_6559( 1 );

            var_12 thread maps\mp\killstreaks\_airdrop::_id_1565( self );
            level thread maps\mp\killstreaks\_airdrop::_id_2F94( var_12, var_12.owner, var_12._id_2383 );
            var_8 = 0;

            if ( isdefined( var_12._id_3AB6 ) )
                var_12._id_3AB6 solid();

            if ( isdefined( var_12._id_32B4 ) )
                var_12._id_32B4 solid();
        }

        maps\mp\killstreaks\_airdrop::_id_2847( var_8 );
    }
}

_id_237B( var_0, var_1, var_2 )
{
    self endon( "captured" );
    var_3 = self;

    if ( isdefined( self._id_65AF ) )
        var_3 = self._id_65AF;

    if ( !isdefined( var_2 ) )
        var_2 = 2000;

    if ( level.currentgen )
    {
        if ( isdefined( self.cratestringent ) )
            var_3 = self.cratestringent;
    }

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    while ( isdefined( self ) )
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( self.owner ) && var_4 == self.owner )
            continue;

        if ( !var_1 && handlekillstreaklimit( var_4 ) )
            continue;

        if ( var_4 isjumping() || isdefined( var_4.exo_hover_on ) && var_4.exo_hover_on )
            continue;

        if ( !var_4 isonground() && !maps\mp\killstreaks\_airdrop::_id_A04A( var_4 ) )
            continue;

        if ( !maps\mp\killstreaks\_airdrop::_id_9C45( var_4 ) )
            continue;

        var_4.iscapturingcrate = 1;
        var_5 = maps\mp\killstreaks\_airdrop::_id_244B();
        var_6 = 0;

        if ( self._id_2383 == "booby_trap" )
            var_6 = var_5 maps\mp\killstreaks\_airdrop::useholdthink( var_4, 500, var_0 );
        else
            var_6 = var_5 maps\mp\killstreaks\_airdrop::useholdthink( var_4, var_2, var_0 );

        if ( isdefined( var_5 ) )
            var_5 delete();

        if ( !var_6 )
        {
            if ( isdefined( var_4 ) )
                var_4.iscapturingcrate = 0;

            continue;
        }

        var_4.iscapturingcrate = 0;

        if ( isdefined( level.numzombierewarddrops ) )
            level.numzombierewarddrops--;

        self notify( "captured", var_4 );
    }
}

moneycratethink( var_0 )
{
    self endon( "death" );
    self.owner = undefined;
    var_1 = undefined;

    if ( isdefined( game["strings"][var_0 + self._id_2383 + "_hint"] ) )
        var_1 = game["strings"][var_0 + self._id_2383 + "_hint"];
    else
        var_1 = &"PLATFORM_GET_KILLSTREAK";

    maps\mp\killstreaks\_airdrop::_id_2380( var_1 );
    maps\mp\killstreaks\_airdrop::_id_237F( "all", "hud_carepkg_world_credits" );
    thread _id_237B( undefined, 1 );

    for (;;)
    {
        self waittill( "captured", var_2 );
        var_2 playlocalsound( "zmb_ss_credits_acquire" );
        var_2 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo( "ss_money" );
        var_3 = getnextmoneyamount();
        var_2 maps\mp\gametypes\zombies::_id_41FB( "crate", var_3, 1 );
        maps\mp\killstreaks\_airdrop::_id_2847( 1 );
    }
}

modifydamagekillstreak( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_2;

    if ( isplayer( var_1 ) && isagent( var_0 ) )
    {
        if ( maps\mp\zombies\_util::_id_508F( self.resistanttosquadmatedamage ) )
            return int( var_5 * 0.5 );
        else
            return var_5 * level.wavecounter;
    }

    switch ( var_3 )
    {
        case "sentry_minigun_mp":
        case "ugv_missile_mp":
        case "drone_assault_remote_turret_mp":
        case "remote_energy_turret_mp":
        case "killstreakmahem_mp":
            if ( maps\mp\zombies\_util::istrapresistant() )
                var_5 = int( var_5 * 0.1 );
            else
                var_5 *= 3;

            break;
        case "turretheadmg_mp":
            var_5 = 200 + level.wavecounter * 10;
            break;
        case "turretheadrocket_mp":
            var_5 = 800 + level.wavecounter * randomintrange( 50, 75 );
            break;
        case "turretheadenergy_mp":
            var_5 = var_5 * 3 + int( level.wavecounter / 2 );
            break;
        case "iw5_exominigunzm_mp":
            if ( isdefined( var_4 ) && var_4 == "MOD_MELEE_ALT" && !maps\mp\zombies\_util::instakillimmune() )
                var_5 = self.health + 1;
            else if ( isdefined( var_4 ) && var_4 == "MOD_MELEE_ALT" )
                var_5 = level.wavecounter * 50;
            else
                var_5 = 2000;

            break;
        case "playermech_rocket_zm_mp":
            var_5 = 7000;
            break;
        case "iw5_juggernautrocketszm_mp":
            var_5 = 3500;
            break;
        default:
            break;
    }

    return var_5;
}
