// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    launch_threads();
    thread launch_loops();
    create_level_envelop_arrays();
    create_level_misc_arrays();
    precache_presets();
    thread maps\sanfran_vo::init_pcap_vo();
    thread setup_bigmoment_notetracks();
    register_snd_messages();
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "no_occlusion" );
    aud_set_timescale();
    soundscripts\_audio_mix_manager::mm_add_submix( "sfa_level_global_mix" );
    soundscripts\_audio_mix_manager::mm_add_submix( "temp_vo_premix" );
}

init_snd_flags()
{

}

init_globals()
{

}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread point_source_dambs();
    thread pitbull_intro_foley_ui();
    thread set_up_bus_crash_anims();
    thread set_up_median_crash_anims();
    thread set_up_pitbull_crash_anims();
    thread set_up_pitbull_escape_anims();
    thread level_start_fade_in();
}

launch_loops()
{
    if ( level.currentgen && !istransientloaded( "sanfran_outro_tr" ) )
        level waittill( "tff_transition_intro_to_outro" );

    common_scripts\utility::loop_fx_sound( "emt_fire_roar_s_01", ( -4079, 71789, 67 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -4064, 71690, 51 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -5099, 71580, -1061 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -5172, 72583, -820 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_m_01", ( -4987, 72345, -840 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -5437, 71946, -1287 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -5484, 71919, -1287 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -5413, 71896, -1317 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_02", ( -5368, 71864, -1282 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -5306, 71931, -1253 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -5649, 71669, -1441 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_m_01", ( -5732, 71626, -1406 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_s_01", ( -5861, 71738, -1449 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_s_01", ( -5698, 72169, -1432 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -5632, 72213, -1410 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_m_01", ( -5867, 72158, -1453 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_critical_01", ( -5094, 71499, -1108 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_02", ( -5094, 71499, -1118 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_critical_02", ( -5675, 72619, -948 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -5675, 72619, -958 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_critical_01", ( -5610, 72434, -959 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_crackle_l_01", ( -5610, 72434, -949 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_l_critical_02", ( -6198, 71424, -968 ), 1 );
    common_scripts\utility::loop_fx_sound( "emt_fire_roar_h_01", ( -6198, 71424, -978 ), 1 );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

create_level_misc_arrays()
{
    level.aud.ambientexp = [];
    level.aud.ambientexp["sfa_bridge_car_explode"] = [ [ "sfa_bridge_car_explode_01", 0 ], [ "sfa_bridge_car_explode_02", 0 ], [ "sfa_bridge_car_explode_03", 0 ], [ "sfa_bridge_car_explode_04", 0 ] ];
    level.aud.ambientexp["sfa_bridge_truck_explode"] = [ [ "sfa_truck_explode", 0 ] ];
    level.aud.ambientexp["sfa_bridge_heli_explode"] = [ [ "sfa_heli_explode_sm_main_01", 0 ], [ "sfa_heli_explode_sm_main_02", 0 ] ];
}

precache_presets()
{

}

aud_set_timescale()
{
    soundsettimescalefactor( "voices", 0 );
    soundsettimescalefactor( "voices_critical", 0 );
    soundsettimescalefactor( "scripted", 0 );
}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "start_intro", ::start_intro );
    soundscripts\_snd::snd_register_message( "start_tunnel", ::start_tunnel );
    soundscripts\_snd::snd_register_message( "start_oncoming", ::start_oncoming );
    soundscripts\_snd::snd_register_message( "start_bridge", ::start_bridge );
    soundscripts\_snd::snd_register_message( "start_street", ::start_street );
    soundscripts\_snd::snd_register_message( "start_police", ::start_police );
    soundscripts\_snd::snd_register_message( "start_pitbull", ::start_pitbull );
    soundscripts\_snd::snd_register_message( "start_van", ::start_van );
    soundscripts\_snd::snd_register_message( "start_boost", ::start_boost );
    soundscripts\_snd::snd_register_message( "aud_drone_view_intro_start", ::aud_drone_view_intro_start );
    soundscripts\_snd::snd_register_message( "aud_drone_view_intro_target", ::aud_drone_view_intro_target );
    soundscripts\_snd::snd_register_message( "setup_audio_zone_tunnel", ::setup_audio_zone_tunnel );
    soundscripts\_snd::snd_register_message( "chase_van_rabbiting_anim", ::chase_van_rabbiting_anim );
    soundscripts\_snd::snd_register_message( "gate_crash", ::gate_crash );
    soundscripts\_snd::snd_register_message( "bus_crash_start", ::bus_crash_start );
    soundscripts\_snd::snd_register_message( "npc_pitbull_shot", ::npc_pitbull_shot );
    soundscripts\_snd::snd_register_message( "npc_heli_shot", ::npc_heli_shot );
    soundscripts\_snd::snd_register_message( "car_chase_crash", ::car_chase_crash );
    soundscripts\_snd::snd_register_message( "atlas_van_explode", ::atlas_van_explode );
    soundscripts\_snd::snd_register_message( "aud_tanker_crash", ::aud_tanker_crash );
    soundscripts\_snd::snd_register_message( "aud_tanker_fall_down", ::aud_tanker_fall_down );
    soundscripts\_snd::snd_register_message( "van_cuts_off_player", ::van_cuts_off_player );
    soundscripts\_snd::snd_register_message( "aud_median_impact", ::aud_median_impact );
    soundscripts\_snd::snd_register_message( "aud_atlas_suv_explo", ::aud_atlas_suv_explo );
    soundscripts\_snd::snd_register_message( "player_in_oncoming", ::player_in_oncoming );
    soundscripts\_snd::snd_register_message( "spawn_new_traffic_vehicle", ::spawn_new_traffic_vehicle );
    soundscripts\_snd::snd_register_message( "pc_pitbull_spawn", ::pc_pitbull_spawn );
    soundscripts\_snd::snd_register_message( "monitor_pitbull_oncoming", ::monitor_aud_median );
    soundscripts\_snd::snd_register_message( "spawn_driving_police_car", ::spawn_driving_police_car );
    soundscripts\_snd::snd_register_message( "intro_give_player_driving", ::intro_give_player_driving );
    soundscripts\_snd::snd_register_message( "pitbull_crash_sound_design", ::pitbull_crash_sound_design );
    soundscripts\_snd::snd_register_message( "pc_pitbull_crash", ::pc_pitbull_crash );
    soundscripts\_snd::snd_register_message( "aud_pitbull_crash_concussion", ::aud_pitbull_crash_concussion );
    soundscripts\_snd::snd_register_message( "bridge_post_crash_pitbull_crawl_done", ::bridge_post_crash_pitbull_crawl_done );
    soundscripts\_snd::snd_register_message( "panic_walla", ::panic_walla );
    soundscripts\_snd::snd_register_message( "panic_walla_oneshots", ::panic_walla_oneshots );
    soundscripts\_snd::snd_register_message( "spawn_parked_police_car", ::spawn_parked_police_car );
    soundscripts\_snd::snd_register_message( "bridge_atlas_suv_drive_up", ::bridge_atlas_suv_drive_up );
    soundscripts\_snd::snd_register_message( "start_burke_boost_kick", ::start_burke_boost_kick );
    soundscripts\_snd::snd_register_message( "bridge_street_fight", ::bridge_street_fight );
    soundscripts\_snd::snd_register_message( "start_bridge_helis", ::start_bridge_helis );
    soundscripts\_snd::snd_register_message( "tanker_fireball", ::tanker_fireball );
    soundscripts\_snd::snd_register_message( "bridge_car_explode", ::bridge_car_explode );
    soundscripts\_snd::snd_register_message( "bridge_tanker_explode", ::bridge_tanker_explode );
    soundscripts\_snd::snd_register_message( "aud_little_bird_hit", ::aud_little_bird_hit );
    soundscripts\_snd::snd_register_message( "start_jerk_driver_car", ::start_jerk_driver_car );
    soundscripts\_snd::snd_register_message( "approaching_standoff", ::approaching_standoff );
    soundscripts\_snd::snd_register_message( "pre_bridge_collapse_helo_idle", ::pre_bridge_collapse_helo_idle );
    soundscripts\_snd::snd_register_message( "pre_bridge_collapse_scene", ::pre_bridge_collapse_scene );
    soundscripts\_snd::snd_register_message( "starting_bridge_collapse", ::starting_bridge_collapse );
    soundscripts\_snd::snd_register_message( "gg_start_bridge_collapse", ::gg_start_bridge_collapse );
    soundscripts\_snd::snd_register_message( "gg_drone_explosions", ::gg_drone_explosions );
    soundscripts\_snd::snd_register_message( "gg_drone_cable_explosions", ::gg_drone_cable_explosions );
    soundscripts\_snd::snd_register_message( "gg_bridge_snap_explosion", ::gg_bridge_snap_explosion );
    soundscripts\_snd::snd_register_message( "gg_start_bus_sliding", ::gg_start_bus_sliding );
    soundscripts\_snd::snd_register_message( "gg_bus_explode_death", ::gg_bus_explode_death );
    soundscripts\_snd::snd_register_message( "bridge_collapsed", ::bridge_collapsed );
    soundscripts\_audio_vehicle_manager::snd_register_vehicle( "bsgods_preset", soundscripts\_audio_presets_music::bsgods_preset_constructor );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_out", ::e3_demo_fade_out );
    soundscripts\_snd::snd_register_message( "e3_demo_fade_in", ::e3_demo_fade_in );
}

zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {

    }
}

music_handler( var_0, var_1 )
{
    level notify( "stop_current_music_thread" );
    level endon( "stop_current_music_thread" );
    var_2 = 1.0;

    switch ( var_0 )
    {
        case "start_intro":
            soundscripts\_audio::aud_set_music_submix( 0.8, 2 );
            break;
        case "transition_to_tunnel":
            soundscripts\_audio_music::mus_stop( 10 );
            break;
        case "start_driving_music":
            if ( isdefined( var_1 ) )
            {
                var_3 = var_1;
                soundscripts\_audio::aud_wait_delay( var_3, 0, 1 );
            }

            soundscripts\_audio::aud_set_music_submix( 0.56, 0.2 );
            soundscripts\_audio_music::mus_play( "mus_sfa_chase_intro", 0 );

            while ( !isdefined( level.aud.pc_veh ) )
                wait 0.05;

            wait 22.5;
            soundscripts\_audio_music::mus_stop( 4 );
            soundscripts\_audio::aud_set_music_submix( 0.56, 1 );
            level.aud.pc_veh thread handle_driving_music( 3.0, 3.0 );
            break;
        case "bridge_chase_outro":
            if ( isdefined( level.aud.pc_veh ) )
                level.aud.pc_veh notify( "bridge_chase_outro" );

            soundscripts\_audio::aud_set_music_submix( 0.64, 0.5 );
            soundscripts\_audio_music::mus_play( "mus_sfa_chase_outro", 0.5 );
            wait 8;
            soundscripts\_audio_music::mus_stop( 1 );
            break;
        case "bridge_post_crash_pitbull_crawl_done":
            break;
        case "bridge_street_fight":
            break;
        case "mus_sfa_street_intro":
            soundscripts\_audio::aud_set_music_submix( var_2, 0.1 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_intro", 0.5 );
            break;
        case "mus_sfa_street_boosters":
            soundscripts\_audio::aud_set_music_submix( var_2, 0.1 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_boosters", 0, 1 );
            soundscripts\_audio_mix_manager::mm_add_submix( "sfa_ext_bridge_intact_combat", 3 );
            break;
        case "mus_sfa_street_vamp1":
            soundscripts\_audio::aud_set_music_submix( var_2, 2 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_vamp1", 0, 3 );
            break;
        case "mus_sfa_street_alt":
            soundscripts\_audio::aud_set_music_submix( var_2, 2 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_alt", 0, 2 );
            break;
        case "mus_sfa_street_vamp2":
            break;
        case "mus_sfa_street_breakdown":
            soundscripts\_audio::aud_set_music_submix( var_2, 2 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_breakdown", 4, 4 );
            break;
        case "mus_sfa_street_outtro":
            soundscripts\_audio::aud_set_music_submix( var_2, 2 );
            soundscripts\_audio_music::mus_play( "mus_sfa_street_outtro", 0, 2 );
            soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_ext_bridge_intact_combat", 5 );
            break;
        case "mus_sfa_street_tag":
            soundscripts\_audio_music::mus_play( "mus_sfa_street_breakdown", 4, 4 );
            break;
        case "approaching_standoff":
            soundscripts\_audio_music::mus_stop( 20 );
            break;
        case "pre_bridge_collapse_scene":
            soundscripts\_audio_music::mus_stop( 4 );
            break;
        case "starting_bridge_collapse":
            soundscripts\_audio_music::mus_stop( 4 );
            break;
        default:
            break;
    }
}

handle_driving_music( var_0, var_1 )
{
    var_2 = self;
    var_0 = soundscripts\_audio::aud_get_optional_param( 0.1, var_0 );
    var_1 = soundscripts\_audio::aud_get_optional_param( 0.1, var_1 );
    soundscripts\_snd::snd_message( "ams_start", "bsgods_preset", "driving", var_0 );
    soundscripts\_snd::snd_message( "ams_set_proxy_vehicle", self );
    var_2 common_scripts\utility::waittill_either( "death", "bridge_chase_outro" );
    soundscripts\_snd::snd_message( "ams_set_proxy_vehicle", undefined );
    soundscripts\_snd::snd_message( "ams_stop", var_1 );
}

start_intro( var_0 )
{
    soundscripts\_snd::snd_music_message( "start_intro" );
    wait 0.05;
    soundscripts\_snd_filters::snd_set_filter( "sfa_vehicle_impacts", 1 );
}

start_tunnel( var_0 )
{
    setup_audio_zone_tunnel();
}

start_oncoming( var_0 )
{
    soundscripts\_snd::snd_music_message( "start_driving_music" );
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
}

start_bridge( var_0 )
{
    soundscripts\_snd::snd_music_message( "start_driving_music" );
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
}

start_street( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
    soundscripts\_snd::snd_music_message( "mus_sfa_street_intro" );
}

start_police( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
    soundscripts\_snd::snd_music_message( "mus_sfa_street_boosters" );
}

start_pitbull( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
    soundscripts\_snd::snd_music_message( "mus_sfa_street_alt" );
}

start_van( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
    soundscripts\_snd::snd_music_message( "mus_sfa_street_breakdown" );
}

start_boost( var_0 )
{
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_street", 1.0 );
}

aud_drone_view_intro_start()
{
    var_0 = 0.75;
    var_1 = 0.3;
    var_2 = 0.75;
    var_3 = 0.1;
    var_4 = 0.4;
    var_5 = 0.5;
    var_6 = 0.75;
    var_7 = 0.25;
    var_8 = 0.1;
    var_9 = 0.75;
    var_10 = 0.4;
    var_11 = 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "sfa_intro", 0.05 );
    var_12 = snd_play_2d_sound( "sfa_intro_opening_drums", var_0 );
    var_13 = snd_play_2d_sound( "sfa_intro_drone1", 0 );
    var_14 = snd_play_2d_sound( "sfa_intro_static_bgrnd", 0, 0.249 );
    var_14 thread aud_fadeup_intro_loop( 1.6, var_2, 0 );
    var_13 thread aud_fadeup_intro_loop( 0.1, var_1, 1.5 );
    level waittill( "aud_drone_view_intro_zoom_in_fleet" );
    var_12 = snd_play_2d_sound( "sfa_intro_zoom_in", var_4 );
    level waittill( "aud_drone_view_intro_zoom_out_fleet" );
    var_12 = snd_play_2d_sound( "sfa_intro_zoom_out", var_5 );
    level waittill( "aud_drone_view_intro_switch_to_camera_2" );
    var_13 snd_fade_and_stop_sound( 0.2 );
    var_12 = snd_play_2d_sound( "sfa_intro_static_burst", var_6 );
    var_15 = snd_play_2d_sound( "sfa_intro_drone2", var_7 );
    var_16 = snd_play_2d_sound( "sfa_intro_pitbull_fadein", var_8 );
    var_12 = snd_play_2d_sound( "sfa_intro_trans_whoosh", 1.0, 0, 5.577 );
    var_12 = snd_play_2d_sound( "sfa_intro_trans_drums", 1.0, 0, 5.577 );
    level waittill( "aud_drone_view_intro_zoom_in_cargo" );
    var_12 = snd_play_2d_sound( "sfa_intro_zoom_in", var_4 );
    level waittill( "aud_drone_view_intro_transition_to_tunnel" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_intro", 0.05 );
    var_14 snd_fade_and_stop_sound( 0.2 );
    var_15 snd_fade_and_stop_sound( 0.2 );
    var_16 snd_fade_and_stop_sound( 2.0 );
}

aud_drone_view_intro_target()
{
    snd_play_2d_sound( "sfa_intro_ui_beep", 0.08 );
}

aud_fadeup_intro_loop( var_0, var_1, var_2 )
{
    wait(var_0);
    self scalevolume( var_1, var_2 );
}

snd_play_2d_sound( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 = soundscripts\_audio::aud_get_optional_param( 1.0, var_1 );
    var_2 = soundscripts\_audio::aud_get_optional_param( 0.0, var_2 );
    var_3 = soundscripts\_audio::aud_get_optional_param( 0.0, var_3 );
    var_4 = soundscripts\_audio::aud_get_optional_param( "sounddone", var_4 );
    var_5 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_5 thread sndx_play_2d_sound( var_0, var_1, var_2, var_3, var_4 );
    return var_5;
}

sndx_play_2d_sound( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( self ) )
    {
        wait(var_3);
        self playsound( var_0, var_4 );
        self scalevolume( var_1, var_2 );
    }
}

snd_fade_and_stop_sound( var_0 )
{
    thread sndx_fade_and_stop_sound( var_0 );
}

sndx_fade_and_stop_sound( var_0 )
{
    var_1 = self;

    if ( isdefined( var_1 ) )
    {
        var_1 scalevolume( 0, var_0 );
        wait(var_0);

        if ( isdefined( var_1 ) )
        {
            var_1 stopsounds();
            wait 0.05;
            var_1 delete();
        }
    }
}

chase_van_rabbiting_anim()
{
    snd_play_2d_sound( "sfa_intro_van_passby" );
}

gate_crash()
{
    thread setup_gate_crash();
}

set_up_bus_crash_anims()
{
    maps\_anim::addnotetrack_customfunction( "bus", "bus_skid", ::bus_skid, "bus_crash" );
    maps\_anim::addnotetrack_customfunction( "bus", "bus_crash", ::bus_crash, "bus_crash" );
}

bus_skid( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "sfa_bus_crash", 0.05 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfa_bus_skid" );
}

bus_crash( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfa_bus_crash" );
    wait 2.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_bus_crash", 0.05 );
}

bus_crash_start()
{

}

npc_pitbull_shot()
{

}

npc_heli_shot( var_0 )
{
    var_1 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "wpn_railgun_shot_npc" );
    var_1 waittill( "death" );

    if ( isdefined( var_1.origin ) )
        common_scripts\utility::play_sound_in_space( "wpn_railgun_exp", var_1.origin );
}

atlas_van_explode( var_0 )
{
    self waittill( "explode" );
    var_1 = spawnstruct();
    var_1.pos = self.origin;
    var_1.duck_alias_ = "exp_generic_explo_sub_kick";
    var_1.duck_dist_threshold_ = 1200;
    var_1.explo_delay_chance_ = 100;
    var_1.shake_dist_threshold_ = 1200;
    var_1.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_1 );
    soundscripts\_snd_playsound::snd_play_delayed_linked( "atlas_van_explo" );
    wait 0.3;

    if ( isdefined( self ) && isdefined( var_0 ) && var_0 vehicle_getspeed() > 5 )
        soundscripts\_snd_playsound::snd_play_linked( "atlas_van_explode_debris" );
}

car_chase_crash()
{

}

aud_tanker_crash()
{
    var_0 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "tanker_truck_swerve_roll", 0.05 );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "sfa_tanker_skid" );
    wait 5.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "tanker_truck_swerve_roll", 0.5 );
}

aud_tanker_fall_down( var_0 )
{
    var_1 = self;
    soundscripts\_audio_mix_manager::mm_add_submix( "tanker_truck_explode", 0.03 );
    var_1 soundscripts\_snd_playsound::snd_play_linked( "sfa_tanker_exp" );
    var_1 soundscripts\_snd_playsound::snd_play_linked( "sfa_tanker_exp_lfe" );
    wait 2.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "tanker_truck_explode", 1.5 );
}

van_cuts_off_player()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "median_crash_explode", 0.05 );
    soundscripts\_snd_playsound::snd_play_2d( "sfa_suv_cuts_off_player" );
}

