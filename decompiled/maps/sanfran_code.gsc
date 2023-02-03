// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

handle_drone_opening( var_0 )
{
    maps\sanfran_util::setup_intro();
    level.player maps\_shg_utility::setup_player_for_scene();
    wait 1;
    maps\sanfran_util::show_water_intro();
    level thread intro_moving_ships();
    maps\sanfran_util::delete_roadsurface_bridge();
    level.player unlink();
    level.player disableslowaim();
    common_scripts\utility::flag_set( "msg_vfx_zone2_driving_chase" );
    level thread handle_driving_section();
    level thread vehicle_scripts\_sentinel_survey_drone_hud::hud_end();
}

helicopter_view_intro( var_0 )
{
    var_1 = getent( "intro_drone_position_01", "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    level.player playerlinktodelta( var_1, undefined, 1, 0, 0, 0, 0 );
    level.player playerlinktodelta( var_1, undefined, 1, 8, 8, 4, 4 );
    level.player enableslowaim();
    level.player maps\_shg_utility::setup_player_for_scene();
    level.player lightsetforplayer( "helicopter_view_intro_0" );
    level thread vehicle_scripts\_sentinel_survey_drone_hud::hud_start( level.player, 0.5, 1 );
    soundscripts\_snd::snd_message( "aud_drone_view_intro_start" );
    wait 0.05;
    thread maps\sanfran_util::drone_view_shake( 0.05 );
    var_1 thread maps\sanfran_util::drone_moveto_ent( var_1.target, 40 );
    wait 2;

    if ( !isdefined( var_0 ) )
        common_scripts\utility::flag_set( "flag_dialog_start_intro" );

    var_1 thread maps\sanfran_util::drone_lookat_ent( "fake_mob", 0, 1 );
    wait 0.5;

    if ( !isdefined( var_0 ) )
        common_scripts\utility::flag_set( "flag_dialog_intro_fleet" );

    wait 8.0;
    thread intro_ship_icons();
    common_scripts\utility::flag_set( "flag_zoom_in_fleet" );
    level notify( "aud_drone_view_intro_zoom_in_fleet" );
    level.player lerpfov( 27, 0.25 );
    wait 0.25;
    level.player lerpfov( 30, 0.25 );
    wait 3.25;
    common_scripts\utility::flag_set( "flag_zoom_out_fleet" );
    level notify( "aud_drone_view_intro_zoom_out_fleet" );
    level.player lerpfov( 67, 0.25 );
    wait 0.25;
    level.player lerpfov( 65, 0.25 );
    thread vehicle_scripts\_sentinel_survey_drone_hud::remove_hud_drone_target();
    wait 2.75;

    if ( !isdefined( var_0 ) )
        common_scripts\utility::flag_set( "flag_dialog_intro_cargo" );

    wait 1.0;
    vehicle_scripts\_sentinel_survey_drone_hud::destroy_sentinel_drone_hud();
    level notify( "aud_drone_view_intro_switch_to_camera_2" );
    thread showstatic( 0.1 );
    var_1 = getent( "intro_drone_position_02", "targetname" );
    var_1 thread maps\sanfran_util::drone_lookat_ent( "cargo_ship_2" );
    level.player playerlinktodelta( var_1, undefined, 1, 0, 0, 0, 0 );
    level.player playerlinktodelta( var_1, undefined, 1, 8, 8, 4, 4 );
    common_scripts\utility::flag_set( "flag_cargo_ship" );
    vehicle_scripts\_sentinel_survey_drone_hud::hud_start( level.player, 1.0, 2 );
    var_1 thread maps\sanfran_util::drone_moveto_ent( var_1.target, 40 );
    wait 1.25;
    var_1 thread maps\sanfran_util::drone_lookat_ent( "cargo_ship_2", 0.5, 0, ( -6, -10, 0 ) );
    common_scripts\utility::flag_set( "flag_zoom_in_cargo" );
    level notify( "aud_drone_view_intro_zoom_in_cargo" );
    level.player lerpfov( 43, 0.5 );
    wait 0.5;
    level.player lerpfov( 45, 0.5 );
    level thread narrow_in_camera_play( var_1 );
    wait 0.5;
    wait 2.0;
    level notify( "stop_narrow_play" );

    if ( !isdefined( var_0 ) )
    {
        wait 1.5;
        common_scripts\utility::flag_set( "flag_intro_transition_to_driving" );
        level notify( "aud_drone_view_intro_transition_to_tunnel" );
    }

    if ( level.currentgen )
    {
        if ( !istransientloaded( "sanfran_intro_tr" ) )
            level waittill( "tff_transition_outro_to_intro" );
    }

    vehicle_scripts\_sentinel_survey_drone_hud::destroy_sentinel_drone_hud();
    level.player lightsetforplayer( "helicopter_view_intro_1" );
}

narrow_in_camera_play( var_0 )
{
    level endon( "stop_narrow_play" );
    var_1 = 8;
    var_2 = 4;

    for (;;)
    {
        level.player playerlinktodelta( var_0, undefined, 1, var_1, var_1, var_2, var_2 );
        wait 0.05;
        var_1 = clamp( var_1 - 0.08, 4, 8 );
        var_2 = clamp( var_2 - 0.04, 2, 4 );
    }
}

fadeupstatic( var_0 )
{
    level.overlaystatic = newhudelem( level.player );
    level.overlaystatic.x = 0;
    level.overlaystatic.y = 0;
    level.overlaystatic.alpha = 0;
    level.overlaystatic.horzalign = "fullscreen";
    level.overlaystatic.vertalign = "fullscreen";
    level.overlaystatic.sort = 4;
    level.overlaystatic setshader( "overlay_static_digital", 640, 480 );
    level.overlaystatic2 = newhudelem( level.player );
    level.overlaystatic2.x = 0;
    level.overlaystatic2.y = 0;
    level.overlaystatic2.alpha = 0;
    level.overlaystatic2.color = ( 0.1, 0.1, 0.1 );
    level.overlaystatic2.horzalign = "fullscreen";
    level.overlaystatic2.vertalign = "fullscreen";
    level.overlaystatic2.sort = 5;
    level.overlaystatic2 setshader( "sentinel_drone_overlay", 640, 480 );
    var_1 = 0.05 / var_0;

    while ( level.overlaystatic.alpha < 1 )
    {
        level.overlaystatic.alpha += var_1;
        level.overlaystatic2.alpha = level.overlaystatic.alpha;
        wait 0.05;
    }
}

fadedownstatic( var_0 )
{
    var_1 = 0.05 / var_0;

    while ( level.overlaystatic.alpha >= 0 )
    {
        level.overlaystatic.alpha -= var_1;
        level.overlaystatic2.alpha = level.overlaystatic.alpha;
        wait 0.05;
    }

    level.overlaystatic destroy();
    level.overlaystatic2 destroy();
}

showstatic( var_0 )
{
    level.overlaystatic = newhudelem( level.player );
    level.overlaystatic.x = 0;
    level.overlaystatic.y = 0;
    level.overlaystatic.alpha = 1;
    level.overlaystatic.horzalign = "fullscreen";
    level.overlaystatic.vertalign = "fullscreen";
    level.overlaystatic.sort = 4;
    level.overlaystatic setshader( "overlay_static_digital", 640, 480 );
    wait(var_0);
    level.overlaystatic destroy();
}

intro_moving_ships()
{
    maps\sanfran_util::toggle_off_real_mob();
    var_0 = [];
    var_1 = [];
    var_0[var_0.size] = getent( "fake_mob", "targetname" );
    var_0[var_0.size] = getent( "cargo_ship", "targetname" );
    var_0[var_0.size] = getent( "cargo_ship_2", "targetname" );
    var_2 = getentarray( "navy_ship", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_2 );
    var_2 = getentarray( "navy_ship_right", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_2 );

    foreach ( var_4 in var_0 )
        var_4 thread moveboat();

    if ( level.nextgen )
        wait 60;
    else if ( !istransientloaded( "sanfran_outro_tr" ) )
        level waittill( "tff_transition_intro_to_outro" );

    foreach ( var_4 in var_0 )
    {
        var_4 notify( "stop_ship_moving" );
        var_4 maps\sanfran_fx::stop_wakefx();
        var_4.origin = var_4.original_org;
        var_4.angles = var_4.original_ang;
    }

    thread maps\sanfran_util::init_bobbing_boats();
}

moveboat()
{
    maps\sanfran_fx::attach_wakefx();
    position_for_movement();

    if ( self.model == "vehicle_atlas_decoy_cargo_ship" )
        thread start_moving_with_bob();
    else
        self moveto( self.original_org, 120, 0, 0 );
}

start_moving_with_bob()
{
    self endon( "stop_ship_moving" );
    var_0 = 1;
    var_1 = 120;

    for (;;)
    {
        var_2 = randomfloatrange( 3, 5 );
        var_3 = self.original_org - self.origin;
        var_4 = var_3 / var_1 * var_2;
        var_5 = self.origin + var_4;
        var_6 = var_0 * randomfloatrange( 125, 175 );
        self moveto( var_5 + ( 0, 0, var_6 ), var_2, 0, 0 );
        wait(var_2);
        var_0 *= -1;
        var_1 -= var_2;
    }
}

intro_ship_icons()
{
    level endon( "remove_hud_drone_target" );
    var_0 = [];
    var_0[var_0.size] = getent( "cargo_ship", "targetname" );
    var_0[var_0.size] = getent( "cargo_ship_2", "targetname" );
    var_1 = getentarray( "navy_ship", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_2 = getent( "fake_mob", "targetname" );
    var_2 vehicle_scripts\_sentinel_survey_drone_hud::create_hud_drone_target( 1 );

    foreach ( var_4 in var_0 )
    {
        var_4 vehicle_scripts\_sentinel_survey_drone_hud::create_hud_drone_target( 0 );
        soundscripts\_snd::snd_message( "aud_drone_view_intro_target" );
        wait 0.25;
    }
}

position_for_movement()
{
    self.original_org = self.origin;
    self.original_ang = self.angles;
    var_0 = 0.35;

    if ( self.model == "vehicle_cvn_carrier" )
        var_0 = 0.75;

    if ( self.model == "vehicle_atlas_decoy_cargo_ship" )
        var_0 = 0.65;

    if ( self.model == "vehicle_naval_littoral" )
        var_0 = 0.3;

    var_1 = getent( self.target, "targetname" );
    var_2 = self.origin - var_1.origin;
    var_3 = var_1.origin - var_0 * var_2;
    var_4 = vectortoangles( var_2 );
    self.origin = var_3;
    self.angles = var_4;
    self moveto( var_1.origin, 0.5, 0, 0 );
    wait 0.5;
}

handle_driving_section( var_0 )
{
    if ( isdefined( var_0 ) )
        maps\_utility::autosave_by_name();

    var_1 = !isdefined( var_0 );
    common_scripts\utility::flag_set( "flag_dialog_start_tunnel" );
    soundscripts\_snd::snd_message( "setup_audio_zone_tunnel" );
    setup_player_pitbull( var_1 );
    level thread handle_chase_van();
    level thread handle_friendly_pitbull();

    if ( !isdefined( var_0 ) || var_0 == "tunnel" )
    {
        level.player thread flag_construction_enable_pitbull_shooting();

        if ( level.nextgen )
            setsaveddvar( "r_umbraAccurateOcclusionThreshold", "400" );

        thread umbra_override_tunnel();
    }

    level thread start_vehicle_traffic();
    level thread pitbull_update_hud_brightness();

    if ( var_1 )
    {
        maps\sanfran_util::make_bridge_big();
        common_scripts\utility::flag_set( "flag_dialog_tunnel_chase" );
        thread maps\sanfran_util::intro_drive_hint();
        thread pitbull_intro_animation();
        common_scripts\utility::flag_set( "start_tunnel_lighting" );
        wait 0.05;
        level.player lerpfov( 65, 0.1 );
    }
    else if ( var_0 == "oncoming" )
    {
        common_scripts\utility::flag_set( "flag_hud_brighten" );
        maps\sanfran_util::make_bridge_big();
    }
    else if ( var_0 == "bridge" )
        common_scripts\utility::flag_set( "flag_hud_brighten" );

    maps\sanfran_util::toggle_all_boats_off();
    maps\sanfran_util::show_water_final();
    thread maps\_player_exo::player_exo_deactivate();
    level thread handle_atlas_intercepts();
    common_scripts\utility::run_thread_on_targetname( "trigger_driving_save", ::driving_section_save );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_crash_bus", ::start_crash_bus );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_construction_heli", ::start_construction_heli );
    common_scripts\utility::run_thread_on_targetname( "trigger_open_gate", ::crash_open_gate );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_tanker", ::start_tanker_explosion );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_blocking_police", ::start_blocking_police );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_knocked_to_oncoming", ::start_knocked_to_oncoming );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_bridge_helicopter", ::start_bridge_heli );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_player_crash", ::player_crash );
    common_scripts\utility::run_thread_on_targetname( "trigger_make_bridge_small", maps\sanfran_util::trigger_bridge_small );
    common_scripts\utility::run_thread_on_targetname( "trigger_toggle_on_boats", maps\sanfran_util::toggle_all_boats_on_trigger );

    if ( !isdefined( var_0 ) )
    {
        common_scripts\utility::flag_wait( "flag_pitbull_allow_shooting" );

        while ( !isdefined( level.atlas_intercepts ) )
            wait 0.5;

        maps\sanfran_util::enable_pitbull_shooting();
        level.player_pitbull waittill( "set_new_target" );
        wait 1;
        level thread maps\sanfran_util::intro_shoot_hint();
        common_scripts\utility::flag_set( "flag_player_can_fire" );
        common_scripts\utility::flag_wait( "flag_player_has_shot_pitbull" );
        wait 1.0;
    }
}

pitbull_update_hud_brightness()
{
    common_scripts\utility::flag_wait( "flag_hud_brighten" );
    level.player_pitbull.fake_vehicle_model setmaterialscriptparam( 0.25, 0.5 );
    level.friendly_pitbull thread maps\_vehicle::vehicle_lights_off( "brakelights" );
    level.chase_van thread maps\_vehicle::vehicle_lights_off( "brakelights" );
}

pitbull_play_lui_cinematic()
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingame( "sanfran_dronefeed", 0, 1.0, 1 );
}

pitbull_intro_animation()
{
    waittillframeend;
    thread pitbull_play_lui_cinematic();
    level thread intro_view_traffic();
    maps\sanfran_util::setup_squad_for_scene();
    thread pitbull_intro_control_rumble();
    level.player_pitbull maps\_utility::ent_flag_set( "pitbull_scripted_anim" );
    level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
    level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
    var_0 = level.player_pitbull.player_rig;
    var_1 = level.player_pitbull.fake_vehicle_model;
    var_2 = [];
    var_2[0] = var_0;
    var_2[1] = level.burke;
    level.burke notify( "animontagdone", "end" );
    level.burke notify( "pitbull_get_out" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_1 maps\_anim::anim_first_frame_solo( var_1, "pitbull_intro" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "pitbull_intro", "tag_body" );
    var_0 linkto( var_1, "tag_body" );
    thread maps\sanfran_pitbull::show_video_on_driverside();
    level.player dontinterpolate();
    level.player playerlinktodelta( var_0, "tag_player", 1, 10, 10, 5, 5, 1 );
    level.player enableslowaim();
    level.player thread remove_camera_view_angles( var_0 maps\_utility::getanim( "pitbull_intro" ), 0.5, 0.1 );
    level thread anim_van_intro( var_1 );
    var_1 thread maps\_anim::anim_single_solo( var_1, "pitbull_intro" );
    var_1 maps\_anim::anim_single( var_2, "pitbull_intro", "tag_body" );
    var_3 = maps\_vehicle_aianim::anim_pos( level.player_pitbull, 1 );
    var_1 thread maps\sanfran_pitbull::passenger_idle( level.burke, var_3 );
    level.player disableslowaim();
    level.player_pitbull maps\sanfran_pitbull::reconnect_fake_pitbull();
    level.chase_van.lead_pos = "far";
    level.player_pitbull.attachedpath = undefined;
    level.player_pitbull notify( "newpath" );
    level.player_pitbull returnplayercontrol();
    level.player playerlinkedvehicleanglesenable();
    common_scripts\utility::flag_set( "flag_intro_give_player_driving" );
    soundscripts\_snd::snd_message( "intro_give_player_driving" );
    level.player_pitbull maps\_utility::ent_flag_clear( "pitbull_scripted_anim" );
    maps\sanfran_util::setup_squad_for_gameplay();

    if ( level.nextgen )
        maps\_utility::autosave_by_name();
    else
        maps\_utility::autosave_now();

    thread start_reverse_hint();
    thread vehicle_blocked_check();
}

pitbull_intro_control_rumble()
{
    level endon( "flag_intro_give_player_driving" );
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0.intensity = 0.09;
    var_0 common_scripts\utility::delaycall( 11.25, ::stoprumble, "steady_rumble" );
    level.player common_scripts\utility::delaycall( 11.75, ::playrumbleonentity, "heavy_1s" );
    wait 13;
    var_0 delete();
}

remove_camera_view_angles( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = getanimlength( var_0 );
    var_4 = var_3 - var_1 + var_2;

    if ( var_4 > 0 )
        wait(var_4);

    self lerpviewangleclamp( var_1, 0.2, 0.2, 0, 0, 0, 0 );
}

intro_view_traffic()
{
    level endon( "flag_intro_give_player_driving" );
    wait 2.0;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "fake_traffic_intro_truck" );
    level thread maps\_vehicle_traffic::add_script_car( var_0 );
    var_0 thread delete_vehicle_outof_view();
    var_0 thread maps\_vehicle::vehicle_lights_on( "brakelights" );
    var_0 thread maps\sanfran_lighting::setup_car_passing_lights();
    wait 4.0;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "fake_traffic_intro_bus" );
    var_0 thread maps\_vehicle::vehicle_lights_on( "brakelights" );
    var_0 thread maps\sanfran_lighting::setup_car_passing_lights();
    level thread maps\_vehicle_traffic::add_script_car( var_0 );
    var_0 thread delete_vehicle_outof_view();
    wait 4.0;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "fake_traffic_intro_van" );
    var_0 thread maps\_vehicle::vehicle_lights_on( "brakelights" );
    var_0 thread maps\sanfran_lighting::setup_car_passing_lights();
    level thread maps\_vehicle_traffic::add_script_car( var_0 );
    var_0 thread delete_vehicle_outof_view();
}

