// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    precachemodel( "vehicle_vm_x4walkerSplit_wheels" );
    precachemodel( "vehicle_vm_x4walkerSplit_turretClosed" );
    precachemodel( "projectile_rpg7" );
    precachemodel( "viewbody_sentinel_covert" );
    precacheshader( "bls_ui_turret_targetlock" );
    precacheshader( "bls_ui_turret_targetlock_white" );
    precacheshader( "bls_ui_turret_targetacquired" );
    precacheitem( "mobile_turret_missile" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacheshader( "bls_ui_turret_overlay_sm" );
    precacheshader( "bls_ui_turret_reticle_tl" );
    precacheshader( "bls_ui_turret_reticle_tr" );
    precacheshader( "bls_ui_turret_reticle_bl" );
    precacheshader( "bls_ui_turret_reticle_br" );
    precacheshader( "bls_ui_turret_reticule_hpip" );
    precacheshader( "bls_ui_turret_reticule_vpip" );
    precacheshader( "bls_ui_turret_warning" );
    precacheshader( "remote_chopper_hud_target_enemy" );
    precacheshader( "remote_chopper_hud_target_friendly" );
    precachestring( &"_X4WALKER_WHEELS_ENTER" );
    precachestring( &"_X4WALKER_WHEELS_EXIT" );
    precachestring( &"_X4WALKER_WHEELS_MELEE_HINT" );
    precachestring( &"_X4WALKER_WHEELS_N" );
    precachestring( &"_X4WALKER_WHEELS_S" );
    precachestring( &"_X4WALKER_WHEELS_E" );
    precachestring( &"_X4WALKER_WHEELS_W" );
    maps\_utility::add_control_based_hint_strings( "x4walker_melee_hint", &"_X4WALKER_WHEELS_MELEE_HINT", ::should_hide_melee_hint );
    maps\_utility::add_hint_string( "x4walker_immune_to_bullets", &"_X4WALKER_WHEELS_BULLETS_DONTHURT_VEHICLE", ::should_hide_bullet_immunity_hint );
    maps\_utility::add_hint_string( "x4walker_immune_to_em1", &"_X4WALKER_WHEELS_EM1_DOESNTHURT_VEHICLE", ::should_hide_bullet_immunity_hint );
    maps\_utility::add_hint_string( "x4walker_turret_hint", &"_X4WALKER_WHEELS_TURRET_HINT", ::should_hide_turret_hint );
    maps\_utility::add_hint_string( "x4walker_missiles_hint", &"_X4WALKER_WHEELS_MISSILES_HINT", ::should_hide_missiles_hint );
    maps\_utility::set_console_status();
    maps\_vehicle::build_template( "x4walker_wheels_turret_closed", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::local_init );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_shoot_shock( "mobile_turret_shoot" );
    maps\_vehicle::build_aianims( ::set_ai_anims );
    maps\_vehicle::build_idle( %x4walker_wheels_turret_idle );
    maps\_vehicle::build_drive( %x4walker_wheels_drive_idle, %x4walker_wheels_drive_idle, 3.36 );
    maps\_vehicle::build_treadfx();
    build_walker_death( var_2 );
    maps\_vehicle::build_turret( "x4walker_turret_closed", "tag_turret", "vehicle_npc_x4walkersplit_turretClosed", undefined, "manual" );
    register_vehicle_anims( var_2 );
    register_player_anims( var_2 );
    register_ai_anims( var_2 );
    register_fx();
}

