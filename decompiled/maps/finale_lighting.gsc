// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main2()
{
    thread set_level_lighting_values();
    thread manage_day_night();
    thread manage_dof();
    thread underwater_sunrays();
    thread init_level_lighting_flags();
    thread hide_on_models();
    thread motion_manage();
    thread trigger_canal_p1();
    thread trigger_canal_p2();
    thread trigger_silo_p1();
    thread trigger_enter_finale_silo_orange_approach();
    thread trigger_flashlight_off();
    thread trigger_enter_finale_silo_orange();
    thread trigger_enter_finale_silo_blue();
    thread cg_trigger_enter_finale_silo_yellow();
    thread cg_trigger_enter_finale_silo_neutral();
    thread trigger_enter_finale_silo_round_tunnel();
    thread trigger_enter_finale_silo_center();
    thread trigger_enter_vision_light_fog_normal();
    thread trigger_enter_finale_low_burn();
    thread trigger_science_room();
    thread trigger_ending();
    thread trigger_ending2();
    precacheshader( "ac130_overlay_pip_vignette" );
    thread setup_flickerlight_motion_presets();
    thread setup_flickerlight_presets2();
    thread trigger_silo_centroid_switch_floor3();
    thread trigger_silo_centroid_switch_top();
    thread atlas_sign_flicker();
}

init_level_lighting_flags()
{
    common_scripts\utility::flag_init( "first_half_lighting" );
    common_scripts\utility::flag_init( "second_half_lighting" );
    common_scripts\utility::flag_init( "turn_on_lights" );
    common_scripts\utility::flag_init( "flyin_mb" );
    common_scripts\utility::flag_init( "underwater_lighting" );
    common_scripts\utility::flag_init( "stair_lights_on" );
    common_scripts\utility::flag_init( "flag_dof_rocket_success_pt2_start" );
    common_scripts\utility::flag_init( "flag_lighting_rocket_success_pt2_gideon_run" );
    common_scripts\utility::flag_init( "flag_autofocus_on" );
    common_scripts\utility::flag_init( "lighting_target_dof" );
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
    }
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

lerp_angles_function( var_0, var_1, var_2 )
{
    var_0 notify( "stop lerp" );
    var_0 endon( "stop lerp" );
    var_0 endon( "death" );
    var_3 = var_0.angles;
    var_4 = 0;

    while ( var_4 < var_1 )
    {
        var_0.angles = vectorlerp( var_3, var_2, var_4 / var_1 );
        var_4 += 0.05;
        wait 0.05;
    }

    var_0.angles = var_2;
}

enable_motion_blur()
{
    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "2" );
}

enable_motion_blur_rotation()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
    }
}

disable_motion_blur()
{
    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );
}

setup_dof_presets()
{
    maps\_lighting::create_dof_preset( "fall", 10, 18, 10, 25, 150, 4, 0.5 );
}

setup_dof_viewmodel_presets()
{
    maps\_lighting::create_dof_viewmodel_preset( "bike_vm_dof", 10, 90 );
}

setup_flickerlight_presets()
{
    maps\_lighting::create_flickerlight_preset( "fire2", ( 0.972549, 0.62451, 1 ), ( 0.2, 0.146275, 1 ), 0.2, 1, 80000 );
}

setup_flickerlight_motion_presets()
{
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_red_burn", ( 1, 0.2246, 0 ), 32000, 20, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_red_burn_exhaust", ( 1, 0.2246, 0 ), 800000, 20, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_cold_burn", ( 1, 1, 1 ), 320000, 10, 0.03, 0.1 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_large_ending", ( 1, 0.3, 0 ), 1400000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_large_atlas", ( 1, 0.3, 0 ), 100000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_large_ending2", ( 1, 0.3, 0 ), 10000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_large_ending3", ( 1, 0.3, 0 ), 5000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_med_ending", ( 1, 0.3, 0 ), 30000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_med_ending2", ( 1, 0.3, 0 ), 6000, 7, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_med_ending3", ( 1, 0.2, 0.05 ), 5000, 7, 0.05, 0.2 );
}

setup_flickerlight_presets2()
{
    maps\_lighting::create_flickerlight_preset( "firelight_med_ending", ( 1, 0.2246, 0 ), ( 0.46, 0.16, 0.06 ), 0.005, 0.2, 8 );
    maps\_lighting::create_flickerlight_preset( "firelight_large_ending3", ( 1, 0.2246, 0 ), ( 0.46, 0.16, 0.06 ), 0.005, 0.2, 8 );
    maps\_lighting::create_flickerlight_preset( "firelight_med_ending2", ( 1, 0.2246, 0 ), ( 0.46, 0.16, 0.06 ), 0.005, 0.2, 8 );
}

manage_dof()
{
    if ( level.nextgen )
    {
        level.player _meth_84A9();
        level.player_dof_aperture = 4.5;
        level.player_dof_distance = 30;
    }
}

trigger_canal_p1()
{
    common_scripts\utility::run_thread_on_targetname( "canal_p1", ::canal_p1 );
}

