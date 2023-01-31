// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_post_tower_pre_load()
{
    thread maps\df_baghdad_barracks_utility::handle_triggers_off( "barracks_approach_triggers" );
    thread _handle_triggers_on();
    thread post_tower_inits_precache();
    thread maps\df_baghdad_code::barracks_objectives();
    thread approach_spawn_functions();
}

_handle_triggers_on()
{
    common_scripts\utility::flag_wait( "snipers_finished" );
    thread maps\df_baghdad_barracks_utility::handle_triggers_on( "barracks_approach_triggers" );
}

setup_post_tower()
{
    maps\df_baghdad_code::setup_common();
    common_scripts\utility::flag_set( "snipers_finished" );
    common_scripts\utility::flag_set( "approach_atlas" );
    common_scripts\utility::flag_set( "approach_atlas_snipers_finished" );
    common_scripts\utility::flag_set( "barracks_approach_start_section" );
    common_scripts\utility::flag_set( "flag_spawn_intro_right_allies" );
    var_0 = getent( "trig_allies_frontline3", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

begin_post_tower()
{
    thread approach_barracks_combat_setup();
    thread df_baghdad_post_tower_autosaves();
    thread barracks_approach_handle_dialogue();
    thread bollards_move();
    thread bollards_clips();
    soundscripts\_snd::snd_music_message( "df_mech_combat" );
    common_scripts\utility::flag_wait( "snipers_finished" );
    soundscripts\_snd::snd_message( "snd_start_post_tower" );
}

post_tower_inits_precache()
{
    if ( !common_scripts\utility::flag_exist( "out_bounds_fail" ) )
        common_scripts\utility::flag_init( "out_bounds_fail" );

    if ( !common_scripts\utility::flag_exist( "out_bounds_fail_water" ) )
        common_scripts\utility::flag_init( "out_bounds_fail_water" );

    common_scripts\utility::flag_init( "barracks_approach_start_section" );
    common_scripts\utility::flag_init( "barracks_approach_assault_completed" );
    common_scripts\utility::flag_init( "barracks_approach_begin_combat" );
    common_scripts\utility::flag_init( "barracks_approach_second_retreat" );
    common_scripts\utility::flag_init( "barracks_approach_spawn_lastwave" );
    common_scripts\utility::flag_init( "barracks_approach_leftstreet" );
    common_scripts\utility::flag_init( "barracks_approach_rightstreet" );
    common_scripts\utility::flag_init( "barracks_approach_center_flag" );
    common_scripts\utility::flag_init( "barracks_shoot_down_bird" );
    common_scripts\utility::flag_init( "barracks_approach_threshold" );
    common_scripts\utility::flag_init( "barracks_approach_lookat_start_bird" );
    common_scripts\utility::flag_init( "flag_barracks_bollards" );
    common_scripts\utility::flag_init( "post_tower_player_on_rail" );
    common_scripts\utility::flag_init( "barracks_approach_spawn_helis" );
    common_scripts\utility::flag_init( "fan_gideon_in_pos" );
    common_scripts\utility::flag_init( "fan_knox_in_pos" );
    common_scripts\utility::flag_init( "spawn_right_flank_guys" );
    common_scripts\utility::flag_init( "snd_cloak_is_enabled" );
    common_scripts\utility::flag_init( "fan_team_ready" );
    common_scripts\utility::flag_init( "player_too_close_to_walker" );
    common_scripts\utility::flag_init( "ilana_alterspeed" );
    common_scripts\utility::flag_init( "mech_drop" );
    common_scripts\utility::flag_init( "drop_mech2" );
    common_scripts\utility::flag_init( "street_mechs_spawned" );
    common_scripts\utility::flag_init( "flag_los_mech3_spawn" );
    common_scripts\utility::flag_init( "barracks_approach_lookat_mech" );
    common_scripts\utility::flag_init( "street_mech_died" );
    common_scripts\utility::flag_init( "street_mech2_died" );
    common_scripts\utility::flag_init( "street_mech3_died" );
    common_scripts\utility::flag_init( "street_mech4_died" );
    common_scripts\utility::flag_init( "mech1_overrun" );
    common_scripts\utility::flag_init( "mech2_overrun" );
    common_scripts\utility::flag_init( "mech3_overrun" );
    common_scripts\utility::flag_init( "mech4_overrun" );
    common_scripts\utility::flag_init( "mech4_zone" );
    common_scripts\utility::flag_init( "mech3_zone" );
    common_scripts\utility::flag_init( "mech2_zone" );
    common_scripts\utility::flag_init( "street_mechs_skipped" );
    common_scripts\utility::flag_init( "obj_update_barracks_approach1" );
    common_scripts\utility::flag_init( "obj_update_barracks_approach2" );
    common_scripts\utility::flag_init( "obj_update_95th" );
    common_scripts\utility::flag_init( "eflag_lftFrnt_retreat" );
    common_scripts\utility::flag_init( "eflag_lftFrnt_retreat_physical" );
    common_scripts\utility::flag_init( "eflag_lftComb_retreat" );
    common_scripts\utility::flag_init( "eflag_lftComb_retreat_physical" );
    common_scripts\utility::flag_init( "eflag_lftLast_retreat" );
    common_scripts\utility::flag_init( "eflag_lftLast_retreat_physical" );
    common_scripts\utility::flag_init( "eflag_security_retreat" );
    common_scripts\utility::flag_init( "eflag_security_retreat_physical" );
    precachemodel( "vehicle_walker_tank_long_lod" );
}

df_baghdad_post_tower_autosaves()
{
    level waittill( "df_begin_combat_saves" );

    if ( !common_scripts\utility::flag( "street_mech_died" ) )
        common_scripts\utility::flag_wait_or_timeout( "street_mech_died", 4 );

    if ( isdefined( level.player.grapple_mech_no_save ) && level.player.grapple_mech_no_save )
    {
        while ( level.player.grapple_mech_no_save )
            waitframe();
    }

    thread maps\_utility::autosave_by_name_silent( "toc_approach_center" );
    common_scripts\utility::flag_wait_either( "eflag_lftFrnt_retreat", "eflag_lftFrnt_retreat_physical" );

    if ( isdefined( level.player.grapple_mech_no_save ) && level.player.grapple_mech_no_save )
    {
        while ( level.player.grapple_mech_no_save )
            waitframe();
    }

    thread maps\_utility::autosave_by_name_silent( "first_retreat_save" );
    common_scripts\utility::flag_wait_either( "eflag_lftComb_retreat", "eflag_lftComb_retreat_physical" );

    if ( isdefined( level.player.grapple_mech_no_save ) && level.player.grapple_mech_no_save )
    {
        while ( level.player.grapple_mech_no_save )
            waitframe();
    }

    thread maps\_utility::autosave_by_name_silent( "second_retreat_save" );
    common_scripts\utility::flag_wait_any( "eflag_security_retreat", "eflag_security_retreat_physical" );

    if ( isdefined( level.player.grapple_mech_no_save ) && level.player.grapple_mech_no_save )
    {
        while ( level.player.grapple_mech_no_save )
            waitframe();
    }

    thread maps\_utility::autosave_by_name_silent( "last_retreat" );
}

approach_spawn_functions()
{
    level waittill( "load_finished" );
    maps\_utility::array_spawn_function_targetname( "barracks_approach_americans_respawns", ::color_spawners_setup );

    if ( level.nextgen )
        maps\_utility::array_spawn_function_targetname( "barracks_approach_americans", ::americans_setup );

    maps\_utility::array_spawn_function_noteworthy( "barracks_approach_monster_spawns", ::monsters_can_jump );
    var_0 = getentarray( "barracks_approach_monster_spawns_monorail", "script_noteworthy" );

    if ( var_0.size )
        maps\_utility::array_spawn_function_noteworthy( "barracks_approach_monster_spawns_monorail", ::monsters_can_jump );
}

monsters_can_jump()
{
    self.canjumppath = 10;
}

safetyteleport_allies( var_0, var_1, var_2 )
{
    level endon( var_2 );
    common_scripts\utility::flag_wait( "barracks_approach_start_section" );
    level.tele_orgs = common_scripts\utility::getstructarray( var_1, "targetname" );
    level.tele_orgs = sortbydistance( level.tele_orgs, level.player.origin );
    common_scripts\utility::array_thread( level.tele_orgs, ::validate_tp_orgs, level.tele_orgs );

    if ( !isdefined( var_0 ) )
        var_0 = 256;

    var_3 = var_0 * var_0;
    var_4 = [];
    var_4[var_4.size] = level.allies[0];
    var_4[var_4.size] = level.allies[1];
    var_4[var_4.size] = level.allies[2];

    foreach ( var_6 in var_4 )
    {
        if ( distancesquared( var_6.origin, level.player.origin ) > var_3 )
        {
            for (;;)
            {
                if ( isdefined( var_6 ) )
                {
                    if ( !maps\_utility::player_can_see_ai( var_6 ) )
                        break;
                }

                waitframe();
            }

            var_6 thread safetyteleport_actor( level.tele_orgs );
        }
    }
}

safetyteleport_actor( var_0 )
{
    for (;;)
    {
        var_1 = common_scripts\utility::random( var_0 );

        if ( isdefined( var_1.valid_tp_node ) && var_1.valid_tp_node == 1 )
        {
            self _meth_81C6( var_1.origin, var_1.angles );
            break;
        }

        waitframe();
    }
}

validate_tp_orgs( var_0 )
{
    for (;;)
    {
        var_1 = level.player _meth_80A8();

        foreach ( var_3 in var_0 )
        {
            if ( !common_scripts\utility::within_fov( var_1, level.player getangles(), var_3.origin, cos( 45 ) ) )
            {
                var_3.valid_tp_node = 1;
                continue;
            }

            var_3.valid_tp_node = 0;
        }

        waitframe();
    }
}

americans_setup()
{

}

color_spawners_setup()
{
    thread maps\_utility::replace_on_death();
    maps\_utility::enable_careful();
    self.canjumppath = 10;
}

allies_careful()
{
    foreach ( var_1 in level.allies )
    {
        if ( isdefined( var_1 ) )
        {
            var_1 maps\_utility::enable_careful();
            var_1 maps\_utility::set_ignoresuppression( 0 );
        }
    }
}

approach_barracks_combat_setup()
{
    common_scripts\utility::flag_wait( "barracks_approach_start_section" );
    thread post_tower_axis_logic();
    thread approach_handle_murica_movement_left();
    thread allies_careful();
    thread allies_cover_michell();
    level.allies[2] thread maps\df_baghdad_barracks_utility::ilana_keeps_up();

    if ( level.nextgen )
    {
        level.americans = maps\_utility::array_spawn_targetname( "barracks_approach_americans", 1 );

        foreach ( var_1 in level.americans )
        {
            var_1 thread maps\_utility::magic_bullet_shield( 1 );
            var_1 thread maps\_utility::enable_careful();
            var_1.canjumppath = 10;
            var_1.dontmelee = 1;
        }

        thread maps\df_baghdad_code::safe_activate_trigger_with_targetname( "position_alliesformech" );
        common_scripts\utility::flag_wait_either( "street_mech_died", "mech1_overrun" );

        foreach ( var_1 in level.americans )
        {
            var_1 maps\_utility::set_force_color( "c" );
            var_1.dontmelee = 0;
        }

        waitframe();
        thread maps\df_baghdad_code::safe_activate_trigger_with_targetname( "barracks_approach_allies_right" );

        foreach ( var_1 in level.americans )
        {
            var_1 thread maps\_utility::stop_magic_bullet_shield();
            var_1 thread maps\_utility::replace_on_death();
        }
    }
}

post_tower_axis_logic()
{
    for (;;)
    {
        if ( isdefined( level.player.isinturret ) && level.player.isinturret )
        {
            waitframe();
            continue;
        }

        waitframe();
        break;
    }

    var_0 = level.player getorigin();
    var_1 = squared( 196 );

    for (;;)
    {
        waitframe();

        if ( distancesquared( level.player getorigin(), var_0 ) > var_1 )
            break;
    }

    var_2 = getent( "flag_bsp_check_mechdrop", "targetname" );

    if ( isdefined( var_2 ) )
    {
        if ( !common_scripts\utility::flag( "barracks_approach_lookat_mech" ) )
            common_scripts\utility::flag_wait_or_timeout( "barracks_approach_lookat_mech", 6 );
    }

    thread barracks_defense_guys();
    thread street_mechs();
    thread cleanup_specific_spawns();
    common_scripts\utility::flag_wait( "drop_mech2" );
    var_3 = undefined;

    if ( level.nextgen )
        var_3 = maps\df_baghdad_barracks_utility::array_spawn_targetname_stagger( "barracks_approach_left_guys", 1, 1, 1, 0.1, 0.5 );
    else
        var_3 = maps\_utility::array_spawn_targetname_cg( "barracks_approach_left_guys", 1, 0.15 );

    foreach ( var_5 in var_3 )
    {
        if ( isdefined( var_5 ) )
            var_5.canjumppath = 10;
    }

    var_7 = undefined;

    if ( level.nextgen )
        var_7 = maps\_utility::array_spawn_targetname( "barracks_approach_left_guys_balcony", 1 );
    else
        var_7 = maps\_utility::array_spawn_targetname_cg( "barracks_approach_left_guys_balcony", 1, 0.15 );

    foreach ( var_9 in var_7 )
    {
        if ( isdefined( var_9 ) )
            var_9.canjumppath = 10;
    }

    var_3 = common_scripts\utility::array_combine( var_3, var_7 );
    thread maps\df_baghdad_barracks_utility::ai_array_killcount_flag_set( var_3, int( var_3.size * 0.7 ), "eflag_lftFrnt_retreat" );
    level notify( "df_begin_combat_saves" );
    common_scripts\utility::flag_wait_any( "eflag_lftFrnt_retreat", "eflag_lftFrnt_retreat_physical" );
    var_11 = maps\_utility::get_living_ai_array( "barracks_approach_left_guys_balcony_rpg", "script_noteworthy" );

    if ( var_11.size )
    {
        foreach ( var_13 in var_11 )
            var_13 thread maps\df_baghdad_barracks_utility::cleanup_extra_ai();
    }

    var_15 = maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( undefined, "approach_tower_leftside_01", "barracks_approach_left_guys", "barracks_approach_left_guys_rear", 1 );
    waittillframeend;
    thread maps\df_baghdad_barracks_utility::ai_array_killcount_flag_set( var_15, int( var_15.size * 0.7 ), "eflag_lftComb_retreat" );
    var_11 = maps\_utility::get_living_ai_array( "barracks_approach_left_guys_balcony", "script_noteworthy" );

    if ( var_11.size )
    {
        foreach ( var_17 in var_11 )
        {
            if ( !maps\_utility::player_can_see_ai( var_17 ) )
                var_17 thread maps\df_baghdad_barracks_utility::bloody_death( 2 );
        }
    }

    common_scripts\utility::flag_wait_either( "eflag_lftComb_retreat", "eflag_lftComb_retreat_physical" );
    var_15 = maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "approach_tower_leftside_01", "barracks_front_combat" );
    var_15 = common_scripts\utility::array_combine( var_15, maps\_utility::get_living_ai_array( "barracks_approach_building_defend_guys", "script_noteworthy" ) );
    var_19 = common_scripts\utility::flag_wait_any_return( "eflag_security_retreat", "eflag_security_retreat_physical" );
    var_15 = maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "barracks_front_combat", "walker_guys_vol" );
    var_20 = maps\df_baghdad_barracks_utility::retreat_from_vol_to_vol( "barracks_roundup_front", "walker_guys_vol" );
    wait 0.1;

    if ( var_15.size && var_20.size )
    {
        var_15 = common_scripts\utility::array_combine( var_15, var_20 );

        foreach ( var_13 in var_15 )
        {
            if ( isalive( var_13 ) && issentient( var_13 ) && !issubstr( var_13.classname, "mech" ) )
                var_13 thread maps\df_baghdad_barracks_utility::disable_grenades();
        }
    }
}

