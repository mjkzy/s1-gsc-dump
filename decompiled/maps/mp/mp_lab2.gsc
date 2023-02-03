// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_lab2_precache::main();
    maps\createart\mp_lab2_art::main();
    maps\mp\mp_lab2_fx::main();
    common_scripts\utility::setlightingstate( 1 );
    maps\mp\_load::main();
    thread setup_audio();
    thread set_lighting_values();
    thread set_umbra_values();
    level.ospvisionset = "mp_lab2_osp";
    level.osplightset = "mp_lab2_osp";
    level.warbirdvisionset = "mp_lab2_osp";
    level.warbirdlightset = "mp_lab2_osp";
    level.vulcanvisionset = "mp_lab2_osp";
    level.vulcanlightset = "mp_lab2_osp";
    maps\mp\_compass::setupminimap( "compass_map_mp_lab2" );
    setdvar( "sm_minSpotLightScore", 0.0007 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if ( level.nextgen )
        level.aerial_pathnode_group_connect_dist = 350;

    precachemodel( "lab2_cannister_holder_01" );
    precachemodel( "lab2_industrial_crane_01" );
    precachempanim( "lab2_dynamic_event_helicopter_anim" );
    precachempanim( "lab2_dynamic_event_harness_anim" );
    precachempanim( "lab2_dynamic_event_building_anim" );
    precachempanim( "lab2_industrial_crane_anim" );
    precachempanim( "lab2_dynamic_event_harness_invis_anim" );
    precacheshellshock( "mp_lab_gas" );
    precacheshader( "lab_gas_overlay" );
    level.missileparticles = spawnstruct();
    level.missileparticles.spraymachine = loadfx( "vfx/water/industrial_hot_water_sprayer" );
    level.missileparticles.spraymachinedrips = loadfx( "vfx/water/industrial_hot_water_sprayer_drips" );
    level.missileparticles.canisterdrips = loadfx( "vfx/map/mp_lab/canister_drips" );
    level.missileparticles.canistersteam = loadfx( "vfx/map/mp_lab/canister_steam" );
    level.missileparticles.drymachine = loadfx( "vfx/map/mp_lab/industrial_dryer_fan" );
    level.missileparticles.sparkgreenloop = loadfx( "vfx/map/mp_lab/flare_sparks_ambient_green" );
    level.missileparticles.greencrazylightloop = loadfx( "vfx/smoke/smoke_flare_marker_green_windy" );
    level.missileparticles.greensmokeloop = loadfx( "vfx/map/mp_lab/chem_smoke_green" );
    level.missileparticles.missileexplosion = loadfx( "vfx/explosion/poison_gas_canister_explosion" );
    level.missileparticles.cranesparks = loadfx( "vfx/sparks/crane_scrape_sparks_small_looping" );
    level.alarmfx01 = loadfx( "vfx/lights/mp_lab2/lab2_crane_red_alarm" );

    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
        return;

    thread setupcranechem();
    thread onplayerconnectfucntions();
    thread setupdynamicevent();
    thread setuprobotarmnotetracks();
    thread maps\mp\_utility::findandplayanims( "animated_prop", 1 );
    thread specialgametypescript();
    setdvar( "r_reactivemotionfrequencyscale", 0.5 );
    setdvar( "r_reactivemotionamplitudescale", 0.5 );
    setdvar( "r_gunSightColorEntityScale", "7" );
    setdvar( "r_gunSightColorNoneScale", "0.8" );
    level.labtemptuner1 = 9;
    level.labtemptuner2 = 4;
    level.labtemptuner3 = -2;
    level.orbitalsupportoverridefunc = ::labpaladinoverrides;
    level.orbitallaseroverridefunc = ::lab2customlaserstreakfunc;
    thread lab2customairstrike();
    thread lab2botkilltrigger();
    thread lab2playerkilltrigger();
}

set_umbra_values()
{
    setdvar( "r_umbraAccurateOcclusionThreshold", 128 );
}

specialgametypescript()
{
    thread waitcarryobjects();
}

waitcarryobjects()
{
    level endon( "game_ended" );

    if ( level.gametype == "sd" )
    {
        while ( !isdefined( level.sdbomb ) )
            wait 0.05;

        level.sdbomb thread watchcarryobjects();
    }
    else if ( level.gametype == "sab" )
    {
        while ( !isdefined( level.sabbomb ) )
            wait 0.05;

        level.sabbomb thread watchcarryobjects();
    }
    else if ( level.gametype == "tdef" )
    {
        while ( !isdefined( level.gameflag ) )
            wait 0.05;

        level.gameflag thread watchcarryobjects();
    }
    else if ( level.gametype == "ball" )
    {
        while ( !isdefined( level.balls ) )
            wait 0.05;

        foreach ( var_1 in level.balls )
            var_1 thread watchcarryobjects();
    }
    else if ( level.gametype == "ctf" )
    {
        while ( !isdefined( level.teamflags ) || !isdefined( level.teamflags[game["defenders"]] ) || !isdefined( level.teamflags[game["attackers"]] ) )
            wait 0.05;

        level.teamflags[game["defenders"]] thread watchcarryobjects();
        level.teamflags[game["attackers"]] thread watchcarryobjects();
    }
}

watchcarryobjects()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "dropped" );
        wait 0.1;

        if ( isoutofbounds() )
        {
            maps\mp\gametypes\_gameobjects::returnhome();
            continue;
        }

        if ( isdefined( level.flyingbuildingent ) && level.flyingbuildingent.flying == 1 && isdefined( level.flyingbuildingent.triggerhurtlower ) && isdefined( level.flyingbuildingent.triggerhurtupper ) )
        {
            while ( level.flyingbuildingent.flying == 1 )
            {
                if ( self.visuals[0] istouching( level.flyingbuildingent.triggerhurtlower ) || self.visuals[0] istouching( level.flyingbuildingent.triggerhurtupper ) )
                {
                    maps\mp\gametypes\_gameobjects::returnhome();
                    break;
                }

                wait 0.05;
            }
        }
    }
}

