// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("player");

set_cam_shake( var_0 )
{
    var_1 = var_0 / 40;

    if ( var_1 < 0.001 )
        var_1 = 0.001;

    var_1 *= 0.7;
    var_2 = self _meth_84F4();

    if ( var_2.size < 4 )
        self _meth_8145( %fin_silo_exhaust_hatch_breach_camshake_vm, 1.0, 0, 3.0 );

    self _meth_814C( %fin_silo_exhaust_hatch_breach_camshake_root, var_1, 0.05 );
}

hatch_open_se_update_rumble_intensity( var_0 )
{
    var_1 = 0.05 + var_0 / 100;
    maps\finale_utility::set_level_player_rumble_ent_intensity( var_1 );
}

button_pressed_think( var_0, var_1, var_2 )
{
    level.player.button_pressed = 0;
    level.player _meth_82DD( "hatch_action", var_0 );

    if ( isdefined( var_2 ) )
        level.player _meth_82DD( "hatch_action", var_2 );

    while ( var_1.state != 4 )
    {
        level.player waittill( "hatch_action" );
        level.player.button_pressed = 1;
        waitframe();
        level.player.button_pressed = 0;
    }

    level.player _meth_849C( "hatch_action", var_0 );

    if ( isdefined( var_2 ) )
        level.player _meth_849C( "hatch_action", var_2 );
}

hatch_button_gameplay( var_0, var_1, var_2, var_3 )
{
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = "+usereload";
    var_9 = "+activate";
    var_0 thread maps\_anim::anim_loop( var_1, "exhaust_hatch_vm_idle_noinput", "ender_player" );
    var_0.state = 0;
    level.player thread maps\_shg_utility::button_mash_dynamic_hint( &"FINALE_PISTON_BREAK_BUTTON", var_8, "notetrack_break_bar", var_9 );
    var_3 thread maps\_shg_utility::hint_button_create_flashing( "piston5_r", "x", "notetrack_break_bar", ( 0, -12, 12 ) );
    level.player thread button_pressed_think( var_8, var_0, var_9 );
    var_2 set_cam_shake( 0.0 );

    while ( var_4 < 40 )
    {
        waittillframeend;

        if ( level.player.button_pressed )
            var_7++;
        else
            var_7 = 0;

        if ( var_7 > 0 && var_7 < 30 )
        {
            if ( var_4 < 40 )
                var_4 += 1;

            var_6 = 0;
            var_7++;
        }
        else
        {
            var_6++;

            if ( var_6 >= 6 && var_4 > 0 )
                var_4 -= 1;
        }

        var_2 set_cam_shake( var_4 );
        hatch_open_se_update_rumble_intensity( var_4 );

        switch ( var_0.state )
        {
            case 0:
                if ( var_4 > 0 )
                    change_state( var_0, 1, var_2 );

                break;
            case 1:
                if ( !isdefined( var_0.wait_for_anim ) )
                {
                    if ( var_4 > var_5 )
                        change_state( var_0, 2, var_2 );
                    else
                        change_state( var_0, 3, var_2 );
                }

                break;
            case 2:
                if ( var_4 < var_5 )
                    change_state( var_0, 3, var_2 );
                else if ( var_4 == 40 )
                    thread change_state( var_0, 4, var_2 );

                break;
            case 3:
                if ( !isdefined( var_0.wait_for_anim ) )
                {
                    if ( var_4 > var_5 )
                        thread change_state( var_0, 1, var_2 );
                    else
                        thread change_state( var_0, 0, var_2 );
                }

                break;
        }

        var_5 = var_4;
        waitframe();
    }

    thread post_win_camshake( var_0, var_2, var_4, gettime() + 3000 );
    thread post_win_disable_rumbles();
}

post_win_camshake( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        if ( isdefined( var_1.stop_camshake ) && var_1.stop_camshake )
            break;

        if ( gettime() > var_3 )
            break;

        var_1 set_cam_shake( var_2 );
        waitframe();
    }

    var_1 _meth_8145( %fin_silo_exhaust_hatch_breach_camshake_vm, 0, 0.2, 3.0 );
    var_1 _meth_814C( %fin_silo_exhaust_hatch_breach_camshake_root, 0, 0.2 );
}

