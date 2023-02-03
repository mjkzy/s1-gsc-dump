// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    maps\_utility::set_console_status();
    setup_pdrone_type( var_2 );
    level._effect["pdrone_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["pdrone_emp_death"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["emp_drone_damage"] = loadfx( "vfx/sparks/emp_drone_damage" );
    level._effect["pdrone_smoke_trail"] = loadfx( "vfx/trail/trail_drone_fire_smk_sm_runner_1" );
    level._effect["drone_muzzle_flash"] = loadfx( "vfx/muzzleflash/pdrone_flash_wv" );
    level._effect["drone_fan_distortion"] = loadfx( "vfx/distortion/drone_fan_distortion" );
    level._effect["drone_fan_distortion_large"] = loadfx( "vfx/distortion/drone_fan_distortion_large" );
    level._effect["drone_thruster_distortion"] = loadfx( "vfx/distortion/drone_thruster_distortion" );
    level._effect["drone_beacon_red"] = loadfx( "vfx/lights/light_drone_beacon_red" );
    level._effect["drone_beacon_red_fast"] = loadfx( "vfx/lights/light_drone_beacon_red_fast" );
    level._effect["drone_beacon_blue_fast"] = loadfx( "vfx/lights/light_drone_beacon_blue_fast" );
    level._effect["drone_beacon_red_slow_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_slow_nolight" );
    level._effect["drone_beacon_blue_slow_nolight"] = loadfx( "vfx/lights/light_drone_beacon_blue_slow_nolight" );
    level._effect["drone_beacon_red_sm_nolight"] = loadfx( "vfx/lights/light_drone_beacon_red_sm_nolight" );
    level.scr_animtree["personal_drone"] = #animtree;
    level.scr_model["personal_drone"] = var_0;
    level.scr_anim["personal_drone"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch;
    level.scr_anim["personal_drone"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run;
    level.scr_anim["personal_drone"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run;
    level.scr_anim["personal_drone"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand;
    level.scr_anim["personal_drone"]["personal_drone_folded_idle"][0] = %personal_drone_folded_idle;
    setup_buddy_drone_deploy_anims();
    var_3 = "pdrone";

    if ( isdefined( var_1 ) )
        var_3 = var_1;

    maps\_vehicle::build_template( var_3, var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( %atlas_assault_drone_lage_rotors, undefined, 0 );
    maps\_vehicle::build_deathquake( 0.4, 0.8, 1024 );
    maps\_vehicle::build_life( level.pdrone_parms[var_2]["health"] );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_mainturret();
    var_4 = randomfloatrange( 0, 1 );
    var_5 = var_2;
    maps\_vehicle::build_is_helicopter();
}

#using_animtree("generic_human");

setup_buddy_drone_deploy_anims()
{
    level.scr_anim["generic"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch_guy;
    level.scr_anim["generic"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run_guy;
    level.scr_anim["generic"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run_guy;
    level.scr_anim["generic"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand_guy;
}

setup_pdrone_type( var_0 )
{
    if ( !isdefined( level.pdrone_parms ) )
        level.pdrone_parms = [];

    if ( isdefined( level.pdrone_parms[var_0] ) )
        return;

    level.pdrone_parms[var_0] = [];
    level.pdrone_parms[var_0]["health"] = 110;
    level.pdrone_parms[var_0]["speed"] = 45;
    level.pdrone_parms[var_0]["accel"] = 50;
    level.pdrone_parms[var_0]["decel"] = 50;
    level.pdrone_parms[var_0]["hover_radius"] = 0;
    level.pdrone_parms[var_0]["hover_speed"] = 0;
    level.pdrone_parms[var_0]["hover_accel"] = 0;
    level.pdrone_parms[var_0]["pitchmax"] = 60;
    level.pdrone_parms[var_0]["rollmax"] = 60;
    level.pdrone_parms[var_0]["angle_vel_pitch"] = 90;
    level.pdrone_parms[var_0]["angle_vel_yaw"] = 120;
    level.pdrone_parms[var_0]["angle_vel_roll"] = 90;
    level.pdrone_parms[var_0]["angle_accel"] = 400;
    level.pdrone_parms[var_0]["yaw_speed"] = 180;
    level.pdrone_parms[var_0]["yaw_accel"] = 250;
    level.pdrone_parms[var_0]["yaw_decel"] = 100;
    level.pdrone_parms[var_0]["yaw_over"] = 0.1;
    level.pdrone_parms[var_0]["axial_move"] = 0;
    level.pdrone_parms[var_0]["weap_fire_tags"] = [ "tag_flash" ];
    level.pdrone_parms[var_0]["clear_look"] = 1;
}

drone_parm( var_0 )
{
    return level.pdrone_parms[self.classname][var_0];
}

init_class_motion( var_0, var_1, var_2 )
{
    self sethoverparams( drone_parm( "hover_radius" ), drone_parm( "hover_speed" ), drone_parm( "hover_accel" ) );
    self setmaxpitchroll( drone_parm( "pitchmax" ), drone_parm( "rollmax" ) );
    var_3 = drone_parm( "speed" );
    var_4 = drone_parm( "accel" );
    var_5 = drone_parm( "decel" );

    if ( isdefined( var_0 ) )
        var_3 = var_0;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    if ( isdefined( var_2 ) )
        var_5 = var_2;

    self vehicle_setspeed( var_3, var_4, var_5 );
    self vehicle_helicoptersetmaxangularvelocity( drone_parm( "angle_vel_pitch" ), drone_parm( "angle_vel_yaw" ), drone_parm( "angle_vel_roll" ) );
    self vehicle_helicoptersetmaxangularacceleration( drone_parm( "angle_accel" ) );
    self setneargoalnotifydist( 5 );
    self setyawspeed( drone_parm( "yaw_speed" ), drone_parm( "yaw_accel" ), drone_parm( "yaw_decel" ), drone_parm( "yaw_over" ) );
    self setaxialmove( drone_parm( "axial_move" ) );
}

init_local()
{
    self endon( "death" );
    self.originheightoffset = distance( self gettagorigin( "tag_origin" ), self gettagorigin( "tag_ground" ) );
    self.script_badplace = 0;
    self.dontdisconnectpaths = 1;
    self.vehicle_heli_default_path_speeds = ::init_class_motion;

    if ( tactical_picker_enabled() )
        init_class_motion();

    if ( self.script_team == "allies" )
    {
        thread maps\_vehicle::vehicle_lights_on( "friendly" );
        self.contents = self setcontents( 0 );
    }
    else
    {
        thread maps\_vehicle::vehicle_lights_on( "hostile" );
        self.ignore_death_fx = 1;
        self.script_crashtypeoverride = "pdrone";
    }

    maps\_utility::ent_flag_init( "sentient_controlled" );
    maps\_utility::ent_flag_init( "fire_disabled" );

    if ( tactical_picker_enabled() )
    {
        self.time_before_move = 0;
        self.time_before_attack = 0;
        self.attack_available = 0;
        self.flock_goal_position = ( 0, 0, 0 );
        self.flock_goal_offset = ( 0, 0, 0 );
    }

    self.stun_duration = 0;
    self.playing_hit_reaction = 0;

    if ( should_play_animations() )
        setup_pdrone_animations();

    vehicle_scripts\_pdrone_threat_sensor::build_threat_data();
    waittillframeend;
    self.emp_death_function = ::pdrone_emp_death;
    maps\_utility::add_damage_function( ::pdrone_damage_function );
    thread maps\_damagefeedback::monitordamage();
    self.custom_death_script = ::handle_death;
    var_0 = 0;

    if ( isdefined( self.script_parameters ) && self.script_parameters == "expendable" )
        var_0 = 1;

    if ( self.script_team != "allies" )
    {
        self enableaimassist();
        thread maps\_shg_utility::make_emp_vulnerable();
    }

    if ( isdefined( self.script_parameters ) && self.script_parameters == "diveboat_weapon_target" )
    {
        target_set( self, ( 0, 0, 0 ) );
        target_hidefromplayer( self, level.player );
    }
    else if ( self.classname != "script_vehicle_pdrone_kva" )
    {
        target_set( self, ( 0, 0, 0 ) );
        target_setjavelinonly( self, 1 );
    }

    thread pdrone_ai( var_0 );
    thread pdrone_flying_fx();
    self notify( "stop_kicking_up_dust" );
    thread handle_pdrone_audio();
}

handle_pdrone_audio()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0.preset_name = "pdrone_atlas";
    var_1 = vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;

    if ( issubstr( self.classname, "pdrone_atlas_large" ) )
    {
        var_0.preset_name = "pdrone_atlas";
        var_1 = vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;
    }
    else if ( issubstr( self.classname, "pdrone_atlas" ) )
    {
        var_0.preset_name = "pdrone_atlas";
        var_1 = vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;
    }
    else if ( isdefined( level.script ) && level.script == "greece" )
    {
        var_0.preset_name = "pdrone_swarm";
        var_1 = vehicle_scripts\_pdrone_aud::snd_pdrone_swarm_constructor;
    }

    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}

pdrone_ai( var_0 )
{
    self endon( "death" );
    self makeentitysentient( self.script_team, var_0 );
    self setmaxpitchroll( drone_parm( "pitchmax" ), drone_parm( "rollmax" ) );

    if ( isdefined( self.owner ) )
    {
        thread pdrone_movement_follow_buddy();
        thread attack_if_buddy_killed();
    }

    thread vehicle_scripts\_pdrone_threat_sensor::pdrone_update_threat_sensor();
    thread pdrone_targeting();
}

pdrone_flying_fx()
{
    self endon( "death" );
    var_0 = 0.3;

    if ( self.classname == "script_vehicle_pdrone_atlas" || self.classname == "script_vehicle_pdrone_atlas_lab" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), self, "TAG_FX_FAN_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion" ), self, "TAG_FX_FAN_R" );
    }

    if ( self.classname == "script_vehicle_pdrone_atlas_large" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), self, "TAG_FX_FAN_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_fan_distortion_large" ), self, "TAG_FX_FAN_R" );
    }

    if ( self.classname != "script_vehicle_pdrone_atlas" && self.classname != "script_vehicle_pdrone_atlas_lab" )
    {
        playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), self, "TAG_FX_THRUSTER_L" );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "drone_thruster_distortion" ), self, "TAG_FX_THRUSTER_R" );
    }

    if ( self.script_team == "axis" )
    {
        if ( self.classname == "script_vehicle_pdrone_atlas_lab" )
        {
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red_sm_nolight" ), self, "TAG_FX_BEACON_0" );
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red_sm_nolight" ), self, "TAG_FX_BEACON_1" );
        }
        else
        {
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_0" );
            wait(var_0);
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_1" );
            wait(var_0);
            playfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "TAG_FX_BEACON_2" );
        }
    }
}