set_up_median_crash_anims()
{
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "enemy_suv_median", ::enemy_suv_median, "oncoming_crash" );
    maps\_anim::addnotetrack_customfunction( "atlas_suv", "enemy_suv_explode", ::enemy_suv_explode, "oncoming_crash" );
}

enemy_suv_median( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_median_impact" );
}

enemy_suv_explode( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "sfa_median_suv_explode", 0.15 );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "median_crash_explode", 1.0 );
}

aud_median_impact()
{

}

aud_atlas_suv_explo( var_0 )
{

}

player_in_oncoming()
{
    level.aud.median_crash = 1;
}

spawn_new_traffic_vehicle()
{
    var_0 = self;
    var_0 endon( "death" );
    var_1 = 0;
    var_2 = 10;
    var_3 = 1.0;
    var_4 = spawnstruct();
    soundscripts\_snd::snd_message( "snd_register_vehicle", "sfa_generic_traffic", ::sfa_generic_traffic_constructor );

    if ( isdefined( level.nextgen ) )
        var_5 = 50;
    else
        var_5 = 25;

    var_4.preset_name = "sfa_generic_traffic";
    var_4.fadein_time = 0.5;
    var_4.fadeout_time = 0.5;

    for (;;)
    {
        var_6 = soundscripts\_audio_vehicle_manager::dist2yards( distance( var_0.origin, level.player.origin ) );
        var_7 = var_0 vehicle_getspeed();

        if ( !var_1 && ( var_6 < var_5 && var_7 > var_2 ) )
        {
            var_0 soundscripts\_snd::snd_message( "snd_start_vehicle", var_4 );
            var_1 = 1;
        }
        else if ( var_1 && ( var_6 >= var_5 || var_7 <= var_2 ) )
        {
            var_0 soundscripts\_snd::snd_message( "snd_stop_vehicle", var_4.fadeout_time );
            var_1 = 0;
        }

        wait 0.25;
    }
}

