// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    config_system();
    init_snd_flags();
    init_globals();
    create_conversation_arrays();
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
}

init_snd_flags()
{

}

init_globals()
{
    level.aud.convoactive = 0;
    level.aud.convogate = 1;
    level.aud.explosions = 1;
    level.aud.grapple_fire_plr_sound_bagh = "linelauncher_fire_player_bagh";
    level.aud.grapple_move_plr_sound_bagh = "linelauncher_move_player_bagh";
    level.aud.grapple_mantle_plr_sound_bagh = "linelauncher_plr_mantle_bagh";
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread setup_anim_receivers();
    thread setup_dnabomb_anims();
    thread setup_warbird_grapple_kill_anims();
    thread setup_mech_grapple_kill_anims();
    thread monitor_turret_exit();
    thread soundscripts\_audio_mix_manager::mm_add_submix( "master_mix" );
}

launch_loops()
{
    thread aud_background_chatter_gate();
    thread soundscripts\_audio::aud_play_line_emitter( "main_view_screen", "console_large_lp", ( -7813, 3663, -385 ), ( -7251, 3413, -396 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "main_view_screen_data", "computer_pulse_busy_lp_01", ( -7809, 3683, -501 ), ( -7246, 3423, -500 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "right_main_view_screen", "console_large_low_lp_01", ( -7203, 3387, -396 ), ( -7096, 3099, -397 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "left_main_view_screen", "console_large_low_lp_02", ( -7863, 3699, -419 ), ( -8158, 3599, -429 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "catwalk_main_view_screen", "console_large_lp", ( -8255, 1487, -414 ), ( -8673, 1681, -418 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "main_upstairs_console", "computer_idle_lp", ( -7645, 3137, -545 ), ( -7768, 3196, -552 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "small_console_01", "computer_hum_lp_01", ( -7540, 2697, -804 ), ( -7755, 2801, -806 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "small_console_02", "computer_hum_lp_02", ( -7962, 2893, -805 ), ( -8177, 2998, -805 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "small_console_03", "computer_hum_lp_03", ( -7638, 2492, -778 ), ( -7850, 2597, -782 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "small_console_04", "computer_hum_lp_01", ( -8057, 2691, -780 ), ( -8271, 2795, -781 ) );
    common_scripts\utility::loop_fx_sound( "console_medium_low_lp_01", ( -7647, 3299, -581 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_hard_drive", ( -8092, 3599, -557 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_hard_drive", ( -7538, 3531, -551 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_hard_drive", ( -7168, 3247, -556 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_hard_drive", ( -7654, 3140, -541 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_hard_drive", ( -7763, 3193, -543 ), 1 );
    thread soundscripts\_audio::aud_play_line_emitter( "server_01", "server_air_lp_01", ( -7872, 3158, -681 ), ( -7680, 3595, -700 ) );
    thread soundscripts\_audio::aud_play_line_emitter( "server_02", "server_air_lp_02", ( -7401, 3477, -700 ), ( -7605, 3035, -700 ) );
    common_scripts\utility::loop_fx_sound( "server_rattle_lp_01", ( -7543, 2989, -759 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_rattle_lp_01", ( -7894, 3329, -709 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_rattle_lp_02", ( -7814, 3114, -739 ), 1 );
    common_scripts\utility::loop_fx_sound( "server_rattle_lp_02", ( -7531, 3364, -734 ), 1 );
    common_scripts\utility::loop_fx_sound( "electric_hum_large_lp_03", ( -7422, 1758, -678 ), 1 );
    thread soundscripts\_audio::aud_play_line_emitter( "power_coils_01", "electric_hum_large_lp_02", ( -7283, 1879, -738 ), ( -7218, 2055, -743 ) );
}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["example_envelop"] = [ [ 0.0, 0.0 ], [ 0.082, 0.426 ], [ 0.238, 0.736 ], [ 0.408, 0.844 ], [ 0.756, 0.953 ], [ 1.0, 1.0 ] ];
}

create_conversation_arrays()
{
    level.aud.convos = [];
    level.aud.convos[0] = [ "df_ss2_artsupport1", "df_ss1_position1", "df_ss1_landmark1", "df_ss2_finbuilding1", "df_ss1_payloadinbound" ];
    level.aud.convos[1] = [ "df_ss3_multcontacts", "df_so_clearengage2", "df_ss3_solidcopy3", "df_so_unable2", "df_ss3_harddcopy3" ];
    level.aud.convos[2] = [ "df_ss3_positionaldata3", "df_ss4_goahead3", "df_ss3_gridsupp3", "df_ss4_proceed3" ];
    level.aud.convos[3] = [ "df_ss1_maintainpos4", "df_ss2_copyall4", "df_ss3_hardcopy4" ];
    level.aud.convos[4] = [ "df_ss1_movement6", "df_ss4_confirmation6", "df_ss4_thisapollo6", "df_ss1_goforathena6", "df_ss4_clearengage6", "df_ss1_engaging6" ];
    level.aud.convos[5] = [ "df_ss3_immstrike7", "df_jp1_proceed7", "df_ss3_mapgrid7", "df_jp1_ordinance7", "df_jp1_inair7" ];
    level.aud.convos[6] = [ "df_jp1_commencing8", "df_ss3_ceasedrops8", "df_jp1_canceldrop8", "df_ss3_cancelrun8", "df_jp1_cancelingrun8", "df_ss3_posdata8" ];
    level.aud.convos[7] = [ "df_ss4_notinbound11", "df_ss1_flankposition11", "df_ss4_out11" ];
    level.aud.convos[8] = [ "df_ss1_thisis12", "df_ss3_gofor12", "df_ss1_fortified12", "df_ss3_sitrep12", "df_ss1_wounded12" ];
    level.aud.convos[9] = [ "df_ss3_hold13", "df_ss1_copy13" ];
    level.aud.convos[10] = [ "df_ss4_approach14", "df_ss3_ceasefire14", "df_ss3_advance14", "df_ss4_moving14" ];
    level.aud.convos[11] = [ "df_ss4_sitrepd23", "df_ss1_send23", "df_ss4_howcopy23", "df_ss1_solidcopy23", "df_ss4_end23" ];
    level.aud.convos[12] = [ "df_ss4_thisis24", "df_so_send24", "df_ss4_support24" ];
}

precache_presets()
{

}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "snd_start_intro", ::snd_start_intro );
    soundscripts\_snd::snd_register_message( "snd_start_snipers", ::snd_start_snipers );
    soundscripts\_snd::snd_register_message( "snd_start_post_tower", ::snd_start_post_tower );
    soundscripts\_snd::snd_register_message( "snd_start_barracks", ::snd_start_barracks );
    soundscripts\_snd::snd_register_message( "snd_start_tank", ::snd_start_tank );
    soundscripts\_snd::snd_register_message( "snd_start_approachdna", ::snd_start_approachdna );
    soundscripts\_snd::snd_register_message( "snd_start_dnabomb", ::snd_start_dnabomb );
    soundscripts\_snd::snd_register_message( "aud_avs_intro_allies_1", ::aud_avs_intro_allies_1 );
    soundscripts\_snd::snd_register_message( "aud_avs_intro_allies_2", ::aud_avs_intro_allies_2 );
    soundscripts\_snd::snd_register_message( "aud_avs_enemy_warbird_grapple", ::aud_avs_enemy_warbird_grapple );
    soundscripts\_snd::snd_register_message( "aud_avs_enemy_warbird", ::aud_avs_enemy_warbird );
    soundscripts\_snd::snd_register_message( "aud_avs_enemy_warbird_2", ::aud_avs_enemy_warbird_2 );
    soundscripts\_snd::snd_register_message( "aud_turret_entry", ::aud_turret_entry );
    soundscripts\_snd::snd_register_message( "player_enter_walker_anim", ::player_enter_walker_anim );
    soundscripts\_snd::snd_register_message( "titan_walker_weapon_fire", ::titan_walker_weapon_fire );
    soundscripts\_snd::snd_register_message( "bollards_move", ::bollards_move );
    soundscripts\_snd::snd_register_message( "aud_enter_vtol", ::aud_enter_vtol );
    soundscripts\_snd::snd_register_message( "aud_exit_vtol", ::aud_exit_vtol );
    soundscripts\_snd::snd_register_message( "aud_dna_bomb_01", ::aud_dna_bomb_01 );
    soundscripts\_snd::snd_register_message( "aud_dna_bomb_02", ::aud_dna_bomb_02 );
    soundscripts\_snd::snd_register_message( "postdna_mech_attack", ::postdna_mech_attack );
    soundscripts\_snd::snd_register_message( "drag_scene_begin", ::drag_scene_begin );
    soundscripts\_snd::snd_register_message( "water_exp_audio", ::water_exp_audio );
    soundscripts\_snd::snd_register_message( "midair_exp_audio", ::midair_exp_audio );
    soundscripts\_snd::snd_register_message( "midair_exp_glass", ::midair_exp_glass );
    soundscripts\_snd::snd_register_message( "seo_dirt_explosions", ::seo_dirt_explosions );
    soundscripts\_snd::snd_register_message( "seo_ambient_ground_explosions", ::seo_ambient_ground_explosions );
    soundscripts\_snd::snd_register_message( "aud_start_dna_events", ::aud_start_dna_events );
}

zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {

    }
}

music_handler( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "df_baghdad_intro_and_combat":
            wait 2;
            soundscripts\_audio_music::mus_play( "mus_callto_dfbag_intro" );
            wait 44;
            soundscripts\_audio_music::mus_play( "mus_callto_dfbag_lp", 1.0 );
            break;
        case "df_baghdad_intro_end":
            soundscripts\_audio_music::mus_play( "mus_callto_dfbag_end", 1.0 );
        case "df_baghdad_barracks":
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            soundscripts\_audio_music::mus_play( "mus_df_baghdad_barracks_lp_01", 0, 3 );
            common_scripts\utility::flag_wait( "barracks_command_room_cleared" );
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            soundscripts\_audio_music::mus_play( "mus_df_baghdad_barracks_lp_02", 3, 1.25 );
            common_scripts\utility::flag_wait( "flag_barracks_player_escape" );
            soundscripts\_audio::aud_set_music_submix( 0.7 );
            soundscripts\_audio_music::mus_play( "mus_df_baghdad_barracks_end" );
            break;
        case "df_baghdad_bridge":
            soundscripts\_audio_music::mus_stop( 3 );
            break;
        case "df_mech_combat":
            soundscripts\_audio_music::mus_play( "mus_callto_dfbag_end", 1.0 );
            wait 20;
            soundscripts\_audio_music::mus_play( "mus_dfb_mech_combat_begin" );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

snd_start_intro()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
    thread pod_intro_mix();
}

snd_start_snipers()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
}

snd_start_post_tower()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
}

snd_start_barracks()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
}

snd_start_tank()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
}

snd_start_approachdna()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    level.aud.convoactive = 1;
}

snd_start_dnabomb()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war", 1.0 );
    soundscripts\_audio_music::mus_play( "mus_dfb_mech_combat_begin" );
}

setup_anim_receivers()
{
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_pod_scene_begin", ::aud_pod_scene_begin, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_pod_turbulence_01", ::aud_pod_turbulence_01, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_pod_turbulence_02", ::aud_pod_turbulence_02, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_pod_arm_reach", ::aud_pod_arm_reach, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "aud_pod_hits_ground", ::aud_pod_hits_ground, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "pod_goes_flying", ::pod_goes_flying, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "pod_get_up", ::pod_get_up, "intro_pod_scene" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "bagh_start_turretpull_mix", ::bagh_start_turretpull_mix, "roof_kill" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "bagh_end_turretpull_mix", ::bagh_end_turretpull_mix, "roof_kill" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "punch_turret", ::bagh_punch_turret, "roof_kill" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "grab_gunner", ::bagh_grab_gunner, "roof_kill" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "throw_gunner", ::bagh_throw_gunner, "roof_kill" );
}

setup_dnabomb_anims()
{
    maps\_anim::addnotetrack_customfunction( "ilona", "iln_sprint_to_knox", ::iln_sprint_to_knox, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilona", "iln_kneel_down", ::iln_kneel_down, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilona", "iln_get_up", ::iln_get_up, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilona", "iln_flip_over", ::iln_flip_over, "drag_humans" );
    maps\_anim::addnotetrack_customfunction( "ilona", "iln_dragged_away", ::iln_dragged_away, "drag_humans" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gid_kneel_down", ::gid_kneel_down, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gid_hand_on_knox", ::gid_hand_on_knox, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gid_stand_and_drag", ::gid_stand_and_drag, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gid_fall_down", ::gid_fall_down, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "gideon", "gid_dragged_away", ::gid_dragged_away, "drag_humans" );
    maps\_anim::addnotetrack_customfunction( "ilana", "aud_dogfight_finale_knoxdeath_knox_start", ::knox_death_start, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilana", "knox_hand_grab", ::knox_hand_grab, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilana", "knox_arm_jerk", ::knox_arm_jerk, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "ilana", "knox_go_limp", ::knox_go_limp, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "plr_fall_over", ::plr_fall_over, "vtol_crash" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "plr_dragged_away", ::plr_dragged_away, "drag_player" );
    maps\_anim::addnotetrack_customfunction( "drag_enemy1", "grd_trunk_close", ::grd_trunk_close, "drag_humans" );
    maps\_anim::addnotetrack_customfunction( "drag_enemy1", "grd_player_grab", ::grd_player_grab, "drag_humans" );
}

setup_warbird_grapple_kill_anims()
{
    maps\_anim::addnotetrack_customfunction( "player_rig", "start", ::grapple_pullout_r, "grapple_pullout_r" );
    maps\_anim::addnotetrack_customfunction( "player_rig", "start", ::grapple_pullout_l, "grapple_pullout_l" );
}

setup_mech_grapple_kill_anims()
{
    maps\_anim::addnotetrack_customfunction( "mech_grapple_player", "aud_mechkill_smashy", ::mech_grapple_kill_success, "success_end" );
}

midair_exp_audio( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", var_0 );
}

seo_dirt_explosions( var_0, var_1 )
{
    if ( level.aud.explosions == 1 )
    {
        var_2 = soundscripts\_snd_playsound::snd_play_at( "exp_generic_incoming", var_0 );
        var_2 waittill( "sounddone" );
        level notify( var_1 );
        var_3 = var_0;
        var_4 = spawnstruct();
        var_4.pos = var_3;
        var_4.speed_of_sound_ = 1;
        var_4.duck_alias_ = "exp_generic_explo_sub_kick";
        var_4.duck_dist_threshold_ = 1000;
        var_4.explo_delay_chance_ = 40;
        var_4.explo_tail_alias_ = "exp_generic_explo_tail";
        var_4.shake_dist_threshold_ = 1800;
        var_4.explo_debris_alias_ = "exp_debris_mixed";
        var_4.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
        var_4.ground_zero_dist_threshold_ = 500;
        soundscripts\_snd_common::snd_ambient_explosion( var_4 );
    }
    else
    {

    }
}

water_exp_audio( var_0 )
{
    var_1 = var_0;
    var_2 = spawnstruct();
    var_2.pos = var_1;
    var_2.speed_of_sound_ = 1;
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1000;
    var_2.explo_tail_alias_ = "exp_generic_explo_tail";
    var_2.shake_dist_threshold_ = 1000;
    var_2.explo_debris_alias_ = "exp_fireball";
    var_2.ground_zero_alias_ = "exp_ground_zero";
    var_2.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
}

seo_ambient_ground_explosions( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_structure", var_0 );
}

midair_exp_glass( var_0 )
{
    var_1 = var_0;
    var_2 = spawnstruct();
    var_2.pos = var_1;
    var_2.speed_of_sound_ = 1;
    var_2.duck_alias_ = "exp_generic_explo_sub_kick";
    var_2.duck_dist_threshold_ = 1000;
    var_2.explo_tail_alias_ = "exp_generic_explo_tail";
    var_2.shake_dist_threshold_ = 500;
    var_2.explo_debris_alias_ = "exp_debris_glass";
    var_2.ground_zero_alias_ = "exp_debris_structure_collapse";
    var_2.ground_zero_dist_threshold_ = 1000;
    soundscripts\_snd_common::snd_ambient_explosion( var_2 );
}

pod_intro_mix()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "mute_all" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "mute_all", 0.75 );
}

aud_pod_scene_begin( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_pod_amb" );
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_intro_scene" );
    wait 0.5;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_explos_01" );
}

aud_pod_turbulence_01( var_0 )
{
    if ( level.nextgen )
        thread soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_shot_06", ( -10168, 9208, -216 ) );
    else
        thread soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_shot_07", ( -10168, 9208, -216 ) );
}

aud_pod_turbulence_02( var_0 )
{
    if ( level.nextgen )
        soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_shot_08", ( -11921, 6744, 369 ) );
    else
        soundscripts\_snd_playsound::snd_play_at( "exp_generic_explo_shot_10", ( -11921, 6744, 369 ) );
}

aud_pod_arm_reach( var_0 )
{
    wait 0.1333;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_arm_reach" );
    wait 0.9333;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_pod_alert" );
    wait 0.7;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_canopy_open" );
    thread aud_pod_hits_ground_corrected();
}

aud_pod_hits_ground_corrected()
{
    wait 0.7333;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_pod_hits_ground" );
}

aud_pod_hits_ground( var_0 )
{
    wait 2.1333;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_pod_flying" );
    wait 2.3666;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_intro_scene", 1.0 );
}

pod_goes_flying( var_0 )
{
    wait 0.2666;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_pergola_smash" );
    thread pod_get_up_corrected();
}

pod_get_up_corrected()
{
    wait 2.6;
    thread soundscripts\_snd_playsound::snd_play_2d( "intro_plr_get_up" );
    wait 2;
    soundscripts\_snd::snd_music_message( "df_baghdad_intro_and_combat" );
}

pod_get_up( var_0 )
{

}

bagh_start_turretpull_mix( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_turret_kill" );
}

bagh_punch_turret( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "turret_kill_rip" );
    soundscripts\_snd_playsound::snd_play_2d( "turret_kill_impact" );
}

bagh_grab_gunner( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "turret_kill_grab" );
}

