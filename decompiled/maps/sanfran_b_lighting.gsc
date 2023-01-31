// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    waittillframeend;
    thread setup_dof_presets();
    thread setup_dof_viewmodel_presets();
    thread setup_flickerlight_presets();
    thread set_level_lighting_values();
    thread fix_dark_script_models();
    thread intro_sun_flare_position();

    if ( level.nextgen )
        thread clut_trigger_manage();

    if ( level.currentgen )
    {

    }

    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );

    precacheshader( "ac130_overlay_pip_vignette" );
}

set_level_lighting_values()
{
    if ( _func_235() )
    {
        if ( level.nextgen )
            _func_0D3( "r_dynamicOpl", 1 );

        _func_0D3( "r_disableLightSets", 0 );
        _func_0D3( "r_tonemapMinExposureAdjust", -7.4919 );
        _func_0D3( "sm_usedSunCascadeCount", 2 );
        _func_0D3( "sm_sunSampleSizeNear", 0.2 );

        if ( level.nextgen )
            return;

        return;
    }
}

setup_dof_presets()
{
    maps\_lighting::create_dof_preset( "intro", 10, 18, 10, 25, 150, 4.5, 0.5 );
    maps\_lighting::create_dof_preset( "temp", 0, 60, 5, 1000, 8000, 2.5, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_intro", 8, 16, 4, 50, 250, 1, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_intro_blur", 8, 16, 5, 50, 150, 2.7, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_intro_crash", 8, 16, 8, 20, 50, 5, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_interior", 8, 16, 5, 17, 650, 4, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_guns", 8, 300, 5, 5000, 7000, 0, 0.5 );
    maps\_lighting::create_dof_preset( "sf_b_end", 8, 16, 5, 17, 450, 2, 0.5 );
    maps\_lighting::create_dof_preset( "cg_default", 0, 100, 4.0, 6000, 31000, 1.5, 0.0 );
}

setup_dof_viewmodel_presets()
{
    maps\_lighting::create_dof_viewmodel_preset( "vm_rack_nblur", 2, 10 );
    maps\_lighting::create_dof_viewmodel_preset( "vm_off", 0, 0 );
}

setup_flickerlight_presets()
{
    maps\_lighting::create_flickerlight_preset( "fire2", ( 0.972549, 0.62451, 1 ), ( 0.2, 0.146275, 1 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway2", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "hallway3", ( 1, 1, 1 ), ( 0, 0, 0 ), 0.005, 0.2, 80000 );
    maps\_lighting::create_flickerlight_preset( "red_pulse", ( 1, 0, 0 ), ( 0.3, 0, 0 ), 0.2, 1, 80000 );
}

viewmodel_blend()
{
    maps\_lighting::blend_dof_viewmodel_presets( "vm_rack_nblur", "vm_off", 2 );
}

dof_car_explosion()
{
    wait 1.5;

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_b_exterior", 0.25 );
        wait 1.75;
        level.player _meth_8490( "clut_sanfran_b_fire", 0.5 );
    }

    wait 8.3;

    if ( level.currentgen )
    {
        level.player _meth_83C0( "sanfran_b_intro" );
        wait 1.75;
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_darker_fog", 0.2 );
    }

    if ( level.nextgen )
        _func_0D3( "r_mbVelocityScalar", "2" );

    wait 0.3;

    if ( level.nextgen )
    {
        maps\_utility::fog_set_changes( "sanfran_b_exterior_light_fog", 0.2 );
        level.player _meth_83C0( "sanfran_b_intro_bright" );
    }

    if ( level.currentgen )
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_light_fog", 0.2 );

    wait 0.4;

    if ( level.currentgen )
    {
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_exterior_dark_fog", 0.5 );
        level.player _meth_83C0( "sanfran_b_intro" );
    }

    if ( level.nextgen )
    {
        maps\_utility::fog_set_changes( "sanfran_b_exterior_darker_fog", 3 );
        level.player _meth_83C0( "sanfran_b_intro" );
    }

    wait 1;

    if ( level.nextgen )
        _func_0D3( "r_mbVelocityScalar", ".5" );
}

interior_dof_blend()
{
    if ( level.nextgen )
        return;
}

play_flickering_hanger_light()
{
    if ( level.nextgen )
        thread maps\_lighting::model_flicker_preset( "model_flicker_02", 0, 300000, 300000, undefined, 1668 );
    else
        thread maps\_lighting::model_flicker_preset( "model_flicker_02", 0, 25000, 25000, undefined, 1668 );

    if ( level.nextgen )
        maps\_lighting::play_flickerlight_preset( "fire", "fire_hallway", 1700000 );
    else
        maps\_lighting::play_flickerlight_preset( "fire", "fire_hallway", 4000 );
}

stop_flickering_hanger_light()
{
    maps\_lighting::stop_flickerlight( "fire", "fire_hallway", 0 );
}

play_flickering_interior_light()
{
    maps\_lighting::play_flickerlight_preset( "fire", "fire_interior", 100000 );
}

stop_flickering_interior_light()
{
    maps\_lighting::stop_flickerlight( "fire", "fire_interior", 0 );
}

play_flickering_fire_light()
{
    thread intro_dof();

    if ( level.nextgen )
    {
        wait 0.05;
        var_0 = getent( "heli_light", "targetname" );
        var_0 _meth_81DF( 10000000 );
        var_0 _meth_8044( ( 1, 0.8, 0.6 ) );
        maps\_lighting::play_flickerlight_preset( "sfb_fire", "fire_outside", 2058000 );
        wait 3.5;
        maps\_lighting::lerp_spot_intensity( "fire_outside", 1, 0 );
        wait 0.4;
        maps\_lighting::lerp_spot_intensity( "fire_outside", 0.5, 2058000 );
        wait 6.8;
    }
}

intro_dof()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", ".5" );
        level.player _meth_84A9();
        level.player _meth_84AB( 2, 241 );
        wait 2.1;
        level.player _meth_84AB( 1.5, 40 );
        wait 0.5;
        level.player _meth_84AB( 1.5, 30 );
        wait 1.5;
        level.player _meth_84AB( 2, 241 );
        wait 5.5;
        level.player _meth_84AB( 1.2, 41 );
        wait 12.2;
        level.player _meth_84AB( 1.5, 30 );
        level.player _meth_84AA();
        wait 0.2;
        _func_0D3( "r_mbEnable", "0" );
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 2, 241 );
        wait 2.1;
        level.player _meth_84AB( 1.5, 40 );
        wait 0.5;
        level.player _meth_84AB( 1.5, 30 );
        wait 1.5;
        level.player _meth_84AB( 2, 241 );
        wait 5.5;
        level.player _meth_84AB( 1.2, 41 );
        wait 12.2;
        level.player _meth_84AB( 1.5, 30 );
        wait 0.2;
        level.player _meth_84AB( 19, 0, 2, 3 );
    }
}

