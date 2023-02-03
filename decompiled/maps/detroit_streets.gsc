// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

streets_main()
{
    level.truck_org_cords = ( 117, 65, 64 );
    thread alley_setup();
    thread bar_setup();
    thread second_room_nightclub_setup();
    thread setup_hospital_transition();
    thread streets_dialogue_manager();
    thread spawn_few_nightclub_guys();
    thread first_nightclub_room_setup();
    thread second_nightclub_room_setup();
    thread ambulance_firstframe_function();
    thread ambulance_objective_update();
}

streets_dialogue_manager()
{
    thread mitchell_over_here_dialogue();
}

setup_hospital_transition()
{
    maps\_utility::trigger_wait_targetname( "prepare_the_hospital" );
    maps\detroit_hospital::setup_hospital();
}

onfoot_start_alley_setup()
{
    var_0 = getnode( "ally_burke_start_onfoot", "targetname" );
    level.burke maps\_utility::clear_run_anim();
    level.burke maps\_utility::clear_generic_idle_anim();
    level.burke maps\_utility::teleport_ai( var_0 );
    level.burke.ignoreall = 0;
    level.burke thread blink_flashlight();
    common_scripts\utility::flag_set( "begin_setup_alley" );
    common_scripts\utility::flag_wait( "burke_alley_flashlight_off" );
    level.burke notify( "flashlight_off" );
}

blink_flashlight()
{
    level.burke maps\detroit_lighting::add_enemy_flashlight( "flashlight", "light" );
}

alley_setup()
{
    level.player thread return_full_mobility( "begin_onfoot_street_section" );
    common_scripts\utility::flag_wait( "begin_setup_alley" );
    level.burke maps\_utility::set_force_color( "r" );
    var_0 = getnode( "burke_door_kick_spot", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    level.burke.goalradius = 75;
    level.burke.disablearrivals = 0;
    level.burke.disableexits = 0;
    thread setup_hazmat_intro_allies();
    thread exterior_street_kickoff();
    thread street_fight_after_snipe();
    thread battle_chatter_check_alley();
}

return_full_mobility( var_0 )
{
    maps\_shg_design_tools::waittill_trigger_with_name( var_0 );
    self setmovespeedscale( 1 );
    self allowsprint( 1 );
}

destroy_the_window_exit()
{
    waitframe();
    var_0 = getent( "reunite_objective_node", "targetname" );
    var_1 = getentarray( "shoot_at_me_node", "targetname" );

    foreach ( var_3 in var_1 )
        var_4 = magicbullet( "iw5_bal27_sp", var_0.origin, var_3.origin );
}

shoot_at_ambulance()
{
    var_0 = getentarray( "shoot_at_ambulance_node", "targetname" );
    var_1 = getentarray( "shoot_at_me_origin", "targetname" );
    maps\_utility::trigger_wait_targetname( "regroup_kva_spawner_trigger" );

    foreach ( var_3 in var_1 )
        var_3 thread fake_gunfire_shooter_ambulance( var_0 );
}

move_bones_and_joker_up()
{
    maps\_utility::trigger_wait_targetname( "spawn_few_nightclub_guys_trigger" );
    var_0 = getnode( "bones_supressed_outside_node", "targetname" );
    var_1 = getnode( "joker_supressed_outside_node", "targetname" );

    if ( !isdefined( level.bones ) )
    {
        var_2 = getent( "bones_spawner_2", "targetname" );
        level.bones = var_2 maps\_utility::spawn_ai( 1 );
        level.bones maps\_utility::magic_bullet_shield();
    }

    level.bones.script_friendname = "Torres";
    level.bones.animname = "bones";
    var_3 = getnode( "bones_supressed_outside_node_startpoint", "targetname" );
    level.bones maps\_utility::clear_run_anim();
    level.bones maps\_utility::clear_generic_idle_anim();
    level.bones maps\_utility::teleport_ai( var_3 );
    level.bones.goalradius = 15;
    level.bones.accuracy = 15;

    if ( !isdefined( level.joker ) )
    {
        var_2 = getent( "joker_spawner_2", "targetname" );
        level.joker = var_2 maps\_utility::spawn_ai( 1 );
        level.joker maps\_utility::magic_bullet_shield();
    }

    level.joker.script_friendname = "Joker";
    level.joker.animname = "joker";
    var_4 = getnode( "joker_supressed_outside_node_startpoint", "targetname" );
    level.joker maps\_utility::clear_run_anim();
    level.joker maps\_utility::clear_generic_idle_anim();
    level.joker maps\_utility::teleport_ai( var_4 );
    level.joker.goalradius = 15;
    level.joker.accuracy = 0;
}

advance_bones_and_joker_intro()
{
    var_0 = getnode( "bones_supressed_outside_node", "targetname" );
    var_1 = getnode( "joker_supressed_outside_node", "targetname" );
    common_scripts\utility::flag_wait( "move_burke_down" );
    level.joker setgoalnode( var_1 );
    level.bones setgoalnode( var_0 );
    level.joker maps\_utility::disable_careful();
    level.bones maps\_utility::disable_careful();
}

distance_to_last_stage( var_0 )
{
    for (;;)
    {
        var_1 = distance2d( var_0.origin, level.player.origin );
        wait 0.05;
    }
}

exopush_stage_manager()
{
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );
    var_0 = getent( "exo_push_stage2_org", "targetname" );
    var_1 = getent( "exo_push_stage3_org", "targetname" );
    var_2 = 1;
    var_3 = 1;
    thread exopush_distance_debug_ui( var_2, var_3, var_0, var_1 );

    while ( var_2 )
    {
        var_4 = distance2d( self.origin, var_0.origin );

        if ( var_4 < 40 )
        {
            common_scripts\utility::flag_set( "exo_push_phase1_complete" );
            thread maps\_utility::autosave_by_name( "seeker" );
            var_2 = 0;
        }

        wait 0.05;
    }

    while ( var_3 )
    {
        var_4 = distance2d( self.origin, var_1.origin );

        if ( var_4 < 40 )
        {
            common_scripts\utility::flag_set( "exo_push_phase2_complete" );
            thread maps\_utility::autosave_by_name( "seeker" );
            thread spawn_hospital_roof_guys();
            var_3 = 0;
        }

        wait 0.05;
    }
}

exopush_distance_debug_ui( var_0, var_1, var_2, var_3 )
{
    while ( var_0 == 1 )
    {
        var_4 = distance2d( self.origin, var_2.origin );

        if ( var_4 < 40 )
            var_0 = 0;

        wait 0.1;
    }

    while ( var_1 == 1 )
    {
        var_4 = distance2d( self.origin, var_3.origin );

        if ( var_4 < 40 )
            var_1 = 0;

        wait 0.1;
    }
}

exopush_start()
{
    maps\_utility::trigger_wait_targetname( "runto_exo_start_trigger" );
    common_scripts\utility::flag_set( "vo_office_reunion_doctor" );
    common_scripts\utility::flag_wait( "flag_send_team_to_the_truck" );
    common_scripts\utility::flag_set( "obj_rendezvous_joker_complete" );
    thread begin_exo_push();
    wait 3;
    common_scripts\utility::flag_set( "vo_exo_push_start" );
    thread maps\_utility::autosave_by_name( "seeker" );
}

preplaced_guys_function()
{
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );
    thread spawn_preplaced_guys();
}

exo_push_combat_manager()
{
    level endon( "stop_exo_street_combat" );
    level.max_exo_guysalive = 2;
    level.current_exo_guys_alive = 0;
    common_scripts\utility::flag_wait( "window_ambush_flag" );
    thread new_kva_window_ambush( 4 );
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );

    for (;;)
    {
        if ( level.max_exo_guysalive > level.current_exo_guys_alive )
        {
            wait(randomintrange( 3, 5 ));
            spawn_a_guy();
        }

        wait 0.05;
    }
}

bones_rollout_manager()
{
    var_0 = getnode( "bones_cover_left_push_1", "targetname" );
    var_1 = getnode( "bones_cover_left_push_2", "targetname" );
    var_2 = getnode( "joker_cover_left_push_1", "targetname" );
    var_3 = getnode( "joker_cover_left_push_2", "targetname" );
    var_4 = getnode( "bones_hospital", "targetname" );
    var_5 = getnode( "joker_hospital", "targetname" );
    common_scripts\utility::flag_wait( "send_bones_joker_to_cover1" );
    level.bones thread maps\_utility::disable_careful();
    level.joker thread maps\_utility::disable_careful();
    level.bones.ignoreall = 1;
    level.joker.ignoreall = 1;
    level.bones.ignoreme = 1;
    level.joker.ignoreme = 1;
    level.bones setgoalnode( var_0 );
    level.joker setgoalnode( var_2 );
    level.bones thread enable_ai_on_goal();
    level.joker thread enable_ai_on_goal();
    level.bones.ignoreme = 0;
    level.joker.ignoreme = 0;
    common_scripts\utility::flag_wait( "exo_push_phase2_complete" );
    level.bones maps\_utility::disable_careful();
    level.joker maps\_utility::disable_careful();
    level.bones.ignoreall = 1;
    level.joker.ignoreall = 1;
    level.bones.ignoreme = 1;
    level.joker.ignoreme = 1;
    level.bones thread ignore_me_till_goal();
    level.joker thread ignore_me_till_goal();
    level.bones thread maps\_utility::disable_cqbwalk();
    level.joker thread maps\_utility::disable_cqbwalk();
    level.bones setgoalnode( var_1 );
    level.joker setgoalnode( var_3 );
    level.bones thread enable_ai_on_goal();
    level.joker thread enable_ai_on_goal();
    common_scripts\utility::flag_wait( "send_exopush_guys_into_hospital" );
    level.bones setgoalnode( var_4 );
    level.joker setgoalnode( var_5 );
}

surprise_ambush_kva_team()
{
    var_0 = getentarray( "surprise_ambush_kva_spawner", "targetname" );
    var_1 = getent( "surprise_ambush_kva_vol", "targetname" );
    maps\_utility::trigger_wait_targetname( "runto_exo_start_trigger" );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );

        if ( isdefined( var_4 ) )
        {
            var_4 setgoalvolumeauto( var_1 );
            var_4.goalradius = 30;
            var_4 thread maps\detroit_lighting::add_enemy_flashlight();
            var_4 thread ignore_me_till_goal();
            var_4 thread kill_me_on_truck_pushover();
        }
    }
}

kill_off_inside_guy()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "begin_spawning_troops_hospital" );
    thread maps\detroit::bloody_death();
}

new_kva_window_ambush( var_0 )
{
    common_scripts\utility::flag_wait( "begin_spawning_troops_hospital" );

    if ( isdefined( var_0 ) )
        wait(var_0);

    var_1 = getent( "scaffold_1_windowshoot_org", "targetname" );
    var_2 = getent( "scaffold_2_windowshoot_org", "targetname" );
    var_3 = getentarray( "scaffold_1_windowshoot_target", "targetname" );
    var_4 = getentarray( "scaffold_2_windowshoot_target", "targetname" );
    var_5 = getent( "exo_push_spawner_scaffold", "targetname" );
    var_6 = getent( "exo_push_spawner_scaffold_start", "targetname" );
    var_7 = getnode( "shoot_ambulance_org1", "targetname" );
    var_8 = getnode( "shoot_ambulance_org2", "targetname" );
    var_9 = getent( "surprise_ambush_kva_vol", "targetname" );
    thread shoot_out_windows( var_1, var_3 );
    wait 0.2;
    shoot_out_windows( var_2, var_4 );
    var_10 = var_5 maps\_utility::spawn_ai( 1 );

    if ( isalive( var_10 ) )
        var_10 setgoalnode( var_7 );

    wait 2.4;
    var_11 = var_6 maps\_utility::spawn_ai( 1 );

    if ( isalive( var_11 ) )
        var_11 setgoalnode( var_8 );
}

enable_ai_after_time( var_0 )
{
    wait(var_0);
    self.ignoreall = 0;
}

exo_push_gourney()
{
    level endon( "gourney_stop" );
    thread gourney_stop();
    var_0 = 0;
    var_1 = getent( "exo_push_gourney_spawner", "targetname" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_arrived" ) )
            return;

        var_1.count = 1;
        var_2 = var_1 maps\_utility::spawn_ai( 1 );
        var_0++;

        if ( var_0 == 3 )
        {
            common_scripts\utility::flag_set( "gourney_guys_dead" );
            return;
        }

        var_2 waittill( "death" );
        wait(randomintrange( 2, 6 ));
    }
}

all_exopush_enemies_dead()
{
    common_scripts\utility::flag_wait( "gourney_guys_dead" );
    common_scripts\utility::flag_wait( "secondline_guys_killed" );
    common_scripts\utility::flag_wait( "backline_guys_alldead" );
    common_scripts\utility::flag_set( "exo_push_arrived" );
}

gourney_stop()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level notify( "gourney_stop" );
}

enable_ai_on_goal()
{
    self endon( "death" );
    self.goalradius = 15;
    self waittill( "goal" );
    self.ignoreall = 0;
}

ignore_me_till_goal()
{
    self endon( "death" );
    self.ignoreme = 1;
    self waittill( "goal" );
    self.ignoreme = 0;
}

