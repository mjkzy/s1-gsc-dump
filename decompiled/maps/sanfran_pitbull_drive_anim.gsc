// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

handle_player_pitbull_driving()
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );

    if ( !maps\_utility::ent_flag( "pitbull_scripted_anim" ) )
        childthread link_player_and_start_driving_anims();

    for (;;)
    {
        if ( maps\_utility::ent_flag( "pitbull_scripted_anim" ) )
        {
            maps\_utility::ent_flag_waitopen( "pitbull_scripted_anim" );
            self.fake_vehicle_model maps\_utility::anim_stopanimscripted();
            self.player_rig maps\_utility::anim_stopanimscripted();
            childthread link_player_and_start_driving_anims();
            wait 0.05;
            continue;
        }

        play_pitbull_anim();
        wait 0.05;
    }
}

link_player_and_start_driving_anims()
{
    link_player_and_play_idle();
    childthread adjust_pitbull_add_idle();
    childthread play_pitbull_camera_speed_anim();
    childthread play_pitbull_gear_shift_anim();
}

clear_anims()
{
    self.fake_vehicle_model _meth_8142( get_pitbull_anim_node( "root" ), 0 );
    self.player_rig _meth_8142( get_player_anim_node( "root" ), 0 );
    self.drive_anim_add_idle = undefined;
}

link_player_and_play_idle()
{
    var_0 = self.fake_vehicle_model;
    var_1 = self.player_rig;
    self.drive_anim_name = "cockpit_static_idle";
    var_0 _meth_8147( var_0 maps\_utility::getanim( self.drive_anim_name ), get_pitbull_anim_node( "root" ), 1, 0, 1 );
    var_1 _meth_8092();
    var_1 _meth_804F();
    var_2 = var_0 gettagorigin( "tag_body" );
    var_3 = var_0 gettagangles( "tag_body" );
    var_4 = getstartorigin( var_2, var_3, var_1 maps\_utility::getanim( self.drive_anim_name ) );
    var_5 = getstartangles( var_2, var_3, var_1 maps\_utility::getanim( self.drive_anim_name ) );
    var_1.origin = var_4;
    var_1.angles = var_5;
    var_1 _meth_804D( var_0, "tag_player" );
    var_1 _meth_8147( var_1 maps\_utility::getanim( self.drive_anim_name ), get_player_anim_node( "root" ), 1, 0, 1 );
    self.drive_yaw_sign = 1;
    self.drive_anim_centering = 0;
    self.drive_cam_anim_name = "cockpit_static_idle_cam";
    self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, 0, 1 );
    self.drive_cam_yaw_sign = 1;
    self.drive_cam_centering = 0;
    self.drive_anim_add_idle = undefined;
}

play_pitbull_anim()
{
    self endon( "pitbull_scripted_anim" );
    play_pitbull_steer_anim();

    if ( 1 )
        play_pitbull_camera_anim();
    else
        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( "cockpit_static_idle_cam" ), 1, 0, 1 );
}

