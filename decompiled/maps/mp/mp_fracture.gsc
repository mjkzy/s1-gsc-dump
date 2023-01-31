// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::fracture_callbackstartgametype;
    maps\mp\mp_fracture_precache::main();
    maps\createart\mp_fracture_art::main();
    maps\mp\mp_fracture_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_fracture_lighting::main();
    maps\mp\mp_fracture_aud::main();
    maps\mp\_water::init();
    maps\mp\_water::init();
    maps\mp\_compass::setupminimap( "compass_map_mp_cargoship2" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    level.goliath_bad_landing_volumes = [];
    precachemodel( "genericprop" );
    precacherumble( "cgo_event_rumble_loop" );
    level.ospvisionset = "mp_fracture_osp";
    level.osplightset = "mp_fracture_osp";
    level.dronevisionset = "mp_fracture_drone";
    level.dronelightset = "mp_fracture_drone";
    level.warbirdvisionset = "mp_fracture_warbird";
    level.warbirdlightset = "mp_fracture_warbird";
    level.availableicebergs = [];
    level.usedicebergs = [];
    level.icebergspawn = getent( "icebergSpawner", "targetname" );
    level.icebergfinish = getent( "icebergEnd", "targetname" );
    level thread onplayerconnect();
    level thread initcarepackagebadvolumes();
    thread fracturekillstreakoverrides();
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::handleiceberglanebreakup, ::handleiceberglanereset, ::handleiceberglanebreakupend );
    level thread fracturegoliathdeathhack();
    setdvar( "scr_spawnfactor_maxenemydistance", 2000 );
    level.ballpreventgoaljumpfromtraversals = 1;
    level.ballgoalradius = 180;
}

fracture_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

fracturekillstreakoverrides()
{
    while ( !isdefined( level.orbitalsupportoverrides ) )
        waitframe();

    level.orbitalsupportoverrides.spawnheight = 6500;
    level.remote_missile_height_override = 18000;
    level.orbitalsupportoverrides.spawnangle = 90;
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread handleicewaterdamagetrigger();
    }
}

handleicewaterdamagetrigger()
{
    var_0 = getent( "ice_water_hurt_trig", "targetname" );

    for (;;)
    {
        while ( isalive( self ) && self _meth_80A9( var_0 ) )
        {
            self _meth_8051( 5, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "none", "none" );
            wait 0.1;
            maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
        }

        waitframe();
    }
}

handledynamiceventspawns()
{
    waittillframeend;
    spawnsetup();

    if ( !isdefined( level.endstateinit ) )
    {
        level.predynamicevent = 1;
        level.postdynamicevent = 0;
        level waittill( "dynamic_event_started" );
        level.predynamicevent = 0;
        level.postdynamicevent = 0;
        level waittill( "dynamic_event_complete" );
    }

    level.predynamicevent = 0;
    level.postdynamicevent = 1;
}

spawnsetup()
{
    level.dynamicspawns = ::getlistofgoodspawnpoints;
}

getlistofgoodspawnpoints( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.targetname ) || var_3.targetname == "" || var_3 isvalidspawn() == 1 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

isvalidspawn()
{
    if ( level.predynamicevent == 1 && self.targetname == "post_dynamic_event_spawn" )
        return 0;
    else if ( level.predynamicevent == 0 && level.postdynamicevent == 0 && ( self.targetname == "pre_dynamic_event_spawn" || self.targetname == "post_dynamic_event_spawn" ) )
        return 0;
    else if ( level.postdynamicevent == 1 && self.targetname == "pre_dynamic_event_spawn" )
        return 0;

    return 1;
}

getspawnsexcludingtargetname( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.allspawns )
    {
        if ( var_3.targetname != var_0 )
            var_1 = common_scripts\utility::add_to_array( var_1, var_3 );
    }

    return var_1;
}

dynamicevent_init()
{
    setupicebergbonelist();
    setupiceberglane();
    thread setupiceberganimproxy();
    setupiceberglanebadvolume();
    thread handledynamiceventspawns();
    thread handledynamiceventpaths();
    thread setupicebergeventshake();
    thread setupicebergfxchunks();
}