kill_me_on_truck_pushover()
{
    self endon( "death" );
    var_0 = randomfloatrange( 4.6, 5.1 );

    for (;;)
    {
        if ( common_scripts\utility::flag( "kill_the_two_guys_by_ambulance" ) )
            maps\detroit::bloody_death( var_0 );

        wait 0.05;
    }
}

fake_gunfire_sniper_moment()
{
    var_0 = getentarray( "shoot_at_me_origin", "targetname" );
    var_1 = getentarray( "shoot_at_me_node", "targetname" );
    maps\_utility::trigger_wait_targetname( "regroup_kva_spawner_trigger" );

    foreach ( var_3 in var_0 )
        var_3 thread fake_gunfire_shooter( var_1 );
}

fake_gunfire_shooter( var_0 )
{
    level endon( "time to stop shooting the roof" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "obj_rendezvous_joker_pos_joker" ) )
            thread stop_shooting_timer();

        var_1 = randomint( var_0.size );
        var_2 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_1].origin );
        wait(randomfloatrange( 0.2, 0.4 ));
    }
}

fake_gunfire_shooter_ambulance( var_0 )
{
    level endon( "time to stop shooting the ambulance" );
    thread stop_shooting_ambulance_timer();

    for (;;)
    {
        var_1 = randomint( var_0.size );
        var_2 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_1].origin );
        wait(randomfloatrange( 0.2, 0.4 ));
    }
}

stop_shooting_ambulance_timer()
{
    maps\_utility::trigger_wait_targetname( "runto_exo_start_trigger" );
    level notify( "time to stop shooting the ambulance" );
}

stop_shooting_timer()
{
    wait 0.6;
    level notify( "time to stop shooting the roof" );
}

bloody_death_all_survivors()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    common_scripts\utility::flag_set( "obj_exo_push_complete" );
    var_0 = getentarray( "killable_exopush_guy", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 thread random_bloody_death( 3.0 );
}

back_fake_bullets()
{
    var_0 = getentarray( "exopush_shooter_org_back", "targetname" );
    var_1 = getentarray( "exopush_shooter_org_mid", "targetname" );
    var_2 = getentarray( "exopush_shooter_org_front", "targetname" );
    var_3 = getentarray( "exopush_shooter_org_target", "targetname" );
    common_scripts\utility::flag_wait( "send_bones_joker_to_cover1" );

    foreach ( var_5 in var_0 )
        var_5 thread fake_gunfire_shooter_exopush_back( var_3 );

    foreach ( var_5 in var_2 )
        var_5 thread fake_gunfire_shooter_exopush_front( var_3 );

    foreach ( var_5 in var_1 )
        var_5 thread fake_gunfire_shooter_exopush_mid( var_3 );

    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level notify( "stop_all_fake_bullets" );
}

fake_gunfire_shooter_exopush_back( var_0 )
{
    level endon( "stop_back_shooting" );
    level endon( "stop_all_fake_bullets" );
    var_1 = getent( "exo_push_ambulance", "targetname" );
    thread back_gunfire_timer();
    var_2 = getent( "exo_push_street_vol3", "targetname" );

    for (;;)
    {
        if ( distance2d( level.player.origin, var_1.origin ) < 260 )
        {
            if ( !level.player istouching( var_2 ) )
            {
                var_3 = randomint( var_0.size );
                var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_3].origin );
            }
        }
        else if ( !level.player istouching( var_2 ) )
        {
            var_5 = level.player.origin + ( randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ) );
            var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_5 );
        }

        wait(randomfloatrange( 0.1, 0.4 ));
    }
}

fake_gunfire_shooter_exopush_mid( var_0 )
{
    level endon( "stop_mid_shooting" );
    level endon( "stop_all_fake_bullets" );
    var_1 = getent( "exo_push_ambulance", "targetname" );
    thread mid_gunfire_timer();
    var_2 = getent( "exo_push_street_vol3", "targetname" );

    for (;;)
    {
        if ( distance2d( level.player.origin, var_1.origin ) < 260 )
        {
            if ( !level.player istouching( var_2 ) )
            {
                var_3 = randomint( var_0.size );
                var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_3].origin );
            }
        }
        else if ( !level.player istouching( var_2 ) )
        {
            var_5 = level.player.origin + ( randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ) );
            var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_5 );
        }

        wait(randomfloatrange( 0.1, 0.4 ));
    }
}

fake_gunfire_shooter_exopush_front( var_0 )
{
    level endon( "stop_front_shooting" );
    level endon( "stop_all_fake_bullets" );
    var_1 = getent( "exo_push_ambulance", "targetname" );
    thread front_gunfire_timer();
    var_2 = getent( "exo_push_street_vol3", "targetname" );

    for (;;)
    {
        if ( distance2d( level.player.origin, var_1.origin ) < 260 )
        {
            if ( !level.player istouching( var_2 ) )
            {
                var_3 = randomint( var_0.size );
                var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_3].origin );
            }
        }
        else if ( !level.player istouching( var_2 ) )
        {
            var_5 = level.player.origin + ( randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ), randomfloatrange( -70, 70 ) );
            var_4 = magicbullet( "iw5_bal27_sp", self.origin, var_5 );
        }

        wait(randomfloatrange( 0.1, 0.4 ));
    }
}

back_gunfire_timer()
{
    common_scripts\utility::flag_wait( "exo_push_phase2_complete" );
    level notify( "stop_back_shooting" );
}

mid_gunfire_timer()
{
    common_scripts\utility::flag_wait( "exo_push_phase1_complete" );
    level notify( "stop_mid_shooting" );
}

front_gunfire_timer()
{
    common_scripts\utility::flag_wait( "exo_push_phase1_complete" );
    level notify( "stop_front_shooting" );
}

random_bloody_death( var_0 )
{
    wait(randomfloatrange( 0.3, var_0 ));

    if ( isalive( self ) )
        maps\detroit::bloody_death();
}

spawn_a_guy()
{
    if ( !common_scripts\utility::flag( "exo_push_arrived" ) )
    {
        var_0 = randomintrange( 1, 4 );

        if ( var_0 == 1 )
        {
            if ( !common_scripts\utility::flag( "window_exo_guys_spawned_yet" ) )
            {
                common_scripts\utility::flag_set( "window_exo_guys_spawned_yet" );
                thread shoot_out_exo_windows_scaffolding_think();
                thread exo_scaffolding_enemy();
            }
            else
                thread exo_scaffolding_enemy();
        }
        else if ( var_0 == 2 )
        {
            if ( !common_scripts\utility::flag( "window_exo_guys_spawned_yet" ) )
            {
                common_scripts\utility::flag_set( "window_exo_guys_spawned_yet" );
                thread spawn_scaffolding_to_floor_right();
            }
            else
                thread spawn_scaffolding_to_floor_right();
        }
        else if ( var_0 == 3 )
            thread spawn_left_building_scaffolding_guy();
    }
}

spawn_left_building_scaffolding_guy()
{
    var_0 = getent( "left_building_scaffolding1", "targetname" );
    var_1 = getent( "exo_push_leftbuilding_spawner_bottom", "targetname" );
    var_1.count = 1;
    var_2 = randomint( 12 );
    var_3 = var_1 maps\_utility::spawn_ai( 1 );

    if ( isdefined( var_3 ) )
    {
        level.current_exo_guys_alive++;
        var_3.goalradius = 15;
        var_3.grenadeammo = 0;
        var_3.meleeattackdist = 0;
        var_3 thread exo_guy_cleanup_think();
        var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
        var_3 setgoalvolumeauto( var_0 );
        var_3.ignoreall = 1;
        var_3 waittill( "goal" );
        var_3.ignoreall = 0;
    }
}

spawn_scaffolding_to_floor_right()
{
    var_0 = getent( "exo_push_spawner_scaffold", "targetname" );
    var_0.count = 1;
    var_1 = var_0 maps\_utility::spawn_ai( 1 );

    if ( isdefined( var_1 ) )
    {
        level.current_exo_guys_alive++;
        var_1.goalradius = 15;
        var_1.grenadeammo = 0;
        var_1.meleeattackdist = 0;
        var_1 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
        var_1 thread move_into_place_right();
        var_1 thread exo_guy_cleanup_think();
        var_1 thread street_update_my_volume_think();
    }
}

move_into_place_right()
{
    self.ignoreall = 1;
    level.burke.ignoreme = 1;
    level.bones.ignoreme = 1;
    self waittill( "goal" );
    self.ignoreall = 0;
    level.burke.ignoreme = 0;
    level.bones.ignoreme = 0;
}

street_update_my_volume_think()
{
    self endon( "death" );

    for (;;)
    {
        if ( !common_scripts\utility::flag( "exo_push_phase1_complete" ) )
            var_0 = getent( "exo_push_street_vol1", "targetname" );
        else if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
            var_0 = getent( "exo_push_street_vol2", "targetname" );
        else
            var_0 = getent( "exo_push_street_vol3", "targetname" );

        if ( isalive( self ) )
            self setgoalvolumeauto( var_0 );

        wait 3;
    }
}

shoot_out_exo_windows_scaffolding_think()
{
    var_0 = getglass( "hospital_jumpout_glass1" );
    var_1 = getglass( "hospital_jumpout_glass2" );
    var_2 = getent( "scaffold_1_windowshoot_org", "targetname" );
    var_3 = getent( "scaffold_2_windowshoot_org", "targetname" );
    var_4 = getentarray( "scaffold_1_windowshoot_target", "targetname" );
    var_5 = getentarray( "scaffold_2_windowshoot_target", "targetname" );
    thread shoot_out_windows( var_2, var_4 );
    destroyglass( var_0 );
    wait 0.4;
    thread shoot_out_windows( var_3, var_5 );
    destroyglass( var_1 );
}

exo_scaffolding_enemies()
{
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );
    var_0 = getentarray( "exo_push_spawner_scaffold", "targetname" );
    var_1 = getent( "scaffolding_1_vol", "targetname" );
    var_2 = getent( "scaffolding_2_vol", "targetname" );
    var_3 = getent( "scaffolding_3_vol", "targetname" );

    if ( !common_scripts\utility::flag( "exo_push_phase1_complete" ) )
    {
        foreach ( var_5 in var_0 )
        {
            var_6 = var_5 maps\_utility::spawn_ai( 1 );

            if ( isdefined( var_6 ) )
            {
                var_6 setgoalvolumeauto( var_1 );
                var_6.goalradius = 15;
                var_6.grenadeammo = 0;
                var_6.meleeattackdist = 0;
                var_6 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
                var_6 thread move_right_scaffolding_guy();
                wait(randomintrange( 3, 5 ));
            }
        }
    }
}

exo_guy_cleanup_think()
{
    self waittill( "death" );
    level.current_exo_guys_alive--;
}

exo_scaffolding_enemy()
{
    var_0 = randomint( 12 );
    var_1 = getent( "exo_push_spawner_scaffold", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_1.count = 1;

    if ( isdefined( var_2 ) )
    {
        var_2 endon( "death" );
        var_2.grenadeammo = 0;
        var_2.meleeattackdist = 0;
        level.current_exo_guys_alive++;
        var_2 thread exo_guy_cleanup_think();
        var_2.goalradius = 15;
        var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
        var_2 thread move_right_scaffolding_guy();
        wait(randomintrange( 1, 4 ));

        if ( var_0 > 9 )
            var_2 thread scaffolding_update_my_volume_think();
        else
        {

        }
    }
}

scaffolding_update_my_volume_think()
{
    self endon( "death" );
    var_0 = getent( "scaffolding_1_vol", "targetname" );
    var_1 = getent( "scaffolding_2_vol", "targetname" );
    var_2 = getent( "scaffolding_3_vol", "targetname" );

    for (;;)
    {
        if ( !common_scripts\utility::flag( "exo_push_phase1_complete" ) )
            var_3 = var_0;
        else if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
            var_3 = var_1;
        else
            var_3 = var_2;

        if ( isalive( self ) )
            self setgoalvolumeauto( var_3 );

        wait 3;
    }
}

shoot_out_windows( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        var_4 = magicbullet( "iw5_bal27_sp", var_0.origin, var_3.origin );
        wait(randomfloatrange( 0.1, 0.2 ));
        var_4 = magicbullet( "iw5_bal27_sp", var_0.origin, var_3.origin );
        wait(randomfloatrange( 0.25, 0.4 ));
    }
}

move_right_scaffolding_guy()
{
    self endon( "death" );
    self.ignoreall = 1;
    level.burke.ignoreme = 1;
    level.bones.ignoreme = 1;
    self waittill( "goal" );
    self.ignoreall = 0;
    level.burke.ignoreme = 0;
    level.bones.ignoreme = 0;
}

setup_street_reunion_spawners()
{
    maps\_utility::trigger_wait_targetname( "regroup_kva_spawner_trigger" );
    thread setup_sniper_spawns();
    common_scripts\utility::flag_set( "vo_office_reunion_start" );
    common_scripts\utility::flag_set( "flicker_street_lights" );
    var_0 = getentarray( "regroup_kva_spawner", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.accuracy = 0;
        var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    }
}

