// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

load_precache()
{
    precachemodel( "viewbody_generic_s1" );
    precachemodel( "viewbody_sentinel" );
    precachemodel( "viewbody_atlas_pmc_smp_custom" );
    precachemodel( "viewbody_atlas_military_smp" );
    precachemodel( "viewbody_atlas_military_smp_grapple" );
    precacheitem( "frag_grenade_var_exoclimb" );
    precacheitem( "tracking_grenade_var_exoclimb" );
    precacheitem( "contact_grenade_var_exoclimb" );
    precacheitem( "flash_grenade_var_exoclimb" );
    precacheitem( "emp_grenade_var_exoclimb" );
    precacheitem( "paint_grenade_var_exoclimb" );
    precachestring( &"EXOCLIMB_CLIMB_HINT" );
    precachestring( &"EXOCLIMB_CLIMB_HINT_PC" );
    precacherumble( "falling_land" );
    precacherumble( "damage_light" );
    level._effect["exo_r_gloves_engage"] = loadfx( "vfx/ui/exo_r_gloves_engage" );
    level._effect["exo_l_gloves_engage"] = loadfx( "vfx/ui/exo_l_gloves_engage" );
    level._effect["exo_r_gloves_engage_slow"] = loadfx( "vfx/ui/exo_r_gloves_engage_slow" );
    level._effect["exo_l_gloves_engage_slow"] = loadfx( "vfx/ui/exo_l_gloves_engage_slow" );
    level._effect["exo_r_gloves_disengage"] = loadfx( "vfx/ui/exo_r_gloves_disengage" );
    level._effect["exo_l_gloves_disengage"] = loadfx( "vfx/ui/exo_l_gloves_disengage" );
    level._effect["dust_mag_r_glove_impact"] = loadfx( "vfx/dust/dust_mag_r_glove_impact" );
    level._effect["dust_mag_l_glove_impact"] = loadfx( "vfx/dust/dust_mag_l_glove_impact" );

    if ( isdefined( 1 ) && 1 )
        temp_exoclimb_hud_precache();
}

main( var_0 )
{
    common_scripts\utility::flag_init( "flag_exo_climbing_enabled" );
    setup_climb_special_arrays();
    setup_climb_model( var_0 );
    setup_climb_anims();
    setup_exo_climb_audio();
    verify_jump_mount_points();
    verify_mag_mount_points();
    get_climb_triggers();
    init_exoclimb_hud();
}

is_exo_climbing()
{
    if ( isdefined( level.exo_climb_rig ) )
        return 1;
    else
        return 0;
}

is_exoclimb_combat()
{
    if ( !isdefined( level.exo_climb_rig.combatbuttonbuffer ) )
        return 0;

    if ( climbing_helper_player_combat_requested() )
        return 1;

    return 0;
}

is_exoclimb_cover()
{
    if ( !isdefined( level.exo_climb_rig.crouch_button_reset ) )
        return 0;

    if ( climbing_helper_player_exit_combat_mode_requested() )
        return 1;

    return 0;
}

is_exoclimb_jumped()
{
    if ( !isdefined( level.exo_climb_rig.jumpbuttonbuffer ) )
        return 0;

    if ( climbing_helper_player_jump_requested() )
        return 1;

    return 0;
}

is_exoclimb_mag_moved()
{
    if ( !isdefined( level.exo_climb_rig.surface_state ) )
        return 0;

    if ( climbing_helper_player_mag_moving() )
        return 1;

    return 0;
}

override_mount_anim( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getentarray( var_0, "script_noteworthy" );

    foreach ( var_7 in var_5 )
    {
        var_7.override_anim = var_1;
        var_7.override_anim_org = var_2;
        var_7.override_rig = var_3;
        var_7.override_view_angle_unclamp_time = var_4;
    }
}

disable_mount_point( var_0 )
{
    var_1 = getentarray( var_0, "script_noteworthy" );

    foreach ( var_3 in var_1 )
        var_3 notify( "disable_mount_point" );
}

enable_exoclimb_combat( var_0 )
{
    if ( isdefined( var_0 ) && !var_0 )
        level.exoclimb_combat_enabled = 0;
    else
        level.exoclimb_combat_enabled = 1;
}

setup_climb_special_arrays()
{
    level.exo_climb_move_options = [];
    level.exo_climb_move_options["short"] = [];
    level.exo_climb_move_options["long"] = [];
    level.exo_climb_move_options["magnetic"] = [];
    level.exo_climb_move_options["jump2mag"] = [];
    level.exo_climb_move_options["mag2jump"] = [];
    level.exo_climb_anim_offsets = [];
    level.exo_climb_weapon = [];
}

add_shake_and_rumble_notetracks_for_jump( var_0 )
{
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "jump_rumble", ::exo_climb_jump_rumble, var_0 );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "jump_shake", ::exo_climb_jump_shake, var_0 );
}

add_shake_and_rumble_notetracks_for_grab( var_0 )
{
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "grab_rumble", ::exo_climb_grab_rumble, var_0 );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "grab_shake", ::exo_climb_grab_shake, var_0 );
}

add_shake_and_rumble_notetracks( var_0 )
{
    add_shake_and_rumble_notetracks_for_jump( var_0 );
    add_shake_and_rumble_notetracks_for_grab( var_0 );
}

add_mag_move_notetracks( var_0 )
{
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, var_0 );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input_2", ::exo_climb_allow_player_input_2, var_0 );
}

setup_climb_model( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        level.scr_model["player_climb_rig"] = "viewbody_generic_s1";
    else if ( var_0 == "atlas_pmc" )
        level.scr_model["player_climb_rig"] = "viewbody_atlas_pmc_smp_custom";
    else if ( var_0 == "atlas_army" )
    {
        if ( isdefined( var_1 ) )
            level.scr_model["player_climb_rig"] = "viewbody_atlas_military_smp_grapple";
        else
            level.scr_model["player_climb_rig"] = "viewbody_atlas_military_smp";
    }
    else if ( var_0 == "sentinel" )
        level.scr_model["player_climb_rig"] = "viewbody_sentinel";
}

#using_animtree("player");

