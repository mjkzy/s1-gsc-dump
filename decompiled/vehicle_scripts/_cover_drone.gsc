// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "cover_drone", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_mobile_cover_drone );
    maps\_vehicle::build_life( 2000 );
    build_cover_death( var_2 );
    maps\_vehicle::build_team( "allies" );
    precachestring( &"COVER_DRONE_LINK" );
    precachestring( &"COVER_DRONE_LINK_KB" );
    precachestring( &"COVER_DRONE_UNLINK" );
    precachestring( &"COVER_DRONE_UNLINK_KB" );
    precachestring( &"COVER_DRONE_LOWER_SHIELD" );
    precachestring( &"COVER_DRONE_LOWER_SHIELD_KB" );
    precachemodel( "vehicle_mobile_cover_tactics_friendly" );
    precachemodel( "vehicle_mobile_cover_active" );
    level._effect["link_light"] = loadfx( "vfx/lights/light_drone_beacon_green_sm_nolight" );
    level._effect["unlink_light"] = loadfx( "vfx/lights/light_drone_beacon_red_sm_nolight" );
    level.player thread record_grenade_throw_times();
    level.player thread record_grenade_rising_edges();
}

cover_drone_disable()
{
    if ( isdefined( self.linked_player ) )
        player_unlink_from_cover();

    self.cover_drone_disabled = 1;
}

cover_drone_enable()
{
    self.cover_drone_disabled = undefined;
}

build_cover_death( var_0 )
{
    maps\_vehicle::build_deathmodel( "moving_cover_standing_01", "moving_cover_standing_destroyed_01", 0.05, var_0 );
}

init_mobile_cover_drone()
{
    level.player endon( "death" );
    self.is_mobile_cover = 1;
    waittillframeend;
    self.original_model = self.model;
    self.tactics_model = "vehicle_mobile_cover_tactics_friendly";
    self.tactics_type = "tool";
    self.no_line = 1;
    self.description = "Mobile Cover";
    maps\_warzone_tactics::add_object_to_tactics_system( self );
    self.window_position = "up";
    self.extra_slow_player = 0;
    self.yaw_scale = 1.0;
    self.position_error = ( 0, 0, 0 );
    self.accumulated_restore = 0;
    self.godmode = 1;
    thread mobile_cover_impulse();
    self.link_trigger = common_scripts\utility::spawn_tag_origin();
    self.link_trigger maps\_utility::addhinttrigger( &"COVER_DRONE_LINK", &"COVER_DRONE_LINK_KB" );
    self.unlink_trigger = common_scripts\utility::spawn_tag_origin();
    self.unlink_trigger maps\_utility::addhinttrigger( &"COVER_DRONE_UNLINK", &"COVER_DRONE_UNLINK_KB" );
    thread mobile_cover_drone_trigger_think();
    thread mobile_cover_drone_hint_think();
}

mobile_cover_drone_trigger_think()
{
    while ( isdefined( self ) )
    {
        self.link_trigger waittill( "trigger" );

        if ( should_show_prompt( level.player ) )
        {
            thread player_link_to_cover( level.player );
            player_wait_and_unlink();
        }
    }
}

mobile_cover_drone_hint_think()
{
    var_0 = 0.5;
    var_1 = 0.5;
    playfxontag( common_scripts\utility::getfx( "unlink_light" ), self, "tag_fx" );
    var_2 = 0;
    var_3 = 0;

    while ( isdefined( self ) )
    {
        if ( isdefined( self.linked_player ) )
        {
            self.link_trigger makeglobalunusable();
            var_2 = 0;
            var_3 += 0.05;

            if ( var_3 > var_0 )
                self.unlink_trigger makeglobalusable( -999 );
        }
        else
        {
            self.unlink_trigger makeglobalunusable();
            var_2 += 0.05;
            var_3 = 0;

            if ( var_2 > var_1 && should_show_prompt( level.player ) )
                self.link_trigger makeglobalusable( -999 );
            else
                self.link_trigger makeglobalunusable();
        }

        waitframe();
    }
}

