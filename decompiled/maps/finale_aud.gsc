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
    init_notetracks();
}

register_snd_messages()
{
    soundscripts\_snd::snd_register_message( "snd_zone_handler", ::zone_handler );
    soundscripts\_snd::snd_register_message( "snd_music_handler", ::music_handler );
    soundscripts\_snd::snd_register_message( "enter_water_override", ::enter_water_override );
    soundscripts\_snd::snd_register_message( "exit_water_override", ::exit_water_override );
    soundscripts\_snd::snd_register_message( "start_intro", ::start_intro );
    soundscripts\_snd::snd_register_message( "start_intro_skip", ::start_intro_skip );
    soundscripts\_snd::snd_register_message( "start_canal", ::start_canal );
    soundscripts\_snd::snd_register_message( "start_silo_approach", ::start_silo_approach );
    soundscripts\_snd::snd_register_message( "start_silo_floor_03", ::start_silo_floor_03 );
    soundscripts\_snd::snd_register_message( "start_door_kick", ::start_door_kick );
    soundscripts\_snd::snd_register_message( "start_silo_exhaust_entrance", ::start_silo_exhaust_entrance );
    soundscripts\_snd::snd_register_message( "start_lobby", ::start_lobby );
    soundscripts\_snd::snd_register_message( "start_sky_bridge", ::start_sky_bridge );
    soundscripts\_snd::snd_register_message( "start_will_room", ::start_will_room );
    soundscripts\_snd::snd_register_message( "start_irons_chase", ::start_irons_chase );
    soundscripts\_snd::snd_register_message( "start_roof", ::start_roof );
    soundscripts\_snd::snd_register_message( "fin_flyin_start", ::fin_flyin_start );
    soundscripts\_snd::snd_register_message( "fin_flyin_drop", ::fin_flyin_drop );
    soundscripts\_snd::snd_register_message( "fin_flyin_splash", ::fin_flyin_splash );
    soundscripts\_snd::snd_register_message( "fin_flyin_gideon_splash", ::fin_flyin_gideon_splash );
    soundscripts\_snd::snd_register_message( "find_npc_dive_boat_handler", ::find_npc_dive_boat_handler );
    soundscripts\_snd::snd_register_message( "fin_midair_exp_audio", ::fin_midair_exp_audio );
    soundscripts\_snd::snd_register_message( "fin_bldg_exp_audio", ::fin_bldg_exp_audio );
    soundscripts\_snd::snd_register_message( "fin_water_exp_audio", ::fin_water_exp_audio );
    soundscripts\_snd::snd_register_message( "fin_glass_exp_audio", ::fin_glass_exp_audio );
    soundscripts\_snd::snd_register_message( "vrap_explode", ::vrap_explode );
    soundscripts\_snd::snd_register_message( "fin_bullet_trails", ::fin_bullet_trails );
    soundscripts\_snd::snd_register_message( "fin_gid_exit_water", ::fin_gid_exit_water );
    soundscripts\_snd::snd_register_message( "silo_door_kick", ::silo_door_kick );
    soundscripts\_snd::snd_register_message( "shaft_descent_start", ::shaft_descent_start );
    soundscripts\_snd::snd_register_message( "shaft_descent_state_change", ::shaft_descent_state_change );
    soundscripts\_snd::snd_register_message( "shaft_descent_speed_update", ::shaft_descent_speed_update );
    soundscripts\_snd::snd_register_message( "shaft_descent_end", ::shaft_descent_end );
    soundscripts\_snd::snd_register_message( "exhaust_shaft_land", ::exhaust_shaft_land );
    soundscripts\_snd::snd_register_message( "exhaust_shaft_land_gideon", ::exhaust_shaft_land_gideon );
    soundscripts\_snd::snd_register_message( "aud_rocket_launch_start", ::aud_rocket_launch_start );
    soundscripts\_snd::snd_register_message( "aud_fin_rocket_damage_vfx", ::aud_fin_rocket_damage_vfx );
    soundscripts\_snd::snd_register_message( "fin_silo_success", ::fin_silo_success );
    soundscripts\_snd::snd_register_message( "missile_small_thrusters_off", ::missile_small_thrusters_off );
    soundscripts\_snd::snd_register_message( "missile_large_thrusters_off", ::missile_large_thrusters_off );
    soundscripts\_snd::snd_register_message( "gid_release_plr_mech_suit", ::gid_release_plr_mech_suit );
    soundscripts\_snd::snd_register_message( "fin_lobby_gun_limp", ::fin_lobby_gun_limp );
    soundscripts\_snd::snd_register_message( "aud_irons_says_hello", ::aud_irons_says_hello );
    soundscripts\_snd::snd_register_message( "aud_irons_reveal_star_trek_door", ::aud_irons_reveal_star_trek_door );
    soundscripts\_snd::snd_register_message( "aud_irons_reveal_bomb_shake", ::aud_irons_reveal_bomb_shake );
    soundscripts\_snd::snd_register_message( "fin_irons_reveal_mash_start", ::fin_irons_reveal_mash_start );
    soundscripts\_snd::snd_register_message( "fin_irons_reveal_mash", ::fin_irons_reveal_mash );
    soundscripts\_snd::snd_register_message( "fin_irons_reveal_mash_finish", ::fin_irons_reveal_mash_finish );
    soundscripts\_snd::snd_register_message( "aud_irons_reveal_bomb_shake_02", ::aud_irons_reveal_bomb_shake_02 );
    soundscripts\_snd::snd_register_message( "irons_reveal_exit_door_open", ::irons_reveal_exit_door_open );
    soundscripts\_snd::snd_register_message( "irons_keypad_door_open", ::irons_keypad_door_open );
    soundscripts\_snd::snd_register_message( "irons_chase_door_close", ::irons_chase_door_close );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_pre_shake", ::aud_fin_ending_pre_shake );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_shake_01", ::aud_fin_ending_shake_01 );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_shake_02", ::aud_fin_ending_shake_02 );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_rooftop_shake", ::aud_fin_ending_rooftop_shake );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_roof_explosion", ::aud_fin_ending_roof_explosion );
    soundscripts\_snd::snd_register_message( "fin_skybridge_takedown_start", ::fin_skybridge_takedown_start );
    soundscripts\_snd::snd_register_message( "fin_skybridge_slo_mo_start", ::fin_skybridge_slo_mo_start );
    soundscripts\_snd::snd_register_message( "fin_skybridge_slo_mo_stop", ::fin_skybridge_slo_mo_stop );
    soundscripts\_snd::snd_register_message( "fin_skybridge_takedown_guy_fall", ::fin_skybridge_takedown_guy_fall );
    soundscripts\_snd::snd_register_message( "fin_skybridge_incoming_initial", ::fin_skybridge_incoming_initial );
    soundscripts\_snd::snd_register_message( "fin_skybridge_incoming", ::fin_skybridge_incoming );
    soundscripts\_snd::snd_register_message( "fin_skybridge_glass_explo", ::fin_skybridge_glass_explo );
    soundscripts\_snd::snd_register_message( "fin_irons_takedown_start", ::fin_irons_takedown_start );
    soundscripts\_snd::snd_register_message( "fin_irons_tackle", ::fin_irons_tackle );
    soundscripts\_snd::snd_register_message( "fin_ending_slo_mo_override", ::fin_ending_slo_mo_override );
    soundscripts\_snd::snd_register_message( "bridge_takedown_success", ::bridge_takedown_success );
    soundscripts\_snd::snd_register_message( "bridge_takedown_fail", ::bridge_takedown_fail );
    soundscripts\_snd::snd_register_message( "finale_qte_show_knife", ::finale_qte_show_knife );
    soundscripts\_snd::snd_register_message( "finale_ending_qte1_success", ::finale_ending_qte1_success );
    soundscripts\_snd::snd_register_message( "finale_ending_qte1_timeout", ::finale_ending_qte1_timeout );
    soundscripts\_snd::snd_register_message( "finale_ending_buttonmash_start", ::finale_ending_buttonmash_start );
    soundscripts\_snd::snd_register_message( "finale_ending_buttonmash_fail", ::finale_ending_buttonmash_fail );
    soundscripts\_snd::snd_register_message( "finale_ending_qte2_success", ::finale_ending_qte2_success );
    soundscripts\_snd::snd_register_message( "finale_ending_qte2_timeout", ::finale_ending_qte2_timeout );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_last_rpg_01", ::aud_fin_ending_last_rpg_01 );
    soundscripts\_snd::snd_register_message( "aud_fin_ending_last_rpg_02", ::aud_fin_ending_last_rpg_02 );
}

