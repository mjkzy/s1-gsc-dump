// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_zombie_h2o_precache::main();
    maps\createart\mp_zombie_h2o_art::main();
    maps\mp\mp_zombie_h2o_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_zombie_h2o_lighting::main();
    maps\mp\mp_zombie_h2o_aud::main();
    maps\mp\mp_zombie_h2o_sq::init_sidequest();
    level thread common_scripts\_exploder::_id_06F5( 10 );
    maps\mp\_compass::_id_831E( "compass_map_mp_zombie_h2o" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.dlcleaderboardnumber = 4;
    level.pickupdebugprint = 1;
    level.zombiehostinit = maps\mp\zombies\zombie_host::init;
    level.zombiedoginit = maps\mp\zombies\zombie_dog::init;
    level.zombielevelinit = ::inith2o;

    if ( level.nextgen )
        level thread flyoverbink();

    level.zombies_using_civilians = 0;
    level._id_0A9D = 0;
    level thread _id_A75F::init();
    thread initzones();
    thread inittraversalsthroughdoors();
    thread initcharactermodels();
    thread inith2omutators();
    thread _id_5731();
    thread exo_reveal();
    thread tidalgeneratorblade();
    thread windtowerblades();
    thread ambientmantarays();
    thread onplayerfadetoblackonwaterdeath();
    thread maps\mp\zombies\_pickups_dlc3::init();
    thread maps\mp\zombies\zombie_ammo_drone::init();
    thread maps\mp\zombies\_tubes::init();
    thread maps\mp\zombies\_zombies_audio_dlc4::initdlc4audio();
    level.airdropcustomfunclevelspecific = ::airdropcustomfunc;
    level.zmgetscorestreaksforschedule = ::getscorestreaksforschedule;
    level._id_5985 = ::initkillstreaksformap;
    level.zombieweapononplayerspawnedfunc = ::zombieweapononplayerspawned;
    level.zombieweaponinitfunc = ::zombieweaponinit;
    level.initmagicboxweaponsfunc = ::zombieh2oinitmagicboxweapons;
    level.onstartgametypelevelfunc = ::zombieh2ostartgametypelevel;
    level.calculateroundtypeoverridefunc = ::calculateroundtype;
    level.calculatenextspecialround = ::calculatenextspecialround;
    level.zmbteleportgrenadefindzonecustom = ::zmbteleportgrenadefindzonecustom;
    level.zmdamageignoresarmor = maps\mp\gametypes\zombies::zmdamageignoresarmor;
    level.zmteleporterinit = ::zmteleporterinit;
    level.zmteleporterused = ::zmteleporterused;
    level.zmteleporterroomenter = ::zmteleporterroomenter;
    level.zmteleporterplayers = ::zmteleporterplayers;
    level.zmteleportreadyhint = &"ZOMBIE_H2O_TELEPORT_USE";
    level.zmteleportlookarcs = [ 0, 0, 0, 0 ];
    level.allowzombierecycle = 1;
    level.recyclefullhealthzombies = 1;
    level.zombieinfectedvisionset = "mp_zombie_h2o_infected";
    level.zombieinfectedvisionset2 = "mp_zombie_h2o_infected_crazy";
    level.zombieinfectedlightset = "mp_zombie_h2o_infected";

    if ( !isdefined( level.ammodroneillegalzones ) )
        level.ammodroneillegalzones = [];

    level.ammodroneillegalzones[level.ammodroneillegalzones.size] = "bus";
    level.ammodroneillegalzones[level.ammodroneillegalzones.size] = "easter_egg";
    _func_29C( 60 );
    level thread outsiderailshove();
    level thread waterfallshove();
    fixupcratepositions();

    if ( level.nextgen )
        thread spawnpatchclipfixes();

    level.zmpatchshovefunc = ::zombieh2opatchshove;
}

fixupcratepositions()
{
    var_0 = common_scripts\utility::getstructarray( "ozCarepackagePosition", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.origin == ( -349.0, -4305.0, -632.0 ) )
        {
            var_2.origin = ( -355.0, -4305.0, -632.0 );
            continue;
        }

        if ( var_2.origin == ( 159.0, -5593.0, -696.0 ) )
        {
            var_2.origin = ( 159.0, -5598.0, -696.0 );
            continue;
        }

        if ( var_2.origin == ( -857.0, -5265.0, -696.0 ) )
            var_2.origin = ( -862.0, -5265.0, -696.0 );
    }
}

