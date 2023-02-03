// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

spawn_squad( var_0 )
{
    level.burke = getent( "spawner_burke_bridge", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.saint = getent( "spawner_saint_bridge", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.burke setup_hero( "Burke" );
    level.saint setup_hero( "Saint" );

    if ( isdefined( var_0 ) )
    {
        var_1 = getent( var_0 + "_burke", "targetname" );
        level.burke teleport( var_1.origin, var_1.angles );
        level.burke setgoalpos( level.burke.origin );
        var_2 = getent( var_0 + "_saint", "targetname" );
        level.saint teleport( var_2.origin, var_2.angles );
        level.saint setgoalpos( level.saint.origin );
    }

    level.player setthreatbiasgroup( "sentinel" );
}

setup_hero( var_0 )
{
    maps\_utility::magic_bullet_shield();
    self.animname = var_0;

    if ( !isdefined( level.heroes ) )
        level.heroes = [];

    level.heroes[level.heroes.size] = self;
    maps\_utility::make_hero();
    self setthreatbiasgroup( "sentinel" );
}

set_player_start( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    level.player maps\_utility::teleport_player( var_1 );
}

give_boost_jump()
{
    maps\_player_exo::player_exo_add_single( "high_jump" );
}

remove_boost_jump()
{
    maps\_player_exo::player_exo_remove_single( "high_jump" );
}

squad_ignore_all_start()
{
    foreach ( var_1 in level.heroes )
        var_1.ignoreall = 1;
}

squad_ignore_all_stop()
{
    foreach ( var_1 in level.heroes )
        var_1.ignoreall = 0;
}

setup_squad_for_scene()
{
    foreach ( var_1 in level.heroes )
    {
        var_1.old_name = var_1.name;
        var_1.name = " ";
    }
}

setup_squad_for_gameplay()
{
    foreach ( var_1 in level.heroes )
        var_1.name = var_1.old_name;
}

squad_careful_all_start()
{
    foreach ( var_1 in level.heroes )
        var_1 maps\_utility::enable_careful();
}

squad_careful_all_stop()
{
    foreach ( var_1 in level.heroes )
        var_1 maps\_utility::disable_careful();
}

show_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 show();
}

hide_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 hide();
}

solid_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 solid();
}

notsolid_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 notsolid();
}

connectpaths_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 connectpaths();
    }
}

disconnectpaths_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( var_3.classname == "script_brushmodel" )
            var_3 disconnectpaths();
    }
}

delete_ents_by_targetname( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 delete();
}

hide_fallen_bridge()
{
    hide_ents_by_targetname( "bridge_section_fallen" );
    hide_ents_by_targetname( "bridge_section_far" );
}

show_fallen_bridge()
{
    show_ents_by_targetname( "bridge_section_fallen" );
}

show_far_bridge()
{
    show_ents_by_targetname( "bridge_section_far" );
}

hide_intact_bridge()
{
    hide_ents_by_targetname( "bridge_section_remove" );
}

remove_intact_bridge()
{
    connectpaths_ents_by_targetname( "bridge_section_remove" );
    delete_ents_by_targetname( "bridge_section_remove" );
}

hide_crash_traffic()
{
    notsolid_ents_by_targetname( "after_crash_traffic" );
    hide_ents_by_targetname( "after_crash_traffic" );
}

show_crash_traffic()
{
    solid_ents_by_targetname( "after_crash_traffic" );
    show_ents_by_targetname( "after_crash_traffic" );
}

hide_chase_scene()
{
    hide_ents_by_targetname( "bus_crash_final_pos_col" );
    notsolid_ents_by_targetname( "bus_crash_final_pos_col" );
    hide_ents_by_targetname( "pitbull_crash_collision" );
    notsolid_ents_by_targetname( "pitbull_crash_collision" );
}

put_bridge_in_proper_place()
{
    var_0 = getentarray( "bridge_section_remove", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.origin += ( 0, -9216, 0 );

        if ( var_2.classname == "script_brushmodel" )
            var_2 disconnectpaths();
    }
}

put_roadsurface_in_proper_place()
{
    var_0 = getentarray( "bridge_roadsurface_intro", "targetname" );

    foreach ( var_2 in var_0 )
        var_2.origin += ( 0, -5120, 5 );
}

delete_roadsurface_bridge()
{
    delete_ents_by_targetname( "bridge_roadsurface_intro" );
}

setup_intro()
{
    hide_fallen_bridge();
    hide_crash_traffic();
    hide_chase_scene();
    make_bridge_normal();
    put_bridge_in_proper_place();
    put_roadsurface_in_proper_place();
    thread maps\sanfran_fx::traffic_fx_init();
    thread maps\_vehicle_traffic::traffic_init( maps\sanfran_fx::traffic_collision_hit_func );
}

trigger_bridge_small()
{
    self waittill( "trigger" );
    make_bridge_normal();
}

make_bridge_big()
{
    hide_ents_by_targetname( "bridge_tower_small" );
    show_ents_by_targetname( "bridge_tower_big" );
}

make_bridge_normal()
{
    show_ents_by_targetname( "bridge_tower_small" );
    hide_ents_by_targetname( "bridge_tower_big" );
}

toggle_off_real_mob()
{
    hide_ents_by_targetname( "mob_brushmodel" );
    hide_ents_by_targetname( "mob_models" );
}

toggle_on_real_mob()
{
    hide_ents_by_targetname( "fake_mob" );
    show_ents_by_targetname( "mob_brushmodel" );
    show_ents_by_targetname( "mob_models" );
}

toggle_all_boats_on_trigger()
{
    self waittill( "trigger" );
    toggle_all_boats_on();
}

