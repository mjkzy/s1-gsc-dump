// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

init()
{
    level.mp_lost_killstreak_duration = 40;
    precacheitem( "iw5_dlcgun12loot6_mp" );
    precacheshader( "dpad_killstreak_lost_static" );
    level.killstreakfuncs["mp_lost"] = ::tryusecleaningdrone;
    level.mapkillstreak = "mp_lost";
    level._id_598A = &"MP_LOST_MAP_KILLSTREAK_PICKUP";
    level.mp_lost_inuse = 0;
    level.cleaningdronemaxperplayer = 3;
    level.cleaningdronesettings = spawnstruct();
    level.cleaningdronesettings.health = 999999;
    level.cleaningdronesettings.maxhealth = 60;
    level.cleaningdronesettings._id_9D6D = "vehicle_lost_drone_mp";
    level.cleaningdronesettings._id_5D3A = "Lost_attack_drone";
    level.cleaningdronesettings._id_3BAF = loadfx( "vfx/sparks/direct_hack_stun" );
    level.cleaningdronesettings._id_3BAB = loadfx( "vfx/lights/tracking_drone_laser_blue" );
    level.cleaningdronesettings._id_3BA9 = loadfx( "vfx/explosion/tracking_drone_explosion" );
    level.cleaningdronesettings.fxid_spawn = loadfx( "vfx/map/mp_lost/lost_attack_drone_spawn" );
    level.cleaningdronesettings.fxid_hit = loadfx( "vfx/map/mp_lost/lost_attack_drone_hit" );
    level.cleaningdronesettings._id_3BAD = loadfx( "vfx/explosion/frag_grenade_default" );
    level.cleaningdronesettings._id_3BB2 = loadfx( "vfx/map/mp_lost/lost_attack_drone_lights_danger" );
    level.cleaningdronesettings._id_3BA7 = loadfx( "vfx/map/mp_lost/lost_attack_drone_lights_enemy" );
    level.cleaningdronesettings._id_3BAA = loadfx( "vfx/map/mp_lost/lost_attack_drone_lights_friendly" );
    level.cleaningdronesettings.fxid_thruster_forward = loadfx( "vfx/distortion/drone_thruster_lost" );
    level.cleaningdronesettings.fxid_thruster_attack = loadfx( "vfx/distortion/lost_drone_attack" );
    level.cleaningdronesettings._id_3BB0 = loadfx( "vfx/distortion/lost_drone_distortion_hemi" );
    level.cleaningdronesettings._id_8898 = "veh_tracking_drone_explode";
    level.cleaningdronesettings._id_889A = "veh_tracking_drone_lock_lp";
    level.cleaningdrones = [];
    level.startpointlocations = common_scripts\utility::getstructarray( "lost_drone_spawn_point", "script_noteworthy" );
    level.spawncratelocations = getentarray( "lost_drone_spawn_crate", "targetname" );
    level.cleaningdronedone = 0;

    foreach ( var_1 in level.players )
        var_1.is_being_tracked = 0;

    level thread _id_64EF();
    level.cleaningdronedebugposition = 0;
    level.cleaningdronedebugpositionforward = 65;
    level.cleaningdronedebugpositionheight = 0;
}

tryusecleaningdrone( var_0, var_1 )
{
    var_2 = level.cleaningdronemaxperplayer;

    if ( maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= maps\mp\_utility::maxvehiclesallowed() )
    {
        self iclientprintlnbold( &"MP_AIR_SPACE_TOO_CROWDED" );
        return 0;
    }

    if ( level.mp_lost_inuse )
    {
        self iclientprintlnbold( &"MP_LOST_IN_USE" );
        return 0;
    }

    if ( maps\mp\_utility::isusingremote() )
        return 0;

    if ( maps\mp\_utility::isairdenied() )
        return 0;

    if ( maps\mp\_utility::isemped() )
        return 0;

    var_3 = setlostdroneactive();

    if ( isdefined( var_3 ) && var_3 )
        maps\mp\_matchdata::logkillstreakevent( "mp_lost", self.origin );

    level.cleaningdronedone = 0;

    foreach ( var_5 in level.players )
        var_5.is_being_tracked = 0;

    if ( !isdefined( level.cleaningdronecount ) )
        level.cleaningdronecount = 0;

    if ( !isdefined( level.startpointlocations ) )
        level.startpointlocations = common_scripts\utility::getstructarray( "lost_drone_spawn_point", "script_noteworthy" );

    for ( var_7 = 0; var_7 < level.cleaningdronemaxperplayer; var_7 += 1 )
    {
        maps\mp\_utility::incrementfauxvehiclecount();
        var_8 = createcleaningdrone();

        if ( !isdefined( var_8 ) )
        {
            maps\mp\_utility::decrementfauxvehiclecount();
            return 0;
        }

        level.cleaningdrones common_scripts\utility::add_to_array( level.cleaningdrones, var_8 );
        level.cleaningdrones = common_scripts\utility::array_removeundefined( level.cleaningdrones );
        thread startcleaningdrone( var_8 );
        var_8 thread cleaningdronemonitordeath();
        level.cleaningdronecount += 1;
        wait 0.25;
    }

    thread cleaningdronespawnwaves();
    thread cleaningdronemonitortime();
    return 1;
}

