// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

delete_spawners( var_0 )
{
    if ( !isarray( var_0 ) )
        var_0 = [ var_0 ];

    foreach ( var_2 in var_0 )
    {
        foreach ( var_4 in getentarray( var_2, "script_noteworthy" ) )
        {
            if ( isspawner( var_4 ) )
                var_4 delete();
        }
    }
}

spawn_metrics_init_for_noteworthy( var_0 )
{
    if ( !isdefined( level.spawn_metrics_spawn_count ) )
        level.spawn_metrics_spawn_count = [];

    if ( !isdefined( level.spawn_metrics_death_count ) )
        level.spawn_metrics_death_count = [];

    maps\_utility::array_spawn_function_noteworthy( var_0, ::spawn_metrics_spawn_func );

    foreach ( var_2 in getentarray( var_0, "script_noteworthy" ) )
    {
        if ( !isspawner( var_2 ) && isalive( var_2 ) )
            var_2 spawn_metrics_spawn_func();
    }
}

spawn_metrics_spawn_func()
{
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( isdefined( level.spawn_metrics_spawn_count[self.script_noteworthy] ) )
            level.spawn_metrics_spawn_count[self.script_noteworthy] += 1;
        else
            level.spawn_metrics_spawn_count[self.script_noteworthy] = 1;

        thread spawn_metrics_death_watcher();
    }
}

spawn_metrics_death_watcher()
{
    var_0 = self.script_noteworthy;
    self waittill( "death" );

    if ( isdefined( level.spawn_metrics_death_count[var_0] ) )
        level.spawn_metrics_death_count[var_0] += 1;
    else
        level.spawn_metrics_death_count[var_0] = 1;
}

spawn_metrics_number_spawned( var_0 )
{
    if ( isarray( var_0 ) )
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
            var_1 += spawn_metrics_number_spawned( var_3 );

        return var_1;
    }

    if ( isdefined( level.spawn_metrics_spawn_count[var_0] ) )
        return level.spawn_metrics_spawn_count[var_0];
    else
        return 0;
}

spawn_metrics_number_died( var_0 )
{
    if ( isarray( var_0 ) )
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
            var_1 += spawn_metrics_number_died( var_3 );

        return var_1;
    }

    if ( isdefined( level.spawn_metrics_death_count[var_0] ) )
        return level.spawn_metrics_death_count[var_0];
    else
        return 0;
}

spawn_metrics_number_alive( var_0 )
{
    return spawn_metrics_number_spawned( var_0 ) - spawn_metrics_number_died( var_0 );
}

spawn_metrics_waittill_count_reaches( var_0, var_1, var_2 )
{
    if ( !isarray( var_1 ) )
        var_1 = [ var_1 ];

    waittillframeend;

    for (;;)
    {
        var_3 = 0;

        foreach ( var_5 in var_1 )
            var_3 += spawn_metrics_number_alive( var_5 );

        if ( var_3 <= var_0 )
            break;

        wait 1;
    }
}

spawn_metrics_waittill_deaths_reach( var_0, var_1, var_2 )
{
    if ( !isarray( var_1 ) )
        var_1 = [ var_1 ];

    for (;;)
    {
        var_3 = 0;

        foreach ( var_5 in var_1 )
            var_3 += spawn_metrics_number_died( var_5 );

        if ( var_3 >= var_0 )
            break;

        wait 1;
    }
}

goto_node( var_0, var_1, var_2 )
{
    self endon( "stop_goto_node" );

    if ( !isdefined( var_2 ) )
        var_2 = 16;

    maps\_utility::set_goal_radius( var_2 );

    if ( isstring( var_0 ) )
        var_3 = getnode( var_0, "script_noteworthy" );
    else
        var_3 = var_0;

    if ( isdefined( var_3 ) )
        maps\_utility::set_goal_node( var_3 );
    else
    {
        var_3 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
        maps\_utility::set_goal_pos( var_3.origin );
    }

    if ( var_1 )
        self waittill( "goal" );
}

disable_grenades()
{
    if ( isdefined( self.grenadeammo ) && !isdefined( self.oldgrenadeammo ) )
        self.oldgrenadeammo = self.grenadeammo;

    self.grenadeammo = 0;
}

enable_grenades()
{
    if ( isdefined( self.oldgrenadeammo ) )
    {
        self.grenadeammo = self.oldgrenadeammo;
        self.oldgrenadeammo = undefined;
    }
}

equip_microwave_grenade()
{
    self.grenadeweapon = "microwave_grenade";
    self.grenadeammo = 2;
}

bloody_death( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread bloody_death_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self dodamage( self.health + 50, self.origin );
}

bloody_death_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

