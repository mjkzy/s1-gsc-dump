// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

security_center_start()
{
    level.start_point_scripted = "security_center";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    thread maps\irons_estate_code::handle_player_abandoned_mission( "nox" );
    thread maps\irons_estate_infil::poolhouse_enemies();
    thread maps\irons_estate_code::tennis_court_floor( 1 );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_top_kill_trigger" );
    thread drone_setup_before_emp();
    thread security_center_fan_blades();
    soundscripts\_snd::snd_message( "start_security_center" );
    var_0 = getentarray( "security_center_light_hatch", "targetname" );
    thread maps\irons_estate_code::security_center_lights( undefined, var_0, 50000 );
    common_scripts\_exploder::exploder( 6611 );
    common_scripts\utility::flag_set( "player_in_estate" );
    var_1 = common_scripts\utility::getstruct( "security_center_rooftop_obj", "targetname" );
    var_2 = common_scripts\utility::getstruct( "security_center_emp_xprompt", "targetname" );
    objective_add( maps\_utility::obj( "security_center" ), "current", &"IRONS_ESTATE_OBJ_SECURITY_CENTER" );
    objective_position( maps\_utility::obj( "security_center" ), var_2.origin );
    objective_setpointertextoverride( maps\_utility::obj( "security_center" ), &"IRONS_ESTATE_PLANT" );
    thread maps\irons_estate_code::handle_objective_marker( var_2, var_1, "player_planting_emp", 50 );
}

security_center_main()
{
    level.start_point_scripted = "security_center";
    common_scripts\utility::flag_set( "security_center_begin" );
    thread security_center_begin();
    common_scripts\utility::flag_wait( "security_center_end" );
    maps\_utility::autosave_stealth();
}

security_center_begin()
{
    level.player.grapple["dist_max"] = 800;
    thread handle_security_center();
}

handle_security_center()
{
    thread maps\irons_estate_code::security_center_main_screen_bink( 1 );
    var_0 = getent( "security_center_desk_screen", "targetname" );
    var_0 hide();
    thread plant_emp_setup();
    common_scripts\utility::flag_wait( "security_center_enter_anim_done" );
    common_scripts\utility::flag_set( "security_center_end" );
    thread maps\irons_estate_fx::sec_godray();
}

drone_setup_before_emp()
{
    var_0 = getentarray( "security_center_drone", "targetname" );

    foreach ( var_2 in var_0 )
        playfxontag( level._effect["ie_drone_eye_emissive_bootup"], var_2, "tag_main_camera" );

    common_scripts\utility::flag_wait( "emp_detonated" );

    foreach ( var_2 in var_0 )
        stopfxontag( level._effect["ie_drone_eye_emissive_bootup"], var_2, "tag_main_camera" );
}

security_center_fan_blades()
{
    var_0 = getentarray( "fan_blade", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread security_center_fan_blades_internal();
}

security_center_fan_blades_internal()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.angles = self.angles;
    self _meth_804D( var_0, "tag_origin" );

    if ( level.start_point_scripted == "infil" || level.start_point_scripted == "security_center" )
    {
        while ( !common_scripts\utility::flag( "emp_detonated" ) )
        {
            self _meth_842A( ( 0, 180, 0 ), 0.25 );
            self waittill( "rotatedone" );
        }

        self _meth_842A( ( 0, 180, 0 ), 0.25, 0, 0 );
        self waittill( "rotatedone" );
        self _meth_842A( ( 0, 180, 0 ), 0.5, 0, 0 );
        self waittill( "rotatedone" );
        self _meth_842A( ( 0, 180, 0 ), 1, 0, 0 );
        self waittill( "rotatedone" );
        self _meth_842A( ( 0, 180, 0 ), 2, 0, 0 );
    }

    if ( level.start_point_scripted == "security_center" || level.start_point_scripted == "hack_security" )
        common_scripts\utility::flag_wait( "player_is_exiting_security_center" );

    self _meth_842A( ( 0, 180, 0 ), 2, 0, 0 );
    self waittill( "rotatedone" );
    self _meth_842A( ( 0, 180, 0 ), 1, 0, 0 );
    self waittill( "rotatedone" );
    self _meth_842A( ( 0, 180, 0 ), 0.5, 0, 0 );
    self waittill( "rotatedone" );
    self _meth_842A( ( 0, 180, 0 ), 0.25, 0, 0 );
    self waittill( "rotatedone" );

    while ( !common_scripts\utility::flag( "penthouse_end" ) )
    {
        self _meth_804D( var_0, "tag_origin" );
        self _meth_842A( ( 0, 180, 0 ), 0.25 );
        self waittill( "rotatedone" );
    }

    if ( isdefined( self ) )
        self delete();

    if ( isdefined( var_0 ) )
        var_0 delete();
}