spawnpatchclipfixes()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 448.0, 214.0, 40.0 ), ( 0.0, 28.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 448.0, 214.0, 104.0 ), ( 0.0, 28.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 448.0, 214.0, 168.0 ), ( 0.0, 28.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 448.0, 214.0, 232.0 ), ( 0.0, 28.9, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 259.0, 216.0, 40.0 ), ( 0.0, -34.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 259.0, 216.0, 104.0 ), ( 0.0, -34.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 259.0, 216.0, 168.0 ), ( 0.0, -34.3, 0.0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_64_64_64", ( 259.0, 216.0, 232.0 ), ( 0.0, -34.3, 0.0 ) );
}

zombieh2opatchshove( var_0, var_1 )
{
    if ( var_1 )
    {
        if ( self.currentzone == "start" || self.currentzone == "zone_04" )
        {
            var_2 = self _meth_8557();

            if ( isdefined( var_2 ) && isdefined( var_2._id_2383 ) && var_2._id_2383 == "juggernaut" )
            {
                var_3 = randomfloat( 360.0 );
                self _meth_82F1( anglestoforward( ( 0.0, var_3, 0.0 ) ) * 200.0 );
            }
        }

        if ( self.currentzone == "zone_04" && self.origin[2] > 865.0 && self.origin[2] < 900.0 && self.origin[0] >= -1095 )
            self _meth_82F1( ( 200.0, 0.0, 0.0 ) );
    }
}

initkillstreaksformap()
{
    thread maps\mp\zombies\killstreaks\_zombie_goliath_suit::init();
}

inith2omutators()
{
    maps\mp\zombies\_mutators::initfastmutator();
    maps\mp\zombies\_mutators::initexplodermutator();
    maps\mp\zombies\_mutators::initemzmutator();
    maps\mp\zombies\_mutators_spiked::initspikedmutator();
    maps\mp\zombies\_mutators_armor::initarmormutator();
    maps\mp\zombies\_mutators_teleport::initteleportmutator();
    maps\mp\zombies\_mutators_combo::initcombomutators();
    level.mutatortablesetupfunc = ::buildmutatortable;
}

inith2o()
{
    maps\mp\zombies\zombie_boss_oz::init();
    maps\mp\zombies\killstreaks\_zombie_squadmate::init();
}

initzones()
{
    maps\mp\zombies\_zombies_zone_manager::init();
    maps\mp\zombies\_zombies_zone_manager::initializezone( "start", 1 );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_01" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_01a" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_02" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "atrium" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_02a" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "venthall" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_03" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "zone_04" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "arena" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "bus" );
    maps\mp\zombies\_zombies_zone_manager::initializezone( "easter_egg" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "start", "zone_01", "start_to_zone_01" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "start", "zone_02", "start_to_zone_02" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_01", "atrium", "zone_01_to_atrium" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_01", "zone_01a", "zone_01_to_zone_01a" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_02", "zone_01", "zone_02_to_zone_01" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_02", "zone_02a", "zone_02_to_zone_02a" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_02a", "venthall", "zone_02a_to_venthall" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "venthall", "zone_03", "venthall_to_zone_03" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "venthall", "atrium", "venthall_to_atrium" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "atrium", "zone_04", "atrium_to_zone_04" );
    maps\mp\zombies\_zombies_zone_manager::addadjacentzone( "zone_04", "easter_egg", "zone_04_to_easter_egg" );
    maps\mp\zombies\_zombies_zone_manager::activate();
    level.doorbitmaskarray = [];
    level.doorbitmaskarray["start_to_zone_01"] = 1;
    level.doorbitmaskarray["start_to_zone_02"] = 2;
    level.doorbitmaskarray["zone_01_to_atrium"] = 4;
    level.doorbitmaskarray["zone_01_to_zone_01a"] = 8;
    level.doorbitmaskarray["zone_02_to_zone_01"] = 16;
    level.doorbitmaskarray["zone_02_to_zone_02a"] = 32;
    level.doorbitmaskarray["zone_02a_to_venthall"] = 64;
    level.doorbitmaskarray["venthall_to_zone_03"] = 128;
    level.doorbitmaskarray["venthall_to_atrium"] = 256;
    level.doorbitmaskarray["atrium_to_zone_04"] = 512;
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_CONCIERGE", "start_to_zone_01", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_LANDING", "start_to_zone_01", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_RECEPTION", "start_to_zone_02", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_LANDING", "start_to_zone_02", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_RECEPTION", "zone_02_to_zone_01", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_CONCIERGE", "zone_02_to_zone_01", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_PROMENADE", "zone_02_to_zone_02a", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_RECEPTION", "zone_02_to_zone_02a", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_ANNEX", "zone_02a_to_venthall", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_PROMENADE", "zone_02a_to_venthall", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_ANNEX", "venthall_to_zone_03", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_LOUNGE", "venthall_to_zone_03", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_GALLERIA", "venthall_to_atrium", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_ANNEX", "venthall_to_atrium", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_GALLERIA", "atrium_to_zone_04", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_TIDAL_GENERATOR", "atrium_to_zone_04", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_GALLERIA", "zone_01_to_atrium", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_GREAT_HALL", "zone_01_to_atrium", 1 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_SPA", "zone_01_to_zone_01a", 0 );
    maps\mp\zombies\_doors::registerhintstring( &"ZOMBIE_H2O_DOOR_TO_GREAT_HALL", "zone_01_to_zone_01a", 1 );
}

inittraversalsthroughdoors()
{
    level endon( "game_ended" );

    while ( !isdefined( level.closetpathnodescalculated ) )
        wait 0.05;

    var_0 = getallnodes();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( var_3.type == "Begin" )
            var_1[var_1.size] = var_3;
    }

    wait 0.05;

    foreach ( var_6 in var_1 )
    {
        var_7 = getnode( var_6.target, "targetname" );

        if ( isdefined( var_6.zombieszone ) && isdefined( var_7.zombieszone ) && var_6.zombieszone != var_7.zombieszone )
        {
            var_8 = finddoorforzonepair( var_6.zombieszone, var_7.zombieszone );
            var_9 = distance( var_8.origin, pointonsegmentnearesttopoint( var_6.origin, var_7.origin, var_8.origin ) );

            if ( var_9 < 100 )
            {
                if ( !isdefined( var_8.traversalnodepairs ) )
                    var_8.traversalnodepairs = [];

                var_8.traversalnodepairs[var_8.traversalnodepairs.size] = [ var_6, var_7 ];
                disconnectnodepair( var_6, var_7 );
            }
        }
    }

    level.closetpathnodescalculated++;
}