teleport_to_scriptstruct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "script_noteworthy" );
    level.player setorigin( var_1.origin );

    if ( isdefined( var_1.angles ) )
        level.player setangles( var_1.angles );

    var_2 = getentarray( "hero", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( isspawner( var_4 ) )
            var_2 = common_scripts\utility::array_remove( var_2, var_4 );
    }

    var_6 = common_scripts\utility::getstructarray( var_1.target, "targetname" );

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        if ( var_7 < var_6.size )
        {
            var_2[var_7] forceteleport( var_6[var_7].origin, var_6[var_7].angles );
            var_2[var_7] setgoalpos( var_6[var_7].origin );
            continue;
        }

        var_2[var_7] forceteleport( level.player.origin, level.player.angles );
        var_2[var_7] setgoalpos( level.player.origin );
    }
}

kill_path_on_death()
{
    wait_to_kill_path();
    self notify( "newpath" );
}

wait_to_kill_path()
{
    self endon( "death" );
    self endon( "driver dead" );
    level waittill( "eternity" );
}

disable_awareness()
{
    self.ignoreall = 1;
    self.dontmelee = 1;
    self.ignoresuppression = 1;
    self.suppressionwait_old = self.suppressionwait;
    self.suppressionwait = 0;
    maps\_utility::disable_surprise();
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_bulletwhizbyreaction();
    maps\_utility::disable_pain();
    self.grenadeawareness = 0;
    self.ignoreme = 1;
    maps\_utility::enable_dontevershoot();
    self.disablefriendlyfirereaction = 1;
    self.dodangerreact = 0;
}

enable_awareness()
{
    self.ignoreall = 0;
    self.dontmelee = undefined;
    self.ignoresuppression = 0;
    self.suppressionwait = self.suppressionwait_old;
    self.suppressionwait_old = undefined;
    maps\_utility::enable_surprise();
    self.ignorerandombulletdamage = 0;
    maps\_utility::enable_bulletwhizbyreaction();
    maps\_utility::enable_pain();
    self.grenadeawareness = 1;
    self.ignoreme = 0;
    maps\_utility::disable_dontevershoot();
    self.disablefriendlyfirereaction = undefined;
    self.dodangerreact = 1;
}

hide_friendname_until_flag_or_notify( var_0 )
{
    if ( !isdefined( self.name ) )
        return;

    level.player endon( "death" );
    self endon( "death" );
    self.old_name = self.name;
    self.name = " ";
    level waittill( var_0 );
    self.name = self.old_name;
}

ignore_badplace( var_0, var_1 )
{
    self endon( "death" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_wait( var_0 );

    self.old_bp_awareness = self.badplaceawareness;
    self.badplaceawareness = 0;

    if ( isdefined( var_1 ) )
    {
        common_scripts\utility::flag_wait( var_1 );
        self.badplaceawareness = self.old_bp_awareness;
    }
}

print3duntilnotify( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( var_5 );

    for (;;)
        wait 0.05;
}

printorigin3duntilnotify( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( var_4 );

    for (;;)
        wait 0.05;
}

delete_on_notify( var_0 )
{
    level waittill( var_0 );
    self delete();
}

run_thread_on_notify( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) )
        self endon( var_2 );

    self waittill( var_1 );
    self thread [[ var_0 ]]();
}

hint_button_string_lookup_fus( var_0 )
{
    switch ( var_0 )
    {
        case "activate":
        case "usereload":
        case "use":
        case "reload":
        case "x":
            return "^3[{+activate}]^7";
        case "gostand":
        case "jump":
        case "a":
            return "^3[{+gostand}]^7";
        case "weapnext":
        case "y":
            return "^3[{weapnext}]^7";
        case "stance":
        case "crouch":
        case "b":
            return "^3[{+stance}]^7";
        case "melee":
            return "^3[{+melee}]^7";
        case "pause":
        case "start":
            return "^3[{pause}]^7";
        default:
            break;
    }
}

hint_button_clear_fus()
{
    if ( isdefined( self.deleteobjectwhendone ) && self.deleteobjectwhendone )
        self.object delete();

    self destroy();
}

point_is_in_screen_circle( var_0, var_1, var_2 )
{
    return vectordot( vectornormalize( var_0 - var_1 geteye() ), anglestoforward( var_1 getangles() ) ) > cos( var_2 );
}

player_in_mt()
{
    return isdefined( level.player.drivingvehicleandturret );
}

is_sonar_vision_allowed()
{
    var_0 = level.player getcurrentweapon();

    if ( weaponhasthermalscope( var_0 ) && level.player playerads() > 0 )
        return 0;

    return 1;
}

disable_sonar_when_not_allowed()
{
    level.player endon( "sonar_vision_off" );

    for (;;)
    {
        if ( !is_sonar_vision_allowed() )
            break;

        waitframe();
    }

    sonar_off();
}

