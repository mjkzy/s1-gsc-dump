// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    _id_4D88();
    level thread onplayerconnect();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );

        if ( !isdefined( var_0.pers["stats"] ) )
            var_0.pers["stats"] = [];

        var_0.stats = var_0.pers["stats"];

        if ( !var_0.stats.size )
        {
            foreach ( var_3, var_2 in level._id_005F )
                var_0 maps\mp\_utility::initplayerstat( var_3, level._id_005F[var_3]._id_27A0 );
        }
    }
}

_id_4D88()
{
    _id_4E25( "headshots", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "multikill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "avengekills", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "comebacks", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "rescues", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "longshots", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "revengekills", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "bulletpenkills", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "throwback_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "firstblood", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "posthumous", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assistedsuicide", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "buzzkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "oneshotkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "air_to_air_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "air_to_ground_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "ground_to_air_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "doublekill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "triplekill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "fourkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "fivekill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sixkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sevenkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "eightkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "hijacker", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "backstab", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "5killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "10killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "15killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "20killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "25killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "30killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "30pluskillstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "pointblank", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "firstplacekill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "boostslamkill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assault", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "defends", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "exo_knife_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "exo_knife_recall_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "near_death_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "slide_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "flash_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "riot_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "melee_air_to_air", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assist_riot_shield", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "semtex_stick", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "stuck_with_explosive", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "crossbow_stick", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "multiKillOneBullet", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "think_fast", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "take_and_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "four_play", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sharepackage", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "map_killstreak", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killstreak_tag", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killstreak_join", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "kills", 0, 0, ::_id_488B );
    _id_4E25( "longestkillstreak", 0, 0, ::_id_488B );
    _id_4E25( "knifekills", 0, 0, ::_id_488B );
    _id_4E25( "kdratio", 0, 0, ::_id_488B );
    _id_4E25( "deaths", 0, 0, ::_id_58AA );
    _id_4E25( "assists", 0, 0, ::_id_488B );
    _id_4E25( "totalGameScore", 0, 0, ::_id_488B );
    _id_4E25( "scorePerMinute", 0, 0, ::_id_488B );
    _id_4E25( "mostScorePerLife", 0, 0, ::_id_488B );
    _id_4E25( "killStreaksUsed", 0, 0, ::_id_488B );
    _id_4E25( "humiliation", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "regicide", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "gunslinger", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "dejavu", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "levelup", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "omegaman", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "plague", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "patientzero", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "careless", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "survivor", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "contagious", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "flagscaptured", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "flagsreturned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "flagcarrierkills", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "flagscarried", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killsasflagcarrier", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "pointscaptured", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "kill_while_capture", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "opening_move", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "hp_secure", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "targetsdestroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "bombsplanted", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "bombsdefused", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "ninja_defuse", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "last_man_defuse", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "elimination", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "last_man_standing", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sr_tag_elimination", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sr_tag_revive", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killsconfirmed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killsdenied", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "kill_denied_retrieved", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "tag_collector", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "touchdown", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "fieldgoal", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "interception", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "kill_with_ball", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "ball_score_assist", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "pass_kill_pickup", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "killedBallCarrier", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "uav_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "warbird_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "paladin_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "vulcan_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "goliath_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "missile_strike_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sentry_gun_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "strafing_run_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assault_drone_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "recon_drone_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "map_killstreak_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assist_killstreak_destroyed", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "warbird_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "paladin_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "vulcan_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "goliath_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "airdrop_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "airdrop_trap_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "missile_strike_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "sentry_gun_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "strafing_run_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assault_drone_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "map_killstreak_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "coop_killstreak_kill", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "uav_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "warbird_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "orbitalsupport_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "orbital_strike_laser_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "orbital_carepackage_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "heavy_exosuit_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "missile_strike_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "remote_mg_sentry_turret_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "strafing_run_airstrike_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "assault_ugv_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "recon_ugv_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "emp_earned", 0, 1, ::highesetwinsupdateplayerdata );
    _id_4E25( "numMatchesRecorded", 0, 0, ::_id_488B );
}

_id_4E25( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level._id_005F[var_0] = spawnstruct();
    level._id_005F[var_0]._id_27A0 = var_1;

    if ( isdefined( var_3 ) )
        level._id_005F[var_0]._id_6FDA = var_3;

    if ( isdefined( var_2 ) )
        level._id_005F[var_0].saveonupdate = var_2;

    if ( isdefined( var_4 ) )
        level._id_005F[var_0]._id_9C55 = var_4;

    if ( isdefined( var_5 ) )
        level._id_005F[var_0]._id_9C56 = var_5;
}

_id_7FD8( var_0 )
{
    var_1 = self getcommonplayerdata( "bests", var_0 );
    var_2 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = _id_3F9E( var_0, var_2 );

    if ( var_1 == 0 || var_2 > var_1 )
        self setcommonplayerdata( "bests", var_0, var_2 );
}

_id_7FD9( var_0 )
{
    var_1 = self getcommonplayerdata( "bests", var_0 );
    var_2 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = _id_3F9E( var_0, var_2 );

    if ( var_1 == 0 || var_2 < var_1 )
        self setcommonplayerdata( "bests", var_0, var_2 );
}

_id_19DF( var_0 )
{
    var_1 = var_0 maps\mp\_utility::getplayerstat( "kills" );
    var_2 = var_0 maps\mp\_utility::getplayerstat( "deaths" );

    if ( var_2 == 0 )
        var_2 = 1;

    var_0 maps\mp\_utility::setplayerstat( "kdratio", var_1 / var_2 );
}

gettotalscore( var_0 )
{
    var_1 = var_0.score;

    if ( !level.teambased )
        var_1 = var_0.extrascore0;

    return var_1;
}

_id_19E6( var_0 )
{
    if ( var_0.timeplayed["total"] < 1 )
        return;

    var_1 = gettotalscore( var_0 );
    var_2 = var_0.timeplayed["total"];
    var_3 = var_1 / ( var_2 / 60 );
    var_0 maps\mp\_utility::setplayerstat( "totalGameScore", var_1 );
    var_0 maps\mp\_utility::setplayerstat( "scorePerMinute", var_3 );
}

assignawards()
{
    foreach ( var_1 in level.players )
    {
        if ( !var_1 maps\mp\_utility::rankingenabled() )
            return;

        var_1 maps\mp\_utility::incplayerstat( "numMatchesRecorded", 1 );
        _id_19DF( var_1 );
        _id_19E6( var_1 );
    }

    foreach ( var_8, var_4 in level._id_005F )
    {
        if ( !isdefined( level._id_005F[var_8]._id_6FDA ) || isdefined( level._id_005F[var_8].saveonupdate ) && level._id_005F[var_8].saveonupdate )
            continue;

        var_5 = level._id_005F[var_8]._id_6FDA;
        var_6 = level._id_005F[var_8]._id_9C55;
        var_7 = level._id_005F[var_8]._id_9C56;

        if ( isdefined( var_6 ) && isdefined( var_7 ) )
        {
            [[ var_5 ]]( var_8, var_6, var_7 );
            continue;
        }

        if ( isdefined( var_6 ) )
        {
            [[ var_5 ]]( var_8, var_6 );
            continue;
        }

        [[ var_5 ]]( var_8 );
    }
}

_id_41DE( var_0, var_1 )
{
    var_1 = _id_3F9E( var_0, var_1 );
    var_2 = self getcommonplayerdata( "round", "awards", var_0 );
    self setcommonplayerdata( "round", "awards", var_0, var_2 + var_1 );

    if ( maps\mp\_utility::practiceroundgame() )
        return;

    if ( _id_847F( var_0 ) )
    {
        var_3 = self getcommonplayerdata( "awards", "numMatchesRecorded" );
        var_4 = self getcommonplayerdata( "awards", var_0 );
        var_5 = var_4 * var_3;
        var_6 = int( ( var_5 + var_1 ) / ( var_3 + 1 ) );
        self setcommonplayerdata( "awards", var_0, var_6 );
    }
    else
    {
        var_2 = self getcommonplayerdata( "awards", var_0 );
        self setcommonplayerdata( "awards", var_0, var_2 + var_1 );
    }
}

_id_847F( var_0 )
{
    switch ( var_0 )
    {
        case "kdratio":
        case "scorePerMinute":
            return 1;
    }

    return 0;
}

_id_3F9E( var_0, var_1 )
{
    var_2 = tablelookup( "mp/awardTable.csv", 1, var_0, 5 );

    switch ( var_2 )
    {
        case "float":
            var_1 = maps\mp\_utility::limitdecimalplaces( var_1, 2 );
            var_1 *= 100;
            break;
        case "none":
        case "distance":
        case "count":
        case "time":
        case "ratio":
        case "multi":
        default:
            break;
    }

    var_1 = int( var_1 );
    return var_1;
}

highesetwinsupdateplayerdata( var_0, var_1 )
{
    if ( maps\mp\_utility::rankingenabled() )
    {
        _id_41DE( var_0, var_1 );
        _id_7FD8( var_0 );
    }
}

lowestwinsupdateplayerdata( var_0, var_1 )
{
    if ( maps\mp\_utility::rankingenabled() )
    {
        _id_41DE( var_0, var_1 );
        _id_7FD9( var_0 );
    }
}

_id_488B( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3 maps\mp\_utility::rankingenabled() && var_3 _id_8D78( var_0 ) && ( !isdefined( var_1 ) || var_3 maps\mp\_utility::getplayerstat( var_0 ) >= var_1 ) )
        {
            var_4 = var_3 maps\mp\_utility::getplayerstat( var_0 );
            var_3 highesetwinsupdateplayerdata( var_0, var_4 );
        }
    }
}

_id_58A9( var_0, var_1 )
{
    foreach ( var_3 in level.players )
    {
        if ( var_3 maps\mp\_utility::rankingenabled() && var_3 _id_8D78( var_0 ) && ( !isdefined( var_1 ) || var_3 maps\mp\_utility::getplayerstat( var_0 ) <= var_1 ) )
        {
            var_4 = var_3 maps\mp\_utility::getplayerstat( var_0 );
            var_3 lowestwinsupdateplayerdata( var_0, var_4 );
        }
    }
}

_id_58AA( var_0 )
{
    var_1 = maps\mp\_utility::gettimepassed() / 1000;
    var_2 = var_1 * 0.5;

    foreach ( var_4 in level.players )
    {
        if ( var_4.hasspawned && var_4.timeplayed["total"] >= var_2 )
        {
            var_5 = var_4 maps\mp\_utility::getplayerstat( var_0 );
            var_4 lowestwinsupdateplayerdata( var_0, var_5 );
        }
    }
}

_id_8D78( var_0 )
{
    var_1 = maps\mp\_utility::getplayerstat( var_0 );
    var_2 = level._id_005F[var_0]._id_27A0;

    if ( var_1 == var_2 )
        return 0;
    else
        return 1;
}
