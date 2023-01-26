// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    init_common();
    level._id_0897["ranged_elite_soldier_goliath"] = level._id_0897["ranged_elite_soldier"];
    level.onspawnfinished["ranged_elite_soldier_goliath"] = ::onspawnfinishedgoliath;
    level.getloadout["ranged_elite_soldier_goliath"] = ::getgoliathloadout;
    var_0 = spawnstruct();
    var_0.agent_type = "ranged_elite_soldier_goliath";
    var_0.isbotagent = 1;
    var_0._id_4780 = 4.0;
    var_0.damage_scale = 0.2;
    var_0.melee_damage_scale = 0.5;
    maps\mp\zombies\_util::agentclassregister( var_0, "ranged_elite_soldier_goliath" );
    level.getspawntypefunc["ranged_elite_soldier"] = ::getsoldierroundspawntype;
    level.candroppickupsfunc["ranged_elite_soldier"] = ::soldierroundcandroppickups;
    level.roundstartfunc["ranged_elite_soldier"] = ::soldierroundstart;
    level.roundendfunc["ranged_elite_soldier"] = ::soldierroundend;
    level.randomspawnpointoverride["ranged_elite_soldier"] = ::soldiergetrandomspawnpoint;
    level.numenemiesthisroundfunc["ranged_elite_soldier"] = ::soldierroundnumenemies;
    level.roundspawndelayfunc["ranged_elite_soldier"] = ::soldierroundspawndelay;
    level.getrepulsortagfunc = ::soldiergetrepulsortag;
    level.soldierroundnum = 0;
    level._effect["npc_teleport_enemy"] = loadfx( "vfx/unique/dlc_teleport_soldier_bad" );
    level._effect["goliath_death_fire"] = loadfx( "vfx/fire/goliath_death_fire" );
    level._effect["goliath_self_destruct"] = loadfx( "vfx/explosion/goliath_self_destruct" );
}

