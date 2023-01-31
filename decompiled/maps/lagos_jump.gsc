// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{

}

exo_jump_process()
{
    level.player endon( "exo_jump_process_end" );
    common_scripts\utility::flag_wait( "flag_setup_highway_vehicles" );
    waitframe();
    level.player _meth_82DD( "exo_jump_button", "+gostand" );
    thread exo_jump_button_listener();
    level.player.exo_jump_button_pressed = 0;
    level.jumping_rig = maps\_utility::spawn_anim_model( "player_arms", ( 0, 0, 0 ) );
    level.handplant_target = spawn( "script_origin", ( 0, 0, 0 ) );
    level.script_origin_target_array = getentarray( "jump_target", "targetname" );
    var_0 = 999999999;

    for ( var_1 = 0; var_1 < level.script_origin_target_array.size; var_1++ )
    {
        var_2 = distancesquared( level.script_origin_target_array[var_1].origin, level.player.origin );

        if ( var_0 > var_2 )
        {
            var_0 = var_2;
            level.jump_target = level.script_origin_target_array[var_1];
        }
    }

    level.player.jump_state = 1;

    for (;;)
    {
        waittillframeend;

        switch ( level.player.jump_state )
        {
            case 1:
                if ( level.player.exo_jump_button_pressed )
                    player_assisted_jump( level.script_origin_target_array );

                break;
            case 2:
                break;
            case 3:
                if ( level.player _meth_824C( "DPAD_UP" ) )
                {
                    player_unlock();
                    level.player.jump_state = 1;
                }
                else if ( level.player _meth_8341() && level.player.exo_jump_button_pressed )
                    player_assisted_jump( level.script_origin_target_array );

                break;
        }

        waitframe();
    }
}

exo_jump_button_listener()
{
    level.player endon( "exo_jump_process_end" );

    for (;;)
    {
        level.player waittill( "exo_jump_button" );
        var_0 = getgroundposition( level.player.origin, 16 );
        var_1 = abs( var_0[2] - level.player.origin[2] );

        if ( var_1 < 20 )
            level.player.exo_jump_button_pressed = 1;

        waitframe();
        level.player.exo_jump_button_pressed = 0;
    }
}