play_pitbull_steer_anim()
{
    var_0 = 56;
    var_1 = 1 / var_0;
    var_2 = self.fake_vehicle_model;
    var_3 = self.player_rig;
    var_4 = 0;

    if ( self.drive_anim_name != "cockpit_static_idle" )
    {
        var_4 = var_3 _meth_814F( var_3 maps\_utility::getanim( self.drive_anim_name ) );

        if ( self.drive_anim_centering )
            var_4 = 1 - var_4;

        var_4 *= self.drive_yaw_sign;
    }

    var_5 = self _meth_8289() * 1;
    var_5 = clamp( var_5, -1, 1 );
    play_pitbull_add_idle( var_5, var_1 );

    if ( abs( var_5 ) < var_1 && abs( var_4 ) < var_1 )
    {
        var_6 = 0.2;

        if ( self.drive_anim_name != "cockpit_static_idle" )
        {
            var_6 = 0;
            var_2 _meth_814B( var_2 maps\_utility::getanim( self.drive_anim_name ), 0, 0, 0 );
            var_3 _meth_814B( var_3 maps\_utility::getanim( self.drive_anim_name ), 0, 0, 0 );
        }

        self.drive_anim_name = "cockpit_static_idle";
        set_pitbull_anim( ::_meth_8143, self.drive_anim_name, 1, var_6, 1 );
        self.drive_yaw_sign = 1;
        self.drive_anim_centering = 0;
    }
    else
    {
        var_7 = 0;
        var_8 = 1;
        var_9 = var_5 - var_4;

        if ( var_5 > 0 && var_4 < 0 || var_5 < 0 && var_4 > 0 )
        {
            var_8 = abs( var_5 ) * var_0 * 0.5;
            var_7 = 1;
        }
        else
            var_8 = abs( var_9 ) * var_0 * 0.5;

        if ( var_8 == 0 )
        {
            var_2 _meth_814B( var_2 maps\_utility::getanim( self.drive_anim_name ), 1, 0, var_8 );
            var_3 _meth_814B( var_3 maps\_utility::getanim( self.drive_anim_name ), 1, 0, var_8 );
        }
        else
        {
            if ( var_5 <= 0 && var_9 > 0 || var_5 >= 0 && var_9 < 0 )
                var_10 = 1;
            else
                var_10 = 0;

            var_11 = undefined;
            var_12 = 1;

            if ( var_9 < 0 )
            {
                if ( var_10 )
                {
                    var_11 = "left2center";
                    var_12 = 1;
                }
                else
                {
                    var_11 = "center2right";
                    var_12 = -1;
                }
            }
            else if ( var_10 )
            {
                var_11 = "right2center";
                var_12 = -1;
            }
            else
            {
                var_11 = "center2left";
                var_12 = 1;
            }

            if ( self.drive_anim_name != var_11 )
            {
                if ( self.drive_anim_name == "cockpit_static_idle" )
                {
                    self.drive_anim_name = var_11;
                    self.drive_yaw_sign = var_12;
                    self.drive_anim_centering = var_10;
                    set_pitbull_anim( ::_meth_8145, self.drive_anim_name, 1, 0, 1 );
                }
                else
                {
                    var_13 = var_2 _meth_814F( var_2 maps\_utility::getanim( self.drive_anim_name ) );
                    var_14 = var_3 _meth_814F( var_3 maps\_utility::getanim( self.drive_anim_name ) );
                    self.drive_anim_name = var_11;
                    self.drive_yaw_sign = var_12;
                    set_pitbull_anim( ::_meth_8143, self.drive_anim_name, 1, 0.2, var_8 );

                    if ( !var_7 && self.drive_anim_centering != var_10 )
                    {
                        self.drive_anim_jump_to_time = 1;
                        var_13 = 1 - var_13;
                        var_14 = 1 - var_14;
                        var_13 = clamp( var_13, 0, 1 );
                        var_14 = clamp( var_14, 0, 1 );
                        var_2 _meth_8117( var_2 maps\_utility::getanim( self.drive_anim_name ), var_13 );
                        var_3 _meth_8117( var_3 maps\_utility::getanim( self.drive_anim_name ), var_14 );
                    }

                    self.drive_anim_centering = var_10;
                }
            }
            else
            {
                self.fake_vehicle_model _meth_83C7( self.fake_vehicle_model maps\_utility::getanim( self.drive_anim_name ), var_8 );
                self.player_rig _meth_83C7( self.player_rig maps\_utility::getanim( self.drive_anim_name ), var_8 );
            }
        }
    }
}

set_pitbull_anim( var_0, var_1, var_2, var_3, var_4 )
{
    self.fake_vehicle_model call [[ var_0 ]]( self.fake_vehicle_model maps\_utility::getanim( var_1 ), var_2, var_3, var_4 );
    self.player_rig call [[ var_0 ]]( self.player_rig maps\_utility::getanim( var_1 ), var_2, var_3, var_4 );
}

set_pitbull_anim_node( var_0, var_1, var_2, var_3, var_4 )
{
    self.fake_vehicle_model call [[ var_0 ]]( self.fake_vehicle_model get_pitbull_anim_node( var_1 ), var_2, var_3, var_4 );
    self.player_rig call [[ var_0 ]]( self.player_rig get_player_anim_node( var_1 ), var_2, var_3, var_4 );
}

