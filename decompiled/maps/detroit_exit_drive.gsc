// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

exit_drive_main()
{
    precacheitem( "rpg_straight" );
    precacheitem( "rpg_player" );
    precacheitem( "rpg_custom_detroit_exit_drive" );
    thread setup_exitdrive_starting_anims();
    thread exit_drive_objects_think();
    thread failed_to_keep_up();
    thread failed_to_avoid_buttress();
    thread setup_exitdrive_encounters();
    thread warning_box_functions();
    thread cleanup_school_cars();
}

transient_middle_remove_hospital_interior_begin()
{
    level notify( "tff_pre_remove_hospital_add_exit" );
    _func_219( "detroit_hospital_interior_tr" );
    wait 2.5;
    _func_218( "detroit_outro_tr" );

    for (;;)
    {
        if ( _func_21E( "detroit_outro_tr" ) )
        {
            level notify( "tff_post_remove_hospital_add_exit" );
            break;
        }

        wait 0.05;
    }

    level.jetbike _meth_846C( "mq/mtl_mil_hoverbike_screen_center_off", "mq/mtl_hoverbike_screen_ui_01" );
    level.jetbike _meth_846C( "mq/mtl_mil_hoverbike_screen_right_off", "mq/mtl_hoverbike_screen_ui_02" );
    level.jetbike _meth_846C( "mq/mtl_mil_hoverbike_screen_top_off", "mq/mtl_hoverbike_screen_ui_03" );
    level.jetbike _meth_846C( "mq/mtl_mil_hoverbike_lights_off", "mq/mtl_hoverbike_screen_ui_04" );
}

warning_box_functions()
{
    var_0 = getent( "exit_drive_warning_box", "targetname" );
    common_scripts\utility::flag_wait( "exit_drive_started" );
    thread mission_fail_warning_exitdrive( var_0 );
}

mission_fail_warning_exitdrive( var_0 )
{
    level.player endon( "death" );

    for (;;)
    {
        if ( level.player _meth_80A9( var_0 ) )
        {
            maps\_utility::hint( &"DETROIT_LEAVING_MISSION", 3 );
            wait 8;
        }

        wait 0.05;
    }
}

exit_drive_objects_think()
{
    var_0 = getentarray( "exitdrive_vehicle_clip_bubble", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin -= ( 0, 0, 1000 );

    common_scripts\utility::flag_wait( "exit_drive_started" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, 0, 1000 );
}

jetbike_physics()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0.3;

    if ( self == level.burke_bike )
    {
        var_0 = 10;
        var_1 = 25;
        var_2 = 60;
        var_3 = -20;
    }

    if ( self == level.jetbike )
    {
        var_0 = 74;
        var_1 = 75;
        var_2 = 100;
        var_3 = -100;
        var_4 = 0.06;
    }

    for (;;)
    {
        var_5 = var_4;

        if ( self == level.jetbike )
        {
            var_6 = self _meth_8286();
            var_7 = 42;
            var_5 *= max( 0, min( 1, var_6 / var_7 ) );
        }

        var_8 = self.origin + anglestoforward( self.angles ) * var_2 + anglestoup( self.angles ) * var_3;
        physicsexplosionsphere( var_8, var_1, var_0, var_5, 0 );
        wait 0.05;
    }
}

manage_burke_bike_behavior()
{
    wait 4;
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband( level.jetbike, 1000, 100 );
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_min_speed( 30 );
    wait 1;
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_fail_range( 2000, 8 );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_rail_dodge_01a" );
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range( 1200 );
}

failed_to_keep_up()
{
    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    common_scripts\utility::flag_clear( "exit_drive_ending_begin_player" );
    common_scripts\utility::flag_wait( "flag_jetbike_fail" );

    if ( common_scripts\utility::flag( "exit_drive_ending_begin_player" ) )
        return;

    maps\detroit_jetbike::fail_out_of_range();
}

failed_to_avoid_buttress()
{
    common_scripts\utility::flag_wait( "flag_jetbike_fail_buttress" );
    level.player _meth_8052();
}

exit_drive_player_jetbike_initial_lights()
{
    var_0 = maps\_shg_utility::play_fx_with_handle( "jetbike_lights", self, "tag_headlight" );
    self waittill( "kill_fx_to_hack_around_setmodel_fx_bug" );
    maps\_shg_utility::kill_fx_with_handle( var_0 );
}

setup_exitdrive_control_hints()
{
    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    wait 8.0;
    maps\_utility::hintdisplayhandler( "jetbike_controls_controller" );
}

player_input_control_hint_off()
{
    if ( level.player _meth_82F3()[0] != 0 || level.player _meth_82F3()[1] != 0 )
        return 1;

    return 0;
}

handle_name_identifiers_exit_drive()
{
    var_0 = getdvarint( "g_friendlyNameDist" );
    _func_0D3( "g_friendlyNameDist", 0 );
    level waittill( "detroit_level_fadeout" );
    _func_0D3( "g_friendlyNameDist", var_0 );
}

setup_exitdrive_starting_anims()
{
    var_0 = getent( "exit_drive_starting", "targetname" );
    thread jetbike_exitdrive_door( var_0 );
    common_scripts\utility::flag_wait( "exit_drive_cinematic_start" );
    thread maps\detroit::spawn_bikes();
    thread jetbike_exitdrive_player( var_0 );
    thread jetbike_exitdrive_burke( var_0 );
    thread jetbike_exitdrive_joker_and_doctor( var_0 );
    thread jetbike_exitdrive_bones( var_0 );
    thread exit_drive_starting_anims_ambient_danger();
    thread jetbike_exitdrive_fov_changes();
    thread stay_on_mission();

    if ( level.currentgen )
    {
        wait 2;
        level.burke_bike hide();
        level.joker_bike hide();
        level.bones_bike hide();

        if ( isdefined( level.player_bike ) )
            level.player_bike hide();
    }
}

jetbike_exitdrive_fov_changes()
{
    level waittill( "exit_drive_FOV_start" );
    level.player _meth_8031( 56, 2 );
    level waittill( "exit_drive_FOV_end" );
    level.player _meth_8031( 65, 1 );
}

stay_on_mission()
{
    maps\_utility::trigger_wait_targetname( "play_garage_animation_sequence" );
    maps\_player_death::set_deadquote( &"DETROIT_OBJECTIVE_FAIL_JETBIKE" );
    maps\_utility::missionfailedwrapper();
}

jetbike_exitdrive_door( var_0 )
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_1 = getent( "exit_drive_animated_door", "targetname" );
    var_1.animname = "animated_door";
    var_1 maps\_anim::setanimtree();
    var_2 = getent( var_1.target, "targetname" );
    var_0 maps\_anim::anim_first_frame_solo( var_1, "det_exit_drive_starting_anim_1" );
    var_2 _meth_804D( var_1, "doorA" );
    common_scripts\utility::flag_wait( "flag_open_door_to_bikes" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "det_exit_drive_starting_anim_1" );
}

