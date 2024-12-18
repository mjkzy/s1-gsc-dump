// S1 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

penthouse_start()
{
    level.start_point_scripted = "meet_cormack";
    maps\irons_estate::irons_estate_objectives();
    maps\irons_estate_code::spawn_player_checkpoint();
    maps\irons_estate_code::spawn_allies();
    thread maps\irons_estate_infil::poolhouse_enemies();
    thread ie_west_enemies();
    thread guesthouse_enemies();
    thread maps\irons_estate_civilians::ie_west_civilian_vignettes();
    thread maps\irons_estate_code::tennis_court_floor( 1 );
    thread maps\irons_estate_code::player_kill_trigger( "waterfall_top_kill_trigger" );
    thread maps\irons_estate_security_center::security_center_fan_blades();
    soundscripts\_snd::snd_message( "start_penthouse" );
    common_scripts\utility::flag_set( "player_in_estate" );
}

penthouse_main()
{
    level.start_point_scripted = "meet_cormack";
    thread penthouse_begin();
    common_scripts\utility::flag_wait( "penthouse_end" );
    maps\_utility::autosave_stealth();
}

penthouse_begin()
{
    common_scripts\utility::flag_set( "penthouse_start" );
    level.player.grapple["dist_max"] = 800;
    thread maps\irons_estate_code::handle_player_abandoned_mission( "iln" );
    thread penthouse_vo();
    thread penthouse_objective();
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_1" );
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_2" );
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_2a" );
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_3" );
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_4" );
    thread maps\irons_estate_code::irons_estate_trigger_saves( "penthouse_end", "player_enters_front_yard_save_5" );
    thread maps\irons_estate_code::generic_enemy_vo_chatter( "player_entered_balcony_door" );
    thread ilona_generic_update_vo();
    thread tennis_court();
    common_scripts\utility::flag_wait( "player_enters_front_yard_save_1" );
    thread vtol_flyover();
    common_scripts\utility::flag_wait( "player_enters_front_yard_save_4" );
    maps\_utility::delaythread( 4, maps\irons_estate_code::corpse_cleanup );
}

vtol_flyover()
{
    var_0 = common_scripts\utility::getstruct( "vtol_struct", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "vtol", ( 0, 0, 0 ) );
    var_1.grapple_magnets = [];
    soundscripts\_snd::snd_message( "aud_vtol_land", var_1 );
    var_1 thread vtol_fx_land();
    var_0 thread maps\_anim::anim_single_solo( var_1, "cormack_stealth_takedown" );
    var_1 waittillmatch( "single anim", "end" );
    var_1 delete();
}

vtol_fx_land()
{
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_LT_WING_LIGHT_FX" );
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_RT_WING_LIGHT_FX" );
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_LT_WING_LIGHT_FX" );
    playfxontag( level._effect["ie_vtol_wtip_light_red_blink"], self, "TAG_RT_WING_LIGHT_FX" );
    wait 0.05;
    playfxontag( level._effect["ie_vtol_wtip_light_tail_red"], self, "tag_light_L_wing" );
    playfxontag( level._effect["ie_vtol_wtip_light_tail_red"], self, "tag_light_R_wing" );
    playfxontag( level._effect["ie_vtol_wtip_light_tail_red"], self, "tag_light_L_tail" );
    playfxontag( level._effect["ie_vtol_wtip_light_tail_red"], self, "tag_light_R_tail" );
    wait 0.05;
    playfxontag( level._effect["vtol_exhaust_l"], self, "TAG_LT_WING_EXHAUSE_FX" );
    playfxontag( level._effect["vtol_exhaust_r"], self, "TAG_RT_WING_EXHAUSE_FX" );
    wait 10.0;
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_RI_1" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_RI_2" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_RI_3" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_RI_4" );
    wait 0.05;
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_LE_1" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_LE_2" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_LE_3" );
    playfxontag( level._effect["vtol_engine_land"], self, "TAG_FX_ENGINE_LE_4" );
}

