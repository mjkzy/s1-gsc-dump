// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "df_fly" );
    _func_0D3( "vehPlaneSwapSticks", "0" );
    maps\_utility::add_control_based_hint_strings( "climb_hint", &"PLAYERPLANE_MOVEMENT_HINT", ::climb_hint, &"PLAYERPLANE_MOVEMENT_HINT_PC", &"PLAYERPLANE_MOVEMENT_HINT_SP" );
    maps\_utility::add_hint_string( "boost_hint", &"PLAYERPLANE_AFTERBURNERS_HINT", ::boost_hint );
    maps\_utility::add_hint_string( "missile_hint", &"PLAYERPLANE_MISSILES_HINT", ::missile_hint );
    maps\_utility::add_hint_string( "airbrake_hint", &"PLAYERPLANE_BRAKE_HINT", maps\df_canyon_script::airbrake_hint );
    maps\_utility::add_hint_string( "airbrake_hint_pc_toggle", &"PLAYERPLANE_BRAKE_HINT_PC_TOGGLE", maps\df_canyon_script::airbrake_hint );
    maps\_utility::add_hint_string( "airbrake_hint_pc_hold", &"PLAYERPLANE_BRAKE_HINT_PC_HOLD", maps\df_canyon_script::airbrake_hint );
    maps\_utility::add_hint_string( "gun_hint", &"PLAYERPLANE_GUNS_HINT", ::gun_hint );
    df_fly_precache();
    df_fly_pre_load();
    level.custom_no_game_setupfunc = ::canyon_no_game_start_setupfunc;
    maps\createart\df_fly_art::main();
    maps\df_fly_code::precache_code();
    maps\df_fly_fx::main();
    maps\df_fly_precache::main();
    maps\df_fly_anim::main();
    maps\createfx\df_fly_fx::main();
    df_fly_starts();
    maps\_load::main();
    maps\df_fly_lighting::main();
    maps\df_fly_aud::main();
    level thread maps\_upgrade_system::init();
    maps\df_fly_flight_code::flight_code_main();
}

canyon_no_game_start_setupfunc()
{
    level.player _meth_83C0( "df_fly_canyon", 0 );
    maps\_utility::vision_set_fog_changes( "df_fly_canyon", 0 );
    thread maps\df_fly_lighting::set_sun_flare();
}

df_fly_starts()
{
    maps\_utility::add_start( "canyon_intro", ::setup_intro_canyon, "canyon_intro", maps\df_canyon_script::begin_canyon_intro );
    maps\_utility::add_start( "canyon", maps\df_canyon_script::setup_canyon, "canyon", maps\df_canyon_script::begin_canyon );
    maps\_utility::add_start( "canyon2", maps\df_canyon_script::setup_canyon2, "canyon2", maps\df_canyon_script::begin_canyon2 );
    maps\_utility::add_start( "canyon_dam", maps\df_canyon_script::setup_canyon_dam, "canyon_dam", maps\df_canyon_script::begin_canyon_dam );
    maps\_utility::add_start( "canyon3", maps\df_canyon_script::setup_canyon3, "canyon3", maps\df_canyon_script::begin_canyon3 );
    maps\_utility::add_start( "canyon_exit", maps\df_canyon_script::setup_canyon_exit, "canyon_exit", maps\df_canyon_script::begin_canyon_exit );
}

setup_nothing()
{

}

