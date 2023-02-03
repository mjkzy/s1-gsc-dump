// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    launch_threads();
    launch_loops();
    create_level_envelop_arrays();
    precache_presets();
    register_snd_messages();
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundsettimescalefactor( "unoccluded", 0.5 );
    soundsettimescalefactor( "scripted2", 0 );
    soundsettimescalefactor( "tactical_special", 0 );
    soundsettimescalefactor( "weapons", 0 );
}

init_snd_flags()
{
    common_scripts\utility::flag_init( "razor_crate_stops" );
}

init_globals()
{
    level.aud = spawnstruct();
    level.aud.panned_quad_1_front = spawn( "script_origin", ( 3647, -32105, 2851 ) );
    level.aud.panned_quad_2_front = spawn( "script_origin", ( 3647, -32105, 2851 ) );
    level.aud.panned_quad_3_front = spawn( "script_origin", ( 3647, -32105, 2851 ) );
    level.aud.panned_quad_1_rear = spawn( "script_origin", ( 3056, 33241, 3808 ) );
    level.aud.panned_quad_2_rear = spawn( "script_origin", ( 3056, 33241, 3808 ) );
    level.aud.panned_quad_3_rear = spawn( "script_origin", ( 3056, 33241, 3808 ) );
    level.aud.player_jetpack = spawn( "script_origin", level.player.origin );
    level.aud.gloveon = 0;
    level.aud.firstdroppod = 1;
    level.aud.crvplrhitground = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread setup_skyjack_anims();
    thread setup_skyjack_mag_glove_anims();
    thread setup_crash_site_intro_anims();
    thread setup_cave_entry_loading_razorback();
    thread setup_crevasse_fall_and_recover();
    thread setup_goliath_bridge_anims();
    thread setup_narrow_cave_anims();
    thread setup_lake_anims();
    thread setup_exfil_anims();
    thread soundscripts\_audio_mix_manager::mm_add_submix( "master_mix" );
}

launch_loops()
{
    common_scripts\utility::loop_fx_sound( "amb_wind_light_gus_space", ( 3003, 8147, 1201 ) );
    thread common_scripts\utility::loop_fx_sound_interval( "emt_wind_ext_gust", ( 330, -5093, -845 ), undefined, undefined, 7, 13 );
    common_scripts\utility::loop_fx_sound( "waterfall_med_01", ( 1177, 5342, 448 ) );
    common_scripts\utility::loop_fx_sound( "waterfall_near_01", ( 1167, 5344, 309 ) );
    common_scripts\utility::loop_fx_sound( "waterfall_splat_01", ( 1169, 5356, 237 ) );
    common_scripts\utility::loop_fx_sound( "waterfall_splat_01", ( 1417, 6000, 255 ) );
    common_scripts\utility::loop_fx_sound( "fire_airplane_01_loop", ( 2878, 7363, 2977 ) );
    common_scripts\utility::loop_fx_sound( "fire_airplane_02_loop", ( 2920, 7244, 2768 ) );
    common_scripts\utility::loop_fx_sound( "crash_gol_bridge_water_left", ( 1428, 3671, 346 ), undefined, "waterfall_end" );
    common_scripts\utility::loop_fx_sound( "crash_gol_bridge_water_right", ( 936, 3569, 346 ), undefined, "waterfall_end" );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_02", ( 1120, 2847, -862 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 1120, 2847, -862 ) );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_02", ( 999, 2750, -865 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 999, 2750, -865 ) );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_02", ( 920, 2661, -870 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 920, 2661, -870 ) );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_01", ( 854, 2533, -875 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 854, 2533, -875 ) );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_01", ( 835, 2377, -879 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 835, 2377, -879 ) );
    common_scripts\utility::loop_fx_sound( "emt_water_drips_01", ( 841, 2233, -872 ) );
    common_scripts\utility::loop_fx_sound( "cave_water_trickle_dist", ( 841, 2233, -872 ) );
    common_scripts\utility::loop_fx_sound( "fire_airplane_01_loop", ( 347, -10489, -1471 ) );
    common_scripts\utility::loop_fx_sound( "fire_airplane_02_loop", ( 634, -10587, -1381 ) );
    common_scripts\utility::loop_fx_sound( "amb_wind_light_gus_space_2", ( 2485, -1349, -844 ) );
    common_scripts\utility::loop_fx_sound( "overlook_waterfall_water", ( 3027, -2139, -822 ) );
    common_scripts\utility::loop_fx_sound( "light_water_flow", ( 2199, -2292, -919 ) );
    common_scripts\utility::loop_fx_sound( "light_water_flow", ( 399, -8277, -1181 ) );
    common_scripts\utility::loop_fx_sound( "lake_waterfall", ( 399, -8340, -1354 ) );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

precache_presets()
{

}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_crash_site", ::start_crash_site );
    soundscripts\_snd::snd_register_message( "start_cave_entry", ::start_cave_entry );
    soundscripts\_snd::snd_register_message( "start_cave_hallway", ::start_cave_hallway );
    soundscripts\_snd::snd_register_message( "start_big_cave", ::start_big_cave );
    soundscripts\_snd::snd_register_message( "start_narrow_cave", ::start_narrow_cave );
    soundscripts\_snd::snd_register_message( "start_combat_cave", ::start_combat_cave );
    soundscripts\_snd::snd_register_message( "start_ice_bridge", ::start_ice_bridge );
    soundscripts\_snd::snd_register_message( "start_overlook", ::start_overlook );
    soundscripts\_snd::snd_register_message( "start_lake", ::start_lake );
    soundscripts\_snd::snd_register_message( "start_lake_cinema", ::start_lake_cinema );
    soundscripts\_snd::snd_register_message( "start_vtol_takedown", ::start_vtol_takedown );
    soundscripts\_snd::snd_register_message( "start_avalanche", ::start_avalanche );
    soundscripts\_snd::snd_register_message( "intro_skyjack_black", ::intro_skyjack_black );
    soundscripts\_snd::snd_register_message( "intro_skyjack_fade_in", ::intro_skyjack_fade_in );
    soundscripts\_snd::snd_register_message( "skyjack_gloveon", ::skyjack_gloveon );
    soundscripts\_snd::snd_register_message( "skyjack_gloveoff", ::skyjack_gloveoff );
    soundscripts\_snd::snd_register_message( "ambush_events", ::ambush_events );
    soundscripts\_snd::snd_register_message( "drop_pod", ::drop_pod );
    soundscripts\_snd::snd_register_message( "razorback_explosion", ::razorback_explosion );
    soundscripts\_snd::snd_register_message( "background_explosion", ::background_explosion );
    soundscripts\_snd::snd_register_message( "playspace_explosion", ::playspace_explosion );
    soundscripts\_snd::snd_register_message( "warbird_crash_site", ::warbird_crash_site );
    soundscripts\_snd::snd_register_message( "mech_fire_missile_first", ::mech_fire_missile_first );
    soundscripts\_snd::snd_register_message( "mech_fire_missile", ::mech_fire_missile );
    soundscripts\_snd::snd_register_message( "cave_entry", ::cave_entry );
    soundscripts\_snd::snd_register_message( "cave_entry_tank_missile", ::cave_entry_tank_missile );
    soundscripts\_snd::snd_register_message( "ilana_break_wall", ::ilana_break_wall );
    soundscripts\_snd::snd_register_message( "cormack_flare", ::cormack_flare );
    soundscripts\_snd::snd_register_message( "seo_zipline_harpoon_fire", ::seo_zipline_harpoon_fire );
    soundscripts\_snd::snd_register_message( "seo_zipline_harpoon_impact", ::seo_zipline_harpoon_impact );
    soundscripts\_snd::snd_register_message( "seo_zipline_rappel_begin", ::seo_zipline_rappel_begin );
    soundscripts\_snd::snd_register_message( "seo_zipline_rappel_land", ::seo_zipline_rappel_land );
    soundscripts\_snd::snd_register_message( "seo_zipline_retract_rope", ::seo_zipline_retract_rope );
    soundscripts\_snd::snd_register_message( "drop_pod_screen_shake", ::drop_pod_screen_shake );
    soundscripts\_snd::snd_register_message( "drop_pod_screen_shake_large", ::drop_pod_screen_shake_large );
    soundscripts\_snd::snd_register_message( "turkey_shoot", ::turkey_shoot );
    soundscripts\_snd::snd_register_message( "cave_npc_boost_assist", ::cave_npc_boost_assist );
    soundscripts\_snd::snd_register_message( "cave_npc_boost_assist_land", ::cave_npc_boost_assist_land );
    soundscripts\_snd::snd_register_message( "player_knockdown", ::player_knockdown );
    soundscripts\_snd::snd_register_message( "goliath_land", ::goliath_land );
    soundscripts\_snd::snd_register_message( "stalactite_fall", ::stalactite_fall );
    soundscripts\_snd::snd_register_message( "cave_in", ::cave_in );
    soundscripts\_snd::snd_register_message( "start_water_breach", ::start_water_breach );
    soundscripts\_snd::snd_register_message( "end_water_breach", ::end_water_breach );
    soundscripts\_snd::snd_register_message( "wind_warning", ::wind_warning );
    soundscripts\_snd::snd_register_message( "wind_gust", ::wind_gust );
    soundscripts\_snd::snd_register_message( "overlook_land", ::overlook_land );
    soundscripts\_snd::snd_register_message( "overlook_fall", ::overlook_fall );
    soundscripts\_snd::snd_register_message( "overlook_recover", ::overlook_recover );
    soundscripts\_snd::snd_register_message( "enter_lake_cave", ::enter_lake_cave );
    soundscripts\_snd::snd_register_message( "lake_events", ::lake_events );
    soundscripts\_snd::snd_register_message( "missile_fire", ::missile_fire );
    soundscripts\_snd::snd_register_message( "lake_warbird_approaches", ::lake_warbird_approaches );
    soundscripts\_snd::snd_register_message( "lake_fall_in", ::lake_fall_in );
    soundscripts\_snd::snd_register_message( "lake_exit", ::lake_exit );
    soundscripts\_snd::snd_register_message( "pickup_stinger", ::pickup_stinger );
    soundscripts\_snd::snd_register_message( "vtol_flyin", ::vtol_flyin );
    soundscripts\_snd::snd_register_message( "cormack_missile", ::cormack_missile );
    soundscripts\_snd::snd_register_message( "recover_cargo", ::recover_cargo );
    soundscripts\_snd::snd_register_message( "exfil_fail", ::exfil_fail );
    soundscripts\_snd::snd_register_message( "railgun_charge", ::railgun_charge );
    soundscripts\_snd::snd_register_message( "railgun_ready", ::railgun_ready );
}