finddoorforzonepair( var_0, var_1 )
{
    foreach ( var_3 in level.zombiedoors )
    {
        var_4 = var_0 + "_to_" + var_1;

        if ( var_3._id_79CE == var_4 )
            return var_3;

        var_4 = var_1 + "_to_" + var_0;

        if ( var_3._id_79CE == var_4 )
            return var_3;
    }

    return undefined;
}

zmcustomdamagetriggerweapon( var_0, var_1, var_2 )
{
    if ( var_2 == "laser" )
        return "zombie_vaporize_mp";
    else
        return "trap_zm_mp";
}

initcharactermodels()
{
    maps\mp\zombies\_util::initializecharactermodel( "security", "security_guard_body", "viewhands_security_guard", [ "security_guard_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec", "executive_body", "viewhands_executive", [ "executive_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it", "lilith_body", "viewhands_lilith", [ "lilith_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "pilot", "pilot_body_nohelmet", "viewhands_pilot_bcambell", [ "pilot_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "security_exo", "security_guard_body_exo", "viewhands_security_guard_exo", [ "security_guard_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec_exo", "executive_body_exo", "viewhands_executive_exo", [ "executive_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it_exo", "lilith_body_exo", "viewhands_lilith_exo", [ "lilith_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "pilot_exo", "pilot_body_nohelmet_exo", "viewhands_pilot_bcambell_exo", [ "pilot_head" ] );
    maps\mp\zombies\_util::initializecharactermodel( "security_host", "security_guard_body", undefined, [ "security_guard_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "exec_host", "executive_body", undefined, [ "executive_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "it_host", "lilith_body", undefined, [ "lilith_head_z" ] );
    maps\mp\zombies\_util::initializecharactermodel( "pilot_host", "pilot_body_nohelmet", undefined, [ "pilot_head_z" ] );
}

airdropcustomfunc()
{
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "repulsion_turret", 8, maps\mp\zombies\killstreaks\_zombie_killstreaks::_id_5396, &"KILLSTREAKS_DLC3_DISRUPTOR_TURRET", "zm_disruptor" );
    maps\mp\killstreaks\_airdrop::_id_07DC( "airdrop_assault", "squadmate", 25, maps\mp\zombies\killstreaks\_zombie_killstreaks::_id_5396, &"ZOMBIE_SQUADMATE_SQUADMATE", "zm_squadmate" );
}

getscorestreaksforschedule()
{
    var_0 = [];
    var_0[var_0.size] = "sentry_" + randomintrange( 1, 4 );
    var_0[var_0.size] = "drone_" + randomintrange( 1, 3 );
    var_0[var_0.size] = "money";
    var_0[var_0.size] = "camo";
    var_0[var_0.size] = "squadmate";
    var_0[var_0.size] = "repulsion_turret";
    var_0[var_0.size] = "sentry_" + randomintrange( 1, 4 );
    var_0[var_0.size] = "drone_" + randomintrange( 1, 3 );
    var_0[var_0.size] = "money";
    var_0[var_0.size] = "camo";
    var_0[var_0.size] = "squadmate";
    var_0[var_0.size] = "repulsion_turret";
    return var_0;
}

zombieweapononplayerspawned()
{
    thread maps\mp\zombies\weapons\_zombie_repulsor::onplayerspawn();
    thread maps\mp\zombies\weapons\_zombie_teleport_grenade::onplayerspawn();
    thread maps\mp\zombies\weapons\_zombie_trident::onplayerspawn();
}

zombieweaponinit()
{
    maps\mp\zombies\weapons\_zombie_repulsor::init();
    maps\mp\zombies\weapons\_zombie_teleport_grenade::init();
    maps\mp\zombies\weapons\_zombie_trident::init();
}

zombieh2oinitmagicboxweapons()
{
    maps\mp\zombies\_wall_buys::addmagicboxweapon( "repulsor_zombie", "dlc3_repulsor_device_01_holo", &"ZOMBIE_DLC3_REPULSOR", "none", "none", "none", 2 );
    maps\mp\zombies\_wall_buys::addmagicboxweapon( "iw5_dlcgun2zm", "npc_lmg_shotgun_base_static_holo", &"ZOMBIE_WEAPONDLC2_GUN", "none", "none", "none" );
    maps\mp\zombies\_wall_buys::addmagicboxweapon( "iw5_dlcgun3zm", "npc_m1_irons_base_static_holo", &"ZOMBIE_WEAPONDLC3_GUN", "none", "none", "none" );

    if ( level.nextgen )
        maps\mp\zombies\_wall_buys::addmagicboxweapon( "iw5_dlcgun4zm", "npc_blunderbuss_base_holo", &"ZOMBIE_WEAPONDLC4_GUN", "none", "none", "none", 2 );

    maps\mp\zombies\_wall_buys::addmagicboxweapon( "iw5_tridentzm", "npc_zom_trident_base_holo", &"ZOMBIE_WEAPON_TRIDENT_PICKUP", "none", "none", "none", 2 );
}

buildmutatortable()
{
    for (;;)
    {
        level.special_mutators = [];
        level common_scripts\utility::waittill_any( "zombie_round_countdown_started" );
        var_0 = h2ogeneratepossiblemutatorsforwave( level.wavecounter );

        foreach ( var_3, var_2 in var_0 )
            level.special_mutators[var_3] = [ ::h2omutatoralwaysvalid, var_2["weight"] ];

        level waittill( "zombie_wave_ended" );
    }
}

h2omutatoralwaysvalid( var_0 )
{
    return 1;
}

h2ogetsolowaveoffset()
{
    if ( level.players.size < 2 )
        return maps\mp\zombies\zombies_spawn_manager::getsolowaveoffset();

    return 0;
}

h2ogeneratepossiblemutatorsforwave( var_0 )
{
    var_0 -= h2ogetsolowaveoffset();
    var_1 = [];

    if ( var_0 < 4 )
    {

    }
    else if ( var_0 == 4 )
        var_1["emz"]["weight"] = 1;
    else if ( var_0 == 5 )
    {
        var_1["emz"]["weight"] = 1;
        var_1["fast"]["weight"] = 1;
    }
    else if ( var_0 == 6 )
    {
        var_1["emz"]["weight"] = 2;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
    }
    else if ( var_0 == 7 )
    {
        var_1["emz"]["weight"] = 3;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
    }
    else if ( var_0 == 8 )
    {
        var_1["emz"]["weight"] = 4;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
    }
    else if ( var_0 <= 11 )
    {
        var_1["emz"]["weight"] = 5;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
    }
    else if ( var_0 <= 13 )
    {
        var_1["emz"]["weight"] = 6;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
        var_1["combo_exploder_teleport"]["weight"] = 1;
    }
    else if ( var_0 <= 15 )
    {
        var_1["emz"]["weight"] = 4;
        var_1["combo_armor_emz"]["weight"] = 2;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
        var_1["combo_exploder_teleport"]["weight"] = 1;
    }
    else if ( var_0 <= 17 )
    {
        var_1["emz"]["weight"] = 5;
        var_1["combo_armor_emz"]["weight"] = 2;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
        var_1["combo_exploder_teleport"]["weight"] = 1;
        var_1["combo_spike_teleport"]["weight"] = 1;
    }
    else if ( var_0 <= 19 )
    {
        var_1["emz"]["weight"] = 5;
        var_1["combo_armor_emz"]["weight"] = 1;
        var_1["combo_emz_spike"]["weight"] = 1;
        var_1["fast"]["weight"] = 1;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
        var_1["combo_exploder_teleport"]["weight"] = 1;
        var_1["combo_spike_teleport"]["weight"] = 1;
    }
    else if ( var_0 >= 20 )
    {
        var_1["emz"]["weight"] = 6;
        var_1["combo_armor_emz"]["weight"] = 3;
        var_1["combo_emz_spike"]["weight"] = 3;
        var_1["teleport"]["weight"] = 1;
        var_1["exploder"]["weight"] = 1;
        var_1["armor"]["weight"] = 1;
        var_1["spiked"]["weight"] = 1;
        var_1["combo_exploder_teleport"]["weight"] = 1;
        var_1["combo_spike_teleport"]["weight"] = 1;
    }

    return var_1;
}

zombieh2ostartgametypelevel()
{
    level thread maps\mp\zombies\_teleport::init();
    level thread maps\mp\zombies\_util::outofboundswatch( 0 );
    level thread maps\mp\zombies\traps\_trap_turrets::init();
    maps\mp\zombies\_traps::register_trap_state_models( "dlc_trap_activation_console_01_no_signal", "dlc_trap_activation_console_01_ready", "dlc_trap_activation_console_01_active", "dlc_trap_activation_console_01_cooldown" );
}

initspecialstreaks()
{

}

calculateroundtype()
{
    if ( isbossround( level.wavecounter ) )
    {
        if ( maps\mp\zombies\_util::isspecialround() )
        {
            level.specialroundcounter--;
            level.specialroundnumber += 1;
        }

        if ( level.wavecounter == 13 )
            level.bossozstage = 1;

        if ( level.wavecounter == 20 )
            level.bossozstage = 2;

        return "zombie_boss_oz";
    }

    if ( maps\mp\zombies\_util::isspecialround() )
        return calculatespecialroundtype();

    return "normal";
}

isbossround( var_0 )
{
    return var_0 == 13 || var_0 == 20;
}

calculatespecialroundtype()
{
    var_0 = [ "zombie_dog", "zombie_host" ];
    var_1 = var_0[0];

    switch ( level.specialroundcounter )
    {
        case 1:
            var_1 = "zombie_dog";
            break;
        case 2:
            var_1 = "zombie_host";
            break;
        case 3:
            var_1 = "zombie_dog";
            break;
        default:
            if ( !isdefined( level.specialroundarray ) || level.specialroundindex == level.specialroundarray.size )
            {
                level.specialroundarray = common_scripts\utility::array_randomize( var_0 );
                level.specialroundindex = 0;
            }

            var_1 = level.specialroundarray[level.specialroundindex];
            level.specialroundindex++;
    }

    return var_1;
}

calculatenextspecialround()
{
    if ( level.specialroundnumber < 12 )
        var_0 = level.specialroundnumber + 4;
    else
        var_0 = level.specialroundnumber + randomintrange( 4, 6 );

    return var_0;
}

zmteleporterinit( var_0, var_1 )
{
    switch ( var_1 )
    {
        case "ark_device":
            thread teleporter_device( var_0 );
            break;
        case "ark_light":
            thread teleporter_light( var_0 );
            break;
        default:
            return 0;
    }

    return 1;
}

zmteleporterused( var_0 )
{
    if ( isdefined( self.device ) )
    {
        playfxontag( common_scripts\utility::getfx( "dlc_teleport_in" ), self.device, "tag_fx" );
        wait 0.3;
    }
}

zmteleporterroomenter( var_0, var_1 )
{
    if ( !maps\mp\zombies\_util::_id_508F( var_1 ) )
        common_scripts\utility::array_thread( var_0, ::teleporterfx );
}

teleporterfx()
{
    if ( !isdefined( self.teleportchutefx ) )
    {
        self.teleportchutefx = _func_272( common_scripts\utility::getfx( "dlc_teleport_tunnel_player" ), self.origin, self );
        self.teleportchutefx thread teleportfxdelete( self );
    }

    triggerfx( self.teleportchutefx );
}

teleportfxdelete( var_0 )
{
    self endon( "death" );
    var_0 waittill( "disconnect" );
    self delete();
}

zmteleporterplayers( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        playfx( common_scripts\utility::getfx( "teleport_post_fx" ), var_2.origin, anglestoforward( var_2.angles ) );
    }
}

teleporter_device( var_0 )
{
    self.device = var_0;
    var_0 _meth_8048( "TAG_FX_ON" );
    var_0 _meth_8048( "TAG_FX_OFF" );
    var_0 _meth_804B( "TAG_FX_GLOW" );
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "dlc_prop_exo_teleport_pwr_off" ), var_0, "tag_origin", 0 );
    self waittill( "teleportReady" );
    var_0 _meth_804B( "TAG_FX_ON" );
    var_0 _meth_8048( "TAG_FX_OFF" );
    var_0 _meth_8048( "TAG_FX_GLOW" );
    maps\mp\zombies\_util::stopfxontagnetwork( common_scripts\utility::getfx( "dlc_prop_exo_teleport_pwr_off" ), var_0, "tag_origin" );
    maps\mp\zombies\_util::playfxontagnetwork( common_scripts\utility::getfx( "dlc_prop_exo_teleport_pwr_on" ), var_0, "tag_origin", 0 );
}

teleporter_light( var_0 )
{
    var_0 _meth_8044( ( 0.941176, 0.0, 0.0 ) );
    var_0 _meth_81DF( 250 );
    self waittill( "teleportReady" );
    var_0 _meth_8044( ( 0.501961, 1.0, 1.0 ) );
    var_0 _meth_81DF( 3500 );
}

getteleporterlightcoloron()
{
    return ( 0.501961, 1.0, 1.0 );
}

getteleporterlightcolorstandby()
{
    return ( 0.941176, 0.0, 0.0 );
}

getteleporterlightcoloroff()
{
    return ( 0.941176, 0.0, 0.0 );
}

getteleporterlightintensityon()
{
    return ( 0.501961, 1.0, 1.0 );
}

getteleporterlightintensitystandby()
{
    return 250;
}

getteleporterlightintensityoff()
{
    return 0.001;
}

_id_5731()
{
    var_0 = _func_231( "lightning_pos", "targetname" );

    if ( !var_0.size )
        return;

    for (;;)
    {
        var_0 = common_scripts\utility::array_randomize( var_0 );

        foreach ( var_2 in var_0 )
        {
            var_2 _meth_83F6( 0, 1 );
            var_3 = randomfloatrange( 5, 7 );
            wait(var_3);

            while ( maps\mp\zombies\_util::_id_508F( level.zmbpauselightningflashes ) )
                waitframe();

            var_2 _meth_83F6( 0, 0 );
        }

        while ( maps\mp\zombies\_util::_id_508F( level.zmbpauselightningflashes ) )
            waitframe();

        wait 0.1;
    }
}

exo_reveal()
{
    var_0 = getentarray( "exo_glass", "targetname" );
    common_scripts\utility::array_thread( var_0, ::exo_reveal_run );
}

exo_reveal_run()
{
    if ( isdefined( self.target ) )
    {
        var_0 = getentarray( self.target, "targetname" );

        foreach ( var_2 in var_0 )
            var_2 linkto( self );
    }

    level waittill( "power_atrium" );
    self connectpaths();
    self moveto( self.origin + ( 0.0, 0.0, 216.0 ), 2 );
}

tidalgeneratorblade()
{
    var_0 = getent( "tidal_generator_blade", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = 120;
    var_2 = 100;

    for (;;)
    {
        var_0 rotatevelocity( ( 0, var_2, 0 ), var_1 );
        wait(var_1);
    }
}

windtowerblades()
{
    var_0 = getentarray( "wind_tower_fan_front", "targetname" );
    common_scripts\utility::array_thread( var_0, ::windtowerbladespin, ( 0.0, 0.0, 100.0 ) );
    var_1 = getentarray( "wind_tower_fan_back", "targetname" );
    common_scripts\utility::array_thread( var_1, ::windtowerbladespin, ( 0.0, 0.0, 100.0 ) );
}

windtowerbladespin( var_0 )
{
    var_1 = 600;

    for (;;)
    {
        self rotatevelocity( var_0, var_1 );
        wait(var_1);
    }
}

ambientmantarays()
{
    if ( level.currentgen )
        return;

    var_0 = common_scripts\utility::getstruct( "floater_anim_node", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0.0, 0.0, 0.0 );

    var_1 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_1 setmodel( "h2o_mantaray_01_anim" );
    var_1 _meth_848B( "zom_h2o_manta_ray_flyby_01", var_0.origin, var_0.angles, "manta_ray_1" );
    var_2 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_2 setmodel( "h2o_mantaray_01_anim" );
    var_2 _meth_848B( "zom_h2o_manta_ray_flyby_02", var_0.origin, var_0.angles, "manta_ray_2" );
}

onplayerfadetoblackonwaterdeath()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread fadetoblackonwaterdeath();
    }
}

fadetoblackonwaterdeath()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "death" );

        if ( isagent( self ) || isbot( self ) )
            continue;

        if ( istouchingwatertrigger() )
        {
            var_0 = underwateroverlay();
            thread underwateroverlaycleanup( var_0 );
        }
    }
}