attack_if_buddy_killed()
{
    self endon( "death" );
    self.owner waittill( "death", var_0 );

    if ( !isdefined( var_0 ) )
    {
        self delete();
        return;
    }

    thread flying_attack_drone_logic();
}

pdrone_movement_follow_buddy()
{
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );

    if ( self.script_team == "allies" )
    {
        self sethoverparams( 20, 20, 20 );
        self.goalradius = 64;
    }
    else
    {
        self sethoverparams( 0, 0, 0.05 );
        self.goalradius = 8;
    }

    self vehicle_setspeed( 20, 20, 20 );
    self setyawspeedbyname( "faster" );
    thread pdrone_movement_follow();

    for (;;)
    {
        self.owner waittill( "pdrone_defend_point", var_0 );
        thread pdrone_movement_go_to_point( var_0 );
    }
}

pdrone_movement_follow()
{
    self notify( "change_movement_type" );
    self endon( "change_movement_type" );
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );
    var_0 = 0.2;

    if ( isplayer( self.owner ) )
    {
        var_1 = ( 1, 5, 3 );
        var_2 = ( -50, 130, 90 );
    }
    else
    {
        var_1 = ( 1, 64, 10 );
        var_2 = ( -60, 0, 95 );
    }

    wait(randomfloat( var_0 ));
    var_3 = 0;
    var_4 = self.origin;
    var_5 = self.origin;
    var_6 = self.origin;
    var_7 = 0;
    var_8 = ( 0, 0, 0 );
    var_9 = 0;
    var_10 = 0;
    var_11 = self.origin;
    var_12 = 0.05;

    if ( level.currentgen )
        var_12 = 0.25;

    for (;;)
    {
        var_9 += var_12;
        var_7 += var_12;

        if ( var_7 > 2 )
        {
            var_7 = 0;
            var_8 = ( randomfloatrange( -0.5, 0.5 ) * var_1[0], randomfloatrange( -0.5, 0.5 ) * var_1[1], randomfloatrange( -0.5, 0.5 ) * var_1[2] );
        }

        var_6 = transformmove( self.owner.origin, self.owner.angles, ( 0, 0, 0 ), ( 0, var_3, 0 ), var_2 + var_8, ( 0, 0, 0 ) )["origin"];

        if ( distance( var_6, var_5 ) > 16 )
        {
            if ( var_9 > var_0 )
            {
                if ( var_10 > 0.5 && common_scripts\utility::cointoss() )
                {
                    var_13 = 1;
                    var_14 = vectornormalize( self.owner.origin - self.origin );
                    var_15 = vectorcross( var_14, ( 0, 0, 1 ) );
                    var_16 = self.origin + var_15 * ( randomfloatrange( -1, 1 ) * 256 );
                }
                else
                {
                    var_13 = 0;
                    var_16 = var_6;
                }

                if ( pdrone_can_move_to_point( self.origin, var_16 ) && pdrone_can_see_owner_from_point( var_16 ) )
                {
                    var_10 = 0;
                    var_5 = var_16;
                    var_4 = var_16;
                }
                else
                {
                    var_10 += var_9;
                    var_17 = randomfloat( 1 ) + randomfloat( 1 ) - 1;
                    var_3 = angleclamp( angleclamp180( var_3 ) * 0.5 + var_17 * 250 );
                }

                var_9 = 0;
            }
        }
        else
        {
            var_4 = var_6;
            var_10 = 0;
        }

        if ( var_10 > 3 )
        {
            if ( !level.player maps\_utility::point_in_fov( var_6 ) && !level.player maps\_utility::point_in_fov( self.origin ) && pdrone_can_see_owner_from_point( var_6 ) && pdrone_can_teleport_to_point( var_6 ) )
            {
                self vehicle_teleport( var_6, self.angles );
                var_4 = var_6;
                var_5 = var_6;
            }
        }

        self setvehgoalpos( var_4, 1 );
        wait(var_12);
    }
}