zone_handler( var_0, var_1 )
{
    var_2 = "";
    var_3 = "";

    if ( getsubstr( var_0, 0, 6 ) == "enter_" )
        var_2 = var_1;
    else if ( getsubstr( var_0, 0, 5 ) == "exit_" )
        var_3 = var_1;

    switch ( var_0 )
    {
        case "enter_crash_int_cave":
            if ( var_2 == "crash_int_cave" )
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
            else if ( var_2 == "crash_ext_crash_site" )
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );

            break;
        case "exit_crash_int_cave":
            if ( var_3 == "crash_int_cave" )
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
            else if ( var_3 == "crash_ext_crash_site" )
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_stop_sound();

            break;
        case "enter_crash_int_cave_narrow":
            if ( var_2 == "crash_int_cave_post_goliath" )
            {
                level.aud.panned_quad_3_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_narrow" );
                level.aud.panned_quad_3_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_narrow_sur" );
            }
            else if ( var_2 == "crash_int_cave_narrow" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath" );
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath_sur" );
            }

            break;
        case "exit_crash_int_cave_narrow":
            if ( var_3 == "crash_int_cave_post_goliath" )
            {
                level.aud.panned_quad_3_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_3_rear soundscripts\_snd_playsound::snd_stop_sound();
            }
            else if ( var_3 == "crash_int_cave_narrow" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
            }

            break;
        case "enter_crash_ext_postcave":
            if ( var_2 == "crash_ext_postcave" )
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
            else if ( var_2 == "crash_int_cave_large" )
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );

            break;
        case "exit_crash_ext_postcave":
            if ( var_3 == "crash_ext_postcave" )
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_stop_sound();
            else if ( var_3 == "crash_int_cave_large" )
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();

            break;
        case "enter_crash_ext_preoverlook":
            if ( var_2 == "crash_ext_preoverlook" )
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
            else if ( var_2 == "crash_ext_postcave" )
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );

            break;
        case "exit_crash_ext_preoverlook":
            if ( var_3 == "crash_ext_preoverlook" )
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_stop_sound();
            else if ( var_3 == "crash_ext_postcave" )
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();

            break;
        case "enter_crash_ext_overlook":
            if ( var_2 == "crash_ext_overlook" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
            }
            else if ( var_2 == "crash_ext_preoverlook" )
            {
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_overlook_wind" );
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_overlook_wind_sur" );
            }

            break;
        case "exit_crash_ext_overlook":
            if ( var_3 == "crash_ext_overlook" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
            }
            else if ( var_3 == "crash_ext_preoverlook" )
            {
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_stop_sound();
            }

            break;
        case "enter_crash_ext_postoverlook":
            if ( var_2 == "crash_ext_postoverlook" )
            {
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_overlook_wind" );
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_overlook_wind_sur" );
            }
            else if ( var_2 == "crash_ext_overlook" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
            }

            break;
        case "exit_crash_ext_postoverlook":
            if ( var_3 == "crash_ext_postoverlook" )
            {
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_stop_sound();
            }
            else if ( var_3 == "crash_ext_overlook" )
            {
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
                level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
            }

            break;
        case "enter_crash_int_endcave":
            if ( var_2 == "crash_int_endcave" )
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
            else if ( var_2 == "crash_ext_precave" )
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );

            break;
        case "exit_crash_int_endcave":
            if ( var_3 == "crash_int_endcave" )
                level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_stop_sound();
            else if ( var_3 == "crash_ext_precave" )
                level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();

            break;
    }
}

music_handler( var_0, var_1 )
{
    level notify( "exit_music_thread" );
    level endon( "exit_music_thread" );

    switch ( var_0 )
    {
        case "crash_ambush_intro":
            soundscripts\_audio_music::mus_play( "mus_crash_ambush_intro", 4, 0 );
            soundscripts\_audio::aud_set_music_submix( 0.55 );
            break;
        case "crash_ambush_combat":
            soundscripts\_audio_music::mus_play( "mus_crash_intro_combat", 0, 0.2 );
            soundscripts\_audio::aud_set_music_submix( 1 );
            break;
        case "crash_pre_cave_combat_end":
            soundscripts\_audio_music::mus_stop( 0.2 );
            break;
        case "crash_ambush_combat_end":
            soundscripts\_audio_music::mus_play( "mus_crash_intro_combat_outro", 0.5, 1 );
            soundscripts\_audio::aud_set_music_submix( 1 );
            break;
        case "crash_cave_stealth":
            wait 5;
            soundscripts\_audio_music::mus_play( "mus_crash_cave_reveal" );
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            wait 15;
            soundscripts\_audio_music::mus_stop( 6 );
            break;
        case "crash_cave_combat":
            soundscripts\_audio_music::mus_play( "mus_crash_cave_combat", 0.5, 1 );
            soundscripts\_audio::aud_set_music_submix( 0.5 );
            maps\_utility::trigger_wait_targetname( "TRIG_caves_goliath" );
            soundscripts\_audio_music::mus_stop( 1 );
            break;
        case "narrow_cave":
            wait 3.5;
            soundscripts\_audio::aud_set_music_submix( 0.3 );
            break;
        case "crevasse_combat":
            soundscripts\_audio_music::mus_play( "mus_crash_cave_combat" );
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            level waittill( "combat_cave_exit" );
            soundscripts\_audio_music::mus_stop( 3 );
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            break;
        case "lake_combat":
            wait 2;
            soundscripts\_audio::aud_set_music_submix( 1 );
            soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_3" );
            soundscripts\_audio_music::mus_play( "mus_crash_sniper_combat" );
            level endon( "lake_player_fall_in" );
            wait 49.39;
            soundscripts\_audio_music::mus_play( "mus_crash_sniper_combat_lp", 0, 0.1 );
            break;
        case "double_agent":
            wait 14;
            soundscripts\_audio::aud_set_music_submix( 1 );
            soundscripts\_audio_music::mus_play( "mus_crash_double_agent" );
            break;
        case "end_sequence":
            soundscripts\_audio::aud_set_music_submix( 1 );
            soundscripts\_audio_music::mus_play( "mus_crash_warbird_race_p1", 0, 0.6 );
            common_scripts\utility::flag_wait( "cargo_trigger" );
            wait 0.25;
            soundscripts\_audio_music::mus_play( "mus_crash_warbird_jump", 0.5, 0.1 );
            common_scripts\utility::flag_wait( "player_exfil_success" );
            wait 1.25;
            soundscripts\_audio_music::mus_play( "mus_crash_exfil" );
            break;
        case "exfil_escape":
            soundscripts\_audio_music::mus_play( "mus_crash_avalanche_escape" );
            soundscripts\_audio::aud_set_music_submix( 0.35 );
            common_scripts\utility::flag_wait( "player_getting_in_end_chopper" );
            soundscripts\_audio_music::mus_stop( 15 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

start_crash_site()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_skyjack", 0.5 );
}

start_cave_entry()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_crash_site2", 0.5 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
    soundscripts\_snd::snd_music_message( "crash_ambush_combat" );
}

start_cave_hallway()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave", 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
    soundscripts\_snd_playsound::snd_play_2d( "cave_stress" );
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "crash_crev_foley_cormack", 0.1 );
    level.ilana soundscripts\_snd_playsound::snd_play_delayed_linked( "crash_crev_foley_ilona", 0.1 );
    wait 3.5;
    soundscripts\_snd::snd_music_message( "crash_cave_stealth" );
}