setup_climb_anims()
{
    level.scr_animtree["player_climb_rig"] = #animtree;
    level.scr_anim["player_climb_rig"]["mount2jump"] = %vm_exoclimb_mount;
    level.scr_anim["player_climb_rig"]["mount2mag"] = %vm_exoclimb_mag_mount_up;
    level.scr_anim["player_climb_rig"]["mount_override"] = undefined;
    level.scr_anim["player_climb_rig"]["dismount"] = %vm_exoclimb_dismount_down;
    level.scr_anim["player_climb_rig"]["idle"][0] = %vm_exoclimb_idle;
    level.scr_anim["player_climb_rig"]["idleleft"][0] = %vm_exoclimb_idle_left;
    level.scr_anim["player_climb_rig"]["idleright"][0] = %vm_exoclimb_idle_right;
    level.scr_anim["player_climb_rig"]["idleleft_back"][0] = %vm_exoclimb_idle_left_back;
    level.scr_anim["player_climb_rig"]["idleright_back"][0] = %vm_exoclimb_idle_right_back;
    level.scr_anim["player_climb_rig"]["idle_magnetic_gloves"][0] = %vm_exoclimb_mag_idle;
    level.scr_anim["player_climb_rig"]["combat_idle"][0] = %vm_exoclimb_combat_idle;
    level.scr_anim["player_climb_rig"]["combat_idle_left"][0] = %vm_exoclimb_combat_idle_left;
    level.scr_anim["player_climb_rig"]["combat_idle_right"][0] = %vm_exoclimb_combat_idle_right;
    level.scr_anim["player_climb_rig"]["climb_to_combat_idle"] = %vm_exoclimb_climb_idle_to_combat_idle;
    level.scr_anim["player_climb_rig"]["combat_to_climb_idle"] = %vm_exoclimb_combat_idle_to_climb_idle;
    level.scr_anim["player_climb_rig"]["combat_center_to_left"] = %vm_exoclimb_combat_idle_to_combat_idle_left;
    level.scr_anim["player_climb_rig"]["combat_left_to_center"] = %vm_exoclimb_combat_idle_left_to_combat_idle;
    level.scr_anim["player_climb_rig"]["combat_center_to_right"] = %vm_exoclimb_combat_idle_to_combat_idle_right;
    level.scr_anim["player_climb_rig"]["combat_right_to_center"] = %vm_exoclimb_combat_idle_right_to_combat_idle;
    level.scr_anim["player_climb_rig"]["normal_long_d"] = %vm_exoclimb_jump_2;
    level.scr_anim["player_climb_rig"]["normal_long_l"] = %vm_exoclimb_jump_4;
    level.scr_anim["player_climb_rig"]["normal_long_r"] = %vm_exoclimb_jump_6;
    level.scr_anim["player_climb_rig"]["normal_long_u"] = %vm_exoclimb_jump_8;
    level.scr_anim["player_climb_rig"]["magnetic_u_0"] = %vm_exoclimb_mag_up_00;
    level.scr_anim["player_climb_rig"]["magnetic_u_1"] = %vm_exoclimb_mag_up_01;
    level.scr_anim["player_climb_rig"]["magnetic_u_2"] = %vm_exoclimb_mag_up_02;
    level.scr_anim["player_climb_rig"]["magnetic_d_0"] = %vm_exoclimb_mag_down_00;
    level.scr_anim["player_climb_rig"]["magnetic_d_1"] = %vm_exoclimb_mag_down_01;
    level.scr_anim["player_climb_rig"]["magnetic_d_2"] = %vm_exoclimb_mag_down_02;
    level.scr_anim["player_climb_rig"]["magnetic_l_0"] = %vm_exoclimb_mag_left_00;
    level.scr_anim["player_climb_rig"]["magnetic_l_1"] = %vm_exoclimb_mag_left_01;
    level.scr_anim["player_climb_rig"]["magnetic_l_2"] = %vm_exoclimb_mag_left_02;
    level.scr_anim["player_climb_rig"]["magnetic_r_0"] = %vm_exoclimb_mag_right_00;
    level.scr_anim["player_climb_rig"]["magnetic_r_1"] = %vm_exoclimb_mag_right_01;
    level.scr_anim["player_climb_rig"]["magnetic_r_2"] = %vm_exoclimb_mag_right_02;
    level.scr_anim["player_climb_rig"]["jump2mag_u"] = %vm_exoclimb_jump2mag_up;
    level.scr_anim["player_climb_rig"]["jump2mag_d"] = %vm_exoclimb_jump2mag_down;
    level.scr_anim["player_climb_rig"]["jump2mag_l"] = %vm_exoclimb_jump2mag_left;
    level.scr_anim["player_climb_rig"]["jump2mag_r"] = %vm_exoclimb_jump2mag_right;
    level.scr_anim["player_climb_rig"]["mag2jump_u"] = %vm_exoclimb_mag2jump_up;
    level.scr_anim["player_climb_rig"]["mag2jump_d"] = %vm_exoclimb_mag2jump_down;
    level.scr_anim["player_climb_rig"]["mag2jump_l"] = %vm_exoclimb_mag2jump_left;
    level.scr_anim["player_climb_rig"]["mag2jump_r"] = %vm_exoclimb_mag2jump_right;
    level.scr_anim["player_climb_rig"]["idle_to_idleleft"] = %vm_exoclimb_idle_to_idle_left;
    level.scr_anim["player_climb_rig"]["idleleft_to_idle"] = %vm_exoclimb_idle_left_to_idle;
    level.scr_anim["player_climb_rig"]["idle_to_idleright"] = %vm_exoclimb_idle_to_idle_right;
    level.scr_anim["player_climb_rig"]["idleright_to_idle"] = %vm_exoclimb_idle_right_to_idle;
    level.scr_anim["player_climb_rig"]["idleleft_to_idleleftback"] = %vm_exoclimb_idle_left_to_idle_left_back;
    level.scr_anim["player_climb_rig"]["idleleftback_to_idleleft"] = %vm_exoclimb_idle_left_back_to_idle_left;
    level.scr_anim["player_climb_rig"]["idleright_to_idlerightback"] = %vm_exoclimb_idle_right_to_idle_right_back;
    level.scr_anim["player_climb_rig"]["idlerightback_to_idleright"] = %vm_exoclimb_idle_right_back_to_idle_right;
    level.scr_anim["player_climb_rig"]["special_short_l_90convex"] = %vm_exoclimb_move_in_90_4;
    level.scr_anim["player_climb_rig"]["special_short_r_90convex"] = %vm_exoclimb_move_in_90_6;
    level.scr_anim["player_climb_rig"]["special_long_l_90concave2"] = %vm_exoclimb_jump_90_4_2;
    level.scr_anim["player_climb_rig"]["special_long_r_90concave2"] = %vm_exoclimb_jump_90_6_2;
    setup_climb_anims_parse_anim_offsets( level.scr_anim["player_climb_rig"] );
    add_shake_and_rumble_notetracks( "normal_long_u" );
    add_shake_and_rumble_notetracks( "normal_long_d" );
    add_shake_and_rumble_notetracks( "normal_long_r" );
    add_shake_and_rumble_notetracks( "normal_long_l" );
    add_shake_and_rumble_notetracks( "special_long_l_90concave2" );
    add_shake_and_rumble_notetracks( "special_long_r_90concave2" );
    add_shake_and_rumble_notetracks( "mount2jump" );
    add_shake_and_rumble_notetracks( "mount2mag" );
    add_shake_and_rumble_notetracks( "jump2mag_u" );
    add_shake_and_rumble_notetracks( "jump2mag_d" );
    add_shake_and_rumble_notetracks( "jump2mag_l" );
    add_shake_and_rumble_notetracks( "jump2mag_r" );
    add_shake_and_rumble_notetracks_for_grab( "mag2jump_u" );
    add_shake_and_rumble_notetracks_for_grab( "mag2jump_d" );
    add_shake_and_rumble_notetracks_for_grab( "mag2jump_l" );
    add_shake_and_rumble_notetracks_for_grab( "mag2jump_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "jump_rumble", ::exo_climb_jump_rumble, "dismount" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "jump_shake", ::exo_climb_jump_shake, "dismount" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "mag_rumble", ::exo_climb_mag_rumble, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "mag_rumble", ::exo_climb_mag_rumble, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "mag_rumble", ::exo_climb_mag_rumble, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "vm_swap", ::exo_climb_draw_weapon, "climb_to_combat_idle" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "normal_long_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "normal_long_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "normal_long_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "normal_long_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "special_long_l_90concave2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "special_long_r_90concave2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "special_short_l_90convex" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "special_short_r_90convex" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "jump2mag_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "jump2mag_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "jump2mag_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "jump2mag_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "mag2jump_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "mag2jump_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "mag2jump_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "player_input", ::exo_climb_allow_player_input_1, "mag2jump_r" );
    add_mag_move_notetracks( "magnetic_u_0" );
    add_mag_move_notetracks( "magnetic_u_1" );
    add_mag_move_notetracks( "magnetic_u_2" );
    add_mag_move_notetracks( "magnetic_d_0" );
    add_mag_move_notetracks( "magnetic_d_1" );
    add_mag_move_notetracks( "magnetic_d_2" );
    add_mag_move_notetracks( "magnetic_l_0" );
    add_mag_move_notetracks( "magnetic_l_1" );
    add_mag_move_notetracks( "magnetic_l_2" );
    add_mag_move_notetracks( "magnetic_r_0" );
    add_mag_move_notetracks( "magnetic_r_1" );
    add_mag_move_notetracks( "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "jump2mag_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "jump2mag_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "jump2mag_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "jump2mag_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "jump2mag_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "jump2mag_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "jump2mag_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "jump2mag_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "jump2mag_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "jump2mag_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "jump2mag_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "jump2mag_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "jump2mag_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "jump2mag_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "jump2mag_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "jump2mag_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "mag2jump_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "mag2jump_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "mag2jump_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "mag2jump_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "mag2jump_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "mag2jump_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "mag2jump_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "mag2jump_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "mag2jump_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "mag2jump_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "mag2jump_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "mag2jump_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "mag2jump_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "mag2jump_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "mag2jump_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "mag2jump_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "normal_long_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "normal_long_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "normal_long_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "normal_long_d" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "normal_long_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "normal_long_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "normal_long_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "normal_long_l" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "normal_long_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "normal_long_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "normal_long_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "normal_long_r" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_engage", ::fx_exo_climb_rglove_engage, "normal_long_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_engage", ::fx_exo_climb_lglove_engage, "normal_long_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "normal_long_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "normal_long_u" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_r_glove_disengage", ::fx_exo_climb_rglove_disengage, "dismount" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_l_glove_disengage", ::fx_exo_climb_lglove_disengage, "dismount" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "fx_gloves_off", ::fx_exo_climb_gloves_off, "dismount" );
}

play_new_and_kill_old_fx_l( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.previously_played_fx_name_l ) && isdefined( var_0.previously_played_fx_joint_l ) && var_1 == var_0.previously_played_fx_name_l && var_2 == var_0.previously_played_fx_joint_l )
        var_3 = 0;
    else
    {
        if ( isdefined( var_0.previously_played_fx_name_l ) )
            killfxontag( common_scripts\utility::getfx( var_0.previously_played_fx_name_l ), var_0, var_0.previously_played_fx_joint_l );

        playfxontag( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
    }

    var_0.previously_played_fx_name_l = var_1;
    var_0.previously_played_fx_joint_l = var_2;
}

play_new_and_kill_old_fx_r( var_0, var_1, var_2 )
{
    if ( isdefined( var_0.previously_played_fx_name_r ) && isdefined( var_0.previously_played_fx_joint_r ) && var_1 == var_0.previously_played_fx_name_r && var_2 == var_0.previously_played_fx_joint_r )
    {

    }
    else
    {
        if ( isdefined( var_0.previously_played_fx_name_r ) )
            killfxontag( common_scripts\utility::getfx( var_0.previously_played_fx_name_r ), var_0, var_0.previously_played_fx_joint_r );

        playfxontag( common_scripts\utility::getfx( var_1 ), var_0, var_2 );
    }

    var_0.previously_played_fx_name_r = var_1;
    var_0.previously_played_fx_joint_r = var_2;
}

fx_exo_climb_rglove_engage( var_0 )
{
    play_new_and_kill_old_fx_r( var_0, "exo_r_gloves_engage", "J_Wrist_RI" );
    playfxontag( common_scripts\utility::getfx( "dust_mag_r_glove_impact" ), var_0, "J_Mid_RI_0" );
}

fx_exo_climb_rglove_disengage( var_0 )
{
    play_new_and_kill_old_fx_r( var_0, "exo_r_gloves_disengage", "J_Wrist_RI" );
    killfxontag( common_scripts\utility::getfx( "exo_r_gloves_engage_slow" ), var_0, "J_Wrist_RI" );
}

fx_exo_climb_lglove_engage( var_0 )
{
    play_new_and_kill_old_fx_l( var_0, "exo_l_gloves_engage", "J_Wrist_LE" );
    killfxontag( common_scripts\utility::getfx( "exo_l_gloves_engage_slow" ), var_0, "J_Wrist_LE" );
    playfxontag( common_scripts\utility::getfx( "dust_mag_l_glove_impact" ), var_0, "J_Mid_LE_0" );
}

fx_exo_climb_lglove_disengage( var_0 )
{
    play_new_and_kill_old_fx_l( var_0, "exo_l_gloves_disengage", "J_Wrist_LE" );
    killfxontag( common_scripts\utility::getfx( "exo_l_gloves_engage_slow" ), var_0, "J_Wrist_LE" );
}

fx_exo_climb_gloves_off( var_0 )
{
    var_0.previously_played_fx_name_l = undefined;
    var_0.previously_played_fx_joint_l = undefined;
    killfxontag( common_scripts\utility::getfx( "exo_l_gloves_engage_slow" ), var_0, "J_Wrist_LE" );
    killfxontag( common_scripts\utility::getfx( "exo_r_gloves_engage_slow" ), var_0, "J_Wrist_RI" );
    waitframe();
    killfxontag( common_scripts\utility::getfx( var_0.previously_played_fx_name_l ), var_0, var_0.previously_played_fx_joint_l );
    var_0.previously_played_fx_name_l = undefined;
    var_0.previously_played_fx_joint_l = undefined;
}