pdrone_can_move_to_point( var_0, var_1 )
{
    var_1 += vectornormalize( var_1 - var_0 ) * 32;
    var_0 += ( 0, 0, -24 );
    var_1 += ( 0, 0, -24 );
    var_2 = playerphysicstrace( var_0, var_1 );
    var_3 = distancesquared( var_2, var_1 ) < 0.01;
    return var_3;
}

pdrone_can_teleport_to_point( var_0 )
{
    var_1 = var_0 + ( 0, 0, 12 );
    var_2 = playerphysicstrace( var_1, var_0 );
    var_3 = distancesquared( var_2, var_0 ) < 0.01;
    return var_3;
}

pdrone_can_see_owner_from_point( var_0 )
{
    var_1 = self.owner geteye();
    var_2 = sighttracepassed( var_0, var_1, 0, self );
    return var_2;
}

pdrone_movement_go_to_point( var_0 )
{
    self notify( "change_movement_type" );
    self endon( "change_movement_type" );
    self.owner endon( "pdrone_returning" );
    self.owner endon( "death" );
    self endon( "death" );
    var_1 = 110;
    var_2 = var_0["position"] + var_1 * var_0["normal"];
    self setvehgoalpos( var_2, 1 );
    self.owner common_scripts\utility::waittill_any_timeout( 10, "stop_pdrone_pov" );
    thread pdrone_movement_follow();
}

pdrone_targeting( var_0 )
{
    self notify( "pdrone_targeting" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self endon( "death" );
    self endon( "emp_death" );
    var_1 = "axis";

    if ( self.script_team == "axis" )
    {
        var_1 = "allies";

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_3 in self.mgturret )
                var_3.script_team = "axis";
        }
    }

    for (;;)
    {
        wait 0.05;

        if ( isdefined( self.drone_threat_data.threat ) )
        {
            self setlookatent( self.drone_threat_data.threat );
            thread pdrone_fire_at_enemy( self.drone_threat_data.threat, var_0 );
            self.drone_threat_data.threat common_scripts\utility::waittill_any_timeout( 5, "death", "target_lost" );
            continue;
        }

        if ( drone_parm( "clear_look" ) )
            self clearlookatent();

        if ( isdefined( self.owner ) )
            self settargetyaw( self.owner.angles[1] );
    }
}

calculate_lateral_move_accuracy( var_0 )
{
    var_1 = ( var_0.origin - self.origin ) * ( 1, 1, 0 );
    var_1 = vectornormalize( var_1 );
    var_1 = ( var_1[1], var_1[0] * -1, 0 );
    var_2 = abs( vectordot( var_1, var_0 getvelocity() ) );
    var_2 = clamp( var_2, 0, 250 ) / 250;
    var_2 = 1 - var_2;
    var_2 = clamp( var_2, 0.5, 1 );
    return var_2;
}

calculate_stance_accuracy( var_0 )
{
    if ( var_0 getstance() == "crouch" )
        return 0.75;
    else if ( var_0 getstance() == "prone" )
        return 0.5;

    return 1;
}

calculate_player_wounded_accuracy( var_0 )
{
    if ( level.player maps\_utility::ent_flag( "player_has_red_flashing_overlay" ) )
        return 0.5;

    return 1;
}

calculate_aim_offset( var_0, var_1, var_2 )
{
    var_3 = self.origin - var_0.origin;
    var_3 *= ( 1, 1, 0 );
    var_3 = vectornormalize( var_3 );

    if ( isplayer( var_0 ) )
    {
        var_1 *= calculate_lateral_move_accuracy( var_0 );
        var_1 *= calculate_stance_accuracy( var_0 );
        var_1 *= calculate_player_wounded_accuracy( var_0 );
    }

    var_4 = vectorcross( var_3, ( 0, 0, 1 ) );
    var_4 = vectornormalize( var_4 );
    var_5 = var_4 * 8 / var_1 * randomfloatrange( -1, 1 );
    var_6 = ( 0, 0, 8 ) / var_1 * randomfloatrange( -1, 1 );

    if ( isdefined( var_2 ) && var_2 )
    {

    }

    return var_5 + var_6;
}

fire_burst( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "death" );
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_targeting" );

    while ( var_0 > 0 )
    {
        var_5 = 1;

        if ( isplayer( var_1 ) )
        {
            var_6 = min( self.drone_threat_data.threat_visible_time, 15 ) / 15;
            var_5 = maps\_utility::linear_interpolate( var_6, 0.15, 0.8 );
        }

        if ( isdefined( self.attack_accuracy ) )
            var_5 *= self.attack_accuracy;

        var_7 = calculate_aim_offset( var_1, var_5, 0 );
        self.current_aim_offset = var_7;
        var_8 = var_2 + var_7;
        var_9 = self.origin;

        if ( self gettagindex( var_3 ) != -1 )
            var_9 = self gettagorigin( var_3 );

        var_10 = var_1.origin + var_8 - var_9;
        var_10 = vectornormalize( var_10 );

        if ( pdrone_could_be_friendly_fire( var_9, var_9 + var_10 * 10000 ) )
        {
            var_1 notify( "target_lost" );
            return;
        }

        pdrone_fire_weapon( var_9, var_1.origin + var_8 );
        var_0 -= var_4;
        wait(var_4);
    }
}

