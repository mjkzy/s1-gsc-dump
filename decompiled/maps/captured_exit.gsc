// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{

}

post_load()
{
    common_scripts\utility::flag_init( "flag_gatedoor_end" );
    level._exit = spawnstruct();
    level._exit.civ_gate_node = common_scripts\utility::getstruct( "struct_exit_scene_gate", "targetname" );
    level._exit.civilians = [];

    if ( isdefined( common_scripts\utility::getstruct( "struct_playerstart_gd", "targetname" ) ) )
    {
        level._exit.gate_inner = getent( "model_mb_exitdoor_inner", "targetname" );
        level._exit.gate_inner.col = getent( level._exit.gate_inner.target, "targetname" );
        level._exit.node = common_scripts\utility::getstruct( "struct_exit_scene", "targetname" ) common_scripts\utility::spawn_tag_origin();
        level._exit.escape_node = common_scripts\utility::getstruct( "struct_exit_scene", "targetname" ) common_scripts\utility::spawn_tag_origin();
        level._exit.lock = getent( "model_mb_maintenance_door", "targetname" );
        level._exit.lock maps\_utility::assign_animtree( "exit_gate_lock" );
        level._exit.gate_inner maps\_utility::assign_animtree( "exit_gate_inner" );

        if ( maps\captured_util::start_point_is_before( "gatedoor" ) )
        {
            level._exit.node maps\_anim::anim_first_frame( [ level._exit.gate_inner, level._exit.lock ], "anim_exit_gateclose" );
            level._exit.gate_inner.col _meth_8058();
        }
        else if ( level.start_point == "gatedoor" )
            level._exit.node maps\_anim::anim_first_frame( [ level._exit.gate_inner, level._exit.lock ], "anim_exit_gatelift_intro" );
    }
    else
        iprintln( "Warning: Mech Battle start point missing.  Compiled out?" );
}

start( var_0, var_1 )
{
    common_scripts\utility::flag_set( "flag_mech_vo_active" );
    level.player maps\captured_util::warp_to_start( var_0 );
    level.allies maps\captured_util::warp_allies( var_1, 1 );
    level.player thread maps\captured_mech_code::init_mech_actions();
    level.civ_run_nodes = level._mb.exit_run_nodes2;
    level._exit.gate_inner.col _meth_8058();
    level._exit.gate_inner.col _meth_82BF();
    maps\_playermech_code::playermech_start( "base" );
    level.allies[0] _meth_83FA( 3, 1 );
}

main_gd()
{
    level.ally maps\_utility::enable_ai_color();
    thread util_physicspush_watcher();
    maps\_utility::activate_trigger_with_targetname( "trig_gd_ally_1" );
    thread maps\_utility::battlechatter_off( "allies" );
    thread maps\_utility::battlechatter_off( "axis" );
    thread dialogue_gd();
    thread gd_player_lifts_gate();
    level.player waittill( "exit_anim_start" );
    thread ai_gd();
    level.player waittill( "exit_anim_done" );
    level.allies[0] _meth_83FB();
}

ai_gd()
{
    level._exit.node thread maps\_anim::anim_single_solo( level.ally, "anim_exit" );
    level.player waittill( "notify_fire_rocket_2" );
    level._exit.node thread maps\_anim::anim_loop_solo( level.ally, "anim_exit_loop" );
}