df_fly_precache()
{
    precachemodel( "generic_prop_raven" );
    precachemodel( "viewbody_sentinel_pilot_mitchell" );
    precachemodel( "vehicle_sentinel_drop_pod_jet" );
    precachemodel( "sentinel_drop_pod" );
    precachemodel( "sentinel_drop_pod_vm" );
    precachemodel( "atlas_vtol_cargo_plane_ext_ai" );
    precachemodel( "atlas_vtol_cargo_plane_fuel_rod" );
    precacheshader( "overlay_static_digital" );
    precacheshader( "s1_railgun_hud_outer_shadow" );
    precachemodel( "vehicle_mig29" );
    precacherumble( "steady_rumble" );
    precachestring( &"invert_flight_controls_popmenu" );
    precachestring( &"flight_controls_setting_popmenu" );
    precachestring( &"plane_hud_fade_out" );
    precachestring( &"plane_hud_fade_in" );
    precachestring( &"PLAYERPLANE_MOVEMENT_HINT" );
    precachestring( &"PLAYERPLANE_AFTERBURNERS_HINT" );
    precachestring( &"PLAYERPLANE_BRAKES_HINT" );
    precachestring( &"PLAYERPLANE_MISSILES_HINT" );
    precachestring( &"PLAYERPLANE_GUNS_HINT" );
    precachestring( &"DF_BAGHDAD_YOU_CRASHED" );
}

df_fly_pre_load()
{
    common_scripts\utility::flag_init( "finale_vo_done" );
    common_scripts\utility::flag_init( "hint_time" );
    common_scripts\utility::flag_init( "fuel_contact" );
    common_scripts\utility::flag_init( "fuel_complete" );
    common_scripts\utility::flag_init( "intro_scene_done" );
    common_scripts\utility::flag_init( "player_braking" );
    common_scripts\utility::flag_init( "intro_screen_done" );
    common_scripts\utility::flag_init( "intro_vo_done" );
    common_scripts\utility::flag_init( "controls_set" );
    common_scripts\utility::flag_init( "player_steered" );
    common_scripts\utility::flag_init( "boost_hint" );
    common_scripts\utility::flag_init( "intro_ally_enemies_dead" );
    common_scripts\utility::flag_init( "intro_enemies_dead" );
    common_scripts\utility::flag_init( "intro_regrouped" );
    common_scripts\utility::flag_init( "intro_finished" );
    common_scripts\utility::flag_init( "canyon_finished" );
    common_scripts\utility::flag_init( "end_fighter_jet_sequence" );
    common_scripts\utility::flag_init( "final_hit" );
    common_scripts\utility::flag_init( "finale" );
    common_scripts\utility::flag_init( "playerPlaneNoDeath" );
    common_scripts\utility::flag_init( "ambush_dead" );
    common_scripts\utility::flag_init( "ally_tailer_dead" );
    common_scripts\utility::flag_init( "airbrake_hint" );
    common_scripts\utility::flag_init( "dam_destroyed" );
    common_scripts\utility::flag_init( "hoodoo1" );
    common_scripts\utility::flag_init( "bridge_fall" );
    common_scripts\utility::flag_init( "red_hoodoo1" );
    common_scripts\utility::flag_init( "red_hoodoo2" );
    common_scripts\utility::flag_init( "red_hoodoo3" );
    common_scripts\utility::flag_init( "red_hoodoo3b" );
    common_scripts\utility::flag_init( "red_hoodoo3c" );
    common_scripts\utility::flag_init( "arch_r" );
    common_scripts\utility::flag_init( "arch_l" );
    common_scripts\utility::flag_init( "hoodoo_w1" );
    common_scripts\utility::flag_init( "hoodoo_w2" );
    common_scripts\utility::flag_init( "hoodoo_w3" );
    common_scripts\utility::flag_init( "hoodoo_w4" );
    common_scripts\utility::flag_init( "hoodoo_w5" );
    common_scripts\utility::flag_init( "dam_cracks2" );
    common_scripts\utility::flag_init( "explode_wall_hoodoo" );
    common_scripts\utility::flag_init( "trig_amb_enemywave_starters" );
    common_scripts\utility::flag_init( "trig_amb_enemywave1" );
    common_scripts\utility::flag_init( "trig_amb_enemywave2" );
    common_scripts\utility::flag_init( "trig_amb_enemywave3" );
    common_scripts\utility::flag_init( "trig_amb_enemywave4" );
    common_scripts\utility::flag_init( "trig_amb_enemywave5" );
    common_scripts\utility::flag_init( "trig_amb_enemywave6" );
    common_scripts\utility::flag_init( "trig_amb_enemywave7" );
    common_scripts\utility::flag_init( "trig_amb_enemywave8" );
    common_scripts\utility::flag_init( "trig_amb_enemywave9" );
    common_scripts\utility::flag_init( "trig_amb_enemywave10" );
}