canal_p1()
{
    for (;;)
    {
        self waittill( "trigger" );

        if ( level.nextgen )
        {
            maps\_utility::vision_set_fog_changes( "finale_underwater", 3 );
            level.player _meth_8490( "clut_finale_underwater", 0 );
            level.player _meth_83C0( "underwater_lightset" );
        }
        else if ( level.currentgen )
        {
            maps\_utility::vision_set_fog_changes( "finale_underwater", 0.1 );
            level.player _meth_83C0( "underwater_lightset" );
        }

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_canal_p2()
{
    common_scripts\utility::run_thread_on_targetname( "canal_p2", ::canal_p2 );
}

canal_p2()
{
    for (;;)
    {
        self waittill( "trigger" );
        maps\_utility::vision_set_fog_changes( "finale_underwater_darkfog", 3 );
        level.player _meth_83C0( "canal_p2" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_silo_p1()
{
    common_scripts\utility::run_thread_on_targetname( "silo_p1", ::silo_p1 );
}

silo_p1()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "finale_silo_orange" );
        maps\_utility::vision_set_fog_changes( "finale_silo_orange", 0 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_flashlight_off()
{
    common_scripts\utility::run_thread_on_targetname( "trig_flashlight_off", ::play_trigger_flashlight_off );
}

play_trigger_flashlight_off()
{
    for (;;)
    {
        self waittill( "trigger" );
        common_scripts\utility::flag_clear( "underwater_flashlight" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_silo_orange_approach()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_orange_approach", ::play_finale_silo_orange_approach );
}

play_finale_silo_orange_approach()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "clut_finale_orange_silo_approach_density", 2 );
        level.player _meth_83C0( "finale_silo_orange" );
        maps\_utility::vision_set_fog_changes( "finale_silo_orange", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_silo_orange()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_orange", ::play_finale_silo_orange );
}

play_finale_silo_orange()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 2 );
        level.player _meth_83C0( "finale_silo_orange" );
        maps\_utility::vision_set_fog_changes( "finale_silo_orange", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_silo_blue()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_blue", ::play_finale_silo_blue );
}

play_finale_silo_blue()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "clut_finale_silo_blue", 2 );
        level.player _meth_83C0( "finale_silo_blue" );
        maps\_utility::vision_set_fog_changes( "finale_silo_blue", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

cg_trigger_enter_finale_silo_yellow()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_yellow", ::play_finale_silo_yellow );
}

play_finale_silo_yellow()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 2 );
        level.player _meth_83C0( "finale_silo_orange" );
        maps\_utility::vision_set_fog_changes( "finale_silo_yellow", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

cg_trigger_enter_finale_silo_neutral()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_neutral", ::play_finale_silo_neutral );
}

play_finale_silo_neutral()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 2 );
        level.player _meth_83C0( "finale_silo_orange" );
        maps\_utility::vision_set_fog_changes( "finale_silo_neutral", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_silo_round_tunnel()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_round_tunnel", ::play_finale_silo_round_tunnel );
}

play_finale_silo_round_tunnel()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "clut_finale_round_tunnel", 2 );
        level.player _meth_83C0( "finale_silo_blue" );
        maps\_utility::vision_set_fog_changes( "finale_silo_blue", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_silo_center()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_silo_center", ::play_finale_silo_center );
}

play_finale_silo_center()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 2 );
        setsunflareposition( ( -64.7, 29.9, 0 ) );
        level.player _meth_83C0( "finale_silo_center" );
        maps\_utility::vision_set_fog_changes( "finale_silo_center", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_vision_light_fog_normal()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_normal", ::play_vision_light_fog_normal );
}

