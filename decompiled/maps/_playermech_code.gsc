// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

playermech_init( var_0 )
{
    level thread playermech_fx_init();
    _func_0D3( "mechHide", 0 );

    if ( level.script == "finale" )
        _func_0D3( "mechFxLethalFlash", "muzzleflash/playermech_lethal_flash_view_run" );
    else
        _func_0D3( "mechFxLethalFlash", "muzzleflash/playermech_lethal_flash_view_run_cap" );

    _func_0D3( "mechMissileLerpTime", 0.4 );
    _func_0D3( "mechMissileTrackDelay", 0.2 );
    _func_0D3( "mechFxTacticalFlash", "muzzleflash/playermech_tactical_flash_view_run" );
    _func_0D3( "mechFxTacticalFlashTag", "tag_rocket_flash" );
    setdvar( "mechCompassScaleFudge", 1.5 );

    if ( 1 )
    {
        _func_0D3( "r_hudoutlineenable", 1 );
        _func_0D3( "r_chromaticAberrationTweaks", 1 );
        _func_0D3( "r_chromaticAberration", 0 );
        _func_0D3( "r_chromaticSeparationG", -10 );
        _func_0D3( "r_chromaticSeparationR", 10 );
    }

    precachemodel( "viewhands_playermech" );
    precachemodel( "vm_view_arms_mech" );
    precacheshader( "ui_playermech_icon_swarm_target" );
    precacheshader( "ui_playermech_icon_swarm_target" );
    precacheshader( "cinematic_3d_blend_visor" );
    precachemodel( "vm_exo_interior_base_missile" );
    self.mechdata = spawnstruct();
    self.mechdata.active = 0;
    self.mechdata.init_active = 0;
    self.mechdata.swarm_target_list = [];
    self.mechdata.swarm_scantime_override = undefined;
    self.mechdata.swarm_dot_override = undefined;
    self.mechdata.threat_list = [];
    self.mechdata.bool_norecharge = 0;
    self.mechdata.dmg_screen_all = [];
    self.mechdata.dmg_screen_left = [];
    self.mechdata.dmg_screen_right = [];
    level.mechdata_left_bones = [ "j_exo_left_srn_pnchout_01", "j_exo_left_srn_pnchout_02", "j_exo_left_srn_pnchout_03", "j_exo_left_srn_pnchout_04", "j_exo_left_srn_pnchout_05" ];
    level.mechdata_right_bones = [ "j_exo_right_srn_pnchout_01", "j_exo_right_srn_pnchout_02", "j_exo_right_srn_pnchout_03", "j_exo_right_srn_pnchout_04", "j_exo_right_srn_pnchout_05" ];
    playermech_init_dmg_screens();

    if ( isdefined( var_0 ) )
        self.mechdata.weapon_names = var_0;
    else
    {
        self.mechdata.weapon_names["mech_base_weapon"] = "playermech_auto_cannon";
        self.mechdata.weapon_names["mech_lethal_weapon"] = "playermech_rocket";
        self.mechdata.weapon_names["mech_tactical_weapon"] = "playermech_rocket_swarm";
        self.mechdata.weapon_names["mech_swarm_rocket"] = "playermech_rocket_projectile";
        self.mechdata.weapon_names["mech_swarm_rocket_deploy"] = "playermech_rocket_deploy_projectile";
        self.mechdata.weapon_names["mech_base_no_weapon"] = "playermech_auto_cannon_noweap";
        self.mechdata.weapon_names["mech_dmg1_weapon"] = "playermech_auto_cannon_dmg1";
        self.mechdata.weapon_names["mech_dmg2_weapon"] = "playermech_auto_cannon_dmg2";
    }

    precacheitem( self.mechdata.weapon_names["mech_base_weapon"] );
    precacheitem( self.mechdata.weapon_names["mech_lethal_weapon"] );
    precacheitem( self.mechdata.weapon_names["mech_tactical_weapon"] );
    precacheitem( self.mechdata.weapon_names["mech_swarm_rocket"] );
    precacheitem( self.mechdata.weapon_names["mech_swarm_rocket_deploy"] );
    precacheitem( self.mechdata.weapon_names["mech_base_no_weapon"] );
    precacheitem( self.mechdata.weapon_names["mech_dmg1_weapon"] );
    precacheitem( self.mechdata.weapon_names["mech_dmg2_weapon"] );
    common_scripts\utility::flag_init( "internal_threat_paint_in_progress" );
    common_scripts\utility::flag_init( "internal_swarm_rocket_active" );
    common_scripts\utility::flag_init( "internal_rocket_active" );
    common_scripts\utility::flag_init( "flag_mech_threat_paint_ping_on" );
    common_scripts\utility::flag_init( "flag_mech_vo_active" );
    common_scripts\utility::flag_init( "flag_mech_vo_playing" );
    common_scripts\utility::flag_init( "flag_force_hud_ready" );
    thread aud_playermech_foley_override_handler();
    self.mechdata.create_badplace = 1;

    if ( !isdefined( level.mech_max_health ) )
        level.mech_max_health = 100;

    if ( !isdefined( level.damage_multiplier_mod ) )
        level.damage_multiplier_mod = 0.07;

    if ( !isdefined( level.mech_swarm_rocket_max_targets ) )
        level.mech_swarm_rocket_max_targets = 8;

    if ( !isdefined( level.mech_swarm_rocket_dud_min_count ) )
        level.mech_swarm_rocket_dud_min_count = 0;

    if ( !isdefined( level.mech_swarm_rocket_dud_max_count ) )
        level.mech_swarm_rocket_dud_max_count = 0;

    if ( !isdefined( level.mech_swarm_line_of_sight_lock_duration ) )
        level.mech_swarm_line_of_sight_lock_duration = 2.0;

    if ( !isdefined( level.mech_swarm_use_two_stage_swarm ) )
        level.mech_swarm_use_two_stage_swarm = 1;

    if ( !isdefined( level.mech_swarm_two_stage_swarm_homing_distance ) )
        level.mech_swarm_two_stage_swarm_homing_distance = 250;

    if ( !isdefined( level.mech_swarm_two_stage_swarm_homing_strength ) )
        level.mech_swarm_two_stage_swarm_homing_strength = 7500;

    if ( !isdefined( level.mech_swarm_number_of_rockets_per_target ) )
        level.mech_swarm_number_of_rockets_per_target = 1;

    if ( !isdefined( level.mech_swarm_skip_line_of_sight_obstruction_test ) )
        level.mech_swarm_skip_line_of_sight_obstruction_test = 1;

    if ( !isdefined( level.mech_threat_paint_delay ) )
        level.mech_threat_paint_delay = 0.1;
}

playermech_init_vo()
{
    common_scripts\utility::flag_clear( "flag_mech_vo_playing" );
    var_0 = [ "cap_sri_maingunoverheating", "cap_sri_maingunoverheated" ];
    level.player thread dialogue_mech( var_0, "chaingun_state_overheat", "callback_chaingun_state_overheat" );
    level.player thread dialogue_mech( [ "cap_sri_maingunready" ], undefined, "chaingun_state_ready" );
    level.player thread dialogue_mech( [ "cap_sri_rocketreloading" ], undefined, "callback_rocket_reload" );
    level.player thread dialogue_mech( [ "cap_sri_rocketready" ], undefined, "rocket_state_ready" );
    level.player thread dialogue_mech( [ "cap_sri_swarmmissilesreloading" ], undefined, "callback_swarm_reload" );
    level.player thread dialogue_mech( [ "cap_sri_swarmmissilesready" ], undefined, "swarm_state_ready" );
}

dialog_mech_clear_queued( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 == "chaingun" )
    {
        maps\_utility::radio_dialogue_remove_from_stack( "chaingun_state_overheat" );
        maps\_utility::radio_dialogue_remove_from_stack( "cap_sri_maingunready" );
    }

    if ( !isdefined( var_0 ) || var_0 == "rocket" )
    {
        maps\_utility::radio_dialogue_remove_from_stack( "cap_sri_rocketreloading" );
        maps\_utility::radio_dialogue_remove_from_stack( "cap_sri_rocketready" );
    }

    if ( !isdefined( var_0 ) || var_0 == "swarm" )
    {
        maps\_utility::radio_dialogue_remove_from_stack( "cap_sri_swarmmissilesreloading" );
        maps\_utility::radio_dialogue_remove_from_stack( "cap_sri_swarmmissilesready" );
    }
}

dialogue_mech( var_0, var_1, var_2 )
{
    self endon( "exit_mech" );
    common_scripts\utility::flag_wait( "flag_mech_vo_active" );

    if ( isdefined( var_1 ) )
    {
        self waittill( var_1 );
        common_scripts\utility::flag_set( "flag_mech_vo_playing" );
        maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_0 ) );
        common_scripts\utility::flag_clear( "flag_mech_vo_playing" );
    }

    if ( isdefined( var_2 ) )
        childthread dialogue_mech_everytime( var_2, var_0 );
}

dialogue_mech_everytime( var_0, var_1 )
{
    var_2 = 0;

    if ( issubstr( var_0, "chaingun" ) )
        var_2 = 1;

    var_3 = 0;

    if ( issubstr( var_0, "rocket" ) )
        var_3 = 1;

    var_4 = 0;

    if ( issubstr( var_0, "swarm" ) )
        var_4 = 1;

    var_5 = 0;

    if ( issubstr( var_0, "overheat" ) )
        var_5 = 1;

    var_6 = 0;

    if ( issubstr( var_0, "ready" ) )
        var_6 = 1;

    var_7 = 0;

    if ( issubstr( var_0, "reload" ) )
        var_7 = 1;

    for (;;)
    {
        self waittill( var_0 );
        waittillframeend;

        if ( var_2 && self.mechuistate.chaingun.state == "offline" || var_3 && self.mechuistate.rocket.state == "offline" || var_4 && self.mechuistate.swarm.state == "offline" )
            continue;

        if ( var_2 && var_6 && ( self.mechuistate.chaingun.last_state == "firing" || self.mechuistate.chaingun.last_state == "none" ) )
            continue;

        if ( var_3 )
            dialog_mech_clear_queued( "rocket" );

        if ( var_4 )
            dialog_mech_clear_queued( "swarm" );

        if ( var_2 )
            dialog_mech_clear_queued( "chaingun" );

        thread play_reload_buzz( var_0, var_4, var_3 );

        if ( common_scripts\utility::flag( "flag_mech_vo_active" ) && ( var_6 || var_5 || !common_scripts\utility::flag( "flag_mech_vo_playing" ) ) )
        {
            common_scripts\utility::flag_set( "flag_mech_vo_playing" );
            maps\_utility::smart_radio_dialogue( common_scripts\utility::random( var_1 ) );
            common_scripts\utility::flag_clear( "flag_mech_vo_playing" );
        }

        if ( var_7 && ( var_4 || var_3 ) )
        {
            for (;;)
            {
                if ( var_3 && self.mechuistate.rocket.state != "reload" || var_4 && self.mechuistate.swarm.state != "reload" )
                {
                    self notify( "kill_play_reload_buzz" + var_0 );
                    break;
                }

                waitframe();
            }
        }

        wait 0.05;
    }
}

