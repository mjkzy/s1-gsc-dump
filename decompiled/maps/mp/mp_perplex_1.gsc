// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.callbackstartgametype = ::perplex_callbackstartgametype;
    maps\mp\mp_perplex_1_precache::main();
    maps\createart\mp_perplex_1_art::main();
    maps\mp\mp_perplex_1_fx::main();
    maps\mp\_load::main();
    maps\mp\mp_perplex_1_lighting::main();
    maps\mp\mp_perplex_1_aud::main();
    maps\mp\_water::init();
    maps\mp\_water::init();
    maps\mp\_compass::setupminimap( "compass_map_mp_perplex_1" );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    precachemodel( "genericprop" );

    if ( level.nextgen )
    {
        map_restart( "per_ferry_boat" );
        map_restart( "per_sail_boat" );
        map_restart( "per_sail_boat_idle_a" );
        map_restart( "per_sail_boat_idle_b" );
        map_restart( "per_sail_boat_idle_c" );
        map_restart( "per_sail_boat_idle_d" );
        map_restart( "per_windmill_idle01" );
        map_restart( "per_windmill_idle02" );
        map_restart( "per_windmill_idle03" );
        map_restart( "per_windmill_idle04" );
    }

    level.goliath_bad_landing_volumes = [];

    if ( level.nextgen )
    {
        thread vignetteferry();
        thread vignettesailboats();
    }

    thread vignetterooftopwindmills();
    thread perplexkillstreakoverrides();
    thread removecentermissilespawn();
    thread gamemodetraversalcheck();
    level dynamicevent_init();
    level thread maps\mp\_dynamic_events::dynamicevent( ::dynamiceventsuspendedapartmentshiftanim, undefined, ::dynamiceventsuspendedapartmentshiftanimend );
    level.osplightset = "mp_perplex_osp";
    level.warbirdlightset = "mp_perplex_osp";
    level.vulcanlightset = "mp_perplex_osp";

    if ( level.currentgen )
    {
        thread cg_overridevulcanheight();
        thread cg_overridewarbirdheight();
    }

    thread clip_fixes();
    thread trigger_fixes();
}

clip_fixes()
{
    thread boardwalkvehicleholefix();
    thread atriumdronepushholefix();
    thread modelapartmentstuckspotfix();
}

boardwalkvehicleholefix()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( -190, 1376, -64 ), ( 270, 180, 180 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_vehicle_16_256_256", ( 66, 1376, -64 ), ( 270, 180, 180 ) );
}

atriumdronepushholefix()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 552, 473, 192 ), ( 0, 180, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -488, 273, 192 ), ( 0, 0, 0 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( -416, -296, 192 ), ( 0, 90, 0 ) );
}

trigger_fixes()
{
    thread goliathoutofmapfix();
}

goliathoutofmapfix()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( 0, 0, -320 ), 0, 72, 3072 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isbot( var_1 ) || isagent( var_1 ) )
            var_1 _meth_8051( var_1.health + 999, var_0.origin );
    }
}

modelapartmentstuckspotfix()
{
    var_0 = 0;
    var_1 = 0;

    for ( var_2 = 0; var_2 < 6; var_2++ )
    {
        var_0 = 12 - var_2 * 10;
        var_1 = 1570 - var_2 * 16;
        maps\mp\_utility::spawnpatchclip( "patchclip_player_16_128_128", ( var_1, -1280, var_0 ), ( 0, 0, 0 ) );
    }
}

cg_overridevulcanheight()
{
    wait 1;

    if ( !isdefined( level.orbitallaseroverrides ) )
        level.orbitallaseroverrides = spawnstruct();

    level.orbitallaseroverrides.spawnheight = 2352;
}

cg_overridewarbirdheight()
{
    if ( !isdefined( level.helianchor ) )
        level waittill( "reset_warbird_height" );

    wait 1;

    if ( level.helianchor.origin[2] < 2352 )
        level.warbirdzoffset = 1328;
    else
        level.helianchor.origin[2] = 2352;
}