build_walker_death( var_0 )
{
    level._effect["walkerexplode"] = loadfx( "vfx/explosion/vehicle_x4walker_explosion" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_x4walker_explosion", "tag_body" );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

register_vehicle_anims( var_0 )
{
    maps\_vehicle_shg::add_vehicle_anim( var_0, "idle", %x4walker_wheels_turret_idle );
    maps\_vehicle_shg::add_vehicle_anim( var_0, "cockpit_idle", %x4walker_wheels_turret_cockpit_idle );
    level.scr_animtree[var_0] = #animtree;
    level.scr_anim[var_0]["roof_kill"] = %x4walkersplit_grapple_turret;
}

register_fx()
{
    level._effect["exo_rocket_trail"] = loadfx( "fx/test/test_smoke_geotrail_exo_rocket" );
    level._effect["exo_rocket_explosion"] = loadfx( "fx/explosions/rpg_wall_impact" );
    level._effect["x4walker_wheels_rpg_fv"] = loadfx( "vfx/muzzleflash/x4walker_wheels_rpg_fv" );
}

local_init()
{
    self _meth_8115( #animtree );
    thread manage_player_using_mobile_turret();
    thread monitor_vehicle_mount();
    thread animation_think();
    thread monitor_wheel_movements();
    thread clean_up_vehicle();
    maps\_utility::ent_flag_init( "player_in_transition" );
    waittillframeend;
    self.bullet_resistance = 99999999;
    thread maps\_damagefeedback::monitordamage();
    thread monitor_roof_use_trigger();
    self.mgturret[0] _meth_8136();
    self.mgturret[0] _meth_8115( #animtree );
    thread monitor_player_rip_off_roof();
    thread monitor_player_melee();
    thread monitor_player_grapple();
    thread monitor_turret_damage();
    thread monitor_base_damage();
    thread monitor_turret_death_spawn_dmg();
    thread monitor_bullet_damage();
    self.magnetoptions = spawnstruct();
    self.magnetoptions.ignorecollision = 0;
    self.magnetoptions.forcestyle = "floor";
    self.magnetoptions.distmin = 256;
    self.magnetoptions.noenableweapon = 1;
    self.magnetoptions.landhiderope = 1;
    maps\_grapple::grapple_magnet_register( self.mgturret[0], "tag_grapple_front", ( 5, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
    maps\_grapple::grapple_magnet_register( self.mgturret[0], "tag_grapple_left", ( 8, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
    maps\_grapple::grapple_magnet_register( self.mgturret[0], "tag_grapple_back", ( 18, 0, -1 ), "grapple_turret", undefined, self.magnetoptions );
    maps\_grapple::grapple_magnet_register( self.mgturret[0], "tag_grapple_right", ( 8, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
    self notify( "stop_vehicle_shoot_shock" );
    vehicle_scripts\_x4walker_wheels_turret_closed_aud::snd_init_x4_walker_wheels_turret_closed();
}

monitor_turret_death_spawn_dmg()
{
    self waittill( "death" );
    soundscripts\_snd_playsound::snd_play( "exp_generic_explo_shot_08" );
    var_0 = self gettagorigin( "tag_body" );
    badplace_cylinder( "turret_dest_bplace", 0, var_0, 64, 64, "allies", "axis", "neutral", "team3" );
    var_1 = spawn( "trigger_radius", var_0, 0, 32, 48 );

    for (;;)
    {
        var_1 waittill( "trigger", var_2 );
        level.player _meth_8051( 5, var_0 );
        wait(randomfloat( 1.0 ));
    }
}

#using_animtree("generic_human");

set_ai_anims()
{
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].sittag = "tag_guy";
    var_0[0].sittag_on_turret = 1;
    var_0[0].death = %x4walker_wheels_death_left_npc;
    var_0[0].mgturret = 0;
    var_0[0].idle = %x4walker_wheels_idle_npc;
    var_0[0].drive = %x4walker_wheels_drive_idle_npc;
    var_0[0].bhasgunwhileriding = 0;
    return var_0;
}

register_ai_anims( var_0 )
{
    level.scr_animtree[var_0 + "_guy"] = #animtree;
    level.scr_anim[var_0 + "_guy"]["roof_kill"] = %grapple_x4walker;
    level.scr_goaltime[var_0 + "_guy"]["roof_kill"] = 0.0;
}

#using_animtree("player");

register_player_anims( var_0 )
{
    level.scr_animtree["_vehicle_player_rig"] = #animtree;
    level.scr_anim["_vehicle_player_rig"]["roof_kill"] = %vm_grapple_x4walker;
    level.scr_anim["_vehicle_player_rig"]["enter_left_turret"] = %x4walker_turret_cockpit_in_l_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_right_turret"] = %x4walker_turret_cockpit_in_r_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_back_turret"] = %x4walker_turret_cockpit_in_b_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_left_turret"] = %x4walker_turret_cockpit_out_l_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_right_turret"] = %x4walker_turret_cockpit_out_r_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_back_turret"] = %x4walker_turret_cockpit_out_b_vm;
    level.scr_anim["_vehicle_player_rig"]["mount_left"] = %vm_grapple_x4walker_in_l;
    level.scr_anim["_vehicle_player_rig"]["mount_right"] = %vm_grapple_x4walker_in_r;
    level.scr_anim["_vehicle_player_rig"]["mount_back"] = %vm_grapple_x4walker_in_b;
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_left_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_right_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_back_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_left_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_right_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_back_turret" );
}

should_hide_melee_hint()
{
    return isdefined( level.hide_x4walker_melee_hint ) && level.hide_x4walker_melee_hint;
}

should_hide_bullet_immunity_hint()
{
    return 0;
}

should_hide_turret_hint()
{
    return !isdefined( level.player.drivingvehicleandturret );
}

should_hide_missiles_hint()
{
    return !isdefined( level.player.drivingvehicleandturret );
}

monitor_bullet_damage()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = 0;
    self.script_bulletshield = 1;
    self.script_grenadeshield = 1;
    self.script_ai_invulnerable = 1;

    for (;;)
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( var_3 == level.player )
        {
            if ( var_6 == "BULLET" || var_6 == "MOD_RIFLE_BULLET" || var_6 == "MOD_PISTOL_BULLET" )
            {
                if ( issubstr( tolower( var_11 ), "em1" ) )
                {
                    if ( !var_1 )
                    {
                        level.player thread maps\_utility::display_hint_timeout( "x4walker_immune_to_em1", 3 );
                        var_1 = 1;
                    }
                }
                else if ( !var_0 )
                {
                    level.player thread maps\_utility::display_hint_timeout( "x4walker_immune_to_bullets", 3 );
                    var_0 = 1;
                }

                continue;
            }

            if ( var_11 == "boost_slam_sp" )
            {
                if ( self.currenthealth <= self.health )
                    self.currenthealth += var_2;

                self.health = self.currenthealth;
            }
        }
    }
}

monitor_turret_damage()
{
    self endon( "death" );
    self.mgturret[0] _meth_82C0( 1 );
    self.mgturret[0].maxhealth = 999999999;
    self.mgturret[0].health = self.mgturret[0].maxhealth;

    while ( isdefined( self ) && isdefined( self.mgturret ) && self.mgturret.size > 0 && isdefined( self.mgturret[0] ) )
    {
        self.mgturret[0] waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        self.mgturret[0].health = self.mgturret[0].maxhealth;

        if ( isdefined( var_9 ) )
        {
            self _meth_8051( var_0, var_3, var_1, var_1, var_4, var_9 );
            continue;
        }

        self _meth_8051( var_0, var_3, var_1, var_1, var_4 );
    }
}

monitor_base_damage()
{
    self endon( "death" );

    while ( !isdefined( self.base ) )
        wait 0.05;

    self.base _meth_82C0( 1 );
    self.base.maxhealth = 999999999;
    self.base.health = self.base.maxhealth;

    while ( isdefined( self ) && isdefined( self.base ) )
    {
        self.base waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        self.base.health = self.base.maxhealth;

        if ( isdefined( var_9 ) )
        {
            self _meth_8051( var_0, var_3, var_1, var_1, var_4, var_9 );
            continue;
        }

        self _meth_8051( var_0, var_3, var_1, var_1, var_4 );
    }
}

monitor_roof_use_trigger()
{
    self endon( "death" );
    self.roof_use_trigger = spawn( "trigger_radius", self.mgturret[0].origin + ( 0, 0, 24 ), 0, 72, 30 );
    self.roof_use_trigger _meth_8069();
    self.roof_use_trigger _meth_804D( self.mgturret[0] );

    for (;;)
    {
        self.roof_use_trigger waittill( "trigger", var_0 );

        if ( var_0 == level.player && level.player _meth_8341() )
        {
            for (;;)
            {
                if ( !level.player _meth_80A9( self.roof_use_trigger ) )
                {
                    self.enter_use_tags[3].origin = level.player.origin + ( 0, 0, 60 ) + anglestoforward( level.player.angles ) * 6;
                    break;
                }

                wait 0.05;
            }
        }
    }
}

manage_player_using_mobile_turret()
{
    self endon( "death" );
    thread handle_vehicle_dof();
    self.enter_use_tags = [];

    for ( var_0 = 0; var_0 < 4; var_0++ )
    {
        var_1 = spawn( "script_model", ( 0, 0, 0 ) );
        var_1 _meth_80B1( "tag_origin" );
        var_1 hide();
        self.enter_use_tags[var_0] = var_1;
    }

    var_2 = self gettagorigin( "tag_body" );
    var_3 = self gettagorigin( "tag_wheel_front_left" );
    var_4 = self gettagorigin( "tag_wheel_front_right" );
    var_5 = self gettagorigin( "tag_wheel_back_left" );
    var_6 = self gettagorigin( "tag_wheel_back_right" );
    self.enter_use_tags[0].origin = ( ( var_3[0] + var_5[0] ) * 0.5, ( var_3[1] + var_5[1] ) * 0.5, var_2[2] );
    self.enter_use_tags[1].origin = ( ( var_4[0] + var_6[0] ) * 0.5, ( var_4[1] + var_6[1] ) * 0.5, var_2[2] );
    self.enter_use_tags[2].origin = ( ( var_5[0] + var_6[0] ) * 0.5, ( var_5[1] + var_6[1] ) * 0.5, var_2[2] );
    self.enter_use_tags[3].origin = var_2 + ( 0, 0, 120 );

    foreach ( var_1 in self.enter_use_tags )
    {
        var_1 _meth_804D( self );
        var_1 _meth_80DB( &"_X4WALKER_WHEELS_ENTER" );

        if ( !isdefined( self.driver ) || var_1 != self.enter_use_tags[3] )
            var_1 makeusable();
    }

    waittillframeend;
    self.tag_player_view = common_scripts\utility::spawn_tag_origin();
    self.tag_player_view _meth_804D( self.mgturret[0], "tag_barrel", ( -38.9526, 6.01624, -46.3999 ), ( 0, 0, 0 ) );
    self.hint_button_locations = [];
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin + anglestoright( self.mgturret[0].angles ) * 60;
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoright( self.mgturret[0].angles ) * 60;
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoforward( self.mgturret[0].angles ) * 75;
    self.hint_buttons = [];

    foreach ( var_10 in self.hint_button_locations )
    {
        var_10 _meth_8092();
        var_10 _meth_804D( self.mgturret[0], "tag_aim_pivot" );
        self.hint_buttons[self.hint_buttons.size] = var_10 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );
    }

    self.hint_button_melee_location = common_scripts\utility::spawn_tag_origin();
    self.hint_button_melee_location.origin = self.mgturret[0].origin + ( 0, 0, 50 );
    self.hint_button_melee_location _meth_8092();
    self.hint_button_melee_location _meth_804D( self.mgturret[0], "tag_aim_pivot" );
    self.hint_button_melee = self.hint_button_melee_location maps\_shg_utility::hint_button_create( "melee", "tag_origin", 90, 150, 1 );

    for (;;)
    {
        self makeunusable();
        wait_for_any_trigger_hit( self.enter_use_tags );

        if ( level.player ismantling() || level.player _meth_83B3() )
            continue;

        maps\_utility::ent_flag_set( "player_in_transition" );
        soundscripts\_snd::snd_message( "player_enter_walker_anim" );
        var_12 = player_enter_turret();
        maps\_utility::ent_flag_clear( "player_in_transition" );

        if ( !isdefined( var_12 ) )
            continue;

        thread monitor_turret_rotation_rate();
        var_13 = level.player thread display_exit_hint();
        var_14 = undefined;

        while ( !isdefined( var_14 ) )
        {
            wait_for_exit_message();

            if ( !isalive( level.player ) || !isdefined( level.player.drivingvehicleandturret ) )
                break;

            var_14 = find_best_exit_anim( var_12 );

            if ( !isdefined( var_14 ) )
                iprintlnbold( "Could not find an exit!" );
        }

        var_13 destroy();
        maps\_utility::ent_flag_set( "player_in_transition" );
        level.player _meth_80FF();
        self.mgturret[0] _meth_8136();
        thread maps\_utility::lerp_fov_overtime( 2, 65 );

        if ( isdefined( level.player.drivingvehicleandturret ) && isalive( level.player ) )
        {
            soundscripts\_snd::snd_message( "player_exit_walker_anim" );
            player_exit_turret( var_14 );
        }

        maps\_utility::ent_flag_clear( "player_in_transition" );
    }
}

display_exit_hint()
{
    var_0 = maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_0.alpha = 0.7;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.y = 175;
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0.foreground = 0;
    var_0.hidewhendead = 1;
    var_0.hidewheninmenu = 1;
    var_0 settext( &"_X4WALKER_WHEELS_EXIT" );
    return var_0;
}

getcompasstext( var_0 )
{
    var_1 = getnorthyaw();
    var_0 -= var_1;

    if ( var_0 < 0 )
        var_0 += 360;
    else if ( var_0 > 360 )
        var_0 -= 360;

    if ( var_0 < 45 || var_0 > 315 )
        var_2 = &"_X4WALKER_WHEELS_NORTH";
    else if ( var_0 < 135 )
        var_2 = &"_X4WALKER_WHEELS_WEST";
    else if ( var_0 < 225 )
        var_2 = &"_X4WALKER_WHEELS_SOUTH";
    else if ( var_0 < 315 )
        var_2 = &"_X4WALKER_WHEELS_EAST";
    else
        var_2 = "";

    return var_2;
}

warning_update_text()
{
    self endon( "death" );
    self waittill( "play_damage_warning" );
    self notify( "destroy_compass_text" );
    self.compass_text settext( "WARNING" );
    self.hud_warning.alpha = 1;
    self.compass_text thread pulse_compass_text();
}

update_hud_text()
{
    self endon( "death" );
    self endon( "player_exited_mobile_turret" );
    self endon( "destroy_hud_text" );

    for (;;)
    {
        self.hud_text[0] settext( maps\_utility::round_float( self _meth_8289(), 1, 0 ) );
        self.hud_text[1] settext( maps\_utility::round_float( self _meth_8286(), 1, 0 ) );
        waitframe();
    }
}

pulse_compass_text()
{
    self endon( "death" );
    self endon( "player_exited_mobile_turret" );
    self endon( "destroy_hud_text" );
    var_0 = -0.1;

    for (;;)
    {
        self.alpha += var_0;

        if ( self.alpha <= 0 || self.alpha >= 1 )
            var_0 *= -1;

        waitframe();
    }
}

compass_update_text()
{
    self endon( "destroy_hud_text" );
    self endon( "destroy_compass_text" );

    for (;;)
    {
        var_0 = level.player getangles();
        var_1 = getcompasstext( var_0[1] );
        self.compass_text settext( var_1 );
        waitframe();
    }
}

turret_hud_elem_init_nofade( var_0 )
{
    self.alignx = "center";
    self.aligny = "middle";
    self.hidewhendead = 1;
    self.hidewheninmenu = 1;
    self.positioninworld = 1;
    self.relativeoffset = 1;
    self _meth_80CD( var_0, "turret_animate_jnt" );
}

turret_hud_elem_init( var_0 )
{
    self fadeovertime( 0.5 );
    self.alpha = 1;
    turret_hud_elem_init_nofade( var_0 );
}

turret_hud_elem_fadeout()
{
    self fadeovertime( 0.1 );
    self.alpha = 0;
}

player_show_turret_hud()
{
    var_0 = 100000;
    var_1 = 60;
    var_2 = -0.3 * var_0;
    var_3 = 0.25 * var_0;
    var_4 = 0.05 * var_0;
    var_5 = -0.23 * var_0;
    var_6 = 0.4 * var_0;
    var_7 = -0.4 * var_0;
    var_8 = -0.145 * var_0;
    var_9 = 0.28 * var_0;
    var_10 = 0.215 * var_0;
    var_11 = -0.225 * var_0;
    level.player endon( "death" );
    var_12 = getdvar( "hud_fade_ammodisplay" );
    _func_0D3( "hud_fade_ammodisplay", 0.05 );
    self.missiles = [];
    var_13 = newhudelem();
    var_13 _meth_80CC( "bls_ui_turret_overlay_sm", 720, 360 );
    var_13 turret_hud_elem_init( self.mgturret[0] );
    var_13.sort = 2;
    var_13.x = var_0;
    var_13.z = var_1;
    self.compass_text = maps\_hud_util::createfontstring( "small", 1.0 );
    self.compass_text turret_hud_elem_init( self.mgturret[0] );
    self.compass_text.x = var_0;
    self.compass_text.y = 0;
    self.compass_text.z = var_1 + var_10;
    self.hud_warning = newhudelem();
    self.hud_warning _meth_80CC( "bls_ui_turret_warning", 90, 24 );
    self.hud_warning turret_hud_elem_init_nofade( self.mgturret[0] );
    self.hud_warning.alpha = 0;
    self.hud_warning.x = var_0;
    self.hud_warning.y = 0;
    self.hud_warning.z = var_1 + var_10;
    self.hud_text = [];

    for ( var_14 = 0; var_14 < 2; var_14++ )
    {
        self.hud_text[var_14] = maps\_hud_util::createfontstring( "hudsmall", 0.75 );
        self.hud_text[var_14] turret_hud_elem_init( self.mgturret[0] );
        self.hud_text[var_14].x = var_0;
        self.hud_text[var_14].y = var_8 + var_14 * var_9;
        self.hud_text[var_14].z = var_1 + var_11;
    }

    thread update_outlines();
    thread update_hud_text();
    thread compass_update_text();
    thread warning_update_text();
    thread player_show_missile_reticle();
    common_scripts\utility::waittill_any( "dismount_vehicle_and_turret", "death" );
    var_13 turret_hud_elem_fadeout();
    self.hud_warning turret_hud_elem_fadeout();
    self.compass_text turret_hud_elem_fadeout();
    level notify( "remove_outline" );

    foreach ( var_16 in _func_0D6( "axis" ) )
    {
        if ( isdefined( var_16 ) )
            var_16 notify( "remove_outline" );
    }

    foreach ( var_16 in _func_0D6( "allies" ) )
    {
        if ( isdefined( var_16 ) )
            var_16 notify( "remove_outline" );
    }

    foreach ( var_21 in vehicle_getarray() )
    {
        if ( var_21 != self && isdefined( var_21.script_team ) && var_21.script_team == "axis" )
        {
            var_21 notify( "remove_outline" );

            if ( var_21.classname == "script_vehicle_x4walker_wheels_turret_closed" )
            {
                if ( isdefined( var_21.mgturret ) && isarray( var_21.mgturret ) && var_21.mgturret.size > 0 && isdefined( var_21.mgturret[0] ) )
                    var_21.mgturret[0] notify( "remove_outline" );
            }
        }
    }

    foreach ( var_24 in self.missiles )
        var_24 turret_hud_elem_fadeout();

    foreach ( var_24 in self.hud_text )
        var_24 turret_hud_elem_fadeout();

    common_scripts\utility::waittill_any( "player_exited_mobile_turret", "death" );
    _func_0D3( "hud_fade_ammodisplay", var_12 );
    var_13 destroy();
    self.hud_warning destroy();
    self notify( "destroy_hud_text" );
    self.compass_text destroy();

    foreach ( var_24 in self.missiles )
        var_24 destroy();

    foreach ( var_24 in self.hud_text )
        var_24 destroy();
}

update_outlines()
{
    level endon( "remove_outline" );

    for (;;)
    {
        var_0 = 5;

        foreach ( var_2 in _func_0D6( "axis" ) )
        {
            if ( var_0 <= 0 )
                break;

            if ( ( !isdefined( var_2.outlined ) || !var_2.outlined ) && ( !isdefined( var_2.drivingvehicle ) || !var_2.drivingvehicle ) )
            {
                var_2.outlined = 1;
                var_2 _meth_83FA( 1 );
                var_2 thread remove_outline_on_death();
                _func_09A( var_2 );
                _func_09C( var_2, "remote_chopper_hud_target_enemy" );
                _func_0A8( var_2, 1 );
                _func_0A9( var_2, 1 );
                _func_0A7( var_2, level.player );
                var_0--;
            }
        }

        foreach ( var_2 in _func_0D6( "allies" ) )
        {
            if ( var_0 <= 0 )
                break;

            if ( !isdefined( var_2.outlined ) || !var_2.outlined )
            {
                var_2.outlined = 1;
                var_2 _meth_83FA( 6 );
                var_2 thread remove_outline_on_death();
                _func_09A( var_2, ( 0, 0, 30 ) );
                _func_09C( var_2, "remote_chopper_hud_target_friendly" );
                _func_0A7( var_2, level.player );
                var_0--;
            }
        }

        foreach ( var_7 in vehicle_getarray() )
        {
            if ( var_0 <= 0 )
                break;

            if ( var_7 != self && isdefined( var_7.script_team ) && var_7.script_team == "axis" && ( !isdefined( var_7.outlined ) || !var_7.outlined ) && !issubstr( tolower( var_7.vehicletype ), "gaz" ) )
            {
                var_7.outlined = 1;
                var_7 _meth_83FA( 1 );
                var_7 thread remove_outline_on_death();
                _func_09A( var_7 );
                _func_09C( var_7, "remote_chopper_hud_target_enemy" );
                _func_0A8( var_7, 1 );
                _func_0A9( var_7, 1 );
                _func_0A7( var_7, level.player );
                var_0--;

                if ( var_7.classname == "script_vehicle_x4walker_wheels_turret_closed" && isdefined( var_7.mgturret ) )
                {
                    var_7.mgturret[0] _meth_83FA( 1 );
                    var_7.mgturret[0] thread remove_outline_on_death();
                }
            }
        }

        wait 0.05;
    }
}

remove_outline_on_death()
{
    common_scripts\utility::waittill_any( "death", "remove_outline" );

    if ( isdefined( self ) )
    {
        self.outlined = undefined;
        self _meth_83FB();

        if ( _func_0A3( self ) )
            _func_09B( self );
    }
}

reticle_show()
{
    var_0 = 32;
    var_1 = 32;

    foreach ( var_3 in self )
    {
        var_3 moveovertime( 0.1 );
        var_3.alpha = 1;
    }

    self["tl"].x = 0 - var_0;
    self["tl"].y = 0 - var_1;
    self["tr"].x = var_0;
    self["tr"].y = 0 - var_1;
    self["br"].x = var_0;
    self["br"].y = var_1;
    self["bl"].x = 0 - var_0;
    self["bl"].y = var_1;
    self["cross_l"].x = 0 - var_0;
    self["cross_l"].y = 0;
    self["cross_r"].x = var_0;
    self["cross_r"].y = 0;
    self["cross_b"].x = 0;
    self["cross_b"].y = 0 - var_1;
    self["cross_t"].x = 0;
    self["cross_t"].y = var_1;
}

reticle_hide()
{
    var_0 = 16;
    var_1 = 16;

    foreach ( var_3 in self )
        var_3.alpha = 0;

    self["tl"].x = 0 - var_0;
    self["tl"].y = 0 - var_1;
    self["tr"].x = var_0;
    self["tr"].y = 0 - var_1;
    self["br"].x = var_0;
    self["br"].y = var_1;
    self["bl"].x = 0 - var_0;
    self["bl"].y = var_1;
    self["cross_l"].x = 0 - var_0;
    self["cross_l"].y = 0;
    self["cross_r"].x = var_0;
    self["cross_r"].y = 0;
    self["cross_b"].x = 0;
    self["cross_b"].y = 0 - var_1;
    self["cross_t"].x = 0;
    self["cross_t"].y = var_1;
}

player_show_missile_reticle()
{
    self.player_driver endon( "death" );
    var_0 = 16;
    var_1 = 16;
    self.reticle = [];
    self.reticle["tl"] = newhudelem();
    self.reticle["tr"] = newhudelem();
    self.reticle["br"] = newhudelem();
    self.reticle["bl"] = newhudelem();
    self.reticle["cross_l"] = newhudelem();
    self.reticle["cross_r"] = newhudelem();
    self.reticle["cross_b"] = newhudelem();
    self.reticle["cross_t"] = newhudelem();

    foreach ( var_3 in self.reticle )
    {
        var_3.elemtype = "icon";
        var_3.width = 32;
        var_3.height = 32;
        var_3.foreground = 1;
        var_3.children = [];
        var_3 maps\_hud_util::setparent( level.uiparent );
        var_3.alignx = "center";
        var_3.aligny = "middle";
        var_3.horzalign = "center";
        var_3.vertalign = "middle";
        var_3.alpha = 0;
        var_3.hidewhendead = 1;
    }

    self.reticle["tl"].x = 0 - var_0;
    self.reticle["tl"].y = 0 - var_1;
    self.reticle["tl"] _meth_80CC( "bls_ui_turret_reticle_tl", 32, 32 );
    self.reticle["tr"].x = var_0;
    self.reticle["tr"].y = 0 - var_1;
    self.reticle["tr"] _meth_80CC( "bls_ui_turret_reticle_tr", 32, 32 );
    self.reticle["br"].x = var_0;
    self.reticle["br"].y = var_1;
    self.reticle["br"] _meth_80CC( "bls_ui_turret_reticle_br", 32, 32 );
    self.reticle["bl"].x = 0 - var_0;
    self.reticle["bl"].y = var_1;
    self.reticle["bl"] _meth_80CC( "bls_ui_turret_reticle_bl", 32, 32 );
    self.reticle["cross_l"].x = 0 - var_0;
    self.reticle["cross_l"].y = 0;
    self.reticle["cross_l"] _meth_80CC( "bls_ui_turret_reticule_hpip", 16, 16 );
    self.reticle["cross_r"].x = var_0;
    self.reticle["cross_r"].y = 0;
    self.reticle["cross_r"] _meth_80CC( "bls_ui_turret_reticule_hpip", 16, 16 );
    self.reticle["cross_b"].x = 0;
    self.reticle["cross_b"].y = 0 - var_1;
    self.reticle["cross_b"] _meth_80CC( "bls_ui_turret_reticule_vpip", 16, 16 );
    self.reticle["cross_t"].x = 0;
    self.reticle["cross_t"].y = var_1;
    self.reticle["cross_t"] _meth_80CC( "bls_ui_turret_reticule_vpip", 16, 16 );
    self waittill( "dismount_vehicle_and_turret" );

    foreach ( var_3 in self.reticle )
        var_3 turret_hud_elem_fadeout();

    self waittill( "player_exited_mobile_turret" );

    foreach ( var_3 in self.reticle )
        var_3 destroy();
}

player_enter_turret()
{
    level.player endon( "death" );
    self endon( "player_roof_kill" );

    if ( !isalive( level.player ) || level.player _meth_80A9( self.roof_use_trigger ) && isdefined( self.driver ) && isalive( self.driver ) )
        return;

    level.player _meth_80EF();
    level.player _meth_80EC( 1 );
    level.player _meth_8303( 0 );

    if ( isdefined( level.player.grapple ) && isdefined( level.player.grapple["enabled"] ) && level.player.grapple["enabled"] )
    {
        level.player maps\_grapple::grapple_take();
        level.player.reenable_grapple = 1;
    }

    foreach ( var_1 in self.enter_use_tags )
        var_1 makeunusable();

    if ( isdefined( self.hint_buttons ) )
    {
        foreach ( var_4 in self.hint_buttons )
            var_4 maps\_shg_utility::hint_button_clear();

        self.hint_buttons = [];
    }

    level.player notify( "player_starts_entering_mobile_turret" );
    var_6 = "enter_top_turret";

    if ( !level.player _meth_80A9( self.roof_use_trigger ) )
    {
        level.player maps\_shg_utility::setup_player_for_scene();
        level.player maps\_player_exo::player_exo_deactivate();
        var_7 = maps\_vehicle_shg::spawn_player_rig();
        self.enter_walker_rig = var_7;
        var_7 hide();
        level notify( "player_climbing_turret" );
        var_8 = distancesquared( level.player.origin, self.enter_use_tags[0].origin );
        var_9 = distancesquared( level.player.origin, self.enter_use_tags[1].origin );
        var_10 = distancesquared( level.player.origin, self.enter_use_tags[2].origin );
        var_11 = var_8;
        var_6 = "enter_left_turret";

        if ( var_9 < var_11 )
        {
            var_11 = var_9;
            var_6 = "enter_right_turret";
        }

        if ( var_10 < var_11 )
        {
            var_11 = var_10;
            var_6 = "enter_back_turret";
        }

        if ( isdefined( self.driver ) && isalive( self.driver ) )
        {
            switch ( var_6 )
            {
                case "enter_left_turret":
                    var_6 = "mount_left";
                    break;
                case "enter_right_turret":
                    var_6 = "mount_right";
                    break;
                case "enter_back_turret":
                    var_6 = "mount_back";
                    break;
            }
        }
        else
            soundscripts\_snd::snd_message( "aud_turret_entry" );

        self.mgturret[0] _meth_8065( "manual" );
        self.mgturret[0] _meth_8108();
        var_12 = common_scripts\utility::spawn_tag_origin();
        var_12 _meth_8092();
        var_12.origin = self.origin + rotatevector( self gettagorigin( "tag_body" ) - self.origin, self.mgturret[0] gettagangles( "tag_aim_pivot" ) - self.angles );
        var_12.angles = self.mgturret[0] gettagangles( "tag_aim_pivot" );
        var_12 _meth_804D( self.mgturret[0], "tag_aim_pivot" );
        var_12 maps\_anim::anim_first_frame_solo( var_7, var_6 );
        level.player _meth_8080( var_7, "tag_player", 0.2, 0.1, 0.1 );
        wait 0.2;
        thread maps\_utility::lerp_fov_overtime( 2, 55 );
        var_7 show();
        var_7 _meth_808E();
        var_7.vehicle_to_swap = self;
        var_12 maps\_anim::anim_single_solo( var_7, var_6 );
        level.player _meth_804F();
        var_7 delete();
        var_12 delete();
        self.enter_walker_rig = undefined;
        level.player maps\_shg_utility::setup_player_for_gameplay();
    }
    else
    {
        level.player.vehicle_to_swap = self;
        swap_cockpit_model( level.player );
        level.player maps\_player_exo::player_exo_deactivate();
    }

    self _meth_827C( self.origin + ( 0, 0, 45 ), self.angles );
    level.player _meth_820B( self );
    self.mgturret[0] setcontents( 0 );
    self.mgturret[0] _meth_8099( level.player );
    self.mgturret[0] makeunusable();
    level.player _meth_80F4();
    level.player _meth_807C( self.mgturret[0], "tag_guy", 0, 180, 180, 11, 13, 0 );
    level.player.drivingvehicleandturret = self;
    level.player _meth_8233();
    level.player _meth_80FE( 0.5, 0.35 );
    self.player_driver = level.player;
    thread camera_shake();
    thread randomize_turret_spread();
    self notify( "driving_vehicle_and_turret" );
    self.player_driver notify( "player_enters_mobile_turret", self );
    thread vehicle_scripts\_x4walker_wheels_turret_closed_aud::snd_start_x4_walker_wheels_turret_closed( "plr" );

    if ( var_6 != "enter_top_turret" )
        level notify( "player_finished_climbing_turret" );

    thread player_show_turret_hud();
    level.player _meth_80EC( 0 );
    self.dontfreeme = 1;
    level.player.isinturret = 1;
    thread handle_aggro();
    thread handle_hints();
    return var_6;
}

camera_shake()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    level.player endon( "death" );
    var_0 = 7;
    var_1 = 512;
    var_2 = 0.5;
    var_3 = 1;

    for (;;)
    {
        if ( self _meth_8286() == 0 )
            var_4 = 0.08;
        else
            var_4 = 0.12;

        earthquake( var_4, var_0, level.player.origin, var_1 );
        wait(var_3 + randomfloat( var_2 ));
    }
}

randomize_turret_spread()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    level.player endon( "death" );

    for (;;)
    {
        var_0 = randomfloatrange( 0.2, 1 );
        self.mgturret[0] _meth_810A( var_0 );
        wait 0.05;
    }
}

handle_aggro()
{
    self endon( "exiting_turret" );
    self.ignoreme = 1;
    level.player.ignoreme = 1;
    maps\_vehicle::godon();
    level.player _meth_80EF();
    wait 30;
    self.ignoreme = 0;
    level.player.ignoreme = 0;
    wait 30;
    maps\_vehicle::godoff();
    self.script_bulletshield = 1;
    self.script_grenadeshield = 1;
    self.script_ai_invulnerable = 1;
    level.player _meth_80F0();
    level.player _meth_80EC( 1 );
    wait 30;
    self.script_bulletshield = 0;
    self.script_grenadeshield = 0;
    self.script_ai_invulnerable = 0;
    level.player _meth_80EC( 0 );
}

handle_hints()
{
    self endon( "exiting_turret" );

    if ( !isdefined( level.player.x4_walker_controls_hints_shown ) || !level.player.x4_walker_controls_hints_shown )
    {
        level.player thread maps\_utility::display_hint_timeout( "x4walker_turret_hint", 3 );
        wait 3;
        level.player thread maps\_utility::display_hint_timeout( "x4walker_missiles_hint", 5 );
        wait 5;
        level.player.x4_walker_controls_hints_shown = 1;
    }
}

find_best_exit_anim( var_0 )
{
    var_1 = [ "exit_left_turret", "exit_right_turret", "exit_back_turret" ];
    var_2 = [ 0, 1, 2 ];

    if ( isdefined( var_0 ) )
    {
        if ( var_0 == "enter_right_turret" )
            var_2 = [ 1, 0, 2 ];
        else if ( var_0 == "enter_top_turret" )
            var_2 = [ 2, 0, 1 ];
    }

    var_3 = maps\_vehicle_shg::spawn_player_rig();
    var_3 hide();
    self.end_exit_early = 0;

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = var_2[var_4];
        var_6 = var_1[var_5];
        var_7 = var_3 maps\_utility::getanim( var_6 );
        maps\_anim::anim_first_frame_solo( var_3, var_6, "tag_body" );
        var_8 = getmovedelta( var_7, 0, 1 );
        var_9 = var_3 _meth_81B0( var_8 );
        var_10 = var_9 + ( 0, 0, 15 );
        var_11 = playerphysicstrace( var_10, var_9 );
        var_12 = var_11[2] - var_9[2];

        if ( var_12 < 1 )
        {
            var_3 delete();
            return var_6;
        }
    }

    self.end_exit_early = 1;
    var_3 delete();
    return "exit_back_turret";
}

player_exit_turret( var_0 )
{
    level.player endon( "death" );

    if ( !isalive( level.player ) )
        return;

    self notify( "exiting_turret" );
    wait 0.05;
    level.player _meth_80EF();
    level.player _meth_80EC( 1 );
    self.mgturret[0] _meth_8001( self.tag_player_view.origin );
    self.mgturret[0] _meth_8099( level.player );
    level.player _meth_807D( self.tag_player_view, "tag_origin", 1 );
    level.player maps\_shg_utility::setup_player_for_scene();
    wait_for_turret_reset();
    level.player _meth_804F();
    var_1 = maps\_vehicle_shg::spawn_player_rig();
    var_1 hide();
    level notify( "player_out_of_turret" );
    maps\_anim::anim_first_frame_solo( var_1, var_0, "tag_body" );
    level.player _meth_8080( var_1, "tag_player", 0.2, 0.1, 0.1 );
    wait 0.2;
    var_1 show();
    var_1 _meth_808E();
    var_1.vehicle_to_swap = self;
    level.player.drivingvehicleandturret = undefined;
    self.player_driver = undefined;

    if ( !isdefined( self.burning ) )
        level.player _meth_820C( self );
    else if ( isdefined( self.damage_fx ) )
    {
        foreach ( var_3 in self.damage_fx )
            stopfxontag( common_scripts\utility::getfx( var_3.name ), self.mgturret[0], var_3.tag );
    }

    self notify( "dismount_vehicle_and_turret" );
    level.player notify( "dismount_vehicle_and_turret" );
    level.player _meth_807D( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    thread vehicle_scripts\_x4walker_wheels_turret_closed_aud::snd_start_x4_walker_wheels_turret_closed( "npc" );

    if ( isdefined( self.end_exit_early ) && self.end_exit_early )
    {
        thread maps\_anim::anim_single_solo( var_1, var_0, "tag_body" );
        wait 2.5;
    }
    else
        maps\_anim::anim_single_solo( var_1, var_0, "tag_body" );

    self _meth_827C( self.origin - ( 0, 0, 45 ), self.angles );
    level.player _meth_804F();
    var_1 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player maps\_player_exo::player_exo_activate();

    foreach ( var_6 in self.enter_use_tags )
        var_6 makeusable();

    self.hint_buttons = [];

    foreach ( var_9 in self.hint_button_locations )
        self.hint_buttons[self.hint_buttons.size] = var_9 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );

    self.ignoreme = 0;
    level.player.ignoreme = 0;
    maps\_vehicle::godoff();
    self.script_bulletshield = 1;
    self.script_grenadeshield = 1;
    self.script_ai_invulnerable = 1;
    self.dontfreeme = 0;
    level.player.isinturret = 0;
    level.player _meth_80F0();
    level.player _meth_80EC( 0 );
    level.player _meth_8303( 1 );

    if ( isdefined( level.player.reenable_grapple ) && level.player.reenable_grapple )
    {
        level.player maps\_grapple::grapple_give();
        level.player.reenable_grapple = 0;
    }

    self notify( "player_exited_mobile_turret" );
    level.player notify( "player_exited_mobile_turret" );
}

wait_for_turret_reset()
{
    for ( var_0 = 0; !var_0; var_0 = var_4 > 0.95 )
    {
        wait 0.05;
        var_1 = self.mgturret[0] gettagangles( "tag_barrel" );
        var_2 = anglestoforward( self.angles );
        var_3 = anglestoforward( var_1 );
        var_4 = vectordot( var_2, var_3 );
    }
}

handle_vehicle_dof()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "enter_vehicle_dof" );
        maps\_art::dof_enable_script( 10, 70, 4, 9500, 10000, 0, 0.5 );
        self waittill( "exit_vehicle_dof" );
        maps\_art::dof_disable_script( 0.5 );
    }
}

