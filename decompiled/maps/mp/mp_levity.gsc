// S1 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main()
{
    _id_A76E::main();
    _id_A6D7::main();
    _id_A76D::main();
    maps\mp\_load::main();
    thread _id_7E66();
    maps\mp\mp_levity_lighting::main();
    thread maps\mp\mp_levity_aud::main();
    level._id_088B = 600;
    level._id_088D[0] = spawnstruct();
    level._id_088D[0].origin = ( -977.0, -1811.0, 2054.0 );
    level._id_088D[0].radius = 275;
    maps\mp\_compass::_id_831E( "compass_map_mp_levity" );
    setdvar( "r_lightGridEnableTweaks", 1 );
    setdvar( "r_lightGridIntensity", 1.33 );
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    common_scripts\utility::array_thread( getentarray( "com_radar_dish", "targetname" ), ::_id_70AB );
    level thread _id_46B7();
    level thread _id_4CEB();
    level thread _id_4CB1();
    level thread levitypatchclip();

    if ( level.nextgen )
    {
        level thread _id_4CB2();
        setdvar( "sm_polygonOffsetPreset", 2 );
    }
}

levitypatchclip()
{
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 766.0, -3192.0, 1488.5 ), ( 352.5, 311.3, 0.110002 ) );
    maps\mp\_utility::spawnpatchclip( "patchclip_player_16_256_256", ( 963.5, -3033.0, 1488.5 ), ( 352.5, 306.4, 0.109992 ) );
}

_id_4CB2()
{
    var_0 = [ "mp_lev_drone_assembly_line_01", "mp_lev_drone_assembly_line_02", "mp_lev_drone_assembly_line_03", "mp_lev_drone_assembly_line_04", "mp_lev_drone_assembly_line_05", "mp_lev_drone_assembly_line_06", "mp_lev_drone_assembly_line_07" ];

    foreach ( var_2 in var_0 )
        map_restart( var_2 );

    var_4 = common_scripts\utility::getstruct( "robot_arm_scripted_node", "targetname" );
    var_5 = getentarray( "assembly_line_drone", "targetname" );

    foreach ( var_8, var_7 in var_5 )
        var_7 thread _id_76A2( var_4, var_0[var_8] );
}

_id_76A2( var_0, var_1 )
{
    self endon( "death" );
    var_2 = "droneNT";
    self _meth_848B( var_1, var_0.origin, var_0.angles, var_2 );

    for (;;)
    {
        self waittill( var_2, var_3 );
        var_4 = self gettagorigin( "j_drone" );

        switch ( var_3 )
        {
            case "drone_sound_start":
                playsoundatpos( var_4, "drone_gear_start" );
                continue;
            case "drone_sound_stop":
                playsoundatpos( var_4, "drone_gear_stop" );
                continue;
            default:
                continue;
        }
    }
}

_id_4CEB()
{
    var_0 = "mp_lev_ind_thermanl_cell_fan_spin";
    map_restart( var_0 );
    var_1 = getentarray( "levity_animated_fan", "targetname" );
    common_scripts\utility::array_thread( var_1, ::_id_76A7, var_0 );
}

_id_76A7( var_0 )
{
    self scriptmodelplayanimdeltamotion( var_0 );
}

_id_4CB1()
{
    var_0 = getentarray( "levity_antenna", "targetname" );
    common_scripts\utility::array_thread( var_0, ::_id_70AB, 20 );
}

_id_70AB( var_0 )
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

_id_7E66()
{
    if ( _func_235() )
    {
        for (;;)
        {
            level waittill( "connected", var_0 );
            var_0 setclientdvars( "r_tonemap", "1" );
        }
    }
}

_id_46B7()
{
    level._id_33C8 = getentarray( "hanger_event", "targetname" );
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46BF );
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46B5 );
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46BE );
}

_id_33D4()
{
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46C0 );
    thread maps\mp\mp_levity_aud::_id_33C1();
}

_id_33D3()
{
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46B6 );
    common_scripts\utility::array_thread( level._id_33C8, ::_id_46BE );
    _id_46B9();
    _id_46BA();
}

_id_46B5()
{
    self._id_8C1A = self.origin;
    self._id_8B2C = self.angles;
}

_id_46B6()
{
    if ( isdefined( self._id_33C0 ) && self._id_33C0 )
    {
        self _meth_827A();

        if ( isdefined( self._id_2031 ) )
            self._id_2031 _meth_827A();
    }

    self.origin = self._id_8C1A;
    self.angles = self._id_8B2C;
}

_id_46BF()
{
    var_0 = ( 60.0, 0.0, 0.0 );

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
                var_1._id_1B9E = 1;
                var_1 linkto( self );
            }

            break;
        default:
            break;
    }
}

_id_2E53()
{
    waittillframeend;
    var_0 = _func_2C1( common_scripts\utility::getfx( "mp_levity_aircraft_light" ), self, "tag_fx_camera" );
    triggerfx( var_0 );
}

_id_46BE()
{
    switch ( self.script_noteworthy )
    {
        case "drone":
            self._id_33C0 = 1;
            var_0 = [];
            var_0["drone"] = "mp_lev_drone_deploy_idle";
            var_1 = common_scripts\utility::getstruct( "ref_anim_node", "targetname" );
            self _meth_848B( var_0[self.script_noteworthy], var_1.origin, var_1.angles );

            if ( isdefined( self._id_2031 ) )
                self._id_2031 _meth_848B( var_0[self.script_noteworthy + "_collision"], var_1.origin, var_1.angles );

            thread _id_2E53();
            break;
        default:
            break;
    }
}

_id_46C0()
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
            _id_46BD();
            self _meth_82AF( -1 * var_0, var_1 );
            break;
        case "hanger_floor_right":
            self _meth_82AF( var_0, var_1 );
            break;
        case "drone":
            var_12 = [];
            var_12["drone"] = "mp_lev_drone_deploy";
            var_13 = common_scripts\utility::getstruct( "ref_anim_node", "targetname" );
            wait(var_5);
            self _meth_848B( var_12[self.script_noteworthy], var_13.origin, var_13.angles );

            if ( isdefined( self._id_2031 ) )
                self._id_2031 _meth_848B( var_12[self.script_noteworthy + "_collision"], var_13.origin, var_13.angles );

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

_id_46BB( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_1.origin += ( 0.0, 0.0, 1200.0 );
    var_1 disconnectpaths();
    var_1.origin -= ( 0.0, 0.0, 1200.0 );
}

_id_46BC()
{
    _id_46BB( "path_node_disconnect_drone" );
}

_id_46BD()
{
    _id_46BB( "path_node_disconnect_floor" );
}

_id_46B8( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    var_1 connectpaths();
}

_id_46B9()
{
    _id_46B8( "path_node_disconnect_drone" );
}

_id_46BA()
{
    _id_46B8( "path_node_disconnect_floor" );
}