toggle_all_boats_on()
{
    var_0 = [];
    var_0[var_0.size] = getent( "cargo_ship_2", "targetname" );
    var_0[var_0.size] = getent( "cargo_ship", "targetname" );
    var_1 = getentarray( "navy_ship_right", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_1 = getentarray( "navy_ship", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_0[var_0.size] = getent( "fake_mob", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 show();
}

toggle_all_boats_off()
{
    var_0 = [];
    var_0[var_0.size] = getent( "cargo_ship_2", "targetname" );
    var_0[var_0.size] = getent( "cargo_ship", "targetname" );
    var_1 = getentarray( "navy_ship_right", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_1 = getentarray( "navy_ship", "targetname" );
    var_0 = common_scripts\utility::array_combine( var_0, var_1 );
    var_0[var_0.size] = getent( "fake_mob", "targetname" );

    foreach ( var_3 in var_0 )
        var_3 hide();
}

toggle_boat_visibility()
{
    level thread toggle_boat_visibility_group( "right" );
    level thread toggle_boat_visibility_group( "left" );
}

toggle_boat_visibility_group( var_0 )
{
    level endon( "stop_toggle_boat_visibility" );
    var_1 = [];

    if ( var_0 == "right" )
    {
        var_2 = getentarray( "trigger_toggle_cant_see_ships_right", "targetname" );
        var_1[var_1.size] = getent( "cargo_ship_2", "targetname" );
        var_3 = getentarray( "navy_ship_right", "targetname" );
        var_1 = common_scripts\utility::array_combine( var_1, var_3 );
    }
    else if ( var_0 == "left" )
    {
        var_2 = getentarray( "trigger_toggle_cant_see_ships_left", "targetname" );
        var_1[var_1.size] = getent( "cargo_ship", "targetname" );
        var_3 = getentarray( "navy_ship", "targetname" );
        var_1 = common_scripts\utility::array_combine( var_1, var_3 );
    }
    else
        return;

    thread make_all_boats_visible( var_1 );

    for (;;)
    {
        for (;;)
        {
            var_4 = 0;

            foreach ( var_6 in var_2 )
            {
                if ( level.player istouching( var_6 ) )
                {
                    var_4 = 1;
                    break;
                }
            }

            if ( var_4 == 1 )
                break;

            wait 0.05;
        }

        foreach ( var_9 in var_1 )
            var_9 hide();

        for (;;)
        {
            var_4 = 0;

            foreach ( var_6 in var_2 )
            {
                if ( level.player istouching( var_6 ) )
                {
                    var_4 = 1;
                    break;
                }
            }

            if ( var_4 == 0 )
                break;

            wait 0.05;
        }

        foreach ( var_9 in var_1 )
            var_9 show();

        wait 0.05;
    }
}

make_all_boats_visible( var_0 )
{
    level waittill( "stop_toggle_boat_visibility" );

    foreach ( var_2 in var_0 )
        var_2 show();
}

show_water_intro()
{
    show_ents_by_targetname( "ship_water_intro" );
    hide_ents_by_targetname( "ship_water_waves" );
}

show_water_final()
{
    hide_ents_by_targetname( "ship_water_intro" );
    show_ents_by_targetname( "ship_water_waves" );
}

drone_lookat_ent( var_0, var_1, var_2, var_3 )
{
    self notify( "start_new_drone_lookat" );
    self endon( "start_new_drone_lookat" );

    if ( !isdefined( var_3 ) )
        var_3 = ( 0, 0, 0 );

    var_4 = getent( var_0, "targetname" );
    var_5 = vectortoangles( var_4.origin - self.origin );

    if ( !isdefined( var_1 ) || var_1 == 0 )
        self.angles = var_5;
    else
    {
        self rotateto( var_5 + var_3, var_1, var_1 / 5, var_1 / 5 );
        self waittill( "rotatedone" );
        self notify( "drone_lookat_done" );
    }

    if ( isdefined( var_2 ) && var_2 )
    {
        for (;;)
        {
            var_5 = vectortoangles( var_4.origin - self.origin ) + var_3;
            self rotateto( var_5, 0.05, 0, 0 );
            wait 0.05;
        }
    }
}

drone_moveto_ent( var_0, var_1 )
{
    var_2 = getent( var_0, "targetname" );
    self moveto( var_2.origin, var_1, var_1 / 5, var_1 / 5 );
    self waittill( "movedone" );
    self notify( "drone_moveto_done" );
}

drone_view_shake( var_0 )
{
    self notify( "start_new_intro_shake" );
    self endon( "start_new_intro_shake" );

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_intro_transition_to_driving" ) )
            break;

        earthquake( var_0, 0.1, level.player.origin, 200 );
        wait 0.1;
    }
}

setup_move_player_pitbull( var_0 )
{
    level.player_pitbull = maps\_vehicle::spawn_vehicle_from_targetname( "player_pitbull" );
    thread maps\_vehicle_traffic::add_script_car( level.player_pitbull );
    var_1 = getent( var_0, "targetname" );
    level.player_pitbull vehicle_teleport( var_1.origin, var_1.angles );
}

setup_move_friendly_pitbull( var_0 )
{
    level.friendly_pitbull = maps\_vehicle::spawn_vehicle_from_targetname( "friendly_pitbull" );
    thread maps\_vehicle_traffic::add_script_car( level.friendly_pitbull );
    level.friendly_pitbull setup_start_vehicle_on_path( var_0 );
}

setup_move_chase_van( var_0 )
{
    level.chase_van = maps\_vehicle::spawn_vehicle_from_targetname( "chase_van" );
    thread maps\_vehicle_traffic::add_script_car( level.chase_van );
    level.chase_van setup_start_vehicle_on_path( var_0 );
}

setup_start_vehicle_on_path( var_0 )
{
    var_1 = getent( var_0, "targetname" );
    self vehicle_teleport( var_1.origin, var_1.angles );
    var_2 = getvehiclenode( var_1.target, "targetname" );
    thread maps\_vehicle_code::_vehicle_paths( var_2 );
    self startpath( var_2 );
}

enable_pitbull_shooting()
{
    level.player_pitbull maps\_utility::ent_flag_set( "pitbull_allow_shooting" );
    level.friendly_pitbull maps\_utility::ent_flag_set( "pitbull_allow_shooting" );
}

chase_van_set_close()
{
    self waittill( "trigger" );
    level.chase_van.lead_pos = "close";
}

chase_van_set_medium()
{
    self waittill( "trigger" );
    level.chase_van.lead_pos = "medium";
}

chase_van_set_far()
{
    self waittill( "trigger" );
    level.chase_van.lead_pos = "far";
}

friendly_pitbull_shadow_chase_van()
{
    self waittill( "trigger" );
    level.friendly_pitbull.shadow_pos = "van";
}

friendly_pitbull_shadow_player()
{
    self waittill( "trigger" );
    level.friendly_pitbull.shadow_pos = "player";
}

wait_for_crash_at_end()
{
    self waittill( "reached_end_node" );
    self dodamage( 1000000000, self.origin );
    playfxontag( level._effect["tanker_explosion"], self, "tag_origin" );
    soundscripts\_snd::snd_message( "car_chase_crash" );
    wait 4.0;
    stopfxontag( level._effect["tanker_explosion"], self, "tag_origin" );
}

get_dist_to_end_in_miles( var_0 )
{
    if ( !isdefined( self.currentnode.target ) )
        return 0;

    var_1 = getvehiclenode( self.currentnode.target, "targetname" );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = 0;
    var_3 = self;

    for (;;)
    {
        var_2 += distance( var_3.origin, var_1.origin );

        if ( !isdefined( var_1.target ) )
        {
            if ( isdefined( var_0 ) )
                return 0;

            break;
        }

        if ( isdefined( var_0 ) && isdefined( var_1.script_noteworthy ) && var_1.script_noteworthy == var_0 )
            break;

        var_3 = var_1;
        var_1 = getvehiclenode( var_1.target, "targetname" );

        if ( !isdefined( var_1 ) )
            break;
    }

    return var_2 / 63360;
}

get_vehicles_to_point_at_same_time( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 endon( "death" );
    var_2 endon( "death" );

    if ( isdefined( var_4 ) )
        level endon( var_4 );

    for (;;)
    {
        var_5 = var_0 get_dist_to_end_in_miles( var_1 );
        var_6 = var_2 get_dist_to_end_in_miles( var_3 );
        var_7 = var_0 vehicle_getspeed();

        if ( var_7 > 0 )
        {
            var_8 = var_5 / var_7;

            if ( var_8 > 0 )
                var_9 = var_6 / var_8;
            else
                var_9 = 50;

            var_2 vehicle_setspeed( var_9, 100, 5 );
        }

        wait 0.05;
    }
}

vehicle_chase_target( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self notify( "one_vehicle_chase_target" );
    self endon( "one_vehicle_chase_target" );
    level endon( "flag_player_crashed" );
    self endon( "stop_chase_target" );
    self endon( "death" );
    thread chase_cleanup_after_player_crash();
    self.oscillate_speed = 0;

    if ( var_3 >= 0 && var_4 > 0 )
        thread vehicle_oscillate_location( var_3, var_4 );

    for (;;)
    {
        var_10 = var_0 vehicle_getspeed();
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

        if ( var_7 && isdefined( level.player_pitbull ) )
        {
            if ( vectordot( level.player_pitbull.origin - self.origin, anglestoforward( self.angles ) ) > 0 )
            {
                [var_18, var_19] = maps\_vehicle_traffic::time_and_distance_of_closest_approach( self.origin, self vehicle_getvelocity(), level.player_pitbull.origin, level.player_pitbull vehicle_getvelocity(), 0.1, 234, 0 );

                if ( var_18 < 2 && var_19 < 234 )
                    var_10 = level.player_pitbull vehicle_getspeed() * 0.6;
            }
        }

        if ( var_8 )
            var_10 = clamp( var_10, 0, 200 );
        else if ( isdefined( var_9 ) )
            var_10 = clamp( var_10, var_9, 200 );
        else
            var_10 = clamp( var_10, 20, 200 );

        self vehicle_setspeed( var_10, 100, 100 );
        wait 0.05;
    }
}

chase_cleanup_after_player_crash()
{
    self notify( "one_chase_cleanup_after_player_crash" );
    self endon( "one_chase_cleanup_after_player_crash" );
    self endon( "stop_chase_target" );
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_crashed" );
    wait 0.5;
    self resumespeed( 100 );
}

vehicle_oscillate_location( var_0, var_1 )
{
    self notify( "one_vehicle_oscillate_location" );
    self endon( "one_vehicle_oscillate_location" );
    level endon( "flag_player_crashed" );
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

jumping_take_down( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );
    var_1 = common_scripts\utility::array_randomize( var_1 );
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = [];

    foreach ( var_7 in var_1 )
    {
        var_3 = undefined;
        var_4 = undefined;
        var_8 = vectornormalize( anglestoforward( var_7.angles ) );
        var_9 = vectornormalize( -1 * anglestoright( var_7.angles ) );
        var_3 = get_closest_ai_to_origin( var_7.origin, "axis", 0, 150 );

        if ( !isdefined( var_3 ) )
            continue;

        var_4 = get_closest_ai_to_origin( var_7.origin, "allies", 350, 800, 0, 20, var_9 );

        if ( isdefined( var_3 ) && isdefined( var_4 ) )
        {
            var_2 = var_7;
            break;
        }
    }

    if ( !isdefined( var_3 ) || !isdefined( var_4 ) )
        return 0;

    var_5[0] = var_4;
    var_5[0].ignoreme = 1;
    var_5[0].ignoreall = 1;
    var_5[1] = var_3;
    var_5[1].ignoreme = 1;
    var_5[1].ignoreall = 1;
    var_11[0] = "boost_jump_kick_02_atk";
    var_11[1] = "boost_jump_kick_02_def";
    var_2 anim_reach_together_with_overrides( var_5, "boost_jump_kick_02", var_11 );

    if ( isalive( var_5[0] ) && isalive( var_5[1] ) )
    {
        var_2 thread maps\_anim::anim_single_solo( var_5[0], "boost_jump_kick_02", undefined, undefined, var_11[0] );
        var_2 thread maps\_anim::anim_single_solo( var_5[1], "boost_jump_kick_02", undefined, undefined, var_11[1] );
        var_2 waittill( "boost_jump_kick_02" );
        var_2 waittill( "boost_jump_kick_02" );
        var_3 kill_no_react();
        var_4 maps\_utility::enable_ai_color_dontmove();
    }

    var_5[0].ignoreme = 0;
    var_5[0].ignoreall = 0;
    return 1;
}

lunging_take_down( var_0, var_1, var_2 )
{
    var_3 = getnodearray( var_0, "targetname" );
    var_3 = common_scripts\utility::array_randomize( var_3 );
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = [];

    foreach ( var_9 in var_3 )
    {
        var_5 = undefined;
        var_6 = undefined;
        var_10 = vectornormalize( anglestoforward( var_9.angles ) );
        var_11 = vectornormalize( -1 * anglestoright( var_9.angles ) );
        var_5 = get_closest_ai_to_origin( var_9.origin, "axis", 0, 150 );

        if ( !isdefined( var_5 ) )
            continue;

        var_6 = get_closest_ai_to_origin( var_9.origin, "allies", 450, 900, 0, 20, var_11 );

        if ( isdefined( var_5 ) && isdefined( var_6 ) )
        {
            var_4 = var_9;
            break;
        }
    }

    if ( isdefined( var_1 ) )
        var_6 = var_1;

    if ( isdefined( var_2 ) )
        var_5 = var_2;

    if ( !isdefined( var_5 ) || !isdefined( var_6 ) )
        return 0;

    if ( !isdefined( var_4 ) )
        var_4 = var_3[0];

    var_7[0] = var_6;
    var_7[0].ignoreme = 1;
    var_7[0].ignoreall = 1;
    var_7[1] = var_5;
    var_7[1].ignoreme = 1;
    var_7[1].ignoreall = 1;
    var_13[0] = "boost_jump_kick_01_atk";
    var_13[1] = "boost_jump_kick_01_def";
    var_4 anim_reach_together_with_overrides( var_7, "boost_jump_kick_01", var_13 );

    if ( isalive( var_7[0] ) && isalive( var_7[1] ) )
    {
        var_4 thread maps\_anim::anim_single_solo( var_7[0], "boost_jump_kick_01", undefined, 0.25, var_13[0] );
        var_4 thread maps\_anim::anim_single_solo( var_7[1], "boost_jump_kick_01", undefined, undefined, var_13[1] );
        var_4 waittill( "boost_jump_kick_01" );
        var_4 waittill( "boost_jump_kick_01" );
        var_5 kill_no_react();
        var_6 maps\_utility::enable_ai_color_dontmove();
    }

    var_7[0].ignoreme = 0;
    var_7[0].ignoreall = 0;
    return 1;
}

get_closest_ai_to_origin( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_2 = validate_min_value( var_2, 0 );
    var_3 = validate_max_value( var_3, var_2, 999999 );
    var_4 = validate_min_value( var_4, 0 );
    var_5 = validate_max_value( var_5, var_4, 180 );
    var_7 = cos( var_4 );
    var_8 = cos( var_5 );
    var_9 = [];

    if ( isdefined( var_1 ) )
        var_9 = getaiarray( var_1 );
    else
        var_9 = getaiarray();

    var_10 = undefined;
    var_11 = 99999;

    foreach ( var_13 in var_9 )
    {
        var_14 = distance( var_13.origin, var_0 );

        if ( var_14 < var_2 || var_14 > var_3 )
            continue;

        if ( isdefined( var_6 ) )
        {
            var_15 = vectornormalize( var_13.origin - var_0 );
            var_16 = vectordot( var_15, var_6 );

            if ( var_16 < var_8 || var_16 > var_7 )
                continue;
        }

        if ( var_14 < var_11 )
        {
            var_11 = var_14;
            var_10 = var_13;
        }
    }

    return var_10;
}

validate_min_value( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || var_0 < var_1 )
        return var_1;

    return var_0;
}

validate_max_value( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) && var_0 < var_1 )
        return var_1;
    else if ( !isdefined( var_0 ) )
        return var_2;

    return var_0;
}

