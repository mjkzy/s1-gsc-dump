// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread set_level_lighting_values();
    init_level_lighting_flags();
    thread setup_flickerlight_presets();
    thread lab_climb_lighting();
    thread breach_lighting();
    thread breach_dof();
    thread setup_dof_default_interior();
    thread setup_server_room_lighting();
    thread setup_dof_server_room();
    thread setup_server_room_door_open_lighting();
    thread setup_orange_room_enter_volume();
    thread setup_orange_room_exit_volume();
    thread setup_dof_mini_atrium();
    thread setup_sunlight_off();
    thread lighting_vehicle_takedown_01_lerp();
    thread tank_reveal_lighting();
    thread tank_reveal_models();
    thread sun_light_reset();
    thread outer_space_lighting();
    thread red_light_strobe_courtyard();
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
}

init_level_lighting_flags()
{
    common_scripts\utility::flag_init( "breach_start" );
    common_scripts\utility::flag_init( "player_climbing_wall_lighting" );
    common_scripts\utility::flag_init( "flag_forest_climb_wall_complete_lighting" );
    common_scripts\utility::flag_init( "flag_rappel_start_lighting" );
    common_scripts\utility::flag_init( "open_server_room_door_lighting" );
    common_scripts\utility::flag_init( "bio_weapons_hack_lighting" );
    common_scripts\utility::flag_init( "flag_server_room_start_lighting" );
}

set_level_lighting_values()
{
    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );

    if ( _func_235() )
    {
        _func_0D3( "r_disableLightSets", 0 );
        setsunflareposition( ( -30, 110, 0 ) );

        if ( level.currentgen )
            level.player _meth_83C0( "crash_hut" );

        if ( level.nextgen )
            _func_0D3( "r_dynamicOpl", 1 );
    }
}

setup_flickerlight_presets()
{
    maps\_lighting::create_flickerlight_preset( "server_room_fire", ( 1, 0.4246, 0.2 ), ( 0.26, 0.06, 0 ), 0.005, 0.2, 8 );
}

lab()
{
    level.player _meth_83C0( "lab" );
    thread enable_motion_blur_rotation();
    thread maps\_utility::vision_set_fog_changes( "lab", 0 );
    level.player _meth_8490( "clut_lab_exterior", 0 );
    thread intro_dof();
    thread crash_fire_light();
    thread hill_slide();
    thread heli_spotlight_exposure_change();
}

intro_dof()
{
    wait 5;

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 2.0, 33.0 );
    wait 15;
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

crash_fire_light()
{
    if ( level.nextgen )
    {
        var_0 = getent( "crash_fire_light", "targetname" );
        var_0 _meth_8044( ( 1, 0.4, 0.1 ) );
        var_0 _meth_81DF( 1000000 );
    }

    wait 12;

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "crash_fire_light", 0.5, 0.0 );
}

heli_spotlight_exposure_change()
{
    wait 14;

    if ( level.nextgen )
        level.player _meth_83C0( "heli_spot_on" );
}

hill_slide()
{
    common_scripts\utility::flag_wait( "flag_player_slide_start" );

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 2.0, 320.0, 30, 30 );
    earthquake( 0.25, 3, level.player.origin, 400 );
    wait 6.0;
    level.player _meth_84AB( 2.0, 500, 30, 30 );
    wait 2;
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

enter_forest()
{
    level.player _meth_83C0( "enter_forest" );
    level.player _meth_8490( "clut_lab_exterior", 0 );
    thread maps\_utility::vision_set_fog_changes( "lab_enter_forest", 0.01 );
    thread enable_motion_blur_rotation();
}

lab_climb_lighting()
{
    wait 0.1;
    thread lt_root_climb_rim_intensity_init();
    thread lt_root_climb_key_intensity_init();
    thread tree_roots_lighting();
    common_scripts\utility::flag_wait( "player_climbing_wall_lighting" );
    thread disable_motion_blur();
    thread lab_root_climb_vision();
    thread lab_root_climb_dof();
    thread lt_root_climb_key_shadow_res();
    thread lab_climb_rim_lighting_off();
}

lt_root_climb_rim_intensity_init()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lt_root_climb_rim", "targetname" );
        wait 0.1;
        var_0 _meth_81DF( 40000 );
    }
}

lt_root_climb_key_intensity_init()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lt_root_climb_key", "targetname" );
        wait 0.1;
        var_0 _meth_81DF( 14000 );
    }
}

lt_root_climb_key_shadow_res()
{
    wait 2;

    if ( level.nextgen )
    {
        var_0 = getent( "lt_root_climb_key", "targetname" );
        var_0 _meth_8020( 40, 30 );
    }

    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete_lighting" );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "lt_root_climb_key", 1.0, 0.0 );

    thread forest_takedown();
}

lab_root_climb_vision()
{
    setsunflareposition( ( -70, 110, 0 ) );
    maps\_utility::vision_set_fog_changes( "lab_root_climb", 1.0 );
}

lab_root_climb_dof()
{
    level.player _meth_84A9();
    level.player _meth_84AB( 2.0, 58.0 );
}

