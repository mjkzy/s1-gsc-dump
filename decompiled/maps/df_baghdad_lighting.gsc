// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_lighting_preload()
{
    common_scripts\utility::flag_init( "dnabomb1_exploded" );
    common_scripts\utility::flag_init( "dnabomb2_exploded" );
    common_scripts\utility::flag_init( "dnabomb3_exploded" );
    common_scripts\utility::flag_init( "flag_drag_fade_in" );
    common_scripts\utility::flag_init( "pvtol_crashed" );
}

main()
{
    thread setup_flickerlight_motion_presets();
    thread df_baghdad_lighting();
    thread df_baghdad_set_level_lighting_values();
    thread set_baghdad_standard_dof();
    thread mblur_intro_fly_in_enable();
    thread mblur_intro_fly_in_disable();
    thread dof_spidertank_moment_off();
    thread dof_spidertank_moment_on();
    thread vision_spidertank_moment_on();
    thread vision_spidertank_moment_off();
    thread df_baghdad_lighting_drones();
    thread df_baghdad_lighting_dna_bomb_01();
    thread df_baghdad_lighting_dna_bomb_02();
    thread df_baghdad_lighting_dna_bomb_03();
    thread df_baghdad_lighting_captured();
    thread dna_bomb_warm_fill_01();
    thread dna_bomb_warm_fill_02();
    thread dna_bomb_cool_fill_01();
    thread dna_bomb_cool_fill_02();
    thread dna_bomb_cool_fill_03();
    thread starting_fire_01();
    thread dna_bomb_fire_01();
    thread dna_bomb_fire_02();
    thread dna_bomb_fire_03();
}

df_baghdad_dof_presets()
{
    maps\_lighting::create_dof_preset( "df_baghdad", 10, 60, 6, 0, 7500, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "df_baghdad_barracks", 10, 60, 6, 0, 7500, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "df_baghdad_outside_barracks", 10, 60, 6, 0, 7500, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "df_baghdad_dna_bomb_02", 10, 60, 6, 0, 7500, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "df_baghdad_dna_bomb_03", 10, 60, 6, 0, 7500, 1.5, 0.5 );
    maps\_lighting::create_dof_preset( "df_baghdad_dna_bomb_after", 10, 60, 6, 0, 7500, 1.5, 0.5 );
}

setup_flickerlight_presets()
{
    maps\_lighting::create_flickerlight_preset( "baghdad_fire", ( 1, 0.2246, 0 ), ( 0.46, 0.16, 0.06 ), 0.005, 0.2, 8 );
}

setup_flickerlight_motion_presets()
{
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_small", ( 1, 0.576471, 0.2 ), 600000, 4, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_medium_bright2", ( 1, 0.576471, 0.2 ), 2500000, 4, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_medium_bright3", ( 1, 0.576471, 0.2 ), 3000000, 4, 0.05, 0.2 );
    maps\_lighting::create_flickerlight_motion_preset( "firelight_motion_large", ( 1, 0.576471, 0.2 ), 3000000, 4, 0.05, 0.2 );
}

df_baghdad_set_level_lighting_values()
{
    level.player _meth_83C0( "df_baghdad", 0 );
    maps\_utility::vision_set_fog_changes( "df_baghdad", 0 );

    if ( level.nextgen )
    {
        level.player _meth_8490( "clut_df_baghdad", 0 );
        _func_0D3( "r_hemiAoEnable", 1 );

        if ( _func_235() )
        {
            _func_0D3( "r_disableLightSets", 0 );
            _func_0D3( "r_aodiminish", 0.1 );
            setsunflareposition( ( -43, 141, 0 ) );
        }
    }
}

df_baghdad_lighting()
{
    level.player _meth_83C0( "df_baghdad", 0 );
    setsunflareposition( ( -43, 141, 0 ) );
    maps\_utility::vision_set_fog_changes( "df_baghdad", 0 );
    thread set_baghdad_standard_dof();

    if ( level.nextgen )
        _func_0D3( "r_aodiminish", 0.1 );
}

set_baghdad_standard_dof()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_dof_physical_bokehenable", 0 );
        _func_0D3( "r_dof_physical_hipEnable", 0 );
        _func_0D3( "r_dof_physical_hipFstop", 2 );
        _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.03 );
    }
}

mblur_intro_fly_in_enable()
{
    wait 0.1;

    if ( level.nextgen && level.start_point == "intro" )
    {
        setsunflareposition( ( -43, 141, 0 ) );
        _func_0D3( "r_aodiminish", 0.1 );
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "2" );
        level.player _meth_84A9();
        level.player _meth_84AB( 6, 45, 1, 1 );
        wait 13;
        level.player _meth_84AB( 6, 13, 1, 1 );
        wait 1;
        setsunflareposition( ( -28, 172, 0 ) );
        level.player _meth_84AB( 6, 47, 1, 1 );
        level.player _meth_84AA();
    }
    else
    {
        setsunflareposition( ( -43, 141, 0 ) );
        level.player _meth_84A9();
        level.player _meth_84AB( 6, 45, 1, 1 );
        wait 13;
        level.player _meth_84AB( 6, 13, 1, 1 );
        wait 1;
        setsunflareposition( ( -28, 172, 0 ) );
        level.player _meth_84AB( 6, 47, 1, 1 );
        level.player _meth_84AA();
    }
}

