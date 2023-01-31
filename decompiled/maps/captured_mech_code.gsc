// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

pre_load()
{
    common_scripts\utility::flag_init( "hint_mash_button" );
    maps\_utility::add_hint_string( "hint_mash_button", &"CAPTURED_HINT_TAP", ::hint_mash_button );
    common_scripts\utility::flag_init( "hint_push_forward" );
    maps\_utility::add_hint_string( "hint_push_forward", "Press Forward on Left Thumbstick to Push", ::hint_push_forward );
    common_scripts\utility::flag_init( "hint_pull_back" );
    maps\_utility::add_hint_string( "hint_pull_back", "Press down on Left Thumbstick to Pull", ::hint_pull_back );
    common_scripts\utility::flag_init( "flag_mech_smash_active" );
    mech_player_anims();
    mech_generic_human();
    mech_script_model_anims();
    mech_vehicle_anims();
    mech_fx();
}

init_mech_actions()
{
    level.allow_threat_paint = 1;
    _func_0D3( "mechAcceleration", 0.6 );
    _func_0D3( "mechAirAcceleration", 0.6 );

    if ( !isdefined( self.mech_init ) )
    {
        self.mech_init = 1;
        level.player thread maps\captured_util::waittill_notify_func( "playermech_start", soundscripts\_snd::snd_message, "aud_plr_inside_mech" );
        setup_smash_nodes();
        common_scripts\utility::array_thread( getentarray( "trig_mb_destructible", "script_noteworthy" ), ::mech_action_smash );
        common_scripts\utility::array_thread( common_scripts\utility::getstructarray( "brush_mb1_crane", "targetname" ), ::mech_action_shoot );
        level.player thread mech_crush();
        maps\_playermech_code::playermech_disable_badplace();
        level.mech_swarm_number_of_rockets_per_target = 8;
    }
}

hint_mash_button()
{
    return !common_scripts\utility::flag( "hint_mash_button" );
}

hint_push_forward()
{
    return !common_scripts\utility::flag( "hint_push_forward" );
}

hint_pull_back()
{
    return !common_scripts\utility::flag( "hint_pull_back" );
}

mech_player_anims()
{

}

#using_animtree("generic_human");