plant_emp_setup()
{
    level.security_center_anim_struct = common_scripts\utility::getstruct( "security_center_anim_struct", "targetname" );
    var_0 = getent( "emp_device_position", "targetname" );
    level.emp_device_obj = spawn( "script_model", ( 0, 0, 0 ) );
    level.emp_device_obj _meth_80B1( "mutecharge_obj" );
    level.emp_device_obj.angles = var_0.angles;
    level.emp_device_obj.origin = var_0.origin;
    level.emp = maps\_utility::spawn_anim_model( "emp" );
    level.emp hide();
    maps\irons_estate_code::security_center_player_rig_and_hatch_door_setup();
    level.player_and_hatch_doors[3] = level.emp;
    level.security_center_anim_struct maps\_anim::anim_first_frame( level.player_and_hatch_doors, "plant_emp" );
    level.security_center_hatch_trigger = getent( "security_center_hatch_trigger", "targetname" );
    level.security_center_rooftop_obj = common_scripts\utility::getstruct( "security_center_rooftop_obj", "targetname" );
    thread maps\irons_estate_code::delay_scripting_if_stealth_broken( level.security_center_hatch_trigger, "player_planting_emp", level.emp_device_obj, ::plant_emp_trigger );
    plant_emp_trigger();
}

plant_emp_trigger()
{
    level endon( "_stealth_spotted" );
    level endon( "someone_became_alert" );
    level endon( "drones_investigating" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "someone_became_alert" ) || common_scripts\utility::flag( "drones_investigating" ) )
        return;

    thread security_center_vo();
    level.security_center_hatch_trigger thread maps\_utility::addhinttrigger( &"IRONS_ESTATE_EMP", &"IRONS_ESTATE_EMP_PC" );
    level.security_center_hatch_trigger waittill( "trigger" );
    level.security_center_hatch_trigger delete();
    soundscripts\_snd::snd_message( "aud_security_plant_emp" );
    plant_emp();
}

plant_emp()
{
    level notify( "player_planting_emp" );
    common_scripts\utility::flag_set( "player_planting_emp" );
    _func_0D3( "objectiveHide", 1 );
    level.play_ally_warning_vo = undefined;
    level.ally_vo_org _meth_80AC();
    wait 0.05;
    level.player thread maps\_tagging::tagging_set_binocs_enabled( 0 );
    level.player thread maps\irons_estate_stealth::irons_estate_whistle( 0 );
    level.player freezecontrols( 1 );
    level.player thread maps\_shg_utility::disable_features_entering_cinema( 1 );

    if ( level.player _meth_817C() != "stand" )
        level.player _meth_817D( "stand" );

    level.player _meth_8119( 0 );
    level.player _meth_831D();
    level.player _meth_8080( level.player_rig, "tag_player", 0.6 );
    level.security_center_anim_struct thread maps\_anim::anim_single( level.player_and_hatch_doors, "plant_emp" );
    wait 0.6;
    level.emp_device_obj delete();
    level.player_rig show();
    level.emp show();
    level.player _meth_80AD( "light_1s" );
    level.player_rig waittillmatch( "single anim", "lights_off" );
    common_scripts\utility::flag_set( "emp_detonated" );
    level.player _meth_80AD( "light_1s" );
    level.player thread maps\_tagging::tagging_set_enabled( 0 );
    var_0 = getentarray( "security_center_light", "targetname" );
    thread maps\irons_estate_code::security_center_lights( 1, var_0 );
    var_1 = getentarray( "security_center_light_hatch", "targetname" );
    thread maps\irons_estate_code::security_center_lights( 1, var_1 );
    var_2 = getentarray( "ac_unit_emissive", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );

    var_6 = getent( "security_center_ladder_light", "targetname" );
    var_6 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );
    var_7 = getentarray( "server_lights", "targetname" );

    foreach ( var_9 in var_7 )
        var_9 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );

    var_11 = getent( "security_center_hatch_window_cards", "targetname" );
    var_11 thread maps\irons_estate_code::security_center_script_brushmodels( 1 );
    playfxontag( common_scripts\utility::getfx( "ie_emp" ), level.emp, "tag_vfx_attach" );
    maps\_utility::stop_exploder( 6611 );
    wait 3.25;
    level.player _meth_80AD( "light_1s" );
    wait 0.5;
    level.player _meth_80AD( "light_1s" );
    wait 6.3;
    level.player _meth_80AD( "light_1s" );
    level.player_rig waittillmatch( "single anim", "end" );
    thread maps\irons_estate_code::timer( 120, 10, undefined, &"IRONS_ESTATE_SECURITY_TIMER" );
    level.player_rig hide();
    level.player_and_hatch_doors = common_scripts\utility::array_remove( level.player_and_hatch_doors, level.emp );
    level.emp delete();
    level.player _meth_804F();
    level.player _meth_831E();
    level.player _meth_8119( 1 );
    level.player freezecontrols( 0 );
    level.player thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    common_scripts\utility::flag_set( "security_center_enter_anim_done" );
}

security_center_vo()
{
    level endon( "_stealth_spotted" );
    level endon( "someone_became_alert" );
    level endon( "drones_investigating" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "someone_became_alert" ) || common_scripts\utility::flag( "drones_investigating" ) )
        return;

    wait 0.5;
    var_0 = getent( "security_center_rooftop_trigger", "targetname" );

    if ( !level.player _meth_80A9( var_0 ) )
        var_0 waittill( "trigger" );

    maps\_utility::smart_radio_dialogue( "ie_nox_microemp" );
    common_scripts\utility::flag_wait( "emp_detonated" );
    wait 6.5;
    maps\_utility::smart_radio_dialogue( "ie_nox_minutesbehind" );
}
