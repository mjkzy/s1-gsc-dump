// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

lighting_begin_preload()
{
    common_scripts\utility::flag_init( "intro_begin" );
    common_scripts\utility::flag_init( "player_under_car" );
    common_scripts\utility::flag_init( "introscreen1_complete" );
    common_scripts\utility::flag_init( "player_grappled_to_vtol" );
}

main()
{
    thread lighting_begin_preload();
    thread setup_flickerlight_motion_presets();
    thread set_level_lighting_values();
    thread set_hemi_ao();
    thread irons_estate_vignette();
    thread irons_estate_outside_vision_setup();
    thread irons_estate_briefing_setup();
    thread lerp_spot_briefing();
    thread force_bounce_on_briefing_hanger();
    thread force_bounce_on_briefing_hanger_02();
    thread irons_estate_waterfall_cave_setup();
    thread irons_estate_waterfall_setup();
    thread irons_estate_waterfall_debug_checkpoint();
    thread irons_estate_intro_reveal_setup();
    thread irons_estate_intro_reveal_setup_debug_checkpoint();
    thread irons_estate_tutorial_setup();
    thread irons_estate_recon_setup();
    thread irons_estate_security_center_setup();
    thread irons_estate_security_center_debug_checkpoint();
    thread irons_estate_security_center_exit_setup();
    thread garage_door_shut_off();
    thread irons_estate_penthouse_setup();

    if ( level.currentgen )
        thread irons_estate_penthouse_cormack_setup();

    thread irons_estate_intel_debug_checkpoint();
    thread irons_estate_elevator_dof();
    thread irons_estate_car_setup();
    thread irons_estate_hanger_setup();
    thread force_bounce_on();
    thread plant_tracker_debug_checkpoint();
    thread irons_estate_exfil_setup();
    thread plant_tracker_light_model_swap();
    thread irons_estate_plane_setup();
    thread irons_estate_underwater_setup();

    if ( level.start_point == "briefing" || level.start_point == "intro" || level.start_point == "grapple" || level.start_point == "recon" || level.start_point == "infil" || level.start_point == "security_center" || level.start_point == "hack_security" )
    {
        thread set_security_lights();
        thread set_security_center_tv();
    }
}

setup_flickerlight_motion_presets()
{
    if ( level.nextgen )
    {
        maps\_lighting::create_flickerlight_motion_preset( "water_motion_large", ( 0.83, 0.94, 1 ), 710, 1, 0.1, 0.12 );
        maps\_lighting::create_flickerlight_motion_preset( "fire_motion_medium", ( 1, 0.2246, 0 ), 600, 2, 0.1, 0.2 );
    }
    else
    {
        maps\_lighting::create_flickerlight_motion_preset( "water_motion_large", ( 0.55, 0.83, 1 ), 2000, 1, 0.1, 0.12 );
        maps\_lighting::create_flickerlight_motion_preset( "fire_motion_medium", ( 1, 0.2246, 0 ), 3000, 2, 0.05, 0.2 );
    }
}

set_level_lighting_values()
{
    if ( _func_235() )
    {
        _func_0D3( "r_disableLightSets", 0 );
        level.player _meth_83C0( "irons_estate" );
    }

    if ( level.currentgen )
    {
        _func_0D3( "r_gunSightColorEntityScale", 0.7 );
        _func_0D3( "r_gunSightColorNoneScale", 0.2 );
    }
}

set_hemi_ao()
{
    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );
}

irons_estate_vignette()
{
    level.player thread maps\_lighting::screen_effect_base( 0, "ac130_overlay_pip_vignette", 0, 0, 1, 0, 0 );
}

irons_estate_outside_vision_setup()
{
    level.player _meth_83C0( "irons_estate" );
    maps\_utility::vision_set_fog_changes( "irons_estate", 0 );
    level.player _meth_8490( "clut_base_default", 0 );
}

