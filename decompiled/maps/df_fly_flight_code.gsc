// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

flight_code_main()
{
    level.user_controlled_plane = 1;
    level.fps_controls = 1;
    level.plane_intialized = 0;
    level.num_objectives_visable = 0;
    level.player_boosting = 0;
    level.player_braking = 0;
    level.enemy_locking_on_to_player = 0;
    level.last_missile_fired_at_player = 0;
    level.default_player_dist = 2000;
    level.flares_active = 0;
    level.friend_jets = [];
    precacheshellshock( "s19_cannon_player_test" );
    precacheshellshock( "s19_cannon_AI" );
    precacheshellshock( "sidewinder_atlas_jet" );
    precachemodel( "vehicle_s19" );
    precachemodel( "vfx_atlas_fighter_jet_dest_body_01" );
    precachemodel( "vfx_atlas_fighter_jet_dest_wing_lt" );
    precachemodel( "vfx_atlas_fighter_jet_dest_wing_rt" );
    precacheshader( "jet_HUD_hex_blue" );
    precacheshader( "jet_HUD_hex_orange" );
    precacheshader( "jet_hud_target_bullet_lock" );
    precacheshader( "jet_HUD_diamond_green" );
    precacheshader( "jet_HUD_ground_target" );
    precacheshader( "coop_class_icon_vangard" );
    precacheshader( "veh_hud_target" );
    precacheshader( "jet_hud_overlay_cannon_1" );
    precacheshader( "jet_hud_overlay_cannon_boresight" );
    precacheshader( "jet_hud_overlay_cannon_boresight_lockon" );
    precacheshader( "jet_hud_overlay_cannon_reticle" );
    precacheshader( "jet_hud_overlay_cannon_reticle_lockon" );
    precacheshader( "jet_hud_overlay_missile_1" );
    precacheshader( "jet_hud_missile_circle" );
    precacheshader( "jet_hud_red_doublecircle" );
    precacheshader( "jet_hud_overlay_bomb_1" );
    precacheshader( "jet_hud_incoming_missile" );
    precacheshader( "jet_hud_locking_on" );
    precacheshader( "jet_hud_locking_on_small" );
    precacheshader( "jet_hud_lockon_missile" );
    precacheshader( "jet_hud_overlay_missile_lockon" );
    precacheshader( "jet_hud_overlay_cannon_lockon" );
    precacheshader( "jet_hud_overlay_bomb_lockon" );
    precacheshader( "jet_hud_ground_target_lockon" );
    precacheshader( "jet_hud_pip_missile_1" );
    precacheshader( "jet_hud_overlay_bomb_flight" );
    precacheshader( "jet_hud_follow" );
    precacheshader( "jet_hud_missile_indicator" );
    precacheshader( "jet_hud_ammo_missile_0" );
    precacheshader( "jet_hud_ammo_missile_1" );
    precacheshader( "jet_hud_follow_white" );
    precacheshader( "jet_hud_lockon_bomb_1" );
    precacheshader( "jet_hud_lockon_bomb_2" );
    precacheshader( "jet_hud_overlay_reentry" );
    precacheshader( "jet_reentry_target" );
    precacheshader( "jet_hud_locking_on_1" );
    precacheshader( "jet_hud_locking_on_2" );
    precacheshader( "jet_hud_locking_on_3" );
    precacheshader( "jet_hud_locking_on_4" );
    precacheshader( "jet_hud_locking_on_5" );
    precacheshader( "jet_hud_locking_on_6" );
    precacheshader( "jet_hud_locking_on_7" );
    precacheshader( "jet_hud_locking_on_8" );
    precacheshader( "jet_hud_locking_on_9" );
    precacheshader( "jet_hud_locking_on_10" );
    precacheshader( "jet_hud_locking_on_11" );
    precacheshader( "jet_hud_locking_on_12" );
    precacheshader( "jet_hud_locking_on_13" );
    precacheshader( "jet_hud_locking_on_14" );
    precacheshader( "jet_hud_locking_on_15" );
    precacheshader( "jet_hud_locking_on_16" );
    precacheshader( "jet_hud_bomb_locking_on_1" );
    precacheshader( "jet_hud_bomb_locking_on_2" );
    precacheshader( "jet_hud_bomb_locking_on_3" );
    precacheshader( "jet_hud_bomb_locking_on_4" );
    precacheshader( "jet_hud_bomb_locking_on_5" );
    precacheshader( "jet_hud_bomb_locking_on_6" );
    precacheshader( "jet_hud_bomb_locking_on_7" );
    precacheshader( "jet_hud_bomb_locking_on_8" );
    precacheshader( "jet_hud_bomb_locking_on_9" );
    precacheshader( "jet_hud_bomb_locking_on_10" );
    precacheshader( "jet_hud_bomb_locking_on_11" );
    precacheshader( "jet_hud_bomb_locking_on_12" );
    precacheshader( "jet_hud_bomb_locking_on_13" );
    precacheshader( "jet_hud_bomb_locking_on_14" );
    precacheshader( "jet_hud_bomb_locking_on_15" );
    precacheshader( "jet_hud_bomb_locking_on_16" );
    precacheshader( "jet_hud_hex_blue_distort_1" );
    precacheshader( "jet_hud_hex_blue_distort_2" );
    precacheshader( "hud_plane_enemy" );
    precacheshader( "hud_fofbox_hostile_obstructed" );
    precacheshader( "hud_plane_horizon" );
    precacheshader( "hud_plane_mg" );
    precacheshader( "hud_plane_missile" );
    precacheshader( "hud_plane_reticle" );
    precacheshader( "hud_plane_controls_button" );
    precacheshader( "hud_plane_mg_button" );
    precacheshader( "hud_plane_missile_button" );
    precacheshader( "hud_plane_thrust_button" );
    precachedigitaldistortcodeassets();
}

change_optimal_flight_distance( var_0 )
{
    self.default_player_dist += var_0;
    self.infront_dist_min += var_0;
    self.infront_dist_max += var_0;
}

set_optimal_flight_dist( var_0, var_1 )
{
    if ( isdefined( self ) )
    {
        self.default_player_dist = var_0;
        self.infront_dist_min = var_0 - 500;
        self.infront_dist_max = var_0 + 500;
    }
}

steering_hack()
{
    setsaveddvar( "vehPlanePathAllowance", 45 );
    common_scripts\utility::flag_wait( "go_wide" );
    setsaveddvar( "vehPlanePathAllowance", 60.0 );
}

flight_code_start( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "player_mig";

    setsaveddvar( "vehPlanePathAllowance", 60.0 );
    level.plane = getent( var_0, "targetname" );
    level.plane maps\_vehicle::godon();
    level.plane maps\_utility::ent_flag_clear( "engineeffects" );
    level.plane.lock_targets = [];
    level.plane.bomb_tag = level.plane common_scripts\utility::spawn_tag_origin();
    level.plane.bomb_tag linkto( level.plane, "tag_origin" );
    thread init_jet_crash_points();
    var_2 = getentarray( "player_vehicle", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 != level.plane )
            var_4 delete();
    }

    if ( level.mini_version )
        level.plane plane_test( 50 );
    else
        level.plane plane_test( undefined, undefined, var_1 );
}

debug_friendly_death()
{
    while ( isdefined( self ) && self.health > 1 )
        wait 0.05;

    if ( isdefined( self ) && isdefined( self.targetname ) )
    {
        var_0 = self.targetname;
        iprintlnbold( "friendly dead", var_0 );
    }
}

target_cycleshader( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0 endon( "stop_target_cycle" );

    if ( !isdefined( var_3 ) )
        var_3 = 0.5;

    while ( target_istarget( var_0 ) )
    {
        target_setshadersafe( var_0, var_1 );
        wait(var_3);
        target_setshadersafe( var_0, var_2 );
        wait(var_3);
    }
}

make_ally_jet( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_3 = self;
    var_4 = var_3 maps\_vehicle::spawn_vehicle_and_gopath();

    if ( isdefined( var_3.script_parameters ) )
        var_5 = int( var_3.script_parameters );
    else
        var_5 = 3000;

    var_4 set_optimal_flight_dist( var_5, is_true( var_2 ) || !is_true( var_1 ) );
    var_4.missiletags_right = [ "tag_right_wingtip" ];
    var_4.missiletags_left = [ "tag_left_wingtip" ];
    var_4.salvo_ammo = [];
    var_4.salvo_ammo[0] = 4;
    var_4.mgun_left = "tag_left_wingtip";
    var_4.mgun_right = "tag_right_wingtip";
    var_4.has_flares = 999;
    var_4 thread fly_think( var_0, 1.0, 1.0, 0 );

    if ( var_1 )
    {
        level.allies[level.allies.size] = var_4;
        var_4 thread ally_jet_shoot_think();
    }
    else
    {
        var_4 hide();
        var_4 maps\_utility::ent_flag_clear( "engineeffects" );
        level.friend_jets[level.friend_jets.size] = var_4;
        var_4 maps\_vehicle::godon();
    }

    return var_4;
}

spawn_enemy_jets( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "targetname";

    var_3 = getentarray( var_0, var_1 );
    var_4 = [];

    foreach ( var_6 in var_3 )
    {
        var_7 = var_6 maps\_vehicle::spawn_vehicle_and_gopath();

        if ( is_true( var_2 ) )
            var_7 maps\_vehicle::godon();

        if ( isdefined( var_6.script_parameters ) )
            var_8 = int( var_6.script_parameters );
        else
            var_8 = 3000;

        var_7 set_optimal_flight_dist( var_8 );
        var_7 thread make_enemy_jet();
        var_4[var_4.size] = var_7;
    }

    return var_4;
}

make_enemy_jet( var_0, var_1, var_2 )
{
    if ( !isdefined( level.vehicle_death_jolt ) )
        level.vehicle_death_jolt = [];

    var_3 = spawnstruct();
    var_3.delay = 9999;
    level.vehicle_death_jolt["script_vehicle_mig29"] = var_3;
    self.salvo_ammo = [];
    self.salvo_ammo[0] = 4;
    self.mgun_left = "tag_gun_left";
    self.mgun_right = "tag_gun_right";
    self.has_flares = 1;
    self.last_flare_time = 0;
    self.ignore_death_fx = 1;
    self.script_ai_invulnerable = 1;
    level.enemy_units[level.enemy_units.size] = self;
    thread monitor_enemy_jet_health();
    self.default_hud = "hud_fofbox_hostile_obstructed";
    thread hud_target_think();
    thread fly_think( level.plane, 1, 1, var_1 );

    if ( isdefined( var_2 ) )
    {
        if ( level.next_obj_pos == 0 )
            objective_onentity( maps\_utility::obj( var_2 ), self );

        objective_additionalentity( maps\_utility::obj( var_2 ), level.next_obj_pos, self );
        level.next_obj_pos++;
    }

    thread wait_for_death();
    thread enemy_jet_shoot_think();
}

wait_for_death()
{
    self waittill( "death", var_0 );

    if ( isdefined( var_0 ) && var_0 == level.player )
        level notify( "enemy_dead_by_player" );
    else
        level notify( "enemy_dead" );
}

make_enemy_jet_special( var_0, var_1 )
{
    target_setsafe( self );
    thread target_cycleshader( self, "jet_hud_hex_blue_distort_1", "jet_hud_hex_blue_distort_2", 0.1 );
    var_2 = [ level.plane ];
    thread monitor_enemy_jet_health();
    thread fly_think( level.plane, 1, 1, var_1 );
}

monitor_enemy_jet_health()
{
    level endon( "end_canyon" );
    self.script_crashtypeoverride = "none";
    var_0 = check_health();
    burn_and_crash( var_0 );
}

physics_crash( var_0 )
{
    if ( isdefined( self ) )
        self delete();

    var_1 = spawn( "script_model", var_0["org"] );
    var_1.angles = var_0["ang"];
    var_1 setmodel( "vehicle_mig29" );
    var_1 thread add_damage_fx();
    var_2 = 10;
    var_3 = var_0["velocity"] * var_2;
    var_4 = vectorlerp( var_0["org"], var_0["point"], 0.5 );
    var_1 physicslaunchserver( var_4, var_3 );
    delete_on_crash( var_1 );
}

burn_and_crash( var_0 )
{
    if ( !isdefined( self ) || isremovedentity( self ) )
        return;

    if ( target_istarget( self ) )
        target_remove( self );

    level.enemy_units = common_scripts\utility::array_remove( level.enemy_units, self );
    var_1 = vectornormalize( self.origin - var_0["point"] );
    var_2 = var_1 * 50 * 17.6;
    var_3 = ( 0, 0, 100 );
    self vehicle_addvelocity( var_2, var_3 );
    var_4 = choose_crash_path();
    var_5 = 0;
    maps\_utility::ent_flag_clear( "engineeffects" );

    if ( isdefined( var_4 ) )
    {
        var_6 = playfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_fire_trail" ), self, "tag_origin" );
        playfx( common_scripts\utility::getfx( "missile_explode" ), self.origin, anglestoforward( self.angles ) * -1 );
        var_4.claimed = 1;
        self notify( "newpath" );
        self vehicledriveto( var_4.origin, self.veh_pathspeed );

        if ( isdefined( var_4.target ) )
            follow_crash_path( var_4 );
    }
    else
    {
        maps\df_fly_fx::vfx_handle_disintegrating_jet();
        var_5 = 1;
    }

    if ( !var_5 )
    {
        var_7 = gettime();
        var_8 = self.origin;
        var_9 = var_7 + randomfloatrange( 2.0, 3.0 ) * 1000;
        var_10 = 0;

        while ( isdefined( self ) && ( isdefined( var_4 ) || gettime() < var_9 ) )
        {
            if ( isdefined( self.dragging ) && self.dragging )
                return;

            if ( !bullettracepassed( var_8, self.origin, 0, self ) )
            {
                var_10 = 1;
                break;
            }

            var_8 = self.origin;
            waitframe();
        }

        if ( isdefined( self ) && !var_10 )
        {
            var_11 = [];
            var_11["org"] = self.origin;
            var_11["ang"] = self.angles;
            var_11["velocity"] = var_0["velocity"];
            var_11["point"] = self.origin;
            var_11["direction_vec"] = self.angles;
            physics_crash( var_11 );
        }

        if ( isdefined( self ) )
        {
            stopfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_fire_trail" ), self, "tag_origin" );
            playfx( level._effect["canyon_jet_impact"], self.origin );
            self delete();
        }
    }
}

follow_crash_path( var_0 )
{
    while ( isdefined( self ) && isdefined( var_0.target ) )
    {
        if ( distancesquared( self.origin, var_0.origin ) < 62500 )
        {
            if ( isdefined( var_0.script_noteworthy ) && var_0.script_noteworthy == "drag" && !is_true( self.dragging ) )
            {
                self.dragging = 1;
                self cancelaimove();
                self hide();
                var_1 = spawn( "script_model", self.origin );
                var_1.angles = self.angles;
                var_1 setmodel( self.model );
                var_1 show();
                stopfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_fire_trail" ), self, "tag_origin" );
                playfx( common_scripts\utility::getfx( "canyon_jet_impact" ), var_1.origin, anglestoforward( var_1.angles ) * -1 );
                playfxontag( common_scripts\utility::getfx( "bagh_tanker_dust_trail_small" ), var_1, "tag_origin" );
                var_2 = self.veh_pathspeed;

                while ( isdefined( var_0.target ) )
                {
                    var_0 = getvehiclenode( var_0.target, "targetname" );
                    var_3 = distance( var_1.origin, var_0.origin ) / var_2 * 17.6;
                    var_1 moveto( var_0.origin, var_3 );
                    var_1 rotateto( var_0.angles, var_3 );
                    wait(var_3);
                }

                playfx( level._effect["canyon_jet_impact"], var_1.origin );
                var_1 delete();

                if ( isdefined( self ) )
                    self delete();

                return;
            }

            var_0 = getvehiclenode( var_0.target, "targetname" );

            if ( isdefined( var_0 ) )
                self vehicledriveto( var_0.origin, self.veh_pathspeed );
            else
                break;
        }

        wait 0.05;
    }
}

delete_on_crash( var_0 )
{
    var_1 = 0;

    while ( isdefined( var_0 ) && ( length( var_0 maps\_shg_utility::get_differentiated_acceleration() ) < 1000 || var_1 < 3 ) && var_1 < 100 )
    {
        var_1++;
        waitframe();
    }

    var_2 = var_0.differentiated_last_velocity;

    if ( var_2 == ( 0, 0, 0 ) )
        var_2 = -1 * anglestoforward( var_0.angles );

    playfx( level._effect["canyon_jet_impact"], var_0.origin, var_0.differentiated_last_velocity );
    var_0 delete();
}

add_damage_fx()
{
    level endon( "finale" );
    var_0 = [ "tag_right_wingtip", "tag_left_wingtip" ];
    var_1 = randomint( var_0.size );
    var_2 = playfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_trail" ), self, "tag_origin" );

    while ( isalive( self ) && self.health > self.healthbuffer )
    {
        if ( !isdefined( self ) )
            break;

        wait 0.05;
    }

    if ( isdefined( self ) )
        stopfxontag( common_scripts\utility::getfx( "bagh_aircraft_damage_trail" ), self, "tag_origin" );
}