start_big_cave()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave_tunnel", 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
}

start_ice_bridge()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave_medium", 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
}

start_narrow_cave()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave_post_goliath", 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath_sur" );
    level notify( "waterfall_end" );
}

start_combat_cave()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave_combat", 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
}

start_overlook()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_preoverlook", 0.5 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
}

start_lake()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_preoverlook", 0.5 );
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_mix_manager::mm_add_submix( "crash_postoverlook_start" );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_postoverlook_start" );
}

start_lake_cinema()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_endcave", 0.5 );
}

start_vtol_takedown()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_end", 0.5 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
}

start_avalanche()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_overlook", 0.5 );
}

setup_skyjack_anims()
{
    maps\_anim::addnotetrack_customfunction( "rig", "player_magon", ::skyjack_gloveon, "skyjack_wingland_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "land_on_wing", ::player_land_on_wing, "skyjack_wingland_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "start", ::skyjack_player_set_charge, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "charge_planted", ::skyjack_player_charge_planted, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "right_hand_on_charge", ::skyjack_player_hand_on_charge, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "open_charge", ::skyjack_player_open_charge, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "activate_charge", ::skyjack_player_activate_charge, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "use_wrist_computer", ::skyjack_player_wrist, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "impact_plane", ::skyjack_player_impact_plane, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "aud_plane_expl_gloves", ::plane_expl_gloves, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "push_off_plane", ::skyjack_player_push_off_plane, "skyjack_explosion_player" );
    maps\_anim::addnotetrack_customfunction( "cormack", "jets_on", ::skyjack_cormack_jetpack_on, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "jetpack_boost", ::skyjack_cormack_jetpack_boost, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "jets_off", ::skyjack_cormack_jetpack_off, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "lands_on_plane", ::skyjack_cormack_land_on_plane, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "mag_hand_left", ::skyjack_cormack_mag_hand_left, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "mag_hand_right", ::skyjack_cormack_mag_hand_right, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "left_knee", ::skyjack_cormack_left_knee, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "right_knee", ::skyjack_cormack_right_knee, "skyjack_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "push_off_plane_1", ::skyjack_cormack_push_off_plane, "skyjack_explosion_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "jets_on", ::skyjack_cormack_jetpack_on, "skyjack_explosion_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "impact_plane", ::skyjack_cormack_impact_plane, "skyjack_explosion_cormack" );
    maps\_anim::addnotetrack_customfunction( "cargo_plane", "activate", ::skyjack_plane_cut, "skyjack_explosion_plane" );
    maps\_anim::addnotetrack_customfunction( "cargo_plane", "begin_explosion", ::skyjack_plane_explosion, "skyjack_explosion_plane" );
    maps\_anim::addnotetrack_customfunction( "explosive", "legs_unfold", ::skyjack_charge_legs, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "explosive", "impact", ::skyjack_charge_impact, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "explosive", "charge_opens", ::skyjack_charge_opens, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "explosive", "laser_guide", ::skyjack_charge_laser_guide, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "explosive", "laser_turn", ::skyjack_charge_laser_turn, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "explosive", "activate", ::skyjack_charge_activate, "skyjack_setcharge_explosive" );
    maps\_anim::addnotetrack_customfunction( "drone_pod", "jets_on", ::skyjack_drone_jets_on, "skyjack_intro_drone" );
    maps\_anim::addnotetrack_customfunction( "drone_pod", "jets_off", ::skyjack_drone_jets_off, "skyjack_intro_drone" );
    maps\_anim::addnotetrack_customfunction( "drone_pod", "jets_on", ::skyjack_drone_jets_on, "skyjack_explosion_drone" );
    maps\_anim::addnotetrack_customfunction( "drone_pod", "deploy_chutes", ::skyjack_drone_chutes, "skyjack_explosion_drone" );
}

setup_skyjack_mag_glove_anims()
{
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_r", ::mag_windup_r, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_r", ::mag_windup_r, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_r", ::mag_windup_r, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_r", ::mag_windup_r, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_l", ::mag_windup_l, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "windup_r", ::mag_windup_r, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "hit", ::mag_hit, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "rest", ::mag_rest, "magnetic_l_2" );
}

setup_crash_site_intro_anims()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "jets_off", ::cs_intro_cormack_jetpack_off, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_land", ::cs_intro_cormack_land, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "remove_jetpack", ::cs_intro_cormack_remove_jetpack, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_open", ::generic_helmet_open, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_close", ::generic_helmet_close, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "ready_gun", ::cs_intro_cormack_ready_gun, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "ilana", "give_gun", ::cs_intro_ilona_hand_over_gun, "atlas_plane_crash" );
    maps\_anim::addnotetrack_customfunction( "rig", "bg_plane_breach", ::cs_intro_bg_plane_breach, "crash_atlas_plane_crash_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "remove_jetpack", ::cs_intro_player_remove_jetpack, "crash_atlas_plane_crash_player" );
    maps\_anim::addnotetrack_customfunction( "sent1", "boost_jump", ::cs_intro_plane_jumper_boost, "atlas_plane_crash_craig" );
    maps\_anim::addnotetrack_customfunction( "sent1", "land_on_plane", ::cs_intro_plane_jumper_land, "atlas_plane_crash_craig" );
    maps\_anim::addnotetrack_customfunction( "sent1", "land_on_snow", ::cs_intro_plane_jumper_drop_to_ground, "atlas_plane_crash_craig" );
    maps\_anim::addnotetrack_customfunction( "sent2", "boost_jump", ::cs_intro_plane_jumper_boost, "atlas_plane_crash_tony" );
    maps\_anim::addnotetrack_customfunction( "sent2", "land_on_plane", ::cs_intro_plane_jumper_land, "atlas_plane_crash_tony" );
    maps\_anim::addnotetrack_customfunction( "sent2", "land_on_snow", ::cs_intro_plane_jumper_drop_to_ground, "atlas_plane_crash_tony" );
}

setup_cave_entry_loading_razorback()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "touching_crate", ::razor_cormack_reaches_crate, "prebunker_intro_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "stowing_gun", ::razor_cormack_stowing_gun, "prebunker_end_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "lf_hand_on_crate", ::razor_cormack_hand_on_crate, "prebunker_end_cormack" );
    maps\_anim::addnotetrack_customfunction( "cormack", "ft_hand_on_crate", ::razor_cormack_hand_on_crate, "prebunker_end_cormack" );
    maps\_anim::addnotetrack_customfunction( "rig", "start", ::razor_player_hand_on_crate, "prebunker_end_player" );
    maps\_anim::addnotetrack_customfunction( "rig", "releasing_crate", ::razor_player_hand_off_crate, "prebunker_end_player" );
    maps\_anim::addnotetrack_customfunction( "razor_cargo", "crate_starts_moving", ::razor_crate_move, "prebunker_end_crate" );
    maps\_anim::addnotetrack_flag( "razor_cargo", "crate_stops_moving", "razor_crate_stops", "prebunker_end_crate" );
    maps\_anim::addnotetrack_customfunction( "razorback", "hatch_closing", ::razor_rb_hatch_close, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "lifting_off", ::razor_rb_lifting_off, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "missile_1_hit", ::razor_rb_missile_hit, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "missile_2_hit", ::razor_rb_missile_hit, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "missile_3_hit", ::razor_rb_missile_hit, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "missile_4_hit", ::razor_rb_missile_hit, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razorback", "missile_5_hit", ::razor_rb_missile_hit, "prebunker_end_razorback" );
    maps\_anim::addnotetrack_customfunction( "razor_missiles", "missile_1_launched", ::razor_rb_missile_launch, "prebunker_end_missiles" );
    maps\_anim::addnotetrack_customfunction( "razor_missiles", "missile_2_launched", ::razor_rb_missile_launch, "prebunker_end_missiles" );
    maps\_anim::addnotetrack_customfunction( "razor_missiles", "missile_3_launched", ::razor_rb_missile_launch, "prebunker_end_missiles" );
    maps\_anim::addnotetrack_customfunction( "razor_missiles", "missile_4_launched", ::razor_rb_missile_launch, "prebunker_end_missiles" );
    maps\_anim::addnotetrack_customfunction( "razor_missiles", "missile_5_launched", ::razor_rb_missile_launch, "prebunker_end_missiles" );
}