setup_common()
{
    level.mini_version = 0;
    level.current_median_speed = 0.5;
    level.current_objective = 1;
    level.player_fired_missiles = 0;
    level.base_agl = 62000;
    level.ally_ai_active = 0;
    level.allies = [];
    maps\_utility::add_extra_autosave_check( "fly_check", ::autosave_fly_check, "can't autosave when about to crash" );
    thread maps\df_canyon_script::handle_dying_player_brake_hint();
}

autosave_fly_check()
{
    var_0 = 3;
    var_1 = 0.1;
    var_2 = 20;
    var_3 = 3;
    var_4 = 2;
    var_5 = level.plane;
    var_6 = var_5 maps\_shg_utility::get_differentiated_acceleration();
    var_7 = var_5 _meth_8287();
    var_8 = length( var_7 );

    if ( var_8 > 0 )
    {
        var_9 = var_7 + var_6 * ( var_1 * 0.5 );
        var_10 = var_5.origin;
        var_11 = var_5.origin + var_9 * var_0;
        var_12 = bullettrace( var_10, var_11, 0, var_5 );

        if ( var_12["fraction"] < 1 && ( !isdefined( var_12["entity"] ) || !isdefined( var_12["entity"].targetname ) || var_12["entity"].targetname != "turnaround_vol" ) )
        {
            var_13 = distance( var_5.origin, var_12["position"] );
            var_14 = var_13 / var_8;

            if ( var_14 > var_1 + 0.01 )
            {
                var_15 = vectorlerp( var_5.origin + var_9 * var_1, var_12["position"], 0.5 );
                var_16 = ( var_14 - var_1 ) * var_2;
                var_17 = var_14;
                var_18 = randomfloat( 90 );

                foreach ( var_20 in [ 0, 90, 180, 270 ] )
                {
                    var_21 = anglestoforward( combineangles( var_5.angles, combineangles( ( 0, 0, var_20 + var_18 ), ( var_16, 0, 0 ) ) ) );
                    var_22 = var_15 + var_21 * ( var_8 * var_0 );
                    var_23 = bullettrace( var_15, var_22, 0, var_5 );
                    var_24 = distance( var_5.origin, var_23["position"] ) / var_8 + var_14;
                    var_17 = max( var_17, var_24 );
                }
            }
            else
                var_17 = var_14;
        }
        else
            var_17 = var_0;
    }
    else
        var_17 = var_0;

    return var_17 >= var_0;
}

intro_movie()
{
    level.player _meth_831D();
    level.player freezecontrols( 1 );
    var_0 = newclienthudelem( level.player );
    var_0 _meth_80CC( "black", 1280, 720 );
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.alpha = 1;
    var_0.foreground = 0;
    maps\_shg_utility::play_chyron_video( "chyron_text_df_fly" );
    thread maps\df_canyon_script::canyon_intro_vo();
    common_scripts\utility::flag_wait( "intro_vo_done" );
    wait 1;
    common_scripts\utility::flag_set( "intro_screen_done" );
    var_0 fadeovertime( 2 );
    var_0.alpha = 0;
    wait 2;
    var_0 destroy();
}

setup_intro()
{
    setup_common();
    level.player freezecontrols( 1 );
}

setup_intro_old_controls()
{
    level.old_controls = 1;
    setup_intro();
}

setup_intro_canyon()
{
    setup_common();
    level.player freezecontrols( 1 );
    soundscripts\_snd::snd_message( "snd_start_canyon_intro" );
}

setup_intro_canyon_old_controls()
{
    level.old_controls = 1;
    setup_intro_canyon();
}

