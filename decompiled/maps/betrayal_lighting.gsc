// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main2()
{
    thread set_level_lighting_values();
    thread setup_dof_presets();
    thread dof_triggers();
    thread setup_dof_viewmodel_presets();
    init_level_lighting_flags();
    thread setup_lighting_office_start();
    thread setup_lighting_basement_start();
    thread setup_lighting_confrontation_start();
    thread setup_lighting_escape_start();
    thread setup_lighting_roof_start();
    thread setup_lighting_swim_start();
    thread setup_lighting_sewer_start();
    thread setup_lighting_old_town_start();
    thread setup_lighting_boat_start();
    thread setup_lighting_boat_crash();
    thread setup_lighting_climb_start();
    thread setup_vfx_sunflare();
    _func_0D3( "r_disablelightsets", 0 );
    thread lightset_triggers();
    _func_0D3( "r_chromaticAberrationTweaks", 1 );
    _func_0D3( "r_chromaticAberration", 1 );
    _func_0D3( "r_chromaticSeparationR", 0.5 );
    _func_0D3( "r_chromaticSeparationG", -0.5 );
    _func_0D3( "r_chromaticSeparationB", 0 );
    _func_0D3( "r_chromaticAberrationAlpha", 0.5 );
    _func_0D3( "r_veilFallOffWeight1", ( 2, 2, 2 ) );
    _func_0D3( "r_aoDiminish", 0.3 );
    level.player_dof_aperture = 4.0;
    thread autofocus_loop();
    thread riverbounce_hideents();
    thread lightbox_hideents();

    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );
}

init_level_lighting_flags()
{
    common_scripts\utility::flag_init( "office_start_lighting" );
    common_scripts\utility::flag_init( "basement_start_lighting" );
    common_scripts\utility::flag_init( "hospital_start_lighting" );
    common_scripts\utility::flag_init( "confrontation_start_lighting" );
    common_scripts\utility::flag_init( "confrontation2_start_lighting" );
    common_scripts\utility::flag_init( "escape_lighting" );
    common_scripts\utility::flag_init( "escape_start_lighting" );
    common_scripts\utility::flag_init( "jail_start_lighting" );
    common_scripts\utility::flag_init( "holding_start_lighting" );
    common_scripts\utility::flag_init( "garage_start_lighting" );
    common_scripts\utility::flag_init( "office_chase_start_lighting" );
    common_scripts\utility::flag_init( "roof_start_lighting" );
    common_scripts\utility::flag_init( "swim_start_lighting" );
    common_scripts\utility::flag_init( "sewer_start_lighting" );
    common_scripts\utility::flag_init( "oldtown_start_lighting" );
    common_scripts\utility::flag_init( "checkpoint_start_lighting" );
    common_scripts\utility::flag_init( "crossing_start_lighting" );
    common_scripts\utility::flag_init( "cafe_start_lighting" );
    common_scripts\utility::flag_init( "mall_start_lighting" );
    common_scripts\utility::flag_init( "boat_start_lighting" );
    common_scripts\utility::flag_init( "boat_crash_lighting" );
    common_scripts\utility::flag_init( "subway_start_lighting" );
    common_scripts\utility::flag_init( "gunfight_start_lighting" );
    common_scripts\utility::flag_init( "gunfight2_start_lighting" );
    common_scripts\utility::flag_init( "climb_start_lighting" );
}

set_level_lighting_values()
{
    _func_0D3( "r_disablelightsets", 0 );

    if ( level.nextgen )
        _func_0D3( "r_mdao", 1 );

    level.player _meth_83C0( "betrayal_interior" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_int_intro", 0 );
    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = 2.2;
    level.player_dof_distance = 53;
    level.player_dof_max_distance = 600;
    thread mblur_disable();
}

setup_dof_presets()
{
    maps\_lighting::create_dof_preset( "betrayal_standard", 4, 35, 4, 1000, 7000, 1, 0.5 );
    maps\_lighting::create_dof_preset( "exterior_dof", 1, 40, 1.0, 3001, 10000, 0.1, 0.5 );
    maps\_lighting::create_dof_preset( "interior_dof", 1, 35, 10.0, 101, 6000, 10.0, 0.5 );
}

dof_triggers()
{
    if ( level.nextgen )
        _func_0D3( "r_dof_physical_enable", 1 );

    level.player _meth_84A9();
    common_scripts\utility::run_thread_on_targetname( "dof_enable_interior", ::dof_enable_interior );
    common_scripts\utility::run_thread_on_targetname( "dof_enable_exterior", ::dof_enable_exterior );
    common_scripts\utility::run_thread_on_targetname( "dof_enable_start", ::dof_enable_start );
    common_scripts\utility::run_thread_on_targetname( "interior_fog", ::trigger_interior_fog );
    common_scripts\utility::run_thread_on_targetname( "exterior_fog", ::trigger_exterior_fog );
    common_scripts\utility::run_thread_on_targetname( "mblur_enable", ::mblur_enable_trigger );
    common_scripts\utility::run_thread_on_targetname( "mblur_cam_enable", ::mblur_cam_enable_trigger );
    common_scripts\utility::run_thread_on_targetname( "mblur_disable", ::mblur_disable_trigger );
}

dof_enable_interior()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        level.player_dof_aperture = 2.8;

    common_scripts\utility::flag_set( "flag_autofocus_on" );
}

dof_enable_exterior()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        level.player_dof_aperture = 8.0;

    common_scripts\utility::flag_set( "flag_autofocus_on" );
}

dof_enable_start()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        level.player_dof_aperture = 4.0;
}

trigger_interior_fog()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        maps\_utility::fog_set_changes( "betrayal_canal", 2 );
}

trigger_exterior_fog()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        maps\_utility::fog_set_changes( "neutral", 2 );
    else
        maps\_utility::vision_set_fog_changes( "neutral", 2 );
}

mblur_enable_trigger()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

mblur_cam_enable_trigger()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

mblur_disable_trigger()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
        _func_0D3( "r_mbVelocityScalar", "0" );
    }
}

mblur_enable()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

mblur_cam_enable()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbCameraRotationInfluence", "1" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

mblur_disable()
{
    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "0" );
        _func_0D3( "r_mbCameraRotationInfluence", "0" );
        _func_0D3( "r_mbVelocityScalar", "0" );
    }
}