setup_sniper_spawns()
{
    var_0 = getent( "snipe_setup_vol_1", "targetname" );
    var_1 = getent( "snipe_setup_vol_2", "targetname" );
    var_2 = getent( "snipe_setup_vol_3", "targetname" );
    var_3 = getent( "snipe_setup_vol_4", "targetname" );
    var_4 = getent( "sniper_setup_spawner_1", "targetname" );
    var_5 = getent( "sniper_setup_spawner_2", "targetname" );
    var_6 = getent( "sniper_setup_spawner_3", "targetname" );
    var_7 = getent( "sniper_setup_spawner_4", "targetname" );
    var_8 = getent( "sniper_setup_spawner_6", "targetname" );
    thread spawn_sniper_guy( var_4, var_0 );
    thread spawn_sniper_guy( var_5, var_1, 0 );
    thread spawn_sniper_guy( var_6, var_2 );
    thread spawn_sniper_guy( var_7, var_3, 0 );
    thread spawn_sniper_guy( var_8, var_3, 0 );
    wait 0.25;
    common_scripts\utility::flag_set( "start_tracking_sniper_deaths" );
}

ambush_player_if_alive_exopush()
{
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );

    if ( isalive( self ) )
        maps\_utility::player_seek();
}

spawn_sniper_guy( var_0, var_1, var_2 )
{
    var_3 = var_0 maps\_utility::spawn_ai( 1 );
    var_3.accuracy = 0;
    var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_3 thread ambush_player_if_alive_exopush();

    if ( !isdefined( var_2 ) )
    {
        var_3 cleargoalvolume();
        var_3 setgoalvolumeauto( var_1 );
    }
}

push_right_after_flag()
{
    self endon( "death" );
    var_0 = getent( "snipe_setup_vol_4", "targetname" );
    maps\_utility::trigger_wait_targetname( "runto_exo_start_trigger" );
    wait(randomintrange( 1, 4 ));

    if ( isalive( self ) )
        self setgoalvolumeauto( var_0 );
}

angles_clamp_180( var_0 )
{
    return ( angleclamp180( var_0[0] ), angleclamp180( var_0[1] ), angleclamp180( var_0[2] ) );
}

angle_lerp( var_0, var_1, var_2 )
{
    return angleclamp( var_0 + angleclamp180( var_1 - var_0 ) * var_2 );
}

euler_lerp( var_0, var_1, var_2 )
{
    return ( angle_lerp( var_0[0], var_1[0], var_2 ), angle_lerp( var_0[1], var_1[1], var_2 ), angle_lerp( var_0[2], var_1[2], var_2 ) );
}

train_gopath( var_0, var_1, var_2 )
{
    var_3 = 0.052;
    var_4 = spawnstruct();
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_0 = common_scripts\utility::array_combine( [ var_4 ], var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = 1200;

    soundscripts\_snd::snd_message( "play_maglev_train_path" );
    var_5 = 0;

    for ( var_6 = 0; var_6 < var_0.size - 1; var_6++ )
    {
        var_7 = var_0[var_6];
        var_8 = var_0[var_6 + 1];
        var_9 = vectornormalize( var_8.origin - var_7.origin );

        for ( var_10 = distance( var_8.origin, var_7.origin ); var_5 < var_10; var_5 += var_1 * 0.05 )
        {
            var_11 = var_7.origin + var_5 * var_9;
            var_12 = euler_lerp( var_7.angles, var_8.angles, var_5 / var_10 );
            self moveto( var_11, var_3, 0, 0 );
            self rotateto( var_12, var_3, 0, 0 );

            if ( isdefined( var_2 ) )
            {
                var_13 = transformmove( var_11, var_12, ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 48 ), ( 0, 90, 0 ) );
                var_14 = var_13["origin"];
                var_15 = var_13["angles"];
                var_2 moveto( var_14, var_3, 0, 0 );
                var_2 rotateto( var_15, var_3, 0, 0 );
            }

            waitframe();
        }

        var_5 -= var_10;
    }

    if ( isdefined( self.tags ) )
        common_scripts\utility::array_call( self.tags, ::delete );

    self delete();
}

get_door( var_0 )
{
    var_1 = getent( var_0 + "org", "targetname" );
    var_2 = getent( var_0 + "brush", "targetname" );
    var_3 = getent( var_0 + "clip", "targetname" );
    var_4 = var_1 common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_4, "tag_origin" );
    var_3 linkto( var_4, "tag_origin" );
    var_5 = spawnstruct();
    var_5.org = var_1;
    var_5.brush = var_2;
    var_5.hasclip = var_3;
    var_5.tag = var_4;
    return var_5;
}

second_room_nightclub_setup()
{
    thread destroy_the_window_exit();
    thread move_bones_and_joker_up();
    thread exopush_start();
    thread preplaced_guys_function();
    thread advance_bones_and_joker_intro();
    thread setup_street_reunion_spawners();
    thread move_burke_outside_office();
    thread destroy_office_snipe_glass();
    thread temp_clip_delete();
    thread office_2guys_ambush();
    thread break_office_glass_ahead_of_time();
    thread initiate_exo_push_on_sniperguys_dead();
    thread initiate_exo_push_on_player_advance();
    thread last_guy_in_group();
    thread second_floor_snipers();
    thread kill_all_inside_guys_now();
    thread exo_push_combat_manager();
    thread bones_rollout_manager();
    thread exo_push_gourney();
    thread all_exopush_enemies_dead();
}

dead_guy_for_moors()
{
    var_0 = getent( "dead_sniper_spawner", "targetname" );
    var_1 = getent( "dead_sniper_animorg", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_2.animname = "generic";
    var_1 thread maps\_anim::anim_last_frame_solo( var_2, "airport_civ_pillar_exit_death" );
}

destroy_office_snipe_glass()
{
    var_0 = getglass( "snipe_glass" );
    var_1 = getglass( "left_snipe_glass" );
    destroyglass( var_0 );
    destroyglass( var_1 );
}

temp_clip_delete()
{
    var_0 = getent( "temp_window_clip", "targetname" );
    maps\_utility::trigger_wait_targetname( "jump_window_clip_delete" );

    if ( isdefined( var_0 ) )
    {
        var_0 connectpaths();
        var_0 delete();
    }
}

bullets_break_office_glass_gag()
{
    var_0 = getentarray( "office_shooter_org", "targetname" );
    var_1 = getentarray( "office_shooter_target_org", "targetname" );
    maps\_utility::disable_trigger_with_targetname( "office_first_enemy_intro_trigger" );
    maps\_utility::trigger_wait_targetname( "office_shooter_org_moment_trigger" );
    wait 2.3;
    thread bullet_break_glass_gag_timer();

    foreach ( var_3 in var_0 )
        var_3 thread shoot_at_these_targets( var_1 );

    common_scripts\utility::flag_wait( "stop_shoot_org_moment" );
    level notify( "stop_shooting_fake_shots" );
}

shoot_at_these_targets( var_0 )
{
    level endon( "stop_shooting_fake_shots" );

    for (;;)
    {
        var_1 = randomint( var_0.size );
        var_2 = magicbullet( "iw5_bal27_sp", self.origin, var_0[var_1].origin );
        wait(randomfloatrange( 0.1, 0.3 ));
    }
}

sneaky_reload()
{
    var_0 = level.player getcurrentweapon();
    var_1 = level.player getammocount( var_0 );
    var_2 = level.player getcurrentweaponclipammo();
    var_3 = weaponclipsize( var_0 );
    var_4 = var_3 - var_2;
    level.player setweaponammoclip( var_0, var_3 );
    level.player setweaponammostock( var_0, var_1 - var_4 );
}

break_office_glass_ahead_of_time()
{
    var_0 = getglass( "office_glass_break1" );
    var_1 = getglass( "office_glass_break2" );
    destroyglass( var_0 );
    destroyglass( var_1 );
}

office_2guys_ambush()
{
    var_0 = getentarray( "office_spawner_guys_shootingfrom_office", "targetname" );
    maps\_utility::trigger_wait_targetname( "office_shooter_org_moment_trigger" );
    var_1 = getent( "office_ambush_waitvol", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_ai( 1 );
        var_4.goalradius = 15;
        var_4 thread seek_player_on_trigger();
    }
}

seek_player_on_trigger()
{
    self endon( "death" );
    maps\_utility::trigger_wait_targetname( "player_moving_out_area1" );
    wait(randomintrange( 1, 3 ));

    if ( isalive( self ) )
        maps\_utility::player_seek();
}

office_support_after_ambush()
{
    var_0 = getentarray( "office_first_enemy_intro_spawner_DISABLED", "targetname" );
    maps\_utility::trigger_wait_targetname( "office_first_enemy_intro_spawner_zone_trigger" );

    foreach ( var_2 in var_0 )
        var_3 = var_2 maps\_utility::spawn_ai();
}

wait_then_movetogoalvol( var_0 )
{
    common_scripts\utility::flag_wait( "stop_shoot_org_moment" );
    wait(randomfloatrange( 0.8, 1.5 ));

    if ( isalive( self ) )
        self setgoalvolumeauto( var_0 );
}

bullet_break_glass_gag_timer()
{
    wait 4.5;
    common_scripts\utility::flag_set( "stop_shoot_org_moment" );
}

move_burke_outside_office()
{
    common_scripts\utility::flag_wait( "move_burke_down" );
    thread kill_last_sniper_guys();
    level.burke maps\_utility::disable_careful();
    level.burke.goalradius = 15;
    level.burke.ignoreall = 1;
    level.burke maps\_utility::disable_pain();
    var_0 = getnode( "player_parkinglot_startorg", "targetname" );
    level.burke setgoalpos( var_0.origin );
    level.burke waittill( "goal" );
    level.burke.ignoreall = 0;
    level.burke maps\_utility::enable_pain();
}

kill_last_sniper_guys()
{
    var_0 = getentarray( "sniper_setup_guy", "script_noteworthy" );
    maps\_utility::trigger_wait_targetname( "runto_exo_start_trigger" );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
        {
            var_3 = randomint( 3 );
            var_2 maps\detroit::bloody_death( var_3 );
        }

        wait(randomintrange( 1, 2 ));
    }
}

teleport_bones_and_joker()
{
    maps\_utility::trigger_wait_targetname( "spawn_few_nightclub_guys_trigger" );
    var_0 = getnode( "bones_supressed_outside_node_startpoint", "targetname" );
    level.bones maps\_utility::teleport_ai( var_0 );
    level.bones.goalradius = 15;
    wait 0.05;
    var_1 = getnode( "joker_supressed_outside_node_startpoint", "targetname" );
    level.joker maps\_utility::teleport_ai( var_1 );
    level.joker.goalradius = 15;
    level.joker.accuracy = 0;
    level.bones.accuracy = 0;
    level.joker.accuracy = 1;
    level.bones.accuracy = 1;
}

sniper_kva_dead_body()
{
    var_0 = getent( "kva_at_window_spawner_2", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    wait 0.05;
    var_1.nodrop = 1;
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 kill();
}

waittill_enemy_group_size_is( var_0, var_1 )
{
    thread maps\_shg_design_tools::trigger_to_notify( var_1 );
    level endon( var_1 );
    var_2 = self;

    while ( var_2.size > var_0 )
    {
        var_2 = maps\_utility::array_removedead_or_dying( var_2 );
        waitframe();
    }
}

monitor_death_and_reinforce( var_0, var_1 )
{
    var_2 = self;

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_2 waittill( "death" );
        var_4 = common_scripts\utility::random( var_0 );
        var_4.count = 1;
        var_2 = var_4 maps\_utility::spawn_ai( 1 );
        level.alleyway_fight_enemies[level.alleyway_fight_enemies.size] = var_2;
        wait 0.1;
    }

    foreach ( var_4 in var_0 )
        var_4.count = 0;
}

setup_hazmat_intro_allies()
{
    thread burke_reunite_with_player_alley();
}

burke_reunite_with_player_alley()
{
    thread burke_move_into_office();
    var_0 = getent( "intro_alley_hide_spot3", "targetname" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "wall_stack_idle", "move ahead" );
    var_1 = getnode( "burke_take_a_shot_spot", "targetname" );
    common_scripts\utility::flag_wait( "burke_alley_flashlight_off" );
    level notify( "burke_and_player_reunited" );
    var_0 notify( "move ahead" );
    maps\_utility::battlechatter_off( "allies" );
    level.burke stopanimscripted();
    level.burke.ignoreall = 0;
    level.burke maps\_utility::enable_dontevershoot();
    level.burke maps\_utility::enable_cqbwalk();
    level.burke setgoalnode( var_1 );
    common_scripts\utility::flag_set( "vo_alley_burke_reunite" );
    thread spawn_placed_alleyway_guys();
    thread dog_attack_enemies();
    level.burke waittill( "goal" );
    level.burke maps\_utility::disable_cqbwalk();
    common_scripts\utility::flag_set( "vo_alley_burke_patrol" );
    level common_scripts\utility::waittill_any_timeout( 13, "move_allies_up_street1", "second_street_alley_r2" );

    if ( isdefined( getent( "move_allies_up_street1", "targetname" ) ) )
        maps\_utility::disable_trigger_with_targetname( "move_allies_up_street1" );

    if ( common_scripts\utility::flag( "stop_burke_asking_player_to_drop_patrol" ) == 0 )
    {
        common_scripts\utility::flag_set( "vo_alley_burke_too_slow" );
        waitframe();
        level.burke.ignoreall = 0;
        level.burke maps\_utility::clear_generic_run_anim();
        level.burke maps\_utility::enable_careful();
        level.burke maps\_utility::disable_dontevershoot();
        var_2 = getaiarray( "axis" );
        var_3 = 0;

        if ( isdefined( level.burke.enemy ) && isdefined( level.burke.a.aimidlethread ) && level.burke animscripts\utility::canseeenemy( 0 ) )
        {
            level.burke shoot( 1000, level.burke.enemy geteye() );
            level.burke.enemy kill( level.burke geteye(), level.burke );
        }

        common_scripts\utility::flag_set( "_stealth_spotted" );

        if ( isdefined( getent( "move_allies_up_street1", "targetname" ) ) && !isdefined( getent( "move_allies_up_street1", "targetname" ).trigger_off ) )
            maps\_utility::activate_trigger_with_targetname( "move_allies_up_street1" );

        common_scripts\utility::flag_set( "move_allies_up_street1" );
        level notify( "snipe_ambush_fail" );
        common_scripts\utility::flag_set( "stop_burke_asking_player_to_drop_patrol" );
        level.burke.accuracy = 1;
        wait 2;
        level.burke.accuracy = 0.25;
        level notify( "kickoff_street_fight" );
    }

    common_scripts\utility::flag_set( "vo_alley_combat" );
}