isoutofbounds()
{
    var_0 = getentarray( "radiation", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_0[var_1] ) )
            continue;

        return 1;
    }

    var_2 = getentarray( "minefield", "targetname" );

    for ( var_1 = 0; var_1 < var_2.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_2[var_1] ) )
            continue;

        return 1;
    }

    var_3 = getentarray( "trigger_hurt", "classname" );

    for ( var_1 = 0; var_1 < var_3.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_3[var_1] ) )
            continue;

        return 1;
    }

    var_4 = getentarray( "boost_jump_border_trig", "targetname" );

    for ( var_1 = 0; var_1 < var_4.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_4[var_1] ) )
            continue;

        return 1;
    }

    var_5 = getentarray( "object_out_of_bounds", "targetname" );

    for ( var_1 = 0; var_1 < var_5.size; var_1++ )
    {
        if ( !self.visuals[0] istouching( var_5[var_1] ) )
            continue;

        return 1;
    }

    return 0;
}

setupdynamicevent()
{
    var_0 = getentarray( "ground_shadow_patch_before", "targetname" );
    var_1 = getentarray( "ground_shadow_patch_after", "targetname" );
    var_2 = getent( "teleport_from", "targetname" );
    var_3 = getent( "teleport_to", "targetname" );

    foreach ( var_5 in var_0 )
        var_5.origin += var_3.origin - var_2.origin;

    foreach ( var_5 in var_1 )
        var_5 hide();

    common_scripts\utility::setlightingstate( 2 );
    var_9 = getentarray( "dynamic_building_master_prefab", "targetname" );
    var_10 = undefined;
    var_11 = [];

    foreach ( var_13 in var_9 )
    {
        if ( isdefined( var_13.script_noteworthy ) && var_13.script_noteworthy == "origin" )
        {
            var_10 = spawn( "script_origin", var_13.origin );
            continue;
        }

        var_11[var_11.size] = var_13;
    }

    if ( !isdefined( var_10 ) )
        var_10 = spawn( "script_origin", var_9[0].origin );

    var_10.radiant_pos = var_10.origin;
    var_10.flying = 0;
    var_10.parts = var_11;
    var_10.triggerhurtlower = getent( "building_hurt_01", "targetname" );
    var_10.triggerhurtupper = getent( "building_hurt_02", "targetname" );
    var_10.triggerkillvehiclesheli = getent( "vehicle_kill_heli", "targetname" );
    var_10.triggerkillvehicleshelioffset = ( 525, 36, 635 );
    var_10.triggerkillvehiclesheli.origin += ( 0, 0, -10000 );
    var_10.triggerkillvehiclesbuilding = getent( "vehicle_kill_building", "targetname" );
    var_10.triggerkillvehiclesbuildingoffset = var_10.triggerkillvehiclesbuilding.origin - var_10.origin;
    var_10.triggerkillvehiclesbuilding.origin += ( 0, 0, -10000 );

    foreach ( var_13 in var_10.parts )
    {
        if ( var_13.classname == "info_null_meter" )
            continue;
        else if ( isdefined( var_13.script_noteworthy ) && var_13.script_noteworthy == "trigger_origin_01" )
            var_10.triggerlowerorigin = var_13;
        else if ( isdefined( var_13.script_noteworthy ) && var_13.script_noteworthy == "trigger_origin_02" )
            var_10.triggerupperorigin = var_13;

        var_13 vehicle_jetbikesethoverforcescale( var_10 );
    }

    var_10.dynamicpathblock = getent( "flying_building_paths_unblock", "targetname" );
    var_10.dynamicpathrampswitch = getent( "flying_building_path_ramp_switch", "targetname" );
    var_10.dynamicpathblock vehicle_jetbikesethoverforcescale( var_10 );
    var_10.og_spawn = ( 15959.8, -24712.9, 5209.89 );
    var_10.og_heli_spawn = ( 15940.7, -24711.6, 5888.01 );
    var_10.origin = var_10.og_spawn;
    wait 0.05;
    var_10.triggerhurtlower.origin = var_10.triggerlowerorigin.origin;
    var_10.triggerhurtlower.angles = var_10.triggerlowerorigin.angles;
    var_10.triggerhurtupper.origin = var_10.triggerupperorigin.origin;
    var_10.triggerhurtupper.angles = var_10.triggerupperorigin.angles;
    opendynamicbuildingplatformpath( var_10 );

    foreach ( var_13 in var_10.parts )
    {
        if ( var_13.classname == "info_null_meter" )
            continue;

        var_13 hide();
    }

    var_10 hide();
    level.flyingbuildingent = var_10;
    level thread maps\mp\_dynamic_events::dynamicevent( ::dynamiceventstartfunc, undefined, ::dynamiceventendfunc );
}

opendynamicbuildingplatformpath( var_0 )
{
    var_0.dynamicpathrampswitch.origin += ( 0, 0, -10000 );
    var_0.dynamicpathblock connectpaths();

    foreach ( var_2 in var_0.parts )
    {
        if ( isdefined( var_2.script_noteworthy ) )
        {
            if ( var_2.script_noteworthy == "flying_building_collision_shell" || var_2.script_noteworthy == "collision" || var_2.script_noteworthy == "building_brush_geo" )
            {
                var_2 connectpaths();

                if ( var_2.script_noteworthy == "flying_building_collision_shell" )
                    var_2 setaisightlinevisible( 0 );
            }
        }
    }

    if ( level.gametype == "dom" )
    {
        wait 0.05;
        maps\mp\gametypes\dom::flagsetup();
    }
}

dynamiceventstartfunc()
{
    if ( isdefined( level.flyingbuildingent ) && !isdefined( level.ishorde ) )
        level.flyingbuildingent moveflyingbuilding();
}

dynamiceventendfunc()
{
    var_0 = getentarray( "ground_shadow_patch_before", "targetname" );
    var_1 = getentarray( "ground_shadow_patch_after", "targetname" );
    var_1[0] show();
    var_0[0] hide();

    if ( isdefined( level.flyingbuildingent ) )
    {
        level.flyingbuildingent.dynamicpathblock unlink();
        level.flyingbuildingent.dynamicpathblock.origin += ( 0, 0, -10000 );
        level.flyingbuildingent dontinterpolate();
        level.flyingbuildingent.origin = level.flyingbuildingent.radiant_pos;
        wait 0.05;
        level.flyingbuildingent.triggerhurtlower dontinterpolate();
        level.flyingbuildingent.triggerhurtupper dontinterpolate();
        level.flyingbuildingent.triggerhurtlower.origin += ( 0, 0, -10000 );
        level.flyingbuildingent.triggerhurtupper.origin += ( 0, 0, -10000 );

        foreach ( var_3 in level.flyingbuildingent.parts )
        {
            var_3 unlink();
            var_3 show();
            var_3.unresolved_collision_kill = 0;

            if ( isdefined( var_3.script_noteworthy ) )
            {
                if ( var_3.script_noteworthy == "flying_building_collision_shell" )
                {
                    var_3 disconnectpaths();
                    var_3 setaisightlinevisible( 1 );
                    continue;
                }

                if ( var_3.script_noteworthy == "collision" )
                    var_3 delete();
            }
        }

        level.flyingbuildingent.dynamicpathrampswitch connectpaths();
        level thread common_scripts\_exploder::activate_clientside_exploder( 100 );
    }

    if ( level.gametype == "dom" )
        dom_b_move();
}