setup_crevasse_fall_and_recover()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "hands_on_wall_slide", ::crevasse_slide_hands, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "impact_wall", ::crevasse_impact_wall, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "end_slide", ::crevasse_slide_end, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "impact_ground", ::crevasse_impact_ground, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "getting_up", ::pro_cave_get_up, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "cormack", "pick_up_gun", ::pro_cave_pick_up_gun, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_open", ::generic_helmet_open, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "cormack", "help_ilona", ::pro_cave_help_ilona, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "cormack", "release_gun", ::pro_cave_stowing_gun, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "cormack", "grab_gun", ::pro_cave_grabbing_gun, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "ilana", "hands_on_wall_slide", ::crevasse_slide_hands, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "ilana", "impact_wall", ::crevasse_impact_wall, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "ilana", "end_slide", ::crevasse_slide_end, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "ilana", "impact_ground", ::crevasse_impact_ground, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "ilana", "rolling_over", ::pro_cave_roll_over, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "ilana", "helped_up", ::pro_cave_helped_up, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "ilana", "pick_up_gun", ::pro_cave_ilona_pick_up_gun, "head_down_tunnel" );
    maps\_anim::addnotetrack_customfunction( "rig", "fall_down", ::crevasse_player_fall_down, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "rig", "hands_on_wall_slide", ::crevasse_player_slide_hands, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "rig", "impact_wall", ::crevasse_player_impact_wall, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "rig", "end_slide", ::crevasse_player_slide_end, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "rig", "player_land", ::crevasse_player_impact_ground, "icecave_enter" );
    maps\_anim::addnotetrack_customfunction( "rig", "stand_up", ::crevasse_player_get_up, "icecave_enter" );
}

setup_goliath_bridge_anims()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "boost_begin", ::cormack_boost_jump, "cormack_bridge_smash" );
    maps\_anim::addnotetrack_customfunction( "cormack", "get_up", ::cormack_narrow_cave_start, "friendly_bridge_explode" );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_open", ::generic_helmet_open, "friendly_bridge_explode" );
    maps\_anim::addnotetrack_customfunction( "ilana", "get_up", ::ilana_narrow_cave_start, "friendly_bridge_explode" );
}

setup_narrow_cave_anims()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::cormack_narrow_cave_search, "narrowcave_search" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::cormack_narrowcave_search_enter, "narrowcave_search_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::cormack_narrowcave_search_exit, "narrowcave_search_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::cormack_narrowcave_search_traverse_sec1, "narrowcave_search_traverse_sec1" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::narrowcave_traverse_sec1, "narrowcave_traverse_sec1" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::narrowcave_sec1_traverse_sec2, "narrowcave_sec1_traverse_sec2" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::narrowcave_sec2_enter, "narrowcave_sec2_enter" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::narrowcave_sec2_exit, "narrowcave_sec2_exit" );
    maps\_anim::addnotetrack_customfunction( "cormack", "cormack_start", ::narrowcave_sec2_traverse_floodroom, "narrowcave_sec2_traverse_floodroom" );
    maps\_anim::addnotetrack_customfunction( "cormack", "helmet_close", ::generic_helmet_close, "narrowcave_floodroom_break_to_breach" );
    maps\_anim::addnotetrack_customfunction( "cormack", "turn_to_player", ::cormack_narrowcave_breach_turn, "narrowcave_water_breach" );
    maps\_anim::addnotetrack_customfunction( "cormack", "grab_ledge", ::cormack_narrowcave_breach_ledge, "narrowcave_water_breach" );
    maps\_anim::addnotetrack_customfunction( "cormack", "grab_axe", ::cormack_narrowcave_breach_grab_axe, "narrowcave_water_breach" );
    maps\_anim::addnotetrack_customfunction( "cormack", "surface", ::cormack_narrowcave_breach_surface, "narrowcave_water_breach" );
    maps\_anim::addnotetrack_customfunction( "ilana", "ilona_start", ::ilana_narrow_cave_search, "narrowcave_search" );
    maps\_anim::addnotetrack_customfunction( "breach_enemy_6", "axe_impact", ::enemy_narrowcave_breach_axe_hit, "water_breach_enemy" );
}

setup_lake_anims()
{
    maps\_anim::addnotetrack_customfunction( "gideon", "pistol_pickup", ::bad_guys_die, "gideon_scene" );
    maps\_anim::addnotetrack_customfunction( "cormack", "hand_on_ilana", ::cormack_hand_on_ilana, "gideon_scene" );
    maps\_anim::addnotetrack_customfunction( "ilana", "pick_up_gun", ::ilana_pick_up_gun, "gideon_scene" );
}

setup_exfil_anims()
{
    maps\_anim::addnotetrack_customfunction( "cormack", "attach_stinger_to_tag_inhand", ::cormack_pickup_stinger, "vtol_ambush_intro" );
    maps\_anim::addnotetrack_customfunction( "gideon", "boost_prep", ::gideon_exfil_boost, "vtol_sliding_off_cliff_gideon" );
    maps\_anim::addnotetrack_customfunction( "gideon", "section_1", ::gideon_exfil_foley1, "vtol_sliding_off_cliff_gideon" );
    maps\_anim::addnotetrack_customfunction( "gideon", "section_2", ::gideon_exfil_foley2, "vtol_sliding_off_cliff_gideon" );
    maps\_anim::addnotetrack_customfunction( "gideon", "section_3", ::gideon_exfil_foley3, "vtol_sliding_off_cliff_gideon" );
    maps\_anim::addnotetrack_customfunction( "gideon", "section_4", ::gideon_exfil_foley4, "vtol_sliding_off_cliff_gideon" );
    maps\_anim::addnotetrack_customfunction( "rig", "boost_jump_to_heli", ::boost_jump_to_heli, "avalanche_exit" );
    maps\_anim::addnotetrack_customfunction( "gideon", "start", ::gideon_jump_to_heli, "avalanche_exit" );
    maps\_anim::addnotetrack_customfunction( "rig", "grab_hand", ::grab_hand, "avalanche_exit" );
}

generic_helmet_open( var_0 )
{
    wait 0.05;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "helmet_open" );
}

generic_helmet_close( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "helmet_close" );
}

skyj_intro_black()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "skyj_intro_black_amb_lp", "aud_stop_intro_black_loop", 1, 1 );
}

