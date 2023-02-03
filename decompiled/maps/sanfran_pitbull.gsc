// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("player");

player_pitbull_init( var_0 )
{
    precachemodel( "vehicle_vm_pitbull" );
    precache_lui_event_strings();
    level._effect["ui_pitbulltur_target"] = loadfx( "vfx/ui/ui_pitbulltur_target" );

    if ( isdefined( var_0 ) )
    {
        level.scr_anim[var_0]["cockpit_idle"] = %pitbull_cockpit_idle_vm;
        level.scr_anim[var_0]["cockpit_shake_cam"] = %pitbull_cockpit_idle_vm_cam;
        level.scr_anim[var_0]["cockpit_static_idle"] = %pitbull_cockpit_static_idle_vm;
        level.scr_anim[var_0]["cockpit_static_idle_cam"] = %pitbull_cockpit_static_idle_vm_cam;
        level.scr_anim[var_0]["center2left"] = %pitbull_cockpit_turn_center_to_l_vm;
        level.scr_anim[var_0]["center2left_cam"] = %pitbull_cockpit_turn_center_to_l_vm_cam;
        level.scr_anim[var_0]["center2right"] = %pitbull_cockpit_turn_center_to_r_vm;
        level.scr_anim[var_0]["center2right_cam"] = %pitbull_cockpit_turn_center_to_r_vm_cam;
        level.scr_anim[var_0]["left2center"] = %pitbull_cockpit_turn_l_to_center_vm;
        level.scr_anim[var_0]["left2center_cam"] = %pitbull_cockpit_turn_l_to_center_vm_cam;
        level.scr_anim[var_0]["right2center"] = %pitbull_cockpit_turn_r_to_center_vm;
        level.scr_anim[var_0]["right2center_cam"] = %pitbull_cockpit_turn_r_to_center_vm_cam;
        level.scr_anim[var_0]["accelerate"] = %pitbull_cockpit_accelerate_vm;
        level.scr_anim[var_0]["decelerate"] = %pitbull_cockpit_decelerate_vm;
        level.scr_anim[var_0]["accelerate_cam"] = %pitbull_cockpit_accelerate_vm_cam;
        level.scr_anim[var_0]["accelerate2idle_cam"] = %pitbull_cockpit_accelerate_to_idle_vm_cam;
        level.scr_anim[var_0]["decelerate_cam"] = %pitbull_cockpit_decelerate_vm_cam;
        level.scr_anim[var_0]["gear_up"] = %pitbull_cockpit_gear_up_vm;
        level.scr_anim[var_0]["gear_down"] = %pitbull_cockpit_gear_down_vm;
    }

    thread load_pitbull_animations();
}

#using_animtree("script_model");

load_pitbull_animations()
{
    level.scr_animtree["_pitbull"] = #animtree;
    level.scr_model["_pitbull"] = "vehicle_vm_pitbull";
    level.scr_anim["_pitbull"]["cockpit_idle"] = %pitbull_cockpit_idle;
    level.scr_anim["_pitbull"]["cockpit_static_idle"] = %pitbull_cockpit_static_idle;
    level.scr_anim["_pitbull"]["center2left"] = %pitbull_cockpit_turn_center_to_l;
    level.scr_anim["_pitbull"]["center2right"] = %pitbull_cockpit_turn_center_to_r;
    level.scr_anim["_pitbull"]["left2center"] = %pitbull_cockpit_turn_l_to_center;
    level.scr_anim["_pitbull"]["right2center"] = %pitbull_cockpit_turn_r_to_center;
    level.scr_anim["_pitbull"]["accelerate"] = %pitbull_cockpit_accelerate;
    level.scr_anim["_pitbull"]["decelerate"] = %pitbull_cockpit_decelerate;
    level.scr_anim["_pitbull"]["gear_up"] = %pitbull_cockpit_gear_up;
    level.scr_anim["_pitbull"]["gear_down"] = %pitbull_cockpit_gear_down;
}

precache_lui_event_strings()
{
    precachestring( &"pitbull_update_speed" );
    precachestring( &"pitbull_charge" );
    precachestring( &"pitbull_safe" );
    precachestring( &"pitbull_target_locked" );
    precachestring( &"pitbull_warning" );
    precachestring( &"pitbull_update_text" );
    precachestring( &"pitbullHud" );
    precachestring( &"pitbull_stop" );
    precachestring( &"pitbull_stop_movie" );
    precachestring( &"pitbull_ui_tap" );
    precachestring( &"pitbull_fade_video" );
}

