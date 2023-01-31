// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

move_player_to_ent_by_targetname( var_0 )
{
    var_1 = get_ent_by_targetname( var_0 );
    maps\_utility::teleport_player( var_1 );
    return var_1;
}

move_squad_member_to_ent_by_targetname( var_0 )
{
    var_1 = get_ent_by_targetname( var_0 );
    self _meth_81C6( var_1.origin, var_1.angles );
}

move_squad_member_to_ent( var_0 )
{
    self _meth_81C6( var_0.origin, var_0.angles );
}

give_player_just_hands()
{
    level.player _meth_831D();
    level.player _meth_8130( 0 );
    level.player _meth_8304( 0 );
    level.player _meth_81E1( 0.45 );
    level thread start_player_walk_sway();
}

give_player_gun()
{
    level.player _meth_831E();
    level.player _meth_8130( 1 );
    level.player _meth_8304( 1 );
    level.player maps\_utility::blend_movespeedscale_default();
    level.player notify( "stop_player_walk_sway" );
}

activate_betrayal_exo_abilities()
{
    maps\_player_exo::setboostdash();
    maps\_player_exo::setoverdrive();
    maps\_player_exo::setexoslide();
}

deactivate_betrayal_exo_abilities()
{
    maps\_player_exo::unsetboostdash();
    maps\_player_exo::unsetoverdrive();
    maps\_player_exo::unsetexoslide();
}

start_player_walk_sway()
{
    level.player endon( "death" );
    level.player endon( "stop_player_walk_sway" );

    for (;;)
    {
        _func_234( level.player.origin, 1, 1, 0.5, 2, 0.2, 0.2, 0, 0.15, 0.18, 0.05 );
        wait 1.5;
    }
}

start_player_office_scene_walk_sway()
{
    level.player endon( "death" );
    level.player endon( "stop_player_walk_sway" );
    common_scripts\utility::flag_wait( "flag_objective_office_scene_follow_gideon" );
    var_0 = getdvar( "bg_viewBobAmplitudeStanding" );
    var_1 = getdvar( "bg_viewBobAmplitudeDucked" );
    var_2 = getdvar( "bg_viewBobMax" );
    _func_0D3( "bg_viewBobAmplitudeStanding", "0.005 0.01" );
    _func_0D3( "bg_viewBobAmplitudeDucked", "0.002 0.005" );
    _func_0D3( "bg_viewBobMax", 3 );
    level.player _meth_83F5( 0.8 );
    common_scripts\utility::flag_wait( "flag_confrontation_give_player_real_gun" );
    _func_0D3( "bg_viewBobAmplitudeStanding", var_0 );
    _func_0D3( "bg_viewBobAmplitudeDucked", var_1 );
    _func_0D3( "bg_viewBobMax", var_2 );
    level.player _meth_83F5( 1 );
}

player_apply_mission_failed_wrapper_on_death_for_duration( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        level.player common_scripts\utility::waittill_any_timeout( var_1, "death" );
        setdvar( "ui_deadquote", &"mission_fail_wrapper" );
        maps\_utility::missionfailedwrapper();
    }
}

player_mission_failed_handler( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && common_scripts\utility::flag( var_1 ) || isdefined( var_2 ) && !common_scripts\utility::flag( var_2 ) )
    {
        common_scripts\utility::flag_set( "disable_autosaves" );
        level.player common_scripts\utility::waittill_any_timeout( var_0, "death" );

        if ( isdefined( var_1 ) && !common_scripts\utility::flag( var_1 ) || isdefined( var_2 ) && common_scripts\utility::flag( var_2 ) )
        {
            common_scripts\utility::flag_clear( "disable_autosaves" );
            maps\_utility::autosave_by_name();
            return 1;
        }
        else
        {
            wait 0.5;
            setdvar( "ui_deadquote", &"BETRAYAL_FAIL_ESCAPE" );
            maps\_utility::missionfailedwrapper();
            return 0;
        }
    }
    else
        return 1;
}

spawn_squad( var_0, var_1, var_2 )
{
    if ( isdefined( var_1 ) && var_1 )
        level.gideon = spawn_squad_member( var_0, "gideon" );

    if ( isdefined( var_2 ) && var_2 )
    {
        level.ilana = spawn_squad_member( var_0, "ilana" );
        level.ilana maps\_utility::place_weapon_on( "iw5_sn6_sp_opticsreddot", "right" );
        level.ilana maps\_utility::gun_remove();
    }
}

spawn_squad_member( var_0, var_1 )
{
    var_2 = spawn_ai_from_targetname_single( "spawner_squad_" + var_1, 1, 1 );
    var_2.ignoreall = 1;
    var_2.dontmelee = 1;
    var_2 maps\_utility::gun_remove();

    if ( var_1 == "gideon" )
        var_2 maps\_urgent_walk::set_urgent_walk_anims();

    var_2 setup_hero( var_1 );
    var_2 start_squad_member_at_start( var_0 + "_" + var_1 );
    var_2 _meth_81A6( var_2.origin );
    return var_2;
}

setup_hero( var_0 )
{
    maps\_utility::make_hero();
    self.animname = var_0;
}

start_squad_member_at_start( var_0 )
{
    var_1 = get_ent_by_targetname( var_0 );
    self _meth_81C6( var_1.origin, var_1.angles );
}

player_knockout_white()
{
    level.crash_overlay = get_white_overlay();
    level.crash_overlay thread blackout( 0.01, 2 );
}

player_knockout_wakeup()
{
    if ( isdefined( level.crash_overlay ) )
        level.crash_overlay thread restorevision( 2.0, 0 );

    level.player shellshock( "default", 6.0 );
}

get_white_overlay()
{
    if ( !isdefined( level.white_overlay ) )
        level.white_overlay = maps\_hud_util::create_client_overlay( "white", 0, level.player );

    level.white_overlay.sort = -1;
    level.white_overlay.foreground = 1;
    return level.white_overlay;
}

blackout( var_0, var_1 )
{
    fadeoverlay( var_0, 1, var_1 );
}

restorevision( var_0, var_1 )
{
    fadeoverlay( var_0, 0, var_1 );
}

fadeoverlay( var_0, var_1, var_2 )
{
    self fadeovertime( var_0 );
    self.alpha = var_1;
    _func_072( var_2, var_0 );
    wait(var_0);
}

animate_player_on_rig_simple( var_0, var_1, var_2, var_3, var_4 )
{
    level.rig = maps\_utility::spawn_anim_model( var_0, level.player.origin, level.player.angles );
    level.rig hide();
    level.player maps\_shg_utility::setup_player_for_scene();
    var_5 = 0.5;

    if ( isdefined( var_3 ) )
        var_5 = var_3;

    var_6 = get_ent_by_targetname( var_2 );
    var_6 maps\_anim::anim_first_frame_solo( level.rig, var_1 );
    level.player _meth_8080( level.rig, "tag_player", var_5 );
    level.rig common_scripts\utility::delaycall( var_5, ::show );
    level.player common_scripts\utility::delaycall( var_5, ::_meth_807D, level.rig, "tag_player", 1.0, 0, 0, 0, 0, 1 );

    if ( isdefined( var_4 ) )
    {
        var_4 = common_scripts\utility::array_add( var_4, level.rig );
        var_6 maps\_anim::anim_single( var_4, var_1 );
    }
    else
        var_6 maps\_anim::anim_single_solo( level.rig, var_1 );

    level.player _meth_804F();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.rig delete();
}

spawn_ai_from_targetname_single( var_0, var_1, var_2 )
{
    var_3 = spawn_ai_from_targetname( var_0, var_1, var_2 );
    return var_3[0];
}

spawn_ai_from_targetname( var_0, var_1, var_2 )
{
    var_3 = get_ents_by_targetname( var_0 );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = [];

    foreach ( var_6 in var_3 )
        var_4[var_4.size] = var_6 maps\_utility::spawn_ai( var_1, var_2 );

    return var_4;
}

add_spawn_function_to_targetname( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = get_ents_by_targetname( var_0 );
    common_scripts\utility::array_thread( var_7, maps\_utility::add_spawn_function, var_1, var_2, var_3, var_4, var_5, var_6 );
}

add_spawn_function_to_noteworthy( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = get_ents_by_noteworthy( var_0 );
    common_scripts\utility::array_thread( var_7, maps\_utility::add_spawn_function, var_1, var_2, var_3, var_4, var_5, var_6 );
}

remove_on_spawner_delete()
{
    self endon( "death" );
    var_0 = self.spawner;
    self.script_linkname = undefined;
    var_0 waittill( "death" );

    if ( isai( self ) )
        delete_ai();

    if ( maps\_vehicle::isvehicle() )
        delete_veh();
}

allow_boost_jump()
{
    self.canjumppath = 1;
}

remove_display_name()
{
    self.name = " ";
}

set_display_name( var_0 )
{
    self.name = var_0;
}

setup_squad_member_for_scene()
{
    self.old_name = self.name;
    self.name = " ";
}

setup_squad_member_for_gameplay()
{
    self.name = self.old_name;
}

force_to_always_sidearm()
{
    animscripts\utility::setalwaysusepistol( 1 );
}

set_custom_patrol_anim_set( var_0 )
{
    set_custom_run_anim( var_0 );
    self _meth_81CA( "stand" );
    self.oldcombatmode = self.combatmode;
    self.combatmode = "no_cover";
    maps\_utility::disable_cqbwalk();
}

set_custom_run_anim( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( level.scr_anim["generic"]["patrol_walk_" + var_0] ) )
        var_1 = "patrol_walk_" + var_0;

    if ( isdefined( level.scr_anim["generic"]["patrol_walk_weights_" + var_0] ) )
        var_2 = "patrol_walk_weights_" + var_0;

    maps\_utility::set_generic_run_anim_array( var_1, var_2, 1 );

    if ( isdefined( level.scr_anim["generic"]["patrol_idle_" + var_0] ) )
    {
        var_3 = "patrol_idle_" + var_0;
        maps\_utility::set_generic_idle_anim( var_3 );
    }

    if ( isdefined( level.scr_anim["generic"]["patrol_transin_" + var_0] ) )
    {
        self.customarrivalfunc = ::custom_idle_trans_function;
        self.startidletransitionanim = level.scr_anim["generic"]["patrol_transin_" + var_0];
    }

    if ( isdefined( level.scr_anim["generic"]["patrol_transout_" + var_0] ) )
    {
        self.permanentcustommovetransition = 1;
        self.custommovetransition = animscripts\cover_arrival::custommovetransitionfunc;
        self.startmovetransitionanim = level.scr_anim["generic"]["patrol_transout_" + var_0];
    }
}

clear_custom_patrol_anim_set()
{
    maps\_utility::clear_generic_run_anim();
    maps\_utility::clear_generic_idle_anim();
    self.permanentcustommovetransition = undefined;
    self.custommovetransition = undefined;
    self.startmovetransitionanim = undefined;
    self.customarrivalfunc = undefined;
    self.startidletransitionanim = undefined;
    self _meth_81CA( "stand", "crouch", "prone" );

    if ( isdefined( self.oldcombatmode ) )
        self.combatmode = self.oldcombatmode;
}

#using_animtree("generic_human");