burke_move_into_office()
{
    var_0 = getnode( "burke_path_onfoot_bar", "targetname" );
    var_1 = getnode( "burke_path_onfoot_01a", "targetname" );
    common_scripts\utility::flag_wait( "send_burke_to_office_wait_point" );
    common_scripts\utility::flag_wait( "all_street_fighters_dead" );
    common_scripts\utility::flag_set( "sitrep_dialogue_line" );
    level.burke maps\_utility::enable_careful();
    level.burke setgoalnode( var_0 );
    common_scripts\utility::flag_wait( "bar_has_been_cleared" );
    level.burke setgoalnode( var_1 );
}

bar_guy_check_function()
{
    common_scripts\utility::flag_wait( "player_has_entered_the_bar" );

    for (;;)
    {
        var_0 = getentarray( "bar_fighter", "script_noteworthy" );
        var_0 = maps\_utility::remove_dead_from_array( var_0 );

        if ( var_0.size == 0 )
        {
            common_scripts\utility::flag_set( "bar_has_been_cleared" );
            thread barfighters_notify();
            return;
        }

        wait 0.05;
    }
}

street_fighter_check_function()
{
    for (;;)
    {
        var_0 = getentarray( "street_fighters", "script_noteworthy" );
        var_0 = maps\_utility::remove_dead_from_array( var_0 );

        if ( var_0.size == 0 )
        {
            common_scripts\utility::flag_set( "all_street_fighters_dead" );
            return;
        }

        wait 0.05;
    }
}

mitchell_over_here_dialogue()
{
    level endon( "burke_and_player_reunited" );
    maps\_utility::trigger_wait_targetname( "begin_onfoot_street_section" );
    thread onfoot_start_alley_setup();
    common_scripts\utility::flag_set( "obj_reunite_with_burke_pos_reunite" );
    maps\detroit_school::is_player_near_burke( 600 );
    common_scripts\utility::flag_set( "vo_alley_burke_downhere" );
    wait 4;

    if ( distance2d( level.burke.origin, level.player.origin ) > 500 )
        common_scripts\utility::flag_set( "vo_alley_burke_overhere" );
}

first_nightclub_room_setup()
{
    maps\_utility::trigger_wait_targetname( "office_first_enemy_intro_trigger" );
    level notify( "nightclub_started" );
    var_0 = getglass( "skylight_glass_01" );
    var_1 = getent( "skylight_glass_01_org", "targetname" );
    var_2 = getglass( "skylight_glass_02" );
    var_3 = getent( "skylight_glass_02_org", "targetname" );
    var_4 = getglass( "skylight_glass_03" );
    var_5 = getent( "skylight_glass_03_org", "targetname" );
    var_6 = getglass( "skylight_glass_04" );
    var_7 = getent( "skylight_glass_04_org", "targetname" );
    var_8 = getglass( "skylight_glass_05" );
    var_9 = getent( "skylight_glass_05_org", "targetname" );
    var_10 = getglass( "skylight_glass_06" );
    var_11 = getent( "skylight_glass_06_org", "targetname" );
    var_12 = getglass( "skylight_glass_07" );
    var_13 = getent( "skylight_glass_07_org", "targetname" );
    var_14 = getglass( "skylight_glass_08" );
    var_15 = getent( "skylight_glass_08_org", "targetname" );
    var_16 = getglass( "skylight_glass_09" );
    var_17 = getent( "skylight_glass_09_org", "targetname" );
    var_18 = getglass( "skylight_glass_10" );
    var_19 = getent( "skylight_glass_10_org", "targetname" );
    var_20 = getglass( "skylight_glass_11" );
    var_21 = getent( "skylight_glass_11_org", "targetname" );
    var_22 = getglass( "skylight_glass_12" );
    var_23 = getent( "skylight_glass_12_org", "targetname" );
    var_24 = getglass( "skylight_glass_13" );
    var_25 = getent( "skylight_glass_13_org", "targetname" );
    var_26 = getglass( "skylight_glass_14" );
    var_27 = getent( "skylight_glass_14_org", "targetname" );
    var_28 = getglass( "skylight_glass_15" );
    var_29 = getent( "skylight_glass_15_org", "targetname" );
    thread office_glass( var_0, var_1 );
    thread office_glass( var_2, var_3 );
    thread office_glass( var_4, var_5 );
    thread office_glass( var_6, var_7 );
    thread office_glass( var_8, var_9 );
    thread office_glass( var_10, var_11 );
    thread office_glass( var_12, var_13 );
    thread office_glass( var_14, var_15 );
    thread office_glass( var_16, var_17 );
    thread office_glass( var_18, var_19 );
    thread office_glass( var_20, var_21 );
    thread office_glass( var_22, var_23 );
    thread office_glass( var_24, var_25 );
    thread office_glass( var_26, var_27 );
    thread office_glass( var_28, var_29 );
}

office_glass( var_0, var_1 )
{
    level waittillmatch( "glass_destroyed", var_0 );
    soundscripts\_snd::snd_message( "office_skylights_breakable", var_1 );
}

second_nightclub_room_setup()
{
    maps\_utility::trigger_wait_targetname( "office_first_enemy_intro_trigger" );
    thread sniper_kva_dead_body();
}

self_tracking_functions()
{
    thread are_we_close( 500, "begin_first_office_room_fight" );
    am_i_hit();
    i_am_hit_engage();
}

are_we_close( var_0, var_1 )
{
    level endon( var_1 );

    for (;;)
    {
        if ( distance2d( self.origin, level.player.origin ) <= var_0 )
            level notify( var_1 );

        wait 0.05;
    }
}

am_i_hit()
{
    level endon( "begin_first_office_room_fight" );
    var_0 = self.health;

    for (;;)
    {
        if ( var_0 > self.health )
            level notify( "begin_first_office_room_fight" );

        wait 0.1;
    }
}

i_am_hit_engage()
{
    level.player.ignoreme = 0;
    level.burke.ignoreme = 0;
    level.burke.ignoreall = 0;
    maps\detroit_school::remove_patrol_anim_set();
    self.ignoreall = 0;
    self.ignoreme = 0;
}

spawn_few_nightclub_guys()
{
    maps\_utility::trigger_wait_targetname( "spawn_few_nightclub_guys_trigger" );
    thread maps\_utility::autosave_by_name( "seeker" );
    var_0 = getentarray( "office_firstroom_wave1_spawner", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_3 ) )
            var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );

        wait 0.05;
    }
}

goto_goal()
{
    self.ignoreall = 1;
    self waittill( "goal" );
    self.ignreall = 0;
}

exterior_street_kickoff()
{
    thread top_level_kva_guys();
    var_0 = getent( "kva_outside_kickoff_spawner1", "targetname" );
    var_1 = getent( "kva_outside_kickoff_spawner2", "targetname" );
    var_2 = getnode( "guy_1_break_hidenode", "targetname" );
    var_3 = getnode( "guy_2_break_hidenode", "targetname" );
    var_4 = getent( "soldiers_outside_kickoff_talking", "targetname" );
    var_5 = getent( "soldiers_outside_kickoff_talking_2", "targetname" );
    common_scripts\utility::flag_wait( "rendezvous_obj_reached" );
    common_scripts\utility::flag_set( "obj_reunite_with_burke_complete" );
    var_6 = var_0 maps\_utility::spawn_ai( 1 );
    var_7 = var_1 maps\_utility::spawn_ai( 1 );
    var_6.health = 10;
    var_7.health = 10;
    var_6.fovcosine = 0.95;
    var_7.fovcosine = 0.95;
    var_6 setgoalpos( var_4.origin );
    var_7 setgoalpos( var_5.origin );
    var_6 maps\_utility::disable_surprise();
    var_7 maps\_utility::disable_surprise();
    level.burke.ignoreme = 1;
    level.burke maps\_utility::disable_surprise();
    var_6.animname = "generic";
    var_7.animname = "generic";
    var_6 thread maps\detroit::force_patrol_anim_set( "active_right" );
    var_7 thread maps\detroit::force_patrol_anim_set( "active" );
    var_6 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_7 thread maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_6 thread begin_the_street_fight();
    var_7 thread begin_the_street_fight();
    var_6 thread wake_me_up_if_still_alive();
    var_7 thread wake_me_up_if_still_alive();
    var_6 thread combat_state();
    var_7 thread combat_state();
    level.burke thread re_enable_combat();
}

re_enable_combat()
{
    common_scripts\utility::flag_wait( "one_street_guy_dead_kickoff_fight_now" );
    level.burke maps\_utility::disable_dontevershoot();
    level notify( "kickoff_street_fight" );
    maps\_stealth_utility::disable_stealth_system();
}

combat_state()
{
    level endon( "stop_all_combat_state" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.enemy ) || common_scripts\utility::flag( "_stealth_spotted" ) )
        {
            maps\_utility::ent_flag_clear( "_stealth_enabled" );
            common_scripts\utility::flag_set( "one_street_guy_dead_kickoff_fight_now" );
            common_scripts\utility::flag_set( "vo_alley_combat" );
            level notify( "stop_burke_asking_player_to_drop_patrol" );
            level notify( "kickoff_street_fight" );
            maps\_utility::disable_careful();
            maps\detroit_school::remove_patrol_anim_set();
            self notify( "flashlight_off" );
            self notify( "end_patrol" );
            self.alwaysrunforward = undefined;
            level notify( "patrol_alerted" );
            common_scripts\utility::flag_set( "_stealth_spotted" );
            return;
        }

        wait 0.05;
    }
}

wake_me_up_if_still_alive()
{
    while ( isalive( self ) )
    {
        common_scripts\utility::flag_wait( "one_street_guy_dead_kickoff_fight_now" );
        self setgoalpos( self.origin );
        return;
    }
}

begin_the_street_fight()
{
    for (;;)
    {
        common_scripts\utility::waittill_any( "death", "alert", "_stealth_spotted", "damage" );
        level notify( "kickoff_street_fight" );

        if ( !common_scripts\utility::flag( "one_street_guy_dead_kickoff_fight_now" ) )
        {
            if ( isdefined( getent( "move_allies_up_street1", "targetname" ) ) && !isdefined( getent( "move_allies_up_street1", "targetname" ).trigger_off ) )
            {
                maps\_utility::activate_trigger_with_targetname( "move_allies_up_street1" );
                maps\_utility::disable_trigger_with_targetname( "move_allies_up_street1" );
            }

            level.burke maps\_utility::disable_dontevershoot();
            common_scripts\utility::flag_set( "one_street_guy_dead_kickoff_fight_now" );
            common_scripts\utility::flag_set( "move_allies_up_street1" );
            level notify( "kickoff_street_fight" );
            common_scripts\utility::flag_set( "stop_burke_asking_player_to_drop_patrol" );
            common_scripts\utility::flag_set( "vo_alley_combat" );
        }

        return;
    }
}

notify_spotted_player_alleyway()
{
    self endon( "death" );
    common_scripts\utility::waittill_any( "_stealth_spotted", "alert", "spotted_player" );
    maps\detroit_school::remove_patrol_anim_set();
    self notify( "flashlight_off" );
    level notify( "kickoff_street_fight" );
}

seek_player_on_fail()
{
    self endon( "death" );
    level waittill( "snipe_ambush_fail" );
    maps\_utility::set_goal_pos( level.player.origin );
    wait(randomfloatrange( 0.1, 0.4 ));
    thread maps\_utility::player_seek();
}

player_health_check()
{
    level.player endon( "death" );
    level endon( "kickoff_street_fight" );
    level endon( "snipe_ambush_fail" );
    level endon( "snipe_ambush_success" );
    var_0 = level.player.health;

    for (;;)
    {
        if ( var_0 > level.player.health )
            level notify( "kickoff_street_fight" );

        wait 0.05;
    }
}

kickoff_modify()
{
    level waittill( "kickoff_street_fight" );
    maps\_stealth_utility::disable_stealth_system();
    common_scripts\utility::flag_set( "vo_alley_combat" );
    level.burke maps\_utility::disable_cqbwalk();
    level.burke maps\_utility::clear_generic_run_anim();
}

health_track()
{
    var_0 = self.health;

    for (;;)
    {
        if ( self.health < var_0 )
        {
            self stopanimscripted();
            maps\detroit_school::remove_patrol_anim_set();
            return;
        }

        wait 0.05;
    }
}

