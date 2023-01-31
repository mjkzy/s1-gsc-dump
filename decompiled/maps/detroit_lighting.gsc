// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main2()
{
    waittillframeend;
    thread set_level_lighting_values();
    thread setup_dof_presets();
    thread setup_dof_viewmodel_presets();
    thread sunflare();
    thread setup_flickerlight_presets();
    thread lightning_call_single( "detroit_lightning_max", 0.3, 0.7, 1675 );
    thread toggle_lighting_spot01_on();
    thread manage_staircase_lights();
    thread toogle_burke_fall_light();
    thread gate_lights_off();
    thread train_spotlight_lerp();
    thread setup_player_fall_fog();
    thread hospital_flicker_lights();
    thread show_hidden_rail();
    thread outerspacelighting();
    thread setup_vfx_sunflare();
    thread main_camp_spot();
    thread gate_pulse_on();
    thread exo_flicker_lighting();
    thread clut_manage();
    thread clut_manage_school();
    thread butress_origin_fix();
    thread det_vignette();

    if ( level.currentgen )
    {
        common_scripts\utility::flag_init( "school_spotlight_off" );
        thread cg_car_light_shadowstate_on();
        thread cg_car_light_shadowstate_reset();
    }

    precacheshader( "ac130_overlay_pip_bottom_vignette" );
    precachemodel( "com_flashlight_on_physics" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
}

set_level_lighting_values()
{
    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );

    if ( _func_235() )
    {
        _func_0D3( "r_disableLightSets", 0 );
        _func_0D3( "r_tonemapMinExposureAdjust", -7.4919 );
        _func_0D3( "sm_usedSunCascadeCount", 2 );
        _func_0D3( "sm_sunSampleSizeNear", 0.2 );
        _func_0D3( "r_fog_ev_adjust", 1 );

        if ( level.nextgen )
        {
            _func_0D3( "r_dynamicOpl", 1 );
            _func_0D3( "r_gunSightColorEntityScale", 0.3 );
            _func_0D3( "r_gunSightColorNoneScale", 0.3 );
        }
    }
}

setup_dof_presets()
{
    maps\_lighting::create_dof_preset( "fall", 10, 18, 10, 25, 150, 4, 0.5 );
    maps\_lighting::create_dof_preset( "detroit_grab", 1, 2, 4, 50, 150, 2.7, 0.5 );
    maps\_lighting::create_dof_preset( "schoolextdof", 10, 60, 6, 100, 5000, 2.3, 0.5 );
    maps\_lighting::create_dof_preset( "huddle", 10, 18, 5, 100, 200, 3, 0.5 );
    maps\_lighting::create_dof_preset( "breach", 1, 2, 5, 40, 120, 3, 0.5 );
    maps\_lighting::create_dof_preset( "breach_back", 1, 2, 5, 90, 220, 3, 0.5 );
    maps\_lighting::create_dof_preset( "introdof", 10, 18, 10, 30, 100, 2.5, 0.5 );
    maps\_lighting::create_dof_preset( "capture", 10, 40, 4, 30, 300, 2.5, 0.5 );
    maps\_lighting::create_dof_preset( "camp", 5, 35, 5, 1000, 7000, 0.5, 0.5 );
    maps\_lighting::create_dof_preset( "detroit_med_blur", 1, 2, 6, 30, 40, 2, 0.5 );
}

setup_dof_viewmodel_presets()
{
    maps\_lighting::create_dof_viewmodel_preset( "bike_vm_dof", 10, 90 );
}

setup_flickerlight_presets()
{
    maps\_lighting::create_flickerlight_preset( "fire2", ( 0.972549, 0.62451, 1 ), ( 0.2, 0.146275, 1 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway2", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway3", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "red_pulse", ( 1, 0, 0 ), ( 0.3, 0, 0 ), 0.2, 1, 80000 );
}

sunflare()
{
    maps\_art::sunflare_changes( "default", 0 );
}

play_flickering_light_school_01()
{
    level endon( "console_guy_spawn" );

    for (;;)
    {
        thread maps\_lighting::model_flicker_preset( "model_flicker_01", 0, 5000, 5000, undefined, 1660, 0.2, 1.5, 0.05, 0.2, "endlight" );
        common_scripts\utility::flag_wait( "exploder1660" );
        level notify( "endlight" );
        common_scripts\utility::flag_waitopen( "exploder1660" );
    }
}

manage_staircase_lights()
{
    common_scripts\utility::flag_init( "staircase_lights" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "staircase_lights" );
        common_scripts\_exploder::exploder( 5193 );

        if ( level.nextgen )
        {
            var_0 = 100;
            var_1 = 100;
        }
        else
        {
            var_0 = 70;
            var_1 = 70;
        }

        var_2 = 0.005;
        var_3 = 0.4;
        var_4 = 0.005;
        var_5 = 0.4;
        var_6["on"] = "school_flickering_light_on";
        var_6["off"] = "school_flickering_light_off";
        var_6["loop"] = "school_flickering_light_lp";
        var_6["vol_env"] = [ [ var_0, 0.25 ], [ var_1, 1.0 ] ];
        thread maps\_lighting::model_flicker_preset( "model_flicker_02", 0, var_0, var_1, 1661, undefined, var_2, var_3, var_4, var_5, "flickering_light_02_off", var_6, 500 );
        common_scripts\utility::flag_waitopen( "staircase_lights" );
    }
}

play_flickering_light_school_03()
{
    thread maps\_lighting::model_flicker_preset( "model_flicker_03", 0, 500, 500, undefined, undefined, 0.2, 0.5, 0.05, 1 );
}

hallway_light_scare()
{
    var_0 = getent( "light_scare_flicker", "targetname" );
    var_1 = getent( "light_scare_flicker_bounce", "targetname" );

    if ( level.nextgen )
    {
        maps\_lighting::play_flickerlight_preset( "white_fire", "light_scare_flicker", 160 );
        maps\_lighting::play_flickerlight_preset( "white_fire_dim", "light_scare_flicker_bounce", 1.5 );
    }
    else
        maps\_lighting::play_flickerlight_preset( "white_fire", "light_scare_flicker", 2000 );

    common_scripts\_exploder::exploder( 5145 );
    maps\_utility::trigger_wait_targetname( "tile_fall" );
    maps\_lighting::stop_flickerlight( "white_fire", "light_scare_flicker", 0 );
    maps\_lighting::stop_flickerlight( "white_fire", "light_scare_flicker_bounce", 0 );
    wait 0.05;
    wait 0.05;

    if ( isdefined( var_0 ) )
        var_0 _meth_81DF( 4000000 );

    var_1 _meth_81DF( 500000 );
    common_scripts\_exploder::exploder( 2321 );
    wait 0.1;

    if ( isdefined( var_0 ) )
        var_0 _meth_81DF( 0 );

    if ( isdefined( var_1 ) )
        var_1 _meth_81DF( 0 );

    wait 0.15;
    common_scripts\_exploder::kill_exploder( 2321 );
    common_scripts\_exploder::kill_exploder( 5145 );
}

