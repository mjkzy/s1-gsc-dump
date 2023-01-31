// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( level.currentgen )
        thread df_fly_dof_presets();

    thread df_fly_set_level_lighting_values();
    thread df_fly_lighting();
    thread df_fly_lighting_canyon();
    thread df_fly_lighting_canyon_finale();
    thread df_fly_lighting_end_pod();
    thread set_sun_flare();
    thread setup_vignette();
}

df_fly_dof_presets()
{
    if ( level.nextgen )
    {
        maps\_lighting::create_dof_preset( "df_fly", 10, 60, 0, 0, 7500, 1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_intro", 10, 60, 0, 0, 7500, 1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_canyon", 10, 60, 0, 0, 7500, 1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_canyon_finale", 10, 60, 0, 0, 7500, 1, 0.5 );
    }
    else
    {
        _func_0D3( "r_dof_physical_enable", 0 );
        maps\_lighting::create_dof_preset( "df_fly", 0, 100, 0, 18000, 29000, 1.1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_intro", 0, 100, 0, 18000, 29000, 1.1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_canyon", 0, 100, 0, 18000, 29000, 1.1, 0.5 );
        maps\_lighting::create_dof_preset( "df_fly_canyon_finale", 0, 100, 0, 18000, 29000, 1.1, 0.5 );
    }
}

retarget_lighting()
{
    var_0 = getent( "terrain_no_light", "targetname" );
    var_1 = getent( "terrain_light", "targetname" );
    var_0 _meth_83EF( var_1 );
}

df_fly_set_level_lighting_values()
{
    if ( _func_235() )
        _func_0D3( "r_disableLightSets", 0 );

    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );
}

df_fly_lighting()
{
    level.player _meth_83C0( "df_fly_canyon" );

    if ( level.nextgen )
        level.player _meth_8490( "clut_df_fly", 0 );

    maps\_utility::vision_set_fog_changes( "df_fly_canyon", 0 );

    if ( level.currentgen )
        maps\_lighting::blend_dof_presets( "default", "df_fly", 0 );
}

df_fly_lighting_canyon()
{
    level.player _meth_83C0( "df_fly_canyon" );
    maps\_utility::vision_set_fog_changes( "df_fly_canyon", 0 );

    if ( level.currentgen )
        maps\_lighting::blend_dof_presets( "df_fly_intro", "df_fly_canyon", 0 );

    if ( level.nextgen )
    {
        thread set_canyon_dof();
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }
}

set_canyon_dof()
{
    level.player _meth_84A9();
    level.player _meth_84AB( 1.5, 7000.0, 50, 50 );
    level.player _meth_84BC( 1.25, 30 );
    common_scripts\utility::flag_wait( "canyon_finished" );
    wait 5.0;
    level.player _meth_84AB( 5.0, 660 );
    wait 3.0;
    level.player _meth_84AB( 5.0, 28.8 );
}

set_sun_flare()
{
    thread maps\_shg_fx::vfx_sunflare( "df_fly_sun_flare" );
}

setup_vignette()
{
    level.flyvignette = newhudelem( level.player );
    level.flyvignette.x = 0;
    level.flyvignette.y = 0;
    level.flyvignette.alpha = 1.0;
    level.flyvignette.horzalign = "fullscreen";
    level.flyvignette.vertalign = "fullscreen";
    level.flyvignette.sort = 3;
    level.flyvignette _meth_80CC( "s1_railgun_hud_outer_shadow", 640, 480 );
}

df_fly_lighting_canyon_finale()
{
    common_scripts\utility::flag_wait( "canyon_finished" );
    level.player _meth_83C0( "df_fly_canyon" );
    maps\_utility::vision_set_fog_changes( "df_fly_canyon_finale", 2 );

    if ( level.currentgen )
        maps\_lighting::blend_dof_presets( "df_fly_canyon", "df_fly_canyon_finale", 1 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }
}

df_fly_lighting_end_pod()
{
    common_scripts\utility::flag_wait( "canyon_finished" );
    wait 12;
    level.player _meth_83C0( "df_fly_canyon" );
    maps\_utility::vision_set_fog_changes( "df_fly_canyon_finale", 2 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }
}

ambient_model_fix()
{
    wait 1;
    var_0 = getent( "red_hoodoo2b", "targetname" );
    var_1 = getent( "crumble_hoodoo_b", "targetname" );
    var_2 = getent( "red_hoodoo2c", "targetname" );
    var_3 = getent( "crumble_hoodoo_a", "targetname" );
    var_4 = getent( "cliff_01_origin", "targetname" );
    var_5 = common_scripts\utility::getstruct( "cliff_02_origin", "targetname" );
    var_0 _meth_847B( var_4.origin );
    var_1 _meth_847B( var_5.origin );
    var_2 _meth_847B( var_5.origin );
    var_3 _meth_847B( var_5.origin );
}