handle_player_pitbull( var_0 )
{
    self endon( "death" );
    thread player_pitbull_physics_wake_up();
    thread handle_player_pitbull_autosave_checks();
    self.player_rig = undefined;

    if ( isdefined( var_0 ) )
    {
        self.player_rig = maps\_utility::spawn_anim_model( var_0 );
        self.player_rig hide();
        thread common_scripts\utility::delete_on_death( self.player_rig );
    }

    if ( !isdefined( self.fake_vehicle_model ) )
    {
        var_1 = maps\_utility::spawn_anim_model( "_pitbull" );
        var_1.origin = self.origin;
        var_1.angles = self.angles;
        var_1 hidepart( "TAG_WINDSHIELD1" );
        var_1 hidepart( "TAG_WINDSHIELD2" );
        var_1 hidepart( "TAG_WINDSHIELD3" );
        var_1 linkto( self );
        self.fake_vehicle_model = var_1;

        if ( isdefined( self.player_rig ) )
            self.player_rig linkto( self.fake_vehicle_model, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }

    self.fake_vehicle_model show();
    self hide();
    self.mgturret[0] hide();
    self makeunusable();
    maps\_utility::ent_flag_init( "pitbull_disconnected" );
    maps\_utility::ent_flag_init( "pitbull_scripted_anim" );
    maps\_utility::ent_flag_init( "pitbull_allow_shooting" );

    for (;;)
    {
        self waittill( "mount_pitbull", var_2 );
        mount_player_pitbull( var_2 );
        thread maps\sanfran_pitbull_drive_anim::handle_player_pitbull_driving();
        thread handle_player_pitbull_turret();
        thread handle_player_pitbull_hud();
        thread handle_player_pitbull_damage();
        thread pitbull_rumble();
        self waittill( "dismount_pitbull" );
        dismount_player_pitbull( self.player_rig );
    }
}

show_video_on_driverside()
{
    wait 0.1;
    setomnvar( "ui_pitbull_video_state", 1 );
}

mount_player_pitbull( var_0 )
{
    setomnvar( "ui_pitbull", 1 );
    level.player maps\_utility::player_mount_vehicle( self );
    level.player lerpfov( 65, 0.2 );
    self.player_rig show();
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    level.player playerlinkedvehicleanglesenable();
    level.player lerpviewangleclamp( 0, 0, 0, 0, 0, 0, 0 );
}

dismount_player_pitbull( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        level.player unlink();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        self notify( "stop_loop" );
        var_0 hide();
    }

    setomnvar( "ui_pitbull", 0 );
    self.fake_vehicle_model hide();
    self show();

    if ( !maps\_utility::ent_flag( "pitbull_disconnected" ) )
        level.player maps\_utility::player_dismount_vehicle();

    level.player lerpfov( 65, 0.2 );
    self notify( "dismount_player_pitbull" );
}

disconnect_fake_pitbull()
{
    if ( !maps\_utility::ent_flag( "pitbull_disconnected" ) )
    {
        level.player maps\_utility::player_dismount_vehicle();
        self.fake_vehicle_model unlink();
        self.fake_vehicle_model notify( "stop_loop" );
        self.fake_vehicle_model maps\_utility::anim_stopanimscripted();
        level.player playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        maps\_utility::ent_flag_set( "pitbull_disconnected" );
        thread fake_vehicle_fake_collision();
        self vehphys_disablecrashing();
    }

    return self.fake_vehicle_model;
}

reconnect_fake_pitbull()
{
    if ( maps\_utility::ent_flag( "pitbull_disconnected" ) )
    {
        self vehicle_teleport( self.fake_vehicle_model.origin, self.fake_vehicle_model.angles, 1 );
        level.player maps\_utility::player_mount_vehicle( self );
        self.fake_vehicle_model dontinterpolate();
        self.fake_vehicle_model.origin = self.origin;
        self.fake_vehicle_model.angles = self.angles;
        self.fake_vehicle_model linkto( self );
        level.player playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        level.player playerlinkedvehicleanglesenable();
        maps\_utility::ent_flag_clear( "pitbull_disconnected" );
        self vehphys_enablecrashing();
    }
}

fake_vehicle_fake_collision()
{
    self endon( "death" );
    self endon( "dismount_pitbull" );

    while ( maps\_utility::ent_flag( "pitbull_disconnected" ) )
    {
        var_0 = self.fake_vehicle_model;
        var_1 = anglestoforward( var_0.angles );
        var_2 = var_0.origin + var_1 * 78;
        var_3 = 117;
        physicsexplosioncylinder( var_2, var_3, 0, 0.5 );
        wait 0.05;
    }
}