init_notetracks()
{
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_fin_gideon_hatch_grab", ::slate_fin_gideon_hatch_grab, "exhaust_hatch_enter" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_pull_1", ::slate_finale_gideon_hatch_pull_1, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_regrip_1", ::slate_finale_gideon_hatch_regrip_1, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_pull_2", ::slate_finale_gideon_hatch_pull_2, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_regrip_2", ::slate_finale_gideon_hatch_regrip_2, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_pull_3", ::slate_finale_gideon_hatch_pull_3, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_finale_gideon_hatch_regrip_3", ::slate_finale_gideon_hatch_regrip_3, "exhaust_hatch_idle_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_gideon_wave_hand_raise", ::slate_gideon_wave_hand_raise, "exhaust_hatch_idle_wave_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_gideon_wave_hand_plant", ::slate_gideon_wave_hand_plant, "exhaust_hatch_idle_wave_noloop" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_gideon_wave_hand_regrip", ::slate_gideon_wave_hand_regrip, "exhaust_hatch_idle_wave_noloop" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "slate_fin_vm_hatch_grab", ::slate_fin_vm_hatch_grab, "exhaust_hatch_vm_approach" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "slate_fin_vm_hatch_pull", ::slate_fin_vm_hatch_pull, "exhaust_hatch_vm_noinput_to_input" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "slate_fin_vm_hatch_pull_loop", ::slate_fin_vm_hatch_pull_loop, "exhaust_hatch_vm_idle_input" );
    maps\_anim::addnotetrack_customfunction( "world_body_mech", "slate_fin_vm_pull_relax", ::slate_fin_vm_pull_relax, "exhaust_hatch_vm_input_to_noinput" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_fin_gideon_bar_break", ::slate_fin_gideon_bar_break, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_fin_vm_bar_break", ::slate_fin_vm_bar_break, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_fin_gideon_hatch_open", ::slate_fin_gideon_hatch_open, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "gideon_mech", "slate_fin_gideon_hatch_push", ::slate_fin_gideon_hatch_push, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "piston_r", "slate_fin_piston_r_break", ::slate_fin_piston_r_break, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "piston_l", "slate_fin_piston_l_break", ::slate_fin_piston_l_break, "exhaust_hatch_open" );
    maps\_anim::addnotetrack_customfunction( "missile_main", "fin_silo_fail_launch", ::fin_silo_fail_launch, "missile_launch" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_post_silo_gid_foley", ::fin_post_silo_gid_foley, "mech_exit" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_post_silo_switch_to_plr", ::fin_post_silo_switch_to_plr, "mech_exit" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_pickup_1", ::fin_gid_carry_pickup_1, "drag_pickup01" );
    maps\_anim::addnotetrack_customfunction( "plr", "fin_silo_plr_picked_up", ::fin_silo_plr_picked_up, "drag_pickup01" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_plr_1", ::fin_gid_carry_plr_1, "drag_run01" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_plr_2", ::fin_gid_carry_plr_2, "drag_run02" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fin_gid_plr_putdown", ::fin_gid_plr_putdown, "drag_putdown" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_pickup_2", ::fin_gid_carry_pickup_2, "drag_pickup02" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_plr_3", ::fin_gid_carry_plr_3, "drag_run03" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_gid_carry_plr_4", ::fin_gid_carry_plr_4, "drag_run04" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fin_irons_reveal_plr_start", ::fin_irons_reveal_plr_start, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged", "fin_irons_reveal_plr_stand", ::fin_irons_reveal_plr_stand, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "fin_irons_reveal_irons_start", ::fin_irons_reveal_irons_start, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "fin_irons_reveal_irons_takes_gun", ::fin_irons_reveal_irons_takes_gun, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "fin_irons_reveal_irons_quake", ::fin_irons_reveal_irons_quake, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "fin_irons_reveal_irons_points_gun", ::fin_irons_reveal_irons_points_gun, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "irons", "fin_irons_reveal_gun_away_exit", ::fin_irons_reveal_gun_away_exit, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_reveal_gid_drops_plr", ::fin_reveal_gid_drops_plr, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_irons_reveal_scene_gid_start", ::fin_irons_reveal_scene_gid_start, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_irons_reveal_scene_gid_exo_freeze", ::fin_irons_reveal_scene_gid_exo_freeze, "irons_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fin_ending_qte_stab", ::fin_ending_qte_stab, "balcony_finale_pt5" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fin_ending_knife_drop", ::fin_ending_knife_drop, "balcony_finale_pt5" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fin_ending_plr_foley_1", ::fin_ending_plr_foley_1, "balcony_finale_end" );
    maps\_anim::addnotetrack_customfunction( "world_body_damaged_no_exo", "fin_ending_plr_foley_2", ::fin_ending_plr_foley_2, "balcony_finale_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_ending_gideon_foley_1", ::fin_ending_gideon_foley_1, "balcony_finale_end" );
    maps\_anim::addnotetrack_customfunction( "gideon", "fin_ending_gideon_foley_2", ::fin_ending_gideon_foley_2, "balcony_finale_end" );
}

config_system()
{
    soundscripts\_audio::set_stringtable_mapname( "shg" );
    soundscripts\_snd_filters::snd_set_occlusion( "med_occlusion" );
    soundscripts\_audio_mix_manager::mm_add_submix( "finale_global_mix" );
    soundscripts\_audio_mix_manager::mm_add_submix( "temp_vo_premix" );
}

init_snd_flags()
{

}

init_globals()
{
    level.aud.water = spawnstruct();
    level.aud.water.enter_water_override = "enter_water_override";
    level.aud.water.exit_water_override = "exit_water_override";
    level.aud.underwater = 0;
}

launch_threads()
{
    if ( soundscripts\_audio::aud_is_specops() )
        return;

    thread aud_rocket_stage_01_start();
}

launch_loops()
{

}

create_level_envelop_arrays()
{
    level.aud.envs = [];
    level.aud.envs["speed_to_volume"] = [ [ 0.0, 0.1 ], [ 200.0, 0.2 ], [ 400.0, 0.5 ], [ 600.0, 0.75 ], [ 800.0, 0.8 ], [ 1000.0, 0.9 ], [ 1100.0, 1.0 ] ];
}

precache_presets()
{

}

zone_handler( var_0, var_1 )
{
    switch ( var_0 )
    {

    }
}

music( var_0, var_1 )
{
    thread music_handler( var_0, var_1 );
}

music_handler( var_0, var_1 )
{
    switch ( var_0 )
    {
        case "mitchell_vo_intro":
            soundscripts\_audio::aud_set_music_submix( 0.9, 0 );
            soundscripts\_audio_music::mus_play( "mus_mitchell_vo_intro", 0 );
            break;
        case "game_play_begin":
            soundscripts\_audio::aud_set_music_submix( 0.85, 0 );
            soundscripts\_audio_music::mus_play( "mus_game_play_begin", 0 );
            break;
        case "weapons_free":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_weapons_free", 3 );
            break;
        case "underwater_begin":
            soundscripts\_audio_music::mus_stop( 0.5 );
            break;
        case "underwater_end":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_underwater_end", 0 );
            break;
        case "post_underwater_combat_begin":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_weapons_free", 3 );
            break;
        case "post_underwater_combat_end":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_post_underwater_combat_end", 0, 1 );
            break;
        case "timer_begin":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_timer_begin", 0, 6 );
            break;
        case "ast_combat_begin":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            level.aud.ast_mus_on = 0;
            level endon( "dofpart5" );

            for (;;)
            {
                var_2 = soundscripts\_snd_common::snd_get_num_enemies_aware();

                if ( var_2 && !level.aud.ast_mus_on )
                {
                    soundscripts\_audio_music::mus_play( "mus_ast_combat_begin", 1, 2 );
                    level.aud.ast_mus_on = 1;
                }
                else if ( !var_2 && level.aud.ast_mus_on )
                {
                    soundscripts\_audio_music::mus_play( "mus_ast_combat_end", 0, 1 );
                    level.aud.ast_mus_on = 0;
                }

                wait 1;
            }

            break;
        case "ast_combat_end":
            if ( !isdefined( level.aud.ast_mus_on ) )
                level.aud.ast_mus_on = 0;

            if ( level.aud.ast_mus_on )
                soundscripts\_audio_music::mus_play( "mus_ast_combat_end", 0, 1 );
            else
                soundscripts\_audio_music::mus_stop( 3 );

            break;
        case "post_door_kick":
            soundscripts\_audio::aud_set_music_submix( 0.0, 0 );
            wait 0.1;
            soundscripts\_audio_music::mus_play( "mus_post_door_kick", 3 );
            soundscripts\_audio::aud_set_music_submix( 0.25, 10 );
            break;
        case "hatch_scene_begin":
            soundscripts\_audio::aud_set_music_submix( 0.25, 0 );
            soundscripts\_audio_music::mus_play( "mus_hatch_scene_begin", 3 );
            break;
        case "hatch_jump_begin":
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "hatch_jump_end":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            wait 0.5;
            soundscripts\_audio_music::mus_play( "mus_hatch_jump_end", 0 );
            break;
        case "missile_disabled":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_dazed_and_confused2", 0 );
            break;
        case "mitchellhangon":
            soundscripts\_audio_music::mus_stop( 5 );
            break;
        case "dazed_and_confused1":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_dazed_and_confused1", 0 );
            break;
        case "lobby_combat_begin":
            soundscripts\_audio_music::mus_play( "mus_hatch_scene_begin", 4 );
            break;
        case "dazed_and_confused2":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_dazed_and_confused2", 3 );
            break;
        case "gideon_sets_mitchell_down":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_gideon_sets_mitchell_down", 3 );
            break;
        case "fin_irs_hellomitchell":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_irons_enters", 4 );
            wait 35;
            soundscripts\_audio_music::mus_play( "mus_gideon_sets_mitchell_down", 3 );
            level waittill( "sounddone_fin_gdn_theresnotime" );
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_irons_chase_being", 3 );
            break;
        case "irons_chase_being_checkpoint":
            soundscripts\_audio::aud_set_music_submix( 1.0, 0 );
            soundscripts\_audio_music::mus_play( "mus_irons_chase_being", 3 );
            break;
        case "irons_tackle":
            soundscripts\_audio::aud_set_music_submix( 0.4, 7 );
            level waittill( "sounddone_fin_irs_aaahhhhmitchell" );
            soundscripts\_audio::aud_set_music_submix( 1, 2 );
            soundscripts\_audio_music::mus_play( "mus_finale_finale", 0, 2 );
            level waittill( "sounddone_fin_gdn_ivegotyamate" );
            wait 3;
            soundscripts\_audio_mix_manager::mm_add_submix( "finale_finale", 45 );
            soundscripts\_audio_mix_manager::mm_clear_submix( "temp_vo_premix", 5 );
            break;
        default:
            soundscripts\_audio::aud_print_warning( "\\tMUSIC MESSAGE NOT HANDLED: " + var_0 );
            break;
    }
}

enter_water_override()
{
    level.aud.underwater = 1;
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 1 );
    soundscripts\_snd_filters::snd_fade_in_filter( "underwater", 0.05 );
    soundscripts\_audio_mix_manager::mm_add_submix( "underwater" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_underwater" );
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "underwater" );
    soundscripts\_snd_playsound::snd_play_2d( "bet_swim_plr_submerge" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "underwater_main_lp", "kill_underwater_loop" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "fin_mech_respirator", "kill_underwater_loop", undefined, 1 );
    level.gideon soundscripts\_snd_playsound::snd_play_loop_linked( "underwater_bubble_lp_sm_01", "kill_underwater_loop", undefined, undefined, 0.5 );
    music( "underwater_begin" );
}

exit_water_override()
{
    level.aud.underwater = 0;
    level notify( "kill_underwater_loop" );
    soundscripts\_snd_filters::snd_fade_out_filter( 0.05 );
    soundscripts\_audio_mix_manager::mm_clear_submix( "underwater" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_underwater" );
    soundscripts\_audio_zone_manager::azm_set_filter_bypass( 0 );
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "underwater" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_mech_exit_water" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_mech_exit_water" );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_mech_exit_water" );
    music( "underwater_end" );
}

start_intro()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_intro" );
}