exo_jump_end()
{
    level.player notify( "exo_jump_process_end" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player maps\_utility::restore_players_weapons( "traffic_weapons" );
    level.player.jump_state = 1;

    if ( isdefined( level.jumping_rig ) )
        level.player _meth_804F();

    if ( isdefined( level.jumping_rig ) )
        level.jumping_rig delete();

    if ( isdefined( level.handplant_target ) )
        level.handplant_target delete();

    level.player _meth_849C( "exo_jump_button", "+gostand" );
    level.player.exo_jump_button_pressed = undefined;
}

player_exo_jump_hint( var_0 )
{
    for (;;)
    {
        var_1 = get_best_jump_target( var_0 );

        if ( isdefined( var_1 ) )
        {
            maps\_utility::display_hint_timeout( "player_exo_jump", 20 );
            break;
        }

        wait 0.1;
    }
}

player_assisted_jump( var_0 )
{
    var_1 = get_best_jump_target( var_0 );

    if ( isdefined( var_1 ) )
    {
        level.jump_target = var_1;
        var_2 = ( 0, 0, 0 );

        if ( isdefined( level.burke_bus_goal ) )
        {
            var_3 = 40;

            if ( _func_220( level.burke_bus_goal.origin, var_1.origin ) < var_3 * var_3 )
            {
                var_4 = vectornormalize( var_1.origin - level.burke_bus_goal.origin );
                var_2 = level.burke_bus_goal.origin + var_3 * var_4 - var_1.origin;
            }
        }

        var_5 = var_1.origin + var_2;
        var_6 = var_5 - level.player.origin;
        var_7 = distance2d( var_5, level.player.origin );
        level.player.jump_state = 2;
        level.player maps\_shg_utility::setup_player_for_scene();
        level.player maps\_utility::store_players_weapons( "traffic_weapons" );
        level.player _meth_8310();
        thread animate_script_origin( var_1, var_2, var_6, var_7, 1 );
        player_unlock();
    }
}

player_handplant()
{
    level.jumping_rig waittill( "notetrack_vm_exo_magnet_start" );
    maps\_anim::anim_set_rate_single( level.jumping_rig, level.jump_animstring, 0 );
    level.player.jump_state = 3;
    maps\_utility::display_hint_timeout( "player_exo_jump_release", 5 );
}

player_handplant_standalone()
{
    var_0 = level.handplant_target;
    level.jump_target = var_0;
    level.jumping_rig _meth_804C();
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player maps\_utility::store_players_weapons( "traffic_weapons" );
    level.player _meth_8310();
    match_angles_pos( level.jumping_rig, level.player );
    match_angles_pos( var_0, level.jumping_rig );
    level.jumping_rig _meth_804D( var_0 );
    level.player _meth_8080( level.jumping_rig, "tag_player", 1, 0.1, 0.1 );
    level.jump_animstring = "bus_jump_vm_handplant";
    level.jumping_rig thread maps\_anim::anim_single_solo( level.jumping_rig, level.jump_animstring );
    thread player_handplant();
}

player_link_to( var_0, var_1 )
{
    level.player endon( "exo_jump_process_end" );
    level.player endon( "exo_jump_stop_view_clamp" );
    level.player endon( "death" );
    var_2 = 1;

    switch ( var_0 )
    {
        case "bus_jump_vm_a":
            var_2 = 0.75 / var_1;
            break;
        case "bus_jump_vm_b":
            var_2 = 0.9 / var_1;
            break;
        case "bus_jump_vm_c":
            var_2 = 1.1 / var_1;
            break;
        default:
            break;
    }

    level.player _meth_8080( level.jumping_rig, "tag_player", var_2 );
    level.jumping_rig hide();
    wait(var_2);
    level.jumping_rig show();
    level waittill( "bus_jump_player_landed" );
    wait 1;
    level.player _meth_807D( level.jumping_rig, "tag_player" );
    level.player _meth_80A2( 1, 0.2, 0.2, 70, 35, 70, 10 );
}

player_unlock()
{
    maps\_anim::anim_set_rate_single( level.jumping_rig, level.jump_animstring, 1 );
    level.jumping_rig waittill( "notetrack_vm_exo_magnet_end" );
    level.player _meth_804F();
    level.player _meth_807D( level.jump_target, "" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player maps\_utility::restore_players_weapons( "traffic_weapons" );
    wait 0.5;
    level.player _meth_804F();
    level.player.jump_state = 1;
}

get_stick_dir_in_world_coor()
{
    var_0 = level.player _meth_82F3();
    var_0 = ( var_0[0], var_0[1] * -1, 0.0 );
    var_1 = rotatevector( var_0, level.player.angles );
    var_1 = vectornormalize( var_1 );
    return var_1;
}

get_best_jump_target( var_0 )
{
    if ( !isdefined( level.const_cosine_stick_angle ) )
        level.const_cosine_stick_angle = cos( 30.0 );

    if ( !isdefined( level.const_cosine_bunched_angle ) )
        level.const_cosine_bunched_angle = cos( 2.0 );

    var_1 = level.player _meth_82F3();
    var_2 = vectortoyaw( var_1 );
    var_3 = 45.0;

    if ( common_scripts\utility::flag( "flag_bus_traverse_4" ) )
        var_3 = 60;

    if ( var_3 < var_2 && var_2 < 360.0 - var_3 )
        return undefined;

    var_4 = get_stick_dir_in_world_coor();

    if ( distance2d( var_4, ( 0, 0, 0 ) ) < 0.1 )
        return undefined;

    var_5 = 0;
    var_6 = -1;
    var_7 = 99999;

    for ( var_8 = 0; var_8 < var_0.size; var_8++ )
    {
        var_9 = var_0[var_8] _meth_83EC();
        var_10 = level.jump_target _meth_83EC();

        if ( isdefined( var_9 ) && isdefined( var_10 ) && var_9 == var_10 )
            continue;

        if ( level.player.origin[2] - var_0[var_8].origin[2] < -120 )
            continue;

        var_11 = _func_220( var_0[var_8].origin, level.player.origin );

        if ( var_11 > 360000 || var_11 < 100 )
            continue;

        var_12 = sqrt( var_11 );
        var_13 = var_0[var_8].origin - level.player.origin;
        var_14 = var_13 * 1.0 / var_12;
        var_15 = vectordot( var_4, var_14 );

        if ( var_6 != -1 && abs( var_5 - var_15 ) < abs( var_5 - level.const_cosine_bunched_angle ) && abs( var_12 - var_7 ) < 50 )
        {
            if ( var_1[0] < 0.5 && var_12 < var_7 || var_1[0] > 0.5 && var_12 > var_7 )
            {
                var_5 = var_15;
                var_6 = var_8;
                var_7 = var_12;
            }
            else
            {

            }

            continue;
        }

        if ( var_15 > var_5 )
        {
            var_5 = var_15;
            var_6 = var_8;
            var_7 = var_12;
        }
    }

    if ( var_5 < level.const_cosine_stick_angle || var_6 == -1 )
        return undefined;

    return var_0[var_6];
}

orient_facing( var_0, var_1 )
{
    var_2 = var_1.origin - var_0.origin;
    var_3 = vectortoangles( var_2 );
    var_0.angles = var_3;
}

match_angles_pos( var_0, var_1 )
{
    var_0.angles = var_1.angles;
    var_0.origin = var_1.origin;
}

animate_script_origin( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "exo_jump_process_end" );
    level.jumping_rig.origin = var_0.origin;
    var_5 = vectortoangles( var_2 );
    var_0 _meth_804D( var_0.linkparent_ent, var_0.linkparent_tag, var_1, var_5 - var_0.linkparent_ent.angles );
    level.jumping_rig _meth_804D( var_0 );
    level.jump_animstring = "";

    if ( var_3 < 118.5 )
        level.jump_animstring = "bus_jump_vm_a";
    else if ( var_3 < 240.93 )
        level.jump_animstring = "bus_jump_vm_b";
    else
        level.jump_animstring = "bus_jump_vm_c";

    var_6 = level.player _meth_83ED();

    if ( isdefined( var_6 ) && isdefined( var_6.targetname ) && var_6.targetname == "sb_bus_traverse_4" )
        common_scripts\utility::flag_set( "flag_bus_traverse_5_start_takedown" );

    var_7 = 1.2;

    if ( var_4 )
        thread player_link_to( level.jump_animstring, var_7 );

    var_0 maps\_utility::delaythread( 0.05, maps\_anim::anim_set_rate_single, level.jumping_rig, level.jump_animstring, var_7 );
    var_0 maps\_anim::anim_single_solo( level.jumping_rig, level.jump_animstring );

    if ( isdefined( level.jumping_rig ) )
        level.jumping_rig hide();
}

notetrack_vm_exo_magnet_start( var_0 )
{

}

notetrack_vm_exo_magnet_end( var_0 )
{
    if ( isdefined( level.jumping_rig ) )
        level.jumping_rig notify( "notetrack_vm_exo_magnet_end" );
}

spawn_vehicle_from_targetname_and_setup_jump_targets( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( var_0 );
    var_6 = "";
    var_5.script_origin_roof = [];

    if ( !isdefined( var_1 ) )
        var_1 = 4;

    var_7 = 0;

    for ( var_8 = 0; var_8 < var_1; var_8++ )
    {
        if ( var_8 == 0 )
            var_6 = "tag_roof_a";
        else if ( var_8 == 1 )
            var_6 = "tag_roof_b";
        else if ( var_8 == 2 )
            var_6 = "tag_roof_c";
        else if ( var_8 == 3 )
            var_6 = "tag_roof_d";

        if ( isdefined( var_2 ) && var_2 == var_6 )
            continue;
        else if ( isdefined( var_3 ) && var_3 == var_6 )
            continue;
        else if ( isdefined( var_4 ) && var_4 == var_6 )
            continue;

        if ( isdefined( var_5 gettagorigin( var_6 ) ) )
        {
            var_5.script_origin_roof[var_7] = spawn( "script_origin", ( 0, 0, 0 ) );
            var_5.script_origin_roof[var_7].origin = var_5 gettagorigin( var_6 );
            var_5.script_origin_roof[var_7].targetname = "jump_target";
            var_5.script_origin_roof[var_7] _meth_804D( var_5, var_6 );
            var_5.script_origin_roof[var_7].linkparent_tag = var_6;
            var_5.script_origin_roof[var_7].linkparent_ent = var_5;
            var_7++;
        }
    }

    var_5 thread test();
    return var_5;
}

test()
{
    for (;;)
        waitframe();
}