pdrone_fire_at_enemy( var_0, var_1 )
{
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self notify( "new_target" );
    self endon( "new_target" );
    var_2 = var_0 geteye() - var_0.origin;
    var_3 = ( 0, 0, var_2[2] );
    var_4 = 0.095;

    if ( !isdefined( var_1 ) )
        var_1 = 0.25;

    var_5 = var_1 * 0.8;
    var_6 = var_1 * 1.2;

    if ( level.currentgen )
    {
        var_4 = 0.2499;
        var_5 *= 2.5;
        var_6 *= 2.5;
    }

    var_7 = calculate_aim_offset( var_0, 1, 0 );
    var_8 = var_3 + var_7;

    for (;;)
    {
        self setturrettargetent( var_0, var_8 );
        var_9 = self.origin;
        var_10 = drone_parm( "weap_fire_tags" );
        var_11 = var_10[0];

        if ( self gettagindex( var_11 ) != -1 )
            var_9 = self gettagorigin( var_11 );

        if ( self.playing_hit_reaction || self.stun_duration > 0 || pdrone_could_be_friendly_fire( var_9, var_0.origin + var_8 ) || !isdefined( self.drone_threat_data.threat ) || self.drone_threat_data.threat != var_0 )
        {
            var_0 notify( "target_lost" );
            return;
        }

        if ( tactical_picker_enabled() )
        {
            if ( isdefined( self.attack_available ) && !self.attack_available )
            {
                wait 0.05;
                continue;
            }

            if ( length( self vehicle_getvelocity() ) > 1 )
            {
                wait 0.05;
                continue;
            }

            if ( isdefined( self.attack_sight_required ) && self.attack_sight_required && !sighttracepassed( var_9, var_0 geteye(), 0, self, var_0 ) )
            {
                self.attack_available = 0;
                wait 0.05;
                continue;
            }
        }

        var_12 = randomfloatrange( 2, 3 );

        while ( var_12 > 0 )
        {
            if ( self.playing_hit_reaction || self.stun_duration > 0 )
                break;

            var_13 = randomfloatrange( var_5, var_6 );
            var_13 = min( var_13, var_12 );
            fire_burst( var_13, var_0, var_3, var_11, var_4 );
            var_12 -= var_13;

            if ( tactical_picker_enabled() )
            {
                self.attack_available = 0;
                wait 0.05;
                break;
            }

            var_14 = randomfloatrange( 0.5, 1 );
            var_14 = min( var_14, var_12 );

            if ( var_14 > 0 )
            {
                var_12 -= var_14;
                wait(var_14);
            }
        }
    }
}

pdrone_fire_weapon( var_0, var_1 )
{
    self notify( "weapon_fired" );
    playfxontag( level._effect["drone_muzzle_flash"], self, "tag_flash" );
    magicbullet( "pdrone_turret", var_0, var_1 );
}

anglessubtract( var_0, var_1 )
{
    return ( angleclamp180( var_0[0] - var_1[0] ), angleclamp180( var_0[1] - var_1[1] ), angleclamp180( var_0[2] - var_1[2] ) );
}

pdrone_could_be_friendly_fire( var_0, var_1 )
{
    if ( self.script_team == "axis" )
        return 0;
    else
        return maps\_utility::shot_endangers_any_player( var_0, var_1 );
}

pdrone_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.script_team ) && self.script_team == var_1.script_team )
        return;

    if ( isdefined( var_1 ) && isdefined( var_1.classname ) && var_1.classname == "worldspawn" )
    {
        self.health = int( min( self.maxhealth, self.health + var_0 ) );
        return;
    }

    self.last_damage_attacker = var_1;
    self.last_damage_direction_vec = var_2;
    self.last_damage_point = var_3;

    if ( var_4 == "MOD_ENERGY" )
        self dodamage( var_0 * 4, var_1.origin, var_1 );
    else if ( isalive( self ) && isdefined( var_1 ) && !isplayer( var_1 ) )
        self.health = int( min( self.maxhealth, self.health + var_0 * 0.7 ) );

    if ( should_play_animations() )
        play_hit_reaction();
}

play_death_explosion_fx()
{
    if ( self.classname == "script_vehicle_pdrone_atlas_large" )
    {
        playfx( common_scripts\utility::getfx( "pdrone_large_death_explosion" ), self gettagorigin( "tag_origin" ) );
        soundscripts\_snd::snd_message( "pdrone_death_explode" );
    }
    else
    {
        playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), self gettagorigin( "tag_origin" ) );
        soundscripts\_snd::snd_message( "pdrone_death_explode" );
    }
}

handle_death()
{
    if ( !isdefined( self ) )
        return;

    self.crashing = 1;

    if ( self.script_team != "allies" && !isdefined( self.owner ) && isdefined( self.last_damage_attacker ) && randomfloat( 1 ) < 0.4 )
    {
        var_0 = randomintrange( 0, 3 );

        switch ( var_0 )
        {
            case 0:
                death_crash_nearby_player( self.last_damage_attacker );
                break;
            case 1:
                thread death_spiral( self.last_damage_attacker );
                break;
            case 2:
                thread death_rocket_out_of_control( self.last_damage_attacker );
                break;
        }
    }
    else
        play_death_explosion_fx();

    if ( isdefined( self ) )
    {
        self notify( "crash_done" );
        self delete();
    }
}

pdrone_emp_death()
{
    self endon( "death" );
    self endon( "in_air_explosion" );
    self notify( "emp_death" );
    self.vehicle_stays_alive = 1;
    var_0 = self vehicle_getvelocity();
    var_1 = 60;

    if ( isdefined( level.get_pdrone_crash_location_override ) )
        var_2 = [[ level.get_pdrone_crash_location_override ]]();
    else
    {
        var_3 = ( self.origin[0] + var_0[0] * 10, self.origin[1] + var_0[1] * 10, self.origin[2] - 2000 );
        var_2 = physicstrace( self.origin, var_3 );
    }

    self notify( "newpath" );
    self notify( "deathspin" );
    thread drone_deathspin();
    var_4 = 60;
    self vehicle_setspeed( var_4, 60, 1000 );
    self setneargoalnotifydist( var_1 );
    self setvehgoalpos( var_2, 0 );
    thread drone_emp_crash_movement( var_2, var_1, var_4 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
    play_death_explosion_fx();
    self delete();
}

#using_animtree("script_model");

drone_deathspin()
{
    level.scr_animtree["pdrone_dummy"] = #animtree;
    level.scr_anim["pdrone_dummy"]["roll_left"][0] = %rotate_x_l;
    level.scr_anim["pdrone_dummy"]["roll_right"][0] = %rotate_x_r;
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 linkto( self );

    if ( isdefined( self.death_model_override ) )
        var_0 setmodel( self.death_model_override );
    else
        var_0 setmodel( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_0, "TAG_ORIGIN" );
    var_0.animname = "pdrone_dummy";
    var_0 maps\_utility::assign_animtree();

    if ( common_scripts\utility::cointoss() )
        var_1 = "roll_left";
    else
        var_1 = "roll_right";

    var_0 thread maps\_anim::anim_loop_solo( var_0, var_1 );
    self waittill( "death" );
    var_0 delete();
}

drone_emp_crash_movement( var_0, var_1, var_2 )
{
    self endon( "crash_done" );
    self clearlookatent();
    self setmaxpitchroll( 180, 180 );
    self setyawspeed( 400, 100, 100 );
    self setturningability( 1 );
    var_3 = 1400;
    var_4 = 800;
    var_5 = undefined;
    var_6 = 90 * randomintrange( -2, 3 );

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        if ( self.origin[2] < var_0[2] + var_1 )
            self notify( "near_goal" );

        if ( common_scripts\utility::cointoss() )
        {
            var_5 = self.angles[1] - 300;
            self setyawspeed( var_3, var_4 );
            self settargetyaw( var_5 );
            self settargetyaw( var_5 );
        }

        wait 0.05;
    }
}