start_intro_skip()
{
    music( "game_play_begin" );
}

start_canal()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_intro" );
    music( "weapons_free" );
}

start_silo_approach()
{
    music( "underwater_end" );
    soundscripts\_audio_zone_manager::azm_start_zone( "int_silo_med" );
}

start_silo_floor_03()
{
    music( "post_underwater_combat_begin" );
    soundscripts\_audio_zone_manager::azm_start_zone( "int_silo_med" );
}

start_door_kick()
{
    soundscripts\_audio_zone_manager::azm_start_zone( "int_silo_large" );
}

start_silo_exhaust_entrance()
{
    music( "hatch_scene_begin" );
    soundscripts\_audio_zone_manager::azm_start_zone( "int_silo_tunnel" );
}

start_lobby()
{
    music( "lobby_combat_begin" );
}

start_sky_bridge()
{

}

start_will_room()
{
    music( "gideon_sets_mitchell_down" );
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_black_out_seq" );
    thread irons_reveal_scene();
}

start_irons_chase()
{
    music( "irons_chase_being_checkpoint" );
}

start_roof()
{
    music( "irons_chase_being_checkpoint" );
}

fin_midair_exp_audio( var_0 )
{
    soundscripts\_snd_playsound::snd_play_at( "exp_amb_mid_air", var_0 );
}