burke_walk_lighting()
{
    var_0 = getent( "burke_walk_light", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 _meth_81DF( 0 );
}

player_fall_lighting()
{
    common_scripts\_exploder::kill_exploder( 5193 );
    level notify( "flashlight_off" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    wait 4;
    common_scripts\_exploder::exploder( 1669 );

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    _func_072( 10, 0.5 );
    wait 0.5;
    _func_072( 0, 1 );
    wait 10;

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "2" );

    wait 2;
    common_scripts\_exploder::exploder( 1670 );
    maps\_utility::set_blur( 2, 0.3 );

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    maps\_utility::set_blur( 8, 0.2 );
    maps\_utility::set_blur( 0, 2 );
    common_scripts\utility::flag_wait( "flag_start_kva_2_basement" );
    common_scripts\_exploder::kill_exploder( 1669 );
}

toogle_burke_fall_light()
{
    if ( level.nextgen )
    {
        var_0 = getent( "burke_fall_light", "targetname" );
        var_1 = getent( "burke_fall_light2", "targetname" );
        var_2 = getent( "player_fall_light", "targetname" );
        var_3 = getent( "burke_fall_light3", "targetname" );
        common_scripts\utility::flag_wait( "school_player_falling" );
        var_4 = getent( "burke_fx_footdrop", "targetname" );
        level.burke _meth_847B( var_4.origin );
        wait 1;
        maps\_utility::vision_set_fog_changes( "detroit_school_walk_nofog", 0.5 );

        if ( isdefined( var_0 ) )
            var_0 _meth_81DF( 50 );

        var_0 _meth_8044( ( 0.2, 0.4, 0.8 ) );

        if ( isdefined( var_1 ) )
            var_1 _meth_81DF( 80 );

        var_1 _meth_8044( ( 0.2, 0.4, 0.8 ) );

        if ( isdefined( var_3 ) )
            var_3 _meth_81DF( 5 );

        var_3 _meth_8044( ( 0.2, 0.4, 0.8 ) );
        wait 3.1;

        if ( isdefined( var_2 ) )
            var_2 _meth_81DF( 700 );

        var_2 _meth_8044( ( 0.2, 0.4, 0.8 ) );
        wait 10;
        level.burke _meth_847C();
    }
}

setup_player_fall_fog()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "player_fall_fog" );
    common_scripts\_exploder::exploder( 5571 );
    maps\_shg_design_tools::waittill_trigger_with_name( "lightning_single" );
    common_scripts\_exploder::kill_exploder( 5571 );
}

toggle_school_exterior_light_on()
{
    wait 0.05;
    var_0 = getentarray( "toggle_school_exterior_light", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( level.nextgen )
        {
            var_2 _meth_81DF( 5000 );
            continue;
        }

        var_2 _meth_81DF( 10000 );
    }

    common_scripts\_exploder::exploder( 2663 );
    common_scripts\utility::flag_wait( "hide_and_seek" );
    common_scripts\_exploder::kill_exploder( 2663 );
}

toggle_school_exterior_light_off()
{
    common_scripts\utility::flag_wait( "school_spotlight_off" );
    var_0 = getent( "toggle_school_exterior_light", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 _meth_81DF( 0.01 );
    else
        return;
}

intro_lighting()
{
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete_real" );
    wait 0.05;

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1.25" );
    }

    if ( level.nextgen )
    {
        _func_0D3( "r_lightgridenabletweaks", 1 );
        maps\_utility::lerp_saveddvar( "r_lightgridintensity", 0.2, 0.1 );
    }

    wait 5.5;
    wait 1;

    if ( level.nextgen )
        thread intro_lerp_sun();

    wait 2.3;
    level.player _meth_83C0( "detroit_intro_2" );

    if ( level.nextgen )
    {
        wait 13.5;
        level.player _meth_83C0( "detroit_intro_1" );
        wait 3;
        _func_0D3( "r_mbEnable", "0" );
        maps\_utility::lerp_saveddvar( "r_lightgridintensity", 1, 2 );
        level.player _meth_8490( "clut_detroit_camp", 20 );
    }
    else
    {
        wait 11;
        level.player _meth_83C0( "detroit_intro_1" );
        wait 3;
        level.player _meth_83C0( "detroit_camp" );
    }
}

intro_dof_physically_based()
{
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete_real" );
    level.player _meth_84BC( 9, 25 );
    level.player _meth_84A9();
    level.player _meth_84AB( 4.0, 35 );
    wait 17;
    level.player _meth_84AB( 4.0, 25 );

    if ( level.nextgen )
    {
        wait 4.5;
        level.player _meth_84AB( 4.5, 16 );
        wait 1.5;
        level.player _meth_84AB( 9.0, 80 );
    }
    else
    {
        wait 4.5;
        level.player _meth_84AB( 2.375, 18.5 );
        wait 1.5;
        level.player _meth_84AB( 9.0, 80, 2.5, 3.5 );
    }

    wait 3;
    common_scripts\utility::flag_set( "flag_autofocus_on" );

    if ( level.currentgen )
        common_scripts\utility::flag_init( "bike_mount_dof_cg" );

    thread autofocus_hipenable();
}

autofocus_hipenable()
{
    common_scripts\utility::flag_wait( "flag_autofocus_on" );

    if ( level.nextgen )
    {

    }

    level.player _meth_84AA();
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 3.5 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );
    common_scripts\utility::flag_waitopen( "flag_autofocus_on" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
    thread mount_bike_dof();
}

mount_bike_dof()
{
    level.player _meth_84A9();
    level.player _meth_84AB( 1.5, 40, 30, 30 );
    wait 2.5;
    level.player _meth_84AB( 1.5, 77, 30, 30 );
    wait 2.8;
    level.player _meth_84AB( 1.5, 20, 30, 30 );
    wait 3;
    level.player _meth_84AB( 5, 200, 30, 30 );
    wait 2;
    level.player _meth_84AA();
    wait 3;
    level.player _meth_8490( "clut_detroit_exterior_drive_1", 3 );
}

autofocus_hipenable_bike()
{
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_hipFstop", 3.5 );
    else
        _func_0D3( "r_dof_physical_hipFstop", 5.5 );
}

bike_mount_dof()
{
    common_scripts\utility::flag_clear( "flag_autofocus_on" );

    if ( level.nextgen )
    {
        var_0 = level.burke;

        if ( isdefined( var_0.helmet_tag ) )
            var_0.helmet_tag delete();

        var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
        var_1 = var_0.helmet_tag;
        var_1 _meth_804D( var_0, "J_Head", ( 3, 10, 0 ), ( 0, 0, 0 ), 0 );
        playfxontag( common_scripts\utility::getfx( "intro_point_rim" ), var_1, "tag_origin" );
        wait 1;
        wait 5;
        wait 2;
        wait 2;

        if ( level.nextgen )
        {
            _func_0D3( "r_mbEnable", "2" );
            _func_0D3( "r_mbVelocityScalar", "1" );
        }

        var_2 = getentarray( "gate_top_lights1", "targetname" );

        foreach ( var_4 in var_2 )
            var_4 _meth_81DF( 0 );

        stopfxontag( common_scripts\utility::getfx( "intro_point_rim" ), var_1, "tag_origin" );

        if ( isdefined( var_0.helmet_tag ) )
            var_0.helmet_tag delete();

        wait 4;
        level.player _meth_8490( "clut_detroit_exterior_drive_1", 2 );
        wait 14;
        level.player _meth_8490( "", 2 );
    }
    else
        common_scripts\utility::flag_set( "bike_mount_dof_cg" );
}

jetbike_dismount_red_light()
{
    level.player _meth_8490( "clut_detroit_exterior", 3 );

    if ( level.currentgen )
    {
        if ( common_scripts\utility::flag_exist( "bike_mount_dof_cg" ) )
            common_scripts\utility::flag_clear( "bike_mount_dof_cg" );
    }

    thread school_jeep_light_tgl();
    common_scripts\_exploder::exploder( 9405 );
    wait 4;
    wait 7;

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    wait 0.05;
}

hospital_breach_dof()
{
    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "detroit_hospital_capture1", 2 );
    else
        maps\_utility::vision_set_fog_changes( "detroit_hospital_capture", 2 );

    level.player _meth_84AA();
    wait 0.5;

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1.5" );
    }
}

