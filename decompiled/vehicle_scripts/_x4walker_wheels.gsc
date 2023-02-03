// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("vehicles");

main( var_0, var_1, var_2 )
{
    precachemodel( "vehicle_vm_x4walker_wheels" );
    precachemodel( "projectile_rpg7" );
    precacheshader( "hud_exo_poly_cool" );
    precacheshader( "hud_exo_circle_hot" );
    precacheshellshock( "mobile_turret_missile" );
    maps\_utility::set_console_status();
    maps\_vehicle::build_template( "x4walker_wheels", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::local_init );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_mainturret();
    maps\_vehicle::build_shoot_shock( "mobile_turret_shoot" );
    maps\_vehicle::build_aianims( ::set_ai_anims );
    maps\_vehicle::build_drive( %x4walker_wheels_drive_idle, %x4walker_wheels_drive_idle, 3.36 );
    maps\_vehicle::build_treadfx();
    build_walker_death( var_2 );
    register_vehicle_anims( var_2 );
    register_player_anims();
    register_fx();
}

build_walker_death( var_0 )
{
    level._effect["walkerexplode"] = loadfx( "vfx/explosion/vehicle_x4walker_explosion" );
    maps\_vehicle::build_deathmodel( "vehicle_x4walker_wheels", "vehicle_x4walker_wheels_dstrypv" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_x4walker_explosion", "TAG_DEATH_FX" );
    maps\_vehicle::build_deathquake( 1, 1.6, 625 );
    maps\_vehicle::build_radiusdamage( ( 0, 0, 32 ), 300, 200, 0, 0 );
}

register_vehicle_anims( var_0 )
{
    maps\_vehicle_shg::add_vehicle_anim( var_0, "idle", %x4walker_wheels_idle );
    maps\_vehicle_shg::add_vehicle_anim( var_0, "cockpit_idle", %x4walker_wheels_cockpit_idle );
}

register_fx()
{
    level._effect["x4walker_wheels_rpg_fv"] = loadfx( "vfx/muzzleflash/x4walker_wheels_rpg_fv" );
}

local_init()
{
    self useanimtree( #animtree );
    thread vehicle_scripts\_x4walker_wheels_aud::snd_init_x4_walker_wheels();
    thread monitor_vehicle_mount();
    thread animation_think();
    thread monitor_wheel_movements();
    thread monitor_walker_death_stop_sounds();
    waittillframeend;
    self notify( "stop_vehicle_shoot_shock" );
}

#using_animtree("generic_human");

set_ai_anims()
{
    var_0 = [];
    var_0[0] = spawnstruct();
    var_0[0].sittag = "tag_guy";
    var_0[0].idle = %x4walker_wheels_idle_npc;
    return var_0;
}

#using_animtree("player");

register_player_anims()
{
    level.scr_anim["_vehicle_player_rig"]["enter_left"] = %x4walker_wheels_cockpit_in_l_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_right"] = %x4walker_wheels_cockpit_in_r_vm;
    level.scr_anim["_vehicle_player_rig"]["enter_back"] = %x4walker_wheels_cockpit_in_b_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_left"] = %x4walker_wheels_cockpit_out_l_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_right"] = %x4walker_wheels_cockpit_out_r_vm;
    level.scr_anim["_vehicle_player_rig"]["exit_back"] = %x4walker_wheels_cockpit_out_b_vm;
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_left" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_right" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_cockpit_model, "enter_back" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_left" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_right" );
    maps\_anim::addnotetrack_customfunction( "_vehicle_player_rig", "cockpit_swap", ::swap_world_model, "exit_back" );
}