jetbike_exitdrive_player( var_0 )
{
    thread setup_exitdrive_control_hints();

    if ( isdefined( level.player_bike ) )
        level.player_bike delete();

    level.jetbike = maps\_vehicle::spawn_vehicle_from_targetname( "player_jetbike_exit" );
    level.jetbike.animname = "player_bike";
    level.jetbike_obj = spawn( "script_model", ( 0, 0, 0 ) );
    level.jetbike_obj.animname = level.jetbike.animname;
    level.jetbike_obj maps\_utility::assign_animtree();
    var_0 thread maps\_anim::anim_loop_solo( level.jetbike, "det_exit_drive_starting_idle_1", "bike_idle_ender" );
    level.jetbike jetbike_allow_player_use_detroit( undefined );
    level.player thread maps\_player_exo::player_exo_deactivate();
    var_0 notify( "bike_idle_ender" );
    level.jetbike_obj delete();
    level notify( "hide_hoverbike_exit_prompt" );

    if ( level.nextgen )
        level.jetbike _meth_804C();

    common_scripts\utility::flag_set( "player_on_exitdrive_jetbike" );
    common_scripts\utility::flag_clear( "start_exit_trains" );
    level.jetbike thread maps\detroit_jetbike::handle_glass_collisions();
    thread handle_name_identifiers_exit_drive();
    common_scripts\utility::flag_set( "exitdrive_lights_on" );
    level.player _meth_83C0( "jetbike_exit" );
    maps\_utility::vision_set_fog_changes( "detroit_jetbike_exit", 2 );
    thread maps\detroit_lighting::exit_drive_jetbike_lighting();
    level waittill( "exit_drive_on_button_pressed" );
    level notify( "player_progressed_to_exit_drive" );
    level.jetbike vehicle_scripts\_jetbike::jetbike_speedometer_on();
    level.jetbike thread maps\detroit_refugee_camp::hoverbike_ride_in_autorumble( 225, "stop_exit_drive_rumbles" );
    level.player thread manage_health_rumble();

    if ( level.nextgen )
    {
        level.burke_bike _meth_846C( "mtl_mil_hoverbike", "m/mtl_mil_hoverbike_emissive" );
        level.burke_bike _meth_846C( "m/mtl_mil_hoverbike_glass", "m/mtl_mil_hoverbike_glass" );
    }
    else
    {
        level.burke_bike _meth_846C( "mtl_mil_hoverbike", "mq/mtl_mil_hoverbike_emissive" );
        level.burke_bike _meth_846C( "mq/mtl_mil_hoverbike_glass", "mq/mtl_mil_hoverbike_glass" );
    }

    common_scripts\utility::flag_set( "exit_drive_started" );
    level.player thread monitor_wheelman();
    level.player thread maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_set( "obj_escape_detroit_on_burke" );

    if ( level.currentgen )
        thread transient_middle_remove_hospital_interior_begin();

    maps\_utility::autosave_by_name();
}

monitor_wheelman()
{
    level.player.wheelman_success = 1;
    thread monitor_jetbike_wheelman();
    thread monitor_player_wheelman();
    common_scripts\utility::flag_wait( "obj_escape_detroit_complete" );

    if ( level.player.wheelman_success )
        maps\_utility::giveachievement_wrapper( "LEVEL_5A" );
}

monitor_jetbike_wheelman()
{
    level endon( "obj_escape_detroit_complete" );

    for (;;)
    {
        var_0 = level.jetbike common_scripts\utility::waittill_any_return_parms( "veh_contact" );

        if ( isdefined( var_0 ) && isarray( var_0 ) )
        {
            var_1 = vectornormalize( var_0[3] );

            if ( var_1[2] < 0.8 )
            {
                if ( isdefined( level.player.wheelman_success ) )
                    level.player.wheelman_success = 0;
            }
        }
    }
}

monitor_player_wheelman()
{
    level endon( "obj_escape_detroit_complete" );

    for (;;)
    {
        var_0 = level.player common_scripts\utility::waittill_any_return( "damage", "death" );
        level.player.wheelman_success = 0;
    }
}

jetbike_allow_player_use_detroit( var_0 )
{
    self makeunusable();
    var_1 = getent( "hoverbike_exit_trigger_usable", "targetname" );
    var_1 _meth_80DB( &"DETROIT_PROMPT_USE" );
    var_2 = var_1 maps\_shg_utility::hint_button_position( "use", var_1.origin, undefined, 200, undefined, var_1 );
    var_1 waittill( "trigger" );
    var_1 delete();
    var_2 maps\_shg_utility::hint_button_clear();
    soundscripts\_snd::snd_message( "exit_ride_jetbike_mount_player" );
    thread vehicle_scripts\_jetbike::jetbike_allow_player_use_internal( var_0 );
    level.doctor hide();
    level.joker hide();
    wait 1.8;
    level.doctor show();
    level.joker show();
}

manage_health_rumble()
{
    self endon( "death" );
    var_0 = level.player.health;
    var_1 = 0;

    for (;;)
    {
        var_1 = level.player.health;

        if ( var_1 < var_0 )
        {
            var_2 = var_0 - var_1;
            thread health_based_rumble( var_2 );
        }

        var_0 = var_1;
        wait 0.05;
    }
}

health_based_rumble( var_0 )
{
    var_1 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
    var_1 maps\_utility::set_rumble_intensity( var_0 / 120 );
    wait 0.3;
    var_1 _meth_80AF( "steady_rumble" );
    var_1 delete();
}

hoverbike_exit_prompt()
{
    var_0 = getent( "hoverbike_exit_trigger_usable", "targetname" ) maps\_shg_utility::hint_button_trigger( "use", 200 );
    level waittill( "hide_hoverbike_exit_prompt" );
    thread hospital_barrel_swap_physics();
    var_0 maps\_shg_utility::hint_button_clear();
}