intro_helipad_lights()
{
    var_0 = getentarray( "det_helipad_light_on", "targetname" );
    var_1 = getentarray( "det_helipad_light_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 hide();

    wait 6;
    thread maps\detroit_fx::cg_helipad_red_fx_lights();

    for ( var_5 = 0; var_5 < 6; var_5++ )
    {
        wait 0.75;

        foreach ( var_7 in var_1 )
            var_7 hide();

        foreach ( var_3 in var_0 )
            var_3 show();

        common_scripts\_exploder::exploder( 1112 );
        wait 0.75;

        foreach ( var_3 in var_0 )
            var_3 hide();

        common_scripts\_exploder::kill_exploder( 1112 );

        foreach ( var_7 in var_1 )
            var_7 show();
    }
}

gate_lights_on()
{
    var_0 = getent( "door_right_rigged", "targetname" );
    var_1 = common_scripts\utility::getstruct( "door_right_rigged_origin", "targetname" );
    var_0 _meth_847B( var_1.origin );
    common_scripts\_exploder::exploder( 1124 );
    wait 2;
    level.player _meth_83C0( "jetbike_gate" );
    var_2 = getent( "door_lights_script2", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 _meth_81DF( 1118200 );

    wait 0.05;
    var_3 = getent( "door_lights_script1", "targetname" );

    if ( isdefined( var_2 ) )
        var_3 _meth_81DF( 422000 );

    wait 0.05;
    wait 0.05;
}

gate_lights_off()
{
    var_0 = getentarray( "gate_light_models", "targetname" );
    var_1 = getentarray( "gate_light_models_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 show();

    foreach ( var_6 in var_1 )
        var_6 hide();
}

gate_lights_off_toggle_on( var_0 )
{
    maps\_utility::stop_exploder( 1124 );
    common_scripts\utility::flag_set( "gate_pulse_light" );
    wait 0.05;
    thread gate_fx();
    wait 1;
    wait 0.05;
    wait 0.05;
    wait 0.05;
    level.player _meth_83C0( "detroit_intro_dark" );
    wait 11;
    common_scripts\utility::flag_set( "open_massive_door" );
    common_scripts\utility::flag_set( "vo_drive_in" );
    level.player _meth_8490( "clut_detroit_exterior_drive_2", 3 );
}

gate_pulse_on()
{
    var_0 = getentarray( "siren_white_on", "targetname" );
    var_1 = getentarray( "siren_white_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 hide();

    common_scripts\utility::flag_wait( "gate_pulse_light" );
    common_scripts\_exploder::exploder( 1125 );

    for ( var_5 = 0; var_5 < 12; var_5++ )
    {
        foreach ( var_3 in var_0 )
            var_3 show();

        foreach ( var_9 in var_1 )
            var_9 hide();

        wait 0.15;

        foreach ( var_3 in var_0 )
            var_3 hide();

        foreach ( var_9 in var_1 )
            var_9 show();

        wait 0.85;
    }

    if ( level.nextgen )
        _func_0D3( "r_mbVelocityScalar", "1.5" );

    maps\_utility::stop_exploder( 1125 );
}

gate_model_spin()
{
    var_0 = getentarray( "siren_orange_model", "targetname" );
    var_1 = getentarray( "siren_light", "targetname" );
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        var_4 _meth_81DF( 3000000 );
        var_4 _meth_8044( ( 1, 1, 1 ) );
    }

    while ( var_2 < 15 )
    {
        foreach ( var_7 in var_0 )
            var_7 _meth_83DF( ( 360, 0, 0 ), 1.0 );

        foreach ( var_4 in var_1 )
            var_4 _meth_83DF( ( 360, 0, 0 ), 1.0 );

        wait 1;
        var_2++;
    }
}

gate_earthquake()
{
    earthquake( 0.1, 7.0, level.player.origin, 1600 );
    wait 4;
    earthquake( 0.4, 1, level.player.origin, 1600 );
}

gate_fx()
{
    thread gate_rumble();
    wait 3;
}

turn_on_helmet_light_bright()
{
    wait 7;
    var_0 = level.player;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_80A6( var_0, "tag_origin", ( 0, 0, 2 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "player_light_bright" ), var_1, "tag_origin" );
}

turn_off_light_bright()
{
    var_0 = level.player;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();
}

turn_on_helmet_light()
{
    var_0 = level.player;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_80A6( var_0, "tag_origin", ( 0, 0, 2 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "player_light" ), var_1, "tag_origin" );
}

turn_off_light()
{
    var_0 = level.player;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();
}

turn_on_weapon_light()
{
    var_0 = level.player;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();

    var_0.flashlight_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.flashlight_tag;
    var_1 _meth_80A6( var_0, "tag_flash", ( 0, 0, -2 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "player_light2" ), var_1, "tag_origin" );
}

turn_on_cheap_flashlight()
{
    self endon( "death" );
    var_0 = [ "flashlight_enemy" ];
    self.flashfx = var_0[randomint( var_0.size )];
    playfxontag( common_scripts\utility::getfx( self.flashfx ), self, "tag_flash" );
}

train_bridge_light_on()
{
    var_0 = getent( "train_bridge_light", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 _meth_81DF( 100000000 );
}

lightning_call( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( "lightning_on" );
    wait 0.05;
    common_scripts\utility::flag_set( "lightning_on" );
}

lightning_call_single( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        maps\_shg_design_tools::waittill_trigger_with_name( "lightning_single" );
        thread toggle_lighting_spot01_lightning();
        level.player _meth_80AD( "heavy_1s" );
        var_4 = getdvar( "vision_set_current" );
        var_5 = getmapsundirection();
        setsundirection( var_5 );
        level.lite_settings = vectortoangles( var_5 );
        level.new_lite_settings = level.lite_settings;
        var_6 = ( randomfloatrange( 20, 30 ) * -1, randomfloatrange( 20, 25 ), 0 );
        var_7 = ( -59.4, 105.5, 0 );
        var_8 = level.new_lite_settings + var_6;
        var_9 = anglestoforward( var_8 );
        setsundirection( var_9 );
        setsunlight( 0.05, 0.05, 0.05 );
        wait 0.05;
        _func_072( 0.5, var_1 );

        if ( isdefined( var_3 ) )
            common_scripts\_exploder::exploder( var_3 );

        wait(randomfloatrange( 0.1, 0.4 ));
        resetsunlight();
        resetsundirection();
        _func_072( 0, var_2 );
        wait 40;
    }
}

lightning_call_gate( var_0, var_1, var_2, var_3 )
{
    var_4 = getdvar( "vision_set_current" );
    var_5 = getmapsundirection();
    setsundirection( var_5 );
    level.lite_settings = vectortoangles( var_5 );
    level.new_lite_settings = level.lite_settings;
    var_6 = ( randomfloatrange( 20, 30 ) * -1, randomfloatrange( 20, 25 ), 0 );
    var_7 = ( -59.4, 105.5, 0 );
    var_8 = level.new_lite_settings + var_6;
    var_9 = anglestoforward( var_8 );
    setsundirection( var_9 );
    setsunlight( 0.05, 0.05, 0.05 );
    wait 0.05;
    _func_072( 0.3, var_1 );

    if ( isdefined( var_3 ) )
        common_scripts\_exploder::exploder( var_3 );

    wait(randomfloatrange( 0.2, 0.5 ));

    if ( isdefined( var_3 ) )
        maps\_utility::stop_exploder( var_3 );

    resetsunlight();
    resetsundirection();
    _func_072( 0, var_2 );
    wait 40;
}

lightning_call_traversal( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        wait 1;

        while ( common_scripts\utility::flag( "start_exit_trains" ) == 1 )
        {
            var_4 = getdvar( "vision_set_current" );
            var_5 = getmapsundirection();
            setsundirection( var_5 );
            level.lite_settings = vectortoangles( var_5 );
            level.new_lite_settings = level.lite_settings;
            var_6 = ( randomfloatrange( 20, 30 ) * -1, randomfloatrange( 20, 25 ), 0 );
            var_7 = ( -59.4, 105.5, 0 );
            var_8 = level.new_lite_settings + var_6;
            var_9 = anglestoforward( var_8 );
            setsundirection( var_9 );
            setsunlight( 0.05, 0.05, 0.05 );
            _func_072( 0.1, var_1 );

            if ( isdefined( var_3 ) )
                common_scripts\_exploder::exploder( var_3 );

            wait(randomfloatrange( 0.2, 0.5 ));

            if ( isdefined( var_3 ) )
                maps\_utility::stop_exploder( var_3 );

            resetsunlight();
            resetsundirection();
            _func_072( 0, var_2 );
            wait 8;
        }
    }
}

toggle_lighting_spot01_on()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lightning_spot_01", "targetname" );
        var_1 = getent( "lightning_spot_02", "targetname" );
        common_scripts\utility::flag_wait( "flag_player_shimmy_start" );

        if ( isdefined( var_0 ) )
            var_0 _meth_81DF( 2000 );

        var_0 _meth_8044( ( 0.8, 0.9, 1 ) );
        var_1 _meth_81DF( 800 );
        var_1 _meth_8044( ( 0.8, 0.9, 1 ) );
    }
    else
    {
        common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
        var_0 = getent( "lightning_spot_01", "targetname" );

        if ( isdefined( var_0 ) )
        {
            var_0 _meth_81DF( 1 );
            var_0 _meth_8044( ( 0.8, 0.9, 1 ) );
        }
    }
}