fail_enable( var_0, var_1 )
{
    level waittill( "snipe_ambush_fail" );

    if ( isalive( self ) )
    {
        self.ignoreall = 0;
        self.ignoreme = 0;
        self notify( "stop_loop" );
        var_0 notify( "stop_loop" );
        maps\_utility::set_moveplaybackrate( 1 );
        self stopanimscripted();
        self setgoalnode( var_1 );
    }
}

top_level_kva_guys()
{
    level waittill( "kickoff_street_fight" );
    wait 7;
    var_0 = getent( "alley_fight_top_rpg_spawner", "targetname" );
    var_1 = getent( "alley_fight_top_ar_spawner", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_2.goalradius = 15;
    var_2.fixednode = 1;
    var_2.combatmode = "no_cover";
    var_3 = var_1 maps\_utility::spawn_ai( 1 );
    var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_3.fixednode = 1;
    var_3.goalradius = 15;
}

street_train_function()
{
    level endon( "nightclub_started" );
    var_0 = randomintrange( 900, 1700 );

    for (;;)
    {
        spawn_street_train( var_0 );
        wait(randomintrange( 8, 16 ));

        if ( common_scripts\utility::flag( "hospital_escape_trains_only" ) )
            return;
    }
}

reverse_street_train_function()
{
    level endon( "nightclub_started" );
    var_0 = randomintrange( 900, 1700 );

    for (;;)
    {
        spawn_reverse_street_train( var_0 );
        wait(randomintrange( 8, 16 ));

        if ( common_scripts\utility::flag( "hospital_escape_trains_only" ) )
            return;
    }
}

street_fight_after_snipe()
{
    level waittill( "kickoff_street_fight" );
    level.burke maps\_utility::disable_cqbwalk();
    thread first_guy_looking();
    wait 6;
    thread outside_group_1();
    thread maps\_utility::autosave_by_name( "seeker" );
}

spawn_placed_alleyway_guys()
{
    var_0 = getentarray( "enemyspawn_onfoot_intro_placed", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_4 = var_3.combatmode;
        var_3.combatmode = "no_cover";
        var_3 thread activate_guy();
        var_3 thread kickoff_notify();
        var_3 thread break_from_ignoreall();
        var_3 thread stealth_guy_think_on_flag();
    }

    street_fighter_check_function();
}

stealth_guy_think_on_flag()
{
    self endon( "death" );
    maps\detroit_school::stealth_guy_think();
    common_scripts\utility::flag_wait( "rendezvous_obj_reached" );
}

kickoff_notify()
{
    common_scripts\utility::waittill_any( "damage", "_stealth_spotted", "spotted_player", "death" );
    level notify( "kickoff_street_fight" );
    common_scripts\utility::flag_set( "_stealth_spotted" );
}

break_from_ignoreall()
{
    self endon( "death" );
    level waittill( "kickoff_street_fight" );
    self.ignoreall = 0;
}

dog_attack_enemies()
{
    level waittill( "kickoff_street_fight" );
    var_0 = getent( "dog_spawner_1", "targetname" );
    var_1 = getentarray( "dog_spawner_2", "targetname" );
    var_2 = var_0 maps\_utility::spawn_ai( 1 );
    var_2 thread maps\_utility::player_seek();
    wait 3;

    foreach ( var_4 in var_1 )
    {
        var_5 = var_4 maps\_utility::spawn_ai( 1 );
        var_5 thread maps\_utility::player_seek();
    }

    common_scripts\utility::flag_wait( "hide_and_seek" );
    var_7 = getent( "last_dog_spawner", "targetname" );
    var_8 = var_7 maps\_utility::spawn_ai( 1 );
    var_8 thread maps\_utility::player_seek();
}

temp_dog_sfx()
{
    self endon( "death" );

    for (;;)
    {
        wait(randomintrange( 0, 3 ));
        soundscripts\_snd::snd_message( "temp_dog_bark", self );
        wait(randomintrange( 3, 5 ));
    }
}

activate_guy()
{
    self endon( "death" );
    level waittill( "kickoff_street_fight" );
    self stopanimscripted();
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.combatmode = "cover";
    group_wait_seek_player( 2, "street_fighters" );
}

group_wait_seek_player( var_0, var_1 )
{
    for (;;)
    {
        var_2 = getentarray( var_1, "script_noteworthy" );

        if ( var_2.size < var_0 )
            maps\_utility::player_seek();

        wait 0.05;
    }
}

bar_setup()
{
    thread bar_guys_waiting();
    var_0 = getentarray( "kva_barcombat_spawner_group", "targetname" );
    var_1 = getent( "nighthawks_vol", "targetname" );
    common_scripts\utility::flag_wait( "move_allies_up_street1" );

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3 maps\_utility::spawn_ai();
        var_4 setgoalvolumeauto( var_1 );
        var_4 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    }

    thread bar_guy_check_function();
}

bar_guys_waiting()
{
    common_scripts\utility::flag_wait( "move_allies_up_street1" );
    thread burke_move_through_alley_cover();
    thread maps\detroit::battle_chatter_on_both();
    var_0 = getent( "kva_barcombat_animspawn1", "targetname" );
    var_1 = getent( "kva_barcombat_animspawn2", "targetname" );
    var_2 = getnode( "burke_path_onfoot_01a", "targetname" );
    var_3 = var_0 maps\_utility::spawn_ai( 1 );
    var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_4 = var_1 maps\_utility::spawn_ai( 1 );
    var_4 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    var_3.ignoreall = 1;
    var_3.ignoreme = 1;
    var_4.ignoreall = 1;
    var_4.ignoreme = 1;
    common_scripts\utility::flag_wait( "hide_and_seek" );

    if ( isalive( var_3 ) )
    {
        var_3.ignoreall = 0;
        var_3.ignoreme = 0;
    }

    if ( isalive( var_4 ) )
    {
        var_4.ignoreall = 0;
        var_4.ignoreme = 0;
    }
}

first_guy_looking()
{
    var_0 = getent( "alley_spotlight_guy_vol", "targetname" );
    var_1 = getent( "first_cover_streetfight_spotlighter", "targetname" );
    wait 0.3;
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2 setgoalvolumeauto( var_0 );
    var_2 endon( "death" );
    var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    var_2 maps\detroit::set_patrol_anim_set( "active" );
    var_2 maps\_utility::set_moveplaybackrate( 1.5 );
    wait 4;
    var_2 thread return_to_normal();
    var_2.ignoreall = 0;
    level notify( "flashlight_off" );
}

return_to_normal()
{
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::set_moveplaybackrate( 1 );
    maps\_utility::clear_run_anim();
    self allowedstances( "stand", "crouch", "prone" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    self stopanimscripted();
    self notify( "stop_animmode" );
    self notify( "flashlight_off" );
    self.script_nobark = undefined;
}

top_guy_spawn()
{
    level endon( "AI_broken_out" );
    level endon( "searching_alleyway_guy_is_dead" );
    var_0 = getent( "exterior_investigate_animorg", "targetname" );
    var_1 = getent( "investigation spawner", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    waitframe();
    var_2.animname = "generic";
    var_2.ignoreall = 1;
    var_0 maps\_anim::anim_reach_solo( var_2, "so_hijack_search_flashlight_high_loop_single" );
    thread break_out_if_damaged( var_2 );
    var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );
    var_0 thread maps\_anim::anim_single_solo( var_2, "so_hijack_search_flashlight_high_loop_single" );
    wait 2;

    if ( isalive( var_2 ) )
    {
        var_2 notify( "flashlight_off" );
        var_2.ignoreall = 0;
        var_2 stopanimscripted();
        thread spawn_the_rest();
    }
}

break_out_if_damaged( var_0 )
{
    var_0 endon( "death" );
    var_1 = var_0.health;

    for (;;)
    {
        if ( var_0.health < var_1 )
        {
            wait 0.4;
            var_0.ignoreall = 0;
            var_0 stopanimscripted();
            level notify( "AI_broken_out" );
            level notify( "searching_alleyway_guy_is_dead" );
            self notify( "flashlight_off" );
            return;
        }

        wait 0.05;
    }
}

spawn_the_rest()
{

}

outside_group_1()
{
    var_0 = getentarray( "kva_streetcombat_spawner_group", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3.goalradius = 15;
        var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
    }
}

outside_group_start_fighting()
{
    level waittill( "kickoff_street_fight" );
    self stopanimscripted();
    self.ignoreall = 0;
    self.ignoreme = 0;
}

battle_chatter_check_alley()
{
    level waittill( "partner_shot" );
    thread maps\detroit::battle_chatter_on_both();
}

burke_move_through_alley_cover()
{
    common_scripts\utility::flag_wait( "second_street_alley_r2" );
    wait 0.05;

    if ( isdefined( getent( "second_street_alley_r2", "targetname" ) ) )
        maps\_utility::disable_trigger_with_targetname( "second_street_alley_r2" );

    common_scripts\utility::flag_wait( "path_trigger_05" );
    wait 0.05;

    if ( isdefined( getent( "path_trigger_05", "targetname" ) ) )
        maps\_utility::disable_trigger_with_targetname( "path_trigger_05" );

    common_scripts\utility::flag_wait( "hide_and_seek" );
    thread street_fighters_gone_yet();
    wait 0.05;

    if ( isdefined( getent( "hide_and_seek", "targetname" ) ) )
        maps\_utility::disable_trigger_with_targetname( "hide_and_seek" );

    common_scripts\utility::flag_wait( "bar_interior_trigger" );
    common_scripts\utility::flag_set( "player_has_entered_the_bar" );
    level notify( "street_fighting_over" );
    thread kill_all_streetfighters();
    wait 0.05;
}

street_fighters_gone_yet()
{
    level endon( "street_fighting_over" );

    for (;;)
    {
        var_0 = getentarray( "street_fighters", "script_noteworthy" );
        var_0 = maps\_utility::remove_dead_from_array( var_0 );

        if ( var_0.size == 0 )
        {
            var_1 = getnode( "burke_inner_barnode", "targetname" );
            level.burke setgoalnode( var_1 );
            thread streetfighters_notify();
            return;
        }

        wait 0.05;
    }
}

kill_all_streetfighters()
{
    var_0 = getentarray( "street_fighters", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 thread random_bloody_death( 0.5 );
}

streetfighters_notify()
{
    common_scripts\utility::flag_set( "move_allies_up_street1" );
    common_scripts\utility::flag_set( "second_street_alley_r2" );
    common_scripts\utility::flag_set( "path_trigger_05" );
    common_scripts\utility::flag_set( "hide_and_seek" );
}

barfighters_notify()
{
    common_scripts\utility::flag_set( "move_allies_up_street1" );
    common_scripts\utility::flag_set( "second_street_alley_r2" );
    common_scripts\utility::flag_set( "path_trigger_05" );
    common_scripts\utility::flag_set( "hide_and_seek" );

    if ( isdefined( getent( "bar_interior_trigger", "targetname" ) ) && !isdefined( getent( "bar_interior_trigger", "targetname" ).trigger_off ) )
        maps\_utility::activate_trigger_with_targetname( "bar_interior_trigger" );

    common_scripts\utility::flag_set( "bar_interior_trigger" );
    wait 0.05;
}

guy1_reach_wait()
{
    self endon( "death" );
    level endon( "partner_shot" );
    var_0 = getent( "soldiers_outside_kickoff_talking", "targetname" );
    self waittill( "goal" );
    self notify( "flashlight_off" );
    self.allowdeath = 1;
    var_0 thread maps\_anim::anim_loop_solo( self, "talking_guard_1", "guards_stop_talking" );
}

guy2_reach_wait()
{
    self endon( "death" );
    level endon( "partner_shot" );
    var_0 = getent( "soldiers_outside_kickoff_talking_2", "targetname" );
    self waittill( "goal" );
    self notify( "flashlight_off" );
    var_0 thread maps\_anim::anim_loop_solo( self, "talking_guard_2", "guards_stop_talking" );
}

setup_guy_for_animation( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
    {
        self.animname = "generic";

        if ( var_0 == 1 )
            self.ignoreall = 1;

        if ( var_1 == 1 )
            self.ignoreme = 1;

        self.goalradius = 15;

        if ( var_2 == 1 )
            maps\detroit_lighting::add_enemy_flashlight( "flashlight", "med" );

        if ( var_3 == 1 )
            maps\detroit::set_patrol_anim_set( "active" );

        if ( var_3 == 0 )
            maps\detroit::set_patrol_anim_set( "gundown" );
    }
}

setup_animated_guy()
{
    if ( isdefined( self ) )
    {
        self.animname = "generic";
        self.ignoreall = 1;
        self.goalradius = 15;
        maps\_utility::set_moveplaybackrate( 0.8 );
    }
}

spawn_street_train( var_0 )
{
    if ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        var_1 = getent( "street_train1_path_start", "targetname" );
        var_2 = getentarray( "street_train1_path", "targetname" );
        var_3 = maps\detroit_exit_drive::run_train( var_1, var_2, var_0 );
        var_3 waittill( "death" );
    }
}

spawn_reverse_street_train( var_0 )
{
    if ( !common_scripts\utility::flag( "hospital_escape_trains_only" ) )
    {
        var_1 = getent( "street_train2_path_start", "targetname" );
        var_2 = getentarray( "school_train2_path", "targetname" );
        var_3 = maps\detroit_exit_drive::run_train( var_1, var_2, var_0 );
        var_3 waittill( "death" );
    }
}

initiate_exo_push_on_sniperguys_dead()
{
    level endon( "stop_tracking_sniperguys" );
    common_scripts\utility::flag_wait( "start_tracking_sniper_deaths" );
    var_0 = getentarray( "sniper_setup_guy", "script_noteworthy" );
    maps\_utility::waittill_dead_or_dying( var_0 );
    maps\_utility::activate_trigger_with_targetname( "runto_exo_start_trigger" );
    level notify( "time to stop shooting the roof" );
    level notify( "time to stop shooting the ambulance" );
    common_scripts\utility::flag_set( "window_ambush_flag" );
}

initiate_exo_push_on_player_advance()
{
    common_scripts\utility::flag_wait( "exo_push_spawner_scaffolding_trigger" );
    level notify( "stop_tracking_sniperguys" );
    maps\_utility::activate_trigger_with_targetname( "runto_exo_start_trigger" );
    level notify( "time to stop shooting the roof" );
    level notify( "time to stop shooting the ambulance" );
    common_scripts\utility::flag_set( "window_ambush_flag" );
}

second_floor_snipers()
{
    var_0 = getentarray( "sniper_setup_spawner", "targetname" );
    common_scripts\utility::flag_wait( "spawn_second_floor_spawners" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai();

        if ( isalive( var_3 ) )
        {
            var_3.custom_laser_function = ::detroit_laser;
            var_3 thread maps\_utility::disable_long_death();
            var_3 thread kill_when_player_reaches_overhang();
            var_3 thread kill_off_inside_guy();
        }
    }
}

kill_all_inside_guys_now()
{
    common_scripts\utility::flag_wait( "begin_spawning_troops_hospital" );
    var_0 = getentarray( "inside_guy_killme", "script_noteworthy" );
    var_0 = maps\_utility::array_removedead( var_0 );

    foreach ( var_2 in var_0 )
    {
        if ( isalive( var_2 ) )
            var_2 kill();
    }

    var_4 = getnode( "gideon_cheat_teleport_spot", "targetname" );
    var_5 = getnode( "kva_at_window_guy1_cover1", "targetname" );
    var_6 = getent( "gideon_outside_check_vol", "targetname" );

    if ( distance2d( level.burke.origin, var_5.origin ) > 400 )
    {
        if ( level.burke istouching( var_6 ) )
            return;
        else
        {
            level.burke maps\_utility::teleport_ai( var_4 );
            var_7 = getnode( "burke_rendezvous_animnode", "targetname" );
            level.burke setgoalnode( var_7 );
        }
    }
}

kill_when_player_reaches_overhang()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "move_burke_down" );
    wait(randomfloatrange( 1.2, 2.4 ));
    maps\detroit::bloody_death();
}

