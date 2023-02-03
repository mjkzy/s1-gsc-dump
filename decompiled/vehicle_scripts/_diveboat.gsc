// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    setup_fx();
    maps\_vehicle::build_template( "diveboat", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_mil_atlas_speedboat_ai", "vehicle_mil_atlas_speedboat_dstrypv", 0 );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_diveboat_explosion", undefined, "fin_npc_boat_exp" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_death_jolt_delay( 9999 );

    if ( !isdefined( level.diveboat_anims_initialized ) )
    {
        setup_worldhands_anims();
        setup_player_driving_anims();
        level.diveboat_anims_initialized = 1;
    }

    precachemodel( "vehicle_mil_hoverbike_vm" );
    precachemodel( "vehicle_mil_hoverbike_ai" );
    precachemodel( "vehicle_mil_atlas_speedboat_ai" );
    precacherumble( "steady_rumble" );
    init_diveboat_weapon();
    init_diveboat_weapon_gauge();
    maps\_vehicle::build_missile_launcher( "diveboat_missile_launcher", "hatchL", "projectile_rpg7", "rpg_guided", ::missile_door_open, ::missile_door_close, 0.2, 0.2, 0.75, 3.0, 5.0, 1 );
    maps\_vehicle::build_missile_launcher( "diveboat_missile_launcher", "hatchR", "projectile_rpg7", "rpg_guided", ::missile_door_open, ::missile_door_close, 0.2, 0.2, 0.75, 3.0, 5.0, 1 );
}

setup_fx()
{
    level._effect["boat_wake_diveboat_splash_fast"] = loadfx( "vfx/treadfx/boat_wake_diveboat_splash_fast" );
    level._effect["boat_wake_diveboat_splash_slow"] = loadfx( "vfx/treadfx/boat_wake_diveboat_splash_slow" );
    level._effect["diveboat_submerge_splash"] = loadfx( "vfx/water/diveboat_submerge_splash" );
    level._effect["diveboat_submerge_trail"] = loadfx( "vfx/water/diveboat_submerge_trail" );
    level._effect["diveboat_emerge_splash"] = loadfx( "vfx/water/diveboat_emerge_splash" );
    level._effect["boat_wake_diveboat_foam_trail"] = loadfx( "vfx/treadfx/boat_wake_diveboat_foam_trail" );
    level._effect["vehicle_diveboat_death_water_ring"] = loadfx( "vfx/explosion/vehicle_diveboat_death_water_ring" );
}

init_local()
{
    if ( self.vehicletype != "diveboat_player" )
    {
        self.playermech_rocket_targeting_allowed = 1;
        self enableaimassist();
        thread modifydamage();
        thread vehicle_death_add();
        thread ai_diveboats_chase_trail();
        soundscripts\_snd::snd_message( "find_npc_dive_boat_handler" );
        self.script_crashtypeoverride = "diveboat";
    }
}

#using_animtree("generic_human");