removecentermissilespawn()
{
    var_0 = getent( "auto613", "target" );
    var_1 = getent( "auto613", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 delete();

    if ( isdefined( var_1 ) )
        var_1 delete();
}

perplex_callbackstartgametype()
{
    maps\mp\gametypes\_gamelogic::callback_startgametype();
    common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

dynamicevent_init()
{
    level endon( "game_ended" );
    level thread handledynamiceventpathnodesforstate();
    level thread handledynamiceventcarepackagebadvol();
    level thread handledynamiceventobjectresettriggers();
    level.drone_top_origins = [];
    level.dynamiceventdrones = [];
    level.dynamiceventapartments = [];
    level.dynamiceventanimorg = getent( "dynamic_event_animorg", "targetname" );
    level.building04 = dynamiceventsetupsuspendedapartment( "dynamic_event_apartment_04", "per_drone04_idle" );
    level.building03 = dynamiceventsetupsuspendedapartment( "dynamic_event_apartment_03", "per_drone03_idle" );
    level.building02 = dynamiceventsetupsuspendedapartment( "dynamic_event_apartment_02", "per_drone02_idle" );
    level.building01 = dynamiceventsetupsuspendedapartment( "dynamic_event_apartment_01", "per_drone01_idle" );
    level thread do_drone_top_damage();

    if ( level.nextgen )
    {
        var_0 = getent( "mp_recovery_signage", "targetname" );
        var_0 common_scripts\utility::hide_notsolid();
    }
}

dynamiceventsetupsuspendedapartment( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    var_3 = undefined;

    foreach ( var_5 in var_2 )
    {
        if ( var_5.classname == "script_origin" )
        {
            var_3 = var_5;
            break;
        }
    }

    foreach ( var_5 in var_2 )
    {
        if ( var_5 != var_3 )
            var_5 _meth_8446( var_3 );
    }

    var_9 = getent( var_0 + "_col", "targetname" );
    var_10 = getent( var_0 + "_drone", "targetname" );
    var_11 = getent( var_0 + "_drone_reset_trig", "targetname" );
    var_12 = getent( var_0 + "_drone_body_col", "targetname" );
    var_13 = getent( var_0 + "_drone_killorg", "targetname" );

    if ( isdefined( level.drone_top_origins ) && isdefined( var_13 ) )
        level.drone_top_origins[level.drone_top_origins.size] = var_13;

    thread handleobjectresettrigger( var_11, var_13 );

    if ( !getdvarint( "scr_game_grappling_hook", 0 ) )
        thread handleragdollwakeup( var_3.origin, 500 );

    thread playdronevfx( var_10 );
    var_14 = var_10 gettagorigin( "TAG_HANDLE" );
    var_15 = var_10 gettagangles( "TAG_HANDLE" );
    var_16 = spawn( "script_model", var_14 );
    var_16 _meth_80B1( "genericprop" );
    var_16.angles = var_15;
    var_16 _meth_8446( var_10, "TAG_HANDLE" );
    var_17 = var_10 gettagorigin( "body_main" );
    var_18 = var_10 gettagangles( "body_main" );
    var_19 = spawn( "script_model", var_17 );
    var_19 _meth_80B1( "genericprop" );
    var_19.angles = var_18;
    var_19 _meth_8446( var_10, "body_main" );

    if ( level.nextgen )
    {
        var_20 = getent( var_0 + "_drone_leg_frontright_col", "targetname" );
        var_21 = getent( var_0 + "_drone_leg_frontleft_col", "targetname" );
        var_22 = getent( var_0 + "_drone_leg_backright_col", "targetname" );
        var_23 = getent( var_0 + "_drone_leg_backleft_col", "targetname" );
        var_24 = var_10 gettagorigin( "fx_joint_0" );
        var_25 = var_10 gettagangles( "fx_joint_0" );
        var_26 = spawn( "script_model", var_24 );
        var_26 _meth_80B1( "genericprop" );
        var_26.angles = var_25;
        var_26 _meth_8446( var_10, "fx_joint_0" );
        var_27 = var_10 gettagorigin( "fx_joint_1" );
        var_28 = var_10 gettagangles( "fx_joint_1" );
        var_29 = spawn( "script_model", var_27 );
        var_29 _meth_80B1( "genericprop" );
        var_29.angles = var_28;
        var_29 _meth_8446( var_10, "fx_joint_1" );
        var_30 = var_10 gettagorigin( "fx_joint_2" );
        var_31 = var_10 gettagangles( "fx_joint_2" );
        var_32 = spawn( "script_model", var_30 );
        var_32 _meth_80B1( "genericprop" );
        var_32.angles = var_31;
        var_32 _meth_8446( var_10, "fx_joint_2" );
        var_33 = var_10 gettagorigin( "fx_joint_3" );
        var_34 = var_10 gettagangles( "fx_joint_3" );
        var_35 = spawn( "script_model", var_33 );
        var_35 _meth_80B1( "genericprop" );
        var_35.angles = var_25;
        var_35 _meth_8446( var_10, "fx_joint_3" );
        var_21 _meth_8446( var_26 );
        var_20 _meth_8446( var_29 );
        var_23 _meth_8446( var_32 );
        var_22 _meth_8446( var_35 );
        var_10.clipents = [ var_21, var_26, var_20, var_29, var_23, var_32, var_22, var_35, var_12, var_19, var_13, var_11 ];
    }
    else
    {
        var_36 = getent( var_0 + "_drone_legs_col", "targetname" );
        var_36 _meth_8446( var_19 );
        var_10.legsclip = var_36;
        var_10.clipents = [ var_12, var_19, var_13, var_11 ];
    }

    var_37 = getent( "dynamic_event_slot_clip", "targetname" );
    thread dynamiceventcollisionhandling( var_9, var_37 );
    var_9 _meth_8446( var_3 );
    var_3.col = var_9;
    var_3.proxy = var_16;
    var_12 _meth_8446( var_19 );
    var_13 _meth_8446( var_19 );
    var_10.bodyclip = var_12;
    var_10.bodyclip.parent = var_19;
    var_3.origin = var_14;
    var_3.angles = var_15 - ( 0, 180, 0 );
    var_9.angles = var_3.angles;
    var_3 _meth_8446( var_16 );
    var_10 _meth_848B( var_1, level.dynamiceventanimorg.origin, level.dynamiceventanimorg.angles, "droneIdle" );
    level.dynamiceventdrones[level.dynamiceventdrones.size] = var_10;
    level.dynamiceventapartments[level.dynamiceventapartments.size] = var_3;
    return var_3;
}

dynamiceventsuspendedapartmentshiftanim()
{
    if ( !getdvarint( "scr_game_grappling_hook", 0 ) )
    {
        var_0 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_0 playsound( "anrx_per_dynevent_warn" );
        wait 5;
        level notify( "dynamic_event_started" );
        var_1 = getent( "dynamic_event_apartment_01_drone", "targetname" );
        var_2 = getent( "dynamic_event_apartment_02_drone", "targetname" );
        var_3 = getent( "dynamic_event_apartment_03_drone", "targetname" );
        var_4 = getent( "dynamic_event_apartment_04_drone", "targetname" );
        dynamiceventhandleshiftingapartment( var_1, level.building01, "per_apartment01_drop", "per_drone01_drop_apartment", 30 );
        dynamiceventhandleshiftingapartment( var_2, level.building02, "per_apartment02_drop", "per_drone02_drop_apartment", 28 );
        dynamiceventhandleshiftingapartment( var_3, level.building03, "per_apartment03_drop", "per_drone03_drop_apartment", 27 );
        dynamiceventhandlefinalshiftingapartment( var_4, level.building04, "per_drone04_flight", "per_drone04_idle02" );
        level notify( "dynamic_event_complete" );
        var_0 playsound( "anrx_per_dynevent_act" );
    }
}

dynamiceventhandleshiftingapartment( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 waittillmatch( "droneIdle", "end" );

    if ( level.currentgen )
        var_0.legsclip delete();

    thread playdroneactivevfx( var_0 );
    var_0 _meth_827A();
    var_1 aud_map_event_start();
    var_1.proxy _meth_804F();
    var_0 _meth_848B( var_3, level.dynamiceventanimorg.origin, level.dynamiceventanimorg.angles, "droneDropoff" );
    var_1.proxy _meth_848B( var_2, level.dynamiceventanimorg.origin, level.dynamiceventanimorg.angles );
    thread dynamiceventplayaccordion( var_1.targetname + "_accordian", 5 );
    thread notifybuildinginplace( var_1.targetname, 15 );
    wait(var_4);
    var_0 deletedroneandcollision();
}

deletedroneandcollision()
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.clipents ) )
        {
            foreach ( var_1 in self.clipents )
                var_1 delete();
        }

        self delete();
    }
}