custom_idle_trans_function()
{
    if ( !isdefined( self.startidletransitionanim ) )
        return;

    var_0 = self.approachnumber;
    var_1 = self.startidletransitionanim;

    if ( !isdefined( self.heat ) )
        thread animscripts\cover_arrival::abortapproachifthreatened();

    self _meth_8142( %body, 0.2 );
    self _meth_8113( "coverArrival", var_1, 1, 0.2, self.movetransitionrate );
    animscripts\face::playfacialanim( var_1, "run" );
    animscripts\shared::donotetracks( "coverArrival", animscripts\cover_arrival::handlestartaim );
    var_2 = anim.arrivalendstance[self.approachtype];

    if ( isdefined( var_2 ) )
        self.a.pose = var_2;

    self.a.movement = "stop";
    self.a.arrivaltype = self.approachtype;
    self _meth_8142( %root, 0.3 );
    self.lastapproachaborttime = undefined;
    var_3 = self.origin - self.goalpos;
}

event_actor_animations( var_0, var_1, var_2 )
{
    level endon( var_2 );
    self endon( "death" );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( var_1[var_3]["anim"] != "SKIP_BEAT" )
        {
            common_scripts\utility::flag_wait( var_1[var_3]["wait_flag"] );
            stop_current_animations();

            if ( var_1[var_3]["anim"] == "PATH_TO_TARGET" )
            {
                maps\_utility::set_goalradius( 16 );
                self notify( "move" );

                if ( var_1[var_3 + 1]["anim"] != "TELEPORT_TO_TARGET" )
                {
                    self waittill( "goal" );
                    self.target = undefined;
                    common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                }

                continue;
            }

            if ( var_1[var_3]["anim"] == "TELEPORT_TO_TARGET" )
            {
                var_4 = getnode( self.target, "targetname" );
                maps\_utility::teleport_ai( var_4 );
                common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "WAIT_DELAY" )
            {
                common_scripts\utility::flag_wait( var_1[var_3]["wait_for"] );
                common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "REACT" )
            {
                self.animname = "scripted";
                var_5 = self.script_parameters;
                maps\_anim::anim_single_solo( self, var_5 );
                continue;
            }

            if ( isarray( level.scr_anim["scripted"][var_1[var_3]["anim"]] ) )
            {
                self.animname = "scripted";
                thread maps\_anim::anim_loop( [ self ], var_1[var_3]["anim"] );
                continue;
            }

            self.animname = "scripted";
            maps\_anim::anim_single_solo( self, var_1[var_3]["anim"] );
            common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
        }
    }
}

generic_event_actor_animations( var_0, var_1, var_2 )
{
    level endon( var_2 );
    self endon( "death" );

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( var_1[var_3]["anim"] != "SKIP_BEAT" )
        {
            common_scripts\utility::flag_wait( var_1[var_3]["wait_flag"] );
            stop_current_animations();

            if ( var_1[var_3]["anim"] == "IDLE" )
            {
                self.animname = "scripted";
                var_4 = self.animation;
                thread maps\_anim::anim_loop( [ self ], var_4 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "PATH_TO_TARGET" )
            {
                self notify( "move" );

                if ( var_1[var_3 + 1]["anim"] != "TELEPORT_TO_TARGET" )
                {
                    self waittill( "goal" );
                    self.target = undefined;
                    common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                }

                continue;
            }

            if ( var_1[var_3]["anim"] == "TELEPORT_TO_TARGET" )
            {
                var_5 = getnode( self.target, "targetname" );
                maps\_utility::teleport_ai( var_5 );
                common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "TARGET_REACHED_IDLE_ANIM" )
            {
                self.animname = "scripted";
                var_4 = self.script_parameters;
                maps\_anim::anim_single_solo( self, var_4 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "WAIT_DELAY" )
            {
                common_scripts\utility::flag_wait( var_1[var_3]["wait_for"] );
                common_scripts\utility::flag_set( var_0 + "_completed_beat_" + var_3 );
                continue;
            }

            if ( var_1[var_3]["anim"] == "REACT" )
            {
                self.animname = "scripted";
                var_4 = self.script_noteworthy;
                maps\_anim::anim_single_solo_run( self, var_4 );
            }
        }
    }
}

stop_current_animations( var_0 )
{
    self endon( "death" );
    self _meth_8141();
    self notify( "drone_stop" );
    self notify( "stop_loop" );
    self notify( "single anim", "end" );
    self notify( "looping anim", "end" );

    if ( isdefined( var_0 ) )
    {
        var_0 notify( "drone_stop" );
        var_0 notify( "stop_loop" );
        var_0 notify( "single anim", "end" );
        var_0 notify( "looping anim", "end" );
    }
}

simple_anim_at_struct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_2 = var_1.animation;
    wait(randomfloatrange( 0.5, 2 ));
    var_1 maps\_anim::anim_reach_solo( self, var_2 );
    var_1 maps\_anim::anim_single_solo( self, var_2 );
    self notify( "anim_finished" );
}

clear_ignore_all_on_group( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            var_2 stop_current_animations();
            var_2 maps\_utility::set_ignoreall( 0 );
        }
    }
}

delete_ai( var_0 )
{
    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    if ( !isdefined( var_0 ) )
        var_0 = 128;

    var_1[0] = self;
    level thread maps\_utility::ai_delete_when_out_of_sight( var_1, var_0 );
}

delete_ai_on_goal()
{
    self endon( "death" );
    self waittill( "goal" );
    delete_ai();
}

delete_ai_on_flag( var_0 )
{
    common_scripts\utility::flag_wait( var_0 );
    delete_ai();
}

delete_ai_on_path_end()
{
    self endon( "death" );
    self waittill( "reached_path_end" );
    self delete();
}

clean_up_ai_single( var_0 )
{
    var_1[0] = var_0;
    clean_up_ai( var_1 );
}

clean_up_ai( var_0 )
{
    var_1 = _func_0D6();

    foreach ( var_3 in var_1 )
    {
        if ( common_scripts\utility::array_contains( var_0, var_3 ) )
            continue;

        var_3 delete_ai();
    }
}

clean_up_vehicles_all()
{
    var_0 = maps\_utility::getvehiclearray();

    foreach ( var_2 in var_0 )
        var_2 delete_veh();
}

clean_up_vehicle_type( var_0 )
{
    var_1 = maps\_utility::getvehiclearray();

    foreach ( var_3 in var_1 )
    {
        if ( var_3.vehicletype == var_0 )
            var_3 delete_veh();
    }
}

delete_veh( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 128;

    var_1[0] = self;
    level thread maps\_utility::ai_delete_when_out_of_sight( var_1, var_0 );
}

open_double_doors_by_name( var_0, var_1, var_2 )
{
    var_3 = get_ents_by_targetname( var_0 + "_right" );
    var_4 = get_ents_by_targetname( var_0 + "_left" );
    level thread open_door( var_3, var_1, var_2 );
    level thread open_door( var_4, var_1, var_2 * -1 );
}

open_double_hatch_by_name( var_0, var_1, var_2 )
{
    var_3 = get_ents_by_targetname( var_0 + "_right" );
    var_4 = get_ents_by_targetname( var_0 + "_left" );
    level thread open_door( var_3, var_1, var_2 );
    level thread open_door( var_4, var_1, var_2 );
}

open_single_door_by_name( var_0, var_1, var_2 )
{
    var_3 = get_ents_by_targetname( var_0 );
    level thread open_door( var_3, var_1, var_2 );
}

open_door( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( var_4.classname == "script_brushmodel" )
            var_4 _meth_8058();

        var_4 _meth_82B7( var_2, var_1, var_1 / 5, var_1 / 5 );
    }

    wait(var_1);

    foreach ( var_4 in var_0 )
    {
        if ( var_4.classname == "script_brushmodel" )
            var_4 _meth_8057();
    }
}

open_double_sliding_doors_toggle( var_0, var_1 )
{
    var_2 = get_ents_by_targetname( var_0 + "_right" );
    var_3 = get_ents_by_targetname( var_0 + "_left" );
    level thread open_sliding_door_toggle( var_2, var_0, var_1 );
    level thread open_sliding_door_toggle( var_3, var_0, var_1 );
}

open_sliding_door_toggle( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_0 )
    {
        var_6 = get_ent_by_targetname( var_5.targetname + "_goal" );
        var_7 = get_ent_by_targetname( var_5.targetname + "_default_org" );
        var_5.col = get_ent_by_targetname( var_5.target );
        var_5.col _meth_804D( var_5 );

        if ( isdefined( var_5.col ) && var_5.col.classname == "script_brushmodel" )
            var_5.col _meth_8058();

        if ( isdefined( var_3 ) )
        {
            var_8 = var_3 * ( var_6.origin - var_7.origin ) + var_7.origin;
            soundscripts\_snd::snd_message( "bet_conf_door_opens", var_5 );
            var_5 _meth_82AE( var_8, var_2, var_2 / 2, var_2 / 2 );
            wait(var_2);
            var_5.col _meth_8057();
            continue;
        }

        if ( var_5.origin == var_6.origin )
        {
            var_5 _meth_82AE( var_7.origin, var_2, var_2 / 2, var_2 / 2 );
            wait(var_2);
            var_5.col _meth_8057();

            if ( var_5.classname == "script_brushmodel" )
                var_5 _meth_8057();

            continue;
        }

        if ( var_5.origin == var_7.origin )
        {
            var_5 _meth_82AE( var_6.origin, var_2, var_2 / 2, var_2 / 2 );
            wait(var_2);
            var_5.col _meth_8058();

            if ( var_5.classname == "script_brushmodel" )
                var_5 _meth_8058();

            continue;
        }

        var_5 _meth_82AE( var_6.origin, var_2, var_2 / 2, var_2 / 2 );
        wait(var_2);
        var_5.col _meth_8058();

        if ( var_5.classname == "script_brushmodel" )
            var_5 _meth_8058();
    }
}

prepare_blast_doors( var_0, var_1 )
{
    var_2 = get_ents_by_targetname( var_0 );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.prepared ) && var_4.prepared )
            continue;

        var_4.prepared = 1;
        var_4.original_org = var_4.origin;
        var_4.origin += ( 0, 0, var_1 );
        var_4.opened_org = var_4.origin;
    }
}

raise_blast_doors( var_0, var_1, var_2 )
{
    var_3 = get_ents_by_targetname( var_0 );
    var_3 = common_scripts\utility::array_sort_with_func( var_3, ::blast_door_compare );
    var_4 = 1;
    var_5 = var_3[var_3.size - 1].door_num;

    for ( var_6 = 0; var_4 <= var_5; var_4++ )
    {
        for ( var_7 = []; var_6 < var_3.size && var_3[var_6].door_num == var_4; var_6++ )
        {
            var_3[var_6].prepared = 0;
            var_3[var_6] _meth_82AE( var_3[var_6].original_org, var_1, 0, var_1 / 4 );
            var_7[var_7.size] = var_3[var_6];
        }

        wait(var_1);
    }

    if ( isdefined( var_2 ) )
        blast_doors_mr_x( var_3, var_2 );
}