fin_bldg_exp_audio( var_0 )
{

}

fin_water_exp_audio( var_0 )
{

}

fin_glass_exp_audio( var_0 )
{

}

fin_flyin_start()
{
    soundscripts\_snd::snd_slate( "fin_flyin_start" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_intro_flight_jets_fronts", 0.1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_intro_flight_littlebird_path" );
    level waittill( "aud_intro_flight_arrive_hover" );
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_intro_flight_littlebird_lp", 14.5, 1, "fin_intro_flight_helicopter_stop", 3, 3 );
}

fin_flyin_drop()
{
    soundscripts\_snd::snd_slate( "fin_flyin_drop" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_mech_release_chain" );
    level notify( "fin_intro_flight_helicopter_stop" );
}

fin_flyin_splash()
{
    soundscripts\_snd::snd_slate( "fin_flyin_splash" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_water_player_pre_splash", 0.01, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_water_player_splash_fronts", 0.1, 1 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_water_player_hit_underwater", 0.2, 1 );
}

fin_flyin_gideon_splash()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_water_gideon_hit_underwater" );
}

find_npc_dive_boat_handler()
{
    var_0 = "fin_npc_boats_flyby";
    var_1 = [];
    var_1[0] = 800;
    var_2 = [];
    var_2[0] = 20;
    var_2[1] = 5;
    thread soundscripts\_snd_common::snd_advanced_flyby_system( var_0, undefined, var_1, var_2, 1, undefined, undefined, 3, 2 );
}

vrap_explode()
{
    self waittill( "explode" );
    self playsound( "fin_vrap_explo" );
    var_0 = spawnstruct();
    var_0.explo_shot_array_ = [ [ "rocket_explode_metal", 0 ], [ "rocket_explode_paintedmetal", 0 ] ];
    var_0.pos = self.origin;
    var_0.explo_delay_chance_ = 100;
    var_0.shake_dist_threshold_ = 1500;
    var_0.ground_zero_dist_threshold_ = 500;
    soundscripts\_snd_common::snd_ambient_explosion( var_0 );
}

fin_bullet_trails( var_0 )
{
    if ( level.aud.underwater == 1 )
    {
        var_1 = soundscripts\_audio::aud_find_exploder( var_0 );

        if ( isdefined( var_1 ) )
        {
            var_2 = var_1.v["origin"];
            soundscripts\_snd_playsound::snd_play_at( "fin_canal_bullet_trail", var_2 );
        }
    }
}

fin_gid_exit_water()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_gideon_mech_exit_water" );
}