setupicebergbonelist()
{
    var_0 = [ setupbonestruct( "chunk_A", ( 2340, 971, -440.139 ), 1 ), setupbonestruct( "A_container_01_red", ( 1977.2, 724.165, -307.299 ), 1 ), setupbonestruct( "A_container_01_orange", ( 1631, 714.695, -182.16 ), 1 ), setupbonestruct( "chunk_B", ( 1052.38, 1040.26, -138.983 ), 0 ), setupbonestruct( "B_snowcat", ( 162.003, 746.972, -384.812 ), 1 ), setupbonestruct( "B_container_01_liteblue1", ( -1540, 780.63, -416.497 ), 1 ), setupbonestruct( "chunk_C", ( 227, 1128.54, -402.207 ), 1 ), setupbonestruct( "chunk_D", ( -561, 1029.83, -122.877 ), 0 ), setupbonestruct( "chunk_E", ( -1963, 1031.29, -384.02 ), 1 ) ];
    level.icebergbonelist = [];

    foreach ( var_2 in var_0 )
        level.icebergbonelist[var_2.jointname] = var_2;
}

setupiceberglane()
{
    level.iceberglanemodel = spawn( "script_model", ( 0, 0, 0 ) );
    level.iceberglanemodel _meth_80B1( "cgo_iceberg_lane" );
    level.iceberglanemodel.angles = ( 0, -90, 0 );
    level.iceberglanemodel hide();

    foreach ( var_1 in level.icebergbonelist )
    {
        if ( ismajoricebergchunkent( var_1.jointname ) )
        {
            var_2 = getentarray( var_1.jointname, "targetname" );

            foreach ( var_4 in var_2 )
                var_4.origin += ( 0, -1024, 0 );
        }
    }
}

prepareiceberganimation( var_0 )
{
    wait 0.001;

    if ( isdefined( level.endstateinit ) )
        return;

    var_0.animproxy _meth_827B( var_0.animname );
    var_0.animproxy _meth_84BD( 1 );
    level waittill( "icebergAnimStart" );
    var_0.animproxy _meth_84BD( 0 );
}

setupiceberglanebadvolume()
{
    level.iceberglanebadvolumelist = getentarray( "iceberg_lane_badplace_volume", "targetname" );
}

ismajoricebergchunkent( var_0 )
{
    if ( var_0 == "chunk_A_jnt" || var_0 == "chunk_B_jnt" || var_0 == "chunk_C_jnt" || var_0 == "chunk_D_jnt" || var_0 == "chunk_E_jnt" )
        return 1;
    else
        return 0;
}

setupbonestruct( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.jointname = var_0 + "_jnt";
    var_3.animname = "cgo_iceberg_lane_collapse_" + var_0;
    var_3.xmodelname = "cgo_iceberg_lane_" + var_0;
    var_3.endpos = var_1;
    var_3.shouldclean = var_2;
    return var_3;
}

setupicebergeventshake()
{
    var_0 = [];
    var_0["A"] = _func_231( "crack_event_A", "targetname" )[0];
    var_0["B"] = _func_231( "crack_event_B", "targetname" )[0];
    var_0["C"] = _func_231( "crack_event_C", "targetname" )[0];
    var_0["D"] = _func_231( "crack_event_D", "targetname" )[0];
    var_0["E"] = _func_231( "crack_event_E", "targetname" )[0];
    var_0["start"] = _func_231( "start_event", "targetname" )[0];
    level.icebergeventscriptables = var_0;
    var_1 = [];
    var_1["A"] = getentarray( "event_shake_trigger_A", "targetname" );
    var_1["B"] = getentarray( "event_shake_trigger_B", "targetname" );
    var_1["C"] = getentarray( "event_shake_trigger_C", "targetname" );
    var_1["D"] = getentarray( "event_shake_trigger_D", "targetname" );
    var_1["E"] = getentarray( "event_shake_trigger_E", "targetname" );
    var_1["liteblue1"] = getentarray( "event_shake_trigger_liteblue1", "targetname" );
    var_1["snowcat"] = getentarray( "event_shake_trigger_snowcat", "targetname" );
    var_1["orange"] = getentarray( "event_shake_trigger_orange", "targetname" );
    var_1["red"] = getentarray( "event_shake_trigger_red", "targetname" );

    foreach ( var_3 in var_1 )
    {
        foreach ( var_5 in var_3 )
            var_5 hide();
    }

    level.icebergshaketriggerlists = var_1;
    level.icebergcontinuingrumble = "cgo_event_rumble_loop";
}