umbra_override_tunnel()
{
    common_scripts\utility::flag_wait( "flag_hud_brighten" );

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", "256" );
}

use_turn_signal( var_0, var_1 )
{
    self endon( "death" );
    var_2 = [];

    if ( var_0 == "left" )
        var_2 = [ "taillight_left", "mirrorlight_left", "frontsignal_left" ];
    else if ( var_0 == "right" )
        var_2 = [ "taillight_right", "mirrorlight_right", "frontsignal_right" ];

    while ( var_1 > 0 )
    {
        foreach ( var_4 in var_2 )
            maps\_vehicle::vehicle_single_light_on( var_4 );

        wait 0.35;
        var_1 -= 0.35;

        foreach ( var_4 in var_2 )
            maps\_vehicle::vehicle_single_light_off( var_4 );

        wait 0.5;
        var_1 -= 0.5;
    }
}

delete_vehicle_outof_view()
{
    level waittill( "flag_intro_give_player_driving" );

    for (;;)
    {
        if ( !maps\sanfran_util::player_can_see( self.origin, 125 ) )
        {
            self delete();
            break;
        }

        wait 0.05;
    }
}

#using_animtree("vehicles");

anim_van_intro( var_0 )
{
    var_1 = spawn( "script_model", level.chase_van.origin );
    var_1 setmodel( "vehicle_ind_van_utility_ai" );
    var_1.animname = "atlas_van";
    var_1 useanimtree( #animtree );
    var_1 thread wakeup_physics_sphere_on_ent( 195 );
    var_1 thread maps\sanfran_lighting::setup_car_passing_lights();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "pitbull_intro", "tag_turret" );
    var_1 linkto( var_0, "tag_turret" );
    var_0 soundscripts\_snd::snd_message( "chase_van_rabbiting_anim" );
    var_0 maps\_anim::anim_single_solo( var_1, "pitbull_intro", "tag_turret" );
    level.chase_van vehicle_teleport( var_1.origin, level.chase_van.angles );
    var_2 = getvehiclenode( "van_anim_start_drive", "targetname" );
    level.chase_van thread maps\_vehicle_code::_vehicle_paths( var_2 );
    level.chase_van startpath( var_2 );
    var_1 unlink();
    var_1 delete();
    common_scripts\utility::flag_set( "flag_intro_van_anim_finished" );
}

wakeup_physics_sphere_on_ent( var_0 )
{
    self endon( "death" );

    if ( self.code_classname == "script_model" )
    {
        var_1 = 1;
        var_2 = self setcontents( 0 );
        self setcontents( var_2 | var_1 );
    }

    for (;;)
    {
        wakeupphysicssphere( self.origin, var_0 );
        waitframe();
    }
}

start_vehicle_traffic()
{
    wait 0.25;
    var_0 = getent( "player_start_pos", "targetname" );
    thread maps\_vehicle_traffic::setup_traffic_path( "road_path", "bridge_damageable_vehicle_spawner", 1, var_0 );
    thread maps\_vehicle_traffic::setup_traffic_path( "road_path_flood", "bridge_damageable_vehicle_spawner", 1, var_0 );
    thread maps\_vehicle_traffic::setup_traffic_path( "bridge_path", "bridge_damageable_vehicle_spawner", 1, var_0 );
    thread maps\_vehicle_traffic::setup_traffic_path( "bridge_path_split", "bridge_damageable_vehicle_spawner", 1, var_0 );
    thread maps\_vehicle_traffic::setup_traffic_path( "road_onramp", "bridge_damageable_vehicle_spawner", 1, var_0 );
}

setup_player_pitbull( var_0 )
{
    if ( !isdefined( level.player_pitbull ) )
    {
        level.player_pitbull = maps\_vehicle::spawn_vehicle_from_targetname( "player_pitbull" );
        thread maps\_vehicle_traffic::add_script_car( level.player_pitbull );
    }

    level.player_pitbull soundscripts\_snd::snd_message( "pc_pitbull_spawn" );
    level.player unlink();
    level.player_pitbull thread maps\sanfran_aud::player_pitbull_woosh_sounds();
    level.player_pitbull thread maps\sanfran_pitbull::handle_player_pitbull( "player_rig" );
    level.player_pitbull thread mount_pitbull( var_0 );
    level.player_pitbull thread pitbull_flipped_failsafe();
    level.player_pitbull maps\_utility::ent_flag_clear( "pitbull_allow_shooting" );
    setsaveddvar( "bg_viewBobMax", 0 );
    maps\sanfran_util::spawn_squad();
    level.player_pitbull maps\sanfran_pitbull::add_passenger_to_player_pitbull( level.burke, 1 );
    level.player_pitbull maps\sanfran_pitbull::add_passenger_to_player_pitbull( level.saint, 2 );
    level.player_pitbull thread maps\sanfran_fx::vfx_car_radial_damage();
}

flag_construction_enable_pitbull_shooting()
{
    self endon( "death" );
    self endon( "flag_pitbull_allow_shooting" );
    common_scripts\utility::flag_wait( "flag_pitbull_allow_firing" );
    common_scripts\utility::flag_set( "flag_pitbull_allow_shooting" );
}

disable_pitbull_use()
{
    wait 0.25;
    level.player_pitbull makeunusable();
}

mount_pitbull( var_0 )
{
    waittillframeend;
    self notify( "mount_pitbull", var_0 );
}

pitbull_flipped_failsafe()
{
    self endon( "death" );
    self endon( "dismount_pitbull" );
    var_0 = 0;

    for (;;)
    {
        if ( !isdefined( level.player.drivingvehicle ) || level.player.drivingvehicle != self )
        {
            var_0 = 0;
            wait 0.2;
            continue;
        }

        if ( maps\_utility::ent_flag( "pitbull_scripted_anim" ) )
        {
            var_0 = 0;
            maps\_utility::ent_flag_waitopen( "pitbull_scripted_anim" );
            wait 0.2;
            continue;
        }

        var_1 = anglestoup( self.angles );
        var_2 = vectordot( var_1, ( 0, 0, 1 ) );

        if ( var_2 < 0.1 )
            var_0 += 0.2;
        else
            var_0 = 0;

        if ( var_0 >= 2 )
        {
            setdvar( "ui_deadquote", &"SANFRAN_FAIL_CHASE" );
            maps\_utility::missionfailedwrapper();
        }

        wait 0.2;
    }
}

handle_chase_van()
{
    var_0 = 0;

    if ( !isdefined( level.chase_van ) )
    {
        level.chase_van = maps\_vehicle::spawn_vehicle_from_targetname( "chase_van" );
        thread maps\_vehicle_traffic::add_script_car( level.chase_van );
        level.chase_van thread maps\_vehicle::vehicle_lights_on( "brakelights" );
        var_0 = 1;
    }

    level.chase_van endon( "death" );
    level.chase_van maps\_vehicle::godon();
    level.chase_van vehphys_disablecrashing();

    if ( var_0 == 1 )
        common_scripts\utility::flag_wait( "flag_intro_van_anim_finished" );

    common_scripts\utility::flag_set( "flag_obj_van_intercept" );
    level.chase_van thread fail_chase_van();

    if ( !isdefined( level.chase_van.lead_pos ) )
        level.chase_van.lead_pos = "far";

    var_1 = undefined;
    common_scripts\utility::run_thread_on_targetname( "trigger_chase_van_set_far", maps\sanfran_util::chase_van_set_far );
    common_scripts\utility::run_thread_on_targetname( "trigger_chase_van_set_medium", maps\sanfran_util::chase_van_set_medium );
    common_scripts\utility::run_thread_on_targetname( "trigger_chase_van_set_close", maps\sanfran_util::chase_van_set_close );

    if ( !common_scripts\utility::flag( "flag_intro_give_player_driving" ) )
    {
        common_scripts\utility::flag_wait( "flag_intro_give_player_driving" );
        level.chase_van vehicle_setspeed( 55, 100, 100 );
    }

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_player_crashed" ) )
            break;

        if ( !isdefined( var_1 ) || var_1 != level.chase_van.lead_pos )
        {
            var_1 = level.chase_van.lead_pos;

            if ( var_1 == "close" )
                level.chase_van thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 1280, 1536, 5, 5, 1, 0, 0, 0, 35 );
            else if ( var_1 == "medium" )
                level.chase_van thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 2176, 2688, 5, 5, 1, 0, 0, 0, 35 );
            else if ( var_1 == "far" )
                level.chase_van thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 3328, 3584, 5, 5, 1, 0, 0, 0, 35 );
            else
            {

            }
        }

        wait 0.05;
    }

    level.chase_van notify( "stop_chase_target" );
    level.chase_van resumespeed( 30 );
}

start_reverse_hint()
{
    level endon( "player_crash_scene" );
    level endon( "display_reverse_tutorial" );

    for (;;)
    {
        if ( isdefined( level.chase_van ) && !common_scripts\utility::flag( "flag_oncoming_scene_playing" ) && !common_scripts\utility::flag( "flag_final_crash_scene_playing" ) || !common_scripts\utility::flag( "missionfailed" ) )
        {
            var_0 = level.player maps\_utility::player_looking_at( level.chase_van.origin, 0.4, 1 );

            if ( !var_0 )
            {
                thread show_reverse_tutorial();
                break;
            }
        }

        wait 0.15;
    }
}

show_reverse_tutorial()
{
    level notify( "display_reverse_tutorial" );

    while ( level.player_pitbull.veh_speed > 10 )
        waitframe();

    common_scripts\utility::flag_set( "flag_reverse_hint_displayed" );
    thread maps\_utility::hintdisplayhandler( "reverse_hint", 5 );
}

show_reverse_tutorial_check()
{
    if ( !isdefined( level.player_pitbull ) )
        return 1;

    if ( level.player_pitbull.veh_speed > 30 || common_scripts\utility::flag( "flag_oncoming_scene_playing" ) || common_scripts\utility::flag( "flag_final_crash_scene_playing" ) )
    {
        common_scripts\utility::flag_clear( "flag_reverse_hint_displayed" );
        return 1;
    }

    return 0;
}

vehicle_blocked_check()
{
    level endon( "player_crash_scene" );
    level endon( "display_reverse_tutorial" );

    for (;;)
    {
        var_0 = level.player_pitbull vehicle_getspeed();

        if ( var_0 < 2 )
        {
            wait 0.8;

            if ( !common_scripts\utility::flag( "flag_oncoming_scene_playing" ) || !common_scripts\utility::flag( "flag_final_crash_scene_playing" ) || !common_scripts\utility::flag( "missionfailed" ) )
            {
                var_1 = 250;
                var_2 = level.player_pitbull gettagorigin( "left_wheel_01_jnt" );
                var_3 = common_scripts\utility::flat_angle( level.player_pitbull gettagangles( "left_wheel_01_jnt" ) );
                var_2 += anglestoforward( var_3 ) * 30;
                var_2 = ( var_2[0], var_2[1] + 45, var_2[2] + 25 );
                var_4 = var_2 + anglestoforward( var_3 ) * var_1;
                var_5 = bullettrace( var_2, var_4, 0, 0, 0, 0, 1 );

                if ( isdefined( var_5["surfacetype"] ) && var_5["surfacetype"] != "none" )
                {
                    thread show_reverse_tutorial();
                    break;
                }
            }
        }

        waitframe();
    }
}

driving_section_save()
{
    self waittill( "trigger" );

    for ( var_0 = 0; var_0 < 5; var_0 += 0.15 )
    {
        var_1 = level.player maps\_utility::player_looking_at( level.chase_van.origin, 0.15, 1 );

        if ( level.player_close_to_fail_dist == 0 && var_1 == 1 )
        {
            for ( var_2 = 0; var_2 < level.players.size; var_2++ )
            {
                var_3 = level.players[var_2];

                if ( !var_3 maps\_autosave::autosavehealthcheck() )
                    break;

                maps\_utility::autosave_now();
            }

            break;
        }

        wait 0.15;
    }
}

fail_chase_van()
{
    level endon( "flag_player_crashed" );
    common_scripts\utility::run_thread_on_targetname( "trigger_leaving_driving_section", ::fail_leaving_area );
    level.player_close_to_fail_dist = 0;
    wait 1.0;

    for (;;)
    {
        var_0 = distance( level.player.origin, self.origin );

        if ( var_0 > 6000 )
        {
            setdvar( "ui_deadquote", &"SANFRAN_FAIL_CHASE" );
            maps\_utility::missionfailedwrapper();
        }
        else if ( var_0 > 4500 && !common_scripts\utility::flag( "flag_reverse_hint_displayed" ) )
        {
            maps\sanfran_util::player_too_far_hint();
            level.player_close_to_fail_dist = 1;
        }
        else
        {
            common_scripts\utility::flag_clear( "flag_hint_player_too_far" );
            level.player_close_to_fail_dist = 0;
        }

        wait 0.15;
    }
}

fail_leaving_area()
{
    if ( !isdefined( level.player_out_of_bounds_count ) )
        level.player_out_of_bounds_count = 0;

    level endon( "flag_player_crashed" );

    for (;;)
    {
        self waittill( "trigger" );
        level.player_out_of_bounds_count++;

        if ( level.player_out_of_bounds_count == 1 )
            level.fail_start_time = gettime();

        maps\sanfran_util::player_left_road_hint();

        while ( level.player istouching( self ) )
        {
            var_0 = gettime();
            var_1 = var_0 - level.fail_start_time;
            wait 0.05;
        }

        wait 0.05;
        level.player_out_of_bounds_count--;

        if ( level.player_out_of_bounds_count == 0 )
            common_scripts\utility::flag_clear( "flag_hint_player_left_road" );
    }
}

handle_friendly_pitbull()
{
    var_0 = 0;

    if ( !isdefined( level.friendly_pitbull ) )
    {
        level.friendly_pitbull = maps\_vehicle::spawn_vehicle_from_targetname( "friendly_pitbull" );
        thread maps\_vehicle_traffic::add_script_car( level.friendly_pitbull );
        level.friendly_pitbull thread maps\_vehicle::vehicle_lights_on( "brakelights" );
        var_0 = 1;
    }

    level.friendly_pitbull endon( "death" );
    level.friendly_pitbull maps\_vehicle::godon();
    level.friendly_pitbull vehphys_disablecrashing();

    if ( var_0 == 1 )
    {
        common_scripts\utility::flag_wait( "flag_intro_van_anim_finished" );
        level.friendly_pitbull startpath();
    }

    if ( !isdefined( level.friendly_pitbull.shadow_pos ) )
        level.friendly_pitbull.shadow_pos = "player";

    var_1 = undefined;
    common_scripts\utility::run_thread_on_targetname( "trigger_pitbull_shadow_chase_van", maps\sanfran_util::friendly_pitbull_shadow_chase_van );
    common_scripts\utility::run_thread_on_targetname( "trigger_pitbull_shadow_player", maps\sanfran_util::friendly_pitbull_shadow_player );
    level.friendly_pitbull thread maps\sanfran_pitbull::handle_friendly_pitbull_shooting();
    level.friendly_pitbull thread maps\sanfran_util::vehicle_oscillate_location( 1024, 3 );

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_player_crashed" ) )
            break;

        if ( !isdefined( var_1 ) || var_1 != level.friendly_pitbull.shadow_pos )
        {
            var_1 = level.friendly_pitbull.shadow_pos;

            if ( var_1 == "van" )
                level.friendly_pitbull thread maps\sanfran_util::vehicle_chase_target( level.chase_van, 768, 1024, 5, 5, 0, 1, 1, 0 );
            else if ( var_1 == "player" )
                level.friendly_pitbull thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 768, 1024, 5, 5, 1, 0, 1, 0 );
            else
            {

            }
        }

        wait 0.05;
    }

    level.friendly_pitbull notify( "stop_chase_target" );
    level.friendly_pitbull resumespeed( 30 );
}

