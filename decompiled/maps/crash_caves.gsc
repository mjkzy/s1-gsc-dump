// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

precache_cave_hallway()
{
    common_scripts\utility::flag_init( "cave_hallway_done" );
    common_scripts\utility::flag_init( "turn_off_flare" );
    common_scripts\utility::flag_init( "launch_prometheus_drone" );
    common_scripts\utility::flag_init( "cave_intro_anim_done" );
    common_scripts\utility::flag_init( "show_drone" );
    common_scripts\utility::flag_init( "show_drone_lighting" );
    common_scripts\utility::flag_init( "start_drone_anim" );
    common_scripts\utility::flag_init( "turn_on_light" );
    common_scripts\utility::flag_init( "allow_release_drone" );
    common_scripts\utility::flag_init( "FLAG_early_voices" );
    common_scripts\utility::flag_init( "FLAG_cave_abyss_death_1" );
    common_scripts\utility::flag_init( "start_down_hall" );
    common_scripts\utility::flag_init( "hall_loop_1" );
    common_scripts\utility::flag_init( "hall_loop_2" );
    common_scripts\utility::flag_init( "noise_stinger" );
    common_scripts\utility::flag_init( "say_light_off" );
    common_scripts\utility::flag_init( "start_friendly_turkey_anim" );
    common_scripts\utility::flag_init( "flare_out" );
    precachemodel( "vehicle_drone_02" );
    precachemodel( "csh_grid_effects" );
    precacheitem( "iw5_kvahazmatknifeonearm_sp" );
    precachemodel( "mil_emergency_flare" );
    precacheitem( "s1_sentinel_survey_drone_sphere" );
    precacheitem( "iw5_kvahazmatknife_sp" );
    precacheshader( "cinematic_add" );
    precacheitem( "fraggrenade" );
    precacheitem( "flash_grenade" );
    precacheitem( "iw5_uts19_sp" );
}

precache_big_cave()
{
    common_scripts\utility::flag_init( "big_cave_done" );
    common_scripts\utility::flag_init( "wakeup_turkey" );
    common_scripts\utility::flag_init( "reso_charge_planted" );
    common_scripts\utility::flag_init( "drop_pod_shake_stop" );
    common_scripts\utility::flag_init( "small_cave_combat_start" );
    common_scripts\utility::flag_init( "run_away" );
    common_scripts\utility::flag_init( "small_cave_wave1_spawn" );
    common_scripts\utility::flag_init( "wave1_dead" );
    common_scripts\utility::flag_init( "wave2_dead" );
    common_scripts\utility::flag_init( "new_wakeup_turkey" );
    common_scripts\utility::flag_init( "pod_area_done" );
    common_scripts\utility::flag_init( "alert_drop_pod_1" );
    common_scripts\utility::flag_init( "alert_drop_pod_2" );
    common_scripts\utility::flag_init( "alert_drop_pod_3" );
    common_scripts\utility::flag_init( "alert_all_troops" );
    common_scripts\utility::flag_init( "turkey_1_dead" );
    common_scripts\utility::flag_init( "turkey_2_dead" );
    common_scripts\utility::flag_init( "turkey_3_dead" );
    common_scripts\utility::flag_init( "FLAG_caves_goliath" );
    common_scripts\utility::flag_init( "hall_light_off" );
    common_scripts\utility::flag_init( "hall_light_on" );
    common_scripts\utility::flag_init( "stealth_room_alerted" );
    common_scripts\utility::flag_init( "medic_detection" );
    common_scripts\utility::flag_init( "radio_detected" );
    common_scripts\utility::flag_init( "mechanic_detected" );
    common_scripts\utility::flag_init( "player_turn_off_light" );
    common_scripts\utility::flag_init( "say_movement_ahead" );
    common_scripts\utility::flag_init( "stealth_room_takedown" );
    common_scripts\utility::flag_init( "stealth_room_alerted" );
    common_scripts\utility::flag_init( "mechanic_set" );
    common_scripts\utility::flag_init( "patrollers_set" );
    common_scripts\utility::flag_init( "follow_pod_room" );
    common_scripts\utility::flag_init( "patrol_guy_01_done" );
    common_scripts\utility::flag_init( "say_light_off" );
    common_scripts\utility::flag_init( "pod_room_alerted" );
    common_scripts\utility::flag_init( "pod_retreat" );
    common_scripts\utility::flag_init( "FLAG_pod_room_start" );
    common_scripts\utility::flag_init( "flag_turkey_goons" );
    common_scripts\utility::flag_init( "patrol_moves" );
}

precache_ice_bridge()
{
    common_scripts\utility::flag_init( "ice_bridge_done" );
    common_scripts\utility::flag_init( "ice_bridge_shot" );
    common_scripts\utility::flag_init( "turn_on_reso_trigger" );
    common_scripts\utility::flag_init( "bridge_reso_shot" );
    common_scripts\utility::flag_init( "goliath_attack" );
    common_scripts\utility::flag_init( "bridge_cormack_ready" );
    common_scripts\utility::flag_init( "start_smash" );
    common_scripts\utility::flag_init( "goliath_change_anim" );
    common_scripts\utility::flag_init( "player_up_close" );
    common_scripts\utility::flag_init( "bridge_throw_start" );
    common_scripts\utility::flag_init( "bridge_throw_end" );
    common_scripts\utility::flag_init( "bridge_explode" );
    common_scripts\utility::flag_init( "friendlies_move" );
    common_scripts\utility::flag_init( "start_reso_move" );
    common_scripts\utility::flag_init( "golaith_throw_anim_done" );
    common_scripts\utility::flag_init( "cormack_throw_moment" );
    common_scripts\utility::flag_init( "goliath_fail_flag" );
    common_scripts\utility::flag_init( "goliath_dof_set" );
    common_scripts\utility::flag_init( "crash_lighting_goliath_pit" );
    precacheitem( "iw5_maul_sp" );
    precacheitem( "iw5_titan45_sp" );
    precachemodel( "generic_prop_raven_x3" );
    precachemodel( "csh_ice_lrg_rock_01" );
    precachemodel( "npc_exo_armor_base" );
    precachemodel( "npc_resonance_device_base" );
    precacherumble( "hijack_plane_medium" );
    precacheshellshock( "crash_goliath_hit" );
    maps\_utility::add_control_based_hint_strings( "player_tappy_gamepad", &"CRASH_HINT_TAPPY_GAMEPAD", ::should_break_tappy_hint );
    maps\_utility::add_control_based_hint_strings( "player_move_gamepad", &"CRASH_HINT_CAVE_MOVEMENT", ::should_break_move_hint, &"CRASH_HINT_CAVE_MOVEMENT_KEYBOARD", &"CRASH_HINT_CAVE_MOVEMENT_S" );
}

precache_narrow_cave()
{
    common_scripts\utility::flag_init( "narrow_cave_done" );
    common_scripts\utility::flag_init( "waiting_for_input" );
    common_scripts\utility::flag_init( "ilana_in_chamber" );
    common_scripts\utility::flag_init( "cormack_traverse_sec_1" );
    common_scripts\utility::flag_init( "cormack_can_teleport1" );
    common_scripts\utility::flag_init( "cormack_can_teleport2" );
    common_scripts\utility::flag_init( "cormack_can_teleport3" );
    common_scripts\utility::flag_init( "ilona_can_teleport1" );
    common_scripts\utility::flag_init( "ilona_can_teleport2" );
    common_scripts\utility::flag_init( "ilona_can_teleport4" );
    common_scripts\utility::flag_init( "cormack_in_chamber" );
    common_scripts\utility::flag_init( "narrow_cave_rumble" );
    common_scripts\utility::flag_init( "cave_in" );
    common_scripts\utility::flag_init( "narrow_cave_hint" );
    common_scripts\utility::flag_init( "zero_breach_view" );
    common_scripts\utility::flag_init( "cormack_breach_loop" );
    common_scripts\utility::flag_init( "cormack_breach_ready" );
    common_scripts\utility::flag_init( "start_breach_enemies" );
    common_scripts\utility::flag_init( "start_ilona_breach" );
    common_scripts\utility::flag_init( "player_starting_uw_breach" );
    common_scripts\utility::flag_init( "lighting_uw_breach_dof" );
    common_scripts\utility::flag_init( "player_can_aim" );
    common_scripts\utility::flag_init( "narrow_cave_underwater" );
    precachemodel( "weapon_ice_picker_arctic" );
    precachemodel( "scripted_ice_picker_arctic" );
    precacherumble( "light_2s" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precachestring( &"CRASH_HINT_CAVE_MOVEMENT" );
    precachestring( &"CRASH_HINT_SWIM_GAMEPAD" );
    precachestring( &"CRASH_HINT_SWIM_KEYBOARD" );
    precachestring( &"CRASH_HINT_CROUCH_GAMEPAD" );
    precachestring( &"CRASH_HINT_CROUCH_KEYBOARD" );
    maps\_utility::add_control_based_hint_strings( "player_crouch_gamepad", &"CRASH_HINT_CROUCH_GAMEPAD", ::should_break_crouch_hint, &"CRASH_HINT_CROUCH_KEYBOARD" );
    maps\_utility::add_control_based_hint_strings( "player_swim_gamepad", &"CRASH_HINT_SWIM_GAMEPAD", ::should_break_swim_hint, &"CRASH_HINT_SWIM_KEYBOARD", &"CRASH_HINT_SWIM_GAMEPAD_S" );
}

precache_combat_cave()
{
    common_scripts\utility::flag_init( "start_crevasse_wave_1" );
    common_scripts\utility::flag_init( "FLAG_crevasse_upper_move" );
    common_scripts\utility::flag_init( "crevasse_player_left" );
    common_scripts\utility::flag_init( "crevasse_player_top" );
    common_scripts\utility::flag_init( "crevasse_player_right" );
    common_scripts\utility::flag_init( "crevasse_wave_2" );
    common_scripts\utility::flag_init( "crevasse_3_support" );
    common_scripts\utility::flag_init( "combat_cave_done" );
    common_scripts\utility::flag_init( "FLAG_abyss_death" );
    common_scripts\utility::flag_init( "ilona_say_left" );
}

debug_start_cave_hallway()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_cave_hallway" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_prometheus" );
    maps\_utility::vision_set_fog_changes( "crash_ice_caves_prometheus", 0 );
    level.player _meth_8490( "clut_crash_prometheus", 0 );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_big_cave()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_big_cave" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_ice_caves_01" );
    maps\_utility::vision_set_fog_changes( "crash_ice_caves_01", 0 );
    level.player _meth_8490( "clut_crash_ice_caves", 0 );
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    common_scripts\utility::flag_set( "turn_on_light" );
    common_scripts\utility::flag_set( "obj_hall_follow_start" );
    common_scripts\utility::flag_set( "start_friendly_turkey_anim" );
    thread maps\crash_utility::cormack_helmet_open( level.cormack );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_ice_bridge()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_ice_bridge" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_ice_caves_01" );
    maps\_utility::vision_set_fog_changes( "crash_ice_caves_01", 0 );
    level.player _meth_8490( "clut_crash_ice_caves", 0 );
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    thread maps\crash_utility::cormack_helmet_open( level.cormack );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_narrow_cave()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_narrow_cave" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_post_goliath" );
    maps\_utility::vision_set_fog_changes( "crash_post_goliath", 0 );
    level.player _meth_8490( "clut_crash_ice_caves", 0 );
    level.visionset_default = "crash_post_goliath";
    level.player _meth_84AA();
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    thread maps\crash_utility::cormack_helmet_open( level.cormack );
    common_scripts\_exploder::exploder( 1999 );
}

debug_start_combat_cave()
{
    maps\crash::set_completed_flags();
    maps\crash_utility::setup_player();
    maps\crash_utility::setup_allies();
    soundscripts\_snd::snd_message( "start_combat_cave" );
    thread maps\crash::objective_init();
    level.player _meth_83C0( "crash_ice_caves_02" );
    maps\_utility::vision_set_fog_changes( "crash_ice_caves_02", 0 );
    level.player _meth_8490( "clut_crash_overlook", 0 );
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    common_scripts\_exploder::exploder( 1999 );
}

begin_cave_hallway()
{
    thread maps\_utility::autosave_by_name( "start_caves" );
    thread death_pit();
    thread cave_intro_anim_moment();
    thread temp_noise();
    thread drone_dialog();
    thread hall_exploders();
    thread cave_wall_temp_show();
    thread early_voices_around_corner();
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_indoor, 5 );
    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 5 );
    common_scripts\utility::flag_set( "hide_player_snow_footprints" );
    common_scripts\utility::flag_set( "indoors" );
    common_scripts\utility::flag_set( "obj_start_locate_chopper" );
    common_scripts\utility::flag_wait( "cave_hallway_done" );
}