mech_generic_human()
{
    level.scr_animtree["mech_player_rig"] = #animtree;
    level.scr_model["mech_player_rig"] = "worldhands_playermech";
    level.scr_anim["mech_player_rig"]["mech_run_through"] = %cap_playermech_run_through_mech_short;
    level.scr_anim["generic"]["explode_death"] = %death_explosion_run_f_v2;
    level.scr_anim["mech_player_rig"]["anim_mb1_intro_exit"] = %cap_s1_escape_mech_control_release_mech;
    level.scr_anim["mech_player_rig"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_jump_out_mech;
    level.scr_animtree["mb1_introwall_guard"] = #animtree;
    level.scr_anim["mb1_introwall_guard1"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_01;
    level.scr_anim["mb1_introwall_guard2"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_02;
    level.scr_anim["mb1_introwall_guard3"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_03;
    level.scr_anim["mb1_introwall_guard4"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_04;
    level.scr_anim["mb1_introwall_guard5"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_05;
    level.scr_anim["mb1_introwall_guard6"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_06;
    level.scr_anim["mb1_introwall_guard7"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_07;
    level.scr_anim["mb1_introwall_guard8"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_08;
    level.scr_anim["mb1_introwall_guard9"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_09;
    level.scr_anim["mb1_introwall_guard10"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_10;
    level.scr_anim["mb1_introwall_guard11"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_11;
    level.scr_anim["mb1_introwall_guard12"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_12;
    level.scr_anim["mb1_introwall_guard13"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_13;
    level.scr_anim["mb1_introwall_guard14"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_14;
    level.scr_anim["mb1_introwall_guard15"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_guard_15;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_intro_idle"][0] = %cap_s1_escape_mech_door_lift_idle_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_1"] = %cap_s1_escape_mech_door_lift_01_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_2"] = %cap_s1_escape_mech_door_lift_02_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_3"] = %cap_s1_escape_mech_door_lift_03_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_4"] = %cap_s1_escape_mech_door_lift_04_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_5"] = %cap_s1_escape_mech_door_lift_05_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_6"] = %cap_s1_escape_mech_door_lift_06_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_7"] = %cap_s1_escape_mech_door_lift_07_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_1_rev"] = %cap_s1_escape_mech_door_lift_01_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_2_rev"] = %cap_s1_escape_mech_door_lift_02_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_3_rev"] = %cap_s1_escape_mech_door_lift_03_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_4_rev"] = %cap_s1_escape_mech_door_lift_04_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_5_rev"] = %cap_s1_escape_mech_door_lift_05_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_6_rev"] = %cap_s1_escape_mech_door_lift_06_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_7_rev"] = %cap_s1_escape_mech_door_lift_07_rev_mech;
    level.scr_anim["mech_player_rig"]["anim_exit_gatelift_exit"] = %cap_s1_escape_mech_door_lift_exit_mech;
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_0", ::notify_fire_rocket_0, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_1", ::notify_fire_rocket_1, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket", ::notify_fire_rocket_2, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_2", ::notify_fire_rocket_3, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_3", ::notify_fire_rocket_4, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_4", ::notify_fire_rocket_5, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fire_rocket_5", ::notify_fire_rocket_6, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fx_mech_foot_sparks", maps\captured_fx::fx_mech_foot_sparks );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fx_mech_exit_steam", maps\captured_fx::fx_mech_exit_steam );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fx_mech_land_sparks", maps\captured_fx::fx_mech_land_sparks );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "fx_mech_soft_land_dust", maps\captured_fx::fx_mech_soft_land_dust );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "mech_swap", ::notify_mech_swap, "anim_exit_gatelift_exit" );
    maps\_anim::addnotetrack_customfunction( "mech_player_rig", "snd_end_01", maps\captured_aud::snd_end_01, "anim_exit_gatelift_exit" );
    level.scr_anim["ally_0"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_gideon;
    level.scr_anim["tank_driver"]["anim_exit_takedown_intro"] = %cap_s1_escape_mech_tank_takedown_intro_opfor;
    level.scr_anim["tank_driver"]["anim_exit_takedown_idle"][0] = %cap_s1_escape_mech_tank_takedown_loop_opfor;
    level.scr_anim["tank_driver"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_opfor;
    level.scr_anim["mech_player_rig"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_mech;
}

notify_fire_rocket_0( var_0 )
{
    level.player notify( "notify_fire_rocket_0" );
}

notify_fire_rocket_1( var_0 )
{
    level.player notify( "notify_fire_rocket_1" );
}

notify_fire_rocket_2( var_0 )
{
    level.player notify( "notify_fire_rocket_2" );
}

notify_fire_rocket_3( var_0 )
{
    level.player notify( "notify_fire_rocket_3" );
}

notify_fire_rocket_4( var_0 )
{
    level.player notify( "notify_fire_rocket_4" );
}

notify_fire_rocket_5( var_0 )
{
    level.player notify( "notify_fire_rocket_5" );
}

notify_fire_rocket_6( var_0 )
{
    level.player notify( "notify_fire_rocket_6" );
}

notify_mech_swap( var_0 )
{
    level.player notify( "mech_swap" );
}

#using_animtree("script_model");

mech_script_model_anims()
{
    level.scr_animtree["mb_wall_1"] = #animtree;
    level.scr_anim["mb_wall_1"]["mech_run_through"] = %cap_playermech_run_through_prop_short;
    level.scr_model["mb_wall_1"] = "cap_playermech_breakable_wall";
    level.scr_animtree["mb1_introwall"] = #animtree;
    level.scr_anim["mb1_introwall"]["anim_mb1_introwall_smash"] = %cap_s1_escape_mech_jump_out_wall;
    level.scr_animtree["exit_gate_lock"] = #animtree;
    level.scr_model["exit_gate_lock"] = "cap_s1_exit_gate_lock";
    level.scr_anim["exit_gate_lock"]["anim_exit_gateclose"] = %cap_s1_escape_mech_gate_close_lock;
    level.scr_anim["exit_gate_lock"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_lock;
    level.scr_animtree["exit_gate_inner"] = #animtree;
    level.scr_anim["exit_gate_inner"]["anim_exit_gateclose"] = %cap_s1_escape_mech_gate_close_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_intro"] = %cap_s1_escape_mech_door_lift_intro_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_intro_idle"][0] = %cap_s1_escape_mech_door_lift_intro_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_1"] = %cap_s1_escape_mech_door_lift_01_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_2"] = %cap_s1_escape_mech_door_lift_02_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_3"] = %cap_s1_escape_mech_door_lift_03_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_4"] = %cap_s1_escape_mech_door_lift_04_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_5"] = %cap_s1_escape_mech_door_lift_05_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_6"] = %cap_s1_escape_mech_door_lift_06_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_7"] = %cap_s1_escape_mech_door_lift_07_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_1_rev"] = %cap_s1_escape_mech_door_lift_01_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_2_rev"] = %cap_s1_escape_mech_door_lift_02_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_3_rev"] = %cap_s1_escape_mech_door_lift_03_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_4_rev"] = %cap_s1_escape_mech_door_lift_04_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_5_rev"] = %cap_s1_escape_mech_door_lift_05_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_6_rev"] = %cap_s1_escape_mech_door_lift_06_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_7_rev"] = %cap_s1_escape_mech_door_lift_07_rev_door;
    level.scr_anim["exit_gate_inner"]["anim_exit_gatelift_exit"] = %cap_s1_escape_mech_door_lift_exit_door;
    level.scr_animtree["mech_gun"] = #animtree;
    level.scr_model["mech_gun"] = "vm_exo_interior_base";
}

#using_animtree("vehicles");

mech_vehicle_anims()
{
    level.scr_animtree["tank"] = #animtree;
    level.scr_anim["tank"]["anim_exit_takedown_intro"] = %cap_s1_escape_mech_tank_takedown_intro_tank;
    level.scr_anim["tank"]["anim_exit_takedown_idle"][0] = %cap_s1_escape_mech_tank_takedown_loop_tank;
    level.scr_anim["tank"]["anim_exit_takedown_exit"] = %cap_s1_escape_mech_tank_takedown_tank;
}

mech_fx()
{
    level._effect["fx_trailer_1"] = loadfx( "vfx/destructible/cap_tank_trailer_l" );
    level._effect["fx_trailer_3"] = loadfx( "vfx/destructible/cap_tank_trailer_c" );
    level._effect["fx_trailer_2"] = loadfx( "vfx/destructible/cap_tank_trailer_r" );
}

mech_action_smash()
{
    level.player endon( "death" );
    level.player endon( "exit_mech" );
    self endon( "death" );
    level._mb.trigs = common_scripts\utility::array_add( level._mb.trigs, self );
    self.nodes = common_scripts\utility::getstructarray( self.target, "targetname" );
    self.flag_smash = 0;
    self.additional_unlink_nodes = [];

    if ( isdefined( self.nodes[0].target ) )
    {
        self.additional_geo = [];

        foreach ( var_1 in getentarray( self.nodes[0].target, "targetname" ) )
        {
            if ( issubstr( var_1.classname, "brushmodel" ) )
            {
                self.col = var_1;
                continue;
            }

            if ( issubstr( var_1.classname, "model" ) )
                self.additional_geo = common_scripts\utility::array_add( self.additional_geo, var_1 );
        }

        foreach ( var_4 in common_scripts\utility::getstructarray( self.nodes[0].target, "targetname" ) )
        {
            if ( isdefined( var_4.script_parameters ) && var_4.script_parameters == "unlink" )
            {
                self.additional_unlink_nodes = common_scripts\utility::array_add( self.additional_unlink_nodes, var_4 );
                continue;
            }

            self.fx = var_4;
        }

        self._id_03A7 = _func_231( self.nodes[0].target, "targetname" )[0];
        self.glass = getglassarray( self.nodes[0].target );

        if ( isdefined( self.col ) )
        {
            if ( isdefined( self.nodes[0].height ) )
                self.col _meth_8058();

            if ( isdefined( self.col.target ) )
            {
                foreach ( var_1 in getentarray( self.col.target, "targetname" ) )
                    self.additional_geo = common_scripts\utility::array_add( self.additional_geo, var_1 );
            }
        }
    }

    if ( isdefined( self.col ) )
        childthread mech_action_smash_projectile();

    var_8 = undefined;

    for (;;)
    {
        self waittill( "trigger", var_9, var_10, var_11 );
        var_12 = 0;

        if ( isstring( var_9 ) && var_9 == "weapon" )
            var_12 = 1;

        if ( self.flag_smash )
            continue;

        if ( common_scripts\utility::flag( "flag_mech_smash_active" ) && !var_12 )
            continue;

        var_13 = 0;
        var_14 = level.player meleebuttonpressed();

        if ( var_14 || var_12 )
        {
            var_8 = choosesmashnode( level.player.origin, anglestoforward( level.player.angles ), 1 );

            if ( !isdefined( var_8 ) && !var_12 )
                continue;

            if ( isdefined( var_8 ) )
                var_13 = level.player cansmash( var_8, anglestoforward( var_8.angles ) );

            if ( !var_13 && !var_12 )
                continue;

            if ( !var_12 )
            {
                if ( !var_13 )
                    continue;

                if ( distance( level.player.origin, var_8.origin ) > 70 )
                {
                    while ( level.player _meth_812E() )
                        wait 0.05;

                    continue;
                }

                if ( vectordot( anglestoforward( level.player getangles() ), anglestoforward( var_8.angles ) ) < 0.5 )
                {
                    while ( level.player _meth_812E() )
                        wait 0.05;

                    continue;
                }
            }
            else
            {
                var_8 = choosesmashnode( var_11, var_10, 0, 1 );

                if ( !isdefined( var_8 ) )
                    continue;
            }

            common_scripts\utility::flag_set( "flag_mech_smash_active" );

            if ( level.allow_threat_paint )
                common_scripts\utility::flag_clear( "flag_mech_threat_paint_ping_on" );

            self.flag_smash = 1;
            anim_prep( var_8 );

            if ( var_12 )
                soundscripts\_snd::snd_message( "mech_wall_smash_3d", self.smash_obj.origin );
            else
                soundscripts\_snd::snd_message( "mech_wall_smash" );

            if ( isdefined( self._id_03A7 ) )
            {
                if ( angleclamp180( self._id_03A7.angles[1] ) == angleclamp180( var_8.angles[1] ) )
                    self._id_03A7 _meth_83F6( 0, 4 );
                else
                    self._id_03A7 _meth_83F6( 0, 3 );
            }
            else if ( self.smash_obj.model != "tag_origin" )
            {
                var_8 thread maps\_anim::anim_single_solo( self.smash_obj, "mech_run_through" );
                self.smash_obj _meth_8117( self.smash_obj maps\_utility::getanim( "mech_run_through" ), 0.2 );
            }

            if ( isdefined( self.col ) )
            {
                self.col _meth_8058();
                self.col notify( "remove" );
                self.col delete();
            }

            if ( isdefined( self.fx ) )
                playfx( self.fx common_scripts\utility::getfx( self.fx.script_parameters ), self.fx.origin, anglestoforward( self.fx.angles ) );

            if ( isdefined( self.fx ) )
                thread smash_throw( self.fx.origin, 256 );
            else
                thread smash_throw_2( var_11 );

            foreach ( var_16 in self.additional_unlink_nodes )
                common_scripts\utility::array_thread( getnodesinradius( var_16.origin, var_16.radius, 0 ), ::disconnect_node );

            if ( !isdefined( self._id_03A7 ) && self.smash_obj.model != "tag_origin" )
                var_8 waittill( "mech_run_through" );

            if ( level.allow_threat_paint )
                common_scripts\utility::flag_set( "flag_mech_threat_paint_ping_on" );

            common_scripts\utility::flag_clear( "flag_mech_smash_active" );
            level notify( "mech_smash" );
            cleanup_mech_traversal_elements( var_8 );
            return;
        }
        else if ( level.player _meth_82F3()[0] > 0 )
        {
            var_8 = choosesmashnode( level.player.origin, anglestoforward( level.player.angles ), 1 );

            if ( !isdefined( var_8 ) )
                continue;

            if ( !level.player cansmash( var_8, anglestoforward( var_8.angles ) ) )
                continue;

            common_scripts\utility::flag_set( "flag_mech_smash_active" );

            if ( level.allow_threat_paint )
                common_scripts\utility::flag_clear( "flag_mech_threat_paint_ping_on" );

            self.flag_smash = 1;
            anim_prep( var_8 );
            level.player thread spawn_mech_rig( 1, 0.2 );

            if ( isdefined( self._id_03A7 ) )
            {
                if ( angleclamp180( self._id_03A7.angles[1] ) == angleclamp180( var_8.angles[1] ) )
                    self._id_03A7 _meth_83F6( 0, 4 );
                else
                    self._id_03A7 _meth_83F6( 0, 3 );
            }

            var_18 = [ level.player.rig ];

            if ( !isdefined( self._id_03A7 ) && self.smash_obj.model != "tag_origin" )
                var_18 = common_scripts\utility::array_add( var_18, self.smash_obj );
            else
            {
                var_8 = var_8 common_scripts\utility::spawn_tag_origin();
                var_8 thread smash_surface_float();
            }

            common_scripts\utility::flag_set( "flag_force_hud_ready" );
            var_8 thread anim_single_mech( var_18, "mech_run_through", "cap_playermech_run_through_mech_short_vm" );
            soundscripts\_snd::snd_message( "mech_wall_smash" );

            if ( isdefined( self.col ) )
            {
                self.col _meth_8058();
                self.col notify( "remove" );
                self.col delete();
            }

            if ( isdefined( self.fx ) )
                thread smash_throw( self.fx.origin, 256 );
            else
                thread smash_throw_2( var_11 );

            foreach ( var_16 in self.additional_unlink_nodes )
                common_scripts\utility::array_thread( getnodesinradius( var_16.origin, var_16.radius, 0 ), ::disconnect_node );

            if ( isdefined( self.fx ) )
                playfx( self.fx common_scripts\utility::getfx( self.fx.script_parameters ), self.fx.origin, anglestoforward( self.fx.angles ) );

            var_8 waittill( "mech_anim_done" );
            common_scripts\utility::flag_clear( "flag_force_hud_ready" );
            _func_0D3( "mechHide", 0 );
            level.player _meth_804F();
            level.player.rig delete();

            if ( level.allow_threat_paint )
                common_scripts\utility::flag_set( "flag_mech_threat_paint_ping_on" );

            common_scripts\utility::flag_clear( "flag_mech_smash_active" );
            level notify( "mech_smash" );
            cleanup_mech_traversal_elements( var_8 );
            return;
        }
    }
}

smash_surface_float()
{
    level.player.rig _meth_804D( self );
    var_0 = self.origin + anglestoforward( self.angles ) * 64 + ( 0, 0, 64 );
    var_0 = maps\_utility::groundpos( var_0 );
    var_1 = getanimlength( level.player.rig maps\_utility::getanim( "mech_run_through" ) );

    if ( isdefined( var_0 ) )
        self _meth_82AE( var_0, var_1 );

    wait(var_1);
    level.player.rig _meth_804F();
    wait 0.05;
    self delete();
}

choosesmashnode( var_0, var_1, var_2, var_3 )
{
    var_4 = sortbydistance( self.nodes, var_0 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_5 = undefined;
    var_6 = 0;
    var_7 = undefined;
    var_8 = [];

    foreach ( var_10 in var_4 )
    {
        var_11 = 0;
        var_7 = vectordot( anglestoforward( var_10.angles ), vectornormalize( var_1 ) );

        if ( var_7 > 0.7 )
        {
            var_11 = 1;
            var_5 = var_10;
        }
        else if ( var_3 && var_7 > var_6 )
            var_5 = var_10;

        if ( var_2 )
        {
            var_12 = 32;

            if ( isdefined( var_10.radius ) )
                var_12 = var_10.radius;

            var_13 = distance2d( level.player.origin, var_10.origin );

            if ( var_13 > var_12 )
                var_5 = undefined;
        }

        if ( isdefined( var_5 ) && var_11 )
            var_8 = common_scripts\utility::array_add( var_8, var_5 );
    }

    if ( var_8.size > 0 && var_2 )
        return var_8[0];

    if ( isdefined( var_5 ) )
        return var_5;
}

cansmash( var_0, var_1 )
{
    if ( self _meth_817C() != "stand" )
        return 0;

    if ( distance( ( 0, 0, self.origin[2] ), ( 0, 0, var_0.origin[2] ) ) > 64 )
        return 0;

    var_2 = var_0.origin + ( 0, 0, 64 );

    if ( !level.player maps\_utility::player_looking_at( var_2 + var_1 * 64, 0.7, 1 ) )
        return 0;

    return 1;
}

smash_throw_2( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self.smash_obj.origin;

    if ( !isdefined( var_1 ) )
        var_1 = 128;

    foreach ( var_3 in sortbydistance( maps\_utility::remove_dead_from_array( level.mech_crush ), var_0, var_1 ) )
        var_4 = var_3 death_throw( var_0, var_1, 1 );
}

smash_throw( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = self.smash_obj.origin;

    if ( !isdefined( var_1 ) )
        var_1 = 170;

    foreach ( var_3 in sortbydistance( maps\_utility::remove_dead_from_array( level.mech_crush ), var_0, var_1 ) )
        var_3 thread smash_throw_solo();

    physicsexplosionsphere( var_0, var_1, var_1, 1 );
}

smash_throw_solo()
{
    if ( isdefined( self.smash_throw_active ) )
        return;

    self.smash_throw_active = 1;
    var_0 = common_scripts\utility::spawn_tag_origin();
    self.animname = "generic";
    self.a.nodeath = 1;
    self.allowdeath = 1;
    level.player maps\_playermech_code::disable_stencil( self );
    self.noragdoll = 0;
    self _meth_8023();
    var_0 thread maps\_anim::anim_single_solo( self, "explode_death" );
    wait 0.25;

    if ( isalive( self ) )
    {
        self notify( "death", level.player, "MOD_MECH_SMASH" );
        self _meth_8052();
    }

    var_0 delete();
}

mech_action_smash_projectile()
{
    self.col _meth_82C0( 1 );
    self.col _meth_82C1( 1 );
    self.col _meth_82BE();
    self.col endon( "remove" );

    if ( isdefined( self.col.hits_left ) )
        return;

    var_0 = 2;
    self.col.hits_left = var_0;

    for (;;)
    {
        self.col waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( !isdefined( var_5 ) )
            continue;

        if ( isdefined( var_2 ) && var_2 == level.player )
        {
            if ( issubstr( var_5, "BULLET" ) )
            {
                self.col.hits_left--;

                if ( self.col.hits_left <= 0 )
                    self notify( "trigger", "weapon", var_3, var_4 );
                else if ( isdefined( self._id_03A7 ) && !isdefined( self.damaged ) )
                {
                    var_6 = choosesmashnode( var_4, var_3, 0, 1 );

                    if ( !isdefined( var_6 ) )
                        continue;

                    if ( angleclamp180( self._id_03A7.angles[1] ) == angleclamp180( var_6.angles[1] ) )
                        self._id_03A7 _meth_83F6( 0, 1 );
                    else
                        self._id_03A7 _meth_83F6( 0, 2 );

                    self.damaged = 1;
                }

                continue;
            }

            if ( isdefined( var_5 ) && issubstr( var_5, "GRENADE" ) )
            {
                self notify( "trigger", "weapon", var_3, var_4 );
                continue;
            }

            if ( isdefined( var_5 ) && ( issubstr( var_5, "SPLASH" ) || var_5 == "MOD_PROJECTILE" ) )
            {
                self notify( "trigger", "weapon", var_3, var_4 );
                continue;
            }
        }
    }
}

anim_prep( var_0 )
{
    if ( isdefined( self._id_03A7 ) )
        self.smash_obj = self._id_03A7;
    else if ( isdefined( var_0.script_parameters ) )
        self.smash_obj = maps\_utility::spawn_anim_model( var_0.script_parameters );
    else
        self.smash_obj = var_0 common_scripts\utility::spawn_tag_origin();

    if ( isdefined( var_0.height ) )
        self.smash_obj.height = var_0.height;

    if ( isdefined( self.additional_geo ) )
    {
        foreach ( var_2 in self.additional_geo )
        {
            if ( isdefined( var_2 ) )
                var_2 delete();
        }
    }

    self.additional_geo = undefined;

    if ( isdefined( self.glass ) )
    {
        foreach ( var_5 in self.glass )
            deleteglass( var_5 );
    }

    self.glass = undefined;

    if ( isdefined( self.opp_trig ) )
        self.opp_trig cleanup_mech_traversal_elements( var_0, 0 );
}

setup_smash_nodes()
{
    foreach ( var_1 in getallnodes() )
    {
        if ( issubstr( var_1.type, "Cover" ) || issubstr( var_1.type, "Conceal" ) || issubstr( var_1.type, "Exposed" ) )
        {
            if ( isdefined( var_1.script_nodestate ) )
            {
                var_1.state = tolower( var_1.script_nodestate );

                switch ( var_1.state )
                {
                    case "linked":
                        break;
                    case "unlinked":
                        var_1 disconnect_node( 1 );
                        break;
                    default:
                        iprintln( "Warning: node at " + var_1.origin + " has a .script_nodestate of '" + var_1.state );
                }

                level._mb.nodes = common_scripts\utility::array_add( level._mb.nodes, var_1 );
            }
        }
    }
}

cleanup_mech_traversal_elements( var_0, var_1 )
{
    if ( isdefined( self.smash_obj ) && !isdefined( self._id_03A7 ) )
        self.smash_obj delete();

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( isdefined( self.additional_geo ) )
    {
        foreach ( var_3 in self.additional_geo )
        {
            if ( isdefined( var_3 ) )
                var_3 delete();
        }
    }

    if ( isdefined( self.glass ) )
    {
        foreach ( var_6 in self.glass )
            deleteglass( var_6 );
    }

    if ( isdefined( self.col ) )
    {
        self.col _meth_8058();
        self.col notify( "remove" );
        self.col delete();
    }

    if ( var_1 )
    {
        var_8 = 128;

        if ( isdefined( var_0.height ) )
            var_8 = var_0.height;

        foreach ( var_10 in getnodesinradius( var_0.origin, 128, 0, var_8 ) )
        {
            if ( isdefined( var_10.state ) )
            {
                if ( isdefined( var_0.height ) || !issubstr( var_10.type, "exposed" ) && node_is_exposed( var_10.origin + ( 0, 0, 32 ) + anglestoforward( var_10.angles ) * 64, var_10 ) )
                {
                    if ( var_10.state == "linked" )
                        var_10 disconnect_node();

                    level._mb.nodes = common_scripts\utility::array_remove( level._mb.nodes, var_10 );
                    var_10.state = undefined;
                    continue;
                }

                if ( var_10.state == "unlinked" )
                    var_10 connect_node();
            }
        }
    }

    self delete();
}

connect_node()
{
    self.state = "linked";
    self _meth_805A();
}

disconnect_node( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( var_0 )
        self.state = "unlinked";
    else
        self.state = "disabled";

    self _meth_8059();

    if ( isdefined( self.owner ) && !isplayer( self.owner ) )
        self.owner maps\captured_mech::go_to_vol();
}

node_is_exposed( var_0, var_1 )
{
    if ( var_1.type == "Cover Multi" )
    {
        foreach ( var_3 in [ "Cover Left", "Cover Right" ] )
        {
            if ( isdefined( var_1.offset ) )
                var_1.offset = undefined;

            if ( !sighttracepassed( var_1.origin + animscripts\utility::getnodeoffset( var_1, var_3 ), var_0, 0, undefined ) )
                return 0;
        }

        return 1;
    }
    else
        return sighttracepassed( var_1.origin + animscripts\utility::getnodeoffset( var_1 ), var_0, 0, undefined );
}

mech_action_shoot()
{
    self._id_03A7 = _func_231( self.target, "targetname" )[0];
    self _meth_82C0( 1 );
    self _meth_82C1( 1 );
    self._id_03A7 waittill( "death" );

    foreach ( var_1 in getnodesinradius( self.origin, self.radius, 0, self.height ) )
        var_1 disconnect_node();
}

mech_crush()
{
    self endon( "exit_mech" );
    level.mech_crush = [];
    var_0 = 64;

    for (;;)
    {
        if ( !common_scripts\utility::flag( "flag_mech_smash_active" ) )
        {
            foreach ( var_2 in level.mech_crush )
            {
                if ( var_2 death_throw( self.origin, var_0, 0 ) )
                    soundscripts\_snd::snd_message( "aud_mech_crush_guy", var_2 );
            }
        }

        wait 0.05;
    }
}

#using_animtree("generic_human");

mech_victim_death_func()
{
    if ( self.damagemod == "MOD_MELEE" || isdefined( self.mech_death_throw ) && self.mech_death_throw )
    {
        var_0 = level.player.origin;
        var_1 = self.origin - ( var_0[0], var_0[1], self.origin[2] );
        self _meth_81C5( self.origin, vectortoangles( var_1 ) );
        self.deathanim = %death_explosion_run_f_v2;
    }

    return 0;
}

spawnfunc_mech_crush()
{
    self.deathfunction = ::mech_victim_death_func;
    self.badplaceawareness = 1;
    self.a.disablelongdeath = 1;
    level.mech_crush = common_scripts\utility::array_add( level.mech_crush, self );
}

death_throw( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isalive( self ) || !isai( self ) || isdefined( self.playingdeathanim ) )
    {
        if ( isdefined( common_scripts\utility::array_find( level.mech_crush, self ) ) )
            level.mech_crush = common_scripts\utility::array_remove( level.mech_crush, self );

        return 0;
    }

    var_3 = distance( var_0, self.origin );
    var_4 = 200;
    var_5 = level.player getvelocity();
    var_6 = length( var_5 );
    var_7 = self.origin - ( var_0[0], var_0[1], self.origin[2] );
    var_8 = vectordot( var_5, var_7 );

    if ( var_3 <= var_1 )
    {
        if ( !var_2 && !level.player _meth_83D8() && ( var_6 < var_4 || var_8 <= 0 ) )
            return 0;

        maps\_utility::anim_stopanimscripted();
        self.mech_death_throw = 1;
        self.allowdeath = 1;
        self notify( "death", level.player, "MOD_MECH_CRUSH" );
        self _meth_8052();
        return 1;
    }
    else if ( var_3 < 200 )
    {
        if ( !self.ignoreall )
        {
            if ( !isdefined( self.noclosemechrun ) || !self.noclosemechrun )
            {
                self.ignoreall = 1;
                maps\_utility::delaythread( 6, maps\_utility::set_ignoreall, 0 );
            }
        }
    }

    return 0;
}

spawn_mech_rig( var_0, var_1 )
{
    self.rig = maps\_utility::spawn_anim_model( "mech_player_rig", self.origin, self.angles );
    self.rig hide();

    foreach ( var_3 in common_scripts\utility::array_combine( level.mechdata_left_bones, level.mechdata_right_bones ) )
        self.rig _meth_8048( var_3 );

    if ( !isdefined( var_0 ) )
        return;

    if ( !var_0 )
        var_1 = 0;
    else if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( var_0 )
        self _meth_8080( self.rig, "tag_player", var_1 );

    wait(var_1);
    self _meth_807D( self.rig, "tag_player", 1, 0, 0, 0, 0, 1 );
}

anim_single_mech( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_0 = set_array( var_0 );

    if ( !isdefined( var_4 ) )
        var_4 = level.player;

    var_8 = isarray( var_0[0] maps\_utility::getanim( var_1 ) );

    if ( !isdefined( var_3 ) )
    {
        if ( var_8 )
            var_3 = 0;
        else
            var_3 = 1;
    }

    if ( var_3 )
    {
        var_4._frozen_controls = 1;
        var_4 freezecontrols( 1 );
    }

    if ( !isdefined( var_2 ) )
        iprintln( "Warning: no vm_anim_index for anim_single_player() call for '" + var_1 + "'" );

    level.player _meth_8499();

    if ( var_8 )
    {
        var_4 notify( "mech_anim_loop_start" );
        self notify( "mech_anim_loop_start" );
        thread anim_loop_vm( var_4, var_2, getanimlength( var_0[0] maps\_utility::getanim( var_1 )[0] ) );
        maps\_anim::anim_loop( var_0, var_1, undefined, var_5 );
        var_4 notify( "mech_anim_loop_done" );
        self notify( "mech_anim_loop_done" );
    }
    else
    {
        var_4 notify( "mech_anim_start" );
        self notify( "mech_anim_start" );
        var_4 _meth_84B5( var_2 );
        maps\_anim::anim_single( var_0, var_1, var_5, var_6, var_7 );
        var_4 notify( "mech_anim_done" );
        self notify( "mech_anim_done" );
    }

    if ( var_3 )
    {
        var_4 freezecontrols( 0 );
        var_4._frozen_controls = 0;
    }
}

anim_loop_vm( var_0, var_1, var_2 )
{
    self endon( "stop_loop" );
    var_0 _meth_84B5( var_1 );

    for (;;)
    {
        wait(var_2);
        var_0 _meth_84B6( 0 );
    }
}

mech_obj_move( var_0, var_1 )
{
    if ( isstring( var_0.node ) )
    {
        var_0.node = common_scripts\utility::getstruct( var_0.node, "targetname" );

        if ( !isdefined( var_0.node ) )
            var_0.node = getent( var_0.node, "targetname" );
    }

    var_0.state = "none";
    var_0.current_anim = undefined;
    var_0.current_anim_vm = undefined;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( isdefined( var_0.intro_anim ) )
    {
        var_0.state = "intro_anim";
        self notify( "intro_anim_start" );
        var_0.node anim_single_mech( var_0.guys, var_0.intro_anim, var_0.intro_anim_vm );
        self notify( "intro_anim_done" );
        var_0.current_anim = var_0.intro_anim;
        var_0.current_anim_vm = var_0.intro_anim_vm;
    }

    var_2 = 0;

    if ( isdefined( var_0.main_anims ) )
    {
        var_0.main_anims = set_array( var_0.main_anims );
        var_0.main_anims_vm = set_array( var_0.main_anims_vm );

        if ( var_0.input_type == "mash" )
        {
            if ( isdefined( var_0.rev_main_anims ) )
            {
                var_0.rev_main_anims = set_array( var_0.rev_main_anims );
                var_0.rev_main_anims_vm = set_array( var_0.rev_main_anims_vm );
            }

            var_3 = 1;
            var_4 = undefined;
            common_scripts\utility::flag_set( "hint_mash_button" );
            maps\_utility::display_hint( "hint_mash_button" );
            self.button_mash_level = 0;
            self.button_mash_success = 2;
            thread button_mash_detection();

            for (;;)
            {
                self.button_mash_level = clamp( self.button_mash_level, 0, 2 );

                if ( self.button_mash_level >= 2 )
                {
                    var_3 = 1;

                    if ( !isdefined( var_4 ) )
                        var_4 = 0;
                    else
                        var_4++;
                }
                else
                    var_3 = 0;

                if ( isdefined( var_4 ) && var_4 == var_0.main_anims.size )
                    break;

                var_5 = undefined;
                var_6 = undefined;

                if ( isdefined( var_4 ) )
                {
                    if ( !var_3 )
                    {
                        var_5 = var_0.rev_main_anims[var_4];
                        var_6 = var_0.rev_main_anims_vm[var_4];
                        var_4--;

                        if ( var_4 < 0 )
                            var_4 = undefined;
                    }
                    else
                    {
                        var_5 = var_0.main_anims[var_4];
                        var_6 = var_0.main_anims_vm[var_4];

                        if ( !var_1 )
                            thread constant_quake();
                    }

                    if ( var_2 )
                    {
                        self notify( "post_intro_loop_anim_done" );
                        var_0.node notify( "stop_loop" );
                        common_scripts\utility::array_thread( var_0.guys, maps\_utility::anim_stopanimscripted );
                        var_2 = 0;
                    }

                    var_0.state = "main_anims";
                    self notify( "main_anim_start" + var_5 );
                    soundscripts\_snd::snd_message( "aud_mech_obj_move", var_5 );
                    var_0.node anim_single_mech( var_0.guys, var_5, var_6 );
                    self notify( "main_anim_done" + var_5 );
                    thread stop_constant_quake();

                    if ( isdefined( var_0.rev_main_anims ) && isdefined( var_4 ) && !isdefined( var_0.rev_main_anims[var_4] ) )
                        break;
                }
                else
                {
                    if ( isdefined( var_0.post_intro_loop_anim ) && !isdefined( var_4 ) && !var_2 )
                    {
                        var_0.state = "post_intro_loop_anim";
                        self notify( "post_intro_loop_anim_start" );
                        soundscripts\_snd::snd_message( "aud_mech_obj_move_wait" );
                        var_0.node thread anim_single_mech( var_0.guys, var_0.post_intro_loop_anim, var_0.post_intro_loop_anim_vm );
                        var_2 = 1;
                        continue;
                    }

                    wait 0.05;
                }
            }

            if ( isdefined( var_0.post_main_loop_anim ) )
            {
                var_0.state = "post_main_loop_anim";
                self notify( "post_main_loop_anim_start" );
                soundscripts\_snd::snd_message( "aud_mech_obj_move_wait" );
                var_0.node thread anim_single_mech( var_0.guys, var_0.post_main_loop_anim, var_0.post_main_loop_anim_vm );

                if ( !var_1 )
                    thread constant_quake();

                while ( self.button_mash_level >= 2 )
                    wait 0.05;

                self notify( "post_main_loop_anim_done" );
                var_0.node notify( "stop_loop" );
                common_scripts\utility::array_thread( var_0.guys, maps\_utility::anim_stopanimscripted );
            }
        }
        else if ( var_0.input_type == "push_forward" || var_0.input_type == "pull_back" )
        {
            thread add_idle_control( var_0, var_1 );

            if ( isdefined( var_0.post_intro_loop_anim ) && !var_2 )
            {
                var_0.state = "post_intro_loop_anim";
                self notify( "post_intro_loop_anim_start" );
                var_0.node thread anim_single_mech( var_0.guys, var_0.post_intro_loop_anim, var_0.post_intro_loop_anim_vm );
                self waittill( "input_success" );
                self notify( "post_intro_loop_anim_done" );
                var_0.node notify( "stop_loop" );
                common_scripts\utility::array_thread( var_0.guys, maps\_utility::anim_stopanimscripted );
                var_2 = 0;
            }

            var_0.state = "main_anims";

            for ( var_7 = 0; var_7 < var_0.main_anims.size; var_7++ )
            {
                var_0.current_anim = var_0.main_anims[var_7];
                var_0.current_anim_vm = var_0.main_anims_vm[var_7];
                var_0.node anim_single_mech( var_0.guys, var_0.main_anims[var_7], var_0.main_anims_vm[var_7], 0 );
            }

            self notify( "stop_add_idle_control" );
            common_scripts\utility::flag_clear( "hint_" + var_0.input_type );
        }
        else
        {

        }
    }

    thread stop_constant_quake();

    if ( isdefined( var_0.exit_anim ) )
    {
        var_0.state = "exit_anim";
        self notify( "exit_anim_start" );
        soundscripts\_snd::snd_message( "aud_mech_obj_move_end" );
        var_0.node anim_single_mech( var_0.guys, var_0.exit_anim, var_0.exit_anim_vm );
        self notify( "exit_anim_done" );
    }

    self _meth_804F();
    self.rig delete();
}

constant_quake()
{
    self endon( "stop_quake" );

    for (;;)
    {
        earthquake( 0.5, 0.05, self.origin, 128 );
        self _meth_80AD( "damage_heavy" );
        wait 0.05;
    }
}

stop_constant_quake()
{
    self notify( "stop_quake" );
}

add_idle_control( var_0, var_1 )
{
    self endon( "stop_add_idle_control" );
    var_2 = 0;
    var_3 = 0;
    common_scripts\utility::flag_set( "hint_" + var_0.input_type );
    maps\_utility::display_hint( "hint_" + var_0.input_type );

    for (;;)
    {
        var_3 = 0;

        if ( var_0.input_type == "push_forward" )
        {
            if ( self _meth_82F3()[0] > 0 )
                var_3 = 1;
        }
        else if ( var_0.input_type == "pull_back" )
        {
            if ( self _meth_82F3()[0] < 0 )
                var_3 = 1;
        }

        if ( var_3 )
            self notify( "input_success" );

        if ( var_0.state == "main_anims" )
        {
            if ( var_3 )
            {
                if ( var_2 )
                {
                    var_2 = 0;

                    if ( isdefined( var_0.main_anim_idle_vm ) )
                        self _meth_84B8( 0 );

                    maps\_anim::anim_set_rate( var_0.guys, var_0.current_anim, 1 );
                    self _meth_84B7( 0 );

                    if ( !var_1 )
                        thread constant_quake();
                }

                common_scripts\utility::flag_clear( "hint_" + var_0.input_type );
            }
            else
            {
                common_scripts\utility::flag_set( "hint_" + var_0.input_type );
                maps\_utility::display_hint( "hint_" + var_0.input_type );

                if ( !var_2 )
                {
                    var_2 = 1;
                    maps\_anim::anim_set_rate( var_0.guys, var_0.current_anim, 0 );
                    self _meth_84B7( 1 );

                    if ( isdefined( var_0.main_anim_idle_vm ) )
                        self _meth_84B8( var_0.main_anim_idle_vm );

                    thread stop_constant_quake();
                }
            }
        }

        wait 0.05;
    }
}

button_mash_detection()
{
    self endon( "notify_stop_mash_detection" );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        if ( self usebuttonpressed() )
            var_1++;
        else
            var_1 = 0;

        if ( var_1 > 0 && var_1 < 20 )
        {
            if ( self.button_mash_level < self.button_mash_success )
                self.button_mash_level += 1;

            var_0 = 0;
            var_1++;
        }
        else
        {
            var_0++;

            if ( var_0 >= 4 && self.button_mash_level > 0 )
                self.button_mash_level -= 1;
        }

        wait 0.05;
    }
}

set_array( var_0 )
{
    if ( isarray( var_0 ) )
        return var_0;
    else
        return [ var_0 ];
}

disable_threat_ping()
{
    common_scripts\utility::flag_clear( "flag_mech_threat_paint_ping_on" );
    level.allow_threat_paint = 0;
}

enable_threat_ping()
{
    common_scripts\utility::flag_set( "flag_mech_threat_paint_ping_on" );
    level.allow_threat_paint = 1;
}