istouchingwatertrigger()
{
    var_0 = getentarray( "trigger_underwater", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( self istouching( var_2 ) )
            return 1;
    }

    return 0;
}

underwateroverlay()
{
    var_0 = newclienthudelem( self );
    var_0.x = 0;
    var_0.y = 0;
    var_0 setshader( "black", 640, 480 );
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.alpha = 0.0;
    var_0 fadeovertime( 1.5 );
    var_0.alpha = 1.0;
    return var_0;
}

underwateroverlaycleanup( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::waittill_any( "spawned", "disconnect" );
    var_0 destroy();
}

zmbteleportgrenadefindzonecustom( var_0, var_1, var_2 )
{
    var_3 = 100;
    var_4 = 0;
    var_5 = var_2 - var_0;
    var_6 = length( var_5 );
    var_7 = vectornormalize( var_5 );
    var_8 = maps\mp\zombies\_zombies_zone_manager::getplayerzone();

    if ( isdefined( var_8 ) && var_8 == "bus" )
        return "bus";
    else if ( isdefined( var_8 ) && var_8 == "arena" )
        return "arena";

    for (;;)
    {
        var_9 = var_0 + var_7 * var_4;
        var_10 = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn( var_9, 1 );

        if ( isdefined( var_10 ) && maps\mp\zombies\_zombies_zone_manager::iszoneenabled( var_10 ) )
        {
            if ( var_10 != "bus" && var_10 != "arena" )
                return var_10;
        }

        if ( var_4 == var_6 )
            break;

        var_4 += var_3;

        if ( var_4 > var_6 )
            var_4 = var_6;
    }

    if ( isdefined( var_8 ) )
        return var_8;
}