autofocus_loop()
{
    if ( level.nextgen )
        _func_0D3( "r_dof_physical_enable", 1 );

    level.player _meth_84A9();
    var_0 = level.player_dof_aperture;

    for (;;)
    {
        waitframe();

        if ( common_scripts\utility::flag( "flag_autofocus_on" ) == 1 )
            var_1 = min( trace_distance(), level.player_dof_max_distance );
        else
            var_1 = level.player_dof_distance;

        var_0 = level.player_dof_aperture;

        if ( var_1 < 60 )
            var_0 += abs( 60 - var_1 ) * 0.3;
        else
            var_0 = level.player_dof_aperture;

        if ( level.nextgen )
            level.player _meth_84AB( var_0, var_1, 4, 2 );
    }
}

riverbounce_hideents()
{
    var_0 = getentarray( "canal_bounce", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] hide();
        var_0[var_1] _meth_82BF();
    }
}

lightbox_hideents()
{
    var_0 = getentarray( "lightboxes", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] _meth_8058();
        var_0[var_1] hide();
        var_2 = ( 0, 0, 0 );
        var_0[var_1] _meth_82AE( var_2, 0.1, 0.02, 0.02 );
    }

    var_0 = getentarray( "hide_screens", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1] hide();
        var_2 = ( 0, 0, 0 );
        var_0[var_1] _meth_82AE( var_2, 0.1, 0.02, 0.02 );
    }
}

blastdoor_hideents()
{
    var_0 = getentarray( "roof_window_blastdoor", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] hide();
}

