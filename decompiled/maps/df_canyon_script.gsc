// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_canyon()
{
    maps\df_fly::setup_common();
    common_scripts\utility::flag_set( "intro_finished" );
    level.player thread maps\_hud_util::fade_out( 0.1, "white" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_start" );
    soundscripts\_snd::snd_message( "snd_start_canyon" );
    thread maps\df_fly::handle_gun_hint();
}

setup_canyon_old_controls()
{
    level.old_controls = 1;
    setup_canyon();
}

setup_canyon2_old_controls()
{
    level.old_controls = 1;
    setup_canyon2();
}

setup_canyon_dam_old_controls()
{
    level.old_controls = 1;
    setup_canyon_dam();
}

setup_canyon3_old_controls()
{
    level.old_controls = 1;
    setup_canyon3();
}

setup_canyon2()
{
    maps\df_fly::setup_common();
    common_scripts\utility::flag_set( "intro_finished" );
    thread maps\df_fly_flight_code::process_flight_path( "canyon_run_start2_path" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_start2" );
    common_canyon_funcs( "canyon_ally_start2" );
    soundscripts\_snd::snd_message( "snd_start_canyon2" );
}

setup_canyon_dam()
{
    maps\df_fly::setup_common();
    common_scripts\utility::flag_set( "intro_finished" );
    thread maps\df_fly_flight_code::process_flight_path( "pre_dam_path" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_start_dam" );
    common_canyon_funcs( "canyon_ally_start_dam" );
    common_scripts\utility::flag_set( "turrets2" );
    thread maps\df_fly_code::handle_turrets( "enemy_turret_dam", "turrets2", "enemies6" );
    soundscripts\_snd::snd_message( "snd_start_canyon_dam" );
}

setup_canyon3()
{
    maps\df_fly::setup_common();
    common_scripts\utility::flag_set( "intro_finished" );
    thread maps\df_fly_flight_code::process_flight_path( "canyon_run_start3_path" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_start3" );
    common_canyon_funcs( "canyon_ally_start3" );
    common_scripts\utility::flag_set( "dam_cracks1" );
    level.allies[2] thread redshirt_death_vo();
    soundscripts\_snd::snd_message( "snd_start_canyon3" );
}

setup_canyon_exit()
{
    maps\df_fly::setup_common();
    common_scripts\utility::flag_set( "intro_finished" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_exit" );
    soundscripts\_snd::snd_message( "snd_start_canyon_exit" );
}

spawn_allies( var_0 )
{
    level.ally_ai_active = 1;
    var_1 = [ 1, 2, 3 ];
    level.allies = [];
    var_2 = getentarray( var_0, "targetname" );

    foreach ( var_4 in var_2 )
    {
        var_5 = var_4 maps\df_fly_flight_code::make_ally_jet( level.plane );

        switch ( var_4.script_noteworthy )
        {
            case "canyon_ally1":
                var_1[0] = var_5;
                break;
            case "canyon_ally2":
                var_1[1] = var_5;
                break;
            case "canyon_ally3":
                var_1[2] = var_5;
                break;
        }
    }

    level.allies = var_1;
    return var_1;
}

common_canyon_funcs( var_0 )
{
    level.base_agl = 0;
    spawn_allies( var_0 );

    if ( !isdefined( level.enemy_units ) )
        level.enemy_units = [];

    thread stay_low_nags();
    thread ambient_combat_vo();
    thread maps\df_fly_code::setup_destructibles();
    soundscripts\_snd::snd_music_message( "df_fly_jet_combat" );
    thread maps\df_fly::handle_gun_hint();
    thread bump_nag_vo();
}

hide_mountains( var_0 )
{
    var_1 = getentarray( "intro_mountain", "targetname" );

    if ( maps\df_fly_flight_code::is_true( var_0 ) )
        common_scripts\utility::array_call( var_1, ::show );
    else
        common_scripts\utility::array_call( var_1, ::hide );
}

begin_canyon()
{
    thread maps\df_fly_flight_code::process_flight_path( "canyon_run_start_path" );
    var_0 = maps\_utility::obj( "reach_obj" );
    objective_add( var_0, "current", &"PLAYERPLANE_REACH_NEW_BAGHDAD" );
    level.enemy_units = [];
    level.base_agl = 0;
    common_scripts\utility::flag_clear( "target_player" );
    wait 0.1;
    thread maps\df_fly_flight_code::steering_hack();
    var_1 = getent( "canyon_run_start", "targetname" );
    level.plane vehicle_teleport( var_1.origin, var_1.angles, 1 );
    spawn_allies( "canyon_ally" );
    level.player thread maps\df_fly::wait_for_stick_press();
    var_2 = 0;
    var_3 = getentarray( "canyon_ally_redshirt", "targetname" );
    common_scripts\utility::array_thread( var_3, maps\df_fly_flight_code::make_ally_jet, level.plane, 0 );
    thread tanker_crash();
    wait 0.5;
    level.player maps\_hud_util::fade_in( 1, "white" );
    maps\_utility::autosave_by_name( "canyon_start" );
    thread stay_low_nags();
    thread canyon_ally_vo();
    thread left_canyon1();
    thread maps\df_fly_code::handle_turrets( "enemy_turret0", "intro_finished", "canyon_enemy2a" );
    thread maps\df_fly_code::handle_turrets( "canyon_turrets0", "ally_fire1", "canyon_enemy3_warning" );
    thread maps\df_fly_code::setup_destructibles();
    thread handle_flak( "flak_origin00", "start_flak00" );
    thread amb_sky_combat_setup();
    common_scripts\utility::flag_set( "trig_amb_enemywave_starters" );
    soundscripts\_snd::snd_message( "snd_start_canyon" );
    level.player thread maps\_utility::hintdisplayhandler( "climb_hint", 5 );
    level.next_obj_pos = 0;
    var_4 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy_tut", "targetname" );
    thread ambient_combat_vo( "control_check" );
    thread handle_missile_hint();
    thread bump_nag_vo();
    var_5 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy1", "targetname" );
    thread invert_controls_prompt();
    thread maps\df_fly_code::fake_missile_from_behind_player( "fake_missiles1", "fake_missile_target1", undefined, undefined, 3 );
    common_scripts\utility::flag_wait( "enemy_ambush" );
    thread maps\df_fly_code::handle_missile_jet( "explode_wall_hoodoo_jet", "missile_jet_exploding_hoodoo", "explode_wall_hoodoo" );
    waitframe();
    var_6 = maps\_utility::remove_dead_from_array( var_5 );
    var_7 = maps\df_fly_flight_code::get_jet_array( "canyon_ally3" );
    common_scripts\utility::array_thread( var_7, ::redshirt_death_vo );

    if ( var_6.size > 0 )
    {
        level.player thread maps\df_fly_code::radio_dialog_add_and_go( "df_mag_ambush" );
        thread ambush_ambushed_vo( var_7, var_6 );
        wait 1;
        thread maps\df_fly_flight_code::engage_enemies( var_6, var_7, 0.5, 3, 1 );

        if ( var_6.size > 0 )
            level.player thread maps\df_fly_code::radio_dialog_add_and_go( "df_mag_painted" );
    }

    common_scripts\utility::flag_wait( "speed_boost1" );
    thread handle_flak( "flak_origin0", "start_flak0" );
    common_scripts\utility::flag_wait( "enemies1b" );
    maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy1b", "targetname" );
    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    var_6 = maps\_utility::remove_dead_from_array( var_6 );
    var_8 = var_6;
    common_scripts\utility::array_thread( var_6, maps\df_fly_flight_code::set_optimal_flight_dist, 5000 );
    var_9 = 0;

    foreach ( var_11 in var_6 )
    {
        var_11.has_flares = 4;
        var_11 maps\df_fly_flight_code::change_optimal_flight_distance( var_9 );
        var_9 += 1000;
    }

    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
    common_scripts\utility::array_thread( var_6, ::player_catch_up_on_boost, 1500, 1, 7000 );
    common_scripts\utility::array_thread( var_6, ::player_catch_up_on_boost, 1500, 0, 5000 );
    common_scripts\utility::flag_wait( "brake_hint" );
    show_brake_hint();
    common_scripts\utility::flag_wait( "canyon_enemy2a" );
    thread maps\_utility::autosave_by_name( "first corner" );
    common_scripts\utility::flag_clear( "target_player" );
    var_6 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy2a" );

    foreach ( var_11 in var_6 )
        var_11.has_flares = 2;

    common_scripts\utility::flag_wait( "target_player" );
    thread flare_warning();
    common_scripts\utility::flag_set( "target_player" );
    common_scripts\utility::flag_wait( "ally_fire1" );
    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    var_8 = maps\_utility::remove_dead_from_array( var_8 );

    if ( var_8.size > 0 )
    {
        foreach ( var_11 in var_8 )
            var_11.has_flares = 0;

        thread maps\df_fly_flight_code::engage_enemies( level.allies, var_8, 2, 3, 1, 2 );
    }

    level common_scripts\utility::waittill_any( "autosave", "pop_flares" );
    var_6 = maps\_utility::remove_dead_from_array( var_6 );
    thread maps\df_fly_flight_code::engage_enemies( var_6, level.allies, 0.25, 2, 2, 1 );
    common_scripts\utility::flag_wait( "autosave" );
    maps\_utility::autosave_by_name( "first_corner_done" );
    maps\_utility::delaythread( 3, common_scripts\utility::flag_clear, "autosave" );
    level.enemies = var_6;
}

show_brake_hint()
{
    if ( level.player usinggamepad() )
        level.player thread maps\_utility::display_hint_timeout( "airbrake_hint", 5 );
    else if ( maps\_utility::is_command_bound( "toggleprone" ) )
        level.player thread maps\_utility::display_hint_timeout( "airbrake_hint_pc_toggle", 5 );
    else if ( maps\_utility::is_command_bound( "+prone" ) )
        level.player thread maps\_utility::display_hint_timeout( "airbrake_hint_pc_hold", 5 );
}

handle_dying_player_brake_hint()
{
    setdvarifuninitialized( "df_fly_deaths", 0 );
    setdvar( "df_fly_deaths", 0 );
    var_0 = 0;
    thread watch_for_deaths();

    for (;;)
    {
        wait 2;
        var_1 = getdvarint( "df_fly_deaths" );

        if ( var_0 != var_1 )
        {
            var_0 = var_1;

            if ( var_1 >= 5 )
            {
                thread show_brake_hint();
                var_1 = 0;
                setdvar( "df_fly_deaths", var_1 );
            }
        }
    }
}

watch_for_deaths()
{
    for (;;)
    {
        level maps\_utility::add_wait( common_scripts\utility::flag_wait, "missionfailed" );
        level.player maps\_utility::add_wait( maps\_utility::waittill_msg, "death" );
        maps\_utility::do_wait_any();
        var_0 = getdvarint( "df_fly_deaths" );
        var_0++;
        setdvar( "df_fly_deaths", var_0 );
        wait 1;
    }
}

handle_missile_hint()
{
    common_scripts\utility::flag_wait( "player_steered" );
    level.player maps\_utility::display_hint_timeout( "missile_hint", 5 );
}

invert_controls_prompt()
{
    common_scripts\utility::flag_wait( "hint_time" );
    wait 0.05;
    level.player luiopenmenu( &"flight_controls_setting_popmenu" );
    wait 0.5;
    maps\_utility::autosave_now( 1 );
}

tanker_crash()
{
    var_0 = getent( "crashing_tanker", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "refueler" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    waitframe();
    var_1 maps\_utility::ent_flag_clear( "engineeffects" );
    wait 0.25;
    var_1 notify( "stop_engineeffects" );
    common_scripts\utility::flag_wait( "tanker_impact" );
    playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), var_2.origin, anglestoforward( var_2.angles ) * -1 );
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_dust_trail" ), var_2, "TAG_ORIGIN" );
    wait 7;
    playfx( common_scripts\utility::getfx( "bagh_dam_explosion" ), var_2.origin );
    stopfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    stopfxontag( common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" ), var_2, "TAG_ORIGIN" );
    var_1 waittill( "death" );
    var_2 unlink();
    var_2 delete();
}

player_catch_up_on_boost( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( !level.player_boosting )
        level waittill( "player_boost_start" );

    maps\df_fly_flight_code::set_optimal_flight_dist( var_0 );

    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_2 ) )
        {
            while ( isalive( self ) && distance( level.player.origin, self.origin ) > var_2 )
                wait 0.1;
        }

        if ( isdefined( self ) )
            self.has_flares = var_1;
    }
}

left_canyon1()
{
    var_0 = [];
    common_scripts\utility::flag_wait( "enemy_ambush" );
    var_1 = maps\df_fly_flight_code::get_jet_array( "canyon_enemy1_left", "script_noteworthy" );
    var_2 = maps\df_fly_flight_code::get_jet_array( "canyon_enemy1_right", "script_noteworthy" );

    if ( common_scripts\utility::flag( "left_canyon1" ) && var_1.size > 1 )
        var_0 = var_2;

    if ( !common_scripts\utility::flag( "left_canyon1" ) && var_2.size > 1 )
        var_0 = var_1;

    foreach ( var_4 in var_0 )
        var_4 delete();
}

begin_canyon2()
{
    hide_mountains();
    thread canyon_ally_vo2();
    thread flak_scenario1();
    thread maps\df_fly_code::handle_turrets( "enemy_turret_b", "the_peak", "allies_split_vo" );
    common_scripts\utility::flag_wait( "canyon_enemy3_warning" );
    common_scripts\utility::flag_clear( "target_player" );
    thread maps\df_fly_code::handle_turrets( "enemy_turret", "canyon_enemy3_warning", "allies_split_vo" );

    if ( !isdefined( level.enemies ) )
        level.enemies = [];

    var_0 = level.enemies;
    var_0 = common_scripts\utility::array_combine( var_0, maps\df_fly_flight_code::get_jet_array( "canyon_enemy2", "script_noteworthy" ) );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    thread maps\df_fly_flight_code::engage_enemies( level.allies, var_0, 1, 1, 2, 1 );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
    common_scripts\utility::flag_wait( "canyon_enemy4" );
    var_1 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy4" );
    common_scripts\utility::array_thread( var_0, ::player_catch_up_on_boost, 5000, 1, 7000 );
    common_scripts\utility::flag_wait( "allies_drop_back" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
    common_scripts\utility::flag_wait( "autosave" );
    maps\_utility::autosave_by_name( "second_corner" );
    maps\_utility::delaythread( 3, common_scripts\utility::flag_clear, "autosave" );
    thread maps\df_fly_code::handle_missile_jet( "hoodoo_w1_missile", "missile_jet_hoodoo_w1", "hoodoo_w1" );
    common_scripts\utility::flag_wait( "enemies_drop_back" );
    level.enemy_units = maps\_utility::remove_dead_from_array( level.enemy_units );
    common_scripts\utility::flag_wait( "split_reinforcements" );
    var_2 = maps\_utility::make_array( "rs1", "rs2", "ls1", "ls2" );

    foreach ( var_4 in var_2 )
    {
        if ( common_scripts\utility::flag( var_4 ) )
            maps\df_fly_flight_code::spawn_enemy_jets( var_4 );
    }

    thread white_hoodoos();
    var_6 = [];

    foreach ( var_8 in level.enemy_units )
    {
        if ( !maps\df_fly_flight_code::is_true( var_8.ground_target ) )
            var_6[var_6.size] = var_8;
    }

    level.enemy_units = var_6;
    var_10 = 2000;

    foreach ( var_12 in level.enemy_units )
    {
        var_12 maps\df_fly_flight_code::set_optimal_flight_dist( var_10 );
        var_10 += 1000;
    }

    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    thread maps\df_fly_code::adjust_bounce_lookahead( 0.25, "tighten_up", "loosen_up" );
    common_scripts\utility::flag_wait_any( "canyon_left2", "canyon_right2" );
    maps\_utility::delaythread( 0.5, maps\df_fly_code::handle_missile_jet, "canyon_right2", "missile_jet_arch_r", "arch_r", 1 );
    maps\_utility::delaythread( 0.5, maps\df_fly_code::fake_missile_from_behind_player, "canyon_left2", "left_arch_missile_targ", "arch_l", "left_arch_missile_start" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "canyon_left2", "left_arch_missile_targ", "arch_l", "left_arch_missile_start" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "canyon_left2", "left_hoodoo_missile_targ", "hoodoo_w2", "left_arch_missile_start" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "hoodoo_w5_missile", "left_hoodoo_missile_targ3", "hoodoo_w5", "left_hoodoo_missile_source3" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "hoodoo_w3_missile", "right_hoodoo_missile_targ3", "hoodoo_w3", "right_hoodoo_missile_source3" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "shoot_hoodoo_w4", "hoodoo_w4_targ", "hoodoo_w4", "hoodoo_w4_start" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );

    if ( common_scripts\utility::flag( "canyon_left2" ) )
    {
        var_14 = maps\df_fly_flight_code::get_jet_array( "righty2", "script_noteworthy" );
        thread maps\df_fly_flight_code::process_flight_path( "left_canyon_path" );
    }
    else
    {
        var_14 = maps\df_fly_flight_code::get_jet_array( "lefty2", "script_noteworthy" );
        thread maps\df_fly_flight_code::process_flight_path( "right_canyon_path" );
    }

    foreach ( var_12 in var_14 )
        var_12 delete();

    level.enemy_units = maps\_utility::remove_dead_from_array( level.enemy_units );

    if ( level.enemy_units.size < 2 )
    {
        if ( common_scripts\utility::flag( "canyon_left2" ) )
            var_17 = "lefty3";
        else
            var_17 = "righty3";

        maps\df_fly_flight_code::spawn_enemy_jets( var_17 );
    }

    common_scripts\utility::flag_wait( "turrets2" );
    level.enemy_units = maps\_utility::remove_dead_from_array( level.enemy_units );
    common_scripts\utility::array_thread( level.enemy_units, maps\df_fly_flight_code::set_optimal_flight_dist, 3000 );
    thread maps\df_fly_code::handle_turrets( "enemy_turret_dam", "turrets2", "enemies6" );
    thread maps\df_fly_code::handle_turrets( "enemy_turret2", "turrets2", "start_dam_run" );
    level.enemy_units = maps\_utility::remove_dead_from_array( level.enemy_units );
    var_18 = level.enemy_units;
    common_scripts\utility::flag_wait( "canyon_merge1" );
    var_18 = maps\_utility::remove_dead_from_array( var_18 );

    if ( var_18.size > 0 )
        thread maps\df_fly_flight_code::engage_enemies( level.allies, var_18, 0.5, 2, 1, 2 );
}

begin_canyon_dam()
{
    maps\_utility::autosave_by_name( "dam_area" );
    var_0 = getentarray( "terrain_shadow_fix", "targetname" );
    common_scripts\utility::array_call( var_0, ::hide );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, 2000 );
    thread maps\df_fly_code::handle_turrets( "enemy_turret3", "allies_fire_dam_missile", "narrows_flyby" );
    thread dam_enemies();
    thread dam_objective();
    thread canyon_ally_vo_dam();
    var_1 = gettime();
    var_2 = var_1 + 1000;
    common_scripts\utility::array_thread( level.allies, ::switch_path, "switch_paths" );

    for ( var_3 = 0; var_3 < level.friend_jets.size; var_3++ )
        level.friend_jets[var_3].script_noteworthy = common_scripts\utility::tostring( var_3 + 1 );

    common_scripts\utility::array_thread( level.friend_jets, ::switch_path, "switch_paths" );
    common_scripts\utility::flag_wait_any( "ally_tailer_dead", "enemies6" );
    common_scripts\utility::flag_wait( "start_dam" );
    maps\_utility::autosave_by_name( "dam_start" );
    common_scripts\utility::flag_wait( "dam_cracks1" );
}

dam_objective()
{
    common_scripts\utility::flag_wait( "start_dam_run" );
    level.dam_targ = getent( "dam_target", "script_noteworthy" );
    thread handle_dam_targets();
    var_0 = getent( "allly_dam_trigger", "targetname" );
    common_scripts\utility::array_thread( level.allies, ::ally_fire_on_dam, var_0 );
    wait 0.5;
    thread maps\df_fly_fx::vfx_dam_setup();
    common_scripts\utility::flag_wait( "dam_cracks1" );
    wait 0.75;
    common_scripts\utility::flag_set( "dam_cracks2" );
}

ally_fire_on_dam( var_0 )
{
    var_1 = level.player;

    while ( var_1 != self )
        var_0 waittill( "trigger", var_1 );

    if ( isalive( level.dam_targ ) )
        thread maps\df_fly_flight_code::ai_shoot_missile_salvo( level.dam_targ, 1 );
}

handle_dam_targets()
{
    if ( !isdefined( level.enemy_units ) )
        level.enemy_units = [];

    level.dam_targ setcandamage( 1 );
    level.dam_targ setcanradiusdamage( 1 );
    level.dam_targ.default_hud = "hud_fofbox_hostile_obstructed";
    level.dam_targ.health = 100;
    level.dam_targ.ground_target = 1;
    level.enemy_units[level.enemy_units.size] = level.dam_targ;
    level.dam_targ thread maps\df_fly_flight_code::hud_target_think();
    level.dam_targ thread dam_target_death();
    common_scripts\utility::flag_wait( "dam_destroyed" );

    if ( isdefined( level.dam_targ ) )
    {
        level.enemy_units = common_scripts\utility::array_remove( level.enemy_units, level.dam_targ );
        level.dam_targ delete();
    }
}

dam_target_death()
{
    var_0 = self.origin;
    self waittill( "death" );

    if ( !maps\df_fly_flight_code::is_true( level.dam_destroyed ) )
    {
        level.dam_destroyed = 1;
        common_scripts\_exploder::exploder( 10 );
        soundscripts\_snd::snd_message( "dam_explode" );
    }

    if ( isdefined( self ) )
    {
        level.enemy_units = common_scripts\utility::array_remove( level.enemy_units, self );
        self delete();
    }

    wait 1;
    common_scripts\utility::flag_set( "dam_destroyed" );
}

dam_enemies()
{
    common_scripts\utility::flag_wait( "dam_cracks1" );
    common_scripts\utility::flag_set( "dam_destroyed" );
    maps\_utility::autosave_by_name( "dam_enemies" );
    var_0 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy5b" );
}

begin_canyon3()
{
    while ( !isdefined( level.allies ) || !isdefined( level.allies[1] ) )
        waitframe();

    level.allies[0].has_flares = 9999;
    level.allies[1].has_flares = 9999;

    if ( isdefined( level.allies[2] ) && isalive( level.allies[2] ) )
        level.allies[2].has_flares = 2;

    maps\_utility::autosave_by_name( "canyon3" );
    thread canyon_ally_vo3();
    common_scripts\utility::flag_wait( "dam_cracks1" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
    common_scripts\utility::flag_wait( "enemies6" );
    common_scripts\utility::flag_set( "target_player" );
    thread maps\df_fly_flight_code::process_flight_path( "canyon_run_start3_path" );
    maps\_utility::stop_exploder( 10 );
    thread handle_train_bridge();
    var_0 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy6", "targetname", 1 );
    thread monitor_airbrake( var_0 );
    thread maps\df_fly_flight_code::engage_enemies( var_0, level.allies, 1, 3, 1, 1 );
    wait 2;
    common_scripts\utility::flag_set( "airbrake_hint" );
    common_scripts\utility::flag_wait_any( "narrows_flyby", "player_braking" );

    foreach ( var_2 in var_0 )
        var_2 notify( "stop_engaging" );

    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    common_scripts\utility::flag_set( "player_braking" );
    wait 2;
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    common_scripts\utility::array_thread( var_0, maps\_vehicle::godoff );
    common_scripts\utility::flag_wait( "enemies7" );
    maps\_utility::autosave_by_name( "through_narrows" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    thread maps\df_fly_flight_code::engage_enemies( level.allies, var_0, 1, 1, 2, 1 );
    common_scripts\utility::flag_clear( "target_player" );
    var_0 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy7" );

    foreach ( var_2 in var_0 )
        var_2.has_flares = 5;

    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    thread maps\df_fly_code::adjust_bounce_lookahead( 0.25, "tighten_up2", "enemies9" );
    common_scripts\utility::flag_wait( "chicken_run" );
    common_scripts\utility::flag_set( "target_player" );
    common_scripts\utility::array_thread( var_0, ::pop_flares_when_fired_on );
    common_scripts\utility::array_thread( var_0, ::fire_on_allies, "enemy_chicken_fire" );
    thread maps\df_fly_flight_code::engage_enemies( level.allies, var_0, 1, 3, 1, 1 );
    thread maps\df_fly_code::handle_missile_jet( "enemies8", "missile_jet8", "hoodoo1", 1, 1 );
    thread red_hoodoos();
    common_scripts\utility::flag_wait( "enemies8" );
    thread maps\df_fly_code::handle_turrets( "enemy_turret4", "5miles", "canyon_finished" );
    thread maps\df_fly_code::fake_missile_from_behind_player( "red_hoodoo_missile1", "hoodoo_missile_target1", "red_hoodoo1" );
    thread domino_hoodoos();
    maps\_utility::autosave_by_name( "past_chicken" );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
    var_0 = maps\df_fly_flight_code::spawn_enemy_jets( "canyon_enemy8" );

    foreach ( var_2 in var_0 )
        var_2.has_flares = 5;

    common_scripts\utility::flag_wait( "enemies9" );
    maps\_utility::autosave_by_name( "near_end" );
    var_8 = maps\_utility::remove_dead_from_array( level.enemy_units );

    foreach ( var_2 in var_8 )
        var_2.has_flares = 0;

    thread maps\df_fly_flight_code::engage_enemies( level.allies, var_8, 0.5, 2, 1, 1 );
    thread maps\df_fly_code::handle_turrets( "enemy_turret4b", "enemies9", "canyon_finished" );
    common_scripts\utility::flag_wait( "clean_up_enemies" );
    var_8 = maps\_utility::remove_dead_from_array( level.enemy_units );
    thread maps\df_fly_flight_code::engage_enemies( level.allies, var_8, 0.5, 2, 1, 1 );
}

domino_hoodoos()
{
    thread maps\df_fly_code::handle_missile_jet( "red_hoodoo_missile3", "red_hoodoo_domino_crasher", "red_hoodoo3", 1, 0 );
    common_scripts\utility::flag_wait( "red_hoodoo3" );
    wait 0.9;
    var_0 = getent( "domino_hoodoo_hit1", "targetname" );
    playfx( common_scripts\utility::getfx( "bagh_hoodoo_impact1_crack_large" ), var_0.origin, anglestoforward( var_0.angles ) );
    common_scripts\utility::flag_set( "red_hoodoo3b" );
    wait 1.3;
    var_0 = getent( "domino_hoodoo_hit2", "targetname" );
    playfx( common_scripts\utility::getfx( "bagh_hoodoo_domino_impact1" ), var_0.origin, anglestoforward( var_0.angles ) );
    common_scripts\utility::flag_set( "red_hoodoo3c" );
}

handle_train_bridge()
{
    thread maps\df_fly_code::handle_missile_jet( "train_missile", "train_missile_jet", "bridge_fall", 1 );
    var_0 = getentarray( "trainbridge", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = var_2.animation;
        var_2 useanimtree( level.scr_animtree[var_2.animation] );
    }

    common_scripts\utility::flag_wait( "bridge_fall" );
    soundscripts\_snd::snd_message( "bridge_fall" );
    common_scripts\_exploder::exploder( 20 );

    foreach ( var_2 in var_0 )
    {
        var_2 thread maps\_anim::anim_single_solo( var_2, "destroy" );
        var_2 setanimrate( var_2 maps\_utility::getanim( "destroy" ), 1.5 );
    }

    wait 0.5;
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_bridgeout3" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_heavydebris" );
    wait 1;
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_acp5" );
}

white_hoodoos()
{
    var_0 = [];

    for ( var_1 = 1; var_1 <= 5; var_1++ )
    {
        var_2 = "hoodoo_w" + var_1;
        var_0[var_0.size] = getent( var_2, "targetname" );
    }

    common_scripts\utility::array_thread( var_0, ::white_hoodoo_fx );
}

white_hoodoo_fx()
{
    self waittill( "fall_down" );
    var_0 = common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" );
    playfxontag( var_0, self, "Tag_fx_top" );
    playfxontag( var_0, self, "Tag_fx_mid" );
    self waittillmatch( "single anim", "end" );
    stopfxontag( var_0, self, "Tag_fx_top" );
    stopfxontag( var_0, self, "Tag_fx_mid" );
}

red_hoodoos()
{
    var_0 = getentarray( "crumble_hoodoo", "targetname" );
    var_1 = getentarray( "wall_hoodoo", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    common_scripts\utility::array_thread( var_0, ::crumble_hoodoo_fx );
    var_0 = getentarray( "red_hoodoo2", "targetname" );
    common_scripts\utility::array_thread( var_0, ::red_hoodoo_fx );
}

crumble_hoodoo_fx()
{
    self waittill( "fall_down" );
    var_0 = common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" );
    playfxontag( var_0, self, "tag_fx_1" );
    playfxontag( var_0, self, "tag_fx_2" );
    playfxontag( var_0, self, "tag_fx_4" );
    self waittillmatch( "single anim", "end" );
    stopfxontag( var_0, self, "tag_fx_1" );
    stopfxontag( var_0, self, "tag_fx_2" );
    stopfxontag( var_0, self, "tag_fx_4" );
}

red_hoodoo_fx()
{
    self waittill( "fall_down" );
    var_0 = common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" );
    playfxontag( var_0, self, "tag_fx_1" );
    playfxontag( var_0, self, "tag_fx_2" );
    self waittillmatch( "single anim", "end" );
    stopfxontag( var_0, self, "tag_fx_1" );
    stopfxontag( var_0, self, "tag_fx_2" );
}

red_hoodoo1()
{
    common_scripts\utility::flag_wait( "hoodoo1" );
    var_0 = getent( "hoodoo1", "targetname" );
    var_1 = common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" );
    playfxontag( var_1, var_0, "TAG_FX_TOP_1" );
    playfxontag( var_1, var_0, "TAG_FX_TOP_2" );
    playfxontag( var_1, var_0, "TAG_FX_TOP_3" );
    playfxontag( var_1, var_0, "TAG_FX_TOP_4" );
    wait 5;
    stopfxontag( var_1, var_0, "TAG_FX_TOP_1" );
    stopfxontag( var_1, var_0, "TAG_FX_TOP_2" );
    stopfxontag( var_1, var_0, "TAG_FX_TOP_3" );
    stopfxontag( var_1, var_0, "TAG_FX_TOP_4" );
}

pop_flares_when_fired_on()
{
    self endon( "death" );

    while ( isalive( self ) )
    {
        self waittill( "missile_fired_at" );
        wait(randomfloat( 0.5 ));
        playfx( common_scripts\utility::getfx( "missile_repel" ), self.origin );
    }
}

fire_on_allies( var_0 )
{
    self endon( "death" );
    var_1 = getent( var_0, "targetname" );
    var_2 = level.player;

    while ( var_2 != self )
        var_1 waittill( "trigger", var_2 );

    var_3 = randomint( level.allies.size );
    maps\df_fly_flight_code::engage_enemies( maps\_utility::make_array( self ), maps\_utility::make_array( level.allies[var_3] ), 0, 2, 1, 1 );
}

airbrake_hint()
{
    if ( level.player_airbraked )
        return 1;

    return 0;
}

monitor_airbrake( var_0 )
{
    thread trailing_jets_move_up_on_airbrake( var_0 );
    common_scripts\utility::flag_wait( "airbrake_hint" );
    level.player_airbraked = 0;
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_gid_yourtail" );
    level.player_airbraked = 1;
    common_scripts\utility::flag_set( "player_braking" );
    common_scripts\utility::flag_wait_or_timeout( "player_braking", 5 );

    if ( !common_scripts\utility::flag( "player_braking" ) )
        thread maps\df_fly_code::radio_dialog_add_and_go( "df_gid_airbrake" );
}

trailing_jets_move_up_on_airbrake( var_0 )
{
    common_scripts\utility::flag_wait( "player_braking" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    level.allies = maps\_utility::remove_dead_from_array( level.allies );
    common_scripts\utility::array_thread( var_0, maps\df_fly_flight_code::set_optimal_flight_dist, 2000 );
    common_scripts\utility::array_thread( level.allies, maps\df_fly_flight_code::set_optimal_flight_dist, -5000 );
}

switch_path( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    var_2 = level.player;

    while ( var_2 != self )
        var_1 waittill( "trigger", var_2 );

    var_3 = var_2.script_noteworthy[var_2.script_noteworthy.size - 1];
    var_4 = var_1.script_parameters + var_3;
    var_5 = getvehiclenode( var_4, "targetname" );
    var_2 thread maps\_vehicle::vehicle_paths( var_5 );
    var_2 startpath( var_5 );
}

flare_warning()
{
    level.player waittill( "enemy_lock_on" );
    maps\_utility::radio_dialogue_stop();
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_lockonyou" );
}

flares_hint()
{
    if ( level.player_popped_flares )
        return 1;

    return 0;
}

handle_flak( var_0, var_1 )
{
    common_scripts\utility::flag_wait( var_1 );
    var_2 = getentarray( var_0, "targetname" );
    common_scripts\utility::array_thread( var_2, ::flak_explode );
}

flak_scenario1()
{
    thread maps\df_fly_code::handle_flak_cannons( "flak_cannon", "the_peak", "allies_drop_back" );
    thread flak_nag_vo();
    common_scripts\utility::flag_wait( "canyon_enemy3_warning" );
    handle_flak( "flak_origin1", "canyon_enemy3_warning" );
    common_scripts\utility::flag_wait( "flak2" );
    var_0 = getentarray( "flak_origin2", "targetname" );
    common_scripts\utility::array_thread( var_0, ::flak_explode );
    common_scripts\utility::flag_wait( "flak3" );
    var_0 = getentarray( "flak_origin3", "targetname" );
    common_scripts\utility::array_thread( var_0, ::flak_explode );
    common_scripts\utility::flag_wait( "flak4" );
    var_0 = getentarray( "flak_origin4", "targetname" );
    common_scripts\utility::array_thread( var_0, ::flak_explode );
    common_scripts\utility::flag_wait( "flak5" );
    var_0 = getentarray( "flak_origin5", "targetname" );
    common_scripts\utility::array_thread( var_0, ::flak_explode );
}

flak_explode()
{
    if ( isdefined( self.script_parameters ) )
        wait(float( self.script_parameters ));

    wait(randomfloat( 0.2 ));
    playfx( common_scripts\utility::getfx( "flak_explosion" ), self.origin );
    self playsound( "flak_expl" );
    var_0 = vectornormalize( level.plane.origin - self.origin );

    if ( distancesquared( level.plane.origin, self.origin ) <= 6250000 )
    {
        level.player playsound( "plr_jet_hit_by_missile_lyr1" );

        if ( level.player_boosting )
        {
            level.plane notify( "damage", 100, undefined, var_0, level.plane.origin, "flak_pepper" );
            level.plane vehicle_teleport( level.plane.origin, level.plane.angles + ( 0, 0, 25 ) );
        }
        else
        {
            level.plane notify( "damage", 100, undefined, var_0, level.plane.origin, "flak_hit" );
            level.plane vehicle_teleport( level.plane.origin, level.plane.angles + ( 0, 0, 45 ) );
        }
    }
    else
    {
        var_1 = spawn( "trigger_radius", self.origin - ( 0, 0, 2500 ), 1, 2500, 5000 );
        var_1 thread flak_pepper_player( self.origin );
        var_1 common_scripts\utility::waittill_notify_or_timeout( "trigger", 2.0 );
        var_1 delete();
    }
}

flak_pepper_player( var_0 )
{
    self waittill( "trigger" );
    var_1 = vectornormalize( level.plane.origin - var_0 );
    level.plane notify( "damage", 100, undefined, var_1, var_0, "flak_pepper" );
}

flak_nag_vo()
{
    level endon( "finale" );
    var_0 = [];
    var_0[0] = "df_gid_watchflak";
    var_0[1] = "df_gid_chrewedup";
    var_0[2] = "df_gid_dropdown";
    var_1 = 0;

    for (;;)
    {
        level.plane waittill( "damage", var_2, var_3, var_4, var_5, var_6 );

        if ( var_6 == "flak_pepper" || var_6 == "flak_hit" )
        {
            maps\df_fly_code::radio_dialog_add_and_go( var_0[var_1] );
            wait 1;
            var_1++;

            if ( var_1 >= var_0.size )
                var_1 = 0;
        }
    }
}

bump_nag_vo()
{
    level endon( "finale" );
    var_0 = [];
    var_0[0] = "df_gid_watchwings";
    var_0[1] = "df_nox_tooclose1";
    var_0[2] = "df_gid_headsup11";
    var_0[3] = "df_gid_steerclear";
    var_0[4] = "df_nox_damn4";
    var_1 = 0;

    for (;;)
    {
        level.plane waittill( "plane_bump" );
        maps\df_fly_code::radio_dialog_add_and_go( var_0[var_1] );
        wait 5;
        var_1++;

        if ( var_1 >= var_0.size )
            var_1 = 0;
    }
}

begin_canyon_intro()
{
    thread maps\df_fly::intro_movie();
    common_scripts\utility::flag_wait( "intro_screen_done" );
    common_scripts\utility::flag_wait( "intro_screen_done" );
    level.player freezecontrols( 0 );
    common_scripts\utility::flag_set( "intro_finished" );
    maps\df_fly_flight_code::flight_code_start( "canyon_run_start" );
    thread maps\df_fly::handle_gun_hint();
}

canyon_intro_vo()
{
    soundscripts\_snd::snd_music_message( "df_fly_intro" );
    soundscripts\_snd::snd_message( "fly_fade_in_intro" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_nought" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_kp_rogerthat10" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_kp_lowlevel10" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_kp_kingpinout" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_fencein10" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "df_gid_engageanything" );
    common_scripts\utility::flag_set( "intro_vo_done" );
}

canyon_ally_vo()
{
    common_scripts\utility::flag_set( "hint_time" );
    wait 0.5;
    level.player thread maps\df_fly_code::radio_dialog_add_and_go( "ds_gid_3bandits" );
    level.player thread maps\df_fly_code::radio_dialog_add_and_go( "ds_gid_12oclocklow3" );
    level.player maps\df_fly_code::radio_dialog_add_and_go( "ds_gid_timetobump" );
    common_scripts\utility::flag_wait( "speed_boost1" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_trancers" );
    common_scripts\utility::flag_wait( "canyon_enemy2" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_acp3" );
    common_scripts\utility::flag_wait( "canyon_enemy2a" );
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_nox_overridge" );
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_gid_tapem" );
    wait 1.5;
    common_scripts\utility::flag_set( "target_player" );
}

canyon_ally_vo2()
{
    common_scripts\utility::flag_wait( "canyon_enemy3_warning" );
    level.player thread maps\_utility::display_hint_timeout( "boost_hint", 5 );
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_nox_flakahead" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_useblower" );
    common_scripts\utility::flag_wait( "flak3" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_knox_phallanx" );
    common_scripts\utility::flag_wait( "canyon_enemy4" );
    wait 1;
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_nox_4birds" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_engage2" );
    common_scripts\utility::flag_wait( "acp4" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_acp4" );
    common_scripts\utility::flag_wait( "allies_split_vo" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_rightcanyon" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_takingleft1" );
    common_scripts\utility::flag_wait_any( "canyon_left2", "canyon_right2" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_watchyoursix" );
    wait 0.5;
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_nox_rockfall" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_watchdebris55" );
    common_scripts\utility::flag_wait( "close_call" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_watchhead2" );
}

canyon_ally_vo_dam()
{
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_approachingdam" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_hardpoints" );
    common_scripts\utility::flag_wait( "dam_destroyed" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_directhit" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_watchdebris" );
}

canyon_ally_vo3()
{
    common_scripts\utility::flag_wait( "enemies6" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_closingin" );
    common_scripts\utility::flag_wait( "enemies7" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_4bandits" );
    common_scripts\utility::flag_wait( "chicken_run" );
    common_scripts\utility::flag_wait( "enemies8" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_backaround" );
    wait 3;
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_getinclose" );
    common_scripts\utility::flag_wait( "5miles" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_5miles" );
    common_scripts\utility::flag_wait( "almost_done" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_stayfocused" );
}

ambush_ambushed_vo( var_0, var_1 )
{
    thread maps\df_fly_code::ai_array_killcount_flag_set( var_1, var_1.size, "ambush_dead" );
    common_scripts\utility::flag_wait( "ambush_dead" );
    var_0 = maps\_utility::remove_dead_from_array( var_0 );

    if ( var_0.size > 0 )
        maps\df_fly_code::radio_dialog_add_and_go( "df_mag_savedtail" );
}

redshirt_death_vo()
{
    level endon( "finale" );
    self waittill( "death" );
    maps\_utility::radio_dialogue_stop();
    thread maps\df_fly_code::radio_dialog_add_and_go( "df_mag_i'mhit" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_mag_aaaaah" );
}

begin_canyon_exit()
{
    setsaveddvar( "vehPlanePathAllowance", 20 );
    thread maps\df_fly_flight_code::process_flight_path( "canyon_end_close" );
    thread jet_shakes();
    common_scripts\utility::flag_wait( "canyon_finished" );
    soundscripts\_snd::snd_music_message( "df_fly_ending" );
    soundscripts\_snd::snd_message( "fly_ending_mix" );
    level notify( "finale" );
    level.plane notify( "finale" );
    thread deploy_sequence();
    common_scripts\utility::flag_wait( "black_out" );
    thread maps\_hud_util::fade_out( 0.5 );
    common_scripts\utility::flag_wait( "finale_vo_done" );
    maps\_utility::nextmission();
}

jet_shakes()
{
    maps\df_fly_flight_code::fighter_jet_set_shake( 3, 1.5 );
    wait 2;
    maps\df_fly_flight_code::fighter_jet_set_shake( 2, 1 );
}

ambient_combat_vo( var_0 )
{
    level endon( "death" );
    var_1 = 8;
    var_2 = [];
    var_2[0] = "df_gid_boola";
    var_2[1] = "df_nox_trgtdestroyed";
    var_2[2] = "df_gid_bravozulu";
    var_2[3] = "df_nox_gotone1";
    var_3 = [];
    var_3[0] = "df_gid_niceshot";
    var_3[1] = "df_gid_sierrahotel";
    var_3[2] = "df_nox_niceshootin";
    var_3[3] = "df_gid_goodshot";
    var_3[4] = "df_nox_goodone";
    var_3[5] = "df_gid_bravozulu";
    var_4 = [];
    var_4[0] = "df_gid_onedown";
    var_4[1] = "df_gid_thatstwo1";
    var_4[2] = "df_gid_thatsall";
    var_5 = [];
    var_5[0] = "df_gid_inmysights";
    var_5[1] = "df_nox_gotthisone";
    var_5[2] = "df_gid_onim";
    var_5[3] = "df_nox_thatonesmine";
    var_6 = "";
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;

    for (;;)
    {
        var_11 = level common_scripts\utility::waittill_any_return( "enemy_dead", "enemy_dead_by_player", "ally_targeting_enemy" );

        if ( isdefined( var_0 ) && !common_scripts\utility::flag( var_0 ) && var_10 < var_4.size )
        {
            var_6 = var_4[var_10];
            var_10++;
        }
        else if ( var_11 == "ally_targeting_enemy" )
        {
            var_6 = var_5[var_9];
            var_9++;

            if ( var_9 >= var_5.size )
                var_9 = 0;
        }
        else if ( var_11 == "enemy_dead_by_player" )
        {
            var_6 = var_3[var_8];
            var_8++;

            if ( var_8 >= var_3.size )
                var_8 = 0;
        }
        else
        {
            var_6 = var_2[var_7];
            var_7++;

            if ( var_7 >= var_2.size )
                var_7 = 0;
        }

        if ( maps\_utility::radio_dialogue_safe( var_6 ) && ( !isdefined( var_0 ) || !common_scripts\utility::flag( var_0 ) ) )
            wait(var_1);
    }
}

stay_low_nags()
{
    level endon( "death" );
    var_0 = [];
    var_0[0] = "df_gid_incanyon";
    var_0[1] = "df_gid_headdown";
    var_0[2] = "df_gid_staylow2";
    var_0[3] = "df_gid_2000agl";
    var_1 = 0;
    common_scripts\utility::flag_waitopen_or_timeout( "stay_low", 20 );

    for (;;)
    {
        common_scripts\utility::flag_wait( "stay_low" );
        maps\df_fly_code::radio_dialog_add_and_go( var_0[var_1] );
        var_1++;

        if ( var_1 > var_0.size )
            var_1 = 0;

        common_scripts\utility::flag_waitopen_or_timeout( "stay_low", 10 );
    }
}

canopy_fade_in_cinematic()
{
    cinematicingame( "df_canopy_transition" );

    while ( cinematicgetframe() < 2 )
        waitframe();

    pausecinematicingame( 1 );
}

deploy_sequence()
{
    var_0 = level.plane vehicle_getspeed();
    maps\df_fly_flight_code::fighter_jet_set_shake( 4, 0.25 );
    level.player notify( "toggle_chase_cam" );
    level notify( "end_canyon" );
    level.plane notify( "end_canyon" );
    level.player notify( "remove_jet_hud" );
    level.player notify( "end_canyon" );
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    thread canopy_fade_in_cinematic();
    luinotifyevent( &"plane_hud_fade_out", 1, 5000 );
    var_1 = maps\_utility::spawn_anim_model( "pod" );
    level.finale_pod = var_1;
    level.finale_pod hidepart( "TAG_TRANSFER_AR" );
    var_2 = maps\_utility::spawn_anim_model( "pod_l" );
    var_3 = maps\_utility::spawn_anim_model( "pod_r" );
    var_4 = maps\_utility::spawn_anim_model( "jet" );
    var_4 hide();
    level.finale_jet = var_4;
    var_5 = maps\_utility::spawn_anim_model( "jet_l" );
    var_6 = maps\_utility::spawn_anim_model( "jet_r" );
    var_7 = maps\_utility::spawn_anim_model( "player_rig" );
    var_8 = maps\_utility::spawn_anim_model( "finale_genProp" );
    level.fake_plane unlinkfromplayerview( level.player );
    var_1.origin = level.fake_plane.origin;
    var_1.angles = level.fake_plane.angles;
    var_1 thread maps\_anim::anim_loop_solo( var_1, "idle", "stop_loop" );
    level.plane maps\_utility::ent_flag_clear( "engineeffects" );
    var_9 = [ var_7, var_2, var_3, var_4, var_5, var_6 ];
    common_scripts\utility::array_call( var_9, ::hide );
    var_10 = common_scripts\utility::getstruct( "finale_struct", "targetname" );
    level.player dismountvehicle();
    level.player unlink();
    level.player disableweapons();
    level.player allowcrouch( 0 );
    level.player disableoffhandweapons();
    level.player disableweaponswitch();
    level.plane hide();

    if ( isdefined( level.allies ) )
    {
        foreach ( var_12 in level.allies )
        {
            if ( isdefined( var_12 ) )
                var_12 delete();
        }
    }

    thread deploy_vo();
    var_9 = common_scripts\utility::array_add( var_9, var_1 );
    var_10 maps\_anim::anim_first_frame_solo( var_8, "deploy" );
    level.player playerlinktoabsolute( var_1, "tag_player" );
    setsaveddvar( "sv_znear", "1" );
    var_14 = maps\_utility::make_array( var_1 );
    var_15 = spawn( "script_model", var_1.origin );
    var_15.angles = var_1.angles;
    var_15.origin = var_1.origin;
    var_1 linkto( var_15 );
    var_16 = var_8 maps\_anim::get_anim_position( "j_prop_1" );
    var_17 = var_16["origin"];
    var_18 = var_16["angles"];
    var_19 = getstartorigin( var_17, var_18, level.scr_anim[var_1.animname]["deploy"] );
    var_20 = getstartangles( var_17, var_18, level.scr_anim[var_1.animname]["deploy"] );
    var_21 = distance( var_19, var_15.origin ) / 12 / 5280;
    var_22 = var_21 / var_0 * 60 * 60;
    var_23 = vectortoangles( var_19 - var_15.origin );
    thread fake_cockpit_jitter( var_1, var_22 );
    var_15 moveto( var_19, var_22, 0, 0 );
    var_15 rotateto( var_23, var_22 / 4, var_22 / 16, var_22 / 4 - var_22 / 16 );
    var_1 dontinterpolate();
    var_8 dontinterpolate();
    var_10 maps\_anim::anim_first_frame_solo( var_8, "deploy" );
    var_8 maps\_anim::anim_first_frame( var_9, "deploy", "j_prop_1" );
    wait(var_22 / 2);
    var_15 rotateto( var_20, var_22 / 2, var_22 / 4, var_22 / 4 );
    wait(var_22 / 2);
    level.plane delete();

    foreach ( var_25 in var_9 )
    {
        var_25 linkto( var_8, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );

        if ( var_25 != level.finale_jet )
            var_25 show();
    }

    level.player playerlinktodelta( var_7, "tag_player", 0.9, 10, 10, 10, 10, 1 );
    var_27 = common_scripts\utility::getfx( "s19_engineeffect" );
    playfxontag( var_27, var_5, "tag_engine_left" );
    playfxontag( var_27, var_6, "tag_engine_left" );
    playfxontag( var_27, var_4, "tag_engine_left" );
    var_2 thread maps\df_fly_fx::pod_engine_fx( 1 );
    var_3 thread maps\df_fly_fx::pod_engine_fx( 1 );
    var_10 thread maps\_anim::anim_single_solo( var_8, "deploy" );
    var_1 notify( "stop_loop" );
    var_8 maps\_anim::anim_single( var_9, "deploy", "j_prop_1" );
    var_2 thread maps\df_fly_fx::pod_engine_fx( 0 );
    var_3 thread maps\df_fly_fx::pod_engine_fx( 0 );
}

fake_cockpit_jitter( var_0, var_1 )
{
    wait 0.1;
    var_1 -= 0.1;
    var_2 = 0;
    var_3 = gettime();

    for ( var_4 = var_3; var_2 < var_1; var_4 = var_6 )
    {
        var_5 = randomfloatrange( 0.05, 0.1 );
        level.player playerlinktodelta( var_0, "tag_player", 0.9, 10, 10, 10, 10, 1 );
        wait(var_5);
        var_6 = gettime();
        var_2 += ( var_6 - var_4 ) / 1000;
    }
}

deploy_vo()
{
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_finalapproach" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_so_flakperimeter" );
    wait 0.5;
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_dropsequence" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_nox_autopilot" );
    wait 2;
    maps\df_fly_code::radio_dialog_add_and_go( "df_gid_deploymentsuccessful" );
    maps\df_fly_code::radio_dialog_add_and_go( "df_so_offradar" );
    common_scripts\utility::flag_set( "black_out" );
    common_scripts\utility::flag_set( "finale_vo_done" );
}

do_fly_screen()
{
    var_0 = getent( "fly_screen_start", "targetname" );
    var_1 = getent( "fly_screen_mid", "targetname" );
    var_2 = getent( "fly_screen_end", "targetname" );
    level.player disableweapons();
    level.player freezecontrols( 1 );
    level.player maps\_utility::teleport_player( var_0 );
    waitframe();
    level.player maps\_utility::lerp_player_view_to_position( var_2.origin, level.player.angles, 18, 1, 0, 0, 0, 0 );
}

do_hoodoo_voodoo()
{
    var_0 = getentarray( "canyon_destructible", "script_noteworthy" );
    common_scripts\utility::array_thread( var_0, maps\df_fly_code::handle_canyon_destructible );

    foreach ( var_2 in var_0 )
        var_2 notify( "fall_down" );
}

deathspin()
{
    var_0 = maps\_utility::spawn_anim_model( "enemy_jet" );
    var_0 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self hide();
    var_0 maps\_anim::anim_single_solo( var_0, "deathspin" );
}

amb_sky_combat_setup()
{
    thread amb_sky_combat();
    thread sky_booms();
    thread mothership_fly();
    thread mothership_fly2();
    thread mothership_fly3();
    thread mothership_fly4();
    thread mothership_fly5();
    thread tanker_mountain_crash();
    thread tanker_mountain_crash2();
}

amb_sky_combat()
{
    thread jet_spawn_loop( "trig_amb_enemywave_starters", "trig_amb_enemywave0", "amb_jets_starters" );
    thread jet_spawn_loop( "trig_amb_enemywave0", "trig_amb_enemywave1", "amb_jets0" );
    thread jet_spawn_loop( "trig_amb_enemywave1", "trig_amb_enemywave2", "amb_jets1" );
    thread jet_spawn_loop( "trig_amb_enemywave2", "trig_amb_enemywave3", "amb_jets2" );
    thread jet_spawn_loop( "trig_amb_enemywave3", "trig_amb_enemywave4", "amb_jets3" );
    thread jet_spawn_loop( "trig_amb_enemywave4", "trig_amb_enemywave5", "amb_jets4" );
    thread jet_spawn_loop( "trig_amb_enemywave5", "trig_amb_enemywave6", "amb_jets5" );
    thread jet_spawn_loop( "trig_amb_enemywave6", "trig_amb_enemywave7", "amb_jets6" );
    thread jet_spawn_loop( "trig_amb_enemywave7", "trig_amb_enemywave8", "amb_jets7" );
    thread jet_spawn_loop( "trig_amb_enemywave8a", "trig_amb_enemywave9a", "amb_jets8a" );
    thread jet_spawn_loop( "trig_amb_enemywave8b", "trig_amb_enemywave9b", "amb_jets8b" );
    thread jet_spawn_loop( "trig_amb_enemywave9a", "trig_amb_enemywave10", "amb_jets9a" );
    thread jet_spawn_loop( "trig_amb_enemywave9b", "trig_amb_enemywave10", "amb_jets9b" );
    thread jet_spawn_loop( "trig_amb_enemywave10", "trig_amb_enemywave11", "amb_jets10" );
    thread jet_spawn_loop( "trig_amb_enemywave11", "trig_amb_enemywave12", "amb_jets11" );
    thread jet_spawn_loop( "trig_amb_enemywave12", "trig_amb_enemywave13", "amb_jets12" );
    thread jet_spawn_loop( "trig_amb_enemywave13", "trig_amb_enemywave14", "amb_jets13" );
    thread jet_spawn_loop( "trig_amb_enemywave14", "trig_amb_enemywave15", "amb_jets14" );
    thread jet_spawn_loop( "trig_amb_enemywave15", "trig_amb_enemywave16", "amb_jets15" );
    thread jet_spawn_loop( "trig_amb_enemywave16", "trig_amb_enemywave17", "amb_jets16" );
    thread jet_spawn_loop( "trig_amb_enemywave17", "trig_amb_enemywave18", "amb_jets17" );
}

sky_booms()
{

}

jet_spawn_loop( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_wait( var_0 );

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( var_2 );
        common_scripts\utility::array_thread( var_3, ::setup_jet_waits );

        while ( var_3.size > 0 )
        {
            wait 1.5;
            var_3 = maps\_utility::remove_dead_from_array( var_3 );
        }

        waitframe();
    }
}

setup_jet_waits()
{
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "jet_fire" )
        {
            thread jet_wait_start_firing();
            thread jet_wait_stop_firing();
        }
        else if ( self.script_noteworthy == "jet_missile" )
            thread jet_wait_fire_missile();
        else if ( self.script_noteworthy == "jet_boom" )
            thread jet_wait_boom();
    }
}

jet_wait_start_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "start_firing" );
    maps\_utility::ent_flag_wait( "start_firing" );
    maps\_utility::ent_flag_clear( "start_firing" );
    thread jet_fire_guns();
}

jet_wait_stop_firing()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "stop_firing" );
    maps\_utility::ent_flag_wait( "stop_firing" );
    maps\_utility::ent_flag_clear( "stop_firing" );
}

jet_wait_fire_missile()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "fire_missile" );
    maps\_utility::ent_flag_wait( "fire_missile" );
    thread jet_launch_missile();
}

jet_wait_boom()
{
    self endon( "death" );
    maps\_utility::ent_flag_init( "jet_explode" );
    maps\_utility::ent_flag_wait( "jet_explode" );
    thread jet_boom();
}

jet_fire_guns()
{
    self endon( "death" );
    self endon( "stop_firing" );
    self.firing_sound_ent = spawn( "script_origin", ( 0, 0, 0 ) );

    for (;;)
    {
        var_0 = anglestoforward( self.angles );
        var_1 = 1000;
        var_2 = self gettagorigin( "tag_flash" ) + var_0 * var_1;
        var_3 = var_2 + var_0 * 999999999;
        magicbullet( "s19_cannon_AI", var_2 + var_0, var_3 );
        wait 0.1;
    }
}

jet_launch_missile()
{
    var_0 = anglestoforward( self.angles );
    var_1 = maps\df_fly_flight_code::offset_position_from_tag( "forward", "tag_origin", 1000 );
    var_2 = magicbullet( "sidewinder_atlas_jet", var_1, var_0 );
}

jet_boom()
{
    var_0 = playfx( common_scripts\utility::getfx( "bagh_aircraft_explosion_midair" ), self.origin );
    self delete();
}

tanker_mountain_crash()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave5" );
    var_0 = getent( "crashing_tanker2", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "refueler" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    waitframe();
    var_1 maps\_utility::ent_flag_clear( "engineeffects" );
    wait 0.25;
    var_1 notify( "stop_engineeffects" );
    wait 6;
    playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), var_2.origin, anglestoforward( var_2.angles ) * -1 );
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_dust_trail" ), var_2, "TAG_ORIGIN" );
    wait 7;
    playfx( common_scripts\utility::getfx( "bagh_dam_explosion" ), var_2.origin );
    stopfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    stopfxontag( common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" ), var_2, "TAG_ORIGIN" );
    var_1 waittill( "death" );
    var_2 unlink();
    var_2 delete();
}

tanker_mountain_crash2()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave12" );
    var_0 = getent( "crashing_tanker3", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "refueler" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    waitframe();
    var_1 maps\_utility::ent_flag_clear( "engineeffects" );
    wait 0.25;
    var_1 notify( "stop_engineeffects" );
    wait 4;
    playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), var_2.origin, anglestoforward( var_2.angles ) * -1 );
    playfxontag( common_scripts\utility::getfx( "bagh_tanker_dust_trail" ), var_2, "TAG_ORIGIN" );
    wait 7;
    playfx( common_scripts\utility::getfx( "bagh_dam_explosion" ), var_2.origin );
    stopfxontag( common_scripts\utility::getfx( "bagh_tanker_crash" ), var_2, "TAG_ORIGIN" );
    stopfxontag( common_scripts\utility::getfx( "bagh_hoodoo_dust_trail" ), var_2, "TAG_ORIGIN" );
    var_1 waittill( "death" );
    var_2 unlink();
    var_2 delete();
}

mothership_fly()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave1" );
    var_0 = getent( "osp_fly", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "osp" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    var_1 waittill( "death" );
    var_2 unlink();
}

mothership_fly2()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave1" );
    var_0 = getent( "osp_fly2", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "osp" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    var_1 waittill( "death" );
    var_2 unlink();
}

mothership_fly3()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave1" );
    var_0 = getent( "osp_fly3", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "osp" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    var_1 waittill( "death" );
    var_2 unlink();
}

mothership_fly4()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave1" );
    var_0 = getent( "osp_fly4", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "osp" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    var_1 waittill( "death" );
    var_2 unlink();
}

mothership_fly5()
{
    common_scripts\utility::flag_wait( "trig_amb_enemywave11" );
    var_0 = getent( "osp_fly5", "targetname" );
    var_1 = var_0 thread maps\_vehicle::spawn_vehicle_and_gopath();
    var_2 = maps\_utility::spawn_anim_model( "osp" );
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2 linkto( var_1, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1 hide();
    var_1 waittill( "death" );
    var_2 unlink();
}