bagh_throw_gunner( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "turret_kill_throw" );
    wait 0.65;
    soundscripts\_snd_playsound::snd_play_2d( "grapple_kill_falling_scream" );
}

bagh_end_turretpull_mix( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_turret_kill", 1 );
}

aud_avs_intro_allies_1( var_0 )
{
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "warbird_field_spawn_1st", 3.85 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fus_intro_warbird_b_decloak", 7 );
    wait 8;
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2[0] = 2000;
    var_0 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, undefined, var_2, undefined, 1, undefined, "warbird_death_explo" );
    var_3 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp" );
    var_4 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp" );
    var_5 = spawn( "script_origin", var_0.origin );
    var_5 _meth_804D( var_0 );
    var_0 waittill( "death" );
    var_3 aud_stop_and_delete_ent();
    var_4 aud_stop_and_delete_ent();
    var_5 soundscripts\_snd_playsound::snd_play_loop( "warbird_death_spin_loop" );
    wait 8.5;
    var_5 aud_stop_and_delete_ent();
}

aud_avs_intro_allies_2( var_0 )
{
    var_0 _meth_828B();
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "warbird_field_spawn_2nd", 5.7 );
    wait 10;
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2[0] = 2000;
    var_0 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, undefined, var_2, undefined, 1, "warbird_death_spin", "warbird_death_explo" );
    var_3 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp" );
    var_4 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp" );
    var_0 waittill( "death" );
    var_3 aud_stop_and_delete_ent();
    var_4 aud_stop_and_delete_ent();
}