mblur_intro_fly_in_disable()
{
    wait 0.1;

    if ( level.start_point == "intro" && level.nextgen )
    {
        _func_0D3( "r_aodiminish", 0.1 );
        level waittill( "intro_pod_anims_finished" );
        setsunflareposition( ( -43, 141, 0 ) );
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
        _func_0D3( "r_mbVelocityScalar", "0" );
        thread set_baghdad_standard_dof();
    }
}

dof_spidertank_moment_off()
{
    for (;;)
    {
        level waittill( "turret_grapple_dof_off" );
        level.player _meth_84A9();
        level.player _meth_84AB( 5, 31, 1, 1 );
        level.player _meth_84AA();
    }
}

dof_spidertank_moment_on()
{
    for (;;)
        level waittill( "turret_grapple_dof_on" );
}

vision_spidertank_moment_on()
{
    for (;;)
        level waittill( "player_in_turret" );
}

vision_spidertank_moment_off()
{
    for (;;)
        level waittill( "player_out_of_turret" );
}

df_baghdad_lighting_drones()
{
    level waittill( "pvtol_crashed" );
    level.player _meth_83C0( "df_baghdad", 1 );
    maps\_utility::vision_set_fog_changes( "df_baghdad", 1 );

    if ( level.nextgen )
    {
        _func_0D3( "r_aodiminish", 0.1 );
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "0" );
    }

    level.player _meth_84A9();
    level.player _meth_84AB( 50, 20, 1, 1 );
    level.player _meth_84AA();
    setsunflareposition( ( -43, 141, 0 ) );
}

df_baghdad_lighting_dna_bomb_01()
{
    level waittill( "dnabomb_explode01" );
    level.player _meth_83C0( "df_baghdad_dna_bomb_01", 4 );

    if ( level.nextgen )
        _func_0D3( "r_aodiminish", 0.1 );

    maps\_utility::vision_set_fog_changes( "df_baghdad_dna_bomb_01", 4 );
    setsunflareposition( ( -43, 141, 0 ) );
}

df_baghdad_lighting_dna_bomb_02()
{
    level waittill( "dnabomb_explode02" );
    level.player _meth_83C0( "df_baghdad_dna_bomb_02", 4 );
    maps\_utility::vision_set_fog_changes( "df_baghdad_dna_bomb_02", 4 );
    setsunflareposition( ( -43, 141, 0 ) );
}

df_baghdad_lighting_dna_bomb_03()
{
    level waittill( "dnabomb_explode03" );

    if ( level.nextgen )
        level.player _meth_8490( "clut_df_baghdad_dna", 4 );

    maps\_utility::vision_set_fog_changes( "df_baghdad_dna_bomb_03", 6 );
    level.player _meth_83C0( "df_baghdad_dna_bomb_03", 6 );

    if ( level.nextgen )
        _func_0D3( "r_aodiminish", 0.1 );

    setsunflareposition( ( -43, 141, 0 ) );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
        _func_0D3( "r_mbVelocityScalar", "0" );
    }

    level.player _meth_84A9();
    _func_0D3( "r_dof_physical_bokehSharpness", 0.3 );
    level.player _meth_84AB( 5, 50, 1, 1 );
    wait 3.5;
    level.player _meth_84AB( 4, 22, 1, 1 );
    wait 7.5;
    level.player _meth_84AB( 6, 25, 2, 2 );
    wait 3.5;
    level.player _meth_84AB( 6, 20, 2, 2 );
    wait 3.2;
    level.player _meth_84AB( 8, 14, 2, 2 );
    wait 2.8;
    level.player _meth_84AB( 8, 15, 2, 2 );
    wait 2.45;
    level.player _meth_84AB( 8, 19, 2, 2 );
    wait 2.45;
    level.player _meth_84AB( 4, 26, 1, 1 );
    wait 6.6;
    level.player _meth_84AB( 10, 24, 1, 1.5 );
    wait 6;
    level.player _meth_84AB( 3, 320, 1, 1 );
    wait 3;
    level.player _meth_84AB( 0.175, 0, 1, 1 );
    wait 7;
    level.player _meth_84AA();
}

dna_bomb_warm_fill_01()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "warm_fill_01", 5, 3600000 );
}

dna_bomb_warm_fill_02()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "warm_fill_02", 5, 3600000 );
}

dna_bomb_warm_fill_03()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "warm_fill_03", 5, 900000 );
}

dna_bomb_cool_fill_01()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "cool_fill_01", 5, 200000 );
}

dna_bomb_cool_fill_02()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "cool_fill_02", 5, 300000 );
}

