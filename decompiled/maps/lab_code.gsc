// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

setup_spawn_functions()
{
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_building_wave_01", ::research_building_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_building_wave_02", ::research_building_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_pool_building_wave_01", ::pool_building_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_bridge_wave_01", ::facility_bridge_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_pool_building_walkway_wave_01", ::pool_building_walkway_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_pool_building_walkway_wave_02", ::pool_building_walkway_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_left_01", ::research_left_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_left_lower_01", ::research_left_lower_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_right_lower_01", ::research_right_lower_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_platform_01", ::research_platform_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_research_right_01", ::research_right_01_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_pool_building_wave_02", ::pool_building_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_initial", ::courtyard_enemy_initial_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_jammer", ::courtyard_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_jammer_complete", ::courtyard_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_jammer_ladder", ::courtyard_jammer_ladder_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_sniper_fodder", ::courtyard_enemy_sniper_fodder_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_foam_corridor_b", ::foam_corridor_enemy_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_general_01", ::combat_courtyard_general_01_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_left_00", ::combat_courtyard_path_left_00_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_left_01", ::combat_courtyard_path_left_01_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_left_02", ::combat_courtyard_path_left_02_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_left_03", ::combat_courtyard_path_left_03_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_middle_01", ::combat_courtyard_path_middle_01_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_middle_02", ::combat_courtyard_path_middle_02_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_middle_03", ::combat_courtyard_path_middle_03_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_right_01", ::combat_courtyard_path_right_01_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_right_02", ::combat_courtyard_path_right_02_think );
    maps\_utility::array_spawn_function_targetname( "combat_courtyard_path_right_03", ::combat_courtyard_path_right_03_think );
    maps\_utility::array_spawn_function_noteworthy( "guy_01_seeker", ::patrol_01_unload_spawn_func );
    maps\_utility::array_spawn_function_noteworthy( "guy_02_seeker", ::patrol_02_unload_spawn_func );
    maps\_utility::array_spawn_function_noteworthy( "guy_03_seeker", ::patrol_03_unload_spawn_func );
    maps\_utility::array_spawn_function_noteworthy( "guy_04_seeker", ::patrol_04_unload_spawn_func );
    maps\_utility::array_spawn_function_noteworthy( "enemy_stealth_patrol_01", ::set_flag_on_death, "flag_patroler_01_clear_a", "flag_patroler_takedown_02_follow_a", "flag_patroler_takedown_02_follow_b", "flag_patroler_takedown_02_ready" );
    maps\_utility::array_spawn_function_noteworthy( "enemy_stealth_patrol_02", ::set_flag_on_death, "flag_patroler_01_clear_b", "flag_patrol_02_clear_for_vehicle_takedown" );
    maps\_utility::array_spawn_function_noteworthy( "combat_mech_march_05", ::set_flag_on_death, "flag_mech_march_hide_right_complete", "flag_mech_march_hide_right" );
    maps\_utility::array_spawn_function_noteworthy( "enemy_post_breach_patrol_01", ::set_flag_on_death, "flag_breach_patrol_01_clear", "flag_breach_patrol_01_dead" );
    maps\_utility::array_spawn_function_noteworthy( "enemy_post_breach_patrol_02", ::set_flag_on_death, "flag_breach_patrol_02_dead" );
    maps\_utility::array_spawn_function_noteworthy( "combat_mech_march_follower", ::mech_march_follower_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "combat_mech_march_runner", ::mech_march_runner_enemy_think );
    common_scripts\utility::array_thread( getentarray( "trigger_set_and_clear_flag", "script_noteworthy" ), maps\lab_utility::trigger_set_and_clear_flag_think );
    maps\_utility::add_global_spawn_function( "axis", ::add_drone_to_squad );
    common_scripts\utility::array_thread( getentarray( "helo_spotlight_shoot_trigger", "script_noteworthy" ), ::helo_spotlight_shoot_trigger_think );
    common_scripts\utility::array_thread( getentarray( "camera_scanner_interior_trigger", "script_noteworthy" ), maps\lab_vo::camera_scanner_interior_trigger_think );
}

player_damage_check()
{
    for (;;)
    {
        level.player waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
        iprintlnbold( "Damage Type: " + var_4 );
        waitframe();
    }
}

spawn_ai_flashlight()
{
    maps\_flashlight_cheap::add_cheap_flashlight();
}

equip_player()
{
    setsaveddvar( "bg_viewBobAmplitudeStanding", "0.007 0.007" );
    maps\_variable_grenade::give_player_variable_grenade();
    maps\_player_exo::player_exo_add_single( "exo_melee" );

    if ( common_scripts\utility::flag( "flag_obj_bio_weapons_hack" ) )
        thread maps\_cloak::disable_cloak_system();
}

debug_start_equip_player()
{
    level.player takeweapon( "iw5_unarmed_nullattach" );
    level.player giveweapon( "iw5_hbra3_sp_silencer01_variablereddot" );
    level.player givemaxammo( "iw5_hbra3_sp_silencer01_variablereddot" );
    level.player switchtoweapon( "iw5_hbra3_sp_silencer01_variablereddot" );
}

equip_player_smg()
{
    setsaveddvar( "bg_viewBobAmplitudeStanding", "0.007 0.007" );
    level.player takeweapon( "iw5_unarmed_nullattach" );
    level.player giveweapon( "iw5_hbra3_sp" );
    level.player switchtoweapon( "iw5_hbra3_sp" );
}

lab_intro_screen()
{
    level.player disableweapons();
    level.player freezecontrols( 1 );
    var_0 = 8.4;
    thread maps\_shg_utility::play_chyron_video( "chyron_text_biolab", 8.4 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    soundscripts\_snd::snd_message( "aud_lab_intro_screen" );
    wait(var_0);
    common_scripts\utility::flag_set( "flag_escape_the_sniper_obj_give" );
    common_scripts\utility::flag_set( "lab_intro_screen_complete" );
    soundscripts\_snd::snd_message( "hud_malfunction" );
}

startcloakingbinksequence()
{
    common_scripts\utility::flag_wait( "lab_intro_screen_complete" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    common_scripts\utility::flag_wait( "flag_burke_dive_over_log" );
    common_scripts\utility::flag_wait( "flag_player_enters_forest" );
    stopcinematicingame();
    cinematicingame( "cloaking_hud_reboot" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on" );
    stopcinematicingame();
    cinematicingame( "cloaking_hud_ready" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );
    stopcinematicingame();
}

startcloakingbinksequence_debug()
{
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    common_scripts\utility::flag_wait( "flag_player_enters_forest" );
    stopcinematicingame();
    cinematicingame( "cloaking_hud_reboot" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on" );
    stopcinematicingame();
    cinematicingame( "cloaking_hud_ready" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );
    stopcinematicingame();
}

player_movement_tweaks()
{
    maps\_utility::player_speed_percent( 80, 1 );
    level.player takeweapon( "fraggrenade" );
    level.player takeweapon( "flash_grenade" );
    setsaveddvar( "bg_viewbobamplitudestanding", "0.03 0.02" );
    setsaveddvar( "player_sprintunlimited", "1" );
    common_scripts\utility::flag_wait( "flag_player_enters_forest" );
    setsaveddvar( "player_sprintunlimited", "0" );
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    maps\_utility::player_speed_percent( 100, 1 );
}

helo_spotlight_init()
{
    if ( isdefined( level.start_point ) && level.start_point == "forest_start" )
    {
        var_0 = getent( "helo_spotlight", "targetname" );
        var_0.origin = common_scripts\utility::getstruct( "path_helo_river_path_start", "targetname" ).origin;
    }

    level.helo_spotlight = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "helo_spotlight" );
    level.helo_spotlight maps\_vehicle::godon();
    level.helo_spotlight maps\_utility::ent_flag_init( "spotlight_on" );
    level.helo_spotlight soundscripts\_snd::snd_message( "aud_helo_spotlight_spawn" );
    level.helo_spotlight.spotlight = spawnturret( "misc_turret", level.helo_spotlight gettagorigin( "tag_flash" ), "heli_spotlight_so_castle" );
    level.helo_spotlight.spotlight setmode( "manual" );
    level.helo_spotlight.spotlight setmodel( "com_blackhawk_spotlight_on_mg_setup" );
    level.helo_spotlight.spotlight maketurretinoperable();
    level.helo_spotlight.spotlight makeunusable();
    level.helo_spotlight.spotlight.angles = level.helo_spotlight gettagangles( "tag_flash" );
    level.helo_spotlight.spotlight linkto( level.helo_spotlight, "tag_flash", ( 0, 2, -6 ), ( 0, 90, -20 ) );
    level.helo_spotlight thread helo_spotlight_think();
    level.helo_spotlight setlookatent( level.burke );
    level.helo_spotlight maps\_vehicle::mgoff();
    common_scripts\utility::flag_wait( "flag_helo_spotlight_on" );
    level.helo_spotlight maps\_utility::ent_flag_set( "spotlight_on" );
}

helo_spotlight_handle_intro_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 0.9;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.6, 0.2 );
    wait 1.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.2 );
    wait 3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.2 );
    wait 3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.2 );
    wait 4.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 1.75 );
}

helo_spotlight_movement()
{
    common_scripts\utility::flag_wait( "flag_helo_spotlight_path_02" );
    level.helo_spotlight maps\_utility::vehicle_detachfrompath();
    var_0 = common_scripts\utility::getstruct( "path_helo_spotlight_02_start", "targetname" );
    level.helo_spotlight thread maps\_utility::vehicle_dynamicpath( var_0, 0 );
    common_scripts\utility::flag_wait( "flag_helo_spotlight_path_03" );
    level.helo_spotlight maps\_utility::vehicle_detachfrompath();
    level.helo_spotlight vehicle_setspeed( 60, 30, 25 );
    var_0 = common_scripts\utility::getstruct( "path_helo_spotlight_03_start", "targetname" );
    level.helo_spotlight thread maps\_utility::vehicle_dynamicpath( var_0, 0 );
    common_scripts\utility::flag_wait( "flag_player_enters_forest" );
    level.helo_spotlight thread helo_spotlight_forest_think();
    level.helo_spotlight maps\_utility::vehicle_detachfrompath();
    var_0 = common_scripts\utility::getstruct( "path_helo_river_path_start", "targetname" );
    level.helo_spotlight thread maps\_utility::vehicle_dynamicpath( var_0, 0 );
    common_scripts\utility::flag_wait( "flag_helo_arrived_at_crash" );
    level.helo_spotlight maps\_utility::vehicle_land();
    level.helo_spotlight.spotlight delete();
    level.helo_spotlight delete();
}

helo_spotlight_think( var_0 )
{
    self endon( "death" );
    self notify( "stop_helo_spotlight" );
    self endon( "stop_helo_spotlight" );
    thread helo_spotlight_light_motion();
    var_1 = 0;
    var_2 = "docks_heli_spotlight";

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    for (;;)
    {
        if ( !maps\_utility::ent_flag( "spotlight_on" ) )
        {
            if ( var_1 )
            {
                var_1 = 0;
                stopfxontag( common_scripts\utility::getfx( var_2 ), self.spotlight, "tag_flash" );
                stopfxontag( common_scripts\utility::getfx( "lab_heli_spot_flare" ), self.spotlight, "tag_flash" );
            }

            var_3 = level.player;

            if ( isdefined( var_3 ) )
                self.spotlight settargetentity_smoothtracking( var_3 );

            wait 0.2;
            continue;
        }

        wait 0.5;

        if ( !var_1 )
        {
            var_1 = 1;
            playfxontag( common_scripts\utility::getfx( var_2 ), self.spotlight, "tag_flash" );
            playfxontag( common_scripts\utility::getfx( "lab_heli_spot_flare" ), self.spotlight, "tag_flash" );
        }
    }
}

helo_spotlight_light_motion()
{
    self endon( "stop_helo_spotlight" );
    self endon( "death" );

    for (;;)
    {
        var_0 = undefined;

        if ( isdefined( self.override_target ) )
        {
            self.spotlight settargetentity_smoothtracking( self.override_target );

            while ( isdefined( self.override_target ) )
                wait 0.5;

            continue;
        }
        else
        {
            var_1 = [ level.player, level.burke ];
            var_0 = level.burke;

            if ( isdefined( var_0 ) && !common_scripts\utility::flag( "flag_player_enters_forest" ) )
                self.spotlight settargetentity_smoothtracking( var_0 );
            else
            {

            }
        }

        if ( isdefined( var_0 ) && isai( var_0 ) )
        {
            var_2 = randomfloatrange( 1, 2.5 ) * 1000;
            var_3 = gettime() + var_2;

            while ( gettime() < var_3 )
            {
                if ( !isdefined( var_0 ) || !isalive( var_0 ) )
                    break;

                wait 0.1;
            }

            continue;
        }

        wait(randomfloatrange( 3, 5 ));
    }
}

helo_spotlight_climbing_moment( var_0, var_1 )
{
    var_2 = gettime() / 1000;
    var_3 = 100;

    while ( !common_scripts\utility::flag( "flag_player_wall_look_right" ) )
    {
        var_4 = 1 - ( gettime() / 1000 - var_2 ) / var_0;
        var_1.origin = level.player.origin + ( 1000 * var_4 + var_3, 0, 0 );
        wait 0.05;
    }

    while ( common_scripts\utility::flag( "flag_player_wall_look_right" ) )
    {
        var_4 = 1 - ( gettime() / 1000 - var_2 ) / var_0;
        var_1.origin = level.player.origin + ( 500 * var_4 + var_3, 0, 0 );
        wait 0.05;
    }

    while ( !common_scripts\utility::flag( "flag_player_cloak_on_pressed" ) )
    {
        var_4 = 1 - ( gettime() / 1000 - var_2 ) / var_0;
        var_1.origin = level.player.origin + ( 1000 * var_4 + var_3, 0, 0 );
        wait 0.05;
    }
}

helo_spotlight_forest_think()
{
    level endon( "helo_spotlight_point_of_no_return" );
    self clearlookatent();
    self.spotlight settargetentity_smoothtracking( undefined );
    self.spotlight noisy_turret_clear_default_angles();
    var_0 = 20;
    var_1 = gettime() / 1000;
    thread helo_spotlight_kill_player_unless_notify( var_0, "player_climbing_wall" );
    var_2 = spawn( "script_origin", level.player.origin );
    self.override_target = var_2;
    level thread maps\_utility::notify_delay( "helo_spotlight_stop_search", 15 );
    helo_spotlight_search_for_player( var_2 );
    var_3 = 200;
    var_2.origin = level.player.origin + ( 1500 + var_3, 0, 0 );

    while ( !common_scripts\utility::flag( "player_climbing_wall" ) )
    {
        var_4 = 1 - ( gettime() / 1000 - var_1 ) / var_0;
        var_2.origin = level.player.origin + ( 1500 * var_4 + var_3, 0, 0 );
        wait 0.05;
    }

    var_0 = 20;
    thread helo_spotlight_kill_player_unless_notify( var_0, "flag_player_climb_succeeded" );
    thread helo_spotlight_climbing_moment( var_0, var_2 );
    common_scripts\utility::flag_wait( "flag_player_climb_succeeded" );
    var_0 = 15;
    thread helo_spotlight_kill_player_unless_notify( var_0, "flag_player_cloak_on_pressed" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );
    var_4 = 0;
    var_1 = gettime() / 1000;
    var_0 = 20;
    var_3 = 215;

    while ( var_4 < 1 )
    {
        var_4 = ( gettime() / 1000 - var_1 ) / var_0;
        var_2.origin = level.player.origin + ( -1000 * var_4 + var_3, 0, 0 );
        wait 0.05;
    }

    self.override_target = undefined;
    self notify( "stop_helo_spotlight" );
    self.spotlight.real_target = undefined;
    self.spotlight noisy_turret_set_default_angles( ( 25, -90, -20 ) );
}

helo_spotlight_search_for_player( var_0 )
{
    level endon( "helo_spotlight_stop_search" );
    level endon( "player_climbing_wall" );
    var_1 = 0.5;
    var_2 = 1;
    var_3 = common_scripts\utility::getstructarray( "helo_spotlight_search_loc", "targetname" );

    for (;;)
    {
        var_0.origin = var_3[randomint( var_3.size )].origin;
        self.spotlight common_scripts\utility::waittill_notify_or_timeout( "turret_on_target", 1 );
        wait(randomfloatrange( var_1, var_2 ));
    }
}

helo_spotlight_kill_player_unless_notify( var_0, var_1 )
{
    level endon( var_1 );
    wait(var_0);
    level notify( "helo_spotlight_point_of_no_return" );
    self.override_target.origin = level.player geteye();
    var_2 = getent( "climb_wall_use_trigger", "targetname" );

    if ( isdefined( var_2 ) )
        var_2 delete();

    level.player endon( "death" );
    level.player enablehealthshield( 0 );

    if ( common_scripts\utility::flag( "player_climbing_wall" ) )
        thread knock_player_off_wall();

    for (;;)
    {
        helo_spotlight_shoot_location( level.player geteye() + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) );
        level.player dodamage( level.player.maxhealth / 3, level.helo_spotlight.origin, level.helo_spotlight );
        wait(randomfloatrange( 0.5, 1 ));
    }
}

knock_player_off_wall()
{
    common_scripts\utility::flag_set( "flag_cloak_fail_kill_player" );
    level.player waittill( "death" );
    level notify( "player_falling_to_death" );
    earthquake( 0.2, 3, level.player.origin, 8000 );
    var_0 = 0.4;
    var_1 = spawn( "script_origin", level.player.origin );
    var_1.angles = level.player getgunangles();
    var_1 moveto( common_scripts\utility::getstruct( "obj_forest_climb_wall_fall_loc", "targetname" ).origin, var_0, var_0 );
    level.player playerlinktoblend( var_1, undefined, var_0 );
    level.player_rig delete();
    wait(var_0);
    level.player unlink();
}

player_falling_kill_logic( var_0 )
{
    var_1 = int( tablelookup( "sp/deathquotetable.csv", 1, "size", 0 ) );
    var_2 = randomint( var_1 );

    if ( !isdefined( var_0 ) )
        var_0 = 3;

    common_scripts\utility::flag_clear( "can_save" );
    var_3 = gettime() + var_0 * 1000;

    while ( !level.player isonground() && gettime() < var_3 )
        wait 0.05;

    if ( level.player isonground() )
        level.player kill();
    else
        maps\_utility::missionfailedwrapper();
}

settargetentity_smoothtracking( var_0 )
{
    self.real_target = var_0;

    if ( isdefined( var_0 ) )
    {
        if ( !isdefined( self.spotlight_target ) )
            self.spotlight_target = common_scripts\utility::spawn_tag_origin();

        self.spotlight_target.origin = var_0.origin;
        self.spotlight_target linkto( self );
        self settargetentity( self.spotlight_target );
        thread noisy_turret_think();
    }
}

noisy_turret_set_default_angles( var_0 )
{
    self.no_target_local_spotlight_angles = var_0;
}

noisy_turret_clear_default_angles()
{
    self.no_target_local_spotlight_angles = undefined;
}

noisy_turret_think()
{
    self notify( "stop_noisy_turret_think" );
    self endon( "stop_noisy_turret_think" );
    self endon( "death" );

    if ( !isdefined( self.cur_local_angles ) )
    {
        self.cur_local_angles = ( 0, 0, 0 );
        self.self_to_target_local_angles = ( 0, 0, 0 );
        self.pitch_rate = 0;
        self.yaw_rate = 0;
        self.last_pitch_noise = 0;
        self.last_yaw_noise = 0;
    }

    var_0 = 0.05;

    for (;;)
    {
        waittillframeend;
        waittillframeend;

        if ( isdefined( self.real_target ) && isdefined( self.real_target.origin ) )
        {
            var_1 = self.real_target.origin;

            if ( isai( self.real_target ) )
                var_1 += ( 0, 0, 32 );

            if ( isplayer( self.real_target ) )
                var_1 += ( 0, 0, 32 );

            var_2 = transformmove( ( 0, 0, 0 ), ( 0, 0, 0 ), self.origin, self.angles, var_1, ( 0, 0, 0 ) )["origin"];
            var_3 = vectornormalize( var_2 );
            self.self_to_target_local_angles = vectortoangles( var_3 );
        }
        else if ( isdefined( self.no_target_local_spotlight_angles ) )
            self.self_to_target_local_angles = self.no_target_local_spotlight_angles;

        var_5 = angleclamp180( self.self_to_target_local_angles[0] - self.cur_local_angles[0] );
        var_6 = angleclamp180( self.self_to_target_local_angles[1] - self.cur_local_angles[1] );
        var_7 = 180;
        var_8 = 180;
        var_9 = length( ( var_5, var_6, 0 ) );

        if ( var_9 < 10 )
        {
            var_10 = max( var_9 / 10, 0.7 );
            var_7 *= var_10;
            var_8 *= var_10;
        }

        if ( abs( angleclamp180( self.cur_local_angles[0] ) ) < 89 )
        {
            var_10 = min( 1 / cos( self.cur_local_angles[0] ), 3 );
            var_8 *= var_10;
        }

        var_5 = clamp( var_5, -1 * var_7 * var_0, var_7 * var_0 );
        var_6 = clamp( var_6, -1 * var_8 * var_0, var_8 * var_0 );
        var_5 = maps\_utility::linear_interpolate( 0.8, var_5, self.pitch_rate * var_0 * 0.8 );
        var_6 = maps\_utility::linear_interpolate( 0.8, var_6, self.yaw_rate * var_0 * 0.8 );
        self.pitch_rate = var_5 / var_0;
        self.yaw_rate = var_6 / var_0;
        var_11 = gettime() * 0.001 * 1.5;
        var_12 = perlinnoise2d( 0, var_11, 2, 2, 1 ) * 0.5;
        var_13 = perlinnoise2d( 1.5, var_11, 2, 2, 1 ) * 1.5;
        var_5 += var_12 - self.last_pitch_noise;
        var_6 += var_13 - self.last_yaw_noise;
        self.last_pitch_noise = var_12;
        self.last_yaw_noise = var_13;
        self.cur_local_angles += ( var_5, var_6, 0 );
        var_14 = anglestoforward( self.cur_local_angles );
        var_15 = var_14 * 1000;
        var_16 = transformmove( self.origin, self.angles, ( 0, 0, 0 ), ( 0, 0, 0 ), var_15, ( 0, 0, 0 ) )["origin"];
        self.spotlight_target unlink();
        self.spotlight_target.origin = var_16;
        self.spotlight_target linkto( self );
        wait(var_0);
    }
}

se_intro()
{
    thread lab_intro_screen();
    common_scripts\utility::flag_wait( "chyron_video_done" );
    thread helo_spotlight_handle_intro_rumbles();
    thread helo_spotlight_init();
    thread helo_spotlight_movement();
    common_scripts\utility::flag_wait( "lab_intro_screen_complete" );
    setsaveddvar( "ammoCounterHide", "1" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    level.player thread player_run_rumble();
    var_0 = maps\_utility::spawn_anim_model( "player_rig_intro" );
    var_0.weapon = "none";
    var_0 dontcastshadows();
    var_1 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 = common_scripts\utility::getstruct( "intro_anim_org", "targetname" );
    var_1.origin = var_2.origin;

    if ( isdefined( var_2.angles ) )
        var_1.angles = var_2.angles;

    level.player playerlinktodelta( var_0, "tag_player", 1, 0, 0, 0, 0, 1 );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "intro_recover" );
    var_1 maps\_anim::anim_first_frame_solo( level.burke, "intro_recover" );
    maps\_utility::delaythread( 0.5, ::helo_spotlight_shoot_struct, "intro_anim_bullet_dest" );
    var_1 thread burke_intro_anim( level.burke, "intro_recover" );
    var_1 thread maps\_anim::anim_single_solo( var_0, "intro_recover" );
    var_3 = getanimlength( var_0 maps\_utility::getanim( "intro_recover" ) );
    var_4 = gettime();

    for (;;)
    {
        if ( gettime() - var_4 >= var_3 * 1000 )
            break;

        common_scripts\utility::waittill_any_ents( level, "allow_player_control", var_1, "intro_recover" );

        if ( level.player getnormalizedmovement()[0] > 0.5 )
            break;

        if ( gettime() - var_4 >= var_3 * 1000 )
            break;

        wait 0.05;
    }

    level.player unlink();
    var_0 delete();
    level.player enableweapons();
    setsaveddvar( "player_sprintunlimited", "1" );
    level.player forcesprint();
    var_1 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    thread helo_sniper_threaten_player();
    common_scripts\utility::array_thread( getentarray( "player_run_progress_trigger", "script_noteworthy" ), ::player_run_progress_trigger_think );
}

player_run_rumble()
{
    var_0 = maps\_utility::get_rumble_ent( "steady_rumble" );
    var_1 = 0.05;
    var_2 = 0.25;

    while ( !common_scripts\utility::flag( "flag_player_enters_forest" ) )
    {
        var_3 = length( level.player getvelocity() );
        var_4 = var_3 / 320;
        var_0.intensity = var_4 * var_2;

        if ( var_0.intensity > 1 )
            var_0.intensity = 1;

        wait 0.1;
        var_0.intensity = var_4 * var_1;

        if ( var_0.intensity > 1 )
            var_0.intensity = 1;

        if ( var_3 > 0 )
            var_5 = 0.3 * ( 1 - var_3 / 194 );
        else
            var_5 = 0;

        var_6 = 0.3 + var_5;

        if ( var_6 > 0 )
            wait(var_6);
    }

    var_0 delete();
    stopallrumbles();
}

burke_intro_anim( var_0, var_1 )
{
    level.burke maps\_utility::gun_remove();
    level.burke maps\_utility::disable_pain();
    level.burke maps\_utility::disable_ai_color();
    soundscripts\_snd::snd_message( "aud_burke_intro_anim" );
    maps\_anim::anim_single_solo_run( var_0, var_1 );
    common_scripts\utility::flag_set( "flag_burke_intro_react_se_start" );
}

se_intro_burke_react()
{
    common_scripts\utility::flag_wait( "flag_burke_intro_react_se_start" );
    var_0 = common_scripts\utility::getstruct( "burke_intro_react_anim_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_intro_react" );
    maps\_utility::delaythread( 0.05, ::helo_spotlight_shoot_struct, "burke_intro_react_bullet_dest" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_intro_react" );
    common_scripts\utility::flag_set( "flag_burke_shack_se_start" );
}

se_intro_shack()
{
    common_scripts\utility::flag_wait( "flag_burke_shack_se_start" );
    var_0 = common_scripts\utility::getstruct( "burke_intro_shack_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "lab_shack_enter" );
    var_0 maps\_anim::anim_single_solo( level.burke, "lab_shack_enter" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "lab_shack_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_burke_dive_over_log" );
    soundscripts\_snd::snd_message( "aud_shack_explode_whizby" );
    wait 0.25;
    var_0 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    helo_spotlight_shoot_struct( "intro_shack_bullet_dest" );
    thread maps\lab_fx::shack_roof_damage_fx();
    thread shack_explode();
    var_1 = distance( level.player.origin, level.burke.origin );

    if ( var_1 < 200 )
        thread maps\lab_utility::rumble_heavy_1();
    else if ( var_1 < 500 )
        thread maps\lab_utility::rumble_light();

    var_0 maps\_anim::anim_single_run_solo( level.burke, "lab_shack_exit" );
}

shack_explode()
{
    maps\_utility::activate_trigger_with_targetname( "shack_explode" );
    soundscripts\_snd::snd_message( "player_reaches_shack" );
}

se_check_player_too_far_from_burke()
{
    while ( !common_scripts\utility::flag( "flag_helo_spotlight_path_02" ) )
    {
        if ( !maps\_utility::players_within_distance( 300, level.burke.origin ) )
            magicbullet( "s1_lab_heli_railgun_sp", level.helo_spotlight.origin, level.player );

        wait(randomfloatrange( 1, 2 ));
    }
}

se_slow_player_if_too_far_ahead()
{
    var_0 = common_scripts\utility::getstruct( "intro_shack_bullet_dest", "targetname" );
    var_1 = getent( "obj_forest_climb_wall", "targetname" );
    var_2 = 1;
    var_3 = 0.7;
    var_4 = 0.5;

    while ( !common_scripts\utility::flag( "flag_burke_dive_over_log" ) )
    {
        if ( distance2dsquared( level.player.origin, var_0.origin ) < distance2dsquared( level.burke.origin, var_0.origin ) )
        {
            while ( var_2 >= var_3 && distance2dsquared( level.player.origin, var_0.origin ) < distance2dsquared( level.burke.origin, var_0.origin ) )
            {
                var_2 -= 0.1;
                level.player setmovespeedscale( var_2 );
                wait(var_4);
            }

            while ( distance2dsquared( level.player.origin, var_0.origin ) < distance2dsquared( level.burke.origin, var_0.origin ) )
                waitframe();

            while ( var_2 < 1 )
            {
                var_2 += 0.1;
                level.player setmovespeedscale( var_2 );
                waitframe();
            }

            var_2 = 1;
            level.player setmovespeedscale( var_2 );
        }

        waitframe();
    }

    while ( !common_scripts\utility::flag( "flag_player_slide_start" ) )
    {
        if ( distance2dsquared( level.player.origin, var_1.origin ) < distance2dsquared( level.burke.origin, var_1.origin ) )
        {
            while ( var_2 >= var_3 && distance2dsquared( level.player.origin, var_1.origin ) < distance2dsquared( level.burke.origin, var_1.origin ) )
            {
                var_2 -= 0.1;
                level.player setmovespeedscale( var_2 );
                wait(var_4);
            }

            while ( distance2dsquared( level.player.origin, var_1.origin ) < distance2dsquared( level.burke.origin, var_1.origin ) )
                waitframe();

            while ( var_2 < 1 )
            {
                var_2 += 0.1;
                level.player setmovespeedscale( var_2 );
                waitframe();
            }

            var_2 = 1;
            level.player setmovespeedscale( var_2 );
        }

        waitframe();
    }
}

se_burke_stumble_run()
{
    var_0 = common_scripts\utility::getstruct( "burke_stumble_run_anim_org", "targetname" );

    if ( !common_scripts\utility::flag( "flag_helo_spotlight_path_02" ) )
    {
        var_0 maps\_anim::anim_reach_solo( level.burke, "burke_stumble_run" );
        maps\_utility::delaythread( 0.15, ::helo_spotlight_shoot_struct, "burke_stumble_run_bullet_dest" );
        level.burke soundscripts\_snd::snd_message( "aud_burke_stumble_run" );
        var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_stumble_run" );
    }

    common_scripts\utility::flag_set( "flag_emp_cocked_exo_dialogue" );
}

se_burke_dive_over_log()
{
    var_0 = common_scripts\utility::getstruct( "burke_dive_over_log_anim_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_dive_over_log" );
    maps\_utility::delaythread( 1.1, ::helo_spotlight_shoot_struct, "burke_dive_over_log_bullet_dest" );
    level.burke soundscripts\_snd::snd_message( "aud_burke_step_over_log" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_dive_over_log" );

    if ( maps\_utility::players_within_distance( 350, level.burke.origin ) )
        se_burke_stumble_knee();
    else
        se_burke_tree_cover_01();
}

se_burke_tree_cover_01()
{
    var_0 = common_scripts\utility::getstruct( "burke_tree_cover_01_anim_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_tree_cover_01" );
    maps\_utility::delaythread( 0.6, ::helo_spotlight_shoot_struct, "burke_tree_cover_01_bullet_dest_1" );
    level.burke soundscripts\_snd::snd_message( "aud_burke_tree_cover_01" );
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_tree_cover_01" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_tree_cover_01_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_helo_spotlight_path_02" );
    var_0 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    common_scripts\utility::flag_set( "flag_gogogo_dialogue_start" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_tree_cover_01_exit" );
}

se_burke_stumble_knee()
{
    maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "flag_gogogo_dialogue_start" );
}

se_burke_hill_slide()
{
    var_0 = common_scripts\utility::getstruct( "hill_slide_anim_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_hill_slide" );
    maps\_utility::delaythread( 2.6, ::helo_spotlight_shoot_struct, "hill_slide_bullet_dest_2" );

    if ( maps\_utility::players_within_distance( 400, level.burke.origin ) )
    {
        maps\_utility::delaythread( 0.25, ::se_player_hill_slide );
        common_scripts\utility::flag_set( "flag_burke_hill_slide_start" );
        level.burke soundscripts\_snd::snd_message( "burke_hill_slide", "anim_02" );
        var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_hill_slide_alt" );
    }
    else
    {
        maps\_utility::delaythread( 2, ::se_player_hill_slide );
        common_scripts\utility::flag_set( "flag_burke_hill_slide_start" );
        level.burke soundscripts\_snd::snd_message( "burke_hill_slide", "anim_01" );
        var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_hill_slide" );
    }

    if ( maps\_utility::players_within_distance( 400, level.burke.origin ) )
    {
        common_scripts\utility::flag_set( "flag_run_dialogue_start" );
        se_burke_river_over_log();
    }
    else
    {
        se_burke_tree_stump();
        se_burke_river_over_log();
    }
}

se_player_hill_slide()
{
    common_scripts\utility::flag_wait( "flag_player_slide_start" );
    var_0 = common_scripts\utility::getstruct( "hill_slide_anim_org", "targetname" );
    soundscripts\_snd::snd_message( "aud_player_hill_slide" );
    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig dontcastshadows();
    level.player_rig hide();
    level.player freezecontrols( 1 );
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    level.player setstance( "stand" );
    var_0 maps\_anim::anim_first_frame_solo( level.player_rig, "player_hill_slide" );
    level.player playerlinktoblend( level.player_rig, "tag_player", 0.2 );
    wait 0.2;
    level.player playerlinktodelta( level.player_rig, "tag_player", 1, 20, 20, 20, 0 );
    level.player_rig common_scripts\utility::delaycall( 0.1, ::show );
    maps\_utility::delaythread( 2.85, ::helo_spotlight_shoot_struct, "hill_slide_bullet_dest_4" );
    var_0 thread maps\_anim::anim_single_solo( level.player_rig, "player_hill_slide" );
    thread handle_player_slide_rumbles();
    var_1 = getanimlength( level.player_rig maps\_utility::getanim( "player_hill_slide" ) );
    var_2 = gettime();

    for (;;)
    {
        if ( gettime() - var_2 >= var_1 * 1000 )
            break;

        common_scripts\utility::waittill_any_ents( level, "allow_player_control", var_0, "player_hill_slide" );

        if ( level.player getnormalizedmovement()[0] > 0.5 )
            break;

        if ( gettime() - var_2 >= var_1 * 1000 )
            break;

        wait 0.05;
    }

    level.player unlink();
    level.player freezecontrols( 0 );
    level.player enableweapons();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player forcesprint();
    setsaveddvar( "player_sprintunlimited", "1" );
    level.player_rig delete();
    level.player thread river_slow_movement_ai_think();
}

handle_player_slide_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 1.35;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.75, 0.5 );
    wait 0.6;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 2 );
    wait 2.1;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.5, 0.3 );
}

se_burke_tree_stump()
{
    var_0 = common_scripts\utility::getstruct( "burke_tree_stump_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_hill_slide_stump" );
    maps\_utility::delaythread( 0.4, ::helo_spotlight_shoot_struct, "burke_tree_stump_bullet_dest" );
    level.burke soundscripts\_snd::snd_message( "aud_burke_hill_slide_stump" );
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_hill_slide_stump" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "burke_hill_slide_stump_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_burke_cross_river" );
    var_0 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    common_scripts\utility::flag_set( "flag_run_dialogue_start" );

    if ( level.nextgen )
        var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_hill_slide_stump_exit" );
}

se_burke_river_over_log()
{
    var_0 = common_scripts\utility::getstruct( "burke_river_over_log_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_river_over_log" );
    level.burke soundscripts\_snd::snd_message( "aud_burke_river_over_log" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_river_over_log" );
}

se_burke_river_cross()
{
    thread se_wall_climb_roots();
    var_0 = common_scripts\utility::getstruct( "forest_climb_anim_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "burke_river_cross" );
    maps\_utility::delaythread( 0.6, ::helo_spotlight_shoot_struct, "river_cross_bullet_dest_1" );
    maps\_utility::delaythread( 5.05, ::helo_spotlight_shoot_struct, "river_cross_bullet_dest_3" );
    maps\_utility::delaythread( 10.35, ::helo_spotlight_shoot_struct, "river_cross_bullet_dest_5" );
    maps\_utility::delaythread( 12.6, ::helo_spotlight_shoot_struct, "river_cross_bullet_dest_6" );
    var_0 maps\_anim::anim_single_solo_run( level.burke, "burke_river_cross" );

    if ( maps\_utility::players_within_distance( 400, level.burke.origin ) )
        se_burke_river_to_wall( var_0 );
    else
    {
        se_burke_cover_tree_wave( var_0 );
        se_burke_tree_to_wall( var_0 );
    }
}

se_burke_river_to_wall( var_0 )
{
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_river_to_wall" );
}

se_burke_cover_tree_wave( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "forest_take_cover_wave_anim_org", "targetname" );
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_river_to_tree" );
    var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_forest_cover_tree_wave", "ender" );
    common_scripts\utility::flag_wait( "flag_player_enters_forest" );
    var_1 notify( "ender" );
}

se_burke_tree_to_wall( var_0 )
{
    var_0 maps\_anim::anim_single_solo( level.burke, "burke_tree_to_wall" );
}

helo_spotlight_shoot_struct( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    helo_spotlight_shoot_location( var_1.origin );
}

helo_spotlight_shoot_location( var_0 )
{
    if ( !isdefined( level.helo_spotlight ) )
        return;

    var_1 = get_helo_spotlight_bullet_origin( var_0 );
    magicbullet( "s1_lab_heli_railgun_sp", var_1, var_0 );
    playfx( common_scripts\utility::getfx( "heli_railgun_muzzleflash" ), var_1, var_0 - var_1 );
    soundscripts\_snd::snd_message( "chopper_sniper_shot", var_1, var_0 );

    if ( distancesquared( var_0, level.player.origin ) < 40000 )
    {
        common_scripts\utility::noself_delaycall( 0.1, ::earthquake, 0.5, 0.5, var_0, 200 );
        level.player common_scripts\utility::delaycall( 0.1, ::playrumbleonentity, "damage_light" );
    }
}

helo_spotlight_shoot_trigger_think()
{
    level endon( "flag_player_enters_forest" );
    self waittill( "trigger" );
    var_0 = 0;

    for (;;)
    {
        var_1 = level.player getgunangles();
        var_2 = level.player geteye();
        var_3 = var_2 + anglestoforward( var_1 ) * 150 + anglestoright( var_1 ) * randomintrange( -40, 40 );
        var_4 = bullettrace( var_2, var_3, 0 );
        var_5 = get_helo_spotlight_bullet_origin( var_4["position"] );

        if ( !maps\_utility::shot_endangers_any_player( var_5, var_4["position"] ) )
        {
            helo_spotlight_shoot_location( var_4["position"] );
            return;
        }

        wait 0.05;
    }
}

se_wall_climb_roots()
{
    var_0 = common_scripts\utility::getstruct( "forest_climb_anim_org", "targetname" );
    var_1 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_0.angles ) )
        var_1.angles = var_0.angles;

    level.wallclimb_roots = getent( "wallclimb_roots", "targetname" );
    level.wallclimb_roots.animname = "wallclimb_roots";
    level.wallclimb_roots maps\_utility::assign_animtree();
    var_1 maps\_anim::anim_first_frame_solo( level.wallclimb_roots, "burke_wall_climb" );
}

