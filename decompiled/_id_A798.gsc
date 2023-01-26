// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

_id_5175( var_0 )
{
    return isdefined( var_0.laststand ) && var_0.laststand;
}

_id_5164( var_0 )
{
    if ( isdefined( var_0.team ) )
        return var_0.team == level._id_6D6C;

    return 0;
}

_id_5165( var_0 )
{
    if ( isdefined( var_0.team ) )
    {
        if ( var_0.team == level._id_6D6C || var_0.team == "spectator" )
            return 1;
    }

    return 0;
}

_id_4056()
{
    var_0 = 0;

    if ( !isdefined( level.players ) )
        return 0;

    foreach ( var_2 in level.players )
    {
        if ( _id_5164( var_2 ) )
            var_0++;
    }

    return var_0;
}

_id_852A( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( _id_5164( var_2 ) && maps\mp\_utility::isreallyalive( var_2 ) )
            var_2 thread maps\mp\gametypes\_hud_message::splashnotify( var_0 );
    }
}

_id_4711( var_0 )
{
    var_1 = 0;

    if ( isagent( var_0 ) )
        return var_1;

    foreach ( var_3 in var_0.pers["killstreaks"] )
    {
        if ( isdefined( var_3 ) && isdefined( var_3.streakname ) && var_3.available && var_3.streakname == "agent" )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

_id_4090( var_0 )
{
    var_1 = var_0 getcurrentprimaryweapon();

    if ( isdefined( var_0.changingweapon ) )
        var_1 = var_0.changingweapon;

    if ( !maps\mp\gametypes\_weapons::isprimaryweapon( var_1 ) )
        var_1 = var_0 common_scripts\utility::getlastweapon();

    if ( !var_0 hasweapon( var_1 ) )
        var_1 = var_0 maps\mp\killstreaks\_killstreaks::getfirstprimaryweapon();

    return var_1;
}

_id_6DDB( var_0 )
{
    level endon( "game_ended" );

    foreach ( var_2 in level.players )
    {
        if ( !maps\mp\_utility::isreallyalive( var_2 ) )
            continue;

        if ( !_id_5164( var_2 ) )
            continue;

        var_2 playsoundtoplayer( var_0, var_2 );
    }
}

_id_72AC( var_0 )
{
    var_1 = var_0 getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( issubstr( var_3, "iw5_microdronelaunchercoop_mp" ) )
        {
            var_4 = var_0 getweaponammostock( var_3 );
            var_5 = _func_1E1( var_3 );
            var_6 = var_4 / var_5 + 0.5;
            var_0 givemaxammo( var_3, var_6 );
            continue;
        }

        if ( !issubstr( var_3, "turrethead" ) )
            var_0 givemaxammo( var_3 );
    }
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

_id_4989( var_0 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );
    level endon( "stop_enable_weapons" );

    for (;;)
    {
        var_0 waittill( "luinotifyserver", var_1, var_2 );

        if ( var_1 == "horde_close_armory" )
        {
            var_0 enableweapons();
            level notify( "stop_enable_weapons" );
        }

        waitframe();
    }
}

_id_120A( var_0 )
{
    if ( var_0._id_53B5 < 65535 )
        var_0._id_53B5++;

    var_0 _meth_8526( "killsTotal", var_0._id_53B5 );

    if ( var_0._id_53B5 > var_0 _meth_8525( "killsBest" ) )
        var_0 _meth_8526( "killsBest", var_0._id_53B5 );

    var_0.kills = var_0._id_53B5;
    var_0 maps\mp\_utility::setpersstat( "kills", var_0.kills );
    var_0._id_7654++;
}

_id_1209( var_0, var_1 )
{
    var_0._id_499D += var_1;

    if ( var_0._id_499D > 65535 )
        var_0._id_499D = 65535;

    var_0 maps\mp\_utility::setpersstat( "headshots", var_1 );
}

awardhordemeleekills( var_0 )
{
    if ( var_0.meleekills < 65535 )
        var_0.meleekills++;

    var_0 _meth_8526( "meleeKillsTotal", var_0.meleekills );

    if ( var_0.meleekills > var_0 _meth_8525( "meleeKillsBest" ) )
        var_0 _meth_8526( "meleeKillsBest", var_0.meleekills );
}

awardhordeheadshotkills( var_0 )
{
    if ( var_0.headshotkills < 65535 )
        var_0.headshotkills++;

    var_0 _meth_8526( "headshotKillsTotal", var_0.headshotkills );

    if ( var_0.headshotkills > var_0 _meth_8525( "headshotKillsBest" ) )
        var_0 _meth_8526( "headshotKillsBest", var_0.headshotkills );
}

awardhordeobjectivescompleted( var_0 )
{
    if ( var_0.objectivescompleted < 65535 )
        var_0.objectivescompleted++;

    var_0 _meth_8526( "objectivesTotal", var_0.objectivescompleted );

    if ( var_0.objectivescompleted > var_0 _meth_8525( "objectivesBest" ) )
        var_0 _meth_8526( "objectivesBest", var_0.objectivescompleted );
}

awardhordesupportdrop( var_0 )
{
    if ( var_0.numcratesobtained < 65535 )
        var_0.numcratesobtained++;

    var_0 _meth_8526( "cratesTotal", var_0.numcratesobtained );

    if ( var_0.numcratesobtained > var_0 _meth_8525( "cratesBest" ) )
        var_0 _meth_8526( "cratesBest", var_0.numcratesobtained );

    var_0.extrascore0 = var_0.numcratesobtained;
    var_0 maps\mp\_utility::setpersstat( "extrascore0", var_0.numcratesobtained );
}

_id_120B( var_0 )
{
    if ( var_0._id_62AA < 65535 )
        var_0._id_62AA++;

    var_0 _meth_8526( "revivesTotal", var_0._id_62AA );

    if ( var_0._id_62AA > var_0 _meth_8525( "revivesBest" ) )
        var_0 _meth_8526( "revivesBest", var_0._id_62AA );

    var_0.assists = int( var_0._id_62AA / 128 );
    var_0.extrascore1 = var_0._id_62AA % 128;
    var_0 maps\mp\_utility::setpersstat( "assists", var_0.assists );
    var_0 maps\mp\_utility::setpersstat( "extrascore1", var_0.extrascore1 );
}

_id_120C( var_0 )
{
    if ( var_0._id_7656 < 65535 )
        var_0._id_7656++;

    var_0 _meth_8526( "roundsTotal", var_0._id_7656 );

    if ( var_0._id_7656 > var_0 _meth_8525( "roundsBest" ) )
        var_0 _meth_8526( "roundsBest", var_0._id_7656 );

    var_1 = _id_4994();

    if ( var_1 == -1 )
        return;

    var_2 = 0;

    if ( var_1 < 4 )
        var_2 = 1;
    else if ( var_1 < 8 )
    {
        var_3 = 0;

        for ( var_4 = 0; var_4 < 4; var_4++ )
            var_3 += var_0 _meth_8525( "numWavesCompleted", var_4 );

        if ( var_3 >= 50 )
            var_2 = 1;
    }
    else if ( var_1 < 12 )
    {
        var_3 = 0;

        for ( var_4 = 4; var_4 < 8; var_4++ )
            var_3 += var_0 _meth_8525( "numWavesCompleted", var_4 );

        if ( var_3 >= 75 )
            var_2 = 1;
    }
    else if ( var_1 == 12 )
    {
        var_3 = 0;

        for ( var_4 = 8; var_4 < 12; var_4++ )
            var_3 += var_0 _meth_8525( "numWavesCompleted", var_4 );

        if ( var_3 >= 100 )
            var_2 = 1;
    }

    if ( var_2 )
    {
        var_5 = var_0 _meth_8525( "numWavesCompleted", var_1 );

        if ( var_5 < 65535 )
            var_5++;

        var_0 _meth_8526( "numWavesCompleted", var_1, var_5 );

        if ( var_0._id_7656 > var_0 _meth_8525( "highestWave", var_1 ) )
            var_0 _meth_8526( "highestWave", var_1, var_0._id_7656 );
    }
}

_id_120D( var_0, var_1 )
{

}

_id_49D8( var_0, var_1 )
{
    var_0.horde_score += var_1;

    if ( var_0.horde_score > 16777215 )
        var_0.horde_score = 16777215;

    var_0 _meth_8526( "scoreTotal", var_0.horde_score );

    if ( var_0.horde_score > var_0 _meth_8525( "scoreBest" ) )
        var_0 _meth_8526( "scoreBest", var_0.horde_score );

    var_2 = int( 0 );
    var_3 = int( 0 );
    var_2 = int( var_0.horde_score / 512 );
    var_3 = 511 - var_0.horde_score % 512;
    var_0.score = var_2;
    var_0.deaths = var_3;
    var_0 maps\mp\_utility::setpersstat( "score", var_0.score );
    var_0 maps\mp\_utility::setpersstat( "deaths", var_0.deaths );
}

_id_49CD()
{
    self.origin -= ( 0.0, 0.0, 9999.0 );
}

_id_49CE()
{
    self.origin += ( 0.0, 0.0, 9999.0 );
}

_id_4991( var_0 )
{
    if ( level.players.size == 0 )
        return undefined;

    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( var_3.ignoreme == 1 || var_3.sessionstate == "spectator" )
            continue;

        var_1 = common_scripts\utility::array_add( var_1, var_3 );
    }

    if ( var_1.size > 0 )
    {
        var_3 = common_scripts\utility::getclosest( var_0, var_1 );
        return var_3;
    }
    else
        return undefined;
}