setup_climb_anims_parse_anim_offsets( var_0 )
{
    var_1 = getarraykeys( var_0 );

    foreach ( var_3 in var_1 )
    {
        var_4 = strtok( var_3, "_" );

        if ( var_4[0] == "normal" || var_4[0] == "special" || var_4[0] == "magnetic" || var_4[0] == "jump2mag" || var_4[0] == "mag2jump" )
        {
            if ( !isdefined( level.exo_climb_anim_offsets[var_4[0]] ) )
                level.exo_climb_anim_offsets[var_4[0]] = [];

            if ( var_4[0] == "normal" )
            {
                if ( !isdefined( level.exo_climb_anim_offsets[var_4[0]][var_4[1]] ) )
                    level.exo_climb_anim_offsets[var_4[0]][var_4[1]] = [];

                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]] = [];
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]]["offset"] = getmovedelta( var_0[var_3], 0, 1 );
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]]["angle"] = getangledelta( var_0[var_3], 0, 1 );
                continue;
            }

            if ( var_4[0] == "special" )
            {
                if ( !isdefined( level.exo_climb_anim_offsets[var_4[0]][var_4[1]] ) )
                    level.exo_climb_anim_offsets[var_4[0]][var_4[1]] = [];

                if ( !isdefined( level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]] ) )
                    level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]] = [];

                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]][var_4[3]] = [];
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]][var_4[3]]["offset"] = getmovedelta( var_0[var_3], 0, 1 );
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]][var_4[3]]["angle"] = getangledelta( var_0[var_3], 0, 1 );
                continue;
            }

            if ( var_4[0] == "magnetic" )
            {
                if ( !isdefined( level.exo_climb_anim_offsets[var_4[0]][var_4[1]] ) )
                    level.exo_climb_anim_offsets[var_4[0]][var_4[1]] = [];

                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]] = [];
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]]["offset"] = getmovedelta( var_0[var_3], 0, 1 );
                level.exo_climb_anim_offsets[var_4[0]][var_4[1]][var_4[2]]["angle"] = getangledelta( var_0[var_3], 0, 1 );
                continue;
            }

            if ( var_4[0] == "jump2mag" )
            {
                var_5 = var_4[1];
                level.exo_climb_anim_offsets["jump2mag"][var_5] = [];
                level.exo_climb_anim_offsets["jump2mag"][var_5]["offset"] = getmovedelta( var_0[var_3], 0, 1 );
                level.exo_climb_anim_offsets["jump2mag"][var_5]["angle"] = getangledelta( var_0[var_3], 0, 1 );
                continue;
            }

            if ( var_4[0] == "mag2jump" )
            {
                var_5 = var_4[1];
                level.exo_climb_anim_offsets["mag2jump"][var_5] = [];
                level.exo_climb_anim_offsets["mag2jump"][var_5]["offset"] = getmovedelta( var_0[var_3], 0, 1 );
                level.exo_climb_anim_offsets["mag2jump"][var_5]["angle"] = getangledelta( var_0[var_3], 0, 1 );
            }
        }
    }
}

verify_jump_mount_points()
{
    var_0 = getentarray( "exo_climbing_mount_point", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getent( var_2.target, "targetname" );
        var_4 = getent( var_3.target, "targetname" );
        var_3.mount_org = var_4;
        var_3 thread trigger_handle_jump_mount();
    }
}

verify_mag_mount_points()
{
    var_0 = getentarray( "exoclimb_magnetic_mount_point", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = getent( var_2.target, "targetname" );
        var_4 = getent( var_3.target, "targetname" );
        var_3.mount_org = var_4;
        var_3 thread trigger_handle_mag_mount();
    }
}

get_climb_triggers()
{
    level.exo_climb_jump_trigs = getentarray( "exo_climbing_bounds_trigger", "targetname" );
    level.exo_climb_magnetic_trigs = getentarray( "exo_climbing_magnetic_trigger", "targetname" );
}

trigger_handle_jump_mount()
{
    maps\_utility::addhinttrigger( &"EXOCLIMB_CLIMB_HINT", &"EXOCLIMB_CLIMB_HINT_PC" );
    self.script_flag_false = "flag_exo_climbing_enabled";
    level thread maps\_trigger::trigger_script_flag_false( self );

    for (;;)
    {
        common_scripts\utility::flag_waitopen( "flag_exo_climbing_enabled" );
        var_0 = maps\_shg_utility::hint_button_position( "use", self.origin + ( 0, 0, -15 ), undefined, 200, undefined, self );
        var_1 = common_scripts\utility::waittill_any_return( "trigger", "disable_mount_point" );

        if ( var_1 == "trigger" )
        {
            level thread climbing_player_mount( self.mount_org, "jump" );
            var_0 maps\_shg_utility::hint_button_clear();
            continue;
        }

        var_0 maps\_shg_utility::hint_button_clear();
        self delete();
        return;
    }
}

trigger_handle_mag_mount()
{
    self _meth_817B();
    maps\_utility::addhinttrigger( &"EXOCLIMB_CLIMB_HINT", &"EXOCLIMB_CLIMB_HINT_PC" );
    self.script_flag_false = "flag_exo_climbing_enabled";
    level thread maps\_trigger::trigger_script_flag_false( self );

    for (;;)
    {
        level endon( "flag_cancel_exo_climb" );
        common_scripts\utility::flag_waitopen( "flag_exo_climbing_enabled" );
        var_0 = maps\_shg_utility::hint_button_position( "use", self.origin, undefined, 200, undefined, self );
        var_1 = common_scripts\utility::waittill_any_return( "trigger", "disable_mount_point" );

        if ( var_1 == "trigger" )
        {
            level thread climbing_player_mount( self.mount_org, "magnetic" );
            var_0 maps\_shg_utility::hint_button_clear();
            continue;
        }

        var_0 maps\_shg_utility::hint_button_clear();
        self delete();
        return;
    }
}