se_burke_forest_wall_climb()
{
    var_0 = common_scripts\utility::getstruct( "forest_climb_anim_org", "targetname" );
    var_1 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_0.angles ) )
        var_1.angles = var_0.angles;

    level.burke maps\_utility::enable_pain();
    level.burke thread maps\lab_utility::cloak_off();
    var_2 = [ level.burke, level.wallclimb_roots ];
    var_1 maps\_anim::anim_first_frame_solo( level.wallclimb_roots, "burke_wall_climb" );
    level.burke soundscripts\_snd::snd_message( "aud_burke_wall_climb" );
    level.burke maps\lab_utility::clear_additive_helmet_anim( 0 );
    var_1 thread maps\_anim::anim_single( var_2, "burke_wall_climb" );
    maps\_utility::delaythread( 8, ::player_climb_wall );
    maps\_utility::delaythread( 1, maps\lab_fx::wall_climb_dust_fx );
    thread helo_wall_climb( var_1 );
    thread maps\lab_lighting::enter_forest();
    var_1 waittill( "burke_wall_climb" );
    var_3 = "burke_wall_climb_loop_end";
    var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_wall_climb_loop", var_3 );
    common_scripts\utility::flag_wait( "flag_burke_says_exo_is_on" );
    var_1 notify( var_3 );
    var_1 maps\_anim::anim_single_solo( level.burke, "burke_says_exo_is_on" );
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    thread spawn_takedown_01_guys();
}

burke_wall_climb_teleport( var_0 )
{
    var_1 = common_scripts\utility::getstruct( "forest_search_drone_anim_org", "targetname" );
    level.burke stopanimscripted();
    var_1 thread maps\_anim::anim_loop_solo( level.burke, "burke_search_drone_idle", "ender" );
}

player_climb_wall_head_sway()
{
    level endon( "player_falling_to_death" );
    level.player endon( "stop_head_sway" );

    for (;;)
    {
        screenshake( level.player.origin, 7, 9, 4, 2, 0.2, 0.2, 0, 0.3, 0.375, 0.225 );
        wait 1.0;
    }
}

player_climb_wall()
{
    level endon( "player_falling_to_death" );
    level endon( "flag_cloak_fail_kill_player" );
    common_scripts\utility::flag_set( "flag_forest_climb_wall_start" );
    soundscripts\_snd::snd_message( "forest_climb_wall_start" );
    thread show_exo_cloak_hint();
    var_0 = common_scripts\utility::getstruct( "forest_climb_anim_org", "targetname" );
    var_1 = getent( "climb_wall_use_trigger", "targetname" );
    var_1 thread maps\_utility::addhinttrigger( &"LAB_CLIMB_WALL_HINT", &"LAB_CLIMB_WALL_HINT_PC" );
    var_2 = var_1 maps\_shg_utility::hint_button_trigger( "x" );
    var_1 waittill( "trigger" );
    var_1 delete();
    var_2 maps\_shg_utility::hint_button_clear();
    common_scripts\utility::flag_set( "player_climbing_wall" );
    common_scripts\utility::flag_set( "player_climbing_wall_lighting" );
    level.player setstance( "stand" );
    var_3 = getentarray( "tree_wall_climb", "targetname" );

    foreach ( var_5 in var_3 )
        var_5 hide();

    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    level.player freezecontrols( 1 );
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    var_7 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_7 );
    var_8 = [ level.player_rig, level.wallclimb_roots ];
    level.player_rig common_scripts\utility::delaycall( var_7, ::show );
    soundscripts\_snd::snd_message( "aud_player_wall_climb_01" );
    level notify( "player_wall_climb_01" );
    level.player thread player_climb_wall_head_sway();
    thread handle_player_wall_climb_rumbles();
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_1" );
    maps\lab_utility::wait_until_left_swing_pressed( level.wallclimb_roots gettagorigin( "jnt_root03" ) + ( 0, 0, 10 ) );
    level.player thread maps\lab_utility::monitor_right_swing_released();
    soundscripts\_snd::snd_message( "aud_player_wall_climb_02" );
    level notify( "player_wall_climb_02" );
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_2" );
    maps\lab_utility::wait_until_next_right_swing( level.wallclimb_roots gettagorigin( "jnt_root05" ) + ( 0, 0, 0 ) );
    thread maps\lab_utility::monitor_left_swing_released();
    soundscripts\_snd::snd_message( "aud_player_wall_climb_03" );
    level notify( "player_wall_climb_03" );
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_3" );
    maps\lab_utility::wait_until_next_left_swing( level.wallclimb_roots gettagorigin( "jnt_root07" ) + ( 0, 0, 0 ) );
    var_9 = level.burke gettagorigin( "tag_origin" );
    thread maps\lab_utility::monitor_right_swing_released();
    soundscripts\_snd::snd_message( "aud_player_wall_climb_04" );
    level notify( "player_wall_climb_04" );
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_4" );
    level.burke overridelightingorigin( var_9 );

    if ( level.nextgen )
        setsaveddvar( "r_adaptivesubdiv", 0 );

    maps\lab_utility::wait_until_next_right_swing( level.wallclimb_roots gettagorigin( "jnt_breakoff03" ) + ( 0, 0, 0 ) );
    common_scripts\utility::flag_set( "flag_player_climb_succeeded" );
    level.nextgrenadedrop = 1000000;
    soundscripts\_snd::snd_message( "aud_player_wall_climb_05" );
    level notify( "player_wall_climb_05" );
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_5" );
    common_scripts\utility::flag_set( "flag_player_cloak_enabled" );

    if ( !common_scripts\utility::flag( "flag_player_cloak_on_pressed" ) )
    {
        var_0 thread maps\_anim::anim_loop( var_8, "player_wall_climb_loop", "player_wall_climb_loop_end" );
        common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );
        var_0 notify( "player_wall_climb_loop_end" );
    }

    soundscripts\_snd::snd_message( "wall_climb_cloak_activate" );
    level notify( "aud_wall_climb_done" );
    level notify( "wall_cloak_on" );
    level.burke defaultlightingorigin();
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_lastjump" );
    maps\lab_utility::wait_until_both_swings_pressed();
    level.player notify( "stop_head_sway" );
    level notify( "last_jump_made" );
    soundscripts\_snd::snd_message( "wall_climb_last_jump" );
    var_0 maps\_anim::anim_single( var_8, "player_wall_climb_end" );

    if ( level.nextgen )
        setsaveddvar( "r_adaptivesubdiv", 1 );

    level.player unlink();
    level.player freezecontrols( 0 );
    level.player enableweapons();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    common_scripts\utility::flag_set( "flag_player_exo_enabled" );
    setsaveddvar( "player_sprintunlimited", "1" );
    level.player_rig delete();
    maps\_cloak::turn_on_the_cloak_effect();
    common_scripts\utility::flag_set( "flag_forest_climb_wall_complete" );
    common_scripts\utility::flag_set( "flag_forest_climb_wall_complete_lighting" );

    foreach ( var_5 in var_3 )
        var_5 show();

    soundscripts\_snd::snd_message( "random_dog_barks" );
}

handle_player_wall_climb_rumbles()
{
    wait 0.5;
    thread maps\lab_utility::rumble_heavy();
    wait 0.5;
    thread maps\lab_utility::rumble_light_1();
    level waittill( "player_wall_climb_02" );
    wait 0.75;
    thread maps\lab_utility::rumble_light();
    level waittill( "player_wall_climb_03" );
    wait 0.5;
    thread maps\lab_utility::rumble_light();
    level waittill( "player_wall_climb_04" );
    wait 1;
    thread maps\lab_utility::rumble_light();
    level waittill( "player_wall_climb_05" );
    wait 2.15;
    thread maps\lab_utility::rumble_heavy();
    maps\lab_utility::setup_level_rumble_ent();
    level waittill( "wall_cloak_on" );
    wait 1;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.15 );
    wait 0.16;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.2 );
    wait 3.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.2 );
    level waittill( "last_jump_made" );
    wait 0.6;
    maps\lab_utility::rumble_light();
    wait 0.85;
    maps\lab_utility::rumble_heavy();
}

helo_wall_climb( var_0 )
{
    common_scripts\utility::flag_wait( "player_climbing_wall" );
    common_scripts\utility::flag_set( "flag_helo_low_pass_claok_start" );
    level.helo_spotlight.animname = "spotlight_helo";
    var_0 maps\_anim::anim_single_solo( level.helo_spotlight, "player_wall_climb" );
    var_0 thread maps\_anim::anim_loop_solo( level.helo_spotlight, "player_wall_climb_loop", "ender" );
    common_scripts\utility::flag_wait( "flag_player_cloak_on_pressed" );
    var_0 notify( "ender" );
    var_0 maps\_anim::anim_single_solo( level.helo_spotlight, "player_wall_climb_end" );
    common_scripts\utility::flag_set( "flag_helo_low_pass_complete" );
    level.helo_spotlight notify( "stop_helo_spotlight" );
    level.helo_spotlight.override_target linkto( level.helo_spotlight );
    level.helo_spotlight maps\_utility::vehicle_detachfrompath();
    level.helo_spotlight vehicle_setspeed( 20, 15, 5 );
    var_1 = common_scripts\utility::getstruct( "path_helo_goto_crash_site_start", "targetname" );
    level.helo_spotlight thread maps\_utility::vehicle_dynamicpath( var_1, 0 );
    level.helo_spotlight.script_vehicle_selfremove = 1;
}

player_stealth_cloak_think()
{
    if ( !common_scripts\utility::flag( "flag_player_cloak_on" ) )
        maps\_cloak::cloaked_stealth_enable_lab_hud_cinematic();

    common_scripts\utility::flag_wait( "flag_player_cloak_on" );
    level.player maps\_cloak::cloaked_stealth_player_setup();
    maps\_cloak::cloaked_stealth_disable_lab_hud_cinematic();
    maps\_cloak::cloaked_stealth_enable_battery_hud();
    common_scripts\utility::flag_wait( "flag_player_cloak_off" );
    maps\_cloak::cloaked_stealth_disable_battery_hud();
}

show_exo_cloak_hint()
{
    common_scripts\utility::flag_wait( "flag_player_cloak_on" );
    maps\_utility::display_hint_timeout( "exo_toggle_hint", 10 );
}

break_exo_cloak_hint()
{
    if ( common_scripts\utility::flag( "flag_player_cloak_on_pressed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_cloak_fail_kill_player" ) )
        return 1;

    if ( level.player buttonpressed( "dpad_right" ) )
    {
        common_scripts\utility::flag_set( "flag_player_cloak_on_pressed" );
        return 1;
    }
    else
        return 0;
}

break_prone_hint()
{
    if ( level.player getstance() == "prone" )
        return 1;

    if ( !common_scripts\utility::flag( "player_near_logging_road_end_log" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_seeker_clear" ) )
        return 1;

    return 0;
}

break_detonate_frb_hint()
{
    if ( common_scripts\utility::flag( "flag_obj_neutralize_bio_weapons_complete" ) )
        return 1;

    if ( !common_scripts\utility::flag( "flag_foam_room_clear" ) )
        return 1;

    return 0;
}

se_search_drones_01()
{
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "drones_search" );
    var_1 = common_scripts\utility::getstruct( "forest_search_drone_anim_org", "targetname" );

    foreach ( var_3 in var_0 )
    {
        var_3 maps\_utility::ent_flag_set( "fire_disabled" );
        var_3.ignoreme = 1;
        var_3 maps\_utility::delaythread( randomfloatrange( 0.05, 1 ), maps\lab_fx::drone_search_light_fx );
    }

    level.burke maps\_utility::set_grenadeammo( 0 );
    thread se_search_drone_backup();
    thread se_search_drone_vehicle( var_1 );
    thread se_search_drone_deer( var_1 );
    level.burke soundscripts\_snd::snd_message( "burke_run_slide" );
    common_scripts\utility::flag_wait( "flag_search_drone_burke_anim_start" );
    var_5 = getnodearray( "node_search_drone", "targetname" );

    foreach ( var_7 in var_5 )
        var_7 disconnectnode();

    maps\_utility::delaythread( 32.5, common_scripts\utility::flag_set, "flag_search_drone_complete_dialogue_start" );
    maps\_utility::delaythread( 32.5, common_scripts\utility::flag_set, "flag_search_drone_complete_dialogue_start" );
    level thread maps\_utility::notify_delay( "se_search_drone_backup_progress", 32 );
    var_1 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_1 maps\_anim::anim_single_solo_run( level.burke, "burke_search_drone" );
    maps\_utility::autosave_by_name();
    level.burke maps\_utility::set_moveplaybackrate( 0.8 );
    common_scripts\utility::flag_set( "flag_search_drone_se_complete" );
}

se_search_drone_backup()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname( "se_search_drone_backup" );
    var_0 endon( "death" );
    var_0 endon( "drone_spotted_player" );
    thread search_drone_behavior( var_0, undefined, 1 );
    var_0 sethoverparams( 16, 5, 5 );
    var_0 thread search_drone_random_turns();
    var_0 maps\_utility::delaythread( 0.25, maps\lab_fx::drone_search_light_fx );
    level waittill( "se_search_drone_backup_progress" );
    var_0 maps\_vehicle::gopath();
}

search_drone_random_turns()
{
    self endon( "weapon_fired" );
    self endon( "start_vehiclepath" );
    self endon( "drone_spotted_player" );
    self setvehgoalpos( self.origin, 1 );
    self notify( "goal" );
    self.pacifist = 1;
    maps\_utility::ent_flag_set( "fire_disabled" );

    for (;;)
    {
        var_0 = randomint( 360 );
        self setgoalyaw( var_0 );
        wait(randomfloatrange( 2, 5 ));
    }
}

search_drone_behavior( var_0, var_1, var_2 )
{
    var_0 endon( "death" );
    var_0 setcontents( 8192 );
    var_0 makevehiclenotcollidewithplayers( 1 );
    var_3 = 40;
    var_4 = 512;
    var_5 = 256;
    var_6 = 100;

    if ( isdefined( var_2 ) && var_2 )
        var_6 = 1;

    if ( isdefined( var_1 ) && var_1 )
        var_6 = 32;

    var_7 = var_3 * var_3;
    var_8 = var_4 * var_4;
    var_9 = var_5 * var_5;
    var_0.alerted_amount = 0;
    var_10 = 2;

    if ( isdefined( var_2 ) && var_2 )
        var_10 = 0.1;

    var_11 = 0.05;
    var_0 thread search_drone_alert_monitor();
    var_0 thread search_drone_damage_detection();

    for (;;)
    {
        var_12 = length( level.player getvelocity() );
        var_13 = level._cloaked_stealth_settings.cloak_on;
        var_14 = level.player geteye();

        if ( var_0.alerted_amount >= var_10 )
        {
            if ( isdefined( var_1 ) && var_1 || isdefined( var_2 ) && var_2 )
                var_0 se_search_drone_spotted_player();
            else
                var_0 search_drone_spotted_player();

            var_0.alerted_amount = 0;
        }

        var_15 = 0;

        if ( var_13 )
        {
            if ( distancesquared( var_14, var_0.origin ) < var_7 )
            {
                if ( !var_0.alerted_amount )
                {

                }

                var_0.alerted_amount += var_11 * 2;
                var_15 = 1;
            }
        }
        else if ( distancesquared( var_14, var_0.origin ) < var_8 && sighttracepassed( var_0.origin, var_14, 0, var_0 ) )
        {
            if ( !var_0.alerted_amount )
            {

            }

            var_0.alerted_amount += var_11;
            var_15 = 1;
        }

        if ( distancesquared( var_14, var_0.origin ) < var_9 )
        {
            if ( var_12 > var_6 )
            {
                if ( !var_0.alerted_amount )
                    thread maps\lab_vo::search_drone_warning_dialogue();

                var_0.alerted_amount += var_11;
                var_15 = 1;
            }
        }

        if ( var_15 )
            var_0 notify( "alerted" );
        else
            var_0 notify( "not_alerted" );

        wait(var_11);
    }
}

search_drone_damage_detection()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1 );

        if ( isdefined( var_1 ) && isdefined( var_1.team ) )
        {
            if ( isenemyteam( self.team, var_1.team ) )
            {
                self.alerted_amount = 100;
                self notify( "alerted" );
            }
        }
    }
}

search_drone_alert_monitor()
{
    self endon( "drone_spotted_player" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "alerted" );

        if ( !common_scripts\utility::flag( "flag_forest_takedown_01" ) )
            self playsound( "atlasdrn_angry" );

        self waittill( "not_alerted" );
        self stoploopsound( "seeker_alarm_lp" );
    }
}

se_search_drone_spotted_player()
{
    self laseron();
    self playloopsound( "atlasdrn_detection_lp" );
    thread maps\lab_vo::search_drone_alerted_dialogue();
    wait 1;
    self.pacifist = 0;
    maps\_utility::ent_flag_clear( "fire_disabled" );
    self stopanimscripted();
    self setvehgoalpos( level.player.origin + ( 0, 0, 90 ), 1 );
    level.player enablehealthshield( 0 );
    maps\_utility::vehicle_detachfrompath();
    thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
    level.player enablehealthshield( 0 );

    for (;;)
    {
        level notify( "player_failed_drone_scene" );
        self waittill( "weapon_fired" );
        level.player dodamage( 34 / level.player.damagemultiplier, self.origin, self );
    }
}

search_drone_spotted_player()
{
    self notify( "search_drone_spotted_player" );
    self endon( "search_drone_spotted_player" );
    self endon( "death" );
    self laseron();
    maps\_utility::ent_flag_clear( "fire_disabled" );
    self.pacifist = 0;
    self.ignoreme = 0;
    maps\_utility::set_favoriteenemy( level.player );
    var_0 = level.player.origin;
    maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
    maps\_utility::vehicle_detachfrompath();

    while ( sighttracepassed( self.origin, level.player geteye(), 0, self ) )
    {
        if ( isdefined( self.script_stealthgroup ) && isdefined( level._stealth.group.groups[maps\_utility::string( self.script_stealthgroup )] ) )
        {
            var_1 = maps\_stealth_shared_utilities::group_get_ai_in_group( maps\_utility::string( self.script_stealthgroup ) );

            foreach ( var_4, var_3 in var_1 )
            {
                if ( var_3 == self )
                    continue;

                if ( isdefined( var_3.enemy ) || isdefined( var_3.favoriteenemy ) )
                    continue;

                var_3 notify( "heard_alarm", var_0 );
            }
        }

        self waittill( "new_target" );
        maps\_utility::set_favoriteenemy( undefined );

        if ( isdefined( self.enemy ) )
            self.enemy common_scripts\utility::waittill_notify_or_timeout( "target_lost", 10 );

        wait 3;
    }

    maps\_utility::ent_flag_set( "fire_disabled" );
    self laseroff();
    self.pacifist = 1;
    self.ignoreme = 1;
}

se_search_drone_vehicle( var_0 )
{
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "se_search_drone" );
    var_1.animname = "search_drone";
    var_1 endon( "drone_spotted_player" );
    thread search_drone_behavior( var_1, 1 );
    var_1 maps\_utility::ent_flag_set( "fire_disabled" );
    var_1 maps\_vehicle::godon();
    var_1.ignoreme = 1;
    var_1 thread maps\lab_fx::drone_search_light_fx();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "search_drone" );
    common_scripts\utility::flag_wait( "flag_search_drone_burke_anim_start" );
    var_0 maps\_anim::anim_single_solo( var_1, "search_drone" );
    var_2 = common_scripts\utility::getstruct( "path_search_drone_end", "targetname" );
    var_1 thread maps\_utility::vehicle_dynamicpath( var_2, 0 );
    var_1.script_vehicle_selfremove = 1;
}

se_search_drone_deer( var_0 )
{
    var_1 = spawn( "script_model", var_0.origin );
    var_1 setmodel( "fullbody_deer_c" );
    var_1.animname = "deer";
    var_1 maps\_anim::setanimtree();
    var_0 maps\_anim::anim_first_frame_solo( var_1, "search_drone" );
    maps\_utility::delaythread( 31.0, maps\lab_fx::deer_leaves_fx );
    common_scripts\utility::flag_wait( "flag_search_drone_burke_anim_start" );
    var_1 soundscripts\_snd::snd_message( "deer_foliage_rustle" );
    var_0 maps\_anim::anim_single_solo( var_1, "search_drone" );
    var_1 delete();
}

force_patrol_anim_set( var_0, var_1, var_2 )
{
    maps\_patrol_extended::force_patrol_anim_set( var_0, var_1, 0, var_2 );
}

spawn_takedown_01_guys()
{
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    level endon( "flag_se_takedown_01_started" );
    level.guy_1 = getent( "enemy_takedown_player_01", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.guy_2 = getent( "enemy_takedown_burke_01", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.guy_1 maps\_utility::set_ignoreme( 1 );
    level.guy_2 maps\_utility::set_ignoreme( 1 );
    level.guy_1 maps\_utility::set_ignoreall( 1 );
    level.guy_2 maps\_utility::set_ignoreall( 1 );
    level waittill( "player_failed_drone_scene" );
    common_scripts\utility::flag_set( "forest_player_passed_takedown" );
}

se_forest_takedown_01()
{
    var_0 = common_scripts\utility::getstruct( "forest_takedown_01_org", "targetname" );
    thread burke_se_forest_takedown_01( var_0 );
    common_scripts\utility::flag_wait( "flag_forest_takedown_01" );
    level.player allowmelee( 0 );
    level.player.disable_melee = 1;
    var_1 = getnodearray( "node_search_drone", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 connectnode();

    thread se_forest_takedown_01_fail_conditions( level.guy_1, level.guy_2 );
    thread se_forest_takedown_01_distance_think();
    var_0 = common_scripts\utility::getstruct( "forest_takedown_01_org", "targetname" );
    level.guy_1 force_patrol_anim_set( "active_forward" );
    level.guy_1 common_scripts\utility::delay_script_call( 3, maps\_flashlight_cheap::add_cheap_flashlight, "flashlight", 0, "flashlight_spotlight" );
    level.guy_2 force_patrol_anim_set( "gundown" );
    level.guy_1.nodrop = 1;
    level.guy_2.nodrop = 1;
    level.guy_1.diequietly = 1;
    level.guy_2.diequietly = 1;
    level.guy_1 maps\_utility::disable_surprise();
    level.guy_2 maps\_utility::disable_surprise();
    level.guy_1.animname = "disarm_guy_1";
    level.guy_2.animname = "disarm_guy_2";
    common_scripts\utility::flag_set( "flag_forest_takedown_01_dialogue_start" );
    thread maps\lab_utility::enable_takedown_hint( level.guy_1, 101, 1 );
    level.guy_1 thread maps\lab_utility::display_takedown_world_prompt_on_enemy( self );
    self waittill( "player_completed_takedown" );
    common_scripts\utility::flag_set( "flag_se_takedown_01_started" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
    level.guy_1 notify( "enemy" );
    level.guy_2 notify( "enemy" );

    if ( isdefined( level.guy_1.function_stack ) )
        level.guy_1 maps\_utility::function_stack_clear();

    level.guy_1 stopsounds();

    if ( isdefined( level.burke.function_stack ) )
        level.burke maps\_utility::function_stack_clear();

    level.burke stopsounds();
    var_5 = [ level.burke, level.guy_1, level.guy_2 ];
    level.player setstance( "stand" );
    level.guy_1 notify( "flashlight_off" );
    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    level.player freezecontrols( 1 );
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    maps\_player_exo::player_exo_deactivate();
    soundscripts\_snd::snd_message( "player_forest_takedown", level.guy_1 );
    soundscripts\_snd::snd_message( "burke_forest_takedown", level.guy_2 );
    var_6 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_6 );
    var_7 = [ level.guy_1, level.player_rig ];
    var_8 = [ level.burke, level.guy_2 ];
    level.player_rig common_scripts\utility::delaycall( var_6, ::show );
    thread se_burke_takedown_01( var_0 );
    level.guy_1 notify( "takedown_01_start" );
    thread maps\lab_fx::forest_takedown_fx();
    thread forest_takedown_01_rumbles();
    thread forest_takedown_handle_gideon_weapon();
    thread award_player_exo_challenge_kill_for_scene();
    var_0 maps\_anim::anim_single( var_7, "forest_disarm" );
    setsaveddvar( "ammoCounterHide", "0" );
    level.guy_1 maps\_utility::pretend_to_be_dead();
    level.guy_2 maps\_utility::pretend_to_be_dead();
    level.player unlink();
    level.player freezecontrols( 0 );
    level.player enableweapons();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    maps\_player_exo::player_exo_remove_single( "exo_melee" );
    setsaveddvar( "player_sprintunlimited", "1" );
    level.player_rig delete();
    level.guy_1 kill();
    level.player thread equip_player_smg();

    if ( level._cloaked_stealth_settings.cloak_on == 1 )
    {
        level.player maps\_cloak::turn_off_the_cloak_effect();
        wait 0.05;
        level.player maps\_cloak::turn_on_the_cloak_effect();
    }

    common_scripts\utility::flag_set( "flag_se_takedown_01_complete" );
    soundscripts\_snd::snd_message( "takedown_01_complete" );
    maps\_utility::autosave_by_name();
    level.player allowmelee( 1 );
    level.player.disable_melee = undefined;
    thread maps\lab_lighting::logging_road();
}

award_player_exo_challenge_kill_for_scene()
{
    wait 2.5;
    level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
}

forest_takedown_01_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 0.75;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.6, 0.3 );
    wait 1;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.5 );
    wait 0.65;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.8, 0.2 );
}

forest_takedown_handle_gideon_weapon()
{
    wait 5;
    level.guy_2 maps\_utility::gun_remove();
    var_0 = spawn( "script_model", level.burke.origin );
    var_1 = "npc_hbra3_nocamo";

    if ( isdefined( level.burke.free_running_hidden_weapon ) )
        var_1 = getweaponmodel( level.burke.free_running_hidden_weapon );

    var_0 setmodel( var_1 );
    var_0 maps\_utility::teleport_to_ent_tag( level.burke, "tag_weapon_right" );
    wait 8.25;
    var_0 delete();
    level.burke animscripts\free_run::disable_free_running();
}

burke_se_forest_takedown_01( var_0 )
{
    level endon( "flag_logging_road_loud_combat" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "forest_disarm_arrive", undefined, 1 );
    maps\_utility::delaythread( 0.5, maps\lab_fx::burke_tree_slide_fx );
    level.burke soundscripts\_snd::snd_message( "burke_slide_02" );
    var_0 maps\_anim::anim_single_solo( level.burke, "forest_disarm_arrive" );
    level.burke maps\_utility::set_moveplaybackrate( 1 );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "forest_disarm_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_se_takedown_01_started" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
}

se_forest_takedown_01_fail_conditions( var_0, var_1 )
{
    self endon( "player_completed_takedown" );
    var_2 = 36;
    var_3 = 1024;
    var_4 = 184;
    var_5 = 300;
    var_6 = var_2 * var_2;
    var_7 = var_3 * var_3;
    var_8 = var_4 * var_4;
    var_9 = 0.05;

    while ( !common_scripts\utility::flag( "flag_se_takedown_01_complete" ) && !common_scripts\utility::flag( "forest_player_passed_takedown" ) )
    {
        var_10 = length( level.player getvelocity() );
        var_11 = level._cloaked_stealth_settings.cloak_on;
        var_12 = level.player.origin;

        if ( var_11 )
        {
            if ( distancesquared( var_12, var_0.origin ) < var_6 || distancesquared( var_12, var_1.origin ) < var_6 )
                break;
        }
        else if ( distancesquared( var_12, var_0.origin ) < var_7 || distancesquared( var_12, var_1.origin ) < var_7 )
        {
            if ( var_0 cansee( level.player ) || var_1 cansee( level.player ) )
                break;
        }

        if ( distancesquared( var_12, var_0.origin ) < var_8 || distancesquared( var_12, var_1.origin ) < var_8 )
        {
            if ( var_10 > var_5 )
                break;
        }

        wait(var_9);
    }

    wait 0.05;

    if ( !common_scripts\utility::flag( "flag_se_takedown_01_started" ) || common_scripts\utility::flag( "forest_player_passed_takedown" ) )
    {
        self notify( "takedown_failed" );
        level notify( "se_takedown_01_failed" );
        common_scripts\utility::flag_set( "flag_disable_takedown_hint" );
        level.should_display_melee_hint = 0;
        common_scripts\utility::flag_clear( "can_save" );
        var_0 maps\_utility::set_ignoreall( 0 );
        var_1 maps\_utility::set_ignoreall( 0 );
        level._cloaked_stealth_settings.cloak_disabled = 1;
        var_0.favoriteenemy = level.player;
        var_1.favoriteenemy = level.player;
        var_0 maps\_utility::set_baseaccuracy( 999 );
        var_1 maps\_utility::set_baseaccuracy( 999 );
        var_0 maps\_utility::magic_bullet_shield();
        var_1 maps\_utility::magic_bullet_shield();
        var_0 setgoalentity( level.player );
        var_1 setgoalentity( level.player );
        var_0.goalradius = 20;
        var_1.goalradius = 20;
        var_0.combatmode = "no_cover";
        var_1.combatmode = "no_cover";
        var_0 notify( "end_patrol" );
        var_1 notify( "end_patrol" );
        var_0 notify( "enemy" );
        var_1 notify( "enemy" );
        level notify( "patrol_alerted" );
        common_scripts\utility::flag_set( "_stealth_spotted" );
        maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
        level.player enablehealthshield( 0 );

        for (;;)
        {
            var_0 waittill( "shooting" );
            level.player dodamage( level.player.maxhealth / 3, var_0 gettagorigin( "tag_flash" ), var_0 );
        }
    }
}

se_forest_takedown_01_distance_think()
{
    level endon( "flag_slowly_dialogue_start" );
    level endon( "se_takedown_01_failed" );

    for (;;)
    {
        if ( maps\_utility::players_within_distance( 300, level.guy_1.origin ) )
            common_scripts\utility::flag_set( "flag_slowly_dialogue_start" );

        wait 0.1;
    }
}

se_burke_takedown_01( var_0 )
{
    var_1 = [ level.burke, level.guy_2 ];
    level.guy_2.allowdeath = 1;
    level.guy_2.a.nodeath = 1;
    level.guy_2 maps\_utility::set_battlechatter( 0 );
    level.guy_2 setcontents( 0 );
    level.guy_2 common_scripts\utility::delaycall( 14, ::setanimrate, level.guy_2 maps\_utility::getanim( "forest_disarm" ), 0 );
    thread maps\lab_utility::ai_kill_when_out_of_sight( level.guy_2, 1024 );
    var_0 maps\_anim::anim_single_run( var_1, "forest_disarm" );
    level.burke maps\_utility::set_moveplaybackrate( 0.8 );
    level.burke maps\_utility::enable_cqbwalk();
}

se_vehicle_takedown_01()
{
    self endon( "takedown_failed" );
    level endon( "flag_se_vehicle_takedown_01_failed" );
    thread maps\lab_lighting::vrap_takedown_lights_on();
    thread maps\lab_lighting::lighting_vehicle_takedown_01_on();
    var_0 = common_scripts\utility::getstruct( "vrap_takedown_org", "targetname" );
    var_1 = spawn( "script_origin", var_0.origin );
    var_2 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_0.angles ) )
    {
        var_1.angles = var_0.angles;
        var_2.angles = var_0.angles;
    }

    var_3 = getent( "blocker_vrap_takedown_door", "targetname" );
    var_3.origin += ( 0, 0, 10000 );
    var_3 disconnectpaths();
    var_4 = getent( "vrap_01", "targetname" ) maps\_utility::spawn_vehicle();
    var_5 = maps\_utility::spawn_targetname( "enemy_vrap_01" );
    var_6 = maps\_utility::spawn_targetname( "enemy_vrap_02" );
    var_4.animname = "vrap";
    var_5.animname = "vrap_guy_1";
    var_6.animname = "vrap_guy_2";
    var_5.allowdeath = 1;
    var_5.diequietly = 1;
    var_6.diequietly = 1;
    var_5.health = 1;
    var_6.health = 1;
    var_5.found = 1;
    var_6.found = 1;
    var_7 = [ var_4, var_5 ];
    var_8 = [ var_6 ];
    var_6.vehicle_idle_override = var_6 maps\_utility::getanim( "vrap_takedown_idle" );
    var_6 notify( "enteredvehicle" );
    var_4 thread maps\_utility::guy_enter_vehicle( var_6 );
    var_6.allowdeath = 1;
    var_9 = "vrap_takedown_ender";
    var_1 thread maps\_anim::anim_loop( var_7, "vrap_takedown_idle", var_9 );
    thread se_vehicle_takedown_fail_conditions( var_5, var_6, var_1, var_2, var_9, var_4 );
    thread se_vehicle_takedown_stealth_alert_check( var_5, 1 );
    thread se_vehicle_takedown_stealth_alert_check( var_6, 0 );
    common_scripts\utility::flag_wait( "flag_vehicle_takedown_01" );
    soundscripts\_snd::snd_message( "truck_takedown_radio", var_5 );

    if ( !common_scripts\utility::flag( "flag_forest_player_alt_path_01" ) )
    {
        se_vehicle_mute_charge( var_1 );
        thread maps\lab_utility::enable_takedown_hint( var_5, 101 );
        var_10 = common_scripts\utility::spawn_tag_origin();
        var_10.origin = var_5.origin + ( 0, 0, 52 );
        var_10 linkto( var_5, "j_neck" );
        var_5 thread maps\lab_utility::activate_takedown_world_prompt_on_truck_enemy( self );
        self waittill( "player_completed_takedown" );
        level.player setstance( "stand" );
        common_scripts\utility::flag_set( "flag_vehicle_takedown_01_start" );
        thread maps\lab_lighting::lighting_vehicle_takedown_01( var_5 );
        var_5 maps\_stealth_utility::disable_stealth_for_ai();
        var_6 maps\_stealth_utility::disable_stealth_for_ai();
        level.player maps\_shg_utility::setup_player_for_scene( 1 );
        maps\_player_exo::player_exo_deactivate();
        level.player maps\_utility::set_ignoreme( 1 );
        var_6 = maps\_vehicle_aianim::convert_guy_to_drone( var_6 );
        var_6.animname = "vrap_guy_2";
        var_1 notify( var_9 );
        var_2 notify( var_9 );
        level.player_rig = maps\lab_utility::spawn_player_rig();
        level.player_rig.animname = "player_rig";
        level.player_rig hide();
        level.player playerlinktoblend( level.player_rig, "tag_player", 0.2 );
        level.player_rig common_scripts\utility::delaycall( 0.2, ::show );
        var_11 = [ var_4, var_5, var_6, level.burke, level.player_rig ];
        soundscripts\_snd::snd_message( "truck_takedown" );
        thread vehicle_takedown_rumbles();
        thread award_player_exo_challenge_kill_for_scene();
        var_1 maps\_anim::anim_single( var_11, "vrap_takedown" );
        var_5 maps\_utility::pretend_to_be_dead();
        level.player unlink();
        level.player freezecontrols( 0 );
        level.player enableweapons();
        level.player maps\_shg_utility::setup_player_for_gameplay();
        maps\_player_exo::player_exo_activate();
        level.player_rig delete();
        level.player maps\_utility::set_ignoreme( 0 );
        var_3 connectpaths();
        var_3 delete();
        var_1 notify( var_9 );
        var_2 notify( var_9 );
        var_1 delete();
        var_2 delete();
    }

    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );
    thread maps\_utility::autosave_stealth();
}