add_passenger_to_player_pitbull( var_0, var_1 )
{
    if ( !isdefined( self.fake_attachedguys ) )
        self.fake_attachedguys = [];

    if ( !isdefined( self.fake_usedpositions ) )
        self.fake_usedpositions = [];

    self.fake_attachedguys[self.fake_attachedguys.size] = var_0;
    var_2 = set_pos( var_1 );
    var_3 = maps\_vehicle_aianim::anim_pos( self, var_2 );
    self.fake_usedpositions[var_2] = 1;
    var_4 = self.fake_vehicle_model gettagorigin( var_3.sittag );
    var_5 = self.fake_vehicle_model gettagangles( var_3.sittag );
    var_0.vehicle_pos = var_2;
    var_0.vehicle_idle = var_3.idle;
    self.fake_vehicle_model maps\_vehicle_aianim::link_to_sittag( var_0, var_3.sittag, var_3.sittag_offset, var_3.linktoblend );
    self.fake_vehicle_model thread passenger_idle( var_0, var_3 );
}

passenger_idle( var_0, var_1 )
{
    var_0 endon( "pitbull_get_out" );

    for (;;)
        maps\_vehicle_aianim::play_new_idle( var_0, var_1 );
}

set_pos( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        if ( isdefined( self.fake_usedpositions[var_0] ) )
        {

        }

        return var_0;
    }

    for ( var_1 = 1; var_1 < 4; var_1++ )
    {
        if ( self.fake_usedpositions[var_1] )
            continue;

        return var_1;
    }
}

remove_passenger_from_player_pitbull( var_0 )
{
    for ( var_1 = 0; var_1 < self.fake_attachedguys.size; var_1++ )
    {
        if ( self.fake_attachedguys[var_1] == var_0 )
        {
            common_scripts\utility::array_remove( self.fake_attachedguys, var_0 );
            self.fake_usedpositions[var_0.vehicle_pos] = 0;
            var_0 notify( "pitbull_get_out" );
            var_0 notify( "newanim" );
            var_0 stopanimscripted();
            var_0 unlink();
            var_0.vehicle_pos = undefined;
            var_0.vehicle_idle = undefined;
            return;
        }
    }
}

handle_player_pitbull_turret()
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );

    if ( !isdefined( self.mgturret[0] ) )
        return;

    for (;;)
    {
        maps\_utility::ent_flag_wait( "pitbull_allow_shooting" );
        thread pitbull_turret_aim();
        thread pitbull_turret_fire();
        maps\_utility::ent_flag_waitopen( "pitbull_allow_shooting" );
    }
}

find_best_target( var_0, var_1, var_2 )
{
    var_3 = undefined;
    var_4 = undefined;
    var_5 = getentarray( "target_vehicle", "script_noteworthy" );

    foreach ( var_7 in var_5 )
    {
        if ( !isdefined( var_7 ) )
            continue;

        var_8 = var_7.origin - self.origin;
        var_9 = vectornormalize( var_8 );
        var_10 = length( var_8 );
        var_11 = vectordot( var_0, var_9 );
        var_11 = acos( clamp( var_11, -1, 1 ) );

        if ( var_11 > var_1 )
            continue;

        var_12 = abs( var_10 - var_2 );
        var_11 += ( var_12 + 50 );

        if ( !isdefined( var_3 ) || var_11 < var_3 )
        {
            var_3 = var_11;
            var_4 = var_7;
        }
    }

    return var_4;
}

find_adjacent_target( var_0 )
{
    if ( !isdefined( self.current_turret_target ) )
        return;

    var_1 = anglestoforward( level.player getangles() );
    var_2 = anglestoright( level.player getangles() );
    var_3 = undefined;
    var_4 = undefined;
    var_5 = getentarray( "target_vehicle", "script_noteworthy" );

    foreach ( var_7 in var_5 )
    {
        if ( !isdefined( var_7 ) )
            continue;

        if ( var_7 == self.current_turret_target )
            continue;

        var_8 = var_7.origin - self.origin;
        var_9 = vectornormalize( var_8 );
        var_10 = vectordot( var_1, var_9 );

        if ( var_10 < 0.423 )
            continue;

        var_11 = var_7.origin - self.current_turret_target.origin;
        var_12 = vectordot( var_2, var_11 );

        if ( !isdefined( var_4 ) )
        {
            var_3 = var_12;
            var_4 = var_7;
            continue;
        }

        if ( var_0 == "left" )
        {
            if ( var_3 < 0 )
            {
                if ( var_12 < 0 && var_3 < var_12 )
                {
                    var_3 = var_12;
                    var_4 = var_7;
                }
            }
            else if ( var_12 < 0 || var_3 < var_12 )
            {
                var_3 = var_12;
                var_4 = var_7;
            }

            continue;
        }

        if ( var_3 > 0 )
        {
            if ( var_12 > 0 && var_3 > var_12 )
            {
                var_3 = var_12;
                var_4 = var_7;
            }

            continue;
        }

        if ( var_12 > 0 || var_3 > var_12 )
        {
            var_3 = var_12;
            var_4 = var_7;
        }
    }

    return var_4;
}