wait_for_exit_message()
{
    self endon( "dismount_vehicle_and_turret" );
    var_0 = "exit_message";
    notifyoncommand( var_0, "+activate" );
    notifyoncommand( var_0, "+usereload" );
    level.player waittill( var_0 );
}

wait_for_any_trigger_hit( var_0 )
{
    if ( var_0.size > 1 )
    {
        for ( var_1 = 1; var_1 < var_0.size; var_1++ )
            var_0[var_1] endon( "trigger" );
    }

    if ( var_0.size > 0 )
        var_0[0] waittill( "trigger" );
}

make_mobile_turret_usable()
{
    self makeunusable();

    if ( isdefined( self.enter_use_tags ) )
    {
        foreach ( var_1 in self.enter_use_tags )
            var_1 makeusable();
    }

    if ( isdefined( self.hint_button_locations ) )
    {
        self.hint_buttons = [];

        foreach ( var_4 in self.hint_button_locations )
            self.hint_buttons[self.hint_buttons.size] = var_4 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );
    }
}

make_mobile_turret_unusable()
{
    self makeunusable();

    if ( isdefined( self.enter_use_tags ) )
    {
        foreach ( var_1 in self.enter_use_tags )
            var_1 makeunusable();
    }

    if ( isdefined( self.hint_buttons ) )
    {
        foreach ( var_4 in self.hint_buttons )
            var_4 maps\_shg_utility::hint_button_clear();

        self.hint_buttons = [];
    }
}