skyj_part_1()
{
    level notify( "aud_stop_intro_black_loop" );
    soundscripts\_snd_playsound::snd_play_2d( "skyj_intro_amb" );
    soundscripts\_snd_playsound::snd_play_2d( "skyj_intro_breathing" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_act_mag", 10.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "hgw_crash_skyjack_intro", 10 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_intro_corm_accel", 14.3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_intro_plr_thrust_rear", 16 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_approach_jet", 21 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_plr_land_jet", 24.4 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_plr_land_jet_breathing", 25.3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_corm_land_jet", 27 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_lifter_land", 27 );
    wait 25;
    soundscripts\_snd_playsound::snd_play_loop_2d( "skyj_wing_amb_front_lp", "aud_stop_skyj_wing_amb", 1, 1 );
}

skyj_part_2()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_place_cutter", 1.4 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_cutter_rear_button", 3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_cutter_top_button", 4 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_cutter_go", 9 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_banking", 12 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_wing_metal_boom", 14 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_banking_foley", 14 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_cutter_finish", 17 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_wing_expl_lead_in", 17 );
}

skyj_part_3()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_jet_grab", 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_wing_expl", 2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_chutes_deploy", 2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_corm_liftoff", 10 );
}

skyj_part_4()
{
    level notify( "aud_stop_skyj_wing_amb" );
    soundscripts\_snd_playsound::snd_play_2d( "skyj_land_amb", "recently_loaded" );
    thread recently_loaded_listener( "crash_lighting_cinema_end" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_land_plr_thrust_rear", 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_plr_descent_breathing", 15, 0, "recently_loaded" );
    soundscripts\_snd_playsound::snd_play_delayed_at( "skyj_jet_impact", ( 2862, 6790, 3152 ), 33 );

    if ( level.nextgen )
    {
        soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_corm_land_ground", 41 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_plr_land_ground", 38.5 );
    }
}

intro_skyjack_black()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_skyjack_intro", 2 );
    thread skyj_intro_black();
    wait 16;
    wait 4.7;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_skyjack", 1 );
}

intro_skyjack_fade_in()
{
    thread skyj_part_1();
}

player_land_on_wing( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_skyjack_plane", 1 );
}

skyjack_gloveon( var_0 )
{
    if ( level.aud.gloveon == 0 )
    {
        level.aud.gloveon = 1;
        soundscripts\_snd_playsound::snd_play_2d( "skjk_gloves" );
    }
    else
    {

    }
}

skyjack_gloveoff( var_0 )
{
    if ( level.aud.gloveon == 1 )
        level.aud.gloveon = 0;
    else
    {

    }
}

mag_hit( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_hit_magnet" );
}

mag_rest( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_rest_magnet" );
}

mag_windup_l( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_lt" );
}

mag_windup_r( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_rt" );
}

skyjack_player_set_charge( var_0 )
{
    wait 1.5;
    thread skyj_part_2();
    soundscripts\_snd_playsound::snd_play_2d( "sky_cutter_legs" );
}

skyjack_player_charge_planted( var_0 )
{

}

skyjack_player_hand_on_charge( var_0 )
{

}

skyjack_player_open_charge( var_0 )
{
    wait 0.1;
}

skyjack_player_activate_charge( var_0 )
{
    wait 0.1;
}

skyjack_player_wrist( var_0 )
{
    wait 3.2;
    thread skyjack_expl_start();
    wait 13;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_skyjack", 3 );
}

skyjack_player_impact_plane( var_0 )
{
    thread skyj_part_3();
}

skyjack_expl_start()
{
    level notify( "wings_blown_off" );
    wait 5.75;
    wait 10;
    level notify( "plane_crashed" );
}

plane_expl_gloves( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "skjk_gloves" );
}

skyjack_player_push_off_plane( var_0 )
{
    thread skyj_part_4();
}

skyjack_cormack_jetpack_on( var_0 )
{

}

skyjack_cormack_jetpack_boost( var_0 )
{

}

skyjack_cormack_jetpack_off( var_0 )
{

}

skyjack_cormack_land_on_plane( var_0 )
{

}

skyjack_cormack_mag_hand_left( var_0 )
{

}

skyjack_cormack_mag_hand_right( var_0 )
{

}

skyjack_cormack_left_knee( var_0 )
{

}

skyjack_cormack_right_knee( var_0 )
{

}

skyjack_cormack_push_off_plane( var_0 )
{

}

skyjack_cormack_impact_plane( var_0 )
{

}

skyjack_plane_cut( var_0 )
{

}

skyjack_plane_explosion( var_0 )
{

}

skyjack_charge_legs( var_0 )
{

}

skyjack_charge_impact( var_0 )
{

}

skyjack_charge_opens( var_0 )
{

}

skyjack_charge_laser_guide( var_0 )
{

}

skyjack_charge_laser_turn( var_0 )
{

}

skyjack_charge_activate( var_0 )
{

}

skyjack_drone_jets_on( var_0 )
{

}

skyjack_drone_jets_off( var_0 )
{

}

skyjack_drone_chutes( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_01", 20.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_02", 21 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_03", 24 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_04", 34 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_05", 35 );
}

ambush_events()
{
    thread fade_in_crash_site();
    wait 8;
    wait 4.8;
    soundscripts\_snd_playsound::snd_play_2d( "player_jet_land" );
    level.aud.player_jetpack scalevolume( 0, 1 );
    thread soundscripts\_audio::aud_fade_loop_out_and_delete( level.aud.player_jetpack, 1 );
    common_scripts\utility::flag_wait( "go_drop_pods" );
    wait 2.5;
    soundscripts\_snd::snd_music_message( "crash_ambush_combat" );
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_crash_site2", 0.2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "global_volume_cut_2", 0.2 );
}

fade_in_crash_site()
{
    wait 8;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_crash_site", 4.0 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_sur" );
}

cs_intro_cormack_jetpack_off( var_0 )
{

}

cs_intro_cormack_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_ui_06", 2 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "skyj_plr_helm_open", 3.7 );
    wait 3.35;
    soundscripts\_audio_mix_manager::mm_clear_submix( "global_volume_cut", 0.15 );
}

cs_intro_cormack_remove_jetpack( var_0 )
{
    wait 1.8;
    soundscripts\_snd_playsound::snd_play_at( "cs_blow_hatch", ( 3002, 6799, 2878 ) );
}

cs_intro_cormack_ready_gun( var_0 )
{

}

cs_intro_ilona_hand_over_gun( var_0 )
{
    wait 0.2;
    soundscripts\_snd_playsound::snd_play_2d( "cs_give_gun" );
}

cs_intro_bg_plane_breach( var_0 )
{

}

cs_intro_player_remove_jetpack( var_0 )
{

}

cs_intro_plane_jumper_boost( var_0 )
{

}

cs_intro_plane_jumper_land( var_0 )
{

}

cs_intro_plane_jumper_drop_to_ground( var_0 )
{

}

drop_pod( var_0 )
{
    wait 1.5;

    if ( level.aud.firstdroppod )
    {
        thread first_drop_pod_submix();
        level.aud.firstdroppod = 0;
        var_0 soundscripts\_snd_playsound::snd_play_linked( "drop_pod_first" );
    }
    else
        var_0 soundscripts\_snd_playsound::snd_play_linked( "drop_pod" );

    wait 1.1;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "drop_pod_impact" );
    wait 0.4;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "snow_explosion_debris_light" );
}

first_drop_pod_submix()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "first_drop_pod", 0.5 );
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "first_drop_pod", 0.2 );
}

razorback_explosion()
{
    level.razorback_org soundscripts\_snd_playsound::snd_play_linked( "littlebird_helicopter_secondary_exp" );
}

background_explosion( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "snow_explosion_dist", var_0 );
}

playspace_explosion( var_0, var_1 )
{
    wait 0.1;
    var_2 = soundscripts\_snd_playsound::snd_play_at( "snow_explosion_impact", var_0 );
}

warbird_crash_site( var_0, var_1 )
{
    if ( var_0 == "bunker_warbird_1" )
    {
        wait 9.8;
        var_1 soundscripts\_snd_playsound::snd_play_linked( "cs_warbird" );
    }
}