detroit_laser()
{
    self laseron( "lag_snipper_laser" );
}

last_guy_in_group()
{
    common_scripts\utility::flag_wait( "start_tracking_sniper_deaths" );
    var_0 = getentarray( "sniper_setup_guy", "script_noteworthy" );
    var_1 = [];

    for (;;)
    {
        foreach ( var_3 in var_0 )
        {
            if ( isalive( var_3 ) )
                var_1[var_1.size] = var_3;
        }

        if ( var_1.size == 1 )
        {
            common_scripts\utility::flag_set( "move_to_be_killed" );
            var_1 = maps\_utility::remove_dead_from_array( var_1 );
            var_1[0] thread move_to_death_spot();
            return;
        }

        var_1 = [];
        wait 0.5;
    }
}

move_to_death_spot()
{
    self endon( "death" );
    wait(randomfloatrange( 0.2, 0.8 ));
    var_0 = getnode( "last_node_to_hide", "targetname" );
    self.ignoreall = 1;
    self.goalradius = 15;
    thread kill_me_in_x_seconds( 5 );
    self setgoalnode( var_0 );
    self waittill( "goal" );
    self.ignoreall = 0;
}

kill_me_in_x_seconds( var_0 )
{
    wait(var_0);

    if ( isalive( self ) )
        maps\detroit::bloody_death();
}

begin_exo_push( var_0 )
{
    common_scripts\utility::flag_wait_any( "ok_to_start_exo_push", "exo_push_spawner_scaffolding_trigger" );
    level.burke thread maps\_utility::disable_cqbwalk();

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    soundscripts\_snd::snd_message( "begin_exo_push" );
    thread begin_spawnning_exo_spawners();
    thread back_line_of_fire();
    thread second_line_of_fire();
    thread stage1_ambush();
    thread stage2_ambush();
    thread bloody_death_all_survivors();
    thread back_fake_bullets();
    thread end_ambulance_anim_early();
    thread exo_push_hospital_callout();
    thread player_is_pushing_rumble();
    common_scripts\utility::flag_set( "obj_exo_push_give" );
    var_1 = getent( "exo_push_ambulance", "targetname" );
    level.truck = var_1;
    var_2 = getent( "exo_push_first_animorg", "targetname" );
    playfxontag( common_scripts\utility::getfx( "det_exo_push_sparks" ), var_1, "TAG_WHEEL_FRONT_RIGHT" );
    var_1 thread truck_distance_to_end();
    var_3 = getent( "exo_push_player_trigger", "targetname" );
    var_4 = getent( "exo_push_team_goalorg_joker", "targetname" );
    var_5 = getent( "exo_push_team_goalorg_bones", "targetname" );
    var_6 = getent( "exo_push_team_goalorg_burke", "targetname" );
    var_3 enablelinkto();
    var_3 linkto( var_1, "tag_origin", ( -140, -40, 30 ), ( 0, 0, 0 ) );
    thread exo_push_think_burke( var_1, var_2, var_0 );
    thread exo_push_think_truck( var_1, var_2 );
    var_7 = maps\_utility::spawn_anim_model( "world_body", level.player.origin );
    var_1 maps\_anim::anim_first_frame_solo( var_7, "exo_push_attach", "tag_driver" );
    var_7 linkto( var_1, "tag_driver" );
    var_7 hide();
    level.burke maps\_utility::set_ignoresuppression( 1 );
    level.burke maps\_utility::disable_pain();
    level.joker maps\_utility::set_ignoresuppression( 1 );
    level.joker maps\_utility::disable_pain();
    level.bones maps\_utility::set_ignoresuppression( 1 );
    level.bones maps\_utility::disable_pain();
    var_8 = 1;

    while ( !common_scripts\utility::flag( "exo_push_arrived" ) )
    {
        if ( !common_scripts\utility::flag( "exo_push_burke_attaching" ) )
        {
            common_scripts\utility::flag_wait( "exo_push_burke_attaching" );
            wait 3.5;
        }

        var_3 sethintstring( &"DETROIT_PROMPT_PUSH" );
        var_3 makeusable();
        var_3 thread disable_me_when_exopush_finished();
        var_3 waittill( "trigger" );
        common_scripts\utility::flag_set( "exo_push_has_been_started" );
        var_9 = 0.5;
        var_7 hide();
        level.player playerlinktoblend( var_7, "tag_player", var_9, 0.25, 0.25 );
        var_3 makeunusable();
        var_3 sethintstring( "" );
        level.player maps\_shg_utility::setup_player_for_scene( 1 );
        var_7 show();
        common_scripts\utility::flag_set( "exo_push_player_attached" );
        soundscripts\_snd::snd_message( "ambulance_push_attach", "exo_push_player_attached" );
        var_1 setanimrestart( var_1 maps\_utility::getanim( "exo_push_attach" ) );
        var_1 maps\_anim::anim_single_solo( var_7, "exo_push_attach", "tag_driver" );
        var_1 clearanim( var_1 maps\_utility::getanim( "exo_push_attach" ), 0.2 );
        var_1 setanimrestart( var_1 maps\_utility::getanim( "exo_push_idle" )[0] );
        common_scripts\utility::flag_set( "exo_push_should_idle" );
        thread exo_push_think_player_attached( var_1, var_7 );

        while ( common_scripts\utility::flag( "exo_push_should_idle" ) || common_scripts\utility::flag( "exo_push_should_push" ) )
        {
            var_10 = level.player getnormalizedmovement()[0];

            if ( level.player usebuttonpressed() )
            {
                common_scripts\utility::flag_set( "exo_push_should_push" );
                common_scripts\utility::flag_set( "van_pushed_atlaest_once" );
                common_scripts\utility::flag_clear( "exo_push_should_idle" );
                var_1 soundscripts\_snd::snd_message( "ambulance_push_active" );
            }
            else
            {
                common_scripts\utility::flag_clear( "exo_push_should_push" );
                common_scripts\utility::flag_clear( "exo_push_should_idle" );
                var_1 soundscripts\_snd::snd_message( "ambulance_push_step_away" );
                common_scripts\utility::flag_clear( "aud_ambulance_pushing" );
            }

            if ( common_scripts\utility::flag( "exo_push_arrived" ) || !isalive( level.player ) )
            {
                common_scripts\utility::flag_clear( "exo_push_should_push" );
                common_scripts\utility::flag_clear( "exo_push_should_idle" );
                var_1 soundscripts\_snd::snd_message( "ambulance_push_sequence_end" );
                common_scripts\utility::flag_clear( "aud_ambulance_pushing" );
                break;
            }

            wait 0.05;
        }

        common_scripts\utility::flag_clear( "exo_push_player_attached" );
        level.player common_scripts\utility::delaycall( 0.25, ::enableweapons );
        var_1 maps\_anim::anim_single_solo( var_7, "exo_push_detach", "tag_driver" );
        level.player unlink();
        var_11 = getgroundposition( level.player.origin, 16 )[2] - level.player.origin[2];

        if ( var_11 > 1 )
            level.player setorigin( level.player.origin + ( 0, 0, var_11 ) );

        level.player maps\_shg_utility::setup_player_for_gameplay();
        var_7 hide();
    }

    common_scripts\utility::flag_set( "vo_exo_push_entry_point" );
    level.burke maps\_utility::set_ignoresuppression( 0 );
    level.burke maps\_utility::enable_pain();
    level.joker maps\_utility::set_ignoresuppression( 0 );
    level.joker maps\_utility::enable_pain();
    level.bones maps\_utility::set_ignoresuppression( 0 );
    level.bones maps\_utility::enable_pain();
    var_3 delete();
    var_7 delete();
}

disable_me_when_exopush_finished()
{
    while ( isdefined( self ) )
    {
        common_scripts\utility::flag_wait( "exo_push_arrived" );
        self makeunusable();
        return;
    }
}

on_alert_chase_player()
{
    while ( isalive( self ) )
    {
        level waittill( "chase_the_player_now" );
        iprintlnbold( "Time to fight the player nowc" );
        self setgoalpos( level.player.origin );
        return;
    }
}

on_alert_notify_level()
{
    while ( isalive( self ) )
    {
        common_scripts\utility::waittill_any( "_stealth_spotted", "damage", "alert" );
        level notify( "chase_the_player_now" );
        iprintlnbold( "I am alert" );
        return;
    }
}

player_is_pushing_rumble()
{
    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_arrived" ) )
            return;

        if ( common_scripts\utility::flag( "exo_push_should_push" ) )
        {
            var_0 = level.player maps\_utility::get_rumble_ent( "steady_rumble" );
            var_0 maps\_utility::set_rumble_intensity( 0.24 );

            while ( common_scripts\utility::flag( "exo_push_should_push" ) )
                wait 0.05;

            var_0 stoprumble( "steady_rumble" );
            var_0 delete();
        }

        wait 0.05;
    }
}

exo_push_hospital_callout()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    common_scripts\utility::flag_set( "vo_exo_push_entry_point" );
}

end_the_exopush_even_if_never_pushed()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );

    if ( !common_scripts\utility::flag( "van_pushed_atlaest_once" ) )
        level.burke stopanimscripted();
}

ambulance_objective_update()
{
    common_scripts\utility::flag_wait( "office_ambulance_reached" );
    common_scripts\utility::flag_set( "obj_rendezvous_joker_complete" );
}

ambulance_firstframe_function()
{
    if ( level.currentgen && !issubstr( level.transient_zone, "middle" ) )
        level waittill( "tff_post_intro_to_middle" );

    var_0 = getent( "exo_push_ambulance", "targetname" );
    var_1 = [ "tag_rooflight_tkl", "tag_rooflight_tkr", "tag_rooflight_tl", "tag_rooflight_tr", "tag_siren_f", "tag_roof" ];
    var_2 = [ "tag_rooflight_tkl_d", "tag_rooflight_tkr_d", "tag_rooflight_tl_d", "tag_rooflight_tr_d", "tag_siren_f_d", "tag_roof_d" ];

    foreach ( var_4 in var_2 )
        var_0 hidepart( var_4 );

    var_6 = getent( "exo_push_first_animorg", "targetname" );
    var_0.animname = "ambulance";
    var_0 maps\_utility::assign_animtree();
    var_0 setcandamage( 1 );

    for ( var_7 = 0; var_7 < 4; var_7++ )
        var_0 thread ambulance_part_monitor( var_1[var_7], var_2[var_7], 100 );

    var_0 thread ambulance_part_monitor( var_1[4], var_2[4], 200 );
    var_0 thread ambulance_part_monitor( var_1[5], var_2[5], 500, 1 );
    var_0 thread ambulance_max_health();
    var_0.health = 10000;
    var_8 = getent( "exo_brush_clip_nosight", "targetname" );
    var_8 linkto( var_0, "tag_driver" );
    var_9 = getent( "exo_push_team_goalorg_joker", "targetname" );
    var_10 = getent( "exo_push_team_goalorg_bones", "targetname" );
    var_11 = getent( "exo_push_team_goalorg_burke", "targetname" );
    var_0 thread exo_objective_use_prompt();
    var_10 linkto( var_0, "tag_origin" );
    var_9 linkto( var_0, "tag_origin" );
    var_11 linkto( var_0, "tag_origin" );
    var_12 = getentarray( "exopush_shooter_org_target", "targetname" );

    foreach ( var_14 in var_12 )
        var_14 linkto( var_0, "tag_origin" );

    var_6 thread maps\_anim::anim_first_frame_solo( var_0, "exo_push_burke_attach" );
    common_scripts\utility::flag_set( "ok_to_start_exo_push" );
}