se_vehicle_mute_charge( var_0 )
{
    self endon( "takedown_failed" );
    var_1 = maps\_utility::spawn_anim_model( "vrap_mute" );
    var_1 hide();
    var_2 = getent( "vrap_mute_hint", "targetname" );
    level.vrap_mute_obj = spawn( "script_model", ( 0, 0, 0 ) );
    level.vrap_mute_obj setmodel( "mutecharge_obj" );
    level.vrap_mute_obj.angles = var_2.angles;
    level.vrap_mute_obj.origin = var_2.origin;
    level.vrap_mute_trig = getent( "trig_vrap_mute", "targetname" );
    level.vrap_mute_trig thread maps\_utility::addhinttrigger( &"LAB_PLANT_MUTE_HINT", &"LAB_PLANT_MUTE_HINT_PC" );
    level.vrap_mute_trig.button = level.vrap_mute_trig maps\_shg_utility::hint_button_trigger( "x" );
    thread vehicle_mute_charge_failed();
    common_scripts\utility::flag_wait( "flag_vrap_mute_start" );

    while ( isdefined( level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim ) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1 )
        wait 0.05;

    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    var_3 = [ level.player_rig, var_1 ];
    var_0 thread maps\_anim::anim_first_frame( var_3, "vrap_mute" );
    level.vrap_mute_trig thread maps\_utility::addhinttrigger( "", "" );
    level.vrap_mute_trig.button maps\_shg_utility::hint_button_clear();
    soundscripts\_snd::snd_message( "lab_mute_gun_holster" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player playerlinktoblend( level.player_rig, "tag_player", 0.5 );
    wait 0.5;
    var_1 thread maps\_cloak::activate_mute_volume( 350, 20 );
    var_1 soundscripts\_snd::snd_message( "aud_vrap_mute_start", 350, 20 );
    level.vrap_mute_obj hide();
    level.player_rig show();
    var_1 show();
    thread mute_charge_01_rumbles();
    var_0 maps\_anim::anim_single( var_3, "vrap_mute" );
    level.player unlink();
    level.player enableweapons();
    level.player freezecontrols( 0 );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    level.player_rig delete();
}

mute_charge_01_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 0.65;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.2 );
    wait 0.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.75 );
}

vehicle_takedown_rumbles()
{
    wait 0.93;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.7, 0.2 );
    wait 1;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.7, 0.2 );
}

vehicle_mute_charge_failed()
{
    self endon( "player_completed_takedown" );
    level endon( "flag_vrap_mute_start" );
    common_scripts\utility::waittill_any_ents( self, "takedown_failed", level, "flag_se_vehicle_takedown_01_failed" );
    thread vehicle_mute_charge_cleanup();
}

vehicle_mute_charge_cleanup()
{
    if ( isdefined( level.vrap_mute_obj ) )
        level.vrap_mute_obj delete();

    if ( isdefined( level.vrap_mute_trig ) )
    {
        if ( isdefined( level.vrap_mute_trig.button ) )
            level.vrap_mute_trig.button maps\_shg_utility::hint_button_clear();

        level.vrap_mute_trig delete();
    }
}

se_vehicle_takedown_fail_conditions( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "player_completed_takedown" );
    thread se_vehicle_takedown_fail_condition_guy( var_0, var_2, var_4, 1, var_5 );
    thread se_vehicle_takedown_fail_condition_guy( var_1, var_3, var_4, 0, var_5 );
    common_scripts\utility::waittill_any_ents( var_0, "death", var_1, "death" );

    if ( level.player maps\_utility::ent_flag_exist( "_stealth_in_mute_radius" ) && level.player maps\_utility::ent_flag( "_stealth_in_mute_radius" ) )
    {
        if ( isdefined( var_0 ) )
            var_0 maps\_stealth_utility::disable_stealth_for_ai();

        if ( isdefined( var_1 ) )
        {
            var_1 maps\_stealth_utility::disable_stealth_for_ai();
            var_1 = maps\_vehicle_aianim::convert_guy_to_drone( var_1 );
            var_1.animname = "vrap_guy_2";
            var_3 thread maps\_anim::anim_single_solo( var_1, "vrap_takedown" );
            var_3 maps\_utility::delaythread( 0.05, maps\_anim::anim_set_time, [ var_1 ], "vrap_takedown", 1 );
            var_1 setanimrate( var_1 maps\_utility::getanim( "vrap_takedown" ), 0 );
            var_1 kill( level.burke.origin, level.burke );
        }

        if ( !isdefined( var_0 ) || !isalive( var_0 ) )
        {
            if ( isdefined( var_1 ) && isalive( var_1 ) )
                var_1 kill( level.burke.origin, level.burke );
        }

        if ( !isdefined( var_1 ) || !isalive( var_1 ) )
        {
            if ( isdefined( var_0 ) && isalive( var_0 ) )
                var_0 kill( level.burke.origin, level.burke );
        }
    }
    else
    {
        common_scripts\utility::flag_set( "_stealth_spotted" );
        maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
    }

    self notify( "takedown_failed" );
    common_scripts\utility::flag_set( "flag_disable_takedown_hint" );
    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_failed" );
    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );
    level.should_display_melee_hint = 0;
}

se_vehicle_takedown_stealth_alert_check( var_0, var_1 )
{
    var_0 endon( "death" );

    if ( var_1 )
        common_scripts\utility::waittill_any_ents( var_0, "patrol_alerted", var_0, "_stealth_spotted", var_0, "stealth_event", var_0, "_stealth_found_corpse", var_0, "alerted", var_0, "enemy", var_0, "touch" );
    else
        common_scripts\utility::waittill_any_ents( var_0, "patrol_alerted", var_0, "_stealth_spotted", var_0, "stealth_event", var_0, "_stealth_found_corpse", var_0, "alerted", var_0, "enemy" );

    var_0 notify( "alerted" );
}

se_vehicle_takedown_fail_condition_guy( var_0, var_1, var_2, var_3, var_4 )
{
    self endon( "player_completed_takedown" );
    var_0 endon( "death" );
    var_5 = var_0 maps\_stealth_shared_utilities::ai_get_behavior_function( "animation", "wrapper" );
    var_0 maps\_stealth_shared_utilities::ai_create_behavior_function( "animation", "wrapper", ::se_vehicle_takedown_dummyfunc );
    var_0 maps\_utility::ent_flag_set( "_stealth_behavior_reaction_anim" );
    var_0._stealth.debug_state = "hanging around";
    var_0 waittill( "alerted" );
    var_1 notify( var_2 );
    self notify( "takedown_failed" );
    common_scripts\utility::flag_set( "flag_disable_takedown_hint" );
    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_failed" );
    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );
    level.should_display_melee_hint = 0;

    if ( var_3 )
    {
        waittillframeend;
        var_1 maps\_anim::anim_single_solo( var_0, "vrap_takedown_fail" );
        var_0 maps\_stealth_shared_utilities::ai_create_behavior_function( "animation", "wrapper", var_5 );
    }
    else
    {
        var_4 maps\_vehicle::vehicle_unload();
        var_0 waittill( "jumpedout" );
        var_0 maps\_stealth_shared_utilities::ai_create_behavior_function( "animation", "wrapper", var_5 );
    }

    var_0 maps\_utility::ent_flag_clear( "_stealth_behavior_reaction_anim" );
}

se_vehicle_takedown_dummyfunc( var_0 )
{

}

drones_logging_road()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "drones_logging_road_wave_1" );

    foreach ( var_2 in var_0 )
    {
        var_2 maps\_utility::ent_flag_set( "fire_disabled" );
        var_2.ignoreme = 1;
        var_2 thread maps\lab_fx::drone_search_light_fx();
        thread search_drone_behavior( var_2 );
    }

    common_scripts\utility::flag_wait( "flag_se_vehicle_takedown_01_complete" );
    wait 0.1;
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "drones_logging_road_wave_1" );

    foreach ( var_2 in var_0 )
    {
        var_2 maps\_utility::ent_flag_set( "fire_disabled" );
        var_2.ignoreme = 1;
        var_2 thread maps\lab_fx::drone_search_light_fx();
        thread search_drone_behavior( var_2 );
    }
}

se_mech_march()
{
    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
        return;

    level endon( "flag_logging_road_loud_combat" );
    common_scripts\utility::flag_wait( "flag_se_mech_march_start" );

    if ( !common_scripts\utility::flag( "flag_se_vehicle_takedown_01_complete" ) )
    {
        common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_failed" );
        common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );
    }

    level notify( "dog_barks_stop" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "gaz_mech_march_02" );
    var_0 soundscripts\_snd::snd_message( "gaz_04_slow_by" );
    var_0 maps\_vehicle::vehicle_lights_on();
    var_0 thread maps\lab_fx::logging_road_mud_tracks_2();
    var_0 thread forest_stealth_gaz_think();
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "brt_mech_march_01" );
    var_1 soundscripts\_snd::snd_message( "gaz_05_slow_by" );
    var_1 thread maps\lab_fx::logging_road_mud_tracks_2();
    var_1 thread forest_stealth_gaz_think();
    var_0 thread maps\lab_lighting::logging_road_gaz_headlight_moment();
    var_2 = getentarray( "combat_mech_march_runner", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        var_4 maps\_utility::spawn_ai( 1, 0 );
        wait(randomfloatrange( 0.1, 0.25 ));
    }

    var_2 = getentarray( "combat_mech_march", "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        var_7 = var_4 maps\_utility::spawn_ai( 1, 0 );
        var_7 thread mech_march_footstep_rumbles();
    }

    var_9 = getent( "combat_mech_march_05", "script_noteworthy" );
    var_10 = var_9 maps\_utility::spawn_ai( 1, 0 );
    var_10 thread mech_march_footstep_rumbles();
    var_2 = getentarray( "combat_mech_march_follower", "script_noteworthy" );

    foreach ( var_4 in var_2 )
        var_4 maps\_utility::spawn_ai( 1, 0 );
}

mech_march_footstep_rumbles()
{
    level endon( "flag_logging_road_loud_combat" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "moveanim", var_0 );

        if ( var_0 == "footstep_rumble" )
        {
            var_1 = 300;
            var_2 = distance( self.origin, level.player.origin );

            if ( var_2 < var_1 )
            {
                maps\lab_utility::setup_level_rumble_ent();
                var_3 = ( var_1 - var_2 ) / var_1;
                thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, var_3, 0.25 );
                wait 0.25;
            }
            else
                waitframe();

            continue;
        }

        waitframe();
    }
}

mech_march_follower_enemy_think()
{
    self endon( "death" );
    force_patrol_anim_set( "gundown", 0 );
    maps\_utility::set_moveplaybackrate( 0.9 );
}

mech_march_runner_enemy_think()
{
    self endon( "death" );
    force_patrol_anim_set( "patroljog", 0 );
    maps\_utility::set_moveplaybackrate( 1.1 );
}

disable_rappel_trigger_monitor()
{
    level endon( "flag_rappel_start" );
    var_0 = getent( "rappel_cancel_trigger", "targetname" );
    var_1 = getent( "rappel_use_trigger", "targetname" );
    var_0 waittill( "trigger" );
    var_1 common_scripts\utility::trigger_off();
}

se_cormack_meet()
{
    thread disable_rappel_trigger_monitor();
    common_scripts\utility::flag_wait( "flag_logging_road_complete" );
    level.nextgrenadedrop = -1;

    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
        common_scripts\utility::flag_set( "flag_vo_stealth_recovered" );

    level notify( "patrol_radios_stop" );
    level notify( "aud_start_clearing_damb" );
    common_scripts\utility::flag_wait( "flag_cormack_meet_init" );
    common_scripts\utility::flag_set( "flag_obj_crawl_under_log" );
    thread maps\lab_lighting::cliff_rappel_lighting_setup();
    thread maps\lab_lighting::cliff_rappel();
    var_0 = common_scripts\utility::getstruct( "cliff_rappel_org", "targetname" );
    se_cormack_meet_init();
    level.burke thread burke_disable_cqb();
    level.knox.ignoreme = 1;
    var_1 = getnode( "node_burke_cover_rappel", "targetname" );
    level.burke thread maps\lab_utility::goto_node( var_1, 0 );
    var_2 = [ level.cormack, level.knox ];
    var_0 thread maps\_anim::anim_loop( var_2, "cliff_meetup_idle", "ender" );
    var_3 = spawn( "script_model", var_0.origin );
    var_3 setmodel( "rope_carabiner" );
    var_3.animname = "carabiner_burke";
    var_3 maps\_anim::setanimtree();
    var_4 = spawn( "script_model", var_0.origin );
    var_4 setmodel( "rope_carabiner" );
    var_4.animname = "carabiner_cormack";
    var_4 maps\_anim::setanimtree();
    var_5 = spawn( "script_model", var_0.origin );
    var_5 setmodel( "rope_carabiner" );
    var_5.animname = "carabiner_knox";
    var_5 maps\_anim::setanimtree();
    var_5 overridematerial( "mtl_rope_carabiner", "mtl_rope_carabiner_cloak" );
    level.carabiner_knox = var_5;
    var_6 = spawn( "script_model", var_0.origin );
    var_6 setmodel( "lab_anchor_system" );
    var_6.animname = "anchor_system_burke";
    var_6 maps\_anim::setanimtree();
    var_7 = spawn( "script_model", var_0.origin );
    var_7 setmodel( "lab_anchor_system" );
    var_7.animname = "anchor_system_cormack";
    var_7 maps\_anim::setanimtree();
    var_8 = spawn( "script_model", var_0.origin );
    var_8 setmodel( "lab_anchor_system" );
    var_8.animname = "anchor_system_knox";
    var_8 maps\_anim::setanimtree();
    var_9 = spawn( "script_model", var_0.origin );
    var_9 setmodel( "rope30ft_120j" );
    var_9.animname = "rope_30_burke";
    var_9 maps\_anim::setanimtree();
    var_10 = spawn( "script_model", var_0.origin );
    var_10 setmodel( "rope30ft_120j" );
    var_10.animname = "rope_30_cormack";
    var_10 maps\_anim::setanimtree();
    var_11 = spawn( "script_model", var_0.origin );
    var_11 setmodel( "rope30ft_120j" );
    var_11.animname = "rope_30_knox";
    var_11 maps\_anim::setanimtree();
    var_11 overridematerial( "mtl_rope_blk", "mtl_rope_blk_cloak" );
    level.rope_knox = var_11;
    var_12 = [ var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 ];
    var_0 thread maps\_anim::anim_first_frame( var_12, "cliff_meetup" );
    common_scripts\utility::flag_wait( "flag_cormack_meet_start" );
    soundscripts\_snd::snd_message( "aud_burke_nearing_cliff" );
    var_0 maps\_anim::anim_reach_solo( level.burke, "cliff_meetup" );
    level.burke thread maps\lab_utility::cloak_off();
    level.cormack maps\_utility::anim_stopanimscripted();
    level.knox maps\_utility::anim_stopanimscripted();
    common_scripts\utility::flag_set( "flag_cliff_rappel_dialogue_start" );
    level.burke pushplayer( 0 );
    level.burke.dontavoidplayer = 0;
    level.burke.dontchangepushplayer = undefined;
    var_0 notify( "ender" );
    var_2 = [ level.cormack, level.knox, level.burke, var_6, var_7, var_8, var_9, var_10, var_11, var_3, var_4, var_5 ];
    maps\_utility::delaythread( 12, ::equip_player );
    var_0 maps\_anim::anim_single( var_2, "cliff_meetup" );
    var_13 = [ level.burke, var_9 ];
    var_0 thread maps\_anim::anim_loop( var_13, "cliff_meetup_rappel_idle", "ender" );
    var_14 = getnode( "node_knox_rappel_1", "targetname" );
    var_15 = getnode( "node_cormack_rappel_1", "targetname" );
    level.knox maps\lab_utility::goto_node( var_14, 0 );
    level.cormack maps\lab_utility::goto_node( var_15, 0 );
    level.cormack thread maps\lab_utility::cloak_on();
    level.knox thread maps\lab_utility::cloak_on();
    var_16 = getent( "cliff_clip_cormack", "targetname" );
    var_16 delete();
    common_scripts\utility::flag_set( "flag_player_ready_to_rappel" );
    thread maps\lab_vo::cliff_rappel_dialogue_nag();
    var_17 = getent( "rappel_use_trigger", "targetname" );
    var_17 thread maps\_utility::addhinttrigger( &"LAB_RAPPEL_HINT", &"LAB_RAPPEL_HINT_PC" );
    var_18 = var_17 maps\_shg_utility::hint_button_trigger( "x" );
    var_17 thread maps\lab_utility::disable_trigger_while_player_animating( "flag_rappel_start" );
    common_scripts\utility::flag_wait( "flag_rappel_start" );
    common_scripts\utility::flag_clear( "flag_player_cloak_enabled" );
    thread cleanup_ai_logging_road();
    level.knox.ignoreme = 0;
    soundscripts\_snd::snd_message( "aud_rappel_player_hookup" );
    var_19 = [ var_6, var_7, var_8, var_9, var_10, var_11, var_3, var_4, var_5 ];
    thread rope_end_rappel( var_0, var_19 );
    thread courtyard_rappel_preview();
    common_scripts\utility::flag_set( "flag_rappel_start_lighting" );
    common_scripts\utility::flag_set( "flag_cliff_rappeling_dialogue_start" );
    var_17 thread maps\_utility::addhinttrigger( "", "" );
    var_18 maps\_shg_utility::hint_button_clear();
    var_20 = spawn( "script_model", var_0.origin );
    var_20 hide();
    var_20 setmodel( "rope30ft_240j" );
    var_20.animname = "rope_vm";
    var_20 maps\_anim::setanimtree();
    var_21 = spawn( "script_model", var_0.origin );
    var_21 hide();
    var_21 setmodel( "rope_carabiner" );
    var_21.animname = "carabiner_vm";
    var_21 maps\_anim::setanimtree();
    var_22 = spawn( "script_model", var_0.origin );
    var_22 hide();
    var_22 setmodel( "lab_anchor_system" );
    var_22.animname = "anchor_system";
    var_22 maps\_anim::setanimtree();
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    var_23 = 1;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_23 );
    level.player common_scripts\utility::delaycall( 2, ::playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    level.player enableslowaim( 0.4, 0.25 );
    level.player_rig common_scripts\utility::delaycall( var_23, ::show );
    var_22 common_scripts\utility::delaycall( var_23, ::show );
    var_24 = getent( "cliff_clip_gideon", "targetname" );
    var_24 delete();
    thread player_rappel( var_0, var_20, var_21, var_22 );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
    thread burke_rappel( var_0, var_9 );
}

burke_disable_cqb()
{
    common_scripts\utility::flag_wait( "flag_seeker_clear" );
    maps\_utility::disable_cqbwalk();
}

burke_rappel( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0.origin );
    var_2 hide();
    var_2 setmodel( "rope150ft_240j" );
    var_2.animname = "rope_150_burke";
    var_2 maps\_anim::setanimtree();
    level.burke_rope_long = var_2;
    level.burke_rope = var_1;
    var_3 = [ level.burke, var_1, var_2 ];
    var_0 maps\_anim::anim_single( var_3, "cliff_jump" );
    level.burke thread maps\lab_utility::cloak_on();
    level.burke maps\_utility::place_weapon_on( "iw5_hbra3_sp_silencer01_variablereddot", "right" );
    var_2 delete();
}

player_rappel( var_0, var_1, var_2, var_3 )
{
    level notify( "aud_stop_clearing_damb" );
    var_1 common_scripts\utility::delaycall( 1, ::show );
    var_2 common_scripts\utility::delaycall( 1, ::show );
    var_4 = spawn( "script_model", var_0.origin );
    var_4 hide();
    var_4 setmodel( "weapon_rappel_rope_long" );
    var_4.animname = "rope_vm_long";
    var_4 maps\_anim::setanimtree();
    level.player_rope_long = var_4;
    level.player_rope = var_1;
    var_5 = [ level.player_rig, var_1, var_4, var_2, var_3 ];
    thread play_cliff_rappel_animation( var_0, level.player_rig, var_5 );
    thread player_rappel_control( var_0, level.player_rig, var_5 );
    level.player_rig waittill( "cliff_jump" );
    level notify( "cliff_rappel_landing" );
    level.player unlink();
    level.player freezecontrols( 0 );
    level.player enableweapons();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    level.player_rig delete();
    level.player disableslowaim();
    common_scripts\utility::flag_set( "flag_player_cloak_enabled" );
    soundscripts\_snd::snd_message( "player_rappel_complete" );
    var_4 delete();
    maps\_utility::autosave_by_name();

    if ( level.currentgen )
    {
        level notify( "tff_pre_intro_to_middle" );
        unloadtransient( "lab_intro_tr" );
        loadtransient( "lab_middle_tr" );

        while ( !istransientloaded( "lab_middle_tr" ) )
            wait 0.05;

        level notify( "tff_post_intro_to_middle" );
    }
}

rope_end_rappel( var_0, var_1 )
{
    level waittill( "cliff_rappel_landing" );

    foreach ( var_3 in var_1 )
        var_3 delete();

    var_5 = spawn( "script_model", var_0.origin );
    var_5 setmodel( "rope150ft_240j" );
    var_5.animname = "rope_150_knox_end";
    var_5 maps\_anim::setanimtree();
    var_6 = spawn( "script_model", var_0.origin );
    var_6 setmodel( "rope150ft_240j" );
    var_6.animname = "rope_150_cormack_end";
    var_6 maps\_anim::setanimtree();
    var_7 = spawn( "script_model", var_0.origin );
    var_7 setmodel( "rope150ft_240j" );
    var_7.animname = "rope_150_burke_end";
    var_7 maps\_anim::setanimtree();
    var_8 = spawn( "script_model", var_0.origin );
    var_8 setmodel( "rope150ft_240j" );
    var_8.animname = "rope_150_player_end";
    var_8 maps\_anim::setanimtree();
    var_9 = [ var_5, var_6, var_7, var_8 ];
    var_0 maps\_anim::anim_loop( var_9, "cliff_jump_end" );
}

player_input_rappel_hint_off()
{
    return level.player getnormalizedmovement()[0] < -0.1;
}

player_rappel_control( var_0, var_1, var_2 )
{
    var_1 endon( "cliff_jump" );
    var_3 = 1;
    var_4 = 1.0;
    var_5 = 1;
    var_6 = 1.0;
    var_7 = 0.1;
    common_scripts\utility::flag_wait( "flag_rappel_player_input_start" );
    thread rappel_control_hint();
    level.player lerpviewangleclamp( 1, 0.5, 0, 10, 20, 20, 30 );

    if ( 0 )
        thread camera_view_tuning( var_1 );

    if ( 0 )
        thread camera_sway_tuning();

    thread player_rappel_camera_sway( var_1, 1 );

    for (;;)
    {
        if ( common_scripts\utility::flag( "flag_rappel_player_input_stop" ) )
        {
            maps\_anim::anim_set_rate( var_2, "cliff_jump", 1 );
            thread player_rappel_camera_sway( var_1, 0 );
            return;
        }

        var_8 = level.player getnormalizedmovement();

        if ( var_8[0] < 0 )
            var_6 = var_8[0] * -1;
        else
            var_6 = 0;

        if ( var_6 > 0 )
        {
            soundscripts\_snd::snd_message( "aud_rappel_player_movement_start", var_1 );
            level.player_is_rappelling = 1;
        }
        else
            soundscripts\_snd::snd_message( "aud_rappel_player_movement_stop", var_1 );

        var_9 = abs( var_6 - var_4 );

        if ( var_9 > 0.01 )
        {
            if ( var_9 > 0.5 )
                var_7 = 0.1;
            else
                var_7 = 0.03;

            if ( var_6 > var_4 )
            {
                var_4 += var_7;

                if ( var_4 > 1.0 )
                    var_4 = 1.0;
            }
            else
            {
                var_4 -= var_7;

                if ( var_4 < 0.0 )
                {
                    var_4 = 0.0;
                    level.player_is_rappelling = 0;
                }
            }

            maps\_anim::anim_set_rate( var_2, "cliff_jump", var_4 );
        }

        waitframe();
    }
}

rappel_control_hint()
{
    wait 1.5;
    maps\_utility::hintdisplayhandler( "player_input_rappel_hint" );
}

play_cliff_rappel_animation( var_0, var_1, var_2 )
{
    thread rappel_animation_rumbles();
    var_0 maps\_anim::anim_single( var_2, "cliff_jump" );
    var_1 notify( "cliff_jump" );
}

rappel_animation_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 1.15;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.8, 0.4 );
    wait 2.4;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.3 );
    wait 7.4;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.5 );
    wait 3.75;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.1, 3.75 );
    thread rappel_rumbles();
}

rappel_rumbles()
{
    level endon( "cliff_rappel_landing" );

    while ( !isdefined( level.player_is_rappelling ) )
        wait 0.5;

    maps\lab_utility::setup_level_rumble_ent();

    for (;;)
    {
        if ( level.player_is_rappelling == 1 )
            thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.1, 0.4 );

        wait 0.5;
    }
}

player_rappel_camera_sway( var_0, var_1 )
{
    var_0 endon( "cliff_jump" );
    var_0 notify( "killduplicatethread" );
    var_0 endon( "killduplicatethread" );

    if ( !var_1 )
        return;

    for (;;)
    {
        if ( 0 )
            screenshake( level.player.origin, level.values[0], level.values[1], level.values[2], level.values[3], level.values[4], level.values[5], level.values[6], level.values[7], level.values[8], level.values[9] );
        else
            screenshake( level.player.origin, 0.2, 4.1, 0.56, 2, 0.95, 0, 0, 0.4, 0.1, 0.1 );

        wait 1.0;
    }
}

camera_sway_tuning()
{
    level.values[0] = 0.2;
    level.values[1] = 4.1;
    level.values[2] = 0.56;
    level.values[3] = 2;
    level.values[4] = 0.95;
    level.values[5] = 0;
    level.values[6] = 0;
    level.values[7] = 0.4;
    level.values[8] = 0.1;
    level.values[9] = 0.1;
    var_0[0] = "scalePitch";
    var_0[1] = "scaleyaw";
    var_0[2] = "scaleroll";
    var_0[3] = "duration";
    var_0[4] = "durationfadeup";
    var_0[5] = "durationfadedown";
    var_0[6] = "radius";
    var_0[7] = "frequencypitch";
    var_0[8] = "frequencyyaw";
    var_0[9] = "frequencyroll";
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        if ( level.player buttonpressed( "DPAD_LEFT" ) )
        {
            var_1++;

            if ( var_1 >= var_0.size )
                var_1 = 0;

            var_2 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_RIGHT" ) )
        {
            var_1--;

            if ( var_1 < 0 )
                var_1 = var_0.size - 1;

            var_2 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_UP" ) )
        {
            level.values[var_1] += 0.05;
            var_2 = 1;
        }
        else if ( level.player buttonpressed( "DPAD_DOWN" ) )
        {
            level.values[var_1] -= 0.05;
            var_2 = 1;
        }

        if ( var_2 )
        {
            var_3 = "selected(" + var_0[var_1] + ") ";

            for ( var_4 = 0; var_4 < var_0.size; var_4++ )
                var_3 = var_3 + var_0[var_4] + "(" + level.values[var_4] + ") ";

            iprintln( var_3 );
            var_2 = 0;
        }

        waitframe();
    }
}

camera_view_tuning( var_0 )
{
    var_0 endon( "cliff_jump" );
    level.values[0] = 10;
    level.values[1] = 30;
    level.values[2] = 30;
    level.values[3] = 45;
    var_1[0] = "right";
    var_1[1] = "left";
    var_1[2] = "top";
    var_1[3] = "bottom";
    var_2 = 0;
    var_3 = 0;

    for (;;)
    {
        if ( level.player buttonpressed( "DPAD_LEFT" ) )
        {
            var_2++;

            if ( var_2 >= var_1.size )
                var_2 = 0;

            var_3 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_RIGHT" ) )
        {
            var_2--;

            if ( var_2 < 0 )
                var_2 = var_1.size - 1;

            var_3 = 1;
            wait 0.5;
        }
        else if ( level.player buttonpressed( "DPAD_UP" ) )
        {
            level.values[var_2] += 0.05;
            var_3 = 1;
        }
        else if ( level.player buttonpressed( "DPAD_DOWN" ) )
        {
            level.values[var_2] -= 0.05;
            var_3 = 1;
        }

        if ( var_3 )
        {
            var_4 = "selected(" + var_1[var_2] + ") ";

            for ( var_5 = 0; var_5 < var_1.size; var_5++ )
                var_4 = var_4 + var_1[var_5] + "(" + level.values[var_5] + ") ";

            iprintln( var_4 );
            var_3 = 0;
            level.player lerpviewangleclamp( 0.2, 0.1, 0.1, level.values[0], level.values[1], level.values[2], level.values[3] );
        }

        waitframe();
    }
}

player_rappel_rope_swap( var_0 )
{
    level.player_rope_long show();
    level.player_rope hide();
}

burke_rappel_rope_swap( var_0 )
{
    level.burke_rope_long show();
    level.burke_rope hide();
}

se_cormack_meet_init()
{
    maps\lab::spawn_cormack_common();
    level.cormack thread maps\lab_utility::cloak_on();
    maps\lab::spawn_knox_common();
    level.knox thread maps\lab_utility::cloak_on();
}

play_rappel_pip( var_0 )
{
    wait 1;
    maps\_shg_utility::play_videolog( "lab_videolog_01", "screen_add" );
}

se_breach_guards()
{
    maps\_utility::battlechatter_off( "axis" );
    level.burke maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_cqbwalk();
    level.knox maps\_utility::enable_cqbwalk();
    setsaveddvar( "ai_friendlyFireBlockDuration", 0 );
    thread maps\lab_utility::enable_all_fixed_scanners();
    var_0 = common_scripts\utility::getstruct( "breach_guards_org", "targetname" );
    var_1 = getent( "camera_breach", "script_noteworthy" );
    var_2 = maps\_utility::spawn_targetname( "breach_guard_01", 1 );
    var_3 = maps\_utility::spawn_targetname( "breach_guard_02", 1 );
    var_2.ignoreme = 1;
    var_3.ignoreme = 1;
    var_1.ignoreme = 1;
    var_2.animname = "guy_1";
    var_3.animname = "guy_2";
    var_4 = [ var_2, var_3 ];
    var_0 thread maps\_anim::anim_loop( var_4, "breach_duards_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_facility_breach_start" );
    var_5 = getnode( "node_burke_shoot_camera", "targetname" );
    level.burke maps\_utility::disable_ai_color();
    level.burke.ignoreme = 1;
    level.burke thread maps\lab_utility::goto_node( var_5, 0 );
    var_6 = getnode( "node_cormack_shoot_camera", "targetname" );
    level.cormack maps\_utility::disable_ai_color();
    level.cormack.ignoreme = 1;
    level.cormack thread maps\lab_utility::goto_node( var_6, 0 );
    var_7 = getnode( "node_knox_shoot_camera", "targetname" );
    level.knox maps\_utility::disable_ai_color();
    level.knox.ignoreme = 1;
    level.knox thread maps\lab_utility::goto_node( var_7, 0 );

    if ( isdefined( var_1.destructible_parts ) && var_1.destructible_parts[0].v["health"] > 0 )
        var_4 = [ var_1, var_2, var_3 ];
    else
        var_4 = [ var_2, var_3 ];

    common_scripts\utility::array_thread( var_4, ::breach_guy_think );
    level waittill( "breach_guard_damaged" );
    level.burke.ignoreme = 0;
    level.cormack.ignoreme = 0;
    level.knox.ignoreme = 0;
    common_scripts\utility::flag_set( "flag_breach_guards_alerted" );
    var_0 notify( "ender" );
    wait 0.5;

    foreach ( var_9 in var_4 )
    {
        var_9.ignoreall = 0;
        var_9.ignoreme = 0;
        var_9.dontattackme = undefined;
        var_9.dontevershoot = undefined;
        var_9 maps\_utility::anim_stopanimscripted();
    }

    level.burke maps\_utility::set_baseaccuracy( 999 );
    level.cormack maps\_utility::set_baseaccuracy( 999 );
    level.knox maps\_utility::set_baseaccuracy( 999 );

    while ( isdefined( var_1.destructible_parts ) && var_1.destructible_parts[0].v["health"] > 0 || isdefined( var_2 ) && var_2.health > 0 || isdefined( var_3 ) && var_3.health > 0 )
        wait 0.05;

    common_scripts\utility::flag_set( "flag_breach_guards_clear" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_wait( "flag_facility_security_camera" );
    common_scripts\utility::flag_set( "flag_light_security_camera_off" );
    var_1 notify( "stop_fixed_scanner_audio" );
    level.burke maps\_utility::set_baseaccuracy( 0.2 );
    level.cormack maps\_utility::set_baseaccuracy( 0.2 );
    level.knox maps\_utility::set_baseaccuracy( 0.2 );
    level.burke maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.knox maps\_utility::disable_cqbwalk();
    setsaveddvar( "ai_friendlyFireBlockDuration", 2000 );
    level.knox maps\_utility::delaythread( 2, maps\lab_utility::cloak_off );
    level.burke maps\_utility::delaythread( 3.25, maps\lab_utility::cloak_off );
    level.cormack maps\_utility::delaythread( 4.5, maps\lab_utility::cloak_off );
}

breach_guy_think()
{
    self.health = 1;
    self.allowdeath = 1;

    if ( isai( self ) )
    {
        thread maps\lab_utility::disable_grenades();
        common_scripts\utility::waittill_any_ents( self, "damage", self, "_stealth_spotted", self, "stealth_event", self, "enemy", self, "weapon_fired" );
    }
    else
    {
        while ( self.destructible_parts[0].v["health"] > 0 )
            wait 0.05;
    }

    level notify( "breach_guard_damaged", self );
}

se_facility_breach()
{
    common_scripts\utility::flag_wait_all( "flag_facility_breach_start", "flag_breach_guards_clear" );
    thread maps\lab_lighting::facility_breach();
    thread maps\lab_breach::facility_breach();
    thread maps\lab_breach::facility_breach_get_burke_into_position();
    var_0 = getnode( "node_cormack_facility_breach", "targetname" );
    level.cormack thread maps\lab_utility::goto_node( var_0, 0 );
    var_0 = getnode( "node_knox_facility_breach", "targetname" );
    level.knox thread maps\lab_utility::goto_node( var_0, 0 );
    level waittill( "breaching" );
    thread facility_breach_rumbles();
    level.knox thread knox_move_to_breach_door();
    common_scripts\utility::flag_wait_any( "flag_facility_breach_complete", "flag_burke_kills_guy" );
    var_1 = getnode( "node_burke_breach_01", "targetname" );
    var_2 = getnode( "node_cormack_breach_00", "targetname" );
    var_3 = getnode( "node_knox_breach_01", "targetname" );
    level.burke maps\lab_utility::goto_node( var_1, 0 );
    level.cormack maps\lab_utility::goto_node( var_2, 0 );
    level.knox maps\lab_utility::goto_node( var_3, 0 );
    level.cormack thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    level.knox thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    soundscripts\_snd::snd_message( "aud_lab_ambient_emitters" );

    if ( level.currentgen )
    {
        level notify( "tff_pre_intro_audio_to_middle" );
        unloadtransient( "lab_intro_audio_tr" );
    }
}

facility_breach_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 1.6;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 1, 0.2 );
    wait 0.65;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.75 );
    wait 8.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.6, 0.75 );
}

se_server_room_entrance()
{
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_04" );
    maps\_stealth_utility::disable_stealth_system();
    var_0 = common_scripts\utility::getstruct( "server_room_entrance_org", "targetname" );
    level.monitor = spawn( "script_model", var_0.origin );
    level.monitor setmodel( "lab_server_monitor_01_opc" );
    level.monitor.animname = "server_monitor";
    level.monitor maps\_anim::setanimtree();
    level.cormack notify( "anim_reach_server_room_started" );
    level.burke notify( "anim_reach_server_room_started" );
    level.knox notify( "anim_reach_server_room_started" );

    if ( isdefined( level.cormack.cloak ) && level.cormack.cloak == "on" )
        level.cormack maps\lab_utility::cloak_off();

    if ( isdefined( level.burke.cloak ) && level.burke.cloak == "on" )
        level.burke maps\lab_utility::cloak_off();

    if ( isdefined( level.knox.cloak ) && level.knox.cloak == "on" )
        level.knox maps\lab_utility::cloak_off();

    thread burke_server_room_se( var_0 );
    thread cormack_server_room_se( var_0 );
    thread knox_server_room_se( var_0 );
    thread enemy_server_room_se( var_0 );
    level.monitor thread monitor_server_room_se( var_0 );
    var_1 = getent( "security_door_right_model", "targetname" );
    var_2 = getent( "security_door_right_clip", "targetname" );
    var_2 linkto( var_1 );
    var_2 disconnectpaths();
    var_1.orig_origin = var_1.origin;
    var_1.orig_angles = var_1.angles;
    var_3 = maps\_utility::spawn_anim_model( "security_door_right", var_1.origin );
    var_0 maps\_anim::anim_first_frame_solo( var_3, "server_room_peek" );
    var_1 linkto( var_3, "tag_origin_animated" );
    common_scripts\utility::flag_wait_all( "flag_obj_bio_weapons_05", "flag_burke_server_room_ready", "flag_knox_server_room_ready" );
    thread play_monitor_cinematic();
    common_scripts\utility::flag_set( "flag_se_server_room_start" );
    common_scripts\utility::flag_set( "flag_server_room_start_lighting" );
    soundscripts\_snd::snd_message( "aud_server_room_door_crack" );
    var_0 thread maps\_anim::anim_single_solo( var_3, "server_room_peek" );
    maps\_utility::add_wait( common_scripts\utility::flag_wait, "flag_server_room_enemy_killed_by_player" );
    maps\_utility::add_wait( common_scripts\utility::flag_wait, "player_entered_server_room" );
    maps\_utility::add_wait( maps\_utility::_wait, 8 );
    maps\_utility::add_wait( ::se_server_room_player_misses, level.player );
    maps\_utility::do_wait_any();
    var_4 = "server_room_enter";
    soundscripts\_snd::snd_message( "aud_server_room_door_enter" );
    common_scripts\utility::flag_set( "flag_sever_room_guy_kill" );
    var_2 connectpaths();
    var_5 = getent( "dsm_usetrigger", "targetname" );
    var_5 thread maps\lab_utility::disable_trigger_while_player_animating( "flag_se_server_room_exit_start" );
    common_scripts\utility::flag_wait( "flag_se_server_room_exit_start" );
    common_scripts\utility::flag_wait( "monitor_finished_animating" );
    soundscripts\_snd::snd_message( "aud_player_computer_gl_timing_fix" );
    maps\_utility::delaythread( 0.5, common_scripts\utility::flag_set, "flag_obj_bio_weapons_hack" );
    maps\_utility::delaythread( 0.5, common_scripts\utility::flag_set, "bio_weapons_hack_lighting" );
    level.knox maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
    var_1 unlink();
    var_1.origin = var_1.orig_origin;
    var_1.angles = var_1.orig_angles;
    var_2 disconnectpaths();
    var_6 = spawn( "script_model", var_0.origin );
    var_6 setmodel( "npc_variable_grenade_lethal" );
    var_6.animname = "grenade1";
    var_6 maps\_anim::setanimtree();
    var_7 = spawn( "script_model", var_0.origin );
    var_7 setmodel( "npc_variable_grenade_lethal" );
    var_7.animname = "grenade2";
    var_7 maps\_anim::setanimtree();
    var_8 = spawn( "script_model", var_0.origin );
    var_8 setmodel( "npc_variable_grenade_lethal" );
    var_8.animname = "grenade3";
    var_8 maps\_anim::setanimtree();
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    maps\_player_exo::player_exo_deactivate();
    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    var_9 = 0.5;
    maps\_utility::delaythread( var_9, maps\_cloak::disable_cloak_system );
    level.player playerlinktoblend( level.player_rig, "tag_player", var_9 );
    level.player common_scripts\utility::delaycall( var_9, ::playerlinktodelta, level.player_rig, "tag_player", 1, 15, 15, 10, 10 );
    level.player enableslowaim( 0.3, 0.15 );
    level.player_rig common_scripts\utility::delaycall( var_9, ::show );
    var_10 = [ level.knox, var_6, var_7, var_8 ];
    level.player_rig thread player_server_room_se_end( var_0 );
    level.burke thread server_room_se_end( var_0 );
    level.cormack thread server_room_se_end( var_0 );
    maps\_utility::activate_trigger_with_targetname( "trig_color_server_room" );

    if ( !common_scripts\utility::flag( "flag_server_room_promo" ) )
        var_0 maps\_utility::delaythread( 0.5, maps\_anim::anim_single_run, var_10, "server_room_exit" );
    else
        var_0 maps\_utility::delaythread( 0.5, maps\_anim::anim_single_run, var_10, "server_room_exit_promo" );

    common_scripts\utility::flag_wait( "flag_combat_research_start" );
    level thread maps\lab_fx::thermite_servers_explosion();
    common_scripts\utility::flag_wait( "flag_post_server_room_dialogue_complete" );
    maps\_utility::autosave_by_name();
    thread open_server_room_door();
    common_scripts\utility::flag_set( "flag_enable_battle_chatter" );
    maps\_utility::activate_trigger_with_targetname( "trig_color_research_facility_01" );
}