death_pit()
{
    level endon( "ice_bridge_done" );
    common_scripts\utility::flag_wait( "FLAG_cave_abyss_death_1" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
    level.player _meth_8482();
}

cave_wall_temp_show()
{
    var_0 = getent( "pro_healthy_wall", "targetname" );
    var_1 = getent( "pro_destroyed_wall", "targetname" );
    var_1 hide();
    var_0 show();
    var_2 = getent( "pro_wall", "targetname" );
    level waittill( "break_wall" );
    var_3 = playfxontag( level._effect["wall_break"], var_2, "tag_fx_01" );
    var_2 show();
    var_0 hide();
    var_0 _meth_82BF();
}

temp_noise()
{
    level endon( "disable_ice_crack" );
    var_0 = getent( "node_noise", "targetname" );
    level waittill( "ice_shatter" );
    common_scripts\utility::flag_set( "noise_stinger" );
    soundscripts\_snd::snd_message( "stalactite_fall", var_0.origin );
}

drone_dialog()
{
    thread dialog_complain_cold();
    thread dialog_noise_stinger();
}

dialog_complain_cold()
{
    level endon( "drone_dead" );
    common_scripts\utility::flag_wait( "drone_move_1" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_colder" );
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_suitthermals" );
}

dialog_noise_stinger()
{
    level endon( "data_ends" );
    common_scripts\utility::flag_wait( "noise_stinger" );
    wait 4;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_justice" );
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_scanning" );
}

flare_cormack()
{
    common_scripts\utility::flag_wait( "turn_on_light" );

    if ( !isdefined( level.flare_model ) )
    {
        level.flare_model = spawn( "script_model", level.cormack.origin );
        level.flare_model _meth_80B1( "mil_emergency_flare" );
        level.flare_model.origin = level.cormack gettagorigin( "TAG_WEAPON_LEFT" );
        level.flare_model.angles = level.cormack gettagangles( "TAG_WEAPON_LEFT" );
        level.flare_model _meth_804D( level.cormack, "TAG_WEAPON_LEFT" );
    }

    var_0 = playfxontag( level._effect["smoke_flare_held_crash"], level.flare_model, "tag_fire_fx" );
    common_scripts\utility::flag_wait( "flare_out" );
    killfxontag( level._effect["smoke_flare_held_crash"], level.flare_model, "tag_fire_fx" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = level.flare_model gettagorigin( "tag_fire_fx" );
    playfxontag( level._effect["smoke_flare_out"], var_1, "tag_origin" );
    wait 3;
    level.flare_model _meth_804F();
    level.flare_model delete();
    var_1 delete();
}

cave_intro_anim_moment()
{
    var_0 = [];
    var_1 = common_scripts\utility::getstruct( "cave_entry_teleport_animnode", "targetname" );
    maps\_utility::battlechatter_off( "allies" );
    common_scripts\utility::flag_wait_either( "cave_entry_done", "FLAG_entered_caves" );
    level.cormack _meth_8141();
    level.ilana _meth_8141();
    var_0[0] = level.ilana;
    var_0[1] = level.cormack;
    var_2 = getent( "pro_wall", "targetname" );
    var_2.animname = "pro_wall";
    var_2 maps\_anim::setanimtree();
    var_2 hide();
    var_1 thread maps\_anim::anim_first_frame_solo( var_2, "head_down_tunnel" );
    level.ilana maps\_utility::disable_ai_color();
    level.cormack maps\_utility::disable_ai_color();
    level.cormack thread cormack_light_handler();
    level.cormack thread radio_chatter();
    level.ilana thread wall_notetrack_listener();
    var_0 = common_scripts\utility::array_add( var_0, var_2 );
    var_1 thread maps\_anim::anim_single( var_0, "head_down_tunnel" );
    wait 0.05;
    level.cormack thread attach_weapon_to_tag_sync();
    level.ilana thread attach_weapon_to_tag_sync();
    level.ilana waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "obj_hall_follow_start" );
    thread maps\_utility::autosave_by_name( "end_pro_drone" );

    if ( !common_scripts\utility::flag( "FLAG_ilona_drone" ) )
    {
        var_1 thread maps\_anim::anim_loop_solo( level.ilana, "cave_intro_loop", "stop_cave_loop" );
        var_1 thread maps\_anim::anim_loop_solo( level.cormack, "cave_intro_loop", "stop_cave_loop" );
    }

    common_scripts\utility::flag_wait( "FLAG_ilona_drone" );
    var_1 notify( "stop_cave_loop" );
    level.ilana _meth_8141();
    level.cormack _meth_8141();
    thread cave_temperature();
    var_3 = [];
    var_3[0] = level.cormack;
    var_3[1] = level.ilana;
    common_scripts\utility::flag_set( "cave_hallway_done" );
    var_1 thread cormack_hall_handler();
    level.cormack thread cormack_flare_notetrack_handler_flare();
    level.cormack thread cave_ender_notify();
    level.ilana thread cave_ender_notify();
    var_1 thread ilana_hall_handler();
    thread teleport_ahead();
    var_1 maps\_anim::anim_single( var_3, "flare_cave_walk" );
    level notify( "flare_out" );
    common_scripts\utility::flag_set( "flare_out" );
    common_scripts\utility::flag_set( "start_friendly_turkey_anim" );
}

attach_weapon_to_tag_sync()
{
    var_0 = getweaponmodel( self.weapon );
    var_1 = spawn( "script_model", self gettagorigin( "tag_sync" ) );
    var_1.angles = self gettagangles( "tag_sync" );
    var_1 _meth_804D( self, "tag_sync" );
    var_1 _meth_80B1( var_0 );
    maps\_utility::gun_remove();
    self waittillmatch( "single anim", "end" );
    var_1 _meth_804F();
    var_1 delete();
    maps\_utility::gun_recall();
}

cave_temperature()
{
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_deep_caves, 40 );
}

radio_chatter()
{
    self waittillmatch( "single anim", "radio" );
    maps\_utility::smart_radio_dialogue( "crsh_kp_plesaerespond4" );
}

#using_animtree("generic_human");

cave_ender_notify()
{
    self waittillmatch( "single anim", "end" );
    var_0 = common_scripts\utility::getstruct( "csh_turkey_anim", "targetname" );
    var_0 thread maps\_anim::anim_single_solo( self, "turkey_shoot" );
    waitframe();

    if ( !common_scripts\utility::flag( "continue_turkey_anim" ) )
    {
        if ( self == level.cormack )
            self _meth_83C7( %crash_turkey_shoot_insertion_cormack, 0 );
        else
            self _meth_83C7( %crash_turkey_shoot_insertion_ilona, 0 );

        common_scripts\utility::flag_wait( "continue_turkey_anim" );

        if ( self == level.cormack )
            self _meth_83C7( %crash_turkey_shoot_insertion_cormack, 1 );
        else
            self _meth_83C7( %crash_turkey_shoot_insertion_ilona, 1 );
    }

    level.cormack waittillmatch( "single anim", "end" );
    var_1 = level.ilana common_scripts\utility::spawn_tag_origin();
    level.ilana _meth_81A7( var_1 );
    level.ilana maps\_utility::enable_ai_color();
    var_2 = level.cormack common_scripts\utility::spawn_tag_origin();
    level.cormack _meth_81A7( var_2 );
    level.cormack maps\_utility::enable_ai_color();
    level.cormack notify( "new_anim_reach" );
    level.ilana notify( "new_anim_reach" );
}

teleport_ahead()
{
    level endon( "wakeup_turkey" );
    common_scripts\utility::flag_wait( "drone_move_2" );

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.19 )
    {
        level.cormack _meth_8117( %crash_flare_cave_cormack, 0.19 );
        level.ilana _meth_8117( %crash_flare_cave_ilona, 0.19 );
    }

    common_scripts\utility::flag_wait( "prometheus_drone_vision_off" );

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.5 )
    {
        level notify( "disable_shatter_event" );
        level.cormack _meth_8117( %crash_flare_cave_cormack, 0.5 );
        level.ilana _meth_8117( %crash_flare_cave_ilona, 0.5 );
        level notify( "disable_ice_crack" );
    }

    common_scripts\utility::flag_wait( "hall_light_off" );

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.7 )
    {
        level.cormack _meth_8117( %crash_flare_cave_cormack, 0.7 );
        level.ilana _meth_8117( %crash_flare_cave_ilona, 0.7 );
    }
}

cormack_hall_handler()
{
    level endon( "teleport_ahead" );
    var_0 = self;
    level.cormack thread cormack_flare_notetrack_handler_ice();

    while ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.28 )
        wait 0.05;

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) > 0.28 )
    {
        if ( !common_scripts\utility::flag( "drone_dead" ) )
        {
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 0 );
            common_scripts\utility::flag_wait( "drone_dead" );
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 1 );
        }
    }

    while ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.4 )
        wait 0.05;

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) > 0.4 )
    {
        if ( !common_scripts\utility::flag( "drone_move_2" ) )
        {
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 0 );
            common_scripts\utility::flag_wait( "drone_move_2" );
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 1 );
        }
    }

    while ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.57 )
        wait 0.05;

    if ( level.cormack _meth_814F( %crash_flare_cave_cormack ) > 0.57 )
    {
        if ( !common_scripts\utility::flag( "drone_move_3" ) )
        {
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 0 );
            common_scripts\utility::flag_wait( "drone_move_3" );
            level.cormack _meth_83C7( %crash_flare_cave_cormack, 1 );
        }
    }
}

cormack_flare_notetrack_handler_ice()
{
    level endon( "disable_shatter_event" );

    while ( level.cormack _meth_814F( %crash_flare_cave_cormack ) < 0.46 )
        wait 0.05;

    level notify( "ice_shatter" );
}

cormack_flare_notetrack_handler_flare()
{
    self waittillmatch( "single anim", "flare_out" );
    common_scripts\_exploder::exploder( 5151 );
    level notify( "flare_out" );
    common_scripts\utility::flag_set( "flare_out" );
}

ilana_hall_handler()
{
    level endon( "teleport_ahead" );
    var_0 = self;

    while ( level.ilana _meth_814F( %crash_flare_cave_ilona ) < 0.28 )
        wait 0.05;

    if ( level.ilana _meth_814F( %crash_flare_cave_ilona ) > 0.28 )
    {
        if ( !common_scripts\utility::flag( "drone_dead" ) )
        {
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 0 );
            common_scripts\utility::flag_wait( "drone_dead" );
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 1 );
        }
    }

    while ( level.ilana _meth_814F( %crash_flare_cave_ilona ) < 0.4 )
        wait 0.05;

    if ( level.ilana _meth_814F( %crash_flare_cave_ilona ) > 0.4 )
    {
        if ( !common_scripts\utility::flag( "drone_move_2" ) )
        {
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 0 );
            common_scripts\utility::flag_wait( "drone_move_2" );
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 1 );
        }
    }

    while ( level.ilana _meth_814F( %crash_flare_cave_ilona ) < 0.57 )
        wait 0.05;

    if ( level.ilana _meth_814F( %crash_flare_cave_ilona ) > 0.57 )
    {
        if ( !common_scripts\utility::flag( "drone_move_3" ) )
        {
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 0 );
            common_scripts\utility::flag_wait( "drone_move_3" );
            level.ilana _meth_83C7( %crash_flare_cave_ilona, 1 );
        }
    }
}

wall_notetrack_listener()
{
    var_0 = getent( "icewall_blocker", "targetname" );
    soundscripts\_snd::snd_message( "ilana_break_wall", self );
    self waittillmatch( "single anim", "break_wall" );
    var_0 _meth_82BF();
    var_0 delete();
    level notify( "break_wall" );
}

cormack_light_handler()
{
    self waittillmatch( "single anim", "unhide_flare" );
    level.flare_model = spawn( "script_model", level.cormack.origin );
    level.flare_model _meth_80B1( "mil_emergency_flare" );
    level.flare_model.origin = level.cormack gettagorigin( "TAG_WEAPON_LEFT" );
    level.flare_model.angles = level.cormack gettagangles( "TAG_WEAPON_LEFT" );
    level.flare_model _meth_804D( level.cormack, "TAG_WEAPON_LEFT" );
    self waittillmatch( "single anim", "cormack_light" );
    soundscripts\_snd::snd_message( "cormack_flare" );
    common_scripts\utility::flag_set( "turn_on_light" );
    var_0 = playfxontag( level._effect["smoke_flare_held_crash"], level.flare_model, "tag_fire_fx" );
    common_scripts\utility::flag_wait_either( "flare_out", "wakeup_turkey" );
    killfxontag( level._effect["smoke_flare_held_crash"], level.flare_model, "tag_fire_fx" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = level.flare_model gettagorigin( "tag_fire_fx" );
    playfxontag( level._effect["smoke_flare_out"], var_1, "tag_origin" );
    wait 3;
    level.flare_model _meth_804F();
    level.flare_model delete();
    var_1 delete();
}

drone_cinematic( var_0 )
{
    wait 1.25;
    _func_0D3( "cg_cinematicfullscreen", "0" );
    var_1 = newhudelem();
    var_1 _meth_80CC( "cinematic_add", 180, 132 );
    var_1.x = 10;
    var_1.y = 135;
    var_1.alignx = "left";
    var_1.aligny = "top";
    var_1.horzalign = "left";
    var_1.vertalign = "top";
    var_1.alpha = 1.0;
    _func_057( "crash_drone_hud_intro" );

    while ( !_func_22D() )
        wait 0.05;

    wait 27;
    _func_05A( "crash_drone_hud_loop" );
    common_scripts\utility::flag_wait( "drone_dead" );
    _func_057( "crash_drone_hud_outro" );

    while ( !_func_22D() )
        wait 0.05;

    wait 4;
    _func_0D3( "cg_cinematicfullscreen", "1" );
    _func_05C();
    var_1 destroy();
    wait 7.5;
    level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_indoor );
    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
    level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
}

player_movement_weapons_setup()
{

}

hall_exploders()
{
    common_scripts\utility::flag_wait( "drone_move_1" );
    common_scripts\_exploder::exploder( 3173 );
    common_scripts\utility::flag_wait( "drone_move_2" );
    common_scripts\_exploder::exploder( 3173 );
}

early_voices_around_corner()
{
    common_scripts\utility::flag_wait( "FLAG_early_voices" );
    var_0 = common_scripts\utility::getstruct( "NODE_drone_08", "targetname" );
    thread common_scripts\utility::play_sound_in_space( "crsh_as3_coldashell", var_0.origin );
    wait 1;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_hearthat" );
    common_scripts\utility::flag_set( "say_light_off" );
}

begin_big_cave()
{
    thread big_cave_autosave();
    thread turkey_shoot();
    thread big_cave_abyss_death();
    thread ice_bridge_goons();
    thread big_cave_cleanup();
    thread bridge_rappel_squad();
    level.ilana anim_reach_fix();
    level.cormack anim_reach_fix();
    common_scripts\utility::flag_wait( "big_cave_done" );
}

big_cave_autosave()
{
    common_scripts\utility::flag_wait( "cormack_turkey_talk_hold" );
    thread maps\_utility::autosave_by_name( "big_cave" );
}