penthouse_vo()
{
    wait 1.0;
    maps\_utility::smart_radio_dialogue( "ie_crmk_regroup" );
    wait 0.5;
    maps\_utility::smart_radio_dialogue( "ie_iln_movingposition" );
    wait 0.5;
    level.play_ally_warning_vo = 1;
    level.play_ally_callout_vo = 1;
    thread maps\irons_estate_code::enemy_callout_vo( "iln" );
    thread maps\irons_estate_code::drone_incoming_vo( "iln" );
    thread maps\irons_estate_code::clean_kill_vo( "iln" );
    maps\irons_estate_code::enemy_alert_vo_setup( "iln" );
    thread maps\irons_estate_code::failed_vo( "iln" );
    thread maps\irons_estate_code::dont_shoot_warning_vo( "iln" );
    thread maps\irons_estate_code::exposed_group_logic();
    common_scripts\utility::flag_wait( "overlook_obj_trigger" );
    level.play_ally_warning_vo = undefined;
    level.play_ally_callout_vo = undefined;
    level.ally_vo_org stopsounds();
    wait 0.05;
    maps\_utility::smart_radio_dialogue( "ie_iln_inposition" );
    level.play_ally_warning_vo = 1;
    level.play_ally_callout_vo = 1;
    thread pre_guesthouse_vo();
    thread guest_house_vo();
    common_scripts\utility::flag_wait( "penthouse_end_ready" );
    level.ally_vo_org stopsounds();
    wait 0.05;
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].vo = "ie_iln_driveway";
    var_0[0].vo_priority = 7;
    var_0[1] = spawnstruct();
    var_0[1].vo = "ie_iln_onbalcony";
    var_0[1].vo_priority = 7;
    wait 1;
    maps\irons_estate_code::ally_vo_controller( var_0[0] );
    wait 0.5;
    maps\irons_estate_code::ally_vo_controller( var_0[1] );
}

pre_guesthouse_vo()
{
    level endon( "guesthouse_balcony_enemy_1_dead" );
    level endon( "guesthouse_balcony_enemy_2_dead" );
    level endon( "player_enters_front_yard_save_4" );
    common_scripts\utility::flag_wait( "two_on_balcony_vo" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
        return;

    level.play_ally_warning_vo = undefined;
    level.play_ally_callout_vo = undefined;
    level.ally_vo_org stopsounds();
    wait 0.05;
    maps\_utility::smart_radio_dialogue( "ie_iln_shadows" );
    level.play_ally_warning_vo = 1;
    level.play_ally_callout_vo = 1;
}

guest_house_vo()
{
    level endon( "player_enters_front_yard_save_4" );
    common_scripts\utility::flag_wait( "spawn_civilian_guesthouse_walkin" );
    wait 1;

    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
        return;

    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].vo = "ie_iln_raftersquick";
    var_0[0].vo_priority = 4;
    var_0[1] = spawnstruct();
    var_0[1].vo = "ie_iln_clear4";
    var_0[1].vo_priority = 4;
    thread maps\irons_estate_code::ally_vo_controller( var_0[0] );
    common_scripts\utility::flag_wait( "guesthouse_walkin_all_clear" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
        return;

    if ( !maps\irons_estate_code::check_player_in_stop_enemy_callout_vo_volume() )
        thread maps\irons_estate_code::ally_vo_controller( var_0[1] );
}

penthouse_objective()
{
    wait 2.0;
    objective_add( maps\_utility::obj( "penthouse" ), "current", &"IRONS_ESTATE_OBJ_PENTHOUSE" );
    var_0 = common_scripts\utility::getstruct( "overlook_obj", "targetname" );
    objective_position( maps\_utility::obj( "penthouse" ), var_0.origin );
    common_scripts\utility::flag_wait( "overlook_obj_trigger" );
    maps\_utility::autosave_stealth();
    var_1 = common_scripts\utility::getstruct( "penthouse_obj_org", "targetname" );
    objective_position( maps\_utility::obj( "penthouse" ), var_1.origin );
    common_scripts\utility::flag_wait( "penthouse_end_ready" );
    var_2 = common_scripts\utility::getstruct( "penthouse_balcony_obj", "targetname" );
    objective_position( maps\_utility::obj( "penthouse" ), var_2.origin );
    common_scripts\utility::flag_wait( "penthouse_end" );
    var_3 = common_scripts\utility::getstruct( "penthouse_balcony_interior_obj", "targetname" );
    objective_position( maps\_utility::obj( "penthouse" ), var_3.origin );
}

ilona_generic_update_vo()
{
    common_scripts\utility::flag_wait( "player_enters_front_yard_save_3" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "someone_became_alert" ) )
        return;

    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].vo = "ie_iln_sofarsogood";
    var_0[0].vo_priority = 4;
    maps\irons_estate_code::ally_vo_controller( var_0[0] );
    wait 1;
    maps\_utility::deletestruct_ref( var_0[0] );
}