getnetquantizedangle( var_0 )
{
    var_1 = var_0 / 360.0;
    var_2 = ( var_1 - floor( var_1 ) ) * 360.0;
    var_3 = var_2 - 360.0;

    if ( var_3 >= 0 )
        var_2 = var_3;

    var_4 = int( floor( var_2 * 4095 / 360 + 0.5 ) );
    var_0 = var_4 * 360 / 4095.0;
    return var_0;
}

dom_b_move()
{
    wait 0.05;
    var_0 = common_scripts\utility::getstruct( "dom_point_b_location", "targetname" );

    foreach ( var_2 in level.flags )
    {
        if ( var_2.script_label == "_b" )
        {
            var_2.origin = var_0.origin;
            var_2.useobj.visuals[0].origin = var_0.origin + ( 0, 0, 1.125 );
            var_2.useobj.visuals[0].baseorigin = var_0.origin + ( 0, 0, 1.125 );
            var_2.useobj.curorigin = var_0.origin + ( 0, 0, 1.125 );
            var_2.useobj.baseeffectpos = var_0.origin + ( 0, 0, 1.125 );
            var_2.useobj maps\mp\gametypes\dom::updatevisuals();

            if ( isdefined( var_2.useobj.objidallies ) )
                objective_position( var_2.useobj.objidallies, var_0.origin );

            if ( isdefined( var_2.useobj.objidaxis ) )
                objective_position( var_2.useobj.objidaxis, var_0.origin );

            var_3 = var_0.origin + ( 0, 0, 100 );

            foreach ( var_5 in level.teamnamelist )
            {
                var_6 = "objpoint_" + var_5 + "_" + var_2.useobj.entnum;
                var_7 = maps\mp\gametypes\_objpoints::getobjpointbyname( var_6 );
                var_7.x = var_3[0];
                var_7.y = var_3[1];
                var_7.z = var_3[2];
            }
        }
    }

    level notify( "dom_flags_moved" );
    maps\mp\gametypes\dom::flagsetup();
}

moveflyingbuilding()
{
    var_0 = level.labtemptuner1;
    var_1 = level.labtemptuner2;
    var_2 = level.labtemptuner3;
    self.heavy_lifter = spawn( "script_model", self.og_heli_spawn + ( var_2, var_1, var_0 ) );
    var_3 = getnetquantizedangle( 36.078 );
    self.heavy_lifter.angles = ( 0, 36.044, 0 );
    self.heavy_lifter setmodel( "vehicle_heavy_lift_helicopter_01" );
    self.harness = spawn( "script_model", self.heavy_lifter gettagorigin( "tag_crane" ) );
    self.harness.angles = self.heavy_lifter gettagangles( "tag_crane" ) + ( 0, 0, 0 );
    self.harness setmodel( "heavy_lift_wires" );
    self.building_bone = spawn( "script_model", self.og_spawn + ( 0, 0, var_0 ) );
    self.building_bone.angles = self.harness gettagangles( "tag_cargo" ) + ( 0, 180, 0 );
    self.building_bone setmodel( "tag_origin_animate" );
    self.flying = 1;
    wait 0.05;
    self.triggerkillvehiclesheli thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();
    self.triggerkillvehiclesbuilding thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();
    thread killwarbirds( self.triggerkillvehiclesbuilding );
    thread killwarbirds( self.triggerkillvehiclesheli );

    foreach ( var_5 in self.parts )
        var_5 show();

    wait 0.05;

    foreach ( var_8 in self.parts )
        var_8.unresolved_collision_kill = 1;

    self.origin = self.og_spawn + ( 0, 0, var_0 );
    self.angles = self.harness gettagangles( "tag_cargo" ) + ( 0, 180, 0 );
    self vehicle_jetbikesethoverforcescale( self.harness, "tag_cargo" );
    wait 0.05;
    self.heavy_lifter scriptmodelplayanimdeltamotion( "lab2_dynamic_event_helicopter_anim", "building_unlink_notify" );
    self.harness scriptmodelplayanimdeltamotion( "lab2_dynamic_event_harness_anim" );
    self.heavy_lifter thread aud_transport_chopper();
    thread movebuildingdeathtriggers();
    self.heavy_lifter thread maps\mp\mp_lab2_fx::startheavylifterfx();
    self.heavy_lifter waittillmatch( "building_unlink_notify", "vfx_heligroundfx_start" );
    self.heavy_lifter thread maps\mp\mp_lab2_fx::startheligroundfx();
    self.heavy_lifter waittillmatch( "building_unlink_notify", "vfx_crane_sparks_start" );
    playfxontag( common_scripts\utility::getfx( "crane_sparks" ), self.heavy_lifter, "TAG_CRANE" );
    self.heavy_lifter waittillmatch( "building_unlink_notify", "helicopter_descend" );
    var_10 = [];

    foreach ( var_5 in self.parts )
    {
        if ( isdefined( var_5.script_noteworthy ) && var_5.script_noteworthy == "collision" )
        {
            var_5 unlink();
            var_5 delete();
            continue;
        }

        var_10[var_10.size] = var_5;
    }

    self.parts = var_10;
    self.dynamicpathblock unlink();
    self.dynamicpathblock delete();
    self.heavy_lifter thread aud_building_pre_drop();
    self.heavy_lifter waittillmatch( "building_unlink_notify", "vfx_crane_sparks_stop" );
    stopfxontag( common_scripts\utility::getfx( "crane_sparks" ), self.heavy_lifter, "TAG_CRANE" );
    self.heavy_lifter waittillmatch( "building_unlink_notify", "vfx_building_land" );
    common_scripts\_exploder::activate_clientside_exploder( 99 );
    self.heavy_lifter waittillmatch( "building_unlink_notify", "drop_building" );
    self.harness thread maps\mp\mp_lab2_fx::clampreleasefx();
    self.heavy_lifter thread aud_building_drop();
    var_13 = getentarray( "ground_shadow_patch_before", "targetname" );
    var_14 = getentarray( "ground_shadow_patch_after", "targetname" );
    var_14[0] show();
    var_13[0] hide();
    self unlink();
    self.flying = 0;

    foreach ( var_5 in self.parts )
    {
        if ( isdefined( var_5 ) )
        {
            var_5 unlink();
            var_5.unresolved_collision_kill = 0;

            if ( isdefined( var_5.script_noteworthy ) )
            {
                if ( var_5.script_noteworthy == "flying_building_collision_shell" )
                {
                    var_5 disconnectpaths();
                    var_5 setaisightlinevisible( 1 );
                }
            }
        }
    }

    self.dynamicpathrampswitch connectpaths();

    if ( level.gametype == "dom" )
        dom_b_move();

    common_scripts\_exploder::activate_clientside_exploder( 100 );
    self.heavy_lifter waittillmatch( "building_unlink_notify", "vfx_heligroundfx_stop" );
    self.heavy_lifter thread maps\mp\mp_lab2_fx::stopheligroundfx();
    self.heavy_lifter waittillmatch( "building_unlink_notify", "helicopter_end" );
    self.heavy_lifter delete();
    self.harness delete();
}