aud_avs_enemy_warbird_grapple( var_0 )
{
    var_0 _meth_828B();
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2["warbird_field_spawn_1st"] = 3.266;
    var_2["warbird_field_spawn_2nd"] = 5;
    var_3 = [];
    var_3[0] = 1400;
    var_3[1] = 2000;
    var_3[2] = 2500;
    var_4 = [];
    var_4[0] = 40;
    var_0 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, var_4, 1, undefined, "warbird_death_explo" );
    var_5 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp" );
    var_6 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp" );
    var_7 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_interior_lp" );
    var_0 thread enemy_warbird_deathspin_listener( var_5, var_6, var_7 );
}

aud_avs_enemy_warbird( var_0 )
{
    var_0 _meth_828B();
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2["warbird_field_spawn_1st"] = 0.266;
    var_2["warbird_field_spawn_2nd"] = 16.096;
    var_3 = [];
    var_3[0] = 1400;
    var_3[1] = 2000;
    var_3[2] = 2500;
    var_4 = [];
    var_4[0] = 40;
    var_0 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, var_4, 1, "warbird_death_spin", "warbird_death_explo" );
    var_5 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp" );
    var_6 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp" );
}

aud_avs_enemy_warbird_2( var_0 )
{
    var_0 _meth_828B();
    var_1 = "warbird_field_flyby";
    var_2 = [];
    var_2["warbird_field_spawn_1st"] = 0.266;
    var_2["warbird_field_spawn_2nd"] = 16.096;
    var_3 = [];
    var_3[0] = 1400;
    var_3[1] = 2000;
    var_3[2] = 2500;
    var_4 = [];
    var_4[0] = 40;
    var_0 thread soundscripts\_snd_common::snd_advanced_flyby_system( var_1, var_2, var_3, var_4, 1, "warbird_death_spin", "warbird_death_explo" );
    var_5 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_chop_lp" );
    var_6 = var_0 soundscripts\_snd_playsound::snd_play_loop_linked( "fus_warbird_plr_blades_lp" );
}