death_spiral( var_0 )
{
    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;

    if ( isdefined( self.death_model_override ) )
        var_1 setmodel( self.death_model_override );
    else
        var_1 setmodel( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_1, "TAG_ORIGIN" );
    soundscripts\_snd::snd_message( "pdrone_emp_death", var_1 );
    var_2 = ( self.origin[0], self.origin[1], self.origin[2] - 500 );
    var_3 = physicstrace( self.origin, var_2 );
    var_4 = 0;
    var_5 = 5;
    var_6 = var_0.origin - var_1.origin;
    var_6 = vectornormalize( var_6 );
    var_7 = vectorcross( ( 0, 0, 1 ), var_6 );
    var_7 = vectornormalize( var_7 );
    var_8 = 100;
    var_9 = var_1.origin + var_7 * var_8;
    var_10 = vectortoangles( var_1.origin - var_9 );
    var_11 = 1;

    if ( common_scripts\utility::cointoss() )
        var_11 = -1;

    while ( var_4 < 5 )
    {
        wait 0.05;
        var_4 += 0.05;
        var_10 += ( 0, 10, 0 ) * var_11;
        var_12 = maps\_utility::linear_interpolate( clamp( var_4 / 3, 0, 1 ), 2, 30 );
        var_9 -= ( 0, 0, var_12 );
        var_13 = var_9 + anglestoforward( var_10 ) * var_8;
        var_14 = physicstrace( var_1.origin, var_13, var_1 );
        var_1.origin = var_13;
        var_1.angles += ( 0, 50, 0 ) * var_11;
        var_15 = length( var_3 - var_1.origin );

        if ( var_15 < 60 || var_1.origin[2] < var_3[2] + 15 || var_14 != var_13 )
            break;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_1.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_1.origin );
    var_1 delete();
}

death_crash_nearby_player( var_0 )
{
    self.vehicle_stays_alive = 1;
    var_1 = var_0.origin - self.origin;
    var_1 = vectornormalize( var_1 );
    var_2 = vectorcross( ( 0, 0, 1 ), var_1 );
    var_2 = vectornormalize( var_2 );

    if ( common_scripts\utility::cointoss() )
        var_2 *= -1;

    var_3 = var_0.origin - var_1 * ( 1, 1, 0 ) * 250 + var_2 * 250;
    var_3 = ( var_3[0], var_3[1], self.origin[2] );
    var_4 = common_scripts\utility::randomvectorincone( vectornormalize( var_3 - self.origin ), 15 );
    var_5 = self.origin + var_4 * 250;
    var_3 = physicstrace( self.origin, var_5 );
    self notify( "newpath" );
    self notify( "deathspin" );
    self setneargoalnotifydist( 60 );
    self vehicle_helisetai( var_3, drone_parm( "speed" ) * 0.75, drone_parm( "accel" ), drone_parm( "decel" ), undefined, undefined, 0, 0, 0, 0, 0, 0, 0 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    death_plummet();
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
}

death_plummet()
{
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 setmodel( self.model );
    self hide();

    if ( !issubstr( self.classname, "_security" ) )
        stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );

    var_1 = 0;
    var_2 = self vehicle_getvelocity();
    var_3 = squared( 0.05 );

    for ( var_4 = ( 0, 0, -980 ); var_1 < 5; var_1 += 0.05 )
    {
        wait 0.05;
        var_2 = var_4 * 0.05 + var_2;
        var_2 = vectorclamp( var_2, 1000 );
        var_5 = var_2 * 0.05 + var_4 * var_3 / 2;
        var_6 = var_0.origin + var_5;
        var_7 = physicstrace( var_0.origin, var_6, var_0 );

        if ( var_7 != var_6 )
            break;

        var_0.origin = var_6;
        var_0.angles += ( 0, 5, 0 );
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_0.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_0.origin );
    var_0 delete();
}

death_rocket_out_of_control( var_0 )
{
    var_1 = self.origin;
    self hide();
    var_2 = 0;
    var_3 = 1;
    var_4 = 0;
    var_5 = 0;
    var_6 = level.player geteye() - var_1;
    var_7 = self.origin;
    var_8 = level.player.origin - self.origin;
    var_8 = vectornormalize( var_8 );
    var_9 = var_8 * ( 1, 1, 0 );
    var_10 = vectorcross( ( 0, 0, 1 ), var_8 );
    var_10 = vectornormalize( var_10 );
    var_11 = -5;

    if ( common_scripts\utility::cointoss() )
    {
        var_10 *= -1;
        var_11 = 5;
    }

    var_12 = var_10;
    var_13 = var_7 + var_12 * 600 + ( 0, 0, 250 );
    var_14 = var_7 + var_12 * 300 + ( 0, 0, 500 );
    var_15 = common_scripts\utility::spawn_tag_origin();
    var_15.origin = var_7;
    var_15.parentorigin = var_7;
    var_15.droneviewmodel = spawn( "script_model", var_7 );
    var_15.droneviewmodel.angles = self.angles;
    var_15.droneviewmodel setmodel( self.model );
    var_15.velocity = ( 0, 0, 0 );
    playfxontag( common_scripts\utility::getfx( "pdrone_smoke_trail" ), var_15.droneviewmodel, "TAG_ORIGIN" );
    thread rocketpositionupdate( var_1, level.player, var_15, var_2, var_4, var_5 );
    var_16 = 0;
    var_17 = 1 / var_3 * 20;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;

    while ( var_18 <= 1 )
    {
        wait 0.05;
        var_21 = squared( 1 - var_16 ) * var_7 + 2 * var_16 * ( 1 - var_16 ) * var_14 + squared( var_16 ) * var_13;
        var_22 = var_15.parentorigin;
        var_15.parentorigin = var_21;
        var_15.velocity = var_15.parentorigin - var_22;
        var_23 = physicstrace( var_22, var_15.parentorigin, var_15.droneviewmodel );

        if ( var_23 != var_15.parentorigin )
        {
            var_20 = 1;
            break;
        }

        var_24 = anglestoaxis( var_15.droneviewmodel.angles );
        var_25 = var_24["forward"];
        var_26 = var_24["up"];
        var_27 = var_24["right"];
        var_25 = rotatepointaroundvector( var_9, var_25, var_11 );
        var_26 = rotatepointaroundvector( var_9, var_26, var_11 );
        var_27 = rotatepointaroundvector( var_9, var_27, var_11 );
        var_15.droneviewmodel.angles = axistoangles( var_25, var_27, var_26 );
        var_18 += var_17;
        var_16 = squared( var_18 );

        if ( var_19 )
            break;

        if ( var_18 > 1 )
        {
            var_18 = 1;
            var_19 = 1;
        }
    }

    var_15 notify( "RocketPositionUpdate" );
    var_28 = 0;
    var_29 = var_15.velocity * 20;
    var_30 = squared( 0.05 );

    for ( var_31 = ( 0, 0, -980 ); var_28 < 5 && !var_20; var_28 += 0.05 )
    {
        wait 0.05;
        var_29 = var_31 * 0.05 + var_29;
        var_29 = vectorclamp( var_29, 1000 );
        var_32 = var_29 * 0.05 + var_31 * var_30 / 2;
        var_33 = var_15.droneviewmodel.origin + var_32;
        var_23 = physicstrace( var_15.droneviewmodel.origin, var_33, var_15.droneviewmodel );

        if ( var_23 != var_33 )
            break;

        var_15.droneviewmodel.origin = var_33;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_15.droneviewmodel.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_15.droneviewmodel.origin );
    var_15.droneviewmodel delete();
    var_15 delete();
}