toggle_lighting_spot01_on_checkpoint()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lightning_spot_01", "targetname" );
        var_1 = getent( "lightning_spot_02", "targetname" );

        if ( isdefined( var_0 ) )
            var_0 _meth_81DF( 2000 );

        var_0 _meth_8044( ( 0.5, 0.7, 1 ) );
        var_1 _meth_81DF( 800 );
        var_1 _meth_8044( ( 0.5, 0.7, 1 ) );
    }
    else
    {
        var_0 = getent( "lightning_spot_01", "targetname" );

        if ( isdefined( var_0 ) )
        {
            var_0 _meth_81DF( 1 );
            var_0 _meth_8044( ( 0.5, 0.7, 1 ) );
        }
    }
}

basement_fog_checkpoint()
{
    common_scripts\_exploder::exploder( 5571 );
    maps\_shg_design_tools::waittill_trigger_with_name( "lightning_single" );
    common_scripts\_exploder::kill_exploder( 5571 );
}

toggle_lighting_spot01_lightning()
{
    var_0 = getent( "lightning_spot_01", "targetname" );
    var_1 = common_scripts\utility::getstruct( "old_origin", "targetname" );
    var_2 = common_scripts\utility::getstruct( "new_origin", "targetname" );

    if ( isdefined( var_0 ) )
    {
        var_0 _meth_81DF( randomfloatrange( 10055, 50050 ) );
        var_0.origin = var_2.origin;
        var_0 soundscripts\_snd::snd_message( "lightning_strike" );
        wait 1;

        if ( level.nextgen )
            var_0 _meth_81DF( 1000 );
        else
            var_0 _meth_81DF( 1 );

        var_0.origin = var_1.origin;
    }
}

burke_intro_lighting()
{
    common_scripts\utility::flag_wait( "level_intro_cinematic_complete_real" );
    wait 1;
    var_0 = level.burke;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.flashlight_tag ) )
        var_0.flashlight_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_0.helmet_tag2 = common_scripts\utility::spawn_tag_origin();
    var_2 = var_0.helmet_tag2;
    var_1 _meth_804D( var_0, "TAG_ORIGIN", ( -9, 5, 65 ), ( 0, 0, 0 ), 0 );
    var_2 _meth_804D( var_0, "J_Head", ( 0, 20, 0 ), ( 0, 0, 0 ), 0 );
    level waittill( "end_burke_intro_talk" );
}

guy_outside_school( var_0 )
{
    wait 7;
    var_0 add_enemy_flashlight( "flashlight", "bright" );
    var_0 maps\_utility::notify_delay( "flashlight_off", 21 );
    maps\_utility::stop_exploder( 9405 );
}

lerp_origin_function( var_0, var_1, var_2 )
{
    var_0 notify( "stop lerp" );
    var_0 endon( "stop lerp" );
    var_0 endon( "death" );
    var_3 = var_0.origin;
    var_4 = 0;

    while ( var_4 < var_1 )
    {
        var_0.origin = vectorlerp( var_3, var_2, var_4 / var_1 );
        var_4 += 0.05;
        wait 0.05;
    }

    var_0.origin = var_2;
}

