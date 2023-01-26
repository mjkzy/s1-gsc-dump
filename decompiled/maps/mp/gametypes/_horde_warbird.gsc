// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

hordecreatewarbird()
{
    foreach ( var_1 in level._id_89A1 )
    {
        var_1 thread maps\mp\killstreaks\_aerial_utility::_id_47CA();
        waittillframeend;
    }

    var_3 = -1;
    var_4 = [ "sentry_guardian", "assault_ugv_ai", "assault_ugv_mg", "warbird_ai_attack" ];
    var_5 = maps\mp\killstreaks\_warbird::_id_188A();
    horde_patch_flight_paths();
    var_6 = maps\mp\killstreaks\_warbird::_id_3776( var_5 );
    var_6 = maps\mp\killstreaks\_warbird::_id_75FC( var_6 );
    var_7 = spawnhelicopter( self, var_6.origin, var_6.angles, "warbird_horde", level._id_A195["Warbird"]._id_5D3A );
    var_7._id_251D = var_6;

    if ( !isdefined( var_7 ) )
        return 0;

    var_7 thread maps\mp\killstreaks\_warbird::_id_A151();
    var_7 hide();
    var_7 thread maps\mp\killstreaks\_warbird::_id_A18E();
    var_7._id_91C2 = spawn( "script_origin", ( 0.0, 0.0, 0.0 ) );
    var_7.vehicletype = "Warbird";
    var_7._id_47FC = level._id_A195["Warbird"].helitype;
    var_7.helitype = level._id_A195["Warbird"].helitype;
    var_7._id_0E54 = missile_createattractorent( var_7, level._id_47A4, level._id_47A3 );
    var_7.lifeid = var_3;
    var_7.team = "axis";
    var_7.pers["team"] = "axis";
    var_7.maxhealth = level.warbirdhealth + ( _id_A798::_id_4056() - 1 ) * level.warbirdhealth / 2;
    var_7._id_A3C2 = ( 0.0, 0.0, 0.0 );
    var_7._id_91C5 = level._id_47F7;
    var_7._id_6F89 = undefined;
    var_7._id_7BF6 = undefined;
    var_7.attacker = undefined;
    var_7._id_2525 = "ok";
    var_7._id_680A = 1;
    var_7._id_576F = 0;
    var_7._id_65F2 = 6;
    var_7._id_37EB = 0;
    var_7._id_A2D0 = 0;
    var_7._id_5154 = 1;
    var_7._id_1FBB = 0;
    var_7.iscrashing = 0;
    var_7._id_517E = 0;
    var_7.modules = var_4;
    var_7._id_0947 = common_scripts\utility::array_contains( var_7.modules, "warbird_ai_attack" );
    var_7._id_0953 = common_scripts\utility::array_contains( var_7.modules, "warbird_ai_follow" );
    var_7._id_4712 = var_7._id_0947 || var_7._id_0953;
    var_7._id_1AC1 = common_scripts\utility::array_contains( var_7.modules, "warbird_cloak" );
    var_7._id_473F = common_scripts\utility::array_contains( var_7.modules, "warbird_rockets" );
    var_7._id_21C9 = common_scripts\utility::array_contains( var_7.modules, "warbird_coop_offensive" );
    var_7._id_35AA = common_scripts\utility::array_contains( var_7.modules, "warbird_flares" );

    if ( var_7._id_35AA )
        var_7._id_629C = 1;
    else
        var_7._id_629C = 0;

    if ( var_7._id_473F )
        var_7._id_758B = 3;
    else
        var_7._id_758B = 0;

    var_7._id_731C = var_7._id_758B;
    var_7 common_scripts\utility::make_entity_sentient_mp( var_7.team );

    if ( !isdefined( level._id_89A1 ) )
        level._id_89A1 = [];

    level._id_89A1 = common_scripts\utility::array_add( level._id_89A1, var_7 );
    var_7 maps\mp\killstreaks\_aerial_utility::_id_084B();
    var_7 thread maps\mp\killstreaks\_aerial_utility::_id_47BC( var_7._id_629C );
    var_7 thread maps\mp\killstreaks\_aerial_utility::_id_47D4();
    var_7 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_7.maxhealth, "hitjuggernaut", maps\mp\killstreaks\_warbird::_id_A190, ::hordewarbirdmodifydamage, 1 );
    var_7 thread maps\mp\killstreaks\_warbird::_id_A16D();
    var_7 thread maps\mp\killstreaks\_aerial_utility::_id_47B7();
    var_7 thread hordewarbird_watchdeath();
    thread maps\mp\killstreaks\_warbird::_id_5E22( var_7 );
    var_7._id_A196 = var_7 maps\mp\killstreaks\_warbird::_id_897D( "warbird_remote_turret_mp", "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_player_mp", 0 );
    var_7._id_A196.ishordeenemywarbird = 1;
    var_7._id_A196 hide();
    var_8 = "orbitalsupport_big_turret_mp";

    if ( var_7._id_21C9 )
        var_8 = "warbird_remote_turret_mp";

    var_7._id_A184 = var_7 maps\mp\killstreaks\_warbird::_id_897D( var_8, "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_playerbuddy_mp", 1 );
    var_7._id_A184 hide();
    thread maps\mp\killstreaks\_warbird::_id_82FD( var_7 );
    var_9 = 3;
    maps\mp\_utility::delaythread( var_9, maps\mp\killstreaks\_warbird::_id_1FC5, var_7, 0 );
    var_7 common_scripts\utility::delaycall( var_9, ::_meth_83FA, level._id_32B6, 1 );
    var_7._id_A196 common_scripts\utility::delaycall( var_9, ::_meth_83FA, level._id_32B6, 1 );
    var_7._id_517E = 0;
    var_7._id_A196 _meth_8065( "auto_nonai" );
    var_7._id_40F1 = ::hordewarbird_stinger_target_pos;
    waittillframeend;
    var_7 thread hordewarbirdaiattack( var_7 );
    var_7.killcamstarttime = gettime();
    var_7._id_A196.killcament = var_7;
    var_7.player = undefined;

    if ( isdefined( var_7 ) )
    {
        level._id_2514++;
        level._id_2509++;
        level._id_A189 = 1;
        return 1;
    }
    else
        return 0;
}

