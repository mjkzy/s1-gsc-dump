// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

hordecreatewarbird()
{
    foreach ( var_1 in level.spawnedwarbirds )
    {
        var_1 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
        waittillframeend;
    }

    var_3 = -1;
    var_4 = [ "sentry_guardian", "assault_ugv_ai", "assault_ugv_mg", "warbird_ai_attack" ];
    var_5 = maps\mp\killstreaks\_warbird::buildvalidflightpaths();
    horde_patch_flight_paths();
    var_6 = maps\mp\killstreaks\_warbird::findbestspawnlocation( var_5 );
    var_6 = maps\mp\killstreaks\_warbird::rotatehelispawn( var_6 );
    var_7 = spawnhelicopter( self, var_6.origin, var_6.angles, "warbird_horde", level.warbirdsetting["Warbird"].modelbase );
    var_7.currentnode = var_6;

    if ( !isdefined( var_7 ) )
        return 0;

    var_7 thread maps\mp\killstreaks\_warbird::warbird_audio();
    var_7 hide();
    var_7 thread maps\mp\killstreaks\_warbird::warbirdmakevehiclesolidcapsule();
    var_7.targetent = spawn( "script_origin", ( 0, 0, 0 ) );
    var_7.vehicletype = "Warbird";
    var_7.heli_type = level.warbirdsetting["Warbird"].helitype;
    var_7.helitype = level.warbirdsetting["Warbird"].helitype;
    var_7.attractor = missile_createattractorent( var_7, level.heli_attract_strength, level.heli_attract_range );
    var_7.lifeid = var_3;
    var_7.team = "axis";
    var_7.pers["team"] = "axis";
    var_7.maxhealth = level.warbirdhealth + ( maps\mp\gametypes\_horde_util::getnumplayers() - 1 ) * level.warbirdhealth / 2;
    var_7.zoffset = ( 0, 0, 0 );
    var_7.targeting_delay = level.heli_targeting_delay;
    var_7.primarytarget = undefined;
    var_7.secondarytarget = undefined;
    var_7.attacker = undefined;
    var_7.currentstate = "ok";
    var_7.picknewtarget = 1;
    var_7.lineofsight = 0;
    var_7.overheattime = 6;
    var_7.firetime = 0;
    var_7.weaponfire = 0;
    var_7.ismoving = 1;
    var_7.cloakcooldown = 0;
    var_7.iscrashing = 0;
    var_7.ispossessed = 0;
    var_7.modules = var_4;
    var_7.aiattack = common_scripts\utility::array_contains( var_7.modules, "warbird_ai_attack" );
    var_7.aifollow = common_scripts\utility::array_contains( var_7.modules, "warbird_ai_follow" );
    var_7.hasai = var_7.aiattack || var_7.aifollow;
    var_7.cancloak = common_scripts\utility::array_contains( var_7.modules, "warbird_cloak" );
    var_7.hasrockets = common_scripts\utility::array_contains( var_7.modules, "warbird_rockets" );
    var_7.coopoffensive = common_scripts\utility::array_contains( var_7.modules, "warbird_coop_offensive" );
    var_7.extraflare = common_scripts\utility::array_contains( var_7.modules, "warbird_flares" );

    if ( var_7.extraflare )
        var_7.numextraflares = 1;
    else
        var_7.numextraflares = 0;

    if ( var_7.hasrockets )
        var_7.rocketclip = 3;
    else
        var_7.rocketclip = 0;

    var_7.remainingrocketshots = var_7.rocketclip;
    var_7 common_scripts\utility::make_entity_sentient_mp( var_7.team );

    if ( !isdefined( level.spawnedwarbirds ) )
        level.spawnedwarbirds = [];

    level.spawnedwarbirds = common_scripts\utility::array_add( level.spawnedwarbirds, var_7 );
    var_7 maps\mp\killstreaks\_aerial_utility::addtohelilist();
    var_7 thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor( var_7.numextraflares );
    var_7 thread maps\mp\killstreaks\_aerial_utility::heli_monitoremp();
    var_7 thread maps\mp\gametypes\_damage::setentitydamagecallback( var_7.maxhealth, "hitjuggernaut", maps\mp\killstreaks\_warbird::warbirdondeath, ::hordewarbirdmodifydamage, 1 );
    var_7 thread maps\mp\killstreaks\_warbird::warbird_health();
    var_7 thread maps\mp\killstreaks\_aerial_utility::heli_existance();
    var_7 thread hordewarbird_watchdeath();
    thread maps\mp\killstreaks\_warbird::monitoraiwarbirddeathortimeout( var_7 );
    var_7.warbirdturret = var_7 maps\mp\killstreaks\_warbird::spawn_warbird_turret( "warbird_remote_turret_mp", "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_player_mp", 0 );
    var_7.warbirdturret.ishordeenemywarbird = 1;
    var_7.warbirdturret hide();
    var_8 = "orbitalsupport_big_turret_mp";

    if ( var_7.coopoffensive )
        var_8 = "warbird_remote_turret_mp";

    var_7.warbirdbuddyturret = var_7 maps\mp\killstreaks\_warbird::spawn_warbird_turret( var_8, "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_playerbuddy_mp", 1 );
    var_7.warbirdbuddyturret hide();
    thread maps\mp\killstreaks\_warbird::setupcloaking( var_7 );
    var_9 = 3;
    maps\mp\_utility::delaythread( var_9, maps\mp\killstreaks\_warbird::cloakingtransition, var_7, 0 );
    var_7 common_scripts\utility::delaycall( var_9, ::hudoutlineenable, level.enemyoutlinecolor, 1 );
    var_7.warbirdturret common_scripts\utility::delaycall( var_9, ::hudoutlineenable, level.enemyoutlinecolor, 1 );
    var_7.ispossessed = 0;
    var_7.warbirdturret setmode( "auto_nonai" );
    var_7.getstingertargetposfunc = ::hordewarbird_stinger_target_pos;
    waittillframeend;
    var_7 thread hordewarbirdaiattack( var_7 );
    var_7.killcamstarttime = gettime();
    var_7.warbirdturret.killcament = var_7;
    var_7.player = undefined;

    if ( isdefined( var_7 ) )
    {
        level.currentenemycount++;
        level.currentaliveenemycount++;
        level.warbirdinuse = 1;
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
        self hudoutlinedisable();

    if ( isdefined( self.warbirdturret ) )
        self.warbirdturret hudoutlinedisable();

    var_0 = self.lasttododamage;
    thread hordewarbirddestroyed( var_0 );
}

hordewarbirddestroyed( var_0 )
{
    if ( !isdefined( self ) )
        return;

    level.currentaliveenemycount--;
    level.enemiesleft--;
    setomnvar( "ui_horde_enemies_left", level.enemiesleft );

    if ( level.objdefend )
        maps\mp\gametypes\horde::checkdefendkill( self, var_0 );

    level notify( "enemy_death", var_0, self );
    level.warbirdinuse = 0;

    if ( isplayer( var_0 ) )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_0 );
        var_0 thread maps\mp\gametypes\_rank::xppointspopup( "kill", 1000 );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0, 100 );
    }

    if ( isdefined( var_0 ) && isdefined( var_0.owner ) && isplayer( var_0.owner ) && isdefined( var_0.owner.killz ) )
    {
        maps\mp\gametypes\_horde_util::awardhordekill( var_0.owner );
        var_0.owner thread maps\mp\gametypes\_rank::xppointspopup( "kill", 1000 );
        level thread maps\mp\gametypes\_horde_util::hordeupdatescore( var_0.owner, 100 );
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
    var_0 vehicle_setspeed( var_1, var_1 / 4, var_1 / 4 );
    var_0 setneargoalnotifydist( level.warbirdhordeneargoal );
    var_2 = var_0.currentnode;

    if ( !isdefined( var_2 ) )
    {
        var_3 = common_scripts\utility::get_array_of_closest( var_0.origin, maps\mp\killstreaks\_warbird::buildvalidflightpaths() );
        var_4 = var_0.origin;

        for ( var_5 = 0; var_5 < var_3.size; var_5++ )
        {
            var_6 = var_3[var_5].origin;

            if ( maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed( var_4, var_6, var_0 ) )
            {
                var_7 = var_6 - var_4;
                var_8 = distance( var_4, var_6 );
                var_9 = rotatevector( var_7, ( 0, 90, 0 ) );
                var_10 = var_4 + var_9 * 100;
                var_11 = var_10 + var_7 * var_8;

                if ( maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed( var_10, var_11, var_0 ) )
                {
                    var_12 = rotatevector( var_7, ( 0, -90, 0 ) );
                    var_10 = var_4 + var_12 * 100;
                    var_11 = var_10 + var_7 * var_8;

                    if ( maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed( var_10, var_11, var_0 ) )
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
        var_2 = var_2.next;

    if ( !isdefined( var_2 ) )
        return;

    if ( isdefined( var_2.horde_patch_slow_from_prev ) || isdefined( var_2.horde_patch_slow_from_next ) )
        var_0.horde_approach_next_node_slow = 1;
    else
        var_0.horde_approach_next_node_slow = 0;

    for (;;)
    {
        var_13 = var_0.horde_approach_next_node_slow;
        var_0 setvehgoalpos( var_2.origin, var_13 );
        var_0.ismoving = 1;
        var_0 waittill( "near_goal" );
        var_0.currentnode = var_2;
        var_0.ismoving = 0;
        var_2 = hordewarbirdwaituntilmovereturnnode( var_0 );
        var_0.currentnode = undefined;
    }
}

hordewarbirdwaituntilmovereturnnode( var_0 )
{
    var_1 = var_0.currentnode;
    var_2 = var_1.prev;
    var_3 = var_1.next;
    var_4 = maps\mp\_utility::getlivingplayers( "allies" );
    var_4 = sortbydistance( var_4, var_0.origin );

    if ( var_4.size == 0 )
        return var_0.currentnode.next;

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
        if ( isdefined( var_0.enemy_target ) )
        {
            hordemonitorlookatent( var_0 );
            var_0.warbirdturret cleartargetentity();
        }

        waitframe();
    }
}

hordemonitorlookatent( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "pickNewTarget" );
    var_0 setlookatent( var_0.enemy_target );

    if ( isdefined( var_0.enemy_target.isaerialassaultdrone ) && var_0.enemy_target.isaerialassaultdrone )
        var_0.warbirdturret settargetentity( var_0.enemy_target, ( 0, 0, 50 ) );
    else
        var_0.warbirdturret settargetentity( var_0.enemy_target );

    var_0.enemy_target common_scripts\utility::waittill_any_timeout( randomfloatrange( 3, 5 ), "death", "disconnect" );
    var_0.picknewtarget = 1;
    var_0.lineofsight = 0;
}

hordewarbirdfire( var_0 )
{
    var_0 endon( "crashing" );
    var_0 endon( "death" );
    thread hordewarbirdfireai( var_0 );

    for (;;)
    {
        if ( var_0.picknewtarget )
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

            if ( var_0.aiattack )
                var_2 = sortbydistance( var_2, var_0.origin );
            else
                var_2 = sortbydistance( var_2, self.origin );

            var_6 = undefined;

            foreach ( var_4 in var_2 )
            {
                if ( !isdefined( var_4 ) )
                    continue;

                if ( !isalive( var_4 ) || isdefined( var_4.isspectator ) && var_4.isspectator || isdefined( var_4.inlaststand ) && var_4.inlaststand )
                    continue;

                if ( var_4 maps\mp\_utility::_hasperk( "specialty_blindeye" ) )
                    continue;

                if ( isdefined( var_4.spawntime ) && ( gettime() - var_4.spawntime ) / 1000 < 5 )
                    continue;

                var_6 = var_4;
                var_0.enemy_target = var_6;
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
    var_0.remainingrocketshots = var_0.rocketclip;
    var_1 = hordewarbirdburstendtime();
    var_2 = 0.2;
    var_0.firing_rocket = 0;

    if ( level.hordelevelflip > 1 )
        var_0.hasrockets = 1;

    for (;;)
    {
        if ( gettime() > var_1 )
        {
            hordewarbirdburstdelay();
            var_1 = hordewarbirdburstendtime();
        }
        else
            wait(var_2);

        if ( !isdefined( var_0.enemy_target ) || !isalive( var_0.enemy_target ) || isdefined( var_0.enemy_target.isspectator ) && var_0.enemy_target.isspectator || isdefined( var_0.enemy_target.inlaststand ) && var_0.enemy_target.inlaststand || !var_0.lineofsight )
            continue;

        if ( var_0.hasrockets )
        {
            if ( !var_0.firing_rocket )
                thread hordewarbirdfireairocket( var_0 );
        }

        var_0.warbirdturret shootturret();
    }
}

hordewarbirdfireairocket( var_0 )
{
    var_1 = var_0 gettagorigin( "tag_missile_right" );
    var_2 = vectornormalize( anglestoforward( var_0.angles ) );
    var_3 = var_0 vehicle_getvelocity();
    var_4 = magicbullet( "warbird_missile_mp", var_1 + var_3 / 10, self geteye() + var_3 + var_2 * 1000 );
    var_4.killcament = var_0;
    playfxontag( level.chopper_fx["rocketlaunch"]["warbird"], var_0, "tag_missile_right" );
    var_4 missile_settargetent( var_0.enemy_target );
    var_4 missile_setflightmodedirect();
    var_0.remainingrocketshots--;

    if ( var_0.remainingrocketshots <= 0 )
        thread hordewarbirdairocketreload( var_0 );

    var_0.firing_rocket = 1;
    waittillhordewarbirdrocketdeath( var_0, var_4 );
    var_0.firing_rocket = 0;
}

hordewarbirdairocketreload( var_0 )
{
    var_0 endon( "warbirdStreakComplete" );
    wait 6;
    var_0.remainingrocketshots = var_0.rocketclip;
}

waittillhordewarbirdrocketdeath( var_0, var_1 )
{
    var_0.enemy_target endon( "death" );
    var_0.enemy_target endon( "disconnect" );
    var_1 waittill( "death" );
}

checkhordewarbirdtargetlos( var_0 )
{
    self endon( "warbirdPlayerControlled" );
    self endon( "warbirdStreakComplete" );
    var_0.enemy_target endon( "death" );
    var_0.enemy_target endon( "disconnect" );

    for (;;)
    {
        var_1 = var_0 gettagorigin( "TAG_FLASH1" );
        var_2 = ( 0, 0, 0 );

        if ( isdefined( var_0.enemy_target.issentry ) && var_0.enemy_target.issentry )
            var_2 = var_0.enemy_target.origin + ( 0, 0, 40 );
        else
            var_2 = var_0.enemy_target geteye();

        var_3 = vectornormalize( var_2 - var_1 );
        var_4 = var_1 + var_3 * 20;
        var_5 = bullettrace( var_4, var_2, 0, var_0, 0, 0, 0, 0, 0 );

        if ( isdefined( var_0.enemy_target.isspectator ) && var_0.enemy_target.isspectator || isdefined( var_0.enemy_target.inlaststand ) && var_0.enemy_target.inlaststand || var_5["fraction"] < 0.99 )
        {
            var_0.enemy_target = undefined;
            var_0 clearlookatent();
            var_0.warbirdturret cleartargetentity();
            var_0.lineofsight = 0;
            var_0.picknewtarget = 1;
            var_0 notify( "pickNewTarget" );
            return;
        }

        var_0.lineofsight = 1;
        wait 0.25;
    }
}

hordewarbirdchecktargetisinvision( var_0 )
{
    var_1 = anglestoforward( var_0.angles );
    var_2 = var_0.enemy_target.origin - var_0.origin;
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
        self.lasttododamage = var_0;
        maps\mp\killstreaks\_aerial_utility::heli_staticdamage( var_1, var_2, var_5 );

        if ( isdefined( var_0 ) )
        {
            if ( isplayer( var_0 ) )
                var_0 maps\mp\gametypes\horde::givepointsfordamage( self, var_5, "none", var_1, undefined, undefined, "none", 0 );
            else if ( isdefined( var_0.owner ) && isplayer( var_0.owner ) )
                var_0.owner maps\mp\gametypes\horde::givepointsfordamage( self, var_5, "none", var_1, undefined, undefined, "none", 0 );
        }
    }

    return var_5;
}

hordewarbird_stinger_target_pos()
{
    return self gettagorigin( "tag_origin" ) + ( 0, 0, 64 );
}

horde_patch_flight_paths()
{
    if ( isdefined( level.horde_flight_paths_patched ) )
        return;

    if ( isdefined( level.warbirdflightpathnodes ) )
    {
        foreach ( var_2 in level.horde_warbird_path_patch_array )
        {
            var_3 = level.warbirdflightpathnodes[var_2.index];

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
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -468, -2000, 1536 ), ( -318, -2058, 1536 ) );
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( 720, 3144, 1508 ), ( 870, 3086, 1508 ) );
            break;
        case "mp_laser2":
            maps\mp\killstreaks\_aerial_utility::patchheliloopnode( ( -1992, 1648, 2164 ), ( -1329, 768, 2164 ) );
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