handle_atlas_intercepts()
{
    level endon( "flag_player_crashed" );
    common_scripts\utility::run_thread_on_targetname( "trigger_spawn_atlas_intercept", ::spawn_atlas_intercept );

    if ( !isdefined( level.atlas_intercepts ) )
        level.atlas_intercepts = [];

    for (;;)
    {
        level.atlas_intercepts = maps\_utility::array_removedead( level.atlas_intercepts );
        wait 0.05;
    }
}

delete_atlas_intercepts()
{
    foreach ( var_1 in level.atlas_intercepts )
        var_1 delete();
}

spawn_atlas_intercept()
{
    level endon( "flag_player_crashed" );
    self waittill( "trigger" );

    for ( var_0 = 0; var_0 < level.atlas_intercepts.size; var_0++ )
    {
        if ( level.atlas_intercepts[var_0].targetname == self.script_noteworthy )
            return;
    }

    var_1 = getent( self.target, "targetname" );

    if ( maps\sanfran_util::player_can_see( var_1.origin, 45 ) )
        return;

    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_1.targetname );
    thread maps\_vehicle_traffic::add_script_car( var_2 );
    var_2.script_noteworthy = "target_vehicle";
    var_2.targetname = self.script_noteworthy;

    foreach ( var_4 in var_2.riders )
        var_4.accuracy = 200;

    var_2 thread cleanup_atlas_on_death();
    level.atlas_intercepts[level.atlas_intercepts.size] = var_2;
    var_6 = randomint( 100 );

    if ( var_2.targetname == "right_atlas_intercept" )
    {
        if ( var_6 < 50 )
            var_2 thread maps\sanfran_util::vehicle_chase_target( level.chase_van, 512, 768, 5, 5, 0, 1, 1, 1 );
        else
            var_2 thread maps\sanfran_util::vehicle_chase_target( level.friendly_pitbull, 256, 384, 5, 5, 0, 1, 1, 1 );
    }
    else if ( level.chase_van.lead_pos == "close" )
    {
        if ( var_6 < 10 )
            var_2 thread maps\sanfran_util::vehicle_chase_target( level.chase_van, 512, 768, 5, 5, 0, 1, 1, 1 );
        else if ( var_6 < 55 )
            var_2 thread maps\sanfran_util::vehicle_chase_target( level.friendly_pitbull, 256, 384, 5, 5, 0, 1, 1, 1 );
        else
            var_2 thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 1024, 1280, 5, 5, 1, 0, 1, 1 );
    }
    else if ( var_6 < 50 )
        var_2 thread maps\sanfran_util::vehicle_chase_target( level.friendly_pitbull, 256, 384, 5, 5, 0, 1, 1, 1 );
    else
        var_2 thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 1024, 1280, 5, 5, 1, 0, 1, 1 );

    var_2 thread maps\_vehicle_traffic::detect_being_pushed( ::delete_atlas_intercept );

    if ( isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == "crash_at_end" )
    {
        wakeupphysicssphere( var_1.origin, 195 );
        var_2 thread maps\sanfran_util::wait_for_crash_at_end();
    }

    common_scripts\utility::flag_wait( "flag_player_crashed" );
    self notify( "stop_chase_target" );
    self resumespeed( 30 );
}

delete_atlas_intercept()
{
    self dodamage( 1000000000, self.origin );
}

cleanup_atlas_on_death()
{
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_2 ) && var_2 == "pitbull_turret" && isdefined( level.player_pitbull ) )
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );

    common_scripts\utility::array_remove( level.atlas_intercepts, self );
    wait 5.0;

    if ( isdefined( self ) )
        self delete();
}

start_crash_bus()
{
    self waittill( "trigger" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "veh_crash_bus" );
    var_0 maps\_vehicle::godon();
    thread maps\_vehicle_traffic::add_script_car( var_0 );
    thread maps\_vehicle_traffic::clear_cars_around_pos( var_0.origin, 2000 );
    var_0 vehphys_disablecrashing();
    var_0 thread bus_crash_at_end();
    level thread maps\sanfran_util::get_vehicles_to_point_at_same_time( level.chase_van, "bus_crash_location", var_0, undefined, "stop_bus_syncup" );
}

bus_crash_at_end()
{
    self waittill( "reached_end_node" );
    level notify( "stop_bus_syncup" );
    self vehphys_setspeed( 0, 10000, 10000 );
    self.animname = "bus";
    self useanimtree( #animtree );
    maps\_utility::anim_stopanimscripted();
    soundscripts\_snd::snd_message( "bus_crash_start" );
    common_scripts\utility::flag_set( "flag_dialog_tunnel_bus" );
    thread bus_crash_setup_backup_collision();
    thread bus_crash_hold_on_last_frame();
    var_0 = getent( "bus_crash_origin", "targetname" );
    var_0 maps\_anim::anim_single_solo( self, "bus_crash" );
    thread maps\_vehicle_traffic::remove_script_car( self );
    maps\_vehicle::godoff();
}

bus_crash_setup_backup_collision()
{
    var_0 = getanimlength( maps\_utility::getanim( "bus_crash" ) ) - 1;
    wait(var_0);
    maps\sanfran_util::show_ents_by_targetname( "bus_crash_final_pos_col" );
    maps\sanfran_util::solid_ents_by_targetname( "bus_crash_final_pos_col" );
}

bus_crash_hold_on_last_frame()
{
    wait(getanimlength( maps\_utility::getanim( "bus_crash" ) ) - 0.1);
    self setanimrate( maps\_utility::getanim( "bus_crash" ), 0 );
}

start_construction_heli()
{
    self waittill( "trigger" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "construction_heli" );
    var_0 waittill( "heli_at_construction" );
    var_0 thread maps\sanfran_util::vehicle_chase_target( level.player_pitbull, 2800, 3000, 0, 0, 1, 0, 0, 0 );
    common_scripts\utility::run_thread_on_targetname( "trigger_heli_start_shooting", ::construction_heli_shoot, var_0 );
    var_0 waittill( "heli_at_tanker" );
    var_0 notify( "stop_chase_target" );
    var_0 resumespeed( 80 );
}

construction_heli_shoot( var_0 )
{
    self waittill( "trigger" );
    var_1 = [];
    var_2 = 1;

    for (;;)
    {
        var_3 = getent( "heli_construction_target_" + var_2, "targetname" );

        if ( !isdefined( var_3 ) )
            break;

        var_1[var_1.size] = var_3;
        var_2++;
    }

    var_4 = magicbullet( "pitbull_magicbullet", var_0.origin + ( 0, 0, -150 ), var_1[0].origin );
    var_4 soundscripts\_snd::snd_message( "npc_heli_shot", var_0 );
    wait 1.0;
    var_4 = magicbullet( "pitbull_magicbullet", var_0.origin + ( 0, 0, -150 ), var_1[1].origin );
    var_4 soundscripts\_snd::snd_message( "npc_heli_shot", var_0 );
    wait 1.0;
    var_4 = magicbullet( "pitbull_magicbullet", var_0.origin + ( 0, 0, -150 ), var_1[2].origin );
    var_4 soundscripts\_snd::snd_message( "npc_heli_shot", var_0 );
}

crash_open_gate()
{
    self waittill( "trigger", var_0 );
    soundscripts\_snd::snd_message( "gate_crash" );
    common_scripts\utility::run_thread_on_targetname( "construction_gate_left", ::crash_open_left_gate );
    common_scripts\utility::run_thread_on_targetname( "construction_gate_right", ::crash_open_right_gate );
    thread maps\sanfran_fx::vfx_gate_crash_open();
    common_scripts\utility::run_thread_on_targetname( "trigger_water_splash", ::water_splash );
}

crash_open_left_gate()
{
    var_0 = self.angles;
    var_1 = ( var_0[0], var_0[1] + 80, var_0[2] );
    self rotateto( var_1, 0.4, 0, 0.1 );
}

crash_open_right_gate()
{
    var_0 = self.angles;
    var_1 = ( var_0[0], var_0[1] - 100, var_0[2] );
    self rotateto( var_1, 0.4, 0, 0.1 );
}

water_splash()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( !isdefined( var_0.splashing_water ) )
            var_0.splashing_water = 0;

        if ( var_0.splashing_water == 0 )
            var_0 thread vehicle_splash_water( self );
    }
}

vehicle_splash_water( var_0 )
{
    self endon( "death" );
    self.splashing_water = 1;
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 thread splash_pos_for_speed( self );

    for (;;)
    {
        wait 0.25;

        if ( !var_1 istouching( var_0 ) )
            break;
    }

    self.splashing_water = 0;
    var_1 unlink();
    var_1 delete();
}

splash_pos_for_speed( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        self unlink();
        var_1 = vectornormalize( var_0 vehicle_getvelocity() );
        var_2 = vectornormalize( anglestoforward( var_0.angles ) );
        var_3 = vectordot( var_1, var_2 );
        var_4 = var_0 vehicle_getspeed();
        var_5 = var_4 / 70 * 450 + 200;

        if ( var_5 > 0.2 )
        {
            if ( var_3 > 0 )
                var_6 = var_0.origin + var_5 * anglestoforward( self.angles );
            else
                var_6 = var_0.origin - var_5 * anglestoforward( self.angles );
        }
        else
            var_6 = var_0.origin + ( 0, 0, -1000 );

        self.origin = var_6;
        self linkto( var_0 );
        wait 0.05;
    }
}

start_tanker_explosion()
{
    self waittill( "trigger" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( self.target );
    var_1 = getent( "crash_truck_cab_brushmodel", "targetname" );
    var_2 = getent( "crash_truck_tank_brushmodel", "targetname" );
    var_1 store_offsets_for_link( var_0, "tag_headlight_right" );
    var_2 store_offsets_for_link( var_0, "tag_brakelight_right" );
    var_1 link_with_stored_offsets( var_0 );
    var_2 link_with_stored_offsets( var_0 );
    level thread start_tanker_on_ramp_traffic();
    level thread handle_tanker_missiles( var_0 );
    level thread maps\sanfran_util::get_vehicles_to_point_at_same_time( level.chase_van, "tanker_missile_location", var_0, "tanker_missile_location" );

    if ( level.currentgen )
    {
        level waittill( "tff_pre_transition_intro_to_outro" );
        var_2 delete();
        var_1 delete();
    }
}

store_offsets_for_link( var_0, var_1 )
{
    self.link_tag = var_1;
    self.link_offset = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), var_0 gettagorigin( var_1 ), var_0 gettagangles( var_1 ), self.origin, self.angles );
}

link_with_stored_offsets( var_0 )
{
    self linkto( var_0, self.link_tag, self.link_offset["origin"], self.link_offset["angles"] );
}

handle_tanker_missiles( var_0 )
{
    level.chase_van thread fire_first_tanker_missile( var_0 );
    var_0 thread wait_for_missile();
}

fire_first_tanker_missile( var_0 )
{
    self waittill( "tanker_first_missile_location" );
    var_1 = self.origin + ( 0, 0, 100 ) + 100 * anglestoright( self.angles );
    var_2 = var_0.origin + ( 0, 0, 100 ) + -300 * anglestoforward( var_0.angles );
    magicbullet( "rpg_nodamage", var_1, var_2 );
}

wait_for_missile()
{
    self waittill( "tanker_missile_location" );
    wait 0.05;
    self resumespeed( 20 );
    var_0 = 50;

    for (;;)
    {
        var_1 = level.chase_van.origin + ( 0, 0, var_0 ) + 100 * anglestoright( level.chase_van.angles );
        var_2 = self.origin + ( 0, 0, 64 ) + 400 * anglestoforward( self.angles );
        var_3 = bullettrace( var_1, var_2, 1 );

        if ( !isdefined( var_3["entity"] ) && var_3["fraction"] > 0.9 )
            break;

        var_0 += 5;

        if ( var_0 > 100 )
            break;
    }

    magicbullet( "rpg_nodamage", var_1, var_2 );
    wait 1.0;
    level thread tanker_roll_explosion( self );
}