tennis_court()
{
    level endon( "bedroom_end" );
    common_scripts\utility::flag_init( "tennis_court_clear" );
    common_scripts\utility::flag_wait( "tennis_court_activated" );
    level.tennis_court_trigger = getent( "tennis_court_trigger", "targetname" );
    level.tennis_court_trigger common_scripts\utility::trigger_off();
    soundscripts\_snd::snd_message( "aud_tennis_court_wakeup" );
    wait 0.5;
    level.tennis_court_origin = getent( "tennis_court_origin", "targetname" );
    thread maps\irons_estate_lighting::tennis_court_lights_intial();
    thread tennis_court_player_brackets();
    thread tennis_court_ball_launcher();
    thread maps\irons_estate_code::tennis_court_floor();
    common_scripts\_exploder::exploder( 747 );
    wait 2;
    thread tennis_court_nags();
    start_tennis_court_alert();
    common_scripts\utility::flag_wait( "player_entered_balcony_door" );
    maps\_utility::stop_exploder( 747 );
}

tennis_court_player_brackets()
{
    level endon( "bedroom_end" );
    var_0 = getent( "tennis_court_playing_area", "targetname" );
    var_1 = common_scripts\utility::getstruct( "tennis_court_floor_struct", "targetname" );

    for (;;)
    {
        var_0 waittill( "trigger" );
        var_2 = getaiarray( "axis" );
        var_2 = common_scripts\utility::array_add( var_2, level.player );
        var_3 = var_0 getistouchingentities( var_2 );

        if ( isdefined( var_3 ) && var_3.size > 0 )
        {
            foreach ( var_5 in var_3 )
            {
                if ( !isdefined( var_5.has_bracket ) )
                {
                    if ( var_5 == level.player )
                    {
                        var_5 thread tennis_court_player_brackets_internal( var_0, var_1, "ie_tennis_ring" );
                        continue;
                    }

                    if ( isdefined( var_5.classname ) && ( var_5.classname == "actor_enemy_atlas_bodyguard_smg" || var_5.classname == "actor_enemy_atlas_pmc_estate_smg" ) )
                        var_5 thread tennis_court_player_brackets_internal( var_0, var_1, "ie_tennis_ring_inv" );
                }
            }
        }

        waitframe();
    }
}