gd_player_lifts_gate()
{
    var_0 = level._exit.node;
    var_1 = level._exit.lock;
    var_2 = spawnstruct();
    var_2.input_type = "mash";
    var_2.node = var_0;
    var_2.obj = level._exit.gate_inner;
    var_2.intro_anim = "anim_exit_gatelift_intro";
    var_2.intro_anim_vm = "cap_s1_escape_mech_door_lift_intro_vm";
    var_2.post_intro_loop_anim = "anim_exit_gatelift_intro_idle";
    var_2.post_intro_loop_anim_vm = "cap_s1_escape_mech_door_lift_idle_vm";
    var_2.main_anims = [ "anim_exit_gatelift_1", "anim_exit_gatelift_2", "anim_exit_gatelift_3", "anim_exit_gatelift_4", "anim_exit_gatelift_5", "anim_exit_gatelift_6", "anim_exit_gatelift_7" ];
    var_2.rev_main_anims = [ "anim_exit_gatelift_1_rev", "anim_exit_gatelift_2_rev", "anim_exit_gatelift_3_rev", "anim_exit_gatelift_4_rev", "anim_exit_gatelift_5_rev", "anim_exit_gatelift_6_rev", "anim_exit_gatelift_7_rev" ];
    var_2.main_anims_vm = [ "cap_s1_escape_mech_door_lift_01_vm", "cap_s1_escape_mech_door_lift_02_vm", "cap_s1_escape_mech_door_lift_03_vm", "cap_s1_escape_mech_door_lift_04_vm", "cap_s1_escape_mech_door_lift_05_vm", "cap_s1_escape_mech_door_lift_06_vm", "cap_s1_escape_mech_door_lift_07_vm" ];
    var_2.rev_main_anims_vm = [ "cap_s1_escape_mech_door_lift_01_rev_vm", "cap_s1_escape_mech_door_lift_02_rev_vm", "cap_s1_escape_mech_door_lift_03_rev_vm", "cap_s1_escape_mech_door_lift_04_rev_vm", "cap_s1_escape_mech_door_lift_05_rev_vm", "cap_s1_escape_mech_door_lift_06_rev_vm", "cap_s1_escape_mech_door_lift_07_rev_vm" ];
    var_2.exit_anim = "anim_exit_gatelift_exit";
    var_2.exit_anim_vm = "cap_s1_escape_mech_door_lift_exit_vm";
    level.player maps\captured_mech_code::spawn_mech_rig();
    var_2.guys = [ level.player.rig, var_2.obj ];
    var_0 maps\_anim::anim_first_frame_solo( level.player.rig, "anim_exit_gatelift_intro" );
    level._exit.final_player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level._exit.final_player_rig hide();
    level._exit.escape_node maps\_anim::anim_first_frame_solo( level._exit.final_player_rig, "end_escape" );
    wait 0.05;
    var_3 = maps\_shg_utility::hint_button_position( "use", common_scripts\utility::getstruct( "mech_gate_lock_hint", "targetname" ).origin, 72 );
    var_3.object makeusable();
    var_3.object maps\_utility::addhinttrigger( &"CAPTURED_HINT_BREAK_CONSOLE", &"CAPTURED_HINT_BREAK_PC" );
    maps\captured_util::waittill_entity_activate_looking_at( var_3.object, undefined, undefined, 90, undefined, 0 );
    level notify( "lgt_dof_mechdoor" );
    _func_0D3( "g_friendlyNameDist", 0 );
    common_scripts\utility::flag_set( "flag_exit_lock_broken" );
    var_3 maps\_shg_utility::hint_button_clear();
    level.player thread playerlinktodeltablend();
    wait 0.25;
    soundscripts\_snd::snd_message( "scn_cap_mech_door_grab" );
    var_0 thread maps\_anim::anim_single_solo( var_1, "anim_exit_gatelift_intro" );
    thread maps\captured_fx::fx_mech_door_lift_fx();
    common_scripts\utility::flag_set( "flag_force_hud_ready" );
    level.player thread maps\captured_mech_code::mech_obj_move( var_2, 1 );
    level.player waittill( "exit_anim_start" );
    level._exit.gate_inner.col _meth_8058();
    level._exit.gate_inner.col _meth_82BF();
    level notify( "dialogue_gatedoor_hold" );
    self notify( "notify_stop_mash_detection" );
    common_scripts\utility::flag_clear( "hint_mash_button" );
    level.player thread event_exit_player_knockback();
    level.player thread event_mechsuit_swap();
}