enemy_warbird_deathspin_listener( var_0, var_1, var_2 )
{
    self waittill( "deathspin" );
    var_3 = spawn( "script_origin", self.origin );
    var_3 _meth_804D( self );
    var_0 aud_stop_and_delete_ent();
    var_1 aud_stop_and_delete_ent();
    var_4 = soundscripts\_snd_playsound::snd_play_loop_linked( "warbird_death_spin_loop" );
    wait 8.1;
    var_3 soundscripts\_snd_playsound::snd_play_linked( "warbird_generic_explo_shot_2" );
    var_4 aud_stop_and_delete_ent();
    var_2 aud_stop_and_delete_ent();
    wait 4;
    var_3 aud_stop_and_delete_ent();
}

aud_stop_and_delete_ent()
{
    soundscripts\_snd_playsound::snd_stop_sound();

    if ( isdefined( self ) )
        self delete();
}

player_enter_walker_anim()
{
    soundscripts\_snd_playsound::snd_play_2d( "turret_kill_climb" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "turret_kill", 3.25 );
}

grapple_pullout_r( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "warbird_grapple_kill_right" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "grapple_kill_falling_scream", 1.25 );
    wait 0.45;
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_warbird_grapple_kill", 0 );
    wait 0.95;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_warbird_grapple_kill", 0.3 );
}