barracks_defense_guys()
{
    common_scripts\utility::flag_wait_any( "barracks_approach_center_flag", "eflag_lftComb_retreat", "eflag_lftComb_retreat_physical" );
    thread enemy_walker();

    if ( !common_scripts\utility::flag( "barracks_approach_spawn_lastwave" ) )
        common_scripts\utility::flag_wait( "barracks_approach_spawn_lastwave" );

    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\_utility::array_spawn_targetname( "barracks_approach_building_defend_guys", 1 );
    else
        var_0 = maps\_utility::array_spawn_targetname_cg( "barracks_approach_building_defend_guys", 1, 0.2 );

    thread maps\df_baghdad_barracks_utility::ai_array_killcount_flag_set( var_0, int( var_0.size * 0.7 ), "eflag_security_retreat" );
    var_1 = maps\_utility::get_living_ai_array( "barracks_approach_left_guys_rear", "script_noteworthy" );
    var_1 = common_scripts\utility::array_combine( var_1, maps\_utility::get_living_ai_array( "barracks_approach_left_guys", "script_noteworthy" ) );

    if ( var_1.size )
    {
        foreach ( var_3 in var_1 )
            var_3 thread maps\df_baghdad_barracks_utility::bloody_death( 6 );
    }

    waittillframeend;

    foreach ( var_6 in var_0 )
    {
        if ( isalive( var_6 ) && issentient( var_6 ) )
            var_6.canjumppath = 10;
    }

    common_scripts\utility::flag_wait_either( "eflag_security_retreat", "eflag_security_retreat_physical" );
    var_8 = undefined;

    if ( level.nextgen )
        var_8 = maps\_utility::array_spawn_targetname( "barracks_approach_right_guys_rear", 1 );
    else
        var_8 = maps\_utility::array_spawn_targetname_cg( "barracks_approach_right_guys_rear", 1, 0.2 );

    foreach ( var_10 in var_8 )
    {
        if ( isalive( var_10 ) && issentient( var_10 ) )
        {
            var_10.canjumppath = 10;
            var_10 thread maps\df_baghdad_barracks_utility::spawn_func_respawn_on_death( 1, 512 );
            var_10 maps\df_baghdad_barracks_utility::disable_grenades();
        }
    }
}