handleobjectresettrigger( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = 32;

    if ( isdefined( var_0 ) )
        var_0.targetname = "out_of_bounds";

    if ( level.gametype == "ball" )
        var_2 = 24;

    while ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        var_0.origin = var_1.origin - ( 0, 0, var_2 );
        wait 0.5;
    }
}

handleragdollwakeup( var_0, var_1 )
{
    level waittill( "dynamic_event_started" );
    physicsexplosionsphere( var_0, var_1, 0, 0 );
}

notifybuildinginplace( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    level notify( var_0 + "_in_place" );
}

dynamiceventhandlefinalshiftingapartment( var_0, var_1, var_2, var_3 )
{
    var_0 waittillmatch( "droneIdle", "end" );
    var_0 _meth_827A();
    var_0 _meth_848B( var_2, level.dynamiceventanimorg.origin, level.dynamiceventanimorg.angles, "droneReposition" );
    var_0 waittillmatch( "droneReposition", "end" );
    var_0 _meth_827A();
    var_0 _meth_848B( var_3, level.dynamiceventanimorg.origin, level.dynamiceventanimorg.angles );
}

dynamiceventcollisionhandling( var_0, var_1 )
{
    wait 1;

    foreach ( var_3 in level.dynamiceventdrones )
    {
        if ( isdefined( var_3.bodyclip ) )
            var_3.bodyclip _meth_804F();
    }

    level waittill( "dynamic_event_started" );

    foreach ( var_3 in level.dynamiceventdrones )
    {
        if ( isdefined( var_3.bodyclip ) )
        {
            if ( level.nextgen )
            {
                var_3.bodyclip.origin = var_3.bodyclip.parent.origin;
                var_3.bodyclip.angles = var_3.bodyclip.parent.angles;
            }

            var_3.bodyclip _meth_8446( var_3.bodyclip.parent );
        }
    }

    var_0.unresolved_collision_kill = 1;
    var_1.unresolved_collision_kill = 1;
}

