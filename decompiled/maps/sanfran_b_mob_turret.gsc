// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_mob_turret()
{
    level.player maps\_shg_utility::setup_player_for_scene();
    soundscripts\_snd::snd_message( "mob_audio_setup" );

    if ( level.nextgen )
    {
        thread maps\_utility::fog_set_changes( "sanfran_b_guns_bright", 0.05 );
        level.player _meth_8490( "", 1.0 );
        level.player _meth_83C0( "sanfran_b_guns_bright" );
        level.player common_scripts\utility::delaycall( 0.5, ::_meth_83C0, "sanfran_b_guns_a" );
        _func_072( 6, 0 );
        maps\_utility::delaythread( 0.5, maps\_utility::fog_set_changes, "sanfran_b_guns", 0.05 );
    }
    else
    {
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_guns_bright", 0.05 );
        level.player _meth_83C0( "sanfran_b_guns_bright" );
        wait 1.1;
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_guns", 0.05 );
        level.player _meth_83C0( "sanfran_b_guns" );
    }

    common_scripts\utility::noself_delaycall( 0.5, ::_func_072, 0, 1 );
    _func_0D3( "sm_usedSunCascadeCount", 3 );
    _func_0D3( "sm_sunSampleSizeNear", 6 );
    _func_0D3( "r_fog_ev_adjust", 1 );
    common_scripts\_exploder::exploder( 3636 );
    thread maps\sanfran_b_lighting::ending_viewmodelblur();
    level.player soundscripts\_snd::snd_message( "mob_xform" );
    var_0 = getentarray( "railgun_turn_off_clip", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    var_4 = getent( "mob_turret_right", "targetname" );
    level.mob_turret_right = var_4;
    var_4.angles = ( -5, 0, 5 );
    var_4.angles -= ( 0, 325, 0 );
    var_4 _meth_80B1( "vehicle_mob_deck_large_calibur_turret_vm" );
    var_5 = ( -0.99, 0, 0 );
    level.player maps\sanfran_b_code::sonar_off();
    level.player notify( "end_sonar_vision" );
    level.player link_player_to_mob_turret( var_4, 0 );
    thread attachdistortionfx( var_4 );
    common_scripts\utility::flag_set( "player_on_turret_1" );
    var_4 thread control_mob_turret( var_5 );
    var_6 = "first_cargo_ship_destroyed";
    var_7 = 6.25;
    var_4 thread railgun_track_damage( var_6, var_7 );
    common_scripts\utility::flag_wait( var_6 );
    wait(var_7);
    common_scripts\utility::flag_set( "player_switching_to_turret_2" );
    thread maps\sanfran_b_code::static_overlay();
    common_scripts\utility::flag_clear( "cargo_ship_destroyed" );
    common_scripts\utility::flag_clear( "player_firing_mob_turret" );
    level.player unlink_player_from_mob_turret( var_4 );

    if ( level.nextgen )
    {
        level.player _meth_83C0( "sanfran_b_guns_bright" );
        thread maps\_utility::fog_set_changes( "sanfran_b_guns_bright", 0.05 );
        level.player common_scripts\utility::delaycall( 0.5, ::_meth_83C0, "sanfran_b_guns_b" );
        _func_072( 6, 0 );
        maps\_utility::delaythread( 0.5, maps\_utility::fog_set_changes, "sanfran_b_guns", 0.05 );
    }
    else
    {
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_guns_bright", 0.05 );
        level.player _meth_83C0( "sanfran_b_guns_bright" );
        wait 1.1;
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_guns", 0.5 );
        level.player _meth_83C0( "sanfran_b_guns" );
    }

    common_scripts\utility::noself_delaycall( 0.5, ::_func_072, 0, 1 );

    if ( level.nextgen )
    {
        level.defaultsundir = getmapsunangles();
        lerpsunangles( level.defaultsundir, ( -23, 80, 0 ), 0.1 );
    }

    level.player soundscripts\_snd::snd_message( "mob_xform" );
    var_8 = getent( "mob_turret_left", "targetname" );
    level.mob_turret_left = var_8;
    var_8.angles = ( 5, 0, -5 );
    var_8.angles += ( 0, 152, 0 );
    var_8 _meth_80B1( "vehicle_mob_deck_large_calibur_turret_vm" );
    var_5 = ( -0.55, 0.45, 0 );
    var_9 = getent( "railgun_turn_off", "targetname" );
    level.deletable_turret = var_9;
    var_9 hide();
    level.player link_player_to_mob_turret( var_8, 0 );
    thread attachdistortionfx( var_8 );
    common_scripts\utility::flag_set( "player_on_turret_2" );
    var_10 = "second_cargo_ship_destroyed";
    var_7 = 7.5;
    var_8 thread railgun_track_damage( var_10, var_7 );
    var_8 thread railgun_damage_timer();
    var_8 thread control_mob_turret( var_5 );
    common_scripts\_exploder::exploder( 3700 );
    common_scripts\utility::flag_wait( var_10 );
    wait(var_7);
    thread maps\sanfran_b_code::static_overlay();
    level.player unlink_player_from_mob_turret( var_8 );
    wait 0.25;
    level.player notify( "laser_off" );

    if ( level.nextgen )
        maps\_utility::fog_set_changes( "sanfran_b_end", 0.1 );
    else
        thread maps\_utility::vision_set_fog_changes( "sanfran_b_end", 0.1 );

    level.player _meth_83C0( "sanfran_b_end" );
    common_scripts\_exploder::exploder( 9028 );
    maps\_utility::stop_exploder( 3636 );
    thread maps\sanfran_b_lighting::ending_viewmodelblur_reset();
    resetsundirection();
    _func_0D3( "r_fog_ev_adjust", 1.5 );
}

#using_animtree("script_model");

link_player_to_mob_turret( var_0, var_1 )
{
    var_2 = 1;
    var_3 = "tag_aim_animated";
    var_4 = anglestoforward( var_0 gettagangles( var_3 ) );
    var_5 = var_4 * 15;
    var_6 = anglestoup( var_0 gettagangles( var_3 ) );
    var_7 = var_6 * 200;
    var_8 = var_0 common_scripts\utility::spawn_tag_origin();
    var_8.origin = var_8.origin + var_5 + var_7;
    var_8 _meth_804D( var_0, var_3 );
    self _meth_807D( var_0, "tag_player", 1, 0, 0, 0, 0, 1 );
    self _meth_834C( 1 );
    wait 0.5;
    var_0 start_railgun_hud();
    var_0.animname = "mob_turret";
    var_0 maps\_utility::assign_animtree();
    var_0 _meth_8152( "turret_transform", %sf_b_mob_turret_transform, 1, 0, 1 );
    var_9 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_10 = -30;
        var_11 = 12;

        if ( var_1 < 0 )
            var_9 = var_1 / var_10;
        else
            var_9 = var_1 / var_11;

        if ( var_1 < 0 )
        {
            var_0.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
            var_0.mob_pitch_sign = -1;
            var_0 _meth_8143( var_0.mob_pitch_anim, 1, 0, 0 );
            var_0 _meth_8117( var_0.mob_pitch_anim, var_9 );
        }
        else
        {
            var_0.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
            var_0.mob_pitch_sign = 1;
            var_0 _meth_8143( var_0.mob_pitch_anim, 1, 0, 0 );
            var_0 _meth_8117( var_0.mob_pitch_anim, var_9 );
        }
    }

    if ( var_2 )
    {
        self _meth_804F();
        var_12 = 2.65;
        self _meth_8080( var_8, "tag_origin", var_12, 0.25, 0.25 );
        common_scripts\utility::delaycall( var_12, ::_meth_807D, var_8, "tag_origin", 1, 0, 0, 0, 0, 1 );
    }

    var_0 waittillmatch( "turret_transform", "end" );
    var_0.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
    var_0.mob_yaw_sign = -1;
    var_0 _meth_8147( var_0.mob_yaw_anim, %root, 1, 0, 0 );

    if ( isdefined( var_9 ) )
    {
        var_0 _meth_8143( var_0.mob_pitch_anim, 1, 0, 0 );
        var_0 _meth_8117( var_0.mob_pitch_anim, var_9 );
    }

    var_8 thread delete_on_player_unlink();
}