irons_estate_briefing_setup()
{
    common_scripts\utility::flag_wait( "introscreen1_complete" );
    level.player _meth_83C0( "irons_estate_briefing" );
    maps\_utility::vision_set_fog_changes( "irons_estate_briefing", 0 );
    level.player _meth_8490( "clut_base_briefing", 0 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    level.player _meth_84A9();
    level.player _meth_84AB( 13, 27, 1, 1 );
    wait 8;
    level.player _meth_84AB( 11, 27, 1, 1 );
    level waittill( "player_can_move" );
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    maps\_lighting::lerp_spot_intensity( "Illona_briefing_fill", 1, 0 );
    maps\_lighting::lerp_spot_intensity( "Illona_briefing_bounce", 1, 0 );
}

lerp_spot_briefing()
{
    common_scripts\utility::flag_wait( "introscreen1_complete" );
    wait 26;

    if ( level.nextgen )
        maps\_lighting::lerp_spot_intensity( "cormack_briefing_shadow", 1, 0 );
}

force_bounce_on_briefing_hanger()
{
    if ( level.nextgen )
    {
        var_0 = getent( "briefing_hanger_lod", "targetname" );
        var_0 _meth_8498( "force_on" );
        common_scripts\utility::flag_wait( "intro_begin" );
        var_0 _meth_8498( "force_off" );
    }
}

force_bounce_on_briefing_hanger_02()
{
    if ( level.nextgen )
    {
        var_0 = getent( "briefing_hanger_lod_02", "targetname" );
        var_0 _meth_8498( "force_on" );
        common_scripts\utility::flag_wait( "intro_begin" );
        var_0 _meth_8498( "force_off" );
    }
}

irons_estate_waterfall_cave_setup()
{
    common_scripts\utility::flag_wait( "intro_begin" );
    maps\_lighting::play_flickerlight_motion_preset( "water_motion_large", "water_shim_01" );
    level.player _meth_83C0( "irons_estate_waterfall_intro" );

    if ( level.nextgen )
    {
        maps\_utility::vision_set_fog_changes( "irons_estate_waterfall_intro", 0 );
        level.player _meth_8490( "clut_base_default", 0 );
    }
    else
    {
        maps\_utility::vision_set_fog_changes( "irons_estate_waterfall_intro", 0.1 );
        level.player _meth_8490( "clut_base_cave", 0.1 );
    }

    common_scripts\utility::flag_wait( "drone_passed" );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_waterfall_setup()
{
    common_scripts\utility::flag_wait( "intro_waterfall_dof" );
    maps\_lighting::play_flickerlight_motion_preset( "water_motion_large", "water_shim_01" );
    level.player _meth_83C0( "irons_estate_waterfall" );
    maps\_utility::vision_set_fog_changes( "irons_estate_waterfall", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "water_shim_off" );
    maps\_lighting::stop_flickerlight( "water_motion_large", "water_shim_01", 0 );
}

irons_estate_waterfall_debug_checkpoint()
{
    common_scripts\utility::flag_wait( "grapple_debug" );
    maps\_lighting::play_flickerlight_motion_preset( "water_motion_large", "water_shim_01" );
    level.player _meth_83C0( "irons_estate_waterfall" );
    maps\_utility::vision_set_fog_changes( "irons_estate_waterfall", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "water_shim_off" );
    maps\_lighting::stop_flickerlight( "water_motion_large", "water_shim_01", 0 );
}

irons_estate_intro_reveal_setup()
{
    common_scripts\utility::flag_wait( "spawn_infil_enemies" );
    level.player _meth_83C0( "irons_estate_intro_reveal" );
    maps\_utility::vision_set_fog_changes( "irons_estate_intro_reveal", 0.1 );
    level.player _meth_8490( "clut_base_default", 0.1 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_intro_reveal_setup_debug_checkpoint()
{
    common_scripts\utility::flag_wait( "irons_estate_recon_dof" );
    level.player _meth_83C0( "irons_estate_intro_reveal" );
    maps\_utility::vision_set_fog_changes( "irons_estate_intro_reveal", 0 );
    level.player _meth_8490( "clut_base_default", 0 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_tutorial_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_tutorial_dof" );
    level.player _meth_83C0( "irons_estate_tutorial" );
    maps\_utility::vision_set_fog_changes( "irons_estate_tutorial", 1 );
    level.player _meth_8490( "clut_base_default", 1 );
    level.player _meth_84A9();
    level.player _meth_84AB( 1.12, 548, 1, 1 );
    common_scripts\utility::flag_wait( "stealth_display_tutorial_over" );
    level.player _meth_84AA();
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_recon_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_tutorial_end" );
    level.player _meth_83C0( "irons_estate" );
    maps\_utility::vision_set_fog_changes( "irons_estate", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_security_center_setup()
{
    level waittill( "player_planting_emp" );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbCameraRotationInfluence", "1" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 8, 15, 1, 1 );
    common_scripts\utility::flag_wait( "security_center_enter_anim_done" );
    level.player _meth_84AA();
    _func_0D3( "r_mbEnable", "0" );
    level.player _meth_83C0( "irons_estate_security_center" );
    maps\_utility::vision_set_fog_changes( "irons_estate_security_center", 2 );
    level.player _meth_8490( "clut_base_security_center", 2 );
    common_scripts\utility::flag_wait( "handprint_start" );
    level.player _meth_84A9();
    level.player _meth_84AB( 17, 0, 1, 1 );
    wait 3;
    level.player _meth_84AA();
    setsunflareposition( ( -45, -15, 0 ) );
}

irons_estate_security_center_debug_checkpoint()
{
    common_scripts\utility::flag_wait( "inside_security_center" );
    level.player _meth_83C0( "irons_estate_security_center" );
    maps\_utility::vision_set_fog_changes( "irons_estate_security_center", 0 );
    level.player _meth_8490( "clut_base_security_center", 0 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "handprint_start" );
    level.player _meth_84A9();
    level.player _meth_84AB( 17, 0, 1, 1 );
    wait 3;
    level.player _meth_84AA();
}

irons_estate_penthouse_cormack_setup()
{

}

irons_estate_security_center_exit_setup()
{
    common_scripts\utility::flag_wait( "outside_security_center" );
    level.player _meth_83C0( "irons_estate" );
    maps\_utility::vision_set_fog_changes( "irons_estate", 10 );
    level.player _meth_8490( "clut_base_default", 10 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "firelight_on" );
    maps\_lighting::play_flickerlight_motion_preset( "fire_motion_medium", "fireplace_01" );
}

garage_door_shut_off()
{
    var_0 = getent( "garage_light_source_off", "targetname" );
    var_1 = getent( "garage_light_source_on", "targetname" );
    var_1 show();
    var_0 hide();
    common_scripts\utility::flag_wait( "garage_door_light_off" );
    var_0 show();
    var_1 hide();
    var_2 = getent( "garage_door_light", "targetname" );
    var_2 _meth_81DF( 0 );
}

irons_estate_penthouse_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_penthouse_dof" );
    maps\_lighting::play_flickerlight_motion_preset( "fire_motion_medium", "fireplace_01" );
    level.player _meth_83C0( "irons_estate_penthouse" );
    maps\_utility::vision_set_fog_changes( "irons_estate_penthouse", 4 );
    level.player _meth_8490( "clut_base_default", 1 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "player_used_intel_trigger" );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 8, 15, 1, 1 );
    common_scripts\utility::flag_wait( "player_finished_desk_anim" );
    level.player _meth_84AA();
    _func_0D3( "r_mbEnable", "0" );
    common_scripts\utility::flag_wait( "firelight_off" ) maps\_lighting::stop_flickerlight( "fire_motion_medium", "fireplace_01", 0 );
}

irons_estate_intel_debug_checkpoint()
{
    common_scripts\utility::flag_wait( "intel_debug_lighting" );
    maps\_lighting::play_flickerlight_motion_preset( "fire_motion_medium", "fireplace_01" );
    level.player _meth_83C0( "irons_estate_penthouse" );
    maps\_utility::vision_set_fog_changes( "irons_estate_penthouse", 1 );
    level.player _meth_8490( "clut_base_default", 1 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "player_used_intel_trigger" );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 22, 49, 1, 1 );
    common_scripts\utility::flag_wait( "player_finished_desk_anim" );
    level.player _meth_84AA();
    _func_0D3( "r_mbEnable", "0" );
    common_scripts\utility::flag_wait( "firelight_off" ) maps\_lighting::stop_flickerlight( "fire_motion_medium", "fireplace_01", 0 );
}

irons_estate_elevator_dof()
{
    common_scripts\utility::flag_wait( "elevator_rappel_start" );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 18, 0, 1, 1 );
    wait 2;
    level.player _meth_84AB( 5, 0, 1, 1 );
    wait 2;
    level.player _meth_84AA();
    _func_0D3( "r_mbEnable", "0" );

    if ( level.currentgen )
    {
        var_0 = getent( "guard_house_exit_light", "targetname" );
        var_0 _meth_81DF( 15000 );
    }
}

irons_estate_car_setup()
{
    common_scripts\utility::flag_wait( "player_under_car" );
    wait 2;
    level.player _meth_83C0( "irons_estate_car" );
    maps\_utility::vision_set_fog_changes( "irons_estate_car", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    wait 16;
    maps\_utility::vision_set_fog_changes( "irons_estate_hanger", 2 );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbCameraRotationInfluence", "1" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 3, 22, 1, 1 );
    common_scripts\utility::flag_wait( "track_irons_start" );
    level.player _meth_84AA();
    _func_0D3( "r_mbEnable", "0" );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
}

irons_estate_hanger_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_hanger_dof" );
    maps\_lighting::lerp_spot_intensity( "spacey_bounce", 0, 0 );
    level.player _meth_83C0( "irons_estate_hanger" );
    maps\_utility::vision_set_fog_changes( "irons_estate_hanger", 2 );
    level.player _meth_8490( "clut_base_default", 0 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    common_scripts\utility::flag_wait( "at_listening_position" );
    maps\_lighting::lerp_spot_intensity( "spacey_bounce", 0, 2000 );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    level.player _meth_84A9();
    level.player _meth_84AB( 10, 500, 1, 1 );
    wait 7;
    level.player _meth_84AB( 35, 500, 1, 1 );
    wait 6;
    level.player _meth_84AB( 30, 540, 1, 1 );
    common_scripts\utility::flag_wait( "track_irons_end" );
    level.player _meth_84AA();
    maps\_lighting::lerp_spot_intensity( "spacey_bounce", 1, 0 );
    _func_0D3( "r_mbEnable", "0" );
}

force_bounce_on()
{
    common_scripts\utility::flag_wait( "bounce_force_on" );
    var_0 = getent( "spacey_bounce_force_on", "targetname" );
    var_0 _meth_8498( "force_on" );
    common_scripts\utility::flag_wait( "bounce_force_off" );
    var_0 _meth_8498( "force_off" );
}

plant_tracker_debug_checkpoint()
{
    common_scripts\utility::flag_wait( "irons_estate_plant_tracker_debug" );
    level.player _meth_83C0( "irons_estate_hanger" );
    maps\_utility::vision_set_fog_changes( "irons_estate_hanger", 0 );
    level.player _meth_8490( "clut_base_default", 0 );
}

irons_estate_exfil_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_exfil" );
    level.player _meth_83C0( "irons_estate_exfil" );
    maps\_utility::vision_set_fog_changes( "irons_estate_exfil", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );
    playfxontag( level._effect["ie_light_red_cormack_plane"], level.vtol, "TAG_LT_WING_CORMACK_LIGHT" );
    playfxontag( level._effect["ie_light_red_cormack_plane"], level.vtol, "TAG_RT_WING_CORMACK_LIGHT" );
}

plant_tracker_light_model_swap()
{
    var_0 = getent( "plant_tracker_blue_light_off", "targetname" );
    var_1 = getent( "plant_tracker_blue_light_on", "targetname" );
    var_0 show();
    var_1 hide();
    common_scripts\utility::flag_wait( "model_swap_light" );
    var_1 show();
    var_0 hide();
}

irons_estate_plane_setup()
{
    common_scripts\utility::flag_wait( "player_grappled_to_vtol" );
    level.player _meth_83C0( "irons_estate_plane" );
    maps\_utility::vision_set_fog_changes( "irons_estate_plane", 2 );
    level.player _meth_8490( "clut_base_default", 2 );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    if ( level.nextgen )
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 5, 29, 1, 1 );
        wait 2;
        level.player _meth_84AB( 9, 0, 1, 1 );
        wait 2;
        level.player _meth_84AB( 5, 29, 1, 1 );
        wait 4;
        level.player _meth_84AB( 6, 30, 1, 1 );
        wait 2;
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 0.6816, 47.298, 1, 1 );
        wait 1.5;
        level.player _meth_84AB( 5.84, 0, 1, 1 );
        wait 2;
        level.player _meth_84AB( 2.66, 30, 1, 1 );
        wait 4;
        level.player _meth_84AB( 1.6, 100, 1, 1 );
        wait 2;
    }

    maps\_utility::vision_set_fog_changes( "irons_estate_plane_drop", 2 );
}