blastdoor_showents()
{
    var_0 = getentarray( "roof_window_blastdoor", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] show();
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

setup_dof_viewmodel_presets()
{
    maps\_lighting::create_dof_viewmodel_preset( "betrayal_viewmodel_standard", 1, 12 );
}

setup_lighting_office_start()
{
    common_scripts\utility::flag_wait( "office_start_lighting" );
    level.player _meth_8490( "clut_betrayal_c3_02", 2 );

    if ( level.nextgen )
    {
        level.player_dof_aperture = 3.5;
        level.player_dof_distance = 53;
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
        thread mblur_disable();
        level.player _meth_83C0( "betrayal_interior_lobby" );
        maps\_utility::vision_set_fog_changes( "betrayal_grungy_int_intro", 0.5 );
        level.player _meth_8490( "clut_betrayal_c3_01", 1 );
        var_0 = getent( "btr_lobby_light_gideon_key", "targetname" );
        var_1 = getent( "btr_lobby_light_gideon_rim", "targetname" );
        var_2 = getent( "btr_lobby_light_ground_source", "targetname" );
        var_3 = getent( "btr_lobby_light_elevator", "targetname" );
        var_2 _meth_81DF( 2000000 );
        var_2 _meth_8044( ( 1, 1, 1 ) );
        var_1 _meth_81DF( 38000 );
        var_0 _meth_81DF( 28000 );
        var_0 _meth_8046( 170 );
        wait 15;
        maps\_lighting::lerp_spot_intensity( "btr_lobby_light_gideon_key", 13, 22000 );
        maps\_lighting::lerp_spot_intensity( "btr_lobby_light_gideon_rim", 4, 5000 );
        wait 10;
        common_scripts\utility::flag_set( "flag_autofocus_on" );
        level.player_dof_aperture = 3.5;
        level.player_dof_distance = 53;
        maps\_lighting::lerp_spot_intensity( "btr_lobby_light_gideon_key", 8, 0 );
        var_4 = getent( "betr_light_vista_rim", "targetname" );
        var_4 _meth_81DF( 100000000 );
        var_4 _meth_8498( "force_on" );
        level.player_dof_aperture = 8.0;
    }
}

setup_lighting_basement_start()
{
    common_scripts\utility::flag_wait( "basement_start_lighting" );

    if ( level.nextgen )
    {
        level.player _meth_83C0( "betrayal_interior" );
        maps\_utility::vision_set_fog_changes( "betrayal_interior", 0.5 );
    }
    else
    {
        level.player _meth_83C0( "betrayal_interior_darker" );
        maps\_utility::vision_set_fog_changes( "betrayal_interior", 0.5 );
    }

    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    level.player_dof_max_distance = 600;
    thread mblur_disable();
}

setup_lighting_confrontation_start()
{
    common_scripts\utility::flag_wait( "confrontation_start_lighting" );

    if ( level.nextgen )
    {
        _func_0D3( "r_subdiv", "1" );
        _func_0D3( "r_adaptiveSubdivBaseFactor", "0.5" );
    }

    thread blastdoor_hideents();
    common_scripts\_exploder::exploder( 1999 );
    thread mblur_disable();

    if ( level.nextgen )
    {
        maps\_utility::fog_set_changes( "betrayal_interior_darker", 1 );
        level.player _meth_83C0( "betrayal_interior_confrontation_1" );
    }
    else
    {
        maps\_utility::vision_set_fog_changes( "betrayal_interior_darker", 1 );
        level.player _meth_83C0( "betrayal_interior_darker" );
    }

    level.player _meth_8490( "clut_betrayal_c3_03", 1 );
    common_scripts\utility::flag_set( "flag_dialogue_start_confrontation" );

    if ( level.nextgen )
    {
        level.player_dof_aperture = 2.5;
        level.player_dof_max_distance = 400;
        _func_0D3( "r_dof_physical_bokehEnable", 1 );
        var_0 = getent( "btr_basement_key1", "targetname" );
        var_1 = getent( "btr_basement_key2", "targetname" );
        var_0 _meth_83DF( ( 15, 0, 0 ), 0.1 );
        var_1 _meth_83DF( ( 15, 0, 0 ), 0.1 );
        var_2 = getent( "btr_basement_hall_light", "targetname" );
        var_2 _meth_81DF( 0 );
        var_3 = getent( "btr_basement_key4", "targetname" );
        var_3 _meth_81DF( 4000 );

        if ( level.nextgen )
            maps\_lighting::lerp_spot_intensity( "btr_basement_key4", 5, 600 );

        var_3 _meth_8046( 150 );
        wait 4;
        wait 1;
        var_4 = getent( "betr_emergency_alarm_model_1", "targetname" );
        var_5 = getent( "betr_emergency_alarm_model_2", "targetname" );
        var_6 = getent( "betr_emergency_alarm_model_3", "targetname" );
        var_7 = getent( "betr_emergency_alarm_model_4", "targetname" );
        var_8 = getent( "betr_emergency_alarm_model_5", "targetname" );
        var_9 = getent( "betr_emergency_alarm_model_6", "targetname" );
        var_10 = getent( "betr_emergency_alarm_model_7", "targetname" );
        var_11 = getent( "betr_emergency_alarm_model_8", "targetname" );
        var_12 = getent( "betr_emergency_alarm_model_9", "targetname" );
        var_13 = getent( "betr_emergency_alarm_model_10", "targetname" );
        var_14 = getent( "betr_emergency_alarm_model_11", "targetname" );
        var_15 = getent( "betr_emergency_alarm_model_12", "targetname" );
        var_16 = getent( "btr_emergLight_elevator_1", "targetname" );
        var_17 = getent( "btr_emergLight_elevator_2", "targetname" );
        var_11 hide();
        var_12 hide();
        var_13 hide();
        var_14 hide();
        var_15 hide();
        var_18 = getent( "betr_emergency_power_light_off", "targetname" );
        var_19 = getent( "betr_emergency_power_light_on", "targetname" );
        var_19 hide();
        var_0 _meth_81DF( 4000 );
        var_1 _meth_81DF( 6000 );
        wait 9;
        level.player_dof_aperture = 1.0;
        maps\_lighting::lerp_spot_intensity( "btr_basement_key1", 10, 6000 );
        maps\_lighting::lerp_spot_intensity( "btr_basement_key2", 10, 3000 );
        level.player _meth_83C0( "betrayal_interior_confrontation_2" );
        maps\_lighting::lerp_spot_intensity( "btr_basement_key2", 10, 4000 );
        maps\_lighting::lerp_spot_intensity( "btr_basement_key1", 10, 2000 );
        var_3 _meth_81DF( 10 );
        var_3 _meth_8044( ( 1, 0.87, 0.85 ) );
        var_3 _meth_83DF( ( 60, 0, 0 ), 1.0 );
        wait 5;
        common_scripts\utility::flag_clear( "flag_autofocus_on" );
        level.player_dof_aperture = 7;
        level.player_dof_max_distance = 400;
        wait 20;
        level.player _meth_83C0( "betrayal_interior_confrontation_3" );
        wait 24;
        var_20 = var_0 getorigin();
        var_20 += ( 40, -20, 0 );
        var_0 _meth_82AE( var_20, 4 );
        var_0 _meth_83DF( ( 10, 0, 0 ), 4 );
        maps\_lighting::lerp_spot_intensity( "btr_basement_key1", 5, 3000 );
        wait 1;
        var_3 _meth_81DF( 30000 );
        common_scripts\utility::flag_wait( "escape_lighting" );
        level.player _meth_8490( "clut_betrayal_c3_04", 0.02 );
        common_scripts\_exploder::exploder( 2001 );
        var_11 show();
        var_12 show();
        var_13 show();
        var_14 show();
        var_15 show();
        var_19 show();
        var_18 hide();
        maps\_utility::stop_exploder( 1999 );
        level.player _meth_83C0( "betrayal_interior" );
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
        level.player_dof_aperture = 3.5;
        var_0 _meth_81DF( 15000 );
        var_1 _meth_81DF( 30000 );
        var_3 _meth_81DF( 60000 );
        var_0 _meth_8020( 85, 60 );
        var_1 _meth_8020( 85, 60 );
        var_3 _meth_8020( 80, 50 );
        var_0 _meth_8044( ( 1, 0.98, 0.95 ) );
        var_1 _meth_8044( ( 1, 0.05, 0.05 ) );
        var_3 _meth_8044( ( 1, 0.05, 0.05 ) );
        var_2 _meth_81DF( 12000 );
        var_0 _meth_83DF( ( -15, 0, 0 ), 0.1 );
        var_0 _meth_83DF( ( -10, 0, 0 ), 0.1 );
        var_1 _meth_83DF( ( -15, 0, 0 ), 0.1 );
        var_3 _meth_83DF( ( -60, 0, 0 ), 0.1 );
        var_0 _meth_83DF( ( 0, 0, 90 ), 0.1 );
        var_0 _meth_83DF( ( 45, 45, 0 ), 0.1 );
        var_1 _meth_83DF( ( 0, 0, 90 ), 0.1 );
        var_3 _meth_83DF( ( -50, 0, 0 ), 0.1 );
        var_1 _meth_83DF( ( -30, 0, 0 ), 0.1 );
        var_20 = var_11 _meth_8096();
        var_20 += ( -5, 0, 0 );
        var_1 _meth_82AE( var_20, 0.1 );
        var_20 = var_12 _meth_8096();
        var_20 += ( -2, 0, 0 );
        var_3 _meth_82AE( var_20, 0.1 );
        var_20 = var_19 _meth_8096();
        var_20 += ( -5, 10, 0 );
        var_0 _meth_82AE( var_20, 0.02 );
        var_1 _meth_8020( 70, 10 );
        var_3 _meth_8020( 70, 10 );

        if ( level.nextgen )
        {
            maps\_utility::fog_set_changes( "betrayal_escape", 7 );
            _func_0D3( "r_dof_physical_bokehEnable", 0 );
        }
        else
            maps\_utility::vision_set_fog_changes( "betrayal_escape", 7 );

        var_16 _meth_81DF( 300000 );
        var_17 _meth_81DF( 300000 );
        var_20 = var_16 _meth_8096();
        var_20 += ( 0, 0, 200 );
        var_16 _meth_82AE( var_20, 0.02 );
        var_20 = var_17 _meth_8096();
        var_20 += ( 0, 0, 200 );
        var_17 _meth_82AE( var_20, 0.02 );
        var_16 _meth_8020( 90, 30 );
        var_17 _meth_8020( 90, 30 );
        var_16 _meth_83DF( ( 90, 0, 0 ), 0.02 );
        var_17 _meth_83DF( ( 90, 0, 0 ), 0.02 );
        var_21 = [ var_1, var_3 ];

        for ( var_22 = 60; var_22 > 0; var_22-- )
        {
            var_23 = 20;

            while ( var_23 > 0 )
            {
                var_24 = abs( cos( gettime() * 0.08 ) ) * 26000;
                var_1 _meth_81DF( var_24 );
                var_3 _meth_81DF( var_24 * 2 );
                var_23--;
                wait 0.1;
            }

            var_16 _meth_83DF( ( 0, 360, 0 ), 2.0 );
            var_17 _meth_83DF( ( 0, 360, 0 ), 2.0 );
            var_4 _meth_83DF( ( 0, 360, 0 ), 2.0 );

            if ( var_22 == 40 )
                maps\_utility::vision_set_fog_changes( "betrayal_escape_elevator_interior", 20 );
        }
    }

    level.player_dof_max_distance = 400;
    maps\_utility::stop_exploder( 2001 );

    if ( level.nextgen )
        _func_0D3( "r_adaptiveSubdivBaseFactor", "1.5" );

    level.player_dof_aperture = 8.0;
}

lighting_confrontation_auto_dof( var_0, var_1 )
{
    for ( var_2 = 715; var_2 > 0 && !_func_294( var_1 ); var_2-- )
    {
        var_3 = distance2d( var_0.origin, var_1.origin );

        if ( !_func_294( var_1 ) && maps\_utility::player_looking_at( var_1.origin ) )
        {
            level.player_dof_distance = var_3;
            common_scripts\utility::flag_clear( "flag_autofocus_on" );
            level.player_dof_aperture = 3.2;
        }
        else if ( var_3 < 40 )
        {
            level.player_dof_distance = var_3;
            common_scripts\utility::flag_clear( "flag_autofocus_on" );
            level.player_dof_aperture = 5.5;
        }
        else
        {
            common_scripts\utility::flag_set( "flag_autofocus_on" );
            level.player_dof_aperture = 2.5;
        }

        wait 0.1;
    }

    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = 3.5;
}

lighting_irons_dof( var_0, var_1 )
{
    if ( level.currentgen )
        _func_08A( 500 );
    else
        _func_08A( 0 );

    common_scripts\utility::flag_wait( "confrontation2_start_lighting" );

    for ( var_2 = 550; var_2 > 0; var_2-- )
    {
        var_3 = distance2d( var_0.origin, var_1.origin );

        if ( maps\_utility::player_looking_at( var_1.origin ) )
        {
            level.player_dof_distance = var_3;
            common_scripts\utility::flag_clear( "flag_autofocus_on" );
            level.player_dof_aperture = 1.1;
        }
        else
        {
            common_scripts\utility::flag_set( "flag_autofocus_on" );
            level.player_dof_aperture = 3.8;
        }

        wait 0.1;
    }

    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = 3.0;
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

    level.player_dof_aperture = var_4;
    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = var_4;
}

setup_lighting_escape_start()
{
    if ( level.currentgen )
        _func_08A( 0 );
    else
        _func_08A( 0 );

    common_scripts\utility::flag_wait( "escape_start_lighting" );
    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = 3.5;

    if ( level.nextgen )
    {
        level.player _meth_83C0( "betrayal_interior_confrontation_1" );
        level.player _meth_8490( "clut_betrayal_c3_04", 1 );
    }
    else
    {
        level.player _meth_83C0( "betrayal_interior_darker" );
        maps\_utility::vision_set_fog_changes( "betrayal_interior_darker", 0.5 );
    }

    var_0 = getent( "btr_basement_key1", "targetname" );
    var_1 = getent( "btr_basement_key2", "targetname" );
    var_2 = getent( "btr_basement_key4", "targetname" );
    var_3 = getent( "betr_emergency_alarm_model_1", "targetname" );
    var_4 = getent( "betr_emergency_alarm_model_2", "targetname" );
    var_5 = getent( "betr_emergency_alarm_model_3", "targetname" );
    var_6 = getent( "betr_emergency_alarm_model_4", "targetname" );
    var_7 = getent( "betr_emergency_alarm_model_5", "targetname" );
    var_8 = getent( "betr_emergency_alarm_model_6", "targetname" );
    var_9 = getent( "betr_emergency_alarm_model_7", "targetname" );
    var_10 = getent( "betr_emergency_alarm_model_8", "targetname" );
    var_11 = getent( "betr_emergency_alarm_model_9", "targetname" );
    var_12 = getent( "betr_emergency_alarm_model_10", "targetname" );
    var_13 = getent( "betr_emergency_alarm_model_11", "targetname" );
    var_14 = getent( "betr_emergency_alarm_model_12", "targetname" );
    var_15 = getent( "btr_emergLight_elevator_1", "targetname" );
    var_16 = getent( "btr_emergLight_elevator_2", "targetname" );
    var_17 = getent( "btr_basement_hall_light", "targetname" );
    var_18 = getent( "betr_emergency_power_light_off", "targetname" );
    var_19 = getent( "betr_emergency_power_light_on", "targetname" );
    common_scripts\_exploder::exploder( 2001 );
    var_10 show();
    var_11 show();
    var_12 show();
    var_13 show();
    var_14 show();
    var_19 show();
    var_18 hide();
    maps\_utility::stop_exploder( 1999 );
    _func_0D3( "r_mbEnable", "2" );
    _func_0D3( "r_mbVelocityScalar", "1" );
    common_scripts\utility::flag_set( "flag_autofocus_on" );
    level.player_dof_aperture = 3.5;
    var_0 _meth_81DF( 10000 );
    var_1 _meth_81DF( 60000 );
    var_2 _meth_81DF( 100000 );
    var_0 _meth_8020( 85, 60 );
    var_1 _meth_8020( 85, 60 );
    var_2 _meth_8020( 80, 50 );
    var_0 _meth_8044( ( 1, 0.98, 0.95 ) );
    var_1 _meth_8044( ( 1, 0.05, 0.05 ) );
    var_2 _meth_8044( ( 1, 0.05, 0.05 ) );
    var_17 _meth_81DF( 12000 );
    var_20 = 60;
    var_0 _meth_83DF( ( 0, 0, 90 ), 0.1 );
    var_0 _meth_83DF( ( 45, 45, 0 ), 0.1 );
    var_1 _meth_83DF( ( 0, 0, 90 ), 0.1 );
    var_2 _meth_83DF( ( 30, 0, 0 ), 0.1 );
    var_1 _meth_83DF( ( -30, 0, 0 ), 0.1 );
    var_21 = var_10 _meth_8096();
    var_21 += ( -5, 0, 0 );
    var_1 _meth_82AE( var_21, 0.1 );
    var_21 = var_11 _meth_8096();
    var_21 += ( -2, 0, 0 );
    var_2 _meth_82AE( var_21, 0.1 );
    var_21 = var_19 _meth_8096();
    var_21 += ( -5, 10, 0 );
    var_0 _meth_82AE( var_21, 0.02 );
    var_1 _meth_8020( 70, 10 );
    var_2 _meth_8020( 70, 10 );

    if ( level.nextgen )
    {
        maps\_utility::fog_set_changes( "betrayal_escape", 7 );
        _func_0D3( "r_dof_physical_bokehEnable", 0 );
    }
    else
        maps\_utility::vision_set_fog_changes( "betrayal_escape", 7 );

    var_15 _meth_81DF( 300000 );
    var_16 _meth_81DF( 300000 );
    var_21 = var_15 _meth_8096();
    var_21 += ( 0, 0, 200 );
    var_15 _meth_82AE( var_21, 0.02 );
    var_21 = var_16 _meth_8096();
    var_21 += ( 0, 0, 200 );
    var_16 _meth_82AE( var_21, 0.02 );
    var_15 _meth_8020( 90, 30 );
    var_16 _meth_8020( 90, 30 );
    var_15 _meth_83DF( ( 90, 0, 0 ), 0.02 );
    var_16 _meth_83DF( ( 90, 0, 0 ), 0.02 );

    for ( var_22 = [ var_1, var_2 ]; var_20 > 0; var_20-- )
    {
        var_23 = 20;

        while ( var_23 > 0 )
        {
            var_24 = abs( cos( gettime() * 0.08 ) ) * 26000;
            var_1 _meth_81DF( var_24 );
            var_2 _meth_81DF( var_24 * 2 );
            var_23--;
            wait 0.1;
        }

        var_15 _meth_83DF( ( 0, 360, 0 ), 2.0 );
        var_16 _meth_83DF( ( 0, 360, 0 ), 2.0 );
        var_3 _meth_83DF( ( 0, 360, 0 ), 2.0 );

        if ( var_20 == 40 )
            maps\_utility::vision_set_fog_changes( "betrayal_escape_elevator_interior", 20 );
    }
}

blink_lights( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_1;
    var_6 = var_2;

    for ( var_7 = int( var_3 * 10 ); var_7 > 0; var_7-- )
    {
        var_5 = abs( cos( gettime() * 0.08 * var_4 ) ) * var_5 + var_6;

        foreach ( var_9 in var_0 )
            var_9 _meth_81DF( var_5 );

        wait 0.1;
    }
}

blink_lights_flicker( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_1;
    var_7 = var_2;

    for ( var_8 = int( var_3 * 10 ); var_8 > 0; var_8-- )
    {
        var_6 = abs( cos( gettime() * 0.08 * var_4 ) ) * var_6 + var_7;

        foreach ( var_10 in var_0 )
            var_10 _meth_81DF( var_6 );

        if ( var_5 > 0 )
            wait(randomfloatrange( 0.0, 0.3 * var_5 ));

        wait 0.1;
    }
}

setup_lighting_roof_start()
{
    if ( level.currentgen )
        _func_08A( 0 );
    else
        _func_08A( 0 );

    common_scripts\utility::flag_wait( "roof_start_lighting" );
    level.player_dof_aperture = 8.0;
    level.player_dof_max_distance = 400;
    thread blastdoor_showents();

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
    }

    common_scripts\_exploder::exploder( 3001 );

    if ( level.nextgen )
    {
        var_0 = getent( "siren_light_1", "targetname" );
        var_1 = getent( "siren_light_model_1", "targetname" );
        var_2 = getent( "siren_light_2", "targetname" );
        var_3 = getent( "siren_light_model_2", "targetname" );
        var_4 = getent( "siren_light_3", "targetname" );
        var_5 = getent( "siren_light_model_3", "targetname" );
        var_0 _meth_81DF( 500000 );
        var_2 _meth_81DF( 500000 );
        var_4 _meth_81DF( 500000 );

        for ( var_6 = 80; var_6 > 0; var_6-- )
        {
            var_1 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            var_0 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            var_3 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            var_2 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            var_5 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            var_4 _meth_83DF( ( 0, 360, 0 ), 1.0 );
            wait 1;
        }
    }

    common_scripts\_exploder::kill_exploder( 3001 );
}