check_health( var_0 )
{
    level endon( "end_canyon" );
    maps\_vehicle::vehicle_set_health( 3000 );
    self.script_bulletshield = undefined;
    self.script_explosive_bullet_shield = undefined;
    self.script_ai_invulnerable = undefined;
    self.script_grenadeshield = undefined;
    self.vehicle_stays_alive = 1;
    var_1 = [];
    var_1["org"] = self.origin;
    var_1["ang"] = self.angles;
    var_1["velocity"] = self vehicle_getvelocity();
    var_1["point"] = self.origin;
    var_1["direction_vec"] = self.angles;
    var_2 = 0;
    var_3 = self.health - self.healthbuffer;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    while ( isalive( self ) && self.health > self.healthbuffer )
    {
        self waittill( "damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16 );
        var_4 = var_8;
        var_5 = var_11;
        var_6 = var_16;

        if ( isalive( self ) )
        {
            if ( var_8 == level.player )
            {
                if ( var_11 == "MOD_EXPLOSIVE" )
                    self dodamage( var_7, var_10, var_8 );
                else
                    self dodamage( self.maxhealth / 100, var_10, var_8 );

                self playsound( "enemy_jet_mid_air_damage" );
            }

            var_1["direction_vec"] = var_9;
            var_1["point"] = var_10;
            var_1["org"] = self.origin;
            var_1["ang"] = self.angles;
            var_1["velocity"] = self vehicle_getvelocity();

            if ( !var_2 && self.health > self.healthbuffer )
            {
                thread add_damage_fx();
                var_2 = 1;
            }
        }
    }

    if ( var_4 == level.player )
    {
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );

        if ( isdefined( var_6 ) && var_6 == "s19_cannon_player_test" )
        {
            if ( !isdefined( level.maverick_counter ) )
                level.maverick_counter = 0;

            level.maverick_counter++;

            if ( level.maverick_counter == 10 )
                maps\_utility::giveachievement_wrapper( "LEVEL_13A" );
        }
    }

    var_17 = self.origin;
    var_18 = self.angles;

    if ( isdefined( var_17 ) )
        var_1["org"] = var_17;

    if ( isdefined( var_18 ) )
        var_1["ang"] = var_18;

    return var_1;
}

fly_think( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( common_scripts\utility::flag( "end_fighter_jet_sequence" ) )
        return;

    if ( !var_3 )
        thread fly_think_constrained( var_0, var_1, var_2 );
    else
        thread fly_think_autopilot( var_0, var_1, var_2 );
}

check_flight_distances()
{
    if ( !isdefined( self.default_player_dist ) )
        self.default_player_dist = level.default_player_dist;

    self.infront_dist_min = self.default_player_dist - 500;
    self.infront_dist_max = self.default_player_dist + 500;
}

fly_think_constrained( var_0, var_1, var_2 )
{
    level endon( "end_canyon" );
    self endon( "death" );

    if ( isdefined( self.no_path ) )
    {
        thread fly_think_formation( var_0 );
        return;
    }

    check_flight_distances();

    if ( self.default_player_dist != 0 )
    {
        var_3 = level.plane vehicle_getspeed();
        self vehicle_setspeedimmediate( var_3 * 0.75, 100, 50 );
    }

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        if ( self.default_player_dist == 0 )
        {
            wait 0.1;
            continue;
        }

        var_4 = maps\_utility::get_dot( self.origin, self.angles, var_0.origin );
        var_5 = anglestoforward( var_0.angles ) * self.default_player_dist;
        var_6 = distance( var_0.missile_target.origin, self.origin );
        var_7 = distance( var_0.origin, self.origin );
        var_8 = var_7;

        if ( var_4 > 0 )
            var_8 = self.default_player_dist + var_7;
        else
            var_8 = var_7 - self.default_player_dist;

        var_3 = var_0 vehicle_getspeed();
        var_3 += randomfloatrange( -5.0, 5.0 );
        var_9 = 1.0;
        var_10 = 1.0;

        if ( level.player_boosting && self.default_player_dist > 0 )
        {
            var_11 = 10;
            var_12 = gettime() - level.player_boost_time + 1.0;
            var_13 = clamp( var_12 / var_11 * 1000, 0.5, 1.0 );
            var_9 = ( var_13 - 1 ) * self.default_player_dist;

            if ( self.script_team == "allies" )
                var_10 *= var_13;
            else
                var_10 *= var_13;
        }

        if ( level.player_braking )
        {
            var_9 = 10000;
            var_10 *= 10;

            if ( self.default_player_dist < 0 )
                var_10 *= 10;
        }

        if ( var_4 > 0 && self.default_player_dist > 0 )
            var_10 *= 2;

        var_14 = 5000;
        var_15 = 1 / abs( var_4 );
        var_15 *= var_8 / 1000;
        var_15 *= var_10;
        var_15 = clamp( var_15, 0.5, 100 );
        var_16 = self.default_player_dist + var_9;

        if ( var_16 < 0 )
        {
            if ( var_4 < 0 )
                var_3 += var_15 * randomfloatrange( -65.0, -40.0 );
            else if ( var_8 > abs( self.infront_dist_min + var_9 ) * var_1 )
                var_3 += var_15 * randomfloatrange( 100, 300.0 );
            else
                var_3 -= var_15 * randomfloatrange( 6, 9.0 );
        }
        else if ( var_4 > 0 || var_7 < ( var_9 + self.infront_dist_min ) * var_1 )
            var_3 += var_15 * randomfloatrange( 20, 25.0 );
        else if ( var_4 < 0 )
        {
            if ( var_8 < ( var_9 + self.infront_dist_max ) * var_2 )
                var_3 += var_15 * randomfloatrange( 6, 9.0 );
            else
                var_3 += var_15 * randomfloatrange( -20.0, -15.0 );
        }

        var_3 = clamp( var_3, 300, 800 );
        self vehicle_setspeed( var_3, 100, 50 );
        wait 0.25;
    }
}

fly_think_autopilot( var_0, var_1, var_2 )
{
    level endon( "end_canyon" );
    self endon( "death" );
    self.is_autopilot = 1;

    if ( isdefined( self.no_path ) )
    {
        thread fly_think_formation( var_0 );
        return;
    }

    setsaveddvar( "vehPlaneAiRollResponseRate", 0.1 );
    setsaveddvar( "vehPlaneAiPitchResponseRate", 0.1 );
    setsaveddvar( "vehPlaneAiYawResponseRate", 0.2 );
    var_3 = 1;
    var_4 = 1;
    var_5 = getvehiclenode( self.target, "targetname" );
    var_6 = 0;
    var_7 = self.origin;
    var_8 = 1;
    var_9 = var_5.origin;
    var_10 = var_5.speed;
    check_flight_distances();

    while ( isdefined( var_5.target ) )
    {
        var_11 = getvehiclenodearray( var_5.target, "targetname" );
        var_12 = var_11[0];

        if ( !isdefined( var_12 ) )
            break;

        var_6 = 0;
        var_13 = 0;

        while ( var_6 < 1 )
        {
            while ( var_6 < 1 )
            {
                var_14 = vectorlerp( var_5.origin, var_12.origin, var_6 );
                var_10 = maps\_utility::linear_interpolate( var_6, var_5.speed, var_12.speed );
                var_8 = maps\_utility::linear_interpolate( var_6, var_5.lookahead, var_12.lookahead ) * var_4;
                var_13 = var_8 * var_10;

                if ( vectordot( var_14 - self.origin, vectornormalize( var_12.origin - var_5.origin ) ) > var_13 )
                    break;

                var_7 = var_14;
                var_6 += 0.01;
            }

            if ( var_6 < 1 )
            {
                if ( !isdefined( self ) )
                    break;

                if ( var_3 )
                {
                    var_15 = vectornormalize( var_7 - self.origin );
                    var_16 = vectortoangles( var_15 );
                    var_16 = ( var_16[0], var_16[1], var_5.angles[2] );
                    self vehicle_teleport( self.origin, var_16 );
                    self vehicle_setvelocity( var_15 * var_12.speed, ( 0, 0, 0 ) );
                    var_3 = 0;
                }

                var_17 = vectordot( anglestoforward( var_0.angles ), self.origin - var_0.origin );
                var_18 = clamp( var_17, self.infront_dist_min * var_1, self.infront_dist_max * var_2 );
                var_19 = var_17 - var_18;

                if ( var_19 > 0 )
                    var_20 = -87.5;
                else
                    var_20 = 55;

                var_21 = var_0 vehicle_getspeed() + var_20;
                var_21 = clamp( var_21, 50, 800 );
                var_22 = var_9;
                var_9 = var_7 + vectornormalize( var_9 - var_7 ) * var_13;
                var_23 = project_perpendicular( var_9 - self.origin, self vehicle_getvelocity() );
                var_24 = var_23 * 2;
                var_25 = var_7;
                var_26 = vectorlerp( anglestoup( var_5.angles ), anglestoup( var_12.angles ), var_6 );
                self vehicledriveto( var_25, var_21, var_26 );
                waitframe();
            }
        }

        var_5 = var_12;
    }
}

project_perpendicular( var_0, var_1 )
{
    var_1 = vectornormalize( var_1 );
    return var_0 - var_1 * vectordot( var_0, vectornormalize( var_1 ) );
}

debug_graph( var_0, var_1, var_2 )
{
    debug_graph_init();
    debug_graph_init_key( var_0, var_1 );
    level.debug_graph.graphs[var_0].cur_point = ( level.debug_graph.graphs[var_0].cur_point + 1 ) % level.debug_graph.graphs[var_0].num_points;
    level.debug_graph.graphs[var_0].values[level.debug_graph.graphs[var_0].cur_point] = var_2;
    debug_graph_draw( level.debug_graph.graphs[var_0] );
}

debug_graph_init()
{
    if ( !isdefined( level.debug_graph ) )
    {
        level.debug_graph = spawnstruct();
        level.debug_graph.graphs = [];
    }
}

debug_graph_init_key( var_0, var_1 )
{
    if ( !isdefined( level.debug_graph.graphs[var_0] ) )
    {
        level.debug_graph.graphs[var_0] = spawnstruct();
        level.debug_graph.graphs[var_0].values = [];
        level.debug_graph.graphs[var_0].values[0] = 0;
        level.debug_graph.graphs[var_0].cur = 0;
        level.debug_graph.graphs[var_0].num_points = 20;
        level.debug_graph.graphs[var_0].cur_point = 0;
        level.debug_graph.graphs[var_0].color = var_1;
    }
}

debug_graph_draw( var_0 )
{
    var_1 = 50000;
    var_2 = undefined;
    var_3 = undefined;

    for ( var_4 = 0; var_4 < var_0.num_points; var_4++ )
    {
        var_3 = var_2;
        var_2 = var_0.values[( var_0.cur_point + 1 + var_4 ) % var_0.num_points];

        if ( isdefined( var_3 ) && isdefined( var_2 ) )
        {
            var_5 = level.player getangles();
            var_6 = anglestoforward( var_5 );
            var_7 = anglestoright( var_5 ) * var_1 * 0.01;
            var_8 = anglestoup( var_5 ) * var_1 * 0.25;
            var_9 = level.player geteye() + var_6 * var_1;
        }
    }
}

fly_think_autopilot_player( var_0 )
{
    level endon( "end_canyon" );
    self endon( "death" );
    setsaveddvar( "vehPlaneAiRollResponseRate", 0.05 );
    setsaveddvar( "vehPlaneAiPitchResponseRate", 0.05 );
    setsaveddvar( "vehPlaneAiYawResponseRate", 0.1 );
    var_1 = self;
    var_2 = 0;
    var_3 = self.origin;

    for ( var_4 = 1; isdefined( var_1.target ); var_1 = var_5 )
    {
        var_5 = getvehiclenode( var_1.target, "targetname" );

        if ( !isdefined( var_5 ) )
            break;

        var_2 = 0;
        var_6 = var_4 * self vehicle_getspeed() * 17.6;
        var_6 = clamp( var_6, 1950, 7800 );

        while ( var_2 < 1 )
        {
            while ( var_2 < 1 )
            {
                var_7 = vectorlerp( var_1.origin, var_5.origin, var_2 );

                if ( vectordot( var_7 - self.origin, anglestoforward( self.angles ) ) > var_6 )
                    break;

                var_3 = var_7;
                var_2 += 0.1;
            }

            if ( var_2 < 1 )
            {
                var_8 = var_0;
                self vehicledriveto( var_3, var_8 );
                waitframe();
            }
        }
    }
}

fly_think_formation( var_0 )
{
    level endon( "end_canyon" );
    self endon( "death" );
    setsaveddvar( "vehPlaneAiRollResponseRate", 0.05 );
    setsaveddvar( "vehPlaneAiPitchResponseRate", 0.05 );
    setsaveddvar( "vehPlaneAiYawResponseRate", 0.1 );
    var_1 = self.formation_pos;

    for (;;)
    {
        var_2 = level.plane vehicle_getspeed();
        var_3 = distance( var_1.origin, self.origin );

        if ( target_is_in_front( var_1 ) && var_3 > 1000 )
        {
            var_2 -= 15;

            while ( target_is_in_front( var_1 ) )
                wait 0.05;
        }
        else if ( target_is_in_front( var_1 ) && var_3 < 500 )
        {
            var_2 -= 5;

            while ( target_is_in_front( var_1 ) )
                wait 0.05;
        }
        else if ( !target_is_in_front( var_1 ) && var_3 > 500 )
            var_2 += 10;
        else if ( !target_is_in_front( var_1 ) && var_3 < 500 )
            var_2 = var_2;

        self vehicledriveto( var_1.origin, var_2 );
        wait 0.1;
    }
}

target_is_in_front( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 50;

    var_2 = offset_position_from_tag( "forward", "tag_origin", var_1 );
    var_3 = distance( var_2, var_0.origin );
    var_4 = distance( self.origin, var_0.origin );

    if ( var_3 < var_4 )
        return 0;

    return 1;
}

is_in_lockon_bounds( var_0 )
{
    if ( target_istarget( var_0 ) && target_isincircle( var_0, level.player, 65, level.plane.lockon_fov ) )
        return 1;

    return 0;
}

try_to_lock_on( var_0 )
{
    var_0 endon( "death" );
    var_1 = 10;
    var_2 = cos( var_1 );

    if ( level.plane islockedonto( var_0 ) )
        return 0;

    if ( is_true( var_0.ground_target ) )
        var_3 = 1;

    var_3 = 1;
    level.plane.acquiring_lock_target = var_0;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = maps\_utility::get_dot( level.player.eye_origin, vectortoangles( level.player.reticle_origin - level.player.eye_origin ), var_0.origin );

        if ( target_istarget( var_0 ) && distancesquared( var_0.origin, level.player.origin ) <= 1600000000 && var_5 > var_2 )
        {
            wait 0.05;
            continue;
        }

        level.plane.acquiring_lock_target = undefined;
        return 0;
    }

    return 1;
}

try_to_dogfight( var_0 )
{
    if ( !isdefined( level.plane.acquiring_dogfight_target ) || level.plane.acquiring_dogfight_target == var_0 )
    {
        var_1 = distance( level.plane.origin, var_0.origin ) * 0.0254;

        if ( var_1 <= 150 )
        {
            if ( target_istarget( var_0 ) && target_isincircle( var_0, level.player, 65, 130 ) )
            {
                var_2 = gettime();

                if ( !isdefined( level.plane.acquiring_dogfight_target ) )
                {
                    level.plane.acquiring_dogfight_target = var_0;
                    level.plane.dogfight_time = var_2 + 3000;
                }

                if ( var_2 >= level.plane.dogfight_time )
                {
                    level.plane.dogfight_engaged_target = var_0;
                    return 1;
                }
            }
            else
                level.plane.acquiring_dogfight_target = undefined;
        }
        else
            level.plane.acquiring_dogfight_target = undefined;
    }

    return 0;
}

switch_node_now( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( !isdefined( var_1 ) )
        return;

    var_0.attachedpath = undefined;
    var_0 notify( "newpath" );
    var_0 thread maps\_vehicle::vehicle_paths( var_1 );
    var_0 startpath( var_1 );
}

has_los( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( bullettracepassed( level.player geteye() + anglestoforward( level.player getgunangles() ) * 100, self.origin + ( 0, 0, var_0 ), 0, self ) )
        return 1;

    return 0;
}

player_targeting_think()
{
    level notify( "kill_player_targeting_think" );
    level endon( "kill_player_targeting_think" );
    level endon( "controlling_missile" );
    level endon( "finale" );

    while ( !isdefined( level.enemy_units ) )
        wait 0.05;

    while ( isdefined( self ) )
    {
        foreach ( var_1 in level.enemy_units )
        {
            if ( !isdefined( var_1.classname ) )
                level.enemy_units common_scripts\utility::array_remove( level.enemy_units, var_1 );
        }

        var_3 = [];

        foreach ( var_1 in level.enemy_units )
        {
            if ( !isdefined( var_1 ) )
                continue;

            if ( isdefined( var_1.ground_target ) )
                var_5 = var_1;
            else
                var_5 = var_1;

            if ( isdefined( var_5 ) && !isremovedentity( var_5 ) )
            {
                var_6 = try_to_lock_on( var_5 );

                if ( isdefined( var_6 ) && var_6 )
                {
                    self.lock_targets[self.lock_targets.size] = var_5;
                    thread monitor_lockon( var_5 );
                    var_5 thread lockon_behavior();
                }
            }
        }

        wait 0.05;
    }
}

lockon_behavior()
{
    set_optimal_flight_dist( 3500 + randomfloatrange( -1000, 500 ) );
    self.player_locked_on = 1;
}