hordewarbird_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    common_scripts\utility::waittill_any( "crashing", "death" );

    if ( isdefined( self ) )
        self _meth_83FB();

    if ( isdefined( self._id_A196 ) )
        self._id_A196 _meth_83FB();

    var_0 = self._id_5604;
    thread hordewarbirddestroyed( var_0 );
}

hordewarbirddestroyed( var_0 )
{
    if ( !isdefined( self ) )
        return;

    level._id_2509--;
    level._id_31D4--;
    setomnvar( "ui_horde_enemies_left", level._id_31D4 );

    if ( level._id_62DC )
        maps\mp\gametypes\horde::checkdefendkill( self, var_0 );

    level notify( "enemy_death", var_0, self );
    level._id_A189 = 0;

    if ( isplayer( var_0 ) )
    {
        _id_A798::_id_120A( var_0 );
        var_0 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 1000 );
        level thread _id_A798::_id_49D8( var_0, 100 );
    }

    if ( isdefined( var_0 ) && isdefined( var_0.owner ) && isplayer( var_0.owner ) && isdefined( var_0.owner._id_53B5 ) )
    {
        _id_A798::_id_120A( var_0.owner );
        var_0.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 1000 );
        level thread _id_A798::_id_49D8( var_0.owner, 100 );
    }
}

hordewarbirdaiattack( var_0 )
{
    thread hordewarbirdfire( var_0 );
    thread hordewarbirdlookatenemy( var_0 );
    thread hordewarbirdmovetoattackpoint( var_0 );
}