exo_objective_use_prompt()
{
    common_scripts\utility::flag_wait( "send_bones_joker_to_cover1" );
    var_0 = getent( "exo_push_player_trigger", "targetname" );
    var_1 = level.truck.origin;
    var_1 += level.truck_org_cords;
    var_0.origin = var_1;
    var_2 = getent( "exo_push_ambulance", "targetname" );
    var_3 = var_2.origin + level.truck_org_cords;
    var_4 = var_0 maps\_shg_utility::hint_button_position( "use", var_3, undefined, 200, undefined, var_0 );
    var_4 thread close_me_when_exopush_over();
    maps\_shg_design_tools::waittill_trigger_with_name( "exo_push_player_trigger" );

    if ( isdefined( var_4 ) )
        var_4 maps\_shg_utility::hint_button_clear();
}

close_me_when_exopush_over()
{
    while ( isdefined( self ) )
    {
        common_scripts\utility::flag_wait( "exo_push_arrived" );

        if ( isdefined( self ) )
            maps\_shg_utility::hint_button_clear();
    }
}

ambulance_part_monitor( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( isdefined( var_3 ) && var_3 )
        {
            if ( damage_is_explosive( var_8 ) )
            {
                ambulance_damage_part( var_0, var_1 );
                return;
            }
        }
        else
        {
            if ( var_11 == var_0 || var_11 == var_1 )
                var_2 -= var_4;

            if ( var_2 <= 0 )
            {
                ambulance_damage_part( var_0, var_1 );
                return;
            }
        }
    }
}

ambulance_max_health()
{
    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
        self.health = self.maxhealth;
    }
}

damage_is_explosive( var_0 )
{
    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "splash":
        case "mod_explosive":
        case "mod_projectile_splash":
        case "mod_projectile":
        case "mod_grenade_splash":
        case "mod_grenade":
            return 1;
        default:
            return 0;
    }
}

ambulance_damage_part( var_0, var_1 )
{
    self hidepart( var_0 );
    self showpart( var_1 );
}

second_line_of_fire()
{
    common_scripts\utility::flag_wait( "begin_spawning_troops_hospital" );
    level endon( "stop_spawning_second_line_guys" );
    var_0 = "second_line_of_fire";
    level.secondguysalive = 0;
    level.secondguys_total = 9;

    for ( var_1 = 0; var_1 < 2; var_1++ )
    {
        wait(randomfloat( 3.0 ));
        spawn_a_second_line_guy( var_0 );
    }
}

spawn_a_second_line_guy( var_0 )
{
    level endon( "stop_second_line_spawner" );

    if ( common_scripts\utility::flag( "exo_push_arrived" ) )
        return;

    if ( level.secondguys_total <= 0 )
    {
        common_scripts\utility::flag_set( "secondline_guys_killed" );
        level notify( "stop_second_line_spawner" );
        return;
    }

    if ( !common_scripts\utility::flag( "send_bones_joker_to_cover1" ) )
    {
        var_1 = getent( "exo_push_spawner_hospital", "targetname" );
        var_1.count = 1;
        var_2 = getent( "exo_push_secondline_vol", "targetname" );
        wait(randomfloat( 1.1 ));
        var_3 = var_1 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_3 ) )
        {
            level.secondguysalive++;
            level.secondguys_total--;
            var_3.radius = 15;
            var_3 thread accuracy_fake_function();
            var_3.grenadeammo = 0;
            var_3.meleeattackdist = 0;
            var_3 setgoalvolumeauto( var_2 );
            var_3 thread secondline_alive_check( var_0 );
            var_3 thread seekplayercheck();
            var_3 thread secondline_flee_check();
            var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            var_3 thread kill_me_on_flag( "exo_push_phase1_complete" );
        }
    }

    if ( common_scripts\utility::flag( "send_bones_joker_to_cover1" ) )
    {
        var_1 = getent( "exo_push_spawner_hospital", "targetname" );
        var_1.count = 1;
        var_2 = getent( "secondline_last_volume", "targetname" );
        wait(randomfloat( 1.1 ));
        var_3 = var_1 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_3 ) )
        {
            level.secondguysalive++;
            level.secondguys_total--;
            var_3.radius = 15;
            var_3 thread accuracy_fake_function();
            var_3.grenadeammo = 0;
            var_3.meleeattackdist = 0;
            var_3 setgoalvolumeauto( var_2 );
            var_3 thread secondline_alive_check( var_0 );
            var_3 thread seekplayercheck();
            var_3 thread secondline_flee_check();
            var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            var_3 thread kill_me_on_flag( "exo_push_phase1_complete" );
        }
    }
}

kill_me_on_flag( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );
    wait(randomfloatrange( 0.3, 0.8 ));

    if ( isalive( self ) )
        maps\detroit::bloody_death();
}

truck_distance_to_end()
{
    var_0 = getnode( "joker_hospital", "targetname" );
    var_1 = 1;
    var_2 = 1;

    while ( var_1 == 1 )
    {
        var_3 = distance2d( self.origin, var_0.origin );

        if ( var_3 < 900 )
        {
            common_scripts\utility::flag_set( "send_exopush_secondline_into_hospital" );
            var_1 = 0;
        }

        wait 1;
    }

    while ( var_2 == 1 )
    {
        var_3 = distance2d( self.origin, var_0.origin );

        if ( var_3 < 600 )
        {
            common_scripts\utility::flag_set( "send_exopush_guys_into_hospital" );
            var_2 = 0;
            return;
        }

        wait 1;
    }
}

seekplayercheck()
{
    wait(randomfloatrange( 12.0, 18.0 ));

    if ( isalive( self ) )
    {
        var_0 = randomint( 3 );

        if ( var_0 > 1 )
            maps\_utility::player_seek();
    }
}

secondline_alive_check( var_0 )
{
    level endon( "stop_spawning_second_line_guys" );
    self waittill( "death" );
    level.secondguysalive--;

    if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
    {
        wait(randomfloat( 4.0 ));

        if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
            thread spawn_a_second_line_guy( var_0 );
    }
}

back_line_of_fire()
{
    common_scripts\utility::flag_wait( "begin_spawning_troops_hospital" );
    level endon( "stop_spawning_backline_guys" );
    var_0 = "back_line_of_fire";
    level.backlineguysalive = 0;
    level.backlineguys_total = 11;

    for ( var_1 = 0; var_1 < 5; var_1++ )
        spawn_a_backline_guy( var_0 );
}

spawn_a_backline_guy( var_0 )
{
    if ( !common_scripts\utility::flag( "exo_push_arrived" ) )
    {
        var_1 = getent( "exo_push_spawner_hospital", "targetname" );
        var_1.count = 1;
        var_2 = getent( "back_lineoffire_vol", "targetname" );
        wait(randomfloat( 1.1 ));
        var_3 = var_1 maps\_utility::spawn_ai( 1 );

        if ( level.backlineguys_total <= 0 )
        {
            common_scripts\utility::flag_set( "backline_guys_alldead" );
            return;
        }

        if ( isalive( var_3 ) )
        {
            level.backlineguysalive++;
            level.backlineguys_total--;
            var_3.grenadeammo = 0;
            var_3.meleeattackdist = 0;
            var_3 thread accuracy_fake_function();
            var_3.radius = 15;
            var_3 setgoalvolumeauto( var_2 );
            var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            var_3 thread backline_alive_check( var_0 );
            var_3 thread backline_flee_check();
        }
    }
}

stage1_ambush()
{
    var_0 = getent( "exo_push_spawner_hospital_ambush_ar", "targetname" );
    common_scripts\utility::flag_wait( "exo_push_phase1_complete" );

    for ( var_1 = 0; var_1 < 1; var_1++ )
    {
        var_0.count = 1;
        var_2 = var_0 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_2 ) )
        {
            var_2.grenadeammo = 0;
            var_2.meleeattackdist = 0;
            var_2 thread accuracy_fake_function();
            var_2 thread maps\_utility::player_seek();
            var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            wait(randomfloatrange( 0.5, 2.0 ));
        }
    }
}

stage2_ambush()
{
    var_0 = getent( "exo_push_spawner_hospital_alcove", "targetname" );
    common_scripts\utility::flag_wait( "exo_push_phase2_complete" );

    for ( var_1 = 0; var_1 < 2; var_1++ )
    {
        var_0.count = 1;
        var_2 = var_0 maps\_utility::spawn_ai( 1 );
        var_2 thread maps\_utility::player_seek();
        var_2 thread accuracy_fake_function();
        var_2 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
        wait(randomfloatrange( 0.5, 2.0 ));
    }
}

backline_flee_check()
{
    self endon( "death" );
    var_0 = getent( "hospital_fight_goal1", "targetname" );
    common_scripts\utility::flag_wait_any( "exo_push_arrived", "send_exopush_guys_into_hospital" );

    if ( isalive( self ) )
    {
        self setgoalvolumeauto( var_0 );
        thread exopush_end_flee();
        self waittill( "goal" );
    }

    if ( isdefined( self ) )
        maps\detroit::bloody_death( randomint( 2 ) );
}

secondline_flee_check()
{
    self endon( "death" );
    var_0 = getent( "hospital_fight_goal1", "targetname" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "send_exopush_secondline_into_hospital" ) )
        {
            if ( isdefined( self ) )
            {
                var_1 = randomint( 3 );
                self cleargoalvolume();
                self setgoalvolumeauto( var_0 );
                self.ignoreall = 1;
                thread player_close_disable_ignore_check();
                thread exopush_end_flee();
                self waittill( "goal" );

                if ( isdefined( self ) )
                    maps\detroit::bloody_death( var_1 );
            }
        }

        wait 0.05;
    }
}

player_close_disable_ignore_check()
{
    while ( isalive( self ) )
    {
        if ( distance( level.player.origin, self.origin ) < 400 )
        {
            self.ignoreall = 0;
            return;
        }

        wait 0.05;
    }
}

exopush_end_fight()
{
    wait(randomfloat( 2.0 ));
    var_0 = randomint( 3 );

    if ( isdefined( self ) )
        maps\detroit::bloody_death( var_0 );
}

exopush_end_flee()
{
    wait(randomfloat( 2.0 ));

    if ( isdefined( self ) )
    {
        thread player_close_disable_ignore_check();
        self.ignoreall = 1;
    }
}

backline_alive_check( var_0 )
{
    self waittill( "death" );
    level.backlineguysalive--;

    if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
    {
        wait(randomfloat( 4.0 ));

        if ( !common_scripts\utility::flag( "exo_push_phase2_complete" ) )
            thread spawn_a_backline_guy( var_0 );
    }
}

spawn_preplaced_guys()
{
    thread spawn_hospital_roof_guys();
    thread spawn_back_left_scaffold_guys();
}

spawn_hospital_roof_guys()
{
    level.hospitalroofguys = 0;
    var_0 = getentarray( "exo_push_spawner_roof", "targetname" );
    var_1 = getent( "roof_1_vol", "targetname" );
    var_2 = getent( "roof_2_vol", "targetname" );

    foreach ( var_4 in var_0 )
    {
        var_4.count = 1;
        var_5 = var_4 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_5 ) )
        {
            var_5.radius = 15;
            var_5 thread accuracy_fake_function();
            var_5.grenadeammo = 0;
            var_5.meleeattackdist = 0;
            level.hospitalroofguys++;
            var_5 setgoalvolumeauto( var_1 );
            var_5 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            wait(randomint( 4 ));
        }
    }
}

spawn_back_left_scaffold_guys()
{
    var_0 = getentarray( "exo_push_inplace_spawner_scaffold_left_back", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );

        if ( isalive( var_3 ) )
        {
            var_3.radius = 15;
            var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
            var_3.grenadeammo = 0;
            var_3.meleeattackdist = 0;
            var_3 thread accuracy_fake_function();
        }
    }
}

accuracy_fake_function()
{
    self endon( "death" );
    var_0 = self.accuracy;

    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_should_push" ) )
        {
            if ( self.accuracy <= 0.5 )
                break;

            var_1 = var_0 - randomfloatrange( 0.1, 0.3 );

            if ( var_1 <= 0 )
                var_1 = 0.1;

            self.accuracy = var_1;
        }
        else if ( common_scripts\utility::flag( "exo_push_should_idle" ) )
            self.accuracy = var_0;

        if ( distance2d( self.origin, level.player.origin ) > 400 )
            self.accuracy = 0.02;

        if ( distance2d( self.origin, level.player.origin ) < 400 )
            self.accuracy = 0.6;

        wait 0.05;
    }
}