init_common()
{
    if ( isdefined( level._id_0897["ranged_elite_soldier"] ) )
        return;

    level._id_0897["ranged_elite_soldier"] = level._id_0897["zombie"];
    level._id_0897["ranged_elite_soldier"]["think"] = ::soldierthink;
    level._id_0897["ranged_elite_soldier"]["spawn"] = ::onsoldierspawned;
    level._id_0897["ranged_elite_soldier"]["on_damaged_finished"] = maps\mp\agents\_agents::_id_0896;
    level._id_0897["ranged_elite_soldier"]["on_killed"] = ::onsoldierkilled;
    var_0 = spawnstruct();
    var_0.agent_type = "ranged_elite_soldier";
    var_0.isbotagent = 1;
    var_0._id_4780 = 0.5;
    var_0.damage_scale = 0.015;
    var_0.melee_damage_scale = 0.32;
    var_0.model_bodies = [ "atlas_biohazard_body_a" ];
    var_0.model_heads = [ "atlas_biohazard_head_a" ];
    maps\mp\zombies\_util::agentclassregister( var_0, var_0.agent_type );

    if ( !isdefined( level.ranged_elite_soldier_weapons ) )
    {
        level.ranged_elite_soldier_weapons = [];
        level.ranged_elite_soldier_weapons["primary"] = [];
        level.ranged_elite_soldier_weapons["secondary"] = [];
        var_1 = [];

        if ( level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark" )
        {
            foreach ( var_3 in level.magicboxweapons )
                var_1[var_1.size] = var_3["baseNameNoMP"];

            var_1[var_1.size] = "iw5_titan45zm";
            var_1[var_1.size] = "iw5_hmr9zm";
            var_1[var_1.size] = "iw5_m182sprzm";
            var_1[var_1.size] = "iw5_uts19zm";
        }
        else
        {
            foreach ( var_3 in level.magicboxweapons )
                var_1[var_1.size] = var_3["baseNameNoMP"];

            var_1[var_1.size] = "iw5_titan45zm";
            var_1[var_1.size] = "iw5_arx160zm";
            var_1[var_1.size] = "iw5_mp11zm";
            var_1[var_1.size] = "iw5_hbra3zm";
            var_1[var_1.size] = "iw5_hmr9zm";
            var_1[var_1.size] = "iw5_maulzm";
            var_1[var_1.size] = "iw5_m182sprzm";
            var_1[var_1.size] = "iw5_uts19zm";
        }

        foreach ( var_3 in var_1 )
        {
            if ( isvalidsoldierweapon( var_3 ) )
            {
                if ( maps\mp\zombies\_util::isvalidprimaryzombies( var_3 ) )
                {
                    level.ranged_elite_soldier_weapons["primary"][level.ranged_elite_soldier_weapons["primary"].size] = var_3;
                    continue;
                }

                if ( maps\mp\zombies\_util::isvalidsecondaryzombies( var_3 ) )
                {
                    level.ranged_elite_soldier_weapons["secondary"][level.ranged_elite_soldier_weapons["secondary"].size] = var_3;
                    continue;
                }

                if ( !maps\mp\zombies\_util::isvalidequipmentzombies( var_3 ) )
                {

                }
            }
        }
    }
}

init_ally()
{
    init_common();
    level._effect["npc_teleport_ally"] = loadfx( "vfx/unique/dlc_teleport_soldier_good" );
}

isvalidsoldierweapon( var_0 )
{
    switch ( var_0 )
    {
        case "iw5_gm6zm":
        case "iw5_rhinozm":
        case "iw5_em1zm":
        case "iw5_fusionzm":
        case "iw5_linegunzm":
        case "iw5_rw1zm":
        case "iw5_mahemzm":
        case "iw5_exocrossbowzm":
            return 0;
        default:
            return 1;
    }
}

getsoldierroundspawntype( var_0, var_1 )
{
    return "ranged_elite_soldier";
}

soldierroundcandroppickups( var_0 )
{
    return 0;
}

soldierroundstart()
{
    level.soldierroundnum++;
    thread soldierroundupdatespawnpoints();
    iprintlnbold( "Atlas Cleanup Crew Inbound!" );
    level waittill( "soldier_spawn_calculated" );
}

soldierroundend()
{
    maps\mp\gametypes\zombies::createpickup( "ammo", level.lastenemydeathpos, "soldierRoundEnd" );
    level notify( "soldierRoundUpdateSpawnPoints" );
}

soldierroundupdatespawnpoints()
{
    level notify( "soldierRoundUpdateSpawnPoints" );
    level endon( "soldierRoundUpdateSpawnPoints" );
    level endon( "game_ended" );
    level.soldierspawn = undefined;
    level.validsoldiernodes = [];
    var_0 = getallnodes();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !maps\mp\zombies\_util::nodeisinspawncloset( var_3 ) )
            var_1[var_1.size] = var_3;
    }

    wait 0.05;
    var_5 = 0.95;
    var_6 = 0.05;
    var_7 = 0.05;
    var_8 = 0.05;
    var_9 = var_5 - var_6 + var_7 + var_8;

    for (;;)
    {
        var_10 = [];
        var_11 = [];

        foreach ( var_13 in level.players )
        {
            if ( isalive( var_13 ) )
            {
                var_14 = var_13 _meth_8387();

                if ( isdefined( var_14 ) )
                {
                    var_10[var_10.size] = var_14;
                    var_11[var_11.size] = _func_2D1( var_14 );
                }
            }
        }

        if ( var_10.size == 0 )
        {
            wait 0.1;
            continue;
        }

        var_16 = !isdefined( level.soldierspawn );

        if ( !var_16 )
        {
            var_17 = 0;

            foreach ( var_19 in var_10 )
            {
                if ( getnodesintrigger( level.soldierspawn, var_19, 1 ) )
                {
                    var_16 = 1;
                    break;
                }

                var_17 += distance( level.soldierspawn.origin, var_19.origin );
            }

            if ( var_17 / var_10.size < 500 )
                var_16 = 1;

            if ( !var_16 )
            {
                wait 0.1;
                continue;
            }
        }

        var_21 = [];

        foreach ( var_3 in var_1 )
        {
            if ( !var_3 _meth_8386() )
            {
                var_23 = _func_2D1( var_3 );

                if ( common_scripts\utility::array_contains( var_11, var_23 ) )
                    var_21[var_21.size] = var_3;
            }
        }

        wait(var_6);
        var_25 = [];
        var_26 = 0;
        var_27 = int( var_21.size / ( 0.5 * var_9 / 0.05 ) );

        foreach ( var_3 in var_21 )
        {
            var_29 = 1;

            foreach ( var_19 in var_10 )
            {
                if ( getnodesintrigger( var_3, var_19, 1 ) )
                {
                    var_29 = 0;
                    break;
                }
            }

            if ( var_29 )
                var_25[var_25.size] = var_3;

            var_26++;

            if ( var_26 % var_27 == 0 )
                wait 0.05;
        }

        wait(var_7);
        var_26 = 0;
        var_33 = undefined;
        var_34 = -1;
        var_27 = int( var_25.size / ( 0.5 * var_9 / 0.05 ) );

        foreach ( var_3 in var_25 )
        {
            var_36 = 0;

            foreach ( var_19 in var_10 )
                var_36 += distance( var_3.origin, var_19.origin );

            if ( var_36 > var_34 )
            {
                var_34 = var_36;
                var_33 = var_3;
            }

            var_26++;

            if ( var_26 % var_27 == 0 )
                wait 0.05;
        }

        wait(var_8);

        if ( isdefined( var_33 ) )
            level.soldierspawn = var_33;
        else
            level.soldierspawn = common_scripts\utility::random( var_21 );

        level notify( "soldier_spawn_calculated" );
    }
}