_id_4990( var_0 )
{
    if ( level.players.size == 0 )
        return undefined;

    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( !var_3.ignoreme && var_3.sessionstate != "spectator" )
            var_1[var_1.size] = var_3;

        if ( isdefined( var_3.turret ) && !var_3.iscarrying && isdefined( var_3.turret.damagetaken ) && var_3.turret.damagetaken < var_3.turret.maxhealth )
            var_1[var_1.size] = var_3.turret;

        if ( isdefined( var_3.aerialassaultdrone ) )
            var_1[var_1.size] = var_3.aerialassaultdrone;
    }

    var_5 = 500000000;
    var_6 = undefined;

    foreach ( var_8 in var_1 )
    {
        var_9 = distancesquared( var_8.origin, var_0.origin );

        if ( var_9 < var_5 )
        {
            var_5 = var_9;
            var_6 = var_8;
        }
    }

    return var_6;
}

hordegetclosehealthyenemyforturret( var_0 )
{
    var_1 = ( 0.0, 0.0, 72.0 );
    var_2 = ( 0.0, 0.0, 60.0 );
    var_3 = ( 0.0, 0.0, 40.0 );

    if ( level.players.size == 0 )
        return undefined;

    var_4 = [];
    var_5 = [];

    foreach ( var_7 in level.players )
    {
        if ( !var_7.ignoreme && var_7.sessionstate != "spectator" )
            var_5[var_5.size] = var_7;

        if ( isdefined( var_7.turret ) && !var_7.iscarrying && isdefined( var_7.turret.damagetaken ) && var_7.turret.damagetaken < var_7.turret.maxhealth )
            var_4[var_4.size] = var_7.turret;

        if ( isdefined( var_7.aerialassaultdrone ) )
            var_4[var_4.size] = var_7.aerialassaultdrone;
    }

    var_9 = 500000000;
    var_10 = undefined;

    foreach ( var_7 in var_5 )
    {
        var_12 = distancesquared( var_7.origin, var_0.origin );

        if ( var_12 < var_9 )
        {
            if ( sighttracepassed( var_7.origin + var_1, var_0.origin + var_2, 0, undefined ) )
            {
                var_9 = var_12;
                var_10 = var_7;
            }
        }
    }

    if ( isdefined( var_10 ) )
        return var_10;

    var_9 = 500000000;

    foreach ( var_15 in var_4 )
    {
        var_12 = distancesquared( var_15.origin, var_0.origin );

        if ( var_12 < var_9 )
        {
            var_16 = var_15.origin;

            if ( isdefined( var_15.issentry ) && var_15.issentry )
                var_16 += var_3;

            if ( sighttracepassed( var_16, var_0.origin + var_3, 0, self, var_15 ) )
            {
                var_9 = var_12;
                var_10 = var_15;
            }
        }
    }

    return var_10;
}