setup_post_refuel()
{
    setup_common();
    level.player freezecontrols( 1 );
    common_scripts\utility::flag_set( "intro_screen_done" );
    common_scripts\utility::flag_set( "intro_scene_done" );
}

setup_post_refuel_old_controls()
{
    level.old_controls = 1;
    setup_post_refuel();
}

post_refuel()
{
    level.old_gravity = getdvarfloat( "vehPlaneGravityVelocity" );
    _func_0D3( "vehPlaneGravityVelocity", 0 );
    thread intro_vo();
    thread handle_intro_clip();
    maps\df_fly_flight_code::flight_code_start( "intro_player_jet", 1 );
    thread handle_gun_hint();

    for ( var_0 = 1; var_0 <= 3; var_0++ )
    {
        var_1 = "ally" + var_0;
        var_2 = getent( var_1, "script_noteworthy" );
        var_2 maps\df_fly_flight_code::make_ally_jet( level.plane, 1, 1 );
    }

    thread handle_clouds( level.plane, "intro_finished" );
    var_3 = maps\_utility::obj( "intro_follow" );
    objective_add( var_3, "current", "Stay in formation" );
    objective_onentity( var_3, level.allies[0], ( 0, 0, 0 ) );
    objective_setpointertextoverride( var_3, "Follow" );

    for ( var_0 = 1; var_0 < level.allies.size; var_0++ )
        objective_additionalentity( var_3, var_0, level.allies[var_0], ( 0, 0, 0 ) );

    wait 1;
    maps\_utility::delaythread( 2, ::handle_formation_nags );
    level.player freezecontrols( 0 );
    level.player thread maps\_utility::display_hint_timeout( "climb_hint", 5 );
    var_4 = 0;
    common_scripts\utility::flag_set( "controls_set" );
    common_scripts\utility::flag_wait( "set_waypoint" );
    level.player _meth_84F6( &"invert_flight_controls_popmenu" );
    var_5 = getent( "waypoint1", "targetname" );
    var_6 = maps\_utility::obj( "intro_waypoint" );
    objective_add( var_6, "current", "Proceed to waypoint" );
    objective_onentity( var_6, var_5, ( 0, 0, 0 ) );
    objective_setpointertextoverride( var_6, "Reach" );
    common_scripts\utility::flag_wait( "waypoint1_reached" );
    maps\_utility::objective_complete( var_6 );
    common_scripts\utility::flag_wait( "intro_bogeys" );
    level notify( "ignore_formation" );
    soundscripts\_snd::snd_music_message( "df_fly_jet_combat" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 10000, 1 );
    maps\_utility::objective_complete( var_3 );
    level.enemy_units = [];
    level.next_obj_pos = 0;
    var_7 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "intro_enemy" );
    thread maps\df_fly_code::ai_array_killcount_flag_set( var_7, var_7.size, "intro_enemies_dead" );
    thread maps\df_fly_code::ai_array_killcount_flag_set( var_7, var_7.size - 1, "intro_ally_enemies_dead" );
    common_scripts\utility::array_thread( var_7, maps\df_fly_flight_code::make_enemy_jet, "dogfight_enemies" );
    var_8 = maps\_utility::obj( "dogfight_enemies" );
    level.enemy_objectives = var_7;
    initmultiobjectives( "dogfight_enemies", var_7 );
    thread multiple_objectives( "dogfight_enemies" );
    common_scripts\utility::flag_wait( "boost_hint" );
    level.player thread maps\_utility::display_hint_timeout( "boost_hint", 5 );
    common_scripts\utility::flag_wait( "shoot_missiles" );
    level.player thread maps\_utility::display_hint_timeout( "missile_hint", 5 );
    var_7 = maps\_utility::remove_dead_from_array( var_7 );
    thread dogfight_vo( var_7 );
    var_9 = maps\df_fly_flight_code::get_jet_array( "player_enemy" );
    common_scripts\utility::array_thread( var_9, maps\df_fly_flight_code::set_optimal_flight_dist, 1000, 1 );
    thread enemies_move_away();
    var_10 = maps\df_fly_flight_code::get_jet_array( "ally_enemy" );
    maps\df_fly_flight_code::engage_enemies( level.allies, var_10, 5, 10 );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 1500, 1 );
    thread nag_player_to_shoot_target( var_9 );
    common_scripts\utility::flag_wait( "intro_ally_enemies_dead" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 1000, 1 );
    common_scripts\utility::flag_wait( "intro_enemies_dead" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 4000, 1 );
    level.allies[2] maps\df_fly_flight_code::set_optimal_flight_dist( 6000, 1 );
    maps\_utility::objective_complete( maps\_utility::obj( "dogfight_enemies" ) );
    thread setup_regroup_obj();
    wait 0.5;
    level.plane maps\df_fly_code::wait_for_formation( level.allies, 7000, 2 );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 8000, 1 );
    common_scripts\utility::flag_set( "intro_regrouped" );
    common_scripts\utility::flag_wait( "drop_down" );
    maps\_utility::objective_complete( maps\_utility::obj( "intro_regroup" ) );
    common_scripts\utility::flag_set( "intro_finished" );
    common_scripts\utility::flag_wait( "intro_finished" );
    level.player maps\_hud_util::fade_out( 1, "white" );
    wait 1;
    _func_0D3( "vehPlaneGravityVelocity", level.old_gravity );

    foreach ( var_12 in level.allies )
        var_12 delete();

    level.allies = [];
}

