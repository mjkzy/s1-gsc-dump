// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( "vehicle_vm_x4walkerSplit_wheels" );
    precachemodel( "vehicle_vm_x4walkerSplit_turret" );
    precachemodel( "projectile_rpg7" );
    precacheshader( "bls_ui_turret_targetlock" );
    precacheshader( "bls_ui_turret_targetlock_white" );
    precacheshader( "bls_ui_turret_targetacquired" );
    precacheitem( "mobile_turret_missile" );
    precacherumble( "heavy_1s" );
    precacheshader( "bls_ui_turret_overlay_sm" );
    precacheshader( "bls_ui_turret_overlay_vignette" );
    precacheshader( "bls_ui_turret_missle" );
    precacheshader( "bls_ui_turret_chevron" );
    precacheshader( "bls_ui_turret_chevron_right" );
    precacheshader( "bls_ui_turret_reticle_tl" );
    precacheshader( "bls_ui_turret_reticle_tr" );
    precacheshader( "bls_ui_turret_reticle_bl" );
    precacheshader( "bls_ui_turret_reticle_br" );
    precacheshader( "bls_ui_turret_reticule_hpip" );
    precacheshader( "bls_ui_turret_reticule_vpip" );
    precacheshader( "bls_ui_turret_warning" );
    precachestring( &"_X4WALKER_WHEELS_ENTER" );
    maps\_utility::set_console_status();
    maps\_vehicle::build_template( "x4walker_wheels_turret", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::local_init );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_shoot_shock( "mobile_turret_shoot" );
    maps\_vehicle::build_aianims( ::set_ai_anims );
    build_walker_death( var_2 );

    if ( issubstr( var_2, "explosive" ) )
        maps\_vehicle::build_turret( "x4walker_turret_explosive", "tag_turret", "vehicle_npc_x4walkerSplit_turret", undefined, "manual", 0.2, 0 );
    else
        maps\_vehicle::build_turret( "x4walker_turret", "tag_turret", "vehicle_npc_x4walkerSplit_turret", undefined, "manual", 0.2, 0 );

    register_vehicle_anims( var_2 );
    register_player_anims();
    register_fx();
    level.x4walker_wheels_seoul_turret = 0;
    level.x4walker_wheels_fusion_turret = 0;
    level.x4walker_player_invulnerability = 1;
}

build_walker_death( var_0 )
{
    level._effect["walkerexplode"] = loadfx( "vfx/explosion/vehicle_x4walker_explosion" );
    maps\_vehicle::build_deathmodel( "vehicle_x4walker_wheels", "vehicle_x4walker_wheels_destroyed" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_x4walker_explosion", "TAG_ORIGIN" );
    maps\_vehicle::build_deathquake( 1, 1.6, 500 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

#using_animtree("vehicles");

register_vehicle_anims( var_0 )
{
    maps\_vehicle_shg::add_vehicle_anim( var_0, "idle", %x4walker_wheels_turret_idle );
    maps\_vehicle_shg::add_vehicle_anim( var_0, "cockpit_idle", %x4walker_wheels_turret_cockpit_idle );
}

register_fx()
{
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
    common_scripts\utility::flag_init( "player_in_x4walker" );
    waittillframeend;
    self.mgturret[0] _meth_8136();
    self.mgturret[0] _meth_8115( #animtree );
    self notify( "stop_vehicle_shoot_shock" );
    vehicle_scripts\_x4walker_wheels_turret_aud::snd_init_x4_walker_wheels_turret();
}

set_ai_anims()
{
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].sittag = "tag_guy";
    return var_0;
}

#using_animtree("player");

register_player_anims()
{
    level.scr_anim["_vehicle_player_rig"]["enter_left_turret"] = %x4walker_turret_cockpit_in_l_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_right_turret"] = %x4walker_turret_cockpit_in_r_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_back_turret"] = %x4walker_turret_cockpit_in_b_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_left_turret"] = %x4walker_turret_cockpit_out_l_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_right_turret"] = %x4walker_turret_cockpit_out_r_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_back_turret"] = %x4walker_turret_cockpit_out_b_vm;
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_left_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_right_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_back_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_left_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_right_turret" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_back_turret" );
}