start_jerk_driver_car()
{
    soundscripts\_snd::snd_message( "snd_register_vehicle", "civilian_compact_car", ::civilian_compact_car_constructor );
    soundscripts\_snd::snd_message( "snd_start_vehicle", "civilian_compact_car" );
}

pc_pitbull_spawn( var_0 )
{
    level.aud.pc_veh = self;
    soundscripts\_snd::snd_message( "snd_register_vehicle", "pitbull", vehicle_scripts\_pitbull_aud::snd_pitbull_constructor );
    soundscripts\_snd::snd_message( "snd_start_vehicle", "pitbull" );
}

spawn_driving_police_car( var_0 )
{
    var_1 = self;
    var_2 = "sfa_police_siren_yelp";
    var_3 = soundscripts\_snd_playsound::snd_play_loop_linked( "sfa_police_siren_yelp", var_2 );
    var_4 = 0.05;

    while ( !isdefined( level.aud.median_crash ) && isdefined( var_1 ) && isdefined( var_3 ) )
    {
        var_5 = dopplerpitch( var_1.origin, ( 0, 0, 0 ), level.player.origin, level.player getvelocity(), 2, 2 );
        var_3 scalepitch( var_5, var_4 );
        wait(var_4);
    }

    level notify( var_2 );
}

pitbull_intro_foley_ui()
{
    level waittill( "aud_start_sanfran_bridge_pitbull_intro_vo_start" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_intro_plr", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_intro_brk_01", 4.22 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_intro_brk_02", 7.43 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_intro_screen_off", 15.52 );
}