kill_no_react()
{
    if ( !isalive( self ) )
        return;

    self.allowdeath = 1;
    self.a.nodeath = 1;
    thread maps\_utility::set_battlechatter( 0 );
    self kill();
}

anim_reach_together_with_overrides( var_0, var_1, var_2 )
{
    thread maps\_anim::modify_moveplaybackrate_together( var_0 );
    var_3 = self.origin;
    var_4 = self.angles;
    var_5 = spawnstruct();
    var_6 = 0;

    for ( var_7 = 0; var_7 < var_0.size; var_7++ )
    {
        if ( isdefined( level.scr_anim[var_2[var_7]][var_1] ) )
        {
            if ( isarray( level.scr_anim[var_2[var_7]][var_1] ) )
                var_8 = getstartorigin( var_3, var_4, level.scr_anim[var_2[var_7]][var_1][0] );
            else
                var_8 = getstartorigin( var_3, var_4, level.scr_anim[var_2[var_7]][var_1] );
        }
        else
            var_8 = var_3;

        var_6++;
        var_0[var_7] thread maps\_anim::begin_anim_reach( var_5, var_8, maps\_anim::reach_with_standard_adjustments_begin, maps\_anim::reach_with_standard_adjustments_end );
    }

    while ( var_6 )
    {
        var_5 waittill( "reach_notify" );
        var_6--;
    }

    foreach ( var_10 in var_0 )
    {
        if ( !isalive( var_10 ) )
            continue;

        var_10.goalradius = var_10.oldgoalradius;
        var_10.scriptedarrivalent = undefined;
        var_10.stopanimdistsq = 0;
    }
}