setup_lighting_swim_start()
{
    common_scripts\utility::flag_wait( "swim_start_lighting" );
    wait 0.5;
    level.player _meth_83C0( "betrayal_grungy" );

    if ( level.nextgen )
        level.player _meth_8490( "clut_betrayal_c3_05", 1 );

    maps\_utility::vision_set_fog_changes( "betrayal_grungy", 0.5 );
    level.player_dof_aperture = 1.2;
    level.player_dof_max_distance = 100;
    common_scripts\_exploder::exploder( 3002 );
    thread mblur_disable();
}

setup_lighting_sewer_start()
{
    common_scripts\utility::flag_wait( "sewer_start_lighting" );
    wait 0.5;

    if ( level.nextgen )
        level.player _meth_8490( "clut_betrayal_c3_05", 1 );
    else
    {
        level.player _meth_83C0( "betrayal_sewer" );
        maps\_utility::vision_set_fog_changes( "betrayal_sewer", 1 );
    }

    level.player_dof_aperture = 8.0;
    level.player_dof_max_distance = 600;
    level.player _meth_83C0( "betrayal_sewer" );
    maps\_utility::vision_set_fog_changes( "betrayal_sewer", 3 );
    thread mblur_disable();
    var_0 = getentarray( "sewer_light_1", "targetname" );
    thread blink_lights_flicker( var_0, 9000, 7000, 100, 10, 1 );
}

