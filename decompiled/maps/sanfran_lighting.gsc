// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    waittillframeend;
    common_scripts\utility::flag_init( "kill_vehicle_lights" );
    common_scripts\utility::flag_init( "show_ship_shadows" );
    thread setup_dof_presets();
    thread set_level_lighting_values();
    thread trigger_exit_tunnel();
    thread set_tunnel_lighting();
    thread set_oncoming_lighting();
    thread set_bridge_lighting();
    thread set_street_lighting();
    thread set_van_lighting();
    thread set_boost_lighting();

    if ( level.currentgen )
        thread showboatshadows();

    thread setup_crash_events();
    thread flickering_tunnel_light();
    thread set_cargo_ship_drone_view_lighting();

    if ( level.nextgen )
        _func_0D3( "r_subdiv", "1" );
}

set_level_lighting_values()
{
    if ( _func_235() )
    {
        if ( level.nextgen )
        {
            _func_0D3( "r_disableLightSets", 0 );
            _func_0D3( "r_hemiAoEnable", 1 );
        }

        if ( level.currentgen )
        {

        }

        level.player _meth_83C0( "set_level_lighting_values" );
    }
}

set_intro_lighting()
{
    common_scripts\utility::flag_wait( "start_intro_lighting" );
    maps\_utility::vision_set_fog_changes( "sanfran_drone_view", 0.0 );
    level.player _meth_83C0( "sanfran_drone_view_0" );
    thread move_sunflare_back_startpoints();
    maps\_utility::delaythread( 1.8, ::overexposed_effect );
}

set_cargo_ship_drone_view_lighting()
{
    common_scripts\utility::flag_wait( "flag_cargo_ship" );

    if ( level.nextgen )
        thread lerp_sun_cargo_ship();

    thread overexposed_effect();
    maps\_utility::vision_set_fog_changes( "sanfran_drone_view_1", 0.0 );
    wait 1.0;
    level.player _meth_83C0( "sanfran_drone_view_1" );
}

overexposed_effect()
{
    level.player _meth_83C0( "overexposed_effect_0" );
    wait 0.25;
    level.player _meth_83C0( "overexposed_effect_1" );
}

flickering_tunnel_light()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lighting_origin", "targetname" );
        var_1 = getent( "light_wall_off", "targetname" );
        var_2 = getent( "light_wall_on", "targetname" );
        var_3 = getent( "light_wall_off_1", "targetname" );
        var_4 = getent( "light_wall_on_1", "targetname" );
        var_5 = getent( "light_wall_off_2", "targetname" );
        var_6 = getent( "light_wall_on_2", "targetname" );
        var_2 _meth_847B( var_0.origin );
        var_1 _meth_847B( var_0.origin );
        var_4 _meth_847B( var_0.origin );
        var_3 _meth_847B( var_0.origin );
        var_6 _meth_847B( var_0.origin );
        var_5 _meth_847B( var_0.origin );
        thread maps\_lighting::model_flicker_preset( "light_flicker_test", 0, 30000, 50000, undefined, undefined, 0.1, 0.4, 0.2, 0.4 );
        thread maps\_lighting::model_flicker_preset( "light_flicker_test_1", 0, 10000, 50000, undefined, undefined, 0.2, 0.6, 0.2, 0.4 );
        thread maps\_lighting::model_flicker_preset( "light_flicker_test_2", 0, 10000, 50000, undefined, undefined, 0.2, 0.5, 0.4, 0.6 );
    }
}

mblur_rotation_on()
{
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbCameraRotationInfluence", "1" );
}

mblur_on()
{
    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "2" );
}

mblur_off()
{
    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );
}

set_tunnel_lighting_1()
{
    if ( level.nextgen )
        wait 0.5;
    else
        wait 0.125;

    level.player _meth_83C0( "set_tunnel_lighting_1" );

    if ( level.nextgen )
        thread lerp_sun();
}

set_tunnel_lighting_2()
{
    wait 13.5;
    level.player _meth_83C0( "set_tunnel_lighting_2" );
}

showboatshadows()
{
    common_scripts\utility::flag_wait( "show_ship_shadows" );
    var_0 = getentarray( "boat_shadows", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 show();
    }
}