play_reload_buzz( var_0, var_1, var_2 )
{
    self notify( "kill_play_reload_buzz" + var_0 );
    self endon( "kill_play_reload_buzz" + var_0 );
    wait 1.0;

    for (;;)
    {
        self waittill( var_0 );

        if ( var_2 && self.mechuistate.rocket.state == "reload" || var_1 && self.mechuistate.swarm.state == "reload" )
            soundscripts\_snd_playsound::snd_play_2d( "wpn_goliath_dry_fire_plr" );

        wait 0.5;
    }
}

playermech_init_dmg_screens()
{
    for ( var_0 = 0; var_0 < level.mechdata_left_bones.size; var_0++ )
    {
        self.mechdata.dmg_screen_left[var_0] = spawnstruct();
        self.mechdata.dmg_screen_left[var_0].bone = level.mechdata_left_bones[var_0];
        self.mechdata.dmg_screen_left[var_0].flickering = 0;
        self.mechdata.dmg_screen_left[var_0].hidden = 0;
        self.mechdata.dmg_screen_all[level.mechdata_left_bones[var_0]] = self.mechdata.dmg_screen_left[var_0];
    }

    for ( var_0 = 0; var_0 < level.mechdata_right_bones.size; var_0++ )
    {
        self.mechdata.dmg_screen_right[var_0] = spawnstruct();
        self.mechdata.dmg_screen_right[var_0].bone = level.mechdata_right_bones[var_0];
        self.mechdata.dmg_screen_right[var_0].flickering = 0;
        self.mechdata.dmg_screen_right[var_0].hidden = 0;
        self.mechdata.dmg_screen_all[level.mechdata_right_bones[var_0]] = self.mechdata.dmg_screen_right[var_0];
    }
}

playermech_fx_init()
{
    level.mech_fx["rocket_separation"] = loadfx( "vfx/muzzleflash/playermech_tactical_flash_view_run" );
    level.mech_fx["bullet_hit_sparks"] = loadfx( "vfx/weaponimpact/metal_spark_fountain_small" );
    level.mech_fx["bullet_hit_sparks_large"] = loadfx( "vfx/weaponimpact/metal_spark_fountain_large" );
    level.mech_fx["rocket_trail_0"] = loadfx( "vfx/trail/exo_armor_rocket_trail_a" );
    level.mech_fx["rocket_trail_1"] = loadfx( "vfx/trail/exo_armor_rocket_trail_b" );
    level.mech_fx["rocket_trail_2"] = loadfx( "vfx/trail/exo_armor_rocket_trail_c" );
    level._effect["paint_threat"] = loadfx( "vfx/explosion/paint_grenade" );
    level._effect["exo_armor_gun_barrel_heat_view"] = loadfx( "vfx/muzzleflash/exo_armor_gun_barrel_heat_view" );
    level._effect["exo_armor_gun_barrel_overheat_view"] = loadfx( "vfx/muzzleflash/exo_armor_gun_barrel_overheat_view" );
    level._effect["playermech_lethal_flash_view_run_cap"] = loadfx( "vfx/muzzleflash/playermech_lethal_flash_view_run_cap" );
}

playermech_start( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;

    if ( !isplayer( self ) )
        var_5 = level.player;
    else
        var_5 = self;

    if ( !isdefined( var_5.mechdata ) )
    {

    }

    if ( !isdefined( var_0 ) )
        var_0 = "base";

    var_6 = var_5 get_mech_state();

    if ( isdefined( var_6 ) && var_6 == var_0 )
        return;

    if ( !isdefined( var_1 ) )
    {
        if ( var_0 == "base_noweap_bootup" )
            var_1 = 0;
        else
            var_1 = 1;
    }

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_5 thread _state_init();
    var_5 notify( "playermech_start" );
    var_5 thread aud_playermech_start();

    if ( !isdefined( var_3 ) )
        var_3 = "viewhands_playermech";

    if ( !isdefined( var_4 ) )
        var_4 = "viewhands_playermech_dmg1";

    switch ( var_0 )
    {
        case "base_noweap_bootup":
            var_5 _meth_8343( var_3 );

            if ( level.currentgen )
                var_5 _meth_84F5( "tag_camera", 1 );

            var_5 _meth_82FB( "ui_hide_hud", 1 );
            var_5 thread set_mech_weapon_state( var_0, var_1, var_5.mechdata.weapon_names["mech_base_no_weapon"], var_5.mechdata.weapon_names["mech_lethal_weapon"], var_5.mechdata.weapon_names["mech_tactical_weapon"], 0, 0, 0 );

            if ( !var_2 )
                enable_mech_threat_ping();

            break;
        case "base_noweap":
            var_5 _meth_8343( var_3 );

            if ( level.currentgen )
                var_5 _meth_84F5( "tag_camera", 1 );

            var_5 _meth_82FB( "ui_playermech_hud", 1 );
            var_5 _meth_82FB( "ui_hide_hud", 0 );

            if ( level.currentgen )
                var_5 common_scripts\utility::delaycall( 0.2, ::_meth_84F5, "tag_camera", 0 );

            var_5 thread set_mech_weapon_state( var_0, var_1, var_5.mechdata.weapon_names["mech_base_no_weapon"], var_5.mechdata.weapon_names["mech_lethal_weapon"], var_5.mechdata.weapon_names["mech_tactical_weapon"], 0, 0, 0 );

            if ( !var_2 )
                enable_mech_threat_ping();

            break;
        case "base_transition":
        case "base":
            var_5 _meth_82FB( "ui_playermech_hud", 1 );
            var_5 _meth_82FB( "ui_hide_hud", 0 );
            var_5 _meth_8343( var_3 );
            var_5 thread set_mech_weapon_state( var_0, var_1, var_5.mechdata.weapon_names["mech_base_weapon"], var_5.mechdata.weapon_names["mech_lethal_weapon"], var_5.mechdata.weapon_names["mech_tactical_weapon"] );

            if ( !var_2 )
                enable_mech_threat_ping();

            break;
        case "dmg1":
        case "dmg1_transition":
            var_5 _meth_82FB( "ui_playermech_hud", 1 );
            var_5 _meth_82FB( "ui_hide_hud", 0 );
            var_5 _meth_8343( var_4 );
            var_5 thread set_mech_weapon_state( var_0, var_1, var_5.mechdata.weapon_names["mech_dmg1_weapon"], var_5.mechdata.weapon_names["mech_lethal_weapon"], var_5.mechdata.weapon_names["mech_tactical_weapon"] );

            if ( !var_2 )
                enable_mech_threat_ping();

            break;
        case "dmg2":
        case "dmg2_transition":
            var_5 _meth_82FB( "ui_playermech_hud", 1 );
            var_5 _meth_82FB( "ui_hide_hud", 0 );
            var_5 _meth_8343( var_4 );
            var_5 thread set_mech_weapon_state( var_0, var_1, var_5.mechdata.weapon_names["mech_dmg2_weapon"], var_5.mechdata.weapon_names["mech_lethal_weapon"], var_5.mechdata.weapon_names["mech_tactical_weapon"], 0, 0, 0 );
            disable_mech_threat_ping();
            break;
        default:
    }

    var_7 = 1;

    foreach ( var_9 in var_5.mechdata.dmg_screen_all )
    {
        var_5 thread hide_mech_screen( var_9, 0.05 * var_7 );
        var_7++;
    }
}

playermech_end( var_0 )
{
    var_1 = undefined;

    if ( !isplayer( self ) )
        var_1 = level.player;
    else
        var_1 = self;

    var_1 thread _exit( var_0 );
    var_1 thread aud_playermech_end();
}

add_swarm_repulsor_for_ally( var_0, var_1 )
{
    if ( !isdefined( var_0.swarm_repulsor_foot ) )
    {
        var_0.swarm_repulsor_foot = missile_createrepulsorent( var_0, 10000, 100, var_1 );
        var_2 = var_0 _meth_8096() - var_0.origin;
        var_0.swarm_repulsor_body = missile_createrepulsorent( var_0, 10000, 100, var_1, 0, ( 0, 0, var_2[2] ) );
        var_0.swarm_repulsor_head = missile_createrepulsorent( var_0, 10000, 100, var_1, 0, ( 0, 0, var_2[2] * 2 ) );
    }
}

enable_mech_threat_ping()
{
    common_scripts\utility::flag_set( "flag_mech_threat_paint_ping_on" );
}

disable_mech_threat_ping()
{
    common_scripts\utility::flag_clear( "flag_mech_threat_paint_ping_on" );
}

enable_mech_chaingun()
{
    set_mech_chaingun_state( "ready" );
    self _meth_8131( 1 );
}

disable_mech_chaingun()
{
    set_mech_chaingun_state( "offline" );
    dialog_mech_clear_queued( "chaingun" );
    self _meth_8131( 0 );
}

enable_mech_rocket()
{
    set_mech_rocket_state( "ready" );
    thread playermech_monitor_rocket_recharge();
    self _meth_8320();
}

disable_mech_rocket()
{
    set_mech_rocket_state( "offline" );
    self notify( "stop_rocket_recharge" );
    self.mechuistate.rocket.recharge = 100;
    dialog_mech_clear_queued( "rocket" );
    self _meth_831F();
}

enable_mech_swarm()
{
    set_mech_swarm_state( "ready" );
    thread playermech_monitor_swarm_recharge();
    self _meth_84C0();
}

disable_mech_swarm()
{
    set_mech_swarm_state( "offline" );
    dialog_mech_clear_queued( "swarm" );
    self notify( "stop_swarm_recharge" );
    self _meth_84BF();
}

enable_stencil( var_0 )
{
    if ( isarray( var_0 ) )
    {
        foreach ( var_2 in var_0 )
        {
            var_2.disablestencil = undefined;
            mark_stencil( var_2 );
        }
    }
    else
    {
        var_0.disablestencil = undefined;
        mark_stencil( var_0 );
    }
}

disable_stencil( var_0 )
{
    if ( isarray( var_0 ) )
    {
        foreach ( var_2 in var_0 )
            var_2.disablestencil = 1;
    }
    else
        var_0.disablestencil = 1;
}

mech_setup_player_for_forced_walk_scene()
{
    mech_setup_player_for_scene( undefined, 1 );
}