train_spotlight_lerp()
{
    var_0 = getent( "lerp_light", "targetname" );
    var_1 = common_scripts\utility::getstruct( "origin_final", "targetname" );
    var_2 = common_scripts\utility::getstruct( "origin_start", "targetname" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_0.origin;
    var_3.angles = var_0.angles;
    maps\_shg_design_tools::waittill_trigger_with_name( "train_scare" );
    var_0 _meth_8498( "force_on" );
    soundscripts\_snd::snd_message( "train_scare" );
    thread train_rumble();
    earthquake( 0.05, 1.0, level.player.origin, 1600 );
    wait 0.5;
    earthquake( 0.12, 1.0, level.player.origin, 1600 );
    var_0 _meth_82AE( var_2.origin, 0.15, 0.05, 0.05 );
    wait 0.5;
    earthquake( 0.2, 5.0, level.player.origin, 1600 );
    var_0 _meth_81DF( 8000 );
    thread lerp_origin_function( var_0, 9, var_1.origin );
    var_3 _meth_804D( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    wait 1;
    earthquake( 0.12, 4.0, level.player.origin, 1600 );
    wait 2;
    earthquake( 0.05, 4.0, level.player.origin, 1600 );
    thread maps\_lighting::lerp_spot_intensity( "lerp_light", 2, 1 );
    wait 6.5;
    var_0 _meth_8498( "force_off" );
}

train_rumble()
{
    level.player _meth_80AD( "light_2s" );
    wait 0.5;
    level.player _meth_80AD( "light_2s" );
    wait 0.5;
    level.player _meth_80AD( "light_2s" );
    wait 0.5;
    level.player _meth_80AD( "heavy_2s" );
    wait 0.5;
    level.player _meth_80AD( "heavy_2s" );
    wait 0.5;
    level.player _meth_80AD( "heavy_2s" );
    wait 0.5;
    level.player _meth_80AD( "light_2s" );
    wait 0.5;
    level.player _meth_80AD( "light_2s" );
    wait 0.5;
    level.player _meth_80AD( "light_2s" );
}

gate_rumble()
{
    level.player _meth_80AD( "light_3s" );
    wait 1;
    level.player _meth_80AD( "light_3s" );
    wait 1;
    level.player _meth_80AD( "light_2s" );
    wait 2;
    level.player _meth_80AD( "heavy_1s" );
}

train_radiosity()
{

}

player_school_flashlight()
{
    maps\_utility::trigger_wait_targetname( "jetbike_lights_off" );
    level.player add_player_flashlight();
    level waittill( "player_door_open" );
    level notify( "all_flashlights_off" );
    wait 4;
    level.burke add_burke_flashlight( "flashlight", 1 );
    common_scripts\_exploder::kill_exploder( 5622 );
    common_scripts\utility::flag_wait( "flag_player_shimmy_start" );
    level.player notify( "flashlight_off" );
}

add_player_flashlight( var_0, var_1, var_2 )
{
    var_3 = level.player common_scripts\utility::spawn_tag_origin();
    var_3 _meth_80A6( level.player, "tag_flash", ( 0, -10, 10 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "player_light_med2" ), var_3, "tag_origin" );
    level.player.tag_weapon = var_3;
    thread monitor_player_light_off();
}

player_spotlight( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "flashlight_off" );
    thread monitor_player_light_off();
    self.roaming_light = var_0 common_scripts\utility::spawn_tag_origin();
    _func_09A( self.roaming_light );
    playfxontag( common_scripts\utility::getfx( "player_light_med2" ), self.roaming_light, "tag_origin" );

    while ( isalive( self ) )
    {
        var_4 = var_0.origin;
        var_5 = var_0.angles;
        var_6 = anglestoforward( var_5 ) * 400;
        var_7 = anglestoforward( var_5 ) * -20;
        var_8 = bullettrace( var_4, var_4 + var_6, 1, var_0, 0 );
        var_9 = bullettrace( var_8["position"], var_8["position"] + var_7, 1, self, 0 );
        self.roaming_light.origin = var_9["position"];
        waitframe();
    }
}

attach_light_to_face( var_0, var_1 )
{
    self.facelight = common_scripts\utility::spawn_tag_origin();

    if ( !isdefined( var_0 ) || !var_0 )
    {
        if ( !isdefined( var_1 ) || !var_1 )
            playfxontag( common_scripts\utility::getfx( "point_amber" ), self.facelight, "tag_origin" );
        else if ( isdefined( var_1 ) && var_1 )
            playfxontag( common_scripts\utility::getfx( "point_amber_dim" ), self.facelight, "tag_origin" );
    }
    else
        playfxontag( common_scripts\utility::getfx( "point_blue_med" ), self.facelight, "tag_origin" );

    var_2 = maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_eye", 20 );
    self.facelight.origin = var_2;
    self.facelight _meth_804D( self, "tag_eye" );
    common_scripts\utility::waittill_any( "death", "facelight_off" );

    if ( isdefined( self ) && isdefined( self.facelight ) )
        self.facelight delete();
}

remove_light_from_face()
{
    self notify( "facelight_off" );
}

add_enemy_flashlight( var_0, var_1, var_2, var_3 )
{
    var_4 = cheap_flashlight_setup( var_0, var_1, var_2, var_3 );
    thread fake_spotlight( var_4, var_1, var_2, 0 );
    self.flashlight_on = 1;
    self.flashlight_parm_type = var_0;
    self.flashlight_parm_spotlight = var_1;
    self.flashlight_parm_point_light = var_2;
    self.flashlight_parm_offset = var_3;
}

add_basement_enemy_flashlight( var_0, var_1, var_2 )
{
    var_3 = basement_enemy_flashlight_setup( var_0, var_1, var_2 );
    thread fake_spotlight( "tag_light", var_1, var_2, 0 );
}

add_burke_flashlight( var_0, var_1, var_2 )
{
    var_3 = burke_cheap_flashlight_setup( var_0, var_1, var_2 );
    level.burke thread fake_spotlight( var_3, var_1, var_2, 1 );
}

cheap_flashlight_setup( var_0, var_1, var_2, var_3 )
{
    var_4 = self;
    var_5 = "tag_eye";

    if ( isdefined( var_0 ) && var_0 == "flashlight" )
    {
        var_6 = self gettagorigin( "tag_inhand" );
        var_7 = self gettagangles( "tag_inhand" );
        self.flashlight = spawn( "script_model", var_6 );
        self.flashlight _meth_80B1( "com_flashlight_on_physics" );

        if ( isdefined( var_3 ) )
            self.flashlight.angles = anglestoforward( var_7 ) * var_3;
        else
            self.flashlight.angles = var_7;

        self.flashlight _meth_804D( self, "tag_inhand" );
        var_4 = self.flashlight;
        var_5 = "tag_light";
        thread flashlight_off_think();
    }

    return var_5;
}

basement_enemy_flashlight_setup( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = "tag_weapon_left";

    if ( isdefined( var_0 ) && var_0 == "flashlight" )
    {
        var_5 = self gettagorigin( "tag_inhand" );
        var_6 = self gettagangles( "tag_inhand" );
        self.flashlight = spawn( "script_model", var_5 );
        self.flashlight _meth_80B1( "com_flashlight_on_physics" );
        self.flashlight.angles = var_6;
        self.flashlight _meth_804D( self, "tag_inhand" );
        var_3 = self.flashlight;
        var_4 = "tag_weapon_left";
        thread flashlight_off_think();
    }

    return var_4;
}

burke_cheap_flashlight_setup( var_0, var_1, var_2 )
{
    var_3 = "tag_flash";
    return var_3;
}

flashlight_off_think()
{
    var_0 = self.flashlight;
    var_1 = common_scripts\utility::waittill_any_return( "death", "damage", "alert", "flashlight_off" );
    stopfxontag( common_scripts\utility::getfx( self.fx_type ), var_0, "tag_light" );
    var_0 notify( "flashlight_off" );
    var_0.light_tag delete();
    var_0 delete();
}

monitor_player_light_off()
{
    common_scripts\utility::waittill_any( "flashlight_off", "death" );

    if ( !isdefined( self ) )
        return;

    stopfxontag( common_scripts\utility::getfx( "player_light_med2" ), self.tag_weapon, "tag_origin" );
    self.tag_weapon delete();
}

monitor_turn_light_off()
{
    common_scripts\utility::waittill_any_ents( self, "flashlight_off", self, "death", level, "all_flashlights_off" );

    if ( !isdefined( self ) )
        return;

    if ( isdefined( self.light_tag ) )
        stopfxontag( common_scripts\utility::getfx( "point_amber" ), self.light_tag, "tag_origin" );

    if ( isdefined( self.fx_tag ) && isdefined( self.fx_type ) )
        stopfxontag( common_scripts\utility::getfx( self.fx_type ), self, self.fx_tag );
}

fake_spotlight( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "damage" );
    self endon( "alert" );
    level endon( "all_flashlights_off" );

    if ( var_0 == "tag_light" )
        var_4 = self.flashlight;
    else
        var_4 = self;

    var_4 endon( "flashlight_off" );
    var_4 thread monitor_turn_light_off();
    self.disablelongdeath = 1;
    var_4.light_tag = common_scripts\utility::spawn_tag_origin();
    var_5 = "flashlight_enemy";

    if ( isdefined( var_1 ) )
    {
        if ( isstring( var_1 ) )
        {
            if ( var_1 == "bright" )
                var_5 = "player_light_bright";

            if ( var_1 == "med" )
                var_5 = "player_light_med";

            if ( var_1 == "light" )
                var_5 = "player_light_light";
        }
        else
            var_5 = "player_light";

        if ( isdefined( var_2 ) && var_2 )
            playfxontag( common_scripts\utility::getfx( "point_amber" ), var_4.light_tag, "tag_origin" );
    }
    else if ( isdefined( var_3 ) && var_3 )
        playfxontag( common_scripts\utility::getfx( "point_blue" ), var_4.light_tag, "tag_origin" );
    else
        playfxontag( common_scripts\utility::getfx( "point_amber" ), var_4.light_tag, "tag_origin" );

    playfxontag( common_scripts\utility::getfx( var_5 ), var_4, var_0 );
    thread kill_flashlight_fx( common_scripts\utility::getfx( var_5 ), var_4, var_0 );
    var_4.fx_tag = var_0;
    self.fx_type = var_5;
    var_4.fx_type = var_5;

    while ( isalive( self ) )
    {
        var_6 = var_4 gettagorigin( var_0 );
        var_7 = var_4 gettagangles( var_0 );
        var_8 = anglestoforward( var_7 ) * 400;
        var_9 = anglestoforward( var_7 ) * -20;
        var_10 = bullettrace( var_6, var_6 + var_8, 1, var_4, 0 );
        var_11 = bullettrace( var_10["position"], var_10["position"] + var_9, 1, var_4, 0 );
        var_4.light_tag.origin = var_11["position"];
        waitframe();
    }
}

kill_flashlight_fx( var_0, var_1, var_2 )
{
    level waittill( "all_flashlights_off" );

    if ( isdefined( var_1 ) )
        killfxontag( var_0, var_1, var_2 );
}

attach_pointlight_to_beam( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( "point_amber" ), var_1, "tag_origin" );

    for (;;)
    {
        var_2 = self gettagorigin( var_0 );
        var_3 = self gettagangles( var_0 );
        var_4 = anglestoforward( var_3 ) * 800;
        var_5 = anglestoforward( var_3 ) * -20;
        var_6 = bullettrace( var_2, var_2 + var_4, 1, self, 0 );
        var_7 = bullettrace( var_6["position"], var_6["position"] + var_5, 1, self, 0 );
        thread common_scripts\utility::draw_line_for_time( self.origin, var_7["position"], 0, 0, 1, 0.05 );
        var_1.origin = var_7["position"];
        waitframe();
    }
}

sundark_manage()
{
    for (;;)
    {
        common_scripts\utility::flag_waitopen( "lightning_on" );
        setsunlight( 0, 0, 0 );
        common_scripts\utility::flag_wait( "lightning_on" );
        resetsunlight();
    }
}

debug_flashlight_basement_switch()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = "";

        if ( self.has_expensive_flashlight == 1 )
            var_0 = "expensive";
        else
            var_0 = "cheap";

        wait 0.05;
    }
}

guy_basement_flashlight_monitor()
{
    self endon( "death" );

    for (;;)
    {
        level waittill( "update_basement_flashlights" );
        self notify( "flashlight_off" );

        if ( isdefined( self.give_expensive_flashlight ) )
        {
            self.give_expensive_flashlight = undefined;
            self.has_expensive_flashlight = 1;
            add_basement_enemy_flashlight( "flashlight", "med" );
            continue;
        }

        add_enemy_flashlight( "flashlight", "med" );
        self.has_expensive_flashlight = 0;
    }
}