flyoverbink()
{
    var_0 = "zombie_bink_env_camera_DLC4";
    var_1 = "scr_" + var_0;
    setdvar( var_1, 0 );
    var_2 = "devgui_cmd \"Zombie:2/Toggle Flyover Binks/" + var_0 + "\" \"togglep " + var_1 + " 0 1\";";
    thread setupflyoveranimation( "zombie_bink_env_camera_DLC4", "j_prop_1", [], var_1 );
}

setupflyoveranimation( var_0, var_1, var_2, var_3 )
{
    var_4 = common_scripts\utility::getstruct( "floater_anim_node", "targetname" );

    if ( !isdefined( var_4 ) )
        return;

    if ( !isdefined( var_4.angles ) )
        var_4.angles = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_2 ) )
        var_2 = [];

    while ( getdvarint( var_3, 0 ) == 0 )
        waitframe();

    setdvar( "lui_enabled", 0 );
    setdvar( "cg_drawBuildname", 0 );
    setdvar( "cg_drawMapBuildInfo", 0 );
    setdvar( "cg_drawversion", 0 );
    setdvar( "cg_drawviewpos", 0 );
    setdvar( "cg_fovScale", 1.1 );
    level.zombiegamepaused = 1;
    var_5 = maps\mp\agents\_agent_utility::_id_3ED7( "all" );

    foreach ( var_7 in var_5 )
    {
        var_7.bypasscorpse = 1;
        var_7 dodamage( var_7.health + 500000, var_7.origin, level.players[0], undefined, "MOD_EXPLOSIVE", "repulsor_zombie_mp" );
    }

    wait 2;
    var_9 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_9 setmodel( "genericprop_x3" );
    var_10 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_10 setmodel( "tag_player" );
    var_10 linktosynchronizedparent( var_9, var_1, ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );

    for (;;)
    {
        while ( getdvarint( var_3, 0 ) == 0 )
            waitframe();

        level.player _meth_807E( var_10, "tag_player", 1, 0, 0, 0, 0, 1 );
        level.player _meth_80A0( 0 );
        level.player hide();
        var_9 _meth_848B( var_0, var_4.origin, var_4.angles, "camera_notetrack" );

        foreach ( var_12 in var_2 )
            level thread donotetrack( var_9, "camera_notetrack", var_12 );

        wait 1;

        while ( getdvarint( var_3, 0 ) == 1 )
            waitframe();

        var_9 notify( "notetrackDone" );
        level.player show();
        level.player unlink();
        var_9 _meth_827A();
        wait 1;
    }
}