lab_climb_rim_lighting_off()
{
    common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );

    if ( level.nextgen )
        level.player _meth_83C0( "climb_shadow_tweak" );

    level.player _meth_84AB( 3.0, 20.0, 3, 3 );
    wait 2;

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "lt_root_climb_rim", 1.0, 0.0 );

    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete_lighting" );
    level.player _meth_84AA();
    thread disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

tree_roots_lighting()
{
    var_0 = getent( "lighting_reflection_tree", "targetname" );
    var_1 = getent( "lighting_centroid_tree", "targetname" );
    var_2 = getent( "wallclimb_roots", "targetname" );
    var_2 _meth_83AB( var_0.origin );
    var_2 _meth_847B( var_1.origin );
}

forest_takedown()
{
    level.player _meth_83C0( "logging_road" );
    maps\_utility::vision_set_fog_changes( "lab_logging_road", 0 );
    thread forest_takedown_dof();
}

forest_takedown_dof()
{
    common_scripts\utility::flag_wait( "flag_se_takedown_01_started" );
    thread enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 2.0, 25.0, 30, 30 );
    wait 5.5;
    level.player _meth_84AB( 2.0, 75.0, 5, 5 );
    wait 1.5;
    level.player _meth_84AA();
    thread disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

logging_road()
{
    level.player _meth_83C0( "logging_road" );
    maps\_utility::vision_set_fog_changes( "lab_logging_road", 0 );
    level.player _meth_8490( "clut_lab_exterior", 0 );
}

vrap_takedown_lights_on()
{
    if ( level.nextgen )
    {
        wait 0.1;
        var_0 = getent( "head_lights_vrap_takedown_b", "targetname" );
        var_1 = getent( "head_lights_vrap_takedown_c", "targetname" );
        wait 1;
        var_0 _meth_81DF( 1000000 );
    }
}

vrap_takedown_lights_off( var_0 )
{
    if ( level.nextgen )
    {
        wait 0.1;
        var_1 = getent( "head_lights_vrap_takedown_b", "targetname" );
        var_2 = getent( "head_lights_vrap_takedown_c", "targetname" );
        wait 0.1;
        var_1 _meth_81DF( 0 );
        var_2 _meth_81DF( 0 );
    }

    soundscripts\_snd::snd_message( "takedown_truck_lights_off" );
    level notify( "takedown_lights_off" );
}

lighting_vehicle_takedown_01_on()
{
    wait 0.05;
    common_scripts\_exploder::exploder( 2132 );

    if ( level.nextgen )
    {
        var_0 = getent( "take_down_light_01", "targetname" );
        var_1 = getent( "take_down_light_02", "targetname" );
        wait 0.05;
        var_0 _meth_81DF( 10000 );
        wait 0.05;
        var_1 _meth_81DF( 10000 );
        level waittill( "takedown_lights_off" );
    }

    maps\_utility::stop_exploder( 2132 );
}

lighting_vehicle_takedown_01_lerp()
{
    level waittill( "takedown_lights_off" );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "take_down_light_01", 0.5, 0 );
        thread maps\_lighting::lerp_spot_intensity( "take_down_light_02", 0.5, 0 );
    }
}

lighting_vehicle_takedown_01( var_0 )
{
    if ( isdefined( var_0.helmet_tag ) )
        var_0.helmet_tag delete();

    var_0.helmet_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.helmet_tag;
    var_1 _meth_804D( var_0, "J_Head", ( 0, 55, 0 ), ( 0, 0, 0 ), 0 );
    thread vehicle_takedown_01_dof();
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "point_blue_fill" ), var_1, "tag_origin" );
    wait 2.3;
    stopfxontag( common_scripts\utility::getfx( "point_blue_fill" ), var_1, "tag_origin" );
}

vehicle_takedown_01_dof()
{
    thread enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 3.0, 65, 30, 30 );
    wait 2.7;
    level.player _meth_84AB( 2.0, 115, 30, 30 );
    wait 7.0;
    thread disable_motion_blur();
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

logging_road_gaz_headlight_moment()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( "headlight_gaz_spotlight" ), var_0, "tag_origin" );
    var_0 _meth_804D( self, "TAG_HEADLIGHT_LEFT", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    wait 20;
    killfxontag( common_scripts\utility::getfx( "headlight_gaz_spotlight" ), var_0, "tag_origin" );
}

logging_road_post_vrap()
{
    level.player _meth_83C0( "logging_road_post_vrap" );
    maps\_utility::vision_set_fog_changes( "lab_logging_road_post_vrap", 0 );
}

cliff_rappel()
{
    level.player _meth_83C0( "cliff_rappel" );
    thread maps\_utility::vision_set_fog_changes( "lab_cliff_rappel", 0 );
    level.player _meth_8490( "clut_lab_exterior", 0 );
}

cliff_rappel_lighting_setup()
{
    thread cliff_rappel_lighting_init();
    thread cliff_rappel_moment();
    thread cliff_rappel_landing();
}