x4walker_spawn_player_rig( var_0 )
{
    var_1 = undefined;

    if ( isdefined( level.player_rig_spawn_function ) )
    {
        var_1 = [[ level.player_rig_spawn_function ]]();
        var_1.animname = var_0;
    }
    else
    {
        var_1 = spawn( "script_model", ( 0, 0, 0 ) );
        var_1.animname = var_0;
        var_1 _meth_8115( #animtree );
        var_1 _meth_80B1( "viewbody_sentinel_covert" );
    }

    return var_1;
}

monitor_vehicle_mount()
{
    self endon( "death" );
    self _meth_814B( maps\_vehicle_shg::get_vehicle_anim( "idle" ) );

    for (;;)
    {
        common_scripts\utility::waittill_any( "driving_vehicle_and_turret", "guy_entered" );

        if ( !isdefined( self.player_driver ) )
        {
            self.driver maps\_utility::magic_bullet_shield( 1 );
            thread handle_vehicle_ai();

            if ( isdefined( self.enter_use_tags ) && isarray( self.enter_use_tags ) && self.enter_use_tags.size > 3 )
                self.enter_use_tags[3] makeunusable();

            thread vehicle_scripts\_x4walker_wheels_turret_closed_aud::snd_start_x4_walker_wheels_turret_closed( "npc" );
            continue;
        }

        thread monitor_turret_shoot();
        thread camera_shake_on_turret_fire();
        thread rocket_think();
        wait_for_exit_message();
    }
}

monitor_player_rip_off_roof()
{
    self endon( "death" );
    self.roof_trigger = spawn( "trigger_radius", self.mgturret[0].origin + ( 0, 0, 24 ), 0, 72, 30 );
    self.roof_trigger _meth_8069();
    self.roof_trigger _meth_804D( self.mgturret[0] );

    for (;;)
    {
        self.roof_trigger waittill( "trigger", var_0 );

        if ( isdefined( var_0 ) && var_0 == level.player )
        {
            thread disablemeleeonroof( level.player );

            if ( isdefined( self.driver ) && ( isdefined( self.grappled ) && level.player.grapple["rope_state"] == 0 || level.player _meth_8341() && isdefined( self.meleed ) || isdefined( self.enter_walker_rig ) ) )
            {
                self notify( "player_roof_kill" );
                level.hide_x4walker_melee_hint = 1;
                self.hint_button_melee maps\_shg_utility::hint_button_clear();
                self.hint_button_melee = undefined;
                maps\_grapple::grapple_magnet_unregister( self.mgturret[0], "tag_grapple_front" );
                maps\_grapple::grapple_magnet_unregister( self.mgturret[0], "tag_grapple_left" );
                maps\_grapple::grapple_magnet_unregister( self.mgturret[0], "tag_grapple_back" );
                maps\_grapple::grapple_magnet_unregister( self.mgturret[0], "tag_grapple_right" );
                var_1 = common_scripts\utility::spawn_tag_origin();
                var_1 _meth_8092();
                var_1.origin = self.mgturret[0].origin + anglestoforward( ( 0, self.mgturret[0].angles[1], 0 ) ) * 9999999;
                self.mgturret[0] _meth_8065( "manual" );
                self.mgturret[0] _meth_8108();
                self.mgturret[0] _meth_80E3();
                self.mgturret[0] _meth_8106( var_1 );
                self.mgturret[0].animname = self.classname;
                var_2 = level.player _meth_817C();

                if ( var_2 != "stand" )
                {
                    level.player _meth_817D( "stand" );

                    if ( var_2 == "prone" )
                        wait 0.5;
                    else if ( var_2 == "crouch" )
                        wait 0.25;
                }

                var_3 = 0;
                var_4 = undefined;

                if ( isdefined( self.enter_walker_rig ) )
                {
                    var_3 = 1;
                    self.enter_walker_rig waittillmatch( "single anim", "end" );
                    var_4 = self.enter_walker_rig;
                }

                level.player _meth_80EF();
                self.roof_trigger delete();
                self.roof_trigger = undefined;
                level.player maps\_shg_utility::setup_player_for_scene();
                level.player maps\_player_exo::player_exo_deactivate();

                if ( isdefined( self.grappled ) && self.grappled )
                {
                    level.player.grapple["exo_deactivated"] = 0;
                    level.player.grapple["model_attach_world"] hide();
                    level.player.grapple["no_disable_invulnerability"] = 1;
                    level.player maps\_grapple::grapple_take();
                    level.player.reenable_grapple = 1;
                }

                if ( !isdefined( var_4 ) )
                {
                    var_4 = level.player maps\_vehicle_shg::spawn_player_rig();
                    var_4 _meth_804F();
                    var_4 hide();
                    var_4.origin = level.player.origin;
                    var_4.angles = level.player.angles;
                    var_4 _meth_8092();
                }

                maps\_anim::addnotetrack_notify( var_4.animname, "dof_on", "turret_grapple_dof_on", "roof_kill" );
                maps\_anim::addnotetrack_notify( var_4.animname, "dof_off", "turret_grapple_dof_off", "roof_kill" );
                var_5 = undefined;

                if ( isdefined( self.driver.script_deathflag ) )
                {
                    var_5 = self.driver.script_deathflag;
                    self.driver.script_deathflag = undefined;
                }

                self.driver.angles = var_4.angles;
                self.driver notify( "roof_kill" );
                self.driver = maps\_utility::swap_drone_to_ai( self.driver );
                self.driver maps\_utility::magic_bullet_shield( 1 );
                self.driver.animname = self.classname + "_guy";
                self.driver _meth_804F();
                self.driver hide();
                self.driver _meth_8092();
                self.driver.script_deathflag = var_5;
                thread maps\_anim::anim_first_frame_solo( self.driver, "roof_kill", "tag_body" );
                thread maps\_anim::anim_first_frame_solo( self.mgturret[0], "roof_kill", "tag_body" );
                thread maps\_anim::anim_first_frame_solo( var_4, "roof_kill", "tag_body" );

                if ( !var_3 )
                {
                    level.player _meth_8080( var_4, "tag_player", 0.2 );
                    wait 0.2;
                }

                var_4 show();
                level.player _meth_807F( var_4, "tag_player" );

                if ( var_3 )
                    wait 0.05;

                self.driver notify( "killanimscript" );
                self.driver show();
                thread maps\_anim::anim_single_solo( self.driver, "roof_kill", "tag_body" );
                thread maps\_anim::anim_single_solo( self.mgturret[0], "roof_kill", "tag_body" );
                thread maps\_anim::anim_single_solo( var_4, "roof_kill", "tag_body" );
                var_4 waittillmatch( "single anim", "rumble" );
                level.player _meth_80AD( "falling_land" );
                wait 1.0;
                level.player _meth_80AD( "heavy_2s" );
                self.driver waittillmatch( "single anim", "intoragdoll" );

                if ( isdefined( var_5 ) )
                    common_scripts\utility::flag_set( var_5 );

                if ( !isdefined( self.driver.knuckles_bloodsplosion ) )
                {
                    self.driver.deathanim = undefined;
                    self.driver.turretdeathanim = undefined;
                    var_6 = self.driver.origin;
                    wait 0.05;
                    var_7 = distance( self.driver.origin, var_6 );
                    self.driver _meth_8023();
                    self.driver _meth_8142( self.driver maps\_utility::getanim( "roof_kill" ), 0.1 );
                    wait 0.05;
                    physicsexplosionsphere( var_6, 600, 0, var_7 * 0.1 );
                }

                level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
                var_4 waittillmatch( "single anim", "end" );

                if ( !isdefined( self.driver.knuckles_bloodsplosion ) )
                {
                    self.driver maps\_utility::stop_magic_bullet_shield();
                    self.driver _meth_8052();
                }

                self.driver = undefined;
                level.player _meth_804F();
                level.player maps\_shg_utility::setup_player_for_gameplay();
                level.player maps\_player_exo::player_exo_activate();
                var_4 delete();
                level.player _meth_80F0();
                level.player _meth_80EC( 0 );
                level.player _meth_8303( 1 );

                if ( isdefined( self.grappled ) && self.grappled )
                    level.player maps\_grapple::grapple_kills_increment();

                foreach ( var_9 in self.enter_use_tags )
                    var_9 makeusable();

                self.hint_buttons = [];

                foreach ( var_12 in self.hint_button_locations )
                    self.hint_buttons[self.hint_buttons.size] = var_12 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );

                self.mgturret[0] _meth_8108();
                var_1 delete();

                if ( isdefined( level.player.reenable_grapple ) && level.player.reenable_grapple )
                {
                    level.player maps\_grapple::grapple_give();
                    level.player.reenable_grapple = 0;
                }

                break;
            }
        }
    }
}