starting_fire_01()
{
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_small", "starting_fire_01" );
    level waittill( "dnabomb_explode03" );
    maps\_lighting::lerp_spot_intensity_array( "starting_fire_01", 1, 0 );
}

dna_bomb_fire_01()
{
    maps\_lighting::lerp_spot_intensity_array( "fire_01", 5, 5000 );
    level waittill( "dnabomb_explode03" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_large", "fire_01" );
}

dna_bomb_fire_02()
{
    level waittill( "dnabomb_explode03" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_medium_bright2", "fire_02" );
}

dna_bomb_fire_03()
{
    level waittill( "flag_drag_fade_in" );
    maps\_lighting::play_flickerlight_motion_preset( "firelight_motion_medium_bright3", "fire_03" );
    maps\_lighting::lerp_spot_intensity_array( "fire_01", 0.1, 0 );
    maps\_lighting::lerp_spot_intensity_array( "fire_02", 0.1, 0 );
}

dna_bomb_cool_fill_03()
{
    level waittill( "flag_drag_fade_in" );
    maps\_lighting::lerp_spot_intensity_array( "cool_fill_03", 5, 1000000 );
    maps\_lighting::lerp_spot_intensity_array( "warm_fill_01", 0.1, 0 );
    maps\_lighting::lerp_spot_intensity_array( "warm_fill_02", 0.1, 0 );
    maps\_lighting::lerp_spot_intensity_array( "cool_fill_01", 0.1, 0 );
    maps\_lighting::lerp_spot_intensity_array( "cool_fill_02", 0.1, 0 );
}

df_baghdad_lighting_captured()
{
    common_scripts\utility::flag_wait( "flag_drag_fade_in" );
    maps\_utility::vision_set_fog_changes( "df_baghdad_captured", 1 );
    level.player _meth_83C0( "df_baghdad_captured", 6 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "1" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "2" );
        maps\_utility::lerp_fov_overtime( 0, 75 );
    }

    level.player _meth_84A9();

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehSharpness", 0.3 );

    level.player _meth_84AB( 0.9, 10, 5, 5 );
    wait 2;
    level.player _meth_84AB( 5, 10, 5, 5 );
    wait 1;
    level.player _meth_84AB( 2, 10, 5, 5 );
    wait 1;
    level.player _meth_84AB( 2, 127, 1.5, 1 );
    wait 4;
    level.player _meth_84AB( 0.5, 100, 2, 2 );
    wait 2;
    level.player _meth_84AB( 4, 107, 1.5, 1 );
    wait 3;
    level.player _meth_84AB( 2, 50, 2, 2 );
    wait 2;
    level.player _meth_84AB( 4, 231, 1.5, 1 );
    wait 1;
    level.player _meth_84AB( 3, 79, 1.6, 1 );
    wait 2;
    level.player _meth_84AB( 5, 50, 2, 2 );
    wait 1;
    level.player _meth_84AB( 4, 20, 2, 2 );
    wait 2;
    level.player _meth_84AB( 12, 0, 1.5, 1.5 );
    wait 2;
    level.player _meth_84AB( 7, 0, 2, 2 );
    wait 2;
    level.player _meth_84AB( 12, 0, 2, 2 );
    wait 2;
    level.player _meth_84AB( 7, 0, 2, 2 );
    wait 0.5;
    level.player _meth_84AB( 10, 0, 1.7, 1 );
    wait 1;
    level.player _meth_84AB( 0.175, 0, 1.7, 1 );
    wait 5;
    level.player _meth_84AA();
}

lights_on_blue()
{
    var_0 = getentarray( "blue_lights", "targetname" );
    wait 1;

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 0 );
}

lights_on_blue_02()
{
    var_0 = getentarray( "blue_lights_02", "targetname" );
    wait 1;

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 0 );
}

lights_on_neutral()
{
    var_0 = getentarray( "white_lights", "targetname" );
    wait 1;

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 0 );
}

lights_on_orange()
{
    var_0 = getentarray( "orange_lights", "targetname" );

    foreach ( var_2 in var_0 )
        var_0 _meth_81DF( 0 );
}

lights_on_orange_02()
{
    var_0 = getentarray( "orange_lights_02", "targetname" );
    wait 1;

    foreach ( var_2 in var_0 )
        var_2 _meth_81DF( 300 );
}

firelight_on_plane_01()
{
    var_0 = getentarray( "fire_lights_plane_01", "targetname" );
    common_scripts\utility::flag_wait( "start_pvtol_crash" );
    var_0 _meth_81DF( 20000 );
}

fire_light_on_dna_bomb_01()
{
    var_0 = getentarray( "fire_lights_01", "targetname" );
    common_scripts\utility::flag_wait( "start_pvtol_crash" );
    var_0 _meth_81DF( 20000 );
}

fire_light_on_dna_bomb_02()
{
    var_0 = getentarray( "fire_lights_02", "targetname" );
    common_scripts\utility::flag_wait( "start_pvtol_crash" );
    var_0 _meth_81DF( 20000 );
}