blast_doors_mr_x( var_0, var_1 )
{
    var_0 = common_scripts\utility::array_randomize( var_0 );
    var_2 = 0.5;
    var_3 = 1.0;
    var_4 = [ 40, 100, 120, 70 ];
    var_5 = [ 40, 100, 120, 70 ];
    var_6 = 0;
    common_scripts\utility::flag_wait( var_1 );

    foreach ( var_8 in var_0 )
    {
        var_9 = randomfloatrange( var_2, var_3 );
        var_8 _meth_82AE( var_8.opened_org + var_4[var_6] * anglestoup( var_8.angles ), var_9, 0, var_9 / 4 );
        wait 0.1;
        var_6++;

        if ( var_6 > 3 )
            var_6 = 0;
    }

    var_6 = 0;
    wait 0.2;

    foreach ( var_8 in var_0 )
    {
        var_9 = randomfloatrange( var_2, var_3 );
        var_8 _meth_82AE( var_8.original_org - var_5[var_6] * anglestoup( var_8.angles ), var_9, 0, var_9 / 4 );
        wait 0.1;
        var_6++;

        if ( var_6 > 3 )
            var_6 = 0;
    }

    wait 0.2;

    foreach ( var_8 in var_0 )
    {
        var_8 _meth_82AE( var_8.opened_org, var_2, 0, var_2 / 4 );
        wait 0.1;
    }

    common_scripts\utility::flag_wait( "flag_roof_close_mrX_blast_doors" );
    wait 2;
    var_0 = common_scripts\utility::array_randomize( var_0 );

    foreach ( var_8 in var_0 )
    {
        var_9 = randomfloatrange( var_2, var_3 );
        var_8 _meth_82AE( var_8.original_org, var_9, 0, var_9 / 4 );
    }
}

blast_door_compare( var_0, var_1 )
{
    if ( !isdefined( var_0.doornum ) )
        var_0.door_num = get_blast_door_num( var_0.script_noteworthy );

    if ( !isdefined( var_1.doornum ) )
        var_1.door_num = get_blast_door_num( var_1.script_noteworthy );

    return var_0.door_num < var_1.door_num;
}

get_blast_door_num( var_0 )
{
    var_1 = strtok( var_0, "_" );

    foreach ( var_3 in var_1 )
    {
        if ( maps\_utility::string_is_single_digit_integer( var_3 ) )
            return int( var_3 );
    }
}

ups_to_mph( var_0 )
{
    return var_0 / 63360.0 * 60.0 * 60.0;
}

mph_to_ups( var_0 )
{
    return var_0 * 63360.0 / 60.0 / 60.0;
}

vehicle_chase_target( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self notify( "one_vehicle_chase_target" );
    self endon( "one_vehicle_chase_target" );
    level endon( "stop_all_chase_vehicles" );
    self endon( "stop_chase_target" );
    self endon( "death" );
    self.oscillate_speed = 0;

    if ( var_3 >= 0 && var_4 > 0 )
        thread vehicle_oscillate_location( var_3, var_4 );

    for (;;)
    {
        var_10 = var_0 _meth_8286();
        var_11 = vectornormalize( anglestoforward( var_0.angles ) );
        var_12 = self.origin - var_0.origin;
        var_13 = vectordot( var_11, var_12 ) * var_11;
        var_14 = length( var_13 );
        var_15 = vectornormalize( var_12 );
        var_16 = vectordot( var_11, var_15 );

        if ( var_16 < 0 )
        {
            if ( var_5 )
                var_10 *= 1.5;
            else if ( var_14 < var_1 )
                var_10 *= 0.8;
            else if ( var_14 > var_2 * 1.5 )
                var_10 *= 1.35;
            else if ( var_14 > var_2 * 1.2 )
                var_10 *= 1.2;
            else if ( var_14 > var_2 )
                var_10 *= 1.1;
            else
                var_10 += self.oscillate_speed;
        }
        else if ( var_6 )
            var_10 *= 0.5;
        else if ( var_14 < var_1 )
            var_10 *= 1.2;
        else if ( var_14 > var_2 * 1.5 )
            var_10 *= 0.7;
        else if ( var_14 > var_2 * 1.2 )
            var_10 *= 0.85;
        else if ( var_14 > var_2 )
            var_10 *= 0.95;
        else
            var_10 += self.oscillate_speed;

        if ( var_7 && isdefined( level.player.drivingvehicle ) )
        {
            if ( vectordot( level.player.drivingvehicle.origin - self.origin, anglestoforward( self.angles ) ) > 0 )
            {
                [var_18, var_19] = time_and_distance_of_closest_approach( self.origin, self _meth_8287(), level.player.drivingvehicle.origin, level.player.drivingvehicle _meth_8287(), 0.1, 234, 0 );

                if ( var_18 < 2 && var_19 < 234 )
                    var_10 = level.player.drivingvehicle _meth_8286() * 0.6;
            }
        }

        if ( var_8 )
            var_10 = clamp( var_10, 0, 200 );
        else if ( isdefined( var_9 ) )
            var_10 = clamp( var_10, var_9, 200 );
        else
            var_10 = clamp( var_10, 20, 200 );

        self _meth_8283( var_10, 100, 100 );
        wait 0.05;
    }
}

vehicle_oscillate_location( var_0, var_1 )
{
    self notify( "one_vehicle_oscillate_location" );
    self endon( "one_vehicle_oscillate_location" );
    level endon( "stop_all_chase_vehicles" );
    self endon( "stop_chase_target" );
    self endon( "death" );
    var_2 = gettime();
    var_1 *= 1000;

    for (;;)
    {
        var_3 = gettime() - var_2;
        var_4 = var_3 % var_1;
        var_4 /= var_1;
        var_4 *= 365;
        var_5 = var_0 * sin( var_4 );
        self.oscillate_speed = var_5;
        wait 0.05;
    }
}

time_and_distance_of_closest_approach( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_4 ) )
        var_4 = 0.05;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_7 = var_0 - var_2;
    var_8 = var_1 - var_3;
    var_9 = lengthsquared( var_8 );
    var_10 = 2 * vectordot( var_7, var_8 );
    var_11 = lengthsquared( var_7 ) - squared( var_5 );
    var_12 = squared( var_10 ) - 4 * var_9 * var_11;
    var_13 = 0;

    if ( var_12 > 0 && var_9 > 0 )
    {
        var_14 = -0.5 * ( var_10 + common_scripts\utility::sign( var_10 ) * sqrt( var_12 ) );
        var_15 = min( var_14 / var_9, var_11 / var_14 );
    }
    else if ( var_9 > 0 )
        var_15 = var_10 / -2 * var_9;
    else
        var_15 = var_4;

    if ( var_15 < var_4 )
        var_15 = var_4;

    var_16 = distance( var_0 + var_1 * var_15, var_2 + var_3 * var_15 );
    return [ var_15, var_16 ];
}

get_ent_by_targetname( var_0 )
{
    return getent( var_0, "targetname" );
}

get_ents_by_targetname( var_0 )
{
    return getentarray( var_0, "targetname" );
}

get_ent_by_target( var_0 )
{
    return getent( var_0, "target" );
}

get_ents_by_target( var_0 )
{
    return getentarray( var_0, "target" );
}

get_ents_by_noteworthy( var_0 )
{
    return getentarray( var_0, "script_noteworthy" );
}

get_vehnode_by_targetname( var_0 )
{
    return getvehiclenode( var_0, "targetname" );
}

get_vehnodes_by_targetname( var_0 )
{
    return getvehiclenodearray( var_0, "targetname" );
}

wait_for_trigger_and_ai_single( var_0, var_1 )
{
    var_2[0] = var_1;
    wait_for_trigger_with_group_touching( var_0, 1, var_2 );
}

wait_for_trigger_just_ai_single( var_0, var_1 )
{
    var_2[0] = var_1;
    wait_for_trigger_with_group_touching( var_0, 0, var_2 );
}

wait_for_trigger_and_ai_group( var_0, var_1 )
{
    wait_for_trigger_with_group_touching( var_0, 1, var_1 );
}

wait_for_trigger_just_ai_group( var_0, var_1 )
{
    wait_for_trigger_with_group_touching( var_0, 0, var_1 );
}

wait_for_trigger_with_group_touching( var_0, var_1, var_2 )
{
    var_3 = get_ent_by_targetname( var_0 );

    for (;;)
    {
        if ( var_1 )
            var_3 waittill( "trigger" );

        var_4 = 1;

        foreach ( var_6 in var_2 )
        {
            if ( !var_6 _meth_80A9( var_3 ) )
                var_4 = 0;
        }

        if ( var_4 )
            break;

        wait 0.05;
    }
}

wait_for_no_trigger_and_ai_single( var_0, var_1 )
{
    var_2[0] = var_1;
    wait_for_trigger_with_group_not_touching( var_0, 1, var_2 );
}

wait_for_no_trigger_just_ai_single( var_0, var_1 )
{
    var_2[0] = var_1;
    wait_for_trigger_with_group_not_touching( var_0, 0, var_2 );
}

wait_for_no_trigger_and_ai_group( var_0, var_1 )
{
    wait_for_trigger_with_group_not_touching( var_0, 1, var_1 );
}

wait_for_no_trigger_just_ai_group( var_0, var_1 )
{
    wait_for_trigger_with_group_not_touching( var_0, 0, var_1 );
}

wait_for_trigger_with_group_not_touching( var_0, var_1, var_2 )
{
    var_3 = get_ent_by_targetname( var_0 );

    for (;;)
    {
        var_4 = 1;

        if ( var_1 && level.player _meth_80A9( var_3 ) )
            var_4 = 0;

        foreach ( var_6 in var_2 )
        {
            if ( var_6 _meth_80A9( var_3 ) )
                var_4 = 0;
        }

        if ( var_4 )
            break;

        wait 0.05;
    }
}

drone_swarm_move_change_path_on_trigger( var_0 )
{
    self waittill( "trigger" );

    if ( isdefined( self.script_wait ) )
        wait(self.script_wait);

    var_1 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_2 = var_1.script_noteworthy;
    var_3 = 3.0;

    if ( isdefined( var_1.script_delay ) )
        var_3 = var_1.script_delay;

    if ( !isdefined( var_0 ) || var_0 == 0 )
        level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_teleport_to_point( var_1 );

    level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points( var_2, undefined, var_3 );
}

drone_swarm_start_kamikaze_attack( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( var_4 ) )
        level.override_min_wave_delay = 7.0;
    else
        level.override_min_wave_delay = var_4;

    if ( !isdefined( var_5 ) )
        level.override_max_wave_delay = 10.0;
    else
        level.override_max_wave_delay = var_5;

    if ( !isdefined( var_6 ) )
        level.override_max_wave_spawns = 2;
    else
        level.override_max_wave_spawns = var_6;

    if ( !isdefined( var_7 ) )
        level.override_kamikaze_range = 512;
    else
        level.override_kamikaze_range = var_7;

    if ( isdefined( var_1 ) )
        level waittill( var_1 );

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    level endon( "drone_swarm_stop_kamikaze_attack" );

    for (;;)
    {
        level.snake_cloud.snakes = maps\_shg_design_tools::sortbydistanceauto( level.snake_cloud.snakes, level.player.origin );
        var_8 = randomint( level.override_max_wave_spawns );
        var_9 = 0;

        for ( var_10 = 0; var_9 < var_8 && var_10 < level.snake_cloud.snakes.size; var_10++ )
        {
            if ( level.player player_can_see_point( level.snake_cloud.snakes[var_10].origin ) )
                continue;

            if ( level.snake_cloud.snakes[var_10] drone_swarm_kamikaze_attack_player( var_0, var_3 ) )
                var_9++;

            wait(randomfloatrange( 0.1, 0.25 ));
        }

        if ( isdefined( var_3 ) )
        {
            foreach ( var_12 in var_3 )
                var_12.claimed = undefined;
        }

        wait(randomfloatrange( level.override_min_wave_delay, level.override_max_wave_delay ));
    }
}