post_win_disable_rumbles()
{
    wait 2;
    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.0 );
}

notetrack_break_bar( var_0 )
{
    level.player notify( "notetrack_break_bar" );
    var_0.stop_camshake = 1;
}

change_state( var_0, var_1, var_2 )
{
    var_3 = var_0.state;
    var_0.state = var_1;

    if ( var_1 != var_3 )
    {
        var_0 notify( "ender_player" );

        if ( var_0.state == 0 )
            var_0 thread maps\_anim::anim_loop_solo( var_2, "exhaust_hatch_vm_idle_noinput", "ender_player" );
        else if ( var_0.state == 1 )
        {
            var_0.wait_for_anim = 1;
            var_0 thread anim_single_solo_custom( var_0, var_2, "exhaust_hatch_vm_noinput_to_input" );
        }
        else if ( var_0.state == 2 )
            var_0 thread maps\_anim::anim_loop_solo( var_2, "exhaust_hatch_vm_idle_input", "ender_player" );
        else if ( var_0.state == 3 )
        {
            var_0.wait_for_anim = 1;
            var_0 thread anim_single_solo_custom( var_0, var_2, "exhaust_hatch_vm_input_to_noinput" );
        }
    }
}

anim_single_solo_custom( var_0, var_1, var_2 )
{
    var_0.wait_for_anim = 1;
    var_0 notify( "ender" );
    var_0 maps\_anim::anim_single_solo( var_1, var_2 );
    var_0.wait_for_anim = undefined;
}

do_shaft_gameplay_setup( var_0 )
{
    level.drop_locator = maps\_utility::spawn_anim_model( "locator" );
    level.drop_locator.anim_speed = calculate_locator_anim_speed( var_0 );
    level.drop_locator.drop_started_status = 0;
    var_0 maps\_anim::anim_first_frame_solo( level.drop_locator, "shaft_drop" );
}

setup_mech_for_drop( var_0 )
{
    var_1 = level.player.player_rig;

    if ( !isdefined( level.player.player_rig ) )
    {
        var_1 = maps\_utility::spawn_anim_model( "world_body_mech", level.player.origin + ( 0, 0, 30 ), level.player.angles );
        maps\_playermech_code::hide_mech_glass_static_overlay( var_1 );
    }

    if ( isdefined( var_0 ) && var_0 )
    {
        if ( 0 )
        {
            var_2 = -38.6;
            var_3 = -10.6;
            var_4 = -105.8;
            var_1 _meth_8401( level.player, "TAG_ORIGIN", ( var_4, var_3, var_2 ), ( 0, 0, 0 ), 1, 0, 0, 1 );
            level.player _meth_8482();
        }
        else
        {
            if ( !isdefined( level.player _meth_83EC() ) || !( level.player _meth_83EC() == var_1 ) )
            {
                level.player _meth_8080( var_1, "TAG_PLAYER", 1.0 );
                level.player maps\_playermech_code::mech_setup_player_for_scene();
            }

            var_1 _meth_804D( level.drop_locator, "TAG_ORIGIN_ANIMATED" );
        }
    }

    return var_1;
}

set_player_link_angles_tag_relative( var_0, var_1 )
{
    level.ground_ref = spawn( "script_origin", var_0.origin );
    level.ground_ref.angles = var_0 gettagangles( "TAG_PLAYER" );
    level.player _meth_8091( level.ground_ref );
}

calculate_locator_anim_speed( var_0 )
{
    var_1 = maps\_utility::spawn_anim_model( "locator" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "shaft_drop" );
    waitframe();
    maps\_anim::anim_set_time( [ var_1 ], "shaft_drop", 1.0 );
    var_2 = var_1 gettagorigin( "TAG_ORIGIN_ANIMATED" );
    var_3 = distance( var_1.origin, var_2 );
    var_4 = getanimlength( var_1 maps\_utility::getanim( "shaft_drop" ) );
    var_1 delete();
    return var_3 / var_4;
}