guy_flashlight_basement_switch( var_0, var_1 )
{
    self endon( "death" );
    thread guy_basement_flashlight_monitor();
    self.has_expensive_flashlight = 0;

    if ( var_1 )
    {
        self.give_expensive_flashlight = 1;
        level notify( "update_basement_flashlights" );
    }
    else
        add_enemy_flashlight( "flashlight", "med" );

    thread debug_flashlight_basement_switch();

    for (;;)
    {
        maps\_shg_design_tools::waittill_trigger_with_name( var_0 );

        if ( !self.has_expensive_flashlight )
        {
            self.give_expensive_flashlight = 1;
            level notify( "update_basement_flashlights" );
        }
    }
}

enemy_flashlight_think_on( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        maps\_shg_design_tools::waittill_trigger_with_name( var_0 );

        if ( !isdefined( self.flashlight_on ) || self.flashlight_on == 0 )
        {
            add_enemy_flashlight( self.flashlight_parm_type, self.flashlight_parm_spotlight, self.flashlight_parm_point_light, self.flashlight_parm_offset );
            self.flashlight_on = 1;
        }
    }
}

enemy_flashlight_think_off( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        maps\_shg_design_tools::waittill_trigger_with_name( var_0 );

        if ( isdefined( self.flashlight_on ) && self.flashlight_on == 1 )
        {
            self notify( "flashlight_off" );
            self.flashlight_on = undefined;
        }
    }
}

enemy_flashlight_toggle_think( var_0, var_1 )
{
    thread enemy_flashlight_think_on( var_0 );
    thread enemy_flashlight_think_off( var_1 );
}

grab_lighting()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", ".5" );
    }

    common_scripts\_exploder::exploder( 1685 );
    wait 11;

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "0" );
        common_scripts\_exploder::kill_exploder( 1685 );
    }
}

hospital_flicker_lights()
{
    if ( level.nextgen )
    {
        maps\_utility::trigger_wait_targetname( "team_move_hospital" );
        maps\_lighting::play_flickerlight_preset( "white_fire", "hospital_pulse_01", 290000 );
        maps\_lighting::play_flickerlight_preset( "white_fire", "hospital_pulse_02", 80000 );
    }
}

burke_red_arm_light()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "move_burke_ahead" );
    level.burke.red_point = common_scripts\utility::spawn_tag_origin();
    var_0 = level.burke.red_point;
    var_0 _meth_804D( level.burke, "J_Elbow_LE", ( 4, -6, 0 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "red_point" ), var_0, "tag_origin" );
}

burke_red_arm_light_checkpoint()
{
    level.burke.red_point = common_scripts\utility::spawn_tag_origin();
    var_0 = level.burke.red_point;
    var_0 _meth_804D( level.burke, "J_Elbow_LE", ( 4, -6, 0 ), ( 160, 90, 90 ), 0 );

    if ( common_scripts\utility::flag( "red_dim" ) == 1 )
        playfxontag( common_scripts\utility::getfx( "red_point_dim" ), var_0, "tag_origin" );
    else
        playfxontag( common_scripts\utility::getfx( "red_point" ), var_0, "tag_origin" );

    level waittill( "kill_burke_red_light" );

    if ( isdefined( level.burke.red_point ) )
        level.burke.red_point delete();
}

joker_red_arm_light_checkpoint()
{
    level.joker.red_point = common_scripts\utility::spawn_tag_origin();
    var_0 = level.joker.red_point;
    var_0 _meth_804D( level.joker, "J_Elbow_LE", ( 4, -6, 0 ), ( 160, 90, 90 ), 0 );
    playfxontag( common_scripts\utility::getfx( "red_point_dim" ), var_0, "tag_origin" );
    level waittill( "kill_joker_red_light" );

    if ( isdefined( level.joker.red_point ) )
        level.joker.red_point delete();
}

train_lighting( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_2 endon( "death" );
    wait 0.1;

    if ( common_scripts\utility::flag( "jetbike_dynfx_on" ) == 1 )
    {
        for (;;)
        {
            common_scripts\utility::flag_wait( "lightning_on" );
            playfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train_nolight" ), var_1, "tag_origin" );
            playfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
            common_scripts\utility::flag_waitopen( "lightning_on" );
            killfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train_nolight" ), var_1, "tag_origin" );
            killfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
        }
    }
    else
    {
        for (;;)
        {
            common_scripts\utility::flag_wait( "lightning_on" );

            if ( common_scripts\utility::flag( "alleyway_train" ) == 1 )
            {
                playfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train_lrg" ), var_0, "tag_origin" );
                playfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
                common_scripts\utility::flag_waitopen( "alleyway_train" );
                killfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train_lrg" ), var_0, "tag_origin" );
                killfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
                continue;
            }

            playfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train" ), var_0, "tag_origin" );
            playfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
            common_scripts\utility::flag_waitopen( "lightning_on" );
            killfxontag( common_scripts\utility::getfx( "det_dyn_spotlight_train" ), var_0, "tag_origin" );
            killfxontag( common_scripts\utility::getfx( "det_track_water_splash" ), var_2, "tag_origin" );
        }
    }
}

trigger_chopper_spotlight_follow( var_0, var_1 )
{
    self endon( "death" );
    level endon( "kill_spotlight" );

    if ( !isdefined( self.spotlight ) )
    {
        self.spotlight = common_scripts\utility::spawn_tag_origin();
        self.spotlight thread handle_spotlight_fx( var_1 );
    }

    for (;;)
    {
        self.spotlight.origin = maps\_shg_design_tools::offset_position_from_tag( "down", "tag_light_nose", 0 );
        var_2 = var_0.origin + var_0 maps\_shg_utility::get_differentiated_velocity() * 0.3;
        var_3 = ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), 0 );
        var_4 = vectortoangles( var_2 + var_3 - self.spotlight.origin );
        self.spotlight.angles = var_4;
        wait(randomfloat( 0.05 ));
    }
}

handle_spotlight_fx( var_0 )
{
    if ( var_0 )
        var_1 = [ "heli_spotlight_god", "heli_spot_flare" ];
    else
        var_1 = [ "heli_spotlight", "heli_spot_flare" ];

    foreach ( var_3 in var_1 )
        playfxontag( common_scripts\utility::getfx( var_3 ), self, "tag_origin" );

    level waittill( "kill_spotlight" );

    foreach ( var_3 in var_1 )
        killfxontag( common_scripts\utility::getfx( var_3 ), self, "tag_origin" );

    waitframe();
    self delete();
}

kill_spotlight()
{
    level notify( "kill_spotlight" );
    wait 0.5;
}

trigger_chopper_spotlight_straight( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 _meth_804D( self, "tag_light_nose", ( 0, 0, 0 ), ( 28, 0, 0 ) );
    var_1 thread handle_spotlight_fx( var_0 );
}