cleaningdronemonitortime()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = level.mp_lost_killstreak_duration;
    wait(var_0);
    level.cleaningdronedone = 1;
    level.mp_lost_inuse = 0;
}

cleaningdronespawnwaves()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    while ( level.cleaningdronedone == 0 )
    {
        if ( level.cleaningdronecount < level.cleaningdronemaxperplayer )
        {
            var_0 = createcleaningdrone();

            if ( !isdefined( var_0 ) )
            {
                maps\mp\_utility::decrementfauxvehiclecount();
                return 0;
            }

            level.cleaningdrones common_scripts\utility::add_to_array( level.cleaningdrones, var_0 );
            level.cleaningdrones = common_scripts\utility::array_removeundefined( level.cleaningdrones );
            level.cleaningdronecount += 1;
            var_0 thread cleaningdronemonitordeath();
            thread startcleaningdrone( var_0 );
            wait 2;
        }

        waitframe();
    }
}

cleaningdronemonitordeath()
{
    common_scripts\utility::waittill_either( "death", "destroyed" );
    level.cleaningdronecount -= 1;
}

setlostdroneactive()
{
    if ( level.mp_lost_inuse )
        return 0;

    level.mp_lost_inuse = 1;
    return 1;
}

createcleaningdrone( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_5 = "nil";
    var_6 = "nil";
    var_7 = "nil";

    if ( !var_1 )
    {
        var_7 = common_scripts\utility::getclosest( self.origin, level.startpointlocations );
        level.startpointlocations = common_scripts\utility::array_remove( level.startpointlocations, var_7 );
        thread clearspawnlocation( var_7 );
        var_5 = var_7.origin;
        var_6 = var_7.angles;
    }

    var_8 = self;

    if ( isdefined( level.ishorde ) && level.ishorde )
        var_8 = level.player;

    var_9 = spawnhelicopter( var_8, var_5, var_6, level.cleaningdronesettings._id_9D6D, level.cleaningdronesettings._id_5D3A );
    var_9 setmodel( "tag_origin" );
    var_9 hide();
    var_9._id_5D3A = spawn( "script_model", var_5 );
    var_9._id_5D3A.angles = ( 0.0, 0.0, 0.0 );
    var_9._id_5D3A setmodel( level.cleaningdronesettings._id_5D3A );
    var_9 thread cleaningdrone_spawnanim( var_7 );
    var_9.owner = self;
    var_10 = spawn( "script_model", var_9._id_5D3A gettagorigin( "tag_origin" ) );
    var_10 setmodel( "tag_origin" );
    var_10 linktosynchronizedparent( var_9._id_5D3A, "tag_origin", ( -40.0, 0.0, 10.0 ), ( 0.0, 0.0, 0.0 ) );
    var_9.killcament = var_10;
    var_9.killcament setscriptmoverkillcam( "rocket" );

    if ( !isdefined( var_9 ) )
        return;

    if ( isdefined( var_4 ) )
        var_9.type = "cleaning_drone";
    else
        var_9.type = "cleaning_drone";

    var_9 common_scripts\utility::make_entity_sentient_mp( self.team );
    var_9 makeunusable();
    var_9 _meth_8202( 23, 23, 23 );
    var_9 addtocleaningdronelist();
    var_9 thread removefromcleaningdronelistondeath();
    var_9._id_5D3A setcandamage( 1 );
    var_9._id_5D3A setcanradiusdamage( 1 );
    var_9._id_5D3A.health = level.cleaningdronesettings.health;
    var_9._id_5D3A.maxhealth = level.cleaningdronesettings.maxhealth;
    var_9._id_5D3A.damagetaken = 0;
    var_9._id_03E3 = 20;
    var_9._id_3978 = 20;
    var_9.owner = self;
    var_9.team = self.team;
    var_9 _meth_8283( var_9._id_03E3, 10, 10 );
    var_9 _meth_8292( 120, 90 );
    var_9 _meth_825A( 30 );
    var_9 _meth_8253( 4, 5, 5 );
    var_9._id_3B88 = undefined;

    if ( isdefined( var_9.type ) )
    {
        if ( var_9.type == "cleaning_drone" )
            var_9._id_3B88 = "TAG_EYE";
        else if ( var_9.type == "explosive_drone" )
            var_9._id_3B88 = "TAG_EYE";
    }

    if ( level.teambased )
        var_9._id_5D3A maps\mp\_entityheadicons::setteamheadicon( self.team, ( 0.0, 0.0, 40.0 ), "TAG_ORIGIN" );
    else
        var_9._id_5D3A maps\mp\_entityheadicons::setplayerheadicon( self.owner, ( 0.0, 0.0, 40.0 ), "TAG_ORIGIN" );

    var_9._id_5A54 = 80000;
    var_9.startattackrange = 450;
    var_9.maxattackrange = 300;
    var_9.minattackrange = 100;
    var_9._id_94B6 = undefined;
    var_11 = 45;
    var_12 = 45;
    var_9 _meth_8294( var_11, var_12 );
    var_9._id_91D1 = var_5;
    var_9._id_0E53 = 10000;
    var_9._id_0E52 = 500;
    var_9._id_4724 = 0;
    var_9.stunned = 0;
    var_9._id_4C0E = 0;
    var_9._id_5D3A thread maps\mp\gametypes\_damage::setentitydamagecallback( var_9._id_5D3A.maxhealth, undefined, ::oncleaningdronedeath, undefined, 0 );
    var_9._id_5D3A thread cleaningdrone_watchdamage();
    var_9 thread cleaningdrone_watchdisable();
    var_9._id_5D3A thread cleaningdrone_watchdeath( var_9 );
    var_9 thread cleaningdrone_watchownerloss();
    var_9 thread cleaningdrone_watchownerdeath();
    var_9 thread cleaningdrone_watchroundend();
    var_9 thread cleaningdrone_watchhostmigration();
    var_9 thread cleaningdrone_watchtimeout();
    var_9 thread cleaningdrone_enemy_lightfx();
    var_9 thread cleaningdrone_friendly_lightfx();
    var_9._id_5D3A thread _id_2EDE( 1.5 );
    return var_9;
}