disablemeleeonroof( var_0 )
{
    self endon( "player_roof_kill" );
    var_0 _meth_8130( 0 );
    level.hide_x4walker_melee_hint = 0;
    maps\_utility::display_hint( "x4walker_melee_hint" );

    while ( isdefined( self.roof_trigger ) )
    {
        if ( !var_0 _meth_80A9( self.roof_trigger ) )
        {
            var_0 _meth_8130( 1 );
            break;
        }

        wait 0.05;
    }

    level.hide_x4walker_melee_hint = 1;
}

monitor_player_melee()
{
    self endon( "death" );
    self endon( "player_roof_kill" );
    level.player _meth_82DD( "rip_open_roof", "+melee_zoom" );

    for (;;)
    {
        level.player waittill( "rip_open_roof" );
        var_0 = 0;

        if ( isdefined( level.player.grapple ) )
        {
            if ( level.player.grapple["grappling"] || level.player.grapple["quick_firing"] || level.player _meth_8311() == level.player.grapple["weapon"] || level.player.grapple["quick_fire_button_down"] || level.player.grapple["quick_fire_button_up"] )
                var_0 = 1;
        }

        if ( isdefined( self.roof_trigger ) && level.player _meth_80A9( self.roof_trigger ) && !var_0 )
        {
            self.meleed = 1;
            self.roof_trigger notify( "trigger", level.player );
            wait 0.05;
            self.meleed = undefined;
        }
    }
}