unlink_player_from_mob_turret( var_0 )
{
    self _meth_834C( 0 );
    self _meth_804F();
    var_0 notify( "end_control_mob_turret" );
    var_0 stop_railgun_hud();
}

delete_on_player_unlink()
{
    while ( level.player _meth_8068() )
        wait 0.1;

    self delete();
}

should_pause_yaw_anim( var_0, var_1, var_2 )
{
    if ( isdefined( self.mob_yaw_anim ) )
    {
        if ( abs( var_0 ) < 0.1 )
            return 1;

        if ( var_1 < var_2[0] && var_0 > 0 )
            return 1;

        if ( var_1 > var_2[1] && var_0 < 0 )
            return 1;
    }

    return 0;
}

control_mob_turret( var_0 )
{
    self endon( "end_control_mob_turret" );
    maps\_utility::anim_stopanimscripted();
    childthread control_mob_fire();

    for (;;)
    {
        var_1 = level.player _meth_830D();
        var_2 = var_1[0] * 0.5;
        var_3 = var_1[1] * 0.25;
        var_4 = 0;

        if ( isdefined( self.mob_yaw_anim ) )
        {
            var_4 = self _meth_814F( self.mob_yaw_anim );
            var_4 *= self.mob_yaw_sign;
        }

        self.current_yaw = var_4;

        if ( should_pause_yaw_anim( var_3, var_4, var_0 ) )
        {
            self _meth_8143( self.mob_yaw_anim, 1, 0, 0 );
            soundscripts\_snd::snd_message( "mob_turret_move", "lat_stop" );
        }
        else if ( var_4 == 0 )
        {
            if ( var_3 < 0 )
            {
                self.mob_yaw_anim = %sf_b_mob_turret_center_to_l;
                self.mob_yaw_sign = 1;
            }
            else
            {
                self.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
                self.mob_yaw_sign = -1;
            }

            self _meth_8143( self.mob_yaw_anim, 1, 0, abs( var_3 ) );
            soundscripts\_snd::snd_message( "mob_turret_move", "lat_move" );
        }
        else if ( var_4 > 0 )
        {
            self.mob_yaw_anim = %sf_b_mob_turret_center_to_l;
            self.mob_yaw_sign = 1;
            self _meth_8143( self.mob_yaw_anim, 1, 0, var_3 * -1 );
            soundscripts\_snd::snd_message( "mob_turret_move", "lat_move" );
            self _meth_8117( self.mob_yaw_anim, var_4 );
        }
        else
        {
            self.mob_yaw_anim = %sf_b_mob_turret_center_to_r;
            self.mob_yaw_sign = -1;
            self _meth_8143( self.mob_yaw_anim, 1, 0, var_3 );
            soundscripts\_snd::snd_message( "mob_turret_move", "lat_move" );
            self _meth_8117( self.mob_yaw_anim, var_4 * self.mob_yaw_sign );
        }

        var_5 = 0;

        if ( isdefined( self.mob_pitch_anim ) )
        {
            var_5 = self _meth_814F( self.mob_pitch_anim );
            var_5 *= self.mob_pitch_sign;
        }

        self.current_pitch = var_5;

        if ( isdefined( self.mob_pitch_anim ) && abs( var_2 ) < 0.1 )
        {
            self _meth_8143( self.mob_pitch_anim, 1, 0, 0 );
            soundscripts\_snd::snd_message( "mob_turret_move", "vert_stop" );
        }
        else if ( var_5 == 0 )
        {
            if ( var_2 < 0 )
            {
                self.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
                self.mob_pitch_sign = 1;
            }
            else
            {
                self.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
                self.mob_pitch_sign = -1;
            }

            self _meth_8143( self.mob_pitch_anim, 1, 0.2, 0 );
            wait 0.2;
            self _meth_8117( self.mob_pitch_anim, 0.001 );
        }
        else if ( var_5 > 0 )
        {
            self.mob_pitch_anim = %sf_b_mob_turret_center_to_low;
            self.mob_pitch_sign = 1;
            self _meth_8143( self.mob_pitch_anim, 1, 0, var_2 * -1 );
            soundscripts\_snd::snd_message( "mob_turret_move", "vert_move" );
            self _meth_8117( self.mob_pitch_anim, var_5 );
        }
        else
        {
            self.mob_pitch_anim = %sf_b_mob_turret_center_to_up;
            self.mob_pitch_sign = -1;
            self _meth_8143( self.mob_pitch_anim, 1, 0, var_2 );
            soundscripts\_snd::snd_message( "mob_turret_move", "vert_move" );
            self _meth_8117( self.mob_pitch_anim, var_5 * self.mob_pitch_sign );
        }

        wait 0.05;
    }
}