open_car_doors()
{
    common_scripts\utility::run_thread_on_noteworthy( "door_open_compact_both", ::open_car_door, "compact", "open_door_both" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_compact_left", ::open_car_door, "compact", "open_door_left" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_compact_right", ::open_car_door, "compact", "open_door_right" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_truck_both", ::open_car_door, "truck", "open_door_both" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_truck_left", ::open_car_door, "truck", "open_door_left" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_truck_right", ::open_car_door, "truck", "open_door_right" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_atlas_suv_both", ::open_car_door, "atlas_suv", "open_door_both" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_atlas_suv_left", ::open_car_door, "atlas_suv", "open_door_left" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_atlas_suv_right", ::open_car_door, "atlas_suv", "open_door_right" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_sedan_both", ::open_car_door, "sedan", "open_door_both" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_sedan_left", ::open_car_door, "sedan", "open_door_left" );
    common_scripts\utility::run_thread_on_noteworthy( "door_open_sedan_right", ::open_car_door, "sedan", "open_door_right" );
}

#using_animtree("vehicles");

open_car_door( var_0, var_1 )
{
    if ( self.classname != "script_model" )
        return;

    self.animname = var_0;
    self useanimtree( #animtree );
    self setanim( maps\_utility::getanim( var_1 ) );
}

container_death_anims()
{
    self.specialdeathfunc = ::use_container_death;
}

use_container_death()
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "container_death" )
    {
        self.deathanim = maps\_utility::getgenericanim( "container_death" );
        animscripts\death::playdeathanim( self.deathanim );
        return 1;
    }

    return 0;
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

temp_subtitle( var_0, var_1, var_2 )
{
    var_3 = newhudelem();
    var_3.x = 0;
    var_3.y = -42;
    var_3 settext( var_0 );
    var_3.fontscale = 1.46;
    var_3.alignx = "center";
    var_3.aligny = "middle";
    var_3.horzalign = "center";
    var_3.vertalign = "bottom";
    var_3.sort = 1;
    wait(var_1);
    var_3 destroy();
}

init_bobbing_boats()
{
    level.bobbing_objects = [];
    var_0 = maps\_bobbing_boats::createdefaultbobsettings();
    var_1 = getentarray( "bobbing_ship", "script_noteworthy" );
    maps\_bobbing_boats::prep_bobbing( var_1, maps\_bobbing_boats::bobbingobject, var_0, 0 );
    level.bobbing_objects = maps\_shg_utility::array_combine_unique( level.bobbing_objects, var_1 );
    var_2 = maps\_bobbing_boats::createdefaultbobsettings();
    var_2.max_pitch = 1.0;
    var_3 = getentarray( "bobbing_ship_big", "script_noteworthy" );
    maps\_bobbing_boats::prep_bobbing( var_3, maps\_bobbing_boats::bobbingobject, var_2, 0 );
    level.bobbing_objects = maps\_shg_utility::array_combine_unique( level.bobbing_objects, var_3 );
    maps\_bobbing_boats::start_bobbing( level.bobbing_objects );
}

intro_drive_hint()
{
    common_scripts\utility::flag_wait( "flag_intro_give_player_driving" );
    maps\_utility::hintdisplayhandler( "drive_hint" );
    var_0 = gettime();

    while ( gettime() < var_0 + 4000 )
    {
        if ( level.player_pitbull.veh_speed > 5 )
            break;

        if ( level.player buttonpressed( "BUTTON_B" ) )
            break;

        level.player_pitbull vehphys_setspeed( 35.0 );
        wait 0.05;
    }
}

player_is_driving()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( level.player_pitbull.veh_speed > 50 )
        return 1;
    else
        return 0;
}

intro_shoot_hint()
{
    maps\_utility::hintdisplayhandler( "shoot_hint" );
}

player_is_shooting()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_final_crash_scene_playing" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_reverse_hint_displayed" ) )
        return 1;

    if ( !level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() && level.player attackbuttonpressed() )
    {
        common_scripts\utility::flag_set( "flag_player_has_shot_pitbull" );
        return 1;
    }
    else if ( level.player common_scripts\utility::is_player_gamepad_enabled() && level.player adsbuttonpressed() )
    {
        common_scripts\utility::flag_set( "flag_player_has_shot_pitbull" );
        return 1;
    }

    return 0;
}

boost_jump_hint()
{
    maps\_utility::display_hint( "boost_hint" );
}

player_has_jumped()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( level.player jumpbuttonpressed() )
        return 1;

    return 0;
}

player_too_far_hint()
{
    if ( common_scripts\utility::flag( "flag_hint_player_too_far" ) )
        return;

    common_scripts\utility::flag_set( "flag_hint_player_too_far" );
    maps\_utility::hintdisplayhandler( "too_far_hint" );
}

player_has_caught_up()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_hint_player_too_far" ) )
        return 0;

    return 1;
}

player_left_road_hint()
{
    if ( common_scripts\utility::flag( "flag_hint_player_left_road" ) )
        return;

    common_scripts\utility::flag_set( "flag_hint_player_left_road" );
    maps\_utility::hintdisplayhandler( "left_road_hint" );
}

player_has_returned_to_road()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_hint_player_left_road" ) )
        return 0;

    return 1;
}

player_left_squad_hint()
{
    if ( common_scripts\utility::flag( "flag_hint_player_left_squad" ) )
        return;

    common_scripts\utility::flag_set( "flag_hint_player_left_squad" );
    maps\_utility::display_hint( "left_squad_hint" );
}

player_has_returned_to_squad()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_hint_player_left_squad" ) )
        return 0;

    return 1;
}

start_civilian_group( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( !isdefined( level.civilian_group ) )
        level.civilian_group = [];

    var_2 = getentarray( var_0, "targetname" );
    maps\_utility::array_spawn_function_targetname( var_0, ::civilian_drone_setup );
    level.aud.bridge_civs = [];
    common_scripts\utility::array_thread( var_2, maps\_utility::spawn_ai );
    soundscripts\_snd::snd_message( "panic_walla", var_0 );
}

civilian_drone_setup()
{
    self endon( "death" );
    self endon( "delete" );
    level.aud.bridge_civs[level.aud.bridge_civs.size] = self;
    self.goalradius = 32;
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.animname = "drone";
    self.drone_move_callback = ::civilian_drone_run_override;
    level.civilian_group[level.civilian_group.size] = self;
    thread civilian_drone_runner_collision();
    soundscripts\_snd::snd_message( "panic_walla_oneshots", self );
    self waittill( "goal" );
    self stopanimscripted();
    self notify( "drone_stop" );
    self notify( "stop_loop" );
    self notify( "single anim", "end" );
    self notify( "looping anim", "end" );
    thread maps\_anim::anim_loop_solo( self, "civilian_cower" );

    for (;;)
    {
        wait 0.5;

        if ( distance( level.player.origin, self.origin ) > 1000 )
        {
            if ( !maps\_utility::player_looking_at( self.origin, undefined, 1 ) )
                break;
        }
    }

    self delete();
}