speed_to_anim_rate( var_0 )
{
    var_1 = var_0 / level.drop_locator.anim_speed;
    return var_1;
}

anim_rate_to_speed( var_0 )
{
    var_1 = var_0 * level.drop_locator.anim_speed;
    return var_1;
}

rigsetvelocity( var_0, var_1 )
{
    if ( 0 )
    {
        self _meth_82F1( ( 0.0, 0.0, var_0 ) );
        return;
    }

    if ( level.drop_locator.drop_started_status == 0 )
        level.drop_locator.drop_started_status = 1;

    level.drop_locator.speed = var_0;

    if ( !isdefined( var_1 ) )
        var_1 = 0.05;

    var_2 = speed_to_anim_rate( -1 * var_0 );
    level.drop_locator _meth_8111( "single anim", level.drop_locator maps\_utility::getanim( "shaft_drop" ), 1, var_1, var_2 );
}

riggetvelocity()
{
    if ( 0 )
        return self getvelocity()[2];

    return level.drop_locator.speed;
}

riggetgravity()
{
    if ( 0 )
        return level.player getgravity();

    return level.drop_locator.gravity;
}

rigsetgravity( var_0 )
{
    if ( 0 )
    {
        self _meth_84CB( int( var_0 ) );
        return;
    }

    level.drop_locator.gravity = var_0;
}

rigprocessvelocity()
{
    if ( level.drop_locator.drop_started_status == 0 )
        return;

    var_0 = 0.05;
    var_1 = level.drop_locator.speed + -1 * level.drop_locator.gravity * var_0;

    if ( -1 * var_1 < 0.0 )
        var_1 = 0;

    var_2 = speed_to_anim_rate( -1 * var_1 );

    if ( level.drop_locator.drop_started_status == 2 )
        level.drop_locator _meth_83C7( level.drop_locator maps\_utility::getanim( "shaft_drop" ), var_2 );

    level.drop_locator.drop_started_status = 2;
    wait(var_0);
    level.drop_locator.speed = var_1;
}

set_cam_shake_drop( var_0 )
{
    switch ( var_0 )
    {
        case "shaft_both_hands":
        case "shaft_right_hand_to_both":
        case "shaft_left_hand_to_both":
        case "shaft_no_hands_to_both":
            self _meth_8145( %fin_shaft_fall_idle_both_hands_mech_cam_vm, 1.0, 0, 1.0 );
            self _meth_814C( %fin_shaft_fall_idle_both_hands_mech_cam_root, 1.0, 0.05 );
            break;
        case "shaft_left_hand":
        case "shaft_right_hand_to_left":
        case "shaft_no_hands_to_left":
        case "shaft_both_hands_to_left":
            self _meth_8145( %fin_shaft_fall_idle_left_hand_mech_cam_vm, 1.0, 0, 1.0 );
            self _meth_814C( %fin_shaft_fall_idle_left_hand_mech_cam_root, 1.0, 0.05 );
            break;
        case "shaft_right_hand":
        case "shaft_left_hand_to_right":
        case "shaft_no_hands_to_right":
        case "shaft_both_hands_to_right":
            self _meth_8145( %fin_shaft_fall_idle_right_hand_mech_cam_vm, 1.0, 0, 1.0 );
            self _meth_814C( %fin_shaft_fall_idle_right_hand_mech_cam_root, 1.0, 0.05 );
            break;
        case "shaft_no_hands":
        case "shaft_right_hand_to_no":
        case "shaft_left_hand_to_no":
        case "shaft_both_hands_to_no":
            self _meth_8145( %fin_shaft_fall_idle_no_hands_mech_cam_vm, 1.0, 0, 1.0 );
            self _meth_814C( %fin_shaft_fall_idle_no_hands_mech_cam_root, 1.0, 0.05 );
            break;
    }
}