dynamiceventplayaccordion( var_0, var_1 )
{
    var_2 = _func_231( var_0, "targetname" );

    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
            var_4 _meth_83F6( "root_part", "anim_state" );
    }
}

handledynamiceventcarepackagebadvol()
{
    var_0 = getent( "carepackage_bad_vol", "targetname" );

    while ( !isdefined( level.orbital_util_covered_volumes ) )
        waitframe();

    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_0;
    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_0;
}

handledynamiceventobjectresettriggers()
{
    var_0 = getent( "object_reset_trigger_01", "targetname" );
    var_1 = getent( "object_reset_trigger_02", "targetname" );
    var_2 = getent( "uplink_ball_blocker", "targetname" );
    var_0.targetname = "out_of_bounds";
    var_1.targetname = "out_of_bounds";
    var_0 common_scripts\utility::trigger_off();
    var_1 common_scripts\utility::trigger_off();
    var_2 common_scripts\utility::trigger_off();
    level waittill( "dynamic_event_started" );
    var_0 common_scripts\utility::trigger_on();
    level waittill( "dynamic_event_apartment_01_in_place" );
    var_0 delete();
    var_2 common_scripts\utility::trigger_on();
    level waittill( "dynamic_event_apartment_02_in_place" );
    var_1 common_scripts\utility::trigger_on();
    level waittill( "dynamic_event_apartment_03_in_place" );
    var_1 delete();
}