se_server_room_player_misses( var_0 )
{
    level endon( "flag_enemy_server_room_se_dead" );
    var_0 common_scripts\utility::waittill_any( "weapon_fired", "grenade_fire" );
    wait 0.1;
}

se_server_room_player_close( var_0 )
{
    level endon( "flag_enemy_server_room_se_dead" );
    var_1 = common_scripts\utility::getstruct( "server_room_entrance_org", "targetname" );
    var_2 = 62500;

    while ( distancesquared( var_0.origin, var_1.origin ) > var_2 )
        wait 0.05;
}

play_monitor_cinematic()
{
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingame( "lab_uploadscreen" );

    while ( !iscinematicplaying() )
        wait 0.1;

    pausecinematicingame( 1 );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );
    pausecinematicingame( 0 );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_complete" );
    stopcinematicingame();
    cinematicingame( "lab_uploadscreen_end" );
}

monitor_interaction_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 3.8;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
    wait 0.25;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
    wait 0.75;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.1, 0.5 );
    wait 4.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
    wait 0.4;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
    wait 0.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
    wait 0.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.18, 0.15 );
}

stop_monitor_cinematic()
{
    stopcinematicingame();
}

player_server_room_se_end( var_0 )
{
    if ( !common_scripts\utility::flag( "flag_server_room_promo" ) )
        var_0 maps\_anim::anim_first_frame_solo( self, "server_room_exit" );
    else
        var_0 maps\_anim::anim_first_frame_solo( self, "server_room_exit_promo" );

    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );
    thread monitor_interaction_rumbles();

    if ( !common_scripts\utility::flag( "flag_server_room_promo" ) )
        var_0 maps\_anim::anim_single_solo( self, "server_room_exit" );
    else if ( !common_scripts\utility::flag( "flag_demo_itiot" ) )
    {
        var_1 = getdvarint( "g_friendlyNameDist" );
        setsaveddvar( "g_friendlyNameDist", 0 );
        var_0 maps\_anim::anim_single_solo( self, "server_room_exit_promo" );
        setsaveddvar( "g_friendlyNameDist", var_1 );
    }

    level.player unlink();
    level.player_rig delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    level.player disableslowaim();
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_complete" );
    maps\_utility::autosave_by_name();
}

open_server_room_door()
{
    soundscripts\_snd::snd_message( "open_server_room_door" );
    common_scripts\utility::flag_set( "open_server_room_door_lighting" );
    var_0 = getent( "door_server_room_left", "targetname" );
    var_1 = getent( "door_server_room_right", "targetname" );
    var_2 = getent( "clip_door_server_room_left", "targetname" );
    var_3 = getent( "clip_door_server_room_right", "targetname" );
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = common_scripts\utility::getstruct( "struct_door_server_room_left", "targetname" );
    var_5 = common_scripts\utility::getstruct( "struct_door_server_room_right", "targetname" );
    var_0 moveto( var_4.origin, 1, 0.5, 0.5 );
    var_1 moveto( var_5.origin, 1, 0.5, 0.5 );
    wait 0.5;
    var_2 connectpaths();
    var_3 connectpaths();
}

se_server_room_player_kills_guy( var_0 )
{
    level endon( "end_enemy_server_room_se_dead" );
    self endon( "death" );
    self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

    if ( var_2 == level.player )
        common_scripts\utility::flag_set( "flag_server_room_enemy_killed_by_player" );

    if ( self.damagelocation == "head" )
        level.player maps\_upgrade_challenge::give_player_challenge_headshot( 1 );
    else
        level.player maps\_upgrade_challenge::give_player_challenge_kill( 1 );
}

burke_server_room_se( var_0 )
{
    wait 2;
    var_0 maps\_anim::anim_reach_solo( level.burke, "server_room_entry_intro" );
    var_0 maps\_anim::anim_single_solo( level.burke, "server_room_entry_intro" );
    common_scripts\utility::flag_set( "flag_burke_server_room_ready" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "server_room_door_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_se_server_room_start" );
    var_0 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( level.burke, "server_room_peek" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "server_room_door_idle", "ender" );
    common_scripts\utility::flag_wait_any( "flag_server_room_enemy_killed_by_player", "flag_server_room_enemy_killed_by_knox" );

    if ( common_scripts\utility::flag( "flag_server_room_enemy_killed_by_player" ) )
        wait 2;
    else
        wait 4;

    var_0 notify( "ender" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( level.burke, "server_room_enter" );
    var_0 thread maps\_anim::anim_loop_solo( level.burke, "server_room_enter_idle", "ender" );
    var_0 thread maps\lab_utility::notify_on_flag( "flag_obj_bio_weapons_hack", "ender" );
    common_scripts\utility::flag_wait( "flag_se_server_room_exit_start" );
    level.burke maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
}

cormack_server_room_se( var_0 )
{
    var_0 maps\_anim::anim_reach_solo( level.cormack, "server_room_entry_intro" );
    var_0 maps\_anim::anim_single_solo( level.cormack, "server_room_entry_intro" );
    common_scripts\utility::flag_set( "flag_cormack_server_room_ready" );

    if ( !common_scripts\utility::flag( "flag_se_server_room_start" ) )
        var_0 thread maps\_anim::anim_loop_solo( level.cormack, "server_room_door_idle", "ender" );

    common_scripts\utility::flag_wait( "flag_se_server_room_start" );
    var_0 notify( "ender" );
    level.cormack maps\_utility::anim_stopanimscripted();
    var_0 maps\_anim::anim_single_solo( level.cormack, "server_room_peek" );
    var_0 maps\_anim::anim_single_solo( level.cormack, "server_room_enter" );
    var_0 thread maps\_anim::anim_loop_solo( level.cormack, "server_room_door_idle", "ender" );
    var_0 thread maps\lab_utility::notify_on_flag( "flag_obj_bio_weapons_hack", "ender" );
    common_scripts\utility::flag_wait( "flag_se_server_room_exit_start" );
    level.cormack maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
}

knox_server_room_se( var_0 )
{
    var_0 maps\_anim::anim_reach_solo( level.knox, "server_room_entry_intro" );
    var_0 maps\_anim::anim_single_solo( level.knox, "server_room_entry_intro" );
    common_scripts\utility::flag_set( "flag_knox_server_room_ready" );

    if ( !common_scripts\utility::flag( "flag_se_server_room_start" ) )
    {
        var_0 thread maps\_anim::anim_loop_solo( level.knox, "server_room_door_idle", "ender" );
        common_scripts\utility::flag_wait( "flag_se_server_room_start" );
        var_0 notify( "ender" );
    }

    var_0 thread knox_server_room_se_peek( "server_room_peek", "server_room_door_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_sever_room_guy_kill" );
    var_0 notify( "ender" );
    level.knox maps\_utility::anim_stopanimscripted();

    if ( !common_scripts\utility::flag( "flag_server_room_enemy_killed_by_player" ) )
    {
        soundscripts\_snd::snd_message( "aud_server_room_door_kick" );
        var_0 maps\_anim::anim_single_solo( level.knox, "server_room_enter_fail" );
    }

    var_0 thread maps\_anim::anim_loop_solo( level.knox, "server_room_door_idle", "ender" );
    var_0 thread maps\lab_utility::notify_on_flag( "flag_obj_bio_weapons_hack", "ender" );
    common_scripts\utility::flag_wait( "flag_se_server_room_exit_start" );
    level.knox maps\_utility::anim_stopanimscripted();
    var_0 notify( "ender" );
}

knox_server_room_se_peek( var_0, var_1, var_2 )
{
    level endon( "flag_sever_room_guy_kill" );
    maps\_anim::anim_single_solo( level.knox, var_0 );
    thread maps\_anim::anim_loop_solo( level.knox, var_1, var_2 );
}

server_room_fire_knox_gun( var_0 )
{
    if ( !common_scripts\utility::flag( "flag_server_room_enemy_killed_by_player" ) )
        magicbullet( level.knox.weapon, level.knox gettagorigin( "tag_flash" ), level.console_guy geteye() );
}

server_room_se_end( var_0 )
{
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );

    if ( !common_scripts\utility::flag( "flag_server_room_promo" ) )
        var_0 maps\_anim::anim_single_solo_run( self, "server_room_exit" );
    else
        var_0 maps\_anim::anim_single_solo_run( self, "server_room_exit_promo" );
}

enemy_server_room_se( var_0 )
{
    level endon( "flag_enemy_server_room_se_dead" );
    common_scripts\utility::flag_wait( "flag_se_server_room_start" );
    level.console_guy = getent( "guy_se_server_room", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.console_guy.animname = "guy_01_server_room";
    level.console_guy.ignoresonicaoe = 1;
    level.console_guy thread se_server_room_player_kills_guy( var_0 );
    var_0 thread maps\_anim::anim_loop_solo( level.console_guy, "server_room_door_idle", "ender" );
    level.console_guy.allowdeath = 0;
    common_scripts\utility::flag_wait( "flag_sever_room_guy_kill" );
    common_scripts\utility::flag_set( "flag_server_room_enemy_killed_by_knox" );
    var_0 notify( "ender" );

    if ( isalive( level.console_guy ) && common_scripts\utility::flag( "flag_server_room_enemy_killed_by_player" ) )
        var_0 maps\_anim::anim_single_solo( level.console_guy, "server_room_enter" );
    else if ( isalive( level.console_guy ) )
        var_0 maps\_anim::anim_single_solo( level.console_guy, "server_room_enter_fail" );
}

monitor_server_room_se( var_0 )
{
    var_0 thread maps\_anim::anim_loop_solo( self, "server_room_door_idle", "ender" );
    level.monitor setmodel( "lab_server_monitor_01_opc" );
    common_scripts\utility::flag_wait_any( "flag_server_room_enemy_killed_by_player", "flag_server_room_enemy_killed_by_knox" );
    self stopanimscripted();
    var_0 notify( "ender" );

    if ( common_scripts\utility::flag( "flag_server_room_enemy_killed_by_player" ) )
        var_0 maps\_anim::anim_single_solo( self, "server_room_enter" );
    else
        var_0 maps\_anim::anim_single_solo( self, "server_room_enter_fail" );

    level.monitor setmodel( "lab_server_monitor_01_obj" );
    common_scripts\utility::flag_set( "monitor_finished_animating" );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );
    level.monitor setmodel( "lab_server_monitor_01_opc" );

    if ( !common_scripts\utility::flag( "flag_server_room_promo" ) )
        var_0 maps\_anim::anim_single_solo( self, "server_room_exit" );
    else
        var_0 maps\_anim::anim_single_solo( self, "server_room_exit_promo" );
}

se_foam_room_player()
{
    var_0 = getent( "org_foam_room", "targetname" );
    common_scripts\utility::flag_wait( "flag_obj_neutralize_bio_weapons_planted" );
    thread foam_room_door_01_close();
    thread foam_room_door_03_close();
    var_1 = "foam_room";
    var_2 = spawn( "script_model", var_0.origin );
    var_2 setmodel( "npc_foam_grenade" );
    var_2.animname = "foam_bomb";
    var_2 maps\_anim::setanimtree();
    level.player enableinvulnerability();
    thread maps\lab_lighting::foam_plant_dof();
    var_3 = maps\_utility::spawn_anim_model( "player_rig_intro" );
    var_3 hide();
    var_0 maps\_anim::anim_first_frame_solo( var_3, var_1 );
    soundscripts\_snd::snd_message( "player_plant_frb" );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    var_4 = [ var_3, var_2 ];
    level.player playerlinktoblend( var_3, "tag_player", 0.2 );
    wait 0.5;
    var_3 show();
    thread frb_plant_rumbles();
    var_0 maps\_anim::anim_single( var_4, var_1 );
    level.player disableinvulnerability();
    level notify( "reset_plant_dof" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    var_2 hidepart( "root_pin" );
    var_2 hidepart( "flipper" );
    var_3 delete();
    level.player unlink();
}

frb_plant_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 1.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.4 );
    wait 0.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.8, 0.3 );
    wait 0.75;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.7, 0.2 );
    level.player waittill( "detonate" );
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.4 );
}

se_foam_room()
{
    common_scripts\utility::flag_wait( "flag_obj_neutralize_bio_weapons_planted" );
    thread foam_room_clear_think();
    var_0 = getent( "org_foam_warp1", "targetname" );
    var_1 = getent( "org_foam_warp2", "targetname" );
    var_2 = getent( "org_foam_warp3", "targetname" );
    level.cormack forceteleport( var_0.origin, var_0.angles );
    level.knox forceteleport( var_1.origin, var_1.angles );
    level.burke forceteleport( var_2.origin, var_2.angles );
    level.cormack.goalradius = 64;
    level.knox.goalradius = 64;
    level.burke.goalradius = 64;

    if ( !common_scripts\utility::flag( "flag_obj_courtyard_jammer_start" ) )
    {
        waittillframeend;
        wait 3;
        maps\_utility::activate_trigger_with_targetname( "trig_color_foam_planted" );
        level.burke maps\_utility::delaythread( 0.05, maps\_utility::disable_ai_color );
        level.cormack maps\_utility::delaythread( 0.05, maps\_utility::disable_ai_color );
        level.knox maps\_utility::delaythread( 0.05, maps\_utility::disable_ai_color );
    }

    common_scripts\utility::flag_wait( "flag_foam_room_complete_dialogue" );
    common_scripts\utility::flag_set( "flag_enable_battle_chatter" );
    level.burke maps\_utility::enable_ai_color();
    level.cormack maps\_utility::enable_ai_color();
    level.knox maps\_utility::enable_ai_color();
    level.burke.ignoreall = 0;
    level.cormack.ignoreall = 0;
    level.knox.ignoreall = 0;
    level.cormack notify( "goal_changed" );
    level.knox notify( "goal_changed" );
    level.burke notify( "goal_changed" );

    if ( !common_scripts\utility::flag( "flag_obj_courtyard_jammer_start" ) )
    {
        waittillframeend;
        wait 0.75;
        level.cormack.goalradius = 2048;
        level.knox.goalradius = 2048;
        level.burke.goalradius = 2048;
        maps\_utility::activate_trigger_with_targetname( "trig_color_foam_room_exit" );
    }

    wait 2.5;
    thread maps\_utility::autosave_by_name( "courtyard_start" );
}

foam_room_clear_think()
{
    var_0 = getent( "vol_foam_room_clear", "targetname" );

    while ( !common_scripts\utility::flag( "flag_foam_room_clear" ) )
    {
        if ( level.player istouching( var_0 ) && level.burke istouching( var_0 ) && level.knox istouching( var_0 ) && level.cormack istouching( var_0 ) )
        {
            common_scripts\utility::flag_set( "flag_foam_room_clear" );
            thread foam_room_door_02_close();
            continue;
        }

        wait 0.1;
    }
}

se_knox_courtyard_hangar_door_hack_open()
{
    common_scripts\utility::flag_wait( "flag_hangar_mech_01_dead" );
    var_0 = common_scripts\utility::getstruct( "knox_courtyard_hangar_door_hack_open_org", "targetname" );
    var_0 maps\_anim::anim_reach_solo( level.knox, "courtyard_hangar_door_hack_enter" );
    common_scripts\utility::flag_set( "flag_courtyard_door_hack_dialogue" );
    soundscripts\_snd::snd_message( "aud_courtyard_hangar_door_hack", level.scr_anim["knox"]["courtyard_hangar_door_hack_enter"], level.knox );
    var_0 maps\_anim::anim_single_solo( level.knox, "courtyard_hangar_door_hack_enter" );
    soundscripts\_snd::snd_message( "aud_courtyard_hangar_door_hack_idle", level.scr_anim["knox"]["courtyard_hangar_door_hack_idle"][0], level.knox );
    var_0 thread maps\_anim::anim_loop_solo( level.knox, "courtyard_hangar_door_hack_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_hack_success" );
    var_0 notify( "ender" );
    level.knox maps\_utility::anim_stopanimscripted();
    level notify( "hack_success" );
    soundscripts\_snd::snd_message( "aud_courtyard_hangar_door_open" );
    var_0 maps\_anim::anim_single_solo( level.knox, "courtyard_hangar_door_hack_exit" );
}

se_foam_room_bomb()
{
    level.player thread handle_foam_detonator();
    level.player waittill( "detonate" );
    var_0 = getent( "org_foam_research", "targetname" );
    level notify( "vfx_foam_room_explode_start" );
}

handle_foam_detonator()
{
    level.player endon( "detonate" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_foam_room_clear" );
        maps\_utility::display_hint( "detonate_frb" );
        level.player thread maps\_foam_bomb::handle_detonator();
        common_scripts\utility::flag_waitopen( "flag_foam_room_clear" );
        self switchtoweapon( self.old_weapon );
        self takeweapon( level.c4_weaponname );
    }
}

se_foam_corridor_bomb( var_0 )
{
    var_1 = maps\_utility::spawn_anim_model( "foam_bomb" );
    thread maps\_anim::anim_single_solo( var_1, "foam_corridor_exit" );
    soundscripts\_snd::snd_message( "foam_grenade", level.burke );
    level waittill( "foam_grenade_detonate" );
    var_1 delete();
    level notify( "vfx_foam_corridor_explode_start" );
    var_2 = getent( "blocker_foam_corridor", "targetname" );
    var_2 solid();
    var_2 disconnectpaths();
    var_2 moveto( var_2.origin + ( 0, 156, 0 ), 5, 0.25, 0.25 );
    wait 3.0;
    thread tank_hangar_door_open();
    common_scripts\utility::flag_set( "flag_foam_corridor_exit_door_open_dialogue" );
    wait 3.0;
    cleanup_foam_corridor_enemies();
}

se_foam_corridor_grenade()
{
    level.burke waittillmatch( "single anim", "burke_grenade_hold" );
    var_0 = spawn( "script_model", level.burke gettagorigin( "tag_inhand" ) );
    var_0 setmodel( "projectile_m67fraggrenade" );
    var_0 linkto( level.burke, "tag_inhand" );
    var_1 = common_scripts\utility::getstruct( "struct_foam_corridor_grenade_dest", "targetname" );
    level.burke waittillmatch( "single anim", "burke_grenade_release" );
    var_0 delete();
    var_2 = level.burke gettagorigin( "tag_inhand" );
    var_3 = magicgrenade( "fraggrenade", var_2, var_1.origin, 2.0 );
    var_3 waittill( "death" );

    foreach ( var_5 in getaiarray( "axis" ) )
    {
        if ( isdefined( var_5.magic_bullet_shield ) && var_5.magic_bullet_shield == 1 )
            var_5 maps\_utility::stop_magic_bullet_shield();
    }

    radiusdamage( var_1.origin, 300, 99999, 99999 );
    common_scripts\utility::flag_wait( "foam_corridor_end" );
    thread tank_hangar_door_open();
    wait 0.5;
    common_scripts\utility::flag_set( "flag_foam_corridor_exit_door_open_dialogue" );
}

debug_track( var_0 )
{
    for (;;)
        wait 0.05;
}

se_foam_corridor_guy_4()
{

}

se_foam_corridor()
{
    level.burke.dontmelee = 1;
    level.knox.dontmelee = 1;
    level.cormack.dontmelee = 1;
    level.burke maps\_utility::disable_ai_color();
    level.knox maps\_utility::disable_ai_color();
    level.cormack maps\_utility::disable_ai_color();
    var_0 = getent( "blocker_foam_corridor", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    var_1 = common_scripts\utility::getstruct( "foam_corridor_anim_node", "targetname" );
    var_2 = spawn( "script_origin", var_1.origin );

    if ( isdefined( var_1.angles ) )
        var_2.angles = var_1.angles;

    var_3 = "foam_corridor_in";
    var_4 = "foam_corridor_idle";
    var_5 = "foam_corridor_grenade_throw";
    var_6 = "foam_corridor_idle_2";
    var_7 = "foam_corridor_exit";
    var_8 = "foam_corridor_idle_end";
    var_9 = "foam_corridor_idle2_end";
    var_10 = [];
    var_10[var_10.size] = level.burke;
    var_10[var_10.size] = level.knox;
    var_10[var_10.size] = level.cormack;
    common_scripts\utility::trigger_off( "trigger_foam_corridor_end", "targetname" );
    common_scripts\utility::array_thread( var_10, ::se_foam_corridor_approach, var_2, var_3, var_4, var_8 );
    common_scripts\utility::flag_set( "flag_foam_corridor_another_door_dialogue" );
    level waittill( "foam_corridor_squadmate_ready" );
    level waittill( "foam_corridor_squadmate_ready" );
    level waittill( "foam_corridor_squadmate_ready" );
    common_scripts\utility::flag_wait( "foam_corridor_start" );
    common_scripts\utility::flag_waitopen( "flag_player_inside_foam_corridor" );
    common_scripts\utility::flag_set( "flag_foam_corridor_improvise_dialogue" );
    var_11 = common_scripts\utility::getstruct( "hovertank_reveal_org", "targetname" );
    var_12 = maps\_utility::spawn_anim_model( "hovertank", level.hovertank.origin );
    level.hovertank hide();
    thread se_hovertank_reveal_actor( var_12, var_11 );
    var_2 notify( var_8 );
    thread se_foam_corridor_grenade();
    var_2 maps\_anim::anim_single( var_10, var_5 );
    var_2 thread maps\_anim::anim_loop( var_10, var_6, var_9 );
    common_scripts\utility::trigger_on( "trigger_foam_corridor_end", "targetname" );
    common_scripts\utility::flag_wait( "foam_corridor_end" );
    var_2 notify( var_9 );

    foreach ( var_14 in var_10 )
    {
        var_15 = spawnstruct();
        var_15 thread maps\_utility::function_stack( ::foam_room_end_animation, var_14, var_1, var_7 );
        var_15 thread maps\_utility::function_stack( ::se_hovertank_reveal_actor, var_14, var_11 );
    }

    common_scripts\utility::flag_set( "flag_foam_corridor_exit" );
    level.burke.dontmelee = 0;
    level.knox.dontmelee = 0;
    level.cormack.dontmelee = 0;
    level.burke maps\_utility::enable_ai_color_dontmove();
    level.knox maps\_utility::enable_ai_color_dontmove();
    level.cormack maps\_utility::enable_ai_color_dontmove();
    var_2 delete();
}

foam_room_end_animation( var_0, var_1, var_2 )
{
    var_1 maps\_anim::anim_single_solo_run( var_0, var_2 );
}

se_foam_corridor_approach( var_0, var_1, var_2, var_3 )
{
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    var_0 maps\_anim::anim_single_solo( self, var_1 );
    var_0 thread maps\_anim::anim_loop_solo( self, var_2, var_3 );
    level notify( "foam_corridor_squadmate_ready" );
}

se_exfil()
{
    common_scripts\utility::flag_wait( "flag_exfil_start" );
    common_scripts\utility::flag_set( "flag_exfil_start_dialogue" );
    var_0 = common_scripts\utility::getstruct( "org_se_exfil", "targetname" );
    thread maps\lab_lighting::exfil();
    var_1 = common_scripts\utility::getstruct( "hovertank_exit_burke_position", "targetname" );
    level.burke maps\_utility::anim_stopanimscripted();
    level.burke forceteleport( var_1.origin, var_1.angles, 1000 );
    var_2 = common_scripts\utility::getstruct( "hovertank_exit_knox_position", "targetname" );
    level.knox maps\_utility::anim_stopanimscripted();
    level.knox forceteleport( var_2.origin, var_2.angles, 1000 );
    level.knox setgoalnode( getnode( "knox_exfil_node", "targetname" ) );
    level.burke pushplayer( 1 );
    level.cormack pushplayer( 1 );
    level.burke.moveplaybackrate = 0.9;
    level.knox.moveplaybackrate = 0.9;
    level.player maps\_utility::blend_movespeedscale_percent( 80 );
    thread cormack_exfil_approach( var_0 );
    level.burke thread burke_exfil_approach( var_0, "exfil_burke_enter" );
    var_3 = [ level.burke ];
    common_scripts\utility::flag_wait( "flag_burke_ready_for_exfil" );
    var_0 notify( "fly_in_idle_stop" );
    var_0 thread maps\_anim::anim_single( var_3, "exfil_burke_enter" );
    var_0 maps\_anim::anim_single( var_3, "exfil_burke_enter" );
    var_0 thread maps\_anim::anim_loop( var_3, "exfil_hover_idle", "exfil_hover_idle_stop" );
    common_scripts\utility::flag_set( "flag_player_exfil_enter_ready" );
    thread se_player_exfil_out_of_bounds_check();
    common_scripts\utility::flag_wait( "flag_player_exfil_enter" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "flag_exfil_dialogue" );
    thread maps\lab_lighting::exfil_dof();
    var_0 notify( "exfil_hover_idle_stop" );
    var_0 notify( "exfil_hover_idle_stop" );
    waittillframeend;
    maps\_player_exo::player_exo_deactivate();
    maps\_player_exo::player_exo_add_single( "exo_melee" );
    var_4 = maps\_utility::spawn_anim_model( "player_rig_intro" );
    var_4.animname = "player_rig_intro";
    var_4.weapon = "none";
    var_4 hide();
    level.razorback maps\_anim::anim_first_frame_solo( var_4, "exfil_enter", "tag_guy1" );
    level notify( "player_enters_razorback" );
    var_5 = 0.5;
    level.player playerlinktoblend( var_4, "tag_player", var_5 );
    level.player maps\_utility::add_wait( maps\_shg_utility::setup_player_for_scene, 1 );
    var_4 maps\_utility::add_call( ::show );
    thread maps\_utility::do_wait();
    var_3 = [ level.cormack, level.burke, level.knox, var_4 ];

    foreach ( var_7 in var_3 )
        var_7 linkto( level.razorback, "tag_guy1" );

    level.razorback thread maps\_anim::anim_single( var_3, "exfil_enter", "tag_guy1" );
    maps\_utility::delaythread( 4, common_scripts\utility::flag_set, "flag_obj_battle_exfil_complete" );
    maps\_utility::delaythread( 12, common_scripts\utility::flag_set, "flag_burke_destroy_tank" );
    maps\_utility::delaythread( 30, common_scripts\utility::flag_set, "flag_mission_complete" );
    level waittill( "level_fade_out" );
    var_9 = 3;
    maps\lab_utility::ending_fade_out( var_9 );
    wait(var_9);
    maps\_utility::nextmission();
}

se_player_exfil_out_of_bounds_check()
{
    var_0 = getent( "obj_battle_exfil_04", "targetname" );

    while ( !common_scripts\utility::flag( "flag_player_exfil_enter" ) )
    {
        if ( distance( level.player.origin, var_0.origin ) > 2000 )
        {
            common_scripts\utility::flag_clear( "flag_player_close_to_exfil" );
            maps\_utility::display_hint_timeout( "hint_dont_leave_mission", 5 );

            if ( distance( level.player.origin, var_0.origin ) > 3000 )
            {
                common_scripts\utility::flag_set( "flag_player_close_to_exfil" );
                level notify( "mission failed" );
                setdvar( "ui_deadquote", &"LAB_MISSION_FAILED_LEFT_MISSION" );
                maps\_utility::missionfailedwrapper();
            }
        }
        else
            common_scripts\utility::flag_set( "flag_player_close_to_exfil" );

        wait 0.3;
    }

    common_scripts\utility::flag_set( "flag_player_close_to_exfil" );
}

break_exfil_out_bounds()
{
    if ( common_scripts\utility::flag( "flag_player_close_to_exfil" ) )
        return 1;
    else
        return 0;
}

se_exfil_razorback( var_0 )
{
    common_scripts\utility::flag_set( "flag_obj_show_razorback_marker" );
    var_1 = common_scripts\utility::getstruct( "org_se_exfil", "targetname" );
    level.razorback = maps\_vehicle::spawn_vehicle_from_targetname( "helo_exfil" );
    soundscripts\_snd::snd_message( "razorback_land" );
    level.razorback.animname = "razorback";
    level.razorback maps\_anim::setanimtree();
    level.razorback thread maps\lab_fx::se_exfil_fx();
    thread maps\lab_lighting::razorback_lighting( level.razorback );
    thread maps\lab_lighting::burke_exfil_lighting();
    var_0 = maps\_utility::spawn_targetname( "guy_helo_exfil" );
    var_0.animname = "guy_exfil";
    var_2 = maps\_utility::spawn_targetname( "guy_helo_exfil_pilot" );
    var_2.animname = "guy_exfil_pilot";
    var_2 maps\_utility::gun_remove();
    var_2 linkto( level.razorback, "tag_guy1" );
    level.razorback thread maps\_anim::anim_loop_solo( var_2, "exfil_pilot_idle", "ender", "tag_guy1" );
    var_3 = [ var_0, level.razorback ];
    var_1 thread maps\_anim::anim_single( var_3, "exfil_fly_in" );
    thread handle_player_close_to_aircraft_rumbles();
    common_scripts\utility::waittill_any_ents( level, "flag_burke_ready_for_exfil", var_1, "exfil_fly_in" );

    if ( !common_scripts\utility::flag( "flag_burke_ready_for_exfil" ) )
        var_1 thread maps\_anim::anim_loop( var_3, "exfil_fly_in_idle", "fly_in_idle_stop" );

    common_scripts\utility::flag_wait( "flag_burke_ready_for_exfil" );
    level notify( "thruster_front_off" );
    var_1 notify( "fly_in_idle_stop" );
    var_0 maps\_utility::anim_stopanimscripted();
    var_1 thread maps\_anim::anim_single( var_3, "exfil_burke_enter" );
    var_1 maps\_anim::anim_single( var_3, "exfil_burke_enter" );
    var_1 thread maps\_anim::anim_loop( var_3, "exfil_hover_idle", "exfil_hover_idle_stop" );
    common_scripts\utility::flag_wait( "flag_player_exfil_enter" );
    var_1 notify( "exfil_hover_idle_stop" );
    waittillframeend;
    var_3 = [ var_0 ];
    var_0 maps\_utility::anim_stopanimscripted();
    var_1 thread maps\_anim::anim_single_solo( level.razorback, "exfil_enter" );

    foreach ( var_0 in var_3 )
        var_0 linkto( level.razorback, "tag_guy1" );

    level.razorback thread maps\_anim::anim_single( var_3, "exfil_enter", "tag_guy1" );
}

burke_exfil_approach( var_0, var_1 )
{
    var_0 maps\_anim::anim_reach_solo( self, var_1 );
    common_scripts\utility::flag_set( "flag_burke_ready_for_exfil" );
}

cormack_exfil_approach( var_0 )
{
    var_0 maps\_anim::anim_reach_solo( level.cormack, "exfil_cormack_approach" );
    maps\_utility::delaythread( 2, common_scripts\utility::flag_set, "flag_exfil_loadup_dialogue" );
    var_0 maps\_anim::anim_single_solo( level.cormack, "exfil_cormack_approach" );
    var_0 thread maps\_anim::anim_loop_solo( level.cormack, "exfil_cormack_approach_idle", "ender" );
    common_scripts\utility::flag_wait( "flag_player_exfil_enter" );
    level.cormack stopanimscripted();
    var_0 notify( "ender" );
}

setup_combat()
{
    setup_spawn_functions();
    setup_hovertank();
    thread player_stealth_cloak_think();
    thread setup_clip();
    thread setup_triggers();
    thread combat_gaz_bridge();
    thread forest_ambient_enemy_se();
    thread foreat_stealth_ambient_vehicle_drive_by();
    thread combat_forest_patrols_start();
    thread logging_road_loud_combat();
    thread combat_logging_road_end();
    thread combat_research_building();
    thread combat_research_building_bridge();
    thread combat_research_pool_walkway_01();
    thread combat_research_left_01();
    thread combat_research_right_01();
    thread combat_research_pool_room();
    thread combat_research_platform_01();
    thread combat_courtyard_path_general();
    thread combat_courtyard_jammer();
    thread combat_courtyard_jammer_complete();
    thread skip_foam_corridor();
    thread cleanup_courtyard_enemies();
    thread open_hangar_doors();
    thread combat_tank_road();
    thread courtyard_gate_think( 1 );
    thread courtyard_gate_think( 2 );
}

combat_gaz_bridge()
{
    common_scripts\utility::flag_wait( "flag_increase_sinper_shots_01" );
    wait 3;
    var_0 = getent( "gaz_bridge_02", "targetname" );
}

helo_spotlight_logging_road()
{
    if ( !isdefined( level.start_point ) || level.start_point != "logging_road" )
        common_scripts\utility::flag_wait( "flag_se_takedown_01_complete" );

    level.helo_spotlight_logging_road = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "helo_spotlight_logging_road" );
    level.helo_spotlight_logging_road soundscripts\_snd::snd_message( "aud_patrol_helo_debris_sfx" );
    level.helo_spotlight_logging_road maps\_vehicle::godon();
    level.helo_spotlight_logging_road maps\_utility::ent_flag_init( "spotlight_on" );
    level.helo_spotlight_logging_road.spotlight = spawnturret( "misc_turret", level.helo_spotlight_logging_road gettagorigin( "tag_flash" ), "heli_spotlight_so_castle" );
    level.helo_spotlight_logging_road.spotlight setmode( "manual" );
    level.helo_spotlight_logging_road.spotlight setmodel( "com_blackhawk_spotlight_on_mg_setup" );
    level.helo_spotlight_logging_road.spotlight maketurretinoperable();
    level.helo_spotlight_logging_road.spotlight makeunusable();
    level.helo_spotlight_logging_road.spotlight.angles = level.helo_spotlight_logging_road gettagangles( "tag_flash" );
    level.helo_spotlight_logging_road.spotlight linkto( level.helo_spotlight_logging_road, "tag_flash", ( 0, 2, -6 ), ( 0, 90, -20 ) );
    level.helo_spotlight_logging_road thread helo_spotlight_think( "docks_heli_spotlight_cheap" );
    level.helo_spotlight_logging_road thread helo_spotlight_point_of_interest_tracking();
    level.helo_spotlight_logging_road maps\_utility::ent_flag_set( "spotlight_on" );
    level.helo_spotlight_logging_road maps\_vehicle::mgoff();
    level.helo_spotlight_logging_road thread helo_spotlight_logging_road_break_off();
    common_scripts\utility::flag_wait( "flag_helo_logging_road_end" );
    level.helo_spotlight_logging_road.spotlight delete();
}

helo_spotlight_logging_road_break_off()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "flag_logging_road_loud_combat" );
    self notify( "newpath" );
    maps\_utility::vehicle_liftoff( 512 );
    maps\_utility::vehicle_dynamicpath( common_scripts\utility::getstruct( "logging_road_chopper_detour", "targetname" ) );
}