store_speed( var_0 )
{
    var_1 = var_0.origin;

    while ( !common_scripts\utility::flag( "flag_player_exhaust_corridor" ) )
    {
        var_2 = var_0 gettagorigin( "TAG_PLAYER" );
        var_3 = ( var_2 - var_1 ) / 0.05;
        var_0.speed = var_3;
        var_1 = var_2;
        waitframe();
    }
}

do_shaft_gameplay()
{
    var_0 = undefined;
    var_1 = 0;
    var_2 = undefined;
    var_3 = "none";
    var_4 = "none";
    var_5 = 400;
    var_6 = maps\_utility::getent_or_struct( "org_shaft_drop_controls_start", "targetname" );
    var_7 = maps\_utility::getent_or_struct( "org_shaft_drop_controls_end", "targetname" );
    level.player.hint_allow_hide_time = gettime() + 2000;
    var_8 = _func_0DD( "+toggleads_throw" );

    if ( level.player common_scripts\utility::is_player_gamepad_enabled() || var_8["count"] == 0 )
        thread maps\_utility::hintdisplaymintimehandler( "player_input_shaft_buttons", 30 );
    else
        thread maps\_utility::hintdisplaymintimehandler( "player_input_shaft_buttons_pc_alt", 30 );

    var_9 = setup_mech_for_drop( 1 );
    var_10 = 0;

    if ( isdefined( var_9.speed ) )
        var_10 = var_9.speed[2];

    level.player rigsetvelocity( var_10, 0.0 );
    level.player rigsetgravity( level.player getgravity() );
    var_11 = var_10;
    var_12 = undefined;
    var_9.anim_state = "";
    var_9.wait_for_anim = 0;
    thread process_animation( var_9, level.drop_locator );
    thread process_fov( var_9 );
    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.1 );
    soundscripts\_snd::snd_message( "shaft_descent_start" );

    while ( level.player.origin[2] > var_7.origin[2] + 2 )
    {
        var_10 = level.player riggetvelocity();
        soundscripts\_snd::snd_message( "shaft_descent_speed_update", var_10 );
        var_13 = level.player attackbuttonpressed();
        var_14 = level.player adsbuttonpressed( 1 );

        if ( var_13 && var_14 )
            var_9.anim_state = "shaft_both_hands";
        else if ( var_13 )
            var_9.anim_state = "shaft_right_hand";
        else if ( var_14 )
            var_9.anim_state = "shaft_left_hand";
        else
            var_9.anim_state = "shaft_no_hands";

        if ( var_9.anim_state != var_4 )
        {
            soundscripts\_snd::snd_message( "shaft_descent_state_change", var_4, var_9.anim_state );

            switch ( var_9.anim_state )
            {
                case "shaft_both_hands":
                case "shaft_right_hand_to_both":
                case "shaft_left_hand_to_both":
                case "shaft_no_hands_to_both":
                    var_1 = -400;

                    if ( isdefined( var_1 ) && var_10 < var_1 )
                        var_0 = -400;
                    else
                        var_0 = var_5 * 0.5;

                    var_2 = "less";
                    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.8 );
                    break;
                case "shaft_right_hand":
                case "shaft_left_hand_to_right":
                case "shaft_no_hands_to_right":
                case "shaft_both_hands_to_right":
                    var_1 = -700;

                    if ( isdefined( var_1 ) && var_10 < var_1 )
                        var_0 = -200;
                    else
                        var_0 = var_5 * 0.5;

                    var_2 = "more";
                    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.4 );
                    break;
                case "shaft_left_hand":
                case "shaft_right_hand_to_left":
                case "shaft_no_hands_to_left":
                case "shaft_both_hands_to_left":
                    var_1 = -700;

                    if ( isdefined( var_1 ) && var_10 < var_1 )
                        var_0 = -200;
                    else
                        var_0 = var_5 * 0.5;

                    var_2 = "more";
                    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.4 );
                    break;
                case "shaft_no_hands":
                case "shaft_right_hand_to_no":
                case "shaft_left_hand_to_no":
                case "shaft_both_hands_to_no":
                    var_1 = -1200;
                    var_0 = var_5;
                    var_2 = "none";
                    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.1 );
                    break;
            }

            if ( !isdefined( var_1 ) )
                var_3 = "speedup";
            else if ( var_1 > var_10 )
                var_3 = "slowdown";
            else if ( var_1 < var_10 )
                var_3 = "speedup";
        }

        if ( var_3 != "constantspeed" && level.player riggetgravity() != var_0 )
            level.player rigsetgravity( var_0 );

        if ( isdefined( var_1 ) )
        {
            if ( is_speed_target_just_reached( var_3, var_11, var_10, var_1 ) )
            {
                level.player rigsetvelocity( var_1 );
                level.player rigsetgravity( 0.0 );
                var_3 = "constantspeed";

                if ( var_10 == 0 )
                    var_2 = "strong";
            }
            else if ( var_10 == 0 )
                var_2 = "none";
        }

        var_11 = var_10;
        var_4 = var_9.anim_state;
        level.player rigprocessvelocity();
    }

    maps\finale_utility::set_level_player_rumble_ent_intensity( 0.0 );
    soundscripts\_snd::snd_message( "shaft_descent_end" );
    level.player notify( "free_fall_done" );

    if ( 0 )
        level.player _meth_84CC();

    var_9.anim_state = "drop_finished";
    var_9 _meth_804F();
    level notify( "kill_drop_fx_thread" );
    var_15 = level.player.health;
    var_16 = level.player riggetvelocity();
    var_17 = getgroundposition( level.player.origin, 5 );
    var_18 = animscripts\utility::get_trajectory_v_given_x( level.player.origin[2], var_17[2], var_16, -1 * level.player getgravity() );

    if ( var_18 < -1200 )
        var_18 = -1200;

    var_19 = maps\_player_land_assist::do_custom_fall_damage( var_18, 0 );

    if ( var_19 > 50.0 )
        var_9 thread maps\_playermech_code::scripted_screen_flicker_loop( 5.0 );

    if ( var_11 <= -1200 || var_19 >= var_15 )
    {
        level.player.player_failed_drop = 1;
        level.player maps\_playermech_code::mech_setup_player_for_gameplay();
        var_9 hide();
        var_9 _meth_804F();
        level.player _meth_804F();
        level.player _meth_82F1( ( 0, 0, level.drop_locator.speed ) );
        var_20 = level.player _meth_8051( 999999, level.player.origin );
        maps\_utility::missionfailedwrapper();
        wait 1111;
    }
    else
        common_scripts\utility::flag_set( "flag_player_exhaust_corridor" );
}