drone_swarm_kamikaze_set_attack_vars( var_0, var_1, var_2, var_3 )
{
    waittillframeend;

    if ( isdefined( var_0 ) )
        level.override_min_wave_delay = var_0;

    if ( isdefined( var_1 ) )
        level.override_max_wave_delay = var_1;

    if ( isdefined( var_2 ) )
        level.override_max_wave_spawns = var_2;

    if ( isdefined( var_3 ) )
        level.override_kamikaze_range = var_3;
}

drone_swarm_kamikaze_attack_player( var_0, var_1 )
{
    var_2 = level.player _meth_80A8();
    var_3 = self gettagorigin( "tag_origin" );

    if ( !isdefined( level.swarm_last_player_pos ) )
        level.swarm_last_player_pos = var_2;

    if ( sighttracepassed( var_3, var_2, 0, self ) )
    {
        level.swarm_last_player_pos = var_2;
        var_0.count = 1;
        var_4 = var_0 maps\_utility::spawn_vehicle();

        if ( !isdefined( var_4 ) || !var_4 maps\_vehicle::isvehicle() )
            return 0;

        var_4 _meth_827C( self.origin, self.angles );
        var_4 _meth_8283( 20, 20, 20 );
        var_5 = undefined;

        if ( isdefined( var_1 ) )
        {
            foreach ( var_7 in var_1 )
            {
                if ( !isdefined( var_7.claimed ) && distance( var_7.origin, level.player.origin ) < level.override_kamikaze_range )
                {
                    var_7.claimed = 1;
                    var_5 = var_7;
                    break;
                }
            }
        }

        var_4 thread drone_swarm_kamikaze_seek_player( var_5 );
        return 1;
    }

    return 0;
}

drone_swarm_kamikaze_seek_player( var_0 )
{
    self endon( "death" );
    var_1 = undefined;

    for (;;)
    {
        if ( isdefined( var_0 ) )
            var_1 = var_0.origin;
        else
        {
            var_2 = anglestoforward( level.player getangles() );
            var_3 = level.player _meth_80A8() + 30 * var_2;
            var_4 = self gettagorigin( "tag_origin" );
            var_5 = vectornormalize( var_3 - var_4 );
            var_6 = var_4 + var_5 * 20;
            var_1 = level.swarm_last_player_pos;

            if ( sighttracepassed( var_6, var_3, 0, undefined ) )
                var_1 = var_3;
        }

        drone_swarm_kamikaze_set_goal( var_1 );

        if ( distance( self.origin, var_1 ) < 45 )
            thread drone_swarm_kamikaze_explode();

        wait 0.05;
    }
}

drone_swarm_kamikaze_set_goal( var_0 )
{
    if ( !isdefined( self ) )
        return;

    if ( !maps\_vehicle::isvehicle() )
        return;

    self _meth_825B( var_0 );
}

drone_swarm_kamikaze_explode()
{
    var_0 = 15;
    var_1 = 10;
    var_2 = self.origin;
    var_3 = self.angles;

    if ( randomint( 100 ) < 5 )
        playfx( common_scripts\utility::getfx( "drone_sparks" ), var_2 );

    self entityradiusdamage( var_2, 130, var_0, var_1, self );
    earthquake( randomfloatrange( 0.25, 1 ), 0.5, level.player.origin, 32 );
    var_4 = spawn( "script_model", var_2 );
    var_4 _meth_80B1( "vehicle_mil_attack_drone_destroy" );
    var_4.angles = var_3;
    playfxontag( level._effect["swarm_death_explosion"], self, "tag_origin" );
    soundscripts\_snd::snd_message( "pdrone_death_explode" );
    self _meth_8052();
    waitframe();
    var_5 = var_4.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) - level.player _meth_80A8();
    var_6 = randomintrange( 50, 80 );
    var_4 _meth_8276( var_4.origin + ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), randomintrange( -15, 15 ) ), var_5 * var_6 );

    if ( randomint( 100 ) < 5 )
        playfxontag( common_scripts\utility::getfx( "drone_smoke" ), var_4, "tag_origin" );

    wait 15;
    var_4 delete();
}

start_fire_suppression_group( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );
    level thread maps\betrayal_fx::escape_sprinklers_off();
}

warbird_toggle_turret_off_after_deploy()
{
    self endon( "death" );
    self waittill( "unloaded" );
    maps\_utility::ent_flag_clear( "fire_turrets" );
}

warbird_shooting_think( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    self endon( "death" );
    self.mgturret[0] _meth_8065( "manual" );
    self.mgturret[1] _meth_8065( "manual" );

    if ( !maps\_utility::ent_flag_exist( "fire_turrets" ) )
        maps\_utility::ent_flag_init( "fire_turrets" );

    if ( isdefined( var_1 ) && var_1 == 1 )
        maps\_utility::ent_flag_set( "fire_turrets" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "fire_turrets" );
        thread warbird_fire_init( var_0, var_2 );
        maps\_utility::ent_flag_waitopen( "fire_turrets" );
    }
}

warbird_fire_init( var_0, var_1 )
{
    self endon( "death" );
    var_2 = self.mgturret[0];
    var_3 = self.mgturret[1];

    if ( isdefined( var_1 ) )
        var_4 = var_1;
    else
        var_4 = 3;

    while ( maps\_utility::ent_flag( "fire_turrets" ) )
    {
        if ( isdefined( self.sight_check ) )
            var_0 = self.sight_check;

        if ( !isdefined( self.turret_target_override ) )
        {
            var_5 = _func_0D6( "allies" );

            if ( !maps\_utility::ent_flag_exist( "dont_shoot_player" ) || !maps\_utility::ent_flag( "dont_shoot_player" ) )
            {
                var_6 = 33;

                if ( randomint( 100 ) <= var_6 )
                    var_5 = common_scripts\utility::array_add( var_5, level.player );
            }

            var_7 = [];

            foreach ( var_9 in var_5 )
            {
                if ( isdefined( var_9.ignoreme ) && var_9.ignoreme )
                    continue;
                else
                    var_7[var_7.size] = var_9;
            }

            var_7 = sortbydistance( var_7, self.origin );
            var_11 = undefined;

            foreach ( var_9 in var_7 )
            {
                if ( !isdefined( var_9 ) )
                    continue;

                if ( !isalive( var_9 ) )
                    continue;

                if ( isdefined( var_0 ) && var_0 )
                {
                    var_13 = self.mgturret[0] gettagorigin( "tag_flash" );
                    var_14 = var_9 _meth_80A8();
                    var_15 = vectornormalize( var_14 - var_13 );
                    var_16 = var_14 + var_15 * 20;

                    if ( !sighttracepassed( var_16, var_14, 0, var_9, self.mgturret[0] ) )
                        continue;
                }

                var_11 = var_9;
                break;
            }
        }
        else
            var_11 = self.turret_target_override;

        if ( isdefined( var_11 ) )
        {
            var_2 _meth_8106( var_11 );
            var_3 _meth_8106( var_11 );
            var_2 _meth_8179();
            var_3 _meth_8179();
            var_2 _meth_80E2();
            var_3 _meth_80E2();
            warbird_wait_for_fire_target_done( var_11, var_0 );
            var_2 _meth_8108();
            var_3 _meth_8108();
            var_2 _meth_815C();
            var_3 _meth_815C();
        }

        wait(var_4);
    }

    var_2 _meth_815C();
    var_3 _meth_815C();
}

warbird_wait_for_fire_target_done( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !maps\_utility::ent_flag( "fire_turrets" ) )
        return;

    self endon( "fire_turrets" );

    if ( var_0 == level.player )
        var_2 = 0.6;
    else
        var_2 = 3;

    var_3 = 0;

    while ( var_3 < var_2 )
    {
        if ( isdefined( var_1 ) && var_1 )
        {
            var_4 = self.mgturret[0] gettagorigin( "tag_flash" );
            var_5 = var_0 _meth_80A8();
            var_6 = vectornormalize( var_5 - var_4 );
            var_7 = var_4 + var_6 * 20;

            if ( !sighttracepassed( var_7, var_5, 0, var_0, self.mgturret[0] ) )
                return;
        }

        var_3 += 0.3;
        wait 0.3;
    }
}

warbird_get_passengers()
{
    var_0 = self.riders;
    return var_0;
}

warbird_ignore_until_unloaded()
{
    foreach ( var_1 in self )
    {
        var_1.ignoreme = 1;
        var_1 thread warbird_wait_until_unloaded();
    }
}

warbird_wait_until_unloaded()
{
    self endon( "death" );
    self waittill( "jumpedout" );
    self.ignoreme = 0;
    self notify( "take_cover" );
}

warbird_unload_listener()
{
    var_0 = self.riders;
    self waittill( "finish" );

    foreach ( var_2 in var_0 )
        var_2 notify( "zipline_finish" );
}

ally_redirect_goto_node( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = undefined;

    foreach ( var_10 in level.alpha_squad )
    {
        if ( isdefined( var_10.script_friendname ) && var_10.script_friendname == var_0 )
            var_8 = var_10;
    }

    var_12 = getnode( var_1, "targetname" );
    var_8 maps\_utility::enable_ai_color();
    var_8 maps\_utility::set_goal_node( var_12 );

    if ( isdefined( var_3 ) )
        var_8 thread exec_function( var_2, var_3, var_4, var_5, var_6, var_7 );
}