should_show_prompt( var_0 )
{
    if ( isdefined( self.cover_drone_disabled ) )
        return 0;

    if ( isdefined( self.linked_player ) )
        return 0;

    if ( isdefined( var_0.linked_to_cover ) )
        return 0;

    if ( isdefined( var_0.disable_cover_drone ) )
        return 0;

    var_1 = anglestoright( self.angles );
    var_2 = pointonsegmentnearesttopoint( self.origin + 18 * var_1, self.origin - 18 * var_1, var_0.origin ) - var_0.origin;

    if ( length( var_2 ) > 64 )
        return 0;

    var_3 = vectornormalize( var_2 );

    if ( vectordot( anglestoforward( var_0.angles ), common_scripts\utility::flat_origin( var_3 ) ) < cos( 45 ) )
        return 0;

    if ( vectordot( var_3, anglestoforward( self.angles ) ) < 0 )
        return 0;

    if ( abs( angleclamp180( var_0.angles[1] - self.angles[1] ) ) > 45 )
        return 0;

    if ( distance( var_0.origin + anglestoforward( var_0.angles ) * 35, self.origin ) > 45 )
        return 0;

    if ( anglestoup( self.angles )[2] < 0.766044 )
        return 0;

    if ( abs( self.origin[2] - var_0.origin[2] ) > 30 )
        return 0;

    return 1;
}

player_link_to_cover( var_0 )
{
    self.linked_player = var_0;
    vehicle_scripts\_cover_drone_aud::snd_init_cover_drone();
    self.linked_player.linked_to_cover = self;
    maps\_warzone_tactics::remove_object_from_tactics_system( self );
    self.linked_player endon( "death" );
    self.linked_player player_update_slow_aim( 1, self );
    self.linked_player allowjump( 0 );
    level.old_viewbobamplitudestanding = getdvar( "bg_viewBobAmplitudeStanding" );
    level.old_viewbobamplitudeducked = getdvar( "bg_viewBobAmplitudeDucked" );
    level.old_viewbobamplitudesprinting = getdvar( "bg_viewBobAmplitudeSprinting" );
    setsaveddvar( "bg_viewBobAmplitudeStanding", "0 0" );
    setsaveddvar( "bg_viewBobAmplitudeDucked", "0 0" );
    setsaveddvar( "bg_viewBobAmplitudeSprinting", "0 0" );
    self.window_position = "up";
    self.blend = 0;
    self.linked_player notify( "player_linked_to_cover" );

    if ( !isdefined( self.dummy_player ) )
        self.dummy_player = common_scripts\utility::spawn_tag_origin();

    self.dummy_player.origin = self.linked_player.origin;
    self.dummy_player.angles = ( 0, self.linked_player getgunangles()[1], 0 );
    self.dummy_player.vel = ( 0, 0, 0 );
    self.tag_origin = common_scripts\utility::spawn_tag_origin();
    self.tag_origin.origin = self.dummy_player.origin;
    self.tag_origin.angles = self.dummy_player.angles;
    self.linked_player playerlinktodelta( self.tag_origin, "tag_origin", 1.0, 0, 0, 80, 80, 0, 0 );
    self.ads = self.linked_player adsbuttonpressed();
    self.linked_player enablemousesteer( 1 );
    maps\_variable_grenade::change_threat_detection_style( "detectable" );
    stopfxontag( common_scripts\utility::getfx( "unlink_light" ), self, "tag_fx" );
    playfxontag( common_scripts\utility::getfx( "link_light" ), self, "tag_fx" );
    self overridematerial( "mtl_mobile_cover_glass_vm", "mtl_mobile_cover_glass_vm_active" );
    self makevehiclenotcollidewithplayers( 1 );
    thread player_ads_think();
    thread mobile_cover_link_think();
    thread mobile_cover_sound_think();
    thread player_unlink_on_sprint();
    thread player_unlink_on_death();
    thread player_enable_highlight();
    thread pass_mech_melee_damage_to_player();
}

pass_mech_melee_damage_to_player()
{
    if ( !isdefined( self.linked_player ) )
        return;

    self.linked_player endon( "death" );
    self.linked_player endon( "player_unlinked_from_cover" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isdefined( var_1 ) )
        {
            if ( isdefined( var_1.team ) && var_1.team == self.linked_player.team )
                continue;

            if ( !isdefined( var_1.mech ) )
                continue;

            if ( var_4 != "MOD_MELEE" )
                continue;

            var_10 = distance( self.origin, var_1.origin );
            var_11 = var_3 + var_2 * var_10 * -1;
            self.linked_player dodamage( var_0, var_11, var_1 );
        }
    }
}