slate_fin_gideon_hatch_grab( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_mech_hatch_rips" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_grab", 0.0 );
}

slate_finale_gideon_hatch_pull_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_01", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_pipe_01", 0.0 );
}

slate_finale_gideon_hatch_regrip_1( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_regrip_01", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_regrip_01_lfe", 0.0 );
}

slate_finale_gideon_hatch_pull_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_02", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_pipe_02", 0.0 );
}

slate_finale_gideon_hatch_regrip_2( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_regrip_02", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_regrip_02_lfe", 0.0 );
}

slate_finale_gideon_hatch_pull_3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_03", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_pull_pipe_03", 0.0 );
}

slate_finale_gideon_hatch_regrip_3( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_nag_hplant", 0.0 );
}

slate_gideon_wave_hand_raise( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_nag_hraise", 0.0 );
}

slate_gideon_wave_hand_plant( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_hatch_nag_hplant", 0.0 );
}

slate_gideon_wave_hand_regrip( var_0 )
{

}

slate_fin_vm_hatch_grab( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_grab_pipe_high", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_grab_pops", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_grab_mech", 0.0 );
}

slate_fin_vm_hatch_pull( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_pull_pipe_high", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_pull_pops", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_hatch_pull_mech", 0.0 );
}

slate_fin_vm_hatch_pull_loop( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_plr_hatch_strain_mech_lp", 0.0, undefined, "stop_mech_strain_loop" );
}

slate_fin_vm_pull_relax( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_pull_relax_mech", 0.0 );
}

slate_fin_gideon_bar_break( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_pipe_break", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_pipe_break_sweet", 0.0 );
}

slate_fin_piston_r_break( var_0 )
{
    level notify( "stop_mech_strain_loop" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_mech_hatch_rips" );
}

slate_fin_piston_l_break( var_0 )
{

}

slate_fin_vm_bar_break( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_pipe_bar_break", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_bar_break_mech", 0.0 );
}

slate_fin_gideon_hatch_open( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_open", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_open_sweet", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_open_mech", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "mech_jump_plr", 7.75 );
}

slate_fin_gideon_hatch_push( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_push", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_push_sweet", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_gideon_hatch_push_mech", 0.0 );
}

shaft_descent_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_shaft_descent" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_free_fall", "kill_free_fall", 0.25 );
    level.aud.wind_lp = soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_free_fall_speed_wind", "kill_free_fall_wind" );
}

shaft_descent_state_change( var_0, var_1 )
{
    var_2 = 0.05;
    var_3 = 0.2;

    if ( var_0 == "shaft_no_hands" && var_1 == "shaft_right_hand" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_right" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_right", "kill_right_loop", var_2, var_3 );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_lfe", "kill_lfe_loop", var_2, var_3 );
        level notify( "kill_free_fall" );
        return;
    }

    if ( var_0 == "shaft_no_hands" && var_1 == "shaft_left_hand" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_left" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_left", "kill_left_loop", var_2, var_3 );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_lfe", "kill_lfe_loop", var_2, var_3 );
        level notify( "kill_free_fall" );
        return;
    }

    if ( var_0 == "shaft_left_hand" && var_1 == "shaft_no_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_release_left" );
        level notify( "kill_left_loop" );
        level notify( "kill_lfe_loop" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_free_fall", "kill_free_fall", 0.05, var_3 );
        return;
    }

    if ( var_0 == "shaft_right_hand" && var_1 == "shaft_no_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_release_right" );
        level notify( "kill_right_loop" );
        level notify( "kill_lfe_loop" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_free_fall", "kill_free_fall", 0.05, var_3 );
        return;
    }

    if ( var_0 == "shaft_right_hand" && var_1 == "shaft_both_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_left" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_left", "kill_left_loop", var_2, var_3 );
        return;
    }

    if ( var_0 == "shaft_left_hand" && var_1 == "shaft_both_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_right" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_right", "kill_right_loop", var_2, var_3 );
        return;
    }

    if ( var_0 == "shaft_no_hands" && var_1 == "shaft_both_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_right" );
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_impact_left" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_left", "kill_left_loop", var_2, var_3 );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_right", "kill_right_loop", var_2, var_3 );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_descent_lfe", "kill_lfe_loop", var_2, var_3 );
        level notify( "kill_free_fall" );
        return;
    }

    if ( var_0 == "shaft_both_hands" && var_1 == "shaft_no_hands" )
    {
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_release_right" );
        soundscripts\_snd_playsound::snd_play_2d( "fin_shaft_release_left" );
        soundscripts\_snd_playsound::snd_play_loop_2d( "fin_shaft_free_fall", "kill_free_fall", 0.05, var_3 );
        level notify( "kill_right_loop" );
        level notify( "kill_left_loop" );
        level notify( "kill_lfe_loop" );
        return;
    }

    if ( var_0 == "shaft_both_hands" && var_1 == "shaft_left_hand" )
    {
        level notify( "kill_right_loop" );
        return;
    }

    if ( var_0 == "shaft_both_hands" && var_1 == "shaft_right_hand" )
    {
        level notify( "kill_left_loop" );
        return;
    }
}