control_mob_fire()
{
    var_0 = 3000;
    self.ms_until_ready_to_fire = 0;

    for (;;)
    {
        if ( level.player attackbuttonpressed() )
        {
            common_scripts\utility::flag_set( "player_firing_mob_turret" );
            mob_fire();

            for ( self.ms_until_ready_to_fire = var_0; self.ms_until_ready_to_fire > 0; self.ms_until_ready_to_fire -= 50 )
                wait 0.05;
        }

        wait 0.05;
    }
}

mob_fire()
{
    var_0 = "tag_flash1";
    self _meth_8145( %sf_b_mob_turret_fire, 1, 0, 1 );
    thread fire_effects( "tag_flash1" );
    soundscripts\_snd::snd_message( "mob_fire" );
    thread fire_effects( "tag_flash" );
}

fire_effects( var_0 )
{
    var_1 = self gettagorigin( var_0 );
    var_2 = self gettagangles( var_0 );
    var_3 = anglestoforward( var_2 );
    var_4 = var_1 + var_3 * 2000;
    magicbullet( "mob_turret_missile", var_1, var_4, level.player );
    wait 0.05;
    playfx( common_scripts\utility::getfx( "mob_turret_flash_view" ), self gettagorigin( var_0 ), anglestoforward( self gettagangles( var_0 ) ), anglestoup( self gettagangles( var_0 ) ) );
    thread fire_emp_wave( var_1, var_4 );
    thread fire_archlight_rumbles();
    thread mob_fire_linger_smoke( var_0 );

    if ( var_0 == "tag_flash" )
        var_5 = 1;
    else
        var_5 = -1;

    var_6 = 160;
    var_7 = var_5 * anglestoright( var_2 ) * var_6;
    thread calculate_water_pos( var_1 + var_7, var_3 );
}

