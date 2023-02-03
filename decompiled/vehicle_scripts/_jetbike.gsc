// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "jetbike", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_mil_hoverbike_ai" );
    maps\_vehicle::build_deathfx( "fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand" );
    maps\_vehicle::build_life( 999, 500, 1500 );

    if ( issubstr( var_2, "slow" ) )
        maps\_vehicle::build_aianims( ::setanims_slow, ::set_vehicle_anims_slow );
    else
        maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );

    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_death_jolt_delay( 9999 );

    if ( !isdefined( level.jetbike_anims_initialized ) )
    {
        setup_worldhands_anims();
        setup_player_driving_anims();
        level.jetbike_anims_initialized = 1;
    }

    precachemodel( "vehicle_mil_hoverbike_vm" );
    precachemodel( "vehicle_mil_hoverbike_ai" );
    precachemodel( "vehicle_mil_hoverbike_ai_obj" );

    if ( level.nextgen )
    {
        precacheshader( "m/mtl_hoverbike_screen_ui_01" );
        precacheshader( "m/mtl_hoverbike_screen_ui_02" );
        precacheshader( "m/mtl_hoverbike_screen_ui_03" );
        precacheshader( "m/mtl_hoverbike_screen_ui_04" );
        precacheshader( "m/mtl_mil_hoverbike_screens_off" );
    }
    else
    {
        precacheshader( "mq/mtl_hoverbike_screen_ui_01" );
        precacheshader( "mq/mtl_hoverbike_screen_ui_02" );
        precacheshader( "mq/mtl_hoverbike_screen_ui_03" );
        precacheshader( "mq/mtl_hoverbike_screen_ui_04" );
        precacheshader( "mq/mtl_mil_hoverbike_screens_off" );
    }

    level._effect["hoverbike_pads_idle"] = loadfx( "vfx/vehicle/hoverbike_pads_idle" );
    level._effect["hoverbike_pads_slow"] = loadfx( "vfx/vehicle/hoverbike_pads_slow" );
    level._effect["hoverbike_pads_fast"] = loadfx( "vfx/vehicle/hoverbike_pads_fast" );
    level._effect["hoverbike_exhaust_idle"] = loadfx( "vfx/vehicle/hoverbike_exhaust_idle" );
    level._effect["hoverbike_exhaust_slow"] = loadfx( "vfx/vehicle/hoverbike_exhaust_slow" );
    level._effect["hoverbike_exhaust_fast"] = loadfx( "vfx/vehicle/hoverbike_exhaust_fast" );
    level._effect["hoverbike_tread_water_idle"] = loadfx( "vfx/treadfx/hoverbike_tread_water_idle" );
    level._effect["hoverbike_tread_water_slow"] = loadfx( "vfx/treadfx/hoverbike_tread_water_slow" );
    level._effect["hoverbike_tread_water_fast"] = loadfx( "vfx/treadfx/hoverbike_tread_water_fast" );
    level._effect["hoverbike_tread_asphalt_idle"] = loadfx( "vfx/treadfx/hoverbike_tread_asphalt_idle" );
    level._effect["hoverbike_tread_asphalt_slow"] = loadfx( "vfx/treadfx/hoverbike_tread_asphalt_slow" );
    level._effect["hoverbike_tread_asphalt_fast"] = loadfx( "vfx/treadfx/hoverbike_tread_asphalt_fast" );
}

jetbike_allow_player_use( var_0 )
{
    self makeunusable();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( self, "tag_origin", ( 0, 0, 64 ), ( 0, 0, 0 ) );
    var_1 sethintstring( &"DETROIT_PROMPT_USE" );
    var_1 makeusable();
    var_1 waittill( "trigger" );
    var_1 delete();
    thread jetbike_allow_player_use_internal( var_0 );
}

jetbike_blend_out_fake_speed( var_0 )
{
    self.blend_out_fake_speed_start_ms = gettime();
    self.blend_out_fake_speed_blend_ms = var_0 * 1000;
}

jetbike_stop_player_use()
{
    stop_jetbike_handle_viewmodel_anims();
    self notify( "player_dismount" );
    level.player dismountvehicle();
    self detach( level.scr_model["world_body"], "tag_driver" );
}

jetbike_speedometer_on()
{
    thread jetbike_speedometer_on_thread();
}

jetbike_speedometer_on_thread()
{
    setomnvar( "ui_hoverbike", 1 );
    wait 0.2;
    level.player setclientomnvar( "ui_hoverbike_bootup", 1 );
    wait 0.2;

    if ( level.nextgen )
    {
        self overridematerial( "m/mtl_mil_hoverbike_screen_center_off", "m/mtl_hoverbike_screen_ui_01" );
        self overridematerial( "m/mtl_mil_hoverbike_screen_right_off", "m/mtl_hoverbike_screen_ui_02" );
        self overridematerial( "m/mtl_mil_hoverbike_screen_top_off", "m/mtl_hoverbike_screen_ui_03" );
        self overridematerial( "m/mtl_mil_hoverbike_lights_off", "m/mtl_hoverbike_screen_ui_04" );
    }
    else
    {
        self overridematerial( "mq/mtl_mil_hoverbike_screen_center_off", "mq/mtl_hoverbike_screen_ui_01" );
        self overridematerial( "mq/mtl_mil_hoverbike_screen_right_off", "mq/mtl_hoverbike_screen_ui_02" );
        self overridematerial( "mq/mtl_mil_hoverbike_screen_top_off", "mq/mtl_hoverbike_screen_ui_03" );
        self overridematerial( "mq/mtl_mil_hoverbike_lights_off", "mq/mtl_hoverbike_screen_ui_04" );
    }

    thread jetbike_speedometer_think();
}