monitor_player_grapple()
{
    self endon( "death" );
    self endon( "player_roof_kill" );

    for (;;)
    {
        level.player waittill( "grapple_turret" );

        if ( isdefined( self.roof_trigger ) && level.player _meth_80A9( self.roof_trigger ) )
            self.grappled = 1;

        level.player notify( "grapple_drop" );
    }
}

animation_think()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "play_anim", var_0 );
        clear_anims();
        self _meth_814B( maps\_vehicle_shg::get_vehicle_anim( var_0 ), 1.0, 0.2, 1.0 );
    }
}

#using_animtree("vehicles");

clear_anims()
{
    self _meth_8142( %walker_wheels_turret, 0.2 );
}

monitor_turret_shoot()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );

    for (;;)
    {
        self.mgturret[0] waittill( "turret_fire" );
        self.mgturret[0] _meth_814D( %x4walker_wheels_turret_cockpit_fire, 1, 0, 1 );
    }
}

camera_shake_on_turret_fire()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );

    for (;;)
    {
        self.mgturret[0] waittill( "turret_fire" );
        earthquake( 0.2, 0.1, self.player_driver.origin, 128 );
    }
}

rocket_think()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    thread monitor_missile_input();

    for (;;)
    {
        self waittill( "target_missile_system" );
        thread rocket_target_think();
        self waittill( "fire_missile_system" );
        thread fire_rockets();

        if ( isdefined( self.rocket_targets ) && self.rocket_targets.size > 0 )
        {
            self notify( "disable_missile_input" );
            wait 2;
            self.mgturret[0] _meth_8143( %x4walkersplit_cockpit_rockets_down, 1, 0.2, 1 );
            wait 0.5;
            self.mgturret[0] _meth_8143( %x4walkersplit_cockpit_rockets_up, 1, 0.2, 1 );
            thread monitor_missile_input();
        }
    }
}

rocket_target_think()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    self endon( "fire_missile_system" );

    if ( !isdefined( self.rocket_targets ) )
        self.rocket_targets = [];

    var_0 = 4;

    for (;;)
    {
        if ( self.rocket_targets.size < var_0 )
            add_target_on_dot();

        wait 0.05;
    }
}

acquired_animation()
{
    self endon( "death" );
    wait 0.3;

    if ( isdefined( self.hud_missile_target ) )
    {
        self.hud_missile_target _meth_80CC( "bls_ui_turret_targetlock_white", self.hud_missile_target.width, self.hud_missile_target.height );
        soundscripts\_snd_playsound::snd_play_2d( "x4_walker_missile_lock" );
    }
}

add_target_on_los()
{
    var_0 = anglestoforward( self.player_driver getangles() );
    var_0 = vectornormalize( var_0 );
    var_1 = self.player_driver _meth_80A8();
    var_2 = bullettrace( var_1, var_1 + var_0 * 2048, 1, self );
    var_3 = var_2["entity"];

    if ( isdefined( var_3 ) && isai( var_3 ) && isalive( var_3 ) && !maps\_vehicle_code::attacker_isonmyteam( var_3 ) && !maps\_vehicle_code::attacker_troop_isonmyteam( var_3 ) )
    {
        if ( !isdefined( var_3.target_marked ) || !var_3.target_marked )
        {
            var_3.target_marked = 1;
            _func_09A( var_3, ( 0, 0, 20 ) );
            _func_09C( var_3, "bls_ui_turret_targetacquired" );
            var_3 thread acquired_animation();
            soundscripts\_snd::snd_message( "x4_walker_hud_target_aquired", var_3 );
            thread remove_target( var_3 );
            self.rocket_targets[self.rocket_targets.size] = var_3;
        }
    }
}