shaft_descent_speed_update( var_0 )
{
    var_0 = abs( var_0 );
    var_1 = soundscripts\_snd::snd_map( var_0, level.aud.envs["speed_to_volume"] );
    level.aud.wind_lp _meth_806F( var_1, 0.05 );
}

shaft_descent_end()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_shaft_descent" );
    soundscripts\_snd::snd_slate( "shaft_descent_end" );
    level notify( "kill_right_loop" );
    level notify( "kill_left_loop" );
    level notify( "kill_lfe_loop" );
    wait 2;
    level notify( "kill_free_fall" );
    level notify( "kill_free_fall_wind" );
}

silo_door_kick( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_gideon_blast_door_kick" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_silo_door_kick_debris", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_silo_door_kick_mech", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_silo_door_kick_metal", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_silo_door_kick_thud", 0.0 );
    wait 6;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_gideon_blast_door_kick" );
}

exhaust_shaft_land()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_mech_shaft_lands" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_shaft_land_impact", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_shaft_land_mech", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_plr_shaft_land_sweet", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_shaft_land_vent", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_shaft_land_debris", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_shaft_land_debris_rain", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_shaft_land_wind", 0.0 );
    wait 10;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_mech_shaft_lands" );
}

exhaust_shaft_land_gideon( var_0 )
{
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_shaft_land_impact", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_shaft_land_mech", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_shaft_land_sweet", 0.0 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_gideon_mech_shields_up", 2.25 );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_player_mech_shields_up", 3.0 );
    level notify( "aud_begin_rocket_ignition" );
}

aud_rocket_stage_01_start()
{
    level waittill( "aud_begin_rocket_ignition" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_rocket_tunnel" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_silo_rocket_ignition", 7.5 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_silo_fire_blast", 11.5 );
    var_0 = 13.6;
    var_1 = 10;
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_01_lp", var_0, undefined, "aud_stop_stage_01_loops", undefined, var_1 );
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_01_lp_lfe", var_0, undefined, "aud_stop_stage_01_loops", undefined, var_1 );
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_01_lp_rears", var_0, undefined, "aud_stop_stage_01_loops", undefined, var_1 );
}

aud_rocket_launch_start()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_stage_02_startup_whine", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_stage_02_startup_thruster", 3.1 );
    var_0 = 0.0;
    var_1 = 5.0;
    var_2 = 2.5;
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_02_lp", var_0, undefined, "aud_stop_stage_02_loops", var_1, var_2 );
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_02_lp_body", var_0, undefined, "aud_stop_stage_02_loops", var_1, var_2 );
    soundscripts\_snd_playsound::snd_play_delayed_loop_2d( "fin_launch_stage_02_lp_whine", var_0, undefined, "aud_stop_stage_02_loops", var_1, var_2 );
    level notify( "aud_stop_stage_01_loops" );
}

fin_silo_fail_launch( var_0 )
{
    var_1 = 0.8;
    wait(var_1);
    level notify( "aud_stop_stage_02_loops" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_silo_launch_fail", 0.0 );
}

fin_silo_success()
{
    soundscripts\_snd::snd_slate( "fin_silo_success" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_win_turbine", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_win_mech", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_win_debris", 0.0 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_win_sparks", 0.0 );
    wait 0.5;
    level notify( "aud_stop_stage_01_loops" );
    level notify( "aud_stop_stage_02_loops" );
}

aud_fin_rocket_damage_vfx()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_rocket_win_explosion", 0.05 );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_launch_win_thrust_off", 0.05 );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_rocket_win_explosion", 2 );
}

missile_small_thrusters_off()
{
    soundscripts\_snd::snd_slate( "missile_small_thrusters_off" );
}

missile_large_thrusters_off()
{
    soundscripts\_snd::snd_slate( "missile_large_thrusters_off" );
}

gid_release_plr_mech_suit()
{
    soundscripts\_snd::snd_slate( "gid_release_plr_mech_suit" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "gid_release_plr_mech_suit", 5.5 );
}

fin_post_silo_gid_foley( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_post_launch_foley" );
    soundscripts\_snd::snd_slate( "post silo_gid foley" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_post_launch_gid_foley" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_post_launch_plr_breaths" );
}

fin_post_silo_switch_to_plr( var_0 )
{
    soundscripts\_snd::snd_slate( "switch_to_plr" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_post_launch_plr_foley" );
    wait 10;
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_black_out_seq", 3 );
    wait 2;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_post_launch_foley" );
}

fin_gid_carry_pickup_1( var_0 )
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_rocket_tunnel" );
}

fin_silo_plr_picked_up( var_0 )
{
    soundscripts\_snd::snd_slate( "pickup" );
}