jetbike_speedometer_off()
{
    self notify( "jetbike_speedometer_off" );
    level.player setclientomnvar( "ui_hoverbike_bootup", 0 );
    setomnvar( "ui_hoverbike", 0 );
    self overridematerialreset();
}

jetbike_speedometer_think()
{
    self endon( "jetbike_speedometer_off" );

    for (;;)
    {
        waittillframeend;

        if ( isdefined( self.fakespeed ) )
            var_0 = self.fakespeed;
        else
            var_0 = maps\_shg_utility::get_differentiated_speed() / 17.6;

        var_0 *= 1.39683;
        var_1 = int( clamp( abs( var_0 ), 0, 100 ) );
        level.player setclientomnvar( "ui_hoverbike_speed", var_1 );
        waitframe();
    }
}

create_anim_ent_for_my_position( var_0 )
{
    if ( isstring( var_0 ) )
        var_0 = maps\_utility::getanim( var_0 );

    var_1 = getstartorigin( ( 0, 0, 0 ), ( 0, 0, 0 ), var_0 );
    var_2 = getstartangles( ( 0, 0, 0 ), ( 0, 0, 0 ), var_0 );
    var_3 = transformmove( self.origin, self.angles, var_1, var_2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_4 = spawnstruct();
    var_4.origin = var_3["origin"];
    var_4.angles = var_3["angles"];
    return var_4;
}

smooth_vehicle_animation_wait( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = var_0 maps\_utility::getanim( var_2 );
    var_6 = getstartorigin( var_1.origin, var_1.angles, var_5 );
    var_7 = getstartangles( var_1.origin, var_1.angles, var_5 );

    if ( isdefined( var_4 ) )
    {

    }
    else
        var_4 = 1.0;

    var_8 = var_0.origin + ( var_6 - var_0.origin ) * var_4;
    var_0 vehicledriveto( var_8, var_3 );
    var_9 = var_6 - var_0.origin;
    var_10 = vectordot( var_9, var_6 - var_0.origin );
    var_11 = var_0 vehicle_getspeed();

    if ( vectordot( vectornormalize( var_9 ), anglestoforward( var_0.angles ) ) > cos( 75 ) )
    {
        for (;;)
        {
            var_12 = vectordot( var_9, var_6 - var_0.origin );

            if ( var_12 <= 0 )
                break;

            var_13 = maps\_utility::linear_interpolate( var_12 / var_10, var_3, var_11 );
            var_0 vehicledriveto( var_8, var_13 );
            wait 0.05;
        }
    }
    else
    {

    }
}

smooth_vehicle_animation_play( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_3 ) )
        var_3 = [];

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 2;

    var_6 = var_5 * 0.5;
    var_7 = var_0 maps\_utility::getanim( var_2 );
    var_8 = getstartorigin( var_1.origin, var_1.angles, var_7 );
    var_9 = getstartangles( var_1.origin, var_1.angles, var_7 );
    var_10 = transformmove( var_0.origin, var_0.angles, var_8, var_9, var_1.origin, var_1.angles );
    var_11 = level common_scripts\utility::spawn_tag_origin();
    var_11.origin = var_10["origin"];
    var_11.angles = var_10["angles"];
    var_12 = level common_scripts\utility::spawn_tag_origin();
    var_12.origin = var_0.origin;
    var_12.angles = var_0.angles;
    var_0 linkto( var_11, "tag_origin" );

    foreach ( var_14 in var_3 )
        var_14 linkto( var_11, "tag_origin" );

    var_11 linkto( var_12, "tag_origin" );
    var_12 moveto( var_8, var_5, var_5 * 0.3, var_5 * 0.3 );
    var_12 rotateto( var_9, var_6, var_6 * 0.3, var_6 * 0.3 );
    var_16 = getanimlength( var_7 );

    if ( var_4 )
        var_11 maps\_utility::delaythread( var_16 - 0.05, maps\_anim::anim_set_rate, [ var_0 ], var_2, 0 );

    foreach ( var_14 in var_3 )
    {

    }

    var_11 thread maps\_anim::anim_single_solo( var_0, var_2, "tag_origin" );
    var_11 thread maps\_anim::anim_single( var_3, var_2, "tag_origin" );
    wait(var_16);

    foreach ( var_14 in var_3 )
    {
        if ( isdefined( var_14 ) )
            var_14 unlink();
    }

    if ( !var_4 )
    {
        var_0 unlink();
        var_11 delete();
        var_12 delete();
    }
}