hideboatshadows()
{
    var_0 = getentarray( "boat_shadows", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 hide();
    }
}

set_tunnel_lighting()
{
    common_scripts\utility::flag_wait( "start_tunnel_lighting" );
    thread tunnel_sequence_dof();

    if ( level.nextgen )
        level.player _meth_83C0( "set_tunnel_lighting_0" );

    if ( level.nextgen )
    {
        thread mblur_rotation_on();
        thread maps\_lighting::set_spot_intensity( "intro_car_light", 100500 );
        level.player _meth_8490( "clut_sanfran_tunnel", 0 );
        wait 3;
        maps\_utility::vision_set_changes( "sanfran_neutral", 1 );
        maps\_utility::fog_set_changes( "sanfran_tunnel", 1 );
    }
    else
    {
        wait 0.25;
        maps\_utility::vision_set_fog_changes( "sanfran_tunnel", 0.0 );
    }

    thread set_tunnel_lighting_2();
    thread set_tunnel_lighting_1();
    thread setup_vfx_sunflare();
    thread setup_pitbull_vfx_lights();
    thread pitbull_headlights_on();
}

setup_hud_lighting()
{
    var_0 = ( 3, -40, -2 );
    var_1 = ( 3, 3, -2 );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( level.player_pitbull.fake_vehicle_model, "tag_lt_window_hud", var_0, ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "lt_pt_pitbull_hud" ), var_2, "TAG_ORIGIN" );
    wait 0.5;
    var_3 = 0.5;

    for ( var_4 = 0; var_4 < var_3; var_4 += 0.05 )
    {
        var_5 = var_4 / var_3;
        var_6 = vectorlerp( var_0, var_1, var_5 );
        var_2 _meth_804D( level.player_pitbull.fake_vehicle_model, "tag_lt_window_hud", var_6, ( 0, 0, 0 ) );
        wait 0.05;
    }

    var_0 = ( 3, 3, -2 );
    var_1 = ( 3, -45, -2 );
    wait 10.2;
    var_3 = 0.4;

    for ( var_4 = 0; var_4 < var_3; var_4 += 0.05 )
    {
        var_5 = var_4 / var_3;
        var_6 = vectorlerp( var_0, var_1, var_5 );
        var_2 _meth_804D( level.player_pitbull.fake_vehicle_model, "tag_lt_window_hud", var_6, ( 0, 0, 0 ) );
        wait 0.05;
    }

    wait 1.0;
    var_0 = ( 3, -45, -2 );
    var_1 = ( 3, -50, 5 );
    var_3 = 0.4;

    for ( var_4 = 0; var_4 < var_3; var_4 += 0.05 )
    {
        var_5 = var_4 / var_3;
        var_6 = vectorlerp( var_0, var_1, var_5 );
        var_2 _meth_804D( level.player_pitbull.fake_vehicle_model, "tag_lt_window_hud", var_6, ( 0, 0, 0 ) );
        wait 0.05;
    }

    var_2 delete();
    common_scripts\utility::flag_set( "kill_vehicle_lights" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "show_ship_shadows" );
}

setup_car_passing_lights()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 _meth_804D( self, "TAG_BRAKELIGHT_LEFT", ( 0, 0, 0 ), ( 0, -90, 0 ) );
    playfxontag( common_scripts\utility::getfx( "lt_pt_tunnel_car_pass" ), var_0, "TAG_ORIGIN" );
    common_scripts\utility::flag_wait( "kill_vehicle_lights" );
    stopfxontag( common_scripts\utility::getfx( "lt_pt_tunnel_car_pass" ), var_0, "TAG_ORIGIN" );
    var_0 delete();
}

set_oncoming_lighting()
{
    common_scripts\utility::flag_wait( "start_oncoming_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 0 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran_oncoming", 1.0 );
        thread mblur_on();
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );

    level.player _meth_83C0( "setup_drive_shadows" );
    thread setup_pitbull_vfx_lights();
    thread setup_vfx_sunflare();
    thread move_sunflare_back_startpoints();
    thread pitbull_drive_dof();
    wait 0.1;
    thread script_probe_pitbull_tunnel_exterior_no_trigger();
}

