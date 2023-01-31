// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread set_level_lighting_values();
    thread dof_init();
    thread lgt_init();
    thread retarget_model_init();
}

retarget_model_init()
{
    waitframe();
    waitframe();
    var_0 = getentarray( "s1_intro_elevator_door", "targetname" );
    var_1 = spawn( "script_model", ( 5520, -5504, -16 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "model_s3interrogation_doorin", "targetname" );
    var_1 = spawn( "script_model", ( 4803, -9935, -1708 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "model_s3escape_doorout", "targetname" );
    var_1 = spawn( "script_model", ( 5232, -9928, -1760 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "model_s3escape_docdoor", "targetname" );
    var_1 = spawn( "script_model", ( 5256, -10304, -1760 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "door_ah_morgue", "targetname" );
    var_1 = spawn( "script_model", ( 4960, -13104, -1620 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "tc_side_doors", "targetname" );
    var_1 = spawn( "script_model", ( 3888, -11068, -1544 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "door_bh_yard", "targetname" );
    var_1 = spawn( "script_model", ( 11408, -13608, -1852 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );

    var_0 = getentarray( "door_bh_mech", "targetname" );
    var_1 = spawn( "script_model", ( 11408, -13608, -1852 ) );
    var_1 _meth_80B1( "tag_origin" );

    foreach ( var_3 in var_0 )
        var_3 _meth_83EF( var_1 );
}

lgt_init()
{
    thread lgt_s2_walk();
    thread lgt_escape_door_alarm();
    thread lgt_emergency_screens();
    thread lgt_sys_hacking();
    thread lgt_test_chamber();
    thread lgt_uv_flash();
    thread lgt_morgue();
    thread lgt_incinerator_seq();
    thread lgt_heli_escape();
    thread lgt_manticore_bay();
    thread lgt_mech2_door();
}

dof_init()
{
    thread dof_introdrive_seq();
    thread dof_s2_walk();
    thread dof_s3_interrogation();
    thread dof_escape_gun_seq();
    thread dof_sys_hacking();
    thread dof_uv_flash();
    thread dof_incinerator_seq();
    thread dof_autopsy_door_seq();
    thread dof_manticore_hangar();
    thread dof_heli_flight_seq();
    thread dof_heli_crash();
    thread dof_mech_suit_entrance();
    thread dof_mech_jump_getup();
    thread dof_mech_gate_crash();
    thread dof_mech_door();
    thread dof_end_escape();
}

set_level_lighting_values()
{
    if ( _func_235() )
    {
        _func_0D3( "r_disableLightSets", 0 );
        _func_0D3( "r_mdao", 1 );
        _func_0D3( "r_mdaoOccluderCullDistance", 641 );
    }

    if ( level.nextgen )
        _func_0D3( "r_hemiAoEnable", 1 );
}

lgt_change_intensity_over_time( var_0, var_1 )
{
    var_2 = int( var_1 * 20 );
    var_3 = self _meth_81DE();
    var_4 = ( var_0 - var_3 ) / var_2;

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        self _meth_81DF( var_3 + var_5 * var_4 );
        wait 0.05;
    }

    self _meth_81DF( var_0 );
}

lgt_emergency_screens()
{
    var_0 = getentarray( "lgt_screen_emergency", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 thread lgt_alarm_pulsing( 6000, 0.15, 0.3, 0.15, 0.6 );
}

lgt_start_fire( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.85;

    self endon( "kill_incinerator_light" );

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
    {
        self _meth_81DF( 0.01 );
        return;
    }

    var_2 = ( 0.992157, 0.321569, 0.101961 );
    var_3 = ( 0.305, 0.475, 0.895 );

    for ( var_4 = 0; var_4 < var_0; var_4++ )
    {
        self _meth_81DF( 0.01 );
        self _meth_8044( var_2 );
        var_5 = randomfloatrange( 1.7, 2.2 );
        lgt_change_intensity_over_time( 54000, var_5 );
        wait(4.0 - var_5);
        lgt_change_intensity_over_time( 0.01, 1 );
        self _meth_8044( var_3 );
        wait 0.5;
        lgt_change_intensity_over_time( 15, 0.5 );
        wait 0.85;
    }
}

lgt_alarm_pulsing( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "kill_pulse_light" );

    if ( getdvar( "r_reflectionProbeGenerate" ) == "1" )
    {
        self _meth_81DF( 0 );
        return;
    }

    var_5 = self _meth_81DE();

    if ( isdefined( var_0 ) )
        var_5 = var_0;

    if ( !isdefined( var_3 ) )
        var_3 = 0.5;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_6 = 0.05;
    var_7 = var_5;

    if ( !isdefined( var_1 ) )
        var_1 = 0.3;

    if ( !isdefined( var_2 ) )
        var_2 = 0.6;

    var_8 = ( var_5 - var_6 ) / ( var_1 / 0.05 );
    var_9 = ( var_5 - var_6 ) / ( var_2 / 0.05 );

    for (;;)
    {
        var_10 = 0;

        while ( var_10 < var_2 )
        {
            var_7 -= var_9;
            var_7 = clamp( var_7, 0, 100 );
            self _meth_81DF( var_7 );
            var_10 += 0.05;
            wait 0.05;
        }

        wait(var_4);
        var_10 = 0;

        while ( var_10 < var_1 )
        {
            var_7 += var_8;
            var_7 = clamp( var_7, 0, 100 );
            self _meth_81DF( var_7 );
            var_10 += 0.05;
            wait 0.05;
        }

        wait(var_3);
    }
}

lgt_s2_walk()
{
    var_0 = getentarray( "lgt_s2_elevator", "script_noteworthy" );
    common_scripts\utility::flag_wait( "lgt_flag_elevator_entered" );

    foreach ( var_2 in var_0 )
        var_2 thread lgt_change_intensity_over_time( 6500, 0.3 );
}

lgt_escape_door_alarm()
{
    common_scripts\utility::flag_wait( "lgt_flag_interrogation_esc" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = ( 5245.18, -10373.4, -1681.97 );
    var_0 soundscripts\_snd::snd_message( "aud_red_light" );
    wait 1.4;
    thread maps\captured_fx::fx_emergency_lights( "fx_emergency_lights_s3door", "lgt_flag_interrogation_esc_done", 2.4 );
    common_scripts\utility::flag_wait( "lgt_flag_interrogation_esc_done" );
    var_0 delete();
}

lgt_sys_hacking()
{
    level waittill( "finished_door_hacking" );
    waitframe();
    waitframe();
    thread maps\captured_fx::fx_emergency_lights( "fx_emergency_lights_hack", "lgt_flag_tc_alarms_off", 0.75 );
}

lgt_test_chamber()
{

}

lgt_uv_flash()
{
    level waittill( "start_anim_tc_exit_stairs" );
    var_0 = getentarray( "lgt_uv_decontamination", "script_noteworthy" );
    var_1 = getent( "lgt_uv_bake_red", "script_noteworthy" );
    var_1 _meth_8044( ( 0.95, 0.2, 0.1 ) );
    var_1 _meth_81DF( 1600 );
    common_scripts\_exploder::exploder( "fx_uv_orange_light" );
    var_2 = getent( "lgt_uv_bake_green", "script_noteworthy" );
    var_2 _meth_8044( ( 0.1, 0.95, 0.2 ) );
    var_2 _meth_81DF( 0.01 );
    level waittill( "start_anim_tc_enter_test" );

    foreach ( var_4 in var_0 )
        var_4 thread lgt_change_intensity_over_time( 8000, 1.3 );

    wait 0.6;

    foreach ( var_4 in var_0 )
        var_4 thread lgt_change_intensity_over_time( 24000, 1.1 );

    wait 0.6;

    foreach ( var_4 in var_0 )
        var_4 thread lgt_change_intensity_over_time( 1500, 0.3 );

    wait 4.5;
    common_scripts\_exploder::kill_exploder( "fx_uv_orange_light" );
    var_1 lgt_change_intensity_over_time( 0.01, 0.25 );
    common_scripts\_exploder::exploder( "fx_uv_green_light" );
    var_2 lgt_change_intensity_over_time( 1600, 0.25 );
    wait 5;
    var_2 lgt_change_intensity_over_time( 0.01, 0.25 );
    common_scripts\_exploder::kill_exploder( "fx_uv_green_light" );
}

lgt_morgue()
{
    if ( !common_scripts\utility::flag_exist( "lgt_flag_morgue_end" ) )
        common_scripts\utility::flag_init( "lgt_flag_morgue_end" );

    thread maps\captured_fx::fx_emergency_lights( "fx_emergency_lights_morgue", "lgt_flag_morgue_end" );
}

lgt_incinerator_seq()
{
    if ( !common_scripts\utility::flag_exist( "lgt_flag_inc_near_miss" ) )
        common_scripts\utility::flag_init( "lgt_flag_inc_near_miss" );

    if ( !common_scripts\utility::flag_exist( "lgt_flag_inc_pipe_explode" ) )
        common_scripts\utility::flag_init( "lgt_flag_inc_pipe_explode" );

    if ( !common_scripts\utility::flag_exist( "flag_incinerator_saved" ) )
        common_scripts\utility::flag_init( "flag_incinerator_saved" );

    var_0 = getentarray( "lgt_incinerator_fire", "script_noteworthy" );
    var_1 = getent( "lgt_incinerator_gideon", "script_noteworthy" );
    var_2 = getent( "lgt_incinerator_fire1", "script_noteworthy" );
    var_3 = getent( "lgt_incinerator_fire2", "script_noteworthy" );
    var_4 = getent( "lgt_incinerator_fire3", "script_noteworthy" );
    var_5 = getent( "lgt_incinerator_fire4", "script_noteworthy" );
    var_6 = getent( "lgt_incinerator_fire5", "script_noteworthy" );
    var_7 = getent( "lgt_incinerator_fire_under", "script_noteworthy" );
    var_8 = ( 0.992157, 0.321569, 0.101961 );
    var_9 = ( 0.305, 0.475, 0.895 );
    var_10 = [ var_2, var_3, var_4, var_5, var_6 ];

    if ( level.nextgen )
    {
        var_1 _meth_81DF( 0.01 );
        var_1 _meth_8044( var_9 );
        common_scripts\utility::array_call( var_10, ::_meth_81DF, 0.01 );
        common_scripts\utility::array_call( var_10, ::_meth_8044, var_9 );
        common_scripts\utility::array_call( var_10, ::_meth_8046, 100 );
        common_scripts\utility::array_call( var_0, ::_meth_81DF, 0.01 );
        var_2 _meth_8046( 700 );
        var_7 _meth_81DF( 100 );
    }

    var_11 = common_scripts\utility::flag_wait_either_return( "flag_autopsy_end", "flag_incinerator_saved" );
    maps\_utility::fog_set_changes( "captured", 0.01 );

    if ( var_11 == "flag_autopsy_end" )
        common_scripts\utility::flag_wait( "flag_incinerator_saved" );

    maps\_art::sunflare_changes( "incinerator", 0 );
    var_12 = randomfloatrange( 0.35, 0.5 );
    thread maps\_utility::vision_set_fog_changes( "", var_12 * 5 );
    wait 8.15;

    if ( level.nextgen )
    {
        var_1 thread lgt_change_intensity_over_time( 15, var_12 );
        var_6 lgt_change_intensity_over_time( 15, var_12 );
        wait(2.43 - var_12);
        var_12 = randomfloatrange( 0.35, 0.5 );
        var_5 lgt_change_intensity_over_time( 100, var_12 );
        wait(0.9 - var_12);
        var_12 = randomfloatrange( 0.3, 0.45 );
        var_4 lgt_change_intensity_over_time( 60, var_12 );
        wait(0.77 - var_12);
        var_12 = randomfloatrange( 0.35, 0.5 );
        var_3 lgt_change_intensity_over_time( 60, var_12 );
        wait(0.6 - var_12);
        var_12 = randomfloatrange( 0.2, 0.4 );
        var_2 lgt_change_intensity_over_time( 65, var_12 );
        wait(0.53 - var_12);
        var_1 thread lgt_change_intensity_over_time( 25, 1.25 );
        var_12 = randomfloatrange( 0.23, 0.4 );
        var_2 lgt_change_intensity_over_time( 115, var_12 );
        wait 0.7;
        var_2 _meth_81DF( 0.01 );
        var_2 _meth_8044( var_8 );
        var_3 _meth_81DF( 0.01 );
        var_3 _meth_8044( var_8 );
        var_3 _meth_8046( 200 );
        var_2 thread lgt_start_fire( 1 );
        var_3 lgt_start_fire( 1 );
        wait 1.75;
        var_3 _meth_81DF( 0.01 );
        var_3 _meth_8046( 400 );
        var_3 _meth_8044( var_8 );
        var_4 _meth_8046( 400 );
        var_4 thread lgt_start_fire( 1 );
        var_3 lgt_start_fire( 1 );
        wait 1.75;
        var_4 _meth_81DF( 0.01 );
        var_4 _meth_8046( 400 );
        var_4 _meth_8044( var_8 );
        var_4 lgt_start_fire( 1 );
        wait 1.75;
        var_5 _meth_81DF( 0.01 );
        var_5 _meth_8046( 400 );
        var_5 _meth_8044( var_8 );
        var_5 thread lgt_start_fire( 6, 2.6 );
        common_scripts\utility::flag_wait( "lgt_flag_inc_near_miss" );
        common_scripts\utility::array_call( var_10, ::_meth_8046, 20 );
        var_5 _meth_8046( 200 );
        var_5 notify( "kill_incinerator_light" );
        var_5 thread lgt_start_fire( 40, 2.6 );
        wait 1.75;

        foreach ( var_14 in var_0 )
            var_14 thread lgt_start_fire( 40, 2.6 );

        common_scripts\utility::flag_wait( "lgt_flag_inc_pipe_explode" );
        var_7 lgt_change_intensity_over_time( 10000, randomfloatrange( 0.23, 0.4 ) );
        wait 1.4;
        var_7 lgt_change_intensity_over_time( 0.01, randomfloatrange( 0.23, 0.4 ) );
        common_scripts\utility::flag_wait( "flag_incinerator_end" );

        foreach ( var_14 in var_10 )
        {
            var_14 notify( "kill_incinerator_light" );
            wait(randomfloatrange( 0.6, 1.1 ));
        }

        foreach ( var_14 in var_0 )
        {
            var_14 notify( "kill_incinerator_light" );
            wait(randomfloatrange( 0.6, 1.1 ));
        }
    }
}

lgt_heli_escape()
{
    common_scripts\utility::flag_wait( "flag_bh_intro_start_scene" );
    wait 2.0;
    thread maps\captured_fx::fx_emergency_lights( "fx_emergency_lights_heli", "flag_bh_pit", 2.0 );
}

lgt_manticore_bay()
{
    var_0 = getentarray( "lgt_manticore_pulsing", "script_noteworthy" );
    common_scripts\utility::flag_wait( "flag_s3guard_security_door_shuts" );

    foreach ( var_2 in var_0 )
        var_2 thread lgt_alarm_pulsing( 15000 );

    common_scripts\utility::flag_wait( "s3escape_hall_enemies_dead" );

    foreach ( var_2 in var_0 )
        var_2 notify( "kill_pulse_light" );
}

lgt_mech2_door()
{
    if ( !common_scripts\utility::flag_exist( "lgt_flag_mb2_end" ) )
        common_scripts\utility::flag_init( "lgt_flag_mb2_end" );

    common_scripts\utility::flag_wait( "flag_mb1_end" );
    thread maps\captured_fx::fx_emergency_lights( "fx_emergency_lights_mb2", "lgt_flag_mb2_end" );
    wait 20;
    common_scripts\utility::flag_set( "lgt_flag_mb2_end" );
}

dof_set_focus( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_4 ) && isdefined( var_5 ) )
        level.player _meth_84AB( var_2, var_3, var_4, var_5 );
    else
        level.player _meth_84AB( var_2, var_3 );

    wait(var_1);
}

dof_introdrive_seq()
{
    common_scripts\utility::flag_wait( "lgt_flag_introdrive" );
    _func_0D3( "r_dof_physical_bokehEnable", 1 );

    if ( level.xb3 )
    {
        _func_0D3( "sm_sunShadowBoundsMin", "-10240 -10240 -64" );
        _func_0D3( "sm_sunShadowBoundsMax", "10240 10240 2048" );
        _func_0D3( "sm_sunShadowBoundsOverride", "1" );
    }

    level.player _meth_84A9();
    dof_set_focus( "beginning hands", 5.5, 2.8, 20.0 );
    dof_set_focus( "background look up", 9.0, 11, 1860.0, 2, 1 );
    dof_set_focus( "faces", 20.0, 2.8, 65.0, 0.5, 0.5 );
    dof_set_focus( "slow down", 8.5, 8.0, 65.0, 3, 1.5 );
    dof_set_focus( "guard approach", 2, 5.6, 60.0 );
    dof_set_focus( "guard climb", 1.5, 5.6, 25.0 );
    dof_set_focus( "guard and Ilana", 2.25, 5.6, 13.0 );
    dof_set_focus( "guard close", 4, 5.6, 10.0 );
    dof_set_focus( "guard when falling", 1.25, 5.6, 60.0 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", 2 );
        _func_0D3( "r_mbCameraRotationInfluence", 1 );
        _func_0D3( "r_mbCameraTranslationInfluence", 1 );
        _func_0D3( "r_mbVelocityScalar", 0.85 );
    }

    dof_set_focus( "hit", 1.0, 1.2, 40.0 );
    _func_0D3( "sm_sunsamplesizenear", 0.6 );
    dof_set_focus( "hands", 2.25, 3.5, 20.0 );
    dof_set_focus( "gideon", 1.5, 5.6, 100.0 );
    dof_set_focus( "gideon and co", 5, 3.5, 260.0 );

    if ( level.nextgen )
    {
        _func_0D3( "r_mbEnable", 0 );
        _func_0D3( "r_dof_physical_hipEnable", 1 );
        _func_0D3( "r_dof_physical_hipFstop", 4 );
        _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.08 );
    }

    if ( level.xb3 )
        _func_0D3( "sm_sunShadowBoundsOverride", "0" );

    common_scripts\utility::flag_wait( "flag_start_s1elevator" );
    _func_0D3( "sm_sunsamplesizenear", "0.1" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
    level.player _meth_84AA();
}

dof_s2_walk()
{
    common_scripts\utility::flag_wait( "flag_s2walk_start" );
    level.player _meth_84A9();
    _func_0D3( "r_mbEnable", 3 );
    _func_0D3( "r_mbCameraTranslationInfluence", 1 );
    dof_set_focus( "hands", 2.25, 3.5, 30.0 );
    dof_set_focus( "walk", 2.25, 3.5, 100.0 );
    level waittill( "trolley_doctor_start" );
    wait 2.0;
    dof_set_focus( "gideon start", 1.5, 1.25, 85.0, 2, 2 );
    dof_set_focus( "gideon", 3.0, 0.5, 85.0, 2, 2 );
    dof_set_focus( "doctor", 2.5, 3.5, 18.0 );
    dof_set_focus( "out", 0, 0.5, 20.0 );
    wait 0.5;
    common_scripts\utility::flag_wait( "flag_s2elevator_end" );
    _func_0D3( "r_mbEnable", 0 );
    level.player _meth_84AA();
}

dof_s3_interrogation()
{
    common_scripts\utility::flag_wait( "lgt_flag_interrogation_begin" );
    level.player _meth_84A9();
    dof_set_focus( "interrogation wake up", 4, 3.0, 24.0 );
    dof_set_focus( "Hands", 2.5, 5.6, 24.0 );
    dof_set_focus( "Friends", 5.5, 2.0, 170.0 );
    dof_set_focus( "Iron Enter", 2.5, 3.5, 64.0 );
    dof_set_focus( "Iron Enter 2", 3, 5.6, 54.0 );
    dof_set_focus( "Iron turn", 7.5, 5.0, 76.0 );
    dof_set_focus( "Iron talk", 17.5, 8.0, 56.0 );
    dof_set_focus( "Iron start Close", 2.75, 8.0, 30.0 );
    dof_set_focus( "Iron mid Close", 1.75, 7.5, 23.0 );
    dof_set_focus( "Iron Close", 12.0, 7.5, 20.0 );
    dof_set_focus( "Cormack", 11.0, 6.5, 70.0 );
    dof_set_focus( "Irons shoot", 14.0, 6.5, 65.0 );
    dof_set_focus( "Iron far", 8.5, 4.0, 145.0 );
    dof_set_focus( "Iron / Cormack", 3, 6.0, 80.0 );
    dof_set_focus( "Cormack", 3.0, 4.0, 50.0 );
    dof_set_focus( "Iron close again", 12.5, 7.5, 24.0 );
    dof_set_focus( "Right up", 14.0, 11, 12.5 );
    dof_set_focus( "Hands 1", 1.0, 8, 14.0 );
    dof_set_focus( "Face", 1.5, 6, 24.0 );
    dof_set_focus( "Hands 2", 4.5, 8, 14.0 );
    dof_set_focus( "Close", 14, 11, 20.0 );
    dof_set_focus( "Fade Out", 10.0, 4.0, 54.0, 4, 5 );
    dof_set_focus( "Fade In", 2.5, 0.4, 24.0 );
    dof_set_focus( "Fade Up", 3, 1.4, 74.0 );
    dof_set_focus( "Friends", 5, 3.5, 154.0 );
    dof_set_focus( "Friends escape", 6, 5.5, 74.0 );
    dof_set_focus( "Gideon", 9, 7.0, 40.0 );
    dof_set_focus( "Undo shackles", 7, 3.5, 30.0 );
    dof_set_focus( "Everyone", 5, 11.0, 64.0 );
    common_scripts\utility::flag_wait( "flag_s3interrogate_end" );
    level.player _meth_84AA();
}

dof_escape_gun_seq()
{
    level waittill( "s3_escape_player_got_gun" );
    level.player _meth_84A9();
    _func_0D3( "r_dof_physical_bokehEnable", 1 );
    dof_set_focus( "beginning gun", 1, 8, 31.0 );
    dof_set_focus( "gideon", 9, 4.5, 31.0, 2, 1 );
    dof_set_focus( "gideonfar", 5, 22, 170, 3, 4 );
    _func_0D3( "r_dof_physical_bokehEnable", 0 );
    level.player _meth_84AA();
}

dof_sys_hacking()
{
    level waittill( "started_door_hacking" );
    level.player _meth_84A9();
    _func_0D3( "r_dof_physical_bokehEnable", 1 );
    wait 0.5;
    dof_set_focus( "hacking", 6.5, 2, 32.0, 1.5, 1.5 );
    level waittill( "finished_door_hacking" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
    _func_0D3( "r_dof_physical_bokehEnable", 0 );
    level.player _meth_84AA();
}

dof_uv_flash()
{
    level waittill( "start_anim_tc_enter_test" );
    level.player _meth_84A9();
    dof_set_focus( "Gideon", 5.4, 3.0, 94.0 );
    common_scripts\utility::flag_wait( "lgt_flag_entered_tc" );
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 4.0 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.22 );
    common_scripts\utility::flag_wait( "lgt_flag_exit_tc" );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.15 );
    wait 1.0;
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.08 );
    wait 1.0;
    _func_0D3( "r_dof_physical_hipEnable", 0 );
    level.player _meth_84AA();
}

dof_autopsy_door_seq()
{
    common_scripts\utility::flag_wait( "lgt_flag_entered_autopsy" );
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 2.0 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.05 );
    level waittill( "doctor_door_weapon_hidden" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
    level.player _meth_84A9();
    dof_set_focus( "face and gun", 2.5, 2.2, 25.0, 3.5, 3.5 );
    dof_set_focus( "doctor", 1.0, 4.0, 65.0, 1.0, 2.0 );
    level.player _meth_84AA();
}

dof_incinerator_seq()
{
    var_0 = common_scripts\utility::flag_wait_either_return( "flag_autopsy_end", "flag_incinerator_saved" );

    if ( var_0 == "flag_autopsy_end" )
        common_scripts\utility::flag_wait( "flag_incinerator_saved" );

    wait 8.15;
    level.player _meth_84A9();
    dof_set_focus( "Gideon", 2.43, 4.0, 20.0 );
    dof_set_focus( "pilot 2", 1.9, 3.5, 109.0 );
    dof_set_focus( "pilot 3", 5.0, 2.6, 250.0 );
    dof_set_focus( "Gideon again", 2.0, 4.0, 20.0 );
    dof_set_focus( "Gideon further", 2.0, 4.0, 60, 5, 3 );
    common_scripts\utility::flag_wait( "flag_incinerator_push_start" );
    dof_set_focus( "Gideon close", 6.0, 4.0, 32, 5, 3 );
    common_scripts\utility::flag_wait( "lgt_flag_inc_near_miss" );
    dof_set_focus( "near miss", 0, 5.6, 50.0 );
    common_scripts\utility::flag_wait( "lgt_flag_inc_pipe_explode" );
    common_scripts\utility::flag_wait( "flag_incinerator_end" );
    level.player _meth_84AA();
}

dof_manticore_hangar()
{
    level waittill( "lgt_dof_run_to_heli" );
    thread heli_probe_override();
    level.player _meth_84A9();
    dof_set_focus( "Gideon", 2.5, 4.0, 180.0 );
    common_scripts\utility::flag_wait( "flag_player_and_ally_at_window" );
    level.player _meth_84AA();
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 11 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.055 );
    common_scripts\utility::flag_wait( "flag_bh_run" );
    _func_0D3( "r_mbEnable", 2 );
    _func_0D3( "r_mbCameraRotationInfluence", 1 );
    _func_0D3( "r_mbCameraTranslationInfluence", 1 );
    _func_0D3( "r_mbVelocityScalar", 0.2 );
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
}

dof_heli_flight_seq()
{
    common_scripts\utility::flag_wait( "flag_heliride_warbird_mount" );
    level.player _meth_83C1( "captured_heli", 12 );
    _func_0D3( "r_mbEnable", 3 );
    _func_0D3( "r_mbCameraRotationInfluence", 1 );
    _func_0D3( "r_mbCameraTranslationInfluence", 1 );
    _func_0D3( "r_mbVelocityScalar", 0.2 );
    level.player _meth_84A9();
    dof_set_focus( "heli board", 3, 2.5, 60, 0.5, 1 );
    dof_set_focus( "heli flight", 0, 1.8, 80, 2, 4 );
    common_scripts\utility::flag_wait( "flag_heliride_end" );
    _func_0D3( "r_mbEnable", 0 );
    level.player _meth_84AA();
    level.player _meth_83C2();
}

dof_heli_crash()
{
    level waittill( "anim_mech_wakeup" );
    level.player _meth_84A9();
    dof_set_focus( "Wake up", 2.43, 2.6, 24.0 );
    dof_set_focus( "Hands", 5, 2.6, 44.0 );
    dof_set_focus( "Gideon slide", 3, 2.6, 180.0 );
    dof_set_focus( "Gideon close", 7, 2.6, 50.0 );
    level.player _meth_84AA();
}

dof_mech_suit_entrance()
{
    common_scripts\utility::flag_wait( "flag_getting_into_mech" );
    level.player _meth_84A9();
    _func_0D3( "r_mbEnable", 2 );
    _func_0D3( "r_mbCameraRotationInfluence", 1 );
    _func_0D3( "r_mbCameraTranslationInfluence", 1 );
    _func_0D3( "r_mbVelocityScalar", 0.2 );
    dof_set_focus( "mech", 17, 4.0, 22.0 );
    dof_set_focus( "inside mech", 5.0, 5.0, 200.0 );
    common_scripts\utility::flag_wait( "lgt_flag_mech_entered" );
    _func_0D3( "r_mbEnable", 0 );
    level.player _meth_84AA();
}

dof_mech_jump_getup()
{

}

dof_mech_gate_crash()
{

}

dof_mech_door()
{
    level waittill( "lgt_dof_mechdoor" );
    _func_0D3( "r_dof_physical_hipEnable", 1 );
    _func_0D3( "r_dof_physical_hipFstop", 3.5 );
    _func_0D3( "r_dof_physical_hipSharpCocDiameter", 0.08 );
    _func_0D3( "r_mbEnable", 2 );
    _func_0D3( "r_mbCameraRotationInfluence", 1 );
    _func_0D3( "r_mbCameraTranslationInfluence", 1 );
    _func_0D3( "r_mbVelocityScalar", 0.2 );
    common_scripts\utility::flag_wait( "flag_gatedoor_end" );
    _func_0D3( "r_dof_physical_hipEnable", 0 );
}

dof_end_escape()
{
    level waittill( "truck_dof" );
    level.player _meth_84A9();
    dof_set_focus( "hands on ground", 3.5, 4, 20.0 );
    dof_set_focus( "gideon", 6.0, 2, 170.0 );
    dof_set_focus( "gideon near", 1.5, 0.8, 100.0 );
    dof_set_focus( "gideon nearer", 1.25, 1.6, 75.0 );
    dof_set_focus( "explosion", 2.25, 0.8, 1400.0 );
    dof_set_focus( "gideon", 1.75, 2.4, 65.0 );
    dof_set_focus( "gideon away", 6.25, 2.5, 150.0 );
    dof_set_focus( "Ilana", 6.0, 16.0, 40.0 );
    dof_set_focus( "Gideon close", 15, 2.5, 32.0 );
    level.player _meth_84AA();
}

heli_probe_override()
{
    script_probe_heli_open();
    common_scripts\utility::flag_wait( "flag_heliride_end" );
    script_probe_heli_reset();
}

script_probe_heli_open()
{
    var_0 = getent( "refl_probe_heli_open", "targetname" );
    level waittill( "all_heliride_pieces_spawned" );
    level._facility.warbird _meth_83AB( var_0.origin );
    level.player_rig _meth_83AB( var_0.origin );
    level.allies[0] _meth_83AB( var_0.origin );
    level.pilot _meth_83AB( var_0.origin );
    level.mech_pilot _meth_83AB( var_0.origin );
    level.heli_collision _meth_83AB( var_0.origin );
    level.glass _meth_83AB( var_0.origin );
    level.glass_broken _meth_83AB( var_0.origin );
}

script_probe_heli_closed()
{
    var_0 = getent( "refl_probe_heli_closed", "targetname" );
    level._facility.warbird _meth_83AB( var_0.origin );
    level.player_rig _meth_83AB( var_0.origin );
    level.allies[0] _meth_83AB( var_0.origin );
    level.pilot _meth_83AB( var_0.origin );
    level.mech_pilot _meth_83AB( var_0.origin );
    level.heli_collision _meth_83AB( var_0.origin );
    level.glass _meth_83AB( var_0.origin );
    level.glass_broken _meth_83AB( var_0.origin );
}

script_probe_heli_reset()
{
    level.allies[0] _meth_83AC();
}