comparenodedistances( var_0, var_1 )
{
    return level.nodedistances[var_0 _meth_8381()] <= level.nodedistances[var_1 _meth_8381()];
}

soldiergetrandomspawnpoint()
{
    return level.soldierspawn;
}

soldierroundnumenemies( var_0 )
{
    var_1 = maps\mp\zombies\_util::_id_4056();
    var_2 = 4 + level.soldierroundnum * 2;
    var_3 = var_1 * var_2;
    return var_3;
}

soldierroundspawndelay( var_0, var_1 )
{
    return 4.0;
}

soldierthink()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    childthread _id_0B7E();
    childthread _id_0B7F();
    childthread maps\mp\zombies\_zombies::monitorbadzombieai();
    childthread maps\mp\zombies\_util::_id_57F0();
}

getsoldierloadout()
{
    var_0 = maps\mp\bots\_bots_loadout::_id_1683;
    var_1 = [];
    var_1["loadoutWildcard1"] = "specialty_null";
    var_1["loadoutWildcard2"] = "specialty_null";
    var_1["loadoutWildcard3"] = "specialty_null";
    var_1["loadoutPrimary"] = common_scripts\utility::random( level.ranged_elite_soldier_weapons["primary"] );
    var_1["loadoutPrimaryAttachment"] = self [[ var_0 ]]( "attachmenttable", var_1, "loadoutPrimaryAttachment", self._id_67DC, self._id_2A5E );
    var_1["loadoutPrimaryAttachment2"] = self [[ var_0 ]]( "attachmenttable", var_1, "loadoutPrimaryAttachment2", self._id_67DC, self._id_2A5E );
    var_1["loadoutPrimaryAttachment3"] = "none";
    var_1["loadoutPrimaryBuff"] = "specialty_null";
    var_1["loadoutPrimaryCamo"] = "none";
    var_1["loadoutPrimaryReticle"] = "none";
    var_1["loadoutSecondary"] = common_scripts\utility::random( level.ranged_elite_soldier_weapons["secondary"] );
    var_1["loadoutSecondaryAttachment"] = self [[ var_0 ]]( "attachmenttable", var_1, "loadoutSecondaryAttachment", self._id_67DC, self._id_2A5E );
    var_1["loadoutSecondaryAttachment2"] = self [[ var_0 ]]( "attachmenttable", var_1, "loadoutSecondaryAttachment2", self._id_67DC, self._id_2A5E );
    var_1["loadoutSecondaryAttachment3"] = "none";
    var_1["loadoutSecondaryBuff"] = "specialty_null";
    var_1["loadoutSecondaryCamo"] = "none";
    var_1["loadoutSecondaryReticle"] = "none";
    var_1["loadoutEquipment"] = getsoldierloadoutequipment();
    var_1["loadoutEquipmentExtra"] = getsoldierloadoutequipmentextra();
    var_1["loadoutOffhand"] = getsoldierloadoutoffhand();
    var_1["loadoutPerk1"] = getsoldierloadoutperk( 1, var_1 );
    var_1["loadoutPerk2"] = "specialty_null";
    var_1["loadoutPerk3"] = getsoldierloadoutperk( 3, var_1 );
    var_1["loadoutPerk4"] = "specialty_null";
    var_1["loadoutPerk5"] = getsoldierloadoutperk( 5, var_1 );
    var_1["loadoutPerk6"] = "specialty_null";
    var_1["loadoutKillstreaks"][0] = "none";
    var_1["loadoutKillstreaks"][1] = "none";
    var_1["loadoutKillstreaks"][2] = "none";
    var_1["loadoutKillstreaks"][3] = "none";

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        var_1["loadoutPerks"][var_2] = var_1["loadoutPerk" + ( var_2 + 1 )];
        var_1["loadoutPerk" + ( var_2 + 1 )] = undefined;
    }

    for ( var_2 = 0; var_2 < 3; var_2++ )
    {
        var_1["loadoutWildcards"][var_2] = var_1["loadoutWildcard" + ( var_2 + 1 )];
        var_1["loadoutWildcard" + ( var_2 + 1 )] = undefined;
    }

    return var_1;
}