dynamiceventsuspendedapartmentshiftanimend()
{
    var_0 = getent( "final_position_apartment_01", "targetname" );
    var_1 = getent( "final_position_apartment_02", "targetname" );
    var_2 = getent( "final_position_apartment_03", "targetname" );
    var_3 = getent( "final_position_apartment_04", "targetname" );
    var_4 = undefined;

    foreach ( var_6 in level.dynamiceventdrones )
    {
        if ( var_6.targetname == "dynamic_event_apartment_04_drone" )
        {
            var_4 = var_6;
            break;
        }
    }

    foreach ( var_9 in level.dynamiceventapartments )
        var_9 _meth_804F();

    level.building01.origin = var_0.origin;
    level.building01.angles = var_0.angles;
    level.building02.origin = var_1.origin;
    level.building02.angles = var_1.angles;
    level.building03.origin = var_2.origin;
    level.building03.angles = var_2.angles;
    level.building04.origin = var_3.origin;
    level.building04.angles = var_3.angles;

    foreach ( var_9 in level.dynamiceventapartments )
    {
        var_9.col.origin = var_9.origin;
        var_9.col.angles = var_9.angles;
    }

    var_4 _meth_827A();
    var_4.origin = level.dynamiceventanimorg.origin;
    var_4.angles = level.dynamiceventanimorg.angles;
    level.building04.origin = level.dynamiceventanimorg.origin;
    level.building04.angles = level.dynamiceventanimorg.angles - ( 0, 180, 0 );
    level.building04.proxy.origin = level.dynamiceventanimorg.origin;
    level.building04.proxy.angles = level.dynamiceventanimorg.angles;
    var_4 _meth_827B( "per_drone04_idle02" );
    level.building04 _meth_8446( level.building04.proxy );

    foreach ( var_6 in level.dynamiceventdrones )
    {
        if ( isdefined( var_6 ) && var_6 != var_4 )
            var_6 deletedroneandcollision();
    }

    handledynamiceventpathnodesforstate( 1 );
}

playdronevfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_hover" ), var_0, "TAG_ORIGIN" );
    var_0 _meth_8075( "mp_pp_drone_idle_lo" );
}

playdroneactivevfx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_active" ), var_0, "TAG_ORIGIN" );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_leg_glow" ), var_0, "fx_joint_0" );
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_leg_glow" ), var_0, "fx_joint_1" );
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_leg_glow" ), var_0, "fx_joint_2" );
    playfxontag( common_scripts\utility::getfx( "mp_plex_drone_leg_glow" ), var_0, "fx_joint_3" );
}

