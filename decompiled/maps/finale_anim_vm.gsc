// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

anim_single_solo_vm( var_0, var_1, var_2 )
{
    var_0 notify( "kill_duplicate_anim_single_solo_vm" );
    var_0 endon( "kill_duplicate_anim_single_solo_vm" );
    var_0 endon( "die" );

    if ( !isdefined( var_2 ) )
        var_2 = "stop_nonloop";

    if ( !assert_existance_of_anim_vm( var_1 ) )
        return;

    var_3 = getanimlength( var_0 getanim_vm( var_1 ) ) - 0.05;
    var_4 = gettime() + var_3 * 1000;
    thread anim_single_solo_internal_vm( var_0, var_1, var_2 );
    var_0 common_scripts\utility::waittill_any_timeout( var_3, var_2 );

    if ( gettime() < var_4 - 50 )
        var_0 _meth_84B6( 1.0 );
}

anim_single_solo_internal_vm( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "stop_nonloop";

    var_0 endon( "kill_duplicate_anim_single_solo_vm" );
    var_0 endon( var_2 );
    var_3 = getanimlength( var_0 getanim_vm( var_1 ) );
    var_0 _meth_84B5( getanim_vm_index( var_1 ) );
    wait(var_3 - 0.05);
}

anim_loop_solo_vm( var_0, var_1, var_2, var_3 )
{
    var_0 notify( "kill_duplicate_anim_loop_solo_vm" );
    var_0 endon( "kill_duplicate_anim_loop_solo_vm" );

    if ( !isdefined( var_2 ) )
        var_2 = "stop_loop";

    if ( !assert_existance_of_anim_vm( var_1 ) )
        return;

    thread hack_fake_loop_because_you_cant_play_looping_vm_anims( var_0, var_1, var_2 );

    for (;;)
    {
        if ( isdefined( var_3 ) )
            var_0 common_scripts\utility::waittill_any_timeout( var_3, var_2 );
        else
            var_0 waittill( var_2 );

        if ( !isdefined( var_0.viewmodel_hidden ) || !var_0.viewmodel_hidden )
            var_0 _meth_84B6( 1.0 );

        break;
    }
}

getanim_vm( var_0 )
{
    return level.scr_anim_vm[var_0];
}

getanim_vm_index( var_0 )
{
    return level.scr_anim_vm_index[var_0];
}

hack_fake_loop_because_you_cant_play_looping_vm_anims( var_0, var_1, var_2 )
{
    var_0 endon( "kill_duplicate_anim_loop_solo_vm" );
    var_0 endon( var_2 );
    var_3 = getanimlength( var_0 getanim_vm( var_1 ) );

    for (;;)
    {
        var_0 _meth_84B5( getanim_vm_index( var_1 ) );
        wait(var_3 - 0.05);
        var_0 _meth_84B6( 1.0 );
    }
}

assert_existance_of_anim_vm( var_0 )
{
    if ( !isdefined( level.scr_anim_vm_index ) || !isdefined( level.scr_anim_vm_index[var_0] ) )
        return 0;

    return 1;
}