play_pitbull_speed_anim()
{
    var_0 = self _meth_8286();

    if ( !isdefined( self.drive_speed ) )
    {
        self.drive_speed = var_0;
        return;
    }

    var_1 = var_0 - self.drive_speed;

    if ( var_1 > 0 )
    {
        self.fake_vehicle_model _meth_8143( self.fake_vehicle_model maps\_utility::getanim( "accelerate" ), 1, 0, 1 );
        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( "accelerate" ), 1, 0, 1 );
    }
    else if ( var_1 < 0 )
    {
        self.fake_vehicle_model _meth_8143( self.fake_vehicle_model maps\_utility::getanim( "decelerate" ), 1, 0, 1 );
        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( "decelerate" ), 1, 0, 1 );
    }
    else
    {
        self.fake_vehicle_model _meth_8142( get_pitbull_anim_node( "speed_anims" ), 0.2 );
        self.player_rig _meth_8142( get_player_anim_node( "speed_anims" ), 0.2 );
    }

    self.drive_speed = var_0;
}

play_pitbull_camera_anim()
{
    var_0 = 56;
    var_1 = 1 / var_0;
    var_2 = self.player_rig;
    var_3 = 0;

    if ( self.drive_cam_anim_name != "cockpit_static_idle_cam" )
    {
        var_3 = var_2 _meth_814F( var_2 maps\_utility::getanim( self.drive_cam_anim_name ) );

        if ( self.drive_cam_centering )
            var_3 = 1 - var_3;

        var_3 *= self.drive_cam_yaw_sign;
    }

    var_4 = self _meth_8289();
    var_4 = clamp( var_4, -1, 1 );

    if ( var_4 <= 0 && var_4 > var_3 || var_4 >= 0 && var_4 < var_3 )
        var_5 = 1;
    else
        var_5 = 0;

    if ( abs( var_4 ) < var_1 && abs( var_3 ) < var_1 )
    {
        var_6 = 0;

        if ( self.drive_cam_anim_name != "cockpit_static_idle_cam" )
            var_6 = 0.2;

        self.drive_cam_anim_name = "cockpit_static_idle_cam";
        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, var_6, 1 );
        self.drive_cam_yaw_sign = 1;
        self.drive_cam_centering = 0;
    }
    else
    {
        var_7 = 0;
        var_8 = 1;
        var_9 = 0.1;
        var_10 = 0.4;

        if ( !isdefined( self.drive_cam_vel ) )
            self.drive_cam_vel = 0;

        var_11 = var_9;

        if ( var_5 )
            var_11 = var_10;

        var_12 = var_4 - var_3;

        if ( var_12 < 0 )
        {
            self.drive_cam_vel -= var_11 * 0.05;
            self.drive_cam_vel = clamp( self.drive_cam_vel, var_12, 0 );
        }
        else if ( var_12 > 0 )
        {
            self.drive_cam_vel += var_11 * 0.05;
            self.drive_cam_vel = clamp( self.drive_cam_vel, 0, var_12 );
        }

        var_4 = var_3 + self.drive_cam_vel;
        var_13 = self.drive_cam_vel;

        if ( var_4 <= 0 && var_4 > var_3 || var_4 >= 0 && var_4 < var_3 )
            var_5 = 1;
        else
            var_5 = 0;

        if ( var_4 > 0 && var_3 < 0 || var_4 < 0 && var_3 > 0 )
        {
            var_8 = abs( var_4 ) * var_0 * 0.5;
            var_7 = 1;
        }
        else
            var_8 = abs( var_13 ) * var_0 * 0.5;

        if ( var_8 == 0 )
            self.player_rig _meth_814B( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, 0, var_8 );
        else
        {
            var_14 = undefined;
            var_15 = 1;

            if ( var_13 < 0 )
            {
                if ( var_5 )
                {
                    var_14 = "left2center_cam";
                    var_15 = 1;
                }
                else
                {
                    var_14 = "center2right_cam";
                    var_15 = -1;
                }
            }
            else if ( var_5 )
            {
                var_14 = "right2center_cam";
                var_15 = -1;
            }
            else
            {
                var_14 = "center2left_cam";
                var_15 = 1;
            }

            if ( self.drive_cam_anim_name != var_14 )
            {
                if ( self.drive_cam_anim_name == "cockpit_static_idle_cam" )
                {
                    self.drive_cam_anim_name = var_14;
                    self.drive_cam_yaw_sign = var_15;
                    self.drive_cam_centering = var_5;
                    self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, 0, 1 );
                }
                else
                {
                    var_16 = self.player_rig _meth_814F( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ) );
                    self.drive_cam_anim_name = var_14;
                    self.drive_cam_yaw_sign = var_15;

                    if ( !var_7 && self.drive_cam_centering != var_5 )
                    {
                        var_16 = 1 - var_16;
                        var_16 = clamp( var_16, 0, 1 );
                        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, 0.2, var_8 );
                        self.player_rig _meth_8117( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), var_16 );
                    }
                    else
                        self.player_rig _meth_8143( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), 1, 0.2, var_8 );

                    self.drive_cam_centering = var_5;
                }
            }
            else
                self.player_rig _meth_83C7( self.player_rig maps\_utility::getanim( self.drive_cam_anim_name ), var_8 );
        }
    }
}