setup_lighting_old_town_start()
{
    common_scripts\utility::flag_wait( "oldtown_start_lighting" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_market", 0.5 );
    level.player _meth_83C0( "betrayal_grungy" );
    level.player_dof_aperture = 8.0;
    level.player_dof_max_distance = 600;
    level.player _meth_8490( "clut_betrayal_c3_01", 6 );
    maps\_utility::stop_exploder( 3002 );
    var_0 = getentarray( "betr_lighting_market_tvs", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 _meth_8044( ( 0.92, 0.9, 1 ) );

    thread blink_lights_flicker( var_0, 4000, 3200, 1000, 5, 1 );
    thread mblur_disable();
}

setup_lighting_boat_start()
{
    common_scripts\utility::flag_wait( "boat_start_lighting" );
    level.player_dof_aperture = 8.0;
    level.player_dof_max_distance = 600;
    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    level.player _meth_83C0( "betrayal_grungy_boat_chase" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_boat_chase", 2.0 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

setup_lighting_boat_crash()
{
    common_scripts\utility::flag_wait( "boat_crash_lighting" );

    if ( level.nextgen )
        _func_0D3( "r_subdiv", "1" );

    common_scripts\utility::flag_clear( "flag_autofocus_on" );
    level.player_dof_aperture = 1.1;
    level.player_dof_distance = 15;

    if ( level.nextgen )
        _func_0D3( "r_dof_physical_bokehEnable", 1 );

    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    level.player _meth_83C0( "betrayal_crash_cine" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy", 2.0 );

    if ( level.nextgen )
    {
        var_0 = getent( "btr_crash_light_rim", "targetname" );
        var_1 = getent( "btr_crash_light_fill", "targetname" );
        var_0 _meth_81DF( 1200000 );
        var_1 _meth_81DF( 35000 );
    }

    wait 6;
    thread lighting_target_dof( level.player, level.ilana, 2.8, 10 );
    wait 10;
    common_scripts\utility::flag_set( "flag_autofocus_on" );
    thread mblur_disable();
    level.player_dof_max_distance = 400;
    level.player_dof_aperture = 8.0;
    wait 15;
    level.player _meth_83C0( "betrayal_grungy" );
    wait 45;
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_climb", 20 );
    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
}

setup_lighting_climb_start()
{
    common_scripts\utility::flag_wait( "climb_start_lighting" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_climb", 6 );
    level.player _meth_83C0( "betrayal_grungy" );
    level.player_dof_aperture = 9.0;
    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    level.player_dof_max_distance = 400;
    thread mblur_disable();
}

setup_lighting_finale_start( var_0 )
{
    if ( level.nextgen )
        _func_0D3( "r_subdiv", "1" );

    level.player _meth_83C0( "betrayal_outro" );

    if ( level.nextgen )
    {
        maps\_utility::fog_set_changes( "betrayal_grungy_finale", 5 );
        maps\_utility::vision_set_changes( "betrayal_outro", 0.5 );
    }
    else
        maps\_utility::vision_set_fog_changes( "betrayal_grungy_climb", 1.5 );

    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    var_1 = -60;
    var_2 = 160;
    var_3 = ( var_1, var_2, 0 );
    maps\_shg_fx::set_sun_flare_position( var_3 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "1" );
        common_scripts\utility::flag_clear( "flag_autofocus_on" );
        level.player_dof_aperture = 4.1;
        level.player_dof_distance = 1;
        level.player_dof_max_distance = 400;

        if ( level.nextgen )
            _func_0D3( "r_dof_physical_bokehEnable", 1 );

        wait 0.3;
        level.player_dof_distance = 97;
        thread lighting_target_dof( level.player, var_0[0], 3.2, 4 );
        wait 4;
        thread mblur_disable();
        level.player_dof_distance = 52;
        var_4 = getent( "btr_finale_rim_top", "targetname" );
        maps\_lighting::lerp_spot_intensity( "btr_finale_rim_top", 4, 3000000 );
        thread lighting_target_dof( level.player, var_0[1], 3.2, 8 );
        wait 6;
        level.player _meth_83C0( "betrayal_outro_helicopter" );
        wait 2;
        thread lighting_target_dof( level.player, var_0[2], 3.2, 20 );
        var_5 = var_4 getorigin();
        var_5 += ( 100, -230, 0 );
        var_4 _meth_82AE( var_5, 5 );
        var_4 _meth_83DF( ( 1, -50, 0 ), 5 );
        maps\_lighting::lerp_spot_intensity( "btr_finale_rim_top", 5, 3000000 );
        level.player _meth_83C0( "betrayal_outro" );
        level.player_dof_distance = 53;
        wait 10;
        common_scripts\_exploder::exploder( 9000 );
        wait 2;
        thread lighting_target_dof( level.player, var_0[1], 3.2, 6 );
        level.player_dof_distance = 53;
        wait 6;
        thread lighting_target_dof( level.player, var_0[2], 3.2, 4 );
        level.player_dof_distance = 160;
        level.player_dof_aperture = 8.0;
    }
}

setup_vfx_sunflare()
{
    thread maps\_shg_fx::vfx_sunflare( "fx_sunflare_lsr2" );
}

lightset_triggers()
{
    common_scripts\utility::run_thread_on_targetname( "betrayal", ::lightset_betrayal );
    common_scripts\utility::run_thread_on_targetname( "betrayal_grungy", ::lightset_betrayal_grungy );
    common_scripts\utility::run_thread_on_targetname( "betrayal_interior_darker_fog", ::betrayal_interior_darker_fog );
    common_scripts\utility::run_thread_on_targetname( "betrayal_roof_transition", ::betrayal_roof_transition );
    common_scripts\utility::run_thread_on_targetname( "betrayal_mall", ::lightset_betrayal_mall );
    common_scripts\utility::run_thread_on_targetname( "betrayal_subway", ::lightset_betrayal_subway );
    common_scripts\utility::run_thread_on_targetname( "betrayal_interior", ::lightset_betrayal_interior );
    common_scripts\utility::run_thread_on_targetname( "betrayal_interior_clut", ::betrayal_interior_clut );
    common_scripts\utility::run_thread_on_targetname( "betrayal_race", ::lightset_betrayal_race );
    common_scripts\utility::run_thread_on_targetname( "betrayal_intro", ::lightset_betrayal );
    common_scripts\utility::run_thread_on_targetname( "betrayal_interior_in", ::lightset_betrayal_grungy_int );
    common_scripts\utility::run_thread_on_targetname( "betrayal_river_in", ::lightset_betrayal_river_int );
    common_scripts\utility::run_thread_on_targetname( "betrayal_interior_out", ::lightset_betrayal_grungy_out );
    common_scripts\utility::run_thread_on_targetname( "betrayal_river_out", ::lightset_betrayal_river_out );
    common_scripts\utility::run_thread_on_targetname( "betrayal_pigeon", ::exploder_pigeon );
    common_scripts\utility::run_thread_on_targetname( "betrayal_swim_tube", ::visionset_betrayal_swim_tube );
}

lightset_betrayal()
{
    self waittill( "trigger" );
    wait 1.0;
    level.player _meth_83C0( "betrayal" );
}

lightset_betrayal_mall()
{
    self waittill( "trigger" );
    wait 1.0;
    level.player _meth_83C0( "betrayal_mall" );
}

lightset_betrayal_subway()
{
    self waittill( "trigger" );
    wait 1.0;
    level.player _meth_83C0( "betrayal_subway" );
}

lightset_betrayal_interior()
{
    for (;;)
    {
        self waittill( "trigger" );
        level.player _meth_83C0( "betrayal_interior" );

        if ( level.nextgen )
            maps\_utility::vision_set_fog_changes( "betrayal_interior", 1 );
        else
            maps\_utility::vision_set_fog_changes( "betrayal_interior", 1 );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

betrayal_interior_clut()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        level.player _meth_8490( "clut_betrayal_interior_grungy", 12 );
}

lightset_betrayal_race()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        level.player _meth_83C0( "betrayal_grungy_boat_chase" );
        maps\_utility::vision_set_fog_changes( "betrayal_grungy_boat_chase", 2.0 );
        _func_0D3( "r_mbEnable", "2" );
        _func_0D3( "r_mbVelocityScalar", "2" );
    }
}

lightset_betrayal_grungy()
{
    for (;;)
    {
        self waittill( "trigger" );
        maps\_utility::vision_set_fog_changes( "betrayal_grungy", 1 );
        level.player _meth_83C0( "betrayal_grungy" );

        while ( level.player _meth_80A9( self ) )
            wait 0.1;
    }
}

betrayal_interior_darker_fog()
{
    self waittill( "trigger" );
    maps\_utility::vision_set_fog_changes( "betrayal_interior_darker", 3 );
    level.player _meth_83C0( "betrayal_interior_darker" );
}

betrayal_roof_transition()
{
    self waittill( "trigger" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy", 1 );
    level.player _meth_8490( "clut_betrayal_c3_01", 1 );
    level.player _meth_83C0( "betrayal_grungy" );
    wait 3;
    level.player _meth_83C0( "betrayal_grungy_inside" );
    wait 2;
    level.player _meth_83C0( "betrayal_grungy" );
}

lightset_betrayal_grungy_int()
{
    self waittill( "trigger" );
    maps\_utility::vision_set_fog_changes( "betrayal_grungy_market_int", 0.4 );
    level.player _meth_83C0( "betrayal_grungy_inside" );
}

lightset_betrayal_grungy_out()
{
    self waittill( "trigger" );

    if ( level.nextgen )
        maps\_utility::vision_set_fog_changes( "betrayal_grungy", 1.5 );
    else
        maps\_utility::vision_set_fog_changes( "betrayal_grungy_market", 0.4 );

    level.player _meth_83C0( "betrayal_grungy_market" );
}

visionset_betrayal_swim_tube()
{
    self waittill( "trigger" );

    if ( level.nextgen )
    {
        maps\_utility::vision_set_fog_changes( "betrayal_swim_tube", 1 );
        wait 8;
        level.player _meth_83C0( "betrayal_sewer" );
        maps\_utility::vision_set_fog_changes( "betrayal_sewer", 3 );
        var_0 = getentarray( "sewer_light_1", "targetname" );
        thread blink_lights_flicker( var_0, 9000, 7000, 100, 5, 1 );
        level.player_dof_aperture = 8.0;
        level.player_dof_max_distance = 400;
        thread mblur_disable();
    }
    else
    {
        level.player_dof_aperture = 8.0;
        level.player_dof_max_distance = 400;
    }
}

lightset_betrayal_river_int()
{
    self waittill( "trigger" );
    betrayal_boat_vision_set_fog_changes( "betrayal_boat_int", 3 );
    level.player _meth_83C0( "betrayal_grungy_inside" );
}

lightset_betrayal_river_out()
{
    self waittill( "trigger" );
    betrayal_boat_vision_set_fog_changes( "betrayal_grungy_boat_chase", 3 );
    level.player _meth_83C0( "betrayal_grungy" );
}

update_sun_flare_position()
{
    self waittill( "trigger" );
    var_0 = getdvarfloat( "r_lightTweakSunPitch" );
    var_1 = getdvarfloat( "r_lightTweakSunHeading" );
    var_2 = ( var_0, var_1, 0 );
    wait 1.0;
    maps\_shg_fx::set_sun_flare_position( var_2 );
}

intro_sun_flare_position()
{
    self waittill( "trigger" );
    var_0 = ( -34.3, 46.7, 0 );
    maps\_shg_fx::set_sun_flare_position( var_0 );
}

map_sun_flare_position()
{
    self waittill( "trigger" );
    var_0 = ( -65, 46.7, 0 );
    maps\_shg_fx::set_sun_flare_position( var_0 );
}

underwater_visionset_change( var_0 )
{
    var_1 = 0;
    level notify( "stop_swimming_change_fx" );
    var_2 = "tag_origin";
    var_3 = level.player common_scripts\utility::spawn_tag_origin();
    var_3.angles = ( 0, 0, 0 );
    var_3.origin = level.player _meth_80A8() - ( 0, 0, 0 );
    var_3 _meth_80A6( level.player, "tag_origin", ( 70, 0, -1 ), ( -90, 0, 0 ), 0 );

    if ( var_0 )
    {
        var_3.origin = level.player _meth_80A8() - ( 0, 0, 0 );
        maps\_utility::vision_set_fog_changes( "betrayal_swim", 0.02 );
        common_scripts\_exploder::exploder( 666 );
        level.player_dof_aperture = 1.1;
        level.player_dof_max_distance = 100;

        if ( level.nextgen )
        {
            _func_0D3( "r_chromaticAberration", 1 );
            _func_0D3( "r_chromaticSeparationR", 2.0 );
            _func_0D3( "r_chromaticSeparationG", -2.0 );
            _func_0D3( "r_chromaticSeparationB", 0 );
            _func_0D3( "r_chromaticAberrationAlpha", 0.7 );
        }

        playfxontag( common_scripts\utility::getfx( "screen_fx_plunge" ), var_3, var_2 );

        if ( level.nextgen )
            level.player _meth_83C0( "betrayal_boat" );

        maps\_water::setunderwateraudiozone();
        self playlocalsound( "underwater_enter" );
    }
    else
    {
        if ( level.nextgen )
        {
            maps\_utility::fog_set_changes( "betrayal", 0.02 );
            maps\_utility::vision_set_changes( "neutral", 1.0 );
        }
        else
            maps\_utility::vision_set_fog_changes( "betrayal_grungy", 1.0 );

        maps\_utility::pauseexploder( 666 );
        level.player_dof_aperture = 8;
        level.player_dof_max_distance = 400;

        if ( level.nextgen )
        {
            _func_0D3( "r_chromaticAberration", 1 );
            _func_0D3( "r_chromaticSeparationR", 0.5 );
            _func_0D3( "r_chromaticSeparationG", -0.5 );
            _func_0D3( "r_chromaticSeparationB", 0 );
            _func_0D3( "r_chromaticAberrationAlpha", 0.5 );
        }

        killfxontag( common_scripts\utility::getfx( "screen_fx_plunge" ), var_3, var_2 );
        playfxontag( common_scripts\utility::getfx( "screen_fx_emerge" ), var_3, var_2 );
        level.player _meth_83C0( "betrayal_grungy" );
        maps\_water::clearunderwateraudiozone();
        self playlocalsound( "breathing_better" );
        self playlocalsound( "underwater_exit" );
        var_4 = undefined;

        if ( isdefined( self.water_trigger_current ) )
            var_4 = maps\_water::getwaterline( self.water_trigger_current );

        if ( isdefined( var_4 ) )
        {
            var_5 = ( self.origin[0], self.origin[1], var_4 );
            playfx( level._effect["water_splash_emerge"], var_5, anglestoforward( ( 0, self.angles[1], 0 ) + ( 270, 180, 0 ) ) );
        }
    }

    var_3 thread underwater_visionset_change_cleanup();
}

underwater_visionset_change_cleanup()
{
    level common_scripts\utility::waittill_any_timeout( 1.0, "stop_swimming_change_fx" );
    self _meth_804F();
    self delete();
}

betrayal_boat_vision_set_fog_changes( var_0, var_1 )
{
    level.current_betrayal_boat_vision_fog = var_0;
    maps\_utility::vision_set_fog_changes( var_0, var_1 );
}

underwater_boat_visionset_change()
{
    var_0 = 0;
    var_1 = "tag_origin";
    var_2 = level.player_boat common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( level.player_boat, "tag_origin", ( 100, 0, 0 ), ( -90, 0, 0 ) );
    var_3 = level.player_boat common_scripts\utility::spawn_tag_origin();
    var_3 _meth_804D( level.player_boat, "tag_origin", ( 800, 0, -80 ), ( -90, 0, 0 ) );
    var_4 = level.player_boat common_scripts\utility::spawn_tag_origin();
    var_4 _meth_804D( level.player_boat, "tag_origin", ( 1800, 0, -80 ), ( -90, 0, 0 ) );
    var_5 = level.player_boat common_scripts\utility::spawn_tag_origin();
    var_5 _meth_804D( level.player_boat, "tag_origin", ( 800, -1000, -80 ), ( -90, 0, 0 ) );
    var_6 = level.player_boat common_scripts\utility::spawn_tag_origin();
    var_6 _meth_804D( level.player_boat, "tag_origin", ( 800, 1000, -80 ), ( -90, 0, 0 ) );

    if ( isdefined( level.current_betrayal_boat_vision_fog ) )
        var_7 = level.current_betrayal_boat_vision_fog;
    else
        var_7 = "";

    for (;;)
    {
        if ( isdefined( level.player_boat ) )
        {
            var_8 = level.player_boat _meth_84C7();

            if ( var_8 != var_0 )
            {
                if ( var_8 )
                {
                    if ( isdefined( level.current_betrayal_boat_vision_fog ) )
                        var_7 = level.current_betrayal_boat_vision_fog;
                    else
                        var_7 = "";

                    if ( var_7 == "betrayal_boat_int" )
                        betrayal_boat_vision_set_fog_changes( "betrayal_underwater_int", 0.02 );
                    else
                        betrayal_boat_vision_set_fog_changes( "betrayal_underwater", 0.02 );

                    level.player_dof_aperture = 1.1;
                    level.player_dof_max_distance = 100;

                    if ( level.nextgen )
                    {
                        _func_0D3( "r_chromaticAberration", 1 );
                        _func_0D3( "r_chromaticSeparationR", 2.0 );
                        _func_0D3( "r_chromaticSeparationG", -2.0 );
                        _func_0D3( "r_chromaticSeparationB", 0 );
                        _func_0D3( "r_chromaticAberrationAlpha", 0.7 );
                    }

                    level.player _meth_83C0( "betrayal_boat" );
                    level.player_boat thread maps\betrayal_fx::vm_boat_submerge_fx();
                }
                else
                {
                    if ( level.nextgen )
                    {
                        betrayal_boat_vision_set_fog_changes( var_7, 0.02 );
                        level.player_dof_aperture = 8;
                        level.player_dof_max_distance = 400;
                        _func_0D3( "r_chromaticAberration", 1 );
                        _func_0D3( "r_chromaticSeparationR", 0.5 );
                        _func_0D3( "r_chromaticSeparationG", -0.5 );
                        _func_0D3( "r_chromaticSeparationB", 0 );
                        _func_0D3( "r_chromaticAberrationAlpha", 0.5 );
                    }

                    if ( level.nextgen )
                        level.player _meth_83C0( "betrayal_grungy_boat_chase" );
                    else
                    {
                        level.player _meth_83C0( "betrayal_grungy_boat_chase" );
                        betrayal_boat_vision_set_fog_changes( "betrayal_boat_chase", 0.02 );
                    }

                    level.player_boat thread maps\betrayal_fx::vm_boat_emerge_fx();
                }

                var_0 = var_8;
            }
        }

        waitframe();
    }
}

exploder_pigeon()
{
    var_0 = 901;

    for (;;)
    {
        self waittill( "trigger" );
        common_scripts\_exploder::exploder( var_0 );
        wait 1;
    }
}

manhole_lighting()
{
    var_0 = getent( "manhole_cover_2", "targetname" );
    var_1 = getent( "oldtown_sewer_lid", "targetname" );
    var_1 _meth_847B( var_0.origin );
}