rocketpositionupdate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_2 endon( "RocketPositionUpdate" );
    var_6 = vectortoangles( var_1.origin - var_0 );
    var_7 = var_3;
    var_8 = ( 0, 0, 0 );

    if ( common_scripts\utility::cointoss() )
        var_4 *= -1;

    var_9 = var_5 / 5;
    var_10 = 0;

    for (;;)
    {
        wait 0.05;
        var_7 += var_4;

        if ( isdefined( var_2.tangent ) )
            var_6 = vectortoangles( var_2.tangent );

        var_8 = ( 0, 0, 1 ) * var_10;
        var_11 = transformmove( var_2.parentorigin, var_6, ( 0, 0, 0 ), ( 0, 0, var_7 ), var_8, ( 0, 0, 0 ) );
        var_8 = var_11["origin"];
        var_2.origin = vectorlerp( var_2.origin, var_8, 0.5 );
        var_2.droneviewmodel.origin = var_2.origin;
        var_10 += var_9;
        var_10 = clamp( var_10, 0, var_5 );
    }
}

pdrone_ai_deploy( var_0 )
{
    var_1 = var_0 maps\_utility::spawn_ai( 1 );
    var_1.animname = "generic";
    var_2 = common_scripts\utility::getstruct( var_0.target, "targetname" );
    var_3 = spawn( "script_origin", var_2.origin );
    var_3.angles = var_2.angles;
    var_4 = getent( var_2.target, "targetname" );
    var_5 = 0;
    var_6 = undefined;

    switch ( var_2.animation )
    {
        case "drone_deploy_crouch_to_crouch_guy":
            var_6 = "Cover Crouch";
            break;
        case "drone_deploy_crouch_to_run_guy":
            var_5 = 1;
            var_6 = "Cover Crouch";
            break;
        case "drone_deploy_run_to_run_guy":
            var_5 = 1;
            break;
        case "drone_deploy_run_to_stand_guy":
            break;
        default:
            break;
    }

    var_7 = getsubstr( var_2.animation, 0, var_2.animation.size - 4 );
    var_8 = spawn( "script_model", var_1 gettagorigin( "J_Spine4" ) );
    var_8 setmodel( var_4.model );
    var_9 = var_1 gettagangles( "J_Spine4" );
    var_8.angles = var_9;
    var_8 linkto( var_1, "J_Spine4", ( -3.746, -9.852, -0.08 ), ( 0, 0, 90 ) );
    var_8.animname = "personal_drone";
    var_8 useanimtree( level.scr_animtree["personal_drone"] );
    var_8 setanim( level.scr_anim["personal_drone"]["personal_drone_folded_idle"][0], 1, 0 );
    var_1.ignoreall = 1;

    if ( isdefined( var_6 ) )
        var_3 maps\_anim::anim_reach_and_approach_solo( var_1, var_7, undefined, var_6 );
    else
        var_3 maps\_anim::anim_generic_reach( var_1, var_7 );

    var_3 maps\_anim::anim_generic_reach( var_1, var_7 );

    if ( isdefined( var_5 ) && var_5 )
        var_3 thread maps\_anim::anim_generic_run( var_1, var_7 );
    else
        var_3 thread maps\_anim::anim_generic( var_1, var_7 );

    var_4.origin = var_8.origin;
    var_4.angles = var_8.angles;
    var_10 = var_4 maps\_utility::spawn_vehicle();

    if ( isdefined( var_10.target ) )
        var_11 = 0;
    else
    {
        var_11 = 1;
        var_10.owner = var_1;
    }

    var_10.pacifist = 1;
    var_8 delete();
    var_10.animname = "personal_drone";
    var_3 maps\_anim::anim_single_solo( var_10, var_7 );
    var_10.pacifist = undefined;
    var_1.ignoreall = 0;

    if ( !var_11 )
        var_10 maps\_vehicle::gopath();

    return var_1;
}

destroy_drones_when_nuked()
{
    self endon( "death" );

    for (;;)
    {
        if ( getdvar( "debug_nuke" ) == "on" )
            self dodamage( self.health + 99999, ( 0, 0, -500 ), level.player );

        wait 0.05;
    }
}

flying_attack_drone_system_init()
{
    level.player_test_points = common_scripts\utility::getstructarray( "player_test_point", "targetname" );
    level.drone_air_spaces = getentarray( "drone_air_space", "script_noteworthy" );

    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];
}

start_flying_attack_drones( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "flying_attack_drone";

    var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( var_0 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) )
        {
            var_3.my_debug_name = var_0;
            var_3 thread flying_attack_drone_logic();
        }
    }

    return var_1;
}

start_flying_attack_drone( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "flying_attack_drone";

    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( var_0 );

    if ( isdefined( var_1 ) )
    {
        var_1.my_debug_name = var_0;
        var_1 thread flying_attack_drone_logic();
    }

    return var_1;
}

init_drone_motion_old()
{
    if ( tactical_picker_enabled() )
        return;

    var_0 = undefined;

    if ( !isdefined( self.script_airspeed ) )
        var_0 = 40;
    else
        var_0 = self.script_airspeed;

    self setneargoalnotifydist( 30 );
    self vehicle_setspeed( var_0, var_0 / 4, var_0 / 4 );
}

flying_attack_drone_logic( var_0 )
{
    self notify( "pdrone_flying_attack_drone_logic" );
    self endon( "pdrone_flying_attack_drone_logic" );
    self endon( "death" );
    var_0 = self;
    var_0 childthread flying_attack_drone_damage_monitor();
    var_0 childthread flying_attack_drone_stun_monitor();
    var_0 thread flying_attack_drone_death_monitor();
    var_0 init_drone_motion_old();

    if ( isdefined( var_0.target ) )
        var_0 waittill( "reached_dynamic_path_end" );

    if ( tactical_picker_enabled() )
        var_0 childthread update_drone_tactical_movement();
    else
        var_0 childthread flying_attack_drone_move_think_old();

    if ( should_play_animations() )
        var_0 childthread idle_anim_update();
}