cliff_rappel_lighting_init()
{
    if ( level.nextgen )
    {
        var_0 = getent( "cliff_light_key", "targetname" );
        var_1 = getent( "cliff_light_fill", "targetname" );
        var_2 = getent( "cliff_light_rim", "targetname" );
        thread maps\_lighting::lerp_spot_intensity( "cliff_light_key", 1, 200000 );
        var_0 _meth_8044( ( 1, 1, 1 ) );
        thread maps\_lighting::lerp_spot_intensity( "cliff_light_fill", 1, 600000 );
        thread maps\_lighting::lerp_spot_intensity( "cliff_light_rim", 1, 500000 );
        common_scripts\utility::flag_wait( "flag_rappel_start_lighting" );
        var_0 _meth_8020( 28, 24 );
        var_1 _meth_8020( 40, 33 );
        var_2 _meth_8020( 45, 40 );
    }
}

cliff_rappel_moment()
{
    common_scripts\utility::flag_wait( "flag_rappel_start_lighting" );
    thread cliff_rappel_shadow_tweaks();
    maps\_utility::vision_set_fog_changes( "lab_cliff_rappel_moment", 2.5 );
    thread enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    wait 1.5;
    level.player _meth_84AB( 2.0, 15.0, 30, 30 );
    wait 4.0;
    level.player _meth_84AB( 2.0, 38, 30, 30 );
    wait 5.5;
    level.player _meth_84AB( 5, 50, 30, 30 );
}

cliff_rappel_shadow_tweaks()
{
    wait 0.45;
    level.player _meth_83C0( "cliff_rappel_spike" );
    wait 5.5;
    level.player _meth_83C0( "cliff_rappel_moment" );
    wait 3.5;
    level.player _meth_83C0( "cliff_rappel_jump" );
    wait 3;
    level.player _meth_83C0( "cliff_rappel_moment" );
    common_scripts\utility::flag_wait( "flag_rappel_player_input_start" );

    if ( level.nextgen )
        level.player _meth_83C0( "facility_breach" );
}

cliff_rappel_lerpsun()
{
    if ( level.nextgen )
    {
        wait 0.45;
        lerpsunangles( ( -50, 110, 0 ), ( -50, -11, 0 ), 0.1, 0, 0 );
        wait 5.5;
        lerpsunangles( ( -50, -11, 0 ), ( -50, 110, 0 ), 0.1, 0, 0 );
    }
}

cliff_rappel_landing()
{
    level waittill( "cliff_rappel_landing" );
    thread maps\_utility::vision_set_fog_changes( "lab_facility_breach", 2 );
    thread lab_camera_light();
    level.player _meth_84AA();
    thread disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

lab_camera_light()
{
    if ( level.nextgen )
    {
        var_0 = getent( "lab_camera_light", "targetname" );
        var_0 _meth_81DF( 500000 );
        var_0 _meth_8044( ( 0.3, 0.5, 1 ) );
        common_scripts\utility::flag_wait( "flag_light_security_camera_off" );
        var_0 _meth_81DF( 0 );
    }
}

facility_breach()
{
    level.player _meth_83C0( "facility_breach" );
    maps\_utility::vision_set_fog_changes( "lab_facility_breach", 0 );
    level.player _meth_8490( "clut_lab_exterior", 0 );
    thread lab_camera_light();
}

breach_fx()
{
    common_scripts\_exploder::exploder( "breach_smoke_1" );

    if ( level.currentgen )
        return;
}

breach_lighting()
{
    if ( level.nextgen )
    {
        wait 1;
        thread maps\_lighting::lerp_spot_intensity( "lab_breach_key", 2, 100000 );
        common_scripts\utility::flag_wait( "breach_start" );
        thread maps\_utility::sun_light_fade( ( 0.5, 0.5, 0.5 ), ( 0.1, 0.1, 0.1 ), 1.0 );
        thread enable_motion_blur_rotation();
        thread maps\_lighting::lerp_spot_intensity( "lab_breach_rim", 2, 300000 );
        wait 1.8;
        thread maps\_utility::vision_set_fog_changes( "lab_facility_breach_moment", 0.1 );
        level.player _meth_83C0( "facility_breach_moment" );
        wait 10.25;
        thread disable_motion_blur();
        level.player _meth_83C0( "breach_room" );
        level.player _meth_8490( "clut_lab_breach_brick_interior", 0.25 );
        thread maps\_utility::vision_set_fog_changes( "lab_facility_breach_room", 5 );
    }

    if ( level.currentgen )
    {
        wait 1;
        common_scripts\utility::flag_wait( "breach_start" );
        wait 1.8;
        thread maps\_utility::vision_set_fog_changes( "lab_facility_breach_moment", 0.1 );
        level.player _meth_83C0( "facility_breach_moment" );
        wait 8.0;
        level.player _meth_83C0( "breach_fx" );
        wait 2;
        level.player _meth_83C0( "breach_room" );
    }
}

breach_dof()
{
    common_scripts\utility::flag_wait( "breach_start" );

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 1.0, 61, 30, 30 );
    wait 1.5;
    level.player _meth_84AB( 1.5, 19, 30, 30 );
    wait 2;
    level.player _meth_84AB( 1.5, 93, 30, 30 );
    wait 10.0;
    level.player _meth_84AA();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

setup_dof_default_interior()
{
    var_0 = getentarray( "lab_DOF_default_interior_volume", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread setup_dof_default_interior_volume();
}

setup_dof_default_interior_volume()
{
    for (;;)
        self waittill( "trigger" );
}

building_1()
{
    level.player _meth_83C0( "building_1_bright" );
    maps\_utility::vision_set_fog_changes( "lab_building_1", 0 );
    level.player _meth_8490( "clut_lab_breach_interior", 0.25 );
}

setup_server_room_lighting()
{
    wait 1.0;
    common_scripts\utility::flag_wait( "flag_server_room_start_lighting" );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "lab_server_room_fill", 1, 175000 );

    resetsunlight();
    common_scripts\_exploder::exploder( 4031 );
    common_scripts\_exploder::exploder( 4032 );
    common_scripts\_exploder::exploder( 4033 );
    common_scripts\_exploder::exploder( 4034 );
    common_scripts\utility::flag_wait( "bio_weapons_hack_lighting" );
    wait 24.5;
    common_scripts\_exploder::kill_exploder( 4031 );
    common_scripts\_exploder::kill_exploder( 4032 );
    common_scripts\_exploder::exploder( 4132 );
    wait 3.4;
    common_scripts\_exploder::kill_exploder( 4033 );
    common_scripts\_exploder::exploder( 4133 );

    if ( level.nextgen )
        maps\_lighting::play_flickerlight_preset( "server_room_fire", "server_room_exit_doorway_light", 10000000 );

    wait 4.4;
    common_scripts\_exploder::kill_exploder( 4034 );
    common_scripts\_exploder::exploder( 4134 );

    if ( level.nextgen )
    {
        thread maps\_lighting::lerp_spot_intensity( "lab_server_room_fill", 3, 250000 );
        maps\_lighting::play_flickerlight_preset( "server_room_fire", "lab_server_room_fill", 250000 );
        maps\_lighting::play_flickerlight_preset( "server_room_fire", "server_room_main_rim_light", 250000 );
    }
}

setup_dof_server_room()
{
    common_scripts\utility::flag_wait( "bio_weapons_hack_lighting" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
    }

    level.player _meth_84A9();
    level.player _meth_84AB( 1.2, 200.0 );
    wait 25.9;
    level.player _meth_84AB( 1.2, 57.0 );
    wait 7.4;

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
    }

    level.player _meth_84AA();
}