getgoliathloadout()
{
    var_0 = [];
    var_0["loadoutPrimary"] = "iw5_exominigun";
    var_0["loadoutPrimaryAttachment"] = "none";
    var_0["loadoutPrimaryAttachment2"] = "none";
    var_0["loadoutPrimaryAttachment3"] = "none";
    var_0["loadoutPrimaryBuff"] = "specialty_null";
    var_0["loadoutPrimaryCamo"] = "none";
    var_0["loadoutPrimaryReticle"] = "none";
    var_0["loadoutSecondary"] = "none";
    var_0["loadoutSecondaryAttachment"] = "none";
    var_0["loadoutSecondaryAttachment2"] = "none";
    var_0["loadoutSecondaryAttachment3"] = "none";
    var_0["loadoutSecondaryBuff"] = "specialty_null";
    var_0["loadoutSecondaryCamo"] = "none";
    var_0["loadoutSecondaryReticle"] = "none";
    var_0["loadoutEquipment"] = "none";
    var_0["loadoutOffhand"] = "none";
    var_0["loadoutKillstreaks"][0] = "none";
    var_0["loadoutKillstreaks"][1] = "none";
    var_0["loadoutKillstreaks"][2] = "none";
    var_0["loadoutKillstreaks"][3] = "none";
    var_0["loadoutPerks"] = [ "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null", "specialty_null" ];
    var_0["loadoutWildcards"] = [ "specialty_null", "specialty_null", "specialty_null" ];
    var_0["loadoutJuggernaut"] = 1;
    return var_0;
}

getsoldierloadoutoffhand()
{
    if ( issoldierally() )
        return "specialty_null";

    var_0 = [ "exoshield_equipment_mp", "exoshield_equipment_mp", "exocloak_equipment_mp", "exocloak_equipment_mp", "exomute_equipment_mp", "exomute_equipment_mp" ];

    if ( level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10 )
        var_0[var_0.size] = "exorepulsor_equipment_mp";

    return common_scripts\utility::random( var_0 );
}