setupicebergfxchunks()
{
    if ( level.currentgen )
        return;

    common_scripts\utility::flag_init( "icebergChunks" );

    while ( isdefined( level.icebergchunks1 ) == 0 )
    {
        level.icebergchunks1 = getent( "icebergChunks1", "targetname" );
        wait 0.2;
    }

    level.icebergchunks1 hide();

    while ( isdefined( level.icebergchunks2 ) == 0 )
    {
        level.icebergchunks2 = getent( "icebergChunks2", "targetname" );
        wait 0.2;
    }

    level.icebergchunks2 hide();

    while ( isdefined( level.icebergchunks3 ) == 0 )
    {
        level.icebergchunks3 = getent( "icebergChunks3", "targetname" );
        wait 0.2;
    }

    level.icebergchunks3 hide();
    common_scripts\utility::flag_set( "icebergChunks" );
}

handleiceberglanebreakup()
{
    thread handleinitialicebergshake();
    thread doiceberglanebadplace();
    level notify( "dynamic_event_pre_start" );
    wait 5;
    level notify( "dynamic_event_started" );
    wait 3;
    common_scripts\utility::flag_wait( "icebergAnimProxy" );
    thread notifyaftermajormotion();
    thread maps\mp\mp_fracture_fx::ice_cracking_fx();
    thread handleicebergeventshake();

    if ( level.nextgen )
    {
        thread playicebergchunks1();
        thread playicebergchunks2();
        thread playicebergchunks3();
    }

    level notify( "icebergAnimStart" );
    thread aud_play_iceberg_splitting();
    wait 30;
    level notify( "dynamic_event_complete" );
    thread cleanupsunkenchunks();
}

aud_play_iceberg_splitting()
{
    var_0 = ( 2322.8, 1093.73, -73.7358 );
    wait 0.5;
    thread common_scripts\utility::play_sound_in_space( "iceberg_full_event", var_0 );
}

notifyaftermajormotion()
{
    common_scripts\utility::flag_init( "icebergMajorMotionComplete" );
    wait 18;
    common_scripts\utility::flag_set( "icebergMajorMotionComplete" );
}

doiceberglanebadplace()
{
    var_0 = 0;

    foreach ( var_2 in level.iceberglanebadvolumelist )
    {
        badplace_brush( "IBLaneBadplace" + var_0, 15, var_2, "axis", "allies" );
        var_0++;
    }
}

playicebergchunks1()
{
    wait 2.67;
    common_scripts\utility::flag_wait( "icebergChunks" );
    thread aud_iceberg_sequence_01();
    var_0 = spawnfx( common_scripts\utility::getfx( "mp_cgo_iceberg_foam_1" ), ( 2322.8, 1093.73, -73.7358 ), anglestoforward( ( 270, 0, 178 ) ), anglestoup( ( 270, 0, 178 ) ) );
    triggerfx( var_0 );
    wait 3;
    level.icebergchunks1 show();
    level.icebergchunks1 _meth_827B( "vfx_cgo_iceberg_breakup_1" );
    wait 55;
    var_0 delete();
}

playicebergchunks2()
{
    wait 5.67;
    common_scripts\utility::flag_wait( "icebergChunks" );
    thread aud_iceberg_sequence_02();
    var_0 = spawnfx( common_scripts\utility::getfx( "mp_cgo_iceberg_foam_1" ), ( -1236.57, 973.315, -78 ), anglestoforward( ( 270, 0, 173 ) ), anglestoup( ( 270, 0, 173 ) ) );
    triggerfx( var_0 );
    wait 4;
    level.icebergchunks2 show();
    level.icebergchunks2 _meth_827B( "vfx_cgo_iceberg_breakup_2" );
    wait 55;
    var_0 delete();
}