set_bridge_lighting()
{
    common_scripts\utility::flag_wait( "start_bridge_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 0 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran_oncoming", 1.0 );
        thread mblur_on();
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );

    level.player _meth_83C0( "setup_drive_shadows" );
    thread setup_pitbull_vfx_lights();
    thread setup_vfx_sunflare();
    thread move_sunflare_back_startpoints();
    thread pitbull_drive_dof();
    wait 0.1;
    thread script_probe_pitbull_tunnel_exterior_no_trigger();
}

set_street_lighting()
{
    common_scripts\utility::flag_wait( "start_street_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 0 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran", 1.0 );
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );

    level.player _meth_83C0( "set_street_lighting" );
    thread setup_vfx_sunflare();
    thread move_sunflare_back_startpoints();
}

set_van_lighting()
{
    common_scripts\utility::flag_wait( "start_van_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 0 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran", 1.0 );
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );

    level.player _meth_83C0( "set_street_lighting" );
    thread setup_vfx_sunflare();
    thread move_sunflare_back_startpoints();
}

set_boost_lighting()
{
    common_scripts\utility::flag_wait( "start_boost_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 0 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran", 1.0 );
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );

    level.player _meth_83C0( "set_boost_lighting" );
    thread setup_vfx_sunflare();
    thread move_sunflare_back_startpoints();
    thread boost_setup_desat();
    common_scripts\utility::flag_set( "flag_van_explosion_start" );
}

bridge_collapse_screen_effects()
{
    thread bc_initial_blur();
    thread bc_explosion_vision();
    thread bridge_collapse_sequence();
    maps\_utility::delaythread( 0.2, ::headless_shadow_tweak );
    maps\_utility::delaythread( 1.2, ::car_hit_shadows );
    maps\_utility::delaythread( 1.3, ::car_hit_blur );
    maps\_utility::delaythread( 23.0, ::bc_shadow_tweak );
}

trigger_exit_tunnel()
{
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::script_probe_pitbull_tunnel_exterior );
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::move_sunflare_back );
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::vision_set_sanfran );
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::setup_drive_shadows );
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::pitbull_headlights_off );
    common_scripts\utility::run_thread_on_targetname( "exit_tunnel", ::disable_bokeh );
}

intro_rack_focus_dof()
{
    if ( level.nextgen )
    {
        maps\_lighting::blend_dof_presets( "default", "intro_out_of_focus", 0.05 );
        wait 6.5;
        maps\_lighting::blend_dof_presets( "intro_out_of_focus", "intro_bg_in_focus", 0.5 );
        wait 2.5;
        maps\_lighting::blend_dof_presets( "intro_bg_in_focus", "intro_all_in_focus", 1.0 );
        thread intro_zoom_in_out_fleet();
    }
    else
        thread intro_zoom_in_out_fleet();
}

intro_zoom_in_out_fleet()
{
    common_scripts\utility::flag_wait( "flag_zoom_in_fleet" );

    if ( level.nextgen )
    {
        maps\_lighting::blend_dof_presets( "intro_all_in_focus", "intro_zoom_out_focus", 0.05 );
        wait 0.5;
        maps\_lighting::blend_dof_presets( "intro_zoom_out_focus", "intro_zoom_in_focus", 0.1 );
        common_scripts\utility::flag_wait( "flag_zoom_out_fleet" );
        maps\_lighting::blend_dof_presets( "intro_zoom_in_focus", "intro_bg_in_focus", 0.05 );
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 2.0, 23.0 );
        wait 6.5;
        level.player _meth_84AB( 2.0, 23.0 );
        wait 2.5;
        level.player _meth_84AB( 2.0, 23.0 );
        wait 2.5;
        level.player _meth_84AA();
    }
}

intro_rack_focus_cargo_dof()
{
    if ( level.nextgen )
    {
        maps\_lighting::blend_dof_presets( "intro_bg_in_focus", "cargo_in_focus", 0.1 );
        common_scripts\utility::flag_wait( "flag_zoom_in_cargo" );
        maps\_lighting::blend_dof_presets( "cargo_in_focus", "cargo_out_focus", 0.05 );
        wait 0.5;
        maps\_lighting::blend_dof_presets( "cargo_out_focus", "cargo_in_focus", 0.1 );
        common_scripts\utility::flag_wait( "flag_zoom_out_cargo" );
        maps\_lighting::blend_dof_presets( "cargo_in_focus", "cargo_out_focus", 0.05 );
        wait 0.5;
        maps\_lighting::blend_dof_presets( "cargo_out_focus", "cargo_in_focus", 0.1 );
    }
    else
    {
        common_scripts\utility::flag_wait( "flag_zoom_in_cargo" );
        wait 0.5;
        common_scripts\utility::flag_wait( "flag_zoom_out_cargo" );
        wait 0.5;
    }
}