setanims()
{
    var_0[0] = spawnstruct();
    var_0[0].sittag = "tag_driver";
    var_0[0].getin = %hoverbike_mount_driver_dir1;
    var_0[0].getout = %hoverbike_dismount_driver;
    var_0[0].idle = %hoverbike_driving_idle_guy1;
    var_0[0].aianim_simple["hoverbike_driving_flashlight_left_guy1"] = %hoverbike_driving_flashlight_left_guy1;
    var_0[0].aianim_simple["hoverbike_driving_flashlight_right_guy1"] = %hoverbike_driving_flashlight_right_guy1;
    var_0[0].aianim_simple["hoverbike_driving_gesture_lft_guy1"] = %hoverbike_driving_gesture_lft_guy1;
    var_0[0].aianim_simple["hoverbike_driving_gesture_rt_guy1"] = %hoverbike_driving_gesture_rt_guy1;
    var_0[0].aianim_simple["hoverbike_driving_idle_guy1"] = %hoverbike_driving_idle_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_left_idle_guy1"] = %hoverbike_driving_lean_left_idle_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_left_into_guy1"] = %hoverbike_driving_lean_left_into_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_left_out_guy1"] = %hoverbike_driving_lean_left_out_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_right_idle_guy1"] = %hoverbike_driving_lean_right_idle_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_right_into_guy1"] = %hoverbike_driving_lean_right_into_guy1;
    var_0[0].aianim_simple["hoverbike_driving_lean_right_out_guy1"] = %hoverbike_driving_lean_right_out_guy1;
    var_0[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_guy1"] = %hoverbike_driving_look_over_lft_shoulder_guy1;
    var_0[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_guy1"] = %hoverbike_driving_look_over_rt_shoulder_guy1;
    return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims( var_0 )
{
    var_0[0].vehicle_idle = %hoverbike_driving_idle_vehicle1;
    return var_0;
}

#using_animtree("player");

setup_worldhands_anims()
{
    level.scr_anim["world_body"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vm;
    level.scr_anim["world_body"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
    level.scr_anim["world_body"]["mount_jetbike"] = %det_exfil_droponbike_drop_vm;
    maps\_anim::addnotetrack_customfunction( "world_body", "bike_swap", ::level_diveboat_to_vm_model, "mount_jetbike" );
    maps\_anim::addnotetrack_notify( "world_body", "fov_start", "exit_drive_FOV_start", "mount_jetbike" );
    maps\_anim::addnotetrack_notify( "world_body", "fov_end", "exit_drive_FOV_end", "mount_jetbike" );
}

#using_animtree("vehicles");

setup_player_driving_anims()
{
    level.scr_anim["frankenbike_jetbike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
    level.scr_anim["frankenbike_worldbody"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
    level.scr_anim["frankenbike_jetbike"]["idle_branch"] = %hoverbike_vehicle_idle_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_branch"] = %hoverbike_vehicle_idle_slow_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_slow"] = %hoverbike_drive_idle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_branch"] = %hoverbike_vehicle_idle_fast_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_direction_branch"] = %hoverbike_vehicle_idle_fast_direction_branch;
    level.scr_anim["frankenbike_jetbike"]["idle_fast"] = %hoverbike_drive_fast_idle_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_st"] = %hoverbike_drive_jump_st_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_loop"] = %hoverbike_drive_jump_loop_vehicle;
    level.scr_anim["frankenbike_jetbike"]["jump_end"] = %hoverbike_drive_jump_end_vehicle;
    level.scr_anim["frankenbike_worldbody"]["idle_branch"] = %hoverbike_vm_idle_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_branch"] = %hoverbike_vm_idle_slow_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_slow"] = %hoverbike_drive_idle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_branch"] = %hoverbike_vm_idle_fast_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_direction_branch"] = %hoverbike_vm_idle_fast_direction_branch;
    level.scr_anim["frankenbike_worldbody"]["idle_fast"] = %hoverbike_drive_fast_idle_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vm;
    level.scr_anim["frankenbike_worldbody"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_st"] = %hoverbike_drive_jump_st_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_loop"] = %hoverbike_drive_jump_loop_vm;
    level.scr_anim["frankenbike_worldbody"]["jump_end"] = %hoverbike_drive_jump_end_vm;
    level.scr_anim["player_bike"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vehicle;
    level.scr_anim["player_bike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
    level.scr_anim["player_bike"]["mount_jetbike"] = %det_exfil_droponbike_drop_vmbike;
}

modifydamage()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( var_4 == "MOD_PROJECTILE" )
        {
            var_0 = self.maxhealth * 0.5;
            self dodamage( var_0, var_3, var_1, var_1, var_4 );
        }
    }
}

level_diveboat_to_vm_model( var_0 )
{
    level.diveboat setmodel( "vehicle_mil_hoverbike_vm" );
}

do_diveboat_threads()
{
    thread rumble_thread();
    thread handle_diveboat_collisions();
}

stop_diveboat_threads()
{
    self notify( "stop_diveboat_thread" );
    self.rumble_entity.intensity = 0.0;
}

handle_diveboat_collisions()
{
    self endon( "death" );
    self endon( "stop_diveboat_thread" );

    for (;;)
    {
        self waittill( "veh_contact", var_0, var_1, var_2, var_3, var_4 );

        if ( isdefined( self.last_collision_time ) && self.last_collision_time == gettime() )
            continue;

        self.last_collision_time = gettime();
        var_5 = [];
        var_5["vehicle"] = self;
        var_5["hit_entity"] = var_0;
        var_5["pos"] = var_1;
        var_5["impulse"] = var_2;
        var_5["relativeVel"] = var_3;
        var_5["surface"] = var_4;
        soundscripts\_snd::snd_message( "aud_impact_system_diveboat", var_5 );
    }
}

rumble_thread()
{
    level.player endon( "death" );
    self endon( "stop_diveboat_thread" );
    var_0 = 40.0;
    var_1 = 0.1;
    var_2 = 0.001;
    var_3 = 8.0;
    var_4 = 0.1;
    var_5 = 0.0;
    self.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
    self.rumble_entity.intensity = 0.0;

    for (;;)
    {
        var_6 = var_5;
        var_5 = self vehicle_getspeed();

        if ( self vehicle_diveboatissubmerged() )
            self.rumble_entity.intensity = 0.0;
        else
        {
            var_7 = var_1 * clamp( var_5 / var_0, 0.0, 1.0 );
            var_7 *= randomfloat( 1.0 );
            var_8 = 0.0;

            if ( level.player attackbuttonpressed() )
            {
                var_9 = var_5 - var_6;

                if ( var_9 > 0.0 )
                    var_8 = var_3 * ( clamp( 1.0 - var_6 / var_5, var_2, 1.0 ) - var_2 );
            }

            var_10 = 0.0;
            var_11 = abs( level.player getnormalizedmovement()[1] );

            if ( var_11 > 0.3 )
                var_10 = var_11 * var_4;

            self.rumble_entity.intensity = clamp( var_7 + var_8 + var_10, 0.0, 1.0 );
        }

        wait 0.1;
    }
}

init_diveboat_weapon()
{
    precacheshellshock( "diveboat_missile" );
    precacheshader( "veh_hud_friendly" );
    precacheshader( "uav_vehicle_target" );
    precacheshader( "hud_fofbox_hostile" );
    level.diveboat_weapon_ammo_count = 4;
}

diveboat_weapon_auto_targetting()
{
    self.team = "allies";

    if ( isdefined( level.diveboat_weapon_target ) )
    {
        if ( isai( level.diveboat_weapon_target ) )
            self missile_settargetent( level.diveboat_weapon_target, ( 0, 0, 45 ) );
        else
            self missile_settargetent( level.diveboat_weapon_target );

        target_setshader( level.diveboat_weapon_target, "hud_fofbox_hostile" );
        var_0 = level.diveboat_weapon_target;
        level.diveboat_weapon_target.diveboat_weapon_attacked = 1;
        level.diveboat_weapon_target = undefined;
        var_0 endon( "death" );
        var_0 common_scripts\utility::waittill_notify_or_timeout( "damage", 2.5 );
        var_0.diveboat_weapon_attacked = undefined;
        target_setshader( var_0, "veh_hud_friendly" );
    }
}

get_npc_center_offset()
{
    if ( isai( self ) && isalive( self ) )
    {
        var_0 = self geteye()[2];
        var_1 = self.origin[2];
        var_2 = ( var_0 - var_1 ) / 2;
        return ( 0, 0, var_2 );
    }
    else
        return ( 0, 0, 0 );
}

set_up_target()
{
    if ( isdefined( self ) && isdefined( self.script_parameters ) && self.script_parameters == "diveboat_weapon_target" )
        target_set( self, get_npc_center_offset() );
}

give_diveboat_weapons()
{
    maps\_utility::add_global_spawn_function( "axis", ::set_up_target );
    thread diveboat_weapon_targetting_system();
    thread diveboat_weapon_reloading_system();
    thread diveboat_weapon_fire_notify();
    thread diveboat_weapon_fire_system();
}

remove_diveboat_weapons()
{
    maps\_utility::remove_global_spawn_function( "axis", ::set_up_target );
    level notify( "remove_diveboat_weapon" );
}

diveboat_weapon_targetting_system()
{
    level endon( "remove_diveboat_weapon" );

    for (;;)
    {
        var_0 = target_getarray();
        var_1 = [];

        foreach ( var_3 in var_0 )
        {
            if ( isdefined( var_3.ignore_target ) )
            {
                target_hidefromplayer( var_3, level.player );
                var_3.is_shown_to_player = undefined;
                continue;
            }

            if ( isdefined( var_3.diveboat_weapon_attacked ) )
            {
                if ( sighttracepassed( level.player.origin, var_3.origin, 0, var_3, self ) )
                {
                    if ( !isdefined( var_3.is_shown_to_player ) )
                    {
                        target_showtoplayer( var_3, level.player );
                        var_3.is_shown_to_player = 1;
                    }

                    target_setshader( var_3, "hud_fofbox_hostile" );
                }
                else if ( isdefined( var_3.is_shown_to_player ) )
                {
                    target_hidefromplayer( var_3, level.player );
                    var_3.is_shown_to_player = undefined;
                }

                continue;
            }

            if ( target_isincircle( var_3, level.player, 75, 360 ) && sighttracepassed( level.player.origin, var_3.origin, 0, var_3, self ) )
            {
                var_1[var_1.size] = var_3;

                if ( !isdefined( var_3.is_shown_to_player ) )
                {
                    target_showtoplayer( var_3, level.player );
                    var_3.is_shown_to_player = 1;
                }

                target_setshader( var_3, "veh_hud_friendly" );
                continue;
            }

            if ( isdefined( var_3.is_shown_to_player ) )
            {
                target_hidefromplayer( var_3, level.player );
                var_3.is_shown_to_player = undefined;
            }
        }

        if ( var_1.size > 0 )
        {
            var_5 = var_1[0];
            var_6 = distance2dsquared( level.player.origin, var_5.origin );

            for ( var_7 = 1; var_7 < var_1.size; var_7++ )
            {
                var_8 = distance2dsquared( level.player.origin, var_1[var_7].origin );

                if ( var_8 < var_6 )
                {
                    var_6 = var_8;
                    var_5 = var_1[var_7];
                }
            }

            level.diveboat_weapon_target = var_5;
            target_setshader( var_5, "uav_vehicle_target" );
        }

        wait 0.05;
    }
}

diveboat_weapon_reloading_system()
{
    level endon( "remove_diveboat_weapon" );

    for (;;)
    {
        if ( !isdefined( level.diveboat_weapon_firing ) && level.diveboat_weapon_ammo_count < 4 )
        {
            level.diveboat_weapon_ammo_count++;
            var_0 = level.diveboat_weapon_ammo_count / 4;
            level.diveboat_weapon_gauge_level = clamp( var_0, 0.04, 1 );
        }

        wait 0.5;
    }
}

diveboat_attack_button_pressed()
{
    var_0 = getdvarint( "vehDiveboatControlScheme" );

    if ( var_0 == 1 )
        return self buttonpressed( "BUTTON_LTRIG" );
    else if ( var_0 == 2 )
        return self buttonpressed( "BUTTON_A" );
    else
        return self buttonpressed( "BUTTON_RTRIG" );
}

diveboat_weapon_fire_notify()
{
    level endon( "remove_diveboat_weapon" );

    for (;;)
    {
        if ( level.player diveboat_attack_button_pressed() && level.diveboat_weapon_ammo_count > 0 && !self vehicle_diveboatissubmerged() )
        {
            level.diveboat_weapon_firing = 1;
            level.player notify( "LISTEN_attack_button_pressed" );
            var_0 = 0.0;
            var_1 = 0;

            while ( var_0 < 0.1 )
            {
                if ( !level.player diveboat_attack_button_pressed() )
                    var_1 = 1;

                var_0 += 0.05;
                wait 0.05;
            }

            level.diveboat_weapon_firing = undefined;

            if ( !var_1 )
            {
                while ( level.player diveboat_attack_button_pressed() )
                    wait 0.05;
            }

            continue;
        }

        wait 0.05;
    }
}

diveboat_weapon_fire_system()
{
    level endon( "remove_diveboat_weapon" );

    for (;;)
    {
        level.player waittill( "LISTEN_attack_button_pressed" );
        level.diveboat_weapon_ammo_count--;
        var_0 = level.diveboat_weapon_ammo_count / 4;
        level.diveboat_weapon_gauge_level = clamp( var_0, 0.04, 1 );
        var_1 = level.player getangles();
        var_2 = level.player geteye() + 50 * anglestoup( var_1 );
        var_3 = level.player geteye() + 500 * anglestoforward( var_1 ) + 80 * anglestoup( var_1 );
        var_4 = magicbullet( "diveboat_missile", var_2, var_3, level.player );
        var_4 thread diveboat_weapon_auto_targetting();
    }
}

init_diveboat_weapon_gauge()
{
    level.diveboat_weapon_gauge_level = 1.0;

    if ( isdefined( 0 ) && 0 )
    {
        precacheshader( "hud_temperature_gauge" );
        thread temp_diveboat_weapon_gauge();
    }
}

setup_missile_launchers()
{
    self.missiletags = [];
    self.missiletagsready = [];
    self.missiletags[0] = "TAG_MISSILE1";
    self.missiletags[1] = "TAG_MISSILE2";
    self.missiletags[2] = "TAG_MISSILE3";
    self.missiletags[3] = "TAG_MISSILE4";
    self.missiletags[4] = "TAG_MISSILE5";
    self.missiletags[5] = "TAG_MISSILE6";
    self.missiledooropen = 0;
    thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

missile_door_open()
{
    self setanimknobrestart( %atlas_speedboat_hatch_l_open, 0.9, 0 );
    self setanimlimited( %atlas_speedboat_hatch_l_root, 1, 0 );
    self setanimknobrestart( %atlas_speedboat_hatch_r_open, 0.9, 0 );
    self setanimlimited( %atlas_speedboat_hatch_r_root, 1, 0 );
    wait(getanimlength( %atlas_speedboat_hatch_l_open ));
}

missile_door_close()
{
    self setanimlimited( %atlas_speedboat_hatch_l_root, 0.01, 0.5 );
    self setanimlimited( %atlas_speedboat_hatch_r_root, 0.01, 0.5 );
    wait(getanimlength( %atlas_speedboat_hatch_l_open ));
}

fire_missles_at_target_array( var_0, var_1, var_2 )
{
    vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array( var_0, var_1, undefined, var_2 );
}

setup_and_fire_missles_at_guys_repeated( var_0, var_1 )
{
    self endon( "death" );

    if ( self.vehicletype != "diveboat_player" )
    {
        setup_missile_launchers();
        self.missile_auto_reload = 1;
        self useanimtree( #animtree );
        self setanim( %atlas_speedboat_idle, 1, 0, 1 );
    }

    if ( !isdefined( var_1 ) )
        var_1 = 2.0;

    vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array_repeated( var_0, ::missile_door_open, 1, 1, 1, "diveboats", 1, var_1 );
}

temp_diveboat_weapon_gauge()
{
    var_0 = 610;
    var_1 = 250;
    var_2 = 156.0;
    var_3 = int( 15.0 );
    var_4 = newhudelem();
    var_4.x = var_0 - 0.5 * ( 30 - var_3 );
    var_4.y = var_1 - int( 40.0 );
    var_4.alignx = "right";
    var_4.aligny = "bottom";
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.color = ( 0.1, 0.6, 0.1 );
    var_4 setshader( "white", var_3, int( var_2 * level.diveboat_weapon_gauge_level ) );
    var_5 = newhudelem();
    var_5.x = var_0;
    var_5.y = var_1;
    var_5.alignx = var_4.alignx;
    var_5.aligny = var_4.aligny;
    var_5.horzalign = var_4.horzalign;
    var_5.vertalign = var_4.vertalign;
    var_5.color = ( 1, 1, 1 );
    var_5 setshader( "hud_temperature_gauge", 30, 200 );
    var_6 = 0.05;

    for (;;)
    {
        if ( isdefined( level.player.drivingvehicle ) )
        {
            var_4.alpha = 1;
            var_5.alpha = 1;
            var_7 = level.diveboat_weapon_gauge_level;
            var_4 scaleovertime( var_6, var_3, int( var_2 * var_7 ) );

            if ( var_7 > 0.5 )
                var_4.color = ( 0.1, 0.6, 0.1 );
            else if ( var_7 > 0.2 )
                var_4.color = ( 1, 1, 0.1 );
            else
                var_4.color = ( 1, 0.1, 0.1 );
        }
        else
        {
            var_4.alpha = 0;
            var_5.alpha = 0;
        }

        wait(var_6);
    }
}

vehicle_death_add()
{
    var_0 = undefined;
    var_1 = undefined;

    while ( isalive( self ) && !issubstr( self.model, "dstrypv" ) )
    {
        var_0 = self.origin;
        waitframe();
    }

    thread vehicle_death_add_remove_carcass();
    var_2 = bullettrace( var_0 + ( 0, 0, 500 ), var_0 + ( 0, 0, -100 ), 0, self, 0, 0, 0, 0, 0 );

    if ( isdefined( var_2["surfacetype"] ) && issubstr( var_2["surfacetype"], "water" ) )
        var_3 = var_2["position"];
    else
        return;

    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = ( var_0[0], var_0[1], var_3[2] );
    var_4.angles = ( 270, 0, 0 );
    playfxontag( common_scripts\utility::getfx( "vehicle_diveboat_death_water_ring" ), var_4, "tag_origin" );
    wait 3;
    stopfxontag( common_scripts\utility::getfx( "vehicle_diveboat_death_water_ring" ), var_4, "tag_origin" );
    var_4 delete();
}

vehicle_death_add_remove_carcass()
{
    wait 0.25;

    if ( isremovedentity( self ) )
        return;

    if ( isdefined( level.player.underwater ) && level.player.underwater )
    {
        var_0 = getdvarint( "cg_fov" );

        while ( level.player worldpointinreticle_circle( self.origin, var_0, 350 ) )
        {
            waitframe();

            if ( isremovedentity( self ) )
                return;
        }

        self delete();
    }
    else
        self delete();
}

ai_diveboats_chase_trail()
{
    self endon( "death" );
    var_0 = bullettrace( self.origin + ( 0, 0, 500 ), self.origin + ( 0, 0, -100 ), 0, self, 0, 0, 0, 0, 0 );

    if ( isdefined( var_0["surfacetype"] ) && issubstr( var_0["surfacetype"], "water" ) )
        var_1 = var_0["position"];
    else
        var_1 = self.origin;

    thread ai_diveboat_foam_trail( var_1[2] );

    while ( isdefined( self ) && isalive( self ) && !issubstr( self.model, "dstrypv" ) )
    {
        var_2 = self vehicle_getspeed();

        if ( self vehicle_diveboatissubmerged() )
        {

        }
        else
        {
            var_3 = self.origin[2] - var_1[2];

            if ( var_3 <= 15 )
            {
                if ( var_2 > 35 )
                    playfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_splash_fast" ), self, "tag_origin" );
                else if ( var_2 <= 35 && var_2 >= 10 )
                    playfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_splash_slow" ), self, "tag_origin" );
                else if ( var_2 < 10 )
                {

                }
            }
        }

        wait 0.3;
    }

    self notify( "boat_dead" );
}

ai_diveboat_foam_trail( var_0 )
{
    self endon( "boat_dead" );
    var_1 = self vehicle_diveboatissubmerged();
    var_2 = 0;
    var_3 = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_foam_trail" ), var_3, "tag_origin" );

    while ( isdefined( self ) && isalive( self ) && !issubstr( self.model, "dstrypv" ) )
    {
        var_3.origin = ( self.origin[0], self.origin[1], var_0 );
        var_3.angles = ( 0, self.angles[1], 0 );

        if ( isdefined( self ) )
        {
            var_1 = self vehicle_diveboatissubmerged();

            if ( var_1 != var_2 )
            {
                if ( var_1 )
                {
                    playfxontag( common_scripts\utility::getfx( "diveboat_submerge_splash" ), var_3, "tag_origin" );
                    playfxontag( common_scripts\utility::getfx( "diveboat_submerge_trail" ), self, "tag_origin" );
                    stopfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_foam_trail" ), var_3, "tag_origin" );
                }
                else
                {
                    playfxontag( common_scripts\utility::getfx( "diveboat_emerge_splash" ), var_3, "tag_origin" );
                    playfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_foam_trail" ), var_3, "tag_origin" );
                    stopfxontag( common_scripts\utility::getfx( "diveboat_submerge_splash" ), var_3, "tag_origin" );
                }

                var_2 = var_1;
                wait 0.05;
            }
        }

        wait 0.05;
    }

    wait 0.05;
    stopfxontag( common_scripts\utility::getfx( "boat_wake_diveboat_foam_trail" ), var_3, "tag_origin" );
    var_3 delete();
}

diveboat_audio()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0.player_mode = 1;
    var_0.preset_name = "diveboat";
    var_1 = vehicle_scripts\_diveboat_aud::diveboat_constructor;
    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );

    if ( var_0.player_mode == 1 )
        soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );

    common_scripts\utility::flag_wait( "flag_objective_boat_chase_complete" );
    maps\_utility::delaythread( 5.0, soundscripts\_snd::snd_message, "snd_stop_vehicle" );
}