exec_function( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 0;

    if ( isdefined( var_5 ) )
        var_6 = 4;
    else if ( isdefined( var_4 ) )
        var_6 = 3;
    else if ( isdefined( var_3 ) )
        var_6 = 2;
    else if ( isdefined( var_2 ) )
        var_6 = 1;

    if ( var_0 == 1 )
    {
        switch ( var_6 )
        {
            case 0:
                thread [[ var_1 ]]();
                break;
            case 1:
                thread [[ var_1 ]]( var_2 );
                break;
            case 2:
                thread [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                thread [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                thread [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
    else
    {
        switch ( var_6 )
        {
            case 0:
                [[ var_1 ]]();
                break;
            case 1:
                [[ var_1 ]]( var_2 );
                break;
            case 2:
                [[ var_1 ]]( var_2, var_3 );
                break;
            case 3:
                [[ var_1 ]]( var_2, var_3, var_4 );
                break;
            case 4:
                [[ var_1 ]]( var_2, var_3, var_4, var_5 );
                break;
        }
    }
}

assign_goal_vol( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        var_2 = getent( var_0, "targetname" );
        self _meth_81A9( var_2 );

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

assign_goal_node( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        var_2 = getnode( var_0, "targetname" );
        self _meth_81A5( var_2 );

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

setupenemygoalvolumesettings( var_0, var_1 )
{
    var_0 = common_scripts\utility::array_randomize( var_0 );

    if ( level.player _meth_80A9( var_0[0] ) )
    {
        self _meth_81A9( var_0[1] );
        waitframe();

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
    else
    {
        self _meth_81A9( var_0[0] );
        waitframe();

        if ( isdefined( var_1 ) )
            self.goalradius = var_1;
    }
}

ally_move_dynamic_speed()
{
    self notify( "start_dynamic_run_speed" );
    self endon( "death" );
    self endon( "stop_dynamic_run_speed" );
    self endon( "start_dynamic_run_speed" );

    if ( maps\_utility::ent_flag_exist( "_stealth_custom_anim" ) )
        maps\_utility::ent_flag_waitopen( "_stealth_custom_anim" );

    self.run_speed_state = "";
    ally_reset_dynamic_speed();
    var_0 = 144;
    var_1 = [ "sprint", "run" ];
    var_2 = [];
    var_2["player_sprint"]["sprint"][0] = 225 * var_0;
    var_2["player_sprint"]["sprint"][1] = 900 * var_0;
    var_2["player_sprint"]["run"][0] = 900 * var_0;
    var_2["player_sprint"]["run"][1] = 900 * var_0;
    var_2["player_run"]["sprint"][0] = 225 * var_0;
    var_2["player_run"]["sprint"][1] = 400 * var_0;
    var_2["player_run"]["run"][0] = 400 * var_0;
    var_2["player_run"]["run"][1] = 625 * var_0;
    var_2["player_crouch"]["run"][0] = 4 * var_0;
    var_2["player_crouch"]["run"][1] = 100 * var_0;
    var_3 = 123;
    var_4 = 189;
    var_5 = 283;

    for (;;)
    {
        wait 0.2;

        if ( isdefined( self.force_run_speed_state ) )
        {
            ally_dynamic_run_set( self.force_run_speed_state );
            continue;
        }

        var_6 = vectornormalize( anglestoforward( self.angles ) );
        var_7 = vectornormalize( self.origin - level.player.origin );
        var_8 = vectordot( var_6, var_7 );
        var_9 = distancesquared( self.origin, level.player.origin );

        if ( isdefined( self.cqbwalking ) && self.cqbwalking )
            self.moveplaybackrate = 1;

        if ( common_scripts\utility::flag_exist( "_stealth_spotted" ) && common_scripts\utility::flag( "_stealth_spotted" ) )
        {
            ally_dynamic_run_set( "run" );
            continue;
        }

        if ( var_8 < -0.25 && var_9 > 225 * var_0 )
        {
            ally_dynamic_run_set( "sprint" );
            continue;
        }

        ally_dynamic_run_set( "cqb" );
    }
}

ally_stop_dynamic_speed()
{
    self endon( "death" );
    self notify( "stop_dynamic_run_speed" );
    ally_reset_dynamic_speed();
}

ally_reset_dynamic_speed()
{
    self endon( "death" );
    maps\_utility::disable_cqbwalk();
    self.moveplaybackrate = 1;
    maps\_utility::clear_run_anim();
    self notify( "stop_loop" );
}

ally_dynamic_run_set( var_0 )
{
    if ( self.run_speed_state == var_0 )
        return;

    self.run_speed_state = var_0;

    switch ( var_0 )
    {
        case "sprint":
            if ( isdefined( self.cqbwalking ) && self.cqbwalking )
                self.moveplaybackrate = 1;
            else
                self.moveplaybackrate = 1;

            maps\_utility::set_generic_run_anim( "DRS_sprint" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "run":
            self.moveplaybackrate = 1;
            maps\_utility::clear_run_anim();
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "jog":
            self.moveplaybackrate = 1;
            maps\_utility::set_generic_run_anim( "DRS_combat_jog" );
            maps\_utility::disable_cqbwalk();
            self notify( "stop_loop" );
            break;
        case "cqb":
            self.moveplaybackrate = 1;
            maps\_utility::enable_cqbwalk();
            self notify( "stop_loop" );
            break;
    }
}

fake_linkto_internal( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_0 endon( "death" );
    self notify( "fake_unlink" );
    self endon( "fake_unlink" );

    if ( !isdefined( var_2 ) || !isdefined( var_3 ) )
    {
        if ( isdefined( var_1 ) )
        {
            var_4 = var_0 gettagorigin( var_1 );
            var_5 = var_0 gettagangles( var_1 );
        }
        else
        {
            var_4 = var_0.origin;
            var_5 = var_0.angles;
        }

        var_6 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_4, var_5, self.origin, self.angles );
        var_2 = var_6["origin"];
        var_3 = var_6["angles"];
    }

    for (;;)
    {
        if ( isdefined( var_1 ) )
        {
            var_4 = var_0 gettagorigin( var_1 );
            var_5 = var_0 gettagangles( var_1 );
        }
        else
        {
            var_4 = var_0.origin;
            var_5 = var_0.angles;
        }

        var_6 = transformmove( var_4, var_5, ( 0, 0, 0 ), ( 0, 0, 0 ), var_2, var_3 );
        self.origin = var_6["origin"];
        self.angles = var_6["angles"];
        waitframe();
    }
}

fake_unlink()
{
    self notify( "fake_unlink" );
}

civilian_setup( var_0, var_1, var_2 )
{
    self waittill( "trigger" );
    var_3 = getent( self.script_linkto, "script_linkname" );
    var_4 = getentarray( self.target, "targetname" );
    var_5 = [];
    var_6 = [];
    var_7 = [];

    foreach ( var_9 in var_4 )
    {
        if ( isdefined( var_9.script_noteworthy ) && var_9.script_noteworthy == "ai_spawner" )
        {
            var_5 = common_scripts\utility::getstructarray( var_9.target, "targetname" );

            foreach ( var_11 in var_5 )
            {
                var_12 = var_11 civilian_spawn_single( var_9, "ai", var_1 );
                var_9.count = 1;
                var_7 = common_scripts\utility::array_add( var_7, var_12 );
                waitframe();
                var_12 thread civilian_actor_behavior_manager( var_0, 1, var_11 );
            }

            continue;
        }

        var_5 = common_scripts\utility::getstructarray( var_9.target, "targetname" );

        foreach ( var_11 in var_5 )
        {
            var_12 = var_11 civilian_spawn_single( var_9, "drone", var_1 );
            var_12 thread civilian_actor_behavior_manager( var_0, 0 );
            var_6 = common_scripts\utility::array_add( var_6, var_12 );
        }
    }

    if ( !isdefined( var_2 ) || var_2 )
        civilian_setup_esc_nodes( var_7 );

    var_3 waittill( "trigger" );

    foreach ( var_18 in var_7 )
        civilian_cleanup( var_18 );

    foreach ( var_18 in var_6 )
        civilian_cleanup( var_18 );
}

civilian_spawn_single( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = undefined;
    var_0.target = self.target;
    var_0.script_moveoverride = 1;

    if ( var_1 == "ai" )
    {
        var_3 = var_0 maps\_utility::spawn_ai( 1 );
        var_0.count = 1;
        var_3.ignoreme = 1;
        var_3.ignoreall = 1;
        var_3 maps\_utility::disable_pain();
        var_3 _meth_81C6( self.origin, self.angles );
    }
    else
    {
        var_3 = var_0 maps\_utility::dronespawn();
        var_3.origin = self.origin;
        var_3.angles = self.angles;
    }

    var_0.script_moveoverride = undefined;
    var_3 civilian_detach_props();
    var_3.script_parameters = self.script_parameters;
    var_3.script_linkto = self.script_linkto;
    var_3.animation = self.animation;
    var_3.script_noteworthy = self.script_noteworthy;
    var_3.script_nodestate = self.script_nodestate;
    var_3.script_squadname = self.script_squadname;
    var_3.health = 20;

    if ( isdefined( self.civilian_walk_animation ) )
        var_3.civilian_walk_animation = self.civilian_walk_animation;

    if ( isdefined( var_2 ) && var_2 )
        var_3.no_friendly_fire_penalty = 1;

    return var_3;
}

civilian_init_props()
{
    if ( isdefined( anim.civilianprops ) )
        return;

    anim.civilianprops = [];
    anim.civilianprops["civilian_texting_standing"] = "electronics_pda";
    anim.civilianprops["civilian_texting_sitting"] = "electronics_pda";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_smoking_A"] = "prop_cigarette";
    anim.civilianprops["civilian_smoking_B"] = "prop_cigarette";
    anim.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
    anim.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
    anim.civilianprops["guardB_sit_drinker_idle"] = "cs_coffeemug02";
    anim.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
    anim.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
    anim.civilianprops["civilian_briefcase_walk"] = "com_metal_briefcase";
    anim.civilianprops["civilian_crazy_walk"] = "electronics_pda";
    anim.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
    anim.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
    anim.civilianprops["civilian_paper_walk"] = "paper_memo";
    anim.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
    anim.civilianprops["civilian_pda_walk"] = "electronics_pda";
    anim.civilianprops["civilian_crowd_walk_stand_idle"] = "electronics_pda";
    anim.civilianprops["civilian_crowd_walk_stand"] = "electronics_pda";
    anim.civilianprops["civilian_walk_nervous"] = "electronics_pda";
    anim.civilianprops["civilian_walk_pda"] = "electronics_pda";
}

civilian_attach_props( var_0 )
{
    if ( isdefined( self.hasattachedprops ) )
        return;

    civilian_init_props();
    var_1 = anim.civilianprops[var_0];

    if ( isdefined( var_1 ) )
    {
        self.attachedpropmodel = var_1;
        self.attachedproptag = "tag_inhand";

        if ( issubstr( self.attachedpropmodel, "electronics_pda" ) )
            wait 0.25;

        var_2 = self attach( self.attachedpropmodel, self.attachedproptag, 1 );
        self.hasattachedprops = 1;
        return var_1;
    }
}

civilian_setup_esc_nodes( var_0 )
{
    if ( !isdefined( level.esc_node_locations ) )
        level.esc_node_locations = getnodearray( "ai_esc_node", "targetname" );

    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.target ) )
        {
            if ( level.esc_node_locations.size > 0 )
            {
                foreach ( var_5 in level.esc_node_locations )
                {
                    var_6 = distance( var_5.origin, self.origin );

                    if ( !isdefined( var_5 ) || var_5.targetname != "ai_esc_node" )
                        level.esc_node_locations = common_scripts\utility::array_remove( level.esc_node_locations, var_5 );
                }

                level.esc_node_locations = sortbydistance( level.esc_node_locations, var_3.origin );
                var_1 = level.esc_node_locations[0];
                level.esc_node_locations = common_scripts\utility::array_remove( level.esc_node_locations, level.esc_node_locations[0] );
                var_3 _meth_81A5( var_1 );

                if ( isdefined( var_1.target ) )
                    var_3 thread civilian_actor_ai_player_reaction( var_1 );
            }
            else
            {

            }

            continue;
        }

        var_1 = getnode( var_3.target, "targetname" );
        var_8 = undefined;

        if ( isdefined( var_1 ) && isdefined( var_1.target ) )
        {
            var_8 = getent( var_1.target, "targetname" );

            if ( isdefined( var_8 ) && isdefined( var_8.angles ) )
            {
                var_3.final_animation_angles = var_8.angles;
                var_3.final_animation_origin = var_8.origin;
            }
        }

        var_3 _meth_81A5( var_1 );
    }
}

filter_nodes( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4.targetname ) && var_4.targetname == var_1 )
            var_2 = common_scripts\utility::array_add( var_2, var_4 );
    }

    return var_2;
}

civilian_actor_behavior_manager( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    self endon( "death" );

    if ( isdefined( var_2 ) && isdefined( var_2.animation ) && issubstr( var_2.animation, "_sit_" ) )
        thread civilian_actor_play_idle( undefined, var_2 );
    else
        thread civilian_actor_play_idle();

    thread civilian_wait_for_reaction( var_0 );
    self waittill( "reacting" );

    if ( var_1 )
    {
        self _meth_81FF( level.player );
        self _meth_81FF();
    }

    thread civilian_actor_play_reaction( var_1 );
}

civilian_wait_for_reaction( var_0 )
{
    if ( isstring( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );
    else if ( isdefined( var_0 ) )
        maps\_utility::waittill_entity_in_range( level.player, var_0 );
    else
    {

    }

    waitframe();
    self notify( "reacting" );
}

civilian_watch_player_when_close()
{
    self endon( "death" );
    level.player endon( "death" );
    self endon( "reacting" );
    var_0 = 0;

    for (;;)
    {
        var_0 = distance( self.origin, level.player.origin );

        if ( var_0 <= 100 )
            self _meth_81FF( level.player );
        else
            self _meth_81B7();

        wait 0.5;
    }
}

civilian_actor_play_idle( var_0, var_1 )
{
    self notify( "new_idle_spot" );
    self endon( "new_idle_spot" );
    self endon( "death" );

    if ( isdefined( self.attachedpropmodel ) )
        civilian_detach_props();

    stop_current_animations();
    self.animname = "generic";

    if ( isdefined( var_0 ) )
        var_2 = var_0;
    else if ( isdefined( self.animation ) )
        var_2 = self.animation;
    else
        var_2 = civilian_get_random_idle();

    self.animation = var_2;

    if ( !isdefined( var_1 ) )
        thread maps\_anim::anim_generic_loop( self, var_2 );
    else
        var_1 maps\_anim::anim_generic_loop( self, var_2 );

    var_3 = civilian_attach_props( var_2 );
    self waittill( "reacting" );

    if ( isdefined( var_3 ) )
        civilian_detach_props();
}

civilian_actor_play_reaction( var_0 )
{
    self endon( "death" );
    level.player endon( "death" );
    wait(randomfloatrange( 0.0, 0.25 ));
    self.animname = "civilian_react";
    var_1 = civilian_get_random_reaction();

    if ( isdefined( self.script_noteworthy ) )
    {
        stop_current_animations();
        var_1 = self.script_noteworthy;
        maps\_anim::anim_single_solo_run( self, var_1 );
    }

    if ( isdefined( self.target ) || isdefined( self.goalpos ) )
    {
        self.goalradius = 16;
        stop_current_animations();
        self.animname = "generic";

        if ( !var_0 && isdefined( self.civilian_walk_animation ) )
            var_1 = self.civilian_walk_animation;
        else
            var_1 = civilian_get_random_run();

        self.runanim = level.scr_anim[self.animname][var_1][0];
        maps\_utility::set_run_anim_array( var_1, undefined, 1 );
        self notify( "move" );
        self waittill( "goal" );
        stop_current_animations();
        self.animname = "civilian_react";
        var_1 = civilian_get_random_reaction();
    }
    else if ( !isdefined( self.script_parameters ) )
        var_1 = civilian_get_random_reaction();

    if ( isdefined( self.script_parameters ) )
    {
        if ( isdefined( self.final_animation_angles ) && isdefined( self.final_animation_origin ) && isdefined( self.script_nodestate ) )
            self _meth_81C6( self.final_animation_origin, self.final_animation_angles );

        stop_current_animations();
        self.animname = "generic";
        var_1 = self.script_parameters;
        thread maps\_anim::anim_generic_loop( self, var_1 );
    }
    else
    {
        if ( isdefined( self.final_animation_angles ) && isdefined( self.script_nodestate ) )
            self _meth_81C6( self.origin, self.final_animation_angles );

        if ( isdefined( self.final_animation_origin ) && isdefined( self.script_nodestate ) )
            self _meth_81C6( self.final_animation_origin, self.angles );

        stop_current_animations();
        thread maps\_anim::anim_loop( [ self ], var_1 );
    }

    self notify( "done_reacting" );
}

civilian_actor_ai_player_reaction( var_0 )
{
    self endon( "death" );
    var_1 = getnode( var_0.target, "targetname" );
    var_2 = var_1.script_noteworthy;
    common_scripts\utility::flag_wait( var_2 );
    stop_current_animations();
    waitframe();
    self _meth_81A5( var_1 );
    self waittill( "goal" );
    self waittill( "done_reacting" );
    stop_current_animations();
    var_1 thread maps\_anim::anim_loop_solo( self, "civ_react_cower_crouch_to_crouch_2", "stop_loop" );
}

civilian_actor_drone_player_reaction()
{

}

civilian_get_random_reaction()
{
    self endon( "death" );
    var_0 = [];
    var_0[0] = "civ_react_cower_crouch_to_crouch";
    var_0[1] = "civ_react_crouch_idle";
    var_0[2] = "civ_react_cower_hunch_to_hunch";
    var_0[3] = "civ_react_cower_crouch_to_crouch_2";
    var_0[4] = "civ_react_cower_crouch_to_crouch_3";
    var_0[5] = "bet_civilians_cowering_idle_01";
    var_0[6] = "bet_civilians_cowering_idle_02";
    var_0[7] = "bet_civilians_cowering_idle_03";
    var_0[8] = "bet_civilians_cowering_idle_04";
    var_0[9] = "bet_civilians_cowering_idle_05";
    var_0[10] = "bet_civilians_cowering_idle_06";
    var_1 = randomintrange( 0, var_0.size );
    return var_0[var_1];
}

civilian_get_random_idle()
{
    self endon( "death" );
    var_0 = [];
    var_0[0] = "civilian_stand_idle2";
    var_0[1] = "civilian_stand_idle4";
    var_0[2] = "civilian_stand_idle5";
    var_0[3] = "civilian_stand_idle6";
    var_0[4] = "civilian_stand_idle7";
    var_0[5] = "civilian_stand_idle8";
    var_0[6] = "civilian_stand_idle9";

    if ( issubstr( self.model, "female" ) )
    {

    }
    else if ( issubstr( self.model, "male" ) )
        var_0[7] = "civilian_stand_idle_male1";

    var_1 = randomintrange( 0, var_0.size );
    return var_0[var_1];
}

civilian_get_random_run()
{
    self endon( "death" );
    var_0 = [];
    var_0[0] = "civ_run_hunch1";
    var_0[1] = "civ_run_stand1";

    if ( issubstr( self.model, "female" ) )
    {

    }
    else if ( issubstr( self.model, "male" ) )
    {
        var_0[2] = "civilian_run1_male";
        var_0[3] = "civilian_run2_male";
        var_0[4] = "civilian_run3_male";
    }

    var_1 = randomintrange( 0, var_0.size );
    return var_0[var_1];
}

civilian_get_random_walk()
{
    self endon( "death" );
    var_0 = [];
    var_0[0] = "civilian_walk_nervous";
    var_0[1] = "civilian_walk_hurried";

    if ( issubstr( self.model, "female" ) )
    {
        var_0[2] = "civilian_walk1_female";
        var_0[3] = "civilian_walk2_female";
    }
    else if ( issubstr( self.model, "male" ) )
    {
        var_0[2] = "civilian_walk1_male";
        var_0[3] = "civilian_walk2_male";
        var_0[4] = "civilian_walk3_male";
        var_0[5] = "civilian_male_walk_cool";
    }

    var_1 = randomintrange( 0, var_0.size );
    return var_0[var_1];
}

civilian_cleanup( var_0 )
{
    if ( isdefined( var_0 ) && !_func_294( var_0 ) )
        var_0 delete();
}

civilian_detach_props()
{
    if ( isdefined( self.hasattachedprops ) && isdefined( self.attachedpropmodel ) )
    {
        self detach( self.attachedpropmodel, self.attachedproptag );
        self.hasattachedprops = undefined;
        self.attachedpropmodel = undefined;
        self.attachedproptag = undefined;
    }
}

civilian_walker_setup( var_0, var_1 )
{
    level.player endon( "death" );
    self waittill( "trigger" );
    var_2 = getent( self.script_linkto, "script_linkname" );
    var_3 = getentarray( self.target, "targetname" );
    var_4 = [];
    var_5 = [];

    foreach ( var_7 in var_3 )
    {
        var_4 = common_scripts\utility::getstructarray( var_7.target, "targetname" );

        foreach ( var_9 in var_4 )
        {
            var_10 = var_9 civilian_spawn_single( var_7, "ai", var_1 );
            var_7.count = 1;
            var_10 maps\_utility::set_ignoreall( 1 );
            var_10.is_walking = 0;
            var_5 = common_scripts\utility::array_add( var_5, var_10 );

            if ( isdefined( var_10.civilian_walk_animation ) )
            {
                var_10.animname = "generic";
                var_11 = var_10.civilian_walk_animation;
                var_10.runanim = level.scr_anim[var_10.animname][var_11][0];
                var_10 maps\_utility::set_run_anim_array( var_11, undefined, 1 );
            }
            else
            {
                var_10.animname = "generic";
                var_11 = civilian_get_random_walk();
                var_10.civilian_walk_animation = var_11;
                var_10.runanim = level.scr_anim[var_10.animname][var_11][0];
                var_10 maps\_utility::set_run_anim_array( var_11, undefined, 1 );
            }

            waitframe();
            var_10 _meth_81A3( 1 );
            var_10 thread civilian_walker_behavior_manager( var_0 );
            var_10 thread civilian_walker_idle_when_blocked();
        }
    }

    var_2 waittill( "trigger" );

    foreach ( var_15 in var_5 )
        civilian_cleanup( var_15 );

    foreach ( var_15 in var_5 )
        civilian_cleanup( var_15 );
}

civilian_walker_setup_esc_nodes()
{
    level.walker_esc_node_locations = getnodesinradius( self.origin, 4096, 0, 1024, "scripted" );
    level.walker_esc_node_locations = filter_nodes( level.esc_node_locations, "ai_walker_esc_node" );
}

civilian_walker_behavior_manager( var_0 )
{
    self endon( "reacting" );
    self endon( "death" );
    level.player endon( "death" );
    thread civilian_actor_play_idle();
    thread civilian_wait_for_reaction( var_0 );
    thread civilian_walker_wait_for_walk_signal();
    self waittill( "reacting" );
    civilian_walker_play_reaction();
}

civilian_walker_wait_for_walk_signal()
{
    self endon( "death" );
    self endon( "reaction" );
    level.player endon( "death" );
    var_0 = getent( self.script_linkto, "script_linkname" );
    var_0 waittill( "trigger" );
    thread civilian_walker_play_walk();
}

civilian_walker_play_walk()
{
    self endon( "death" );
    self endon( "reacting" );
    level.player endon( "death" );
    self.goal_node = civilian_walker_update_current_goal_and_animate_to( self );
    wait(randomintrange( 5, 8 ));

    while ( isdefined( self.goal_node ) )
    {
        self.goal_node = civilian_walker_update_current_goal_and_animate_to( self.goal_node );
        wait(randomintrange( 5, 8 ));
    }
}

civilian_walker_idle_when_blocked()
{
    self endon( "death" );
    self endon( "reacting" );
    level.player endon( "death" );

    for (;;)
    {
        if ( self.is_walking && civilian_check_if_player_blocking() )
        {
            civilian_detach_props();
            thread civilian_actor_play_idle();

            while ( civilian_check_if_player_blocking() )
                wait 1.0;

            waittillframeend;

            if ( self.is_walking )
            {
                if ( isdefined( self.goal_node ) && isdefined( self.goal_node.target ) )
                {
                    var_0 = getnode( self.goal_node.target, "targetname" );
                    var_1 = distance( var_0.origin, self.origin );

                    if ( var_1 - 15 > self.goalradius )
                    {
                        stop_current_animations();
                        self notify( "move" );
                        civilian_detach_props();
                    }
                }
                else
                {
                    self notify( "move" );
                    stop_current_animations();
                    civilian_detach_props();
                }
            }
        }

        waitframe();
    }
}

civilian_check_if_player_blocking()
{
    self endon( "death" );
    self endon( "reacting" );
    level.player endon( "death" );
    var_0 = distance( level.player.origin, self.origin );

    if ( var_0 < 100 )
        return 1;
    else
        return 0;
}

civilian_walker_update_current_goal_and_animate_to( var_0 )
{
    var_1 = undefined;

    while ( civilian_check_if_player_blocking() )
        wait 1.0;

    if ( isdefined( var_0.target ) )
        var_1 = getnode( var_0.target, "targetname" );

    if ( isdefined( var_1 ) )
    {
        self _meth_81A5( var_1 );

        if ( isdefined( var_0.script_noteworthy ) )
        {
            civilian_detach_props();
            stop_current_animations();
            self.animname = "generic";
            var_2 = var_0.script_noteworthy;
            maps\_anim::anim_single_solo_run( self, var_2 );
        }

        stop_current_animations();
        self.goalradius = 16;
        civilian_detach_props();
        self notify( "move" );
        self.is_walking = 1;
        self waittill( "goal" );
        self.is_walking = 0;

        if ( isdefined( var_1.script_parameters ) )
        {
            stop_current_animations();
            var_1.animname = "generic";
            var_2 = var_1.script_parameters;
            var_1 maps\_anim::anim_single_solo( self, var_2 );
        }

        if ( isdefined( var_1.animation ) )
            thread civilian_actor_play_idle( var_1.animation );
        else
            thread civilian_actor_play_idle();

        return var_1;
    }
    else
        return undefined;
}

civilian_walker_play_reaction()
{
    self endon( "death" );
    level.player endon( "death" );
    stop_current_animations();
}

bullet_thing( var_0 )
{
    self _meth_82C0( 1 );
    var_1 = self;

    switch ( var_0 )
    {
        case "magnet":
            var_1 thread bullet_magnet_shield( self );
            break;
        case "deflector":
            var_1 thread bullet_deflector_shield( self );
            break;
        case "shield":
            var_1 thread bullet_shield_shield( self );
            break;
        default:
            break;
    }

    while ( self.health > 0 )
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( var_6 == "MOD_GRENADE_SPLASH" )
            break;
        else if ( var_3.classname == "worldspawn" )
            self.health += var_2;
    }

    self _meth_8052();
    var_1 delete();
}

bullet_magnet_shield( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self.health = 20000;
    self _meth_82C0( 1 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( var_5 == "MOD_GRENADE_SPLASH" )
            continue;

        var_11 = var_4 + anglestoforward( vectortoangles( self.origin - var_4 ) ) * 1;
        var_12 = self.origin + anglestoforward( vectortoangles( var_4 - self.origin ) ) * 30;

        if ( issubstr( var_10, "grenade" ) )
        {
            var_11 = var_4 + anglestoforward( vectortoangles( self.origin - var_4 ) ) * 10;
            var_13 = getentarray( "grenade", "classname" );

            foreach ( var_15 in var_13 )
            {
                if ( distancesquared( var_15.origin, var_4 ) < squared( 5 ) )
                    var_15 delete();
            }

            _func_070( var_10, var_11, var_12, 1 );
        }
        else
            magicbullet( var_10, var_11, self.origin );

        self.health += var_1;
    }
}

bullet_deflector_shield( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self.health = 20000;
    self _meth_82C0( 1 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( var_5 == "MOD_GRENADE_SPLASH" )
            continue;

        var_11 = var_4 + anglestoforward( vectortoangles( self.origin - var_4 ) ) * -1;
        var_12 = var_4 + anglestoforward( vectortoangles( self.origin - var_4 ) ) * -2;

        if ( issubstr( var_10, "grenade" ) )
        {
            var_13 = getentarray( "grenade", "classname" );

            foreach ( var_15 in var_13 )
            {
                if ( distancesquared( var_15.origin, var_4 ) < squared( 5 ) )
                    var_15 delete();
            }

            _func_070( var_10, var_11, var_12, 1 );
        }
        else
            magicbullet( var_10, var_11, var_12 );

        self.health += var_1;
    }
}

bullet_shield_shield( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self.health = 20000;
    self _meth_82C0( 1 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( var_5 == "MOD_GRENADE_SPLASH" )
            continue;

        playfx( common_scripts\utility::getfx( "bullet_drop" ), var_4, var_3 );
        self.health += var_1;
    }
}

drone_secure_zone( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_7 = common_scripts\utility::getstruct( var_0, "targetname" );
    thread maps\_vehicle::vehicle_paths( var_7 );

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( !isdefined( var_6 ) )
        var_6 = 0;

    if ( var_6 < var_5 )
        var_6 = var_5;

    var_8 = var_6 - var_5;

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_wait_or_timeout( var_2, var_5 );
    else
        wait(var_5);

    drone_magic_bullets( 0, var_8, var_3, var_1 );
    drone_magic_bullets( 1, undefined, var_1 );
}

drone_magic_bullets( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    common_scripts\utility::flag_clear( "flag_stop_drone_magic_bullets" );
    var_4 = 0;
    var_5 = level.player.origin;
    var_6 = self gettagorigin( "TAG_LASER" );
    var_6 -= 50 * anglestoforward( var_6 );

    if ( var_0 )
    {
        var_7 = 4;
        var_8 = 75;
        var_9 = 150;
        var_10 = "betrayal_missile_small_lethal";
    }
    else
    {
        var_7 = 8;
        var_8 = 100;
        var_9 = 250;
        var_10 = "betrayal_missile_small_harass";
    }

    if ( isdefined( var_1 ) )
        thread flag_set_on_timeout( "flag_stop_drone_magic_bullets", var_1 );

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        thread flag_set_once_either_set( "flag_stop_drone_magic_bullets", var_2, var_3 );
    else
        thread flag_set_once_this_set( "flag_stop_drone_magic_bullets", var_2 );

    while ( !common_scripts\utility::flag( "flag_stop_drone_magic_bullets" ) )
    {
        var_6 = self gettagorigin( "TAG_LASER" );
        var_11 = randomintrange( var_8, var_9 );

        if ( var_4 == 0 || var_4 == 5 )
            var_5 = level.player.origin + var_11 * anglestoright( level.player.origin );
        else if ( var_4 == 1 || var_4 == 6 )
            var_5 = level.player.origin - var_11 * anglestoright( level.player.origin );
        else if ( var_4 == 2 || var_4 == 7 )
            var_5 = level.player.origin + var_11 * anglestoforward( level.player.origin );
        else if ( var_4 == 3 || var_4 == 8 )
            var_5 = level.player.origin - var_11 * anglestoforward( level.player.origin );
        else if ( var_4 == 4 )
            var_5 = level.player.origin;

        var_12 = magicbullet( var_10, var_6, var_5 );
        var_12 thread missile_stuff();
        var_4++;

        if ( var_4 > var_7 )
            var_4 = 0;

        wait 0.1;
    }

    self notify( "stop_delay_call" );
}

missile_stuff()
{
    playfx( common_scripts\utility::getfx( "hovertank_anti_pers_muzzle_flash_vm" ), self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
    thread missile_delayed_trail();
}

missile_delayed_trail()
{
    var_0 = 0.5;
    wait(var_0);

    if ( isdefined( self ) )
    {
        playfxontag( common_scripts\utility::getfx( "hovertank_anti_pers_trail_rocket_2" ), self, "tag_origin" );
        self waittill( "death" );
    }
}

flag_set_on_timeout( var_0, var_1 )
{
    self endon( "stop_delay_call" );
    wait(var_1);
    common_scripts\utility::flag_set( var_0 );
}

flag_set_once_either_set( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait_either( var_1, var_2 );
    common_scripts\utility::flag_set( var_0 );
}

flag_set_once_this_set( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );
    common_scripts\utility::flag_set( var_0 );
}

balcony_death_anims()
{
    self.animname = "generic";
    self.deathfunction = ::try_balcony_death;
}

try_balcony_death()
{
    if ( !isdefined( self ) )
        return 0;

    if ( self.a.pose == "prone" )
        return 0;

    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "container_death" )
    {
        self.deathanim = maps\_utility::getgenericanim( "container_death" );
        return 0;
    }

    if ( isdefined( self.prevnode ) )
    {
        if ( isdefined( self.prevnode.script_balcony ) )
        {
            var_0 = self.angles[1];

            if ( var_0 > 180 )
                var_0 -= 360;

            var_1 = self.prevnode.angles[1];

            if ( var_1 > 180 )
                var_1 -= 360;

            var_2 = abs( var_0 - var_1 );

            if ( var_2 > 90 )
                return 0;

            var_3 = distance( self.origin, self.prevnode.origin );

            if ( var_3 > 92 )
                return 0;
        }
        else
            return 0;
    }
    else
        return 0;

    if ( !isdefined( level.last_balcony_death ) )
        level.last_balcony_death = -4000;

    var_4 = gettime() - level.last_balcony_death;

    if ( var_4 < 2000 )
        return 0;

    var_5 = maps\_utility::getgenericanim( "balcony_death" );
    self.deathanim = var_5[randomint( var_5.size )];
    return 0;
}

waittill_player_exo_climbing()
{
    for (;;)
    {
        if ( maps\_exo_climb::is_exo_climbing() )
            break;

        wait 0.05;
    }
}

waittill_player_not_exo_climbing()
{
    for (;;)
    {
        if ( !maps\_exo_climb::is_exo_climbing() )
            break;

        wait 0.05;
    }
}

spawn_and_handle_looping_helicopters( var_0, var_1, var_2 )
{
    var_3 = getentarray( var_0, "targetname" );
    level.looping_heli_array = [];
    level.looping_helis_currently_moving = [];

    foreach ( var_5 in var_3 )
    {
        var_6 = var_5 maps\_utility::spawn_vehicle();
        var_6 soundscripts\_snd::snd_message( "aud_ambient_helicopter", var_0 );
        var_6 childthread heli_hold_position( var_5, var_1 );
        level.looping_heli_array = common_scripts\utility::array_add( level.looping_heli_array, var_6 );
    }

    if ( level.looping_heli_array.size > 0 )
    {
        while ( !common_scripts\utility::flag( var_1 ) )
        {
            if ( level.looping_helis_currently_moving.size < var_2 )
            {
                var_8 = 0;

                for (;;)
                {
                    var_9 = 1;
                    var_8 = randomintrange( 0, level.looping_heli_array.size );

                    if ( !common_scripts\utility::array_contains( level.looping_helis_currently_moving, level.looping_heli_array[var_8] ) )
                        break;

                    wait 0.05;
                }

                level.looping_helis_currently_moving = common_scripts\utility::array_add( level.looping_helis_currently_moving, level.looping_heli_array[var_8] );
                level.looping_heli_array[var_8] childthread send_heli_through_path( level.looping_helis_currently_moving.size - 1 );
            }

            wait 1;
        }

        common_scripts\utility::flag_wait( var_1 );

        foreach ( var_11 in level.looping_heli_array )
        {
            if ( isdefined( var_11 ) )
                var_11 thread heli_delete_on_pathend();
        }
    }
}

heli_hold_position( var_0, var_1 )
{
    for (;;)
    {
        if ( !common_scripts\utility::array_contains( level.looping_helis_currently_moving, self ) )
            self _meth_827C( var_0.origin, var_0.angles, 0 );

        wait 5;

        if ( common_scripts\utility::flag( var_1 ) )
            break;
    }
}

send_heli_through_path( var_0 )
{
    self endon( "death" );
    var_1 = self.origin;
    var_2 = self.angles;
    var_3 = common_scripts\utility::getstruct( self.target, "targetname" );
    thread maps\_vehicle_code::_vehicle_paths( var_3 );
    self waittill( "reached_dynamic_path_end" );
    waitframe();

    if ( isdefined( self ) )
    {
        self _meth_827C( var_1, var_2, 0 );
        level.looping_helis_currently_moving = common_scripts\utility::array_remove( level.looping_helis_currently_moving, self );
    }
}

heli_delete_on_pathend()
{
    common_scripts\utility::waittill_notify_or_timeout_return( "reached_dynamic_path_end", 30 );
    level.looping_heli_array = common_scripts\utility::array_remove( level.looping_heli_array, self );
    self delete();
}

start_player_diveboat_ride()
{
    level.player_boat _meth_8099( level.player );
    level.player_boat vehicle_scripts\_diveboat::do_diveboat_threads();
    level.player_boat _meth_840F( 1 );
    level.player.drivingvehicle = level.player_boat;
}

scripted_spin_fan_blades( var_0, var_1 )
{
    level endon( var_1 );
    var_2 = max( randomfloatrange( 0.1, 2.0 ) / 4.0, 0.05 ) * var_0;
    var_3 = self.angles[1];

    for (;;)
    {
        while ( var_3 > 36000.0 )
        {
            var_3 -= 36000.0;
            self.angles = ( self.angles[0], var_3, self.angles[2] );
        }

        var_3 += 90;
        self _meth_82B7( 90, var_2, 0, 0 );
        wait(var_2);
    }
}

progress_path_create( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_2 = [];
    var_3 = 0;
    var_4 = var_1;

    for (;;)
    {
        var_5 = var_1;

        if ( isdefined( var_1.target ) )
            var_5 = common_scripts\utility::getstruct( var_1.target, "targetname" );

        var_2[var_2.size] = var_1;
        var_1.next_node = var_5;
        var_1.prev_node = var_4;
        var_1.dist_to_next_node = distance( var_1.origin, var_1.next_node.origin );
        var_1.index = var_3;
        var_3++;

        if ( var_1 == var_5 )
            break;

        var_4 = var_1;
        var_1 = var_5;
    }

    return var_2;
}

progress_path_get_my_node_from_org( var_0 )
{
    var_0 = ( var_0[0], var_0[1], 0 );
    var_1 = common_scripts\utility::get_array_of_closest( var_0, self, undefined, 3 );
    var_2 = var_1[0];
    var_3 = var_2.index;

    if ( var_1[1].index < var_3 )
    {
        var_2 = var_1[1];
        var_3 = var_2.index;
    }

    if ( var_1[2].index < var_3 )
        var_2 = var_1[2];

    return var_2;
}

progress_path_move_to_correct_node( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();

    for (;;)
    {
        var_4 = var_0.dist_to_next_node;

        if ( var_1 > var_4 )
        {
            if ( var_0 == var_0.next_node )
                break;

            var_5 = get_position_from_spline( var_0, var_4, var_2 );
            var_1 -= var_4;
            var_0 = var_0.next_node;
            var_6 = get_progression_between_points( var_5, var_0.origin, var_0.next_node.origin );
            var_2 = var_6["offset"];
            continue;
        }

        if ( var_1 < 0 )
        {
            if ( var_0 == var_0.prev_node )
                break;

            var_5 = get_position_from_spline( var_0, 0, var_2 );
            var_0 = var_0.prev_node;
            var_6 = get_progression_between_points( var_5, var_0.origin, var_0.next_node.origin );
            var_1 += var_6["progress"];
            var_2 = var_6["offset"];
            continue;
        }

        break;
    }

    var_3.node = var_0;
    var_3.progress = var_1;
    var_3.offset = var_2;
    return var_3;
}

get_progression_between_points( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = vectornormalize( var_2 - var_1 );
    var_5 = var_0 - var_1;
    var_6 = vectordot( var_5, var_4 );
    var_7 = var_1 + var_4 * var_6;
    var_3["progress"] = var_6;
    var_3["offset"] = distance2d( var_7, var_0 );
    var_8 = anglestoright( vectortoangles( var_4 ) );
    var_9 = vectornormalize( var_7 - var_0 );
    var_10 = vectordot( var_8, var_9 );
    var_3["side"] = "right";

    if ( var_10 > 0 )
    {
        var_3["offset"] *= -1;
        var_3["side"] = "left";
    }

    return var_3;
}

get_position_from_spline( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = vectortoangles( var_0.next_node.origin - var_0.origin );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoright( var_4 );
    return var_0.origin + var_5 * var_1 + var_6 * var_2;
}

can_teleport_ai_to_pos( var_0, var_1, var_2 )
{
    if ( player_can_see_ai_bones( var_0, var_2 ) )
        return 0;

    if ( player_can_see_point( var_1, var_2 ) )
        return 0;

    if ( player_can_see_point( var_1 + ( 0, 0, 70 ), var_2 ) )
        return 0;

    return 1;
}

player_can_see_point( var_0, var_1 )
{
    var_2 = 0.342;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    var_3 = level.player getangles();

    if ( !common_scripts\utility::within_fov( level.player.origin, var_3, var_0, var_2 ) )
        return 0;

    var_4 = level.player _meth_80A8();

    if ( sighttracepassed( var_4, var_0, 1, level.player ) )
        return 1;

    return 0;
}

player_can_see_ai_bones( var_0, var_1 )
{
    var_2 = 0.342;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, var_2 ) )
        return 0;

    var_3 = level.player _meth_80A8();
    var_4 = var_0 gettagorigin( "j_head" );

    if ( sighttracepassed( var_3, var_4, 1, level.player, var_0 ) )
        return 1;

    var_5 = var_0 gettagorigin( "j_mainroot" );

    if ( sighttracepassed( var_3, var_5, 1, level.player, var_0 ) )
        return 1;

    var_6 = var_0 gettagorigin( "j_wrist_le" );

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0 ) )
        return 1;

    var_6 = var_0 gettagorigin( "j_wrist_ri" );

    if ( sighttracepassed( var_3, var_6, 1, level.player, var_0 ) )
        return 1;

    var_7 = var_0 gettagorigin( "j_ankle_ri" );

    if ( sighttracepassed( var_3, var_7, 1, level.player, var_0 ) )
        return 1;

    var_7 = var_0 gettagorigin( "j_ankle_ri" );

    if ( sighttracepassed( var_3, var_7, 1, level.player, var_0 ) )
        return 1;

    return 0;
}