setup_server_room_door_open_lighting()
{
    common_scripts\utility::flag_wait( "bio_weapons_hack_lighting" );

    if ( level.nextgen )
        thread maps\_lighting::lerp_spot_intensity( "lab_server_door_open", 1, 160000 );

    common_scripts\utility::flag_wait( "open_server_room_door_lighting" );
    wait 0.1;
    level.player _meth_83C0( "after_server_room_bright" );
    wait 5.0;
    level.player _meth_83C0( "building_1" );
}

setup_orange_room_enter_volume()
{
    var_0 = getentarray( "orange_room_enter_volume", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread setup_orange_room_enter();
}

setup_orange_room_enter()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread maps\_lighting::lerp_spot_intensity( "courtyard_exterior_light_01", 1.0, 0 );
    }
}

setup_orange_room_exit_volume()
{
    var_0 = getentarray( "orange_room_exit_volume", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread setup_orange_room_exit();
}

setup_orange_room_exit()
{
    for (;;)
    {
        self waittill( "trigger" );
        thread maps\_lighting::lerp_spot_intensity( "courtyard_exterior_light_01", 1.0, 150000 );
    }
}

building_research_bridge()
{
    level.player _meth_83C0( "building_1" );
    maps\_utility::vision_set_fog_changes( "lab_connecting_hallway", 0 );
    level.player _meth_8490( "clut_lab_orange_interior", 0.25 );
}

setup_dof_mini_atrium()
{
    var_0 = getentarray( "lab_DOF_mini_atrium_volume", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread setup_dof_mini_atrium_volume();
}

setup_dof_mini_atrium_volume()
{
    for (;;)
        self waittill( "trigger" );
}

setup_sunlight_off()
{
    if ( level.nextgen )
    {
        var_0 = getentarray( "lab_sunlight_tweak_off_volume", "targetname" );

        foreach ( var_2 in var_0 )
            var_2 thread setup_sunlight_off_volume();
    }
}

setup_sunlight_off_volume()
{
    for (;;)
    {
        self waittill( "trigger" );
        wait 0.1;
        setsunlight( 0, 0, 0 );
    }
}

foam_room()
{
    level.player _meth_83C0( "foam_room_frost" );
    maps\_utility::vision_set_fog_changes( "lab_foam_room_frost", 0 );
    level.player _meth_8490( "clut_lab_blue_interior", 0.25 );
}

foam_plant_dof()
{
    enable_motion_blur_rotation();
    wait 1;

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 3.5, 10, 5, 5 );
    wait 2.0;
    level.player _meth_84AB( 3.5, 20, 30, 30 );
    level waittill( "reset_plant_dof" );
    level.player _meth_84AA();
    disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );
}