donotetrack( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "notetrackDone" );
    var_0 waittillmatch( var_1, var_2 );

    if ( var_2 == "trigger_decontamination" )
    {

    }
    else if ( var_2 == "open_doors" )
    {

    }

    level notify( var_2 );
}

setupscriptmodelanimation( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = common_scripts\utility::getstruct( "env_bink_anim_node", "targetname" );

    if ( !isdefined( var_5 ) )
    {
        var_5 = spawnstruct();
        var_5.origin = ( 0.0, 3584.0, 88.0 );
    }

    if ( !isdefined( var_5.angles ) )
        var_5.angles = ( 0.0, 0.0, 0.0 );

    if ( !isdefined( var_3 ) )
        var_3 = [];

    var_6 = spawn( "script_model", ( 0.0, 0.0, 0.0 ) );
    var_6 setmodel( var_1 );

    for (;;)
    {
        while ( getdvarint( var_4, 0 ) == 0 )
            waitframe();

        if ( isdefined( var_2 ) )
            level waittill( var_2 );

        var_6 _meth_848B( var_0, var_5.origin, var_5.angles, "ent_notetrack" );

        foreach ( var_8 in var_3 )
            level thread donotetrack( var_6, "ent_notetrack", var_8 );

        wait 1;

        while ( getdvarint( var_4, 0 ) == 1 )
            waitframe();

        var_6 notify( "notetrackDone" );
        var_6 _meth_827A();
        wait 1;
    }
}