killwarbirds( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        while ( self.flying == 1 )
        {
            if ( isdefined( level.spawnedwarbirds ) )
            {
                foreach ( var_2 in level.spawnedwarbirds )
                {
                    if ( isdefined( var_2 ) )
                    {
                        if ( var_2 istouching( var_0 ) )
                            var_2 thread maps\mp\killstreaks\_aerial_utility::heli_explode( 1 );
                    }
                }
            }

            wait 0.05;
        }
    }
}

movebuildingdeathtriggers()
{
    while ( self.flying == 1 )
    {
        self.triggerhurtlower.origin = self.triggerlowerorigin.origin;
        self.triggerhurtlower.angles = self.triggerlowerorigin.angles;
        self.triggerhurtupper.origin = self.triggerupperorigin.origin;
        self.triggerhurtupper.angles = self.triggerupperorigin.angles;
        var_0 = self.heavy_lifter gettagangles( "body_animate_jnt" );
        var_1 = 360 - var_0[0];
        var_2 = var_0[1] + 180;
        var_3 = 360 - var_0[2];
        self.triggerkillvehiclesheli.angles = ( var_1, var_2, var_3 );
        self.triggerkillvehiclesheli.origin = self.heavy_lifter.origin + self.triggerkillvehicleshelioffset;
        self.triggerkillvehiclesbuilding.origin = self.origin + self.triggerkillvehiclesbuildingoffset;
        self.triggerkillvehiclesbuilding.angles = self.angles;
        wait 0.05;
    }

    self.triggerhurtlower dontinterpolate();
    self.triggerhurtupper dontinterpolate();
    self.triggerkillvehiclesheli dontinterpolate();
    self.triggerkillvehiclesbuilding dontinterpolate();
    self.triggerhurtlower.origin += ( 0, 0, -10000 );
    self.triggerhurtupper.origin += ( 0, 0, -10000 );
    self.triggerkillvehiclesheli.origin += ( 0, 0, -10000 );
    self.triggerkillvehiclesbuilding.origin += ( 0, 0, -10000 );
}

labpaladinoverrides()
{
    level.orbitalsupportoverrides.spawnanglemin = 70;
    level.orbitalsupportoverrides.spawnanglemax = 150;
    level.orbitalsupportoverrides.spawnheight = 7500;
    level.orbitalsupportoverrides.spawnradius = 5000;
    level.orbitalsupportoverrides.leftarc = 30;
    level.orbitalsupportoverrides.rightarc = 30;
    level.orbitalsupportoverrides.toparc = -42;
    level.orbitalsupportoverrides.bottomarc = 67;
}

lab2customlaserstreakfunc()
{
    var_0 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
    level.orbitallaseroverrides.spawnheight = var_0.origin[2] + 2724;
}

lab2customairstrike()
{
    if ( !isdefined( level.airstrikeoverrides ) )
        level.airstrikeoverrides = spawnstruct();

    level.airstrikeoverrides.spawnheight = 1700;
}

lab2botkilltrigger()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( -584, 1728, 176 ), 0, 300, 128 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isbot( var_1 ) || isagent( var_1 ) )
            var_1 dodamage( var_1.health + 999, var_0.origin );
    }
}

lab2playerkilltrigger()
{
    level endon( "game_ended" );
    var_0 = spawn( "trigger_radius", ( -566, 1636, 220 ), 0, 64, 64 );

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        var_1 dodamage( var_1.health + 999, var_0.origin );
    }
}

onplayerconnectfucntions()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0.gastime = 0;
        var_0 thread creategastrackingoverlay();
    }
}

