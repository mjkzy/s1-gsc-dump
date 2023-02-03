// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\mp\mp_levity_precache::main();
    maps\createart\mp_levity_art::main();
    maps\mp\mp_levity_fx::main();
    maps\mp\_load::main();
    thread set_lighting_values();
    maps\mp\mp_levity_lighting::main();
    thread maps\mp\mp_levity_aud::main();
    level.aerial_pathnode_offset = 600;
    level.aerial_pathnodes_force_connect[0] = spawnstruct();
    level.aerial_pathnodes_force_connect[0].origin = ( -977, -1811, 2054 );
    level.aerial_pathnodes_force_connect[0].radius = 275;
    maps\mp\_compass::setupminimap( "compass_map_mp_levity" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    common_scripts\utility::array_thread( getentarray( "com_radar_dish", "targetname" ), ::radar_dish_rotate );
    level thread hanger_event();
    level thread init_fans();
    level thread init_antenna();
    level thread levitypatchclip();

    if ( level.nextgen )
    {
        level thread init_assembly_line();
        setdvar( "sm_polygonOffsetPreset", 2 );
    }
}

levitypatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 766, -3192, 1488.5 ), ( 352.5, 311.3, 0.110002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 963.5, -3033, 1488.5 ), ( 352.5, 306.4, 0.109992 ) );
}

init_assembly_line()
{
    var_0 = [ "mp_lev_drone_assembly_line_01", "mp_lev_drone_assembly_line_02", "mp_lev_drone_assembly_line_03", "mp_lev_drone_assembly_line_04", "mp_lev_drone_assembly_line_05", "mp_lev_drone_assembly_line_06", "mp_lev_drone_assembly_line_07" ];

    foreach ( var_2 in var_0 )
        precachempanim( var_2 );

    var_4 = common_scripts\utility::getstruct( "robot_arm_scripted_node", "targetname" );
    var_5 = getentarray( "assembly_line_drone", "targetname" );

    foreach ( var_8, var_7 in var_5 )
        var_7 thread run_assembly_line( var_4, var_0[var_8] );
}

run_assembly_line( var_0, var_1 )
{
    self endon( "death" );
    var_2 = "droneNT";
    self scriptmodelplayanimdeltamotionfrompos( var_1, var_0.origin, var_0.angles, var_2 );

    for (;;)
    {
        self waittill( var_2, var_3 );
        var_4 = self gettagorigin( "j_drone" );

        switch ( var_3 )
        {
            case "drone_sound_start":
                playsoundatpos( var_4, "drone_gear_start" );
                break;
            case "drone_sound_stop":
                playsoundatpos( var_4, "drone_gear_stop" );
                break;
            default:
                break;
        }
    }
}

init_fans()
{
    var_0 = "mp_lev_ind_thermanl_cell_fan_spin";
    precachempanim( var_0 );
    var_1 = getentarray( "levity_animated_fan", "targetname" );
    common_scripts\utility::array_thread( var_1, ::run_fan, var_0 );
}

run_fan( var_0 )
{
    self scriptmodelplayanimdeltamotion( var_0 );
}

init_antenna()
{
    var_0 = getentarray( "levity_antenna", "targetname" );
    common_scripts\utility::array_thread( var_0, ::radar_dish_rotate, 20 );
}