show_hidden_rail()
{
    if ( level.nextgen )
    {
        var_0 = getent( "hidden_rail_01", "targetname" );
        var_1 = getent( "hidden_rail_02", "targetname" );
        var_2 = getent( "hidden_rail_03", "targetname" );
        var_3 = getent( "hidden_rail_04", "targetname" );
        var_4 = getent( "hidden_rail_11", "targetname" );
        var_5 = getent( "hidden_rail_12", "targetname" );
        var_6 = getent( "hidden_rail_13", "targetname" );
        var_7 = getent( "hidden_rail_14", "targetname" );
        var_8 = getent( "hidden_rail_15", "targetname" );
        var_9 = getent( "hidden_rail_16", "targetname" );
        var_10 = getent( "hidden_rail_17", "targetname" );
        var_11 = getent( "track_model_01", "targetname" );
        var_12 = getent( "track_model_02", "targetname" );
        var_13 = common_scripts\utility::getstruct( "rail_pos_01", "targetname" );
        var_14 = common_scripts\utility::getstruct( "rail_pos_02", "targetname" );
        var_15 = common_scripts\utility::getstruct( "rail_pos_03", "targetname" );
        var_16 = common_scripts\utility::getstruct( "rail_pos_04", "targetname" );
        var_17 = common_scripts\utility::getstruct( "rail_pos_11", "targetname" );
        var_18 = common_scripts\utility::getstruct( "rail_pos_12", "targetname" );
        var_19 = common_scripts\utility::getstruct( "rail_pos_13", "targetname" );
        var_20 = common_scripts\utility::getstruct( "rail_pos_14", "targetname" );
        var_21 = common_scripts\utility::getstruct( "rail_pos_15", "targetname" );
        var_22 = common_scripts\utility::getstruct( "rail_pos_16", "targetname" );
        var_23 = common_scripts\utility::getstruct( "rail_pos_17", "targetname" );
        var_24 = common_scripts\utility::getstruct( "track_model_org_01", "targetname" );
        var_25 = common_scripts\utility::getstruct( "track_model_org_02", "targetname" );
        var_0 hide();
        var_1 hide();
        var_2 hide();
        var_3 hide();
        var_4 hide();
        var_5 hide();
        var_6 hide();
        var_7 hide();
        var_8 hide();
        var_9 hide();
        var_10 hide();
        var_11 hide();
        var_12 hide();
        common_scripts\utility::flag_wait( "capture_start" );
        var_0 show();
        var_1 show();
        var_2 show();
        var_3 show();
        var_4 show();
        var_5 show();
        var_6 show();
        var_7 show();
        var_8 show();
        var_9 show();
        var_10 show();
        var_11 show();
        var_12 show();
        var_0.origin = var_13.origin;
        var_1.origin = var_14.origin;
        var_2.origin = var_15.origin;
        var_3.origin = var_16.origin;
        var_4.origin = var_17.origin;
        var_5.origin = var_18.origin;
        var_6.origin = var_19.origin;
        var_7.origin = var_20.origin;
        var_8.origin = var_21.origin;
        var_9.origin = var_22.origin;
        var_10.origin = var_23.origin;
        var_11.origin = var_24.origin;
        var_12.origin = var_25.origin;
    }
}

exit_drive_jetbike_lighting()
{
    level.jetbike thread exit_drive_jetbike_lights_player();
    level.jetbike thread maps\detroit_exit_drive::exit_drive_player_jetbike_initial_lights();
    level.burke_bike thread exit_drive_jetbike_lights_ai();
}

exit_drive_jetbike_lights_player()
{
    for (;;)
    {
        if ( level.nextgen )
        {
            _func_0D3( "r_mbEnable", "2" );
            _func_0D3( "r_mbVelocityScalar", "1.25" );
        }

        common_scripts\utility::flag_wait( "exitdrive_lights_on" );
        common_scripts\utility::flag_set( "jetbike_dynfx_on" );
        var_0 = maps\_shg_utility::play_fx_with_handle( "det_dyn_spotlight_jetbike", self, "tag_headlight" );
        common_scripts\utility::flag_waitopen( "exitdrive_lights_on" );
        maps\_shg_utility::kill_fx_with_handle( var_0 );

        if ( level.nextgen )
            _func_0D3( "r_mbEnable", "0" );

        wait 0.05;
    }
}

exit_drive_jetbike_lights_ai()
{
    level.burke_bike thread maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
}

ending_mech_lighting()
{
    var_0 = getentarray( "gate_light_02_models", "targetname" );
    var_1 = getentarray( "gate_light_02_models_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 show();

    foreach ( var_6 in var_1 )
        var_6 hide();

    common_scripts\_exploder::exploder( 9125 );
    var_8 = common_scripts\utility::getstruct( "light_ending_rim", "targetname" );
    var_9 = common_scripts\utility::getstruct( "light_ending_key", "targetname" );
    var_10 = getent( "door_lights_script1", "targetname" );
    var_11 = getent( "heli_light_02", "targetname" );
    var_12 = getent( "ending_light_02", "targetname" );

    if ( isdefined( var_10 ) )
    {
        var_10.origin = var_8.origin;
        var_10 _meth_81DF( 320000 );
        var_10 _meth_8044( ( 1, 1, 1 ) );
        var_10 _meth_83DF( ( 0, -45, 0 ), 0.1 );
    }

    if ( isdefined( var_11 ) )
    {
        var_11 _meth_81DF( 600000 );
        var_11 _meth_8044( ( 1, 0.5, 0.25 ) );
    }

    if ( isdefined( var_12 ) )
    {
        var_12 _meth_81DF( 190000 );
        var_12 _meth_8044( ( 1, 0.5, 0.25 ) );
    }
}

move_mech_origins( var_0 )
{
    level waittill( "vfx_player_jetbike_stops" );
    wait 3;
    var_1 = common_scripts\utility::getstruct( "mech_new_origin2", "targetname" );
}

final_chopper_lighting( var_0 )
{
    var_1 = getent( "heli_light", "targetname" );
    wait 0.05;

    if ( isdefined( var_1 ) )
    {
        var_1 _meth_81DF( 28200000 );
        var_1 _meth_8044( ( 1, 0.9, 0.6 ) );
    }

    level.bones_bike maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
    level.joker_bike maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
    level.player _meth_84A9();
    level.player _meth_84AB( 15.5, 400 );

    if ( level.nextgen )
    {
        maps\_utility::lerp_saveddvar( "r_mbVelocityScalar", 1, 1 );
        wait 5;
        var_2 = getent( "reflection_white_bottom", "targetname" );
        var_0 _meth_83AB( var_2.origin );
    }
    else
        wait 5;

    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end", 2 );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 _meth_804D( var_0, "tag_light_nose", ( 60, 40, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "aircraft_light_wingtip_red_med" ), var_0, "tag_light_nose" );
    wait 5;

    if ( level.nextgen )
        maps\_utility::lerp_saveddvar( "r_mbVelocityScalar", 2, 1 );

    wait 1;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end_fire", 0.4 );
    wait 0.5;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end", 0.5 );
    wait 1.4;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end_fire", 0.25 );
    wait 1;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end", 0.5 );
    wait 0.65;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end_fire", 0.1 );
    wait 1.5;
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_end", 1.5 );
    level.player _meth_84AB( 2.5, 50 );
    wait 10;
    level.player _meth_84AB( 2.5, 60 );
}

gate_origin_change()
{
    var_0 = getent( "gate_lighting_origin", "targetname" );
    var_1 = getent( "detroit_entrance_gate", "targetname" );
    var_1 _meth_847B( var_0.origin );
}

jetbike_exit_pre_mount_lighting()
{
    common_scripts\_exploder::exploder( 9405 );
    var_0 = getentarray( "gate_top_lights1", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( level.nextgen )
            var_2 _meth_81DF( 10000 );
    }

    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_lightsoff" );
    maps\_utility::stop_exploder( 9405 );
}

sentinel_reveal_lighting()
{
    common_scripts\utility::flag_wait( "reveal_the_sentinels" );
    level.player _meth_84A9();
    level.player _meth_84AB( 1.5, 300 );
    wait 1;
    _func_072( 1, 1 );

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "detroit_sentinal", 3 );

    wait 2;
    _func_072( 0, 1 );
    level.player _meth_84AB( 5, 300 );
    thread maps\_lighting::lerp_spot_intensity( "sent_reveal_spot_blue", 4, 10000 );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "sentkeylight", 4, 1000 );

    _func_072( 0, 3 );

    if ( level.nextgen )
    {
        var_0 = getent( "sentkeylight", "targetname" );
        var_0 _meth_8020( 60, 50 );
    }

    wait 10;
    thread maps\_lighting::lerp_spot_intensity( "sent_reveal_spot_blue", 8, 200000 );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "sentkeylight", 4, 500 );
        thread maps\_lighting::lerp_spot_color( "sentkeylight", 0.15, ( 1, 1, 1 ) );
    }

    thread maps\_lighting::lerp_spot_radius( "sent_reveal_spot_blue", 3, 400 );
    wait 2;

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    wait 2;
    level.player _meth_84AB( 3, 32 );
    wait 4;
    level.player _meth_84AB( 3, 38 );
    wait 2;
    thread maps\_lighting::lerp_spot_intensity( "sent_reveal_spot_blue", 4, 50000 );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "sentkeylight", 4, 1000 );

    wait 8;
    thread maps\_lighting::lerp_spot_intensity( "sent_reveal_spot_blue", 2.5, 4000 );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "sentkeylight", 2.5, 0 );

    maps\_utility::vision_set_fog_changes( "detroit_city", 5 );
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