cleaningdrone_watchdamage()
{
    self endon( "death" );

    for (;;)
        self waittill( "damage" );
}

clearspawnlocation( var_0 )
{
    wait 6;
    level.startpointlocations = common_scripts\utility::array_add( level.startpointlocations, var_0 );
}

_id_4B82( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_1 = anglestoforward( self.angles );

    for (;;)
    {
        if ( maps\mp\_utility::isreallyalive( self ) && !maps\mp\_utility::isusingremote() && anglestoforward( self.angles ) != var_1 )
        {
            var_1 = anglestoforward( self.angles );
            var_2 = self.origin + var_1 * -100 + ( 0.0, 0.0, 40.0 );
            var_0 moveto( var_2, 0.5 );
        }

        wait 0.5;
    }
}

playfxontagforclients_alivecheck( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_3 endon( "disconnect" );

    while ( !isalive( var_3 ) )
        waitframe();

    playfxontagforclients( var_0, var_1, var_2, var_3 );
}

cleaningdrone_lightfx( var_0, var_1 )
{
    self endon( "death" );
    var_1 endon( "disconnect" );

    while ( !isalive( var_1 ) )
        waitframe();

    playfxontagforclients( var_0, self._id_5D3A, "tag_origin", var_1 );
}

cleaningdrone_removelightfx()
{
    self endon( "death" );

    foreach ( var_1 in level.players )
    {
        _func_2AD( level.cleaningdronesettings._id_3BA7, self._id_5D3A, "tag_origin", var_1 );
        _func_2AD( level.cleaningdronesettings._id_3BAA, self._id_5D3A, "tag_origin", var_1 );
    }
}

cleaningdrone_enemy_lightfx()
{
    self endon( "death" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team != self.team )
        {
            childthread cleaningdrone_lightfx( level.cleaningdronesettings._id_3BA7, var_1 );
            waitframe();
        }
    }
}

cleaningdrone_friendly_lightfx()
{
    self endon( "death" );
    self notify( "killwatchplayfx" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && issentient( var_1 ) && issentient( self ) && var_1.team == self.team )
        {
            childthread cleaningdrone_lightfx( level.cleaningdronesettings._id_3BAA, var_1 );
            waitframe();
        }
    }

    thread _id_A202();
    thread _id_A22D();
}

_id_2EDE( var_0 )
{
    self endon( "death" );
    self notify( "drone_thrusterFX" );
    self endon( "drone_thrusterFX" );
    wait(var_0);

    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) && isdefined( self ) && isdefined( level.cleaningdronesettings.fxid_thruster_forward ) )
            playfxontagforclients_alivecheck( level.cleaningdronesettings.fxid_thruster_forward, self, "TAG_THRUSTER", var_2 );

        waitframe();

        if ( isdefined( var_2 ) && isdefined( self ) && isdefined( level.cleaningdronesettings._id_3BB0 ) )
            playfxontagforclients_alivecheck( level.cleaningdronesettings._id_3BB0, self, "TAG_THRUSTER_DOWN", var_2 );
    }

    for (;;)
    {
        level waittill( "connected", var_2 );
        var_2 waittill( "spawned_player" );

        if ( isdefined( var_2 ) && isdefined( self ) && isdefined( level.cleaningdronesettings.fxid_thruster_forward ) )
            playfxontagforclients( level.cleaningdronesettings.fxid_thruster_forward, self, "TAG_THRUSTER", var_2 );

        waitframe();

        if ( isdefined( var_2 ) && isdefined( self ) && isdefined( level.cleaningdronesettings._id_3BB0 ) )
            playfxontagforclients( level.cleaningdronesettings._id_3BB0, self, "TAG_THRUSTER_DOWN", var_2 );
    }
}

drone_thrusterattackfx()
{
    playfxontag( level.cleaningdronesettings.fxid_thruster_attack, self, "TAG_THRUSTER" );
    thread aud_drone_thrusterattack();
}

_id_A202()
{
    self endon( "death" );
    self endon( "killwatchplayfx" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            childthread cleaningdrone_lightfx( level.cleaningdronesettings._id_3BAA, var_0 );
            wait 0.2;
        }
    }
}

_id_A22D()
{
    self endon( "death" );
    self endon( "killwatchplayfx" );

    for (;;)
    {
        level waittill( "joined_team", var_0 );
        var_0 waittill( "spawned_player" );

        if ( isdefined( var_0 ) && var_0.team == self.team )
        {
            childthread cleaningdrone_lightfx( level.cleaningdronesettings._id_3BAA, var_0 );
            wait 0.2;
        }
    }
}