stop_flickering_fire_light()
{
    maps\_lighting::stop_flickerlight( "fire", "fire_outside", 0 );
    maps\_lighting::stop_flickerlight( "fire", "fire_outside2", 0 );
}

fire_inside_02_manage()
{
    level endon( "console_guy_spawn" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "fire_inside_02_on" );

        if ( level.nextgen )
            maps\_lighting::play_flickerlight_preset( "fire", "fire_inside_02", 5580000 );
        else
            maps\_lighting::play_flickerlight_preset( "fire", "fire_inside_02", 150000 );

        maps\_utility::lerp_saveddvar( "r_specularColorScale", 2, 1.5 );
        common_scripts\utility::flag_waitopen( "fire_inside_02_on" );
        maps\_lighting::stop_flickerlight( "fire", "fire_inside_02", 0 );
        maps\_utility::lerp_saveddvar( "r_specularColorScale", 1, 1.5 );
    }
}

play_flickering_info_hallway_light()
{
    maps\_lighting::play_flickerlight_preset( "hallway", "hallway_flicker", 70000 );
}

stop_flickering_info_hallway_light()
{
    maps\_lighting::stop_flickerlight( "hallway", "hallway_flicker", 0 );
}

play_flickering_info_light()
{
    if ( level.nextgen )
        thread maps\_lighting::model_flicker_preset( "model_flicker_03", 0, 300000, 300000, undefined, 1669 );
    else
        thread maps\_lighting::model_flicker_preset( "model_flicker_03", 0, 100000, 100000, undefined, 1669 );

    thread maps\_lighting::play_pulse_preset( "red", "red_strobe", 260000 );
    thread maps\_lighting::play_pulse_preset( "red", "red_strobe2", 260000 );
}

play_flickering_bridge_light()
{

}

stop_flickering_info_light()
{

}

play_pulse_light()
{
    maps\_lighting::play_flickerlight_preset( "pulse", "pulse_light", 4000 );
}

stop_pulse_light()
{
    maps\_lighting::stop_flickerlight( "pulse", "pulse_light", 0 );
}

lerp_sun_01()
{
    thread maps\_shg_fx::set_sun_flare_position( ( -24, 180, 0 ) );
    wait 1;
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );
}

lerp_sun_02()
{
    thread maps\_shg_fx::set_sun_flare_position( ( -15, 85, 0 ) );
    wait 1;
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );
}

flip_spot_light()
{
    var_0 = getent( "spot_switch_off", "targetname" );
    var_0 _meth_81DF( 0 );
}

sundark_call()
{
    var_0 = getentarray( "sun_dark", "targetname" );
    level.sundark_touched = 0;

    foreach ( var_2 in var_0 )
        var_2 thread sundark_volume();
}

sundark_volume()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.sundark_touched++;

        while ( level.player _meth_80A9( self ) )
            wait 0.1;

        level.sundark_touched--;

        if ( level.sundark_touched == 0 )
            resetsunlight();
    }
}