playicebergchunks3()
{
    wait 1.33;
    common_scripts\utility::flag_wait( "icebergChunks" );
    thread aud_iceberg_sequence_03();
    var_0 = spawnfx( common_scripts\utility::getfx( "mp_cgo_iceberg_foam_1" ), ( 498.966, 1091.24, -78 ), anglestoforward( ( 270, 0, 173 ) ), anglestoup( ( 270, 0, 173 ) ) );
    triggerfx( var_0 );
    wait 3;
    level.icebergchunks3 show();
    level.icebergchunks3 _meth_827B( "vfx_cgo_iceberg_breakup_3" );
    wait 55;
    var_0 delete();
}

aud_iceberg_sequence_01()
{
    var_0 = ( 2322.8, 1093.73, -73.7358 );
    thread common_scripts\utility::play_sound_in_space( "iceberg_full_event", var_0 );
}

aud_iceberg_sequence_02()
{
    var_0 = ( -1236.57, 973.315, -78 );
    thread common_scripts\utility::play_sound_in_space( "iceberg_full_event", var_0 );
}

aud_iceberg_sequence_03()
{
    var_0 = ( 498.966, 1091.24, -78 );
    thread common_scripts\utility::play_sound_in_space( "iceberg_full_event", var_0 );
}

handleinitialicebergshake()
{
    wait 4;
    thread maps\mp\_audio::snd_play_in_space( "mp_fracture_ty_initial_hit", ( 0, 0, 0 ) );
    thread executeicebergeventscriptable( level.icebergeventscriptables["start"] );
}

handleicebergeventshake()
{
    thread wakeupphysicsnearjoint( level.icebergbonelist["B_container_01_liteblue1_jnt"], 10.1 );
    thread wakeupphysicsnearjoint( level.icebergbonelist["A_container_01_orange_jnt"], 7.7 );
    thread wakeupphysicsnearjoint( level.icebergbonelist["A_container_01_red_jnt"], 12.8 );
    thread wakeupphysicsnearjoint( level.icebergbonelist["B_snowcat_jnt"], 8 );
    thread executeicebergeventscriptable( level.icebergeventscriptables["C"] );
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["C"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["chunk_C_jnt"] );
    wait 1;
    thread executeicebergeventscriptable( level.icebergeventscriptables["D"] );
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["D"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["chunk_D_jnt"] );
    wait 0.3;
    thread executeicebergeventscriptable( level.icebergeventscriptables["B"] );
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["B"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["chunk_B_jnt"] );
    wait 0.7;
    thread executeicebergeventscriptable( level.icebergeventscriptables["E"] );
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["E"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["chunk_E_jnt"] );
    wait 0.1;
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["snowcat"] );
    wait 0.2;
    thread executeicebergeventscriptable( level.icebergeventscriptables["A"] );
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["A"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["chunk_A_jnt"] );
    wait 0.7;
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["orange"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["A_container_01_orange_jnt"] );
    wait 0.7;
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["liteblue1"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["B_container_01_liteblue1_jnt"] );
    wait 6.3;
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists["red"] );
    thread wakeupphysicsnearjoint( level.icebergbonelist["A_container_01_red_jnt"] );
    level waittill( "dynamic_event_complete" );
    level notify( "fracture_event_shake_end" );

    foreach ( var_1 in level.icebergshaketriggerlists )
    {
        foreach ( var_3 in var_1 )
            var_3 common_scripts\utility::trigger_off();
    }
}

wakeupphysicsnearjoint( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    physicsexplosionsphere( var_0.animproxy.origin, 800, 0, 0 );
}

executeicebergeventshakesection( var_0 )
{
    thread executeicebergeventscriptable( level.icebergeventscriptables[var_0] );
    var_1 = "chunk_" + var_0 + "_jnt";
    thread activateicebergshaketriggerlists( level.icebergshaketriggerlists[var_0], var_1 );
}