big_cave_abyss_death()
{
    level endon( "ice_bridge_done" );
    common_scripts\utility::flag_wait( "FLAG_big_cave_abyss_death" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
}

turkey_shoot()
{
    common_scripts\utility::flag_wait( "say_light_off" );
    thread turkey_shoot_dialog();
    thread turkey_shoot_enemy_dialog();
    thread turkey_shoot_anim();
    thread turn_off_light();
    thread turkey_shoot_enemies();
    level.ilana maps\_utility::enable_arrivals();
    level.ilana maps\_utility::enable_exits();
    level.ilana maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_arrivals();
    level.cormack maps\_utility::enable_exits();
    level.cormack maps\_utility::enable_cqbwalk();
    level.cormack.ignoreme = 1;
    level.cormack.ignoreall = 1;
    level.ilana.ignoreme = 1;
    level.ilana.ignoreall = 1;
    level.player.ignoreme = 1;
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    level.cormack notify( "new_anim_reach" );
    level.ilana notify( "new_anim_reach" );
    level.cormack.ignoreme = 0;
    level.cormack.ignoreall = 0;
    level.ilana.ignoreme = 0;
    level.ilana.ignoreall = 0;
    level.player.ignoreme = 0;
    level.cormack.ignoresuppression = 1;
    level.ilana.ignoresuppression = 1;
}

turkey_shoot_anim()
{
    var_0 = [];
    var_0[0] = level.cormack;
    var_0[1] = level.ilana;
    level.ilana maps\_utility::disable_ai_color();
    level.cormack maps\_utility::disable_ai_color();
    level.cormack maps\_utility::set_moveplaybackrate( 1 );
    level.ilana maps\_utility::set_moveplaybackrate( 1 );
    var_1 = common_scripts\utility::getstruct( "csh_turkey_anim", "targetname" );
    level.cormack thread cormack_turkey_shoot( var_1 );
    level.ilana thread ilana_turkey_shoot( var_1 );
    common_scripts\utility::flag_set( "say_movement_ahead" );
    level waittill( "wakeup_turkey" );
    level.cormack _meth_8141();
    level.ilana _meth_8141();
    maps\_utility::battlechatter_on( "allies" );
    level.ilana maps\_utility::enable_ai_color();
    level.cormack maps\_utility::enable_ai_color();
}

cormack_turkey_shoot( var_0 )
{
    level endon( "wakeup_turkey" );

    if ( !common_scripts\utility::flag( "drone_move_4" ) )
    {
        common_scripts\utility::flag_wait( "start_friendly_turkey_anim" );
        var_0 maps\_anim::anim_reach_solo( self, "turkey_shoot" );
        var_0 maps\_anim::anim_single_solo( self, "turkey_shoot" );
        var_1 = level.ilana common_scripts\utility::spawn_tag_origin();
        level.ilana _meth_81A7( var_1 );
        level.ilana maps\_utility::enable_ai_color();
        var_2 = level.cormack common_scripts\utility::spawn_tag_origin();
        level.cormack _meth_81A7( var_2 );
        level.cormack maps\_utility::enable_ai_color();
        level.cormack notify( "new_anim_reach" );
        level.ilana notify( "new_anim_reach" );
    }
}

ilana_turkey_shoot( var_0 )
{
    level endon( "wakeup_turkey" );

    if ( !common_scripts\utility::flag( "drone_move_4" ) )
    {
        common_scripts\utility::flag_wait( "start_friendly_turkey_anim" );
        level.ilana.ignoresuppression = 1;
        var_0 maps\_anim::anim_reach_solo( self, "turkey_shoot" );
        var_0 maps\_anim::anim_single_solo( self, "turkey_shoot" );
        var_1 = level.ilana common_scripts\utility::spawn_tag_origin();
        level.ilana _meth_81A7( var_1 );
        level.ilana maps\_utility::enable_ai_color();
    }
}

anim_reach_fix()
{
    level endon( "wakeup_turkey" );

    for (;;)
    {
        self.goalradius = 1;
        waitframe();
    }
}

turn_off_light()
{
    common_scripts\utility::flag_wait( "say_light_off" );
    common_scripts\utility::flag_set( "player_turn_off_light" );
}

turkey_shoot_drone()
{
    level endon( "turkey_done_dead" );
    var_0 = common_scripts\utility::getstruct( "csh_turkey_anim", "targetname" );
    var_1 = getent( "turkey_drone", "targetname" );
    var_1.animname = "turkey_drone";
    var_1 maps\_anim::setanimtree();
    var_1 thread drone_fx();
    var_0 thread maps\_anim::anim_single_solo( var_1, "turkey_shoot" );
    var_1 waittillmatch( "single anim", "end" );

    if ( !common_scripts\utility::flag( "wakeup_turkey" ) )
        var_0 thread maps\_anim::anim_loop_solo( var_1, "turkey_shoot_loop", "stop_loop" );

    common_scripts\utility::flag_wait( "wakeup_turkey" );
    var_0 notify( "stop loop" );
    level notify( "drone_drop" );
    var_0 maps\_anim::anim_single_solo( var_1, "turkey_shoot_dead" );
}

turkey_drone_logic( var_0 )
{
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    self _meth_8141();
    var_0 maps\_anim::anim_single_solo( self, "turkey_shoot_dead" );
}

drone_fx()
{
    wait 8;
    var_0 = playfxontag( level._effect["energy_distort"], self, "FX_blade_KR1" );
    var_1 = playfxontag( level._effect["energy_distort"], self, "FX_blade_FR1" );
    var_2 = playfxontag( level._effect["energy_distort"], self, "FX_blade_FL1" );
    var_3 = playfxontag( level._effect["energy_distort"], self, "FX_blade_KL1" );
    waitframe();
    var_4 = playfxontag( level._effect["energy_distort"], self, "FX_blade_KR2" );
    var_5 = playfxontag( level._effect["energy_distort"], self, "FX_blade_FL2" );
    var_6 = playfxontag( level._effect["energy_distort"], self, "FX_blade_KL2" );
    var_7 = playfxontag( level._effect["energy_distort"], self, "FX_blade_FR2" );
    level waittill( "drone_drop" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_KR1" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_FR1" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_FL1" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_KL1" );
    waitframe();
    killfxontag( level._effect["energy_distort"], self, "FX_blade_KR2" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_FL2" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_KL2" );
    killfxontag( level._effect["energy_distort"], self, "FX_blade_FR2" );
}

turkey_shoot_enemies()
{
    common_scripts\utility::flag_wait( "start_turkey_movement" );
    createthreatbiasgroup( "top_guys" );
    createthreatbiasgroup( "friendlies" );
    soundscripts\_snd::snd_message( "turkey_shoot" );
    level.ilana.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.cormack _meth_8177( "friendlies" );
    level.ilana _meth_8177( "friendlies" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "enemy_turkey_1", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "enemy_turkey_1", 1, 0.1 );

    var_1 = common_scripts\utility::getstruct( "csh_turkey_anim", "targetname" );
    thread turkey_shoot_patrol();
    thread turkey_shoot_drone();

    foreach ( var_3 in var_0 )
    {
        var_3.animname = var_3.script_noteworthy;
        var_3.script_noteworthy = "enemy_turkey_1";
        var_3 maps\_utility::set_allowdeath( 1 );
        var_3.ignoreall = 1;
        var_3.canreact = 1;
        var_3 _meth_8041( "gunshot" );
        var_3 _meth_8041( "gunshot_teammate" );
        var_3 _meth_8041( "explode" );
        var_3 thread turkey_listen();

        if ( var_3.animname == "rappeler1" || var_3.animname == "rappeler2" )
        {
            var_3.canreact = 0;
            var_3 thread turkey_boost_assist();
        }

        if ( var_3.animname == "gearguy2" )
        {
            var_1 thread turkey_enemy_anim_loop( var_3 );
            continue;
        }

        var_1 thread turkey_enemy_anim( var_3 );
    }

    common_scripts\utility::flag_wait( "wakeup_turkey" );
    level.ilana.ignoreall = 0;
    level.cormack.ignoreall = 0;
    level.ilana thread turkey_shoot_open_fire();
    level.cormack thread turkey_shoot_open_fire();
    var_5 = getent( "VOL_turkey_shoot", "targetname" );
    var_6 = maps\_utility::get_living_ai_array( "enemy_turkey_1", "script_noteworthy" );
    var_7 = [];

    foreach ( var_3 in var_6 )
    {
        var_3 _meth_81A9( var_5 );
        var_3.ignoreall = 0;
        var_3.ignoreme = 0;

        if ( var_3.animname == "rappeler1" || var_3.animname == "rappeler2" )
        {

        }
        else
        {
            var_3 _meth_8141();
            var_3 thread maps\_anim::anim_single_solo( var_3, "turkey_react" );
            waitframe();
            var_3 _meth_83C7( var_3 maps\_utility::getanim( "turkey_react" ), 4 );
        }

        if ( var_3.animname == "rappeler1" || var_3.animname == "gearguy2" )
        {
            var_7 = common_scripts\utility::add_to_array( var_7, var_3 );
            continue;
        }

        var_3 _meth_8177( "top_guys" );
        var_3.accuracy *= 0.5;
        var_3.baseaccuracy *= 0.5;
    }

    if ( var_7.size > 0 )
    {
        level.ilana thread execute_ai_solo( var_7[0], 0.6, 6, 1, 1 );

        if ( var_7.size == 2 )
            level.cormack thread execute_ai_solo( var_7[1], 0.6, 6, 1, 1 );
        else
            level.cormack thread execute_ai_solo( var_7[0], 0.6, 6, 1, 1 );
    }

    setignoremegroup( "top_guys", "friendlies" );
    setignoremegroup( "friendlies", "top_guys" );
    wait 2;
    var_6 = maps\_utility::get_living_ai_array( "enemy_turkey_1", "script_noteworthy" );

    foreach ( var_3 in var_6 )
    {
        if ( var_3.animname == "rappeler1" || var_3.animname == "gearguy2" )
            var_3 _meth_8052();
    }

    maps\_utility::clearthreatbias( "top_guys", "friendlies" );
    var_12 = maps\_utility::get_living_ai_array( "enemy_turkey_1", "script_noteworthy" );
    maps\_utility::waittill_dead_or_dying( var_12 );
    level notify( "turkey_done" );
    thread maps\_utility::autosave_by_name_silent( "wakeup_turkey" );
    maps\_utility::activate_trigger_with_targetname( "TRIG_move_reso_wall" );
    var_0 = maps\_utility::get_living_ai_array( "turkey_walker", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_utility::waittill_dead_or_dying( var_0 );

    maps\_utility::activate_trigger_with_targetname( "TRIG_move_to_bridge" );
}

turkey_enemy_anim_loop( var_0 )
{
    level endon( "wakeup_turkey" );
    var_0 endon( "death" );
    maps\_anim::anim_loop_solo( var_0, "turkey_shoot", "wakeup_turkey" );
}

turkey_enemy_anim( var_0 )
{
    level endon( "wakeup_turkey" );
    var_0 endon( "death" );
    maps\_anim::anim_single_solo( var_0, "turkey_shoot" );
    maps\_anim::anim_loop_solo( var_0, "turkey_shoot_idle" );
}

turkey_boost_assist()
{
    level endon( self.animname );
    self endon( "death" );
    var_0 = 0;
    var_1 = undefined;
    maps\_utility::set_allowdeath( 0 );

    for (;;)
    {
        self waittill( "single anim", var_2 );

        switch ( var_2 )
        {
            case "boost_assist":
                if ( !isdefined( var_1 ) )
                {
                    var_1 = common_scripts\utility::spawn_tag_origin();
                    var_1.origin = self gettagorigin( "j_spinelower" );
                    var_1.angles += ( 90, 333.435, -26.5651 );
                    var_1 _meth_804D( self );
                }

                var_3 = playfxontag( level._effect["alternate_jump"], var_1, "tag_origin" );
                soundscripts\_snd::snd_message( "cave_npc_boost_assist", self );
                break;
            case "ground_touchdown":
                var_0++;

                if ( var_0 == 1 )
                    thread allow_death_timer();

                if ( var_0 == 2 )
                    thread turkey_boost_logic();

                if ( !isdefined( var_1 ) )
                {
                    var_1 = common_scripts\utility::spawn_tag_origin();
                    var_1.origin = self gettagorigin( "j_spinelower" );
                    var_1.angles += ( 90, 333.435, -26.5651 );
                    var_1 _meth_804D( self );
                }

                var_3 = playfxontag( level._effect["alternate_jump"], var_1, "tag_origin" );
                soundscripts\_snd::snd_message( "cave_npc_boost_assist_land", self );
                break;
            case "end":
                level notify( self.animname );
                var_1 delete();
                break;
        }
    }
}

allow_death_timer()
{
    self endon( "death" );
    wait 3;
    maps\_utility::set_allowdeath( 1 );
}

turkey_boost_logic()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    maps\_anim::anim_single_solo( self, "turkey_react" );
}

turkey_listen()
{
    self endon( "death" );
    self waittill( "ai_event", var_0 );

    if ( var_0 == "gunshot" || var_0 == "gunshot_teammate" || var_0 == "explode" )
        common_scripts\utility::flag_set( "wakeup_turkey" );
}

turkey_shoot_patrol()
{
    level endon( "wakeup_turkey" );
    var_0 = getent( "VOL_turkey_patrol_start", "targetname" );
    var_1 = undefined;

    if ( level.nextgen )
        var_1 = maps\_utility::array_spawn_targetname( "turkey_walker", 1 );
    else
        var_1 = maps\_utility::array_spawn_targetname_cg( "turkey_walker", 1, 0.1 );

    foreach ( var_3 in var_1 )
    {
        var_3.ignoreall = 1;
        var_3.ignoreme = 1;
        var_3.ignoresuppression = 1;
        var_3 thread turkey_patrol_logic();
        var_3.animname = var_3.script_noteworthy;
        var_3.script_noteworthy = "turkey_walker";
        var_3 _meth_81A9( var_0 );
        var_3 maps\_utility::set_allowdeath( 1 );
        var_3 thread maps\_anim::anim_loop_solo( var_3, "turkey_shoot_idle", "stop_loop" );
    }

    level waittill( "start_patrol" );
    var_0 = getent( "VOL_pod_back_group", "targetname" );
    var_1 = maps\_utility::get_living_ai_array( "turkey_walker", "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        var_3 _meth_8141();
        var_3.animname = "generic";
        var_3 maps\_utility::set_run_anim( "stealth_walk" );
        var_3 _meth_81A9( var_0 );
    }
}

turkey_patrol_logic()
{
    self endon( "death" );
    var_0 = getent( "VOL_turkey_shoot", "targetname" );
    var_1 = getent( "VOL_patrol", "targetname" );
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    self _meth_8141();

    if ( self _meth_80A9( var_0 ) )
    {
        maps\_utility::clear_run_anim();
        self.ignoreme = 0;
        self.ignoreall = 0;
        self _meth_81A9( var_0 );
    }

    wait 5;
    maps\_utility::clear_run_anim();
    self.ignoreme = 0;
    self.ignoreall = 0;
    self _meth_81A9( var_1 );
}

turkey_timer()
{
    self waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "wakeup_turkey" );
}

turkey_shoot_open_fire()
{
    self.oldacc = self.accuracy;
    self.oldbase = self.baseaccuracy;
    self.oldgrenade = self.grenadeammo;
    self.baseaccuracy = 100000;
    self.accuracy = 100000;
    self.grenadeammo = 0;
    self.ignoresuppression = 1;
    level waittill( "turkey_done" );
    self.baseaccuracy = self.oldbase;
    self.accuracy = self.oldacc;
    self.grenadeammo = self.oldgrenade;
    self.ignoresuppression = 0;
    thread maps\_utility::enable_cqbwalk();
}