_id_49C0( var_0, var_1, var_2, var_3 )
{
    var_0 notify( "horde_score_streak_splash_request" );
    var_0 endon( "horde_score_streak_splash_request" );

    while ( var_0 getclientomnvar( "ui_horde_show_armory" ) != 0 )
        waitframe();

    var_0 thread maps\mp\gametypes\_hud_message::splashnotify( var_2, undefined, var_3 );
    var_0 maps\mp\_utility::leaderdialogonplayer( var_1, "horde", 0 );
}

_id_49BA( var_0, var_1, var_2 )
{
    if ( var_2 != 1 )
    {
        var_3 = "ks_icon" + common_scripts\utility::tostring( var_2 );
        self setclientomnvar( var_3, 0 );
    }
}

_id_4953( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "default";

    maps\mp\_utility::playerallowdodge( var_0, var_1 );
    maps\mp\_utility::playerallowpowerslide( var_0, var_1 );
    maps\mp\_utility::playerallowhighjump( var_0, var_1 );
}

_id_9894( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 playlocalsound( "ammo_crate_use" );
    var_6 = var_0 getclientomnvar( "ui_horde_player_class" );

    if ( isdefined( var_4 ) )
        var_7 = var_4;
    else
        var_7 = "none";

    var_8 = var_0 getweaponslistprimaries();
    var_9 = getweaponbasename( var_1 );

    if ( var_8.size > 1 && !isdefined( var_0.underwater ) )
    {
        var_10 = 1;

        if ( !isdefined( var_7 ) || var_7 == "none" )
            var_7 = var_0 getcurrentprimaryweapon();

        var_0 takeweapon( var_7 );
    }

    var_11 = var_0._id_A2DB > 0 && isdefined( var_2 ) && var_2;

    if ( var_11 )
    {
        var_0._id_9BA2 = 1;
        var_12 = getweaponbasename( var_1 );
        var_13 = getsubstr( var_1, var_12.size );
        var_1 = var_12 + var_13;
    }

    var_14 = [];

    if ( getweaponbasename( var_1 ) == "iw5_microdronelaunchercoop_mp" )
        var_14[var_14.size] = "iw5_microdronelauncher_mp";

    var_14[var_14.size] = var_1;
    var_15 = !var_0 loadweapons( var_14 );

    for ( var_0.classweaponswait = var_15; var_15; var_15 = !var_0 loadweapons( var_14 ) )
        waitframe();

    var_0 loadweapons( _id_A795::hordelaststandweapon() );
    var_0 loadweapons( [ "iw5_microdronelauncher_mp" ] );

    if ( issubstr( var_1, "camo" ) )
        var_1 = getsubstr( var_1, 0, var_1.size - 7 );

    var_16 = _id_3F21( var_0 );
    var_17 = _id_3F20( var_0 );
    var_0 maps\mp\_utility::_giveweapon( var_1, var_17 );
    var_0 givemaxammo( var_1 + var_16, 1 );

    if ( var_11 )
        var_0._id_9BA2 = 0;

    if ( isdefined( var_3 ) && var_3 )
        var_0 switchtoweaponimmediate( var_1 + var_16 );

    if ( isdefined( var_5 ) )
        var_0._id_4964[var_6][var_5] = var_1 + var_16;
    else if ( var_7 == var_0._id_4964[var_6]["primary"] )
        var_0._id_4964[var_6]["primary"] = var_1 + var_16;
    else
        var_0._id_4964[var_6]["secondary"] = var_1 + var_16;
}