getsoldierloadoutequipment()
{
    var_0 = [ "frag_grenade_mp", "semtex_mp", "stun_grenade_mp", "emp_grenade_mp" ];

    if ( !issoldierally() )
        var_0[var_0.size] = "smoke_grenade_mp";

    return common_scripts\utility::random( var_0 );
}

getsoldierloadoutequipmentextra()
{
    return issoldierally() || level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10;
}

getsoldierloadoutperk( var_0, var_1 )
{
    var_2 = [ "specialty_class_coldblooded" ];

    for ( var_3 = ""; var_3 == "" || common_scripts\utility::array_contains( var_2, var_3 ); var_3 = maps\mp\bots\_bots_loadout::_id_1688( [ "template_any" ], "template_any", var_1, "loadoutPerk" + var_0 ) )
    {

    }

    return var_3;
}

issoldierally()
{
    return self.agent_type == "zm_squadmate";
}

onsoldierspawned()
{
    if ( isdefined( level._id_0897[self.agent_type]["onAIConnect"] ) )
        [[ maps\mp\agents\_agent_utility::agentfunc( "onAIConnect" ) ]]();

    setsoldierpersonalityanddifficulty();
    maps\mp\gametypes\_battlechatter_mp::disablebattlechatter( self );
    self.nopickups = 1;
    self._id_1D63 = [];
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";

    if ( isdefined( level.getloadout ) && isdefined( level.getloadout[self.agent_type] ) )
        self.pers["gamemodeLoadout"] = self [[ level.getloadout[self.agent_type] ]]();
    else
        self.pers["gamemodeLoadout"] = getsoldierloadout();

    self.class = self.pers["class"];
    self.lastclass = self.pers["lastClass"];

    if ( isdefined( level.onspawnfinished ) && isdefined( level.onspawnfinished[self.agent_type] ) )
        self thread [[ level.onspawnfinished[self.agent_type] ]]();
    else
        thread onspawnfinished();
}

onspawnfinished( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "applyLoadout" );
    setsoldierbotsettings();
    self _meth_8548( 1 );
    self _meth_8351( "no_enemy_search", 1 );
    self.pers["numberOfTimesCloakingUsed"] = 0;
    self.pers["numberOfTimesShieldUsed"] = 0;
    var_1 = self.overridebodymodel;
    var_2 = self.overrideheadmodel;

    if ( !isdefined( var_1 ) || !isdefined( var_2 ) )
    {
        if ( isdefined( level.agentclasses[self.agent_type].model_bodies ) )
        {
            var_3 = randomint( level.agentclasses[self.agent_type].model_bodies.size );
            var_1 = level.agentclasses[self.agent_type].model_bodies[var_3];
            var_2 = level.agentclasses[self.agent_type].model_heads[var_3];
        }
    }

    if ( isdefined( var_1 ) )
    {
        self setmodel( var_1 );

        if ( isdefined( self.headmodel ) )
            self detach( self.headmodel, "" );

        self.headmodel = var_2;
        self attach( self.headmodel, "", 1 );
    }

    self.ignorezombierecycling = 1;
}

playersetjuggexomodelzm( var_0 )
{
    self detachall();
    self setmodel( "npc_exo_armor_mp_base" );
    self attach( "head_hero_cormack_sentinel_halo" );

    if ( isdefined( var_0 ) && !var_0._id_4734 || isdefined( level.ishorde ) )
        self attach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );

    if ( isai( self ) )
        self.hideondeath = 1;

    self notify( "goliath_equipped" );
}

onspawnfinishedgoliath()
{
    onspawnfinished();
    playersetjuggexomodelzm();
    self _meth_8494( 1 );
    self _meth_8352( "stand" );
    self allowjump( 0 );
    self _meth_8302( 0 );
    self _meth_8303( 0 );
    self _meth_8119( 0 );
    self _meth_811A( 0 );
    maps\mp\_utility::playerallowhighjump( 0, "class" );
    maps\mp\_utility::playerallowdodge( 0, "class" );
    mechattachminigunbarrel();
    thread maps\mp\killstreaks\_juggernaut::_id_6C6E();
    thread maps\mp\killstreaks\_juggernaut::_id_6955();
}