play_vision_light_fog_normal()
{
    for (;;)
    {
        self waittill( "trigger" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_enter_finale_low_burn()
{
    common_scripts\utility::run_thread_on_targetname( "trig_fog_low_burn", ::play_finale_low_burn );
}

trigger_science_room()
{
    common_scripts\utility::run_thread_on_targetname( "science_room", ::science_room );
}

science_room()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "finale_will_litend" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_ending()
{
    common_scripts\utility::run_thread_on_targetname( "ending", ::ending );
}

ending()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "finale_night" );
        level notify( "leave_will_room" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_ending2()
{
    common_scripts\utility::run_thread_on_targetname( "ending2", ::ending2 );
}

ending2()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "finale_night2" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_silo_centroid_switch_floor3()
{
    common_scripts\utility::run_thread_on_targetname( "trig_silo_centroid_switch_floor3", ::play_centroid_switch_floor3 );
}

play_centroid_switch_floor3()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread main_missle_lighting_floor3();

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

trigger_silo_centroid_switch_top()
{
    common_scripts\utility::run_thread_on_targetname( "trig_silo_centroid_switch_top", ::play_centroid_switch_top );
}

play_centroid_switch_top()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread main_missle_lighting_silotop();

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

debug_silo_approach_clut()
{
    wait 0.05;
    level.player _meth_8490( "clut_finale_orange_silo_approach_density", 1 );
}

debug_silo_floor_03_clut()
{
    wait 0.05;
    level.player _meth_8490( "clut_finale_silo_blue", 1 );
}

debug_silo_door_kick_clut()
{
    wait 0.05;
    level.player _meth_8490( "", 2 );
}

debug_silo_exhaust_entrance_clut()
{
    wait 0.05;
    level.player _meth_8490( "clut_finale_round_tunnel", 1 );
}

hatch_lighting()
{
    enable_motion_blur();
    thread hatch_dof();
    level.player _meth_83C0( "finale_hatch" );
    maps\_utility::vision_set_fog_changes( "finale_hatch", 2 );
    common_scripts\_exploder::exploder( "4000" );
    wait 1.5;
    level.player _meth_8490( "clut_finale_silo_shaft", 2 );
}

hatch_dof()
{
    thread hatch_land_blur();
    level.player _meth_84A9();
    _func_0D3( "r_dof_physical_bokehEnable", 1 );
    level.player _meth_84AB( 12, 33 );
    wait 1;
    level.player _meth_84AB( 1.5, 33, 1, 2 );
}

hatch_land_blur()
{
    common_scripts\utility::flag_wait( "flag_lighting_fall_blur" );
    wait 0.5;
    _func_072( 40, 0.5 );
    wait 0.1;
    _func_072( 0, 0.8 );
}

play_finale_low_burn()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_84AB( 12, 33, 1, 2 );
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
        setsunflareposition( ( 0, 180, 0 ) );
        level.player _meth_8490( "clut_finale_burn_pre", 4 );
        var_0 = getent( "light_rocket_exhaust", "targetname" );
        maps\_lighting::set_spot_intensity( "light_rocket_exhaust", 4000 );
        maps\_lighting::set_spot_color( "light_rocket_exhaust", ( 0.156863, 0.313726, 0.847059 ) );
        level.player _meth_83C0( "finale_low_burn" );
        maps\_utility::vision_set_fog_changes( "finale_low_burn", 2 );
        var_1 = common_scripts\utility::getstruct( "struct_light_silo_cine_low_burn_rim", "targetname" );
        var_2 = getent( "light_rocket_rim", "targetname" );
        maps\_lighting::set_spot_intensity( "light_rocket_rim", 300000 );
        maps\_lighting::set_spot_color( "light_rocket_rim", ( 0.255, 0.376, 1 ) );
        var_2 maps\_lighting::lerp_light_fov_range( 30, 5, 30, 1, 0.05 );
        var_2 _meth_8046( 285 );
        wait 5;
        lerp_origin_function( var_2, 0.05, var_1.origin );
        lerp_angles_function( var_2, 0.05, var_1.angles );
        common_scripts\_exploder::kill_exploder( "4000" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

red_burn_lighting_fog()
{
    var_0 = getent( "light_rocket_exhaust", "targetname" );
    level.player _meth_8490( "clut_finale_burn_red", 2.6 );
    level.player _meth_83C0( "finale_red_burn" );
    maps\_utility::vision_set_fog_changes( "finale_red_burn", 2.6 );
    var_0 maps\_lighting::lerp_light_fov_range( 90, 60, 30, 5, 0.05 );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_red_burn_exhaust", "light_rocket_exhaust" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_red_burn", "light_rocket_thrusters" );
}

cold_burn_lighting_fog()
{
    level.player _meth_8490( "", 1 );
    level.player _meth_83C0( "finale_cold_burn" );
    maps\_utility::vision_set_fog_changes( "finale_cold_burn", 8 );
    maps\_lighting::stop_flickerlight( "firelight_motion_red_burn", "light_rocket_exhaust", 0 );
    maps\_lighting::stop_flickerlight( "firelight_motion_red_burn", "light_rocket_thrusters", 0 );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_cold_burn", "light_rocket_exhaust" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_cold_burn", "light_rocket_thrusters" );
    thread rocket_fail_lighting();
}

rocket_success_lighting_pre_cine()
{
    common_scripts\utility::flag_wait( "lighting_flag_obj_stop_missile_complete" );
    level.player _meth_83C0( "finale_silo_end_cine" );
    maps\_utility::vision_set_fog_changes( "finale_silo_end_cine", 10 );
    maps\_lighting::pause_flickerlight( "firelight_motion_cold_burn", "light_rocket_exhaust" );
    maps\_lighting::pause_flickerlight( "firelight_motion_cold_burn", "light_rocket_thrusters" );
    maps\_lighting::lerp_spot_intensity( "light_rocket_thrusters", 2, 8000 );
    maps\_lighting::lerp_spot_color( "light_rocket_thrusters", 2, ( 1, 0.608, 0.459 ) );
    wait 0.5;
    setsunflareposition( ( 278.8, 602, 0 ) );
}

rocket_success_dof_debugging( var_0 )
{
    iprintlnbold( "dof timing debug START" );
    wait 1.65;
    iprintlnbold( "ground hit" );
    wait 3.75;
    iprintlnbold( "rocket left direction switch" );
    wait 10.2;
    iprintlnbold( "Gideon enter (whole head just in frame" );
}

rocket_success_pt2_lighting_debugging( var_0 )
{
    common_scripts\utility::flag_set( "flag_dof_rocket_success_pt2_start" );
}

rocket_success_pt2_gideon_in_frame( var_0 )
{
    common_scripts\utility::flag_set( "flag_lighting_rocket_success_pt2_gideon_run" );
}

rocket_cine_dof( var_0 )
{
    level.player _meth_84A9();
    _func_0D3( "r_dof_physical_bokehEnable", 1 );
    enable_motion_blur_rotation();
    level.player _meth_84AB( 12, 100 );
    wait 2;
    level.player _meth_84AB( 1.5, 36, 5, 2 );
    wait 2;
    level.player _meth_84AB( 1.5, 500, 5, 2 );
    wait 1;
    level.player _meth_84AB( 0.3, 72, 5, 2 );
    wait 1;
    level.player _meth_84AB( 1.5, 600, 5, 2 );
    wait 2.5;
    level.player _meth_84AB( 0.5, 72, 5, 2 );
    common_scripts\utility::flag_wait( "flag_dof_rocket_success_pt2_start" );
    level.player _meth_84AB( 2.5, 22, 5, 2 );
    wait 3;
    level.player _meth_84AB( 4, 85, 10, 10 );
    wait 0.5;
    level.player _meth_84AB( 1.5, 43, 2, 4 );
    wait 1;
    level.player _meth_84AB( 1, 21, 1, 2 );
    wait 1;
    level.player _meth_84AB( 2.5, 22, 5, 2 );
    wait 4.25;
    level.player _meth_84AB( 2, 21.5, 5, 2 );
    wait 1.25;
    level.player _meth_84AB( 2.5, 23, 5, 2 );
    wait 2;
    level.player _meth_84AB( 2.5, 27.2, 5, 2 );
    wait 1.75;
    level.player _meth_84AB( 2.5, 23.8, 5, 2 );
    wait 2;
    level.player _meth_84AB( 2.5, 27.3, 5, 2 );
    wait 1;
    level.player _meth_84AB( 2.5, 13.6, 5, 2 );
    wait 4;
    _func_0D3( "r_dof_physical_bokehEnable", 0 );
    level.player _meth_84AA();
    disable_motion_blur();
}

play_finale_silo_end_cine()
{
    level.player _meth_83C0( "finale_silo_end_cine" );
    maps\_utility::vision_set_fog_changes( "finale_silo_end_cine", 1 );
    var_0 = getent( "light_rocket_exhaust", "targetname" );
    var_1 = getent( "light_rocket_thrusters", "targetname" );
    var_2 = getent( "light_rocket_rim", "targetname" );
    var_0 _meth_8498( "force_on" );
    var_1 _meth_8498( "force_on" );
    var_2 _meth_8498( "force_on" );
    var_3 = common_scripts\utility::getstruct( "struct_light_silo_cine_key_1", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_light_silo_cine_key_2_alt3", "targetname" );
    var_5 = common_scripts\utility::getstruct( "struct_light_silo_cine_key_2", "targetname" );
    var_6 = common_scripts\utility::getstruct( "struct_light_silo_cine_key_2_alt2", "targetname" );
    var_7 = common_scripts\utility::getstruct( "struct_light_silo_cine_fill_1", "targetname" );
    var_8 = common_scripts\utility::getstruct( "struct_light_silo_cine_fill_2", "targetname" );
    var_9 = common_scripts\utility::getstruct( "struct_light_silo_cine_rim_1", "targetname" );
    var_10 = common_scripts\utility::getstruct( "struct_light_silo_cine_rim_2", "targetname" );
    var_11 = common_scripts\utility::getstruct( "struct_light_silo_cine_rim_2_alt1", "targetname" );
    var_12 = common_scripts\utility::getstruct( "struct_light_silo_cine_rim_2_alt2", "targetname" );
    level.player _meth_83C0( "finale_silo_end_cine" );
    maps\_utility::vision_set_fog_changes( "finale_silo_end_cine", 1 );
    maps\_lighting::stop_flickerlight( "firelight_motion_cold_burn", "light_rocket_thrusters", 0 );
    maps\_lighting::stop_flickerlight( "firelight_motion_cold_burn", "light_rocket_exhaust", 0 );
    maps\_lighting::set_spot_intensity( "light_rocket_exhaust", 240000 );
    maps\_lighting::set_spot_color( "light_rocket_exhaust", ( 0.352, 0.541, 1 ) );
    var_0 maps\_lighting::lerp_light_fov_range( 30, 5, 85, 15, 0.05 );
    lerp_origin_function( var_0, 0.05, var_4.origin );
    lerp_angles_function( var_0, 0.05, var_4.angles );
    maps\_lighting::set_spot_intensity( "light_rocket_thrusters", 10000 );
    maps\_lighting::set_spot_color( "light_rocket_thrusters", ( 0.565, 0.643, 0.937 ) );
    var_1 maps\_lighting::lerp_light_fov_range( 90, 60, 35, 1, 0.05 );
    lerp_origin_function( var_1, 0.05, var_7.origin );
    lerp_angles_function( var_1, 0.05, var_7.angles );
    maps\_lighting::set_spot_intensity( "light_rocket_rim", 20000 );
    maps\_lighting::set_spot_color( "light_rocket_rim", ( 0.75, 0.5, 0.4 ) );
    var_2 maps\_lighting::lerp_light_fov_range( 90, 60, 25, 5, 0.05 );
    lerp_origin_function( var_2, 0.05, var_9.origin );
    lerp_angles_function( var_2, 0.05, var_9.angles );
    common_scripts\utility::flag_wait( "flag_lighting_rocket_success_pt2_gideon_run" );
    wait 5;
    maps\_lighting::set_spot_intensity( "light_rocket_rim", 250000 );
    maps\_lighting::set_spot_color( "light_rocket_rim", ( 0.352, 0.541, 1 ) );
    var_2 maps\_lighting::lerp_light_fov_range( 25, 5, 40, 18, 0.05 );
    lerp_origin_function( var_2, 0.05, var_10.origin );
    lerp_angles_function( var_2, 0.05, var_10.angles );
    maps\_lighting::lerp_spot_intensity( "light_rocket_exhaust", 0.3, 1 );
    maps\_lighting::set_spot_color( "light_rocket_exhaust", ( 0.92, 0.729, 0.698 ) );
    var_0 maps\_lighting::lerp_light_fov_range( 85, 15, 35, 1, 0.05 );
    lerp_origin_function( var_0, 0.05, var_6.origin );
    lerp_angles_function( var_0, 0.05, var_6.angles );
    maps\_lighting::set_spot_intensity( "light_rocket_thrusters", 4000 );
    maps\_lighting::set_spot_color( "light_rocket_thrusters", ( 0.447, 0.572, 1 ) );
    var_1 maps\_lighting::lerp_light_fov_range( 90, 60, 35, 1, 0.05 );
    lerp_origin_function( var_1, 0.05, var_8.origin );
    lerp_angles_function( var_1, 0.05, var_8.angles );
    wait 0.7;
    wait 0.5;
    maps\_lighting::lerp_spot_intensity( "light_rocket_rim", 0.1, 0 );
    wait 0.1;
    thread maps\_lighting::set_spot_color( "light_rocket_rim", ( 0.1607, 0.3921, 1 ) );
    var_2 maps\_lighting::lerp_light_fov_range( 25, 5, 10, 1, 0.05 );
    thread maps\_lighting::lerp_spot_radius( "light_rocket_rim", 0.05, 170 );
    lerp_origin_function( var_2, 0.05, var_12.origin );
    lerp_angles_function( var_2, 0.05, var_12.angles );
    thread maps\_lighting::lerp_spot_intensity( "light_rocket_rim", 0.3, 2000000 );
    thread maps\_lighting::lerp_spot_intensity( "light_rocket_exhaust", 0.3, 1500 );
    wait 2;
    wait 4;
    var_0 _meth_8498( "normal" );
    var_1 _meth_8498( "normal" );
    var_2 _meth_8498( "normal" );
}

rocket_fail_lighting()
{
    common_scripts\utility::flag_wait( "lighting_missile_fail" );
    maps\_lighting::pause_flickerlight( "firelight_motion_cold_burn", "light_rocket_exhaust" );
    maps\_lighting::pause_flickerlight( "firelight_motion_cold_burn", "light_rocket_thrusters" );
    var_0 = getent( "light_rocket_exhaust", "targetname" );
    var_1 = getent( "light_rocket_thrusters", "targetname" );
    var_2 = common_scripts\utility::getstruct( "struct_light_silo_cine_fail_highdown", "targetname" );
    maps\_lighting::set_spot_intensity( "light_rocket_thrusters", 320000 );
    maps\_lighting::set_spot_color( "light_rocket_thrusters", ( 1, 1, 1 ) );
    maps\_lighting::set_spot_intensity( "light_rocket_thrusters", 320000 );
    maps\_lighting::set_spot_color( "light_rocket_thrusters", ( 1, 1, 1 ) );
    maps\_lighting::lerp_spot_intensity( "light_rocket_exhaust", 4.5, 0 );
    var_0 maps\_lighting::lerp_light_fov_range( 30, 5, 90, 15, 0.05 );
    thread move_god_rays_rocket_fail();
    maps\_lighting::lerp_spot_intensity( "light_rocket_exhaust", 1, 1300000 );
    thread spot_exhaust_fail_orig();
    lerp_angles_function( var_1, 0.05, var_2.angles );
    lerp_origin_function( var_1, 5, var_2.origin );
}

move_god_rays_rocket_fail()
{
    var_0 = ( 0, 180, 0 );
    var_1 = ( -90, 180, 0 );
    var_2 = 5.0;

    for ( var_3 = 0; var_3 < var_2; var_3 += 0.05 )
    {
        var_4 = var_3 / var_2;
        var_5 = vectorlerp( var_0, var_1, var_4 );
        thread maps\_shg_fx::set_sun_flare_position( var_5 );
        wait 0.05;
    }
}

spot_exhaust_fail_angles()
{
    var_0 = common_scripts\utility::getstruct( "struct_light_silo_cine_fail_highdown", "targetname" );
    var_1 = getent( "light_rocket_exhaust", "targetname" );
    lerp_angles_function( var_1, 0.05, var_0.angles );
}

spot_exhaust_fail_orig()
{
    var_0 = common_scripts\utility::getstruct( "struct_light_silo_cine_fail_highdown", "targetname" );
    var_1 = getent( "light_rocket_exhaust", "targetname" );
    lerp_origin_function( var_1, 5, var_0.origin );
}

test_sun_flare()
{
    thread maps\_shg_fx::vfx_sunflare( "finale_sun_flare" );
}

manage_day_night()
{
    wait 0.05;

    if ( common_scripts\utility::flag( "first_half_lighting" ) == 1 )
    {
        _func_0D3( "r_useLightGridDefaultFXLightingLookup", 1 );
        _func_0D3( "r_useLightGridDefaultModelLightingLookup", 1 );
        _func_0D3( "r_lightGridDefaultFXLightingLookup", ( -702, -7842, 202 ) );
        _func_0D3( "r_lightGridDefaultModelLightingLookup", ( -702, -7842, 202 ) );
        common_scripts\utility::flag_waitopen( "first_half_lighting" );
        _func_0D3( "r_useLightGridDefaultFXLightingLookup", 1 );
        _func_0D3( "r_useLightGridDefaultModelLightingLookup", 1 );
        _func_0D3( "r_lightGridDefaultFXLightingLookup", ( 15286.3, -87020.1, 7820.69 ) );
        _func_0D3( "r_lightGridDefaultModelLightingLookup", ( 15286.3, -87020.1, 7820.69 ) );
    }
    else
    {
        _func_0D3( "r_useLightGridDefaultFXLightingLookup", 1 );
        _func_0D3( "r_useLightGridDefaultModelLightingLookup", 1 );
        _func_0D3( "r_lightGridDefaultFXLightingLookup", ( 15286.3, -87020.1, 7820.69 ) );
        _func_0D3( "r_lightGridDefaultModelLightingLookup", ( 15286.3, -87020.1, 7820.69 ) );
    }
}

hide_on_models()
{
    wait 0.05;
    var_0 = [ "will_room_model_on_03_bright", "will_room_model_on_07_bright", "will_room_model_on_06_bright", "will_room_model_on_09_bright" ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "targetname" ) )
            var_4 hide();
    }

    for ( var_7 = 1; var_7 <= 9; var_7++ )
    {
        var_8[var_7] = getentarray( "will_room_model_on_0" + var_7, "targetname" );

        foreach ( var_10 in var_8[var_7] )
            var_10 hide();

        wait 0.05;
    }
}

turn_on_lab_lights_scriptable()
{
    level.player thread maps\_lighting::screen_effect_base( 0, "ac130_overlay_pip_vignette", 0, 0, 1, 0, 0 );
    level.lighting_origin = getent( "tube_on", "targetname" );
    _func_0D3( "r_adaptivesubdiv", 0 );
    var_0 = getentarray( "light_strips_on", "targetname" );
    var_1 = getentarray( "light_strips_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 hide();

    foreach ( var_3 in var_1 )
        var_3 show();

    common_scripts\utility::flag_wait( "turn_on_lights" );

    foreach ( var_3 in var_0 )
        var_3 show();

    foreach ( var_3 in var_1 )
        var_3 hide();

    maps\_lighting::set_spot_intensity( "light_will_room_exit", 100000 );
    maps\_lighting::set_spot_intensity( "door_bright", 600000 );
    common_scripts\_exploder::exploder( "lighton" );
    wait 70;
    maps\_utility::vision_set_fog_changes( "finale_roof", 5 );
    _func_0D3( "r_adaptivesubdiv", 1 );
    level.player _meth_83C0( "finale_will_litend" );
}

animated_lights( var_0 )
{
    var_1 = maps\_lighting::setup_scriptable_primary_light( "will_key_light", 0, ( 141.1, -204, -24.78 ), ( 25.9, 85, 0 ), 3000, ( 0.4, 0.7, 1 ), 70, 120, level.lighting_origin, "tag_origin", 250 );
    var_2 = maps\_lighting::setup_scriptable_primary_light( "will_rim_light", 2, ( 206.5, -179.112, -36.9 ), ( 4.4, 170, 0 ), 5000, ( 0.55, 0.8, 1 ), 30, 80, level.lighting_origin, "tag_origin", 150 );
    var_3 = maps\_lighting::setup_scriptable_primary_light( "will_back_light", 3, ( 109.12, -76.21, -2.06 ), ( 20, -69, 0 ), 10500, ( 0.26, 0.54, 1 ), 30, 80, level.lighting_origin, "tag_origin", 150 );
    maps\_lighting::execute_scriptable_primary_light( var_1 );
    maps\_lighting::execute_scriptable_primary_light( var_2 );
    maps\_lighting::execute_scriptable_primary_light( var_3 );
    wait 1.9;
    maps\_lighting::stop_scriptable_primary_light( var_1 );
    maps\_lighting::stop_scriptable_primary_light( var_2 );
    maps\_lighting::stop_scriptable_primary_light( var_3 );
    wait 0.9;
    thread maps\_lighting::lerp_spot_intensity( "will_back_light", 0.5, 420000 );
    wait 0.45;
    thread maps\_lighting::lerp_spot_intensity( "will_back_light", 1, 0 );
    common_scripts\utility::flag_wait( "turn_on_lights" );
    thread maps\_lighting::lerp_spot_intensity( "will_fill_light", 1, 45000 );
    thread maps\_lighting::lerp_spot_color( "will_fill_light", 1, ( 0.68, 0.8, 1 ) );
    maps\_utility::vision_set_fog_changes( "finale_cinematic", 0 );
    level.player _meth_83C0( "finale_will_lit_bright" );
    wait 0.05;
    level.player _meth_83C0( "finale_will_lit" );
    var_4 = maps\_lighting::setup_scriptable_primary_light( "will_key_light", 0, ( 93.6, -142.9, 24.08 ), ( 31.6, -8, 0 ), 5000, ( 1, 0.9, 0.85 ), 70, 120, level.lighting_origin, "tag_origin", 200 );
    var_5 = maps\_lighting::setup_scriptable_primary_light( "will_rim_light", 2, ( 136.95, -265.679, 54.899 ), ( 21.24, 82.3, 0 ), 60000.5, ( 1, 0.95, 0.95 ), 30, 80, level.lighting_origin, "tag_origin", 250 );
    var_6 = maps\_lighting::setup_scriptable_primary_light( "will_back_light", 3, ( 220.99, -112.189, -17.25 ), ( 13, -162, 0 ), 250700, ( 0.45, 0.6, 1 ), 30, 80, level.lighting_origin, "tag_origin", 150 );
    maps\_lighting::execute_scriptable_primary_light( var_4 );
    maps\_lighting::execute_scriptable_primary_light( var_5 );
    maps\_lighting::execute_scriptable_primary_light( var_6 );
    wait 1;
    maps\_lighting::stop_scriptable_primary_light( var_4 );
    maps\_lighting::stop_scriptable_primary_light( var_5 );
    maps\_lighting::stop_scriptable_primary_light( var_6 );
    wait 5;
    wait 12.5;
    thread maps\_lighting::lerp_spot_intensity( "will_back_light", 7, 25700 );
    wait 13.5;
    thread maps\_lighting::lerp_spot_intensity( "will_back_light", 6, 70700 );
    wait 7;
    thread maps\_lighting::lerp_spot_intensity( "will_back_light", 6, 25700 );
}

turn_on_lab_lights()
{
    wait 8;
    var_0 = getent( "will_key_light", "targetname" );
    var_0 _meth_81DF( 100000 );
    var_0 _meth_8044( ( 0.4, 0.7, 1 ) );
    var_1 = getent( "will_fill_light", "targetname" );
    var_1 _meth_81DF( 5000 );
    var_1 _meth_8044( ( 0.4, 0.7, 1 ) );
    var_2 = getent( "will_rim_light", "targetname" );
    var_2 _meth_81DF( 100000 );
    var_2 _meth_8044( ( 0.55, 0.8, 1 ) );
    var_2 _meth_8046( 250 );

    for ( var_3 = 1; var_3 <= 9; var_3++ )
    {
        var_4[var_3] = getentarray( "will_room_model_on_0" + var_3, "targetname" );

        foreach ( var_6 in var_4[var_3] )
            var_6 hide();
    }

    for ( var_3 = 1; var_3 <= 8; var_3++ )
    {
        var_8[var_3] = getentarray( "will_room_model_off_0" + var_3, "targetname" );

        foreach ( var_10 in var_8[var_3] )
            var_10 hide();

        var_4[var_3] = getentarray( "will_room_model_on_0" + var_3, "targetname" );

        foreach ( var_13 in var_4[var_3] )
            var_13 show();

        var_15 = "811" + var_3;
        common_scripts\_exploder::exploder( var_15 );
        wait 1;
    }

    wait 15;
    thread maps\_lighting::lerp_spot_intensity( "will_rim_light", 6, 700000 );
    wait 5;
    thread maps\_lighting::lerp_spot_radius( "will_key_light", 8, 240 );
    thread maps\_lighting::lerp_spot_radius( "will_fill_light", 8, 240 );
    wait 90;
    common_scripts\utility::flag_wait( "stair_lights_on" );
    thread maps\_lighting::lerp_spot_intensity( "will_key_light", 3, 500000 );
    thread maps\_lighting::lerp_spot_intensity( "will_fill_light", 3, 10000 );
    wait 15;
    maps\_utility::vision_set_fog_changes( "finale_roof", 2 );
}

underwater_reflection()
{
    var_0 = getent( "reflection_underwater_green", "targetname" );
}

underwater_sunrays()
{
    for (;;)
    {
        thread maps\_lighting::lerp_spot_intensity_array( "sun_ray", 3, 1000000 );
        wait 3;
        thread maps\_lighting::lerp_spot_intensity_array( "sun_ray", 3, 500000 );
        wait 3;
        thread maps\_lighting::lerp_spot_intensity_array( "sun_ray", 1, 200000 );
        wait 2;
    }
}

motion_manage()
{
    if ( level.nextgen )
    {
        wait 0.05;

        if ( common_scripts\utility::flag( "flyin_mb" ) == 1 )
        {
            _func_0D3( "r_mbEnable", "3" );
            _func_0D3( "r_mbvelocityscalar", ".5" );
            common_scripts\utility::flag_waitopen( "flyin_mb" );
            _func_0D3( "r_mbEnable", "0" );
        }
        else
            _func_0D3( "r_mbEnable", "0" );
    }
}

setup_final_lighting()
{
    var_0 = getent( "key", "targetname" );
    var_1 = getent( "rim", "targetname" );
    var_2 = getent( "fill", "targetname" );
}

enable_physical_dof()
{

}

disable_physical_dof()
{

}

enable_physical_dof_hip()
{
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 0.125 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.1 );
}

dof_intro()
{
    level.player _meth_84A9();
    level.player _meth_84AB( 1.5, 200 );
    common_scripts\utility::flag_wait( "flag_intro_flyin_done" );
    level.player _meth_84AA();
}

dof_outro()
{
    level.player _meth_84A9();
    level.player _meth_84AB( 0.5, 50 );
}

light_ending_cinematic()
{
    var_0 = getent( "will_lighting_org", "targetname" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0.origin;
    level.player thread maps\_lighting::screen_effect_base( 0, "ac130_overlay_pip_vignette", 0, 0, 1, 0, 0 );
    thread light_ending_cinematic_dof();
    wait 10;
    wait 0.05;
}

light_ending_cinematic_dof()
{
    level.player _meth_84A9();
    wait 0.5;
    level.player _meth_84AB( 4.5, 4 );
    wait 0.5;
    level.player _meth_84AB( 5.5, 60 );
    wait 1;
    level.player _meth_84AB( 2.5, 40 );
    level.player _meth_83C0( "finale_night_cinematic" );
    wait 10.3;

    if ( level.nextgen )
        level.player _meth_84AA();

    level waittill( "dof_look_down" );

    if ( level.nextgen )
        level.player _meth_84A9();

    level.player _meth_84AB( 2.5, 40 );
    common_scripts\utility::flag_wait( "arm_off" );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbvelocityscalar", "3" );
    level.player _meth_84AB( 4.5, 1290 );
    level waittill( "irons_dead" );
    _func_0D3( "r_mbEnable", "0" );
    wait 3.5;
    level.player _meth_84AB( 8.5, 16.5 );
    wait 5.5;
    level.player _meth_84AB( 8.5, 16.5 );
    wait 6;
    level.player _meth_84AB( 4.5, 1290 );
    wait 4;
    level.player _meth_84AB( 4.5, 1290 );
    wait 15.25;
    level.player _meth_84AB( 8, 16 );
    wait 3;
    level.player _meth_84AB( 5, 300 );
}

will_room_speech_end()
{
    common_scripts\utility::flag_wait( "turn_on_lights" );
    var_0 = getentarray( "will_room_model_on_03", "targetname" );
    var_1 = [ "will_room_model_on_03", "will_room_model_on_07", "will_room_model_on_06", "will_room_model_on_09" ];

    foreach ( var_3 in var_1 )
    {
        foreach ( var_5 in getentarray( var_3, "targetname" ) )
            var_5 hide();
    }

    var_8 = [ "will_room_model_on_03_bright", "will_room_model_on_07_bright", "will_room_model_on_06_bright", "will_room_model_on_09_bright" ];

    foreach ( var_3 in var_8 )
    {
        foreach ( var_5 in getentarray( var_3, "targetname" ) )
            var_5 show();
    }

    common_scripts\_exploder::kill_exploder( 8113 );
    common_scripts\utility::flag_wait( "stair_lights_on" );
}

lighting_will_reveal()
{
    level.player _meth_83C0( "finale_will" );
    maps\_utility::vision_set_fog_changes( "finale_cinematic_nofog", 2 );
    thread turn_on_lab_lights_scriptable();
}

missle_lighting( var_0 )
{
    var_1 = getent( "org_missile_corridor_origin", "targetname" );
    var_2 = getent( "script_origin_rocket_top", "targetname" );

    foreach ( var_4 in var_0 )
        var_4 _meth_847B( var_1.origin );
}

main_missle_lighting_silotop()
{
    var_0 = getent( "org_missile_corridor_origin", "targetname" );
    var_1 = getent( "script_origin_rocket_top", "targetname" );
    var_2 = getent( "missile_top", "targetname" );
    var_3 = getent( "missile_mid_01", "targetname" );
    var_4 = getent( "missile_mid_02", "targetname" );
    var_5 = getent( "missile_bottom", "targetname" );
    var_2 _meth_847B( var_1.origin );
    var_3 _meth_847B( var_1.origin );
    var_4 _meth_847B( var_1.origin );
    var_5 _meth_847B( var_1.origin );
}

main_missle_lighting_floor3()
{
    var_0 = getent( "org_missile_corridor_origin", "targetname" );
    var_1 = getent( "script_origin_rocket_top", "targetname" );
    var_2 = getent( "missile_top", "targetname" );
    var_3 = getent( "missile_mid_01", "targetname" );
    var_4 = getent( "missile_mid_02", "targetname" );
    var_5 = getent( "missile_bottom", "targetname" );
    var_2 _meth_847B( var_0.origin );
    var_3 _meth_847B( var_0.origin );
    var_4 _meth_847B( var_0.origin );
    var_5 _meth_847B( var_0.origin );
}

s_flicker_catwalk_alarm()
{
    thread main_missle_lighting_floor3();
    var_0 = getent( "alarm_catwalk_01", "targetname" );
    var_1 = getent( "alarm_catwalk_02", "targetname" );
    var_2 = getent( "alarm_catwalk_03", "targetname" );
    var_3 = getent( "alarm_catwalk_04", "targetname" );
    var_0 hide();
    var_1 hide();
    var_2 hide();
    var_3 hide();
    maps\_lighting::model_flicker_preset( "undefined", 0, 0, undefined, undefined, "9543spot", 0.15, 0.151, 1, 1.001, "lighting_kill_catwalk_s_flicker_red" );
    maps\_lighting::model_flicker_preset( "undefined", 0, 0, undefined, undefined, 9542, 0.15, 0.151, 1, 1.001, "lighting_kill_catwalk_s_flicker_white" );
}

setup_eye_highlights_gideon()
{
    if ( level.nextgen )
    {
        level.gideon _meth_846C( "mtl_gideon_eye_shader_l", "mc/mtl_gideon_eye_shader_end_l" );
        level.gideon _meth_846C( "mtl_gideon_eye_shader_r", "mc/mtl_gideon_eye_shader_end_r" );
    }
}

setup_eye_highlights_02()
{
    if ( level.nextgen )
    {
        level.irons _meth_846C( "mtl_irons_eye_shader_l", "mc/mtl_irons_eye_shader_finale_fire_l" );
        level.irons _meth_846C( "mtl_irons_eye_shader_r", "mc/mtl_irons_eye_shader_finale_fire_r" );
    }
}

setup_eye_highlights( var_0 )
{
    if ( level.nextgen )
    {
        wait 20;
        var_0 _meth_846C( "mtl_irons_eye_shader_l", "mc/mtl_irons_eye_shader_finale_l" );
        var_0 _meth_846C( "mtl_irons_eye_shader_r", "mc/mtl_irons_eye_shader_finale_r" );
    }
}

mb_surprise()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbvelocityscalar", "3" );
        wait 5;
        _func_0D3( "r_mbEnable", "0" );
    }
}