approach_handle_murica_movement_left()
{
    common_scripts\utility::flag_wait_any( "eflag_lftFrnt_retreat", "eflag_lftFrnt_retreat_physical" );
    wait 1;
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "aMovement_murica_lft1" );
    common_scripts\utility::flag_wait_any( "eflag_lftComb_retreat", "eflag_lftComb_retreat_physical" );
    level notify( "spawn_new_americans" );
    wait 1;
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "aMovement_murica_lft2" );
    common_scripts\utility::flag_wait_either( "eflag_security_retreat", "eflag_security_retreat_physical" );
    wait 1;
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "aMovement_murica_lft3" );
}

cleanup_specific_spawns()
{
    common_scripts\utility::flag_wait( "barracks_approach_assault_completed" );
    var_0 = maps\_utility::get_living_ai_array( "barracks_approach_monster_spawns", "script_noteworthy" );

    while ( var_0.size )
    {
        foreach ( var_2 in var_0 )
        {
            waitframe();

            if ( isdefined( var_2 ) )
            {
                if ( !maps\_utility::player_can_see_ai( var_2 ) )
                    var_2 thread maps\df_baghdad_barracks_utility::bloody_death( 4 );
            }
        }
    }
}

allies_cover_michell()
{
    level.player endon( "death" );
    level endon( "stop_walker_spawners" );
    level waittill( "street_mechs_handled" );

    for (;;)
    {
        waitframe();
        level.player waittill( "damage", var_0, var_1 );

        if ( isdefined( var_1 ) && isai( var_1 ) && isalive( var_1 ) )
        {
            foreach ( var_3 in level.allies )
                var_3 maps\_utility::set_favoriteenemy( var_1 );
        }

        var_1 common_scripts\utility::waittill_any_timeout( 2, "death", "removed" );
    }
}