play_pitbull_add_idle( var_0, var_1 )
{
    var_2 = 0;

    if ( abs( var_0 ) < 0.25 )
        var_2 = 1;

    if ( !isdefined( self.drive_anim_add_idle ) || self.drive_anim_add_idle != var_2 )
    {
        self.drive_anim_add_idle = var_2;

        if ( self.drive_anim_add_idle )
        {
            set_pitbull_anim_node( ::_meth_814B, "idle_add", 1, 0.1, 1 );
            var_3 = randomfloatrange( 0, 1 );
            self.fake_vehicle_model _meth_8117( self.fake_vehicle_model maps\_utility::getanim( "cockpit_idle" ), var_3 );
            self.player_rig _meth_8117( self.player_rig maps\_utility::getanim( "cockpit_idle" ), var_3 );
        }
        else
            set_pitbull_anim_node( ::_meth_814B, "idle_add", 0, 0.1, 1 );
    }
}

adjust_pitbull_add_idle()
{
    self endon( "pitbull_scripted_anim" );

    for (;;)
    {
        var_0 = self _meth_8286();
        var_1 = var_0 / 60;
        var_1 = clamp( var_1, 0, 1 );
        set_pitbull_anim( ::_meth_814C, "cockpit_idle", 1, 0, var_1 );

        if ( 1 )
        {
            var_2 = var_0 / 60;
            var_2 = clamp( var_2, 0, 1.25 );
            self.player_rig _meth_814B( self.player_rig maps\_utility::getanim( "cockpit_shake_cam" ), 1, 0, var_2 );
        }

        wait 0.05;
    }
}

play_pitbull_camera_speed_anim()
{
    self endon( "pitbull_scripted_anim" );

    if ( !1 )
        return;

    self.drive_speed = 0;
    self.drive_cam_accel = 0;
    self.drive_cam_anim_accel = "none";
    var_0 = 0;

    for (;;)
    {
        var_1 = self _meth_8286();
        var_2 = self _meth_8288();

        if ( var_2[0] < -0.0001 )
            var_1 *= -1;

        var_3 = var_1 - self.drive_speed;
        var_4 = var_3 - self.drive_cam_accel;
        var_5 = 0;
        var_6 = 1;
        var_7 = "none";
        var_8 = 0;

        if ( var_3 < 0 )
            var_0 = 0;

        if ( self.drive_cam_anim_accel == "accelerate_cam" )
        {
            var_9 = self.player_rig _meth_814F( self.player_rig maps\_utility::getanim( self.drive_cam_anim_accel ) );

            if ( var_9 < 1 && var_3 > 0.1 )
                var_7 = "accelerate_cam";
            else
            {
                var_7 = "accelerate2idle_cam";
                var_8 = 1 - var_9;
                var_8 = clamp( var_8, 0, 1 );
            }
        }
        else if ( self.drive_cam_anim_accel == "accelerate2idle_cam" )
        {
            var_9 = self.player_rig _meth_814F( self.player_rig maps\_utility::getanim( self.drive_cam_anim_accel ) );

            if ( var_9 < 1 )
            {
                var_7 = "accelerate2idle_cam";

                if ( abs( var_4 ) > 0.5 )
                    var_6 = 2;
            }
        }
        else if ( self.drive_cam_anim_accel == "decelerate_cam" )
        {
            var_9 = self.player_rig _meth_814F( self.player_rig maps\_utility::getanim( self.drive_cam_anim_accel ) );

            if ( var_9 < 1 )
            {
                var_7 = "decelerate_cam";

                if ( var_3 > 1 )
                    var_6 = 3;
                else if ( var_3 > -0.5 )
                    var_6 = 2.5;
                else if ( var_3 > -0.1 )
                    var_6 = 2;

                if ( var_3 > 1 && var_4 >= 1 )
                    var_0 = 1;
            }
        }

        if ( self.drive_cam_anim_accel == "none" || var_7 == "none" )
        {
            if ( var_1 > 0 )
            {
                var_5 = 0.2;

                if ( var_0 && var_3 > 0 || var_3 > 0.9 && self.drive_cam_accel > 0.9 )
                    var_7 = "accelerate_cam";
                else if ( var_3 < -1.5 && abs( var_4 ) >= 1 )
                    var_7 = "decelerate_cam";
            }
        }

        self.drive_cam_accel = var_3;

        if ( self.drive_cam_anim_accel != var_7 )
        {
            if ( var_7 == "none" )
            {
                if ( self.drive_cam_anim_accel != "none" )
                    self.player_rig _meth_8142( self.player_rig maps\_utility::getanim( self.drive_cam_anim_accel ), 0.2 );
            }
            else
            {
                var_10 = self.player_rig maps\_utility::getanim( var_7 );
                self.player_rig _meth_8143( var_10, 1, var_5, var_6 );

                if ( var_8 > 0 )
                    self.player_rig _meth_8117( var_10, var_8 );
            }

            self.drive_cam_anim_accel = var_7;
        }

        self.drive_speed = var_1;
        wait 0.05;
    }
}

