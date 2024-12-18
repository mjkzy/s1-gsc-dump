// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

pre_load()
{

}

post_load()
{
    common_scripts\utility::flag_init( "flag_t2e_moveup" );
    common_scripts\utility::flag_init( "flag_entered_s1elevator" );
    common_scripts\utility::flag_init( "flag_start_s1elevator" );
    common_scripts\utility::flag_init( "flag_intro_bounds_double_check" );
    common_scripts\utility::flag_init( "lgt_flag_introdrive" );
}

start()
{
    level.player disableweapons();
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    setsaveddvar( "g_friendlyNameDist", 0 );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );

    if ( issubstr( level.start_point, "introdrive" ) )
    {
        level.player maps\captured_util::warp_to_start( "origin_playerstart_introdrive" );
        maps\captured_util::warp_allies( "struct_allystart_introdrive" );
    }
    else
    {
        level.player maps\captured_util::warp_to_start( "struct_playerstart_s1elevator" );
        soundscripts\_snd::snd_message( "start_s1_elevator" );
        thread truck_to_s1elevator_scene();
        common_scripts\utility::flag_set( "flag_introdrive_end" );
    }
}

main_introdrive()
{
    level.player freezecontrols( 1 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    soundscripts\_snd::snd_message( "scn_truck_sounds" );
    soundscripts\_snd::snd_music_message( "mus_captured_intro" );
    soundscripts\_snd::snd_message( "start_intro_drive" );
    soundscripts\_snd::snd_message( "aud_mech_idle_sfx" );
    setsaveddvar( "g_friendlyNameDist", 0 );
    level.player enableslowaim( 0.3, 0.15 );
    common_scripts\utility::flag_set( "lgt_flag_introdrive" );
    var_0 = getent( "model_introdrive_playertruck", "targetname" );
    thread player_truck( var_0 );
    thread intro_ambient_cleanup();
    thread s1_drive_and_elevator_scene( var_0 );
    wait 1.0;

    if ( !level.currentgen )
        thread maps\captured_util::captured_caravan_spawner( "intro_drive_truck_one", 3, 9.1, 9.2, "intro_drive" );
    else
        thread maps\captured_util::captured_caravan_spawner( "intro_drive_truck_one", 3, 19.1, 19.2, "intro_drive" );

    wait 10.0;
    wait 12.5;

    if ( !level.currentgen )
        thread maps\captured_util::captured_caravan_spawner( "intro_drive_trucks", undefined, 3.0, 10.0, "intro_drive" );
    else
        thread maps\captured_util::captured_caravan_spawner( "intro_drive_trucks", undefined, 18.0, 23.0, "intro_drive" );

    common_scripts\utility::flag_wait( "flag_introdrive_end" );
    level.player disableslowaim();
}

intro_ambient_cleanup()
{
    maps\_utility::wait_for_targetname_trigger( "intro_ambient_cleanup" );
    level notify( "s1_killpoppingcharacters" );
    level notify( "s1_looping_prisoner_intro" );
}

main_s1elevator()
{
    common_scripts\utility::flag_wait( "flag_s1elevator_end" );
}

player_truck( var_0 )
{
    var_1 = getent( "origin_playerstart_introdrive", "targetname" ) common_scripts\utility::spawn_tag_origin();
    soundscripts\_snd::snd_message( "entrance_alarm" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_introdrive_player" );
    var_2 hide();
    var_0 linkto( var_2, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    if ( level.currentgen )
    {
        var_0 thread maps\captured_util::tff_cleanup_vehicle( "intro_drive" );
        var_2 thread maps\captured_util::tff_cleanup_vehicle( "intro_drive" );
    }

    soundscripts\_snd::snd_message( "entrance_alarm_fast2" );
    var_3 = getvehiclenode( "intro_drive_player_vehicle_entrance_start", "targetname" );
    var_2 attachpath( var_3 );
    var_2 startpath();
    var_2 waittill( "reached_end_node" );
    wait 7.0;
    soundscripts\_snd::snd_message( "entrance_alarm_fast" );
}

s1_drive_and_elevator_scene( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "struct_scene_truckunload", "targetname" );
    var_2 = getent( "origin_scene_s1elevator", "targetname" );
    thread player_fov_controller();
    wait 3.5;

    if ( !isdefined( var_1 ) )
        return;

    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 linkto( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    var_4 = level.allies[2];
    var_5 = level.allies;
    common_scripts\utility::array_thread( var_5, maps\captured_util::ignore_everything );
    common_scripts\utility::array_thread( var_5, maps\_utility::gun_remove );
    var_6 = [ level.allies[0], level.allies[1] ];

    foreach ( var_4 in level.allies )
    {
        var_4 attach( "s1_captured_handcuffs", "tag_weapon_left" );
        var_4.hasattachedprops = 1;
        var_4 linkto( var_3 );
    }

    var_9 = maps\_utility::array_spawn_noteworthy( "truck_to_s1elevator_guards" );

    for ( var_10 = 0; var_10 < var_9.size; var_10++ )
    {
        var_9[var_10] maps\captured_util::ignore_everything();
        var_9[var_10] maps\_utility::disable_danger_react();
        var_11 = var_10 + 1;

        if ( var_11 > 3 )
            var_11 = var_11 + 1;

        var_9[var_10].animname = "guard_" + var_11;
    }

    var_12 = maps\_utility::spawn_script_noteworthy( "truck_to_s1elevator_general" );
    var_12.animname = "general_1";
    var_12 thread maps\captured_util::ignore_everything();
    var_12 thread maps\_utility::gun_remove();
    thread maps\captured::dialogue_s1elevator_outside( var_9, var_12 );
    var_13 = var_9[0];
    var_14 = var_9[1];
    var_15 = var_9[1];
    var_16 = var_9[3];
    var_9 = common_scripts\utility::array_remove( var_9, var_13 );
    var_9 = common_scripts\utility::array_remove( var_9, var_15 );
    common_scripts\utility::array_removeundefined( var_9 );
    var_17 = maps\_utility::array_spawn_noteworthy( "truck_to_s1elevator_prisoners", 1 );

    for ( var_10 = 0; var_10 < var_17.size; var_10++ )
    {
        var_17[var_10] maps\captured_util::ignore_everything();
        var_17[var_10] linkto( var_3 );
        var_11 = var_10 + 1;

        if ( var_11 > 4 )
            var_11 = var_11 + 5;

        var_17[var_10].animname = "prisoner_" + var_11;
    }

    var_18 = maps\_utility::spawn_script_noteworthy( "truck_to_s1elevator_prisoner_5" );
    var_18.animname = "prisoner_5";
    var_19 = maps\_utility::spawn_script_noteworthy( "truck_to_s1elevator_prisoner_6" );
    var_19.animname = "prisoner_6";
    var_20 = maps\_utility::spawn_script_noteworthy( "truck_to_s1elevator_prisoner_7" );
    var_20.animname = "prisoner_7";
    var_21 = maps\_utility::spawn_script_noteworthy( "truck_to_s1elevator_prisoner_8" );
    var_21.animname = "prisoner_8";
    var_21 hide();

    foreach ( var_23 in var_17 )
        var_23 attach( "s1_captured_handcuffs", "tag_weapon_left" );

    var_25 = [ var_18, var_19, var_20, var_21 ];

    foreach ( var_23 in var_25 )
        var_23 attach( "s1_captured_handcuffs", "tag_weapon_left" );

    var_28 = common_scripts\utility::array_combine( [ var_18, var_19, var_20, var_21 ], var_17 );
    var_29 = [ var_13, var_15, var_16 ];
    var_30 = [ var_18, var_20 ];
    var_31 = [ var_13, var_9[0] ];
    var_32 = "truck_to_s1elevator_start_loop_ender";
    var_33 = "truck_to_s1elevator_start_guard_loop_ender";
    var_34 = "truck_to_s1elevator_start_loop_ambient_ender";

    foreach ( var_36 in var_30 )
        var_1 thread maps\_anim::anim_loop_solo( var_36, "s1_truck_start_loop", var_34 );

    foreach ( var_36 in var_29 )
        var_1 thread maps\_anim::anim_loop_solo( var_36, "s1_truck_start_loop", var_33 );

    var_3 thread s1_deleted_prisoners_anims( var_17 );
    var_3 thread s1_truck_unload_main_allies_anims( var_6, var_1, var_2, var_21 );
    var_3 thread s1_truck_unload_main_guards_anims( var_29, var_9[0], var_12, var_1, var_33, var_2, var_19, var_32, var_0 );
    var_40 = maps\_utility::spawn_anim_model( "player_rig_noexo" );
    var_41 = var_40 thread maps\captured_util::captured_player_cuffs();
    var_40 linkto( var_3 );
    thread player_look_limit_controller( var_40 );
    thread prisoner_6_shadow_and_loop( var_19, var_3, var_1 );
    level.player common_scripts\utility::delaycall( 31.55, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 48.85, ::playrumbleonentity, "heavy_1s" );
    level.player thread maps\_utility::blend_movespeedscale( 0.075 );
    level.player allowsprint( 0 );
    level.player allowcrouch( 0 );
    level.player allowprone( 0 );
    level.player freezecontrols( 0 );
    var_3 maps\_anim::anim_single_solo( var_40, "truck_to_s1elevator_unload", "tag_origin" );
    common_scripts\utility::flag_set( "flag_introdrive_end" );
    var_42 = [ var_13, var_12, var_15, var_16 ];
    var_43 = common_scripts\utility::array_combine( var_9, var_42 );
    var_1 truck_to_s1elevator_scene( var_34, var_40, var_15, var_21, var_28, var_43, var_41 );
}

player_fov_controller()
{
    level.player lerpfov( 52, 1 );
    wait 13.0;
    level.player lerpfov( 40, 5 );
    level waittill( "s1_drive_guards_start" );
    level.player common_scripts\utility::delaycall( 2, ::lerpfov, 65, 3 );
}

player_look_limit_controller( var_0 )
{
    level.player playerlinktodelta( var_0, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait 12.0;
    level.player playerlinktodelta( var_0, "tag_player", 1, 25, 25, 12, 12, 1 );
    level waittill( "s1_drive_guards_start" );
    wait 1;
    level.player playerlinktoblend( var_0, "tag_player", 3, 1.5, 1.5 );
}

s1_deleted_prisoners_anims( var_0 )
{
    var_1 = self;
    var_1 maps\captured_anim::anim_single_to_delete( var_0, "truck_to_s1elevator_unload" );
}

prisoner_6_shadow_and_loop( var_0, var_1, var_2 )
{
    var_0 linkto( var_1 );
    var_1 maps\_anim::anim_single_solo( var_0, "truck_drive_player_shadow" );
    var_0 unlink();
    var_2 maps\_anim::anim_loop_solo( var_0, "s1_truck_start_loop", "prisoner_truck_start_loop_ender" );
}

s1_truck_unload_main_allies_anims( var_0, var_1, var_2, var_3 )
{
    var_4 = self;
    var_5 = maps\_utility::spawn_script_noteworthy( "introdrive_driver", 1 );
    var_5.animname = "driver";
    var_5 linkto( var_4, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 maps\captured_util::ignore_everything();
    var_4 thread maps\_anim::anim_single_solo( var_5, "truck_drive" );
    var_4 thread maps\_anim::anim_single( var_0, "truck_drive" );
    var_6 = getanimlength( level.allies[0] maps\_utility::getanim( "truck_drive" ) ) - 2;
    wait( var_6 );
    var_5 delete();
    wait 2;

    foreach ( var_8 in level.allies )
        var_8 unlink();

    var_1 thread maps\captured_anim::anim_single_to_loop( level.allies, "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "truck_to_s1elevator_ally_loop_ender", var_2 );
    var_2 thread maps\captured_anim::anim_single_to_loop( var_3, "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "loop_forever_ender" );
    level.player common_scripts\utility::delaycall( 9.65, ::playrumbleonentity, "light_1s" );
    wait 6;
    var_3 show();
    var_10 = getent( "s1_intro_elevator_door", "targetname" );
    var_10 soundscripts\_snd::snd_message( "s2_elevator_door_open_top" );
    var_10 moveto( var_10.origin + ( 0, 0, 192 ), 4 );
}

s1_truck_unload_main_guards_anims( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = self;
    var_6 common_scripts\utility::delaycall( 3.5, ::hide );
    var_6 common_scripts\utility::delaycall( 7, ::show );
    level waittill( "s1_drive_guards_start" );
    var_8 maps\_utility::assign_animtree( "intro_truck" );
    var_8 thread maps\_anim::anim_single_solo( var_8, "introdrive_truckopen" );
    var_3 notify( var_4 );
    var_3 notify( "prisoner_truck_start_loop_ender" );
    level.player common_scripts\utility::delaycall( 2, ::lerpfov, 65, 3 );
    var_9 thread introdrive_truck_throw_guard( var_0[0], getanimlength( var_0[0] maps\_utility::getanim( "truck_to_s1elevator_unload" ) ) );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_0[2], "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "truck_to_s1elevator_loop_ender" );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_6, "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "truck_to_s1elevator_loop_ender" );
    var_9 maps\_anim::anim_single_solo( var_0[1], "truck_drive" );
    var_3 thread maps\captured_anim::anim_single_to_loop( var_0[1], "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "truck_to_s1elevator_loop_ender" );

    if ( isdefined( var_7 ) )
        var_3 notify( var_7 );

    var_3 thread maps\captured_anim::anim_single_to_loop( [ var_1, var_2 ], "truck_to_s1elevator_unload", "truck_to_s1elevator_loop", "truck_to_s1elevator_loop_ender" );
}

introdrive_truck_throw_guard( var_0, var_1 )
{
    var_0 common_scripts\utility::delaycall( var_1 - 11.85, ::hide );
    var_0 common_scripts\utility::delaycall( var_1 - 11.65, ::show );
    thread maps\_anim::anim_single_solo( var_0, "truck_to_s1elevator_unload" );
    var_0 maps\captured_util::unignore_everything();
    var_0 thread opfor_kill_guard( getnode( "t2e_node_guard_back", "targetname" ) );
}

truck_to_s1elevator_scene( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = self;
    var_8 = getent( "origin_scene_s1elevator", "targetname" );

    if ( !isdefined( var_8 ) )
        return;

    var_9 = level.allies;
    var_10 = getent( "t2e_clip_start", "targetname" );
    var_11 = getent( "t2e_clip_end", "targetname" );
    var_10 maps\_utility::flagwaitthread( [ "flag_t2e_moveup", 0.25 ], ::_id_9092 );
    var_10 maps\_utility::delaythread( 15, common_scripts\utility::flag_set, "flag_t2e_moveup" );
    var_11 maps\_utility::delaythread( 30, ::_id_9092 );
    level.cover_warnings_disabled = 1;
    var_1 hide();
    level.player unlink();
    var_1 unlink();
    var_6 hide();
    thread soundscripts\_snd::snd_message( "aud_intro_caravan_unmute" );
    level.player thread maps\_utility::blend_movespeedscale( 0.4, 7 );
    level.player thread _id_9093( var_11 );
    maps\_utility::array_spawn_function_targetname( "t2e_kill_guard", ::opfor_kill_guard );
    var_12 = maps\_utility::array_spawn_targetname( "t2e_kill_guard", 1 );
    var_5 = maps\_utility::array_merge( var_5, var_12 );
    thread s1_elevator_boundary_function( var_12 );
    thread maps\captured_s2walk::spawn_player_prisoner_hands();
    maps\_utility::trigger_wait_targetname( "truck_to_s1elevator_trigger" );
    common_scripts\utility::flag_set( "flag_entered_s1elevator" );
    soundscripts\_snd::snd_message( "s2_elevator_ride_down" );
    soundscripts\_snd::snd_message( "aud_stop_cormack_foley" );
    level.player setstance( "stand" );
    var_13 = [ var_1, var_3 ];
    var_8 thread maps\_anim::anim_single( var_13, "truck_to_s1elevator_push" );
    var_7 thread maps\_anim::anim_single_solo( var_2, "truck_to_s1elevator_push" );

    if ( level.currentgen )
        thread maps\_utility::tff_sync( 6 );

    level.player playerlinktoblend( var_1, "tag_player", 0.5 );
    wait 0.5;
    maps\captured_s2walk::player_hands_idle_stop( 1 );
    var_1 show();
    var_6 show();
    level.player playerlinktodelta( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    level.player common_scripts\utility::delaycall( 0.3, ::playrumbleonentity, "light_1s" );
    level waittill( "s1_elevator_player_fall" );
    level.player enableslowaim( 0.3, 0.15 );
    level.player common_scripts\utility::delaycall( 3.0, ::playerlinktodelta, var_1, "tag_player", 0.5, 20, 30, 15, 15, 1 );
    var_7 notify( "truck_to_s1elevator_ally_loop_ender" );
    var_8 notify( "truck_to_s1elevator_ally_loop_ender" );
    var_8 thread maps\captured_anim::anim_single_to_loop( var_9, "truck_to_s1elevator_push", "s2walk_wait_intro_loop_allies", "s2walk_all_wait_loop_ender" );

    if ( isdefined( var_0 ) )
        var_7 notify( var_0 );

    thread elevator_ride_s1s2( var_1, var_6 );
    wait( getanimlength( var_2 maps\_utility::getanim( "truck_to_s1elevator_push" ) ) );
    level notify( "stop_caravan_spawner" );

    foreach ( var_15 in var_5 )
    {
        if ( !isremovedentity( var_15 ) )
            var_15 delete();
    }

    foreach ( var_18 in var_4 )
    {
        if ( !isremovedentity( var_18 ) )
            var_18 delete();
    }
}

_id_9093( var_0 )
{
    self endon( "death" );
    level endon( "flag_entered_s1elevator" );
    thread set_demigod_while( "s1_elevator_boundary" );
    self waittill( "damage", var_1, var_2, var_3, var_4 );

    if ( !common_scripts\utility::flag( "s1_elevator_boundary" ) )
    {
        var_2.dontmelee = 1;
        maps\_utility::set_ignoreme( 1 );

        while ( isdefined( var_2.melee ) )
            wait 0.05;

        maps\_utility::set_ignoreme( 0 );
    }

    var_5 = common_scripts\utility::array_randomize( [ "cap_gr4_inline", "cap_gr4_getinline" ] );
    var_2 maps\_utility::smart_dialogue_generic( var_5[0] );
    wait 3;
    setdemigodmode( self, 0 );
    maps\_utility::set_ignoreme( 0 );
    self waittill( "damage", var_1, var_2, var_3, var_4 );
    var_2 thread maps\_utility::smart_dialogue_generic( var_5[1] );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_id_9092()
{
    self connectpaths();
    self delete();
}

set_demigod_while( var_0 )
{
    self endon( "death" );
    setdemigodmode( self, 1 );

    while ( common_scripts\utility::flag( var_0 ) )
        wait 0.05;

    setdemigodmode( self, 0 );
}

s1_elevator_boundary_function( var_0 )
{
    self endon( "death" );
    level endon( "flag_entered_s1elevator" );

    for (;;)
    {
        common_scripts\utility::flag_waitopen( "s1_elevator_boundary" );
        wait 2;

        if ( !common_scripts\utility::flag( "s1_elevator_boundary" ) )
        {
            var_1 = common_scripts\utility::getclosest( level.player.origin, var_0 );
            magicbullet( "iw5_titan45_sp", var_1 geteye(), level.player geteye() );
            level.player kill( ( 5352, -5148, 32 ), var_1 );
        }
    }
}

elevator_ride_s1s2( var_0, var_1 )
{
    var_2 = getentarray( "brush_elevator_s1s2", "targetname" );
    var_3 = getent( "origin_scene_s1elevator", "targetname" );
    var_4 = getent( "brush_elevator_s1s2_bottomgate", "targetname" );
    var_5 = level.allies;
    common_scripts\utility::array_thread( var_5, maps\captured_util::ignore_everything );
    common_scripts\utility::array_thread( var_5, maps\_utility::gun_remove );
    var_6 = undefined;
    var_7 = [];
    var_8 = 0;

    foreach ( var_10 in var_2 )
    {
        if ( var_8 != 1 )
        {
            if ( var_10.classname == "script_brushmodel" )
            {
                var_6 = var_10;
                var_8 = 1;
            }
            else
                var_7 = common_scripts\utility::array_add( var_7, var_10 );

            continue;
        }

        var_7 = common_scripts\utility::array_add( var_7, var_10 );
    }

    var_7 = common_scripts\utility::array_add( var_7, var_3 );
    var_7 = common_scripts\utility::array_add( var_7, var_4 );
    var_7 = common_scripts\utility::array_combine( var_7, var_5 );
    var_0 linkto( var_6 );

    foreach ( var_13 in var_7 )
        var_13 linkto( var_6 );

    common_scripts\utility::flag_set( "flag_start_s1elevator" );
    var_15 = spawn( "script_model", ( 5520, -5705, 75 ) );
    var_15 setmodel( "tag_origin" );
    playfxontag( level._effect["cap_intro_elevator_light_soft"], var_15, "tag_origin" );
    var_15 linkto( var_6 );
    wait 5.8;

    if ( level.currentgen )
    {
        if ( !istransientloaded( "captured_s2walk_tr" ) )
            level waittill( "tff_post_intro_drive_to_s2walk" );
    }

    level notify( "stop_elevator_push" );
    level notify( "start_elevator_sounds" );
    thread scene_enemy_walk_setup_loops( var_0, var_1 );
    var_6 moveto( var_6.origin - ( 0, 0, 593 ), 18.5 );
    wait 14.0;
    common_scripts\utility::flag_set( "flag_s1elevator_end" );
    wait 4.5;
    var_4 unlink();
    level notify( "stop_elevator_sounds" );
}

elevator_push()
{
    level endon( "stop_elevator_push" );
    var_0 = anglestoforward( common_scripts\utility::getstruct( "struct_playerstart_s1elevator", "targetname" ).angles ) * 16;

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_s1elevator_push" );
        player_push_impulse( var_0, 1 );
    }
}

player_push_impulse( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.05;

    var_2 = var_1;

    while ( var_2 > 0.0 )
    {
        var_3 = clamp( var_2 / var_1, 0, 1 );
        var_4 = var_0 * var_3;
        level.player pushplayervector( var_4 );
        var_2 = var_2 - 0.05;
        wait 0.05;
    }

    level.player pushplayervector( ( 0, 0, 0 ) );
}

scene_s1_in_elevator()
{
    common_scripts\utility::flag_wait( "flag_start_s1elevator" );
}

scene_enemy_walk_setup_loops( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( "struct_scene_s2walkstart", "targetname" );

    if ( !isdefined( var_2 ) )
        return;

    var_3 = maps\_utility::array_spawn_noteworthy( "actor_s2wintro_guards" );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        var_3[var_4] maps\captured_util::ignore_everything();
        var_5 = var_4 + 1;
        var_3[var_4].animname = "guard_" + var_5;

        if ( var_5 == 3 )
            var_3[var_4] maps\_utility::gun_remove();
    }

    var_2 thread maps\_anim::anim_loop( var_3, "s2walk_guard_intro_loop", "s2walk_guard_intro_loop_ender" );
    level waittill( "s1elevator_end" );
    var_2 notify( "s2walk_guard_intro_loop_ender" );
    thread maps\captured_s2walk::scene_intro_walk( var_3, var_0, var_1 );
}

nt_s1_elevator_push_fall( var_0 )
{
    level notify( "s1_elevator_player_fall" );
}

nt_s1_truck_dismount_guards( var_0 )
{
    level notify( "s1_drive_guards_start" );
    thread soundscripts\_snd::snd_message( "aud_intro_to_elev_walla" );
}

nt_s1_elevator_end( var_0 )
{
    level notify( "s1elevator_end" );
}

opfor_kill_guard( var_0 )
{
    self endon( "death" );
    self.newenemyreactiondistsq = 0;
    maps\_utility::flagwaitthread( "flag_entered_s1elevator", maps\_utility::set_ignoreall, 1 );

    if ( isdefined( var_0 ) )
    {
        self.script_forcegoal = 1;
        thread maps\_utility::follow_path( var_0 );
    }
    else if ( isdefined( self.target ) )
        var_0 = getnode( self.target, "targetname" );

    if ( isdefined( var_0 ) && isdefined( var_0.script_flag_wait ) && isdefined( var_0.target ) )
    {
        var_1 = getnode( var_0.target, "targetname" );
        var_2 = 0;

        if ( isdefined( var_0.script_wait ) && var_0.script_wait > 0.05 )
            var_2 = var_0.script_wait - 0.05;

        maps\_utility::flagwaitthread( [ var_0.script_flag_wait, var_2 ], maps\_utility::follow_path, var_1 );
    }

    self.a.nextmeleechargesound = gettime() + 320000;
    maps\_utility::set_favoriteenemy( level.player );
    maps\_utility::enable_dontevershoot();
    maps\_utility::magic_bullet_shield( 1 );
    common_scripts\utility::flag_wait( "s1_elevator_boundary" );
    common_scripts\utility::flag_waitopen( "s1_elevator_boundary" );
    maps\_utility::disable_dontevershoot();
    level.player waittill( "death" );
    maps\_utility::enable_dontevershoot();
}