multiple_objectives( var_0 )
{
    foreach ( var_2 in level.enemy_objectives )
        var_2 thread objectivedeathdetection( var_0 );
}

objectivedeathdetection( var_0 )
{
    self endon( "removed" );
    self waittill( "death" );
    level.enemy_objectives = common_scripts\utility::array_remove( level.enemy_objectives, self );
    objective_delete( maps\_utility::obj( var_0 ) );
    initmultiobjectives( var_0, level.enemy_objectives );
}

initmultiobjectives( var_0, var_1 )
{
    objective_add( maps\_utility::obj( var_0 ), "current", "Dogfight enemy aircraft" );
    objective_setpointertextoverride( maps\_utility::obj( var_0 ), "Destroy" );
    var_2 = 0;

    foreach ( var_4 in var_1 )
    {
        objective_additionalentity( maps\_utility::obj( var_0 ), var_2, var_1[var_2] );
        var_2++;
    }
}

handle_gun_hint()
{
    level.player_shot_guns = 0;

    while ( !level.player_shot_guns && !isdefined( level.plane.lock_target ) )
    {
        wait 0.2;

        if ( isdefined( level.plane.lock_target ) )
        {
            level.player thread maps\_utility::display_hint_timeout( "gun_hint", 5 );
            wait 10;
        }
    }
}

enemies_move_away()
{
    wait 3;
    var_0 = maps\_utility::remove_dead_from_array( level.enemy_units );
    common_scripts\utility::array_thread( var_0, maps\df_fly_flight_code::set_optimal_flight_dist, 15000, 1 );
}

handle_clouds( var_0, var_1 )
{
    playfxontag( common_scripts\utility::getfx( "bagh_flight_cloud_volume" ), var_0, "tag_origin" );
    var_2 = common_scripts\utility::getstructarray( "large_cloud", "targetname" );

    foreach ( var_4 in var_2 )
        playfx( common_scripts\utility::getfx( "large_cloud" ), var_4.origin, anglestoforward( var_4.angles ) );

    common_scripts\utility::flag_wait( var_1 );
    stopfxontag( common_scripts\utility::getfx( "bagh_flight_cloud_volume" ), var_0, "tag_origin" );
}

handle_intro_clip()
{
    var_0 = getent( "intro_clip", "script_noteworthy" );
    var_0 _meth_82BF();
    common_scripts\utility::flag_wait( "in_the_sky" );
    var_0 _meth_82BE();
}