tanker_roll_explosion( var_0 )
{
    common_scripts\utility::flag_set( "flag_dialog_tunnel_tanker" );
    var_1 = getent( "tanker_crash_origin", "targetname" );
    var_2 = distance( var_0.origin, var_1.origin );

    for (;;)
    {
        wait 0.05;
        var_3 = distance( var_0.origin, var_1.origin );

        if ( var_3 > var_2 )
            break;

        var_2 = var_3;
    }

    var_4 = spawn( "script_model", ( 0, 0, 0 ) );
    var_4 setmodel( "vehicle_ind_semi_truck_fuel_tanker" );
    var_4.animname = "tanker";
    var_4 useanimtree( #animtree );
    var_4.origin = var_0.origin;
    var_4.angles = var_0.angles;
    var_5 = getent( "crash_truck_cab_brushmodel", "targetname" );
    var_6 = getent( "crash_truck_tank_brushmodel", "targetname" );
    var_5 link_with_stored_offsets( var_4 );
    var_6 link_with_stored_offsets( var_4 );
    var_0 delete();
    var_4 soundscripts\_snd::snd_message( "aud_tanker_crash" );
    var_4 thread maps\sanfran_fx::oil_tanker_crash_fx();
    var_1 maps\_anim::anim_single_solo( var_4, "tanker_crash" );
}

start_tanker_on_ramp_traffic()
{
    wait 3.0;
    maps\_vehicle_traffic::spawn_single_vehicle_for_lane( "road_onramp_1", "bridge_damageable_vehicle_spawner" );
    wait 3.0;
    maps\_vehicle_traffic::spawn_single_vehicle_for_lane( "road_onramp_1", "bridge_damageable_vehicle_spawner" );
    wait 3.0;
    maps\_vehicle_traffic::spawn_single_vehicle_for_lane( "road_onramp_1", "bridge_damageable_vehicle_spawner" );
}

start_blocking_police()
{
    self waittill( "trigger" );
    var_0 = getent( "police_blocking_collision", "targetname" );
    var_0 notsolid();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( self.target );
    var_1 waittill( "reached_end_node" );
    var_1 vehphys_setspeed( 0 );
    var_2 = spawn( "script_model", var_1.origin );
    var_2 setmodel( var_1.model );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 soundscripts\_snd::snd_message( "spawn_driving_police_car" );
    var_1 delete();
    var_0 solid();
}

start_knocked_to_oncoming()
{
    self waittill( "trigger" );
    common_scripts\utility::flag_set( "flag_dialog_pre_oncoming_knocked" );
    wait 0.4;
    level.player_pitbull maps\_utility::ent_flag_set( "pitbull_scripted_anim" );
    level.player_pitbull maps\_utility::ent_flag_clear( "pitbull_allow_shooting" );
    level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
    level.player enabledeathshield( 1 );
    var_0 = getent( "knocked_to_oncoming_origin", "targetname" );
    thread knocked_to_oncoming_rumble();
    var_1 = level.player_pitbull.player_rig;
    var_2 = level.player_pitbull.fake_vehicle_model;
    var_3 = [];
    var_3[0] = var_1;
    soundscripts\_snd::snd_message( "van_cuts_off_player" );
    thread maps\_vehicle_traffic::clear_cars_around_pos( var_0.origin, 200 );

    foreach ( var_5 in level.atlas_intercepts )
    {
        if ( distance( level.player_pitbull.origin, var_5.origin ) < 200 )
            var_5 delete();
    }

    level.player_pitbull vehicle_teleport( var_0.origin, level.player_pitbull.angles );
    var_2 = level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
    var_7 = maps\_vehicle::spawn_vehicle_from_targetname( "atlas_van_knock_to_oncoming" );
    var_7.animname = "atlas_suv";
    var_7 useanimtree( #animtree );
    var_3 = [];
    var_3[0] = var_2;
    var_3[1] = var_7;
    level.player dontinterpolate();
    var_2 maps\_anim::anim_first_frame_solo( var_2, "oncoming_crash" );
    var_2 maps\_anim::anim_first_frame_solo( var_1, "oncoming_crash", "tag_driver" );
    var_1 linkto( var_2, "tag_driver" );
    common_scripts\utility::flag_set( "flag_dialog_start_oncoming" );
    common_scripts\utility::flag_set( "flag_dialog_oncoming_knocked" );
    common_scripts\utility::flag_set( "flag_oncoming_scene_playing" );

    if ( level.currentgen )
    {
        level.player_pitbull notify( "oncoming_scene_pitbull_monitor_start" );
        thread oncoming_scene_pitbull_speed_monitor();
    }

    var_2 thread maps\_anim::anim_single_solo( var_1, "oncoming_crash", "tag_driver" );
    var_0 maps\_anim::anim_single( var_3, "oncoming_crash" );
    common_scripts\utility::flag_clear( "flag_oncoming_scene_playing" );
    level.player_pitbull maps\sanfran_pitbull::reconnect_fake_pitbull();
    level.player_pitbull vehicle_setspeedimmediate( 55.0, 100, 60 );
    level.player enabledeathshield( 0 );

    if ( level.currentgen )
    {
        level notify( "oncoming_scene_pitbull_monitor_stop" );
        level.player_pitbull thread maps\sanfran_pitbull::handle_player_pitbull_hud();
    }

    level.player_pitbull maps\_utility::ent_flag_clear( "pitbull_scripted_anim" );
    level.player_pitbull maps\_utility::ent_flag_set( "pitbull_allow_shooting" );
    soundscripts\_snd::snd_message( "monitor_pitbull_oncoming" );
    level thread pitbull_back_to_speed();
    var_7 thread cleanup_oncoming_suv();
    soundscripts\_snd::snd_message( "player_in_oncoming" );
}

oncoming_scene_pitbull_speed_monitor()
{
    level endon( "oncoming_scene_pitbull_monitor_stop" );
    var_0 = 0;

    for (;;)
    {
        luinotifyevent( &"pitbull_update_speed", 1, level.oncoming_pitbull_speed );

        if ( var_0 > 10 )
        {
            level.oncoming_pitbull_speed--;
            var_0 = 0;
        }

        waitframe();
        var_0++;
    }
}

knocked_to_oncoming_rumble()
{
    level.player common_scripts\utility::delaycall( 0.1, ::playrumbleonentity, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 2.2, ::playrumbleonentity, "light_1s" );
}

pitbull_back_to_speed()
{
    var_0 = gettime();
    level.player_pitbull vehphys_setspeed( 55.0 );

    while ( gettime() < var_0 + 4000 )
    {
        if ( level.player attackbuttonpressed() )
            break;

        if ( level.player buttonpressed( "BUTTON_B" ) )
            break;

        level.player_pitbull vehphys_setspeed( 55.0 );
        wait 0.05;
    }
}

cleanup_oncoming_suv()
{
    self endon( "death" );
    wait 20.0;

    for (;;)
    {
        if ( !maps\sanfran_util::player_can_see( self.origin, 45 ) )
        {
            self delete();
            return;
        }

        wait 0.05;
    }
}

start_bridge_heli()
{
    self waittill( "trigger" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "bridge_heli" );

    for (;;)
    {
        if ( !isdefined( level.chase_van ) )
            break;

        var_1 = anglestoforward( var_0.angles );
        var_2 = vectornormalize( level.chase_van.origin - var_0.origin );
        var_3 = vectordot( var_1, var_2 );

        if ( var_3 < 0 )
            break;

        var_4 = distance( var_0.origin, level.chase_van.origin );

        if ( var_4 < 5000 )
            break;

        wait 0.05;
    }

    for ( var_5 = 0; var_5 < 3; var_5++ )
    {
        var_6 = maps\sanfran_util::get_single_living_ent( "right_atlas_intercept", "targetname" );
        var_7 = ( 0, 0, 0 );
        var_8 = ( 0, 0, 0 );

        if ( isdefined( var_6 ) && var_5 == 0 && distance( var_0.origin, var_6.origin ) < 6000 )
        {
            var_7 = 700 * anglestoforward( var_6.angles );
            magicbullet( "pitbull_magicbullet", var_0.origin + ( 0, 0, -100 ), var_6.origin + var_7 );
        }
        else
        {
            if ( !isdefined( level.chase_van ) )
                return;

            var_7 = randomfloatrange( 800, 1200 ) * anglestoforward( level.chase_van.angles );
            var_8 = randomfloatrange( 200, 400 ) * anglestoright( level.chase_van.angles );

            if ( randomint( 100 ) < 50 )
                var_8 = -1 * var_8;

            magicbullet( "pitbull_magicbullet", var_0.origin + ( 0, 0, -100 ), level.chase_van.origin + var_7 + var_8 );
        }

        if ( var_5 == 0 )
        {
            var_9 = common_scripts\utility::getstruct( "bridge_heli_fly_off", "targetname" );
            var_0 thread maps\_vehicle_code::_vehicle_paths( var_9 );
        }

        wait 1.5;
    }
}

player_crash()
{
    self waittill( "trigger" );
    level notify( "player_crash_scene" );
    maps\sanfran_util::setup_squad_for_scene();
    level.player_pitbull maps\_utility::ent_flag_set( "pitbull_scripted_anim" );
    level.player_pitbull maps\_utility::ent_flag_clear( "pitbull_allow_shooting" );
    level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
    level.player enabledeathshield( 1 );
    var_0 = getent( "org_player_crash_start", "targetname" );
    var_1 = level.player_pitbull.player_rig;
    var_2 = level.player_pitbull.fake_vehicle_model;
    thread crash_rumble();
    level.player playerlinktodelta( var_1, "tag_player", 1, 10, 10, 5, 5, 1 );
    level.player enableslowaim();
    soundscripts\_snd::snd_message( "pitbull_crash_sound_design" );
    level.player_pitbull vehicle_teleport( var_0.origin, level.player_pitbull.angles );
    maps\_vehicle_traffic::clear_cars_around_pos( level.player_pitbull.origin, 600, 1 );
    var_2 = level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname( "player_crash_van" );
    var_3 maps\_vehicle::godon();
    var_3.animname = "work_van";
    var_3 useanimtree( #animtree );
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( "player_crash_suburban" );
    var_4 maps\_vehicle::godon();
    var_4.animname = "atlas_suv";
    var_4 useanimtree( #animtree );
    var_4 hidepart( "TAG_DOOR_GLASS_RIGHT_BACK" );
    var_0 maps\_anim::anim_first_frame_solo( var_4, "pitbull_crash" );
    var_5 = maps\_utility::array_spawn_targetname( "player_crash_atlas_guy" );

    for ( var_6 = 0; var_6 < var_5.size; var_6++ )
        var_5[var_6].animname = "atlas_" + ( var_6 + 1 );

    var_1 unlink();
    level.player_pitbull maps\sanfran_pitbull::remove_passenger_from_player_pitbull( level.burke );
    level.burke hide();
    var_7 = [];
    var_7[0] = var_1;
    var_7[1] = var_2;
    var_7[2] = level.burke;
    var_7[3] = var_3;
    var_7[4] = var_4;
    var_7[5] = var_5[0];
    var_7[6] = var_5[1];
    var_7[7] = var_5[2];

    foreach ( var_9 in var_7 )
        var_9 dontinterpolate();

    level.player_pitbull thread destroy_windshield();
    var_11 = getent( "brush_crash_scene_player_pitbull_collision", "targetname" );
    var_11.origin = level.player.origin;
    var_11 thread update_bumper_think();
    common_scripts\utility::flag_set( "flag_dialog_bridge_crash" );
    common_scripts\utility::flag_set( "flag_final_crash_scene_playing" );
    soundscripts\_snd::snd_message( "pc_pitbull_crash" );
    var_0 maps\_anim::anim_single( var_7, "pitbull_crash" );
    var_7 = [];
    var_7[0] = var_1;
    var_7[1] = var_2;
    common_scripts\utility::flag_set( "flag_player_crashed" );
    level.chase_van delete();
    delete_atlas_intercepts();
    maps\sanfran_util::show_crash_traffic();
    level.friendly_pitbull delete();
    level notify( "stop_traffic" );
    level thread start_after_crash_traffic();
    var_3 delete();
    var_4 delete();

    foreach ( var_13 in var_5 )
        var_13 delete();

    var_1 maps\_utility::attach_player_current_weapon_to_anim_tag( "tag_weapon" );

    if ( level.currentgen )
        loadtransient( "sanfran_outro_tr" );

    level.player playerlinktodelta( var_1, "tag_player", 1, 10, 10, 5, 5, 1 );
    common_scripts\utility::flag_set( "flag_dialog_bridge_crawl" );
    level.burke show();
    level thread anim_burke_crawl( var_0 );
    var_11 delete();
    var_0 maps\_anim::anim_single( var_7, "pitbull_crawl" );
    common_scripts\utility::flag_clear( "flag_final_crash_scene_playing" );
    level.player_pitbull notify( "dismount_pitbull" );
    get_squad_out_of_pitbull();
    level.player_pitbull delete();
    level.player disableslowaim();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player enablehybridsight( "iw5_bal27_sp_variablereddot", 1 );
    level.player enabledeathshield( 0 );
    maps\sanfran_util::setup_squad_for_gameplay();
    setsaveddvar( "bg_viewBobMax", 8 );

    if ( level.currentgen )
    {
        level notify( "tff_pre_transition_intro_to_outro" );
        unloadtransient( "sanfran_intro_tr" );

        while ( !istransientloaded( "sanfran_outro_tr" ) )
            wait 0.05;

        level notify( "tff_transition_intro_to_outro" );
    }

    thread handle_fight_section();
    maps\sanfran_util::toggle_all_boats_on();
    level notify( "vfx_pitball_crash_end" );
}

update_bumper_think()
{
    self endon( "death" );

    for (;;)
    {
        var_0 = level.player screenpostoworldpoint( ( 0, 0, 0 ), 65, 100 );
        self moveto( var_0, 0.05 );
        wait 0.05;
    }
}

crash_rumble()
{
    level.player common_scripts\utility::delaycall( 0.1, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 2.2, ::playrumbleonentity, "heavy_2s" );
    level.player common_scripts\utility::delaycall( 4, ::playrumbleonentity, "light_2s" );
    level.player common_scripts\utility::delaycall( 6, ::playrumbleonentity, "heavy_3s" );
    level.player common_scripts\utility::delaycall( 8.8, ::playrumbleonentity, "heavy_1s" );
}

destroy_windshield()
{
    wait 6.05;
    self notify( "windshield_state", 4 );
    wait 0.05;
    self notify( "stop_player_pitbull_damage" );
}

pitbull_crash_swap_to_real_model( var_0 )
{
    level.player_pitbull.fake_vehicle_model hide();
    maps\sanfran_util::show_ents_by_targetname( "pitbull_crash_collision" );
    maps\sanfran_util::solid_ents_by_targetname( "pitbull_crash_collision" );
    var_1 = getent( "org_player_crash_start", "targetname" );
    var_2 = getentarray( "pitbull_crash_collision", "targetname" );
    var_3 = undefined;

    foreach ( var_5 in var_2 )
    {
        if ( var_5.classname == "script_model" )
            var_3 = var_5;
    }

    var_3.animname = "after_pitbull";
    var_3 useanimtree( #animtree );
    var_1 maps\_anim::anim_single_solo( var_3, "pitbull_wreck" );
}

anim_burke_crawl( var_0 )
{
    maps\_utility::activate_trigger_with_targetname( "trigger_move_from_crash" );
    level thread maps\sanfran_fx::burke_spit_blood();
    var_0 maps\_anim::anim_single_solo_run( level.burke, "pitbull_crawl" );
    common_scripts\utility::flag_set( "flag_player_crash_complete" );
}

crash_blackout( var_0 )
{
    level.crash_overlay = maps\sanfran_util::get_white_overlay();
    level.crash_overlay thread maps\sanfran_util::blackout( 0.01, 2 );
    soundscripts\_snd::snd_message( "aud_pitbull_crash_concussion" );
}

crash_wakeup( var_0 )
{
    level.crash_overlay thread maps\sanfran_util::restorevision( 2.0, 0 );
    level.player shellshock( "default", 14.0 );
}

start_after_crash_traffic( var_0 )
{
    if ( !isdefined( var_0 ) )
        wait 10.5;
    else
        wait(var_0);

    maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "bridge_crash_traffic" );
    clean_up_traffic_drivers();
}

clean_up_traffic_drivers()
{
    var_0 = getentarray( "crash_traffic_driver", "script_noteworthy" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isai( var_3 ) )
        {
            var_1[var_1.size] = var_3;
            var_3.ignoresonicaoe = 1;
        }
    }

    common_scripts\utility::array_thread( var_1, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_police_battle );
}

get_squad_out_of_pitbull()
{
    level.player_pitbull maps\sanfran_pitbull::remove_passenger_from_player_pitbull( level.saint );
    var_0 = getent( "crash_point_saint", "targetname" );
    level.saint forceteleport( var_0.origin, var_0.angles );
}

handle_fight_section( var_0 )
{
    if ( isdefined( var_0 ) )
        maps\_utility::autosave_by_name();
    else if ( !isdefined( level.start_point ) || level.start_point != "street" )
        maps\_utility::autosave_now();

    soundscripts\_snd::snd_message( "bridge_street_fight" );
    setsaveddvar( "fx_draw_omnilight", 0 );
    common_scripts\utility::flag_set( "flag_obj_van_meetup" );
    common_scripts\utility::flag_set( "flag_dialog_start_street" );
    common_scripts\utility::flag_set( "flag_enable_battle_chatter" );
    common_scripts\utility::run_thread_on_targetname( "trigger_fall_fail", maps\sanfran_util::fall_fail );
    common_scripts\utility::run_thread_on_targetname( "trigger_fall_fail_remove", maps\sanfran_util::fall_fail );
    level thread maps\sanfran_util::fail_player_for_abandon();
    level thread maps\sanfran_util::player_abandon_squad_distance_think();
    common_scripts\utility::run_thread_on_targetname( "trigger_no_long_death", ::no_long_death );
    thread railing_dangerzone_think();
    level thread maps\sanfran_util::toggle_boat_visibility();
    maps\_player_exo::player_exo_activate();
    level thread maps\sanfran_util::give_boost_jump();

    if ( !isdefined( var_0 ) )
    {
        common_scripts\utility::flag_set( "flag_dialog_street_foot" );
        level thread fight_section_crash_encounter();
        level thread fight_section_boost_encounter();
        level thread fight_section_police_encounter();
        level thread fight_section_tanker_encouter();
        level thread fight_section_ambient_encounter();
        level thread fight_section_pitbull_encounter();
        level thread fight_section_escape_encounter();
        level thread fight_section_standoff_encounter();
    }
    else if ( var_0 == "police" )
    {
        common_scripts\utility::flag_set( "flag_fight_start_boost_encounter" );
        common_scripts\utility::flag_set( "flag_fight_start_police_encounter" );
        maps\sanfran_util::connectpaths_ents_by_targetname( "boost_path_blocker" );
        maps\sanfran_util::delete_ents_by_targetname( "boost_path_blocker" );
        maps\_utility::activate_trigger_with_targetname( "trigger_move_first_boost" );
        level thread fight_section_police_encounter();
        level thread fight_section_tanker_encouter();
        level thread fight_section_ambient_encounter();
        level thread fight_section_pitbull_encounter();
        level thread fight_section_escape_encounter();
        level thread fight_section_standoff_encounter();
    }
    else if ( var_0 == "pitbull" )
    {
        level thread fight_section_ambient_encounter();
        level thread fight_section_pitbull_encounter();
        level thread fight_section_escape_encounter();
        level thread fight_section_standoff_encounter();
    }
}

play_van_videolog_pip()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_play_van_videolog_pip" );
    maps\_shg_utility::play_videolog( "sanfran_videolog", "screen_add" );
}

no_long_death()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( isalive( var_0 ) && var_0.team == "axis" && var_0.a.disablelongdeath != 1 )
            var_0 maps\_utility::disable_long_death();
    }
}