jetbike_allow_player_use_internal( var_0 )
{
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    var_1 = maps\_utility::spawn_anim_model( "world_body" );
    var_1 hide();
    var_2 = 0.5;
    level.player playerlinktoblend( var_1, "tag_player", var_2, var_2 * 0.3, var_2 * 0.3 );
    level.player common_scripts\utility::delaycall( var_2, ::playerlinktodelta, var_1, "tag_player", 1, 20, 20, 10, 10, 1 );
    var_3 = 1;
    var_4 = getanimlength( var_1 maps\_utility::getanim( "mount_jetbike" ) );
    level.player common_scripts\utility::delaycall( var_4 - var_3, ::lerpviewangleclamp, var_3, var_3 * 0.5, var_3 * 0.5, 0, 0, 0, 0 );
    var_1 common_scripts\utility::delaycall( var_2, ::show );
    var_5 = [ var_1, self ];

    if ( !isdefined( var_0 ) )
        var_0 = maps\_utility::getanim( "mount_jetbike" );

    var_6 = create_anim_ent_for_my_position( var_0 );
    var_6 maps\_anim::anim_single( var_5, "mount_jetbike" );
    var_1 delete();
    self attach( level.scr_model["world_body"], "tag_driver" );
    level.player.attackeraccuracy = 0;
    self stopanimscripted();
    level.player mountvehicle( self );
    level.player.drivingvehicle = self;
    self vehicle_jetbikesethoverforcescale( 1 );
    maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    level.player enablemousesteer( 1 );
    self returnplayercontrol();
    thread jetbike_player_think();
}

jetbike_handle_fake_speed()
{
    self endon( "death" );
    level.player endon( "death" );
    self endon( "player_dismount" );
    level endon( "stop hovering player bike" );
    self.boost_timer = 0;
    var_0 = 5;
    var_1 = 1;
    var_2 = 20;
    var_3 = 2;
    var_4 = 0.5;
    var_5 = 20;
    var_6 = 5;
    var_7 = 1;
    var_8 = 1;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;

    for (;;)
    {
        var_13 = 0;
        var_14 = var_13 && !var_10;
        var_10 = var_13;

        if ( !var_9 && var_14 && var_8 > 0 )
            var_9 = 1;

        if ( var_9 && !var_13 )
            var_9 = 0;

        if ( var_9 )
            var_8 -= 0.05 / var_0;
        else
            var_8 += 0.05 / var_1;

        if ( var_8 < 0 )
            var_9 = 0;

        var_8 = clamp( var_8, 0, 1 );

        if ( var_9 )
        {
            var_15 = maps\_shg_utility::linear_map_clamp( self vehicle_getspeed(), 15, 65, 3, 1 );
            self.boost_timer += 0.05;
            var_11 += 0.05 / var_3;
            self vehicle_jetbikesetthrustscale( var_15 );
            self vehicle_jetbikesethoverforcescale( 0.75 );
        }
        else
        {
            self.boost_timer = 0;
            var_11 -= 0.05 / var_4;
            self vehicle_jetbikesetthrustscale( 1 );
            self vehicle_jetbikesethoverforcescale( 1 );
        }

        if ( level.player getnormalizedmovement()[0] > 0.75 )
            var_12 += 0.05 / var_6;
        else
            var_12 -= 0.05 / var_7;

        var_11 = clamp( var_11, 0, 1 );
        var_12 = clamp( var_12, 0, 1 );
        var_16 = self vehicle_getspeed() + var_11 * var_2 + var_12 * var_5;
        vehicle_set_fake_speed( var_16 );
        wait 0.05;
    }
}

vehicle_set_fake_speed( var_0 )
{
    if ( var_0 == 0 )
        self.fakespeed = undefined;
    else
        self.fakespeed = var_0;

    if ( isdefined( self.blend_out_fake_speed_start_ms ) )
    {
        var_1 = gettime() - self.blend_out_fake_speed_start_ms;
        var_2 = maps\_shg_utility::linear_map_clamp( var_1, 0, self.blend_out_fake_speed_blend_ms, 1, 0.0001 );
    }
    else
        var_2 = 1;

    self vehicle_setfakespeed( var_0 * var_2 );
}