pitbull_turret_aim()
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );
    self endon( "pitbull_allow_shooting" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    thread clean_up_hud_entity( var_0, "ui_pitbulltur_target" );
    thread update_target_hud( var_0 );
    thread pitbull_turret_targeting( var_0 );
}

update_target_hud( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        if ( !isalive( self.current_turret_target ) )
        {
            waitframe();

            if ( !isalive( self.current_turret_target ) )
            {
                if ( isdefined( var_0.fx_on ) && var_0.fx_on )
                {
                    var_0.fx_on = 0;
                    killfxontag( common_scripts\utility::getfx( "ui_pitbulltur_target" ), var_0, "tag_origin" );
                }

                continue;
            }
        }

        if ( !isdefined( var_0.fx_on ) || !var_0.fx_on )
        {
            playfxontag( common_scripts\utility::getfx( "ui_pitbulltur_target" ), var_0, "tag_origin" );
            var_0.fx_on = 1;
        }

        var_1 = self.current_turret_target.origin + ( 0, 0, 50 );
        var_2 = vectornormalize( var_1 - level.player geteye() );
        var_0.origin = var_1;
        var_0.angles = vectortoangles( var_2 * -1 );
        waitframe();
    }
}

pitbull_turret_set_target( var_0, var_1, var_2 )
{
    self notify( "set_new_target" );
    self endon( "set_new_target" );
    self endon( "death" );
    self endon( "dismount_player_pitbull" );
    self endon( "pitbull_allow_shooting" );
    var_3 = self.current_turret_target;
    self.mgturret[0] settargetentity( var_3, ( 0, 0, 50 ) );
    self.mgturret[0] snaptotargetentity( var_3, ( 0, 0, 50 ) );
    wait_until_new_target( var_3, var_1, var_2 );
    self.current_turret_target = undefined;
}

pitbull_turret_targeting( var_0 )
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );
    self endon( "pitbull_allow_shooting" );

    for (;;)
    {
        var_1 = 0;
        var_2 = 90;

        if ( !isdefined( self.current_turret_target ) )
        {
            var_3 = anglestoforward( level.player getangles() );
            var_4 = find_best_target( var_3, 30, 500 );

            if ( isdefined( var_4 ) )
            {
                self.current_turret_target = var_4;
                var_1 = 5;
                var_2 = 30;
            }
        }

        if ( isdefined( self.current_turret_target ) )
        {
            pitbull_turret_set_target( var_0, var_2, var_1 );
            luinotifyevent( &"pitbull_target_locked", 1, 1 );
        }
        else
            luinotifyevent( &"pitbull_target_locked", 1, 0 );

        wait 0.05;
    }
}

wait_until_new_target( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_3 = cos( var_1 );
    var_4 = 0;

    if ( isdefined( var_2 ) && var_2 > 0 )
        var_4 = 1;

    while ( !var_4 || var_2 > 0 )
    {
        var_5 = anglestoforward( level.player getangles() );

        if ( !isdefined( var_0 ) )
            return;

        var_6 = var_0.origin - self.origin;
        var_7 = vectornormalize( var_6 );

        if ( vectordot( var_5, var_7 ) < var_3 )
            return;

        if ( var_4 )
            var_2 -= 0.1;

        wait 0.1;
    }
}

pitbull_update_lui_charge( var_0 )
{
    luinotifyevent( &"pitbull_charge", 1, int( clamp( var_0, 0, 1 ) * 100 ) );
}