stop_scripted_move_and_attack()
{
    self.target = undefined;
    maps\_utility::vehicle_detachfrompath();
    thread flying_attack_drone_logic();
}

tactical_picker_enabled()
{
    return isdefined( level.drone_tactical_picker_data ) && isdefined( level.drone_tactical_picker_data.enabled );
}

get_target_air_space( var_0 )
{
    if ( tactical_picker_enabled() )
        return level.drone_tactical_picker_data.target_air_space;

    var_1 = common_scripts\utility::getclosest( var_0.origin, level.player_test_points );
    return getent( var_1.target, "targetname" );
}

flying_attack_drone_move_think_old()
{
    self endon( "death" );
    self endon( "pdrone_flying_attack_drone_logic" );

    if ( !isdefined( level.drone_air_spaces ) )
        return;

    self.current_air_space = common_scripts\utility::getclosest( self.origin, level.drone_air_spaces );
    update_flying_attack_drone_goal_pos();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = maps\_utility::get_closest_player_healthy( self.origin );
        self setlookatent( var_0 );
        var_1 = get_target_air_space( var_0 );

        if ( var_1 != self.current_air_space )
        {
            var_2 = get_next_air_space( self.current_air_space, var_1, level.drone_air_spaces );

            if ( isdefined( var_2 ) )
                self.current_air_space = var_2;
        }

        update_flying_attack_drone_goal_pos();
        self waittill( "near_goal" );

        if ( var_1 == self.current_air_space )
        {
            wait_in_current_air_space();
            wait_for_hit_reaction();
        }
    }
}

update_drone_tactical_movement()
{
    self endon( "death" );

    if ( !isdefined( level.drone_air_spaces ) )
        return;

    self.current_air_space = common_scripts\utility::getclosest( self.origin, level.drone_air_spaces );
    update_flying_attack_drone_goal_pos();
    self waittill( "near_goal" );
    wait 0.05;

    for (;;)
    {
        var_0 = maps\_utility::get_closest_player_healthy( self.origin );
        self setlookatent( var_0 );
        var_1 = level.drone_tactical_picker_data.target_air_space;

        if ( var_1 != self.current_air_space )
        {
            if ( randomfloat( 1 ) > 0.5 )
                wait(randomfloat( 1 ));

            var_2 = get_next_air_space( self.current_air_space, var_1, level.drone_air_spaces );

            if ( isdefined( var_2 ) )
                self.current_air_space = var_2;
        }

        if ( tactical_move_to_goal_pos() )
            self waittill( "near_goal" );

        if ( var_1 == self.current_air_space )
        {
            wait 0.05;
            wait_for_hit_reaction();
        }
    }
}

wait_in_current_air_space()
{
    level endon( "pdrone_wait_in_current_air_space" );

    if ( !tactical_picker_enabled() )
    {
        wait(randomfloatrange( 0.5, 1.5 ));
        return;
    }

    var_0 = 0;

    if ( tactical_picker_enabled() )
    {
        if ( randomfloat( 1 ) < 0.25 )
            var_0 = randomfloatrange( 1, 2.5 );
        else
            var_0 = randomfloatrange( 0, 1 );
    }

    var_1 = 0;

    while ( var_1 < var_0 )
    {
        wait 0.05;
        var_1 += 0.05;

        if ( self.current_air_space != level.drone_tactical_picker_data.target_air_space )
            break;
    }
}

wait_for_hit_reaction()
{
    self endon( "death" );

    while ( self.playing_hit_reaction || self.stun_duration > 0 )
    {
        wait 0.05;
        self.stun_duration -= 0.05;
    }
}

calc_flock_goal_pos()
{
    var_0 = self.origin;

    if ( !ispointinvolume( var_0, self.current_air_space ) )
        var_0 = get_random_point_in_air_space( self.current_air_space );
    else
    {
        var_1 = 0;
        var_2 = 0;
        var_3 = ( 0, 0, 0 );
        var_4 = 0;
        var_5 = ( 0, 0, 0 );

        foreach ( var_7 in level.flying_attack_drones )
        {
            if ( self != var_7 && isdefined( self.current_air_space ) && isdefined( var_7.current_air_space ) )
            {
                if ( self.current_air_space == var_7.current_air_space )
                {
                    var_1++;
                    var_8 = var_7.origin - self.origin;
                    var_9 = length( var_8 );

                    if ( var_9 < 90 )
                    {
                        var_2++;
                        var_3 -= 0.5 * ( 90 - var_9 ) * var_8 / var_9;
                    }
                    else if ( var_9 > 150 )
                    {
                        var_4++;
                        var_5 += 0.5 * ( var_9 - 150 ) * var_8 / var_9;
                    }
                }
            }
        }

        if ( var_1 > 0 )
        {
            if ( randomint( 5 ) == 0 )
                var_0 = get_random_point_in_air_space( self.current_air_space );
            else
            {
                if ( var_2 > 0 )
                    var_0 += var_3 / var_2;

                if ( var_4 > 0 )
                    var_0 += var_5 / var_4;
            }
        }
        else
            var_0 = get_random_point_in_air_space( self.current_air_space );
    }

    return var_0;
}

get_tactical_goal_pos()
{
    if ( self.current_air_space != level.drone_tactical_picker_data.target_air_space || !isdefined( self.current_goal_position ) || !isdefined( self.current_goal_offset ) )
        return get_random_point_in_air_space( self.current_air_space );

    if ( isdefined( self.dodge_position ) )
        return self.dodge_position;

    var_0 = self.current_goal_position + self.current_goal_offset;

    if ( length( var_0 - self.origin ) < 10 )
        return undefined;

    return var_0;
}

calculate_move_to_goal_yaw( var_0 )
{
    if ( isdefined( self.drone_look_at_entity ) )
        return vectortoyaw( self.drone_look_at_entity.origin - var_0 );

    if ( !isdefined( self.drone_threat_data ) || !isdefined( self.drone_threat_data.threat ) )
    {
        var_1 = var_0 - self.origin;

        if ( var_1 != ( 0, 0, 0 ) )
            return vectortoyaw( var_1 );

        return self.angles[1];
    }

    return undefined;
}

tactical_move_to_goal_pos()
{
    var_0 = get_tactical_goal_pos();

    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = calculate_move_to_goal_yaw( var_0 );
    var_2 = undefined;

    if ( isdefined( var_1 ) )
        var_2 = 1;
    else
        var_1 = self.angles[1];

    self vehicle_helisetai( var_0, drone_parm( "speed" ), drone_parm( "accel" ), drone_parm( "decel" ), undefined, var_2, var_1, 0, 0, 0, 0, 0, 1 );
    return 1;
}