courtyard()
{
    level.player _meth_83C0( "locker_room" );
    maps\_utility::vision_set_fog_changes( "lab_locker_room", 0 );
    level.player _meth_8490( "clut_lab_blue_interior", 0.25 );

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );
}

courtyard_jammer()
{
    level.player _meth_83C0( "enter_courtyard" );
    maps\_utility::vision_set_fog_changes( "lab_enter_courtyard", 0 );
    level.player _meth_8490( "clut_lab_courtyard", 0.25 );

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );

    level notify( "courtyard_red_strobe" );
}

courtyard_jammer_plant_dof()
{
    enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 2.5, 14, 2, 2 );
    wait 2.5;
    level.player _meth_84AB( 3.5, 25, 2, 2 );
    level waittill( "reset_jammer_plant_dof" );
    level.player _meth_84AA();
    disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
}

courtyard_sun_off()
{
    wait 0.1;

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );
}

tank_hangar()
{
    maps\_utility::vision_set_fog_changes( "lab_courtyard_walkway", 0 );
    level.player _meth_83C0( "courtyard_walkway" );
    level.player _meth_8490( "clut_lab_courtyard", 0.25 );

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );
}

tank_reveal_models()
{
    wait 0.05;
    var_0 = [ "light_models_on_01", "light_models_on_02", "light_models_on_03", "light_models_on_04", "light_models_on_05", "light_models_on_06", "light_models_on_07" ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "targetname" ) )
            var_4 hide();
    }

    var_7 = getent( "tank_top_light_01", "targetname" );
    var_8 = getent( "tank_top_light_02", "targetname" );
    var_9 = getent( "tank_top_light_03", "targetname" );
    var_10 = getent( "tank_top_light_04", "targetname" );

    if ( level.nextgen )
        var_10 _meth_8498( "force_on" );

    var_11 = getent( "tank_top_light_bounce_01", "targetname" );
    var_12 = getent( "tank_top_light_bounce_02", "targetname" );
    var_13 = getent( "tank_top_light_bounce_03", "targetname" );
    var_14 = getent( "tank_top_light_bounce_04", "targetname" );
    common_scripts\utility::flag_wait( "tank_reveal_volume" );

    if ( level.nextgen )
        var_10 _meth_8498( "force_on" );

    common_scripts\_exploder::exploder( 7913 );

    if ( level.nextgen )
    {
        wait 1;
        var_9 _meth_81DF( 1000000 );
        var_13 _meth_81DF( 5000 );
        wait 1;
        var_10 _meth_81DF( 1000000 );
        var_14 _meth_81DF( 5000 );
        wait 1;
        var_7 _meth_81DF( 1000000 );
        var_11 _meth_81DF( 5000 );
        wait 1;
        var_8 _meth_81DF( 1000000 );
        var_12 _meth_81DF( 5000 );
    }

    common_scripts\utility::flag_wait( "player_entering_hovertank" );

    if ( level.nextgen )
        var_10 _meth_8498( "force_off" );
}

tank_reveal_models_start_point()
{
    wait 0.1;
    var_0 = [ "floor_light_models_off_02", "floor_light_models_off_03", "floor_light_models_off_04" ];
    var_1 = [ "Light_dyn_on_01", "Light_dyn_on_02", "Light_dyn_on_03", "Light_dyn_on_04", "Light_dyn_on_05" ];
    var_2 = [ "tank_top_light_01", "tank_top_light_02", "tank_top_light_03", "tank_top_light_04" ];
    var_3 = [ "tank_top_light_bounce_01", "tank_top_light_bounce_02", "tank_top_light_bounce_03", "tank_top_light_bounce_04" ];
    var_4 = [ "light_models_on_01", "light_models_on_02", "light_models_on_03", "light_models_on_04", "light_models_on_05", "light_models_on_06", "light_models_on_07" ];

    foreach ( var_6 in var_4 )
    {
        foreach ( var_8 in getentarray( var_6, "targetname" ) )
            var_8 show();
    }

    foreach ( var_6 in var_0 )
    {
        foreach ( var_8 in getentarray( var_6, "targetname" ) )
            var_8 hide();
    }

    foreach ( var_6 in var_1 )
    {
        foreach ( var_17 in getentarray( var_6, "targetname" ) )
            var_17 _meth_81DF( 100000 );
    }

    foreach ( var_6 in var_2 )
    {
        foreach ( var_17 in getentarray( var_6, "targetname" ) )
            var_17 _meth_81DF( 1000000 );
    }

    foreach ( var_6 in var_3 )
    {
        foreach ( var_17 in getentarray( var_6, "targetname" ) )
            var_17 _meth_81DF( 5000 );
    }

    common_scripts\_exploder::exploder( 7011 );
    common_scripts\_exploder::exploder( 7012 );
    common_scripts\_exploder::exploder( 7013 );
    common_scripts\_exploder::exploder( 7014 );
    common_scripts\_exploder::exploder( 7015 );
}