is_speed_target_just_reached( var_0, var_1, var_2, var_3 )
{
    if ( var_1 != var_2 )
    {
        if ( var_0 == "slowdown" && var_2 >= var_3 - 10 )
            return 1;

        if ( var_0 == "speedup" && var_2 <= var_3 + 10 )
            return 1;
    }

    return 0;
}

do_shake( var_0 )
{
    level.player endon( "free_fall_done" );
    level.player endon( "death" );

    if ( isdefined( level.player.shake_in_progress ) && level.player.shake_in_progress == var_0 )
        return;

    if ( var_0 == "none" )
        return;

    level.player.shake_in_progress = var_0;
    var_1 = level.player getgravity();

    if ( var_0 == "less" )
    {
        var_2 = 0.4 + randomfloat( 100 ) * 0.01 * 0.25;
        var_3 = 0.2 + randomfloat( 100 ) * 0.01 * 0.5;
        var_2 *= 0.5;
        earthquake( var_2, var_3, level.player.origin, 100 );
        wait(var_3 * 0.5);
    }
    else if ( var_0 == "more" )
    {
        var_2 = 0.4 + randomfloat( 100 ) * 0.01 * 0.25;
        var_3 = 0.2 + randomfloat( 100 ) * 0.01 * 0.5;
        earthquake( var_2, var_3, level.player.origin, 100 );
        wait(var_3 * 0.5);
    }
    else if ( var_0 == "strong" )
    {
        var_2 = 0.4 + randomfloat( 100 ) * 0.01 * 0.25;
        var_3 = 0.2 + randomfloat( 100 ) * 0.01 * 0.5;
        var_2 *= 1.5;
        earthquake( var_2, var_3, level.player.origin, 100 );
        wait(var_3 * 0.5);
    }

    level.player.shake_in_progress = undefined;
}