street_civilian_clean_up()
{
    if ( isdefined( level.civilian_group ) )
    {
        maps\_utility::ai_delete_when_out_of_sight( level.civilian_group, 200 );
        level.civilian_group = common_scripts\utility::array_removeundefined( level.civilian_group );
    }
}

civilian_drone_run_override()
{
    var_0 = undefined;

    if ( !isdefined( self.drone_run_number ) )
        self.drone_run_number = randomintrange( 1, 8 );

    if ( !isdefined( self.drone_move_time ) )
        self.drone_move_time = -1000;

    if ( gettime() > self.drone_move_time )
    {
        var_0 = spawnstruct();
        var_1 = level.scr_anim["drone"]["run_0" + self.drone_run_number];

        if ( isarray( var_1 ) )
        {
            var_1 = common_scripts\utility::array_randomize( var_1 );
            var_0.runanim = var_1[0];
        }
        else
            var_0.runanim = var_1;

        var_2 = maps\_drone::get_anim_data( var_0.runanim );
        var_0.anim_relative = var_2.anim_relative;
        var_0.run_speed = var_2.run_speed;
        self.drone_move_time = gettime() + var_2.anim_time / self.moveplaybackrate * 1000;
    }

    return var_0;
}

civilian_drone_runner_collision()
{
    self endon( "goal" );
    self endon( "death" );

    while ( isdefined( self ) )
    {
        while ( distance( self.origin, level.player.origin ) > 100 )
            wait 0.1;

        var_0 = self setcontents( 0 );

        while ( distance( self.origin, level.player.origin ) <= 100 )
            wait 0.1;

        self setcontents( var_0 );
    }
}

civilian_get_out_of_car_setup( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = get_civilian_car( var_0 );
    var_6 = get_civilian( var_1, var_5["model"].animname );
    level thread civilian_in_car_get_out( var_5, var_6, var_2, var_3, var_4 );
}