climbing_player_mount( var_0, var_1 )
{
    level.player endon( "death" );

    if ( common_scripts\utility::flag( "flag_exo_climbing_enabled" ) )
        return;

    common_scripts\utility::flag_set( "flag_exo_climbing_enabled" );

    if ( isdefined( 1 ) && 1 )
        level thread temp_exoclimb_hud_thread();

    if ( isdefined( var_0.override_rig ) )
    {
        level.exo_climb_rig = var_0.override_rig;
        level.exo_climb_rig.animname = "player_climb_rig";
    }
    else
    {
        level.exo_climb_rig = maps\_utility::spawn_anim_model( "player_climb_rig", level.player.origin, level.player.angles );
        level.exo_climb_rig hide();
    }

    if ( !isdefined( level.exoclimb_combat_enabled ) )
        level.exoclimb_combat_enabled = 1;

    level.exo_climb_rig.facing = "center";

    if ( !isdefined( level.exo_climb_player_center ) )
    {
        level.exo_climb_player_center = spawn( "script_origin", level.exo_climb_rig.origin );
        level.exo_climb_player_center.angles = level.exo_climb_rig.angles;
        var_2 = anglestoforward( level.exo_climb_player_center.angles );
        var_3 = 0 * var_2 + ( 0, 0, 60 );
        level.exo_climb_player_center _meth_804D( level.exo_climb_rig, "tag_origin", var_3, ( 0, 0, 0 ) );
    }

    if ( !isdefined( var_0.override_rig ) )
    {
        level.player maps\_shg_utility::setup_player_for_scene();
        level.player _meth_8300( 0 );
        level.player _meth_8321();
        level.player _meth_8320();
        level.player waittill( "weapon_change" );
    }

    swap_to_climbing_weapon();
    var_4 = "";

    if ( var_1 == "jump" )
        var_4 = "mount2jump";
    else if ( var_1 == "magnetic" )
        var_4 = "mount2mag";
    else
        return;

    var_5 = 0.5;

    if ( !isdefined( var_0.override_rig ) )
    {
        level.player _meth_8080( level.exo_climb_rig, "tag_player", var_5 );
        level.player common_scripts\utility::delaycall( var_5, ::_meth_807D, level.exo_climb_rig, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    }

    var_6 = 120;
    var_7 = 60;
    var_8 = 57;

    if ( var_1 == "magnetic" )
    {
        var_6 = 80;
        var_7 = 60;
        var_8 = 57;

        if ( isdefined( level.player.exo_climb_overrides ) )
        {
            if ( isdefined( level.player.exo_climb_overrides.idle_look_sideways_limit_mag ) )
                var_6 = level.player.exo_climb_overrides.idle_look_sideways_limit_mag;

            if ( isdefined( level.player.exo_climb_overrides.idle_look_up_limit_mag ) )
                var_7 = level.player.exo_climb_overrides.idle_look_up_limit_mag;

            if ( isdefined( level.player.exo_climb_overrides.idle_look_down_limit_mag ) )
                var_8 = level.player.exo_climb_overrides.idle_look_down_limit_mag;
        }
    }

    if ( !isdefined( var_0.override_rig ) )
        level.exo_climb_rig common_scripts\utility::delaycall( var_5, ::show );

    var_9 = var_5 + 0.1;

    if ( isdefined( var_0.override_view_angle_unclamp_time ) )
        var_9 = var_0.override_view_angle_unclamp_time;

    level.player common_scripts\utility::delaycall( var_9, ::_meth_80A2, 0.5, 0, 0, var_6, var_6, var_7, var_8 );
    level.player _meth_8031( 70.0, var_9 + 0.1 );
    level notify( "exoclimb_start_mount_anim" );

    if ( isdefined( var_0.override_anim_org ) && isdefined( var_0.override_anim ) )
    {
        level.scr_anim["player_climb_rig"]["mount_override"] = var_0.override_anim;
        var_0.override_anim_org maps\_anim::anim_single_solo( level.exo_climb_rig, "mount_override" );
    }
    else
        var_0 maps\_anim::anim_single_solo( level.exo_climb_rig, var_4 );

    level.exo_climb_ground_ref_ent = spawn( "script_model", ( 0, 0, 0 ) );
    level.exo_climb_ground_ref_ent _meth_80B1( "tag_origin" );
    level.exo_climb_ground_ref_ent _meth_804D( level.exo_climb_rig, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    if ( !isdefined( level.player.hack_fix_lagos_flank_alley_camera_pop ) || !level.player.hack_fix_lagos_flank_alley_camera_pop )
        level.player _meth_8091( level.exo_climb_ground_ref_ent );

    level.player _meth_80FE( 1.0, 0.6 );
    level thread climbing_player_controller( var_1 );
}

using_variable_grenade( var_0 )
{
    if ( !isdefined( self.variable_grenade ) )
        return 0;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0.size != 2 )
        return 0;

    var_1 = level.player maps\_variable_grenade::get_mode_for_weapon_name( var_0[0] );

    if ( !isdefined( var_1 ) )
        return 0;

    var_1 = level.player maps\_variable_grenade::get_mode_for_weapon_name( var_0[1] );

    if ( !isdefined( var_1 ) )
        return 0;

    return 1;
}

swap_to_climbing_weapon()
{
    maps\_player_exo::player_exo_deactivate();
    var_0 = level.player _meth_82CE();

    if ( level.player using_variable_grenade( var_0 ) )
    {
        var_1 = 0;

        if ( isdefined( var_0[0] ) )
            var_1 = level.player maps\_variable_grenade::get_index_for_weapon_name( var_0[0] );

        var_2 = 0;

        if ( isdefined( var_0[1] ) )
            var_2 = level.player maps\_variable_grenade::get_index_for_weapon_name( var_0[1] );

        var_3["normal"][0] = "tracking_grenade_var_exoclimb";
        var_3["normal"][1] = "contact_grenade_var_exoclimb";
        var_3["normal"][2] = "frag_grenade_var_exoclimb";
        var_3["special"][0] = "paint_grenade_var_exoclimb";
        var_3["special"][1] = "flash_grenade_var_exoclimb";
        var_3["special"][2] = "emp_grenade_var_exoclimb";
        level.exo_climb_rig.stored_variable_grenade = level.player.variable_grenade;
        level.player.variable_grenade = var_3;
        var_4 = [];
        var_4["frag_grenade_var_exoclimb"] = 1;
        var_4["contact_grenade_var_exoclimb"] = 2;
        var_4["tracking_grenade_var_exoclimb"] = 3;
        var_4["paint_grenade_var_exoclimb"] = 4;
        var_4["flash_grenade_var_exoclimb"] = 5;
        var_4["emp_grenade_var_exoclimb"] = 6;
        level.exo_climb_rig.stored_variable_grenade_ui_type = level.player.variable_grenade_ui_type;
        level.player.variable_grenade_ui_type = var_4;

        foreach ( var_6 in var_0 )
            level.player _meth_830F( var_6 );

        level.player _meth_8344( level.player.variable_grenade["normal"][var_1] );
        level.player _meth_830E( level.player.variable_grenade["normal"][var_1] );
        level.player _meth_8319( level.player.variable_grenade["special"][var_2] );
        level.player _meth_830E( level.player.variable_grenade["special"][var_2] );
    }

    level.exo_climb_rig.stored_weapon = level.player maps\_utility::get_storable_current_weapon();
    level.exo_climb_rig.stored_clipsize = level.player _meth_82F8( level.exo_climb_rig.stored_weapon );
    level.exo_climb_rig.stored_stock = level.player _meth_82F9( level.exo_climb_rig.stored_weapon );
    level.player _meth_830F( level.exo_climb_rig.stored_weapon );
}

swap_to_real_weapon()
{
    maps\_player_exo::player_exo_activate();
    level.player _meth_830E( level.exo_climb_rig.stored_weapon );
    level.player _meth_82F6( level.exo_climb_rig.stored_weapon, level.exo_climb_rig.stored_clipsize );
    level.player _meth_82F7( level.exo_climb_rig.stored_weapon, level.exo_climb_rig.stored_stock );
    level.player _meth_8315( level.exo_climb_rig.stored_weapon );

    if ( isdefined( level.exo_climb_rig.stored_variable_grenade ) )
    {
        var_0 = level.player _meth_82CE();
        var_1 = 0;

        if ( isdefined( var_0[0] ) )
            var_1 = level.player maps\_variable_grenade::get_index_for_weapon_name( var_0[0] );

        var_2 = 0;

        if ( isdefined( var_0[1] ) )
            var_2 = level.player maps\_variable_grenade::get_index_for_weapon_name( var_0[1] );

        level.player.variable_grenade = level.exo_climb_rig.stored_variable_grenade;
        level.exo_climb_rig.stored_variable_grenade = undefined;

        foreach ( var_4 in var_0 )
            level.player _meth_830F( var_4 );

        level.player _meth_8344( level.player.variable_grenade["normal"][var_1] );
        level.player _meth_830E( level.player.variable_grenade["normal"][var_1] );
        level.player _meth_8319( level.player.variable_grenade["special"][var_2] );
        level.player _meth_830E( level.player.variable_grenade["special"][var_2] );
    }

    if ( isdefined( level.exo_climb_rig.stored_variable_grenade_ui_type ) )
        level.player.variable_grenade_ui_type = level.exo_climb_rig.stored_variable_grenade_ui_type;
}

stop_player_climbing( var_0 )
{
    if ( !var_0 )
    {
        swap_to_real_weapon();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        level.player _meth_8300( 1 );
        level.player _meth_8322();
        level.player _meth_804F();
        level.exo_climb_rig delete();
    }

    level.exo_climb_rig = undefined;
    level.player _meth_80FF();
    level.exo_climb_player_center _meth_804F();
    level.exo_climb_player_center delete();
    level.exo_climb_player_center = undefined;
    level.player _meth_8091( undefined );
    level.exo_climb_ground_ref_ent _meth_804F();
    level.exo_climb_ground_ref_ent delete();
    level.exo_climb_ground_ref_ent = undefined;
    common_scripts\utility::flag_clear( "flag_exo_climbing_enabled" );
    level.player notify( "stop_player_climbing" );
}

enter_state_on_jump_surface()
{
    level.exo_climb_rig.surface_state = "on_jump_surface";
    climbing_update_available_moving_options();
}

enter_state_on_mag_surface()
{
    level.exo_climb_rig.surface_state = "on_mag_surface";
    level.exo_climb_rig.mag_move_dir = "";
    level.exo_climb_rig.next_chain_move = undefined;
    climbing_update_available_moving_options();
}

enter_state_mag_to_jump_surface()
{
    level.exo_climb_rig.surface_state = "mag_to_jump_surface";
    reset_button_buffers();
}

reset_button_buffers()
{
    level.exo_climb_rig.jumpbuttonbuffer = 0.0;
    level.exo_climb_rig.combatbuttonbuffer = 0.0;
}

update_button_buffers()
{
    if ( level.player _meth_83DE() )
        level.exo_climb_rig.jumpbuttonbuffer = 0.6;
    else if ( level.exo_climb_rig.jumpbuttonbuffer > 0.0 )
        level.exo_climb_rig.jumpbuttonbuffer -= 0.05;

    if ( level.player _meth_824C( "Button_B" ) || level.player attackbuttonpressed() || level.player adsbuttonpressed() || level.player _meth_82EE() || level.player _meth_82EF() )
        level.exo_climb_rig.combatbuttonbuffer = 0.6;
    else if ( level.exo_climb_rig.combatbuttonbuffer > 0.0 )
        level.exo_climb_rig.combatbuttonbuffer -= 0.05;
}

climbing_player_controller( var_0 )
{
    level.player endon( "stop_player_climbing" );
    wait 0.05;
    reset_button_buffers();

    if ( var_0 == "jump" )
        enter_state_on_jump_surface();
    else if ( var_0 == "magnetic" )
        enter_state_on_mag_surface();
    else
        return;

    restore_idle();

    for (;;)
    {
        if ( isdefined( level.exo_climb_retest_jumps_triggers ) )
            climbing_update_available_moving_options();

        if ( level.exo_climb_rig.surface_state == "on_jump_surface" )
        {
            update_button_buffers();

            if ( climbing_helper_player_in_combat_mode() && level.player _meth_812C() )
                climbing_motion_player_combat_mode();
            else if ( climbing_helper_player_dismount_requested() )
                climbing_motion_dismount();
            else if ( climbing_helper_player_jump_requested() && climbing_helper_player_input_1_allowed() )
            {
                var_1 = get_requested_jump_direction();

                if ( jump_to_mag_direction_is_valid( var_1 ) )
                {
                    if ( climbing_helper_player_in_combat_mode() )
                        climbing_motion_stop_player_combat_mode_quick();

                    climbing_motion_start_player_jump_to_mag( var_1 );
                }
                else if ( jump_direction_is_valid( var_1 ) )
                {
                    if ( climbing_helper_player_in_combat_mode() )
                        climbing_motion_stop_player_combat_mode_quick();

                    climbing_motion_start_player_jump( var_1 );
                }
                else
                    level.exo_climb_rig.jumpbuttonbuffer = 0.0;
            }
            else if ( climbing_helper_player_combat_requested() && climbing_helper_player_input_1_allowed() && !climbing_helper_player_in_combat_mode() && level.exoclimb_combat_enabled )
                climbing_motion_start_player_shooting();
            else if ( climbing_helper_player_jumping() )
                climbing_motion_player_jumping();
            else if ( climbing_helper_player_in_combat_mode() && climbing_helper_player_exit_combat_mode_requested() )
            {
                climbing_motion_stop_player_combat_mode();
                level.exo_climb_rig.combatbuttonbuffer = 0.0;
            }
            else if ( climbing_helper_player_in_combat_mode() )
                climbing_motion_player_combat_mode();
            else
                climbing_motion_player_looking();
        }
        else if ( level.exo_climb_rig.surface_state == "on_mag_surface" )
        {
            if ( climbing_helper_player_mag_moving() )
            {
                var_1 = get_requested_move_direction();

                if ( climbing_helper_player_input_1_allowed() && var_1 == level.exo_climb_rig.mag_move_dir && magnetic_hands_direction_is_valid( var_1 ) )
                    climbing_motion_start_player_mag_move( var_1 );
                else if ( climbing_helper_player_input_2_allowed() && var_1 != level.exo_climb_rig.mag_move_dir && magnetic_hands_direction_is_valid( var_1 ) )
                    climbing_motion_start_player_mag_move( var_1 );
                else if ( climbing_helper_player_input_1_allowed() && mag_to_jump_direction_is_valid( var_1 ) )
                    climbing_motion_start_player_mag_to_jump( var_1 );
                else
                    climbing_motion_player_moving_on_magnetic_surface();
            }
            else
            {
                var_1 = get_requested_move_direction();

                if ( magnetic_hands_direction_is_valid( var_1 ) )
                    climbing_motion_start_player_mag_move( var_1 );
                else if ( mag_to_jump_direction_is_valid( var_1 ) )
                    climbing_motion_start_player_mag_to_jump( var_1 );
            }
        }
        else if ( level.exo_climb_rig.surface_state == "jump_to_mag_surface" )
            climbing_motion_player_jump_to_mag();
        else if ( level.exo_climb_rig.surface_state == "mag_to_jump_surface" )
        {
            update_button_buffers();

            if ( climbing_helper_player_input_1_allowed() )
                enter_state_on_jump_surface();
            else
                climbing_motion_player_mag_to_jump();
        }

        wait 0.05;
    }
}

restore_idle()
{
    if ( level.exo_climb_rig.surface_state == "on_mag_surface" )
        level thread climbing_animation_idle_loop( "magnetic" );
    else if ( level.exo_climb_rig.facing == "right" )
        level thread climbing_animation_idle_loop( "right" );
    else if ( level.exo_climb_rig.facing == "right_back" )
        level thread climbing_animation_idle_loop( "right_back" );
    else if ( level.exo_climb_rig.facing == "left" )
        level thread climbing_animation_idle_loop( "left" );
    else if ( level.exo_climb_rig.facing == "left_back" )
        level thread climbing_animation_idle_loop( "left_back" );
    else
        level thread climbing_animation_idle_loop();
}

exo_climb_grab_rumble( var_0 )
{
    var_1 = randomfloat( 360 );
    var_2 = anglestoright( level.exo_climb_rig.angles );
    var_3 = anglestoup( level.exo_climb_rig.angles );
    var_4 = sin( var_1 ) * var_3 + cos( var_1 ) * var_2;
    var_5 = 0.9;
    glassradiusdamage( level.exo_climb_rig.origin, 84, 10, 10, var_5, var_4 );
    level.player _meth_80AD( "falling_land" );
}

exo_climb_jump_rumble( var_0 )
{
    level.player _meth_80AD( "damage_light" );
}

exo_climb_mag_rumble( var_0 )
{
    level.player _meth_80AD( "damage_light" );
}

exo_climb_grab_shake( var_0 )
{
    level.player _meth_83FE( 12, 6, 2, 0.5, 0, 0.25, 128, 10, 5, 5, 2 );
}

exo_climb_jump_shake( var_0 )
{
    level.player _meth_83FE( 4, 2, 0.5, 0.5, 0, 0.25, 128, 10, 5, 5, 2 );
}

exo_climb_allow_player_input_1( var_0 )
{
    level.exo_climb_rig.allow_player_input_1 = 1;
    climbing_update_available_moving_options();
}

exo_climb_allow_player_input_2( var_0 )
{
    level.exo_climb_rig.allow_player_input_2 = 1;
}

climbing_motion_start_player_jump( var_0 )
{
    if ( level.exo_climb_move_options["long"][var_0] != "blocked" )
    {
        var_1 = level.exo_climb_move_options["long"][var_0];
        thread climbing_animation_traverse_move( var_1, 2 );

        if ( var_0 == "u" )
        {
            var_2 = level.player getangles()[0];

            if ( var_2 < 20.0 )
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 100.0, 0.4 );
            else
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 85.0, 0.4 );

            level.player common_scripts\utility::delaycall( 0.9, ::_meth_8031, 70.0, 0.15 );
        }
        else if ( var_0 == "d" )
        {
            var_2 = level.player getangles()[0];

            if ( var_2 > -20.0 )
                level.player _meth_8031( 100.0, 0.5 );
            else
                level.player _meth_8031( 85.0, 0.5 );

            level.player common_scripts\utility::delaycall( 0.7, ::_meth_8031, 70.0, 0.4 );
        }
        else if ( var_0 == "l" )
        {
            var_3 = get_player_local_yaw();

            if ( var_3 > -20.0 )
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 100.0, 0.4 );
            else
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 85.0, 0.4 );

            level.player common_scripts\utility::delaycall( 0.7, ::_meth_8031, 70.0, 0.4 );
        }
        else if ( var_0 == "r" )
        {
            var_3 = get_player_local_yaw();

            if ( var_3 < 20.0 )
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 100.0, 0.4 );
            else
                level.player common_scripts\utility::delaycall( 0.2, ::_meth_8031, 85.0, 0.4 );

            level.player common_scripts\utility::delaycall( 0.7, ::_meth_8031, 70.0, 0.4 );
        }
    }
    else if ( level.exo_climb_move_options["short"][var_0] != "blocked" )
    {
        var_1 = level.exo_climb_move_options["short"][var_0];
        thread climbing_animation_traverse_move( var_1, 0 );
    }
    else
        return;

    level.exo_climb_rig.is_jumping = 1;
    level.exo_climb_rig.allow_player_input_1 = undefined;
    level.exo_climb_rig.allow_player_input_2 = undefined;
}