do_drone_top_damage()
{
    level endon( "game_ended" );
    var_0 = 198;
    var_1 = 12;
    var_2 = -100;
    var_3 = var_0 * var_0;

    while ( !isdefined( level.players ) )
        waitframe();

    var_4 = level.drone_top_origins.size;

    for (;;)
    {
        if ( !isdefined( level.drone_top_origins ) || var_4 == 0 )
            return;

        var_5 = 0;

        foreach ( var_7 in level.drone_top_origins )
        {
            if ( isdefined( var_7 ) )
            {
                foreach ( var_9 in level.players )
                {
                    if ( !isdefined( var_9 ) || !isalive( var_9 ) )
                        continue;

                    if ( _func_220( var_7.origin, var_9.origin ) < var_3 )
                    {
                        var_10 = var_9.origin[2] - var_7.origin[2];

                        if ( var_10 > var_2 && var_10 < var_1 )
                            var_9 _meth_8051( 1000, var_7.origin, undefined, undefined, "MOD_TRIGGER_HURT", "none", "none" );
                    }
                }

                if ( isdefined( level.ugvs ) )
                {
                    foreach ( var_13 in level.ugvs )
                    {
                        if ( _func_220( var_7.origin, var_13.origin ) < var_3 )
                        {
                            var_14 = var_13.origin[2] - var_7.origin[2];

                            if ( var_14 > var_2 + 85 && var_14 < var_1 )
                                var_13 notify( "death" );
                        }
                    }
                }

                var_5++;
            }
        }

        var_4 = var_5;
        wait 0.05;
    }
}

handledynamiceventpathnodesforstate( var_0 )
{
    level endon( "game_ended" );
    level notify( "override_dynamic_path_handling" );
    level endon( "override_dynamic_path_handling" );
    wait 1;
    var_1 = getent( "building_01_dynamic_path_brush", "targetname" );
    var_2 = getent( "building_02_dynamic_path_brush", "targetname" );
    var_3 = getent( "building_03_dynamic_path_brush", "targetname" );
    var_4 = getent( "pre_dynamic_event_dynamic_path_brush", "targetname" );
    var_5 = getent( "both_dynamic_path_brush", "targetname" );
    var_6 = getentarray( "dynamic_event_temp_clip", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 delete();

    if ( isdefined( var_0 ) && var_0 == 1 )
    {
        disconnectnodesforbrush( var_4 );
        connectnodesforbrush( var_1 );
        connectnodesforbrush( var_2 );
        connectnodesforbrush( var_3 );
        connectnodesforbrush( var_5 );
    }
    else
    {
        var_1 _meth_8057();
        var_1 common_scripts\utility::trigger_off();
        var_2 _meth_8057();
        var_2 common_scripts\utility::trigger_off();
        var_3 _meth_8057();
        var_3 common_scripts\utility::trigger_off();
        var_4 _meth_8058();
        var_4 common_scripts\utility::trigger_off();
        var_5 _meth_8058();
        var_5 common_scripts\utility::trigger_off();
        level waittill( "dynamic_event_started" );
        disconnectnodesforbrush( var_4 );
        disconnectnodesforbrush( var_5 );
        level waittill( "dynamic_event_apartment_01_in_place" );
        connectnodesforbrush( var_1 );
        level waittill( "dynamic_event_apartment_02_in_place" );
        connectnodesforbrush( var_2 );
        connectnodesforbrush( var_5 );
        level waittill( "dynamic_event_apartment_03_in_place" );
        connectnodesforbrush( var_3 );
    }
}

gamemodetraversalcheck()
{
    wait 2;
    var_0 = getent( "uplink_non_goalnode_brush", "targetname" );

    if ( level.gametype == "ball" )
    {
        var_0 _meth_8057();
        var_0 common_scripts\utility::trigger_off();
    }
    else
    {
        var_0 _meth_8058();
        var_0 common_scripts\utility::trigger_off();
    }

    var_0 delete();
}

connectnodesforbrush( var_0 )
{
    var_0 common_scripts\utility::trigger_on();
    var_0 _meth_8058();
    var_0 common_scripts\utility::trigger_off();
}

disconnectnodesforbrush( var_0 )
{
    var_0 common_scripts\utility::trigger_on();
    var_0 _meth_8057();
    var_0 common_scripts\utility::trigger_off();
}

perplexkillstreakoverrides()
{
    while ( !isdefined( level.orbitalsupportoverrides ) )
        waitframe();

    level.orbitalsupportoverrides.spawnheight = 6500;
    level.remote_missile_height_override = 18000;
}

vignetteferry()
{
    var_0 = getent( "ferry_loop_org", "targetname" );
    var_1 = spawn( "script_model", var_0.origin );
    var_1 _meth_80B1( "per_ferryboat_01" );
    var_1.angles = var_0.angles;

    for (;;)
    {
        var_1 _meth_8279( "per_ferry_boat" );
        playfxontag( common_scripts\utility::getfx( "boat_wake_ferryboat_main_foam" ), var_1, "boat_body" );
        var_2 = randomintrange( 220, 340 );
        wait(var_2);
        stopfxontag( common_scripts\utility::getfx( "boat_wake_ferryboat_main_foam" ), var_1, "boat_body" );
        wait 2;
        var_1 _meth_827A();
    }
}

vignetterooftopwindmills()
{
    var_0 = getentarray( "rooftop_windmill", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_noteworthy ) )
        {
            var_2 _meth_8279( var_2.script_noteworthy );
            continue;
        }

        var_2 _meth_8279( "per_windmill_idle01" );
    }
}