fight_section_crash_encounter()
{
    common_scripts\utility::run_thread_on_targetname( "trigger_start_crash_suvs", ::start_crash_suvs );
    level thread maps\sanfran_util::start_civilian_group( "crash_civilian_spawner" );
    maps\sanfran_util::civilian_get_out_of_car_setup( "crash_scene_escape_car_1", "crash_scene_escape_spawner_1", "flag_crash_scene_get_out", 1 );
    maps\sanfran_util::civilian_get_out_of_car_setup( "crash_scene_escape_car_2", "crash_scene_escape_spawner_2", "flag_crash_scene_get_out", 1 );
    maps\sanfran_util::civilian_get_out_of_car_setup( "crash_scene_escape_car_3", "crash_scene_escape_spawner_3", "flag_crash_scene_get_out", 1 );
    maps\sanfran_util::civilian_get_out_of_car_setup( "crash_scene_escape_car_4", "crash_scene_escape_spawner_4", "flag_crash_scene_get_out", 1 );
    maps\sanfran_util::civilian_get_out_of_car_setup( "crash_scene_escape_car_5", "crash_scene_escape_spawner_5", "flag_crash_scene_get_out", 1, 4 );
    maps\sanfran_util::civilian_loop_setup( "crash_civ_seat", undefined, "flag_player_at_tanker_battle" );
    common_scripts\utility::flag_wait( "flag_player_crash_complete" );
    maps\_utility::activate_trigger_with_targetname( "trigger_move_from_crash" );
    maps\_utility::waittill_aigroupcount( "atlas_suv_guys", 2 );
    common_scripts\utility::flag_set( "flag_crash_retreat_01" );
    wait 4.0;
    common_scripts\utility::flag_set( "flag_fight_start_boost_encounter" );
}

start_crash_suvs()
{
    self waittill( "trigger" );
    maps\sanfran_util::squad_ignore_all_start();
    common_scripts\utility::run_thread_on_targetname( "trigger_crash_squad_cover", ::crash_squad_take_cover );
}

clean_up_suv_drivers()
{
    var_0 = getentarray( "atlas_ai_suv_drivers", "script_noteworthy" );
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( isai( var_3 ) )
            var_1[var_1.size] = var_3;
    }

    common_scripts\utility::array_thread( var_1, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_tanker_battle );
}

crash_squad_take_cover()
{
    self waittill( "trigger" );
    maps\sanfran_util::connectpaths_ents_by_targetname( "crash_path_blocker" );
    maps\sanfran_util::delete_ents_by_targetname( "crash_path_blocker" );
    maps\sanfran_util::squad_ignore_all_stop();
    soundscripts\_snd::snd_message( "bridge_post_crash" );
}

drive_crash_suv()
{
    self vehphys_disablecrashing();
    maps\_vehicle::vehicle_set_health( 3000 );
    self waittill( "reached_end_node" );
    self disconnectpaths();
}

fight_section_boost_encounter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_boost_encounter" );
    thread maps\sanfran_util::street_civilian_clean_up();
    maps\sanfran_util::connectpaths_ents_by_targetname( "boost_path_blocker" );
    maps\sanfran_util::delete_ents_by_targetname( "boost_path_blocker" );
    var_0 = getentarray( "spawner_atlas_boost", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_ignore_all, maps\sanfran_util::ai_end_ignore_all, maps\sanfran_util::ai_cond_reached_goal );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_ignore_me, maps\sanfran_util::ai_end_ignore_me, maps\sanfran_util::ai_cond_reached_goal );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_tanker_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    common_scripts\utility::flag_set( "flag_dialog_street_boost_incoming" );
    maps\_utility::activate_trigger_with_targetname( "trigger_move_to_first_jump" );
    maps\_utility::waittill_aigroupcount( "atlas_first_jump", 1 );
    common_scripts\utility::flag_set( "flag_boost_retreat_01" );
    wait 4.0;
    common_scripts\utility::flag_set( "flag_dialog_street_boosters" );
    maps\_utility::activate_trigger_with_targetname( "trigger_move_first_boost" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "flag_fight_start_police_encounter" );
}

wait_to_give_boost_to_player()
{
    common_scripts\utility::flag_wait( "flag_enable_boost_jump" );
    maps\_utility::display_hint( "boost_hint" );
    level thread maps\sanfran_util::give_boost_jump();
}

fight_section_police_encounter()
{
    level thread set_up_police_battle();
    maps\sanfran_util::civilian_loop_setup( "police_civ_seat", undefined, "flag_player_at_ambient_battle" );
    maps\sanfran_util::civilian_loop_setup( "police_civ_seat_2", undefined, "flag_player_at_ambient_battle" );
    maps\sanfran_util::civilian_loop_setup( "police_civ_paired_a", "police_civ_paired_b", "flag_player_at_ambient_battle" );
    maps\sanfran_util::civilian_loop_setup( "police_civ_paired_2_a", "police_civ_paired_2_b", "flag_player_at_ambient_battle" );
    common_scripts\utility::flag_wait( "flag_player_at_police_battle" );
    level thread start_street_heli();
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_police_fight", 11, "flag_force_police_battle_atlas_second_group" );
    common_scripts\utility::flag_set( "flag_police_retreat_01" );
    var_0 = getentarray( "police_battle_atlas_second_group", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    wait 3.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_police_persue_01" );
    common_scripts\utility::flag_set( "flag_dialog_street_sitrep" );
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_police_fight", 6, "flag_force_police_battle_atlas_third_group" );
    common_scripts\utility::flag_set( "flag_police_retreat_02" );
    var_1 = getentarray( "police_battle_atlas_third_group", "targetname" );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    common_scripts\utility::array_thread( var_1, maps\_utility::spawn_ai, 1, 0 );
    wait 3.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_police_persue_02" );
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_police_fight", 2, "flag_force_police_battle_final_fallback" );
    maps\_utility::activate_trigger_with_targetname( "trigger_police_fight_fallback" );
    maps\_utility::autosave_by_name();
    wait 1.0;
    common_scripts\utility::flag_set( "flag_fight_start_tanker_encounter" );
}

set_up_police_battle()
{
    setthreatbias( "police", "atlas", 10000 );
    setthreatbias( "atlas", "police", 10000 );
    setthreatbias( "sentinel", "atlas", -10000 );
    setthreatbias( "atlas", "sentinel", -10000 );
    setthreatbias( "police", "atlas_attack", -10000 );
    setthreatbias( "atlas_attack", "police", -10000 );
    setthreatbias( "sentinel", "atlas_attack", 10000 );
    setthreatbias( "atlas_attack", "sentinel", 10000 );
    var_0 = getentarray( "tanker_battle_police", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_magic_bullet_shield, maps\sanfran_util::ai_end_magic_bullet_shield, maps\sanfran_util::ai_cond_player_at_police_battle );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    var_1 = getentarray( "police_battle_atlas_first_group", "targetname" );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_end_fixed_node, maps\sanfran_util::ai_cond_player_at_police_battle );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\sanfran_util::ai_shot_by_player_team_notify );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    common_scripts\utility::array_thread( var_1, maps\_utility::spawn_ai, 1, 0 );
    var_2 = getent( "trigger_tanker_fire_damage", "targetname" );
    var_2 common_scripts\utility::trigger_off_proc();
    level waittill( "ai_shot_by_player_team" );
    setthreatbias( "police", "atlas", 0 );
    setthreatbias( "atlas", "police", 0 );
    setthreatbias( "sentinel", "atlas", 100 );
    setthreatbias( "atlas", "sentinel", 100 );
    setthreatbias( "police", "atlas_attack", 0 );
    setthreatbias( "atlas_attack", "police", 0 );
    setthreatbias( "sentinel", "atlas_attack", 100 );
    setthreatbias( "atlas_attack", "sentinel", 100 );
}

start_street_heli()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "street_fight_heli" );
    var_0 maps\_utility::ent_flag_init( "heli_can_shoot" );
    var_0 maps\_vehicle::godon();
    var_0 maps\sanfran_util::riders_no_damage();
    var_0 thread maps\sanfran_util::heli_shoot_enemies();
    var_0 thread maps\sanfran_util::heli_toggle_shoot();
    common_scripts\utility::flag_set( "flag_dialog_street_helo_intro" );
    common_scripts\utility::flag_wait( "flag_police_retreat_02" );
    var_1 = common_scripts\utility::getstruct( "start_bridge_heli_swap_sides", "targetname" );
    var_0 thread maps\_vehicle_code::_vehicle_paths( var_1 );
    var_0 maps\_utility::ent_flag_clear( "heli_can_shoot" );
    common_scripts\utility::flag_set( "flag_dialog_street_helo_change" );
    common_scripts\utility::flag_wait( "flag_player_at_tanker_battle" );
    var_1 = common_scripts\utility::getstruct( "start_bridge_heli_move_tanker", "targetname" );
    var_0 thread maps\_vehicle_code::_vehicle_paths( var_1 );
    common_scripts\utility::flag_wait( "flag_tanker_exploded" );
    common_scripts\utility::flag_set( "flag_dialog_street_helo_die" );
    var_0 soundscripts\_snd::snd_message( "aud_little_bird_hit" );
    var_0 maps\_vehicle::godoff();
    var_0 dodamage( var_0.health + 10000, var_0.origin );
}

fight_section_tanker_encouter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_tanker_encounter" );
    level thread start_tanker_fire();
    var_0 = getentarray( "tanker_battle_atlas_group", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_start_balcony_death, maps\sanfran_util::ai_cond_player_at_tanker_battle );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_pitbull_battle );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::player_damage_atlas_flag_set, "flag_player_at_tanker_battle" );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    wait 2.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_tanker_move_up" );
    common_scripts\utility::flag_wait( "flag_player_at_tanker_battle" );
    setthreatbias( "police", "atlas", 1000 );
    setthreatbias( "atlas", "police", 1000 );
    setthreatbias( "sentinel", "atlas", -100 );
    setthreatbias( "atlas", "sentinel", -100 );
    setthreatbias( "police", "atlas_attack", -1000 );
    setthreatbias( "atlas_attack", "police", -1000 );
    setthreatbias( "sentinel", "atlas_attack", 1000 );
    setthreatbias( "atlas_attack", "sentinel", 1000 );
    tanker_drone_flood();
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_tanker_fight", 6, "flag_force_tanker_battle_atlas_second_group" );
    var_0 = getentarray( "tanker_battle_atlas_second_group", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\sanfran_util::balcony_death_anims );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_pitbull_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    common_scripts\utility::flag_set( "flag_dialog_street_helo_warn" );
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_tanker_fight", 4, "flag_force_tanker_ignite_second" );
    level thread maps\sanfran_fx::ignite_tanker_spurt();
    common_scripts\utility::flag_set( "flag_tanker_retreat_01" );
    wait 3.0;
    level thread explode_tanker();
    common_scripts\utility::flag_wait( "flag_tanker_exploded" );
    maps\sanfran_util::connectpaths_ents_by_targetname( "tanker_fire_path_blocker" );
    maps\sanfran_util::delete_ents_by_targetname( "tanker_fire_path_blocker" );
    var_1 = getaiarray( "axis" );
    var_2 = getent( "trigger_tanker_explosion_ragdoll", "targetname" );
    var_3 = getent( "tanker_explosion_org", "targetname" );

    foreach ( var_5 in var_1 )
    {
        if ( var_5 istouching( var_2 ) )
        {
            var_6 = vectornormalize( var_5.origin - var_3.origin );
            var_7 = distance( var_5.origin, var_3.origin );
            var_8 = ( 800 - var_7 ) / 800;
            var_9 = var_6 * var_8 * 400;
            var_5 kill();
            var_5 startragdollfromimpact( var_5.origin, var_9 );
        }
    }

    common_scripts\utility::flag_set( "flag_fight_start_ambient_encounter" );
    maps\_utility::waittill_aigroupcleared( "atlas_tanker_fight" );
    maps\_utility::autosave_by_name();
    wait 2.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_tanker_move_past_fire" );
}

tanker_drone_flood()
{
    var_0 = getentarray( "atlas_tanker_drone", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 thread drone_respawn();
}

drone_respawn()
{
    level endon( "flag_tanker_exploded" );

    for (;;)
    {
        var_0 = maps\_vehicle::spawn_vehicle_and_gopath();
        var_0 thread maps\_shg_utility::make_emp_vulnerable();
        var_0 maps\_utility::add_damage_function( maps\sanfran_util::ai_twenty_percent_damage_func );
        var_0 laseron();
        var_0 thread explode_drones_at_tanker();
        var_0 waittill( "death" );
        wait(randomfloatrange( 3.0, 5.0 ));
    }
}

explode_drones_at_tanker()
{
    self endon( "death" );
    level waittill( "flag_tanker_exploded" );
    var_0 = randomfloatrange( 0.1, 0.8 );
    wait(var_0);
    self kill();
}

start_tanker_fire()
{
    thread maps\sanfran_fx::oil_tanker_bridge_fire();
    soundscripts\_snd::snd_message( "tanker_fireball" );
    var_0 = getent( "trigger_tanker_fire_damage", "targetname" );
    var_0 common_scripts\utility::trigger_on_proc();
    common_scripts\utility::flag_wait( "flag_tanker_exploded" );
    var_0 delete();
}

#using_animtree("destructibles");

explode_tanker()
{
    var_0 = [];
    var_1 = 1;

    for (;;)
    {
        var_2 = getentarray( "tanker_explosion_car_" + var_1, "script_noteworthy" );

        if ( var_2.size == 0 )
            break;

        var_0[var_0.size] = var_2;
        var_1++;
    }

    var_0 = common_scripts\utility::array_randomize( var_0 );

    foreach ( var_2 in var_0 )
    {
        for ( var_1 = 0; var_1 < var_2.size; var_1++ )
        {
            if ( var_2[var_1].classname != "script_model" )
                continue;

            var_2[var_1] useanimtree( #animtree );
            var_4 = var_2[var_1].model;

            if ( issubstr( var_4, "vehicle_civ_domestic_economy" ) )
            {
                var_2[var_1] setmodel( "vehicle_civ_domestic_economy_destroy_static" );
                var_2[var_1] setanimknob( %civ_domestic_sedan_police_destroy, 1, 0, 1 );
            }
            else if ( issubstr( var_4, "vehicle_civ_smartcar_02_blue" ) )
            {
                var_2[var_1].newmodel = spawn( "script_model", var_2[var_1].origin );
                var_2[var_1].newmodel.angles = var_2[var_1].angles;
                var_2[var_1].newmodel setmodel( "vehicle_civ_smartcar_static_dstry" );
                var_2[var_1].newmodel linkto( var_2[var_1], "body_animate_jnt" );
                var_2[var_1] hide();
                var_2[var_1] setanimknob( %civ_domestic_sedan_police_destroy, 1, 0, 1 );
            }

            playfx( level._effect["tanker_explosion"], var_2[var_1].origin );
            var_2[var_1] soundscripts\_snd::snd_message( "bridge_car_explode" );
            earthquake( 0.4, 0.5, var_2[var_1].origin, 2000 );
            radiusdamage( var_2[var_1].origin, 400, 50, 10 );
            break;
        }

        wait(randomfloatrange( 0.5, 2.0 ));
    }

    wait(randomfloatrange( 1.0, 2.0 ));
    common_scripts\utility::flag_set( "kill_oil_puddle_flames" );
    wait 1.0;
    level thread maps\sanfran_fx::oil_tanker_bridge_explosion();
    var_6 = getent( "tanker_explosion_org", "targetname" );
    var_7 = getentarray( "tanker_explosion_tanker", "script_noteworthy" );

    foreach ( var_9 in var_7 )
    {
        if ( var_9.classname == "script_model" )
            var_9 setmodel( "ind_semi_truck_fuel_tank_destroy" );
    }

    var_11 = getentarray( "tanker_explosion_cab", "script_noteworthy" );

    foreach ( var_9 in var_11 )
    {
        if ( var_9.classname == "script_model" )
            var_9 setmodel( "ind_semi_truck_03_destroy" );
    }

    earthquake( 0.6, 0.5, var_6.origin, 2000 );
    radiusdamage( var_6.origin, 400, 50, 10 );
    common_scripts\utility::flag_set( "flag_tanker_exploded" );

    foreach ( var_2 in var_0 )
    {
        var_15 = vectornormalize( var_2[0].origin - var_6.origin );
        var_16 = distance( var_2[0].origin, var_6.origin );
        var_17 = ( 800 - var_16 ) / 800;
        var_18 = var_15 * var_17 * 300;
        var_19 = ( var_18[0], var_18[1], 0 );
        var_20 = randomfloatrange( 50, 70 );

        if ( randomint( 100 ) > 50 )
            var_20 *= -1;

        foreach ( var_22 in var_2 )
            var_22 thread shift_car( var_19, var_20 );
    }

    maps\_utility::delaythread( 5.0, maps\_utility::pauseexploder, 2200 );
}

shift_car( var_0, var_1 )
{
    if ( self.classname != "script_model" )
        self connectpaths();
    else
        self clearanim( %civ_domestic_sedan_police_destroy, 0 );

    self moveto( self.origin + var_0, 0.2, 0, 0.1 );
    self rotateto( self.angles + ( 0, var_1, 0 ), 0.2, 0, 0.1 );
    wait 0.2;

    if ( self.classname != "script_model" )
        self disconnectpaths();
    else
        common_scripts\utility::delaycall( randomfloat( 0.15 ), ::setanimknob, %civ_domestic_sedan_police_destroy, 1, 0, 1 );
}

fight_section_ambient_encounter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_ambient_encounter" );
    common_scripts\utility::run_thread_on_targetname( "start_bridge_helis", ::start_bridge_helis );
    level thread set_up_ambient_battle();
    maps\sanfran_util::civilian_loop_setup( "ambient_civ_seat_1", undefined, "flag_player_at_escape_battle" );
    maps\sanfran_util::civilian_loop_setup( "ambient_civ_seat_2", undefined, "flag_player_at_escape_battle" );
    maps\sanfran_util::civilian_loop_setup( "ambient_civ_paired_1", "ambient_civ_paired_2", "flag_player_at_escape_battle" );
    common_scripts\utility::flag_wait( "flag_player_at_ambient_battle" );
    level thread maps\sanfran_util::start_civilian_group( "spawner_ambient_spawner_wave01" );
    maps\_utility::autosave_by_name();
    maps\_utility::activate_trigger_with_targetname( "trigger_move_to_ambient_battle" );
    common_scripts\utility::flag_set( "flag_start_jerk_driver" );
    wait 5;
    common_scripts\utility::flag_set( "flag_fight_start_pitbull_encounter" );
    maps\_utility::autosave_by_name();
    wait 4.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_move_to_pitbull_encounter" );
    common_scripts\utility::run_thread_on_targetname( "trigger_start_ambient_kick_pair", ::start_ambient_pair_kick );
}

start_ambient_pair_kick()
{
    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0 == level.burke )
            break;
    }

    var_1 = getent( "spawner_atlas_ambient_kick_pair", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1, 0 );
    soundscripts\_snd::snd_message( "start_burke_boost_kick" );
    maps\sanfran_util::lunging_take_down( "takedown_ambient", level.burke, var_2 );
    var_3 = getnode( "node_burke_lunge_cover", "targetname" );
    level.burke thread maps\_spawner::go_to_node( var_3 );
    level.burke maps\_utility::enable_ai_color_dontmove();
}