combat_forest_patrols_start()
{
    if ( !isdefined( level.start_point ) || level.start_point != "logging_road" )
        common_scripts\utility::flag_wait( "flag_se_takedown_01_complete" );

    level.patrol_01 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_01", 1 );
    level.patrol_01 force_patrol_anim_set( "active_right", 1 );
    level.patrol_01 thread guy_patrol_takedown_02();
    var_0 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_02", 1 );
    var_0 force_patrol_anim_set( "active_left", 1 );
    var_1 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_03", 1 );
    var_1 force_patrol_anim_set( "gundown" );
    var_2 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_04", 1 );
    var_2 force_patrol_anim_set( "active", 1 );
    var_3 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_06", 1 );
    var_3 force_patrol_anim_set( "creepwalk" );
    var_4 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_07", 1 );
    var_4 force_patrol_anim_set( "creepwalk" );
    var_5 = [ level.patrol_01, var_0, var_1, var_2, var_3, var_4 ];
    soundscripts\_snd::snd_message( "combat_forest_patrols_start", var_5 );
    thread helo_spotlight_logging_road();

    foreach ( var_7 in var_5 )
    {
        if ( isdefined( var_7.pdroneactive ) && var_7.pdroneactive )
            var_7 thread start_search_drone_behavior_when_pdrone_follower_spawned();
    }

    common_scripts\utility::flag_wait( "flag_forest_drive_by_01" );
    var_9 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_08", 1 );
    var_9 force_patrol_anim_set( "casualkiller" );
    var_10 = maps\_utility::spawn_targetname( "enemy_stealth_patrol_09", 1 );
    var_10 force_patrol_anim_set( "casualkiller" );
}

start_search_drone_behavior_when_pdrone_follower_spawned()
{
    self endon( "death" );

    while ( !isdefined( self.pdrone ) )
        wait 0.5;

    if ( isdefined( self.script_stealthgroup ) )
        self.pdrone.script_stealthgroup = self.script_stealthgroup;

    thread search_drone_behavior( self.pdrone );
}

set_flag_on_death( var_0, var_1, var_2, var_3 )
{
    self waittill( "death" );

    if ( isdefined( var_0 ) )
        common_scripts\utility::flag_set( var_0 );

    if ( isdefined( var_1 ) )
        common_scripts\utility::flag_set( var_1 );

    if ( isdefined( var_2 ) )
        common_scripts\utility::flag_set( var_2 );

    if ( isdefined( var_3 ) )
        common_scripts\utility::flag_set( var_3 );
}

patrol_03_idle_think()
{
    common_scripts\utility::flag_wait( "flag_patrol_03_idle" );
    var_0 = common_scripts\utility::getstruct( "forest_stealth_ambiant_01_org", "targetname" );
    var_0 maps\_anim::anim_loop_solo( self, "patrol_sit_idle", "ender" );
}

forest_ambient_enemy_se()
{
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    var_0 = maps\_utility::spawn_targetname( "enemy_stealth_ambient_02", 1 );
    var_0 maps\_flashlight_cheap::add_cheap_flashlight( "flashlight" );
    var_1 = maps\_utility::spawn_targetname( "enemy_stealth_ambient_04", 1 );
    var_1 maps\_flashlight_cheap::add_cheap_flashlight( "flashlight" );
    var_2 = maps\_utility::spawn_targetname( "enemy_stealth_ambient_05", 1 );
    var_2 maps\_flashlight_cheap::add_cheap_flashlight( "flashlight" );
    soundscripts\_snd::snd_message( "combat_forest_patrols_start", [ var_0, var_1, var_2 ] );
}

flag_wait_both_or_timeout( var_0, var_1, var_2 )
{
    var_3 = var_2 * 1000;
    var_4 = gettime();

    for (;;)
    {
        if ( common_scripts\utility::flag( var_0 ) && common_scripts\utility::flag( var_1 ) )
            break;

        if ( gettime() >= var_4 + var_3 )
            break;

        wait 0.05;
    }
}