mb_tackle()
{
    if ( level.nextgen )
    {
        common_scripts\utility::flag_wait( "flag_balcony_tackle_success" );
        thread light_ending_cinematic();
        thread fire_ending_light();
        _func_0D3( "r_adaptivesubdiv", 0 );
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbvelocityscalar", "5.5" );
        wait 3.2;
        maps\_utility::vision_set_fog_changes( "finale_roof_hang", 1 );
        level.player _meth_8490( "clut_finale_fire", 0.5 );
        level.player _meth_83C0( "finale_night3" );
        thread setup_eye_highlights_02();
        wait 2.5;
        _func_0D3( "r_mbvelocityscalar", ".5" );
    }

    if ( level.currentgen )
    {
        common_scripts\utility::flag_wait( "flag_balcony_tackle_success" );
        thread light_ending_cinematic();
        thread fire_ending_light();
        wait 3.2;
        maps\_utility::vision_set_fog_changes( "finale_roof_hang", 1 );
        level.player _meth_83C0( "finale_night3" );
        thread setup_eye_highlights_02();
        wait 3;
    }
}

star( var_0 )
{
    for (;;)
        wait 0.05;
}

dof_irons_meet( var_0 )
{
    if ( level.nextgen )
    {
        common_scripts\utility::flag_wait( "flag_sit_down" );
        var_1 = common_scripts\utility::spawn_tag_origin();
        var_1 _meth_804D( var_0, "J_Head", ( 0, 3, 0 ), ( 0, 0, 0 ), 0 );
        level.player _meth_84A9();
        level.player _meth_84AB( 3.5, 60 );
        wait 2.5;
        level.player _meth_84AB( 3.5, 15 );
        wait 2;
        level.player _meth_84AB( 0.5, 120 );
        common_scripts\utility::flag_wait( "turn_on_lights" );
        level.player _meth_8490( "clut_finale_chase", 0 );
        common_scripts\utility::flag_set( "lighting_target_dof" );
        thread lighting_target_dof_ender( level.player, var_1, 3.5 );
        thread autofocus_loop();
        wait 12;
        common_scripts\utility::flag_clear( "lighting_target_dof" );
        wait 0.05;
        common_scripts\utility::flag_set( "lighting_target_dof" );
        thread lighting_target_dof_ender( level.player, var_1, 15 );
        wait 9;
        common_scripts\utility::flag_clear( "lighting_target_dof" );
        wait 0.05;
        common_scripts\utility::flag_set( "lighting_target_dof" );
        thread lighting_target_dof_ender( level.player, var_1, 3.5 );
        wait 15;
        common_scripts\utility::flag_clear( "lighting_target_dof" );
        wait 0.05;
        common_scripts\utility::flag_set( "lighting_target_dof" );
        thread lighting_target_dof_ender( level.player, var_1, 15 );
        wait 18;
        common_scripts\utility::flag_clear( "lighting_target_dof" );
        level.player waittill( "exo_released" );
        level notify( "end_screen_effect" );
        common_scripts\_exploder::exploder( 2000 );
    }
}