executeicebergeventscriptable( var_0 )
{
    var_0 _meth_83F6( 0, 1 );
    wait 0.1;
    var_0 _meth_83F6( 0, 0 );
}

activateicebergshaketriggerlists( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 thread common_scripts\_dynamic_world::triggertouchthink( ::entericebergshaketrigger, ::exiticebergshaketrigger );
}

entericebergshaketrigger( var_0 )
{
    var_1 = 0;

    if ( isdefined( self.fractureshaketriggercount ) )
        var_1 = self.fractureshaketriggercount;

    if ( var_1 == 0 && !isdefined( self.fractureshakeactive ) )
    {
        self.fractureshakeactive = 1;
        thread icebergtriggershakethink();

        if ( !common_scripts\utility::flag( "icebergMajorMotionComplete" ) )
            thread setupicebergdeath();
    }

    self.fractureshaketriggercount = var_1 + 1;
}

exiticebergshaketrigger( var_0 )
{
    self.fractureshaketriggercount--;
    waittillframeend;

    if ( self.fractureshaketriggercount == 0 )
    {
        self notify( "fracture_event_triggers_left" );
        self.fractureshakeactive = undefined;
        self.icebergtriggerrumbling = undefined;
    }
}

icebergtriggershakethink()
{
    if ( isbot( self ) )
        return;

    self endon( "death" );
    self endon( "disconnect" );
    self endon( "fracture_event_triggers_left" );
    level endon( "dynamic_event_complete" );
    level endon( "fracture_event_shake_end" );

    for (;;)
    {
        while ( !self _meth_8341() || !isdefined( self _meth_83ED() ) )
            waitframe();

        thread icebergtriggershake();
        wait 0.4;
    }
}

icebergtriggershake()
{
    self notify( "fracture_event_shake" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "fracture_event_shake" );

    if ( !isdefined( self.icebergtriggerrumbling ) )
    {
        self _meth_80AE( level.icebergcontinuingrumble );
        self.icebergtriggerrumbling = 1;
    }

    earthquake( 0.075, 0.5, self.origin, 63360, self );
    wait 0.5;
    self _meth_80AF( level.icebergcontinuingrumble );
    self.icebergtriggerrumbling = undefined;
}

setupiceberganimproxy()
{
    common_scripts\utility::flag_init( "icebergAnimProxy" );

    foreach ( var_1 in level.icebergbonelist )
        connectenttoanimproxy( var_1 );

    common_scripts\utility::flag_set( "icebergAnimProxy" );
}

setupanimproxy( var_0 )
{
    var_1 = level.iceberglanemodel gettagorigin( var_0.jointname );
    var_2 = level.iceberglanemodel gettagangles( var_0.jointname );
    var_3 = spawn( "script_model", var_1 );
    var_3 _meth_80B1( var_0.xmodelname );
    var_3.angles = var_2;
    return var_3;
}

connectenttoanimproxy( var_0, var_1 )
{
    var_0.animproxy = setupanimproxy( var_0 );

    if ( isdefined( var_1 ) )
        wait(var_1);

    var_2 = getentarray( var_0.jointname, "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_4 _meth_8446( var_0.animproxy );

        if ( isdefined( var_1 ) )
            wait(var_1);
    }

    thread prepareiceberganimation( var_0 );

    if ( isdefined( var_1 ) )
        wait(var_1);
}

disconnectentfromanimproxyanddelete( var_0, var_1, var_2 )
{
    var_3 = getentarray( var_0.jointname, "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_5 _meth_804F();
        var_5 delete();

        if ( isdefined( var_2 ) )
            wait(var_2);
    }
}

cleanupsunkenchunks()
{
    foreach ( var_1 in level.icebergbonelist )
    {
        if ( isdefined( var_1.shouldclean ) && var_1.shouldclean == 1 )
            disconnectentfromanimproxyanddelete( var_1, level.iceberglanecollapseanimproxy, 0.1 );
    }

    wait 26.67;

    if ( level.nextgen )
    {
        common_scripts\utility::flag_wait( "icebergChunks" );
        level.icebergchunks1 delete();
        level.icebergchunks2 delete();
        level.icebergchunks3 delete();
    }
}