tennis_court_player_brackets_internal( var_0, var_1, var_2 )
{
    level endon( "player_entered_balcony_door" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = ( self.origin[0], self.origin[1], var_1.origin[2] + 0.1 );
    var_3.angles = var_3.angles + ( -90, 0, 0 );
    waitframe();
    playfxontag( level._effect[var_2], var_3, "tag_origin" );
    self.has_bracket = 1;

    while ( self istouching( var_0 ) && isalive( self ) )
    {
        var_3.angles = ( var_3.angles[0], self.angles[1], var_3.angles[2] );
        var_3.origin = ( self.origin[0], self.origin[1], var_1.origin[2] + 0.1 );
        waitframe();
    }

    stopfxontag( level._effect[var_2], var_3, "tag_origin" );
    var_3 delete();
    wait 1;
    self.has_bracket = undefined;
}

tennis_court_ball_launcher()
{
    var_0 = getent( "tennis_ball_launcher", "targetname" );
    var_1 = getent( "tennis_ball_launcher_clip", "targetname" );
    var_2 = getentarray( "tennis_ball", "targetname" );
    var_3 = getent( "tennis_ball_launcher_anim_origin", "targetname" );
    var_4 = var_0 gettagorigin( "tag_origin" );
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_4;
    var_0 linkto( var_5, "tag_origin" );
    var_1 linkto( var_5, "tag_origin" );

    foreach ( var_7 in var_2 )
        var_7 linkto( var_5, "tag_origin" );

    var_3 linkto( var_5, "tag_origin" );
    var_9 = getent( "tennis_ball_launcher_anim_origin_temp", "targetname" );
    var_9 linkto( var_5, "tag_origin" );
    var_5 thread tennis_court_ball_launcher_logic( var_9 );
    common_scripts\utility::flag_wait( "bedroom_end" );
    var_0 delete();
    var_1 delete();

    foreach ( var_7 in var_2 )
        var_7 delete();

    var_3 delete();
    var_9 delete();
    var_5 delete();
}

tennis_court_ball_launcher_logic( var_0 )
{
    level endon( "bedroom_end" );
    var_1 = [];
    var_1[0] = "ie_cv_serving";
    level.audio_org = level.tennis_court_origin common_scripts\utility::spawn_tag_origin();

    for (;;)
    {
        waitframe();
        common_scripts\utility::flag_clear( "tennis_court_activated" );
        var_2 = 0;
        wait 0.5;
        play_tennis_court_vo( "ie_cv_starting" );
        wait 1.5;
        play_tennis_court_vo( "ie_cv_lovelove" );

        for (;;)
        {
            if ( common_scripts\utility::flag( "player_playing_tennis" ) )
            {
                var_3 = vectortoangles( level.player.origin - self.origin );
                var_4 = var_3[1];
                var_5 = var_4 - self.angles[1];

                if ( var_5 > 0 )
                    var_5 = var_5 - 180;
                else
                    var_5 = var_5 + 180;
            }
            else
            {
                var_5 = 180 - self.angles[1];

                if ( var_5 > 0 )
                    var_5 = var_5 - 180;
                else
                    var_5 = var_5 + 180;

                var_5 = var_5 + randomintrange( -10, 10 );
            }

            self rotateyaw( var_5, 0.3, 0, 0 );
            wait 0.3;
            play_tennis_court_vo( "ie_cv_serving" );
            var_6 = spawn( "script_model", var_0.origin );
            var_6 setmodel( "base_tennis_ball_01" );
            var_7 = anglestoforward( var_0.angles );
            var_6 physicslaunchclient( var_6.origin, var_7 * 850 );
            soundscripts\_snd_playsound::snd_play_at( "irons_tennis_ball_launch", ( -2664, -4892, 444 ) );
            var_6 thread tennis_court_ball_cleanup();
            wait 2;
            var_2++;

            if ( var_2 == 1 )
            {
                play_tennis_court_vo( "ie_cv_15" );
                play_tennis_court_vo( "ie_cv_love" );
            }

            if ( var_2 == 2 )
            {
                play_tennis_court_vo( "ie_cv_30" );
                play_tennis_court_vo( "ie_cv_love" );
            }

            if ( var_2 == 3 )
            {
                play_tennis_court_vo( "ie_cv_40" );
                play_tennis_court_vo( "ie_cv_love" );
            }

            if ( var_2 == 4 )
            {
                level.audio_org playsound( "ie_cv_pausing" );
                break;
            }

            waitframe();
        }

        thread maps\irons_estate_lighting::tennis_court_lights_dimmed();
        thread enemies_in_tennis_court();
        common_scripts\utility::flag_wait( "tennis_court_clear" );
        wait 8;
        level.tennis_court_trigger common_scripts\utility::trigger_on();
        common_scripts\utility::flag_wait( "tennis_court_activated" );
        level.tennis_court_trigger common_scripts\utility::trigger_off();
        thread maps\irons_estate_lighting::tennis_court_lights_on();
    }
}

play_tennis_court_vo( var_0 )
{
    level.tennis_court_computer_talking = 1;
    level.audio_org playsound( var_0, "sounddone" );
    level.audio_org tennis_court_computer_line_done();
    level.tennis_court_computer_talking = undefined;
}

touchtest()
{
    self endon( "tennis_ball_delete" );
    var_0 = common_scripts\utility::getstruct( "tennis_court_floor_struct", "targetname" );
    var_1 = getent( "tennis_court_floor_volume", "targetname" );

    for (;;)
    {
        if ( self istouching( var_1 ) )
        {
            if ( !isdefined( self.ball_touching_ground ) )
            {
                self.ball_touching_ground = 1;
                iprintlnbold( "Yes" );
            }
        }
        else if ( isdefined( self.ball_touching_ground ) )
        {
            self.ball_touching_ground = undefined;
            iprintlnbold( "No" );
        }

        waitframe();
    }
}

tennis_court_ball_cleanup()
{
    common_scripts\utility::flag_wait_either( "tennis_court_activated", "bedroom_end" );

    if ( isdefined( self ) )
    {
        self notify( "tennis_ball_delete" );
        self delete();
    }
}

tennis_court_computer_line_done()
{
    self waittill( "sounddone" );
    return;
}

tennis_court_nags()
{
    common_scripts\utility::flag_wait( "tennis_court_clear" );
    level endon( "_stealth_spotted" );
    level endon( "bedroom_end" );
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].vo = "ie_iln_quitplaying";
    var_0[0].vo_priority = 4;
    var_0[1] = spawnstruct();
    var_0[1].vo = "ie_iln_serious";
    var_0[1].vo_priority = 4;
    common_scripts\utility::flag_wait( "tennis_court_activated" );
    wait 2;
    var_1 = getent( "player_touching_tennis_court_floor_volume", "targetname" );

    if ( level.player istouching( var_1 ) )
        thread maps\irons_estate_code::ally_vo_controller( var_0[0] );

    common_scripts\utility::flag_wait( "tennis_court_activated" );
    wait 2;

    if ( level.player istouching( var_1 ) )
        thread maps\irons_estate_code::ally_vo_controller( var_0[1] );
}