start_bridge_helis()
{
    self waittill( "trigger" );
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "bridge_helis" );
    soundscripts\_snd::snd_message( "start_bridge_helis", var_0 );
    common_scripts\utility::flag_set( "flag_dialog_street_van_stop" );
}

set_up_ambient_battle()
{
    var_0 = getentarray( "spawner_police_ambient", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_magic_bullet_shield, maps\sanfran_util::ai_end_magic_bullet_shield, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    var_1 = getent( "spawner_police_ambient_animated", "targetname" );
    var_1 maps\_utility::add_spawn_function( ::ambient_battle_deployable_cover );
    var_0 = common_scripts\utility::array_add( var_0, var_1 );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_escape_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    var_2 = getentarray( "spawner_atlas_ambient", "targetname" );
    common_scripts\utility::array_thread( var_2, maps\_utility::add_spawn_function, maps\sanfran_util::ai_shot_by_player_team_notify );
    common_scripts\utility::array_thread( var_2, maps\sanfran_util::add_spawn_behavior, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_2, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_respawn_death, maps\sanfran_util::ai_stop_death_function, maps\sanfran_util::ai_cond_player_at_ambient_battle );
    common_scripts\utility::array_thread( var_2, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_escape_battle );
    level waittill( "ai_shot_by_player_team" );
    setthreatbias( "police", "atlas", 0 );
    setthreatbias( "atlas", "police", 0 );
    setthreatbias( "sentinel", "atlas", 100 );
    setthreatbias( "atlas", "sentinel", 100 );
    setthreatbias( "police", "atlas_attack", 0 );
    setthreatbias( "atlas_attack", "police", 0 );
    setthreatbias( "sentinel", "atlas_attack", 100 );
    setthreatbias( "atlas_attack", "sentinel", 100 );
}

ambient_battle_deployable_cover()
{
    var_0 = getent( "deployable_cover_final_model", "targetname" );
    var_0.contents = var_0 setcontents( 0 );
    var_0 hide();
    maps\_utility::magic_bullet_shield();
    thread deployable_cover_think();
    common_scripts\utility::flag_wait( "flag_place_deployable_cover" );
    self.animname = "generic";
    var_1 = common_scripts\utility::getstruct( "deployable_cover_animnode", "targetname" );
    var_2 = "deployable_cover_deploy";
    var_1 maps\_anim::anim_reach_solo( self, var_2 );
    level notify( "police_placing_deployable_cover" );
    var_3 = maps\_utility::spawn_anim_model( "deployable_cover", ( 0, 0, 0 ) );
    var_4 = [ self, var_3 ];
    var_1 thread maps\_anim::anim_single( var_4, "deployable_cover_deploy" );
    var_5 = 5.4;
    var_0 common_scripts\utility::delaycall( var_5, ::setcontents, var_0.contents );
    var_0 common_scripts\utility::delaycall( var_5, ::show );
    var_3 common_scripts\utility::delaycall( var_5, ::delete );
}

deployable_cover_think()
{
    var_0 = spawn( "script_model", self gettagorigin( "j_SpineUpper" ) + ( 0, 0, 0 ) );
    var_0.angles = self gettagangles( "j_SpineUpper" ) + ( 0, 0, 0 );
    var_0.animname = "deployable_cover";
    var_0 setmodel( "deployable_cover" );
    var_0 maps\_anim::setanimtree();
    var_0 maps\_anim::anim_first_frame_solo( var_0, "deployable_cover_closed_idle" );
    var_0 linkto( self, "j_SpineUpper" );
    level waittill( "police_placing_deployable_cover" );
    var_0 delete();
}

start_jerk_driver()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "jerk_driver_car" );
    var_0 maps\_vehicle::godon();
    var_0 soundscripts\_snd::snd_message( "start_jerk_driver_car" );
    common_scripts\utility::flag_wait( "flag_start_jerk_driver" );
    var_0 startpath();
    var_0 waittill( "reached_end_node" );
    var_1 = getvehiclenode( "start_jerk_back_up", "targetname" );
    var_0 thread maps\_vehicle_code::_vehicle_paths( var_1 );
    var_0 startpath( var_1 );
    var_0 waittill( "reached_end_node" );
    var_1 = getvehiclenode( "start_jerk_go_forward", "targetname" );
    var_0 thread maps\_vehicle_code::_vehicle_paths( var_1 );
    var_0 startpath( var_1 );
    var_0 waittill( "reached_end_node" );

    for (;;)
    {
        if ( !maps\sanfran_util::player_can_see( var_0.origin, 45 ) )
        {
            var_0 maps\_vehicle::godoff();
            var_0 delete();
            return;
        }

        wait 0.05;
    }
}

fight_section_pitbull_encounter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_pitbull_encounter" );
    level thread start_pitbull_skirmish();
    maps\sanfran_util::civilian_loop_setup( "pitbull_civ_seat", undefined, "flag_player_at_standoff_battle" );
    common_scripts\utility::flag_wait( "flag_player_at_pitbull_battle" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "flag_dialog_street_pitbull" );
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_pitbull", 9, "flag_force_atlas_pitbull_second" );
    var_0 = getentarray( "spawner_atlas_pitbull_second", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_ignore_all, maps\sanfran_util::ai_end_ignore_all, maps\sanfran_util::ai_cond_reached_goal );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\sanfran_util::balcony_death_anims );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_standoff_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1 );
    common_scripts\utility::flag_set( "flag_dialog_street_cover" );
    maps\_utility::waittill_aigroupcleared( "atlas_pitbull" );
    common_scripts\utility::flag_set( "flag_fight_start_escape_encounter" );
    maps\_utility::autosave_by_name();
    wait 2.0;
    maps\_utility::activate_trigger_with_targetname( "trigger_move_past_pitbull" );
}

start_pitbull_skirmish()
{
    var_0 = getentarray( "spawner_atlas_pitbull", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_respawn_death, maps\sanfran_util::ai_start_balcony_death, maps\sanfran_util::ai_cond_player_at_pitbull_battle );
    common_scripts\utility::array_thread( var_0, maps\_utility::add_spawn_function, maps\sanfran_util::container_death_anims );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_standoff_battle );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::player_damage_atlas_flag_set, "flag_player_at_pitbull_battle" );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    var_1 = getentarray( "spawner_sentinel_pitbull", "targetname" );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_magic_bullet_shield, maps\sanfran_util::ai_end_magic_bullet_shield, maps\sanfran_util::ai_cond_player_at_pitbull_battle );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, ::bravo_leader );
    common_scripts\utility::array_thread( var_1, maps\_utility::spawn_ai, 1, 0 );
}

bravo_leader()
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "bravo_leader" )
    {
        self.animname = "Bravo";
        level.bravo = self;
    }
}

fight_section_escape_encounter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_escape_encounter" );

    if ( level.currentgen )
    {
        if ( !istransientloaded( "sanfran_bigm_tr" ) )
            level waittill( "tff_transition_outro_to_bigm" );
    }

    common_scripts\utility::run_thread_on_targetname( "setup_explosion_scene", ::setup_bridge_explosion_trigger );
    maps\sanfran_util::civilian_loop_setup( "escape_civ_seat", undefined, "flag_van_explosion_deploy" );
    maps\sanfran_util::civilian_loop_setup( "escape_civ_lay", undefined, "flag_van_explosion_deploy" );
    common_scripts\utility::flag_wait( "flag_player_at_escape_battle" );
    setthreatbias( "police", "atlas", 0 );
    setthreatbias( "atlas", "police", 0 );
    setthreatbias( "sentinel", "atlas", 100 );
    setthreatbias( "atlas", "sentinel", 100 );
    setthreatbias( "police", "atlas_attack", -1000 );
    setthreatbias( "atlas_attack", "police", -1000 );
    setthreatbias( "sentinel", "atlas_attack", 1000 );
    setthreatbias( "atlas_attack", "sentinel", 1000 );
    level thread escape_fight_wave( "spawner_atlas_escape" );
    wait 4.0;
    level thread escape_fight_wave( "spawner_atlas_escape_second" );
    wait 6.0;
    level thread escape_fight_wave( "spawner_atlas_escape_third" );
    maps\sanfran_util::waittill_aigroupcount_or_flag( "atlas_escape", 4, "flag_atlas_escape_fight_skip" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "flag_dialog_street_hurry" );
    maps\_utility::activate_trigger_with_targetname( "trigger_move_to_standoff" );
    common_scripts\utility::flag_set( "flag_fight_start_standoff_encounter" );
}

escape_fight_wave( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_van );
    common_scripts\utility::array_thread( var_1, maps\_utility::spawn_ai, 1, 0 );
}

fight_section_standoff_encounter()
{
    common_scripts\utility::flag_wait( "flag_fight_start_standoff_encounter" );
    level thread change_music_to_standoff();
    level thread start_police_standoff();
    common_scripts\utility::run_thread_on_targetname( "trigger_player_at_van", ::handle_bridge_collapse );

    if ( !level.nextgen )
    {
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_lay_1", undefined, "flag_van_explosion_deploy" );
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_lay_2", undefined, "flag_van_explosion_deploy" );
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_seat_1", undefined, "flag_van_explosion_deploy" );
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_seat_2", undefined, "flag_van_explosion_deploy" );
    }

    maps\sanfran_util::civilian_loop_setup( "standoff_civ_seat_3", undefined, "flag_van_explosion_deploy" );

    if ( !level.nextgen )
    {
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_paired_1", "standoff_civ_paired_2", "flag_van_explosion_deploy" );
        maps\sanfran_util::civilian_loop_setup( "standoff_civ_paired_b_1", "standoff_civ_paired_b_2", "flag_van_explosion_deploy" );
    }

    common_scripts\utility::flag_wait( "flag_player_at_standoff_battle" );
    thread at_van_enemy_cleanup();
    common_scripts\utility::flag_set( "flag_dialog_street_friendlies" );
    maps\_utility::waittill_aigroupcleared( "atlas_standoff" );
    maps\_utility::activate_trigger_with_targetname( "trigger_move_past_standoff" );
    level thread maps\sanfran_util::remove_boost_jump();

    if ( level.currentgen )
        maps\_utility::vision_set_fog_changes( "sanfran_cops_end_cg", 1.0 );

    common_scripts\utility::flag_set( "flag_player_at_van_standoff" );
}

change_music_to_standoff()
{
    common_scripts\utility::flag_wait( "flag_player_at_van_standoff" );
    soundscripts\_snd::snd_music_message( "approaching_standoff" );
    common_scripts\utility::flag_set( "flag_dialog_street_assist" );
}

start_police_standoff()
{
    var_0 = getentarray( "spawner_police_standoff", "targetname" );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_magic_bullet_shield, maps\sanfran_util::ai_end_magic_bullet_shield, maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_end_fixed_node, maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone );
    common_scripts\utility::array_thread( var_0, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_van );
    common_scripts\utility::array_thread( var_0, maps\_utility::spawn_ai, 1, 0 );
    var_1 = getentarray( "spawner_atlas_standoff", "targetname" );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_start_magic_bullet_shield, maps\sanfran_util::ai_end_magic_bullet_shield, maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_end_fixed_node, maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\sanfran_util::ai_shot_by_player_team_notify );
    common_scripts\utility::array_thread( var_1, maps\_utility::add_spawn_function, maps\_utility::add_damage_function, maps\sanfran_util::ai_twenty_percent_damage_func );
    common_scripts\utility::array_thread( var_1, maps\sanfran_util::add_spawn_behavior, maps\sanfran_util::ai_run_behavior_until_condition, maps\sanfran_util::ai_empty, maps\sanfran_util::ai_delete_self, maps\sanfran_util::ai_cond_player_at_van );
    common_scripts\utility::array_thread( var_1, maps\_utility::spawn_ai, 1, 0 );
    level waittill( "ai_shot_by_player_team" );
    setthreatbias( "police", "atlas", 0 );
    setthreatbias( "atlas", "police", 0 );
    setthreatbias( "sentinel", "atlas", 100 );
    setthreatbias( "atlas", "sentinel", 100 );
    setthreatbias( "police", "atlas_attack", 0 );
    setthreatbias( "atlas_attack", "police", 0 );
    setthreatbias( "sentinel", "atlas_attack", 100 );
    setthreatbias( "atlas_attack", "sentinel", 100 );
}

setup_bridge_explosion_trigger()
{
    self waittill( "trigger" );
    setup_bridge_explosion_anim_sequence();
}

setup_helicopter_blades_damage()
{
    level endon( "van_door_interact" );
    var_0 = getent( "helicopter_blades_damage", "targetname" );
    var_1 = undefined;

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );
        var_1 dodamage( 60, var_0.origin );
        wait 0.05;
    }
}