thermal_with_nvg()
{
    level endon( "flag_end_sonar_vision" );
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;

    for (;;)
    {
        self waittill( "sonar_vision" );

        if ( !is_sonar_vision_allowed() )
            continue;

        if ( !isdefined( level.player.sonar_vision ) || !level.player.sonar_vision )
        {
            sonar_on();
            childthread disable_sonar_when_not_allowed();
            continue;
        }

        sonar_off();
    }
}

sonar_save_and_set_dvars()
{
    if ( !isdefined( level.player.sonarvisionsaveddvars ) )
        level.player.sonarvisionsaveddvars = [];

    level.player.sonarvisionsaveddvars["r_hudoutlineenable"] = getdvarint( "r_hudoutlineenable", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] = getdvar( "r_hudoutlinepostmode", 0 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] = getdvarfloat( "r_hudoutlinehaloblurradius", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] = getdvarfloat( "r_hudoutlinehalolumscale", 1 );
    level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] = getdvar( "r_hudoutlinehalowhen", 1 );
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.7 );
    setsaveddvar( "r_hudoutlinehalolumscale", 2 );
    setsaveddvar( "r_hudoutlinehalowhen", 0 );
    level.player.sonarvisionsaveddvars["r_ssrBlendScale"] = getdvarfloat( "r_ssrBlendScale", 1.0 );
    setsaveddvar( "r_ssrBlendScale", 0.0 );
}

sonar_reset_dvars()
{
    if ( isdefined( level.player.sonarvisionsaveddvars ) )
    {
        setsaveddvar( "r_hudoutlineenable", level.player.sonarvisionsaveddvars["r_hudoutlineenable"] );
        setsaveddvar( "r_hudoutlinepostmode", level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] );
        setsaveddvar( "r_hudoutlinehaloblurradius", level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] );
        setsaveddvar( "r_hudoutlinehalolumscale", level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] );
        setsaveddvar( "r_hudoutlinehalowhen", level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] );
        setsaveddvar( "r_ssrBlendScale", level.player.sonarvisionsaveddvars["r_ssrBlendScale"] );
    }
}

sonar_on()
{
    level.overlaysonar = create_hud_sonar_overlay( 0, 1 );
    sonar_save_and_set_dvars();
    thread mark_enemies();
    var_0 = 0.05;
    level.player lightsetoverrideenableforplayer( "sanfran_b_sonar_vision", var_0 );
    level.player setclutoverrideenableforplayer( "clut_sonar", var_0 );
    soundscripts\_snd::snd_message( "aud_sonar_vision_on" );
    level.player.sonar_vision = 1;
    level notify( "sonar_update" );
}

sonar_off()
{
    var_0 = 0.05;
    level.player lightsetoverrideenableforplayer( var_0 );
    level.player setclutoverridedisableforplayer( var_0 );
    soundscripts\_snd::snd_message( "aud_sonar_vision_off" );
    level.player.sonar_vision = 0;
    level notify( "sonar_update" );

    if ( isdefined( level.overlay ) )
        level.overlay destroy();

    if ( isdefined( level.overlaythreat ) )
        level.overlaythreat destroy();

    if ( isdefined( level.overlaysonar ) )
        level.overlaysonar destroy();

    sonar_reset_dvars();

    foreach ( var_2 in getaiarray( "axis", "allies" ) )
    {
        if ( isdefined( var_2.hudoutlineenabledbysonarvision ) )
        {
            var_2 hudoutlinedisable();
            var_2.hudoutlineenabledbysonarvision = undefined;
        }
    }

    level.player notify( "sonar_vision_off" );
}

mark_enemies()
{
    level.player endon( "sonar_vision_off" );

    for (;;)
    {
        foreach ( var_1 in getaiarray( "axis" ) )
        {
            var_1 hudoutlineenable( 1, 1, 0 );
            var_1.hudoutlineenabledbysonarvision = 1;
        }

        foreach ( var_4 in getaiarray( "allies" ) )
        {
            var_4 hudoutlineenable( 2, 1, 0 );
            var_4.hudoutlineenabledbysonarvision = 1;
        }

        wait 0.1;
    }
}

create_hud_sonar_overlay( var_0, var_1 )
{
    var_2 = newhudelem();
    var_2.x = 0;
    var_2.y = 0;

    if ( level.currentgen )
        var_2.color = ( 1, 0.6, 0.2 );
    else
        var_2.color = ( 0.1, 0.1, 1 );

    var_2.sort = var_0;
    var_2.horzalign = "fullscreen";
    var_2.vertalign = "fullscreen";
    var_2.alpha = var_1;
    var_2 setsonarvision( 10 );
    return var_2;
}