mech_spawn_warbird( var_0 )
{
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );
    var_1 thread mechbird_handlecloak();
    soundscripts\_snd::snd_message( "aud_avs_enemy_warbird_2", var_1 );
    return var_1;
}

mechbird_handlecloak()
{
    maps\_utility::ent_flag_init( "klingon_cloak_on" );
    maps\_utility::ent_flag_init( "klingon_cloak_off" );
}

drop_off_walker_bird()
{
    common_scripts\utility::flag_wait( "mech1_overrun" );
    var_0 = getent( "warbird_walker_ridein", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "warbird_walker_ridein" );
    waitframe();
    var_1 thread maps\df_baghdad_intro::warbird_carrying_walker( "warbird_pulley", "warbird_walker2" );
}

enemy_walker()
{
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][0].homing_delay_min = 0.05;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][0].homing_delay_max = 0.06;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][1].homing_delay_min = 0.05;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][1].homing_delay_max = 0.06;
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][0].homing_delay_min = 0.05;
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][0].homing_delay_max = 0.06;
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][1].homing_delay_min = 0.05;
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][1].homing_delay_max = 0.06;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][0].missile_object = "bagh_mahem_cheaptrail";
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][1].missile_object = "bagh_mahem_cheaptrail";
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][0].missile_object = "bagh_mahem_cheaptrail";
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][1].missile_object = "bagh_mahem_cheaptrail";
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][0].pre_fire_function = undefined;
    level.vehicle_missile_launcher["script_vehicle_walker_tank"][1].post_fire_function = undefined;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][0].pre_fire_function = undefined;
    level.vehicle_missile_launcher["script_vehicle_walker_tank_generic"][1].post_fire_function = undefined;
    level.walker = maps\_vehicle::spawn_vehicle_from_targetname( "finale_tank_boss" );
    var_0 = getent( "finale_tank_boss2", "targetname" );

    if ( isdefined( var_0 ) )
    {
        level.walker2 = maps\_vehicle::spawn_vehicle_from_targetname( "finale_tank_boss2" );
        level.walker2 thread walker2_logic();
        level.walker2 childthread enemy_walker_kill_player_if_too_close();
    }

    level.walker.mobile_turret_rocket_target = 0;
    level.walker thread walker_anims();
    level.walker thread enemy_walker_silence();
    level.walker endon( "death" );
    level.walker endon( "stop_final_walker" );
    level.walker maps\_vehicle::godon();
    level.walker childthread enemy_walker_kill_player_if_too_close();
}