ending_viewmodelblur()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }
}

ending_viewmodelblur_reset()
{
    if ( level.nextgen )
    {
        if ( level.xb3 )
        {
            _func_0D3( "sm_sunShadowBoundsOverride", "1" );
            _func_0D3( "sm_sunShadowBoundsMin", "-10000 50000 -1000" );
            _func_0D3( "sm_sunShadowBoundsMax", "-2000 70000 1000" );
        }

        _func_0D3( "r_dof_physical_bokehenable", 1 );
        _func_0D3( "r_mbCameraRotationInfluence", 1 );
        thread shadow_card();
        common_scripts\_exploder::exploder( 7022 );
        level.player _meth_84A9();
        level.player _meth_84AB( 1, 35, 10, 10 );
        wait 1;
        level.player _meth_84AB( 1, 165, 2, 3 );
        wait 9.5;
        level.player _meth_84AB( 1.5, 41, 2, 3 );
        wait 3.5;
        level.player _meth_84AB( 1.5, 74, 2, 3 );
        wait 6.25;
        level.player _meth_84AB( 1.5, 31, 2, 3 );
        wait 9.0;
        level.player _meth_84AB( 1.5, 45, 2, 3 );
        wait 10;

        if ( level.xb3 )
            _func_0D3( "sm_sunShadowBoundsOverride", "0" );
    }
    else
    {
        thread shadow_card();
        common_scripts\_exploder::exploder( 7022 );
        level.player _meth_84A9();
        level.player _meth_84AB( 1, 35, 10, 10 );
        wait 1;
        level.player _meth_84AB( 1, 165, 2, 3 );
        wait 9.5;
        level.player _meth_84AB( 1.5, 41, 2, 3 );
        wait 3.5;
        level.player _meth_84AB( 1.5, 74, 2, 3 );
        wait 6.25;
        level.player _meth_84AB( 1.5, 31, 2, 3 );
        wait 9.0;
        level.player _meth_84AB( 1.5, 45, 2, 3 );
        wait 10;
    }
}

shadow_card()
{
    var_0 = level.maddox;
    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_804D( var_0, "TAG_ORIGIN", ( 0, -50, 50 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "shadow_card1" ), var_1, "tag_origin" );
}

fix_dark_script_models()
{
    wait 5;
    var_0 = getent( "refl_probe_outside", "targetname" );
    var_1 = getent( "mob_placement_marker", "targetname" );
    var_2 = getent( "mob_turret_right", "targetname" );
    var_3 = getent( "mob_turret_left", "targetname" );
    var_4 = getent( "railgun_turn_off", "targetname" );
    var_2 _meth_83AB( var_0.origin );
    var_3 _meth_83AB( var_0.origin );
    var_4 _meth_83AB( var_0.origin );
    var_2.origin = var_1.origin;
}

intro_sun_flare_position()
{
    var_0 = ( -31, 84, 0 );
    maps\_shg_fx::set_sun_flare_position( var_0 );
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );
}

clut_trigger_manage()
{
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_exterior", ::sanfran_b_exterior_clut );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_exterior_fast", ::sanfran_b_exterior_clut_fast );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_interior", ::sanfran_b_interior_clut );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_bridge", ::sanfran_b_bridge_clut );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_interior_blue", ::sanfran_b_interior_blue_clut );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_fire", ::sanfran_b_fire );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_dark_lightset", ::sanfran_b_dark_lightset );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_darker_lightset", ::sanfran_b_darker_lightset );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_lightset", ::sanfran_b_lightset );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_hangar_lightset", ::sanfran_b_hangar_lightset );
    common_scripts\utility::run_thread_on_targetname( "sanfran_b_info_top_lightset", ::sanfran_b_info_top_lightset );
}

sanfran_b_exterior_clut()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread maps\_utility::fog_set_changes( "sanfran_b", 3 );
        level.player _meth_8490( "clut_sanfran_b_exterior", 3 );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_exterior_clut_fast()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread maps\_utility::fog_set_changes( "sanfran_b", 1.5 );
        level.player _meth_8490( "clut_sanfran_b_exterior", 1.5 );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_interior_clut()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 3 );
        thread maps\_utility::fog_set_changes( "sanfran_b", 3 );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_bridge_clut()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "", 3 );
        thread maps\_utility::fog_set_changes( "sanfran_b_bridge", 3 );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_interior_blue_clut()
{
    for (;;)
    {
        self waittill( "trigger" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_fire()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_8490( "clut_sanfran_b_fire", 5 );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_dark_lightset()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "sanfran_b_dark" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_darker_lightset()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "sanfran_b_darker" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_lightset()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "sanfran_b" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_hangar_lightset()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "sanfran_b_hangar" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}

sanfran_b_info_top_lightset()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "sanfran_b_info_top" );

        while ( level.player _meth_80A9( self ) )
            wait 0.05;
    }
}