mechattachminigunbarrel()
{
    self._id_12E9 = spawn( "script_model", self gettagorigin( "tag_barrel" ) );
    self._id_12E9 setmodel( "generic_prop_raven" );
    self._id_12E9 linktosynchronizedparent( self, "tag_barrel", ( 12.7, 0.0, -2.9 ), ( 90.0, 0.0, 0.0 ) );
    self._id_12E4 = spawn( "script_model", self._id_12E9 gettagorigin( "j_prop_1" ) );
    self._id_12E4 setmodel( "npc_exo_armor_minigun_barrel" );
    self._id_12E4 linktosynchronizedparent( self._id_12E9, "j_prop_1", ( 0.0, 0.0, 0.0 ), ( -90.0, 0.0, 0.0 ) );
}

setsoldierpersonalityanddifficulty()
{
    maps\mp\bots\_bots_util::_id_16ED( "run_and_gun" );

    if ( isdefined( self._id_2A5E ) )
        maps\mp\bots\_bots_util::_id_16EB( self._id_2A5E );
    else if ( issoldierally() )
        maps\mp\bots\_bots_util::_id_16EB( "veteran" );
    else
        maps\mp\bots\_bots_util::_id_16EB( "regular" );

    self._id_2A5E = self _meth_836B();
}

setsoldierbotsettings()
{
    if ( !issoldierally() )
    {
        self _meth_837A( "quickPistolSwitch", 1 );
        self _meth_837A( "diveChance", 0.2 );
        self _meth_837A( "diveDelay", 300 );
        self _meth_837A( "slideChance", 0.6 );
        self _meth_837A( "cornerFireChance", 1.0 );
        self _meth_837A( "cornerJumpChance", 1.0 );
        self _meth_837A( "throwKnifeChance", 1.0 );
        self _meth_837A( "meleeDist", 100 );
        self _meth_837A( "meleeChargeDist", 160 );
        self _meth_837A( "grenadeCookPrecision", 100 );
        self _meth_837A( "grenadeDoubleTapChance", 1.0 );
        self _meth_837A( "strategyLevel", 3 );
        self _meth_837A( "intelligentSprintLevel", 2 );
        self _meth_837A( "holdBreathChance", 1.0 );
        self _meth_837A( "intelligentReload", 1.0 );
        self _meth_837A( "dodgeChance", 0.5 );
        self _meth_837A( "dodgeIntelligence", 0.8 );
        self _meth_837A( "boostSlamChance", 0.35 );
        self _meth_837A( "boostLookAroundChance", 1.0 );
        self _meth_837A( "diveDelay", 300 );
        self _meth_837A( "diveDelay", 300 );
    }
}

_id_0B7E()
{
    if ( self.primaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.primaryweapon );
        wait 12;
    }
}

_id_0B7F()
{
    if ( self.secondaryweapon == "none" )
        return;

    for (;;)
    {
        self givemaxammo( self.secondaryweapon );
        wait 8;
    }
}

onsoldierkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    level.lastenemydeathpos = self.origin;

    if ( isdefined( var_1 ) && isplayer( var_1 ) )
    {
        var_1 maps\mp\_utility::incplayerstat( "kills", 1 );
        var_1 maps\mp\_utility::incpersstat( "kills", 1 );
        var_1.kills = var_1 maps\mp\_utility::getpersstat( "kills" );
        var_1 maps\mp\gametypes\_persistence::statsetchild( "round", "kills", var_1.kills );
    }

    if ( isdefined( var_1 ) )
        var_1 notify( "killed_enemy" );

    if ( isdefined( level.processenemykilledfunc ) )
        self thread [[ level.processenemykilledfunc ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

    return maps\mp\agents\_agents::on_agent_player_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

soldiergetrepulsortag()
{
    if ( maps\mp\killstreaks\_aerial_utility::_id_4746( self.model, "TAG_JETPACK" ) )
        return "TAG_JETPACK";
    else
        return "tag_shield_back";
}