mimic_player_move( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.05;
    var_5 = 100.0;
    var_6 = 5.5;
    var_7 = length( var_1.vel );

    if ( var_7 < 1.0 )
        var_1.vel = ( 0, 0, 0 );
    else
    {
        if ( var_7 < var_5 )
            var_8 = var_5;
        else
            var_8 = var_7;

        var_9 = var_8 * var_6 * var_4;
        var_10 = var_7 - var_9;

        if ( var_10 < 0 )
            var_10 = 0;

        var_1.vel = var_10 / var_7 * var_1.vel;
    }

    var_11 = sqrt( var_2 * var_2 + var_3 * var_3 );

    if ( var_2 < 0 )
        var_12 = abs( var_2 * 0.7 );
    else
        var_12 = abs( var_2 );

    var_13 = abs( var_3 * 0.8 );
    var_14 = max( var_12, var_13 );

    if ( var_14 <= 0 )
        var_15 = 0;
    else
        var_15 = getdvarint( "g_speed", 190 ) * var_14 / 127 * var_11;

    if ( level.player maps\_utility::isads() )
        var_15 *= 0.4;

    var_16 = var_0 getstance();
    var_17 = 9.0;

    if ( var_16 == "prone" )
    {
        var_15 *= 0.15;
        var_17 = 19.0;
    }
    else if ( var_16 == "crouch" )
    {
        var_15 *= 0.65;
        var_17 = 12.0;
    }

    var_18 = var_0 playerads();

    if ( var_18 > 0.5 )
        var_15 *= 0.5;

    var_15 *= var_0.move_scale;
    var_19 = anglestoforward( var_1.angles );
    var_20 = anglestoright( var_1.angles );
    var_21 = var_2 * var_19 + var_3 * var_20;
    var_22 = length( var_21 );
    var_23 = vectornormalize( var_21 );
    var_22 *= var_15;
    var_24 = playerphysicstraceinfo( var_1.origin + ( 0, 0, 100 ), var_1.origin + ( 0, 0, -100 ), self );
    var_25 = var_24["normal"];
    var_21 = maps\_pmove::pm_projectvelocity( var_21, var_25 );
    var_26 = vectordot( var_1.vel, var_23 );
    var_27 = var_22 - var_26;

    if ( var_27 <= 0 )
    {

    }
    else
    {
        if ( var_22 < var_5 )
            var_8 = var_5;
        else
            var_8 = var_22;

        var_28 = var_17 * var_4 * var_8;

        if ( var_28 > var_27 )
            var_28 = var_27;

        var_1.vel += var_28 * var_23;
    }

    var_1.vel = maps\_pmove::pm_projectvelocity( var_1.vel, var_25 );

    if ( var_1.vel[0] != 0 || var_1.vel[1] != 0 )
        maps\_pmove::pm_stepslidemove( var_1, var_25, 0 );

    var_29 = playerphysicstrace( var_1.origin, var_1.origin + ( 0, 0, -5 ), self );
    var_1.origin = var_29;
}