tank_reveal_lighting()
{
    wait 0.05;
    var_0 = getentarray( "Light_dyn_on_01", "targetname" );
    var_1 = getentarray( "Light_dyn_on_02", "targetname" );
    var_2 = getentarray( "Light_dyn_on_03", "targetname" );
    var_3 = getentarray( "Light_dyn_on_04", "targetname" );
    var_4 = getentarray( "Light_dyn_on_05", "targetname" );
    var_5 = getentarray( "Light_dyn_on_06", "targetname" );
    var_6 = getentarray( "light_models_on_01", "targetname" );
    var_7 = getentarray( "light_models_on_02", "targetname" );
    var_8 = getentarray( "light_models_on_03", "targetname" );
    var_9 = getentarray( "light_models_on_04", "targetname" );
    var_10 = getentarray( "light_models_on_05", "targetname" );
    var_11 = getentarray( "light_models_on_06", "targetname" );
    var_12 = getentarray( "light_models_on_07", "targetname" );
    var_13 = getentarray( "floor_light_models_off_02", "targetname" );
    var_14 = getentarray( "floor_light_models_off_03", "targetname" );
    var_15 = getentarray( "floor_light_models_off_04", "targetname" );
    wait 0.05;
    common_scripts\utility::flag_wait( "tank_reveal_volume" );
    wait 1;
    soundscripts\_snd::snd_message( "hangar_lights_on" );
    common_scripts\_exploder::exploder( 7011 );
    common_scripts\_exploder::exploder( 7021 );

    foreach ( var_17 in var_0 )
        var_17 _meth_81DF( 100000 );

    foreach ( var_20 in var_6 )
        var_20 show();

    wait 1;
    common_scripts\_exploder::exploder( 7012 );
    common_scripts\_exploder::exploder( 7022 );

    foreach ( var_17 in var_1 )
        var_17 _meth_81DF( 100000 );

    foreach ( var_20 in var_7 )
        var_20 show();

    foreach ( var_20 in var_13 )
        var_20 hide();

    var_28 = getent( "blue_flicker", "targetname" );

    if ( isdefined( var_28 ) )
    {
        var_28 _meth_81DF( 55000 );
        var_28 _meth_8498( "force_on" );
    }

    wait 1;
    common_scripts\_exploder::exploder( 7013 );
    common_scripts\_exploder::exploder( 7023 );

    foreach ( var_17 in var_2 )
        var_17 _meth_81DF( 100000 );

    foreach ( var_20 in var_8 )
        var_20 show();

    foreach ( var_20 in var_14 )
        var_20 hide();

    wait 1;
    common_scripts\_exploder::exploder( 7014 );

    foreach ( var_17 in var_3 )
        var_17 _meth_81DF( 100000 );

    foreach ( var_20 in var_9 )
        var_20 show();

    foreach ( var_20 in var_15 )
        var_20 hide();

    wait 1;
    common_scripts\_exploder::exploder( 7015 );

    foreach ( var_17 in var_4 )
        var_17 _meth_81DF( 100000 );

    foreach ( var_17 in var_5 )
        var_17 _meth_81DF( 10000 );

    foreach ( var_20 in var_10 )
        var_20 show();

    wait 1;
    common_scripts\_exploder::exploder( 7016 );

    foreach ( var_20 in var_11 )
        var_20 show();

    wait 1;
    common_scripts\_exploder::exploder( 7017 );
    level waittill( "stair_lights" );

    foreach ( var_20 in var_12 )
        var_20 show();

    common_scripts\utility::flag_wait( "player_entering_hovertank" );

    if ( isdefined( var_28 ) )
        var_28 _meth_8498( "force_off" );
}

stair_wait()
{
    wait 28;
    level notify( "stair_lights" );
}

tank_field_nightvision()
{
    level.player _meth_83C0( "tank_nightvision" );
    maps\_utility::vision_set_fog_changes( "lab_tank_thermal", 0 );
}

tank_board()
{
    level.player _meth_83C0( "tank_hangar" );
    maps\_utility::vision_set_fog_changes( "lab_tank_hangar", 0 );
    level.player _meth_8490( "clut_lab_tank_hangar", 0.25 );

    if ( level.nextgen )
        setsunlight( 0, 0, 0 );
}

tank_board_enter()
{
    wait 0.1;
    common_scripts\_exploder::exploder( 7122 );
    resetsunlight();
    level.player _meth_83C0( "tank_board" );
    enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84A9();
    level.player _meth_84AB( 3, 36, 2, 2 );
    wait 2;
    common_scripts\_exploder::kill_exploder( 7622 );
    level waittill( "tank_switch" );
    level.player _meth_84AA();
    wait 1.5;
    common_scripts\_exploder::kill_exploder( 7122 );
    disable_motion_blur();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );

    level.player _meth_83C0( "enter_courtyard_2" );
}