handleiceberglanebreakupend()
{
    level.endstateinit = 1;
    level notify( "dynamic_event_started" );

    foreach ( var_1 in level.icebergbonelist )
        var_1.animproxy.origin = var_1.endpos;

    level notify( "dynamic_event_complete" );
    thread cleanupsunkenchunks();
}

handleiceberglanereset()
{

}

handledynamiceventpaths()
{
    var_0 = getent( "post_dynamic_event_temp_geo", "targetname" );
    var_1 = getent( "pre_dynamic_event_temp_geo", "targetname" );
    var_0 delete();
    var_1 delete();
    patchaerialnodes();
    waittillframeend;
    thread handledynamiceventcarepackagebadvolumes();

    if ( !isdefined( level.endstateinit ) )
    {
        thread disconnectnodes( "post_dynamic_event_pathnodes" );
        level waittill( "dynamic_event_started" );
        thread disconnectnodes( "pre_dynamic_event_pathnodes", 1 );
        level waittill( "icebergMajorMotionComplete" );
        thread connectnodes( "post_dynamic_event_pathnodes", 1 );
    }
    else
        thread disconnectnodes( "pre_dynamic_event_pathnodes" );
}

initcarepackagebadvolumes()
{
    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    var_0 = getentarray( "carepackage_bad_vol", "targetname" );

    foreach ( var_2 in var_0 )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_2;

    foreach ( var_2 in var_0 )
        level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_2;
}

handledynamiceventcarepackagebadvolumes()
{
    var_0 = getentarray( "pre_event_bad_vol", "targetname" );
    var_1 = getentarray( "post_event_bad_vol", "targetname" );

    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    foreach ( var_3 in var_0 )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_3;

    foreach ( var_3 in var_0 )
        level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_3;

    foreach ( var_3 in var_1 )
        level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_3;

    foreach ( var_3 in var_1 )
        level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_3;

    if ( !isdefined( level.endstateinit ) )
    {
        thread disabletriggerset( var_1 );
        level waittill( "dynamic_event_pre_start" );
        thread enabletriggerset( var_1 );
        level waittill( "dynamic_event_complete" );
    }

    thread disabletriggerset( var_0 );
}

enabletriggerset( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();
}

disabletriggerset( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();
}

disconnectnodes( var_0, var_1 )
{
    var_2 = getnodearray( var_0, "targetname" );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_2[var_3] _meth_8059();

        if ( isdefined( var_1 ) && var_1 && var_3 % 20 == 0 )
            waitframe();
    }

    if ( isdefined( var_1 ) && var_1 )
        waitframe();

    var_4 = getnodearray( var_0, "script_noteworthy" );

    for ( var_3 = 0; var_3 < var_4.size; var_3++ )
    {
        var_4[var_3] _meth_8059();

        if ( isdefined( var_1 ) && var_1 && var_3 % 20 == 0 )
            waitframe();
    }

    if ( isdefined( var_1 ) && var_1 )
        waitframe();

    disconnectnodepairs( var_2, var_1 );

    if ( isdefined( var_1 ) && var_1 )
        waitframe();

    disconnectnodepairs( var_4, var_1 );
}

connectnodes( var_0, var_1 )
{
    var_2 = 0;
    var_3 = getnodearray( var_0, "targetname" );

    foreach ( var_5 in var_3 )
    {
        var_5 _meth_805A();
        reconnectnodepairs( var_5 );
        var_2++;

        if ( isdefined( var_1 ) && var_1 && var_2 % 20 == 0 )
            waitframe();
    }

    var_7 = getnodearray( var_0, "script_noteworthy" );

    foreach ( var_9 in var_7 )
    {
        var_9 _meth_805A();
        reconnectnodepairs( var_9 );
        var_2++;

        if ( isdefined( var_1 ) && var_1 && var_2 % 20 == 0 )
            waitframe();
    }
}