climbing_motion_start_player_jump_to_mag( var_0 )
{
    var_1 = "jump2mag_" + var_0;
    thread climbing_animation_traverse_move( var_1, 2 );
    level.exo_climb_rig.surface_state = "jump_to_mag_surface";
    level.exo_climb_rig.is_jumping = undefined;
    var_2 = 80;
    var_3 = 60;
    var_4 = 57;

    if ( isdefined( level.player.exo_climb_overrides ) )
    {
        if ( isdefined( level.player.exo_climb_overrides.idle_look_sideways_limit_mag ) )
            var_2 = level.player.exo_climb_overrides.idle_look_sideways_limit_mag;

        if ( isdefined( level.player.exo_climb_overrides.idle_look_up_limit_mag ) )
            var_3 = level.player.exo_climb_overrides.idle_look_up_limit_mag;

        if ( isdefined( level.player.exo_climb_overrides.idle_look_down_limit_mag ) )
            var_4 = level.player.exo_climb_overrides.idle_look_down_limit_mag;
    }

    level.player _meth_80A2( 0.5, 0, 0, var_2, var_2, var_3, var_4 );
    level.exo_climb_rig.allow_player_input_1 = undefined;
    level.exo_climb_rig.allow_player_input_2 = undefined;
}

climbing_motion_player_jumping()
{
    if ( isdefined( level.exo_climb_rig.current_traverse_anime ) )
    {
        var_0 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
        var_1 = level.exo_climb_rig _meth_814F( var_0 );

        if ( var_1 >= 1.0 )
        {
            level.exo_climb_rig.is_jumping = undefined;

            if ( level.nextgen )
                _func_0D3( "r_mbEnable", "0" );

            climbing_update_available_moving_options();
            restore_idle();
        }
    }
}

climbing_motion_player_moving_on_magnetic_surface()
{
    if ( isdefined( level.exo_climb_rig.current_traverse_anime ) )
    {
        var_0 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
        var_1 = level.exo_climb_rig _meth_814F( var_0 );

        if ( var_1 >= 1.0 )
        {
            level.exo_climb_rig.mag_move_dir = "";
            level.exo_climb_rig.next_chain_move = undefined;
            climbing_update_available_moving_options();

            if ( isdefined( level.exo_climb_force_animated_dismount ) )
                climbing_motion_dismount();
            else
                restore_idle();

            if ( level.nextgen )
                _func_0D3( "r_mbEnable", "0" );
        }
    }
}

climbing_motion_player_jump_to_mag()
{
    if ( isdefined( level.exo_climb_rig.current_traverse_anime ) )
    {
        var_0 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
        var_1 = level.exo_climb_rig _meth_814F( var_0 );

        if ( var_1 >= 1.0 )
        {
            enter_state_on_mag_surface();
            restore_idle();

            if ( level.nextgen )
                _func_0D3( "r_mbEnable", "0" );
        }
    }
}

climbing_motion_player_mag_to_jump()
{
    if ( climbing_helper_player_input_1_allowed() )
        enter_state_on_jump_surface();
    else if ( isdefined( level.exo_climb_rig.current_traverse_anime ) )
    {
        var_0 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
        var_1 = level.exo_climb_rig _meth_814F( var_0 );

        if ( var_1 >= 1.0 )
        {
            level.exo_climb_rig.is_jumping = undefined;
            enter_state_on_jump_surface();

            if ( level.nextgen )
                _func_0D3( "r_mbEnable", "0" );

            restore_idle();
        }
    }
}

get_direction_from_normalized_movement( var_0 )
{
    var_1 = angleclamp360( var_0[0], var_0[1] );
    var_2 = "";

    if ( var_1 < -135.0 || var_1 > 135.0 )
        var_2 = "l";
    else if ( var_1 < -45.0 )
        var_2 = "d";
    else if ( var_1 < 45.0 )
        var_2 = "r";
    else
        var_2 = "u";

    return var_2;
}

get_requested_jump_direction()
{
    var_0 = "u";
    var_1 = level.player _meth_82F3();
    var_2 = length2d( var_1 );

    if ( var_2 > 0.15 )
        var_0 = get_direction_from_normalized_movement( var_1 );

    return var_0;
}

jump_to_mag_direction_is_valid( var_0 )
{
    return level.exo_climb_move_options["jump2mag"][var_0] != "blocked";
}

jump_direction_is_valid( var_0 )
{
    return level.exo_climb_move_options["long"][var_0] != "blocked" || level.exo_climb_move_options["short"][var_0] != "blocked";
}

get_requested_move_direction()
{
    var_0 = level.player _meth_82F3();

    if ( length2d( var_0 ) <= 0.15 )
        return "";

    return get_direction_from_normalized_movement( var_0 );
}

magnetic_hands_direction_is_valid( var_0 )
{
    return var_0 != "" && level.exo_climb_move_options["magnetic"][var_0] != "blocked";
}

mag_to_jump_direction_is_valid( var_0 )
{
    return var_0 != "" && level.exo_climb_move_options["mag2jump"][var_0] != "blocked";
}

climbing_motion_start_player_mag_move( var_0 )
{
    if ( isdefined( level.exo_climb_rig.next_chain_move ) )
    {
        if ( level.exo_climb_rig.next_chain_move == "1" )
        {
            var_1 = "magnetic_" + var_0 + "_1";
            level.exo_climb_rig.next_chain_move = "2";
        }
        else
        {
            var_1 = "magnetic_" + var_0 + "_2";
            level.exo_climb_rig.next_chain_move = "1";
        }
    }
    else
    {
        var_1 = "magnetic_" + var_0 + "_0";
        level.exo_climb_rig.next_chain_move = "2";
    }

    level.exo_climb_rig.allow_player_input_1 = undefined;
    level.exo_climb_rig.allow_player_input_2 = undefined;
    level.exo_climb_rig.mag_move_dir = var_0;
    thread climbing_animation_traverse_move( var_1, 1 );
}

climbing_motion_start_player_mag_to_jump( var_0 )
{
    var_1 = "mag2jump_" + var_0;
    thread climbing_animation_traverse_move( var_1, 2 );
    enter_state_mag_to_jump_surface();
    level.exo_climb_rig.is_jumping = 1;
    level.player _meth_80A2( 0.5, 0, 0, 120, 120, 60, 57 );
    level.exo_climb_rig.allow_player_input_1 = undefined;
    level.exo_climb_rig.allow_player_input_2 = undefined;
}