hospital_barrel_swap_physics()
{
    var_0 = getentarray( "static_barrel_hospital", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 _meth_82C2( var_2.origin, ( 0, 0, 0 ) );
}

jetbike_exitdrive_burke( var_0 )
{
    if ( isdefined( level.burke_bike ) )
        level.burke_bike delete();

    level.burke_bike = maps\_vehicle::spawn_vehicle_from_targetname( "npc_jetbike_burke" );
    level.burke_bike.animname = "burke_bike";
    var_1 = level.burke_bike;
    var_2 = [ level.burke, var_1 ];
    var_0 maps\_anim::anim_reach_solo( level.burke, "det_exit_drive_starting_anim_1" );
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "obj_escape_detroit_on_player_bike" );
    common_scripts\utility::flag_set( "flag_open_door_to_bikes" );
    var_0 thread maps\_anim::anim_single( var_2, "det_exit_drive_starting_anim_1" );
    common_scripts\utility::waittill_any_ents( var_0, "det_exit_drive_starting_anim_1", level, "player_on_exitdrive_jetbike" );

    if ( !common_scripts\utility::flag( "player_on_exitdrive_jetbike" ) )
        var_0 thread maps\_anim::anim_loop( var_2, "det_exit_drive_starting_idle_1", "burke_idle_ender" );

    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    var_0 notify( "burke_idle_ender" );
    var_1 maps\_utility::delaythread( getanimlength( level.burke_bike maps\_utility::getanim( "det_exit_drive_starting_anim_2" ) ) - 0.2, maps\_vehicle::gopath );
    var_0 maps\_anim::anim_single( var_2, "det_exit_drive_starting_anim_2" );
    var_1 _meth_8141();
    level.burke _meth_8141();
    var_1 maps\_utility::guy_enter_vehicle( level.burke );
    var_1.dont_clear_vehicle_anim = 1;
    level notify( "vfx_exit_drive_start" );
    var_1 vehicle_scripts\_jetbike::jetbike_start_hovering_now();
    var_1 _meth_822E();
    var_1 thread maps\detroit_jetbike::handle_glass_collisions();
    var_1 thread maps\detroit_jetbike::handle_contact_collisions();
    level.burke_bike thread jetbike_physics();
    level.jetbike thread jetbike_physics();
    manage_burke_bike_behavior();
}

jetbike_exitdrive_joker_and_doctor( var_0 )
{
    var_1 = [ level.doctor, level.joker, level.joker_bike ];
    var_0 thread maps\_anim::anim_loop_solo( level.joker_bike, "det_exit_drive_starting_idle_1", "jokerbike_idle_ender" );
    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    common_scripts\utility::flag_set( "obj_escape_detroit_on_player_bike_mount" );
    var_0 notify( "jokerbike_idle_ender" );
    level.doctor _meth_804F();
    var_0 maps\_anim::anim_single( var_1, "det_exit_drive_starting_anim_2" );
    common_scripts\utility::flag_set( "doctor_on_bike" );
    var_0 thread maps\_anim::anim_loop( var_1, "det_exit_drive_starting_idle_2", "joker_and_doctor_ender" );
    wait 10;
    level.joker maps\_utility::gun_recall();
    var_0 notify( "joker_and_doctor_ender" );
}

jetbike_exitdrive_bones( var_0 )
{
    var_0 thread maps\_anim::anim_loop_solo( level.bones_bike, "det_exit_drive_starting_idle_1", "bonesbike_idle_ender" );
}

exit_drive_starting_anims_ambient_danger()
{
    common_scripts\utility::flag_wait( "player_on_exitdrive_jetbike" );
    level.player _meth_80EF();
    wait 1;
    thread exit_drive_starting_magic_bullets();
    common_scripts\utility::flag_wait( "exit_drive_started" );
    level.player _meth_80F0();
    var_0 = getentarray( "exit_drive_battle", "targetname" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_4.fixednode = 1;
        var_4.grenadeammo = 0;
        var_4.baseaccuracy = 0.1;
        var_1[var_1.size] = var_4;
        wait 0.5;
    }

    wait 10;

    foreach ( var_4 in var_1 )
        var_4 delete();
}

exit_drive_starting_magic_bullets()
{
    while ( !common_scripts\utility::flag( "exit_drive_started" ) )
    {
        var_0 = undefined;

        switch ( randomintrange( 0, 3 ) )
        {
            case 0:
                var_0 = common_scripts\utility::getstruct( "org_exitdrive_magicbullet_01", "targetname" );
                break;
            case 1:
                var_0 = common_scripts\utility::getstruct( "org_exitdrive_magicbullet_02", "targetname" );
                break;
            case 2:
                var_0 = common_scripts\utility::getstruct( "org_exitdrive_magicbullet_03", "targetname" );
                break;
        }

        var_1 = undefined;

        switch ( randomintrange( 0, 3 ) )
        {
            case 0:
                var_1 = common_scripts\utility::getstruct( "dest_exitdrive_magicbullet_01", "targetname" );
                break;
            case 1:
                var_1 = common_scripts\utility::getstruct( "dest_exitdrive_magicbullet_02", "targetname" );
                break;
            case 2:
                var_1 = common_scripts\utility::getstruct( "dest_exitdrive_magicbullet_03", "targetname" );
                break;
        }

        var_2 = randomintrange( 3, 9 );

        for ( var_3 = 0; var_3 < var_2; var_3++ )
        {
            magicbullet( "iw5_bal27_sp", var_0.origin, var_1.origin );
            wait(randomfloatrange( 0.1, 0.2 ));
        }

        wait(randomfloatrange( 0.4, 1.6 ));
    }
}

setup_exitdrive_encounters()
{
    common_scripts\utility::flag_wait( "exit_drive_started" );
    thread linear_encounter_script();
    thread setup_park_rpg_barrage();
    thread setup_water_crash();
    thread setup_tracks_1();
    thread setup_tracks_2();
    thread setup_final_straightaway_missiles();
    thread setup_final_straightaway_buttresses();
    thread setup_final_straightaway_bus_jump();
    thread setup_final_chopper();
    thread setup_exitdrive_ending_anims();
    thread handle_spotlight_switch();
    thread exit_drive_script_checkpoints();
    thread exit_drive_jump_save_attempt();
    thread exit_drive_timeout_fail();
}

handle_spotlight_switch()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_ending_spot_switch" );
    level notify( "kill_spotlight" );
}

shoot_at_chopper( var_0 )
{
    self endon( "death" );
    var_1 = var_0.origin;
    level endon( "mechs_stop_shooting" );

    for (;;)
    {
        if ( self _meth_8442( "tag_flash" ) != -1 )
        {
            var_2 = self gettagorigin( "tag_flash" );
            var_3 = ( randomfloatrange( -200, 200 ), randomfloatrange( -200, 200 ), randomfloatrange( -200, 200 ) );

            if ( isdefined( var_0 ) )
                var_1 = var_0.origin;
            else
                maps\_utility::notify_delay( "mechs_stop_shooting", 5 );

            var_4 = magicbullet( "heli_minigun_so", var_2, var_1 + var_3 );
            waitframe();
            var_5 = magicbullet( "heli_minigun_so", var_2, var_1 + var_3 );
            waitframe();
            continue;
        }

        waitframe();
    }
}

break_glass_when_near( var_0, var_1, var_2 )
{
    while ( distance( level.player.origin, var_1.origin ) > var_0 )
        waitframe();

    destroyglass( var_2, level.player.origin - var_1.origin );
}

