// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

se_irons_react_to_gunfire( var_0 )
{
    var_1 = ( 0, 0, 0 );
    var_2 = 2.0;
    var_3 = 6.0;

    for (;;)
    {
        level.player waittill( "weapon_fired" );

        if ( common_scripts\utility::flag( "flag_se_irons_end_start" ) )
            return;

        var_4 = getdvarfloat( "cg_fov" );
        var_5 = level.player worldpointtoscreenpos( level.irons.origin, var_4 );

        if ( isdefined( var_5 ) )
        {
            var_0 notify( "ender" );

            if ( var_5[0] > var_1[0] )
                var_0 maps\_anim::anim_single_solo( level.irons, "irons_end_look_l" );
            else
                var_0 maps\_anim::anim_single_solo( level.irons, "irons_end_look_r" );

            if ( common_scripts\utility::flag( "flag_se_irons_end_start" ) )
                return;

            var_0 thread maps\_anim::anim_loop_solo( level.irons, "irons_end_idle", "ender" );
            wait(randomfloatrange( var_2, var_3 ));
        }
    }
}

anim_first_frame_with_finale_gameplay( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = undefined;
    maps\_anim::anim_first_frame( var_0, var_1 );

    if ( 1 )
    {
        maps\_anim::anim_first_frame_solo( var_2, var_1 );
        var_7 = getanimlength( var_2 maps\_utility::getanim( var_1 ) );
        var_2 maps\_anim::anim_set_time( [ var_2 ], var_1, 6.8333 / var_7 );
    }

    var_6 = create_pivot( var_2, "tag_origin", 0 );
    var_8 = gettime() + 34700.0;
    wait 13.3333;
    level.player notifyonplayercommand( "trigger_pulled", "+attack" );
    thread allow_fake_shooting( var_2, var_3, 7.0666 );
    move_pivot_process( var_6, var_2, "TAG_WEAPON_LEFT", level.irons, "TAG_EYE", var_1, 32.1333, 1, var_4 );

    if ( 1 )
    {
        while ( gettime() < var_8 )
            waitframe();

        var_3 hide();
        var_5 show();
        var_2 hide();
        var_4 show();
    }
}

allow_fake_shooting( var_0, var_1, var_2 )
{
    level.player endon( "end_fake_shooting" );
    var_3 = gettime() + var_2 * 1000;
    var_4 = "tag_rail_master_on";
    var_5 = 0;

    for (;;)
    {
        level.player waittill( "trigger_pulled" );
        var_6 = var_1 gettagorigin( var_4 );
        var_7 = anglestoforward( var_1 gettagangles( var_4 ) );
        var_8 = var_6 + var_7 * 50;
        var_9 = bullettrace( var_6, var_8, 1, var_1, 1, 1 );

        if ( gettime() > var_3 )
        {
            soundscripts\_snd_playsound::snd_play_2d( "wpn_dryfire_pistol_plr" );
            var_5++;

            if ( var_5 > 4 )
                return;
        }
        else
        {
            if ( isdefined( var_9["entity"] ) && var_9["entity"] == level.irons )
            {
                soundscripts\_snd_playsound::snd_play_2d( "wpn_dryfire_pistol_plr" );
                continue;
            }

            magicbullet( "iw5_titan45_sp", var_6, var_8, level.player );
            playfxontag( common_scripts\utility::getfx( "titan45_muzzle" ), var_1, var_4 );
            level.player playrumbleonentity( "pistol_fire" );

            if ( 0 )
            {
                var_10 = var_0 maps\_utility::getanim( "irons_reveal_fire_add" );
                var_0 setanim( var_10, 1.0, 0.05 );
                wait(getanimlength( var_10 ));
                var_11 = 0.05;
                var_0 setanim( var_10, 0, var_11 );
                wait(var_11);
            }
            else
            {
                var_10 = var_0 maps\_utility::getanim( "irons_reveal_fire_add" );
                wait(getanimlength( var_10 ));
            }
        }
    }
}