intro_give_player_driving()
{

}

pitbull_crash_sound_design()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "pitbull_crash", 0.03 );
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_first_impact" );
}

set_up_pitbull_crash_anims()
{
    maps\_anim::addnotetrack_customfunction( "_pitbull", "pitbull_impact", ::pitbull_second_impact, "pitbull_crash" );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "pitbull_start_flip", ::pitbull_start_flip, "pitbull_crash" );
    maps\_anim::addnotetrack_customfunction( "_pitbull", "pitbull_land_upside_down", ::pitbull_land_upside_down, "pitbull_crash" );
}

pitbull_second_impact( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_second_impact" );
}

pitbull_start_flip( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "pitbull_upside_down" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "pitbull_crash", 3.0 );
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_flip" );
}

pitbull_land_upside_down( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_land" );
}

aud_pitbull_crash_concussion()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "pitbull_upside_down" );
    soundscripts\_audio_mix_manager::mm_add_submix( "pitbull_crash_concussion", 0.03 );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 1 );
    soundscripts\_snd_filters::snd_fade_in_filter( "sfa_pitbull_crash_concussion", 0.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_crash_concussion", 0.7 );
    wait 10;
    soundscripts\_snd_filters::snd_fade_out_filter( 8 );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 0 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "pitbull_crash_concussion", 3.0 );
}

set_up_pitbull_escape_anims()
{
    if ( level.currentgen && level.transient_zone != "intro" )
        level waittill( "tff_transition_outro_to_intro" );

    maps\_anim::addnotetrack_customfunction( "player_rig", "punch_door", ::punch_door, "pitbull_crawl" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "kick_door", ::kick_door, "pitbull_crawl" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "player_get_up", ::player_escape, "pitbull_crawl" );
}

punch_door( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_punch_door" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "sfa_pitbull_crash_kick_exo", 1.5, 1 );
}

kick_door( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_kick_door" );
}

player_escape( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "sfa_pitbull_crash_escape" );
}

pc_pitbull_crash( var_0 )
{
    soundscripts\_snd::snd_music_message( "bridge_chase_outro" );
    level.player_pitbull soundscripts\_snd::snd_message( "snd_stop_moving_vehicle", 0.5 );
    thread setup_audio_zone_bridge_intact();
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_snd_filters::snd_clear_filter( 1 );
}

bridge_post_crash_pitbull_crawl_done( var_0 )
{
    soundscripts\_snd::snd_music_message( "bridge_post_crash_pitbull_crawl_done" );
}

spawn_parked_police_car( var_0 )
{
    var_1 = 0;

    foreach ( var_4, var_3 in var_0 )
    {
        if ( var_1 % 2 )
            var_3 soundscripts\_snd_playsound::snd_play_loop_linked( "sfa_police_idle", "foo_notify" );
    }

    thread handle_parked_police_car_radios( var_0 );
}