mobile_cover_dummy_player_think()
{
    var_0 = self.linked_player getnormalizedmovement();
    var_1 = self.linked_player getnormalizedcameramovements();
    var_1 = ( var_1[0], -1 * var_1[1], 0 );
    var_2 = self.linked_player getaimassistdeltas();
    var_3 = 0.05;
    var_4 = self.dummy_player.origin;
    mimic_player_move( self.linked_player, self.dummy_player, 127 * var_0[0], 127 * var_0[1] );
    var_5 = common_scripts\utility::flat_origin( self.position_error );
    var_6 = length( var_5 );
    var_7 = 32;
    var_8 = 10;
    var_9 = vectordot( var_5, self.dummy_player.vel * var_3 );

    if ( var_6 > var_7 && var_9 > 0 )
    {
        if ( self.accumulated_restore < var_8 )
        {
            self.accumulated_restore += abs( var_9 );
            self.dummy_player.vel = ( 0, 0, 0 );
            self.dummy_player.origin = var_4;
        }
    }
    else
    {
        self.accumulated_restore -= 2;

        if ( self.accumulated_restore < 0 )
            self.accumulated_restore = 0;
    }

    if ( var_2[1] )
        var_10 = var_3 * var_2[1] * self.yaw_scale;
    else
        var_10 = 2 * var_1[1] * self.yaw_scale;

    var_11 = self.dummy_player.angles[1] + var_10;

    if ( self.linked_player adsbuttonpressed() && !self.ads )
    {
        self.ads = 1;
        var_12 = self.linked_player getaimassisttargetangles();

        if ( var_12[1] != 0 || var_12[0] != 0 )
            var_11 = var_12[1];
    }
    else
        self.ads = self.linked_player adsbuttonpressed();

    self.dummy_player.angles = ( self.dummy_player.angles[0], angleclamp180( var_11 ), self.dummy_player.angles[2] );
    var_13 = anglestoforward( self.angles );
    var_14 = vectordot( var_13, self.origin - self.dummy_player.origin );

    if ( var_14 < 30 )
    {
        var_15 = 30 - var_14;
        var_16 = self.dummy_player.origin - var_13 * var_15;
        var_17 = playerphysicstraceinfo( var_16 + ( 0, 0, 8 ), var_16 - ( 0, 0, 8 ), self );

        if ( var_17["fraction"] > 0 )
            self.dummy_player.origin = var_17["position"];
        else
            self.dummy_player.origin = var_4;
    }

    return self.dummy_player.vel;
}

mobile_cover_link_think()
{
    self endon( "stop_mobile_cover_link_think" );
    self endon( "death" );
    self.linked_player endon( "death" );
    mobile_cover_link_think_angle_controller();
}

mobile_cover_link_think_angle_controller()
{
    var_0 = 33;
    var_1 = 39;
    var_2 = 12;
    var_3 = 4;
    var_4 = 25;
    var_5 = 0.3;
    var_6 = 0.6;
    var_7 = 0.1;
    var_8 = 0.8;
    var_9 = 0.8;
    var_10 = 0.1;
    var_11 = filter_lead_controller_init( self.dummy_player.origin, var_5, var_6, var_7 );
    var_12 = filter_lead_controller_init( self.dummy_player.angles[1], var_8, var_9, var_10, 1 );
    var_13 = self.origin;
    var_14 = self.angles;

    for (;;)
    {
        var_15 = mobile_cover_dummy_player_think();
        var_16 = var_11 [[ var_11.update_func ]]( self.dummy_player.origin );
        var_16 = ( var_16[0], var_16[1], var_13[2] );
        var_17 = var_12 [[ var_12.update_func ]]( self.dummy_player.angles[1] );
        var_18 = var_13 - var_16;
        var_19 = vectortoangles( var_18 );
        var_20 = var_19[1];
        var_21 = length( var_18 );
        var_22 = 1;
        var_23 = clamp( var_21, var_0 * var_22, var_1 * var_22 );
        var_24 = var_23 - var_21;
        var_25 = maps\_utility::linear_interpolate( self.blend, var_2, var_3 );
        var_26 = atan( var_25 / var_21 );
        var_26 *= maps\_shg_utility::linear_map_clamp( length( var_15 ), 10, 50, 1, 0 );
        var_27 = angleclamp180( var_17 - var_20 );
        self.extra_slow_player = 0;

        if ( abs( var_27 ) < var_26 )
            var_28 = 0;
        else
        {
            var_28 = var_27 - var_26 * common_scripts\utility::sign( var_27 );
            self.extra_slow_player = 1;
        }

        var_29 = angleclamp( var_20 + var_28 );
        var_30 = var_16 + anglestoforward( ( 0, var_29, 0 ) ) * var_23;
        var_31 = ( 0, var_17, 0 );
        self.tag_origin unlink();
        self.tag_origin.origin = self.dummy_player.origin;
        self.tag_origin.angles = self.dummy_player.angles;
        drive_cover( var_30, var_31 );
        waitframe();
        var_13 = self.origin;
        var_14 = self.angles;
    }
}

mobile_cover_vehicle_controller()
{
    for (;;)
    {
        var_0 = self.dummy_player.origin + anglestoforward( self.dummy_player.angles ) * 35;
        var_1 = self.dummy_player.angles;
        drive_cover( var_0, var_1 );
        waitframe();
    }
}