anim_single_with_gameplay( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;

    foreach ( var_7 in var_0 )
    {
        if ( var_7.animname == "world_body_damaged" )
            var_5 = var_7;

        if ( var_7.animname == "pistol" )
            var_3 = var_7;
    }

    if ( 1 )
    {
        var_4 = maps\_anim::anim_spawn_model( var_5.model, var_5.animname, var_1 );
        var_4.animname = var_5.animname;
        var_4 useanimtree( level.scr_animtree[var_4.animname] );
        var_5 hide();
        var_2 = maps\_anim::anim_spawn_model( var_3.model, var_3.animname, var_1 );
        var_2.animname = var_3.animname;
        var_2 useanimtree( level.scr_animtree[var_3.animname] );
        var_9 = ( 11.6, 0, 3.7 );
        var_2 linkto( var_4, "TAG_WEAPON_RIGHT", var_9, ( 0, 0, 0 ) );
        var_3 hide();
    }
    else
    {
        var_4 = var_5;
        var_2 = var_3;
    }

    if ( 0 )
    {
        var_0 = common_scripts\utility::array_remove( var_0, var_3 );
        var_2 linkto( var_4, "TAG_WEAPON_RIGHT", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }

    thread anim_first_frame_with_finale_gameplay( var_0, var_1, var_4, var_2, var_5, var_3 );

    if ( 1 )
        thread maps\_anim::anim_single_solo( var_4, var_1 );

    maps\_anim::anim_single( var_0, var_1 );

    if ( 0 )
        var_2 unlink();
}

create_pivot( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_3.origin = var_0 gettagorigin( var_1 );

    if ( var_2 )
        var_3.angles = var_0 gettagangles( var_1 );

    var_0 unlink();
    var_0 linkto( var_3 );
    return var_3;
}

set_pivot_pos( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_0 unlink();
    var_1.origin = var_0 gettagorigin( var_2 );

    if ( var_3 )
        var_1.angles = var_0 gettagangles( var_2 );

    var_0 linkto( var_1 );
    return var_1;
}

move_pivot_process( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_0 endon( "death" );
    var_3 endon( "death" );
    var_1 endon( "death" );
    set_pivot_pos( var_1, var_0, "J_Shoulder_RI" );
    var_9 = var_0.angles;
    var_10 = var_0.origin;
    var_11 = var_1 maps\_utility::getanim( var_5 );
    var_12 = var_6 / getanimlength( var_11 );
    var_13 = var_7 / getanimlength( var_11 );
    var_1.return_to_position = 0;
    thread check_on_target_process( var_3, var_4, var_1, var_2, 2.5 );
    var_14 = ( 0, 0, 0 );
    var_15 = ( 0, 0, 0 );
    var_16 = 1.0;

    for (;;)
    {
        if ( var_1.return_to_position )
        {
            var_17 = 0.5;
            var_0 rotateto( var_9, var_17, 0.025, 0.025 );
            var_14 = ( 0, 0, 0 );
            wait(var_17 * 2);
            var_1.return_to_position = 0;
            break;
        }
        else
        {
            var_18 = 0;
            var_19 = randomfloatrange( 0.4, 1.2 );
            var_20 = level.player getnormalizedcameramovements();

            if ( abs( var_20[0] ) > 0.01 && abs( var_20[1] ) > 0.01 )
            {
                var_14 -= ( 0, var_20[1] * var_19, var_20[0] * var_19 );
                var_18 = 1;
            }

            if ( var_18 )
            {
                var_21 = var_14[2];
                var_22 = var_14[1];

                if ( var_22 > 7.0 )
                    var_22 = 7.0;

                if ( var_22 < -7.0 )
                    var_22 = -7.0;

                if ( var_21 > 4.0 )
                    var_21 = 4.0;

                if ( var_21 < -4.0 )
                    var_21 = -4.0;

                var_14 = ( var_14[0], var_22, var_21 );
            }

            if ( !var_18 )
            {
                var_21 = var_14[2] - 1.0 * common_scripts\utility::sign( var_14[2] );
                var_22 = var_14[1] - 1.0 * common_scripts\utility::sign( var_14[1] );

                if ( abs( var_21 ) <= 1.0 )
                    var_21 = 0;

                if ( abs( var_22 ) <= 1.0 )
                    var_22 = 0;

                var_14 = ( var_14[0], var_22, var_21 );
            }

            var_23 = "";

            if ( var_18 )
            {
                var_24 = undefined;
                var_25 = undefined;

                if ( 1 )
                {
                    var_26 = sqrt( squared( var_14[2] ) + squared( var_14[1] ) );
                    var_27 = undefined;

                    if ( var_26 > 4 )
                        var_27 = 1.0;
                    else
                        var_27 = var_26 / 4;

                    var_28 = gettime() * 0.001 * 10;
                    var_25 = var_27 * perlinnoise2d( 0, var_28, 2, 2, 1 ) * 7;
                    var_24 = var_27 * perlinnoise2d( 10, var_28, 2, 2, 1 ) * 4;
                }
                else if ( abs( var_20[1] ) > 0.01 && abs( var_20[1] ) < 0.5 || abs( var_20[0] ) > 0.01 && abs( var_20[0] ) < 0.5 )
                {
                    var_28 = gettime() * 0.001 * 10;
                    var_25 = perlinnoise2d( 0, var_28, 2, 2, 1 ) * 7;
                    var_24 = perlinnoise2d( 10, var_28, 2, 2, 1 ) * 4;
                    var_24 *= ( abs( var_20[0] ) + 0.2 );
                    var_25 *= ( abs( var_20[1] ) + 0.2 );
                }

                var_14 = ( var_14[0], var_14[1] + var_24, var_14[2] + var_25 );
            }

            var_29 = var_1 getanimtime( var_11 );

            if ( var_29 >= var_12 )
            {
                var_16 = 1.0 - ( var_29 - var_12 ) / var_13;

                if ( var_16 < 0 )
                    var_16 = 0.0;

                level.player notify( "end_fake_shooting" );
            }

            var_15 = combineangles( var_9, var_14 );
            var_15 = angles_clamp_180( var_15 );
            var_30 = var_9 * ( 1.0 - var_16 ) + var_15 * var_16;
            var_0 rotateto( var_30, 0.05, 0.025, 0.025 );

            if ( var_16 == 0.0 )
                break;
        }

        waitframe();
        var_31 = 0;
    }

    waitframe();
    var_1.angles = var_8.angles;
    var_1.origin = var_8.origin;
    return;
}

angles_clamp_180( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

check_on_target_process( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 endon( "death" );
    var_2 endon( "death" );
    var_5 = 1;

    for (;;)
    {
        var_6 = getdvarfloat( "cg_fov" );
        var_7 = 0;
        var_8 = var_0 gettagorigin( var_1 );
        var_9 = var_2 gettagorigin( var_3 );
        var_10 = var_8 + anglestoright( level.player getangles() ) * var_4;

        if ( var_5 )
        {
            var_11 = level.player worldpointtoscreenpos( var_8, var_6 );
            var_12 = level.player worldpointtoscreenpos( var_9, var_6 );
            var_13 = level.player worldpointtoscreenpos( var_10, var_6 );

            if ( isdefined( var_11 ) && isdefined( var_12 ) && isdefined( var_13 ) )
            {
                var_14 = distance2dsquared( ( var_11[0], var_11[1], 0 ), ( var_12[0], var_12[1], 0 ) );
                var_15 = distance2dsquared( ( var_11[0], var_11[1], 0 ), ( var_13[0], var_13[1], 0 ) );

                if ( var_14 < var_15 )
                    var_7 = 1;
            }
        }
        else
        {
            var_14 = distancesquared( var_9, var_8 );

            if ( var_14 < squared( var_4 ) )
                var_7 = 1;
        }

        if ( level.player buttonpressed( "BUTTON_LTRIG" ) || level.player buttonpressed( "BUTTON_X" ) )
        {
            if ( var_7 )
            {
                var_2.return_to_position = 1;
                return;
            }
        }

        waitframe();
    }
}

player_input_ending_aim_button_off()
{
    var_0 = level.player getnormalizedcameramovements();

    if ( isdefined( var_0 ) && length2d( var_0 ) > 0.0 )
        return 1;

    return 0;
}

player_input_ending_shoot_button_off()
{
    if ( isdefined( level.player.finale_trigger_pulled ) && level.player.finale_trigger_pulled )
        return 1;

    return 0;
}