climbing_update_available_moving_options()
{
    level.exo_climb_retest_jumps_triggers = undefined;
    var_0 = spawn( "script_origin", level.exo_climb_player_center.origin );
    level.exo_climb_move_options["long"]["u"] = "blocked";
    level.exo_climb_move_options["long"]["d"] = "blocked";
    level.exo_climb_move_options["long"]["l"] = "blocked";
    level.exo_climb_move_options["long"]["r"] = "blocked";
    level.exo_climb_move_options["short"]["u"] = "blocked";
    level.exo_climb_move_options["short"]["d"] = "blocked";
    level.exo_climb_move_options["short"]["l"] = "blocked";
    level.exo_climb_move_options["short"]["r"] = "blocked";
    level.exo_climb_move_options["magnetic"]["u"] = "blocked";
    level.exo_climb_move_options["magnetic"]["d"] = "blocked";
    level.exo_climb_move_options["magnetic"]["l"] = "blocked";
    level.exo_climb_move_options["magnetic"]["r"] = "blocked";
    level.exo_climb_move_options["jump2mag"]["u"] = "blocked";
    level.exo_climb_move_options["jump2mag"]["d"] = "blocked";
    level.exo_climb_move_options["jump2mag"]["l"] = "blocked";
    level.exo_climb_move_options["jump2mag"]["r"] = "blocked";
    level.exo_climb_move_options["mag2jump"]["u"] = "blocked";
    level.exo_climb_move_options["mag2jump"]["d"] = "blocked";
    level.exo_climb_move_options["mag2jump"]["l"] = "blocked";
    level.exo_climb_move_options["mag2jump"]["r"] = "blocked";

    if ( ( level.exo_climb_rig.surface_state == "on_mag_surface" || level.exo_climb_rig.surface_state == "jump_to_mag_surface" ) && isdefined( level.exo_climb_anim_offsets["magnetic"] ) )
    {
        var_1 = getarraykeys( level.exo_climb_anim_offsets["magnetic"] );

        foreach ( var_3 in var_1 )
        {
            var_0.origin = level.exo_climb_player_center _meth_81B0( level.exo_climb_anim_offsets["magnetic"][var_3]["0"]["offset"] );

            foreach ( var_5 in level.exo_climb_magnetic_trigs )
            {
                if ( var_0 _meth_80A9( var_5 ) )
                {
                    if ( isdefined( var_5.script_noteworthy ) && issubstr( var_5.script_noteworthy, "exo_climb_toggle_trigger" ) )
                    {
                        if ( isdefined( var_5.allow_exo_climb ) )
                            level.exo_climb_move_options["magnetic"][var_3] = "ok";
                    }
                    else
                        level.exo_climb_move_options["magnetic"][var_3] = "ok";

                    break;
                }
            }
        }
    }

    if ( level.exo_climb_rig.surface_state == "on_jump_surface" && isdefined( level.exo_climb_anim_offsets["jump2mag"] ) )
    {
        var_8 = getarraykeys( level.exo_climb_anim_offsets["jump2mag"] );

        foreach ( var_3 in var_8 )
        {
            var_0.origin = level.exo_climb_player_center _meth_81B0( level.exo_climb_anim_offsets["jump2mag"][var_3]["offset"] );

            foreach ( var_5 in level.exo_climb_magnetic_trigs )
            {
                if ( var_0 _meth_80A9( var_5 ) )
                {
                    if ( isdefined( var_5.script_noteworthy ) && issubstr( var_5.script_noteworthy, "exo_climb_toggle_trigger" ) )
                    {
                        if ( isdefined( var_5.allow_exo_climb ) )
                            level.exo_climb_move_options["jump2mag"][var_3] = "ok";
                    }
                    else
                        level.exo_climb_move_options["jump2mag"][var_3] = "ok";

                    break;
                }
            }
        }
    }

    if ( level.exo_climb_rig.surface_state == "on_mag_surface" && isdefined( level.exo_climb_anim_offsets["mag2jump"] ) )
    {
        var_13 = getarraykeys( level.exo_climb_anim_offsets["mag2jump"] );

        foreach ( var_3 in var_13 )
        {
            var_0.origin = level.exo_climb_player_center _meth_81B0( level.exo_climb_anim_offsets["mag2jump"][var_3]["offset"] );

            foreach ( var_5 in level.exo_climb_jump_trigs )
            {
                if ( var_0 _meth_80A9( var_5 ) )
                {
                    if ( isdefined( var_5.script_noteworthy ) && issubstr( var_5.script_noteworthy, "exo_climb_toggle_trigger" ) )
                    {
                        if ( isdefined( var_5.allow_exo_climb ) )
                            level.exo_climb_move_options["mag2jump"][var_3] = "ok";
                    }
                    else
                        level.exo_climb_move_options["mag2jump"][var_3] = "ok";

                    break;
                }
            }
        }
    }

    if ( ( level.exo_climb_rig.surface_state == "on_jump_surface" || level.exo_climb_rig.surface_state == "mag_to_jump_surface" ) && isdefined( level.exo_climb_anim_offsets["normal"] ) )
    {
        var_18 = getarraykeys( level.exo_climb_anim_offsets["normal"] );

        foreach ( var_20 in var_18 )
        {
            var_21 = getarraykeys( level.exo_climb_anim_offsets["normal"][var_20] );

            foreach ( var_3 in var_21 )
            {
                var_0.origin = level.exo_climb_player_center _meth_81B0( level.exo_climb_anim_offsets["normal"][var_20][var_3]["offset"] );

                foreach ( var_5 in level.exo_climb_jump_trigs )
                {
                    if ( var_0 _meth_80A9( var_5 ) )
                    {
                        if ( isdefined( var_5.script_noteworthy ) && issubstr( var_5.script_noteworthy, "exo_climb_toggle_trigger" ) )
                        {
                            if ( isdefined( var_5.allow_exo_climb ) )
                                level.exo_climb_move_options[var_20][var_3] = "normal_" + var_20 + "_" + var_3;
                        }
                        else
                            level.exo_climb_move_options[var_20][var_3] = "normal_" + var_20 + "_" + var_3;

                        break;
                    }
                }
            }
        }

        var_18 = getarraykeys( level.exo_climb_anim_offsets["special"] );

        foreach ( var_20 in var_18 )
        {
            var_21 = getarraykeys( level.exo_climb_anim_offsets["special"][var_20] );

            foreach ( var_3 in var_21 )
            {
                if ( level.exo_climb_move_options[var_20][var_3] != "blocked" )
                    continue;

                var_29 = getarraykeys( level.exo_climb_anim_offsets["special"][var_20][var_3] );

                foreach ( var_31 in var_29 )
                {
                    if ( level.exo_climb_move_options[var_20][var_3] != "blocked" )
                        continue;

                    var_0.origin = level.exo_climb_player_center _meth_81B0( level.exo_climb_anim_offsets["special"][var_20][var_3][var_31]["offset"] );

                    foreach ( var_5 in level.exo_climb_jump_trigs )
                    {
                        if ( var_0 _meth_80A9( var_5 ) )
                        {
                            if ( isdefined( var_5.script_noteworthy ) && issubstr( var_5.script_noteworthy, "exo_climb_toggle_trigger" ) )
                            {
                                if ( isdefined( var_5.allow_exo_climb ) )
                                    level.exo_climb_move_options[var_20][var_3] = "special_" + var_20 + "_" + var_3 + "_" + var_31;
                            }
                            else
                                level.exo_climb_move_options[var_20][var_3] = "special_" + var_20 + "_" + var_3 + "_" + var_31;

                            break;
                        }
                    }
                }
            }
        }
    }

    var_0 delete();

    if ( isdefined( level.exo_climb_rig.is_linked ) )
        level.exo_climb_retest_jumps_triggers = 1;
}

get_player_local_yaw()
{
    var_0 = level.player getangles()[1];

    if ( var_0 > 180 )
        var_0 -= 360;

    return var_0;
}

climbing_motion_player_looking()
{
    var_0 = get_player_local_yaw();

    if ( level.exo_climb_rig.facing == "center" )
    {
        if ( var_0 > 30 )
            climbing_animation_idle_to_side_idle( "left" );
        else if ( var_0 < -30 )
            climbing_animation_idle_to_side_idle( "right" );
    }
    else if ( level.exo_climb_rig.facing == "left" )
    {
        if ( var_0 < 25 )
            climbing_animation_side_idle_to_idle( "left" );
        else if ( var_0 > 90 )
            climbing_animation_side_idle_to_back( "left" );
    }
    else if ( level.exo_climb_rig.facing == "left_back" )
    {
        if ( var_0 < 80 )
            climbing_animation_back_to_side_idle( "left" );
    }
    else if ( level.exo_climb_rig.facing == "right" )
    {
        if ( var_0 > -25 )
            climbing_animation_side_idle_to_idle( "right" );
        else if ( var_0 < -90 )
            climbing_animation_side_idle_to_back( "right" );
    }
    else if ( var_0 > -80 )
        climbing_animation_back_to_side_idle( "right" );
}

climbing_motion_player_combat_mode()
{
    if ( !level.player _meth_824C( "BUTTON_B" ) )
        level.exo_climb_rig.crouch_button_reset = 1;

    var_0 = get_player_local_yaw();

    if ( level.exo_climb_rig.facing == "center" )
    {
        if ( var_0 > 30 )
        {
            climbing_animation_stop_idle();
            level.exo_climb_rig.facing = "left";
            level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "combat_center_to_left" );
            level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "combat_idle_left", "stop_climb_idle" );
        }
        else if ( var_0 < -30 )
        {
            climbing_animation_stop_idle();
            level.exo_climb_rig.facing = "right";
            level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "combat_center_to_right" );
            level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "combat_idle_right", "stop_climb_idle" );
        }
    }
    else if ( level.exo_climb_rig.facing == "left" )
    {
        if ( var_0 < 25 )
        {
            climbing_animation_stop_idle();
            level.exo_climb_rig.facing = "center";
            level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "combat_left_to_center" );
            level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "combat_idle", "stop_climb_idle" );
        }
    }
    else if ( var_0 > -25 )
    {
        climbing_animation_stop_idle();
        level.exo_climb_rig.facing = "center";
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "combat_right_to_center" );
        level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "combat_idle", "stop_climb_idle" );
    }
}