tank_board_enter_top_lights()
{
    wait 2;
    var_0 = getent( "tank_board_light", "targetname" );
    wait 0.05;
    var_1 = getent( "tank_top_light_02", "targetname" );

    if ( isdefined( var_1 ) )
        var_1 _meth_81DF( 0 );

    var_2 = getent( "tank_top_light_03", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 _meth_81DF( 0 );

    wait 0.05;
    var_3 = getent( "tank_top_light_04", "targetname" );

    if ( isdefined( var_3 ) )
    {
        var_3 _meth_8498( "normal" );
        var_3 _meth_81DF( 0 );
    }

    wait 3.5;
    var_4 = getent( "tank_top_light_01", "targetname" );

    if ( isdefined( var_4 ) )
        var_4 _meth_81DF( 0 );
}

hovertank_turrent_light( var_0 )
{
    var_0.spot_main = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.spot_main;
    var_1 _meth_804D( var_0, "barrel", ( 80, 50, 0 ), ( 180, 90, 0 ), 0 );
    wait 1.5;
    playfxontag( common_scripts\utility::getfx( "point_blue_fill_tank_gun" ), var_1, "TAG_ORIGIN" );
}

hovertank_turrent_reflection( var_0 )
{
    var_1 = getent( "reflection_dark", "targetname" );
    var_0 common_scripts\utility::delaycall( 0.05, ::_meth_83AB, var_1.origin );
}

tank_road()
{
    resetsunlight();
    level.player _meth_83C0( "tank_field" );
    maps\_utility::vision_set_fog_changes( "lab_tank_field", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

tank_field()
{
    resetsunlight();
    level.player _meth_83C0( "tank_field" );
    maps\_utility::vision_set_fog_changes( "lab_tank_field", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

tank_exit_dof_reset()
{
    setsunlight( 0, 0, 0 );
    common_scripts\_exploder::exploder( 9123 );
    enable_motion_blur_rotation();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    var_0 = getent( "tank_exit_light", "targetname" );
    var_1 = getent( "tank_exit_light_char", "targetname" );
    thread exfil();
    level waittill( "hovertank_show_exterior" );

    if ( level.nextgen )
    {
        var_0 _meth_8044( ( 0.5, 0.8, 1 ) );
        var_0 _meth_81DF( 300000 );
        var_1 _meth_8044( ( 0.5, 0.8, 1 ) );
        var_1 _meth_81DF( 40000 );
    }

    wait 2;
    resetsunlight();
    common_scripts\_exploder::exploder( 9158 );
    wait 1.25;
    common_scripts\_exploder::kill_exploder( 9123 );
    common_scripts\_exploder::exploder( 9157 );
    wait 5;
    common_scripts\_exploder::kill_exploder( 9158 );
    wait 7;

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 0 );

    disable_motion_blur();

    if ( level.nextgen )
    {
        var_0 _meth_81DF( 0 );
        var_1 _meth_81DF( 0 );
    }
}

tank_field_lft_frk()
{
    level.player _meth_83C0( "tank_field_lft_frk" );
    maps\_utility::vision_set_fog_changes( "lab_tank_field_lft_frk", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

tank_field_rgt_frk()
{
    level.player _meth_83C0( "tank_field_rgt_frk" );
    maps\_utility::vision_set_fog_changes( "lab_tank_field_rgt_frk", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

tank_ascent()
{
    level.player _meth_83C0( "tank_ascent" );
    maps\_utility::vision_set_fog_changes( "lab_tank_ascent", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

exfil()
{
    level.player _meth_83C0( "exfil" );
    common_scripts\_exploder::exploder( 9157 );
    maps\_utility::vision_set_fog_changes( "lab_tank_exfil", 0 );
    level.player _meth_8490( "clut_lab_tank", 0 );
}

sun_light_reset()
{
    level.defaultsunlight = getmapsunlight();
}

outer_space_lighting()
{
    var_0 = getent( "amb_test", "targetname" );
    enableouterspacemodellighting( var_0.origin, ( 0.2, 0.25, 0.35 ) );
}

red_light_strobe_courtyard()
{
    level waittill( "courtyard_red_strobe" );
    common_scripts\_exploder::exploder( 6125 );
    var_0 = getentarray( "siren_light_model", "targetname" );
    var_1 = getentarray( "siren_light", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_3 _meth_81DF( 300000 );
        var_3 _meth_8044( ( 1, 0, 0 ) );
    }

    for (;;)
    {
        foreach ( var_6 in var_0 )
            var_6 _meth_83DF( ( 360, 0, 0 ), 1.0 );

        foreach ( var_3 in var_1 )
            var_3 _meth_83DF( ( 360, 0, 0 ), 1.0 );

        wait 1;
    }
}

exfil_dof()
{
    enable_motion_blur_rotation();
    level.player _meth_84A9();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_84AB( 4, 40 );
    wait 12;
    level.player _meth_84AB( 4, 20 );
    common_scripts\utility::flag_wait( "flag_burke_destroy_tank" );
    wait 2;
    level.player _meth_84AB( 2, 1100 );
    wait 3.7;
    level.player _meth_84AB( 1.5, 40 );
    wait 4;
    level.player _meth_84AB( 1.5, 20 );
}

razorback_lighting( var_0 )
{
    var_0 vehicle_scripts\_razorback_fx::vfx_red_lights_on();
    level waittill( "thruster_front_off" );

    if ( level.nextgen )
        _func_0D3( "r_subdiv", "1" );

    var_0.point_inside = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.point_inside;
    var_1 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_POINT", ( -20, 0, 0 ), ( 30, -125, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "spot_red_heli_in" ), var_1, "tag_origin" );
    var_0.spot_main = common_scripts\utility::spawn_tag_origin();
    var_2 = var_0.spot_main;
    var_2 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_SPOT", ( 0, 0, 0 ), ( 0, 0, 0 ), 0 );
    var_0.spot_tag4 = common_scripts\utility::spawn_tag_origin();
    var_3 = var_0.spot_tag4;
    var_3 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_SPOT", ( 40, -20, 0 ), ( 10, 110, 0 ), 0 );
    var_0.spot_tag3 = common_scripts\utility::spawn_tag_origin();
    var_4 = var_0.spot_tag3;
    var_4 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_SPOT", ( 30, 0, 0 ), ( 0, 45, 0 ), 0 );
    var_0.spot_tag = common_scripts\utility::spawn_tag_origin();
    var_5 = var_0.spot_tag;
    var_5 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_POINT", ( 0, 80, 0 ), ( 0, 90, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "spot_red_heli_in_lrg" ), var_5, "tag_origin" );
    var_0.spot_tag2 = common_scripts\utility::spawn_tag_origin();
    var_6 = var_0.spot_tag2;
    var_6 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_SPOT", ( 70, 30, 0 ), ( 180, 0, 0 ), 0 );
    var_0.point_tag = common_scripts\utility::spawn_tag_origin();
    var_7 = var_0.point_tag;
    var_7 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_POINT", ( -20, 20, 0 ), ( 0, 0, 0 ), 0 );
    var_0.point_tag2 = common_scripts\utility::spawn_tag_origin();
    var_8 = var_0.point_tag2;
    var_8 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_POINT", ( -55, -15, -40 ), ( 90, 0, 0 ), 0 );
    common_scripts\utility::flag_wait( "flag_exfil_dialogue" );
    killfxontag( common_scripts\utility::getfx( "spot_red_heli_in_lrg" ), var_5, "tag_origin" );
    common_scripts\_exploder::kill_exploder( 9157 );

    if ( isdefined( var_0.spot_tag ) )
        var_0.spot_tag delete();

    if ( isdefined( var_0.spot_main ) )
        var_0.spot_main delete();

    wait 4.5;
    playfxontag( common_scripts\utility::getfx( "point_blue_heli" ), var_3, "tag_origin" );
    wait 5;
    common_scripts\utility::flag_wait( "flag_burke_destroy_tank" );
    wait 5.5;
    level.player _meth_83C0( "exfil_pre_explosion" );
    wait 0.15;
    earthquake( 0.25, 1.0, level.player.origin, 1600 );
    level.player _meth_80AD( "heavy_2s" );
    var_0.spot_tag4 = common_scripts\utility::spawn_tag_origin();
    var_3 = var_0.spot_tag4;
    var_3 _meth_804D( var_0, "TAG_LIGHT_INTERIOR_SPOT", ( 0, 0, 50 ), ( 30, 0, 0 ), 0 );
    thread maps\_utility::vision_set_fog_changes( "lab_building_power", 0.2 );
    level.player _meth_83C0( "exfil_explosion" );
    wait 0.5;
    thread maps\_utility::vision_set_fog_changes( "lab_tank_exfil", 0.5 );
    level.player _meth_83C0( "exfil" );
    wait 1;

    if ( isdefined( var_0.spot_tag2 ) )
        var_0.spot_tag2 delete();
}

burke_exfil_lighting()
{

}

tank_turrent_reflection( var_0, var_1 )
{
    var_2 = getent( "reflection_orange", "targetname" );
    var_0 _meth_83AB( var_2.origin );

    foreach ( var_4 in var_1 )
        var_4 _meth_83AB( var_2.origin );
}

turn_off_top_tank_lights()
{
    earthquake( 0.2, 1.0, level.player.origin, 1600 );
    level.player _meth_80AD( "heavy_2s" );
    var_0 = [ "tank_top_light_01", "tank_top_light_02", "tank_top_light_03" ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "targetname" ) )
            var_4 _meth_81DF( 300000 );
    }

    var_7 = getent( "tank_top_light_04", "targetname" );

    if ( isdefined( var_7 ) )
        var_7 _meth_81DF( 50000 );

    if ( level.nextgen )
        maps\_lighting::play_flickerlight_preset( "blue_fire", "blue_flicker", 500000 );

    level waittill( "msg_vfx_htank_thrust_regular" );
    wait 0.5;
    earthquake( 0.25, 1.0, level.player.origin, 1600 );
    level.player _meth_80AD( "heavy_2s" );
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
    {
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
    }
}

enable_physical_dof_hip()
{
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 1.5 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );
}