get_civilian_car( var_0 )
{
    var_1 = getentarray( var_0, "targetname" );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( var_4.classname == "script_model" )
        {
            var_2["model"] = var_4;
            continue;
        }

        if ( var_4.classname == "script_brushmodel" )
        {
            if ( isdefined( var_4.script_noteworthy ) && var_4.script_noteworthy == "door_open_col" )
            {
                var_2["door"] = var_4;
                var_2["door"] notsolid();
                var_2["door"] connectpaths();
            }
            else
                var_2["col"] = var_4;

            continue;
        }
    }

    if ( issubstr( var_2["model"].model, "sedan" ) )
    {
        var_2["model"].animname = "sedan";
        var_2["model"] useanimtree( #animtree );
    }
    else if ( issubstr( var_2["model"].model, "compact" ) || issubstr( var_2["model"].model, "economy" ) )
    {
        var_2["model"].animname = "compact";
        var_2["model"] useanimtree( #animtree );
    }
    else if ( issubstr( var_2["model"].model, "truck" ) )
    {
        var_2["model"].animname = "truck";
        var_2["model"] useanimtree( #animtree );
    }

    return var_2;
}

get_civilian( var_0, var_1 )
{
    var_2 = [];
    var_3 = getent( var_0, "targetname" );
    var_2["ai"] = var_3 maps\_utility::spawn_ai( 1, 0 );
    var_2["ai"].ignoresonicaoe = 1;
    level.civilian_group[level.civilian_group.size] = var_2["ai"];
    var_2["ai"].ignoreall = 1;
    var_2["ai"].animname = var_1 + "_driver";

    if ( isdefined( var_3.target ) )
        var_2["goal"] = getnode( var_3.target, "targetname" );

    return var_2;
}

civilian_in_car_get_out( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "death" );

    if ( !isdefined( level.last_car_exit_index ) )
        level.last_car_exit_index = -1;

    var_5 = undefined;

    if ( isdefined( var_4 ) )
    {
        var_5 = var_4;
        level.last_car_exit_index = var_5;
    }
    else
    {
        for (;;)
        {
            if ( isdefined( var_3 ) && var_3 == 1 )
                var_5 = randomintrange( 4, 8 );
            else
                var_5 = randomintrange( 1, 4 );

            if ( var_5 != level.last_car_exit_index )
            {
                level.last_car_exit_index = var_5;
                break;
            }
        }
    }

    var_0["model"] thread maps\_anim::anim_loop_solo( var_1["ai"], "loop_0" + var_5, "stop_driver_loop", "tag_driver" );
    level waittill( var_2 );
    wait(randomfloatrange( 0.0, 2.0 ));
    var_1["ai"] maps\_utility::set_run_anim( "run_0" + var_5, 1 );
    var_1["ai"].run_override_weights = undefined;
    var_0["model"] notify( "stop_driver_loop" );
    var_0["model"] thread maps\_anim::anim_single_solo( var_0["model"], "get_out_0" + var_5 );
    var_0["model"] maps\_anim::anim_single_solo_run( var_1["ai"], "get_out_0" + var_5, "tag_driver" );
    var_1["ai"].ignoresonicaoe = 0;
    var_1["ai"] thread maps\_spawner::go_to_node( var_1["goal"] );
    soundscripts\_snd::snd_message( "panic_walla_oneshots", var_1["ai"] );
    var_1["ai"] thread cower_cleanup_civs_on_goal();

    for (;;)
    {
        var_6 = 0;

        if ( level.player istouching( var_0["door"] ) )
            var_6 = 1;

        var_7 = getaiarray();

        foreach ( var_1 in var_7 )
        {
            if ( isalive( var_1 ) && var_1 istouching( var_0["door"] ) )
                var_6 = 1;
        }

        if ( !var_6 )
            break;

        wait 1;
    }

    var_0["door"] disconnectpaths();
    var_0["door"] solid();
}

cleanup_on_goal()
{
    self waittill( "goal" );
    self delete();
}

cower_cleanup_civs_on_goal()
{
    self waittill( "goal" );
    self stopanimscripted();
    self notify( "drone_stop" );
    self notify( "stop_loop" );
    self notify( "single anim", "end" );
    self notify( "looping anim", "end" );
    thread maps\_anim::anim_loop_solo( self, "civilian_cower" );

    for (;;)
    {
        wait 0.5;

        if ( distance( level.player.origin, self.origin ) > 1000 )
        {
            if ( !maps\_utility::player_looking_at( self.origin, undefined, 1 ) )
                break;
        }
    }

    self delete();
}

civilian_loop_setup( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = getent( var_0, "targetname" );
    var_3[0] = var_4 maps\_utility::spawn_ai( 1, 0 );

    if ( !isdefined( var_3[0] ) )
        return;

    var_3[0].animname = "civilian";
    var_3[0].ignoreall = 1;

    if ( isdefined( var_1 ) )
    {
        var_5 = getent( var_1, "targetname" );
        var_3[1] = var_5 maps\_utility::spawn_ai( 1, 0 );

        if ( !isdefined( var_3[1] ) )
            var_3[0].script_noteworthy = "seated";
        else
        {
            var_3[1].animname = "civilian_b";
            var_3[1].ignoreall = 1;
        }
    }

    level thread start_civilian_loop_anims( var_3, var_2 );

    if ( isdefined( var_4.target ) )
        var_3[0] thread civilian_loop_vo_trigger( var_4 );

    foreach ( var_7 in var_3 )
        var_7 thread no_civilian_friendly_fire_until_seen();
}

no_civilian_friendly_fire_until_seen()
{
    self endon( "death" );
    self.no_friendly_fire_penalty = 1;
    var_0 = 0.05;

    if ( level.currentgen )
        var_0 = 1.0;

    for (;;)
    {
        if ( maps\_utility::player_can_see_ai( self ) )
            break;

        if ( player_can_see_civ( self ) )
            break;

        wait(var_0);
    }

    self.no_friendly_fire_penalty = undefined;
}

player_can_see_civ( var_0 )
{
    if ( !common_scripts\utility::within_fov( level.player.origin, level.player.angles, var_0.origin, 0.743 ) )
        return 0;

    var_1 = level.player geteye();
    var_2 = undefined;

    for ( var_3 = 0; var_3 < 2; var_3++ )
    {
        var_4 = var_0.origin;
        var_5 = var_0 geteye();
        var_6 = ( var_5 + var_4 ) * 0.5;
        var_7 = bullettrace( var_1, var_6, 0, var_2 );

        if ( var_7["fraction"] < 0.99 )
        {
            if ( isdefined( var_7["entity"] ) && isai( var_7["entity"] ) && var_7["entity"] != var_0 )
                var_2 = var_7["entity"];
        }
        else
            return 1;

        if ( !isdefined( var_2 ) )
            break;
    }

    return 0;
}

start_civilian_loop_anims( var_0, var_1 )
{
    wait(randomfloatrange( 0.0, 1.0 ));

    if ( isalive( var_0[0] ) )
    {
        var_0[0] maps\_utility::magic_bullet_shield();
        var_0[0] thread civ_damage_check();
    }

    if ( isalive( var_0[1] ) )
    {
        var_0[1] maps\_utility::magic_bullet_shield();
        var_0[1] thread civ_damage_check();
    }

    if ( isalive( var_0[0] ) && !isalive( var_0[1] ) )
    {
        if ( var_0[0].script_noteworthy == "paired" )
            var_0[0].script_noteworthy = "seated";
    }
    else if ( !isalive( var_0[0] ) && isalive( var_0[1] ) )
    {
        var_0[0] = var_0[1];
        var_0[1] = undefined;
        var_0[0].script_noteworthy = "seated";
    }
    else if ( !isalive( var_0[0] ) && !isalive( var_0[1] ) )
        return;

    if ( !isdefined( var_0[0].script_noteworthy ) )
        return;

    if ( var_0[0].script_noteworthy == "laying" )
    {
        if ( randomint( 100 ) < 50 )
            var_2 = "laying_1";
        else
            var_2 = "laying_2";

        var_0[0] thread maps\_anim::anim_loop_solo( var_0[0], var_2, var_1 );
    }
    else if ( var_0[0].script_noteworthy == "seated" )
    {
        var_3 = randomint( 100 );

        if ( var_3 < 33 )
            var_2 = "seated_1";
        else if ( var_3 < 66 )
            var_2 = "seated_2";
        else
            var_2 = "seated_3";

        var_0[0] thread maps\_anim::anim_loop_solo( var_0[0], var_2, var_1 );
    }
    else if ( var_0[0].script_noteworthy == "paired" )
    {
        if ( randomint( 100 ) < 50 )
            var_2 = "paired_1";
        else
            var_2 = "paired_2";

        var_0[0] thread maps\_anim::anim_loop( var_0, var_2, var_1 );
    }
    else
    {

    }

    level thread civilian_clean_up( var_0, var_1 );
}

civ_damage_check()
{
    self endon( "death" );
    self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

    if ( isplayer( var_1 ) )
    {
        if ( isdefined( self.magic_bullet_shield ) )
            maps\_utility::stop_magic_bullet_shield();

        self startragdoll();
    }
}

civilian_loop_vo_trigger( var_0 )
{
    self endon( "death" );
    var_1 = getent( var_0.target, "targetname" );
    var_1 endon( "death" );

    if ( isdefined( var_1 ) )
    {
        for (;;)
        {
            var_1 waittill( "trigger", var_2 );

            if ( var_2 == level.player )
            {
                maps\sanfran_vo::play_civilian_dialog( self );
                return;
            }
        }
    }
}

civilian_clean_up( var_0, var_1 )
{
    level waittill( var_1 );
    wait 1.0;

    foreach ( var_3 in var_0 )
    {
        if ( isalive( var_3 ) )
        {
            if ( isdefined( var_3.magic_bullet_shield ) )
            {
                var_3 maps\_utility::stop_magic_bullet_shield();
                var_3 notify( var_1 );
                var_3 delete();
                continue;
            }

            var_3 notify( var_1 );
            var_3 delete();
        }
    }
}

add_spawn_behavior( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    foreach ( var_7 in self.spawn_functions )
    {
        var_8 = 1;

        if ( var_7["function"] != var_0 )
            var_8 = 0;
        else
        {
            if ( isdefined( var_7["param1"] ) )
            {
                if ( !isdefined( var_1 ) )
                    var_8 = 0;
                else if ( var_7["param1"] != var_1 )
                    var_8 = 0;
            }
            else if ( isdefined( var_1 ) )
                var_8 = 0;

            if ( isdefined( var_7["param2"] ) )
            {
                if ( !isdefined( var_2 ) )
                    var_8 = 0;
                else if ( var_7["param2"] != var_2 )
                    var_8 = 0;
            }
            else if ( isdefined( var_2 ) )
                var_8 = 0;

            if ( isdefined( var_7["param3"] ) )
            {
                if ( !isdefined( var_3 ) )
                    var_8 = 0;
                else if ( var_7["param3"] != var_3 )
                    var_8 = 0;
            }
            else if ( isdefined( var_3 ) )
                var_8 = 0;

            if ( isdefined( var_7["param4"] ) )
            {
                if ( !isdefined( var_4 ) )
                    var_8 = 0;
                else if ( var_7["param4"] != var_4 )
                    var_8 = 0;
            }
            else if ( isdefined( var_4 ) )
                var_8 = 0;

            if ( isdefined( var_7["param5"] ) )
            {
                if ( !isdefined( var_5 ) )
                    var_8 = 0;
                else if ( var_7["param5"] != var_5 )
                    var_8 = 0;
            }
            else if ( isdefined( var_5 ) )
                var_8 = 0;
        }

        if ( var_8 == 1 )
            return;
    }

    var_10 = [];
    var_10["function"] = var_0;
    var_10["param1"] = var_1;
    var_10["param2"] = var_2;
    var_10["param3"] = var_3;
    var_10["param4"] = var_4;
    var_10["param5"] = var_5;
    self.spawn_functions[self.spawn_functions.size] = var_10;
}

ai_run_behavior_until_condition( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        [[ var_0 ]]( self );

    if ( isdefined( var_2 ) )
        [[ var_2 ]]( self );

    if ( isdefined( var_1 ) )
        [[ var_1 ]]( self );
}

ai_cond_reached_goal( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "goal" );
}

ai_cond_reached_path_end( var_0 )
{
    var_0 endon( "death" );
    var_0 waittill( "reached_path_end" );
}

ai_cond_player_at_police_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_police_battle" );
}

ai_cond_player_at_tanker_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_tanker_battle" );
}

ai_cond_player_at_ambient_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_ambient_battle" );
}