hordewarbirdmovetoattackpoint( var_0 )
{
    self endon( "warbirdPlayerControlled" );
    self endon( "warbirdStreakComplete" );

    if ( !isdefined( level.warbirdhordebasespeed ) )
        level.warbirdhordebasespeed = 40;

    if ( !isdefined( level.warbirdhordeneargoal ) )
        level.warbirdhordeneargoal = 100;

    var_1 = level.warbirdhordebasespeed;
    var_0 _meth_8283( var_1, var_1 / 4, var_1 / 4 );
    var_0 _meth_825A( level.warbirdhordeneargoal );
    var_2 = var_0._id_251D;

    if ( !isdefined( var_2 ) )
    {
        var_3 = common_scripts\utility::get_array_of_closest( var_0.origin, maps\mp\killstreaks\_warbird::_id_188A() );
        var_4 = var_0.origin;

        for ( var_5 = 0; var_5 < var_3.size; var_5++ )
        {
            var_6 = var_3[var_5].origin;

            if ( maps\mp\killstreaks\_aerial_utility::_id_3931( var_4, var_6, var_0 ) )
            {
                var_7 = var_6 - var_4;
                var_8 = distance( var_4, var_6 );
                var_9 = rotatevector( var_7, ( 0.0, 90.0, 0.0 ) );
                var_10 = var_4 + var_9 * 100;
                var_11 = var_10 + var_7 * var_8;

                if ( maps\mp\killstreaks\_aerial_utility::_id_3931( var_10, var_11, var_0 ) )
                {
                    var_12 = rotatevector( var_7, ( 0.0, -90.0, 0.0 ) );
                    var_10 = var_4 + var_12 * 100;
                    var_11 = var_10 + var_7 * var_8;

                    if ( maps\mp\killstreaks\_aerial_utility::_id_3931( var_10, var_11, var_0 ) )
                    {
                        var_2 = var_3[var_5];
                        break;
                    }
                }
            }

            waitframe();
        }
    }
    else
        var_2 = var_2._id_60B4;

    if ( !isdefined( var_2 ) )
        return;

    if ( isdefined( var_2.horde_patch_slow_from_prev ) || isdefined( var_2.horde_patch_slow_from_next ) )
        var_0.horde_approach_next_node_slow = 1;
    else
        var_0.horde_approach_next_node_slow = 0;

    for (;;)
    {
        var_13 = var_0.horde_approach_next_node_slow;
        var_0 _meth_825B( var_2.origin, var_13 );
        var_0._id_5154 = 1;
        var_0 waittill( "near_goal" );
        var_0._id_251D = var_2;
        var_0._id_5154 = 0;
        var_2 = hordewarbirdwaituntilmovereturnnode( var_0 );
        var_0._id_251D = undefined;
    }
}

hordewarbirdwaituntilmovereturnnode( var_0 )
{
    var_1 = var_0._id_251D;
    var_2 = var_1._id_6F30;
    var_3 = var_1._id_60B4;
    var_4 = maps\mp\_utility::getlivingplayers( "allies" );
    var_4 = sortbydistance( var_4, var_0.origin );

    if ( var_4.size == 0 )
        return var_0._id_251D._id_60B4;

    var_5 = var_4[0];
    var_6 = var_3;

    if ( distancesquared( var_5.origin, var_2.origin ) < distancesquared( var_5.origin, var_3.origin ) )
        var_6 = var_2;
    else
        var_6 = var_3;

    if ( randomfloat( 1 ) < 0.2 )
    {
        if ( var_6 == var_2 )
            var_6 = var_3;
        else
            var_6 = var_2;
    }

    if ( isdefined( var_6.horde_patch_slow_from_prev ) && var_6 == var_3 || isdefined( var_6.horde_patch_slow_from_next ) && var_6 == var_2 )
        var_0.horde_approach_next_node_slow = 1;
    else
        var_0.horde_approach_next_node_slow = 0;

    return var_6;
}

hordewarbirdlookatenemy( var_0 )
{
    var_0 endon( "death" );

    for (;;)
    {
        if ( isdefined( var_0._id_3286 ) )
        {
            hordemonitorlookatent( var_0 );
            var_0._id_A196 _meth_8108();
        }

        waitframe();
    }
}