handle_parked_police_car_radios( var_0 )
{
    var_1 = [];

    foreach ( var_4, var_3 in var_0 )
    {
        var_1[var_4] = spawnstruct();
        var_1[var_4].veh_ent = var_3;
        var_1[var_4].snd_ent = undefined;
    }

    var_5 = undefined;
    var_6 = undefined;

    while ( !common_scripts\utility::flag( "flag_van_explosion_start" ) )
    {
        var_7 = 1000000;

        foreach ( var_11, var_9 in var_1 )
        {
            var_10 = distance( level.player.origin, var_1[var_11].veh_ent.origin );

            if ( var_10 < var_7 )
            {
                var_7 = var_10;
                var_6 = var_11;
            }
        }

        if ( !isdefined( var_5 ) || var_5 != var_6 )
        {
            if ( isdefined( var_5 ) && isdefined( var_1[var_5].snd_ent ) )
            {
                var_1[var_5].snd_ent snd_fade_and_stop_sound( 0.5 );
                var_1[var_5].snd_ent = undefined;
            }

            var_1[var_6].snd_ent = var_1[var_6].veh_ent start_parked_police_car_radio();
            var_5 = var_6;
        }

        wait 0.1;
    }

    foreach ( var_9 in var_1 )
    {
        if ( isdefined( var_9.snd_ent ) )
            var_9.snd_ent snd_fade_and_stop_sound( 0.5 );
    }
}

start_parked_police_car_radio()
{
    var_0 = self;
    var_1 = spawn( "script_origin", var_0.origin );
    var_1 linkto( var_0 );
    var_1 scalevolume( 0, 0 );
    var_1 soundscripts\_snd_playsound::snd_play_loop( "sfa_police_radio" );
    var_1 scalevolume( 1, 0.5 );
    return var_1;
}

bridge_atlas_suv_drive_up( var_0 )
{
    var_1 = "";

    if ( var_0 == 1 )
    {
        var_1 = "sfa_atlas_suv_drive_up1";
        wait 0.5;
    }
    else
    {
        var_1 = "sfa_atlas_suv_drive_up2";
        wait 0.5;
    }

    var_2 = soundscripts\_snd_playsound::snd_play_linked( var_1 );
    thread dopplerize_suv_drive_up( var_2 );
}

dopplerize_suv_drive_up( var_0 )
{
    var_1 = self;
    var_2 = 0.05;
    var_3 = 2;
    var_4 = 2;

    while ( isdefined( var_0 ) )
    {
        var_5 = dopplerpitch( var_1.origin, var_1 vehicle_getvelocity(), level.player.origin, level.player getvelocity(), var_3, var_4 );
        var_0 scalepitch( var_5, var_2 );
        wait(var_2);
    }
}

start_burke_boost_kick()
{
    maps\_anim::addnotetrack_animsound( "boost_jump_kick_01_atk", "boost_jump_kick_01", "boost_kick_jump", "sfa_boost_kick_brk_jump" );
    maps\_anim::addnotetrack_animsound( "boost_jump_kick_01_atk", "boost_jump_kick_01", "boost_kick_land", "sfa_boost_kick_brk_land" );
    maps\_anim::addnotetrack_animsound( "boost_jump_kick_01_def", "boost_jump_kick_01", "boost_kick_bodyfall", "sfa_boost_kick_enmy_bodyfall" );
}

bridge_street_fight( var_0 )
{

}

start_bridge_helis( var_0 )
{
    foreach ( var_3, var_2 in var_0 )
        var_2 thread play_bridge_lb_sentinel_flyby();
}

play_bridge_lb_sentinel_flyby()
{
    for (;;)
    {
        if ( soundscripts\_audio_vehicle_manager::units2yards( distance2d( self.origin, level.player.origin ) ) < 90 )
        {
            soundscripts\_snd_playsound::snd_play_linked( "lbs_flyby_short" );
            break;
        }

        wait 0.1;
    }
}

veh_debug_monitor_3d( var_0 )
{
    if ( !isstring( var_0 ) )
        var_0 = "<unnamed>";

    thread soundscripts\_audio::aud_print_3d_on_ent( "VEH " + var_0 + ": ", 1, "red", ::veh_debug_monitor_3d_callback );
}

veh_debug_monitor_3d_callback()
{
    var_0 = soundscripts\_audio_vehicle_manager::dist2yards( distance( self.origin, level.player.origin ) );
    return "yards_3d = " + var_0;
}

tanker_fireball()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "bridge_tanker_fireball", 0.03 );
    soundscripts\_snd_playsound::snd_play_at( "sfa_truck_explode_fireball", ( 5963, 71936, 469 ) );
    wait 2.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "bridge_tanker_fireball", 1.0 );
}

bridge_car_explode()
{
    var_0 = self;
    var_1 = spawnstruct();
    var_1.pos = self.origin;
    var_1.explo_shot_array_ = [ [ "sfa_bridge_car_explode_01", 0 ], [ "sfa_bridge_car_explode_02", 0 ], [ "sfa_bridge_car_explode_03", 0 ], [ "sfa_bridge_car_explode_04", 0 ] ];
    var_1.duck_alias_ = "exp_generic_explo_sub_kick";
    var_1.duck_dist_threshold_ = 1200;
    var_1.explo_delay_chance_ = 0;
    var_1.shake_dist_threshold_ = 1200;
    soundscripts\_snd_common::snd_ambient_explosion( var_1 );
}

bridge_tanker_explode()
{
    soundscripts\_snd_playsound::snd_play_at( "sfa_truck_explode_ignite", ( 5309, 71939, 541 ) );
    level notify( "aud_bridge_fire_clear" );
    wait 1.0;
    soundscripts\_audio_mix_manager::mm_add_submix( "tanker_exp_brings_down_heli", 0.03 );
    var_0 = spawnstruct();
    var_0.pos = ( 5309, 71939, 541 );
    var_0.explo_shot_array_ = [ [ "sfa_truck_explode", 0 ] ];
    var_0.duck_alias_ = "exp_generic_explo_sub_kick";
    var_0.duck_dist_threshold_ = 1200;
    var_0.explo_delay_chance_ = 0;
    var_0.shake_dist_threshold_ = 1200;
    soundscripts\_snd_common::snd_ambient_explosion( var_0 );
    wait 2.0;
    soundscripts\_audio_mix_manager::mm_clear_submix( "tanker_exp_brings_down_heli", 1.0 );
}