turkey_shoot_dialog()
{
    level endon( "wakeup_turkey" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    common_scripts\utility::flag_wait_all( "say_movement_ahead", "say_light_off" );
    wait 1.3;
    thread turkey_complain();
    thread turkey_drone();
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_holdfire2" );
    common_scripts\utility::flag_wait( "cormack_turkey_talk_hold" );
    wait 1;
    level notify( "enemy_talk" );
    wait 2;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_holdshot2" );
    wait 4;
    level notify( "leave_exit" );
    level notify( "start_patrol" );
    common_scripts\utility::flag_set( "patrol_moves" );
    level.ilana maps\_utility::smart_radio_dialogue( "crsh_iln_groupleaving" );
    wait 1;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_cleanuprest" );
    wait 0.75;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_waitforem" );
    wait 3;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_twoontop" );
    wait 1;
    level notify( "take_the_shot" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_onyourshot" );
    thread turkey_anim_nag();
    wait 5;
    maps\_utility::smart_radio_dialogue( "crsh_crmk_takeshot" );
}

turkey_complain()
{
    level endon( "take_the_shot" );
    var_0 = getent( "VOL_turkey_shoot", "targetname" );
    level waittill( "turkey_done" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    if ( var_1.size > 0 )
        maps\_utility::waittill_dead( var_1 );

    wait 2;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_quicktrigger" );
    maps\_utility::activate_trigger_with_targetname( "pod_move_up_3" );
}

turkey_anim_nag()
{
    level endon( "wakeup_turkey" );
    var_0 = getent( "VOL_turkey_bottom_guys", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
    var_2 = 1;

    while ( var_2 )
    {
        if ( level.player _meth_8340() > 0.5 )
        {
            foreach ( var_4 in var_1 )
            {
                if ( level.player _meth_8214( var_4.origin, 65, 100 ) )
                    var_2 = 0;
            }
        }

        waitframe();
    }

    maps\_utility::smart_radio_dialogue_interrupt( "crsh_crmk_notwoontop" );
}

turkey_shoot_enemy_dialog()
{
    level endon( "wakeup_turkey" );
    common_scripts\utility::flag_wait( "say_movement_ahead" );
    level waittill( "enemy_talk" );
    var_0 = maps\_utility::get_living_ai_array( "enemy_turkey_1", "script_noteworthy" );

    if ( isdefined( var_0[1] ) )
        var_0[1] maps\_utility::smart_dialogue( "crsh_as3_nosignal" );

    wait 2;

    if ( isdefined( var_0[1] ) )
        var_0[1] maps\_utility::smart_dialogue( "crsh_as3_scrambingwarbirds" );

    wait 2;

    if ( isdefined( var_0[1] ) )
        var_0[1] maps\_utility::smart_dialogue( "crsh_as3_othersquads" );
}

turkey_drone()
{
    var_0 = getent( "temp_drone_test", "targetname" );
    var_0.animname = "drone";
    var_0 maps\_anim::setanimtree();
    var_1 = common_scripts\utility::getstruct( "drone_path_01", "targetname" );
    var_2 = common_scripts\utility::getstruct( "drone_path_02", "targetname" );
    var_3 = common_scripts\utility::getstruct( "drone_path_03", "targetname" );
    var_4 = common_scripts\utility::getstruct( "drone_path_04", "targetname" );
    var_5 = common_scripts\utility::getstruct( "drone_path_05", "targetname" );
    var_6 = common_scripts\utility::getstruct( "drone_path_06", "targetname" );
    var_7 = common_scripts\utility::getstruct( "drone_path_07", "targetname" );
    var_8 = 2;
    var_9 = 2;
    var_10 = 2;
    var_11 = 2;
    var_12 = 1;
    var_13 = 1;
    var_14 = 1;
    common_scripts\utility::flag_wait_either( "wakeup_turkey", "patrol_moves" );
    var_15 = var_0 common_scripts\utility::spawn_tag_origin();
    var_0 _meth_804D( var_15 );
    var_0 thread maps\_anim::anim_loop_solo( var_0, "drone_release_loop" );
    playfxontag( level._effect["geo_scanner"], var_15, "tag_origin" );
    var_15 _meth_82AE( var_1.origin, var_8, 0.25 );
    wait(var_8);
    var_15 _meth_82AE( var_2.origin, var_9, 0 );
    wait(var_9);
    var_15 _meth_82AE( var_3.origin, var_10, 0 );
    wait(var_10);
    var_15 _meth_82AE( var_4.origin, var_11, 0 );
    wait(var_11);
    var_15 _meth_82AE( var_5.origin, var_12, 0 );
    wait(var_12);
    var_15 _meth_82AE( var_6.origin, var_13, 0 );
    wait(var_13);
    var_15 _meth_82AE( var_7.origin, var_14, 0 );
    wait(var_14);
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    killfxontag( level._effect["geo_scanner"], var_15, "tag_origin" );
    var_0 _meth_804F();
    var_0 delete();
    var_15 delete();
}

ice_bridge_goons()
{
    var_0 = getent( "VOL_ice_bridge_shelf", "targetname" );
    common_scripts\utility::flag_wait( "flag_turkey_goons" );
    test_zipline();
    var_1 = maps\_utility::get_living_ai_array( "zipper", "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 _meth_81A9( var_0 );
}

bridge_rappel_squad()
{
    common_scripts\utility::flag_wait( "FLAG_caves_goliath" );
    thread maps\_utility::autosave_by_name( "turkey_done" );
    common_scripts\utility::flag_set( "big_cave_done" );
    var_0 = getent( "VOL_pre_ice_bridge2", "targetname" );
    var_1 = undefined;

    if ( level.nextgen )
        var_1 = maps\_utility::array_spawn_targetname( "enemy_rappel_squad_00", 1 );
    else
        var_1 = maps\_utility::array_spawn_targetname_cg( "enemy_rappel_squad_00", 1, 0.1 );

    var_2 = common_scripts\utility::getstruct( "csh_rappel_bridge_anim", "targetname" );

    foreach ( var_4 in var_1 )
    {
        var_4.animname = "rappeler2";
        var_4 thread boost_script_ender();
        var_4 thread turkey_boost_assist();
        var_2 thread maps\_anim::anim_single_solo( var_4, "turkey_shoot" );
        waitframe();
        var_4 _meth_83C7( %crash_turkey_shoot_rappeler2, 2 );
        var_4 _meth_81A9( var_0 );
        var_4 maps\_utility::set_allowdeath( 1 );
        var_4.ignoresuppression = 1;
        var_4.grenadeammo = 0;
    }

    var_6 = maps\_utility::get_living_ai_array( "zipper", "script_noteworthy" );
    var_4 = maps\_utility::get_living_ai( "pod_rappel", "script_noteworthy" );

    if ( isdefined( var_4 ) )
        var_6 = common_scripts\utility::array_add( var_6, var_4 );

    maps\_utility::waittill_dead( var_6 );
    maps\_utility::activate_trigger_with_targetname( "ally_ice_bridge_run" );
    wait 2;

    if ( !common_scripts\utility::flag( "goliath_prep_fall" ) )
        level.ilana thread maps\_utility::smart_radio_dialogue( "crsh_iln_exitahead" );
}

boost_script_ender()
{
    self endon( "death" );
    wait 6.5;
    self _meth_8141();
}

test_zipline()
{
    var_0 = getent( "test_zipper_01", "targetname" );
    var_1 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_0, "zipline_test_start" );
    var_1.grenadeammo = 0;
    wait 0.5;
    var_0 = getent( "test_zipper_02", "targetname" );
    var_2 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_0, "zipline_test_start_02" );
    var_2.grenadeammo = 0;
}

rappel_vo_callouts()
{
    level endon( "player_up_close" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_openfire7" );
}

cave_shake_effects()
{
    while ( !common_scripts\utility::flag( "drop_pod_shake_stop" ) )
    {
        _func_234( level.player.origin, 5, 4, 6, 0.75, 0, 0.25, 1000, 9, 3, 1 );
        level.player _meth_80AD( "damage_light" );
        soundscripts\_snd::snd_message( "drop_pod_screen_shake" );
        wait(randomfloatrange( 4, 11 ));
    }
}

big_cave_cleanup()
{
    common_scripts\utility::flag_wait( "goliath_change_anim" );
    var_0 = getent( "vol_big_cave", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.script_noteworthy != "kool_aid" )
        {
            if ( maps\_utility::player_can_see_ai( var_3 ) )
            {
                var_3 thread magic_bullet_kill();
                continue;
            }

            var_3 delete();
        }
    }
}

magic_bullet_kill()
{
    self _meth_8052();
}

begin_ice_bridge()
{
    thread ice_bridge_kill_fall();
    thread new_goliath_moment();
    thread goliath_dialog();
    thread new_cormack_bridge_anim();
    thread new_ilana_bridge_anim();
    common_scripts\utility::flag_set( "goliath_exit_dot_start" );
    common_scripts\utility::flag_wait( "ice_bridge_done" );
    maps\_utility::battlechatter_on( "allies" );
}

new_goliath_moment()
{
    common_scripts\utility::flag_wait( "player_up_close" );
    common_scripts\utility::flag_set( "goliath_exit_dot_end" );
    thread maps\crash_fx::goliath_entry_ice();
    maps\_utility::battlechatter_off( "allies" );
    level.player maps\_player_high_jump::disable_high_jump();
    level.player _meth_8485( 0 );
    level.player _meth_848D( 0 );
    level.player maps\crash_utility::disable_exo_melee();
    level.player _meth_8130( 0 );
    level.player _meth_831F();
    level.player thread maps\_player_exo::player_exo_deactivate();
    thread new_golaith_anim();
    thread new_player_bridge_anim();
    thread bridge_collapse_anim();
}

new_golaith_anim()
{
    var_0 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    var_1 = getent( "kool_aid", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.health = 1000000;
    var_2.animname = "goliath";
    level.goliath = var_2;
    var_2 thread goliath_disable_threat();
    var_2 thread goliath_distance();
    var_3 = getent( "test_player_node", "targetname" );
    level.smash_spot = common_scripts\utility::spawn_tag_origin();
    level.smash_spot.origin = var_2 gettagorigin( "tag_sync" );
    level.smash_spot.angles = var_2 gettagangles( "tag_sync" );
    level.smash_spot _meth_804D( var_2, "tag_sync" );
    thread player_knockdown();
    soundscripts\_snd::snd_message( "goliath_land", var_2 );
    var_0 thread maps\_anim::anim_single_solo( var_2, "goliath_bridge_surprise" );
    common_scripts\utility::flag_wait( "goliath_change_anim" );
    var_2 thread maps\_anim::anim_single_solo( var_2, "goliath_bridge_smash" );
    self notify( "bridge_stop_run_fx" );
    var_4 = 1;
    var_5 = 1;
    var_6 = maps\_utility::spawn_anim_model( "goliath_rig" );
    var_6 maps\_anim::setanimtree();
    var_6 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_6, "goliath_bridge_throw" );
    var_7 = var_2 common_scripts\utility::spawn_tag_origin();
    var_2 _meth_804D( var_7 );
    wait(var_5);
    var_7 _meth_82AE( var_6.origin, var_4 );
    wait(var_4);
    var_2 _meth_804F();
    var_2 waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "friendlies_move" );
    var_2 thread goliath_rocket_logic();
    thread goliath_pass( var_0, var_2 );
    var_0 maps\_anim::anim_single_solo( var_2, "goliath_bridge_throw" );
    thread goliath_fail( var_0, var_2 );
}

goliath_disable_threat()
{
    common_scripts\utility::flag_wait( "goliath_change_anim" );
    self _meth_84ED( "disable" );
}

goliath_rocket_logic()
{
    self waittillmatch( "single anim", "fire_missiles" );
    maps\crash_utility::mech_fire_rockets_special( level.ilana );
    thread maps\crash_fx::bridge_soot();
}

goliath_fail( var_0, var_1 )
{
    if ( !common_scripts\utility::flag( "start_reso_move" ) )
    {
        common_scripts\utility::flag_set( "goliath_fail_flag" );
        var_0 thread maps\_anim::anim_single_solo( var_1, "goliath_bridge_throw2" );
        wait 3.5;
        level.player _meth_8052();
    }
}

goliath_pass( var_0, var_1 )
{
    common_scripts\utility::flag_wait( "cormack_throw_moment" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "goliath_bridge_explode" );
    var_1 waittillmatch( "single anim", "bridge_explodes" );
    common_scripts\utility::flag_set( "bridge_explode" );
    var_2 = maps\_utility::spawn_anim_model( "ice_bridge_rock" );
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3 _meth_80B1( "csh_ice_lrg_rock_01" );
    var_3 _meth_804D( var_2, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_0 thread maps\_anim::anim_loop_solo( var_2, "rock_collapse" );
    var_1 setcontents( 0 );
    var_1 waittillmatch( "single anim", "end" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "goliath_bridge_death" );
    var_1 disableaimassist();
}

goliath_explode_logic_timer()
{
    self waittillmatch( "single anim", "end" );
    common_scripts\utility::flag_set( "golaith_throw_anim_done" );
}

new_player_bridge_anim()
{
    level.player endon( "death" );
    var_0 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "rig" );
    var_1 hide();
    var_2 = maps\_utility::spawn_anim_model( "ice_bridge_reso" );
    var_2 hide();
    var_3 = maps\_utility::spawn_anim_model( "ice_bridge_gun" );
    var_3 hide();
    var_4 = level.scr_anim["ice_bridge_reso"]["reso_device_fall"];
    var_0 maps\_anim::anim_first_frame_solo( var_2, "reso_device_fall" );
    common_scripts\utility::flag_wait( "goliath_change_anim" );

    if ( isalive( level.player ) )
    {
        _func_0D3( "ammoCounterHide", 1 );
        _func_0D3( "actionSlotsHide", 1 );
        level.player _meth_830F( "iw5_kvahazmatknife_sp" );
        level.player _meth_817D( "stand" );
        level.player _meth_8119( 0 );
        level.player _meth_811A( 0 );
    }

    var_1.origin = level.goliath gettagorigin( "tag_sync" );
    var_1.angles = level.goliath gettagangles( "tag_sync" );
    var_1 _meth_804D( level.goliath, "tag_sync" );
    common_scripts\utility::flag_set( "start_smash" );
    level.smash_spot thread maps\_anim::anim_single_solo( var_1, "player_bridge_smash" );
    level.player _meth_831D();
    level.player _meth_8080( var_1, "tag_player", 0.25 );
    level.player thread watch_tappy_progress();
    wait 0.25;
    level.player _meth_80AE( "hijack_plane_medium" );
    thread earthquake_notify_stop( 0.2, 0.5, level.player.origin, 1000, 0.5 );
    var_1 show();
    level.player _meth_807D( var_1, "tag_player", 1.0, 15, 15, 30, 15, 1 );
    var_1 waittillmatch( "single anim", "end" );
    var_1 _meth_804F();
    var_0 thread maps\_anim::anim_single_solo( var_1, "player_bridge_throw" );
    level.player _meth_807D( var_1, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    level.player _meth_80AF( "hijack_plane_medium" );
    level notify( "stop_earthquake" );
    thread pass_tappy();
    common_scripts\utility::flag_wait( "friendlies_move" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "reso_device_fall" );
    var_0 thread maps\_anim::anim_single_solo( var_3, "gun_fall" );
    var_2 show();
    var_3 show();
    thread get_forward_movement();
    var_1 thread bridge_player_notetrack_handler( var_1 );
    thread goliath_handle_death( var_1, var_2 );
    thread goliath_player_rumbles();
    clearallcorpses();
    var_5 = level.scr_anim["rig"]["player_bridge_throw"];
    var_1 _meth_8111( "bridge_player", var_5, 1, 0, 1 );
    var_1 _meth_8117( var_5, 0 );
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;

    while ( var_6 < 1 && !common_scripts\utility::flag( "cormack_throw_moment" ) )
    {
        wait 0.05;

        if ( var_7 <= 0 )
            var_7 = 0;

        if ( common_scripts\utility::flag( "waiting_for_input" ) )
            var_7 = 0;
        else
            var_7 = 1;

        if ( isalive( level.player ) )
        {
            var_6 = var_1 _meth_814F( var_5 );
            var_9 = var_2 _meth_814F( var_4 );
            var_1 _meth_8111( "bridge_player", var_5, 1, 0, clamp( abs( var_7 ), 0, 1 ) );
            var_2 _meth_8111( "bridge_player", var_4, 1, 0, clamp( abs( var_7 ), 0, 1 ) );
        }
    }

    level.player _meth_80AD( "damage_heavy" );
    level notify( "input_done" );
    level notify( "player_normal_movement" );
    common_scripts\utility::flag_set( "obj_reso_move_end" );
    common_scripts\utility::flag_wait( "bridge_explode" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "reso_device_explode" );
    thread maps\crash_fx::bridge_explosion();
    level notify( "end_upper_trigger" );
    thread explosion_player_rumbles();
    level.narrow_animnode = common_scripts\utility::getstruct( "csh_narrow_anim_node", "targetname" );
    var_0 maps\_anim::anim_single_solo( var_1, "player_bridge_explode" );
    maps\_utility::stop_exploder( 2978 );
    var_1 hide();
    common_scripts\utility::flag_set( "crash_lighting_goliath_pit" );
    level.player _meth_804F();
    var_1 delete();
    level.player_weapons = level.player _meth_830B();

    foreach ( var_11 in level.player_weapons )
        level.player _meth_8332( var_11 );

    level.player _meth_831E();
    level.player _meth_8119( 1 );
    level.player _meth_8130( 1 );

    if ( !isdefined( level.player.water_depth ) )
        level.player _meth_811A( 1 );

    level.player maps\_player_high_jump::enable_high_jump();
    level.player _meth_8485( 1 );
    level.player _meth_848D( 1 );
    level.player maps\crash_utility::enable_exo_melee();
    level.player thread maps\_player_exo::player_exo_activate();
    _func_0D3( "ammoCounterHide", 0 );
    _func_0D3( "actionSlotsHide", 0 );
    thread narrow_cave_player();
}

pass_tappy()
{
    wait 1;

    if ( level.player.mech_grapple_tappy_pressed < 3 )
        level.player _meth_8052();
}

earthquake_notify_stop( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_5 ) )
        var_5 = "stop_earthquake";

    level notify( var_5 );
    level endon( var_5 );

    for (;;)
    {
        _func_234( level.player.origin, var_0, 0, 0, var_1, 0, 0, 1000, 0, 0, var_4 );
        wait(var_1);
    }
}

goliath_handle_death( var_0, var_1 )
{
    level endon( "ice_bridge_done" );
    level.player waittill( "death" );
    level.player _meth_804F();
    var_0 delete();
    var_1 delete();
}

goliath_player_rumbles()
{
    wait 0.5;
    level.player shellshock( "crash_goliath_hit", 1, undefined, undefined );
    wait 1.5;
    thread handle_rumble_and_screenshake( 3, 4, 0.5, "", 1000 );
    wait 2;
    thread handle_rumble_and_screenshake( 2, 3, 0.5, "", 1000 );
    wait 1.2;
    thread handle_rumble_and_screenshake( 2, 5, 1, "", 1000 );
    wait 1.25;
    thread handle_rumble_and_screenshake( 1, 2, 0.5, "", 1000 );
    wait 0.75;
    thread handle_rumble_and_screenshake( 2, 2, 0.5, "", 1000 );
    wait 3;
    thread handle_rumble_and_screenshake( 1, 2, 0.5, "", 1000 );
}

explosion_player_rumbles()
{
    thread handle_rumble_and_screenshake( 1, 5, 2, "hijack_plane_medium", 1000 );
    wait 1.25;
    thread handle_rumble_and_screenshake( 1, 4, 0.5, "hijack_plane_medium", 1000 );
    wait 1;
    thread handle_rumble_and_screenshake( 2, 3, 0.5, "", 1000 );
    wait 4.5;
    var_0 = getent( "ice_bridge_fall_player", "targetname" );
    var_0 delete();
    var_1 = getent( "ice_bridge_fall_other", "targetname" );
    var_1 delete();
    thread handle_rumble_and_screenshake( 5, 10, 1.5, "hijack_plane_medium", 1000 );
    wait 2.75;
    level.player shellshock( "crash_goliath_hit", 3, undefined, undefined );
    maps\_utility::lerp_fov_overtime( 1, 65 );
}

new_cormack_bridge_anim()
{
    var_0 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    thread cormack_bridge_intro( var_0 );
    common_scripts\utility::flag_wait( "player_up_close" );
    var_0 notify( "goliath_jump" );
    wait 0.2;
    level.cormack notify( "stop personal effect" );
    level.cormack maps\_utility::anim_stopanimscripted();
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = level.cormack.origin;
    var_1.angles = ( 0, 210, 0 );
    var_1 thread maps\_anim::anim_single_solo( level.cormack, "cormack_bridge_surprise" );
    level.cormack maps\_utility::forceuseweapon( "iw5_maul_sp", "primary" );
    common_scripts\utility::flag_wait( "friendlies_move" );
    var_1 delete();
    var_0 thread maps\_anim::anim_single_solo( level.cormack, "cormack_bridge_smash" );
    wait 14;
    level.cormack maps\_utility::forceuseweapon( "iw5_titan45_sp", "primary" );
    common_scripts\utility::flag_wait_any( "cormack_throw_moment", "goliath_fail_flag" );

    if ( common_scripts\utility::flag( "cormack_throw_moment" ) )
        var_0 thread maps\_anim::anim_single_solo( level.cormack, "cormack_bridge_throw" );
    else
        var_0 thread maps\_anim::anim_single_solo( level.cormack, "cormack_bridge_throw2" );

    common_scripts\utility::flag_wait( "bridge_explode" );
    level.cormack maps\_utility::forceuseweapon( "iw5_bal27_sp", "primary" );
    level.cormack.lastweapon = level.cormack.weapon;
    var_0 maps\_anim::anim_single_solo( level.cormack, "friendly_bridge_explode" );
    level.cormack thread narrow_cave_cormack();
}

cormack_bridge_intro( var_0 )
{
    level endon( "player_up_close" );
}

new_ilana_bridge_anim()
{
    var_0 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    common_scripts\utility::flag_wait( "friendlies_move" );
    level.ilana notify( "stop personal effect" );
    var_0 maps\_anim::anim_single_solo( level.ilana, "ilana_bridge_throw" );
    common_scripts\utility::flag_wait( "bridge_explode" );
    var_0 maps\_anim::anim_single_solo( level.ilana, "friendly_bridge_explode" );
    thread maps\_utility::autosave_by_name( "ice_bridge_done" );
    common_scripts\utility::flag_set( "ice_bridge_done" );
    level.ilana thread narrow_cave_ilana();
}

new_reso_anim()
{
    var_0 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    var_1 = maps\_utility::spawn_anim_model( "ice_bridge_reso" );
    var_1 hide();
    var_2 = level.scr_anim["ice_bridge_reso"]["reso_device_fall"];
    var_0 maps\_anim::anim_first_frame_solo( var_1, "reso_device_fall" );
    common_scripts\utility::flag_wait( "friendlies_move" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "reso_device_fall" );
    var_1 show();
    var_1 waittillmatch( "single anim", "end" );
    var_0 maps\_anim::anim_single_solo( var_1, "reso_device_explode" );
}

bridge_player_notetrack_handler( var_0 )
{
    level.player endon( "death" );
    level endon( "input_done" );

    for (;;)
    {
        self waittill( "bridge_player", var_1 );

        if ( isalive( level.player ) )
        {
            switch ( var_1 )
            {
                case "unhide_reso_device":
                    level notify( "show_reso_device" );
                    break;
                case "wait_for_player_input":
                    common_scripts\utility::flag_set( "waiting_for_input" );
                    level.input_bool = 1;
                    level.player _meth_807D( var_0, "tag_player", 1.0, 5, 5, 35, 5, 1 );
                    thread handle_rumble_and_screenshake( 1, 3, 0.5, "", 100 );
                    common_scripts\utility::flag_set( "obj_reso_move_start" );
                    break;
                case "wait_for_player_to_hit_x":
                    common_scripts\utility::flag_set( "waiting_for_input" );
                    level notify( "player_normal_movement" );
                    waitframe();
                    level.player notify( "grab_device" );
                    common_scripts\utility::flag_set( "start_reso_move" );
                    common_scripts\utility::flag_clear( "waiting_for_input" );
                    common_scripts\utility::flag_set( "goliath_dof_set" );
                    level.player _meth_807D( var_0, "tag_player", 1.0, 15, 15, 35, 5, 1 );
                    common_scripts\utility::flag_set( "cormack_throw_moment" );
                    break;
                case "start_reso_detonation_sequence":
                    break;
            }
        }
    }
}

get_x_button()
{
    level.player _meth_82DD( "grab_device", "+usereload" );
    thread get_forward_movement_grab();
    thread input_hint_use( 0.25 );
    level.player waittill( "grab_device" );
    level notify( "stop_hint" );
    maps\_utility::hint_fade();
    common_scripts\utility::flag_set( "start_reso_move" );
    common_scripts\utility::flag_clear( "waiting_for_input" );
}

get_forward_movement_grab()
{
    waitframe();
    level.player endon( "grab_device" );

    for (;;)
    {
        var_0 = level.player _meth_82F3();
        var_1 = var_0[0];

        if ( var_1 > 0 )
        {
            level.player notify( "grab_device" );
            break;
        }

        waitframe();
    }
}

bridge_collapse_anim()
{
    common_scripts\utility::flag_wait( "friendlies_move" );
    var_0 = getent( "ice_bridge_model", "targetname" );
    var_0.animname = "goliath_ice_bridge";
    var_0 maps\_anim::setanimtree();
    var_1 = common_scripts\utility::getstruct( "csh_goliath_anim_node", "targetname" );
    var_1 maps\_anim::anim_single_solo( var_0, "bridge_throw" );
    common_scripts\utility::flag_wait( "bridge_explode" );
    var_2 = getentarray( "ice_bridge_init", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 delete();

    thread maps\crash_fx::bridge_chunks();
    thread maps\crash_fx::bridge_screenfx();
    thread maps\crash_fx::far_explode();
    var_1 maps\_anim::anim_single_solo( var_0, "bridge_collapse" );
}

goliath_dialog()
{
    common_scripts\utility::flag_wait( "FLAG_caves_goliath" );
    common_scripts\_exploder::exploder( 2978 );
    common_scripts\utility::flag_set( "drop_pod_shake_stop" );
    common_scripts\utility::flag_wait( "player_up_close" );
    wait 1;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_watchout3" );
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_ast2" );
    common_scripts\utility::flag_wait( "start_smash" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_gotmitch" );
    wait 1;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_watchfire2" );
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_donthaveshot" );
    common_scripts\utility::flag_wait( "friendlies_move" );
    wait 3;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_mitchelllll" );
    wait 1;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_getdown8" );
    wait 3;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_blowbridge" );
    wait 3.8;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_aaaaaaaah" );
    common_scripts\utility::flag_wait( "bridge_explode" );
    wait 1;
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_cormackkkk" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_holdon9" );
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_gotyou2" );
    wait 3;
    wait 0.25;
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_aaahhh" );
    wait 12;
}

watch_tappy_progress()
{
    self endon( "death" );
    self endon( "bridge_explode" );
    self _meth_82DD( "mech_tappy_button_pressed", "+usereload" );
    self _meth_82DD( "mech_tappy_button_pressed", "+activate" );
    self.mech_grapple_tappy_pressed = 0;
    thread maps\_utility::hintdisplayhandler( "player_tappy_gamepad" );

    for (;;)
    {
        self waittill( "mech_tappy_button_pressed" );
        self.mech_grapple_tappy_pressed++;
    }
}

should_break_tappy_hint()
{
    return common_scripts\utility::flag( "friendlies_move" );
}

ice_bridge_kill_fall()
{
    level endon( "start_smash" );
    common_scripts\utility::flag_wait( "FLAG_ice_bridge_kill_player" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
}

player_knockdown()
{
    soundscripts\_snd::snd_message( "player_knockdown" );
    level.player _meth_81E1( 0.4 );
    level.player _meth_8301( 0 );
    level.player _meth_8304( 0 );
    wait 1.23;
    level.player _meth_80AD( "damage_heavy" );
    _func_234( level.player.origin, 2, 1, 1, 0.75, 0, 0.25, 1000, 9, 3, 1 );
    wait 1;
    level.player _meth_80AD( "heavy_2s" );
    level.player _meth_81E1( 0.05 );
    _func_234( level.player.origin, 6.5, 4, 4, 0.75, 0, 0.5, 1000, 9, 3, 1 );
    wait 1;
    level.player _meth_81E1( 0.4 );
    level.player _meth_83FE( 5, 2, 2, 3, 2, 0.5, 100, 6, 2, 1 );
    common_scripts\utility::flag_wait( "goliath_change_anim" );
    level.player _meth_81E1( 1 );
    level.player _meth_8301( 1 );
    level.player _meth_8304( 1 );
}

goliath_distance()
{
    self endon( "death" );
    var_0 = self;
    var_1 = var_0.origin;
    var_2 = level.player.origin;
    var_3 = distance2d( var_1, var_2 );
    var_4 = 74;

    while ( var_3 > var_4 )
    {
        var_1 = var_0.origin;
        var_2 = level.player.origin;
        var_3 = distance2d( var_1, var_2 );
        var_4 += 1;
        waitframe();
    }

    common_scripts\utility::flag_set( "goliath_change_anim" );
}

get_forward_movement()
{
    level endon( "player_normal_movement" );
    level.input_bool = 0;
    var_0 = 0;
    var_1 = 2;

    for (;;)
    {
        var_2 = level.player _meth_82F3();
        var_0 = var_2[0];

        while ( var_0 <= 0 )
        {
            var_2 = level.player _meth_82F3();
            var_0 = var_2[0];

            if ( level.input_bool )
            {
                level thread input_hint( var_1 );
                level.input_bool = 0;
            }

            wait 0.05;
        }

        level notify( "stop_hint" );
        level thread maps\_utility::hint_fade();
        level.input_bool = 0;
        var_1 = 5;
        common_scripts\utility::flag_clear( "waiting_for_input" );
        wait 0.05;
    }
}

input_hint( var_0 )
{
    level endon( "player_normal_movement" );
    level endon( "stop_hint" );
    wait(var_0);
    maps\_utility::hintdisplayhandler( "player_move_gamepad" );
}

should_break_move_hint()
{
    return level.player _meth_82F3()[0] > 0.25 || level.player _meth_82F3()[1] > 0.25;
}

input_hint_use( var_0 )
{
    level.player endon( "grab_device" );
    level endon( "stop_hint" );
    wait(var_0);
    level thread maps\_utility::hint( "Press ^3[{+usereload}]^7", 5 );
}

handle_rumble_and_screenshake( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) || isdefined( var_3 ) && var_3 == "" )
        var_3 = "damage_heavy";

    level.player _meth_80AD( var_3 );
}

begin_narrow_cave()
{
    var_0 = getent( "nc_behind_ilona", "targetname" );
    var_0 common_scripts\utility::trigger_off();
    var_1 = getent( "nc_behind_ilona_2", "targetname" );
    var_1 common_scripts\utility::trigger_on();
    level.narrow_animnode = common_scripts\utility::getstruct( "csh_narrow_anim_node", "targetname" );
    level.cave_water_origin = getent( "narrow_cave_origin_underwater", "script_noteworthy" );
    maps\_utility::battlechatter_off( "allies" );
    soundscripts\_snd::snd_music_message( "narrow_cave" );

    if ( level.start_point == "narrow_cave" )
    {
        level.cormack thread narrow_cave_cormack();
        level.ilana thread narrow_cave_ilana();
        thread narrow_cave_player();
    }

    thread narrow_cave_drop_pod();
    thread narrow_cave_cave_in();
    thread narrow_cave_jump_out_fail();
    common_scripts\utility::flag_wait( "narrow_cave_done" );
}

narrow_cave_jump_out_fail()
{
    level endon( "narrow_cave_done" );
    common_scripts\utility::flag_clear( "FLAG_narrow_cave_backtrack" );
    common_scripts\utility::flag_wait( "FLAG_narrow_cave_backtrack" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_CARGO" );
    maps\_utility::missionfailedwrapper();
}

narrow_cave_cormack()
{
    thread maps\_water::watchaienterwater( self );
    level.cormack_pick = spawn( "script_model", level.cormack gettagorigin( "tag_stowed_back" ) );
    level.cormack_pick.angles = level.cormack gettagangles( "tag_stowed_back" );
    level.cormack_pick _meth_804D( level.cormack, "tag_stowed_back" );
    level.cormack_pick _meth_80B1( "weapon_ice_picker_arctic" );
    level.ice_axe = maps\_utility::spawn_anim_model( "ice_axe_scripted" );
    level.narrow_animnode thread maps\_anim::anim_first_frame_solo( level.ice_axe, "narrowcave_water_breach" );
    level.ice_axe hide();
    thread narrow_cave_cormack_teleport_monitor();
    anim_with_teleport( "cormack_can_teleport1", "narrowcave_search", 0.9 );
    common_scripts\utility::flag_set( "narrow_cave_dot_start" );

    if ( !common_scripts\utility::flag( "narrow_cave_enter" ) && !common_scripts\utility::flag( "cormack_can_teleport1" ) )
    {
        anim_with_teleport( "cormack_can_teleport1", "narrowcave_search_enter", 0.9 );

        if ( !common_scripts\utility::flag( "start_narrow_cave" ) && !common_scripts\utility::flag( "cormack_can_teleport1" ) )
            level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_search_idle", "stop_cormack_loop" );

        common_scripts\utility::flag_wait( "start_narrow_cave" );
        level.narrow_animnode notify( "stop_cormack_loop" );

        if ( !common_scripts\utility::flag( "cormack_can_teleport1" ) )
            anim_with_teleport( "cormack_can_teleport1", "narrowcave_search_exit", 0.9 );
    }
    else if ( !common_scripts\utility::flag( "cormack_can_teleport1" ) )
        anim_with_teleport( "cormack_can_teleport1", "narrowcave_search_traverse_sec1", 0.9 );

    var_0 = getanimlength( maps\_utility::getanim( "narrowcave_traverse_sec1" ) );
    maps\_utility::delaythread( var_0 * 0.64, common_scripts\utility::flag_set, "cormack_traverse_sec_1" );
    anim_with_teleport( "cormack_can_teleport2", "narrowcave_traverse_sec1", 0.9 );

    if ( !common_scripts\utility::flag( "narrow_cave_start_2" ) && !common_scripts\utility::flag( "cormack_can_teleport2" ) )
    {
        anim_with_teleport( "cormack_can_teleport2", "narrowcave_sec2_enter", 0.9 );

        if ( !common_scripts\utility::flag( "narrow_cave_start_2" ) && !common_scripts\utility::flag( "cormack_can_teleport2" ) )
            level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_sec2_idle", "stop_cormack_loop" );

        common_scripts\utility::flag_wait( "narrow_cave_start_2" );
        level.narrow_animnode notify( "stop_cormack_loop" );

        if ( !common_scripts\utility::flag( "cormack_can_teleport2" ) )
            anim_with_teleport( "cormack_can_teleport2", "narrowcave_sec2_exit", 0.9 );
    }
    else if ( !common_scripts\utility::flag( "cormack_can_teleport2" ) )
        anim_with_teleport( "cormack_can_teleport2", "narrowcave_sec1_traverse_sec2", 0.9 );

    anim_with_teleport( "cormack_can_teleport3", "narrowcave_sec2_traverse_floodroom", 0.9 );
    common_scripts\utility::flag_set( "cormack_in_chamber" );

    if ( !common_scripts\utility::flag( "cave_in" ) && !common_scripts\utility::flag( "cormack_can_teleport3" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_floodroom_idle", "stop_cormack_loop" );

    common_scripts\utility::flag_wait( "cave_in" );
    level.narrow_animnode notify( "stop_cormack_loop" );
    thread narrow_cave_cormack_cave_in_dialogue();
    anim_with_teleport( "cormack_can_teleport3", "narrowcave_floodroom_break_to_breach", 0.9 );

    if ( !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) && !common_scripts\utility::flag( "cormack_can_teleport3" ) )
    {
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_pre_breach_idle", "stop_cormack_loop" );
        common_scripts\utility::flag_set( "cormack_breach_loop" );
    }

    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );
    self.ignoreall = 1;
    self.allowpain = 0;
    self.ignoresuppression = 1;
    level.narrow_animnode notify( "stop_cormack_loop" );
    var_1 = undefined;

    if ( common_scripts\utility::flag( "cormack_can_teleport3" ) )
    {
        level.narrow_animnode thread maps\_anim::anim_single_solo( self, "narrowcave_floodroom_break_to_breach" );

        if ( isdefined( self.helmet_open ) && self.helmet_open == 1 )
            thread maps\crash_utility::cormack_helmet_close( self );

        wait 0.15;
        self _meth_8117( maps\_utility::getanim( "narrowcave_floodroom_break_to_breach" ), 0.62 );
        self waittillmatch( "single anim", "end" );
    }

    level.narrow_animnode thread maps\_anim::anim_single_solo( self, "narrowcave_water_breach" );
    level.narrow_animnode thread maps\_anim::anim_single_solo( level.ice_axe, "narrowcave_water_breach" );
    self waittillmatch( "single anim", "start_ilona_breach_anim" );
    common_scripts\utility::flag_set( "start_ilona_breach" );
    self waittillmatch( "single anim", "end" );
    level.narrow_animnode maps\_anim::anim_single_solo( self, "narrowcave_water_breach_fire" );
    self.ignoreall = 0;
    maps\_utility::disable_cqbwalk();
    var_2 = common_scripts\utility::spawn_tag_origin();
    self _meth_81A7( var_2 );
    common_scripts\utility::flag_wait( "narrow_cave_done" );
    level.narrow_animnode maps\_anim::anim_single_solo( self, "narrowcave_water_breach_mantle" );
    self.allowpain = 1;
    self.ignoresuppression = 0;
    maps\_utility::enable_ai_color();

    if ( isdefined( var_1 ) )
        var_1 delete();

    var_2 delete();
    self notify( "watchAIEnterWater" );
}

no_interp()
{
    while ( !common_scripts\utility::flag( "narrow_cave_done" ) )
    {
        self _meth_8092();
        wait 0.05;
    }
}

narrow_cave_cormack_cave_in_dialogue()
{
    wait 6.0;

    if ( !common_scripts\utility::flag( "cormack_can_teleport3" ) )
        level.cormack maps\_utility::smart_dialogue( "crsh_crmk_seelight" );

    if ( !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) )
        common_scripts\utility::flag_set( "narrow_cave_dot_update" );

    wait 3.0;

    if ( !common_scripts\utility::flag( "ilona_can_teleport4" ) && !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) && !isdefined( level.player.underwater ) )
        level.ilana maps\_utility::smart_dialogue( "crsh_iln_swimdown" );

    if ( !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) )
        common_scripts\utility::flag_set( "narrow_cave_hint" );
}