drive_cover( var_0, var_1 )
{
    var_2 = 0.738636;

    foreach ( var_4 in getaiarray( "all" ) )
    {
        if ( isalive( var_4 ) && var_4 istouching( self ) )
        {
            var_5 = var_0 - self.origin;
            var_6 = vectornormalize( self.origin - var_4.origin );
            var_7 = vectordot( var_5, var_6 );

            if ( var_7 < 0 )
            {
                var_0 -= var_6 * var_7;
                var_1 = self.angles;
            }
        }
    }

    var_9 = var_0 - self.origin;
    var_10 = common_scripts\utility::flat_origin( var_9 );
    var_11 = length( var_10 );
    self.position_error = var_9;

    if ( var_11 > 45 )
    {
        soundscripts\_snd::snd_message( "cdrn_auto_unlink" );
        thread player_unlink_from_cover();
    }

    if ( abs( angleclamp180( var_1[1] - self.angles[1] ) ) > 45 )
    {
        soundscripts\_snd::snd_message( "cdrn_auto_unlink" );
        thread player_unlink_from_cover();
    }

    if ( anglestoup( self.angles )[2] < 0.766044 )
    {
        soundscripts\_snd::snd_message( "cdrn_auto_unlink" );
        thread player_unlink_from_cover();
    }

    if ( abs( self.origin[2] - self.linked_player.origin[2] ) > 30 )
    {
        soundscripts\_snd::snd_message( "cdrn_auto_unlink" );
        thread player_unlink_from_cover();
    }

    var_12 = distance2d( self.origin, var_0 ) * var_2;
    var_13 = self.dummy_player maps\_shg_utility::get_differentiated_speed() / 17.6;
    var_12 = clamp( var_12, 0.01, var_13 + 5 );
    self vehicle_rotateyaw( var_1[1] );
    self vehicledriveto( var_0, var_12 );
}

filter_lead_controller_init( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = spawnstruct();
    var_5.is_filter_lead_controller = 1;
    var_5.update_func = ::filter_lead_controller_update;
    var_5.position_smoothing = var_1;
    var_5.velocity_smoothing = var_2;
    var_5.lead_time = var_3;
    var_5.is_angles = isdefined( var_4 ) && var_4;

    if ( var_5.is_angles )
        var_0 = angleclamp180( var_0 );

    var_5.target_position = var_0;
    var_5.smooth_target_position = var_0;
    var_5.smooth_target_velocity = var_0 * 0;
    return var_5;
}

filter_lead_controller_update( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.05;

    if ( self.is_angles )
        var_0 = angleclamp180( var_0 );

    var_2 = var_0 - self.target_position;

    if ( self.is_angles )
        var_2 = angleclamp180( var_2 );

    var_3 = var_2 / var_1;
    self.target_position = var_0;

    if ( self.is_angles )
        self.smooth_target_position = angle_interpolate( self.position_smoothing, var_0, self.smooth_target_position );
    else
        self.smooth_target_position = maps\_utility::linear_interpolate( self.position_smoothing, var_0, self.smooth_target_position );

    self.smooth_target_velocity = maps\_utility::linear_interpolate( self.velocity_smoothing, var_3, self.smooth_target_velocity );
    var_4 = self.smooth_target_position + self.smooth_target_velocity * self.lead_time;

    if ( self.is_angles )
        var_4 = angleclamp( var_4 );

    return var_4;
}

angle_interpolate( var_0, var_1, var_2 )
{
    return angleclamp180( var_1 + angleclamp180( var_2 - var_1 ) * var_0 );
}

sigmoid( var_0 )
{
    var_1 = [ [ 0, 0 ], [ 0.3, 0.05 ], [ 0.4, 0.2 ], [ 0.5, 0.5 ], [ 0.6, 0.8 ], [ 0.7, 0.95 ], [ 1.0, 1.0 ] ];

    foreach ( var_8, var_3 in var_1 )
    {
        if ( var_3[0] >= var_0 )
        {
            if ( var_8 > 0 )
            {
                var_4 = var_1[var_8 - 1];
                var_5 = var_0 - var_4[0];
                var_6 = var_3[0] - var_4[0];
                var_7 = var_5 / var_6;
                var_0 = var_7 * ( var_3[1] - var_4[1] ) + var_4[1];
                return var_0;
            }
            else
                return var_3[1];
        }
    }

    return var_0;
}