ai_cond_player_at_pitbull_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_pitbull_battle" );

    if ( var_0 == level.bravo )
        var_0 waittill( "dialog_done" );
}

ai_cond_player_at_escape_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_escape_battle" );
}

ai_cond_player_at_standoff_battle( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_player_at_standoff_battle" );
}

ai_cond_player_at_standoff_battle_or_danger_zone( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait_either( "flag_player_at_standoff_battle", "railing_danger_zone_touching" );
}

ai_cond_player_at_van( var_0 )
{
    var_0 endon( "death" );
    common_scripts\utility::flag_wait( "flag_van_explosion_deploy" );
}

ai_empty( var_0 )
{

}

ai_start_magic_bullet_shield( var_0 )
{
    var_0 maps\_utility::magic_bullet_shield();
}

ai_end_magic_bullet_shield( var_0 )
{
    if ( isdefined( var_0.magic_bullet_shield ) && var_0.magic_bullet_shield == 1 )
        var_0 maps\_utility::stop_magic_bullet_shield();
}

ai_start_ignore_all( var_0 )
{
    var_0.ignoreall = 1;
}

ai_end_ignore_all( var_0 )
{
    var_0.ignoreall = 0;
}

ai_start_ignore_me( var_0 )
{
    var_0.ignoreme = 1;
}

ai_end_ignore_me( var_0 )
{
    var_0.ignoreme = 0;
}

ai_start_pacifist( var_0 )
{
    var_0.pacifist = 1;
}

ai_end_fixed_node( var_0 )
{
    var_0.fixednode = 0;
}

ai_delete_self( var_0 )
{
    if ( isdefined( var_0.magic_bullet_shield ) && var_0.magic_bullet_shield == 1 )
        var_0 maps\_utility::stop_magic_bullet_shield();

    wait 0.1;
    var_0 delete();
}

ai_shot_by_player_team_notify()
{
    self endon( "death" );
    level endon( "ai_shot_by_player_team" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( var_1 == level.player )
            break;

        if ( common_scripts\utility::array_contains( level.heroes, var_1 ) )
            break;
    }

    level notify( "ai_shot_by_player_team" );
}

get_single_living_ent( var_0, var_1 )
{
    var_2 = getentarray( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_3 = undefined;

    foreach ( var_5 in var_2 )
    {
        if ( !isalive( var_5 ) )
            continue;

        var_3 = var_5;
    }

    return var_3;
}

ai_start_balcony_death( var_0 )
{
    var_0 notify( "stop_death_function" );
    var_0 balcony_death_anims();
}

ai_start_respawn_death( var_0 )
{
    var_0 notify( "stop_death_function" );

    if ( !isdefined( var_0.spawner ) )
        return;

    var_0.respawn_spawner = var_0.spawner;

    if ( !( weaponclass( var_0.weapon ) == "rocketlauncher" ) )
        var_0.deathfunction = ::try_respawn_death;
    else
        var_0 thread wait_till_death_try_respawn_death();
}

ai_stop_death_function( var_0 )
{
    var_0.deathfunction = undefined;
    var_0 notify( "stop_death_function" );
}

wait_till_death_try_respawn_death()
{
    self endon( "stop_death_function" );
    self waittill( "death" );
    try_respawn_death();
}

try_respawn_death()
{
    if ( !isdefined( self.respawn_spawner ) )
        return;

    self.respawn_spawner.count++;

    if ( isdefined( self.respawn_spawner.script_aigroup ) )
        self.respawn_spawner thread maps\_spawner::aigroup_spawnerthink( level._ai_group[self.respawn_spawner.script_aigroup] );

    level thread respawn_death_spawn( self.respawn_spawner );
    return 0;
}

respawn_death_spawn( var_0 )
{
    wait(randomfloatrange( 2, 6 ));
    var_0 maps\_utility::spawn_ai( 1, 0 );
}

ai_add_player_only_damage( var_0 )
{
    var_0 maps\_utility::add_damage_function( ::ai_player_only_damage_func );
}

ai_remove_player_only_damage( var_0 )
{
    var_0 maps\_utility::remove_damage_function( ::ai_player_only_damage_func );
}

ai_player_only_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isplayer( var_1 ) )
    {
        if ( isdefined( var_1 ) && var_1.classname == "trigger_hurt" )
            return;

        self.health += var_0;
    }
}

ai_add_twenty_percent_damage( var_0 )
{
    var_0 maps\_utility::add_damage_function( ::ai_twenty_percent_damage_func );
}

ai_remove_twenty_percent_damage( var_0 )
{
    var_0 maps\_utility::remove_damage_function( ::ai_twenty_percent_damage_func );
}

ai_twenty_percent_damage_func( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isplayer( var_1 ) )
    {
        if ( isdefined( var_1 ) && var_1.classname == "trigger_hurt" )
            return;

        var_7 = int( var_0 * 0.8 );

        if ( self.health + var_7 > 0 )
            self.health += var_7;
    }
}

notify_drones_all_dead( var_0, var_1 )
{
    for (;;)
    {
        var_2 = 0;

        foreach ( var_4 in var_0 )
        {
            if ( isalive( var_4 ) )
                var_2 = 1;
        }

        if ( !var_2 )
            break;

        wait 0.05;
    }

    common_scripts\utility::flag_set( var_1 );
}

heli_shoot_enemies()
{
    self endon( "death" );
    var_0 = heli_get_shooters();

    foreach ( var_2 in var_0 )
    {
        var_3 = spawn( "script_model", ( 0, 0, 0 ) );
        var_3 setmodel( "tag_laser" );
        var_3.origin = var_2 gettagorigin( "tag_flash" );
        var_3.angles = var_2 gettagangles( "tag_flash" );
        var_3 laseron();
        var_2.fake_laser = var_3;
        var_2 thread delete_laser_on_death();
        var_2 thread force_fake_laser_origin_link();
        thread heli_shoot_enemy_trace_then_fire( var_2 );
    }
}

force_fake_laser_origin_link()
{
    self endon( "death" );

    for (;;)
    {
        self.fake_laser.origin = self gettagorigin( "tag_flash" );
        wait 0.05;
    }
}

delete_laser_on_death()
{
    self waittill( "death" );
    self.fake_laser delete();
}

heli_shoot_enemy_trace_then_fire( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        wait 0.05;
        var_1 = getaiarray( "axis" );

        if ( var_1.size <= 0 )
            continue;

        var_1 = common_scripts\utility::array_randomize( var_1 );
        var_2 = 0;

        if ( randomint( 100 ) < 25 )
            var_2 = 1;

        var_3 = undefined;

        if ( var_2 )
        {
            var_3 = get_accurate_target( var_1, var_0 );

            if ( !isdefined( var_3 ) )
                var_3 = var_1[0];
        }
        else
            var_3 = var_1[0];

        var_4 = gettime() + randomfloatrange( 8.0, 12.0 ) * 1000;

        while ( gettime() < var_4 && isalive( var_3 ) )
        {
            if ( var_3.a.pose == "stand" )
                var_5 = var_3.origin + ( 0, 0, 64 ) - var_0.fake_laser.origin;
            else
                var_5 = var_3.origin + ( 0, 0, 32 ) - var_0.fake_laser.origin;

            var_6 = vectortoangles( var_5 );
            var_0.fake_laser rotateto( var_6, 0.25 );
            wait 0.25;
        }

        if ( maps\_utility::ent_flag( "heli_can_shoot" ) && isalive( var_3 ) )
        {
            var_7 = var_0 gettagorigin( "tag_flash" );

            if ( var_3.a.pose == "stand" || var_2 == 0 )
                var_8 = var_3.origin + ( 0, 0, 64 );
            else
                var_8 = var_3.origin + ( 0, 0, 32 );

            var_9 = bullettrace( var_7, var_8, 1 );
            magicbullet( "iw5_mors_sp", var_7, var_8 );
            bullettracer( var_7, var_8 );
        }
    }
}