pitbull_turret_fire()
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );
    self endon( "pitbull_allow_shooting" );
    var_0 = 0.8;
    var_1 = var_0;
    pitbull_update_lui_charge( var_1 );

    for (;;)
    {
        var_2 = 0;
        var_3 = level.player is_shoot_button_pressed();
        var_1 += 0.05;
        var_1 = min( var_1, var_0 );

        if ( isdefined( var_3 ) && var_3 )
        {
            if ( var_1 >= var_0 )
            {
                if ( isdefined( self.current_turret_target ) )
                {
                    var_2 = 1;
                    soundscripts\_snd_playsound::snd_play( "wpn_railgun_shot" );
                    self.mgturret[0] shootturret();
                    level.player playrumbleonentity( "heavygun_fire" );
                    var_1 = 0;
                }
                else if ( common_scripts\utility::flag( "flag_player_can_fire" ) == 1 )
                {

                }
            }

            pitbull_update_lui_charge( 1 );
        }
        else
            pitbull_update_lui_charge( 0 );

        var_4 = var_1 / var_0;
        wait 0.05;
    }
}

display_no_target_hint()
{
    thread maps\_utility::display_hint( "no_target_hint" );
    common_scripts\utility::waittill_notify_or_timeout( "set_new_target", 2 );
    level.player.showhint = 0;
}

is_shoot_button_pressed()
{
    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() )
        return self attackbuttonpressed();

    return self adsbuttonpressed();
}

clean_up_hud_entity( var_0, var_1 )
{
    common_scripts\utility::waittill_any( "death", "dismount_player_pitbull" );

    if ( isdefined( var_0 ) )
    {
        stopfxontag( common_scripts\utility::getfx( var_1 ), var_0, "tag_origin" );
        var_0 delete();
    }
}

handle_player_pitbull_hud()
{
    self endon( "death" );
    self endon( "dismount_player_pitbull" );

    if ( level.currentgen )
        self endon( "oncoming_scene_pitbull_monitor_start" );

    for (;;)
    {
        var_0 = self vehicle_getspeed();
        var_0 = int( var_0 );

        if ( var_0 > 0 )
            var_0 += 1;

        luinotifyevent( &"pitbull_update_speed", 1, var_0 );

        if ( level.currentgen )
            level.oncoming_pitbull_speed = var_0;

        wait 0.05;
    }
}

pitbull_rumble()
{
    level endon( "flag_player_crashed" );
    level.player endon( "death" );
    var_0 = 0.0;
    var_1 = 0.015;
    var_2 = var_1 - var_0;
    thread pitbull_rumble_stop();
    var_3 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_3.intensity = 0.04;
    var_4 = 1.0;
    thread pitbull_vehicle_collision_rumble( var_3 );

    for (;;)
    {
        var_5 = get_pitbull_shake_value();
        var_3.intensity = var_0 + var_5 * var_2;
        wait(randomfloatrange( var_4 / 4, var_4 / 2 ));
    }
}

pitbull_vehicle_collision_rumble( var_0 )
{
    level endon( "flag_player_crashed" );
    level.player endon( "death" );
    var_1 = 0.02;
    var_2 = 0.1;
    var_3 = var_2 - var_1;

    for (;;)
    {
        self waittill( "veh_contact" );
        var_4 = get_pitbull_shake_value();
        var_0.intensity = var_1 + var_4 * var_3;
    }
}

get_pitbull_shake_value()
{
    var_0 = 0;
    var_1 = 12;
    return self vehicle_getspeed() / var_1;
}

pitbull_rumble_stop()
{
    level waittill( "flag_player_crashed" );
    stopallrumbles();
}

handle_player_pitbull_damage()
{
    self endon( "death" );
    self endon( "stop_player_pitbull_damage" );
    childthread manage_windshield_states();
    var_0 = [];
    var_0[0] = [ 200, 300 ];
    var_0[1] = [ 400, 3000 ];
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        self waittill( "veh_contact", var_3, var_4, var_5, var_6, var_7 );
        var_8 = ( var_6[0], var_6[1], 0 );
        var_9 = length( var_8 );

        if ( var_9 < var_0[var_1][0] )
            continue;

        var_2 += var_9;

        if ( var_2 < var_0[var_1][1] )
            continue;

        var_1++;
        self notify( "windshield_state", var_1 );
        var_2 = 0;

        if ( var_1 >= var_0.size )
            return;
    }
}