update_missile_hud()
{
    if ( isdefined( self.missiles ) && isdefined( self.rocket_targets ) )
    {
        for ( var_0 = 0; var_0 < self.rocket_targets.size; var_0++ )
        {
            self.missiles[var_0] fadeovertime( 0.1 );
            self.missiles[var_0].alpha = 0.1;
        }

        while ( var_0 < self.missiles.size )
        {
            self.missiles[var_0] fadeovertime( 0.1 );
            self.missiles[var_0].alpha = 1;
            var_0++;
        }
    }
}

add_target_on_dot()
{
    var_0 = anglestoforward( self.player_driver getangles() );
    var_0 = vectornormalize( var_0 );
    var_1 = self.player_driver _meth_80A8();
    var_2 = ( 0, 0, 32 );
    var_3 = get_all_valid_rocket_targets();

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5.target_marked ) && var_5.target_marked )
            continue;

        if ( isdefined( var_5.ridingvehicle ) )
        {
            if ( !isdefined( var_5.rappeller ) || !var_5.rappeller )
                continue;
        }

        var_6 = var_5.origin;

        if ( isai( var_5 ) )
            var_6 = var_5 _meth_80A8();

        var_7 = var_6 - var_1;
        var_7 = vectornormalize( var_7 );
        var_8 = vectordot( var_0, var_7 );
        var_9 = abs( acos( var_8 ) );

        if ( var_9 > 4 )
            continue;

        var_5.target_marked = 1;
        var_5.hud_missile_target = maps\_hud_util::createicon( "bls_ui_turret_targetacquired", 20, 20 );
        var_5.hud_missile_target.alpha = 1;
        var_5.hud_missile_target.alignx = "center";
        var_5.hud_missile_target.aligny = "middle";
        var_5.hud_missile_target.hidewhendead = 1;
        var_5.hud_missile_target.hidewheninmenu = 1;
        var_5.hud_missile_target.positioninworld = 1;
        var_5.hud_missile_target.relativeoffset = 1;
        var_5.hud_missile_target _meth_80CD( var_5, "tag_origin" );
        var_5 thread acquired_animation();
        soundscripts\_snd::snd_message( "x4_walker_hud_target_aquired", var_5 );
        thread remove_target( var_5 );
        self.rocket_targets[self.rocket_targets.size] = var_5;
        return;
    }
}

get_missile_target_offset( var_0 )
{
    if ( isai( var_0 ) )
        return ( 0, 0, 0 );

    if ( isdefined( var_0.vehicletype ) )
    {
        if ( var_0 maps\_vehicle::ishelicopter() )
            return ( 0, 0, -80 );

        return ( 0, 0, 48 );
    }

    if ( isdefined( var_0.destructibleinfo ) )
        return ( 0, 0, 48 );

    return ( 0, 0, 0 );
}

get_all_valid_rocket_targets()
{
    var_0 = _func_0D6( "axis" );
    var_1 = getentarray( "script_vehicle", "code_classname" );
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isalive( var_4 ) )
            continue;

        var_2[var_2.size] = var_4;
    }

    foreach ( var_7 in var_1 )
    {
        if ( isspawner( var_7 ) )
            continue;

        if ( !isalive( var_7 ) )
            continue;

        if ( isdefined( var_7.script_team ) && var_7.script_team != "axis" )
            continue;

        if ( isdefined( var_7.mobile_turret_rocket_target ) && !var_7.mobile_turret_rocket_target )
            continue;

        var_2[var_2.size] = var_7;
    }

    return var_2;
}

remove_target( var_0 )
{
    wait_to_remove_target( var_0 );

    if ( isdefined( var_0 ) )
    {
        var_0.target_marked = undefined;

        if ( isdefined( var_0.hud_missile_target ) )
        {
            var_0.hud_missile_target destroy();
            var_0.hud_missile_target = undefined;
        }
    }

    if ( isdefined( self ) && isdefined( self.rocket_targets ) )
    {
        var_1 = [];

        foreach ( var_3 in self.rocket_targets )
        {
            if ( isdefined( var_3 ) )
            {
                if ( isdefined( var_0 ) && var_3 == var_0 )
                    continue;

                var_1[var_1.size] = var_3;
            }
        }

        self.rocket_targets = var_1;
    }
}

wait_to_remove_target( var_0 )
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    var_0 endon( "death" );
    var_0 waittill( "remove_target" );
}

monitor_missile_input()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    self endon( "disable_missile_input" );
    var_0 = 0;

    for (;;)
    {
        wait 0.05;
        var_1 = self.player_driver _meth_82EE();

        if ( var_1 && !var_0 )
        {
            var_0 = 1;
            self.reticle reticle_show();
            self notify( "target_missile_system" );
            continue;
        }

        if ( !var_1 && var_0 )
        {
            var_0 = 0;
            self.reticle reticle_hide();
            self notify( "fire_missile_system" );
        }
    }

    _func_0D3( "cg_drawCrosshair", 1 );
}

fire_rockets()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    var_0 = [];

    foreach ( var_2 in self.rocket_targets )
        var_0[var_0.size] = var_2;

    var_4 = 0;

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) || !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2.target_marked ) )
            continue;

        self.player_driver _meth_80AD( "heavy_1s" );
        earthquake( 0.3, 1, self.player_driver.origin, 256 );

        if ( _func_0A3( var_2 ) )
            _func_09C( var_2, "bls_ui_turret_targetlock" );

        soundscripts\_snd_playsound::snd_play_2d( "x4_walker_missile_fire" );
        soundscripts\_snd::snd_message( "x4_walker_hud_missile_launched", var_2 );
        thread fire_rocket_at( var_2, var_4, self.player_driver );
        var_4++;
        wait 0.35;
    }
}

fire_rocket_at( var_0, var_1, var_2 )
{
    if ( !isdefined( self.launcher_index ) )
        self.launcher_index = 0;
    else
    {
        self.launcher_index++;
        self.launcher_index %= 4;
    }

    var_3 = var_0.origin;
    var_1 = self.launcher_index + 1;
    var_4 = "TAG_LAUNCHER" + var_1;
    var_5 = undefined;

    switch ( var_1 )
    {
        case 1:
            var_5 = %x4walkersplit_cockpit_rockets_fire4;
            break;
        case 2:
            var_5 = %x4walkersplit_cockpit_rockets_fire3;
            break;
        case 3:
            var_5 = %x4walkersplit_cockpit_rockets_fire2;
            break;
        case 4:
            var_5 = %x4walkersplit_cockpit_rockets_fire1;
            break;
    }

    self.mgturret[0] _meth_8143( var_5, 1, 0, 1 );
    var_6 = self.mgturret[0] gettagorigin( var_4 );
    var_7 = self.mgturret[0] gettagangles( var_4 );
    var_8 = var_6 + anglestoforward( var_7 ) * 512;
    playfxontag( common_scripts\utility::getfx( "x4walker_wheels_rpg_fv" ), self.mgturret[0], var_4 );
    var_9 = magicbullet( "mobile_turret_missile", var_6, var_8, var_2 );
    var_9 soundscripts\_snd::snd_message( "x4_walker_fire_missile", var_0 );
    var_10 = ( 0, 0, 30 );

    if ( var_0.classname == "actor_enemy_mech" )
        var_10 = ( 0, 0, 60 );

    var_9 _meth_81D9( var_0, var_10 );
    var_9 _meth_81DC();
    var_9 waittill( "death" );

    if ( isdefined( var_0 ) )
        var_0 notify( "remove_target" );
}

handle_vehicle_ai()
{
    if ( isdefined( self.ai_func_override ) )
        self thread [[ self.ai_func_override ]]();
    else
    {
        var_0 = maps\_vehicle_aianim::anim_pos( self, 0 );

        if ( isdefined( self.driver ) && !isai( self.driver ) && isdefined( var_0.sittag_on_turret ) && var_0.sittag_on_turret )
        {
            if ( maps\_vehicle_aianim::guy_should_man_turret( var_0 ) )
                thread handle_drone_on_turret( self.driver, var_0 );
        }
    }
}