_id_3F21( var_0 )
{
    var_1 = "";

    if ( var_0._id_A2DB > 0 )
        var_1 = "_camo" + level._id_A2CB[var_0._id_A2DB];

    return var_1;
}

_id_3F20( var_0 )
{
    var_1 = 0;
    var_2 = "";

    if ( var_0._id_A2DB > 0 )
    {
        var_2 = level._id_A2CB[var_0._id_A2DB];
        var_2 = _id_8F55( var_2, "0" );
        var_1 = int( var_2 );
    }

    return var_1;
}

_id_4997( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];
    var_4 = getweaponbasename( var_0 );

    if ( var_4 == var_0 )
        return var_2;

    var_5 = getsubstr( var_0, var_4.size );
    var_6 = strtok( var_5, "_" );

    for ( var_7 = 0; var_7 < var_6.size; var_7++ )
    {
        if ( !issubstr( var_6[var_7], "camo" ) )
            var_3[var_3.size] = var_6[var_7];
    }

    return var_3;
}

_id_498F( var_0, var_1 )
{
    var_2 = "";

    if ( var_0.size )
    {
        var_3 = var_0.size;

        for ( var_4 = 0; var_4 < var_3; var_4++ )
        {
            if ( ( issubstr( var_0[var_4], "optics" ) || issubstr( var_0[var_4], "reddot" ) || issubstr( var_0[var_4], "scope" ) ) && ( issubstr( var_1, "optics" ) || issubstr( var_1, "reddot" ) || issubstr( var_1, "scope" ) ) )
            {
                var_0[var_4] = var_1;
                continue;
            }

            var_0[var_0.size] = var_1;
        }
    }
    else
        var_0[0] = var_1;

    var_0 = common_scripts\utility::array_remove_duplicates( var_0 );
    var_0 = common_scripts\utility::alphabetize( var_0 );

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
        var_2 = var_2 + "_" + var_0[var_4];

    return var_2;
}