islockedonto( var_0 )
{
    foreach ( var_2 in self.lock_targets )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

hud_target_think( var_0 )
{
    self notify( "kill_target_think" );
    self endon( "kill_target_think" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for (;;)
    {
        waittillframeend;

        if ( should_show_hud_element( var_0 ) )
        {
            var_2 = 0;

            if ( is_true( self.player_shooting_at ) )
            {
                var_4 = level.plane.locked_guns_hud;
                var_3 = 0;
                var_5 = ( 1, 0, 0 );
                var_2 = 1;
            }
            else if ( level.plane islockedonto( self ) )
            {
                var_4 = self.default_hud;
                var_3 = 0;
                var_5 = ( 1, 0, 0 );
                var_2 = 1;
            }
            else if ( isdefined( level.plane.acquiring_lock_target ) && level.plane.acquiring_lock_target == self )
            {
                var_3 %= 16;
                var_4 = level.plane.in_sights_hud + ( var_3 + 1 );
                var_3++;
                var_5 = ( 1, 1, 0 );
            }
            else
            {
                var_4 = self.default_hud;
                var_5 = ( 0, 1, 1 );
                var_3 = 0;
            }

            if ( !var_1 )
            {
                target_setsafe( self );
                target_hidefromplayer( self, level.player );
                var_1 = 1;
            }

            if ( target_istarget( self ) )
            {
                if ( var_2 )
                    target_showtoplayer( self, level.player );

                target_setshadersafe( self, var_4 );
            }
        }
        else
        {
            if ( target_istarget( self ) )
            {
                target_hidefromplayer( self, level.player );
                target_remove( self );
                var_1 = 0;
                var_2 = 0;
            }

            var_3 = 0;
        }

        waitframe();
    }
}

monitor_lockon( var_0 )
{
    level.player notify( "locked_on" );
    var_1 = level.plane.currentweapon;

    while ( isdefined( var_0 ) && islockedonto( var_0 ) && is_in_lockon_bounds( var_0 ) )
        wait 0.05;

    level.player.jethud["LockOn_Overlay"].alpha = 0;
    level.player notify( "locked_on_off" );

    if ( islockedonto( var_0 ) )
        self.lock_targets = common_scripts\utility::array_remove( self.lock_targets, var_0 );
}

should_show_hud_element( var_0 )
{
    if ( !isalive( self ) )
        return 0;

    if ( !has_los( var_0 ) )
        return 0;

    return 1;
}

plane_init()
{
    self.missiletags_right = [ "tag_weapon_pod_right" ];
    self.missiletags_left = [ "tag_weapon_pod_left" ];
    self.last_missile_side = 0;
    self.mgun_left = "tag_gun_left";
    self.mgun_right = "tag_gun_right";
    self.salvo_ammo = [];
    self.salvo_ammo[0] = 2;
    self.salvo_ammo[1] = 2;
    var_0 = self gettagangles( "tag_origin" );
    var_1 = anglestoforward( var_0 );
    var_2 = self gettagorigin( "tag_origin" );
    var_3 = var_2 + var_1 * 1500;
    self.missile_target = common_scripts\utility::spawn_tag_origin();
    self.missile_target.origin = var_3;
    self.missile_target linkto( self, "tag_origin" );
    var_3 = var_2 + var_1 * 5000;
    self.fake_missile_target = common_scripts\utility::spawn_tag_origin();
    self.fake_missile_target.origin = var_3;
    self.fake_missile_target linkto( self, "tag_origin" );
    var_3 = var_2 + var_1 * -3000;
    self.fake_enemy_missile_spawn = common_scripts\utility::spawn_tag_origin();
    self.fake_enemy_missile_spawn.origin = var_3;
    self.fake_enemy_missile_spawn linkto( self, "tag_origin" );
    level.player notifyonplayercommand( "dpad_down", "+actionslot 2" );
    level.player notifyonplayercommand( "dpad_left", "+actionslot 3" );
    level.player notifyonplayercommand( "dpad_right", "+actionslot 4" );
    level.player notifyonplayercommand( "dpad_up", "+actionslot 1" );
    level.player notifyonplayercommand( "a_pressed", "+gostand" );
    level.player notifyonplayercommand( "b_pressed", "+stance" );
    level.player notifyonplayercommand( "b_pressed", "+prone" );
    level.player notifyonplayercommand( "b_pressed", "toggleprone" );
    level.player notifyonplayercommand( "y_pressed", "weapnext" );
    level.player notifyonplayercommand( "fire_guns", "+speed_throw" );
    level.player notifyonplayercommand( "fire_guns", "+toggleads_throw" );
    level.player notifyonplayercommand( "fire_guns", "+ads_akimbo_accessible" );
}

debug_enemy_jets_die()
{

}

handle_evasive_controls()
{
    level.player notifyonplayercommand( "pop_flares", "+smoke" );
    waitframe();

    for (;;)
    {
        level.player waittill( "pop_flares" );
        level.plane playsound( "plr_jet_deploy_flares" );
        var_0 = level.plane offset_position_from_tag( "backward", "tag_origin", 120 );
        playfx( common_scripts\utility::getfx( "missile_repel" ), var_0 );
        level.player_popped_flares = 1;
        level.flares_active = 1;
        thread turn_off_flares();
        wait 3;
    }
}

turn_off_flares()
{
    wait 2;
    level.flares_active = 0;
}

monitor_player_shooting()
{
    level notify( "kill_monitor_player_shooting" );
    level endon( "kill_monitor_player_shooting" );
    level endon( "controlling_missile" );
    level endon( "missionfailed" );
    level endon( "end_canyon" );
    thread player_shooting_logic( level.player );
    self.currentweapon = "none";
    self.on_radar_hud = "hud_fofbox_hostile_obstructed";
    self.in_sights_hud = "jet_hud_locking_on_";
    self.lock_on_hud = "jet_hud_lockon_missile";
    self.locked_guns_hud = "jet_hud_target_bullet_lock";
    self.target_fov = 30;
    self.lockon_fov = 240;
    self.lockon_time = 1.0;
    level waittill( "jetHUD_init" );
    level.player.jethud["weaponOverlay"].alpha = 0;
    level.player.jethud["weapon_boresight"].alpha = 0;

    for ( level.player.jethud["weapon_reticle"].alpha = 0; !common_scripts\utility::flag( "canyon_finished" ); level.player.jethud["weapon_boresight"].alpha = 0 )
    {
        level.player waittill( "fire_guns" );

        if ( common_scripts\utility::flag( "canyon_finished" ) )
            return;

        level.player playrumblelooponentity( "damage_light" );
        level.player.jethud["weapon_boresight"].alpha = 0.8;

        while ( level.player adsbuttonpressed( 1 ) && !common_scripts\utility::flag( "canyon_finished" ) )
            wait 0.05;

        level.player stoprumble( "damage_light" );
    }
}

thermaloff_vianotify( var_0 )
{
    self waittill( var_0 );
    self thermalvisionoff();
}

can_shoot_weapons( var_0 )
{
    if ( level.plane.currentweapon == "missiles" )
        return 1;
    else if ( level.plane.currentweapon == "guns" && level.plane can_shoot_guns( var_0 ) )
        return 1;
    else if ( level.plane.currentweapon == "bombs" )
        return 1;

    return 0;
}

check_missile_ammo()
{
    if ( self.salvo_ammo[0] > 0 || self.salvo_ammo[1] > 0 )
        return self.salvo_ammo[1] > self.salvo_ammo[0];

    return -1;
}

can_shoot_missiles( var_0 )
{
    if ( var_0 == 0 && self.salvo0 )
        return 1;
    else if ( var_0 == 1 && self.salvo1 )
        return 1;

    return 0;
}

can_shoot_guns( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( distance( self.origin, var_0.origin ) < 8100 )
        return 1;

    return 0;
}

player_guns_cooldown_think()
{
    self endon( "death" );
    self.guns_max_fire_time = 8;
    self.guns_complete_cooldown_time = 1;
    self.guns_last_fire_time = 0;
    self.guns_fire_time = 0.0;

    for (;;)
    {
        if ( gettime() - self.guns_last_fire_time <= 50 )
            self.guns_fire_time += 0.05;
        else
            self.guns_fire_time = max( 0, self.guns_fire_time - self.guns_max_fire_time / self.guns_complete_cooldown_time * 0.05 );

        waitframe();
    }
}

player_guns_cooldown_shoot_notify()
{
    self.guns_last_fire_time = gettime();
}

player_guns_cooldown_can_shoot()
{
    return self.guns_fire_time < self.guns_max_fire_time;
}

player_guns_cooldown_get_heat()
{
    return clamp( self.guns_fire_time / self.guns_max_fire_time, 0, 1 );
}

player_shooting_logic( var_0 )
{
    level notify( "kill_player_shooting_logic" );
    level endon( "kill_player_shooting_logic" );
    level endon( "controlling_missile" );
    self endon( "death" );
    var_1 = gettime() * 0.001;
    self.salvo0 = 1;
    self.salvo1 = 1;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    childthread player_missile_firing_logic( var_0 );

    while ( !common_scripts\utility::flag( "canyon_finished" ) )
    {
        var_0 waittill( "fire_guns" );

        if ( common_scripts\utility::flag( "canyon_finished" ) )
            return;

        if ( var_0 adsbuttonpressed( 1 ) )
        {
            level.player_shot_guns = 1;
            thread gun_sound();

            while ( var_0 adsbuttonpressed( 1 ) && !common_scripts\utility::flag( "canyon_finished" ) )
            {
                jet_shoot_gun( var_4 );
                var_4 = !var_4;
                wait 0.05;
            }

            self notify( "gun_sound_stop" );
        }
    }
}

player_missile_firing_logic( var_0 )
{
    level endon( "finale" );
    var_0 notifyonplayercommand( "fire_missile", "+attack" );
    var_0 notifyonplayercommand( "fire_missile", "+attack_akimbo_accessible" );

    for (;;)
    {
        var_0 waittill( "fire_missile" );
        var_1 = check_missile_ammo();

        if ( var_1 > -1 )
        {
            level.player_fired_missiles = 1;
            var_2 = undefined;

            if ( level.plane.lock_targets.size > 0 )
            {
                foreach ( var_4 in level.plane.lock_targets )
                {
                    if ( !is_true( var_4.player_shooting_at ) )
                    {
                        var_2 = var_4;
                        break;
                    }
                }
            }

            if ( isdefined( var_2 ) )
            {
                var_1 = check_missile_ammo();

                if ( var_1 > -1 )
                {
                    var_2.player_shooting_at = 1;
                    level.plane spawn_cbdr_missile( var_2, undefined, var_1 );
                    var_2 notify( "missile_fired_at" );
                }
            }
            else
                level.plane spawn_cbdr_missile( undefined, undefined, var_1 );

            continue;
        }

        level.plane playsound( "plr_jet_missile_ammo_out" );
    }
}

re_target( var_0 )
{
    var_0.player_shooting_at = 0;
}

gun_sound()
{
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.plane playsound( "s19_mgun_trigger_plr" );
    var_0 playloopsound( "s19_mgun_shot_lp_plr" );
    common_scripts\utility::waittill_any( "gun_sound_stop", "finale" );
    var_0 stoploopsound();

    if ( isdefined( level.plane ) )
        level.plane playsound( "s19_mgun_shot_lp_end_plr" );

    var_0 delete();
}

print_distance_on_ent( var_0 )
{
    var_1 = ( 0.1, 0.2, 1 );
    var_2 = 0.7;
    var_3 = 1;

    if ( !isdefined( var_0 ) )
        return;

    var_0 endon( "death" );

    if ( !isdefined( var_0.is_objective ) || !var_0.is_objective )
    {
        var_0.hudelements = [];
        var_0.is_objective = 1;
        var_0.hudelements[0] = newclienthudelem( self );
        var_0.hudelements[0].positioninworld = 1;
        var_0.hudelements[0] settargetent( var_0 );
        var_0.hudelements[0].color = var_1;
        var_0.hudelements[0].alpha = var_2;
        var_0.hudelements[0].alignx = "center";
        var_0.hudelements[0].aligny = "top";
        var_0.hudelements[0].fontscale = var_3;
        var_0.hudelements[1] = newclienthudelem( self );
        var_0.hudelements[1].positioninworld = 1;
        var_0.hudelements[1] settargetent( var_0 );
        var_0.hudelements[1].color = var_1;
        var_0.hudelements[1].alpha = var_2;
        var_0.hudelements[1].alignx = "center";
        var_0.hudelements[1].aligny = "middle";
        var_0.hudelements[1].fontscale = var_3;
        var_0 thread keep_active_distance_text( var_0.hudelements );
    }
}

keep_active_distance_text( var_0 )
{
    var_1 = ( 0.2, 1, 0.2 );

    while ( isdefined( self ) )
    {
        var_2 = int( distance( self.origin, level.player.origin ) );
        var_3 = int( var_2 / 12 );

        if ( !level.player can_see_ent( self, self ) )
        {
            var_0[0].alpha = 0;
            wait 0.1;
            continue;
        }

        if ( level.plane.currentweapon == "guns" && var_2 < 8100 || level.plane islockedonto( self ) )
            var_0[0].alpha = 0;
        else if ( level.plane.currentweapon != "guns" )
        {
            var_0[0].alpha = 0.7;
            var_0[0].color = ( 0.1, 1, 0.1 );
        }
        else if ( level.plane.currentweapon == "guns" && var_2 > 8100 )
        {
            var_0[0].alpha = 0.7;
            var_0[0].color = ( 1, 0.9, 0.1 );
            var_3 = int( ( 8100 - var_2 ) / 12 );
        }
        else
        {
            var_0[0].alpha = 0.7;
            var_0[0].color = ( 0.1, 1, 0.1 );
        }

        var_0[0] settext( var_3 );
        wait 0.05;
    }

    var_0[0] destroy();
    var_0[1] destroy();
}

can_see_ent( var_0, var_1 )
{
    if ( bullettracepassed( self.origin, var_0.origin, 0, var_1 ) )
        return 1;

    return 0;
}

monitor_missile_target( var_0 )
{
    self endon( "death" );

    while ( isdefined( self.missiletag ) )
        wait 0.05;

    if ( isdefined( self ) && isdefined( var_0 ) )
        self missile_settargetent( var_0 );
}

offset_debug( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "death" );
    var_0.tags = [];
    var_0.tags[0] = common_scripts\utility::spawn_tag_origin();
    var_0.tags[1] = common_scripts\utility::spawn_tag_origin();
    var_0.tags[2] = common_scripts\utility::spawn_tag_origin();
    var_0.tags[3] = common_scripts\utility::spawn_tag_origin();
    var_0.tags[1].origin = var_0 offset_position_from_tag( "up", "tag_origin", 256 );
    var_0.tags[2].origin = var_0 offset_position_from_tag( "down", "tag_origin", 256 );
    var_0.tags[3].origin = var_0 offset_position_from_tag( "left", "tag_origin", 256 );
    var_0.tags[1] linkto( var_0.tags[0], "tag_origin" );
    var_0.tags[2] linkto( var_0.tags[0], "tag_origin" );
    var_0.tags[3] linkto( var_0.tags[0], "tag_origin" );
    var_0 thread rotate_missile_targets();
    return var_0;
}

rotate_missile_targets()
{
    var_0 = self.tags[0];
    var_1 = self.tags;

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        var_0.origin = self.origin;
        var_2 = var_0.angles;
        var_0.angles = ( var_2[0], var_2[1] + 5, var_2[2] );
        wait 0.05;
    }

    foreach ( var_0 in var_1 )
    {
        if ( isdefined( var_0 ) )
            var_0 delete();
    }
}

player_chooses_manual_control()
{
    return 1;
}

move_target_for_squirly_effect( var_0 )
{
    self endon( "death" );
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    self.tag_targ = var_1;
    self.bomb_target = var_0;
    self missile_settargetent( var_1 );
    thread make_squirly_path( var_1, var_0 );
    var_2 = ( var_0.origin[0], var_0.origin[1], level.player.origin[2] );
    var_3 = var_0.origin;
    var_4 = distance( self.origin, var_1.origin );
    var_5 = var_4;

    while ( var_5 > var_4 * 0.2 )
    {
        var_5 = distance( self.origin, var_2 );
        wait 0.05;
    }

    self notify( "end_squirel" );
    var_1.origin = var_3;
}

make_squirly_path( var_0, var_1 )
{
    self endon( "end_squirel" );
    var_2 = max( var_1.origin[2] + 2000, level.player.origin[2] );
    var_3 = ( var_1.origin[0], var_1.origin[1], var_2 );
    var_4 = var_1.origin;
    var_5 = 0.1;
    var_6 = distance( self.origin, var_0.origin );
    var_7 = var_6;

    for (;;)
    {
        var_8 = randomfloatrange( var_7 * ( var_5 * -1 ), var_7 * var_5 );
        var_9 = randomfloatrange( var_7 * ( var_5 * -1 ), var_7 * var_5 );
        var_10 = randomfloatrange( var_7 * ( var_5 * -1 ), var_7 * var_5 );
        var_0 moveto( var_3 + ( var_8, var_9, var_10 ), 0.25 );
        var_7 = distance( self.origin, var_3 );
        wait 0.25;
    }
}

monitor_missile_death( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.player;

    self waittill( "explode", var_4 );

    if ( isdefined( var_3 ) && var_3 != level.plane && distance( var_3.origin, var_4 ) < 500 )
    {
        if ( var_3 trytorepelmissile( self, 2, 3000, 1 ) )
            return;

        var_3 delete();
    }

    if ( var_0 && isalive( var_1 ) )
        radiusdamage( var_4, 1500, 3000, 1500, var_1 );

    if ( isdefined( var_2 ) )
        var_2 delete();
}