hordemonitorlookatent( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "pickNewTarget" );
    var_0 _meth_8265( var_0._id_3286 );

    if ( isdefined( var_0._id_3286.isaerialassaultdrone ) && var_0._id_3286.isaerialassaultdrone )
        var_0._id_A196 _meth_8106( var_0._id_3286, ( 0.0, 0.0, 50.0 ) );
    else
        var_0._id_A196 _meth_8106( var_0._id_3286 );

    var_0._id_3286 common_scripts\utility::waittill_any_timeout( randomfloatrange( 3, 5 ), "death", "disconnect" );
    var_0._id_680A = 1;
    var_0._id_576F = 0;
}

hordewarbirdfire( var_0 )
{
    var_0 endon( "crashing" );
    var_0 endon( "death" );
    thread hordewarbirdfireai( var_0 );

    for (;;)
    {
        if ( var_0._id_680A )
        {
            var_1 = level.participants;
            var_1 = common_scripts\utility::array_combine( var_1, level.ugvs );
            var_1 = common_scripts\utility::array_combine( var_1, level.turrets );
            var_2 = [];

            foreach ( var_4 in var_1 )
            {
                if ( var_4.team != self.team )
                    var_2 = common_scripts\utility::array_add( var_2, var_4 );
            }

            if ( var_0._id_0947 )
                var_2 = sortbydistance( var_2, var_0.origin );
            else
                var_2 = sortbydistance( var_2, self.origin );

            var_6 = undefined;

            foreach ( var_4 in var_2 )
            {
                if ( !isdefined( var_4 ) )
                    continue;

                if ( !isalive( var_4 ) || isdefined( var_4._id_51B2 ) && var_4._id_51B2 || isdefined( var_4.inlaststand ) && var_4.inlaststand )
                    continue;

                if ( var_4 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                    continue;

                if ( isdefined( var_4.spawntime ) && ( gettime() - var_4.spawntime ) / 1000 < 5 )
                    continue;

                var_6 = var_4;
                var_0._id_3286 = var_6;
                checkhordewarbirdtargetlos( var_0 );
                break;
            }
        }

        var_0 notify( "LostLOS" );
        wait 0.05;
    }
}

hordewarbirdfireai( var_0 )
{
    var_0 endon( "crashing" );
    var_0 endon( "death" );
    var_0._id_731C = var_0._id_758B;
    var_1 = hordewarbirdburstendtime();
    var_2 = 0.2;
    var_0.firing_rocket = 0;

    if ( level._id_49A8 > 1 )
        var_0._id_473F = 1;

    for (;;)
    {
        if ( gettime() > var_1 )
        {
            hordewarbirdburstdelay();
            var_1 = hordewarbirdburstendtime();
        }
        else
            wait(var_2);

        if ( !isdefined( var_0._id_3286 ) || !isalive( var_0._id_3286 ) || isdefined( var_0._id_3286._id_51B2 ) && var_0._id_3286._id_51B2 || isdefined( var_0._id_3286.inlaststand ) && var_0._id_3286.inlaststand || !var_0._id_576F )
            continue;

        if ( var_0._id_473F )
        {
            if ( !var_0.firing_rocket )
                thread hordewarbirdfireairocket( var_0 );
        }

        var_0._id_A196 _meth_80EA();
    }
}

hordewarbirdfireairocket( var_0 )
{
    var_1 = var_0 gettagorigin( "tag_missile_right" );
    var_2 = vectornormalize( anglestoforward( var_0.angles ) );
    var_3 = var_0 _meth_8287();
    var_4 = magicbullet( "warbird_missile_mp", var_1 + var_3 / 10, self geteye() + var_3 + var_2 * 1000 );
    var_4.killcament = var_0;
    playfxontag( level.chopper_fx["rocketlaunch"]["warbird"], var_0, "tag_missile_right" );
    var_4 missile_settargetent( var_0._id_3286 );
    var_4 missile_setflightmodedirect();
    var_0._id_731C--;

    if ( var_0._id_731C <= 0 )
        thread hordewarbirdairocketreload( var_0 );

    var_0.firing_rocket = 1;
    waittillhordewarbirdrocketdeath( var_0, var_4 );
    var_0.firing_rocket = 0;
}

hordewarbirdairocketreload( var_0 )
{
    var_0 endon( "warbirdStreakComplete" );
    wait 6;
    var_0._id_731C = var_0._id_758B;
}

waittillhordewarbirdrocketdeath( var_0, var_1 )
{
    var_0._id_3286 endon( "death" );
    var_0._id_3286 endon( "disconnect" );
    var_1 waittill( "death" );
}

checkhordewarbirdtargetlos( var_0 )
{
    self endon( "warbirdPlayerControlled" );
    self endon( "warbirdStreakComplete" );
    var_0._id_3286 endon( "death" );
    var_0._id_3286 endon( "disconnect" );

    for (;;)
    {
        var_1 = var_0 gettagorigin( "TAG_FLASH1" );
        var_2 = ( 0.0, 0.0, 0.0 );

        if ( isdefined( var_0._id_3286.issentry ) && var_0._id_3286.issentry )
            var_2 = var_0._id_3286.origin + ( 0.0, 0.0, 40.0 );
        else
            var_2 = var_0._id_3286 geteye();

        var_3 = vectornormalize( var_2 - var_1 );
        var_4 = var_1 + var_3 * 20;
        var_5 = bullettrace( var_4, var_2, 0, var_0, 0, 0, 0, 0, 0 );

        if ( isdefined( var_0._id_3286._id_51B2 ) && var_0._id_3286._id_51B2 || isdefined( var_0._id_3286.inlaststand ) && var_0._id_3286.inlaststand || var_5["fraction"] < 0.99 )
        {
            var_0._id_3286 = undefined;
            var_0 _meth_8266();
            var_0._id_A196 _meth_8108();
            var_0._id_576F = 0;
            var_0._id_680A = 1;
            var_0 notify( "pickNewTarget" );
            return;
        }

        var_0._id_576F = 1;
        wait 0.25;
    }
}

hordewarbirdchecktargetisinvision( var_0 )
{
    var_1 = anglestoforward( var_0.angles );
    var_2 = var_0._id_3286.origin - var_0.origin;
    var_3 = vectordot( var_1, var_2 );
    return var_3 > 0;
}

hordewarbirdburstendtime()
{
    var_0 = 1000;
    var_1 = 2000;
    return gettime() + randomintrange( var_0, var_1 );
}

hordewarbirdburstdelay()
{
    var_0 = 2;
    var_1 = 4;
    wait(randomfloatrange( var_0, var_1 ));
}

hordewarbirdmodifydamage( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;
    self.damagefeedback = "hitjuggernaut";

    if ( isdefined( self.damageloc ) && ( issubstr( self.damageloc, "rotor" ) || issubstr( self.damageloc, "wing" ) ) )
    {
        var_4 = 1.25;
        self.damagefeedback = "headshot";
    }

    var_5 = maps\mp\gametypes\_damage::modifydamage( var_0, var_1, var_2, var_3 * var_4 );

    if ( issubstr( var_1, "turret" ) && !isplayer( var_0 ) )
        var_5 *= 0.1;

    if ( issubstr( var_1, "remotemissile_projectile_cluster" ) )
        var_5 = 1000;
    else if ( issubstr( var_1, "remotemissile_" ) )
        var_5 = 1400;
    else if ( issubstr( var_1, "playermech_rocket_mp" ) )
        var_5 = 500;

    if ( weaponclass( var_1 ) == "rocketlauncher" )
    {
        var_6 = 500;

        if ( getweaponbasename( var_1 ) == "iw5_maaws_mp" )
            var_5 = var_5;

        if ( getweaponbasename( var_1 ) == "iw5_mahem_mp" )
            var_5 *= 2.5;

        if ( getweaponbasename( var_1 ) == "iw5_stingerm7_mp" )
            var_5 = 500;
    }

    if ( var_5 > 0 )
    {
        self._id_5604 = var_0;
        maps\mp\killstreaks\_aerial_utility::_id_47F5( var_1, var_2, var_5 );

        if ( isdefined( var_0 ) )
        {
            if ( isplayer( var_0 ) )
                var_0 maps\mp\gametypes\horde::_id_41FA( self, var_5, "none", var_1, undefined, undefined, "none", 0 );
            else if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) )
                var_0.owner maps\mp\gametypes\horde::_id_41FA( self, var_5, "none", var_1, undefined, undefined, "none", 0 );
        }
    }

    return var_5;
}