set_lighting_values()
{
    if ( isusinghdr() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}

rotatemeshes( var_0 )
{
    for (;;)
    {
        self rotateyaw( 360, var_0 );
        wait(var_0);
    }
}

setupcranechem()
{
    level.alarmsystem = spawnstruct();
    level.alarmsystem.spinnerarray = getentarray( "horizontal_spinner", "targetname" );
    level.alarmsystem.alarmsoundent = getent( "alarm_missile_sound01", "targetname" );
    level.gasmachine = spawnstruct();
    level.gasmachine.totalspawned = [];
    level.gasmachine.cranecollisiontotal = [];
    level.gasmachine.cranechemcollisiontotal = [];
    level.gasmachine.explosionoffset = 72;
    level.gasmachine.explosionangleoffset = ( -90, 0, 0 );
    level.gasmachine.machinesparkarray = getentarray( "sparkgroup", "targetname" );
    level.gasmachine.sprayerdriparray = getentarray( "dripgroup", "targetname" );
    level.gasmachine.partciledrylocation = common_scripts\utility::getstruct( "particle_dryer", "targetname" );
    level.gasmachine.chemical_rackpausetime = 0;
    level.gasmachine.chemical_racksactive = 1;
    level.gasmachine.chemical_rackgotosarray = common_scripts\utility::getstructarray( "missile_rack_start01", "targetname" );
    level.gasmachine.damageradius = 375;
    level.gasmachine.maxdamageamount = 300;
    level.gasmachine.mindamageamount = 75;
    level.gasmachine.spraysheetstate = 1;
    level.gasmachine.totalchemcanhealth = 100;
    level.gasmachine.particlespawnoriginoffset = ( 0, 0, 0 );
    level.gasmachine.dryerfan = getent( "dryer_fan", "targetname" );
    level.gasmachine.dryerfanrotatevelocity = ( 0, 1400, 0 );
    level.gasmachine.gasrange = 170;
    var_0 = level.gasmachine.chemical_rackgotosarray[0];

    for (;;)
    {
        if ( isdefined( var_0.target ) )
        {
            var_1 = common_scripts\utility::getstruct( var_0.target, "targetname" );
            level.gasmachine.chemical_rackgotosarray = common_scripts\utility::add_to_array( level.gasmachine.chemical_rackgotosarray, var_1 );
            var_0 = var_1;
            continue;
        }
        else
            break;

        wait 0.05;
    }

    level.gasmachine.cranecollisiontotal = getentarray( "crane_collision01", "targetname" );
    level.gasmachine.cranecollision = level.gasmachine.cranecollisiontotal;

    foreach ( var_3 in level.gasmachine.cranecollisiontotal )
        var_3.unresolved_collision_kill = 1;

    level.gasmachine.cranechemcollisiontotal = getentarray( "rack_collision01", "targetname" );
    level.gasmachine.cranechemcollision = level.gasmachine.cranechemcollisiontotal;

    foreach ( var_3 in level.gasmachine.cranechemcollisiontotal )
        var_3.unresolved_collision_kill = 1;

    cranethink( level.gasmachine.chemical_rackgotosarray );
}

addtototalspawned()
{
    level.gasmachine.totalspawned = common_scripts\utility::add_to_array( level.gasmachine.totalspawned, self );
}

removefromtotalspawned()
{
    wait 0.05;
    level.gasmachine.totalspawned = common_scripts\utility::array_removeundefined( level.gasmachine.totalspawned );
}

cranethink( var_0 )
{
    var_1 = 5;
    var_2 = 5;

    for (;;)
    {
        if ( level.gasmachine.chemical_racksactive == 1 )
        {
            if ( level.gasmachine.cranecollision.size > 0 )
            {
                var_3 = randomint( 100 );

                if ( var_3 > 40 )
                {
                    var_4 = spawncrane( var_0, 1 );

                    if ( isdefined( var_4 ) )
                        var_4 thread startnotelisten( var_2, var_1 );
                }
            }

            wait(var_1 + var_2 + randomfloatrange( 3.0, 7.0 ));
            continue;
        }

        wait 1;
    }
}

startnotelisten( var_0, var_1 )
{
    thread watchcranenotetrack( var_0, var_1 );
}

watchcranenotetrack( var_0, var_1 )
{
    self endon( "death" );
    self endon( "deleted" );

    for (;;)
    {
        self waittill( "crane_note_track", var_2 );

        if ( var_2 == "crane_move_start" )
        {
            if ( level.gasmachine.chemical_racksactive == 0 )
            {
                if ( isdefined( self ) && self.paused == 0 )
                {
                    self scriptmodelpauseanim( 1 );
                    self.paused = 1;
                    checkforunpause();
                }
            }
            else
            {
                thread maps\mp\_audio::snd_play_linked( "emt_conveyor_belt_gears", self );
                thread maps\mp\_audio::snd_play_linked( "emt_conveyor_belt_sparks", self );
                playfxontag( level.missileparticles.cranesparks, self, "TAG_ORIGIN" );
            }

            continue;
        }

        if ( var_2 == "crane_move_stop" )
        {
            thread stopcranesound();
            stopfxontag( level.missileparticles.cranesparks, self, "TAG_ORIGIN" );
            continue;
        }

        if ( var_2 == "crane_wiggle_stop" )
            continue;

        if ( var_2 == "crane_particle_01" || var_2 == "crane_particle_02" || var_2 == "crane_particle_03" )
        {
            thread spraycans( var_0, var_2 );
            continue;
        }

        if ( var_2 == "rotate_start" )
        {
            thread rotatethink( var_0 );
            continue;
        }

        if ( var_2 == "rotate_stop" )
        {
            thread stopcranesound();
            continue;
        }

        if ( var_2 == "crane_finish" )
            thread removerack();
    }
}

checkforunpause()
{
    self endon( "death" );
    self endon( "deleted" );

    for (;;)
    {
        if ( isdefined( self ) )
        {
            if ( level.gasmachine.chemical_racksactive == 1 )
            {
                if ( self.paused == 1 )
                {
                    self scriptmodelpauseanim( 0 );
                    self.paused = 0;
                    thread maps\mp\_audio::snd_play_linked( "emt_conveyor_belt_gears", self );
                    thread maps\mp\_audio::snd_play_linked( "emt_conveyor_belt_sparks", self );
                    playfxontag( level.missileparticles.cranesparks, self, "TAG_ORIGIN" );
                    break;
                }
            }
        }
        else
            break;

        wait 0.5;
    }
}

setuprobotarmnotetracks()
{
    var_0 = getentarray( "lab2_robot_arm", "targetname" );

    foreach ( var_2 in var_0 )
    {
        wait(randomfloatrange( 0.0, 1 ));
        var_2 scriptmodelplayanimdeltamotion( "lab2_robot_arm_01_idle_anim", "emt_servo_sparks" );
        var_2 thread watchrobotarmnotetrack();
    }
}

watchrobotarmnotetrack()
{
    self endon( "death" );
    self endon( "deleted" );

    for (;;)
    {
        self waittill( "emt_servo_sparks", var_0 );

        if ( isdefined( var_0 ) && var_0 == "robot_arm_sparks_on" )
        {
            playfxontag( common_scripts\utility::getfx( "welding_sparks" ), self, "wristSwivel" );
            continue;
        }

        if ( isdefined( var_0 ) && var_0 == "emt_servo_sparks" )
            thread maps\mp\_audio::snd_play_linked( "emt_servo_sparks", self );
    }
}

stopcranesound()
{
    self stopsounds();
    wait 0.05;
    thread maps\mp\_audio::snd_play_linked( "mp_lab_missilerack_stop01", self );
}

rotatethink( var_0 )
{
    if ( self.has_chemicals == 1 )
    {
        if ( level.gasmachine.chemical_racksactive == 1 )
        {
            thread maps\mp\_audio::snd_play_in_space( "emt_air_blast_turn", level.gasmachine.partciledrylocation.origin );
            thread maps\mp\_audio::snd_play_in_space( "emt_air_blast_clean", level.gasmachine.partciledrylocation.origin );
            level.gasmachine.partciledrylocation thread particlespray( level.missileparticles.drymachine, level.gasmachine.partciledrylocation.angles, 3 );
            thread startcanisterfx( level.missileparticles.canistersteam, var_0 );
            thread rotatedryerfan();
        }
    }
}

rotatedryerfan()
{
    level.gasmachine.dryerfan rotatevelocity( level.gasmachine.dryerfanrotatevelocity, 7, 1, 5 );
}

spraycans( var_0, var_1 )
{
    if ( self.has_chemicals == 1 )
    {
        if ( level.gasmachine.chemical_racksactive == 1 )
        {
            thread particlespraymultiplenode( var_1, var_0 );
            thread startcanisterfx( level.missileparticles.canisterdrips, var_0 );
        }
    }
}

spawncrane( var_0, var_1 )
{
    var_2 = -210;
    var_3 = spawn( "script_model", var_0[0].origin + ( 0, 0, var_2 ) );
    var_3 playcranespawnvfx();
    var_4 = getcollision( level.gasmachine.cranecollision );

    if ( isdefined( var_4 ) && isdefined( var_4.collision ) )
    {
        var_3 setmodel( "lab2_industrial_crane_01" );
        var_3.paused = 0;
        var_3.cranecollision = var_4.collision;
        level.gasmachine.cranecollision = var_4.pool;
        var_3.cranecollision.origin = var_3.origin;
        var_3.cranecollision.angles = var_3.angles;
        var_3.cranecollision vehicle_jetbikesethoverforcescale( var_3 );
        var_3 solid();
    }
    else
    {
        if ( isdefined( var_3 ) )
            var_3 delete();

        return undefined;
    }

    var_3 addtototalspawned();
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "lab_crane_arm_01_lights" ), var_3, "TAG_ORIGIN" );
    playfxontag( level.missileparticles.cranesparks, var_3, "TAG_ORIGIN" );

    if ( var_1 == 1 )
    {
        var_4 = getcollision( level.gasmachine.cranechemcollision );

        if ( isdefined( var_4 ) && isdefined( var_4.collision ) )
        {
            var_3.chemical_rack = spawn( "script_model", var_3 gettagorigin( "tag_cargo" ) );
            var_3.exploding = 0;
            var_3.chemical_rack setmodel( "lab2_cannister_holder_01" );
            var_3.chemical_rack linkto( var_3, "tag_cargo" );
            var_3.chemical_rack addtototalspawned();
            var_3.has_chemicals = 1;
            var_3.chemical_rack solid();
            thread playorangegoo( var_3.chemical_rack );
            var_3.chemical_rack.damageradius = level.gasmachine.damageradius;
            var_3.chemical_rack.maxdamageamount = level.gasmachine.maxdamageamount;
            var_3.chemical_rack.mindamageamount = level.gasmachine.mindamageamount;
            var_3.chemical_rack thread watchdamagechemical( var_3 );
            var_3.chemical_rack.cranechemcollision = var_4.collision;
            level.gasmachine.cranechemcollision = var_4.pool;
            var_3.chemical_rack.cranechemcollision thread common_scripts\utility::entity_path_disconnect_thread( 1 );
            var_3.chemical_rack.cranechemcollision.origin = var_3.chemical_rack.origin;
            var_3.chemical_rack.cranechemcollision.angles = var_3.chemical_rack.angles;
            var_3.chemical_rack.cranechemcollision vehicle_jetbikesethoverforcescale( var_3.chemical_rack );
        }
        else
            var_3.has_chemicals = 0;
    }
    else
        var_3.has_chemicals = 0;

    var_3 scriptmodelplayanimdeltamotion( "lab2_industrial_crane_anim", "crane_note_track" );
    return var_3;
}

