// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("player");

anim_single_droppod_custom( var_0, var_1, var_2 )
{
    thread maps\_anim::anim_single( var_0, var_2 );
    var_3 = getanimlength( var_1 maps\_utility::getanim( var_2 ) );
    var_4 = 9.3;
    var_5 = 14.6666;
    wait(var_4);
    level.player notify( "start_droppod_qte" );
    thread process_buttonmash( var_1 );
    wait(var_5 - var_4);
    level.player notify( "end_process_buttonmash" );
    var_1 _meth_814C( %seo_pod_phase3_vm_root, 0.0, 0.5, 1 );

    if ( var_1.buttonmash_value >= 1.0 )
    {
        wait(var_3 - var_5);
        level.player notify( "end_droppod_qte" );
        return 1;
    }
    else
        return 0;
}

process_buttonmash( var_0 )
{
    level.player endon( "end_process_buttonmash" );
    var_0.buttonmash_decay_per_frame = 0.025;
    var_0.buttonmash_value = 0.0;
    var_0.buttonmash_add_per_press = 0.15;
    var_0.buttonmash_max = 1.2;
    level.player _meth_82DD( "x_pressed", "+usereload" );
    level.player _meth_82DD( "x_pressed", "+activate" );
    var_0 _meth_814C( %seo_pod_phase3_vm_root, 0.01, 0, 1 );
    var_0 _meth_814C( %seo_pod_phase3_vm_add, 1 );
    var_0 _meth_8117( %seo_pod_phase3_vm_add, 1 );

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        level.player thread maps\_shg_utility::button_mash_dynamic_hint( &"SEOUL_TAP_X_TO_PULL_LEVER", "+usereload", "end_process_buttonmash", "+activate" );
    else
        level.player thread maps\_shg_utility::button_mash_dynamic_hint( &"SEOUL_TAP_X_TO_PULL_LEVER", "+reload", "end_process_buttonmash", "+activate" );

    thread animation_process( var_0, "x_pressed", "b_pressed", "a_pressed" );

    for (;;)
    {
        level.player common_scripts\utility::waittill_any( "x_pressed", "b_pressed", "a_pressed" );
        var_0.buttonmash_value += var_0.buttonmash_add_per_press;

        if ( var_0.buttonmash_value > var_0.buttonmash_max )
            var_0.buttonmash_value = var_0.buttonmash_max;
    }
}

animation_process( var_0, var_1, var_2, var_3 )
{
    level.player endon( "end_process_buttonmash" );
    level.player endon( var_1 );
    level.player endon( var_2 );
    level.player endon( var_3 );
    var_4 = 0.05;
    var_5 = var_0.buttonmash_value;

    if ( var_0.buttonmash_value > 0.95 )
        var_5 = 1.0;

    var_0 _meth_814C( %seo_pod_phase3_vm_root, var_5, var_4, 1 );
    wait(var_4);

    for (;;)
    {
        var_0.buttonmash_value -= var_0.buttonmash_decay_per_frame;

        if ( var_0.buttonmash_value < 0.0 )
            var_0.buttonmash_value = 0.0;

        var_5 = var_0.buttonmash_value;

        if ( var_0.buttonmash_value <= 0.0 )
            var_5 = 0.01;

        var_0 _meth_814C( %seo_pod_phase3_vm_root, var_5, var_4, 1 );
        wait(var_4);
    }
}