mech_fire_missile_first( var_0, var_1 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mech_missiles" );
    thread mech_fire_missile( var_0, var_1 );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mech_missiles", 0.25 );
    wait 1.4;
    soundscripts\_audio_mix_manager::mm_add_submix( "mech_missiles" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mech_missiles", 1 );
}

mech_fire_missile( var_0, var_1 )
{
    soundscripts\_snd_playsound::snd_play_2d( "wpn_mahem_crash_npc" );
    var_0 waittill( "death" );
    level.razorback soundscripts\_snd_playsound::snd_play_linked( "wpn_mahem_crash_proj_exp" );
}

razor_cormack_reaches_crate( var_0 )
{

}

razor_cormack_stowing_gun( var_0 )
{

}

razor_cormack_hand_on_crate( var_0 )
{

}

razor_player_hand_on_crate( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "cs_razorback_liftoff_front", 9.2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "push_crate", 0.2 );
    soundscripts\_snd_playsound::snd_play_2d( "cs_push_crate_foley" );
    wait 2.1;
    soundscripts\_snd_playsound::snd_play_2d( "cs_push_crate" );
    wait 5.4;
    soundscripts\_snd_filters::snd_fade_in_filter( "push_crate", 1 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "push_crate", 1 );
    level.razorback soundscripts\_snd_playsound::snd_play_delayed_linked( "cs_razorback_missiles", 10.25 );
}

razor_player_hand_off_crate( var_0 )
{
    wait 1;
    soundscripts\_snd_filters::snd_fade_out_filter( 1 );
}

razor_crate_move( var_0 )
{
    common_scripts\utility::flag_wait( "razor_crate_stops" );
}

razor_rb_hatch_close( var_0 )
{
    wait 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "crash_npc_weaps", 2 );
}

razor_rb_lifting_off( var_0 )
{

}

razor_rb_missile_hit( var_0 )
{

}

razor_rb_missile_launch( var_0 )
{

}

cave_entry_tank_missile( var_0 )
{
    wait 1;
    soundscripts\_snd_playsound::snd_play_2d( "crash_crev_missiles_incoming" );
    soundscripts\_snd_playsound::snd_play_2d( "crash_crev_rocket_front" );
    soundscripts\_audio_mix_manager::mm_add_submix( "crash_cave_entry", 0.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "crash_crev_fall_cave_front", 3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "crash_crev_fall_exertions", 3 );
}

cave_entry()
{
    wait 1.8;
    soundscripts\_audio_mix_manager::mm_add_submix( "crash_cave_entry_2", 0.5 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_npc_weaps", 0 );
    soundscripts\_audio_music::mus_stop();
    wait 1.2;
    thread fall_cave_swell();
    wait 5;
    level.aud.panned_quad_1_front scalevolume( 0, 0.5 );
    level.aud.panned_quad_1_rear scalevolume( 0, 0.5 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
    wait 1.6;
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_cave_entry", 1 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_cave_entry_2", 1 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave", 1 );
}

fall_cave_swell()
{
    wait 8.6;
    soundscripts\_snd_playsound::snd_play_2d( "cave_stress" );
    wait 3.5;
    soundscripts\_snd::snd_music_message( "crash_cave_stealth" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_cave_entry", 1 );
}

crevasse_slide_hands( var_0 )
{

}

crevasse_impact_wall( var_0 )
{

}

crevasse_slide_end( var_0 )
{

}

crevasse_impact_ground( var_0 )
{

}

pro_cave_get_up( var_0 )
{

}

pro_cave_pick_up_gun( var_0 )
{

}

pro_cave_help_ilona( var_0 )
{

}

pro_cave_stowing_gun( var_0 )
{

}

pro_cave_grabbing_gun( var_0 )
{

}

pro_cave_roll_over( var_0 )
{

}

pro_cave_helped_up( var_0 )
{

}

pro_cave_ilona_pick_up_gun( var_0 )
{

}

crevasse_player_fall_down( var_0 )
{

}

crevasse_player_slide_hands( var_0 )
{

}

crevasse_player_impact_wall( var_0 )
{

}

crevasse_player_slide_end( var_0 )
{

}

crevasse_player_impact_ground( var_0 )
{
    thread crevasse_player_impact_ground_throttled();
}

crevasse_player_impact_ground_throttled()
{
    if ( level.aud.crvplrhitground == 0 )
    {
        level.aud.crvplrhitground = 1;
        soundscripts\_snd_playsound::snd_play_2d( "crash_crev_hit_ground_front" );
        soundscripts\_snd_playsound::snd_play_2d( "crash_crev_fall_exertion_player" );
        level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "crash_crev_foley_cormack", 4.1 );
        level.ilana soundscripts\_snd_playsound::snd_play_delayed_linked( "crash_crev_foley_ilona", 4.8 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "crash_crev_quake_front", 11.65 );
    }
}

crevasse_player_get_up( var_0 )
{

}

ilana_break_wall( var_0 )
{
    var_0 waittillmatch( "single anim", "kick_wall" );
    wait 2.4;
    soundscripts\_snd_playsound::snd_play_at( "cave_ilana_kick_wall", ( 2793, 8203, 990 ) );
    wait 0.55;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "crsh_iln_grunt3" );
}

cormack_flare()
{
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "cave_flare_ignite" );
    wait 0.25;
    level.cormack soundscripts\_snd_playsound::snd_play_loop_linked( "cave_flare_loop", "flare_off", 0, 1.5 );
    common_scripts\utility::flag_wait( "say_light_off" );
    wait 5.1;
    level notify( "flare_off" );
}

stalactite_fall( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "cave_stalactite_fall", var_0 );
}

seo_zipline_harpoon_fire( var_0, var_1, var_2 )
{
    var_3 = soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_shot", var_0 );
    var_3 moveto( var_1, var_2 );
}

seo_zipline_harpoon_impact( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_impact", var_0 );
}

seo_zipline_rappel_begin()
{
    var_0 = self;
    var_0 thread snd_play_linked_notify_ent( "seo_linelauncher_move", "zipline_done", 0.5 );
}

snd_play_linked_notify_ent( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", self.origin );
    var_3 linkto( self );
    var_3 playsound( var_0 );
    self waittill( var_1 );
    var_3 scalevolume( var_2 );
    wait(var_2);
    var_3 stopsounds();
    waitframe();
    var_3 delete();
}

seo_zipline_rappel_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "seo_npc_zipline_unhook" );
    var_0 notify( "zipline_done" );
}

seo_zipline_retract_rope( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "seo_npc_zipline_retract", var_0 );
}

drop_pod_screen_shake()
{
    soundscripts\_snd_playsound::snd_play_2d( "cave_low_hit" );
}

drop_pod_screen_shake_large( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "cave_low_hit_2" );
    soundscripts\_snd_playsound::snd_play_2d( "narrow_cave_rumble_0" + var_0 );
}

turkey_shoot()
{
    soundscripts\_snd_playsound::snd_play_2d( "cave_crystal_long" );
}

cave_npc_boost_assist( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "crash_boost_land_assist_npc" );
}

cave_npc_boost_assist_land( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "crash_boost_land_assist_npc_land" );
}

player_knockdown()
{
    soundscripts\_snd_playsound::snd_play_2d( "cave_low_hit" );
}