gideon_mech_light()
{
    common_scripts\utility::flag_wait( "underwater_flashlight" );
    wait 6;
    var_0 = level.gideon;

    if ( isdefined( var_0.light_tag ) )
        var_0.light_tag delete();

    var_0.light_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.light_tag;
    var_1 _meth_804D( var_0, "J_Head", ( 0, 20, 0 ), ( 180, -105, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.1;
    killfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.2;
    killfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.1;
    playfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.15;
    killfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
    common_scripts\utility::flag_waitopen( "underwater_flashlight" );
    killfxontag( common_scripts\utility::getfx( "fin_light_mech" ), var_1, "tag_origin" );
}

add_player_flashlight( var_0, var_1, var_2 )
{
    var_3 = level.player common_scripts\utility::spawn_tag_origin();
    var_3 _meth_80A6( level.player, "tag_origin", ( 0, -10, 10 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "player_light_med2" ), var_3, "tag_origin" );
    level.player.tag_weapon = var_3;
    thread monitor_player_light_off();
}

monitor_player_light_off()
{
    common_scripts\utility::waittill_any( "flashlight_off", "death" );

    if ( !isdefined( self ) )
        return;

    stopfxontag( common_scripts\utility::getfx( "player_light_med2" ), self.tag_weapon, "tag_origin" );
    self.tag_weapon delete();
}

light_strip_checkpoint()
{
    var_0 = getentarray( "light_strips_on", "targetname" );
    var_1 = getentarray( "light_strips_off", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 show();

    foreach ( var_3 in var_1 )
        var_3 hide();
}

fire_ending_light()
{
    wait 1.5;
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_med_ending", "light_spot_irons_key_02" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_large_ending", "light_spot_irons_fill_02" );
    setsunflareposition( ( 81, 62, 0 ) );
    level waittill( "irons_dead" );
    wait 2;
    maps\_utility::vision_set_fog_changes( "finale_roof_hang_end", 1.5 );
    maps\_lighting::stop_flickerlight( "firelight_motion_med_ending", "light_spot_irons_key_02", 0 );
    maps\_lighting::stop_flickerlight( "firelight_motion_large_ending", "light_spot_irons_fill_02", 0 );
    wait 0.25;
    var_0 = getent( "gideon_lighting_org", "targetname" );
    wait 0.5;
}

atlas_sign_flicker()
{
    var_0 = getent( "atlas_off", "script_noteworthy" );
    var_1 = getent( "atlas_halfoff", "script_noteworthy" );
    var_2 = getent( "atlas_on", "script_noteworthy" );
    var_3 = getent( "light_spot_irons_rim", "targetname" );
    var_4 = common_scripts\utility::getstruct( "finale_rim_org_02", "targetname" );
    var_0 show();
    var_1 hide();
    var_2 hide();
    level waittill( "irons_dead" );
    wait 3.9;
    var_3 _meth_82AE( var_4.origin, 0.1, 0.05, 0.05 );
    wait 0.15;
    level.player _meth_8490( "clut_finale_roof", 0 );
    thread maps\_utility::vision_set_fog_changes( "finale_roof_hang_end", 1 );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_large_atlas", "fire_ending_shot" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_med_ending3", "light_spot_irons_rim_02" );
    maps\_lighting::play_flickerlight_preset( "firelight_med_ending2", "light_spot_irons_rim", 7000 );
    wait 0.05;
    thread setup_eye_highlights_gideon();
}

lighting_target_dof( var_0, var_1, var_2, var_3 )
{
    var_4 = level.player_dof_aperture;
    level.player_dof_aperture = var_2;
    var_5 = var_3 * 10;
    common_scripts\utility::flag_clear( "flag_autofocus_on" );

    while ( var_5 > 0 )
    {
        var_6 = distance2d( var_0.origin, var_1.origin );
        level.player_dof_distance = var_6;
        wait 0.1;
        var_5--;
    }

    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = var_4;
}

lighting_target_dof_ender( var_0, var_1, var_2 )
{
    var_3 = level.player_dof_aperture;
    level.player_dof_aperture = var_2;
    common_scripts\utility::flag_clear( "flag_autofocus_on" );

    while ( common_scripts\utility::flag( "lighting_target_dof" ) == 1 )
    {
        var_4 = distance2d( var_0.origin, var_1.origin );
        level.player_dof_distance = var_4;
        wait 0.1;
    }

    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = var_3;
}

autofocus_loop()
{
    level.player _meth_84A9();
    var_0 = level.player_dof_aperture;

    while ( common_scripts\utility::flag( "flag_autofocus_on" ) == 0 )
    {
        waitframe();
        var_1 = level.player_dof_distance;
        var_0 = level.player_dof_aperture;

        if ( var_1 < 60 )
            var_0 += abs( 60 - var_1 ) * 0.1;

        if ( level.nextgen )
            level.player _meth_84AB( var_0, var_1, 4, 2 );
    }

    level.player _meth_84AA();
}

trace_distance()
{
    var_0 = 4096;
    var_1 = level.player _meth_80A8();
    var_2 = level.player getangles();

    if ( isdefined( level.player.dof_ref_ent ) )
        var_3 = combineangles( level.player.dof_ref_ent.angles, var_2 );
    else
        var_3 = var_2;

    var_4 = vectornormalize( anglestoforward( var_3 ) );
    var_5 = bullettrace( var_1, var_1 + var_4 * var_0, 1, level.player, 1, 1, 0, 0, 0 );
    return distance( var_1, var_5["position"] );
}

player_rig_lighting_org_willroom( var_0 )
{
    var_0 _meth_847C();
    wait 0.05;
    var_1 = common_scripts\utility::getstruct( "will_room_lighting_origin", "targetname" );
    var_0 _meth_847B( level.gideon.origin );
    level.player waittill( "exo_released" );
    var_0 _meth_847C();
}

player_rig_lighting_org( var_0 )
{
    var_0 _meth_847C();
    wait 0.05;
    var_1 = getent( "org_player_carried_lobby_03_lighting", "targetname" );
    var_0 _meth_847B( level.irons.origin );
    level.player waittill( "exo_released" );
    var_0 _meth_847C();
}

clut_rotate()
{
    wait 15;

    for (;;)
    {
        level.player _meth_8490( "clut_finale_fire", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_intro", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_chase", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_irons", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_lobby", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_roof", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_walkway", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_burn_pre", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_burn_red", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_orange_silo_approach", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_round_tunnel", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_silo_blue", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_silo_center", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_silo_shaft", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_floor3_density", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_orange_silo_approach_density", 0 );
        wait 1;
        level.player _meth_8490( "clut_finale_round_tunnel", 0 );
        wait 1;
        level.player _meth_8490( "", 0 );
    }
}

balcony_lighting( var_0 )
{
    common_scripts\utility::flag_wait( "flag_balcony_tackle_success" );
    wait 3;
    var_1 = getent( "gideon_lighting_org", "targetname" );
    var_0 _meth_847B( level.gideon.origin );
}

sky_bridge_dof()
{
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbvelocityscalar", "1" );
    _func_0D3( "r_mbCameraRotationInfluence", "1" );
    level.player _meth_84A9();
    wait 5;
    level.player _meth_84AB( 1.5, 30 );
    wait 4;
    level.player _meth_84AB( 2.5, 3000 );
    wait 10;
    level.player _meth_84AB( 1.5, 30 );
    wait 8;
    level.player _meth_84AA();
    disable_motion_blur();
}