manage_player_using_mobile_turret()
{
    self endon( "death" );
    self endon( "disable_mobile_turret" );
    thread handle_vehicle_dof();
    self.enter_use_tags = [];

    for ( var_0 = 0; var_0 < 3; var_0++ )
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

    if ( !isdefined( level.mt_use_tags ) )
        level.mt_use_tags = [];

    foreach ( var_1 in self.enter_use_tags )
    {
        var_1 _meth_804D( self );
        var_1 _meth_80DB( &"_X4WALKER_WHEELS_ENTER" );
        var_1 makeusable();
        level.mt_use_tags[level.mt_use_tags.size] = var_1;
    }

    waittillframeend;
    self.tag_player_view = common_scripts\utility::spawn_tag_origin();
    self.tag_player_view _meth_804D( self.mgturret[0], "tag_barrel", ( -38.9526, 6.01624, -46.3999 ), ( 0, 0, 0 ) );
    self.hint_button_locations = [];
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin + anglestoright( self.mgturret[0].angles ) * 60 + ( 0, 0, 10 );
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoright( self.mgturret[0].angles ) * 60 + ( 0, 0, 10 );
    self.hint_button_locations[self.hint_button_locations.size] = common_scripts\utility::spawn_tag_origin();
    self.hint_button_locations[self.hint_button_locations.size - 1].origin = self.mgturret[0].origin - anglestoforward( self.mgturret[0].angles ) * 75 + ( 0, 0, 10 );
    self.hint_buttons = [];

    foreach ( var_10 in self.hint_button_locations )
    {
        var_10 _meth_8092();
        var_10 _meth_804D( self.mgturret[0] );
        self.hint_buttons[self.hint_buttons.size] = var_10 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );
    }

    for (;;)
    {
        self makeunusable();
        wait_for_any_trigger_hit( self.enter_use_tags );

        if ( isdefined( level.player.linked_to_cover ) )
            continue;

        maps\_utility::ent_flag_set( "player_in_transition" );
        soundscripts\_snd::snd_message( "player_enter_walker_anim" );
        var_12 = player_enter_turret();
        maps\_utility::ent_flag_clear( "player_in_transition" );
        thread monitor_turret_rotation_rate();
        level.player notify( "player_in_x4walker" );
        common_scripts\utility::flag_set( "player_in_x4walker" );
        disable_sonic_aoe();
        _func_0D3( "ammoCounterHide", 1 );
        var_13 = undefined;

        if ( common_scripts\utility::flag_exist( "seoul_player_can_exit_x4walker" ) )
            common_scripts\utility::flag_wait( "seoul_player_can_exit_x4walker" );
        else
            var_13 = level.player thread display_exit_hint();

        var_14 = undefined;

        while ( !isdefined( var_14 ) )
        {
            wait_for_exit_message();

            if ( !isalive( level.player ) || !isdefined( level.player.drivingvehicleandturret ) )
                break;

            var_14 = find_best_exit_anim( var_12 );

            if ( isdefined( level.template_script ) && level.template_script == "seoul" )
                var_14 = "exit_back_turret";

            if ( !isdefined( var_14 ) )
            {

            }
        }

        if ( isdefined( var_13 ) )
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
        common_scripts\utility::flag_clear( "player_in_x4walker" );
        enable_sonic_aoe();

        if ( common_scripts\utility::flag_exist( "seoul_player_can_exit_x4walker" ) && common_scripts\utility::flag( "seoul_player_can_exit_x4walker" ) )
            return;
    }
}

disable_sonic_aoe()
{
    thread maps\_sonicaoe::disablesonicaoe();
}

enable_sonic_aoe()
{
    thread maps\_sonicaoe::enablesonicaoe();
}

rotate_player_to_facing_angles( var_0 )
{
    var_1 = level.player common_scripts\utility::spawn_tag_origin();
    level.player _meth_807F( var_1, "tag_origin" );
    var_1 _meth_82B5( var_0.angles, 1 );
    wait 1;
    level.player _meth_804F();
    var_1 delete();
}

display_exit_hint()
{
    var_0 = maps\_hud_util::createclientfontstring( "default", 1.5 );
    var_0.alpha = 0.7;
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.y = 100;
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
        var_2 = "N";
    else if ( var_0 < 135 )
        var_2 = "E";
    else if ( var_0 < 225 )
        var_2 = "S";
    else if ( var_0 < 315 )
        var_2 = "W";
    else
        var_2 = "";

    return var_2;
}