bc_explosion_vision()
{
    level.player _meth_83C0( "overexposed_effect_2" );
    wait 0.05;
    level.player _meth_83C0( "set_van_lighting" );
}

bc_initial_blur()
{
    _func_072( 2, 0 );
    wait 0.5;
    _func_072( 0, 1 );
}

headless_shadow_tweak()
{
    level.defaultsundir = getmapsunangles();
    lerpsunangles( level.defaultsundir, ( -88, 127.1, 0 ), 0.01 );
    wait 2;
    lerpsunangles( ( -88, 127.1, 0 ), level.defaultsundir, 1.0 );
    wait 1.5;
    resetsundirection();
}

car_hit_shadows()
{
    level.player _meth_83C0( "car_hit_shadows_0" );
    wait 3.0;
    level.player _meth_83C0( "car_hit_shadows_1" );
    wait 27;
    level.player _meth_83C0( "car_hit_shadows_2" );
    wait 8;
    level.player _meth_83C0( "car_hit_shadows_1" );
    wait 12.2;
    level.player _meth_83C0( "car_hit_shadows_2" );
}

car_hit_blur()
{
    _func_072( 3, 0 );
    wait 0.5;
    _func_072( 0, 1 );
}

van_knockback_blur()
{
    _func_072( 3, 0 );
    wait 0.5;
    _func_072( 0, 1.5 );
}

bc_shadow_tweak()
{
    maps\_utility::lerp_saveddvar( "sm_sunSampleSizeNear", 0.15, 1 );
    wait 13.0;
    maps\_utility::lerp_saveddvar( "sm_sunSampleSizeNear", 0.09, 1 );
    wait 4.5;
    maps\_utility::lerp_saveddvar( "sm_sunSampleSizeNear", 0.25, 1 );
    wait 8.5;
    maps\_utility::lerp_saveddvar( "sm_sunSampleSizeNear", 0.08, 1 );
}

tunnel_sequence_dof()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
        level.player _meth_84A9();
        level.player _meth_84AB( 2.5, 20, 30 );
        wait 3.5;
        level.player _meth_84AB( 2.5, 40, 2 );
        wait 11.0;
        level.player _meth_84AA();
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 2.8, 38, 30 );
        wait 3.5;
        level.player _meth_84AB( 2.5, 40, 2 );
        wait 11.0;
        level.player _meth_84AA();
    }

    if ( level.nextgen )
    {
        wait 3.5;
        wait 11.0;
    }

    if ( level.nextgen )
    {
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
        _func_0D3( "r_dof_physical_hipEnable", 1 );
        _func_0D3( "r_dof_physical_hipFstop", 6 );
        _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
    }
    else
    {

    }

    common_scripts\utility::flag_set( "kill_vehicle_lights" );
}

pitbull_drive_dof()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_dof_physical_hipEnable", 1 );
        _func_0D3( "r_dof_physical_hipFstop", 6 );
        _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );
    }
    else
    {

    }
}

pitbull_atlas_impact_initial( var_0 )
{
    thread pitbull_impact_blur();
}

pitbull_atlas_impact( var_0 )
{
    thread pitbull_impact_blur();
}

pitbull_crash_jump_start( var_0 )
{
    thread pitbull_impact_blur();
}

pitbull_roof_impact( var_0 )
{
    thread pitbull_impact_blur();
    wait 1.6;
    thread pitbull_impact_blur();
}

pitbull_crashed_dof()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
        _func_0D3( "r_dof_physical_hipEnable", 0 );
        level.player _meth_84A9();
        level.player _meth_84AB( 1.5, 25, 5 );
        wait 15;
        level.player _meth_84AB( 0.75, 88, 3 );
        wait 7.5;
        level.player _meth_84AA();
        thread mblur_off();
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 1.5, 25, 5 );
        wait 15;
        level.player _meth_84AB( 0.75, 88, 3 );
        wait 7.5;
        thread mblur_off();
        level.player _meth_84AA();
    }

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