start_tennis_court_alert( var_0 )
{
    if ( !common_scripts\utility::flag( "_stealth_spotted" ) )
    {
        level.play_ally_warning_vo = undefined;
        level.play_ally_callout_vo = undefined;
        level.ally_vo_org stopsounds();
        wait 0.05;
        maps\_utility::smart_radio_dialogue( "ie_iln_tangoscoming" );
        level.play_ally_warning_vo = 1;
        level.play_ally_callout_vo = 1;
        wait 0.25;
        var_1 = getaiarray( "axis" );
        var_2 = common_scripts\utility::get_array_of_closest( level.tennis_court_origin.origin, var_1, undefined, undefined, 1024, undefined );

        if ( isdefined( var_2 ) )
        {
            foreach ( var_4 in var_2 )
            {
                wait 0.5;

                if ( !isdefined( level.tennis_court_alert_vo ) )
                {
                    level.tennis_court_alert_vo = 1;
                    var_4.animname = "generic";
                    var_4 maps\_utility::smart_dialogue( "ie_as1_whatsthat5" );
                }

                if ( !common_scripts\utility::flag( "_stealth_spotted" ) && isalive( var_4 ) && isdefined( var_4._stealth ) )
                {
                    var_4 notify( "reaction_generic", level.tennis_court_origin.origin );
                    var_5 = maps\_stealth_shared_utilities::group_get_ai_in_group( var_4.script_stealthgroup );

                    if ( isdefined( var_5 ) )
                    {
                        foreach ( var_8, var_7 in var_5 )
                        {
                            if ( var_7 == self )
                                continue;

                            if ( isdefined( var_7.enemy ) || isdefined( var_7.favoriteenemy ) )
                                continue;

                            var_7 thread maps\irons_estate_code::notify_delay_param( "reaction_generic", randomfloatrange( 0.1, 0.5 ), level.tennis_court_origin.origin );
                        }

                        break;
                    }
                }
            }
        }
    }
}

enemies_in_tennis_court()
{
    var_0 = getent( "player_touching_tennis_court_floor_volume", "targetname" );

    for (;;)
    {
        var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

        if ( var_1.size == 0 )
            break;

        wait 0.5;
    }

    common_scripts\utility::flag_set( "tennis_court_clear" );
}

ie_west_enemies()
{
    if ( level.start_point_scripted == "hack_security" )
    {
        if ( common_scripts\utility::flag( "security_center_guard_right" ) )
        {
            maps\_utility::array_spawn_function_targetname( "security_center_guard_right_spawner", maps\irons_estate_infil::security_center_guard_spawner_setup );
            var_0 = maps\_utility::array_spawn_targetname( "security_center_guard_right_spawner", 1 );
        }

        if ( common_scripts\utility::flag( "security_center_guard_left" ) )
        {
            maps\_utility::array_spawn_function_targetname( "security_center_guard_left_spawner", maps\irons_estate_infil::security_center_guard_spawner_setup );
            var_1 = maps\_utility::array_spawn_targetname( "security_center_guard_left_spawner", 1 );
        }
    }

    maps\_utility::array_spawn_function_targetname( "ie_west_spawner", ::ie_west_spawner_setup );
    var_2 = maps\_utility::array_spawn_targetname( "ie_west_spawner", 1 );
    thread ie_west_drones();
    thread maps\irons_estate_car_alarm::car_alarm_main( "ie_west_driveway_car", "player_entered_balcony_door" );

    if ( level.start_point_scripted == "hack_security" )
    {
        common_scripts\utility::flag_wait( "spawn_garage_civilians" );
        wait 1;
    }

    maps\_utility::array_spawn_function_targetname( "ie_west_spawner_2", ::ie_west_spawner_setup );
    var_3 = maps\_utility::array_spawn_targetname( "ie_west_spawner_2", 1 );
}