warning_update_text()
{
    self endon( "death" );
    self waittill( "play_damage_warning" );
    self notify( "destroy_compass_text" );
    self.compass_text settext( &"FUSION_X4_WARNING" );
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

    if ( !level.x4walker_wheels_seoul_turret )
    {
        self.positioninworld = 1;
        self.relativeoffset = 1;
        self _meth_80CD( var_0, "tag_aim_animated" );
    }
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

hudoutline_toggle_target( var_0 )
{
    var_1 = self;
    var_2 = 1;

    if ( issubstr( var_1.classname, "script_vehicle_cover_drone" ) )
        return;

    if ( isdefined( var_1.team ) && var_1.team == "allies" || isdefined( var_1.script_team ) && var_1.script_team != "axis" )
        var_2 = 3;

    if ( var_0 )
        var_1 _meth_83FA( var_2, 1 );
    else
        var_1 _meth_83FB();
}

hudoutline_toggle_all( var_0 )
{
    var_1 = [];
    var_1 = common_scripts\utility::array_combine( var_1, _func_0D6( "axis", "allies" ) );
    var_1 = common_scripts\utility::array_combine( var_1, vehicle_getarray() );

    foreach ( var_3 in var_1 )
        var_3 hudoutline_toggle_target( var_0 );
}

hudoutline_spawner_think()
{
    level endon( "x4walker_hudoutline_think_stop" );

    for (;;)
    {
        self waittill( "spawned", var_0 );
        var_0 hudoutline_toggle_target( 1 );
    }
}

hudoutline_spawner_all()
{
    var_0 = [];
    var_0 = common_scripts\utility::array_combine( var_0, _func_0D8() );
    var_0 = common_scripts\utility::array_combine( var_0, vehicle_getspawnerarray() );

    foreach ( var_2 in var_0 )
        var_2 thread hudoutline_spawner_think();
}

hudoutline_dvars_set()
{
    if ( !isdefined( level.hudoutlinedvars ) )
        level.hudoutlinedvars = [];

    level.hudoutlinedvars["r_hudoutlineenable"] = getdvar( "r_hudoutlineenable", 0 );
    level.hudoutlinedvars["r_hudoutlinepostmode"] = getdvar( "r_hudoutlinepostmode", 0 );
    level.hudoutlinedvars["r_hudoutlinehalolumscale"] = getdvar( "r_hudoutlinehalolumscale", 0 );
    level.hudoutlinedvars["r_hudoutlinehaloblurradius"] = getdvar( "r_hudoutlinehaloblurradius", 0 );
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinepostmode", 2 );
    _func_0D3( "r_hudoutlinehalolumscale", 2 );
    _func_0D3( "r_hudoutlinehaloblurradius", 0.7 );
}

hudoutline_dvars_reset()
{
    if ( !isdefined( level.hudoutlinedvars ) )
        return;

    foreach ( var_1 in getarraykeys( level.hudoutlinedvars ) )
        _func_0D3( var_1, level.hudoutlinedvars[var_1] );
}

hudoutline_think()
{
    common_scripts\utility::flag_wait( "player_in_x4walker" );
    hudoutline_dvars_set();
    hudoutline_toggle_all( 1 );
    hudoutline_spawner_all();
    common_scripts\utility::flag_waitopen( "player_in_x4walker" );
    level notify( "x4walker_hudoutline_think_stop" );
    hudoutline_dvars_reset();
    hudoutline_toggle_all( 0 );
}

player_show_turret_hud()
{
    var_0 = 100000;
    var_1 = 60;
    var_2 = -30000;
    var_3 = 25000;
    var_4 = 5000;
    var_5 = -23000;
    var_6 = 40000;
    var_7 = -40000;
    var_8 = -14500;
    var_9 = 28000;
    var_10 = 21500;
    var_11 = -22500;
    level.player endon( "death" );
    var_12 = getdvar( "hud_fade_ammodisplay" );
    _func_0D3( "hud_fade_ammodisplay", 0.05 );
    self.missiles = [];

    for ( var_13 = 0; var_13 < 4; var_13++ )
    {
        if ( var_13 > 1 )
            var_2 = var_3;

        self.missiles[var_13] = newhudelem();
        self.missiles[var_13] _meth_80CC( "bls_ui_turret_missle", 48, 48 );
        self.missiles[var_13] turret_hud_elem_init( self.mgturret[0] );
        self.missiles[var_13].x = var_0;
        self.missiles[var_13].y = var_2 + var_13 % 2 * var_4;
        self.missiles[var_13].z = var_1 + var_5;
    }

    var_14 = newhudelem();
    var_14 _meth_80CC( "bls_ui_turret_overlay_sm", 1024, 512 );
    var_14 turret_hud_elem_init( self.mgturret[0] );
    var_14.sort = 2;
    var_14.x = var_0;
    var_14.z = var_1;
    var_15 = undefined;

    if ( level.x4walker_wheels_seoul_turret )
    {
        var_15 = newhudelem();
        var_15 _meth_80CC( "bls_ui_turret_overlay_vignette", 640, 480 );
        var_15.horzalign = "fullscreen";
        var_15.vertalign = "fullscreen";
    }

    self.chevron = newhudelem();
    self.chevron _meth_80CC( "bls_ui_turret_chevron", 32, 32 );
    self.chevron turret_hud_elem_init( self.mgturret[0] );
    self.chevron.x = var_0;
    self.chevron.y = var_6;
    self.chevron.z = var_1;
    self.chevron_right = newhudelem();
    self.chevron_right _meth_80CC( "bls_ui_turret_chevron_right", 32, 32 );
    self.chevron_right turret_hud_elem_init( self.mgturret[0] );
    self.chevron_right.x = var_0;
    self.chevron_right.y = var_7;
    self.chevron_right.z = var_1;
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

    for ( var_13 = 0; var_13 < 2; var_13++ )
    {
        self.hud_text[var_13] = maps\_hud_util::createfontstring( "hudsmall", 0.75 );
        self.hud_text[var_13] turret_hud_elem_init( self.mgturret[0] );
        self.hud_text[var_13].x = var_0;
        self.hud_text[var_13].y = var_8 + var_13 * var_9;
        self.hud_text[var_13].z = var_1 + var_11;
    }

    thread update_hud_text();
    thread compass_update_text();
    thread warning_update_text();
    thread player_show_missile_reticle();

    if ( isdefined( level.x4walker_wheels_fusion_turret ) && level.x4walker_wheels_fusion_turret )
        thread hudoutline_think();

    common_scripts\utility::waittill_any( "dismount_vehicle_and_turret", "death" );
    var_14 turret_hud_elem_fadeout();
    self.chevron turret_hud_elem_fadeout();
    self.chevron_right turret_hud_elem_fadeout();
    self.hud_warning turret_hud_elem_fadeout();
    self.compass_text turret_hud_elem_fadeout();

    foreach ( var_17 in self.missiles )
        var_17 turret_hud_elem_fadeout();

    foreach ( var_17 in self.hud_text )
        var_17 turret_hud_elem_fadeout();

    common_scripts\utility::waittill_any( "player_exited_mobile_turret", "death" );
    _func_0D3( "hud_fade_ammodisplay", var_12 );
    var_14 destroy();

    if ( isdefined( var_15 ) )
        var_15 destroy();

    self.chevron destroy();
    self.chevron_right destroy();
    self.hud_warning destroy();
    self notify( "destroy_hud_text" );
    self.compass_text destroy();

    foreach ( var_17 in self.missiles )
        var_17 destroy();

    foreach ( var_17 in self.hud_text )
        var_17 destroy();
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
    self endon( "disable_mobile_turret" );

    if ( !isalive( level.player ) )
        return;

    level.player _meth_80EC( 1 );

    foreach ( var_1 in self.enter_use_tags )
        var_1 makeunusable();

    foreach ( var_4 in self.hint_buttons )
    {
        if ( isdefined( var_4 ) )
            var_4 maps\_shg_utility::hint_button_clear();
    }

    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    var_6 = maps\_vehicle_shg::spawn_player_rig();
    var_6 hide();
    var_7 = distancesquared( level.player.origin, self.enter_use_tags[0].origin );
    var_8 = distancesquared( level.player.origin, self.enter_use_tags[1].origin );
    var_9 = distancesquared( level.player.origin, self.enter_use_tags[2].origin );
    var_10 = var_7;
    var_11 = "enter_left_turret";

    if ( var_8 < var_10 )
    {
        var_10 = var_8;
        var_11 = "enter_right_turret";
    }

    if ( var_9 < var_10 )
    {
        var_10 = var_9;
        var_11 = "enter_back_turret";
    }

    level.player notify( "player_starts_entering_mobile_turret" );
    maps\_anim::anim_first_frame_solo( var_6, var_11, "tag_body" );
    level.player _meth_8080( var_6, "tag_player", 0.2, 0.1, 0.1 );
    wait 0.2;
    thread maps\_utility::lerp_fov_overtime( 2, 55 );
    var_6 show();
    var_6 _meth_808E();
    var_6.vehicle_to_swap = self;
    maps\_anim::anim_single_solo( var_6, var_11, "tag_body" );
    level.player _meth_804F();
    var_6 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();

    if ( level.x4walker_wheels_seoul_turret )
    {

    }
    else
        level.player _meth_820B( self );

    self.mgturret[0] setcontents( 0 );
    self.mgturret[0] _meth_8099( level.player );
    self.mgturret[0] makeunusable();
    level.player _meth_80F4();

    if ( level.x4walker_wheels_seoul_turret )
        level.player _meth_807C( self.mgturret[0], "tag_guy", 0, 180, 180, 90, 2, 0 );
    else
        level.player _meth_807C( self.mgturret[0], "tag_guy", 0, 180, 180, 11, 13, 0 );

    level.player.drivingvehicleandturret = self;
    level.player _meth_8233();

    if ( level.x4walker_wheels_seoul_turret )
        level.player _meth_80FE( 0.65, 0.65 );
    else
        level.player _meth_80FE( 0.5, 0.35 );

    self.player_driver = level.player;
    thread camera_shake();
    self.player_driver _meth_80AD( "damage_light" );
    thread randomize_turret_spread();
    self notify( "driving_vehicle_and_turret" );
    self.player_driver notify( "player_enters_mobile_turret" );
    thread vehicle_scripts\_x4walker_wheels_turret_aud::snd_start_x4_walker_wheels_turret( "plr" );
    thread player_show_turret_hud();

    if ( level.x4walker_player_invulnerability )
    {
        level.player _meth_80EC( 0 );
        level.player _meth_80EF();
    }

    return var_11;
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

find_best_exit_anim( var_0 )
{
    var_1 = [ "exit_left_turret", "exit_right_turret", "exit_back_turret" ];
    var_2 = [ 0, 1, 2 ];

    if ( isdefined( var_0 ) )
    {
        if ( var_0 == "enter_right_turret" )
            var_2 = [ 1, 0, 2 ];
    }

    var_3 = maps\_vehicle_shg::spawn_player_rig();
    var_3 hide();

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

    var_3 delete();
    return undefined;
}

player_exit_turret( var_0 )
{
    level.player endon( "death" );
    self endon( "disable_mobile_turret" );

    if ( !isalive( level.player ) )
        return;

    level.player _meth_80F0();
    level.player _meth_80EC( 1 );
    self.mgturret[0] _meth_8001( self.tag_player_view.origin );
    self.mgturret[0] _meth_8099( level.player );
    level.player _meth_807D( self.tag_player_view, "tag_origin", 1 );
    level.player maps\_shg_utility::setup_player_for_scene();
    wait_for_turret_reset();
    level.player _meth_804F();
    var_1 = maps\_vehicle_shg::spawn_player_rig();
    var_1 hide();
    maps\_anim::anim_first_frame_solo( var_1, var_0, "tag_body" );
    level.player _meth_8080( var_1, "tag_player", 0.2, 0.1, 0.1 );
    wait 0.2;
    var_1 show();
    var_1 _meth_808E();
    var_1.vehicle_to_swap = self;
    level.player.drivingvehicleandturret = undefined;
    self.player_driver = undefined;

    if ( !isdefined( self.burning ) )
    {
        if ( !level.x4walker_wheels_seoul_turret )
            level.player _meth_820C( self );
    }
    else if ( isdefined( self.damage_fx ) )
    {
        foreach ( var_3 in self.damage_fx )
            stopfxontag( common_scripts\utility::getfx( var_3.name ), self.mgturret[0], var_3.tag );
    }

    self notify( "dismount_vehicle_and_turret" );
    level.player _meth_807D( var_1, "tag_player", 1, 0, 0, 0, 0, 1 );
    thread vehicle_scripts\_x4walker_wheels_turret_aud::snd_start_x4_walker_wheels_turret( "npc" );
    maps\_anim::anim_single_solo( var_1, var_0, "tag_body" );
    level.player _meth_80AD( "damage_light" );
    level.player _meth_804F();
    var_1 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();

    foreach ( var_6 in self.enter_use_tags )
        var_6 makeusable();

    self.hint_buttons = [];

    foreach ( var_9 in self.hint_button_locations )
        self.hint_buttons[self.hint_buttons.size] = var_9 maps\_shg_utility::hint_button_create( "x", "tag_origin", 50, 150 );

    level.player _meth_80EC( 0 );
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
    var_0 = 0;

    while ( var_0 < 1 )
    {
        var_0 = 0;

        while ( level.player usebuttonpressed() && var_0 < 1 )
        {
            var_0 += 0.1;
            waitframe();
        }

        waitframe();
    }
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

monitor_vehicle_mount()
{
    self endon( "death" );
    self _meth_814B( maps\_vehicle_shg::get_vehicle_anim( "idle" ) );

    for (;;)
    {
        self waittill( "driving_vehicle_and_turret" );

        if ( !isdefined( self.player_driver ) )
        {
            thread handle_vehicle_ai();
            make_mobile_turret_unusable();
        }
        else
        {
            thread monitor_turret_shoot();
            thread camera_shake_on_turret_fire();
            thread rocket_think();
        }

        wait_for_exit_message();
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
        self.player_driver _meth_80AD( "heavy_1s" );
    }
}

rocket_think()
{
    self endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    self endon( "end_rocket_think" );
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

acquired_animation( var_0 )
{
    self endon( "death" );
    var_0 endon( "dismount_vehicle_and_turret" );
    wait 0.3;
    _func_09C( self, "bls_ui_turret_targetlock_white" );
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
            var_3 thread acquired_animation( self );
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
        var_8 = length( var_7 );

        if ( var_8 > 2648 )
        {
            var_9 = bullettrace( var_1, var_6 + get_missile_target_offset( var_5 ), 1, self );

            if ( !isdefined( var_9["entity"] ) || !( var_9["entity"] == var_5 ) )
                continue;
        }

        var_7 = vectornormalize( var_7 );
        var_10 = vectordot( var_0, var_7 );
        var_11 = abs( acos( var_10 ) );

        if ( var_11 > 4 )
            continue;

        var_5.target_marked = 1;
        _func_09A( var_5, ( 0, 0, 20 ) );
        _func_09C( var_5, "bls_ui_turret_targetacquired" );
        var_5 thread acquired_animation( self );
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
        _func_09B( var_0 );
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
    self endon( "force_clear_all_turret_locks" );
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
            _func_0D3( "cg_drawCrosshair", 0 );
            self.reticle reticle_show();
            self notify( "target_missile_system" );
        }
        else if ( !var_1 && var_0 )
        {
            var_0 = 0;
            _func_0D3( "cg_drawCrosshair", 1 );
            self.reticle reticle_hide();
            self notify( "fire_missile_system" );
        }

        update_missile_hud();
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
        _func_09C( var_2, "bls_ui_turret_targetlock" );
        soundscripts\_snd::snd_message( "x4_walker_hud_missile_launched", var_2 );
        thread fire_rocket_at( var_2, var_4 );
        var_4++;
        wait 0.35;
    }
}

fire_rocket_at( var_0, var_1 )
{
    if ( !isdefined( self.launcher_index ) )
        self.launcher_index = 0;
    else
    {
        self.launcher_index++;
        self.launcher_index %= 4;
    }

    var_2 = var_0.origin;
    var_1 = self.launcher_index + 1;
    var_3 = "TAG_LAUNCHER" + var_1;
    var_4 = undefined;

    switch ( var_1 )
    {
        case 1:
            var_4 = %x4walkersplit_cockpit_rockets_fire4;
            break;
        case 2:
            var_4 = %x4walkersplit_cockpit_rockets_fire3;
            break;
        case 3:
            var_4 = %x4walkersplit_cockpit_rockets_fire2;
            break;
        case 4:
            var_4 = %x4walkersplit_cockpit_rockets_fire1;
            break;
    }

    self.mgturret[0] _meth_8143( var_4, 1, 0, 1 );
    var_5 = self.mgturret[0] gettagorigin( var_3 );
    var_6 = self.mgturret[0] gettagangles( var_3 );
    var_7 = var_5 + anglestoforward( var_6 ) * 512;
    playfxontag( common_scripts\utility::getfx( "x4walker_wheels_rpg_fv" ), self.mgturret[0], var_3 );

    if ( isdefined( self.player_driver ) )
        var_8 = magicbullet( "mobile_turret_missile", var_5, var_7, self.player_driver );
    else
        var_8 = magicbullet( "mobile_turret_missile", var_5, var_7 );

    var_8 soundscripts\_snd::snd_message( "x4_walker_fire_missile", var_0 );
    var_8 _meth_81D9( var_0 );
    var_8 _meth_81DC();
    var_8 waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        if ( isai( var_0 ) )
            check_fire_and_forget();

        var_0 notify( "remove_target" );
    }
}

check_fire_and_forget()
{
    if ( getdvar( "mapname" ) == "fusion" )
    {
        if ( !isdefined( level.fire_and_forget ) )
            level.fire_and_forget = 0;

        level.fire_and_forget++;

        if ( level.fire_and_forget >= 10 && level.fire_and_forget < 20 )
            maps\_utility::giveachievement_wrapper( "LEVEL_4A" );
    }
}

handle_vehicle_ai()
{
    if ( isdefined( self.ai_func_override ) )
        self thread [[ self.ai_func_override ]]();
    else
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
}

swap_cockpit_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        var_0.vehicle_to_swap notify( "enter_vehicle_dof" );
        var_0.vehicle_to_swap _meth_80B1( "vehicle_vm_x4walkerSplit_wheels" );
        var_0.vehicle_to_swap.mgturret[0] _meth_80B1( "vehicle_vm_x4walkerSplit_turret" );
        var_0.vehicle_to_swap _meth_827C( var_0.vehicle_to_swap.origin, var_0.vehicle_to_swap.angles );
        var_0.vehicle_to_swap notify( "play_anim", "cockpit_idle" );
        level notify( "swapped_x4walker", var_0.vehicle_to_swap );
    }
}