narrow_cave_swap_axe( var_0 )
{
    level.ice_axe show();
    level.cormack_pick delete();
    level.ice_axe thread ice_axe_delete_special();
    level.breach_enemy_6 waittillmatch( "single anim", "axe_impact" );
    wait 0.36;
    playfxontag( common_scripts\utility::getfx( "blood_impact_burst" ), level.ice_axe, "tag_fx" );
    level.breach_enemy_6 waittillmatch( "single anim", "end" );
    level.breach_enemy_6.skipdeathanim = 1;
    level.breach_enemy_6.a.nodeath = 1;
    level.breach_enemy_6.forceragdollimmediate = 1;
    level.breach_enemy_6 thread maps\_utility::stop_magic_bullet_shield();
    waitframe();
    level.breach_enemy_6 _meth_8052();
    common_scripts\utility::flag_wait( "combat_cave_done" );

    if ( isdefined( level.ice_axe ) )
        level.ice_axe delete();
}

ice_axe_delete_special()
{
    level endon( "combat_cave_done" );

    for (;;)
    {
        if ( _func_085() )
        {
            if ( isdefined( level.ice_axe ) )
                level.ice_axe delete();
        }

        wait 0.05;
    }
}

narrow_cave_cormack_teleport_monitor()
{
    common_scripts\utility::flag_wait( "player_in_narrow_cave" );

    if ( !level.player _meth_8214( self.origin, 65, 300 ) )
        common_scripts\utility::flag_set( "cormack_can_teleport1" );

    common_scripts\utility::flag_wait( "narrow_cave_in_chamber" );

    if ( !level.player _meth_8214( self.origin, 65, 300 ) )
        common_scripts\utility::flag_set( "cormack_can_teleport2" );

    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );

    if ( !level.player _meth_8214( self.origin, 65, 300 ) )
        common_scripts\utility::flag_set( "cormack_can_teleport3" );
}