make_mobile_turret_usable()
{
    self endon( "death" );
    thread handle_vehicle_dof();
    self.enter_use_tags = [];

    for ( var_0 = 0; var_0 < 3; var_0++ )
    {
        var_1 = spawn( "script_model", ( 0, 0, 0 ) );
        var_1 setmodel( "tag_origin" );
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

    foreach ( var_1 in self.enter_use_tags )
    {
        var_1 linkto( self );
        var_1 sethintstring( "Press ^3 &&1 ^7to Enter the Mobile Turret." );
        var_1 makeusable();
    }

    for (;;)
    {
        self makeunusable();
        wait_for_any_trigger_hit( self.enter_use_tags );

        if ( isdefined( level.player.linked_to_cover ) )
            continue;

        foreach ( var_1 in self.enter_use_tags )
            var_1 makeunusable();

        level.player maps\_shg_utility::setup_player_for_scene();
        maps\_player_exo::player_exo_deactivate();
        var_11 = maps\_vehicle_shg::spawn_player_rig();
        var_11 hide();
        var_12 = distancesquared( level.player.origin, self.enter_use_tags[0].origin );
        var_13 = distancesquared( level.player.origin, self.enter_use_tags[1].origin );
        var_14 = distancesquared( level.player.origin, self.enter_use_tags[2].origin );
        var_15 = var_12;
        var_16 = "enter_left";
        var_17 = "exit_left";

        if ( var_13 < var_15 )
        {
            var_15 = var_13;
            var_16 = "enter_right";
            var_17 = "exit_right";
        }

        if ( var_14 < var_15 )
        {
            var_15 = var_14;
            var_16 = "enter_back";
            var_17 = "exit_back";
        }

        maps\_anim::anim_first_frame_solo( var_11, var_16, "tag_body" );
        level.player playerlinktoblend( var_11, "tag_player", 0.2, 0.1, 0.1 );
        wait 0.2;
        var_11 show();
        var_11.vehicle_to_swap = self;
        maps\_anim::anim_single_solo( var_11, var_16, "tag_body" );
        level.player unlink();
        var_11 delete();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        level.player maps\_utility::player_mount_vehicle( self );
        wait_for_exit_message();

        if ( isdefined( level.player.drivingvehicle ) )
        {
            level.player maps\_shg_utility::setup_player_for_scene();
            var_11 = maps\_vehicle_shg::spawn_player_rig();
            var_11 hide();
            maps\_anim::anim_first_frame_solo( var_11, var_17, "tag_body" );
            level.player playerlinktoblend( var_11, "tag_player", 0.2, 0.1, 0.1 );
            wait 0.2;
            var_11 show();
            var_11.vehicle_to_swap = self;
            level.player maps\_utility::player_dismount_vehicle();
            level.player playerlinktodelta( var_11, "tag_player", 1, 0, 0, 0, 0, 1 );
            maps\_anim::anim_single_solo( var_11, var_17, "tag_body" );
            level.player unlink();
            var_11 delete();
            level.player maps\_shg_utility::setup_player_for_gameplay();
            maps\_player_exo::player_exo_activate();

            foreach ( var_1 in self.enter_use_tags )
                var_1 makeusable();
        }
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
        maps\_art::dof_disable_script( 0.25 );
    }
}

wait_for_exit_message()
{
    self endon( "vehicle_dismount" );
    var_0 = "exit_message";
    notifyoncommand( var_0, "+activate" );
    notifyoncommand( var_0, "+usereload" );
    level.player waittill( var_0 );
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

make_mobile_turret_unusable()
{
    self makeunusable();

    if ( isdefined( self.enter_use_tags ) )
    {
        foreach ( var_1 in self.enter_use_tags )
            var_1 makeunusable();
    }
}

monitor_vehicle_mount()
{
    self endon( "death" );
    self setanim( maps\_vehicle_shg::get_vehicle_anim( "idle" ) );
    thread calculate_base_target_offset();

    for (;;)
    {
        maps\_vehicle_shg::wait_for_vehicle_mount();
        thread turret_think();

        if ( !isdefined( self.player_driver ) )
        {
            thread handle_vehicle_ai();
            thread rocket_ai();
            make_mobile_turret_unusable();
            thread vehicle_scripts\_x4walker_wheels_aud::snd_start_x4_walker_wheels( "npc" );
        }
        else
            thread rocket_think();

        maps\_vehicle_shg::wait_for_vehicle_dismount();
        reset_turret();
    }
}

monitor_walker_death_stop_sounds()
{
    self waittill( "death" );

    if ( !isdefined( self ) )
        return;

    var_0 = 1;
    soundscripts\_snd::snd_message( "snd_stop_vehicle", var_0 );
}

animation_think()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "play_anim", var_0 );
        clear_anims();
        self setanim( maps\_vehicle_shg::get_vehicle_anim( var_0 ), 1.0, 0.2, 1.0 );
    }
}

#using_animtree("vehicles");