jetbike_handle_viewmodel_anims()
{
    self endon( "death" );
    self endon( "stop_jetbike_handle_viewmodel_anims" );
    var_0 = 0.6;
    var_1 = 0;
    var_2 = 0.5;
    var_3 = 0.7;
    var_4 = 0.8;
    var_5 = 0.1;
    var_6 = 0.4;
    var_7 = 0.1;
    var_8 = 0;
    var_9 = 0.35;
    var_10 = 0.3;
    var_11 = getanimlength( level.scr_anim["frankenbike_worldbody"]["jump_end"] ) - var_10;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;

    for (;;)
    {
        waittillframeend;
        var_23 = 0 - level.player getnormalizedcameramovements()[1] * 1.00794;
        var_19 = maps\_utility::linear_interpolate( var_3, var_23, var_19 );
        var_24 = ( var_19 - var_20 ) * 20;
        var_20 = var_19;
        var_21 = maps\_utility::linear_interpolate( var_4, var_24, var_21 );
        var_25 = clamp( var_19 - var_21 * var_1, -1, 1 );
        var_26 = self vehicle_getspeed();

        if ( isdefined( self.fakespeed ) )
            var_26 = self.fakespeed;

        var_27 = maps\_shg_utility::linear_map_clamp( var_26, 15, 80, 0, 1 );
        var_28 = clamp( level.player getnormalizedmovement()[0] * 1.00794, 0, 1 );
        var_22 = maps\_utility::linear_interpolate( var_2, var_28, var_22 );
        var_29 = var_22;
        var_30 = clamp( 1 - max( var_27, var_29 ), 0, 1 );
        var_31 = var_27;
        var_32 = self vehicle_jetbikegettotalrepulsorfraction() > 1.7;
        var_33 = self vehicle_jetbikegettotalrepulsorfraction() < 0.7;
        var_34 = 0;
        var_35 = 0;

        if ( var_33 )
        {
            var_13 += 0.05;
            var_14 = 0;
        }
        else
        {
            var_13 = 0;
            var_14 += 0.05;
        }

        if ( var_32 )
            var_12 += 0.05;
        else
            var_12 = 0;

        if ( !var_16 && !var_17 && var_12 > var_5 )
        {
            soundscripts\_snd::snd_message( "jetbike_hit_ramp" );
            var_16 = 1;
            var_34 = 1;
        }

        if ( !var_16 && !var_17 && !var_32 && var_13 > var_9 )
        {
            soundscripts\_snd::snd_message( "jetbike_hit_cliff" );
            var_16 = 1;
            var_35 = 1;
            var_15 = var_6;
        }

        if ( var_16 && var_15 > var_6 && var_12 > var_8 )
        {
            soundscripts\_snd::snd_message( "jetbike_hit_landing" );
            var_16 = 0;
            var_17 = 1;
        }

        if ( var_16 && var_15 > var_6 && var_14 > var_7 )
        {
            soundscripts\_snd::snd_message( "jetbike_soft_landing" );
            var_16 = 0;
        }

        if ( var_18 > var_11 )
        {
            soundscripts\_snd::snd_message( "jetbike_landing_finished" );
            var_17 = 0;
        }

        if ( var_16 )
            var_15 += 0.05;
        else
            var_15 = 0;

        if ( var_17 )
            var_18 += 0.05;
        else
            var_18 = 0;

        if ( isdefined( self.blend_out_fake_speed_start_ms ) )
        {
            var_36 = gettime() - self.blend_out_fake_speed_start_ms;
            var_37 = maps\_shg_utility::linear_map_clamp( var_36, 0, self.blend_out_fake_speed_blend_ms, 1, 0 );
            var_16 = 0;
            var_34 = 0;
            var_35 = 0;
            var_17 = 0;
            var_30 = maps\_utility::linear_interpolate( var_37, 0, var_30 );
            var_38 = maps\_utility::linear_interpolate( var_37, 0, var_25 );
            var_31 = maps\_utility::linear_interpolate( var_37, 1, var_31 );
            var_10 = 0;
        }

        jetbike_set_viewmodel_state( var_16, var_34, var_35, var_17, var_30, var_25, var_31, var_10 );
        wait 0.05;
    }
}

stop_jetbike_handle_viewmodel_anims()
{
    self notify( "stop_jetbike_handle_viewmodel_anims" );

    foreach ( var_1 in [ "frankenbike_jetbike", "frankenbike_worldbody" ] )
        self clearanim( level.scr_anim[var_1]["branch"], 0.2 );
}

getanimtimeseconds( var_0 )
{
    return self getanimtime( var_0 ) * getanimlength( var_0 );
}

getanimtimeremainingseconds( var_0 )
{
    return ( 1 - self getanimtime( var_0 ) ) * getanimlength( var_0 );
}

jetbike_set_viewmodel_state( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = 0.2;
    var_9 = 0.2;
    var_10 = 1;
    var_11 = 0.2;
    var_12 = 0.05;
    var_13 = clamp( var_5, 0, 1 );
    var_14 = clamp( 0 - var_5, 0, 1 );
    var_15 = clamp( 1 - abs( var_5 ), 0, 1 );

    foreach ( var_17 in [ "frankenbike_jetbike", "frankenbike_worldbody" ] )
    {
        self setanimlimited( level.scr_anim[var_17]["idle_slow_branch"], var_4, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast_branch"], 1 - var_4, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_slow"], var_15, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_slow_lt"], var_13, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_slow_rt"], var_14, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast_throttle"], 1 - var_6, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast_direction_branch"], var_6, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast"], var_15, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast_lt"], var_13, var_12 );
        self setanimlimited( level.scr_anim[var_17]["idle_fast_rt"], var_14, var_12 );

        if ( var_0 )
        {
            if ( var_1 )
                self setanimknob( level.scr_anim[var_17]["jump_st"], 1, var_8 );
            else if ( var_2 )
                self setanimknob( level.scr_anim[var_17]["jump_loop"], 1, var_10 );
            else if ( getanimtimeremainingseconds( level.scr_anim[var_17]["jump_st"] ) < var_9 )
                self setanimknob( level.scr_anim[var_17]["jump_loop"], 1, var_9 );

            continue;
        }

        if ( var_3 )
        {
            self setanimknob( level.scr_anim[var_17]["jump_end"], 1, var_11 );
            continue;
        }

        self setanimknob( level.scr_anim[var_17]["idle_branch"], 1, var_7 );
    }
}

debug_tags()
{
    for (;;)
    {
        if ( self gettagindex( "tag_camera" ) != -1 )
        {

        }

        waitframe();
    }
}