narrow_cave_ilana()
{
    thread maps\_water::watchaienterwater( self );

    if ( level.start_point != "narrow_cave" )
        thread maps\crash_fx::cold_breath();

    thread narrow_cave_ilana_teleport_monitor();
    anim_with_teleport( "ilona_can_teleport2", "narrowcave_search", 0.9 );

    if ( !common_scripts\utility::flag( "ilona_can_teleport2" ) && !common_scripts\utility::flag( "narrow_cave_ilona_start_2" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_search_idle", "stop_ilona_loop" );

    common_scripts\utility::flag_wait( "narrow_cave_ilona_start_2" );
    level.narrow_animnode notify( "stop_ilona_loop" );
    anim_with_teleport( "ilona_can_teleport2", "narrowcave_search_traverse_sec1", 0.8 );

    if ( !common_scripts\utility::flag( "move_to_bottleneck_ilona" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_sec1_idle", "stop_ilona_loop" );

    common_scripts\utility::flag_wait( "move_to_bottleneck_ilona" );
    level.narrow_animnode notify( "stop_ilona_loop" );
    anim_with_teleport( "ilona_can_teleport2", "narrowcave_sec1_traverse_sec2", 0.9 );

    if ( !common_scripts\utility::flag( "narrow_cave_in_chamber" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_sec2_idle", "stop_ilona_loop" );

    if ( !common_scripts\utility::flag( "narrow_cave_in_chamber" ) )
    {
        var_0 = getent( "nc_behind_ilona", "targetname" );
        var_0 common_scripts\utility::trigger_on();
    }

    common_scripts\utility::flag_wait( "narrow_cave_in_chamber" );
    wait 1.5;
    level.narrow_animnode notify( "stop_ilona_loop" );
    anim_with_teleport( "ilona_can_teleport4", "narrowcave_sec2_traverse_floodroom", 0.7 );
    common_scripts\utility::flag_set( "ilana_in_chamber" );

    if ( !common_scripts\utility::flag( "narrow_cave_in_chamber" ) )
    {
        var_1 = getent( "nc_behind_ilona_2", "targetname" );
        var_1 common_scripts\utility::trigger_on();
    }

    var_2 = undefined;

    if ( !common_scripts\utility::flag( "cave_in" ) )
    {
        var_2 = common_scripts\utility::spawn_tag_origin();
        self _meth_81A7( var_2 );
    }

    common_scripts\utility::flag_wait( "cave_in" );

    if ( !common_scripts\utility::flag( "ilona_can_teleport4" ) && !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) )
        anim_with_teleport( "ilona_can_teleport4", "narrowcave_break_to_idle_floodroom", 0.9 );

    if ( !common_scripts\utility::flag( "ilona_can_teleport4" ) && !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_idle_floodroom", "stop_ilona_loop" );

    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );
    level.narrow_animnode notify( "stop_ilona_loop" );
    self.ignoreall = 1;
    self.allowpain = 0;
    self.ignoresuppression = 1;
    anim_with_teleport( "start_ilona_breach", "narrowcave_floodroom_to_breach", 0.9 );

    if ( !common_scripts\utility::flag( "start_ilona_breach" ) )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "narrowcave_pre_breach_idle", "stop_ilona_loop" );

    common_scripts\utility::flag_wait( "start_ilona_breach" );
    level.narrow_animnode notify( "stop_ilona_loop" );
    level.narrow_animnode maps\_anim::anim_single_solo( self, "narrowcave_water_breach" );
    level.narrow_animnode maps\_anim::anim_single_solo( self, "narrowcave_water_breach_fire" );
    self.ignoreall = 0;
    maps\_utility::disable_cqbwalk();
    var_3 = common_scripts\utility::spawn_tag_origin();
    self _meth_81A7( var_3 );
    common_scripts\utility::flag_wait( "narrow_cave_done" );
    level.narrow_animnode maps\_anim::anim_single_solo( self, "narrowcave_water_breach_mantle" );
    self.allowpain = 1;
    self.ignoresuppression = 0;
    maps\_utility::enable_ai_color();

    if ( isdefined( var_2 ) )
        var_2 delete();

    var_3 delete();
    self notify( "watchAIEnterWater" );
}

narrow_cave_ilana_teleport_monitor()
{
    common_scripts\utility::flag_wait( "narrow_cave_in_chamber" );

    if ( !level.player _meth_8214( self.origin, 65, 300 ) )
        common_scripts\utility::flag_set( "ilona_can_teleport2" );

    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );

    if ( !level.player _meth_8214( self.origin, 65, 300 ) )
        common_scripts\utility::flag_set( "ilona_can_teleport4" );
}

anim_with_teleport( var_0, var_1, var_2 )
{
    level.narrow_animnode thread maps\_anim::anim_single_solo( self, var_1 );

    while ( !common_scripts\utility::flag( var_0 ) && self _meth_814F( maps\_utility::getanim( var_1 ) ) < var_2 )
        wait 0.05;

    if ( self _meth_814F( maps\_utility::getanim( var_1 ) ) >= var_2 )
        self waittillmatch( "single anim", "end" );
}

narrow_cave_player()
{
    level.underwater_visionset_callback = ::nc_underwater_visionset_change;
    level.water_allow_sprint = 0;
    thread underwater_objective_hack();
    level.player_breath_amount_use_rate = 1.33333;
    wait 0.25;
    level.player _meth_8304( 0 );
    wait 1.25;
    common_scripts\utility::flag_wait( "narrow_cave_enter" );
    thread maps\crash_utility::exo_temp_narrow_cave();
    common_scripts\utility::flag_wait( "narrow_cave_in_chamber" );
    thread player_swim_hint();
    maps\_utility::array_spawn_function_targetname( "underwater_breach_enemies", ::narrow_cave_enemies );
    level.breach_guys = maps\_utility::array_spawn_targetname( "underwater_breach_enemies", 1 );
    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );
    thread maps\_shg_utility::disable_features_entering_cinema( 1 );
    level.player _meth_811C( 0 );

    if ( isdefined( level.player.swimming_arms ) )
        level.player.swimming_arms hide();

    common_scripts\utility::flag_set( "player_starting_uw_breach" );
    common_scripts\utility::flag_set( "lighting_uw_breach_dof" );
    common_scripts\utility::flag_set( "narrow_cave_dot_end" );
    var_0 = maps\_utility::spawn_anim_model( "rig" );
    var_0 hide();
    level.player _meth_8131( 0 );
    level.player _meth_8300( 0 );
    level.player _meth_8301( 0 );
    level.player _meth_8130( 0 );
    var_1 = level.player _meth_8312();
    level.player _meth_831F();
    level.player _meth_831D();
    level.player _meth_8321();
    level.player _meth_8118( 1 );
    level.player _meth_8119( 0 );
    level.player _meth_811A( 0 );
    level.player.player_breath_amount = 100;
    thread maps\_utility::autosave_by_name( "crawl_completed" );
    level.swim_end_hide_viewarms = 1;
    level.narrow_animnode thread maps\_anim::anim_single_solo( var_0, "narrowcave_water_breach_enter" );
    level.player _meth_8080( var_0, "tag_player", 1.1 );
    wait 0.6;
    level.player _meth_807D( var_0, "tag_player", 0, 18, 15, 10, 10, 1 );
    wait 0.5;
    var_0 show();
    var_2 = getanimlength( var_0 maps\_utility::getanim( "narrowcave_water_breach_enter" ) );
    wait(var_2 - 1.7);

    if ( common_scripts\utility::flag( "cormack_breach_ready" ) || common_scripts\utility::flag( "cormack_breach_loop" ) )
        level.player _meth_80A2( 0.5, 0.25, 0, 0, 0, 0, 0 );

    var_0 waittillmatch( "single anim", "end" );
    level.player thread maps\_swim_player::disable_player_swim();
    _func_0D3( "cg_drawCrosshair", "0" );
    _func_0D3( "ammoCounterHide", "1" );
    level.player waittill( "viewmodel_swim_animations_loop" );
    level.player _meth_8482();

    if ( !issubstr( var_1, "hbra3" ) )
        level.player _meth_831D();

    if ( !common_scripts\utility::flag( "cormack_breach_ready" ) && !common_scripts\utility::flag( "cormack_breach_loop" ) )
    {
        level.narrow_animnode thread maps\_anim::anim_loop_solo( var_0, "narrowcave_water_breach_idle", "stop_rig_loop" );
        common_scripts\utility::flag_wait( "zero_breach_view" );
        level.player _meth_80A2( 0.5, 0.25, 0, 0, 0, 0, 0 );
    }

    common_scripts\utility::flag_wait( "cormack_breach_ready" );
    level.narrow_animnode notify( "stop_rig_loop" );
    level.narrow_animnode thread maps\_anim::anim_single_solo( var_0, "narrowcave_water_breach" );
    var_0 hide();
    var_3 = getnotetracktimes( var_0 maps\_utility::getanim( "narrowcave_water_breach_old" ), "gun_up" );
    var_2 = getanimlength( var_0 maps\_utility::getanim( "narrowcave_water_breach_old" ) );
    var_4 = var_2 * var_3[0];
    thread move_to_cave_combat( var_4 );

    if ( issubstr( var_1, "hbra3" ) )
    {
        level.player _meth_84B5( "crash_narrowcave_water_breach_player" );
        level.player _meth_8481();
    }

    thread narrow_cave_player_allows();
    wait(var_4);

    if ( !issubstr( var_1, "hbra3" ) )
        thread narrowcave_player_breach_weapon_enable();

    _func_0D3( "cg_drawCrosshair", "1" );
    _func_0D3( "ammoCounterHide", "0" );
    common_scripts\_exploder::exploder( 7000 );
    thread exo_temp_breach();
    level.player _meth_8118( 1 );
    level.player _meth_817D( "stand" );
    soundscripts\_snd::snd_message( "start_water_breach" );
    thread end_slow_mo();
    level.player _meth_80EF();
    level.player _meth_81E1( 0.2 );
    var_0 waittillmatch( "single anim", "end" );
    level.player _meth_81E1( 1.0 );
    level.player _meth_804F();
    thread maps\_shg_utility::enable_features_exiting_cinema( 1 );
    var_0 delete();
    level.swim_end_hide_viewarms = undefined;
    level.player _meth_8322();
    level.player _meth_8130( 1 );
    level.player _meth_8320();
    level.player _meth_8118( 1 );
    level.player _meth_8119( 1 );
    level.player _meth_811A( 1 );
    common_scripts\utility::flag_wait( "narrow_cave_done" );
    level.player _meth_8301( 1 );
    level.player _meth_8304( 1 );
    level.water_allow_sprint = undefined;
    waitframe();
    level.player _meth_81E1( 1.0 );
    thread maps\_utility::autosave_by_name( "breach_done" );
}

narrowcave_player_breach_weapon_enable()
{
    wait 0.5;
    level.player _meth_831E();
    level.player _meth_8481();
}

narrow_cave_player_allows()
{
    wait 6.3;
    common_scripts\utility::flag_set( "player_can_aim" );
    level.player _meth_8131( 1 );
    level.player _meth_8300( 1 );
}

nc_underwater_visionset_change( var_0 )
{
    if ( var_0 )
    {
        var_1 = 1;
        level.player maps\_utility::vision_set_fog_changes( "crash_narrow_cave_underwater_02", 0.5 );

        if ( !common_scripts\utility::flag( "csh_lighting_ice_caves_02" ) )
            level.lightset_current = "crash_post_goliath";
        else
            level.lightset_current = "crash_ice_caves_02";

        level.player _meth_8490( "clut_crash_underwater", 0.5 );
        maps\_water::set_light_set_for_player( "crash_lake_fallin_02" );
        playfx( common_scripts\utility::getfx( "water_screen_plunge" ), self.origin );
        self _meth_8218( 0 );
        maps\_water::setunderwateraudiozone();
        self playlocalsound( "underwater_enter" );
    }
    else
    {
        maps\_water::revertvisionsetforplayer( 0 );

        if ( isdefined( level.lightset_previous ) )
            maps\_water::set_light_set_for_player( level.lightset_previous );

        level.player _meth_8490( "clut_crash_overlook", 0.5 );
        self _meth_8218( 0 );
        maps\_water::clearunderwateraudiozone();
        self playlocalsound( "underwater_exit" );
    }
}

underwater_objective_hack()
{
    level endon( "narrow_cave_exiting_tunnel" );

    for (;;)
    {
        if ( isdefined( level.player.underwater ) && level.player.underwater == 1 )
        {
            wait 0.1;
            _func_0D3( "compass", "1" );
        }

        wait 0.05;
    }
}

player_swim_hint()
{
    common_scripts\utility::flag_wait( "narrow_cave_hint" );

    if ( !isdefined( level.player.swimming ) || isdefined( level.player.swimming ) && level.player.swimming != "underwater" )
        level.player maps\_utility::hintdisplayhandler( "player_crouch_gamepad" );

    while ( !isdefined( level.player.swimming ) && level.player _meth_817C() != "crouch" )
        wait 0.05;

    if ( !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) && ( level.player _meth_82F3()[0] < 0.1 || level.player _meth_82F3()[1] < 0.1 ) )
        wait 1.5;

    if ( !common_scripts\utility::flag( "narrow_cave_exiting_tunnel" ) && ( level.player _meth_82F3()[0] < 0.1 || level.player _meth_82F3()[1] < 0.1 ) )
        level.player maps\_utility::hintdisplayhandler( "player_swim_gamepad" );
}

should_break_crouch_hint()
{
    return level.player _meth_817C() == "crouch" || isdefined( level.player.swimming ) && level.player.swimming == "underwater";
}

should_break_swim_hint()
{
    return isdefined( level.player.swimming ) && ( level.player _meth_82F3()[0] > 0.25 || level.player _meth_82F3()[1] > 0.25 );
}

exo_temp_breach()
{
    wait 0.75;
    level.player thread maps\crash_exo_temperature::set_external_temperature_over_time( level.temperature_indoor, 1.5 );
    level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 1.5 );
    level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 1.5 );
}

move_to_cave_combat( var_0 )
{
    maps\_utility::waittill_dead_or_dying( level.breach_guys, 5, var_0 + 5 );
    common_scripts\utility::flag_set( "narrow_cave_done" );
}