alcove_clips()
{
    level endon( "player_entered_balcony_door" );
    common_scripts\utility::flag_wait( "start_car_lift_scene" );

    if ( !common_scripts\utility::flag( "_stealth_spotted" ) )
        common_scripts\utility::flag_wait( "_stealth_spotted" );

    var_0 = getent( "garage_alcove_clip", "targetname" );
    var_0 notsolid();
}

garage_balcony_enemy()
{
    level endon( "player_entered_balcony_door" );
    common_scripts\utility::flag_wait_either( "spawn_garage_balcony_spawner", "do_not_spawn_garage_balcony_spawner" );

    if ( common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "do_not_spawn_garage_balcony_spawner" ) )
        return;

    maps\_utility::array_spawn_function_targetname( "ie_west_garage_balcony_spawner", ::garage_balcony_spawner_setup );
    var_0 = maps\_utility::array_spawn_targetname( "ie_west_garage_balcony_spawner", 1 );
    thread garage_balcony_door();
    thread garage_balcony_vo();
}

garage_balcony_spawner_setup()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "player_entered_balcony_door" );
    self delete();
}

garage_balcony_door()
{
    var_0 = getent( "garage_balcony_door", "targetname" );
    var_1 = getent( "garage_balcony_door_clip", "targetname" );
    var_1 linkto( var_0, "door_single_01_lod0" );
    var_0 rotateyaw( 90, 1 );
    var_2 = getent( "garage_balcony_door_light", "targetname" );
    var_2 setlightintensity( 15000 );
    var_1 connectpaths();
    common_scripts\utility::flag_wait_or_timeout( "garage_balcony_door_close", 5 );
    var_0 rotateyaw( -90, 1 );
    var_1 disconnectpaths();
    wait 1;
    var_2 setlightintensity( 1 );
}

garage_balcony_vo()
{
    wait 1;
    maps\_utility::smart_radio_dialogue( "ie_iln_hide2" );
}

ie_west_drones()
{
    var_0 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive( "ie_west_drones" );
    common_scripts\utility::flag_wait( "player_entered_balcony_door" );
    common_scripts\utility::array_thread( var_0, ::frontyard_drone_cleanup );
}

frontyard_drone_cleanup()
{
    self endon( "death" );
    var_0 = 0;

    while ( !var_0 )
    {
        if ( !maps\_utility::within_fov_2d( level.player.origin, level.player.angles, self.origin, cos( 45 ) ) )
        {
            var_0 = 1;
            continue;
        }

        wait 0.1;
    }

    self delete();
}

ie_west_spawner_setup()
{
    self endon( "death" );
    maps\_utility::walkdist_zero();
    common_scripts\utility::flag_wait( "player_entered_balcony_door" );
    self delete();
}

guesthouse_enemies()
{
    maps\_utility::array_spawn_function_targetname( "guesthouse_spawner", ::guesthouse_spawner_setup );
    var_0 = maps\_utility::array_spawn_targetname( "guesthouse_spawner", 1 );
    level endon( "player_enters_front_yard_save_4" );
    common_scripts\utility::flag_wait( "spawn_civilian_guesthouse_smoking" );
    maps\_utility::array_spawn_function_targetname( "guesthouse_balcony_walkout_spawner", ::guesthouse_spawner_setup );
    var_1 = maps\_utility::array_spawn_targetname( "guesthouse_balcony_walkout_spawner", 1 );
}

guesthouse_spawner_setup()
{
    self endon( "death" );
    maps\_utility::walkdist_zero();
    common_scripts\utility::flag_wait( "player_entered_balcony_door" );
    self delete();
}