pick_best_gear( var_0 )
{
    if ( var_0 < 10 )
        return 1;
    else if ( var_0 < 40 )
        return 2;
    else
        return 3;
}

play_pitbull_gear_shift_anim()
{
    self endon( "pitbull_scripted_anim" );
    var_0 = self _meth_8286();
    var_1 = self _meth_8288();

    if ( var_1[0] < -0.0001 )
        var_0 *= -1;

    var_2 = pick_best_gear( var_0 );
    var_3 = "none";
    var_4 = 0;
    var_5 = 0;

    for (;;)
    {
        var_0 = self _meth_8286();
        var_1 = self _meth_8288();

        if ( var_1[0] < -0.0001 )
            var_0 *= -1;

        var_6 = 0;
        var_7 = 0;
        var_8 = "none";

        if ( var_2 == 1 )
        {
            var_6 = -99999;
            var_7 = 30;
        }
        else if ( var_2 == 2 )
        {
            var_6 = 20;
            var_7 = 55;
        }
        else if ( var_2 == 3 )
        {
            var_6 = 40;
            var_7 = 9999;
        }

        if ( var_0 < var_6 )
        {
            var_4 = pick_best_gear( var_0 );
            var_8 = "gear_down";
        }
        else if ( var_0 > var_7 )
        {
            var_4 = pick_best_gear( var_0 );
            var_8 = "gear_up";
            self _meth_8284( var_7, 60, 60 );
        }

        if ( var_3 != "none" )
        {
            var_9 = self.player_rig _meth_814F( self.player_rig maps\_utility::getanim( var_3 ) );

            if ( var_9 >= 0.3 && var_5 > 0 )
            {
                var_2 = var_5;
                var_5 = 0;
            }

            if ( var_9 >= 1 )
            {
                var_3 = "none";
                var_2 = var_4;
            }
        }
        else if ( var_3 != var_8 )
        {
            var_3 = var_8;
            var_5 = var_4;

            if ( isdefined( level.player_pitbull ) )
                level.player_pitbull notify( "audio_shift", var_3 );

            set_pitbull_anim( ::_meth_8145, var_3, 1, 0.2, 1 );
        }

        wait 0.05;
    }
}

#using_animtree("script_model");

get_pitbull_anim_node( var_0 )
{
    if ( var_0 == "root" )
        return %root;
    else if ( var_0 == "speed_anims" )
        return %speed_anims;
    else if ( var_0 == "idle_add" )
        return %idle_add;
    else
    {

    }
}

#using_animtree("player");

get_player_anim_node( var_0 )
{
    if ( var_0 == "root" )
        return %root;
    else if ( var_0 == "speed_anims" )
        return %speed_anims;
    else if ( var_0 == "idle_add" )
        return %idle_add;
    else if ( var_0 == "camera_accel_anims" )
        return %camera_accel_anims;
    else
    {

    }
}