chopper_shoot_straight()
{
    self endon( "chopper_stop_shooting" );

    for (;;)
    {
        var_0 = self gettagorigin( "TAG_MINIGUN_ATTACH_LEFT" );
        var_1 = self gettagorigin( "TAG_MINIGUN_ATTACH_RIGHT" );
        var_2 = maps\_shg_design_tools::offset_position_from_tag( "forward", "TAG_MINIGUN_ATTACH_LEFT", 600 );
        var_3 = maps\_shg_design_tools::offset_position_from_tag( "forward", "TAG_MINIGUN_ATTACH_RIGHT", 600 );
        var_4 = maps\_shg_design_tools::offset_position_from_tag( "forward", "TAG_MINIGUN_ATTACH_LEFT", 100 );
        var_5 = maps\_shg_design_tools::offset_position_from_tag( "forward", "TAG_MINIGUN_ATTACH_RIGHT", 100 );
        var_6 = magicbullet( "heli_minigun_so", var_4, var_2 );
        var_7 = magicbullet( "heli_minigun_so", var_5, var_3 );
        waitframe();
    }
}

chopper_shoot_down()
{
    self endon( "death" );

    for (;;)
    {
        chopper_shoot_down_internal( "TAG_MINIGUN_ATTACH_LEFT" );
        chopper_shoot_down_internal( "TAG_MINIGUN_ATTACH_RIGHT" );
        waitframe();
    }
}

chopper_shoot_down_internal( var_0 )
{
    var_1 = self gettagorigin( var_0 );
    var_2 = self gettagangles( var_0 );
    var_3 = anglestoup( var_2 );
    var_4 = anglestoforward( var_2 );
    var_5 = var_1 + var_4 * 100;
    var_6 = var_1 + var_3 * -1000 + var_4 * 2500;
    var_7 = "heli_minigun_so";

    if ( randomint( 100 ) > 90 )
        var_7 = "mig_25mm_cannon";

    magicbullet( var_7, var_5, var_6 );
}

setup_park_rpg_barrage()
{
    level endon( "missionfailed" );
    var_0 = getent( "spawner_rpg_fire_guy_01", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_1 = getent( "spawner_rpg_fire_guy_02", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_2 = getent( "spawner_rpg_fire_guy_03", "targetname" ) maps\_utility::spawn_ai( 1 );
    var_0 thread kill_when_player_close();
    var_1 thread kill_when_player_close();
    var_2 thread kill_when_player_close();
    var_0.ignoreall = 1;
    var_1.ignoreall = 1;
    var_2.ignoreall = 1;
    var_3 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_01", "targetname" );
    var_4 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_02", "targetname" );
    var_5 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_03", "targetname" );
    common_scripts\utility::flag_wait( "exit_drive_started" );
    maps\_shg_design_tools::waittill_trigger_with_name( "park_missile_01" );
    var_6 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_03", "targetname" );
    var_7 = common_scripts\utility::getstruct( "park_target_01", "targetname" );
    var_8 = magicbullet( "rpg_custom_detroit_exit_drive", var_6.origin, var_7.origin );
    var_8 soundscripts\_snd::snd_message( "exit_drive_rpgs" );
    maps\_shg_design_tools::waittill_trigger_with_name( "park_missile_02" );
    var_6 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_02", "targetname" );
    var_7 = common_scripts\utility::getstruct( "park_target_02", "targetname" );
    var_8 = magicbullet( "rpg_custom_detroit_exit_drive", var_6.origin, var_7.origin );
    var_8 soundscripts\_snd::snd_message( "exit_drive_rpgs" );
    maps\_shg_design_tools::waittill_trigger_with_name( "park_missile_03" );
    var_6 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_03", "targetname" );
    var_7 = common_scripts\utility::getstruct( "park_target_03", "targetname" );
    var_8 = magicbullet( "rpg_custom_detroit_exit_drive", var_6.origin, var_7.origin );
    var_8 soundscripts\_snd::snd_message( "exit_drive_rpgs" );
    maps\_shg_design_tools::waittill_trigger_with_name( "park_missile_05" );
    var_6 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_01", "targetname" );
    var_7 = common_scripts\utility::getstruct( "park_target_05", "targetname" );
    var_8 = magicbullet( "rpg_custom_detroit_exit_drive", var_6.origin, var_7.origin );
    var_8 soundscripts\_snd::snd_message( "exit_drive_rpgs" );
    maps\_shg_design_tools::waittill_trigger_with_name( "park_missile_07" );
    var_6 = common_scripts\utility::getstruct( "struct_rpg_fire_loc_03", "targetname" );
    var_7 = common_scripts\utility::getstruct( "park_target_07", "targetname" );
    var_8 = magicbullet( "rpg_custom_detroit_exit_drive", var_6.origin, var_7.origin );
    var_8 soundscripts\_snd::snd_message( "exit_drive_rpgs" );
}

exit_drive_script_checkpoints()
{
    maps\_utility::trigger_wait_targetname( "park_missile_02" );
    maps\_utility::autosave_by_name( "exit drive dealership" );
}

kill_when_player_close()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = distance2d( self.origin, level.player.origin );

        if ( var_0 < 150 )
        {
            self _meth_8052();
            return;
        }

        wait 0.05;
    }
}

linear_encounter_script()
{
    var_0 = getentarray( "pitbull_refugee_camp", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    common_scripts\utility::flag_wait( "exit_drive_started" );
    level notify( "ok_to_stop_sentinel_reveal_warnings" );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_chopper_initial" );
    var_4 soundscripts\_snd::snd_message( "exitdrive_chopper_initial" );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_00a" );
    var_4 soundscripts\_snd::snd_message( "exitdrive_chopper_initial_gopath" );
    var_4 maps\_vehicle::gopath();
    var_4 thread maps\detroit_lighting::trigger_chopper_spotlight_follow( level.burke_bike, 0 );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_01a" );
    var_5 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_vehicle_warehouse_02" );
    var_5 _meth_80B1( "vehicle_mil_humvee_cleaner_01_ai" );
    var_5 maps\_vehicle::gopath();
    var_5 thread maps\detroit::setup_cleanup_vehicle();
    var_5 thread vehicle_matchspeed( level.jetbike, 8 );
    var_5 soundscripts\_snd::snd_message( "warehouse_chase_vehicle_01" );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_01b" );
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_vehicle_warehouse_03" );
    var_6 _meth_80B1( "vehicle_mil_humvee_cleaner_01_ai" );
    var_6 maps\_vehicle::gopath();
    var_6 thread maps\detroit::setup_cleanup_vehicle();
    var_6 thread vehicle_matchspeed( level.jetbike );
    var_6 soundscripts\_snd::snd_message( "warehouse_chase_vehicle_02" );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_01c" );
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_vehicle_warehouse_04" );
    var_7 _meth_80B1( "vehicle_mil_humvee_cleaner_01_ai" );
    var_7 maps\_vehicle::gopath();
    var_7 soundscripts\_snd::snd_message( "gaz_store_shootout_drive" );
    var_7 thread maps\detroit::setup_cleanup_vehicle();
    var_7 thread vehicle_matchspeed( level.jetbike, -5 );
    var_7 soundscripts\_snd::snd_message( "warehouse_chase_vehicle_03" );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_01d" );
    thread trigger_store_drive_sequence( var_5, var_6, var_7 );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_02a" );
    var_5 thread vehicle_matchspeed( level.jetbike, 25 );
    var_6 thread vehicle_matchspeed( level.jetbike, 25 );
    var_7 thread vehicle_matchspeed( level.jetbike, 25 );
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_02ab" );
    var_5 thread vehicle_matchspeed( level.jetbike, 4 );
    var_6 thread vehicle_matchspeed( level.jetbike, 4 );
    var_7 thread vehicle_matchspeed( level.jetbike, 4 );
}

trigger_store_drive_sequence( var_0, var_1, var_2 )
{
    var_0.maxhealth = 30000;
    var_0.health = var_0.maxhealth;
    var_0 thread make_shooter_car( 1 );
    var_1.maxhealth = 30000;
    var_1.health = var_1.maxhealth;
    var_1 thread make_shooter_car();
    var_2.maxhealth = 30000;
    var_2.health = var_2.maxhealth;
    var_2 thread make_shooter_car();
    var_3 = [ var_0, var_1, var_2 ];
    maps\_shg_design_tools::waittill_trigger_with_name( "exitdrive_trigger_02a" );
    wait 2.0;
    level notify( "cars_stop_shooting" );
}

make_shooter_car( var_0 )
{
    self endon( "death" );
    level endon( "cars_stop_shooting" );
    soundscripts\_snd::snd_message( "warehouse_car_shots", "cars_stop_shooting" );

    for (;;)
    {
        var_1 = self;
        var_2 = "heli_minigun_so";
        var_3 = var_1 maps\_shg_design_tools::offset_position_from_tag( "up", "tag_origin", 115 );
        var_4 = level.jetbike maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 500 );
        var_5 = ( randomfloat( 15 ), randomfloat( 15 ), randomfloat( 15 ) );
        var_2 = magicbullet( var_2, var_3, var_4 + var_5 );
        waitframe();

        if ( level.nextgen )
        {
            if ( maps\_shg_design_tools::percentchance( 2 ) )
                wait 2;

            continue;
        }

        for ( var_6 = 0; var_6 < 7; var_6++ )
            waitframe();

        if ( maps\_shg_design_tools::percentchance( 2 ) )
            wait 2;
    }
}

