// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("player");

grapple_init_anims_player()
{
    var_0 = "grapple_hands";
    level.scr_animtree[var_0] = #animtree;

    if ( isdefined( level.grapple_defaultviewhandsmodel ) )
        level.scr_model[var_0] = level.grapple_defaultviewhandsmodel;
    else
        level.scr_model[var_0] = "tag_origin";

    level.scr_anim[var_0]["land_straight"] = %vm_grapple_land;
    level.scr_anim[var_0]["land_right"] = %vm_grapple_land_right;
    level.scr_anim[var_0]["land_left"] = %vm_grapple_land_left;
    level.scr_anim[var_0]["grapple_death"] = %vm_grapple_death;
    level.scr_anim[var_0]["grapple_fire_end"] = %vm_grapple_fire_end;
    level.scr_anim[var_0]["grapple_hip_fire"] = %vm_grapple_hip_fire;
    level.scr_anim[var_0]["land_mantle_up"] = %vm_grapple_mantle_32_up;
    level.scr_anim[var_0]["land_mantle_over"] = %vm_grapple_mantle_32_over;
    level.scr_anim[var_0]["land_mantle_kill_up"] = %vm_grapple_mantle_throw_death_32_up;
    level.scr_anim[var_0]["land_mantle_kill_over"] = %vm_grapple_mantle_throw_death_32_over;
    level.scr_anim[var_0]["land_mantle_kill_up_2"] = %vm_grapple_mantle_kick_death_32_up;
    level.scr_anim[var_0]["land_mantle_kill_over_2"] = %vm_grapple_mantle_kick_death_32_over;
    var_0 = "grapple_body";
    level.scr_animtree[var_0] = #animtree;

    if ( isdefined( level.grapple_defaultscriptedbodymodel ) )
        level.scr_model[var_0] = level.grapple_defaultscriptedbodymodel;
    else
        level.scr_model[var_0] = "tag_origin";

    level.scr_anim[var_0]["land_straight"] = %vm_grapple_land;
    level.scr_anim[var_0]["land_right"] = %vm_grapple_land_right;
    level.scr_anim[var_0]["land_left"] = %vm_grapple_land_left;
    level.scr_anim[var_0]["grapple_death"] = %vm_grapple_death;
    level.scr_viewanim = [];
    level.scr_viewanim["grapple_fire_end"] = "vm_grapple_fire_end";
    level.scr_viewanim["grapple_hip_fire"] = "vm_grapple_hip_fire";
    level.grapple_death_pull_suffixes = [ "", "_2", "_3" ];
    level.scr_viewanim["grapple_pull_death_start_above_obs"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop_above_obs"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs"] = %vm_grapple_pull_death_above_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_2"] = %vm_grapple_pull_death_above_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_3"] = %vm_grapple_pull_death_above_end;
    level.scr_viewanim["grapple_pull_death_start_above_obs_45"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop_above_obs_45"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs_45"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs_45"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45"] = %vm_grapple_pull_death_above_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45_2"] = %vm_grapple_pull_death_above_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45_3"] = %vm_grapple_pull_death_above_end_45;
    level.scr_viewanim["grapple_pull_death_start_obs"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop_obs"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start_obs"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_obs"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_obs"] = %vm_grapple_pull_death_end;
    level.scr_anim[var_0]["grapple_pull_death_end_obs_2"] = %vm_grapple_pull_death_end;
    level.scr_anim[var_0]["grapple_pull_death_end_obs_3"] = %vm_grapple_pull_death_end;
    level.scr_viewanim["grapple_pull_death_start_above"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop_above"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start_above"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above"] = %vm_grapple_pull_death_above_knife_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_2"] = %vm_grapple_pull_death_above_neck_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_3"] = %vm_grapple_pull_death_above_choke_end;
    level.scr_viewanim["grapple_pull_death_start_above_45"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop_above_45"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start_above_45"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_45"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_45"] = %vm_grapple_pull_death_above_knife_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_45_2"] = %vm_grapple_pull_death_above_neck_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_45_3"] = %vm_grapple_pull_death_above_choke_end_45;
    level.scr_viewanim["grapple_pull_death_start"] = "vm_grapple_pull_death_above_start";
    level.scr_viewanim["grapple_pull_death_loop"] = "vm_grapple_pull_death_above_loop";
    level.scr_anim[var_0]["grapple_pull_death_start"] = %vm_grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop"] = [ %vm_grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end"] = %vm_grapple_pull_death_knife_end;
    level.scr_anim[var_0]["grapple_pull_death_end_2"] = %vm_grapple_pull_death_neck_end;
    level.scr_anim[var_0]["grapple_pull_death_end_3"] = %vm_grapple_pull_death_choke_end;
    level.scr_anim[var_0]["land_mantle_up"] = %vm_grapple_mantle_32_up_world;
    level.scr_anim[var_0]["land_mantle_over"] = %vm_grapple_mantle_32_over_world;
    level.scr_anim[var_0]["land_mantle_kill_up"] = %vm_grapple_mantle_throw_death_32_up_world;
    level.scr_anim[var_0]["land_mantle_kill_over"] = %vm_grapple_mantle_throw_death_32_over_world;
    level.scr_anim[var_0]["land_mantle_kill_up_2"] = %vm_grapple_mantle_kick_death_32_up_world;
    level.scr_anim[var_0]["land_mantle_kill_over_2"] = %vm_grapple_mantle_kick_death_32_over_world;

    foreach ( var_3, var_2 in level.scr_anim[var_0] )
        level.scr_goaltime[var_0][var_3] = 0;
}