playorangegoo( var_0 )
{
    var_1 = 3;

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        wait 0.05;

        if ( isdefined( var_0 ) && !isremovedentity( var_0 ) )
        {
            var_0 show();

            if ( var_2 == 2 )
            {
                var_3 = playfxontag( common_scripts\utility::getfx( "lab_canister_liquid_orange" ), var_0, "tag_origin" );
                var_0 show();
            }

            continue;
        }

        return;
    }
}

playcranespawnvfx()
{
    var_0 = 0.05;
    var_1 = level.gasmachine.particlespawnoriginoffset;
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    var_2 = self.origin + var_1;
    wait(var_0);
    return;
}

getcollision( var_0 )
{
    if ( var_0.size > 0 )
    {
        var_1 = spawnstruct();
        var_1.collision = var_0[var_0.size - 1];
        var_0 = common_scripts\utility::array_remove( var_0, var_1.collision );
        var_0 = common_scripts\utility::array_remove_duplicates( var_0 );
        var_1.pool = var_0;
        return var_1;
    }
    else
        return;
}

addcollisiontopool( var_0 )
{
    self notify( "entity_path_disconnect_thread" );
    self unlink();
    self.origin = ( 0, 0, -5000 );
    var_0 = common_scripts\utility::add_to_array( var_0, self );
    return var_0;
}

watchdamagechemical( var_0 )
{
    self endon( "deleted" );
    self endon( "death" );
    self.health = 10000000;
    self.fakehealth = level.gasmachine.totalchemcanhealth;
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    self.leaking = 0;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

            if ( isdefined( var_10 ) )
            {
                var_11 = maps\mp\_utility::strip_suffix( var_10, "_lefthand" );

                switch ( var_11 )
                {
                    case "paint_grenade_mp":
                    case "mp_lab_gas_explosion":
                    case "smoke_grenade_mp":
                    case "flash_grenade_mp":
                    case "concussion_grenade_mp":
                    case "mp_lab_gas":
                        continue;
                }

                if ( issubstr( var_10, "m990" ) )
                {
                    if ( var_5 == "MOD_PISTOL_BULLET" )
                        var_1 = 50;
                    else if ( var_5 == "MOD_EXPLOSIVE" )
                        var_1 = 100;
                }
            }

            if ( isdefined( var_5 ) )
            {
                if ( maps\mp\_utility::ismeleemod( var_5 ) || var_5 == "MOD_TRIGGER_HURT" )
                    continue;
            }

            if ( isdefined( var_2 ) )
                var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback( "standard" );

            if ( var_0.exploding == 0 )
            {
                self.fakehealth += var_1 * -1;

                if ( self.fakehealth <= 0 )
                {
                    thread pauseracksystem();
                    thread blowitup( var_0, var_2 );
                    level notify( "Chemical_Exploded" );
                    break;
                }
            }
            else if ( var_0.exploding == 1 )
                break;
        }
        else if ( !isdefined( self ) )
            break;
    }
}