#using_animtree("vehicles");

player_ads_think()
{
    self.linked_player endon( "death" );
    self.linked_player endon( "player_unlinked_from_cover" );
    self endon( "death" );
    self notify( "new_ads_think" );
    thread close_ads_window_on_unlink();
    self.window_position = "up";
    var_0 = 0.5;
    var_1 = -0.2;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    thread ads_hint_display();

    for (;;)
    {
        waittillframeend;
        var_5 = self.linked_player adsbuttonpressed() || self.linked_player is_really_throwing_grenade();

        if ( var_5 || var_3 || var_4 > 0 )
        {
            self.blend += var_0;

            if ( var_5 )
                var_3 = 1;
        }
        else
            self.blend += var_1;

        if ( var_4 > 0 )
            var_4--;

        self.blend = clamp( self.blend, 0, 1 );

        if ( self.blend == 1 )
        {
            var_3 = 0;

            if ( var_5 )
                var_4 = 3;
        }

        if ( var_2 == 1 && self.blend != 1 )
            thread ads_hint_display();
        else if ( var_2 != 1 && self.blend == 1 )
            thread ads_hint_clear();

        play_window_sound( var_2, self.blend );
        var_6 = sigmoid( self.blend );
        self setanim( %mobile_cover_window_down_pose, var_6, 0.05, 1 );
        self setanim( %mobile_cover_window_up_pose, 1 - var_6, 0.05, 1 );
        self.linked_player player_update_slow_aim( 1, self );

        if ( self.blend > 0.5 )
        {
            self.window_position = "down";
            maps\_variable_grenade::change_threat_detection_style( "enhanceable" );
        }
        else
        {
            self.window_position = "up";
            maps\_variable_grenade::change_threat_detection_style( "detectable" );
        }

        var_2 = self.blend;
        waitframe();
    }
}

play_window_sound( var_0, var_1 )
{
    if ( var_0 == 0 && var_1 != 0 )
        self playsound( "cdrn_window_open" );
    else if ( var_0 == 1 && var_1 != 1 )
        self playsound( "cdrn_window_close" );
    else if ( var_0 != 0 && var_1 == 0 )
        self playsound( "cdrn_window_open_latch" );
    else if ( var_0 != 1 && var_1 == 1 )
        self playsound( "cdrn_window_close_latch" );
}

ads_hint_display()
{
    self notify( "ads_hint_state_change" );
    self endon( "ads_hint_state_change" );
    var_0 = create_ads_hint_string();
    common_scripts\utility::waittill_any_ents( self, "ads_hint_clear", self.linked_player, "player_unlinked_from_cover" );
    var_0 destroy();
}

ads_hint_clear()
{
    self notify( "ads_hint_clear" );
}

close_ads_window_on_unlink()
{
    self endon( "new_ads_think" );
    self.linked_player endon( "death" );
    self endon( "death" );
    self.linked_player waittill( "player_unlinked_from_cover" );
    var_0 = -0.2;
    var_1 = self.blend;

    while ( self.blend > 0 )
    {
        self.blend += var_0;
        self.blend = clamp( self.blend, 0, 1 );

        if ( self.blend > 0.5 )
            self.window_position = "down";
        else
            self.window_position = "up";

        play_window_sound( var_1, self.blend );
        var_2 = sigmoid( self.blend );
        self setanim( %mobile_cover_window_down_pose, var_2, 0.05, 1 );
        self setanim( %mobile_cover_window_up_pose, 1 - var_2, 0.05, 1 );
        var_1 = self.blend;
        wait 0.05;
    }
}

player_update_slow_aim( var_0, var_1 )
{
    if ( var_0 )
    {
        var_2 = self getlocalplayerprofiledata( "viewSensitivity" );
        var_3 = pow( self playerads(), 3 );
        var_4 = maps\_utility::linear_interpolate( var_3, 0.480769, 1.90259 ) / var_2;

        if ( var_1.extra_slow_player )
            var_4 *= 0.75;

        var_4 = clamp( var_4, 0.01, 0.99 );
        var_5 = clamp( var_4 * 6, 0.01, 0.99 );
        self enableslowaim( var_5, var_4 );
        self setmovespeedscale( 0.6 );
        self.yaw_scale = maps\_utility::linear_interpolate( var_3, 0.480769, 0.120192 );
        self.move_scale = 0.6;
    }
    else
    {
        self.yaw_scale = 1.0;
        self.move_scale = 1.0;
        self disableslowaim();
        self setmovespeedscale( 1 );
    }
}