burke_forest_stealth_movement()
{
    level.burke pushplayer( 1 );
    level.burke.dontavoidplayer = 1;
    level.burke.dontchangepushplayer = 1;
    level endon( "flag_ready_burke_for_mech_march" );

    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
        return;

    level endon( "flag_logging_road_loud_combat" );
    var_0 = getnode( "node_burke_forest_stealth_01", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait_all( "flag_patroler_takedown_02_follow_a", "flag_forest_drive_by_01", "flag_burke_forest_01_moveup" );
    var_0 = getnode( "node_burke_takedown_02_follow", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait_all( "flag_patroler_takedown_02_follow_b", "flag_forest_drive_by_02" );

    if ( !common_scripts\utility::flag( "flag_patroler_takedown_02_ready" ) )
    {
        var_0 = getnode( "node_burke_takedown_02", "targetname" );
        level.burke maps\lab_utility::goto_node( var_0, 1 );
        level.burke maps\_utility::set_moveplaybackrate( 0.7 );
    }
    else
        level.burke maps\_utility::set_moveplaybackrate( 1 );

    if ( isdefined( level.patrol_01 ) && isalive( level.patrol_01 ) )
        thread burke_patrol_takedown_02( level.patrol_01 );
    else
    {
        common_scripts\utility::flag_set( "flag_se_takedown_02_complete" );
        var_0 = getnode( "node_burke_takedown_02", "targetname" );
        level.burke maps\lab_utility::goto_node( var_0, 1 );
    }

    common_scripts\utility::flag_wait_all( "flag_se_takedown_02_complete", "flag_patroler_06_clear", "flag_patroler_07_clear", "flag_patroler_03_clear" );
    var_0 = getnode( "node_burke_forest_stealth_02", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    level.burke maps\_utility::set_moveplaybackrate( 1 );
    var_1 = getnodearray( "node_logging_road", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 disconnectnode();

    wait 1;
    common_scripts\utility::flag_set( "flag_recharge_cloak_01" );
    maps\_utility::display_hint_timeout( "exo_toggle_hint", 5 );
    level.burke maps\lab_utility::ai_toggle_cloak_animate( 2, 0, "right" );

    if ( common_scripts\utility::flag( "flag_forest_player_alt_path_01" ) )
    {
        common_scripts\utility::flag_set( "flag_move_to_vehicle_takedown_01" );
        common_scripts\utility::flag_set( "flag_move_to_vrap_takedown" );
    }

    flag_wait_both_or_timeout( "flag_move_to_vrap_takedown", "flag_aproach_vehicle_dialogue_complete", 12 );
    common_scripts\utility::flag_set( "flag_move_to_vehicle_takedown_01" );
    var_0 = getnode( "node_burke_forest_stealth_03", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );

    foreach ( var_3 in var_1 )
        var_3 connectnode();

    common_scripts\utility::flag_wait_any( "flag_se_vehicle_takedown_01_complete", "flag_forest_player_alt_path_01" );

    if ( !common_scripts\utility::flag( "flag_se_vehicle_takedown_01_failed" ) && !common_scripts\utility::flag( "flag_forest_player_alt_path_01" ) )
    {
        var_0 = getnode( "node_burke_forest_stealth_04", "targetname" );
        level.burke maps\lab_utility::goto_node( var_0, 1 );
    }
    else
    {
        common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );
        common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_failed" );
    }

    wait 2;
    common_scripts\utility::flag_wait( "flag_drone_pass_02" );
    var_0 = getnode( "node_burke_forest_stealth_05", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait( "flag_recharge_cloak_trench" );
    level.burke maps\lab_utility::ai_toggle_cloak_animate( -1, -1 );
    var_0 = getnode( "node_burke_forest_stealth_06", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 0 );
    common_scripts\utility::flag_wait( "flag_trench_complete" );
    var_0 = getnode( "node_burke_forest_stealth_14", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 0 );
    level.burke maps\_utility::enable_cqbwalk();
}

burke_mech_march_movement()
{
    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
        return;

    level endon( "flag_logging_road_loud_combat" );
    level endon( "flag_cormack_meet_init" );
    common_scripts\utility::flag_wait( "flag_ready_burke_for_mech_march" );
    level.burke pushplayer( 1 );
    level.burke.dontavoidplayer = 1;
    level.burke.dontchangepushplayer = 1;
    level.burke maps\_utility::set_moveplaybackrate( 1 );

    if ( !isdefined( level.start_point ) || level.start_point != "mech_march" )
        maps\_utility::autosave_stealth();

    var_0 = getnode( "node_burke_forest_stealth_07", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    wait 0.5;
    level.burke maps\lab_utility::ai_toggle_cloak_animate( 1, 0 );
    level notify( "burke_recharge_mech_done" );
    common_scripts\utility::flag_wait( "flag_mech_march_hide_right" );
    var_0 = getnode( "node_burke_forest_stealth_08", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait( "flag_mech_march_hide_right_complete" );
    var_0 = getnode( "node_burke_forest_stealth_09", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait_any( "flag_logging_road_seeker_01", "flag_gaz_01_scanner_on" );
    var_0 = getnode( "node_burke_forest_stealth_10", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    level.burke maps\_utility::disable_cqbwalk();
    level.burke maps\_utility::delaythread( 5, maps\_utility::enable_sprint );
    common_scripts\utility::flag_wait_all( "flag_seeker_patrol_01_clear", "flag_seeker_patrol_02_clear", "flag_seeker_patrol_03_clear", "flag_seeker_patrol_04_clear" );
    common_scripts\utility::flag_set( "flag_seeker_patrol_01_clear" );
    thread advance_gideon_if_player_ahead();
    common_scripts\utility::flag_wait_all( "flag_move_up_seeker_01", "flag_seeker_cone_safe_right" );
    var_0 = getnode( "node_burke_forest_stealth_11", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    common_scripts\utility::flag_wait_all( "flag_move_up_seeker_02", "flag_seeker_cone_safe_left" );
    var_0 = getnode( "node_burke_forest_stealth_12", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    level.burke maps\_utility::enable_cqbwalk();
    level.burke maps\_utility::disable_sprint();
    common_scripts\utility::flag_wait( "flag_move_up_seeker_03" );
    var_0 = getnode( "node_burke_forest_stealth_13", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 1 );
    level.burke maps\_utility::enable_cqbwalk();
    common_scripts\utility::flag_wait( "flag_exit_seeker_area" );
    common_scripts\utility::flag_set( "flag_obj_crawl_under_log" );
    var_0 = getnode( "node_burke_forest_stealth_15", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 0 );
    level.burke maps\_utility::enable_cqbwalk();
}

advance_gideon_if_player_ahead()
{
    common_scripts\utility::flag_wait( "flag_move_up_seeker_03" );
    common_scripts\utility::flag_set( "flag_move_up_seeker_01" );
    common_scripts\utility::flag_set( "flag_move_up_seeker_02" );
}

burke_patrol_takedown_02( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "stealth_enemy_endon_alert" );
    var_0.animname = "guy";
    var_1 = common_scripts\utility::getstruct( "forest_takedown_02_org", "targetname" );
    var_0 thread maps\_stealth_utility::stealth_enemy_endon_alert();
    thread burke_patrol_takedown_02_cleanup( var_0, "death", var_0, "stealth_enemy_endon_alert", var_1, "forest_takedown_02" );
    common_scripts\utility::flag_wait_all( "flag_patroler_03_clear", "flag_patroler_06_clear", "flag_patroler_07_clear", "flag_patroler_takedown_02_ready" );

    if ( isalive( var_0 ) )
    {
        level.burke notify( "stop_goto_node" );
        var_1 maps\_anim::anim_reach_solo( level.burke, "forest_takedown_02", undefined, 1 );
        level notify( "patrol_takedown_02_start" );
        var_1 thread maps\_anim::anim_single_solo( level.burke, "forest_takedown_02" );
        level.burke soundscripts\_snd::snd_message( "burke_solo_takedown", var_0 );
    }
}

guy_patrol_takedown_02()
{
    self endon( "death" );
    self endon( "stealth_enemy_endon_alert" );
    self endon( "alerted" );
    self.animname = "guy";
    var_0 = common_scripts\utility::getstruct( "forest_takedown_02_org", "targetname" );
    common_scripts\utility::flag_wait( "flag_patroler_takedown_02_reach_start" );
    var_0 maps\_anim::anim_reach_solo( self, "forest_takedown_02_loser_enter" );
    var_0 maps\_anim::anim_single_solo( self, "forest_takedown_02_loser_enter" );
    var_0 thread maps\_anim::anim_loop_solo( self, "forest_takedown_02_loser_idle", "ender" );
    thread guy_patrol_takedown_02_alert_check( var_0 );
    common_scripts\utility::flag_set( "flag_patroler_takedown_02_ready" );
    level waittill( "patrol_takedown_02_start" );
    var_0 notify( "ender" );
    maps\_utility::anim_stopanimscripted();
    self.ignoresonicaoe = 1;
    var_0 thread maps\_anim::anim_single_solo( self, "forest_takedown_02_loser" );
    level waittill( "forest_takedown_02_guy_stabbed" );
    thread forest_takedown_02_ai_kill( self );
    var_0 waittill( "forest_takedown_02" );
    self kill();
}

guy_patrol_takedown_02_alert_check( var_0 )
{
    self endon( "death" );
    level endon( "forest_takedown_02_guy_stabbed" );
    common_scripts\utility::waittill_any_ents( self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "_stealth_found_corpse", self, "alerted", self, "enemy", self, "touch" );
    self notify( "alerted" );
    var_0 notify( "ender" );
    maps\_utility::anim_stopanimscripted();

    if ( isdefined( self.flashlight ) )
        self.flashlight delete();
}

forest_takedown_02_ai_kill( var_0 )
{
    if ( !isalive( var_0 ) )
        return;

    var_0.allowdeath = 1;
    var_0.a.nodeath = 1;
    var_0 maps\_utility::set_battlechatter( 0 );
    var_0.ignoreall = 1;
}

burke_patrol_takedown_02_cleanup( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    common_scripts\utility::waittill_any_ents( var_0, var_1, var_2, var_3, var_4, var_5 );
    common_scripts\utility::flag_set( "flag_se_takedown_02_complete" );
    level.burke maps\_utility::anim_stopanimscripted();

    if ( isalive( var_0 ) )
        var_0 maps\_utility::anim_stopanimscripted();
}

foreat_stealth_ambient_vehicle_drive_by()
{
    common_scripts\utility::flag_wait( "flag_forest_drive_by_01" );
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "gaz_raod_drive_by_01" );
    var_0 maps\_vehicle::vehicle_lights_on();
    var_0 soundscripts\_snd::snd_message( "gaz_01_dist_by" );
    var_0 thread forest_stealth_gaz_think();
    var_0 thread maps\lab_fx::logging_road_mud_tracks();
    wait 1.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "gaz_raod_drive_by_02" );
    var_1 maps\_vehicle::vehicle_lights_on();
    var_1 soundscripts\_snd::snd_message( "gaz_02_dist_by" );
    var_1 thread forest_stealth_gaz_think();
    var_1 thread maps\lab_fx::logging_road_mud_tracks();
    wait 0.5;
    common_scripts\utility::flag_wait( "flag_forest_drive_by_02" );
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "gaz_raod_drive_by_03" );
    var_2 maps\_vehicle::vehicle_lights_on();
    var_2 soundscripts\_snd::snd_message( "gaz_03_close_by" );
    var_2 thread forest_stealth_gaz_think();
    var_2 thread maps\lab_fx::logging_road_mud_tracks();
    common_scripts\utility::flag_wait_all( "flag_se_takedown_02_complete", "flag_move_to_vehicle_takedown_01" );
    common_scripts\utility::flag_set( "flag_move_to_vrap_takedown" );
    thread drones_logging_road();
}

forest_stealth_gaz_think( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "_stealth_spotted" );

    if ( !isdefined( var_0 ) || !var_0 )
        wait(randomfloat( 0.5 ));
    else
    {
        while ( length( self vehicle_getvelocity() ) > 0 )
            wait 0.5;

        common_scripts\utility::flag_set( "flag_gaz_01_scanner_on" );
    }

    self vehicle_setspeed( 0, 10, 10 );
    self notify( "vehicle_stopping" );
    var_1 = maps\_vehicle::vehicle_unload();

    foreach ( var_3 in var_1 )
        var_3 thread maps\_utility::player_seek();
}

helo_spotlight_point_of_interest_tracking()
{
    self endon( "death" );
    var_0 = 1000;
    var_1 = 500;
    var_2 = 3;
    var_3 = 10;
    var_4 = spawnstruct();
    var_4.origin = ( 0, 0, 0 );
    self.override_target = var_4;
    var_5 = common_scripts\utility::getstructarray( "spotlight_point_of_interest", "targetname" );

    for (;;)
    {
        var_6 = self.origin + anglestoforward( self.angles ) * var_0;
        var_7 = [];

        foreach ( var_9 in var_5 )
        {
            if ( distance2d( var_6, var_9.origin ) < var_1 )
                var_7[var_7.size] = var_9;
        }

        if ( var_7.size > 0 )
        {
            var_4.origin = var_7[randomint( var_7.size )].origin;
            self.spotlight common_scripts\utility::waittill_notify_or_timeout( "turret_on_target", 10 );
            wait(randomfloatrange( var_2, var_3 ));
            continue;
        }

        wait 1;
    }
}

combat_logging_road_end()
{
    common_scripts\utility::flag_wait( "flag_logging_road_end_combat" );
    thread logging_road_seeker_save();
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "gaz_logging_road_01" );
    var_0 maps\_vehicle::vehicle_lights_on();
    var_0 soundscripts\_snd::snd_message( "skr_distant_pull_up_and_scan" );
    var_0 thread forest_stealth_gaz_think( 1 );
    level endon( "flag_logging_road_loud_combat" );
    common_scripts\utility::flag_wait( "flag_seeker_patrol_spawn" );
    common_scripts\utility::flag_set( "flag_helo_logging_road_end" );
    maps\_utility::spawn_script_noteworthy( "guy_01_seeker", 1 );
    maps\_utility::spawn_script_noteworthy( "guy_02_seeker", 1 );
    maps\_utility::spawn_script_noteworthy( "guy_03_seeker", 1 );
    maps\_utility::spawn_script_noteworthy( "guy_04_seeker", 1 );
    var_1 = maps\_utility::array_spawn_noteworthy( "seeker_guards", 1 );
    var_0 thread maps\lab_utility::attach_scanner_turret();

    if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
    {
        if ( isdefined( var_1[0] ) && isalive( var_1[0] ) )
        {
            var_1[0] notify( "ai_event", "gunshot" );
            var_1[0] maps\_utility::set_favoriteenemy( level.player );
        }
    }

    common_scripts\utility::flag_wait( "flag_gaz_01_scanner_on" );
    var_0 thread seeker_think();
    var_0 thread maps\lab_utility::attach_scanner( 1500, 15, 15, -5, 50, 10, 200, 50, 0.35, -12, 5, "veh_turret_scanner_search_red", "veh_turret_scanner_search" );
}

logging_road_seeker_save()
{
    level endon( "flag_logging_road_loud_combat" );
    common_scripts\utility::flag_wait( "flag_seeker_checkpoint" );
    thread maps\_utility::autosave_stealth();
}

seeker_think()
{
    self waittill( "reached_dynamic_path_end" );
    level waittill( "_stealth_spotted" );
    maps\_vehicle::vehicle_unload();
}

patrol_creepwalk_unload_spawn_func()
{
    self waittill( "jumpedout" );
}

patrol_01_unload_spawn_func()
{
    force_patrol_anim_set( "casualkiller" );
}

patrol_02_unload_spawn_func()
{
    force_patrol_anim_set( "patroljog" );
}

patrol_03_unload_spawn_func()
{
    force_patrol_anim_set( "casualkiller" );
}

patrol_04_unload_spawn_func()
{
    force_patrol_anim_set( "casualkiller" );
}

logging_road_loud_combat()
{
    level endon( "flag_cormack_meet_init" );
    common_scripts\utility::flag_wait( "_stealth_spotted" );
    common_scripts\utility::flag_set( "flag_logging_road_loud_combat" );
    common_scripts\utility::flag_set( "flag_vo_stealth_broken" );

    if ( isdefined( level.burke.function_stack ) )
        level.burke maps\_utility::function_stack_clear();

    level.burke stopsounds();
    level.burke.alwaysrunforward = undefined;
    maps\_utility::radio_dialogue_stop();
    level.burke maps\_utility::enable_ai_color();
    level.burke maps\_utility::enable_careful();
    level.burke maps\_utility::disable_cqbwalk();
    level.burke maps\lab_utility::cloak_off( 1 );
    level.burke maps\_utility::set_moveplaybackrate( 1 );
    maps\_utility::array_spawn_function_noteworthy( "logging_road_loud_combat_enemy", ::logging_road_loud_combat_enemy_think );

    if ( !common_scripts\utility::flag( "flag_logging_road_field_passed" ) )
        thread logging_road_loud_combat_field();

    if ( !common_scripts\utility::flag( "flag_logging_road_trench_passed" ) )
        thread logging_road_loud_combat_trench();

    if ( !common_scripts\utility::flag( "flag_se_mech_march_start" ) )
        thread logging_road_loud_combat_mech_march();

    if ( !common_scripts\utility::flag( "flag_logging_road_end_combat" ) )
        thread logging_road_loud_combat_end();

    common_scripts\utility::flag_set( "flag_move_up_seeker_03" );
    maps\_player_exo::player_exo_add_single( "exo_melee" );
    common_scripts\utility::flag_wait( "flag_exit_seeker_area" );
    var_0 = getnode( "node_burke_forest_stealth_15", "targetname" );
    level.burke maps\lab_utility::goto_node( var_0, 0 );
    level.burke maps\_utility::enable_cqbwalk();
}

logging_road_loud_combat_enemy_think()
{
    self endon( "death" );
    thread maps\_utility::player_seek();
    self.pathrandompercent = 300;
}

logging_road_loud_combat_field()
{
    var_0 = maps\_utility::array_spawn_targetname( "logging_road_loud_combat_field_enemy" );
}

logging_road_loud_combat_trench()
{
    var_0 = maps\_utility::array_spawn_targetname( "logging_road_loud_combat_trench_enemy" );
}

logging_road_loud_combat_mech_march()
{
    var_0 = maps\_utility::array_spawn_targetname( "logging_road_loud_combat_mechmarch_enemy" );
}

logging_road_loud_combat_end()
{
    var_0 = maps\_utility::array_spawn_targetname( "logging_road_loud_combat_end_enemy" );
}

logging_road_end_drop_logic()
{
    var_0 = getent( "forest_drop_clip", "targetname" );
    var_0 notsolid();
    common_scripts\utility::flag_wait( "flag_logging_road_complete" );
    thread player_near_logging_road_end_log();
    thread player_under_logging_road_end_log();
    common_scripts\utility::flag_wait( "flag_seeker_clear" );
    thread cleanup_ai_logging_road();

    if ( isdefined( level.player.old_weapon ) )
    {
        level.player takeweapon( "iw5_unarmed_nullattach" );
        level.player switchtoweapon( level.player.old_weapon );
        level.player enableweaponswitch();
        level.player.old_weapon = undefined;
    }

    var_0 solid();
}

player_near_logging_road_end_log()
{
    level endon( "flag_seeker_clear" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "player_near_logging_road_end_log" );
        maps\_utility::hintdisplayhandler( "prone_hint" );
        common_scripts\utility::flag_waitopen( "player_near_logging_road_end_log" );
    }
}

player_under_logging_road_end_log()
{
    level endon( "flag_seeker_clear" );
    var_0 = getent( "player_under_logging_road_end_log", "targetname" );

    for (;;)
    {
        while ( !level.player istouching( var_0 ) )
            waitframe();

        while ( level.player istouching( var_0 ) )
        {
            if ( common_scripts\utility::flag( "flag_logging_road_loud_combat" ) )
            {
                wait(randomfloatrange( 1, 2.5 ));
                thread kill_player_under_log_test();
            }

            waitframe();
        }
    }
}

kill_player_under_log_test()
{
    level notify( "kill_player_under_log_test" );
    level endon( "kill_player_under_log_test" );
    level.player endon( "death" );
    level endon( "flag_seeker_clear" );

    for (;;)
    {
        if ( level.burke getclosestenemysqdist( level.player.origin ) < 1048576 )
            break;

        wait 0.1;
    }

    thread kill_player_under_log_execution();
}

kill_player_under_log_execution()
{
    var_0 = common_scripts\utility::array_randomize( common_scripts\utility::getstructarray( "kill_player_under_log_bullet_soruce", "targetname" ) );
    var_1 = var_0[0];

    foreach ( var_3 in var_0 )
    {
        if ( bullettracepassed( var_3.origin, level.player geteye(), 0, level.player ) )
        {
            var_1 = var_3;
            break;
        }
    }

    for (;;)
    {
        magicbullet( "iw5_bal27_sp", var_1.origin, level.player geteye() );
        level.player enabledeathshield( 0 );
        level.player dodamage( level.player.health / 10, var_1.origin );
        wait 0.05;
    }
}

cleanup_ai_logging_road()
{
    common_scripts\utility::array_call( getaiarray( "axis" ), ::delete );
}

combat_post_breach_patrol()
{
    common_scripts\utility::flag_wait( "flag_post_breach_patrol" );
    var_0 = common_scripts\utility::getstruct( "org_post_breach_patrol", "targetname" );
    level.burke thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    level.cormack thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    level.knox thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    level.burke maps\lab_utility::disable_grenades();
    level.cormack maps\lab_utility::disable_grenades();
    level.knox maps\lab_utility::disable_grenades();
    level.burke.ignoreme = 1;
    level.cormack.ignoreme = 1;
    level.knox.ignoreme = 1;
    var_1 = 21.5;
    level.burke maps\_utility::delaythread( var_1, maps\_stealth_utility::disable_stealth_for_ai );
    level.cormack maps\_utility::delaythread( var_1, maps\_stealth_utility::disable_stealth_for_ai );
    level.knox maps\_utility::delaythread( var_1, maps\_stealth_utility::disable_stealth_for_ai );
    level.burke maps\_utility::set_baseaccuracy( 999 );
    level.cormack maps\_utility::set_baseaccuracy( 999 );
    level.knox maps\_utility::set_baseaccuracy( 999 );
    var_2 = maps\_utility::spawn_script_noteworthy( "enemy_post_breach_patrol_01", 1 );
    var_3 = maps\_utility::spawn_script_noteworthy( "enemy_post_breach_patrol_02", 1 );
    var_2 thread se_breach_patrol_guy_01( var_0 );
    var_3 thread se_breach_patrol_guy_02( var_0 );
    var_2.fovcosine = cos( 35 );
    var_3.fovcosine = cos( 35 );
    maps\_utility::delaythread( 3, common_scripts\utility::flag_set, "flag_breach_patrol_01_clear" );
    maps\_utility::delaythread( 14, common_scripts\utility::flag_set, "flag_breach_patrol_02_reached_end" );
    level.burke thread burke_post_breach_move();
    level.cormack thread cormack_post_breach_move();
    level.knox thread knox_post_breach_move( var_2, var_3 );
    var_4 = [ var_2, var_3 ];

    foreach ( var_6 in var_4 )
        var_6 thread patrol_post_breach_think( var_1 );

    common_scripts\utility::flag_wait_all( "flag_breach_patrol_01_dead", "flag_breach_patrol_02_dead" );
    level.burke.ignoreme = 0;
    level.cormack.ignoreme = 0;
    level.knox.ignoreme = 0;
    level.burke maps\lab_utility::enable_grenades();
    level.cormack maps\lab_utility::enable_grenades();
    level.knox maps\lab_utility::enable_grenades();
    level.burke maps\_utility::set_baseaccuracy( 0.2 );
    level.cormack maps\_utility::set_baseaccuracy( 0.2 );
    level.knox maps\_utility::set_baseaccuracy( 0.2 );
    level.burke maps\_utility::enable_ai_color_dontmove();
    level.cormack maps\_utility::enable_ai_color_dontmove();
    level.knox maps\_utility::enable_ai_color_dontmove();

    if ( !common_scripts\utility::flag( "flag_obj_bio_weapons_04" ) )
        maps\_utility::activate_trigger_with_targetname( "trig_color_facility_clear" );
}

se_breach_patrol_guy_01( var_0 )
{
    self endon( "death" );
    self endon( "damage" );
    self.animname = "guy_1";
    self.allowdeath = 1;
    var_0 maps\_anim::anim_single_solo( self, "se_breach_patrol_guy_01" );
}

se_breach_patrol_guy_02( var_0 )
{
    self endon( "death" );
    self endon( "damage" );
    self.animname = "guy_2";
    self.allowdeath = 1;
    var_0 maps\_anim::anim_single_solo( self, "se_breach_patrol_guy_02" );
}

patrol_post_breach_think( var_0 )
{
    self endon( "death" );
    maps\lab_utility::disable_grenades();
    thread force_alert_patrol( var_0 );
    common_scripts\utility::waittill_any_ents( self, "damage", self, "patrol_alerted", self, "_stealth_spotted", self, "stealth_event", self, "weapon_fired" );
    maps\_utility::ent_flag_clear( "_stealth_enabled" );
    level notify( "patrol_alerted" );
    common_scripts\utility::flag_set( "_stealth_spotted" );
    common_scripts\utility::flag_set( "flag_post_breach_patrol_alerted" );
}

force_alert_patrol( var_0 )
{
    level endon( "patrol_alerted" );
    self.dontattackme = undefined;
    self.dontevershoot = undefined;
    level thread maps\_utility::notify_delay( "patrol_alerted", var_0 );
    maps\_utility::delaythread( var_0, common_scripts\utility::flag_set, "_stealth_spotted" );
    maps\_utility::delaythread( var_0, common_scripts\utility::flag_set, "flag_post_breach_patrol_alerted" );
}

knox_move_to_breach_door()
{
    wait 10;
    var_0 = getnode( "node_knox_breach_door", "targetname" );
    level.knox thread maps\lab_utility::goto_node( var_0, 0 );
}

burke_post_breach_move()
{
    level.burke endon( "anim_reach_server_room_started" );
    thread cloak_off_server_room( 2 );
    var_0 = getnode( "node_burke_breach_02", "targetname" );
    var_1 = getnode( "node_burke_breach_03", "targetname" );
    common_scripts\utility::flag_wait( "breach_done" );
    maps\_utility::delaythread( 2, maps\lab_utility::cloak_on );
    common_scripts\utility::flag_wait( "flag_breach_patrol_01_clear" );
    maps\lab_utility::goto_node( var_1, 0 );
}

cormack_post_breach_move()
{
    level.cormack endon( "anim_reach_server_room_started" );
    thread cloak_off_server_room( 1.75 );
    var_0 = getnode( "node_cormack_breach_02", "targetname" );
    var_1 = getnode( "node_knox_breach_02", "targetname" );
    common_scripts\utility::flag_wait( "lab_breach_all_guys_dead" );
    maps\_utility::delaythread( 3.75, maps\lab_utility::cloak_on );
    common_scripts\utility::flag_wait_all( "flag_breach_patrol_01_clear", "flag_burke_exit_breach_room" );
    maps\lab_utility::goto_node( var_0, 0 );
    common_scripts\utility::flag_wait_any( "flag_breach_patrol_01_dead", "flag_breach_patrol_02_dead", "flag_breach_patrol_02_reached_end" );
    maps\lab_utility::goto_node( var_1, 0 );
}

knox_post_breach_move( var_0, var_1 )
{
    level.knox endon( "anim_reach_server_room_started" );
    thread cloak_off_server_room( 1.5, 0.2 );
    var_2 = getnode( "node_knox_breach_02", "targetname" );
    var_3 = getnode( "node_knox_breach_03", "targetname" );
    var_4 = getnode( "node_knox_breach_04", "targetname" );
    common_scripts\utility::flag_wait( "lab_breach_all_guys_dead" );
    maps\_utility::set_baseaccuracy( 999 );
    maps\lab_utility::any_enemy_is_able_to_attack();
    maps\_utility::delaythread( 3, maps\lab_utility::cloak_on );
    common_scripts\utility::flag_wait_all( "flag_breach_patrol_01_clear", "flag_burke_exit_breach_room" );
    maps\lab_utility::goto_node( var_2, 0 );
    common_scripts\utility::flag_wait_any( "flag_breach_patrol_01_dead", "flag_breach_patrol_02_dead", "flag_breach_patrol_02_reached_end" );
    maps\lab_utility::goto_node( var_3, 0 );

    if ( common_scripts\utility::flag( "flag_breach_patrol_01_dead" ) && common_scripts\utility::flag( "flag_breach_patrol_02_reached_end" ) )
    {

    }
    else if ( common_scripts\utility::flag( "flag_breach_patrol_01_dead" ) && !common_scripts\utility::flag( "flag_breach_patrol_02_reached_end" ) )
        maps\lab_utility::goto_node( var_4, 0 );

    common_scripts\utility::flag_wait_all( "flag_breach_patrol_01_dead", "flag_breach_patrol_02_dead" );
    maps\lab_utility::goto_node( var_4, 0 );
}

cloak_off_server_room( var_0, var_1 )
{
    common_scripts\utility::flag_wait_all( "flag_breach_patrol_01_dead", "flag_breach_patrol_02_dead" );
    wait(var_0);
    maps\lab_utility::cloak_off();
    maps\_utility::enable_cqbwalk();

    if ( isdefined( var_1 ) )
        maps\_utility::set_baseaccuracy( var_1 );
}

combat_research_building()
{
    common_scripts\utility::flag_wait( "flag_research_facility_combat_dialogue_complete" );
    var_0 = getentarray( "enemy_research_building_wave_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    var_0 = getentarray( "enemy_research_wave_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    maps\lab_utility::spawn_metrics_waittill_count_reaches( 4, [ "enemy_research_building_wave_01", "enemy_research_wave_01" ], 0 );
    var_0 = getentarray( "enemy_research_building_wave_02", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );
}

combat_research_building_bridge()
{
    common_scripts\utility::flag_wait( "flag_combat_research_02" );
    var_0 = getentarray( "enemy_research_bridge_wave_01", "script_noteworthy" );

    if ( var_0.size > 0 && !common_scripts\utility::flag( "flag_obj_neutralize_bio_weapons_complete" ) )
        maps\_spawner::flood_spawner_scripted( var_0 );

    common_scripts\utility::flag_wait( "flag_combat_research_bridge_01" );
    var_0 = getentarray( "enemy_research_bridge_wave_02", "script_noteworthy" );

    if ( var_0.size > 0 && !common_scripts\utility::flag( "flag_obj_neutralize_bio_weapons_complete" ) )
        maps\_spawner::flood_spawner_scripted( var_0 );

    maps\lab_utility::spawn_metrics_waittill_count_reaches( 1, [ "enemy_research_bridge_wave_01", "enemy_research_bridge_wave_02" ], 0 );
    var_0 = [ "enemy_research_bridge_wave_01", "enemy_research_bridge_wave_02" ];
    maps\lab_utility::delete_spawners( var_0 );
    maps\_utility::activate_trigger_with_targetname( "trig_color_research_facility_bridge" );
    common_scripts\utility::flag_set( "flag_combat_facility_bridge_seek_player" );
}

combat_research_pool_walkway_01()
{
    common_scripts\utility::flag_wait( "flag_combat_research_03" );
    var_0 = getentarray( "enemy_pool_building_walkway_wave_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    maps\lab_utility::spawn_metrics_waittill_count_reaches( 3, [ "enemy_pool_building_walkway_wave_01" ], 0 );
    var_0 = getentarray( "enemy_pool_building_walkway_wave_02", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    maps\lab_utility::spawn_metrics_waittill_count_reaches( 2, [ "enemy_pool_building_walkway_wave_01", "enemy_pool_building_walkway_wave_02" ], 0 );
    var_0 = [ "enemy_pool_building_walkway_wave_01", "enemy_pool_building_walkway_wave_02" ];
    maps\lab_utility::delete_spawners( var_0 );
    common_scripts\utility::flag_set( "flag_guys_pool_bldg_01_seek_player" );
}

combat_research_left_01()
{
    level endon( "flag_combat_research_right_01" );
    common_scripts\utility::flag_wait( "flag_combat_research_left_01" );
    var_0 = getentarray( "enemy_research_left_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    var_0 = getentarray( "enemy_research_left_lower_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    maps\lab_utility::spawn_metrics_waittill_count_reaches( 3, [ "enemy_research_left_01", "enemy_research_left_lower_01" ], 0 );
    common_scripts\utility::flag_set( "flag_guys_research_left_01_seek_player" );
}

combat_research_right_01()
{
    level endon( "flag_combat_research_left_01" );
    common_scripts\utility::flag_wait( "flag_combat_research_right_01" );
    var_0 = getentarray( "enemy_research_right_flank_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    var_0 = getentarray( "enemy_research_right_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    var_0 = getentarray( "enemy_research_right_lower_01", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );

    thread combat_spawn_research_right_flank_02();
    maps\lab_utility::spawn_metrics_waittill_count_reaches( 3, [ "enemy_research_right_01", "enemy_research_right_lower_01" ], 0 );
    common_scripts\utility::flag_set( "flag_guys_research_right_01_seek_player" );
}

combat_spawn_research_right_flank_02()
{
    common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_right_flank_01_dead" );
    var_0 = getentarray( "enemy_research_right_flank_02", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 maps\_utility::spawn_ai( 1 );
}

combat_research_platform_01()
{
    common_scripts\utility::flag_wait_any( "flag_guys_research_right_01_seek_player", "flag_guys_research_left_01_seek_player" );
    var_0 = getentarray( "enemy_platform_01", "script_noteworthy" );

    if ( !common_scripts\utility::flag( "flag_combat_research_05" ) )
    {
        foreach ( var_2 in var_0 )
            var_2 maps\_utility::spawn_ai( 1 );
    }
}

combat_research_pool_room()
{
    common_scripts\utility::flag_set( "flag_bomb_plant_trigger_on" );
    thread control_foam_room_door02_clip();
    thread foam_planted_kill_enemies();
    common_scripts\utility::flag_wait( "flag_combat_research_03" );
    var_0 = [ "enemy_research_building_wave_01" ];
    maps\lab_utility::delete_spawners( var_0 );
    common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_combat_research_04_bottom" );
    var_0 = [ "enemy_pool_building_wave_01" ];
    maps\lab_utility::delete_spawners( var_0 );
    var_0 = getentarray( "enemy_pool_building_wave_02", "script_noteworthy" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    thread maps\_utility::autosave_by_name( "pool_room" );
    common_scripts\utility::flag_wait( "flag_combat_research_05" );
    soundscripts\_snd::snd_message( "aud_foam_room_emitters" );
    var_0 = [ "enemy_pool_building_wave_02" ];
    maps\lab_utility::delete_spawners( var_0 );
    var_1 = [ "enemy_research_building_wave_01", "enemy_research_building_wave_02", "enemy_pool_building_wave_01", "enemy_pool_building_wave_02" ];
    maps\lab_utility::spawn_metrics_waittill_count_reaches( 5, [ "enemy_research_building_wave_01", "enemy_research_building_wave_02", "enemy_pool_building_wave_01", "enemy_pool_building_wave_02" ], 0 );
    common_scripts\utility::flag_set( "flag_combat_research_retreat_foam_room" );
    maps\_utility::activate_trigger_with_targetname( "trig_color_foam_room_combat" );
    maps\lab_utility::spawn_metrics_waittill_count_reaches( 3, [ "enemy_research_building_wave_01", "enemy_research_building_wave_02", "enemy_pool_building_wave_01", "enemy_pool_building_wave_02" ], 0 );
    common_scripts\utility::flag_set( "flag_foam_room_combat_clear_out" );
    maps\lab_utility::spawn_metrics_waittill_count_reaches( 0, [ "enemy_research_building_wave_01", "enemy_research_building_wave_02", "enemy_pool_building_wave_01", "enemy_pool_building_wave_02" ], 0 );
    common_scripts\utility::flag_set( "flag_research_building_combat_complete" );
    common_scripts\utility::flag_clear( "flag_enable_battle_chatter" );
    soundscripts\_snd::snd_message( "research_building_combat_complete" );
    var_2 = getaiarray( "axis" );

    foreach ( var_4 in var_2 )
    {
        var_5 = randomfloatrange( 0.5, 2.0 );
        var_4 thread maps\lab_utility::bloody_death( var_5 );
        wait 0.3;
    }

    common_scripts\utility::flag_wait_all( "flag_research_building_combat_complete", "flag_player_inside_foam_room" );
    level.burke.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.knox.ignoreall = 1;
    var_7 = getentarray( "c_trigger_researh", "script_noteworthy" );

    foreach ( var_9 in var_7 )
        var_9 common_scripts\utility::trigger_off();
}

foam_planted_kill_enemies()
{
    common_scripts\utility::flag_wait( "flag_obj_neutralize_bio_weapons_planted" );
    var_0 = getaiarray( "axis" );

    foreach ( var_2 in var_0 )
    {
        var_3 = randomfloatrange( 0.5, 1.0 );
        var_2 thread maps\lab_utility::bloody_death( var_3 );
    }
}

foam_room_door_think()
{
    var_0 = 0.75;
    var_1 = getent( "door_foam_room_l", "targetname" );
    var_2 = getent( "door_foam_room_r", "targetname" );
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_4 = var_2 common_scripts\utility::get_target_ent();
    var_3 linkto( var_1 );
    var_4 linkto( var_2 );
    var_5 = common_scripts\utility::getstruct( "org_door_foam_room_open_l", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_door_foam_room_open_r", "targetname" );
    var_7 = common_scripts\utility::getstruct( "org_door_foam_room_close_l", "targetname" );
    var_8 = common_scripts\utility::getstruct( "org_door_foam_room_close_r", "targetname" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 connectpaths();
    var_4 connectpaths();
    common_scripts\utility::flag_wait( "flag_combat_research_05" );
    var_1 moveto( var_7.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_8.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 disconnectpaths();
    var_4 disconnectpaths();
    common_scripts\utility::flag_wait( "flag_foam_room_complete_dialogue" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 connectpaths();
    var_4 connectpaths();
}

foam_room_door_01_close()
{
    var_0 = 0.75;
    var_1 = getent( "door_01_foam_room_l", "targetname" );
    var_2 = getent( "door_01_foam_room_r", "targetname" );
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_4 = var_2 common_scripts\utility::get_target_ent();
    var_3 linkto( var_1 );
    var_4 linkto( var_2 );
    var_5 = common_scripts\utility::getstruct( "org_door_01_foam_room_close_l", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_door_01_foam_room_close_r", "targetname" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 disconnectpaths();
    var_4 disconnectpaths();
}

foam_room_door_03_close()
{
    var_0 = 0.75;
    var_1 = getent( "door_03_foam_room_l", "targetname" );
    var_2 = getent( "door_03_foam_room_r", "targetname" );
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_4 = var_2 common_scripts\utility::get_target_ent();
    var_3 linkto( var_1 );
    var_4 linkto( var_2 );
    var_5 = common_scripts\utility::getstruct( "org_door_03_foam_room_close_l", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_door_03_foam_room_close_r", "targetname" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 disconnectpaths();
    var_4 disconnectpaths();
}

foam_room_door_02_close()
{
    var_0 = 0.75;
    var_1 = getent( "door_02_foam_room_l", "targetname" );
    var_2 = getent( "door_02_foam_room_r", "targetname" );
    soundscripts\_snd::snd_message( "foam_room_door_close", var_1, var_2 );
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_4 = var_2 common_scripts\utility::get_target_ent();
    var_3 linkto( var_1 );
    var_4 linkto( var_2 );
    var_5 = common_scripts\utility::getstruct( "org_door_02_foam_room_close_l", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_door_02_foam_room_close_r", "targetname" );
    common_scripts\utility::flag_wait( "flag_combat_research_05" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 disconnectpaths();
    var_4 disconnectpaths();
}

control_foam_room_door02_clip()
{
    var_0 = getent( "foam_room_instant_door02_clip", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    common_scripts\utility::flag_wait( "flag_foam_room_clear" );
    var_0 solid();
}

courtyard_scrambler_rotate()
{
    var_0 = getent( "scrambler_top", "targetname" );
    var_0.point_tag = common_scripts\utility::spawn_tag_origin();
    var_1 = var_0.point_tag;
    var_1 linkto( var_0, "lab_comm_satellite_top_lod0_comb", ( 15, 15, 220 ), ( 0, 0, 0 ), 0 );
    playfxontag( common_scripts\utility::getfx( "light_glow_red_steady" ), var_1, "tag_origin" );

    while ( !common_scripts\utility::flag( "flag_obj_jammer_complete" ) )
    {
        var_0 addyaw( 2.5 );
        wait 0.05;
    }

    var_2 = 2.5;

    for ( var_3 = 0; var_3 < 25; var_3++ )
    {
        var_2 -= 0.1;
        var_0 addyaw( var_2 );
        wait 0.05;
    }
}

platform_door_think()
{
    var_0 = 0.75;
    var_1 = getent( "door_platform_l", "targetname" );
    var_2 = getent( "door_platform_r", "targetname" );
    soundscripts\_snd::snd_message( "door2courtyard_open" );
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_4 = var_2 common_scripts\utility::get_target_ent();
    var_3 linkto( var_1 );
    var_4 linkto( var_2 );
    var_5 = common_scripts\utility::getstruct( "org_door_platform_open_l", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_door_platform_open_r", "targetname" );
    var_7 = common_scripts\utility::getstruct( "org_door_platform_close_l", "targetname" );
    var_8 = common_scripts\utility::getstruct( "org_door_platform_close_r", "targetname" );
    var_1 moveto( var_5.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_6.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 connectpaths();
    var_4 connectpaths();
    common_scripts\utility::flag_wait( "flag_combat_research_05" );
    var_1 moveto( var_7.origin, var_0, 0.25, 0.25 );
    var_2 moveto( var_8.origin, var_0, 0.25, 0.25 );
    wait(var_0);
    var_3 disconnectpaths();
    var_4 disconnectpaths();
}

combat_courtyard_mech()
{
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_block" );
    level.cormack maps\_utility::disable_ai_color();
    level.knox maps\_utility::disable_ai_color();
    var_0 = getnode( "cormack_mech_sneak", "script_noteworthy" );
    var_1 = getnode( "knox_mech_sneak", "script_noteworthy" );
    level.cormack setgoalnode( var_0 );
    level.knox setgoalnode( var_1 );
    level.hangar_mech_01 = getent( "enemy_hangar_mech_01", "targetname" ) maps\_utility::spawn_ai( 1 );
    level.hangar_mech_01 maps\_mech::mech_start_reduced_nonplayer_damage();
    level.hangar_mech_01 maps\_utility::magic_bullet_shield();
    soundscripts\_snd::snd_message( "courtyard_hangar_mech_01_spawned", level.hangar_mech_01 );
    level.knox.ignoreme = 1;
    level.cormack.ignoreme = 1;
    level.burke.ignoreme = 1;
    level.burke.ignoreall = 1;
    level.knox.ignoreall = 1;
    level.cormack.ignoreall = 1;
    level.hangar_mech_01.ignoreall = 1;
    maps\_utility::delaythread( 2, ::courtyard_hangar_door_close );
    level.hangar_mech_01.animname = "mech";
    var_2 = common_scripts\utility::getstruct( "courtyard_mech_reveal", "targetname" );
    var_2 maps\_anim::anim_single_solo( level.hangar_mech_01, "courtyard_mech_intro", undefined, 0.55 );
    level.hangar_mech_01 maps\_utility::stop_magic_bullet_shield();
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_initial", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_hangar_building_01", 128 );
    level notify( "remove_doormen" );
    level.burke.ignoreall = 0;
    level.hangar_mech_01.ignoreall = 0;
    level.hangar_mech_01 setgoalentity( level.player );
    level.hangar_mech_01.favoriteenemy = level.player;
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "mech" );
    level.player setthreatbiasgroup( "player" );
    level.hangar_mech_01 setthreatbiasgroup( "mech" );
    setthreatbias( "player", "mech", 900000 );
    level.hangar_mech_01 maps\_mech::mech_start_rockets();
    level.hangar_mech_01 maps\_mech::mech_start_hunting();
    level.hangar_mech_01 maps\_mech::mech_start_badplace_behavior();
    wait_for_mech_distance();
    level.hangar_mech_01.walkdist = 200;
    level.hangar_mech_01.walkdistfacingmotion = level.hangar_mech_01.walkdist;
    level.knox.ignoreall = 0;
    level.cormack.ignoreall = 0;
    common_scripts\utility::flag_set( "flag_combat_courtyard_jammer" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack" );
}

wait_for_mech_distance()
{
    if ( isdefined( level.hangar_mech_01 ) && isalive( level.hangar_mech_01 ) )
    {
        level.hangar_mech_01 endon( "death" );
        var_0 = getent( "obj_defend_01", "targetname" );
        var_1 = 600;
        var_2 = var_1 * var_1;

        while ( distancesquared( level.hangar_mech_01.origin, var_0.origin ) < var_2 )
            wait 0.1;
    }
}

courtyard_gates_think()
{
    common_scripts\utility::flag_wait( "flag_foam_room_complete_dialogue" );
    var_0 = getentarray( "courtyard_perimeter_gate_instance_02", "script_noteworthy" );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_model" )
        {
            var_1 = var_3;
            break;
        }
    }

    var_5 = getent( var_1.target, "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_1, "opened" );
    var_5 notsolid();
    common_scripts\utility::flag_wait( "flag_combat_courtyard_general_01" );
    var_5 common_scripts\utility::delaycall( 1, ::solid );
    var_1 maps\_anim::anim_single_solo( var_1, "close" );
    var_1 maps\_anim::anim_first_frame_solo( var_1, "closed" );
}

courtyard_rappel_preview()
{
    level.burke.ignoreme = 1;
    level.cormack.ignoreme = 1;
    level.knox.ignoreme = 1;
    level.player.ignoreme = 1;
    var_0 = getentarray( "courtyard_perimeter_gate_instance_01", "script_noteworthy" );
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        if ( var_3.classname == "script_model" )
        {
            var_1 = var_3;
            break;
        }
    }

    var_5 = getent( var_1.target, "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_1, "opened" );
    var_5 notsolid();
    var_5 connectpaths();
    thread courtyard_rappel_preview_guys();
    thread courtyard_rappel_preview_vehicles();
    level waittill( "cliff_rappel_landing" );
    level.player.ignoreme = 0;
    var_1 maps\_anim::anim_single_solo( var_1, "close" );
    var_1 maps\_anim::anim_first_frame_solo( var_1, "closed" );
    wait 3;
    var_5 solid();
    var_5 disconnectpaths();
}

courtyard_rappel_preview_guys()
{
    level endon( "cliff_rappel_landing" );
    var_0 = getent( "enemy_courtyard_rappel_preview_01", "script_noteworthy" );
    var_1 = getent( "enemy_courtyard_rappel_preview_02", "script_noteworthy" );
    var_2 = getent( "enemy_courtyard_rappel_preview_03", "script_noteworthy" );
    var_3 = getent( "enemy_courtyard_rappel_preview_04", "script_noteworthy" );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_rappel_preview_01", ::courtyard_rappel_preview_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_rappel_preview_02", ::courtyard_rappel_preview_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_rappel_preview_03", ::courtyard_rappel_preview_think );
    maps\_utility::array_spawn_function_noteworthy( "enemy_courtyard_rappel_preview_04", ::courtyard_rappel_preview_think );
    wait 21;

    for (;;)
    {
        var_4 = randomintrange( 1, 2 );

        for ( var_5 = 0; var_5 < var_4; var_5++ )
        {
            var_0 maps\_utility::spawn_ai();
            var_1 maps\_utility::spawn_ai();
            var_2 maps\_utility::spawn_ai();
            var_3 maps\_utility::spawn_ai();
            var_0.count++;
            var_1.count++;
            var_2.count++;
            var_3.count++;
            wait(randomfloatrange( 0.8, 1.2 ));
        }

        wait(randomfloatrange( 2.0, 3.0 ));
    }
}

courtyard_rappel_preview_vehicles()
{
    wait 19;
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "courtyard_vrap_preview" );
    var_0 maps\_vehicle::vehicle_lights_on();
    level waittill( "cliff_rappel_landing" );
    var_0 delete();
}

courtyard_rappel_preview_think()
{
    self.goalradius = 8;
    self.ignoreme = 1;
    self waittill( "goal" );
    self delete();
}

courtyard_rpg_drop()
{
    self.dropweapon = 0;
}

combat_courtyard_path_general()
{
    level.courtyard_goal_volume = getent( "courtyard_combat_volume_initial", "script_noteworthy" );
    common_scripts\utility::array_thread( getentarray( "courtyard_goal_volume_trigger", "targetname" ), ::courtyard_goal_volume_trigger_think );
    thread combat_courtyard_path_jammer_building();
    thread combat_courtyard_path_left_00();
    thread combat_courtyard_path_left_01();
    thread combat_courtyard_path_left_02();
    thread combat_courtyard_path_left_03();
    thread combat_courtyard_path_middle_01();
    thread combat_courtyard_path_middle_02();
    thread combat_courtyard_path_middle_03();
    thread combat_courtyard_path_right_01();
    thread combat_courtyard_path_right_02();
    thread combat_courtyard_path_right_03();
    thread courtyard_gates_think();
    thread courtyard_scrambler_rotate();
    soundscripts\_snd::snd_message( "courtyard_start_dish" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_general_01" );
    var_0 = getentarray( "combat_courtyard_general_01", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 maps\_utility::spawn_ai( 1 );
    }

    thread maps\lab_lighting::courtyard_sun_off();
    thread courtyard_traversal_initial();
    thread courtyard_hangar_door_open();
    thread courtyard_hangar_door_hack();
    level.courtyard_vrap04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "courtyard_vrap04" );
    level.courtyard_vrap04 maps\_vehicle::vehicle_lights_on();
    soundscripts\_snd::snd_message( "aud_ctyard_vrap04" );
    wait 1;
    level.courtyard_vrap05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "courtyard_vrap05" );
    level.courtyard_vrap05 maps\_vehicle::vehicle_lights_on();
    soundscripts\_snd::snd_message( "aud_ctyard_vrap05" );
    common_scripts\utility::flag_wait_either( "flag_combat_courtyard_vehicle01_a", "flag_combat_courtyard_vehicle01_b" );
    thread maps\_utility::autosave_by_name( "courtyard_midpoint" );
    thread combat_courtyard_mech();
    var_0 = getentarray( "enemy_hangar_building_01", "script_noteworthy" );
    maps\_utility::array_spawn_function( var_0, ::courtyard_rpg_drop );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    level.courtyard_vrap01 = maps\_vehicle::spawn_vehicle_from_targetname( "courtyard_vrap01" );
    var_4 = undefined;
    var_5 = level.courtyard_vrap01.riders[0];
    var_6 = level.courtyard_vrap01.riders[1];

    if ( common_scripts\utility::flag( "flag_combat_courtyard_vehicle01_a" ) )
        var_4 = getvehiclenode( "courtyard_vehicle01_a", "targetname" );

    if ( common_scripts\utility::flag( "flag_combat_courtyard_vehicle01_b" ) )
        var_4 = getvehiclenode( "courtyard_vehicle01_b", "targetname" );

    level.courtyard_vrap01 thread maps\_vehicle_code::_vehicle_paths( var_4 );
    level.courtyard_vrap01 startpath( var_4 );
    level.courtyard_vrap01 maps\_vehicle::vehicle_lights_on();
    soundscripts\_snd::snd_message( "aud_ctyard_vrap01" );
    level.courtyard_vrap01 waittill( "unloaded" );

    if ( common_scripts\utility::flag( "flag_combat_courtyard_vehicle01_a" ) )
    {
        var_5 setgoalnode( getnode( "vrap01_startingposition0_node_a", "targetname" ) );
        var_6 setgoalnode( getnode( "vrap01_startingposition1_node_a", "targetname" ) );
    }

    if ( common_scripts\utility::flag( "flag_combat_courtyard_vehicle01_b" ) )
    {
        var_5 setgoalnode( getnode( "vrap01_startingposition0_node_b", "targetname" ) );
        var_6 setgoalnode( getnode( "vrap01_startingposition1_node_b", "targetname" ) );
    }

    var_5.fixednode = 1;
    var_6.fixednode = 1;
}

combat_courtyard_path_jammer_building()
{
    common_scripts\utility::flag_wait_either( "flag_combat_courtyard_path_jammer_building_lower", "flag_combat_courtyard_path_jammer_building_upper" );
    var_0 = undefined;

    if ( common_scripts\utility::flag( "flag_combat_courtyard_path_jammer_building_lower" ) )
        var_0 = getentarray( "combat_courtyard_path_jammer_building_lower", "targetname" );
    else if ( common_scripts\utility::flag( "flag_combat_courtyard_path_jammer_building_upper" ) )
        var_0 = getentarray( "combat_courtyard_path_jammer_building_upper", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_left_00()
{
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_left_00" );
    var_0 = getentarray( "combat_courtyard_path_left_00", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_left_01()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_left_01" );
    var_0 = getentarray( "combat_courtyard_path_left_01", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_left_02()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_left_02" );
    var_0 = getentarray( "combat_courtyard_path_left_02", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_left_03()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_left_03" );
    var_0 = getentarray( "combat_courtyard_path_left_03", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_middle_01()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_middle_01" );
    var_0 = getentarray( "combat_courtyard_path_middle_01", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );

    var_1 = getent( "combat_courtyard_path_middle_01_rpg", "targetname" );
    var_1 maps\_utility::add_spawn_function( ::courtyard_rpg_drop );
    var_2 = getent( "combat_courtyard_path_middle_01_ar", "targetname" );
    var_3 = var_1 maps\_utility::spawn_ai();
    var_3.baseaccuracy = 0.2;
    var_4 = var_2 maps\_utility::spawn_ai();
    common_scripts\utility::flag_wait_either( "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ var_3 ], 64 );
    maps\_utility::ai_delete_when_out_of_sight( [ var_4 ], 64 );
}

combat_courtyard_path_middle_02()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_middle_02" );
    var_0 = getentarray( "combat_courtyard_path_middle_02", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_middle_03()
{
    level endon( "flag_combat_courtyard_path_right_01" );
    level endon( "flag_combat_courtyard_path_right_02" );
    level endon( "flag_combat_courtyard_path_right_03" );
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_middle_03" );
    var_0 = getentarray( "combat_courtyard_path_middle_03", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_right_01()
{
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_right_01" );
    var_0 = getentarray( "combat_courtyard_path_right_01", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_right_02()
{
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_right_02" );
    var_0 = getentarray( "combat_courtyard_path_right_02", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_path_right_03()
{
    level endon( "flag_combat_courtyard_path_left_01" );
    level endon( "flag_combat_courtyard_path_left_02" );
    level endon( "flag_combat_courtyard_path_left_03" );
    level endon( "flag_combat_courtyard_path_middle_01" );
    level endon( "flag_combat_courtyard_path_middle_02" );
    level endon( "flag_combat_courtyard_path_middle_03" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_path_right_03" );
    var_0 = getentarray( "combat_courtyard_path_right_03", "targetname" );

    if ( var_0.size > 0 )
        maps\_utility::array_spawn( var_0 );
}

combat_courtyard_jammer()
{
    level endon( "flag_obj_jammer_interact" );
    common_scripts\utility::flag_wait( "flag_combat_courtyard_jammer" );
    common_scripts\utility::array_thread( getentarray( "courtyard_goal_volume_trigger_b", "targetname" ), ::courtyard_goal_volume_trigger_b_think );
    level.courtyard_vrap02 = maps\_vehicle::spawn_vehicle_from_targetname( "courtyard_vrap02" );
    var_0 = getvehiclenode( "courtyard_vrap02_go", "targetname" );
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_block" );

    if ( isdefined( level.hangar_mech_01 ) )
    {
        level.hangar_mech_01 waittill( "death" );
        common_scripts\utility::flag_set( "flag_hangar_mech_01_dead" );
    }

    level.burke.ignoreme = 0;
    level.cormack.ignoreme = 0;
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_initial", 128 );
    level.courtyard_vrap02 thread maps\_vehicle_code::_vehicle_paths( var_0 );
    level.courtyard_vrap02 startpath( var_0 );
    level.courtyard_vrap02 maps\_vehicle::vehicle_lights_on();
    soundscripts\_snd::snd_message( "aud_ctyard_vrap02" );
    thread combat_courtyard_jammer_ladder_left();
    thread combat_courtyard_jammer_ladder_right();
    var_1 = getentarray( "enemy_courtyard_jammer", "targetname" );
    common_scripts\utility::flag_wait_either( "flag_jammer_combat_ladder_left", "flag_jammer_combat_ladder_right" );
    wait 15;

    if ( var_1.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_1 );
}

combat_courtyard_jammer_ladder_left()
{
    common_scripts\utility::flag_wait( "flag_jammer_combat_ladder_left" );
    var_0 = getentarray( "enemy_courtyard_jammer_ladder_left", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 maps\_utility::spawn_ai( 1 );
    }
}

combat_courtyard_jammer_ladder_right()
{
    common_scripts\utility::flag_wait( "flag_jammer_combat_ladder_right" );
    var_0 = getentarray( "enemy_courtyard_jammer_ladder_right", "targetname" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 maps\_utility::spawn_ai( 1 );
    }
}

combat_courtyard_jammer_complete()
{
    common_scripts\utility::flag_wait( "flag_combat_courtyard_jammer_complete" );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_jammer", 128 );
    wait 2.0;
    var_0 = getentarray( "enemy_courtyard_sniper_fodder", "script_noteworthy" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
            var_2 maps\_utility::spawn_ai( 1 );
    }

    thread courtyard_enemy_sniper_fodder_count();
    level.player.ignoreme = 1;
    maps\_utility::wait_for_notify_or_timeout( "flag_courtyard_sniper_sequence_complete", 28 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_sniper_fodder", 128 );
    level.player.ignoreme = 0;
    common_scripts\utility::flag_set( "flag_courtyard_sniper_sequence_complete" );
    var_0 = getentarray( "enemy_courtyard_jammer_complete", "targetname" );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    var_0 = getentarray( "enemy_courtyard_jammer_complete_perimeter", "targetname" );
    maps\_utility::array_spawn_function( var_0, ::courtyard_rpg_drop );

    if ( var_0.size > 0 )
        maps\_spawner::flood_spawner_scripted( var_0 );

    wait 5;
    var_4 = getent( "enemy_courtyard_mech_02", "targetname" );

    if ( isdefined( var_4 ) )
        var_4 = getent( "enemy_courtyard_mech_03", "targetname" );

    if ( isdefined( var_4 ) )
        var_4 = getent( "enemy_courtyard_mech_04", "targetname" );

    if ( isdefined( var_4 ) )
        var_4 maps\_utility::spawn_ai( 1 );
}

cleanup_courtyard_enemies()
{
    common_scripts\utility::flag_wait( "flag_obj_tank_02" );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_initial", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_hangar_building_01", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_jammer", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_jammer_complete", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_jammer_complete_perimeter", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_flood", 128 );
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_courtyard_sniper_fodder", 128 );

    if ( isdefined( level.hangar_mech_01 ) )
        level.hangar_mech_01 delete();

    if ( isdefined( level.courtyard_mech_01 ) )
        level.courtyard_mech_01 delete();

    if ( isdefined( level.courtyard_mech_02 ) )
        level.courtyard_mech_02 delete();

    if ( isdefined( level.courtyard_mech_03 ) )
        level.courtyard_mech_03 delete();

    if ( isdefined( level.courtyard_mech_04 ) )
        level.courtyard_mech_04 delete();

    if ( isdefined( level.courtyard_vrap01 ) )
        level.courtyard_vrap01 delete();

    if ( isdefined( level.courtyard_vrap02 ) )
        level.courtyard_vrap02 delete();

    if ( isdefined( level.courtyard_vrap03 ) )
        level.courtyard_vrap03 delete();

    if ( isdefined( level.courtyard_vrap04 ) )
        level.courtyard_vrap04 delete();

    if ( isdefined( level.courtyard_vrap05 ) )
        level.courtyard_vrap05 delete();

    maps\_utility::delaythread( 0.05, maps\_utility::array_delete, getentarray( "script_vehicle_cover_drone", "classname" ) );
}

vrap_sonic_blast_immunity_toggle()
{
    self endon( "death" );
    wait 0.5;

    if ( isdefined( self.riders ) )
    {
        var_0 = self.riders;

        foreach ( var_2 in var_0 )
        {
            if ( isalive( var_2 ) && isai( var_2 ) )
                var_2.ignoresonicaoe = 1;
        }

        wait 0.5;

        while ( self.riders.size > 0 )
            waitframe();

        foreach ( var_2 in var_0 )
            var_2.ignoresonicaoe = 0;
    }
}

cleanup_foam_corridor_enemies()
{
    maps\lab_utility::cleanup_ai_with_script_noteworthy( "enemy_foam_corridor_b", 128 );
}

skip_foam_corridor()
{
    common_scripts\utility::flag_wait( "flag_combat_foam_corridor" );
    thread tank_hangar_door_open();
    level.burke maps\_utility::disable_ai_color();
    level.knox maps\_utility::disable_ai_color();
    level.cormack maps\_utility::disable_ai_color();
    var_0 = common_scripts\utility::getstruct( "foam_corridor_anim_node", "targetname" );
    var_1 = "foam_corridor_exit";
    var_2 = [];
    var_2[var_2.size] = level.burke;
    var_2[var_2.size] = level.knox;
    var_2[var_2.size] = level.cormack;
    var_3 = common_scripts\utility::getstruct( "hovertank_reveal_org", "targetname" );
    var_4 = maps\_utility::spawn_anim_model( "hovertank", level.hovertank.origin );
    level.hovertank hide();
    thread se_hovertank_reveal_actor( var_4, var_3 );

    foreach ( var_6 in var_2 )
        thread se_hovertank_reveal_actor( var_6, var_3 );

    common_scripts\utility::flag_set( "flag_foam_corridor_exit" );
}

combat_foam_corridor()
{
    common_scripts\utility::flag_wait( "flag_combat_foam_corridor" );
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "foam_corridor_axis" );
    level.player setthreatbiasgroup( "player" );
    var_0 = getentarray( "enemy_foam_corridor_b", "script_noteworthy" );

    if ( var_0.size > 0 )
    {
        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 maps\_utility::spawn_ai( 1 );
            var_3.grenadeawareness = 0;
        }
    }

    thread se_foam_corridor();
}

foam_corridor_enemy_think()
{
    self endon( "death" );
    self setthreatbiasgroup( "foam_corridor_axis" );
    maps\_utility::magic_bullet_shield( 1 );

    while ( !common_scripts\utility::flag( "flag_foam_corridor_exit" ) )
    {
        common_scripts\utility::flag_wait( "flag_player_inside_foam_corridor" );
        setthreatbias( "foam_corridor_axis", "player", 9999999 );
        self.baseaccuracy = 999999;
        common_scripts\utility::flag_waitopen( "flag_player_inside_foam_corridor" );
        setthreatbias( "foam_corridor_axis", "player", 1 );
        self.baseaccuracy = 1.0;
    }

    maps\_utility::set_battlechatter( 0 );
}

combat_tank_courtyard()
{
    common_scripts\utility::flag_wait( "player_in_hovertank" );
    common_scripts\utility::array_thread( getentarray( "gate_1_react_guys", "targetname" ), ::combat_tank_courtyard_gate_1_guys_think );
    maps\_utility::array_spawn_targetname( "tank_courtyard_guys_1", 1 );
    common_scripts\utility::flag_wait( "flag_courtyard_gate_01_explode" );
    var_0 = maps\_utility::array_spawn_targetname( "courtyard_tank_vrap_1", 1 );
    thread maps\lab_aud::aud_tank_section_vehicles_spawned( var_0 );
    common_scripts\utility::flag_wait( "flag_courtyard_gate_02_explode" );
}

combat_tank_courtyard_gate_1_guys_think()
{
    var_0 = common_scripts\utility::getstruct( self.target, "targetname" );
    var_1 = maps\_utility::spawn_ai( 1 );
    var_1.ignoreall = 1;
    var_2 = common_scripts\utility::getstruct( "courtyard_tank_flee_point", "targetname" );
    var_1.animname = "generic";
    var_1.goalradius = var_2.radius;
    var_1 setgoalpos( var_2.origin );
    var_3 = var_0.animation;
    var_4 = 0;
    var_5 = 0;

    if ( isdefined( var_0.script_parameters ) )
    {
        if ( var_0.script_parameters == "scripted_death" )
            var_5 = 1;
        else
            var_4 = float( var_0.script_parameters );
    }

    var_0 thread maps\_anim::anim_generic_run( var_1, var_3 );
    var_6 = getanimlength( var_1 maps\_utility::getanim( var_3 ) );

    if ( var_4 > 0 )
    {
        wait 0.05;
        var_7 = ( var_6 - var_4 ) / var_6;
        var_1 setanimtime( var_1 maps\_utility::getanim( var_3 ), var_7 );
    }

    if ( var_5 )
    {
        wait(var_6 - 0.3);
        var_1 startragdoll();
        maps\lab_anim::ai_kill( var_1 );
    }
    else if ( isdefined( var_1 ) && isalive( var_1 ) )
    {
        var_1.goalradius = var_2.radius;
        var_1 setgoalpos( var_2.origin );
        thread maps\_utility::ai_delete_when_out_of_sight( [ var_1 ], 5000 );
    }
}

combat_tank_field_flee_guys_think()
{
    self endon( "death" );
    self.ignoreall = 1;
    var_0 = common_scripts\utility::getstruct( "tank_field_flee_point", "targetname" );

    if ( isdefined( self.ridingvehicle ) )
        self waittill( "jumpedout" );

    self.goalradius = 256;
    self setgoalpos( var_0.origin );
    thread maps\_utility::ai_delete_when_out_of_sight( [ self ], 512 );
}

combat_tank_road()
{

}

setup_clip()
{
    var_0 = getent( "blocker_vrap_takedown_door", "targetname" );
    var_0.origin -= ( 0, 0, 10000 );
    var_0 connectpaths();
    thread takedown_trunk();
    thread foam_room_door_think();
    thread platform_door_think();
}

takedown_trunk()
{
    var_0 = getent( "takedown_stump", "targetname" );
    var_1 = getent( "takedown_stump_damaged", "targetname" );
    var_1 hide();

    if ( common_scripts\utility::flag( "flag_se_takedown_01_complete" ) )
    {
        var_0 hide();
        var_1 show();
    }
}

tank_hangar_door_open()
{
    var_0 = getent( "tank_hangar_door_l", "targetname" );
    var_1 = getent( "tank_hangar_door_r", "targetname" );
    var_2 = var_0 common_scripts\utility::get_target_ent();
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = common_scripts\utility::getstruct( "tank_hanger_door_l_opened", "targetname" );
    var_5 = common_scripts\utility::getstruct( "tank_hanger_door_r_opened", "targetname" );
    var_6 = 0.75;
    var_0 moveto( var_4.origin, var_6, 0.25, 0.25 );
    var_1 moveto( var_5.origin, var_6, 0.25, 0.25 );
    wait(var_6);
    var_2 connectpaths();
    var_3 connectpaths();
}

tank_hangar_door_close()
{
    var_0 = getent( "tank_hangar_door_l", "targetname" );
    var_1 = getent( "tank_hangar_door_r", "targetname" );
    var_2 = var_0 common_scripts\utility::get_target_ent();
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = common_scripts\utility::getstruct( "tank_hanger_door_l_opened", "targetname" );
    var_5 = common_scripts\utility::getstruct( "tank_hanger_door_r_opened", "targetname" );
    var_6 = common_scripts\utility::getstruct( "tank_hanger_door_closed", "targetname" );
    var_7 = 0.75;
    var_0 moveto( var_6.origin, var_7, 0.25, 0.25 );
    var_1 moveto( var_6.origin, var_7, 0.25, 0.25 );
    wait(var_7);
    var_2 disconnectpaths();
    var_3 disconnectpaths();
}

helo_sniper_bullet_impacts()
{
    while ( !common_scripts\utility::flag( "flag_player_enters_forest" ) )
    {
        var_0 = 3;
        var_1 = 6;

        if ( common_scripts\utility::flag( "flag_increase_sinper_shots_01" ) )
        {
            var_0 = 2;
            var_1 = 4;
        }

        if ( common_scripts\utility::flag( "flag_hill_slide_complete" ) )
        {
            var_0 = 1;
            var_1 = 3;
        }

        wait(randomfloatrange( var_0, var_1 ));
        var_2 = vectornormalize( anglestoforward( level.player.angles ) );
        var_3 = vectornormalize( anglestoright( level.player.angles ) );
        var_4 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_2 *= randomintrange( 128, 512 );
        var_3 *= randomintrange( -96, 96 );
        var_5 = randomint( 360 );
        var_4.angles = ( 0, var_5, 0 );
        var_6 = get_helo_spotlight_bullet_origin();
        var_7 = 0;
        var_8 = level.player.origin + var_2 + var_3;
        var_9 = randomintrange( 64, 256 );
        var_10 = randomintrange( 1, 2 );
        var_11 = var_8 + vectornormalize( anglestoforward( var_4.angles ) ) * var_9;
        var_12 = var_11 - var_8;
        var_13 = var_10 * 0.05;

        while ( var_7 < var_13 )
        {
            var_14 = randomfloat( 1 );

            if ( var_14 < 0.8 )
            {
                var_4.origin = var_8 + var_12 * var_7 / var_13;
                var_15 = randomintrange( -40, 40 );
                var_16 = randomintrange( -40, 40 );
                var_17 = randomintrange( -5, 5 );
                var_4.origin += ( var_15, var_16, var_17 );

                if ( !maps\_utility::shot_endangers_any_player( var_6, var_4.origin ) )
                    helo_spotlight_shoot_location( var_4.origin );
            }

            var_7 += 0.05;
            wait 0.05;
        }

        var_4 delete();
    }
}

helo_sniper_threaten_player()
{
    level notify( "player_run_progress_trigger_hit" );
    level endon( "player_run_progress_trigger_hit" );
    var_0 = randomfloatrange( 5.0, 8.0 );
    var_1 = 2;
    var_2 = 4;
    wait(var_0);

    while ( !common_scripts\utility::flag( "flag_player_enters_forest" ) )
    {
        helo_spotlight_shoot_location( level.player geteye() + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( -10, 10 ) ) );
        wait(randomfloatrange( var_1, var_2 ));
    }
}

player_run_progress_trigger_think()
{
    level endon( "flag_player_enters_forest" );
    self waittill( "trigger" );
    helo_sniper_threaten_player();
}

get_helo_spotlight_bullet_origin( var_0 )
{
    if ( !isdefined( var_0 ) )
        return level.helo_spotlight gettagorigin( "tag_guy1" ) + ( 0, 0, 28 );
    else
    {
        var_1 = 88;
        var_2 = level.helo_spotlight gettagorigin( "tag_deathfx" );
        var_2 += vectornormalize( var_0 - var_2 ) * var_1;
        return var_2;
    }
}

river_slow_movement_ai_think()
{
    level endon( "player_climbing_wall" );

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_player_in_river" );

        if ( isplayer( self ) )
        {
            self setmovespeedscale( 0.4 );
            self allowjump( 0 );
            self takeweapon( "iw5_unarmed_nullattach" );
            self giveweapon( "s1_unarmed_water" );
            self switchtoweapon( "s1_unarmed_water" );
            self allowcrouch( 0 );
            self allowprone( 0 );

            if ( !isdefined( level.rumble_ent ) )
                level.rumble_ent = maps\_utility::get_rumble_ent( "steady_rumble" );

            level.rumble_ent.intensity = 0.08;
        }

        common_scripts\utility::flag_waitopen( "flag_player_in_river" );

        if ( isplayer( self ) )
        {
            self setmovespeedscale( 0.8 );
            self allowjump( 1 );
            self takeweapon( "s1_unarmed_water" );
            self giveweapon( "iw5_unarmed_nullattach" );
            self switchtoweapon( "iw5_unarmed_nullattach" );
            self allowsprint( 1 );
            self allowcrouch( 1 );
            self allowprone( 1 );

            if ( isdefined( level.rumble_ent ) )
            {
                level.rumble_ent delete();
                level.rumble_ent = undefined;
                stopallrumbles();
            }
        }
    }
}

lerp_move_speed_scale( var_0, var_1, var_2 )
{
    self notify( "lerp_move_speed_scale" );
    self endon( "lerp_move_speed_scale" );
    var_3 = gettime() * 0.001;

    for (;;)
    {
        var_4 = gettime() * 0.001 - var_3;

        if ( var_4 >= var_2 )
            break;

        self setmovespeedscale( maps\_utility::linear_interpolate( var_4 / var_2, var_0, var_1 ) );
        waitframe();
    }

    self setmovespeedscale( var_1 );
}

open_hangar_doors()
{
    common_scripts\utility::flag_wait( "player_in_hovertank" );
    var_0 = getent( "tank_hangar_garage_door_clip", "targetname" );
    var_0 delete();
    var_1 = getent( "tank_hangar_garage_door", "targetname" );
    var_1.animname = "tank_hangar_garage_door";
    var_1 maps\_utility::assign_animtree();
    var_1 maps\_anim::anim_single_solo( var_1, "lab_tank_hanger_door_open" );
}

courtyard_gate_think( var_0 )
{
    var_1 = getentarray( "courtyard_perimeter_gate_instance_0" + var_0, "script_noteworthy" );
    var_2 = undefined;

    foreach ( var_4 in var_1 )
    {
        if ( var_4.classname == "script_model" )
        {
            var_2 = var_4;
            break;
        }
    }

    var_6 = spawnstruct();
    var_6.origin = var_2.origin;

    if ( isdefined( var_2.angles ) )
        var_6.angles = var_2.angles;

    var_2.animname = "perimeter_gate";
    var_2 maps\_utility::assign_animtree();
    var_7 = getent( var_2.target, "targetname" );
    var_8 = getent( var_7.target, "targetname" );
    var_7 disconnectpaths();
    var_8 connectpaths();
    var_8 notsolid();
    common_scripts\utility::flag_wait( "player_in_hovertank" );
    var_2 maps\_anim::anim_first_frame_solo( var_2, "opened" );
    var_8 disconnectpaths();
    var_8 solid();
    var_7 connectpaths();
    var_7 delete();
    maps\_utility::deletestruct_ref( var_6 );
}

courtyard_gate_take_damage( var_0 )
{
    common_scripts\utility::flag_wait( "player_in_hovertank" );
    var_1 = "flag_courtyard_gate_0" + var_0 + "_explode";
    level endon( var_1 );
    self setcandamage( 1 );
    var_2 = 500;
    var_3 = 1000;
    self.health = var_2 + var_3;

    for (;;)
    {
        self waittill( "damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 );

        if ( var_5 != level.player )
        {
            self.health += var_4;
            continue;
        }

        if ( self.health <= var_3 )
            common_scripts\utility::flag_set( var_1 );
    }
}

setup_triggers()
{
    var_0 = getentarray( "trigs_tank_combat", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_off();

    common_scripts\utility::flag_wait( "flag_obj_tank_complete" );

    foreach ( var_2 in var_0 )
        var_2 common_scripts\utility::trigger_on();
}

research_building_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_research_01", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_combat_research_02" );
    self cleargoalvolume();
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_01", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_combat_research_03" );

    while ( !common_scripts\utility::flag( "flag_player_inside_foam_room" ) )
    {
        common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_combat_research_04_bottom" );

        if ( common_scripts\utility::flag( "flag_combat_research_04" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_03", "targetname" ) );
        }
        else if ( common_scripts\utility::flag( "flag_combat_research_04_bottom" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_bottom", "targetname" ) );
        }

        waitframe();
    }

    self cleargoalvolume();
    maps\_utility::player_seek();
}

facility_bridge_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_facility_bridge_01", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_combat_facility_bridge_seek_player" );
    self cleargoalvolume();
    maps\_utility::player_seek();
}

pool_building_walkway_01_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_walkway_02", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_guys_pool_bldg_01_seek_player" );
    self cleargoalvolume();
    maps\_utility::player_seek();
}

research_right_01_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_walkway_03", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_guys_research_right_01_seek_player" );
    self cleargoalvolume();
    maps\_utility::player_seek();
}

research_left_01_enemy_think()
{
    self endon( "death" );

    if ( randomint( 2 ) == 0 )
        self setgoalvolumeauto( getent( "info_v_combat_pool_room_walkway_04", "targetname" ) );
    else
        self setgoalvolumeauto( getent( "info_v_combat_pool_room_walkway_05", "targetname" ) );

    common_scripts\utility::flag_wait( "flag_guys_research_left_01_seek_player" );
    self cleargoalvolume();
    maps\_utility::player_seek();
}

research_left_lower_01_enemy_think()
{
    self endon( "death" );
    self cleargoalvolume();
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_platform", "targetname" ) );

    while ( !common_scripts\utility::flag( "flag_player_inside_foam_room" ) )
    {
        common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_combat_research_04_bottom" );

        if ( common_scripts\utility::flag( "flag_combat_research_04" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_03", "targetname" ) );
        }
        else if ( common_scripts\utility::flag( "flag_combat_research_04_bottom" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_bottom", "targetname" ) );
        }

        waitframe();
    }

    self cleargoalvolume();
    maps\_utility::player_seek();
}

research_right_lower_01_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_bottom_03", "targetname" ) );

    while ( !common_scripts\utility::flag( "flag_player_inside_foam_room" ) )
    {
        common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_combat_research_04_bottom" );

        if ( common_scripts\utility::flag( "flag_combat_research_04" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_03", "targetname" ) );
        }
        else if ( common_scripts\utility::flag( "flag_combat_research_04_bottom" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_bottom", "targetname" ) );
        }

        waitframe();
    }

    self cleargoalvolume();
    maps\_utility::player_seek();
}

research_platform_enemy_think()
{
    self endon( "death" );
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_platform", "targetname" ) );
    common_scripts\utility::flag_wait( "flag_combat_research_05" );
    common_scripts\utility::flag_wait( "flag_foam_room_combat_clear_out" );
    self cleargoalvolume();
    maps\_utility::player_seek();
}

pool_building_enemy_think()
{
    self endon( "death" );
    self cleargoalvolume();
    self setgoalvolumeauto( getent( "info_v_combat_pool_room_03", "targetname" ) );

    while ( !common_scripts\utility::flag( "flag_player_inside_foam_room" ) )
    {
        common_scripts\utility::flag_wait_any( "flag_combat_research_04", "flag_combat_research_04_bottom" );

        if ( common_scripts\utility::flag( "flag_combat_research_04" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_03", "targetname" ) );
        }
        else if ( common_scripts\utility::flag( "flag_combat_research_04_bottom" ) )
        {
            self cleargoalvolume();
            self setgoalvolumeauto( getent( "info_v_combat_pool_room_bottom", "targetname" ) );
        }

        waitframe();
    }

    self cleargoalvolume();
    maps\_utility::player_seek();
}

courtyard_goal_volume_trigger_think()
{
    var_0 = common_scripts\utility::get_target_ent();
    level endon( "flag_obj_courtyard_jammer_start" );

    for (;;)
    {
        self waittill( "trigger" );

        if ( var_0 != level.courtyard_goal_volume )
        {
            level.courtyard_goal_volume = var_0;
            level notify( "courtyard_enemy_update_goal" );
        }

        wait 0.5;
    }
}

courtyard_goal_volume_trigger_b_think()
{
    var_0 = common_scripts\utility::get_target_ent();
    level endon( "flag_obj_tank_02" );

    for (;;)
    {
        self waittill( "trigger" );

        if ( var_0 != level.courtyard_goal_volume )
        {
            level.courtyard_goal_volume = var_0;
            level notify( "courtyard_enemy_update_goal" );
        }

        wait 0.5;
    }
}

combat_courtyard_general_01_think()
{
    self endon( "death" );
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_01", "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 512 );
}

combat_courtyard_path_left_00_think()
{
    self endon( "death" );
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_middle_02", "flag_combat_courtyard_path_right_01" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_left_01_think()
{
    self endon( "death" );
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_middle_01", "flag_combat_courtyard_path_middle_02", "flag_combat_courtyard_path_right_01", "flag_combat_courtyard_path_right_01" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_left_02_think()
{
    self endon( "death" );
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_middle_02", "flag_combat_courtyard_path_middle_03", "flag_combat_courtyard_path_right_02", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_left_03_think()
{
    self endon( "death" );
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_middle_03", "flag_combat_courtyard_path_right_03" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_middle_01_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_01", "flag_combat_courtyard_path_right_01", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_middle_02_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_01", "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_right_01", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_middle_03_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_left_03", "flag_combat_courtyard_path_right_02", "flag_combat_courtyard_path_right_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_right_01_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_00", "flag_combat_courtyard_path_left_01", "flag_combat_courtyard_path_middle_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_right_02_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_01", "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_middle_02", "flag_combat_courtyard_path_middle_03" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

combat_courtyard_path_right_03_think()
{
    self endon( "death" );
    maps\lab_utility::equip_microwave_grenade();
    common_scripts\utility::flag_wait_any( "flag_combat_courtyard_path_left_02", "flag_combat_courtyard_path_left_03", "flag_combat_courtyard_path_middle_02", "flag_combat_courtyard_path_middle_02" );
    maps\_utility::ai_delete_when_out_of_sight( [ self ], 640 );
}

courtyard_enemy_initial_think()
{
    self endon( "death" );
    self.fixednode = 1;
    wait(randomfloatrange( 30.0, 40.0 ));
    self.fixednode = 0;

    while ( !isdefined( level.courtyard_goal_volume ) )
        wait 1;

    for (;;)
    {
        level waittill( "courtyard_enemy_update_goal" );
        self setgoalvolumeauto( level.courtyard_goal_volume );
        wait 1;
    }
}

courtyard_enemy_think()
{
    self endon( "death" );

    while ( !isdefined( level.courtyard_goal_volume ) )
        wait 1;

    for (;;)
    {
        level waittill( "courtyard_enemy_update_goal" );
        self setgoalvolumeauto( level.courtyard_goal_volume );
        wait 1;
    }
}

courtyard_jammer_ladder_enemy_think()
{
    self endon( "death" );
    wait(randomfloatrange( 20.0, 25.0 ));

    while ( !isdefined( level.courtyard_goal_volume ) )
        wait 1;

    for (;;)
    {
        level waittill( "courtyard_enemy_update_goal" );
        self setgoalvolumeauto( level.courtyard_goal_volume );
        wait 1;
    }
}

courtyard_enemy_sniper_fodder_think()
{
    self endon( "death" );
    maps\_utility::add_damage_function( ::courtyard_enemy_sniper_fodder_damage_function );
    thread courtyard_enemy_sniper_fodder_track();
    self.fixednode = 1;
    common_scripts\utility::flag_wait( "flag_courtyard_sniper_sequence_complete" );
    maps\_utility::remove_damage_function( ::courtyard_enemy_sniper_fodder_damage_function );
    self.fixednode = 0;

    while ( !isdefined( level.courtyard_goal_volume ) )
        wait 1;

    for (;;)
    {
        level waittill( "courtyard_enemy_update_goal" );
        self setgoalvolumeauto( level.courtyard_goal_volume );
        wait 1;
    }
}

courtyard_enemy_sniper_fodder_track()
{
    level endon( "flag_courtyard_sniper_sequence_complete" );
    self waittill( "death", var_0 );

    if ( var_0 == level.player )
        level notify( "courtyard_enemy_sniped" );
}

courtyard_enemy_sniper_fodder_count()
{
    level endon( "flag_courtyard_sniper_sequence_complete" );
    level waittill( "courtyard_enemy_sniped" );
    level waittill( "courtyard_enemy_sniped" );
    level waittill( "courtyard_enemy_sniped" );
    level waittill( "courtyard_enemy_sniped" );
    common_scripts\utility::flag_set( "flag_courtyard_sniper_sequence_complete" );
}

courtyard_enemy_sniper_fodder_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_1 == level.burke || var_1 == level.cormack )
    {
        if ( self.health > 0 )
            self.health += var_0;
    }
}

courtyard_doormen_enemy_think()
{
    self endon( "death" );
    level waittill( "remove_doormen" );
    self delete();
}

courtyard_burke_defend_squad()
{
    var_0 = getnode( "burke_defend_exterior", "script_noteworthy" );
    level.burke maps\_utility::disable_ai_color();
    level.burke.ignoreme = 1;
    level.burke.ignoreall = 1;
    level.burke.ignoresuppression = 1;
    level.burke.goalradius = 32;
    level.burke setgoalnode( var_0 );
    level.burke waittill( "goal" );
    level.burke.ignoreme = 0;
    level.burke.ignoreall = 0;
    level.burke.ignoresuppression = 0;
}

courtyard_hangar_door_hack()
{
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_hack" );
    maps\lab_utility::disable_all_fixed_scanners();
    var_0 = getent( "bad_place_courtyard_stairs", "targetname" );
    badplace_brush( "courtyard_stairs", -1, var_0, "axis" );
    var_1 = getnode( "burke_escort_exterior", "script_noteworthy" );
    var_2 = getnode( "cormack_defend_exterior", "script_noteworthy" );
    level.knox.ignoreme = 1;
    thread se_knox_courtyard_hangar_door_hack_open();
    level.burke setgoalnode( var_1 );
    level.cormack setgoalnode( var_2 );
    thread courtyard_traversal_jammer();
    var_3 = getent( "bad_place_courtyard_roof", "targetname" );
    badplace_brush( "courtyard_roof", -1, var_3, "axis" );
    common_scripts\utility::flag_wait( "flag_obj_jammer_complete" );
    soundscripts\_snd::snd_message( "aud_post_courtyard_emitters" );
    thread courtyard_traversal_hangar();
    common_scripts\utility::flag_wait( "flag_courtyard_sniper_sequence_complete" );
    badplace_delete( "courtyard_roof" );
    thread courtyard_burke_defend_squad();
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack_success" );
    thread courtyard_hangar_door_open();
    var_4 = getent( "trig_dmg_player_hangar", "targetname" );
    var_4 common_scripts\utility::trigger_off();
    thread courtyard_burke_enter_hangar_logic();
    thread courtyard_cormack_enter_hangar_logic();
    level.knox.ignoreme = 0;
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_backward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward02", "script_noteworthy" ), common_scripts\utility::trigger_off );
    var_5 = getnode( "knox_defend_interior_02", "script_noteworthy" );
    var_6 = getnode( "cormack_defend_interior_02", "script_noteworthy" );
    var_7 = getnode( "knox_hack_interior", "script_noteworthy" );
    level.burke.goalradius = 32;
    level.cormack.goalradius = 32;
    level.knox.goalradius = 32;
    level.burke setgoalnode( var_5 );
    level.cormack setgoalnode( var_6 );
    level.knox setgoalnode( var_7 );
    level.burke.ignoreall = 1;
    level.burke.ignoresuppression = 1;
    level.cormack.ignoreall = 1;
    level.cormack.ignoresuppression = 1;
    level.burke maps\_utility::enable_ai_color_dontmove();
    level.cormack maps\_utility::enable_ai_color_dontmove();
    level.knox maps\_utility::enable_ai_color_dontmove();
    common_scripts\utility::flag_wait( "flag_obj_tank_02" );
    badplace_delete( "courtyard_stairs" );
}

courtyard_hangar_door_logic()
{
    var_0 = getent( "hangar_interior_volume", "targetname" );

    while ( !common_scripts\utility::flag( "hangar_door_closing" ) )
    {
        common_scripts\utility::flag_wait( "flag_player_inside_hangar" );

        if ( level.burke istouching( var_0 ) && level.knox istouching( var_0 ) && level.cormack istouching( var_0 ) )
        {
            var_1 = getent( "bad_place_courtyard_exit_platform", "targetname" );
            badplace_brush( "courtyard_exit_platform", -1, var_1, "allies" );
            common_scripts\utility::flag_set( "hangar_door_closing" );
            var_2 = common_scripts\utility::getstruct( "knox_courtyard_hangar_door_hack_close_org", "targetname" );
            var_2.origin = level.knox.origin;
            var_2.angles = level.knox.angles;
            common_scripts\utility::flag_set( "flag_obj_tank_02" );
            thread courtyard_hangar_door_close();
            var_3 = common_scripts\utility::getstruct( "org_courtyard_rpg_02", "targetname" );
            var_4 = undefined;

            switch ( randomintrange( 0, 3 ) )
            {
                case 0:
                    var_4 = common_scripts\utility::getstruct( "dest_courtyard_rpg_02_a", "targetname" );
                    break;
                case 1:
                    var_4 = common_scripts\utility::getstruct( "dest_courtyard_rpg_02_b", "targetname" );
                    break;
                case 2:
                    var_4 = common_scripts\utility::getstruct( "dest_courtyard_rpg_02_c", "targetname" );
                    break;
            }

            var_5 = magicbullet( "rpg_straight", var_3.origin, var_4.origin );
            var_6 = 0.6;
            var_5 soundscripts\_snd::snd_message( "courtyard_hangar_door_close_rpg", var_4.origin, var_6 );
            wait(var_6);
            var_7 = distance( level.player.origin, var_4.origin );

            if ( var_7 < 200 )
                thread maps\lab_utility::rumble_heavy_1();
            else if ( var_7 < 500 )
                thread maps\lab_utility::rumble_heavy();

            var_5 delete();
            badplace_delete( "courtyard_exit_platform" );
            var_8 = getent( "courtyard_hangar_door_l", "targetname" );
            var_8 playsound( "detpack_explo_metal" );
            earthquake( 0.5, 0.5, var_8.origin, 3000 );
            level.player playrumbleonentity( "damage_heavy" );
            continue;
        }

        wait 0.1;
    }

    var_9 = getent( "courtyard_door_clip", "targetname" );
    var_9 solid();
    var_9 disconnectpaths();
    thread maps\_utility::autosave_by_name( "courtyard_exited" );
}

courtyard_glowing_ladders()
{
    common_scripts\utility::flag_wait( "flag_obj_courtyard_jammer_start" );
    var_0 = getent( "jammer_ladder_interior", "targetname" );
    var_1 = getent( "jammer_ladder_exterior", "targetname" );
    var_0 setmodel( "safety_ladder_196_obj" );
    var_1 setmodel( "safety_ladder_196_obj" );
    common_scripts\utility::flag_wait_either( "flag_courtyard_ladder_touching", "flag_obj_jammer_complete" );
    var_0 setmodel( "safety_ladder_196" );
    var_1 setmodel( "safety_ladder_196" );
}

courtyard_jammer_scene()
{
    common_scripts\utility::flag_wait( "flag_obj_courtyard_jammer_start" );
    thread courtyard_glowing_ladders();
    common_scripts\utility::flag_set( "aud_start_jammer" );
    var_0 = common_scripts\utility::getstruct( "org_jammer_1", "targetname" );
    var_1 = "jammerplant_1";
    var_2 = maps\_utility::spawn_anim_model( "jammer" );
    var_0 thread maps\_anim::anim_single_solo( var_2, var_1 );
    maps\_utility::delaythread( 0.05, maps\_anim::anim_set_time, [ var_2 ], var_1, 1.0 );
    maps\_anim::anim_set_rate_single( var_2, var_1, 0 );
    var_2 setmodel( "vm_jamming_device_obj" );
    common_scripts\utility::flag_wait( "flag_obj_jammer_interact" );
    common_scripts\utility::flag_set( "flag_combat_courtyard_jammer_complete" );
    thread maps\lab_lighting::courtyard_jammer_plant_dof();
    soundscripts\_snd::snd_message( "courtyard_end_jammer" );
    level.player enableinvulnerability();
    var_3 = maps\_utility::spawn_anim_model( "player_rig_intro" );
    var_3 hide();
    maps\_utility::delaythread( 1.15, ::player_jammer_movie );
    var_0 maps\_anim::anim_first_frame_solo( var_3, var_1 );
    level.player maps\_shg_utility::setup_player_for_scene( 1 );
    maps\_player_exo::player_exo_deactivate();
    var_2 common_scripts\utility::delaycall( 0.9, ::delete );
    var_4 = maps\_utility::spawn_anim_model( "jammer" );
    var_5 = [ var_3, var_4 ];
    level.player playerlinktoblend( var_3, "tag_player", 0.4 );
    var_4 setmodel( "vm_jamming_device" );
    wait 0.5;
    var_3 show();
    thread courtyard_jammer_rumbles();
    var_0 maps\_anim::anim_single( var_5, var_1 );
    level.player disableinvulnerability();
    level notify( "reset_jammer_plant_dof" );
    level.player maps\_shg_utility::setup_player_for_gameplay();
    maps\_player_exo::player_exo_activate();
    var_3 delete();
    level.player unlink();
    common_scripts\utility::flag_set( "flag_obj_jammer_complete" );
}

courtyard_jammer_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 0.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.2 );
    wait 0.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.2, 0.3 );
    wait 0.5;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.5, 0.2 );
}

player_jammer_movie()
{
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    cinematicingame( "jammer_ui_loop" );
    thread stop_jammer_movie();
}

stop_jammer_movie()
{
    level waittill( "flag_obj_tank_02" );
    stopcinematicingame();
}

courtyard_burke_enter_hangar_logic()
{
    var_0 = getent( "hangar_interior_volume", "targetname" );
    common_scripts\utility::flag_wait( "flag_player_inside_hangar" );
    level.burke.ignoreall = 1;
    level.burke.ignoresuppression = 1;

    while ( !level.burke istouching( var_0 ) )
        wait 0.1;

    level.burke.ignoreall = 0;
    level.burke.ignoresuppression = 0;
}

courtyard_cormack_enter_hangar_logic()
{
    var_0 = getent( "hangar_interior_volume", "targetname" );
    common_scripts\utility::flag_wait( "flag_player_inside_hangar" );
    level.cormack.ignoreall = 1;
    level.cormack.ignoresuppression = 1;

    while ( !level.burke istouching( var_0 ) )
        wait 0.1;

    level.cormack.ignoreall = 0;
    level.cormack.ignoresuppression = 0;
}

courtyard_hangar_door_open()
{
    var_0 = getent( "courtyard_hangar_door_l", "targetname" );
    var_1 = getent( "courtyard_hangar_door_r", "targetname" );
    var_2 = var_0 common_scripts\utility::get_target_ent();
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = common_scripts\utility::getstruct( "courtyard_hanger_door_l_opened", "targetname" );
    var_5 = common_scripts\utility::getstruct( "courtyard_hanger_door_r_opened", "targetname" );
    var_6 = 0.75;
    var_0 moveto( var_4.origin, var_6, 0.25, 0.25 );
    var_1 moveto( var_5.origin, var_6, 0.25, 0.25 );
    wait(var_6);
    var_2 connectpaths();
    var_3 connectpaths();
}

courtyard_hangar_door_close()
{
    soundscripts\_snd::snd_message( "aud_courtyard_hangar_door_close" );
    var_0 = getent( "courtyard_hangar_door_l", "targetname" );
    var_1 = getent( "courtyard_hangar_door_r", "targetname" );
    var_2 = var_0 common_scripts\utility::get_target_ent();
    var_3 = var_1 common_scripts\utility::get_target_ent();
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = common_scripts\utility::getstruct( "courtyard_hanger_door_closed", "targetname" );
    var_5 = 0.5;
    var_0 moveto( var_4.origin, var_5, 0.25, 0.25 );
    var_1 moveto( var_4.origin, var_5, 0.25, 0.25 );
    wait(var_5);
    var_2 disconnectpaths();
    var_3 disconnectpaths();
}

courtyard_intro_magic_bullets()
{
    var_0 = common_scripts\utility::getstruct( "org_courtyard_magicbullet_01", "targetname" );
    var_1 = common_scripts\utility::getstruct( "org_courtyard_magicbullet_02", "targetname" );
    var_2 = common_scripts\utility::getstruct( "org_courtyard_magicbullet_03", "targetname" );
    var_3 = common_scripts\utility::getstruct( "dest_courtyard_magicbullet_01", "targetname" );
    var_4 = common_scripts\utility::getstruct( "dest_courtyard_magicbullet_02", "targetname" );
    var_5 = common_scripts\utility::getstruct( "dest_courtyard_magicbullet_03", "targetname" );
    common_scripts\utility::flag_wait( "courtyard_intro_magic_bullets" );
    magicbullet( "iw5_bal27_sp", var_0.origin, var_3.origin );
    wait 0.2;

    for ( var_6 = 0; var_6 < 5; var_6++ )
    {
        magicbullet( "iw5_bal27_sp", var_1.origin, var_4.origin );
        wait 0.1;
    }

    wait 0.2;

    for ( var_6 = 0; var_6 < 4; var_6++ )
    {
        magicbullet( "iw5_bal27_sp", var_2.origin, var_5.origin );
        wait 0.1;
    }
}

courtyard_traversal_initial()
{
    var_0 = getent( "courtyard_door_clip", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward01", "script_noteworthy" ), common_scripts\utility::trigger_on );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_backward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward02", "script_noteworthy" ), common_scripts\utility::trigger_off );
}

courtyard_traversal_jammer()
{
    var_0 = getent( "courtyard_door_clip", "targetname" );
    var_0 solid();
    var_0 disconnectpaths();
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_backward01", "script_noteworthy" ), common_scripts\utility::trigger_on );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward02", "script_noteworthy" ), common_scripts\utility::trigger_off );
}

courtyard_traversal_hangar()
{
    var_0 = getent( "courtyard_door_clip", "targetname" );
    var_0 notsolid();
    var_0 connectpaths();
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_backward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward02", "script_noteworthy" ), common_scripts\utility::trigger_on );
}

courtyard_traversal_tank()
{
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_backward01", "script_noteworthy" ), common_scripts\utility::trigger_off );
    common_scripts\utility::array_thread( getentarray( "courtyard_traversal_forward02", "script_noteworthy" ), common_scripts\utility::trigger_off );
}

se_hovertank_reveal()
{
    var_0 = common_scripts\utility::getstruct( "hovertank_reveal_org", "targetname" );
    common_scripts\utility::flag_wait( "flag_foam_corridor_exit" );

    for ( var_1 = 1; var_1 <= 4; var_1++ )
        getent( "lab_tank_lift_0" + var_1, "script_noteworthy" ) thread se_hovertank_reveal_lift_think( var_1 );

    common_scripts\utility::flag_set( "flag_obj_tank_04" );
    common_scripts\utility::flag_wait( "flag_hovertank_reveal_scene" );
    common_scripts\utility::flag_set( "flag_obj_tank_05" );
    common_scripts\utility::flag_wait( "flag_hovertank_reveal_scene_started" );
    maps\_utility::autosave_by_name();
    common_scripts\utility::flag_set( "flag_tank_hangar_reveal_dialogue" );
    soundscripts\_snd::snd_message( "hover_tank_startup_sequence" );
    thread maps\lab_lighting::stair_wait();
    maps\_utility::delaythread( 37, ::allow_player_hovertank_mount, var_0 );
}

se_hovertank_reveal_actor( var_0, var_1 )
{
    var_2 = "hovertank_reveal_approach";
    var_3 = "hovertank_reveal_loop";
    var_4 = "hovertank_reveal";
    var_5 = "hovertank_reveal_loop_ender";
    var_6 = "hovertank_static_ender";
    var_7 = spawn( "script_origin", var_1.origin );

    if ( isdefined( var_1.angles ) )
        var_7.angles = var_1.angles;

    if ( var_0.animname != "hovertank" )
    {
        if ( var_0 == level.knox )
        {
            level.knox.goalradius = 16;
            level.knox setgoalnode( getnode( "tank_hangar_knox_node", "targetname" ) );
            common_scripts\utility::flag_wait( "flag_move_knox_to_console" );
        }

        var_7 maps\_anim::anim_reach_solo( var_0, var_2 );

        if ( var_0 == level.burke )
            common_scripts\utility::flag_set( "flag_tank_hangar_sweep_dialogue" );

        var_0 common_scripts\utility::delaycall( 0.05, ::setanimrate, var_0 maps\_utility::getanim( var_2 ), 1.05 );
        var_7 maps\_anim::anim_single_solo( var_0, var_2 );
        var_7 thread maps\_anim::anim_loop_solo( var_0, var_3, var_5 );
    }
    else
        var_7 thread maps\_anim::anim_loop_solo( var_0, "hovertank_reveal_static", var_6 );

    var_0.ready_for_reveal = 1;
    common_scripts\utility::flag_wait( "flag_hovertank_reveal_scene" );
    var_8 = 1;

    while ( var_8 )
    {
        var_8 = 0;

        if ( !isdefined( level.burke.ready_for_reveal ) || !isdefined( level.cormack.ready_for_reveal ) )
            var_8 = 1;

        wait 0.05;
    }

    var_7 notify( var_6 );
    common_scripts\utility::flag_set( "flag_hovertank_reveal_scene_started" );

    if ( var_0 != level.knox )
    {
        var_7 notify( var_5 );

        if ( var_0.animname == "hovertank" )
        {
            var_7 thread maps\_anim::anim_single_solo( var_0, var_4 );
            var_0 thread maps\lab_utility::delete_on_notify( level, "hovertank_hide_exterior" );
            common_scripts\utility::waittill_any_ents( var_7, var_4, level, "player_in_hovertank" );

            if ( !common_scripts\utility::flag( "player_in_hovertank" ) )
            {
                if ( isdefined( var_0 ) )
                    var_7 thread maps\_anim::anim_loop_solo( var_0, var_3, var_5 );
            }
        }
        else
        {
            var_0 common_scripts\utility::delaycall( 0.05, ::setanimrate, var_0 maps\_utility::getanim( var_4 ), 1.05 );
            var_7 maps\_anim::anim_single_solo( var_0, var_4 );

            if ( !common_scripts\utility::flag( "player_in_hovertank" ) )
                var_7 thread maps\_anim::anim_loop_solo( var_0, "hovertank_idle", var_5 );
        }
    }

    common_scripts\utility::flag_wait( "player_in_hovertank" );

    if ( isdefined( var_0 ) )
    {
        var_0 maps\_utility::anim_stopanimscripted();
        var_0.ready_for_reveal = undefined;
    }

    var_7 notify( var_5 );
    waitframe();
    var_7 delete();
    maps\_utility::deletestruct_ref( self );
}

se_hovertank_reveal_lift_think( var_0 )
{
    var_1 = "hovertank_reveal";
    self.animname = "htank_reveal_lift_0" + var_0;
    maps\_utility::assign_animtree();
    maps\_anim::anim_first_frame_solo( self, var_1 );
    common_scripts\utility::flag_wait( "flag_hovertank_reveal_scene_started" );
    maps\_anim::anim_single_solo( self, var_1 );
}

allow_player_hovertank_mount( var_0 )
{
    common_scripts\utility::flag_set( "flag_obj_tank_06" );
    var_1 = getent( "hovertank_enter_trigger", "targetname" );
    var_1 waittill( "trigger" );

    if ( !isdefined( var_0 ) )
        var_0 = common_scripts\utility::getstruct( "hovertank_reveal_org", "targetname" );

    thread maps\lab_lighting::tank_board_enter();
    thread maps\lab_lighting::tank_board_enter_top_lights();
    common_scripts\utility::flag_set( "player_entering_hovertank" );
    common_scripts\utility::flag_set( "flag_tank_board_dialogue" );
    var_2 = level.hovertank.angles;
    var_3 = level.hovertank.origin;
    se_hovertank_mount( var_0 );
    level.hovertank vehicle_teleport( var_3, var_2, 0, 0 );
    level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants( 0 );
    level.player thread mount_hovertank( 1 );
    common_scripts\utility::flag_set( "player_in_hovertank" );
    common_scripts\utility::flag_set( "flag_player_in_hovertank_dialogue" );
    soundscripts\_snd::snd_message( "aud_player_gets_in_tank" );
    wait 0.5;
    thread maps\_utility::autosave_by_name( "tank_hangar" );
    thread combat_tank_courtyard();
}

se_hovertank_mount( var_0 )
{
    var_1 = spawn( "script_origin", var_0.origin );

    if ( isdefined( var_0.angles ) )
        var_1.angles = var_0.angles;

    level.player_rig = maps\lab_utility::spawn_player_rig();
    level.player_rig hide();
    level.player_rig dontcastshadows();
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    maps\_player_exo::player_exo_deactivate();
    var_2 = 0.5;
    level.player playerlinktoblend( level.player_rig, "tag_player", var_2 );
    level.player_rig common_scripts\utility::delaycall( var_2, ::show );
    level notify( "msg_vfx_player_in_tank" );
    thread tank_hangar_door_close();
    var_3 = maps\_utility::spawn_anim_model( "hovertank_interior", level.hovertank.origin );
    var_3.angles = level.hovertank.angles;
    var_3 setmaterialscriptparam( 1.0, 0.0 );
    var_3 hidepart( "TAG_SHADOW_HIDE" );
    var_4 = [ level.player_rig, level.hovertank, var_3 ];
    var_5 = "hovertank_enter";
    var_1 thread maps\_anim::anim_single( var_4, var_5 );
    soundscripts\_snd::snd_message( "hovertank_enter" );
    level waittill( "hovertank_enter_start_npcs" );
    var_6 = [ level.burke, level.cormack, level.knox ];
    var_1 thread maps\_anim::anim_single( var_6, var_5 );
    thread maps\lab_lighting::tank_turrent_reflection( var_3, var_6 );
    level waittill( "hovertank_show_interior" );
    maps\_cloak::cloaked_stealth_disable_battery_hud();
    var_3 show();
    level waittill( "hovertank_hide_exterior" );
    level.hovertank hide();
    level.hovertank clearanim( level.scr_anim["hovertank"]["hovertank_enter"], 0.2 );
    var_1 waittill( var_5 );
    var_3 delete();
    level.player unlink();
    level.player_rig delete();
}

mount_hovertank( var_0 )
{
    setup_hovertank_combat();
    level notify( "tank_switch" );
    var_1 = vehicle_scripts\_hovertank::add_hovertank_turret( level.hovertank );
    var_1 hidepart( "TAG_BOOT" );
    thread maps\lab_lighting::hovertank_turrent_light( var_1 );
    thread maps\lab_lighting::hovertank_turrent_reflection( var_1 );
    maps\_player_exo::player_exo_deactivate();
    level.player vehicle_scripts\_hovertank::hovertank_ride( level.hovertank, level.hovertank_turret );
    level.use_hovertank_chromatic_aberration = 1;

    if ( isdefined( var_0 ) && var_0 == 1 )
        level.hovertank_turret thread vehicle_scripts\_hovertank::hoverscreen_reveal( 3.0 );
    else
        level.hovertank_turret thread vehicle_scripts\_hovertank::hoverscreen_reveal( 1.5 );

    level.burke thread ride_hovertank_ai();
    level.cormack thread ride_hovertank_ai();
    level.knox thread ride_hovertank_ai();
    var_1 setmodel( "vehicle_mil_hovertank_simple_vm" );
}

hoverscreen_damage_fx( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.25;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    level.hovertank_turret setmaterialscriptparam( 1.0, 0.1 );
    wait(var_0);
    level.hovertank_turret setmaterialscriptparam( 0.0, 0.1 );
}

hoverscreen_restore( var_0 )
{
    level.hovertank_turret setmaterialscriptparam( 0.0, var_0 );
}

setup_hovertank_combat()
{
    setsaveddvar( "r_hudoutlinewidth", 1 );
    setsaveddvar( "r_hudoutlinepostmode", 2 );
    setsaveddvar( "r_hudoutlinehalolumscale", 0.75 );
    setsaveddvar( "r_hudoutlinehaloblurradius", 0.35 );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::delaythread( 0.05, ::delete_mobile_cover );
    maps\lab_utility::hovertank_setup_hint_data();
    maps\_utility::array_spawn_function_noteworthy( "tank_courtyard_enemy", ::tank_battle_rpg_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_combat_warbird", ::tank_combat_warbird_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_combat_vrap", ::tank_combat_vrap );
    var_0 = getentarray( "vrap_placed", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 thread tank_combat_vrap();

    maps\_utility::array_spawn_function_noteworthy( "tank_combat_littlebird", ::tank_combat_littlebird_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_battle_enemy_tank", ::enemy_tank_ai_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_road_enemy", ::tank_road_enemy_think );
    maps\_utility::add_global_spawn_function( "axis", ::hovertank_combat_global_enemy_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_combat_field_flee_guy", ::combat_tank_field_flee_guys_think );
    common_scripts\utility::array_thread( getentarray( "destructible_trailer_collision", "script_noteworthy" ), maps\lab_utility::destructible_trailer_collision_think );
    common_scripts\utility::array_thread( getentarray( "can_tip", "script_noteworthy" ), maps\lab_utility::can_tip_think );
    common_scripts\utility::array_thread( getentarray( "log_pile_scripted", "script_noteworthy" ), maps\lab_utility::log_pile_scripted_think );
    common_scripts\utility::array_thread( getentarray( "trigger_spawn_and_set_flag", "script_noteworthy" ), maps\lab_utility::trigger_spawn_and_set_flag_think );
    maps\_utility::array_spawn_function_noteworthy( "tank_battle_rpg_enemy", ::tank_battle_rpg_enemy_think );
    level.vehiclespawncallbackthread = ::lab_vehicle_callback;
    thread courtyard_scripted_props_staged_wakeup();
    thread hovertank_combat_road_log_scene();
    thread hovertank_combat_clearing_choppers_1();
    thread hovertank_combat_clearing_choppers_3();
    thread hovertank_ascent_final_enemies();
    thread hovertank_combat_cleanup();
    level.hovertank thread hovertank_monitor_status();
    thread hovertank_checkpoint_logic();
    common_scripts\utility::array_thread( getentarray( "destructible_boxtruck", "script_noteworthy" ), maps\lab_utility::destructible_boxtruck_think );
    level maps\_utility::waittillthread( "hovertank_end", ::cleanup_hovertank_combat );
}

disable_static_mobile_cover()
{
    var_0 = getentarray( "static_mobile_cover", "script_noteworthy" );

    foreach ( var_2 in var_0 )
        var_2 vehicle_scripts\_cover_drone::cover_drone_disable();
}

delete_mobile_cover()
{
    var_0 = getentarray( "script_vehicle_cover_drone", "classname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
            var_2 delete();
    }
}

cleanup_hovertank_combat()
{
    maps\_utility::remove_global_spawn_function( "axis", ::hovertank_combat_global_enemy_think );
}

hovertank_checkpoint_logic()
{
    level.hovertank endon( "hovertank_done" );
    var_0 = 0;

    for (;;)
    {
        if ( issaverecentlyloaded() && !var_0 )
        {
            var_0 = 1;

            if ( common_scripts\utility::flag( "hovertank_clearing_reached" ) )
            {
                if ( level.hovertank vehicle_scripts\_hovertank::get_trophy_ammo() < 60 )
                    level.hovertank vehicle_scripts\_hovertank::set_trophy_ammo( 60 );
            }
            else if ( common_scripts\utility::flag( "hovertank_road_reached" ) )
            {
                if ( level.hovertank vehicle_scripts\_hovertank::get_trophy_ammo() < 80 )
                    level.hovertank vehicle_scripts\_hovertank::set_trophy_ammo( 80 );
            }
            else
            {

            }
        }
        else if ( !issaverecentlyloaded() )
            var_0 = 0;

        wait 0.1;
    }
}

courtyard_scripted_props_staged_wakeup()
{
    var_0 = getentarray( "courtyard_scripted_props", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        var_2 courtyard_scripted_props_think();
        wait 0.05;
    }
}

courtyard_scripted_props_think()
{
    if ( self.classname == "script_brushmodel" )
        self delete();
    else if ( self.classname == "script_model" )
        self physicslaunchclient( self.origin, ( 0, 0, 0 ) );
}

hovertank_combat_global_enemy_think()
{
    maps\_utility::disable_long_death();
    self.dropweapon = 0;
    self.grenadeammo = 0;
    thread maps\lab_utility::hovertank_enemy_outline( 4 );
    thread maps\lab_utility::hovertank_aimed_enemy_ai_weapon_hint( 1, "missile" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );

        if ( isdefined( var_9 ) )
        {
            if ( var_9 == "hovertank_antiair" )
            {
                self.health += var_0;
                continue;
            }

            if ( var_9 == "hovertank_missile_small" )
                self kill( var_3, var_1 );
        }
    }
}

lab_vehicle_callback( var_0 )
{
    if ( issubstr( var_0.classname, "low" ) )
        var_0 maps\_utility::ent_flag_init( "no_riders_until_unload" );
}

hovertank_combat_road_log_scene()
{
    common_scripts\utility::flag_wait( "hovertank_combat_road_log_scene" );
    maps\_utility::delaythread( 5, common_scripts\utility::flag_set, "flag_tank_road_log_enemies_dialogue" );

    if ( !common_scripts\utility::flag( "flag_log_pile_scripted_destroyed" ) )
        maps\_utility::array_spawn_targetname( "tank_road_log_enemy" );
}

hovertank_combat_clearing_choppers_1()
{
    common_scripts\utility::flag_wait( "flag_hovertank_combat_clearing_choppers_1" );
    common_scripts\utility::flag_set( "flag_tank_field_lz_over_ridge_dialogue" );
}

hovertank_combat_clearing_choppers_3()
{
    common_scripts\utility::flag_wait( "flag_hovertank_combat_clearing_choppers_3" );
    common_scripts\utility::flag_set( "flag_tank_clearing_infantry_dialogue" );
}

hovertank_ascent_final_enemies()
{
    common_scripts\utility::flag_wait( "flag_hovertank_ascent_final_enemies" );
    common_scripts\utility::flag_set( "flag_tank_ascent_dialogue" );
}

hovertank_monitor_status()
{
    level endon( "hovertank_end" );
    var_0 = self.trophyammomax;
    self.last_hit_callout_time = gettime();
    var_1 = 100;

    for (;;)
    {
        self waittill( "trophy_deployed", var_2 );

        if ( self.trophyammo / self.trophyammomax < 0.75 && var_1 > 75 )
        {
            level maps\_utility::dialogue_queue( "lab_sir_trophysystemat75" );
            var_1 = 75;
        }
        else if ( self.trophyammo / self.trophyammomax < 0.5 && var_1 > 50 )
        {
            level maps\_utility::dialogue_queue( "lab_sir_trophysystemat50" );
            var_1 = 50;
        }
        else if ( self.trophyammo / self.trophyammomax < 0.25 && var_1 > 25 )
        {
            level maps\_utility::dialogue_queue( "lab_sir_trophysystemat25" );
            var_1 = 25;
        }
        else if ( self.trophyammo / self.trophyammomax <= 0.05 && var_1 > 0.05 )
        {
            level maps\_utility::dialogue_queue( "lab_sir_trophysystemcritical" );
            var_1 = 0.05;
        }

        if ( self.trophyammo / self.trophyammomax < 0.8 && !isdefined( self.trophy80 ) )
        {
            self.trophy80 = 1;
            level.burke maps\_utility::dialogue_queue( "lab_gdn_weregettingbeatenup" );
            continue;
        }

        if ( self.trophyammo / self.trophyammomax < 0.6 && !isdefined( self.trophy60 ) )
        {
            self.trophy60 = 1;
            level.burke maps\_utility::dialogue_queue( "lab_gdn_wecanttakeanotherhit" );
            continue;
        }

        if ( self.trophyammo / self.trophyammomax == 0 && !isdefined( self.health0 ) )
        {
            self.trophy0 = 1;
            level.burke maps\_utility::dialogue_queue( "lab_gdn_ourtrophysystemisempty" );
            return;
        }
        else if ( gettime() - self.last_hit_callout_time > 10000 )
        {
            if ( randomfloat( 1 ) < 0.25 )
            {
                if ( isdefined( var_2 ) )
                {
                    var_3 = vectortoangles( var_2 - level.hovertank.turret.origin );
                    var_4 = vectornormalize( var_2 - level.hovertank.turret.origin );
                    var_5 = anglestoright( level.hovertank.turret gettagangles( "tag_aim_animated" ) );
                    var_6 = vectordot( var_5, var_4 );

                    if ( var_6 > 0.5 )
                    {
                        var_7 = common_scripts\utility::cointoss();

                        if ( var_7 )
                            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_firefromtheright" );
                        else
                            level.cormack maps\lab_vo::important_dialogue_queue( "lab_crk_takingfirefromtheright" );
                    }
                    else if ( var_6 < -0.5 )
                    {
                        var_7 = common_scripts\utility::cointoss();

                        if ( var_7 )
                            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_firefromtheleft" );
                        else
                            level.cormack maps\lab_vo::important_dialogue_queue( "lab_crk_takingfirefromtheleft" );
                    }
                }
            }
        }
    }
}

hovertank_combat_cleanup()
{
    level waittill( "hovertank_end" );
}

ride_hovertank_ai()
{
    self.no_friendly_fire_penalty = 1;
    self forceteleport( level.hovertank.origin, level.hovertank.angles );
    self linkto( level.hovertank );
    self.ignoreall = 1;
    self hideallparts();
    common_scripts\utility::flag_wait( "flag_se_hovertank_exit" );
    self showallparts();
    self.ignoreall = 0;
    self unlink();
    self.no_friendly_fire_penalty = undefined;
}

setup_hovertank()
{
    var_0 = getent( "hovertank", "targetname" );
    level.hovertank = var_0 maps\_utility::spawn_vehicle();
    level.hovertank thread monitor_mobile_turret_health();
    level.hovertank makeunusable();
    level.hovertank.animname = "hovertank";

    if ( isdefined( level.start_point ) )
    {
        switch ( level.start_point )
        {
            case "tank_ascent":
            case "tank_field_right_fork":
            case "tank_field_left_fork":
            case "tank_field":
            case "tank_road":
                level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants( 0 );
                thread mount_hovertank();
                break;
            default:
                level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants( 1 );
                break;
        }
    }
}

tank_combat_vehicle_damage_feedback()
{
    self endon( "death" );
    thread maps\_utility::add_damagefeedback();
    common_scripts\utility::waittill_any( "end_damage_feedback", "hovertank_end" );
    maps\_utility::remove_damagefeedback();
}

tank_combat_vrap()
{
    thread maps\lab_utility::destroy_self_when_nuked();
    thread maps\lab_utility::hovertank_enemy_outline( 4 );
    thread tank_combat_vehicle_damage_feedback();

    if ( !isdefined( self.damage_functions ) )
        self.damage_functions = [];

    maps\_utility::add_damage_function( ::enemy_vrap_damage_function );
    thread tank_combat_vrap_deactivate_on_unload();
    maps\_vehicle::vehicle_set_health( 2000 );
    self waittill( "death", var_0, var_1, var_2 );
    var_3 = maps\lab_utility::hovertank_enemy_outline_offset() + self.origin;
    radiusdamage( var_3, 400, 150, 150, level.player, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( var_3, 400, 150, 2.0, 0 );
}

tank_combat_vrap_deactivate_on_unload()
{
    self endon( "death" );
    self endon( "hovertank_end" );
    self waittill( "unloaded" );
    self notify( "end_damage_feedback" );
    self notify( "end_highlight" );
}

tank_combat_warbird_think()
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    thread tank_combat_vehicle_damage_feedback();
    maps\_utility::add_damage_function( ::tank_combat_warbird_damage_function );
    thread warbird_death_function();
    thread maps\lab_utility::warbird_heavy_shooting_think( 1 );
    thread maps\lab_utility::destroy_self_when_nuked();
    thread maps\lab_utility::hovertank_enemy_outline( 4 );
    thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint( 2, "emp" );
    maps\_vehicle::vehicle_set_health( 1200 );
    self sethoverparams( 360, 50 );

    if ( !isdefined( self.ent_flag["warbird_open_fire"] ) )
        maps\_utility::ent_flag_init( "warbird_open_fire" );

    maps\_utility::ent_flag_wait( "warbird_open_fire" );
    self notify( "warbird_fire" );
    maps\_utility::ent_flag_waitopen( "warbird_open_fire" );
    self notify( "warbird_stop_firing" );
}

tank_combat_warbird_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_1 == level.player && var_4 != "MOD_ENERGY" && var_0 > 499 )
    {
        if ( !isdefined( level.hovertank.choppersniped ) )
        {
            level.burke maps\_utility::delaythread( 0.5, maps\lab_vo::important_dialogue_queue, "lab_gdn_niceshot" );
            level.hovertank.choppersniped = 1;
            self.sniped = 1;
        }
        else if ( randomfloat( 1 ) < 0.5 )
        {
            level.burke maps\_utility::delaythread( 0.5, maps\lab_vo::important_dialogue_queue, "lab_gdn_niceshot" );
            self.sniped = 1;
        }

        self kill( var_3, var_1 );
        wait 0.05;

        if ( isdefined( self ) )
        {
            self notify( "crash_done" );
            self notify( "in_air_explosion" );
        }
    }
    else if ( var_1 == level.player && var_4 == "MOD_ENERGY" )
    {
        self endon( "death" );
        self endon( "emp_death" );
        wait 0.5;

        if ( isdefined( self.emp_crash ) && self.emp_crash == 1 )
            return;

        if ( !isdefined( level.hovertank.empedwarbird ) )
        {
            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_fireagain" );
            level.hovertank.empedwarbird = 1;
        }
        else if ( randomfloat( 1 ) < 0.5 )
        {
            if ( common_scripts\utility::cointoss() )
                level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_hithimagain" );
            else
                level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_fireagain" );
        }
    }
}

warbird_death_function()
{
    level.hovertank endon( "death" );
    self waittill( "death" );

    if ( isdefined( self ) && isdefined( self.sniped ) )
        return;

    wait 0.5;
    check_restricted_airspace_achievement();

    if ( !isdefined( level.hovertank.warbirdkilled ) )
    {
        level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_warbirdsdown" );
        level.hovertank.warbirdkilled = 1;
    }
    else if ( randomfloat( 1 ) < 0.25 )
        level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_warbirdsdown" );
}

check_restricted_airspace_achievement()
{
    if ( !isdefined( level.restricted_airspace ) )
        level.restricted_airspace = 0;

    level.restricted_airspace++;

    if ( level.restricted_airspace >= 10 )
        maps\_utility::giveachievement_wrapper( "LEVEL_10A" );
}

tank_combat_littlebird_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_1 == level.player && var_4 != "MOD_ENERGY" && var_0 > 499 )
    {
        self kill( self.origin, var_1 );
        wait 0.05;

        if ( isdefined( self ) )
        {
            self notify( "crash_done" );
            self notify( "in_air_explosion" );
        }
    }
}

notify_warbird_when_killed( var_0 )
{
    var_0 endon( "death" );
    self waittill( "death" );
    var_0 notify( "rpg_guy_killed" );
}

tank_combat_warbird_kill_is_crew_killed( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "rpg_guy_killed" );

        if ( self.rpg_guys.size < 1 )
            self kill();
    }
}

tank_combat_warbird_orient_to_open_fire()
{
    level.hovertank endon( "death" );

    if ( !isdefined( self.lookatent ) )
    {
        self.lookatent = spawn( "script_origin", self.origin );
        thread common_scripts\utility::delete_on_death( self.lookatent );

        if ( common_scripts\utility::cointoss() )
            self.lookatent.origin = anglestoright( vectortoangles( self.origin - level.hovertank.origin ) ) * 1000 + self.origin;
        else
            self.lookatent.origin = anglestoright( vectortoangles( self.origin - level.hovertank.origin ) ) * -1000 + self.origin;

        self setlookatent( self.lookatent );
        maps\_utility::ent_flag_waitopen( "warbird_open_fire" );
        self.lookatent delete();
    }
}

tank_combat_warbird_liftoff_think()
{
    self endon( "death" );
    self vehicle_setspeed( 15, 60 );
    maps\_utility::ent_flag_init( "warbird_open_fire" );
    thread tank_combat_warbird_think();
    maps\_utility::delaythread( 3, maps\_utility::ent_flag_set, "warbird_open_fire" );
    var_0 = common_scripts\utility::getstruct( "warbird_liftoff_start_node", "targetname" );
    self setlookatent( level.hovertank );
    maps\_utility::vehicle_liftoff( 700 );
    self clearlookatent();
    thread maps\_vehicle::vehicle_paths( var_0 );
}

tank_combat_littlebird_think()
{
    self endon( "death" );
    thread maps\_shg_utility::make_emp_vulnerable();
    thread maps\lab_utility::destroy_self_when_nuked();
    thread maps\lab_utility::hovertank_enemy_outline( 4 );
    thread tank_combat_vehicle_damage_feedback();
    thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint( 2, "emp" );
    maps\_utility::add_damage_function( ::tank_combat_littlebird_damage_function );
    self sethoverparams( 360, 50 );

    if ( !isdefined( self.ent_flag["littlebird_open_fire"] ) )
        maps\_utility::ent_flag_init( "littlebird_open_fire" );

    maps\_utility::ent_flag_wait( "littlebird_open_fire" );

    foreach ( var_1 in self.riders )
    {
        if ( isalive( var_1 ) && isdefined( var_1.script_startingposition ) && var_1.script_startingposition > 1 )
            var_1 thread littlebird_rpg_rider_think( "littlebird_open_fire" );
    }
}

littlebird_rpg_rider_think( var_0 )
{
    self endon( "death" );
    self.ridingvehicle endon( "emp_death" );

    if ( isdefined( var_0 ) )
        self.ridingvehicle endon( var_0 );

    if ( isdefined( level.hovertank ) )
    {
        level.hovertank endon( "death" );
        self setentitytarget( level.hovertank.turret );
    }

    wait(randomfloatrange( 1, 5 ));
    var_1 = 0.4;

    for (;;)
    {
        if ( !isdefined( self.enemy ) || !self.ridingvehicle maps\_utility::ent_flag( "littlebird_open_fire" ) )
        {
            wait 0.5;
            continue;
        }

        if ( !self canshoot( level.player.origin + ( 0, 0, 64 ) ) )
        {
            wait 0.5;
            continue;
        }

        var_2 = vectornormalize( self.enemy.origin - self.origin );
        var_3 = anglestoforward( self.angles );
        var_4 = vectordot( var_3, var_2 );

        if ( var_4 >= var_1 )
        {
            playfxontag( common_scripts\utility::getfx( "rpg_muzzle_flash" ), self, "tag_flash" );
            magicbullet( "rpg_straight", self gettagorigin( "tag_flash" ) + anglestoforward( self gettagangles( "tag_flash" ) ) * 20, self.enemy.origin );
            wait(randomfloatrange( 4, 8 ));
            continue;
        }

        wait(randomfloatrange( 0.5, 1.5 ));
    }
}

tank_battle_rpg_enemy_think()
{
    level endon( "hovertank_end" );
    self endon( "death" );
    level.hovertank endon( "death" );
    self.dropweapon = 0;
    self setentitytarget( level.hovertank );
}

btr_turret_think()
{
    self endon( "death" );
    self endon( "kill_btr_turret_think" );
    thread maps\_vehicle::vehicle_turret_scan_on();

    for (;;)
    {
        wait(randomfloatrange( 0.3, 0.8 ));
        var_0 = btr_get_target();

        if ( isdefined( var_0 ) )
        {
            btr_fire_at_target( var_0 );
            wait 0.3;
        }
    }
}

btr_fire_at_target( var_0 )
{
    var_0 endon( "death" );
    self setturrettargetent( var_0, ( 0, 0, 32 ) );

    if ( common_scripts\utility::cointoss() )
    {
        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_2 in self.mgturret )
            {
                if ( isdefined( var_2 ) )
                {
                    var_2 setturretteam( "axis" );
                    var_2 setmode( "manual" );
                    var_2 settargetentity( var_0 );
                    var_2 startfiring();
                }
            }
        }

        wait(randomfloatrange( 3, 5 ));

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_2 in self.mgturret )
            {
                if ( isdefined( var_2 ) )
                {
                    var_2 cleartargetentity();
                    var_2 stopfiring();
                }
            }
        }
    }
    else
    {
        for ( var_6 = 0; var_6 < randomintrange( 1, 3 ); var_6++ )
        {
            burst_fire_weapon();
            wait 0.5;
        }
    }
}

burst_fire_weapon()
{
    for ( var_0 = 0; var_0 < randomintrange( 2, 4 ); var_0++ )
    {
        self fireweapon();
        wait 0.2;
    }
}

btr_get_target()
{
    var_0 = 4;
    var_1 = getaiarray( "allies" );

    for ( var_2 = 0; var_2 < var_0; var_2++ )
        var_1[var_1.size] = level.player;

    return common_scripts\utility::random( var_1 );
}

enemy_tank_ai_think()
{
    self endon( "death" );
    level.hovertank endon( "death" );
    thread maps\lab_utility::destroy_self_when_nuked();
    thread maps\lab_utility::hovertank_enemy_outline( 4 );
    thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint( 3, "cannon" );
    var_0 = 100;
    var_1 = 40;
    maps\_vehicle::vehicle_set_health( 1000 );
    maps\_utility::add_damage_function( ::enemy_tank_damage_function );
    thread enemy_tank_death_function();

    while ( isdefined( self ) && isalive( self ) )
    {
        if ( sighttracepassed( self.origin + ( 0, 0, 100 ), level.hovertank.origin + ( 0, 0, var_0 ), 0, self, level.hovertank ) )
        {
            self.cur_tank_target = level.hovertank;
            enemy_tank_aim( var_0, 1 );

            if ( isdefined( self.godmode ) && self.godmode == 1 )
                maps\_vehicle::godoff();

            continue;
        }

        wait 0.1;
    }
}

enemy_tank_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self endon( "death" );
    level.hovertank endon( "death" );

    if ( var_1 == level.player && var_0 < 500 )
    {
        self.health = self.currenthealth;

        if ( var_0 < 50 )
        {
            var_10 = 0;

            if ( isdefined( level.emp_vulnerable_list ) )
            {
                foreach ( var_12 in level.emp_vulnerable_list )
                {
                    if ( distance( var_12.origin, self.origin ) < 1024 )
                        var_10 = 1;
                }
            }

            if ( !var_10 )
            {
                if ( !isdefined( level.hovertank.empedtank ) )
                {
                    level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_empsuselessagainstthosetanks" );
                    level.hovertank.empedtank = 1;
                }
            }
        }
    }
    else
    {
        maps\_damagefeedback::damagefeedback_took_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
        wait 0.5;

        if ( !isdefined( level.hovertank.hittankagain ) )
        {
            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_hithimagain" );
            level.hovertank.hittankagain = 1;
        }
        else if ( randomfloat( 1 ) < 0.5 )
        {
            if ( common_scripts\utility::cointoss() )
                level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_hithimagain" );
            else
                level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_fireagain" );
        }
    }
}

enemy_tank_aim( var_0, var_1 )
{
    self endon( "death" );
    level endon( "missionfailed" );
    var_2 = 100;
    var_3 = 100;
    var_4 = 100;
    self setturrettargetent( self.cur_tank_target, ( randomintrange( -1 * var_2, var_2 ), randomintrange( -1 * var_3, var_3 ), randomintrange( -1 * var_4, var_4 ) ) );
    self waittill( "turret_on_target" );
    wait 2;

    if ( sighttracepassed( self.origin + ( 0, 0, 100 ), self.cur_tank_target.origin + ( 0, 0, var_0 ), 0, self, level.hovertank ) )
    {
        if ( var_1 )
        {
            self fireweapon();
            soundscripts\_audio::deprecated_aud_play_sound_at( "ht_exfil_ft101_fire", self.origin );
        }

        wait(randomintrange( 5, 8 ));
    }
    else
        wait 1;
}

enemy_tank_death_function()
{
    level.hovertank endon( "death" );
    self waittill( "death" );
    wait 1;

    if ( !isdefined( level.hovertank.tankkilled ) )
    {
        level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_tanksdown" );
        level.hovertank.tankkilled = 1;
    }
    else
    {
        if ( level.hovertank.tankkilled == 1 )
            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_gothim" );
        else if ( level.hovertank.tankkilled == 2 )
            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_niceshot" );
        else
            level.burke maps\lab_vo::important_dialogue_queue( "lab_gdn_tanksdown" );

        level.hovertank.tankkilled++;

        if ( level.hovertank.tankkilled > 3 )
            level.hovertank.tankkilled = 1;
    }
}

enemy_vrap_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( var_1 == level.player && var_0 >= 500 )
        self kill();
}

tank_road_enemy_think()
{
    self endon( "death" );
    self.ignoreall = 1;
    self waittill( "goal" );
    self.allowdeath = 1;
    maps\_anim::anim_generic_custom_animmode( self, "gravity", "prone_dive" );
    thread maps\_anim::anim_generic_loop( self, "prone_idle", "stop_loop" );
    self allowedstances( "prone" );
    thread maps\_utility::ai_delete_when_out_of_sight( [ self ], 512 );
}

monitor_mobile_turret_health()
{
    level.player endon( "death" );
    var_0 = getent( "trig_hover_tank_immobilize", "targetname" );
    var_0 mobile_turret_health_think( self, ::se_hovertank_exit );
}

hover_tank_immobilize()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "tank_immobilize_littlebird" );
    var_0 maps\_vehicle::godon();
    var_0 hover_tank_immobilize_rockets();
    var_0 maps\_vehicle::godoff();
    playfxontag( common_scripts\utility::getfx( "tank_immobilized" ), level.hovertank.turret, "tag_light_main" );
    level.hovertank_turret notify( "large_hit_react" );
    var_1 = 1;
    var_2 = common_scripts\utility::getstruct( "hovertank_defend_loc", "targetname" );
    level.hovertank vehicle_hovertanksethoverforcescale( 0, 0 );
    var_3 = 0.5;
    maps\_utility::delaythread( var_3, ::hovertank_defend_setup );
    thread vehicle_scripts\_hovertank::hoverscreen_turnoff( var_3 );
    var_4 = maps\_utility::spawn_anim_model( "hovertank_interior", level.hovertank.origin );
    var_4.angles = level.hovertank.turret.angles;
    var_4 linkto( level.hovertank );
    var_5 = [ level.burke, level.knox, level.cormack, var_4 ];
    level.hovertank common_scripts\utility::delaycall( var_3, ::vehicle_teleport, var_2.origin, var_2.angles );
    wait(var_1);
    stopfxontag( common_scripts\utility::getfx( "tank_immobilized" ), level.hovertank.turret, "tag_light_main" );
    var_4 delete();
    thread hoverscreen_restore( 0.5 );
    iprintln( "defend starts" );
    thread hovertank_defend_combat();
    level.hovertank.turret setbottomarc( 25 );
    common_scripts\utility::flag_wait( "hovertank_defend_complete" );
    wait 5;
    se_hovertank_exit();
}

hover_tank_immobilize_rockets()
{
    level.hovertank endon( "damage" );
    level.hovertank endon( "trophy_deployed" );
    var_0 = common_scripts\utility::getstruct( "hovertank_immobilize_rocket_1", "targetname" );
    var_1 = common_scripts\utility::getstruct( "hovertank_immobilize_rocket_2", "targetname" );
    var_2 = magicbullet( "rpg_straight", var_0.origin, level.hovertank.origin + ( 0, 0, 64 ) );
    wait 0.5;
    var_3 = magicbullet( "rpg_straight", var_1.origin, level.hovertank.origin + ( 0, 0, 64 ) );
    var_4 = 0;
    var_5 = "tag_guy1";

    for (;;)
    {
        if ( var_4 )
            var_5 = "tag_guy1";
        else
            var_5 = "tag_guy3";

        var_4 = !var_4;
        var_6 = self gettagorigin( var_5 ) + anglestoup( self.angles ) * 30 + anglestoforward( self.angles ) * 30;
        magicbullet( "rpg_straight", var_6, level.hovertank.origin + ( 0, 0, 64 ) );
        wait(randomfloatrange( 0.25, 0.75 ));
    }
}

hovertank_defend_setup()
{
    foreach ( var_1 in getentarray( "script_vehicle", "code_classname" ) )
    {
        if ( var_1.health < 0 )
            var_1 delete();
    }

    var_3 = [ getvehiclenode( "ascent_tank_1_end_point", "targetname" ), getvehiclenode( "ascent_tank_2_end_point", "targetname" ) ];

    foreach ( var_5 in var_3 )
    {
        var_6 = spawn( "script_model", var_5.origin );

        if ( isdefined( var_5.angles ) )
            var_6.angles = var_5.angles;

        var_6 setmodel( "vehicle_ft101_tank_destroy" );
    }
}

hovertank_defend_combat()
{
    maps\_utility::array_spawn_targetname( "tank_defend_wave_1" );
    maps\_utility::delaythread( 30, maps\_utility::array_spawn_targetname, "tank_defend_wave_2" );
    wait 60;
    common_scripts\utility::flag_set( "hovertank_defend_complete" );
}

se_hovertank_exit()
{
    soundscripts\_snd::snd_message( "tank_disabled" );
    level.hovertank vehicle_hovertanksethoverforcescale( 0, 0 );
    common_scripts\utility::flag_set( "flag_obj_hide_marker_during_tank_exit" );
    level.hovertank.godmode = 1;
    var_0 = 1.5;
    thread vehicle_scripts\_hovertank::hoverscreen_turnoff( var_0, 1.0 );
    wait 1;
    var_1 = getentarray( "script_vehicle_vrap_physics", "classname" );
    var_2 = getentarray( "script_vehicle_littlebird_atlas_bench", "classname" );
    var_3 = getentarray( "script_vehicle_xh9_warbird_low_heavy_turret", "classname" );
    var_4 = getentarray( "script_vehicle_ft101_tank_physics", "classname" );
    var_5 = getent( "vol_exfil_cleanup_check", "targetname" );
    var_6 = common_scripts\utility::getstruct( "org_se_exfil", "targetname" );
    var_7 = common_scripts\utility::array_combine( var_1, var_2 );
    var_7 = common_scripts\utility::array_combine( var_7, var_3 );
    var_7 = common_scripts\utility::array_combine( var_7, var_4 );

    foreach ( var_9 in var_7 )
    {
        if ( distancesquared( var_9.origin, level.player.origin ) < 250000 || distancesquared( var_9.origin, var_6.origin ) < 250000 )
        {
            var_9 delete();
            continue;
        }

        if ( var_9.health > 0 )
            var_9 kill();
    }

    foreach ( var_12 in getaiarray( "axis" ) )
        var_12 kill();

    level.player painvisionoff();
    level.player maps\_utility::ent_flag_clear( "player_has_red_flashing_overlay" );
    level.player.health = level.player.maxhealth;
    level.player maps\_utility::lerpfov_saved( 65, 0.1 );
    thread maps\lab_lighting::tank_exit_dof_reset();
    var_14 = common_scripts\utility::getstruct( "hovertank_exit_org", "targetname" );
    var_15 = spawnstruct();
    var_15.origin = var_14.origin;

    if ( isdefined( var_14.angles ) )
        var_15.angles = var_14.angles;

    level.player_rig = maps\lab_utility::spawn_player_rig( undefined, var_14.origin );
    level.hovertank_exterior_model = maps\_utility::spawn_anim_model( "hovertank", var_14.origin );
    var_16 = maps\_utility::spawn_anim_model( "hovertank_interior", var_14.origin );
    var_16 hidepart( "TAG_AIM_UNHIDE" );
    var_17 = "hovertank_exit";
    var_15 maps\_anim::anim_first_frame_solo( level.player_rig, var_17 );
    var_18 = level.player_rig gettagorigin( "tag_player" );
    var_19 = level.player_rig gettagangles( "tag_player" );
    level.hovertank_turret setturretdismountorg( var_18 );
    var_20 = getent( "tank_exit_viewmodel_origin", "targetname" );
    var_21 = var_20 getorigin();
    level.player_rig overridelightingorigin( var_21 );

    if ( level.nextgen )
        setsaveddvar( "r_subdiv", "1" );

    level.cormack dontcastshadows();
    level.cormack thread se_hovertank_exit_cormack_shadow();
    level.hovertank notify( "hovertank_done" );
    common_scripts\utility::flag_set( "flag_se_hovertank_exit" );
    common_scripts\utility::flag_set( "flag_tank_exit_dialogue" );
    level maps\_utility::delaythread( 9.25, common_scripts\utility::flag_set, "flag_exfil_start_dialogue" );
    soundscripts\_snd::snd_message( "tank_exit" );
    level.player_rig dontcastshadows();
    level.player_rig defaultlightingorigin();
    level.hovertank_exterior_model hide();
    level.hovertank_turret hide();
    level.player maps\_shg_utility::setup_player_for_scene( 0 );
    maps\_player_exo::player_exo_deactivate();
    level.player setorigin( var_18 );
    level.player setangles( var_19 );
    level.player playerlinktoabsolute( level.player_rig, "tag_player" );
    var_22 = [ level.hovertank_exterior_model, var_16, level.burke, level.cormack, level.knox ];
    var_14 thread maps\_anim::anim_single_run( var_22, var_17 );
    var_15 thread maps\_anim::anim_single_solo( level.player_rig, var_17 );
    thread exit_hovertank_rumbles();
    thread se_hovertank_exit_cover_fire();
    level waittill( "hovertank_show_exterior" );

    foreach ( var_9 in var_7 )
    {
        if ( !isdefined( var_9 ) )
            continue;

        if ( distancesquared( var_9.origin, level.player.origin ) < 250000 )
        {
            var_9 delete();
            continue;
        }
    }

    level.hovertank_exterior_model show();
    level waittill( "hovertank_hide_interior" );
    var_16 hide();
    level.player_rig waittillmatch( "single anim", "end" );
    thread se_hovertank_exit_cover_fire_cleanup();
    level.player unlink();
    maps\_player_exo::player_exo_activate();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    common_scripts\utility::flag_set( "flag_exfil_start" );
    level.hovertank delete();
    level.player_rig delete();
    var_16 delete();
    maps\_utility::deletestruct_ref( var_15 );
    maps\_utility::autosave_by_name();
}

exit_hovertank_rumbles()
{
    maps\lab_utility::setup_level_rumble_ent();
    wait 7.25;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.9, 0.2 );
    wait 0.3;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.7, 0.2 );
    wait 0.4;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.9, 0.1 );
    wait 0.2;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.8, 0.1 );
    wait 0.2;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.6, 0.1 );
    wait 0.8;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.4, 0.1 );
    wait 0.2;
    thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.3, 0.3 );
    wait 2;
    maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, 0.7, 1 );
    level notify( "exfil_helo_overhead_rumble_complete" );
}

handle_player_close_to_aircraft_rumbles()
{
    level waittill( "exfil_helo_overhead_rumble_complete" );
    maps\lab_utility::setup_level_rumble_ent();

    for (;;)
    {
        var_0 = distance( level.player.origin, level.razorback.origin );
        var_1 = ( 1000 - var_0 ) / 4000;
        thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time( level.rumble_ent, var_1, 0.2 );
        wait 0.25;
    }
}

se_hovertank_exit_cormack_shadow()
{
    self waittillmatch( "single anim", "start_shadow" );
    self castshadows();
}

mobile_turret_health_think( var_0, var_1 )
{
    level.player endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( var_2 == level.player )
        {
            var_0 thread [[ var_1 ]]();
            break;
        }
    }
}