mech_setup_player_for_scene( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    _func_0D3( "ammoCounterHide", 1 );
    self _meth_831F();
    self _meth_8321();
    self _meth_8536( 0 );
    self _meth_8119( 0 );
    self _meth_8301( 0 );
    self _meth_8130( 0 );
    self _meth_8118( 1 );
    self _meth_811A( 0 );
    self _meth_8304( 0 );
    self _meth_8303( 0 );
    self _meth_82CB( 1 );
    self _meth_80FA();
    self.original_r_znear = getdvarfloat( "r_znear" );
    _func_0D3( "r_znear", 1 );

    if ( var_1 )
    {
        self _meth_8300( 1 );
        self _meth_8481();
        self.viewmodel_hidden = 0;
    }
    else
    {
        self _meth_8300( 0 );
        self _meth_8482();
        self.viewmodel_hidden = 1;
        self notify( "kill_barrel_vfx" );
        thread reload_checker_hack();
    }

    if ( isdefined( self.mechuistate ) )
    {
        disable_mech_swarm();
        disable_mech_rocket();
        disable_mech_chaingun();
    }

    if ( isdefined( var_0 ) && var_0 )
    {
        waitframe();
        waitframe();

        while ( self _meth_817C() != "stand" || self _meth_812C() || self _meth_8337() )
        {
            self _meth_817D( "stand" );
            wait 0.05;
        }
    }

    self _meth_84B8( 0 );
}

mech_setup_player_for_gameplay()
{
    _func_0D3( "ammoCounterHide", 0 );
    self _meth_8320();
    self _meth_8321();
    self _meth_8536( 0 );
    self _meth_8119( 0 );
    self _meth_8301( 1 );
    self _meth_8130( 1 );
    self _meth_8118( 1 );
    self _meth_811A( 0 );
    self _meth_8304( 1 );
    self _meth_8303( 0 );
    self _meth_82CB( 1 );
    self _meth_80FB();
    self _meth_8300( 1 );

    if ( isdefined( self.original_r_znear ) )
    {
        _func_0D3( "r_znear", self.original_r_znear );
        self.original_r_znear = undefined;
    }

    self _meth_8481();
    self.viewmodel_hidden = 0;

    if ( isdefined( self.mechuistate ) )
    {
        enable_mech_swarm();
        enable_mech_rocket();
        enable_mech_chaingun();
    }
}

reload_checker_hack()
{
    for (;;)
    {
        if ( self.viewmodel_hidden == 1 )
            self _meth_8482();
        else
            break;

        waitframe();
    }
}

_state_init()
{
    if ( !isdefined( self.mechdata ) )
    {

    }

    self _meth_831E();
    mech_setup_player_for_gameplay();

    if ( !self.mechdata.active )
    {
        self.mechdata.active = 1;
        self.mechdata.init_active = 1;
        self.dontmelee = 1;
        level.noautosaveammocheck = 1;
        playermech_save_player_data();
        thread playermech_damage_manager();
        thread playermech_state_manager();
        level.savedcompassfadetime = getdvar( "hud_fade_compass" );
        _func_0D3( "hud_fade_compass", 0 );
        _func_0D3( "mechUseCodeSounds", 1 );
        _func_0D3( "mechUseCodeRumble", 1 );
        wait 0.2;
        self _meth_8470();
        self _meth_846F( "cinematic_3d_blend", "cinematic_3d_blend_visor" );
        self _meth_8494( 1 );

        if ( !isdefined( self._old_visionset ) || level.lvl_visionset != "_playermech" )
            self._old_visionset = level.lvl_visionset;

        thread maps\_utility::vision_set_changes( "_playermech", 0.05 );
        thread playermech_chaingun_watcher();
        thread playermech_rockets_and_swarm_watcher();
        thread playermech_invalid_weapon_watcher();
        playermech_init_vo();
        thread unlimited_mech_ammo();

        if ( level.script == "finale" )
            thread playermech_physics_push_finale();
        else
            thread playermech_physics_push();

        thread playermech_threat_paint_ping_loop();
        thread playermech_badplace();
        thread playermech_damage_parts();
        self.mechdata.init_active = 0;
    }
}

mech_linkplayerview_rocket()
{
    if ( 0 )
        return;

    wait 0.05;
    mech_unlinkplayerview_rocket();
    var_0 = spawn( "script_model", ( 0, 0, 0 ) );
    var_0.angles = ( 0, 0, 0 );
    var_0 _meth_80B1( "vm_exo_interior_base_missile" );
    var_0 _meth_80A6( self, "j_rocket", ( 0, 0, 0 ), ( 0, 0, 0 ), 0 );
    self.linked_rocket = var_0;
}

mech_unlinkplayerview_rocket()
{
    if ( !isdefined( self.linked_rocket ) )
        return;

    self.linked_rocket _meth_80A7( self );
    self.linked_rocket delete();
    self.linked_rocket = undefined;
}

set_mech_weapon_state( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self endon( "exit_mech" );

    if ( !isdefined( var_5 ) )
        var_5 = 1;

    if ( !isdefined( var_6 ) )
        var_6 = 1;

    if ( !isdefined( var_7 ) )
        var_7 = 1;

    if ( var_5 )
        enable_mech_chaingun();
    else
        disable_mech_chaingun();

    if ( var_6 )
        enable_mech_rocket();
    else
        disable_mech_rocket();

    if ( var_7 )
        enable_mech_swarm();
    else
        disable_mech_swarm();

    var_8 = self _meth_8312();

    if ( var_8 != var_2 )
    {
        if ( var_8 != "none" )
            thread delayed_takeweapon( var_8 );

        self _meth_830E( var_2 );

        if ( var_1 )
            self _meth_8316( var_2 );
        else
            self _meth_8315( var_2 );

        thread mech_linkplayerview_rocket();
    }

    var_9 = self _meth_8345();

    if ( var_9 != var_3 )
    {
        if ( var_9 != "none" )
            self _meth_830F( var_9 );

        self _meth_8344( var_3 );
        self _meth_830E( var_3 );
    }

    var_10 = self _meth_831A();

    if ( var_10 != var_4 )
    {
        if ( var_10 != "none" )
            self _meth_830F( var_10 );

        self _meth_8319( var_4 );
        self _meth_830E( var_4 );
    }

    while ( self.mechdata.init_active )
        wait 0.05;

    while ( self _meth_8312() != var_2 )
        wait 0.05;

    set_mech_state( var_0 );
}

delayed_takeweapon( var_0 )
{
    self endon( "exit_mech" );
    self notify( "notify_stop_delayed_takeweapon" );
    self endon( "notify_stop_delayed_takeweapon" );
    wait 0.3;
    self _meth_830F( var_0 );
}

_exit( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        foreach ( var_2 in var_0 )
            common_scripts\utility::flag_waitopen( var_2 );
    }

    common_scripts\utility::flag_waitopen( "internal_threat_paint_in_progress" );

    if ( !isdefined( self.mechdata ) )
    {

    }

    mech_unlinkplayerview_rocket();
    playermech_restore_player_data();
    _func_0D3( "cg_cinematicfullscreen", "1" );
    _func_05C();
    self _meth_8470();
    self _meth_82FB( "ui_playermech_hud", 0 );
    _func_0D3( "hud_fade_compass", level.savedcompassfadetime );
    _func_0D3( "player_damagemultiplier", 1 );
    _func_0D3( "player_radiusDamageMultiplier", 1 );
    self notify( "noHealthOverlay" );
    thread maps\_gameskill::healthoverlay();
    _func_0D3( "mechUseCodeSounds", 0 );
    _func_0D3( "mechUseCodeRumble", 0 );
    self _meth_8494( 0 );

    if ( isdefined( self._old_visionset ) )
        thread maps\_utility::vision_set_changes( self._old_visionset, 0.05 );

    self.mechdata.active = 0;
    self.dontmelee = 0;
    level.noautosaveammocheck = 0;
    set_mech_state( "none" );
    self notify( "exit_mech" );
    self _meth_80EC( 0 );
}

playermech_save_player_data()
{
    self.mechdata.activeweapon = self _meth_8311();
    var_0 = self _meth_830B();
    self.mechdata.weapons = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = self.mechdata.weapons.size;
        self.mechdata.weapons[var_3] = spawnstruct();
        self.mechdata.weapons[var_3].name = var_2;
        self.mechdata.weapons[var_3].clipammor = self _meth_82F8( var_2, "right" );
        self.mechdata.weapons[var_3].clipammol = self _meth_82F8( var_2, "left" );
        self.mechdata.weapons[var_3].stockammo = self _meth_82F9( var_2 );
    }

    self _meth_8310();
    self _meth_8536( 0 );
}

playermech_restore_player_data()
{
    self _meth_8310();

    foreach ( var_1 in self.mechdata.weapons )
    {
        self _meth_830E( var_1.name );
        self _meth_82F6( var_1.name, var_1.clipammor, "right" );
        self _meth_82F6( var_1.name, var_1.clipammol, "left" );
        self _meth_82F7( var_1.name, var_1.stockammo );
    }

    self _meth_8322();
    self _meth_8536( 1 );
    self _meth_8315( self.mechdata.activeweapon );
}

playermech_ui_state_reset()
{
    if ( !isdefined( self.mechuistate ) )
    {
        self.mechuistate = spawnstruct();
        self.mechuistate.chaingun = spawnstruct();
        self.mechuistate.swarm = spawnstruct();
        self.mechuistate.rocket = spawnstruct();
        self.mechuistate.threat_list = spawnstruct();
        self.mechuistate.state = "none";
        self.mechuistate.chaingun.state = "none";
        self.mechuistate.chaingun.last_state = "none";
        self.mechuistate.swarm.state = "none";
        self.mechuistate.swarm.last_state = "none";
        self.mechuistate.rocket.state = "none";
        self.mechuistate.rocket.last_state = "none";
    }

    set_mech_state();
    self.mechuistate.threat_list.threats = [];
    self.mechuistate.threat_list.compass_offsets = [];
    self.mechuistate.chaingun.heatlevel = 0;
    self.mechuistate.chaingun.overheated = 0;
    self.mechuistate.swarm.target_list = [];
    self.mechuistate.swarm.threat_scan = 0;
    self.mechuistate.swarm.recharge = 100;
    self.mechuistate.rocket.fire = 0;
    self.mechuistate.rocket.recharge = 100;
}

playermech_ui_state_enter( var_0 )
{
    switch ( var_0 )
    {
        case "base_noweap_bootup":
            _func_0D3( "cg_cinematicfullscreen", "0" );

            if ( !level.currentgen )
                _func_057( "playermech_bootup" );

            break;
        case "base_noweap":
            _func_0D3( "cg_cinematicfullscreen", "0" );
            break;
        case "base_transition":
            break;
        case "base":
            _func_0D3( "cg_cinematicfullscreen", "0" );
            break;
        case "dmg1_transition":
            break;
        case "dmg1":
            break;
        case "dmg2_transition":
            break;
        case "dmg2":
            break;
        case "outro":
            _func_0D3( "cg_cinematicfullscreen", "0" );
            _func_059( "playermech_outro" );
            break;
    }
}

playermech_ui_state_leave( var_0 )
{
    switch ( var_0 )
    {
        case "base_noweap_bootup":
            break;
        default:
            _func_0D3( "cg_cinematicfullscreen", "1" );
            _func_05C();
            break;
    }
}