startcleaningdrone( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    wait 1.6;
    var_0 thread cleaningdrone_followtarget();
    var_0 thread _id_0EE6();

    if ( isdefined( var_0.type ) )
    {
        if ( var_0.type == "explosive_drone" )
            var_0 thread _id_1D02();
        else if ( var_0.type == "cleaning_drone" && !isdefined( level.ishorde ) )
            var_0 thread cleaningdroneattacktarget();
    }
}

cleaningdrone_spawnanim( var_0 )
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    thread aud_drone_launch();
    var_1 = common_scripts\utility::getclosest( var_0.origin, level.spawncratelocations );
    var_1 scriptmodelplayanim( "lost_attack_drone_spawn_crate" );
    playfx( level.cleaningdronesettings.fxid_spawn, var_1.origin, anglestoforward( var_1.angles + ( 270.0, 0.0, 0.0 ) ) );
    self._id_5D3A _meth_848B( "lost_attack_drone_spawn", var_0.origin, var_0.angles );
    wait 1.6;
    self._id_5D3A _meth_827A();
    self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
    self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
    self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
}

_id_1D02()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        common_scripts\utility::waittill_any( "goal", "near_goal", "hit_goal" );

        if ( self._id_94B6 != self.owner && maps\mp\_utility::isreallyalive( self._id_94B6 ) )
        {
            var_0 = distancesquared( self._id_94B6.origin, self.origin );

            if ( var_0 <= 16384 )
            {
                self notify( "exploding" );
                thread _id_14C3();
                break;
            }
        }
    }
}

_id_14C3()
{
    var_0 = 2;
    var_1 = undefined;

    if ( isdefined( self.owner ) )
        var_1 = self.owner;

    if ( isdefined( self ) )
    {
        thread _id_992D();
        self playsound( "drone_warning_beap" );
    }

    wait(var_0);

    if ( isdefined( self ) )
    {
        self playsound( "drone_bomb_explosion" );
        var_2 = anglestoup( self.angles );
        var_3 = anglestoforward( self.angles );
        playfx( level.cleaningdronesettings._id_3BAD, self.origin, var_3, var_2 );

        if ( isdefined( var_1 ) )
            self entityradiusdamage( self.origin, 256, 1000, 25, var_1, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp" );
        else
            self entityradiusdamage( self.origin, 256, 1000, 25, undefined, "MOD_EXPLOSIVE", "killstreak_missile_strike_mp" );

        self notify( "death" );
    }
}

_id_992D()
{
    if ( isdefined( self ) )
        cleaningdrone_removelightfx();

    wait 0.05;

    if ( isdefined( self ) )
        playfxontag( level.cleaningdronesettings._id_3BB2, self._id_5D3A, "tag_origin" );
}

cleaningdrone_followtarget()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );

    if ( !isdefined( self.owner ) )
    {
        thread cleaningdrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self _meth_8283( self._id_3978, 10, 10 );
    self._id_6F66 = self.owner;
    self._id_94B6 = undefined;
    var_0 = [];

    if ( isdefined( level.ishorde ) && level.ishorde )
        self._id_94B6 = self.owner;

    for (;;)
    {
        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.5;
            continue;
        }

        if ( isdefined( self.owner ) && isalive( self.owner ) )
        {
            var_1 = self._id_5A54 * self._id_5A54;
            var_2 = var_1;

            if ( !isdefined( level.ishorde ) )
            {
                if ( !isdefined( self._id_94B6 ) || self._id_94B6 == self.owner || !isalive( self._id_94B6 ) )
                {
                    foreach ( var_4 in level.players )
                    {
                        if ( isdefined( var_4 ) && isalive( var_4 ) && var_4.team != self.team && !var_4 maps\mp\_utility::_hasperk( "specialty_blindeye" ) && checkplayertracked( var_4 ) == 0 )
                            var_0 = common_scripts\utility::array_add( var_0, var_4 );
                    }

                    var_6 = common_scripts\utility::getclosest( self.origin, var_0 );
                    self._id_94B6 = var_6;
                    var_0 = "nil";
                    var_0 = [];
                }
            }

            if ( isdefined( self._id_94B6 ) && checkplayertracked( self._id_94B6 ) == 0 )
            {
                thread cleaningdrone_movetoplayer( self._id_94B6 );
                thread setplayertracked( self._id_94B6 );
                thread _id_A242( self._id_94B6 );
            }
            else if ( !isdefined( self.goalnode ) )
            {
                thread cleaningdrone_followowner();
                thread cleaningdrone_watchforgoal();
            }
        }

        waitframe();
    }
}

checkplayertracked( var_0 )
{
    if ( !isdefined( var_0.istracked ) )
    {
        var_0.istracked = 0;
        return 0;
    }
    else if ( var_0.istracked == 0 )
        return 0;
    else
        return 1;
}

clearplayertracked( var_0 )
{
    var_0.istracked = 0;
}

setplayertracked( var_0 )
{
    var_0.istracked = 1;
    thread clearplayertrackedondronedeath( var_0 );
    var_0 common_scripts\utility::waittill_either( "death", "leaving" );
    var_0.istracked = 0;
}