hordegetweaponbasenamespecial( var_0 )
{
    var_1 = getweaponbasename( var_0 );

    if ( issubstr( var_0, "exoxmg" ) )
        var_1 = "iw5_exoxmg_mp_akimboxmg";
    else if ( issubstr( var_0, "sac3" ) )
        var_1 = "iw5_sac3_mp_akimbosac3";
    else if ( issubstr( var_0, "mors" ) )
        var_1 = "iw5_mors_mp_morsscope";
    else if ( issubstr( var_0, "gm6" ) )
        var_1 = "iw5_gm6_mp_gm6scope";
    else if ( issubstr( var_0, "m990" ) )
        var_1 = "iw5_m990_mp_m990scope";
    else if ( issubstr( var_0, "thor" ) )
        var_1 = "iw5_thor_mp_thorscope";

    return var_1;
}

hordegetweaponsuffixspecial( var_0 )
{
    var_1 = "_mp";

    if ( issubstr( var_0, "exoxmg" ) )
        var_1 = "_mp_akimboxmg";
    else if ( issubstr( var_0, "sac3" ) )
        var_1 = "_mp_akimbosac3";
    else if ( issubstr( var_0, "mors" ) )
        var_1 = "_mp_morsscope";
    else if ( issubstr( var_0, "gm6" ) )
        var_1 = "_mp_gm6scope";
    else if ( issubstr( var_0, "m990" ) )
        var_1 = "_mp_m990scope";
    else if ( issubstr( var_0, "thor" ) )
        var_1 = "_mp_thorscope";

    return var_1;
}

_id_2007( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 50;

    return randomint( 100 ) <= var_0;
}

_id_4994()
{
    var_0 = [ "mp_lab2", "mp_venus", "mp_detroit", "mp_refraction", "mp_levity", "mp_comeback", "mp_terrace", "mp_instinct", "mp_greenband", "mp_solar", "mp_recovery", "mp_laser2", "mp_prison_z" ];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( maps\mp\_utility::getmapname() == var_0[var_1] )
            return var_1;
    }

    return -1;
}

hordecleardata( var_0 )
{
    var_0 _meth_8526( "roundsTotal", 0 );
    var_0 _meth_8526( "matchesTotal", 0 );
    var_0 _meth_8526( "scoreTotal", 0 );
    var_0 _meth_8526( "killsTotal", 0 );
    var_0 _meth_8526( "cratesTotal", 0 );
    var_0 _meth_8526( "revivesTotal", 0 );
    var_0 _meth_8526( "objectivesTotal", 0 );
    var_0 _meth_8526( "meleeKillsTotal", 0 );
    var_0 _meth_8526( "headshotKillsTotal", 0 );
    var_0 _meth_8526( "timePlayedTotal", 0 );
}

hordecompletetu1transition( var_0 )
{
    for ( var_1 = 0; var_1 < 13; var_1++ )
    {
        var_2 = var_0 _meth_8525( "highestWave", var_1 );
        var_3 = var_0 _meth_8525( "numWavesCompleted", var_1 );

        if ( var_2 > var_3 )
            var_0 _meth_8526( "numWavesCompleted", var_1, var_2 );
    }
}

hordeupdatetimestats( var_0 )
{
    var_1 = int( getomnvar( "ui_game_duration" ) / 1000 );
    var_0 _meth_8526( "timePlayedTotal", var_1 );

    if ( var_1 > var_0 _meth_8525( "timePlayedBest" ) )
        var_0 _meth_8526( "timePlayedBest", var_1 );

    _id_1CB2( var_0 );
}