fire_archlight_rumbles()
{
    maps\sanfran_b_util::setup_level_rumble_ent();
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.85, 0.5 );
    wait 0.5;
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.65, 0.3 );
    wait 0.3;
    thread maps\sanfran_b_util::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.2 );
}

fire_emp_wave( var_0, var_1 )
{
    var_2 = 500;
    var_3 = maps\_utility::getvehiclearray();
    var_4 = [];

    foreach ( var_6 in var_3 )
    {
        if ( !isdefined( var_6.healthbuffer ) || var_6.health < var_6.healthbuffer )
            continue;

        if ( isdefined( var_6.classname ) && issubstr( var_6.classname, "warbird" ) )
        {
            var_7 = vectorfromlinetopoint( var_0, var_1, var_6.origin );

            if ( length( var_7 ) < var_2 )
                var_4[var_4.size] = var_6;
        }
    }

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6 ) && isalive( var_6 ) && var_6.health > var_6.healthbuffer )
            var_6 thread destroy_warbird();
    }
}

destroy_warbird()
{
    self _meth_8052( level.player.origin, level.player );
    wait 0.05;

    if ( isdefined( self ) )
    {
        self notify( "crash_done" );
        self notify( "in_air_explosion" );
    }
}

kill_before_water()
{
    var_0 = 66500;
    var_1 = 67000;

    while ( isdefined( self ) && isalive( self ) )
    {
        var_2 = 0;
        var_3 = length( physicstrace( self.origin, self.origin + ( 0, 0, -10000 ), self ) );

        if ( var_3 <= var_0 )
            var_2 = 1;
        else if ( var_3 <= var_1 )
            var_2 = randomint( var_1 - var_0 ) < var_1 - ( var_3 - var_0 );

        if ( var_2 )
        {
            self notify( "near_goal" );
            return;
        }

        wait 0.1;
    }
}

mob_fire_linger_smoke( var_0 )
{
    wait 0.5;

    for ( var_1 = 0; var_1 < 50; var_1++ )
    {
        playfxontag( common_scripts\utility::getfx( "mob_turret_flash_view_muzzlesmoke" ), self, var_0 );
        wait 0.05;
    }
}