exo_climb_draw_weapon( var_0 )
{
    climbing_give_player_weapon( "right" );
}

climbing_motion_start_player_shooting()
{
    climbing_animation_stop_idle();
    level.exo_climb_rig.facing = "center";
    level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "climb_to_combat_idle" );
    level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "combat_idle", "stop_climb_idle" );
    level.exo_climb_rig.crouch_button_reset = undefined;
    level.exo_climb_rig.is_jumping = undefined;
}

climbing_motion_stop_player_combat_mode_quick()
{
    level.player _meth_8300( 0 );
    level.player _meth_831D();
    var_0 = level.player _meth_8311();
    level.exo_climb_rig.stored_clipsize = level.player _meth_82F8( var_0 );
    level.exo_climb_rig.stored_stock = level.player _meth_82F9( var_0 );
    level.player _meth_830F( var_0 );
    level.exo_climb_rig.in_combat_mode = undefined;
    climbing_animation_stop_idle();
}

climbing_motion_stop_player_combat_mode()
{
    level.player _meth_8300( 0 );
    level.player _meth_831D();
    level.player waittill( "weapon_change" );
    var_0 = level.player _meth_8311();
    level.exo_climb_rig.stored_clipsize = level.player _meth_82F8( var_0 );
    level.exo_climb_rig.stored_stock = level.player _meth_82F9( var_0 );
    level.player _meth_830F( var_0 );
    level.exo_climb_rig.in_combat_mode = undefined;
    climbing_animation_stop_idle();
    level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "combat_to_climb_idle" );
    level.exo_climb_rig.facing = "center";
    level thread climbing_animation_idle_loop();
}

climbing_motion_dismount()
{
    level.player _meth_8031( 65.0, 1.0 );

    if ( level.nextgen )
        _func_0D3( "r_mbEnable", "0" );

    if ( climbing_helper_player_in_combat_mode() )
        climbing_motion_stop_player_combat_mode();

    climbing_animation_dismount();
}

climbing_give_player_weapon( var_0 )
{
    level.exo_climb_rig.in_combat_mode = 1;
    var_1 = "iw5_sn6_sp";
    var_2 = getarraykeys( level.exo_climb_weapon );
    var_3 = common_scripts\utility::array_contains( var_2, level.exo_climb_rig.stored_weapon );

    if ( var_3 )
        var_4 = level.exo_climb_weapon[level.exo_climb_rig.stored_weapon][var_0];
    else
        var_4 = level.exo_climb_weapon[var_1][var_0];

    level.player _meth_830E( var_4 );
    level.player _meth_8315( var_4 );
    level.player _meth_82F6( var_4, level.exo_climb_rig.stored_clipsize );
    level.player _meth_82F7( var_4, level.exo_climb_rig.stored_stock );
    level.player _meth_831E();
    level.player waittill( "weapon_change" );
    level.player _meth_8300( 1 );
}

climbing_animation_stop_idle()
{
    level.exo_climb_rig notify( "stop_climb_idle" );
    level.exo_climb_rig maps\_utility::anim_stopanimscripted();
}

climbing_animation_idle_to_side_idle( var_0 )
{
    climbing_animation_stop_idle();
    level.exo_climb_rig.facing = var_0;
    level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idle_to_idle" + var_0 );
    level thread climbing_animation_idle_loop( var_0 );
}

climbing_animation_side_idle_to_back( var_0 )
{
    climbing_animation_stop_idle();

    if ( var_0 == "left" )
    {
        level.exo_climb_rig.facing = "left_back";
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idleleft_to_idleleftback" );
        level thread climbing_animation_idle_loop( "left_back" );
    }
    else
    {
        level.exo_climb_rig.facing = "right_back";
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idleright_to_idlerightback" );
        level thread climbing_animation_idle_loop( "right_back" );
    }
}

climbing_animation_back_to_side_idle( var_0 )
{
    climbing_animation_stop_idle();
    level.exo_climb_rig.facing = var_0;

    if ( var_0 == "left" )
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idleleftback_to_idleleft" );
    else
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idlerightback_to_idleright" );

    level thread climbing_animation_idle_loop( var_0 );
}

climbing_animation_side_idle_to_idle( var_0 )
{
    climbing_animation_stop_idle();
    level.exo_climb_rig.facing = "center";
    level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "idle" + var_0 + "_to_idle" );
    level thread climbing_animation_idle_loop();
}

climbing_animation_idle_loop( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "";

    if ( var_0 == "magnetic" )
        level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "idle_magnetic_gloves", "stop_climb_idle" );
    else
        level.exo_climb_rig thread maps\_anim::anim_loop_solo( level.exo_climb_rig, "idle" + var_0, "stop_climb_idle" );
}

climbing_animation_traverse_move( var_0, var_1 )
{
    climbing_animation_stop_idle();
    level.exo_climb_rig.current_traverse_anime = var_0;
    level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, var_0 );

    if ( level.nextgen )
    {
        if ( var_1 == 0 )
            _func_0D3( "r_mbEnable", "0" );
        else if ( var_1 == 1 )
        {
            _func_0D3( "r_mbEnable", "2" );
            _func_0D3( "r_mbVelocityScalar", "2" );
        }
        else
        {
            _func_0D3( "r_mbEnable", "2" );
            _func_0D3( "r_mbVelocityScalar", "6" );
        }
    }
}

climbing_animation_dismount()
{
    climbing_animation_stop_idle();
    level.player _meth_8091( undefined );
    level.player _meth_80A2( 0.5, 0, 0, 0, 0, 0, 0 );
    level.exo_climb_rig _meth_808E();
    var_0 = 0;

    if ( isdefined( level.exo_climb_force_animated_dismount ) )
    {
        var_1 = level.exo_climb_animated_dismount["org"];
        var_2 = level.exo_climb_animated_dismount["animname"];
        var_3 = level.exo_climb_animated_dismount["anime"];
        var_1 maps\_anim::anim_single_solo( level.exo_climb_rig, var_3, undefined, undefined, var_2 );
        level.exo_climb_force_animated_dismount = undefined;

        if ( isdefined( level.exo_climb_animated_dismount["keep_rig"] ) )
            var_0 = 1;
    }
    else
        level.exo_climb_rig maps\_anim::anim_single_solo( level.exo_climb_rig, "dismount" );

    stop_player_climbing( var_0 );
}

climbing_head_sway()
{
    level.player endon( "death" );
    level.player endon( "stop_player_climbing" );

    for (;;)
    {
        _func_234( level.player.origin, 3, 5, 1, 2, 0.2, 0.2, 0, 0.3, 0.375, 0.225 );
        wait 1.0;
    }
}

climbing_helper_player_jumping()
{
    return isdefined( level.exo_climb_rig.is_jumping );
}

climbing_helper_player_moving()
{
    return climbing_helper_player_jumping() || climbing_helper_player_mag_moving() || isdefined( level.exo_climb_rig.surface_state ) && level.exo_climb_rig.surface_state == "jump_to_mag_surface" || isdefined( level.exo_climb_rig.surface_state ) && level.exo_climb_rig.surface_state == "mag_to_jump_surface";
}

climbing_helper_player_mag_moving()
{
    return isdefined( level.exo_climb_rig.surface_state ) && level.exo_climb_rig.surface_state == "on_mag_surface" && isdefined( level.exo_climb_rig.mag_move_dir ) && level.exo_climb_rig.mag_move_dir != "";
}

climbing_helper_player_input_1_allowed()
{
    if ( isdefined( level.exo_climb_force_animated_dismount ) )
        return 0;

    if ( isdefined( level.exo_climb_rig.allow_player_input_1 ) )
        return 1;

    if ( !climbing_helper_player_moving() )
        return 1;

    return 0;
}

climbing_helper_player_input_2_allowed()
{
    if ( isdefined( level.exo_climb_force_animated_dismount ) )
        return 0;

    if ( isdefined( level.exo_climb_rig.allow_player_input_2 ) )
        return 1;

    if ( !climbing_helper_player_moving() )
        return 1;

    return 0;
}

climbing_helper_player_jump_requested()
{
    return level.exo_climb_rig.jumpbuttonbuffer > 0.0;
}

climbing_helper_player_in_combat_mode()
{
    return isdefined( level.exo_climb_rig.in_combat_mode );
}

climbing_helper_dir_is_blocked( var_0 )
{
    return var_0 == "blocked";
}

climbing_helper_player_combat_requested()
{
    return level.exo_climb_rig.combatbuttonbuffer > 0.0;
}

climbing_helper_player_exit_combat_mode_requested()
{
    return isdefined( level.exo_climb_rig.crouch_button_reset ) && level.player _meth_824C( "Button_B" );
}

climbing_helper_player_dismount_requested()
{
    if ( !isdefined( level.exo_climb_rig.dismount_timer ) )
        level.exo_climb_rig.dismount_timer = 500;

    if ( climbing_helper_player_moving() )
    {
        level.exo_climb_rig.dismount_timer = 500;
        return 0;
    }

    if ( isdefined( level.exo_climb_force_animated_dismount ) )
        return 1;

    if ( level.player _meth_824C( "BUTTON_X" ) )
    {
        if ( isdefined( level.exo_climb_rig.dismount_timer ) && level.exo_climb_rig.dismount_timer < 0 )
            return 1;
        else
            level.exo_climb_rig.dismount_timer -= 50;

        return 0;
    }
    else
    {
        level.exo_climb_rig.dismount_timer = 500;
        return 0;
    }
}

force_animated_dismount( var_0, var_1, var_2, var_3 )
{
    level.exo_climb_force_animated_dismount = 1;
    level.exo_climb_animated_dismount = [];
    level.exo_climb_animated_dismount["org"] = var_0;
    level.exo_climb_animated_dismount["animname"] = var_1;
    level.exo_climb_animated_dismount["anime"] = var_2;
    level.exo_climb_animated_dismount["keep_rig"] = var_3;
}

toggle_mount_mag_trigger_off( var_0, var_1 )
{
    self.allow_exo_climb = undefined;
    level.exo_climb_retest_jumps_triggers = 1;

    if ( !isdefined( level.exo_climb_rig ) )
        return;

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( var_1 ) )
            var_1 = 0;

        var_2 = gettime() + var_1 * 1000;
        var_3 = spawn( "script_origin", level.exo_climb_player_center.origin );

        while ( gettime() < var_2 )
        {
            var_3.origin = level.exo_climb_player_center.origin;
            mag_mount_unlink_player( var_0, var_3 );
            mag_mount_link_player( var_0, var_3 );
            wait 0.05;
        }

        var_3 delete();
    }
}