playermech_state_manager()
{
    self endon( "exit_mech" );
    playermech_ui_state_reset();
    set_mech_state();
    set_mech_chaingun_state();
    set_mech_rocket_state();
    set_mech_swarm_state();
    thread playermech_ui_chaingun_feedback();
    thread playermech_ui_swarm_feedback();
    thread playermech_ui_rocket_feedback();

    for (;;)
    {
        state_main_pump();
        state_chaingun_pump();
        state_rocket_pump();
        state_swarm_pump();
        self.mechuistate.threat_list.threats = maps\_utility::remove_dead_from_array( self.mechdata.threat_list );
        playermech_ui_update_threat_compass_values( self.mechuistate.threat_list );
        playermech_ui_update_lui( self.mechuistate );
        wait 0.05;
    }
}

set_mech_state( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self.mechuistate ) )
        return;

    if ( self.mechuistate.state == var_0 )
        return;

    playermech_ui_state_leave( self.mechuistate.state );
    self.mechuistate.state = var_0;
    self notify( var_0 );
    playermech_ui_state_enter( var_0 );
}

get_mech_state()
{
    if ( !isdefined( self.mechuistate ) )
        return;

    return self.mechuistate.state;
}

get_front_sorted_threat_list( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( vectordot( var_4.origin - self.origin, var_1 ) < 0 )
            continue;

        var_2[var_2.size] = var_4;
    }

    var_2 = sortbydistance( var_2, self.origin );
    return var_2;
}

playermech_ui_weapon_feedback( var_0, var_1 )
{
    self endon( "exit_mech" );
    self _meth_82FB( var_1, 0 );

    for (;;)
    {
        while ( !self call [[ var_0 ]]() )
            wait 0.05;

        self _meth_82FB( var_1, 1 );

        while ( self call [[ var_0 ]]() )
            wait 0.05;

        self _meth_82FB( var_1, 0 );
        wait 0.05;
    }
}

playermech_ui_chaingun_feedback()
{
    playermech_ui_weapon_feedback( ::attackbuttonpressed, "ui_playermech_chaingun_pressed" );
}

playermech_ui_swarm_feedback()
{
    playermech_ui_weapon_feedback( ::_meth_82EF, "ui_playermech_swarm_pressed" );
}

playermech_ui_rocket_feedback()
{
    playermech_ui_weapon_feedback( ::_meth_82EE, "ui_playermech_rocket_pressed" );
}

playermech_ui_update_threat_compass_values( var_0 )
{
    var_0.compass_offsets = [];
    var_1 = anglestoforward( self getangles() );

    if ( var_1[2] > 0.99 )
        return;

    var_1 = vectornormalize( var_1 * ( 1, 1, 0 ) );
    var_2 = get_front_sorted_threat_list( var_0.threats, var_1 );
    var_3 = getdvarfloat( "mechCompassScaleFudge" );

    foreach ( var_5 in var_2 )
    {
        var_6 = var_5.origin - self.origin;
        var_6 = vectornormalize( var_6 * ( 1, 1, 0 ) );

        if ( var_6[2] > 0.99 )
        {
            var_2.compass_offsets[var_0.compass_offsets.size] = 0;
            continue;
        }

        var_7 = acos( clamp( vectordot( var_6, var_1 ), -1, 1 ) ) / 180.0;
        var_8 = vectorcross( var_6, var_1 );

        if ( var_8[2] <= 0 )
            var_7 *= -1.0;

        var_7 *= var_3;
        var_0.compass_offsets[var_0.compass_offsets.size] = var_7;
    }
}

playermech_ui_update_lui( var_0 )
{
    self _meth_82FB( "ui_playermech_numswarmtargets", var_0.swarm.target_list.size );
    self _meth_82FB( "ui_playermech_swarmrecharge", var_0.swarm.recharge );
    self _meth_82FB( "ui_playermech_threats_scanned", var_0.swarm.threat_scan );
    self _meth_82FB( "ui_playermech_rocketrecharge", var_0.rocket.recharge );
    self _meth_82FB( "ui_playermech_chaingun_heatlevel", var_0.chaingun.heatlevel );
    self _meth_82FB( "ui_playermech_threat_count", var_0.threat_list.compass_offsets.size );

    for ( var_1 = 0; var_1 < 8; var_1++ )
    {
        var_2 = var_1 + 1;

        if ( var_0.threat_list.compass_offsets.size >= var_2 )
            self _meth_82FB( "ui_playermech_threat_position_" + var_2, var_0.threat_list.compass_offsets[var_1] );
    }
}

state_main_pump()
{
    switch ( get_mech_state() )
    {
        case "outro":
        case "dmg2":
        case "dmg2_transition":
        case "dmg1":
        case "dmg1_transition":
        case "base_transition":
        case "base_noweap":
        case "base_noweap_bootup":
        case "base":
            break;
        case "none":
            playermech_ui_state_reset();
            break;
        default:
    }
}

state_chaingun_pump()
{
    set_mech_chaingun_last_state();
    var_0 = get_mech_chaingun_state();
    var_1 = self _meth_8311();
    self.mechuistate.chaingun.heatlevel = self _meth_83B9( var_1 );
    self.mechuistate.chaingun.overheated = self _meth_83BA( var_1 );

    if ( common_scripts\utility::flag( "flag_force_hud_ready" ) && var_0 != "offline" )
    {
        if ( var_0 != "ready" )
            set_mech_chaingun_state( "ready" );
    }
    else if ( var_0 == "ready" )
    {
        if ( self.mechuistate.chaingun.overheated )
        {
            set_mech_chaingun_state( "overheat" );
            thread barrel_overheat_fx();
        }
        else if ( self attackbuttonpressed() && !self _meth_82EE() && !self _meth_82EF() && !common_scripts\utility::flag( "internal_swarm_rocket_active" ) && !common_scripts\utility::flag( "internal_rocket_active" ) )
            set_mech_chaingun_state( "firing" );
    }
    else if ( var_0 == "firing" )
    {
        if ( self.mechuistate.chaingun.overheated )
        {
            set_mech_chaingun_state( "overheat" );
            thread barrel_overheat_fx();
        }
        else if ( !self attackbuttonpressed() || self _meth_82EE() || self _meth_82EF() )
            set_mech_chaingun_state( "ready" );
    }
    else if ( var_0 == "overheat" && !self.mechuistate.chaingun.overheated )
        set_mech_chaingun_state( "ready" );

    switch ( get_mech_chaingun_state() )
    {
        case "ready":
            self _meth_82FB( "ui_playermech_chaingun_state", 1 );
            break;
        case "firing":
            self _meth_82FB( "ui_playermech_chaingun_state", 2 );
            break;
        case "overheat":
            self _meth_82FB( "ui_playermech_chaingun_state", 3 );
            break;
        case "offline":
            self _meth_82FB( "ui_playermech_chaingun_state", 4 );
            break;
        case "none":
            self _meth_82FB( "ui_playermech_chaingun_state", 0 );
            break;
        default:
    }
}

state_rocket_pump()
{
    set_mech_rocket_last_state();
    var_0 = get_mech_rocket_state();

    if ( common_scripts\utility::flag( "flag_force_hud_ready" ) && var_0 != "offline" && var_0 != "reload" )
    {
        if ( var_0 != "ready" )
            set_mech_rocket_state( "ready" );
    }
    else if ( var_0 != "offline" && playermech_invalid_rocket_callback() )
        set_mech_rocket_state( "reload" );
    else if ( var_0 == "reload" && !playermech_invalid_rocket_callback() )
        set_mech_rocket_state( "ready" );

    switch ( get_mech_rocket_state() )
    {
        case "ready":
            self _meth_82FB( "ui_playermech_rocket_state", 1 );
            break;
        case "reload":
            self _meth_82FB( "ui_playermech_rocket_state", 2 );
            break;
        case "offline":
            self _meth_82FB( "ui_playermech_rocket_state", 3 );
            break;
        case "none":
            self _meth_82FB( "ui_playermech_rocket_state", 0 );
            break;
        default:
    }
}

state_swarm_pump()
{
    set_mech_swarm_last_state();
    var_0 = get_mech_swarm_state();
    self.mechuistate.swarm.target_list = maps\_utility::remove_dead_from_array( self.mechdata.swarm_target_list );

    if ( common_scripts\utility::flag( "flag_force_hud_ready" ) && var_0 != "offline" && var_0 != "reload" )
    {
        if ( var_0 != "ready" )
        {
            set_mech_swarm_state( "ready" );
            self.mechuistate.swarm.target_list = [];
        }
    }
    else if ( common_scripts\utility::flag( "internal_swarm_rocket_active" ) )
        set_mech_swarm_state( "target" );
    else if ( var_0 == "target" && playermech_invalid_swarm_callback() )
        set_mech_swarm_state( "reload" );
    else if ( var_0 == "reload" && !playermech_invalid_swarm_callback() )
        set_mech_swarm_state( "ready" );

    switch ( get_mech_swarm_state() )
    {
        case "ready":
            self _meth_82FB( "ui_playermech_swarm_state", 1 );
            break;
        case "reload":
            self _meth_82FB( "ui_playermech_swarm_state", 3 );
            break;
        case "target":
            self _meth_82FB( "ui_playermech_swarm_state", 2 );
            break;
        case "offline":
            self _meth_82FB( "ui_playermech_swarm_state", 4 );
            break;
        case "none":
            self _meth_82FB( "ui_playermech_swarm_state", 0 );
            break;
        default:
    }
}

set_mech_chaingun_state( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self.mechuistate.chaingun.state ) )
        self.mechuistate.chaingun.state = "none";

    if ( self.mechuistate.chaingun.state == var_0 )
        return;

    self.mechuistate.chaingun.state = var_0;
    self notify( "chaingun_state_" + var_0 );
}

get_mech_chaingun_state()
{
    if ( !isdefined( self.mechuistate ) )
        return;

    return self.mechuistate.chaingun.state;
}

set_mech_chaingun_last_state()
{
    if ( isdefined( self.mechuistate.chaingun.last_state ) && self.mechuistate.chaingun.state == self.mechuistate.chaingun.last_state )
        return 1;

    self.mechuistate.chaingun.last_state = self.mechuistate.chaingun.state;
    return 0;
}

set_mech_rocket_state( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self.mechuistate.rocket.state ) )
        self.mechuistate.rocket.state = "none";

    if ( self.mechuistate.rocket.state == var_0 )
        return;

    self.mechuistate.rocket.state = var_0;
    self notify( "rocket_state_" + var_0 );
}

get_mech_rocket_state()
{
    if ( !isdefined( self.mechuistate ) )
        return;

    return self.mechuistate.rocket.state;
}

set_mech_rocket_last_state()
{
    if ( isdefined( self.mechuistate.rocket.last_state ) && self.mechuistate.rocket.state == self.mechuistate.rocket.last_state )
        return 1;

    self.mechuistate.rocket.last_state = self.mechuistate.rocket.state;
    return 0;
}

set_mech_swarm_state( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    if ( !isdefined( self.mechuistate.swarm.state ) )
        self.mechuistate.swarm.state = "none";

    if ( self.mechuistate.swarm.state == var_0 )
        return;

    self.mechuistate.swarm.state = var_0;
    self notify( "swarm_state_" + var_0 );
}