outsiderailshove()
{
    level waittill( "player_spawned" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1 playerisonarailing() )
            {
                if ( maps\mp\zombies\_util::_id_508F( var_1.onoutsiderail ) )
                {
                    var_2 = var_1 _id_6CA7();

                    if ( isdefined( var_2 ) )
                    {
                        var_3 = vectornormalize( ( var_2.origin - var_1.origin ) * ( 1.0, 1.0, 0.0 ) );
                        var_1 _meth_82F1( var_3 * 200 );
                    }
                }
                else
                    var_1.onoutsiderail = 1;

                continue;
            }

            var_1.onoutsiderail = undefined;
        }

        wait 0.1;
    }
}

playerisonarailing()
{
    if ( self.origin[2] > 688 && self.origin[2] < 689 )
        return 0;
    else if ( self.origin[2] > 712 && self.origin[2] < 713 )
        return 0;
    else if ( !self isonground() || self isjumping() )
        return 0;

    var_0 = getentarray( "railing_exploit", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            if ( self istouching( var_2 ) )
                return 1;
        }

        return 0;
    }
    else if ( self.origin[2] > 758 && self.origin[2] < 759 && self.origin[1] > -700 && self.origin[1] < 500 && self.origin[0] > -900 && self.origin[0] < 700 )
        return 1;
    else if ( self.origin[2] > 738 && self.origin[2] < 739 && self.origin[1] > 4500 && self.origin[1] < 5100 && self.origin[0] > -2000 && self.origin[0] < -1300 )
        return 1;
    else
        return 0;
}

_id_6CA7()
{
    var_0 = self _meth_8387();

    if ( !isdefined( var_0 ) )
    {
        var_1 = getnodesinradiussorted( self.origin, 256, 0 );

        if ( var_1.size > 0 )
            var_0 = var_1[0];
    }

    return var_0;
}

waterfallshove()
{
    var_0 = anglestoforward( ( 0.0, 150.0, 0.0 ) );
    level waittill( "player_spawned" );

    for (;;)
    {
        foreach ( var_2 in level.players )
        {
            if ( var_2.origin[2] > 88 && var_2.origin[2] < 89 && var_2.origin[1] > 940 && var_2.origin[1] < 1010 && var_2.origin[0] > 1230 && var_2.origin[0] < 1255 )
            {
                if ( maps\mp\zombies\_util::_id_508F( var_2.onwaterfalledge ) )
                    var_2 _meth_82F1( var_0 * 150 );
                else
                    var_2.onwaterfalledge = 1;

                continue;
            }

            var_2.onwaterfalledge = undefined;
        }

        wait 0.1;
    }
}