player_wait_and_unlink()
{
    self.linked_player endon( "player_unlinked_from_cover" );
    self.unlink_trigger waittill( "trigger" );
    thread player_unlink_from_cover();
}

player_unlink_on_sprint()
{
    if ( !isdefined( self.linked_player ) )
        return;

    self.linked_player endon( "death" );
    self.linked_player endon( "player_unlinked_from_cover" );
    self endon( "death" );

    for (;;)
    {
        if ( self.linked_player sprintbuttonpressed() && !self.ads )
        {
            player_unlink_from_cover();
            break;
        }

        waitframe();
    }
}

player_unlink_on_death()
{
    if ( !isdefined( self.linked_player ) )
        return;

    self.linked_player endon( "player_unlinked_from_cover" );
    self.linked_player waittill( "death" );
    player_unlink_from_cover();
}

player_unlink_from_cover()
{
    self notify( "stop_mobile_cover_link_think" );
    self.linked_player.linked_to_cover = undefined;
    vehicle_scripts\_cover_drone_aud::snd_stop_cover_drone( 1.0, 1.5 );
    maps\_warzone_tactics::add_object_to_tactics_system( self );
    self unlink();
    self.linked_player unlink();
    self.tag_origin delete();
    self.tag_origin = undefined;
    self.dummy_player delete();
    self.dummy_player = undefined;
    self.linked_player enablemousesteer( 0 );
    thread unlink_failsafe();
    setsaveddvar( "bg_viewBobAmplitudeStanding", level.old_viewbobamplitudestanding );
    setsaveddvar( "bg_viewBobAmplitudeDucked", level.old_viewbobamplitudeducked );
    setsaveddvar( "bg_viewBobAmplitudeSprinting", level.old_viewbobamplitudesprinting );
    self.linked_player allowjump( 1 );
    self.linked_player enable_weapon_pickup_wrapper();
    self.linked_player player_update_slow_aim( 0 );
    self.linked_player pushplayervector( ( 0, 0, 0 ), 1 );
    maps\_variable_grenade::change_threat_detection_style( "enhanceable" );
    self vehicledriveto( self.origin, 0 );
    stopfxontag( common_scripts\utility::getfx( "link_light" ), self, "tag_fx" );
    playfxontag( common_scripts\utility::getfx( "unlink_light" ), self, "tag_fx" );
    self overridematerialreset();
    var_0 = self.linked_player;
    self.linked_player = undefined;
    var_0 notify( "player_unlinked_from_cover" );
}

unlink_failsafe()
{
    if ( isdefined( self.unlink_failsafe_running ) )
        return;

    self.unlink_failsafe_running = 1;
    self endon( "death" );
    level.player endon( "death" );

    while ( level.player istouching( self ) )
    {
        self vehicle_removebrushmodelcollision();
        waitframe();
        self vehicle_assignbrushmodelcollision();
    }

    self.unlink_failsafe_running = undefined;
}

get_mobile_cover_base_from_ent( var_0 )
{
    if ( isdefined( var_0.is_mobile_cover ) )
        return var_0;

    return undefined;
}

player_enable_highlight()
{
    if ( !isdefined( self.linked_player ) )
        return;

    self.linked_player endon( "death" );
    var_0 = newclienthudelem( self.linked_player );
    var_0.color = ( 1, 0.05, 0.025 );
    var_0.alpha = 0.01;
    var_0 setradarhighlight( -1 );
    self.linked_player waittill( "player_unlinked_from_cover" );
    var_0 destroy();
}

create_trigger_hint_string( var_0 )
{
    var_1 = level.player maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_1.alpha = 0.7;
    var_1.alignx = "center";
    var_1.aligny = "middle";
    var_1.y = 130;
    var_1.horzalign = "center";
    var_1.vertalign = "middle";
    var_1.foreground = 0;
    var_1.hidewhendead = 1;
    var_1.hidewheninmenu = 1;

    if ( var_0 == "link" )
        var_1 settext( &"COVER_DRONE_LINK" );
    else
        var_1 settext( &"COVER_DRONE_UNLINK" );

    return var_1;
}