get_accurate_target( var_0, var_1 )
{
    var_2 = var_1 gettagorigin( "tag_flash" );

    foreach ( var_4 in var_0 )
    {
        var_5 = var_4.origin + ( 0, 0, 64 );
        var_6 = bullettrace( var_2, var_5, 1 );

        if ( isdefined( var_6["entity"] ) && var_6["entity"] == var_4 )
            return var_4;
    }

    return undefined;
}

heli_get_shooters()
{
    var_0 = [];

    foreach ( var_2 in self.riders )
    {
        if ( var_2.vehicle_position == 0 || var_2.vehicle_position == 1 )
            continue;

        var_0[var_0.size] = var_2;
    }

    return var_0;
}

heli_toggle_shoot()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "allow_heli_shoot" );
        maps\_utility::ent_flag_set( "heli_can_shoot" );
        common_scripts\utility::flag_set( "flag_dialog_street_helo_onsite" );
    }
}

riders_no_damage()
{
    foreach ( var_1 in self.riders )
        var_1 maps\_utility::deletable_magic_bullet_shield();
}

player_can_see( var_0, var_1 )
{
    var_2 = anglestoforward( level.player.angles );
    var_3 = vectornormalize( var_0 - level.player.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > cos( var_1 ) )
        return 1;

    return 0;
}

get_black_overlay()
{
    if ( !isdefined( level.black_overlay ) )
        level.black_overlay = maps\_hud_util::create_client_overlay( "black", 0, level.player );

    level.black_overlay.sort = -1;
    level.black_overlay.foreground = 1;
    return level.black_overlay;
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
    setblur( var_2, var_0 );
    wait(var_0);
}

setup_dont_leave_hint()
{
    level endon( "mission failed" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "player_leaving_map" );
        maps\_utility::display_hint( "hint_dont_leave_mission" );
        common_scripts\utility::flag_wait_either( "player_leaving_map", "player_returning_to_map" );
        waitframe();
    }
}

should_break_dont_leave()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "player_returning_to_map" ) )
        return 1;
    else
        return 0;
}

setup_dont_leave_failure()
{
    common_scripts\utility::flag_wait( "player_left_map" );
    level notify( "mission failed" );
    setdvar( "ui_deadquote", &"SANFRAN_FAIL_SKIP_OBJECTIVE" );
    maps\_utility::missionfailedwrapper();
}

fall_fail()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( var_0 == level.player )
        {
            setblur( 5, 0.5 );
            thread player_falling_kill_logic( 1.5 );
            level.player disableweapons();
            var_1 = spawn( "script_origin", level.player.origin );
            var_1.angles = ( -90, 360, 0 );
            var_1 movegravity( level.player getvelocity(), 15 );
            level.player playerlinktoblend( var_1, undefined, 1.2 );
            setdvar( "ui_deadquote", &"SANFRAN_FAIL_SKIP_OBJECTIVE" );
            thread introscreen_generic_fade_out( "black", 999, 0, 1 );
            maps\_utility::missionfailedwrapper();
            break;
        }
    }
}

fail_player_for_abandon()
{
    for (;;)
    {
        var_0 = -1;

        foreach ( var_2 in level.heroes )
        {
            if ( var_2.origin[0] > level.player.origin[0] )
            {
                var_0 = -1;
                break;
            }

            var_3 = level.player.origin[0] - var_2.origin[0];

            if ( var_3 < var_0 || var_0 == -1 )
                var_0 = var_3;
        }

        if ( var_0 != -1 )
        {
            if ( var_0 > 3000 )
            {
                setdvar( "ui_deadquote", &"SANFRAN_FAIL_LEAVING_SQUAD" );
                maps\_utility::missionfailedwrapper();
            }
            else if ( var_0 > 2500 )
                player_left_squad_hint();
            else
                common_scripts\utility::flag_clear( "flag_hint_player_left_squad" );
        }
        else
            common_scripts\utility::flag_clear( "flag_hint_player_left_squad" );

        wait 0.15;
    }
}

player_abandon_squad_distance_think()
{
    level endon( "gg_start_bridge_collapse" );
    level.axis_global_accuracy_mod = 0;
    var_0 = 1200;
    var_1 = undefined;
    var_2 = -1;

    for (;;)
    {
        if ( level.burke.origin[0] < level.player.origin[0] )
        {
            wait 1;
            var_1 = undefined;
            continue;
        }

        var_3 = level.burke.origin[0] - level.player.origin[0];

        if ( var_3 < var_2 || var_2 == -1 )
            var_2 = var_3;

        if ( isdefined( var_1 ) && var_3 < var_0 )
        {
            var_1 = undefined;
            level.axis_global_accuracy_mod = 0;
            level notify( "global_accuracy_mod_event" );
        }

        if ( var_3 > var_0 )
        {
            var_1 = var_3 - var_0;
            var_4 = var_1 / 100;

            if ( var_4 > 10 )
                var_4 = 10;

            level.axis_global_accuracy_mod = var_4;
            level notify( "global_accuracy_mod_event" );
        }

        wait 1;
    }
}

player_falling_kill_logic( var_0 )
{
    var_1 = int( tablelookup( "sp/deathQuoteTable.csv", 1, "size", 0 ) );
    var_2 = randomint( var_1 );
    var_3 = "player_falling_kill_in_progress";

    if ( common_scripts\utility::flag( var_3 ) )
        return;
    else
        common_scripts\utility::flag_set( var_3 );

    if ( !isdefined( var_0 ) )
        var_0 = 3;

    common_scripts\utility::flag_clear( "can_save" );
    var_4 = gettime() + var_0 * 1000;

    while ( !level.player isonground() && gettime() < var_4 )
        wait 0.05;

    if ( level.player isonground() )
        level.player kill();
    else
        maps\_utility::missionfailedwrapper();
}

introscreen_generic_fade_out( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1.5;

    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 0;
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.foreground = 0;
    var_4 setshader( var_0, 640, 480 );

    if ( isdefined( var_3 ) && var_3 > 0 )
    {
        var_4.alpha = 0;
        var_4 fadeovertime( var_3 );
        var_4.alpha = 1;
        wait(var_3);
    }

    wait(var_1);

    if ( isdefined( var_2 ) && var_2 > 0 )
    {
        var_4.alpha = 1;
        var_4 fadeovertime( var_2 );
        var_4.alpha = 0;
    }

    var_4 destroy();
}

player_damage_atlas_flag_set( var_0 )
{
    self endon( "death" );
    self endon( "flag_already_set" );
    var_1 = undefined;
    var_2 = undefined;

    for (;;)
    {
        self waittill( "damage", var_2, var_1 );

        if ( isdefined( var_1 ) && var_1 == level.player )
        {
            if ( common_scripts\utility::flag( var_0 ) )
            {
                self notify( "flag_already_set" );
                waittillframeend;
            }

            break;
        }
    }

    common_scripts\utility::flag_set( var_0 );
}

waittill_aigroupcount_or_flag( var_0, var_1, var_2 )
{
    level endon( var_2 );

    if ( !common_scripts\utility::flag( var_2 ) )
        maps\_utility::waittill_aigroupcount( var_0, var_1 );
}