nag_player_to_shoot_target( var_0 )
{
    level endon( "intro_enemies_dead" );
    wait 10;
    var_1 = var_0[0];

    if ( isalive( var_1 ) )
    {
        level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_getonthat" );
        var_2 = undefined;
        var_3 = 0;

        foreach ( var_5 in level.allies )
        {
            var_6 = _func_220( var_5.origin, var_1.origin );

            if ( var_3 == 0 || var_6 < var_3 )
                var_2 = var_5;
        }

        var_2 thread maps\df_fly_flight_code::shoot_target_till_dead( var_1, 3, 10 );
    }
}

setup_regroup_obj()
{
    var_0 = maps\_utility::obj( "intro_regroup" );
    objective_add( var_0, "current", "Regroup with flight wing." );
    objective_onentity( var_0, level.allies[0], ( 0, 0, 0 ) );
    objective_setpointertextoverride( var_0, "Follow" );

    for ( var_1 = 1; var_1 < level.allies.size; var_1++ )
        objective_additionalentity( var_0, var_1, level.allies[var_1], ( 0, 0, 0 ) );
}

dogfight_vo( var_0 )
{
    var_1 = [];
    var_1[0] = "df_gid_onedown";
    var_1[1] = "df_nox_scratchone";
    var_1[2] = "df_nox_spanked";
    var_2[3] = "df_nox_trgtdestroyed";
    var_3 = [];
    var_3[0] = "df_gid_niceshot";
    var_3[1] = "df_gid_goodshot";
    var_3[2] = "df_gid_sierrahotel";
    var_3[3] = "df_nox_niceshootin";
    var_4 = "";
    var_5 = 0;
    var_6 = 0;

    for ( var_7 = 0; var_7 < var_0.size - 1; var_7++ )
    {
        var_8 = level common_scripts\utility::waittill_any_return( "enemy_dead", "enemy_dead_by_player" );

        if ( var_8 == "enemy_dead_by_player" )
        {
            var_4 = var_3[var_6];
            var_6++;
        }
        else
        {
            var_4 = var_1[var_5];
            var_5++;
        }

        maps\df_fly_code::radio_dialog_add_and_go( var_4 );
    }
}