get_mech_swarm_state()
{
    if ( !isdefined( self.mechuistate ) )
        return;

    return self.mechuistate.swarm.state;
}

set_mech_swarm_last_state()
{
    if ( isdefined( self.mechuistate.swarm.last_state ) && self.mechuistate.swarm.state == self.mechuistate.swarm.last_state )
        return 1;

    self.mechuistate.swarm.last_state = self.mechuistate.swarm.state;
    return 0;
}

playermech_monitor_update_recharge( var_0, var_1 )
{
    var_0.recharge = 0;
    var_2 = 100.0 / ( var_1 / 0.05 );

    while ( var_0.recharge < 100 )
    {
        var_0.recharge += var_2;
        wait 0.05;
    }

    var_0.recharge = 100;
}

playermech_monitor_rocket_recharge()
{
    self endon( "exit_mech" );
    self notify( "stop_rocket_recharge" );
    self endon( "stop_rocket_recharge" );

    for (;;)
    {
        self waittill( "mech_rocket_fire" );
        self _meth_831F();
        playermech_monitor_update_recharge( self.mechuistate.rocket, 4.0 );
        self _meth_8320();
        wait 0.05;
    }
}

playermech_monitor_swarm_recharge()
{
    self endon( "exit_mech" );
    self notify( "stop_swarm_recharge" );
    self endon( "stop_swarm_recharge" );

    for (;;)
    {
        self waittill( "mech_swarm_fire" );
        self _meth_84BF();
        playermech_monitor_update_recharge( self.mechuistate.swarm, 6.0 );
        self _meth_84C0();
        wait 0.05;
    }
}

playermech_link_viewmodel_part( var_0, var_1, var_2, var_3 )
{
    self endon( "exit_mech" );
    var_0 _meth_8115( var_2 );
    var_0 _meth_80A6( self, var_3, ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    var_0 _meth_82BF();
    self _meth_82DD( "playerdamage", "+usereload" );

    for (;;)
    {
        var_0 hide();
        self waittill( "playerdamage" );
        var_0 show();
        var_0 _meth_814D( var_1, 1, 0, 1 );
        wait(getanimlength( var_1 ) + 0.05);
    }
}

#using_animtree("script_model");

playermech_damage_parts()
{
    if ( !0 )
        return;

    var_0 = spawn( "script_model", ( 0, 0, 0 ) );
    var_0 _meth_80B1( "cap_playermech_breakable_wall" );
    playermech_link_viewmodel_part( var_0, %cap_playermech_run_through_prop_short, #animtree, "tag_flash" );
}

playermech_is_damage_allowed( var_0, var_1, var_2 )
{
    if ( var_1 == "MOD_MELEE" && isdefined( var_2 ) && issubstr( var_2.classname, "enemy_mech" ) )
        return 1;

    if ( self.mechdata.health - var_0 < 30 )
        return 1;

    if ( self.mechdata.damage_allowed )
        return 1;

    return 0;
}

playermech_damage_manager()
{
    self endon( "exit_mech" );
    self.mechdata.health = level.mech_max_health;
    self.mechdata.damage_allowed = 0;
    self.mechdata.regen_cooldown = 0;
    _func_0D3( "player_damagemultiplier", level.damage_multiplier_mod );
    _func_0D3( "player_radiusDamageMultiplier", level.damage_multiplier_mod );
    childthread playermech_health_restore();
    childthread playermech_player_hit_fx();
    childthread playermech_mech_regen();
    var_0 = getdvarfloat( "player_damagemultiplier" );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
        self.mechdata.health -= var_1 / level.damage_multiplier_mod * 0.25;
        self notify( "mech_damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );
        soundscripts\_snd_playsound::snd_play_at( "bullet_large_mech_plr", var_4 );
        self.mechdata.regen_cooldown = 1;

        if ( level.script != "finale" )
            childthread screen_flicker_full( var_4 );
    }
}

screen_flicker_full( var_0 )
{
    var_1 = anglestoforward( self.angles );
    var_0 = ( var_0[0], var_0[1], self.origin[2] );
    var_2 = vectornormalize( var_0 - self.origin );
    var_3 = vectordot( var_1, var_2 );
    var_4 = vectorcross( var_1, var_2 );
    var_5 = undefined;

    if ( var_4[2] >= 0 )
        var_5 = self.mechdata.dmg_screen_left;
    else
        var_5 = self.mechdata.dmg_screen_right;

    foreach ( var_7 in common_scripts\utility::array_randomize( var_5 ) )
        childthread screen_flicker_full_solo( var_7 );
}

screen_flicker_full_solo( var_0 )
{
    if ( !var_0.flickering )
    {
        var_0.flickering = 1;
        childthread show_mech_screen( var_0, 0.05 );
        wait(randomfloatrange( 0.2, 0.7 ));
        hide_mech_screen( var_0, 0.05 );
        wait 0.05;
        var_0.flickering = 0;
    }
}

screen_flicker( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = undefined;

    if ( !isplayer( self ) )
    {
        if ( !isdefined( self.mechdata ) )
        {
            self.mechdata = spawnstruct();
            playermech_init_dmg_screens();
        }
    }

    if ( isdefined( var_0 ) )
    {
        var_3 = anglestoforward( self.angles );
        var_0 = ( var_0[0], var_0[1], self.origin[2] );
        var_4 = vectornormalize( var_0 - self.origin );
        var_5 = vectordot( var_3, var_4 );
        var_6 = vectorcross( var_3, var_4 );

        if ( var_6[2] >= 0 )
            var_2 = self.mechdata.dmg_screen_left;
        else
            var_2 = self.mechdata.dmg_screen_right;
    }
    else
        var_2 = common_scripts\utility::array_combine( self.mechdata.dmg_screen_left, self.mechdata.dmg_screen_right );

    var_7 = 0.1;
    var_8 = 0.05;
    var_9 = 0.0;

    foreach ( var_11 in common_scripts\utility::array_randomize( var_2 ) )
    {
        if ( var_1 )
        {
            var_8 = randomfloatrange( 0.1, 1 );
            var_9 = randomfloatrange( 0.1, 1 );
            var_7 = randomfloatrange( 0.1, 1 );
        }

        childthread show_mech_screen( var_11, var_8 );
        var_11.flickering = 1;
        childthread hide_mech_screen( var_11, var_8 + var_7 + var_9 );
        var_11.flickering = 0;
    }
}

hide_mech_screen( var_0, var_1 )
{
    self endon( "death" );

    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( !var_0.hidden )
    {
        if ( isplayer( self ) )
            self _meth_84F5( var_0.bone, 1 );
        else
            self _meth_8048( var_0.bone );

        var_0.hidden = 1;
    }
}

show_mech_screen( var_0, var_1 )
{
    self endon( "kill_show_mech_screen" );
    self endon( "death" );

    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( var_0.hidden )
    {
        if ( isplayer( self ) )
            self _meth_84F5( var_0.bone, 0 );
        else
            self _meth_804B( var_0.bone );

        var_0.hidden = 0;
    }
}

playermech_mech_regen()
{
    var_0 = 6;
    var_1 = 1;
    var_2 = level.mech_max_health / var_0 * var_1;

    for (;;)
    {
        if ( !self.mechdata.regen_cooldown )
            self.mechdata.health = clamp( self.mechdata.health + var_2, 0, level.mech_max_health );

        self.mechdata.regen_cooldown = 0;
        wait(var_1);
    }
}

playermech_player_hit_fx()
{
    var_0 = "cg_hudDamageIconTime";
    var_1 = getdvar( var_0 );
    var_2 = 0;
    var_3 = 1;

    while ( self.mechdata.active )
    {
        if ( self.mechdata.health < 30 && !self.mechdata.damage_allowed )
        {
            self.mechdata.damage_allowed = 1;
            thread maps\_gameskill::healthoverlay();
            _func_0D3( var_0, var_1 );
        }
        else if ( var_3 || self.mechdata.health >= 30 && self.mechdata.damage_allowed )
        {
            var_3 = 0;
            self.mechdata.damage_allowed = 0;
            self _meth_8309( 0 );
            self notify( "noHealthOverlay" );
            _func_0D3( var_0, var_2 );
        }

        wait 0.05;
    }

    _func_0D3( var_0, var_1 );
}

playermech_health_restore()
{
    self _meth_80EC( 1 );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( !playermech_is_damage_allowed( var_0, var_4, var_1 ) )
        {
            self _meth_8050( self.health + var_0 );
            continue;
        }

        if ( self.health == 1 )
        {
            self _meth_80EC( 0 );

            if ( isdefined( var_9 ) )
            {
                self _meth_8051( 1, var_3, var_1, var_1, var_4, var_9 );
                continue;
            }

            self _meth_8051( 1, var_3, var_1, var_1, var_4 );
        }
    }
}

playermech_dodamage( var_0, var_1, var_2 )
{
    self _meth_8051( var_0, var_1, var_2 );
}

playermech_physics_push_on()
{
    self.physics_pulse_on = 1;
}

playermech_physics_push_off()
{
    self.physics_pulse_on = 0;
}

playermech_physics_push()
{
    self endon( "exit_mech" );
    playermech_physics_push_on();
    var_0 = 0.01;
    var_1 = 48;
    var_2 = 1;

    for (;;)
    {
        if ( self.physics_pulse_on )
        {
            var_3 = clamp( length( self getvelocity() ) * var_0, 0, var_2 );
            physicsexplosionsphere( self.origin, var_1, 1, var_3 );
        }

        wait 0.05;
    }
}

playermech_physics_push_finale()
{
    self endon( "exit_mech" );
    playermech_physics_push_on();
    var_0 = 24;

    for (;;)
    {
        if ( self.physics_pulse_on )
        {
            var_1 = var_0 * getdvarfloat( "mechStandHeight" ) / 90.0;
            physicsexplosionsphere( self.origin, var_1, var_1 * 0.9, 0.01 );
        }

        wait 0.05;
    }
}

playermech_invalid_gun_callback()
{
    if ( self.mechuistate.chaingun.overheated )
    {
        if ( self attackbuttonpressed() )
            self notify( "callback_chaingun_state_overheat" );

        return 1;
    }

    return 0;
}

playermech_invalid_rocket_callback()
{
    if ( self.mechuistate.rocket.recharge < 100 )
    {
        if ( self _meth_82EE() )
            self notify( "callback_rocket_reload" );

        return 1;
    }

    return 0;
}

playermech_invalid_swarm_callback()
{
    if ( self.mechuistate.swarm.recharge < 100 )
    {
        if ( self _meth_82EF() )
            self notify( "callback_swarm_reload" );

        return 1;
    }

    return 0;
}

playermech_invalid_weapon_instance( var_0, var_1 )
{
    self endon( "exit_mech" );
    var_2 = 0;

    for (;;)
    {
        wait 0.05;

        if ( self call [[ var_0 ]]() )
        {
            if ( !var_2 )
            {
                if ( [[ var_1 ]]() )
                {
                    var_2 = 1;
                    soundscripts\_snd::snd_message( "mech_weapon_offline" );
                }
            }

            continue;
        }

        var_2 = 0;
    }
}

playermech_invalid_weapon_watcher()
{
    thread playermech_invalid_weapon_instance( ::attackbuttonpressed, ::playermech_invalid_gun_callback );
    thread playermech_invalid_weapon_instance( ::_meth_82EE, ::playermech_invalid_rocket_callback );
    thread playermech_invalid_weapon_instance( ::_meth_82EF, ::playermech_invalid_swarm_callback );
}

playermech_chaingun_watcher()
{
    self endon( "exit_mech" );
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 _meth_80A6( level.player, "j_barrel", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );

    for (;;)
    {
        self waittill( "weapon_fired" );

        if ( self _meth_82EF() || self _meth_82EE() )
            continue;

        self notify( "chaingun_fired" );
        thread barrel_heat_glow_fx( var_0 );
    }

    common_scripts\utility::waittill_any_timeout( 0.5, "kill_barrel_vfx" );
    var_0 _meth_80A7( level.player );
    var_0 delete();
}

barrel_heat_glow_fx( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "exo_armor_gun_barrel_heat_view" ), var_0, "tag_origin" );
}