get_plane_gun_origin( var_0 )
{
    if ( !isdefined( self ) )
        return;

    var_1 = self gettagangles( self.mgun_left );

    if ( isdefined( var_0 ) )
    {
        if ( var_0 )
        {
            var_2 = offset_position_from_tag( "forward", self.mgun_left, 500 );
            var_3 = anglestoright( var_1 );
        }
        else
        {
            var_2 = offset_position_from_tag( "forward", self.mgun_right, 500 );
            var_3 = anglestoright( var_1 ) * -1;
        }
    }
    else
    {
        var_2 = ( self gettagorigin( self.mgun_left ) + self gettagorigin( self.mgun_right ) ) * 0.5;
        var_3 = ( 0, 0, 0 );
    }

    var_4 = anglestoforward( var_1 );
    var_5 = anglestoup( var_1 ) * -1;

    if ( getdvar( "vehCam_mode" ) == "chase" )
        var_2 += ( var_5 * 0 + var_4 * 500 + var_3 * 16 );
    else
        var_2 += ( var_5 * 150 + var_4 * 500 + var_3 * -50 );

    return var_2;
}

get_plane_gun_angles( var_0 )
{
    var_1 = self gettagangles( self.mgun_left );

    if ( getdvar( "vehCam_mode" ) != "chase" )
        var_1 += ( 6, 0, 0 );

    return var_1;
}

jet_shoot_gun( var_0 )
{
    var_1 = 0.05;
    var_2 = get_plane_gun_origin( var_0 );
    waittillframeend;

    if ( isdefined( self.player_gun_lock_target_origin ) )
        var_3 = self.player_gun_lock_target_origin;
    else
        var_3 = level.player.jethud["hud_tag"].origin;

    var_3 += common_scripts\utility::randomvector( 2 * tan( var_1 ) * distance( var_2, var_3 ) );
    var_4 = magicbullet( "s19_cannon_player_test", var_2, var_3, level.player );
}

jet_shoot_missile_cbdr( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_1; var_3++ )
        spawn_cbdr_missile( var_0, var_2, 0 );
}

spawn_cbdr_missile( var_0, var_1, var_2 )
{
    self notify( "salvo" + var_2 + "_fired" );
    self.salvo_ammo[var_2]--;
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3 playsound( "s19_missile_fire_plr" );
    var_3 hide();
    self.last_missile_side++;

    if ( self.last_missile_side > 1 )
        self.last_missile_side = 0;

    var_3.origin = offset_position_from_tag( "right", self.missiletags_right[0], 1000 );

    if ( self.last_missile_side == 1 )
        var_3.origin = offset_position_from_tag( "left", self.missiletags_left[0], 1000 );

    var_3.origin -= ( 0, 0, 50 );
    var_3.angles = get_plane_gun_angles();
    var_3.velocity = self vehicle_getvelocity();
    var_3.target_entity = var_0;
    var_3 setmodel( "projectile_sidewinder_missile" );
    playfxontag( common_scripts\utility::getfx( "missile_trail" ), var_3, "tag_origin" );
    var_3 thread cbdr_missile_think( var_1 );
    thread reload_ammo( var_2, 3 );
}

reload_ammo( var_0, var_1 )
{
    self endon( "death" );
    wait(var_1);
    self.salvo_ammo[var_0]++;
}

cbdr_missile_think( var_0 )
{
    var_1 = 17600.0;
    var_2 = 0.05;
    var_3 = 40500.0;
    var_4 = 17280;
    var_5 = 0.5;
    var_6 = 0.1;

    if ( !isdefined( var_0 ) )
        var_0 = 10;

    var_7 = 1950;
    var_8 = ( 0, 0, 0 );
    var_9 = 1.5;
    var_10 = 600;
    var_11 = cos( 30 );
    var_12 = 4000;
    self.velocity *= 3.0;

    for ( var_13 = 0.0; var_13 < 0.5; var_13 += 0.05 )
    {
        self.origin += self.velocity * 0.05;
        self.angles = vectortoangles( self.velocity );
        self.velocity *= 0.9;
        wait 0.05;
        self show();

        if ( isdefined( self.target_entity ) && isdefined( self.target_entity.origin ) )
        {
            var_14 = distancesquared( self.origin, self.target_entity.origin );
            var_15 = vectordot( vectornormalize( self.velocity ), vectornormalize( self.target_entity.origin - self.origin ) );

            if ( var_14 < 144000000 || var_15 < var_11 )
                break;
        }
    }

    var_16 = vectornormalize( self.velocity );
    var_17 = length( self.velocity );
    self.velocity = ( var_16 + common_scripts\utility::randomvector( var_2 ) ) * ( var_17 + var_1 );
    var_18 = self.origin + vectornormalize( self.velocity ) * 10000;
    var_19 = vectornormalize( self.velocity );
    var_20 = var_19;
    var_21 = 0;
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;

    while ( var_21 < var_0 && !common_scripts\utility::flag( "canyon_finished" ) )
    {
        var_25 = 0;

        if ( isdefined( self.target_entity ) && isdefined( self.target_entity.origin ) )
        {
            var_25 = 1;
            var_22 = 1;
        }

        if ( var_25 )
            var_18 = self.target_entity.origin;
        else if ( !var_22 )
            var_18 += length( self.velocity ) * var_16 * 0.05;

        var_26 = var_18 - self.origin;
        var_19 = vectornormalize( var_26 );
        var_27 = ( var_19 - var_20 ) * 20 + var_8 + common_scripts\utility::randomvector( var_9 );
        var_20 = var_19;

        if ( !var_23 && var_25 && self.target_entity trytorepelmissile( self, var_21, length( var_26 ), undefined, 1 ) )
        {
            var_23 = 1;
            self.player_shooting_at = 0;
            var_8 = common_scripts\utility::randomvector( 100 );
        }

        if ( var_23 )
            var_27 *= -1;

        var_28 = length( self.velocity );
        var_29 = vectornormalize( self.velocity );

        if ( var_28 < var_3 )
            var_30 = min( var_28 + var_4 * 0.05, var_3 );
        else
            var_30 = max( var_28 - var_4 * 0.05, var_3 );

        var_31 = var_6;
        var_32 = vector_clamp( var_27 * var_31, var_5 );
        var_33 = vectornormalize( var_29 + var_32 );
        self.velocity = var_33 * var_30;
        var_34 = self.origin + self.velocity * 0.05;

        if ( !var_23 && distance( var_34, var_18 ) < var_10 )
        {
            var_24 = 1;
            break;
        }

        if ( !bullettracepassed( self.origin, var_34, 0, self ) )
            break;

        self.origin = var_34;
        self.angles = vectortoangles( self.velocity );

        if ( !var_23 && vectordot( self.velocity, var_18 - var_34 ) < 0 )
            break;

        var_21 += 0.05;
        waitframe();
    }

    if ( !var_23 )
    {
        if ( var_24 )
            self.target_entity notify( "damage", var_12, level.player, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "" );

        radiusdamage( self.origin, var_10 * 3, var_12, var_12, level.player );
    }

    if ( var_24 && isdefined( self.target_entity ) )
    {
        if ( !is_true( self.target_entity.ground_target ) )
        {

        }
    }
    else if ( var_21 >= var_0 )
        playfx( common_scripts\utility::getfx( "missile_explode" ), self.origin, vectornormalize( self.velocity ) * -1 );
    else
        playfx( common_scripts\utility::getfx( "canyon_impact" ), self.origin, vectornormalize( self.velocity ) * -1 );

    if ( isdefined( self.target_entity ) && !var_24 )
        re_target( self.target_entity );

    self delete();
}

trytorepelmissile( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !is_true( var_4 ) && is_true( self.player_shooting_at ) )
        return 0;

    if ( !isdefined( self.has_flares ) || self.has_flares < 1 )
        return 0;

    if ( var_1 < 0.5 )
        return 0;

    if ( var_2 > 3000 )
        return 0;

    if ( is_true( var_3 ) == 0 && isdefined( self.last_flare_time ) && self.last_flare_time + 2000 > gettime() )
        return 0;

    if ( is_true( var_4 ) )
    {
        var_5 = 20000;
        var_6 = maps\_utility::getdifficulty();

        switch ( var_6 )
        {
            case "medium":
                var_5 = 18000;
                break;
            case "hard":
                var_5 = 15000;
                break;
            case "fu":
                var_5 = 10000;
                break;
        }

        var_5 *= var_5;

        if ( !common_scripts\utility::flag( "ai_repel_missiles_ok" ) || distancesquared( level.plane.origin, self.origin ) < var_5 )
            return 0;

        if ( is_true( level.repel_player_missile ) )
        {
            level.repel_player_missile = 0;
            return 0;
        }
        else
            level.repel_player_missile = 1;
    }

    playfx( common_scripts\utility::getfx( "missile_repel" ), var_0.origin );
    self.has_flares--;
    self.last_flare_time = gettime();
    return 1;
}

vector_clamp( var_0, var_1 )
{
    var_2 = length( var_0 );

    if ( var_2 > var_1 )
        return var_0 * var_1 / var_2;
    else
        return var_0;
}

monitor_plane_speed()
{
    level notify( "kill_monitor_plane_speed" );
    level endon( "kill_monitor_plane_speed" );
    level endon( "controlling_missile" );
    self endon( "death" );
    var_0 = 35;
    var_1 = 45;

    for (;;)
    {
        var_2 = self vehicle_getspeed();
        setsaveddvar( "vehPlaneControlForceReferenceSpeed", var_2 );
        setsaveddvar( "vehPlaneMaxControlForceScale", 150 );
        setsaveddvar( "vehPlaneMaxControlForcePitch", 0.8 );
        setsaveddvar( "vehPlaneMaxControlForceRoll", 1 );
        setsaveddvar( "vehPlaneMaxControlForceYaw", 0.8 );
        var_3 = var_0 + var_2 / 50;
        var_4 = var_1 + var_2 / 50;
        setsaveddvar( "vehPlaneWingLoading", var_3 );
        setsaveddvar( "vehPlaneFuselageLoading", var_1 );
        wait 0.1;
    }
}

standard_plane_controls()
{
    regular_plane_controls();

    if ( getdvarint( "vehPlaneControlScheme" ) >= 2 )
    {
        self vehicle_setspeedimmediate( 333, 10 );
        arcade_plane_controls();
    }
    else if ( level.mini_version )
    {
        self vehicle_setspeedimmediate( 500, 50 );
        mini_plane_controls();
    }
    else
    {
        self vehicle_setspeedimmediate( 500, 50 );
        regular_plane_controls();
    }
}

regular_plane_controls()
{
    setsaveddvar( "vehPlaneGravity", 386 );
    setsaveddvar( "vehPlaneMass", 15000 );
    setsaveddvar( "vehPlaneWingLoading", 85 );
    setsaveddvar( "vehPlaneFuselageLoading", 105 );
    setsaveddvar( "vehPlaneThrustToWeightRatio", 2.5 );
    setsaveddvar( "vehPlaneParasiticDragCoeff", 0.03 );
    setsaveddvar( "vehPlaneMaxControlForceScale", 40 );
    setsaveddvar( "vehPlaneMaxControlForceRoll", 1.0 );
    setsaveddvar( "vehPlaneMaxControlForcePitch", 0.5 );
    setsaveddvar( "vehPlaneMaxControlForceYaw", 0.5 );
    setsaveddvar( "vehPlaneControlForceReferenceSpeed", 200 );
    setsaveddvar( "vehPlaneMaxRightingForceScale", 3 );
    setsaveddvar( "vehPlaneRightingForceReferenceSpeed", 450 );
    setsaveddvar( "vehPlaneDihedralCoeff", 3 );
    setsaveddvar( "vehPlaneDampingRoll", 0.15 );
    setsaveddvar( "vehPlaneDampingYaw", 0.4 );
    setsaveddvar( "vehPlaneDampingPitch", 0.2 );
    setsaveddvar( "vehPlaneControlSquaring", 0.1 );
    setsaveddvar( "vehPlaneControlExponent", 1.5 );
    setsaveddvar( "vehPlaneControlYawRollCoupling", 0 );
    setsaveddvar( "vehPlaneControlRollYawCoupling", 0.2 );
    setsaveddvar( "vehPlaneControlLowpassCoeff", 0 );
    setsaveddvar( "vehPlaneTurbulenceStrength", 0 );
    setsaveddvar( "vehPlaneWingLeveling", 0.15 );
}

mini_plane_controls()
{
    setsaveddvar( "vehPlaneGravity", 77 );
    setsaveddvar( "vehPlaneMass", 3000 );
    setsaveddvar( "vehPlaneWingLoading", 17 );
    setsaveddvar( "vehPlaneFuselageLoading", 20 );
    setsaveddvar( "vehPlaneThrustToWeightRatio", 3.0 );
    setsaveddvar( "vehPlaneParasiticDragCoeff", 0.03 );
    setsaveddvar( "vehPlaneMaxControlForceScale", 20 );
    setsaveddvar( "vehPlaneMaxControlForceRoll", 1.0 );
    setsaveddvar( "vehPlaneMaxControlForcePitch", 1.0 );
    setsaveddvar( "vehPlaneMaxControlForceYaw", 0.5 );
    setsaveddvar( "vehPlaneControlForceReferenceSpeed", 40 );
    setsaveddvar( "vehPlaneMaxRightingForceScale", 3 );
    setsaveddvar( "vehPlaneRightingForceReferenceSpeed", 200 );
    setsaveddvar( "vehPlaneDihedralCoeff", 3 );
    setsaveddvar( "vehPlaneDampingRoll", 0.15 );
    setsaveddvar( "vehPlaneDampingYaw", 0.4 );
    setsaveddvar( "vehPlaneDampingPitch", 0.2 );
    setsaveddvar( "vehPlaneControlSquaring", 0.1 );
    setsaveddvar( "vehPlaneControlExponent", 1.5 );
    setsaveddvar( "vehPlaneControlYawRollCoupling", 0 );
    setsaveddvar( "vehPlaneControlRollYawCoupling", 0.2 );
    setsaveddvar( "vehPlaneControlLowpassCoeff", 0 );
    setsaveddvar( "vehPlaneTurbulenceStrength", 0 );
    setsaveddvar( "vehPlaneWingLeveling", 0.15 );
}

boost_plane_controls()
{
    setsaveddvar( "vehPlaneGravity", 386 );
    setsaveddvar( "vehPlaneMass", 15000 );
    setsaveddvar( "vehPlaneWingLoading", 105 );
    setsaveddvar( "vehPlaneFuselageLoading", 125 );
    setsaveddvar( "vehPlaneThrustToWeightRatio", 8.5 );
    setsaveddvar( "vehPlaneParasiticDragCoeff", 0.03 );
    setsaveddvar( "vehPlaneMaxControlForceScale", 50 );
    setsaveddvar( "vehPlaneMaxControlForceRoll", 1.0 );
    setsaveddvar( "vehPlaneMaxControlForcePitch", 0.5 );
    setsaveddvar( "vehPlaneMaxControlForceYaw", 0.5 );
    setsaveddvar( "vehPlaneControlForceReferenceSpeed", 800 );
    setsaveddvar( "vehPlaneMaxRightingForceScale", 3 );
    setsaveddvar( "vehPlaneRightingForceReferenceSpeed", 650 );
    setsaveddvar( "vehPlaneDihedralCoeff", 3 );
    setsaveddvar( "vehPlaneDampingRoll", 0.15 );
    setsaveddvar( "vehPlaneDampingYaw", 0.4 );
    setsaveddvar( "vehPlaneDampingPitch", 0.2 );
    setsaveddvar( "vehPlaneControlSquaring", 0.1 );
    setsaveddvar( "vehPlaneControlExponent", 1.5 );
    setsaveddvar( "vehPlaneControlYawRollCoupling", 0 );
    setsaveddvar( "vehPlaneControlRollYawCoupling", 0.2 );
    setsaveddvar( "vehPlaneControlLowpassCoeff", 0 );
    setsaveddvar( "vehPlaneTurbulenceStrength", 0 );
    setsaveddvar( "vehPlaneWingLeveling", 0.15 );
}

slow_plane_controls()
{
    setsaveddvar( "vehPlaneGravity", 386 );
    setsaveddvar( "vehPlaneMass", 15000 );
    setsaveddvar( "vehPlaneWingLoading", 65 );
    setsaveddvar( "vehPlaneFuselageLoading", 105 );
    setsaveddvar( "vehPlaneThrustToWeightRatio", 1.3 );
    setsaveddvar( "vehPlaneParasiticDragCoeff", 0.03 );
    setsaveddvar( "vehPlaneMaxControlForceScale", 40 );
    setsaveddvar( "vehPlaneMaxControlForceRoll", 1.0 );
    setsaveddvar( "vehPlaneMaxControlForcePitch", 0.5 );
    setsaveddvar( "vehPlaneMaxControlForceYaw", 0.5 );
    setsaveddvar( "vehPlaneControlForceReferenceSpeed", 160 );
    setsaveddvar( "vehPlaneMaxRightingForceScale", 3 );
    setsaveddvar( "vehPlaneRightingForceReferenceSpeed", 300 );
    setsaveddvar( "vehPlaneDihedralCoeff", 3 );
    setsaveddvar( "vehPlaneDampingRoll", 0.15 );
    setsaveddvar( "vehPlaneDampingYaw", 0.4 );
    setsaveddvar( "vehPlaneDampingPitch", 0.2 );
    setsaveddvar( "vehPlaneControlSquaring", 0.1 );
    setsaveddvar( "vehPlaneControlExponent", 1.5 );
    setsaveddvar( "vehPlaneControlYawRollCoupling", 0 );
    setsaveddvar( "vehPlaneControlRollYawCoupling", 0.2 );
    setsaveddvar( "vehPlaneControlLowpassCoeff", 0 );
    setsaveddvar( "vehPlaneTurbulenceStrength", 0 );
    setsaveddvar( "vehPlaneWingLeveling", 0.15 );
}