walker2_logic()
{
    var_0 = "dogfight_spider_tank_fire";
    var_1 = "dogfight_spider_tank_standup";
    var_2 = "dogfight_spider_tank_stand_idle";
    var_3 = "stop_stand_idle";
    var_4 = "dogfight_spider_tank_standdown";
    self.animname = "street_walker";
    vehicle_scripts\_walker_tank::disable_firing( 0 );
    vehicle_scripts\_walker_tank::disable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_firing( 1 );
    vehicle_scripts\_walker_tank::disable_firing( 2 );
    vehicle_scripts\_walker_tank::disable_tracking( 0 );
    vehicle_scripts\_walker_tank::disable_tracking( -1 );
    vehicle_scripts\_walker_tank::disable_tracking( 1 );
    vehicle_scripts\_walker_tank::disable_tracking( 2 );
    common_scripts\utility::flag_wait( "finale_tank_start_anims" );
    wait 1.5;
    thread walker_missile_barrage();
    vehicle_scripts\_walker_tank::enable_firing( 0 );
    vehicle_scripts\_walker_tank::enable_firing( -1 );
    vehicle_scripts\_walker_tank::enable_firing( 1 );
    vehicle_scripts\_walker_tank::enable_firing( 2 );
    vehicle_scripts\_walker_tank::enable_tracking( 0 );
    vehicle_scripts\_walker_tank::enable_tracking( -1 );
    vehicle_scripts\_walker_tank::enable_tracking( 1 );
    vehicle_scripts\_walker_tank::enable_tracking( 2 );
    common_scripts\utility::flag_wait( "dnabomb_start_finale" );
    self notify( "stop_walker_barrage" );
    vehicle_scripts\_walker_tank::disable_firing( 0 );
    vehicle_scripts\_walker_tank::disable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_firing( 1 );
    vehicle_scripts\_walker_tank::disable_firing( 2 );
    vehicle_scripts\_walker_tank::disable_tracking( 0 );
    vehicle_scripts\_walker_tank::disable_tracking( -1 );
    vehicle_scripts\_walker_tank::disable_tracking( 1 );
    vehicle_scripts\_walker_tank::disable_tracking( 2 );
}

walker_anims()
{
    self endon( "end_walker_anims" );
    self endon( "death" );
    self endon( "removed" );
    level.player endon( "death" );
    self.animname = "street_walker";
    self _meth_8259( "neutral" );
    vehicle_scripts\_walker_tank::disable_firing( 0 );
    vehicle_scripts\_walker_tank::disable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_firing( 1 );
    vehicle_scripts\_walker_tank::disable_firing( 2 );
    var_0 = "dogfight_spider_tank_fire";
    var_1 = "dogfight_spider_tank_standup";
    var_2 = "dogfight_spider_tank_stand_idle";
    var_3 = "stop_stand_idle";
    var_4 = "dogfight_spider_tank_standdown";
    common_scripts\utility::flag_wait( "finale_tank_start_anims" );
    waittillframeend;
    thread walker_missile_barrage();
    self _meth_8259( "axis" );
    vehicle_scripts\_walker_tank::enable_firing( 0 );
    vehicle_scripts\_walker_tank::enable_firing( -1 );
    vehicle_scripts\_walker_tank::enable_firing( 1 );
    vehicle_scripts\_walker_tank::enable_firing( 2 );
    common_scripts\utility::flag_wait( "dnabomb_start_finale" );
    self notify( "stop_walker_barrage" );

    if ( !isdefined( self ) )
        return;

    vehicle_scripts\_walker_tank::disable_firing( 0 );
    vehicle_scripts\_walker_tank::disable_firing( -1 );
    vehicle_scripts\_walker_tank::disable_firing( 1 );
    vehicle_scripts\_walker_tank::disable_firing( 2 );
    vehicle_scripts\_walker_tank::disable_tracking( 0 );
    vehicle_scripts\_walker_tank::disable_tracking( -1 );
    vehicle_scripts\_walker_tank::disable_tracking( 1 );
    vehicle_scripts\_walker_tank::disable_tracking( 2 );
    self _meth_8259( "neutral" );
}

enemy_walker_silence()
{
    self endon( "death" );
    self endon( "removed" );
    level.walker waittill( "stop_final_walker" );
    self notify( "death" );
}

enemy_walker_kill_player_if_too_close()
{
    self endon( "death" );
    self endon( "removed" );
    common_scripts\utility::flag_wait( "player_too_close_to_walker" );
    maps\_vehicle::godon();
    level.player endon( "death" );
    level.player _meth_8132( 0 );

    foreach ( var_1 in self.mgturret )
    {
        var_1 notify( "stop_vehicle_turret_ai" );
        var_1 thread walker_tank_turret_fire_at_player( level.player );
    }

    for (;;)
    {
        level.player _meth_8051( 15 / level.player.damagemultiplier, self.origin, self );
        var_3 = randomfloatrange( 0.1, 0.3 );
        wait(var_3);
    }
}

walker_tank_turret_fire_at_player( var_0 )
{
    self endon( "death" );
    self endon( "stop_vehicle_turret_ai" );
    self _meth_8135( "axis" );
    self _meth_8065( "manual" );
    self _meth_8106( var_0 );
    self _meth_8179();
    self _meth_80E2();
}

walker_missile_barrage()
{
    self endon( "death" );
    self endon( "removed" );
    self endon( "stop_walker_barrage" );
    level waittill( "street_mechs_handled" );
    wait 4;

    for (;;)
    {
        var_0 = getentarray( "walker_tank_barrage_locs", "targetname" );
        var_0 = common_scripts\utility::array_combine( var_0, _func_0D6( "allies" ) );

        foreach ( var_2 in var_0 )
        {
            if ( isplayer( var_2 ) || maps\_utility::is_in_array( level.allies, var_2 ) )
                var_0 = common_scripts\utility::array_remove( var_0, var_2 );
        }

        var_0 = sortbydistance( var_0, self.origin, 2000 );

        if ( var_0.size )
        {
            vehicle_scripts\_walker_tank::fire_missles_at_target_array( var_0, 1 );
            wait(randomintrange( 8, 12 ));
            vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
        }

        waitframe();
    }
}