end_slow_mo()
{
    var_0 = 0;
    setslowmotion( 1.0, 0.25, 0.5 );

    while ( !common_scripts\utility::flag( "narrow_cave_done" ) && var_0 <= 3.5 )
    {
        wait 0.05;
        var_0 += 0.05;
    }

    setslowmotion( 0.25, 1.0, 0.75 );
    soundscripts\_snd::snd_message( "end_water_breach" );
    level.player _meth_80F0();
}

narrow_cave_enemies()
{
    self endon( "death" );
    self.health = 15;
    self.allowdeath = 1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.grenadeammo = 0;
    self.animname = self.script_noteworthy;
    self disableaimassist();

    if ( self.script_noteworthy == "breach_enemy_6" )
    {
        level.breach_enemy_6 = self;
        thread maps\_utility::magic_bullet_shield();
    }

    if ( self.animname != "breach_enemy_3" )
        level.narrow_animnode thread maps\_anim::anim_loop_solo( self, "water_breach_idle", "stop_enemy_idle" );

    if ( self.animname == "breach_enemy_3" )
        level.narrow_animnode maps\_anim::anim_first_frame_solo( self, "water_breach_enemy" );

    common_scripts\utility::flag_wait( "start_breach_enemies" );
    level.narrow_animnode notify( "stop_enemy_idle" );
    level.narrow_animnode thread maps\_anim::anim_single_solo( self, "water_breach_enemy" );
    common_scripts\utility::flag_wait( "player_can_aim" );
    self enableaimassist();
    self waittillmatch( "single anim", "end" );
    self.ignoreall = 0;
    self.ignoreme = 0;
}

narrow_cave_dialogue()
{
    common_scripts\utility::flag_wait( "start_narrow_cave" );

    if ( !common_scripts\utility::flag( "cormack_can_teleport1" ) )
    {
        level.cormack maps\_utility::smart_dialogue( "crsh_crmk_toheadto" );
        maps\_utility::smart_radio_dialogue( "crsh_grdn5_static4" );
    }
}

narrow_cave_cormack_radio( var_0 )
{
    level.cormack maps\_utility::smart_dialogue( "crsh_crmk_toheadto" );
}

narrow_cave_radio_response( var_0 )
{
    maps\_utility::smart_radio_dialogue( "crsh_grdn5_static4" );
}

narrow_cave_ilona_thermals( var_0 )
{
    level.ilana maps\_utility::smart_dialogue( "crsh_iln_thermals" );
}

narrow_cave_drop_pod()
{
    common_scripts\utility::flag_wait( "narrow_cave_rumble" );
    _func_234( level.player.origin, 0.6, 0.6, 0.4, 2.75, 0.25, 0.5, 1000, 5, 5, 3 );
    soundscripts\_snd::snd_message( "drop_pod_screen_shake_large", "1" );
    common_scripts\_exploder::exploder( 6650 );
    level.player _meth_80AD( "heavy_2s" );
    wait(randomfloatrange( 4.5, 7.0 ));
    _func_234( level.player.origin, 0.5, 0.5, 0.3, 2.75, 0.25, 0.5, 1000, 5, 5, 3 );
    soundscripts\_snd::snd_message( "drop_pod_screen_shake_large", "2" );
    common_scripts\_exploder::exploder( 6650 );
    level.player _meth_80AD( "heavy_2s" );
    wait(randomfloatrange( 4.5, 7.0 ));
    _func_234( level.player.origin, 0.2, 0.2, 0.1, 2.75, 0.25, 0.5, 1000, 5, 5, 3 );
    soundscripts\_snd::snd_message( "drop_pod_screen_shake_large", "3" );
    common_scripts\_exploder::exploder( 6650 );
    level.player _meth_80AD( "light_2s" );
}

narrow_cave_cave_in()
{
    var_0 = getent( "narrow_cave_trigger_underwater", "script_noteworthy" );
    var_1 = getent( "narrowcave_water", "targetname" );
    level.cave_water_origin.old_origin = level.cave_water_origin.origin;
    var_2 = maps\_utility::spawn_anim_model( "water_level" );
    level.narrow_animnode thread maps\_anim::anim_first_frame_solo( var_2, "water_level_rising" );
    var_1 _meth_804D( var_2, "j_prop_1" );
    level.cave_water_origin _meth_804D( var_2, "j_prop_1" );
    var_0 _meth_8069();
    var_0 _meth_804D( level.cave_water_origin );
    thread fx_moving_water_splatter_setup( var_1 );
    common_scripts\utility::flag_wait_all( "player_in_chamber", "cormack_in_chamber", "ilana_in_chamber" );
    level.player.player_breath_amount = 100;
    thread maps\_utility::autosave_by_name( "narrow_cave_cave_in" );
    common_scripts\utility::flag_set( "cave_in" );
    _func_234( level.player.origin, 0.7, 0.7, 0.4, 3.0, 0.25, 1.0, 1000, 6, 6, 5 );
    soundscripts\_snd::snd_message( "cave_in" );
    level.player _meth_80AD( "heavy_3s" );
    var_3 = getent( "narrow_cave_in_chunk", "targetname" );
    var_4 = getent( "narrow_cave_in_chunk_clip", "targetname" );
    var_3 _meth_82AF( 128, 0.05 );
    var_4 _meth_82AF( 128, 0.05 );
    level.narrow_animnode thread maps\_anim::anim_single_solo( var_2, "water_level_rising" );
    wait 2.5;
    common_scripts\_exploder::exploder( 6620 );
    common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );
    level.cave_water_origin _meth_804F();
    common_scripts\utility::flag_clear( "narrow_cave_in_tunnel" );

    for (;;)
    {
        level.cave_water_origin _meth_82AE( level.cave_water_origin.old_origin, 0.05 );
        waitframe();
        common_scripts\utility::flag_wait( "narrow_cave_in_tunnel" );
        common_scripts\utility::flag_clear( "narrow_cave_exiting_tunnel" );
        level.cave_water_origin _meth_82B1( 48, 0.05 );
        waitframe();
        common_scripts\utility::flag_wait( "narrow_cave_exiting_tunnel" );
        common_scripts\utility::flag_clear( "narrow_cave_in_tunnel" );
    }
}

fx_moving_water_splatter_setup( var_0 )
{
    var_1 = maps\_utility::get_exploder_array( 6621 );

    foreach ( var_3 in var_1 )
    {
        var_4 = common_scripts\utility::spawn_tag_origin();
        var_4.fxid = var_3.v["fxid"];
        var_4.origin = var_3.v["origin"];
        var_4.angles = var_3.v["angles"];
        var_4 _meth_804D( var_0 );
        thread fx_moving_water_splatter( var_4 );
    }
}

fx_moving_water_splatter( var_0 )
{
    common_scripts\utility::flag_wait( "cave_in" );
    wait 2.5;
    wait(randomfloatrange( 0.05, 0.2 ));
    playfxontag( level._effect[var_0.fxid], var_0, "tag_origin" );
}

begin_combat_cave()
{
    thread increase_difficulty();
    thread crevasse_initial_group();
    thread combat_cave_dialogue();
    common_scripts\utility::flag_set( "obj_follow_cormack_combat_to_lake" );
    level.cormack maps\_utility::enable_ai_color();
    level.ilana maps\_utility::enable_ai_color();
    level.cormack maps\_utility::set_force_color( "r" );
    level.ilana maps\_utility::set_force_color( "g" );
    level.cormack.ignoresuppression = 1;
    level.ilana.ignoresuppression = 1;
    maps\_utility::activate_trigger_with_targetname( "TRIG_crevasse_engage" );
    level.player _meth_81E1( 1 );
    maps\_utility::battlechatter_on( "allies" );
    common_scripts\utility::flag_wait( "combat_cave_done" );
}

increase_difficulty()
{
    var_0 = level.cormack.baseaccuracy;
    level.cormack.baseaccuracy = var_0 * 0.6;
    level.ilana.baseaccuracy = var_0 * 0.6;
    common_scripts\utility::flag_wait( "combat_cave_done" );
    level.cormack.baseaccuracy = var_0;
    level.ilana.baseaccuracy = var_0;
}

crevasse_initial_group()
{
    soundscripts\_snd::snd_music_message( "crevasse_combat" );
    thread maps\_utility::battlechatter_on( "allies" );
    thread maps\_utility::battlechatter_on( "axis" );
    var_0 = maps\_utility::get_living_ai_array( "pre_wave_1", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        var_2.ignoreall = 0;
        var_2.ignoreme = 0;
        var_2.script_noteworthy = "crevasse_wave_1_remainders";
        var_2 maps\_utility::clear_run_anim();
    }

    thread maps\crash_utility::move_wave( "crevasse_wave_1_remainders", "VOL_crevasse_top_mid_back" );

    if ( level.currentgen )
    {
        var_4 = [ "crevasse_wave_2_special", "crevasse_wave_1_back" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "combat_cave_exit", undefined, 15, 0, var_4 );
    }

    thread crevasse_combat_wave_1();
}

player_starts_battle()
{
    notifyoncommand( "attack", "+attack" );
    level endon( "crevasse_player_rushed_ahead" );
    level.player waittill( "attack" );
    level notify( "crevasse_player_fired_shot" );
    common_scripts\utility::flag_set( "start_crevasse_wave_1" );
}

player_rushes_ahead()
{
    level endon( "crevasse_player_fired_shot" );
    common_scripts\utility::flag_wait( "crevasse_player_moved_up" );
    thread maps\crash_utility::temp_dialogue( "Cormack", "Shit, Mitchell, I did not tell you to run out in the open", 3 );
    level notify( "crevasse_player_rushed_ahead" );
    common_scripts\utility::flag_set( "start_crevasse_wave_1" );
}

crevasse_combat_wave_1()
{
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_1", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_1", 1, 0.1 );

    thread wave_1_zippers();
    thread wave_1_enemy_logic();
    thread crevasse_wave_1_left();
    thread crevasse_wave_1_mid();
    thread crevasse_wave_1_right();
    thread crevasse_wave_1_drop();
    thread crevasse_ledge_adjustment();
    thread crevasse_wave_1_left_special();
    thread crevasse_wave_2();
    var_1 = maps\_utility::get_living_ai_array( "crevasse_wave_1_back", "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        var_3.ignoresuppression = 1;
        var_3.canjumppath = 10;
    }

    wait 1;
    thread wave_1_ally_move( "TRIG_wave_1_start", "crevasse_wave_1_back", "crevasse_player_top", 2 );
}

wave_1_zippers()
{
    var_0 = getentarray( "wave_1_zipper", "targetname" );
    wait 0.5;

    foreach ( var_2 in var_0 )
    {
        var_3 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_2, common_scripts\utility::getstruct( var_2.target, "targetname" ) );
        var_3.ignoresuppression = 1;
        var_3.canjumppath = 10;
    }

    thread give_laser_sights( "light" );
    cave_dialogue_cormack_dropping();
    wait 0.75;
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_highground2" );
}