arcade_plane_controls()
{
    setsaveddvar( "vehPlaneControlSquaring", 0.1 );
    setsaveddvar( "vehPlaneControlYawRollCoupling", 0.0 );
    setsaveddvar( "vehPlaneControlRollYawCoupling", 0.0 );
    setsaveddvar( "vehPlaneControlLowpassCoeff", 0.8 );
    setsaveddvar( "vehPlanePitchDeadZoneWhileRolling", 0.3 );
    setsaveddvar( "vehPlaneRollLerpRate", 0.1 );
    setsaveddvar( "vehPlaneControlExponent", 3.0 );
    setsaveddvar( "vehPlaneMaxYawRatePerSec", 330 );
    setsaveddvar( "vehPlaneMaxPitchDiffPerSec", 45 );
    setsaveddvar( "vehPlaneCollisionLookAheadTime", 0 );
}

plane_test( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    level notify( "reset_plane_monitoring" );
    common_scripts\utility::flag_set( "playerPlaneNoDeath" );
    level.player enableinvulnerability();
    level.fake_plane = maps\_utility::spawn_anim_model( "cockpit" );
    level.fake_plane hidepart( "TAG_SCREEN_JOINT_LOAD" );
    level.fake_plane hidepart( "TAG_TRANSFER_AR" );
    thread maps\_anim::anim_loop_solo( level.fake_plane, "idle" );
    self.healthbuffer = 0;
    self.maxhealth = 100000;
    self.health = 100000;
    level.player.ads_on = 0;
    level.repel_player_missile = 0;

    if ( level.nextgen )
    {
        setsaveddvar( "r_mbEnable", "2" );
        setsaveddvar( "r_mbVelocityScalar", 2 );
        setsaveddvar( "r_mbCameraRotationInfluence", "0" );
    }

    if ( !isdefined( self.plane_intialized ) || isdefined( self.plane_intialized ) && !self.plane_intialized )
    {
        plane_init();
        self.plane_intialized = 1;
    }

    thread plane_health_monitor();
    thread monitor_player_shooting();
    waitframe();
    thread player_targeting_think();

    if ( var_1 )
    {
        self makeunusable();
        level.player mountvehicle( self );
        setsaveddvar( "vehCam_mode", "1" );
        setsaveddvar( "sv_znear", "16" );
    }

    setomnvar( "ui_playerplane_hud", 1 );
    thread fighter_jet_hud( level.player, self );
    thread fighter_jet_sounds( level.player, self );
    thread fighter_jet_crash_detection( level.player, self );
    thread fighter_jet_gun_hud();
    setdvar( "cockpit_offset", ( 0, 0, 0 ) );
    setdvar( "cockpit_angles", ( 0, 0, 0 ) );
    thread fighter_jet_handle_cockpit( level.player, self );
    thread fighter_jet_handle_throttle( level.player, self, var_2 );

    if ( !isdefined( var_0 ) )
        var_0 = 333;

    self vehicle_setspeedimmediate( var_0, 10 );

    if ( is_true( level.old_controls ) )
        setsaveddvar( "vehPlaneControlScheme", 1 );
    else
        setsaveddvar( "vehPlaneControlScheme", 3 );

    standard_plane_controls();
}

handle_chase_cam_toggle()
{
    self notifyonplayercommand( "toggle_chase_cam", "+actionslot 1" );

    for (;;)
    {
        self waittill( "toggle_chase_cam" );
        toggle_chase_cam();
    }
}

toggle_chase_cam()
{
    if ( !isdefined( level.plane_chase_cam ) )
        level.plane_chase_cam = getdvar( "vehCam_mode" ) == "chase";

    var_0 = anglestoforward( ( 6, 0, 0 ) ) * 10000;

    if ( level.plane_chase_cam )
    {
        setsaveddvar( "vehCam_mode", "1" );
        level.fake_plane show();
        level.plane hide();
        setsaveddvar( "vehPlaneRollLerpRate", 0.1 );
        thread fighter_jet_handle_cockpit( level.player, level.plane );
    }
    else
    {
        setsaveddvar( "vehCam_mode", "3" );
        level.fake_plane hide();
        level.plane show();
        setsaveddvar( "vehPlaneRollLerpRate", 0.25 );
        var_0 = getdvarvector( "vehCam_chaseOffset" );
        var_0 += anglestoforward( getdvarvector( "vehCam_chaseAngleOffset" ) ) * 10000;
    }

    level.player.jethud["hud_tag"] unlink();
    level.player.jethud["hud_tag"] linkto( level.plane, "tag_origin", var_0, ( 0, 0, 0 ) );
    level.player.jethud["hud_tag"] dontinterpolate();
    level.plane_chase_cam = !level.plane_chase_cam;
}

fighter_jet_max_altitude( var_0, var_1 )
{
    var_2 = -1000;
    var_3 = 1000;
    var_4 = 0.05;

    for (;;)
    {
        var_5 = ( 0, 0, var_2 );
        var_6 = ( 0, 0, -1 );
        var_7 = var_1.origin - var_5;
        var_8 = vectordot( var_7, var_6 );

        if ( var_8 < var_3 )
        {
            var_9 = maps\_shg_utility::linear_map_clamp( var_8, var_3, 0 - var_3, 0, 2 );
            var_10 = var_1 vehicle_getvelocity();
            var_11 = vectornormalize( var_10 );
            var_12 = vectordot( var_11, var_6 );

            if ( var_12 < var_4 )
            {
                var_13 = length( var_10 );
                var_14 = vectordot( var_10, var_6 ) * var_9 - var_4 * var_13;
                var_15 = vectornormalize( var_10 - var_14 * var_6 ) * var_13;
                var_1 vehicle_setvelocity( var_15 );
            }
        }

        waitframe();
    }
}

fighter_jet_handle_cockpit( var_0, var_1 )
{
    var_1 hide();
    var_2 = level.fake_plane;
    var_2 notsolid();
    var_3 = getdvarvector( "cockpit_offset" );
    var_4 = getdvarvector( "cockpit_angles" );
    var_2 linktoplayerview( var_0, "tag_origin", var_3, var_4, 1 );
    fighter_jet_handle_cockpit_motion( var_0, var_1, var_2, var_3, var_4 );
}

remove_cockpit_from_view( var_0, var_1, var_2 )
{
    level endon( "finale" );
    level.player common_scripts\utility::waittill_any( "player_eject", "toggle_chase_cam" );
    var_2 unlinkfromplayerview( var_0 );
}

fighter_jet_set_shake( var_0, var_1 )
{
    level notify( "jet_shake" );
    level endon( "jet_shake" );
    level.jet_shake = var_0;

    for ( var_2 = var_0 / ( var_1 / 0.05 ); var_1 > 0.0; var_1 -= 0.05 )
    {
        wait 0.05;
        level.jet_shake -= var_2;
    }

    level.jet_shake = 0.0;
}

fighter_jet_handle_cockpit_motion( var_0, var_1, var_2, var_3, var_4 )
{
    level.player endon( "toggle_chase_cam" );
    thread remove_cockpit_from_view( var_0, var_1, var_2 );
    var_5 = 0.1;
    var_6 = 0.1;
    var_7 = 0.975;
    var_8 = 0.002;
    var_9 = 0.005;
    var_10 = 0.002;
    var_11 = 10.0;
    var_12 = 5;
    var_13 = 5;
    var_14 = 0.00006;
    var_15 = 0.006;

    for ( var_16 = 1; var_16 < 8; var_16++ )
    {
        if ( isdefined( var_1 ) )
            var_1 maps\_shg_utility::get_differentiated_acceleration();

        waitframe();
    }

    var_17 = var_1.angles;
    var_18 = ( 0, 0, 0 );
    var_19 = ( 0, 0, 0 );
    var_20 = ( 0, 0, 0 );
    var_21 = ( 0, 0, 0 );
    var_22 = ( 0, 0, 0 );

    while ( isalive( level.player ) )
    {
        if ( isdefined( var_1 ) )
        {
            var_23 = var_1 maps\_shg_utility::get_differentiated_acceleration() + ( 0, 0, 386 );
            var_24 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), var_1.angles, var_23, ( 0, 0, 0 ) )["origin"];
            var_25 = angles_clamp_180( transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), var_17, ( 0, 0, 0 ), var_1.angles )["angles"] ) * 20;
            var_17 = var_1.angles;
            var_26 = ( var_25 - var_18 ) * 20;
            var_18 = var_25;
            var_19 = vectorlerp( var_19, var_24, var_5 );
            var_27 = var_24 - var_19;
            var_20 = vectorlerp( var_20, var_25, var_5 );
            var_28 = var_25 - var_20;
            var_29 = ( var_27[0] * var_6 * var_8, var_27[1] * var_6 * var_9, var_27[2] * var_6 * var_10 );

            if ( level.player_boosting )
                var_29 *= 1.25;

            var_21 = vectorlerp( var_29, var_21, var_7 );
            var_30 = ( var_28[0] * var_6 * var_12, var_28[1] * var_6 * var_13, var_28[2] * var_6 * var_11 );
            var_22 = euler_lerp( var_30, var_22, var_7 );
            var_31 = var_21 + common_scripts\utility::randomvector( var_14 * length( var_24 ) );
            var_32 = var_22 + common_scripts\utility::randomvector( var_15 * length( var_25 ) );

            if ( isdefined( level.jet_shake ) && level.jet_shake > 0.0 )
                var_31 += common_scripts\utility::randomvector( level.jet_shake );

            var_33 = transformmove( var_31, var_32, ( 0, 0, 0 ), ( 0, 0, 0 ), var_3, var_4 );
            var_2 unlinkfromplayerview( var_0 );
            var_2 linktoplayerview( var_0, "tag_origin", var_33["origin"], var_33["angles"], 1 );
        }

        waitframe();
    }
}

fighter_jet_handle_throttle( var_0, var_1, var_2 )
{
    var_1 endon( "death" );

    if ( !isdefined( var_2 ) )
        var_1 vehicle_planethrottleoverride( level.current_median_speed );
    else
    {
        for ( var_3 = 0; var_3 < level.current_median_speed; var_3 += 0.05 )
        {
            var_1 vehicle_planethrottleoverride( var_3 );
            wait 0.2;
        }
    }

    var_0 notifyonplayercommand( "boost_start", "+gostand" );
    var_0 notifyonplayercommand( "boost_stop", "-gostand" );
    var_0 notifyonplayercommand( "brake_click", "+stance" );
    var_0 notifyonplayercommand( "brake_click", "+prone" );
    var_0 notifyonplayercommand( "brake_click", "toggleprone" );
    thread handle_jet_brake( var_0, var_1 );
    thread handle_jet_boost( var_0, var_1 );
}

watch_player_braking( var_0 )
{
    common_scripts\utility::flag_set( "player_braking" );
    wait 2;
    var_0 notify( "brake_abort" );
    common_scripts\utility::flag_clear( "player_braking" );
}

process_flight_path( var_0 )
{
    level notify( "new_flight_path" );
    level endon( "new_flight_path" );
    var_1 = 0;
    var_2 = [];
    var_3 = 0;
    var_4 = undefined;
    var_5 = common_scripts\utility::getstruct( var_0, "targetname" );

    for ( var_2[var_1] = var_5; isdefined( var_5.target ); var_2[var_1] = var_5 )
    {
        var_5 = common_scripts\utility::getstruct( var_5.target, "targetname" );
        var_1++;
    }

    var_6 = var_2[var_3 + 1].origin - var_2[var_3].origin;
    var_6 = ( var_6[0], var_6[1], 0 );
    var_7 = vectortoangles( var_6 )[1];
    setsaveddvar( "vehPlanePathAngle", var_7 );

    if ( var_3 + 2 < var_2.size )
        var_4 = var_2[var_3 + 2].origin - var_2[var_3 + 1].origin;
    else
        var_4 = var_6;

    for (;;)
    {
        wait 0.5;
        var_8 = level.player.origin - var_2[var_3 + 1].origin;
        var_9 = vectordot( var_4, var_8 );

        if ( var_9 > 0 )
        {
            var_3++;

            if ( var_3 == var_2.size - 1 )
                break;

            var_6 = var_4;
            var_6 = ( var_6[0], var_6[1], 0 );
            var_7 = vectortoangles( var_6 )[1];
            setsaveddvar( "vehPlanePathAngle", var_7 );

            if ( var_3 + 2 < var_2.size )
                var_4 = var_2[var_3 + 2].origin - var_2[var_3 + 1].origin;
            else
                var_4 = var_6;
        }

        if ( common_scripts\utility::flag( "canyon_finished" ) )
            break;
    }

    setsaveddvar( "vehPlanePathAngle", -1.0 );
    setsaveddvar( "vehPlanePathAllowance", 0.0 );
}

handle_jet_brake( var_0, var_1 )
{
    level.player_airbraked = 0;

    while ( !common_scripts\utility::flag( "canyon_finished" ) )
    {
        var_0 waittill( "brake_click" );

        if ( common_scripts\utility::flag( "canyon_finished" ) )
            return;

        level.player_airbraked = 1;
        thread watch_player_braking( var_0 );
        var_1 playsound( "plr_jet_airbrake" );

        if ( level.nextgen )
            setsaveddvar( "r_mbVelocityScalar", 1.1 );

        var_1 vehicle_planethrottleoverride( 0.01 );
        level.player_braking = 1;
        var_0 playrumblelooponentity( "damage_heavy" );

        if ( !level.player.ads_on )
            var_0 lerpfov( 60, 1 );

        if ( level.player_boosting )
        {
            var_0 notify( "boost_stop" );
            waitframe();
        }

        var_0 common_scripts\utility::waittill_notify_or_timeout( "brake_abort", 2 );
        var_1 vehicle_planethrottleoverride( 0.25 );
        common_scripts\utility::flag_waitopen( "player_braking" );
        level.player_braking = 0;
        var_0 stoprumble( "damage_heavy" );

        if ( !level.player.ads_on )
            var_0 lerpfov( 65, 1 );

        if ( level.nextgen )
            setsaveddvar( "r_mbVelocityScalar", 2 );

        var_1 vehicle_planethrottleoverride( level.current_median_speed );
        wait 0;
        waitframe();
    }
}