intro_vo()
{
    common_scripts\utility::flag_wait( "intro_scene_done" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_refuelcomp" );
    wait 0.5;
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_so_unwantedattention" );
    common_scripts\utility::flag_wait_or_timeout( "set_waypoint", 11 );
    common_scripts\utility::flag_set( "set_waypoint" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_so_alphnovember" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_eyespeeled" );
    common_scripts\utility::flag_wait( "waypoint1_reached" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_so_runposition" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_fencein" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_nox_active" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_mag_online" );
    common_scripts\utility::flag_wait( "intro_bogeys" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_nox_4bogies" );
    common_scripts\utility::flag_set( "boost_hint" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_burnerson" );
    common_scripts\utility::flag_set( "shoot_missiles" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_bumpingheads" );
    level.ally_ai_active = 1;
    common_scripts\utility::flag_wait( "intro_enemies_dead" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_thatsall" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_regroup" );
    common_scripts\utility::flag_wait( "intro_regrouped" );
    level.player thread maps\df_fly_code::radio_dialog_add_and_go( "df_gid_chereubsnine" );
    thread drop_down();
}

handle_formation_nags()
{
    level endon( "ignore_formation" );
    var_0 = 8000;
    var_1 = [];
    var_1[0] = "df_gid_stayinformation";
    var_1[1] = "df_gid_return";
    var_1[2] = "df_gid_return";
    var_2 = 0;

    for (;;)
    {
        level.plane maps\df_fly_code::wait_for_formation_break( level.allies, var_0, 1 );
        level.player maps\df_fly_code::radio_dialog_add_and_go( var_1[var_2] );
        var_2++;

        if ( var_2 > var_1.size )
            var_2 = 0;

        wait 5;

        if ( !maps\df_fly_code::plane_in_formation( level.plane, level.allies, var_0 ) )
            level.player thread maps\df_fly_code::radio_dialog_add_and_go( "df_gid_jeopardizing" );
    }
}

intro_screen()
{
    var_0 = 20;
    thread maps\_introscreen::introscreen( 1, var_0 );
    wait(var_0);
    common_scripts\utility::flag_set( "intro_screen_done" );
}

gun_hint()
{
    if ( level.player_shot_guns )
        return 1;

    return 0;
}

missile_hint()
{
    if ( level.player_fired_missiles )
        return 1;

    return 0;
}

boost_hint()
{
    if ( level.player_boosting )
        return 1;

    return 0;
}

climb_hint()
{
    if ( common_scripts\utility::flag( "player_steered" ) )
        return 1;

    return 0;
}

wait_for_stick_press()
{
    var_0 = 0.1;
    var_1 = maps\_utility::make_array( 0, 0 );
    var_2 = 0;
    var_3 = 7;

    while ( var_2 < var_3 )
    {
        if ( level.player common_scripts\utility::is_player_gamepad_enabled() )
        {
            var_1 = self _meth_82F3();

            if ( abs( var_1[0] ) > var_0 )
                var_2 += 0.05;

            if ( var_2 > 1 )
                common_scripts\utility::flag_set( "player_steered" );
        }
        else
        {
            var_2 += 0.05;

            if ( var_2 > 3 )
                common_scripts\utility::flag_set( "player_steered" );
        }

        wait 0.05;
    }

    common_scripts\utility::flag_set( "controls_set" );
}

drop_down()
{
    var_0 = 1;
    var_1 = "a";

    foreach ( var_3 in level.allies )
    {
        var_3 maps\df_fly_flight_code::set_optimal_flight_dist( 5000 );

        if ( var_0 == 1 )
            var_1 = var_3 find_drop_path();

        var_4 = "ally_drop_path" + var_0 + var_1;
        var_5 = getvehiclenode( var_4, "targetname" );
        var_3 thread maps\_vehicle::vehicle_paths( var_5 );
        var_3 _meth_827F( var_5 );
        var_0++;
    }
}

find_drop_path()
{
    var_0 = getvehiclenodearray( "drop_down_start", "script_noteworthy" );
    var_1 = -1;
    var_2 = "z";

    foreach ( var_4 in var_0 )
    {
        var_5 = var_4.targetname[var_4.targetname.size - 1];

        if ( var_5 != var_2 )
        {
            if ( maps\_utility::get_dot( self.origin, self.angles, var_4.origin ) > 0.93 )
            {
                var_6 = _func_220( self.origin, var_4.origin );

                if ( var_1 == -1 || var_6 < var_1 )
                {
                    var_1 = var_6;
                    var_2 = var_5;
                }
            }
        }
    }

    return var_2;
}

intro_scene( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_vehicle();
        var_1[var_1.size] = var_4;
        var_4.animname = "ally" + var_4.script_noteworthy[var_4.script_noteworthy.size - 1];
        var_4 _meth_8115( level.scr_animtree[var_4.animname] );
    }

    common_scripts\utility::array_thread( var_1, ::playfakecontrail );
    var_6 = maps\_utility::spawn_anim_model( "refueler" );
    var_7 = maps\_utility::spawn_anim_model( "fuel_rod" );
    var_8 = maps\_utility::spawn_anim_model( "cockpit" );
    level.intro_arms = maps\_utility::spawn_anim_model( "player_rig" );
    playfxontag( level._effect["cloud_vtol_wing_wispy"], var_6, "TAG_BODY" );
    var_9 = maps\_utility::make_array( level.intro_arms, var_6, var_8 );
    var_9 = common_scripts\utility::array_combine( var_9, var_1 );
    var_10 = common_scripts\utility::getstruct( "intro_struct", "targetname" );
    var_7 _meth_804D( var_6, "TAG_FUEL_ROD" );
    level.player _meth_807F( level.intro_arms, "tag_player" );
    level.player _meth_831D();
    level.player _meth_8119( 0 );
    level.player _meth_831F();
    level.player _meth_8321();
    thread setup_generic_allies();
    thread refuel_vo();
    thread refuel_timings();
    var_6 thread maps\_anim::anim_single_solo( var_7, "intro", "TAG_FUEL_ROD" );
    var_10 maps\_anim::anim_single( var_9, "intro" );
    level.player _meth_804F();
    common_scripts\utility::array_call( var_9, ::delete );
    common_scripts\utility::flag_set( "intro_scene_done" );
}

refuel_timings()
{
    wait 8.55;
    common_scripts\utility::flag_set( "fuel_contact" );
    wait 14.0;
    common_scripts\utility::flag_set( "fuel_complete" );
}

refuel_vo()
{
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_atc_clearedastern" );
    wait 0.5;
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_rp_clearedcontact" );
    common_scripts\utility::flag_wait( "fuel_contact" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_rp_takinggas" );
    common_scripts\utility::flag_wait( "fuel_complete" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_atc_offloadcomp" );
    wait 0.5;
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_thanksforgas" );
}

unlimit_player_view( var_0 )
{
    level.player _meth_807D( level.intro_arms, "tag_player", 0.9, 70, 70, 20, 20, 1 );
}

limit_player_view( var_0 )
{
    level.player _meth_8080( level.intro_arms, "tag_player", 0.5 );
}

setup_generic_allies()
{
    var_0 = common_scripts\utility::getstructarray( "generic_allies_struct", "targetname" );
    var_1 = common_scripts\utility::getstructarray( "generic_allies_no_tanker_struct", "targetname" );
    var_2 = common_scripts\utility::getstructarray( "generic_allies_squad2", "targetname" );
    var_3 = common_scripts\utility::getstructarray( "generic_allies_squad3", "targetname" );
    var_0 = maps\df_fly_flight_code::array_combine_all( var_0, var_1, var_2, var_3 );
    var_4 = [];

    foreach ( var_6 in var_0 )
    {
        var_7 = "";

        switch ( var_6.targetname )
        {
            case "generic_allies_squad2":
                var_7 = "_s2";
                break;
            case "generic_allies_squad3":
                var_7 = "_s3";
                break;
        }

        var_8 = maps\_utility::spawn_anim_model( "ally1" + var_7 + "_generic" );
        var_9 = maps\_utility::spawn_anim_model( "ally2" + var_7 + "_generic" );
        var_10 = maps\_utility::spawn_anim_model( "ally3" + var_7 + "_generic" );
        var_11 = maps\_utility::spawn_anim_model( "ally4" + var_7 + "_generic" );
        var_12 = maps\_utility::make_array( var_8, var_9, var_10, var_11 );

        if ( var_6.targetname == "generic_allies_struct" )
        {
            var_13 = maps\_utility::spawn_anim_model( "refueler_generic" );
            var_12 = common_scripts\utility::array_add( var_12, var_13 );
        }

        var_4[var_4.size] = var_12;
        var_6 thread maps\_anim::anim_loop( var_12, "intro_idle", "exit" );
        var_14 = randomfloat( 1 );
        waitframe();

        foreach ( var_16 in var_12 )
            var_16 _meth_8117( level.scr_anim[var_16.animname]["intro_idle"][0], var_14 );
    }

    wait 10;

    for ( var_19 = 0; var_19 < var_4.size; var_19++ )
    {
        var_20 = var_4[var_19];
        var_6 = var_0[var_19];
        var_6 thread generic_squadron_deploy( var_20 );
        wait(randomfloatrange( 0.8, 1.5 ));
    }
}

generic_squadron_deploy( var_0 )
{
    foreach ( var_2 in var_0 )
        var_2 notify( "exit" );

    common_scripts\utility::array_thread( var_0, ::fly_away_be_free, self );
}

fly_away_be_free( var_0 )
{
    var_0 maps\_anim::anim_single_solo( self, "intro_exit" );
    self delete();
}

playfakecontrail()
{
    playfxontag( level._effect["cloud_wing_wispy"], self, "tag_origin" );
}