fin_gid_carry_plr_1( var_0 )
{
    if ( !isdefined( level.aud.carry_first_done ) )
    {
        level.aud.carry_first_done = 1;
        soundscripts\_snd_playsound::snd_play_2d( "fin_blackout_carry_1" );
    }
    else if ( level.aud.carry_first_done == 1 )
    {
        level.aud.carry_first_done = 2;
        soundscripts\_audio_mix_manager::mm_add_submix( "fin_black_out_seq" );
        soundscripts\_snd_playsound::snd_play_2d( "fin_blackout_carry_2" );
    }
    else
    {

    }
}

fin_gid_carry_plr_2( var_0 )
{

}

fin_gid_plr_putdown( var_0 )
{
    soundscripts\_snd_common::snd_enable_soundcontextoverride( "finale_handgun" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_blackout_gid_drops_plr" );
    wait 4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_black_out_seq" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_lobby_shootout" );
}

fin_lobby_gun_limp()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_lobby_plr_arm_goes_limp" );
}

fin_gid_carry_pickup_2( var_0 )
{
    soundscripts\_snd_common::snd_disable_soundcontextoverride( "finale_handgun" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_lobby_gid_picksup_plr" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_lobby_plr_picked_up" );
    wait 4;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_lobby_shootout" );
}

fin_gid_carry_plr_3( var_0 )
{

}

fin_gid_carry_plr_4( var_0 )
{

}

irons_reveal_scene()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_black_out_seq" );
}

aud_irons_says_hello()
{
    wait 8.8;
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_irons_lights" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_irons_reveal_light_on" );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_irons_lights" );
}

aud_irons_reveal_star_trek_door()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_irons_reveal_door_slide" );
}

fin_reveal_gid_drops_plr( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_irons_reveal" );
    soundscripts\_snd::snd_slate( "drop player" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_reveal_gid_drop_plr" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_reveal_plr_dropped" );
}

fin_irons_reveal_plr_start( var_0 )
{

}

fin_irons_reveal_plr_stand( var_0 )
{
    if ( !isdefined( level.aud.reveal_scene ) )
    {
        level.aud.reveal_scene = 1;
        soundscripts\_snd::snd_slate( "plr_stands" );
        soundscripts\_snd_playsound::snd_play_2d( "fin_reveal_plr_gets_up" );
    }
    else
    {

    }
}

fin_irons_reveal_irons_start( var_0 )
{
    soundscripts\_snd::snd_slate( "irons_start" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_reveal_irons_part_1" );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_irons_phone_pullout", 6.1 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_irons_reveal_phone_beep_occluded", 7.35 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_irons_reveal_phone_beep", 11.72 );
    var_0 soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_irons_phone_putaway", 15.4 );
}

fin_irons_reveal_irons_takes_gun( var_0 )
{
    soundscripts\_snd::snd_slate( "irons_takes gun" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_reveal_irons_part_2" );
}

fin_irons_reveal_irons_quake( var_0 )
{
    soundscripts\_snd::snd_slate( "irons quake" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_reveal_irons_part_3" );
}

aud_irons_reveal_bomb_shake( var_0 )
{
    var_1 = 3.9;
    var_2 = var_0 + var_1;
    wait(var_2);
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_irons_reveal_bomb" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_irons_reveal_bomb" );
    wait 7;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_irons_reveal_bomb" );
}

fin_irons_reveal_irons_points_gun( var_0 )
{

}

fin_irons_reveal_gun_away_exit( var_0 )
{
    soundscripts\_snd::snd_slate( "irons exits" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_reveal_irons_part_4" );
}

fin_irons_reveal_scene_gid_start( var_0 )
{

}

fin_irons_reveal_scene_gid_exo_freeze( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_exo_scramble" );
}

fin_irons_reveal_mash_start()
{
    level.aud.irons_reveal_mash_state = "stopped";
    level.aud.irons_reveal_mash_loop_stopped = 1;
}

fin_irons_reveal_mash( var_0 )
{
    if ( level.aud.irons_reveal_mash_state != var_0 )
    {
        switch ( var_0 )
        {
            case "peak":
                break;
            case "speedup":
                if ( level.aud.irons_reveal_mash_loop_stopped == 1 )
                {
                    soundscripts\_snd::snd_slate( "start" );
                    level notify( "irons_reveal_mash_loop_start" );
                    level.aud.irons_reveal_mash_loop_stopped = 0;
                    soundscripts\_snd_playsound::snd_play_loop_2d( "fin_exo_release_lp", "kill_release_lp" );
                }

                break;
            case "stopped":
                soundscripts\_snd::snd_slate( "stopped" );
                thread fin_irons_reveal_mash_try_stop();
                break;
            case "slowdown":
                break;
        }

        level.aud.irons_reveal_mash_state = var_0;
    }
}

fin_irons_reveal_mash_try_stop()
{
    level endon( "irons_reveal_mash_loop_start" );
    wait 0.25;
    level.aud.irons_reveal_mash_loop_stopped = 1;
    level notify( "kill_release_lp" );
}

fin_irons_reveal_mash_finish()
{
    soundscripts\_snd::snd_slate( "finished" );
    level notify( "kill_release_lp" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exo_release_finished" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exo_release_suit_falls_off" );
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_exo_release_eject", 2.0 );
}

aud_irons_reveal_bomb_shake_02( var_0 )
{
    var_1 = 5.2;
    var_2 = var_0 + var_1;
    wait(var_2);
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_irons_reveal_bomb" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_irons_reveal_bomb_02" );
    wait 7;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_irons_reveal_bomb" );
}

irons_reveal_exit_door_open( var_0 )
{
    soundscripts\_snd::snd_slate( "irons_reveal_exit_door_open" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_chase_irons_first_door" );
}

irons_keypad_door_open( var_0 )
{
    soundscripts\_snd::snd_slate( "irons_keypad_door_open" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_chase_irons_door_open" );
}

irons_chase_door_close( var_0 )
{
    soundscripts\_snd::snd_slate( "irons_chase_door_close" );
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_chase_irons_door_close" );
    wait 5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_irons_reveal" );
}

aud_fin_ending_pre_shake()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_end_shake_bomb", 0.0 );
}

aud_fin_ending_shake_01()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_end_shake_bomb", 0.0 );
}

aud_fin_ending_shake_02()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_end_shake_bomb", 0.0 );
}