exo_push_think_joker( var_0, var_1 )
{
    var_2 = getnode( "joker_cover_exo_wait spot", "targetname" );
    level.joker setgoalnode( var_2 );
    common_scripts\utility::flag_wait( "exo_push_has_been_started" );
    level.joker thread maps\_utility::set_grenadeammo( 0 );
    var_3 = getent( "exo_push_team_goalorg_joker", "targetname" );
    level.joker.goalradius = 5;
    level.joker setgoalpos( var_3.origin );

    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_phase1_complete" ) )
            return;

        if ( distance2d( level.joker.origin, var_3.origin ) > 30 )
        {
            level.joker setgoalpos( var_3.origin );
            level.joker.ignoreme = 1;
        }

        wait 1;
    }
}

stop_animating_when_exopush_over()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level notify( "stop_vo_for_exo_push" );
    self notify( "exo_push_burke_wait_ender" );
}

burke_exo_push_wait()
{
    thread maps\_anim::anim_loop_solo( level.burke, "exo_push_burke_wait", "exo_push_burke_wait_ender", "tag_walker3" );
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    self notify( "exo_push_burke_wait_ender" );
    return;
}

exo_push_think_burke( var_0, var_1, var_2 )
{
    level endon( "stop_vo_for_exo_push" );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = getent( "exo_push_team_goalorg_burke", "targetname" );
    thread move_team_towards_hospital();
    thread exo_push_over_default_values();
    thread burke_exo_push_end_early( var_0 );
    var_3 thread stop_animating_when_exopush_over();
    common_scripts\utility::flag_set( "kill_the_two_guys_by_ambulance" );

    if ( var_2 == 0 )
        var_1 maps\_anim::anim_reach_solo( level.burke, "exo_push_burke_attach" );

    common_scripts\utility::flag_set( "exo_push_burke_attaching" );
    thread set_flag_on_burke_wave_to_ambulance();
    var_1 maps\_anim::anim_single_solo( level.burke, "exo_push_burke_attach" );
    level.burke linkto( var_0, "tag_walker3" );
    var_0 thread burke_exo_push_wait();
    common_scripts\utility::flag_wait( "exo_push_player_attached" );
    level.burke thread maps\_utility::set_grenadeammo( 0 );
    var_0 notify( "exo_push_burke_wait_ender" );

    for (;;)
    {
        common_scripts\utility::flag_wait_any( "exo_push_should_push", "exo_push_should_idle", "exo_push_arrived" );

        if ( common_scripts\utility::flag( "exo_push_arrived" ) )
            break;

        level.burke linkto( var_0, "tag_walker3" );

        for (;;)
        {
            if ( common_scripts\utility::flag( "exo_push_should_push" ) )
            {
                level.joker allowedstances( "crouch", "stand", "prone" );
                level.bones allowedstances( "crouch", "stand", "prone" );
                var_0 thread maps\_anim::anim_loop_solo( level.burke, "exo_push_loop", "burke_ender", "tag_walker3" );
                common_scripts\utility::flag_waitopen( "exo_push_should_push" );
                var_0 notify( "burke_ender" );
                continue;
            }

            if ( common_scripts\utility::flag( "exo_push_should_idle" ) )
            {
                var_0 thread maps\_anim::anim_loop_solo( level.burke, "exo_push_idle", "burke_ender", "tag_walker3" );
                common_scripts\utility::flag_waitopen( "exo_push_should_idle" );
                var_0 notify( "burke_ender" );
                continue;
            }

            level.burke.goalradius = 40;
            level.burke setgoalpos( var_3.origin );
            level.bones.ignoreme = 0;
            level.joker.ignoreme = 0;
            level.joker allowedstances( "crouch" );
            level.bones allowedstances( "crouch" );
            break;
        }

        level.burke unlink();
        level.burke stopanimscripted();
    }

    var_4 = getent( "burke_grenade_location", "targetname" );
}

burke_exo_push_end_early( var_0 )
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level.burke unlink();
    level.burke stopanimscripted();
    var_0 notify( "burke_ender" );
}

exo_push_over_default_values()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level.joker allowedstances( "crouch", "stand", "prone" );
    level.bones allowedstances( "crouch", "stand", "prone" );
}

set_flag_on_burke_wave_to_ambulance()
{
    wait 6.4;
    common_scripts\utility::flag_set( "send_bones_joker_to_cover1" );
}

exo_push_think_bones( var_0, var_1 )
{
    common_scripts\utility::flag_wait( "exo_push_has_been_started" );
    thread maps\_utility::set_grenadeammo( 0 );
    var_2 = getent( "exo_push_team_goalorg_bones", "targetname" );
    var_3 = getent( "exo_push_team_goalorg_joker", "targetname" );
    level.bones.goalradius = 5;

    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_phase1_complete" ) )
            return;

        wait 1;
        level.bones setgoalpos( var_2.origin );
        level.bones.ignoreme = 1;
    }
}

exo_push_think_player_attached( var_0, var_1 )
{
    for (;;)
    {
        if ( common_scripts\utility::flag( "exo_push_should_push" ) )
        {
            var_0 clearanim( var_0 maps\_utility::getanim( "exo_push_idle" )[0], 0.2 );
            var_0 setanimrestart( var_0 maps\_utility::getanim( "exo_push_idle_to_loop" ) );
            var_0 maps\_anim::anim_single_solo( var_1, "exo_push_idle_to_loop", "tag_driver" );
            var_0 clearanim( var_0 maps\_utility::getanim( "exo_push_idle_to_loop" ), 0.2 );
            var_0 setanimrestart( var_0 maps\_utility::getanim( "exo_push_loop" )[0] );
            var_0 thread maps\_anim::anim_loop_solo( var_1, "exo_push_loop", "player_ender", "tag_driver" );
            common_scripts\utility::flag_waitopen( "exo_push_should_push" );
            var_0 notify( "player_ender" );
            var_0 clearanim( var_0 maps\_utility::getanim( "exo_push_loop" )[0], 0.2 );
            var_0 setanimrestart( var_0 maps\_utility::getanim( "exo_push_loop_to_idle" ) );

            if ( isdefined( var_1 ) )
                var_0 maps\_anim::anim_single_solo( var_1, "exo_push_loop_to_idle", "tag_driver" );

            var_0 clearanim( var_0 maps\_utility::getanim( "exo_push_loop_to_idle" ), 0.2 );
            var_0 setanimrestart( var_0 maps\_utility::getanim( "exo_push_idle" )[0] );
            continue;
        }

        if ( common_scripts\utility::flag( "exo_push_should_idle" ) )
        {
            var_0 thread maps\_anim::anim_loop_solo( var_1, "exo_push_idle", "player_ender", "tag_driver" );
            common_scripts\utility::flag_waitopen( "exo_push_should_idle" );
            var_0 notify( "player_ender" );
            continue;
        }

        break;
    }
}

end_ambulance_anim_early()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    level notify( "stop_moving_ambulance_now" );
    wait 0.3;
    level.truck stopanimscripted();
}

exo_push_think_truck( var_0, var_1 )
{
    level endon( "stop_moving_ambulance_now" );
    var_0.animname = "ambulance";
    var_0 maps\_utility::assign_animtree();
    var_2 = getent( "exo_brush_clip_nosight", "targetname" );
    var_0 thread exopush_stage_manager();
    common_scripts\utility::flag_wait( "exo_push_burke_attaching" );
    var_1 maps\_anim::anim_single_solo( var_0, "exo_push_burke_attach" );
    var_0 thread exo_push_play_truck_idle_at_end_of_frame();
    var_0 thread exo_push_truck_handle_speed( var_0, var_1 );
    var_0 thread exo_push_truck_handle_path_disconnect( var_2 );
    var_1 maps\_anim::anim_single_solo( var_0, "exo_push_path" );
    common_scripts\utility::flag_set( "exo_push_arrived" );
    common_scripts\utility::flag_set( "team_move_hospital" );
    level notify( "stop_second_line_spawner" );
}

exo_push_play_truck_idle_at_end_of_frame()
{
    waittillframeend;
    self setanimrestart( maps\_utility::getanim( "exo_push_idle" )[0] );
}

exo_push_truck_handle_speed( var_0, var_1 )
{
    var_2 = getanimlength( level.scr_anim["world_body"]["exo_push_idle_to_loop"] );
    var_3 = getanimlength( level.scr_anim["world_body"]["exo_push_loop_to_idle"] );
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;

    while ( !common_scripts\utility::flag( "exo_push_arrived" ) )
    {
        if ( common_scripts\utility::flag( "exo_push_should_push" ) )
        {
            var_4 = 0;
            var_5 += 0.05;
        }
        else
        {
            var_4 += 0.05;
            var_5 = 0;
        }

        if ( var_5 > var_2 )
            var_6 = 1;
        else if ( var_4 > var_3 )
            var_6 = 0;

        var_1 maps\_anim::anim_set_rate( [ var_0 ], "exo_push_path", var_6 );
        wait 0.05;
    }

    maps\_utility::autosave_by_name( "Hospital start" );
}

exo_push_truck_handle_path_disconnect( var_0 )
{
    var_1 = ( 0, 0, 0 );

    while ( !common_scripts\utility::flag( "exo_push_arrived" ) )
    {
        if ( distancesquared( self.origin, var_1 ) > 1024 )
        {
            var_0 connectpaths();
            badplace_delete( "ambulance_badplace" );
            var_0 disconnectpaths();

            if ( common_scripts\utility::flag( "exo_push_player_attached" ) )
                badplace_cylinder( "ambulance_badplace", 0, self.origin, 150, 100, "axis", "allies" );
        }

        waitframe();
    }

    badplace_delete( "ambulance_badplace" );
}

move_team_towards_hospital()
{
    common_scripts\utility::flag_wait( "exo_push_arrived" );
    var_0 = getnode( "burke_hospital_hide_outside", "targetname" );
    var_1 = getnode( "bones_hospital", "targetname" );
    var_2 = getnode( "joker_hospital", "targetname" );
    level.burke setgoalnode( var_0 );
    level.bones setgoalnode( var_1 );
    level.joker setgoalnode( var_2 );
    maps\_utility::activate_trigger_with_targetname( "team_move_hospital" );
}

begin_spawnning_exo_spawners()
{
    common_scripts\utility::flag_wait( "exo_push_player_attached" );
    level.burke.ignoreall = 0;
    var_0 = getentarray( "exo_push_spawner", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_ai( 1 );
        var_3 thread accuracy_fake_function();
        var_3 maps\detroit_lighting::add_enemy_flashlight( "flashlight", undefined, undefined, 25 );
        var_3.accuracy = 0;
        var_4 = randomfloatrange( 0.3, 0.8 );
        wait(var_4);
    }
}

shoot_at_sentinel_agents()
{
    var_0 = getent( "sentinel_rocket_start_org", "targetname" );
    var_1 = getent( "sentinel_rocket_end_org", "targetname" );
    common_scripts\utility::flag_wait( "begin_kva_assault_on_sentinel" );
    var_2 = getentarray( "sentinel_shoot_window_1_org", "targetname" );
    var_3 = getentarray( "sentinel_shoot_window_2_org", "targetname" );
    var_4 = getentarray( "sentinel_shoot_window_3_org", "targetname" );
    var_5 = [ var_2, var_3, var_4 ];
    var_6 = getentarray( "sentinel_bullet_start_org", "targetname" );

    foreach ( var_8 in var_6 )
    {
        var_8 thread shoot_at_spots( var_5 );
        wait(randomfloatrange( 0.3, 1.2 ));
    }
}

shoot_at_spots( var_0 )
{
    level endon( "cleanup_sentinel_guys" );
    var_1 = randomint( 4 );

    for (;;)
    {
        var_2 = randomfloatrange( -10, 10 );
        var_3 = randomfloatrange( -10, 10 );
        var_4 = randomfloatrange( -10, 10 );
        var_5 = ( var_2, var_3, var_4 );
        var_6 = "";
        var_7 = undefined;
        var_8 = 0;
        var_9 = var_0[randomintrange( 0, var_0.size )];
        var_10 = randomintrange( 1, 8 );
        var_11 = randomfloatrange( 0.25, 1.15 );

        switch ( var_1 )
        {
            case 0:
                var_6 = "iw5_arx160_sp";
                var_7 = 0.1;
                break;
            case 1:
                var_6 = "iw5_mp11_sp";
                var_7 = 0.05;
                break;
            case 2:
                var_6 = "iw5_arx160_sp";
                var_7 = randomfloatrange( 0.1, 0.5 );
                break;
            case 3:
                var_6 = "iw5_mp11_sp";
                var_7 = randomfloatrange( 0.05, 0.2 );
                break;
            default:
                break;
        }

        fire_loop_at_target_with_delay( var_6, var_10, var_8, var_5, var_9, var_7, var_11 );
    }
}

fire_loop_at_target_with_delay( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    while ( var_1 > var_2 )
    {
        var_4 = var_4 if_array_choose_random_target();
        var_7 = magicbullet( var_0, self.origin, var_4.origin + var_3 );
        var_2++;
        wait(var_5);
    }

    wait(var_6);
}

if_array_choose_random_target()
{
    if ( isdefined( self ) && isarray( self ) )
    {
        var_0 = self[randomintrange( 0, self.size )];
        return var_0;
    }
    else
        return self;
}