_id_41E8( var_0 )
{
    var_1 = var_0 _meth_8525( "numWaves" );

    if ( var_1 < 32767 )
    {
        var_1++;
        var_0 _meth_8526( "numWaves", var_1 );
    }

    if ( var_1 > 199 && !var_0 _meth_8525( "requirement_beat200Waves" ) )
    {
        var_0 _meth_8526( "requirement_beat200Waves", 1 );
        var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
    }
    else if ( var_1 > 99 && !var_0 _meth_8525( "requirement_beat100Waves" ) )
    {
        var_0 _meth_8526( "requirement_beat100Waves", 1 );
        var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
    }
    else if ( var_1 > 49 && !var_0 _meth_8525( "requirement_beat50Waves" ) )
    {
        var_0 _meth_8526( "requirement_beat50Waves", 1 );
        var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
    }
}

_id_41E5( var_0 )
{
    var_1 = _id_4994();

    if ( var_1 == -1 )
        return;

    if ( !var_0 _meth_8525( "requirement_unlockedTier2" ) )
    {
        var_2 = 0;

        for ( var_3 = 0; var_3 < 4; var_3++ )
            var_2 += var_0 _meth_8525( "numWavesCompleted", var_3 );

        if ( var_1 < 4 )
            var_2 += var_0._id_7656;

        if ( var_2 >= 50 )
        {
            var_0 _meth_8526( "requirement_unlockedTier2", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
            return;
        }
    }
    else if ( !var_0 _meth_8525( "requirement_unlockedTier3" ) )
    {
        var_2 = 0;

        for ( var_3 = 4; var_3 < 8; var_3++ )
            var_2 += var_0 _meth_8525( "numWavesCompleted", var_3 );

        if ( var_1 >= 4 && var_1 < 8 )
            var_2 += var_0._id_7656;

        if ( var_2 >= 75 )
        {
            var_0 _meth_8526( "requirement_unlockedTier3", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
            return;
        }
    }
    else if ( !var_0 _meth_8525( "requirement_unlockedPrison" ) )
    {
        var_2 = 0;

        for ( var_3 = 8; var_3 < 12; var_3++ )
            var_2 += var_0 _meth_8525( "numWavesCompleted", var_3 );

        if ( var_1 >= 8 && var_1 < 12 )
            var_2 += var_0._id_7656;

        if ( var_2 >= 100 )
        {
            var_0 _meth_8526( "requirement_unlockedPrison", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
            return;
        }
    }
    else if ( !var_0 _meth_8525( "requirement_playedAllMaps" ) )
    {
        var_4 = 1;

        for ( var_3 = 0; var_3 < 13; var_3++ )
        {
            if ( var_0 _meth_8525( "numWavesCompleted", var_3 ) == 0 && var_1 != var_3 )
            {
                var_4 = 0;
                break;
            }
        }

        if ( var_4 )
        {
            var_0 _meth_8526( "requirement_playedAllMaps", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
        }
    }
}

_id_41E7( var_0 )
{
    if ( !var_0 _meth_8525( "requirement_maxWeaponProficiency" ) )
    {
        if ( var_0._id_A2DB > 9 )
        {
            var_0 _meth_8526( "requirement_maxWeaponProficiency", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
        }
    }
}

_id_41E6( var_0 )
{
    if ( !var_0 _meth_8525( "requirement_maxArmorProficiency" ) )
    {
        if ( var_0._id_4957 > 9 )
        {
            var_0 _meth_8526( "requirement_maxArmorProficiency", 1 );
            var_0 setclientomnvar( "ui_horde_loot_unlocked", 1 );
        }
    }
}

_id_8F55( var_0, var_1 )
{
    if ( var_0.size <= var_1.size )
        return var_0;

    if ( getsubstr( var_0, 0, var_1.size ) == var_1 )
        return getsubstr( var_0, var_1.size, var_0.size );

    return var_0;
}

hordeupdatenummatches( var_0 )
{
    var_0._id_3511 = var_0 _meth_8525( "numMatches" );

    if ( var_0._id_3511 < 32767 )
    {
        var_0._id_3511 += 1;
        var_0 _meth_8526( "numMatches", var_0._id_3511 );
    }

    if ( var_0._id_3511 == 50 )
        var_0 _meth_80F9( "COOP_VETERAN" );
}

_id_1CB2( var_0 )
{
    var_1 = var_0 getclientomnvar( "ui_horde_player_class" );
    var_0._id_495F = gettime();

    if ( isdefined( var_0._id_4962 ) )
    {
        var_2 = int( ( var_0._id_495F - var_0._id_4962 ) / 100 );
        var_3 = 0;

        switch ( var_1 )
        {
            case "light":
                var_3 = var_0 _meth_8525( "lightClassTime" );

                if ( isdefined( var_3 ) )
                {
                    var_3 += int( var_2 / 10 );

                    if ( var_3 <= 7200 )
                        var_0 _meth_8526( "lightClassTime", var_3 );
                }

                break;
            case "heavy":
                var_3 = var_0 _meth_8525( "heavyClassTime" );

                if ( isdefined( var_3 ) )
                {
                    var_3 += int( var_2 / 10 );

                    if ( var_3 <= 7200 )
                        var_0 _meth_8526( "heavyClassTime", var_3 );
                }

                break;
            case "support":
                var_3 = var_0 _meth_8525( "specialistClassTime" );

                if ( isdefined( var_3 ) )
                {
                    var_3 += int( var_2 / 10 );

                    if ( var_3 <= 7200 )
                        var_0 _meth_8526( "specialistClassTime", var_3 );
                }

                break;
        }
    }

    var_4 = var_0 _meth_8525( "lightClassTime" );
    var_5 = var_0 _meth_8525( "heavyClassTime" );
    var_6 = var_0 _meth_8525( "specialistClassTime" );

    if ( isdefined( var_4 ) && isdefined( var_5 ) && isdefined( var_6 ) )
    {
        if ( var_4 >= 1800 && var_5 >= 1800 && var_6 >= 1800 )
            var_0 _meth_80F9( "COOP_WARFARE" );
    }

    var_0._id_4962 = gettime();
}

hordegivebackgoliath( var_0 )
{
    if ( var_0 )
    {
        self notify( "cancel_goliath_wait" );
        self setclientomnvar( "ks_count1", 0 );
        self setclientomnvar( "ks_count_updated", 1 );
        self._id_1E31 = 1;
        var_1 = maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex( 1 );
        thread maps\mp\killstreaks\_killstreaks::givehordekillstreak( self._id_2518[1], level.owner, self._id_49A6, 1, 1 );
        thread _id_49C0( self, self._id_2518[1], "horde_ss_splash_" + self._id_2518[1], var_1 );
        self notify( "ability_regenerated" );
    }
    else
        _id_A791::_id_499A( "heavy_exosuit", 1007 );
}

hordeonunderwater( var_0 )
{
    if ( isplayer( self ) )
    {
        if ( isdefined( level.objuplink ) && level.objuplink )
        {
            var_1 = 1;

            foreach ( var_3 in level.balls )
            {
                if ( isdefined( var_3.carrier ) && var_3.carrier == self )
                {
                    self.water_last_weapon = maps\mp\gametypes\_gameobjects::getcarrierweaponcurrent( var_3 );
                    var_3 thread maps\mp\gametypes\_gameobjects::setdropped();
                    var_1 = 0;
                }
            }

            if ( var_1 )
            {
                if ( self getcurrentweapon() == "iw5_carrydrone_mp" && isdefined( self.changingweapon ) )
                    self.water_last_weapon = self.changingweapon;
                else if ( isdefined( self.pass_or_throw_active ) && self.pass_or_throw_active )
                {
                    var_5 = self getweaponslistprimaries();
                    self.water_last_weapon = common_scripts\utility::ter_op( var_5.size, var_5[0], undefined );
                }
            }
        }

        var_6 = "none";

        if ( isdefined( self.water_last_weapon ) )
            var_6 = self.water_last_weapon;

        maps\mp\gametypes\_weapons::saveweapon( "underwater", var_6, level.shallow_water_weapon );
    }
}

hordedropandresetuplinkball()
{
    if ( isdefined( self.ball_carried ) )
    {
        var_0 = self.ball_carried;
        var_0 maps\mp\gametypes\horde_ball::ball_set_dropped( 1 );
        var_0 maps\mp\gametypes\horde_ball::ball_return_home();
    }
}