process_fov( var_0 )
{
    var_1 = getdvarint( "cg_fov" );
    var_2 = 1.0;
    var_3 = 1.25;
    var_4 = 0.0;
    var_5 = var_2;
    var_6 = ( var_3 - var_5 ) / squared( -1200 - var_4 );

    while ( isdefined( var_0 ) && var_0.anim_state != "drop_finished" )
    {
        var_7 = level.player riggetvelocity();
        var_8 = var_6 * squared( var_7 - var_4 ) + var_5;
        level.player _meth_8032( var_8, 0.05 );
        waitframe();
    }

    level.player _meth_8032( 1.0, 1.0 );
}

get_fx_count_for_speed( var_0 )
{
    for ( var_1 = self.drop_thresholds.size - 1; var_1 >= 0; var_1-- )
    {
        if ( var_0 < self.drop_thresholds[var_1] )
            return self.drop_fx_count[var_1];
    }

    return 1;
}

drop_fx_thread( var_0, var_1 )
{
    level notify( "kill_drop_fx_thread" );
    level endon( "kill_drop_fx_thread" );

    for (;;)
    {
        waitframe();
        waittillframeend;
        waittillframeend;
        waittillframeend;

        if ( var_1.fx_current < var_1.fx_goal_count )
        {
            var_1.fx_current++;
            playfx_fordrop( var_0, var_1 );
            continue;
        }

        if ( var_1.fx_current > var_1.fx_goal_count )
        {
            var_1.fx_current = 0;
            stopfx_fordrop( var_0, var_1 );
        }
    }
}

process_animation( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !isdefined( self.drop_thresholds ) )
    {
        var_0.drop_thresholds = [ 0, -200, -400, -600, -800, -1000 ];
        var_0.drop_fx_count = [ 1, 1, 2, 3, 4, 6 ];
    }

    if ( !isdefined( var_0.anim_state ) )
        var_0.anim_state = "shaft_no_hands";

    var_2 = "";
    var_3 = 1000;
    var_0.tag_left_hand = "j_wrist_le";
    var_0.tag_right_hand = "j_wrist_ri";
    var_0.tag_left_foot = "j_ball_le";
    var_0.tag_right_foot = "j_ball_ri";
    var_0.fx_goal_count = 0;
    var_0.fx_current = 0;

    for (;;)
    {
        waittillframeend;
        var_4 = var_0.anim_state;
        var_5 = level.player riggetvelocity();

        if ( var_2 != var_4 )
        {
            if ( var_4 == "drop_finished" )
            {
                stopfx_fordrop( var_2, var_0 );
                return;
            }

            var_0 notify( "stop_anim_state" );
            var_1 notify( "stop_anim_state" );

            if ( 0 )
            {
                var_6 = var_0 _meth_83EC();

                if ( isdefined( var_6 ) )
                    var_6 _meth_84B5( level.scr_anim_viewmodel[var_4] );
            }

            if ( is_transition( var_4 ) )
            {
                var_0.wait_for_anim = 1;
                var_1 thread anim_single_solo_with_wait_flag( var_0, var_4, "TAG_ORIGIN_ANIMATED" );
                var_0 set_cam_shake_drop( var_4 );
            }
            else
            {
                var_0.wait_for_anim = 0;
                var_1 thread maps\_anim::anim_loop_solo( var_0, var_4, "stop_anim_state", "TAG_ORIGIN_ANIMATED" );
                var_0 set_cam_shake_drop( var_4 );
            }

            var_0.fx_current = 0;
            var_0.fx_goal_count = 0;
            stopfx_fordrop( var_2, var_0 );
            thread drop_fx_thread( var_4, var_0 );
            var_2 = var_4;
        }

        if ( var_4 == "shaft_no_hands" )
            var_0.fx_goal_count = 0;
        else
            var_0.fx_goal_count = var_0 get_fx_count_for_speed( var_5 );

        var_3 = var_5;
        waitframe();
    }
}