manage_windshield_states()
{
    for (;;)
    {
        self waittill( "windshield_state", var_0 );
        pitbull_hide_part( "TAG_WINDSHIELD" );
        pitbull_hide_part( "TAG_WINDSHIELD1" );
        pitbull_hide_part( "TAG_WINDSHIELD2" );
        pitbull_hide_part( "TAG_WINDSHIELD3" );

        if ( var_0 == 0 )
        {
            pitbull_show_part( "TAG_WINDSHIELD" );
            continue;
        }

        if ( var_0 == 1 )
        {
            pitbull_show_part( "TAG_WINDSHIELD1" );
            continue;
        }

        if ( var_0 == 2 )
        {
            pitbull_show_part( "TAG_WINDSHIELD2" );
            continue;
        }

        if ( var_0 == 3 )
        {
            pitbull_show_part( "TAG_WINDSHIELD3" );
            continue;
        }

        if ( var_0 > 3 )
        {
            pitbull_show_part( "TAG_WINDSHIELD3" );
            return;
        }
    }
}

pitbull_hide_part( var_0 )
{
    self hidepart( var_0 );

    if ( isdefined( self.fake_vehicle_model ) )
        self.fake_vehicle_model hidepart( var_0 );
}

pitbull_show_part( var_0 )
{
    self showpart( var_0 );

    if ( isdefined( self.fake_vehicle_model ) )
        self.fake_vehicle_model showpart( var_0 );
}

handle_friendly_pitbull_shooting()
{
    self endon( "death" );
    thread friendly_pitbull_aim();
    thread friendly_pitbull_fire();
}

friendly_pitbull_aim()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = anglestoforward( self.angles );
        var_1 = find_best_target( var_0, 45, 500 );

        if ( isdefined( var_1 ) )
        {
            self.mgturret[0] settargetentity( var_1, ( 0, 0, 50 ) );
            wait_until_new_target( var_1, 45, 5 );
        }

        wait 0.05;
    }
}

friendly_pitbull_fire()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "pitbull_allow_shooting" );

    for (;;)
    {
        wait(randomfloatrange( 2, 3 ));

        if ( maps\_utility::ent_flag( "pitbull_allow_shooting" ) )
        {
            for ( var_0 = self.mgturret[0] getturrettarget( 1 ); !isdefined( var_0 ); var_0 = self.mgturret[0] getturrettarget( 1 ) )
                wait 0.2;

            wait(randomfloatrange( 2, 5 ));
            self.mgturret[0] shootturret();
            self.mgturret[0] soundscripts\_snd::snd_message( "npc_pitbull_shot" );
            wait 0.5;
        }
    }
}

player_pitbull_physics_wake_up()
{
    self endon( "death" );

    for (;;)
    {
        if ( level.nextgen )
            wakeupphysicssphere( self.origin, 240 );
        else
        {
            physicsexplosionsphere( self.origin, 240, 200, 0.15, 0 );
            physicsexplosionsphere( level.player.origin, 160, 140, 2.5, 0 );
        }

        waitframe();
    }
}

handle_player_pitbull_autosave_checks()
{
    self endon( "death" );
    maps\_utility::add_extra_autosave_check( "pitbull_no_recent_accel", ::autosave_check_pitbull_no_recent_accel, "pitbull recently accelerated" );
    maps\_utility::add_extra_autosave_check( "pitbull_upright", ::autosave_check_pitbull_upright, "pitbull is not upright" );
    maps\_utility::add_extra_autosave_check( "pitbull_moving", ::autosave_check_pitbull_moving, "pitbull is not moving" );
    thread monitor_pitbull_recent_accel();
    common_scripts\utility::flag_wait( "flag_player_crashed" );
    maps\_utility::remove_extra_autosave_check( "pitbull_no_recent_accel" );
    maps\_utility::remove_extra_autosave_check( "pitbull_upright" );
    maps\_utility::remove_extra_autosave_check( "pitbull_moving" );
}

monitor_pitbull_recent_accel()
{
    self endon( "death" );
    var_0 = 1544;
    var_1 = squared( var_0 );

    for (;;)
    {
        if ( lengthsquared( maps\_shg_utility::get_differentiated_acceleration() ) > var_1 )
            self.last_big_acceleration_msec = gettime();

        waitframe();
    }
}

autosave_check_pitbull_no_recent_accel()
{
    var_0 = 2000;
    return !isdefined( level.player_pitbull.last_big_acceleration_msec ) || gettime() - level.player_pitbull.last_big_acceleration_msec > var_0;
}

autosave_check_pitbull_upright()
{
    var_0 = 0.5;
    return anglestoup( level.player_pitbull.angles )[2] > var_0;
}

autosave_check_pitbull_moving()
{
    var_0 = 20;
    return !common_scripts\utility::flag( "flag_intro_give_player_driving" ) || level.player_pitbull vehicle_getspeed() > var_0;
}
