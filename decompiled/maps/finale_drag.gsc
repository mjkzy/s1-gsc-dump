// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

get_starting_offset_from_org( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    var_3 = spawn_new_ally( var_0 );
    var_2 maps\_anim::anim_first_frame_solo( var_3, "drag_putdown" );
    var_4 = var_3.origin - var_2.origin;
    var_5 = var_3.angles - var_2.angles;
    var_6 = rotatevector( var_4, -1.0 * var_5 );
    var_3 delete();
    return [ var_6, var_5 ];
}

drag_player_from_current_position( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = undefined;

    if ( var_5 )
        var_6 = "drag_pickup02";
    else
        var_6 = var_2;

    [var_8, var_9] = get_starting_offset_from_org( var_0, var_6 );
    var_10 = spawnstruct();
    var_10.origin = var_0.origin - var_8;
    var_10.angles = var_0.angles - var_9;
    return drag_player_internal( var_10, var_0, var_1, var_2, undefined, var_3, var_4, var_5, "drag_pickup02" );
}

#using_animtree("generic_human");

spawn_new_ally( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 _meth_80B1( var_0.model );
    var_1.angles = var_0.angles;
    var_1.animname = "gideon";
    var_1 _meth_8115( #animtree );
    return var_1;
}

drag_player_from_start_to_end( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = spawnstruct();
    var_8.origin = var_0.origin;
    var_9 = var_1.origin - var_0.origin;
    var_9 = ( var_9[0], var_9[1], var_9[2] );
    var_10 = vectortoangles( var_9 );
    var_8.angles = ( 0, var_10[1] + 90.0, 0 );
    return drag_player_internal( var_8, var_2, var_3, var_4, var_1.origin, var_5, var_6, var_7 );
}

drag_player_until_time_or_pos( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    return drag_player_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
}

drag_player_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    while ( isdefined( var_2.wait_ref_count ) && var_2.wait_ref_count > 0 )
        waitframe();

    if ( !isdefined( var_7 ) )
        var_7 = 0;

    if ( !isdefined( var_6 ) )
        var_6 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = "drag_run01";

    if ( !isdefined( var_8 ) )
        var_8 = "drag_pickup01";

    var_0 maps\_anim::anim_first_frame_solo( var_1, "drag_putdown" );
    var_9 = var_1.origin;

    if ( !isdefined( var_2 ) )
        var_2 = maps\_utility::spawn_anim_model( "world_body_damaged" );

    level.player _meth_807D( var_2, "TAG_PLAYER", 1.0, 0, 0, 0, 0, 1, 1 );
    level.player common_scripts\utility::delaycall( 1, ::_meth_807D, var_2, "TAG_PLAYER", 1.0, 30, 30, 30, 10, 1, 1 );
    level.player maps\_shg_utility::setup_player_for_scene();
    var_10 = [ var_1, var_2 ];

    if ( var_7 )
        var_0 maps\_anim::anim_single( var_10, var_8 );

    if ( var_3 == "none" )
        return finish_drag_player_internal( var_0, var_9, var_1, var_2, var_10, var_6 );

    var_0 thread maps\_anim::anim_single( var_10, var_3 );
    waituntil_stop_time_or_posreached( var_4, var_0, var_1, var_3 );

    if ( isdefined( var_5 ) && var_5 != 0 )
    {
        if ( !isdefined( var_2.wait_ref_count ) )
            var_2.wait_ref_count = 0;

        var_2.wait_ref_count++;
        thread finish_drag_player_internal_delayed( var_5, var_0, var_9, var_1, var_2, var_10, var_6 );
        return var_2;
    }
    else
    {
        finish_drag_player_internal( var_0, var_9, var_1, var_2, var_10, var_6 );
        return var_2;
    }
}

finish_drag_player_internal_delayed( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_4 endon( "death" );
    wait(var_0);
    finish_drag_player_internal( var_1, var_2, var_3, var_4, var_5, var_6 );
    var_4.wait_ref_count--;
}

finish_drag_player_internal( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( var_5 )
    {
        var_6 = var_1 - var_2.origin;
        var_7 = var_0.origin - var_6;
        var_8 = spawn( "script_origin", var_7 );
        var_8.angles = var_0.angles;
        var_0 = var_8;
        var_0 maps\_anim::anim_first_frame( var_4, "drag_putdown" );
        var_0 maps\_anim::anim_single( var_4, "drag_putdown" );
        var_8 delete();
    }
    else
    {
        foreach ( var_10 in var_4 )
        {
            if ( isdefined( var_10 ) )
                var_10 maps\_utility::anim_stopanimscripted();
        }
    }

    if ( isdefined( var_3 ) )
        level.player _meth_807D( var_3, "TAG_PLAYER", 1.0, 30, 30, 30, 5, 1, 0 );

    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player _meth_831F();
    return var_3;
}

waituntil_stop_time_or_posreached( var_0, var_1, var_2, var_3 )
{
    var_2 endon( "death" );

    if ( !isdefined( var_0 ) )
    {
        if ( isdefined( var_1.target ) )
        {
            var_4 = maps\_utility::getent_or_struct( var_1.target, "targetname" );
            waittill_marker_passed( var_4.origin, var_1, var_2, var_3 );
        }
        else
        {
            var_0 = getanimlength( var_2 maps\_utility::getanim( var_3 ) );
            wait(var_0);
        }
    }
    else if ( _func_2BA( var_0 ) )
        wait(var_0);
    else
        waittill_marker_passed( var_0, var_1, var_2, var_3 );
}

waittill_marker_passed( var_0, var_1, var_2, var_3 )
{
    var_2 endon( "death" );
    waitframe();
    var_4 = var_0 - var_1.origin;
    var_4 = ( var_4[0], var_4[1], 0.0 );
    var_5 = vectornormalize( var_4 );
    var_6 = length2dsquared( var_4 );
    var_7 = 0;
    var_8 = var_2.origin;

    for (;;)
    {
        var_9 = var_2.origin - var_1.origin;
        var_10 = vectordot( var_9, var_5 );

        if ( squared( var_10 ) > var_6 )
            break;

        if ( var_2.origin == var_8 )
        {
            var_7++;

            if ( var_7 > 100 )
                break;
        }

        var_8 = var_2.origin;
        waitframe();
    }
}

notetrack_drag_cover_pickup( var_0 )
{
    var_0.pickup_allowed = 1;
}

notetrack_drag_cover_dont_pickup( var_0 )
{
    var_0.pickup_allowed = 0;
}

shooting_head_sway()
{
    level.player endon( "death" );
    level.player endon( "end_head_sway" );

    for (;;)
    {
        _func_234( level.player.origin, 2, 3, 1, 2, 0.2, 0.2, 0, 0.3, 0.375, 0.225 );
        wait 1.0;
    }
}