anim_single_solo_with_wait_flag( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    maps\_anim::anim_single_solo( var_0, var_1, var_2 );
    var_0.wait_for_anim = 0;
}

is_transition_to_right( var_0 )
{
    if ( issubstr( var_0, "_to_right" ) )
        return 1;

    return 0;
}

is_transition_to_no( var_0 )
{
    if ( issubstr( var_0, "_to_no" ) )
        return 1;

    return 0;
}

is_transition_to_both( var_0 )
{
    if ( issubstr( var_0, "_to_both" ) )
        return 1;

    return 0;
}

is_transition_to_left( var_0 )
{
    if ( issubstr( var_0, "_to_left" ) )
        return 1;

    return 0;
}

is_transition( var_0 )
{
    if ( issubstr( var_0, "_to_" ) )
        return 1;

    return 0;
}

playfx_fordrop( var_0, var_1 )
{
    playorstopfx_fordrop( 1, var_0, var_1 );
}

stopfx_fordrop( var_0, var_1 )
{
    playorstopfx_fordrop( 0, var_0, var_1 );
}

playfxontag_functionhack( var_0, var_1, var_2 )
{
    playfxontag( var_0, var_1, var_2 );
}

stopfxontag_functionhack( var_0, var_1, var_2 )
{
    stopfxontag( var_0, var_1, var_2 );
}

playorstopfx_fordrop( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( var_0 == 1 )
        var_3 = ::playfxontag_functionhack;
    else
        var_3 = ::stopfxontag_functionhack;

    switch ( var_1 )
    {
        case "shaft_both_hands":
        case "shaft_right_hand_to_both":
        case "shaft_left_hand_to_both":
        case "shaft_no_hands_to_both":
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_right_hand );
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_left_hand );
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_left_foot );
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_right_foot );
            break;
        case "shaft_left_hand":
        case "shaft_right_hand_to_left":
        case "shaft_no_hands_to_left":
        case "shaft_both_hands_to_left":
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_right_hand );
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_left_foot );
            break;
        case "shaft_right_hand":
        case "shaft_left_hand_to_right":
        case "shaft_no_hands_to_right":
        case "shaft_both_hands_to_right":
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_left_hand );
            [[ var_3 ]]( common_scripts\utility::getfx( "sparks_runner_lp_sml" ), var_2, var_2.tag_right_foot );
            break;
        case "shaft_no_hands":
        case "shaft_right_hand_to_no":
        case "shaft_left_hand_to_no":
        case "shaft_both_hands_to_no":
            break;
    }
}