hordewarbird_stinger_target_pos()
{
    return self gettagorigin( "tag_origin" ) + ( 0.0, 0.0, 64.0 );
}

horde_patch_flight_paths()
{
    if ( isdefined( level.horde_flight_paths_patched ) )
        return;

    if ( isdefined( level._id_A187 ) )
    {
        foreach ( var_2 in level.horde_warbird_path_patch_array )
        {
            var_3 = level._id_A187[var_2.index];

            if ( isdefined( var_2.slow_from_next ) )
                var_3.horde_patch_slow_from_next = var_2.slow_from_next;

            if ( isdefined( var_2.slow_from_prev ) )
                var_3.horde_patch_slow_from_prev = var_2.slow_from_prev;
        }

        level.horde_flight_paths_patched = 1;
    }
}

horde_setup_warbird_pathnode_patch()
{
    var_0 = [];

    switch ( level.script )
    {
        case "mp_comeback":
            var_0[0] = horde_create_patch_node( 3, 1, 0 );
            var_0[1] = horde_create_patch_node( 2, 1, 0 );
            var_0[2] = horde_create_patch_node( 4, 0, 1 );
            break;
        case "mp_lab2":
            var_0[0] = horde_create_patch_node( 1, 1, 1 );
            var_0[1] = horde_create_patch_node( 0, 1, 0 );
            var_0[2] = horde_create_patch_node( 5, 1, 0 );
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -468.0, -2000.0, 1536.0 ), ( -318.0, -2058.0, 1536.0 ) );
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 720.0, 3144.0, 1508.0 ), ( 870.0, 3086.0, 1508.0 ) );
            break;
        case "mp_laser2":
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -1992.0, 1648.0, 2164.0 ), ( -1329.0, 768.0, 2164.0 ) );
            var_0[0] = horde_create_patch_node( 1, 1, 0 );
            var_0[1] = horde_create_patch_node( 3, 0, 1 );
            break;
        case "mp_levity":
            var_0[0] = horde_create_patch_node( 5, 1, 1 );
            break;
        case "mp_refraction":
            var_0[0] = horde_create_patch_node( 4, 1, 0 );
            var_0[1] = horde_create_patch_node( 5, 0, 1 );
            break;
        case "mp_terrace":
            var_0[0] = horde_create_patch_node( 3, 1, 0 );
            var_0[1] = horde_create_patch_node( 4, 0, 1 );
            break;
        case "mp_venus":
            var_0[0] = horde_create_patch_node( 5, 1, 0 );
            var_0[1] = horde_create_patch_node( 6, 0, 1 );
            break;
        case "mp_urban":
            var_0[0] = horde_create_patch_node( 0, 0, 1 );
            var_0[1] = horde_create_patch_node( 5, 1, 0 );
            level.warbirdhordebasespeed = 33;
            break;
    }

    level.horde_warbird_path_patch_array = var_0;
}

horde_create_patch_node( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.index = var_0;

    if ( isdefined( var_1 ) && var_1 )
        var_3.slow_from_prev = 1;

    if ( isdefined( var_2 ) && var_2 )
        var_3.slow_from_next = 1;

    return var_3;
}