vignettesailboats()
{
    for ( var_0 = 1; var_0 < 6; var_0 += 1 )
    {
        switch ( var_0 )
        {
            case 1:
                var_1 = getent( "sailboat_idle_a_org", "targetname" );
                var_2 = spawn( "script_model", var_1.origin );
                var_2 _meth_80B1( "per_sailboat_01" );
                var_2.angles = var_1.angles;
                playfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
                var_2 _meth_8279( "per_sail_boat_idle_a" );
                break;
            case 2:
                var_1 = getent( "sailboat_idle_b_org", "targetname" );
                var_2 = spawn( "script_model", var_1.origin );
                var_2 _meth_80B1( "per_sailboat_01" );
                var_2.angles = var_1.angles;
                playfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
                var_2 _meth_8279( "per_sail_boat_idle_b" );
                break;
            case 3:
                var_1 = getent( "sailboat_idle_c_org", "targetname" );
                var_2 = spawn( "script_model", var_1.origin );
                var_2 _meth_80B1( "per_sailboat_01" );
                var_2.angles = var_1.angles;
                playfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
                var_2 _meth_8279( "per_sail_boat_idle_c" );
                break;
            case 4:
                var_1 = getent( "sailboat_idle_d_org", "targetname" );
                var_2 = spawn( "script_model", var_1.origin );
                var_2 _meth_80B1( "per_sailboat_01" );
                var_2.angles = var_1.angles;
                playfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
                var_2 _meth_8279( "per_sail_boat_idle_d" );
                break;
            case 5:
                var_1 = getent( "ferry_idle_org", "targetname" );
                var_3 = spawn( "script_model", var_1.origin );
                var_3 _meth_80B1( "per_ferryboat_01" );
                var_3.angles = var_1.angles;
                var_3 _meth_8279( "per_ferry_boat_dock_idle" );
                break;
        }
    }

    var_4 = getent( "sailboat_loop_org", "targetname" );
    var_2 = spawn( "script_model", var_4.origin );
    var_2 _meth_80B1( "per_sailboat_01" );
    var_2.angles = var_4.angles;

    for (;;)
    {
        var_2 _meth_8279( "per_sail_boat" );
        playfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
        var_5 = randomintrange( 180, 300 );
        wait(var_5);
        stopfxontag( common_scripts\utility::getfx( "boat_wake_sailboat_main_foam" ), var_2, "boat_body" );
        wait 2;
        var_2 _meth_827A();
    }
}

aud_map_event_start()
{
    var_0 = self;

    if ( var_0 == level.building01 )
        maps\mp\_audio::snd_play_linked( "mp_pp_bldg_move_01", var_0, 60 );

    if ( var_0 == level.building02 )
        maps\mp\_audio::snd_play_linked( "mp_pp_bldg_move_02", var_0, 60 );

    if ( var_0 == level.building03 )
        maps\mp\_audio::snd_play_linked( "mp_pp_bldg_move_03", var_0, 60 );
}