grapple_pullout_l( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "warbird_grapple_kill_left" );
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_warbird_grapple_kill", 0.2 );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_warbird_grapple_kill", 1 );
}

mech_grapple_kill_success( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "bagh_mechkill_smashy" );
}

titan_walker_weapon_fire()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "walker_cannon_shot" );
}

bollards_move()
{
    soundscripts\_snd_playsound::snd_play_at( "bagh_bollards_front", ( -9432, 456, -477 ) );
    soundscripts\_snd_playsound::snd_play_at( "bagh_bollards_rear", ( -9139, 1088, -691 ) );
    soundscripts\_snd_playsound::snd_play_at( "bagh_bollards_front", ( -8706, 130, -477 ) );
    soundscripts\_snd_playsound::snd_play_at( "bagh_bollards_rear", ( -8409, 760, -700 ) );
}

aud_enter_vtol()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_int_warbird" );
}

aud_exit_vtol()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "baghdad_ext_war" );
}

aud_dna_bomb_01()
{
    level.aud.convoactive = 0;
    wait 4;
}

aud_dna_bomb_02()
{
    wait 4;
}

aud_start_dna_events()
{
    common_scripts\utility::flag_wait( "pvtol_crashed" );

    if ( level.currentgen && !_func_21E( "df_baghdad_outro_tr" ) )
        thread aud_start_dna_events_cg();

    if ( level.nextgen )
        thread grab_stinger();

    level.aud.explosions = 0;
    soundscripts\_audio_music::mus_stop( 6 );
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_dna_drones", 3 );
    thread soundscripts\_snd_playsound::snd_play_2d( "bagh_dna_drone_swarm_layer", "fade_out_swarm_sounds", undefined, 1.5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_2d( "bagh_dna_drone_flyby_01", 5.66, undefined, "fade_out_swarm_sounds", undefined, 1.5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_2d( "bagh_dna_drone_overhead_front", 8.46, undefined, "fade_out_swarm_sounds", undefined, 1.5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_2d( "bagh_dna_drone_overhead_rear", 8.7, undefined, "fade_out_swarm_sounds", undefined, 1.5 );
    thread soundscripts\_snd_playsound::snd_play_delayed_2d( "bagh_dna_drone_flyby_02", 8.95, undefined, "fade_out_swarm_sounds", undefined, 1.5 );
    wait 11.95;
    level notify( "fade_out_swarm_sounds" );

    if ( level.nextgen )
    {
        wait 0.5;
        thread soundscripts\_snd_playsound::snd_play_2d( "bagh_dna_bombs_main" );
    }

    thread soundscripts\_snd_playsound::snd_play_2d( "dna_bomb_gas_start" );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_dna_drones", 0.5 );
}

aud_start_dna_events_cg()
{
    level waittill( "tff_post_middle_to_outro" );
    thread grab_stinger();
    wait 10.96;
    wait 0.7;
    thread soundscripts\_snd_playsound::snd_play_2d( "bagh_dna_bombs_main" );
}

grab_stinger()
{
    soundscripts\_snd_playsound::snd_play_2d( "grab_stinger" );
}

knox_death_start( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_knox_death", 1 );
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_bomb_gas_end" );
    wait 2.2;
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_player_to_knox" );
}

knox_hand_grab( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_knox_grab_gid" );
}

knox_arm_jerk( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_knox_grab_player" );
}

knox_go_limp( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_knox_go_limp" );
}

gid_kneel_down( var_0 )
{

}

gid_hand_on_knox( var_0 )
{
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_knox_death", 2 );
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_knox_post_death", 2 );
}

gid_stand_and_drag( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_iln_up_gid_drag_knox" );
}

iln_sprint_to_knox( var_0 )
{
    wait 0.4;
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_iln_and_gid_to_knox" );
}

iln_kneel_down( var_0 )
{

}

iln_get_up( var_0 )
{

}

postdna_mech_attack( var_0 )
{
    wait 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_dna_aftermath", 0.5 );
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_player_down_transition" );
    wait 16.25;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_dna_aftermath", 0.5 );
}

gid_fall_down( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_gid_fall_down" );
}

drag_scene_begin()
{
    wait 1.5;
    soundscripts\_audio_music::mus_play( "mus_df_baghdad_end", 0, 1 );
}

gid_dragged_away( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_walk_to_iln" );
}

iln_flip_over( var_0 )
{
    wait 0.5;
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_flip_iln_over" );
    wait 1.5;
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_drag_iln_away" );
}

iln_dragged_away( var_0 )
{
    wait 4.0;
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_drag_gid_to_vehicle" );
}

plr_fall_over( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_bomb_player_react" );
    soundscripts\_audio_music::mus_play( "mus_df_baghdad_knox_death", 0, 1 );
}

plr_dragged_away( var_0 )
{

}

grd_trunk_close( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_tailgate_open" );
}

grd_player_grab( var_0 )
{
    thread soundscripts\_snd_playsound::snd_play_2d( "dna_enemy_grab_player" );
    wait 3.1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "df_baghdad_dna_aftermath" );
    soundscripts\_audio_mix_manager::mm_add_submix( "df_baghdad_dna_end", 0.5 );
}

aud_background_chatter_gate()
{
    if ( level.aud.convogate == 1 )
    {
        thread aud_background_chatter();
        level.aud.convogate = 0;
    }
    else
    {

    }
}

aud_turret_entry()
{
    soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_enter" );
}

monitor_turret_exit()
{
    for (;;)
    {
        level.player waittill( "dismount_vehicle_and_turret" );
        soundscripts\_snd_playsound::snd_play_2d( "x4walker_player_exit" );
    }
}

aud_background_chatter()
{
    wait 5;

    while ( level.aud.convoactive == 1 )
    {
        var_0 = randomint( 12 );
        var_1 = level.aud.convos[var_0];

        foreach ( var_3 in var_1 )
        {
            if ( level.aud.convoactive == 1 )
            {
                var_4 = soundscripts\_snd_playsound::snd_play_2d( var_3 );

                if ( !isdefined( var_4 ) )
                    continue;

                var_4 waittill( "sounddone" );
                wait(randomfloatrange( 1.0, 3.5 ));
                continue;
            }
        }
    }
}