sentinel_reveal_lighting_origins( var_0 )
{
    var_1 = getent( "new_grenade_org", "targetname" );
    var_0 _meth_847B( var_1.origin );
}

outerspacelighting()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_useLightGridDefaultFXLightingLookup", 1 );
        _func_0D3( "r_useLightGridDefaultModelLightingLookup", 1 );
        _func_0D3( "r_lightGridDefaultFXLightingLookup", ( -1493.99, 7192.58, -96.875 ) );
        _func_0D3( "r_lightGridDefaultModelLightingLookup", ( -1493.99, 7192.58, -96.875 ) );
    }
}

mech_intro_gate_lighting( var_0 )
{
    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_804D( var_0, "J_Head", ( 0, 5, -5 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "det_point_rim_lrg" ), var_1, "tag_origin" );
    wait 20;
    wait 4;
    soundscripts\_snd::snd_message( "gate_lightning" );
}

mech_exit_gate_lighting( var_0 )
{
    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_804D( var_0, "J_Head", ( 0, 5, -5 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "det_point_rim_lrg" ), var_1, "tag_origin" );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "door_lights_script2", 10, 6000 );
        thread maps\_lighting::lerp_spot_intensity( "door_lights_script1", 10, 100000 );
    }
}

setup_vfx_sunflare()
{
    thread maps\_shg_fx::fx_spot_lens_flare_dir( "sunflare", ( -30, 85.5, 0 ), 10000 );
}

main_camp_spot()
{
    if ( level.nextgen )
    {
        wait 0.05;
        var_0 = getent( "courtyard_light_force", "targetname" );

        for (;;)
        {
            common_scripts\utility::flag_wait( "main_camp_spot_on" );
            var_0 _meth_8498( "force_on" );
            common_scripts\utility::flag_waitopen( "main_camp_spot_on" );
            var_0 _meth_8498( "force_off" );
        }
    }
}

warbird_intro_lighting( var_0 )
{
    var_0.interior_light = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.interior_light;
    var_1 _meth_804D( var_0, "TAG_burke_key_light", ( 0, 0, -35 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "point_white_med" ), var_1, "tag_origin" );
    wait 8;
    killfxontag( common_scripts\utility::getfx( "point_white_med" ), var_1, "tag_origin" );
}

vinette_overlay()
{
    level.player thread maps\_lighting::screen_effect_base( 0, "s1_railgun_hud_outer_shadow", 0, 0, 0.1, 0, 0, 3 );
    level waittill( "end_screen_effect" );
    level.overlay destroy();
}

turn_off_gold_light()
{
    var_0 = getent( "turn_off_gold_light", "targetname" );
    wait 8.75;
    var_0 _meth_81DF( 0 );
}

school_jeep_light_tgl()
{
    common_scripts\_exploder::exploder( 4123 );
    var_0 = getent( "car_light", "targetname" );
    common_scripts\utility::flag_wait( "school_player_falling" );
    var_0 _meth_81DF( 0 );
    common_scripts\_exploder::kill_exploder( 4123 );
}

turn_off_jeep_light()
{
    var_0 = getent( "car_light", "targetname" );
    var_0 _meth_81DF( 0 );
}

intro_lerp_sun()
{
    if ( level.nextgen )
    {
        wait 2;
        var_0 = anglestoforward( ( -33.942, 180, 0 ) );
        var_1 = anglestoforward( ( -65.942, 162, 0 ) );
        var_2 = vectornormalize( var_0 );
        var_3 = vectornormalize( var_1 );
        wait 3;
        lerpsundirection( var_2, var_3, 7 );
        wait 80;
        lerpsundirection( var_3, var_2, 17 );
        common_scripts\utility::flag_wait( "open_massive_door" );
        resetsundirection();
    }
}

capture_lighting()
{
    common_scripts\utility::flag_set( "capture_start" );
    maps\_utility::vision_set_fog_changes( "detroit_hospital_capture", 6 );
    wait 2;
    common_scripts\utility::flag_set( "red_dim" );
    common_scripts\_exploder::exploder( 9211 );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "officelamp", 1, 50 );
        thread maps\_lighting::lerp_spot_intensity( "bluemoon", 1, 2500 );
        thread maps\_lighting::lerp_spot_intensity( "bluemoonrim", 1, 1000 );
    }

    wait 1;
    level.player _meth_84A9();
    level.player _meth_84AB( 5.6, 100 );
    wait 1.2;

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "2.5" );
    }

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "officelamp", 1, 100 );
        thread maps\_lighting::lerp_spot_intensity( "bluemoon", 1, 500 );
        thread maps\_lighting::lerp_spot_intensity( "rim_capture", 1, 2500 );
        thread maps\_lighting::lerp_spot_intensity( "bluemoonrim", 1, 2500 );
    }

    wait 2.2;

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    wait 15;
    maps\_utility::lerp_saveddvar( "r_ssaoStrength", 0.45, 1 );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "rim_capture", 1, 0 );
        thread maps\_lighting::lerp_spot_intensity( "bluemoonrim", 1, 0 );
    }

    wait 1;
    common_scripts\utility::flag_clear( "red_dim" );
    level notify( "kill_burke_red_light" );
    level notify( "kill_joker_red_light" );
    maps\_utility::lerp_saveddvar( "r_ssaoStrength", 0.45, 1 );
    level.player _meth_84AA();
    maps\_utility::vision_set_fog_changes( "detroit_hospital_top", 4 );
}

exo_flicker_lighting()
{
    common_scripts\utility::flag_wait( "flicker_street_lights" );

    if ( level.nextgen )
    {
        maps\_lighting::play_flickerlight_preset( "street_light", "streetlight_01", 8000 );
        maps\_lighting::play_flickerlight_preset( "street_light", "streetlight_02", 9500 );
    }
    else
    {
        maps\_lighting::play_flickerlight_preset( "street_light", "streetlight_01", 100 );
        maps\_lighting::play_flickerlight_preset( "street_light", "streetlight_02", 500 );
    }
}

handshake_lighting()
{
    common_scripts\utility::flag_wait( "flag_scanner_doors_open" );
    wait 13;
    thread maps\_lighting::lerp_spot_intensity( "handshake_light", 1, 10 );
}

clut_manage()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "lightning_on" );
        level.player _meth_8490( "clut_detroit_exterior", 1 );
        common_scripts\utility::flag_waitopen( "lightning_on" );
        level.player _meth_8490( "clut_detroit_interior", 1 );
    }
}

clut_manage_school()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "lightning_on_school" );
        level.player _meth_8490( "clut_detroit_exterior", 1 );
        common_scripts\utility::flag_waitopen( "lightning_on_school" );
        level.player _meth_8490( "clut_detroit_interior", 1 );
    }
}

butress_origin_fix()
{
    var_0 = common_scripts\utility::getstruct( "low_walls_origin", "targetname" );
    var_1 = getent( "butress2", "targetname" );
    var_1 _meth_847B( var_0.origin );
}

blockage_lighting( var_0 )
{
    var_1 = getent( "burke_third_floor_corner_check_wait", "targetname" );
    var_0 _meth_847B( var_1.origin );
}

det_vignette()
{
    level.player thread maps\_lighting::screen_effect_base( 0, "ac130_overlay_pip_bottom_vignette", 0, 0, 1, 0, 3 );
}

cg_car_light_shadowstate_reset()
{
    var_0 = getent( "car_light", "targetname" );

    for (;;)
    {
        level maps\_utility::wait_for_targetname_trigger( "car_light_ssoff" );
        var_0 _meth_8498( "normal" );
    }
}

cg_car_light_shadowstate_on()
{
    var_0 = getent( "car_light", "targetname" );

    for (;;)
    {
        level maps\_utility::wait_for_targetname_trigger( "car_light_ssoon" );
        var_0 _meth_8498( "force_on" );
    }
}