timebomb( var_0 )
{
    self endon( "deleted" );
    self endon( "death" );
    thread timebombparticle( level.missileparticles.sparkgreenloop );
    var_1 = level.gasmachine.totalchemcanhealth * 0.05;
    var_1 = int( var_1 );

    while ( isdefined( self ) )
    {
        wait 1;
        self notify( "damage", var_1, var_0 );
    }
}

timebombparticle( var_0 )
{
    thread common_scripts\utility::play_loop_sound_on_entity( "mp_lab_gas_leak_loop01", ( 0, 0, 64 ) );
    playfxontag( var_0, self, "tag_origin" );
}

blowitup( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = 0.1;
    var_0.exploding = 1;
    var_3 = self.origin;

    if ( isdefined( self ) && !isremovedentity( self ) )
    {
        if ( isdefined( self.cranechemcollision ) )
        {
            self notify( "entity_path_disconnect_thread" );
            self.cranechemcollision connectpaths();
        }
    }

    var_4 = level.gasmachine.explosionoffset;
    var_5 = level.gasmachine.explosionangleoffset;
    var_6 = thread common_scripts\utility::spawn_tag_origin();
    var_6 show();
    var_6 dontinterpolate();
    var_6.origin = var_0.origin + ( 0, 0, var_4 );
    var_6.angles = var_5;
    var_6 vehicle_jetbikesethoverforcescale( var_0, "tag_origin" );
    playfxontag( level.missileparticles.missileexplosion, var_6, "tag_origin" );
    var_6 thread deleteexplosiontag( var_0, self, 0.05 );
    var_7 = var_0.origin + ( 0, 0, var_4 );
    thread aud_play_tank_explosion( var_7 );
    wait 0.05;

    if ( isdefined( self ) && !isremovedentity( self ) )
    {
        if ( isdefined( self.cranechemcollision ) )
            level.gasmachine.cranechemcollision = self.cranechemcollision addcollisiontopool( level.gasmachine.cranechemcollision );

        killfxontag( common_scripts\utility::getfx( "lab_canister_liquid_orange" ), self, "tag_origin" );
        maps\mp\_utility::delaythread( var_2, ::unlinkanddelete );
    }

    if ( isdefined( var_0 ) && !isremovedentity( var_0 ) )
        var_0.has_chemicals = 0;

    wait(var_2 + 0.05);
    thread missileexplosion( var_1, var_3 );
    thread missilechem( level.missileparticles.greensmokeloop, var_3 + ( 0, 0, -70 ), var_1 );
}

deleteexplosiontag( var_0, var_1, var_2 )
{
    var_1 common_scripts\utility::waittill_any( "death", "deleted" );
    wait(var_2);

    if ( isdefined( self ) && !isremovedentity( self ) )
        self delete();
}

killchemrackvfx()
{
    self endon( "death" );
    wait 0.05;

    if ( isdefined( self ) && !isremovedentity( self ) )
    {
        killfxontag( common_scripts\utility::getfx( "lab_canister_liquid_orange" ), self, "tag_origin" );
        wait 0.05;

        if ( isdefined( self ) && !isremovedentity( self ) )
            self delete();
    }
}

unlinkanddelete()
{
    if ( isdefined( self ) && !isremovedentity( self ) )
    {
        self unlink();
        self delete();
    }
}

missileexplosion( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        radiusdamage( var_1 + ( 0, 0, -44 ), level.gasmachine.damageradius, level.gasmachine.maxdamageamount, level.gasmachine.mindamageamount, var_0, "MOD_EXPLOSIVE", "mp_lab_gas_explosion" );
    else
        radiusdamage( var_1 + ( 0, 0, -44 ), level.gasmachine.damageradius, level.gasmachine.maxdamageamount, level.gasmachine.mindamageamount, undefined, "MOD_EXPLOSIVE", "mp_lab_gas_explosion" );
}

missilechem( var_0, var_1, var_2 )
{
    level.gasparticletime = level.pausetime * 0.15;
    var_3 = spawnfx( var_0, var_1 + ( 0, 0, 0 ) );
    var_4 = spawn( "script_origin", var_1 );
    thread chemdamagethink( var_4, var_1, var_2 );
    wait(level.gasparticletime);
    wait 5;
    var_4 notify( "Gas_Particle_Gone" );
    wait 1;
    var_4 deletedefined();
    var_3 deletedefined();
}

deletedefined()
{
    if ( isdefined( self ) )
        self delete();
}

chemdamagethink( var_0, var_1, var_2 )
{
    var_0 endon( "Gas_Particle_Gone" );

    for (;;)
    {
        if ( isdefined( var_2 ) )
            var_2 radiusdamage( var_1, level.gasmachine.gasrange, 10, 10, var_2, "MOD_TRIGGER_HURT", "mp_lab_gas" );
        else
            radiusdamage( var_1, level.gasmachine.gasrange, 10, 10, undefined, "MOD_TRIGGER_HURT", "mp_lab_gas" );

        thread findshockvictims( var_1 );
        wait 1;
    }
}

findshockvictims( var_0 )
{
    var_1 = level.gasmachine.gasrange * level.gasmachine.gasrange;

    foreach ( var_3 in level.players )
    {
        if ( !var_3 maps\mp\_utility::isusingremote() )
        {
            var_4 = distancesquared( var_3.origin, var_0 );

            if ( var_4 < var_1 && !var_3 maps\mp\_utility::_hasperk( "specialty_stun_resistance" ) )
                var_3 thread shockthink();
        }
    }
}

shockthink()
{
    if ( self.gastime <= 0 )
    {
        thread fadeinoutgastrackingoverlay();
        thread rempveoverlaydeath();
    }

    self.gastime = 2;
    self shellshock( "mp_lab_gas", 1 );

    while ( self.gastime > 0 )
    {
        self.gastime--;
        wait 1;
    }

    self notify( "gas_end" );
    endgastrackingoverlay();
}

rempveoverlaydeath()
{
    self endon( "gas_end" );
    self waittill( "death" );
    thread endgastrackingoverlaydeath();
}