clear_anims()
{
    self clearanim( %walker_wheels, 0.2 );
}

turret_think()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );

    if ( isdefined( self.player_driver ) )
        level.player shellshock( "mobile_turret_shoot", 0.1 );

    for (;;)
    {
        self waittill( "turret_fire" );
        self fireweapon();
    }
}

reset_turret()
{
    self notify( "stop_vehicle_shoot_shock" );

    if ( isdefined( self.base_target_offset_angles ) && isdefined( self.base_target_offset_length ) )
    {
        var_0 = anglestoforward( self.angles );
        var_1 = self gettagorigin( "tag_body" );
        var_1 += var_0 * 100;
        var_2 = anglestoforward( self.base_target_offset_angles + self gettagangles( "tag_body" ) );
        var_2 *= self.base_target_offset_length;
        self setturrettargetvec( var_1 + var_2 );
    }
}

rocket_think()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    thread monitor_missile_input();

    for (;;)
    {
        self waittill( "target_missile_system" );
        thread rocket_target_think();
        self waittill( "fire_missile_system" );
        thread fire_rockets();
        wait 2;
    }
}

rocket_target_think()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    self endon( "fire_missile_system" );

    if ( !isdefined( self.rocket_targets ) )
        self.rocket_targets = [];

    var_0 = 4;

    for (;;)
    {
        if ( self.rocket_targets.size < var_0 )
        {
            var_1 = anglestoforward( self.player_driver getangles() );
            var_1 = vectornormalize( var_1 );
            var_2 = self.player_driver geteye();
            var_3 = bullettrace( var_2, var_2 + var_1 * 2048, 1, self );
            var_4 = var_3["entity"];

            if ( isdefined( var_4 ) && isai( var_4 ) && isalive( var_4 ) && !maps\_vehicle_code::attacker_isonmyteam( var_4 ) && !maps\_vehicle_code::attacker_troop_isonmyteam( var_4 ) )
            {
                if ( !isdefined( var_4.target_marked ) || !var_4.target_marked )
                {
                    var_4.target_marked = 1;
                    target_set( var_4, ( 0, 0, 20 ) );
                    target_setshader( var_4, "hud_exo_poly_cool" );
                    thread remove_target( var_4 );
                    self.rocket_targets[self.rocket_targets.size] = var_4;
                }
            }
        }

        wait 0.05;
    }
}

remove_target( var_0 )
{
    wait_to_remove_target( var_0 );

    if ( isdefined( var_0 ) )
    {
        var_0.target_marked = undefined;
        target_remove( var_0 );
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
    self endon( "vehicle_dismount" );
    var_0 endon( "death" );
    var_0 waittill( "remove_target" );
}

monitor_missile_input()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    var_0 = 0;

    for (;;)
    {
        var_1 = self.player_driver fragbuttonpressed();

        if ( var_1 && !var_0 )
        {
            var_0 = 1;
            self notify( "target_missile_system" );
        }
        else if ( !var_1 && var_0 )
        {
            var_0 = 0;
            self notify( "fire_missile_system" );
        }

        wait 0.05;
    }
}