swap_world_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        var_0.vehicle_to_swap notify( "exit_vehicle_dof" );
        var_0.vehicle_to_swap _meth_80B1( "vehicle_npc_x4walkerSplit_wheels" );
        var_0.vehicle_to_swap.mgturret[0] _meth_80B1( "vehicle_npc_x4walkerSplit_turret" );
        var_0.vehicle_to_swap _meth_827C( var_0.vehicle_to_swap.origin, var_0.vehicle_to_swap.angles );
        var_0.vehicle_to_swap notify( "play_anim", "idle" );
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
        }

        if ( isdefined( self.hint_buttons ) )
        {
            foreach ( var_4 in self.hint_buttons )
                var_4 maps\_shg_utility::hint_button_clear();

            self.hint_buttons = [];
        }

        if ( isdefined( self.tag_player_view ) )
            self.tag_player_view delete();
    }
}

clean_up_vehicle_seoul()
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.enter_use_tags ) )
        {
            foreach ( var_1 in self.enter_use_tags )
                var_1 delete();
        }

        if ( isdefined( self.tag_player_view ) )
            self.tag_player_view delete();
    }
}

monitor_wheel_movements()
{
    self endon( "death" );
    level endon( "kill_wheel_watcher" );
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
            var_3 = maps\_shg_utility::linear_map_clamp( var_2, -11, 13, -6400, 25000 );
            self.chevron.z = var_3;
            var_2 = angleclamp( var_1[1] );
            var_3 = maps\_shg_utility::linear_map_clamp( var_2, 0, 360, -6400, 25000 );
            self.chevron_right.z = var_3;
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