irons_estate_underwater_setup()
{
    common_scripts\utility::flag_wait( "irons_estate_underwater_dof" );
    level.player.underwater = 1;
    level.player thread maps\_water::underwaterbubbles();
    level.player thread maps\_water::underwatercloudy();
    level.player _meth_83C0( "irons_estate_underwater_waterfall" );
    maps\_utility::vision_set_fog_changes( "irons_estate_underwater_waterfall", 0 );
    level.player _meth_8490( "clut_base_default", 0 );
    level.player _meth_8218( 1, 2.0 );
    level.player playlocalsound( "underwater_enter" );
    setsunflareposition( ( -44.0771, 52.229, 0 ) );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    if ( level.nextgen )
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 9.8, 24, 1, 1 );
    }
    else
    {
        level.player _meth_84A9();
        level.player _meth_84AB( 1.65, 110, 1, 1 );
    }
}

pre_hack_security_check()
{
    if ( level.start_point == "hack_security" )
        return 0;
    else
        return 1;
}

set_security_lights()
{
    self endon( "death" );
    var_0 = getentarray( "set_security_lights", "script_noteworthy" );

    if ( pre_hack_security_check() )
    {
        foreach ( var_2 in var_0 )
            var_2 _meth_81DF( 0 );

        common_scripts\utility::flag_wait( "security_center_wake_up" );
        var_4 = 6;
        var_5 = 1;
        var_6 = randomfloatrange( 0.05, 0.1 );

        while ( var_5 < var_4 )
        {
            foreach ( var_2 in var_0 )
                var_2 _meth_81DF( 200 );

            wait(var_6);

            foreach ( var_2 in var_0 )
                var_2 _meth_81DF( 0 );

            var_5++;
            wait(var_6);
        }
    }

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 6000 );
}