jetbike_dismount_riding_player()
{
    jetbike_stop_hovering();
    wait 1;
    self setmodel( "vehicle_mil_hoverbike_ai" );
    var_0 = 0.5;
    level.player lerpfov( 65, var_0 );
    var_1 = level.player common_scripts\utility::spawn_tag_origin();
    level.player playerlinkto( var_1 );
    var_1 moveto( self gettagorigin( "tag_detach" ), var_0 );
    wait(var_0);
    level.player unlink();
    level.player enableweapons();
    level.player allowcrouch( 1 );
    self makeunusable();
}

jetbike_start_hovering()
{
    maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    self vehicle_jetbikesethoverforcescale( 0.6, 0 );
    self vehicle_jetbikesethoverforcescale( 1, 1.5 );
    wait 1;
}

jetbike_start_hovering_now()
{
    maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    self vehicle_jetbikesethoverforcescale( 1 );
}

jetbike_stop_hovering()
{
    maps\_utility::ent_flag_clear( "jetbike_is_hovering" );
    self vehicle_jetbikesethoverforcescale( 0, 5 );
}

jetbike_stop_hovering_now()
{
    maps\_utility::ent_flag_clear( "jetbike_is_hovering" );
    self vehicle_jetbikesethoverforcescale( 0 );
}

jetbike_player_think()
{
    thread jetbike_handle_viewmodel_anims();
    thread jetbike_handle_fake_speed();
    self.saved_bg_viewbobmax = getdvarfloat( "bg_viewBobMax" );
    setsaveddvar( "bg_viewBobMax", 0 );
    thread vehicle_handle_debugfly();
    thread collision_watcher();
}

jetbike_stop_player_think()
{
    self notify( "player_dismount" );
    setsaveddvar( "bg_viewBobMax", self.saved_bg_viewbobmax );
}

jetbike_npc_load( var_0, var_1 )
{
    var_1 vehicle_jetbikesethoverforcescale( 0 );
    maps\_utility::guy_runtovehicle_load( var_0, var_1 );
    var_2 = 1;
    var_1 vehicle_jetbikesethoverforcescale( 0.75 );
    var_1 vehicle_jetbikesethoverforcescale( 1, var_2 );
    maps\_utility::ent_flag_set( "jetbike_is_hovering" );
    wait(var_2);
    var_1 thread stop_hovering_on_unload();
}

notify_wrapper( var_0 )
{
    self notify( var_0 );
}

stop_hovering_on_unload()
{
    self endon( "death" );
    self waittill( "unloading" );
    self vehicle_jetbikesethoverforcescale( 0, 2 );
    maps\_utility::ent_flag_clear( "jetbike_is_hovering" );
}

init_local()
{
    maps\_utility::ent_flag_init( "jetbike_is_hovering" );
    thread jetbike_audio();
    thread jetbike_tread_fx();
    thread jetbike_thrust_fx();
}

jetbike_audio()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0.player_mode = 0;
    var_0.preset_name = "jetbike";
    var_1 = vehicle_scripts\_jetbike_aud::jetbike_constructor;

    if ( issubstr( self.classname, "jetbike_rail" ) || issubstr( self.classname, "jetbike_player" ) )
        var_0.player_mode = 1;

    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );
    var_2 = 3.0;
    var_3 = 0;

    for (;;)
    {
        maps\_utility::ent_flag_wait( "jetbike_is_hovering" );
        soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
        maps\_utility::ent_flag_waitopen( "jetbike_is_hovering" );
        soundscripts\_snd::snd_message( "snd_stop_vehicle", var_2, var_3 );
    }
}