setup_tracks_1()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_exitdrive_slowmo_jump_end" );
    maps\detroit_lighting::kill_spotlight();
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_chopper_tracks_1" );
    var_0 thread maps\detroit_lighting::trigger_chopper_spotlight_straight( 1 );
    var_0 soundscripts\_snd::snd_message( "exitdrive_chopper_tracks_1" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_chopper_tracks_1" );
    var_0 soundscripts\_snd::snd_message( "exitdrive_chopper_tracks_1_gopath" );
    var_0 maps\_vehicle::gopath();
    wait 3;
    var_0 thread chopper_shoot_down();
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_rail_dodge_01a" );
    var_0 delete();
}

setup_tracks_2()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trigger_rail_dodge_01a" );
    common_scripts\utility::flag_set( "lightning_on" );
    var_0 = getentarray( "curve_path_01", "targetname" );
    var_1 = getent( "curve_path_01_start", "targetname" );
    var_2 = getentarray( "curve_path_02", "targetname" );
    var_3 = getent( "curve_path_02_start", "targetname" );
    var_4 = getentarray( "exit_train3_path", "targetname" );
    var_5 = getent( "exit_train3_start", "targetname" );
    var_6 = run_train( var_1, var_0, 900, undefined, "rail_dodge_car_clip_1" );
    var_6 soundscripts\_snd::snd_message( "exit_train_by", 1 );
    wait 1.5;
    var_7 = run_train( var_3, var_2, 600, undefined, "rail_dodge_car_clip_2" );
    var_7 soundscripts\_snd::snd_message( "exit_train_by", 2 );
    var_8 = 0.52;
    var_9 = 0;

    for ( var_10 = 3; var_10 < 13; var_10++ )
    {
        if ( var_10 == 3 )
            var_11 = run_train( var_5, var_4, 800, undefined, "rail_dodge_car_clip_" + var_10 );
        else
            var_11 = run_train( var_5, var_4, 800, undefined, "rail_dodge_car_clip_" + var_10 );

        if ( !var_9 )
        {
            var_11 soundscripts\_snd::snd_message( "exit_train_by", 3 );
            var_9 = 1;
        }

        wait(var_8);
    }
}

setup_water_crash()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "gaz_water_crash_01" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname( "gaz_water_crash_02" );
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_exit_water_jeep_01" );
    common_scripts\utility::flag_set( "burke needs to stop rubber banding now" );
    level.burke_bike notify( "vehicle_rubberband_stop" );
    level.burke_bike _meth_8283( 45, 10, 15 );
    wait 1.0;
    var_0 _meth_80B1( "vehicle_mil_humvee_cleaner_01_ai" );
    var_1 _meth_80B1( "vehicle_mil_humvee_cleaner_01_ai" );
    level.player.ignoreme = 1;
    var_0.mgturret[0] thread animscripts\hummer_turret\common::set_manual_target( level.burke, 999, 9999, "turret_stop_firing" );
    var_0 maps\_vehicle::gopath();
    var_0 thread exit_drive_gaz_physics();
    var_0 soundscripts\_snd::snd_message( "gaz_water_crash_01" );
    var_0 maps\_vehicle::vehicle_lights_on( "headlights_cheap" );
    var_0 thread keep_up_with_burke();
    wait 0.25;
    var_1 maps\_vehicle::gopath();
    var_1 thread exit_drive_gaz_physics();
    var_1 soundscripts\_snd::snd_message( "gaz_water_crash_02" );
    var_1 maps\_vehicle::vehicle_lights_on( "headlights_cheap" );
    var_1 thread keep_up_with_burke();
    common_scripts\utility::flag_wait( "flag_fan_out" );
    var_1 maps\detroit_jetbike::vehicle_rubberband( level.burke_bike, -500 );
    common_scripts\utility::flag_wait( "flag_water_crash_1" );
    level.burke_bike thread maps\detroit_jetbike::vehicle_rubberband_set_desired_range( 400 );
    level.burke_bike thread maps\detroit_jetbike::vehicle_rubberband_think();
    var_0 soundscripts\_snd::snd_message( "gaz_water_crashed", var_1 );
    level.burke.ignoreme = 1;
    var_0.mgturret[0] notify( "turret_stop_firing" );
    wait 0.25;
    physicsexplosionsphere( var_0.origin + ( 50, 0, 0 ), 200, 50, 3 );
    common_scripts\utility::flag_wait( "flag_water_crash_2" );
    wait 0.25;
    physicsexplosionsphere( var_1.origin - ( 50, 0, 0 ), 200, 50, 3 );
    level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range( 1000 );
}

burke_bike_speed()
{
    for (;;)
    {
        iprintln( level.burke_bike.speed );
        wait 0.5;
    }
}

keep_up_with_burke()
{
    for (;;)
    {
        if ( isdefined( self ) )
        {
            self _meth_8283( level.burke_bike.speed, 15, 10 );
            wait 0.05;
        }
    }
}