should_end_sonar_hint()
{
    return isdefined( level.player.sonar_vision ) && level.player.sonar_vision;
}

should_end_pdrone_hint()
{
    if ( common_scripts\utility::flag( "turbine_room_stop_combat" ) || common_scripts\utility::flag( "flag_player_using_drone" ) )
        return 1;
    else
        return 0;
}

should_end_pdrone_fail_hint()
{
    if ( common_scripts\utility::flag( "turbine_room_stop_combat" ) || common_scripts\utility::flag( "flag_player_using_drone" ) )
        return 1;
    else
        return 0;
}

spawn_player_drone_think()
{
    level endon( "turbine_room_stop_combat" );

    for (;;)
    {
        level.player waittill( "use_drone" );

        while ( level.player isjumping() )
            waitframe();

        if ( deploy_check_player_in_elevator_think() )
            break;
        else
        {
            wait 0.25;
            maps\_utility::hintdisplaymintimehandler( "drone_deploy_fail_prompt", 2 );
            wait 1.0;

            if ( common_scripts\utility::flag( "drone_deploy_prompt_displayed" ) )
                maps\_utility::hintdisplaymintimehandler( "drone_deploy_prompt", 8 );
        }
    }

    if ( common_scripts\utility::flag( "player_drone_attack_done" ) == 0 )
    {
        common_scripts\utility::flag_set( "player_drone_start" );
        level notify( "player_drone_start" );
        thread spawn_turbine_enemies_tidal_wave();
        thread force_exit_turbine_combat_complete();
        common_scripts\utility::flag_set( "flag_player_using_drone" );
        thread player_drone_manager();
    }
}

deploy_check_player_in_elevator_think()
{
    var_0 = undefined;

    if ( common_scripts\utility::flag( "player_is_in_turbine_room" ) )
        return vehicle_scripts\_pdrone_player::pdrone_deploy_check( 70, undefined, 10 );
    else
        return vehicle_scripts\_pdrone_player::pdrone_deploy_check( 180, undefined, 40 );
}

spawn_turbine_enemies_tidal_wave()
{
    maps\_utility::activate_trigger( "turbine_room_combat_spawn_trigger", "script_noteworthy" );
    common_scripts\utility::flag_set( "turbine_room_all_enemies" );
}

player_drone_manager()
{
    common_scripts\utility::flag_set( "player_drone_start" );
    level notify( "player_drone_start" );
    level.player setweaponhudiconoverride( "actionslot1", "dpad_icon_drone_off" );
    maps\_player_exo::player_exo_deactivate();
    player_drone_control();
    maps\_player_exo::player_exo_activate();
    common_scripts\utility::flag_clear( "flag_player_using_drone" );
    common_scripts\utility::flag_set( "player_drone_attack_done" );
}

player_drone_control()
{
    var_0 = getent( "pdrone_player_spawner", "targetname" );
    var_1 = common_scripts\utility::getstruct( "pdrone_turbine_in_elevator_safe_spawn", "targetname" );

    if ( common_scripts\utility::flag( "player_is_in_turbine_room" ) )
        var_2 = vehicle_scripts\_pdrone_player::pdrone_deploy( var_0, 0, var_1 );
    else
        var_2 = vehicle_scripts\_pdrone_player::pdrone_deploy( var_0, 0 );

    vehicle_scripts\_pdrone_player::pdrone_player_use( var_2, "player_drone_airspace_turbine", undefined, undefined );
    var_2 vehicle_scripts\_pdrone_player::pdrone_player_add_vehicle_target( "script_noteworthy", "training_s2_patio_vehicles" );
    thread maps\fusion_lighting::setup_lighting_fly_drone_turbine();
    level.player.drone = var_2;
    var_2 vehicle_scripts\_pdrone_player::pdrone_player_enter( 1 );
    soundscripts\_snd::snd_message( "rec_player_drone_start", var_2 );
    var_2 vehicle_scripts\_pdrone_player::pdrone_player_loop();
    soundscripts\_snd::snd_message( "rec_player_drone_end" );
    thread maps\fusion_lighting::setup_lighting_fly_drone_off_turbine();
    var_2 vehicle_scripts\_pdrone_player::pdrone_player_exit( 1 );
    var_2 delete();
}

force_exit_turbine_combat_complete()
{
    waittillframeend;
    var_0 = getaiarray( "axis" );
    maps\_utility::waittill_dead_or_dying( var_0 );
    common_scripts\utility::flag_set( "flag_turbine_pdrone_combat_complete" );
    wait 2.0;
    level.player.drone vehicle_scripts\_pdrone_player::pdrone_player_force_exit();
}