playerlinktodeltablend()
{
    self _meth_8080( self.rig, "tag_player", 0.2 );
    wait 0.2;
    self _meth_807D( self.rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    wait 0.05;
    self.rig show();
    self _meth_8482();
    maps\_utility::spawn_anim_model( "mech_gun", level.player.origin ) _meth_804D( self.rig, "tag_weapon", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

event_exit_player_knockback()
{
    self _meth_80EC( 1 );
    var_0 = maps\_utility::array_spawn_noteworthy( "enemy_exit" );
    common_scripts\utility::array_thread( var_0, ::exit_enemy );
    var_1 = maps\_utility::spawn_script_noteworthy( "enemy_exit_mech" );
    var_1 thread exit_mech_rocket_fire();
    thread maps\captured_mech::smart_radio_dialogue_mb( "cap_sri_enemymechdetected" );
    var_2 = getent( "model_exit_swinggate", "targetname" );
    var_2 _meth_8058();
    var_2 _meth_82AE( var_2.origin + ( 0, 0, 128 ), 1 );
    level.player waittill( "notify_fire_rocket_2" );
    level.player common_scripts\utility::delaycall( 1.25, ::_meth_80AD, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 5.65, ::_meth_80AD, "heavy_1s" );
    common_scripts\utility::flag_set( "flag_gatedoor_end" );
    self notify( "stop_quake" );
    level.player freezecontrols( 1 );
    thread maps\captured_fx::fx_mech_explode_amb_fx();
    maps\_playermech_code::set_mech_state( "outro" );
    level.player _meth_82FB( "ui_hide_hud", 1 );
    level.player.rig thread maps\captured_fx::fx_mech_cockpit_damage();
    thread maps\captured_fx::fx_stop_mech_door_lift_fx();
    level.player _meth_80EC( 0 );
    level._exit.gate_inner.col _meth_8057();
    level._exit.gate_inner.col _meth_82BE();
}

event_mechsuit_swap()
{
    var_0 = common_scripts\utility::getstruct( "struct_exit_scene", "targetname" ) common_scripts\utility::spawn_tag_origin();
    var_1["top"] = maps\_utility::spawn_anim_model( "mech_suit_top" );
    var_1["bottom"] = maps\_utility::spawn_anim_model( "mech_suit_bottom" );
    common_scripts\utility::array_call( var_1, ::hide );
    var_0 maps\_anim::anim_first_frame( var_1, "anim_exit_mechsuit" );
    self waittill( "mech_swap" );
    maps\captured_fx::fx_mech_cockpit_damage_stop();
    level.player.rig hide();
    common_scripts\utility::array_call( var_1, ::show );
    var_0 maps\_anim::anim_single( var_1, "anim_exit_mechsuit" );

    foreach ( var_3 in var_1 )
        var_0 maps\_anim::anim_last_frame_solo( var_3, "anim_exit_mechsuit" );
}

exit_enemy()
{
    maps\_utility::magic_bullet_shield( 1 );
    self.script_forcegoal = 1;
    maps\_utility::set_favoriteenemy( level.player );
    maps\_utility::set_baseaccuracy( 0.7 );
}

#using_animtree("generic_human");

exit_mech_rocket_fire()
{
    maps\_utility::magic_bullet_shield( 1 );
    maps\captured_util::ignore_everything();
    level.player waittill_nt( %cap_s1_escape_mech_door_lift_exit_mech, "fire_rocket_0", -2.5 );
    var_0 = self gettagorigin( "tag_rocket1" ) + anglestoforward( self.angles ) * 64;
    var_1 = common_scripts\utility::getstruct( "struct_exit_rocket_0", "targetname" );
    magicbullet( "playermech_rocket_deploy_projectile", var_0, var_1.origin );
    magicbullet( "playermech_rocket_projectile", var_0, var_1.origin );
    level.player waittill_nt( %cap_s1_escape_mech_door_lift_exit_mech, "fire_rocket_1", -2.5 );
    var_0 = self gettagorigin( "tag_rocket2" ) + anglestoforward( self.angles ) * 64;
    var_1 = common_scripts\utility::getstruct( "struct_exit_rocket_1", "targetname" );
    magicbullet( "playermech_rocket_deploy_projectile", var_0, var_1.origin );
    magicbullet( "playermech_rocket_projectile", var_0, var_1.origin ) thread deathfunc_rocket( var_1.origin, ( 0, 0, 0 ), "mech_wall_explosion", "light_1s" );
    level.player waittill_nt( %cap_s1_escape_mech_door_lift_exit_mech, "fire_rocket", -1.75 );
    var_0 = self gettagorigin( "tag_rocket3" ) + anglestoforward( self.angles ) * 64;
    magicbullet( "playermech_rocket_deploy_projectile", var_0, level.player.origin );
    magicbullet( "playermech_rocket_projectile", var_0, level.player.origin ) thread deathfunc_rocket( level.player.origin + ( 0, 0, 32 ), level.player.angles, "mech_chest_explosion", "heavy_1s" );
}

deathfunc_rocket( var_0, var_1, var_2, var_3 )
{
    self waittill( "death" );
    playfx( common_scripts\utility::getfx( var_2 ), var_0, anglestoforward( var_1 ), anglestoup( var_1 ) );
    level.player _meth_80AD( var_3 );
}

waittill_nt( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_3 ) && !common_scripts\utility::flag_exist( var_3 ) )
        common_scripts\utility::flag_init( var_3 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_4 = getnotetracktimes( var_0, var_1 )[0];
    var_5 = var_4 * getanimlength( var_0 ) + var_2;
    wait(var_5);

    if ( isdefined( var_3 ) )
        common_scripts\utility::flag_set( var_3 );
}

util_physicspush_watcher()
{
    level endon( "flag_gatedoor_end" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_playermech_nopush" );
        level.player maps\_playermech_code::playermech_physics_push_off();
        common_scripts\utility::flag_waitopen( "flag_playermech_nopush" );
        level.player maps\_playermech_code::playermech_physics_push_on();
    }
}

dialogue_gd()
{
    maps\_utility::smart_radio_dialogue( "cap_gdn_thatsthegateout" );
    thread maps\_utility::smart_radio_dialogue( "cap_gdn_breakthislock" );
    level.player waittill( "intro_anim_done" );
    common_scripts\utility::flag_clear( "flag_mech_vo_active" );
    thread dialogue_gd_lift();
    level waittill( "dialogue_gatedoor_hold" );
    common_scripts\utility::flag_wait( "flag_gatedoor_end" );
}

dialogue_gd_lift()
{
    level.player endon( "main_anim_startanim_exit_gatelift_1" );
    maps\_utility::smart_radio_dialogue( "cap_gdn_liftthatgateandhold" );
    wait 7;
    var_0 = [ "cap_gdn_liftthegate", "cap_gdn_openthisdoor", "cap_gdn_comeonwehaveto" ];
    level.player childthread maps\captured_util::radio_dialogue_nag_loop( var_0 );
}