handle_bridge_collapse()
{
    common_scripts\utility::run_thread_on_targetname( "trigger_player_approaching_van", ::handle_early_approach );
    self waittill( "trigger" );
    level notify( "kill_bridge_copcar_lights" );
    setsaveddvar( "fx_draw_omnilight", 1 );
    level notify( "stop_toggle_boat_visibility" );
    common_scripts\utility::flag_set( "flag_obj_player_at_van" );
    common_scripts\utility::flag_set( "flag_dialog_start_van" );
    common_scripts\utility::flag_set( "flag_dialog_van_arrest" );
    soundscripts\_snd::snd_music_message( "pre_bridge_collapse_scene" );
    common_scripts\utility::flag_clear( "flag_enable_battle_chatter" );
    level.explosion_scene_org notify( "stop_barrier_loop" );

    foreach ( var_1 in level.barrier_scene_ents )
        var_1 maps\_utility::anim_stopanimscripted();

    level.explosion_scene_org maps\_anim::anim_single( level.approach_scene_ents, "approach_scene" );
    common_scripts\utility::flag_set( "flag_approach_scene_begin" );
    common_scripts\utility::flag_set( "flag_obj_player_use_van" );
    common_scripts\utility::flag_set( "flag_dialog_van_check" );

    foreach ( var_4 in level.approach_idle_ents )
        level.explosion_scene_org thread maps\_anim::anim_loop_solo( var_4, "approach_idle", "stop_approach_loop" );

    level.explosion_van show_glowy_handles();
    var_6 = getent( "trigger_player_used_van", "targetname" );
    var_6 usetriggerrequirelookat();
    var_6 sethintstring( &"SANFRAN_OPEN_VAN" );
    var_7 = var_6 maps\_shg_utility::hint_button_trigger( "activate", 1024 );
    var_6 waittill( "trigger" );
    var_7 maps\_shg_utility::hint_button_clear();
    var_6 delete();
    soundscripts\_snd::snd_message( "gg_start_bridge_collapse" );
    level notify( "van_door_interact" );
    maps\_player_exo::player_exo_deactivate();
    thread bridge_collapse_rumble();
    common_scripts\utility::flag_set( "portal_on_collapse" );
    wait 0.05;
    common_scripts\utility::flag_clear( "portal_on_collapse" );
    thread maps\sanfran_lighting::van_open_bridge_collapse_dof();
    level.explosion_van show_normal_handles();

    foreach ( var_9 in level.explosion_scene_bridge )
        var_9 show();

    maps\sanfran_util::hide_intact_bridge();
    maps\sanfran_util::toggle_on_real_mob();
    maps\sanfran_util::solid_ents_by_targetname( "collapse_clip" );
    maps\sanfran_util::delete_ents_by_targetname( "collapse_fake_collision" );
    maps\sanfran_util::delete_ents_by_targetname( "trigger_fall_fail_remove" );
    common_scripts\utility::flag_set( "flag_dialog_van_deploy" );
    common_scripts\utility::flag_set( "flag_obj_player_used_van" );
    level.explosion_scene_org notify( "stop_approach_loop" );

    foreach ( var_1 in level.approach_idle_ents )
        var_1 maps\_utility::anim_stopanimscripted();

    var_13 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_13 );
    level.player common_scripts\utility::delaycall( var_13, ::playerlinktodelta, level.player_rig, "tag_player", 1, 7, 7, 5, 5, 1 );
    level.player enableslowaim();
    level.player take_car_door_shields();
    level.player maps\_shg_utility::setup_player_for_scene();
    maps\sanfran_util::setup_squad_for_scene();

    foreach ( var_4 in level.deploy_scene_ents )
    {
        if ( var_4 == level.player_rig )
        {
            var_4 common_scripts\utility::delaycall( var_13, ::show );
            continue;
        }

        var_4 show();
    }

    common_scripts\utility::flag_set( "flag_van_explosion_deploy" );
    thread play_deploy_scene_handcuff_ents();
    level.explosion_scene_org maps\_anim::anim_single( level.deploy_scene_ents, "deploy_scene" );
    maps\sanfran_util::remove_intact_bridge();
    thread rock_mob();
    thread maps\sanfran_lighting::bridge_collapse_screen_effects();
    cleanup_explosion_ents();
    common_scripts\utility::flag_set( "flag_dialog_van_collapse" );

    foreach ( var_4 in level.collapse_scene_ents )
    {
        var_4 show();
        var_4 thread animate_collapse_ent( level.explosion_scene_org );
    }

    common_scripts\utility::flag_set( "flag_van_explosion_start" );
    level.explosion_scene_org maps\_anim::anim_single( level.collapse_scene_ents_long, "collapse_scene" );
    soundscripts\_snd::snd_music_message( "starting_bridge_collapse" );
    soundscripts\_snd::snd_message( "bridge_collapsed" );
    level.player unlink();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player disableslowaim();
    level.player_rig hide();
    maps\sanfran_util::setup_squad_for_gameplay();

    foreach ( var_4 in level.collapse_scene_ents )
        delete_collapse_ent( var_4 );

    level thread start_bridge_after_loop( level.explosion_scene_org );
    cleanup_road_flares();
    var_20 = getent( "saint_boost_teleport", "targetname" );
    level.saint forceteleport( var_20.origin, var_20.angles );
    common_scripts\utility::flag_set( "flag_enable_battle_chatter" );
    level thread handle_boost_jump();
}

handle_player_exo_punch()
{
    self waittill( "trigger" );
    level.player allowmelee( 0 );
    level.player maps\_utility::playerallowalternatemelee( 0 );
}

play_deploy_scene_handcuff_ents()
{
    var_0 = level.deploy_scene_handcuff_ents;

    foreach ( var_2 in var_0 )
    {
        if ( !isalive( var_2 ) || isdefined( self.delayeddeath ) && self.delayeddeath )
            continue;

        if ( isdefined( var_2.magic_bullet_shield ) && var_2.magic_bullet_shield == 1 )
            continue;

        var_2.allowdeath = 0;
        maps\sanfran_util::ai_start_magic_bullet_shield( var_2 );
    }

    if ( isdefined( var_0[0] ) && isalive( var_0[0] ) )
    {
        level.explosion_scene_org thread maps\_anim::anim_single_solo( var_0[0], "deploy_scene" );
        level.explosion_scene_org thread maps\_anim::anim_single_solo( var_0[3], "deploy_scene" );
    }

    if ( isdefined( var_0[1] ) && isalive( var_0[1] ) )
    {
        level.explosion_scene_org thread maps\_anim::anim_single_solo( var_0[1], "deploy_scene" );
        level.explosion_scene_org thread maps\_anim::anim_single_solo( var_0[2], "deploy_scene" );
    }
}

delete_atlas_van_driver( var_0 )
{
    level waittill( "van_door_interact" );
    maps\sanfran_util::ai_end_magic_bullet_shield( var_0 );
    var_0 maps\sanfran_util::kill_no_react();
}

disable_threat_atlas_van_driver( var_0 )
{
    common_scripts\utility::flag_wait( "flag_approach_scene_begin" );
    var_1 = getanimlength( var_0 maps\_utility::getanim( "approach_scene" ) );
    wait(var_1);
    var_0 maps\_variable_grenade::clear_guy_fx();
    var_0 maps\_utility::pretend_to_be_dead();
}

bridge_collapse_rumble()
{
    level endon( "flag_obj_player_on_MOB" );
    thread bridge_collapse_rumble_steady();
    thread bridge_collapse_rumble_timed();
    level.player common_scripts\utility::delaycall( 11.75, ::playrumbleonentity, "heavy_1s" );
}

bridge_collapse_rumble_steady()
{
    wait 12;
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_0.intensity = 0.1;
    waitframe();
    var_0 maps\_utility::delaythread( 0.5, maps\_utility::rumble_ramp_to, 0.3, 1.5 );
    var_0 maps\_utility::delaythread( 8, maps\_utility::rumble_ramp_to, 0, 1 );
    var_0 maps\_utility::delaythread( 13.5, maps\_utility::rumble_ramp_to, 0.3, 0.5 );
    var_0 maps\_utility::delaythread( 16, maps\_utility::rumble_ramp_to, 0, 0.1 );
    var_0 maps\_utility::delaythread( 26.5, maps\_utility::rumble_ramp_to, 0.3, 0.9 );
    var_0 maps\_utility::delaythread( 29, maps\_utility::rumble_ramp_to, 2, 0.1 );
    var_0 maps\_utility::delaythread( 29.5, maps\_utility::rumble_ramp_to, 0.3, 0.1 );
    var_0 maps\_utility::delaythread( 33, maps\_utility::rumble_ramp_to, 0.7, 3 );
    var_0 maps\_utility::delaythread( 37, maps\_utility::rumble_ramp_to, 0, 1 );
    var_0 common_scripts\utility::delaycall( 42, ::stoprumble, "steady_rumble" );
    wait 44;
    var_0 delete();
}

bridge_collapse_rumble_timed()
{
    level.player common_scripts\utility::delaycall( 8, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 9, ::playrumbleonentity, "riotshield_impact" );
    level.player common_scripts\utility::delaycall( 23, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 23.2, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 23.8, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 24.2, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 26, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 27.5, ::playrumbleonentity, "heavy_2s" );
    level.player common_scripts\utility::delaycall( 30.5, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 40.5, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 50, ::playrumbleonentity, "riotshield_impact" );
    level.player common_scripts\utility::delaycall( 51.5, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 67.8, ::playrumbleonentity, "heavy_1s" );
    level.player common_scripts\utility::delaycall( 70, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 70.4, ::playrumbleonentity, "light_1s" );
    level.player common_scripts\utility::delaycall( 72.65, ::playrumbleonentity, "riotshield_impact" );
    level.player common_scripts\utility::delaycall( 78.4, ::playrumbleonentity, "light_1s" );
}

debug_timer()
{
    var_0 = 0;

    for (;;)
    {
        iprintlnbold( "Seconds: " + var_0 );
        var_0 += 1;
        wait 1;
    }
}

take_car_door_shields()
{
    self notify( "remove_car_doors" );
}

cleanup_road_flares()
{
    var_0 = getentarray( "bridge_collapse_road_flare", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.classname == "script_model" )
            var_2 delete();
    }
}

handle_early_approach()
{
    self waittill( "trigger" );
    level.explosion_scene_org notify( "stop_early_barrier_loop" );
    level.early_approach_guy maps\_utility::anim_stopanimscripted();
    level.explosion_scene_org maps\_anim::anim_single_solo( level.early_approach_guy, "approach_scene" );
    common_scripts\utility::flag_set( "flag_approach_scene_begin" );
    level.explosion_scene_org thread maps\_anim::anim_loop_solo( level.early_approach_guy, "approach_idle", "stop_approach_loop" );
}

animate_collapse_ent( var_0 )
{
    if ( isai( self ) )
    {
        if ( self.animname != "human_sentinel_2" )
            maps\_utility::gun_remove();

        self.name = " ";
    }

    var_0 maps\_anim::anim_single_solo( self, "collapse_scene" );
    delete_collapse_ent( self );
}

show_normal_handles()
{
    self hidepart( "rear_handle_obj_left_jnt" );
    self hidepart( "rear_handle_obj_right_jnt" );
}

show_glowy_handles()
{
    self showpart( "rear_handle_obj_left_jnt" );
    self showpart( "rear_handle_obj_right_jnt" );
}

delete_collapse_ent( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( maps\_utility::is_in_array( level.heroes, var_0 ) )
        return;

    if ( maps\_utility::is_in_array( level.after_collpase_ents, var_0 ) )
        return;

    if ( isai( var_0 ) )
        var_0 maps\_utility::stop_magic_bullet_shield();

    var_0 delete();
}

swap_brigde_anim_to_real( var_0 )
{
    foreach ( var_2 in level.explosion_scene_bridge )
    {
        if ( common_scripts\utility::array_contains( level.after_collpase_ents, var_2 ) )
            continue;

        if ( var_2.model == "ggb_collapse_03_chunkg" )
            continue;

        var_2 hide();
    }

    maps\sanfran_util::show_fallen_bridge();
}

swap_brigde_anim_to_real_far( var_0 )
{
    foreach ( var_2 in level.explosion_scene_bridge )
    {
        if ( common_scripts\utility::array_contains( level.after_collpase_ents, var_2 ) )
            continue;

        var_2 hide();
    }

    maps\sanfran_util::show_far_bridge();
    maps\sanfran_util::connectpaths_ents_by_targetname( "collapse_clip" );
    maps\sanfran_util::delete_ents_by_targetname( "collapse_clip" );
}

start_bridge_after_loop( var_0 )
{
    var_0 maps\_anim::anim_loop( level.after_collpase_ents, "after_collapse_idle" );
}

start_slow_mo( var_0 )
{
    setslowmotion( 1.0, 0.2, 0.1 );
}

stop_slow_mo( var_0 )
{
    setslowmotion( 0.2, 1, 0.9 );
}

cracked_windshield_swap( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    var_1 linkto( var_0 );
    var_1 setmodel( "vehicle_civ_domestic_sedan_police_static_dstry02" );
    var_0 hide();
    thread maps\sanfran_lighting::attach_light_to_police_car( var_1 );
    var_0 waittill( "death" );
    var_1 delete();
}

cleanup_explosion_ents()
{
    level.explosion_scene_org notify( "stop_always_loop" );
    var_0 = [];
    var_0 = common_scripts\utility::array_combine( var_0, level.idle_scene_ents );
    var_0 = common_scripts\utility::array_combine( var_0, level.barrier_scene_ents );
    var_0 = common_scripts\utility::array_combine( var_0, level.approach_scene_ents );
    var_0 = common_scripts\utility::array_combine( var_0, level.approach_idle_ents );
    var_0 = common_scripts\utility::array_combine( var_0, level.deploy_scene_ents );
    var_0 = common_scripts\utility::array_combine( var_0, level.always_loop_ents );
    clearallcorpses();

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( maps\_utility::is_in_array( level.collapse_scene_ents, var_2 ) )
            continue;

        if ( maps\_utility::is_in_array( level.collapse_scene_ents_long, var_2 ) )
            continue;

        if ( maps\_utility::is_in_array( level.after_collpase_ents, var_2 ) )
            continue;

        if ( isai( var_2 ) )
            var_2 maps\_utility::stop_magic_bullet_shield();

        var_2 delete();
    }
}

#using_animtree("script_model");

rock_mob()
{
    var_0 = getent( "mob_rocking_origin", "targetname" );
    var_1 = getent( "mob_rocking_attachment_ent", "targetname" );
    var_1.animname = "MOB";
    var_1 useanimtree( #animtree );
    var_2 = getentarray( "mob_brushmodel", "targetname" );

    foreach ( var_4 in var_2 )
        var_4 linkto( var_1, "jnt_boat" );

    var_6 = getentarray( "mob_models", "targetname" );

    foreach ( var_8 in var_6 )
        var_8 linkto( var_2[0] );

    while ( !common_scripts\utility::flag( "flag_stop_mob_rocking" ) )
        var_0 maps\_anim::anim_single_solo( var_1, "mob_sway" );

    var_0 maps\_anim::anim_single_solo( var_1, "mob_sway_stop" );
}

setup_bridge_explosion_anim_sequence()
{
    if ( level.currentgen )
    {
        while ( !istransientloaded( "sanfran_bigm_tr" ) )
            wait 0.05;
    }

    level.idle_scene_ents = [];
    level.barrier_scene_ents = [];
    level.approach_scene_ents = [];
    level.approach_idle_ents = [];
    level.deploy_scene_ents = [];
    level.collapse_scene_ents = [];
    level.collapse_scene_ents_long = [];
    level.after_collpase_ents = [];
    level.deploy_scene_handcuff_ents = [];
    level.animated_gun = [];
    level.always_loop_ents = [];
    level.player_rig = maps\_utility::spawn_anim_model( "player_rig" );
    level.player_rig hide();
    level.deploy_scene_ents[level.deploy_scene_ents.size] = level.player_rig;
    level.collapse_scene_ents_long[level.collapse_scene_ents_long.size] = level.player_rig;
    level.collapse_scene_ents_long[level.collapse_scene_ents_long.size] = level.burke;
    level.explosion_scene_org = getent( "bridge_explosion_origin", "targetname" );
    setup_bridge_explosion_anim_sequence_vehicles();
    setup_bridge_explosion_anim_sequence_humans();
    setup_bridge_explosion_anim_sequence_bridge();
    level.explosion_scene_org maps\_anim::anim_first_frame( level.collapse_scene_ents, "collapse_scene" );
    level.explosion_scene_org maps\_anim::anim_first_frame( level.deploy_scene_ents, "deploy_scene" );
    level.explosion_scene_org maps\_anim::anim_first_frame( level.deploy_scene_handcuff_ents, "deploy_scene" );
    level.explosion_scene_org maps\_anim::anim_first_frame( level.approach_scene_ents, "approach_scene" );

    foreach ( var_1 in level.barrier_scene_ents )
    {
        if ( var_1.animname == "human_sentinel_7" )
        {
            level.explosion_scene_org thread maps\_anim::anim_loop_solo( var_1, "barrier_scene", "stop_early_barrier_loop" );
            continue;
        }

        level.explosion_scene_org thread maps\_anim::anim_loop_solo( var_1, "barrier_scene", "stop_barrier_loop" );
    }

    foreach ( var_1 in level.idle_scene_ents )
        level.explosion_scene_org thread maps\_anim::anim_loop_solo( var_1, "idle_scene", "stop_idle_loop" );

    foreach ( var_1 in level.always_loop_ents )
        level.explosion_scene_org thread maps\_anim::anim_loop_solo( var_1, "always_loop_scene", "stop_always_loop" );

    level thread start_bridge_overwatch_heli();
    maps\sanfran_util::notsolid_ents_by_targetname( "collapse_clip" );
}

start_bridge_overwatch_heli()
{
    level.overwatch_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "explosion_overwatch_heli" );
    level.overwatch_heli maps\_vehicle::godon();
    level.overwatch_heli maps\sanfran_util::riders_no_damage();
    var_0 = level.overwatch_heli maps\sanfran_util::heli_get_shooters();

    foreach ( var_2 in var_0 )
    {
        var_2.ignoreall = 1;
        var_2 laseron();
    }

    common_scripts\utility::flag_wait( "flag_van_explosion_start" );
    var_4 = common_scripts\utility::getstruct( "overwatch_heli_peel_off", "targetname" );
    level.overwatch_heli thread maps\_vehicle_code::_vehicle_paths( var_4 );
}