clearplayertrackedondronedeath( var_0 )
{
    common_scripts\utility::waittill_either( "death", "destroyed" );

    if ( isalive( var_0 ) )
    {
        if ( isdefined( var_0.istracked ) )
            var_0.istracked = 0;
    }
}

_id_A242( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "exploding" );
    var_0 common_scripts\utility::waittill_any( "death", "disconnect", "faux_spawn", "joined_team" );

    if ( isdefined( var_0 ) )
    {
        if ( var_0.is_being_tracked == 1 )
        {
            if ( !isalive( var_0 ) )
            {
                var_0.died_being_tracked = 1;
                thread cleaningdrone_leave();
            }
        }
        else
            self._id_94B6 = undefined;
    }
}

cleaningdrone_movetoplayer( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "cleaningDrone_moveToPlayer" );
    self endon( "cleaningDrone_moveToPlayer" );
    self notify( "clear_goal" );
    self.goalnode = "nil";
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    if ( isdefined( level.ishorde ) && level.ishorde )
    {
        var_1 = 0;
        var_2 = 30;

        switch ( var_0 getstance() )
        {
            case "stand":
                var_3 = 105;
                break;
            case "crouch":
                var_3 = 75;
                break;
            case "prone":
                var_3 = 45;
                break;
        }
    }
    else
    {
        var_1 = -65;
        var_2 = 0;

        switch ( var_0 getstance() )
        {
            case "stand":
                var_3 = 65;
                break;
            case "crouch":
                var_3 = 50;
                break;
            case "prone":
                var_3 = 22;
                break;
        }
    }

    var_4 = ( var_2, var_1, var_3 );
    self _meth_83F9( var_0, var_4 );
    self._id_4EC1 = 1;
    thread cleaningdrone_watchforgoal();
    thread cleaningdrone_watchtargetdisconnect();
}

cleaningdrone_followowner()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "cleaningDrone_moveToOwner" );
    self endon( "cleaningDrone_moveToOwner" );
    var_0 = ( randomintrange( 100, 300 ), randomintrange( 100, 300 ), 105 );
    self _meth_83F9( self.owner, var_0 );
    self._id_4EC1 = 1;
    thread cleaningdrone_watchforgoal();
}

cleaningdrone_stopmovement()
{
    self _meth_825B( self.origin, 1 );
    self._id_4EC1 = 0;
    self._id_4C0E = 1;
}

cleaningdrone_changeowner( var_0 )
{
    maps\mp\_utility::incrementfauxvehiclecount();
    var_1 = var_0 createcleaningdrone( undefined, 1, self.origin, self.angles );

    if ( !isdefined( var_1 ) )
    {
        maps\mp\_utility::decrementfauxvehiclecount();
        return 0;
    }

    if ( !isdefined( var_0.cleaningdronearray ) )
        var_0.cleaningdronearray = [];

    var_0.cleaningdronearray[var_0.cleaningdronearray.size] = var_1;
    level.cleaningdrones = common_scripts\utility::array_removeundefined( level.cleaningdrones );
    level.cleaningdrones[level.trackingdrones.size] = var_1;
    var_0 thread startcleaningdrone( var_1 );

    if ( isdefined( level.drone_settings._id_3BAF ) )
        stopfxontag( level.cleaningdronesettings._id_3BAF, self, self._id_3B88 );

    removecleaningdrone();
    return 1;
}

attack_anim_check( var_0, var_1 )
{
    var_2 = 24;
    var_3 = var_2 * 2;
    var_4 = self.origin;
    var_5 = var_4 + var_1 * var_0;
    var_6 = self _meth_83E5( var_4, var_5, var_2, var_3, 1, 1 );
    return var_6["fraction"] >= 1;
}

do_stationary_attack()
{
    thread cleaningdrone_removelightfx();
    waitframe();
    self._id_5D3A unlink();
    var_0 = self._id_94B6.origin + ( 0.0, 0.0, 40.0 ) - self._id_5D3A.origin;
    var_0 = vectornormalize( var_0 );
    var_1 = vectortoangles( var_0 );
    self._id_5D3A _meth_848B( "lost_attack_drone_stationary_attack", self._id_5D3A.origin, var_1 );
    self.drone_anim_state = "lost_attack_drone_stationary_attack";
    childthread cleaningdrone_attack();
    childthread cleaningdrone_collide( self._id_94B6 );
    childthread cleaningdrone_targetdead( self._id_94B6, var_1 );
    self._id_5D3A childthread drone_thrusterattackfx();
    common_scripts\utility::waittill_any_timeout( 0.4, "damage_stop", "hit" );

    if ( isalive( self._id_94B6 ) )
    {
        self._id_5D3A _meth_827A();
        self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_down" );
        self.drone_anim_state = "lost_attack_drone_spin_down";
        self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
        self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        wait 0.66;
        self notify( "damage_stop" );
        self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
        self.drone_anim_state = "lost_attack_drone_spin_idle";
        self._id_5D3A thread _id_2EDE( 0 );
        thread cleaningdrone_enemy_lightfx();
        thread cleaningdrone_friendly_lightfx();
    }
    else
    {
        self._id_5D3A _meth_827A();
        self._id_5D3A scriptmodelplayanimdeltamotion( "lost_attack_drone_react" );
        self.drone_anim_state = "lost_attack_drone_spin_react";
        wait 2;
        self._id_5D3A _meth_827A();
        self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
        self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
        self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
        self.drone_anim_state = "lost_attack_drone_spin_idle";
        self._id_5D3A thread _id_2EDE( 0 );
        thread cleaningdrone_enemy_lightfx();
        thread cleaningdrone_friendly_lightfx();
    }
}