water_crash_jeep_1( var_0 )
{
    var_1 = getent( "jeep_pusher_1", "targetname" );
    var_2 = var_1 common_scripts\utility::get_target_ent();
    var_2 _meth_804D( var_1 );
    var_1 hide();
    common_scripts\utility::flag_wait( "flag_water_crash_jeep_1" );
    var_3 = 0.075;
    var_1 _meth_82AE( var_1.origin + ( 0, 0, 50 ), var_3, 0.0, 0.0 );
    wait(var_3 + 0.2);
    physicsexplosionsphere( var_0.origin + ( 50, 0, 0 ), 100, 80, 1 );
    var_1 _meth_82AE( var_1.origin - ( 0, 0, 50 ), 0.05, 0.0, 0.0 );
    var_2 _meth_82BF();
    var_0 _meth_8283( 0, 50, 50 );
}

water_crash_jeep_2( var_0 )
{
    var_1 = getent( "jeep_pusher_2", "targetname" );
    var_2 = var_1 common_scripts\utility::get_target_ent();
    var_2 _meth_804D( var_1 );
    var_1 hide();
    common_scripts\utility::flag_wait( "flag_water_crash_jeep_2" );
    var_3 = 0.085;
    var_1 _meth_82AE( var_1.origin + ( 0, 0, 50 ), var_3, 0.0, 0.0 );
    wait(var_3 + 0.2);
    physicsexplosionsphere( var_0.origin - ( 50, 0, 0 ), 100, 80, 1 );
    var_1 _meth_82AE( var_1.origin - ( 0, 0, 50 ), 0.05, 0.0, 0.0 );
    var_2 _meth_82BF();
    var_0 _meth_8283( 0, 50, 50 );
}

exit_drive_gaz_physics()
{
    level endon( "flag_water_crash_1" );
    level endon( "flag_water_crash_2" );
    var_0 = 74;
    var_1 = 200;
    var_2 = 200;
    var_3 = -100;
    var_4 = 0.06;

    for (;;)
    {
        var_5 = var_4;
        var_6 = self.origin + anglestoforward( self.angles ) * var_2 + anglestoup( self.angles ) * var_3;

        if ( level.nextgen )
            _func_244( var_6, var_1 );
        else
            physicsexplosionsphere( var_6, var_1, var_0, var_5, 0 );

        wait 0.05;
    }
}

setup_final_chopper()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_exit_water_jeep_01" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "exitdrive_chopper_final" );
    level.final_scripted_chopper = var_0;
    var_0 soundscripts\_snd::snd_message( "exitdrive_chopper_final" );
    maps\detroit_lighting::kill_spotlight();
    maps\_shg_design_tools::waittill_trigger_with_name( "trig_final_chopper" );
    var_0 soundscripts\_snd::snd_message( "exitdrive_chopper_final_gopath" );
    var_0 maps\_vehicle::gopath();
    wait 1.0;
    var_0 thread maps\detroit_lighting::trigger_chopper_spotlight_follow( level.burke_bike, 0 );
    common_scripts\utility::flag_wait( "flag_chopper_match_speed" );
    var_0 thread maps\detroit_jetbike::vehicle_rubberband( level.jetbike, -400 );
}

setup_final_straightaway_missiles()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_01" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_01", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_01", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_02" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_02", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_02", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_03" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_03", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_03", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_04" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_04", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_04", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_05" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_05", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_05", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_06" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_06", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_06", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_07" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_07", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_07", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_08" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_08", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_08", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_09" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_09", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_09", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_10" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_10", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_10", "targetname" );
    var_3 = common_scripts\utility::getstruct( "final_straightaway_target_10b", "targetname" );
    var_4 = common_scripts\utility::getstruct( "final_straightaway_target_10c", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    wait 0.4;
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_4.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    wait 0.3;
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_3.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_14" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_14", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_14", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_15" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_15", "targetname" );
    var_1 = common_scripts\utility::getstruct( "final_straightaway_target_15", "targetname" );
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1.origin );
    var_2 soundscripts\_snd::snd_message( "collapsing_buttress_missile" );
}