handle_jet_boost( var_0, var_1 )
{
    level endon( "death" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    while ( !common_scripts\utility::flag( "canyon_finished" ) )
    {
        var_0 waittill( "boost_start" );

        if ( common_scripts\utility::flag( "canyon_finished" ) )
            return;

        var_1 playsound( "plr_jet_boost_start" );

        if ( level.nextgen )
        {
            setsaveddvar( "r_mbEnable", "2" );
            setsaveddvar( "r_mbVelocityScalar", 10 );
            setsaveddvar( "r_mbCameraRotationInfluence", "0" );
        }

        var_1 vehicle_planethrottleoverride( 1 );
        level.player_boosting = 1;
        level.player_boost_time = gettime();
        level notify( "player_boost_start" );
        var_0 playrumblelooponentity( "damage_heavy" );
        earthquake( 0.5, 1.0, level.player.origin, 512 );

        if ( !level.player.ads_on )
            var_0 lerpfov( 75, 1 );

        var_2 playloopsound( "plr_jet_boost_loop" );

        if ( level.player_braking )
        {
            var_0 notify( "brake_abort" );
            waitframe();
        }

        while ( level.player jumpbuttonpressed() && !common_scripts\utility::flag( "canyon_finished" ) )
        {
            thread fighter_jet_set_shake( 0.25, 0.25 );
            wait 0.05;
        }

        level.player_boosting = 0;
        var_0 stoprumble( "damage_heavy" );

        if ( !level.player.ads_on )
            var_0 lerpfov( 65, 1 );

        if ( level.nextgen )
            setsaveddvar( "r_mbVelocityScalar", 2 );

        var_1 vehicle_planethrottleoverride( level.current_median_speed );
        var_2 stoploopsound();
        var_1 playsound( "plr_jet_boost_stop" );
        waitframe();
    }
}

handle_ads()
{
    level endon( "death" );

    while ( !common_scripts\utility::flag( "finale" ) )
    {
        var_0 = level.player adsbuttonpressed();
        var_1 = undefined;

        if ( var_0 && !level.player.ads_on )
        {
            level.player.ads_on = 1;
            var_1 = 30;
        }
        else if ( !var_0 && level.player.ads_on )
        {
            level.player.ads_on = 0;
            var_1 = 65;

            if ( level.player_braking )
                var_1 = 60;

            if ( level.player_boosting )
                var_1 = 75;
        }

        if ( isdefined( var_1 ) )
            level.player lerpfov( var_1, 0.25 );

        wait 0.05;
    }
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

remove_fighter_jet_hud()
{
    self waittill( "remove_jet_hud" );

    foreach ( var_1 in self.jethud )
    {
        if ( isarray( var_1 ) )
        {
            foreach ( var_3 in var_1 )
            {
                if ( !isarray( var_3 ) )
                    var_3.alpha = 0;
            }

            continue;
        }

        var_1.alpha = 0;
    }
}

fighter_jet_hud( var_0, var_1 )
{
    var_0 thread remove_fighter_jet_hud();
    self endon( "end_canyon" );
    var_2 = 600;
    var_3 = ( 0.2, 1, 0.2 );
    var_4 = ( 0.4, 1, 0.4 );
    var_5 = 0.5;
    var_6 = 1.5;
    var_7 = 0.868976;
    var_8 = 9;
    var_9 = 10;
    var_10 = 5;
    var_11 = 25;
    var_12 = 10;
    var_13 = 5;
    var_14 = 2;
    var_15 = 5;
    var_16 = 0.5;

    if ( !isdefined( var_0.jethud ) )
        var_0.jethud = [];
    else
    {
        level notify( "jetHUD_init" );
        return;
    }

    var_17 = anglestoforward( ( 6, 0, 0 ) ) * 10000;

    if ( getdvar( "vehCam_mode" ) == "chase" )
    {
        var_17 = getdvarvector( "vehCam_chaseOffset" );
        var_17 += anglestoforward( getdvarvector( "vehCam_chaseAngleOffset" ) ) * 10000;
    }

    var_0.jethud["hud_tag"] = common_scripts\utility::spawn_tag_origin();
    var_0.jethud["hud_tag"] linkto( var_1, "tag_origin", var_17, ( 0, 0, 0 ) );
    var_0.jethud["weapon_bore_tag"] = common_scripts\utility::spawn_tag_origin();
    var_0.jethud["weapon_bore_tag"] linkto( var_1, "tag_origin", var_17, ( 0, 0, 0 ) );
    var_0.jethud["weapon_reticle_tag"] = common_scripts\utility::spawn_tag_origin();
    var_0.jethud["weapon_reticle_tag"] linkto( var_1, "tag_origin", var_17, ( 0, 0, 0 ) );
    var_0.jethud["boresight"] = newclienthudelem( var_0 );
    var_0.jethud["boresight"].positioninworld = 1;
    var_0.jethud["boresight"] settargetent( var_0.jethud["hud_tag"] );
    var_0.jethud["boresight"].alignx = "center";
    var_0.jethud["boresight"].aligny = "middle";
    var_0.jethud["boresight"] setshader( "hud_plane_reticle", 40, 40 );
    var_0.jethud["boresight"].alpha = var_5;
    var_0.jethud["lockon_warning"] = newclienthudelem( var_0 );
    var_0.jethud["lockon_warning"].hidewheninmenu = 1;
    var_0.jethud["lockon_warning"].hidewhendead = 1;
    var_0.jethud["lockon_warning"].alignx = "center";
    var_0.jethud["lockon_warning"].aligny = "middle";
    var_0.jethud["lockon_warning"].x = 320;
    var_0.jethud["lockon_warning"].y = 320;
    var_0.jethud["lockon_warning"] settext( "ENEMY LOCK" );
    var_0.jethud["lockon_warning"].color = ( 1, 0.2, 0.2 );
    var_0.jethud["lockon_warning"].alpha = 0;
    var_0.jethud["lockon_warning"].fontscale = 3;
    var_0.jethud["speed_indicator"] = newclienthudelem( var_0 );
    var_0.jethud["speed_indicator"].positioninworld = 1;
    var_0.jethud["speed_indicator"] settargetent( var_0.jethud["hud_tag"] );
    var_0.jethud["speed_indicator"].alignx = "right";
    var_0.jethud["speed_indicator"].aligny = "middle";
    var_0.jethud["speed_indicator"].x = -300;
    var_0.jethud["speed_indicator"].y = 0;
    var_0.jethud["speed_indicator"].color = var_3;
    var_0.jethud["speed_indicator"].alpha = 0;
    var_0.jethud["speed_indicator"].fontscale = var_6;
    var_0.jethud["jetWeapons"] = newclienthudelem( var_0 );
    var_0.jethud["jetWeapons"].positioninworld = 1;
    var_0.jethud["jetWeapons"] settargetent( var_0.jethud["hud_tag"] );
    var_0.jethud["jetWeapons"].alignx = "center";
    var_0.jethud["jetWeapons"].aligny = "top";
    var_0.jethud["jetWeapons"].y = -50;
    var_0.jethud["jetWeapons"].color = var_3;
    var_0.jethud["jetWeapons"].glowcolor = var_4;
    var_0.jethud["jetWeapons"].alpha = 0;
    var_0.jethud["jetWeapons"].fontscale = var_6;
    var_0.jethud["weaponOverlay"] = newclienthudelem( var_0 );
    var_0.jethud["weaponOverlay"].positioninworld = 1;
    var_0.jethud["weaponOverlay"] settargetent( var_0.jethud["hud_tag"] );
    var_0.jethud["weaponOverlay"] setshader( "jet_hud_overlay_cannon_1", 640, 480 );
    var_0.jethud["weaponOverlay"].alignx = "center";
    var_0.jethud["weaponOverlay"].aligny = "middle";
    var_0.jethud["weaponOverlay"].alpha = 0.35;
    var_0.jethud["weaponOverlay"].fontscale = var_6;
    var_0.jethud["weapon_boresight"] = newclienthudelem( var_0 );
    var_0.jethud["weapon_boresight"].positioninworld = 1;
    var_0.jethud["weapon_boresight"] settargetent( var_0.jethud["weapon_bore_tag"] );
    var_0.jethud["weapon_boresight"] setshader( "jet_hud_overlay_cannon_boresight", 640, 480 );
    var_0.jethud["weapon_boresight"].alignx = "center";
    var_0.jethud["weapon_boresight"].aligny = "middle";
    var_0.jethud["weapon_boresight"].alpha = 0.8;
    var_0.jethud["weapon_boresight"].fontscale = var_6;
    var_0.jethud["weapon_reticle"] = newclienthudelem( var_0 );
    var_0.jethud["weapon_reticle"].positioninworld = 1;
    var_0.jethud["weapon_reticle"] settargetent( var_0.jethud["weapon_reticle_tag"] );
    var_0.jethud["weapon_reticle"] setshader( "jet_hud_overlay_cannon_boresight", 640, 480 );
    var_0.jethud["weapon_reticle"].alignx = "center";
    var_0.jethud["weapon_reticle"].aligny = "middle";
    var_0.jethud["weapon_reticle"].alpha = 0.8;
    var_0.jethud["weapon_reticle"].fontscale = var_6;
    var_18 = 4;
    var_19 = -325;
    var_20 = 325;
    var_21 = -120;
    var_22 = 35;
    var_23 = [];
    var_23[0] = make_missile_ammo_hud( 0, level.plane.salvo_ammo[0], var_19, var_21, var_0.jethud["hud_tag"] );
    var_23[1] = make_missile_ammo_hud( 1, level.plane.salvo_ammo[1], var_19, var_22, var_0.jethud["hud_tag"] );
    var_0.jethud["missile_ammo"] = array_combine_all( var_23[0], var_23[1] );
    var_0.jethud["weapon_bore"] = newclienthudelem( var_0 );
    var_0.jethud["weapon_bore"].positioninworld = 1;
    var_0.jethud["weapon_bore"] settargetent( var_0.jethud["weapon_bore_tag"] );
    var_0.jethud["weapon_bore"].alignx = "center";
    var_0.jethud["weapon_bore"].aligny = "middle";
    var_0.jethud["weapon_bore"].alpha = 0;
    var_0.jethud["weapon_bore"].fontscale = var_6;
    var_0.jethud["LockOn_Overlay"] = newclienthudelem( var_0 );
    var_0.jethud["LockOn_Overlay"].positioninworld = 1;
    var_0.jethud["LockOn_Overlay"] settargetent( var_0.jethud["weapon_bore_tag"] );
    var_0.jethud["LockOn_Overlay"].alignx = "center";
    var_0.jethud["LockOn_Overlay"].aligny = "middle";
    var_0.jethud["LockOn_Overlay"].alpha = 0;
    var_0.jethud["LockOn_Overlay"].fontscale = var_6;
    var_0.jethud["altitude_indicator"] = newclienthudelem( var_0 );
    var_0.jethud["altitude_indicator"].positioninworld = 1;
    var_0.jethud["altitude_indicator"] settargetent( var_0.jethud["hud_tag"] );
    var_0.jethud["altitude_indicator"].alignx = "left";
    var_0.jethud["altitude_indicator"].aligny = "middle";
    var_0.jethud["altitude_indicator"].x = 300;
    var_0.jethud["altitude_indicator"].y = 0;
    var_0.jethud["altitude_indicator"].color = var_3;
    var_0.jethud["altitude_indicator"].alpha = 0;
    var_0.jethud["altitude_indicator"].fontscale = var_6;
    level notify( "jetHUD_init" );
    var_24 = 0;

    if ( !isdefined( level.base_agl ) )
        level.base_agl = 0;

    for (;;)
    {
        if ( !isdefined( var_1 ) )
            break;

        var_25 = var_1 vehicle_getvelocity();
        var_26 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), var_1.angles, var_25, ( 0, 0, 0 ) )["origin"];
        var_27 = var_1 vehicle_getspeed();

        if ( level.mini_version )
            var_27 *= 5;

        var_0.jethud["speed_indicator"] settext( "" + var_27 + " mph" );
        var_28 = bullettrace( var_1.origin, var_1.origin + ( 0, 0, -66000 ), 0, var_1, 0 );

        if ( isdefined( var_28["position"] ) )
            var_29 = var_1.origin[2] - var_28["position"][2];
        else
            var_29 = 119988;

        var_0.jethud["altitude_indicator"] settext( "" + int( level.base_agl + var_29 / 12 ) + " ft agl" );
        var_30 = var_1 gettagorigin( "tag_player" ) + anglestoup( var_1 gettagangles( "tag_player" ) ) * var_2;

        for ( var_31 = 0; var_31 < var_23.size; var_31++ )
        {
            var_32 = var_23[var_31];
            var_18 = level.plane.salvo_ammo[var_31];

            foreach ( var_34 in var_32 )
            {
                var_34.alpha = 0.0;
                var_18--;
            }
        }

        waitframe();
    }
}