pitbull_impact_blur()
{
    _func_072( 3, 0 );
    wait 0.6;
    _func_072( 0, 0.8 );
}

pitbull_impact_blur_long()
{
    _func_072( 3, 0 );
    wait 1.2;
    _func_072( 0, 2 );
}

pitbull_headlights_on()
{
    common_scripts\utility::flag_wait( "kill_vehicle_lights" );
    wait 0.6;
    level.origin_pitbull_headlight = common_scripts\utility::spawn_tag_origin();
    level.origin_pitbull_headlight _meth_804D( level.player_pitbull.fake_vehicle_model, "tag_headlight_right", ( 5, 10, 3 ), ( 7, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "light_sanfran_pitbull_headlight" ), level.origin_pitbull_headlight, "TAG_ORIGIN" );
}

pitbull_headlights_off()
{
    self waittill( "trigger" );
    killfxontag( common_scripts\utility::getfx( "light_sanfran_pitbull_headlight" ), level.origin_pitbull_headlight, "TAG_ORIGIN" );
    level.origin_pitbull_headlight delete();
}

friendly_pitbull_headlights_on()
{
    common_scripts\utility::flag_wait( "kill_vehicle_lights" );
    level.origin_friendly_pitbull_headlight = common_scripts\utility::spawn_tag_origin();
    level.origin_friendly_pitbull_headlight _meth_804D( level.friendly_pitbull, "tag_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "light_sanfran_pitbull_headlight" ), level.origin_friendly_pitbull_headlight, "TAG_ORIGIN" );
}

friendly_pitbull_headlights_off()
{
    self waittill( "trigger" );
    killfxontag( common_scripts\utility::getfx( "light_sanfran_pitbull_headlight" ), level.origin_friendly_pitbull_headlight, "TAG_ORIGIN" );
    level.origin_friendly_pitbull_headlight delete();
}

disable_bokeh()
{
    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

van_open_bridge_collapse_dof()
{
    if ( level.nextgen )
    {
        thread mblur_rotation_on();
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
        level.player _meth_84A9();
        level.player _meth_84AB( 3.5, 23, 10 );
        wait 3;
        level.player _meth_84AB( 3.5, 13, 10 );
        wait 5.2;
        thread van_knockback_blur();
        wait 1.5;
        level.player _meth_84AB( 1.5, 123, 5 );
        wait 11;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 7;
        level.player _meth_84AB( 2.5, 40, 5 );
        wait 3.5;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 21;
        level.player _meth_84AB( 2, 35, 5 );
        wait 13;
        level.player _meth_84AB( 2.5, 40, 5 );
        wait 5;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 8;
        level.player _meth_84AB( 1.5, 64, 5 );
        wait 10;
        level.player _meth_84AA();
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 3.5, 23, 10 );
        wait 3;
        level.player _meth_84AB( 3.5, 13, 10 );
        wait 5.2;
        wait 1.5;
        level.player _meth_84AB( 1.5, 123, 5 );
        wait 11;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 7;
        level.player _meth_84AB( 2.5, 40, 5 );
        wait 3.5;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 21;
        level.player _meth_84AB( 2, 35, 5 );
        wait 13;
        level.player _meth_84AB( 2.5, 40, 5 );
        wait 5;
        level.player _meth_84AB( 2.5, 1500, 5 );
        wait 8;
        level.player _meth_84AB( 1.5, 64, 5 );
        wait 10;
        level.player _meth_84AA();
    }
}

bridge_collapse_sequence()
{
    common_scripts\_exploder::exploder( 9521 );

    if ( level.nextgen )
        level.player _meth_8490( "clut_sanfran_exterior", 6.0 );

    wait 8;
    wait 14.5;

    if ( level.currentgen )
        level.player _meth_83C0( "set_boost_lighting" );

    wait 20;
    wait 8.75;
    thread burke_rim_lights();
    wait 1.0;
    thread boost_setup_desat();
    wait 8;
    common_scripts\_exploder::kill_exploder( 9521 );
}

attach_light_to_police_car( var_0 )
{
    if ( isdefined( var_0.car_light ) )
        var_0.car_light delete();

    var_0.car_light = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.car_light;
    var_1 _meth_804D( var_0, "TAG_ORIGIN", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "light_sedan_police_scroll" ), var_1, "tag_origin" );
    level waittill( "kill_barricade_copcar_lights" );
    stopfxontag( common_scripts\utility::getfx( "light_sedan_police_scroll" ), var_1, "tag_origin" );
}