goliath_land( var_0 )
{
    common_scripts\utility::flag_wait( "player_up_close" );
    maps\_utility::wait_for_flag_or_timeout( "goliath_change_anim", 0.75 );
    soundscripts\_snd_playsound::snd_play_at( "crash_gol_bridge_mech_enter", ( 1292, 3232, 399 ), "aud_stop_mech_enter", undefined, 0.5 );
    maps\_utility::wait_for_flag_or_timeout( "goliath_change_anim", 2.45 );
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_mech_run", "aud_stop_mech_run", undefined, 0.3 );
    common_scripts\utility::flag_wait( "goliath_change_anim" );
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_mech_attack" );
    soundscripts\_audio_mix_manager::mm_add_submix( "crash_goliath_bridge_moment" );
    wait 0.1;
    level notify( "aud_stop_mech_enter" );
    level notify( "aud_stop_mech_run" );
    wait 0.9;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_plr_breath_1" );
    common_scripts\utility::flag_wait( "friendlies_move" );
    wait 1.25;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_plr_breath_2" );
    wait 2.75;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_mech_throw" );
    wait 1.65;
    soundscripts\_snd_playsound::snd_play_at( "crash_gol_bridge_mech_rkt_sweet", ( 1251, 3597, 232 ) );
    wait 0.35;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_hanging" );
    soundscripts\_snd_playsound::snd_play_at( "crash_gol_bridge_bg_fire", ( 1251, 3597, 232 ) );
    wait 0.5;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_plr_breath_3" );
    wait 3.25;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_get_device" );
    wait 2.95;
    soundscripts\_snd_playsound::snd_play_at( "crash_gol_bridge_scuffle", ( 1251, 3597, 232 ) );
    common_scripts\utility::flag_wait( "start_reso_move" );
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_plant_device" );
    common_scripts\utility::flag_wait( "cormack_throw_moment" );
    wait 1.3;
    soundscripts\_snd_playsound::snd_play_at( "crash_gol_bridge_scuffle_end", ( 1251, 3597, 232 ) );
    wait 0.25;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_device_detonate" );
    common_scripts\utility::flag_wait( "bridge_explode" );
    wait 0.4;
    thread recently_loaded_listener( "cormack_in_chamber" );
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_collapse", "recently_loaded" );
    wait 5.5;
    soundscripts\_snd_playsound::snd_play_2d( "crash_gol_bridge_plr_breath_1", "recently_loaded" );
    wait 9;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_int_cave_post_goliath", 1 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_post_goliath_sur" );
    level notify( "waterfall_end" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "crash_goliath_bridge_moment" );
    common_scripts\utility::flag_wait( "ice_bridge_done" );
}

recently_loaded_listener( var_0 )
{
    while ( !common_scripts\utility::flag( var_0 ) )
    {
        if ( issaverecentlyloaded() )
        {
            level notify( "recently_loaded" );

            if ( var_0 == "crash_lighting_cinema_end" )
            {
                soundscripts\_snd_playsound::snd_play_2d( "skyj_land_amb_2" );
                soundscripts\_audio_mix_manager::mm_add_submix( "crash_mute_foley" );
                wait 4;
                soundscripts\_audio_mix_manager::mm_clear_submix( "crash_mute_foley" );
            }

            return;
        }

        waitframe();
    }
}

cormack_boost_jump( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "npc_boost_jump" );
}

bridge_reso_detonation()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "goliath_bridge_reso", 3 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "goliath_bridge_explode", 5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "goliath_bridge_fall", 7 );
}

cormack_narrow_cave_start( var_0 )
{
    wait 4.2;
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "narrow_cave_cormack_foley_1" );
}

ilana_narrow_cave_start( var_0 )
{

}

cormack_narrow_cave_search( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_2", 3.5 );
}

cormack_narrowcave_search_enter( var_0 )
{

}

cormack_narrowcave_search_exit( var_0 )
{

}

cormack_narrowcave_search_traverse_sec1( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_3", 0.25 );
}

narrowcave_traverse_sec1( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_4", 0.05 );
}

narrowcave_sec1_traverse_sec2( var_0 )
{

}

narrowcave_sec2_enter( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_5", 0.25 );
}

narrowcave_sec2_exit( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_6", 1.0 );
}

narrowcave_sec2_traverse_floodroom( var_0 )
{
    level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked( "narrow_cave_cormack_foley_7", 0.35 );
}

cormack_narrowcave_breach_turn( var_0 )
{

}

cormack_narrowcave_breach_ledge( var_0 )
{

}

cormack_narrowcave_breach_grab_axe( var_0 )
{

}

cormack_narrowcave_breach_surface( var_0 )
{

}

enemy_narrowcave_breach_axe_hit( var_0 )
{

}

ilana_narrow_cave_search( var_0 )
{
    var_0 waittillmatch( "single anim", "end_anim" );
}

cave_in()
{
    soundscripts\_snd_playsound::snd_play_at( "cave_in", ( 885, 2604, -862 ) );
    wait 0.7;
    thread water_rising_01();
    wait 0.1;
    thread water_rising_02();
    thread water_rising_03();
    level.aud.panned_quad_3_front scalevolume( 0, 1 );
    level.aud.panned_quad_3_rear scalevolume( 0, 1 );
    wait 1;
    level.aud.panned_quad_3_front soundscripts\_snd_playsound::snd_stop_sound();
    level.aud.panned_quad_3_rear soundscripts\_snd_playsound::snd_stop_sound();
}

start_water_breach()
{
    level.player enablecustomweaponcontext();
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "slomo" );
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_enter", "slowmodone" );
    soundscripts\_snd_playsound::snd_play_2d( "water_breach_axe_throw" );
    thread maps\_water::clearunderwateraudiozone();
    soundscripts\_audio_mix_manager::mm_add_submix( "water_breach", 1.5 );
}

end_water_breach()
{
    level notify( "slowmodone" );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "slomo" );
    level.player disablecustomweaponcontext();
    soundscripts\_snd_playsound::snd_play_2d( "slo_mo_exit" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "water_breach", 0.5 );
}

water_rising_01()
{
    soundscripts\_snd_playsound::snd_play_at( "water_cave_rising_start_01", ( 959, 1918, -886 ) );
    wait 1.75;
    soundscripts\_snd_playsound::snd_play_loop_at( "water_cave_rising_01", ( 959, 1918, -886 ), "player_starting_uw_breach" );
}

water_rising_02()
{
    soundscripts\_snd_playsound::snd_play_at( "water_cave_rising_start_02", ( 869, 1952, -886 ) );
    wait 1.9;
    soundscripts\_snd_playsound::snd_play_loop_at( "water_cave_rising_02", ( 869, 1952, -886 ), "player_starting_uw_breach" );
}

water_rising_03()
{
    soundscripts\_snd_playsound::snd_play_at( "water_cave_rising_start_03", ( 973, 1991, -886 ) );
    wait 1.7;
    soundscripts\_snd_playsound::snd_play_loop_at( "water_cave_rising_03", ( 973, 1991, -886 ), "player_starting_uw_breach" );
    soundscripts\_snd_playsound::snd_play_loop_at( "water_cave_rising_04", ( 884, 1869, -886 ), "player_starting_uw_breach" );
}

wind_warning( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_linked( "emt_wind_gust_whistle" );
}

wind_gust( var_0 )
{
    level.player soundscripts\_snd_playsound::snd_play_linked( "emt_wind_gust_close" );
    level.player soundscripts\_snd_playsound::snd_play_linked( "emt_wind_gust_howl" );
}

overlook_land()
{
    soundscripts\_snd_playsound::snd_play_2d( "overlook_land" );
}

overlook_fall()
{
    soundscripts\_snd_playsound::snd_play_2d( "overlook_fall" );
}

overlook_recover()
{
    soundscripts\_snd_playsound::snd_play_2d( "overlook_recover" );
}

lake_events()
{

}

enter_lake_cave()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_weapon_foley" );
    soundscripts\_audio_mix_manager::mm_add_submix( "smooth_lake_entry", 1 );
    soundscripts\_audio_zone_manager::azm_stop_zone( "crash_ext_postoverlook", 1 );
    level.aud.panned_quad_2_front soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice" );
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_play_loop( "amb_cave_ice_sur" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "step_land_plr_dmg_rock", 0.9 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gear_rattle_plr_dmg_land", 0.9 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "pc_boost_land", 0.9 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "lake_player_exert", 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "cave_low_hit", 2.5 );
    wait 1;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_precave", 1 );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "smooth_lake_entry", 0 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_stop_sound();
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_weapon_foley" );
}

missile_fire( var_0, var_1, var_2 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "missile_fire", 0.1 );
    level.lake_chopper soundscripts\_snd_playsound::snd_play_linked( "wpn_mahem_crash_npc" );
    var_0 soundscripts\_snd_playsound::snd_play_loop( "wpn_mahem_crash_loop" );
    var_1 soundscripts\_snd_playsound::snd_play_loop( "wpn_mahem_crash_loop" );
    var_0 common_scripts\utility::waittill_notify_or_timeout( "death", 2 );
    var_0 soundscripts\_snd_playsound::snd_stop_sound();
    var_1 soundscripts\_snd_playsound::snd_stop_sound();
    soundscripts\_snd_playsound::snd_play_at( "wpn_mahem_crash_proj_exp", var_2 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "missile_fire" );
}