aud_fin_ending_rooftop_shake()
{

}

fin_skybridge_takedown_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "skybridge_takedown", 1 );
    soundscripts\_snd_timescale::snd_set_timescale( "slomo_timescale" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_skybridge_takedown", "kill_takedown", undefined, 1.1 );
}

fin_skybridge_slo_mo_start()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "skybridge_takedown_slomo" );
}

fin_skybridge_slo_mo_stop()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "skybridge_takedown_slomo", 0.25 );
    wait 1;
    soundscripts\_audio_mix_manager::mm_clear_submix( "skybridge_takedown" );
    soundscripts\_snd_timescale::snd_set_timescale( "all_on" );
}

fin_skybridge_takedown_guy_fall()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_skybridge_takedown_fall" );
}

bridge_takedown_success()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "skybridge_knife" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_skybridge_knife_out" );
}

bridge_takedown_fail()
{
    level notify( "kill_takedown" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_skybridge_takedown_fail" );
}

fin_skybridge_incoming_initial()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_skybridge_explo_incoming" );
}

fin_skybridge_incoming()
{
    var_0 = self;
    var_0 soundscripts\_snd_playsound::snd_play_linked( "fin_skybridge_explo_incoming_2" );
}

fin_skybridge_glass_explo()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_end_explo_low" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exp_grnd_zero" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_end_shake_bomb" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exp_debris_structure_collapse" );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "exp_generic_explo_shot_13" );
    soundscripts\_snd_playsound::snd_play_2d( "glass_pane_blowout" );
    wait 0.1;
    soundscripts\_snd_playsound::snd_play_2d( "exp_debris_glass" );
    wait 3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "skybridge_knife" );
}

aud_fin_ending_roof_explosion()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_end_explo_low" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exp_grnd_zero" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exp_generic_explo_tail" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_exp_debris_structure_collapse" );
}

fin_irons_takedown_start()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_balcony_irons_tackle_intro" );
    soundscripts\_snd_playsound::snd_play_loop_2d( "fin_ending_fire_loop_lfe", "kill_fire_lp", 0.5, 0.5 );
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_fire_explos" );
}

fin_irons_tackle()
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_irons_tackle" );
    var_0 = ( 16596, -86850, 6998 );
    soundscripts\_snd_playsound::snd_play_loop_at( "fin_ending_fire_loop", var_0, undefined, 2 );
    soundscripts\_snd_playsound::snd_play_2d( "fin_balcony_irons_tackle" );
    wait 3.87;
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_dangle_vo" );
    wait 2.3;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_irons_tackle", 1 );
}

fin_ending_slo_mo_override()
{
    soundscripts\_snd_timescale::snd_set_timescale( "all_off" );
}

finale_qte_show_knife()
{
    soundscripts\_snd_timescale::snd_set_timescale( "all_off" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_qte" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_show_knife" );
}

finale_ending_qte1_success()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_flex_hand" );
}

finale_ending_qte1_timeout()
{

}

finale_ending_buttonmash_start()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_qte_drag" );
}

finale_ending_buttonmash_fail()
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_qte_fail_fall" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_qte_fail" );
}

finale_ending_qte2_success()
{
    wait 0.5;
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_kill_irons", 0.5 );
    wait 2.5;
    soundscripts\_audio_mix_manager::mm_clear_submix( "fin_end_kill_irons", 1 );
}

fin_ending_qte_stab( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_qte_stab" );
    soundscripts\_snd::snd_slate( "stab" );
}

finale_ending_qte2_timeout()
{
    soundscripts\_snd::snd_slate( "finale_ending_qte2_timeout" );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_qte_fail" );
}

aud_fin_ending_last_rpg_01()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_end_incoming_01", 0.5, undefined, "aud_fin_kill_last_rpg_01", 0.0, 0.25 );
    wait 1;
    level notify( "aud_fin_kill_last_rpg_01" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_ground_zero" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_exp_generic_explo_shot_01" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_generic_explo_tail" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_debris_structure_collapse" );
}

aud_fin_ending_last_rpg_02()
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_end_incoming_02", 0.5, undefined, "aud_fin_kill_last_rpg_02", 0.0, 0.25 );
    wait 1;
    level notify( "aud_fin_kill_last_rpg_02" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_ground_zero" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "fin_exp_generic_explo_shot_02" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_generic_explo_tail" );
    level.player soundscripts\_snd_playsound::snd_play_delayed_linked( "exp_debris_structure_collapse" );
}

fin_ending_knife_drop( var_0 )
{
    soundscripts\_snd_playsound::snd_play_delayed_2d( "fin_ending_knife_drop", 0.1 );
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_gid_rescue", 20 );
}

fin_ending_plr_foley_1( var_0 )
{
    soundscripts\_audio_mix_manager::mm_add_submix( "fin_end_rescue_foley" );
    soundscripts\_snd_playsound::snd_play_2d( "fin_ending_gid_rescue_foley_1" );
}

fin_ending_plr_foley_2( var_0 )
{
    var_1 = soundscripts\_snd_playsound::snd_play_2d( "fin_ending_gid_rescue_foley_2" );
    wait 7.25;
    var_1 _meth_806F( 0, 13 );
}

fin_ending_gideon_foley_1( var_0 )
{

}

fin_ending_gideon_foley_2( var_0 )
{

}