burke_rim_lights()
{
    var_0 = level.burke;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    if ( isdefined( var_0.helmet_tag2 ) )
        var_0.helmet_tag2 delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_0.helmet_tag2 = common_scripts\utility::spawn_tag_origin();
    var_2 = var_0.helmet_tag2;
    var_1 _meth_804D( var_0, "J_Head", ( 3, -5, 5 ), ( 0, 0, 0 ), 0 );
    var_2 _meth_804D( var_0, "J_Head", ( 3, -5, -5 ), ( 0, 0, 0 ), 0 );
}

boost_setup_desat()
{
    if ( level.nextgen )
    {
        maps\_utility::vision_set_changes( "sanfran_neutral", 3.0 );
        maps\_utility::fog_set_changes( "sanfran", 3.0 );
    }
    else
        maps\_utility::vision_set_fog_changes( "sanfran_boost_desat", 3.0 );
}

setup_dof_presets()
{
    maps\_lighting::create_dof_preset( "intro_out_of_focus", 1500, 2000, 6.0, 2001, 7000, 1.0, 0.5 );
    maps\_lighting::create_dof_preset( "intro_fg_in_focus", 760, 1820, 6.0, 1880, 7000, 5.5, 0.5 );
    maps\_lighting::create_dof_preset( "intro_bg_in_focus", 2000, 5450, 6.0, 16500, 150000, 1.0, 0.5 );
    maps\_lighting::create_dof_preset( "intro_all_in_focus", 0, 30, 4.0, 14140, 130000, 1.0, 0.5 );
    maps\_lighting::create_dof_preset( "intro_zoom_out_focus", 3000, 5000, 6.5, 5020, 6750, 6, 0.5 );
    maps\_lighting::create_dof_preset( "intro_zoom_in_focus", 3000, 6200, 6.5, 18500, 150000, 6, 0.5 );
    maps\_lighting::create_dof_preset( "cargo_in_focus", 2100, 4100, 6.3, 12150, 14680, 1.8, 0.5 );
    maps\_lighting::create_dof_preset( "cargo_out_focus", 330, 2000, 6.3, 2010, 6468, 5.5, 0.5 );
    maps\_lighting::create_dof_preset( "tunnel_start", 8, 23, 5.0, 1500, 2000, 0.3, 0.5 );
    maps\_lighting::create_dof_preset( "tunnel_hud_moment", 5, 21, 5.0, 590, 1220, 4.0, 0.5 );
    maps\_lighting::create_dof_preset( "pitbull_drive", 0, 65, 4.0, 3000, 37590, 1.8, 0.5 );
    maps\_lighting::create_dof_preset( "pitbull_crashed", 0, 100, 4.0, 200, 4000, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "bridge_section_01", 0, 100, 4.0, 6000, 31000, 1.5, 0.0 );
    maps\_lighting::create_dof_preset( "van_door_approach", 0, 1, 4.0, 52, 580, 1.8, 0.5 );
    maps\_lighting::create_dof_preset( "van_drones_fly", 0, 1, 4.0, 2000, 7100, 1.8, 0.5 );
    maps\_lighting::create_dof_preset( "van_bridge_explode", 0, 240, 4.0, 2000, 7100, 1.8, 0.5 );
    maps\_lighting::create_dof_preset( "bc_knockback", 0, 30, 4.0, 100, 720, 4.0, 0.5 );
    maps\_lighting::create_dof_preset( "bc_watch_breakage", 25, 420, 4.0, 2000, 18000, 2.0, 0.5 );
    maps\_lighting::create_dof_preset( "bc_catch_moment", 1, 20, 5.0, 20, 295, 2.7, 0.5 );
    maps\_lighting::create_dof_preset( "bc_bus_overboard", 25, 215, 4.0, 5000, 9000, 4.0, 0.5 );
    maps\_lighting::create_dof_preset( "bc_jump_in", 10, 60, 4.0, 61, 100, 2.0, 0.5 );
    maps\_lighting::create_dof_preset( "dof_disable", 0, 10, 0.0, 5000, 20000, 0.0, 0.5 );
}