cleaningdroneattacktarget()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    if ( !isdefined( self.owner ) )
    {
        thread cleaningdrone_leave();
        return;
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self.drone_anim_state = "lost_attack_drone_spin_idle";

    for (;;)
    {
        if ( isdefined( self._id_94B6 ) && self._id_94B6 != self.owner && distancesquared( self.origin, self._id_94B6.origin ) < self.startattackrange * self.startattackrange && 0.8 < self sightconetrace( self._id_94B6.origin + ( 0.0, 0.0, 40.0 ), self._id_94B6 ) )
        {
            self._id_5D3A _meth_827A();
            self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_up" );
            self.drone_anim_state = "lost_attack_drone_spin_up";
            wait 1;

            if ( isdefined( self._id_94B6 ) && self._id_94B6 != self.owner && isalive( self._id_94B6 ) )
            {
                var_0 = 0.8 < self sightconetrace( self._id_94B6.origin + ( 0.0, 0.0, 40.0 ), self._id_94B6 );

                if ( var_0 )
                {
                    var_1 = distancesquared( self.origin, self._id_94B6.origin );

                    if ( var_1 < self.maxattackrange * self.maxattackrange && var_1 > self.minattackrange * self.minattackrange )
                    {
                        var_2 = self._id_94B6.origin + ( 0.0, 0.0, 40.0 ) - self.origin;
                        var_2 = vectornormalize( var_2 );
                        var_3 = attack_anim_check( var_2, self.maxattackrange );

                        if ( var_3 )
                        {
                            thread cleaningdrone_removelightfx();
                            waitframe();
                            self._id_5D3A unlink();
                            var_4 = vectortoangles( var_2 );
                            self._id_5D3A _meth_848B( "lost_attack_drone_attack", self._id_5D3A.origin, var_4 );
                            self.drone_anim_state = "lost_attack_drone_attack";
                            childthread cleaningdrone_attack();
                            childthread cleaningdrone_collide( self._id_94B6 );
                            childthread cleaningdrone_targetdead( self._id_94B6, var_4 );
                            self._id_5D3A childthread drone_thrusterattackfx();
                            common_scripts\utility::waittill_any_timeout( 0.8, "damage_stop", "hit" );

                            if ( isalive( self._id_94B6 ) )
                            {
                                self._id_5D3A _meth_827A();
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_down" );
                                self.drone_anim_state = "lost_attack_drone_spin_down";
                                self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
                                self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
                                wait 0.66;
                                self notify( "damage_stop" );
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
                                self.drone_anim_state = "lost_attack_drone_spin_idle";
                                self._id_5D3A thread _id_2EDE( 0 );
                                thread cleaningdrone_enemy_lightfx();
                                thread cleaningdrone_friendly_lightfx();
                            }
                            else
                            {
                                self._id_5D3A _meth_827A();
                                self._id_5D3A scriptmodelplayanimdeltamotion( "lost_attack_drone_react" );
                                self.drone_anim_state = "lost_attack_drone_react";
                                wait 2;
                                self._id_5D3A _meth_827A();
                                self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
                                self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
                                self.drone_anim_state = "lost_attack_drone_spin_idle";
                                self._id_5D3A thread _id_2EDE( 0 );
                                thread cleaningdrone_enemy_lightfx();
                                thread cleaningdrone_friendly_lightfx();
                            }
                        }
                        else
                            thread cleaningdrone_movetoplayer( self._id_94B6 );
                    }
                    else if ( var_1 <= self.minattackrange * self.minattackrange && var_1 > ( self.minattackrange - 25 ) * ( self.minattackrange - 25 ) )
                    {
                        var_2 = self._id_94B6.origin + ( 0.0, 0.0, 40.0 ) - self.origin;
                        var_2 = vectornormalize( var_2 );
                        var_3 = attack_anim_check( var_2, 80 );

                        if ( var_3 )
                        {
                            thread cleaningdrone_removelightfx();
                            waitframe();
                            self._id_5D3A unlink();
                            var_4 = vectortoangles( var_2 );
                            self._id_5D3A _meth_848B( "lost_attack_drone_100_attack", self._id_5D3A.origin, var_4 );
                            self.drone_anim_state = "lost_attack_drone_100_attack";
                            childthread cleaningdrone_attack();
                            childthread cleaningdrone_collide( self._id_94B6 );
                            childthread cleaningdrone_targetdead( self._id_94B6, var_4 );
                            self._id_5D3A childthread drone_thrusterattackfx();
                            common_scripts\utility::waittill_any_timeout( 0.4, "damage_stop", "hit" );

                            if ( isalive( self._id_94B6 ) )
                            {
                                self._id_5D3A _meth_827A();
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_down" );
                                self.drone_anim_state = "lost_attack_drone_spin_down";
                                self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
                                self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
                                wait 0.66;
                                self notify( "damage_stop" );
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
                                self.drone_anim_state = "lost_attack_drone_spin_idle";
                                self._id_5D3A thread _id_2EDE( 0 );
                                thread cleaningdrone_enemy_lightfx();
                                thread cleaningdrone_friendly_lightfx();
                            }
                            else
                            {
                                self._id_5D3A _meth_827A();
                                self._id_5D3A scriptmodelplayanimdeltamotion( "lost_attack_drone_react" );
                                self.drone_anim_state = "lost_attack_drone_spin_react";
                                wait 2;
                                self._id_5D3A _meth_827A();
                                self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
                                self._id_5D3A linktosynchronizedparent( self, "tag_origin", ( 0.0, 0.0, 0.0 ), ( 0.0, 0.0, 0.0 ) );
                                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
                                self.drone_anim_state = "lost_attack_drone_spin_idle";
                                self._id_5D3A thread _id_2EDE( 0 );
                                thread cleaningdrone_enemy_lightfx();
                                thread cleaningdrone_friendly_lightfx();
                            }
                        }
                        else
                            thread cleaningdrone_movetoplayer( self._id_94B6 );
                    }
                    else if ( var_1 <= ( self.minattackrange - 25 ) * ( self.minattackrange - 25 ) )
                        do_stationary_attack();
                }
            }
            else
            {
                self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
                self.drone_anim_state = "lost_attack_drone_spin_idle";
            }
        }
        else if ( self.drone_anim_state != "lost_attack_drone_spin_idle" )
        {
            self._id_5D3A scriptmodelplayanim( "lost_attack_drone_spin_idle" );
            self.drone_anim_state = "lost_attack_drone_spin_idle";
        }

        waitframe();
    }
}