lake_warbird_approaches()
{
    if ( !common_scripts\utility::flag( "lake_player_fail" ) )
    {
        level.lake_chopper soundscripts\_snd_playsound::snd_play_linked( "warbird_field_flyby_fast_close" );
        level.lake_chopper soundscripts\_snd_playsound::snd_play_linked( "warbird_field_spawn_1st" );
        level.lake_chopper soundscripts\_snd_playsound::snd_play_loop( "fus_warbird_plr_chop_lp" );
    }
}

lake_fall_in()
{
    level notify( "lake_player_fall_in" );
    soundscripts\_audio::aud_set_music_submix( 1 );
    soundscripts\_audio_music::mus_play( "mus_crash_lake_fall", 0, 0 );
    soundscripts\_audio_mix_manager::mm_add_submix( "fall_lake" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "global_volume_cut_3" );
    soundscripts\_snd_playsound::snd_play_2d( "fall_lake" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fall_lake_lfe", 1.1 );
    level.lake_chopper soundscripts\_snd_playsound::snd_stop_sound();
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fall_lake", 2 );
    level.aud.panned_quad_1_front scalevolume( 0, 0.5 );
    level.aud.panned_quad_2_rear scalevolume( 0, 0.5 );
    wait 1;
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_stop_sound();
    level.aud.panned_quad_2_rear soundscripts\_snd_playsound::snd_stop_sound();
}

lake_exit()
{
    wait 0.2;
    maps\_water::clearunderwateraudiozone();
    soundscripts\_snd_playsound::snd_play_2d( "fall_lake_exit" );
    soundscripts\_snd::snd_music_message( "double_agent" );
    wait 1.5;
    soundscripts\_audio_zone_manager::azm_start_zone( "crash_ext_end", 1 );
    level.aud.panned_quad_1_front soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_2" );
    level.aud.panned_quad_1_rear soundscripts\_snd_playsound::snd_play_loop( "amb_wind_light_gust_2_sur" );
    level.aud.panned_quad_1_front scalevolume( 1 );
    level.aud.panned_quad_1_rear scalevolume( 1 );
    wait 15;
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_water_exit" );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_water_exit" );
}

bad_guys_die( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "bad_guys_die", 1 );
}

cormack_hand_on_ilana( var_0 )
{
    level.ilana soundscripts\_snd_playsound::snd_play_linked( "cormack_hand_on_ilana" );
}

ilana_pick_up_gun( var_0 )
{
    level.ilana soundscripts\_snd_playsound::snd_play_linked( "wpn_med_pickup" );
}

pickup_stinger()
{
    thread cormack_firing_listener();
    soundscripts\_snd_playsound::snd_play_2d( "wpn_launcher_pickup_plr" );
    wait 0.1;
    common_scripts\utility::flag_wait( "player_bottom_of_hill" );
}

cormack_pickup_stinger( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "wpn_launcher_pickup" );
}

cormack_firing_listener()
{
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "wpn_stingerm7_npc" );
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "wpn_stingerm7_detail_npc" );
    thread cormack_shoot_missile( 0 );
}

cormack_shoot_missile( var_0 )
{
    wait(var_0);
    level.cormack soundscripts\_snd_playsound::snd_play_linked( "wpn_stingerm7_ignite_npc" );
}

cormack_missile( var_0 )
{
    common_scripts\utility::flag_wait_any( "cormack_fires_stinger", "cormack_fires_stinger_failsafe" );

    if ( isdefined( var_0 ) )
        var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "wpn_stingerm7_loop", "cormack_missile_hit" );
}

vtol_flyin()
{
    common_scripts\utility::flag_wait( "obj_end_get_gun" );
    level.end_vtol vehicle_turnengineoff();
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "vtol_incoming_chop", "vtol_downed", 0, 1 );
    wait 7.7;
    var_0 = level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "vtol_incoming" );
    level waittill( "vtol_downed" );
    var_0 soundscripts\_snd_playsound::snd_stop_sound();
    soundscripts\_snd_playsound::snd_play_at( "crash_finale_warbird_hit_front", ( -8151, -24624, 242 ) );
    soundscripts\_snd_playsound::snd_play_at( "crash_finale_warbird_hit_rear", ( 2037, -7148, 242 ) );
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "wpn_mahem_crash_proj_exp" );
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "exp_explo_lfe_4" );
    wait 0.5;
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "vtol_incoming_going_down" );
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "vtol_incoming_going_down_chop" );
    wait 0.3;
    soundscripts\_audio_mix_manager::mm_add_submix( "vtol_crash", 1 );
    common_scripts\utility::flag_wait( "end_vtol_dying" );
    soundscripts\_snd_playsound::snd_play_at( "crash_finale_warbird_hits_ground_front", ( 1557, -19346, -405 ) );
    soundscripts\_snd_playsound::snd_play_at( "crash_finale_warbird_hits_ground_rear", ( -681, -7912, -405 ) );
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "crash_finale_warbird_hits_ground_lfe" );
    level.end_vtol thread snd_play_delayed_linked_nocull( "crash_finale_warbird_slides_to_cliff_distant", 1, 9999 );
    level.end_vtol thread snd_play_delayed_linked_nocull( "crash_finale_warbird_slides_to_cliff_close", 9.8, 9999 );
    thread warbird_falling_rocks_loop();
    thread warbird_recover_fail();
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "vtol_crash", 2 );
}

snd_play_delayed_linked_nocull( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", self.origin );
    var_3 linkto( self );
    wait(var_1);
    var_3 playsound( var_0, "sounddone", 0, var_2 );
    var_3 waittill( "sounddone" );
    waitframe();
    var_3 delete();
}

warbird_falling_rocks_loop()
{
    soundscripts\_snd_playsound::snd_play_loop_at( "crash_finale_falling_rocks_loop", ( 822, -14143, -2088 ), "recovered_cargo_success", 0, 1 );
    wait 13.2;
    level notify( "warbird_end_slide" );
}

warbird_recover_fail()
{
    level endon( "recovered_cargo_success" );
    wait 19.25;
    level.end_vtol soundscripts\_snd_playsound::snd_play_linked( "crash_finale_warbird_falls", "recovered_cargo_success", 0, 1 );
}

recover_cargo()
{
    level notify( "recovered_cargo_success" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "crash_finale_recover_cargo", 0.35 );
    wait 0.35;
    soundscripts\_audio_mix_manager::mm_add_submix( "recover_cargo" );
    wait 2.4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "recover_cargo", 0.5 );
}

exfil_fail()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "recover_cargo" );
    soundscripts\_snd_playsound::snd_play_2d( "end_exfil_fail" );
}

gideon_exfil_boost( var_0 )
{
    level.gideon soundscripts\_snd_playsound::snd_play_linked( "npc_boost_jump" );
}

gideon_exfil_foley1( var_0 )
{

}

gideon_exfil_foley2( var_0 )
{

}

gideon_exfil_foley3( var_0 )
{

}

gideon_exfil_foley4( var_0 )
{

}

gideon_jump_to_heli( var_0 )
{
    wait 0.15;
    level.gideon soundscripts\_snd_playsound::snd_play_linked( "npc_boost_jump" );
}

boost_jump_to_heli( var_0 )
{
    level.end_vtol soundscripts\_snd_playsound::snd_play_delayed_linked( "crash_finale_warbird_falls", 1.5 );
    wait 0.15;

    if ( common_scripts\utility::flag( "player_exfil_success" ) )
    {
        soundscripts\_snd_playsound::snd_play_2d( "pc_boost_jump" );
        thread soundscripts\_audio_mix_manager::mm_add_submix( "boost_jump_heli" );
    }
}

grab_hand( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "end_exfil_foley" );
}

railgun_charge()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "railgun_charge", "railgun_stop" );
}

railgun_ready()
{
    level.player soundscripts\_snd_playsound::snd_play_2d( "railgun_ready" );
    level.player soundscripts\_snd_playsound::snd_play_loop_2d( "railgun_ready_loop", "railgun_fired" );
    level.player waittill( "railgun_stop_fully_charged_fx" );
    level notify( "railgun_fired" );
}