aud_little_bird_hit()
{
    var_0 = self;
    var_0 waittill( "deathspin" );
    var_1 = var_0 soundscripts\_snd_playsound::snd_play_linked( "sfa_heli_goes_down" );
    var_0 waittill( "crash_done" );

    if ( isdefined( var_1 ) )
        var_1 scalevolume( 0, 0.1 );

    soundscripts\_audio_mix_manager::mm_add_submix( "little_bird_crash", 0.03 );
    var_2 = spawnstruct();
    var_2.pos = ( 5213, 71359, 573 );
    var_2.explo_shot_array_ = [ [ "sfa_heli_explode", 0 ] ];
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1200;
    var_2.explo_debris_alias_ = "sfa_heli_explode_sm_debris";
    var_2.explo_delay_chance_ = 0;
    var_2.shake_dist_threshold_ = 1200;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
    wait 1.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "little_bird_crash", 2.0 );
}

approaching_standoff()
{
    soundscripts\_snd::snd_music_message( "approaching_standoff" );
}

pre_bridge_collapse_helo_idle()
{
    soundscripts\_snd_playsound::snd_play_loop_linked( "sfa_littlebird_idle" );
}

pre_bridge_collapse_scene( var_0 )
{
    soundscripts\_snd::snd_music_message( "pre_bridge_collapse_scene" );
}

starting_bridge_collapse( var_0 )
{
    soundscripts\_snd::snd_music_message( "starting_bridge_collapse" );
    level notify( "stop_bridge_flares" );
}

bridge_collapsed()
{

}

monitor_aud_median()
{
    if ( !isdefined( level.aud.median_cross ) )
        level.aud.median_cross = 0;

    var_0 = getentarray( "aud_median_0", "targetname" );
    var_1 = getentarray( "aud_median_1", "targetname" );
    var_2 = getentarray( "aud_median_2", "targetname" );
    level endon( "flag_player_crashed" );

    for (;;)
    {
        if ( is_player_touching_median_trigger( var_0 ) )
            level.aud.median_cross = 0;
        else if ( is_player_touching_median_trigger( var_1 ) )
            level.aud.median_cross = 1;
        else if ( is_player_touching_median_trigger( var_2 ) )
            level.aud.median_cross = 2;

        wait 0.05;
    }
}

is_player_touching_median_trigger( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( level.player istouching( var_2 ) )
            return 1;
    }

    return 0;
}

panic_walla( var_0 )
{
    var_1 = 0.5;
    var_2 = 0.4;
    var_3 = [ [ 5, 1.0 ], [ 33, 0.5 ], [ 100, 0.05 ] ];
    var_4 = "sfa_walla_wave1";

    if ( var_0 == "spawner_ambient_spawner_wave01" )
    {
        var_4 = "sfa_walla_wave2";
        var_2 = 0.85;
    }

    var_5 = soundscripts\_snd_playsound::snd_play_loop_2d( var_4, "stop_panic_walla", 2.0, 5.0, var_2 );

    while ( level.aud.bridge_civs.size == 0 )
        waitframe();

    for (;;)
    {
        var_6 = level.aud.bridge_civs;
        var_7 = 0;
        var_8 = 0;

        foreach ( var_10 in var_6 )
        {
            if ( isdefined( var_10 ) )
            {
                var_11 = distance2d( level.player.origin, var_10.origin );
                var_7 += var_11;
                var_8 += 1;
            }
        }

        if ( var_8 > 0 )
        {
            var_13 = var_7 / var_8;
            var_14 = soundscripts\_audio_vehicle_manager::units2yards( var_13 );
            var_15 = soundscripts\_snd::snd_map( var_14, var_3 );
            var_5 scalevolume( var_2 * var_15 );
        }
        else
        {
            level notify( "stop_panic_walla" );
            break;
        }

        wait(var_1);
    }
}

panic_walla_oneshots( var_0 )
{
    var_0 endon( "death" );
    var_1 = var_0 soundscripts\_snd_common::snd_waittill_within_radius( 540 );

    if ( var_1 )
    {
        if ( isdefined( var_0 ) )
        {
            wait(randomfloat( 3.0 ));
            var_0 soundscripts\_snd_playsound::snd_play_linked( "sfa_civ_screams" );
        }
    }
}

gg_start_bridge_collapse()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "sfa_drones_deploy", 8 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_van_torch_rack", 0.85 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_flying_drones", 8.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_shotdown_drones", 15.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_clamp_drones", 17.35 );
    wait 23;
    soundscripts\_audio_mix_manager::mm_add_submix( "sfa_bridge_collapse", 4 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_drones_deploy", 4 );
}

gg_drone_explosions()
{
    var_0 = self;
}

gg_drone_cable_explosions()
{
    var_0 = self;

    if ( var_0.animname == "drone_4" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gg_bridge_drones_explode_01" );
        soundscripts\_snd_playsound::snd_play_2d( "gg_bridge_cable_snaps_01" );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_drones_explode_02", 0.85, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_cable_snaps_02", 1.7, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_cable_snaps_rear", 2.1, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_cable_land", 2.7, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_cable_impact", 2.7, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_slomo_crack", 3.25, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_slomo_bass_dive", 3.5, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_slomo_flame", 3.7, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_slomo_whoosh", 5.85, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_windshield_impact", 6.3, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_collapse_low_end", 6.7, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_move_get_off", 7.55, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_windshield_fall_land", 9.1, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_heli_incoming", 9.15, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_heli_impact_01", 11.35, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_heli_impact_02", 11.45, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_heli_blades", 11.55, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_metal_shift", 13.0, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_lookout", 13.95, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_metal_creak_clank", 14.0, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_givingway", 15.45, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_cable_snap_ricos", 16.0, 1 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_asphalt_cracks", 16.85, 1 );
    }
}

gg_bridge_snap_explosion()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_deck_snap_punch", 0.05, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_drop_explo_punch", 2.6, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_drop_explo", 2.8, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_drop_explo_metal", 2.85, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_collapse_metal", 2.85, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_drop_explo_shot", 2.9, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_collapse_rubble", 2.75, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_helpme", 3.5, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_metal_groan", 5.0, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_slide_explo", 5.85, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_player_slide", 6.15, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_screams", 6.45, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_edge_explo", 7.6, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_edge_explo_punch", 7.65, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_left_imp_far", 9.2, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_imp_glass", 12.55, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_npc_slide_foley", 12.6, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_aftermath_grown", 14.2, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_mus_earthshaker_hit_01", 14.4, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_fallguy_grunts", 14.5, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_imp_far", 14.65, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_fall_front", 15.05, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_fall_dist", 16.4, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_fall_imp", 17.2, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_fall_imp_far", 18.8, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_distant_firetruck_01", 21.45, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_police_right_fall_explo", 21.75, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_mus_earthshaker_hit_02", 24.75, 1 );
}

gg_start_bus_sliding()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_vo_bus_guy", 0.0, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_bus_impact_glass", 0.1, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_bus_impact_far_01", 2.4, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_bus_impact_far_02", 2.95, 1 );
}