barrel_overheat_fx()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    waitframe();
    var_0 _meth_80A6( level.player, "j_barrel", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    waitframe();
    playfxontag( common_scripts\utility::getfx( "exo_armor_gun_barrel_overheat_view" ), var_0, "tag_origin" );
    common_scripts\utility::waittill_any_timeout( 4, "kill_barrel_vfx" );
    killfxontag( common_scripts\utility::getfx( "exo_armor_gun_barrel_overheat_view" ), var_0, "tag_origin" );
    var_0 _meth_80A7( level.player );
    waitframe();
    var_0 delete();
}

playermech_threat_paint( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    self.mechdata.swarm_target_list = [];
    thread threat_paint_highlight_hud_effect();
    var_2 = [];
    var_3 = _func_0D6( "axis" );

    foreach ( var_5 in var_3 )
    {
        var_6 = var_5 _meth_83EC();

        if ( !isdefined( var_6 ) || !isdefined( var_6.code_classname ) || var_6.code_classname != "script_vehicle" )
            var_2[var_2.size] = var_5;
    }

    var_8 = [];
    var_9 = maps\_utility::getvehiclearray();

    foreach ( var_11 in var_9 )
    {
        if ( isdefined( var_11.script_team ) && var_11.script_team == "axis" )
            var_8[var_8.size] = var_11;
    }

    var_13 = sortbydistance( common_scripts\utility::array_combine( var_2, var_8 ), self.origin );
    var_14 = anglestoforward( self getangles() );
    var_15 = 1;

    if ( var_14[2] > 0.99 )
        var_15 = 0;

    var_14 = vectornormalize( var_14 * ( 1, 1, 0 ) );
    var_16 = [];

    foreach ( var_5 in var_13 )
    {
        if ( !isdefined( var_5 ) || !isalive( var_5 ) )
            continue;

        var_5 notify( "stop_marking_guy" );
        unmark_swarm_target( var_5 );
        mark_stencil( var_5 );

        if ( var_15 )
        {
            var_18 = vectornormalize( ( var_5.origin - self.origin ) * ( 1, 1, 0 ) );

            if ( length( var_18 ) < 0.001 )
                continue;

            var_5.targetdot = vectordot( var_18, var_14 );

            if ( var_5.targetdot < 0.7 )
                continue;

            if ( !pass_line_of_sight( var_5 ) )
                continue;

            if ( var_16.size < level.mech_swarm_rocket_max_targets )
            {
                var_16[var_16.size] = var_5;
                continue;
            }

            var_19 = 0;

            for ( var_20 = 0; var_20 < var_16.size; var_20++ )
            {
                if ( var_16[var_20].targetdot < var_16[var_19].targetdot )
                    var_19 = var_20;
            }

            if ( var_5.targetdot > var_16[var_19].targetdot )
                var_16[var_19] = var_5;
        }
    }

    foreach ( var_5 in var_16 )
    {
        if ( var_0 )
        {
            thread handle_marking_guy( var_5 );
            continue;
        }

        thread handle_marking_guy( var_5, 1 );
    }

    wait 0.05;
}

pass_line_of_sight( var_0, var_1 )
{
    if ( level.mech_swarm_skip_line_of_sight_obstruction_test )
        return 1;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = self.origin;

    if ( isplayer( self ) )
        var_2 = self _meth_80A8();

    if ( var_1 )
    {
        if ( 1 )
        {
            var_3 = var_0.origin + var_0 get_guy_offset( 0 );
            var_4 = bullettrace( var_2, var_3, 1, self, 0, 1, 0 );

            if ( isdefined( var_4["entity"] ) && ( isdefined( var_4["entity"].script_team ) && var_4["entity"].script_team == "allies" ) )
                return 0;
        }

        if ( isdefined( var_0.swarm_los_lock_duration_endtime ) && gettime() < var_0.swarm_los_lock_duration_endtime )
            return 1;
    }

    var_0.swarm_los_body_behind_cover = undefined;
    var_0.swarm_los_overhead_blocked = undefined;
    var_5 = 0;
    var_3 = undefined;

    for ( var_6 = 0; var_6 < 2; var_6++ )
    {
        if ( var_6 == 0 )
            var_3 = var_0.origin + var_0 get_guy_offset( 0 );

        if ( var_6 == 1 )
            var_3 = var_0.origin + var_0 get_guy_offset( 1 );

        var_7 = ( randomfloatrange( -10.0, 10 ), randomfloatrange( -10.0, 10 ), randomfloatrange( -10.0, 10 ) );
        var_4 = bullettrace( var_2, var_3 + var_7, 0, self, 0, 0, 0 );

        if ( var_4["fraction"] >= 1 || isdefined( var_4["entity"] ) && var_0 != var_4["entity"] )
        {
            var_0.swarm_los_lock_duration_endtime = gettime() + level.mech_swarm_line_of_sight_lock_duration * 2000.0;
            var_5 = 1;
            continue;
        }

        if ( var_6 == 0 && distance2d( var_0.origin, var_4["position"] ) < 75 )
            var_0.swarm_los_body_behind_cover = 1;

        if ( var_6 == 1 )
            var_0.swarm_los_overhead_blocked = 1;
    }

    return var_5;
}

playermech_threat_paint_loop( var_0 )
{
    level endon( "flag_force_hud_ready" );
    self endon( "death" );
    self endon( "grenade_fire" );
    self endon( "scripted_viewmodel_anim" );

    for (;;)
    {
        if ( isdefined( var_0 ) && var_0 )
            self.mechuistate.swarm.threat_scan = 1;

        playermech_threat_paint( 1, 1 );
    }
}

playermech_threat_paint_ping_loop()
{
    self endon( "death" );
    self endon( "exit_mech" );

    for (;;)
    {
        if ( !common_scripts\utility::flag( "flag_mech_threat_paint_ping_on" ) || common_scripts\utility::flag( "internal_threat_paint_in_progress" ) )
        {
            wait 0.05;
            continue;
        }

        if ( common_scripts\utility::flag( "internal_swarm_rocket_active" ) )
        {
            common_scripts\utility::flag_waitopen( "internal_swarm_rocket_active" );
            wait 0;
            continue;
        }

        playermech_threat_paint( 0, 1 );
        wait 0;
    }
}

threat_paint_highlight_hud_effect()
{
    common_scripts\utility::flag_set( "internal_threat_paint_in_progress" );
    var_0 = newclienthudelem( self );
    var_0.color = ( 1, 0.05, 0.025 );
    var_0.alpha = 1.0;
    var_1 = 0.05;
    var_0 _meth_83A4( var_1 );
    wait(var_1);
    var_0 destroy();
    common_scripts\utility::flag_clear( "internal_threat_paint_in_progress" );
}

threat_paint_hud_effect()
{
    var_0 = newclienthudelem( self );
    var_0.x = self.origin[0];
    var_0.y = self.origin[1];
    var_0.z = self.origin[2];
    var_0.color = ( 1, 0.05, 0.025 );
    var_0.alpha = 1.0;
    var_1 = 0;
    var_2 = 3000;
    var_3 = 500;
    var_0 _meth_83A3( int( var_2 + var_3 / 2 ), int( var_3 ), var_1 + 0.05 );
    wait(var_1);
    var_0 destroy();
}

get_guy_offset( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = undefined;
    var_2 = self _meth_8096()[2] - self.origin[2];

    if ( !isdefined( self ) )
        var_1 = ( 0, 0, 32 );
    else if ( maps\_vehicle::isvehicle() )
        var_1 = ( 0, 0, var_2 );
    else if ( issubstr( self.classname, "mech" ) )
        var_1 = ( 0, 0, 64 );
    else
        var_1 = ( 0, 0, 32 );

    if ( var_0 == 1 )
        var_1 = var_1 + ( 0, 0, var_2 ) + ( 0, 0, 32 );
    else if ( var_0 == 2 )
    {
        if ( isdefined( self.swarm_los_overhead_blocked ) && self.swarm_los_overhead_blocked )
            var_1 = get_guy_offset( 0 );
        else
            var_1 = var_1 + ( 0, 0, var_2 ) + ( 0, 0, 30 );
    }
    else
    {

    }

    return var_1;
}

handle_marking_guy( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0 notify( "stop_marking_guy" );
    var_0 endon( "stop_marking_guy" );
    thread handle_threat_paint_death( var_0 );

    if ( isdefined( var_1 ) && var_1 )
        return;

    if ( distance( self.origin, var_0.origin ) > 3000 )
        return;

    self.mechdata.swarm_target_list = maps\_utility::remove_dead_from_array( self.mechdata.swarm_target_list );

    if ( self.mechdata.swarm_target_list.size >= level.mech_swarm_rocket_max_targets )
        return;

    var_2 = var_0 get_guy_offset( 0 );
    var_3 = 0.4;

    if ( isdefined( self.mechdata.swarm_dot_override ) )
        var_3 = self.mechdata.swarm_dot_override;

    if ( !maps\_utility::player_looking_at( var_0.origin + var_2, var_3, 1 ) )
    {
        var_4 = bullettrace( self _meth_80A8(), var_0.origin + var_2, 0 );

        if ( !isdefined( var_4 ) || !isdefined( var_4["position"] ) )
            return;
    }

    if ( !pass_line_of_sight( var_0 ) )
        return;

    if ( common_scripts\utility::flag( "flag_force_hud_ready" ) )
        return;

    mark_swarm_target( var_0 );
    var_5 = 2;

    while ( maps\_utility::player_looking_at( var_0.origin + var_2, var_3, 1 ) && !common_scripts\utility::flag( "flag_force_hud_ready" ) )
    {
        wait(var_5);

        if ( distance( self.origin, var_0.origin ) > 3000 )
            return;

        if ( !pass_line_of_sight( var_0 ) )
            break;

        if ( !self _meth_82EF() || !self _meth_84E0() )
            break;
    }

    unmark_swarm_target( var_0 );
}