calculate_water_pos( var_0, var_1 )
{
    var_2 = ( -4546, 69221, -2723 );
    var_3 = ( -5, 0, 5 );
    var_4 = var_2 - var_0;
    var_5 = anglestoup( var_3 );
    var_6 = vectordot( var_4, var_5 );
    var_7 = var_0 + var_5 * var_6;
    var_8 = var_0 + var_1 * 10000;
    var_4 = var_2 - var_8;
    var_5 = anglestoup( var_3 );
    var_6 = vectordot( var_4, var_5 );
    var_9 = var_8 + var_5 * var_6;
}

attachdistortionfx( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    var_1 _meth_804D( var_0, "tag_player", ( 5, 0, 0 ), ( 0, 0, 0 ) );
    playfxontag( common_scripts\utility::getfx( "drone_cam_distortion" ), var_1, "tag_origin" );
}

start_railgun_hud()
{
    setomnvar( "ui_railgun", 1 );
    thread railgun_hud_update();
}

stop_railgun_hud()
{
    level notify( "stop_railgun_hud" );
    setomnvar( "ui_railgun", 0 );
}

railgun_hud_update()
{
    level endon( "stop_railgun_hud" );
    self endon( "death" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        if ( isdefined( self.ms_until_ready_to_fire ) )
            var_0 = self.ms_until_ready_to_fire;

        if ( isdefined( self.current_pitch ) )
            var_1 = int( ( self.current_pitch + 1 ) * 50 + 0.5 );

        if ( isdefined( self.current_yaw ) )
            var_2 = int( ( self.current_yaw + 1 ) * 50 + 0.5 );

        _func_23F( &"railgun_hud_update", 3, var_0, var_1, var_2 );
        waitframe();
    }
}

railgun_track_damage( var_0, var_1 )
{
    level endon( var_0 );
    var_2 = 2000;
    self.health = var_2;
    self _meth_82C0( 1 );
    var_3 = "overlay_static_digital";
    var_4 = newclienthudelem( level.player );
    var_4.x = 0;
    var_4.y = 0;
    var_4.alignx = "left";
    var_4.aligny = "top";
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4 _meth_80CC( var_3, 640, 480 );
    var_4.alpha = 0;
    var_4.sort = -3;
    var_5 = newclienthudelem( level.player );
    var_5.x = 0;
    var_5.y = 0;
    var_5.alignx = "left";
    var_5.aligny = "top";
    var_5.horzalign = "fullscreen";
    var_5.vertalign = "fullscreen";
    var_5 _meth_80CC( var_3, 640, 480 );
    var_5.alpha = 0;
    var_5.sort = -3;
    var_4 thread destroy_on_flag( var_0, var_1 );
    var_5 thread destroy_on_flag( var_0, var_1 );

    while ( self.health > 0 )
    {
        self waittill( "damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15 );

        if ( isdefined( var_10 ) && var_10 == "MOD_RIFLE_BULLET" )
        {
            self.health += int( var_6 * 0.9 );

            if ( !common_scripts\utility::flag( "player_on_turret_2" ) )
            {
                if ( randomintrange( 1, 99 ) < 20 )
                    level.player _meth_80AD( "light_1s" );
            }
            else if ( randomintrange( 1, 99 ) < 10 )
                level.player _meth_80AD( "light_1s" );
        }
        else
        {
            var_5 thread railgun_track_damage_static();
            level.player _meth_80AD( "heavy_1s" );
        }

        var_4.alpha = min( ( var_2 - self.health ) / var_2 * 0.3, 0.2 );
    }

    level.player _meth_80AD( "artillery_rumble" );
    level.player freezecontrols( 1 );
    setdvar( "ui_deadquote", &"SANFRAN_B_DEFEND_FLEET_FAILED" );
    maps\_utility::missionfailedwrapper();
}

railgun_damage_timer()
{
    while ( self.health > 0 )
    {
        self _meth_8051( randomintrange( 25, 50 ), self.origin, self, self, "MOD_RIFLE_BULLET" );
        wait(randomfloatrange( 0.05, 0.15 ));
    }
}

railgun_track_damage_static()
{
    level notify( "railgun_track_damage_static" );
    level endon( "railgun_track_damage_static" );
    self.alpha = 0.4;
    wait(randomfloatrange( 0.1, 0.2 ));

    while ( self.alpha > 0 )
    {
        self.alpha -= 0.05;
        wait 0.05;
    }
}

destroy_on_flag( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_0 );

    if ( isdefined( var_1 ) && var_1 > 0 )
        wait(var_1);

    self destroy();
}