update_flying_attack_drone_goal_pos()
{
    if ( tactical_picker_enabled() )
        tactical_move_to_goal_pos();
    else
        self setvehgoalpos( calc_flock_goal_pos(), 1 );
}

get_random_point_in_air_space( var_0 )
{
    for ( var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ); !ispointinvolume( var_1, var_0 ); var_1 = var_0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) )
    {

    }

    return var_1;
}

flying_attack_drone_damage_monitor()
{
    self endon( "death" );
    self.damagetaken = 0;
    self.istakingdamage = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread flying_attack_drone_damage_update();
    }
}

flying_attack_drone_damage_update()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self.istakingdamage = 1;
    wait 1;
    self.istakingdamage = 0;
}

flying_attack_drone_death_monitor()
{
    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];

    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    common_scripts\utility::waittill_any( "death", "pdrone_flying_attack_drone_logic" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

get_linked_air_spaces( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    if ( isdefined( var_0.script_linkto ) )
        var_3 = strtok( var_0.script_linkto, " " );

    for ( var_4 = 0; var_4 < var_1.size; var_4++ )
    {
        var_5 = 0;

        if ( isdefined( var_1[var_4].script_linkname ) )
        {
            for ( var_6 = 0; var_6 < var_3.size; var_6++ )
            {
                if ( var_1[var_4].script_linkname == var_3[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    var_5 = 1;
                    break;
                }
            }
        }

        if ( !var_5 && isdefined( var_1[var_4].script_linkto ) && isdefined( var_0.script_linkname ) )
        {
            var_7 = strtok( var_1[var_4].script_linkto, " " );

            for ( var_6 = 0; var_6 < var_7.size; var_6++ )
            {
                if ( var_0.script_linkname == var_7[var_6] )
                {
                    var_2[var_2.size] = var_1[var_4];
                    break;
                }
            }
        }
    }

    return var_2;
}

get_next_air_space( var_0, var_1, var_2 )
{
    var_3 = [];
    var_3[0] = var_0;
    var_4 = [];

    foreach ( var_6 in var_2 )
        var_6.g_score = 0;

    var_0.f_score = var_0.g_score + distance( var_0.origin, var_1.origin );

    while ( var_3.size > 0 )
    {
        var_8 = undefined;
        var_9 = 500000;

        foreach ( var_11 in var_3 )
        {
            if ( var_11.f_score < var_9 )
            {
                var_8 = var_11;
                var_9 = var_11.f_score;
            }
        }

        if ( var_8 == var_1 )
        {
            for ( var_13 = var_1; var_13.came_from != var_0; var_13 = var_13.came_from )
            {

            }

            return var_13;
        }

        var_3 = common_scripts\utility::array_remove( var_3, var_8 );
        var_4[var_4.size] = var_8;
        var_14 = get_linked_air_spaces( var_8, var_2 );

        foreach ( var_11 in var_14 )
        {
            var_16 = var_8.g_score + distance( var_8.origin, var_11.origin );

            if ( common_scripts\utility::array_contains( var_4, var_11 ) && var_16 >= var_11.g_score )
                continue;

            var_17 = common_scripts\utility::array_contains( var_3, var_11 );

            if ( !var_17 || var_16 < var_11.g_score )
            {
                var_11.came_from = var_8;
                var_11.g_score = var_16;
                var_11.f_score = var_11.g_score + distance( var_11.origin, var_1.origin );

                if ( !var_17 )
                    var_3[var_3.size] = var_11;
            }
        }
    }

    return undefined;
}

should_play_animations()
{
    return self.classname == "script_vehicle_pdrone_kva" || self.classname == "script_vehicle_pdrone_atlas_large";
}

#using_animtree("vehicles");

setup_pdrone_animations()
{
    switch ( self.classname )
    {
        case "script_vehicle_pdrone_kva":
            level.scr_anim["personal_drone"]["idle"][0] = %hms_greece_pdrone_idle_01;
            level.scr_anim["personal_drone"]["idle"][1] = %hms_greece_pdrone_idle_02;
            level.scr_anim["personal_drone"]["hit_reaction"][0] = %hms_greece_pdrone_hitreaction_01;
            level.scr_anim["personal_drone"]["hit_reaction"][1] = %hms_greece_pdrone_hitreaction_02;
            level.scr_anim["personal_drone"]["hit_reaction"][2] = %hms_greece_pdrone_hitreaction_03;
            level.scr_anim["personal_drone"]["reload"][1] = %hms_greece_pdrone_reload_01;
            break;
        case "script_vehicle_pdrone_atlas_large":
            level.scr_anim["personal_drone"]["idle"][0] = %atlas_assault_drone_idle_01;
            level.scr_anim["personal_drone"]["idle"][1] = %atlas_assault_drone_idle_02;
            level.scr_anim["personal_drone"]["hit_reaction"][0] = %atlas_assault_drone_hitreaction_01;
            level.scr_anim["personal_drone"]["hit_reaction"][1] = %atlas_assault_drone_hitreaction_02;
            level.scr_anim["personal_drone"]["hit_reaction"][2] = %atlas_assault_drone_hitreaction_03;
            break;
        default:
            break;
    }
}

play_hit_reaction()
{
    if ( !isdefined( level.scr_anim["personal_drone"]["hit_reaction"] ) )
        return;

    self useanimtree( level.scr_animtree["personal_drone"] );
    var_0 = randomint( level.scr_anim["personal_drone"]["hit_reaction"].size );
    var_1 = getanimlength( level.scr_anim["personal_drone"]["hit_reaction"][var_0] );
    self setanimknobrestart( level.scr_anim["personal_drone"]["hit_reaction"][var_0] );
    self.playing_hit_reaction = 1;
    wait(var_1);

    if ( !isdefined( self ) || !isalive( self ) )
        return;

    self.playing_hit_reaction = 0;
}

idle_anim_update()
{
    self endon( "death" );
    self useanimtree( level.scr_animtree["personal_drone"] );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        wait 0.05;

        if ( !var_0 && !self.playing_hit_reaction )
        {
            var_2 = randomint( level.scr_anim["personal_drone"]["idle"].size );
            var_1 = getanimlength( level.scr_anim["personal_drone"]["idle"][var_2] );
            self setanimknob( level.scr_anim["personal_drone"]["idle"][var_2] );
            var_0 = 1;
        }
        else if ( self.playing_hit_reaction || var_1 <= 0 )
            var_0 = 0;

        var_1 -= 0.05;
    }
}

flying_attack_drone_stun_monitor()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "stun_drone" );
        stun_drone();
    }
}

stun_drone()
{
    self.stun_duration = 2;

    if ( self.playing_hit_reaction )
        return;

    thread play_hit_reaction();
}