setup_final_straightaway_buttresses()
{
    common_scripts\utility::flag_wait( "exit_drive_started" );
    var_0 = getentarray( "collapsing_buttress_04", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 delete();

    wait 1;
    maps\_utility::disable_trigger_with_targetname( "trigger_buttress_fail_01" );
    maps\_utility::disable_trigger_with_targetname( "trigger_buttress_fail_03" );
    var_4 = 3.25;
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_02" );
    wait 0.4;
    maps\_utility::delaythread( var_4 - 1, maps\_utility::enable_trigger_with_targetname, "trigger_buttress_fail_01" );
    maps\_utility::delaythread( var_4 + 1, maps\_utility::disable_trigger_with_targetname, "trigger_buttress_fail_01" );
    var_5 = getentarray( "collapsing_buttress_01", "targetname" );
    var_5 soundscripts\_snd::snd_message( "collapsing_buttress_01" );

    foreach ( var_2 in var_5 )
        var_2 delete();

    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_04" );
    wait 0.4;
    var_8 = getentarray( "collapsing_buttress_02", "targetname" );
    var_8 soundscripts\_snd::snd_message( "collapsing_buttress_02" );

    foreach ( var_2 in var_8 )
        var_2 delete();

    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_missile_07" );
    wait 0.4;
    maps\_utility::delaythread( var_4 - 1, maps\_utility::enable_trigger_with_targetname, "trigger_buttress_fail_03" );
    maps\_utility::delaythread( var_4 + 1, maps\_utility::disable_trigger_with_targetname, "trigger_buttress_fail_03" );
    var_11 = getentarray( "collapsing_buttress_03", "targetname" );
    var_11 soundscripts\_snd::snd_message( "collapsing_buttress_03" );

    foreach ( var_2 in var_11 )
        var_2 delete();
}

setup_final_straightaway_bus_jump()
{
    maps\_shg_design_tools::waittill_trigger_with_name( "final_straightaway_bus_jump" );
    var_0 = common_scripts\utility::getstruct( "final_straightaway_org_bus_jump", "targetname" );
    var_1 = level.jetbike.origin + ( 50, 0, 200 );
    wait 0.5;
    var_2 = magicbullet( "sidewinder_warhawk_aftermath", var_0.origin, var_1 );
}

drawstringtime( var_0, var_1, var_2, var_3 )
{
    var_4 = var_3 * 20;

    for ( var_5 = 0; var_5 < var_4; var_5++ )
        wait 0.05;
}

#using_animtree("script_model");

setup_exitdrive_ending_anims()
{
    var_0 = getent( "detroit_entrance_gate", "targetname" );
    var_0.animname = "gate";
    var_0 _meth_8115( #animtree );
    var_1 = getent( "exit_drive_ending", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "det_exit_drive_ending" );
    common_scripts\utility::flag_wait( "exitdrive_ending_approach" );
    thread maps\detroit_lighting::ending_mech_lighting();
    common_scripts\utility::flag_clear( "exitdrive_lights_on" );
    var_2 = getent( "org_mech1_final_stand", "targetname" );
    var_3 = getent( "org_mech2_final_stand", "targetname" );
    var_4 = getent( "org_mech3_final_stand", "targetname" );
    var_5 = getent( "exit_drive_mech1", "targetname" );
    var_6 = getent( "exit_drive_mech2", "targetname" );
    var_7 = getent( "exit_drive_mech3", "targetname" );
    var_8 = "det_exit_drive_ending_idle";
    var_9 = "mech_cover_idle_end";
    var_10 = var_5 maps\_utility::spawn_ai( 1 );
    var_11 = var_6 maps\_utility::spawn_ai( 1 );
    var_12 = var_7 maps\_utility::spawn_ai( 1 );
    thread maps\detroit_lighting::mech_exit_gate_lighting( var_12 );
    var_10.ignoreall = 1;
    var_11.ignoreall = 1;
    var_12.ignoreall = 1;
    var_13 = [];
    var_13[var_13.size] = var_10;
    var_13[var_13.size] = var_11;
    var_13[var_13.size] = var_12;
    thread maps\detroit_lighting::move_mech_origins( var_13 );
    var_10.animname = "exitdrive_mech1";
    var_11.animname = "exitdrive_mech2";
    var_12.animname = "exitdrive_mech3";
    var_1 thread maps\_anim::anim_loop( var_13, var_8, var_9 );
    thread exitdrive_ending_anims_burke();
    level notify( "vfx_player_jetbike_stops" );
    common_scripts\utility::flag_clear( "exit_drive_ending_begin_player" );
    common_scripts\utility::flag_wait( "exit_drive_ending_begin_player" );
    common_scripts\utility::flag_set( "obj_escape_detroit_complete" );
    soundscripts\_snd::snd_message( "exit_drive_ending_begin" );
    prep_cinematic( "fusion_endlogo" );
    var_14 = level.jetbike maps\_utility::spawn_anim_model( "world_body", level.player.origin );
    level.jetbike thread maps\_anim::anim_first_frame_solo( var_14, "det_exit_drive_ending", "tag_passenger" );
    waittillframeend;
    var_14 _meth_804D( level.jetbike, "tag_passenger" );
    var_14 hide();
    level.jetbike vehicle_scripts\_jetbike::jetbike_blend_out_fake_speed( 1.5 );
    maps\_utility::delaythread( 5, common_scripts\utility::flag_set, "stop_exit_drive_rumbles" );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( level.jetbike, var_1, "det_exit_drive_ending", 41.2365, 1.5 );
    var_1 notify( var_9 );
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    var_15 = maps\_utility::spawn_anim_model( "littlebird" );
    thread maps\detroit_lighting::final_chopper_lighting( var_15 );
    var_15.spotlight = level.final_scripted_chopper.spotlight;
    level.final_scripted_chopper delete();
    var_15 thread maps\detroit_lighting::trigger_chopper_spotlight_follow( level.burke_bike, 1 );
    thread exitdrive_ending_anims_player( var_1, var_14 );
    var_13[var_13.size] = level.bones;
    var_13[var_13.size] = level.bones_bike;
    var_13[var_13.size] = level.joker;
    var_13[var_13.size] = level.joker_bike;
    var_13[var_13.size] = level.doctor;
    var_13[var_13.size] = var_15;
    var_13[var_13.size] = var_0;
    var_1 thread maps\_anim::anim_single( var_13, "det_exit_drive_ending" );
    level waittill( "detroit_final_chopper_hit" );
    level notify( "kill_spotlight" );
    level waittill( "detroit_level_fadeout" );
    var_16 = 6;
    thread ending_fade_out( var_16 );
    maps\_player_exo::player_exo_deactivate();
    maps\_utility::delaythread( 3, maps\_utility::nextmission );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    wait(var_16);
}

exitdrive_ending_anims_player( var_0, var_1 )
{
    thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play( level.jetbike, var_0, "det_exit_drive_ending", [], 0, 0.5 );
    waittillframeend;
    level.jetbike thread maps\_anim::anim_single_solo( var_1, "det_exit_drive_ending", "tag_passenger" );
    level.jetbike _meth_8117( level.jetbike maps\_utility::getanim( "det_exit_drive_ending" ), 0 );
    var_1 _meth_8117( var_1 maps\_utility::getanim( "det_exit_drive_ending" ), 0 );
    var_1 show();
    level.jetbike vehicle_scripts\_jetbike::jetbike_stop_player_use();
    level.jetbike _meth_8445( 0 );
    level.player _meth_807D( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait 1.5;
    maps\detroit::controller_rumble_heavy3();
    wait 2.85;
    maps\detroit::controller_rumble_heavy0();
    wait 2;
    maps\detroit::controller_rumble_heavy0();
    wait 0.9;
    maps\detroit::controller_rumble_heavy0();
    wait 0.35;
    maps\detroit::controller_rumble_heavy0();
    wait 0.35;
    maps\detroit::controller_rumble_heavy0();
    wait 0.35;
    maps\detroit::controller_rumble_heavy0();
    wait 0.35;
    maps\detroit::controller_rumble_heavy1();
    wait 1.5;
    maps\detroit::controller_rumble_light3();
    wait 1;
    maps\detroit::controller_rumble_light3();
    wait 2;
    maps\detroit::controller_rumble_heavy2();
    wait 1.5;
    maps\detroit::controller_rumble_heavy2();
    wait 1;
    maps\detroit::controller_rumble_heavy2();
    wait 1;
    maps\detroit::controller_rumble_heavy3();
}

prep_cinematic( var_0 )
{
    _func_0D3( "cg_cinematicFullScreen", "0" );
    _func_057( var_0, 1 );
    level.current_cinematic = var_0;
}

play_cinematic( var_0, var_1, var_2 )
{
    if ( isdefined( level.current_cinematic ) )
    {
        pausecinematicingame( 0 );
        _func_0D3( "cg_cinematicFullScreen", "1" );
        level.current_cinematic = undefined;
    }
    else
        _func_057( var_0 );

    if ( !isdefined( var_2 ) || !var_2 )
        _func_0D3( "cg_cinematicCanPause", "1" );

    wait 1;

    while ( _func_05B() )
        wait 0.05;

    if ( !isdefined( var_2 ) || !var_2 )
        _func_0D3( "cg_cinematicCanPause", "0" );
}

ending_fade_out( var_0 )
{
    var_1 = newhudelem();
    var_1.x = 0;
    var_1.y = 0;
    var_1.horzalign = "fullscreen";
    var_1.vertalign = "fullscreen";
    var_1 _meth_80CC( "black", 640, 480 );

    if ( isdefined( var_0 ) && var_0 > 0 )
    {
        var_1.alpha = 0;
        var_1 fadeovertime( var_0 );
        var_1.alpha = 1;
        wait(var_0);
    }

    waittillframeend;
    var_1 destroy();
}

anim_debug( var_0, var_1 )
{
    for (;;)
    {
        waittillframeend;
        waittillframeend;
        waittillframeend;
        waittillframeend;
        waittillframeend;
        waittillframeend;
        var_2 = var_1 maps\_utility::getanim( "det_exit_drive_ending" );
        var_3 = var_1 _meth_814F( var_2 );
        var_4 = var_3 * getanimlength( var_2 );
        var_5 = var_1 _meth_8150( var_2 );
        var_6 = var_0 maps\_utility::getanim( "det_exit_drive_ending" );
        var_7 = var_0 _meth_814F( var_6 );
        var_8 = var_7 * getanimlength( var_6 );
        var_9 = var_0 _meth_8150( var_6 );
        wait 0.05;
    }
}

exitdrive_ending_anims_burke()
{
    var_0 = getent( "exit_drive_ending", "targetname" );
    common_scripts\utility::flag_wait( "exit_drive_ending_begin_burke" );
    vehicle_scripts\_jetbike::smooth_vehicle_animation_wait( level.burke_bike, var_0, "det_exit_drive_ending", 53.0937 );
    level.burke maps\_vehicle_aianim::disassociate_guy_from_vehicle();
    level.burke _meth_804F();
    thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play( level.burke_bike, var_0, "det_exit_drive_ending", [ level.burke ], 0, 0.25 );
}

delete_self_on_death_of( var_0 )
{
    var_0 waittill( "death" );
    self delete();
}

run_train( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 650;
    var_6 = 3;

    if ( !isdefined( var_3 ) )
    {
        var_7 = "vehicle_civ_det_train_car_01";
        var_3 = spawn( "script_model", var_0.origin );
        var_3 _meth_80B1( var_7 );
    }

    var_8 = undefined;

    if ( isdefined( var_4 ) )
    {
        var_8 = getent( var_4, "targetname" );
        var_8 thread delete_self_on_death_of( var_3 );
    }

    var_9 = common_scripts\utility::spawn_tag_origin();
    var_9 _meth_804D( var_3, "", ( 300, 0, 80 ), ( 25, 0, 0 ) );
    var_10 = common_scripts\utility::spawn_tag_origin();
    var_10 _meth_804D( var_3, "", ( 300, 0, 80 ), ( 0, 0, 0 ) );
    var_11 = common_scripts\utility::spawn_tag_origin();
    var_11 _meth_804D( var_3, "", ( 200, 0, 15 ), ( 0, 90, 0 ) );
    thread maps\detroit_lighting::train_lighting( var_9, var_10, var_11 );

    if ( !isdefined( var_3.tags ) )
        var_3.tags = [];

    var_3.tags[var_3.tags.size] = var_9;
    var_3.tags[var_3.tags.size] = var_10;
    var_3.tags[var_3.tags.size] = var_11;
    var_3.origin = var_0.origin;
    var_3.angles = var_0.angles;
    var_1 = sortbydistance( var_1, var_0.origin );
    var_3 thread maps\detroit_streets::train_gopath( var_1, var_2, var_8 );
    return var_3;
}

run_train_shaker( var_0, var_1 )
{
    self endon( "train_delete" );
    self endon( "train_shutdown" );
    self endon( "death" );

    for (;;)
    {
        var_2 = distance( self.origin, level.player.origin );

        if ( var_2 < var_0 )
        {
            earthquake( 0.4, var_1, self.origin, var_0 );
            wait(var_1);
        }

        waitframe();
    }
}

delete_on_notify( var_0, var_1 )
{
    var_0 endon( "death" );
    self waittill( var_1 );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

player_proximity_rumble( var_0 )
{
    while ( isdefined( self ) )
    {
        if ( !isdefined( var_0 ) )
            var_0 = 850;

        when_am_i_near_player( var_0 );
        var_1 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
        var_1 thread rumble_till_out_of_range( var_0, self );
        return;
    }

    level notify( "rumble_stop_train" );
}

exit_drive_jump_save_attempt()
{
    maps\_utility::trigger_wait_targetname( "attempt_to_save_by_jump" );
    var_0 = distance( level.burke.origin, level.player.origin );

    if ( var_0 < 2000 )
        maps\_utility::autosave_by_name();
}

exit_drive_timeout_fail()
{
    common_scripts\utility::flag_wait( "flag_gate_in_sight" );
    level endon( "exit_drive_ending_begin_player" );
    wait 5;
    common_scripts\utility::flag_set( "flag_jetbike_fail" );
}

rumble_till_out_of_range( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0.8;

    if ( !isdefined( var_3 ) )
        var_3 = 150;

    for (;;)
    {
        if ( isdefined( var_1 ) )
        {
            var_4 = distance( var_1.origin, level.player.origin );

            if ( var_4 >= var_0 )
                maps\_utility::set_rumble_intensity( 0.01 );

            if ( var_4 < var_0 )
            {
                if ( var_4 == 0 )
                    var_4 = 1;

                var_5 = var_2 / ( var_4 / var_3 );

                if ( var_5 > 1 )
                    var_5 = 1;

                maps\_utility::set_rumble_intensity( var_5 );
            }
        }

        if ( !isdefined( var_1 ) )
        {
            level notify( "rumble_stop_train" );
            self _meth_80AF( "steady_rumble" );
            return;
        }

        wait 0.05;
    }
}

when_am_i_near_player( var_0 )
{
    while ( isdefined( self ) )
    {
        if ( distance2d( self.origin, level.player.origin ) < var_0 )
            return;

        wait 0.05;
    }
}

stop_rumble_on_notify( var_0 )
{
    level waittill( var_0 );
    self _meth_80AF( "steady_rumble" );
}

vehicle_matchspeed( var_0, var_1, var_2 )
{
    self endon( "death" );
    self notify( "kill_vehicle_matchspeed" );
    self endon( "kill_vehicle_matchspeed" );
    var_0 endon( "death" );
    var_3 = 0;

    if ( isdefined( var_1 ) )
        var_3 = randomfloat( var_1 );

    for (;;)
    {
        var_4 = var_0 _meth_8286();

        if ( isdefined( var_2 ) )
            var_4 += var_2;

        var_5 = var_4 + var_3;

        if ( var_5 < 0 )
            var_5 = 0;

        self _meth_8283( var_5, 60, 60 );
        waitframe();
    }
}

cleanup_school_cars()
{
    common_scripts\utility::flag_wait( "school_jeep_delete" );
    var_0 = getent( "cleanup_vehicle_outside_school_clip", "targetname" );
    var_0 delete();
    var_1 = getent( "cleanup_vehicle_outside_school", "targetname" );
    var_1 delete();
    maps\detroit_school::cg_open_close_school_entrance_doors( 0 );
    maps\detroit_lighting::turn_off_jeep_light();
}