particlespraymultiplenode( var_0, var_1 )
{
    foreach ( var_3 in level.gasmachine.machinesparkarray )
    {
        if ( var_3.script_noteworthy == var_0 )
        {
            self playsound( "emt_water_spray_hard" );
            var_3 thread particlespray( level.missileparticles.spraymachine, var_3.angles, var_1 );
        }
    }

    foreach ( var_3 in level.gasmachine.sprayerdriparray )
    {
        if ( var_3.script_noteworthy == var_0 )
            var_3 thread sprayerdrip( level.missileparticles.spraymachinedrips, var_3.angles, var_1 );
    }
}

startcanisterfx( var_0, var_1 )
{
    wait(var_1);
    var_2 = 0;
    var_3 = 0.1;

    while ( var_2 < 4.25 )
    {
        if ( isdefined( self ) && self.has_chemicals == 1 )
        {
            var_4 = self.origin + ( 0, 0, -8 );
            var_5 = self.angles + ( 270, 0, 0 );
            playfx( var_0, var_4, anglestoforward( var_5 ), anglestoup( var_5 ) );
            wait(var_3);
            var_2 += var_3;
            continue;
        }

        return;
    }
}

particlespray( var_0, var_1, var_2 )
{
    var_3 = spawnfx( var_0, self.origin, anglestoforward( var_1 ), anglestoup( var_1 ) );
    triggerfx( var_3 );

    if ( isdefined( var_2 ) )
        wait(var_2);

    if ( isdefined( var_3 ) )
        var_3 delete();
}

sprayerdrip( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        wait(var_2);

    playfx( var_0, self.origin, anglestoforward( var_1 ), anglestoup( var_1 ) );
}

removerack()
{
    if ( isdefined( self ) && !isremovedentity( self ) )
    {
        if ( isdefined( self.chemical_rack ) && !isremovedentity( self.chemical_rack ) )
            killfxontag( common_scripts\utility::getfx( "lab_canister_liquid_orange" ), self.chemical_rack, "tag_origin" );

        wait 0.05;

        if ( isdefined( self ) && !isremovedentity( self ) )
        {
            if ( isdefined( self.chemical_rack ) && !isremovedentity( self.chemical_rack ) )
            {
                if ( isdefined( self.chemical_rack.cranechemcollision ) )
                    level.gasmachine.cranechemcollision = self.chemical_rack.cranechemcollision addcollisiontopool( level.gasmachine.cranechemcollision );

                self.chemical_rack unlink();
                self.chemical_rack delete();
            }

            level.gasmachine.cranecollision = self.cranecollision addcollisiontopool( level.gasmachine.cranecollision );
            self notify( "deleted" );
            self delete();
        }
    }

    thread removefromtotalspawned();
}

pauseracksystem()
{
    if ( !isdefined( level.pausetime ) )
        level.pausetime = 20;

    level.gasmachine.chemical_rackpausetime = level.pausetime;

    if ( level.gasmachine.chemical_racksactive == 1 )
        common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstart );

    if ( level.gasmachine.chemical_racksactive == 1 )
        thread playalarmloop();
    else
        return;

    for ( level.gasmachine.chemical_racksactive = 0; level.gasmachine.chemical_rackpausetime > 0; level.gasmachine.chemical_rackpausetime-- )
        wait 1;

    common_scripts\utility::array_thread( level.alarmsystem.spinnerarray, ::spinalarmsstop );
    level.gasmachine.chemical_racksactive = 1;
    level notify( "Restarting_System" );
}

spinalarmsstart()
{
    self hide();
    level thread common_scripts\_exploder::activate_clientside_exploder( 200 );
}

spinalarmsstop()
{
    self show();
    stopclientexploder( 200 );
}

playalarmloop()
{
    var_0 = spawn( "script_origin", level.alarmsystem.alarmsoundent.origin );
    var_0 playloopsound( "mp_lab_alarm_shutdown01" );
    wait 5;
    var_0 stopsounds();
    wait 0.05;
    var_0 delete();
}

creategastrackingoverlay()
{
    if ( !isdefined( self.gastrackingoverlay ) )
    {
        self.gastrackingoverlay = newclienthudelem( self );
        self.gastrackingoverlay.x = 0;
        self.gastrackingoverlay.y = 0;
        self.gastrackingoverlay setshader( "lab_gas_overlay", 640, 480 );
        self.gastrackingoverlay.alignx = "left";
        self.gastrackingoverlay.aligny = "top";
        self.gastrackingoverlay.horzalign = "fullscreen";
        self.gastrackingoverlay.vertalign = "fullscreen";
        self.gastrackingoverlay.alpha = 0;
    }
}

fadeinoutgastrackingoverlay()
{
    level endon( "game_ended" );
    self endon( "gas_end" );
    self endon( "death" );

    if ( isdefined( self.gastrackingoverlay ) )
    {
        for (;;)
        {
            self.gastrackingoverlay fadeovertime( 0.4 );
            self.gastrackingoverlay.alpha = 1;
            wait 0.5;
            self.gastrackingoverlay fadeovertime( 0.4 );
            self.gastrackingoverlay.alpha = 0.5;
            wait 0.5;
        }
    }
}

endgastrackingoverlay()
{
    if ( isdefined( self.gastrackingoverlay ) )
    {
        self.gastrackingoverlay fadeovertime( 0.2 );
        self.gastrackingoverlay.alpha = 0.0;
    }
}

endgastrackingoverlaydeath()
{
    if ( isdefined( self.gastrackingoverlay ) )
        self.gastrackingoverlay.alpha = 0.0;
}

setup_audio()
{

}

aud_play_tank_explosion( var_0 )
{
    thread maps\mp\_audio::snd_play_in_space( "lab2_tank_exp", var_0 );
}

aud_transport_chopper()
{
    var_0 = self;
    var_1 = "veh_drone_heavy_lifter_lp";
    thread maps\mp\_audio::snd_play_linked_loop( var_1, var_0 );
    var_0 thread aud_warning_vo();
}

aud_warning_vo()
{
    wait 32;
    thread maps\mp\_audio::snd_play_linked( "vo_heli_warn_ext", self );
    wait 6.5;
    thread maps\mp\_audio::snd_play_linked( "vo_heli_warn_ext", self );
}

aud_building_pre_drop()
{
    thread maps\mp\_audio::snd_play_linked( "lab2_building_sway", self );
}

aud_building_drop()
{
    thread maps\mp\_audio::snd_play_linked( "lab2_building_drop", self );
}