jetbike_tread_fx()
{
    self endon( "death" );
    self notify( "only_one_jetbike_tread_fx" );
    self endon( "only_one_jetbike_tread_fx" );
    wait(randomfloat( 0.3 ));

    for (;;)
    {
        maps\_utility::ent_flag_wait( "jetbike_is_hovering" );
        var_0 = self.origin + anglestoup( self.angles ) * 32;
        var_1 = self.origin + anglestoup( self.angles ) * -32;
        var_2 = bullettrace( var_0, var_1, 0, self );

        if ( var_2["fraction"] < 1 && var_2["fraction"] > 0 )
        {
            var_3 = var_2["position"];
            var_4 = var_2["normal"];
            var_5 = anglestoforward( self.angles );
            var_6 = maps\_shg_utility::get_differentiated_speed() / 17.6;

            switch ( var_2["surfacetype"] )
            {
                case "water_waist":
                    if ( var_6 < 1 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_water_idle" ), var_3, var_4, var_5 );
                    else if ( var_6 < 25 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_water_slow" ), var_3, var_4, var_5 );
                    else
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_water_fast" ), var_3, var_4, var_5 );

                    break;
                case "asphalt_wet":
                    if ( var_6 < 1 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_idle" ), var_3, var_4, var_5 );
                    else if ( var_6 < 20 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_slow" ), var_3, var_4, var_5 );
                    else
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_fast" ), var_3, var_4, var_5 );

                    break;
                default:
                    if ( var_6 < 1 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_idle" ), var_3, var_4, var_5 );
                    else if ( var_6 < 20 )
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_slow" ), var_3, var_4, var_5 );
                    else
                        playfx( common_scripts\utility::getfx( "hoverbike_tread_asphalt_fast" ), var_3, var_4, var_5 );

                    break;
            }
        }

        if ( maps\_vehicle_code::tread_wait() <= 0 )
            wait 0.1;
    }
}

jetbike_thrust_fx()
{
    thread jetbike_thrust_fx_internal( "hoverbike_pads_", "tag_pad_br" );
    thread jetbike_thrust_fx_internal( "hoverbike_pads_", "tag_pad_fr" );
    thread jetbike_thrust_fx_internal( "hoverbike_pads_", "tag_pad_fl" );
    thread jetbike_thrust_fx_internal( "hoverbike_exhaust_", "tag_exhaust" );
}

jetbike_thrust_fx_internal( var_0, var_1 )
{
    self endon( "death" );
    wait(randomfloat( 0.3 ));
    var_2 = undefined;
    var_3 = undefined;

    for (;;)
    {
        var_4 = undefined;

        if ( maps\_utility::ent_flag( "jetbike_is_hovering" ) )
        {
            var_5 = maps\_shg_utility::get_differentiated_speed() / 17.6;

            if ( var_5 > 20 )
                var_4 = "fast";
            else if ( var_5 > 1 )
                var_4 = "slow";
            else
                var_4 = "idle";
        }

        if ( !isdefined( var_4 ) || isdefined( var_3 ) && var_3 != var_4 )
        {
            if ( isdefined( var_2 ) )
            {
                maps\_shg_utility::kill_fx_with_handle( var_2 );
                var_2 = undefined;
            }

            var_3 = undefined;
        }

        if ( isdefined( var_4 ) && !isdefined( var_3 ) )
        {
            var_2 = maps\_shg_utility::play_fx_with_handle( var_0 + var_4, self, var_1, 1 );
            var_3 = var_4;
        }

        if ( !isdefined( var_3 ) && !maps\_utility::ent_flag( "jetbike_is_hovering" ) )
            maps\_utility::ent_flag_wait( "jetbike_is_hovering" );

        wait 0.05;
    }
}

setanims_slow()
{
    return setanims( 1 );
}

#using_animtree("generic_human");

setanims( var_0 )
{
    var_1[0] = spawnstruct();
    var_1[0].sittag = "tag_driver";
    var_1[0].getin = %hoverbike_mount_driver_dir1;
    var_1[0].getout = %hoverbike_dismount_driver;

    if ( isdefined( var_0 ) && var_0 )
        var_1[0].idle = %hoverbike_driving_idle_guy1;
    else
        var_1[0].idle = %hoverbike_driving_idle_npc;

    var_1[0].aianim_simple["hoverbike_driving_flashlight_left_1"] = %hoverbike_driving_flashlight_left_guy1;
    var_1[0].aianim_simple["hoverbike_driving_flashlight_left_2"] = %hoverbike_driving_flashlight_left_guy2;
    var_1[0].aianim_simple["hoverbike_driving_flashlight_right_1"] = %hoverbike_driving_flashlight_right_guy1;
    var_1[0].aianim_simple["hoverbike_driving_flashlight_right_2"] = %hoverbike_driving_flashlight_right_guy2;
    var_1[0].aianim_simple["hoverbike_driving_gesture_lft_1"] = %hoverbike_driving_gesture_lft_guy1;
    var_1[0].aianim_simple["hoverbike_driving_gesture_lft_2"] = %hoverbike_driving_gesture_lft_guy2;
    var_1[0].aianim_simple["hoverbike_driving_gesture_rt_1"] = %hoverbike_driving_gesture_rt_guy1;
    var_1[0].aianim_simple["hoverbike_driving_gesture_rt_2"] = %hoverbike_driving_gesture_rt_guy2;
    var_1[0].aianim_simple["hoverbike_driving_idle_1"] = %hoverbike_driving_idle_guy1;
    var_1[0].aianim_simple["hoverbike_driving_idle_2"] = %hoverbike_driving_idle_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_idle_1"] = %hoverbike_driving_lean_left_idle_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_idle_2"] = %hoverbike_driving_lean_left_idle_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_into_1"] = %hoverbike_driving_lean_left_into_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_into_2"] = %hoverbike_driving_lean_left_into_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_out_1"] = %hoverbike_driving_lean_left_out_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_left_out_2"] = %hoverbike_driving_lean_left_out_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_idle_1"] = %hoverbike_driving_lean_right_idle_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_idle_2"] = %hoverbike_driving_lean_right_idle_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_into_1"] = %hoverbike_driving_lean_right_into_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_into_2"] = %hoverbike_driving_lean_right_into_guy2;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_out_1"] = %hoverbike_driving_lean_right_out_guy1;
    var_1[0].aianim_simple["hoverbike_driving_lean_right_out_2"] = %hoverbike_driving_lean_right_out_guy2;
    var_1[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_1"] = %hoverbike_driving_look_over_lft_shoulder_guy1;
    var_1[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_2"] = %hoverbike_driving_look_over_lft_shoulder_guy2;
    var_1[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_1"] = %hoverbike_driving_look_over_rt_shoulder_guy1;
    var_1[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_2"] = %hoverbike_driving_look_over_rt_shoulder_guy2;
    return var_1;
}

set_vehicle_anims_slow( var_0 )
{
    return set_vehicle_anims( var_0, 1 );
}

#using_animtree("vehicles");

set_vehicle_anims( var_0, var_1 )
{
    if ( isdefined( var_1 ) && var_1 )
        var_0[0].vehicle_idle = %hoverbike_driving_idle_vehicle1;
    else
        var_0[0].vehicle_idle = %hoverbike_driving_idle_vehicle;

    var_0[0].aianim_simple_vehicle["hoverbike_driving_flashlight_left_1"] = %hoverbike_driving_flashlight_left_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_flashlight_left_2"] = %hoverbike_driving_flashlight_left_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_flashlight_right_1"] = %hoverbike_driving_flashlight_right_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_flashlight_right_2"] = %hoverbike_driving_flashlight_right_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_gesture_lft_1"] = %hoverbike_driving_gesture_lft_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_gesture_lft_2"] = %hoverbike_driving_gesture_lft_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_gesture_rt_1"] = %hoverbike_driving_gesture_rt_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_gesture_rt_2"] = %hoverbike_driving_gesture_rt_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_idle_1"] = %hoverbike_driving_idle_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_idle_2"] = %hoverbike_driving_idle_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_idle_1"] = %hoverbike_driving_lean_left_idle_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_idle_2"] = %hoverbike_driving_lean_left_idle_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_into_1"] = %hoverbike_driving_lean_left_into_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_into_2"] = %hoverbike_driving_lean_left_into_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_out_1"] = %hoverbike_driving_lean_left_out_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_left_out_2"] = %hoverbike_driving_lean_left_out_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_idle_1"] = %hoverbike_driving_lean_right_idle_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_idle_2"] = %hoverbike_driving_lean_right_idle_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_into_1"] = %hoverbike_driving_lean_right_into_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_into_2"] = %hoverbike_driving_lean_right_into_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_out_1"] = %hoverbike_driving_lean_right_out_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_lean_right_out_2"] = %hoverbike_driving_lean_right_out_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_look_over_lft_shoulder_1"] = %hoverbike_driving_look_over_lft_shoulder_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_look_over_lft_shoulder_2"] = %hoverbike_driving_look_over_lft_shoulder_vehicle2;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_look_over_rt_shoulder_1"] = %hoverbike_driving_look_over_rt_shoulder_vehicle1;
    var_0[0].aianim_simple_vehicle["hoverbike_driving_look_over_rt_shoulder_2"] = %hoverbike_driving_look_over_rt_shoulder_vehicle2;
    return var_0;
}