gg_bus_explode_death()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_bus_explode", 0.2, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_bus_explode_sub", 0.4, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_mus_earthshaker_drone", 0.65, 1 );
    thread soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_bridge_destroyed", 0.5 );
    thread soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_bridge_collapse", 0.5 );
    wait 0.05;
    thread soundscripts\_audio_mix_manager::mm_add_submix( "sfa_post_bridge_collapse", 0.5 );
    thread soundscripts\_audio_mix_manager::mm_add_submix( "sfa_bridge_collapse_to_zone", 0.5 );
    thread soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_post_bridge_collapse", 5 );
    wait 15;
    soundscripts\_audio_mix_manager::mm_clear_submix( "sfa_bridge_collapse_to_zone", 5 );
}

e3_demo_fade_out()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all", 3.0 );
}

e3_demo_fade_in()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 0.05;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 2.0 );
}

level_start_fade_in()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 0.25;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 5.0 );
}

setup_bigmoment_notetracks()
{
    if ( level.currentgen && level.transient_zone != "bigm" )
        level waittill( "tff_transition_outro_to_bigm" );

    maps\_anim::addnotetrack_customfunction( "player_rig", "slomo_start", ::gg_slomo_start );
    maps\_anim::addnotetrack_customfunction( "player_rig", "slomo_end", ::gg_slomo_end );
    maps\_anim::addnotetrack_customfunction( "player_rig", "vfx_player_hit_windshield", ::gg_player_hit_windshield );
    maps\_anim::addnotetrack_customfunction( "bridge01", "vfx_bridge_shake_left", ::gg_bridge_shake_left );
    maps\_anim::addnotetrack_customfunction( "bridge01", "vfx_bridge_shake_right", ::gg_bridge_shake_right );
    maps\_anim::addnotetrack_customfunction( "Burke", "boost_begin", ::gg_boost_begin );
    maps\_anim::addnotetrack_customfunction( "Burke", "boost_end", ::gg_boost_end );
}

gg_slomo_start( var_0 )
{

}

gg_slomo_end( var_0 )
{

}

gg_player_hit_windshield( var_0 )
{

}

gg_bridge_shake_left( var_0 )
{

}

gg_bridge_shake_right( var_0 )
{

}

gg_boost_begin( var_0 )
{
    if ( !isdefined( level.aud.gg_brk_boost_begin ) )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gg_bridge_brk_boost_jump_01" );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_brk_boost_land", 1.9 );
        level.aud.gg_brk_boost_begin = 1;
    }
}

gg_boost_end( var_0 )
{
    if ( !isdefined( level.aud.gg_brk_boost_end ) )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gg_bridge_distant_firetruck_02" );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_brk_boost_jump_foley", 15.15 );
        soundscripts\_snd_playsound::snd_play_delayed_2d( "gg_bridge_brk_boost_jump_02", 16.45 );
        level.aud.gg_brk_boost_end = 1;
    }
}

setup_audio_zone_tunnel()
{
    soundscripts\_snd::snd_music_message( "transition_to_tunnel" );
    soundscripts\_snd_filters::snd_set_filter( "sfa_vehicle_impacts", 1 );
    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_int_tunnel", 1.0 );
}

setup_audio_zone_bridge_intact()
{
    wait 14;

    if ( level.currentgen && !istransientloaded( "sanfran_outro_tr" ) )
        level waittill( "tff_transition_intro_to_outro" );

    soundscripts\_audio_zone_manager::azm_start_zone( "sf_a_ext_bridge_intact", 20 );
}

setup_gate_crash()
{
    var_0 = self;
    var_1 = 30;
    var_2 = 60;
    var_3 = level.player_pitbull vehicle_getspeed();
    var_4 = distance2d( level.player.origin, level.player_pitbull.origin );

    if ( var_3 < var_1 )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_l_lfe" );
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_l_impact" );

        if ( var_4 < 800 )
            level.player soundscripts\_snd_playsound::snd_play_linked( "gate_crash_l_debris" );
    }

    if ( var_3 > var_1 && var_3 < var_2 )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_m_lfe" );
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_m_impact" );

        if ( var_4 < 800 )
            level.player soundscripts\_snd_playsound::snd_play_linked( "gate_crash_m_debris" );
    }

    if ( var_3 > var_2 )
    {
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_h_lfe" );
        soundscripts\_snd_playsound::snd_play_2d( "gate_crash_h_impact" );

        if ( var_4 < 800 )
            level.player soundscripts\_snd_playsound::snd_play_linked( "gate_crash_h_debris" );
    }
}

point_source_dambs()
{
    if ( level.currentgen && !istransientloaded( "sanfran_outro_tr" ) )
        level waittill( "tff_transition_intro_to_outro" );

    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_a_fire_bed", ( 5824, 71978, 443 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_a_fire_bed", ( 5780, 72305, 443 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_a_fire_flareups", ( 5778, 72087, 443 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_a_fire_flareups", ( 5843, 72350, 443 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "sf_a_fire_flareups", ( 5727, 71849, 443 ) );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "emt_fire_roar_m_critical_01", ( 5780, 72305, 440 ), "aud_bridge_fire_clear", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "emt_fire_roar_m_critical_01", ( 5780, 72305, 440 ), "aud_bridge_fire_clear", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "emt_fire_roar_m_critical_01", ( 5780, 72305, 440 ), "aud_bridge_fire_clear", 0.3 );
    thread bridge_fire_clear();
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp", ( -3385, 71948, 546 ), "stop_bridge_flares", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp_tight", ( -3528, 71837, 547 ), "stop_bridge_flares", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp", ( -3532, 72197, 547 ), "stop_bridge_flares", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp_tight", ( -3713, 72401, 584 ), "stop_bridge_flares", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp", ( -3816, 72650, 548 ), "stop_bridge_flares", 0.3 );
    thread soundscripts\_snd_playsound::snd_play_amb_loop( "road_flare_lp_tight", ( -5230, 72069, 555 ), "stop_bridge_flares", 0.3 );
}