player_input_shaft_buttons_off()
{
    if ( gettime() > level.player.hint_allow_hide_time && ( level.player _meth_824C( "BUTTON_LTRIG" ) || level.player _meth_824C( "BUTTON_RTRIG" ) ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_player_exhaust_corridor" ) )
        return 1;

    return 0;
}

get_walk_anim( var_0 )
{
    if ( var_0 == "handsblocking" )
        return "blast_walk";
    else if ( var_0 == "nohands" )
        return "blast_walk_nohands";
    else if ( var_0 == "noguns" )
        return "blast_walk_nogun";
}

get_idle_anim( var_0 )
{
    if ( var_0 == "handsblocking" )
        return "blast_idle";
    else if ( var_0 == "nohands" )
        return "blast_idle_nohands";
    else if ( var_0 == "noguns" )
        return "blast_idle_nogun";
}

think_player_blast_walk_anims( var_0 )
{
    var_1 = "none";
    var_2 = "";
    level.player notify( "kill_think_player_blast_walk_anims" );
    level.player endon( "kill_think_player_blast_walk_anims" );
    thread maps\finale_anim_vm::anim_loop_solo_vm( level.player, get_idle_anim( var_0 ), "kill_think_player_blast_walk_anims" );

    for (;;)
    {
        var_3 = level.player _meth_82F3()[0];

        if ( var_3 > 0.1 || var_3 < -0.5 )
        {
            var_2 = get_walk_anim( var_0 );

            if ( var_2 != var_1 )
                level.player _meth_84B8( maps\finale_anim_vm::getanim_vm_index( var_2 ) );
        }
        else
        {
            var_2 = get_idle_anim( var_0 );

            if ( var_2 != var_1 )
                level.player _meth_84B8( 0 );
        }

        waitframe();
    }
}

anim_single_solo_with_lerp( var_0, var_1 )
{
    var_2 = 360.0;
    var_3 = 500.0;
    var_4 = var_2 / var_3;
    var_5 = getent( "org_player_knockback_limit", "targetname" );
    var_6 = spawn( "script_origin", var_5.origin );
    var_6.angles = ( 0, 180, 0 );
    var_7 = 0;

    if ( level.player.origin[0] < level.gideon.origin[0] )
        var_7 = 1;

    if ( var_7 )
        var_6.origin = ( level.gideon.origin[0] + var_2, var_6.origin[1], var_6.origin[2] );
    else
        var_6.origin = ( level.player.origin[0] + var_2, var_6.origin[1], var_6.origin[2] );

    if ( var_6.origin[0] > var_5.origin[0] )
        var_6.origin = ( var_5.origin[0], var_6.origin[1], var_6.origin[2] );

    var_4 = var_2 / var_3;
    var_0 = level.player.player_rig;

    if ( !isdefined( var_0 ) )
    {
        var_0 = maps\_utility::spawn_anim_model( "world_body_mech", level.player.origin + ( 0, 0, 30 ), level.player.angles );
        maps\_playermech_code::hide_mech_glass_static_overlay( var_0 );
    }

    level.player thread maps\_playermech_code::scripted_screen_flicker_loop();
    var_0 thread maps\_playermech_code::scripted_screen_flicker_loop();
    level.player notify( "kill_think_player_blast_walk_anims" );
    do_player_explode_react( var_0, var_6 );
}

do_player_explode_react( var_0, var_1 )
{
    level.player maps\_anim::anim_first_frame_solo( var_0, "exhaust_blast_react" );
    var_0.origin = level.player.origin;
    var_0.angles = var_1.angles;
    var_0 show();
    level.player maps\_playermech_code::mech_setup_player_for_scene();
    var_0 thread lerp_to_target( var_1.origin, var_1.angles, 1.0, 0.25 );
    level.player thread anim_single_solo_in_place( var_0, "exhaust_blast_react" );
    level.player _meth_807F( var_0, "TAG_PLAYER" );
    var_2 = getanimlength( var_0 maps\_utility::getanim( "exhaust_blast_react" ) );
    wait(var_2);
    thread think_player_blast_walk_anims( "noguns" );
    level.player maps\_playermech_code::mech_setup_player_for_forced_walk_scene();
    waitframe();
    level.player _meth_804F();
    var_0 hide();
    thread maps\finale_code::exhaust_corridor_timer();
}

lerp_to_target( var_0, var_1, var_2, var_3 )
{
    var_4 = level.player.origin;
    var_5 = level.player.angles;
    var_6 = spawn( "Script_origin", ( var_4[0], var_4[1], var_0[2] ) );
    var_6.angles = var_5;
    self _meth_804D( var_6 );
    var_6 _meth_82AE( var_0, var_2, var_2 * 0.25 );
    var_6 _meth_82B5( var_1, var_3, var_3 * 0.25 );
    wait(var_2);
    self _meth_804F();
    var_6 delete();
}

anim_single_solo_in_place( var_0, var_1 )
{
    var_0 maps\_anim::anim_single_solo( var_0, var_1 );
    var_0 notify( "anim_done" );
}