#using_animtree("animated_props");

grapple_init_anims_props()
{
    var_0 = "grapple_rope";
    level.scr_animtree[var_0] = #animtree;
    level.scr_model[var_0] = "base_grapple_rope";
    level.scr_anim[var_0]["fire"] = %vm_grapple_fire_rope;
    level.scr_anim[var_0]["fire_third_person"] = %grapple_traverse_fire_rope;
    level.scr_anim[var_0]["grapple_hip_fire"] = %vm_grapple_hip_fire_rope;
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs_45"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs_45"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_start_obs"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop_obs"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_start_above"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop_above"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_3"] = %vm_grapple_pull_death_above_choke_end_rope;
    level.scr_anim[var_0]["grapple_pull_death_start_above_45"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_45"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_45_3"] = %vm_grapple_pull_death_above_choke_end_45_rope;
    level.scr_anim[var_0]["grapple_pull_death_start"] = %vm_grapple_pull_death_above_start_rope;
    level.scr_anim[var_0]["grapple_pull_death_loop"] = [ %vm_grapple_pull_death_above_loop_rope ];
    level.scr_anim[var_0]["grapple_pull_death_end_3"] = %vm_grapple_pull_death_choke_end_rope;
    level.scr_anim[var_0]["grapple_death"] = %vm_grapple_death_rope;

    foreach ( var_3, var_2 in level.scr_anim[var_0] )
        level.scr_goaltime[var_0][var_3] = 0;

    var_0 = "grapple_rope_stretch";
    level.scr_animtree[var_0] = #animtree;
    level.scr_model[var_0] = "base_grapple_scale_rope";
}

#using_animtree("generic_human");

grapple_init_anims_actors()
{
    var_0 = "generic";
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs"] = [ %grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs"] = %grapple_pull_death_above_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_2"] = %grapple_pull_death_above_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_3"] = %grapple_pull_death_above_end;
    level.scr_anim[var_0]["grapple_pull_death_start_above_obs_45"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_obs_45"] = [ %grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45"] = %grapple_pull_death_above_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45_2"] = %grapple_pull_death_above_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_obs_45_3"] = %grapple_pull_death_above_end_45;
    level.scr_anim[var_0]["grapple_pull_death_start_obs"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_obs"] = [ %grapple_pull_death_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_obs"] = %grapple_pull_death_end;
    level.scr_anim[var_0]["grapple_pull_death_end_obs_2"] = %grapple_pull_death_end;
    level.scr_anim[var_0]["grapple_pull_death_end_obs_3"] = %grapple_pull_death_end;
    level.scr_anim[var_0]["grapple_pull_death_start_above"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above"] = [ %grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above"] = %grapple_pull_death_above_knife_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_2"] = %grapple_pull_death_above_neck_end;
    level.scr_anim[var_0]["grapple_pull_death_end_above_3"] = %grapple_pull_death_above_choke_end;
    level.scr_anim[var_0]["grapple_pull_death_start_above_45"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop_above_45"] = [ %grapple_pull_death_above_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end_above_45"] = %grapple_pull_death_above_knife_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_45_2"] = %grapple_pull_death_above_neck_end_45;
    level.scr_anim[var_0]["grapple_pull_death_end_above_45_3"] = %grapple_pull_death_above_choke_end_45;
    level.scr_anim[var_0]["grapple_pull_death_start"] = %grapple_pull_death_above_start;
    level.scr_anim[var_0]["grapple_pull_death_loop"] = [ %grapple_pull_death_loop ];
    level.scr_anim[var_0]["grapple_pull_death_end"] = %grapple_pull_death_knife_end;
    level.scr_anim[var_0]["grapple_pull_death_end_2"] = %grapple_pull_death_neck_end;
    level.scr_anim[var_0]["grapple_pull_death_end_3"] = %grapple_pull_death_choke_end;
    level.scr_anim[var_0]["death_grapple_back"] = %death_grapple_back;
    level.scr_anim[var_0]["death_grapple_front"] = %death_grapple_front;
    level.scr_anim[var_0]["death_grapple_right"] = %death_grapple_right;
    level.scr_anim[var_0]["death_grapple_left"] = %death_grapple_left;
    level.scr_anim[var_0]["death_grapple_above"] = %death_grapple_above;
    level.scr_anim[var_0]["land_mantle_kill_up"] = %grapple_mantle_throw_death_32_up;
    level.scr_anim[var_0]["land_mantle_kill_over"] = %grapple_mantle_throw_death_32_over;
    level.scr_anim[var_0]["land_mantle_kill_up_2"] = %grapple_mantle_kick_death_32_up;
    level.scr_anim[var_0]["land_mantle_kill_over_2"] = %grapple_mantle_kick_death_32_over;
}