handle_drone_on_turret( var_0, var_1 )
{
    var_2 = self.mgturret[var_1.mgturret];

    if ( !isalive( var_0 ) )
        return;

    var_0 maps\_utility::gun_remove();
    var_2 endon( "death" );
    var_0 endon( "death" );
    var_0 endon( "roof_kill" );
    maps\_vehicle_code::set_turret_team( var_2 );
    var_2 _meth_815A( 0 );
    wait 0.1;
    var_0 endon( "guy_man_turret_stop" );
    level thread maps\_mgturret::mg42_setdifficulty( var_2, maps\_utility::getdifficulty() );
    var_2 _meth_8067( 1 );
    var_2 _meth_8065( "auto_nonai" );
    var_0 _meth_804D( var_2, var_1.sittag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread maps\_mgturret_auto_nonai::stop_turret_on_gunner_death( var_2, var_0, var_1 );
    var_3 = var_2 gettagorigin( var_1.sittag );
    var_4 = var_2 gettagangles( var_1.sittag );

    for (;;)
        var_2 maps\_vehicle_aianim::animontag( var_0, var_1.sittag, var_1.idle );
}

rocket_ai()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    var_0 = 128;
    wait(randomintrange( 1, 10 ));

    for (;;)
    {
        wait(randomfloatrange( 12, 20 ));
        var_1 = 0;

        while ( !var_1 )
        {
            var_2 = [];
            var_3 = _func_0D6( common_scripts\utility::get_enemy_team( self.driver.team ) );

            foreach ( var_5 in var_3 )
            {
                var_6 = var_5.origin - self.origin;
                var_7 = length( var_6 );

                if ( var_7 < 1024 )
                    continue;

                var_6 = vectornormalize( var_6 );
                var_8 = self.mgturret[0] gettagangles( "tag_flash" );
                var_9 = anglestoforward( var_8 );
                var_10 = vectordot( var_6, var_9 );

                if ( var_10 < 0.5 )
                    continue;

                var_11 = self.mgturret[0] gettagorigin( "tag_flash" );
                var_12 = var_5.origin + ( 0, 0, 32 );
                var_13 = sighttracepassed( var_11, var_12, 0, self );

                if ( !var_13 )
                    continue;

                var_14 = vectorfromlinetopoint( var_11, var_12, level.player.origin + ( 0, 0, 32 ) );

                if ( length( var_14 ) < var_0 )
                    continue;

                var_2[var_2.size] = var_5;
            }

            var_16 = [];

            if ( var_2.size > 0 )
            {
                var_17 = randomint( var_2.size );

                for ( var_18 = 0; var_18 < var_2.size; var_18++ )
                {
                    var_19 = ( var_17 + var_18 ) % var_2.size;
                    var_20 = var_2[var_19];
                    var_16[var_16.size] = var_20;

                    if ( var_16.size > 1 )
                    {
                        var_21 = var_16.size / 4;

                        if ( var_21 > randomfloatrange( 0, 1 ) )
                            break;
                    }
                }
            }

            var_22 = 0;

            foreach ( var_24 in var_16 )
            {
                if ( !isdefined( var_24 ) )
                    continue;

                var_1 = 1;
                thread fire_rocket_at( var_24, var_22, self.driver );
                var_22++;
                wait 0.35;
            }

            if ( !var_1 )
                wait 0.5;
        }
    }
}

swap_cockpit_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        maps\_grapple::grapple_magnet_unregister( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_front" );
        maps\_grapple::grapple_magnet_unregister( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_left" );
        maps\_grapple::grapple_magnet_unregister( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_back" );
        maps\_grapple::grapple_magnet_unregister( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_right" );
        var_0.vehicle_to_swap.old_contents = var_0.vehicle_to_swap setcontents( 0 );
        var_0.vehicle_to_swap notify( "enter_vehicle_dof" );
        var_0.vehicle_to_swap _meth_80B1( "vehicle_vm_x4walkersplit_wheels" );
        var_0.vehicle_to_swap hide();
        var_0.vehicle_to_swap.mgturret[0] _meth_80B1( "vehicle_vm_x4walkersplit_turretClosed" );
        var_0.vehicle_to_swap _meth_827C( var_0.vehicle_to_swap.origin, var_0.vehicle_to_swap.angles );
        var_0.vehicle_to_swap notify( "play_anim", "cockpit_idle" );
    }
}

swap_world_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        if ( isdefined( var_0.vehicle_to_swap.base ) )
            var_0.vehicle_to_swap.base show();

        var_0.vehicle_to_swap setcontents( var_0.vehicle_to_swap.old_contents );
        var_0.vehicle_to_swap notify( "exit_vehicle_dof" );
        var_0.vehicle_to_swap _meth_80B1( "vehicle_npc_x4walkersplit_wheels" );
        var_0.vehicle_to_swap hide();
        var_0.vehicle_to_swap.mgturret[0] _meth_80B1( "vehicle_npc_x4walkersplit_turretClosed" );
        var_0.vehicle_to_swap _meth_827C( var_0.vehicle_to_swap.origin, var_0.vehicle_to_swap.angles );
        var_0.vehicle_to_swap notify( "play_anim", "idle" );
        maps\_grapple::grapple_magnet_register( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_front", ( 5, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
        maps\_grapple::grapple_magnet_register( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_left", ( 8, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
        maps\_grapple::grapple_magnet_register( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_back", ( 18, 0, -1 ), "grapple_turret", undefined, self.magnetoptions );
        maps\_grapple::grapple_magnet_register( var_0.vehicle_to_swap.mgturret[0], "tag_grapple_right", ( 8, 0, -5 ), "grapple_turret", undefined, self.magnetoptions );
    }
}

clean_up_vehicle()
{
    self waittill( "death" );

    if ( isdefined( self ) )
    {
        if ( isdefined( self.enter_use_tags ) )
        {
            foreach ( var_1 in self.enter_use_tags )
                var_1 delete();

            self.enter_use_tags = undefined;
        }

        if ( isdefined( self.hint_buttons ) )
        {
            foreach ( var_4 in self.hint_buttons )
                var_4 maps\_shg_utility::hint_button_clear();

            self.hint_buttons = [];
        }

        if ( isdefined( self.hint_button_melee ) )
            self.hint_button_melee maps\_shg_utility::hint_button_clear();

        if ( isdefined( self.tag_player_view ) )
            self.tag_player_view delete();

        if ( isdefined( self.roof_trigger ) )
            self.roof_trigger delete();

        if ( isdefined( self.driver ) )
            self.driver maps\_utility::stop_magic_bullet_shield();

        if ( isdefined( self.player_driver ) )
            self.player_driver _meth_8052();

        self delete();
    }
}

monitor_wheel_movements()
{
    self endon( "death" );
    var_0 = [ "tag_wheel_back_left", "tag_wheel_back_right", "tag_wheel_front_left", "tag_wheel_front_right" ];
    self.last_wheel_pos = [];
    self.current_wheel_pos = [];
    var_1 = 0.05;

    if ( level.currentgen )
        var_1 = 0.5;

    for (;;)
    {
        foreach ( var_3 in var_0 )
            self.current_wheel_pos[var_3] = self gettagorigin( var_3 );

        wait(var_1);

        foreach ( var_3 in var_0 )
            self.last_wheel_pos[var_3] = self.current_wheel_pos[var_3];
    }
}

monitor_turret_rotation_rate()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    self.gun_struct = spawnstruct();
    self.gun_struct.data_index = 0;
    self.gun_struct.max_points = 3;
    self.gun_struct.data = [];

    for ( var_0 = 0; var_0 < self.gun_struct.max_points; var_0++ )
    {
        self.gun_struct.data[var_0] = spawnstruct();
        var_1 = self.player_driver getangles();
        self.gun_struct.data[self.gun_struct.data_index].yaw = var_1[1];
        self.gun_struct.data[self.gun_struct.data_index].pitch = var_1[0];
        self.gun_struct.data[self.gun_struct.data_index].time = gettime();
        self.gun_struct.data_index = ( self.gun_struct.data_index + 1 ) % self.gun_struct.max_points;
    }

    for (;;)
    {
        if ( isdefined( self.player_driver ) && isdefined( self.mgturret[0] ) )
        {
            var_1 = self.player_driver getangles();
            self.gun_struct.data[self.gun_struct.data_index].yaw = var_1[1];
            self.gun_struct.data[self.gun_struct.data_index].pitch = var_1[0];
            self.gun_struct.data[self.gun_struct.data_index].time = gettime();
            self.gun_struct.data_index = ( self.gun_struct.data_index + 1 ) % self.gun_struct.max_points;
            var_2 = angleclamp180( var_1[0] );
            var_3 = maps\_shg_utility::linear_map_clamp( var_2, -11, 13, -12000, 16000 );
            var_2 = angleclamp( var_1[1] );
            var_3 = maps\_shg_utility::linear_map_clamp( var_2, 0, 360, -12000, 16000 );
        }

        wait 0.05;
    }
}

get_wheel_velocity( var_0 )
{
    if ( isdefined( self.current_wheel_pos[var_0] ) && isdefined( self.last_wheel_pos[var_0] ) )
    {
        var_1 = self.current_wheel_pos[var_0] - self.last_wheel_pos[var_0];
        return var_1 * 20;
    }

    return ( 0, 0, 0 );
}

get_gun_pitch_rate()
{
    if ( !isdefined( self.gun_struct ) )
        return 0;

    var_0 = self.gun_struct.data_index;
    var_1 = ( self.gun_struct.data_index + 1 ) % self.gun_struct.max_points;
    var_2 = ( self.gun_struct.data_index + self.gun_struct.max_points - 1 ) % self.gun_struct.max_points;
    var_3 = ( self.gun_struct.data[var_0].pitch + self.gun_struct.data[var_1].pitch ) / 2;
    var_4 = ( self.gun_struct.data[var_1].pitch + self.gun_struct.data[var_2].pitch ) / 2;
    var_5 = angleclamp180( var_4 - var_3 );
    var_6 = self.gun_struct.data[var_2].time - self.gun_struct.data[var_0].time;
    return var_5 * 1000 / var_6;
}

get_gun_yaw_rate()
{
    if ( !isdefined( self.gun_struct ) )
        return 0;

    var_0 = self.gun_struct.data_index;
    var_1 = ( self.gun_struct.data_index + 1 ) % self.gun_struct.max_points;
    var_2 = ( self.gun_struct.data_index + self.gun_struct.max_points - 1 ) % self.gun_struct.max_points;
    var_3 = ( self.gun_struct.data[var_0].yaw + self.gun_struct.data[var_1].yaw ) / 2;
    var_4 = ( self.gun_struct.data[var_1].yaw + self.gun_struct.data[var_2].yaw ) / 2;
    var_5 = angleclamp180( self.gun_struct.data[var_2].yaw - self.gun_struct.data[var_0].yaw );
    var_6 = self.gun_struct.data[var_2].time - self.gun_struct.data[var_0].time;
    return var_5 * 1000 / var_6;
}