barracks_approach_handle_dialogue()
{
    thread stinger_vo();
    common_scripts\utility::flag_wait( "street_mechs_spawned" );
    thread mech_objective_nag();
    maps\_utility::smart_radio_dialogue_interrupt( "df_ss1_needsupport" );
    level.allies[1] maps\_utility::smart_radio_dialogue_interrupt( "df_nox_multasts" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_sortbastards" );
    level notify( "start_mech_nags" );
    common_scripts\utility::flag_wait_either( "eflag_lftFrnt_retreat", "eflag_lftFrnt_retreat_physical" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_keepadvancing" );
    common_scripts\utility::flag_wait_either( "eflag_lftComb_retreat", "eflag_lftComb_retreat_physical" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_ontherun" );
    common_scripts\utility::flag_wait_either( "eflag_lftLast_retreat", "eflag_lftLast_retreat_physical" );
}

stinger_vo()
{
    level waittill( "street_mechs_handled" );
    level.allies[2] maps\_utility::smart_radio_dialogue_interrupt( "df_iln_heavyarmor" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gdn_tearusapart" );
    level.allies[1] maps\_utility::smart_radio_dialogue_interrupt( "df_nox_weaponcache" );
    level notify( "start_stinger_objective" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gdn_grabstingers" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gdn_gogogo3" );
}

mech_objective_nag()
{
    level endon( "street_mechs_handled" );
    level waittill( "start_mech_nags" );
    var_0 = [];
    var_0[var_0.size] = "df_iln_takemechs";
    var_0[var_0.size] = "df_gid_clearoutasts";
    var_1 = 6;
    var_2 = 0;
    wait(var_1);

    for (;;)
    {
        var_2++;

        if ( var_2 >= var_0.size )
            var_2 = 0;

        maps\_utility::smart_radio_dialogue_interrupt( var_0[var_2] );
        var_1 *= 1.5;
        wait(var_1);
    }
}

bollards_move()
{
    common_scripts\utility::flag_wait( "flag_barracks_bollards" );
    var_0 = getentarray( "barracks_bollards", "targetname" );
    soundscripts\_snd::snd_message( "bollards_move" );

    if ( var_0.size )
    {
        level notify( "barracks_bollards_moving" );
        common_scripts\utility::array_call( var_0, ::_meth_82B1, 46, 4, 0.5 );
    }
}

bollards_clips()
{
    common_scripts\utility::flag_wait( "flag_barracks_bollards" );
    var_0 = getentarray( "barracks_bollard_clip", "targetname" );

    if ( var_0.size )
        common_scripts\utility::array_call( var_0, ::_meth_82B1, 49, 4, 0.5 );
}

street_mechs()
{
    var_0 = thread mech_spawn_warbird( "warbird_mech_ride" );
    var_0 _meth_8293( "faster" );
    common_scripts\utility::flag_wait( "mech_drop" );
    level.streetmechs = [];
    level.streetmechs[level.streetmechs.size] = spawn_mech_baghdad( "mech1_streets" );
    waittillframeend;
    common_scripts\utility::flag_set( "street_mechs_spawned" );
    level notify( "str_mech_spawned" );
    var_1 = thread mech_spawn_warbird( "warbird_mech_ride2" );
    common_scripts\utility::flag_wait( "drop_mech2" );

    if ( level.currentgen )
        wait 5;

    var_2 = common_scripts\utility::getstruct( "mechdrop_2_heli_path", "targetname" );
    var_1.script_vehicle_selfremove = 1;
    level.streetmechs[level.streetmechs.size] = spawn_mech_baghdad( "mech3_streets" );
    var_1 maps\_utility::delaythread( 2.5, maps\_vehicle::vehicle_paths, var_2 );
    level notify( "str_mech_spawned" );
    var_1 = thread mech_spawn_warbird( "warbird_mech_ride3" );
    common_scripts\utility::flag_wait( "drop_mech3" );

    if ( level.currentgen )
        wait 5;

    level.streetmechs[level.streetmechs.size] = spawn_mech_baghdad( "mech4_streets" );
    var_2 = common_scripts\utility::getstruct( "mechdrop_3_heli_path", "targetname" );
    var_1 maps\_utility::delaythread( 2.5, maps\_vehicle::vehicle_paths, var_2 );
    var_1.script_vehicle_selfremove = 1;
    level notify( "str_mech_spawned" );
    var_3 = undefined;
}

spawn_mech_baghdad( var_0 )
{
    var_1 = getent( var_0, "script_noteworthy" ) maps\_utility::spawn_ai( 1 );
    var_1.dontmelee = 1;
    var_1.walkdist = 5000;
    var_1 maps\_utility::add_damage_function( ::mech_incoming_damage_modifiers_baghdad );
    var_1 maps\_utility::add_damage_function( ::mech_incoming_damage_target_player );
    var_1 thread mech_stop_boost_slam_sp_dmg();
    var_1 thread badmofo();
    var_1 thread maps\df_baghdad_code::mech_damage_end_support();

    switch ( var_1.script_noteworthy )
    {
        case "mech1_streets":
            var_1 thread mech1_focal_change();
            var_1 thread mech1_logic();
            var_1 thread mech1_animdrop( "mech_drop_test" );
            var_1 thread mech_long_distance_damage();
            var_1 thread mech1_death_move_monsters();
            break;
        case "mech3_streets":
            var_1 thread mech3_logic();
            var_1 thread mech1_animdrop( "mech2_drop" );
            var_1 thread mech_long_distance_damage();
            break;
        case "mech4_streets":
            var_1 thread mech4_logic();
            var_1 thread mech1_animdrop( "mech3_drop" );
            var_1 thread mech_long_distance_damage();
            var_1 thread mech4_death_move_monsters();
            break;
        default:
            var_1 thread mech_lower_turnrates();
            break;
    }

    return var_1;
}

mech_stop_boost_slam_sp_dmg()
{
    self endon( "death" );
    self endon( "removed" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isplayer( var_1 ) )
        {
            if ( var_9 == "boost_slam_sp" )
                self.health += var_0;
        }
    }
}

mech_long_distance_damage()
{
    self endon( "death" );
    self endon( "player_is_shoost_fighting_me" );
    self endon( "player_progressing_normally_mechs" );
    var_0 = self.maxhealth - self.maxhealth * 0.2;

    for (;;)
    {
        waitframe();

        if ( self.health <= var_0 )
        {
            for (;;)
            {
                waitframe();
                self waittill( "damage", var_1, var_2 );

                if ( isdefined( var_2 ) && isplayer( var_2 ) )
                {
                    maps\_utility::set_favoriteenemy( level.player );
                    self notify( "stop_fav_random" );
                    self notify( "stop_bully_angles" );

                    if ( self.script_noteworthy != "mech4_streets" )
                        thread maps\df_baghdad_code::_mech_hunt_baghdad( level.player, undefined, 512 );
                    else
                        thread maps\_mech::mech_start_hunting();

                    self notify( "player_is_shoost_fighting_me" );

                    if ( isdefined( self.isshootingrockets ) && !self.isshootingrockets )
                        thread maps\_mech::mech_rocket_launcher_behavior( 128, 2256 );

                    break;
                }
            }
        }
    }
}

mech1_animdrop( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    self.animname = "first_mech";
    self _meth_8141();
    var_1 thread maps\_anim::anim_single_solo( self, "mech_dropin" );
    thread mech1_dropfx();
    self waittillmatch( "single anim", "end" );
    self notify( "drop_complete" );
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0.origin;
    self _meth_81A7( var_1 );
    waitframe();
    self notify( "start_angle_bully" );
    self waittill( "death" );
    var_1 delete();
}

mech1_dropfx()
{
    self endon( "death" );
    self waittillmatch( "single anim", "ast_drop_impact" );
    thread mech1_dropsound();
    playfx( common_scripts\utility::getfx( "mech_drop_impact" ), self.origin );
}

mech1_dropsound()
{
    var_0 = self.origin;
    var_1 = spawnstruct();
    var_1.pos = var_0;
    var_1.speed_of_sound_ = 1;
    var_1.duck_alias_ = "exp_generic_explo_sub_kick";
    var_1.duck_dist_threshold_ = 1000;
    var_1.explo_delay_chance_ = 40;
    var_1.explo_tail_alias_ = "exp_generic_explo_tail";
    var_1.shake_dist_threshold_ = 1800;
    var_1.explo_debris_alias_ = "exp_debris_mixed";
    var_1.ground_zero_alias_ = "exp_grnd_zero_rock_tear";
    var_1.ground_zero_dist_threshold_ = 500;
    thread soundscripts\_snd_common::snd_ambient_explosion( var_1 );
}

badmofo()
{
    self endon( "death" );
    self endon( "removed" );

    for (;;)
    {
        wait 0.5;
        badplace_cylinder( "mech_bplace_" + self.script_noteworthy, 0.5, self.origin, 256, 81, "allies" );
    }
}

mech1_logic()
{
    self endon( "death" );
    self endon( "removed" );
    self waittill( "drop_complete" );
    thread maps\_mech::mech_rocket_launcher_behavior( 128, 2256 );
    thread mech1_forceangle();
    self endon( "player_is_shoost_fighting_me" );
    common_scripts\utility::flag_wait( "mech1_overrun" );
    self notify( "player_progressing_normally_mechs" );
    self notify( "stop_bully_angles" );
    thread maps\df_baghdad_code::_mech_hunt_baghdad( undefined, 1, 512 );
}

mech1_death_move_monsters()
{
    self waittill( "death" );
    var_0 = getent( "mech1_spawnguys_trig1", "targetname" );
    var_1 = getent( "mech1_spawnguys_trig2", "targetname" );

    if ( isdefined( var_0 ) )
        var_0 notify( "trigger" );

    if ( isdefined( var_1 ) )
        var_1 notify( "trigger" );
}

mech1_forceangle()
{
    self endon( "stop_bully_angles" );
    self endon( "death" );
    self waittill( "start_angle_bully" );

    for (;;)
    {
        waitframe();

        if ( !isdefined( self ) )
            break;

        var_0 = common_scripts\utility::getstruct( self.target, "targetname" );

        if ( isdefined( var_0 ) )
            self _meth_818F( "face angle", var_0.angles[1] );
    }
}

mech3_logic()
{
    self endon( "death" );
    self endon( "removed" );
    self endon( "player_is_shoost_fighting_me" );
    thread mechs_focal_change();

    if ( !common_scripts\utility::flag( "street_mech_died" ) && !common_scripts\utility::flag( "mech3_overrun" ) )
        common_scripts\utility::flag_wait_any( "street_mech_died", "mech3_overrun" );

    thread maps\_mech::mech_rocket_launcher_behavior( 128, 2256 );

    if ( !common_scripts\utility::flag( "mech3_zone" ) )
        common_scripts\utility::flag_wait( "mech3_zone" );

    if ( isalive( maps\_utility::get_living_ai( "mech1_streets", "script_noteworthy" ) ) )
    {
        var_0 = maps\_utility::get_living_ai( "mech1_streets", "script_noteworthy" );
        var_0 thread maps\df_baghdad_code::_stop_mech_hunt_baghdad();
        var_0 thread maps\_mech::mech_start_hunting();
        var_0 notify( "stop_fav_random" );
        var_0 maps\_utility::set_favoriteenemy( level.player );
    }

    self notify( "player_progressing_normally_mechs" );
    thread maps\df_baghdad_code::_mech_hunt_baghdad( undefined, 1, 512 );
}

mech4_logic()
{
    self endon( "death" );
    self endon( "removed" );
    thread mechs_focal_change();
    childthread player_dist_limit();

    if ( !common_scripts\utility::flag( "street_mech3_died" ) && !common_scripts\utility::flag( "mech4_overrun" ) )
        common_scripts\utility::flag_wait_any( "street_mech3_died", "mech4_overrun" );

    thread maps\_mech::mech_rocket_launcher_behavior( 96, 2256 );

    if ( !common_scripts\utility::flag( "mech4_zone" ) )
        common_scripts\utility::flag_wait( "mech4_zone" );

    if ( isalive( maps\_utility::get_living_ai( "mech3_streets", "script_noteworthy" ) ) )
    {
        var_0 = maps\_utility::get_living_ai( "mech3_streets", "script_noteworthy" );
        var_0 thread maps\df_baghdad_code::_stop_mech_hunt_baghdad();
        var_0 thread maps\_mech::mech_start_hunting();
        var_0 notify( "stop_fav_random" );
        var_0 maps\_utility::set_favoriteenemy( level.player );
    }

    self notify( "player_progressing_normally_mechs" );
    self notify( "stop_fav_random" );
    maps\_utility::set_favoriteenemy( level.allies[2] );
    thread maps\_mech::mech_start_hunting();
}

mech4_death_move_monsters()
{
    self waittill( "death" );
    var_0 = getent( "mech_monster_move_trig", "targetname" );

    if ( !isdefined( var_0 ) )
        return;

    wait(randomintrange( 1, 3 ));
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "mech_monster_move_trig" );
}

player_dist_limit()
{
    var_0 = squared( 2500 );

    while ( isdefined( self ) )
    {
        var_1 = level.player getorigin();
        var_2 = self getorigin();

        if ( distancesquared( var_1, var_2 ) <= var_0 )
            maps\_utility::set_ignoreall( 0 );
        else
            maps\_utility::set_ignoreall( 1 );

        waitframe();
    }
}

mech1_focal_change()
{
    self endon( "removed" );
    self endon( "death" );
    self endon( "stop_fav_random" );
    var_0 = maps\_utility::get_living_ai_array( "barracks_approach_americans_leftside", "script_noteworthy" );
    waittillframeend;

    if ( var_0.size )
    {
        if ( isdefined( self ) )
        {
            var_1 = common_scripts\utility::random( var_0 );

            if ( !_func_294( var_1 ) )
            {
                if ( var_1.script_parameters == "mech1_focals" )
                {
                    if ( isdefined( self ) )
                        maps\_utility::set_favoriteenemy( var_1 );

                    wait(randomintrange( 2, 4 ));
                }
            }
        }

        waitframe();
    }
}

mechs_focal_change()
{
    self endon( "removed" );
    self endon( "death" );
    self endon( "stop_fav_random" );
    waittillframeend;

    for (;;)
    {
        var_0 = _func_0D6( "allies" );
        waittillframeend;

        if ( var_0.size )
        {
            if ( isdefined( self ) )
            {
                var_1 = common_scripts\utility::random( var_0 );
                maps\_utility::set_favoriteenemy( var_1 );
                wait(randomintrange( 2, 4 ));
            }
        }

        waitframe();
    }
}

mech_lower_turnrates()
{
    self endon( "death" );
    self.old_attributes = [];
    self.old_attributes["maxfaceenemydist"] = self.maxfaceenemydist;
    self.old_attributes["standingTurnRate"] = self.standingturnrate;
    self.old_attributes["walkingTurnRate"] = self.walkingturnrate;
    self.old_attributes["runingTurnRate"] = self.runingturnrate;
    self.old_attributes["pathenemylookahead"] = self.pathenemylookahead;

    for (;;)
    {
        waitframe();

        if ( isdefined( self ) && isdefined( self.enemy ) && isplayer( self.enemy ) )
        {
            var_0 = vectornormalize( level.player.origin - self.origin );
            var_1 = anglestoforward( self gettagangles( "tag_flash" ) );
            var_2 = vectordot( var_1, var_0 );

            if ( var_2 <= cos( 45 ) )
            {
                if ( self.standingturnrate == self.old_attributes["standingturnrate"] || self.walkingturnrate == self.old_attributes["walkingturnrate"] || self.runingturnrate == self.old_attributes["runingturnrate"] || self.moveplaybackrate == self.old_attributes["moveplaybackrate"] )
                {
                    self.standingturnrate *= 0.75;
                    self.walkingturnrate *= 0.75;
                    self.runingturnrate *= 0.75;
                    self.moveplaybackrate = 0.8;

                    for (;;)
                    {
                        waitframe();
                        var_0 = vectornormalize( level.player.origin - self.origin );
                        var_1 = anglestoforward( self gettagangles( "tag_flash" ) );
                        var_2 = vectordot( var_1, var_0 );

                        if ( var_2 >= cos( 45 ) )
                        {
                            self.standingturnrate = self.old_attributes["standingturnrate"];
                            self.walkingturnrate = self.old_attributes["walkingturnrate"];
                            self.runingturnrate = self.old_attributes["runingturnrate"];
                            self.moveplaybackrate = self.old_attributes["moveplaybackrate"];
                            break;
                        }
                    }
                }
            }

            continue;
        }

        if ( self.standingturnrate != self.old_attributes["standingturnrate"] || self.walkingturnrate != self.old_attributes["walkingturnrate"] || self.runingturnrate != self.old_attributes["runingturnrate"] )
        {
            self.standingturnrate = self.old_attributes["standingturnrate"];
            self.walkingturnrate = self.old_attributes["walkingturnrate"];
            self.runingturnrate = self.old_attributes["runingturnrate"];
        }
    }
}

mech_incoming_damage_modifiers_baghdad( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = 0;

    if ( isdefined( self.bullet_resistance ) )
        var_7 = self.bullet_resistance;

    if ( !isplayer( var_1 ) )
    {
        if ( self.health > 0 && var_0 > var_7 )
            self.health += int( ( var_0 - var_7 ) * 0.75 );
    }

    if ( self.damagelocation == "head" )
    {
        if ( self.health > 0 )
            self.health += int( ( var_0 - var_7 ) * 0.25 );
    }
}

mech_incoming_damage_target_player( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );
    self endon( "removed" );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self.currently_handling_player_damage ) && self.currently_handling_player_damage )
            return;

        var_7 = squared( 2000 );

        if ( distancesquared( self.origin, level.player.origin ) > var_7 )
            return;

        self.fav_random_switch = 0;
        self.currently_handling_player_damage = 1;
        maps\_utility::set_favoriteenemy( level.player );
        wait 2;

        if ( self.script_noteworthy == "mech4_streets" )
            maps\_utility::set_favoriteenemy( level.allies[2] );

        self.currently_handling_player_damage = 0;
        self.fav_random_switch = 1;
    }
}