toggle_mount_mag_trigger_on( var_0 )
{
    self.allow_exo_climb = 1;
    level.exo_climb_retest_jumps_triggers = 1;

    if ( !isdefined( level.exo_climb_rig ) )
        return;

    var_1 = spawn( "script_origin", level.exo_climb_player_center.origin );

    for ( var_2 = 0; var_2 < 5; var_2++ )
    {
        var_1.origin = level.exo_climb_player_center.origin;
        mag_mount_unlink_player( var_0, var_1 );
        wait 0.05;
    }

    var_1 delete();
}

mag_mount_link_player( var_0, var_1 )
{
    if ( !isdefined( var_0.player_linked ) && var_1 _meth_80A9( self ) )
    {
        level.exo_climb_rig _meth_804D( var_0 );
        level.exo_climb_rig.is_linked = 1;
        var_0.player_linked = 1;
    }
}

mag_mount_unlink_player( var_0, var_1 )
{
    if ( isdefined( var_0.player_linked ) )
    {
        level.exo_climb_rig _meth_804F();
        level.exo_climb_rig.is_linked = undefined;
        var_0.player_linked = undefined;
    }
}

init_exoclimb_hud()
{
    if ( isdefined( 1 ) && 1 )
        temp_exoclimb_hud_init();
}

temp_exoclimb_hud_precache()
{
    precacheshader( "hud_arrow_up" );
    precacheshader( "hud_arrow_down" );
    precacheshader( "hud_arrow_left" );
    precacheshader( "hud_arrow_right" );
}

temp_exoclimb_hud_init()
{
    if ( isdefined( level.temp_exoclimb_hud ) )
        return;

    level.temp_exoclimb_hud = spawnstruct();
    level.temp_exoclimb_hud.up_arrow = newhudelem();
    level.temp_exoclimb_hud.up_arrow.x = 320;
    level.temp_exoclimb_hud.up_arrow.y = 324.0;
    level.temp_exoclimb_hud.up_arrow.alignx = "center";
    level.temp_exoclimb_hud.up_arrow.aligny = "middle";
    level.temp_exoclimb_hud.up_arrow.horzalign = "fullscreen";
    level.temp_exoclimb_hud.up_arrow.vertalign = "fullscreen";
    level.temp_exoclimb_hud.up_arrow.color = ( 1, 1, 1 );
    level.temp_exoclimb_hud.up_arrow _meth_80CC( "hud_arrow_up", 64, 64 );
    level.temp_exoclimb_hud.down_arrow = newhudelem();
    level.temp_exoclimb_hud.down_arrow.x = 320;
    level.temp_exoclimb_hud.down_arrow.y = 356.0;
    level.temp_exoclimb_hud.down_arrow.alignx = "center";
    level.temp_exoclimb_hud.down_arrow.aligny = "middle";
    level.temp_exoclimb_hud.down_arrow.horzalign = "fullscreen";
    level.temp_exoclimb_hud.down_arrow.vertalign = "fullscreen";
    level.temp_exoclimb_hud.down_arrow.color = ( 1, 1, 1 );
    level.temp_exoclimb_hud.down_arrow _meth_80CC( "hud_arrow_down", 64, 64 );
    level.temp_exoclimb_hud.left_arrow = newhudelem();
    level.temp_exoclimb_hud.left_arrow.x = 304.0;
    level.temp_exoclimb_hud.left_arrow.y = 340;
    level.temp_exoclimb_hud.left_arrow.alignx = "center";
    level.temp_exoclimb_hud.left_arrow.aligny = "middle";
    level.temp_exoclimb_hud.left_arrow.horzalign = "fullscreen";
    level.temp_exoclimb_hud.left_arrow.vertalign = "fullscreen";
    level.temp_exoclimb_hud.left_arrow.color = ( 1, 1, 1 );
    level.temp_exoclimb_hud.left_arrow _meth_80CC( "hud_arrow_left", 64, 64 );
    level.temp_exoclimb_hud.right_arrow = newhudelem();
    level.temp_exoclimb_hud.right_arrow.x = 336.0;
    level.temp_exoclimb_hud.right_arrow.y = 340;
    level.temp_exoclimb_hud.right_arrow.alignx = "center";
    level.temp_exoclimb_hud.right_arrow.aligny = "middle";
    level.temp_exoclimb_hud.right_arrow.horzalign = "fullscreen";
    level.temp_exoclimb_hud.right_arrow.vertalign = "fullscreen";
    level.temp_exoclimb_hud.right_arrow.color = ( 1, 1, 1 );
    level.temp_exoclimb_hud.right_arrow _meth_80CC( "hud_arrow_right", 64, 64 );
    temp_exoclimb_hud_hide();
}

temp_exoclimb_hud_hide()
{
    level.temp_exoclimb_hud.up_arrow.alpha = 0;
    level.temp_exoclimb_hud.down_arrow.alpha = 0;
    level.temp_exoclimb_hud.left_arrow.alpha = 0;
    level.temp_exoclimb_hud.right_arrow.alpha = 0;
}

temp_exoclimb_hud_check_array( var_0 )
{
    if ( isdefined( var_0["u"] ) && var_0["u"] != "blocked" )
        level.temp_exoclimb_hud.show_up_arrow = 1;

    if ( isdefined( var_0["d"] ) && var_0["d"] != "blocked" )
        level.temp_exoclimb_hud.show_down_arrow = 1;

    if ( isdefined( var_0["l"] ) && var_0["l"] != "blocked" )
        level.temp_exoclimb_hud.show_left_arrow = 1;

    if ( isdefined( var_0["r"] ) && var_0["r"] != "blocked" )
        level.temp_exoclimb_hud.show_right_arrow = 1;
}

temp_exoclimb_hud_thread()
{
    var_0 = 0.05;

    for (;;)
    {
        if ( is_exo_climbing() && climbing_helper_player_input_1_allowed() )
        {
            level.temp_exoclimb_hud.show_up_arrow = 0;
            level.temp_exoclimb_hud.show_down_arrow = 0;
            level.temp_exoclimb_hud.show_left_arrow = 0;
            level.temp_exoclimb_hud.show_right_arrow = 0;
            temp_exoclimb_hud_check_array( level.exo_climb_move_options["long"] );
            temp_exoclimb_hud_check_array( level.exo_climb_move_options["short"] );
            temp_exoclimb_hud_check_array( level.exo_climb_move_options["jump2mag"] );
            temp_exoclimb_hud_check_array( level.exo_climb_move_options["mag2jump"] );

            if ( level.temp_exoclimb_hud.show_up_arrow )
                level.temp_exoclimb_hud.up_arrow.alpha = 0.7;
            else
                level.temp_exoclimb_hud.up_arrow.alpha = 0;

            if ( level.temp_exoclimb_hud.show_down_arrow )
                level.temp_exoclimb_hud.down_arrow.alpha = 0.7;
            else
                level.temp_exoclimb_hud.down_arrow.alpha = 0;

            if ( level.temp_exoclimb_hud.show_left_arrow )
                level.temp_exoclimb_hud.left_arrow.alpha = 0.7;
            else
                level.temp_exoclimb_hud.left_arrow.alpha = 0;

            if ( level.temp_exoclimb_hud.show_right_arrow )
                level.temp_exoclimb_hud.right_arrow.alpha = 0.7;
            else
                level.temp_exoclimb_hud.right_arrow.alpha = 0;
        }
        else
            temp_exoclimb_hud_hide();

        wait(var_0);
    }
}

setup_exo_climb_audio()
{
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_mount_jump", ::aud_exo_climb_mount_jump, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_mount_land", ::aud_exo_climb_mount_land, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "mount2mag" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_u_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_u_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_u_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_l_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_l_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_l_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_r_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_r_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_lt", ::aud_exo_climb_windup_lt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_lt", ::aud_exo_climb_hit_lt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_lt", ::aud_exo_climb_rest_lt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_rt, "magnetic_r_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_push", ::aud_exo_climb_slide_push, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_start", ::aud_exo_climb_slide_start, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_stop", ::aud_exo_climb_slide_stop, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_lt, "magnetic_d_0" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_start", ::aud_exo_climb_slide_start, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_stop", ::aud_exo_climb_slide_stop, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_lt, "magnetic_d_1" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_start", ::aud_exo_climb_slide_start, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_slide_stop", ::aud_exo_climb_slide_stop, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_windup_rt", ::aud_exo_climb_windup_rt, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_hit_rt", ::aud_exo_climb_hit_rt, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_rest_rt", ::aud_exo_climb_rest_lt, "magnetic_d_2" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_lt", ::aud_exo_climb_gear_lt, "dismount" );
    maps\_anim::addnotetrack_customfunction( "player_climb_rig", "aud_exo_climb_gear_rt", ::aud_exo_climb_gear_rt, "dismount" );
}

aud_exo_climb_mount_jump( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_mount_jump" );
}

aud_exo_climb_mount_land( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_mount_land" );
}

aud_exo_climb_gear_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_gear_lt" );
}

aud_exo_climb_gear_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_gear_rt" );
}

aud_exo_climb_windup_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_lt" );
}

aud_exo_climb_windup_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_windup_rt" );
}

aud_exo_climb_hit_lt( var_0 )
{
    exo_climb_mag_rumble( var_0 );
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_hit_magnet" );
}

aud_exo_climb_hit_rt( var_0 )
{
    exo_climb_mag_rumble( var_0 );
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_hit_magnet" );
}

aud_exo_climb_rest_lt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_rest_magnet" );
}

aud_exo_climb_rest_rt( var_0 )
{
    soundscripts\_snd_playsound::snd_play_2d( "exo_climb_rest_magnet" );
}

aud_exo_climb_slide_push( var_0 )
{

}

aud_exo_climb_slide_start( var_0 )
{
    if ( !isdefined( level.aud.exo_climb_sliding ) )
    {
        level.aud.exo_climb_sliding = 1;
        soundscripts\_snd_playsound::snd_play_loop_2d( "exo_climb_slide_lp", "kill_exo_slide", undefined, 0.5 );
    }
}

aud_exo_climb_slide_stop( var_0 )
{
    level notify( "kill_exo_slide" );
    level.aud.exo_climb_sliding = undefined;
    exo_climb_mag_rumble( var_0 );
}