fire_rockets()
{
    var_0 = 0;

    foreach ( var_2 in self.rocket_targets )
    {
        if ( !isdefined( var_2 ) )
            continue;

        self.player_driver playrumbleonentity( "heavygun_fire" );
        target_setshader( var_2, "hud_exo_circle_hot" );
        thread fire_rocket_at( var_2, var_0 );
        var_0++;
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
    var_3 = "TAG_LAUNCHER" + ( self.launcher_index + 1 );
    var_4 = self gettagorigin( var_3 );
    var_5 = self gettagangles( var_3 );
    var_6 = var_4 + anglestoforward( var_5 ) * 512;
    playfxontag( common_scripts\utility::getfx( "x4walker_wheels_rpg_fv" ), self, var_3 );

    if ( isdefined( self.player_driver ) )
        var_7 = magicbullet( "mobile_turret_missile", var_4, var_6 );
    else
        var_7 = magicbullet( "mobile_turret_missile", var_4, var_6 );

    var_7 missile_settargetent( var_0 );
    var_7 missile_setflightmodedirect();
    var_7 soundscripts\_snd::snd_message( "mobile_turret_missile" );
}

handle_vehicle_ai()
{
    if ( isdefined( self.ai_func_override ) )
        self thread [[ self.ai_func_override ]]();
    else
    {
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target( 10 );
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot( 2, 4, 0.1, 0.3, 1 );
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
    }
}

rocket_ai()
{
    self endon( "death" );
    self endon( "vehicle_dismount" );
    var_0 = 128;
    wait(randomintrange( 1, 10 ));

    for (;;)
    {
        wait(randomfloatrange( 12, 20 ));
        var_1 = 0;

        while ( !var_1 )
        {
            var_2 = [];

            if ( isdefined( self.script_team ) )
            {
                var_3 = common_scripts\utility::get_enemy_team( self.script_team );
                var_4 = getaiarray( var_3 );
            }
            else
                var_4 = getaiarray( "axis" );

            foreach ( var_6 in var_4 )
            {
                var_7 = var_6.origin - self.origin;
                var_8 = length( var_7 );

                if ( var_8 < 1024 )
                    continue;

                var_7 = vectornormalize( var_7 );
                var_9 = self gettagangles( "tag_flash" );
                var_10 = anglestoforward( var_9 );
                var_11 = vectordot( var_7, var_10 );

                if ( var_11 < 0.5 )
                    continue;

                var_12 = self gettagorigin( "tag_flash" );
                var_13 = var_6.origin + ( 0, 0, 32 );
                var_14 = sighttracepassed( var_12, var_13, 0, self );

                if ( !var_14 )
                    continue;

                var_15 = vectorfromlinetopoint( var_12, var_13, level.player.origin + ( 0, 0, 32 ) );

                if ( length( var_15 ) < var_0 )
                    continue;

                var_2[var_2.size] = var_6;
            }

            var_17 = [];

            if ( var_2.size > 0 )
            {
                var_18 = randomint( var_2.size );

                for ( var_19 = 0; var_19 < var_2.size; var_19++ )
                {
                    var_20 = ( var_18 + var_19 ) % var_2.size;
                    var_21 = var_2[var_20];
                    var_17[var_17.size] = var_21;

                    if ( var_17.size > 1 )
                    {
                        var_22 = var_17.size / 4;

                        if ( var_22 > randomfloatrange( 0, 1 ) )
                            break;
                    }
                }
            }

            var_23 = 0;

            foreach ( var_25 in var_17 )
            {
                if ( !isdefined( var_25 ) )
                    continue;

                var_1 = 1;
                thread fire_rocket_at( var_25, var_23 );
                var_23++;
                wait 0.35;
            }

            if ( !var_1 )
                wait 0.5;
        }
    }
}

calculate_base_target_offset()
{
    var_0 = anglestoforward( self.angles );
    var_1 = self gettagorigin( "tag_body" );
    var_2 = var_1 + var_0 * 100;
    var_3 = self gettagorigin( "tag_flash" );
    var_4 = anglestoforward( self gettagangles( "tag_flash" ) );
    var_5 = var_3 + var_4 * 100;
    var_6 = var_5 - var_2;
    var_7 = self gettagangles( "tag_body" );
    self.base_target_offset_length = length( var_6 );
    var_8 = vectortoangles( var_6 );
    self.base_target_offset_angles = var_8 - var_7;
}

swap_cockpit_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        var_0.vehicle_to_swap notify( "enter_vehicle_dof" );
        var_0.vehicle_to_swap setmodel( "vehicle_vm_x4walker_wheels" );
        var_0.vehicle_to_swap notify( "play_anim", "cockpit_idle" );
    }
}

swap_world_model( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.vehicle_to_swap ) )
    {
        var_0.vehicle_to_swap notify( "exit_vehicle_dof" );
        var_0.vehicle_to_swap setmodel( "vehicle_x4walker_wheels" );
        var_0.vehicle_to_swap notify( "play_anim", "idle" );
    }
}

monitor_wheel_movements()
{
    self endon( "death" );
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

get_wheel_velocity( var_0 )
{
    if ( isdefined( self.current_wheel_pos[var_0] ) && isdefined( self.last_wheel_pos[var_0] ) )
    {
        var_1 = self.current_wheel_pos[var_0] - self.last_wheel_pos[var_0];
        return var_1 * 20;
    }

    return ( 0, 0, 0 );
}