reconnectnodepairs( var_0 )
{
    if ( isdefined( var_0.disconnections ) )
    {
        foreach ( var_2 in var_0.disconnections )
            connectnodepair( var_0, var_2 );
    }
}

disconnectnodepairs( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_4 in var_0 )
    {
        var_5 = [];
        var_5 = getlinkednodes( var_4, 1 );

        if ( var_5.size > 0 )
        {
            if ( !isdefined( var_4.disconnections ) )
                var_4.disconnections = [];

            foreach ( var_7 in var_5 )
            {
                if ( !isdefined( var_7.targetname ) || var_7.targetname == "" )
                    var_4.disconnections[var_4.disconnections.size] = var_7;

                disconnectnodepair( var_4, var_7 );
                var_2++;

                if ( isdefined( var_1 ) && var_1 && var_2 % 20 == 0 )
                    waitframe();
            }
        }
    }
}

patchaerialnodes()
{
    var_0 = [];
    var_0[var_0.size] = getnodearray( "post_dynamic_event_pathnodes", "script_noteworthy" );
    var_0[var_0.size] = getnodearray( "pre_dynamic_event_pathnodes", "script_noteworthy" );
    var_0[var_0.size] = getnodearray( "post_dynamic_event_pathnodes", "targetname" );
    var_0[var_0.size] = getnodearray( "pre_dynamic_event_pathnodes", "targetname" );

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in var_2 )
            var_4.forceenableaerialnode = 1;
    }
}

setupicebergdeath()
{
    if ( isdefined( self.isjuggernaut ) && self.isjuggernaut )
        return;

    self.prev_body = self.body;
    thread cleanupicebergdeath();
    self.prekilledfunc = ::onicebergdeath;
}

cleanupicebergdeath()
{
    self endon( "doneIcebergDeath" );
    self endon( "disconnect" );
    common_scripts\utility::waittill_any( "fracture_event_triggers_left", "icebergMajorMotionComplete" );
    self.prekilledfunc = undefined;
}

onicebergdeath( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    thread onicebergdeath_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
}

onicebergdeath_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    self.prekilledfunc = undefined;
    waittillframeend;

    if ( !isdefined( self.body ) || _func_294( self.body ) || isdefined( self.prev_body ) && self.prev_body == self.body )
        return;

    var_11 = undefined;

    if ( isdefined( var_4 ) )
    {
        if ( isexplosivedamagemod( var_4 ) )
            var_11 = 0.5;
        else if ( var_4 == "MOD_MELEE_ALT" && var_2 _meth_817C() != "prone" )
            var_11 = 0.5;
    }

    if ( isdefined( var_11 ) )
        wait(var_11);

    if ( !isdefined( self.body ) || _func_294( self.body ) )
        return;

    self.body _meth_8023();
    self notify( "doneIcebergDeath" );
}

fracturegoliathdeathhack()
{
    level endon( "dynamic_event_complete" );

    for (;;)
    {
        level waittill( "juggernaut_equipped", var_0 );

        if ( !isai( var_0 ) )
        {
            var_0.prekilledfunc = ::fracturegoliathdeathhack_internal;
            var_0 thread fracturegoliathdeathhack_cleanup();
        }
    }
}

fracturegoliathdeathhack_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( self.origin[1] > 480.0 && !( isdefined( self.juggernautsuicide ) && self.juggernautsuicide ) )
    {
        playfx( common_scripts\utility::getfx( "goliath_self_destruct" ), self.origin, anglestoup( self.angles ) );
        maps\mp\_snd_common_mp::snd_message( "goliath_death_explosion" );
        self.juggernautsuicide = 1;
        self.hideondeath = 1;
    }

    self.prekilledfunc = undefined;
    self notify( "deathHackFinished" );
}

fracturegoliathdeathhack_cleanup()
{
    self endon( "deathHackFinished" );
    common_scripts\utility::waittill_any( "disconnect", "joined_team", "joined_spectators", "jugg_removed" );
    self.prekilledfunc = undefined;
}