bridge_fire_clear()
{
    level waittill( "aud_bridge_fire_clear" );
    soundscripts\_audio_dynamic_ambi::damb_stop_preset( "sf_a_fire_bed", 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_stop_preset( "sf_a_fire_flareups", 1.0 );
}

sfa_generic_traffic_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "sfa_generic_traffic", ::generic_traffic_preset_instance_init_callback );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "gen_traffic_veh_noise_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "relative_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "noise_rel_speed_to_volume" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "noise_rel_speed_to_pitch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "distance" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "noise_distance_to_pitch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_subtle" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "doppler_to_pitch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "veh_horn_commuter", undefined, 3.0, 0 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_subtle" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "doppler_to_pitch" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_full_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avmx_set_oneshot_update_mode( 1 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_cruzin", ::condition_to_state_cruzin );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_honking", ::condition_to_state_state_honking, [ "speed", "relative_speed", "distance" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "veh_horn_commuter" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_group", "state_cruzin", "to_state_cruzin", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_cruzin", 1.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_honking", "to_state_honking" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_honking", 3.0, 100 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_cruzin", "to_state_cruzin" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "env_full_vol", [ [ 0, 1 ], [ 1, 1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "noise_rel_speed_to_volume", [ [ 0.0, 0.0 ], [ 18.0, 0.1 ], [ 36.0, 0.2 ], [ 54.0, 0.3 ], [ 72.0, 0.5 ], [ 90.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "noise_rel_speed_to_pitch", [ [ 0, 0.8 ], [ 90, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "noise_distance_to_pitch", [ [ 360, 0.8 ], [ 792, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "doppler_to_pitch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

generic_traffic_preset_instance_init_callback( var_0 )
{
    var_1 = self;
    var_2 = var_1 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    var_0.g = spawnstruct();
    var_0.g.start_time = soundscripts\_snd::snd_get_secs();
    var_0.g.start_dist = soundscripts\_audio_vehicle_manager::dist2yards( distance( var_2.origin, level.player.origin ) );
}

condition_to_state_cruzin( var_0, var_1 )
{
    return 1;
}

condition_to_state_state_honking( var_0, var_1 )
{
    if ( !isdefined( var_1.honking ) )
    {
        var_1.honking = spawnstruct();
        var_1.honking.prev_time = var_1.g.start_time;
        var_1.honking.prev_dist = var_1.g.start_dist;
    }

    var_2 = 0;
    var_3 = length( level.player getvelocity() * 0.0568182 );
    var_4 = var_0["speed"];
    var_5 = var_0["relative_speed"];
    var_6 = soundscripts\_audio_vehicle_manager::dist2yards( var_0["distance"] );
    var_7 = var_6 - var_1.honking.prev_dist < 0 && var_5 > 36.0;

    if ( isdefined( level.aud.median_crash ) )
    {
        if ( var_7 && level.aud.median_cross == 1 && var_6 < randomintrange( 10, 20 ) )
            var_2 = soundscripts\_audio::aud_percent_chance( 10 );
        else if ( var_7 && level.aud.median_cross == 2 && var_6 < randomintrange( 30, 40 ) )
            var_2 = 1;
        else if ( !var_7 && var_6 < 6 )
            var_2 = 1;
    }
    else if ( !var_7 && var_6 < 6 )
        var_2 = 1;

    var_1.honking.prev_dist = var_6;
    return var_2;
}

civilian_compact_car_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "civilian_compact_car", ::civilian_compact_car_init );
    var_0 = 0;
    var_1 = 15;
    var_2 = var_1 - var_0;
    var_3 = 0.0;
    var_4 = 1.0;
    var_5 = var_4 - var_3;
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "idle_speed_to_vol", [ [ var_0, var_4 ], [ var_1, var_3 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "drive_speed_to_vol", [ [ var_0, var_3 ], [ var_1, var_4 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "skid_speed_to_vol", [ [ 0, 0.5 ], [ 1, 0.5 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "doppler_to_pch", [ [ 0, 0 ], [ 1, 1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "start_moving_duck_env", [ [ 0.0, 0.5 ], [ 0.9, 0.5 ], [ 1.5, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sfa_car_civ_us_cmpct_idle" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "idle_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "doppler_to_pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sfa_car_civ_us_cmpct_drive_md" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "drive_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "doppler_to_pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "sfa_car_civ_us_cmpct_accel_lw", "start_moving_duck_env" );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "sfa_car_civ_us_cmpct_skid_sml" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "skid_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_moving", ::condition_to_moving );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_start_moving", ::condition_to_start_moving, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "sfa_car_civ_us_cmpct_accel_lw" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_stop_moving", ::condition_to_stop_moving, [ "speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "sfa_car_civ_us_cmpct_skid_sml" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_group", "moving", "to_moving", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "moving", 1.0, 50 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "start_moving", "to_start_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "stop_moving", "to_stop_moving" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "start_moving", 1.0, 60 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "moving", "to_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "stop_moving", "to_stop_moving" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "stop_moving", 1.0, 60 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "moving", "to_moving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "start_moving", "to_start_moving" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

civilian_compact_car_init( var_0 )
{
    var_0.start_moving = spawnstruct();
    var_0.stop_moving = spawnstruct();
    var_0.start_moving.prev_speed = 0;
    var_0.stop_moving.prev_speed = 0;
}

condition_to_moving( var_0, var_1 )
{
    return 1;
}

condition_to_start_moving( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( var_1.start_moving.prev_speed < 3 && var_1.start_moving.prev_speed < var_3 )
        var_2 = 1;

    var_1.start_moving.prev_speed = var_3;
    return var_2;
}

condition_to_stop_moving( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];

    if ( var_3 < 3 && var_3 < var_1.stop_moving.prev_speed )
        var_2 = 1;

    var_1.stop_moving.prev_speed = var_3;
    return var_2;
}

player_pitbull_woosh_sounds()
{

}

canyon_whizby_sounds( var_0, var_1 )
{
    foreach ( var_3 in [ -1, 0, 1 ] )
    {
        foreach ( var_5 in [ -1, 1 ] )
            thread canyon_whizby_sound( var_0, var_1, vectornormalize( ( var_3, var_5, 0 ) ) );
    }
}

canyon_whizby_sound( var_0, var_1, var_2 )
{
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 playloopsound( "sanfran_player_pitbull_reflection" );
    var_4 = 1500;
    var_5 = 0.1;
    var_6 = 72;
    var_7 = ( 0, 0, 48 );
    var_8 = 880.0;
    var_9 = 0.4;
    var_10 = var_4;
    var_11 = var_1.origin;

    while ( isdefined( var_1 ) && isalive( var_0 ) )
    {
        var_12 = transformmove( var_1.origin, var_1.angles, ( 0, 0, 0 ), ( 0, 0, 0 ), var_7 + var_6 * var_2, ( 0, 0, 0 ) )["origin"] + var_1 maps\_shg_utility::get_differentiated_velocity() * var_5;
        var_13 = transformmove( var_12, var_1.angles, ( 0, 0, 0 ), ( 0, 0, 0 ), var_2 * var_4, ( 0, 0, 0 ) )["origin"];
        var_14 = bullettrace( var_12, var_13, 0, var_1 );

        if ( var_14["fraction"] < 1 )
            var_3.origin = var_14["position"];

        var_15 = soundscripts\_audio_vehicle_manager::avm_compute_doppler_pitch( var_3.origin, ( 0, 0, 0 ), var_0.origin, var_0 maps\_shg_utility::get_differentiated_velocity(), 1, 1 );
        var_16 = var_9 * clamp( squared( maps\_shg_utility::get_differentiated_speed() / var_8 ), 0, 1 );
        var_3 scalepitch( var_15, 0.05 );
        var_3 setvolume( var_16, 0.05 );
        waitframe();
    }

    var_3 delete();
}