mark_stencil( var_0 )
{
    if ( isdefined( var_0.disablestencil ) && var_0.disablestencil || isdefined( var_0.script_parameters ) && var_0.script_parameters == "disablestencil" )
        return;

    if ( isdefined( var_0 ) && isalive( var_0 ) && ( !isdefined( var_0.target_stencil ) || !var_0.target_stencil ) )
    {
        var_0.target_stencil = 1;

        if ( 1 )
            var_0 _meth_83FA( 4, 1 );
        else
            var_0 _meth_84ED( "detected" );

        self.mechdata.threat_list = common_scripts\utility::array_add( self.mechdata.threat_list, var_0 );
    }
}

unmark_stencil( var_0 )
{
    if ( isdefined( var_0.target_stencil ) && var_0.target_stencil )
    {
        var_0.target_stencil = undefined;

        if ( 1 )
        {
            var_0 _meth_83FB();
            var_0 _meth_83FA( 0, 0 );
        }
        else
            var_0 _meth_84ED( "enhanceable" );

        self.mechdata.threat_list = common_scripts\utility::array_remove( self.mechdata.threat_list, var_0 );
    }
}

mark_swarm_target( var_0 )
{
    if ( isdefined( var_0 ) && isalive( var_0 ) && ( !isdefined( var_0.target_swarm ) || !var_0.target_swarm ) )
    {
        var_0.target_swarm = 1;
        var_1 = var_0 get_guy_offset( 0 );
        _func_09A( var_0, var_1 );
        _func_09C( var_0, "ui_playermech_icon_swarm_target" );
        self.mechdata.swarm_target_list = common_scripts\utility::array_add( self.mechdata.swarm_target_list, var_0 );
        wait 0.05;
    }
}

unmark_swarm_target( var_0 )
{
    if ( isdefined( var_0.target_swarm ) && var_0.target_swarm )
        self.mechdata.swarm_target_list = common_scripts\utility::array_remove( self.mechdata.swarm_target_list, var_0 );

    var_0.target_swarm = undefined;

    if ( _func_0A3( var_0 ) )
        _func_09B( var_0 );
}

handle_threat_paint_death( var_0 )
{
    var_0 notify( "handle_threat_paint_death" );
    var_0 endon( "handle_threat_paint_death" );
    var_0 waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        var_0 notify( "stop_marking_guy" );
        unmark_stencil( var_0 );
        unmark_swarm_target( var_0 );
        var_0 _meth_84ED( "disable" );
    }
}

playermech_disable_badplace()
{
    self.mechdata.create_badplace = 0;
}

playermech_enable_badplace()
{
    self.mechdata.create_badplace = 1;
}

playermech_badplace()
{
    self endon( "exit_mech" );

    for (;;)
    {
        if ( self.mechdata.create_badplace )
            badplace_cylinder( "mech", 1, self.origin, 128, 256, "axis" );

        wait 0.05;
    }
}

playermech_rockets_wait_swarm()
{
    self endon( "scripted_viewmodel_anim" );
    level endon( "flag_force_hud_ready" );
    self waittill( "grenade_fire", var_0, var_1 );
    self notify( "mech_swarm_fire" );
    self notify( "stop_delay_thread" );
    thread rocket_swarm();
    var_0 delete();
}

playermech_rockets_wait_rocket()
{
    self endon( "scripted_viewmodel_anim" );
    level endon( "flag_force_hud_ready" );
    self waittill( "grenade_fire", var_0, var_1 );
    self notify( "mech_rocket_fire", var_0 );
    thread rocket_fire_rumbles();
}

rocket_fire_rumbles()
{
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );
    var_0.intensity = 0.8;
    wait 0.2;
    var_0.intensity = 0.0;
}

playermech_rockets_and_swarm_watcher()
{
    self endon( "exit_mech" );

    for (;;)
    {
        self waittill( "grenade_pullback", var_0 );

        if ( common_scripts\utility::flag( "flag_force_hud_ready" ) )
            continue;

        if ( var_0 == self.mechdata.weapon_names["mech_lethal_weapon"] )
        {
            common_scripts\utility::flag_set( "internal_rocket_active" );
            self notify( "mech_rocket_pullback" );
            playermech_rockets_wait_rocket();
            maps\_utility::delaythread( 0.75, common_scripts\utility::flag_clear, "internal_rocket_active" );
        }
        else if ( var_0 == self.mechdata.weapon_names["mech_tactical_weapon"] )
        {
            common_scripts\utility::flag_set( "internal_swarm_rocket_active" );
            self notify( "mech_swarm_pullback" );
            maps\_utility::delaythread( level.mech_threat_paint_delay, ::playermech_threat_paint_loop, 1 );
            playermech_rockets_wait_swarm();
            maps\_utility::delaythread( 0.75, common_scripts\utility::flag_clear, "internal_swarm_rocket_active" );
        }

        maps\_utility::delaythread( 2, ::playermech_ui_turn_off_threat_count );
        wait 0.05;
    }
}

mech_rocket_clear( var_0 )
{
    wait 1;
    common_scripts\utility::flag_clear( var_0 );
}

playermech_ui_turn_off_threat_count()
{
    self.mechuistate.swarm.threat_scan = 0;
}

rocket_swarm_random_course_change()
{
    self endon( "death" );
    self endon( "rocket_start_swarm_stage_two" );

    for (;;)
    {
        var_0 = 1;
        var_1 = 0.2;
        self.forward = vectornormalize( self.forward + ( randomfloatrange( var_0 * -1.0, var_0 ), randomfloatrange( var_0 * -1.0, var_0 ), randomfloatrange( var_1 * -1.0, var_1 ) ) );
        var_2 = randomfloatrange( 0.1, 0.4 );
        wait(var_2);
    }
}

rocket_swarm_get_height_offset( var_0 )
{
    if ( isdefined( level.mech_swarm_use_two_stage_swarm ) && level.mech_swarm_use_two_stage_swarm )
        return var_0 get_guy_offset( 2 );
    else
        return var_0 get_guy_offset( 0 );
}

rocket_swarm_target_course_change( var_0 )
{
    self endon( "death" );
    self endon( "rocket_start_swarm_stage_two" );

    for (;;)
    {
        var_1 = var_0.origin + rocket_swarm_get_height_offset( var_0 );
        self.forward = vectornormalize( var_1 - self.origin );
        wait 0.05;
    }
}

rocket_swarm_linear_think( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "rocket_start_swarm_stage_two" );
    self.forward = var_0;

    if ( var_1 )
        thread rocket_swarm_random_course_change();

    if ( isdefined( var_2 ) )
        thread rocket_swarm_target_course_change( var_2 );

    for (;;)
    {
        var_3 = self.origin;
        self.origin += self.forward * 150;
        wait 0.05;
    }
}

rocket_two_stage_swarm_think( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level.mech_swarm_use_two_stage_swarm ) || !level.mech_swarm_use_two_stage_swarm )
        return;

    var_4 = undefined;
    var_5 = undefined;
    var_6 = var_1.origin;

    while ( isvalidmissile( var_0 ) )
    {
        if ( isdefined( var_1 ) )
            var_7 = var_1.origin;
        else
            var_7 = var_6;

        var_8 = level.mech_swarm_two_stage_swarm_homing_distance;
        var_9 = level.mech_swarm_two_stage_swarm_homing_strength;

        if ( isdefined( var_1.swarm_los_body_behind_cover ) && var_1.swarm_los_body_behind_cover )
        {
            var_8 = 100;
            var_9 = 10000;
        }

        if ( distance2d( var_0.origin, var_7 ) < var_8 || isdefined( var_0.pathing_done ) && var_0.pathing_done )
        {
            if ( isdefined( var_2 ) )
            {
                var_2 notify( "rocket_start_swarm_stage_two" );
                var_2.origin = var_1.origin + var_1 get_guy_offset( 0 );
                var_2 _meth_804D( var_1 );
            }

            if ( isdefined( var_1 ) )
                var_4 = missile_createattractorent( var_1, var_9, 100000, var_0, 1, var_1 get_guy_offset( 0 ) );

            break;
        }

        if ( isdefined( var_1 ) )
            var_6 = var_1.origin;

        waitframe();
    }

    if ( isvalidmissile( var_0 ) )
    {
        var_10 = gettime() + 2000;

        while ( isvalidmissile( var_0 ) && gettime() < var_10 )
        {
            if ( !isdefined( var_1 ) )
            {
                var_5 = missile_createattractororigin( var_6, 500000, 100000, var_0, 1 );
                wait 2;
                missile_deleteattractor( var_5 );
                break;
            }

            var_6 = var_1.origin;
            waitframe();
        }
    }

    if ( isdefined( var_4 ) )
        missile_deleteattractor( var_4 );
}

rocket_swarm_iterate_next_node( var_0, var_1, var_2, var_3 )
{
    self endon( "rocket_start_swarm_stage_two" );
    self endon( "death" );

    for (;;)
    {
        var_4 = var_2[var_3];
        var_5 = var_4.origin + rocket_swarm_get_height_offset( var_0 );
        var_6 = anglestoforward( var_1.angles );
        var_7 = vectornormalize( var_5 - var_1.origin );
        var_8 = vectordot( var_6, var_7 );

        if ( var_8 >= 0.7 )
        {
            if ( var_3 == var_2.size - 1 )
                self.origin = var_0.origin;
            else
                self.origin = var_5;

            return var_3;
        }

        var_3++;

        if ( var_3 == var_2.size )
        {
            self.origin = var_0.origin;
            return var_3;
        }
    }
}

rocket_swarm_should_path( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) || var_1.size <= 1 )
        return 0;

    if ( abs( var_2 - var_0.origin[2] ) > 80 )
        return 0;

    return 1;
}

rocket_swarm_path_think( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_1 endon( "death" );
    var_0 endon( "death" );

    if ( !isdefined( self ) || !isdefined( self.origin ) || !isdefined( var_0 ) )
        return;

    if ( !isalive( var_0 ) )
        return;

    if ( !isdefined( var_0 ) )
        return;

    var_4 = var_0.origin;

    if ( var_3 )
    {
        var_5 = 50.0;
        var_4 += ( randomfloatrange( var_5 * -1.0, var_5 ), randomfloatrange( var_5 * -1.0, var_5 ), 0 );
    }

    var_6 = _func_200( self.origin, var_4 );

    if ( !rocket_swarm_should_path( var_0, var_6, var_2 ) )
    {
        var_4 += rocket_swarm_get_height_offset( var_0 );
        var_7 = vectornormalize( var_4 - self.origin );

        if ( var_3 )
        {
            var_8 = 0.2;
            var_7 = vectornormalize( var_7 + ( randomfloatrange( var_8 * -1.0, var_8 ), randomfloatrange( var_8 * -1.0, var_8 ), randomfloatrange( var_8 * -1.0, var_8 ) ) );
            thread rocket_swarm_linear_think( var_7, 0, undefined );
        }
        else
        {
            thread rocket_swarm_linear_think( var_7, 0, var_0 );
            thread rocket_two_stage_swarm_think( var_1, var_0, self, 0 );
        }

        return;
    }
    else
    {
        thread rocket_swarm_path_node_think( var_0, var_1, var_6, var_4 );
        thread rocket_two_stage_swarm_think( var_1, var_0, self, 1 );
    }
}