mobile_turret_burning()
{
    thread destroy_turret_when_player_leaves();
    level.player endon( "death" );
    self endon( "dismount_vehicle_and_turret" );
    self notify( "play_damage_warning" );
}

destroy_turret_when_player_leaves()
{
    level.player endon( "death" );
    self waittill( "player_exited_mobile_turret" );
    destroy_mobile_turret();
}

destroy_mobile_turret()
{
    level.player endon( "death" );
    common_scripts\utility::flag_wait( "flag_burke_destroy_tank" );
    var_0 = 256;
    var_1 = 20;

    while ( distance( self.origin, level.player.origin ) < var_0 && var_1 >= 0 )
    {
        var_1 -= 0.05;
        wait 0.05;
    }

    self.mgturret[0] hide();
    self setmodel( "vehicle_x4walker_wheels_dstrypv" );
    playfxontag( common_scripts\utility::getfx( "mobile_turret_explosion" ), self, "tag_death_fx" );
    earthquake( 1, 1.6, self.origin, 625 );
    soundscripts\_snd::snd_message( "player_mobile_turret_explo" );
    self notify( "stop_mobile_turret_health_1" );
    self notify( "stop_mobile_turret_health_2" );
    self notify( "stop_mobile_turret_health_3" );
    self notify( "stop_mobile_turret_health_4" );
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "mobile_turret_ground_smoke" ), self, "tag_death_fx" );
}