setup_crash_events()
{
    common_scripts\utility::flag_wait( "flag_player_crashed" );
    thread script_probe_pitbull_default();
    level.defaultsundir = getmapsunangles();
    lerpsunangles( level.defaultsundir, ( -24.5, 125, 0 ), 1.0 );

    if ( level.nextgen )
        maps\_utility::fog_set_changes( "sanfran", 1 );
    else
        maps\_utility::vision_set_fog_changes( "sanfran", 0.0 );

    thread pitbull_crashed_dof();
    level.player _meth_83C0( "setup_crash_events" );
    wait 5;
    wait 9.25;
    level.player _meth_83C0( "after_crash" );
    wait 7.5;
    lerpsunangles( ( -24.5, 125, 0 ), level.defaultsundir, 0.25 );
    level.player _meth_83C0( "set_street_lighting" );
    wait 2.5;
    resetsundirection();
}

lerp_sun()
{
    resetsundirection();
}

lerp_sun_cargo_ship()
{
    lerpsunangles( ( -24.5, 127.1, 0 ), ( -20, 160, 0 ), 0.01, 0, 0 );
}

script_probe_pitbull_tunnel_interior()
{
    var_0 = getent( "refl_pitbull_tunnel_interior", "targetname" );
    level.burke _meth_83AB( var_0.origin );
    level.saint _meth_83AB( var_0.origin );
    level.player_pitbull.fake_vehicle_model _meth_83AB( var_0.origin );
    level.player_pitbull.player_rig _meth_83AB( var_0.origin );
    var_1 = getent( "lighting_centroid_burke", "targetname" );
    level.burke _meth_847B( var_1.origin );
}

script_probe_pitbull_tunnel_exterior()
{
    self waittill( "trigger" );
    var_0 = getent( "refl_pitbull_tunnel_exterior", "targetname" );
    level.burke _meth_83AB( var_0.origin );
    level.burke _meth_847C();
    level.saint _meth_83AB( var_0.origin );
    level.player_pitbull.fake_vehicle_model _meth_83AB( var_0.origin );
    level.player_pitbull.player_rig _meth_83AB( var_0.origin );
}

script_probe_pitbull_tunnel_exterior_no_trigger()
{
    var_0 = getent( "refl_pitbull_tunnel_exterior", "targetname" );
    level.burke _meth_83AB( var_0.origin );
    level.saint _meth_83AB( var_0.origin );
    level.player_pitbull.fake_vehicle_model _meth_83AB( var_0.origin );
    level.player_pitbull.player_rig _meth_83AB( var_0.origin );
}

script_probe_pitbull_default()
{
    level.burke _meth_83AC();
    level.saint _meth_83AC();
    level.player_pitbull.fake_vehicle_model _meth_83AC();
    level.player_pitbull.player_rig _meth_83AC();
}

setup_pitbull_vfx_lights()
{
    var_0 = level.burke;

    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_804D( var_0, "J_Head", ( 5, -10, 0 ), ( 0, 0, 0 ), 0 );
}

setup_vfx_sunflare()
{
    thread maps\_shg_fx::vfx_sunflare( "sanfran_sunflare_a" );
}

move_sunflare_back()
{
    self waittill( "trigger" );
    setsunflareposition( ( -24.5, 127.1, 0 ) );
}

move_sunflare_back_startpoints()
{
    setsunflareposition( ( -24.5, 127.1, 0 ) );
}

vision_set_sanfran()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_sanfran_exterior", 1 );
        maps\_utility::vision_set_changes( "sanfran_neutral", 1.0 );
        maps\_utility::fog_set_changes( "sanfran_oncoming", 1.0 );
    }
    else
        maps\_utility::vision_set_changes( "sanfran_oncoming", 1.0 );
}

setup_drive_shadows()
{
    self waittill( "trigger" );
    level.player _meth_83C0( "setup_drive_shadows" );
}