fighter_jet_sounds( var_0, var_1 )
{
    level endon( "finale" );
    thread canyon_whizby_sounds( var_0, var_1 );
    thread missile_lock_sounds( var_0, var_1 );
    thread gun_lock_sounds( var_0, var_1 );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 playloopsound( "dogfight_player_plane_low" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 linkto( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 playloopsound( "dogfight_player_plane_turbulence" );
    var_4 = 2;
    var_5 = 0.05 / var_4;
    var_6 = 0;

    while ( isalive( var_0 ) && isdefined( var_1 ) )
    {
        var_7 = var_1 vehicle_getthrottle();
        var_6 = clamp( var_7, var_6 - var_5, var_6 + var_5 );
        var_8 = vectordot( var_1 maps\_shg_utility::get_differentiated_acceleration() + ( 0, 0, 384 ), anglestoup( var_1.angles ) ) / 384;
        var_2 scalepitch( maps\_shg_utility::linear_map_clamp( var_6, 0, 1, 0.8, 1.2 ), 0.05 );
        var_2 scalevolume( maps\_shg_utility::linear_map_clamp( var_7, 0, 1, 0.5, 1 ), 0.05 );
        var_9 = maps\_shg_utility::linear_map_clamp( abs( var_8 ), 0, 8, 0.2, 1 );
        var_3 scalevolume( var_9, 0.05 );
        waitframe();
    }

    var_2 stoploopsound();
    var_3 stoploopsound();
    level.player playsound( "dogfight_player_plane_death" );
}

missile_lock_sounds( var_0, var_1 )
{
    level endon( "finale" );
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2 linkto( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3 = 0;
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4 linkto( var_0, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 = 0;
    var_6 = var_1.lock_targets.size;

    while ( isalive( level.player ) )
    {
        var_7 = "none";

        if ( isdefined( var_1.lock_targets ) )
        {
            if ( var_1.lock_targets.size > 0 )
            {
                var_7 = "locked";

                if ( var_1.lock_targets.size > var_6 )
                    var_1 playsound( "dogfight_player_guns_locked" );
            }

            var_6 = var_1.lock_targets.size;
            var_7 = "locking";
        }

        var_8 = var_7 == "locked";
        var_9 = var_7 == "locking";
        waitframe();
    }
}

gun_lock_sounds( var_0, var_1 )
{
    level endon( "finale" );
    var_2 = 0;
    var_3 = 0;

    while ( isalive( level.player ) )
    {
        var_4 = "none";

        if ( isdefined( var_1.lock_target ) )
            var_4 = "locked";

        var_5 = var_4 == "locked";
        var_6 = var_4 == "locking";

        if ( var_6 && !var_2 )
        {
            var_1 playsound( "dogfight_player_guns_targeting" );
            var_2 = 1;
        }
        else if ( !var_6 && var_2 )
            var_2 = 0;

        if ( var_5 && !var_3 )
        {
            var_1 playsound( "dogfight_player_guns_locked" );
            var_3 = 1;
        }
        else if ( !var_5 && var_3 )
            var_3 = 0;

        waitframe();
    }
}

canyon_whizby_sounds( var_0, var_1 )
{
    foreach ( var_3 in [ -1, 0, 1 ] )
    {
        foreach ( var_5 in [ -1, 0, 1 ] )
        {
            if ( var_3 != 0 || var_5 != 0 )
                thread canyon_whizby_sound( var_0, var_1, vectornormalize( ( 0, var_3, var_5 ) ) );
        }
    }
}

canyon_whizby_sound( var_0, var_1, var_2 )
{
    level endon( "end_canyon" );
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3 playloopsound( "dogfight_player_plane_canyon_reflection" );
    var_4 = 3000;
    var_5 = 0.1;
    var_6 = var_4;
    var_7 = var_1.origin;

    for (;;)
    {
        var_8 = var_1.origin + var_1 maps\_shg_utility::get_differentiated_velocity() * var_5;
        var_9 = transformmove( var_8, var_1.angles, ( 0, 0, 0 ), ( 0, 0, 0 ), var_2 * var_4, ( 0, 0, 0 ) )["origin"];
        var_10 = bullettrace( var_8, var_9, 0, var_1 );

        if ( var_10["fraction"] < 1 )
            var_3.origin = var_10["position"];

        var_11 = soundscripts\_audio_vehicle_manager::avm_compute_doppler_pitch( var_3.origin, ( 0, 0, 0 ), var_0.origin, var_0 maps\_shg_utility::get_differentiated_velocity(), 1, 1 );
        var_3 scalepitch( var_11, 0.05 );
        waitframe();
    }
}

get_crash_deflection_angle()
{
    var_0 = 30;
    var_1 = maps\_utility::getdifficulty();

    switch ( var_1 )
    {
        case "medium":
            var_0 = 25;
            break;
        case "hard":
            var_0 = 20;
            break;
        case "fu":
            var_0 = 10;
            break;
    }

    return var_0;
}

fighter_jet_crash_detection( var_0, var_1 )
{
    var_0 endon( "death" );
    var_1 endon( "death" );
    var_2 = 7744;
    var_3 = var_1.origin;
    var_4 = 1;
    var_5 = -30;
    var_6 = 50;
    var_7 = -1;
    var_8 = 20;
    var_9 = 0 - var_8;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = maps\_utility::getdifficulty();
    var_15 = get_crash_deflection_angle();
    var_16 = cos( var_15 );

    for (;;)
    {
        if ( maps\_utility::getdifficulty() != var_14 )
        {
            var_14 = maps\_utility::getdifficulty();
            var_15 = get_crash_deflection_angle();
            var_16 = cos( var_15 );
        }

        var_1 waittill( "veh_collision", var_17, var_18, var_19 );
        var_20 = vectordot( vectornormalize( var_17 ), vectornormalize( var_1 vehicle_getvelocity() ) );
        var_21 = 0;
        var_22 = var_20 < var_16;
        var_23 = gettime();

        if ( isdefined( var_19 ) && var_19 maps\_vehicle::isvehicle() )
            continue;

        if ( ( !isdefined( var_19 ) || isdefined( var_19 ) && isdefined( var_19.targetname ) && var_19.targetname != "turnaround_vol" ) && getdvarfloat( "vehPlanePathAngle" ) >= 0.0 && getdvarfloat( "vehPlanePathAllowance" ) > 0.0 )
        {
            var_24 = angleclamp( level.player.angles[1] );
            var_25 = angleclamp180( var_24 - getdvarfloat( "vehPlanePathAngle" ) );

            if ( abs( var_25 ) >= 60.0 )
            {
                if ( var_23 - var_11 >= 500 )
                {
                    var_10 = 0;
                    var_11 = gettime();
                }

                var_10++;

                if ( var_10 >= 3 )
                    var_21 = 1;
            }
        }

        if ( distancesquared( var_1.origin, var_3 ) < var_2 )
            var_21 = 1;

        var_3 = var_1.origin;

        if ( !var_21 && isdefined( var_19 ) && isdefined( var_19.targetname ) && var_19.targetname == "turnaround_vol" && var_10 < 3 )
            continue;

        var_26 = getbumpallowancebasedondifficulty();

        if ( !var_21 )
        {
            if ( isdefined( var_19 ) && var_19.targetname == "floor_clip" )
            {
                thread reversegravity( 1 );
                var_12++;
                var_27 = gettimeallowancebasedondifficulty();

                if ( var_27 > 0 && var_23 > var_13 + var_27 )
                {
                    var_13 = var_23;
                    var_12 = 1;
                }
                else if ( var_26 > 0 && var_12 > var_26 )
                    var_21 = 1;

                if ( var_22 && maps\_utility::getdifficulty() == "fu" )
                    var_21 = 1;

                if ( var_26 > 0 && var_12 > var_26 - 15 )
                    thread fake_damage_indicator( ( 0, 0, -1 ), ( var_27 - ( var_23 - var_13 ) ) / 1000, 0, undefined, 1 );
            }
            else if ( var_22 )
                var_21 = 1;
        }

        if ( isdefined( var_19 ) && var_19.targetname != "floor_clip" || var_26 > 0 )
            var_1 notify( "damage", 1, level, undefined, var_1.origin, "COLLISION", "", "" );

        thread fighter_jet_set_shake( 5, 1.0 );
        var_1 playsound( "plr_jet_bounce_hit" );

        if ( var_21 )
        {
            thread common_scripts\utility::play_sound_in_space( "plr_jet_crash_hit", level.player.origin );
            level.player digitaldistortsetparams( 1, 1 );
            thread fadeupstatic( 0.05, 1 );
            level notify( "kill_player_targeting_think" );
            var_28 = target_getarray();

            foreach ( var_30 in var_28 )
            {
                target_hidefromplayer( var_30, level.player );
                target_remove( var_30 );
            }

            level.plane.lock_targets = [];
            wait 0.05;
            var_0 dismountvehicle();
            wait 0.25;
            setdvar( "ui_deadquote", &"PLAYERPLANE_YOU_CRASHED" );
            maps\_utility::missionfailedwrapper();
            continue;
        }

        var_1 notify( "plane_bump" );
    }
}

reversegravity( var_0 )
{
    level notify( "reverse_gravity" );
    level endon( "reverse_gravity" );

    if ( !isdefined( level.old_gravity ) )
        level.old_gravity = getdvarfloat( "vehPlaneGravityVelocity" );

    setsaveddvar( "vehPlaneGravityVelocity", level.old_gravity * -0.5 );
    wait(var_0);
    setsaveddvar( "vehPlaneGravityVelocity", level.old_gravity );
}

gettimeallowancebasedondifficulty()
{
    var_0 = maps\_utility::getdifficulty();
    var_1 = -1;

    switch ( var_0 )
    {
        case "medium":
            var_1 = 3;
            break;
        case "hard":
            var_1 = 1.5;
            break;
        case "fu":
            var_1 = 3;
    }

    return var_1 * 1000;
}

getbumpallowancebasedondifficulty()
{
    var_0 = maps\_utility::getdifficulty();
    var_1 = -1;

    switch ( var_0 )
    {
        case "medium":
            var_1 = 50;
            break;
        case "hard":
            var_1 = 15;
            break;
        case "fu":
            var_1 = 15;
    }

    return var_1;
}

monitor_missile_firing()
{
    self.depleted = 0;

    for (;;)
    {
        level.player waittill( "missile_shot", var_0, var_1 );

        if ( self.salvo_idx == var_0 && self.missile_idx == var_1 )
        {
            self setshader( "jet_hud_ammo_missile_0", self.dimensionsx, self.dimensionsy );
            self.depleted = 1;
            wait 12;
            self setshader( "jet_hud_ammo_missile_1", self.dimensionsx, self.dimensionsy );
            self.depleted = 0;
        }
    }
}

monitor_missile_indication()
{
    level.player endon( "death" );
    level endon( "end_canyon" );

    for (;;)
    {
        var_0 = level.player common_scripts\utility::waittill_any_return( "lock_on", "locked_on_off", "y_pressed" );

        if ( isdefined( var_0 ) && var_0 == "locked_on" )
        {
            self.alpha = 0.75;
            self.color = ( 1, 0.2, 0.2 );
        }

        if ( var_0 == "locked_on_off" || var_0 == "y_pressed" )
        {
            self.alpha = 0.75;
            self.color = ( 0.2, 0.3, 1 );
        }
    }
}

make_missile_ammo_hud( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = [];
    var_6 = 5;
    var_7 = 20;

    for ( var_8 = 0; var_8 < var_1; var_8++ )
    {
        var_9 = newclienthudelem( level.player );
        var_9.positioninworld = 1;
        var_9 settargetent( var_4 );
        var_9 setshader( "jet_hud_ammo_missile_1", var_7, var_6 );
        var_9.alignx = "center";
        var_9.aligny = "middle";
        var_9.x = var_2;
        var_9.y = var_3 + var_6 * var_5.size + 20 * var_5.size;
        var_9.alpha = 0.1;
        var_9.salvo_idx = var_0;
        var_9.missile_idx = var_8;
        var_9.dimensionsx = var_7;
        var_9.dimensionsy = var_6;
        var_9 thread monitor_missile_firing();
        var_5[var_5.size] = var_9;
    }

    return var_5;
}

rotate_axis_angle( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( var_0 );
    return transformmove( ( 0, 0, 0 ), var_3 + ( 0, 0, var_1 ), ( 0, 0, 0 ), var_3, var_2, ( 0, 0, 0 ) )["origin"];
}

fighter_jet_gun_hud()
{
    level.player endon( "death" );
    level endon( "end_canyon" );
    var_0 = 0;
    var_1 = 0;
    var_2 = 0.99;
    var_3 = 0.0;
    var_4 = 10;
    var_5 = cos( 5 );
    var_6 = 50000;
    var_7 = 250000;
    var_8 = 13000;
    var_9 = get_plane_gun_angles();
    var_10 = anglestoforward( get_plane_gun_angles() );
    var_11 = var_10;
    var_12 = var_10;

    while ( isdefined( level.plane ) )
    {
        var_13 = get_plane_gun_origin();
        var_14 = level.player geteye();
        level.player.eye_origin = var_14;
        var_15 = get_plane_gun_angles();
        var_16 = anglestoforward( var_15 );
        var_17 = anglestoup( var_15 );
        var_18 = anglestoright( var_15 );
        var_12 = vectornormalize( transformmove( ( 0, 0, 0 ), var_15, ( 0, 0, 0 ), var_9, var_12, ( 0, 0, 0 ) )["origin"] );
        var_19 = ( var_16 - anglestoforward( var_9 ) ) * 20;
        var_9 = var_15;
        var_20 = undefined;
        var_21 = vectornormalize( var_16 + var_19 * var_0 );
        var_11 = vectornormalize( vectorlerp( var_21, var_11, var_1 ) );
        var_22 = undefined;
        var_22 = compute_best_gun_target( var_16, var_14, var_13, var_6, level.plane.lock_target );

        if ( isdefined( var_22 ) )
        {
            compute_target_lead_origin( var_22, var_13, var_6 );
            var_23 = vectornormalize( var_22.lead_origin - var_14 );
            var_24 = vectornormalize( vectorlerp( var_16, var_23, var_2 ) );
            var_25 = 1;
        }
        else
        {
            var_24 = vectornormalize( level.player.jethud["hud_tag"].origin - var_13 );
            var_25 = 0;
        }

        var_26 = constrain_vector_to_cone( var_24, var_11, var_4 );
        var_12 = vectornormalize( vectorlerp( var_26, var_12, var_3 ) );

        if ( isdefined( var_22 ) )
            var_27 = distance( var_22.lead_origin, var_14 );
        else
            var_27 = 25000;

        level.plane.player_gun_lock_target_origin = var_14 + var_27 * var_12;
        var_28 = 0;

        if ( isdefined( var_22 ) )
        {
            if ( vectordot( vectornormalize( var_22.lead_origin - var_14 ), var_12 ) > var_5 )
                var_28 = 1;
        }

        level.player.jethud["weapon_reticle"] setshader( "jet_hud_overlay_cannon_reticle_lockon", 640, 480 );
        level.plane.lock_target = var_22;
        var_29 = var_14 + var_12 * var_7;
        level.player.jethud["weapon_bore_tag"] unlink();
        level.player.jethud["weapon_bore_tag"].origin = var_29;
        level.player.jethud["weapon_bore_tag"] linkto( level.plane, "tag_player" );
        var_30 = var_14 + var_11 * var_7;
        level.player.reticle_origin = var_30;
        level.player.jethud["weapon_reticle_tag"] unlink();
        level.player.jethud["weapon_reticle_tag"].origin = var_30;
        level.player.jethud["weapon_reticle_tag"] linkto( level.plane, "tag_player" );
        waitframe();
    }
}

compute_best_gun_target( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = cos( 25 );
    var_6 = cos( 25 );
    var_7 = 15000;
    var_8 = 0;
    var_9 = 10;
    var_10 = 0;

    if ( level.player adsbuttonpressed( 1 ) )
        var_10 = 0;

    var_11 = undefined;
    var_12 = 0;

    if ( isdefined( level.enemy_units ) )
    {
        foreach ( var_14 in level.enemy_units )
        {
            if ( !isdefined( var_14 ) || !isdefined( var_14.origin ) )
                continue;

            compute_target_lead_origin( var_14, var_2, var_3 );

            if ( !isdefined( var_14.lead_origin ) )
                continue;

            var_15 = distance( var_14.origin, var_1 );

            if ( var_15 > var_7 )
                continue;

            var_16 = isdefined( var_4 ) && var_14 == var_4;
            var_17 = vectordot( vectornormalize( var_14.origin - var_1 ), var_0 );

            if ( var_16 && var_17 < var_6 )
                continue;
            else if ( !var_16 && var_17 < var_5 )
                continue;

            if ( !var_14 has_los() )
                continue;

            var_18 = 0;
            var_18 += maps\_shg_utility::linear_map_clamp( var_17, 1, var_5, var_9, 0 );
            var_18 += maps\_shg_utility::linear_map_clamp( var_15, 0, var_7, var_8, 0 );

            if ( var_16 )
                var_18 += var_10;

            if ( var_18 > var_12 )
                var_11 = var_14;
        }
    }

    return var_11;
}

compute_target_lead_origin( var_0, var_1, var_2 )
{
    var_3 = var_0 maps\_shg_utility::get_differentiated_velocity();
    var_4 = var_0.origin - var_1;
    var_5 = lengthsquared( var_3 ) - squared( var_2 );
    var_6 = 2 * vectordot( var_3, var_4 );
    var_7 = lengthsquared( var_4 );
    var_8 = squared( var_6 ) - 4 * var_5 * var_7;

    if ( var_8 > 0 )
    {
        var_9 = 2 * var_7 / ( sqrt( var_8 ) - var_6 );
        var_9 += 0.05;
        var_0.lead_origin = var_0.origin + var_0 maps\_shg_utility::get_differentiated_velocity() * var_9;
    }
    else
        var_0.lead_origin = undefined;
}

constrain_vector_to_cone( var_0, var_1, var_2 )
{
    var_3 = vectordot( var_1, var_0 );

    if ( var_3 < cos( var_2 ) )
    {
        var_4 = var_0 - var_1 * var_3;
        var_5 = length( var_4 );
        var_6 = var_5 / tan( var_2 );
        return vectornormalize( var_0 + var_1 * ( var_6 - var_3 ) );
    }
    else
        return var_0;
}

is_true( var_0 )
{
    return isdefined( var_0 ) && var_0;
}

waittill_any_trigger( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_7 = [ var_0, var_1, var_2, var_3, var_4, var_5 ];

    foreach ( var_10, var_9 in var_7 )
    {
        if ( isdefined( var_9 ) )
            var_6 thread notify_on_trigger( "trig" + var_10, var_9 );
    }

    var_6 common_scripts\utility::waittill_any( "trig0", "trig1", "trig2", "trig3", "trig4", "trig5" );
}

waittill_trigger_with_name( var_0 )
{
    var_1 = getent( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        var_1 = getent( var_0, "script_noteworthy" );

    if ( !isdefined( var_1 ) )
        return;

    var_1 waittill( "trigger" );
}

sortbydistanceauto( var_0, var_1, var_2 )
{
    return sortbydistance( var_0, var_1, var_2, 1 );
}

target_setsafe( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_2 = getentarray();
    var_3 = 0;
    var_4 = 60;
    var_5 = [];

    foreach ( var_7 in var_2 )
    {
        if ( target_istarget( var_7 ) )
        {
            var_3++;
            var_5[var_5.size] = var_7;
        }
    }

    if ( var_3 < var_4 )
        target_set( var_0 );
    else if ( var_1 )
    {
        var_5 = sortbydistanceauto( var_5, var_0.origin );
        var_5 = common_scripts\utility::array_reverse( var_5 );
        var_0.forcetarget = 1;

        foreach ( var_10 in var_5 )
        {
            if ( !isdefined( var_10.forcetarget ) || !var_10.forcetarget )
            {
                target_remove( var_10 );
                target_set( var_0 );
                break;
            }
        }
    }
}

notify_on_trigger_with_name( var_0, var_1 )
{
    waittill_trigger_with_name( var_1 );

    if ( isdefined( self ) )
        self notify( var_0 );
    else
        level notify( var_0 );
}

notify_on_trigger( var_0, var_1 )
{
    var_1 waittill( "trigger" );

    if ( isdefined( self ) )
        self notify( var_0 );
    else
        level notify( var_0 );
}

notify_on_use_trigger( var_0, var_1 )
{
    var_1 waittill( "trigger" );
    self notify( var_0 );
}

target_setshadersafe( var_0, var_1 )
{
    if ( target_istarget( var_0 ) )
        target_setshader( var_0, var_1 );
}

offset_position_from_tag( var_0, var_1, var_2 )
{
    var_3 = self gettagangles( var_1 );
    var_4 = self gettagorigin( var_1 );

    if ( var_0 == "up" )
        return var_4 + anglestoup( var_3 ) * var_2;

    if ( var_0 == "down" )
        return var_4 + anglestoup( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "right" )
        return var_4 + anglestoright( var_3 ) * var_2;

    if ( var_0 == "left" )
        return var_4 + anglestoright( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "forward" )
        return var_4 + anglestoforward( var_3 ) * var_2;

    if ( var_0 == "backward" )
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );
}

is_ground_enemy( var_0 )
{
    if ( isdefined( var_0.ground_target ) )
        return 1;

    return 0;
}

generic_human()
{

}

fx_init()
{

}

array_combine_all( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = [ var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 ];
    var_10 = [];

    foreach ( var_12 in var_9 )
    {
        if ( isdefined( var_12 ) )
            var_10 = common_scripts\utility::array_combine( var_10, var_12 );
    }

    return var_10;
}

shoot_target_till_dead( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "stop_engaging" );

    while ( isdefined( self ) && isalive( var_0 ) && isalive( self ) )
    {
        var_3 = maps\_utility::get_dot( self.origin, self.angles, var_0.origin );

        if ( var_3 > 0.15 )
        {
            thread ai_shoot_missile_salvo( var_0, var_1 );
            var_0 notify( "missile_fired_at" );
        }

        wait(var_2);
    }
}

ai_shoot_missile_salvo( var_0, var_1 )
{
    if ( isalive( var_0 ) )
    {
        for ( var_2 = 0; var_2 < var_1; var_2++ )
            thread ai_shoot_missile( var_0 );
    }
}

ai_shoot_missile( var_0 )
{
    var_1 = offset_position_from_tag( "forward", "tag_origin", 1000 );
    self playsound( "canyon_missile_fire_npc" );
    var_2 = magicbullet( "sidewinder_atlas_jet", var_1, var_0.origin );
    var_2 missile_settargetent( var_0 );
    var_2 thread monitor_missile_death( 1, self, undefined, var_0 );
    return var_2;
}

get_jet_array( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "script_noteworthy";

    var_2 = getentarray( var_0, var_1 );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( isalive( var_5 ) )
            var_3[var_3.size] = var_5;
    }

    return var_3;
}

engage_enemies( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    level endon( "finale" );

    if ( !isdefined( var_5 ) )
        var_5 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    var_0 = maps\_utility::remove_dead_from_array( var_0 );
    var_6 = var_0;

    if ( var_0.size < 1 || var_1.size < 1 )
        return;

    while ( var_0.size < var_1.size * var_4 )
        var_0 = common_scripts\utility::array_combine( var_0, var_6 );

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 10;

    var_7 = 0;

    foreach ( var_9 in var_1 )
    {
        if ( is_true( var_9.ground_target ) )
            continue;

        if ( var_0.size <= 0 )
            break;

        for ( var_10 = 0; var_10 < var_4; var_10++ )
        {
            if ( var_0.size <= 0 )
                continue;

            if ( var_0[var_7].script_team == "allies" )
                level notify( "ally_targeting_enemy" );

            var_0[var_7] thread shoot_target_till_dead( var_9, var_5, var_3 );
            wait(var_2);
            var_0 = maps\_utility::remove_dead_from_array( var_0 );
            var_7++;

            if ( var_7 >= var_0.size )
                var_7 = 0;
        }
    }
}

rake_with_bullets( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( !isdefined( var_2 ) )
        var_2 = 1.0;

    if ( !isdefined( var_1 ) )
        var_1 = 0.5;

    var_3 = gettime();
    var_4 = var_3 + randomfloatrange( var_1, var_2 ) * 1000;
    var_5 = maps\_utility::get_dot( self.origin, self.angles, var_0.origin );
    self playloopsound( "s19_mgun_shot_lp_npc" );

    while ( var_3 < var_4 && var_5 > 0 && isdefined( var_0 ) && isalive( var_0 ) )
    {
        if ( !isdefined( var_0.model ) || var_0.model == "" )
            break;

        var_6 = offset_position_from_tag( "forward", self.mgun_left, 1000 );
        var_7 = var_0.origin;

        if ( maps\_utility::hastag( var_0.model, "tag_origin" ) )
            var_7 = var_0 offset_position_from_tag( "forward", "tag_origin", 1200 );

        var_8 = magicbullet( "s19_cannon_AI", var_6, var_7 );
        wait 0.1;
        var_9 = offset_position_from_tag( "forward", self.mgun_right, 1000 );
        var_8 = magicbullet( "s19_cannon_AI", var_9, var_7 );
        wait 0.2;

        if ( isdefined( var_0 ) && isalive( var_0 ) )
        {
            var_5 = maps\_utility::get_dot( self.origin, self.angles, var_0.origin );
            var_3 = gettime();
        }
    }

    self stoploopsound( "s19_mgun_shot_lp_npc" );
    self playsound( "s19_mgun_shot_lp_end_npc" );
    wait(randomfloatrange( 0.3, 1.0 ));
}

lock_on_warning( var_0 )
{
    level.player.jethud["lockon_warning"].color = ( 1, 0.2, 0.2 );
    level.player.jethud["lockon_warning"] settext( "ENEMY LOCK" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1 linkto( self, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.player.jethud["lockon_warning"].alpha = 1;
    var_1 playloopsound( "dogfight_player_missile_locked_lp" );
    var_0 common_scripts\utility::waittill_any( "stop_lock_on_warning", "death" );
    level.player.jethud["lockon_warning"].alpha = 0;
    var_1 stoploopsound();
    waitframe();
    var_1 delete();
}

lock_on_to_player()
{
    if ( 1 )
    {
        if ( gettime() > level.last_missile_fired_at_player + 2500.0 )
        {
            level.plane thread fake_damage_indicator( vectornormalize( level.plane.origin - self.origin ) );
            thread missile_miss_player();
            level.last_missile_fired_at_player = gettime();
        }
    }
    else if ( common_scripts\utility::flag( "target_player" ) && !level.enemy_locking_on_to_player && gettime() >= level.last_missile_fired_at_player + 5000 )
    {
        level.player notify( "enemy_lock_on" );
        level.enemy_locking_on_to_player = 1;
        level.player_popped_flares = 0;
        level.player thread maps\_utility::display_hint_timeout( "flares_hint", 2 );
        level.player thread lock_on_warning( self );
        var_0 = level common_scripts\utility::waittill_notify_or_timeout_return( "pop_flares", 1.0 );
        waitframe();

        if ( level.flares_active )
            thread missile_miss_player();
        else if ( isalive( self ) )
        {
            var_1 = maps\_utility::get_dot( self.origin, self.angles, level.player.origin );

            if ( var_0 == "timeout" && var_1 > 0 )
            {
                level.player.jethud["lockon_warning"].color = ( 1, 0, 0 );
                level.player.jethud["lockon_warning"] settext( "FIRING" );
                level common_scripts\utility::waittill_notify_or_timeout( "pop_flares", 1.0 );

                if ( level.flares_active )
                    thread missile_miss_player();
                else
                {
                    level.player playsound( "plr_jet_hit_by_missile_lyr1" );
                    var_2 = magicbullet( "sidewinder_atlas_jet", level.plane.fake_enemy_missile_spawn.origin, level.plane.missile_target.origin );
                    var_2 missile_settargetent( level.plane.missile_target );
                    wait 0.25;
                    playfxontag( level._effect["explosion"], level.plane, "tag_origin" );
                    level.plane dodamage( 10, level.plane.origin, self, self, "MOD_EXPLOSIVE", "sidewinder_atlas_jet" );
                    level.plane vehicle_teleport( level.plane.origin, level.plane.angles + ( 0, 0, 45 ) );
                }
            }
        }

        self notify( "stop_lock_on_warning" );
        level.last_missile_fired_at_player = gettime();
        level.enemy_locking_on_to_player = 0;
        wait 5;
    }
}

missile_miss_player( var_0 )
{
    var_1 = maps\_utility::get_dot( level.player.origin, level.player.angles, self.origin );
    var_2 = level.plane offset_position_from_tag( "forward", "tag_origin", 10000 ) + ( 0, 0, 200 );
    var_3 = self.origin;

    if ( var_1 > 0 )
        var_3 = offset_position_from_tag( "forward", "tag_origin", 1000 );
    else
    {
        var_3 = level.plane offset_position_from_tag( "backward", "tag_origin", 500 );

        if ( level.plane.angles[0] > 0 && level.plane.angles[0] < 180 )
            var_3 += ( 0, 0, 500 );
        else
            var_3 -= ( 0, 0, 500 );

        var_3 += ( randomintrange( -256, 256 ), randomintrange( -256, 256 ), randomintrange( -256, 256 ) );
    }

    var_4 = magicbullet( "sidewinder_atlas_jet", var_3, var_2 );
    var_4 thread monitor_missile_death( 1, self );

    if ( !is_true( var_0 ) && randomint( 100 ) > 25 )
        maps\_utility::delaythread( 0.25, ::missile_miss_player, 1 );
}

enemy_jet_shoot_think()
{
    self endon( "death" );
    var_0 = 225000000;
    var_1 = 36000000;
    var_2 = 100000000;
    var_3 = 0;

    for (;;)
    {
        if ( common_scripts\utility::flag( "target_player" ) )
        {
            var_4 = maps\_utility::get_dot( self.origin, self.angles, level.player.origin );

            if ( var_4 > 0 )
            {
                var_5 = distancesquared( self.origin, level.player.origin );

                if ( var_5 < var_1 || !common_scripts\utility::flag( "target_player" ) )
                    rake_with_bullets( level.plane );
                else
                    lock_on_to_player();
            }
        }

        var_6 = level.friend_jets;

        foreach ( var_8 in var_6 )
        {
            if ( isremovedentity( var_8 ) )
            {
                level.friend_jets = common_scripts\utility::array_remove( level.friend_jets, var_8 );
                wait 0.1;
                break;
            }

            var_9 = gettime();
            var_4 = maps\_utility::get_dot( self.origin, self.angles, var_8.origin );

            if ( var_4 > 0.93 )
            {
                var_5 = distancesquared( self.origin, level.player.origin );

                if ( var_5 < var_2 )
                {
                    rake_with_bullets( var_8 );
                    break;
                }
                else if ( var_9 >= var_3 )
                {
                    thread ai_shoot_missile( var_8 );
                    var_3 = var_9 + 5000;
                    break;
                }
            }

            wait 0.05;
        }

        wait 0.1;
    }
}

ally_jet_shoot_think()
{
    self endon( "death" );
    var_0 = 225000000;
    var_1 = 36000000;
    var_2 = 100000000;
    var_3 = 0;

    if ( !isdefined( level.enemy_units ) )
        level.enemy_units = [];

    for (;;)
    {
        if ( level.ally_ai_active )
        {
            var_4 = 0;
            var_5 = maps\_utility::get_dot( self.origin, self.angles, level.player.origin );

            if ( var_5 > 0 )
                var_4 = 1;

            var_6 = level.enemy_units;

            foreach ( var_8 in var_6 )
            {
                if ( !isdefined( var_8 ) )
                {
                    level.enemy_units = common_scripts\utility::array_remove( level.enemy_units, var_8 );
                    wait 0.1;
                    break;
                }

                var_9 = gettime();
                var_5 = maps\_utility::get_dot( self.origin, self.angles, var_8.origin );

                if ( var_5 > 0.93 )
                {
                    var_10 = distancesquared( self.origin, level.player.origin );

                    if ( var_10 < var_2 )
                    {
                        rake_with_bullets( var_8, 0.3, 0.6 );
                        wait(randomfloatrange( 0.2, 1.0 ));
                        break;
                    }
                }

                wait 0.05;
            }
        }

        wait 0.1;
    }
}

plane_health_monitor()
{
    level endon( "finale" );
    self.almost_dead = 0;
    self.current_hit_count = 0;
    self.invulnerabletime = 0;
    self.lasthit = 0;

    if ( level.gameskill == 3 )
        self.max_hit_count = 1;
    else if ( level.gameskill == 2 )
        self.max_hit_count = 2;
    else
        self.max_hit_count = 2;

    self.max_health = self.health;

    while ( !common_scripts\utility::flag( "final_hit" ) )
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );
        var_4 = tolower( var_4 );
        self.health = self.max_health;

        if ( isdefined( var_1 ) && ( isdefined( var_1.script_team ) && var_1.script_team == "allies" || var_1 == level.player ) )
            continue;

        if ( var_4 == "collision" )
            thread fake_damage_indicator( var_2, undefined, 0 );
        else
            thread fake_damage_indicator( var_2 );

        if ( var_4 == "mod_impact" )
        {
            thread fake_bullet_damage_sounds();
            thread fighter_jet_set_shake( 2, 0.5 );
            continue;
        }

        var_5 = 1;

        if ( var_4 == "flak_hit" )
            var_5 = 0.5;

        if ( var_4 == "flak_pepper" )
        {
            thread fake_bullet_damage_sounds();
            var_5 = 0.05;
        }

        if ( var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" || var_4 == "flak_hit" )
        {
            thread fighter_jet_set_shake( 4, 1.5 );

            if ( self.current_hit_count / self.max_hit_count < 0.5 )
                var_5 = 0.1;
            else
                var_5 = 0;
        }

        var_6 = gettime();

        if ( var_6 <= self.invulnerabletime && var_5 < 1 )
            continue;

        if ( !common_scripts\utility::flag( "playerPlaneNoDeath" ) )
            self.current_hit_count += var_5;
        else if ( self.current_hit_count < self.max_hit_count - 1 )
            self.current_hit_count += var_5;
        else
            self.current_hit_count = self.max_hit_count - 1;

        if ( self.current_hit_count < 0 )
            self.current_hit_count = 0;

        earthquake( 0.5, 1.0, self.origin, 512 );
        level.player playrumbleonentity( "damage_heavy" );
        level.player viewkick( 1, var_3 );
        self.lasthit = var_6;

        if ( self.current_hit_count >= self.max_hit_count )
        {
            if ( !self.almost_dead || var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" || var_4 == "flak_hit" )
            {
                self.current_hit_count = self.max_hit_count - 0.1;
                continue;
            }

            self makeusable();
            self useby( level.player );
            level.player disableinvulnerability();
            level.player kill();
            self kill();
            return;
        }
    }
}

fake_bullet_damage_sounds()
{
    var_0 = randomintrange( 3, 7 );

    for ( var_1 = 1; var_1 <= var_0; var_1++ )
    {
        level.player playsound( "plr_jet_bullet_imp" );
        wait(randomfloatrange( 0.1, 0.22 ));
    }
}

fake_damage_indicator( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.5;

    if ( !isdefined( var_2 ) )
        var_2 = 3;

    if ( !isdefined( var_3 ) )
        var_3 = 0.5;

    if ( !is_true( var_4 ) && is_true( self.showing_damage ) )
        return;

    if ( is_true( var_4 ) )
    {
        self notify( "fake_damage_indicator" );
        self endon( "fake_damage_indicator" );
    }

    self.showing_damage = 1;
    level.player playsound( "plr_jet_missile_imp_snap" );

    if ( isdefined( var_0 ) && var_0 != ( 0, 0, 0 ) )
    {
        var_5 = 0.5;
        var_6 = anglestoforward( self.angles ) + var_0 * var_5;
        var_6 = vectortoangles( var_6 );
        var_6 = self.angles + ( 0, 0, var_6[2] );
        level.plane vehicle_teleport( level.plane.origin, var_6 );
    }

    earthquake( 0.5, 1.0, self.origin, 512 );
    level.player playrumbleonentity( "damage_heavy" );
    level.player viewkick( 1, level.player.origin );
    level.player digitaldistortsetparams( var_3, 1.5 );
    thread chromo_anim2( var_1, 0.5 );
    wait(var_1);
    level.player digitaldistortsetparams( 0, 1 );
    wait(var_2);
    self.showing_damage = 0;
}

chromo_anim2( var_0, var_1 )
{
    level notify( "chromo_anim" );
    level endon( "chromo_anim" );
    setsaveddvar( "r_chromaticAberrationTweaks", 1 );
    var_2 = 1.0;

    if ( var_1 )
        var_2 = var_1;

    setsaveddvar( "r_chromaticAberration", 1 );
    var_3 = var_0 * 20;
    var_4 = 0;
    level.chromo_offset = 20 * var_2;
    var_5 = level.chromo_offset;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_6 = 1.0 / var_3 * var_5;
        level.chromo_offset -= var_6;
        setsaveddvar( "r_chromaticSeparationG", level.chromo_offset * -1 );
        setsaveddvar( "r_chromaticSeparationR", level.chromo_offset );
        wait 0.05;
    }

    level.chromo_offset = 0;
    setsaveddvar( "r_chromaticSeparationG", 0 );
    setsaveddvar( "r_chromaticSeparationR", 0 );
}

plane_health_regen()
{
    level endon( "finale" );

    for (;;)
    {
        wait 0.05;
        waittillframeend;
        var_0 = gettime();

        if ( self.current_hit_count > 0 && var_0 >= self.lasthit + level.player.gs.playerhealth_regularregendelay / 2 )
        {
            self.current_hit_count -= 1;

            if ( self.current_hit_count < 0 )
                self.current_hit_count = 0;

            self notify( "regen" );
        }

        var_1 = clamp( self.current_hit_count / self.max_hit_count, 0.0, 0.5 );
        level.player digitaldistortsetparams( var_1, 1.5 );

        if ( var_1 >= 0.5 && !self.almost_dead )
        {
            self.almost_dead = 1;
            fadeupstatic( 0.25 );
            self.invulnerabletime = var_0 + level.player.gs.invultime_onshield * 5;
        }

        if ( var_1 == 0 && self.almost_dead )
        {
            thread fadedownstatic( 1 );
            level.player digitaldistortsetparams( 0, 1 );
            self.current_hit_count = 0;
            self.almost_dead = 0;
        }
    }

    level.player painvisionoff();
}

fadeupstatic( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0.05;

    if ( !isdefined( level.overlaystatic ) )
    {
        level.overlaystatic = newhudelem( level.player );
        level.overlaystatic.x = 0;
        level.overlaystatic.y = 0;
        level.overlaystatic.alpha = 0;
        level.overlaystatic.horzalign = "fullscreen";
        level.overlaystatic.vertalign = "fullscreen";
        level.overlaystatic.sort = 4;
        level.overlaystatic setshader( "overlay_static_digital", 640, 480 );
        var_2 = var_1 / ( var_0 / 0.05 );

        while ( level.overlaystatic.alpha < var_1 )
        {
            level.overlaystatic.alpha += var_2;
            wait 0.05;
        }

        level.overlaystatic.alpha = var_1;
    }
}

fadedownstatic( var_0 )
{
    if ( isdefined( level.overlaystatic ) )
    {
        var_1 = 0.05 / var_0;

        while ( isdefined( level.overlaystatic ) && level.overlaystatic.alpha > 0 )
        {
            level.overlaystatic.alpha -= var_1;
            wait 0.05;
        }

        level.overlaystatic destroy();
        level.overlaystatic = undefined;
    }
}

init_jet_crash_points()
{
    level.jet_crash_points = getvehiclenodearray( "jet_crash_location", "targetname" );
}

available_crash_paths()
{
    var_0 = [];

    foreach ( var_2 in level.jet_crash_points )
    {
        if ( !isdefined( var_2.claimed ) )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

choose_crash_path()
{
    var_0 = available_crash_paths();
    var_1 = getclosest_in_front( self.origin, var_0 );
    return var_1;
}

getclosest_in_front( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 20000;

    if ( !isdefined( var_3 ) )
        var_3 = 0.94;

    var_4 = undefined;

    foreach ( var_6 in var_1 )
    {
        if ( !isdefined( var_6 ) )
            continue;

        var_7 = distance( var_6.origin, var_0 );

        if ( var_7 >= var_2 )
            continue;

        var_8 = maps\_utility::get_dot( self.origin, self.angles, var_6.origin );

        if ( var_8 < var_3 )
            continue;

        var_2 = var_7;
        var_4 = var_6;
    }

    return var_4;
}

jet_crash_move( var_0, var_1, var_2 )
{
    self endon( "in_air_explosion" );
    var_0.claimed = 1;
    self notify( "newpath" );
    self notify( "deathspin" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 2400;

    var_3 = self.origin[2] + var_2;
    var_4 = gettime();

    for ( var_5 = var_4 + var_1 * 1000; isdefined( self ) && var_4 < var_5 && self.origin[2] < var_3; var_4 = gettime() )
        wait 0.05;

    var_6 = 700;
    self setneargoalnotifydist( var_0.radius );
    thread maps\_vehicle::vehicle_paths( var_0 );
    self startpath( var_0 );
    self vehicle_setspeed( var_6, 50, 50 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    jet_crash_path( var_0 );
    var_0.claimed = undefined;
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
}

jet_crash_path( var_0 )
{
    self endon( "death" );

    while ( isdefined( var_0.target ) )
    {
        var_0 = common_scripts\utility::getstruct( var_0.target, "targetname" );
        var_1 = 512;

        if ( isdefined( var_0.radius ) )
            var_1 = var_0.radius;

        var_2 = self vehicle_getspeed();

        if ( isdefined( var_0.script_parameters ) )
        {
            self vehicle_setspeed( var_0.script_parameters, 50, 60 );
            var_2 = var_0.script_parameters;
        }

        self setneargoalnotifydist( var_1 );
        thread maps\_vehicle::vehicle_paths( var_0 );
        self startpath( var_0 );
        common_scripts\utility::waittill_any( "goal", "near_goal" );
    }
}