play_and_store_fx_on_tag( var_0, var_1, var_2 )
{
    playfxontag( common_scripts\utility::getfx( var_0 ), var_1.mgturret[0], var_2 );
    var_3 = spawnstruct();
    var_3.name = var_0;
    var_3.tag = var_2;

    if ( !isdefined( var_1.damage_fx ) )
        var_1.damage_fx = [];

    var_1.damage_fx[self.damage_fx.size] = var_3;
}

add_drone_to_squad()
{
    if ( isdefined( self.script_parameters ) && self.script_parameters == "personal_drone" )
    {
        var_0 = getent( "squad_drone_spawner", "targetname" );
        maps\_weapon_pdrone::pdrone_launch( var_0 );

        if ( isdefined( self.pdrone ) )
        {
            self.pdrone.pacifist = 1;
            self.pdrone.ignoreme = 1;
        }
    }
}

cleanup_squad_drone()
{
    if ( level.nextgen )
        level waittill( "street_cleanup" );
    else
        level waittill( "tff_transition_intro_to_middle" );

    self delete();
}

se_hovertank_exit_cover_fire()
{
    var_0 = 0;

    if ( !var_0 )
        level.player common_scripts\utility::delaycall( 1, ::enableinvulnerability );

    var_1 = maps\_utility::getent_or_struct( "checkpoint_exfil_start", "script_noteworthy" );
    level.cover_fire_missile_repulsor = missile_createrepulsororigin( var_1.origin, 10000, 300 );
    thread spawn_exfil_enemies();

    if ( !var_0 )
        wait 6.5;
    else
        wait 0.1;

    thread maps\lab_utility::named_magic_bullet_strafe( "exfil_cover_fire_0", 5, 2, 60, 0.35, "rpg" );
    thread maps\lab_utility::named_magic_bullet_strafe( "exfil_cover_fire_1", 7, 2, 240, 0.35, "rpg" );
}

se_hovertank_exit_cover_fire_cleanup()
{
    level.player disableinvulnerability();
    missile_deleteattractor( level.cover_fire_missile_repulsor );
}

spawn_exfil_enemies()
{
    var_0 = 0;

    if ( !var_0 )
        wait 6.4;

    var_1 = [];
    var_2 = 2;
    var_3 = maps\_utility::getent_or_struct( "exfil_cover_fire_0_source_start", "targetname" );

    for ( var_4 = 0; var_4 < var_2; var_4++ )
    {
        var_1[var_4] = [];
        var_5 = getentarray( "tank_exfil_enemy_" + var_4, "targetname" );

        foreach ( var_7 in var_5 )
            var_1[var_4][var_1[var_4].size] = var_7 maps\_utility::spawn_ai( 1, 0 );

        var_9 = maps\_utility::getent_or_struct( "tank_exfil_target_" + var_4, "targetname" );
        var_10 = var_9.origin;
        var_10 = ( var_10[0], var_10[1], var_10[2] + 240 );
        var_11 = 0.1 + var_4 * 0.25;
        common_scripts\utility::delay_script_call( var_11, ::exfil_enemy_missile, var_3, var_9.origin, var_1[var_4] );
    }
}

exfil_enemy_missile( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_2 )
        var_4.health = 1;

    var_6 = magicbullet( "rpg", var_0.origin, var_1 );
    var_7 = missile_createattractororigin( var_1, 50000, 900, var_6, 1 );
    var_6 waittill( "death" );
    waitframe();

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) && isai( var_4 ) && isalive( var_4 ) )
            var_4 dodamage( var_4.health, var_1 );
    }

    missile_deleteattractor( var_7 );
}