handle_ally_keep_up_with_player( var_0 )
{
    level notify( "stop_previous_ally_move_manager" );
    level endon( "stop_previous_ally_move_manager" );
    level endon( "flag_boat_player_in_boat" );
    var_1 = progress_path_create( "level_progression_path_start" );
    var_2 = var_1 progress_path_get_my_node_from_org( level.player.origin );
    var_3 = var_2;
    var_4 = 0;
    var_5 = var_1 progress_path_get_my_node_from_org( var_0.origin );
    var_6 = var_5;
    var_7 = 0;

    for (;;)
    {
        var_8 = get_progression_between_points( level.player.origin, var_2.origin, var_2.next_node.origin );
        var_9 = progress_path_move_to_correct_node( var_2, var_8["progress"], var_8["offset"] );
        var_10 = get_progression_between_points( var_0.origin, var_5.origin, var_5.next_node.origin );
        var_11 = progress_path_move_to_correct_node( var_5, var_10["progress"], var_10["offset"] );
        var_12 = var_9.progress;
        var_13 = var_9.offset;
        var_2 = var_9.node;
        var_14 = var_11.progress;
        var_15 = var_11.offset;
        var_5 = var_11.node;

        if ( var_2 == var_3.next_node )
        {
            var_3 = var_2;
            var_4 = var_12;
        }

        if ( var_2 == var_3 && var_12 >= var_4 + 5 )
        {
            var_3 = var_2;
            var_4 = var_12;
        }

        if ( var_5 == var_6.next_node )
        {
            var_6 = var_5;
            var_7 = var_14;
        }

        if ( var_5 == var_6 && var_14 >= var_7 + 5 )
        {
            var_6 = var_5;
            var_7 = var_14;
        }

        ally_determine_move_speed( var_9, var_11, var_0 );
        wait 0.05;
    }
}

ally_determine_move_speed( var_0, var_1, var_2 )
{
    level endon( "flag_boat_player_in_boat" );
    var_3 = 0;

    if ( var_0.node == var_1.node )
    {
        if ( var_0.progress > var_1.progress )
            var_3 = 1;
        else
            var_3 = 0;
    }
    else if ( var_0.node.index > var_1.node.index )
        var_3 = 1;
    else
        var_3 = 0;

    if ( var_3 )
    {
        var_4 = distance( level.player.origin, var_2.origin );

        if ( var_4 < 256 )
            var_2 maps\_utility::set_moveplaybackrate( 1.0, 0.5 );

        if ( var_4 < 512 )
            var_2 maps\_utility::set_moveplaybackrate( 1.2, 0.5 );
        else
            var_2 maps\_utility::set_moveplaybackrate( 1.4, 0.5 );
    }
    else
    {
        var_4 = distance( level.player.origin, var_2.origin );

        if ( var_4 < 64 )
            var_2 maps\_utility::set_moveplaybackrate( 1.05, 0.5 );
        else
            var_2 maps\_utility::set_moveplaybackrate( 1.0, 0.5 );
    }
}