radar_dish_rotate( var_0 )
{
    var_1 = 40000;

    if ( !isdefined( var_0 ) )
        var_0 = 70;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "lockedspeed" )
        wait 0;
    else
        wait(randomfloatrange( 0, 1 ));

    for (;;)
    {
        self rotatevelocity( ( 0, var_0, 0 ), var_1 );
        wait(var_1);
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

hanger_event()
{
    level.event_ents = getentarray( "hanger_event", "targetname" );
    common_scripts\utility::array_thread( level.event_ents, ::hanger_floor_init );
    common_scripts\utility::array_thread( level.event_ents, ::hanger_ent_init );
    common_scripts\utility::array_thread( level.event_ents, ::hanger_event_idle_anims );
}

event_start()
{
    common_scripts\utility::array_thread( level.event_ents, ::hanger_floor_run );
    thread maps\mp\mp_levity_aud::event_aud();
}

event_reset()
{
    common_scripts\utility::array_thread( level.event_ents, ::hanger_ent_reset );
    common_scripts\utility::array_thread( level.event_ents, ::hanger_event_idle_anims );
    hanger_event_connect_nodes_drone();
    hanger_event_connect_nodes_floor();
}

hanger_ent_init()
{
    self.start_origin = self.origin;
    self.start_angles = self.angles;
}

hanger_ent_reset()
{
    if ( isdefined( self.event_animated ) && self.event_animated )
    {
        self scriptmodelclearanim();

        if ( isdefined( self.collision_prop ) )
            self.collision_prop scriptmodelclearanim();
    }

    self.origin = self.start_origin;
    self.angles = self.start_angles;
}

hanger_floor_init()
{
    var_0 = ( 60, 0, 0 );

    switch ( self.script_noteworthy )
    {
        case "hanger_door_left":
            self.origin -= var_0;
            self disconnectpaths();
            break;
        case "hanger_door_right":
            self.origin += var_0;
            self disconnectpaths();
            break;
        case "drone":
            if ( isdefined( self.target ) )
            {
                var_1 = getent( self.target, "targetname" );
                var_1.carepackagetouchvalid = 1;
                var_1 linkto( self );
            }

            break;
        default:
            break;
    }
}

drone_fx()
{
    waittillframeend;
    var_0 = spawnlinkedfx( common_scripts\utility::getfx( "mp_levity_aircraft_light" ), self, "tag_fx_camera" );
    triggerfx( var_0 );
}

hanger_event_idle_anims()
{
    switch ( self.script_noteworthy )
    {
        case "drone":
            self.event_animated = 1;
            var_0 = [];
            var_0["drone"] = "mp_lev_drone_deploy_idle";
            var_1 = common_scripts\utility::getstruct( "ref_anim_node", "targetname" );
            self scriptmodelplayanimdeltamotionfrompos( var_0[self.script_noteworthy], var_1.origin, var_1.angles );

            if ( isdefined( self.collision_prop ) )
                self.collision_prop scriptmodelplayanimdeltamotionfrompos( var_0[self.script_noteworthy + "_collision"], var_1.origin, var_1.angles );

            thread drone_fx();
            break;
        default:
            break;
    }
}

hanger_floor_run()
{
    var_0 = 270;
    var_1 = 2;
    var_2 = 110;
    var_3 = 2.0;
    var_4 = 90;
    var_5 = 1.5;
    var_6 = 2;
    var_7 = -512;
    var_8 = 6000;
    var_9 = 2;
    var_10 = 1;
    var_11 = 1;

    switch ( self.script_noteworthy )
    {
        case "hanger_floor_left":
            hanger_event_disconnect_nodes_floor();
            self movex( -1 * var_0, var_1 );
            break;
        case "hanger_floor_right":
            self movex( var_0, var_1 );
            break;
        case "drone":
            var_12 = [];
            var_12["drone"] = "mp_lev_drone_deploy";
            var_13 = common_scripts\utility::getstruct( "ref_anim_node", "targetname" );
            wait(var_5);
            self scriptmodelplayanimdeltamotionfrompos( var_12[self.script_noteworthy], var_13.origin, var_13.angles );

            if ( isdefined( self.collision_prop ) )
                self.collision_prop scriptmodelplayanimdeltamotionfrompos( var_12[self.script_noteworthy + "_collision"], var_13.origin, var_13.angles );

            break;
        case "window":
            wait(var_5);
            var_14 = common_scripts\utility::getstruct( self.target, "targetname" );
            self moveto( var_14.origin, var_10 );
            break;
        case "window_step":
            wait(var_5);
            var_14 = common_scripts\utility::getstruct( self.target, "targetname" );
            self moveto( var_14.origin, var_11 );
            break;
        default:
            break;
    }
}

hanger_event_disconnect_nodes( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_1.origin += ( 0, 0, 1200 );
    var_1 disconnectpaths();
    var_1.origin -= ( 0, 0, 1200 );
}

hanger_event_disconnect_nodes_drone()
{
    hanger_event_disconnect_nodes( "path_node_disconnect_drone" );
}

hanger_event_disconnect_nodes_floor()
{
    hanger_event_disconnect_nodes( "path_node_disconnect_floor" );
}

hanger_event_connect_nodes( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_1 connectpaths();
}

hanger_event_connect_nodes_drone()
{
    hanger_event_connect_nodes( "path_node_disconnect_drone" );
}

hanger_event_connect_nodes_floor()
{
    hanger_event_connect_nodes( "path_node_disconnect_floor" );
}