create_ads_hint_string()
{
    var_0 = level.player maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_0.alpha = 0.7;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.y = 115;
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0.foreground = 0;
    var_0.hidewhendead = 1;
    var_0.hidewheninmenu = 1;

    if ( level.player usinggamepad() )
        var_0 settext( &"COVER_DRONE_LOWER_SHIELD" );
    else if ( getkeybinding( "+toggleads_throw" )["count"] > 0 )
        var_0 settext( &"COVER_DRONE_LOWER_SHIELD_KB" );
    else
        var_0 settext( &"COVER_DRONE_LOWER_SHIELD" );

    return var_0;
}

mobile_cover_sound_think()
{
    if ( !isalive( self.linked_player ) )
        return;

    var_0 = common_scripts\utility::spawn_tag_origin();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_0 linkto( self, "", ( 0, 18, 0 ), ( 0, 0, 0 ) );
    var_1 linkto( self, "", ( 0, -18, 0 ), ( 0, 0, 0 ) );
    thread mobile_cover_sound_loop( var_0 );
    thread mobile_cover_sound_loop( var_1 );
    self.linked_player common_scripts\utility::waittill_either( "death", "player_unlinked_from_cover" );
    var_0 delete();
    var_1 delete();
}

mobile_cover_sound_loop( var_0 )
{
    var_0 endon( "death" );
    var_1 = 0.6;
    var_2 = 17.6;
    var_3 = 264.0;
    var_4 = 0.4;
    var_5 = 0.5;
    var_6 = var_0.origin;
    var_7 = 0;

    for (;;)
    {
        waittillframeend;
        var_8 = length( var_0.origin - var_6 ) * 20;
        var_7 = maps\_utility::linear_interpolate( var_1, var_8, var_7 );
        var_6 = var_0.origin;
        var_9 = maps\_shg_utility::linear_map_clamp( var_7, 0, var_3, 0, 1 );
        var_9 = clamp( var_9, 0.002, 3.99 );
        var_0 setpitch( var_9, 0.05 );

        if ( var_7 > var_2 )
            var_0 setvolume( maps\_shg_utility::linear_map_clamp( var_7, 0, var_3, var_4, var_5 ), 0.05 );
        else
            var_0 setvolume( 0, 0.05 );

        waitframe();
    }
}

mobile_cover_impulse()
{
    self endon( "death" );
    var_0 = self.origin;

    for (;;)
    {
        if ( isdefined( self.linked_player ) )
        {
            if ( distance( self.origin, var_0 ) > 6 )
            {
                var_0 = self.origin;
                physicsexplosioncylinder( self.origin, 26, 24, 0.25 );
            }

            wait 0.1;
            continue;
        }

        wait 0.5;
    }
}

enable_weapon_pickup_wrapper()
{
    thread enable_weapon_pickup_wrapper_internal();
}

enable_weapon_pickup_wrapper_internal()
{
    self endon( "death" );
    self endon( "stop_enable_weapon_pickup_wrapper" );
    wait 2;
    maps\_utility::playerallowweaponpickup( 1 );
}

disable_weapon_pickup_wrapper()
{
    self notify( "stop_enable_weapon_pickup_wrapper" );
    maps\_utility::playerallowweaponpickup( 0 );
}

record_grenade_throw_times()
{
    self.last_grenade_throw_time = 0;

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        self.last_grenade_throw_time = gettime();
    }
}

record_grenade_rising_edges()
{
    self.is_really_throwing_grenade_rising_edge_time = 0;
    var_0 = 0;

    for (;;)
    {
        if ( self isthrowinggrenade( 1 ) && !var_0 )
            self.is_really_throwing_grenade_rising_edge_time = gettime();

        var_0 = self isthrowinggrenade( 1 );
        waitframe();
    }
}

is_really_throwing_grenade()
{
    var_0 = 300.0;

    if ( !self isthrowinggrenade( 1 ) )
        return 0;

    if ( self.last_grenade_throw_time > self.is_really_throwing_grenade_rising_edge_time && gettime() - self.last_grenade_throw_time > var_0 )
        return 0;

    return 1;
}