set_security_center_tv()
{
    self endon( "death" );
    var_0 = getentarray( "set_security_center_tv", "script_noteworthy" );

    if ( pre_hack_security_check() )
    {
        foreach ( var_2 in var_0 )
            var_2 _meth_81DF( 0 );

        common_scripts\utility::flag_wait( "security_center_wake_up" );
        var_4 = 6;
        var_5 = 0;
        var_6 = randomfloatrange( 0.05, 0.1 );

        while ( var_5 < var_4 )
        {
            foreach ( var_2 in var_0 )
            {
                if ( level.nextgen )
                {
                    var_2 _meth_81DF( 800 );
                    continue;
                }

                var_2 _meth_81DF( 1000 );
            }

            wait(var_6);

            foreach ( var_2 in var_0 )
                var_2 _meth_81DF( 0 );

            var_5++;
            wait(var_6);
        }
    }

    foreach ( var_2 in var_0 )
    {
        if ( level.nextgen )
        {
            var_2 _meth_81DF( 800 );
            continue;
        }

        var_2 _meth_81DF( 1000 );
    }

    thread maps\irons_estate_code::security_center_bink();
    thread maps\irons_estate_code::security_center_main_screen_bink( undefined, 1 );
    var_13 = getent( "security_center_desk_screen", "targetname" );
    var_13 show();
}

tennis_court_lights_intial()
{
    var_0 = getentarray( "tennis_court_net_light", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 800 );

    var_4 = getentarray( "tennis_court_light", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 _meth_81DF( 100 );
}

tennis_court_lights_dimmed()
{
    var_0 = getentarray( "tennis_court_net_light", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 400 );

    var_4 = getentarray( "tennis_court_light", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 _meth_81DF( 50 );
}

tennis_court_lights_on()
{
    var_0 = getentarray( "tennis_court_net_light", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 800 );

    var_4 = getentarray( "tennis_court_light", "script_noteworthy" );

    foreach ( var_2 in var_4 )
        var_2 _meth_81DF( 100 );
}