cleaningdrone_attack()
{
    self endon( "damage_stop" );
    self.owner endon( "disconnect" );

    while ( isdefined( self._id_5D3A ) )
    {
        var_0 = 50;
        self entityradiusdamage( self._id_5D3A.origin, var_0, 500, 100, self, "MOD_EXPLOSIVE", "iw5_dlcgun12loot6_mp" );
        waitframe();
    }
}

cleaningdrone_targetdead( var_0, var_1 )
{
    self endon( "damage_stop" );
    var_0 waittill( "death" );
    var_2 = var_0.body gettagorigin( "j_neck" );
    playfx( level.cleaningdronesettings.fxid_hit, var_2 );
    announcement( var_2, var_2 - self.origin );
    self notify( "target_dead" );
    self notify( "damage_stop" );
}

cleaningdrone_collide( var_0 )
{
    self endon( "damage_stop" );
    self waittill( "touch", var_1 );

    if ( var_1 != var_0 && var_1 != self._id_5D3A )
        self notify( "hit" );
}

_id_8EE8( var_0 )
{
    if ( isdefined( self._id_54FE ) )
    {
        self._id_54FE laseroff();
        stopfxontag( level.cleaningdronesettings._id_3BAB, self._id_54FE, "tag_laser" );
    }

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( level.cleaningdronesettings._id_889A ) )
            self stoploopsound();

        if ( var_0 hasperk( "specialty_radararrow", 1 ) )
            var_0 unsetperk( "specialty_radararrow", 1 );

        var_0 notify( "player_not_tracked" );
        var_0.is_being_tracked = 0;
        var_0.trackedbyplayer = undefined;
    }
}

_id_64EF()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.is_being_tracked = 0;

        foreach ( var_0 in level.players )
        {
            if ( !isdefined( var_0.is_being_tracked ) )
                var_0.is_being_tracked = 0;
        }
    }
}

cleaningdrone_watchforgoal()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self endon( "cleaningDrone_watchForGoal" );
    self endon( "cleaningDrone_moveToOwner" );
    var_0 = common_scripts\utility::waittill_any_return( "goal", "near_goal", "hit_goal", "clear_goal" );
    self notify( "cleaningDrone_watchForGoal" );
    self notify( "cleaningDrone_moveToOwner" );
    self._id_4EC1 = 0;
    self._id_4C0E = 0;
    self notify( "hit_goal" );
    self.goalnode = "nil";
}

cleaningdrone_watchdeath( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "gone" );
    self waittill( "death" );
    var_0 notify( "death" );
    var_0 thread cleaningdronedestroyed();
}

cleaningdrone_watchtimeout()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );

    while ( level.cleaningdronedone == 0 )
        waitframe();

    thread cleaningdrone_leave();
}

cleaningdrone_watchownerloss()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self notify( "owner_gone" );
    thread cleaningdrone_leave();
}

cleaningdrone_watchownerdeath()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );

    for (;;)
    {
        self.owner waittill( "death" );
        thread cleaningdrone_leave();
    }
}

cleaningdrone_watchtargetdisconnect()
{
    level endon( "game_ended" );
    level endon( "host_migration_begin" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    self notify( "cleaningDrone_watchTargetDisconnect" );
    self endon( "cleaningDrone_watchTargetDisconnect" );
    self._id_94B6 waittill( "disconnect" );
    _id_8EE8( self._id_94B6 );
    cleaningdrone_movetoplayer( self.owner );
}

cleaningdrone_watchroundend()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level common_scripts\utility::waittill_any( "round_end_finished", "game_ended" );
    thread cleaningdrone_leave();
}