wave_1_enemy_logic()
{
    thread maps\crash_utility::move_wave( "crevasse_wave_1_top", "VOL_crevasse_bridge" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_back", "VOL_crevasse_under_bridge" );
    thread give_enemy_boost( "crevasse_wave_1_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right", "VOL_crevasse_top_right" );
    thread maps\crash_utility::retreat_volume_and_set_flag( "crevasse_wave_1_right", "VOL_crevasse_top_back", 2, "crevasse_player_right" );
    common_scripts\utility::flag_wait( "crevasse_wave_2" );
    thread crevasse_wave_1_cleaup();
    thread wave_1_5_ally_move();
}

crevasse_wave_1_left()
{
    level endon( "player_chose_mid" );
    level endon( "player_chose_right" );
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_chose_left" );
    level notify( "player_chose_left" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_1_left_support", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_1_left_support", 1, 0.1 );

    common_scripts\utility::flag_wait( "crevasse_player_left" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right", "VOL_crevasse_top_right" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_top", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_mid", "VOL_crevasse_top_mid_back" );
    thread give_enemy_boost( "crevasse_wave_1_mid" );
    thread give_enemy_boost( "crevasse_wave_1_top" );
    thread give_enemy_boost( "crevasse_wave_1_right" );
}

crevasse_wave_1_left_special()
{
    level endon( "crevasse_wave_2" );
    common_scripts\utility::flag_wait( "left_special_zip" );
    var_0 = getent( "VOL_crevasse_top_back", "targetname" );
    var_1 = getentarray( "crevasse_wave_2_special_left", "targetname" );

    foreach ( var_3 in var_1 )
    {
        var_4 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_3, common_scripts\utility::getstruct( var_3.target, "targetname" ) );
        var_4.ignoresuppression = 1;
        var_4.canjumppath = 10;
        var_4 _meth_81A9( var_0 );
    }
}

thin_the_herd()
{
    maps\crash_utility::kill_enemies( "crevasse_wave_1_remainders" );
}

crevasse_wave_1_mid()
{
    level endon( "player_chose_left" );
    level endon( "player_chose_right" );
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_chose_mid" );
    level notify( "player_chose_mid" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_1_support_mid", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_1_support_mid", 1, 0.1 );

    thread maps\crash_utility::set_main_vol_and_retreat_vol( "crevasse_wave_1_mid_support", "VOL_crevasse_top_mid_back", "VOL_crevasse_top_back", 1 );
    common_scripts\utility::flag_wait( "crevasse_player_top" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_mid_support", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_top", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_back", "VOL_crevasse_top_mid_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_remainders", "VOL_crevasse_top_back" );
    thread give_enemy_boost( "crevasse_wave_1_mid" );
    thread give_enemy_boost( "crevasse_wave_1_top" );
    thread give_enemy_boost( "crevasse_wave_1_right" );
}

perch_spot_wave()
{
    common_scripts\utility::flag_wait( "crevasse_player_right_perch" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_1_right_perch", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_1_right_perch", 1, 0.1 );

    thread give_enemy_boost( "crevasse_wave_1_right_perch" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_perch", "VOL_crevasse_bridge" );
    common_scripts\utility::flag_wait( "crevasse_player_top" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_perch", "VOL_crevasse_top_mid_back" );
}

crevasse_wave_1_right()
{
    level endon( "player_chose_mid" );
    level endon( "player_chose_left" );
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_chose_right" );
    level notify( "player_chose_right" );
    common_scripts\utility::flag_wait( "crevasse_player_right" );
    maps\crash_utility::kill_enemies( "crevasse_wave_1_mid" );
    thread thin_the_herd();
    thread maps\crash_utility::move_wave( "crevasse_wave_1_mid", "VOL_crevasse_top_mid_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_top", "VOL_crevasse_top_back" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_1_right_special", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_1_right_special", 1, 0.1 );

    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_special", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_bottom", "VOL_crevasse_top_mid_back" );
    common_scripts\utility::flag_wait( "crevasse_wave_2" );
    thread maps\crash_utility::cleanup_enemies( "crevasse_wave_1_back" );
    thread maps\crash_utility::cleanup_enemies( "crevasse_wave_1_mid" );
}

crevasse_wave_1_drop()
{
    var_0 = maps\crash_utility::enemy_drop_traversal( "crevasse_wave_1_drop_3", "crevasse_drop_node_6" );
    wait 1;
    var_1 = maps\crash_utility::enemy_drop_traversal( "crevasse_wave_1_drop_1", "crevasse_drop_node_1" );
    thread maps\crash_utility::set_main_vol_and_retreat_vol( "crevasse_wave_1_mid", "VOL_crevasse_under_bridge", "VOL_crevasse_top_mid_back", 2 );
}

crevasse_wave_1_cleaup()
{
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_perch", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_left_support", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_back", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_mid", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_special", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_5", "VOL_crevasse_top_back" );
    thread maps\crash_utility::move_wave( "crevasse_wave_1_right_bottom", "VOL_crevasse_top_back" );
}

wave_1_ally_move( var_0, var_1, var_2, var_3 )
{
    level endon( var_2 );
    var_4 = maps\_utility::get_living_ai_array( var_1, "script_noteworthy" );
    maps\_utility::waittill_dead( var_4, var_4.size - var_3 );
    maps\_utility::activate_trigger_with_targetname( var_0 );
    cave_dialogue_cormack_push();
}

wave_1_5_ally_move()
{
    var_0 = getent( "VOL_first_cave", "targetname" );
    var_1 = getent( "VOL_crevasse_wave_2", "targetname" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_4 in var_2 )
    {
        var_4.canjumppath = 1;
        var_4 thread wave_1_5_retreat( var_1 );
    }

    maps\_utility::waittill_dead( var_2, var_2.size );
    level notify( "1_5_retreat" );
    maps\_utility::activate_trigger_with_targetname( "TRIG_wave_2_move_up" );
}

wave_1_5_retreat( var_0 )
{
    self endon( "death" );
    level waittill( "1_5_retreat" );
    self _meth_81A9( var_0 );
}

crevasse_ledge_adjustment()
{
    common_scripts\utility::flag_wait( "FLAG_crevasse_upper_move" );
    var_0 = getent( "VOL_crevasse_top_mid_back", "targetname" );
    var_1 = getent( "VOL_crevasse_top_back", "targetname" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_4 in var_2 )
        var_4 _meth_81A9( var_1 );
}

combat_cave_dialogue()
{
    level endon( "combat_cave_done" );
    common_scripts\utility::flag_wait( "crevasse_player_top" );
    thread cave_dialogue_cormack_attack();
    common_scripts\utility::flag_wait( "crevasse_wave_2_special" );
    cave_dialogue_cormack_dropping();
    wait 0.5;
    cave_dialogue_cormack_drop_em();
    common_scripts\utility::flag_wait( "ilona_say_left" );
    thread cave_dialogue_ilona_left();
}

cave_dialogue_cormack_push()
{
    maps\_utility::battlechatter_off( "allies" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_pushfwd2" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_cormack_attack()
{
    maps\_utility::battlechatter_off( "allies" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_clearemout" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_cormack_dropping()
{
    maps\_utility::battlechatter_off( "allies" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_droppingin" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_cormack_contact()
{
    maps\_utility::battlechatter_off( "allies" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_contactahead" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_cormack_drop_em()
{
    maps\_utility::battlechatter_off( "allies" );
    level.cormack maps\_utility::smart_radio_dialogue( "crsh_crmk_dropemquick" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_ilona_left()
{
    maps\_utility::battlechatter_off( "allies" );
    level.ilana maps\_utility::smart_radio_dialogue( "crsh_iln_lookleft" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_ilona_down()
{
    maps\_utility::battlechatter_off( "allies" );
    level.ilana maps\_utility::smart_radio_dialogue( "crsh_iln_targetdown2" );
    maps\_utility::battlechatter_on( "allies" );
}

cave_dialogue_ilona_exit()
{
    maps\_utility::battlechatter_off( "allies" );
    level.ilana maps\_utility::smart_radio_dialogue( "crsh_iln_exitahead" );
    maps\_utility::battlechatter_on( "allies" );
}

crevasse_wave_2()
{
    common_scripts\utility::flag_wait( "crevasse_wave_2" );
    thread maps\_utility::autosave_by_name_silent( "wave_2" );
    thread crevasse_area_2_special();
    thread crevasse_wave_3();
    thread crevasse_upper();
    thread crevasse_upper_cancelled();
    thread abyss_player_kill();
}

crevasse_area_2_special()
{
    thread wave_2_special_start();
    common_scripts\utility::flag_wait( "crevasse_wave_2_special" );
    var_0 = getentarray( "crevasse_wave_2", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_2, common_scripts\utility::getstruct( var_2.target, "targetname" ) );
        var_3.ignoresuppression = 1;
        var_3.canjumppath = 10;
    }

    thread maps\crash_utility::set_main_vol_and_retreat_vol( "crevasse_wave_2", "VOL_crevasse_top_back", "VOL_crevasse_wave_2", 1 );
    thread cave_drop_guys();
    wait 3;
    thread maps\crash_utility::move_wave( "crevasse_wave_2_drop", "VOL_crevasse_wave_2" );
    common_scripts\utility::flag_wait( "crevasse_wave_3_drop" );
    thread wave_3_ally_move_left();
    thread wave_3_ally_move_right();
    var_5 = getent( "VOL_crevasse_jump_right", "targetname" );
    var_6 = getent( "crevasse_wave_3_special", "targetname" );
    var_7 = var_6 maps\_utility::spawn_ai( 1 );
    wait 0.05;
    var_7.ignoresuppression = 1;
    var_7.canjumppath = 10;
    var_7 _meth_81A9( var_5 );
    level.cormack.ignoresuppression = 1;
    level.ilana.ignoresuppression = 1;
    thread maps\_utility::autosave_by_name_silent( "wave_2_5" );
}

wave_2_special_start()
{
    var_0 = getent( "VOL_crevasse_top_back", "targetname" );
    var_1 = undefined;

    if ( level.nextgen )
        var_1 = maps\_utility::array_spawn_targetname( "crevasse_wave_2_upper", 1 );
    else
        var_1 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_2_upper", 1, 0.1 );

    var_2 = maps\_utility::get_living_ai_array( "crevasse_wave_2_special", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        var_4.canjumppath = 10;
        var_4.ignoresuppression = 1;
        var_4 _meth_81A9( var_0 );
    }

    var_6 = getentarray( "crevasse_wave_2_special_zip", "targetname" );

    foreach ( var_8 in var_6 )
    {
        var_9 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_8, common_scripts\utility::getstruct( var_8.target, "targetname" ) );
        var_9.ignoresuppression = 1;
        var_9.canjumppath = 10;
        var_9 _meth_81A9( var_0 );
    }
}

cave_drop_guys()
{
    var_0 = maps\crash_utility::enemy_drop_traversal( "crevasse_wave_2_drop_1", "crevasse_drop_node_4" );
    var_0.canjumppath = 10;
    wait 1;
    var_1 = maps\crash_utility::enemy_drop_traversal( "crevasse_wave_2_drop_2", "crevasse_drop_node_3" );
    var_1.canjumppath = 10;
    thread drop_perch_ally();
}

drop_perch_ally()
{
    level endon( "crevasse_wave_3_drop" );
    var_0 = getent( "VOL_crevasse_wave_2", "targetname" );
    var_1 = getent( "VOL_crevasse_jump_left", "targetname" );
    var_2 = maps\_utility::get_living_ai_array( "crevasse_wave_2_drop", "script_noteworthy" );

    if ( var_2.size > 1 )
        maps\_utility::waittill_dead( var_2, 1 );

    var_3 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_5 in var_3 )
    {
        var_5 _meth_81A9( var_1 );
        var_5.ignoresuppression = 1;
        var_5.script_noteworthy = "crevasse_wave_3_left";
        var_5 thread perch_runner();
    }

    thread maps\crash_utility::move_wave_random( "crevasse_wave_2_special", "VOL_crevasse_jump_left" );
    common_scripts\utility::flag_set( "ilona_say_left" );
    thread bad_perch_logic();
    maps\_utility::activate_trigger_with_targetname( "TRIG_ally_drop_down_cave" );
}

bad_perch_logic()
{
    var_0 = getent( "VOL_crevasse_wave_2", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    if ( var_1.size > 0 )
        badplace_brush( "perch_badplace", 4, var_0, "allies" );
}

perch_runner()
{
    self endon( "death" );
    self.ignoreall = 1;
    common_scripts\utility::flag_wait( "crevasse_wave_3_drop" );
    self.ignoreall = 0;
}

abyss_player_kill()
{
    common_scripts\utility::flag_wait( "FLAG_abyss_death" );
    setdvar( "ui_deadquote", &"CRASH_FAIL_FALL" );
    maps\_utility::missionfailedwrapper();
    level.player thread maps\_player_exo::player_exo_deactivate();
}

crevasse_wave_3()
{
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_wave_3" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_3", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_3", 1, 0.1 );

    thread wave_3_zippers();
    thread maps\crash_utility::move_wave( "crevasse_wave_3_left", "VOL_crevasse_bottom_left" );
    thread maps\crash_utility::retreat_volume_and_set_flag( "crevasse_wave_3_left", "VOL_crevasse_bottom_back", 2, "crevasse_3_support" );
    thread maps\crash_utility::move_wave( "crevasse_wave_3_right", "VOL_crevasse_bottom_right" );
    thread maps\crash_utility::retreat_volume_and_set_flag( "crevasse_wave_3_right", "VOL_crevasse_bottom_back", 1, "crevasse_3_support" );
    thread wave_3_retreat();
    common_scripts\utility::flag_wait_either( "crevasse_3_support", "crevasse_wave_3_move_back" );
    var_1 = undefined;

    if ( level.nextgen )
        var_1 = maps\_utility::array_spawn_targetname( "crevasse_wave_3_support", 1 );
    else
        var_1 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_3_support", 1, 0.1 );

    waitframe();

    foreach ( var_3 in var_1 )
    {
        var_3.canjumppath = 10;
        var_3.ignoresuppression = 1;
    }

    thread maps\crash_utility::move_wave( "crevasse_wave_3_support", "VOL_crevasse_bottom_back" );
}

wave_3_zippers()
{
    var_0 = getent( "VOL_cave_exit", "targetname" );
    var_1 = getent( "crevasse_wave_3_zipper", "targetname" );
    common_scripts\utility::flag_wait( "crevasse_wave_3_drop" );
    var_2 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_1, common_scripts\utility::getstruct( var_1.target, "targetname" ) );
    var_2.ignoresuppression = 1;
    var_2.canjumppath = 10;
    var_2 _meth_81A9( var_0 );
    common_scripts\utility::flag_wait( "crevasse_wave_3_move_back" );
    var_2 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline( var_1, common_scripts\utility::getstruct( var_1.target, "targetname" ) );
    var_2.ignoresuppression = 1;
    var_2.canjumppath = 10;
    var_2 _meth_81A9( var_0 );
}

wave_3_retreat()
{
    common_scripts\utility::flag_wait( "crevasse_wave_3_move_back" );
    thread maps\crash_utility::move_wave_random( "crevasse_wave_3_left", "VOL_crevasse_bottom_back" );
    thread maps\crash_utility::move_wave_random( "crevasse_wave_3_right", "VOL_crevasse_bottom_back" );
    thread maps\crash_utility::move_wave_random( "crevasse_wave_3_right_special", "VOL_crevasse_bottom_back" );
    thread combat_cave_exit();
    thread combat_cave_cleanup();
}

crevasse_upper()
{
    level endon( "end_upper_trigger" );
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_upper" );
    level notify( "took_upper" );
    var_0 = getent( "crevasse_upper", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.canjumppath = 100;
    var_1.ignoresuppression = 1;
    maps\crash_utility::move_wave( "crevasse_wave_3_left", "VOL_crevasse_bottom_back" );
}

crevasse_upper_cancelled()
{
    level endon( "took_upper" );
    maps\_utility::trigger_wait_targetname( "TRIG_crevasse_upper_end" );
    level notify( "end_upper_trigger" );
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "crevasse_wave_3_reinforcement", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "crevasse_wave_3_reinforcement", 1, 0.1 );

    foreach ( var_2 in var_0 )
        var_2.ignoresuppression = 1;

    thread maps\crash_utility::move_wave( "crevasse_wave_3_reinforcement", "VOL_cave_exit" );
}

give_enemy_boost( var_0 )
{
    var_1 = maps\_utility::get_living_ai_array( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
    {
        var_3.canjumppath = 10;
        var_3.ignoresuppression = 1;
    }
}

wave_3_ally_move_left()
{
    level endon( "crevasse_wave_3_move_back" );
    var_0 = getent( "VOL_crevasse_bottom_left", "targetname" );
    var_1 = getent( "VOL_crevasse_bottom_back", "targetname" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_4 in var_2 )
    {
        var_4.canjumppath = 10;
        var_4 thread wave_3_retreat_vol( var_1 );
    }

    maps\_utility::waittill_dead( var_2, var_2.size - 1 );
    level notify( "3_retreat" );
    thread cave_dialogue_cormack_push();
    maps\_utility::activate_trigger_with_targetname( "TRIG_ally_move_3" );
}

wave_3_ally_move_right()
{
    level endon( "crevasse_wave_3_move_back" );
    var_0 = getent( "VOL_crevasse_bottom_right", "targetname" );
    var_1 = getent( "VOL_crevasse_bottom_back", "targetname" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_4 in var_2 )
    {
        var_4.canjumppath = 10;
        var_4 thread wave_3_retreat_vol( var_1 );
    }

    maps\_utility::waittill_dead( var_2, var_2.size - 1 );
    level notify( "3_retreat" );
    maps\_utility::activate_trigger_with_targetname( "TRIG_ally_move_3" );
}

wave_3_retreat_vol( var_0 )
{
    self endon( "death" );
    level waittill( "3_retreat" );
    self _meth_81A9( var_0 );
}

combat_cave_exit()
{
    var_0 = getent( "VOL_second_cave", "targetname" );
    var_1 = getent( "VOL_cave_exit", "targetname" );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "axis" );
    maps\_utility::waittill_dead( var_2, var_2.size - 3 );
    var_3 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_5 in var_3 )
    {
        var_5 _meth_81A9( var_1 );
        var_5.ignoresuppression = 1;
    }

    maps\_utility::waittill_dead_or_dying( var_3, var_3.size );

    if ( !common_scripts\utility::flag( "combat_cave_done" ) )
        maps\_utility::activate_trigger_with_targetname( "TRIG_ally_move_4" );

    level notify( "combat_cave_exit" );

    if ( !common_scripts\utility::flag( "combat_cave_done" ) )
    {
        wait 0.5;
        level.ilana thread maps\_utility::smart_radio_dialogue( "crsh_iln_allclear3" );
        wait 0.5;
        thread cave_dialogue_ilona_exit();
    }

    thread maps\_utility::autosave_by_name( "combat_cave_complete" );
}

combat_cave_cleanup()
{
    common_scripts\utility::flag_wait( "FLAG_overlook_autosave" );
    var_0 = getent( "VOL_second_cave", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_3 in var_1 )
        var_3 delete();

    var_0 = getent( "VOL_first_cave", "targetname" );
    var_1 = var_0 maps\_utility::get_ai_touching_volume( "axis" );

    foreach ( var_3 in var_1 )
        var_3 delete();
}

cave_start_teleport()
{
    maps\_utility::trigger_wait_targetname( "" );
    var_0 = getnode( "cave_teleport_cormack", "targetname" );
    var_1 = getnode( "cave_teleport_ilana", "targetname" );
    level.cormack maps\_utility::teleport_ai( var_0 );
    level.ilana maps\_utility::teleport_ai( var_1 );
}

execute_ai_solo( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_5[0] = var_0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    execute_ai( var_5, var_1, var_2, var_3, var_4 );
}

execute_ai( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_6 = isdefined( var_4 );

    while ( isdefined( self.execute_mode ) && self.execute_mode == 1 )
        self waittill( "execute_mode" );

    self.execute_mode = 1;
    var_7 = 1;

    if ( isdefined( self.cqbwalking ) && self.cqbwalking )
        var_7 = 0;

    for ( var_8 = 0; var_8 < var_0.size; var_8++ )
    {
        if ( !isalive( var_0[var_8] ) || isdefined( var_0[var_8].execute_target ) )
            continue;

        var_0[var_8].execute_target = 1;
        var_9 = spawn( "script_origin", var_0[var_8] gettagorigin( "j_spine4" ) );
        var_9 _meth_804D( var_0[var_8], "j_spine4" );
        maps\_utility::cqb_aim( var_9 );

        if ( var_3 )
        {
            while ( abs( vectordot( self gettagangles( "tag_flash" ), vectornormalize( var_9.origin - self gettagorigin( "tag_flash" ) ) ) ) < 0.95 )
                wait 0.05;
        }

        wait(var_1);

        while ( var_6 )
        {
            var_10 = bullettrace( self gettagorigin( "tag_flash" ), var_9.origin, 1, self );

            if ( !isdefined( var_10["entity"] ) || !isplayer( var_10["entity"] ) )
                break;

            wait 0.1;
        }

        if ( isdefined( var_2 ) )
            var_5 = var_2;
        else
            var_5 = randomintrange( 3, 6 );

        if ( var_3 )
        {
            while ( isalive( var_0[var_8] ) )
                burstshot( var_5 );
        }
        else
        {
            burstshot( var_5 );
            var_0[var_8] _meth_8052( self gettagorigin( "tag_flash" ) );
        }

        var_9 delete();
        wait 0.1;
    }

    maps\_utility::cqb_aim( undefined );
    self.execute_mode = 0;
    self notify( "execute_mode" );
}

burstshot( var_0 )
{
    if ( self.bulletsinclip < var_0 )
        self.bulletsinclip = var_0;

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        self _meth_81E7();
        wait 0.1;
    }
}

give_laser_sights( var_0 )
{
    var_0 = maps\_utility::get_living_ai_array( var_0, "script_parameters" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        wait 0.1;
}

turn_on_laser()
{
    self _meth_80B2();
}

smartlasersystem()
{
    level endon( "disable_smart_laser" );
    self endon( "death" );

    for (;;)
    {
        self _meth_80B2();
        wait 0.05;
    }
}