#using_animtree("player");

setup_worldhands_anims()
{
    level.scr_anim["world_body"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vm;
    level.scr_anim["world_body"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
    level.scr_anim["world_body"]["mount_jetbike"] = %det_exfil_droponbike_drop_vm;
    maps\_anim::addnotetrack_customfunction( "world_body", "bike_swap", ::level_jetbike_to_vm_model, "mount_jetbike" );
    maps\_anim::addnotetrack_notify( "world_body", "fov_start", "exit_drive_FOV_start", "mount_jetbike" );
    maps\_anim::addnotetrack_notify( "world_body", "fov_end", "exit_drive_FOV_end", "mount_jetbike" );
    maps\_anim::addnotetrack_notify( "world_body", "on_button", "exit_drive_on_button_pressed", "mount_jetbike" );
}

#using_animtree("vehicles");

setup_player_driving_anims()
{
    level.scr_anim["frankenbike_jetbike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
    level.scr_anim["frankenbike_worldbody"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
    level.scr_anim["frankenbike_jetbike"]["branch"] = %hoverbike_vehicle_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_branch"] = %hoverbike_vehicle_idle_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_branch"] = %hoverbike_vehicle_idle_slow_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_slow"] = %hoverbike_drive_idle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_branch"] = %hoverbike_vehicle_idle_fast_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_direction_branch"] = %hoverbike_vehicle_idle_fast_direction_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_fast"] = %hoverbike_drive_fast_idle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_st"] = %hoverbike_drive_jump_st_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_loop"] = %hoverbike_drive_jump_loop_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_end"] = %hoverbike_drive_jump_end_vehicle;
    level.scr_anim["frankenbike_worldbody"]["branch"] = %hoverbike_vm_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_branch"] = %hoverbike_vm_idle_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_branch"] = %hoverbike_vm_idle_slow_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_slow"] = %hoverbike_drive_idle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_branch"] = %hoverbike_vm_idle_fast_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_direction_branch"] = %hoverbike_vm_idle_fast_direction_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_fast"] = %hoverbike_drive_fast_idle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_st"] = %hoverbike_drive_jump_st_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_loop"] = %hoverbike_drive_jump_loop_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_end"] = %hoverbike_drive_jump_end_vm;
    level.scr_anim["player_bike"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vehicle;
    level.scr_anim["player_bike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
    level.scr_anim["player_bike"]["mount_jetbike"] = %det_exfil_droponbike_drop_vmbike;
}

vehicle_handle_debugfly()
{

}

project_into_plane( var_0, var_1 )
{
    var_1 = vectornormalize( var_1 );
    return var_0 - var_1 * vectordot( var_1, var_0 );
}

collision_watcher()
{
    self endon( "player_dismount" );
    childthread contact_watcher();
    childthread accel_watcher();
    childthread stop_hovering_on_player_death();
}

jetbike_collision_hit_func( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = length( var_4 );
    var_7 = [];
    var_7["none"] = common_scripts\utility::getfx( "car_contact_spark_sml" );
    var_7["asphalt"] = common_scripts\utility::getfx( "car_contact_asphalt_sml" );
    var_7["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_sml" );
    var_7["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_sml" );
    var_7["water"] = common_scripts\utility::getfx( "veh_collision_water" );
    var_7["metal"] = common_scripts\utility::getfx( "veh_collision_water" );
    var_8 = [];
    var_8["none"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["bark"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["brick"] = common_scripts\utility::getfx( "car_contact_spark_med" );
    var_8["asphalt"] = common_scripts\utility::getfx( "veh_collision_wet_asphalt" );
    var_8["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_med" );
    var_8["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_med" );
    var_8["water"] = common_scripts\utility::getfx( "veh_collision_water" );
    var_8["metal"] = common_scripts\utility::getfx( "veh_collision_water" );
    var_9 = [];
    var_9["none"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["bark"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["brick"] = common_scripts\utility::getfx( "car_contact_spark_lrg" );
    var_9["asphalt"] = common_scripts\utility::getfx( "veh_collision_wet_asphalt" );
    var_9["concrete"] = common_scripts\utility::getfx( "car_contact_concrete_lrg" );
    var_9["dirt"] = common_scripts\utility::getfx( "car_contact_dirt_lrg" );
    var_9["water"] = common_scripts\utility::getfx( "veh_collision_water" );
    var_9["metal"] = common_scripts\utility::getfx( "veh_collision_water" );

    if ( var_6 > 600 )
    {
        if ( isdefined( var_5 ) && isdefined( var_9[var_5] ) )
            playfx( var_9[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "car_contact_spark_lrg" ), var_2 );
    }

    if ( var_6 > 300 )
    {
        if ( isdefined( var_5 ) && isdefined( var_8[var_5] ) )
            playfx( var_8[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "veh_collision_wet_asphalt" ), var_2 );
    }
    else if ( var_6 > 100 )
    {
        if ( isdefined( var_5 ) && isdefined( var_7[var_5] ) )
            playfx( var_7[var_5], var_2 );
        else
            playfx( common_scripts\utility::getfx( "car_contact_spark_sml" ), var_2 );
    }
}

non_player_contact_watcher()
{
    for (;;)
    {
        self waittill( "veh_contact", var_0, var_1, var_2, var_3, var_4 );
        jetbike_collision_hit_func( self, var_0, var_1, var_2, var_3, var_4 );
    }
}

contact_watcher()
{
    var_0 = 50;
    var_1 = 200;
    var_2 = 50;
    var_3 = 0.5;

    for (;;)
    {
        self waittill( "veh_contact", var_4, var_5, var_6, var_7, var_8 );
        var_9 = [];
        var_9["vehicle"] = self;
        var_9["hit_entity"] = var_4;
        var_9["pos"] = var_5;
        var_9["impulse"] = var_6;
        var_9["relativeVel"] = var_7;
        var_9["surface"] = var_8;
        soundscripts\_snd::snd_message( "aud_impact_system_jetbike", var_9 );
        var_10 = length( var_6 );
        var_11 = length( project_into_plane( var_6, anglestoup( self.angles ) ) );

        if ( var_11 > var_0 )
        {

        }

        if ( var_11 > 100 )
            level.player playrumbleonentity( "damage_heavy" );

        jetbike_collision_hit_func( self, var_4, var_5, var_6, var_7, var_8 );
    }
}

accel_watcher()
{
    var_0 = 4825.0;
    var_1 = 14475.0;

    for (;;)
    {
        waitframe();
        var_2 = project_into_plane( maps\_shg_utility::get_differentiated_acceleration(), anglestoup( self.angles ) );
        var_3 = project_into_plane( var_2, ( 0, 0, 1 ) );
        var_4 = length( var_3 );
        var_5 = maps\_shg_utility::linear_map_clamp( var_4, var_0, var_1, 0, 350 );

        if ( var_5 > 0 )
        {
            if ( var_5 > level.player.health )
            {

            }

            level.player dodamage( var_5, self.origin, self, level.player, "MOD_CRUSH" );
        }
    }
}

stop_hovering_on_player_death()
{
    level.player waittill( "death" );
    self vehicle_jetbikesethoverforcescale( 0 );
    maps\_utility::ent_flag_clear( "jetbike_is_hovering" );
}

angles_clamp_180( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

angle_lerp( var_0, var_1, var_2 )
{
    return angleclamp( var_0 + angleclamp180( var_1 - var_0 ) * var_2 );
}

angles_lerp( var_0, var_1, var_2 )
{
    return ( angle_lerp( var_0[0], var_1[0], var_2 ), angle_lerp( var_0[1], var_1[1], var_2 ), angle_lerp( var_0[2], var_1[2], var_2 ) );
}

level_jetbike_to_vm_model( var_0 )
{
    level.jetbike setmodel( "vehicle_mil_hoverbike_vm" );
}