cleaningdrone_watchhostmigration()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self.owner endon( "death" );
    self.owner endon( "disconnect" );
    self endon( "owner_gone" );
    level waittill( "host_migration_begin" );
    _id_8EE8( self._id_94B6 );
    cleaningdrone_stopmovement();
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    thread cleaningdrone_changeowner( self.owner );
}

cleaningdrone_leave()
{
    self endon( "death" );
    self notify( "leaving" );
    _id_8EE8( self._id_94B6 );
    cleaningdroneexplode();
}

oncleaningdronedeath( var_0, var_1, var_2, var_3 )
{
    self notify( "death" );
}

cleaningdrone_watchdisable()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "emp_damage", var_0, var_1 );
        thread cleaningdrone_stunned();
    }
}

cleaningdrone_stunned()
{
    self notify( "cleaningDrone_stunned" );
    self endon( "cleaningDrone_stunned" );
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    cleaningdrone_stunbegin();
    wait 10.0;
    cleaningdrone_stunend();
}

cleaningdrone_stunbegin()
{
    if ( self.stunned )
        return;

    self.stunned = 1;

    if ( isdefined( level.cleaningdronesettings._id_3BAF ) )
    {

    }

    thread _id_8EE8( self._id_94B6 );
    self._id_94B6 = undefined;
    self._id_6F66 = self.owner;
    thread cleaningdrone_stopmovement();
}

cleaningdrone_stunend()
{
    if ( isdefined( level.cleaningdronesettings._id_3BAF ) )
    {

    }

    self.stunned = 0;
    self._id_4C0E = 0;
}

cleaningdronedestroyed()
{
    if ( !isdefined( self ) )
        return;

    _id_8EE8( self._id_94B6 );
    cleaningdrone_stunend();
    cleaningdrone_removelightfx();
    cleaningdroneexplode();
}

cleaningdroneexplode()
{
    if ( isdefined( level.cleaningdronesettings._id_3BA9 ) )
        playfx( level.cleaningdronesettings._id_3BA9, self.origin );

    if ( isdefined( level.cleaningdronesettings._id_8898 ) )
        self playsound( level.cleaningdronesettings._id_8898 );

    self notify( "explode" );
    self._id_5D3A _meth_827A();
    thread cleaningdrone_removelightfx();
    waitframe();
    self._id_5D3A unlink();
    self _meth_827C( self._id_5D3A.origin, self._id_5D3A.angles );
    self._id_5D3A delete();
    removecleaningdrone();
}

deletecleaningdrone()
{
    if ( !_func_294( self ) && isdefined( self ) )
    {
        if ( isdefined( self._id_0E54 ) )
            missile_deleteattractor( self._id_0E54 );

        self delete();
    }
}

removecleaningdrone()
{
    maps\mp\_utility::decrementfauxvehiclecount();

    if ( isdefined( self.owner ) && isdefined( self.owner._id_94CC ) )
        self.owner._id_94CC = undefined;

    if ( isdefined( self._id_54FE ) )
        self._id_54FE delete();

    deletecleaningdrone();
}

addtocleaningdronelist()
{
    level.cleaningdrones[self getentitynumber()] = self;
    return;
}

removefromcleaningdronelistondeath()
{
    var_0 = self getentitynumber();
    self waittill( "death" );
    level.cleaningdrones[var_0] = undefined;
    level.cleaningdrones = common_scripts\utility::array_removeundefined( level.cleaningdrones );
}

exceededmaxcleaningdrones()
{
    if ( level.cleaningdrones.size >= maps\mp\_utility::maxvehiclesallowed() )
        return 1;
    else
        return 0;
}

destroy_cleaning_drone_in_water()
{
    self endon( "death" );

    if ( !isdefined( level._id_A284 ) )
        return;

    for (;;)
    {
        foreach ( var_1 in level._id_A284 )
        {
            if ( self istouching( var_1 ) )
            {
                if ( isdefined( level.cleaningdronesettings._id_3BA9 ) )
                    playfx( level.cleaningdronesettings._id_3BA9, self.origin );

                if ( isdefined( level.cleaningdronesettings._id_8898 ) )
                    self playsound( level.cleaningdronesettings._id_8898 );

                deletecleaningdrone();
            }
        }

        wait 0.05;
    }
}

prevent_cleaning_drone_in_water( var_0 )
{
    if ( !isdefined( level._id_A284 ) )
        return 0;

    foreach ( var_2 in level._id_A284 )
    {
        if ( _func_22A( var_0, var_2 ) )
            return 1;
    }

    return 0;
}

aud_drone_launch()
{
    thread maps\mp\_audio::_id_8730( "veh_lost_tracking_drone_launch", self.origin );
    thread maps\mp\_audio::_id_8730( "veh_lost_tracking_drone_launch_lyr2", self.origin );
    thread maps\mp\_audio::_id_8730( "veh_lost_tracking_drone_launch_lyr3", self.origin );
    thread maps\mp\_audio::_id_8730( "veh_lost_tracking_drone_launch_lyr4", self.origin );
}

_id_0EE6()
{
    self playloopsound( "veh_lost_tracking_drone_eng_low_lp" );
}

aud_drone_thrusterattack()
{
    var_0 = maps\mp\_audio::snd_play_linked( "veh_lost_tracking_drone_attack", self );
}