rocket_swarm_path_node_think( var_0, var_1, var_2, var_3 )
{
    self endon( "rocket_start_swarm_stage_two" );
    var_4 = 0;

    while ( isdefined( self ) )
    {
        var_5 = self.origin;
        var_4 = rocket_swarm_iterate_next_node( var_0, var_1, var_2, var_4 );
        var_6 = -5;

        if ( self.origin[2] - var_5[2] < var_6 )
            self.origin = ( self.origin[0], self.origin[1], var_5[2] + var_6 );

        if ( var_4 == var_2.size )
            break;

        wait 0.05;
    }

    if ( isdefined( var_1 ) )
        var_1.pathing_done = 1;
}

rocket_swarm_start_position( var_0, var_1 )
{
    var_2 = level.mech_swarm_rocket_max_targets + level.mech_swarm_rocket_dud_max_count;
    var_3 = 15;
    var_4 = 80;
    var_5 = var_4 / 2;
    var_6 = var_2 / 2;
    var_7 = var_4 / var_6;
    var_8 = ( 150, 60, 10 );

    if ( var_1 == 0 )
        var_8 *= ( 0, 1, 1 );

    if ( var_1 >= var_6 )
    {
        var_8 += ( 0, 0, var_3 );
        var_1 -= var_6;
    }
    else
        var_8 -= ( 0, 0, var_3 );

    var_8 += ( 0, var_7 * var_1 - var_5, 0 );
    var_9 = var_0 + rotatevector( var_8, self getangles() );
    return var_9;
}

rocket_swarm_death_thread( var_0, var_1, var_2 )
{
    var_0 endon( "death" );

    if ( isdefined( var_1 ) )
        var_1 endon( "death" );

    for (;;)
    {
        if ( isdefined( var_1 ) && distance( var_0.origin, var_1.origin ) < 64 )
        {
            var_2 unmark_swarm_target( var_1 );
            radiusdamage( var_1.origin, 128, 300, 300, var_2 );

            if ( issubstr( var_1.classname, "pdrone" ) )
            {
                var_1 notify( "death", var_2, "MOD_MECH_SWARM_DESTROY" );
                var_1 _meth_8052();
            }

            var_0 delete();
        }

        wait 0.05;
    }
}

rocket_swarm_create_and_manage_attractor( var_0, var_1, var_2 )
{
    self.origin = var_0.origin;
    missile_createattractorent( self, 5000, 100000, var_0, 1 );
    rocket_swarm_death_thread( var_0, var_1, var_2 );
    self delete();
}

rocket_swarm_straight_rocket( var_0, var_1, var_2, var_3 )
{
    var_4 = rocket_swarm_start_position( var_0, var_2 );
    var_5 = magicbullet( self.mechdata.weapon_names["mech_swarm_rocket"], var_4, var_4 + var_1 * 1000.0, self );
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6 thread rocket_swarm_create_and_manage_attractor( var_5, undefined, self );
    var_6 thread rocket_swarm_linear_think( var_1, var_3 );
}

rocket_swarm()
{
    thread rocket_swarm_fired_rumbles();
    var_0 = self _meth_80A8();
    var_1 = vectornormalize( anglestoforward( self getangles() ) );

    if ( 0 )
    {
        var_2 = sortbydistance( _func_0D6( "axis" ), self.origin );
        var_3 = get_front_sorted_threat_list( var_2, var_1 );
    }
    else
        var_3 = maps\_utility::remove_dead_from_array( self.mechdata.swarm_target_list );

    var_4 = 0;
    var_5 = 0;

    if ( var_3.size == 0 )
    {
        rocket_swarm_straight_rocket( var_0, var_1, var_4, 0 );
        var_4++;
        wait 0.05;
    }

    var_6 = 0;

    while ( var_3.size && var_4 < level.mech_swarm_rocket_max_targets )
    {
        var_3 = maps\_utility::remove_dead_from_array( var_3 );

        if ( var_3.size == 0 )
            break;

        foreach ( var_8 in var_3 )
        {
            if ( !isalive( var_8 ) )
                break;

            var_9 = rocket_swarm_start_position( var_0, var_4 );
            var_10 = rocket_swarm_end_position( var_9, var_8 );
            var_11 = magicbullet( self.mechdata.weapon_names["mech_swarm_rocket"], var_9, var_10, self );

            if ( isai( var_8 ) && _func_0A3( var_8 ) )
                _func_09C( var_8, "ui_playermech_icon_swarm_target" );

            var_12 = common_scripts\utility::spawn_tag_origin();
            var_12 thread rocket_swarm_create_and_manage_attractor( var_11, var_8, self );
            var_12 thread rocket_swarm_path_think( var_8, var_11, self.origin[2], var_6 );
            var_4++;

            if ( var_4 >= level.mech_swarm_rocket_max_targets )
                break;

            wait 0.05;
        }

        var_5++;

        if ( var_3.size == 1 )
        {
            if ( var_4 == 2 )
                var_6 = 1;

            continue;
        }

        if ( var_5 >= level.mech_swarm_number_of_rockets_per_target )
            var_6 = 1;
    }

    var_14 = randomintrange( level.mech_swarm_rocket_dud_min_count, level.mech_swarm_rocket_dud_max_count + 1 );

    for ( var_15 = var_14 + level.mech_swarm_rocket_max_targets; var_4 < var_15; var_4++ )
    {
        rocket_swarm_straight_rocket( var_0, var_1, var_4, 1 );
        wait 0.05;
    }
}

rocket_swarm_end_position( var_0, var_1 )
{
    if ( isdefined( level.mech_swarm_use_two_stage_swarm ) && level.mech_swarm_use_two_stage_swarm )
        return var_1.origin + get_guy_offset( 2 );

    var_2 = vectornormalize( var_1.origin - var_0 );
    return var_0 + var_2 * 1000.0;
}

rocket_swarm_fired_rumbles()
{
    var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble", 0.0 );
    var_0.intensity = 0.4;
    wait 0.1;
    var_0.intensity = 0.6;
    wait 0.1;
    var_0.intensity = 0.8;
    wait 0.1;
    var_0.intensity = 1.0;
    wait 0.1;
    var_0.intensity = 0.0;
}

hide_mech_glass_static_overlay( var_0 )
{
    foreach ( var_2 in level.player.mechdata.dmg_screen_right )
        var_0 _meth_8048( var_2.bone );

    foreach ( var_2 in level.player.mechdata.dmg_screen_left )
        var_0 _meth_8048( var_2.bone );
}

scripted_screen_flicker_loop( var_0 )
{
    self notify( "kill_duplicate_scripted_screen_flicker_loop" );
    self endon( "death" );
    self endon( "kill_duplicate_scripted_screen_flicker_loop" );
    var_1 = -1.0;

    if ( isstring( var_0 ) )
        self endon( var_0 );
    else if ( isdefined( var_0 ) )
        var_1 = gettime() + var_0 * 1000;

    screen_flicker( undefined, 0 );
    wait 0.1;
    screen_flicker( undefined, 0 );
    wait 0.2;
    screen_flicker( undefined, 0 );

    while ( !isdefined( var_0 ) || gettime() < var_1 )
    {
        screen_flicker( undefined, 1 );
        wait 2;
    }
}

unlimited_mech_ammo()
{
    self endon( "exit_mech" );

    for (;;)
    {
        foreach ( var_1 in self _meth_830B() )
            level.player _meth_82F7( var_1, _func_1E1( var_1 ) );

        wait 5;
    }
}

aud_playermech_start()
{
    if ( !isdefined( level.player.audio.mech_amb ) || level.player.audio.mech_amb == 0 )
    {
        level.player soundscripts\_snd_playsound::snd_play_loop_2d( "mech_suit_cockpit_plr", "stop_playermech_cockpit", 3, 2 );
        level.player.audio.mech_amb = 1;
    }

    level.player.audio.mech_steps = 1;
    soundscripts\_audio_mix_manager::mm_add_submix( "player_mech" );
}

aud_playermech_end()
{
    soundscripts\_audio_mix_manager::mm_clear_submix( "player_mech" );
    level.player.audio.mech_steps = 0;
    level.player.audio.mech_amb = 0;
    level notify( "stop_playermech_cockpit" );
}

aud_playermech_foley_override_handler()
{
    level.player endon( "death" );

    if ( !isdefined( level.player.audio ) )
        level.player.audio = spawnstruct();

    if ( !isdefined( level.player.audio.mech_steps ) )
        level.player.audio.mech_steps = 0;

    level.player waittill( "playermech_start" );

    for (;;)
    {
        level.player waittill( "foley", var_0, var_1, var_2 );

        switch ( var_0 )
        {
            case "walk":
                if ( level.player.audio.mech_steps == 1 )
                {

                }

                break;
            case "run":
                if ( level.player.audio.mech_steps == 1 )
                {

                }

                break;
            case "sprint":
                if ( level.player.audio.mech_steps == 1 )
                {

                }

                break;
            case "jump":
                if ( level.player.audio.mech_steps == 1 )
                    soundscripts\_snd_playsound::snd_play_2d( "mech_jump_plr" );

                break;
            case "lightland":
                if ( level.player.audio.mech_steps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "mech_walk_plr" );
                    soundscripts\_snd_playsound::snd_play_2d( "mech_run_plr" );
                }

                break;
            case "mediumland":
                if ( level.player.audio.mech_steps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "mech_walk_plr" );
                    soundscripts\_snd_playsound::snd_play_2d( "mech_run_plr" );
                }

                break;
            case "heavyland":
                if ( level.player.audio.mech_steps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "mech_walk_plr" );
                    soundscripts\_snd_playsound::snd_play_2d( "mech_run_plr" );
                }

                break;
            case "damageland":
                if ( level.player.audio.mech_steps == 1 )
                {
                    soundscripts\_snd_playsound::snd_play_2d( "mech_walk_plr" );
                    soundscripts\_snd_playsound::snd_play_2d( "mech_run_plr" );
                }

                break;
            case "stationarycrouchscuff":
                break;
            case "stationaryscuff":
                break;
            case "crouchscuff":
                break;
            case "runscuff":
                break;
            case "sprintscuff":
                break;
            case "prone":
                break;
            case "crouchwalk":
                break;
            case "crouchrun":
                break;
            case "mantleuphigh":
                break;
            case "mantleupmedium":
                break;
            case "mantleuplow":
                break;
            case "mantleoverhigh":
                break;
            case "mantleovermedium":
                break;
            case "mantleoverlow":
                break;
        }
    }
}