at_van_enemy_cleanup()
{
    level endon( "elevator_ascend" );
    self endon( "van_cleanup_complete" );
    var_0 = getent( "at_van_enemy_cleanup", "targetname" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_at_van_enemy_cleanup" );
        var_1 = getaiarray( "axis" );
        var_2 = [];

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4.van_scene_axis ) && var_4.van_scene_axis == 1 )
                var_2 = common_scripts\utility::array_add( var_2, var_4 );
        }

        var_1 = common_scripts\utility::array_remove_array( var_1, var_2 );

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4 ) && !maps\_utility::player_can_see_ai( var_4 ) )
                var_4 kill();

            var_7 = randomfloatrange( 0.05, 0.2 );
            wait(var_7);
        }

        if ( isdefined( var_1 ) && var_1.size < 1 )
        {
            var_0 delete();
            common_scripts\utility::flag_set( "van_cleanup_complete" );
        }

        wait 0.5;
    }
}

#using_animtree("vehicles");

setup_bridge_explosion_anim_sequence_vehicles()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_vehicle_chopper" );
    var_0 soundscripts\_snd::snd_message( "pre_bridge_collapse_helo_idle" );
    var_0 maps\_utility::delaythread( 0.2, soundscripts\_snd::snd_message, "snd_stop_vehicle" );
    var_0.animname = "chopper_1";
    var_0 useanimtree( #animtree );
    var_0 maps\_vehicle::godon();

    if ( level.nextgen )
        var_0 vehicle_scripts\_littlebird::show_static_rotors();

    level.idle_scene_ents[level.idle_scene_ents.size] = var_0;
    thread setup_helicopter_blades_damage();
    var_1 = spawn( "script_model", ( 0, 0, -1000 ) );
    var_1 setmodel( "vehicle_sentinel_littlebird_dstrypv" );
    var_1 hide();
    var_1.animname = "broken_helo";
    var_1 useanimtree( #animtree );
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_1;
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_vehicle_van" );
    var_2 maps\_vehicle::godon();
    var_2.animname = "van";
    var_2 useanimtree( #animtree );
    level.approach_scene_ents[level.approach_scene_ents.size] = var_2;
    level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
    level.explosion_van = var_2;
    level.explosion_scene_drones = [];

    for ( var_3 = 0; var_3 < 12; var_3++ )
    {
        var_4 = spawn( "script_model", var_2.origin );
        var_4 setmodel( "vehicle_atlas_assault_drone" );
        var_4.animname = "drone_" + ( var_3 + 1 );
        var_4 useanimtree( #animtree );
        var_4 hide();
        level.explosion_scene_drones[level.explosion_scene_drones.size] = var_4;
        level.deploy_scene_ents[level.deploy_scene_ents.size] = var_4;
    }

    var_5 = spawn( "script_model", var_2.origin );
    var_5 setmodel( "vehicle_atlas_assault_drone_large" );
    var_5.animname = "large_drone";
    var_5 useanimtree( #animtree );
    level.deploy_scene_ents[level.deploy_scene_ents.size] = var_5;
    level.explosion_scene_drone_large = var_5;
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_truck01" );
    var_6.animname = "truck01";
    var_6 useanimtree( #animtree );
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_6;
    var_6 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_truck02" );
    var_6.animname = "truck02";
    var_6 useanimtree( #animtree );
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_6;
    var_7 = maps\_vehicle::spawn_vehicles_from_targetname( "van_scene_vehicle_copcar" );
    soundscripts\_snd::snd_message( "spawn_parked_police_car", var_7 );

    for ( var_3 = 0; var_3 < var_7.size; var_3++ )
    {
        var_7[var_3].animname = "copcar_" + ( var_3 + 1 );
        var_7[var_3] useanimtree( #animtree );
        var_7[var_3] thread maps\sanfran_fx::cop_car_lights_on_barricade();

        if ( var_7[var_3].animname != "copcar_11" )
        {
            level.approach_scene_ents[level.approach_scene_ents.size] = var_7[var_3];
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_7[var_3];
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_7[var_3];
            continue;
        }

        level.approach_scene_ents[level.approach_scene_ents.size] = var_7[var_3];
    }

    var_8 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_atlas_suv" );
    var_8 maps\_vehicle::godon();
    var_8.animname = "atlas_suv";
    var_8 useanimtree( #animtree );
    level.approach_scene_ents[level.approach_scene_ents.size] = var_8;
    var_9 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_vehicle_bus" );
    var_9.animname = "bus";
    var_9 useanimtree( #animtree );
    var_9 hide();
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_9;
    var_10 = maps\_vehicle::spawn_vehicle_from_targetname( "van_scene_vehicle_compact" );
    var_10.animname = "compact";
    var_10 useanimtree( #animtree );
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_10;
}

setup_bridge_explosion_anim_sequence_humans()
{
    var_0 = getentarray( "van_scene_spawner_atlas", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_1 == 2 || var_1 == 3 )
            continue;

        var_2 = var_0[var_1] maps\_utility::spawn_ai( 1, 1 );
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
        var_2.animname = "human_atlas_" + ( var_1 + 1 );
        var_2.ignoresonicaoe = 1;
        var_2.van_scene_axis = 1;

        if ( var_2.animname == "human_atlas_1" )
        {
            var_2 maps\_utility::gun_remove();
            var_3 = 1;
            var_2.allowdeath = 1;
            var_2.health = 1;
            var_2 maps\_utility::stop_magic_bullet_shield();
            var_2 thread remove_from_idle_array_on_death( var_3 );
            var_2.noragdoll = undefined;
            level.approach_scene_ents[level.approach_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_atlas_2" )
        {
            var_3 = 0;
            var_2.allowdeath = 1;
            var_2.health = 1;
            var_2 maps\_utility::stop_magic_bullet_shield();
            var_2 thread remove_from_idle_array_on_death( var_3 );
            var_2.noragdoll = undefined;
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.approach_scene_ents[level.approach_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_atlas_3" )
        {
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_atlas_4" )
        {
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_atlas_5" )
        {
            var_2 maps\_utility::gun_remove();
            level.approach_scene_ents[level.approach_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            thread delete_atlas_van_driver( var_2 );
            thread disable_threat_atlas_van_driver( var_2 );
        }
    }

    var_0 = getentarray( "van_scene_spawner_sentinel", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( var_1 == 11 || var_1 == 13 )
            continue;

        var_2 = var_0[var_1] maps\_utility::spawn_ai( 1, 1 );
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
        var_2.animname = "human_sentinel_" + ( var_1 + 1 );
        level.approach_scene_ents[level.approach_scene_ents.size] = var_2;

        if ( var_2.animname == "human_sentinel_1" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.sentinel_op1 = var_2;
        }

        if ( var_2.animname == "human_sentinel_2" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
            level.sentinel_op2 = var_2;
        }

        if ( var_2.animname == "human_sentinel_3" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_4" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
            level.sentinel_op4 = var_2;
        }

        if ( var_2.animname == "human_sentinel_5" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_6" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_7" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_scene_ents = common_scripts\utility::array_remove( level.approach_scene_ents, var_2 );
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
            level.early_approach_guy = var_2;
        }

        if ( var_2.animname == "human_sentinel_8" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_9" )
        {
            level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
            level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_10" )
        {
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
        }

        if ( var_2.animname == "human_sentinel_11" )
        {
            level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
        }
    }

    var_4 = getent( "van_scene_spawner_police_special", "targetname" );
    var_2 = var_4 maps\_utility::spawn_ai( 1, 1 );
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.animname = "human_police_1";
    level.collapse_cop = var_2;
    level.barrier_scene_ents[level.barrier_scene_ents.size] = var_2;
    level.approach_scene_ents[level.approach_scene_ents.size] = var_2;
    level.approach_idle_ents[level.approach_idle_ents.size] = var_2;
    level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
    var_4 = getent( "van_scene_spawner_police", "targetname" );
    var_2 = var_4 maps\_utility::spawn_ai( 1, 1 );
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.animname = "human_police_2";
    level.always_loop_ents[level.always_loop_ents.size] = var_2;
    level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
    var_0 = getentarray( "van_scene_spawner_civilian", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = var_0[var_1] maps\_utility::spawn_ai( 1, 1 );
        var_2.ignoreme = 1;
        var_2.ignoreall = 1;
        var_2.animname = "human_civilian_" + ( var_1 + 1 );
        level.collapse_scene_ents[level.collapse_scene_ents.size] = var_2;
    }
}

#using_animtree("script_model");

setup_bridge_explosion_anim_sequence_bridge()
{
    level.explosion_scene_bridge = [];

    for ( var_0 = 1; var_0 <= 7; var_0++ )
    {
        var_1 = spawn( "script_model", ( 0, 0, -1000 ) );

        if ( var_0 == 1 )
        {
            var_1 setmodel( "ggb_collapse_03_chunka" );
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_1;
            level.after_collpase_ents[level.after_collpase_ents.size] = var_1;
        }
        else if ( var_0 == 2 )
        {
            var_1 setmodel( "ggb_collapse_03_chunkb" );
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_1;
            level.after_collpase_ents[level.after_collpase_ents.size] = var_1;
        }
        else if ( var_0 == 3 )
        {
            var_1 setmodel( "ggb_collapse_03_chunkc" );
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_1;
            level.after_collpase_ents[level.after_collpase_ents.size] = var_1;
        }
        else if ( var_0 == 4 )
        {
            var_1 setmodel( "ggb_collapse_03_chunkd" );
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_1;
            level.after_collpase_ents[level.after_collpase_ents.size] = var_1;
        }
        else if ( var_0 == 5 )
            var_1 setmodel( "ggb_collapse_03_chunke" );
        else if ( var_0 == 6 )
            var_1 setmodel( "ggb_collapse_03_chunkf" );
        else if ( var_0 == 7 )
        {
            var_1 setmodel( "ggb_collapse_03_chunkg" );
            level.deploy_scene_ents[level.deploy_scene_ents.size] = var_1;
        }

        var_1.animname = "bridge0" + var_0;
        var_1 useanimtree( #animtree );
        var_1 hide();
        level.explosion_scene_bridge[level.explosion_scene_bridge.size] = var_1;
        level.collapse_scene_ents[level.collapse_scene_ents.size] = var_1;
    }

    for ( var_0 = 1; var_0 <= 2; var_0++ )
    {
        var_2 = spawn( "script_model", ( 0, 0, -1000 ) );
        var_2 setmodel( "ggb_cable_hero_01" );
        var_2.animname = "rope_" + var_0;
        var_2 useanimtree( #animtree );
        var_2 hide();
        level.deploy_scene_ents[level.deploy_scene_ents.size] = var_2;
    }

    var_3 = spawn( "script_model", ( 0, 0, -1000 ) );
    var_3 setmodel( "vm_hbra3_nocamo" );
    var_3.animname = "gun";
    var_3 useanimtree( #animtree );
    var_3 hide();
    level.deploy_scene_ents[level.deploy_scene_ents.size] = var_3;

    for ( var_0 = 1; var_0 <= 2; var_0++ )
    {
        var_3 = spawn( "script_model", ( 0, 0, -1000 ) );
        var_3 setmodel( "npc_sn6_base_black" );
        var_3.animname = "sn6_0" + var_0;
        var_3 useanimtree( #animtree );
        level.animated_gun[var_0] = var_3;
        level.approach_scene_ents[level.approach_scene_ents.size] = var_3;

        if ( var_3.animname == "sn6_02" )
            level.approach_idle_ents[level.approach_idle_ents.size] = var_3;
    }

    var_4 = spawn( "script_model", ( 0, 0, -1000 ) );
    var_4 setmodel( "deployable_cover" );
    var_4.animname = "cover";
    var_4 useanimtree( #animtree );
    level.approach_scene_ents[level.approach_scene_ents.size] = var_4;
    var_5 = spawn( "script_model", level.player.origin );
    var_5 setmodel( "vm_lasercutter" );
    var_5 hide();
    var_5.animname = "cutter";
    var_5 useanimtree( #animtree );
    level.deploy_scene_ents[level.deploy_scene_ents.size] = var_5;
    level.cutter = var_5;
}

remove_from_idle_array_on_death( var_0 )
{
    self waittill( "death" );

    if ( var_0 )
    {
        var_1 = level.animated_gun;
        var_2 = var_1[1].origin;
        var_3 = spawn( "script_model", var_1[1].origin );
        var_3.angles = var_1[1].angles;
        var_3 setmodel( var_1[1].model );
        var_1[1] delete();
        var_3 physicslaunchclient( var_3.origin, ( 0, 15, 200 ) );
    }

    level.barrier_scene_ents = common_scripts\utility::array_remove( level.barrier_scene_ents, self );
    level.approach_scene_ents = common_scripts\utility::array_remove( level.approach_scene_ents, self );
    level.approach_idle_ents = common_scripts\utility::array_remove( level.approach_idle_ents, self );
    level.collapse_scene_ents = common_scripts\utility::array_remove( level.collapse_scene_ents, self );
}

handle_boost_jump()
{
    common_scripts\utility::flag_set( "flag_obj_boost_to_MOB" );
    maps\_utility::autosave_by_name();
    level thread move_overwatch_heli_to_slope();
    level thread maps\sanfran_util::give_boost_jump();
    common_scripts\utility::run_thread_on_targetname( "trigger_boost_down_color", ::boost_down_in_order );
    common_scripts\utility::run_thread_on_noteworthy( "trigger_boost_burke_lets_go", ::boost_lets_go );
    maps\_utility::activate_trigger_with_targetname( "start_boost_jump" );
    common_scripts\utility::flag_set( "start_boost_lighting" );
    common_scripts\utility::flag_set( "flag_dialog_start_boost" );
    common_scripts\utility::flag_set( "flag_dialog_boost_nag" );
    common_scripts\utility::flag_set( "flag_dialog_boost_chatter" );
    level notify( "vfx_boost_jump_start" );
    common_scripts\utility::run_thread_on_targetname( "trigger_on_ship", ::wait_till_on_ship );
}

boost_lets_go()
{
    self endon( "death" );
    self waittill( "trigger" );
    level thread anim_burke_boost_lets_go();
}

anim_burke_boost_lets_go()
{
    var_0 = getent( "boost_burke_lets_go", "targetname" );
    var_1 = getnode( "boost_burke_lets_go_goal", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "boost_go" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "boost_go" );
    level.burke thread maps\_spawner::go_to_node( var_1 );
    level.burke maps\_utility::enable_ai_color_dontmove();
}

wait_till_on_ship()
{
    self waittill( "trigger" );
    common_scripts\utility::flag_set( "flag_obj_player_on_MOB" );
    wait 1.0;

    if ( isalive( level.player ) )
    {
        maps\_loadout_code::saveplayerweaponstatepersistent( "sanfran", 1 );
        maps\_utility::nextmission();
    }
}

boost_down_in_order()
{
    self endon( "death" );
    self waittill( "trigger" );
    var_0 = getentarray( "trigger_boost_down_color", "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( var_2.script_index < self.script_index )
            var_2 delete();
    }

    wait 0.05;
    self delete();
}

move_overwatch_heli_to_slope()
{
    if ( !isdefined( level.overwatch_heli ) )
    {
        level.overwatch_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "explosion_overwatch_heli" );
        level.overwatch_heli maps\_vehicle::godon();
        level.overwatch_heli maps\sanfran_util::riders_no_damage();
        var_0 = level.overwatch_heli maps\sanfran_util::heli_get_shooters();

        foreach ( var_2 in var_0 )
        {
            var_2.ignoreall = 1;
            var_2 laseron();
        }
    }

    var_4 = common_scripts\utility::getstruct( "overwatch_heli_boost", "targetname" );
    level.overwatch_heli thread maps\_vehicle_code::_vehicle_paths( var_4 );
}

railing_dangerzone_think()
{
    var_0 = [];

    for (;;)
    {
        common_scripts\utility::flag_wait( "railing_danger_zone_touching" );
        var_1 = getaiarray( "axis" );

        foreach ( var_3 in var_1 )
        {
            if ( randomfloat( 100 ) < 75 && isalive( var_3 ) && !isdefined( var_3.isseeking ) )
            {
                var_3 thread dangerzone_enemy_seek_player();
                var_0 = common_scripts\utility::array_add( var_0, var_3 );
            }
        }

        var_5 = undefined;
        common_scripts\utility::flag_waitopen( "railing_danger_zone_touching" );
        var_0 = [];
        wait 1.0;
    }
}

dangerzone_enemy_seek_player()
{
    self endon( "death" );
    thread maps\_utility::player_seek_enable();
    self.isseeking = 1;
    common_scripts\utility::flag_waitopen( "railing_danger_zone_touching" );
    thread maps\_utility::player_seek_disable();
    self.isseeking = undefined;
}
